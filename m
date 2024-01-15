Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 905AEC47258
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Jan 2024 22:51:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0646010E3AB;
	Mon, 15 Jan 2024 22:51:31 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0549810E3A3
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Jan 2024 22:51:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mcE3CryegDZIwVEHjfYibXjl6yYXnlWDzVmmotK0//JUqkbBopGCZFWQt7flrYUGbZj20RkU5hbAVdfzY+3ZCunN+yaUpHTOMnZLJThGv8VCGzU7CRNHjkNAeeQgoSW6ewdaqJRkdZghjTQ+oNRr3ulmghAdFvK/6Z+squMat/m9sbr4YVh1bkjO3AmT4VyAjkLgdxsqKMRE0MQi0K7MnJFxAv6IeukaKOTXijSqGrT+ZiHfrvHmaFJb1hbUE5p+a2WVWFtNavhU9PTRCbxeFhOnFDdsY/a7ReUKq7n11+EJW+xwbqQXGZGJe9OtE3t3yZPX5rBVdQB3RPyPbLt9ZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CPww9bKQZGHCY5XMdksDIMm1F+M1NMlKQRrWUTLjY04=;
 b=fZ8b/aH5r+QVRySDgL2QutIZvLjaxbjAzirI6cbfTuMC3gN2rzN44YyFbZC3/tmfGat/jtwzWJU5cp0xMtDPLpWYW67GuP7sGF5IT8Ylb9gPpEw+v5/qwRiWMRmL9QBEiSVOdMsC5oMC8PWCcVWWZcvnaxQMx/VWD4rlO+hKYFxfPTUhFYvfedz7mjt0zrgygEdGsrIKiZiNoNQAHwzwUpKIMDL3J+fBPrruVPtas85TEePWWBnGrO9u2LcIDffvwmIQf5/j2nBXc/lL+gu7fqYZA0uP4isQ0gn35tkQ+nTWSQCr3ojiS2C9KEJ5OFdtJwKI9H69zOdo6mApIqO+4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CPww9bKQZGHCY5XMdksDIMm1F+M1NMlKQRrWUTLjY04=;
 b=IrIE96IaB5NKKk4vOtujdOuFZdz1NwiGLDhnLhxaT/NZuNF3RAC14YhvS2NzGPS5ltavkjKVS2yBuMHTDW5GVL5ofcLQTZUhLozT6sPrxw7Bxm7bf25NG8fi3az5dmPAcEK3jrH+jKw/YQJxZA0ex8e4nOo/qziUJ7RSEXozCEU=
