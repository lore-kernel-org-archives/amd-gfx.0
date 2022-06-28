Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD1DEC43334
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Jun 2022 14:51:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 49E0310FA8F;
	Tue, 28 Jun 2022 14:51:30 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9E84210F9D4
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Jun 2022 14:51:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hm06ASo/24DFoKU8VH0Wzlt+ZY7WmcQgTk4jnfzR7yj2x9ZYVHEdpB5XsVPOJzBAuMp27noWWtA8/VvOYhnsPFNSgM/GreD9iHiUC4zCiW0nUeKH/qGUPMLQsdb2g/oeDafF3HhC1GMjmx0vJyfBBCGgevDf81u+HbmlVypc9j+CzlLovMLquvlBZRJsF5ngfPr0Qb3U8qBs6yqyzln6jDN4s6acZHzr3c0xpsJ00yepx62VDZBiy82ikK2WMrmU/1ERDcODzuGWpAVooMn+ki8WQwFa8Icdv/ytNTt+tIc01QU7Nc8rZW1r7GGhguxcdPIeP5wOaS0PFuBOgYFD6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i91VFUqu2HsdrkVCNigWqscAX8o/9qZp2LihLycRg7Q=;
 b=HxLuGSVmnzvgqQE9/8P54v6ns4C9veKysEApTfEkDbvebBuibKoeh7jpTdITM3nkracXbXmiIq7rv+3rBlKdVyfl5C23i57f8wj9EJSf4w7iWQgXjUaMnnylzZjpK+oY9Y0Xxa4EGMQT9hkQ/acJLjnIKm/vSAiauzSPLkGi8N36hIhZK72GYSt+doWd7OHv+LQqVWXP5ltH4j4pC3e/OFTs6dRuZ+gQmLYe/icDatCgXBZ7+8g+UC63SCxyPwzrAX1TBFQatjXtGD1yCwvkYrqf0pnBtTTmVJcEGlv1y5gnJEO4THcHyWox/wHtZDEnHukecyiU/ZPxv2D8lmo79Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i91VFUqu2HsdrkVCNigWqscAX8o/9qZp2LihLycRg7Q=;
 b=hC0SD8xbJ/FgYKmp2yBxJr+JTLLumKNlFtjI8U076rNeoU9J505QXD7uO2qvQ+fGK6bV5i4TNAEGFl6lDSld64cZPs1PVnSyTS1Tr7d/sRaMoWAdQCURIWImfa2qLeTRKRQPIyLDFKUSWDR4dY+JPF2vjXXuUCnI68FNaBBJj7g=
