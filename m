Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A92CD5B85B
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Dec 2025 18:16:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 050EB10E4B6;
	Mon, 15 Dec 2025 18:16:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="FF/+TxPE";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010057.outbound.protection.outlook.com
 [40.93.198.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 38FEC10E4B4
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Dec 2025 18:16:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nefa8ofPqlW6+MwjSjTfuRw8pi2y7pitcOchQ8EEubn56gPSim+B4ViY3sy38RipSdEMpgEIbx0V0DMdTtSbNK/9SzPkAzKTE5pB8S1rFyN79vEUBZ72ucB5f8quGzEd7hKN7cIOoFsX3mgcu3YapW2apao7LViqixQ+L+BKK4+N+sifbh1qi0BIe+B9O+s+D/4Ayccr9XBGLWJ7asrR0V0SAzdD0M17MNPygJXPORYlq5hX8EHJ7qirYYGZrQeXB8fh+M2yHo8oW4ijc6+l/a1FmVEDHf70T5kRPlQGfF+JSKfW5MCl7ccwfRrg5ZbU4wtKrshI32IPsUPGwxfoIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K9Wt/Dg7dqQEchQAhoO+qn+kiJHflub8VjgRJlT1FUY=;
 b=fGfcqTaYJqyQviIJ6ADD2bPp5LM736XxPiAQHlXVH/UY9NX+YWfoUuWnTfOvckqZ9LTVnXmxgp5MXIGJ3KSPUn8zdKZOyGCRz4SB1G/7oRDEqckeyuAaR2Z/Tu+6udWpiCOt/ayHIYLZTKnovs8qA2TcyoJALcBvifmR7GM1jJMZ/ln9MUfmoE7T+l4oI7a0zt3xOb4eItL7txQ3fT+UNOIL+TQRmSiqS11GT9pVJfgVt3FMDmw5DPq5UpD7FXfnfnBsxZ7hFyb7EUFXfF3+V5NGzlxrdx7RVRpXRjx1Dek/oXjTz9WfLllIJ8LopPSGPP1RhZRLF+EKgZ2ZzkgG6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K9Wt/Dg7dqQEchQAhoO+qn+kiJHflub8VjgRJlT1FUY=;
 b=FF/+TxPEzJusG2Nh3TXaERQ5vJb8cl08pV8kEJLCAIrkvhDQGvQGYbWL3cQucXc9GKXenQSPDeg5uFC6oPcvyWrNBa1016rBEjLWVLXnqwJsMmsmm9uNHeZtW5lnxI0trVLY/fUbrS7k1sMILASpE8jsr1Bh3vaTRYUpakBeUug=
Received: from BL1PR13CA0225.namprd13.prod.outlook.com (2603:10b6:208:2bf::20)
 by MW4PR12MB7310.namprd12.prod.outlook.com (2603:10b6:303:22c::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Mon, 15 Dec
 2025 18:16:20 +0000
Received: from BL6PEPF0001AB74.namprd02.prod.outlook.com
 (2603:10b6:208:2bf:cafe::c1) by BL1PR13CA0225.outlook.office365.com
 (2603:10b6:208:2bf::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9434.6 via Frontend Transport; Mon,
 15 Dec 2025 18:16:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0001AB74.mail.protection.outlook.com (10.167.242.167) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9434.6 via Frontend Transport; Mon, 15 Dec 2025 18:16:19 +0000
Received: from tr4.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 15 Dec
 2025 12:16:19 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Jack Xiao <Jack.Xiao@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>,
 "Alex Deucher" <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu/gfx_v12_1: add mqd_stride_size input parameter
Date: Mon, 15 Dec 2025 13:15:48 -0500
Message-ID: <20251215181607.29132-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB74:EE_|MW4PR12MB7310:EE_
X-MS-Office365-Filtering-Correlation-Id: f9cf72e2-556e-4799-f2f2-08de3c060be4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?N7eBwlIyXc0ZL7VbKJG41R8MLNsIz+GerU0ZqZogY4rEmt95UkqJaLFloREF?=
 =?us-ascii?Q?tHp6VPBKD2Bch9lEKcIAn76wGiGCk/jmz4tyQX8mZUeFF766d9i7004dLiPe?=
 =?us-ascii?Q?t/mwDchHIWHMQ/enwO3vzECWKgoLUZozrUiuZqjYjAZsPZkvApega3Fq0kEn?=
 =?us-ascii?Q?zmReMjOQgPvIqGVHDCSAbw48p15HXrRNl5AC/T2rj0VC/VJJr9YSnxFGzNIF?=
 =?us-ascii?Q?gWWdQsSJ4XlKZusHX8xCZh+0SdJP2QjUS3TxK4tia39IM/Ees6xsf/WEOYr1?=
 =?us-ascii?Q?v9dKmjIRa2ZRodiBgkhlAlIFk9/t9qoWzaGFetu+fcCdsyWBn62AorgHgDA2?=
 =?us-ascii?Q?Sng1agulQS2BI9LrqS+t5v3Q3eMBVHjMHaUs0+W13rgtjNzrqonKTCeG+rgs?=
 =?us-ascii?Q?PqC04ZEIAkfwnn310YcHeJXADSFkCvf4VZWDnjqt0B05/EHMEuwGR4/9buaH?=
 =?us-ascii?Q?TiD48nlvS6rhJPcVaAHQ1k5KFBX625BCM86dHvpn8tg9qLt7LRDQ60foCIkJ?=
 =?us-ascii?Q?FlsvqRmLyx40PPe8L80p3JiX9uScPe/Ot/hA7ynBuGcYFiqcmuhdOMote0US?=
 =?us-ascii?Q?hhfMiLV9qrQ4HA/QoVp+KNLVEMzi8Le12ry2H6+fnTowJ4Lf4GLFqWTfVhgE?=
 =?us-ascii?Q?V+WkpY9eez24N7JzglIoqfOSp5JXzdO6gy0LeRQW4AaTETwG6E9YdV5Q6GB7?=
 =?us-ascii?Q?gjBTGMQtZjl/TiBsSKwrUDSc7gGQcdXYkUUxpLxzd8DL0LQOCxy8meRohNYj?=
 =?us-ascii?Q?fsWosMqsChA7x49pw28EHhX992KvvZdHIbJx8AEBIvTD1VpV5J0zQ+jOZNE4?=
 =?us-ascii?Q?+pJPJ+d8kFR0uzIYMR/abtpcNpkxsWxzRnA7GhHHlrSus7Swc6QB9iZPklKY?=
 =?us-ascii?Q?xKYmE7XDwWzbxCNqMBFEQHFNXuNsF4+TrT+XTNblpODLeOf+jCB1CCpcTnpV?=
 =?us-ascii?Q?A/QTWse+DJwcPDhNp8kSkdCLPOxQo0EpVPER0VA2hxSsoIGIQZQXI+yDMWcI?=
 =?us-ascii?Q?Wzrx9ADQbqZA/HK23FM+iBVUkvp2D32R0NRMOagEeV5VapYKU0sB13jBCg4l?=
 =?us-ascii?Q?PEAMf15Lmj7YqkoT+495R/bQ3dhrDcGtbcBRjJeWZhffbOzw94wDT2oeHLJz?=
 =?us-ascii?Q?JU+mSSzBizSsFBRRxiSoXYaP7uLCJTYjAlG7r6irGdQNpjdh3LXRRfzrEfKC?=
 =?us-ascii?Q?c6NkkcycTGT0ve2vzOB4Jihfv/odajt97C4HO0Jt8L58NWxgbwcjUpzgx8dx?=
 =?us-ascii?Q?dR+g3vazhehwAW0ZXOucjfi7eFgLhMJtvOF4pbkexyzJNooaV4BRHwvjlSCA?=
 =?us-ascii?Q?0kdHe/pXzrIwjpocWErLh4jV0/3K8h2dPWP+h9RRBCbf/u1c6CtFDS5Zw3T6?=
 =?us-ascii?Q?esbP2XAwvMgo5g45pzGLwbTHbjJbZ2CgJwULVqzc/kmTte5ZwxdBaK/OTdQc?=
 =?us-ascii?Q?vX6UPLXL02y9OmaspPbEnZpzF2FgDA2d+V09DXm9Op14Vigl6Ri32VCBS21g?=
 =?us-ascii?Q?Hbk9QGSHgNipDyxkEoWxEKLXsjMYKZlJDIcNpsbGgdz+2FrKF++c3HiXjS1x?=
 =?us-ascii?Q?7FIy3vqdtz2+Eb+5sTI=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2025 18:16:19.9807 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f9cf72e2-556e-4799-f2f2-08de3c060be4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB74.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7310
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

From: Jack Xiao <Jack.Xiao@amd.com>

mqd_stride_size is used to calculate the next mqd offset
for cooperative dispatch.

Signed-off-by: Jack Xiao <Jack.Xiao@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h    | 1 +
 drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index de8fb746daf17..91a9236d19d7d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -774,6 +774,7 @@ struct amdgpu_mqd_prop {
 	uint64_t eop_gpu_addr;
 	uint32_t hqd_pipe_priority;
 	uint32_t hqd_queue_priority;
+	uint32_t mqd_stride_size;
 	bool allow_tunneling;
 	bool hqd_active;
 	uint64_t shadow_addr;
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
index 6a4ecded103aa..0e57c367d9819 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
@@ -2217,6 +2217,9 @@ static int gfx_v12_1_compute_mqd_init(struct amdgpu_device *adev, void *m,
 	mqd->cp_hqd_pipe_priority = prop->hqd_pipe_priority;
 	mqd->cp_hqd_queue_priority = prop->hqd_queue_priority;
 
+	mqd->cp_mqd_stride_size = prop->mqd_stride_size ? prop->mqd_stride_size :
+		sizeof(struct v12_1_compute_mqd);
+
 	mqd->cp_hqd_active = prop->hqd_active;
 
 	return 0;
-- 
2.52.0

