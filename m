Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A882EC433FE
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Feb 2022 15:40:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5788A10E87F;
	Thu, 10 Feb 2022 15:40:20 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2083.outbound.protection.outlook.com [40.107.92.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7EE3110E87F
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Feb 2022 15:40:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MFJXNPp/QUZZiHlCxfa2GbKWynVYNF5XEhvWrSqT8n/bJEoKwKhM8CmN37bX4CgQeoXg2iHlcgk6//lu+ieSy9U+DT0IbzhTMxkWJbT90fk7hB8ke6dAb6ph6AQwsO/mEApFVD36whpXHn9a/oAs6t02hIiL5bN3SreWb9ifOb1hYq0viY1X3Vr+n2J6p/a/H1GfhDu9QaGeibnEif/ggFaMMIkGfCsUI5LYGTQU6BSoGkOT9Lwt2RlXgytd92Wo4OvvErntiiya/JV1N08Qbl+ihnCSHR8slKwDK9nhEGRGZemWfXcjKE53LKRHlQTVWx7vGHVZm6I9qt0IdUL10g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s00UP5VA1YS8zjBNgAsPREKl57xbF7GS8Jd3Plw/Cq4=;
 b=LzgK9hL7WeVGJi5sGWDKSH3iV5C37/b8jh2A4NoXShT8FaoVYxUkCGXmMnwUdrUApGdeO8AR+M0bJUR3Sj/p9u7fo6PANP7iPzxA08ssDC9Lw89fbPMIG8W+1Qj1ld4gngUxFeoy3nbS5CRcPY/iEEt91vJn3ZrQ+sK1lTIEew7EVgh+gRks37vrwtzFE7+hOWVvmHqhsD90S1o1W7aKssDLEHay/cHL0Ipo/PP1a4etkyil3YOkX09jXID11OY8CezA5YJYHzIrgg+0Un+CbhLqUpiU5cgLr+0s2ttCezLa9vehdpcf+Uy+wA79UAAu7IBdgMOcIcAJ1LWrRFH0UA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s00UP5VA1YS8zjBNgAsPREKl57xbF7GS8Jd3Plw/Cq4=;
 b=dsop92dGuPG+VTcBgVFwfWIBISDyPsQoi+xMOqmlLR+shrZjv+8kGcByvbgixIBgaFPk/LVWAbVscRR8ZDJLVhkkyOhma1uDdwYS4NuAqK+3kPkgIqLBIfpHUzH0fZ/Nu/5d21w/pw9ewhf6Wye6G18wqoP0RswfLiA5VmQaE+s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1947.namprd12.prod.outlook.com (2603:10b6:3:111::23)
 by DM6PR12MB4217.namprd12.prod.outlook.com (2603:10b6:5:219::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Thu, 10 Feb
 2022 15:40:15 +0000
Received: from DM5PR12MB1947.namprd12.prod.outlook.com
 ([fe80::a105:faab:243:1dd3]) by DM5PR12MB1947.namprd12.prod.outlook.com
 ([fe80::a105:faab:243:1dd3%11]) with mapi id 15.20.4951.019; Thu, 10 Feb 2022
 15:40:15 +0000
Message-ID: <14c69d29-0d5c-6858-9199-292c8078f0d6@amd.com>
Date: Thu, 10 Feb 2022 10:40:10 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [Patch V2] drm/amdgpu: Handle the GPU recovery failure in SRIOV
 environment.
Content-Language: en-US
To: Surbhi Kakarya <surbhi.kakarya@amd.com>, amd-gfx@lists.freedesktop.org,
 Bokun.Zhang@amd.com, HaiJun.Chang@amd.com, Monk.Liu@amd.com,
 Alexander.Deucher@amd.com, Kelly.Zytaruk@amd.com
References: <20220204024512.5986-1-surbhi.kakarya@amd.com>
From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
In-Reply-To: <20220204024512.5986-1-surbhi.kakarya@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YTXPR0101CA0029.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::42) To DM5PR12MB1947.namprd12.prod.outlook.com
 (2603:10b6:3:111::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 24ecb7df-7994-49d6-36e1-08d9ecaba200
X-MS-TrafficTypeDiagnostic: DM6PR12MB4217:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB4217088517CC8DA81AE592C6EA2F9@DM6PR12MB4217.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uNqJsgjd+RlOn+xSHeJu17LS7QlWd7sgOZdG9hq4RVpmUCmqBK4BPCicGsu+KZlUf2PAC0mj7ROv3usdRoWlv9LLSwMh30cwcnsGLYlDyhliC0CrprzVfXKn+qxz5/sRH6dkDJDcRz4tBK1CCCfuQ/igjoDOUmXgYJXPnXPm7GNNw2qiDSfFX16BLCT2Iu2BIa6WKGrRoDlBO3MDImg952qmdlonmegX8eBMo/XchhhBZcLJ+9NQ7Y7zUnq2e/LyB6dSdY+qQtImFr1p22R0tN8zc974ob1Y15R3yOXp17gvxktJOXVpStKjTfub1Ah0B2+CQXGNeZre2W+Pfe/5aBpc5aToE5aCtxs2ohvJD/aGREQSxyXwPDH8ABnk0XfGaoNmeJbXcqZBHZ5B50kJS7UYtCFCRUJuTpZ39i8lcF5rwm98CDlNme7Pll3B7Zmpiu70O/p9eWYlV1xxQCfkUvob9R/tRH8z38kT2YMExb9r9JH5h4LmUdd3DG6oHvNWbe7EHw5/8pFyk+gHqpEMigAMh9Y+Mp89mnZwdPF0pinbimPDUbOE8jZk/Ja7PHHUfBHda8QecI+Ox092+qHaGpq2hSZ8xdVOzF7AgmRNk3pdlu4RZhGjNXMfqU2Jyr1Z9E6BlkoKyR/1V70k6hqdh8NfXaIJYNvMACFLw2j5dJXg0uC8EvP0s+Va0S+2YmxbMFONKl8NMKAxxsAcDBzEqRglBBjnnZpH3TQ10I7jS/Q=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1947.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(83380400001)(6512007)(508600001)(86362001)(2616005)(8936002)(8676002)(6486002)(66476007)(66556008)(186003)(36756003)(2906002)(66946007)(53546011)(5660300002)(44832011)(6666004)(6506007)(26005)(31696002)(6636002)(31686004)(38100700002)(316002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dlczRUQ5d21kTCtFVjdXWUhkYkpvRi9tRS95WmFzTlcxUDZSWk1zN0tGT2dk?=
 =?utf-8?B?ZWd5YklMd2hhQW43N1dPdllXalVzQ2lrUDFFNWFlR3lSVWhlZjA4VFhLa2t1?=
 =?utf-8?B?QW9oVllybTFNc3kzSlBKS1FZOHYvc25GL04wMXBNT3RlODk4dWF1T1ViTklh?=
 =?utf-8?B?Tmd3R0RvUmpDKzNudjVWVmpncU5uSTkvRUpMUm0zai9DRU4vNG5pVjZmOERR?=
 =?utf-8?B?eUJXT1B5SkVweHJEUFB5cFdidjNVWGNaTlBtRTlINVNjbWNlVTFIVVRpZFZq?=
 =?utf-8?B?VFdhdlg2TWJWa1dtWnp3RXpobjM3UHk4bFBsZFRFVFQ2YVVsRUl1SCtpMVdi?=
 =?utf-8?B?WERSM3FnQ2N2cTl1NU9Oa3NFTm9BTmpZT0p0dkIxZ2NsQlhqc2dmSFdWT0JO?=
 =?utf-8?B?RkNTTnJNZE1lWWI3SlJoaVk4Z1BHNGhhcUNud0F0Qkp1YWNFdklmNlJqRitS?=
 =?utf-8?B?OUkvMG5jeVI4dWhkeXRmUGRNU0hKN0dsdlNxRkIzTkQ0RCtDUFlFTTVHWnJJ?=
 =?utf-8?B?czExOGFLNG1VZmN6TXQ5QWsvK2tNV0M5VFlsaklOa1drNlA2ajFVWGpZRDNB?=
 =?utf-8?B?TjZSTWY0QUpMMjV1cFE4Y3hFQmdvWFlKVEVwVFAyN1ZTOEVSTmVwRThCZVY4?=
 =?utf-8?B?eE1zcWFYZ0MxOEt4bTJpSnp5RitqZ1o2M2F0UFlzQmhXMHVVS0Nya2k4QVlE?=
 =?utf-8?B?d0RFU1JFKy9UWDZzK0ZVNFp6NEo5U005TlpDbURrS3BLNVorejFzSVppNHJl?=
 =?utf-8?B?OVNNY3Vya0tURWdHQ1d2ZUtDM2xjNm5VQzhaRFM4YzRXblk4ZjdHOC9nQ1g4?=
 =?utf-8?B?b0cvQXo1VG9wVmxWVFAvZkxZWVYzMDZwZFNHR08xT1ZLK2hHUG5KQVZaS2No?=
 =?utf-8?B?Z2NrL2ZGWDZYdk9COElKcjdHODR3akYrdmVQeFdXWDducXFXYTdYblgvRHJU?=
 =?utf-8?B?bnF5MXAxT0syN2JDM2VmR3g3NHJoTy9TUjhMVzFuckVGY1FvdXoxR1dZQWdQ?=
 =?utf-8?B?ejd6UllPWjZseXMzYVJrVlBVZUdEZlhvRncyUXBlU2ZQMWdpUmx3RGsvSGhL?=
 =?utf-8?B?SEZqQUttVmNlUFNlNURpbG1iNVlGTDE1dG5aeGROTXRBRWhTanh0R1UrR3cw?=
 =?utf-8?B?Z3VYbDB3Vld5K0h0NlRZc3BrS2Q2LzNqWkJvSE1xL1diK3o4S1ZoS292NU9J?=
 =?utf-8?B?ci90UVNwOXJDRlZ6YTNUcThpdnZqcGs4eFVHVC9BQ1V5eEplTGhHb3ljRHFh?=
 =?utf-8?B?WTh5ZnhjS283RTVvbUhCYktTMFhxR1dmaTFmUHNkQ2psdUQ4SGJlalprZjhR?=
 =?utf-8?B?UUpUWVBPUzNqTzZzNTNDREdRRFdWSVhlWWlzTU9qVkNrcUhUcGgzNmZPbzR1?=
 =?utf-8?B?aUtTc3lrR2NBV3BtMU9xR1lqWEplMG9YbHNGa1l3azJBZXRLN1VKOThCcHhJ?=
 =?utf-8?B?c1d0Zk15YkFacER4WnQ0VTM5TzMzbVorU0JuTmRoOW1zYVhsSkRzTXpZOVB1?=
 =?utf-8?B?b1RVSlpERjRLSU1OR09qaUg3TEVkUUh5MTRvWVJDcmxuVVNRdzZCdjZXbHBu?=
 =?utf-8?B?bWtXN2dXcTVBdTdxU3VQeVVXSVlsZ1grVm0yUnFUdklldmE4dkw1RENqL0N0?=
 =?utf-8?B?bmRWcDJSZlhLR3dYZlh6aWxuVUhRSlZ2SUFjRE1KT2M1cHlTQS9tTUFtNG1N?=
 =?utf-8?B?bjJ3bUtOcXplM2NqWExZYXhOVG5nNmMvUUhxQkVmYml3RE4zUVBZWmNaRmNw?=
 =?utf-8?B?Q0QxaXN4Uk5GeG5KQnEwWWNPVmxuT3g4blZNTkVId3QxbkFzRmFOS3lSRXFz?=
 =?utf-8?B?OFhtQ1hEZDJqR3Irckl4RlZBbTlVWUpYYzlmMmdtd3MzUktrRjQrYVdjUnlZ?=
 =?utf-8?B?VWNSTERIeTJxUHJENnpLajJ1RlJFSUFYd3hjQitINFJXUFBYOGM2K2N1SVh5?=
 =?utf-8?B?dmk4VE1RcFFMK3IzcE81RlIwaWFQNWQvcHFXRDUzUTArUTAyRUVybFJ4ZkdI?=
 =?utf-8?B?VGNxb3FEKzgzcUE0WFM1MXV1MDIzTk5FaFhaS1VRbzlKSGtKWUFLNUpVR0h4?=
 =?utf-8?B?VXk5dkd3SEo1Yks0WUpaalh0V2VObWVBaWhyc0toZVFtZUgrb0xvY1FvVity?=
 =?utf-8?B?dDc5a0pwR3ErWXdrSGI0bnpib1dJY1VMaVBCR1kyOXdrTGdYd0kvaXZqdExY?=
 =?utf-8?Q?x6baKG0e3X6n2ds5MoJvDAw=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24ecb7df-7994-49d6-36e1-08d9ecaba200
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1947.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2022 15:40:15.2996 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9w1AHyrSy9sd8Jztq0RkKdncA3s2uZ9DTbFOpdnbi63/h4pCSvn+tpYIDwsVHhB2fJK/V5B7ih5u0fjN9szwqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4217
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

Reviewed-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>

Andrey

On 2022-02-03 21:45, Surbhi Kakarya wrote:
> This patch handles the GPU recovery failure in sriov environment by
> retrying the reset if the first reset fails. To determine the condition
> of retry, a new macro AMDGPU_RETRY_SRIOV_RESET is added which returns
> true if failure is due to ETIMEDOUT, EINVAL or EBUSY, otherwise return
> false.A new macro AMDGPU_MAX_RETRY_LIMIT is used to limit the retry to 2.
> 
> It also handles the return status in Post Asic Reset by updating the return
> code with asic_reset_res and eventually return the return code in
> amdgpu_job_timedout().
> 
> Signed-off-by: Surbhi Kakarya <surbhi.kakarya@amd.com>
> ---
> Changes in V2:
>   * Added the macro AMDGPU_RETRY_SRIOV_RESET to determine the retry condition.
>   * Moved the reset retry in amdgpu_device_reset_sriov() to avoid duplicacy.
>   * Added the AMDGPU_ prefix in new defines.
>   * Verfied the coding style with checkpatch.pl
>   * Added the retry limit as 2
> 
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 15 +++++++++++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_job.c    |  6 +++++-
>   2 files changed, 20 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 53af2623c58f..59310ca398f5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -89,6 +89,8 @@ MODULE_FIRMWARE("amdgpu/vangogh_gpu_info.bin");
>   MODULE_FIRMWARE("amdgpu/yellow_carp_gpu_info.bin");
>   
>   #define AMDGPU_RESUME_MS		2000
> +#define AMDGPU_MAX_RETRY_LIMIT		2
> +#define AMDGPU_RETRY_SRIOV_RESET(r) ((r) == -EBUSY || (r) == -ETIMEDOUT || (r) == -EINVAL)
>   
>   const char *amdgpu_asic_name[] = {
>   	"TAHITI",
> @@ -4456,7 +4458,9 @@ static int amdgpu_device_reset_sriov(struct amdgpu_device *adev,
>   {
>   	int r;
>   	struct amdgpu_hive_info *hive = NULL;
> +	int retry_limit = 0;
>   
> +retry:
>   	amdgpu_amdkfd_pre_reset(adev);
>   
>   	if (from_hypervisor)
> @@ -4503,6 +4507,14 @@ static int amdgpu_device_reset_sriov(struct amdgpu_device *adev,
>   	}
>   	amdgpu_virt_release_full_gpu(adev, true);
>   
> +	if (AMDGPU_RETRY_SRIOV_RESET(r)) {
> +		if (retry_limit < AMDGPU_MAX_RETRY_LIMIT) {
> +			retry_limit++;
> +			goto retry;
> +		} else
> +			DRM_ERROR("GPU reset retry is beyond the retry limit\n");
> +	}
> +
>   	return r;
>   }
>   
> @@ -5341,6 +5353,9 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
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
> index e0730ea56a8c..4b9d62f375ac 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> @@ -37,6 +37,7 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(struct drm_sched_job *s_job)
>   	struct amdgpu_task_info ti;
>   	struct amdgpu_device *adev = ring->adev;
>   	int idx;
> +	int r;
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
> +			DRM_ERROR("GPU Recovery Failed: %d\n", r);
> +
>   	} else {
>   		drm_sched_suspend_timeout(&ring->sched);
>   		if (amdgpu_sriov_vf(adev))
