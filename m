Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E7AEC67861
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Apr 2024 17:20:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9948B1128EF;
	Mon,  8 Apr 2024 17:20:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="i33MwTS8";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2053.outbound.protection.outlook.com [40.107.95.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EBCF11128EF
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 Apr 2024 17:20:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LFpMZVafc36ef6YLyDHrTfj8m5U/NR9lVTyF3B0MQipeZMA22F3N39lL4yh+6mFVecFRyjE36jTEUNqRXZPQirZwXidyolCSkUU2chRrfp05BztZ1w086Ks4qusWQlA+dpY+kyemrRL06ZW3iUAvLXIfYz3rUM2mmKSsZWSwS4X5APk9VcCrdJt4R0Cl6wGUBFL0MkfWyarPw/b9w2S8AAnSPMgef1GsQOz2viQ5G/t+OJW3/0f7e2XLwlm0WyL4fkks5/gHix5St9YeuChv1vCZmZ1a0XOZ8EFlJaeQcAdvZi4CFDMkcE2pI6nwOT6DiLIMiVfXP/DOA9VqYRgCdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9Uw66lmSnwbSSlWzK3DxRgXTuxeR4KetFl2RPftvklA=;
 b=DKQVb1lbK/Cj8B6NiSky/0qrV+l2ht6kPK0V9txqp4+GBmtzYsZduhiglKuNVfrftB/+xrHOL4Tu2w/mWYbcHvgIq3mB0QlMiPJ0Ls0UtDOGotcu4R/TQ2+SfGa6f75nE11oWd3+wylPR7OFdW4JnFyqFH5L4J+3dVlhgU++QFrlcxld4Lhm4ny2uyRymEHDj9HVmld5x4e1ylCRC4fsmyTjL/8H26y/P2fMVehkVe5XioApfaPrNWIRbT6gr1cux4oqKEhnrHUL0o0BRdFEZxvQIbDuH6BdBKQTvaGwnA8u4qo7czxVZVGeiS0O9Xt8BZxkWJeIaDuitImPvVKXUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9Uw66lmSnwbSSlWzK3DxRgXTuxeR4KetFl2RPftvklA=;
 b=i33MwTS8AxUuM82myWuNtPl9ZK1mnRgf0vH2q4AkG8Fcn1E9DgxkooMw5u09ZjmAipEbI3LnI3cEhcGs4MfsLFcnCVwS+r0da9cgLu9Rf/9+n4bV4TxGN4uE3moxu9o2w3UsjmOO4ioRZhLItLueshpGuIhjOP+tXH9KqOPthYI=
Received: from BYAPR11CA0069.namprd11.prod.outlook.com (2603:10b6:a03:80::46)
 by PH0PR12MB7932.namprd12.prod.outlook.com (2603:10b6:510:280::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Mon, 8 Apr
 2024 17:20:45 +0000
Received: from SJ1PEPF00001CE0.namprd05.prod.outlook.com
 (2603:10b6:a03:80:cafe::5a) by BYAPR11CA0069.outlook.office365.com
 (2603:10b6:a03:80::46) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.30 via Frontend
 Transport; Mon, 8 Apr 2024 17:20:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CE0.mail.protection.outlook.com (10.167.242.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Mon, 8 Apr 2024 17:20:44 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 8 Apr
 2024 12:20:43 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu/gfx11: properly handle regGRBM_GFX_CNTL in soft
 reset
Date: Mon, 8 Apr 2024 13:20:25 -0400
Message-ID: <20240408172025.5848-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.44.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE0:EE_|PH0PR12MB7932:EE_
X-MS-Office365-Filtering-Correlation-Id: 926312aa-f2b1-47c0-ae5f-08dc57f039b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ro5xXw6oTFmKXk5D1zAWkrsXdDUVLpjsqTj4HedW50Dm5PUpTWg/0K1G9gkWIt3NJVggRfeEzB+3msUKp5/XW4xQ/EKpL+NmaesYsOhmvEitFUZs6cCc3Knz0ZkqIr7wkMBgQm0dr3qwsXHGEcY7ImTU+poxJe1hvu7Dy1Yy3vxx3lfevhxqFzLxfqryf4RGoeNAw2AMSZiYHzGgWY1YQYkSXcrXv7ce5VSn2dBU3mrWHyeO9LPECGwijgdVbbvZyG8PRxOKQk2teXxtl82N2v9uwkNCDFmV+HtIVJPgkw6ZWR8SmawbypeM6JRt7RREyVCkavC6oh9MM4D3kRFHR7Zql9oq+k5aQMpUuoWySDpwmvOCqbwmlwCgTxkggzzwDEK+ASgQUssO5kIqfJbYGd2YFIozItykQZ270LP3UNAZkhVxxPUi7G0RS2bIenGuDU+i12kUP1uWnzu+HsqX7lI6ncaQVIQeMFL5NFMQXunKG2oeYeKe6bHjScR9FERI8TX1UcTHcnaDjqHqlW4hHCzI5oKsy8/H0ZbLOJEa+R7c9doV8/EDBmS/2u947NGuCDNFV+8scFIeJNz7mVgaOmkws+9/RHQDRBT0rBgrx+lBHETkfHziOB5MGmyD790ArDHrMWAfH2PVJF5eDhTUtUNleD9kaNuh43sPS2J0DTILqzSlbdnL0jrXnqHHbq6Yts82T6iwA3J4E7E4q+1EYhTuHzFTAynbCNo3R2ctPidIDZmnShNABA/7ud2axOL2
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(36860700004)(82310400014)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2024 17:20:44.8996 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 926312aa-f2b1-47c0-ae5f-08dc57f039b6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CE0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7932
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

Need to take the srbm_mutex and while we are here, use the
helper function soc21_grbm_select();

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 7a906318e4519..dc9c0f67607b3 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -4506,14 +4506,11 @@ static int gfx_v11_0_soft_reset(void *handle)
 
 	gfx_v11_0_set_safe_mode(adev, 0);
 
+	mutex_lock(&adev->srbm_mutex);
 	for (i = 0; i < adev->gfx.mec.num_mec; ++i) {
 		for (j = 0; j < adev->gfx.mec.num_queue_per_pipe; j++) {
 			for (k = 0; k < adev->gfx.mec.num_pipe_per_mec; k++) {
-				tmp = RREG32_SOC15(GC, 0, regGRBM_GFX_CNTL);
-				tmp = REG_SET_FIELD(tmp, GRBM_GFX_CNTL, MEID, i);
-				tmp = REG_SET_FIELD(tmp, GRBM_GFX_CNTL, QUEUEID, j);
-				tmp = REG_SET_FIELD(tmp, GRBM_GFX_CNTL, PIPEID, k);
-				WREG32_SOC15(GC, 0, regGRBM_GFX_CNTL, tmp);
+				soc21_grbm_select(adev, i, k, j, 0);
 
 				WREG32_SOC15(GC, 0, regCP_HQD_DEQUEUE_REQUEST, 0x2);
 				WREG32_SOC15(GC, 0, regSPI_COMPUTE_QUEUE_RESET, 0x1);
@@ -4523,16 +4520,14 @@ static int gfx_v11_0_soft_reset(void *handle)
 	for (i = 0; i < adev->gfx.me.num_me; ++i) {
 		for (j = 0; j < adev->gfx.me.num_queue_per_pipe; j++) {
 			for (k = 0; k < adev->gfx.me.num_pipe_per_me; k++) {
-				tmp = RREG32_SOC15(GC, 0, regGRBM_GFX_CNTL);
-				tmp = REG_SET_FIELD(tmp, GRBM_GFX_CNTL, MEID, i);
-				tmp = REG_SET_FIELD(tmp, GRBM_GFX_CNTL, QUEUEID, j);
-				tmp = REG_SET_FIELD(tmp, GRBM_GFX_CNTL, PIPEID, k);
-				WREG32_SOC15(GC, 0, regGRBM_GFX_CNTL, tmp);
+				soc21_grbm_select(adev, i, k, j, 0);
 
 				WREG32_SOC15(GC, 0, regCP_GFX_HQD_DEQUEUE_REQUEST, 0x1);
 			}
 		}
 	}
+	soc21_grbm_select(adev, 0, 0, 0, 0);
+	mutex_unlock(&adev->srbm_mutex);
 
 	/* Try to acquire the gfx mutex before access to CP_VMID_RESET */
 	r = gfx_v11_0_request_gfx_index_mutex(adev, 1);
-- 
2.44.0

