Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B70F1C624D4
	for <amd-gfx@archiver.kernel.org>; Thu,  3 Sep 2026 05:56:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3AD0310E058;
	Thu,  3 Sep 2026 05:56:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0pWzbdcq";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011043.outbound.protection.outlook.com [40.107.208.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 969CD10E058
 for <amd-gfx@lists.freedesktop.org>; Thu,  3 Sep 2026 05:56:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lrTpaRIPkRKAxXoSiB6SWHXqXtgjTEDvoXjR1Y1X8VYfhPJKUsvkP6ad6NXB9u3hzOeMnh6QG8SgAJbeflqKBvgjzoJAtMDWZtar7LaPpTspVqTEB/oXh5nfd1/faGdWFoGaNEX/atTTgTmCA3soh1kZLLHodptzt8Yb0qczI7i5/NLeJEK0eoecSfP02b5khHDrZ3oiwPJVHORWExQArw1z3u01YaRXxgfWI69hVR3MwYypbT8vgjK9hZag0GXJYtwr8T+4b/HT26KafYyseueYxmlq5t+I6Nc0h3Hc0k4EyuLbjsvX6AG7SGNF1tvtfkejPVEdc1CSJssyUN/Ivw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9tDQZ28pL7KZ+nO8qZtjSSr18OkUyVXRuIr9JfbY5a4=;
 b=qoU7dnDr/JJwLEnlIC83fD3dAilPGSQ9bTh8bfIWXSpJcDajME0BQAlUwJ5LAik8W8YiLrwD3nbvJ04Y4xLHWkxg+MjZtuGlsfY8fmr5KLFcTUyCzFKWw+ziB5v+kYrZeDNma+DTgOlDr67d3PBzPFApFBg0nHsQvhdpS/Cy6Xo9XuHYnWnQEV1e8LBj0YUOOaZJEIy1nH6RXm9sH5x0D0F13c1T0Kx2oax9NKwk+1r8jm19r/7yl+buYscLkm1Fj5ixMjCUf8up7rXGiJRas4n1deDSA3QsdhZSJk41/UF0oxYju16Ob1izghni4HZqzFVxTbRlh63es2C8AuvCbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9tDQZ28pL7KZ+nO8qZtjSSr18OkUyVXRuIr9JfbY5a4=;
 b=0pWzbdcq1+bBevN64CtHEwR0tFKSSasF53yaiokSMQk6REgZyceWo9VR8DvQJrKsxiA3iPADQNKBvzHcXPd/84DQgXdccHU14mEoXAwBw8AUBTLEusmNplLJf19XH5+qOo+gBL0+Jw+GsU4QPWQWx8IjNTQILqSXb3a8Ub3cYG8=
