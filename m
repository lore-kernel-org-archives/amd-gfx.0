Return-Path: <SRS0=P/1w=P4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95593C433F5
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Nov 2021 23:05:12 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4AEB360E73
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Nov 2021 23:05:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 4AEB360E73
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8053F6EC70;
	Tue,  9 Nov 2021 23:05:11 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2077.outbound.protection.outlook.com [40.107.236.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A002A6E8F1
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 Nov 2021 23:05:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z7awbeKgInDxAlwU74HVbm//Cja+JO0JFL/TQrPekbSICw1fAxWlmM9R2T6A9hinzSVqbqxUSnqGin8svnNLvJ9Oy+kxdpdbm6fG4U6rFaLjXR2YZphs8lzlW6sGsqXXKVK3PlJTbKmheF9lDJXtgYK5MenNLEswPS2Yy5F9CVGCJ5vw7rB9EkBpomJXlvrOH06/diq4YsWfmjQx5Xo/SU1rk+OitYzxmWNqJSzLEcUqIKk1bxvCz47HonWRpz4UQzFcP6KjoBwSVRExNio9mwgaUjhFO+AsYXhpg5fXf0eAcbXipF8aZrpvyE86pwh40rhyoEwJLJ8VGe9+/9MLvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aJ8ciKlT9/R+LMbEo1I1F7ka5t9rFwG7qyWQvngvvw8=;
 b=bFQQqJidtNIjt3Y8+hmXu8AIiz212uNJcBHtq/lSsFvp0f2inXevS0gdzzG7ao0U0yG44tNub5OxV/zNRBjlc7c3JGU19LNTeqpKwfWPxtVMcsWEK5K8/eDMI8pbuDffJJ0YAbbRqjPpyraTtbuGj713KlVaX3W3GLLpACqaBSkqt9/VEV+qoimCROVT5W89SPUoJtSk38tIkvGG+7EgmI7mxNHfZWHKWNqSk0VibDq/mNCzYHPAqhgctlzslSVycxIxoASRZlauLfO12Gt1OD27BBtJr8txq27RcTagiRQLnI85g7ZoAI4tg+tljrWrsDAHalFsk6/6GMgLKlR//w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aJ8ciKlT9/R+LMbEo1I1F7ka5t9rFwG7qyWQvngvvw8=;
 b=wmrJDAiaqlhX3dssCPyGEyWeS85ZZ65LIexoBhz6VpSeHnCYaoPdNZ7reOShQWQ+1HIMCobRA9NXDYX7Wenm021Qc5ZNbe96/T3mffXX1ttUfExuFxl6RxfGxq1sWjzY5/3N4vpwIl/24L5iJohmgwhFRCpEHKg1A49z1XPqPUg=
Received: from DM5PR06CA0049.namprd06.prod.outlook.com (2603:10b6:3:37::11) by
 BL0PR12MB5537.namprd12.prod.outlook.com (2603:10b6:208:1cc::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.15; Tue, 9 Nov
 2021 23:05:08 +0000
Received: from DM6NAM11FT024.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:37:cafe::57) by DM5PR06CA0049.outlook.office365.com
 (2603:10b6:3:37::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.15 via Frontend
 Transport; Tue, 9 Nov 2021 23:05:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT024.mail.protection.outlook.com (10.13.172.159) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4690.15 via Frontend Transport; Tue, 9 Nov 2021 23:05:07 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Tue, 9 Nov 2021
 17:04:54 -0600
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/5] drm/amdkfd: check child range to drain retry fault
Date: Tue, 9 Nov 2021 18:04:29 -0500
Message-ID: <20211109230432.3947-2-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211109230432.3947-1-Philip.Yang@amd.com>
References: <20211109230432.3947-1-Philip.Yang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f33c9057-a824-48d1-4eba-08d9a3d55fd2
X-MS-TrafficTypeDiagnostic: BL0PR12MB5537:
X-Microsoft-Antispam-PRVS: <BL0PR12MB55376B43FD730103BC8A5F99E6929@BL0PR12MB5537.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2449;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: S2C6fgqfSzccS2KULLqrNAoBoEw6iI2z05zjqcTBRBBWiYo3S3N13XTUObQozZi/uS5Gazfh494fKBF31HqMEDB6pSii0kqwV8eXMePQrVsYT+4/TAbGeDjqS/nqtcoa+j899Tmo33o+TuPwAcBPznK0dIYZJJzDidGU029g6u49qM8gFhexhuiFVq5R+dB2hAJE9FeoKWpynKIZ/hCTc91UNipKxB/dkij3E6OfSm4cjVfG34LF5fEZjSCrGOb+MbwAFO+D9/rtIgLoAdVrJUTty/ref3wCStZVzNv+8WA6IfLBKbTF1VbEAV/wDSUpJnFhso8sSqHkauEm56CHtMJV0nGofw0lJRtyKKUiUxjVQu7N01LC0aYBg7eUnVGnhScx9Jzh98D+EgQjEb1G7ZriELWY2QD+dv/cc1TV5kMhiYLndvVQtkBGs8gNbDikPUlh28UEBIqIIuAK3Zh5WIDnIk4njAYrjvHc5ZsU1i5NYYjw90W25B+ZRzFHcHBotf5agJf3GbGNtSdJcrOKLS28LP/daQZVjOP/igJUqPEaBbf22YcpztBx6a0LoMuR3UmLcaGdn1CqqDFuMqCx+e+Go63uHquVhzt8SYht/yTsyR0Ot/qR9rvPTux0ouedQdkDc8Gd6lV54c/aIOHbhTBzsYIIk7AXfXSvE1EI50WQIM4eQ5GKqtqNaULXLOYiMS0lk11xoI8+NQ50su4qJzFT25d5PcpvpwJOzSkNy6g=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(26005)(70586007)(70206006)(16526019)(5660300002)(2906002)(47076005)(83380400001)(426003)(316002)(7696005)(82310400003)(508600001)(6916009)(54906003)(36756003)(336012)(186003)(81166007)(86362001)(1076003)(2616005)(8936002)(8676002)(356005)(4326008)(6666004)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2021 23:05:07.7807 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f33c9057-a824-48d1-4eba-08d9a3d55fd2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT024.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB5537
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
Cc: Philip Yang <Philip.Yang@amd.com>, Felix.Kuehling@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

If unmapping partial range, the parent prange list op is update
notifier, child range list op is unmap range, need check child range to
set drain retry fault flag.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 77239b06b236..64f642935600 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -2049,8 +2049,19 @@ svm_range_add_list_work(struct svm_range_list *svms, struct svm_range *prange,
 	 * before the range is freed to avoid straggler interrupts on
 	 * unmapped memory causing "phantom faults".
 	 */
-	if (op == SVM_OP_UNMAP_RANGE)
+	if (op == SVM_OP_UNMAP_RANGE) {
+		pr_debug("set range drain_pagefaults true\n");
 		svms->drain_pagefaults = true;
+	} else {
+		struct svm_range *pchild;
+
+		list_for_each_entry(pchild, &prange->child_list, child_list)
+			if (pchild->work_item.op == SVM_OP_UNMAP_RANGE) {
+				pr_debug("set child drain_pagefaults true\n");
+				svms->drain_pagefaults = true;
+			}
+	}
+
 	/* if prange is on the deferred list */
 	if (!list_empty(&prange->deferred_list)) {
 		pr_debug("update exist prange 0x%p work op %d\n", prange, op);
-- 
2.17.1