Received: from SA9PR13CA0179.namprd13.prod.outlook.com (2603:10b6:806:28::34)
 by LV8PR12MB9134.namprd12.prod.outlook.com (2603:10b6:408:180::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.23; Mon, 15 Jan
 2024 22:51:24 +0000
Received: from SN1PEPF0002BA50.namprd03.prod.outlook.com
 (2603:10b6:806:28:cafe::6d) by SA9PR13CA0179.outlook.office365.com
 (2603:10b6:806:28::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.17 via Frontend
 Transport; Mon, 15 Jan 2024 22:51:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002BA50.mail.protection.outlook.com (10.167.242.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7202.16 via Frontend Transport; Mon, 15 Jan 2024 22:51:24 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Mon, 15 Jan
 2024 16:51:22 -0600
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v4 4/7] amd/amdkfd: Unmap range from GPU based on granularity
Date: Mon, 15 Jan 2024 17:49:47 -0500
Message-ID: <20240115224950.3300-4-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20240115224950.3300-1-Philip.Yang@amd.com>
References: <20240115224950.3300-1-Philip.Yang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA50:EE_|LV8PR12MB9134:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a135c3b-e749-42fa-063d-08dc161c7ff1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3k41oSWTHwN78ylq5fa5sqzBVkVRWjBLODdqFH+E5k2+FFqnotAEL38EoN08g80rBR6jzL5F98ICA69WuXcx1KTEBomRB4CsWVIGZAGK95N0LzKb1OSu+gF7vmCyOjdaiQouHiBO8vJe4/39BeDnJaIjyhoOJOKtMYjE6GyaRyjHxBp2FNrrMdsx3nsSHrvdbVHvCed0Q6b+rQF0gdRdv+HrClDEV7cplNOj9ucSllJIX3a3SLuNhvDO5/q4ka98kxd5AqCl5QJ+IppDKJA54clu4E0spXnqGGOO4dAoA01mUnAATmmhhLGnMJtiXjmJ8Nep9P4k8H9/UgfKNJAyL0Y4iqesprWZisBpUnMtacmSZs36Q+YfbqWfig+S9DjiTF4QcmYwugw1El1BinS3rUvjQdPxfxrc0StZC1kFf5KxtZulYCA/qLyGjcl9tL6oNlbKpIVmVNPvfUDb6bbzAfK/bnJsLfHLVYWsnqfplKGbmfU0Ov61LxIozh6Q2KHooz1WgQqaiPXofY+m8jm/QitolmCxkDkFCgiXNh5VizTf3IQO3mJ9MyXHRQxktOWJGmVQVMYJr/kC5S6LPmjWNVauAJX297h0Fz08gWkLm+qVHeIJ0kLlNHd0HIWc6CX8P8xR88cXe2dgNE+LpOyKSoVcE3DPQAvoPjMiAI6EA6qw59Lb7Dp28fHOPIZFHyeimLTsf8FzoHGdWkSr75ai53HcXmgInfrdyTAyHlh197Nx3iFfs242FwHn8K5iXZHU/+vca8oEPDxN8culXh/upw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(39860400002)(136003)(396003)(376002)(230922051799003)(64100799003)(186009)(82310400011)(451199024)(1800799012)(36840700001)(46966006)(40470700004)(356005)(40480700001)(40460700003)(86362001)(83380400001)(47076005)(36756003)(81166007)(82740400003)(8676002)(6666004)(8936002)(4326008)(5660300002)(26005)(16526019)(1076003)(2616005)(426003)(36860700001)(70586007)(70206006)(316002)(6916009)(54906003)(7696005)(2906002)(41300700001)(336012)(478600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2024 22:51:24.0540 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a135c3b-e749-42fa-063d-08dc161c7ff1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002BA50.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9134
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

When MMU notifier invalidate the range, align the start and last address
to range granularity to unmap from GPU and update bitmap_map flag.
Skip unmap from GPU if range is already unmapped based on bitmap_map
flag. This  avoids unmap 1 page from GPU and flush TLB, also solve
the rocgdb CWSR migration related issue.

Unmap the range from cpu will remove the range and split the range, this
cannot align the start and last address to range granularity. Change
to split the range and bitmap_map flag first, then unmap the range
from GPU. If unmapping from GPU first, the bitmap_map flag is updated,
split range may get incorrect bitmap_map for the remaining ranges.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 42 +++++++++++++++++++---------
 1 file changed, 29 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index a003406db067..7a30c3e58234 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -2114,6 +2114,13 @@ svm_range_evict(struct svm_range *prange, struct mm_struct *mm,
 	} else {
 		unsigned long s, l;
 		uint32_t trigger;
+		u64 size = 1UL << prange->granularity;
+
+		if (!svm_range_partial_mapped(prange, start, last)) {
+			pr_debug("svms 0x%p [0x%lx 0x%lx] unmapped already\n",
+				 prange->svms, start, last);
+			return 0;
+		}
 
 		if (event == MMU_NOTIFY_MIGRATE)
 			trigger = KFD_SVM_UNMAP_TRIGGER_MMU_NOTIFY_MIGRATE;
@@ -2122,16 +2129,17 @@ svm_range_evict(struct svm_range *prange, struct mm_struct *mm,
 
 		pr_debug("invalidate unmap svms 0x%p [0x%lx 0x%lx] from GPUs\n",
 			 prange->svms, start, last);
+
 		list_for_each_entry(pchild, &prange->child_list, child_list) {
 			mutex_lock_nested(&pchild->lock, 1);
-			s = max(start, pchild->start);
-			l = min(last, pchild->last);
+			s = svm_range_align_start(start, pchild->start, size);
+			l = svm_range_align_last(last, pchild->last, size);
 			if (l >= s)
 				svm_range_unmap_from_gpus(pchild, s, l, trigger);
 			mutex_unlock(&pchild->lock);
 		}
-		s = max(start, prange->start);
-		l = min(last, prange->last);
+		s = svm_range_align_start(start, prange->start, size);
+		l = svm_range_align_last(last, prange->last, size);
 		if (l >= s)
 			svm_range_unmap_from_gpus(prange, s, l, trigger);
 	}
@@ -2645,24 +2653,32 @@ svm_range_unmap_from_cpu(struct mm_struct *mm, struct svm_range *prange,
 
 	list_for_each_entry(pchild, &prange->child_list, child_list) {
 		mutex_lock_nested(&pchild->lock, 1);
-		s = max(start, pchild->start);
-		l = min(last, pchild->last);
-		if (l >= s)
-			svm_range_unmap_from_gpus(pchild, s, l, trigger);
 		svm_range_unmap_split(mm, prange, pchild, start, last);
 		mutex_unlock(&pchild->lock);
 	}
-	s = max(start, prange->start);
-	l = min(last, prange->last);
-	if (l >= s)
-		svm_range_unmap_from_gpus(prange, s, l, trigger);
 	svm_range_unmap_split(mm, prange, prange, start, last);
-
 	if (unmap_parent)
 		svm_range_add_list_work(svms, prange, mm, SVM_OP_UNMAP_RANGE);
 	else
 		svm_range_add_list_work(svms, prange, mm,
 					SVM_OP_UPDATE_RANGE_NOTIFIER);
+
+	list_for_each_entry(pchild, &prange->child_list, child_list) {
+		if (pchild->work_item.op != SVM_OP_UNMAP_RANGE)
+			continue;
+
+		s = max(start, pchild->start);
+		l = min(last, pchild->last);
+		if (l >= s)
+			svm_range_unmap_from_gpus(pchild, s, l, trigger);
+	}
+	if (prange->work_item.op == SVM_OP_UNMAP_RANGE) {
+		s = max(start, prange->start);
+		l = min(last, prange->last);
+		if (l >= s)
+			svm_range_unmap_from_gpus(prange, s, l, trigger);
+	}
+
 	schedule_deferred_list_work(svms);
 
 	kfd_unref_process(p);
-- 
2.35.1

