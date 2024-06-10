Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20514C27C5E
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Jun 2024 19:05:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 91D5910E3E8;
	Mon, 10 Jun 2024 19:05:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="m3w3NfiA";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2050.outbound.protection.outlook.com [40.107.243.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 19FCD10E3E8
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Jun 2024 19:05:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bBANSh4PAz/vGLRvPGG7DSuzqPou7KHN9x7BwbpTbhWd/cESh5vf07ZQjN8bCSuqSAiF9Whu+jG70EuQ5LCUxQNwDmCHnPzuM7iEbaxnZ/WF4MboYBmacPzbvjF0HKC7IT0BNTeKBJqE5eSc3XlR8OQum/HwaIAEk5mXs5dTmFC/7WOPnIbb4/1Hwhjg91cscswVzwRsYdBxMjDJmH5vgYkMELQXs6d9p9t7LM3nE0ArTGisjKJKWAZc+Vhv+OICQJdPSnI41SKjVNdYmRKhsNi+URIBiZS3bUYRGBPn2VPVgj0Rqnu5BdO6JzATxTTQ+CNo+S8l6dtzkPAAOuxdaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qX+nt8O3zha1ATeI+3mCG7qRGqon+MlF4Nw7uxXWXjc=;
 b=as97tgUP8Rt/dA9MTiZHdVGGnwzJn0BIJt4UeVH9KDT/kV35wttYdDzX0CIGXxnNJKTCztaGbOxiFeg8lzT7+u2nZm5yVy6Ef9ABspkmjnx+t6sornBGMsjBWbbIFfP2ZtYIQq0FRlEgt+6hMDaIobHfXwa8ekYgSXP/0+LbWwY4zaO2YwOIrPR0/nZ2by1K88KnYCu7nce/8zyWWbEHr5f3Asm38fvtMuSg514niK6z2ClA9NOXLzh+mUCRBkll0RnDtixRV8VNH5jY6WxnJuiIKc98NNWOIRvqHBAzWtE9qm3Ms9Duovq2+I0hEhyiTJ+RH9yMkY+XqUVlLZDu2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qX+nt8O3zha1ATeI+3mCG7qRGqon+MlF4Nw7uxXWXjc=;
 b=m3w3NfiAmb7XKwHxsrRbSl5r6mvUYocse5TQcsqVujtpz8Vd1B6ZMS0Y96WJtR31r1kZXDnf2MXUaoRuMqWNhf6g7Xl2nHqY8zamlDxhZ5WiXF0l+ZaP9NkJSaSdssTwNMA57Z2xSW0HmOwe4GpAvHroXAIy7khPfGgVJBUlw3g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4342.namprd12.prod.outlook.com (2603:10b6:208:264::7)
 by MW4PR12MB7466.namprd12.prod.outlook.com (2603:10b6:303:212::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Mon, 10 Jun
 2024 19:05:25 +0000
Received: from MN2PR12MB4342.namprd12.prod.outlook.com
 ([fe80::c55f:19e:6896:cf3]) by MN2PR12MB4342.namprd12.prod.outlook.com
 ([fe80::c55f:19e:6896:cf3%6]) with mapi id 15.20.7633.036; Mon, 10 Jun 2024
 19:05:24 +0000
Message-ID: <53c9b776-5ddc-497e-8c25-5f3f322aa021@amd.com>
Date: Tue, 11 Jun 2024 00:35:16 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] drm/amdgpu: Fix the BO release clear memory warning
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com, mario.limonciello@amd.com,
 tvrtko.ursulin@igalia.com, Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>,
 Richard Gong <richard.gong@amd.com>
References: <20240610180401.9540-1-Arunpravin.PaneerSelvam@amd.com>
 <bdd4793d-fd0a-4331-8667-7f9616d55b3a@amd.com>
Content-Language: en-US
From: "Paneer Selvam, Arunpravin" <arunpravin.paneerselvam@amd.com>
In-Reply-To: <bdd4793d-fd0a-4331-8667-7f9616d55b3a@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA1PR01CA0152.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:71::22) To MN2PR12MB4342.namprd12.prod.outlook.com
 (2603:10b6:208:264::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB4342:EE_|MW4PR12MB7466:EE_
X-MS-Office365-Filtering-Correlation-Id: a1c1f3f3-070c-411d-55ea-08dc898048a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|366007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?R0wzaDlTNGdmVnNPZFhMTlR3RnpyNHRvai9BeHVYTmV4Z1dMTExxVzlDZVlk?=
 =?utf-8?B?NmlEbDFYSEtEWXRaZTk5NHQrK2x5NHBWVHZhL3UybFd4NWdjM2p2czJheEhK?=
 =?utf-8?B?VUR4M044OUJmZXdvMzJ1d083ZzZ5U0JJU2ltL0NXSVUvMVo0Ykw3VFNhVjBt?=
 =?utf-8?B?Q1FGMFdvT05Cb1EydkIrNjVpSUY2S2JsMVoyaS9EVy95TTMwdTVvaTdBZnVk?=
 =?utf-8?B?UWp2ZDFwNWxEN1VYKytYVmJ6L290Y0c5cVh2MmgvN3dPZk14ZWUxSzlEVTlp?=
 =?utf-8?B?Y0FVS0dqNXluOG9HakJ3VXJGZWJJc1E4OUd1UWpQdU10eVZyNjE1N1ZoMFRP?=
 =?utf-8?B?SEY3M2lpUExuNGlOaHZrY2VILzBodkZtUXRlcXltS1hBRVljeGNoR0RiV1Yy?=
 =?utf-8?B?M2R3WTV1UDNBaGtWOGRXYnpUc21UaWhzeWFybmM1RnU5cEoyUjVTUmMvY1Bu?=
 =?utf-8?B?MEgvekt5MXdGRG5ycU9MUGtsMG9Jb2szb0tnTlFaZUdUZ1JnSk1XVWlpdGRJ?=
 =?utf-8?B?THNwUUtuL3FDbEJOU3FVWFc5TlZmOUlEWHNVVC9VbWR2cFRCWWlFbFRTNnRk?=
 =?utf-8?B?TFp3OHljQ2Q2OHVTRGQ5NVpaVnhwaXRMTUJzSElZSjlieVJBYjlmV2hWVVVp?=
 =?utf-8?B?VjFGd1BtM1YvQnYrKzhKRW8rKzN4bUlHK055OHJZK1lDcU5veXNLbEVqM09w?=
 =?utf-8?B?OC9rMkxVOEpPUldjUStMS0hWeGZJOWl6SkVJRVRPb3llVUo3SmR2eHFLdGNp?=
 =?utf-8?B?YTZRREljdm9kTnJPTkFmN2lTQWthZnk5cHVkeHBKSE9qMkEyWEJpQVI3cTdj?=
 =?utf-8?B?U2YxWWdjVlVBdXEzVmJsdjhFNnh1UnNZTCtkS2dEY0xNL2Z4Q2hmSExsNjlU?=
 =?utf-8?B?WU83ZzVUQ3RoWFVVS3IrL3dzRUdjdTBvaCtFK0pkVEFkS3RzbkcweVhML2hJ?=
 =?utf-8?B?VE80eUo1UEpkNk94WjFZcXExZ01SN2MyUkVRK0s4UVpidmxibmVJUXM4cFI4?=
 =?utf-8?B?Um4zdkIvMzArclVQQU9pdVV1dHd3MXluWU5iaHhQeFNGK1BoeHRVeU5pdjho?=
 =?utf-8?B?Z3EzR3NiYytHWjd3NUJ6ZG14dnRyaStoNmRLVnlMYU5IaFNqRFF2YzZ3cjhE?=
 =?utf-8?B?d3p4QWFBVkxaRzV4eTFhMTlPY2l4M3BGYXAzOC9IQUJVcUZlRWVrbElTcGFO?=
 =?utf-8?B?amZMdkhodUxJNXg2NTlrdFlhMjczeU5mNzNDeUNlakFuWGhGQkJIS0x2SGpw?=
 =?utf-8?B?c3B5aTc5cDl4dDFsTWRVL2NwWUdCQVJ1NTNlS2Y2RmRQVGE3cXJIV3hCZFRi?=
 =?utf-8?B?TkVkdHpReGY4aXc5UklpOUV0OHo3WUhjQkpLdG42RXRLclI1SGo4NFJsWXlp?=
 =?utf-8?B?bXdtNExQUXlXS3prcS91eThubnp1ZERKRTVSbm9nMml3bHB2NXJyZUZMeXZo?=
 =?utf-8?B?eWhxaWYrOFNZZUpEWWFsZGZrVlZtTXduNXdtZURlL3dYUzhLN2ZhdEcrbEhP?=
 =?utf-8?B?ZWw5TG5yTHRENTZINTNoTnJzbWlHVkRQdnFwOFNXMGRDTTZMNmFrbm45UlBa?=
 =?utf-8?B?Z2s4WCtHaG1LQXg3SHdGUWE4Y0Y5Q0s0Z0lnSXJkMS93TC80NTFSUHVvVUdn?=
 =?utf-8?B?U1lZTjdnY3hvVEQxSjNYYWFZMkhJRWlyTnBCdXNtZWNxTmUxRWJZUU5qdWl4?=
 =?utf-8?B?cDBpUXlNcE9NUjd6MDl6UndXbkUzWW8wYVI3ZnpvcGZIWVRzRGk3NUdhemJs?=
 =?utf-8?Q?CYbZCBvvXXuiu8ZVUR70OWbCcm3BZYKKHHQz1Iy?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4342.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(366007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZEJaWVZRUjhIVHhBWVZRbUhlRG5UZEppcFI1TVlIWkJCVnVsdnZDTEpEQkFC?=
 =?utf-8?B?ditGRitJUTRZQ0RYaUtESmpwRG9Da0VYMENZdkhUT3RoTkFoWm1TUXhZRFVJ?=
 =?utf-8?B?VE9vTjZyUS9iWm1BT0RJM0VES1dGajFqdXNkWjN2VEhObDMxWUIyVTRJTFAy?=
 =?utf-8?B?d3haQmVla0N1Ty9ySWEwMXpEU1NZNDI2d215ZmRKa1dPcE9CSW1pMW9lSDIr?=
 =?utf-8?B?L0JEVDNDMTBxWjA4cXQ2L0k5R09zaUZJZjRMTDYydTJzVFdNSlZPckxuWHJ5?=
 =?utf-8?B?ajhnQlVFaUhoYmt0c2I4VlZ3ZFlEZTlqeDhRblVhNmRjbXZMVm9DeHlSV1lH?=
 =?utf-8?B?R0RReVVPdWs1Qk8vSUtlaXJkZzcyMlhiaVU0a1dXTXBIbmF3N2ZST0Mzbkgz?=
 =?utf-8?B?MWQ3OEZEMEh1T2NHMjVyN2wxbGh6UTJXSGw2UzBWb1BYRjFubTg0SlZyd20x?=
 =?utf-8?B?am5IMVdvUXgzdnFKbHlOUk9ZaFFVTWw0NG8rSzhFWWRKWVBpN3BPTUVqdXF2?=
 =?utf-8?B?V1hRZUk1UU9SVXFkNVk3OE0xcWZ2cWxHYjVnNlFzVG9hTXlGYWNZaG5CNDJO?=
 =?utf-8?B?Zytoc1dzMXNKMFNOY1FBYWE2MVJnZkRBMm1WTzc5VUo3Wmc5REZtenh1OVcr?=
 =?utf-8?B?aWYwQXhGekNoTjl3cGFIK3k2WTZIUnBZbWM1WnFTRjJGb2IyWi9UakZpSmRS?=
 =?utf-8?B?QVFpY0tmZUFDcThSM2lrbVhoY0lUMjhTQ2ZMc1BVbzR4TitQa1NWYks5bFl0?=
 =?utf-8?B?WFNUekZidENMOXhPRE9jZURoWnVMYzlYVGVtQVFjYzg5aHU5NXBwZTU0TWk2?=
 =?utf-8?B?UXo4bStQQTExU21IVTBPK1NZK0ExQ3dMTitjbEJEU0dURFBnNkl0eHFyNmlz?=
 =?utf-8?B?Q2VBR0cxSHJsNm5NcG4wbEJBQVNoakdWbGZnc2lPbkRNbVBpdlhqeUlWMFFX?=
 =?utf-8?B?U3RpOTRhcHpvQ1ViQ0J3Y0lxMTBneFo1a3RFVFpnWmpOMngvWGRLWkE0Sk1l?=
 =?utf-8?B?UFlQRFJrdGNSRk9UbTJnRGhwVFA5RnozYm5nbnZKWGVtVEpvTWtiZXBIeXhr?=
 =?utf-8?B?S2R2OW0ra0RJWVpZWWIxN2ZWemVkdGhkQ1ZGbytXdE95UVJVMnhFQU1mNUN5?=
 =?utf-8?B?aTRjYitlUmJCWTBBUWlJbUZFWktyb015c1hQL0FnMlY3WCt0d3lsaFFaOEtL?=
 =?utf-8?B?OFU1YVlNTVFybmdDRTN1M2IxWEgzbkhNTExyampQSk5PWFN3WHVmS3dtUkpK?=
 =?utf-8?B?Ulcyc0F0aWk0MXBrQ1F2RVJja2JkY3FEV3dPWVdDRHJMY1RpcmpMMldzM1J4?=
 =?utf-8?B?blJVL2pncGhXdmhySlJlb2NHa2RiNndQNS8zdHdhR0ZqalBRaFBQQmNGb3ps?=
 =?utf-8?B?OGlrUjVVUnVMTnZYby9nWks2RXlzTlJOTUVJNzcrN1g5dHdUenRoT25BYUEx?=
 =?utf-8?B?SHRjd1BJWDNoQUhmRUlxTTdReGxHSXB5UituNDFCNmE0WFZDZE4zbkZaL3VT?=
 =?utf-8?B?NmpHeGVhWUhQUW1oL2RlYmtvRnpicUtWaGVVNGYzTS9jaEV0S2FjQnFIQUNl?=
 =?utf-8?B?ckwreTM0Z0ZZUkhld1Q5VUhJVjVsOWlVb2xLcWZMUGROd3VmWGZLZmhmY2o3?=
 =?utf-8?B?a1BrZ0FzMGpHQ0dSQmxqbjYvQVlieFp6clU5NGpUQlN5dGdDNms5Q0g5RTJZ?=
 =?utf-8?B?ZzFGMmFlZWdJQ2tNNDlKWi9YcG1oR1hzY0ZuUzRidlhBNWtmZklzcmkxRVlY?=
 =?utf-8?B?T0xWbDlvODVDYXBIZnE0Vm9TS214cVBQRFpLU04yRFAwcVh0UUhUdnVjS2gv?=
 =?utf-8?B?aGhOVHZHNHg1T0I3TUxiVTU2dmo3eWU5bFlTMlAwbzJOcnRYeU9kWTVlNFNu?=
 =?utf-8?B?dGpDRGsyVFQzM1hwWm56aS8zQUp6dWNwTmI3Z2s2M0hDQlkxalg0Zm95Sloy?=
 =?utf-8?B?ckFucTRYV3hENkdqWmVkbnYyTlB3WCt6cExhNXNIYTVDNDdkeDlMc3hMTmQw?=
 =?utf-8?B?bU9QMmhoTDdaQzJ5djNVTGxFRGJuOGUyd29uRHY4Tjk3dEFqcU9qTFFZRDVq?=
 =?utf-8?B?SFpLWU1laHNpSlpCRWM0MUI0YUhuaGhKOGlxaTZUSGY0NGNLYjAvdWlqb1hJ?=
 =?utf-8?Q?ZXUKzgt1HLuRxLBDOoSihHONR?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1c1f3f3-070c-411d-55ea-08dc898048a4
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4342.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2024 19:05:24.8817 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Lk/0R2exIkYJlO+8hQUJ9Uku8HsGgQspNh7wrZtQefzRvEaYSKYbuQTyghnXaXsCKdrVK9OHwYp3hOASBT5VSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7466
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

Hi Christian,

On 6/10/2024 11:35 PM, Christian König wrote:
> Am 10.06.24 um 20:04 schrieb Arunpravin Paneer Selvam:
>> This happens when the amdgpu_bo_release_notify running
>> before amdgpu_ttm_set_buffer_funcs_status set the buffer
>> funcs to enabled.
>>
>> check the buffer funcs enablement before calling the fill
>> buffer memory.
>>
>> v2:(Christian)
>>    - Apply it only for GEM buffers and since GEM buffers are only
>>      allocated/freed while the driver is loaded we never run into
>>      the issue to clear with buffer funcs disabled.
>>
>> v3:(Mario)
>>    - drop the stable tag as this will presumably go into a
>>      -fixes PR for 6.10
>>
>> Log snip:
>> *ERROR* Trying to clear memory with ring turned off.
>> RIP: 0010:amdgpu_bo_release_notify+0x201/0x220 [amdgpu]
>>
>> Fixes: a68c7eaa7a8f ("drm/amdgpu: Enable clear page functionality")
>> Signed-off-by: Arunpravin Paneer Selvam 
>> <Arunpravin.PaneerSelvam@amd.com>
>> Reviewed-by: Christian König <christian.koenig@amd.com>
>> Tested-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
>> Tested-by: Richard Gong <richard.gong@amd.com>
>> Suggested-by: Christian König <christian.koenig@amd.com>
>
> Please push to drm-misc-fixes ASAP.
I pushed into drm-misc-fixes.

Thanks,
Arun
>
> Thanks,
> Christian.
>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c    | 1 +
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 2 --
>>   2 files changed, 1 insertion(+), 2 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
>> index 67c234bcf89f..3adaa4670103 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
>> @@ -108,6 +108,7 @@ int amdgpu_gem_object_create(struct amdgpu_device 
>> *adev, unsigned long size,
>>         memset(&bp, 0, sizeof(bp));
>>       *obj = NULL;
>> +    flags |= AMDGPU_GEM_CREATE_VRAM_WIPE_ON_RELEASE;
>>         bp.size = size;
>>       bp.byte_align = alignment;
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>> index 8d8c39be6129..c556c8b653fa 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>> @@ -604,8 +604,6 @@ int amdgpu_bo_create(struct amdgpu_device *adev,
>>       if (!amdgpu_bo_support_uswc(bo->flags))
>>           bo->flags &= ~AMDGPU_GEM_CREATE_CPU_GTT_USWC;
>>   -    bo->flags |= AMDGPU_GEM_CREATE_VRAM_WIPE_ON_RELEASE;
>> -
>>       bo->tbo.bdev = &adev->mman.bdev;
>>       if (bp->domain & (AMDGPU_GEM_DOMAIN_GWS | AMDGPU_GEM_DOMAIN_OA |
>>                 AMDGPU_GEM_DOMAIN_GDS))
>

