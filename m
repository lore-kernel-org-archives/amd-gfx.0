Return-Path: <SRS0=c7t5=NP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B24FFC4338F
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Aug 2021 00:37:18 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7051961183
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Aug 2021 00:37:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 7051961183
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D4D5D89B5F;
	Tue, 24 Aug 2021 00:37:17 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam08on2084.outbound.protection.outlook.com [40.107.100.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B81FB89B5F
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Aug 2021 00:37:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kgyYNsTgV33YutC6OOxO+LbUEr4gOHKfrocgL0H147yY92cmqXx77yh+ovkJIWgEknn+kDeCNAt9ROTccwqFCdXKuhF8mlCk7I/T++Wm8oK1KKJtcl0LdXXn4AjnCWmUWKkn+Nj8Zo3JeR81TlPfHX17GmpCQtXdugzlE7SGswQW9JVUTQuxZwsEIAj1lVRTCfM9/LKBkGdC54xDKo+m7R1HC+EOl4y6/r5RcIZcyQVRljpm3zBZm2pUPPqKXrgTgV1FfZih4Vs+tQcLJH7rtTExsX+8WNzbF7Wzu5sw6fKT1nNpnZidukymcpQ4kFi5ZsC3oO5gA67CM3BYEjTWdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nF3324RunjhiLvCw5SKj/8IziX2wDpkwzpM6VqoTpCY=;
 b=QOQdTBEyckTmsRaJEeybZ7uTVNASBhLkX5c+h45uK6S9ZeE1/n7oaNiVFEsJf9+7Jb4FO0JfPo+vuyEp8vZj+xnmqXxgKMshrRKxL3BoHOeYET3n9+o/ViuHGNs5Cu1uPMxnNUpB3zVVGl/KQe81o9HEn/PRz40Ng78veUQX/q104v9lxB3Fno1WCfIO600DKaGQQRCcQeZWW4CAoc+YaZemqwl6Klo0xpCEsA8NBD+8tAYo97IHW/hTroV1pTpeJpBHaJfLpFqV0x7mFaFehjBG0V2igPH4xeeKnT1EfRy3wO53B2e40ObalgA6azqE1QPK/hFi5lkJJ8TxLk9Kcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nF3324RunjhiLvCw5SKj/8IziX2wDpkwzpM6VqoTpCY=;
 b=Pn9ks57XitLQ9SyLOBl/7GiNZ5sWxBawKY5RnIAvbBr+ieQYmefHQ6ntbjPF1WmRRPjc7YM4qgp9CEqoC85Gjx9+5NEzfFAoerQv6dVZudtClTeoyEGvPl7LStKB6wmg/B7rQAuY4easKFKgA5BqxcDc9xtNjG+yrwMnFASxnCU=
Received: from BN6PR14CA0040.namprd14.prod.outlook.com (2603:10b6:404:13f::26)
 by BYAPR12MB2821.namprd12.prod.outlook.com (2603:10b6:a03:9b::30)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.24; Tue, 24 Aug
 2021 00:37:12 +0000
Received: from BN8NAM11FT017.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:13f::4) by BN6PR14CA0040.outlook.office365.com
 (2603:10b6:404:13f::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19 via Frontend
 Transport; Tue, 24 Aug 2021 00:37:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT017.mail.protection.outlook.com (10.13.177.93) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4436.19 via Frontend Transport; Tue, 24 Aug 2021 00:37:12 +0000
Received: from w6l.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Mon, 23 Aug
 2021 19:37:11 -0500
From: Sean Keely <Sean.Keely@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Sean Keely <Sean.Keely@amd.com>
Subject: [PATCH v2] drm/amdkfd: Account for SH/SE count when setting up cu
 masks.
Date: Mon, 23 Aug 2021 19:36:58 -0500
Message-ID: <20210824003658.84092-1-Sean.Keely@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4e5a9772-a2c0-441a-1ae7-08d96697502b
X-MS-TrafficTypeDiagnostic: BYAPR12MB2821:
X-Microsoft-Antispam-PRVS: <BYAPR12MB2821BB9FF1F9A5C19D70034C94C59@BYAPR12MB2821.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OtU0TpbxQzgA0O+FOVGzmsfirL+vcuMYCvtZmjJZgX0K8lhwKpy9NcPaEijEYBPLT3x3MfijcjqQ7WC0B6OQcUYgAZaPIV/sI90GeejpG79nJzWGg0igGntzG4brbFlVUQPfxW3UQD7lX7kxMnWZ7qll2KZTta+pp/NxWYbzGydN2MEqlzPlfs/3gRV4OYgmNRhO7NBmrmmBbucWpcHZ2QDTKOkBFe6jeLCNd7XSFmYFBITK7NyJY3Ckf81cRbHvGW8XNnxe1Y+I2iOFOQkBXinexrs+EBuQSWxqofd+qzD+7wd0G0dN+14RNf+WdxzrS+Tg1Ee8+0bh/N6t3/4MI/a57MTAAewnlZ8yNVg0p5PMv9+arQiRUeuQncxp2LHLnBunkqjVSr1XRWsK6XnYMOVk2pir1XgxP8/kQVm37slnhLg7oKWmOSfMm3IlYhD0b2AhPu3Xf7e9OJo+OglSER1T75I/EuMBm1oo7cNm1UK/iyPgVFV32zi5LSB0+A4ozasfaExBAO8Fi5ppDWXl+kR2QrKW7vUOihXzC8HTxqcKWS36JdMH56HOZZ/RHl8xzQSRHHp71WmfieWpjcoSIQSnNS3eTLw8g5lw4pSjjFrrRFuWky5joBHNdEbT9FzMcdKvEEU/1iYPBBm1+xSxuira5e5P+bszdpFwxkq4MrsbzPh/QUXMxN7LS3Fjax83dvx4EqyF8OKZd1xY4FvdrduBU8BKS9eFNsCil+3QXTVOLjeq1PQKVy/n6EroWcxRg3O8wK+SMJ8QeiWc7pdtCg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(396003)(136003)(39860400002)(376002)(346002)(36840700001)(46966006)(70586007)(1076003)(82740400003)(316002)(26005)(36860700001)(2906002)(70206006)(2616005)(5660300002)(8936002)(47076005)(82310400003)(6916009)(86362001)(7696005)(36756003)(336012)(356005)(83380400001)(4326008)(81166007)(478600001)(426003)(16526019)(8676002)(6666004)(34020700004)(186003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2021 00:37:12.0303 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e5a9772-a2c0-441a-1ae7-08d96697502b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT017.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2821
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

On systems with multiple SH per SE compute_static_thread_mgmt_se#
is split into independent masks, one for each SH, in the upper and
lower 16 bits.  We need to detect this and apply cu masking to each
SH.  The cu mask bits are assigned first to each SE, then to
alternate SHs, then finally to higher CU id.  This ensures that
the maximum number of SPIs are engaged as early as possible while
balancing CU assignment to each SH.

v2: Use max SH/SE rather than max SH in cu_per_sh.

Signed-off-by: Sean Keely <Sean.Keely@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c | 79 ++++++++++++++------
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.h |  1 +
 2 files changed, 59 insertions(+), 21 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c
index 88813dad731f..5d7016928d24 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c
@@ -98,36 +98,73 @@ void mqd_symmetrically_map_cu_mask(struct mqd_manager *mm,
 		uint32_t *se_mask)
 {
 	struct kfd_cu_info cu_info;
-	uint32_t cu_per_se[KFD_MAX_NUM_SE] = {0};
-	int i, se, sh, cu = 0;
-
+	uint32_t cu_per_sh[KFD_MAX_NUM_SE][KFD_MAX_NUM_SH_PER_SE] = {0};
+	int i, se, sh, cu;
 	amdgpu_amdkfd_get_cu_info(mm->dev->kgd, &cu_info);
 
 	if (cu_mask_count > cu_info.cu_active_number)
 		cu_mask_count = cu_info.cu_active_number;
 
+	// Exceeding these bounds corrupts the stack and indicates a coding error.
+	// Returning with no CU's enabled will hang the queue, which should be
+	// attention grabbing.
+	if (cu_info.num_shader_engines > KFD_MAX_NUM_SE) {
+		pr_err("Exceeded KFD_MAX_NUM_SE, chip reports %d\n", cu_info.num_shader_engines);
+		return;
+	}
+	if (cu_info.num_shader_arrays_per_engine > KFD_MAX_NUM_SH_PER_SE) {
+		pr_err("Exceeded KFD_MAX_NUM_SH, chip reports %d\n",
+			cu_info.num_shader_arrays_per_engine * cu_info.num_shader_engines);
+		return;
+	}
+
+	/* Count active CUs per SH.
+	 *
+	 * Some CUs in an SH may be disabled.	HW expects disabled CUs to be
+	 * represented in the high bits of each SH's enable mask (the upper and lower
+	 * 16 bits of se_mask) and will take care of the actual distribution of
+	 * disabled CUs within each SH automatically.
+	 * Each half of se_mask must be filled compactly, LSB first.
+	 *
+	 * See note on Arcturus cu_bitmap layout in gfx_v9_0_get_cu_info.
+	 */
 	for (se = 0; se < cu_info.num_shader_engines; se++)
 		for (sh = 0; sh < cu_info.num_shader_arrays_per_engine; sh++)
-			cu_per_se[se] += hweight32(cu_info.cu_bitmap[se % 4][sh + (se / 4)]);
-
-	/* Symmetrically map cu_mask to all SEs:
-	 * cu_mask[0] bit0 -> se_mask[0] bit0;
-	 * cu_mask[0] bit1 -> se_mask[1] bit0;
-	 * ... (if # SE is 4)
-	 * cu_mask[0] bit4 -> se_mask[0] bit1;
+			cu_per_sh[se][sh] = hweight32(cu_info.cu_bitmap[se % 4][sh + (se / 4)]);
+
+	/* Symmetrically map cu_mask to all SEs & SHs:
+	 * se_mask programs up to 2 SH in the upper and lower 16 bits.
+	 *
+	 * Examples
+	 * Assuming 1 SH/SE, 4 SEs:
+	 * cu_mask[0] bit0 -> se_mask[0] bit0
+	 * cu_mask[0] bit1 -> se_mask[1] bit0
+	 * ...
+	 * cu_mask[0] bit4 -> se_mask[0] bit1
+	 * ...
+	 *
+	 * Assuming 2 SH/SE, 4 SEs
+	 * cu_mask[0] bit0 -> se_mask[0] bit0 (SE0,SH0,CU0)
+	 * cu_mask[0] bit1 -> se_mask[1] bit0 (SE1,SH0,CU0)
+	 * ...
+	 * cu_mask[0] bit4 -> se_mask[0] bit16 (SE0,SH1,CU0)
+	 * cu_mask[0] bit5 -> se_mask[1] bit16 (SE1,SH1,CU0)
+	 * ...
+	 * cu_mask[0] bit8 -> se_mask[0] bit1 (SE0,SH0,CU1)
 	 * ...
 	 */
-	se = 0;
-	for (i = 0; i < cu_mask_count; i++) {
-		if (cu_mask[i / 32] & (1 << (i % 32)))
-			se_mask[se] |= 1 << cu;
-
-		do {
-			se++;
-			if (se == cu_info.num_shader_engines) {
-				se = 0;
-				cu++;
+	i = 0;
+	for (cu = 0; cu < 16; cu++) {
+		for (sh = 0; sh < cu_info.num_shader_arrays_per_engine; sh++) {
+			for (se = 0; se < cu_info.num_shader_engines; se++) {
+				if ((cu_mask[i / 32] & (1 << (i % 32))) &&
+					(cu_per_sh[se][sh] > cu)) {
+					se_mask[se] |= 1 << (cu + sh * 16);
+					i++;
+					if (i == cu_mask_count)
+						return;
+				}
 			}
-		} while (cu >= cu_per_se[se] && cu < 32);
+		}
 	}
 }
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.h b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.h
index b5e2ea7550d4..6e6918ccedfd 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.h
@@ -27,6 +27,7 @@
 #include "kfd_priv.h"
 
 #define KFD_MAX_NUM_SE 8
+#define KFD_MAX_NUM_SH_PER_SE 2
 
 /**
  * struct mqd_manager
-- 
2.25.1

