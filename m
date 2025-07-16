Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F409C83F27
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Jul 2025 11:00:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9F14110E6DB;
	Wed, 16 Jul 2025 11:00:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vN9dqxxg";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2077.outbound.protection.outlook.com [40.107.237.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EBD6910E79F
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Jul 2025 11:00:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Wld+oBDYYbG+WKl5Cd5TI3zLUodrROqXyPJb9RywxH97O0HXCzA0ULDT0k2o7iOsgdU2vQJDfoUPuBvsw6OsQpGFBRrG5UzMAq/gUgvqt+kMiSkpDj3iR2WhSPuAzzbJqMxny5bSqzxHBh1RlIGeZjUBuvcjuexbYkVlp6vcLn/zowz5huuv/FgMpAyJwEDoIYwv0jDWYQCsBiUKltFWxFOaNxlakh+m9v/D0gnhBmwLArZc2uTpByvGfzUIwpj2zlDEGAsYes18CYsBHYZK/NKZpbvEnXmv54SoiLYeHDit7Q6/cZ756/D3d912axmGMaQbgUD9pSJx/3uJvimHDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TubKTntlYBch/sbrTXZVf0yoPnuda9PAd+BNP35NTR8=;
 b=h70nGP5QgUTnqXw9qRaj8cwQR/yBYJ79x2NCTT2uVaMlIXT1QPmkQNdMNenUrIE5pETjMfmyjKicrO5LtbEI5pQnf3v+mZRdH2wIwyiWCsfpGEH1NOghtdNHuLbBhpTKsam32Kx49SSrxLn+hcKwuq2X7GAoonTzQu8uSXjY6anWzuF+KS2dgqncGaM41n9vUBdnpCuMbwwfn8hVzvL12FywQ7OB1ez9K7/fTg2Zm8FuJWZGasqGSVmv+AlksaWb80E4KgPTzxAGIctlS3GO3BoV9rgFtuOlbIA8Q/936RAIjba1O03g26i85R2u0EUIhaCB81Bx9uZ7a7/VEj/1nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TubKTntlYBch/sbrTXZVf0yoPnuda9PAd+BNP35NTR8=;
 b=vN9dqxxgleEqhvVt0xaF5umwA4QyUAgsqwGwvUgA6+dnw6GMGQkdOUKj/IkXGhW8CqYvxesuCh7hKJttA8DoPPgzzGm1XU65iCEiZCoWb28c5jfp+yceZ3Ld8hFe/l0Dn1T7EhcwtpbXqtVx23ziHYIVzpazRq3Uou8XbeTN19o=
