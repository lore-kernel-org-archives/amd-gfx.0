Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED11FCD128A
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Apr 2024 19:49:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7976A112836;
	Wed,  3 Apr 2024 19:49:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5IfGhIso";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2122.outbound.protection.outlook.com [40.107.100.122])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 48F18112836
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 Apr 2024 19:49:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZnWnIln4cMJ5yfXovASLOKXot+AiyF89WZDCaVMvTHuqbCK5wzCd1gBogSkuJiUHyp0n/9jdOMQQJZcnvOHDrZoJ+BUHbfAIteUfFYFOgVtGIHgStxwX9ZbfKsXdiAp0Ld9Ld3ZmU2sGt2jzh9FmKHjV2D/U53JqIPNGnyW24xB3OYu5K0p00VjDJSDYtsWiJqpjQNobkq31SpJAJcxGaJzor2zrZTea98ZlpuXNff3+ySN75PME9eNR8elCgXOSJ/g29hKVpq0sgmmOyqD0RWi3RBQhoUVsO9K03dR9GHH1dgUqvld8Nw92QM0TUOmY+UzSfmjGODekXDwZ5xv/Jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=53Lzyc2QOqVUuIX+d7hMYHiToSFDJQ07fHnhTC3iav4=;
 b=Tm4aChlY6/SO4PP+bK2Ahk3HA/fsiddtih7I8pKyiy3D+rtc6rHa4RZWOjbqQXG3YjiAO3JecaXy7+rUAmEKqAR6s885f1TNmCyyKZiHqFjYA91G/UE2AEaJ3Z1gNHyMpK6J0UmZjmqAlkjW5kwqXmT81VZSGPUc3fuHFlc8Lttn7JV6BF3dAHIWNba+iQVSjazcz58/iSWZl7EPPJo2MKVeqgUM6koapTJ71USOS1/DWJj/ngUVUJIH81UQbgOcCROe5sTSXlPwiMJpBAuSSgZuVE0W77ElaJty8HB2j8HhsnR73uF2Q3G2+C93II1bq3zTdEZnWad21+EGbR5Gfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=53Lzyc2QOqVUuIX+d7hMYHiToSFDJQ07fHnhTC3iav4=;
 b=5IfGhIsov5QMHmaqdU0kCYSg0DvR4uPg5abzoV5uvQ6lJMWNBHgrukpUM3Hq+nsrjyaJfsvCB71fFrPVAsltjGUfi94Su0C/mls5fVbqiZ1ktEn4l0EZ075oRkLaH3LWT1KUUwbpJJrJHlPw5FIwHlCi3xw52rZYAkoN/dTc8UU=
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by DM4PR12MB8451.namprd12.prod.outlook.com (2603:10b6:8:182::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Wed, 3 Apr
 2024 19:49:38 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::8099:8c89:7b48:beed]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::8099:8c89:7b48:beed%7]) with mapi id 15.20.7409.042; Wed, 3 Apr 2024
 19:49:38 +0000
Message-ID: <77bc4a6f-2a9c-49f5-a8fc-ffb3b6c2157c@amd.com>
Date: Wed, 3 Apr 2024 15:49:35 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] amd/amdkfd: sync all devices to wait all processes
 being evicted
To: Zhigang Luo <Zhigang.Luo@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Hawking.Zhang@amd.com, Sashank.Saye@amd.com, Jeffrey.Chan@amd.com,
 philip.yang@amd.com, lijo.lazar@amd.com
