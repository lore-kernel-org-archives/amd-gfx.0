Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02D48C369A9
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Apr 2025 18:54:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3925A10E395;
	Thu, 10 Apr 2025 18:54:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="pvMg4xlu";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2050.outbound.protection.outlook.com [40.107.102.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7301110E392
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Apr 2025 18:54:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HLXHk9FtfRMiTbSD2wQDGHDM22ySIHc4hIhbCHMiGsX2f4acRN4I6/URfz5r2+bWoOPX96K1l5hMpJricaT89IEjqddYN+RW4qKG1PtJAtS4jyUAzlPEW0VanigeDBGll4wJfuh3cay4kW9aQaoJfI+Sa5D3awbCX/94YFvehM1htF1ujk8imwqGS4DTuMlvSWfrcUNHd5K3tLZL9DUiMtVEnqsvZ389pAwCy2/hH/F3Hd0twkoZypeErSAaRpSRVAdwggvXa6XeWTvWW+OA1D+kgHXKFj3dBm0nKKi0dgAx5O9oIK4TRTc6IRiodDhfY6Xmjm9C+OA5SSTKRiAuJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ys9xMvKSTnvZpyruor/eVbwShFSqgO1Q/8LOWMmHLJ0=;
 b=rleSwDOt3yHmQUM7sRIl7n56jyd70c8YC1criCdzUGuh8Q2zMRA2QeXOwVyM12ELcZeeTKNN12Z59u5Lh0eawzhcAkrrDMEdlSxwLu5dJCtzyIBW6im1+wxFs4u8CYBf1TcnVdfmzZkOxjvp74Vnky5E/R5byQm6RfkYYs/DYUTg8x4SYMDM61/7ne26aydQ2+q8/7jIgPyVqnUjJ8R4jaYVbBlTu4e44jnTeHF86CdVbaz7XleTcav2n7wPL8dXq7CSHnF7qyJ5Mz1apk6aS+vMVh5kqhw/oH9IVQ/3wnT6+V+LotuYo25ByfFI6fdar0Q9Cwg9zVqTkExiq6BHFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ys9xMvKSTnvZpyruor/eVbwShFSqgO1Q/8LOWMmHLJ0=;
 b=pvMg4xluaks/iz7gqZXVLs7Tn54DXK1JwNjDKlgG59zyhsN/NtU4Ma6J4SBQ/cliT5ACUxh5BEeH1K34l9EDNZs5ZZ1EZQCtcZqwZq7AaKziY8791t4B2JwGcJCqhXfFC6hNTPPplT8TQ9CDxsFteD7kcsmK0dTwgvlW5gJ99Kg=
Received: from BN0PR03CA0039.namprd03.prod.outlook.com (2603:10b6:408:e7::14)
 by CH1PPF934D73F2C.namprd12.prod.outlook.com
 (2603:10b6:61f:fc00::61a) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.21; Thu, 10 Apr
 2025 18:54:18 +0000
Received: from BN1PEPF0000468A.namprd05.prod.outlook.com
 (2603:10b6:408:e7:cafe::63) by BN0PR03CA0039.outlook.office365.com
 (2603:10b6:408:e7::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.24 via Frontend Transport; Thu,
 10 Apr 2025 18:54:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF0000468A.mail.protection.outlook.com (10.167.243.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8632.13 via Frontend Transport; Thu, 10 Apr 2025 18:54:17 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 10 Apr
 2025 13:54:17 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 06/13] drm/amdgpu/userq/mes: handle user queue priority
Date: Thu, 10 Apr 2025 14:53:55 -0400
Message-ID: <20250410185402.2352109-6-alexander.deucher@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468A:EE_|CH1PPF934D73F2C:EE_
X-MS-Office365-Filtering-Correlation-Id: 6bf75af2-55ec-441b-9a47-08dd786118bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?yS20VUU274AgW+U3PC1yHVHkTBcmMySvhf1q+RMRvMaJ4T5OsqJIQf0XFGhq?=
 =?us-ascii?Q?bdi5v67pvAl76sbrcevxQGjztQjxjxJ8Okzb9pJAkjR3hizxxcC7zAbec3nF?=
 =?us-ascii?Q?ooD/QK86/VzoDMfYBxZGxLNXIiuFXJcWfWeYXwvIxPaxvSf8+0EL0XNSASbs?=
 =?us-ascii?Q?87Ntuq4dmDqQyS9PFCuXP/tX9bRWBqONEb5hI6ykFT3jnNakGPcfiIY6R/za?=
 =?us-ascii?Q?QYRMmpYx+KQXN/5HU2uYDOOQreCbSNB1KMyCSXXIbIWdC7pW0jSL6bY5Ndgw?=
 =?us-ascii?Q?C3XUGiupLMDBmkG/lK4K0f5XT/6ef2YkZEFY3iE6oAX7c0fzmo/dKq/YP+Kb?=
 =?us-ascii?Q?iTI/r4zZRfnW2CL6RGgIlxKfscE8EwtsvcypJsvGYZ5GD56VHEhSZTc9Qx0+?=
 =?us-ascii?Q?R2AVQ1PQa1GK2fL5OW8DoJwSG79cE4NB36rVJTcGmu83ynoRRdgS5Nc1dqb0?=
 =?us-ascii?Q?IXtjyNbh6Fj8b+oRhCziCqkDM7q8Afed0cDKbk27VsQ+g8hj+iVIkKm4ujL5?=
 =?us-ascii?Q?KLtlsNIt2atkJvatCjkRJmvQSuxKHJdSDBglwBfaM17Vrv0G224Ea6FkbBMF?=
 =?us-ascii?Q?qR6fbooWEpjCg/BG6mmM5KPgJMZCrGiXECs2Ipm9WQN5U1mHGyNNvlC6WD+n?=
 =?us-ascii?Q?+/U9FhhHOjwr2whRKdzBggQYBNruC8F4+iJS1DjvFudpl7zwg4CrfRIGl/6O?=
 =?us-ascii?Q?AtCn3P1JHbHT0VXuaKH4TtV9YtIoNcCk2cjDBtUDQvjHn/VEYtsXmwwghDy5?=
 =?us-ascii?Q?a/9w4RugREFs2gdnK11j8AxOKKxODywJLnuDLxPXZImGIRvdgSB1Ewewk6b+?=
 =?us-ascii?Q?2oE49wz6BfV4NUuCCPeLtRfZf+4YM/Ns8X5WLKuH+JdXN5pLrsuoDDfHsMi3?=
 =?us-ascii?Q?oD9TBgVuKNGuvc6mcexUqAiJOyn/NXJhA15zaToyP9AQMChe841J4ALje2ac?=
 =?us-ascii?Q?UPM6AtGQMSDcBJ3MjXYw9nalSbn0xuyzZXEXai/cx8ApEdZPFsVe6Z38ECt/?=
 =?us-ascii?Q?A6rImlwKISZtyttRZbnIxDE1TXAaU0yZ0XLWwfDc1no4LcSvpLjcI/meQIA9?=
 =?us-ascii?Q?uhR7ViOvAiGT/6VtGDorTY5Hrz1g1V7Gjv6GD87AdXiqJnmjpvtOq95rIYAg?=
 =?us-ascii?Q?K21d+GojpPDG+tpZ0Pd4yyXiETn0jaxVW08E+4Uz2WO2wAAhq0H0kg1xMV1I?=
 =?us-ascii?Q?fR2WgfjG5RhjtmVh5VciEyBRvb8b3QcR71Sb+Jj1WPP3xofp0F/0xp6k/ozc?=
 =?us-ascii?Q?dp7cJuPGGTeFcUrtqAptEFKmIvCQ2EtjpVks6Jz9u65UtTkhbw9XrTsab48W?=
 =?us-ascii?Q?oNKqOB7EK60XznrLW66Pj6LKtlMVa/7Igg87rLmxvECSWc0TSuavPxkBF5Im?=
 =?us-ascii?Q?y7cp3ug/GOgAROh8/I0mjnhlxcCi2L0HsUnZatIv7YDES+jxMoRFi3afVFzN?=
 =?us-ascii?Q?AkCjl+KKMHZ14obys/vXqfvkDva7DblzRl1C+v7ImR3CABZf2qh+aaXrpxyE?=
 =?us-ascii?Q?xLQY9qoyfzRLNH4VDnQD3G1Eem4aA9WBX6X0?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2025 18:54:17.8276 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bf75af2-55ec-441b-9a47-08dd786118bd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF0000468A.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPF934D73F2C
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

Handle the queue priority set by the user.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_userqueue.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
index e3c3fc160b799..f406a9a29bda5 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
@@ -97,6 +97,21 @@ mes_userq_create_wptr_mapping(struct amdgpu_userq_mgr *uq_mgr,
 	return 0;
 }
 
+static int convert_to_mes_priority(int priority)
+{
+	switch (priority) {
+	case AMDGPU_USERQ_CREATE_FLAGS_QUEUE_PRIORITY_NORMAL_LOW:
+	default:
+		return AMDGPU_MES_PRIORITY_LEVEL_NORMAL;
+	case AMDGPU_USERQ_CREATE_FLAGS_QUEUE_PRIORITY_LOW:
+		return AMDGPU_MES_PRIORITY_LEVEL_LOW;
+	case AMDGPU_USERQ_CREATE_FLAGS_QUEUE_PRIORITY_NORMAL_HIGH:
+		return AMDGPU_MES_PRIORITY_LEVEL_MEDIUM;
+	case AMDGPU_USERQ_CREATE_FLAGS_QUEUE_PRIORITY_HIGH:
+		return AMDGPU_MES_PRIORITY_LEVEL_HIGH;
+	}
+}
+
 static int mes_userq_map(struct amdgpu_userq_mgr *uq_mgr,
 			 struct amdgpu_usermode_queue *queue)
 {
@@ -122,7 +137,7 @@ static int mes_userq_map(struct amdgpu_userq_mgr *uq_mgr,
 	queue_input.process_context_addr = ctx->gpu_addr;
 	queue_input.gang_context_addr = ctx->gpu_addr + AMDGPU_USERQ_PROC_CTX_SZ;
 	queue_input.inprocess_gang_priority = AMDGPU_MES_PRIORITY_LEVEL_NORMAL;
-	queue_input.gang_global_priority_level = AMDGPU_MES_PRIORITY_LEVEL_NORMAL;
+	queue_input.gang_global_priority_level = convert_to_mes_priority(queue->priority);
 
 	queue_input.process_id = queue->vm->pasid;
 	queue_input.queue_type = queue->queue_type;
-- 
2.49.0

