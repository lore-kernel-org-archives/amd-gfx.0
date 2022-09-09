Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD117ECAAA1
	for <amd-gfx@archiver.kernel.org>; Fri,  9 Sep 2022 23:00:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1749310E12D;
	Fri,  9 Sep 2022 23:00:27 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2086.outbound.protection.outlook.com [40.107.102.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1FD4F10E0A1
 for <amd-gfx@lists.freedesktop.org>; Fri,  9 Sep 2022 23:00:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DPc0kLz0OBkoCl27DjdGIExkVCimdHgOy4rrod777w/wVAOErPzY+jr8OBSggm1wI7Axrjdlu6Ry5ay07kVPVrGZBkouZI1O6sX4+yKaSBc4LHFZRBSpLDomecUAYekMNLT+XVagD3qQn/lhvjZfw4WKOfNUJJ5BDMmQVE27lFP2donfn6I+9LpYfxnqsMJCFOVuZw+7+q6/Z/o8XSf1xSHiDVh/zV3gJfjjtElt1cyGdcr/J3YjvqdtkMouBuNypI9IdBvKxyK/8i/Tzsy9RdfKhdZx+QbJVrd6VmXs9ewNGkdfo9xUadZsOozPElI8OwtjnPe+TR3TyoybDnPi5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wPI31EFP3coVN1pAw++8KAwWxJWS3/EMOe9a8hm6Xbk=;
 b=K5pQhtEaRMUV3ud3wG7SBXAICrIJNAfj+LjE8Io/8f5y1UOif4Lem4cReJNm54R69+b+0agAQabbsd33nPjhlMaPxyZiRgVEpplry65Zb/AboZL7Vft9CofH5aeA8FsWJI/xlJ35k4vQ7lwXZsurR0z23yj3D+aV5rczxemfc+DrSId7u5pHtu/jmeq+UMWwFlaOCForOZrfD0otom4vxlWGt6hsJA6sLXC3mquy8BawOT377OykbiwcIF/q2wl3IXPPuQxlErROweBPaVm0eVGjHzGMiT21PYkkihHS86o+PdlDdNBJLhYlzjdTwbfvJQij6pLkTaaNjWbpRokJrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wPI31EFP3coVN1pAw++8KAwWxJWS3/EMOe9a8hm6Xbk=;
 b=sTMmvx9EOc/rohLQ91VINrqZV5ObInto6YWNO3WEw00aV6tVdCZJauu9Pnpfs7MbP5oGzhFkedMmk4qgddm1y0ewFRwcmKYKDnBHvSUoh5Kf2ZOQnXYvj1nZQ20J/6n5OCbCrLj4zArscm23x2WOvEth+5t2dtj1KHIxOVhjj8s=
Received: from BN0PR04CA0172.namprd04.prod.outlook.com (2603:10b6:408:eb::27)
 by MN0PR12MB6199.namprd12.prod.outlook.com (2603:10b6:208:3c4::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.12; Fri, 9 Sep
 2022 23:00:20 +0000
Received: from BN8NAM11FT018.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:eb:cafe::95) by BN0PR04CA0172.outlook.office365.com
 (2603:10b6:408:eb::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.12 via Frontend
 Transport; Fri, 9 Sep 2022 23:00:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT018.mail.protection.outlook.com (10.13.176.89) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5612.13 via Frontend Transport; Fri, 9 Sep 2022 23:00:20 +0000
Received: from canli.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 9 Sep
 2022 18:00:18 -0500
From: Candice Li <candice.li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: added support for ras driver loading
Date: Sat, 10 Sep 2022 07:00:05 +0800
Message-ID: <20220909230005.20646-1-candice.li@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT018:EE_|MN0PR12MB6199:EE_
X-MS-Office365-Filtering-Correlation-Id: d8c8136f-9b85-4661-fb71-08da92b71203
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9wBHpoUYelk5nGGqCZSXRvfk/D2zVIpiNgkcLUKOVa4mqEI4m9x10hNMFDRdMWX1fJM0lNVGj6zHW7mT9Luo9FpSJfnfpqnT1z7dqq71PdcZ+8YerwuuGsOH/pXSaD3A9k760l7OnNYrqoH71p0k9nsJ3cvl7xHEaAOFTAh83EmmD3xy7xJoZuC5WYj8DzsvfkshA/62GLlHGLh9qVq8eo/gT+Nk7yXcU97V9xMN10DP0sSz7ldIRtpwtKHsErl8chPo/1BSJ3L56Z9gvRzokBSH3ttvKiNX2crJVVroG1IXo6b+sCVuDK+LJ0CSeZqXjudrj0CnphJrA730Lhu2W41u0uL5MB/aeDlHQP4HqXgU1YfIkC6fz2jv/rzSsc/qHe/lOjySbXZVMm6/LvhrkPzfoMNaXklOJyvKGnPcwtIgGBtduKHMChLt0EKUIXBKC8zQvLiKe2R7SIcsap/qtj0YCme52PiHSksjE+n8coHvo/12WNJ5ALtJN2eflx2YgbDZLXTIe/lnUtUUMtCYxSIyRfzzYxVodXvCt892kkFp1Iu0Ffc6LHX6nxEFmKhJmMasigYGsdRULG61N2/vegzQc4p80bmVyuwXnTUMechuhbwmvZKcRxiY7owOclxl8dLIk6anYaDe63G5oK96cUJkDxgDGWhfBImc2HTSAfNwuEJmXyJmGrjYaaZ1HaOxaUmYaQyeJQpJVPIctoDPEZT6usdIVG8LL1/05Lee8PCSAgGt4iLn6J29cox5p8GQv+u33ylR3S3bc5KDmMCY1qIDCcdCQeCfthB9n/iV0lE=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(396003)(376002)(39860400002)(346002)(136003)(36840700001)(46966006)(40470700004)(44832011)(82310400005)(2906002)(36756003)(70206006)(5660300002)(86362001)(8936002)(4326008)(40480700001)(41300700001)(316002)(8676002)(6666004)(54906003)(6916009)(70586007)(478600001)(40460700003)(7696005)(1076003)(16526019)(186003)(426003)(336012)(26005)(2616005)(81166007)(47076005)(356005)(82740400003)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2022 23:00:20.4642 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d8c8136f-9b85-4661-fb71-08da92b71203
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT018.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6199
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
Cc: Candice Li <candice.li@amd.com>, John Clements <john.clements@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: John Clements <john.clements@amd.com>

copy ras driver to psp if present

Signed-off-by: John Clements <john.clements@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c   | 15 +++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h   |  6 ++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h |  1 +
 drivers/gpu/drm/amd/amdgpu/psp_v13_0.c    |  7 +++++++
 4 files changed, 29 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index cfcaf890a6a122..218666f6203a9f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -2055,6 +2055,15 @@ static int psp_hw_start(struct psp_context *psp)
 			}
 		}
 
