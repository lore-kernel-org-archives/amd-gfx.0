Return-Path: <SRS0=Inwe=AH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34CFDC433DF
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Jun 2020 01:01:18 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E863C20702
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Jun 2020 01:01:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="HrrIwbx8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E863C20702
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A5B9C6EC2F;
	Fri, 26 Jun 2020 01:01:17 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2061.outbound.protection.outlook.com [40.107.94.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 737D46EC2D
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Jun 2020 01:01:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EXISwIa6N+j+6fZ6d/tITgHYGlb7FTzng0DdhkCLmStxIAufAOuW/GrXaIepJWkrIUX9DiQA7Z04Q5grxXLFEnd1tDS8MM5U2OaYtkMXGtLn3O1ZHQ46tZ48QJ0BChI4bVbF8chsCDXZEIUoErRv5jiNz2z6uxqW3/VO5uAjZN0GqLsLPvdGfIYaQvVJ/Zrlur8EIsiQjpXxhp+N42Iw8gugSWAP62FSmkrAReCbRY0rHBsfDLHPWgQgpBbZiDd1E4yjsbKll7bcKvY1shxSCDWW56WpfxQROVmaW1jS7j7p/mMVgByOrHfS8wkEHexvSjtEHLL4+xTc1VbJSlwx0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MT5vfomIcuAR8kMxr8PsAiQ/KWg6xhR9er3MbluVrZ8=;
 b=NIx8+YjTI0YyhRvxafokw2Nk54B0vp3rMc9hoYOM57seF85EqXM8C/9u2YJRBhYo332ucOFq13dvfUTIekhY1dSXZzxhrf4NC00zIoMu7zXKybfI5iQHOxc+3kpm6FjtqIiX96pFTXYeyOSWxhz0xv1qGHsUE4YjK1i3af0ds2aFX43Mia80Oyn5pAO+d8g+DeL2db5aU2npVX05UVavjhV+K+bsDz1mrOjoK5h4BPPyEVpORecQRJSkkv5udtSg2nHSxAlsPbF8Rc8kOCWLSLfjczN/cYV7x+nW+7Xd2XbZBW76UJ/qtp6ISl14fG1PBMyw0i6SVcSfjGkTHaalZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MT5vfomIcuAR8kMxr8PsAiQ/KWg6xhR9er3MbluVrZ8=;
 b=HrrIwbx8Yl1lmQ0+iyu4KfoC0axOI9o14+7CBnQXCcRKNpBDA2HbmTQ04/o/ZTvr0edHZ0WHGgIi/mLFZgtd5LE/TISkKTxdTeD4cGb+JFMzA/YGKmVEC9pZvbIjW8/atvGM4YEUqAIcm1RNNGhVkjyRFoPxLwAbdULds2Yc8YI=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3355.namprd12.prod.outlook.com (2603:10b6:5:115::26)
 by DM6PR12MB4577.namprd12.prod.outlook.com (2603:10b6:5:2aa::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.21; Fri, 26 Jun
 2020 01:01:09 +0000
Received: from DM6PR12MB3355.namprd12.prod.outlook.com
 ([fe80::918f:4ee4:be8f:9be]) by DM6PR12MB3355.namprd12.prod.outlook.com
 ([fe80::918f:4ee4:be8f:9be%5]) with mapi id 15.20.3131.024; Fri, 26 Jun 2020
 01:01:09 +0000
Subject: Re: [PATCH] drm/amdgpu: SI support for UVD and VCE power managment
To: Alex Jivin <alex.jivin@amd.com>, amd-gfx@lists.freedesktop.org
References: <20200624114948.30948-1-alex.jivin@amd.com>
From: Luben Tuikov <luben.tuikov@amd.com>
Message-ID: <68420ab1-7f76-c100-bf67-38d458e1ebdd@amd.com>
Date: Thu, 25 Jun 2020 21:01:07 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
In-Reply-To: <20200624114948.30948-1-alex.jivin@amd.com>
Content-Language: en-CA
X-ClientProxiedBy: YT1PR01CA0021.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::34)
 To DM6PR12MB3355.namprd12.prod.outlook.com
 (2603:10b6:5:115::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (108.162.131.176) by
 YT1PR01CA0021.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::34) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3131.21 via Frontend Transport; Fri, 26 Jun 2020 01:01:08 +0000
X-Originating-IP: [108.162.131.176]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: d28fb3b7-48f1-4aa5-00cb-08d8196c6995
X-MS-TrafficTypeDiagnostic: DM6PR12MB4577:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB45774B0625811C3A9BBBBCF899930@DM6PR12MB4577.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1227;
X-Forefront-PRVS: 0446F0FCE1
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iSXzK/+fTXwB0pMYWZAhwIE5nPF3EVcvTX90TUyagFMKMe1n/2/zCCGIQjrKTlLR0Iv6moltCz+QWGKqeuPcGCo0ufgY9n95CXU2aFAAcUdWtugVQg78CKOv8SJvfH6mAgw+Dh53AhgXRi22ZT7gp1GLdoSyi9XcXsdnhZYH/0T3JgA1DrcofjtdFi+Qkck7qQ5H24y+8hBmKZHwnr8+f6usy7IfO3pZvtFColNDSuENxXC/r5XZlKNfwpnMkLhMmcJyKsgsQXuKuO+2vmcw/TLIBe/dIen8pLpcomepiGaGRQ55BCiBW6JRn1NbGA1ioqLF97Hv/DsJp1laNM9jZVMuQCgD4i+H4FmcLpLoKakoLYQZDfaqUGA3JKGQBELK4Y0ln96iYIobLWJF3NKG0A==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3355.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(376002)(346002)(366004)(39860400002)(136003)(6512007)(86362001)(52116002)(5660300002)(30864003)(36756003)(66556008)(31696002)(8676002)(478600001)(6486002)(66946007)(66476007)(8936002)(53546011)(55236004)(83380400001)(316002)(6506007)(186003)(16526019)(2616005)(2906002)(31686004)(44832011)(4326008)(26005)(956004)(21314003)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: c1SHtbm9QfGnMmg0YA/x+T4rM2d41w2SXWmRuz0X1ysiRdWbD06DOI5QBUx8cT/xP7xjmOtHh0i1vDIKIO3Q9trXyFAaXLEgm9AK2q7+SpE5DLlNZ7Q6araxGNpeUhwkT+BNYFZcJXMnMd0ZPJ6WMOsVTIRcJFlGjDsotS5o5donXj8bjh4+Vcz9yxwlWkGY90RUiDeIUwvoM2cEtJrSJMosu9ScbRjMO9enktDQDNvzM4+PZttr1E3MSwg3biRLJAQkI9Mc5Phkve+CJkfdgzBD7G+db3sTNw4zZwLStOgsHCTPrfgRXKg3CngFgk3vY+to85MsjzhZVKC689fUj4GQ3SoicYyzJfhkb4dfMPvUDX1R5K+Ibqfwom6flkXsuJNj8zxx0sDLQuTqpeopre0joFYCrY+Ld+AwoZuLE5LuWJXFB3xS2pP1dRdiUYEQE8dNPWfbR8Tzd62BIEJKHSHi/ZzqihIO0RU8cxD9bnMEVNMbaHu7IMlFR8dyEz85
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d28fb3b7-48f1-4aa5-00cb-08d8196c6995
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3355.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2020 01:01:09.3719 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QZfvnDAjESAQcKrN7B0UctYAa1jGuTrNqXMUz+24WTJiwWaF3dh9jzZkCg5Oxodx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4577
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2020-06-24 7:49 a.m., Alex Jivin wrote:
> Port functionality from the Radeon driver to support
> UVD and VCE power management.
> 
> Signed-off-by: Alex Jivin <alex.jivin@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h    |   9 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c |  67 +++--
>  drivers/gpu/drm/amd/amdgpu/si.c        | 361 ++++++++++++++++++++++++-
>  drivers/gpu/drm/amd/amdgpu/si_dpm.c    |  19 ++
>  drivers/gpu/drm/amd/amdgpu/sid.h       |  32 +++
>  5 files changed, 462 insertions(+), 26 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index 6c7dd0a707c9..4b5a9a259a21 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -1083,6 +1083,15 @@ int emu_soc_asic_init(struct amdgpu_device *adev);
>  		tmp_ |= ((val) & ~(mask));			\
>  		WREG32_PLL(reg, tmp_);				\
>  	} while (0)
> +
> +#define WREG32_SMC_P(_Reg, _Val, _Mask)                         \
> +	do {                                                    \
> +		u32 tmp = RREG32_SMC(_Reg);                     \
> +		tmp &= (_Mask);                                 \
> +		tmp |= ((_Val) & ~(_Mask));                     \
> +		WREG32_SMC(_Reg, tmp);                          \
> +	} while (0)
> +
>  #define DREG32_SYS(sqf, adev, reg) seq_printf((sqf), #reg " : 0x%08X\n", amdgpu_device_rreg((adev), (reg), false))
>  #define RREG32_IO(reg) amdgpu_io_rreg(adev, (reg))
>  #define WREG32_IO(reg, v) amdgpu_io_wreg(adev, (reg), (v))
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
> index 347b06d3c140..26c8e39a78bd 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
> @@ -3558,21 +3558,36 @@ void amdgpu_dpm_enable_uvd(struct amdgpu_device *adev, bool enable)
>  {
>  	int ret = 0;

There is no reason to pre-initialize "ret" to 0.
Remove it here and define it locally in the "else"
as "int ret;".

>  
> -	ret = amdgpu_dpm_set_powergating_by_smu(adev, AMD_IP_BLOCK_TYPE_UVD, !enable);
> -	if (ret)
> -		DRM_ERROR("Dpm %s uvd failed, ret = %d. \n",
> -			  enable ? "enable" : "disable", ret);
> -
> -	/* enable/disable Low Memory PState for UVD (4k videos) */
> -	if (adev->asic_type == CHIP_STONEY &&
> -		adev->uvd.decode_image_width >= WIDTH_4K) {
> -		struct pp_hwmgr *hwmgr = adev->powerplay.pp_handle;
> +	if (adev->family == AMDGPU_FAMILY_SI) {
> +		if (enable) {
> +			mutex_lock(&adev->pm.mutex);
> +			adev->pm.dpm.uvd_active = true;
> +			adev->pm.dpm.state = POWER_STATE_TYPE_INTERNAL_UVD;
> +			mutex_unlock(&adev->pm.mutex);
> +		} else {
> +			mutex_lock(&adev->pm.mutex);
> +			adev->pm.dpm.uvd_active = false;
> +			mutex_unlock(&adev->pm.mutex);
> +		}

Move the mutex around the comound "if" to have single matching

	mutex_lock()
	if (...) {
		...
	} else {
		...
	}
	mutex_unlock();

I'd not be surprised if the compiler does this already, as it can prove
that the mutex will be taken and released, regardless of the value of "enable".

>  
> -		if (hwmgr && hwmgr->hwmgr_func &&
> -		    hwmgr->hwmgr_func->update_nbdpm_pstate)
> -			hwmgr->hwmgr_func->update_nbdpm_pstate(hwmgr,
> -							       !enable,
> -							       true);
> +		amdgpu_pm_compute_clocks(adev);
> +	} else {
> +		ret = amdgpu_dpm_set_powergating_by_smu(adev, AMD_IP_BLOCK_TYPE_UVD, !enable);
> +		if (ret)
> +			DRM_ERROR("Dpm %s uvd failed, ret = %d. \n",

Remove the space before the quoted newline.

> +				  enable ? "enable" : "disable", ret);
> +
> +		/* enable/disable Low Memory PState for UVD (4k videos) */
> +		if (adev->asic_type == CHIP_STONEY &&
> +			adev->uvd.decode_image_width >= WIDTH_4K) {

The line above should be aligned with the open parenthesis.

> +			struct pp_hwmgr *hwmgr = adev->powerplay.pp_handle;
> +
> +			if (hwmgr && hwmgr->hwmgr_func &&
> +			    hwmgr->hwmgr_func->update_nbdpm_pstate)
> +				hwmgr->hwmgr_func->update_nbdpm_pstate(hwmgr,
> +								       !enable,
> +								       true);
> +		}
>  	}
>  }
>  
> @@ -3580,10 +3595,26 @@ void amdgpu_dpm_enable_vce(struct amdgpu_device *adev, bool enable)
>  {
>  	int ret = 0;

int ret;

>  
> -	ret = amdgpu_dpm_set_powergating_by_smu(adev, AMD_IP_BLOCK_TYPE_VCE, !enable);
> -	if (ret)
> -		DRM_ERROR("Dpm %s vce failed, ret = %d. \n",
> -			  enable ? "enable" : "disable", ret);
> +	if (adev->family == AMDGPU_FAMILY_SI) {
> +		if (enable) {
> +			mutex_lock(&adev->pm.mutex);
> +			adev->pm.dpm.vce_active = true;
> +			/* XXX select vce level based on ring/task */
> +			adev->pm.dpm.vce_level = AMD_VCE_LEVEL_AC_ALL;
> +			mutex_unlock(&adev->pm.mutex);
> +		} else {
> +			mutex_lock(&adev->pm.mutex);
> +			adev->pm.dpm.vce_active = false;
> +			mutex_unlock(&adev->pm.mutex);
> +		}

Move the mutex outside the if() as it is independent of
the conditional "if (enable)", i.e. the mutex is ALWAYS
taken.

> +
> +		amdgpu_pm_compute_clocks(adev);
> +	} else {
> +		ret = amdgpu_dpm_set_powergating_by_smu(adev, AMD_IP_BLOCK_TYPE_VCE, !enable);
> +		if (ret)
> +			DRM_ERROR("Dpm %s vce failed, ret = %d. \n",

Remove the space before the quoted newline.

> +				  enable ? "enable" : "disable", ret);
> +	}
>  }
>  
>  void amdgpu_pm_print_power_states(struct amdgpu_device *adev)
> diff --git a/drivers/gpu/drm/amd/amdgpu/si.c b/drivers/gpu/drm/amd/amdgpu/si.c
> index cda9aa5e4b9e..471489436b49 100644
> --- a/drivers/gpu/drm/amd/amdgpu/si.c
> +++ b/drivers/gpu/drm/amd/amdgpu/si.c
> @@ -1266,12 +1266,6 @@ static u32 si_get_xclk(struct amdgpu_device *adev)
>  	return reference_clock;
>  }
>  
> -//xxx:not implemented
> -static int si_set_uvd_clocks(struct amdgpu_device *adev, u32 vclk, u32 dclk)
> -{
> -	return 0;
> -}
> -
>  static void si_flush_hdp(struct amdgpu_device *adev, struct amdgpu_ring *ring)
>  {
>  	if (!ring || !ring->funcs->emit_wreg) {
> @@ -1427,6 +1421,358 @@ static uint64_t si_get_pcie_replay_count(struct amdgpu_device *adev)
>  	return (nak_r + nak_g);
>  }
>  
> +static int si_uvd_send_upll_ctlreq(struct amdgpu_device *adev,
> +				   unsigned cg_upll_func_cntl)
> +{
> +	unsigned i;

Use "unsigned int".

Or just "int". Both will do equally
well to iterate from 0 to SI_MAX_CTLACKS_ASSERTION_WAIT.
You're not using this varaible in "size_t" promotion,
so it's all good.

> +
> +	/* Make sure UPLL_CTLREQ is deasserted */
> +	WREG32_P(cg_upll_func_cntl, 0, ~UPLL_CTLREQ_MASK);
> +
> +	mdelay(10);
> +
> +	/* Assert UPLL_CTLREQ */
> +	WREG32_P(cg_upll_func_cntl, UPLL_CTLREQ_MASK, ~UPLL_CTLREQ_MASK);

Here you'll probably need to wait a little bit, for the hardware
to actually act on your register write, before
you read the status below. In my experience CPUs are very fast
compared to exernal HW over a bus, and the first back-to-back
READ will almost certainly return "not yet".

Traditionally the pause here to "do something" is larger than
the "polling pause" below--the "polling pause" being smaller
as it could be done "anytime now".

> +
> +	/* Wait for CTLACK and CTLACK2 to get asserted */
> +	for (i = 0; i < SI_MAX_CTLACKS_ASSERTION_WAIT; ++i) {
> +		uint32_t mask = UPLL_CTLACK_MASK | UPLL_CTLACK2_MASK;
> +
> +		if ((RREG32(cg_upll_func_cntl) & mask) == mask)
> +			break;
> +		mdelay(10);
> +	}
> +
> +	/* Deassert UPLL_CTLREQ */
> +	WREG32_P(cg_upll_func_cntl, 0, ~UPLL_CTLREQ_MASK);
> +
> +	if (i == SI_MAX_CTLACKS_ASSERTION_WAIT) {
> +		DRM_ERROR("Timeout setting UVD clocks!\n");
> +		return -ETIMEDOUT;

There is a corner case here. Look at your loop above.
You check for assertion, then you wait 10 ms, then 
increment i, and if i >= SI_MAX... you quit and declare
defeat.

What if it was asserted during that very last delay?
10 ms is a long time...

> +	}
> +
> +	return 0;
> +}
> +
> +static unsigned si_uvd_calc_upll_post_div(unsigned vco_freq,
> +					  unsigned target_freq,
> +					  unsigned pd_min,
> +					  unsigned pd_even)
> +{
> +	unsigned post_div = vco_freq / target_freq;

unsigned int;

> +
> +	/* Adjust to post divider minimum value */
> +	if (post_div < pd_min)
> +		post_div = pd_min;
> +
> +	/* We alway need a frequency less than or equal the target */
> +	if ((vco_freq / post_div) > target_freq)
> +		post_div += 1;

Had we not conditionally overwritten post_div with pd_min above,
then this check is equivlent to checking "vco_freq % target_freq > 0"
If there is a remainder, then increment post_div. It's almost as if
it is trying to find a divisor of vco_freq to get target_freq without
a remainder--when plugged into the loop of the calling function.

> +
> +	/* Post dividers above a certain value must be even */
> +	if (post_div > pd_even && post_div % 2)
> +		post_div += 1;

If we didn't have the "if (post_div > pd_even"
then this would be just a single line without
a conditional:

post_div = (post_div + 1) & ~1.

> +
> +	return post_div;
> +}
> +
> +/**
> + * si_calc_upll_dividers - calc UPLL clock dividers
> + *
> + * @adev: amdgpu_device pointer
> + * @vclk: wanted VCLK
> + * @dclk: wanted DCLK
> + * @vco_min: minimum VCO frequency
> + * @vco_max: maximum VCO frequency
> + * @fb_factor: factor to multiply vco freq with
> + * @fb_mask: limit and bitmask for feedback divider
> + * @pd_min: post divider minimum
> + * @pd_max: post divider maximum
> + * @pd_even: post divider must be even above this value
> + * @optimal_fb_div: resulting feedback divider
> + * @optimal_vclk_div: resulting vclk post divider
> + * @optimal_dclk_div: resulting dclk post divider
> + *
> + * Calculate dividers for UVDs UPLL (except APUs).

A more detailed comment here would be good--explaining exactly
what is wanted and how it is achieved. The iterative (almost
Newtonian-approximation like) method of calculating those values
should be described and most importantly, regardless of the method
used, what we want to get.

> + * Returns zero on success; -EINVAL on error.
> + */
> +static int si_calc_upll_dividers(struct amdgpu_device *adev,
> +				 unsigned vclk, unsigned dclk,
> +				 unsigned vco_min, unsigned vco_max,
> +				 unsigned fb_factor, unsigned fb_mask,
> +				 unsigned pd_min, unsigned pd_max,
> +				 unsigned pd_even,
> +				 unsigned *optimal_fb_div,
> +				 unsigned *optimal_vclk_div,
> +				 unsigned *optimal_dclk_div)
> +{
> +	unsigned vco_freq, ref_freq = adev->clock.spll.reference_freq;
> +
> +	/* Start off with something large */
> +	unsigned optimal_score = ~0;

unsigned int;

> +
> +	/* Loop through vco from low to high */
> +	vco_min = max(max(vco_min, vclk), dclk);
> +	for (vco_freq = vco_min; vco_freq <= vco_max; vco_freq += 100) {
> +		uint64_t fb_div = (uint64_t)vco_freq * fb_factor;
> +		unsigned vclk_div, dclk_div, score;
> +
> +		do_div(fb_div, ref_freq);
> +
> +		/* fb div out of range ? */
> +		if (fb_div > fb_mask)
> +			break; /* It can oly get worse */
> +
> +		fb_div &= fb_mask;
> +
> +		/* Calc vclk divider with current vco freq */
> +		vclk_div = si_uvd_calc_upll_post_div(vco_freq, vclk,
> +						     pd_min, pd_even);
> +		if (vclk_div > pd_max)
> +			break; /* vco is too big, it has to stop */
> +
> +		/* Calc dclk divider with current vco freq */
> +		dclk_div = si_uvd_calc_upll_post_div(vco_freq, dclk,
> +						     pd_min, pd_even);
> +		if (dclk_div > pd_max)
> +			break; /* vco is too big, it has to stop */
> +
> +		/* Calc score with current vco freq */
> +		score = vclk - (vco_freq / vclk_div) + dclk - (vco_freq / dclk_div);
> +
> +		/* Determine if this vco setting is better than current optimal settings */
> +		if (score < optimal_score) {
> +			*optimal_fb_div = fb_div;
> +			*optimal_vclk_div = vclk_div;
> +			*optimal_dclk_div = dclk_div;
> +			optimal_score = score;
> +			if (optimal_score == 0)
> +				break; /* It can't get better than this */
> +		}
> +	}

Isn't there a closed form of this iterative calculation?
(I feel there should be, but not sure what it is trying to achieve.)

> +
> +	/* Did we found a valid setup ? */
> +	if (optimal_score == ~0)
> +		return -EINVAL;
> +
> +	return 0;
> +}
> +
> +static int si_set_uvd_clocks(struct amdgpu_device *adev, u32 vclk, u32 dclk)
> +{
> +	unsigned fb_div = 0, vclk_div = 0, dclk_div = 0;

unsigned int;

> +	int a;
> +
> +	/* Bypass vclk and dclk with bclk */
> +	WREG32_P(CG_UPLL_FUNC_CNTL_2,
> +		 VCLK_SRC_SEL(1) | DCLK_SRC_SEL(1),
> +		 ~(VCLK_SRC_SEL_MASK | DCLK_SRC_SEL_MASK));
> +
> +	/* Put PLL in bypass mode */
> +	WREG32_P(CG_UPLL_FUNC_CNTL, UPLL_BYPASS_EN_MASK, ~UPLL_BYPASS_EN_MASK);
> +
> +	if (!vclk || !dclk) {
> +		/* Keep the Bypass mode */
> +		return 0;
> +	}
> +
> +	a = si_calc_upll_dividers(adev, vclk, dclk, 125000, 250000,
> +				  16384, 0x03FFFFFF, 0, 128, 5,
> +				  &fb_div, &vclk_div, &dclk_div);

Hardcoded constants?
Will those hadcoded constants make sense for all boards in amdgpu?
How about the hardcoded time delays?

> +	if (a)
> +		return a;
> +
> +	/* Set RESET_ANTI_MUX to 0 */
> +	WREG32_P(CG_UPLL_FUNC_CNTL_5, 0, ~RESET_ANTI_MUX_MASK);
> +
> +	/* Set VCO_MODE to 1 */
> +	WREG32_P(CG_UPLL_FUNC_CNTL, UPLL_VCO_MODE_MASK, ~UPLL_VCO_MODE_MASK);
> +
> +	/* Disable sleep mode */
> +	WREG32_P(CG_UPLL_FUNC_CNTL, 0, ~UPLL_SLEEP_MASK);
> +
> +	/* Deassert UPLL_RESET */
> +	WREG32_P(CG_UPLL_FUNC_CNTL, 0, ~UPLL_RESET_MASK);
> +
> +	mdelay(1);
> +
> +	a = si_uvd_send_upll_ctlreq(adev, CG_UPLL_FUNC_CNTL);
> +	if (a)
> +		return a;
> +
> +	/* Assert UPLL_RESET again */
> +	WREG32_P(CG_UPLL_FUNC_CNTL, UPLL_RESET_MASK, ~UPLL_RESET_MASK);
> +
> +	/* Disable spread spectrum. */
> +	WREG32_P(CG_UPLL_SPREAD_SPECTRUM, 0, ~SSEN_MASK);
> +
> +	/* Set feedback divider */
> +	WREG32_P(CG_UPLL_FUNC_CNTL_3, UPLL_FB_DIV(fb_div), ~UPLL_FB_DIV_MASK);
> +
> +	/* Set ref divider to 0 */
> +	WREG32_P(CG_UPLL_FUNC_CNTL, 0, ~UPLL_REF_DIV_MASK);
> +
> +	if (fb_div < 307200)
> +		WREG32_P(CG_UPLL_FUNC_CNTL_4, 0, ~UPLL_SPARE_ISPARE9);
> +	else
> +		WREG32_P(CG_UPLL_FUNC_CNTL_4,
> +			 UPLL_SPARE_ISPARE9,
> +			 ~UPLL_SPARE_ISPARE9);
> +
> +	/* Set PDIV_A and PDIV_B */
> +	WREG32_P(CG_UPLL_FUNC_CNTL_2,
> +		 UPLL_PDIV_A(vclk_div) | UPLL_PDIV_B(dclk_div),
> +		 ~(UPLL_PDIV_A_MASK | UPLL_PDIV_B_MASK));
> +
> +	/* Give the PLL some time to settle */
> +	mdelay(15);
> +
> +	/* Deassert PLL_RESET */
> +	WREG32_P(CG_UPLL_FUNC_CNTL, 0, ~UPLL_RESET_MASK);
> +
> +	mdelay(15);
> +
> +	/* Switch from bypass mode to normal mode */
> +	WREG32_P(CG_UPLL_FUNC_CNTL, 0, ~UPLL_BYPASS_EN_MASK);
> +
> +	a = si_uvd_send_upll_ctlreq(adev, CG_UPLL_FUNC_CNTL);
> +	if (a)
> +		return a;
> +
> +	/* Switch VCLK and DCLK selection */
> +	WREG32_P(CG_UPLL_FUNC_CNTL_2,
> +		 VCLK_SRC_SEL(2) | DCLK_SRC_SEL(2),
> +		 ~(VCLK_SRC_SEL_MASK | DCLK_SRC_SEL_MASK));
> +
> +	mdelay(100);
> +
> +	return 0;
> +}
> +
> +static int si_vce_send_vcepll_ctlreq(struct amdgpu_device *adev)
> +{
> +	unsigned i;
> +
> +	/* Make sure VCEPLL_CTLREQ is deasserted */
> +	WREG32_SMC_P(CG_VCEPLL_FUNC_CNTL, 0, ~UPLL_CTLREQ_MASK);
> +
> +	mdelay(10);
> +
> +	/* Assert UPLL_CTLREQ */
> +	WREG32_SMC_P(CG_VCEPLL_FUNC_CNTL, UPLL_CTLREQ_MASK, ~UPLL_CTLREQ_MASK);
> +
> +	/* Wait for CTLACK and CTLACK2 to get asserted */
> +	for (i = 0; i < SI_MAX_CTLACKS_ASSERTION_WAIT; ++i) {
> +		uint32_t mask = UPLL_CTLACK_MASK | UPLL_CTLACK2_MASK;
> +
> +		if ((RREG32_SMC(CG_VCEPLL_FUNC_CNTL) & mask) == mask)
> +			break;
> +		mdelay(10);
> +	}
> +
> +	/* Deassert UPLL_CTLREQ */
> +	WREG32_SMC_P(CG_VCEPLL_FUNC_CNTL, 0, ~UPLL_CTLREQ_MASK);
> +
> +	if (i == SI_MAX_CTLACKS_ASSERTION_WAIT) {
> +		DRM_ERROR("Timeout setting UVD clocks!\n");
> +		return -ETIMEDOUT;
> +	}
> +
> +	return 0;
> +}
> +
> +static int si_set_vce_clocks(struct amdgpu_device *adev, u32 evclk, u32 ecclk)
> +{
> +	unsigned fb_div = 0, evclk_div = 0, ecclk_div = 0;

unsigned int;

> +	int a;
> +
> +	/* Bypass evclk and ecclk with bclk */
> +	WREG32_SMC_P(CG_VCEPLL_FUNC_CNTL_2,
> +		     EVCLK_SRC_SEL(1) | ECCLK_SRC_SEL(1),
> +		     ~(EVCLK_SRC_SEL_MASK | ECCLK_SRC_SEL_MASK));
> +
> +	/* Put PLL in bypass mode */
> +	WREG32_SMC_P(CG_VCEPLL_FUNC_CNTL, VCEPLL_BYPASS_EN_MASK,
> +		     ~VCEPLL_BYPASS_EN_MASK);
> +
> +	if (!evclk || !ecclk) {
> +		/* Keep the Bypass mode, put PLL to sleep */
> +		WREG32_SMC_P(CG_VCEPLL_FUNC_CNTL, VCEPLL_SLEEP_MASK,
> +			     ~VCEPLL_SLEEP_MASK);
> +		return 0;
> +	}
> +
> +	a = si_calc_upll_dividers(adev, evclk, ecclk, 125000, 250000,
> +				  16384, 0x03FFFFFF, 0, 128, 5,
> +				  &fb_div, &evclk_div, &ecclk_div);
> +	if (a)
> +		return a;
> +
> +	/* Set RESET_ANTI_MUX to 0 */
> +	WREG32_SMC_P(CG_VCEPLL_FUNC_CNTL_5, 0, ~RESET_ANTI_MUX_MASK);
> +
> +	/* Set VCO_MODE to 1 */
> +	WREG32_SMC_P(CG_VCEPLL_FUNC_CNTL, VCEPLL_VCO_MODE_MASK,
> +		     ~VCEPLL_VCO_MODE_MASK);
> +
> +	/* Toggle VCEPLL_SLEEP to 1 then back to 0 */
> +	WREG32_SMC_P(CG_VCEPLL_FUNC_CNTL, VCEPLL_SLEEP_MASK,
> +		     ~VCEPLL_SLEEP_MASK);
> +	WREG32_SMC_P(CG_VCEPLL_FUNC_CNTL, 0, ~VCEPLL_SLEEP_MASK);
> +
> +	/* Deassert VCEPLL_RESET */
> +	WREG32_SMC_P(CG_VCEPLL_FUNC_CNTL, 0, ~VCEPLL_RESET_MASK);
> +
> +	mdelay(1);
> +
> +	a = si_vce_send_vcepll_ctlreq(adev);
> +	if (a)
> +		return a;
> +
> +	/* Assert VCEPLL_RESET again */
> +	WREG32_SMC_P(CG_VCEPLL_FUNC_CNTL, VCEPLL_RESET_MASK, ~VCEPLL_RESET_MASK);
> +
> +	/* Disable spread spectrum. */
> +	WREG32_SMC_P(CG_VCEPLL_SPREAD_SPECTRUM, 0, ~SSEN_MASK);
> +
> +	/* Set feedback divider */
> +	WREG32_SMC_P(CG_VCEPLL_FUNC_CNTL_3,
> +		     VCEPLL_FB_DIV(fb_div),
> +		     ~VCEPLL_FB_DIV_MASK);
> +
> +	/* Set ref divider to 0 */
> +	WREG32_SMC_P(CG_VCEPLL_FUNC_CNTL, 0, ~VCEPLL_REF_DIV_MASK);
> +
> +	/* Set PDIV_A and PDIV_B */
> +	WREG32_SMC_P(CG_VCEPLL_FUNC_CNTL_2,
> +		     VCEPLL_PDIV_A(evclk_div) | VCEPLL_PDIV_B(ecclk_div),
> +		     ~(VCEPLL_PDIV_A_MASK | VCEPLL_PDIV_B_MASK));
> +
> +	/* Give the PLL some time to settle */
> +	mdelay(15);
> +
> +	/* Deassert PLL_RESET */
> +	WREG32_SMC_P(CG_VCEPLL_FUNC_CNTL, 0, ~VCEPLL_RESET_MASK);
> +
> +	mdelay(15);
> +
> +	/* Switch from bypass mode to normal mode */
> +	WREG32_SMC_P(CG_VCEPLL_FUNC_CNTL, 0, ~VCEPLL_BYPASS_EN_MASK);
> +
> +	a = si_vce_send_vcepll_ctlreq(adev);
> +	if (a)
> +		return a;
> +
> +	/* Switch VCLK and DCLK selection */
> +	WREG32_SMC_P(CG_VCEPLL_FUNC_CNTL_2,
> +		     EVCLK_SRC_SEL(16) | ECCLK_SRC_SEL(16),
> +		     ~(EVCLK_SRC_SEL_MASK | ECCLK_SRC_SEL_MASK));
> +
> +	mdelay(100);
> +
> +	return 0;
> +}
> +
>  static const struct amdgpu_asic_funcs si_asic_funcs =
>  {
>  	.read_disabled_bios = &si_read_disabled_bios,
> @@ -1437,7 +1783,7 @@ static const struct amdgpu_asic_funcs si_asic_funcs =
>  	.set_vga_state = &si_vga_set_state,
>  	.get_xclk = &si_get_xclk,
>  	.set_uvd_clocks = &si_set_uvd_clocks,
> -	.set_vce_clocks = NULL,
> +	.set_vce_clocks = &si_set_vce_clocks,
>  	.get_pcie_lanes = &si_get_pcie_lanes,
>  	.set_pcie_lanes = &si_set_pcie_lanes,
>  	.get_config_memsize = &si_get_config_memsize,
> @@ -2228,4 +2574,3 @@ int si_set_ip_blocks(struct amdgpu_device *adev)
>  	}
>  	return 0;
>  }
> -
> diff --git a/drivers/gpu/drm/amd/amdgpu/si_dpm.c b/drivers/gpu/drm/amd/amdgpu/si_dpm.c
> index c00ba4b23c9a..ea914b256ebd 100644
> --- a/drivers/gpu/drm/amd/amdgpu/si_dpm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/si_dpm.c
> @@ -6953,6 +6953,24 @@ static int si_power_control_set_level(struct amdgpu_device *adev)
>  	return 0;
>  }
>  
> +static void si_set_vce_clock(struct amdgpu_device *adev,
> +			     struct amdgpu_ps *new_rps,
> +			     struct amdgpu_ps *old_rps)
> +{
> +	if ((old_rps->evclk != new_rps->evclk) ||
> +	    (old_rps->ecclk != new_rps->ecclk)) {

You don't need parenthesis around != due to precedence rules.

> +		/* Turn the clocks on when encoding, off otherwise */
> +		if (new_rps->evclk || new_rps->ecclk) {
> +			/* Place holder for future VCE1.0 porting to amdgpu
> +			vce_v1_0_enable_mgcg(adev, false, false);*/

Don't comment out code like this as it is not very visible that it is a comment.
Instead the kernel prefers block comments like this:

/* Existing comment.
 * commented out code;
 * ...
 */

> +		} else {
> +			/* Place holder for future VCE1.0 porting to amdgpu
> +			vce_v1_0_enable_mgcg(adev, true, false);
> +			amdgpu_asic_set_vce_clocks(adev, new_rps->evclk, new_rps->ecclk);*/

See note on comment above.

Since the porting is done (with this patch), shouldn't these be uncommented?

Regrds,
Luben

> +		}
> +	}
> +}
> +
>  static int si_dpm_set_power_state(void *handle)
>  {
>  	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
> @@ -7029,6 +7047,7 @@ static int si_dpm_set_power_state(void *handle)
>  		return ret;
>  	}
>  	ni_set_uvd_clock_after_set_eng_clock(adev, new_ps, old_ps);
> +	si_set_vce_clock(adev, new_ps, old_ps);
>  	if (eg_pi->pcie_performance_request)
>  		si_notify_link_speed_change_after_state_change(adev, new_ps, old_ps);
>  	ret = si_set_power_state_conditionally_enable_ulv(adev, new_ps);
> diff --git a/drivers/gpu/drm/amd/amdgpu/sid.h b/drivers/gpu/drm/amd/amdgpu/sid.h
> index 75b5d441b628..6156a795ad6f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sid.h
> +++ b/drivers/gpu/drm/amd/amdgpu/sid.h
> @@ -47,6 +47,7 @@
>  #define SI_MAX_LDS_NUM           	0xFFFF
>  #define SI_MAX_TCC               	16
>  #define SI_MAX_TCC_MASK          	0xFFFF
> +#define SI_MAX_CTLACKS_ASSERTION_WAIT   100
>  
>  #define AMDGPU_NUM_OF_VMIDS 		8
>  
> @@ -2479,4 +2480,35 @@
>  
>  #define	MC_VM_FB_OFFSET					0x81a
>  
> +/* Discrete VCE clocks */
> +#define CG_VCEPLL_FUNC_CNTL                             0xc0030600
> +#define    VCEPLL_RESET_MASK                            0x00000001
> +#define    VCEPLL_SLEEP_MASK                            0x00000002
> +#define    VCEPLL_BYPASS_EN_MASK                        0x00000004
> +#define    VCEPLL_CTLREQ_MASK                           0x00000008
> +#define    VCEPLL_VCO_MODE_MASK                         0x00000600
> +#define    VCEPLL_REF_DIV_MASK                          0x003F0000
> +#define    VCEPLL_CTLACK_MASK                           0x40000000
> +#define    VCEPLL_CTLACK2_MASK                          0x80000000
> +
> +#define CG_VCEPLL_FUNC_CNTL_2                           0xc0030601
> +#define    VCEPLL_PDIV_A(x)                             ((x) << 0)
> +#define    VCEPLL_PDIV_A_MASK                           0x0000007F
> +#define    VCEPLL_PDIV_B(x)                             ((x) << 8)
> +#define    VCEPLL_PDIV_B_MASK                           0x00007F00
> +#define    EVCLK_SRC_SEL(x)                             ((x) << 20)
> +#define    EVCLK_SRC_SEL_MASK                           0x01F00000
> +#define    ECCLK_SRC_SEL(x)                             ((x) << 25)
> +#define    ECCLK_SRC_SEL_MASK                           0x3E000000
> +
> +#define CG_VCEPLL_FUNC_CNTL_3                           0xc0030602
> +#define    VCEPLL_FB_DIV(x)                             ((x) << 0)
> +#define    VCEPLL_FB_DIV_MASK                           0x01FFFFFF
> +
> +#define CG_VCEPLL_FUNC_CNTL_4                           0xc0030603
> +
> +#define CG_VCEPLL_FUNC_CNTL_5                           0xc0030604
> +#define CG_VCEPLL_SPREAD_SPECTRUM                       0xc0030606
> +#define    VCEPLL_SSEN_MASK                             0x00000001
> +
>  #endif
> 

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
