Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2647C433FE
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Feb 2022 21:23:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7052510E325;
	Tue, 15 Feb 2022 21:23:23 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2086.outbound.protection.outlook.com [40.107.244.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BB8E710E42F
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Feb 2022 21:23:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XUo1AOjqSRBZBZ8fEVFDyvnhW5z7qg+cWjRqQv21WtXpRDOUkst1+rfYKFP6nNgl6Re+ONmWkQ1o6olVDWrz2M1qp2JMVUE+9U+mSlK2O4nSvjaLlae49MMheNDLC9l2EPc+evr33ab1MfFaJhipHl565he+sgq0Ut+ssdNFYT+4iDm2DjB/6vxYSQNvYs8qfgQw0t15X4qReoCVfQYQJUc9Zh/f2MT+x5f9TIdYoM3KN6ueS4Hs0/3/YxDx9x1zfBvB7503zguxJ7neDjOKwfc3mv4NGkH/ZpcL7iOhHaRT8sdi1luCtHRq4TqKTDQWOYit6+HUxMcdeZFYBFBi2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LspsfuAKF3KRxMdD/o8Tw9lG6GDD+53/9rQPCkykC2E=;
 b=DbxfzAMuM4l3MgctGWAiUjKcDk6jAtEpAJp2cmoZwn0LXPejJOznFhsuOUImjgB8b0EOQ4MoJFrnr8oBHhhzKsvCUK1dUa0+5NgdgLht+A7bW06m1XDdtNu3Wth1J/e0FDGMg2cL75M9YLorPsk8qITIF7DVU/6a0C066M2BmTll/kA8AFP3EYs1JQ26F87NPB+ltnkf1vjsH5pvm5GpemL9camq1TrX6PMnKAmEe/WlpA602m35yOZ2lUNC/A0vjyxsTHYiCI9/LRvfcTcLdEOgXnU3FjH5HnBU1xel4mHLgHRqaI9IqJ3Hm/w5PEem+QWewhOm2+G4sOoak4wwZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LspsfuAKF3KRxMdD/o8Tw9lG6GDD+53/9rQPCkykC2E=;
 b=O7X4rIB22IrJoFtjR/wOubf36etfW/6jBhScW8zwFrGdQ0lkXpJx4EIMfBYV2rIX2Y8a595HvHrdq63kg8IGE4viJXlUXYX2MsEp6iPiBGlh8mbK8IAy17o6OU5EkZfZw7PDjxwHdQcYHnIfPtMW9m5GcDX2TonaqKBByeGy600=
Received: from CO2PR18CA0064.namprd18.prod.outlook.com (2603:10b6:104:2::32)
 by BYAPR12MB2632.namprd12.prod.outlook.com (2603:10b6:a03:6c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.12; Tue, 15 Feb
 2022 21:23:05 +0000
Received: from CO1NAM11FT031.eop-nam11.prod.protection.outlook.com
 (2603:10b6:104:2:cafe::6a) by CO2PR18CA0064.outlook.office365.com
 (2603:10b6:104:2::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.19 via Frontend
 Transport; Tue, 15 Feb 2022 21:23:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT031.mail.protection.outlook.com (10.13.174.118) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4975.11 via Frontend Transport; Tue, 15 Feb 2022 21:23:04 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Tue, 15 Feb
 2022 15:23:02 -0600
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v3 1/8] drm/amdkfd: Add KFD SMI event IDs and triggers
Date: Tue, 15 Feb 2022 16:22:40 -0500
Message-ID: <20220215212247.16228-2-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220215212247.16228-1-Philip.Yang@amd.com>
References: <20220215212247.16228-1-Philip.Yang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8c3cb0f4-90cd-426d-0b24-08d9f0c95a93
X-MS-TrafficTypeDiagnostic: BYAPR12MB2632:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB2632CFF599DDDCC960696416E6349@BYAPR12MB2632.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4o2EhOCBQyeh/qvkEOOPKl5Gd90SQ1II113u81SEhvYFyS5Pj7ki5R8uPiRu79L4F3hyBJiVXWFea3+WRlncAV7BvzJRjhZj+CBMLqrs0WgwJleQoVX59qU5VE2nGoGO0Nln955Q0YlH79nRcZQ3c7IqEZcpftsw4eG0KKUdf8Ml/x9qOmTZ8RDG9OzJYO4mDrHNmoyPgAvekf51ow5Xabpro8etfNipc5M4ytk81Sb9GSBuLdPiZcfieQ6QzXRLwIJ3I62RXRt5tVLDCnsKv7iM8paC6WFmrXcQ2xmQ9cSdUWCM/W471CTqstqIR3F8xje3ijIrLKTvIW3eyEIOT4Ql5FJesjRMXYUm9TBQ26YI8ZzfGFsnA5HQh7Tps4LUupKW8kjSAGVXjTsPuw5Tbyl+3ERr1IlkMcWnhzYyA3oW+yDQVxb/gv1myRRPg5jjmvCXS7hg6f9UjgqX/BDJvbD89fLmTbqvDpi6Uvtr8gkp04VMvartlN1o8urpJ4Gh/HpG4Ek5p5kcfmijE7AQpyx7xxKC5iiH2HxARYFtoO0mBEgnUh93uFnj1LRVappyrjEZ2eq+1fB7UgVlBDELqLsmSiZzRWR5HRpqA2Qs0JuSe5QK1n72xuYr2xMY3dH+ePkcrEvtRTpVpkg3K2kypr3FfZpzWu3ERBJgkmA7YXeEGo/tLgoj/J4PAYfby/Wg1wEl3iAGU4cTAnSNg9baBQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(16526019)(7696005)(186003)(1076003)(82310400004)(426003)(336012)(2616005)(6666004)(8936002)(26005)(2906002)(5660300002)(70206006)(8676002)(40460700003)(81166007)(356005)(4326008)(70586007)(316002)(36860700001)(508600001)(54906003)(86362001)(6916009)(36756003)(83380400001)(47076005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2022 21:23:04.6752 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c3cb0f4-90cd-426d-0b24-08d9f0c95a93
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT031.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2632
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
Cc: Philip Yang <Philip.Yang@amd.com>, felix.kuehling@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Define new system management interface event IDs for migration, GPU
recoverable page fault, user queues eviction, restore and unmap from
GPU events and corresponding event triggers, those will be implemented
in the following patches.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 include/uapi/linux/kfd_ioctl.h | 38 ++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/include/uapi/linux/kfd_ioctl.h b/include/uapi/linux/kfd_ioctl.h
index 6e4268f5e482..fcb6c8aa826b 100644
--- a/include/uapi/linux/kfd_ioctl.h
+++ b/include/uapi/linux/kfd_ioctl.h
@@ -460,9 +460,47 @@ enum kfd_smi_event {
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
 };
 
 #define KFD_SMI_EVENT_MASK_FROM_INDEX(i) (1ULL << ((i) - 1))
+#define KFD_SMI_EVENT_MSG_SIZE	96
+
+enum KFD_MIGRATE_TRIGGERS {
+	KFD_MIGRATE_TRIGGER_PREFETCH = 1,
+	KFD_MIGRATE_TRIGGER_PAGEFAULT_GPU,
+	KFD_MIGRATE_TRIGGER_PAGEFAULT_CPU,
+	KFD_MIGRATE_TRIGGER_TTM_EVICTION
+};
+
+enum KFD_QUEUE_EVICTION_TRIGGERS {
+	KFD_QUEUE_EVICTION_TRIGGER_SVM = 1,
+	KFD_QUEUE_EVICTION_TRIGGER_USERPTR,
+	KFD_QUEUE_EVICTION_TRIGGER_TTM,
+	KFD_QUEUE_EVICTION_TRIGGER_SUSPEND,
+	KFD_QUEUE_EVICTION_CRIU_CHECKPOINT,
+	KFD_QUEUE_EVICTION_CRIU_RESTORE
+};
+
+enum KFD_SVM_UNMAP_TRIGGERS {
+	KFD_SVM_UNMAP_TRIGGER_MMU_NOTIFY = 1,
+	KFD_SVM_UNMAP_TRIGGER_MMU_NOTIFY_MIGRATE,
+	KFD_SVM_UNMAP_TRIGGER_UNMAP_FROM_CPU
+};
 
 struct kfd_ioctl_smi_events_args {
 	__u32 gpuid;	/* to KFD */
-- 
2.17.1

