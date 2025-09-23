Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB509CAC5A7
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Sep 2025 07:27:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3D78E10E580;
	Tue, 23 Sep 2025 07:27:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="SLXaOVC4";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012028.outbound.protection.outlook.com [52.101.48.28])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EE3F610E586
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Sep 2025 07:27:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N8B+QW8keBCWex2u4HI0IL9d2X6vzCJRJjO2m100dtVuvQCezTezOrMX5B8M7JcvcTsizKJZD+2/M4RBEMF3LkVDAK1cR5LO9MmXecNBh6gLTuBGlMC9WHG2pIi5Q0QWURraLlwCtmNRllaiB1m53yfutbpkqoiF4jF+oYzBW7nLFwX27Y0upgd2podXX5I3XdFKKfRGU50joU5fLMp705bV8UK6Ul4TvsXTq2J+QSIeO3c4TJJgK41H6HPW8jLzapSx6DS7fBGB0HT7nayCyQqxnotpjAPJDBMizkO8MsfQgscD1a3GMV3RRGgIEunPcgcYB9IJop5MLCX5FKEP7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gGi8SY3QM5jayZFJ0tjCVxKlgbCCECNlwpwefOIvdHI=;
 b=BzropyX0NNptIMsUIIx5DSqJXAWdg2C83CHkf7bT1gCqSlU358YVPHzWD2BNZwoZxAL3ObCx3wJhrsplnHDYDrGn4Vbjyu4hT3blIyIKzt2CA9eaemjNtYxHdTKTBcccIZLp3jSdnKTACDCSZgrPb8e9upk50qKvMAn6WnNROxuBD1tmJk10Trdke+OeROUh+OQxw6yM8jZqCStNu4Ep5y6JB4bR03Cjtvyj3jFO6d11lrR+X2VUAE5rgwTq/ktNfdHl01ayV1kT4h4zSPG2nTpe1c8SGutQdaEGS7fOja38EkhmQxVlU1r9uTB5TSSAoHz8TplWokBWWiir4qDIYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gGi8SY3QM5jayZFJ0tjCVxKlgbCCECNlwpwefOIvdHI=;
 b=SLXaOVC4zSieAYc+aRopDg9q4xL6pgREF0InKjAHydzwMzRV3lTYBUOo8FWrtXcrUKiRXMXEKoFsNGZZiap4e8WLsNwDvORtAl34tfTczD2U2Zoi9HId1zRirBMAZsrLjF/EDYSNI87UfkdGCHRIn4MeqsyNZ0h4t/Ak7o6JaAQ=
