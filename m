Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2125B606A31F
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Nov 2026 21:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=pa+gEHHA
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5FF9C10E12B;
	Fri, 27 Nov 2026 21:46:16 +0000 (UTC)
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013031.outbound.protection.outlook.com
 [40.107.201.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7C84D10E12B
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Nov 2026 21:46:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UvaiWlPyeFb9+CKrnxf8tAkA+a8E5RbXAoIQxUhFXlS/GVZZEV7Ydw6vsMqaS3TOaltXW0bCkhlGIUiFWjo83CHiHPrTnyYGseBYaVbpQIYEfM/cYAu3FIhj4pnu718zVB7IudPzLc+HxLOdqgwCqGJ/d1bv6lUyozDN7FQQlWbJFmHQnVWp2QdJ9YCjqPRrPHMuk8BtQnH1u1t29WvBb5xivQeU9G6l78OwQb9hlq3uacGj8m35qXn9HXPhWGWGrrk3of+6QGRc+9StlELSUat9O8lLe4JYPgg8SPAXI9iW66toLvfhMrGlRfg/CtoFlRGlTyp22nUPpQEXNqpaVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GOKWFi/bmQ3LRRPardliOPfjHgJaNAoTNvhBZwdTxTY=;
 b=ImZ48vczc8SGVsjhvb4mxjR64hzFbG1yokGgcSrxqwWD+qv/hOX8rzQrKa2VAgnH9PzQYFqJ6I3Pg1Q2L2GhVUSlwkKeP+UXEIsSWizsYdcUKvcZijuQbdvJIOd1lm7HJ/gjlfITxEWtaIWLfq17sf84gQjDc/5W0HOyfqc6RA2dakIG5XXrSQFbVvothyMTblFKEx/nHWpISX4BDh17wsxTPTwvXL7TLvgoNFNkOPHaCDS5bVZZuFeQkQo99jgxyqEYisVulW877oNupq7ojmrM6On3C3jV7nA5WSDpDEeFL3EYh/9QAF4FI+yAd/MDk9c5VrS99ulpWY0g3pwlWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GOKWFi/bmQ3LRRPardliOPfjHgJaNAoTNvhBZwdTxTY=;
 b=pa+gEHHAwKvgoaKKNJUL4PSJZ4rO3xd6gLYFWlQbYw5KuMzUNN5zwuP0vWbOyCnv0lf+Zug63+53HN0f/Z8IxmP3wftrFffClIs3BhzTKo7dAFsBsntZfDkXWTBAOmqQPUsdm3R4VkCfhWfIvxWe8QETpiN2nEtCV9hKyNtAV8Y=
Received: from BY5PR13CA0025.namprd13.prod.outlook.com (2603:10b6:a03:180::26)
 by SA0PR12MB7076.namprd12.prod.outlook.com (2603:10b6:806:2d5::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.9; Fri, 27 Nov
 2026 21:46:03 +0000
Received: from SJ5PEPF00000204.namprd05.prod.outlook.com
 (2603:10b6:a03:180:cafe::85) by BY5PR13CA0025.outlook.office365.com
 (2603:10b6:a03:180::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.688.6 via Frontend Transport; Fri, 27
 Nov 2026 21:46:03 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF00000204.mail.protection.outlook.com (10.167.244.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.688.5 via Frontend Transport; Fri, 27 Nov 2026 21:46:03 +0000
Received: from 0yonsun-linux-dev.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Fri, 27 Nov 2026 15:46:02 -0600
From: Yongqiang Sun <Yongqiang.Sun@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Yongqiang Sun <Yongqiang.Sun@amd.com>
Subject: [PATCH] drm/amdkfd: refuse XNACK for a secondary context
Date: Fri, 27 Nov 2026 16:45:44 -0500
Message-ID: <20261127214544.1058794-1-Yongqiang.Sun@amd.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000204:EE_|SA0PR12MB7076:EE_
X-MS-Office365-Filtering-Correlation-Id: ac5b0704-3c6e-4c71-fde8-08df4ccfd56a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700016|1800799024|23010399003|11063799006|261009223027099003|18002099003|10067099003|56012099006|261102123227099003|261021123027099003|261026140227099003|261021121427099003|261028144727099003|261026121527099003|261022105027099003|261022075727099003|261022115727099003;
X-Microsoft-Antispam-Message-Info: YaKbV42DFdPSHgMDzrw7wCJTOr6s54hkstceXKH/PjC1A16nur/aPIzFIDdPt8XEo3jVk6vnhDHPPN2q5gu6Sa9dKEDluUu0suBHc9B9VnET+irbVxWSr7o/Q7l5DVGiy1VtLHGTjLVt1VN38Aaa4BrE7vimcCxMwP0PyFvQ1MSQY8x/G+KoCdI/E/2sIFFkJ4SHAJwrlnMILzZGGKyabVS/CYKfk3joSHrNQ17lU/MjKH4NCRckwcATLitXxFE+TfgLYqmYPmyFMmkWVHWY+jsVWTlhMbEX48yYcZEcS8pd+GGAmVoc0B4ZMF5Svz7nn3PoFdDqTs1Atk1LmixJKZNKoseO22Mu4ucSvNplixqUymYWcikzIQVoNaqDIjflSHoq4IP3SqE6+RkfY4s0+zczV9Evb0A4xzIP2881k+ww4lPkidcxfRp93odbvcNzmVFVkVIrN1z/Oq4v39PzoFntlEbYorVMu/wtJJeDJmsGObh7MpQgTbe6WZzcai80VreYuS5BvnQOFkFQaNejKWrjtgNb/vU6RPLxCaaTYiMK0CqS9VMiUugeiPYkm7IROpz0GECS4ZDeeLxwhzd5g7YCss1HTGNqoFc9fF89uvL1VGJ7ce3DDoBVnmnXJ8eUO2r0VpEgkN6h9cNrILAasYNcafMFD1HK5Wpa/7+vS6cNPNcv2RVYsQ8/EBqHzGahTwyzk/QVyOIW8s0NtSXJNw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700016)(1800799024)(23010399003)(11063799006)(261009223027099003)(18002099003)(10067099003)(56012099006)(261102123227099003)(261021123027099003)(261026140227099003)(261021121427099003)(261028144727099003)(261026121527099003)(261022105027099003)(261022075727099003)(261022115727099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Qn0AwInFCe0oWSzy0DxAtdkq/YocZhyT/qkLuUKB+xJxcDHBQ5VWRConIMU8iQoUDqaAanCDVwDLfhQpW0dPjlGFaeT6xJViuS18JGT80zWlJA53ntzmZ02/xTOSYi04lOYkEhbED343aQny1e6LoM/PdETe45yEPblJTYH+5MakQs2DOaugIdn2LWDgIQ26JA9arXRWBqenDdY3BQPLvaPmIrMP/fMyUBuG8Egt/mJO8F3y134/EzTDFImMZnn34O2sioTTbCu1O5u7Bo5ggJMsGLEOzhlI+arh+H7Q+ZLZGMWb5Lpo4RTgh/IAUR7mWSpNl+csDcydK2do7xxQgKzf4coRCYiffadcsJ6mcdoExbRhX5f4yH/dNISp8t/gUOJIPgQZb4TxmmWRK/liYwPmo/5wOCBKj08W/9qKeJY+h923CnHbAsBmiN/ljiI4
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2026 21:46:03.1670 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ac5b0704-3c6e-4c71-fde8-08df4ccfd56a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF00000204.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7076
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

A secondary kfd_process shares the caller's mm but registers no MMU
notifier and is not torn down when that mm exits. With XNACK enabled,
svm_range_restore_pages() still maps host pages for its PASID, and the
queue keeps those mappings after the pages are freed.

On an unpatched gfx942 kernel, a shader on the secondary context stored
to an unmapped malloc buffer, the process exec'd while that /dev/kfd fd
stayed open, and the GPU then wrote 0x5a5a5a5a into 64 KiB of memory
owned by the new image.

Do not enable XNACK for a non-primary context, reject
AMDKFD_IOC_SET_XNACK_MODE that asks for it, and drop a retry fault that
arrives for one before any host page is mapped.

Signed-off-by: Yongqiang Sun <Yongqiang.Sun@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c |  4 +++-
 drivers/gpu/drm/amd/amdkfd/kfd_process.c |  8 ++++++--
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c     | 10 ++++++++++
 3 files changed, 19 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index ae5b430a00310..b589f8eaa0832 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -1775,7 +1775,9 @@ static int kfd_ioctl_set_xnack_mode(struct file *filep,
 		if (p->xnack_enabled == args->xnack_enabled)
 			goto out_unlock;
 
-		if (args->xnack_enabled && !kfd_process_xnack_mode(p, true)) {
+		if (args->xnack_enabled &&
+		    (p->context_id != KFD_CONTEXT_ID_PRIMARY ||
+		     !kfd_process_xnack_mode(p, true))) {
 			r = -EPERM;
 			goto out_unlock;
 		}
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index 5dc657f32d38c..0c153f9951b38 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -1782,8 +1782,12 @@ struct kfd_process *create_process(const struct task_struct *thread, bool primar
 	if (err != 0)
 		goto err_init_apertures;
 
-	/* Check XNACK support after PDDs are created in kfd_init_apertures */
-	process->xnack_enabled = kfd_process_xnack_mode(process, false);
+	/* Check XNACK support after PDDs are created in kfd_init_apertures.
+	 * Only a primary context is torn down with its address space (it owns
+	 * the MMU notifier), so XNACK retry faults must never map host pages
+	 * into a secondary context.
+	 */
+	process->xnack_enabled = primary && kfd_process_xnack_mode(process, false);
 
 	err = svm_range_list_init(process);
 	if (err)
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 32f2ca5b1fdfd..f48eea7cc9e92 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -3158,6 +3158,16 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
 	}
 	svms = &p->svms;
 
+	/* A secondary context has no MMU notifier and is not torn down with
+	 * its address space, so it must never map host pages on a retry fault.
+	 */
+	if (p->context_id != KFD_CONTEXT_ID_PRIMARY) {
+		pr_debug("retry fault on non-primary kfd process, pasid 0x%x\n",
+			 pasid);
+		r = -EFAULT;
+		goto out;
+	}
+
 	pr_debug("restoring svms 0x%p fault address 0x%llx\n", svms, addr);
 
 	if (atomic_read(&svms->drain_pagefaults)) {
-- 
2.43.0

