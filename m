Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DCE51061B1F
	for <amd-gfx@archiver.kernel.org>; Mon, 30 Mar 2026 19:58:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3B09D10E7A2;
	Mon, 30 Mar 2026 19:58:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ryuEJH2i";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012054.outbound.protection.outlook.com
 [40.107.200.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A483B10E7A2
 for <amd-gfx@lists.freedesktop.org>; Mon, 30 Mar 2026 19:58:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n+VhreVA73E3F5FepIK5MSe4LXH10sJmSaTUuyptL4Dk3pu6p0IIiLJZqR7kPuRcaOMGbg5HLqJF/p6chaLA1b2d1eRmMmkMMvavIVSaqwCNcQsNkBmRSvq6ypDqJjG8Kf5d1CZB+Y0QR36vldT2M7wlARi0KWo+nwMHiJkga09jlVW6dKo91RVl9Dk2ZIs6WeQBih7mNFT7mrtWKvPcdCyRDZ6u9yFVUbXHWXJ1JGtMck3+3T60koqDVzuMzT1rd6L9pD3rsCEa0KdFTZcFrwLZS9kSxN+CO70CuG9T4I7T5Sd3KxyqzN0sm1b4BvnZInD2qEEGeZ0IiUB1iUN1yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R/crxbmq72q5tcaQ6WP9ExD0+q5hLkwiIeq6xWIrgn4=;
 b=v0VxorjpcaWhVJJCcKyY8C6LC8OwqO5sJ7H5NDMSr3Ygs6gw3KZLXY1k3Wr/i2mpA4CuzxWB8/yDw+UaSQ7bINpRUDppi0Ol8fOmb7fp5LDJwV/3IR6ihsbL8wbdy+S1zBIjk4D3YQUBYydmB9fBEtnGpM8eHMva7mmbwC6YqrWa6c9geDqwLtnx3laNyQrqCgUQmAxJU+E/PdWFUafCyxtgOUR6Tje3QjFasgC9qnd6EKbmmyJnVuLHpYmSrrlGgBW8iEQUtl/9d6RjPqZibtjaIP7wODt0Pzs/2VPpF53kfSFiPpofKyytLtkjijewpjT/KJA4B2WDwqxlJhfR2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R/crxbmq72q5tcaQ6WP9ExD0+q5hLkwiIeq6xWIrgn4=;
 b=ryuEJH2irwAHR6jnZfG8CX4yFWdOjSyk1kPAm6fc7895GpVuq2bGSHEkAwY9N8vK07qhuYdLR3CSB+xHvZizEsXs5IyeaxQfLJj3btkJq2uM0k5rkZudpMSZ2uYyoAH1/q6gs/lXd9cxwmyCheMRD7whgRNpBLrgr4eCS6QSszo=
Received: from MN0PR03CA0028.namprd03.prod.outlook.com (2603:10b6:208:52f::16)
 by DM4PR12MB8473.namprd12.prod.outlook.com (2603:10b6:8:183::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Mon, 30 Mar
 2026 19:58:36 +0000
Received: from BL6PEPF0001AB75.namprd02.prod.outlook.com
 (2603:10b6:208:52f:cafe::5c) by MN0PR03CA0028.outlook.office365.com
 (2603:10b6:208:52f::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.28 via Frontend Transport; Mon,
 30 Mar 2026 19:58:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0001AB75.mail.protection.outlook.com (10.167.242.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Mon, 30 Mar 2026 19:58:36 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Mon, 30 Mar
 2026 14:58:35 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 30 Mar
 2026 14:58:35 -0500
Received: from bencheng-dev (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Mon, 30 Mar 2026 14:58:34 -0500
From: Benjamin Cheng <benjamin.cheng@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "David (Ming
 Qiang) Wu" <David.Wu3@amd.com>, <amd-gfx@lists.freedesktop.org>
CC: Leo Liu <leo.liu@amd.com>, Ruijing Dong <ruijing.dong@amd.com>, "Benjamin
 Cheng" <benjamin.cheng@amd.com>
Subject: [PATCH v4 2/5] drm/amdgpu/vce: Prevent partial address patches
Date: Mon, 30 Mar 2026 15:57:54 -0400
Message-ID: <20260330195757.901509-2-benjamin.cheng@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260330195757.901509-1-benjamin.cheng@amd.com>
References: <20260330195757.901509-1-benjamin.cheng@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: benjamin.cheng@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB75:EE_|DM4PR12MB8473:EE_
X-MS-Office365-Filtering-Correlation-Id: fa9981bc-8d65-4b9e-dfae-08de8e96baaa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700016|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: zTsIdvva4B41Ts8B+dcmP8wIUjhMBfByPp3wIF/S1+aiNF3gafYatgyj1Jz+gyAAiKBaFQC7d3psWpB9Y6VlPthwWnqX7wLQ/H6HooOHAYzcjKcODQj7Myjh8HNctYbxrTBypvMz6K6rCLRSxKRY1TsNuhFwTof9DN1UFDZOzCIfcwm593m6/ALsapnSZ6Dq5C0XVcwL7qXJbKT8Jh7jBp8IiVXEkfAsfEpy8foNg8Jy1BT0u7CslC0wsbDFZ8B66QIgpMVmbX5FkqxrF7b4vw/gKRUFq9SFy0/V9sxOw3Syxzu8ddPWMB4N9qBMl9Zs0JFQtfbNNNm0yLitIcRCWZ4Vf9MjNPFlOxtV8eZ4vSVQnO1YxOq+bT2fFJLEfUn/91PFhBRpstE2ndV+ilI47rzGGq1dPdqfeVKgPK3Os23nOxmgFOIrqIEZEjkSGW8iN8WffVdOxgkSiYDUdzNUi3NikDEYL1e2VfEPThCzJItsHc6eyAO4qsbki7irPAOm88wNq0T7ouGdiz+LV33kLD3soFgNWStDEPrlAMxcIb/mFvA5nIMP2RTcp5fjmHFJiS1y0q0ph8LTR2MVaEQh5IXnlilqXSvv1B48gV4dbtNVqUhTztIPw7z6BDp/8STX7WySUCe43mqQKEQ9PTxqtK0wSeLMpLlu0XBz6AR+9HnJd/lVoclaSJo9uVprP13F9oduAK3aESHMSWHNRb3ellcUHSgojXztrj/FzIMGXs1S1e9yQEPU2XP3xchSfzIXKy7lKABz/bei1aRFWt/KdQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700016)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: CIEkLqBxDeZdk9tHUdI6KGLRzqMO3mCHV0tvqPME6cSoVnFDs74VCHzexhxk7gffBYpvQkikli1so6DSc/eabYrVlFSlZJ1gMKfItjDG/tRw4fZdfj5bXeSs1wMnDQzy91mieRbicuTVau6XWKOKjU1KvljI5cWHQVOxQzSO/IFC9jZIT2FpPwiRU6UDd+vorgTUju5ww1PlR0N6AjY2tXfq9KzqDvNgqFGCHfh15LIB9mFkcuMu5inVF4SS5nP0/+3UOJopeGBM0sixnyyLWgRX7IBRZQCbj1iJQtpwd/iX6JiNR34hNn0BH6t3OPAqxmWzAoBEy+Nvkbu3N7jk/KemJegPThKlleDqrfGlGYicRXOhaWOaS7Tg/0hwkCpUdsN4DGSSb/OMyU/6nveRfarWv5qEfiueB1M3C7kn/dHKhozIVqtInRinye/RyKOh
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2026 19:58:36.0748 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fa9981bc-8d65-4b9e-dfae-08de8e96baaa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB75.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8473
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

In the case that only one of lo/hi is valid, the patching could result
in a bad address written to in FW.
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
index eb4a15db2ef2..efdebd9c0a1f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
@@ -680,6 +680,9 @@ static int amdgpu_vce_cs_reloc(struct amdgpu_cs_parser *p, struct amdgpu_ib *ib,
 	uint64_t addr;
 	int r;
 
+	if (lo >= ib->length_dw || hi >= ib->length_dw)
+		return -EINVAL;
+
 	if (index == 0xffffffff)
 		index = 0;
 
-- 
2.53.0

