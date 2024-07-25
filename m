Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC907C3DA7E
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Jul 2024 15:01:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 045B010E866;
	Thu, 25 Jul 2024 15:01:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="v2QgthrS";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2057.outbound.protection.outlook.com [40.107.92.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4B5C610E84A
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Jul 2024 15:01:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iJ1it3AOL0Gsn+7S3KBNFW7zVufxs7L+J+SUCYwW6s7MwS2KDZU3IZz7prf7QG0lZ0274d4ekTYldjSzTaTtCKXM1w42Yqd+33N9rZLJYAVlfTpw0WmJ0mAbl41nfhHXl7rGO/Fq8ObW8RuezqvA1KtuA8d3SXSy0k0ZCUVDJ307maafIf4GH1RUyUu1gIIxjwSu+hTSERBjL63o6/wXpkxrirc2lu7QA8oJndRG4RArLdUphwYnOlqUIucS8vBLdfWo73UqfL/w8rATcXn9nz028qS6GJD1Fg0E6cmRV4fZx9xoxK461iUttytp2I073Pz3jKz7cH3HWTmv7pXUYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sh2CO7AfRQbVEX/LUHEeaOaUQ4yX9DwFkVdp9r032Qw=;
 b=EzNe2dgHhUA73CZe/RGX5n03fsA9CepESAk1+QiVohUZbmT7IpdqHaRm5jk30GwwL3s+YkSPd0zI+UtXKOa5hC/b8R/okNwcxEDRrU42Os2MqN5Db3iXH5ryLokEbNJpDwHYsSUMiHtgr+qRA2XVaB6XheyeG6M1PSG5Fh2zAy1raylHz8iLh2oq89LOQPpksXzbPCYlC+090awMvYmvoUF8bTAgb8UGSi6DniNwqE79AQMpOWEVCSt+NnxNjzYs6RIY9sb6jcPEyM/LwvdbMwbjh8TrVk5JWMNWGwfBMeRPWbr/8xZg2JC2SI26tTJAvk/4ASiuWOTXX25eK8RfRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sh2CO7AfRQbVEX/LUHEeaOaUQ4yX9DwFkVdp9r032Qw=;
 b=v2QgthrSiOefDFlTUr3n4+fZ58aGlIqvNZBzopIlgHN2ycI7fVdBcaQc9D1KQZAO/bLahQvJ7omx8J2jbIHr74HZNQSTYhEspdKTEjjiRwqZXzcr7bsUbSWF/CkqIsmvyH3CDlo5JhVzkYCDKf5tMcKdBK/m4Zb0R4I7i0Xk3Ds=
Received: from PH7P220CA0039.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:32b::26)
 by DM6PR12MB4169.namprd12.prod.outlook.com (2603:10b6:5:215::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.28; Thu, 25 Jul
 2024 15:01:34 +0000
Received: from CY4PEPF0000E9CD.namprd03.prod.outlook.com
 (2603:10b6:510:32b:cafe::38) by PH7P220CA0039.outlook.office365.com
 (2603:10b6:510:32b::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.29 via Frontend
 Transport; Thu, 25 Jul 2024 15:01:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9CD.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.11 via Frontend Transport; Thu, 25 Jul 2024 15:01:33 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 25 Jul
 2024 10:01:30 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 41/53] drm/amdgpu/gfx9: add ring reset callback for gfx
Date: Thu, 25 Jul 2024 11:00:43 -0400
Message-ID: <20240725150055.1991893-42-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240725150055.1991893-1-alexander.deucher@amd.com>
References: <20240725150055.1991893-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9CD:EE_|DM6PR12MB4169:EE_
X-MS-Office365-Filtering-Correlation-Id: c391a3c0-cda3-4e58-1741-08dcacbaac72
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?F59/5czhpKyAnw7ILOt3q+pkGmoE6+K1AhrS/ty/7hnpztaegwT66zpH+z9S?=
 =?us-ascii?Q?kS2d0znVrugysb4/H+hpvgW/wXnaaIkh54/5xlPMVYJmSB6uvBqD++vo07z1?=
 =?us-ascii?Q?9e5kJ6lhaj+bqta6riFdZyMf2b+adbwJLoeM63ZmJ82LiZNOnpocQwA+FMVt?=
 =?us-ascii?Q?BCnvTW+TI3xRoSzaldNKNtP1utj2f1Y6VKUCVvVb2RxGx9RUaiH2pRD/NKHY?=
 =?us-ascii?Q?cvYSzy1JVvIJUOaHESqV0J4DX9Awkak8EdEldqiA/VrgsD8OwJqe7QNTzqtU?=
 =?us-ascii?Q?39YeMyaVlel8iqd5/HkB30KnV8a3KqB9jw/bgDUjNGi5jolsP51qbnyGH5r8?=
 =?us-ascii?Q?nV++y+SsyKhEO/+I1J7EfTKkqZ5XbkCy8Plg4PqgWPVb1D+5hvqKKb9E/9DK?=
 =?us-ascii?Q?+u5Dr7UmoFdxqPsnejUJ7LkdXu1tOxgCmCWB5l2zX+yvfevbTBONuyNXViMn?=
 =?us-ascii?Q?QiFSEmSS14TlWd7EWHpfcfH4S0Y4O3TF8SwMq7h2Z9VzLFZ+SxVitSScXwx6?=
 =?us-ascii?Q?SaC5fPz3rCa0iuo3OI8eUlF3kHoGkdawDGe52xQqxeHpmr3C7KQ7kPr7aGiz?=
 =?us-ascii?Q?rNgwMMw6wDs2NGtXqLVHL2/6AHF7NKjIi+etJeM4xhOTSyWtXYIMWCGOY+MH?=
 =?us-ascii?Q?crps4b5/28av4Jk6ilPoiX33Urmvq0Hy6i1I3HhB8PkzpF49jPEmFPocicRZ?=
 =?us-ascii?Q?NCobpvUez0QcsGROKEGfZU/FyefuMuJdsTamXGbtUzwbOezXmjuK9pQ59rX6?=
 =?us-ascii?Q?F5IdiusLkRzvBLHDSNDfbZ0BkqsVf+OdaQM0ouyBVzJ32KTQvXOkd8qwnoNz?=
 =?us-ascii?Q?jl5cPc8cmBaULLGehYITUHU+P2ZLhAAJI48/u77i2/Q5q5IvFefhURKS257w?=
 =?us-ascii?Q?oemQIrGZvnVCmVqveOmaBRyyL9Yyys/a9iqJdCD8lcJJxZS5HRssmH55+Se3?=
 =?us-ascii?Q?LvAE62cDcInEJcbTXW2nQJ6zBlR8wL5niNbrBpvhaZAPhkhMkvTlbQqDOkbg?=
 =?us-ascii?Q?WWqtrNO1oThcRnsne+v2umxJuJC7ATfHmWO0NXjNjYyNVy9gkfHOAcwC85CU?=
 =?us-ascii?Q?2E5OSewivTn4f+wX9f1WQ0s7VdbtiRddqq6bYKJaAkbPYnPGSR9qzZJanDD4?=
 =?us-ascii?Q?VoLRIjZpTIgS+lXEcTqaytV/JSnrJqfmtOpmJwJTAeOMaJB+9fUfFTteDJgd?=
 =?us-ascii?Q?OGp8VY+6Di/mHhYMbxq36e+FN/Xe6d9fy65fPnP1p2o5rP8SCm0rfyrirfH4?=
 =?us-ascii?Q?61c6+KzvSbb7Btn0ZNtYOIhj4XBajfMRuJnQywgRjYGCpLkRuO67nomlROco?=
 =?us-ascii?Q?g7707RTwAjnUJJbzm2EALqJ1i0WDIMiD1Fa8vDcNLf/1bodxem6AI9cllf0C?=
 =?us-ascii?Q?WvKsaYfzyNIuXRpmlhflbf7mNDwVQb53bZP2T/RgKJrVrVcSSL+nDrULzmFg?=
 =?us-ascii?Q?qANsq0sleYxnmms3UuiKBJkpFCMB/ebz?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2024 15:01:33.5570 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c391a3c0-cda3-4e58-1741-08dcacbaac72
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9CD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4169
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

Add ring reset callback for gfx.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 47 +++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index df5018b4e708..82b38432071e 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -7137,6 +7137,52 @@ static void gfx_v9_0_emit_wave_limit(struct amdgpu_ring *ring, bool enable)
 	}
 }
 
