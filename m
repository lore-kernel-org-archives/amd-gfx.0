Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DED2CC3ABC0
	for <amd-gfx@archiver.kernel.org>; Wed,  7 May 2025 15:27:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 557B210E83C;
	Wed,  7 May 2025 15:27:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="yPQaiLma";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2081.outbound.protection.outlook.com [40.107.223.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4E2E410E83C
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 May 2025 15:27:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UnVk/+qt+PWWJJZUcsokKEaXgfTsX/StBsOWrTN3ELQF14FyE4Vmzdk271AMfCi6yc4G6ltDxCozE2iSomu0gygQb/VyO8orAFWepPMahDcS5qmHNJm3TrdhrwKrzFSwL49AfHLLxR7YQuovRt5s/JEf+WjVQ9238ubTcbsZFh/hweBjvEpZ6859dy6/IR3/c2k5yLi6jWsyUWnV7EuDnSdePJygXRR0pzXxCRlPwgXtjIigNbinlyXxNzz+uRpEhDgIArQiNWa1l0lnwQ0XkKogqaZlE+kaOPtpKdjzLFhOiOl66HfWBBecBFojE/9yXs7oHUUR1MGQT5ejRcDvTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/WGGb3HraY+6x7sfM5l97oBSbA6J1PI882mm0b7P3T0=;
 b=KFUsFpxG/sW9FDPV0BjYKnM30TxnwWmN3mOTCqpx7hJ6T8ZL3UiBLDs5WDxbI1WCTG8iHxcA+vqbKniy5SY+nFttRFxjghXvXHl80mS8jmA3gEax55a+T5QhwS9Hv8PFDbV9ln1lyfScBxF49uPSTDeTPI9Q9KpM2FmNWIuzfoS1cP8EnDu+hNQzcQ2C3O2dcGJWLKbpTgqNQYudKs0nlawvlJS6hupFbPz81sV4SnqZkJlF4zmsT6i0KnGv4K6aIUyPUX8SZ9cmhpyouHUMMjyGY2yqQT2N1ptf41sFi+mS1xYe+x4NbzfnTQ8er0/hp/+BHqNWDGp/GvWG2XGZwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/WGGb3HraY+6x7sfM5l97oBSbA6J1PI882mm0b7P3T0=;
 b=yPQaiLmaxun+EE3L1jo/61v+vbDyp+MlmfAIg/1tCuXmhZW19h6iA4UwcW7LnfLNdqtu23eEcvpOnV0Y6hXgmaPaKHByhJn7uywkPkWXOcye0y4OLuFm7drM/e0B9gnPnldLQJcvhMgB+OX++qeIpmIVQVdTIizy7GC0WVMrXzU=
Received: from PH7PR17CA0042.namprd17.prod.outlook.com (2603:10b6:510:323::21)
 by CH3PR12MB9730.namprd12.prod.outlook.com (2603:10b6:610:253::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.23; Wed, 7 May
 2025 15:27:26 +0000
Received: from SN1PEPF0002BA4E.namprd03.prod.outlook.com
 (2603:10b6:510:323:cafe::a5) by PH7PR17CA0042.outlook.office365.com
 (2603:10b6:510:323::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8722.20 via Frontend Transport; Wed,
 7 May 2025 15:27:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002BA4E.mail.protection.outlook.com (10.167.242.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8722.18 via Frontend Transport; Wed, 7 May 2025 15:27:25 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 7 May
 2025 10:27:24 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>, Alexey Klimov
 <alexey.klimov@linaro.org>
Subject: [PATCH 2/7] drm/amdgpu/hdp4: use memcfg register to post the write
 for HDP flush
Date: Wed, 7 May 2025 11:27:05 -0400
Message-ID: <20250507152710.234881-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250507152710.234881-1-alexander.deucher@amd.com>
References: <20250507152710.234881-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4E:EE_|CH3PR12MB9730:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a07e8d8-a16f-4a0b-f292-08dd8d7babdf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024|13003099007; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?S10QtnIh0q2MXVLi0Ry8lNa778FVeMpg8P2T8e140wu7JXzJi8p1ddNWRl00?=
 =?us-ascii?Q?c+8proowCqXX8TYUJVVMPOag85LzKDrjhT2opfRUV4zyUCuUfr6/YAFdV/CX?=
 =?us-ascii?Q?zTHskvbT7q+dKWY8J1MHknmzYztlyD/wMDqT0r16lvqgbXsfomuqGaUOCUMn?=
 =?us-ascii?Q?wS+kJimpO2hG+qHUP0pQ13FzW+uKWoIHreoHHayMSXazbVl/Pc2tgSFG3YNs?=
 =?us-ascii?Q?FwtoMnFUeB4vRYQYUBmWoLK8sUYwUFdvIPKMc3A1e2QESBuQ8GMwh8XCnc05?=
 =?us-ascii?Q?tligk6tlCFpe1kpOzNp8/H3q50z5Oag81Q5uY7Ry5QqqiVwWi8Oj3n/89+q4?=
 =?us-ascii?Q?AkwBWVAgj9mlvbRsFePMQJIz3BEmcFgzGqEHLebq9jMbKppA/cdhIs5vcK5h?=
 =?us-ascii?Q?IvflLdgv0K8ywk3DDLAFDsOz9ec6Wdra5vS87TldolaHys5UPx5k4rtRGwHR?=
 =?us-ascii?Q?GsKcZLo3Bqkpk7fg3VTXZfh3Dx/KQMQe3CwE+Kn147Rskj9qp9Zg1padITi/?=
 =?us-ascii?Q?LT8JS9ZH1n3svOppuhg1QIlpmAw+9+UK1MZZjJ+wBnYKOP11cH9e5bDzlrJ5?=
 =?us-ascii?Q?vh0aOpTOIy96wkLk4S1W74nCMNdM1br+x2yuJi3V41ouOP0fZ9RRkCXJmjuP?=
 =?us-ascii?Q?V73qm8jbTI1LMSJPesVDJ6zkCDhYsIzDKm2gosUxIVcjdTuzxSWBbrHX4k4y?=
 =?us-ascii?Q?c48KzRv07JKbYTggt9/abOh1x3yGwMc9hGIiULkucQ/QZw6QBcpOXZoVLz2d?=
 =?us-ascii?Q?oQwDUB4kOWhjMI7xiZBbaqLx6VhQ+FsBqFgqW9XzqmulUe5YRMbnWgKW5ftk?=
 =?us-ascii?Q?ntUuemy1Vkzmo2c9fQ7AHLP3lSHFoUJXabPbgY0BPpAAFYf1iADKJb+wrkU+?=
 =?us-ascii?Q?QJdB1UIHlWJqDiECfX5j06eZ7x334Hv0EqPE1AQ5qFwSr2r+OFt2vAUYs6ql?=
 =?us-ascii?Q?NpiSsi5UAfJjmY/6joi1FfQzwyHnRoCwNKDH8GnO13iBC/5RHQ9vaue6tpwm?=
 =?us-ascii?Q?XFEYhUObX1Ip2gVcGHyCVJ3laEbaEJlN0Ugd6Xi+4d5S8pn+bFhOUiuHoPlW?=
 =?us-ascii?Q?R4HLe+9LbRCrwGGSKXvM2AJVwj5x/Huc/IUj+UoXNhEO+hT7oFaNLTTL0Ws2?=
 =?us-ascii?Q?imoRvqlFwOC2JhQO+3qNN2XkNsvifePpDMvVPbm3m+2fck/NGuAv2n4Pb8wt?=
 =?us-ascii?Q?050es7GbXa5/i7ulbkyDpC6cA1e8nmsafz2TDA83z2lngpZKG3OKE2XUBVNj?=
 =?us-ascii?Q?UU/r+so4AkFJ44Aj8nxJ3I0d5Me6j+hm5PGouIyobkn7cZLJrBCnUAblgCte?=
 =?us-ascii?Q?UkAf/shySPXDPaakAvhOo6SPxbwfvGf7OgIl/Bf0zLUgrdgMZFfNkPArUxxy?=
 =?us-ascii?Q?/FIiS6KXV+/f1gbX37RRjNLv5212gPfNx4aOf/5KbpCzmR7unNBoDSVWEmBc?=
 =?us-ascii?Q?WSO7imzx13yq3vwMqncbMk5udO4EzpycAk1MOIjawYcRAeJTh114YQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024)(13003099007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2025 15:27:25.9926 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a07e8d8-a16f-4a0b-f292-08dd8d7babdf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002BA4E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9730
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

Reading back the remapped HDP flush register seems to cause
problems on some platforms. All we need is a read, so read back
the memcfg register.

Fixes: c9b8dcabb52a ("drm/amdgpu/hdp4.0: do a posting read when flushing HDP")
Reported-by: Alexey Klimov <alexey.klimov@linaro.org>
Link: https://lists.freedesktop.org/archives/amd-gfx/2025-April/123150.html
Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4119
Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3908
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/hdp_v4_0.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/hdp_v4_0.c b/drivers/gpu/drm/amd/amdgpu/hdp_v4_0.c
index f1dc13b3ab38e..cbbeadeb53f72 100644
--- a/drivers/gpu/drm/amd/amdgpu/hdp_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/hdp_v4_0.c
@@ -41,7 +41,12 @@ static void hdp_v4_0_flush_hdp(struct amdgpu_device *adev,
 {
 	if (!ring || !ring->funcs->emit_wreg) {
 		WREG32((adev->rmmio_remap.reg_offset + KFD_MMIO_REMAP_HDP_MEM_FLUSH_CNTL) >> 2, 0);
-		RREG32((adev->rmmio_remap.reg_offset + KFD_MMIO_REMAP_HDP_MEM_FLUSH_CNTL) >> 2);
+		/* We just need to read back a register to post the write.
+		 * Reading back the remapped register causes problems on
+		 * some platforms so just read back the memory size register.
+		 */
+		if (adev->nbio.funcs->get_memsize)
+			adev->nbio.funcs->get_memsize(adev);
 	} else {
 		amdgpu_ring_emit_wreg(ring, (adev->rmmio_remap.reg_offset + KFD_MMIO_REMAP_HDP_MEM_FLUSH_CNTL) >> 2, 0);
 	}
-- 
2.49.0

