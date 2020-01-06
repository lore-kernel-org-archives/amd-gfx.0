Return-Path: <SRS0=Ai3v=23=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E128C32767
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Jan 2020 06:34:37 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 505D421734
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Jan 2020 06:34:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="CiXbOCFV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 505D421734
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 135C189DA3;
	Mon,  6 Jan 2020 06:34:37 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2081.outbound.protection.outlook.com [40.107.94.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 996AC89DA3
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 Jan 2020 06:34:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aFzRmIUqCTD4ivxsAV4FxxLSFB14dbPAOzfdZuRPIk9YgjS4SAt0WhEOtcsnGsiUEnvwtwuZBQI34Is8KoAadczO8tBeIdUqRheLTTGSAT+5w3b5t7YCAT/fOSLU/BFNbMhA2iECI5Imm1mOwNAzxogcoxexAoEa4tpU2AZJur5/0rRggyIfZ+Gc4vMe4Rz8oSF90I6TG1bGQOuLykWdbLZpr+lZZibWOhD/kg0Lv3Vm2CjIN7XkwEdkKx5i5VGkq/g0JIbnx6sAe3yq24lz2NTVFlZCknhKibEnOTpAshfT02N5eyvJFqddVsDI4GTIH5pgAkw6fo05bxFO1vUkmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=db58MpRCydcI26qMYjHdRgqiazI4ga7AqyKQM2XkSFs=;
 b=nzB/cosrXiqdqznzdJwAcr9Kl8PpBLJBXMRWJCwmJ5MFCd1lBlvX79miU9FgxDQyPnwcAJLQs7+5yAjlQrj9mVsCBqXMNJ7gamoaW40Y6KZWH1vFlvE7MDUSYPBQx9LRmzW5EcXJbI3I6TV2CmkPOpl+Dr9fbtRZFXhVi3zw6b60+ytYccb/6Itqj53xpEzIaNr03VECjrUhgot/XJTXdL2ZQQQXmz7EBDRYKIrkMp8ra+fW9W9MEiVGvb6erH1ygLyw395ceBWGGinaKfpjYp0NP7Dvi30eB4mj4t0WhMC5J1ORCsV38ATo0OsmN3LRhzEctxjnKqJjWVQ+Mw/7RQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=db58MpRCydcI26qMYjHdRgqiazI4ga7AqyKQM2XkSFs=;
 b=CiXbOCFVidiA05sePzbdxrqeGcEG7IUqqUlOkVhdvc4VBh0fIUkdCwzzxIfuabSvyrsl+yrmiRKq1LK0bJVouYpjsDduFx/ISV73qUM56bZP/wWJUyLbowI3G4m3T5BzwZpLk2SkhfXz8GzChwHiII96FAg3y0d3/Pz2oskzKaY=
Received: from MN2PR12MB3344.namprd12.prod.outlook.com (20.178.241.74) by
 MN2PR12MB3151.namprd12.prod.outlook.com (20.178.244.80) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2602.12; Mon, 6 Jan 2020 06:34:33 +0000
Received: from MN2PR12MB3344.namprd12.prod.outlook.com
 ([fe80::1010:4621:68dd:5b47]) by MN2PR12MB3344.namprd12.prod.outlook.com
 ([fe80::1010:4621:68dd:5b47%5]) with mapi id 15.20.2602.015; Mon, 6 Jan 2020
 06:34:33 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/powerplay: cleanup the interfaces for powergate
 setting through SMU
Thread-Topic: [PATCH] drm/amd/powerplay: cleanup the interfaces for powergate
 setting through SMU
Thread-Index: AQHVwhq+WCCffDXwKkSJ/RBr+m3KkafdMnZg
Date: Mon, 6 Jan 2020 06:34:33 +0000
Message-ID: <MN2PR12MB3344AD82B711BE728E325097E43C0@MN2PR12MB3344.namprd12.prod.outlook.com>
References: <20200103094639.32372-1-evan.quan@amd.com>
In-Reply-To: <20200103094639.32372-1-evan.quan@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=4174d230-d550-4100-8da0-0000bc36b3dc;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-01-06T06:34:25Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Evan.Quan@amd.com; 
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d98c17e0-7286-4ba4-eda2-08d792727e34
x-ms-traffictypediagnostic: MN2PR12MB3151:
x-microsoft-antispam-prvs: <MN2PR12MB315104AF0D745B86BDC51D6DE43C0@MN2PR12MB3151.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:309;
x-forefront-prvs: 0274272F87
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(136003)(396003)(346002)(39860400002)(366004)(199004)(189003)(13464003)(6916009)(33656002)(81166006)(81156014)(8676002)(8936002)(53546011)(71200400001)(66446008)(86362001)(64756008)(7696005)(6506007)(76116006)(66476007)(66556008)(66946007)(478600001)(2906002)(5660300002)(52536014)(55016002)(26005)(186003)(316002)(9686003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3151;
 H:MN2PR12MB3344.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6VLY6MkA1qRqgBqtcJj7rzjAF1t6TkAd0YbW/GV1ADfj3T8XZitX78rQqEyFD5CDWFqxZIMi1CI0iIdnANW1zD+lxrvlW6wMnqJqriMQkh+GYBvt1fNBZA3Htj42phTsGEwAOXXdnLMxtZGVktHOXYWqZHRIn9FHCicf5BY/wuxxSRM9JJTa173JI0mK8HNGGMk8RF84tsYRwI5K424W95TPiRG0OCR1K8d9Xpr0t6VaL1UBc1Ltg9yB2vamI4NaNXG4J9zcCVAquvg8USPhxNL5lLyLYKjxdrNI7LkSWsMexIQgwhHe/bT+GjN+ztcwcr7JwuXUnAepqVpwOkvEodfpC1jjQyDiWNWELQ//UfFsRdVR3hvRq1MdPqhhPdkHWAulWKLA4ewNCUVmg5gZSJYKrGUejGzypcWDwXDRVeMxjlbtd67NmXUQoEASLnQ+Qq+ld96nMQQr9DnFwLdRvt8kcuXGLoBuBbuH4zseoEsDjDQGz7iP6o8trxyoLN2i
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d98c17e0-7286-4ba4-eda2-08d792727e34
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jan 2020 06:34:33.6620 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fkKD6sdh2v2M6+QrD6glhM8Mr+DtBZ/PsPjWqZ3FTH+mtp2ailoyJWkCcuE0v7Lt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3151
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Ping..

> -----Original Message-----
> From: Quan, Evan <Evan.Quan@amd.com>
> Sent: Friday, January 3, 2020 5:47 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Quan, Evan <Evan.Quan@amd.com>
> Subject: [PATCH] drm/amd/powerplay: cleanup the interfaces for powergate
> setting through SMU
> 
> Provided an unified entry point. And fixed the confusing that the API usage is
> conflict with what the naming implies.
> 
> Change-Id: If068980ca6a7b223d0b4d087cd99cdeb729b0e77
> Signed-off-by: Evan Quan <evan.quan@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_dpm.c    | 23 ++++++++++--
>  drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c     | 43 ++++++++--------------
>  drivers/gpu/drm/amd/powerplay/amdgpu_smu.c |  6 +--
>  3 files changed, 37 insertions(+), 35 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dpm.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_dpm.c
> index 9cc270efee7c..cd76fbf4385d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dpm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dpm.c
> @@ -951,16 +951,31 @@ int amdgpu_dpm_set_powergating_by_smu(struct
> amdgpu_device *adev, uint32_t block
>  	case AMD_IP_BLOCK_TYPE_VCN:
>  	case AMD_IP_BLOCK_TYPE_VCE:
>  	case AMD_IP_BLOCK_TYPE_SDMA:
> +		if (swsmu) {
> +			ret = smu_dpm_set_power_gate(&adev->smu,
> block_type, gate);
> +		} else {
> +			if (adev->powerplay.pp_funcs &&
> +			    adev->powerplay.pp_funcs-
> >set_powergating_by_smu) {
> +				mutex_lock(&adev->pm.mutex);
> +				ret = ((adev)->powerplay.pp_funcs-
> >set_powergating_by_smu(
> +					(adev)->powerplay.pp_handle,
> block_type, gate));
> +				mutex_unlock(&adev->pm.mutex);
> +			}
> +		}
> +		break;
> +	case AMD_IP_BLOCK_TYPE_JPEG:
>  		if (swsmu)
>  			ret = smu_dpm_set_power_gate(&adev->smu,
> block_type, gate);
> -		else
> -			ret = ((adev)->powerplay.pp_funcs-
> >set_powergating_by_smu(
> -				(adev)->powerplay.pp_handle, block_type,
> gate));
>  		break;
>  	case AMD_IP_BLOCK_TYPE_GMC:
>  	case AMD_IP_BLOCK_TYPE_ACP:
> -		ret = ((adev)->powerplay.pp_funcs->set_powergating_by_smu(
> +		if (adev->powerplay.pp_funcs &&
> +		    adev->powerplay.pp_funcs->set_powergating_by_smu) {
> +			mutex_lock(&adev->pm.mutex);
> +			ret = ((adev)->powerplay.pp_funcs-
> >set_powergating_by_smu(
>  				(adev)->powerplay.pp_handle, block_type,
> gate));
> +			mutex_unlock(&adev->pm.mutex);
> +		}
>  		break;
>  	default:
>  		break;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
> index b32adda70bbc..285d460624c8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
> @@ -2762,17 +2762,12 @@ static void
> amdgpu_dpm_change_power_state_locked(struct amdgpu_device *adev)  void
> amdgpu_dpm_enable_uvd(struct amdgpu_device *adev, bool enable)  {
>  	int ret = 0;
> -	if (is_support_sw_smu(adev)) {
> -	    ret = smu_dpm_set_power_gate(&adev->smu,
> AMD_IP_BLOCK_TYPE_UVD, enable);
> -	    if (ret)
> -		DRM_ERROR("[SW SMU]: dpm enable uvd failed, state = %s,
> ret = %d. \n",
> -			  enable ? "true" : "false", ret);
> -	} else if (adev->powerplay.pp_funcs->set_powergating_by_smu) {
> -		/* enable/disable UVD */
> -		mutex_lock(&adev->pm.mutex);
> -		amdgpu_dpm_set_powergating_by_smu(adev,
> AMD_IP_BLOCK_TYPE_UVD, !enable);
> -		mutex_unlock(&adev->pm.mutex);
> -	}
> +
> +	ret = amdgpu_dpm_set_powergating_by_smu(adev,
> AMD_IP_BLOCK_TYPE_UVD, !enable);
> +	if (ret)
> +		DRM_ERROR("Dpm %s uvd failed, ret = %d. \n",
> +			  enable ? "enable" : "disable", ret);
> +
>  	/* enable/disable Low Memory PState for UVD (4k videos) */
>  	if (adev->asic_type == CHIP_STONEY &&
>  		adev->uvd.decode_image_width >= WIDTH_4K) { @@ -2789,17
> +2784,11 @@ void amdgpu_dpm_enable_uvd(struct amdgpu_device *adev,
> bool enable)  void amdgpu_dpm_enable_vce(struct amdgpu_device *adev,
> bool enable)  {
>  	int ret = 0;
> -	if (is_support_sw_smu(adev)) {
> -	    ret = smu_dpm_set_power_gate(&adev->smu,
> AMD_IP_BLOCK_TYPE_VCE, enable);
> -	    if (ret)
> -		DRM_ERROR("[SW SMU]: dpm enable vce failed, state = %s,
> ret = %d. \n",
> -			  enable ? "true" : "false", ret);
> -	} else if (adev->powerplay.pp_funcs->set_powergating_by_smu) {
> -		/* enable/disable VCE */
> -		mutex_lock(&adev->pm.mutex);
> -		amdgpu_dpm_set_powergating_by_smu(adev,
> AMD_IP_BLOCK_TYPE_VCE, !enable);
> -		mutex_unlock(&adev->pm.mutex);
> -	}
> +
> +	ret = amdgpu_dpm_set_powergating_by_smu(adev,
> AMD_IP_BLOCK_TYPE_VCE, !enable);
> +	if (ret)
> +		DRM_ERROR("Dpm %s vce failed, ret = %d. \n",
> +			  enable ? "enable" : "disable", ret);
>  }
> 
>  void amdgpu_pm_print_power_states(struct amdgpu_device *adev) @@ -
> 2818,12 +2807,10 @@ void amdgpu_dpm_enable_jpeg(struct amdgpu_device
> *adev, bool enable)  {
>  	int ret = 0;
> 
> -	if (is_support_sw_smu(adev)) {
> -		ret = smu_dpm_set_power_gate(&adev->smu,
> AMD_IP_BLOCK_TYPE_JPEG, enable);
> -		if (ret)
> -			DRM_ERROR("[SW SMU]: dpm enable jpeg failed,
> state = %s, ret = %d. \n",
> -				  enable ? "true" : "false", ret);
> -	}
> +	ret = amdgpu_dpm_set_powergating_by_smu(adev,
> AMD_IP_BLOCK_TYPE_JPEG, !enable);
> +	if (ret)
> +		DRM_ERROR("Dpm %s jpeg failed, ret = %d. \n",
> +			  enable ? "enable" : "disable", ret);
>  }
> 
>  int amdgpu_pm_load_smu_firmware(struct amdgpu_device *adev, uint32_t
> *smu_version) diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
> b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
> index e1b64134bbd8..fabc46dfb933 100644
> --- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
> @@ -433,10 +433,10 @@ int smu_dpm_set_power_gate(struct smu_context
> *smu, uint32_t block_type,
> 
>  	switch (block_type) {
>  	case AMD_IP_BLOCK_TYPE_UVD:
> -		ret = smu_dpm_set_uvd_enable(smu, gate);
> +		ret = smu_dpm_set_uvd_enable(smu, !gate);
>  		break;
>  	case AMD_IP_BLOCK_TYPE_VCE:
> -		ret = smu_dpm_set_vce_enable(smu, gate);
> +		ret = smu_dpm_set_vce_enable(smu, !gate);
>  		break;
>  	case AMD_IP_BLOCK_TYPE_GFX:
>  		ret = smu_gfx_off_control(smu, gate); @@ -445,7 +445,7 @@
> int smu_dpm_set_power_gate(struct smu_context *smu, uint32_t block_type,
>  		ret = smu_powergate_sdma(smu, gate);
>  		break;
>  	case AMD_IP_BLOCK_TYPE_JPEG:
> -		ret = smu_dpm_set_jpeg_enable(smu, gate);
> +		ret = smu_dpm_set_jpeg_enable(smu, !gate);
>  		break;
>  	default:
>  		break;
> --
> 2.24.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
