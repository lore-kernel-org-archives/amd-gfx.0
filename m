Return-Path: <SRS0=MtTs=2X=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09DB3C2D0DD
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Jan 2020 06:18:45 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BEEE52053B
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Jan 2020 06:18:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="z/3ZQTfS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BEEE52053B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3A65789BDB;
	Thu,  2 Jan 2020 06:18:44 +0000 (UTC)
Received: from NAM04-BN3-obe.outbound.protection.outlook.com
 (mail-eopbgr680075.outbound.protection.outlook.com [40.107.68.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3B3BA89BDB
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 Jan 2020 06:18:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HzOGuVfE2XSKLOCbeLn/6nncTH6llN1KFDGdGzDD7eLiKW7RankteVlvFSzqfjGoJr3guz2JbZvPDzlSDUxhs5X+QnEhQLBp9c1JciLrw20u5QVc+V1R+l05W3TxkcZtcz3yaehoaHcm6W1Y/TIR6q+c43IVcyGdLoumyB8vFFG9yCT1keIfXfBZwC1iqhHPiJRI3cD8yLpYgqmpGSXV866rC6WMg6ytl7sa4pgUuCprRTrYjE9FJAitR7HYYV3GlB/eRlePGYYXxmeXnnGq2488cIWewVO3rHpHlgRFrjpQg/A74d47S4/SJLZCgsjc+mGQKqAqOsGViXnOJ5jxow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JX9+Ej6vWs3zyB7yjXMGZ1z9N5JzhKwvUlY+25ls7xM=;
 b=OEBX4i9FgiwRS+rWh8C9ZV36A3Bdmb2vRglkg2DJUUGsOAWlymmuOdN+U9V4747SijIx40PNlvvI22uTLf7TkKz7konTgWv1nTL8+ZFCHTf4GlgTKzRi3x4eTR8j8aYGDPmF+5ev+Ny7bCwDpSkiWD75eZGyi4E8mq+P8a/qpXijv02XYoFtEwfhXWaHlkI0Cy08Rtio9uhBdbOpFU1OEKRutT6aXQBUsxphj96NtTQqWC0EpAGGSxx1d9B01hmr3XFAFzBO9yhpp6n0FTHYInxGTsCU+XF4cFwa5o5GpJFvmT9soRJgA4pvP5Bd5WdTFFrHohd93qORMeClmfXRPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JX9+Ej6vWs3zyB7yjXMGZ1z9N5JzhKwvUlY+25ls7xM=;
 b=z/3ZQTfSy1KA1m3Ft6jokysqVQvh1izdVn7bpM6HPxTsDIEcjZvO9+WvSQQfHd5vl5RX3i+Cz5a1mIIGsLNZZeZ+6w0f8yE1U6/hW3kjeaHZrBO6hBEMvYwvsVfitLBedpJl6OW09d3f+k3hOuucxhRdo2+IC0LakTVyEQr/yDQ=
Received: from MN2PR12MB3344.namprd12.prod.outlook.com (20.178.241.74) by
 MN2PR12MB3805.namprd12.prod.outlook.com (10.255.86.92) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2602.12; Thu, 2 Jan 2020 06:18:39 +0000
Received: from MN2PR12MB3344.namprd12.prod.outlook.com
 ([fe80::1010:4621:68dd:5b47]) by MN2PR12MB3344.namprd12.prod.outlook.com
 ([fe80::1010:4621:68dd:5b47%5]) with mapi id 15.20.2602.010; Thu, 2 Jan 2020
 06:18:38 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: "Zhang, Jack (Jian)" <Jack.Zhang1@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 1/2] amd/amdgpu/sriov enable onevf mode for ARCTURUS VF
Thread-Topic: [PATCH 1/2] amd/amdgpu/sriov enable onevf mode for ARCTURUS VF
Thread-Index: AQHVwTCNJUq+c7FJJ0WmEL4oGbti46fW5X1g
Date: Thu, 2 Jan 2020 06:18:38 +0000
Message-ID: <MN2PR12MB33441C3B023039F7DE554F43E4200@MN2PR12MB3344.namprd12.prod.outlook.com>
References: <1577944216-32200-1-git-send-email-Jack.Zhang1@amd.com>
In-Reply-To: <1577944216-32200-1-git-send-email-Jack.Zhang1@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=36afe736-08e9-49cb-adec-0000af8fb876;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-01-02T06:14:49Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Evan.Quan@amd.com; 
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d606538e-2597-417b-ad95-08d78f4b9b78
x-ms-traffictypediagnostic: MN2PR12MB3805:|MN2PR12MB3805:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB38058E8F73D8AA6D2D968808E4200@MN2PR12MB3805.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:160;
x-forefront-prvs: 0270ED2845
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(136003)(366004)(39860400002)(376002)(396003)(189003)(199004)(13464003)(4326008)(5660300002)(6506007)(52536014)(53546011)(8936002)(66574012)(81166006)(81156014)(9686003)(55016002)(7696005)(66556008)(64756008)(66476007)(66446008)(86362001)(76116006)(316002)(110136005)(66946007)(478600001)(45080400002)(966005)(2906002)(19627235002)(8676002)(71200400001)(26005)(33656002)(186003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3805;
 H:MN2PR12MB3344.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8N7MA0z/Qz1qi3TFTrtgd3kHzPhPD0+/vymL5qocsOZRHXCwqdex4b0ONaG2t+tmr9HU3O28Cwjbq7VgkoFTjnBe1Cqz4TRZFWS2qYLHg7V46Mj1tSjBV40GuydFoK9r1envqTniZtCnI6EUZ4xxrjSwm6jvyFo1IhLXnPgE2QXlhPZtn4fJaMAWtRbq6Zxn3VeIDBm+nWFfgv6297Dmsexoaj7XYnvppAMSGv8lr2ecIYWSVlmBDK+y6yNMVQ+u9pDuL+PkWsf6CSX82CeYGih7Xgv6czRjtUf4WLeUafIFf4DqTl+7YQLjS0V9aoFp0ThkLgHrg0HdYv1bvzbLfKyX8Gis4+VlMVC2Rnii+fHZGM5e56xleElWF8QkNrP+N2gJEYh7leYCM+lrihV5c6fzGnrHsWdE8j7LMoHTVn69ElDhcJiLI/AfJa2jd6VkyfWiZ0gB3bsVdd8jN+dF238xys8GlGT8R2DNAL62e5JWlA3Ms5MaC9sUKiOJFj8+Lw2+VaPRdZVqBK7QLEdz+A==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d606538e-2597-417b-ad95-08d78f4b9b78
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jan 2020 06:18:38.8571 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pNXQ6N8hI9dsK6SxzN5Y5CjqxNrU2sAu0Z5qbrnArJc+/1FXaaODFv2u0OZU0Mv9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3805
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



> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Jack
> Zhang
> Sent: Thursday, January 2, 2020 1:50 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Zhang, Jack (Jian) <Jack.Zhang1@amd.com>
> Subject: [PATCH 1/2] amd/amdgpu/sriov enable onevf mode for ARCTURUS VF
> 
> Before, initialization of smu ip block would be skipped
> for sriov ASICs. But if there's only one VF being used,
> guest driver should be able to dump some HW info such as
> clks, temperature,etc.
> 
> To solve this, now after onevf mode is enabled, host
> driver will notify guest. If it's onevf mode, guest will
> do smu hw_init and skip some steps in normal smu hw_init
> flow because host driver has already done it for smu.
> 
> With this fix, guest app can talk with smu and dump hw
> information from smu.
> 
> v2: refine the logic for pm_enabled.Skip hw_init by not
> changing pm_enabled.
> 
> Signed-off-by: Jack Zhang <Jack.Zhang1@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c    |  3 +-
>  drivers/gpu/drm/amd/amdgpu/soc15.c         |  3 +-
>  drivers/gpu/drm/amd/powerplay/amdgpu_smu.c | 94 +++++++++++++++++----
> ---------
>  3 files changed, 56 insertions(+), 44 deletions(-)
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
> &vcn_v2_5_ip_block);
> diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
> b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
> index 4ed8bdc..fa17265 100644
> --- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
> @@ -531,10 +531,14 @@ bool is_support_sw_smu(struct amdgpu_device
> *adev)
>  	if (adev->asic_type == CHIP_VEGA20)
>  		return (amdgpu_dpm == 2) ? true : false;
>  	else if (adev->asic_type >= CHIP_ARCTURUS) {
> -		if (amdgpu_sriov_vf(adev))
> -			return false;
> -		else
> +		if (amdgpu_sriov_vf(adev)) {
> +			if(amdgpu_sriov_is_pp_one_vf(adev))
> +				return true;
> +			else
> +				return false;
> +		} else {
>  			return true;
> +		}
[Quan, Evan] Maybe this can be simplified as below:
if (amdgpu_sriov_vf(adev)&& !amdgpu_sriov_is_pp_one_vf(adev))
          return false;
else
          return true;
>  	} else
>  		return false;
>  }
> @@ -1061,20 +1065,19 @@ static int smu_smc_table_hw_init(struct
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
> +		/* issue Run*Btc msg */
> +		ret = smu_run_btc(smu);
> +		if (ret)
> +			return ret;
>  	ret = smu_feature_set_allowed_mask(smu);
>  	if (ret)
>  		return ret;
> @@ -1082,7 +1085,7 @@ static int smu_smc_table_hw_init(struct
> smu_context *smu,
>  	ret = smu_system_features_control(smu, true);
>  	if (ret)
>  		return ret;
> -
> +	}
[Quan, Evan] Please check the code style here. It seems the code above does not have the same indentation.
>  	if (adev->asic_type != CHIP_ARCTURUS) {
>  		ret = smu_notify_display_change(smu);
>  		if (ret)
> @@ -1135,8 +1138,9 @@ static int smu_smc_table_hw_init(struct
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
> @@ -1248,6 +1252,9 @@ static int smu_hw_init(void *handle)
>  		smu_set_gfx_cgpg(&adev->smu, true);
>  	}
> 
> +	if (amdgpu_sriov_vf(adev) && !amdgpu_sriov_is_pp_one_vf(adev))
> +		return 0;
> +
>  	if (!smu->pm_enabled)
>  		return 0;
> 
> @@ -1300,37 +1307,42 @@ static int smu_hw_fini(void *handle)
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
> gfx&amp;data=02%7C01%7Cevan.quan%40amd.com%7Cfbd41f8689704e60cb8
> f08d78f47aac1%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C63713
> 5410346465153&amp;sdata=7xQsqRAFgxZTPkU9v5zEAaWzmKIMA%2FiQyn1wD
> ftSZgQ%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
