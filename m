Return-Path: <SRS0=y1ja=OA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8457C433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Sep 2021 09:49:21 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 708426113E
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Sep 2021 09:49:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 708426113E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2653D6E9B4;
	Fri, 10 Sep 2021 09:49:21 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2077.outbound.protection.outlook.com [40.107.237.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 89D646E9B4
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Sep 2021 09:49:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FS568uAnnY0wqcOGAvSjqfW9aBoAMD5ol39W+FjZT88LqsKCwmmmAD9EdmQSHKpReufHUaVinWcaU/5o8hokNAZfPh9pYLBib196qlpeHOhnshGrMxoCVCyHJPEZtVzAMPcZyen2U1qofiwGnxGHdCZWa5GGFUtJ10qvTp1GrlxD7lDugMQl96+Wt8qBKDJe4OsoT2zRgh54ZICfiq0t9oTnojIT7On+LjAGxmCru1Z2LEXs7zB1RQM5iPItqWsbSeMPH0GBIOc6HSyEhEoSBgfAwaNFf6TRUnElNe3tcDMWRewVduKdz0QfozVbS7RkM9++K1opteeKzrrSN9dsXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=XRQxOZZaklwGa5QHmdumpx/FXnQnvMpSIZBM07ywqZw=;
 b=ElG1oJQxOnwPyOOyNp4ALuJLAXPiFDjT5rDu0FLifAx1h4guZdaJr/L5n/p5SzUy0tXnfWKwGnLL/jK4uGon+k35pKiGgAg36p0dwGQeBmNkbVSSQjbHbLafwwEpBmz9IMXF0HXsTfZuvBwl1x7yjSDRkMzStt5vauCjLRMSzxaky7M0q+pVhQzrsNQofAvs5ubTTkWfSctIomy43Es2YUSbCm+gSCa/+0Zy+WXh4V8dzEHHtuABJVAgCZeEFzeBldi2ZWVzot3qWKxL/XTx5P74DNEtKo2eDvxT6f9If22JBrBoViq0hjxiQAyEcIoUmaTgrMOAllgkW2YL7YwvHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XRQxOZZaklwGa5QHmdumpx/FXnQnvMpSIZBM07ywqZw=;
 b=aH979jbcHp6f295aSRzOxp6Knn2pldJu+91VVMgK4AfS8YLUXD4CIXmJ5TBN6zE+UvwfMKVWUoqBZItxhr0uDS9bFYzH3RAE9re5HGC/oVNcH2E+bVWxA5aV+YqJtNHa/ykfR7RljCaqj22Wqg8AL4aZo4DTGdzxM/99r28KxH0=
Received: from DM5PR12CA0057.namprd12.prod.outlook.com (2603:10b6:3:103::19)
 by BN6PR12MB1795.namprd12.prod.outlook.com (2603:10b6:404:107::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.15; Fri, 10 Sep
 2021 09:49:17 +0000
Received: from DM6NAM11FT065.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:103:cafe::ba) by DM5PR12CA0057.outlook.office365.com
 (2603:10b6:3:103::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14 via Frontend
 Transport; Fri, 10 Sep 2021 09:49:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT065.mail.protection.outlook.com (10.13.172.109) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4500.14 via Frontend Transport; Fri, 10 Sep 2021 09:49:16 +0000
Received: from canli.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Fri, 10 Sep
 2021 04:49:14 -0500
From: Candice Li <candice.li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: John Clements <john.clements@amd.com>, Candice Li <candice.li@amd.com>
Subject: [PATCH] drm/amdgpu: Unify PSP TA context
Date: Fri, 10 Sep 2021 17:48:50 +0800
Message-ID: <20210910094850.22498-1-candice.li@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fbad6ae6-1b26-475b-20b2-08d974404118
X-MS-TrafficTypeDiagnostic: BN6PR12MB1795:
X-Microsoft-Antispam-PRVS: <BN6PR12MB1795EB9CFE8FA0AA70ADFCEB91D69@BN6PR12MB1795.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1303;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: R5V+PLbMUZ1cW8Qe+OZGmNRhw7/FjUe3qrA0MJiXFaQBoywh0tYEzi9dl2etN4zppdaSCx+9wiFNlGCdzfJ8d2hkaZw6sfhKwuuz0cAYM4/UTZrW2WsY7FSG8ABsGqs/Fliaia4t00cwKQ7XIE/Tqm6ub4QCuAIrvjIbpuOEWgXaCTNnNlcihrFWVPELbAZJfuZBB8UJoVPAfEn0F/vs7D0C32bDpd36Bkj5JI74n3mhhVXEJ+DlvtEJVrw75dsWY77wMaPCZjb8t6CvVac3GAZd+YYNydR/Aj3XVpoMmpe6QCsqCgN6oc15yiEGRI+5tunPewunPxIB1OlJguqUB6NwczX0VIx1RkgWKMUb1hcG/ZeFtUoOcYdIYYsDDOiSvhqeMr7RfmAZXpNuuR30MKucqHxdUljmS8JGYUsop+tIAlUW07LP84v1KYs17/iEKWY93b5FQZzoxjLw+dU2MnrL9tw7LBwqGgx07BaRUVcoyFreyUham6vSsjxPdMlVVPnIDNaZKhUBFj7YU0W6kLZ4Nx3WRazDG8HP7VPFix2F4NFSBsAnC2rIo+UZaHGLQB+zfEzbwpHoqy+g3i7Br3IqJx6n/lTM1M74m7x/ez0ZmSGiRA+w15d3Kl3ExfTqn+E1su6boicXNsizogW4P5IhAFWy7TAX+LqfOdjSblHBM90lzy9CTYP6ykkF08JFgTbPXkc703g89z02os52hrlsh0D4d5KETcW8bS3Hy24=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(316002)(2616005)(54906003)(47076005)(2906002)(1076003)(70206006)(356005)(508600001)(8936002)(8676002)(70586007)(6666004)(36756003)(426003)(7696005)(30864003)(44832011)(81166007)(36860700001)(6916009)(83380400001)(86362001)(26005)(4326008)(5660300002)(16526019)(82310400003)(186003)(336012)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2021 09:49:16.7445 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fbad6ae6-1b26-475b-20b2-08d974404118
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT065.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1795
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Remove all TA binary structures and add the specific binary
structure in struct ta_context.

Signed-off-by: Candice Li <candice.li@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c   |  23 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c   | 122 +++++++++++-----------
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h   |  23 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c |   6 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c  |   9 +-
 drivers/gpu/drm/amd/amdgpu/psp_v10_0.c    |  22 ++--
 drivers/gpu/drm/amd/amdgpu/psp_v11_0.c    |  40 ++++---
 drivers/gpu/drm/amd/amdgpu/psp_v12_0.c    |  14 +--
 8 files changed, 141 insertions(+), 118 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index 7e45640fbee026..d2955ea4a62bf4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -341,27 +341,34 @@ static int amdgpu_firmware_info(struct drm_amdgpu_info_firmware *fw_info,
 		switch (query_fw->index) {
 		case TA_FW_TYPE_PSP_XGMI:
 			fw_info->ver = adev->psp.ta_fw_version;
-			fw_info->feature = adev->psp.xgmi.feature_version;
+			fw_info->feature = adev->psp.xgmi_context.context
+						   .bin_desc.feature_version;
 			break;
 		case TA_FW_TYPE_PSP_RAS:
 			fw_info->ver = adev->psp.ta_fw_version;
-			fw_info->feature = adev->psp.ras.feature_version;
+			fw_info->feature = adev->psp.ras_context.context
+						   .bin_desc.feature_version;
 			break;
 		case TA_FW_TYPE_PSP_HDCP:
 			fw_info->ver = adev->psp.ta_fw_version;
-			fw_info->feature = adev->psp.hdcp.feature_version;
+			fw_info->feature = adev->psp.hdcp_context.context
+						   .bin_desc.feature_version;
 			break;
 		case TA_FW_TYPE_PSP_DTM:
 			fw_info->ver = adev->psp.ta_fw_version;
-			fw_info->feature = adev->psp.dtm.feature_version;
+			fw_info->feature = adev->psp.dtm_context.context
+						   .bin_desc.feature_version;
 			break;
 		case TA_FW_TYPE_PSP_RAP:
 			fw_info->ver = adev->psp.ta_fw_version;
-			fw_info->feature = adev->psp.rap.feature_version;
+			fw_info->feature = adev->psp.rap_context.context
+						   .bin_desc.feature_version;
 			break;
 		case TA_FW_TYPE_PSP_SECUREDISPLAY:
 			fw_info->ver = adev->psp.ta_fw_version;
-			fw_info->feature = adev->psp.securedisplay.feature_version;
+			fw_info->feature =
+				adev->psp.securedisplay_context.context.bin_desc
+					.feature_version;
 			break;
 		default:
 			return -EINVAL;
@@ -378,8 +385,8 @@ static int amdgpu_firmware_info(struct drm_amdgpu_info_firmware *fw_info,
 		fw_info->feature = adev->psp.sos.feature_version;
 		break;
 	case AMDGPU_INFO_FW_ASD:
-		fw_info->ver = adev->psp.asd.fw_version;
-		fw_info->feature = adev->psp.asd.feature_version;
+		fw_info->ver = adev->psp.asd_context.bin_desc.fw_version;
+		fw_info->feature = adev->psp.asd_context.bin_desc.feature_version;
 		break;
 	case AMDGPU_INFO_FW_DMCU:
 		fw_info->ver = adev->dm.dmcu_fw_version;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 885876e2ce73b6..071dadf3a4509f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -803,15 +803,16 @@ static int psp_asd_load(struct psp_context *psp)
 	 * add workaround to bypass it for sriov now.
 	 * TODO: add version check to make it common
 	 */
-	if (amdgpu_sriov_vf(psp->adev) || !psp->asd.size_bytes)
+	if (amdgpu_sriov_vf(psp->adev) || !psp->asd_context.bin_desc.size_bytes)
 		return 0;
 
 	cmd = acquire_psp_cmd_buf(psp);
 
-	psp_copy_fw(psp, psp->asd.start_addr, psp->asd.size_bytes);
+	psp_copy_fw(psp, psp->asd_context.bin_desc.start_addr,
+		    psp->asd_context.bin_desc.size_bytes);
 
 	psp_prep_asd_load_cmd_buf(cmd, psp->fw_pri_mc_addr,
-				  psp->asd.size_bytes);
+				  psp->asd_context.bin_desc.size_bytes);
 
 	ret = psp_cmd_submit_buf(psp, NULL, cmd,
 				 psp->fence_buf_mc_addr);
@@ -900,17 +901,18 @@ int psp_reg_program(struct psp_context *psp, enum psp_reg_prog_id reg,
 
 static void psp_prep_ta_load_cmd_buf(struct psp_gfx_cmd_resp *cmd,
 				     uint64_t ta_bin_mc,
-				     uint32_t ta_bin_size,
-				     struct ta_mem_context *mem_ctx)
+				     struct ta_context *context)
 {
 	cmd->cmd_id				= GFX_CMD_ID_LOAD_TA;
 	cmd->cmd.cmd_load_ta.app_phy_addr_lo 	= lower_32_bits(ta_bin_mc);
 	cmd->cmd.cmd_load_ta.app_phy_addr_hi	= upper_32_bits(ta_bin_mc);
-	cmd->cmd.cmd_load_ta.app_len		= ta_bin_size;
+	cmd->cmd.cmd_load_ta.app_len		= context->bin_desc.size_bytes;
 
-	cmd->cmd.cmd_load_ta.cmd_buf_phy_addr_lo = lower_32_bits(mem_ctx->shared_mc_addr);
-	cmd->cmd.cmd_load_ta.cmd_buf_phy_addr_hi = upper_32_bits(mem_ctx->shared_mc_addr);
-	cmd->cmd.cmd_load_ta.cmd_buf_len	 = mem_ctx->shared_mem_size;
+	cmd->cmd.cmd_load_ta.cmd_buf_phy_addr_lo =
+		lower_32_bits(context->mem_context.shared_mc_addr);
+	cmd->cmd.cmd_load_ta.cmd_buf_phy_addr_hi =
+		upper_32_bits(context->mem_context.shared_mc_addr);
+	cmd->cmd.cmd_load_ta.cmd_buf_len = context->mem_context.shared_mem_size;
 }
 
 static int psp_ta_init_shared_buf(struct psp_context *psp,
@@ -969,7 +971,6 @@ static int psp_ta_invoke(struct psp_context *psp,
 }
 
 static int psp_ta_load(struct psp_context *psp,
-			   struct psp_bin_desc *bin_desc,
 			   struct ta_context *context)
 {
 	int ret;
@@ -977,12 +978,12 @@ static int psp_ta_load(struct psp_context *psp,
 
 	cmd = acquire_psp_cmd_buf(psp);
 
-	psp_copy_fw(psp, bin_desc->start_addr, bin_desc->size_bytes);
+	psp_copy_fw(psp, context->bin_desc.start_addr,
+		    context->bin_desc.size_bytes);
 
 	psp_prep_ta_load_cmd_buf(cmd,
 				 psp->fw_pri_mc_addr,
-				 bin_desc->size_bytes,
-				 &context->mem_context);
+				 context);
 
 	ret = psp_cmd_submit_buf(psp, NULL, cmd,
 				 psp->fence_buf_mc_addr);
@@ -998,7 +999,7 @@ static int psp_ta_load(struct psp_context *psp,
 
 static int psp_xgmi_load(struct psp_context *psp)
 {
-	return psp_ta_load(psp, &psp->xgmi, &psp->xgmi_context.context);
+	return psp_ta_load(psp, &psp->xgmi_context.context);
 }
 
 static int psp_xgmi_unload(struct psp_context *psp)
@@ -1042,8 +1043,8 @@ int psp_xgmi_initialize(struct psp_context *psp, bool set_extended_data, bool lo
 	int ret;
 
 	if (!psp->ta_fw ||
-	    !psp->xgmi.size_bytes ||
-	    !psp->xgmi.start_addr)
+	    !psp->xgmi_context.context.bin_desc.size_bytes ||
+	    !psp->xgmi_context.context.bin_desc.start_addr)
 		return -ENOENT;
 
 	if (!load_ta)
@@ -1119,7 +1120,7 @@ int psp_xgmi_get_node_id(struct psp_context *psp, uint64_t *node_id)
 static bool psp_xgmi_peer_link_info_supported(struct psp_context *psp)
 {
 	return psp->adev->asic_type == CHIP_ALDEBARAN &&
-				psp->xgmi.feature_version >= 0x2000000b;
+				psp->xgmi_context.context.bin_desc.feature_version >= 0x2000000b;
 }
 
 /*
@@ -1288,7 +1289,7 @@ static int psp_ras_init_shared_buf(struct psp_context *psp)
 
 static int psp_ras_load(struct psp_context *psp)
 {
-	return psp_ta_load(psp, &psp->ras, &psp->ras_context.context);
+	return psp_ta_load(psp, &psp->ras_context.context);
 }
 
 static int psp_ras_unload(struct psp_context *psp)
@@ -1401,8 +1402,8 @@ static int psp_ras_initialize(struct psp_context *psp)
 	if (amdgpu_sriov_vf(adev))
 		return 0;
 
-	if (!adev->psp.ras.size_bytes ||
-	    !adev->psp.ras.start_addr) {
+	if (!adev->psp.ras_context.context.bin_desc.size_bytes ||
+	    !adev->psp.ras_context.context.bin_desc.start_addr) {
 		dev_info(adev->dev, "RAS: optional ras ta ucode is not available\n");
 		return 0;
 	}
@@ -1518,8 +1519,9 @@ static int psp_hdcp_init_shared_buf(struct psp_context *psp)
 
 static int psp_hdcp_load(struct psp_context *psp)
 {
-	return psp_ta_load(psp, &psp->hdcp, &psp->hdcp_context.context);
+	return psp_ta_load(psp, &psp->hdcp_context.context);
 }
+
 static int psp_hdcp_initialize(struct psp_context *psp)
 {
 	int ret;
@@ -1530,8 +1532,8 @@ static int psp_hdcp_initialize(struct psp_context *psp)
 	if (amdgpu_sriov_vf(psp->adev))
 		return 0;
 
-	if (!psp->hdcp.size_bytes ||
-	    !psp->hdcp.start_addr) {
+	if (!psp->hdcp_context.context.bin_desc.size_bytes ||
+	    !psp->hdcp_context.context.bin_desc.start_addr) {
 		dev_info(psp->adev->dev, "HDCP: optional hdcp ta ucode is not available\n");
 		return 0;
 	}
@@ -1608,7 +1610,7 @@ static int psp_dtm_init_shared_buf(struct psp_context *psp)
 
 static int psp_dtm_load(struct psp_context *psp)
 {
-	return psp_ta_load(psp, &psp->dtm, &psp->dtm_context.context);
+	return psp_ta_load(psp, &psp->dtm_context.context);
 }
 
 static int psp_dtm_initialize(struct psp_context *psp)
@@ -1621,8 +1623,8 @@ static int psp_dtm_initialize(struct psp_context *psp)
 	if (amdgpu_sriov_vf(psp->adev))
 		return 0;
 
-	if (!psp->dtm.size_bytes ||
-	    !psp->dtm.start_addr) {
+	if (!psp->dtm_context.context.bin_desc.size_bytes ||
+	    !psp->dtm_context.context.bin_desc.start_addr) {
 		dev_info(psp->adev->dev, "DTM: optional dtm ta ucode is not available\n");
 		return 0;
 	}
@@ -1699,7 +1701,7 @@ static int psp_rap_init_shared_buf(struct psp_context *psp)
 
 static int psp_rap_load(struct psp_context *psp)
 {
-	return psp_ta_load(psp, &psp->rap, &psp->rap_context.context);
+	return psp_ta_load(psp, &psp->rap_context.context);
 }
 
 static int psp_rap_unload(struct psp_context *psp)
@@ -1718,8 +1720,8 @@ static int psp_rap_initialize(struct psp_context *psp)
 	if (amdgpu_sriov_vf(psp->adev))
 		return 0;
 
-	if (!psp->rap.size_bytes ||
-	    !psp->rap.start_addr) {
+	if (!psp->rap_context.context.bin_desc.size_bytes ||
+	    !psp->rap_context.context.bin_desc.start_addr) {
 		dev_info(psp->adev->dev, "RAP: optional rap ta ucode is not available\n");
 		return 0;
 	}
@@ -1813,8 +1815,7 @@ static int psp_securedisplay_init_shared_buf(struct psp_context *psp)
 
 static int psp_securedisplay_load(struct psp_context *psp)
 {
-	return psp_ta_load(psp, &psp->securedisplay,
-			   &psp->securedisplay_context.context);
+	return psp_ta_load(psp, &psp->securedisplay_context.context);
 }
 
 static int psp_securedisplay_unload(struct psp_context *psp)
@@ -1833,8 +1834,8 @@ static int psp_securedisplay_initialize(struct psp_context *psp)
 	if (amdgpu_sriov_vf(psp->adev))
 		return 0;
 
-	if (!psp->securedisplay.size_bytes ||
-	    !psp->securedisplay.start_addr) {
+	if (!psp->securedisplay_context.context.bin_desc.size_bytes ||
+	    !psp->securedisplay_context.context.bin_desc.start_addr) {
 		dev_info(psp->adev->dev, "SECUREDISPLAY: securedisplay ta ucode is not available\n");
 		return 0;
 	}
@@ -2783,10 +2784,10 @@ int psp_init_asd_microcode(struct psp_context *psp,
 		goto out;
 
 	asd_hdr = (const struct psp_firmware_header_v1_0 *)adev->psp.asd_fw->data;
-	adev->psp.asd.fw_version = le32_to_cpu(asd_hdr->header.ucode_version);
-	adev->psp.asd.feature_version = le32_to_cpu(asd_hdr->sos.fw_version);
-	adev->psp.asd.size_bytes = le32_to_cpu(asd_hdr->header.ucode_size_bytes);
-	adev->psp.asd.start_addr = (uint8_t *)asd_hdr +
+	adev->psp.asd_context.bin_desc.fw_version = le32_to_cpu(asd_hdr->header.ucode_version);
+	adev->psp.asd_context.bin_desc.feature_version = le32_to_cpu(asd_hdr->sos.fw_version);
+	adev->psp.asd_context.bin_desc.size_bytes = le32_to_cpu(asd_hdr->header.ucode_size_bytes);
+	adev->psp.asd_context.bin_desc.start_addr = (uint8_t *)asd_hdr +
 				le32_to_cpu(asd_hdr->header.ucode_array_offset_bytes);
 	return 0;
 out:
@@ -3073,40 +3074,43 @@ static int parse_ta_bin_descriptor(struct psp_context *psp,
 
 	switch (desc->fw_type) {
 	case TA_FW_TYPE_PSP_ASD:
-		psp->asd.fw_version        = le32_to_cpu(desc->fw_version);
-		psp->asd.feature_version   = le32_to_cpu(desc->fw_version);
-		psp->asd.size_bytes        = le32_to_cpu(desc->size_bytes);
-		psp->asd.start_addr 	   = ucode_start_addr;
+		psp->asd_context.bin_desc.fw_version        = le32_to_cpu(desc->fw_version);
+		psp->asd_context.bin_desc.feature_version   = le32_to_cpu(desc->fw_version);
+		psp->asd_context.bin_desc.size_bytes        = le32_to_cpu(desc->size_bytes);
+		psp->asd_context.bin_desc.start_addr        = ucode_start_addr;
 		break;
 	case TA_FW_TYPE_PSP_XGMI:
-		psp->xgmi.feature_version  = le32_to_cpu(desc->fw_version);
-		psp->xgmi.size_bytes       = le32_to_cpu(desc->size_bytes);
-		psp->xgmi.start_addr       = ucode_start_addr;
+		psp->xgmi_context.context.bin_desc.feature_version  = le32_to_cpu(desc->fw_version);
+		psp->xgmi_context.context.bin_desc.size_bytes       = le32_to_cpu(desc->size_bytes);
+		psp->xgmi_context.context.bin_desc.start_addr       = ucode_start_addr;
 		break;
 	case TA_FW_TYPE_PSP_RAS:
-		psp->ras.feature_version   = le32_to_cpu(desc->fw_version);
-		psp->ras.size_bytes        = le32_to_cpu(desc->size_bytes);
-		psp->ras.start_addr        = ucode_start_addr;
+		psp->ras_context.context.bin_desc.feature_version   = le32_to_cpu(desc->fw_version);
+		psp->ras_context.context.bin_desc.size_bytes        = le32_to_cpu(desc->size_bytes);
+		psp->ras_context.context.bin_desc.start_addr        = ucode_start_addr;
 		break;
 	case TA_FW_TYPE_PSP_HDCP:
-		psp->hdcp.feature_version  = le32_to_cpu(desc->fw_version);
-		psp->hdcp.size_bytes       = le32_to_cpu(desc->size_bytes);
-		psp->hdcp.start_addr       = ucode_start_addr;
+		psp->hdcp_context.context.bin_desc.feature_version  = le32_to_cpu(desc->fw_version);
+		psp->hdcp_context.context.bin_desc.size_bytes       = le32_to_cpu(desc->size_bytes);
+		psp->hdcp_context.context.bin_desc.start_addr       = ucode_start_addr;
 		break;
 	case TA_FW_TYPE_PSP_DTM:
-		psp->dtm.feature_version  = le32_to_cpu(desc->fw_version);
-		psp->dtm.size_bytes       = le32_to_cpu(desc->size_bytes);
-		psp->dtm.start_addr       = ucode_start_addr;
+		psp->dtm_context.context.bin_desc.feature_version  = le32_to_cpu(desc->fw_version);
+		psp->dtm_context.context.bin_desc.size_bytes       = le32_to_cpu(desc->size_bytes);
+		psp->dtm_context.context.bin_desc.start_addr       = ucode_start_addr;
 		break;
 	case TA_FW_TYPE_PSP_RAP:
-		psp->rap.feature_version  = le32_to_cpu(desc->fw_version);
-		psp->rap.size_bytes       = le32_to_cpu(desc->size_bytes);
-		psp->rap.start_addr       = ucode_start_addr;
+		psp->rap_context.context.bin_desc.feature_version  = le32_to_cpu(desc->fw_version);
+		psp->rap_context.context.bin_desc.size_bytes       = le32_to_cpu(desc->size_bytes);
+		psp->rap_context.context.bin_desc.start_addr       = ucode_start_addr;
 		break;
 	case TA_FW_TYPE_PSP_SECUREDISPLAY:
-		psp->securedisplay.feature_version  = le32_to_cpu(desc->fw_version);
-		psp->securedisplay.size_bytes       = le32_to_cpu(desc->size_bytes);
-		psp->securedisplay.start_addr       = ucode_start_addr;
+		psp->securedisplay_context.context.bin_desc.feature_version =
+			le32_to_cpu(desc->fw_version);
+		psp->securedisplay_context.context.bin_desc.size_bytes =
+			le32_to_cpu(desc->size_bytes);
+		psp->securedisplay_context.context.bin_desc.start_addr =
+			ucode_start_addr;
 		break;
 	default:
 		dev_warn(psp->adev->dev, "Unsupported TA type: %d\n", desc->fw_type);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
index cc09b9e911199a..cfd7ac976cd1e6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
@@ -133,9 +133,17 @@ struct psp_xgmi_topology_info {
 	struct psp_xgmi_node_info	nodes[AMDGPU_XGMI_MAX_CONNECTED_NODES];
 };
 
+struct psp_bin_desc {
+	uint32_t fw_version;
+	uint32_t feature_version;
+	uint32_t size_bytes;
+	uint8_t *start_addr;
+};
+
 struct psp_asd_context {
 	bool			asd_initialized;
 	uint32_t		session_id;
+	struct psp_bin_desc		bin_desc;
 };
 
 struct ta_mem_context {
@@ -149,6 +157,7 @@ struct ta_context {
 	bool			initialized;
 	uint32_t		session_id;
 	struct ta_mem_context	mem_context;
+	struct psp_bin_desc		bin_desc;
 };
 
 struct ta_cp_context {
@@ -266,13 +275,6 @@ struct psp_runtime_boot_cfg_entry {
 	uint32_t reserved;
 };
 
-struct psp_bin_desc {
-	uint32_t fw_version;
-	uint32_t feature_version;
-	uint32_t size_bytes;
-	uint8_t *start_addr;
-};
-
 struct psp_context
 {
 	struct amdgpu_device            *adev;
@@ -304,7 +306,6 @@ struct psp_context
 
 	/* asd firmware */
 	const struct firmware	*asd_fw;
-	struct psp_bin_desc		asd;
 
 	/* toc firmware */
 	const struct firmware		*toc_fw;
@@ -329,12 +330,6 @@ struct psp_context
 	/* xgmi ta firmware and buffer */
 	const struct firmware		*ta_fw;
 	uint32_t			ta_fw_version;
-	struct psp_bin_desc		xgmi;
-	struct psp_bin_desc		ras;
-	struct psp_bin_desc		hdcp;
-	struct psp_bin_desc		dtm;
-	struct psp_bin_desc		rap;
-	struct psp_bin_desc		securedisplay;
 
 	struct psp_asd_context		asd_context;
 	struct psp_xgmi_context		xgmi_context;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
index 5f396936c6addf..527d67ded8a008 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
@@ -525,9 +525,9 @@ FW_VERSION_ATTR(rlc_srls_fw_version, 0444, gfx.rlc_srls_fw_version);
 FW_VERSION_ATTR(mec_fw_version, 0444, gfx.mec_fw_version);
 FW_VERSION_ATTR(mec2_fw_version, 0444, gfx.mec2_fw_version);
 FW_VERSION_ATTR(sos_fw_version, 0444, psp.sos.fw_version);
-FW_VERSION_ATTR(asd_fw_version, 0444, psp.asd.fw_version);
-FW_VERSION_ATTR(ta_ras_fw_version, 0444, psp.ras.feature_version);
-FW_VERSION_ATTR(ta_xgmi_fw_version, 0444, psp.xgmi.feature_version);
+FW_VERSION_ATTR(asd_fw_version, 0444, psp.asd_context.bin_desc.fw_version);
+FW_VERSION_ATTR(ta_ras_fw_version, 0444, psp.ras_context.context.bin_desc.feature_version);
+FW_VERSION_ATTR(ta_xgmi_fw_version, 0444, psp.xgmi_context.context.bin_desc.feature_version);
 FW_VERSION_ATTR(smc_fw_version, 0444, pm.fw_version);
 FW_VERSION_ATTR(sdma_fw_version, 0444, sdma.instance[0].fw_version);
 FW_VERSION_ATTR(sdma2_fw_version, 0444, sdma.instance[1].fw_version);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
index ca058fbcccd43a..88c4177b708ac8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
@@ -532,9 +532,12 @@ static void amdgpu_virt_populate_vf2pf_ucode_info(struct amdgpu_device *adev)
 	POPULATE_UCODE_INFO(vf2pf_info, AMD_SRIOV_UCODE_ID_MEC,      adev->gfx.mec_fw_version);
 	POPULATE_UCODE_INFO(vf2pf_info, AMD_SRIOV_UCODE_ID_MEC2,     adev->gfx.mec2_fw_version);
 	POPULATE_UCODE_INFO(vf2pf_info, AMD_SRIOV_UCODE_ID_SOS,      adev->psp.sos.fw_version);
-	POPULATE_UCODE_INFO(vf2pf_info, AMD_SRIOV_UCODE_ID_ASD,      adev->psp.asd.fw_version);
-	POPULATE_UCODE_INFO(vf2pf_info, AMD_SRIOV_UCODE_ID_TA_RAS,   adev->psp.ras.feature_version);
-	POPULATE_UCODE_INFO(vf2pf_info, AMD_SRIOV_UCODE_ID_TA_XGMI,  adev->psp.xgmi.feature_version);
+	POPULATE_UCODE_INFO(vf2pf_info, AMD_SRIOV_UCODE_ID_ASD,
+			    adev->psp.asd_context.bin_desc.fw_version);
+	POPULATE_UCODE_INFO(vf2pf_info, AMD_SRIOV_UCODE_ID_TA_RAS,
+			    adev->psp.ras_context.context.bin_desc.feature_version);
+	POPULATE_UCODE_INFO(vf2pf_info, AMD_SRIOV_UCODE_ID_TA_XGMI,
+			    adev->psp.xgmi_context.context.bin_desc.feature_version);
 	POPULATE_UCODE_INFO(vf2pf_info, AMD_SRIOV_UCODE_ID_SMC,      adev->pm.fw_version);
 	POPULATE_UCODE_INFO(vf2pf_info, AMD_SRIOV_UCODE_ID_SDMA,     adev->sdma.instance[0].fw_version);
 	POPULATE_UCODE_INFO(vf2pf_info, AMD_SRIOV_UCODE_ID_SDMA2,    adev->sdma.instance[1].fw_version);
diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v10_0.c b/drivers/gpu/drm/amd/amdgpu/psp_v10_0.c
index 5872d68ed13d70..59644015dfc3ee 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v10_0.c
@@ -84,28 +84,28 @@ static int psp_v10_0_init_microcode(struct psp_context *psp)
 
 		ta_hdr = (const struct ta_firmware_header_v1_0 *)
 				 adev->psp.ta_fw->data;
-		adev->psp.hdcp.feature_version =
+		adev->psp.hdcp_context.context.bin_desc.feature_version =
 			le32_to_cpu(ta_hdr->hdcp.fw_version);
-		adev->psp.hdcp.size_bytes =
+		adev->psp.hdcp_context.context.bin_desc.size_bytes =
 			le32_to_cpu(ta_hdr->hdcp.size_bytes);
-		adev->psp.hdcp.start_addr =
+		adev->psp.hdcp_context.context.bin_desc.start_addr =
 			(uint8_t *)ta_hdr +
 			le32_to_cpu(ta_hdr->header.ucode_array_offset_bytes);
 
-		adev->psp.dtm.feature_version =
+		adev->psp.dtm_context.context.bin_desc.feature_version =
 			le32_to_cpu(ta_hdr->dtm.fw_version);
-		adev->psp.dtm.size_bytes =
+		adev->psp.dtm_context.context.bin_desc.size_bytes =
 			le32_to_cpu(ta_hdr->dtm.size_bytes);
-		adev->psp.dtm.start_addr =
-			(uint8_t *)adev->psp.hdcp.start_addr +
+		adev->psp.dtm_context.context.bin_desc.start_addr =
+			(uint8_t *)adev->psp.hdcp_context.context.bin_desc.start_addr +
 			le32_to_cpu(ta_hdr->dtm.offset_bytes);
 
-		adev->psp.securedisplay.feature_version =
+		adev->psp.securedisplay_context.context.bin_desc.feature_version =
 			le32_to_cpu(ta_hdr->securedisplay.fw_version);
-		adev->psp.securedisplay.size_bytes =
+		adev->psp.securedisplay_context.context.bin_desc.size_bytes =
 			le32_to_cpu(ta_hdr->securedisplay.size_bytes);
-		adev->psp.securedisplay.start_addr =
-			(uint8_t *)adev->psp.hdcp.start_addr +
+		adev->psp.securedisplay_context.context.bin_desc.start_addr =
+			(uint8_t *)adev->psp.hdcp_context.context.bin_desc.start_addr +
 			le32_to_cpu(ta_hdr->securedisplay.offset_bytes);
 
 		adev->psp.ta_fw_version = le32_to_cpu(ta_hdr->header.ucode_version);
diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c b/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
index 29bf9f09944be7..3c02e75fd366b5 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
@@ -151,14 +151,20 @@ static int psp_v11_0_init_microcode(struct psp_context *psp)
 				goto out2;
 
 			ta_hdr = (const struct ta_firmware_header_v1_0 *)adev->psp.ta_fw->data;
-			adev->psp.xgmi.feature_version = le32_to_cpu(ta_hdr->xgmi.fw_version);
-			adev->psp.xgmi.size_bytes = le32_to_cpu(ta_hdr->xgmi.size_bytes);
-			adev->psp.xgmi.start_addr = (uint8_t *)ta_hdr +
+			adev->psp.xgmi_context.context.bin_desc.feature_version =
+				le32_to_cpu(ta_hdr->xgmi.fw_version);
+			adev->psp.xgmi_context.context.bin_desc.size_bytes =
+				le32_to_cpu(ta_hdr->xgmi.size_bytes);
+			adev->psp.xgmi_context.context.bin_desc.start_addr =
+				(uint8_t *)ta_hdr +
 				le32_to_cpu(ta_hdr->header.ucode_array_offset_bytes);
 			adev->psp.ta_fw_version = le32_to_cpu(ta_hdr->header.ucode_version);
-			adev->psp.ras.feature_version = le32_to_cpu(ta_hdr->ras.fw_version);
-			adev->psp.ras.size_bytes = le32_to_cpu(ta_hdr->ras.size_bytes);
-			adev->psp.ras.start_addr = (uint8_t *)adev->psp.xgmi.start_addr +
+			adev->psp.ras_context.context.bin_desc.feature_version =
+				le32_to_cpu(ta_hdr->ras.fw_version);
+			adev->psp.ras_context.context.bin_desc.size_bytes =
+				le32_to_cpu(ta_hdr->ras.size_bytes);
+			adev->psp.ras_context.context.bin_desc.start_addr =
+				(uint8_t *)adev->psp.xgmi_context.context.bin_desc.start_addr +
 				le32_to_cpu(ta_hdr->ras.offset_bytes);
 		}
 		break;
@@ -186,16 +192,24 @@ static int psp_v11_0_init_microcode(struct psp_context *psp)
 				goto out2;
 
 			ta_hdr = (const struct ta_firmware_header_v1_0 *)adev->psp.ta_fw->data;
-			adev->psp.hdcp.feature_version = le32_to_cpu(ta_hdr->hdcp.fw_version);
-			adev->psp.hdcp.size_bytes = le32_to_cpu(ta_hdr->hdcp.size_bytes);
-			adev->psp.hdcp.start_addr = (uint8_t *)ta_hdr +
-				le32_to_cpu(ta_hdr->header.ucode_array_offset_bytes);
+			adev->psp.hdcp_context.context.bin_desc.feature_version =
+				le32_to_cpu(ta_hdr->hdcp.fw_version);
+			adev->psp.hdcp_context.context.bin_desc.size_bytes =
+				le32_to_cpu(ta_hdr->hdcp.size_bytes);
+			adev->psp.hdcp_context.context.bin_desc.start_addr =
+				(uint8_t *)ta_hdr +
+				le32_to_cpu(
+					ta_hdr->header.ucode_array_offset_bytes);
 
 			adev->psp.ta_fw_version = le32_to_cpu(ta_hdr->header.ucode_version);
 
-			adev->psp.dtm.feature_version = le32_to_cpu(ta_hdr->dtm.fw_version);
-			adev->psp.dtm.size_bytes = le32_to_cpu(ta_hdr->dtm.size_bytes);
-			adev->psp.dtm.start_addr = (uint8_t *)adev->psp.hdcp.start_addr +
+			adev->psp.dtm_context.context.bin_desc.feature_version =
+				le32_to_cpu(ta_hdr->dtm.fw_version);
+			adev->psp.dtm_context.context.bin_desc.size_bytes =
+				le32_to_cpu(ta_hdr->dtm.size_bytes);
+			adev->psp.dtm_context.context.bin_desc.start_addr =
+				(uint8_t *)adev->psp.hdcp_context.context
+					.bin_desc.start_addr +
 				le32_to_cpu(ta_hdr->dtm.offset_bytes);
 		}
 		break;
diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v12_0.c b/drivers/gpu/drm/amd/amdgpu/psp_v12_0.c
index cc649406234ba7..281bc4d7f0a1aa 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v12_0.c
@@ -84,22 +84,22 @@ static int psp_v12_0_init_microcode(struct psp_context *psp)
 
 		ta_hdr = (const struct ta_firmware_header_v1_0 *)
 				 adev->psp.ta_fw->data;
-		adev->psp.hdcp.feature_version =
+		adev->psp.hdcp_context.context.bin_desc.feature_version =
 			le32_to_cpu(ta_hdr->hdcp.fw_version);
-		adev->psp.hdcp.size_bytes =
+		adev->psp.hdcp_context.context.bin_desc.size_bytes =
 			le32_to_cpu(ta_hdr->hdcp.size_bytes);
-		adev->psp.hdcp.start_addr =
+		adev->psp.hdcp_context.context.bin_desc.start_addr =
 			(uint8_t *)ta_hdr +
 			le32_to_cpu(ta_hdr->header.ucode_array_offset_bytes);
 
 		adev->psp.ta_fw_version = le32_to_cpu(ta_hdr->header.ucode_version);
 
-		adev->psp.dtm.feature_version =
+		adev->psp.dtm_context.context.bin_desc.feature_version =
 			le32_to_cpu(ta_hdr->dtm.fw_version);
-		adev->psp.dtm.size_bytes =
+		adev->psp.dtm_context.context.bin_desc.size_bytes =
 			le32_to_cpu(ta_hdr->dtm.size_bytes);
-		adev->psp.dtm.start_addr =
-			(uint8_t *)adev->psp.hdcp.start_addr +
+		adev->psp.dtm_context.context.bin_desc.start_addr =
+			(uint8_t *)adev->psp.hdcp_context.context.bin_desc.start_addr +
 			le32_to_cpu(ta_hdr->dtm.offset_bytes);
 	}
 
-- 
2.17.1