+		if ((is_psp_fw_valid(psp->ras_drv)) &&
+		    (psp->funcs->bootloader_load_ras_drv != NULL)) {
+			ret = psp_bootloader_load_ras_drv(psp);
+			if (ret) {
+				DRM_ERROR("PSP load ras_drv failed!\n");
+				return ret;
+			}
+		}
+
 		if ((is_psp_fw_valid(psp->sos)) &&
 		    (psp->funcs->bootloader_load_sos != NULL)) {
 			ret = psp_bootloader_load_sos(psp);
@@ -3040,6 +3049,12 @@ static int parse_sos_bin_descriptor(struct psp_context *psp,
 		psp->dbg_drv.size_bytes         = le32_to_cpu(desc->size_bytes);
 		psp->dbg_drv.start_addr         = ucode_start_addr;
 		break;
+	case PSP_FW_TYPE_PSP_RAS_DRV:
+		psp->ras_drv.fw_version         = le32_to_cpu(desc->fw_version);
+		psp->ras_drv.feature_version    = le32_to_cpu(desc->fw_version);
+		psp->ras_drv.size_bytes         = le32_to_cpu(desc->size_bytes);
+		psp->ras_drv.start_addr         = ucode_start_addr;
+		break;
 	default:
 		dev_warn(psp->adev->dev, "Unsupported PSP FW type: %d\n", desc->fw_type);
 		break;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
index c32b74bd970fc5..d7a5ff4660cf9e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
@@ -71,6 +71,7 @@ enum psp_bootloader_cmd {
 	PSP_BL__LOAD_SOCDRV             = 0xB0000,
 	PSP_BL__LOAD_DBGDRV             = 0xC0000,
 	PSP_BL__LOAD_INTFDRV		= 0xD0000,
+	PSP_BL__LOAD_RASDRV		    = 0xE0000,
 	PSP_BL__DRAM_LONG_TRAIN		= 0x100000,
 	PSP_BL__DRAM_SHORT_TRAIN	= 0x200000,
 	PSP_BL__LOAD_TOS_SPL_TABLE	= 0x10000000,
@@ -114,6 +115,7 @@ struct psp_funcs
 	int (*bootloader_load_soc_drv)(struct psp_context *psp);
 	int (*bootloader_load_intf_drv)(struct psp_context *psp);
 	int (*bootloader_load_dbg_drv)(struct psp_context *psp);
+	int (*bootloader_load_ras_drv)(struct psp_context *psp);
 	int (*bootloader_load_sos)(struct psp_context *psp);
 	int (*ring_init)(struct psp_context *psp, enum psp_ring_type ring_type);
 	int (*ring_create)(struct psp_context *psp,
@@ -323,6 +325,7 @@ struct psp_context
 	struct psp_bin_desc		soc_drv;
 	struct psp_bin_desc		intf_drv;
 	struct psp_bin_desc		dbg_drv;
+	struct psp_bin_desc		ras_drv;
 
 	/* tmr buffer */
 	struct amdgpu_bo		*tmr_bo;
@@ -403,6 +406,9 @@ struct amdgpu_psp_funcs {
 		((psp)->funcs->bootloader_load_intf_drv ? (psp)->funcs->bootloader_load_intf_drv((psp)) : 0)
 #define psp_bootloader_load_dbg_drv(psp) \
 		((psp)->funcs->bootloader_load_dbg_drv ? (psp)->funcs->bootloader_load_dbg_drv((psp)) : 0)
+#define psp_bootloader_load_ras_drv(psp) \
+		((psp)->funcs->bootloader_load_ras_drv ? \
+		(psp)->funcs->bootloader_load_ras_drv((psp)) : 0)
 #define psp_bootloader_load_sos(psp) \
 		((psp)->funcs->bootloader_load_sos ? (psp)->funcs->bootloader_load_sos((psp)) : 0)
 #define psp_smu_reload_quirk(psp) \
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h
index 96b6cf4c4d54f8..3975bcaa2c8997 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h
@@ -124,6 +124,7 @@ enum psp_fw_type {
 	PSP_FW_TYPE_PSP_SOC_DRV,
 	PSP_FW_TYPE_PSP_INTF_DRV,
 	PSP_FW_TYPE_PSP_DBG_DRV,
+	PSP_FW_TYPE_PSP_RAS_DRV,
 };
 
 /* version_major=2, version_minor=0 */
diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c b/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
index eac33d5c93e74f..262dcd7513a6fb 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
@@ -223,6 +223,12 @@ static int psp_v13_0_bootloader_load_dbg_drv(struct psp_context *psp)
 	return psp_v13_0_bootloader_load_component(psp, &psp->dbg_drv, PSP_BL__LOAD_DBGDRV);
 }
 
+static int psp_v13_0_bootloader_load_ras_drv(struct psp_context *psp)
+{
+	return psp_v13_0_bootloader_load_component(psp, &psp->ras_drv, PSP_BL__LOAD_RASDRV);
+}
+
+
 static int psp_v13_0_bootloader_load_sos(struct psp_context *psp)
 {
 	int ret;
@@ -719,6 +725,7 @@ static const struct psp_funcs psp_v13_0_funcs = {
 	.bootloader_load_soc_drv = psp_v13_0_bootloader_load_soc_drv,
 	.bootloader_load_intf_drv = psp_v13_0_bootloader_load_intf_drv,
 	.bootloader_load_dbg_drv = psp_v13_0_bootloader_load_dbg_drv,
+	.bootloader_load_ras_drv = psp_v13_0_bootloader_load_ras_drv,
 	.bootloader_load_sos = psp_v13_0_bootloader_load_sos,
 	.ring_init = psp_v13_0_ring_init,
 	.ring_create = psp_v13_0_ring_create,
-- 
2.17.1

