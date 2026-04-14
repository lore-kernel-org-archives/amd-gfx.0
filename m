Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2508AED7B8D
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Apr 2026 09:00:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B705F10E5B6;
	Tue, 14 Apr 2026 09:00:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Rca6WR3z";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012054.outbound.protection.outlook.com [52.101.48.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6BD5E10E5B6
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Apr 2026 09:00:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tn4+a3WqHMZCYPlwC0pByPtMtfAGLO1O3RK8ZcIwLXPFxT78fEyxoUFB4wb/gbGyux/MkBPN+kOckSOt4NYzNF0WGnakV5sNLuBwH32nw8OiNCwHc6RjpwftYo+wzpjlOwyrlA5fmD0y4PSV8/0M7hX9+xdvQq60jyhJbaZBXpD5Nmrp195GyPEq4RFMnbR1rNrL4zToAKIgwwqwXZrl1dPrfs4iBi0rayjOclUn6AvsGognuXjJIjCOMoyKNMzZt7dLiWWlhi6wHjslPXFokY9acVq6DpNjYrc1We8ZqfzbaBIwtZhB7E2mgo3NC87AmisKb2az1UIzYuTVZjWwJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xKrhO6Ez3nX13Zc+ApF10Zd5LtyDdQD608Z8/RlRCMw=;
 b=NyfGzmlTlk0X0aAEseFQpnHlA5fAG1qxuXqIda7cLbOTEWAnqGuNEnAoRmL+2IsPUkfXYUPpoiYEhHYLNwBpf3vBZXxB+gh4ioIRjNNjfaojGg5mxXiBfGKaC9/ttf6SUEwynuCtdsWhuK+zqiI0aznVRchUZGMrgqq1Ra8yQ3v+Ivnq7jiUaI9MbV70jrRAmb81mZm6VofY/DWPqQuhWv2KRW7xouwh6DyfXAkQy1Gf8JpYvbV/85/ZYM/Bo2oKcYuZRQO3CJPh+Zyf/ey61sTU7yfS5mSwM1rx/uTxgD70hjIrdTwhDMr207GM/o8yh9EeCSO3f0/GZFqvO/HHNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xKrhO6Ez3nX13Zc+ApF10Zd5LtyDdQD608Z8/RlRCMw=;
 b=Rca6WR3zWWFyfmpafjxCOjAvk0KBg4HAwuYekv2REfRyhSN4CNJq4sITNHYE0GNDJ/HGW3Jvephfj0GGwPM8UwzbxRycTgORRZ5x4P/sJQhKIwGjPP1NrEpEga0ADKlxiPZNA6R7hrFFpvCnCKOZaneEfG1sOl1LA2gA/LND11k=
