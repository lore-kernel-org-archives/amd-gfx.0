Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DF83CD6E4C
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2026 05:51:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B8734112DB7;
	Mon,  1 Jun 2026 05:51:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="L6scO11i";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010000.outbound.protection.outlook.com [52.101.46.0])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 37772112DB7
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Jun 2026 05:51:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O+rU3UCoagwbxnTp5kbFtX54magZ19b0VDDeFkMo/IoZIhmKohZMZg7GmiYihGzuwipsdnfRiD1OkRhOHWJPuV3kvl2KPrRE4/uyJRKUsLlhGs2uF+7wHEfnBGVRtN/pPBDBn06faND+yhj2eL9AbZ1HSZuaouAEFEI/UFD4UEobT0pRs54I49WF/YuG5HjwQbXLAEo1hxeh+DJ1vyziG/rS7+iurANy+HcUiSCKoGKFOATMEacOfJkat64Umk3oAGXnaj7qM4C9UcJvhQjXtOfv8BrNyPxq54gkSwpY+n6VsJNXGfn+7pclxyz8Hwuyt2ZK9zl2QtNWr2X6TPImYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=67Z2x8a12RhuMwRIY0C8YT7tYA3F9NrjAv5fXZzyLH0=;
 b=C3b3BbtnG5FyPe9M7PVm20zV7uX+uGRSGeH0trfjbPMTtwSdNfL/nK6rslr64UvGcLDnOwzdH1JxBkQEC+Qv7I9waZBfcNs3fARW1oJhMpAR5hk8GbtUjo+thjH6aKzLsD00GYdwdoCP/H5wgmIBst6pOFBdMXtCG5noPIDrTQHJtwLZdErjK6QbVoiIlFIlpwr9eafJkhLAjsYgXDq3gt759Mss7ouWlxhrhUdeGa6zSpwanGsl+/VWNAxlKsJaCJ8iollzxpZ6UB3izHwix2kwYQU7kxYyVe73C+6A3DPwqKn6W5+1h54ZrPc2430MJGUtfUNJJRqIsmoYdl5pRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=67Z2x8a12RhuMwRIY0C8YT7tYA3F9NrjAv5fXZzyLH0=;
 b=L6scO11iXhUogPVbg1UzL2sEcxMYOFN2tXkMK1a0jAzzC9+RjXh3i12JMUitLVOMjpFh7TcEuaTiuDpRBjhqyi4RqhtQa7O/bZ1uji55dsWYA5G0aGSWNYipOAvWzOLTKnYVbDoTXdF9BE/Tm9QapKRyHpZkc26NDrmwfrmTFNo=
