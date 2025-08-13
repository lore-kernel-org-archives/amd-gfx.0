Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7022C87FCF
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Aug 2025 10:35:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8251010E1D4;
	Wed, 13 Aug 2025 10:35:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3zneTD93";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2068.outbound.protection.outlook.com [40.107.93.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1D97B10E1D4
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Aug 2025 10:35:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Eastg9E4vEpbCn1/L5aLqz6xo6Srm9lkz0YMGx8hQoQNrglbFpUdaNMt8/R4LKprGjZvewDvKRwaIhGYNQWjj7rMqLhIdGJ1xLCLGFjeh8TSxghLn8uZtpsZ7DcUVtZSuyobhLbkjhrlIS1i47jTVe2ZG5MeXU0vtdMetjxpdJbYSjWNVVjIlRcGvDShOOPn284wVePJWQTpLcH6on/3lCHDvPFrhCriNsLgY2AYe9WBrrQ682QeWX1H6y9YfKWTfnvyK/w0+lGxY9xDFZDBV0M4E8ZB9FIG8llbyyUXnRObFGtehDxkD+SA5KpnDyhKEIEnN4ehsgxKUPNWjcegsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QaRRte0x/wKi3k5eT5gfAcArrfwQFIFRD1j7BSPn9AU=;
 b=bZsYbeQRUgaT8xLnubo1IPCj+w2x2fsODchASdrs7xlYHniFoET1tVPFWz2x9Dnxy0LT7XapSjQ5HEkB05lJNFLze5d5MikZYNyYy+qJMRPuBFPILPUMmf/2WnD410z9REglSGEoPArI9ElQTegLomZohpzusd6ssmqjIaCcpyRys2n8gdBkCY4Qxzl3m6d/aNOSV6ZJEXnf0z88Hswn7HIEjTSiAy1j0AaSnkHt5O8S9Jvdr6e+Z58H8PHeQN8ptVkss19ZSHfmDwhcy8orRNxOO9oaNUePjZba/vWtaGrMmjdiT48RrmXr61EZj5YLbdKSpVPqlaa6oH8WC4ElkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QaRRte0x/wKi3k5eT5gfAcArrfwQFIFRD1j7BSPn9AU=;
 b=3zneTD93dON57VJ2kPU260tQokhqgqJIVnXgY5JBXFTVCZ2Ic4a2ODg6veX82R2808lVw1sTw6qhadgDji7ApFao9e8eiR9FEh1ZPEepGnGC4TA5vyihvuJ1lw8xJhHLLiK8frIoEC7Q7lglSy8aipH5JX6G9OY7G076FnqEV2I=
