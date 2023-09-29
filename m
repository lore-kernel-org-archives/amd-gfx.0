Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A85BE71D3D
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Sep 2023 14:12:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A4C0910E153;
	Fri, 29 Sep 2023 14:12:13 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2040.outbound.protection.outlook.com [40.107.223.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E77D610E139
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Sep 2023 14:12:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VTiYu++gXVJUbHWJoLVSCAZZQK9YDWNFfQgOMVTzK6M0y4a8pmIW3HgTag3Hzv8rzxJARzd7uzDp56sy5HVefH37dnflShjXiZzDGozvV6vhprNJLqMY4Jn44qme+SgcTQcurT3v863+7fMJq2EX+aAZe4yeM0m1C4Z61Z3f8K2mRAs5wqUcWB9Eut8maNK1MRnd97d4qBVKYYIo1hE5U2ueBjIFsLKGWmOSiPoHLnz/5P4+uRo8t4tLiUoFDGCpSlQ/I4aUi0haXaLXm/26hsasHMrMvWRIBXo9ebjOqoEl+1VhTC2r9mMy3j7p9guZrd3vmdpJVAhZcPPtjb3DQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MRVqD3OC+fH3gijIsTbXAInY6RZ3RoBGGoOrK41Wx9o=;
 b=MY2c2sCnq6yJ0UiCyuw9DHrT74NodqzgoCUqeyFYJYnCGbtjyyHGAvh1LARbo9Hq/i1idxQWfO0+O2oFj2xsw66PHNCh7i6gfpYgDHH5ctIpX3TBCvhr0tCev8Rvi9jP2+x6OKHXPYaIsQD+LzDZyg7qTpYnfcVsylh9XEfBKL6vuqrmzSHlwCD730GY4eHw5O93zffdTj8ivETAtLqU1x+/KhrvonOr+XIdhSNoZAudTN9hTAA79KKBOrZQvOVscKLib5LQnjTBNeLYeEsqKMFBO9kN1XPSlGdvKhrSvRpyZ3d/nivZIu2tuN/Ct3i7Qtb3RbwHQj4bYNSVxRkytg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MRVqD3OC+fH3gijIsTbXAInY6RZ3RoBGGoOrK41Wx9o=;
 b=RkUX/dRqzspLa2P8dmEeErRDlFmAwbiBLj8aWWoX9b5jZZEU6pmLuoY1BlyMRpI0Pe+sd29CpXndMhFxZNKlFVPkFHqzK0pyOShVfVN11N6+IqPoh0ezJaIYtltgUgmoP+cgGPQigD3ioB7q77amjmSP2rloRg1ViUH1sqGpqQA=
Received: from BL1P221CA0025.NAMP221.PROD.OUTLOOK.COM (2603:10b6:208:2c5::13)
 by SJ2PR12MB8160.namprd12.prod.outlook.com (2603:10b6:a03:4af::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.25; Fri, 29 Sep
 2023 14:12:07 +0000
Received: from BL02EPF0001A107.namprd05.prod.outlook.com
 (2603:10b6:208:2c5:cafe::4c) by BL1P221CA0025.outlook.office365.com
 (2603:10b6:208:2c5::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.26 via Frontend
 Transport; Fri, 29 Sep 2023 14:12:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A107.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Fri, 29 Sep 2023 14:12:06 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 29 Sep
 2023 09:12:04 -0500
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/3] amd/amdkfd: Unmap range from GPUs based on granularity
Date: Fri, 29 Sep 2023 10:11:14 -0400
Message-ID: <20230929141115.10016-2-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230929141115.10016-1-Philip.Yang@amd.com>
References: <20230929141115.10016-1-Philip.Yang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A107:EE_|SJ2PR12MB8160:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c8e168b-a04f-4634-371a-08dbc0f6100d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TO3jgHOG3mpMNc82+aldjfU1DTjskauI5rOHnH/D1iOj2t18HhBi7cLIbleUbTcYBEsti74HzDFF4OoWGFnBFAE/6RJg42m6mYFsHI2HWsWx7YAigjz5lKQ5snjwmhjA1fNjWmYEJ5LI/WYRfamuWpvrapk9ldUl6nyz1xmaglJQW9EbavGtcZWM9dz94hNM+vTDWCHJzt5rUMOKSAyhR9Fz8EEMPwny0jstP1PQUz/I4HIgv4b0fDTRVHa+fgJ71lj5pEN+rzoFCy7FZ0W9VDSOhgE9WsF2IC8NRlToJ1dNKQeAAmed+yLw+X5hHyZQdjVrKtiuybCn/MzahuShFOFPHphcPv3kTC7kGvAWoved5a7/vLcrUrBCqPitNjnZHjTcOCH++CR0/fPuWCpt7RPC+e2kFtH70OPmL1XlCStkJ1yOENb9ukKqlUOUokJFaYs9erYZhCTgogXLUQlJbc8f9/fY2kJRKOMJRxyrgqFihyAGJ7FeeO1TUDwDXH3YgqP3JsmPJbRbU05zX9AVwiVL6z0lQYyfwsP9vc7wud8ATfz+bWf9L6pXd9jcDtIorAJv7rn/JPC0BKbY7xHQ8E/cKs2leInv40u5a2rNS7VZmyCeXndek+9PJQwxR/AYPQAavsJKQlQBdndxTrhvEiGGVvVMHsx1o06375xXpzLDVjA+LN8eaOC+Aj5B2xtDcrL6/RplmkepeGLTTM57b8ns/4b1MAheqeLMzZ4ehaZOSy1yyynP52XeniFWwgxsJKXr0sVzqPDcgZj5xMMprQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(376002)(39860400002)(396003)(136003)(230922051799003)(82310400011)(64100799003)(1800799009)(186009)(451199024)(40470700004)(46966006)(36840700001)(1076003)(47076005)(6666004)(478600001)(83380400001)(36860700001)(2616005)(40460700003)(26005)(16526019)(336012)(426003)(40480700001)(356005)(81166007)(7696005)(82740400003)(86362001)(2906002)(5660300002)(8936002)(8676002)(4326008)(54906003)(316002)(36756003)(70586007)(70206006)(6916009)(41300700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2023 14:12:06.6377 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c8e168b-a04f-4634-371a-08dbc0f6100d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A107.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8160
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

Align unmap range start and last address to granularity boundary.
Skip unmap if range is already unmapped from GPUs.

This also solve the rocgdb CWSR migration related issue.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 35 ++++++++++++++++++++++++----
 1 file changed, 31 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 626e0dd4ec79..ac65bf25c685 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -2004,6 +2004,26 @@ static void svm_range_restore_work(struct work_struct *work)
 	mmput(mm);
 }
 
+static unsigned long
+svm_range_align_start(struct svm_range *prange, unsigned long start)
+{
+	unsigned long start_align;
+
+	start_align = ALIGN_DOWN(start, 1UL << prange->granularity);
+	start_align = max_t(unsigned long, start_align, prange->start);
+	return start_align;
+}
+
+static unsigned long
+svm_range_align_last(struct svm_range *prange, unsigned long last)
+{
+	unsigned long last_align;
+
+	last_align = ALIGN(last, 1UL << prange->granularity) - 1;
+	last_align = min_t(unsigned long, last_align, prange->last);
+	return last_align;
+}
+
 /**
  * svm_range_evict - evict svm range
  * @prange: svm range structure
@@ -2078,6 +2098,12 @@ svm_range_evict(struct svm_range *prange, struct mm_struct *mm,
 		unsigned long s, l;
 		uint32_t trigger;
 
+		if (!svm_range_partial_mapped(prange, start, last)) {
+			pr_debug("svms 0x%p [0x%lx 0x%lx] unmapped already\n",
+				prange->svms, start, last);
+			return 0;
+		}
+
 		if (event == MMU_NOTIFY_MIGRATE)
 			trigger = KFD_SVM_UNMAP_TRIGGER_MMU_NOTIFY_MIGRATE;
 		else
@@ -2085,16 +2111,17 @@ svm_range_evict(struct svm_range *prange, struct mm_struct *mm,
 
 		pr_debug("invalidate unmap svms 0x%p [0x%lx 0x%lx] from GPUs\n",
 			 prange->svms, start, last);
+
 		list_for_each_entry(pchild, &prange->child_list, child_list) {
 			mutex_lock_nested(&pchild->lock, 1);
-			s = max(start, pchild->start);
-			l = min(last, pchild->last);
+			s = svm_range_align_start(pchild, start);
+			l = svm_range_align_last(pchild, last);
 			if (l >= s)
 				svm_range_unmap_from_gpus(pchild, s, l, trigger);
 			mutex_unlock(&pchild->lock);
 		}
-		s = max(start, prange->start);
-		l = min(last, prange->last);
+		s = svm_range_align_start(prange, start);
+		l = svm_range_align_last(prange, last);
 		if (l >= s)
 			svm_range_unmap_from_gpus(prange, s, l, trigger);
 	}
-- 
2.35.1

