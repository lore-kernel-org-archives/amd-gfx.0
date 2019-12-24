Return-Path: <SRS0=l0jK=2O=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E6E1C2D0C0
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Dec 2019 02:04:10 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F4B82070E
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Dec 2019 02:04:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="LN+OS2YW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F4B82070E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D13076E0DB;
	Tue, 24 Dec 2019 02:04:09 +0000 (UTC)
Received: from NAM02-BL2-obe.outbound.protection.outlook.com
 (mail-eopbgr750054.outbound.protection.outlook.com [40.107.75.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 075F76E0DB
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Dec 2019 02:04:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yj8KrOMrwUVbkEJPrHVaP5sKqH5FUXWb2w8DMNjIuMtAb3812dphQrjK/uYW6GKORqhU6r/giA5m6aV9uws3TN2vdQUMkvfNs1L+hRkaxUFSSYoPYTpc+I8M/sQ85pQ61j28G1QroPVEsjprTJwXWU6S9gDQ9kaylGgOaJnRLXm/B8JtmG4pU4rC5QnmLL3bn76n6M+j63zjj37Ju4cTP+uYmesT7nJ0HtY5AdM6BbiYUtySy4Xzh7jwxeW3n7GplG+hrwLtu7Txvm+vt5jD74h4qME8imSmSzABdKrIuPOPRDnjVuKJ8HDBLdz8BS+Y7Yepi0L9ypoXDSej2/U/Dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k9XCx8oTVD+7aV9wujtyaym1gsPu3Rh/wyt4gfmPYhk=;
 b=ChJs3x3wDsNvxVbbz2SxWMeF8/vY+Nb/9s+hWEbGSyZvpU7gw4bCALRo4GDW3bWjVa1lTlwsHf3EF2blhtn7DHgxDt73kJfezYMNHO19P/9b6QXfjfvUWky02WfBJwhqq8yqttowlPUtDbQ/a82NqEqFnwoJTNONUh9dddhpn84LJI+BKXzLBzRP3/gTYNBtKy1r0RnIegvVHtk6dna/y7UBCcKwSLiavyhvC4ye575OB3uux8I5oBmd4Ivk3xvAct1avVlipv8QON2JqVGPDwBeF7/yswUwq74J86/+JuRnCOBLZi+Mw/G2PfHqe8ts4pMACZP56CqlFjOgywgECw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k9XCx8oTVD+7aV9wujtyaym1gsPu3Rh/wyt4gfmPYhk=;
 b=LN+OS2YWnzFWYbjrxHrTrivnYzi5DAy6XsJdTM7Ff61FoTtGPsPcVtPoqLAPi7IcYCrI+Po67c0rJ49Sgu6a9gyDNjsekfO22HrULpwStRUPQq6ucn7LE5G+FgiHl87YFWiylWg+7vbIopMuTwEYRArZ6AsmLLmIHVc9BoTmfW8=
Received: from MN2PR12MB3344.namprd12.prod.outlook.com (20.178.241.74) by
 MN2PR12MB4128.namprd12.prod.outlook.com (52.135.51.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2559.14; Tue, 24 Dec 2019 02:04:07 +0000
Received: from MN2PR12MB3344.namprd12.prod.outlook.com
 ([fe80::1010:4621:68dd:5b47]) by MN2PR12MB3344.namprd12.prod.outlook.com
 ([fe80::1010:4621:68dd:5b47%5]) with mapi id 15.20.2559.017; Tue, 24 Dec 2019
 02:04:07 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu/smu: make the set_performance_level logic
 easier to follow
Thread-Topic: [PATCH] drm/amdgpu/smu: make the set_performance_level logic
 easier to follow
Thread-Index: AQHVucrRyU1KyWo47k+h/EPec7XGvafIiRgw
Date: Tue, 24 Dec 2019 02:04:07 +0000
Message-ID: <MN2PR12MB334478BBD2F1F97F7C587304E4290@MN2PR12MB3344.namprd12.prod.outlook.com>
References: <20191223195425.2022741-1-alexander.deucher@amd.com>
In-Reply-To: <20191223195425.2022741-1-alexander.deucher@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=6d9f3ac4-a00c-45b8-b2ad-0000fc14cd03;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2019-12-24T02:03:32Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Evan.Quan@amd.com; 
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: e9482b0b-fa6b-46e2-7771-08d788158f4b
x-ms-traffictypediagnostic: MN2PR12MB4128:|MN2PR12MB4128:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB412835799B2141261CC0C22EE4290@MN2PR12MB4128.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2657;
x-forefront-prvs: 0261CCEEDF
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(396003)(376002)(39860400002)(136003)(366004)(189003)(199004)(13464003)(8936002)(71200400001)(7696005)(4326008)(8676002)(81156014)(30864003)(110136005)(5660300002)(316002)(81166006)(53546011)(6506007)(478600001)(86362001)(45080400002)(2906002)(26005)(66946007)(966005)(64756008)(52536014)(55016002)(76116006)(66476007)(66556008)(66446008)(186003)(9686003)(33656002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB4128;
 H:MN2PR12MB3344.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pDCYu6XjI9gDrGqRzpwLNA+OJgUmPj/3MEMX9bCImgYfj21XuiET2c/dEIZDErTpmxEWbkA5KHPbBc16mykXh7cbC+yHaceUxNtf8bi5N2ESzc/UMHUg/Njifn8Uh7kF5VB9e9JTCkqzYEkXGnc13K/XJAFcURld3GKSSg7yijTMyjrythScXbQYYc4OBjMVGHNJeN2OLLSlg4IMx7qHtKDWi9FgjQI8TE4kdIZS8F3nLdvVhkShLuwJpL3EKE9SuoVBmXl2EtZwTgJNHUQrkQm9S1WLEbP9wkNdOzvAxB09e4K2ZjDb+s/+Xdg6aJxZLdgIPs6OBtBPOOVm2TTWqs0thli3x0gUM9zdUOSBikyjJdSf7/mKxWslZExaOfhCSbSaQplu1Rmfsb5VV0cfqyFXvT8uBHDDHX81GBf0OZ9OIhU8KDbNpIEOyx+g4Djjp+uVmw6LCcS4RWTXGAy8mBtDBp9dLJKupn0M9yQOjwotzy0V+UzvmuQplDVpjvZtN+qYURIuMMclvckagm8WZMdfHMp1Zw0azneky8Tg4Gs=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9482b0b-fa6b-46e2-7771-08d788158f4b
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Dec 2019 02:04:07.4503 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: unutM1yrus5nDOQg6ez2wq4w4PYQCFQUQPxBDXfW9le5Gw41m86Xv0fAPcJSkEet
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4128
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Reviewed-by: Evan Quan <evan.quan@amd.com>

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex
> Deucher
> Sent: Tuesday, December 24, 2019 3:54 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
> Subject: [PATCH] drm/amdgpu/smu: make the set_performance_level logic
> easier to follow
> 
> Have every asic provide a callback for this rather than a mix
> of generic and asic specific code.
> 
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/powerplay/amdgpu_smu.c    | 44 +------------------
>  drivers/gpu/drm/amd/powerplay/arcturus_ppt.c  |  1 +
>  drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h |  3 ++
>  drivers/gpu/drm/amd/powerplay/navi10_ppt.c    | 30 +++++++++++--
>  drivers/gpu/drm/amd/powerplay/renoir_ppt.c    | 30 +++++++++++--
>  drivers/gpu/drm/amd/powerplay/smu_v11_0.c     | 39 ++++++++++++++++
>  drivers/gpu/drm/amd/powerplay/vega20_ppt.c    |  1 +
>  7 files changed, 100 insertions(+), 48 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
> b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
> index 936c68298786..d07c4f2ccee7 100644
> --- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
> @@ -1607,43 +1607,6 @@ static int smu_enable_umd_pstate(void *handle,
>  	return 0;
>  }
> 
> -static int smu_default_set_performance_level(struct smu_context *smu, enum
> amd_dpm_forced_level level)
> -{
> -	int ret = 0;
> -	uint32_t sclk_mask, mclk_mask, soc_mask;
> -
> -	switch (level) {
> -	case AMD_DPM_FORCED_LEVEL_HIGH:
> -		ret = smu_force_dpm_limit_value(smu, true);
> -		break;
> -	case AMD_DPM_FORCED_LEVEL_LOW:
> -		ret = smu_force_dpm_limit_value(smu, false);
> -		break;
> -	case AMD_DPM_FORCED_LEVEL_AUTO:
> -	case AMD_DPM_FORCED_LEVEL_PROFILE_STANDARD:
> -		ret = smu_unforce_dpm_levels(smu);
> -		break;
> -	case AMD_DPM_FORCED_LEVEL_PROFILE_MIN_SCLK:
> -	case AMD_DPM_FORCED_LEVEL_PROFILE_MIN_MCLK:
> -	case AMD_DPM_FORCED_LEVEL_PROFILE_PEAK:
> -		ret = smu_get_profiling_clk_mask(smu, level,
> -						 &sclk_mask,
> -						 &mclk_mask,
> -						 &soc_mask);
> -		if (ret)
> -			return ret;
> -		smu_force_clk_levels(smu, SMU_SCLK, 1 << sclk_mask, false);
> -		smu_force_clk_levels(smu, SMU_MCLK, 1 << mclk_mask,
> false);
> -		smu_force_clk_levels(smu, SMU_SOCCLK, 1 << soc_mask,
> false);
> -		break;
> -	case AMD_DPM_FORCED_LEVEL_MANUAL:
> -	case AMD_DPM_FORCED_LEVEL_PROFILE_EXIT:
> -	default:
> -		break;
> -	}
> -	return ret;
> -}
> -
>  int smu_adjust_power_state_dynamic(struct smu_context *smu,
>  				   enum amd_dpm_forced_level level,
>  				   bool skip_display_settings)
> @@ -1681,11 +1644,8 @@ int smu_adjust_power_state_dynamic(struct
> smu_context *smu,
>  	if (smu_dpm_ctx->dpm_level != level) {
>  		ret = smu_asic_set_performance_level(smu, level);
>  		if (ret) {
> -			ret = smu_default_set_performance_level(smu, level);
> -			if (ret) {
> -				pr_err("Failed to set performance level!");
> -				return ret;
> -			}
> +			pr_err("Failed to set performance level!");
> +			return ret;
>  		}
> 
>  		/* update the saved copy */
> diff --git a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
> b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
> index be4ae0aea9a0..dd575a1baeda 100644
> --- a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
> +++ b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
> @@ -2117,6 +2117,7 @@ static const struct pptable_funcs arcturus_ppt_funcs
> = {
>  	.get_profiling_clk_mask = arcturus_get_profiling_clk_mask,
>  	.get_power_profile_mode = arcturus_get_power_profile_mode,
>  	.set_power_profile_mode = arcturus_set_power_profile_mode,
> +	.set_performance_level = smu_v11_0_set_performance_level,
>  	/* debug (internal used) */
>  	.dump_pptable = arcturus_dump_pptable,
>  	.get_power_limit = arcturus_get_power_limit,
> diff --git a/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h
> b/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h
> index 786de7741990..db3f78676aeb 100644
> --- a/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h
> +++ b/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h
> @@ -262,4 +262,7 @@ int smu_v11_0_set_default_od_settings(struct
> smu_context *smu, bool initialize,
> 
>  uint32_t smu_v11_0_get_max_power_limit(struct smu_context *smu);
> 
> +int smu_v11_0_set_performance_level(struct smu_context *smu,
> +				    enum amd_dpm_forced_level level);
> +
>  #endif
> diff --git a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
> b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
> index bf87e93b26fc..a8ae5cd969a4 100644
> --- a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
> +++ b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
> @@ -1649,19 +1649,43 @@ static int navi10_set_peak_clock_by_device(struct
> smu_context *smu)
>  	return ret;
>  }
> 
> -static int navi10_set_performance_level(struct smu_context *smu, enum
> amd_dpm_forced_level level)
> +static int navi10_set_performance_level(struct smu_context *smu,
> +					enum amd_dpm_forced_level level)
>  {
>  	int ret = 0;
> +	uint32_t sclk_mask, mclk_mask, soc_mask;
> 
>  	switch (level) {
> +	case AMD_DPM_FORCED_LEVEL_HIGH:
> +		ret = smu_force_dpm_limit_value(smu, true);
> +		break;
> +	case AMD_DPM_FORCED_LEVEL_LOW:
> +		ret = smu_force_dpm_limit_value(smu, false);
> +		break;
> +	case AMD_DPM_FORCED_LEVEL_AUTO:
> +	case AMD_DPM_FORCED_LEVEL_PROFILE_STANDARD:
> +		ret = smu_unforce_dpm_levels(smu);
> +		break;
> +	case AMD_DPM_FORCED_LEVEL_PROFILE_MIN_SCLK:
> +	case AMD_DPM_FORCED_LEVEL_PROFILE_MIN_MCLK:
> +		ret = smu_get_profiling_clk_mask(smu, level,
> +						 &sclk_mask,
> +						 &mclk_mask,
> +						 &soc_mask);
> +		if (ret)
> +			return ret;
> +		smu_force_clk_levels(smu, SMU_SCLK, 1 << sclk_mask, false);
> +		smu_force_clk_levels(smu, SMU_MCLK, 1 << mclk_mask,
> false);
> +		smu_force_clk_levels(smu, SMU_SOCCLK, 1 << soc_mask,
> false);
> +		break;
>  	case AMD_DPM_FORCED_LEVEL_PROFILE_PEAK:
>  		ret = navi10_set_peak_clock_by_device(smu);
>  		break;
> +	case AMD_DPM_FORCED_LEVEL_MANUAL:
> +	case AMD_DPM_FORCED_LEVEL_PROFILE_EXIT:
>  	default:
> -		ret = -EINVAL;
>  		break;
>  	}
> -
>  	return ret;
>  }
> 
> diff --git a/drivers/gpu/drm/amd/powerplay/renoir_ppt.c
> b/drivers/gpu/drm/amd/powerplay/renoir_ppt.c
> index 979772dbe6a9..e73644beffd9 100644
> --- a/drivers/gpu/drm/amd/powerplay/renoir_ppt.c
> +++ b/drivers/gpu/drm/amd/powerplay/renoir_ppt.c
> @@ -708,19 +708,43 @@ static int renoir_set_peak_clock_by_device(struct
> smu_context *smu)
>  	return ret;
>  }
> 
> -static int renoir_set_performance_level(struct smu_context *smu, enum
> amd_dpm_forced_level level)
> +static int renoir_set_performance_level(struct smu_context *smu,
> +					enum amd_dpm_forced_level level)
>  {
>  	int ret = 0;
> +	uint32_t sclk_mask, mclk_mask, soc_mask;
> 
>  	switch (level) {
> +	case AMD_DPM_FORCED_LEVEL_HIGH:
> +		ret = smu_force_dpm_limit_value(smu, true);
> +		break;
> +	case AMD_DPM_FORCED_LEVEL_LOW:
> +		ret = smu_force_dpm_limit_value(smu, false);
> +		break;
> +	case AMD_DPM_FORCED_LEVEL_AUTO:
> +	case AMD_DPM_FORCED_LEVEL_PROFILE_STANDARD:
> +		ret = smu_unforce_dpm_levels(smu);
> +		break;
> +	case AMD_DPM_FORCED_LEVEL_PROFILE_MIN_SCLK:
> +	case AMD_DPM_FORCED_LEVEL_PROFILE_MIN_MCLK:
> +		ret = smu_get_profiling_clk_mask(smu, level,
> +						 &sclk_mask,
> +						 &mclk_mask,
> +						 &soc_mask);
> +		if (ret)
> +			return ret;
> +		smu_force_clk_levels(smu, SMU_SCLK, 1 << sclk_mask, false);
> +		smu_force_clk_levels(smu, SMU_MCLK, 1 << mclk_mask,
> false);
> +		smu_force_clk_levels(smu, SMU_SOCCLK, 1 << soc_mask,
> false);
> +		break;
>  	case AMD_DPM_FORCED_LEVEL_PROFILE_PEAK:
>  		ret = renoir_set_peak_clock_by_device(smu);
>  		break;
> +	case AMD_DPM_FORCED_LEVEL_MANUAL:
> +	case AMD_DPM_FORCED_LEVEL_PROFILE_EXIT:
>  	default:
> -		ret = -EINVAL;
>  		break;
>  	}
> -
>  	return ret;
>  }
> 
> diff --git a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
> b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
> index 7781d245f8ef..73935cf7ff39 100644
> --- a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
> +++ b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
> @@ -1860,3 +1860,42 @@ int smu_v11_0_set_default_od_settings(struct
> smu_context *smu, bool initialize,
>  	}
>  	return ret;
>  }
> +
> +int smu_v11_0_set_performance_level(struct smu_context *smu,
> +				    enum amd_dpm_forced_level level)
> +{
> +	int ret = 0;
> +	uint32_t sclk_mask, mclk_mask, soc_mask;
> +
> +	switch (level) {
> +	case AMD_DPM_FORCED_LEVEL_HIGH:
> +		ret = smu_force_dpm_limit_value(smu, true);
> +		break;
> +	case AMD_DPM_FORCED_LEVEL_LOW:
> +		ret = smu_force_dpm_limit_value(smu, false);
> +		break;
> +	case AMD_DPM_FORCED_LEVEL_AUTO:
> +	case AMD_DPM_FORCED_LEVEL_PROFILE_STANDARD:
> +		ret = smu_unforce_dpm_levels(smu);
> +		break;
> +	case AMD_DPM_FORCED_LEVEL_PROFILE_MIN_SCLK:
> +	case AMD_DPM_FORCED_LEVEL_PROFILE_MIN_MCLK:
> +	case AMD_DPM_FORCED_LEVEL_PROFILE_PEAK:
> +		ret = smu_get_profiling_clk_mask(smu, level,
> +						 &sclk_mask,
> +						 &mclk_mask,
> +						 &soc_mask);
> +		if (ret)
> +			return ret;
> +		smu_force_clk_levels(smu, SMU_SCLK, 1 << sclk_mask, false);
> +		smu_force_clk_levels(smu, SMU_MCLK, 1 << mclk_mask,
> false);
> +		smu_force_clk_levels(smu, SMU_SOCCLK, 1 << soc_mask,
> false);
> +		break;
> +	case AMD_DPM_FORCED_LEVEL_MANUAL:
> +	case AMD_DPM_FORCED_LEVEL_PROFILE_EXIT:
> +	default:
> +		break;
> +	}
> +	return ret;
> +}
> +
> diff --git a/drivers/gpu/drm/amd/powerplay/vega20_ppt.c
> b/drivers/gpu/drm/amd/powerplay/vega20_ppt.c
> index 250ff5aa1305..534c46bc0146 100644
> --- a/drivers/gpu/drm/amd/powerplay/vega20_ppt.c
> +++ b/drivers/gpu/drm/amd/powerplay/vega20_ppt.c
> @@ -3194,6 +3194,7 @@ static const struct pptable_funcs vega20_ppt_funcs =
> {
>  	.get_od_percentage = vega20_get_od_percentage,
>  	.get_power_profile_mode = vega20_get_power_profile_mode,
>  	.set_power_profile_mode = vega20_set_power_profile_mode,
> +	.set_performance_level = smu_v11_0_set_performance_level,
>  	.set_od_percentage = vega20_set_od_percentage,
>  	.set_default_od_settings = vega20_set_default_od_settings,
>  	.od_edit_dpm_table = vega20_odn_edit_dpm_table,
> --
> 2.24.1
> 
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.free
> desktop.org%2Fmailman%2Flistinfo%2Famd-
> gfx&amp;data=02%7C01%7Cevan.quan%40amd.com%7Cb54028f3ace24b8530c
> 608d787e1ef9c%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C6371
> 27276822420727&amp;sdata=HIikQGIFZM84MDP%2B%2F%2BCMWrHJoCPWm
> 0TbynxSjCz3rwU%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
