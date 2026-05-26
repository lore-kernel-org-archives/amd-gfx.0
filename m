Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2C62CD5BB1
	for <amd-gfx@archiver.kernel.org>; Tue, 26 May 2026 20:27:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 21A6A10E1E4;
	Tue, 26 May 2026 20:27:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ekBv+CuT";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012030.outbound.protection.outlook.com [52.101.53.30])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5C42710E1E4
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 May 2026 20:27:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SgNqzCuOfV1lL0NDaw5Ilz5HKIT72s4sWzVTmPM+zwbEqKpDYJN5/QZWPKN1mFNvcYgnRTgG7TOms9PSTrRyJ8kElKLfZ6CvxF3AML3tEUiJm1WmAk7AOLFER3KTr0YxqDLy8pCaH6wXyK6RCT7TUQr1pTKdA1+822KaiWI7mnJJpvNNTFj27gOy24ROx2byO9VaAI/644U6sNPPb+7yqh9Ddo+IUWkOw95ZLU5yc62sFmRox41bSCyf5ZGAtdA1iwkRcowWgsgVJjVVcry+wshO/AThnDhcRAsVt3dU6Sf6tD6zfvq+61I3uftHeNB5UAktSFCwR13fEEuBAQMK/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZH74Tgla5X2kJ2l2CrfDYYvl/r7JiO+ZG2TbcFUrEIk=;
 b=L7zXruReuwRqQ2UbfDQ8knnfv0iItaGvy3I5ZHB8X9z9Wyf9+x5xxPIqj703H/LSz8nGliKdPzJNEArpjThRl9Mf/+lu1gmg8SQiTWTpAHVCH/hiRVMg4seWXeYJ25WAFFNhT9NsgpIITm3JYPzL9eivP8qY15GCD2Dlp3wqWvpwkbTZ589tJK0FY5SzMZQ08kc++DVHztSwcMNZi3Ja/Ps3EKKqmO43z7wTw99x6hs4Uzeef50+8lQ+3k5P0eZjgIzi/V6wyQzZkGS1OndgFcoDu3yfHnphOyuKip0R8ieulObM3BieKO39bqerG7b9GLqT539oR48Hq/UDqegk/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZH74Tgla5X2kJ2l2CrfDYYvl/r7JiO+ZG2TbcFUrEIk=;
 b=ekBv+CuTWPU9OHrJR5Yn7afqDxfhq2lOxy+VMDOhS8C+6/1JdPTkhssxYcYIiIAe0Snejn5sl8Y79UZRIeljr0KunKAQJAzRWhNuYvz+K0n7RjsOI8O9T2XdWIuFK4L5utWnvYY2ZAzHP+dnYu8cXL+OVCXKP0WFB5m3J3L68K8=
