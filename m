Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E407AC83F1A
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Jul 2025 09:39:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8033210E9F0;
	Fri, 11 Jul 2025 09:39:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="pTqzB5r+";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2074.outbound.protection.outlook.com [40.107.101.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D514210E9F0
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Jul 2025 09:39:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aPDGna5luzh739wJCRRkHHyvVtybJPyT9AYgCzAykjUPPU9IkU3bBVkWoLDwAMAlplC/+udMHgO2fzL+EMeQGNM+nn+jE2tywbcExsnLLOw2Ue9545UkYljG83AqnyvPa37vvPmY1RXO3i780D2iNu7wAJw1EUznVXEuLyNpKhVD/k0xkPk9fkTZ8vgkUJ+Hz6CzHMaPJ1paUEDd3q9AQSUykf2lXFfuTzKI43RlxJoiORVsrxc2FJi90S22HXcPWKc1fEMfx5PtonTK0hLkf64lQDSEzDI/ToxIZYC0vbv6FZLGLtWzU/PAc1beGbPiaa+EAcmOsYSiLAEfykyWEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fUCt7QcBjmT/N11DAOFwq1SDv9FAC2MCJSw5ZGhxDcw=;
 b=EFPQdkX87VDxxRXmDx5hzPLBCzeU6CbgWAoiRz+PGCm4NlFqYc+evRSm1HTZ44tbF/e2eUzUPEkeg6ANEUlrpOLqrLXcnIWYjaSgrAJ3e9rsPkmWhoZblgaWjPxmXSZXUyAFkILbADFtZttYjpzqTgiTMvUPKHzewZc0l16Q2fexGbLHYPkg444Vsh8zZrynj6Z0dQvhcBJSsDF9Vg7pxnJsptOdO3bz7OuzXm9ngg8THjpq2xF3IP+vEOz9E2BZbOI8rWGA+rkEXDMicgmwCBDseV6wnXJiX/2E49Ua3igPRONAXA9UNqM24cH3DHeeLOMTBSzIh/9jvKtYjHS94w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fUCt7QcBjmT/N11DAOFwq1SDv9FAC2MCJSw5ZGhxDcw=;
 b=pTqzB5r+Jh/HsX4OXSEjmuWOj/Un+kWoqinqEYJL9xLCLfvTm9GAmWEW/jI9FQRgjvguQVNX/OMnIRV2re4GEAec2puPbaWqQ06zhUJjO5CNqp3D5CBXPJJmEzxa73LB/ID+NKJBY7yE/dDfKoNtPwAY6iozvSAmQ6zLntiR4YY=
Received: from SJ0PR05CA0114.namprd05.prod.outlook.com (2603:10b6:a03:334::29)
 by BN7PPFED9549B84.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::6e7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.33; Fri, 11 Jul
 2025 09:39:44 +0000
Received: from SJ1PEPF00002310.namprd03.prod.outlook.com
 (2603:10b6:a03:334:cafe::4) by SJ0PR05CA0114.outlook.office365.com
 (2603:10b6:a03:334::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.7 via Frontend Transport; Fri,
 11 Jul 2025 09:39:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00002310.mail.protection.outlook.com (10.167.242.164) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8922.22 via Frontend Transport; Fri, 11 Jul 2025 09:39:43 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 11 Jul
 2025 04:39:41 -0500
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>, Prike Liang
 <Prike.Liang@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH v6 02/11] drm/amdgpu: validate userq hw unmap status for
 destroying userq
Date: Fri, 11 Jul 2025 17:39:21 +0800
Message-ID: <20250711093930.1411470-2-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250711093930.1411470-1-Prike.Liang@amd.com>
References: <20250711093930.1411470-1-Prike.Liang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002310:EE_|BN7PPFED9549B84:EE_
X-MS-Office365-Filtering-Correlation-Id: 16542c7a-2e67-4f81-addb-08ddc05eddda
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?3jxE9DDV4N8if/O8aFzGfJOWejl/BMeW8ldkgkJXvQsAiLZ+OfuTMlKzdpUV?=
 =?us-ascii?Q?P7oe9654Ac/uak8YM4fTDg++h2aVOZAQfKrmNpjBNanRAOeRQ9eDnXPVDQAi?=
 =?us-ascii?Q?D/v1KY8+ZEeO8pt7C1zhi5FVeqmpRt/KodBZApAaiI12K52Rc5KP8rQdKi3d?=
 =?us-ascii?Q?dM/Ly9UXPjT/8zZshKbr3yw6aFF3CppYeJgRaTs5tLMQQ0sjnaxJqArKRBcm?=
 =?us-ascii?Q?YP5l4X+sU5x5quqeIo63p+ntzGEwWMjBF59YuEgCB3EZ4OWb6ITf/BZ2TH2S?=
 =?us-ascii?Q?xfKDJe3dXf1kPqPYZq553Y79zZH8EUiSf+WNpLAB34VA9+LS6f4kdG3tZSqU?=
 =?us-ascii?Q?/vdf+8CkV6j94CULqesA99i8CIvyvUOIWOXU5enljsbqCnd85nD27bb4yOy/?=
 =?us-ascii?Q?Q6qkjCzxxmh89Q7CGY9Nr60ObnVA7sDjobqNPJ9WqjqxvsQtpB0n0ggMpIWL?=
 =?us-ascii?Q?UbJjqJLmhRbrlrvitpdcabx3h6e/X59Y+yT9VwE7jhQh9ZKoDhIKZeLQaZuP?=
 =?us-ascii?Q?9Cn8zOa9V05Qp4i2/oLyjVhiOZyrzopjzsW9gxIwhnvNBAHczRg4IrTZ4RMx?=
 =?us-ascii?Q?Bf80UZebiq8zCi9aaw6hthQAwJ2z9n5/Sit+O9jTD/MwTOqe/YDxEu5w4aVY?=
 =?us-ascii?Q?xHBcOVXorIMNRJ+w3LjgBqp7TMQdqXeb0XEut47rYZS9RaCBimji2KyIzRPr?=
 =?us-ascii?Q?8Fip/gQcib61h0lAEhylIx7BbCohY07rN7BS0gzh0OhH35Qonx9xElocdaPc?=
 =?us-ascii?Q?swNjx4vHBOZNgdHM1C7P/Wu1N9TtUddFOJO++yaYR4L2t1tQ3GTDpmdmII/R?=
 =?us-ascii?Q?2Bp3DU//8XMp8+DzcpR6WBli4HKlzirrSskA7Q72tPs7YszFkKm2VlxTLyq8?=
 =?us-ascii?Q?Ieds8JHgnyt2LV+ZQcaPpPMrOzbnhMJZQjJvCdEeyNTSyX0txo864tWc1R33?=
 =?us-ascii?Q?RTdS/2/dQaVc4Y4R+0EyKIYWXQFModoNloY75FVrCq8q0hve4kBAMAVTKHaz?=
 =?us-ascii?Q?HUaV9UwfkD9AvybkHIqqAkKrNc/4BnxzYjBUjimSXXJf5fYe3EhnKsb1zap2?=
 =?us-ascii?Q?Kd7gNaxoMXvRp9CL9OY6NlkCDXKAfg4W9C/ftuEagakC/sq74B++tTxJbO6J?=
 =?us-ascii?Q?Hmt68OYleDaqcTEPBSVCHPHh0W6FeJpnDz6mjE1GoCajRV6iMYAZ8+UX6XWF?=
 =?us-ascii?Q?qU535H4SmfcyOSfIZ4iwVZCGy9rLgsMRHKo0p3faS1Jr8lgNqQ3exT0r1+LF?=
 =?us-ascii?Q?WMHSsS92hLLcPbX7qYBmvoYZo564PAMieuMczxlbb2lUxdUp34fP77S976R+?=
 =?us-ascii?Q?rghvA6FYjc3vczlefAi0FSFih5/r/vOpgGrkR0uE7nztmgGMFjepciIiYI1Z?=
 =?us-ascii?Q?eHS2SJdRVMifcCPVHXciTBdwbaQtHPeJT71ULrCKu2Dv/kJ+dQZArVdVSOPK?=
 =?us-ascii?Q?E4DzG61qM3ZLDVO+rMJ1SRZjKkNSth1b6GAKL/vBpZwWPUCfQEvce4I+Agb2?=
 =?us-ascii?Q?+iTuAxBCqW3ocBqfz7F/Z33B4fhllFkB0GXF?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2025 09:39:43.6676 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 16542c7a-2e67-4f81-addb-08ddc05eddda
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002310.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPFED9549B84
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

Before destroying the userq buffer object, it requires validating
the userq HW unmap status and ensuring the userq is unmapped from
hardware. If the user HW unmap failed, then it needs to reset the
queue for reusing.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 7f9dfeae4322..3d2a7f8946cf 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -319,6 +319,11 @@ amdgpu_userq_destroy(struct drm_file *filp, int queue_id)
 	}
 	amdgpu_bo_unref(&queue->db_obj.obj);
 	r = amdgpu_userq_unmap_helper(uq_mgr, queue);
+	/*TODO: It requires a reset for userq hw unmap error*/
+	if (unlikely(r != AMDGPU_USERQ_STATE_UNMAPPED)) {
+		drm_warn(adev_to_drm(uq_mgr->adev), "trying to destroy a HW mapping userq\n");
+		r = -ETIMEDOUT;
+	}
 	amdgpu_userq_cleanup(uq_mgr, queue, queue_id);
 	mutex_unlock(&uq_mgr->userq_mutex);
 
-- 
2.34.1

