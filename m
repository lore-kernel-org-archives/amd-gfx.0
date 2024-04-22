Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93000C07E8F
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Apr 2024 09:36:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4951011293C;
	Mon, 22 Apr 2024 09:36:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="jWYesahi";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2063.outbound.protection.outlook.com [40.107.100.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E45EE112939
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Apr 2024 09:36:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gapsJj5SNaAAdXuKCFaYP2pUrscNzeXzUxCJ4J26Rcr/GN/WOy158DQIRNTyto4LQHB3CMdwhdC1Cjp/q3aM/mgD10OyJamgTBP1X+PKRJzKaCrVGnpOPRdRqzNzMqUzP3Smo8wXKHq3AcpYFg1ubtsI2pjFP+4QL4H85nTVymgS3Ng9G0/45L8w+BngdOmVtfhGyFQK74ORwlmondsboFee/hFXs6EDH+3VAiGx/XBRCgEisUNtqI+GDtNvWda4DF1x2tOBi2MO6wc3UeAnrIZDq5jWjwDCuGpQb9hRsTcOH7+3TBUMzBahibVr3uF2GWVC4qYgEK6I1df1Zn9vVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v4ZAt/9wt62EmDq6nXWnjOnCkgYlDu1vXGKbSJTxGOE=;
 b=AiSJjCnbzC8cgx+oNTpUtFJPbU4OBK96WlU99KCuU4ILXfi8BiQXLTYMlOMvx05sI21pYjgZF/aX7kZO0IvP2Loamyx9Pi+83XdII57Hkif2N4HW+PoTKCodoUa8A453UOUmMdJJ7oMeQ8wkOerujXoEm+vaPAhGOyR+CJWr7M4T1JFcYXd9A/K6+qq30EcFGHvc1kx1i8ZDiy3HXd9qwzbFEgiozaCzR0fSC6QOHXrH3RuCti+9t5rOyhSG8B6X3ZwbYJf4qGBsKT1xHHnO5AkqRLS+cOxlQHo4z7o3qugDI0IGJpf5rfd1Hq/uBK3jMam2QVhoPnNPpWT3Gl8tVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v4ZAt/9wt62EmDq6nXWnjOnCkgYlDu1vXGKbSJTxGOE=;
 b=jWYesahi5GZe/Nci92DLg7R90S7t0jutpyAruEObFPvC+lpCf8ABqJGmO6Uj1EPFjtVSROpyi0tZRofS4tgOjAqilKq0sYTeOW+eAkfcjYPnVwyCLvohOXBHmumY8r4OMFYPZ9+ddnHrNJHNv/fHx9VpcTjC9dcMo0/sPEx/xKQ=
Received: from SJ0PR05CA0179.namprd05.prod.outlook.com (2603:10b6:a03:339::34)
 by MN2PR12MB4421.namprd12.prod.outlook.com (2603:10b6:208:26c::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Mon, 22 Apr
 2024 09:36:12 +0000
Received: from CO1PEPF000066EA.namprd05.prod.outlook.com
 (2603:10b6:a03:339:cafe::2e) by SJ0PR05CA0179.outlook.office365.com
 (2603:10b6:a03:339::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.20 via Frontend
 Transport; Mon, 22 Apr 2024 09:36:12 +0000
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
 2024 04:36:08 -0500
From: Yang Wang <kevinyang.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <hawking.zhang@amd.com>, <tao.zhou1@amd.com>, <Candice.Li@amd.com>
Subject: [PATCH 2/3] drm/amdgpu: add amdgpu MCA bank dispatch function support
Date: Mon, 22 Apr 2024 17:35:35 +0800
Message-ID: <20240422093536.2689784-2-kevinyang.wang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240422093536.2689784-1-kevinyang.wang@amd.com>
References: <20240422093536.2689784-1-kevinyang.wang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066EA:EE_|MN2PR12MB4421:EE_
X-MS-Office365-Filtering-Correlation-Id: 036fc5fb-b513-444f-a598-08dc62afa5c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?dnzBYixlodc501uUs5laExXQUKGF/Mv3YjoPPrGTBal/hltpuxWc0clFqEWC?=
 =?us-ascii?Q?dPaJtLXQdZ7HgwwDrM8v0pTnOqsJ/PH6XgWeevw0PCCoDLlMl3OijmkNtb91?=
 =?us-ascii?Q?uNcRmS5K9sCYf3YWt/AEWYqCwVNMtsAljrEMnXHbAO0qoZX463VG0Lm8Cia/?=
 =?us-ascii?Q?OVa36dSLg3R+ExFeG7TepSQ/bqfk2/oOU0kW+pYFVfpqXejDvZaJ7L9Ah08b?=
 =?us-ascii?Q?TA5FuiTn/lkE+odRVxu7f1ktCCwaAcKd/DqBMLkStC09A/HhIh48QUcNN5nl?=
 =?us-ascii?Q?V4oABjGMXXI8Vjq8UpSZfWd3v+GbFBgY4PFhunnspDWCKJGmo8Has91cpaOt?=
 =?us-ascii?Q?9e0NwhaK652OwlSODW081EuOsEgLLnDfCQsw1/H+bbKuKy864wzvCmmnD+Bo?=
 =?us-ascii?Q?BLfqEcSRRfxgiXf1cWDjZ8DEBAOvRNK8gK/V/S0ecWBPwByJEFgXkYww46gI?=
 =?us-ascii?Q?CvlB1ZRMeDE1oqFFXd6KKOSWfPN2A2SU+/Z1WOb3xccfp/vEiue6pvrlZGjr?=
 =?us-ascii?Q?yAgCGwgMJJO2Fctem42SoNSUu15kKAb5/viTldEv3YQsheIY/5VJ6xZenTf/?=
 =?us-ascii?Q?HPCg4U2xlBeayc1Nt3JA1DmjMq6whIB31qQIELJnt9M3dp/R8u83J90Lh1a1?=
 =?us-ascii?Q?4XkxFVgOT4h3tn+9hQEkO0o9OVqEnB9UOo7tkU2Kj1UJF9PzAYZNisX03iXD?=
 =?us-ascii?Q?D5NwXdgwMRxGl3NxWQX775wMxhzi1Td9Ddd6ykCzYqxp42xBVRCqnhXtajkJ?=
 =?us-ascii?Q?TrRyXR9gg6djRwEi6PfMtQgVuMRTG6H3rmmQfB7+Fjz+GvzpJWLO9/xPd4hX?=
 =?us-ascii?Q?pz3wHCAfe487HUWKD4BwDnlCgziLMrR5YCUaB7Bib/emiAPcDostWW8jAPzi?=
 =?us-ascii?Q?2ssl48KjX/95A/NHnVukgUUci/U3aLR99Lzf47wd3OUr5JCD8q6j57N6PFRf?=
 =?us-ascii?Q?+lhuel5oX6XBm2kRCGsxuAz/i1H2eb6Yn66I9kXUqMUdAUxBiSQIHSgo/jZj?=
 =?us-ascii?Q?sZbMVC9vTeHnGWj29u2U7GlxOOuLLph8eU/ATwMIKpj0Vn1Vjw7FGrQ6wVlp?=
 =?us-ascii?Q?e4oP9n+ZsWuXMRL/dbPCVI31oIhm+jle6DfvQpE+wEwfTnLioBZ1BU+RR3na?=
 =?us-ascii?Q?NUXUw1zLdcO/7ZgTLZKJW37cRDGu7AbuGlPWom5Ce1nrksbEqgw4rXqKdnYo?=
 =?us-ascii?Q?nrht/yzwuhX42SpJ1+TxIFY1a4ZTRchuYsAKqRFLnszb0oqTBYBKVJPqfe2m?=
 =?us-ascii?Q?hDXk6UdFaMi8FZumUT3sNILy74ASKSCasCvSX0UiyAnbIPiD+hHJfpL7/G7x?=
 =?us-ascii?Q?YzYtuJ8lVVFaG1r2Gv3RMBrcdcfbgiaXCx3q3SB6PC6fzCaU8YAVnd2AqGmF?=
 =?us-ascii?Q?Rh1xrHFdc4w9UiUJUZD9ISp4LgJF?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(1800799015)(376005)(82310400014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2024 09:36:11.8550 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 036fc5fb-b513-444f-a598-08dc62afa5c8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000066EA.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4421
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
 drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c | 96 ++++++++++++++-----------
 1 file changed, 53 insertions(+), 43 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c
index 67c208861994..68b0e3608b9c 100644
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
@@ -306,36 +309,33 @@ static int amdgpu_mca_smu_parse_mca_error_count(struct amdgpu_device *adev, enum
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
-
-	amdgpu_mca_bank_set_init(&mca_set);
+	int ret;
 
-	ret = amdgpu_mca_smu_get_mca_set(adev, type, &mca_set);
-	if (ret)
-		goto out_mca_release;
+	if (!mca_set)
+		return -EINVAL;
 
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
 
@@ -345,19 +345,36 @@ int amdgpu_mca_smu_log_ras_error(struct amdgpu_device *adev, enum amdgpu_ras_blo
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
 
@@ -402,36 +419,29 @@ static void mca_dump_entry(struct seq_file *m, struct mca_bank_entry *entry)
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