Received: from DM6PR11CA0003.namprd11.prod.outlook.com (2603:10b6:5:190::16)
 by IA1PR12MB8359.namprd12.prod.outlook.com (2603:10b6:208:3fc::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.21; Wed, 13 Aug
 2025 10:35:33 +0000
Received: from CY4PEPF0000E9D3.namprd03.prod.outlook.com
 (2603:10b6:5:190:cafe::3c) by DM6PR11CA0003.outlook.office365.com
 (2603:10b6:5:190::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.16 via Frontend Transport; Wed,
 13 Aug 2025 10:35:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D3.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9031.11 via Frontend Transport; Wed, 13 Aug 2025 10:35:32 +0000
Received: from sunce-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 13 Aug
 2025 05:35:29 -0500
From: Ce Sun <cesun102@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <tao.zhou1@amd.com>, <Stanley.Yang@amd.com>, <Hawking.Zhang@amd.com>,
 <kevinyang.wang@amd.com>, <YiPeng.Chai@amd.com>, Ce Sun <cesun102@amd.com>,
 Xiang Liu <xiang.liu@amd.com>
Subject: [PATCH 2/3 v2] drm/amdgpu: Add functions to get/clear bank count
Date: Wed, 13 Aug 2025 18:35:20 +0800
Message-ID: <20250813103520.264499-1-cesun102@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D3:EE_|IA1PR12MB8359:EE_
X-MS-Office365-Filtering-Correlation-Id: c77eef8b-010c-424a-4bac-08ddda55218b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?egPwxrvZ6zCADQBvScNRo6Om8iVNJ15RLBtGwk5Gjryz1Zufucm9nfDp//8x?=
 =?us-ascii?Q?t4jpSzbUlRjL6WtOzItwzIF7P5UPmqBS23cjJYLdjd0PQrR6Kl6vttWtSdan?=
 =?us-ascii?Q?4mzHbpsA7PTuDrbYmy90LTMcHeO+u2XpSG1OqwiwM4yhQG7IeRRRw973r2h5?=
 =?us-ascii?Q?/JAEQVL54qaWL29FFwGHwcBc8alR+yUk2Av4EBFPQWquYR9F5jvdE5/poJQM?=
 =?us-ascii?Q?yDWiWdeu24tgeQUZQcgBDBcIUGcc5qN577er81aTM7UNF3/ZZbn70Ww2RqJJ?=
 =?us-ascii?Q?v0FHYtSbJX79Df8dom4V4GqwZdd1OQ0/aEku6RkdLSAuEG6c1vN4Q0vXRQRI?=
 =?us-ascii?Q?85tnFjHrd7WAuYMZdREO4bwAisIezFwGFZbgE4hKQ5LSOFaqDer0DMDMOorx?=
 =?us-ascii?Q?WdeLMzQMoKhtcOKekJRudHQbgRBrx8dG77lwi+CnjkOY9NBXAn/DgWfuc9Cc?=
 =?us-ascii?Q?7BSFBzSUsmCDFQOz5LTPlMBLaK4+ri3uf7voPwwRLy5OwyZax99WQ7kgBIDJ?=
 =?us-ascii?Q?/uqFt0HLDg7rsB0O9UdMYGflF6T9hh232V1my/K1fLDcvEBYLe/VJCkWLyZV?=
 =?us-ascii?Q?whVymmb0teMPQpr36PKnKXjKCCWWII5dSYWtFuS68h+WZxOU3OBT4zJ2prVJ?=
 =?us-ascii?Q?rZgugQRxpzz2TQRAT2UNIR0jm3LSjnvU8MLiRYaVav2ZG7fL7yKAkcTIbiQa?=
 =?us-ascii?Q?SdjZyiNRpy6rDsmVGPa/3Rk32TPFKUtd2WGti8ya6M5v453ynm9Xwf1RFW5A?=
 =?us-ascii?Q?YqPpBTxRXErlXqACWKf+kl/fPRoc6WKWjResj7dgQ7CRZ+UJJqlwNIcj2hDN?=
 =?us-ascii?Q?e+FoTbk+TIDHc59gSOX66wH7rRCxb3QFEWl078Y0/8zzUmj/3gX4cyk41Tu6?=
 =?us-ascii?Q?7iweSOiXW6nvsvea1QbRo4z+c6mzbtsENdePAK7W0yjk/LO1KxY29xJ9RFPA?=
 =?us-ascii?Q?UkSbEwc9gfAzlIRA6ZjMJolRzJeYjEKnog+oli0QW7bslLOVND4Ubh/bdkef?=
 =?us-ascii?Q?GabLhaj2JSKTFKQwiEEphHLF+Pd9BUOWs+RvpvwzeuuEnRFunP2J6VfCEisv?=
 =?us-ascii?Q?lnDfOgmancjsxq7T39I3/YudlY3O27SD3Djwg5u19H4CQQoa1GvoAZiZEGa4?=
 =?us-ascii?Q?2momnjpBDGDE0H0c0jFBPdAMh7HyApt3o9OT5X8ZR15+eAqM6kTT8IGSNGRp?=
 =?us-ascii?Q?QCZ6XeB5C2BCfSht8JRmjARvw+MfuUsweGvYnAqgjybuWQAvl/nh2MpyYSfu?=
 =?us-ascii?Q?xAddie/f8hTZKMWu5kEdOzjL82nwRsLGBn/twaRbXcABJzCVF3iwZwmCfr3K?=
 =?us-ascii?Q?o3UMjdv5+bCVwqr8DP6ud13CJAM/KGT6IJHH+cv62RJpAlwUaz7ifycvt9x9?=
 =?us-ascii?Q?VQAfZkQqnkSAycgSsdGBOyHjjWto9tyEmJ8VYxRcFeXdwHxOZnCnzN5Qj7Gz?=
 =?us-ascii?Q?VBviLF600R8FAlhigKzt94OjCYZs0KXmqrkDRXU4oA3lSS29UCiqxhMLIOz3?=
 =?us-ascii?Q?NmdqXqQ7BSg5QKpIh0XQMbN06xXUaBKIQwuS?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2025 10:35:32.5460 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c77eef8b-010c-424a-4bac-08ddda55218b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8359
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

Add the amdgpu_aca_get_bank_count/amdgpu_aca_clear_bank_count interface

Signed-off-by: Ce Sun <cesun102@amd.com>
Signed-off-by: Xiang Liu <xiang.liu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c | 14 ++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_aca.h |  3 +++
 2 files changed, 17 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
index 090bf6cf1b91..92c2370831b3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
@@ -480,6 +480,8 @@ static int aca_banks_update(struct amdgpu_device *adev, enum aca_smu_type type,
 		goto err_release_banks;
 	}
 
+	atomic64_add(banks.nr_banks, &aca->bank_count);
+
 	ret = aca_dispatch_banks(&aca->mgr, &banks, type,
 				 handler, data);
 	if (ret)
@@ -766,6 +768,7 @@ int amdgpu_aca_init(struct amdgpu_device *adev)
 	int ret;
 
 	atomic_set(&aca->ue_update_flag, 0);
+	atomic64_set(&aca->bank_count, 0);
 
 	ret = aca_manager_init(&aca->mgr);
 	if (ret)
@@ -781,6 +784,7 @@ void amdgpu_aca_fini(struct amdgpu_device *adev)
 	aca_manager_fini(&aca->mgr);
 
 	atomic_set(&aca->ue_update_flag, 0);
+	atomic64_set(&aca->bank_count, 0);
 }
 
 int amdgpu_aca_reset(struct amdgpu_device *adev)
@@ -788,6 +792,7 @@ int amdgpu_aca_reset(struct amdgpu_device *adev)
 	struct amdgpu_aca *aca = &adev->aca;
 
 	atomic_set(&aca->ue_update_flag, 0);
+	atomic64_set(&aca->bank_count, 0);
 
 	return 0;
 }
