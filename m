Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE63FC433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Apr 2022 13:16:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8052710E9A2;
	Tue, 12 Apr 2022 13:16:47 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam08on2084.outbound.protection.outlook.com [40.107.100.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 91CD010E9A2
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Apr 2022 13:16:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ImUXfyNocMFSAWfdSrE/34x7GPsLJK14Xy/pl/XT0+EfFPRg+b5ng+kbeBEMrw1ugWZjVZeHCvkeHB0QLB2jRvSlUAbSGfM19Rxt7DizYBl/W0tJl56qZVCV7VibpMwhUg4nMjc5INdfH/2Fu0l9D9mGUn3e7Hl4UjWRlb5e9bSl8pTByhsiWImy0oK4MG4Uio+dZ4ScjCNE92oofW9/UrsEzT9TnoaTJJ8Ki9Cm7xeHgbhZitJ0dhdfZLFyaZ+B8bfjzadeVJwUaSDKnlffGT5LHcuJyWF3JalGsekeCcJMUskDv1NIZFsjWXZDvmfERjPl4CEOF7os32DRpMATUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UgAQpFrhzJlWTGMIZX48kIY/jws2LfWvBp3sNVc3P/k=;
 b=T26e91rWMFQjZroEOLh5l9xtIA3L/AvKifAkP6Y+WGMOUiR9PXr2UD99CbQBEiXJv/PxNfc5484XG0W+KZ32oKwZ0OFuvekuK3+Dko6zuvhyH0kteZCQBvxrD4J4W9npCJbbGASo/rkQ8j4H7qm0netmE4BuEWbglYv4Yy5ZI5pxHttHh/DpmFZDGbShc7boziLaI7gpOIn32V3sdpNMMjPJqr9Hb0OXF3CnhjVlLZs8RLkKvV8j8w/BCuZUuuejVRbMMpXqXqtAs4QVCes1U71EIFnqZ8TKhOFS39ovkQb0BdgAvnSWd+9DDlcKzOMqZQ1ulob7eL3NiuF3lvBBpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UgAQpFrhzJlWTGMIZX48kIY/jws2LfWvBp3sNVc3P/k=;
 b=Ss2EudRNoghaDs8mY1kCYERapY962dBZrWBeDh94OFlAi5pm1u2Qgcb3C3ZcYJ4aQzc4waHucfQTPn/n68LHtVfumVJc6U/iGOVx2M8nN2+w6QK613RBGTvZNspnp2DFtnHwo8i1Y5qqL2jhNmDnxyDA9GJBEhQ9unB1/qNTwtE=
Received: from MW4PR04CA0219.namprd04.prod.outlook.com (2603:10b6:303:87::14)
 by MN0PR12MB5716.namprd12.prod.outlook.com (2603:10b6:208:373::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Tue, 12 Apr
 2022 13:16:42 +0000
Received: from CO1NAM11FT018.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:87:cafe::24) by MW4PR04CA0219.outlook.office365.com
 (2603:10b6:303:87::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29 via Frontend
 Transport; Tue, 12 Apr 2022 13:16:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT018.mail.protection.outlook.com (10.13.175.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5144.20 via Frontend Transport; Tue, 12 Apr 2022 13:16:42 +0000
Received: from yonsun-E14.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 12 Apr
 2022 08:16:40 -0500
From: Yongqiang Sun <yongqiang.sun@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <shiwei.wong@amd.com>
Subject: [PATCH] drm/amd/amdgpu: Not request init data for MS_HYPERV with
 vega10
Date: Tue, 12 Apr 2022 09:16:28 -0400
Message-ID: <20220412131628.1121961-1-yongqiang.sun@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 72591573-ae75-421f-b215-08da1c86af90
X-MS-TrafficTypeDiagnostic: MN0PR12MB5716:EE_
X-Microsoft-Antispam-PRVS: <MN0PR12MB5716AF7B4C0D0DCFF38C9824F4ED9@MN0PR12MB5716.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: s89sAMCN/93jWw0EYJW3Lsi2jIpBbFenMFspFSXYEXQD+gfeHC8wi2Jub9dC4fCFoKiHo/Iny9oxhx0ILTeMzya8BHetQq7NiqKCsYVTO9J70uZdu3CO36insc+/2dmE1/mtK7JhSo9lHzCBRCZ21LScbbm2ZauhAQYcQ5fTXqYGuDRUXJ4xX+neYzLv0tqKU+9sAi7sNmiaQa+z6xr8iQJZdVgaYhcWkwGO57aGVt+3yoz/6P6oYUAt4FlfBwfs7Cf0NsV9dUHvqhy3yo9kKowCf9Zm0JnlRP3JK6ZuRinRb0dMvOVKIlEszcFr/+lUQiv5ZSs+GlEeyD6CWOjGWNiBGygejYocLsy2XmKhnzPCMhJZaDgyx/3fGu06Id/Wy7+xv+o8tSG6fKO/L1DP2nlwYwp5UyR1KDSRwz2sV2NHj24H1sI0Y4gXYDgT5uJhEnXxjCPtyEurWt+b7FL9MmHxqPOEETjqBOa7D5MUbjnHhlF06ZlYojcJebgvysOXLE4HeXJlx73Puv8Z0GNmenRLHJzzo8lJopuArcJUxvNCD79yLkJLT6p82bNwVipepgUhQALFH4lGxVNcJg2+6QzwEyyJdRL+yMXfFjOH6PCPuoHakHc8dHadhVSiyrYYFHtKeG6q79Wu4eR5nQc7iUOtmaU5wdrUCF7wUmRys/oIqw5HORIwk2As3qkCENoL+rDu76nDyFa76XeeCSHoPQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(8936002)(8676002)(6636002)(70206006)(2616005)(4326008)(26005)(47076005)(186003)(82310400005)(16526019)(336012)(5660300002)(2906002)(40460700003)(36756003)(36860700001)(70586007)(83380400001)(44832011)(508600001)(86362001)(426003)(316002)(54906003)(110136005)(7696005)(6666004)(81166007)(356005)(1076003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2022 13:16:42.1162 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 72591573-ae75-421f-b215-08da1c86af90
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT018.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5716
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
Cc: Yongqiang Sun <yongqiang.sun@amd.com>, yiqing.yao@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

MS_HYPERV with vega10 doesn't have the interface to process
request init data msg.

Check hypervisor type to not send the request for MS_HYPERV.

Signed-off-by: Yongqiang Sun <yongqiang.sun@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
index 933c41f77c92..d5eea031c3e3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
@@ -23,6 +23,10 @@
 
 #include <linux/module.h>
 
+#ifdef CONFIG_X86
+#include <asm/hypervisor.h>
+#endif
+
 #include <drm/drm_drv.h>
 
 #include "amdgpu.h"
@@ -721,8 +725,12 @@ void amdgpu_detect_virtualization(struct amdgpu_device *adev)
 			break;
 		case CHIP_VEGA10:
 			soc15_set_virt_ops(adev);
-			/* send a dummy GPU_INIT_DATA request to host on vega10 */
-			amdgpu_virt_request_init_data(adev);
+#ifdef CONFIG_X86
+			/* not send GPU_INIT_DATA with MS_HYPERV*/
+			if (!hypervisor_is_type(X86_HYPER_MS_HYPERV))
+#endif
+				/* send a dummy GPU_INIT_DATA request to host on vega10 */
+				amdgpu_virt_request_init_data(adev);
 			break;
 		case CHIP_VEGA20:
 		case CHIP_ARCTURUS:
-- 
2.25.1

