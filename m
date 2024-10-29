Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5089DD5B870
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Oct 2024 03:44:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 77FDA10E0C6;
	Tue, 29 Oct 2024 03:44:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0fg/U+3I";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2076.outbound.protection.outlook.com [40.107.94.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EA56D10E0C6
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Oct 2024 03:44:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ze9ok4lxkSXtlg3TsmU+FCjosBQlA6HR7I7rYq06eibG9swY0O/Zrx3ZPYcUsbZs89evgsM9Ket6MnKaWfwJK+4DWupkqv76ermQyRkoUh02BbkJn6FBskQnfB0czmNSNMuduGP5H4rsfD4w6Oj2h7wf/Xfq81renB7CK/z98eu6XDA1O9ryqeVwdFDx/UewsI1TBfCVlPyzxu1HCKPGhDLTnscdjvW9w2ZnpdQqMYw1HFpUiIdnTjBCWBqnK3i6E5Q3TGK8Ea9VEhYPJS7hSnxJwcGkwthqCkl/JB3m+0v29QWOFUG8YqjL9B2564VCdosPEEUhNctEpqvkGMo+eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ygIoJPLXdFIPUAv1nQJvPw5VcFQ6en4Aqe2SgrAlmw0=;
 b=GJYyv6wUnZ8S+hycjOffXdJVnZCgOwNQcr/G127uVetKMZC/lgLe9ev8L3JIC7/VIgd8Vk3QkiKI/hPf6ySj/LSWiVp+bP6GlKf9ZCx2DLLKNFnTzL5Do54c7DDIX3Gc0qYSuaqBShjWqQeGawIgiajBvojvER7zUJzXqrbAYWn+qmpph71MHe0G1TtM+Q0iiu/G4OCUlgPG4OKVbhSwLR01ZyMFcMdD9MLXv3RwDsBZdZrEwUTq5qAbvkLPMR2LCfmMeUu0i9KQiH9cNEraWHxYaNS7jh9bw4i7ABAX3kpYhFsTfPx2dRse+ebOJb5UByhlrXd5ex4FpgtcFBBfOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ygIoJPLXdFIPUAv1nQJvPw5VcFQ6en4Aqe2SgrAlmw0=;
 b=0fg/U+3I7dTA6GGRKftRzcZAe+7s+tazFcmuGMVJA3oNEE8NdtsA7M0VfBaWHNclX+JWQkVNjY4I014RtfqxHo9QPUXhi/wMzZQj4SPZXoRw0OP2XkuVwjqz54x9E+7awV4atWN8EliYfV2dTpPTNC02UE3/3iRHZGkBY1s991o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 PH7PR12MB7379.namprd12.prod.outlook.com (2603:10b6:510:20e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.27; Tue, 29 Oct
 2024 03:44:41 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%5]) with mapi id 15.20.8093.023; Tue, 29 Oct 2024
 03:44:40 +0000
