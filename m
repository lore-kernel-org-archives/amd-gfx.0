Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE92ACCFA13
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Sep 2024 08:40:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8BA5E10EB16;
	Thu, 26 Sep 2024 08:40:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="WqaVjoJH";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2046.outbound.protection.outlook.com [40.107.94.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5AA5F10EB16
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Sep 2024 08:40:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W4pSVmaY2z7dLdjgby/VZUG1ZIM6hJbDWqP9+anAJpqOqTa60fjVJZ5yr+qXf/5IcCcmgtwDYrIdJ+4yo7bhMiV+OYbylh6NxcbzMWuJJkRCUO3Vk8cpquaJBJhTL2S142bkvG3XVXT5IkpIw+aN7viwTbJlQaU5OCbsSFLSeSBgvrgsEj7vort0ymGLUQ9ZTNEgxHpChA3LZVgOdeh8Z7EJchtQI+moTe98HVaSRY70DPy7A5vHxcN/EiURuCEPf4AkIjypNA6XC9MMY4me4kZpY/qmz2iJM+mnXzb5hKJey5GVoplklSXFVc0U4MyvAtPtUsnk/AFXnkE+QBbyug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=agiDtLNRH5vp4cx9xeX6d8pwBb/QnKZI4DQnQuI+9cA=;
 b=V4INUbuLAlmeQgiocpQeTQxSqy8pGkxUcmUzhqlTcMkox874W5IVVWE7VhkYK+9srL4JtnB3vFbnejTHSY3EhnV9xo8te2/IP56dAFOOIbsGR2FmcUEy4wvq7dIKttptkqYKUXrPFkyuu628R6UClmcU0cLmVvI3xyjzRqGWKL7td8wW87ftSCKMFjKz/bHp9p9F9KwRNAs+n8LdUNgw/ooHu5z1BCRQvVTlB5sHFA+e19ebQB6PanXpaqg1L2280hE6FYULsnlMajdg4ZFzh0sYrgUwd6d27x9llCJ19F9gjpGCeTTBbH2FEizpmzCl/W9GxcF50OwpA98nuFbrFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=agiDtLNRH5vp4cx9xeX6d8pwBb/QnKZI4DQnQuI+9cA=;
 b=WqaVjoJHZHbwMZkCKtEgGHQuQCfsLipfpjwMmzEAM+ckAOMuYezCGOlK6wbfuNMsmuX9welFP1yVgV2OkIVUr9KFRN2KMO+M4h6wgPBo3XwnxMJYVRBrpCJYYTsUPECbYPH7c/F1g0/SHHsZ9x4Vmn6rBbvhqiX+B4YWEqdsgrs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 DM4PR12MB6592.namprd12.prod.outlook.com (2603:10b6:8:8a::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7982.25; Thu, 26 Sep 2024 08:40:13 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%5]) with mapi id 15.20.7982.022; Thu, 26 Sep 2024
 08:40:13 +0000
Message-ID: <aa82a23e-00ca-49be-bc47-f2e122ff2459@amd.com>
Date: Thu, 26 Sep 2024 14:10:03 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 5/9] drm/amd/pm: use pm_runtime_get_if_active for
 debugfs getters
To: Pierre-Eric Pelloux-Prayer <pierre-eric@damsy.net>,
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com,
 kenneth.feng@amd.com, mario.limonciello@amd.com
