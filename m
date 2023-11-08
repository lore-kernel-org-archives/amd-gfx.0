Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72E13C4167D
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Nov 2023 12:58:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 02E0110E72E;
	Wed,  8 Nov 2023 12:58:09 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2043.outbound.protection.outlook.com [40.107.237.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5BA9B10E72E
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Nov 2023 12:58:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h4K4H9YlDUOWNzoK6vtp/wPY8QUunTEYs0Ydh9fx9SroxPDLcSTJxLFa9y7JFmOIAcVPoZPkp15kBX8PvXT2RGaxdvh7Ej4kLWk3/tn4UlEWMMQwBusSVJYnftDz8vNJEVsGgPJr1pBWd3ODKml0EODN+KX/9sYAxu3gfMfeZa9sN6thQagoStDtGUoNbEaN68HGM19lhNHiPdV+eJE+UGYQoxpJ7PKjLgBp3ztlWjmL5wb6CCDHmYmRianqxreOjkessR4oECIPzYCOMBJpdBhip4+6se0epugJFHz2cKGhN2ibqRwAX14qXa3Ui6TPyodM7E6PEm1sZqyHthUwew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d9CVvXGOaUgHvWC7fqwwp6xY7NNCwcFvURfNV5VtK4o=;
 b=K5UrR1JMFTmJapbGYg7QuhCMZkjAvzz3gLqLYis747OZ65KbKOykbjGIAYAelipyg6ISDWx3//VyuQzRjl2RA5J+cJU9MZn1W4l4qdrPNpmmkbE+spG03P3FMMSzbVCzALjz2+5qHkAv09gIqbIQF81vu3Dat692j41UC5zO3cUl0f58mpKKOHxW/EZS8RDgfM8gKMZjr/PRwgZgfLZtK551fODw8Qvc4T7bxEm7PsflIRNkcYLXyMRvuBFe4EKH2fRMxKzyLryoXAk1HohWg586kCz2Y/2jfw+Xv0wrQhuRhacyoGFZVuKGYzLKH8fkHQSmw7my7P3bpNCRWLYAbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d9CVvXGOaUgHvWC7fqwwp6xY7NNCwcFvURfNV5VtK4o=;
 b=z43jxKSolXNjMH5U0VVQyQT3h/DzyLilyztoEOdw1IS/Z8YasUXCYO6+LsiX350gEMyy/YIihvqUAxuXYIeRUVgYekjlFaez7VUEBkqMSzexIXy9gpwSadMkEVLya9UMeTofRsI1JngkqRs8HVR59A2Sp3wEgBmIObXzPQoFAMs=
Received: from SN4PR0501CA0126.namprd05.prod.outlook.com
 (2603:10b6:803:42::43) by DM4PR12MB6447.namprd12.prod.outlook.com
 (2603:10b6:8:bf::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.19; Wed, 8 Nov
 2023 12:58:04 +0000
Received: from SN1PEPF000252A2.namprd05.prod.outlook.com
 (2603:10b6:803:42:cafe::6d) by SN4PR0501CA0126.outlook.office365.com
 (2603:10b6:803:42::43) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.18 via Frontend
 Transport; Wed, 8 Nov 2023 12:58:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000252A2.mail.protection.outlook.com (10.167.242.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6977.16 via Frontend Transport; Wed, 8 Nov 2023 12:58:04 +0000
Received: from kevin-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Wed, 8 Nov
 2023 06:57:59 -0600
From: Yang Wang <kevinyang.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/7] drm/amdgpu: refine smu v13.0.6 mca dump driver
Date: Wed, 8 Nov 2023 20:57:30 +0800
Message-ID: <20231108125735.2497856-2-kevinyang.wang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231108125735.2497856-1-kevinyang.wang@amd.com>
References: <20231108125735.2497856-1-kevinyang.wang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A2:EE_|DM4PR12MB6447:EE_
X-MS-Office365-Filtering-Correlation-Id: 3bc5907b-8a6f-4675-4887-08dbe05a58a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: p4ryw9d1bokmFBOmfKEHLEP/uJPhfqFZGdp67LkRU+bQGXS56vM6mPTUGRbBbfPw3+U3T0wT3S3RTBlH+RIFySCO91/o7zui3CNSz4IFgvqFQesAClXxabzj2CM/N3gF+D4tlcPgvuO5PbqKgrjzz5W3OS0AGZguOVDF8KSsw0jGZf85vXHiyDOIpEUEMgWq48g+lNVFuhwaKSE77a1iYXNYjcQzYdjcEwnINMk+VcW4zNo+cui+fhXUJxpkihQpBPS4B+EnhHwqrsJkPO6Ai/ezIm7Sr7iMrmi3CZ74PrhQQXR5GfMJjfV4cXNCiLMMI1TqZ5MYI8TWlPrDaqyJDFHe1ZeKxTees1a6PiEbfSNr8jXJYGU5NVxkZQy1zPU+1iJGhUz3N+pXlgAtxEI9N0X1D3Kd7FJ0nw2U5jSGv/1wttJTnOQ7/bFyYDxFlE6O2r/ppidbLxB4oAtfd9an/vugpM/qysJJBnGihhLYatCoFALTZ6Y5c/44LbRNxid4o0Pnz1NIKkLWjy7p/fUDZ24/Eq4UIrSuX/lgKkyiVi3kSt04jxg6UFgrFaQF2tFQ0tar5deNU42f0oC4EFy2T5+W/egI6jvBnD3eeqR+lFJJq1l11S13oko7foJEiGblEuWFfet6C4lFXWM+FYdf1qk18MNRmwkCKoGJts+daA+lKucpA9dWQZMogiyYoR6AOkQ/0Ba0t8/68EVzYNaO0p8CAaSLgTKo8qyAIi9Fv6HfbOjwAuhaEXo9PnKJWk/Df46fEnqcX3TNt+0Jur6ufQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(346002)(39860400002)(136003)(376002)(230922051799003)(64100799003)(451199024)(186009)(82310400011)(1800799009)(36840700001)(46966006)(40470700004)(2906002)(7696005)(478600001)(1076003)(26005)(36756003)(2616005)(16526019)(40460700003)(336012)(40480700001)(4326008)(81166007)(86362001)(356005)(82740400003)(5660300002)(6666004)(83380400001)(36860700001)(426003)(47076005)(70206006)(8676002)(8936002)(30864003)(70586007)(6916009)(41300700001)(54906003)(316002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2023 12:58:04.1624 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bc5907b-8a6f-4675-4887-08dbe05a58a7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000252A2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6447
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
Cc: Yang Wang <kevinyang.wang@amd.com>, hawking.zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

refine smu mca driver to support query ras error from pmfw path.
- correct gfx smu bank hwid (from mp5 to smu bank)
- retire unused callback function in amdgpu_mca_smu_funcs{}
- add new mca_bank_set{} structure to collect mca bank
- move enum mca_reg_idx into amdgpu_mca.h header
- add mca status register field decode macro

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c       | 164 ++++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_mca.h       |  61 +++-
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c  | 276 +++++++-----------
 3 files changed, 319 insertions(+), 182 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c
index 5a828c175e3a..3302f4a29387 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c
@@ -143,6 +143,46 @@ int amdgpu_mca_mpio_ras_sw_init(struct amdgpu_device *adev)
 	return 0;
 }
 
+void amdgpu_mca_bank_set_init(struct mca_bank_set *mca_set)
+{
+	if (!mca_set)
+		return;
+
+	memset(mca_set, 0, sizeof(*mca_set));
+	INIT_LIST_HEAD(&mca_set->list);
+}
+
+int amdgpu_mca_bank_set_add_entry(struct mca_bank_set *mca_set, struct mca_bank_entry *entry)
+{
+	struct mca_bank_node *node;
+
+	if (!entry)
+		return -EINVAL;
+
+	node = kvzalloc(sizeof(*node), GFP_KERNEL);
+	if (!node)
+		return -ENOMEM;
+
+	memcpy(&node->entry, entry, sizeof(*entry));
+
+	INIT_LIST_HEAD(&node->node);
+	list_add_tail(&node->node, &mca_set->list);
+
+	mca_set->nr_entries++;
+
+	return 0;
+}
+
+void amdgpu_mca_bank_set_release(struct mca_bank_set *mca_set)
+{
+	struct mca_bank_node *node, *tmp;
+
+	list_for_each_entry_safe(node, tmp, &mca_set->list, node) {
+		list_del(&node->node);
+		kvfree(node);
+	}
+}
+
 void amdgpu_mca_smu_init_funcs(struct amdgpu_device *adev, const struct amdgpu_mca_smu_funcs *mca_funcs)
 {
 	struct amdgpu_mca *mca = &adev->mca;
@@ -160,6 +200,58 @@ int amdgpu_mca_smu_set_debug_mode(struct amdgpu_device *adev, bool enable)
 	return -EOPNOTSUPP;
 }
 
+static void amdgpu_mca_smu_mca_bank_dump(struct amdgpu_device *adev, int idx, struct mca_bank_entry *entry)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(entry->regs); i++)
+		dev_dbg(adev->dev, "mca entry[%02d].regs[%02d]=0x%016llx\n", idx, i, entry->regs[i]);
+}
+
+int amdgpu_mca_smu_log_ras_error(struct amdgpu_device *adev, enum amdgpu_ras_block blk, enum amdgpu_mca_error_type type, struct ras_err_data *err_data)
+{
+	struct amdgpu_smuio_mcm_config_info mcm_info;
+	struct mca_bank_set mca_set;
+	struct mca_bank_node *node;
+	struct mca_bank_entry *entry;
+	uint32_t count;
+	int ret, i = 0;
+
+	amdgpu_mca_bank_set_init(&mca_set);
+
+	ret = amdgpu_mca_smu_get_mca_set(adev, blk, type, &mca_set);
+	if (ret)
+		goto out_mca_release;
+
+	list_for_each_entry(node, &mca_set.list, node) {
+		entry = &node->entry;
+
+		amdgpu_mca_smu_mca_bank_dump(adev, i++, entry);
+
+		count = 0;
+		ret = amdgpu_mca_smu_parse_mca_error_count(adev, blk, type, entry, &count);
+		if (ret)
+			goto out_mca_release;
+
+		if (!count)
+			continue;
+
+		mcm_info.socket_id = entry->info.socket_id;
+		mcm_info.die_id = entry->info.aid;
+
+		if (type == AMDGPU_MCA_ERROR_TYPE_UE)
+			amdgpu_ras_error_statistic_ue_count(err_data, &mcm_info, (uint64_t)count);
+		else
+			amdgpu_ras_error_statistic_ce_count(err_data, &mcm_info, (uint64_t)count);
+	}
+
+out_mca_release:
+	amdgpu_mca_bank_set_release(&mca_set);
+
+	return ret;
+}
+
+
 int amdgpu_mca_smu_get_valid_mca_count(struct amdgpu_device *adev, enum amdgpu_mca_error_type type, uint32_t *count)
 {
 	const struct amdgpu_mca_smu_funcs *mca_funcs = adev->mca.mca_funcs;
@@ -173,17 +265,77 @@ int amdgpu_mca_smu_get_valid_mca_count(struct amdgpu_device *adev, enum amdgpu_m
 	return -EOPNOTSUPP;
 }
 
-int amdgpu_mca_smu_get_error_count(struct amdgpu_device *adev, enum amdgpu_ras_block blk,
-				   enum amdgpu_mca_error_type type, uint32_t *count)
+int amdgpu_mca_smu_get_mca_set_error_count(struct amdgpu_device *adev, enum amdgpu_ras_block blk,
+					    enum amdgpu_mca_error_type type, uint32_t *total)
 {
 	const struct amdgpu_mca_smu_funcs *mca_funcs = adev->mca.mca_funcs;
-	if (!count)
+	struct mca_bank_set mca_set;
+	struct mca_bank_node *node;
+	struct mca_bank_entry *entry;
+	uint32_t count;
+	int ret;
+
+	if (!total)
 		return -EINVAL;
 
-	if (mca_funcs && mca_funcs->mca_get_error_count)
-		return mca_funcs->mca_get_error_count(adev, blk, type, count);
+	if (!mca_funcs)
+		return -EOPNOTSUPP;
 
-	return -EOPNOTSUPP;
+	if (!mca_funcs->mca_get_ras_mca_set || !mca_funcs->mca_get_valid_mca_count)
+		return -EOPNOTSUPP;
+
+	amdgpu_mca_bank_set_init(&mca_set);
+
+	ret = mca_funcs->mca_get_ras_mca_set(adev, blk, type, &mca_set);
+	if (ret)
+		goto err_mca_set_release;
+
+	*total = 0;
+	list_for_each_entry(node, &mca_set.list, node) {
+		entry = &node->entry;
+
+		count = 0;
+		ret = mca_funcs->mca_parse_mca_error_count(adev, blk, type, entry, &count);
+		if (ret)
+			goto err_mca_set_release;
+
+		*total += count;
+	}
+
+err_mca_set_release:
+	amdgpu_mca_bank_set_release(&mca_set);
+
+	return ret;
+}
+
+int amdgpu_mca_smu_parse_mca_error_count(struct amdgpu_device *adev, enum amdgpu_ras_block blk,
+					 enum amdgpu_mca_error_type type, struct mca_bank_entry *entry, uint32_t *count)
+{
+	const struct amdgpu_mca_smu_funcs *mca_funcs = adev->mca.mca_funcs;
+	if (!count || !entry)
+		return -EINVAL;
+
+	if (!mca_funcs || !mca_funcs->mca_parse_mca_error_count)
+		return -EOPNOTSUPP;
+
+
+	return mca_funcs->mca_parse_mca_error_count(adev, blk, type, entry, count);
+}
+
+int amdgpu_mca_smu_get_mca_set(struct amdgpu_device *adev, enum amdgpu_ras_block blk,
+			       enum amdgpu_mca_error_type type, struct mca_bank_set *mca_set)
+{
+	const struct amdgpu_mca_smu_funcs *mca_funcs = adev->mca.mca_funcs;
+
+	if (!mca_set)
+		return -EINVAL;
+
+	if (!mca_funcs || !mca_funcs->mca_get_ras_mca_set)
+		return -EOPNOTSUPP;
+
+	WARN_ON(!list_empty(&mca_set->list));
+
+	return mca_funcs->mca_get_ras_mca_set(adev, blk, type, mca_set);
 }
 
 int amdgpu_mca_smu_get_mca_entry(struct amdgpu_device *adev, enum amdgpu_mca_error_type type,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.h
index 28ad463cf5c9..45f90edf2283 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.h
@@ -25,6 +25,27 @@
 
 #define MCA_MAX_REGS_COUNT	(16)
 
+#define MCA_REG_FIELD(x, h, l)			(((x) & GENMASK_ULL(h, l)) >> l)
+#define MCA_REG__STATUS__VAL(x)			MCA_REG_FIELD(x, 63, 63)
+#define MCA_REG__STATUS__OVERFLOW(x)		MCA_REG_FIELD(x, 62, 62)
+#define MCA_REG__STATUS__UC(x)			MCA_REG_FIELD(x, 61, 61)
+#define MCA_REG__STATUS__EN(x)			MCA_REG_FIELD(x, 60, 60)
+#define MCA_REG__STATUS__MISCV(x)		MCA_REG_FIELD(x, 59, 59)
+#define MCA_REG__STATUS__ADDRV(x)		MCA_REG_FIELD(x, 58, 58)
+#define MCA_REG__STATUS__PCC(x)			MCA_REG_FIELD(x, 57, 57)
+#define MCA_REG__STATUS__ERRCOREIDVAL(x)	MCA_REG_FIELD(x, 56, 56)
+#define MCA_REG__STATUS__TCC(x)			MCA_REG_FIELD(x, 55, 55)
+#define MCA_REG__STATUS__SYNDV(x)		MCA_REG_FIELD(x, 53, 53)
+#define MCA_REG__STATUS__CECC(x)		MCA_REG_FIELD(x, 46, 46)
+#define MCA_REG__STATUS__UECC(x)		MCA_REG_FIELD(x, 45, 45)
+#define MCA_REG__STATUS__DEFERRED(x)		MCA_REG_FIELD(x, 44, 44)
+#define MCA_REG__STATUS__POISON(x)		MCA_REG_FIELD(x, 43, 43)
+#define MCA_REG__STATUS__SCRUB(x)		MCA_REG_FIELD(x, 40, 40)
+#define MCA_REG__STATUS__ERRCOREID(x)		MCA_REG_FIELD(x, 37, 32)
+#define MCA_REG__STATUS__ADDRLSB(x)		MCA_REG_FIELD(x, 29, 24)
+#define MCA_REG__STATUS__ERRORCODEEXT(x)	MCA_REG_FIELD(x, 21, 16)
+#define MCA_REG__STATUS__ERRORCODE(x)		MCA_REG_FIELD(x, 15, 0)
+
 enum amdgpu_mca_ip {
 	AMDGPU_MCA_IP_UNKNOW = -1,
 	AMDGPU_MCA_IP_PSP = 0,
@@ -57,6 +78,17 @@ struct amdgpu_mca {
 	const struct amdgpu_mca_smu_funcs *mca_funcs;
 };
 
+enum mca_reg_idx {
+	MCA_REG_IDX_CONTROL		= 0,
+	MCA_REG_IDX_STATUS		= 1,
+	MCA_REG_IDX_ADDR		= 2,
+	MCA_REG_IDX_MISC0		= 3,
+	MCA_REG_IDX_CONFIG		= 4,
+	MCA_REG_IDX_IPID		= 5,
+	MCA_REG_IDX_SYND		= 6,
+	MCA_REG_IDX_COUNT		= 16,
+};
+
 struct mca_bank_info {
 	int socket_id;
 	int aid;
@@ -72,18 +104,28 @@ struct mca_bank_entry {
 	uint64_t regs[MCA_MAX_REGS_COUNT];
 };
 
+struct mca_bank_node {
+	struct mca_bank_entry entry;
+	struct list_head node;
+};
+
+struct mca_bank_set {
+	int nr_entries;
+	struct list_head list;
+};
+
 struct amdgpu_mca_smu_funcs {
 	int max_ue_count;
 	int max_ce_count;
 	int (*mca_set_debug_mode)(struct amdgpu_device *adev, bool enable);
-	int (*mca_get_error_count)(struct amdgpu_device *adev, enum amdgpu_ras_block blk,
-				   enum amdgpu_mca_error_type type, uint32_t *count);
+	int (*mca_get_ras_mca_set)(struct amdgpu_device *adev, enum amdgpu_ras_block blk, enum amdgpu_mca_error_type type,
+				   struct mca_bank_set *mca_set);
+	int (*mca_parse_mca_error_count)(struct amdgpu_device *adev, enum amdgpu_ras_block blk, enum amdgpu_mca_error_type type,
+					 struct mca_bank_entry *entry, uint32_t *count);
 	int (*mca_get_valid_mca_count)(struct amdgpu_device *adev, enum amdgpu_mca_error_type type,
 				       uint32_t *count);
 	int (*mca_get_mca_entry)(struct amdgpu_device *adev, enum amdgpu_mca_error_type type,
 				 int idx, struct mca_bank_entry *entry);
-	int (*mca_get_ras_mca_idx_array)(struct amdgpu_device *adev, enum amdgpu_ras_block blk,
-					 enum amdgpu_mca_error_type type, int *idx_array, int *idx_array_size);
 };
 
 void amdgpu_mca_query_correctable_error_count(struct amdgpu_device *adev,
@@ -107,11 +149,22 @@ int amdgpu_mca_mpio_ras_sw_init(struct amdgpu_device *adev);
 void amdgpu_mca_smu_init_funcs(struct amdgpu_device *adev, const struct amdgpu_mca_smu_funcs *mca_funcs);
 int amdgpu_mca_smu_set_debug_mode(struct amdgpu_device *adev, bool enable);
 int amdgpu_mca_smu_get_valid_mca_count(struct amdgpu_device *adev, enum amdgpu_mca_error_type type, uint32_t *count);
+int amdgpu_mca_smu_get_mca_set_error_count(struct amdgpu_device *adev, enum amdgpu_ras_block blk,
+					   enum amdgpu_mca_error_type type, uint32_t *total);
 int amdgpu_mca_smu_get_error_count(struct amdgpu_device *adev, enum amdgpu_ras_block blk,
 				   enum amdgpu_mca_error_type type, uint32_t *count);
+int amdgpu_mca_smu_parse_mca_error_count(struct amdgpu_device *adev, enum amdgpu_ras_block blk,
+					 enum amdgpu_mca_error_type type, struct mca_bank_entry *entry, uint32_t *count);
+int amdgpu_mca_smu_get_mca_set(struct amdgpu_device *adev, enum amdgpu_ras_block blk,
+			       enum amdgpu_mca_error_type type, struct mca_bank_set *mca_set);
 int amdgpu_mca_smu_get_mca_entry(struct amdgpu_device *adev, enum amdgpu_mca_error_type type,
 				 int idx, struct mca_bank_entry *entry);
 
 void amdgpu_mca_smu_debugfs_init(struct amdgpu_device *adev, struct dentry *root);
 
+void amdgpu_mca_bank_set_init(struct mca_bank_set *mca_set);
+int amdgpu_mca_bank_set_add_entry(struct mca_bank_set *mca_set, struct mca_bank_entry *entry);
+void amdgpu_mca_bank_set_release(struct mca_bank_set *mca_set);
+int amdgpu_mca_smu_log_ras_error(struct amdgpu_device *adev, enum amdgpu_ras_block blk, enum amdgpu_mca_error_type type, struct ras_err_data *err_data);
+
 #endif
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index a7edd3798a6f..5167331e140e 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -100,17 +100,6 @@ MODULE_FIRMWARE("amdgpu/smu_13_0_6.bin");
 #define MCA_BANK_IPID(_ip, _hwid, _type) \
 	[AMDGPU_MCA_IP_##_ip] = { .hwid = _hwid, .mcatype = _type, }
 
-enum mca_reg_idx {
-	MCA_REG_IDX_CONTROL		= 0,
-	MCA_REG_IDX_STATUS		= 1,
-	MCA_REG_IDX_ADDR		= 2,
-	MCA_REG_IDX_MISC0		= 3,
-	MCA_REG_IDX_CONFIG		= 4,
-	MCA_REG_IDX_IPID		= 5,
-	MCA_REG_IDX_SYND		= 6,
-	MCA_REG_IDX_COUNT		= 16,
-};
-
 struct mca_bank_ipid {
 	enum amdgpu_mca_ip ip;
 	uint16_t hwid;
@@ -123,7 +112,9 @@ struct mca_ras_info {
 	int *err_code_array;
 	int err_code_count;
 	int (*get_err_count)(const struct mca_ras_info *mca_ras, struct amdgpu_device *adev,
-			     enum amdgpu_mca_error_type type, int idx, uint32_t *count);
+			     enum amdgpu_mca_error_type type, struct mca_bank_entry *entry, uint32_t *count);
+	bool (*bank_is_valid)(const struct mca_ras_info *mca_ras, struct amdgpu_device *adev,
+			      enum amdgpu_mca_error_type type, struct mca_bank_entry *entry);
 };
 
 #define P2S_TABLE_ID_A 0x50325341
@@ -2446,48 +2437,34 @@ static int mca_get_mca_entry(struct amdgpu_device *adev, enum amdgpu_mca_error_t
 	return 0;
 }
 
-static int mca_decode_mca_ipid(struct amdgpu_device *adev, enum amdgpu_mca_error_type type, int idx, int *ip)
+static int mca_decode_ipid_to_hwip(uint64_t val)
 {
 	const struct mca_bank_ipid *ipid;
-	uint64_t val;
 	uint16_t hwid, mcatype;
-	int i, ret;
-
-	ret = mca_bank_read_reg(adev, type, idx, MCA_REG_IDX_IPID, &val);
-	if (ret)
-		return ret;
+	int i;
 
 	hwid = REG_GET_FIELD(val, MCMP1_IPIDT0, HardwareID);
 	mcatype = REG_GET_FIELD(val, MCMP1_IPIDT0, McaType);
 
-	if (hwid) {
-		for (i = 0; i < ARRAY_SIZE(smu_v13_0_6_mca_ipid_table); i++) {
-			ipid = &smu_v13_0_6_mca_ipid_table[i];
+	for (i = 0; i < ARRAY_SIZE(smu_v13_0_6_mca_ipid_table); i++) {
+		ipid = &smu_v13_0_6_mca_ipid_table[i];
 
-			if (!ipid->hwid)
-				continue;
+		if (!ipid->hwid)
+			continue;
 
-			if (ipid->hwid == hwid && ipid->mcatype == mcatype) {
-				*ip = i;
-				return 0;
-			}
-		}
+		if (ipid->hwid == hwid && ipid->mcatype == mcatype)
+			return i;
 	}
 
-	*ip = AMDGPU_MCA_IP_UNKNOW;
-
-	return 0;
+	return AMDGPU_MCA_IP_UNKNOW;
 }
 
 static int mca_umc_mca_get_err_count(const struct mca_ras_info *mca_ras, struct amdgpu_device *adev,
-					enum amdgpu_mca_error_type type, int idx, uint32_t *count)
+				     enum amdgpu_mca_error_type type, struct mca_bank_entry *entry, uint32_t *count)
 {
 	uint64_t status0;
-	int ret;
 
-	ret = mca_bank_read_reg(adev, type, idx, MCA_REG_IDX_STATUS, &status0);
-	if (ret)
-		return ret;
+	status0 = entry->regs[MCA_REG_IDX_STATUS];
 
 	if (!REG_GET_FIELD(status0, MCMP1_STATUST0, Val)) {
 		*count = 0;
@@ -2518,70 +2495,41 @@ static bool mca_smu_check_error_code(struct amdgpu_device *adev, const struct mc
 	return false;
 }
 
-static int mca_mp5_mca_get_err_count(const struct mca_ras_info *mca_ras, struct amdgpu_device *adev,
-				     enum amdgpu_mca_error_type type, int idx, uint32_t *count)
+static int mca_gfx_mca_get_err_count(const struct mca_ras_info *mca_ras, struct amdgpu_device *adev,
+				     enum amdgpu_mca_error_type type, struct mca_bank_entry *entry, uint32_t *count)
 {
-	uint64_t status0 = 0, misc0 = 0;
-	uint32_t errcode;
-	int ret;
-
-	if (mca_ras->ip != AMDGPU_MCA_IP_MP5)
-		return -EINVAL;
-
-	ret = mca_bank_read_reg(adev, type, idx, MCA_REG_IDX_STATUS, &status0);
-	if (ret)
-		return ret;
+	uint64_t status0, misc0;
 
+	status0 = entry->regs[MCA_REG_IDX_STATUS];
 	if (!REG_GET_FIELD(status0, MCMP1_STATUST0, Val)) {
 		*count = 0;
 		return 0;
 	}
 
-	errcode = REG_GET_FIELD(status0, MCMP1_STATUST0, ErrorCode);
-	if (!mca_smu_check_error_code(adev, mca_ras, errcode))
-		return 0;
-
 	if (type == AMDGPU_MCA_ERROR_TYPE_UE &&
 	    REG_GET_FIELD(status0, MCMP1_STATUST0, UC) == 1 &&
 	    REG_GET_FIELD(status0, MCMP1_STATUST0, PCC) == 1) {
-		if (count)
-			*count = 1;
+		*count = 1;
 		return 0;
-	}
-
-	ret = mca_bank_read_reg(adev, type, idx, MCA_REG_IDX_MISC0, &misc0);
-	if (ret)
-		return ret;
-
-	if (count)
+	} else {
+		misc0 = entry->regs[MCA_REG_IDX_MISC0];
 		*count = REG_GET_FIELD(misc0, MCMP1_MISC0T0, ErrCnt);
+	}
 
 	return 0;
 }
 
 static int mca_smu_mca_get_err_count(const struct mca_ras_info *mca_ras, struct amdgpu_device *adev,
-				     enum amdgpu_mca_error_type type, int idx, uint32_t *count)
+				     enum amdgpu_mca_error_type type, struct mca_bank_entry *entry, uint32_t *count)
 {
-	uint64_t status0 = 0, misc0 = 0;
-	uint32_t errcode;
-	int ret;
-
-	if (mca_ras->ip != AMDGPU_MCA_IP_SMU)
-		return -EINVAL;
-
-	ret = mca_bank_read_reg(adev, type, idx, MCA_REG_IDX_STATUS, &status0);
-	if (ret)
-		return ret;
+	uint64_t status0, misc0;
 
+	status0 = entry->regs[MCA_REG_IDX_STATUS];
 	if (!REG_GET_FIELD(status0, MCMP1_STATUST0, Val)) {
 		*count = 0;
 		return 0;
 	}
 
-	errcode = REG_GET_FIELD(status0, MCMP1_STATUST0, ErrorCode);
-	if (!mca_smu_check_error_code(adev, mca_ras, errcode))
-		return 0;
-
 	if (type == AMDGPU_MCA_ERROR_TYPE_UE &&
 	    REG_GET_FIELD(status0, MCMP1_STATUST0, UC) == 1 &&
 	    REG_GET_FIELD(status0, MCMP1_STATUST0, PCC) == 1) {
@@ -2590,16 +2538,43 @@ static int mca_smu_mca_get_err_count(const struct mca_ras_info *mca_ras, struct
 		return 0;
 	}
 
-	ret = mca_bank_read_reg(adev, type, idx, MCA_REG_IDX_MISC0, &misc0);
-	if (ret)
-		return ret;
-
-	if (count)
-		*count = REG_GET_FIELD(misc0, MCMP1_MISC0T0, ErrCnt);
+	misc0 = entry->regs[MCA_REG_IDX_MISC0];
+	*count = REG_GET_FIELD(misc0, MCMP1_MISC0T0, ErrCnt);
 
 	return 0;
 }
 
+static bool mca_gfx_smu_bank_is_valid(const struct mca_ras_info *mca_ras, struct amdgpu_device *adev,
+				      enum amdgpu_mca_error_type type, struct mca_bank_entry *entry)
+{
+	uint32_t instlo;
+
+	instlo = REG_GET_FIELD(entry->regs[MCA_REG_IDX_IPID], MCMP1_IPIDT0, InstanceIdLo);
+	switch (instlo) {
+	case 0x36430400: /* SMNAID XCD 0 */
+	case 0x38430400: /* SMNAID XCD 1 */
+	case 0x40430400: /* SMNXCD XCD 0, NOTE: FIXME: fix this error later */
+		return true;
+	default:
+		return false;
+	}
+
+	return false;
+};
+
+static bool mca_smu_bank_is_valid(const struct mca_ras_info *mca_ras, struct amdgpu_device *adev,
+				  enum amdgpu_mca_error_type type, struct mca_bank_entry *entry)
+{
+	uint32_t errcode, instlo;
+
+	instlo = REG_GET_FIELD(entry->regs[MCA_REG_IDX_IPID], MCMP1_IPIDT0, InstanceIdLo);
+	if (instlo != 0x03b30400)
+		return false;
+
+	errcode = REG_GET_FIELD(entry->regs[MCA_REG_IDX_STATUS], MCMP1_STATUST0, ErrorCode);
+	return mca_smu_check_error_code(adev, mca_ras, errcode);
+}
+
 static int sdma_err_codes[] = { CODE_SDMA0, CODE_SDMA1, CODE_SDMA2, CODE_SDMA3 };
 static int mmhub_err_codes[] = {
 	CODE_DAGB0, CODE_DAGB0 + 1, CODE_DAGB0 + 2, CODE_DAGB0 + 3, CODE_DAGB0 + 4, /* DAGB0-4 */
@@ -2614,20 +2589,23 @@ static const struct mca_ras_info mca_ras_table[] = {
 		.get_err_count = mca_umc_mca_get_err_count,
 	}, {
 		.blkid = AMDGPU_RAS_BLOCK__GFX,
-		.ip = AMDGPU_MCA_IP_MP5,
-		.get_err_count = mca_mp5_mca_get_err_count,
+		.ip = AMDGPU_MCA_IP_SMU,
+		.get_err_count = mca_gfx_mca_get_err_count,
+		.bank_is_valid = mca_gfx_smu_bank_is_valid,
 	}, {
 		.blkid = AMDGPU_RAS_BLOCK__SDMA,
 		.ip = AMDGPU_MCA_IP_SMU,
 		.err_code_array = sdma_err_codes,
 		.err_code_count = ARRAY_SIZE(sdma_err_codes),
 		.get_err_count = mca_smu_mca_get_err_count,
+		.bank_is_valid = mca_smu_bank_is_valid,
 	}, {
 		.blkid = AMDGPU_RAS_BLOCK__MMHUB,
 		.ip = AMDGPU_MCA_IP_SMU,
 		.err_code_array = mmhub_err_codes,
 		.err_code_count = ARRAY_SIZE(mmhub_err_codes),
 		.get_err_count = mca_smu_mca_get_err_count,
+		.bank_is_valid = mca_smu_bank_is_valid,
 	},
 };
 
@@ -2662,130 +2640,84 @@ static int mca_get_valid_mca_count(struct amdgpu_device *adev, enum amdgpu_mca_e
 }
 
 static bool mca_bank_is_valid(struct amdgpu_device *adev, const struct mca_ras_info *mca_ras,
-			      enum amdgpu_mca_error_type type, int idx)
+			      enum amdgpu_mca_error_type type, struct mca_bank_entry *entry)
 {
-	int ret, ip = AMDGPU_MCA_IP_UNKNOW;
-
-	ret = mca_decode_mca_ipid(adev, type, idx, &ip);
-	if (ret)
+	if (mca_decode_ipid_to_hwip(entry->regs[MCA_REG_IDX_IPID]) != mca_ras->ip)
 		return false;
 
-	if (ip == AMDGPU_MCA_IP_UNKNOW)
-		return false;
+	if (mca_ras->bank_is_valid)
+		return mca_ras->bank_is_valid(mca_ras, adev, type, entry);
 
-	return ip == mca_ras->ip;
-}
-
-static int mca_get_valid_mca_idx(struct amdgpu_device *adev, const struct mca_ras_info *mca_ras,
-				 enum amdgpu_mca_error_type type,
-				 uint32_t mca_cnt, int *idx_array, int idx_array_size)
-{
-	int i, idx_cnt = 0;
-
-	for (i = 0; i < mca_cnt; i++) {
-		if (!mca_bank_is_valid(adev, mca_ras, type, i))
-			continue;
-
-		if (idx_array) {
-			if (idx_cnt < idx_array_size)
-				idx_array[idx_cnt] = i;
-			else
-				return -EINVAL;
-		}
-
-		idx_cnt++;
-	}
-
-	return idx_cnt;
+	return true;
 }
 
-static int __mca_smu_get_error_count(struct amdgpu_device *adev, const struct mca_ras_info *mca_ras, enum amdgpu_mca_error_type type, uint32_t *count)
+static int __mca_smu_get_ras_mca_set(struct amdgpu_device *adev, const struct mca_ras_info *mca_ras,
+				     enum amdgpu_mca_error_type type, struct mca_bank_set *mca_set)
 {
-	uint32_t result, mca_cnt, total = 0;
-	int idx_array[16];
-	int i, ret, idx_cnt = 0;
+	struct mca_bank_entry entry;
+	uint32_t mca_cnt;
+	int i, ret;
 
 	ret = mca_get_valid_mca_count(adev, type, &mca_cnt);
 	if (ret)
 		return ret;
 
 	/* if valid mca bank count is 0, the driver can return 0 directly */
-	if (!mca_cnt) {
-		*count = 0;
+	if (!mca_cnt)
 		return 0;
-	}
 
-	if (!mca_ras->get_err_count)
-		return -EINVAL;
+	for (i = 0; i < mca_cnt; i++) {
+		memset(&entry, 0, sizeof(entry));
+		ret = mca_get_mca_entry(adev, type, i, &entry);
+		if (ret)
+			return ret;
 
-	idx_cnt = mca_get_valid_mca_idx(adev, mca_ras, type, mca_cnt, idx_array, ARRAY_SIZE(idx_array));
-	if (idx_cnt < 0)
-		return -EINVAL;
+		if (mca_ras && !mca_bank_is_valid(adev, mca_ras, type, &entry))
+			continue;
 
-	for (i = 0; i < idx_cnt; i++) {
-		result = 0;
-		ret = mca_ras->get_err_count(mca_ras, adev, type, idx_array[i], &result);
+		ret = amdgpu_mca_bank_set_add_entry(mca_set, &entry);
 		if (ret)
 			return ret;
-
-		total += result;
 	}
 
-	*count = total;
-
 	return 0;
 }
 
-static int mca_smu_get_error_count(struct amdgpu_device *adev, enum amdgpu_ras_block blk,
-				   enum amdgpu_mca_error_type type, uint32_t *count)
+static int mca_smu_get_ras_mca_set(struct amdgpu_device *adev, enum amdgpu_ras_block blk,
+				   enum amdgpu_mca_error_type type, struct mca_bank_set *mca_set)
 {
-	const struct mca_ras_info *mca_ras;
+	const struct mca_ras_info *mca_ras = NULL;
 
-	if (!count)
+	if (!mca_set)
 		return -EINVAL;
 
-	mca_ras = mca_get_mca_ras_info(adev, blk);
-	if (!mca_ras)
-		return -EOPNOTSUPP;
-
-	return __mca_smu_get_error_count(adev, mca_ras, type, count);
-}
-
-static int __mca_smu_get_ras_mca_idx_array(struct amdgpu_device *adev, const struct mca_ras_info *mca_ras,
-					   enum amdgpu_mca_error_type type, int *idx_array, int *idx_array_size)
-{
-	uint32_t mca_cnt = 0;
-	int ret, idx_cnt = 0;
-
-	ret = mca_get_valid_mca_count(adev, type, &mca_cnt);
-	if (ret)
-		return ret;
-
-	/* if valid mca bank count is 0, the driver can return 0 directly */
-	if (!mca_cnt) {
-		*idx_array_size = 0;
-		return 0;
+	if (blk != AMDGPU_RAS_BLOCK_COUNT) {
+		mca_ras = mca_get_mca_ras_info(adev, blk);
+		if (!mca_ras)
+			return -EOPNOTSUPP;
 	}
 
-	idx_cnt = mca_get_valid_mca_idx(adev, mca_ras, type, mca_cnt, idx_array, *idx_array_size);
-	if (idx_cnt < 0)
-		return -EINVAL;
-
-	*idx_array_size = idx_cnt;
-
-	return 0;
+	return __mca_smu_get_ras_mca_set(adev, mca_ras, type, mca_set);
 }
 
-static int mca_smu_get_ras_mca_idx_array(struct amdgpu_device *adev, enum amdgpu_ras_block blk,
-					 enum amdgpu_mca_error_type type, int *idx_array, int *idx_array_size)
+static int mca_smu_parse_mca_error_count(struct amdgpu_device *adev, enum amdgpu_ras_block blk, enum amdgpu_mca_error_type type,
+					 struct mca_bank_entry *entry, uint32_t *count)
 {
 	const struct mca_ras_info *mca_ras;
 
+	if (!entry || !count)
+		return -EINVAL;
+
 	mca_ras = mca_get_mca_ras_info(adev, blk);
 	if (!mca_ras)
 		return -EOPNOTSUPP;
 
-	return __mca_smu_get_ras_mca_idx_array(adev, mca_ras, type, idx_array, idx_array_size);
+	if (!mca_bank_is_valid(adev, mca_ras, type, entry)) {
+		*count = 0;
+		return 0;
+	}
+
+	return mca_ras->get_err_count(mca_ras, adev, type, entry, count);
 }
 
 static int mca_smu_get_mca_entry(struct amdgpu_device *adev,
@@ -2804,10 +2736,10 @@ static const struct amdgpu_mca_smu_funcs smu_v13_0_6_mca_smu_funcs = {
 	.max_ue_count = 12,
 	.max_ce_count = 12,
 	.mca_set_debug_mode = mca_smu_set_debug_mode,
-	.mca_get_error_count = mca_smu_get_error_count,
+	.mca_get_ras_mca_set = mca_smu_get_ras_mca_set,
+	.mca_parse_mca_error_count = mca_smu_parse_mca_error_count,
 	.mca_get_mca_entry = mca_smu_get_mca_entry,
 	.mca_get_valid_mca_count = mca_smu_get_valid_mca_count,
-	.mca_get_ras_mca_idx_array = mca_smu_get_ras_mca_idx_array,
 };
 
 static int smu_v13_0_6_select_xgmi_plpd_policy(struct smu_context *smu,
-- 
2.34.1

