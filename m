Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7E68C433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Feb 2022 18:06:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4CA7C10E90C;
	Fri, 25 Feb 2022 18:06:47 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2065.outbound.protection.outlook.com [40.107.237.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D53EB10E907
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Feb 2022 18:06:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GXqL6uXgdgmApHZx2TydgmYvuvoEs1la02c5GZaHiSEaUyfKZCoQTogCCzp6AsaemQ4J69TUcBDoXlGj0Lvoy8lkwr17beGjLApjnEhDGo9SQPxmaX6XwtUoHN1QAc5Xn4PnSVzhktOOLKO5ylgmm1UgMp5jqtfQgV1qgyD1MhvBmOPCIP2RxgjlNpCnMIGW5QSu6yLefjOd47qugRvEKQrWKqS5A6fvuksbF+HDx/8yA4lLG1txbKuoXU1C4aYFv7O7xKF0suXbAo3mLs+DDk449/lTCLPAOpB2MxQ7E8P6g+lSXD7OJYOQooVmICMjlad6H3RNrmr5J9N2KOPVXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YtdkRVfaqbIdHvTUQI7fcrPu37Vu85kRrvcBKPBpEK0=;
 b=CbpMsqXTJMZuDbw8DikEyP3YoUXhE4TTfr1dkFwSZ876WIfuaewqxfgqjLdYCatoaG2Fvt4XDU/v9XHKfSYpoElsXCpJX8W44c/O+6Ays08FcFFVJ1JcIvx5wm6cjjwjXLJrlVlDQ1PzsUGnBfbR6RrujQpsLJFYcuI3g0s1SzBdGVcHrnP5XHCIlFFN01bn1IXDtU2BSBMLkDjiWz9Nm2ZUk2bmNKDdTV/wmgs1ZWJwtMVI8CNYlHCbOuFuxr7WXDfIQpbLY5H6OD+dbE5EObAOzpdcefPS1Qut3LOa55AKRfFHJ6kkSOm5/B3beX71LvJSDdDPRXWt1+ph6DCtUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YtdkRVfaqbIdHvTUQI7fcrPu37Vu85kRrvcBKPBpEK0=;
 b=t8IMtdg7A66358W81TZk7wwx69Bxd4UccIu0YLV/K8iJ7PwXGQdB19PGXkkcDi4njv0mePGDspNHxjJDtCLYxB+UDdNSeFBf3RzvoLVVqCIWf8qKJ4U9IFxqtLJ3VNYHS9bUe3YxtHYsWclILlaskQ3o5qjjI94oWOHKZ7fFONM=
Received: from BN0PR10CA0009.namprd10.prod.outlook.com (2603:10b6:408:143::6)
 by SN1PR12MB2366.namprd12.prod.outlook.com (2603:10b6:802:25::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.16; Fri, 25 Feb
 2022 18:06:38 +0000
Received: from BN8NAM11FT052.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:143:cafe::46) by BN0PR10CA0009.outlook.office365.com
 (2603:10b6:408:143::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.21 via Frontend
 Transport; Fri, 25 Feb 2022 18:06:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT052.mail.protection.outlook.com (10.13.177.210) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5017.22 via Frontend Transport; Fri, 25 Feb 2022 18:06:37 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Fri, 25 Feb
 2022 12:06:34 -0600
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v4 4/9] drm/amdkfd: Add KFD SMI event IDs and triggers
Date: Fri, 25 Feb 2022 13:06:14 -0500
Message-ID: <20220225180619.21732-5-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220225180619.21732-1-Philip.Yang@amd.com>
References: <20220225180619.21732-1-Philip.Yang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7e9cceb9-60ea-4338-78e8-08d9f8899107
X-MS-TrafficTypeDiagnostic: SN1PR12MB2366:EE_
X-Microsoft-Antispam-PRVS: <SN1PR12MB236605BAFE58919858BA30DBE63E9@SN1PR12MB2366.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: seUxaa7uWwp7T1qbFWpmWbDkPqDGVmlvpZlpB4q6bBUkD9sYEkMqCRkKry9D3AZ8Tyt2UwtIKQo7eqhBO8ll9Cws4r/jt5NfZMuXBixOHUxDPvP9a20SUGx3fnTnGmZTbTR8b9X7eHFeVQZ6aH0JOQo6+CPlD9Si8l2KYOQyg68+m3k910sB3hZxr/xodRIY6Q0IEJLLStGt667gSBmvCYY3wJojkb460VBYc3GLNZ78Hk6EcBfiXWNpVAjhomf5hyblRA/ONB5vR05pKiD6gtDS19sdxqVY5+lQl8u9EaDWZvPk51QPVp/cj0b873K/NTz79U/PdsX5hBM1liIAVgm7XBXqoAoN44J8KZD38Viz4E+kcpcznaaA1k1oebgfzYvbfePAWl9e6qRqWzWD1thtWhtc1vQNJp/hwGxFPsGdjDFC14Biyxm1o+lAPo371AnEQfkWnJFLRk77teumP4c6r5bQ6Sm5hlDPckSVtqV3M4IImV2wmZaNC23a76rzE+wFkNYZoDNAFoS0MMouezQbdQvDv1p/botNfbGvMixgsFLHtqBwVheYGbk8WxEwzzyIEt64vtmZx4QGkc0HVvvYWFCIJkSRCcp49gtsoY4WUwKaY2/E8R1Kg5bO8nH8Es98mHSY95YpjL7zgQ9010x7EECWNagsFuQkNg9zSO8FJIu4I9Ity9L8Y+hye6PvDPWPz1KkmBciRJf5Cq9OnQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(316002)(4326008)(82310400004)(508600001)(47076005)(36756003)(7696005)(70206006)(83380400001)(70586007)(8676002)(186003)(16526019)(81166007)(356005)(1076003)(2616005)(6666004)(40460700003)(5660300002)(26005)(8936002)(336012)(6916009)(54906003)(36860700001)(426003)(86362001)(2906002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2022 18:06:37.6248 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e9cceb9-60ea-4338-78e8-08d9f8899107
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT052.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2366
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
index baec5a41de3e..45e3c2a5cf47 100644
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