+
+static int gfx_v9_0_reset_kgq(struct amdgpu_ring *ring, unsigned int vmid)
+{
+	struct amdgpu_device *adev = ring->adev;
+	struct amdgpu_kiq *kiq = &adev->gfx.kiq[0];
+	struct amdgpu_ring *kiq_ring = &kiq->ring;
+	unsigned long flags;
+	u32 tmp;
+	int r;
+
+	if (amdgpu_sriov_vf(adev))
+		return -EINVAL;
+
+	if (!kiq->pmf || !kiq->pmf->kiq_unmap_queues)
+		return -EINVAL;
+
+	spin_lock_irqsave(&kiq->ring_lock, flags);
+
+	if (amdgpu_ring_alloc(kiq_ring, 5)) {
+		spin_unlock_irqrestore(&kiq->ring_lock, flags);
+		return -ENOMEM;
+	}
+
+	tmp = REG_SET_FIELD(0, CP_VMID_RESET, RESET_REQUEST, 1 << vmid);
+	gfx_v9_0_ring_emit_wreg(kiq_ring,
+				 SOC15_REG_OFFSET(GC, 0, mmCP_VMID_RESET), tmp);
+	amdgpu_ring_commit(kiq_ring);
+
+	spin_unlock_irqrestore(&kiq->ring_lock, flags);
+
+	r = amdgpu_ring_test_ring(kiq_ring);
+	if (r)
+		return r;
+
+	if (amdgpu_ring_alloc(ring, 7 + 7 + 5))
+		return -ENOMEM;
+	gfx_v9_0_ring_emit_fence(ring, ring->fence_drv.gpu_addr,
+				 ring->fence_drv.sync_seq, AMDGPU_FENCE_FLAG_EXEC);
+	gfx_v9_0_ring_emit_reg_wait(ring,
+				    SOC15_REG_OFFSET(GC, 0, mmCP_VMID_RESET), 0, 0xffff);
+	gfx_v9_0_ring_emit_wreg(ring,
+				SOC15_REG_OFFSET(GC, 0, mmCP_VMID_RESET), 0);
+
+	return amdgpu_ring_test_ring(ring);
+}
+
 static int gfx_v9_0_reset_kcq(struct amdgpu_ring *ring,
 			      unsigned int vmid)
 {
@@ -7373,6 +7419,7 @@ static const struct amdgpu_ring_funcs gfx_v9_0_ring_funcs_gfx = {
 	.emit_reg_write_reg_wait = gfx_v9_0_ring_emit_reg_write_reg_wait,
 	.soft_recovery = gfx_v9_0_ring_soft_recovery,
 	.emit_mem_sync = gfx_v9_0_emit_mem_sync,
+	.reset = gfx_v9_0_reset_kgq,
 };
 
 static const struct amdgpu_ring_funcs gfx_v9_0_sw_ring_funcs_gfx = {
-- 
2.45.2

