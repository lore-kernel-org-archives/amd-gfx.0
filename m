Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D546CCD1A0
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Sep 2024 13:40:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D93E810E5AA;
	Wed, 18 Sep 2024 13:40:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="DBNj2Rsr";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2073.outbound.protection.outlook.com [40.107.236.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5633010E5AA
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Sep 2024 13:40:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N+IC0ABh5zeB2xSbuGv2/dTZJczRwvL43VoEK03I1CB2o8MxuUrlK1ErM5LXSBVrTHkv4BvJXVQZY3Lnnfo2LrlrWYxpx9A5M2IYKnBdmrdUMl9lbfZNGR0hKBiQXuq/dWfl6xZq0iTZUJj/jgrSy/ZVRPHEye0RiAJlM0NQr3+R7ugJ+PhwJX2vdANVgSaVSClc6inwuQZSF2GLXV8eMJaT3XBuYM2kAZsAk5A5SYGVIn4zygryq6HdY9iHx8zzSaQA+fSNUftVbRLlpXH+e80F/frQgnABn8nVlkJVpheOWA6BJpPFprmqDl56n7z/3gC83dhrOjy8k6pDYx3zfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fqgc5vc4ekFx5bTQcm07Y+i4M+CG6MTqC8rH09/6eKA=;
 b=mJLhE3t616j5M1A5tYSof6VZ65RK2JHJI3wMHLuGDaDT3XddejlDrqcYj00lErGrii3mf0Zrf1/rKFTHMxFDEpiNPehmxrtsZhAe+zt4Iqve6ZSbgSsBrBsk8TMSYo/marmjXEXgQUEJygCFULx0cKUhl8T/6t5lwEjT+ykRqy39w5BhAhWs39Yv2ivS5k18JSPl/iQWEN3pbB0K1isefX889QTUKPBbU7gas0zbL3XHrWFZkE1BJ5zdgCPyNHbtYq2kRgCgnuokV2eI/IcCqWX0qLnNV047ICJgxZ+h/6KHsG0T1mS2fNpEnk42ALn44L9IfSeaUXmgwK1z2kE1Jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fqgc5vc4ekFx5bTQcm07Y+i4M+CG6MTqC8rH09/6eKA=;
 b=DBNj2RsrU5OY2ofgX8Kht/qAquxLEhgzeLsNUW7qqVSePBrE/8CiIglOu0KH3uhZ7eCFTn7WVIFMkvFSy44+RRUdz2W+2YF0t33IgIKK9lJuT3Rd5rCLMy8Zglnv61ngx/D1JI/lZHRyzJyUZ7lFEuYcxUMeloktlHb4ZPHqsOI=
Received: from BN9PR03CA0238.namprd03.prod.outlook.com (2603:10b6:408:f8::33)
 by SN7PR12MB7788.namprd12.prod.outlook.com (2603:10b6:806:345::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.17; Wed, 18 Sep
 2024 13:40:13 +0000
Received: from BN2PEPF000044A2.namprd02.prod.outlook.com
 (2603:10b6:408:f8:cafe::ca) by BN9PR03CA0238.outlook.office365.com
 (2603:10b6:408:f8::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.26 via Frontend
 Transport; Wed, 18 Sep 2024 13:40:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000044A2.mail.protection.outlook.com (10.167.243.153) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Wed, 18 Sep 2024 13:40:11 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 18 Sep
 2024 08:40:08 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 2/2] drm/amdgpu/mes12: reduce timeout
Date: Wed, 18 Sep 2024 09:39:53 -0400
Message-ID: <20240918133953.3786248-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240918133953.3786248-1-alexander.deucher@amd.com>
References: <20240918133953.3786248-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A2:EE_|SN7PR12MB7788:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d7057e9-9c17-43f1-c18a-08dcd7e76b3c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?fgKEaT6/0xXMucy/EP7L6Y1aR6G3yuSTGLmH8m9ik9m30UafEP0f1rBE0DHF?=
 =?us-ascii?Q?ZXK22FmkToqhgczLzRKnS1/+w0ca2Hqdkgh6fdUe7oTuBZHBS2P8dnOB9M8R?=
 =?us-ascii?Q?CZgJ2AnWvt8jAQ3nXR4SXcwzDEwgaCAWAYVJHAMiNqQE83WtX3d6YAbE03bd?=
 =?us-ascii?Q?hKR2CUkcJPWnXAAUSGfiMQqmQW2HEU7Yxzj84zAGNob+v1BEoynBnO/Pc0Nd?=
 =?us-ascii?Q?yIMXDVI7FVpTc5zC4LG5yZ77yL1O6hPG8zgsWAIwODQBIIlBfwDjK5nqoLjK?=
 =?us-ascii?Q?Ogj263DSxldDz0i5nSPchm+St7SgJ3KT8HBbU1/wAAzIKd2pFNBMK4a60jz7?=
 =?us-ascii?Q?naRSwwrDSHX0zFHGy6nodiA0P0fv2ZTL6pZX2DUaCrn6Kkr1ybwHVrYgjI5C?=
 =?us-ascii?Q?H611MuuEI8pYWXP5HtL8UB6D1wKxnasSf2vjWB2Uo1XktIGob3FY84fArO3+?=
 =?us-ascii?Q?4NpBpsZekmVeCi/4rIjs/DJGglMUluhEmcpL7dlPHtRI+weuPBFM44Tzhwmw?=
 =?us-ascii?Q?b+QauhE3rJ59z9CBRmZwyMInRhzHE5QnlQC7V3XnezSNCvDvI7WSV6oJxIf9?=
 =?us-ascii?Q?3YAFJurTFufsrhrorSdnQ9qdj8kXGXrkiilz34GdIFS1vuWzQDAo1COgp7Qs?=
 =?us-ascii?Q?nxnkkv5Qp02LvaxfiLPc/mEaPwaEqMOimr3eLj+nUOkLlzXwFh6OwDGcuIPW?=
 =?us-ascii?Q?joplb9NIqefhmbqZImw5PQyeH0T464phWF/tWfhL6C79saZVckiqVkeKOnqD?=
 =?us-ascii?Q?fwx68rChS4rPVwPx784oF5K98XkaIvXc+VlW1uZcvRZshk/MBz+h9zeVQKbe?=
 =?us-ascii?Q?9L4jgrSHirFzzJW9ZoCxkzldys02x8LiZ8GVNujlArXk0YjnOVgp6DEBSjMf?=
 =?us-ascii?Q?Edu61esC73QBts+/PzFfZHmD/PDhte49WuENRfVimr5U2/3Y2jiGKog0QR94?=
 =?us-ascii?Q?re+3G5Dp8+8ip8KN3Hn5ln3DXWpKEm1+wE9xv4PT7tOI1eiNy2KIhIiq/tCl?=
 =?us-ascii?Q?pH5xjhLi9BJ0McYt1DsOE1moBBEgTqkx6Ua01cWUhUjOvhiiVZDZLiM31LwA?=
 =?us-ascii?Q?Dygmn9AXZ+gxBBlm7qGuNtp/qW0QiG7oG/zHdizy55K8NeRrtzp3CLKCB1F8?=
 =?us-ascii?Q?l2V/Xe9S0lLU4D6BPmhX44fLKCLB7JHs2Jz6E/1KRopMu/P9CUIogST//fau?=
 =?us-ascii?Q?nQ/qdGTvEnn9YVvXL6KQrz/NSjQ6V8HzKislrnR2kRRHX41oz7nFekta9Y8P?=
 =?us-ascii?Q?h5ENsSLxzqtwweCvjOzXsjnz3+AsKiOavVYWM/1Fwh46OOCST24b7Kobcgea?=
 =?us-ascii?Q?1dbg7GjrmXs2YYZA1mzS1pDj3VUbAMfbQlPHhN+Y/4EyYCzQPnxWHIpXIuXx?=
 =?us-ascii?Q?5avo6XMV1ehBV+ydI3uTi5Q1eLMqAvZUioVe/J8APlAOBwbQ87xw8PjrhXQq?=
 =?us-ascii?Q?e0f3VZ3c5c28HFH4VrQQd63+1pULTIQC?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2024 13:40:11.5703 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d7057e9-9c17-43f1-c18a-08dcd7e76b3c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A2.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7788
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

The firmware timeout is 2s.  Reduce the driver timeout to
2.1 seconds to avoid back pressure on queue submissions.

Fixes: 94b51a3d01ed ("drm/amdgpu/mes12: increase mes submission timeout")
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_v12_0.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
index ef05a41162306..186f778133974 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
@@ -146,7 +146,7 @@ static int mes_v12_0_submit_pkt_and_poll_completion(struct amdgpu_mes *mes,
 					    int api_status_off)
 {
 	union MESAPI__QUERY_MES_STATUS mes_status_pkt;
-	signed long timeout = 3000000; /* 3000 ms */
+	signed long timeout = 2100000; /* 2100 ms */
 	struct amdgpu_device *adev = mes->adev;
 	struct amdgpu_ring *ring = &mes->ring[pipe];
 	spinlock_t *ring_lock = &mes->ring_lock[pipe];
-- 
2.46.0

