Return-Path: <SRS0=793y=2J=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96522C43603
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Dec 2019 22:03:59 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 68A0E24679
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Dec 2019 22:03:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="eE8YjSVC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68A0E24679
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 26FF76EBA0;
	Thu, 19 Dec 2019 22:03:59 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2063.outbound.protection.outlook.com [40.107.244.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AEEB96EBA0
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Dec 2019 22:03:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B/maV+EwOVzzvctb7ZgO96EWFq+57oIYAUbcVF3spnhSSUBUKIjInpTzFuVo/3oZRti2fB5ZLWdMeK6C1rtkEbJJshYp0MNPEsGWWL6WjbGfatvRdo/I1xSWcYoqwgR5ir9HHI2iyzwu2QYyvDAnOZXun7t0Wle2qQPV46bm+25sSBfd26lkqKWfbv5nzenSIaWT1Bv224eBXHfIestvQNZECvEeFGKqJevL6MHC+XP+Ni2vv/mGNa+HcbMc8Ibm01ZLd6BQnxt4615FDY2q2DA6ZgzC13DGOVBmVXI/NT/3xNf1XMklXk4jQaoJEV4x31Qjy4OWpcSNtkK2FaUiBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=11oUaT48x64GXGxP454soryjMX8jgufnII4QOtp7ho4=;
 b=mklDslzp7N1PTA2IRTsZgdt2GfsY5nXrW5aixz5Woi6i+w9knTlVi128m56WWse6aNmderLjSLbVWnYhh4dpQFf3KjVrGYUzGySBN8TlHekdmb/lAwfL+qq7zmG30T1OcEIGu16ui/z2ovuUsIlKCrzy9V1pYWGSQegEvqthG6un0x8hgix48v3I8QvgiEm1aw7yFongWvLF1+KCmD1YZ2+biJVqVpLC+pUgyxz2TA852pTvL+EdOqv6r8EZ1kkLA4+/1zDVKFOgFSAt+nTvkaXfT1q+BLQStP1cXDn5cJt+0Oy2UNHQa1ZyIlymdsPPK2bmz4xGPpKILY4KbOe5OQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=11oUaT48x64GXGxP454soryjMX8jgufnII4QOtp7ho4=;
 b=eE8YjSVCAthysDIbl41zNYWYJr+gAxvPcDMChDkK0iSGUDpbzBQ9mpsnSL1tDrOf28Ht3+bm6o0kZv9EjIe3ub9wKVPbOiJHr63gkazs4TxjCWkrj4KjZQZo7IsFEAp4OSx3ZSGloBZbCbHBc7E4/DnMR778kwR5Bg9TdI3Yp9Y=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Felix.Kuehling@amd.com; 
Received: from DM6PR12MB3947.namprd12.prod.outlook.com (10.255.175.222) by
 DM6PR12MB3162.namprd12.prod.outlook.com (20.179.71.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.19; Thu, 19 Dec 2019 22:03:56 +0000
Received: from DM6PR12MB3947.namprd12.prod.outlook.com
 ([fe80::a099:6fd7:e4d6:f560]) by DM6PR12MB3947.namprd12.prod.outlook.com
 ([fe80::a099:6fd7:e4d6:f560%3]) with mapi id 15.20.2538.019; Thu, 19 Dec 2019
 22:03:56 +0000
Subject: Re: [PATCH] drm/amdgpu: attempt xgmi perfmon re-arm on failed arm
To: Jonathan Kim <jonathan.kim@amd.com>, amd-gfx@lists.freedesktop.org
References: <20191219213044.129948-1-jonathan.kim@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
Message-ID: <a78088ea-505f-23d7-3168-f865b4c57022@amd.com>
Date: Thu, 19 Dec 2019 17:03:54 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
In-Reply-To: <20191219213044.129948-1-jonathan.kim@amd.com>
Content-Language: en-US
X-ClientProxiedBy: YTOPR0101CA0039.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:14::16) To DM6PR12MB3947.namprd12.prod.outlook.com
 (2603:10b6:5:148::30)
MIME-Version: 1.0
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 10606e25-6181-4275-1c91-08d784cf578e
X-MS-TrafficTypeDiagnostic: DM6PR12MB3162:|DM6PR12MB3162:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB31629359E9DA5EE7DF037B2592520@DM6PR12MB3162.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 0256C18696
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(366004)(39860400002)(346002)(136003)(396003)(199004)(189003)(53546011)(31686004)(36916002)(6512007)(52116002)(2906002)(186003)(8676002)(81166006)(6506007)(6486002)(2616005)(81156014)(86362001)(36756003)(5660300002)(4001150100001)(31696002)(26005)(478600001)(66476007)(66556008)(66946007)(44832011)(316002)(8936002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB3162;
 H:DM6PR12MB3947.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /siydkKSBwXtSdtivdP+bZXSbp0Udz6ao3mUVfvqApta+7I838qbw6y0Xf/xz42isVagdyith1IWpqtcFxCp8831tiiizGpyGaZruD0U3KSegL/ynoloskdDycEEO1IF5r1hGZKqBlrYBk+DZpmHcvYeE60qbYDiysnQGz1pgbge64rlonbk8yB0UeWQPS19n0GBkkEzh/uR8dv26KhbdJFc8Z8lP/6y0kNVaIkPt2pcC0uIzb8dESoMvrUConcOcJqEwtoUWf5674tLZYU0WZs0vY1kCrWAL+Hs4lba5hGDZLhJa8GrsCxE6KuFDEphqKW+Jcerb8SBW8Tt8Q4pd+RGTZh7mK9j1x6tTserJigSBqpXPNE35kq8T2/0nLH/cGKA8eJ/3Gnmarw818vEO7kwtfs4iHgRsGpjTDuF0iRFplNzh59S0OVq81eByLQ6
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10606e25-6181-4275-1c91-08d784cf578e
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2019 22:03:56.1810 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 396/Lxi/tBS7r07Fo63TBDrbKavUnoQJRK7VnJoMa/DtA3oaDOzymfdmuklhqRJ63Ubziq4M2sBN6d2QjOGdPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3162
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2019-12-19 4:30 p.m., Jonathan Kim wrote:
> The DF routines to arm xGMI performance will attempt to re-arm both on
> performance monitoring start and read on initial failure to arm.
>
> v3: Addressing nit-picks.
>
> v2: Roll back reset_perfmon_cntr to void return since new perfmon
> counters are now safe to write to during DF C-States.  Do single perfmon
> controller re-arm when counter is deferred in pmc_count versus multiple
> perfmon controller re-arms that could last 1 millisecond. Avoid holding
> spin lock during sleep in perfmon_arm_with_retry.  Rename counter arm
> defer function to be less confusing.
>
> Signed-off-by: Jonathan Kim <Jonathan.Kim@amd.com>

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


> ---
>   drivers/gpu/drm/amd/amdgpu/df_v3_6.c | 151 +++++++++++++++++++++++----
>   1 file changed, 129 insertions(+), 22 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/df_v3_6.c b/drivers/gpu/drm/amd/amdgpu/df_v3_6.c
> index 4043ebcea5de..2f884d941e8d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/df_v3_6.c
> +++ b/drivers/gpu/drm/amd/amdgpu/df_v3_6.c
> @@ -183,6 +183,61 @@ static void df_v3_6_perfmon_wreg(struct amdgpu_device *adev, uint32_t lo_addr,
>   	spin_unlock_irqrestore(&adev->pcie_idx_lock, flags);
>   }
>   
> +/* same as perfmon_wreg but return status on write value check */
> +static int df_v3_6_perfmon_arm_with_status(struct amdgpu_device *adev,
> +					  uint32_t lo_addr, uint32_t lo_val,
> +					  uint32_t hi_addr, uint32_t  hi_val)
> +{
> +	unsigned long flags, address, data;
> +	uint32_t lo_val_rb, hi_val_rb;
> +
> +	address = adev->nbio.funcs->get_pcie_index_offset(adev);
> +	data = adev->nbio.funcs->get_pcie_data_offset(adev);
> +
> +	spin_lock_irqsave(&adev->pcie_idx_lock, flags);
> +	WREG32(address, lo_addr);
> +	WREG32(data, lo_val);
> +	WREG32(address, hi_addr);
> +	WREG32(data, hi_val);
> +
> +	WREG32(address, lo_addr);
> +	lo_val_rb = RREG32(data);
> +	WREG32(address, hi_addr);
> +	hi_val_rb = RREG32(data);
> +	spin_unlock_irqrestore(&adev->pcie_idx_lock, flags);
> +
> +	if (!(lo_val == lo_val_rb && hi_val == hi_val_rb))
> +		return -EBUSY;
> +
> +	return 0;
> +}
> +
> +
> +/*
> + * retry arming counters every 100 usecs within 1 millisecond interval.
> + * if retry fails after time out, return error.
> + */
> +#define ARM_RETRY_USEC_TIMEOUT	1000
> +#define ARM_RETRY_USEC_INTERVAL	100
> +static int df_v3_6_perfmon_arm_with_retry(struct amdgpu_device *adev,
> +					  uint32_t lo_addr, uint32_t lo_val,
> +					  uint32_t hi_addr, uint32_t  hi_val)
> +{
> +	int countdown = ARM_RETRY_USEC_TIMEOUT;
> +
> +	while (countdown) {
> +
> +		if (!df_v3_6_perfmon_arm_with_status(adev, lo_addr, lo_val,
> +						     hi_addr, hi_val))
> +			break;
> +
> +		countdown -= ARM_RETRY_USEC_INTERVAL;
> +		udelay(ARM_RETRY_USEC_INTERVAL);
> +	}
> +
> +	return countdown > 0 ? 0 : -ETIME;
> +}
> +
>   /* get the number of df counters available */
>   static ssize_t df_v3_6_get_df_cntr_avail(struct device *dev,
>   		struct device_attribute *attr,
> @@ -334,20 +389,20 @@ static void df_v3_6_pmc_get_addr(struct amdgpu_device *adev,
>   	switch (target_cntr) {
>   
>   	case 0:
> -		*lo_base_addr = is_ctrl ? smnPerfMonCtlLo0 : smnPerfMonCtrLo0;
> -		*hi_base_addr = is_ctrl ? smnPerfMonCtlHi0 : smnPerfMonCtrHi0;
> +		*lo_base_addr = is_ctrl ? smnPerfMonCtlLo4 : smnPerfMonCtrLo4;
> +		*hi_base_addr = is_ctrl ? smnPerfMonCtlHi4 : smnPerfMonCtrHi4;
>   		break;
>   	case 1:
> -		*lo_base_addr = is_ctrl ? smnPerfMonCtlLo1 : smnPerfMonCtrLo1;
> -		*hi_base_addr = is_ctrl ? smnPerfMonCtlHi1 : smnPerfMonCtrHi1;
> +		*lo_base_addr = is_ctrl ? smnPerfMonCtlLo5 : smnPerfMonCtrLo5;
> +		*hi_base_addr = is_ctrl ? smnPerfMonCtlHi5 : smnPerfMonCtrHi5;
>   		break;
>   	case 2:
> -		*lo_base_addr = is_ctrl ? smnPerfMonCtlLo2 : smnPerfMonCtrLo2;
> -		*hi_base_addr = is_ctrl ? smnPerfMonCtlHi2 : smnPerfMonCtrHi2;
> +		*lo_base_addr = is_ctrl ? smnPerfMonCtlLo6 : smnPerfMonCtrLo6;
> +		*hi_base_addr = is_ctrl ? smnPerfMonCtlHi6 : smnPerfMonCtrHi6;
>   		break;
>   	case 3:
> -		*lo_base_addr = is_ctrl ? smnPerfMonCtlLo3 : smnPerfMonCtrLo3;
> -		*hi_base_addr = is_ctrl ? smnPerfMonCtlHi3 : smnPerfMonCtrHi3;
> +		*lo_base_addr = is_ctrl ? smnPerfMonCtlLo7 : smnPerfMonCtrLo7;
> +		*hi_base_addr = is_ctrl ? smnPerfMonCtlHi7 : smnPerfMonCtrHi7;
>   		break;
>   
>   	}
> @@ -422,6 +477,44 @@ static int df_v3_6_pmc_add_cntr(struct amdgpu_device *adev,
>   	return -ENOSPC;
>   }
>   
> +#define DEFERRED_ARM_MASK	(1 << 31)
> +static int df_v3_6_pmc_set_deferred(struct amdgpu_device *adev,
> +				    uint64_t config, bool is_deferred)
> +{
> +	int target_cntr;
> +
> +	target_cntr = df_v3_6_pmc_config_2_cntr(adev, config);
> +
> +	if (target_cntr < 0)
> +		return -EINVAL;
> +
> +	if (is_deferred)
> +		adev->df_perfmon_config_assign_mask[target_cntr] |=
> +							DEFERRED_ARM_MASK;
> +	else
> +		adev->df_perfmon_config_assign_mask[target_cntr] &=
> +							~DEFERRED_ARM_MASK;
> +
> +	return 0;
> +}
> +
> +static bool df_v3_6_pmc_is_deferred(struct amdgpu_device *adev,
> +				    uint64_t config)
> +{
> +	int target_cntr;
> +
> +	target_cntr = df_v3_6_pmc_config_2_cntr(adev, config);
> +
> +	/*
> +	 * we never get target_cntr < 0 since this function is only called in
> +	 * pmc_count for now but we should check anyways.
> +	 */
> +	return (target_cntr >= 0 &&
> +			(adev->df_perfmon_config_assign_mask[target_cntr]
> +			& DEFERRED_ARM_MASK));
> +
> +}
> +
>   /* release performance counter */
>   static void df_v3_6_pmc_release_cntr(struct amdgpu_device *adev,
>   				     uint64_t config)
> @@ -451,29 +544,33 @@ static int df_v3_6_pmc_start(struct amdgpu_device *adev, uint64_t config,
>   			     int is_enable)
>   {
>   	uint32_t lo_base_addr, hi_base_addr, lo_val, hi_val;
> -	int ret = 0;
> +	int err = 0, ret = 0;
>   
>   	switch (adev->asic_type) {
>   	case CHIP_VEGA20:
> +		if (is_enable)
> +			return df_v3_6_pmc_add_cntr(adev, config);
>   
>   		df_v3_6_reset_perfmon_cntr(adev, config);
>   
> -		if (is_enable) {
> -			ret = df_v3_6_pmc_add_cntr(adev, config);
> -		} else {
> -			ret = df_v3_6_pmc_get_ctrl_settings(adev,
> +		ret = df_v3_6_pmc_get_ctrl_settings(adev,
>   					config,
>   					&lo_base_addr,
>   					&hi_base_addr,
>   					&lo_val,
>   					&hi_val);
>   
> -			if (ret)
> -				return ret;
> +		if (ret)
> +			return ret;
> +
> +		err = df_v3_6_perfmon_arm_with_retry(adev,
> +						     lo_base_addr,
> +						     lo_val,
> +						     hi_base_addr,
> +						     hi_val);
>   
> -			df_v3_6_perfmon_wreg(adev, lo_base_addr, lo_val,
> -					hi_base_addr, hi_val);
> -		}
> +		if (err)
> +			ret = df_v3_6_pmc_set_deferred(adev, config, true);
>   
>   		break;
>   	default:
> @@ -501,7 +598,7 @@ static int df_v3_6_pmc_stop(struct amdgpu_device *adev, uint64_t config,
>   		if (ret)
>   			return ret;
>   
> -		df_v3_6_perfmon_wreg(adev, lo_base_addr, 0, hi_base_addr, 0);
> +		df_v3_6_reset_perfmon_cntr(adev, config);
>   
>   		if (is_disable)
>   			df_v3_6_pmc_release_cntr(adev, config);
> @@ -518,18 +615,29 @@ static void df_v3_6_pmc_get_count(struct amdgpu_device *adev,
>   				  uint64_t config,
>   				  uint64_t *count)
>   {
> -	uint32_t lo_base_addr, hi_base_addr, lo_val, hi_val;
> +	uint32_t lo_base_addr, hi_base_addr, lo_val = 0, hi_val = 0;
>   	*count = 0;
>   
>   	switch (adev->asic_type) {
>   	case CHIP_VEGA20:
> -
>   		df_v3_6_pmc_get_read_settings(adev, config, &lo_base_addr,
>   				      &hi_base_addr);
>   
>   		if ((lo_base_addr == 0) || (hi_base_addr == 0))
>   			return;
>   
> +		/* rearm the counter or throw away count value on failure */
> +		if (df_v3_6_pmc_is_deferred(adev, config)) {
> +			int rearm_err = df_v3_6_perfmon_arm_with_status(adev,
> +							lo_base_addr, lo_val,
> +							hi_base_addr, hi_val);
> +
> +			if (rearm_err)
> +				return;
> +
> +			df_v3_6_pmc_set_deferred(adev, config, false);
> +		}
> +
>   		df_v3_6_perfmon_rreg(adev, lo_base_addr, &lo_val,
>   				hi_base_addr, &hi_val);
>   
> @@ -542,7 +650,6 @@ static void df_v3_6_pmc_get_count(struct amdgpu_device *adev,
>   			 config, lo_base_addr, hi_base_addr, lo_val, hi_val);
>   
>   		break;
> -
>   	default:
>   		break;
>   	}
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
