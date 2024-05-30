Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1CF3C25B74
	for <amd-gfx@archiver.kernel.org>; Thu, 30 May 2024 20:41:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2A03F12BACA;
	Thu, 30 May 2024 20:41:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qYcckizq";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2051.outbound.protection.outlook.com [40.107.244.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 369E012BACA
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 May 2024 20:41:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LWnHriE2CqBxhA8Xd7CTpvqKZGOVj+CjcxJYrhB2T8dTe437JKdIQDD56JCmWM1uNI4sS5Li3+2R0HK5fVza7AR+/41fnL3gcnPwk9+NM2WNjx21pEJaSAjELeFiumVkULO7FFXZM8dlVlMqKeYoeWAFqLBBTO5sds37EIooOvWP/m5X8sbvVyo25S/nC9l0tXoaCxG0ogW3P4Bkrw8/R69IQwPsnjxKenWtyOz1qatUNLm5X55ZWVfgxhHu0GSEYjmY0OCX9/u4CmrNd1WfyzXjcGgi6mfO/24ozj2HyzoqnQTlDud0dnS2Mv5LtXkqkX5mf3HiNkHjGdE9EiKEaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fGSQzLdkdaOz8tWuJk4jhOwXc01rGrGpmVhmSunxBXY=;
 b=HgbqbINIB/wx+uPuqfi7xv5gxxgYWobCchrM5ZJrt3HGMlYs7Nnl9fMBMyZyvnPHpDTmCcR5VhWTxr3rSJa+/zIvAHZxs3GTj1IL8/YtgdTBMr5wRAQ761FrM40lyAVlTamdIv9sJ21REhvGVC76JSyym+xCDnHhzJTfvs7BW9zsJBKajHRpQkGwNRGSDlrkW0pNI8YziKbqDZaYlRE8Q4+S3E6Z7ruhuJsj5yuRsBsoGOu2rLTbgsPI6atxoPXBcAr54nnlTfqke/0/z2AiU2U6lzJNxE45gnxPfnXqRnH0/fjcRTi7auh8q4tERlE9g+Hjbl9ISQPcO3APQQWbrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fGSQzLdkdaOz8tWuJk4jhOwXc01rGrGpmVhmSunxBXY=;
 b=qYcckizqcnYqx+uUT2dbMC65zfQTNJUNMmAhschdbmKSwOx26R9yI1b9swf4ZB3wSkIdM7vk2L4cp2qjnLeWHBtP/wgP+mA0eOkSXhoXgX0UQD2J8aSEN99GBvV74Mr+kPXFgX4+tcGp3NwJcUtvU+o337AwqwCBz/ptG5028V8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by SJ2PR12MB7893.namprd12.prod.outlook.com (2603:10b6:a03:4cc::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.21; Thu, 30 May
 2024 20:41:52 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81%4]) with mapi id 15.20.7633.018; Thu, 30 May 2024
 20:41:52 +0000
Message-ID: <c28025c5-9b10-46cb-a782-4fb7d7ea7e0f@amd.com>
Date: Thu, 30 May 2024 16:41:50 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/8] drm/amdkfd: fix overflow for the function
 criu_restore_bos
To: Jesse Zhang <jesse.zhang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, Christian Koenig <christian.koenig@amd.com>,
 jonathan.kim@amd.com, Tim.Huang@amd.com
