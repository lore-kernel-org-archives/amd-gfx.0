Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2ED4C433F5
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Feb 2022 16:17:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3AB3210E311;
	Wed,  2 Feb 2022 16:17:10 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2067.outbound.protection.outlook.com [40.107.92.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7C9F810E311
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Feb 2022 16:17:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c30zS8B3eQT9zLwVno/xSTlFK3QqCOj+b+QxjT//ff/WEfGkO1chiQKsV/+bd5ZpmoRwFFRX6ZfXgVWRmw1ELfe15rvxd5XsUZ1morT4kfwtIkBxDytyKTaAqDu0j5y4G5cRdok6JnlTwYPSmeT1xQqoG0wZ0mp+zG6jrPsAi3XeJbDREaLJxjdsuR/JEmXyYAudkvAFAV4P3WP50nGCFTXWlLDJKRws7lEVoyj9KO1y+Ydx1vLlIWVIPJvG1lZhnrEXRfp3WhYcl6cveK3CVlxEqD6ZsuppPMbozzvrFIiHQRUehveWZQEmNWiosVj0Dz8SzIHcH+HQEduFhiVRQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1DqQLZg+CVBSPqInvkHRpK6Fek5449bFnkAIwoGkzO0=;
 b=nAX490q3bSISLQv3h8n8DIskAAmTGQg1qr8TTcWkVN1LKzR/IvDs8em7wh/SprP9riDPirg8qF/0F6tPA37gRJaqyrejjHu7Am/6h6DlmC7VNnG2XgQjXSp/buTAwPb51vn2ZK5CnCWbLqx0DXZXtq0p3MXxUTy1057QImJDQ4e5OEiGGcrKGPX+ISPvTYJ4VMEahr84oqvydLhtxcXXnAgebO/Bh2drBmLJbQYzECvXuv3LJ+zSC5MmQxxnL3sRkBiiHL8WUNJOs88NlZXKRpEsaz/cEIr9l3nMCw6C+Vb4HmxEskdWO7xJQUU6OEWFa8kR+4D724aXt1RW47BPAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1DqQLZg+CVBSPqInvkHRpK6Fek5449bFnkAIwoGkzO0=;
 b=H62HwzPv4Ch1ywQcW/xVmfnU7bcHErA7wu1YhsvpUwDNT3BnfFxKz1ELxwRcqBMa1imdhLgNqXkL1JO0FKbVE/9hEIJinTV1jnPms6TZxZg7/CMcStTxVD5EJ3Ax+5wc9q0nXFQwpZhhUZvBjEmYi2hwDzclyZj3ilel6Wop9Eo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by BYAPR12MB2983.namprd12.prod.outlook.com (2603:10b6:a03:d6::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.11; Wed, 2 Feb
 2022 16:17:05 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::971:531c:e4f4:8a9a]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::971:531c:e4f4:8a9a%8]) with mapi id 15.20.4951.012; Wed, 2 Feb 2022
 16:17:05 +0000
Message-ID: <7e153b2c-2751-c021-d1fc-d4fb40004d94@amd.com>
Date: Wed, 2 Feb 2022 11:17:03 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] drm/amdgpu: Handle the GPU recovery failure in SRIOV
 environment.
Content-Language: en-US
To: Surbhi Kakarya <surbhi.kakarya@amd.com>, amd-gfx@lists.freedesktop.org,
 Bokun.Zhang@amd.com, HaiJun.Chang@amd.com, Monk.Liu@amd.com,
 Alexander.Deucher@amd.com, Kelly.Zytaruk@amd.com
