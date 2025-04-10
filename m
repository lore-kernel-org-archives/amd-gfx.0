Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72138C3601E
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Apr 2025 18:54:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 14A9A10E157;
	Thu, 10 Apr 2025 18:54:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="THJvQwmT";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2057.outbound.protection.outlook.com [40.107.244.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2539D10E157
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Apr 2025 18:54:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MmHjGvKgJiAr9DBGA0cLMDRQBxrZ24Z+JxbHXiXF5i2Y+1SWa0B/cwMQelwlb397FaglAQuawDoPYa3NNTcWq2cZHMlWG/XosCa2zU9CamuXThDB1hXAR9Zvudc0jzWGOpE//r9NBmM0l3PX8MLuzHAeKj6QLOSFDtDNGj1hI5ZxXfai+x/w2d9B7b7gf2815yH/i1NTTzB1ItBodUdjIY9P6fKBTComeGC/NuJOY6SLMfoy/JQYBAKyat6GhAgGhLL5VZgNsyFE3gcRiO9wmULxUaWBPmQi//R4aQ1vsUi2D7N2u/InNIc9AoQWicCMx4tkQtf62lXYPvXBaEcT/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f/nay9ZVLBoMWAbAUBXGZpJEkr+wKwWOnnAIIfDWscw=;
 b=bknxcrAONU7tFU2OtCEp1POgADhnvBQva7fbyjuPcFsFN3NIKaLJUvPS58Fz221ZKAAGurzv85HH/kKWdClmW6Swq6YNYUsM87c+n2QYL9Gymqov/7x9SlbXH1Fk0IVwWb/Uc8Ll+yEJKx5NhpUhIqPputD55x6weSZ9YhLFHyNrytPUUGrErKBvkqd9E/PjAgjI4VzaH3nPeX91EiwC0MnlxzqTmJbcWaMdFwE3RLoHigK/ygrgNK1+nyTuH8CpQq+eefsr96MbNa4YF4sKu8q+KVGlz5P7c+POXs69IKxbqtHX02rqjLx5AJLuUwjd6DrvyMAkTDpEqIYLfBS5/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f/nay9ZVLBoMWAbAUBXGZpJEkr+wKwWOnnAIIfDWscw=;
 b=THJvQwmTnrrm0ROZit4KF4OxeO1ZxcRw3QGv1uMmNxFjNtS0MfJjveLskqUZwshZF+8QWyg3jGxx7uakACgV0Rb1wIyc6qw4kVUwRigmnvaM20aGV+2xiaDsFq6Q2+dgaJnp8/EcKkkli8K4dX6LXJXtSJm6CfUMpDUPJZ/wWtI=
Received: from BN0PR03CA0033.namprd03.prod.outlook.com (2603:10b6:408:e7::8)
 by SA1PR12MB6677.namprd12.prod.outlook.com (2603:10b6:806:250::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.32; Thu, 10 Apr
 2025 18:54:16 +0000
Received: from BN1PEPF0000468A.namprd05.prod.outlook.com
 (2603:10b6:408:e7:cafe::c3) by BN0PR03CA0033.outlook.office365.com
 (2603:10b6:408:e7::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.26 via Frontend Transport; Thu,
 10 Apr 2025 18:54:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF0000468A.mail.protection.outlook.com (10.167.243.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8632.13 via Frontend Transport; Thu, 10 Apr 2025 18:54:15 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 10 Apr
 2025 13:54:14 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 02/13] drm/amdgpu/userq: add UAPI for setting queue priority
Date: Thu, 10 Apr 2025 14:53:51 -0400
Message-ID: <20250410185402.2352109-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250410185402.2352109-1-alexander.deucher@amd.com>
References: <20250410185402.2352109-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468A:EE_|SA1PR12MB6677:EE_
X-MS-Office365-Filtering-Correlation-Id: ea723095-329c-42df-a35d-08dd78611794
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?iTWC7+BqAnQW3jrEaTr3qKrwvBDVoF607hddbAdl9PpHJVp+JAk4G3htKu9A?=
 =?us-ascii?Q?np5IgLcl8WymrSd6ByM5qm/wphK125iYTck7c1c7CqviDEj9Tmwc6pcSb14C?=
 =?us-ascii?Q?ZYGl3h/n0jqoHeYf1aMJFOdnKHC4iyFTke9wnV7Tz2fVcb4jkhE2jYYw66ND?=
 =?us-ascii?Q?2s7yuc3CDiaeYaZ2HjHUWUU8qyeDwl8JRlkSSmdkLXByr7d43y+/IaebITnP?=
 =?us-ascii?Q?N9a1mi1d3cXtd8BJ8EAhDd+OobF6lj7oC0EKwUqouq/6gLZ4CMIdDckWeq4q?=
 =?us-ascii?Q?kCOtcft2zypRXcIeoznUl3gvlGk+j915kF9Wb0mOBVGlZ7cNlfRJ7Cue4pKS?=
 =?us-ascii?Q?duUGMj+B1UJnOkZ90FaTbcG+yA1CBkiLex8VhD+RepBttzM1Gf76De7oQv5+?=
 =?us-ascii?Q?45elilpCjBib7CO4kCjDTu7fzixe17y1GUBREBlwFBhWRXpUJiH3EHC0kmK/?=
 =?us-ascii?Q?9sGywiLXm4SXq6SiWXtcOqzFGY7RD7lzec91pPajBuB95xYR//6mx2g66JLa?=
 =?us-ascii?Q?wVS1KVvnHNumagg/rzfJhMnb7DHq5RaNlylnm7VibLMhrAKAmnbpKaxDX3qU?=
 =?us-ascii?Q?2gSeE2c1CP8owaLEr0dTEMFyrDXnlSbAD2XxWbLjm8ELoX5gED0vit34HfCa?=
 =?us-ascii?Q?xMW5ezpAXsrG2ItsNpUNBRRj6NJbW9jetVIR6eqSi3r4d1sE2+pqpKfq7+Uo?=
 =?us-ascii?Q?jA1ac83rjMoKY2OXcbRL5afNHeLBZDEUtRlgWXs+XSIzMkU6qisEh1+jiPvG?=
 =?us-ascii?Q?mRb1OoEt4RCZOhaT652my0jh7BITXMNK3tvdk7extyaSMyK1ll685a57okic?=
 =?us-ascii?Q?dPCfKhDXTSKWLJG9ian7JMpeOvIOyua+WW5x3pr5uXe3HYPyRPJM/Hz0E+ct?=
 =?us-ascii?Q?/8ASM3/4OiM0MzIdCCe0AxQCZ6GNENdPvsGgW8zQbkW7GHaDd2DYzL70vggu?=
 =?us-ascii?Q?s7PCSxW1cMCHsbBbGQ2GKSQuRcxUVSfWgpIfSVMqFWS8TYdk+gIeleE+BD5G?=
 =?us-ascii?Q?drtC7RPP8Zei1ol/iUd372c8QikNdsaDInXhpOUjllirnvKw1aQE6NS8032x?=
 =?us-ascii?Q?4OvbeQKBfEILyM8Pt4IIfBfQ0menaKw5rZ3P2wka5tGyxLYEMqtMWfbPOGzM?=
 =?us-ascii?Q?+7U+qvVyiPekZwbCRQ3oGxYI+TmUrCHWPbyuR/aZFWjjlbILKWBhDlNszoVv?=
 =?us-ascii?Q?2I7WczXxE6ATGFbvp1nkFbSLckfZ2ksJNGA4iDqFUsZdz2zTjBNvBYycNWy7?=
 =?us-ascii?Q?16PNkG7vVLAIhcJjt3xOvIgqLDT1IZ/I1kQus+mzmTZYmRNk7uBvI3rpUK2H?=
 =?us-ascii?Q?a8MyL2ONuNNc3ywDFIwN4wbUTLC0W1iFaR3fdAybB0WFgsNC+/W4uFEqmodr?=
 =?us-ascii?Q?8wR0iA4X9vJQx8zxi6qpEIUcBjFdE0Ck68R9yb2bOBmeFBLd9G6VIoyEoNu0?=
 =?us-ascii?Q?W1dI6HNd2xxnR91LOJgFFngHFdqS/Pv8JODhe5+OTAXBG6oeYuhETA=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2025 18:54:15.8813 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ea723095-329c-42df-a35d-08dd78611794
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF0000468A.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6677
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

Allow the user to set a queue priority levels:
0 - normal low - most apps (maps to MES AMD_PRIORITY_LEVEL_NORMAL)
1 - low - background jobs (maps to MES AMD_PRIORITY_LEVEL_LOW)
2 - normal high - apps that need relative high (maps to MES AMD_PRIORITY_LEVEL_MEDIUM)
3 - high (admin only - for compositors) (maps to MES AMD_PRIORITY_LEVEL_HIGH)

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 include/uapi/drm/amdgpu_drm.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
index 1a451907184cc..8719754c777b4 100644
--- a/include/uapi/drm/amdgpu_drm.h
+++ b/include/uapi/drm/amdgpu_drm.h
@@ -329,6 +329,14 @@ union drm_amdgpu_ctx {
 #define AMDGPU_USERQ_OP_CREATE	1
 #define AMDGPU_USERQ_OP_FREE	2
 
+/* queue priority levels */
+#define AMDGPU_USERQ_CREATE_FLAGS_QUEUE_PRIORITY_MASK  0x3
+#define AMDGPU_USERQ_CREATE_FLAGS_QUEUE_PRIORITY_SHIFT 0
+#define AMDGPU_USERQ_CREATE_FLAGS_QUEUE_PRIORITY_NORMAL_LOW 0
+#define AMDGPU_USERQ_CREATE_FLAGS_QUEUE_PRIORITY_LOW 1
+#define AMDGPU_USERQ_CREATE_FLAGS_QUEUE_PRIORITY_NORMAL_HIGH 2
+#define AMDGPU_USERQ_CREATE_FLAGS_QUEUE_PRIORITY_HIGH 3 /* admin only */
+
 /*
  * This structure is a container to pass input configuration
  * info for all supported userqueue related operations.
-- 
2.49.0