Received: from BN9PR03CA0478.namprd03.prod.outlook.com (2603:10b6:408:139::33)
 by LV8PR12MB9420.namprd12.prod.outlook.com (2603:10b6:408:200::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Thu, 3 Sep
 2026 05:56:24 +0000
Received: from BL02EPF0002992C.namprd02.prod.outlook.com
 (2603:10b6:408:139:cafe::4f) by BN9PR03CA0478.outlook.office365.com
 (2603:10b6:408:139::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.11 via Frontend Transport; Thu, 3
 Sep 2026 05:56:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0002992C.mail.protection.outlook.com (10.167.249.57) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Thu, 3 Sep 2026 05:56:23 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Thu, 3 Sep
 2026 00:56:22 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>, <Le.Ma@amd.com>
Subject: [PATCH] drm/amdgpu: Move GC v12.1 spm vmid init to hw init
Date: Thu, 3 Sep 2026 11:26:03 +0530
Message-ID: <20260903055603.65101-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0002992C:EE_|LV8PR12MB9420:EE_
X-MS-Office365-Filtering-Correlation-Id: d5238c52-90fa-4f6d-3e94-08df098015f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|82310400026|36860700016|10067099003|56012099006|11063799006|3023799007|18002099003;
X-Microsoft-Antispam-Message-Info: JGWOwSR3Dix5LSWkHbGblqXo8AZVAAFDdzWm24BRqDNhdp370Uc+WL9DXYd7XdnwEYUU5M7vPtVN8/3UiiO9n0IIxh9eMlrr/uMg4Gf83I1hUzBzyT8EaxDE1X0pNZQl9RigXXZ/g2av8IqHdzBKElcG1hLWKRJQffHArvzkIluosxX7/Ojij2Vt8dkQSzUWV/EdZvfeUIXu8PbKccfIrUJAo3/8fWHARfE7PhG5Fz80hCJ7PJHjD28vEytCkHsxUgmurukdF6xhrnd1yuPLq9yjVExtin9TwehBKPxEAizE4bz+hmLnkg5kEkWVsDkEZL2TBz2PGR3XoymZiquzzCxTIBIcic5z2eO7xTS8bfJy9fnGadJ5fTD2jauL7kM90e/I1jr5pAAlcJkyCOxHNMaaVTcxvaatAiE9ETPyzFovCXAqlyyGZz3z6nJNcTFkzIjhpuTCpj9w6cT3Yfvr97Y9KvMyooGsZtJOJT7GM6Q/C6/8CyEPoCIy6SygZEr4dThPu6cbYyqoq2aKhLxhqyCwNcpBjy85f3te97IproX2oYYxijLS9Js4ECfNOWlZGsLEFBRqCh84wkrDh4jSuCa9QSCCnayniqgW6m18LPl5LBhC4+jfmZK/3ArA+5SfZMbLSVtah4ZliNaI83cD3jXWP8iu8A5P80Bahi0gF9PlHc4+jG1pJKWn79fXQZ07k6WWCeBLUAAw2OMoWDEKKQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(82310400026)(36860700016)(10067099003)(56012099006)(11063799006)(3023799007)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: wPMfv5EI0Q4MSiMZAJ9jxcCUTOrkBL+XhKeg0rxJBHWe2RbJvCsCYImjIbIF6WXbL/rwsiCSYdIS+NV2KBYC+8YeZlCigOa04QtHoNEo5blmHS2JBF2enK2HuADiPuieQShgbSiQRuJQQtvVC03AAbvITvCNK8GUxhycTHir69Dc9+N29uWY8+ClkNd3kuJUb3TxhwqW+ndmrsb2sCNoho5yDxpcYQzqqotceJvtuKZEUelO8OTrXyXNWNze/TuJLxofLEVG1aO+cANC6SxbEoyAYDMAW19IO8Vn2K+pjw6GcUeO0tvG+LYw6YAdAYG9rBqhTEXqLzmbqa2jNrrBLw6zd14Kko2dNrv/2l8AHOEHJD8VxUpNlp/aOn2FwJ0HSjW1V9aM4HyAi7LXE0k8nZiQJ8RLy6+mct6O1fakC8TXfZSie8pWZvrCCnvj6iAs
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2026 05:56:23.8563 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d5238c52-90fa-4f6d-3e94-08df098015f9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0002992C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9420
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

GC reset is not released during sw init and hence it shouldn't be
accessed. Move spm vmid programming to hw init phase. This programming
may later be overridden with the job's vmid.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
index f812d6d81e9c..1aa86b85ce88 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
@@ -218,6 +218,8 @@ static void gfx_v12_1_xcc_update_perf_clk(struct amdgpu_device *adev,
 static int gfx_v12_1_init_cp_compute_microcode_bo(struct amdgpu_device *adev);
 static void gfx_v12_1_xcc_update_medium_grain_clock_gating(
 	struct amdgpu_device *adev, bool enable, int xcc_id, bool force);
+static void gfx_v12_1_update_spm_vmid(struct amdgpu_device *adev, int xcc_id,
+				      struct amdgpu_ring *ring, unsigned vmid);
 
 static void gfx_v12_1_kiq_set_resources(struct amdgpu_ring *kiq_ring,
 					uint64_t queue_mask)
@@ -695,7 +697,7 @@ static void gfx_v12_1_init_rlcg_reg_access_ctrl(struct amdgpu_device *adev)
 static int gfx_v12_1_rlc_init(struct amdgpu_device *adev)
 {
 	const struct cs_section_def *cs_data;
-	int r, i, num_xcc;
+	int r;
 
 	adev->gfx.rlc.cs_data = gfx12_cs_data;
 
@@ -708,13 +710,6 @@ static int gfx_v12_1_rlc_init(struct amdgpu_device *adev)
 			return r;
 	}
 
-	/* init spm vmid with 0xf */
-	num_xcc = NUM_XCC(adev->gfx.xcc_mask);
-	for (i = 0; i < num_xcc; i++) {
-		if (adev->gfx.rlc.funcs->update_spm_vmid)
-			adev->gfx.rlc.funcs->update_spm_vmid(adev, i, NULL, 0xf);
-	}
-
 	return 0;
 }
 
@@ -2005,6 +2000,9 @@ static int gfx_v12_1_xcc_rlc_resume(struct amdgpu_device *adev,
 {
 	int r;
 
+	/* init spm vmid with 0xf */
+	gfx_v12_1_update_spm_vmid(adev, xcc_id, NULL, 0xf);
+
 	if (adev->firmware.load_type == AMDGPU_FW_LOAD_PSP) {
 		gfx_v12_1_xcc_init_csb(adev, xcc_id);
 
-- 
2.49.0

