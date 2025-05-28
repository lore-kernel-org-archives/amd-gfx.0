Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C50BFC3ABB2
	for <amd-gfx@archiver.kernel.org>; Wed, 28 May 2025 04:20:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5E45D10E57F;
	Wed, 28 May 2025 04:20:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="bvyylQA0";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2055.outbound.protection.outlook.com [40.107.220.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 548F610E57C
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 May 2025 04:20:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S8yC9eYUah2H8DTJ/hBDebpevJ6K+iLoj4BBeiyCgN66ZAoKtdtYDDTJgAsWiFRAKMHf+PmKPSKwyivwTW8PBO1TNG9T5c4khPzMWJ9wbP2XUDOK4MdkaEE57phk/h3ddRdhU/TGjqy1QdhUKHf2pqUj2znwUSevYLRFWVRNtvpNxWw7SKFr6pE6mkFXWtIVPtW5sVa/av+oTUAv8hwDvci8pC0QRChWytkWrmj9Ob3dzPZMw10BlIy3qUx+Zk/oqnSmWIYCcmzHv3McUm0AeLk/9J9Baiv6wdB5drrEv9Heh1gngCAovinn7r1/35M6c+5+kwtmPsQ9Ke/wEWPbKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RjgSuhpwamaeEHEDGPNzstoDCtoCYO6Bf2EstwmgPgM=;
 b=tIehCcHSLtFraNxs8KIepn4q1mP+6voi4mT8Kwc8VmRoVtGWzcLnQc0AQacL5QADvLbi+Oqv3du5G1678jcd7kp2Y/WIAzPnS3733mbXhoW/8+dmo2IMWW75/Vz5K3TFXDRpDlyptZXywdNXjl8meTXabestHHxj+w9ajZqvSzJdlWIoNGoegPxH2hpQPBvR/la21Zj2kiU699fPqITDiCDs3uktgz9SxYX6qQ+h7IOAhvitV0nbefDkjnxKs+vmEAVZeFjrZx2C1TVR0zMgIkC8VjWxbrBl1vWqv30S+mugkCczf1Y6ggMamSkh7P+vzKfBi/RvXDxKIA+ok1Ec9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RjgSuhpwamaeEHEDGPNzstoDCtoCYO6Bf2EstwmgPgM=;
 b=bvyylQA0TaOXpfwT60hrgRdXkDXHBR0f2beJxk13l2GMU0fhEUhdxP7DR1ZPImeD2alwvwlyuTPODjgGjWqpgt7vYDN/AiyvQry5bp0Ep7/rxw09J5vmoKzsbpaErlwFqv6pngap/ZxjTTZ7El+Xf8g3gH3bxA5yvPvBDEcEPmc=
Received: from CH3P221CA0003.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:1e7::14)
 by SA5PPFAB8DFE4E8.namprd12.prod.outlook.com
 (2603:10b6:80f:fc04::8db) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.27; Wed, 28 May
 2025 04:20:10 +0000
