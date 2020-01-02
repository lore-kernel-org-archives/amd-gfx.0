Return-Path: <SRS0=MtTs=2X=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95D15C2D0DD
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Jan 2020 08:04:03 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1EC2520866
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Jan 2020 08:04:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="fwJP95bR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1EC2520866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 787DE89725;
	Thu,  2 Jan 2020 08:04:02 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2045.outbound.protection.outlook.com [40.107.223.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 69B1A89725
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 Jan 2020 08:04:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kkAMBkqsokQ4CGajkQqxm2XSPP7pVsylsuy59b3mvwolZZH9YIeQQCq4elmDSLTvB9qEEqv9Hbe/KvZlIw4VYcq5QGIkmIq7fxg4s0UdKmUvuUmLGxZ21iY0ioAfqhzwbeRnmf5vSP3zWY84xx0jWea/GoEo0Q9QIre/W7jVp3eMAl/CzQA57+7HgkohKqdiT21jKHUv9OpH/QnSVP2TXNpsoyV55IyXFn/ReBPWb3mimgVyxvmDLRtvvdyisCU9k2bVKxjLcDWL3Sq17JLrqsRYQNO7e7bCybPQtNzvz2cdt5kfQIV06JTM7YceVw0y2g3hYvaYXUqZ6j1ouCUH3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W6pzbbLtz1c6R1ZDZMcOcSY450fw3S0dPRzG0uTLAkY=;
 b=XkxHNralsOl8YsGNIVZ5sGR5g5ONUyWpw96ZnqLSzg+HsqYQsParX0vh14VXLyGYmK+os/4wrHgzfvaiKJf7BbXQSw95mX3bP9pBbrjpFH28QoYSJfc1jldrQyJiCpi9mnb6NxujULUthlCE/tt+R2cUSiM3xePbTOa+AA4pTSR8x5i2LjKPyp4KykCdaiwOL3lLgoyF0R3BdfZArlsJCCJA7dXw8ouqJsskLqFcH4WWf7CgAI19j2uPa/7Q7Xs8a5F4sBKTeyWam4t42kgWacHg/upDhYyedUkPpIIZnaIXZAltZc7qaKuc4DGUti8eAQ8+nEH52iHddtzfktCXzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W6pzbbLtz1c6R1ZDZMcOcSY450fw3S0dPRzG0uTLAkY=;
 b=fwJP95bROnZn2whrr0qTtYC5wQJuNxqT3ToQRIKeEnmGND0UeVSjEHj5v95KEronDElEgMhcF7VRG5UQHMaTyeG+Ynogp6B7W55Xn+a9ZMmEnTBadPdty3SV5pKlRlyT7jTPZAXZXQWFxFGaipBEYNaR/UYKIqYP07P2PP9c1ls=
Received: from MN2PR12MB3344.namprd12.prod.outlook.com (20.178.241.74) by
 MN2PR12MB3487.namprd12.prod.outlook.com (20.178.241.210) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2602.10; Thu, 2 Jan 2020 08:03:57 +0000
Received: from MN2PR12MB3344.namprd12.prod.outlook.com
 ([fe80::1010:4621:68dd:5b47]) by MN2PR12MB3344.namprd12.prod.outlook.com
 ([fe80::1010:4621:68dd:5b47%5]) with mapi id 15.20.2602.010; Thu, 2 Jan 2020
 08:03:57 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: "Zhang, Jack (Jian)" <Jack.Zhang1@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 1/2] amd/amdgpu/sriov enable onevf mode for ARCTURUS VF
