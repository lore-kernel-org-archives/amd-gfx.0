Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9117CD98D2
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Jun 2026 05:28:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5913E10E819;
	Tue, 16 Jun 2026 05:28:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="19N3Pemd";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010071.outbound.protection.outlook.com [52.101.56.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AA06110E819
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Jun 2026 05:28:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Dz31sU30+GezhkC6oT4E+glj5/W6fViCFq9QcvFcWGJohE28kp1Mo3V4fZc0uLtWL+goEeV1EtOLmpNejBY4A/86USiKS/4u4vIdhsl1MHsKfTu18yjE+XAliiaJOZFwEchBflOiNQXX+ocF76GpRb4g749N/zC489YLqiTo/WoVyhQAwyExmSJGChKf7ky/gYfdy+ky8mEAFQfpHkToquu0hxTQLO/Cyze2shDyYDSqEPMVZm9HHM7rcdiehsPo+B/Y5NygrkSBdsbTc84qB2+rlGDhLf6/zAt01wf50xMbGLIKba1nwgulv2x+xEI9RcMSq5+NqQVoUr9X27/nEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=90HFi4hfxL4qHRWl/hIEXcGbQgkXaDtqtyMz0xJ+Mgg=;
 b=bMX/BGguaapchokZozqbW5aFA1Ouvp1wzDZTOyMSKkd5mKj+SE0Fi4YfpbLybxh35Y8tsYSIpLQASimf81abo8aS0dru303/FE9NfAVucFUtgBdAM0KyOqllZGzjRzpt2ew0rR9WoMOBhIbOOR+2nUZS41TKQCWZlMJau9ne8PHBTo3idiwv5aPau4bJ07EiTnOeU/TV4DRCTT7NBqwkpzh33m9p4eYaxkvJk5gh795OSpYT+Ya8xLOFecfclDTs8Sz6Wc3uq3lCBQvZ7nn2DHovXe/PURRHp9SVJlF21UmhuLNM7IB36oaQfyANndmxOogxS06eydLebXqCqvGmCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=90HFi4hfxL4qHRWl/hIEXcGbQgkXaDtqtyMz0xJ+Mgg=;
 b=19N3Pemd0RiCsMtafJMWmkUujGYEesR+DSMYYzJUu63RjFT7DCKElBxs1MFO/YBm2eHLpvBscewKITUb9kDQImd53tOmkpveF7iM8QD0p43wxUYhZPgWN+x0S+PhIKyd0gQ+zBaZvsFM2b3Aanww3utAFNMwRvkCixYienkjOoQ=
Received: from DS1PR04CA0024.namprd04.prod.outlook.com (2603:10b6:8:243::18)
 by MW4PR12MB7167.namprd12.prod.outlook.com (2603:10b6:303:225::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Tue, 16 Jun
 2026 05:28:28 +0000
Received: from DS1PEPF00017093.namprd03.prod.outlook.com
 (2603:10b6:8:243:cafe::1e) by DS1PR04CA0024.outlook.office365.com
 (2603:10b6:8:243::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.18 via Frontend Transport; Tue,
 16 Jun 2026 05:28:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS1PEPF00017093.mail.protection.outlook.com (10.167.17.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.8 via Frontend Transport; Tue, 16 Jun 2026 05:28:28 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 16 Jun
 2026 00:28:26 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <Asad.Kamal@amd.com>, <candice.li@amd.com>
Subject: [PATCH] drm/amdgpu: bounds check ATOM IIO table parsing
Date: Tue, 16 Jun 2026 10:58:08 +0530
Message-ID: <20260616052808.354123-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017093:EE_|MW4PR12MB7167:EE_
X-MS-Office365-Filtering-Correlation-Id: b2a08ff8-db88-4a1c-cb8e-08decb681894
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|23010399003|1800799024|82310400026|56012099006|11063799006|6133799003|18002099003;
X-Microsoft-Antispam-Message-Info: tvAP/dXnO32yAdCp+xGIp7NiscpxlwYMDX8Jyi5lVEKxXf2Ek4Xqw6i9h9/6GFXnPao685C2gd+GETY+xekufPmHbD89ajR3U2ar0++Gj7dqUkD/bTIBq31XK++iZ9wg78Bn8Dyg1HPhhRVIXBa8viXv/jt7Ldv81ryp4m/erG5z4/vsuKjN4xngecWvdUDoHL+h0w2QDWBJHANU/ZnUEoRTWuLWmdHvA8BeIKtmjkoni0HGaXlLPUx12z3wypiPcAc6vb4RrF0j6VtA1AQH0SRef1ArHVqaZiZXMs3sJjLz+YRNWBhMdMaDHMptkToGjYQE5IaxEVjYHcLnINEXxJ9svjxgLr48FkM1Kyj2dbDF/uQc3piycoweeT8XfMjABcyulVbyGPXIpVQ2U6s+JrmoH2iI86ykLrraqdqUMSCTCXHwAyay4usPHNDMRHj3Lem6FlySoHE31Yxk1ug/mQ9Z3t0wljEw5FyhTkRLZjTwQu/xpcftRqcSntCSuTr1DrfCPF8OyfQfp7Sm6D5i5AGH6WmgsiN2q3z7OmctMIELvyOPzttgy2FWe181qgF8m47mLo3TKxJawm+2sCl7yyNZa8peTK9Nb0UUGDUTfMkjNcoeRiPqxfu96hgro+7ak7NRUVwxdUx1INyhnOI6WWRRNXiHufA9eRhxFsH4+wVQObADARvvbPs/OUI7hVoXREL7tLNfAZmYnj9yAMKpc3YFX2Hz2ROS2M9J0lSofzk=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(23010399003)(1800799024)(82310400026)(56012099006)(11063799006)(6133799003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: HIJ93INdLPecm7PO/wx2qX4ophJSb6YJozjyL2+J+owTn5sFq6Fu2EJEXRpeZYkOM6DlR8Y84NrLTjR79KeLMah6EJK9O6/2L1bIDASC0EziHDO92WKb8nthRikXPlk0CbVOfNVKiFm3b34EJBJC1N7nVYB6Ut36JEEpbTvDnUTeKj1PBNPQcbkIcvrNs90ELCoi7u8zCHM8dq8CvIttKH7ezwRgbJ/RL5FvnA0n+qsICjh6aDxYAQAi7rA5mnKnLY9kbaWOuAiDVwDsCkkwc28qon8dka9Yp6Nl3iT6GvUHiS6nSAg1sBZXmeONVcQMRmvZAZwa6ofPYSlFpMdcd30xsPOFdOtw58RAGSSVFrU6uvyyLCUs3HIszm+sUDrTzBj6dJH5kpUcorfC5yxmPOQEbkxrZtZl9JYev3xz8aPfDbpFWqMF/LJTB/5Z2qoQ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2026 05:28:28.1821 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b2a08ff8-db88-4a1c-cb8e-08decb681894
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017093.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7167
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

atom_index_iio() parsed the IIO bytecode without bounds checks, allowing
out-of-bounds reads on a malformed VBIOS. Pass the BIOS size into
amdgpu_atom_parse() and bound the parse loops by it.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Assisted-by: Claude Code
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c |  2 +-
 drivers/gpu/drm/amd/amdgpu/atom.c            | 21 +++++++++++++++-----
 drivers/gpu/drm/amd/amdgpu/atom.h            |  3 ++-
 3 files changed, 19 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c
index ca65e6ebdb25..a0c740bce310 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c
@@ -1923,7 +1923,7 @@ int amdgpu_atombios_init(struct amdgpu_device *adev)
 	atom_card_info->pll_read = cail_pll_read;
 	atom_card_info->pll_write = cail_pll_write;
 
-	adev->mode_info.atom_context = amdgpu_atom_parse(atom_card_info, adev->bios);
+	adev->mode_info.atom_context = amdgpu_atom_parse(atom_card_info, adev->bios, adev->bios_size);
 	if (!adev->mode_info.atom_context) {
 		amdgpu_atombios_fini(adev);
 		return -ENOMEM;
diff --git a/drivers/gpu/drm/amd/amdgpu/atom.c b/drivers/gpu/drm/amd/amdgpu/atom.c
index a40ce7555f28..941941cc1759 100644
--- a/drivers/gpu/drm/amd/amdgpu/atom.c
+++ b/drivers/gpu/drm/amd/amdgpu/atom.c
@@ -1327,11 +1327,21 @@ static void atom_index_iio(struct atom_context *ctx, int base)
 	ctx->iio = kzalloc(2 * 256, GFP_KERNEL);
 	if (!ctx->iio)
 		return;
-	while (CU8(base) == ATOM_IIO_START) {
-		ctx->iio[CU8(base + 1)] = base + 2;
+	while (base + 1 < ctx->bios_size && CU8(base) == ATOM_IIO_START) {
+		uint8_t index = CU8(base + 1);
+
+		ctx->iio[index] = base + 2;
 		base += 2;
-		while (CU8(base) != ATOM_IIO_END)
-			base += atom_iio_len[CU8(base)];
+		while (base < ctx->bios_size && CU8(base) != ATOM_IIO_END) {
+			uint8_t op = CU8(base);
+
+			if (op >= ARRAY_SIZE(atom_iio_len)) {
+				/* Malformed table: mark method undefined */
+				ctx->iio[index] = 0;
+				return;
+			}
+			base += atom_iio_len[op];
+		}
 		base += 3;
 	}
 }
@@ -1553,7 +1563,7 @@ static inline void atom_print_vbios_info(struct atom_context *ctx)
 		drm_info(ctx->card->dev, "ATOM BIOS: %s\n", vbios_info);
 }
 
-struct atom_context *amdgpu_atom_parse(struct card_info *card, void *bios)
+struct atom_context *amdgpu_atom_parse(struct card_info *card, void *bios, uint32_t bios_size)
 {
 	int base;
 	struct atom_context *ctx =
@@ -1567,6 +1577,7 @@ struct atom_context *amdgpu_atom_parse(struct card_info *card, void *bios)
 
 	ctx->card = card;
 	ctx->bios = bios;
+	ctx->bios_size = bios_size;
 
 	if (CU16(0) != ATOM_BIOS_MAGIC) {
 		pr_info("Invalid BIOS magic\n");
diff --git a/drivers/gpu/drm/amd/amdgpu/atom.h b/drivers/gpu/drm/amd/amdgpu/atom.h
index bb3d9eb7eb6b..4687c019cbe3 100644
--- a/drivers/gpu/drm/amd/amdgpu/atom.h
+++ b/drivers/gpu/drm/amd/amdgpu/atom.h
@@ -133,6 +133,7 @@ struct atom_context {
 	struct card_info *card;
 	struct mutex mutex;
 	void *bios;
+	uint32_t bios_size;
 	uint32_t cmd_table, data_table;
 	uint16_t *iio;
 
@@ -160,7 +161,7 @@ struct atom_context {
 
 extern int amdgpu_atom_debug;
 
-struct atom_context *amdgpu_atom_parse(struct card_info *card, void *bios);
+struct atom_context *amdgpu_atom_parse(struct card_info *card, void *bios, uint32_t bios_size);
 int amdgpu_atom_execute_table(struct atom_context *ctx, int index, uint32_t *params, int params_size);
 int amdgpu_atom_asic_init(struct atom_context *ctx);
 void amdgpu_atom_destroy(struct atom_context *ctx);
-- 
2.49.0

