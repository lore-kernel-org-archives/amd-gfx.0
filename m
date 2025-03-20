Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0903C36000
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Mar 2025 20:36:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1939A10E69D;
	Thu, 20 Mar 2025 20:36:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Pyht4svc";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2045.outbound.protection.outlook.com [40.107.243.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2258610E2A7
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Mar 2025 20:36:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PGUdcE5Q85nkY8SI+Lnlk5Sjh0Z7Dt7hRT36E29yeUMClgey5HNIXMi+V8VPi0mmO7Pdbxhk/92i2I2Ko8j3NwUzlDwx1zdskabsDAXNmuxwQZEuhDHGpXIFM5orRJPsTT5KFDKGgk/WKrnBijpJ5nPl9/yW6csXzHHjTcq9/cPTOjZk3gRoEQQdzmuGEeXpCYtb8fuwUBL6WAc03Xc2tnrKtYt6OFJB+6Mt47faho6DGluDvsOy7tjcF5OblC5KTjth75x9BTzOjZQqYF7KjOFdhnjvZACenT/XXN1mkxSrrAW+TQ3C3gWpKxXQvFB0RmZZnFocLtJ60d9oOxGxBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fIPEOEApjLz/hicdCaT61xo2EMof6RXsTkOJe8wrgQ4=;
 b=Ce/LTk7quQ7gv7FqN3lUv5fAp0Ql7G+Q3QCvdnZ4BA0hns29MtYDo3rut1UYutb6uPugtqQ4J9cz8V6FDpo6FHj6gUTHa/dVMtC2O8kKpBpKoCH55AlXdJPoj43vzHtinC7iFdquUQTwttBUkmSZir8tAMAovu28xnxwSopoWAvtj6f2SFu910jkY0LTfalRwQ4Xp7whXEnfZkO6qIZwZosO/WEcc36fv4CC9VSgXNSsiwfgWQwLTqy3rMsMLMuZ7mACzXHLg73GzDInurQSYS1SU4Xwhzi14y49BjdmD86hHn1S+F5pmHrWMq5q/AoW16rmUhZe4B8hy/Ho/rW/Kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fIPEOEApjLz/hicdCaT61xo2EMof6RXsTkOJe8wrgQ4=;
 b=Pyht4svcFK1IExkjW60/W8J/HL+QTIKMNT6yqlsSWHpShNeG+Q6OGd26uDHDe2gbN8YgBbQ2g346cEzWosdDyN3kmR9c33u4gvEYKZurj2JVuWlrodLLkuc5uDeQuBSF6kb4oi3nE5iVZG7OIpt7VtoZvjOJ0ZBiJc+427iahJ0=