References: <20220201214719.166802-1-surbhi.kakarya@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <20220201214719.166802-1-surbhi.kakarya@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT1PR01CA0116.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2c::25) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 77a3182b-0776-40fa-a7ed-08d9e6677434
X-MS-TrafficTypeDiagnostic: BYAPR12MB2983:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB2983CB2ADE4088522E93C83092279@BYAPR12MB2983.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2887;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lZ52tY4e/xCRXQAlzTnFQDHfzY5A/xBNcwX22ZczUBmtDOEi4irwN/cXU5RsWnsOPvERDcUgMWA25qH0RQMru3Wowx03kyChXf11SZXM+Cb7PIq21o++QQyCblBqLGj6l16B9XqMVLprkPzR0j/kbWBp7l3b6xp3HU+s07LkDlSnRaQkwTFaGi7MV5Ej/9UJhmNyhxEkUqSW7fIEJvX3Y7IyVfkE9ysKgMAdvqjtXaOYDuM0ig2auAordn/34LQ0QQXt5pMtXTN1+FjdyC5++YRMLRizyi99xp/CGEH7hMzErcs9eEET/kkNo2U9uS3tcOGOz6m+CTBxGq8Kw73qe1GP1vtdKdHFoj41K+EjGI2oyyrg/zEjpAu0e3fTJ8oSntjHk1GsNS60iU0XPA46WGLyhhBNi7ZAquf4CHRCxrNf/G5UuwwrCamGripVEuw6Xf5x3aSgssvsbYQOLonSXXVAU55mPq+qjLAT/4tedd2WEJbRGz11Q63ROgQpRGMuX4/iVn90p0GU5FqHEg0DKMbaNXNQ+g1nZQbaAE1aaYzwIuz9DaOx/0v4r6Qb067JkNn+ZvgUsXM25g4AeLDUQBfycTfz7Z/y9cQ7IsFernE0B2NMlkQ2iRK5bv47C6M6aUy7lRjMv0eWeFTUKaLM8U8L3MB/JYckphOUo0sRsRJtFYyi7q2xRdW8x/1US2pMKuwGY08xavwVOt0MrUXvbnekBybvuavFO9Kv9qrRaSjvCoT5mt2sSS7K9kRTlSBG
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(508600001)(86362001)(31686004)(6636002)(83380400001)(36756003)(6486002)(31696002)(316002)(66476007)(44832011)(66946007)(6506007)(2906002)(186003)(38100700002)(2616005)(8936002)(66556008)(8676002)(26005)(6512007)(5660300002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RGkrT0xndTlIdGJySzBLYW01eWdOMUlLKzlvcEwyNVArNkY4SVRweDF4czJX?=
 =?utf-8?B?M0R1WVB0RnFIbEZkN2gwNm9xTlBOQlNlYWRYRTNFSnZxTkJJaCtHaEhySWxP?=
 =?utf-8?B?TVc3a2NxSUg4L3pHWUg1aThhalNKVXJqQ01jd0dGMkFyNEZrbFNsdkFWdHFE?=
 =?utf-8?B?KzlXVFRDSDBkTEhPQzZhamd0TjZhSzJpSXUzU1RPTG5BNHBSRTFXcnhwK25m?=
 =?utf-8?B?ME82N1JzMXEzcUJNUDBEZVBZdEZ2QXhJWlBuNjZYSnhYUWZ4Vm40VElFeTFO?=
 =?utf-8?B?bkVHNzdLTmVaZnNpbHhWVm1OQjFmSFFkY2tLU2gzcjBMNUwzWVB1Y3MrQjAz?=
 =?utf-8?B?M0tIWFhoOFlDOWVSdzRtRnV1M1ZkTC85SllST1U4QkFaNVY3NnRkTWJxeXpP?=
 =?utf-8?B?Kzd1V2FjSGovR2hlVkc4OVEzbWhtU1pmNFhHL003WDJFU2dYc3gyNy9Tei92?=
 =?utf-8?B?eExIQjBBRWpzN21NcG5ZSlFZSWpQOHcvTFJHOHVXVVlobldpMVhuWE9NL2Nw?=
 =?utf-8?B?TmhMZVAxTkpUcjhQMDN6WTd2NnVPb3d5R0FqdjhVSjg2cmZHSG9wejMxeXdK?=
 =?utf-8?B?TmRVUXo0dC96cnpWLzVMdU5lbXQxblN2WStURGhWaUc5Ry9QNXBpcUUzNmhF?=
 =?utf-8?B?NStITytnTkJTT1pXNVE5UWVDYXNZMFpXTExnSlhjQ3hURUdmQzR0QWZwck14?=
 =?utf-8?B?MzdQU0dYSFpXalNHSG1CVUdDTHJMN0w4RFpPMjRKQ0huK2R4WWdqRTBxWDNq?=
 =?utf-8?B?VmpiMFpmRWZUSnR6VVVWallXMEQvbE9PSlA1ams3TXh0UWsvOEdRTS8xL0di?=
 =?utf-8?B?YXJnclJTQm1uZ1Y5bm4vZ3Bja2FPU1VSUnZPT3FrelIwem5wanFUYTNtQzhQ?=
 =?utf-8?B?Wjg5RVowUkd0akk0Ukxmckk1THJvU01YRTJ1bW5IMnpvWmt1M3V6dWpDTG5i?=
 =?utf-8?B?QUR3dUFQZ2xrVUlxOVNnZVhLaVluWVRyMlBXUFBaYUx3U3dZN3RLenRoYnBu?=
 =?utf-8?B?ZVZxYW03OGp0dVlYZ2J2VW1PNHoyS2ZrRjVOT1ZGcHhhWlp1VjNEVDBpMk9n?=
 =?utf-8?B?SmpYYUR3N3lRbTA3OGtpcXVrNXRIbStQUnpPUnhaeHhYeVU1NVFrNm5tTXVp?=
 =?utf-8?B?cTlZTE03YlNtbUc1VWxldXN6WFBBeW9VZXoycGhZT0pNbGcwWlA3dnJ1ZTZT?=
 =?utf-8?B?NjdJUUVoZ2U3V0x6V25zZ09GeExUUzBScmViYkU1anlnZzRqeVdKVmNucWZo?=
 =?utf-8?B?RjBXRUduYTlaWG83RkVQSTZiWTVTeVhrSUpDanc4bVhkWkZhbXVkbmhiUnoy?=
 =?utf-8?B?OW53RXF1YlNFY1lFOWdaZGErdjN6a2pacHA0UkZwaHdyaHVQUmxtK2JhTzdN?=
 =?utf-8?B?aFpySytkdmx4UjNiTWJhM2NIVzBxS1V6Wm1sWnRPb2IrTk1xaEw4d0tFclZw?=
 =?utf-8?B?bS92Q3Q3Rit6VncwVjZMVVY4TDE4bXM0dzJKZWd1dGExTVNRN1lrOG9mUE5t?=
 =?utf-8?B?UW9UazRKZG1PbFZ1MitzcU1QSGo3NzhURXJEZ3lML3VBNWJUdDYwbmFNSUp5?=
 =?utf-8?B?ZEIzZHY4dVBlSVlORHQva2RSd3RxdGQyWUhHSS9NSmVNcXRpdTZtcEI5eUVy?=
 =?utf-8?B?VndnR3NEazFweW5ZTzNOdDZPbVJjNS92eXhZRUl2QjVRSVdNaTB3R1ZwK2w0?=
 =?utf-8?B?d1VSdzlORmovSzJBeDRWTmlVaHR6NXI2WFF3RmUyb2IrZUJka3haektIajV0?=
 =?utf-8?B?Mk96VHhJWHhPU0ptM0xvZWNyanhlRW5mTEN4aGtIOTY1aXM5RStHVHRxd1Vw?=
 =?utf-8?B?OHJQSXNsTnlXQkNhQnkvNDYvbWMyaHVnWVgzcnBkREl4TFZDQnhmWVJDZ1hq?=
 =?utf-8?B?MGZKcGE0b0xvbDQvOUVweHBQV1dZRGQ3bUUvcDZzT1lvTXhSRFdEYUJIbkFT?=
 =?utf-8?B?cC9jZkVNQnRvMlpjYWthMS8vMWN4Qm05bEpHSk9ac2JLQjU0MkkwbThUZUtP?=
 =?utf-8?B?a3RUZE9JOHJkeEFYaXdLWmEwdUtSSmRJRGMyaW1iYlZSWEtRRllMMWptdnA5?=
 =?utf-8?B?UzZreDd1UnpuUEFjMll1dktYT0svZWZMUEZCazhvUnJlOE5VcVlNYStzaUdu?=
 =?utf-8?B?UisxcmM1cld0RExoVVZ6MmpsRVBNb2Rlb1g3ay9jb0NsTVJTUUJBczB2anU0?=
 =?utf-8?Q?jPWETzRQgvrWB5IAoxVR7F8=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77a3182b-0776-40fa-a7ed-08d9e6677434
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2022 16:17:05.6525 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hs+LSiw9PU1leNn3S8GlOOCtWKZuNMKNh5yaGRdnChlm4sbd2t40g6HoLJiDpG2+Mg6xbJeGAD6fDv9/NnQ7tw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2983
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

Am 2022-02-01 um 16:47 schrieb Surbhi Kakarya:
> This patch handles the GPU recovery faliure in sriov environment by
> retrying the reset if the first reset fails. To determine the condition of retry, a
> new function amdgpu_is_retry_sriov_reset() is added which returns true if failure is due
> to ETIMEDOUT, EINVAL or EBUSY, otherwise return false. MAX_RETRY_LIMIT is used to
> limit the retry to 2.
>
> It also handles the return status in Post Asic Reset by updating the return code
> with asic_reset_res and eventually return the return code in amdgpu_job_timedout().
>
> Signed-off-by: Surbhi Kakarya <Surbhi.Kakarya@amd.com>
> Change-Id: Ib2e408819b4780e6963e1dc078c3410cd512e6e8
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 47 ++++++++++++++++++++--
>   drivers/gpu/drm/amd/amdgpu/amdgpu_job.c    |  6 ++-
>   2 files changed, 49 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 53af2623c58f..f50c18cb38c8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -89,6 +89,7 @@ MODULE_FIRMWARE("amdgpu/vangogh_gpu_info.bin");
>   MODULE_FIRMWARE("amdgpu/yellow_carp_gpu_info.bin");
>   
>   #define AMDGPU_RESUME_MS		2000
> +#define MAX_RETRY_LIMIT		2
>   
>   const char *amdgpu_asic_name[] = {
>   	"TAHITI",
> @@ -5026,11 +5027,27 @@ static int amdgpu_device_suspend_display_audio(struct amdgpu_device *adev)
>   	return 0;
>   }
>   
> +/**
> + * amdgpu_is_retry_sriov_reset - check if we should retry sriov reset
> + *
> + * Check amdgpu_is_retry_sriov_reset and return status to see if we should retry reset.
> + */
> +static bool amdgpu_is_retry_sriov_reset(int r)
> +{
> +
> +        if(r == -EBUSY || r == -ETIMEDOUT || r == -EINVAL)
> +                return true;
> +        else
> +                return false;
> +
> +}

The missing space between "if" and "(" should cause a checkpatch coding 
style warning. Please run your patch through checkpatch.pl.

That said, this function could be much simpler, maybe even a macro instead:

#define RETRY_SRIOV_RESET(r) ((r) == -EBUSY || (r) == -ETIMEDOUT || (r) 
== -EINVAL)