Received: from DS3PEPF000099E1.namprd04.prod.outlook.com
 (2603:10b6:610:1e7:cafe::8d) by CH3P221CA0003.outlook.office365.com
 (2603:10b6:610:1e7::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.19 via Frontend Transport; Wed,
 28 May 2025 04:20:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099E1.mail.protection.outlook.com (10.167.17.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8769.18 via Frontend Transport; Wed, 28 May 2025 04:20:10 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 27 May
 2025 23:19:36 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 14/19] drm/amdgpu/gfx12: re-emit unprocessed state on kgq reset
Date: Wed, 28 May 2025 00:19:09 -0400
Message-ID: <20250528041914.5844-15-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250528041914.5844-1-alexander.deucher@amd.com>
References: <20250528041914.5844-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099E1:EE_|SA5PPFAB8DFE4E8:EE_
X-MS-Office365-Filtering-Correlation-Id: 4405e948-c52b-4f87-504c-08dd9d9eef64
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?AC9cfU5uhIVNeM1370lB8wLx/m2xIhB8fSxS8fHHVrvHur1/TgTlJgWDfgG3?=
 =?us-ascii?Q?Xc8+uFS7815WJmW3QIdjqLMZRbKCTKBwDvVOh8RZg5KMD2R8b3mdNyD2OoUn?=
 =?us-ascii?Q?zh7MXgfw5DG+5Pz0xrA3YdcSM8+RQqIN4JzrxbpJhRcRlB8xZrO8JCkEaLVC?=
 =?us-ascii?Q?+MOmR7mnNXi0oSCg596u2EurUGkT4viaTI/EekV2Re9c0Mn0J9p6T6HUy2jZ?=
 =?us-ascii?Q?7SRzYPkh/y13Fu6j5xMntTfy1snjdi6mD1AFnbLx0CV93roHk1fV/BjORiWj?=
 =?us-ascii?Q?Nyz0XZI/vUA6cQ0kUPW/qrKtlzN5vEa5Oe/EztonLaJ8thVRZvV9rme/XMjL?=
 =?us-ascii?Q?8f5QduAbR090xUkip/ST4aB3zmX6S1G29p9FZeOo0pbtstU921tNCjOvalfs?=
 =?us-ascii?Q?T7FQsza7//0NXhTIKGDI7rGZfucOSWvErf+N9lrtHf5YzdSlTOlUZNCzC7Dt?=
 =?us-ascii?Q?EaG7ag8uZIFmhTC50RUXMegVHfyQRwS3MkkVBJqZv0PWB528wRMz3JodqUdA?=
 =?us-ascii?Q?ywP8AnE6JC8uWO8AMwyHr+ks2BQSV4liIPCF+HrArWu/6UcmL+Ge8oWab6T/?=
 =?us-ascii?Q?IUN7cvVOVEzq6gCBU+jrYQ3PIQLcu48QFAf0261jo2HYXdUvXxTQ0jObz3bv?=
 =?us-ascii?Q?FdbgkthQwb5HbcXCiMWUa6z3N32Z1A8OBuvTj8zQWBAzj6NYi1Y2nZ2Ftt/7?=
 =?us-ascii?Q?IV6KuX4tLB+EEnRLzVgmlFwdUr1ACINZDtMsQesKuR6x8Z6wjRLfr74wT345?=
 =?us-ascii?Q?D+vUcf3uUYYq1+gxbDsIf+sFr55GuC0FZGkg4I3dVuWJdzydd7mJd0TD8oDX?=
 =?us-ascii?Q?zJVWkThdnXo9/3EU/Fvv7t5dNsnIwuQB/4Ij11z0Rxt1pwSS9LgwmDr2X2Wm?=
 =?us-ascii?Q?TfTU+njBNT6fgu0I3ftDbYyRBJz5vHFpFisXZyqJEv6js5oLZjAMaSotpsVA?=
 =?us-ascii?Q?2lT5UmFOh4AaNZ/jSKxxQBWJ0X/Hyc35Mdi2GKqLSiWjXcxMEkjvkgneY+9R?=
 =?us-ascii?Q?lszKgewKuzmtUxn6wWby3INLAvwZk+au9Pi6fo+uthm0CUk/GrsCDJmPeoNd?=
 =?us-ascii?Q?as7Vg+4ikp9PhODOYzGDsLMZ84xyL8le0WQiiL1f4J/LRERkHukvpK3Yy23Z?=
 =?us-ascii?Q?x3seQq53JyeF1aBR88euqbKD437VK7U9p+zlMrmfyI5kPE9PBzx5ftwm3EJC?=
 =?us-ascii?Q?RVH+gad9wTsgAZ95g+xSf1D3RIeQzenONdy7Q4BZeObURRIFftFnudQQXx/8?=
 =?us-ascii?Q?dR2sLr/A+Cdo99dJ05r7SLhGUF5zsH+FsswFHnQaxR8yz21IBbQdnT2rdI6h?=
 =?us-ascii?Q?h4lPolF3XfznG2Y9UHt41ccXkkXc/DnkFccRskd4Ij6T44PNuYERFL25QW5v?=
 =?us-ascii?Q?r2lU3+ehGeLX27cPVue7ZGQnvpfinmlY70jjBuCprYvndDZAMnARHkJYjveZ?=
 =?us-ascii?Q?ply2iKgbGsWyij5evZwY3C4YoT2gPFohJFOF69x0H25dSmC2ykGHO/yN9/uX?=
 =?us-ascii?Q?8s9+XokRnBwzSp7FnZSjSJ+aHpOBwVk1zyK1?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2025 04:20:10.2383 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4405e948-c52b-4f87-504c-08dd9d9eef64
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099E1.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPFAB8DFE4E8
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

Re-emit the unprocessed state after resetting the queue.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
index 855aeb7b1a89d..4018464e00939 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -5319,6 +5319,7 @@ static int gfx_v12_reset_gfx_pipe(struct amdgpu_ring *ring)
 static int gfx_v12_0_reset_kgq(struct amdgpu_ring *ring, unsigned int vmid)
 {
 	struct amdgpu_device *adev = ring->adev;
+	unsigned int i;
 	int r;
 
 	if (amdgpu_sriov_vf(adev))
@@ -5344,7 +5345,15 @@ static int gfx_v12_0_reset_kgq(struct amdgpu_ring *ring, unsigned int vmid)
 		return r;
 	}
 
-	return amdgpu_ring_test_ring(ring);
+	if (amdgpu_ring_alloc(ring, 8 + ring->ring_backup_entries_to_copy))
+		return -ENOMEM;
+	amdgpu_ring_emit_fence(ring, ring->fence_drv.gpu_addr,
+			       ring->ring_backup_seq, 0);
+	for (i = 0; i < ring->ring_backup_entries_to_copy; i++)
+		amdgpu_ring_write(ring, ring->ring_backup[i]);
+	amdgpu_ring_commit(ring);
+
+	return gfx_v12_0_ring_test_ib(ring, AMDGPU_QUEUE_RESET_TIMEOUT);
 }
 
 static int gfx_v12_0_reset_compute_pipe(struct amdgpu_ring *ring)
@@ -5535,7 +5544,6 @@ static const struct amdgpu_ring_funcs gfx_v12_0_ring_funcs_gfx = {
 	.emit_wreg = gfx_v12_0_ring_emit_wreg,
 	.emit_reg_wait = gfx_v12_0_ring_emit_reg_wait,
 	.emit_reg_write_reg_wait = gfx_v12_0_ring_emit_reg_write_reg_wait,
-	.soft_recovery = gfx_v12_0_ring_soft_recovery,
 	.emit_mem_sync = gfx_v12_0_emit_mem_sync,
 	.reset = gfx_v12_0_reset_kgq,
 	.emit_cleaner_shader = gfx_v12_0_ring_emit_cleaner_shader,
-- 
2.49.0

