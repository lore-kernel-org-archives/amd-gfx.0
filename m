Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A543BC433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Jul 2022 10:53:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B1D7212B41D;
	Thu, 14 Jul 2022 10:53:09 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2042.outbound.protection.outlook.com [40.107.93.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2379C112590
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 Jul 2022 10:53:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dOIXdVZQYrl/EkOgxDEW9qKdN5WFcOpJ6ElXUwRQvwqt/rc8f8sPcp2LYMeBTGnEpyRC7/zC1K6HqUMfF9RrpyI0jLGAJI2QOqMz4WkMQj0gLESn7YwxR+gUqVoU5A4QofKpffO3HUxCpeUmL7Um7/9lbcKVYpJC5lt7e2IzYZSA07zc5QvFUKMmfLhNzRhJLMXL48ZUhgsNES/uyJbAw+oi7ZFsZHUdFDsppPFlKEGhFaF65J9pUFFNhtnGe81RWB33bfBkwP51Y/vAAb/OreI+dkgcgACPusk8WR6URomIWL5M5D+akV2RQKQu8knKOtMT7xkljflIKZ0foeQj8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ouvAkKuXN+NiXARe568xZBYnrR/PQOqrpD7VFcDiV78=;
 b=npO8SAri7odFYuGddufvnup7cb9TdkhKqoxYShEhdERgj+8DHxsQxy+3n5F+WY4tp3L4eagNbtvsWJrdXX9juXCClnTalz7cj58BuAPZKxLsV4BvdEPQD1E1+mXqCr9GZJeUxlf3bv5XBs2A/oRBnLZFrMuQ5U+YVX5QfVx/vmd92SG4NuQVJD4eQSrzMhEJZxq8JwYQoIHMqtOBXh260R46056GXtgqXpuX7WC6vbTLDkSgMKE9QKAbUCo9UQHb61gulRKt6+MoorovdgZg0JenVz5MQUhfPdsShYhueKhRvkY3VA6y26dLYKvTQSGmWRzU8JLCXD8KxHRSR8IcKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ouvAkKuXN+NiXARe568xZBYnrR/PQOqrpD7VFcDiV78=;
 b=YBfdDnojwp8k4QMonqMRkQU8oaOIavY6RHjLYxhLqVlllZ+q7Nq53SZEy70RKPMTFKRj5ApeMT5CggfJ/SubQ+vyh2Du5aOUgwE27YvTg+CgUi3XBKoJubFHi3leKUkyfBcf+IUsaFgkdYCwnIKaertjU3YssvrnhUVC1upuA3g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4614.namprd12.prod.outlook.com (2603:10b6:a03:a6::22)
 by BN6PR12MB1297.namprd12.prod.outlook.com (2603:10b6:404:14::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.14; Thu, 14 Jul
 2022 10:53:04 +0000
Received: from BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::41b6:a196:4f46:c9b0]) by BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::41b6:a196:4f46:c9b0%5]) with mapi id 15.20.5417.026; Thu, 14 Jul 2022
 10:53:04 +0000
Message-ID: <358b826b-126e-f1c5-7d20-614676b9810a@amd.com>
Date: Thu, 14 Jul 2022 16:22:55 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH 4/4] drm/amdgpu: drop runpm from amdgpu_device structure
Content-Language: en-US
To: Guchun Chen <guchun.chen@amd.com>, amd-gfx@lists.freedesktop.org,
 alexander.deucher@amd.com, hawking.zhang@amd.com, evan.quan@amd.com,
 kenneth.feng@amd.com