References: <20240925075607.23929-1-pierre-eric.pelloux-prayer@amd.com>
 <20240925075607.23929-6-pierre-eric.pelloux-prayer@amd.com>
 <74f68af1-ed33-422c-b6f0-d1a036a550b1@amd.com>
 <e1619a8a-80ca-48dc-9e62-ccf9462561fe@damsy.net>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <e1619a8a-80ca-48dc-9e62-ccf9462561fe@damsy.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA0PR01CA0044.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:81::17) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|DM4PR12MB6592:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b17216d-125d-491c-1242-08dcde06d666
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eW5RSDVuQTJhblhIZ210akE1U09KcDdabzlSMTBMU3dOMFRmZFlQazFDN3dV?=
 =?utf-8?B?Y09QNjU4WnQ1SkZHSG5GZFFQSk9kTUUvdm9wRXBuQTRlWG8reU5Rd0t3MUUy?=
 =?utf-8?B?RWpVVzBKR09TYVdyT3lLM2pkNjZab2FtQVFKSTZIMEJQMmJsTGdvYmNwdWtT?=
 =?utf-8?B?YVhGMjN1SU1FTlVRd2pNQk1NNXhhVTFnekVtR1NsT3hmS1lCL3Jld3RXa2dj?=
 =?utf-8?B?OFRpZ2lvUXRjTWE1TFJsdTdVejI5ck9QOHVETktHZHFXYmkvZEZvMHF3TTJP?=
 =?utf-8?B?R1hZYlpwbGw1VmdPb09kMGo3VzBmQjR2RTI4MGFtY05VcEUvWTAxUmdtcFdh?=
 =?utf-8?B?VDJsT1dHU1BkaEtBbTY0eFYvaFpMU05hbkdBcDUxYWpYdWtObXFtdzBrUWtK?=
 =?utf-8?B?VG4weEJYbndlQjVZRUZSblJaY29HZml5bTd1bVNLczhrTHV0N25OdkJqZW9o?=
 =?utf-8?B?cjBVRythRHVsVGwrMmFpWkFCU1hiSkoxU1FJazdRWm1GOUVOYklHQnh2a0p5?=
 =?utf-8?B?NUdLMWJndTg4ZUxaalhzWXhsVjVvN3R4TVZlTXJvTkczdUhtZ2xSTjk3dUdG?=
 =?utf-8?B?Zno0QStEUTJORVMwS2lhcnZMQUlBT0p6bTNxdEwxQy81OFlsNjV2and3Nnpo?=
 =?utf-8?B?SDJkWUs0ekV5bGlPUkxocWc1bTI3SGgrTlBneUF0T0VoeHp0NlIycU9TV2lM?=
 =?utf-8?B?VU9NdVZEOWZHaGk4YWprZVFkMXBNWm1QZ1ZIbGZSWm5hZ2JjZitYK1lyaTdv?=
 =?utf-8?B?anJVdDVsOUg4NkR4cU5pYnZwSURyMXQxWW5ZcjJ0ZUJ4MHgzbk5qTzZldGpC?=
 =?utf-8?B?Y2N6Y0tkUjhHVHN1QUNhSE14U21YQTIxVXZvT3JVU081OFZUaW9tY3luTXNL?=
 =?utf-8?B?eVRSZFc3YUcwVUsxZTZDam9NakJLVkYvOGlocGdWMmp5M2JDOXlhZy9qOFpP?=
 =?utf-8?B?a0xuZ2tRMkVGWjUyYThnUHNteDQzU05qKytWekgvNTRzOTJlaEYrMVRVR3Q1?=
 =?utf-8?B?MHBycUVzNWFEeitMallLMXZlNk9Ua1hOSzZucDRJSGpPRDQ2WUhTQkVDU2VB?=
 =?utf-8?B?OVdiWUtNdWdVemJQTGo3YTYyUFNaSHpMWWljV2taNnRHdlZtSnRTSmk5SDJi?=
 =?utf-8?B?ekh5Z1ZkZUYrTk95WExiaEpHWjhMQy9YOHJBc1RLSjFVWElBNmxZNTBzZjlm?=
 =?utf-8?B?c2VzMmc0WWtWWUg5Z1NXTWFzcmI2UWZQVjdKY0wyRWY4d3FwazVQTGJoc0sv?=
 =?utf-8?B?ZlBOVEFxMjhXSUk3QkxIRHN0MWFXMlFGNTFLTER5dUVUL2NxWGhlK3VNN28w?=
 =?utf-8?B?YnBBWG9vaHVVSWx1Tlh3V1JBUGVwRk1rZlp3SWxVMzdkazFBeHc2WnNVL2Jj?=
 =?utf-8?B?blFHaEE5TG5Sa1poOFRCSHhaeUhOVm94UXBmWTBjM2F6VFBja0QvWTNjUG9t?=
 =?utf-8?B?b0FMY21iN212bnRJQXZOeUM0Ym5ZMk95K3RSSEdVS1VqdFhrTTJiTDN3Z2Nm?=
 =?utf-8?B?V0Y0OFdTVU1qS0VBbEZGb1ErR0wzcFhMaGlEZWtZZ01RSTJmNFpDbWFTLzdV?=
 =?utf-8?B?WXhlN1BrZE5BSWdPaGpZdFQwQUNUZDhCQnlDVGhyb1V3Q1lhR201S041dVd6?=
 =?utf-8?Q?6KvSyHZtQtvijAkKgnO/jQXjqCfuTiNUJ1Vjlt6Kao04=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eVRWSDgyZGplaVlRTkpEeTRLMkJ0bTZyVlNNVjBjUnBwQm9zdGw2VkZtUVB3?=
 =?utf-8?B?dldVdEk2OVZ5Z1JjK2xNclNESFZXSVpiQmF4TTd3V096bDR3ZHpQVWREWUNH?=
 =?utf-8?B?OHA4RlArYlBmWWxVYWl0bmd2RmZQdUt0blV1cHJ5TnI5czVnRGhGbDdqV3FZ?=
 =?utf-8?B?elptVkUxazUvcklKSm5DelBmOXQ0VUsvQ3htQWcrYThNU0h2Mk1pSVA2QUVn?=
 =?utf-8?B?ekpRK1JhTWl3SkM0VGJZSWVXaDFzdmtaMVRtSjRoVHdEZzBza2tDSVZhWHRS?=
 =?utf-8?B?RENxWXpZd1FvYmMvSHF6elZYUGJTUWtVU3BBMVc0QlhnNERnVjlleWxTZmJW?=
 =?utf-8?B?RFBWby8rRGlxTVlidTZ0MWdFZDU5cmhqN1hxcis4NDZYNk4rNFhBd0F4SDJh?=
 =?utf-8?B?S09lYUVCZ1ducVRockcwWEZubGdOWGdXajJ1YTRJeGorNHoxdVNVLy9lb1JV?=
 =?utf-8?B?eStnV1dRNzFEVFo4WnY0SlhCSTgzNkFtazFMQUhlVllGRTd1bTJWU0oraXJ2?=
 =?utf-8?B?b2lTcWd2MXJhRkRocjlhdkdvTGpYT3VFWGo3RWp6UFRnL1dCTjFOWFlBRkpU?=
 =?utf-8?B?bmpUZmNmcHZwS094YTVIakNQVVU2NmtMSHQ0cGp4dDZPNWYxNDRFSXI0K0JQ?=
 =?utf-8?B?L1pNTGlsV2Q5UmRWczEvdlA5N014TXErQkdzWmhFdmhpR1krY3NrQW8rWU5h?=
 =?utf-8?B?QzlrOU1BZnI4OTlHQlF0RWhoTjV4bW1MRmh1akUyWlQxZmE5ak0vZkdUMDB5?=
 =?utf-8?B?cmxjK3J5d2YxVVZyRGpRaFJNQm9IbHkxMjVjc2pNSk8wL3pYd0E2MHpoZXVE?=
 =?utf-8?B?N2tOU255WkxXeU4vNnJIczNLaXVwTHJpSTFtMTFWNmlLN21Vakx0TFZhYzN4?=
 =?utf-8?B?ZXh2S3dVTHdiNnAwVFl5dVVUalRhL3M2MjJPb1dCOFJrUmNjWmJlMUx0Zmdp?=
 =?utf-8?B?cXQwWWRQSHA0dm5rYW9VVWYydCt5SUc5ZHhYZ2R5dW1vZ1FhaFhrR3ZUYTBv?=
 =?utf-8?B?bUs2UGNMVjB2NWpQTWhoaWZlNVk1dXJWYUsvTEF2SDliQUFIaDBSSlZ1ZGI5?=
 =?utf-8?B?bTM2WUE0Rjg5VzRxYVhrTVowSDRCSExGU0pvL3FPSFdDSkZTdkcycFZXcmM2?=
 =?utf-8?B?ZTcvOGJyb2xNcFdZbUh6Sm42d20yQWVrNVQrZXQ3SHJ3NzdUemk2TjJrTkJE?=
 =?utf-8?B?d2YzNDZPc1gzR2RSb2xiRDFoMUZyOVMzN25jQzl1TFVUVCsrNXMxSVh3bGFt?=
 =?utf-8?B?Y3EwS2FPOS9sUlUzT3YrdGZzcjh4L3lnbUFTRTBMVEQvc0xJSGFvQ2xBYVU5?=
 =?utf-8?B?VVB1UVBpU2hzNVVKcm1nQjFMMmsrd1p6cFllek1TUkhjUWtGU3JNYlhrdURU?=
 =?utf-8?B?UXJnVjAwTkluaG5pQW5oL1h1M0l6aXFzMEsrdXhoZWNRU0d0Y1FPbmFJK21n?=
 =?utf-8?B?SUsxazd3aTZNRktBc1VzZldQQ3hodmc3U2V6YTVWd2VIeFRZQTNFNFlESy81?=
 =?utf-8?B?NUFpOWt6OENhK1pRZHgrVEJzZURCcUtOQTZMclJGU29BcVMvejZkUGVDdnFx?=
 =?utf-8?B?Mld0WTBEeTFnQW41UlVqNmdycDFrTUpNejdKYnlkQnpFanlZeUk0eXNhb0Rz?=
 =?utf-8?B?aUREaEJjdkJuYnhkN0RRTmZta3lXWEd1VmdRUVZqemxnSTA1Y0hSbTM5b3p6?=
 =?utf-8?B?L0p2UUxsYlN0cU8yZk5CQ3NKM0hCUi9NeVRNZzJpbmMvYkRkQmMzakNqK1U0?=
 =?utf-8?B?TnhTTDhjVlo1RUF3MDZtb3N4RTJaT3hObjhSMzBDNnRPTGtJUGNNSXdEYm1i?=
 =?utf-8?B?VHhEdmlMQjFUTUkvWnpUTFlnRmhtbkdPRXRvRnNIK1lUYnhvbjRmd0x2cUJJ?=
 =?utf-8?B?UDRTUE5MSXpSQ1dIUFMvdWxHVEV3NGJGU05uNEV1dHMrdHQrZDlqYmxMQS9E?=
 =?utf-8?B?RzQwR0dPSDVKS2xiNGdPckllNW5vR3kzUjg1R2tDZzh1SmhXMVdiUUNFOGhT?=
 =?utf-8?B?ZTBQWWdSZHVJNW9kcTluUE5GdnlxUzA3WERKcHRWbGdqaW8wVzRwWWZPTm1o?=
 =?utf-8?B?NmFVT3h2bXQ2Y1MyUHo5RnQxTXJnbUc1dElmemZPRlM0SCtWTGlJc1ZzQS82?=
 =?utf-8?Q?jIWtVj2nGBQhjy3FMURTnwl0q?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b17216d-125d-491c-1242-08dcde06d666
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2024 08:40:13.1535 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: arX+eocAfowKUV5cyn/e6L4TwUtU6uljjuYjpvzlKrtkQayBXtfHE8S8H8mfBqtZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6592
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 9/25/2024 8:02 PM, Pierre-Eric Pelloux-Prayer wrote:
> 
> 
> Le 25/09/2024 à 15:35, Lazar, Lijo a écrit :
>>
>>
>> On 9/25/2024 1:24 PM, Pierre-Eric Pelloux-Prayer wrote:
>>> Don't wake up the GPU for reading pm values. Instead, take a runtime
>>> powermanagement ref when trying to read it iff the GPU is already
>>> awake.
>>>
>>> This avoids spurious wake ups (eg: from applets).
>>>
>>> We use pm_runtime_get_if_in_active(ign_usage_count=true) because we care
>>> about "is the GPU awake?" not about "is the GPU awake and something else
>>> prevents suspend?".
>>>
>>> Tested-by: Mario Limonciello <mario.limonciello@amd.com>
>>> Signed-off-by: Pierre-Eric Pelloux-Prayer
>>> <pierre-eric.pelloux-prayer@amd.com>
>>> ---
>>>   drivers/gpu/drm/amd/pm/amdgpu_pm.c | 138 ++++++++++++++---------------
>>>   1 file changed, 69 insertions(+), 69 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
>>> b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
>>> index c8f34b1a4d8e..f1f339b75380 100644
>>> --- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
>>> +++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
>>> @@ -145,9 +145,9 @@ static ssize_t amdgpu_get_power_dpm_state(struct
>>> device *dev,
>>>       if (adev->in_suspend && !adev->in_runpm)
>>>           return -EPERM;
>>>   -    ret = pm_runtime_resume_and_get(ddev->dev);
>>> -    if (ret < 0)
>>> -        return ret;
>>> +    ret = pm_runtime_get_if_active(ddev->dev, true);
>>> +    if (ret <= 0)
>>> +        return ret ?: -EPERM;
>>
>> Not all our devices support runtime PM.
>>
>> As per the API documentation -
>>
>> "-EINVAL is returned if runtime PM is disabled for the
>> device, in which case also the usage_count will remain unmodified."
> 
> This doc is about "dev->power.disable_depth > 0", not about runtime PM
> being disabled (like you would get by using pm_runtime_forbid).
> 
> When runtime PM is disabled, usage_count is always >= 1 and the status
> is RPM_ACTIVE so pm_runtime_get_if_active will succeed.
> 
> I tested on 2 dGPUs without runtime PM, and both seemed to work fine.
> 

Thanks for clarifying. Found that default enablement is taken care by
pci base driver.

https://elixir.bootlin.com/linux/v6.11/source/drivers/pci/pci.c#L3173

Thanks,
Lijo

> Pierre-Eric
> 
>>
>> If that's true, this won't be working on devices without runtime PM
>> support.
>>
>> Thanks,
>> Lijo
>>>         amdgpu_dpm_get_current_power_state(adev, &pm);
>>>   @@ -268,9 +268,9 @@ static ssize_t
>>> amdgpu_get_power_dpm_force_performance_level(struct device *dev,
>>>       if (adev->in_suspend && !adev->in_runpm)
>>>           return -EPERM;
>>>   -    ret = pm_runtime_resume_and_get(ddev->dev);
>>> -    if (ret < 0)
>>> -        return ret;
>>> +    ret = pm_runtime_get_if_active(ddev->dev, true);
>>> +    if (ret <= 0)
>>> +        return ret ?: -EPERM;
>>>         level = amdgpu_dpm_get_performance_level(adev);
>>>   @@ -364,9 +364,9 @@ static ssize_t amdgpu_get_pp_num_states(struct
>>> device *dev,
>>>       if (adev->in_suspend && !adev->in_runpm)
>>>           return -EPERM;
>>>   -    ret = pm_runtime_resume_and_get(ddev->dev);
>>> -    if (ret < 0)
>>> -        return ret;
>>> +    ret = pm_runtime_get_if_active(ddev->dev, true);
>>> +    if (ret <= 0)
>>> +        return ret ?: -EPERM;
>>>         if (amdgpu_dpm_get_pp_num_states(adev, &data))
>>>           memset(&data, 0, sizeof(data));
>>> @@ -399,9 +399,9 @@ static ssize_t amdgpu_get_pp_cur_state(struct
>>> device *dev,
>>>       if (adev->in_suspend && !adev->in_runpm)
>>>           return -EPERM;
>>>   -    ret = pm_runtime_resume_and_get(ddev->dev);
>>> -    if (ret < 0)
>>> -        return ret;
>>> +    ret = pm_runtime_get_if_active(ddev->dev, true);
>>> +    if (ret <= 0)
>>> +        return ret ?: -EPERM;
>>>         amdgpu_dpm_get_current_power_state(adev, &pm);
>>>   @@ -526,9 +526,9 @@ static ssize_t amdgpu_get_pp_table(struct
>>> device *dev,
>>>       if (adev->in_suspend && !adev->in_runpm)
>>>           return -EPERM;
>>>   -    ret = pm_runtime_resume_and_get(ddev->dev);
>>> -    if (ret < 0)
>>> -        return ret;
>>> +    ret = pm_runtime_get_if_active(ddev->dev, true);
>>> +    if (ret <= 0)
>>> +        return ret ?: -EPERM;
>>>         size = amdgpu_dpm_get_pp_table(adev, &table);
>>>   @@ -840,9 +840,9 @@ static ssize_t
>>> amdgpu_get_pp_od_clk_voltage(struct device *dev,
>>>       if (adev->in_suspend && !adev->in_runpm)
>>>           return -EPERM;
>>>   -    ret = pm_runtime_resume_and_get(ddev->dev);
>>> -    if (ret < 0)
>>> -        return ret;
>>> +    ret = pm_runtime_get_if_active(ddev->dev, true);
>>> +    if (ret <= 0)
>>> +        return ret ?: -EPERM;
>>>         for (clk_index = 0 ; clk_index < 6 ; clk_index++) {
>>>           ret = amdgpu_dpm_emit_clock_levels(adev,
>>> od_clocks[clk_index], buf, &size);
>>> @@ -930,9 +930,9 @@ static ssize_t amdgpu_get_pp_features(struct
>>> device *dev,
>>>       if (adev->in_suspend && !adev->in_runpm)
>>>           return -EPERM;
>>>   -    ret = pm_runtime_resume_and_get(ddev->dev);
>>> -    if (ret < 0)
>>> -        return ret;
>>> +    ret = pm_runtime_get_if_active(ddev->dev, true);
>>> +    if (ret <= 0)
>>> +        return ret ?: -EPERM;
>>>         size = amdgpu_dpm_get_ppfeature_status(adev, buf);
>>>       if (size <= 0)
>>> @@ -996,9 +996,9 @@ static ssize_t amdgpu_get_pp_dpm_clock(struct
>>> device *dev,
>>>       if (adev->in_suspend && !adev->in_runpm)
>>>           return -EPERM;
>>>   -    ret = pm_runtime_resume_and_get(ddev->dev);
>>> -    if (ret < 0)
>>> -        return ret;
>>> +    ret = pm_runtime_get_if_active(ddev->dev, true);
>>> +    if (ret <= 0)
>>> +        return ret ?: -EPERM;
>>>         ret = amdgpu_dpm_emit_clock_levels(adev, type, buf, &size);
>>>       if (ret == -ENOENT)
>>> @@ -1245,9 +1245,9 @@ static ssize_t amdgpu_get_pp_sclk_od(struct
>>> device *dev,
>>>       if (adev->in_suspend && !adev->in_runpm)
>>>           return -EPERM;
>>>   -    ret = pm_runtime_resume_and_get(ddev->dev);
>>> -    if (ret < 0)
>>> -        return ret;
>>> +    ret = pm_runtime_get_if_active(ddev->dev, true);
>>> +    if (ret <= 0)
>>> +        return ret ?: -EPERM;
>>>         value = amdgpu_dpm_get_sclk_od(adev);
>>>   @@ -1302,9 +1302,9 @@ static ssize_t amdgpu_get_pp_mclk_od(struct
>>> device *dev,
>>>       if (adev->in_suspend && !adev->in_runpm)
>>>           return -EPERM;
>>>   -    ret = pm_runtime_resume_and_get(ddev->dev);
>>> -    if (ret < 0)
>>> -        return ret;
>>> +    ret = pm_runtime_get_if_active(ddev->dev, true);
>>> +    if (ret <= 0)
>>> +        return ret ?: -EPERM;
>>>         value = amdgpu_dpm_get_mclk_od(adev);
>>>   @@ -1379,9 +1379,9 @@ static ssize_t
>>> amdgpu_get_pp_power_profile_mode(struct device *dev,
>>>       if (adev->in_suspend && !adev->in_runpm)
>>>           return -EPERM;
>>>   -    ret = pm_runtime_resume_and_get(ddev->dev);
>>> -    if (ret < 0)
>>> -        return ret;
>>> +    ret = pm_runtime_get_if_active(ddev->dev, true);
>>> +    if (ret <= 0)
>>> +        return ret ?: -EPERM;
>>>         size = amdgpu_dpm_get_power_profile_mode(adev, buf);
>>>       if (size <= 0)
>>> @@ -1467,9 +1467,9 @@ static int
>>> amdgpu_hwmon_get_sensor_generic(struct amdgpu_device *adev,
>>>       if (adev->in_suspend && !adev->in_runpm)
>>>           return -EPERM;
>>>   -    r = pm_runtime_resume_and_get(adev->dev);
>>> -    if (r < 0)
>>> -        return r;
>>> +    r = pm_runtime_get_if_active(adev->dev, true);
>>> +    if (r <= 0)
>>> +        return r ?: -EPERM;
>>>         /* get the sensor value */
>>>       r = amdgpu_dpm_read_sensor(adev, sensor, query, &size);
>>> @@ -1583,9 +1583,9 @@ static ssize_t amdgpu_get_pcie_bw(struct device
>>> *dev,
>>>       if (!adev->asic_funcs->get_pcie_usage)
>>>           return -ENODATA;
>>>   -    ret = pm_runtime_resume_and_get(ddev->dev);
>>> -    if (ret < 0)
>>> -        return ret;
>>> +    ret = pm_runtime_get_if_active(ddev->dev, true);
>>> +    if (ret <= 0)
>>> +        return ret ?: -EPERM;
>>>         amdgpu_asic_get_pcie_usage(adev, &count0, &count1);
>>>   @@ -1711,9 +1711,9 @@ static ssize_t
>>> amdgpu_get_apu_thermal_cap(struct device *dev,
>>>       struct drm_device *ddev = dev_get_drvdata(dev);
>>>       struct amdgpu_device *adev = drm_to_adev(ddev);
>>>   -    ret = pm_runtime_resume_and_get(ddev->dev);
>>> -    if (ret < 0)
>>> -        return ret;
>>> +    ret = pm_runtime_get_if_active(ddev->dev, true);
>>> +    if (ret <= 0)
>>> +        return ret ?: -EPERM;
>>>         ret = amdgpu_dpm_get_apu_thermal_limit(adev, &limit);
>>>       if (!ret)
>>> @@ -1787,9 +1787,9 @@ static ssize_t amdgpu_get_pm_metrics(struct
>>> device *dev,
>>>       if (adev->in_suspend && !adev->in_runpm)
>>>           return -EPERM;
>>>   -    ret = pm_runtime_resume_and_get(ddev->dev);
>>> -    if (ret < 0)
>>> -        return ret;
>>> +    ret = pm_runtime_get_if_active(ddev->dev, true);
>>> +    if (ret <= 0)
>>> +        return ret ?: -EPERM;
>>>         size = amdgpu_dpm_get_pm_metrics(adev, buf, PAGE_SIZE);
>>>   @@ -1825,9 +1825,9 @@ static ssize_t amdgpu_get_gpu_metrics(struct
>>> device *dev,
>>>       if (adev->in_suspend && !adev->in_runpm)
>>>           return -EPERM;
>>>   -    ret = pm_runtime_resume_and_get(ddev->dev);
>>> -    if (ret < 0)
>>> -        return ret;
>>> +    ret = pm_runtime_get_if_active(ddev->dev, true);
>>> +    if (ret <= 0)
>>> +        return ret ?: -EPERM;
>>>         size = amdgpu_dpm_get_gpu_metrics(adev, &gpu_metrics);
>>>       if (size <= 0)
>>> @@ -2700,9 +2700,9 @@ static ssize_t
>>> amdgpu_hwmon_get_pwm1_enable(struct device *dev,
>>>       if (adev->in_suspend && !adev->in_runpm)
>>>           return -EPERM;
>>>   -    ret = pm_runtime_resume_and_get(adev->dev);
>>> -    if (ret < 0)
>>> -        return ret;
>>> +    ret = pm_runtime_get_if_active(adev->dev, true);
>>> +    if (ret <= 0)
>>> +        return ret ?: -EPERM;
>>>         ret = amdgpu_dpm_get_fan_control_mode(adev, &pwm_mode);
>>>   @@ -2828,9 +2828,9 @@ static ssize_t amdgpu_hwmon_get_pwm1(struct
>>> device *dev,
>>>       if (adev->in_suspend && !adev->in_runpm)
>>>           return -EPERM;
>>>   -    err = pm_runtime_resume_and_get(adev->dev);
>>> -    if (err < 0)
>>> -        return err;
>>> +    err = pm_runtime_get_if_active(adev->dev, true);
>>> +    if (err <= 0)
>>> +        return err ?: -EPERM;
>>>         err = amdgpu_dpm_get_fan_speed_pwm(adev, &speed);
>>>   @@ -2855,9 +2855,9 @@ static ssize_t
>>> amdgpu_hwmon_get_fan1_input(struct device *dev,
>>>       if (adev->in_suspend && !adev->in_runpm)
>>>           return -EPERM;
>>>   -    err = pm_runtime_resume_and_get(adev->dev);
>>> -    if (err < 0)
>>> -        return err;
>>> +    err = pm_runtime_get_if_active(adev->dev, true);
>>> +    if (err <= 0)
>>> +        return err ?: -EPERM;
>>>         err = amdgpu_dpm_get_fan_speed_rpm(adev, &speed);
>>>   @@ -2916,9 +2916,9 @@ static ssize_t
>>> amdgpu_hwmon_get_fan1_target(struct device *dev,
>>>       if (adev->in_suspend && !adev->in_runpm)
>>>           return -EPERM;
>>>   -    err = pm_runtime_resume_and_get(adev->dev);
>>> -    if (err < 0)
>>> -        return err;
>>> +    err = pm_runtime_get_if_active(adev->dev, true);
>>> +    if (err <= 0)
>>> +        return err ?: -EPERM;
>>>         err = amdgpu_dpm_get_fan_speed_rpm(adev, &rpm);
>>>   @@ -2986,9 +2986,9 @@ static ssize_t
>>> amdgpu_hwmon_get_fan1_enable(struct device *dev,
>>>       if (adev->in_suspend && !adev->in_runpm)
>>>           return -EPERM;
>>>   -    ret = pm_runtime_resume_and_get(adev->dev);
>>> -    if (ret < 0)
>>> -        return ret;
>>> +    ret = pm_runtime_get_if_active(adev->dev, true);
>>> +    if (ret <= 0)
>>> +        return ret ?: -EPERM;
>>>         ret = amdgpu_dpm_get_fan_control_mode(adev, &pwm_mode);
>>>   @@ -3152,9 +3152,9 @@ static ssize_t
>>> amdgpu_hwmon_show_power_cap_generic(struct device *dev,
>>>       if (adev->in_suspend && !adev->in_runpm)
>>>           return -EPERM;
>>>   -    r = pm_runtime_resume_and_get(adev->dev);
>>> -    if (r < 0)
>>> -        return r;
>>> +    r = pm_runtime_get_if_active(adev->dev, true);
>>> +    if (r <= 0)
>>> +        return r ?: -EPERM;
>>>         r = amdgpu_dpm_get_power_limit(adev, &limit,
>>>                         pp_limit_level, power_type);
>>> @@ -3685,9 +3685,9 @@ static int amdgpu_retrieve_od_settings(struct
>>> amdgpu_device *adev,
>>>       if (adev->in_suspend && !adev->in_runpm)
>>>           return -EPERM;
>>>   -    ret = pm_runtime_resume_and_get(adev->dev);
>>> -    if (ret < 0)
>>> -        return ret;
>>> +    ret = pm_runtime_get_if_active(adev->dev, true);
>>> +    if (ret <= 0)
>>> +        return ret ?: -EPERM;
>>>         size = amdgpu_dpm_print_clock_levels(adev, od_type, buf);
>>>       if (size == 0)
