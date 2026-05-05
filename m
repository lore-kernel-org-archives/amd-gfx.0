Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BFE8CD343C
	for <amd-gfx@archiver.kernel.org>; Tue,  5 May 2026 08:16:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0588310E9CC;
	Tue,  5 May 2026 08:16:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="NzaIW5pi";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012044.outbound.protection.outlook.com [52.101.48.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B016910E9CC
 for <amd-gfx@lists.freedesktop.org>; Tue,  5 May 2026 08:16:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pCbtpwi26blGGbSGIdYdT1BZSTlRHjKvpZKIhOcG4cK3xcEzqaTuu383fnlNA5+G2/VGyj9Tu1EL8bckBEAtuan1aDWfCD66EUvjvyhOcMIyRB/sSOEyqgXfgvIzlKB1SOHwHhhRBDTT0W/qCXo0f0ofV1EP/elusqP/NaTtr070AMhvp6LmYLIsSTm+8sSRvYY62xo1MxWUjTYgmoY0uAsXmh1l4o+A4i1uTp4BykwXWqVvaYI3QttFyOfx6nUXu7WB4EocdUj45sEWf4j6bxd6FaLAhnAqdp1XG8YPzjhtT9Xe0sAsepB4Q/LCEknI9wsb3sarSRioOYQIwET8IQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aaXoQRpwy8fe37eYI9jLHIxqTk6hV4nRIXMMYSFtTPY=;
 b=UUfhcplRQVxURCW0XQIMZZ9vWrPCVI4nHiSYTDkG+dEiZN600e2/02VlpsKAr+iuXQ2QpKcZP92Zu4qud5TkMORFAw4XQ20CWBuNrqp4pi7hNuk83WWVKam6luDbDb46JlgSuX+e5FI87hX2APwIURRXRYwGDBa36qD69Xg5VAycfy/lBTorLsrEiShrYvDGJd64Lf6j7BcpC5tt0iDTY7Y8D2xu5po+xfZKgWjigpLamyK0F8LRPdKc6e7HWVBIm2CGyDxMrIqrY6In5D8MnRB7hfK5/1+QnxwgnlWV0TOJuJFL9uWpiB9D+ShYYzmkc39v3niW9pXBkwZVepbHRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aaXoQRpwy8fe37eYI9jLHIxqTk6hV4nRIXMMYSFtTPY=;
 b=NzaIW5pirzmPujqOBoinRvbo9s1LFWPfitHMMOODweZ6crf3YfsMH/dReCl6KND3aWXpWVWnndSpQ6xf+waARe39k886RvqWfGAzSp3hJaNhBWJrBmdEdVBIfwjNyQEVKxfxpAmKFvCZQN1f5il+9W0UMiaxE/kvp8GjKGsCH5g=
Received: from CYZPR05CA0037.namprd05.prod.outlook.com (2603:10b6:930:a3::21)
 by CY1PR12MB9699.namprd12.prod.outlook.com (2603:10b6:930:108::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Tue, 5 May
 2026 08:16:46 +0000
Received: from CY4PEPF0000EDD0.namprd03.prod.outlook.com
 (2603:10b6:930:a3:cafe::ba) by CYZPR05CA0037.outlook.office365.com
 (2603:10b6:930:a3::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9891.15 via Frontend Transport; Tue,
 5 May 2026 08:16:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000EDD0.mail.protection.outlook.com (10.167.241.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.9 via Frontend Transport; Tue, 5 May 2026 08:16:46 +0000
Received: from caden-test (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 5 May
 2026 03:16:42 -0500
From: Caden Chien <chih-wei.chien@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <alexander.deucher@amd.com>,
 <christian.koenig@amd.com>
CC: <HaoPing.Liu@amd.com>, <Solomon.Chiu@amd.com>, <Peyton.Lee@amd.com>,
 <Yu.Wang4@amd.com>, <Pratik.Vishwakarma@amd.com>, Caden Chien
 <chih-wei.chien@amd.com>
Subject: [PATCH 2/4] drm/amdgpu/nbio: add doorbell range init for vpe on 7.11.4
Date: Tue, 5 May 2026 16:13:10 +0800
Message-ID: <20260505081312.14047-3-chih-wei.chien@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260505081312.14047-1-chih-wei.chien@amd.com>
References: <20260505081312.14047-1-chih-wei.chien@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD0:EE_|CY1PR12MB9699:EE_
X-MS-Office365-Filtering-Correlation-Id: 67cd8dbf-647b-48f6-13cd-08deaa7ea615
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700016|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: ywYjW4yhjO/OK7pn5BX1E/TSRhTkCOLiNKlaI6+NaIrxUsIMuueLBpQBZv/agex58ulG6HB6yRQUFWQ5kq0RBFbyu0gRFnRpfMMl0vpG/+9qGjU6wTmJL8WWp4yR2LyRCqUpQtAqqcwXeS7RyW0TbGEyhX4Qq5Ig/n/bVjLaef23Keze6ruqRkPTSAfu2noy3JLEMJ8476YuYsf/0VqVnLyn4OUWLFHj5ZrsL2lrNKNlFK8sotuwpaw9pubrUe2CPS4rnFVGeHSeytHZ0O3D2IV3BeC4rKcaHWG06FpXBkPfEwxdlpJeAEF0/VD6Frsii2qiUydlex7oYj8TrYqQd3t/fu/tCZedj/ULYsDIioFEMfbyTYXmekBwxesg7lHKKUdAYEi+OZ9+ij//lLgGoOV81hSN7hBiNkvWKYm0kfcUYFwyjn3ULHK0C9qVjWJfkrMlr8ZUP7rfkRc/Y8CgMsWM3GenrxPUCvr2QR8k8tzcl0G+h6tVeGPOtV02yNb3D3iJ7Y7SZIhegzugaDV9DpPXodgcw6gJDT9zzK+iTEk2mtTTHFVaGNlvRC/JkAwIsfrCeVs9NV8dat5imhzay0YiAlNC8QPUARG/18GzG7NdI6QeBT49CKO9eXgU/AMueIJ9DOwnyzy7O7kf6T2wbbjHaNnCYO7sDFxye0AnCTXMy7+oSU17+svTKhBxZDy1BciC+QHpuH5E4z/qc+P7BNLm6xeCOt2cF1TRgwu9eBk=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700016)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 3hVCV2FjiQwByiGGi6wRfda9el/h2OwWw1qULTFqBiOiC2oXSkoDyWaQeiWw5KvETpaJbxpgpNoJGoYUu/K48S4uRor+LPONL1oNPgjeCLS/qGUcdUWXn+qNpR67BXy0/1wZTj6c40tUhHEnAiCzRD/356vSgay0HNttIo/37ctZSw5NwhWWfYr+cHClFuj0NL0APBcoToK1mDqsxF0QmPkXsKAJLf76UQsXiH+668dxu962f9X6/Pez8q5r39/o9RYS1wF9U0g/2Nmlfxkc9jrMsARhNkrVFcGsbUz3ewL4bHvPqi6sinyC7v4JL+rKdtnzFeOcW/SfZd5q1E2LI8r1hJBw7qKBNAophcXRuDdgDNGdT2ukFMx2urhgaBc485cDmmmjET88v4fKZfwZitUTK5ckPmPU7bFJpuyLh9BbtBBl4w1OvZwTTgy+VhXZ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2026 08:16:46.1326 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 67cd8dbf-647b-48f6-13cd-08deaa7ea615
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD0.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB9699
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

A callback function is added to setup doorbell range during vpe hw
queue initialization on nbio 7.11.4.

Signed-off-by: Caden Chien <chih-wei.chien@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/nbif_v6_3_1.c | 46 ++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/nbif_v6_3_1.c b/drivers/gpu/drm/amd/amdgpu/nbif_v6_3_1.c
index 375d5ff42a63..28a99b52f59f 100644
--- a/drivers/gpu/drm/amd/amdgpu/nbif_v6_3_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/nbif_v6_3_1.c
@@ -189,6 +189,51 @@ static void nbif_v6_3_1_vcn_doorbell_range(struct amdgpu_device *adev,
 	}
 }
 
+static void nbif_v6_3_1_vpe_doorbell_range(struct amdgpu_device *adev,
+							int instance, bool use_doorbell,
+							int doorbell_index,
+							int doorbell_size)
+{
+	if (instance)
+		return;
+
+	u32 doorbell_range = RREG32_SOC15(NBIO, 0, regGDC_S2A0_S2A_DOORBELL_ENTRY_5_CTRL);
+
+	if (use_doorbell) {
+		doorbell_range = REG_SET_FIELD(doorbell_range,
+					       GDC_S2A0_S2A_DOORBELL_ENTRY_5_CTRL,
+					       S2A_DOORBELL_PORT5_ENABLE,
+					       0x1);
+		doorbell_range = REG_SET_FIELD(doorbell_range,
+					       GDC_S2A0_S2A_DOORBELL_ENTRY_5_CTRL,
+					       S2A_DOORBELL_PORT5_AWID,
+					       0xf);
+		doorbell_range = REG_SET_FIELD(doorbell_range,
+					       GDC_S2A0_S2A_DOORBELL_ENTRY_5_CTRL,
+					       S2A_DOORBELL_PORT5_RANGE_OFFSET,
+					       doorbell_index);
+		doorbell_range = REG_SET_FIELD(doorbell_range,
+					       GDC_S2A0_S2A_DOORBELL_ENTRY_5_CTRL,
+					       S2A_DOORBELL_PORT5_RANGE_SIZE,
+					       doorbell_size);
+		doorbell_range = REG_SET_FIELD(doorbell_range,
+					       GDC_S2A0_S2A_DOORBELL_ENTRY_5_CTRL,
+					       S2A_DOORBELL_PORT5_AWADDR_31_28_VALUE,
+					       0xf);
+	} else {
+		doorbell_range = REG_SET_FIELD(doorbell_range,
+					       GDC_S2A0_S2A_DOORBELL_ENTRY_5_CTRL,
+					       S2A_DOORBELL_PORT5_RANGE_SIZE,
+					       0);
+	}
+
+	if (amdgpu_ip_version(adev, NBIO_HWIP, 0) == IP_VERSION(7, 11, 4))
+		WREG32_SOC15(NBIO, 0, regGDC_S2A0_S2A_DOORBELL_ENTRY_5_CTRL_nbif_4_10, doorbell_range);
+	else
+		WREG32_SOC15(NBIO, 0, regGDC_S2A0_S2A_DOORBELL_ENTRY_5_CTRL, doorbell_range);
+
+}
+
 static void nbif_v6_3_1_gc_doorbell_init(struct amdgpu_device *adev)
 {
 	if (amdgpu_ip_version(adev, NBIO_HWIP, 0) == IP_VERSION(7, 11, 4)) {
@@ -517,6 +562,7 @@ const struct amdgpu_nbio_funcs nbif_v6_3_1_funcs = {
 	.get_memsize = nbif_v6_3_1_get_memsize,
 	.sdma_doorbell_range = nbif_v6_3_1_sdma_doorbell_range,
 	.vcn_doorbell_range = nbif_v6_3_1_vcn_doorbell_range,
+	.vpe_doorbell_range = nbif_v6_3_1_vpe_doorbell_range,
 	.gc_doorbell_init = nbif_v6_3_1_gc_doorbell_init,
 	.enable_doorbell_aperture = nbif_v6_3_1_enable_doorbell_aperture,
 	.enable_doorbell_selfring_aperture = nbif_v6_3_1_enable_doorbell_selfring_aperture,
-- 
2.53.0