References: <20240530034744.2341224-1-jesse.zhang@amd.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20240530034744.2341224-1-jesse.zhang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR0101CA0022.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00::35) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|SJ2PR12MB7893:EE_
X-MS-Office365-Filtering-Correlation-Id: 9dfa6a29-1285-428d-4075-08dc80e8ef9f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|1800799015;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VzNscGpiODlmS2dJMU5mb0Zhdk9qZ1VpOXg0c2Y4Q3FLTVZwRXhydndGaUV0?=
 =?utf-8?B?OFpiSGx1bFU1SndPMUxYa2xHSndacnY2VHN2dVBQdEFNVDFkQTcvbjRSQnBp?=
 =?utf-8?B?ek5uM3lEYXh2NkJlSVlhWnlJbHlTSEUvcS9sa2lZdU40SjNJcTZDTTBCZS9j?=
 =?utf-8?B?bEU5QWpmWDR6Z2xvY2oxS1RIK2RKWjZPM1JxYmc5eURadG9OU25QS2JaWkUr?=
 =?utf-8?B?U2djb3pKUEN1NDQ0bTJ2dmZVazNsR1l2Ujdza2tPcnBwVFp5SzFkOWxaanV1?=
 =?utf-8?B?MTdxZEE3MTRiQnRkN1NHQXFvNExTbFlLRTNPR3Q1T0hKbkNmSk40ZnBaUWZr?=
 =?utf-8?B?d1ZkdTI0RnFDc3QyTVd3eU5WZUs3TElKYU9icVA0RFNnQzB0WXBiVnp1TDlR?=
 =?utf-8?B?QTR4YllxdC9DTkR4TitIb1picVVOSFRrMCtnV2dBd1BmRjFML2o2SGNRaHZk?=
 =?utf-8?B?RkZDczEwQ0ozR040eENmY0kzZWpxZ1dqRnpaWEpUNDlGUzM2STNXVjRZOU1y?=
 =?utf-8?B?RWw3eGVWYjNYYmZpbEpPSWxZYXVzWk54ZXZvYVpKc2NlSVJFVEgxNC9lWnlJ?=
 =?utf-8?B?V3FqZjdTUDlHVmdoZHZadmFuOE5vVEJwV3hIc2xHSjViNG5OVzBDb2xiRE5j?=
 =?utf-8?B?eE5JRVdlMXQ0K3Y1c0hFcXFJQVZYUDJuVDB5N1o2RWZnY2pISzlPNnhPUVdv?=
 =?utf-8?B?R2oydDdoR1FVd0E2YW5MaEJIeDVXenFlWmFDTW9BVVFiZSszY012U0hsVm9V?=
 =?utf-8?B?bVNBOEMxSnR3UjREYXFaR1Y3SVkxRm50djJZUnVtanREWE1QRlVHd1p3Ums1?=
 =?utf-8?B?V1JWU2Q4Mmx2QjlzWUJ5MG1RaWNnV3NYYU5aVEdvOHRmdkhPbGpHTGQxZC9M?=
 =?utf-8?B?aVhZcDAvVnhmTnppQ2ZBaSt0YVVpelFSanh5OGQ2U01McVNmNmt5QXByZ1d2?=
 =?utf-8?B?eldaUzM3R095VVEyWjIyeHhoeHlLM0tzdjBLYUFBUFpjbzFteDF2ZGRvQUg2?=
 =?utf-8?B?cERac094eWxJR0FlV3FIbTVyUXczRzcvM2s0b2xNeWdOa3IxdkFsVXJBYXVz?=
 =?utf-8?B?L1hMVWNFUFQyenVTOVVDTkhWRWJxaWZjaCtGb3dpYmFXNHFTa0VoNnMwclJO?=
 =?utf-8?B?WGZCODNVQXc4TVgvbjZqMHd6U1NtaW1VbXpPRzlEYmxRMlRhN0syK24vMnBC?=
 =?utf-8?B?TTE2QkdDbWxpSzh3dWg2T1hwMmFiZHdZMnkxV1ZUT0d3SmJUK1k5aHBuSm9M?=
 =?utf-8?B?UHk3Qi9tOWVLUVdJTEFxT1hnbnlyVVUrQTZScWgwd1lZYmIrYjUwMzQwRVkz?=
 =?utf-8?B?VnljWmp6R3EzRHZMNDcvM1NQcDRDOHQ0c0UxclUrK0VLTWtDdXBleTdhV3JJ?=
 =?utf-8?B?YzR5K3AzUlFRNWxEeGRONUkxanQwelV0VWY5bUVPOERKcWJHWHNNWHh1bjRT?=
 =?utf-8?B?bzNrNnNTazJTSDhlTU9RYlBYdXppQzJIWHVjbDNiN1ZHeTFGNFZCTTZ6Y2Fm?=
 =?utf-8?B?WGZxQWFzaHpoK2FrOWgyU0RvK2s5Tk95ZFcrMHBOM21oMmJicFA1MTZtSmgx?=
 =?utf-8?B?K2FQWVJ2dnMrRFMyZmJRZnc2S0xTOEppR09QZDYzN3EwOGhqdURjbE5HUzFS?=
 =?utf-8?B?WVNDb28vdUo0bmh1d0xNclkvWnZUY3QySWpJOWJxUnZrWXoranFyRHc4OFBN?=
 =?utf-8?B?dngzM1VsbkFCd2pYOE5weHBCRytaVkZoZGRFcDcvdHByYVc0TjdxSm53PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(1800799015); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cElUd3dMMXhrNXJIUmZ5RTAyK01YRFVkc2tBZG9EUjY5N1ZsMDJSNXl2aU5U?=
 =?utf-8?B?ZmtNcExTK05mc2txN2lnaEIwRStnY2ljN3F6VFVCRFhpdGd0SU1ZdVEvYnB3?=
 =?utf-8?B?RTljS3dwbkpqKzJYeHpaUzlsbVk3UUs0WVpKMzBVRVE4aGl4Wm51dDJ0aGk1?=
 =?utf-8?B?dzZEakREV2crTGc0TzZGSE9YVmVTSldSY2E1UFdPTVFMZk9uT2dUVmlMTEVk?=
 =?utf-8?B?SW5uV1h0ejVheElmNFlJdjVoOVNnTjRKL0xVZ242TlZBMFdmR2xlVDJ0d1hC?=
 =?utf-8?B?U1R5ZXVDOEFrc29Ua0Zhc0orSjAxZjNCUm03bVp3eUJCdnVtLzJqb1NicjRG?=
 =?utf-8?B?RGEwOU1FaFRwS0NTYU5oaFQ2YlVwa3kyTGdjZlZ3UWZFekI2VTFDdnNuMCtX?=
 =?utf-8?B?QWlRWUY0c0NGdnViNTl1ZVBGZUp3YU82czQ0SUVySjFSd3pFMzl6L1NuL3hz?=
 =?utf-8?B?WGpVVytsTEE5YWgvZGo2RDZSdUZaTUFneGphVktjN0ZMUjU2OERuUnVXeG9q?=
 =?utf-8?B?SitEODVnSGg2dHB3VEU5ZkNZNjRTTVVHc29pL2VtVHdYejRrR1U1Y2plUkQ5?=
 =?utf-8?B?YTkzMnJXU3NjTSt2d3EwRHRDSXJvWDBtUlhpY2VGSGhoaDFIR0d6cXRlUXBM?=
 =?utf-8?B?eFIyVWRxRGdLOEdUeklhRFhqc2hmQ3pXTkIwZTJCemNSM0liZFhEVHhtcEhN?=
 =?utf-8?B?TTcyckg5L0VhTDVoZWNJRkFKM1pHUFE0K25Eei9qeFlMRDhldG1TVklmL3Ft?=
 =?utf-8?B?UFcxRE41dXB0dGxWUXhvSTlQUE5xSytCaE5uK09nNXl4cHpLdzh5ZDRTVE5s?=
 =?utf-8?B?VHRLMzhUL0d0cjA1amkzejlSYlV6UnhjTW9UTElLWGM2dkMwbFhNWkd4dHNz?=
 =?utf-8?B?c2ZyekRoS2hSQXdkeW1MQTRQQUFKZGF4S1BXYmVQRFRXNVZmVEVPbk5UeXVj?=
 =?utf-8?B?dVY0SnM1TDBCVGNpYm1PcVJDdTNEWFl3djk3c2FiRUU1dmg3TVYzNlN3ODNu?=
 =?utf-8?B?N0VLZmI0a2JYRldHK1k4YVdkZFh4bkdjUkhrL21xUUpTWEhnR2ljMWhmWlEw?=
 =?utf-8?B?c1loRGxIbldGSm1wbENRYXBycjRsYXZGdkN6TjEvOGtRM1o1ampPTlllM085?=
 =?utf-8?B?YnEwamJ2YlZBWTErNGM5TkdvYUdFZ3MwOFl3VnJqUWhlcHFuUi9KT1BLMStM?=
 =?utf-8?B?SXdTWmlCZjU2bUs4MlVmR0Y1c3lVOEg4WSsrUE9HaCtMdXdLemRKOW8zd0VG?=
 =?utf-8?B?Q2lWT3lpYkx2eTdIaHFYWm10bmR6VmxOSWllR09pQkl2MXV2VmY4MlRSOExG?=
 =?utf-8?B?Qy8yYjN5VGxTenRqbjVhWElRL2xJSnVxL2w5dmlwTkRyNEZFUVZXakdaUTVX?=
 =?utf-8?B?SmhjcXNmRlo3Mmw3SXB1Wis5c1ZDc01XOHBFejhzTlpxMm40Mko5MmFIdGF1?=
 =?utf-8?B?ZXpVMVI1RjIvQ1liV2ZxWUZTL0ZHNm9GNEdiTGllWVN2UmhacGtrNHJQTytM?=
 =?utf-8?B?bm84QkwxeTN2TTRka1U0YjJlTXZ1bXA1NzE3ZHljRUtZeUZYbzJiRlFaQ25C?=
 =?utf-8?B?akFHRHJhSWFBRXZ0MFIreGFnNFBiREY1VmZqVDZKSkswZTM4ekpjMHh6a0ZM?=
 =?utf-8?B?OXM5VHltWlE0aHZIdWFPZTRiWUh0b0p1U0R0Ty9zd3laRWtlcnA1UDVIdmh5?=
 =?utf-8?B?R1h0ZHdzUDZpSEVKN0hGUjdNcG5jOExHZi9QVHhJMTRwUTFhQjBONjZTKzha?=
 =?utf-8?B?MGJDVkNWcG1OTHUzbmpOVTBveHB5QXl6UGc1WEkxMmVUNXJKMjdWaWdXa0hM?=
 =?utf-8?B?ZE1YeUt6K25wVUFwUmtVcU9EaVFpdTRGeG9UUVBEcFhZcUNXakxRdFVseTZ3?=
 =?utf-8?B?R0toOEVwSjRoS1FFR25pNDRRaWhpeklqZXlyNmkxZTViK3I5aXZVN3hHWUcr?=
 =?utf-8?B?dmhnZWl4WFB6M3d1WW9OL0Jld2JBYmw1WnlhOWpYK1FyUm5VY3lXbSt4aGpW?=
 =?utf-8?B?Yld4d2Exa1JZZUJZUWdPR2NNM2lXdGp0d1l5MURCNDQwbmpMMVMwRW8vTjc0?=
 =?utf-8?B?UUJraytGN3NnQkkwM1ZsbUVvNHMxWGZLc0V6ZHpSWWtXeXhrWlpsVTNIU0kr?=
 =?utf-8?Q?ZPVUn+FjwLe6JQ22l1EKiKsDx?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9dfa6a29-1285-428d-4075-08dc80e8ef9f
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2024 20:41:52.2364 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UN4fnergqF+9nrh8ICbgJ71zAMeRQnEpu9bg/wVH6dgJUTh+Fun7Mf84VKFRHsnVra5QWWNTt9QOi0r50Cp6KQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7893
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


On 2024-05-29 23:47, Jesse Zhang wrote:
> When copying the information from the user fails, it will goto exit.
> But the variable i remains at 0, and do i-- will overflow.

i-- may underflow, but the loop will still exit. Why is the underflow a 
problem?


>
> Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> index fdf171ad4a3c..dac8fdc49e3b 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> @@ -2480,10 +2480,11 @@ static int criu_restore_bos(struct kfd_process *p,
>   		ret = -EFAULT;
>   
>   exit:
> -	while (ret && i--) {
> +	while (ret && i) {
>   		if (bo_buckets[i].alloc_flags
>   		   & (KFD_IOC_ALLOC_MEM_FLAGS_VRAM | KFD_IOC_ALLOC_MEM_FLAGS_GTT))
>   			close_fd(bo_buckets[i].dmabuf_fd);
> +		i--;

This changes the value of i in the loop body. To get the same behaviour 
you'd need to decrement i at the start of the loop body.

Regards,
   Felix


>   	}
>   	kvfree(bo_buckets);
>   	kvfree(bo_privs);
