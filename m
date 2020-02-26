Return-Path: <SRS0=BS7L=4O=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19C40C4BA21
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Feb 2020 19:35:38 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C5FF724672
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Feb 2020 19:35:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="AKTLh32N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5FF724672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 486B889CA2;
	Wed, 26 Feb 2020 19:35:37 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2046.outbound.protection.outlook.com [40.107.220.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2CEB789CA2
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Feb 2020 19:35:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KF2UmDwHHFnk7MdnUa4H466CumHHjdHvZWMprOi6TyZx7tOK3p8/hWFrwe98jY1eQb/IlQytoXON6b+A59C7/3Ltp5KytOJltz8lpBFKtikkOguc6DFKM6ECk9HMvHD3ZQKQp5hVWnRkxW74XBOaPKV4ZxDEgp5YVpGvOLUC46v9TKAmh9b2zSYKMta0f92KArUJ/mbDKF9MtSXzz3jt9PaV9uLld6Gyf5gpyellG/iWcNyxsQHrCxPiwyPgaleU1175vgpk9p2BLuAwEahY5p4ayVmZ/3zOQGtwBFRp+kwh5ohe+RE/GspZkaFx/copwVpKdenUGfrWvSZmzXy1SQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wI2Kitm0+raq9ONpDYt1tJVd1FKmPQ3rsuwnYNCRMWU=;
 b=dva3MSUOqNuHo3yVxRgLH8fCisaI95yr4hZeWPXvDt5V+1zCnlklO4orkviBj1s6ZyjZAOJZMg0LmlmGJSQxhIOFnLf/rmwO9x3GejN9Os80xJoswzbhdKuvEcpI22+oN3udwzvPKOObnzSAXE4rHaqUdiO3qoABGunF+IUOiYv7ASKNfq1mDXis5CyGUZmvVjO8sUJFWpjwVoYhVa6G/cpYdgTQIowzxhTD/Zmg3XXlaCnRYz/NgTVkEI6T4Xfq7g4zj5skD27aM6Nkd/9hTiFHQ2dhWhnfOde1ioynAVj6GZ3AdoxJq7ztnSmDPlcL2GlqnksOCRKLvylX/oOe7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wI2Kitm0+raq9ONpDYt1tJVd1FKmPQ3rsuwnYNCRMWU=;
 b=AKTLh32NP39QIyj035en74HzuY+YmjbisIJ80YKxa0DiIVAfVLvajdYKhiTd4Y2HjbcWqWW+glOK243G57YsEAjJ4rExooJ0iiZYXA0IEmheaMmtqNs33OaUcR4FkziR5szZLMLeX0897Scf0EjB26qVg2KGqqfde+UBuF2oPAY=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Zhigang.Luo@amd.com; 
Received: from DM5PR1201MB0266.namprd12.prod.outlook.com (2603:10b6:4:57::13)
 by DM5PR1201MB0010.namprd12.prod.outlook.com (2603:10b6:3:e3::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.22; Wed, 26 Feb
 2020 19:35:34 +0000
Received: from DM5PR1201MB0266.namprd12.prod.outlook.com
 ([fe80::c1b7:15f9:4051:a209]) by DM5PR1201MB0266.namprd12.prod.outlook.com
 ([fe80::c1b7:15f9:4051:a209%10]) with mapi id 15.20.2750.021; Wed, 26 Feb
 2020 19:35:34 +0000
From: Zhigang Luo <zhigang.luo@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: add CAP fw loading
Date: Wed, 26 Feb 2020 14:35:13 -0500
Message-Id: <20200226193513.19417-1-zhigang.luo@amd.com>
X-Mailer: git-send-email 2.17.1
X-ClientProxiedBy: YTXPR0101CA0035.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::48) To DM5PR1201MB0266.namprd12.prod.outlook.com
 (2603:10b6:4:57::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Zhigang-WS.amd.com (165.204.55.250) by
 YTXPR0101CA0035.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00::48) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2772.15 via Frontend Transport; Wed, 26 Feb 2020 19:35:33 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 1a1134a6-dbc5-44d0-179a-08d7baf30c26
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0010:|DM5PR1201MB0010:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR1201MB0010AF580AB026825ADD398AF1EA0@DM5PR1201MB0010.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-Forefront-PRVS: 0325F6C77B
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(346002)(366004)(376002)(136003)(396003)(189003)(199004)(6666004)(26005)(66946007)(66556008)(5660300002)(956004)(2616005)(16526019)(186003)(6486002)(36756003)(8676002)(66476007)(2906002)(7696005)(81156014)(81166006)(4326008)(316002)(8936002)(1076003)(6916009)(44832011)(86362001)(478600001)(52116002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR1201MB0010;
 H:DM5PR1201MB0266.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gmN1MwxrplvUVI+HtGjtBVwEHC4olPy3Dx9FS8Be4A8LxqNeiusLwaR12Zwz9WJ/Kh/YiSC1qqZseZAAVnI/WnfHUyZjxl167G4+pf255xA11v9FVwi+rhlY5Eqf7vu5krqZrz8qYz6TvEi4b21+zLS0/jAM58hRARq1bQubPVqOGxcGRai6Kpu1GDaZmJVlR4dPfknLAvJZVSKHvwZqow401XXqmH3v/7NF1WrTdQFIdYXrOy1Bf1m4LigX7ld5TkU1ioEW3N3D9wjum9GXpqfUgwEwnFn1f0lu6dW/PBU7m5HFFIRfNok//Uv7wrTLalMoaUlDg4+qvXvltj9uIrIhhb4hZ3HH4RXx1ty/CoOrh9rmAx6nnrWF0qIS3uv5Y2upsFgL9Sz+nwVcDJGVC2j1onDCIyxy7SFWAoJhzNKAEj9BCxfz4jZV3jl8aoHz
X-MS-Exchange-AntiSpam-MessageData: CF5xjP1ja8Jsk/u+Kz1HW8ZLL9nvnGtjmVB/+WpB84/DL09YKhxkHXUfpcD9Yq1ltTK00SltL9eWDusaz16gwSp98zDtY5vznxsqqgldHOymGEzOb93CvCnsbLZWs15n8aTY4TiEt2Us5PUh0ocRAQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a1134a6-dbc5-44d0-179a-08d7baf30c26
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2020 19:35:34.1815 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vaL7eVYAKBUKPMWDna9bNBi2816HSb5wlDkLMiqwu/9Vi2v4fgbR3gm3FY1YanS0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0010
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
Cc: Zhigang Luo <zhigang.luo@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The CAP fw is for enabling driver compatibility. Currently, it only
enabled for vega10 VF.

Signed-off-by: Zhigang Luo <zhigang.luo@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c   |  9 +++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h   |  3 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h |  3 ++-
 drivers/gpu/drm/amd/amdgpu/psp_gfx_if.h   |  1 +
 drivers/gpu/drm/amd/amdgpu/psp_v3_1.c     | 26 +++++++++++++++++++++++
 5 files changed, 40 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 0c88837bb890..6ebc04c95927 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -93,6 +93,10 @@ static int psp_sw_fini(void *handle)
 	adev->psp.sos_fw = NULL;
 	release_firmware(adev->psp.asd_fw);
 	adev->psp.asd_fw = NULL;
+	if (adev->psp.cap_fw) {
+		release_firmware(adev->psp.cap_fw);
+		adev->psp.cap_fw = NULL;
+	}
 	if (adev->psp.ta_fw) {
 		release_firmware(adev->psp.ta_fw);
 		adev->psp.ta_fw = NULL;
@@ -162,7 +166,7 @@ psp_cmd_submit_buf(struct psp_context *psp,
 				  ucode->ucode_id);
 		DRM_WARN("psp command failed and response status is (%d)\n",
 			  psp->cmd_buf_mem->resp.status);
-		if (!timeout)
+		if ((ucode->ucode_id == AMDGPU_UCODE_ID_CAP) || !timeout)
 			return -EINVAL;
 	}
 
@@ -841,6 +845,9 @@ static int psp_get_fw_type(struct amdgpu_firmware_info *ucode,
 			   enum psp_gfx_fw_type *type)
 {
 	switch (ucode->ucode_id) {
+	case AMDGPU_UCODE_ID_CAP:
+		*type = GFX_FW_TYPE_CAP;
+		break;
 	case AMDGPU_UCODE_ID_SDMA0:
 		*type = GFX_FW_TYPE_SDMA0;
 		break;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
index 80bbfecc815d..b51901626798 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
@@ -184,6 +184,9 @@ struct psp_context
 	uint64_t			asd_shared_mc_addr;
 	void				*asd_shared_buf;
 
+	/* cap firmware */
+	const struct firmware		*cap_fw;
+
 	/* fence buffer */
 	struct amdgpu_bo		*fence_buf_bo;
 	uint64_t			fence_buf_mc_addr;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h
index c1fb6dc86440..82e13fa43e28 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h
@@ -260,7 +260,8 @@ union amdgpu_firmware_header {
  * fw loading support
  */
 enum AMDGPU_UCODE_ID {
-	AMDGPU_UCODE_ID_SDMA0 = 0,
+	AMDGPU_UCODE_ID_CAP = 0, /* CAP must be the 1st fw to be loaded */
+	AMDGPU_UCODE_ID_SDMA0,
 	AMDGPU_UCODE_ID_SDMA1,
 	AMDGPU_UCODE_ID_CP_CE,
 	AMDGPU_UCODE_ID_CP_PFP,
diff --git a/drivers/gpu/drm/amd/amdgpu/psp_gfx_if.h b/drivers/gpu/drm/amd/amdgpu/psp_gfx_if.h
index 5080a73a95a5..2651d9164007 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_gfx_if.h
+++ b/drivers/gpu/drm/amd/amdgpu/psp_gfx_if.h
@@ -235,6 +235,7 @@ enum psp_gfx_fw_type {
 	GFX_FW_TYPE_RLX6_DRAM_BOOT                  = 48,   /* RLX6 DRAM BOOT           NV      */
 	GFX_FW_TYPE_VCN0_RAM                        = 49,   /* VCN_RAM  NV */
 	GFX_FW_TYPE_VCN1_RAM                        = 50,   /* VCN_RAM  NV */
+	GFX_FW_TYPE_CAP                             = 62,   /* CAP_FW                   VG      */
 	GFX_FW_TYPE_MAX
 };
 
diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v3_1.c b/drivers/gpu/drm/amd/amdgpu/psp_v3_1.c
index ec3a05602f11..6ffcc89e9e28 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v3_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v3_1.c
@@ -42,6 +42,7 @@
 
 MODULE_FIRMWARE("amdgpu/vega10_sos.bin");
 MODULE_FIRMWARE("amdgpu/vega10_asd.bin");
+MODULE_FIRMWARE("amdgpu/vega10_cap.bin");
 MODULE_FIRMWARE("amdgpu/vega12_sos.bin");
 MODULE_FIRMWARE("amdgpu/vega12_asd.bin");
 
@@ -61,6 +62,7 @@ static int psp_v3_1_init_microcode(struct psp_context *psp)
 	char fw_name[30];
 	int err = 0;
 	const struct psp_firmware_header_v1_0 *hdr;
+	struct amdgpu_firmware_info *info = NULL;
 
 	DRM_DEBUG("\n");
 
@@ -110,6 +112,26 @@ static int psp_v3_1_init_microcode(struct psp_context *psp)
 	adev->psp.asd_start_addr = (uint8_t *)hdr +
 				le32_to_cpu(hdr->header.ucode_array_offset_bytes);
 
+	if (amdgpu_sriov_vf(adev) && adev->asic_type == CHIP_VEGA10) {
+		snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_cap.bin",
+			 chip_name);
+		err = request_firmware(&adev->psp.cap_fw, fw_name, adev->dev);
+		if (err)
+			goto out;
+
+		err = amdgpu_ucode_validate(adev->psp.cap_fw);
+		if (err)
+			goto out;
+
+		info = &adev->firmware.ucode[AMDGPU_UCODE_ID_CAP];
+		info->ucode_id = AMDGPU_UCODE_ID_CAP;
+		info->fw = adev->psp.cap_fw;
+		hdr = (const struct psp_firmware_header_v1_0 *)
+			      adev->psp.cap_fw->data;
+		adev->firmware.fw_size += ALIGN(
+			le32_to_cpu(hdr->header.ucode_size_bytes), PAGE_SIZE);
+	}
+
 	return 0;
 out:
 	if (err) {
@@ -120,6 +142,10 @@ static int psp_v3_1_init_microcode(struct psp_context *psp)
 		adev->psp.sos_fw = NULL;
 		release_firmware(adev->psp.asd_fw);
 		adev->psp.asd_fw = NULL;
+		if (amdgpu_sriov_vf(adev) && adev->asic_type == CHIP_VEGA10) {
+			release_firmware(adev->psp.cap_fw);
+			adev->psp.cap_fw = NULL;
+		}
 	}
 
 	return err;
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
