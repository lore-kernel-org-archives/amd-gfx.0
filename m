Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06EA0C64EC4
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Mar 2023 21:58:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7590C10E260;
	Mon,  6 Mar 2023 21:58:28 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2045.outbound.protection.outlook.com [40.107.244.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6744C10E260
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 Mar 2023 21:58:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AYDQWBxhSyULHpBqQRZyuZz3wyzUxR13cQrDqaa18gEmubWAjzr89d7AoUrbO60ub0YLdYmC6uw2UBRRMHO6VuKN2E1lsLvUEm/ztg2bNrYvB73zCgEwT2osywFGCAVkBYxFhPPCUj0lN6OiaoggQZspCc8I6Lvf60/ZuDSX5XdlB3zGdoUTVA4aqqCunv2Sy1m9znVAV1kpKE+l+0Cr+YsYIwPVN+On++P7S+zY4WNQ8u3fm3ZSE+UTO6fSOhBsUgD+uMbwuKOVwD6NMQqNB6evdY5fSbWGneqKe4A3Hibq19tWuA4qiOueGzS/v0tM00LvrGnWCX+r3BGlel0JyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pE0mRP9iv+FrM+oqVKzSfRUqe/oNFBSg7ooFbp/cRNw=;
 b=dQmM+TY6RDJbQ2kCRx5+NVlfsya4X5QpG5PA26avPN5W0nQP3cOKmvhpzHWwgVFap5Kqrp2atZB7zVG9wYtgtPEgli/7mLq0rfSx/e3PZkfs6d5uDbPyzuJQJ3bWg6AaDAFybm3C/rjUBxWY/VAWVarN8Svj4HWtKj74tv+R38Lj2jPkOWIipyXvKcgD7lC+GdZktdpdg11mP8L3BqWYt7vusGSBvcI+fh3rzssZypgAd2qau/KKlLSWvcz1EGgtTsQndAKQ1VrTufONW0VcQAj5GjV+EaIPpRAcySI2og0/fkfcl2qsoYSOhwPwlkO+eMFiWDlO0Uv19lP2bqeWqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pE0mRP9iv+FrM+oqVKzSfRUqe/oNFBSg7ooFbp/cRNw=;
 b=IvoVeMY0X75DVBwFSSSmBmY9KPCskQzzE8Lk2ri1/yCqiEeHVhZgJdbX6k18nAEj9KNJ17P7tcPuTcbfyGY2l6LwkwH5oGQaQ551BfzhnGlPR4SM5MY/CZP/cx2h/OS6gfmxxJkWs9x10vhrANQqgYttws7g4zJaxjuBZmPyoHs=
Received: from MW4P220CA0022.NAMP220.PROD.OUTLOOK.COM (2603:10b6:303:115::27)
 by BN9PR12MB5193.namprd12.prod.outlook.com (2603:10b6:408:11a::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.28; Mon, 6 Mar
 2023 21:58:25 +0000
Received: from CO1NAM11FT034.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:115:cafe::73) by MW4P220CA0022.outlook.office365.com
 (2603:10b6:303:115::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.28 via Frontend
 Transport; Mon, 6 Mar 2023 21:58:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT034.mail.protection.outlook.com (10.13.174.248) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.16 via Frontend Transport; Mon, 6 Mar 2023 21:58:24 +0000
Received: from belanger-linux.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 6 Mar
 2023 15:58:23 -0600
From: David Belanger <david.belanger@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdkfd: Fixed kfd_process cleanup on module exit.
Date: Mon, 6 Mar 2023 16:58:08 -0500
Message-ID: <20230306215808.2903387-1-david.belanger@amd.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT034:EE_|BN9PR12MB5193:EE_
X-MS-Office365-Filtering-Correlation-Id: f6ed33dc-c5bc-407b-1bf6-08db1e8de8f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FO85MTMq/opWCJOQFcgRcz6JyY4wKwgUdHYLt5zaeAR6DavKRJbY7oqrMZjDuXGVdQs9y3BMEisSjfcJWYf7QjOEghDXtDxBdgXbnVPXFrUr+oSILrPoEE3AmceRq0MJbmOCIKhRf39J/vteMlTw/kgTftLqOyJhWIQyOFScptwI4N4t1lr+O5TKiPu1wBCtvzX2DEgWjIIIy1XdAPhVR9xpU4iG4WV9BQrRleUjMiixyoUELfkN4G484a36QWq6hMk1lqhgOyp6msImdlfcCVPBrfX/BeQrfrD+3syiPn9iDhfpFbk+k2L00NXQQN/M6BjeXxfmA/FhE8uvtvct9NKdqyeAW3/86fGNiaq1iLZGsf1eKlNZJKYWLo6k+W4eOZNufJWBBxGXCeSrjIU5zgxcTtdGr3kjUKKdj/M7VTuvcoJ+kMuUGb6VQtnYZaFJOrWoNVq+OPqzVhOWvXA4ilUqKycmAlOkIK1TwEnT/sRC4yMCJW0G3lRgn9GxrQ5RxZk7BEGz03B3szXtmErZ9vwxse9NE14knJpoMygRSlU/14HS1ccXWuFwL0HDHAgIlHesU9Dj9caKVq5HA3FuXBCX6BOXmhr+VQxRytkskYLUP7/3U9QlEAU6dvqreNHImkxsU8y9ovXWIimdSdVC4ETBWEqu9CJ2Kgu1cSVwkjK8hovURZLKeKdNgtBIGTUgM77DIZ5Nq7/tbVQQqkBo9efi65TdCtvMN+HgKf3f6Xs=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(396003)(136003)(376002)(346002)(39860400002)(451199018)(40470700004)(36840700001)(46966006)(40460700003)(16526019)(186003)(6666004)(81166007)(356005)(6916009)(36860700001)(8936002)(8676002)(41300700001)(2906002)(82740400003)(5660300002)(70206006)(70586007)(4326008)(426003)(7696005)(478600001)(47076005)(2616005)(44832011)(26005)(1076003)(316002)(36756003)(40480700001)(82310400005)(86362001)(83380400001)(336012)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2023 21:58:24.8610 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f6ed33dc-c5bc-407b-1bf6-08db1e8de8f0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT034.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5193
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
Cc: David Belanger <david.belanger@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Handle case when module is unloaded (kfd_exit) before a process space
(mm_struct) is released.

Signed-off-by: David Belanger <david.belanger@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_module.c  |  4 ++
 drivers/gpu/drm/amd/amdkfd/kfd_process.c | 57 ++++++++++++++++++++++++
 2 files changed, 61 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_module.c b/drivers/gpu/drm/amd/amdkfd/kfd_module.c
index 09b966dc3768..8ef4bd9e4f7d 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_module.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_module.c
@@ -26,6 +26,9 @@
 #include "kfd_priv.h"
 #include "amdgpu_amdkfd.h"
 
+void kfd_cleanup_processes(void);
+
+
 static int kfd_init(void)
 {
 	int err;
@@ -77,6 +80,7 @@ static int kfd_init(void)
 
 static void kfd_exit(void)
 {
+	kfd_cleanup_processes();
 	kfd_debugfs_fini();
 	kfd_process_destroy_wq();
 	kfd_procfs_shutdown();
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index ebabe92f7edb..b5b28a32639d 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -1181,6 +1181,17 @@ static void kfd_process_notifier_release(struct mmu_notifier *mn,
 		return;
 
 	mutex_lock(&kfd_processes_mutex);
+	/*
+	 * Do early return if p is not in the table.
+	 *
+	 * This could potentially happen if this function is called concurrently
+	 * by mmu_notifier and by kfd_cleanup_pocesses.
+	 *
+	 */
+	if (!hash_hashed(&p->kfd_processes)) {
+		mutex_unlock(&kfd_processes_mutex);
+		return;
+	}
 	hash_del_rcu(&p->kfd_processes);
 	mutex_unlock(&kfd_processes_mutex);
 	synchronize_srcu(&kfd_processes_srcu);
@@ -1200,6 +1211,52 @@ static const struct mmu_notifier_ops kfd_process_mmu_notifier_ops = {
 	.free_notifier = kfd_process_free_notifier,
 };
 
+
+void kfd_cleanup_processes(void)
+{
+	struct kfd_process *p;
+	unsigned int temp;
+
+	/*
+	 * Iterate over remaining processes in table, calling notifier release
+	 * to free up notifier and process resources.
+	 *
+	 * This code handles the case when driver is unloaded before all mm_struct
+	 * are released.
+	 */
+	int idx = srcu_read_lock(&kfd_processes_srcu);
+
+	hash_for_each_rcu(kfd_processes_table, temp, p, kfd_processes) {
+		if (p) {
+			/*
+			 * Obtain a reference on p to avoid a late mmu_notifier release
+			 * call triggering freeing the process.
+			 */
+
+			kref_get(&p->ref);
+
+			srcu_read_unlock(&kfd_processes_srcu, idx);
+
+			kfd_process_notifier_release(&p->mmu_notifier, p->mm);
+
+			kfd_unref_process(p);
+
+			idx = srcu_read_lock(&kfd_processes_srcu);
+		}
+	}
+	srcu_read_unlock(&kfd_processes_srcu, idx);
+
+	/*
+	 * Must be called after all mmu_notifier_put are done and before
+	 * kfd_process_wq is released.
+	 *
+	 * Ensures that all outstanding free_notifier gets called, triggering the release
+	 * of the process.
+	 */
+	mmu_notifier_synchronize();
+}
+
+
 static int kfd_process_init_cwsr_apu(struct kfd_process *p, struct file *filep)
 {
 	unsigned long  offset;
-- 
2.38.1