References: <20240403181223.25079-1-Zhigang.Luo@amd.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20240403181223.25079-1-Zhigang.Luo@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0306.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:6d::28) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|DM4PR12MB8451:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5jAJRRGg1H2VHg52dCLoWIxhqDzbokTCiW4xoq56lvQ1081TMCHtiIGrZFye86tAaAK6mi30CdULoUlwmeLGTOv/2v3knra61FdtOwB7BuFbcg0y0kUK7NLsMvkUY1Xg/K97o6vxAymCjjTJHydHxzBGif+fE6PbgGibCUL8isLXzFQ/ky9ttgJ2c7BlV/N47BIpA5mliAA61QwU++g6UhjDBadVmA9ob7g3XVUDiS50g+1LS/yxBM0e5rwsljXZAWNwujMqS97oYSwcvh47k7DDuelEsTQlO9QnopjgGCRSMOMwRQvCOgA1Wx0OTiH4qBAQghkNZG10wtSK5vYQrJIF5yGklThfIhKDpQas4xYt1hA6UEo6F+nSXZNSm9+cvHMv0VHicFGWk5rwaHKGgO8f8i/PnIzT1jR9M1eFG/y7rL2Sq5D9JmnfvVpjLMFQ6ETZCAVorD9hqWR+FWPqmCnPPOJN8Pvloh2WG98NDyGzhdvtpKkSv5w+1hAV2U9otc4MmuToAewIFFuZTbHL5Vc2TN94VF2t1NCKVtwV9bAH1DF1QKsxaYOOBuBweOkZ+AcyHAJDgdKhVtN3UWIZw6v4Tls2w9ZU4Ywwdh//G9gSnU+q9xzVyYo+PVSKbji+Vcr+2+h/iUf62jQzg+rZHadhyUtPB5hjyCa27j8ZPD8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(366007); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aEFGOGgrM3FMUFo5WmcrUk04bnNnbUdhcmhpQ0xlRFN1YUpUTE0wcXdPbG5Y?=
 =?utf-8?B?OTdQRzlHOWMyaUM2MFNoSFZxc0Z4WTZqZzQ5M1F4Njd6RWNoZCtzdUFZb2Nh?=
 =?utf-8?B?TGFNNXBFYzU1SG90QWE4ODFPY05XVlJyMjdabGZKMFppV0FuQ0drUko1dGxj?=
 =?utf-8?B?SEFrVS9HaDMyRm1aQ24xNnhOVi85aitpUUI3TkpCb1JlV05VN01aZlA5aHcx?=
 =?utf-8?B?U2lWRVUzcVlIeGp6Rm81UWxMdWtta09YaExnRlkzNzVYQ2l5RTF5ZzE3TDQ5?=
 =?utf-8?B?NU5zTXVvSSswTmxvS0JZcHlUSkZzUFgvMWZLODJ3Q1Avclg5L3I0UE9sazZt?=
 =?utf-8?B?QkxJUEV0U0FaVFNsVDlJMU1SdlZoazY4dW5Xc2Rpc0VnS00vbWlwc0VNOW9M?=
 =?utf-8?B?QURaMEs0N1ovOWo2SS9NdVpyUkJFa293Z2ZOdVR2MitDTnhJRmRRUEtTOE5J?=
 =?utf-8?B?TkVrbmlyTFhVQUJXbXV2WjNMYmFDSnByUWp0elJoQjc2WmdsTTM3eTNRam1C?=
 =?utf-8?B?SlNXQU5Wd2x3Z2xoQ2lZUXUxSFFGc0ZKYlVkOFVtMy9kQ1REKzlOUjdUTU1Z?=
 =?utf-8?B?OU1LUGw0OXM2QXgvNzRNZVFmNjRMNFk2ekFBaEd3UGZqdGJVREtCSW1qS25q?=
 =?utf-8?B?VE5QU1Zya3RtaHJBSC90bkJseFZkQkdMbVhPTWpGSXJ6QjNtK2pLQ1kzY2lw?=
 =?utf-8?B?SFpJRFI0ZGFQNG1SR1o5WjdaTTBUWkUydXd4UjlLVUI2YXk2a0djc1ljTnMw?=
 =?utf-8?B?MEhyWG1CbExmUHhGUi9oWGxIdUR4OWtTNnB0SU1vdlAvYXlsU2NIdGxyM0ww?=
 =?utf-8?B?R2EvYUUrZEp0bEF2UUhXenVldWtHS083Q2tZSTV2Yk9iSW40ZEJ1WFB5ZlR5?=
 =?utf-8?B?VnRkSFFRRC9BcXpUODRUL3ZKUW1zWC9yck10U05jQmRuUTQ5MEl4d0kzbDkr?=
 =?utf-8?B?R3VZQ1BQZ2hpTGlQU0hZeWVIUEkrYTZ3WmRRRnBma3RNK2k0clZvNVQ0aXNR?=
 =?utf-8?B?b0ZvSW1FUFJNcDZpZVZGSEtLN0Y4MHo4aXR0N21BelVCR0tCWDlXaDdlNmhp?=
 =?utf-8?B?aGNBMTA1SGlWUnl0ellIR2UySDhkR0VkWkFHYWZBQzhqQ2tzWnRZT0RrVU5x?=
 =?utf-8?B?czJYdkVSYnpNeUdxV21FSk9BemYreVpRL3c4cEJvd2FCL0NNUis2WWcrUFR5?=
 =?utf-8?B?VURnZ3hZU2NFYUtFaHk1RVo1V3dOa2xUZTlEZmgyTi9lQmhYWGhIZWltQWFy?=
 =?utf-8?B?NVl6Rnd4TmJnc1RXd3lST2I5a0phMlAydjg4T0p0Wk40QVZxK3JRK3IrRW1W?=
 =?utf-8?B?K3hyYTd2aGtrUVpCS1o4UytHUy9HYXhLdzJLQmgyT2JrVzQyWTZMMXlocFd5?=
 =?utf-8?B?dnBKUmsrOG5UZGNwOU5uTEhBbzV2OWcreTl0cnlucXBHUm80eXFjWkR2WUxT?=
 =?utf-8?B?Tmg5NkFwL2ltSnMwNjNCbTBZQ1BDeW5kbEErRVBKTVk2QUs5MGZTVDFxdHlO?=
 =?utf-8?B?Z1R5eDJKZzQ2aCtMVEFKeHlnek1NOXRVeXJZMWhSYWkvNFpwQjk3WnNycFZj?=
 =?utf-8?B?YkJzRXI3T3RhOGFUSHV6L1hWVnRlMXhVenhjSnFybHJndjFXaGlETVdOSkN5?=
 =?utf-8?B?ZlpOamozODgzR0Nla3dVKzZNck11QWVjMFZLOEtFdjh4bHFvdnpuaDNMSEls?=
 =?utf-8?B?dzJ2Ymtua3R0cFlSRHlOamFmc0FOUWErTUFLdmhhWkNoY24ydktoSU5uVStD?=
 =?utf-8?B?VjRtbXFBVlRJT3dYaFZwbUxEUGVKa2tvbHVMTkgzMHZ5RVlNRGJpN0o3R0FI?=
 =?utf-8?B?T3BDbjliYmJLanhpNXVIcC9oUm5tVkJlYlRIcURuVFBwb28xV29zMVNYSzRL?=
 =?utf-8?B?UEszZFVHUFgwVDZ6YTFlVllOS0IxcitGRzdpVUdOOEROSDFNYXR0SFZvZXFh?=
 =?utf-8?B?eTU4Si9lbHZkajg4SXM3Vnd2N0ZoTzhRanJMRkFnN3VyQmZKMHlLSzdCWG54?=
 =?utf-8?B?NU8yaHRWY21QVERYdmNpMVNXcjZ1WlZHbjV6aDdLaGpEeTZzMzBSRG5RaHk2?=
 =?utf-8?B?OUVtaUNlYWM2UWtHRkxHMzJPSjdEOSs2a0gvR01CVVZuTWFMYXRtR0ZFSEti?=
 =?utf-8?Q?wHQY5mInm7LFyIgkC6TD7ODdp?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93dce6f8-004f-45f9-eca7-08dc54173276
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2024 19:49:38.8919 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HTZKpj98qcf9vbg7STf5EVzUhH1xHCdtEjM3oKqPyc8KlxeqgxRXy37ufxlnayy0RyYMiGwRrxa7wYM63tvKjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8451
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


