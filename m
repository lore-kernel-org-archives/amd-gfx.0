Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B213C83F17
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Jul 2025 04:10:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A89F510E0FF;
	Fri, 18 Jul 2025 04:10:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mG/IGbMI";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2059.outbound.protection.outlook.com [40.107.102.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6CE3C10E0F7
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Jul 2025 04:10:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pJfGeC7asvchCy0J8UMhDC9MCx7rJBm5bIsy+i6DonNL8IO6Ril8AjU8D44umT1W7bi6xWvwTjPRiAxUeU6e3QT0tM/CzPdUz1X+icuAXqPGWXoU+9rVEMSY586bWyoNv7Rn8wZmBTNQimeV3pTeiBxyTeJQVN3jmAJNskEWKt2LtX9ddVq5ll2pXfZKQ6sJXhZBMwJh2exlKSbEzY8YMS0aeBdQFhaNAQDzqZlAq8Y1sl3sN9H5mYwaAhdtnunzGmTEs/wM3BtQ7a1R3wt7bjFhT9sHMkk1402wgjoXJXTNYZme4mU8DeBdA7CGLXQa2ItMZbKC5/qqgDCtK0mt7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R7D8fl6qb8YK24svhiiw45w5jkJ+3VIy8KCmW6wTmu8=;
 b=Uh/3VC1STrbABbtVrjB9ZIB8XlxkaTozq1MuCem6hOMmqhJJNLY827zvqqVNHFvY/DlJ27w1NxMZT9KCIZChAlQ2FJjGlNwan6s9M9ygwxFFJEvH0HmwMgzzL4FaZCmpoXGoVl/D4hskvNulpYL8SoqmcpgYqbD9htLJlHp+LR3IEO+CXh4Ii11tgyOpHU+LHmVwFAMflst3cqnGHgGUo2j5TeNPlPxpITuMrv3esSSJzyQh8AfdK4wvwV4WUm0seX69VAW4rS2XKuBy9Y9WlmazO/dUaAIo4cgzvtG0I0O5mMzOwhgSY1mRkERunRpYNdkGSjcKJcBr0eZ0BPTIVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R7D8fl6qb8YK24svhiiw45w5jkJ+3VIy8KCmW6wTmu8=;
 b=mG/IGbMISwe5NDdgoWvSsYepQsgUTtwsiL9ms5qQoQsmi1EJtGv16z5pjHmU3xM0sfZXNeuXOTp6xbueu6OBUFXMzqPmZzieby3aXbF9dVDNYsCiEm/tQsazB75kBMvHpdM2nwBREA4bxYj0bfLGUR3tb2eFeCNNE7dgB1u6O5s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB7820.namprd12.prod.outlook.com (2603:10b6:510:268::8)
 by IA1PR12MB6353.namprd12.prod.outlook.com (2603:10b6:208:3e3::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.39; Fri, 18 Jul
 2025 04:10:14 +0000
Received: from PH7PR12MB7820.namprd12.prod.outlook.com
 ([fe80::7606:59:8d0d:6d4c]) by PH7PR12MB7820.namprd12.prod.outlook.com
 ([fe80::7606:59:8d0d:6d4c%4]) with mapi id 15.20.8880.021; Fri, 18 Jul 2025
 04:10:13 +0000
Message-ID: <b446533c-fdfa-42eb-8cea-9c6948878204@amd.com>
Date: Fri, 18 Jul 2025 09:40:08 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] drm/amdgpu: track whether a queue is a kernel queue
 in amdgpu_mqd_prop