Received: from YT4P288CA0062.CANP288.PROD.OUTLOOK.COM (2603:10b6:b01:d2::17)
 by MW6PR12MB8899.namprd12.prod.outlook.com (2603:10b6:303:248::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Tue, 14 Apr
 2026 09:00:00 +0000
Received: from SJ1PEPF00002318.namprd03.prod.outlook.com
 (2603:10b6:b01:d2:cafe::fd) by YT4P288CA0062.outlook.office365.com
 (2603:10b6:b01:d2::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.49 via Frontend Transport; Tue,
 14 Apr 2026 08:59:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ1PEPF00002318.mail.protection.outlook.com (10.167.242.228) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Tue, 14 Apr 2026 08:59:58 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 14 Apr
 2026 03:59:57 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 14 Apr 2026 03:59:51 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Jesse Zhang <Jesse.Zhang@amd.com>, Jesse Zhang <jesse.zhang@amd.com>
Subject: [PATCH v3 3/8] drm/amdgpu/gfx11: Fall back to pipe reset if per-queue
 reset ring test fails
Date: Tue, 14 Apr 2026 16:58:50 +0800
Message-ID: <20260414085926.3171086-3-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260414085926.3171086-1-Jesse.Zhang@amd.com>
References: <20260414085926.3171086-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002318:EE_|MW6PR12MB8899:EE_
X-MS-Office365-Filtering-Correlation-Id: 89dc6ca7-89f2-4e07-3f78-08de9a0434b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700016|1800799024|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: vlYrcllrIkN9eIBvgbd8gyMb9HwRTga5AHyiEwmPg/iupRXdyZQtL3O6B6CgJI/1K5ZkcO1+AEiJzHlNowJhbycF/6V7DYsmJMGhZe7BpThpZTgvcgIrYjh5EJP/Trni+jq7dvpMzjAU0kg6jlsxtz956Trxxh6W20G7AFOP5AFbGrytHBFnR5JseZ6k80IszcglKZw1M9J7su1cO0z5e1hco0tzy7f4xappf+6P50tZm8TPOHbYdrZx7TuX05nqvwxZkb8R8l7Z/m6vH7o6NO3jMViGBZDHnWEyM7N2U5IXoEbw8HlMEtc9L0AvBmdwRSoy+BzrG6GPwPg5ZQlOC56wzaCq9jmMTEaZyxEx0IbX92BngGtafMkm2kClkn/bU6+GwSdAeFEcpemMA+7dgm3lXSnrHySPnpxHaqDY8rKfQSj6zOyXkXpsx4ZaFMmQt+RCNODl310sQubXSgrOzJTnMeL+FSJSGGRk2AetkSMxK6qAiHtAWipo9TAG7lPJB3VW2K7JbsekMxNlFAwj5PWlNKFqvj+t8e6SLmdBGR0UqLHvQxq/qtEa6He6dOnRCrBS9GPzZ/qELGWyg7mLzbNgoAHfYb0EYFjycgHg4HJLGFcikTFxZS41NH5folEOv01SG48eC00U7tFi1zX6Vod7BDVSCzF8qFuXaPTDfSfTqK21MooQCb56z+GJXctAaGYa768EXA1WNmz1eZX8L6jsdyDlWx5YYiM6J68zvCbeX39PMdgHHsm5aVCl+Qb0LUU0vQ30Ek7N46/b0zA80g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700016)(1800799024)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: /NoJ8E/GM8cUTN+pn5H9r2lDBrRTwb/SK1x73rvDtgL2uYGaPtxd+X1FizaNy1NW5UTQ61TIzrM+YZENqk+bJ4A5Te9uyEOZyi2CrsJ7hLJ6hXzEdZMt0t+Elq0AoxLyP89MqjV83snCHwJkIyUfob6GLu5VIsr+oE9FempYvhWc8w0XMYycCcLHCJOL/ESPc6rFEhk0IIQorazznrSr3f1G06zESdWnzrP3t8LGtpZDTcibyQwxuAAbId8t7rCGXFLHJWbMfgQk6skl730Ovpa6e+kiLpt5Nqkfx27Lax5Z+DxZnx2sAkLxgXTLYHlsXUB+5tGBqqQ8horwYEuv2H+yTlnTSPQ9fXHaI7Aajdw0KdMNOPDeQQVHUJGjAABrIz1MNacphWqUThrUBPiCPM4dfVIdiec6fivYfWtaevs/1ao9o29U3SXABbaFhGv8
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2026 08:59:58.7272 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 89dc6ca7-89f2-4e07-3f78-08de9a0434b6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002318.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8899
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

After a per-queue reset via MES, verify that the queue is functional by
performing a ring test. If the test fails, fall back to a full pipe reset
to ensure proper recovery.

This adds a fallback path similar to the one already present when the
initial per-queue reset attempt fails, improving the robustness of KCQ
reset handling on GFX11 hardware.

Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index e29e8e620699..fbef19ed46f9 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -7075,14 +7075,18 @@ static int gfx_v11_0_reset_kcq(struct amdgpu_ring *ring,
 			       struct amdgpu_fence *timedout_fence)
 {
 	struct amdgpu_device *adev = ring->adev;
+	int reset_mode = AMDGPU_RESET_TYPE_PER_QUEUE;
 	int r = 0;
 
 	amdgpu_ring_reset_helper_begin(ring, timedout_fence);
 
 	r = amdgpu_mes_reset_legacy_queue(ring->adev, ring, vmid, true, 0);
+
+pipe_reset:
 	if (r) {
 		dev_warn(adev->dev, "fail(%d) to reset kcq and try pipe reset\n", r);
 
+		reset_mode = AMDGPU_RESET_TYPE_PER_PIPE;
 		amdgpu_amdkfd_suspend(adev, true);
 		r = amdgpu_gfx_mec_pipe_reset_run(adev,
 						     ring->xcc_id, ring->me, ring->pipe,
@@ -7105,6 +7109,13 @@ static int gfx_v11_0_reset_kcq(struct amdgpu_ring *ring,
 		return r;
 	}
 
+	if (reset_mode == AMDGPU_RESET_TYPE_PER_QUEUE) {
+		if (amdgpu_ring_reset_helper_end(ring, timedout_fence))
+			goto pipe_reset;
+		else
+			return 0;
+	}
+
 	return amdgpu_ring_reset_helper_end(ring, timedout_fence);
 }
 
-- 
2.49.0

