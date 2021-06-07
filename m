Return-Path: <SRS0=JNIh=LB=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A9B3C47094
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Jun 2021 16:49:15 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA42260FDA
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Jun 2021 16:49:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA42260FDA
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AB94A6E943;
	Mon,  7 Jun 2021 16:49:14 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam08on2076.outbound.protection.outlook.com [40.107.101.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 826106E942
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Jun 2021 16:49:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I/RycVV6JAexodgwhIJMtyQljmz+scwQ1dnLYeCmVT1qDjnKV40UbJt4V3K54KLYFvDufs5Y2y0Tr9KVcNN3fF1AsfrJ0Tgw1kAPTzWLbsWTF6RYjrmVisato/JvdAgQcU1btmDFon5qKy3IfYQ99uIk1rBTz29CZWjoh5nsRlZBDQyd+YU3zJ2NseicKuPBV1hTo7+4kYyaElIWRMVcEZJl6Udk+AJrpyA/xj0q4pDnNK1rPx7ulEF7PrCy3AeEt8bK8Zj6rXlrSC5YjcFQ3g4T2EDAcbxIN/XREvGeee6Lh0jRQmXj6FM5ODHSJrMFykxe2GZ0abfG4Zs2GahJ5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VCTX8sZiHZwund09LnJulw21sy3mmfaIkuwP4KV97cg=;
 b=gee+rG7a88Vs9VSTIAK8ePSwL7N7eGhg3OPvO2YaZauLPMTkfq7DNIY+VE72Q9mSwLq5mEAC/WkhXKQ3BwU+FYc0Dd4lsgzDJmBko548JC19UIAN5zqzNz4uTKH7zHvRZ3bMpphkuG/VCPHxJ8BJYcwKK1EatbVZfyG79lu7FWqEMW5X4QcDacLrCgXdPGAg5/X6w0n1wdf7v4m8s3pt0yPFAEGx0Bco26faZt3S9eSRWISX6o99d5xwrcQ39X31G/eqy4EJy7Jc/dCkkjviTeP0RAtvkwi0ax3O2Hjy7yH7WGIl7GYdKVtkhKtgNZYP+Qfcii8UTpayhHizTMsszw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VCTX8sZiHZwund09LnJulw21sy3mmfaIkuwP4KV97cg=;
 b=Zq0HRgNlzvcxaCKea9WOCWbMb71a5OGPOsfpB52U+I+t8YcDKSNA2vfG4p8eQHBWHsbfx4pxtUCnzsqsnTEE0JwtkBbbDXypIuXmMP551FMOs/fwilS1CV5ga6gFrkb4bEs5rCMNeLZZ2a0Ly/diWD32OuaLbitscEUN65QCemg=
Received: from BN9PR03CA0065.namprd03.prod.outlook.com (2603:10b6:408:fc::10)
 by MN2PR12MB2925.namprd12.prod.outlook.com (2603:10b6:208:ad::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.24; Mon, 7 Jun
 2021 16:49:10 +0000
Received: from BN8NAM11FT047.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:fc:cafe::ae) by BN9PR03CA0065.outlook.office365.com
 (2603:10b6:408:fc::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.15 via Frontend
 Transport; Mon, 7 Jun 2021 16:49:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT047.mail.protection.outlook.com (10.13.177.220) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4195.22 via Frontend Transport; Mon, 7 Jun 2021 16:49:10 +0000
Received: from stylon-rog.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Mon, 7 Jun 2021
 11:49:03 -0500
From: Stylon Wang <stylon.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 24/30] drm/amd/display: Add debugfs entry for dsc passthrough
Date: Tue, 8 Jun 2021 00:47:08 +0800
Message-ID: <20210607164714.311325-25-stylon.wang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210607164714.311325-1-stylon.wang@amd.com>
References: <20210607164714.311325-1-stylon.wang@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7126d526-2bb3-4893-c06d-08d929d42c2f
X-MS-TrafficTypeDiagnostic: MN2PR12MB2925:
X-Microsoft-Antispam-PRVS: <MN2PR12MB29256241ABA779AA3BE886EDFF389@MN2PR12MB2925.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Na8rBBF+0pUbtjz5szv3ayC6LoixTbtiket2hvNkej7IN4vD76GH71Y2R4hLTMCyEwp295Yh0iVqvKnQILWo0kMPvclJsrfLytvI5gqgEltj9yUtH+JfAcKfK9+1Sae4m3/Z57EdXz8jBq+edIzMUQ0uIxWmrXRLjws2xcoUY+HadK799olHKCTqVx5fMAsyCY/AjOZomirmqfNv4P5ui1iKSyKoj42LfGic4y0o1MzI8v2qJrrjT17pMSLXtYTKp9d8XCyF3qIk1CfGKSG9YaGtGZsd8Z1PHJtkCoVxkO/W/q66tpiypGyHeYo5Ro7WJlhgU1/vhooBnHtzij0/DBmAKqScqoBiGwoSLIgI/PgHuA6fdx6vEjxTFKGYQx4+Bd29C0L8Ar77wGhGkfTrDbA2S3XzQNyljnvHLz04z0f15P+9dLB/N4zZzoMiOxeulFBr1SZvl9sUcUDtAbFM6buRLxfi3S6sZ7aMWCXO6lwQz+rifeL9vCPFqAxxGqtVgugEY8Hz6GMWjJB6QzhL0od37T/4zq1pu0VjETfe+3x4EUSFyTnkdLq/lLaNNakZ4XWcZF61xKS/5IxGyxC30ykYygFh/LAURasmEJdDZ6tY9qHE8tV7lIm5zb3vrlRoy665HVgR2Oa5S47d0CPsacxIySTSbuuySluoLV0CHeIglujq9vsrZqHwP1p6YUgm
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(346002)(376002)(396003)(136003)(39860400002)(36840700001)(46966006)(356005)(426003)(81166007)(83380400001)(82740400003)(5660300002)(36756003)(86362001)(336012)(36860700001)(47076005)(82310400003)(186003)(7696005)(2616005)(70206006)(6916009)(70586007)(316002)(44832011)(26005)(54906003)(8936002)(8676002)(1076003)(16526019)(478600001)(2906002)(4326008)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2021 16:49:10.0344 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7126d526-2bb3-4893-c06d-08d929d42c2f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT047.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB2925
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
Cc: Stylon Wang <stylon.wang@amd.com>, Eryk.Brol@amd.com, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 Anson.Jacob@amd.com, Fangzhi Zuo <Jerry.Zuo@amd.com>, Aurabindo.Pillai@amd.com,
 Hersen Wu <hersenxs.wu@amd.com>, Bhawanpreet.Lakha@amd.com, bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Fangzhi Zuo <Jerry.Zuo@amd.com>

[Why & How]
Add debugfs entry to force dsc decoding at PCON when DSC capable
external RX is connected. In such case, it is free to test DSC
decoding at external RX or at PCON.

Signed-off-by: Fangzhi Zuo <Jerry.Zuo@amd.com>
Reviewed-by: Hersen Wu <hersenxs.wu@amd.com>
Acked-by: Stylon Wang <stylon.wang@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |  1 +
 .../amd/display/amdgpu_dm/amdgpu_dm_debugfs.c | 50 ++++++++++++++++++-
 2 files changed, 50 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
index 7d39dfa7103b..fbec1a52e500 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
@@ -456,6 +456,7 @@ struct dsc_preferred_settings {
 	uint32_t dsc_num_slices_v;
 	uint32_t dsc_num_slices_h;
 	uint32_t dsc_bits_per_pixel;
+	bool dsc_force_disable_passthrough;
 };
 
 struct amdgpu_dm_connector {
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
index 9fbbd0159119..f1145086a468 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
@@ -887,6 +887,47 @@ static int output_bpc_show(struct seq_file *m, void *data)
 	return res;
 }
 
+/*
+ * Example usage:
+ * Disable dsc passthrough, i.e.,: have dsc decoding at converver, not external RX
+ *   echo 1 /sys/kernel/debug/dri/0/DP-1/dsc_disable_passthrough
+ * Enable dsc passthrough, i.e.,: have dsc passthrough to external RX
+ *   echo 0 /sys/kernel/debug/dri/0/DP-1/dsc_disable_passthrough
+ */
+static ssize_t dp_dsc_passthrough_set(struct file *f, const char __user *buf,
+				 size_t size, loff_t *pos)
+{
+	struct amdgpu_dm_connector *aconnector = file_inode(f)->i_private;
+	char *wr_buf = NULL;
+	uint32_t wr_buf_size = 42;
+	int max_param_num = 1;
+	long param;
+	uint8_t param_nums = 0;
+
+	if (size == 0)
+		return -EINVAL;
+
+	wr_buf = kcalloc(wr_buf_size, sizeof(char), GFP_KERNEL);
+
+	if (!wr_buf) {
+		DRM_DEBUG_DRIVER("no memory to allocate write buffer\n");
+		return -ENOSPC;
+	}
+
+	if (parse_write_buffer_into_params(wr_buf, size,
+					   &param, buf,
+					   max_param_num,
+					   &param_nums)) {
+		kfree(wr_buf);
+		return -EINVAL;
+	}
+
+	aconnector->dsc_settings.dsc_force_disable_passthrough = param;
+
+	kfree(wr_buf);
+	return 0;
+}
+
 #ifdef CONFIG_DRM_AMD_DC_HDCP
 /*
  * Returns the HDCP capability of the Display (1.4 for now).
@@ -2535,6 +2576,12 @@ static const struct file_operations dp_max_bpc_debugfs_fops = {
 	.llseek = default_llseek
 };
 
+static const struct file_operations dp_dsc_disable_passthrough_debugfs_fops = {
+	.owner = THIS_MODULE,
+	.write = dp_dsc_passthrough_set,
+	.llseek = default_llseek
+};
+
 static const struct {
 	char *name;
 	const struct file_operations *fops;
@@ -2559,7 +2606,8 @@ static const struct {
 		{"dsc_chunk_size", &dp_dsc_chunk_size_debugfs_fops},
 		{"dsc_slice_bpg", &dp_dsc_slice_bpg_offset_debugfs_fops},
 		{"dp_dsc_fec_support", &dp_dsc_fec_support_fops},
-		{"max_bpc", &dp_max_bpc_debugfs_fops}
+		{"max_bpc", &dp_max_bpc_debugfs_fops},
+		{"dsc_disable_passthrough", &dp_dsc_disable_passthrough_debugfs_fops},
 };
 
 #ifdef CONFIG_DRM_AMD_DC_HDCP
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
