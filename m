Return-Path: <SRS0=pkFB=2R=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6202DC2D0C6
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Dec 2019 07:26:53 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 16D6B20838
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Dec 2019 07:26:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="JvzllHhL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16D6B20838
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CCB3589D42;
	Fri, 27 Dec 2019 07:26:52 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2044.outbound.protection.outlook.com [40.107.236.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 174F689D42
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Dec 2019 07:26:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fLZNK/2KZv7Hk5iK7tMTtNR2Ewv7Np6scxYPQ/oBQPZpfOYP9o+ZHFzs5I6lxW7cGMFu5zeEDW0/bCihqfJFaej4nP30+mvFsKeubHdktNxpgeMeDUspZognVbZSarjVfkc8CANQv1H5clj0KQX6s2qbB1sheEgAIzZ1OlnjifZOyIFLCBIW54YX+IHSBa6BnuYi4k95ecYUgqhfFe6QoYAGnv6ys+iZq/jVfNutG/Lh61TTuoNyzF6j8a6HYb+BrV0GFGzVfX2gOWb48cUHJOWxTpzo9gCelId0hn7YjtKASGgPFEQy3HM0HeNR33IxXASCyP5aN/mKnE7ExJSTLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=psmrbcUvQqmXC07bChAilmoQbZyW+yynjyczFrcBJwM=;
 b=kJKgObiamMAgiE1ULDfrZ9/yYh/onKIZ+tJ+EXWCBP1gmARtCHf5NbywjB8/45qSCMss07lsMgan+0xe7A9B86/qHEdXmpL8upp0rG6ZrRnQ8AvhuEuFJoaCRUBBYSLRqa1aCSh+DewnOzrcN4knfkwdPNl/xXOPdiHasveeAQ0jiPylTzZVBFMnYXJU1W1TDsqkS5L5iKjGjg3wHS/V7HpXFL9Ak03IJMGmBCxQYfbnxmrLTm8nSaPG6sZKAeeAwOPyUkBA4pzwoiZSne8/T0XXEutgtU0Z9wPKqqD5WNYjka8mqlinztAH4BFkytsEbHZr3AUPGOqw9X5Seay+YQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=psmrbcUvQqmXC07bChAilmoQbZyW+yynjyczFrcBJwM=;
 b=JvzllHhLvZG9JUkGVvQI9AHa7KRaWgNNLQSBAZIUhsOOC6jzVfxjk+6o/isRVsfpPneO3vc6PuJe4kNFwGUi6L5kirWHpVNfyIszZ3MyTZDvtClCjloB9fCIMG0m19GY+T31D/fieh/a2zcrR6vjVRUG24mh7veSkb9M0OC78Kk=
Received: from MN2PR12MB2975.namprd12.prod.outlook.com (20.178.243.142) by
 MN2PR12MB3936.namprd12.prod.outlook.com (10.255.238.97) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2581.12; Fri, 27 Dec 2019 07:26:48 +0000
Received: from MN2PR12MB2975.namprd12.prod.outlook.com
 ([fe80::851c:eebf:b936:20fd]) by MN2PR12MB2975.namprd12.prod.outlook.com
 ([fe80::851c:eebf:b936:20fd%4]) with mapi id 15.20.2581.007; Fri, 27 Dec 2019
 07:26:48 +0000
From: "Deng, Emily" <Emily.Deng@amd.com>
To: "Zhang, Jack (Jian)" <Jack.Zhang1@amd.com>, "Feng, Kenneth"
 <Kenneth.Feng@amd.com>, "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Quan, Evan" <Evan.Quan@amd.com>, "Wang, Kevin(Yang)" <Kevin1.Wang@amd.com>,
 "Tao, Yintian" <Yintian.Tao@amd.com>, "Min, Frank" <Frank.Min@amd.com>, "Liu, 
 Monk" <Monk.Liu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 1/2] amd/amdgpu/sriov enable onevf mode for ARCTURUS VF
Thread-Topic: [PATCH 1/2] amd/amdgpu/sriov enable onevf mode for ARCTURUS VF
Thread-Index: AQHVvILjY/76J6Fubkq2JqpFQ/7eDKfNjYGwgAAHNcA=
Date: Fri, 27 Dec 2019 07:26:47 +0000
Message-ID: <MN2PR12MB2975973D777DFC485A7A330E8F2A0@MN2PR12MB2975.namprd12.prod.outlook.com>
References: <20191227065710.3261-1-Jack.Zhang1@amd.com>
 <CH2PR12MB3672D8C9F4D961F505205481BB2A0@CH2PR12MB3672.namprd12.prod.outlook.com>
In-Reply-To: <CH2PR12MB3672D8C9F4D961F505205481BB2A0@CH2PR12MB3672.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2019-12-27T07:26:45Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=d845633d-cefd-4db6-a908-0000369a550a;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2019-12-27T07:26:45Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: 77b6df75-174a-47f1-bda3-000099e106d9
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Emily.Deng@amd.com; 
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b940c5fd-4f57-4dfd-e0b3-08d78a9e223c
x-ms-traffictypediagnostic: MN2PR12MB3936:|MN2PR12MB3936:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB3936FB33DFA9026F42377FF38F2A0@MN2PR12MB3936.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0264FEA5C3
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(396003)(346002)(39860400002)(366004)(136003)(189003)(13464003)(199004)(7696005)(76116006)(8676002)(66946007)(66556008)(52536014)(81156014)(8936002)(6506007)(81166006)(26005)(33656002)(64756008)(66476007)(71200400001)(66446008)(110136005)(19627235002)(2906002)(316002)(66574012)(55016002)(9686003)(186003)(5660300002)(86362001)(478600001)(921003)(1121003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3936;
 H:MN2PR12MB2975.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FOboIqozISiW5DFDbDsCuAE6QLc14y7LxJPeBC+m513g20S4WZWDow9gzz0bB64Yi9dU7RnL0nHGWTVkhPtc7LGfVXRroINEPV73HdXputcrASdzPmQogCBOWm4WGr01QKNZ+IG6ONVblJgYwxba0djbeu+p9oRCKELjqw0qwPJoYII7as//AptIp1THloA1dRscJ2ryvG5nTEZTZ6WobAMxGVLmVSK+wpTi3ckc0gZ/YwUEYx/Ck5WZLWWcwaOwNVib0aerkiecTflzp10tuSF07BPy5nhEfXDnlgGVGd9Y+1hvWmEG/bY/JOoPO1qQSamKqDfPNk4sNlEGv3E2DOYwQh83gnCMIR6E7XORK1+A3BEDYPhDjwi2fOsFBOBAHMpXTOtvvKmyRWjWvj2SqS4oLsnHfP5ihOfZr3qCE60PxsW10vlRss7ZrWOqDNKfWEjCaCB8R1w+b4r3BkIZzCN8EDozEOx+pSyooqZrXho+CQ2pPXJ/TkdhKX9zEzLfBlcYaTbOpW6rR3lDYDG1Fg==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b940c5fd-4f57-4dfd-e0b3-08d78a9e223c
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Dec 2019 07:26:47.8166 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WVhaIHfDxNLaFioxxqtRyhyq/r47N3jrIAo6m6ukDKyo0NYI+DU1Dh/iZeto+ILJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3936
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

[AMD Official Use Only - Internal Distribution Only]



>-----Original Message-----
>From: Zhang, Jack (Jian) <Jack.Zhang1@amd.com>
>Sent: Friday, December 27, 2019 3:00 PM
>To: Feng, Kenneth <Kenneth.Feng@amd.com>; Deucher, Alexander
><Alexander.Deucher@amd.com>; Quan, Evan <Evan.Quan@amd.com>; Wang,
>Kevin(Yang) <Kevin1.Wang@amd.com>; Tao, Yintian <Yintian.Tao@amd.com>;
>Deng, Emily <Emily.Deng@amd.com>; Min, Frank <Frank.Min@amd.com>; Liu,
>Monk <Monk.Liu@amd.com>; amd-gfx@lists.freedesktop.org; Zhang, Jack (Jian)
><Jack.Zhang1@amd.com>
>Subject: RE: [PATCH 1/2] amd/amdgpu/sriov enable onevf mode for ARCTURUS
>VF
>
>
>
>-----Original Message-----
>From: Jack Zhang <Jack.Zhang1@amd.com>
>Sent: Friday, December 27, 2019 2:57 PM
>To: amd-gfx@lists.freedesktop.org
>Cc: Zhang, Jack (Jian) <Jack.Zhang1@amd.com>
>Subject: [PATCH 1/2] amd/amdgpu/sriov enable onevf mode for ARCTURUS VF
>
>Before, initialization of smu ip block would be skipped for sriov ASICs. But if
>there's only one VF being used, guest driver should be able to dump some HW
>info such as clks, temperature,etc.
>
>To solve this, now after onevf mode is enabled, host driver will notify guest. If
>it's onevf mode, guest will do smu hw_init and skip some steps in normal smu
>hw_init flow because host driver has already done it for smu.
>
>With this fix, guest app can talk with smu and dump hw information from smu.
>
>v2: refine the logic for pm_enabled.Skip hw_init by not changing pm_enabled.
>
>Signed-off-by: Jack Zhang <Jack.Zhang1@amd.com>
>---
> drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c    |  3 +-
> drivers/gpu/drm/amd/amdgpu/soc15.c         |  3 +-
> drivers/gpu/drm/amd/powerplay/amdgpu_smu.c | 45 +++++++++++++++++------
>-------
> 3 files changed, 29 insertions(+), 22 deletions(-)
>
>diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
>b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
>index 8469834..08130a6 100644
>--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
>+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
>@@ -1448,7 +1448,8 @@ static int psp_np_fw_load(struct psp_context *psp)
>                     || ucode->ucode_id == AMDGPU_UCODE_ID_RLC_G
> 	            || ucode->ucode_id ==
>AMDGPU_UCODE_ID_RLC_RESTORE_LIST_CNTL
> 	            || ucode->ucode_id ==
>AMDGPU_UCODE_ID_RLC_RESTORE_LIST_GPM_MEM
>-	            || ucode->ucode_id ==
>AMDGPU_UCODE_ID_RLC_RESTORE_LIST_SRM_MEM))
>+	            || ucode->ucode_id ==
>AMDGPU_UCODE_ID_RLC_RESTORE_LIST_SRM_MEM
>+	            || ucode->ucode_id == AMDGPU_UCODE_ID_SMC))
> 			/*skip ucode loading in SRIOV VF */
> 			continue;
>
>diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c
>b/drivers/gpu/drm/amd/amdgpu/soc15.c
>index b53d401..a271496 100644
>--- a/drivers/gpu/drm/amd/amdgpu/soc15.c
>+++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
>@@ -827,8 +827,7 @@ int soc15_set_ip_blocks(struct amdgpu_device *adev)
> 			amdgpu_device_ip_block_add(adev,
>&dce_virtual_ip_block);
> 		amdgpu_device_ip_block_add(adev, &gfx_v9_0_ip_block);
> 		amdgpu_device_ip_block_add(adev, &sdma_v4_0_ip_block);
>-		if (!amdgpu_sriov_vf(adev))
>-			amdgpu_device_ip_block_add(adev,
>&smu_v11_0_ip_block);
>+		amdgpu_device_ip_block_add(adev, &smu_v11_0_ip_block);
>
> 		if (amdgpu_sriov_vf(adev)) {
> 			if (likely(adev->firmware.load_type ==
>AMDGPU_FW_LOAD_PSP)) diff --git
>a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
>b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
>index 936c682..42c0a6d 100644
>--- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
>+++ b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
>@@ -531,10 +531,14 @@ bool is_support_sw_smu(struct amdgpu_device
>*adev)
> 	if (adev->asic_type == CHIP_VEGA20)
> 		return (amdgpu_dpm == 2) ? true : false;
> 	else if (adev->asic_type >= CHIP_ARCTURUS) {
>-		if (amdgpu_sriov_vf(adev))
>-			return false;
>-		else
>+		if (amdgpu_sriov_vf(adev)) {
>+			if(amdgpu_sriov_is_pp_one_vf(adev))
>+				return true;
>+			else
>+				return false;
>+		} else {
> 			return true;
>+		}
> 	} else
> 		return false;
> }
>@@ -1062,20 +1066,19 @@ static int smu_smc_table_hw_init(struct
>smu_context *smu,
> 	}
>
> 	/* smu_dump_pptable(smu); */
>+	if(amdgpu_sriov_vf(adev) && !amdgpu_sriov_is_pp_one_vf(adev)){
>+		/*
>+		 * Copy pptable bo in the vram to smc with SMU MSGs such as
>+		 * SetDriverDramAddr and TransferTableDram2Smu.
>+		 */
>+		ret = smu_write_pptable(smu);
>+		if (ret)
>+			return ret;
Why only sriov and non one vf mode need to this? What about bare metal?
>
>-	/*
>-	 * Copy pptable bo in the vram to smc with SMU MSGs such as
>-	 * SetDriverDramAddr and TransferTableDram2Smu.
>-	 */
>-	ret = smu_write_pptable(smu);
>-	if (ret)
>-		return ret;
>-
>-	/* issue Run*Btc msg */
>-	ret = smu_run_btc(smu);
>-	if (ret)
>-		return ret;
>-
>+		/* issue Run*Btc msg */
>+		ret = smu_run_btc(smu);
>+		if (ret)
>+			return ret;
> 	ret = smu_feature_set_allowed_mask(smu);
> 	if (ret)
> 		return ret;
>@@ -1083,7 +1086,7 @@ static int smu_smc_table_hw_init(struct
>smu_context *smu,
> 	ret = smu_system_features_control(smu, true);
> 	if (ret)
> 		return ret;
>-
>+	}
> 	if (adev->asic_type != CHIP_ARCTURUS) {
> 		ret = smu_notify_display_change(smu);
> 		if (ret)
>@@ -1136,8 +1139,9 @@ static int smu_smc_table_hw_init(struct
>smu_context *smu,
> 	/*
> 	 * Set PMSTATUSLOG table bo address with SetToolsDramAddr MSG for
>tools.
> 	 */
>-	ret = smu_set_tool_table_location(smu);
>-
>+	if(amdgpu_sriov_vf(adev) && !amdgpu_sriov_is_pp_one_vf(adev)){
>+		ret = smu_set_tool_table_location(smu);
>+	}
> 	if (!smu_is_dpm_running(smu))
> 		pr_info("dpm has been disabled\n");
>
>@@ -1249,6 +1253,9 @@ static int smu_hw_init(void *handle)
> 		smu_set_gfx_cgpg(&adev->smu, true);
> 	}
>
>+	if (amdgpu_sriov_vf(adev)&& !amdgpu_sriov_is_pp_one_vf(adev))
>+		return 0;
>+
> 	if (!smu->pm_enabled)
> 		return 0;
>
>--
>2.7.4
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
