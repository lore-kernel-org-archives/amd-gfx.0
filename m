Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C092CEDD8B
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Oct 2024 12:14:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B457310E29E;
	Wed,  9 Oct 2024 12:14:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="S9lh3Gb+";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2088.outbound.protection.outlook.com [40.107.237.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DEB0C10E286
 for <amd-gfx@lists.freedesktop.org>; Wed,  9 Oct 2024 12:14:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FbxxBOA0dlvwZ4+8pu+/8NA0e/QqkC9yW5D/V8HrH/QkaJl91swXxLpGXlc9HAApHiadsopASY7586cArM9FaoL9QYKeP6Jkoa7PJMwXW66w/GBLqwu91//Ih/J9npliW5Dm0VEDVl5ml2/ibJ/5V33T8rrp/Y9n1XVZgfMIh7RWO8stmeUh3MeKtgVAwW/hzKdiGwpSLTa0ob707BKNTqRDfBV+J17UrOjBz6Zh18tqWgnBNXLj0ZZJd4T7KvcwDY8z6oKhUDpK6c7bWURdfg7DFaWzEaNXjY5rBubPMxPQwmVZCZua2T3p+HfFSuzJIPiPyZSxNGWkX6vXRjvKLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yJg91dsvtncMt+Bd8FGDQ2MLnfoNuDoSQ4u7wUOQHbc=;
 b=giT3cX8zmSmEJfutyhnk9LAL2Aea+z6iJ4E1nTp2DL5zohoLDuqsn/5i0zViae3HMgpSOXEpVMsVWtQl3NRvoaZBul5VI+zPmKb0vP+CA8JdLYbNJWhry0McM4B4Q4b9Gd8Q7T3SoH2tjyDfvhr4/bsVaGpeiZNvawoZg1N7D9bVMJjNAPBXVTkg5yY/tsucsRqsRTKI+S84pYWNPUOZW0BDfGv7L0zyo55xq45/1PElOuZQNV3WKm8LBVAyviPn/9EeRnJciWg6/DXRO/sfjOZFp0LjL2l6UlIld/rbQmxNJbIDlZU6BzyYC4vP2lm1qJO8p49h1vyhQUXdsCnStQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yJg91dsvtncMt+Bd8FGDQ2MLnfoNuDoSQ4u7wUOQHbc=;
 b=S9lh3Gb+bx/TP57VhpRZs2+RvGR3XjRFDVnPoCaBb9DU62I6OJ2X6eCWwEQMrwl+jMbiZvlFXTRw6hJbsVrq/CnwVmdjqYryfcI5a6tthJFVlhPVbTcmPn1oymFHG+cLZI7lOc6yi/W2YaT0XZOuCOxBNh37k3nZN8h2iAE2lqg=
Received: from SA0PR11CA0096.namprd11.prod.outlook.com (2603:10b6:806:d1::11)
 by LV8PR12MB9136.namprd12.prod.outlook.com (2603:10b6:408:18e::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.23; Wed, 9 Oct
 2024 12:14:42 +0000
Received: from SA2PEPF00003F68.namprd04.prod.outlook.com
 (2603:10b6:806:d1:cafe::bc) by SA0PR11CA0096.outlook.office365.com
 (2603:10b6:806:d1::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.17 via Frontend
 Transport; Wed, 9 Oct 2024 12:14:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00003F68.mail.protection.outlook.com (10.167.248.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8048.13 via Frontend Transport; Wed, 9 Oct 2024 12:14:41 +0000
Received: from asad-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 9 Oct
 2024 07:14:38 -0500
From: Asad Kamal <asad.kamal@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <lijo.lazar@amd.com>
CC: <le.ma@amd.com>, <hawking.zhang@amd.com>, <shiwu.zhang@amd.com>,
 <Asad.Kamal@amd.com>, <charis.poag@amd.com>, <donald.cheung@amd.com>,
 <sepehr.khatir@amd.com>, <daniel.oliveira@amd.com>
Subject: [PATCH v2 2/2] drm/amd/pm: Fill pcie recov cntr to metrics 1.6
Date: Wed, 9 Oct 2024 20:14:17 +0800
Message-ID: <20241009121417.346166-2-asad.kamal@amd.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20241009121417.346166-1-asad.kamal@amd.com>
References: <20241009121417.346166-1-asad.kamal@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F68:EE_|LV8PR12MB9136:EE_
X-MS-Office365-Filtering-Correlation-Id: 10800aef-40d8-4b93-5a97-08dce85bf448
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?JR4gSsAULg4lVe/utoFlBlXea3ZeC6IFpYUPRXhXALqaIVHjVR0oGQT2fX/v?=
 =?us-ascii?Q?QqWYa0xFw12Wy0u068WPzda46vaD+05vkQKSWS1YTpVr/kjY09+kYmA1UC1h?=
 =?us-ascii?Q?MGYMR0Zk64Thxa4mKzW8ov/jmgSJ5T5wi5UZPkbVQZk5Z0cOv/jGfTbO/PWP?=
 =?us-ascii?Q?NOIg1/jGheVLsuluAsP+5WS0b8ZBoZsUZ5XSq0gMz3+iUC7zAzLX3f+PXzqr?=
 =?us-ascii?Q?yfayeLugLlT7UI36pwA516+XpelDLmD362znNGmcv+yAEcJETcvDzpEgezHw?=
 =?us-ascii?Q?rsLzDhKxPFtSlRzJsdeg81HHUUGnaT13mHl3PUZAGglYDFKZYWNF5qtf8E8A?=
 =?us-ascii?Q?gq/CDb7BgKHpgBaL8XiNDMwFS/uTbOLKgWiYl9qJ5IzC0snaINIUdZMiKw7j?=
 =?us-ascii?Q?F4lcozqiHv2ATHiAJ7q9M8f5qLkknEGKt0djrBidvxv2HkeNEDw0ARahUgxL?=
 =?us-ascii?Q?UgNprjTp+WCRGOCkXk1x0ysDtQm3eyKn0DS7n4H7UWyPjEawrRpcsVh4jX7r?=
 =?us-ascii?Q?eCaIknjDKED4lAmFhakhCTTdyDkQmHLd2G4JYtU2Xb6bdy9TIRu1qFHWwUsM?=
 =?us-ascii?Q?v+bwBg8op4AEo2fCpxM58jI4OmSz0XBN3Dkv3YknrvkSN0B6LZi67YXhEJXa?=
 =?us-ascii?Q?7K1U+XOMgbGz5XPC76yBN5N4PBsoO34cdo2m63iNyqrweSQUl+MKo2jqOXI0?=
 =?us-ascii?Q?9AeM/qLYyRyVHdq3KuM1KtdAJNesRNTEBsdQR6JbI8KF14zarve8w/ULeh44?=
 =?us-ascii?Q?l31T7zL/KieOyvXzFLPn4yXZ1/JLT7mr7WCzRRmiCCZ9ylIPAJASfwZbEbM+?=
 =?us-ascii?Q?tML4rin2+6APJeqc6dlwGkfJfqbG9sx8X23gw4qN1AVmSekOJqtmuIA5NWml?=
 =?us-ascii?Q?VkY21CvDu8+LQulSzC1wlcrVQhoLqvzpVcAbAjblgQIW56xZmLp7FOr/v2Sv?=
 =?us-ascii?Q?7gThO1f6hCEZsHev7Hz+NWbDinh7T9hRPfc1OKt/nRtGteOjtayYUTmFmq0U?=
 =?us-ascii?Q?CKx/2dm0x1bn5A/RDN08mxJZNB+26aHqi0WZDQ1qaXrtn9NDjcLDcnZAPLlc?=
 =?us-ascii?Q?9HmDQFsh35fcS/vRqS0COd4hmumZQp4i1N1ev3O4ZlhWQnGZdEgDegVuth8n?=
 =?us-ascii?Q?jrd+v1xYah9cIs8d0jsh1Cg/QpCKxAJCe3vZ21+BpvUPIw1s6RrvXQ81zy+P?=
 =?us-ascii?Q?HHVoJpSm4T9dv0Vg9RCyb9LYVdbtdhw8AK7GnQcggk62ellcn+rRj5vD7w3v?=
 =?us-ascii?Q?EeztAeWxj72RMhPNVGEnboyI/PnXnp5iNv5U/uoZCC978seq/1+96619vO8A?=
 =?us-ascii?Q?DMGB01OaAcY7XuS2q+1qupeqRJ5HlkW6sANIn7kCz5QhL4yUrEvh8doSGvXT?=
 =?us-ascii?Q?B00+oG0=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2024 12:14:41.7036 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 10800aef-40d8-4b93-5a97-08dce85bf448
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003F68.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9136
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

Fill pcie other end recovery counter to metrics 1.6

v2: Add separate function to check recovery counter support

Signed-off-by: Asad Kamal <asad.kamal@amd.com>
---
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index 52f3c537bb3f..91297590f006 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -108,6 +108,18 @@ static inline bool smu_v13_0_6_is_unified_metrics(struct smu_context *smu)
 		smu->smc_fw_version <= 0x4556900;
 }
 
+static inline bool smu_v13_0_6_is_other_end_count_available(struct smu_context *smu)
+{
+	switch (amdgpu_ip_version(smu->adev, MP1_HWIP, 0)) {
+	case IP_VERSION(13, 0, 6):
+		return smu->smc_fw_version >= 0x557600;
+	case IP_VERSION(13, 0, 14):
+		return smu->smc_fw_version >= 0x05550E00;
+	default:
+		return false;
+	}
+}
+
 struct mca_bank_ipid {
 	enum amdgpu_mca_ip ip;
 	uint16_t hwid;
@@ -2417,6 +2429,10 @@ static ssize_t smu_v13_0_6_get_gpu_metrics(struct smu_context *smu, void **table
 				metrics_x->PCIeNAKSentCountAcc;
 		gpu_metrics->pcie_nak_rcvd_count_acc =
 				metrics_x->PCIeNAKReceivedCountAcc;
+		if (smu_v13_0_6_is_other_end_count_available(smu))
+			gpu_metrics->pcie_lc_perf_other_end_recovery =
+				metrics_x->PCIeOtherEndRecoveryAcc;
+
 	}
 
 	gpu_metrics->system_clock_counter = ktime_get_boottime_ns();
-- 
2.46.0

