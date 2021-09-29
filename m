Return-Path: <SRS0=/upn=OT=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2628DC43219
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Sep 2021 12:01:25 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB55561452
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Sep 2021 12:01:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org EB55561452
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B742F6EA52;
	Wed, 29 Sep 2021 12:01:19 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2069.outbound.protection.outlook.com [40.107.220.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A00A06EA4B
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Sep 2021 12:01:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L92qfjdTy77CVWDKo22CjUlRJybTLdAbhlJribDKufEXfLqfdkStGyMaC3pL1AsJOD/P8+pm4ByIoJGHehvhudtv/rn+A0UhQqOO7rW94qidiQKhTkzFXg8q2lr2xY0QWzZ2JOjeCyf5JFxgN40ZCEy0GIw/w0GzvsGuqJF5KpSHG1M8L2u9o377BkqSfXW9i/lr+iNBsDBqE2AbdVDJKTM2ciXQ4QkoQaY8ySpsghpKCAldjqgUhdpeAGaznl1+6PCmy9eTPDpGZc5isAtb83ZuHlDybdz4ErpnZyf399j9i5ZNLVuzzvIav6qjeNyESwxlwYpVnvCcZkvStUQoCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=p7w446LnnXRyBxIfL+1HEr2XfVVcQ4dWsQqqpmAbSnM=;
 b=Hg9kETBlUIy2elVCKIVwTv2NTB5SEtLkFyfAXb2Z+vPCu1Pqps56QWz5T+xOvxFEu9YtPoiKhbpf8A0yCWNEKLogV4lY2oa3UZGjEnMIGYHCNj49/VsH0DWBBR78MInQgxovfJOsi2QGif3ZLrqgWVQlGxFADNcNmUiG7f4M0iZc2nfP3zW370wG4NcjSYsj7LttCpSc5/AI9CqGkEKkAJYirqZ8zWaD1g97RriI6aK0mrelglclfwhM+b3ncn/IXkWVOQ1vXE5NUkdyACzzaxnPjAq6f9Liqy+2dC9ry4n7yCI6+C2yhNdPEa3POSyorhX0jTcbyEZ/gbOc1Yz6Ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p7w446LnnXRyBxIfL+1HEr2XfVVcQ4dWsQqqpmAbSnM=;
 b=RcppX5prtcWyJV5Ty2YQX4bEnz7v70246oM1APJZqMyY7aH6nTSe/ZXTLah3uAS6bbcBg8Dnka+bkDWXoCmHv7iHb4PfPM80UCt9PpekGO3Mq3ZG1gDafLF/LTijem+Efzq5HZWvGnOwDxzt3k8ADtyEhETniZOv6fYynipxz5c=
Received: from CO2PR05CA0074.namprd05.prod.outlook.com (2603:10b6:102:2::42)
 by SN6PR12MB2814.namprd12.prod.outlook.com (2603:10b6:805:72::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.13; Wed, 29 Sep
 2021 12:01:11 +0000
Received: from CO1NAM11FT008.eop-nam11.prod.protection.outlook.com
 (2603:10b6:102:2:cafe::52) by CO2PR05CA0074.outlook.office365.com
 (2603:10b6:102:2::42) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.7 via Frontend
 Transport; Wed, 29 Sep 2021 12:01:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT008.mail.protection.outlook.com (10.13.175.191) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4566.14 via Frontend Transport; Wed, 29 Sep 2021 12:01:10 +0000
Received: from dayatsin-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Wed, 29 Sep
 2021 07:01:04 -0500
From: David Yat Sin <david.yatsin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: David Yat Sin <david.yatsin@amd.com>
Subject: [PATCH v3 07/16] drm/amdkfd: CRIU Implement KFD pause ioctl
Date: Wed, 29 Sep 2021 08:00:29 -0400
Message-ID: <20210929120038.6485-8-david.yatsin@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210929120038.6485-1-david.yatsin@amd.com>
References: <20210929120038.6485-1-david.yatsin@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e166e9d4-e6ee-4250-02ce-08d98340d3fb
X-MS-TrafficTypeDiagnostic: SN6PR12MB2814:
X-Microsoft-Antispam-PRVS: <SN6PR12MB28144CA5B4EB662447ECD8D995A99@SN6PR12MB2814.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rGw92UdMJZUfF1p5HbHF0xHCm2fFJ0T61JJTe2cRv6vbJHeeN+sR7FE3cON64QA+UXqK9mTprKjYNBbX/Y2wR07Va/By7PoZvxtpHNtTLXUpUldfPV8AnoybEEzqxGxF+XUGWCUiSdKQX6WQy7gzjspFcslWh2I8VD8/LYg4h35RRJEP9XqE+qiS1LvfScjU3vnN6FoAqQmQsP+NumIeLqK5uF6GkkSE17vjmlaRvPeGXsTmLq3qOZaTWQWyzDL3YOqnUAFX9j3hRgymjYDApiN5ZApU26j25RS5S/65243gFA1pzhwWIeSpMWjxRkmGP3i0pzWCLiB/sC9nk0PpDS3iSAL4xt/8Bpxp+G1g4HWjkHI3hqXsh1rS4TnlTSkOMSc+unvhGam8p7sLAqTwF2J2XpIOxMRi+EEIlSolcFTp/uTV+VQHVVkuMvgFBHgEmP7FU1yNgy1YBZAhTmjrSnN14FolWWt4byPLMz283KY5ieUmxsF3Uzh4DwQEraG7+6Kmvzax8EEawCZgY1lelpWlIWLmmExfPpL4yLS2Upxmh0Lb1DOEeazhaeIf+xJd8hCqSuRAVA2FPXPSyVITheurlgdLmmTTXd3Pbrasq8TnOnsIBZxDmQIF5oHODVNQx2HoQ0z5AuKrKJvyc5wKFdzAJ3e7dCxDCnh3Poa9KyNPjNBK4nu9MMLK7sGsII6nq0W9FYM/nqXjynNVS1ktil4OKMh00PQtDw7DBRzzVj0=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(4326008)(8936002)(8676002)(16526019)(36756003)(81166007)(186003)(356005)(36860700001)(426003)(86362001)(70586007)(70206006)(2616005)(83380400001)(6916009)(6666004)(82310400003)(47076005)(26005)(7696005)(1076003)(2906002)(336012)(316002)(508600001)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2021 12:01:10.5675 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e166e9d4-e6ee-4250-02ce-08d98340d3fb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT008.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2814
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

Introducing pause IOCTL. The CRIU amdgpu plugin is needs
to call AMDKFD_IOC_CRIU_PAUSE(pause = 1) before starting dump and
AMDKFD_IOC_CRIU_PAUSE(pause = 0) when dump is complete. This ensures
that the queues are not modified between each CRIU dump ioctl.

Signed-off-by: David Yat Sin <david.yatsin@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 23 ++++++++++++++++++++++-
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h    |  3 +++
 drivers/gpu/drm/amd/amdkfd/kfd_process.c |  1 +
 3 files changed, 26 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index 668772a67f7a..791cb1555413 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -2027,6 +2027,14 @@ static int kfd_ioctl_criu_dumper(struct file *filep,
 		goto err_unlock;
 	}
 
+	/* Confirm all process queues are evicted */
+	if (!p->queues_paused) {
+		pr_err("Cannot dump process when queues are not in evicted state\n");
+		/* CRIU plugin did not call AMDKFD_IOC_CRIU_PAUSE before dumping */
+		ret = -EINVAL;
+		goto err_unlock;
+	}
+
 	switch (args->type) {
 	case KFD_CRIU_OBJECT_TYPE_PROCESS:
 		ret = criu_dump_process(p, args);
@@ -2363,7 +2371,20 @@ static int kfd_ioctl_criu_restorer(struct file *filep,
 
 static int kfd_ioctl_criu_pause(struct file *filep, struct kfd_process *p, void *data)
 {
-	return 0;
+	int ret;
+	struct kfd_ioctl_criu_pause_args *args = data;
+
+	if (args->pause)
+		ret = kfd_process_evict_queues(p);
+	else
+		ret = kfd_process_restore_queues(p);
+
+	if (ret)
+		pr_err("Failed to %s queues ret:%d\n", args->pause ? "evict" : "restore", ret);
+	else
+		p->queues_paused = !!(args->pause);
+
+	return ret;
 }
 
 static int kfd_ioctl_criu_resume(struct file *filep,
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index 881af8e1b06c..e0601bfbcbf2 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -868,6 +868,9 @@ struct kfd_process {
 	struct svm_range_list svms;
 
 	bool xnack_enabled;
+
+	/* Queues are in paused stated because we are in the process of doing a CRIU checkpoint */
+	bool queues_paused;
 };
 
 #define KFD_PROCESS_TABLE_SIZE 5 /* bits: 32 entries */
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index 65a389fb97ce..0f7c4c63ee99 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -1314,6 +1314,7 @@ static struct kfd_process *create_process(const struct task_struct *thread)
 	process->mm = thread->mm;
 	process->lead_thread = thread->group_leader;
 	process->n_pdds = 0;
+	process->queues_paused = false;
 	INIT_DELAYED_WORK(&process->eviction_work, evict_process_worker);
 	INIT_DELAYED_WORK(&process->restore_work, restore_process_worker);
 	process->last_restore_timestamp = get_jiffies_64();
-- 
2.17.1