Message-ID: <e8d7fd9f-322a-4ede-8cf0-fe1ab5b4345d@amd.com>
Date: Tue, 29 Oct 2024 09:14:33 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: add ring reset messages
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Kent Russell <kent.russell@amd.com>
References: <20241028165136.4112276-1-alexander.deucher@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20241028165136.4112276-1-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BMXPR01CA0094.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:54::34) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|PH7PR12MB7379:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f30cb14-4d0a-4cb6-1b83-08dcf7cc04a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bDBDZC9JblUrSEtjU0o0dDVqcTFzZm83QUVtaGx5bnZBcU9Hd0NMTUhEdFlZ?=
 =?utf-8?B?NXhOSVpxSVZkaGMwVlRCZ3dYcHJ4ZEVGU1k0bVZoTS9VWGJEOXFoZnFjV0FD?=
 =?utf-8?B?U1FpVlFvekppeGtFbmRhMVBZSnZYSzM0WW82VkpKYzdrbkNPWWZ6RkppakU0?=
 =?utf-8?B?YnkwWFVoL1JMZ2lyRkpsOFVwcm5TTCtQSnNBSG0zUjZyQk01Ny9jSTdvcjhT?=
 =?utf-8?B?ZmJwSHUrbWJiSHRIUFNaN1B2QVF2WXVob0M2eWtvNFZXblc0UlVSSjJ1S3ZO?=
 =?utf-8?B?NjFKV0RDeFF4V2RCZ3FpVXIycG5vb1o5TDJTTy9SdjBCWllndXBRSkdtNFFy?=
 =?utf-8?B?K1U2VmlkQittK040eHBOM0NGS3lWRng1WnkrVkU5M3ZhU2RPNzA4RXhaV1ZK?=
 =?utf-8?B?OEpidFo2YjlDMlVBdUxsczhSQkVLS3hGRkJTNlp5ZjVYQmpxOVZWcEdiMlE4?=
 =?utf-8?B?d2FTT1Q4T0EvOGt4TEVhUFZ4dVRscGdqMy8rWm1nU3cwRTgrWjM3cmxnc2Nm?=
 =?utf-8?B?alBWK3l5SWM2SXhhcXhXQkNGSnE5ZkpCNnZ0emlxeVBLZ3JXY1JKU1hCaUpX?=
 =?utf-8?B?eWtsU21WQzhyQUhHWVUreGdrMFhuaWtDSUhIamRkTnhWOTlrS2RCdzZGLytD?=
 =?utf-8?B?OEw5eHhHbm9RbmQ0bEI0WmVGcGZ3MEhkWVliYTNHOFRzZ1paMHNEQTg1YitZ?=
 =?utf-8?B?WGliVWFPQkJVS2pWUXoyeHhTbDE5SXV3OWNYSnNzbVBEaEpFaGpQc0VIWm8x?=
 =?utf-8?B?Q250dXQ1dUtSZ2RXY3YzaC83aHE4ZUpHd3ZXeXZBb3JFbFppbzZnV2RUeDRy?=
 =?utf-8?B?MWV1NEZyTzYzYUszdVgzOHdXSUtiQW5tSW1lMWs0QWdlTVRWL3BIWjR2R0cy?=
 =?utf-8?B?cVBoTTVKNE1qSDhibjBLSzB3MS8vd3dLSVhOZU5QMDFMRGlqNlE4a3pkUVln?=
 =?utf-8?B?M2lFeWVyeTJpVWpRanQzb2tuMFlvTFF5ZDRYb1pKNGtIUU9lRWV0Z1JLRkxB?=
 =?utf-8?B?dnIzR294K1ROSTUzampHaTFPaWR2aXNRL0ZPTm45NFdGKzY2bXlFcXFvSVZQ?=
 =?utf-8?B?Q3NyRVhSZVJTbGljenRGOHYvM05oYnBPbXFZRlY5TDNIWm45dFJ3MXdaRHFR?=
 =?utf-8?B?eEJaY2FGbDVTRVd6emFOSEJRRVg4cFU1Y1FNSFFhZlQrb0NQSTRacUFYUmpo?=
 =?utf-8?B?K3M2T1JEcDRlaUtBYlkrVzZZQzZDNkV2UzVwY3RFQ1pnK21aUlFwdjZNOFpz?=
 =?utf-8?B?Qi9JTCs0TlZxeTRTZWZHV21PaktpSmhPdzRuZk93VmJ0QVFLTnRPbVBaSVJL?=
 =?utf-8?B?bkxwZ0tObUlJakJJOXIzRVl6dHJ1MVAxVll3T0Nra09tbFpkQlpUQmo2MkRs?=
 =?utf-8?B?c1VQY0JFUUFVQTZyRmFFUjJKa3Rmd1BsUGtNZEU5MjJIU1pQODg1eGZ3aG1i?=
 =?utf-8?B?VW1XVXN1VFdGelRtZkh1bXhYUjQrbGdMREtUVmlpcnJqYU91SXdOWm16c0cw?=
 =?utf-8?B?RW4wWEpWdnZEWVhsenZ6QjNYRkZzS3JUYjZjeWp1V3FZMGRIdzNHQzRQZ25K?=
 =?utf-8?B?L3hpVzRST21qU3BraUttTFB4QllsMWp2b2V1M01mb1BsNXpIekhpRmV6TEFr?=
 =?utf-8?B?aXZGaHlHUGVWcGxFWllCemUydk5MQ056UnZoK3NMYnEyRk1KblB2eGVQcFJh?=
 =?utf-8?B?RERKY3dXNCtrL1BIN3ZYL0ZmYmI1cWJYU1k1ZllCUGpJVHQxaHVHd0pyRU54?=
 =?utf-8?Q?D2jr6fOTkTRJJJG4GZwsMFULWiOZzOnZzrKI35X?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SUhUdXU1cWJHNzR0d1hNOVBtcjR6elRseXlSZjA5V3F1SlZ1Zk5TODdjd0Z0?=
 =?utf-8?B?OVdJMlNiWnFqekIxWWRQTGNueTM1NndGQk9YWTl0QTE5UDhzdEN3ZzhjNFdr?=
 =?utf-8?B?S0NQTThSME9leFBFZnJzRDBPU3k1TTdtbGRidE56a1dlY1NNazl2cWM3aVJO?=
 =?utf-8?B?Slg1MWx0OVFpTUc4ejhHQ0kxZXZsLzlUS1pqK2RwSVNONDJ0WCtHMWZTbXdR?=
 =?utf-8?B?RnNWRUE4cit3Y3Y5VmU1SEROUlhhUHM5UlNjNWowYnplbDByU2JGYzM0SmQ1?=
 =?utf-8?B?d2ZwNXZ0VzJkS3k4cFBId3lhY3FMUXdwS09NanQ4K2M5Y2I0Q2ZkT3hQdEFm?=
 =?utf-8?B?bG5VSzBiR3Z0Y2NPZzczRUNOdDhvM0xReFZhUldTR0E0K0RJSTJOV2FuYi9N?=
 =?utf-8?B?Y1Z5WTlPcUVqbC9sQTkxRkRzVXhqM3BLdkxrZmZwSUVyR3ExWVFHZmxueVRU?=
 =?utf-8?B?Z2l2VDFxUWVYU09pSWJWZFRrSzhTTmZVTUdnaHZLbVJkaGk4bVN3M0hINmFk?=
 =?utf-8?B?V05LdWJxcldxeURBdHJyUFJYUldWd2VvQWlCNlc0WDNUaHRIbU5QUVdHYVNW?=
 =?utf-8?B?RDdrRDlWOWNKaWFzZzRjaDhqQmhwa2dHcHBEdExsblNvV2x3cTYyb3p1TXVP?=
 =?utf-8?B?RmxveUFFNXR4VG9KbE0zSXc5UThZd2RrYTZsODg5V0FWU3pDTkEwNnJnRDJl?=
 =?utf-8?B?ZmVlcFBLMHBNSU9zMXRvSDNpanEwbmh6WDBjbEUrQWN2eFNobmlnMFRVVENJ?=
 =?utf-8?B?L1d4TG54UGs1STlzVnFmMTVyVit5TXZEVEVVdnhaQmNCSG1SVHNjWERkVlFM?=
 =?utf-8?B?YVNYbXRFTmlDMmpVVzN0VHdhWGZNMEowcitGanA4V3dtdVVaZ3VLYWJmdnht?=
 =?utf-8?B?NkJhSlFtT05aZEgrcFdWN0JrUGhFQTBoMElJdXpEc05jclQ3bGxCTWdOZHBT?=
 =?utf-8?B?dzdvT25acWhiNGUvQ2djL1dSS3hjMnZyQlZSQmEvRGtUa2dZZWJnbGRSbGVh?=
 =?utf-8?B?N3E3OUlrWStoNVE5MHRKcTc4N0wyS0dYT09Hb1ZEbE43NmgxVER4Q3k4czIz?=
 =?utf-8?B?b0FWR1FXajE1aUpQYWNFZnV6a1NmWjM3Q1Q2LzBEcmVJWENrTGswZ2NKV3N2?=
 =?utf-8?B?NTFqU21HNjh2RGJGdTZnakczd1I2RVo0KyswVGQvN0hsaDhOalRHQUFaZk9X?=
 =?utf-8?B?b1d6dGtuNWxaMVRPU1YzdHVxMlQvNmMva2M4ejNicGp0d3hVTGw0NWIxRWhC?=
 =?utf-8?B?V01MVFZMV2cxRGlkOGdIaXd3bTZDUnk0UjJPQjU3VzRpYnVtYnVxakdHWnEr?=
 =?utf-8?B?R2pSMFQ2UXNVVTZqY1ZWY2V3YTg3QVhaK3FqZTNLN0xPRXpXeXhSQXVxbGlR?=
 =?utf-8?B?NEFtWWExQkJjdHdCdFVoNUplZ09Xdmg5NzFjT2dIQUdMOWJ0a1FhcTlrVHJQ?=
 =?utf-8?B?ejFiaUZHbFU1dnBwVVBQemNzZ0NhelU3VldEdFhsYi9YcU1NanUrdUxkTitS?=
 =?utf-8?B?WnBLY3NQNUtaTkZ0cElNczRORktFQlFobDMrbGVWZlZ4NFF6TUlpZU4xM1JK?=
 =?utf-8?B?UERvbithQWhzbUxHTkdPQUt4bndpb1ZPVlorR1NoSVBaZnRmaWpjSmErVTl6?=
 =?utf-8?B?a0pmQ0F6dVlHY0h2QzhvK2RnYzFuMk5zV3JVTjFKdnZUb0xacnlUL29LaXMw?=
 =?utf-8?B?YmdQSEFzU0Z0SDV6QVlkYVR6VzBUUXNVNzNjNWU0UUtFdHkzb1FSRmwyQjY3?=
 =?utf-8?B?UFhKL3V3OU5SdFZUckJqU2xkQzBiTTRyV3ZYUTZUZE1ka1JEN3ZDdVROekxN?=
 =?utf-8?B?cDZsanhDQU94TGJFa0J4VUxkSU9QSFQ5VHF2aWl0K2MvNlZ1QXh3emMrcHVr?=
 =?utf-8?B?b3NlR2tGN2tUSEEyTVRMb0xYckFiRzJZQzFiMnRSOWF4VFBFQS9wZGh6UFdR?=
 =?utf-8?B?MWxCVU02b3hxZHptS3FSQmVkMjgwZU5nM2RDcGpJNkNWZUdjNFdIVjRaYzR3?=
 =?utf-8?B?ckozeEl4aUxPc3BBZVkxRW55NWxnOHZBN2xHZ1g2RERkOG5Ndkc3Z3lxbWtQ?=
 =?utf-8?B?NUhvL3d3NjdEci9qQWRpZkpGZEFxM3YyTFdiQllKYlNOT0J6RUhvdDBrQzRk?=
 =?utf-8?Q?r7PyR/V2wBFxpvEPXKxhthPGi?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f30cb14-4d0a-4cb6-1b83-08dcf7cc04a1
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2024 03:44:40.6189 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SccHIjni5Fc7/L4LGL43tQmz36nMHk1Iorz3e5xB8Jbx/myFZyw2XRJ+FQCIBKhc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7379
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



