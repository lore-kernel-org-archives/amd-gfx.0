Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7A12C25B78
	for <amd-gfx@archiver.kernel.org>; Thu, 16 May 2024 19:27:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4B03710EDB9;
	Thu, 16 May 2024 19:27:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="hTFlWYSv";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2040.outbound.protection.outlook.com [40.107.237.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EE05610EDA2
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 May 2024 19:27:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I7yGN61ZbT6ndkeK/vKnra0NiphfWCCLGeJsVdOJs4QSqbHaF5oIrYGkQBX4omDO+S59ULn5dcnGoGwogCwCys2htuHRCpvOzcSQKi6hrrBAplgoiLeWLBkJeRM9GMSUMXH1ewBT5CXFm7sOFFxTPzAOyF3f+onR1s+1wR2tWYsG8F32mvHvsnCjmNCrupvHe6PVX1WBqnwkPLHhDGFARDLXBv56f0R1ZJHkV9fPRIFLnuSOYXNyBwAy3+MYJBxUaFKtC6R5IyXM2qfNFlXHQh+oog1yRlOc/JsZibWI4kE4qFRrVe4T3epvuaKELYksTGrF5JfB95/4EKJRgRJKZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oUQZwFT3fCzLHQrdIQ4LpHdqZ/LdKiAAcu2B+WGlG0M=;
 b=axvB0TGvqEToKTIloC03e/16iGWXObVETTP2Av9BIMpU44257PGQvYkRogVL3QCmmQR3aYpkNkWtwG4gqZQZJVcprFuEjWoCWyMztTL4GcATyUT3xbh6JBdBdzQkmHHe6OQvF+CSkw00hS19p5+U6cMn2ju2PTm6V2qZj+B0v6qcLusIsF3YJ+6GPqLiuz8nORBZN5NIDSp7h5XvuEVRVgrOf3gVaoYiMV1IVVbT0G/95re2od6SruIwdD8Df5+gRc+GXybxQ5hqdFoYUXG1e/zYtiR6btpSQP9a+oBRbjX31jl2i0Kw6RR7nCQtu47chu+QXnEGkFQYXm6/HQ6D8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oUQZwFT3fCzLHQrdIQ4LpHdqZ/LdKiAAcu2B+WGlG0M=;
 b=hTFlWYSv6O5TF5T0KavPwOAwf+eK5NhvMj2oyvgl+LvVqNv/ooZ+lVeA/MBep66RnoeKGvm+gH06NKb66iIoICUh9pw+tNU7DBe0qnuJqi8ykckW1wL542A19hyTlddd8hHGovnV6a5nLiAxislfLan5Xqj8pErbLHfpMAVdCgo=
Received: from BN9PR03CA0247.namprd03.prod.outlook.com (2603:10b6:408:ff::12)
 by IA0PR12MB8088.namprd12.prod.outlook.com (2603:10b6:208:409::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.26; Thu, 16 May
 2024 19:27:07 +0000
Received: from BN2PEPF000044A7.namprd04.prod.outlook.com
 (2603:10b6:408:ff:cafe::4d) by BN9PR03CA0247.outlook.office365.com
 (2603:10b6:408:ff::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.28 via Frontend
 Transport; Thu, 16 May 2024 19:27:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000044A7.mail.protection.outlook.com (10.167.243.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7587.21 via Frontend Transport; Thu, 16 May 2024 19:27:07 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 16 May
 2024 14:27:05 -0500
Received: from roman-vdev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Thu, 16 May 2024 14:27:04 -0500
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, Nicholas Susanto <nicholas.susanto@amd.com>, "Nicholas
 Kazlauskas" <nicholas.kazlauskas@amd.com>
Subject: [PATCH 16/24] drm/amd/display: Fix pipe addition logic in
 calc_blocks_to_ungate DCN35
Date: Thu, 16 May 2024 15:26:39 -0400
Message-ID: <20240516192647.1522729-17-Roman.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240516192647.1522729-1-Roman.Li@amd.com>
References: <20240516192647.1522729-1-Roman.Li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: Roman.Li@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A7:EE_|IA0PR12MB8088:EE_
X-MS-Office365-Filtering-Correlation-Id: e7b741b7-1156-4213-42d7-08dc75de2ce8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|82310400017|1800799015|376005|36860700004; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?qW1CiwoJefD4P2Lnjbt37oUZdozs+SNDt4gHQ9RS0LBeuvoOUKon5GK2zPYk?=
 =?us-ascii?Q?aIX9WOSkLj7N+UmT2COGouR2ClwocqGlaXGa5i42EgFvzRB/I9+DBouuOEAw?=
 =?us-ascii?Q?RZu7cEtnpMhZKJMQVlE+TkiqE0nu8zh0/P5paB5jHvk8bmOyaazuS6IsHNV1?=
 =?us-ascii?Q?X1KSQx6n5Sj8MhdBvDgCtkj+qJvWfHT2RNgZXd0oUbO7I38mLVIymytOFJBo?=
 =?us-ascii?Q?FKrrKb9Ne4Tx92qPcr5Ruwo3xxsaglhPw340V5YCuUsp6izAw22L10y0mPGC?=
 =?us-ascii?Q?5O+GC9zaZ6BxGxUPpDLbJhCBInh0rdqdINglWkgLQ72GK1azfhyiTNgN5ZJH?=
 =?us-ascii?Q?1oOVqdIruM7UhoyVEbFmKKXIHc7Ho4x6htTc7Ovt18N8Sd5fNkQazvfo2efO?=
 =?us-ascii?Q?webPlaSGZyJPThQIeE628wE5YReBjlOM+8otiWIS2abojKTAuTCP8Jg5vFa/?=
 =?us-ascii?Q?Do3B6PfJhOweo41RnBy029F3E72I0CPRKz5iRlNrzpicik2v5h7t3gl74EKd?=
 =?us-ascii?Q?3j5eMr5Vy5vMmPde2UsJj+UP7cD+ZDww9W84YGl1ZUIvC1/z8tMafgcSMGXp?=
 =?us-ascii?Q?66MhWLWAikiAsApEI+1nzYQl03CQbN2sugv+4spZE/r/Di/2MqwYvthJmRqt?=
 =?us-ascii?Q?iWYCGRLrubBxWnVRzL3sd95nZxvKBLhygn91kIYX79lXcZROZx7euOol9BYd?=
 =?us-ascii?Q?aUWDzaRVs1mSFn+qZOzM/loClyj1q57KVX5yWYvdlXEj6WEFSBCjLs3Dkhrw?=
 =?us-ascii?Q?TXmVVsm1yBSEsSKDBk/Xan1oaLVAqxi44D1LpMOrlhgr8O2mrFHO7zrtupvn?=
 =?us-ascii?Q?T0MPENG3fNsXfm300mBPQURTKhLmk2/HPLHMekV9iNhsSESyBoq39TNXcbGo?=
 =?us-ascii?Q?6tFkAvPRlAEGvoaorw+8DYi1AY2UsHAQACBD4U3vOgr9T7trosoZ4vCZlkx/?=
 =?us-ascii?Q?D59J+qukf0G/6h6+KgH2hW2DjuTllERWKE4MtGc9Tz9ZpPzk5sduDaoK1oe4?=
 =?us-ascii?Q?PdWdF9rluOu0UYSauksHKeIqzQmYCg4I0NMy+J4SM4j7BUx8jW4KryO2RajO?=
 =?us-ascii?Q?5pVF/u690EjAKIFRAu8/nL7BrY0pzPpxeQ0X0xndXBfhTpS5+Ap9DBr7udIZ?=
 =?us-ascii?Q?/sHyi5Zq+LHRTu/KG3R1rPu06vxsZz5Fn9PbOvClFF092CZEVHkw693eXSWU?=
 =?us-ascii?Q?Crr88FtjHL5ZmTKwfgJHvRpQnQ+OE3Xfb+/6zwbywfA1QeZ0PD6OecLn3sDl?=
 =?us-ascii?Q?El4IXHnWW7zCY7weZXi+Pnx2SZ7zdOk8VxZjIrkq+FyHOgPFgS/WGUmwnQOK?=
 =?us-ascii?Q?0w8EMDBg0ZkpqgEiIBhVwJotOmGoCk+iMEKEUXWounxhVVTMekT+bORsSiwK?=
 =?us-ascii?Q?bmHL4P+W4c7dUYGtVQYJRlDy1apR?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400017)(1800799015)(376005)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2024 19:27:07.2782 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e7b741b7-1156-4213-42d7-08dc75de2ce8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A7.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8088
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

From: Nicholas Susanto <nicholas.susanto@amd.com>

[Why]

Missing check for when there is new pipe configuration but both cur_pipe
and new_pipe are both populated causing update_state of DSC for that
instance not being updated correctly.

This causes some display mode changes to cause underflow since DSCCLK
is still gated when the display requires DSC.

[How]

Added another condition in the new pipe addition branch that checks if
there is a new pipe configuration and if it is not the same as cur_pipe.
cur_pipe does not necessarily have to be NULL to go in this branch.

Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Acked-by: Roman Li <roman.li@amd.com>
Signed-off-by: Nicholas Susanto <nicholas.susanto@amd.com>
---
 drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
index 6d40e93b5497..2b3ba5971c69 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
@@ -1097,7 +1097,8 @@ void dcn35_calc_blocks_to_ungate(struct dc *dc, struct dc_state *context,
 			continue;
 
 		if ((!cur_pipe->plane_state && new_pipe->plane_state) ||
-			(!cur_pipe->stream && new_pipe->stream)) {
+			(!cur_pipe->stream && new_pipe->stream) ||
+			(cur_pipe->stream != new_pipe->stream && new_pipe->stream)) {
 			// New pipe addition
 			for (j = 0; j < PG_HW_PIPE_RESOURCES_NUM_ELEMENT; j++) {
 				if (j == PG_HUBP && new_pipe->plane_res.hubp)
-- 
2.34.1