Thread-Topic: [PATCH 1/2] amd/amdgpu/sriov enable onevf mode for ARCTURUS VF
Thread-Index: AQHVwUBrlr2rK67Nlk+pqMtw1JKZkqfXA8QQ
Date: Thu, 2 Jan 2020 08:03:57 +0000
Message-ID: <MN2PR12MB3344201EE9034F5C1500AE5AE4200@MN2PR12MB3344.namprd12.prod.outlook.com>
References: <1577951028-3033-1-git-send-email-Jack.Zhang1@amd.com>
In-Reply-To: <1577951028-3033-1-git-send-email-Jack.Zhang1@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=b381d3e9-550d-4a73-936f-0000ca8601ea;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-01-02T08:03:37Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Evan.Quan@amd.com; 
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 9d55598c-38be-4df4-202d-08d78f5a51c7
x-ms-traffictypediagnostic: MN2PR12MB3487:|MN2PR12MB3487:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB348701590D3EC48012F995DBE4200@MN2PR12MB3487.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:160;
x-forefront-prvs: 0270ED2845
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(376002)(39860400002)(366004)(396003)(346002)(199004)(13464003)(189003)(19627235002)(478600001)(66946007)(2906002)(76116006)(4326008)(5660300002)(33656002)(966005)(9686003)(86362001)(64756008)(45080400002)(66446008)(66476007)(316002)(66556008)(81166006)(81156014)(71200400001)(8676002)(186003)(55016002)(53546011)(110136005)(8936002)(6506007)(7696005)(26005)(52536014)(66574012);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3487;
 H:MN2PR12MB3344.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DaNF9YZOEwO0IXCRc+bW5EylyQGHC4/n3g0V6phC60nArzPzto9s0PBQH/w2FlGd+mZb4KBVRje6kIp80KzOHGucPUp0sLGcyIB8Wldm/cY5pNZMFSh7znVO9Lt1QjvTRFLDLFjbX+Nkkyz7HM/9ZJMWKy2zASeSqfR2E5vc4gPSDdQ930xN0AeZdE2tEC1okA9ndP2zq5k+jfvGpxodU5H/dBkS8pdrzoBLOYFYkqmgD8vVrE4uotOqnjxainYQZzG50zrUyQMUWg4sZWN8pw+fkDmZx6eWUkKv81a2ZX0DKDP+mTdC/LfNu9/aumkbFDttoT683FB9HdzX73X/0odWxjSSRI8LrBNwcK0eodWQHL3mcszy4Wx2Mqn+cRhRoQq5ONYZ5aVw/TGOgHkAN7NRQtojHf+utQcMWqo9NAUgB11X1X01fLd+2bY1mc+1F/ySAn0w+QGh2wGsybhafGvnwh0z4g6TfqM/yb8Sufdz4HIW+hwfnO4w876nysY2DcBZNeuiWUKlZJnNLDhRDw==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d55598c-38be-4df4-202d-08d78f5a51c7
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jan 2020 08:03:57.6958 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: f4AXxZqz+asCiUBCi/PHDdO2mZFNBqVhaboIVZtVAF1XMCggI2Xn4LJWVbWRNVQr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3487
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
Cc: "Zhang, Jack \(Jian\)" <Jack.Zhang1@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Acked-by: Evan Quan <evan.quan@amd.com>

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Jack
> Zhang
> Sent: Thursday, January 2, 2020 3:44 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Zhang, Jack (Jian) <Jack.Zhang1@amd.com>
> Subject: [PATCH 1/2] amd/amdgpu/sriov enable onevf mode for ARCTURUS VF
> 
> Before, initialization of smu ip block would be skipped for sriov ASICs. But if
> there's only one VF being used, guest driver should be able to dump some HW
> info such as clks, temperature,etc.
> 
> To solve this, now after onevf mode is enabled, host driver will notify guest. If
> it's onevf mode, guest will do smu hw_init and skip some steps in normal smu
> hw_init flow because host driver has already done it for smu.
> 
> With this fix, guest app can talk with smu and dump hw information from smu.
> 
> v2: refine the logic for pm_enabled.Skip hw_init by not changing pm_enabled.
> v3: refine is_support_sw_smu and fix some indentation issue.
> 
> Signed-off-by: Jack Zhang <Jack.Zhang1@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c    |  3 +-
>  drivers/gpu/drm/amd/amdgpu/soc15.c         |  3 +-
>  drivers/gpu/drm/amd/powerplay/amdgpu_smu.c | 98 ++++++++++++++++------
> --------
>  3 files changed, 56 insertions(+), 48 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> index 0d842a1..5341905 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> @@ -1454,7 +1454,8 @@ static int psp_np_fw_load(struct psp_context *psp)
>                      || ucode->ucode_id == AMDGPU_UCODE_ID_RLC_G
>  	            || ucode->ucode_id ==
> AMDGPU_UCODE_ID_RLC_RESTORE_LIST_CNTL
>  	            || ucode->ucode_id ==
> AMDGPU_UCODE_ID_RLC_RESTORE_LIST_GPM_MEM
> -	            || ucode->ucode_id ==
> AMDGPU_UCODE_ID_RLC_RESTORE_LIST_SRM_MEM))
> +	            || ucode->ucode_id ==
> AMDGPU_UCODE_ID_RLC_RESTORE_LIST_SRM_MEM
> +	            || ucode->ucode_id == AMDGPU_UCODE_ID_SMC))
>  			/*skip ucode loading in SRIOV VF */
>  			continue;
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c
> b/drivers/gpu/drm/amd/amdgpu/soc15.c
> index 6129fab..26e1c8c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/soc15.c
> +++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
> @@ -826,8 +826,7 @@ int soc15_set_ip_blocks(struct amdgpu_device *adev)
>  			amdgpu_device_ip_block_add(adev,
> &dce_virtual_ip_block);
>  		amdgpu_device_ip_block_add(adev, &gfx_v9_0_ip_block);
>  		amdgpu_device_ip_block_add(adev, &sdma_v4_0_ip_block);
> -		if (!amdgpu_sriov_vf(adev))
> -			amdgpu_device_ip_block_add(adev,
> &smu_v11_0_ip_block);
> +		amdgpu_device_ip_block_add(adev, &smu_v11_0_ip_block);
> 
>  		if (unlikely(adev->firmware.load_type ==
> AMDGPU_FW_LOAD_DIRECT))
>  			amdgpu_device_ip_block_add(adev,
> &vcn_v2_5_ip_block); diff --git
> a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
> b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
> index 4ed8bdc..4b96937 100644
> --- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
> @@ -531,7 +531,7 @@ bool is_support_sw_smu(struct amdgpu_device *adev)
>  	if (adev->asic_type == CHIP_VEGA20)
>  		return (amdgpu_dpm == 2) ? true : false;
>  	else if (adev->asic_type >= CHIP_ARCTURUS) {
> -		if (amdgpu_sriov_vf(adev))
> +		if
> (amdgpu_sriov_vf(adev)&& !amdgpu_sriov_is_pp_one_vf(adev))
>  			return false;
>  		else
>  			return true;
> @@ -1061,28 +1061,27 @@ static int smu_smc_table_hw_init(struct
> smu_context *smu,
>  	}
> 
>  	/* smu_dump_pptable(smu); */
> +	if (!amdgpu_sriov_vf(adev)) {
> +		/*
> +		 * Copy pptable bo in the vram to smc with SMU MSGs such as
> +		 * SetDriverDramAddr and TransferTableDram2Smu.
> +		 */
> +		ret = smu_write_pptable(smu);
> +		if (ret)
> +			return ret;
> 
> -	/*
> -	 * Copy pptable bo in the vram to smc with SMU MSGs such as
> -	 * SetDriverDramAddr and TransferTableDram2Smu.
> -	 */
> -	ret = smu_write_pptable(smu);
> -	if (ret)
> -		return ret;
> -
> -	/* issue Run*Btc msg */
> -	ret = smu_run_btc(smu);
> -	if (ret)
> -		return ret;
> -
> -	ret = smu_feature_set_allowed_mask(smu);
> -	if (ret)
> -		return ret;
> -
> -	ret = smu_system_features_control(smu, true);
> -	if (ret)
> -		return ret;
> +		/* issue Run*Btc msg */
> +		ret = smu_run_btc(smu);
> +		if (ret)
> +			return ret;
> +		ret = smu_feature_set_allowed_mask(smu);
> +		if (ret)
> +			return ret;
> 
> +		ret = smu_system_features_control(smu, true);
> +		if (ret)
> +			return ret;
> +	}
>  	if (adev->asic_type != CHIP_ARCTURUS) {
>  		ret = smu_notify_display_change(smu);
>  		if (ret)
> @@ -1135,8 +1134,9 @@ static int smu_smc_table_hw_init(struct
> smu_context *smu,
>  	/*
>  	 * Set PMSTATUSLOG table bo address with SetToolsDramAddr MSG for
> tools.
>  	 */
> -	ret = smu_set_tool_table_location(smu);
> -
> +	if (!amdgpu_sriov_vf(adev)) {
> +		ret = smu_set_tool_table_location(smu);
> +	}
>  	if (!smu_is_dpm_running(smu))
>  		pr_info("dpm has been disabled\n");
> 
> @@ -1248,6 +1248,9 @@ static int smu_hw_init(void *handle)
>  		smu_set_gfx_cgpg(&adev->smu, true);
>  	}
> 
> +	if (amdgpu_sriov_vf(adev) && !amdgpu_sriov_is_pp_one_vf(adev))
> +		return 0;
> +
>  	if (!smu->pm_enabled)
>  		return 0;
> 
> @@ -1300,37 +1303,42 @@ static int smu_hw_fini(void *handle)
>  	struct smu_table_context *table_context = &smu->smu_table;
>  	int ret = 0;
> 
> +	if (amdgpu_sriov_vf(adev)&& !amdgpu_sriov_is_pp_one_vf(adev))
> +		return 0;
> +
>  	if (adev->flags & AMD_IS_APU) {
>  		smu_powergate_sdma(&adev->smu, true);
>  		smu_powergate_vcn(&adev->smu, true);
>  		smu_powergate_jpeg(&adev->smu, true);
>  	}
> 
> -	ret = smu_stop_thermal_control(smu);
> -	if (ret) {
> -		pr_warn("Fail to stop thermal control!\n");
> -		return ret;
> -	}
> -
> -	/*
> -	 * For custom pptable uploading, skip the DPM features
> -	 * disable process on Navi1x ASICs.
> -	 *   - As the gfx related features are under control of
> -	 *     RLC on those ASICs. RLC reinitialization will be
> -	 *     needed to reenable them. That will cost much more
> -	 *     efforts.
> -	 *
> -	 *   - SMU firmware can handle the DPM reenablement
> -	 *     properly.
> -	 */
> -	if (!smu->uploading_custom_pp_table ||
> -	    !((adev->asic_type >= CHIP_NAVI10) &&
> -	      (adev->asic_type <= CHIP_NAVI12))) {
> -		ret = smu_stop_dpms(smu);
> +	if (!amdgpu_sriov_vf(adev)){
> +		ret = smu_stop_thermal_control(smu);
>  		if (ret) {
> -			pr_warn("Fail to stop Dpms!\n");
> +			pr_warn("Fail to stop thermal control!\n");
>  			return ret;
>  		}
> +
> +		/*
> +		 * For custom pptable uploading, skip the DPM features
> +		 * disable process on Navi1x ASICs.
> +		 *   - As the gfx related features are under control of
> +		 *     RLC on those ASICs. RLC reinitialization will be
> +		 *     needed to reenable them. That will cost much more
> +		 *     efforts.
> +		 *
> +		 *   - SMU firmware can handle the DPM reenablement
> +		 *     properly.
> +		 */
> +		if (!smu->uploading_custom_pp_table ||
> +				!((adev->asic_type >= CHIP_NAVI10) &&
> +					(adev->asic_type <= CHIP_NAVI12))) {
> +			ret = smu_stop_dpms(smu);
> +			if (ret) {
> +				pr_warn("Fail to stop Dpms!\n");
> +				return ret;
> +			}
> +		}
>  	}
> 
>  	kfree(table_context->driver_pptable);
> --
> 2.7.4
> 
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.free
> desktop.org%2Fmailman%2Flistinfo%2Famd-
> gfx&amp;data=02%7C01%7Cevan.quan%40amd.com%7C229782939fa0482d84f
> 308d78f5787c2%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C6371
> 35478506764166&amp;sdata=pX92Zwa84idHjZsFY%2BUjLEamVuF6UuIg4oiJffe
> 0fj8%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