On 10/28/2024 10:21 PM, Alex Deucher wrote:
> Add messages to make it clear when a per ring reset
> happens.  This is helpful for debugging and aligns with
> other reset methods.
> 
> v2: add ring name in success/fail messages (Lijo)
> 
> Reviewed-by: Kent Russell <kent.russell@amd.com> (v1)
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

Probably, will need a followup to keep reset messages at consistent
level. For device reset/recovery, it's at info level now.

Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_job.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> index 717adcedf096..9b322569255e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> @@ -137,6 +137,7 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(struct drm_sched_job *s_job)
>  	/* attempt a per ring reset */
>  	if (amdgpu_gpu_recovery &&
>  	    ring->funcs->reset) {
> +		dev_err(adev->dev, "Starting %s ring reset\n", s_job->sched->name);
>  		/* stop the scheduler, but don't mess with the
>  		 * bad job yet because if ring reset fails
>  		 * we'll fall back to full GPU reset.
> @@ -150,8 +151,10 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(struct drm_sched_job *s_job)
>  			amdgpu_fence_driver_force_completion(ring);
>  			if (amdgpu_ring_sched_ready(ring))
>  				drm_sched_start(&ring->sched, true);
> +			dev_err(adev->dev, "Ring %s reset success\n", ring->sched.name);
>  			goto exit;
>  		}
> +		dev_err(adev->dev, "Ring %s reset failure\n", ring->sched.name);
>  	}
>  
>  	if (amdgpu_device_should_recover_gpu(ring->adev)) {
