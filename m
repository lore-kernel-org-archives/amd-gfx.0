Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E5D0C4345F
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Apr 2024 09:36:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9D08C112935;
	Mon, 22 Apr 2024 09:36:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="R44wP3Xn";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2053.outbound.protection.outlook.com [40.107.244.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 23624112934
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Apr 2024 09:36:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a2bRF5D8QfF2jbZbR9gXp25zOFEqLesQPrrCir0wxe11HCF4kxOejX6Nak+/nFUeopn86gIZRWDX1zvQeWmadi3Z92XFbw4muz/vRFad51gZdX4wsWmumemzYPpi8T5COmv26RnV/IKfXBpDPTRUFxoXoFgp2LLGu2t5ZNr3aLWhTCzuEfUgXlc5P9iHRk4bSo1wSrrgLKzwwyjFxVUQwkUwJgiREWZijr5LLjLpwH7P5fqDi+an7q5xF9YODQPCo+ZmY6Pkab4r4ypbkkDQntSdt4XCvQzdLtrx/PKLc2zI+6zooPBlk7qyBu6pciAuAcuXK4VoN6hs97LabdFq3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oufA1pDo+ThVR6YixJyiG/ok00ckRB1vYRtdPFnl0yY=;
 b=K3BvVzbo2kFSEZws2DHZSBUI2yC8djGFGY1gJrN8hiBjIkr6+kGw0xAUerDePEL1ufGnVY3UrDKSZUshVWhUBvkLOMbFv4MO7EeizteYDezGycynarVFT+oX3ZANy9tcr+yoTCMg98RPzyAbUXHjqeDua3Mjupjz7NL+0EK9y+Y+tV4ISxZTaX5x7n6jvS7oUobiQJKE3QbPb3xCGXnnAUJ5Qv08wkV1Xkt0eV/37TZtW4qsLEjBd+PoE/DZd1BgysGiXbixuBRdavF01yaJdo+V6zr0A0OWTGfthTZow0kwI7N/YH5v0kTZ+CltzRneG9mnZ7M6o+tAJSwqBk4R8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oufA1pDo+ThVR6YixJyiG/ok00ckRB1vYRtdPFnl0yY=;
 b=R44wP3Xnt4w6d40MbQZeEuIccYwwWFVr8q03fdDdUXjJhiVckhR3zuBhUeWDeq2Sxpk9e8L5O65IykkxYg4nraTPeT5xN2spk+NkDFA/EcMkViOOP3tOVijXUQ6HeZ/JlwHgWVX4XNlUGQj6NUoYhAY03x9UsKR5bD6g2H+taN4=
Received: from SJ0PR05CA0155.namprd05.prod.outlook.com (2603:10b6:a03:339::10)
 by SJ1PR12MB6290.namprd12.prod.outlook.com (2603:10b6:a03:457::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Mon, 22 Apr
 2024 09:36:11 +0000
Received: from CO1PEPF000066EA.namprd05.prod.outlook.com
 (2603:10b6:a03:339:cafe::8) by SJ0PR05CA0155.outlook.office365.com
 (2603:10b6:a03:339::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.20 via Frontend
 Transport; Mon, 22 Apr 2024 09:36:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000066EA.mail.protection.outlook.com (10.167.249.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.19 via Frontend Transport; Mon, 22 Apr 2024 09:36:11 +0000
Received: from kevin-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 22 Apr
 2024 04:36:06 -0500
From: Yang Wang <kevinyang.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <hawking.zhang@amd.com>, <tao.zhou1@amd.com>, <Candice.Li@amd.com>
Subject: [PATCH 1/3] drm/amdgpu: remove unused MCA driver codes
Date: Mon, 22 Apr 2024 17:35:34 +0800
Message-ID: <20240422093536.2689784-1-kevinyang.wang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066EA:EE_|SJ1PR12MB6290:EE_
X-MS-Office365-Filtering-Correlation-Id: 81795dc1-6e20-45f8-4725-08dc62afa569
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?kk82TbkTLMhSek2BNrlIDBOBcGfKw4KlHYmcz2cMmQfF1icz5oc4CZTisb8f?=
 =?us-ascii?Q?tMxbtqIRgd/P5ck6CZ3BBaUrJEdpRKjI9ylGo+3vBeAJga7V2I/wxNx/kCmz?=
 =?us-ascii?Q?fkihLbD0xxNwC/cezjntBvVqURgI03MZL+kCMolVTbZzuZQloh1TtN8Id8Wa?=
 =?us-ascii?Q?LjwkCPDNqB2Jp4EsbC2RMxcK8kPAxkcCvoNzo+WoAtkz1wqPJyMaFeq+gJkj?=
 =?us-ascii?Q?965253/Ot111i2avYShc6HU/ktyGqMrW5bWsqCiNmDfBLJLFroz8gTSwFwJ6?=
 =?us-ascii?Q?wvGemnTgSYQ6fM5qgREho/9ZgaieZ0cxkUU2d1qopOkubZckU+SqokSb/U0h?=
 =?us-ascii?Q?JKG3Ajptw3tAqweA1UH9dwhCHMxtjaKa3KRImddsVi8ZS4arnyJbI+3d3D6N?=
 =?us-ascii?Q?LdxUcYfKjAzcBPF4MnBeGi4GFBLlN+BXfNb5STomEFtZJNjq8pgwS801YSCO?=
 =?us-ascii?Q?BeVR61tN4Rj4F/v1qYWGdOtD3JDdTwjoMa/xlzE/aL8Dtih3YCZW+Yp7JHFW?=
 =?us-ascii?Q?9rOD4n8IJiGDiekcZnF4bDyDbwYJ4vAZuvjGG9PVLpdpJb/vaEsreJeA38JX?=
 =?us-ascii?Q?M22M9w8HJaTVkywPzRvm3UtgRPQ2P0L09A2kuUfpsrb8UU9r+iG+MfA6XEx0?=
 =?us-ascii?Q?m4s/NpQfxHz7GgiKB3yOFU7OA0/7GVlV3cTBGqTqcjJgppmrnD9k9dPiV9Ge?=
 =?us-ascii?Q?l+PmYuuffMeD6TGiq0TMG78T1+rWVa28TNOOrPFbGqWjwsnjTUu6KAQckvLu?=
 =?us-ascii?Q?DXT0vt4koKFczcYCdgijuHi7T4j2DTVY7xtqibPsPlO2AxQ+LNx6e577Qt1w?=
 =?us-ascii?Q?c+GbvWEBeBRDYDCjHSceoC9uyCD69KNCi68z4CkDjhVv1nEKeTFEcuI6Ih5f?=
 =?us-ascii?Q?CXxm4HDxWYezbh7t3eszoLxtnZBBEsNWXwQZvetaD5IaxbC4LFAKSlgOfN7+?=
 =?us-ascii?Q?90jh/67sxV15gU6Eu5AAtXlOZfAInhcN+SEoy2EJqqF3Bj5vT6GqMdwZ2OwP?=
 =?us-ascii?Q?mBjkNFCSy27VPklDtjKiR3JwztvPd1Cv/AuozCFi/ucbE//g9WJ3egDN9A6s?=
 =?us-ascii?Q?YXzUOeeCiwFy+RN/dI0Ld4uFZgJnd474bIIjjC7C1Ok9uriRjUnaM35hoHMg?=
 =?us-ascii?Q?UrBZo3SKa0fiefKoBA+kPuFFIMXFCPyUUm91G3MGx9BHv6Z6Iw4aYUDDKI+s?=
 =?us-ascii?Q?xd5e/NaDJpOex8Q+IssKTt3hKJj6tOsgn/X6UwVIP7axxck1ZYvGDmc8MKv4?=
 =?us-ascii?Q?UhOO/6q2NNCKo8SeH19ZAagbYscFhXZRc9L9UvOVEQUBwt2cLZ6qXO8zZxva?=
 =?us-ascii?Q?GdqVnMkhzmvgYc6RaORNrT5p77JkGiToYGG1MU+fim0UOL3+ftFlO60vYvQG?=
 =?us-ascii?Q?7rsLpi8=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(82310400014)(376005)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2024 09:36:11.2300 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 81795dc1-6e20-45f8-4725-08dc62afa569
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000066EA.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6290
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

- remove unused callback functions.
- make part of mca functions static and refine the function order.

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
Reviewed-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c       | 199 ++++++++----------
 drivers/gpu/drm/amd/amdgpu/amdgpu_mca.h       |  16 --
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c  |  50 -----
 3 files changed, 82 insertions(+), 183 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c
index 0734490347db..67c208861994 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c
@@ -153,7 +153,7 @@ int amdgpu_mca_mpio_ras_sw_init(struct amdgpu_device *adev)
 	return 0;
 }
 
-void amdgpu_mca_bank_set_init(struct mca_bank_set *mca_set)
+static void amdgpu_mca_bank_set_init(struct mca_bank_set *mca_set)
 {
 	if (!mca_set)
 		return;
@@ -162,7 +162,7 @@ void amdgpu_mca_bank_set_init(struct mca_bank_set *mca_set)
 	INIT_LIST_HEAD(&mca_set->list);
 }
 
-int amdgpu_mca_bank_set_add_entry(struct mca_bank_set *mca_set, struct mca_bank_entry *entry)
+static int amdgpu_mca_bank_set_add_entry(struct mca_bank_set *mca_set, struct mca_bank_entry *entry)
 {
 	struct mca_bank_node *node;
 
@@ -183,7 +183,7 @@ int amdgpu_mca_bank_set_add_entry(struct mca_bank_set *mca_set, struct mca_bank_
 	return 0;
 }
 
-void amdgpu_mca_bank_set_release(struct mca_bank_set *mca_set)
+static void amdgpu_mca_bank_set_release(struct mca_bank_set *mca_set)
 {
 	struct mca_bank_node *node, *tmp;
 
@@ -228,6 +228,84 @@ static void amdgpu_mca_smu_mca_bank_dump(struct amdgpu_device *adev, int idx, st
 		      idx, entry->regs[MCA_REG_IDX_SYND]);
 }
 
+static int amdgpu_mca_smu_get_valid_mca_count(struct amdgpu_device *adev, enum amdgpu_mca_error_type type, uint32_t *count)
+{
+	const struct amdgpu_mca_smu_funcs *mca_funcs = adev->mca.mca_funcs;
+
+	if (!count)
+		return -EINVAL;
+
+	if (mca_funcs && mca_funcs->mca_get_valid_mca_count)
+		return mca_funcs->mca_get_valid_mca_count(adev, type, count);
+
+	return -EOPNOTSUPP;
+}
+
+static int amdgpu_mca_smu_get_mca_entry(struct amdgpu_device *adev, enum amdgpu_mca_error_type type,
+					int idx, struct mca_bank_entry *entry)
+{
+	const struct amdgpu_mca_smu_funcs *mca_funcs = adev->mca.mca_funcs;
+	int count;
+
+	if (!mca_funcs || !mca_funcs->mca_get_mca_entry)
+		return -EOPNOTSUPP;
+
+	switch (type) {
+	case AMDGPU_MCA_ERROR_TYPE_UE:
+		count = mca_funcs->max_ue_count;
+		break;
+	case AMDGPU_MCA_ERROR_TYPE_CE:
+		count = mca_funcs->max_ce_count;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	if (idx >= count)
+		return -EINVAL;
+
+	return mca_funcs->mca_get_mca_entry(adev, type, idx, entry);
+}
+
+static int amdgpu_mca_smu_get_mca_set(struct amdgpu_device *adev, enum amdgpu_mca_error_type type, struct mca_bank_set *mca_set)
+{
+	struct mca_bank_entry entry;
+	uint32_t count = 0, i;
+	int ret;
+
+	if (!mca_set)
+		return -EINVAL;
+
+	ret = amdgpu_mca_smu_get_valid_mca_count(adev, type, &count);
+	if (ret)
+		return ret;
+
+	for (i = 0; i < count; i++) {
+		memset(&entry, 0, sizeof(entry));
+		ret = amdgpu_mca_smu_get_mca_entry(adev, type, i, &entry);
+		if (ret)
+			return ret;
+
+		amdgpu_mca_bank_set_add_entry(mca_set, &entry);
+	}
+
+	return 0;
+}
+
+static int amdgpu_mca_smu_parse_mca_error_count(struct amdgpu_device *adev, enum amdgpu_ras_block blk,
+						enum amdgpu_mca_error_type type, struct mca_bank_entry *entry, uint32_t *count)
+{
+	const struct amdgpu_mca_smu_funcs *mca_funcs = adev->mca.mca_funcs;
+
+	if (!count || !entry)
+		return -EINVAL;
+
+	if (!mca_funcs || !mca_funcs->mca_parse_mca_error_count)
+		return -EOPNOTSUPP;
+
+	return mca_funcs->mca_parse_mca_error_count(adev, blk, type, entry, count);
+}
+
 int amdgpu_mca_smu_log_ras_error(struct amdgpu_device *adev, enum amdgpu_ras_block blk, enum amdgpu_mca_error_type type,
 				 struct ras_err_data *err_data, struct ras_query_context *qctx)
 {
@@ -241,7 +319,7 @@ int amdgpu_mca_smu_log_ras_error(struct amdgpu_device *adev, enum amdgpu_ras_blo
 
 	amdgpu_mca_bank_set_init(&mca_set);
 
-	ret = amdgpu_mca_smu_get_mca_set(adev, blk, type, &mca_set);
+	ret = amdgpu_mca_smu_get_mca_set(adev, type, &mca_set);
 	if (ret)
 		goto out_mca_release;
 
@@ -286,119 +364,6 @@ int amdgpu_mca_smu_log_ras_error(struct amdgpu_device *adev, enum amdgpu_ras_blo
 	return ret;
 }
 
-
-int amdgpu_mca_smu_get_valid_mca_count(struct amdgpu_device *adev, enum amdgpu_mca_error_type type, uint32_t *count)
-{
-	const struct amdgpu_mca_smu_funcs *mca_funcs = adev->mca.mca_funcs;
-
-	if (!count)
-		return -EINVAL;
-
-	if (mca_funcs && mca_funcs->mca_get_valid_mca_count)
-		return mca_funcs->mca_get_valid_mca_count(adev, type, count);
-
-	return -EOPNOTSUPP;
-}
-
-int amdgpu_mca_smu_get_mca_set_error_count(struct amdgpu_device *adev, enum amdgpu_ras_block blk,
-					    enum amdgpu_mca_error_type type, uint32_t *total)
-{
-	const struct amdgpu_mca_smu_funcs *mca_funcs = adev->mca.mca_funcs;
-	struct mca_bank_set mca_set;
-	struct mca_bank_node *node;
-	struct mca_bank_entry *entry;
-	uint32_t count;
-	int ret;
-
-	if (!total)
-		return -EINVAL;
-
-	if (!mca_funcs)
-		return -EOPNOTSUPP;
-
-	if (!mca_funcs->mca_get_ras_mca_set || !mca_funcs->mca_get_valid_mca_count)
-		return -EOPNOTSUPP;
-
-	amdgpu_mca_bank_set_init(&mca_set);
-
-	ret = mca_funcs->mca_get_ras_mca_set(adev, blk, type, &mca_set);
-	if (ret)
-		goto err_mca_set_release;
-
-	*total = 0;
-	list_for_each_entry(node, &mca_set.list, node) {
-		entry = &node->entry;
-
-		count = 0;
-		ret = mca_funcs->mca_parse_mca_error_count(adev, blk, type, entry, &count);
-		if (ret)
-			goto err_mca_set_release;
-
-		*total += count;
-	}
-
-err_mca_set_release:
-	amdgpu_mca_bank_set_release(&mca_set);
-
-	return ret;
-}
-
-int amdgpu_mca_smu_parse_mca_error_count(struct amdgpu_device *adev, enum amdgpu_ras_block blk,
-					 enum amdgpu_mca_error_type type, struct mca_bank_entry *entry, uint32_t *count)
-{
-	const struct amdgpu_mca_smu_funcs *mca_funcs = adev->mca.mca_funcs;
-	if (!count || !entry)
-		return -EINVAL;
-
-	if (!mca_funcs || !mca_funcs->mca_parse_mca_error_count)
-		return -EOPNOTSUPP;
-
-
-	return mca_funcs->mca_parse_mca_error_count(adev, blk, type, entry, count);
-}
-
-int amdgpu_mca_smu_get_mca_set(struct amdgpu_device *adev, enum amdgpu_ras_block blk,
-			       enum amdgpu_mca_error_type type, struct mca_bank_set *mca_set)
-{
-	const struct amdgpu_mca_smu_funcs *mca_funcs = adev->mca.mca_funcs;
-
-	if (!mca_set)
-		return -EINVAL;
-
-	if (!mca_funcs || !mca_funcs->mca_get_ras_mca_set)
-		return -EOPNOTSUPP;
-
-	WARN_ON(!list_empty(&mca_set->list));
-
-	return mca_funcs->mca_get_ras_mca_set(adev, blk, type, mca_set);
-}
-
-int amdgpu_mca_smu_get_mca_entry(struct amdgpu_device *adev, enum amdgpu_mca_error_type type,
-				 int idx, struct mca_bank_entry *entry)
-{
-	const struct amdgpu_mca_smu_funcs *mca_funcs = adev->mca.mca_funcs;
-	int count;
-
-	if (!mca_funcs || !mca_funcs->mca_get_mca_entry)
-		return -EOPNOTSUPP;
-
-	switch (type) {
-	case AMDGPU_MCA_ERROR_TYPE_UE:
-		count = mca_funcs->max_ue_count;
-		break;
-	case AMDGPU_MCA_ERROR_TYPE_CE:
-		count = mca_funcs->max_ce_count;
-		break;
-	default:
-		return -EINVAL;
-	}
-
-	if (idx >= count)
-		return -EINVAL;
-
-	return mca_funcs->mca_get_mca_entry(adev, type, idx, entry);
-}
-
 #if defined(CONFIG_DEBUG_FS)
 static int amdgpu_mca_smu_debug_mode_set(void *data, u64 val)
 {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.h
index e5bf07ce3451..4d0a0f91c375 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.h
@@ -122,8 +122,6 @@ struct amdgpu_mca_smu_funcs {
 	int max_ue_count;
 	int max_ce_count;
 	int (*mca_set_debug_mode)(struct amdgpu_device *adev, bool enable);
-	int (*mca_get_ras_mca_set)(struct amdgpu_device *adev, enum amdgpu_ras_block blk, enum amdgpu_mca_error_type type,
-				   struct mca_bank_set *mca_set);
 	int (*mca_parse_mca_error_count)(struct amdgpu_device *adev, enum amdgpu_ras_block blk, enum amdgpu_mca_error_type type,
 					 struct mca_bank_entry *entry, uint32_t *count);
 	int (*mca_get_valid_mca_count)(struct amdgpu_device *adev, enum amdgpu_mca_error_type type,
@@ -152,23 +150,9 @@ int amdgpu_mca_mpio_ras_sw_init(struct amdgpu_device *adev);
 
 void amdgpu_mca_smu_init_funcs(struct amdgpu_device *adev, const struct amdgpu_mca_smu_funcs *mca_funcs);
 int amdgpu_mca_smu_set_debug_mode(struct amdgpu_device *adev, bool enable);
-int amdgpu_mca_smu_get_valid_mca_count(struct amdgpu_device *adev, enum amdgpu_mca_error_type type, uint32_t *count);
 int amdgpu_mca_smu_get_mca_set_error_count(struct amdgpu_device *adev, enum amdgpu_ras_block blk,
 					   enum amdgpu_mca_error_type type, uint32_t *total);
-int amdgpu_mca_smu_get_error_count(struct amdgpu_device *adev, enum amdgpu_ras_block blk,
-				   enum amdgpu_mca_error_type type, uint32_t *count);
-int amdgpu_mca_smu_parse_mca_error_count(struct amdgpu_device *adev, enum amdgpu_ras_block blk,
-					 enum amdgpu_mca_error_type type, struct mca_bank_entry *entry, uint32_t *count);
-int amdgpu_mca_smu_get_mca_set(struct amdgpu_device *adev, enum amdgpu_ras_block blk,
-			       enum amdgpu_mca_error_type type, struct mca_bank_set *mca_set);
-int amdgpu_mca_smu_get_mca_entry(struct amdgpu_device *adev, enum amdgpu_mca_error_type type,
-				 int idx, struct mca_bank_entry *entry);
-
 void amdgpu_mca_smu_debugfs_init(struct amdgpu_device *adev, struct dentry *root);
-
-void amdgpu_mca_bank_set_init(struct mca_bank_set *mca_set);
-int amdgpu_mca_bank_set_add_entry(struct mca_bank_set *mca_set, struct mca_bank_entry *entry);
-void amdgpu_mca_bank_set_release(struct mca_bank_set *mca_set);
 int amdgpu_mca_smu_log_ras_error(struct amdgpu_device *adev, enum amdgpu_ras_block blk, enum amdgpu_mca_error_type type,
 				 struct ras_err_data *err_data, struct ras_query_context *qctx);
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index 59e5c6256ea2..f3956fc7d476 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -2899,55 +2899,6 @@ static bool mca_bank_is_valid(struct amdgpu_device *adev, const struct mca_ras_i
 	return true;
 }
 
-static int __mca_smu_get_ras_mca_set(struct amdgpu_device *adev, const struct mca_ras_info *mca_ras,
-				     enum amdgpu_mca_error_type type, struct mca_bank_set *mca_set)
-{
-	struct mca_bank_entry entry;
-	uint32_t mca_cnt;
-	int i, ret;
-
-	ret = mca_get_valid_mca_count(adev, type, &mca_cnt);
-	if (ret)
-		return ret;
-
-	/* if valid mca bank count is 0, the driver can return 0 directly */
-	if (!mca_cnt)
-		return 0;
-
-	for (i = 0; i < mca_cnt; i++) {
-		memset(&entry, 0, sizeof(entry));
-		ret = mca_get_mca_entry(adev, type, i, &entry);
-		if (ret)
-			return ret;
-
-		if (mca_ras && !mca_bank_is_valid(adev, mca_ras, type, &entry))
-			continue;
-
-		ret = amdgpu_mca_bank_set_add_entry(mca_set, &entry);
-		if (ret)
-			return ret;
-	}
-
-	return 0;
-}
-
-static int mca_smu_get_ras_mca_set(struct amdgpu_device *adev, enum amdgpu_ras_block blk,
-				   enum amdgpu_mca_error_type type, struct mca_bank_set *mca_set)
-{
-	const struct mca_ras_info *mca_ras = NULL;
-
-	if (!mca_set)
-		return -EINVAL;
-
-	if (blk != AMDGPU_RAS_BLOCK_COUNT) {
-		mca_ras = mca_get_mca_ras_info(adev, blk);
-		if (!mca_ras)
-			return -EOPNOTSUPP;
-	}
-
-	return __mca_smu_get_ras_mca_set(adev, mca_ras, type, mca_set);
-}
-
 static int mca_smu_parse_mca_error_count(struct amdgpu_device *adev, enum amdgpu_ras_block blk, enum amdgpu_mca_error_type type,
 					 struct mca_bank_entry *entry, uint32_t *count)
 {
@@ -2984,7 +2935,6 @@ static const struct amdgpu_mca_smu_funcs smu_v13_0_6_mca_smu_funcs = {
 	.max_ue_count = 12,
 	.max_ce_count = 12,
 	.mca_set_debug_mode = mca_smu_set_debug_mode,
-	.mca_get_ras_mca_set = mca_smu_get_ras_mca_set,
 	.mca_parse_mca_error_count = mca_smu_parse_mca_error_count,
 	.mca_get_mca_entry = mca_smu_get_mca_entry,
 	.mca_get_valid_mca_count = mca_smu_get_valid_mca_count,
-- 
2.34.1