Received: from MN2PR22CA0013.namprd22.prod.outlook.com (2603:10b6:208:238::18)
 by DS7PR12MB8292.namprd12.prod.outlook.com (2603:10b6:8:e2::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.15; Mon, 1 Jun 2026
 05:50:55 +0000
Received: from BL6PEPF0001AB58.namprd02.prod.outlook.com
 (2603:10b6:208:238:cafe::46) by MN2PR22CA0013.outlook.office365.com
 (2603:10b6:208:238::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.16 via Frontend Transport; Mon, 1
 Jun 2026 05:50:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0001AB58.mail.protection.outlook.com (10.167.241.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Mon, 1 Jun 2026 05:50:55 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 1 Jun
 2026 00:50:55 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Sun, 31 May
 2026 22:50:54 -0700
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Mon, 1 Jun 2026 00:50:48 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>, Jesse Zhang <jesse.zhang@amd.com>
Subject: [PATCH v2 03/42] drm/amdgpu: track guilty fence for queue reset
Date: Mon, 1 Jun 2026 13:48:49 +0800
Message-ID: <20260601055034.3700921-3-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260601055034.3700921-1-Jesse.Zhang@amd.com>
References: <20260601055034.3700921-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB58:EE_|DS7PR12MB8292:EE_
X-MS-Office365-Filtering-Correlation-Id: ad068a9d-361b-468d-d368-08debfa1bf4d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700016|18002099003|6133799003|22082099003|56012099006|11063799006|3023799007;
X-Microsoft-Antispam-Message-Info: EHsUlraBBnMlBAl4KURCzh/kLU+MfiUCACaSW8A9dCX0fEeIIgqVP0DqqPHkURwKhvzs8ccpMY3ObaEAu5uPKGvZs84Q9p3P2JEFv/P4alrEojTy2im4hxR0tRJ+iVNXuJiw6eYNDxCzT+wkJJw7RiwlDNluHJJoY4F4FVIprUm4nQGS+TOP1e490/ROs2zcXleMchpbRwgBXzcWBupSxWHWhQkjiW33N29wT7RFaqqh+3DBPw7VUfK5kPmNLwBwNLckFaelNPbN4PT0yiqdTa4ojjTXCfHZsviUN3oG3C+uvGwKirpLOLJ/YxgFPHqcHbBTJW4p6c/YRWblYujdf9xwZ8XsO40qioIZDpn/Q9NOfoIhb9mnBiR66ORqhP2WfARvFPLp/0PTu7HhSeDN7zXYMhjvKYJO/W4YhJf3laoFNrB0voIuzOSNA02f6HtUa+YeCE8KrqHZ6d/J2XelxroO1FbE1L65mj1QJ+zPQ6VGjLlOiuIjHpRTOY8ldH/kKwnSGq7+uu0V8lHJaQwN8Vq4DqV9rBFEUNJ7gW1zO+94/3ZoHHpbXXUlzn7gW8FlCAA2ZQgET1yq5bFVt0iWj+TSNsLUMl1Pnd71On/HErGzxCvdZW2pDxyBQAUsurFcab0ZW85ksilhfb80TxU/O8GiRVe1X8DLHWsTNd3MB7LahMlPTueUUD9PDqh81ThyiXxI1Kdv2PZVhoX81X0cogVzb4ikrR5BDjkJkQoUhZg=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700016)(18002099003)(6133799003)(22082099003)(56012099006)(11063799006)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: A3gFb6rAE1LTewJazmGMJYNtrJovA6rsZGTKDKKac0iI4HWVHSJjvnZSlT+qCr1ASOhz6EwYLmtUxmRsxKTIc7oNcU6uL256tdz4EniykzxQ9SVcFUE3JbgJFrz4Kn+T8MEeraG1xuXWEfcEy/AM2yIcxD+lFvSOrXntpNraYeO2o+qx8TkvJc51nayko/a2Xwpy80hDv0rWmKVlUczV39BIU7kaArnUKN9TWnQeOSmXWsODEx/yt/1DtLi4CxPNAuWwX9rsaSA6inwSFAUS14QY+fm+tmbAjm85lx6PsxyBxThEI1Z88t4HCHnlXm69gSny2g8+pNR+56nLDgrj+QEv2AWmem8sUlOCUght67ihImQsBCIxI3Lph99IYzdC14EuGotP8GdX3ejGa4MrTgcz+fE2+rLE0n+l8ZcspvDSKIrs6rBoKkggIBBBAoAJ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2026 05:50:55.2941 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ad068a9d-361b-468d-d368-08debfa1bf4d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB58.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8292
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

From: Alex Deucher <alexander.deucher@amd.com>

If we've already seen a fence, don't backup the
ring contents since presumably either the previous reset
was not successful or there was something wrong with the
data.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Reviewed-by: Jesse Zhang <jesse.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c | 11 +++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h  |  1 +
 2 files changed, 12 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
index 6a43c8494fa8..a7a6db0bc694 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
@@ -803,6 +803,17 @@ void amdgpu_ring_backup_unprocessed_commands(struct amdgpu_ring *ring,
 	seq = ring->fence_drv.sync_seq & ring->fence_drv.num_fences_mask;
 	ring->ring_backup_entries_to_copy = 0;
 
+	/* if we've already seen this fence, return early.
+	 * ring->ring_backup_entries_to_copy is set to 0 so
+	 * the reemit helper will return early as well to
+	 * avoid getting stuck in a reemit loop.
+	 */
+	if (ring->guilty_fence == guilty_fence) {
+		ring->guilty_fence = NULL;
+		return;
+	}
+	ring->guilty_fence = guilty_fence;
+
 	do {
 		last_seq++;
 		last_seq &= ring->fence_drv.num_fences_mask;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
index 8f28b3bd7010..9276a3bb69de 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
@@ -314,6 +314,7 @@ struct amdgpu_ring {
 	uint32_t		*ring_backup;
 	unsigned int		ring_backup_entries_to_copy;
 	bool			reemit;
+	struct amdgpu_fence	*guilty_fence;
 	unsigned		rptr_offs;
 	u64			rptr_gpu_addr;
 	u32			*rptr_cpu_addr;
-- 
2.49.0

