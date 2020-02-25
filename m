Return-Path: <SRS0=Kz8i=4N=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 294EDC35DF0
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Feb 2020 03:39:18 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E6C0522464
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Feb 2020 03:39:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="F81ou9N4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6C0522464
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 399286E8A1;
	Tue, 25 Feb 2020 03:39:13 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2084.outbound.protection.outlook.com [40.107.236.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4CA736E8A1
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Feb 2020 03:39:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QZKCIXoQJ8YSHsJMV8C+gFCIm0X1GBW2dLLMhYXQqbeBvm/8zRmhV4GVEmBCAaBYtF36rGvTtMXevHc4BxKuS1E605MxfHZjU9vb361Kdl2A4POM7OalwYXHcPFfOav5oZuT+U3gI04nwgSZTzw3XHGmpuGk+eJKqkhqwCGDv3gCTxyi6VEVo1g1F+a+Lxd5B5jRV3bB06QqEbB5FRCoRV7rj2aBpxikI+WqrTbPfzCcESfs8DpoN2M0kM4Cdn3Mr7CfWTNmvyD59q8bvIhSzH6QHZ6B5uxT0tPt+ygxPDHFLKlFFFGx69zX6etc9o/73uNsHCjOiT8ipbngiAiSMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kdb4DwlHutKy02ELMD08HqBlzY4rFjCobrXl2r8Em4g=;
 b=PFzNqM0i82IAbyCXj0688fMiEr3UFmMa3Eljd87SZ5IuLu1knOoxDmRvclHH5oPjcmVXu06nHG91I+9nAOY9Wkq3iPRrlXn9wPTMBWdmT0f8CoknOu6RI1UHiB4+lXCl5T+ILL2XsaBGgUHJAWrWEWHH58LXmrf1bBUJJ6R/MNO1Lv/zKJDaduhX8k3b2U+9+MQnJMFXEvGqYhgVzumrxKke4nfuUE1UkGsgZLv1ZWQ61Z8O+mavMfDMqo/aAt5NNru/M2kkisyH4/G2HeeFrenRWugSPkrfw3/4JDepxy4nQsOLtO/UrsufUilfOAP4XZbmanmGXgb3NDrYxx/odw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kdb4DwlHutKy02ELMD08HqBlzY4rFjCobrXl2r8Em4g=;
 b=F81ou9N4wfc30AXDrJ3XbCfTFVVFPAoD+T9u2ZC+lWvYIengS9ErZ4Gp0fpr8yGpl3BTiUrgZK990Vn168Dd+qpBiEAWiWCWqFX3uC+HwNKFIGGaDqUEwY2fwxZLLa4EtgLsaAWY+qq1A1Aa5SgSbgHRWP4+jJCYBuShKaprWyc=
Received: from MN2PR12MB3344.namprd12.prod.outlook.com (2603:10b6:208:c5::10)
 by MN2PR12MB4077.namprd12.prod.outlook.com (2603:10b6:208:1da::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.17; Tue, 25 Feb
 2020 03:39:10 +0000
Received: from MN2PR12MB3344.namprd12.prod.outlook.com
 ([fe80::69c7:b493:690:2173]) by MN2PR12MB3344.namprd12.prod.outlook.com
 ([fe80::69c7:b493:690:2173%3]) with mapi id 15.20.2750.021; Tue, 25 Feb 2020
 03:39:10 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Min, Frank" <Frank.Min@amd.com>
Subject: RE: [PATCH] drm/amdgpu: update psp firmwares loading sequence V2
Thread-Topic: [PATCH] drm/amdgpu: update psp firmwares loading sequence V2
Thread-Index: AQHV6v5SHwXW1ZrfJUyXJVm2rsv1aagqNrWAgAEM/PA=
Date: Tue, 25 Feb 2020 03:39:10 +0000
Message-ID: <MN2PR12MB33442F892C84D75C2788E659E4ED0@MN2PR12MB3344.namprd12.prod.outlook.com>
References: <20200224103629.9344-1-evan.quan@amd.com>
 <DM5PR12MB14182932E713D06F6462882DFCEC0@DM5PR12MB1418.namprd12.prod.outlook.com>
In-Reply-To: <DM5PR12MB14182932E713D06F6462882DFCEC0@DM5PR12MB1418.namprd12.prod.outlook.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-02-24T11:34:14Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=b989024a-e732-4bbf-9cb3-00004960a5c1;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Evan.Quan@amd.com; 
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 005cf51c-9e6c-4f8f-83f5-08d7b9a44690
x-ms-traffictypediagnostic: MN2PR12MB4077:|MN2PR12MB4077:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB4077C6D0E4A5C8A98F4EEC03E4ED0@MN2PR12MB4077.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0324C2C0E2
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(136003)(366004)(396003)(376002)(39860400002)(199004)(189003)(7696005)(64756008)(55016002)(81166006)(9686003)(186003)(6636002)(71200400001)(8936002)(33656002)(81156014)(8676002)(26005)(2906002)(15650500001)(66476007)(66556008)(5660300002)(66446008)(316002)(6506007)(66946007)(478600001)(4326008)(53546011)(86362001)(110136005)(76116006)(52536014);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB4077;
 H:MN2PR12MB3344.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: A5NOAsZzOQxdprwAI8+FArGc5Puw08JbpL+EpW4F+06oNUhd5aYhaFiNQYklpFB5yMUVB56say2MH6tPWzF/qyCHPnKQ378NfOX2TVL+SVH+TLH0hR7R8XoTU03zBBdw41PRusBQb+mYspMSVIUQsEPEiK/bYJcr/cx63fFtDlABjFiXLmidaxA2ZIPloo4HlVt3xmXluEYEtMDu6wicOrITGXWuxZ72PUJFbnCFzbvdAL7ul0EIcc6OGIby0mju72nYS48iOXjA7hEyhDHWAubiDNCXAIDsNuIUreFvLN5Jy1MG9BT68jweFe+YjkTb+/lc0e3ldL9Sk7r+K5CRNIEKb4t4jER7zumPE8fkUxN/Mr8W3GNa0IdE3G/BLp8GIoK/rOG0jK7SfAELGrHgdTijeWPr+9gyKsFs7HEJ5Y5gLqKmZxKW+zxOeluiy+5e
x-ms-exchange-antispam-messagedata: FtxI7iqr2j5wh2IomNEO7jmUeYpbZtaA1L7FGt3sUmQaNvDg5j2FMy3x3z0jQR051jFz0CsK1JTnSGbnKpqA/MyblFkZ2S6SpGxfWbGRjZuF790Za1512WjQM2ZlwvcNaA5lt1+lswtps9YyiyXAtA==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 005cf51c-9e6c-4f8f-83f5-08d7b9a44690
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2020 03:39:10.3017 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qZYkDjwNITscBDApcKH0uIOtwE+3eBpYDqWBUO3Rg+8VtR9aYz//pls7DVpE/gRK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4077
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

Hi Hawking,

Do you mean SRIOV may need this change also? 
Currently this covers bare-metal case only(SRIOV still follows old firmwares loading sequence).

Regards,
Evan
-----Original Message-----
From: Zhang, Hawking <Hawking.Zhang@amd.com> 
Sent: Monday, February 24, 2020 7:34 PM
To: Quan, Evan <Evan.Quan@amd.com>; amd-gfx@lists.freedesktop.org; Min, Frank <Frank.Min@amd.com>
Cc: Feng, Kenneth <Kenneth.Feng@amd.com>
Subject: RE: [PATCH] drm/amdgpu: update psp firmwares loading sequence V2

[AMD Official Use Only - Internal Distribution Only]

The patch looks good for bare-metal case now. Frank is still on the way to clean up our concern on SETUP_VMR command (i.e. SETUP_TMR for bare-metal case). After that settled, please push the patch with my RB. Thanks.

Regards,
Hawking
-----Original Message-----
From: Quan, Evan <Evan.Quan@amd.com> 
Sent: Monday, February 24, 2020 18:36
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Feng, Kenneth <Kenneth.Feng@amd.com>; Quan, Evan <Evan.Quan@amd.com>
Subject: [PATCH] drm/amdgpu: update psp firmwares loading sequence V2

For those ASICs with DF Cstate management centralized to PMFW, TMR setup should be performed between pmfw loading and other non-psp firmwares loading.

V2: skip possible SMU firmware reloading

Change-Id: I8986ddb4d9ffe63ed0823d1dce8d9d52812a1240
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 65 ++++++++++++++++++++++---  drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h |  2 +
 2 files changed, 61 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 51839ab02b84..d33f74100094 100644
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
@@ -1333,7 +1384,9 @@ static int psp_np_fw_load(struct psp_context *psp)
 			continue;
 
 		if (ucode->ucode_id == AMDGPU_UCODE_ID_SMC &&
-		    (psp_smu_reload_quirk(psp) || psp->autoload_supported))
+		    (psp_smu_reload_quirk(psp) ||
+		     psp->autoload_supported ||
+		     psp->pmfw_centralized_cstate_management))
 			continue;
 
 		if (amdgpu_sriov_vf(adev) &&
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
