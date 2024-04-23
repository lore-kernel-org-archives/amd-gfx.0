Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50D4CC10F15
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Apr 2024 08:27:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 49A731131EA;
	Tue, 23 Apr 2024 08:27:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="IMiZ5s1S";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2045.outbound.protection.outlook.com [40.107.237.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8A5051131E7
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Apr 2024 08:26:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FjVLNHF6/X7nTJTQoWbbFl1vWjh0WpHgUQpFJI57oSqPk6dWfgqLUYQmXyx5vRm2WsarrWTKo7clGsvuQ/4vtm2kpxyYeYasPywb1riCpWGXwX2a9iQf7T1u8EWJWApnkLD3OnD2iDUhG0UAVKslNgm61P4sAMBdIdTGI1Lji+Mf4gwLSzUqnboVIrbdT/29OxtWzyoaK0oWzFytYQ748m3wHz02JbixFNrJ0kL/nqP9BGjHkz7A+jAkboLYKuA41B5RKtIoV4MMevnBbAyqhgnChg4ICG5rwnuqkPiwu2tJ/SezOUvVA0sKQZggjL63va47jXU9salljqhvxW0+lQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ap/aXI0HzqV4LDHs7OTwQ6q+bW2vNDmieJf3EMFZsZ0=;
 b=C0CdJI1bsdrZTv6b2H0lN6DdlOOx7pE5uecbKqNHDGef/ftaFBylknivB1ywAAFznLb/NPA9w6lU7BQmS+gRINtzbpMCfFDFn6sNqSV59rReOYieLMlZcSkGxO1khH0LJ7cyfy3b6z70wzpn9Hc59Z+ScI67A9TytgE/Bacv7cfYdgyxQZ4eRC4HNJW5uvG7kJ4Wr3PGrIfIkjx9z1yrR/vFMZxl2Cj3hemJtDDXCqr6tEnjZYtHwf5jg+P/7P6ZF+CJmdODV63ikEN60dzbFakDYAJ22+o2hl0hBVGzEF5SD2i8z5gubzb8F3T9uZcH9il3ykZL90a3CvM8WJkPYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ap/aXI0HzqV4LDHs7OTwQ6q+bW2vNDmieJf3EMFZsZ0=;
 b=IMiZ5s1SuehVODYiUTxVj5JmyjhOEcsl1oHVlU1xHv1ilCtus4y16QdyTXfx7qfhoDLp2Lsry0NtemL6RNjjtZUpFt0BbuqnUeBK/fqZ8calxUjz7MEfwl5Zg/oMJrn+KND9WEeAWAT59AMolmFwCXAlPJrcOPp+fd+MKpSAmM4=
Received: from BN9PR03CA0219.namprd03.prod.outlook.com (2603:10b6:408:f8::14)
 by SA1PR12MB8597.namprd12.prod.outlook.com (2603:10b6:806:251::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Tue, 23 Apr
 2024 08:26:55 +0000
Received: from BN3PEPF0000B06A.namprd21.prod.outlook.com
 (2603:10b6:408:f8:cafe::ca) by BN9PR03CA0219.outlook.office365.com
 (2603:10b6:408:f8::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7495.33 via Frontend
 Transport; Tue, 23 Apr 2024 08:26:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B06A.mail.protection.outlook.com (10.167.243.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.0 via Frontend Transport; Tue, 23 Apr 2024 08:26:55 +0000
Received: from kevin-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 23 Apr
 2024 03:26:53 -0500
From: Yang Wang <kevinyang.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <hawking.zhang@amd.com>, <tao.zhou1@amd.com>, <Candice.Li@amd.com>
Subject: [PATCH 2/4] drm/amdgpu: add amdgpu MCA bank dispatch function support
Date: Tue, 23 Apr 2024 16:26:38 +0800
Message-ID: <20240423082640.3273762-2-kevinyang.wang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240423082640.3273762-1-kevinyang.wang@amd.com>
References: <20240423082640.3273762-1-kevinyang.wang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06A:EE_|SA1PR12MB8597:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c70536b-e1dc-462a-771b-08dc636f22c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?y6+9mqnuJasN/KBBxm7spfiOOzOOy8uIMVSWbr4J5gPpMziB4Srfe9+we/8m?=
 =?us-ascii?Q?lIR/ThjsrrPu4DYoWRcbJYCm+iIL7r4DHQZ7oJUzTDF+SN/D756uf6XQZF2C?=
 =?us-ascii?Q?Wo5KRd3eyg2nhubC33tnnjvcZEv/vVpE7mLZRugPhbnAAv9YKdlliv8XWqVk?=
 =?us-ascii?Q?eVS9JZ6ICnVPFmkHyTFpdJ82bT+ziYoQXGXdhHWVmDnVEV+Kh0gaThOzar/u?=
 =?us-ascii?Q?2toa6ntI3r0cPprcc0eli7Y+DDHzXK/BtOOZRCS6TDxIpOauSoGwYuCEPD6S?=
 =?us-ascii?Q?gyCop+yDb3U+kkHGlHPrR0myLdbq0/+zj3AMe+ueec2Uhsfi0mu+diepXjVu?=
 =?us-ascii?Q?Ip1tgCJz9NwIoybOuBb+aG75Mm/tpMHbNfxg2dww9g3wd8kwe6PoZ+9AWqYo?=
 =?us-ascii?Q?qVj2pFxM+y4lYT9LyWrHGKwEzNykYe8zT2ZyttoG0G/YD84BB4C5c4dymW/r?=
 =?us-ascii?Q?HcAo7XoCfK5LTtBx6opwRAdyuS3i64G4azwmIqQUm/JCucaLej+WSLxiRP+q?=
 =?us-ascii?Q?lbpjNrsRNSc35cKN/fQFIzR4AkhoT2QFXwkmHjYb4lTvm5qzoY6RSE2QcGI1?=
 =?us-ascii?Q?TdV4VzwlUqw0rr3Ki5ee3Qp9l4fnaL2NuCvTuXuojkZcV0pgIJnnnanL5WbM?=
 =?us-ascii?Q?iUb63HY+bUGb8bRFWbZfDkMMTTG4gbc5dupBTTDabx1sqTt12uF8Z3vYHiqT?=
 =?us-ascii?Q?ca0K2AihWRvkQ17B75mn+mt/oFZB7OL/qSHy87G2rgkPxUdq040LcOMZohv4?=
 =?us-ascii?Q?vNSVQ8Wxh4/wMDsDFlsG2pktt7pQse5o9qTDVK8HOHbNWpBbdB/ZViI2ESAR?=
 =?us-ascii?Q?LSGVAtuE+xJnbkj+S/iH9Rz4CRoWm8p6V+DXSzZCV9pkPr5ZN8RBx4qLTuoZ?=
 =?us-ascii?Q?xUxbtpDHx4VME72mzJCfwnZGGgnGDna8aw65PlSo8QKdcWseYIrt0xnGP9ar?=
 =?us-ascii?Q?sTjJMIGkYWwYUTTTlWkrnjzcM4CpxOamIRUgHFdm3j3+EDKlkMLcF7M3CFEK?=
 =?us-ascii?Q?UnjXoxQjtoLMpn75vXJC9EReO2t/hlwVKVGemGkgEAiLZU4xUdZlvxK5CAqV?=
 =?us-ascii?Q?TwcpHg+M1PkzQR9ZhIN8kH5UJXjpYM02FbrPi/j+JnOM/dd1YQ3uyxDQZVbN?=
 =?us-ascii?Q?V5qOWx+F47rMqdletbvrNitzB/Y0UZxmRzvDfpDTnJbYOiHtrOpL1CS/4PuG?=
 =?us-ascii?Q?IWdVU2c+AcEICD8NA1HjlDlkbxHmGhgOZP5zYok/++NO5kqgItcJBO0rl3IP?=
 =?us-ascii?Q?106GftJJ+YavB6R6OUHv1uiQymwEzjnEIPDnfdQIC2RL/qyGN1Z/KMdB9K5u?=
 =?us-ascii?Q?cys47rlmvnS2lT/4pIV+pHmKl9H0YjGrW3e8Ir7zVLF9DS6g+r1tCUkJThLp?=
 =?us-ascii?Q?WgSDfoMzjbTOkrXIX9Hbu/M5qTf/?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400014)(1800799015)(376005)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2024 08:26:55.5054 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c70536b-e1dc-462a-771b-08dc636f22c3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B06A.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8597
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

- Refine mca driver code.
- Centralize mca bank dispatch code logic.

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
Reviewed-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c | 97 ++++++++++++++-----------
 1 file changed, 55 insertions(+), 42 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c
index 67c208861994..859d594c02a5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c
@@ -267,7 +267,8 @@ static int amdgpu_mca_smu_get_mca_entry(struct amdgpu_device *adev, enum amdgpu_
 	return mca_funcs->mca_get_mca_entry(adev, type, idx, entry);
 }
 
-static int amdgpu_mca_smu_get_mca_set(struct amdgpu_device *adev, enum amdgpu_mca_error_type type, struct mca_bank_set *mca_set)
+static int amdgpu_mca_smu_get_mca_set(struct amdgpu_device *adev, enum amdgpu_mca_error_type type, struct mca_bank_set *mca_set,
+				      struct ras_query_context *qctx)
 {
 	struct mca_bank_entry entry;
 	uint32_t count = 0, i;
@@ -287,6 +288,8 @@ static int amdgpu_mca_smu_get_mca_set(struct amdgpu_device *adev, enum amdgpu_mc
 			return ret;
 
 		amdgpu_mca_bank_set_add_entry(mca_set, &entry);
+
+		amdgpu_mca_smu_mca_bank_dump(adev, i, &entry, qctx);
 	}
 
 	return 0;
@@ -306,36 +309,36 @@ static int amdgpu_mca_smu_parse_mca_error_count(struct amdgpu_device *adev, enum
 	return mca_funcs->mca_parse_mca_error_count(adev, blk, type, entry, count);
 }
 
-int amdgpu_mca_smu_log_ras_error(struct amdgpu_device *adev, enum amdgpu_ras_block blk, enum amdgpu_mca_error_type type,
-				 struct ras_err_data *err_data, struct ras_query_context *qctx)
+static int amdgpu_mca_dispatch_mca_set(struct amdgpu_device *adev, enum amdgpu_ras_block blk, enum amdgpu_mca_error_type type,
+				       struct mca_bank_set *mca_set, struct ras_err_data *err_data)
 {
+	struct ras_err_addr err_addr;
 	struct amdgpu_smuio_mcm_config_info mcm_info;
-	struct ras_err_addr err_addr = {0};
-	struct mca_bank_set mca_set;
 	struct mca_bank_node *node;
 	struct mca_bank_entry *entry;
 	uint32_t count;
-	int ret, i = 0;
+	int ret;
 
-	amdgpu_mca_bank_set_init(&mca_set);
+	if (!mca_set)
+		return -EINVAL;
 
-	ret = amdgpu_mca_smu_get_mca_set(adev, type, &mca_set);
-	if (ret)
-		goto out_mca_release;
+	if (!mca_set->nr_entries)
+		return 0;
 
-	list_for_each_entry(node, &mca_set.list, node) {
+	list_for_each_entry(node, &mca_set->list, node) {
 		entry = &node->entry;
 
-		amdgpu_mca_smu_mca_bank_dump(adev, i++, entry, qctx);
-
 		count = 0;
 		ret = amdgpu_mca_smu_parse_mca_error_count(adev, blk, type, entry, &count);
 		if (ret)
-			goto out_mca_release;
+			return ret;
 
 		if (!count)
 			continue;
 
+		memset(&mcm_info, 0, sizeof(mcm_info));
+		memset(&err_addr, 0, sizeof(err_addr));
+
 		mcm_info.socket_id = entry->info.socket_id;
 		mcm_info.die_id = entry->info.aid;
 
@@ -345,19 +348,36 @@ int amdgpu_mca_smu_log_ras_error(struct amdgpu_device *adev, enum amdgpu_ras_blo
 			err_addr.err_addr = entry->regs[MCA_REG_IDX_ADDR];
 		}
 
-		if (type == AMDGPU_MCA_ERROR_TYPE_UE)
+		if (type == AMDGPU_MCA_ERROR_TYPE_UE) {
 			amdgpu_ras_error_statistic_ue_count(err_data,
-				&mcm_info, &err_addr, (uint64_t)count);
-		else {
+							    &mcm_info, &err_addr, (uint64_t)count);
+		} else {
 			if (amdgpu_mca_is_deferred_error(adev, entry->regs[MCA_REG_IDX_STATUS]))
 				amdgpu_ras_error_statistic_de_count(err_data,
-					&mcm_info, &err_addr, (uint64_t)count);
+								    &mcm_info, &err_addr, (uint64_t)count);
 			else
 				amdgpu_ras_error_statistic_ce_count(err_data,
-					&mcm_info, &err_addr, (uint64_t)count);
+								    &mcm_info, &err_addr, (uint64_t)count);
 		}
 	}
 
+	return 0;
+}
+
+int amdgpu_mca_smu_log_ras_error(struct amdgpu_device *adev, enum amdgpu_ras_block blk, enum amdgpu_mca_error_type type,
+				 struct ras_err_data *err_data, struct ras_query_context *qctx)
+{
+	struct mca_bank_set mca_set;
+	int ret;
+
+	amdgpu_mca_bank_set_init(&mca_set);
+
+	ret = amdgpu_mca_smu_get_mca_set(adev, type, &mca_set, qctx);
+	if (ret)
+		goto out_mca_release;
+
+	ret = amdgpu_mca_dispatch_mca_set(adev, blk, type, &mca_set, err_data);
+
 out_mca_release:
 	amdgpu_mca_bank_set_release(&mca_set);
 
@@ -402,36 +422,29 @@ static void mca_dump_entry(struct seq_file *m, struct mca_bank_entry *entry)
 static int mca_dump_show(struct seq_file *m, enum amdgpu_mca_error_type type)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)m->private;
-	struct mca_bank_entry *entry;
-	uint32_t count = 0;
-	int i, ret;
+	struct mca_bank_node *node;
+	struct mca_bank_set mca_set;
+	struct ras_query_context qctx;
+	int ret;
 
-	ret = amdgpu_mca_smu_get_valid_mca_count(adev, type, &count);
+	amdgpu_mca_bank_set_init(&mca_set);
+
+	qctx.event_id = 0ULL;
+	ret = amdgpu_mca_smu_get_mca_set(adev, type, &mca_set, &qctx);
 	if (ret)
-		return ret;
+		goto err_free_mca_set;
 
 	seq_printf(m, "amdgpu smu %s valid mca count: %d\n",
-		   type == AMDGPU_MCA_ERROR_TYPE_UE ? "UE" : "CE", count);
-
-	if (!count)
-		return 0;
-
-	entry = kmalloc(sizeof(*entry), GFP_KERNEL);
-	if (!entry)
-		return -ENOMEM;
-
-	for (i = 0; i < count; i++) {
-		memset(entry, 0, sizeof(*entry));
+		   type == AMDGPU_MCA_ERROR_TYPE_UE ? "UE" : "CE", mca_set.nr_entries);
 
-		ret = amdgpu_mca_smu_get_mca_entry(adev, type, i, entry);
-		if (ret)
-			goto err_free_entry;
+	if (!mca_set.nr_entries)
+		goto err_free_mca_set;
 
-		mca_dump_entry(m, entry);
-	}
+	list_for_each_entry(node, &mca_set.list, node)
+		mca_dump_entry(m, &node->entry);
 
-err_free_entry:
-	kfree(entry);
+err_free_mca_set:
+	amdgpu_mca_bank_set_release(&mca_set);
 
 	return ret;
 }
-- 
2.34.1