Regards,
   Felix


> +
>   static void amdgpu_device_recheck_guilty_jobs(
>   	struct amdgpu_device *adev, struct list_head *device_list_handle,
>   	struct amdgpu_reset_context *reset_context)
>   {
>   	int i, r = 0;
> +	int retry_limit = 0;
>   
>   	for (i = 0; i < AMDGPU_MAX_RINGS; ++i) {
>   		struct amdgpu_ring *ring = adev->rings[i];
> @@ -5064,8 +5081,18 @@ static void amdgpu_device_recheck_guilty_jobs(
>   			if (amdgpu_sriov_vf(adev)) {
>   				amdgpu_virt_fini_data_exchange(adev);
>   				r = amdgpu_device_reset_sriov(adev, false);
> -				if (r)
> +				if (r) {
>   					adev->asic_reset_res = r;
> +					if (amdgpu_is_retry_sriov_reset(r)) {
> +						adev->asic_reset_res = 0;
> +						if (retry_limit < MAX_RETRY_LIMIT) {
> +							retry_limit++;
> +							goto retry;
> +						}
> +						else
> +							DRM_ERROR("GPU reset retry is beyond the retry limit\n");
> +					}
> +				}
>   			} else {
>   				clear_bit(AMDGPU_SKIP_HW_RESET,
>   					  &reset_context->flags);
> @@ -5122,6 +5149,7 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
>   	bool locked = false;
>   	int tmp_vram_lost_counter;
>   	struct amdgpu_reset_context reset_context;
> +	int retry_limit = 0;
>   
>   	memset(&reset_context, 0, sizeof(reset_context));
>   
> @@ -5299,8 +5327,18 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
>   	/* Host driver will handle XGMI hive reset for SRIOV */
>   	if (amdgpu_sriov_vf(adev)) {
>   		r = amdgpu_device_reset_sriov(adev, job ? false : true);
> -		if (r)
> -			adev->asic_reset_res = r;
> +                if (r) {
> +                        adev->asic_reset_res = r;
> +                        if (amdgpu_is_retry_sriov_reset(r)) {
> +				adev->asic_reset_res = 0;
> +				if (retry_limit < MAX_RETRY_LIMIT) {
> +					retry_limit++;
> +					goto retry;
> +				}
> +				else
> +					DRM_ERROR("GPU reset retry is beyond the retry limit\n");
> +                        }
> +                }
>   	} else {
>   		r = amdgpu_do_asic_reset(device_list_handle, &reset_context);
>   		if (r && r == -EAGAIN)
> @@ -5341,6 +5379,9 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
>   			drm_helper_resume_force_mode(adev_to_drm(tmp_adev));
>   		}
>   
> +		if (tmp_adev->asic_reset_res)
> +			r = tmp_adev->asic_reset_res;
> +
>   		tmp_adev->asic_reset_res = 0;
>   
>   		if (r) {
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> index e0730ea56a8c..1f0fb21ac15a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> @@ -37,6 +37,7 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(struct drm_sched_job *s_job)
>   	struct amdgpu_task_info ti;
>   	struct amdgpu_device *adev = ring->adev;
>   	int idx;
> +	int r = 0;
>   
>   	if (!drm_dev_enter(adev_to_drm(adev), &idx)) {
>   		DRM_INFO("%s - device unplugged skipping recovery on scheduler:%s",
> @@ -63,7 +64,10 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(struct drm_sched_job *s_job)
>   		  ti.process_name, ti.tgid, ti.task_name, ti.pid);
>   
>   	if (amdgpu_device_should_recover_gpu(ring->adev)) {
> -		amdgpu_device_gpu_recover(ring->adev, job);
> +		r = amdgpu_device_gpu_recover(ring->adev, job);
> +		if (r)
> +			DRM_ERROR("GPU Recovery Failed: %d\n",r);
> +
>   	} else {
>   		drm_sched_suspend_timeout(&ring->sched);
>   		if (amdgpu_sriov_vf(adev))