Received: from MN2PR15CA0053.namprd15.prod.outlook.com (2603:10b6:208:237::22)
 by SA1PR12MB8858.namprd12.prod.outlook.com (2603:10b6:806:385::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Thu, 20 Mar
 2025 20:36:13 +0000
Received: from BL6PEPF0001AB78.namprd02.prod.outlook.com
 (2603:10b6:208:237:cafe::25) by MN2PR15CA0053.outlook.office365.com
 (2603:10b6:208:237::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.34 via Frontend Transport; Thu,
 20 Mar 2025 20:36:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB78.mail.protection.outlook.com (10.167.242.171) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Thu, 20 Mar 2025 20:36:13 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 20 Mar
 2025 15:36:05 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 3/3] drm/amdgpu/gfx: assign the actual me0 queues per pipe
Date: Thu, 20 Mar 2025 16:35:49 -0400
Message-ID: <20250320203549.1345822-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250320203549.1345822-1-alexander.deucher@amd.com>
References: <20250320203549.1345822-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB78:EE_|SA1PR12MB8858:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f7d9e53-10a3-4cb4-b4b8-08dd67eedb14
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?EvLfFY8KW9a4vvpkZAckT0k5vCZqqolLj7aZe7U6IQ5Raxvjg5POCfM0QZKr?=
 =?us-ascii?Q?4YMfKD4tBk+wklE60bitfa+s/iQy5ydNWF3QfmQOrGCxwnwDSzfxPZKQLbk2?=
 =?us-ascii?Q?dUxHoNW40cvYjHvtBQsYoCc27lKqsuLHva8E4cK8kcuzLyKjtGycUfTizLzR?=
 =?us-ascii?Q?z0v9whjm+trupQz9W5lwwHDHj92+adnfkmZDFCfU++L045CTlaOTwvXU59uj?=
 =?us-ascii?Q?+hr/Y7hZ2fs/0EFsOqPYY8tNefSq3psu3kJt7kFVr1O+eQ7rP/IIfMCV9EVH?=
 =?us-ascii?Q?rgO3Ma99uj6Ju6o41NUFG/0M7AebRamfixL9UmPCnLWcF6fXOOPTVTEQZ7ZC?=
 =?us-ascii?Q?Hc3+mmeTnrsjcpgd4Bkd4hfZxfWX3Gl+E93piqYYwaytJX06Gt3voYZHNvLt?=
 =?us-ascii?Q?h/QpQpMYbKGQtYw/wCXoXHY3a5bY2KG+jMyi3X0QG140IDntQrbOs2n3AQkl?=
 =?us-ascii?Q?X788GKEl7IZvFAzWs3N2PcHpPS5XM7+2dSOhHg8lBJQU+oZCOi/kHc9pTOa6?=
 =?us-ascii?Q?2Cjp+IspDY5YFs7JevTJi+7VE4jWcf6ONw+PlchU50UqhtQ4BMEZU4BTkq/z?=
 =?us-ascii?Q?X+zTO6cleGsSi4sNphO8pPFL/VbBoPSFeIL5M9FRbG5BjoxpORlFfy52KcnT?=
 =?us-ascii?Q?96kQvurFs99ID6MugUNdpv5U2wlhMSIPy9WW67MQ9/K8Pxs6TECVI5mdyTZZ?=
 =?us-ascii?Q?2e5yMghLK1+Bre7Aj01esIi0vx31VdBLAC3O1aQ9nFrTiRievkCgfLNI3kI/?=
 =?us-ascii?Q?FnhVg12J3t9BFi1153izaK9XUPPWegOpRrniIET40YttA8ZJuiP05Wo0grlY?=
 =?us-ascii?Q?QcvYXfRWCCHSHQjQ1HWlmUGcRysktNDk2C5GKJjIPIOJqxazZ5Rc/K2AUuCN?=
 =?us-ascii?Q?d3iOLSc7T1IVqAPfXGsmTAwVTJc39bqUF88iE/7puGy+jYGPMKXPxBrW9WFV?=
 =?us-ascii?Q?6AV8MSft7ab0i3fAEmjK1LGknbnhKqiCIN2bm8rAExsv0e10RPo9O0Hi+ycQ?=
 =?us-ascii?Q?yQRA9RNBYCmrQz7dKTkthOrJeHPeIhb81XdO51TcfcR1ZI9HIiNRAtJ6G2vt?=
 =?us-ascii?Q?eQZOOYsKnmleqSDn99WhxdOc4rmvEq27958Xb+6KLAmAUviCAzNZaMu1QUuZ?=
 =?us-ascii?Q?0ePN6AbFORC/XYAzhskpBW0hA7wGMtWu16bA1tDMaB4FQcqdqRsSAxqYuLQd?=
 =?us-ascii?Q?VKia1+972NqO9Fp695RedYHLHIMeVtujTCoowxcIW4GDYSCJiFFogQLRS9GH?=
 =?us-ascii?Q?Vi+zhizSKuT5ooD9XnkS7FDQ9djoCycWQgOpkd0woxqwdQDWT90G7EmqmLCe?=
 =?us-ascii?Q?RKGXpfFdtDNLNwl073PcCCDuzBe0fP8lYulD+r3qq9K16JaN6J9fi5DNBl58?=
 =?us-ascii?Q?Fhcu6smT456IdZuMaY7pj8o9ny6f9bhUa+7GFl9JSlIlaIee4usdXFwKScmG?=
 =?us-ascii?Q?xT3gFy8lU8Ib9k0RoJZhj9PnyfHjOAIUuwyfgasha3gMM6uq/ZVGNQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2025 20:36:13.0516 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f7d9e53-10a3-4cb4-b4b8-08dd67eedb14
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB78.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8858
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

Set the actual number of queues per pipe for ME0 (gfx).
This way we will dump all of the queues properly in
dev core dumps.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 4 ++--
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 4 ++--
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index dd7bcf87dd1ad..0f0dc04d4664a 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -4793,7 +4793,7 @@ static int gfx_v10_0_sw_init(struct amdgpu_ip_block *ip_block)
 	case IP_VERSION(10, 1, 4):
 		adev->gfx.me.num_me = 1;
 		adev->gfx.me.num_pipe_per_me = 1;
-		adev->gfx.me.num_queue_per_pipe = 1;
+		adev->gfx.me.num_queue_per_pipe = 8;
 		adev->gfx.mec.num_mec = 2;
 		adev->gfx.mec.num_pipe_per_mec = 4;
 		adev->gfx.mec.num_queue_per_pipe = 8;
@@ -4811,7 +4811,7 @@ static int gfx_v10_0_sw_init(struct amdgpu_ip_block *ip_block)
 			adev->gfx.me.num_pipe_per_me = 2;
 		else
 			adev->gfx.me.num_pipe_per_me = 1;
-		adev->gfx.me.num_queue_per_pipe = 1;
+		adev->gfx.me.num_queue_per_pipe = 2;
 		adev->gfx.mec.num_mec = 2;
 		adev->gfx.mec.num_pipe_per_mec = 4;
 		adev->gfx.mec.num_queue_per_pipe = 4;
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 4ae85d769957b..130c5ec2b25d9 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -1603,7 +1603,7 @@ static int gfx_v11_0_sw_init(struct amdgpu_ip_block *ip_block)
 	case IP_VERSION(11, 0, 3):
 		adev->gfx.me.num_me = 1;
 		adev->gfx.me.num_pipe_per_me = 1;
-		adev->gfx.me.num_queue_per_pipe = 1;
+		adev->gfx.me.num_queue_per_pipe = 2;
 		adev->gfx.mec.num_mec = 2;
 		adev->gfx.mec.num_pipe_per_mec = 4;
 		adev->gfx.mec.num_queue_per_pipe = 4;
@@ -1623,7 +1623,7 @@ static int gfx_v11_0_sw_init(struct amdgpu_ip_block *ip_block)
 	case IP_VERSION(11, 5, 3):
 		adev->gfx.me.num_me = 1;
 		adev->gfx.me.num_pipe_per_me = 1;
-		adev->gfx.me.num_queue_per_pipe = 1;
+		adev->gfx.me.num_queue_per_pipe = 2;
 		adev->gfx.mec.num_mec = 1;
 		adev->gfx.mec.num_pipe_per_mec = 4;
 		adev->gfx.mec.num_queue_per_pipe = 4;
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
index 4e0327f7be180..0cd713d2ef0a5 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -1398,7 +1398,7 @@ static int gfx_v12_0_sw_init(struct amdgpu_ip_block *ip_block)
 	case IP_VERSION(12, 0, 1):
 		adev->gfx.me.num_me = 1;
 		adev->gfx.me.num_pipe_per_me = 1;
-		adev->gfx.me.num_queue_per_pipe = 1;
+		adev->gfx.me.num_queue_per_pipe = 8;
 		adev->gfx.mec.num_mec = 1;
 		adev->gfx.mec.num_pipe_per_mec = 2;
 		adev->gfx.mec.num_queue_per_pipe = 4;
-- 
2.49.0