Received: from MW4PR04CA0096.namprd04.prod.outlook.com (2603:10b6:303:83::11)
 by IA1PR12MB6386.namprd12.prod.outlook.com (2603:10b6:208:38a::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.19; Tue, 23 Sep
 2025 07:27:02 +0000
Received: from SJ5PEPF000001EF.namprd05.prod.outlook.com
 (2603:10b6:303:83:cafe::a6) by MW4PR04CA0096.outlook.office365.com
 (2603:10b6:303:83::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.20 via Frontend Transport; Tue,
 23 Sep 2025 07:27:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001EF.mail.protection.outlook.com (10.167.242.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Tue, 23 Sep 2025 07:27:01 +0000
Received: from fedora.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 23 Sep
 2025 00:26:59 -0700
From: Zhu Lingshan <lingshan.zhu@amd.com>
To: <felix.kuehling@amd.com>, <alexander.deucher@amd.com>
CC: <ray.huang@amd.com>, <amd-gfx@lists.freedesktop.org>, Zhu Lingshan
 <lingshan.zhu@amd.com>
Subject: [PATCH V4 17/18] amdkfd: set_debug_trap ioctl only works on a primary
 kfd_process target
Date: Tue, 23 Sep 2025 15:26:07 +0800
Message-ID: <20250923072608.252345-18-lingshan.zhu@amd.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250923072608.252345-1-lingshan.zhu@amd.com>
References: <20250923072608.252345-1-lingshan.zhu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001EF:EE_|IA1PR12MB6386:EE_
X-MS-Office365-Filtering-Correlation-Id: 711b8699-515b-4180-1e91-08ddfa7296cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Ud8JsqhN2T6ozwhso48BrqiKahw6qXSsXoWFHK6kKbY+OlY3cGsjuLbYz9qg?=
 =?us-ascii?Q?2xcYMjoAk+BJ7CioEGJGA9fntNbp61utLqKRdUnpEr7gZWUpIE0GXFliBsFU?=
 =?us-ascii?Q?o5Yd1no9iwFGLrBrMgCngHlRWdG8dhJWCNRp1fioIP17YWtBVydaqxDx/gDG?=
 =?us-ascii?Q?Ul2R9Et/pAYKqsSUfZwSXsCWJCpaU8uISTMS8p9KeQeouinP9G/pILC+6o0J?=
 =?us-ascii?Q?T7lzw9B2ir+ylkgA4ODmAy7Oh9akDz4e1N0BkrUdCRUKrpK151ls7fqmjrq6?=
 =?us-ascii?Q?tK9Cc6DPulNkTwS7sCG4QxUFicqLJogt5N/WmfP1eid4z5bTOgg36i/UTGXm?=
 =?us-ascii?Q?5461Rr1GBOhxNOYPRXhAMHakGVfEiiqx5sip8aHFVn85w5EhdnImMEdxf9H9?=
 =?us-ascii?Q?PlW1DKbx0iUTpSUBxuDJjIcjGyu3I3ME3QqERLMVt1ejkCoJvkRVsdPt/eQq?=
 =?us-ascii?Q?aJSKU8lNhsnxFNfnH45yVrRh6yPlJpbxK4aBU1ywPeFcFwQQ/zWvGb0ikcm/?=
 =?us-ascii?Q?CVpLMAJapxFxRqtx0xmwy1gA2i3BQATMMoK33IcC1k7q/vanao0LDoa7ruwW?=
 =?us-ascii?Q?X83FLlAEUCtSvk9fMlSXt9tLFOupz2ng168TbpwMaUCTnWbYOCWd9ZNThA3h?=
 =?us-ascii?Q?QqrYfiotjZpMbycMyS7M7xrO9AGoJs0u/kEr+WVh9VQQkJ/UGDXClI2q5I1J?=
 =?us-ascii?Q?mQ8cYyK8JIgvBAuPahBdADDBKFrPIWm2Z4jsVvqG0m4o3SSx4XOVBh1ho15S?=
 =?us-ascii?Q?XCTMcQtUvCKxo45eKZkQVDHgaMkNAqWeHepnfsJMeB1SfMg1fe4/cwPMPJR0?=
 =?us-ascii?Q?8JN8VnlapraMB9sbapKFBYICr0k5rqptmp9JP+7CtfBGOmiCT4PYAR4Iqcm6?=
 =?us-ascii?Q?AOD1pC8/feCFpqtTdoZgKcJmUnAP4GuavHo29NJDdxK8TMQAlenPUlpJZISi?=
 =?us-ascii?Q?vizfjFRm06dNKJL7WLwI6XHGLweMwOsCeDcKQQh60vHh1mZ/3LEJgeo+vTQk?=
 =?us-ascii?Q?zXisTkP9/EwEY/T6hGwoo15PoLlir/eCuhPTNP59nZaBB1w7vzkW97rWmfoH?=
 =?us-ascii?Q?6cbEqBz4Lr7Tw7+/apqpv4SbvAT8c6UZC40+m4vMHliGKzIFH7j2VPtYT1wr?=
 =?us-ascii?Q?ZrFVNHJae4nLCBrGTfB6ofTuKlUyxDCByXlUR+e2suucjt0Lygf1X/hX4wi/?=
 =?us-ascii?Q?0DwVgKxrdWdauLdYnAjzfIDv9JduZArlhwiJdu2rtROPjPrPCelC8LtrrNJa?=
 =?us-ascii?Q?AjSUYi5yJnJozTJEQ9z+Z/dR7U2mm4lMuyVeZqbmHssbXYHwRe4nf4Okmz1O?=
 =?us-ascii?Q?fNGAi8QxBWpGkEqbat1+qpdAQkBSSuwiTarVfXZoBhwzm5ULQQ1dCAAqHBMH?=
 =?us-ascii?Q?NlocbAauLWW9uKOzczKLXkvK8dB9coSNaU3tSfz5hCLcn+ohwcPgHgVfCtmx?=
 =?us-ascii?Q?MnROCZvdYpnBmMfZssOjfFh9BlKn65GLn1tYwRzPlxGWpHCLk9FToRr+9PpD?=
 =?us-ascii?Q?ogoMQ1NGHFruPyZWch8m8ubmMKIbQdJwwAbC?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2025 07:27:01.8238 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 711b8699-515b-4180-1e91-08ddfa7296cb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001EF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6386
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

The user space program pass down a pid to kfd
through set_debug_trap ioctl, which can help
find the corresponding user space program and
its mm struct.

However, these information is insufficient to
locate a specific kfd process among the
multiple kfd_process that belong to the
same user space program.

For correctness and backward compatibilities,
this commit only allow set_debut_trap ioctl
work for a user space program which does not
own any secondary kfd_process.

Signed-off-by: Zhu Lingshan <lingshan.zhu@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 29 ++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index 662b181f1fd2..2df095e25c2e 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -36,6 +36,7 @@
 #include <linux/ptrace.h>
 #include <linux/dma-buf.h>
 #include <linux/processor.h>
+#include <linux/fdtable.h>
 #include "kfd_priv.h"
 #include "kfd_device_queue_manager.h"
 #include "kfd_svm.h"
@@ -2918,6 +2919,25 @@ static int kfd_ioctl_runtime_enable(struct file *filep, struct kfd_process *p, v
 	return r;
 }
 
+static int kfd_process_count_cb(const void *num, struct file *filep, unsigned int n)
+{
+	u16 *ret = (u16 *)num;
+
+	if (filep->f_op == &kfd_fops)
+		(*ret)++;
+
+	return 0;
+}
+
+static u16 kfd_process_count(struct task_struct *thread)
+{
+	u16 count = 0;
+
+	iterate_fd(thread->files, 0, kfd_process_count_cb, (const void *)&count);
+
+	return count;
+}
+
 static int kfd_ioctl_set_debug_trap(struct file *filep, struct kfd_process *p, void *data)
 {
 	struct kfd_ioctl_dbg_trap_args *args = data;
@@ -2927,6 +2947,7 @@ static int kfd_ioctl_set_debug_trap(struct file *filep, struct kfd_process *p, v
 	struct kfd_process *target = NULL;
 	struct kfd_process_device *pdd = NULL;
 	int r = 0;
+	u16 process_count = 0;
 
 	if (sched_policy == KFD_SCHED_POLICY_NO_HWS) {
 		pr_err("Debugging does not support sched_policy %i", sched_policy);
@@ -2984,6 +3005,14 @@ static int kfd_ioctl_set_debug_trap(struct file *filep, struct kfd_process *p, v
 	if (r)
 		goto out;
 
+	process_count = kfd_process_count(thread);
+	/* The user space program has secondary contexts */
+	if (process_count > 1) {
+		pr_err("Detect multiple kfd_process owned by PID %i, please consider close any secondary kfd_process and try again\n", args->pid);
+		r = -EINVAL;
+		goto out;
+	}
+
 	mutex_lock(&target->mutex);
 
 	if (args->op != KFD_IOC_DBG_TRAP_ENABLE && !target->debug_trap_enabled) {
-- 
2.51.0

