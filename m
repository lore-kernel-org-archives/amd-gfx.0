Return-Path: <SRS0=KDYH=4M=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6ECDC3567B
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Feb 2020 10:19:25 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7859A20836
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Feb 2020 10:19:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="a9QFQX2O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7859A20836
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3E8486E419;
	Mon, 24 Feb 2020 10:19:25 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2079.outbound.protection.outlook.com [40.107.236.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 69E6A6E419
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Feb 2020 10:19:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kqd3JQVd0ajC5i10wdcu/8un8jIkVEuKs30myPfJd5vsJwPbEIxhxvEEHw/K9MeDn1zsLIjnvdt0+tv2Qc2l3Q3Ifes5+8d9Cml0rSiDqUHUA4R7uvAvEY+D1yHtHgjXx6Mrmch5DYbNAOn1qT8esVJQRfUGq0s+bMh4GiRLIvDVZBIxo6ga4J3D59Cnu3wxfgF4meyfLwo0hzIGYm/LCdg+qwCVNZ32qMauIIuCXb/nk/aW6snsfIrP1Dr+hSisHexA+eACxWUGj2Nj7AbvEv5Vw+1wGIhu5XwdkgnFqXQxI3JCKDhGclgJVSAgCOoz7aoBXwRPekjXfBp5WJqX5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k+tz6UUevyhPnG0ibsombdpCVabG9qs6ncGX7vJ8BIM=;
 b=XQidH8kdY6Mbgb77SugNlQbwXFzvEBqxrUtTvOIy4k4T6OP+zbw10jKItQ4N+DvZ5SmzdE0m8eUpHRy3JtANVI+s6sA5ycxpWfAzvKyDJkbu1MahsnKVHnLE42GqupHKIRyn4m3NJPTm2WvBPHWtCmg9lFH/kHEe1XP+O2tmY9gO1EP6uTLcFeIHzafV9eawkW82hdQQjBhu7BVoKFNNEnGM3emzEqBMoPOY1pOO9kMQwIJKy8wC0NroZn0nQw9/VAfeHk+XHccfeuviI0h0h88ozM6DnR/vLykWUDORz5DPcibB2W1m3qNOIHF8k9tI8vXkAZp3eOZhoK5HdfO6vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k+tz6UUevyhPnG0ibsombdpCVabG9qs6ncGX7vJ8BIM=;
 b=a9QFQX2OwElhXaNPjlFV1bC3bRX9b4/QEIIPVaHP0EdKKtreGWkhi/G5X09cU9XbLR+rfuAfx0461VncGzdSrxskM7Ng6aRhSYJ/U52oNX7xnLQkTr4U1qn6xTcaa9DkxLoyQvBvRCE/mrMEzyK3bp8pp82SRUnUGXLG6R5CdjI=
Received: from DM5PR12MB1418.namprd12.prod.outlook.com (2603:10b6:3:7a::15) by
 DM5PR12MB1625.namprd12.prod.outlook.com (2603:10b6:4:b::13) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2750.21; Mon, 24 Feb 2020 10:19:22 +0000
Received: from DM5PR12MB1418.namprd12.prod.outlook.com
 ([fe80::c8ba:7e4e:e1c3:d8db]) by DM5PR12MB1418.namprd12.prod.outlook.com
 ([fe80::c8ba:7e4e:e1c3:d8db%5]) with mapi id 15.20.2750.021; Mon, 24 Feb 2020
 10:19:22 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Quan, Evan" <Evan.Quan@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: update psp firmwares loading sequence
Thread-Topic: [PATCH] drm/amdgpu: update psp firmwares loading sequence
Thread-Index: AQHV6vR7cLi/urdlg065vWPdO8srAKgqIHKAgAABARCAAABFIA==
Date: Mon, 24 Feb 2020 10:19:22 +0000
Message-ID: <DM5PR12MB1418C508A68C7E2F4D738565FCEC0@DM5PR12MB1418.namprd12.prod.outlook.com>
References: <20200224092417.7589-1-evan.quan@amd.com>
 <DM5PR12MB1418D5CF6F341DC174C6AF5EFCEC0@DM5PR12MB1418.namprd12.prod.outlook.com>
 <DM5PR12MB141877F6C4E39995151C8D93FCEC0@DM5PR12MB1418.namprd12.prod.outlook.com>
In-Reply-To: <DM5PR12MB141877F6C4E39995151C8D93FCEC0@DM5PR12MB1418.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-02-24T10:15:45Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=f0986d10-208a-4c63-a13d-000072765be6;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-02-24T10:19:20Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: 7b9fd385-6e53-43d3-8fe2-00005481c8cf
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Hawking.Zhang@amd.com; 
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 34faabda-f6d8-40cd-062b-08d7b913047f
x-ms-traffictypediagnostic: DM5PR12MB1625:|DM5PR12MB1625:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR12MB1625BAFC2489AC8DE25FB775FCEC0@DM5PR12MB1625.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-forefront-prvs: 032334F434
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(396003)(39860400002)(346002)(366004)(136003)(199004)(189003)(86362001)(33656002)(52536014)(26005)(53546011)(15650500001)(2940100002)(76116006)(478600001)(71200400001)(66946007)(186003)(81166006)(55016002)(66476007)(9686003)(7696005)(316002)(6506007)(66446008)(64756008)(110136005)(81156014)(4326008)(5660300002)(2906002)(8676002)(66556008)(8936002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB1625;
 H:DM5PR12MB1418.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3iXenPsOSznskkFoSbwmWst8+I9clHvBQJITitDUVObZXaq4/bCbdpd7fUK4tpwjDA2JXrBUn/hWVwuxcpo3l+z5bGMU83CAiDiqrm62y4kSwHokBlb+0hTIibX6w9YphGzn7GYrw1PWIMmbkgN6aC8HTpCR0w8qCkBeajrYFddmKn3v70efg1sEMPbs+pu1nAZkepHz4TLyrrIxjWBtOiwuDAQyPCfsBFwWHpvYSdx7G/Unm7M9v8JdPN/XlvjRkdrZpcnWMwiVg3K6xTnP5ULCLFBFHWKRolecqrUUYrA1QWPZVXx0ZVjjVf7/s6YD5mYhg+eG2SIl9fr2zNBL1ky9MCEoOn5QV8wKjDkJtvGaWGhFpOLVWVGXPaSWzYjg6xZ+btnIPKaLnvIyD0KtSNjpQtIbDJ5oquOpE+eEvyEeqjfuVLVMAIfMsCHlXcI1
x-ms-exchange-antispam-messagedata: GK8BPj3nArQpdoS2ojFZPV2SlqVXVSFUoHG2gOF2+31eIsDjG/g/tfBIdVqZJdaU1A+sF0xKNNv/IbkSLlT8+Kc3GW8Ml1suEkyaOkrRb0qT5Je/G6px5yHb/P7WssiKL5dgJLzL0D0FCxX1AjuEQw==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34faabda-f6d8-40cd-062b-08d7b913047f
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2020 10:19:22.5705 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tLm1e8a+uHK4FCL3+WOohF7BWHEwY0p+EltZcLHXQXy+wAkUd3uqVMExsodA3IIPIrHNweuSzTy5phlRvWHdcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1625
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
Cc: "Feng, Kenneth" <Kenneth.Feng@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

Sorry just for Navi12. Arcturus should be fine as it doesn't support autoload.

Regards,
Hawking

-----Original Message-----
From: Zhang, Hawking 
Sent: Monday, February 24, 2020 18:18
To: Quan, Evan <Evan.Quan@amd.com>; 'amd-gfx@lists.freedesktop.org' <amd-gfx@lists.freedesktop.org>
Cc: Feng, Kenneth <Kenneth.Feng@amd.com>
Subject: RE: [PATCH] drm/amdgpu: update psp firmwares loading sequence

[AMD Official Use Only - Internal Distribution Only]

That's saying I suspect the PMFW was loaded twice with the patch for Arcturus and Navi12.

Regards,
Hawking

-----Original Message-----
From: Zhang, Hawking 
Sent: Monday, February 24, 2020 18:16
To: Quan, Evan <Evan.Quan@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Feng, Kenneth <Kenneth.Feng@amd.com>
Subject: RE: [PATCH] drm/amdgpu: update psp firmwares loading sequence

[AMD Official Use Only - Internal Distribution Only]

Can you double check the following logic after your setup the TMR in psp_np_fw_load? For Arcturus and Navi12, it should be skipped as well.

if (ucode->ucode_id == AMDGPU_UCODE_ID_SMC &&
    (psp_smu_reload_quirk(psp) || psp->autoload_supported))
			continue;

Regards,
Hawking
-----Original Message-----
From: Quan, Evan <Evan.Quan@amd.com> 
Sent: Monday, February 24, 2020 17:24
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Feng, Kenneth <Kenneth.Feng@amd.com>; Quan, Evan <Evan.Quan@amd.com>
Subject: [PATCH] drm/amdgpu: update psp firmwares loading sequence

For those ASICs with DF Cstate management centralized to PMFW, TMR setup should be performed between pmfw loading and other non-psp firmwares loading.

Change-Id: I8986ddb4d9ffe63ed0823d1dce8d9d52812a1240
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 61 +++++++++++++++++++++++--  drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h |  2 +
 2 files changed, 58 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 51839ab02b84..ef800ad68e1c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -38,6 +38,39 @@
 
 static void psp_set_funcs(struct amdgpu_device *adev);
 
+/*
+ * Due to DF Cstate management centralized to PMFW, the firmware
+ * loading sequence will be updated as below:
+ *   - Load KDB
+ *   - Load SYS_DRV
+ *   - Load tOS
+ *   - Load PMFW
+ *   - Setup TMR
+ *   - Load other non-psp fw
+ *   - Load ASD
+ *   - Load XGMI/RAS/HDCP/DTM TA if any
+ *
+ * This new sequence is required for
+ *   - Arcturus
+ *   - Navi12 and onwards
+ */
+static void psp_check_pmfw_centralized_cstate_management(struct 
+psp_context *psp) {
+	struct amdgpu_device *adev = psp->adev;
+
+	psp->pmfw_centralized_cstate_management = false;
+
+	if (amdgpu_sriov_vf(adev))
+		return;
+
+	if (adev->flags & AMD_IS_APU)
+		return;
+
+	if ((adev->asic_type == CHIP_ARCTURUS) ||
+	    (adev->asic_type >= CHIP_NAVI12))
+		psp->pmfw_centralized_cstate_management = true; }
+
 static int psp_early_init(void *handle)  {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle; @@ -75,6 +108,8 @@ static int psp_early_init(void *handle)
 
 	psp->adev = adev;
 
+	psp_check_pmfw_centralized_cstate_management(psp);
+
 	return 0;
 }
 
@@ -1116,10 +1151,17 @@ static int psp_hw_start(struct psp_context *psp)
 		return ret;
 	}
 
-	ret = psp_tmr_load(psp);
-	if (ret) {
-		DRM_ERROR("PSP load tmr failed!\n");
-		return ret;
+	/*
+	 * For those ASICs with DF Cstate management centralized
+	 * to PMFW, TMR setup should be performed after PMFW
+	 * loaded and before other non-psp firmware loaded.
+	 */
+	if (!psp->pmfw_centralized_cstate_management) {
+		ret = psp_tmr_load(psp);
+		if (ret) {
+			DRM_ERROR("PSP load tmr failed!\n");
+			return ret;
+		}
 	}
 
 	return 0;
@@ -1316,7 +1358,8 @@ static int psp_np_fw_load(struct psp_context *psp)
 	struct amdgpu_firmware_info *ucode;
 	struct amdgpu_device* adev = psp->adev;
 
-	if (psp->autoload_supported) {
+	if (psp->autoload_supported ||
+	    psp->pmfw_centralized_cstate_management) {
 		ucode = &adev->firmware.ucode[AMDGPU_UCODE_ID_SMC];
 		if (!ucode->fw || amdgpu_sriov_vf(adev))
 			goto out;
@@ -1326,6 +1369,14 @@ static int psp_np_fw_load(struct psp_context *psp)
 			return ret;
 	}
 
+	if (psp->pmfw_centralized_cstate_management) {
+		ret = psp_tmr_load(psp);
+		if (ret) {
+			DRM_ERROR("PSP load tmr failed!\n");
+			return ret;
+		}
+	}
+
 out:
 	for (i = 0; i < adev->firmware.max_ucodes; i++) {
 		ucode = &adev->firmware.ucode[i];
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
index c77e1abb538a..37fa184f27f6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
@@ -264,6 +264,8 @@ struct psp_context
 	atomic_t			fence_value;
 	/* flag to mark whether gfx fw autoload is supported or not */
 	bool				autoload_supported;
+	/* flag to mark whether df cstate management centralized to PMFW */
+	bool				pmfw_centralized_cstate_management;
 
 	/* xgmi ta firmware and buffer */
 	const struct firmware		*ta_fw;
--
2.25.0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