References: <20220714084305.3191-1-guchun.chen@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20220714084305.3191-1-guchun.chen@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0186.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:be::7) To BYAPR12MB4614.namprd12.prod.outlook.com
 (2603:10b6:a03:a6::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8a407a42-7610-481e-0a86-08da65870711
X-MS-TrafficTypeDiagnostic: BN6PR12MB1297:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6lyJTYPMGdo3Tb0DKR1d19P1yrjtDKHnbLgotLPtfnYPHWIHNFexeGQkxQBpvrzEJyfWQOrRlnByfKVaGTUWOLHlfKqWLS96LDKctVctndnFsnqSXuxfsYYCDgYEZ9DINOQSjBZ0wdFFzu7UgDoJxvLbdA9ke7LWgP1aNzRkwYuGlmuCjVPayLw+dQ/VC5fkRGzzhwhiGp2an0ZD9VPrdh3xaV4N68ULUthV2fK1qbJYQTk38xPVPotJu76GgcunIdSQIqpemnKQrb6ypwzCp2Xy4XKoiFLFtclO+wYVNubnk5Qz8/CoG44AuQmIUemHM5ODlbQJGD2YiNgcKABeKP3bWNqm5zzgfTUd++UEaeuvLCcyFpK36GaPj/uBQdAFsC+Jyt/S6Ci//llKpek8sAdHKywMQuBaaKh4uh1/7LH70PNtqOspkTO6+6Ad0koQ5eAWCk3fPrytMDd7FzR4J0VLpz9OJ48iGT6E5EXBccBofxjt1ixrNMTRTdDTsBO4a0RtRoqXJhpvtirerL/628t1FiAXAiOE9c63IbxiH4WWwRSzT/FFzHz4JqobUJj87YFDlq2gahIrfWT4GK3h8AHegamEgzsF9Iygzc+UMR2IhYbO+lKxyUCSwGIAUWQ+G6Ws/KPUvLkt6nOdS8s6slPChieCCBPVhH3+9qFklU6NcMyqQnO9NC3ogzaiA3IFV2KJ2jhk5RRSS3S1woAsUJdFEkUvEvdrTBhvAgokrEVBcTBOIuAWB3q0dYHwjJ9R2+5IbPcwO5nFgxqb1FvexhguuR6fkkcRq6fplhpAh4tpPXfsICdHAgMQbBt5dzPJWLFSo2PegNycP/oX4PtnAJbyilCY+hQ5to7q4+SexeE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(376002)(366004)(39860400002)(396003)(136003)(346002)(53546011)(26005)(31696002)(6512007)(41300700001)(6506007)(86362001)(6666004)(38100700002)(478600001)(6486002)(66476007)(83380400001)(186003)(2616005)(36756003)(2906002)(8676002)(316002)(66946007)(66556008)(6636002)(8936002)(31686004)(5660300002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WXNRcm1pd2N6QzQ2dE1MQnFQOGh4aENiejFoNnpRWXl0Y2d4U2kybGM3ai9Y?=
 =?utf-8?B?UzVIOWl6a085YVlWOENLamRUSEhkcStOUmViK0VUY0NSM3hPZWs5dmgrRU5P?=
 =?utf-8?B?QVp4ZGhwYW5rRFJvRTFIMzJydTQ0VWRzNFRrU3VXWFdTbURDU2ZCVXdJMEtF?=
 =?utf-8?B?Qk00cjRPSURZeW8zbXA2ZWdWWHFZQ0tqem1Jd21CUlNXQ2kvcU9lalorWURM?=
 =?utf-8?B?cng3ZnhtdzFFZTl6dlFhcTZxUzBMSjdxUjg2YTJ6QjBMMkdLeURkVkQwdHVa?=
 =?utf-8?B?NjZiMk02bmJwRUNYb1c3cVN4RFJlaktkZ3NIc0ZnclNyOGNaOGt5dU9HNXVP?=
 =?utf-8?B?RFhlVDU1eVpJcG5uOWJuWFBZOXdsR3pRNGFQOWMrOVRPdzFiazVETDRHakRX?=
 =?utf-8?B?VTRWRGNDSEhvUk1YaVZPRzAzUU5tb0ZZNGUybG9oWnZxbkxTNnM0eUE2bldN?=
 =?utf-8?B?T0dxNzdpSy9XSkdFNmlmejZxc0FCaUJDai96U2hJR1dVRXZ6cTJybGFzVVlK?=
 =?utf-8?B?ZUFSQ2VXcGhFZys3OG9XTDFBcHFXdjRLZjRtZFhzaXpDMnFDRmdsT1M1TEZB?=
 =?utf-8?B?Z2h3WURkOGdSWkxLbzVuT25xa3FERVl6L0ZaQXhXanZ0SkpMTkMyS2QxVFE4?=
 =?utf-8?B?RW1raDcxY1k4MnRZa1dDVlNIL3EzMmU1alBOQy92bFExMWRTazFiclduRXZ2?=
 =?utf-8?B?SHVyUzJqTE9oOFAyTXdwdzZocDBOMnRqWVRrZDR1Q2NpNlpzRytzMHpUNWtH?=
 =?utf-8?B?dmhpZnJmU3Y4MTRLdVNZdjVadDYvWXU4Qml5MU51Ymx4L1VMdUc2YTRWYUwr?=
 =?utf-8?B?RTE1N1k3RFNwTVlWdW9MeXJQeUpnNkN5cERrYUhWNWx3WjBRWmV0bHNKTE1n?=
 =?utf-8?B?V2dVSGJwdlN5Y1BTN3RtK0ZLMUlQQUtyVGUrUjlKOVZUWThaYytFaE9COWJH?=
 =?utf-8?B?MHpBWlZ2WTZncUpPTEJQM1BZeUJnSHlTRXFFZE4wWEJTTUNHSGViSEtTN2pr?=
 =?utf-8?B?emZ6dTVNbkk1S0FDaUE0WkhRbEw2SHUrQXdhY0JCWGh1NnVrWnNjVWxlMGsv?=
 =?utf-8?B?M3hwWWkwYUZVa3NDbVRVNXpEN2drSy9HOEdKVHVJLzhUcHlpWEZHbzVuWWVw?=
 =?utf-8?B?UmlzWXFhU2VzL0Y3S2k2bW9lQkR4Zmp2ck5sWkpRYWVqc2tIV0p6N2Uwa256?=
 =?utf-8?B?cGRCRXdKM0twSnJPenRWNWxQUExTT0l1ZmNsLzVHUDJFb2dLdlZnSHMrK0Er?=
 =?utf-8?B?VnBGamcxaHh5QTFHTysyc2FZVFV1REhqNGMrQU9oNVV5Z1JkWkFBZGFGZmR0?=
 =?utf-8?B?SGRQbGJFUSttcWdoWFpObmpOUG9YMmtoZlExZjNKVXhNTVo2eGlrTlB5VXBJ?=
 =?utf-8?B?N2g5Y1BnN25tR0pUay9TSUtCL2pWSU9iaWh4MFhjZnptYUtXZHdtUDcyQ25q?=
 =?utf-8?B?UEFaZ1E3WUliVHJnNTJNQlhEYTdnQUN6UHdJeHRINnFSYUR3T0hYWW1pc2ZO?=
 =?utf-8?B?TE1sejlTa0Y3ZHFhUndTQjRybENYaEg1U29SUlhESGtNVmRIMmU4RndvU2ho?=
 =?utf-8?B?UUdXTTg0cWtCeWVaclA5cWQxL0tTUTRLc1RBcHRzekRMcnd4ejJjYUlER3ZP?=
 =?utf-8?B?dEo2Z0tMdE5ySDJYK0ZlMkxCUk5DditnYzJ1eHhGN1RqZEQyZEh2QnQrZDNU?=
 =?utf-8?B?a3VxaDJIY1pnS0RxMkdhTE5WT2NTWDc4Y3A2T0dSSUxQNG5kWEFmdUFxZDdM?=
 =?utf-8?B?YVdzRGlqTzVHd0ovRE5SOWZlaG4vTmd2WW5NdUtvLzdBbXV1ZForZy9RZUFt?=
 =?utf-8?B?ZVV4QTdYa0psMERjMTFtWG94T2wxNVc5Q2NZMzg0cm02cERDTzhTNFNNdm5h?=
 =?utf-8?B?d3pEaGZPeURWWXVVVzdvUncrZloxZ0pWVkNPT0o2N3RjMSs4cXV2MkdMMDg2?=
 =?utf-8?B?NzNmVGxWeU40eCtvczZGb3dsU3N4YmlrYkFIUzBzM1hXaGJ0Z0FEQ0d3eHFT?=
 =?utf-8?B?TUtvM2c2dUFIbnl0U1NHbU1BWFI1SzZ3dVlMVVBDekxraU41aE1qN1NFTG1Z?=
 =?utf-8?B?UjFVM0RLMmREOURTbE5OVERocURoOGcyZm9iaU1UQXJRaGRqSHh0ZWhJUk51?=
 =?utf-8?Q?t2GBBCzNH3uotDXUMRqplDkSL?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a407a42-7610-481e-0a86-08da65870711
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2022 10:53:04.3175 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YvCyXhKLV7LLalWnN2wd+A1VsjCTeu/79NYRoMavbN1hfQdKQneIWR6u8UPamGNs
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1297
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



On 7/14/2022 2:13 PM, Guchun Chen wrote:
> It's redundant, as now switching to rpm_mode to indicate
> runtime power management mode.
> 
> Suggested-by: Lijo Lazar <lijo.lazar@amd.com>
> Signed-off-by: Guchun Chen <guchun.chen@amd.com>

Series is:
	Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu.h     |  1 -
>   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 10 +++++-----
>   drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 23 ++++++++++-------------
>   3 files changed, 15 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index 15f290c9523d..9f729a648005 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -1011,7 +1011,6 @@ struct amdgpu_device {
>   	uint64_t	df_perfmon_config_assign_mask[AMDGPU_MAX_DF_PERFMONS];
>   
>   	/* enable runtime pm on the device */
> -	bool                            runpm;
>   	bool                            in_runpm;
>   	bool                            has_pr3;
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index 1cc9260e75de..70a7203a2916 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -2118,7 +2118,7 @@ static int amdgpu_pci_probe(struct pci_dev *pdev,
>   	if (ret)
>   		DRM_ERROR("Creating debugfs files failed (%d).\n", ret);
>   
> -	if (adev->runpm) {
> +	if (adev->pm.rpm_mode != AMDGPU_RUNPM_NONE) {
>   		/* only need to skip on ATPX */
>   		if (amdgpu_device_supports_px(ddev))
>   			dev_pm_set_driver_flags(ddev->dev, DPM_FLAG_NO_DIRECT_COMPLETE);
> @@ -2175,7 +2175,7 @@ amdgpu_pci_remove(struct pci_dev *pdev)
>   
>   	drm_dev_unplug(dev);
>   
> -	if (adev->runpm) {
> +	if (adev->pm.rpm_mode != AMDGPU_RUNPM_NONE) {
>   		pm_runtime_get_sync(dev->dev);
>   		pm_runtime_forbid(dev->dev);
>   	}
> @@ -2458,7 +2458,7 @@ static int amdgpu_pmops_runtime_suspend(struct device *dev)
>   	struct amdgpu_device *adev = drm_to_adev(drm_dev);
>   	int ret, i;
>   
> -	if (!adev->runpm) {
> +	if (adev->pm.rpm_mode == AMDGPU_RUNPM_NONE) {
>   		pm_runtime_forbid(dev);
>   		return -EBUSY;
>   	}
> @@ -2527,7 +2527,7 @@ static int amdgpu_pmops_runtime_resume(struct device *dev)
>   	struct amdgpu_device *adev = drm_to_adev(drm_dev);
>   	int ret;
>   
> -	if (!adev->runpm)
> +	if (adev->pm.rpm_mode == AMDGPU_RUNPM_NONE)
>   		return -EINVAL;
>   
>   	/* Avoids registers access if device is physically gone */
> @@ -2571,7 +2571,7 @@ static int amdgpu_pmops_runtime_idle(struct device *dev)
>   	/* we don't want the main rpm_idle to call suspend - we want to autosuspend */
>   	int ret = 1;
>   
> -	if (!adev->runpm) {
> +	if (adev->pm.rpm_mode == AMDGPU_RUNPM_NONE) {
>   		pm_runtime_forbid(dev);
>   		return -EBUSY;
>   	}
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> index 9182e81e3135..a3744c0b632b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> @@ -147,14 +147,13 @@ int amdgpu_driver_load_kms(struct amdgpu_device *adev, unsigned long flags)
>   		goto out;
>   	}
>   
> +	adev->pm.rpm_mode = AMDGPU_RUNPM_NONE;
>   	if (amdgpu_device_supports_px(dev) &&
> -	    (amdgpu_runtime_pm != 0)) { /* enable runpm by default for atpx */
> -		adev->runpm = true;
> +	    (amdgpu_runtime_pm != 0)) { /* enable PX as runtime mode */
>   		adev->pm.rpm_mode = AMDGPU_RUNPM_PX;
>   		dev_info(adev->dev, "Using ATPX for runtime pm\n");
>   	} else if (amdgpu_device_supports_boco(dev) &&
> -		   (amdgpu_runtime_pm != 0)) { /* enable runpm by default for boco */
> -		adev->runpm = true;
> +		   (amdgpu_runtime_pm != 0)) { /* enable boco as runtime mode */
>   		adev->pm.rpm_mode = AMDGPU_RUNPM_BOCO;
>   		dev_info(adev->dev, "Using BOCO for runtime pm\n");
>   	} else if (amdgpu_device_supports_baco(dev) &&
> @@ -162,25 +161,23 @@ int amdgpu_driver_load_kms(struct amdgpu_device *adev, unsigned long flags)
>   		switch (adev->asic_type) {
>   		case CHIP_VEGA20:
>   		case CHIP_ARCTURUS:
> -			/* enable runpm if runpm=1 */
> +			/* enable BACO as runpm mode if runpm=1 */
>   			if (amdgpu_runtime_pm > 0)
> -				adev->runpm = true;
> +				adev->pm.rpm_mode = AMDGPU_RUNPM_BACO;
>   			break;
>   		case CHIP_VEGA10:
> -			/* turn runpm on if noretry=0 */
> +			/* enable BACO as runpm mode if noretry=0 */
>   			if (!adev->gmc.noretry)
> -				adev->runpm = true;
> +				adev->pm.rpm_mode = AMDGPU_RUNPM_BACO;
>   			break;
>   		default:
> -			/* enable runpm on CI+ */
> -			adev->runpm = true;
> +			/* enable BACO as runpm mode on CI+ */
> +			adev->pm.rpm_mode = AMDGPU_RUNPM_BACO;
>   			break;
>   		}
>   
> -		if (adev->runpm) {
> -			adev->pm.rpm_mode = AMDGPU_RUNPM_BACO;
> +		if (adev->pm.rpm_mode == AMDGPU_RUNPM_BACO)
>   			dev_info(adev->dev, "Using BACO for runtime pm\n");
> -		}
>   	}
>   
>   	/* Call ACPI methods: require modeset init
> 