Received: from PH7P220CA0105.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:32d::20)
 by DS0PR12MB9422.namprd12.prod.outlook.com (2603:10b6:8:1bb::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Tue, 26 May
 2026 20:27:33 +0000
Received: from MW1PEPF00016159.namprd21.prod.outlook.com
 (2603:10b6:510:32d:cafe::8e) by PH7P220CA0105.outlook.office365.com
 (2603:10b6:510:32d::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.12 via Frontend Transport; Tue, 26
 May 2026 20:27:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MW1PEPF00016159.mail.protection.outlook.com (10.167.249.84) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.0 via Frontend Transport; Tue, 26 May 2026 20:27:30 +0000
Received: from 0yonsun-linux-dev.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.41; Tue, 26 May 2026 15:27:29 -0500
From: Yongqiang Sun <Yongqiang.Sun@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Yongqiang Sun <Yongqiang.Sun@amd.com>
Subject: [PATCH] drm/amdkfd: fix signal page mmap PFN for GTT-backed event
 pages.
Date: Tue, 26 May 2026 16:27:11 -0400
Message-ID: <20260526202712.1112773-1-Yongqiang.Sun@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW1PEPF00016159:EE_|DS0PR12MB9422:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d6a4ecb-2c23-44c7-2518-08debb6535fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700016|376014|11063799006|18002099003|6133799003|56012099006;
X-Microsoft-Antispam-Message-Info: 0y8QtGSVnzHMXZvSgRntgUMJSjxeUnyQCcLbgaX5kCBgPbB6YASNd0VlKu4H0fB44IaxaNg2i7r86krXiMuuv0wQS7jG76bIhJz4RGp9bATQNC13+VilNNYCSD8H5zd3xOwlQlvEAuhhFhGgw6JqQS5hxmvaPzChiyRZKsXdO6QTCWrY4FcHTRAqbPEjh3gxjARZDd683/bO5kO2EakmQ05w9By9JehNauojsbiriqUQhZ5Vz40/XKiYXBynRywovrhxMqtr937hym5Rdlzf9y+WOLql8mhxT6sHQj50ySJ9+unQN54y1OvsBw/7YE5TY0MtKignSrgdRuyC9hSMWfbYziWz5tiT+YoYdY83xc5wrP/aKUjLxEKKHWzGZ4Tv76uuh/t8uN35/kpJjU7sT2CtxQhHKUEecCCFoFcHMyr1ENBB1h1Azip76oTIVyQFr7iiPIbTTQc4soMSqzeiz7FYQ04+hsQ62hHP9ILbjqNfHQfoH4VC4wSsO1zRKyhUI72wWtI3GGwXLDi1l3eDgh3zpwO8diO1EykgikQjVlB/qWd31Gu4iPmUdCkF4uiRA36qxEkYGI8wSYrpWg5WVD2wHWAJcLHMhG6PwOGTdbuucjd2Yg5g0xFz9Anxeo4qxiFgAKM4e6OL+/PUnER/LhgfIpt+zT3t6/DWqe7YtglfTVveaOc/lqTSv0uV2YoasGXhcxVhXnT/lpYoqvo6oSJdqXX8hOfsH/9i48/gZYQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(11063799006)(18002099003)(6133799003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: aG+rWSLs74BHIHS4px/V/d5b9OGn3JaQBOPosnMqVhC93QiJo2kezczBumaJOMq1UgslLhMZlzGoqCU1tEYABrpjZm1qCCFh0Uryf+KyC0qMrRXLiHuRW7yqJ0kpLI4MvYE68FXFVjGQhuEDMhzaZRsZ6mCWuzsEZdvAq4kxq1S4nj1hsOm4MVBf5/D7DIROHT9Dkysp7cW9gPaLuzZkpKUmE20gl8Tw36qBirmEg9/6R9TrEkg3ue8/CElZfVemebYbQqyeeuEILZdVDQ39GgOruTmgRWcqdjbgYvIfat2YY1pOw+eT3QXLy3R39V1xCMfaRclcmcwMlBzN+M3m8Tgascq2AWUQpX5As8//UAr6gpGa/jPFNFU3GJZTSL63rkHsKijuzLKAhL0D8mHTEHVZTovhFZdIeAU72k5s1qWNYHFyxHFkKu5JWfDCUiLa
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2026 20:27:30.3552 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d6a4ecb-2c23-44c7-2518-08debb6535fb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MW1PEPF00016159.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9422
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

__pa(kernel_address) is invalid for vmap'd GTT kmap addresses. Record
page->user_pfn at setup (virt_to_page / vmalloc_to_pfn) and use it in
kfd_event_mmap() instead of __pa().

Signed-off-by: Yongqiang Sun <Yongqiang.Sun@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_events.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_events.c b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
index e9be798c0a2b..6e0beacca81e 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_events.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
@@ -21,8 +21,10 @@
  * OTHER DEALINGS IN THE SOFTWARE.
  */
 
+#include <linux/mm.h>
 #include <linux/mm_types.h>
 #include <linux/slab.h>
+#include <linux/vmalloc.h>
 #include <linux/types.h>
 #include <linux/sched/signal.h>
 #include <linux/sched/mm.h>
@@ -54,6 +56,7 @@ struct kfd_event_waiter {
 struct kfd_signal_page {
 	uint64_t *kernel_address;
 	uint64_t __user *user_address;
+	unsigned long user_pfn;
 	bool need_to_free_pages;
 };
 
@@ -82,6 +85,7 @@ static struct kfd_signal_page *allocate_signal_page(struct kfd_process *p)
 
 	page->kernel_address = backing_store;
 	page->need_to_free_pages = true;
+	page->user_pfn = page_to_pfn(virt_to_page(backing_store));
 	pr_debug("Allocated new event signal page at %p, for process %p\n",
 			page, p);
 
@@ -349,6 +353,11 @@ static int kfd_event_page_set(struct kfd_process *p, void *kernel_address,
 	       KFD_SIGNAL_EVENT_LIMIT * 8);
 
 	page->kernel_address = kernel_address;
+	/* kmap for GTT is vmap-backed; do not use __pa() on kernel_address */
+	if (is_vmalloc_addr(kernel_address))
+		page->user_pfn = vmalloc_to_pfn(kernel_address);
+	else
+		page->user_pfn = page_to_pfn(virt_to_page(kernel_address));
 
 	p->signal_page = page;
 	p->signal_mapped_size = size;
@@ -1087,8 +1096,11 @@ int kfd_event_mmap(struct kfd_process *p, struct vm_area_struct *vma)
 		return -EINVAL;
 	}
 
-	pfn = __pa(page->kernel_address);
-	pfn >>= PAGE_SHIFT;
+	if (!page->user_pfn) {
+		pr_err("signal page has no recorded PFN\n");
+		return -EINVAL;
+	}
+	pfn = page->user_pfn;
 
 	vm_flags_set(vma, VM_IO | VM_DONTCOPY | VM_DONTEXPAND | VM_NORESERVE
 		       | VM_DONTDUMP | VM_PFNMAP);
-- 
2.43.0