Received: from MWHPR17CA0073.namprd17.prod.outlook.com (2603:10b6:300:c2::11)
 by DM6PR12MB3308.namprd12.prod.outlook.com (2603:10b6:5:182::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.18; Tue, 28 Jun
 2022 14:51:22 +0000
Received: from CO1NAM11FT054.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:c2:cafe::ea) by MWHPR17CA0073.outlook.office365.com
 (2603:10b6:300:c2::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.21 via Frontend
 Transport; Tue, 28 Jun 2022 14:51:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT054.mail.protection.outlook.com (10.13.174.70) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5373.15 via Frontend Transport; Tue, 28 Jun 2022 14:51:21 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 28 Jun
 2022 09:51:20 -0500
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v5 1/11] drm/amdkfd: Add KFD SMI event IDs and triggers
Date: Tue, 28 Jun 2022 10:50:10 -0400
Message-ID: <20220628145020.26925-2-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220628145020.26925-1-Philip.Yang@amd.com>
References: <20220628145020.26925-1-Philip.Yang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 057c2f48-5053-4edf-7829-08da5915aa89
X-MS-TrafficTypeDiagnostic: DM6PR12MB3308:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aLrMa6Wy+zYINVmUvrVXG5Nyjn+gMte2uV5NlVdw8q82LA25dlc9A94CJwAuXY54gRnuAeM0yDUzOsMCh/N7wpXPD5/rzBG1973wXTXgqSu8NtgaEvGxd2+fgYtgkxendGAfyKClrf+5bo6sfDlxC1wJwNgzIZ77ba9xR8s0gZrfCP/HU5sRdjvwQY4CeMrlDW5QNDV6zGSDnBhp/W8k4ttipJvEQa60IR2knUdA/NU2sMxanwjhJECpc6nc/7zIbBz1a+poY3o2VLmn3kA0tgr3reQ8SjmmJME+Mdvmj7WMNt6aEN9qe0p9CBkIWDnD8dOjBMGQ8JUKol43aDFq92i9nmaQXcQfgbg3S5Bk2q/CUWRwKoYoTr/h6Et4Trf9ieJGCWZh2K2hxAuFCMpXMnzYUs/0rZX43i5Ke/VqI2xYshqNnEFpl6w2RpX+4yMxDLHAya1t+dTyfqFnGePDDfynfWugZQpP7MJb/vTcoUrF7aeaMPEf3uPlSCmZ6E7g19rCMNOc5nnw2Y1UgJ1BuHrC4E7BLU/vWzEGQEjLT6qGNvHRk/fezl9jABq6g75NbbRuAI8/Uv1hRy3m+MPP3CMZbAmG63PBAlsub5h8dkUc4NeArHvh/n0fsbWR80TLm5cpzS5uswFYHAAY2SkUCJzjWjCFZi7H+/KEHnBF30ntfxroQXJxZWzfHFBvyZCeGVV46VFKuaMWbzEQtQOWlupJ5eGy9z9lc0AFVJA5LRNG4VKFVRoUgMdUkSfWZR7zu/mzK56cUAbb6g3mYgexi45hAv3by+4obeFF6oon0vyZ0wsywAr0F5dRZaNPDnjbYgGCqtZYFonSljpz2f48pA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(376002)(136003)(346002)(396003)(39860400002)(40470700004)(36840700001)(46966006)(316002)(54906003)(2906002)(1076003)(6916009)(6666004)(5660300002)(336012)(82310400005)(36756003)(41300700001)(356005)(16526019)(2616005)(186003)(86362001)(70206006)(426003)(7696005)(8676002)(70586007)(4326008)(36860700001)(40460700003)(47076005)(40480700001)(8936002)(81166007)(26005)(478600001)(82740400003)(83380400001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2022 14:51:21.4792 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 057c2f48-5053-4edf-7829-08da5915aa89
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT054.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3308
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

Define new system management interface event IDs for migration, GPU
recoverable page fault, user queues eviction, restore and unmap from
GPU events and corresponding event triggers, those will be implemented
in the following patches.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 include/uapi/linux/kfd_ioctl.h | 37 ++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/include/uapi/linux/kfd_ioctl.h b/include/uapi/linux/kfd_ioctl.h
index c648ed7c5ff1..f239e260796b 100644
--- a/include/uapi/linux/kfd_ioctl.h
+++ b/include/uapi/linux/kfd_ioctl.h
@@ -468,6 +468,43 @@ enum kfd_smi_event {
 	KFD_SMI_EVENT_THERMAL_THROTTLE = 2,
 	KFD_SMI_EVENT_GPU_PRE_RESET = 3,
 	KFD_SMI_EVENT_GPU_POST_RESET = 4,
+	KFD_SMI_EVENT_MIGRATE_START = 5,
+	KFD_SMI_EVENT_MIGRATE_END = 6,
+	KFD_SMI_EVENT_PAGE_FAULT_START = 7,
+	KFD_SMI_EVENT_PAGE_FAULT_END = 8,
+	KFD_SMI_EVENT_QUEUE_EVICTION = 9,
+	KFD_SMI_EVENT_QUEUE_RESTORE = 10,
+	KFD_SMI_EVENT_UNMAP_FROM_GPU = 11,
+
+	/*
+	 * max event number, as a flag bit to get events from all processes,
+	 * this requires super user permission, otherwise will not be able to
+	 * receive event from any process. Without this flag to receive events
+	 * from same process.
+	 */
+	KFD_SMI_EVENT_ALL_PROCESS = 64
+};
+
+enum KFD_MIGRATE_TRIGGERS {
+	KFD_MIGRATE_TRIGGER_PREFETCH,
+	KFD_MIGRATE_TRIGGER_PAGEFAULT_GPU,
+	KFD_MIGRATE_TRIGGER_PAGEFAULT_CPU,
+	KFD_MIGRATE_TRIGGER_TTM_EVICTION
+};
+
+enum KFD_QUEUE_EVICTION_TRIGGERS {
+	KFD_QUEUE_EVICTION_TRIGGER_SVM,
+	KFD_QUEUE_EVICTION_TRIGGER_USERPTR,
+	KFD_QUEUE_EVICTION_TRIGGER_TTM,
+	KFD_QUEUE_EVICTION_TRIGGER_SUSPEND,
+	KFD_QUEUE_EVICTION_CRIU_CHECKPOINT,
+	KFD_QUEUE_EVICTION_CRIU_RESTORE
+};
+
+enum KFD_SVM_UNMAP_TRIGGERS {
+	KFD_SVM_UNMAP_TRIGGER_MMU_NOTIFY,
+	KFD_SVM_UNMAP_TRIGGER_MMU_NOTIFY_MIGRATE,
+	KFD_SVM_UNMAP_TRIGGER_UNMAP_FROM_CPU
 };
 
 #define KFD_SMI_EVENT_MASK_FROM_INDEX(i) (1ULL << ((i) - 1))
-- 
2.35.1