@@ -865,6 +870,15 @@ int amdgpu_aca_smu_set_debug_mode(struct amdgpu_device *adev, bool en)
 	return smu_funcs->set_debug_mode(adev, en);
 }
 
+size_t amdgpu_aca_get_bank_count(struct amdgpu_device *adev)
+{
+	return atomic64_read(&adev->aca.bank_count);
+}
+
+void amdgpu_aca_clear_bank_count(struct amdgpu_device *adev)
+{
+	atomic64_set(&aca->bank_count, 0);
+}
 #if defined(CONFIG_DEBUG_FS)
 static int amdgpu_aca_smu_debug_mode_set(void *data, u64 val)
 {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.h
index 38c88897e1ec..e9acfbf57a44 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.h
@@ -202,6 +202,7 @@ struct amdgpu_aca {
 	const struct aca_smu_funcs *smu_funcs;
 	atomic_t ue_update_flag;
 	bool is_enabled;
+	atomic64_t bank_count;
 };
 
 struct aca_info {
@@ -225,6 +226,8 @@ void amdgpu_aca_remove_handle(struct aca_handle *handle);
 int amdgpu_aca_get_error_data(struct amdgpu_device *adev, struct aca_handle *handle,
 			      enum aca_error_type type, struct ras_err_data *err_data,
 			      struct ras_query_context *qctx);
+size_t amdgpu_aca_get_bank_count(struct amdgpu_device *adev);
+void amdgpu_aca_clear_bank_count(struct amdgpu_device *adev);
 int amdgpu_aca_smu_set_debug_mode(struct amdgpu_device *adev, bool en);
 void amdgpu_aca_smu_debugfs_init(struct amdgpu_device *adev, struct dentry *root);
 int aca_error_cache_log_bank_error(struct aca_handle *handle, struct aca_bank_info *info,
-- 
2.34.1