Received: from BY5PR17CA0027.namprd17.prod.outlook.com (2603:10b6:a03:1b8::40)
 by SA3PR12MB8761.namprd12.prod.outlook.com (2603:10b6:806:312::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.32; Wed, 16 Jul
 2025 11:00:28 +0000
Received: from SN1PEPF00036F43.namprd05.prod.outlook.com
 (2603:10b6:a03:1b8:cafe::e8) by BY5PR17CA0027.outlook.office365.com
 (2603:10b6:a03:1b8::40) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.17 via Frontend Transport; Wed,
 16 Jul 2025 11:00:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SN1PEPF00036F43.mail.protection.outlook.com (10.167.248.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8922.22 via Frontend Transport; Wed, 16 Jul 2025 11:00:27 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 16 Jul
 2025 06:00:27 -0500
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Wed, 16 Jul 2025 06:00:25 -0500
From: Jesse.Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Jesse.Zhang <Jesse.Zhang@amd.com>,
 Chau Kyle-haiChau <Kyle-hai.Chau@amd.com>
Subject: [v4 06/11] drm/amd/amdgpu: Set is_kfd_process flag for MES user queues
Date: Wed, 16 Jul 2025 18:59:26 +0800
Message-ID: <20250716110011.1670654-6-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250716110011.1670654-1-Jesse.Zhang@amd.com>
References: <20250716110011.1670654-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: Jesse.Zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F43:EE_|SA3PR12MB8761:EE_
X-MS-Office365-Filtering-Correlation-Id: b67ce003-0cc6-47da-0b4c-08ddc457f935
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?t1604aBrdfHkDYG7+uWwIKQRVKetde4enbQIfw3wDQn8Yowt/nwVZQfcOnl6?=
 =?us-ascii?Q?pVLagzwupDBQkf0enEH0wAfEItLXoigSuWXHvYE61cenQw5U1cckmiL9W3Md?=
 =?us-ascii?Q?ObzmLJG1fZDM8dYCeKp7njMPJT45I02EwtYQDl8pvZIQ6Vr0xKEvALvchyOz?=
 =?us-ascii?Q?Qdo1eX4t9v5ASHrNkCqslLtM4d9cESHqHD9MuTemmf30nrIEUsNG9fA5nvQM?=
 =?us-ascii?Q?rGYZkIGGltH94qmIClvPBfNi+bV2PcVzl+G/3CzIM8V4vvyiuoQFMM31k5UX?=
 =?us-ascii?Q?klxCbu5BmJJX77llOaND8QGlVfF4NtWP/KGaCiqYpjQxt8MsT+EuQfz5zabr?=
 =?us-ascii?Q?idDF79Qo+aVnb6VfnSYxt9ZT1uCu4XEKwhql3g4DAskX8twgA1hdJGbQ8e7E?=
 =?us-ascii?Q?IRH9XjsAB/mD2XZddfEY/cTfxubv4iZpdDl9pv3FtZnu3v5bBXfZtcC6qBcZ?=
 =?us-ascii?Q?L6zIHfONcC6NCCOX7r6hHno/xhkcLOivLuWrUVxwpe4qbryWbsyxWqZf06Af?=
 =?us-ascii?Q?zFg+VYPCWiYU3+bUuJYt1S/GxVhcdFLY+58YeDWpvp6VAM9gEaPI/ZYwVdxt?=
 =?us-ascii?Q?H+izbgmOzF0ZZYpbSkzCUwBaCsdM2+az7PJoex7J0m+s4WVIwxLAEodeJuhx?=
 =?us-ascii?Q?42TSHhjW72xH8UFVGgaWfAUlt7cZJBMgOKXLJxhf9z5Q+y2vz/rvsSmnxW3d?=
 =?us-ascii?Q?4VcFT9vdO5Nq+962uIkk83MiZGTiR7AtgkadbSAXHeXBAyCEBPjgM6NnXud/?=
 =?us-ascii?Q?2oHY4mDT6qy1+lgX6sivKBNAb5B6GMgf/ZwwUKg5hxEgXRn6C+iD7iQdDgGh?=
 =?us-ascii?Q?VQKiVApZhNNkGGWXckwHzMPgcJ0DUL/dGUpp4omcm1PnXwYNMnAyD8Q9Jfcp?=
 =?us-ascii?Q?MLaDQGaDUCrEfRGVq8jCNZeTF41ovNHrLyxPpiHAihMElfLfPnkVUypo6e45?=
 =?us-ascii?Q?SDbWK1604KEwGnaceLp4E7ugUt1SIwf7uH00g6qqq25C9xjBhJgwKDxNYDrU?=
 =?us-ascii?Q?u9KDXrTlr05WqzRa4U6FKmiHtzzbIVVbzEIqfnN55Oogf75+uA+XDyv6mkMY?=
 =?us-ascii?Q?APIIb7nHuMWV63jdiVw0TsMEqvBYPK9jLbGSWO+7djPWhxPadOBdzLtLVZ/r?=
 =?us-ascii?Q?2Pe2dzAJ73P1GvdmG2qP8Q5WAhft7cxpL7bYrQaE85cwq8h5XSIi6Ax8UJCN?=
 =?us-ascii?Q?WDELnu3KZJIU6djLu+A/GmtLQ5/4L2BsAeFS27LWUrPxMOtRElng6EMI/j8L?=
 =?us-ascii?Q?jPKXMIAGc/ronh6J+5SZfxqsVbPH7SAK6b8ZcQlgLbBcgMEhAB3avCYFUKAP?=
 =?us-ascii?Q?EJAGIYxRHtABysLt/Mi6On2pzrvRJJDc7oEvgsCA0ihCNGbUqohMxk6rJPDq?=
 =?us-ascii?Q?svMVb7LtIePiSVUDN14tehf9CPzMYAakkiWeHWTXjsXTbCpEKei+ZuZRbeiY?=
 =?us-ascii?Q?q8nKdusuSujJg6PDd+p4ndHY4yDDx7bYiuNOrGc9sPAE6usnc3HItVnpKXEi?=
 =?us-ascii?Q?DhL3w9mo4RdteHNBujrfyWss1/iDJgyRQrY3?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2025 11:00:27.8022 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b67ce003-0cc6-47da-0b4c-08ddc457f935
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00036F43.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8761
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

The MES has special handling to track unmap
failures for KFD processes when they occur during
queue removal. This is because the driver is expected to call remove_queue
again after a reset.

Normally, unmap failures aren't remembered during queue removal as cleanup
is performed. However, for KFD processes we need to maintain this state.

This change sets the is_kfd_process flag to 1 when creating user queues
to ensure proper handling of unmap failures during queue removal scenarios.

Suggested-by: Chau Kyle-haiChau <Kyle-hai.Chau@amd.com>
Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_userqueue.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
index d6f50b13e2ba..64aa749c58c5 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
@@ -143,7 +143,7 @@ static int mes_userq_map(struct amdgpu_userq_mgr *uq_mgr,
 	queue_input.doorbell_offset = userq_props->doorbell_index;
 	queue_input.page_table_base_addr = amdgpu_gmc_pd_addr(queue->vm->root.bo);
 	queue_input.wptr_mc_addr = queue->wptr_obj.gpu_addr;
-
+	queue_input.is_kfd_process = 1;
 	amdgpu_mes_lock(&adev->mes);
 	r = adev->mes.funcs->add_hw_queue(&adev->mes, &queue_input);
 	amdgpu_mes_unlock(&adev->mes);
-- 
2.49.0