On 2024-04-03 14:12, Zhigang Luo wrote:
> If there are more than one device doing reset in parallel, the first
> device will call kfd_suspend_all_processes() to evict all processes
> on all devices, this call takes time to finish. other device will
> start reset and recover without waiting. if the process has not been
> evicted before doing recover, it will be restored, then caused page
> fault.
>
> Signed-off-by: Zhigang Luo <Zhigang.Luo@amd.com>

This patch is

Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>


> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_device.c | 17 ++++++-----------
>   1 file changed, 6 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> index 041ec3de55e7..719d6d365e15 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> @@ -960,7 +960,6 @@ void kgd2kfd_suspend(struct kfd_dev *kfd, bool run_pm)
>   {
>   	struct kfd_node *node;
>   	int i;
> -	int count;
>   
>   	if (!kfd->init_complete)
>   		return;
> @@ -968,12 +967,10 @@ void kgd2kfd_suspend(struct kfd_dev *kfd, bool run_pm)
>   	/* for runtime suspend, skip locking kfd */
>   	if (!run_pm) {
>   		mutex_lock(&kfd_processes_mutex);
> -		count = ++kfd_locked;
> -		mutex_unlock(&kfd_processes_mutex);
> -
>   		/* For first KFD device suspend all the KFD processes */
> -		if (count == 1)
> +		if (++kfd_locked == 1)
>   			kfd_suspend_all_processes();
> +		mutex_unlock(&kfd_processes_mutex);
>   	}
>   
>   	for (i = 0; i < kfd->num_nodes; i++) {
> @@ -984,7 +981,7 @@ void kgd2kfd_suspend(struct kfd_dev *kfd, bool run_pm)
>   
>   int kgd2kfd_resume(struct kfd_dev *kfd, bool run_pm)
>   {
> -	int ret, count, i;
> +	int ret, i;
>   
>   	if (!kfd->init_complete)
>   		return 0;
> @@ -998,12 +995,10 @@ int kgd2kfd_resume(struct kfd_dev *kfd, bool run_pm)
>   	/* for runtime resume, skip unlocking kfd */
>   	if (!run_pm) {
>   		mutex_lock(&kfd_processes_mutex);
> -		count = --kfd_locked;
> -		mutex_unlock(&kfd_processes_mutex);
> -
> -		WARN_ONCE(count < 0, "KFD suspend / resume ref. error");
> -		if (count == 0)
> +		if (--kfd_locked == 0)
>   			ret = kfd_resume_all_processes();
> +		WARN_ONCE(kfd_locked < 0, "KFD suspend / resume ref. error");
> +		mutex_unlock(&kfd_processes_mutex);
>   	}
>   
>   	return ret;