To: amd-gfx@lists.freedesktop.org
References: <20250716220115.3872837-1-alexander.deucher@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20250716220115.3872837-1-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN4P287CA0102.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:278::9) To PH7PR12MB7820.namprd12.prod.outlook.com
 (2603:10b6:510:268::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB7820:EE_|IA1PR12MB6353:EE_
X-MS-Office365-Filtering-Correlation-Id: da9a65e2-3c4a-4c10-fa58-08ddc5b0fe91
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MmJsc1U4ckFjNE5CampCelhMWU9ZdjV2c1paWEp0QS9SMExoQTFHQTJiQVVC?=
 =?utf-8?B?ak8ydEtxWEpTRlhkNW13MjYrcXFIR29CMThTQ2x1a3FNK2M4UHRSeGpwQ05B?=
 =?utf-8?B?TzZGRFRMbG96dmwxajZiWUNIVFhKTDNpV3B6RnRPbnhiWElNRmYxVHpTTDhG?=
 =?utf-8?B?LzRtVDUwVGkwNTc2VlhibFMrSG1Pc1JZek9TR1dUZUJtWVZneEgvRkNiL2h4?=
 =?utf-8?B?UTlrRE9tK3lyS3ByZk8xQXhadmgrdjFQbWJ2dERSeTZPZzhCcS82cTZEN0V6?=
 =?utf-8?B?dGRDVERqek1OYzZrdG41NlRzblVxNTlBUzJnSXovRmQ4S0dNN0haZTlINGNM?=
 =?utf-8?B?bnJoODhOWXhReVBkZVlyazR3SGJUL1NqRGlZVHgzTERyMkVCaXM1S2p6Zm9Q?=
 =?utf-8?B?VXpzUWxVUGFac1pwdU0yMW5oVkpvQVBEaGpZVElJSEJXSFBxUzFFcjV3ckNp?=
 =?utf-8?B?bWVYcFVsS3BMcHRuSzBaQmxiVFhqRzhUMzd6YWRTUXVkaklQR2lmMk1wSWoz?=
 =?utf-8?B?R1dVblgzdHp1Rjg5ZFI1M3AxU2oyMkFTYWZYOTNXTjBXdm9GeEd1V29XM3ZJ?=
 =?utf-8?B?Q3hwSlh0YXJVTWZyVDlGaGExVXZGRkxVdXJVZEZ4RklxYmRjRkgwS2NqcjAy?=
 =?utf-8?B?V1FLTDRaWk1ydVY5WkFaZTVaR1p6a0hMYWIrcHM2UDFKUmNGZHZqdW0zSjlB?=
 =?utf-8?B?TldnZlphWDZkOEVlVWRGb012UHlnR29zVDdxZU5ZdWR0UXhyQWhXZitWLzBh?=
 =?utf-8?B?NnJtZ1ByYm1XcGNLUDhJMk9QYmc0UzcwYzEzODQyK3pwTWt2aWJIWHpOQWZs?=
 =?utf-8?B?OVNPdkxqU1Qwb0ZYMStvc2I4L1V5aXpSRlVTRXpCU1Z5QzFqTzFza0xXWUMy?=
 =?utf-8?B?OWJjc21KUlA2aDRiSCtiSExDLzFwOHNlVGJqck9lVFpuS01uclhVcG9EWUp0?=
 =?utf-8?B?WnRCZHpvMU1jaVkxTVF6UGNydURxVGpOblNvaFJhbXFmMWZJdWtvUXlnWk1u?=
 =?utf-8?B?c1p4Z1JlWXlZSUJUUDlZejFGSFRTQ0RNRkF1SmZSdk9BUGNiUXlqV3c0THdv?=
 =?utf-8?B?eWhJZzhQeEJZYllmQkdKOEhqUDFrbjBFNEJaY3d1Q1Fla2NlNG9oNnpwWTIz?=
 =?utf-8?B?LzJDdzBNbGd5V2dsVzlFZUhpYWdaNnRwNGtUdG5LSk1EeWtNM1FsdXpUYVhH?=
 =?utf-8?B?bzBPQ0hoSjZUM1hDRWgwbStFYmswUVYvZXNYM1R6TERnS3Q3UStpUjdIckhW?=
 =?utf-8?B?dUxweTZkZERsRnI0UllTZXNxUkRFMG93WWhHU09sNjFQU0svWElDVVZpdXV4?=
 =?utf-8?B?cTZKU3VIbnJlRFBlOXV1dG5Cbm1NNUtRU2YxYktQRkxrb2lBVENad3d4c2Mr?=
 =?utf-8?B?YTJ6c2tFMW9qUEIyS2NId2QvdmszSlpmQkJYK0Z1UXdCTEs2L2p2cEF1d3NY?=
 =?utf-8?B?RlNzWE95bW5vaFl2bTdWZ2tjL3YzVUFXTmd6MU5tY2RCWkJ0ZGlWMk5UT1Vt?=
 =?utf-8?B?aURZdGNUenFFV2hYUEdZVzk2UUd3T2U1TTE0UDhjaklTRDN2eXZrV0VnY0lJ?=
 =?utf-8?B?YTlwVjdSVXdzSDhhWmNlSEZhbTVtVm5hUjJoMC8zRUxvM05vcTBaUnE2Wm9w?=
 =?utf-8?B?NFB4MFNFdk5ndTJWa3JYczF6N2kzdEVEOGxtUjRsSys3b3RHck1WdzJKaFA5?=
 =?utf-8?B?ZVNDdjdsUCtYYWVEV2RzTjJUcXJQY0M5UzZTUUdCa3Zja05NbHI0MnRmWThZ?=
 =?utf-8?B?blRJNXRBMnVQbUpNOUtYSUxLbDRuZDN3MFRjWUdhUkdDaTM5VzliY3d4d2xI?=
 =?utf-8?B?QW9MQUFMT280eklVRzM0T3M4NHhoWWtWekVNRXZBNVVJQXJNQkc2M2FacFJx?=
 =?utf-8?B?Uk8rNk5BU1d6bGpQRnp6ZFAyQlVtekVYTVVBZ3lnWHRDM25EdFNjejBmTGFM?=
 =?utf-8?Q?WbF61ODbN0Y=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB7820.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TThRRDBPOVg0NVZsL29oVHAxaG9pNDRXSURhbVBnT0xJWm1lb1dhQ0Fzb2VU?=
 =?utf-8?B?bnR6eEFLcGFleHp5WFdFWnI5Sis1RTBXeUdTNThuM055TitHZ0tFL3hBcE8y?=
 =?utf-8?B?bmNkaVNwUVJPYnI3S0I4Ri9YdHlUMk84QmwwcDRiaSsvQVN5N3FNeC9jYUFk?=
 =?utf-8?B?SmxpcDdYMjN5S1RUU2VTazVLcExrRTZjTlpVZlh0SVh3OExZTDU2T1dYTG96?=
 =?utf-8?B?eWZPWUo4ZDBvWWdwdkZnWllQd2hrUllxS215TWJmK0Q0Wkh0RVE1ZVJSK2hs?=
 =?utf-8?B?UHBBK1F4aDd5SXgyTnRXdk5LWk1nK1lsckpYVHNZYTJwV1A2eHdTTXU3RU1M?=
 =?utf-8?B?T1RNS2daby81bXJpZjNSTUZxdmJKZnVqenkvdEFlSEVYQ21MTFgwNklNaDdW?=
 =?utf-8?B?c3lHUWF5NG5aOElzenRPVXFEZlBNS1JLM2tvcktMS29YTFB6RmtYSWExNVF4?=
 =?utf-8?B?SS8vcG95ZzhPdjJGWUJybXdpMitqUXNRMG1paUhUMllxUzVibHZTcENoUFFS?=
 =?utf-8?B?L2VYNlRubzAvVFJsMlBBS29MejVjaUM3d0hvSEJNUjVsS2JjQnBvYUdVM2dh?=
 =?utf-8?B?UEM5UFJsNkYvdHNGcU0zK09pVmdLUmFiamhJekxuNGZYZ1orLzFzZVE5QTFk?=
 =?utf-8?B?aFRpNm5CK3FBSExDbWMrMm5nWXVOZVkzYUxxMDA5S0w0a3VsZVhVWjlOQ3p5?=
 =?utf-8?B?WXR5NlJXMk1nZUdrSVd1UC85VXlNTEcrOXcwZk84Q3IxNUNqT2x2MDdvSWFo?=
 =?utf-8?B?RG9mZXBoSkszMUFrSlVYM3BCTUp3TDYzRzFhNTErUnJqVzhmYkZ4ZmJZVndh?=
 =?utf-8?B?WHRIZ292bk5pdTBQcUZJNVNHNzZSUE5JNzFtcTJSS3lZbWx2ZTdPZUQ3MU5H?=
 =?utf-8?B?ekZ6R1hGNEdYYmxEYlk5bDg1aHNva2E0K0lPWHVpRUJDTVNXaTY4VzBIWUJD?=
 =?utf-8?B?NW5YVjByMlkwMUdQRUJFREdBOU1hekxkKzhFaXlaMWdmbEJSQWU2RTMrb1RL?=
 =?utf-8?B?bExiaSthcVBNN1lIWVJkcU1RRFRrSzl0c2dTSG93ZFNJZktacHJLZ0VNeW1z?=
 =?utf-8?B?UjZiSTVVS3B4dXNrM1RsRkFCOFNsaVR0RmlFR2h0dS9wTlFTZ0NYR05KNjlC?=
 =?utf-8?B?UmZMWXYzdUZUK3J3OTQ2dXJYZ3c3WndLUVRLbDkxSDBIVnU0MGtrbTBIK0xS?=
 =?utf-8?B?M0RrRXZHMzZiZFZra2p5RDQ2TFMybmtXYkpGQ1ZoRkp6Q2dYMW14T3d5Q0lG?=
 =?utf-8?B?V2Z4MWRySGtrRWtGMnI5OGlLWHBiL2ZrSE1EYzdFbms1KzFiTk1FV3hNdTFS?=
 =?utf-8?B?UEd4UnFGUWtQY2xsTDJGcnhFa1hQcTdRT3VDdkVZZDlEREJ4TVgwVER0VS96?=
 =?utf-8?B?ekdISlFYcmRqNTduM0hDZmRNcE04NVdKM1E2dUtYVUN2cW8rdkNWMmFNTUM1?=
 =?utf-8?B?RVNiTnNYbHhXclBqODMrZU9WN2JzY1d4dTFFb2p4STk3dlBxVG5wNWJiUm5x?=
 =?utf-8?B?Z3VSRGlHVXE1WEh5TkxBS2ROcWJnZ3lJV2hFNnprazJkSWdtUHlVUjlNYkMw?=
 =?utf-8?B?QmlBaWJjaHJ0WUYwWmhBdFREOWxVVFdndXRyaklObjY3ejJNWjcxa0xqZENj?=
 =?utf-8?B?ell4V2N2WE5sQ25yMU9PMTJzR3dyTENlcjgzYUNCVEFRQks2VmhwdVdBRjhC?=
 =?utf-8?B?L2xHN2VCNW8xOWxRblpITldMSDdSVVdGYTF2eXBMT0FNSVc3K0xuU3JpN0xI?=
 =?utf-8?B?Z2pTMllxU2txNDduNG1lb2VHQTJDbnhwOGcyTlJxbFk3UXI5dll3RWxoNC82?=
 =?utf-8?B?MXg3SnpFd2NmQ1VNbkZuVS9sVnFpVWpWSjNGeHVxaUt3LzJkN3h2WGRyR2Nv?=
 =?utf-8?B?TktZeitpSUNCdmx5QkQxZm9QSGlUQmk1N3VzMWRLT1E0b1ExcWUrNFBvSVYy?=
 =?utf-8?B?Tlg4bVliMWdmby9OZkNSTGMrVXNldGpFUVJMRGpsdy85M0R3Ty9YcnR4RGtW?=
 =?utf-8?B?b250eDFjY3ZYMHJycStPVHNqY3lNTnUrM0R2aUQ1T0N1elBwaW1CRytvVEtr?=
 =?utf-8?B?d2F5TStkL1pYenFJZDBzanZ2dUdRaU1oRHJDZWNSV1lub1ZkWERlMDlNVDI2?=
 =?utf-8?Q?RmGzIGkcsll/YPelGDDWQ4Ubp?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da9a65e2-3c4a-4c10-fa58-08ddc5b0fe91
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB7820.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2025 04:10:13.6470 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0OL7WHmcrYZrBPftY78TA/bfY0TsqGQjT0ZqgiKMuuzPNNbFcghRLkmKCDW/0Mp4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6353
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



On 7/17/2025 3:31 AM, Alex Deucher wrote:
> Used to to set the MQD appropriately for each queue type.
> Kernel queues have have additional privileges.
> 
<nit> Extra 'have'
> Acked-by: Christian König <christian.koenig@amd.com>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h      | 1 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c | 2 ++
>  2 files changed, 3 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index a1737556a77eb..ef3af170dda4e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -883,6 +883,7 @@ struct amdgpu_mqd_prop {
>  	uint64_t csa_addr;
>  	uint64_t fence_address;
>  	bool tmz_queue;
> +	bool kernel_queue;
>  };
>  
>  struct amdgpu_mqd {
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> index acac646a4e4e9..617dc009a2550 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> @@ -719,6 +719,8 @@ static void amdgpu_ring_to_mqd_prop(struct amdgpu_ring *ring,
>  	prop->eop_gpu_addr = ring->eop_gpu_addr;
>  	prop->use_doorbell = ring->use_doorbell;
>  	prop->doorbell_index = ring->doorbell_index;
> +	/* kernel queues are privileged */
<nit> This comment is no longer needed here.

Thanks,
Lijo

> +	prop->kernel_queue = true;
>  
>  	/* map_queues packet doesn't need activate the queue,
>  	 * so only kiq need set this field.

