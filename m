Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BB87E8783D
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Feb 2026 15:13:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D1F5F10E1AA;
	Tue,  3 Feb 2026 15:13:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="l0m7tyGu";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010016.outbound.protection.outlook.com [52.101.56.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6A2B110E1AA
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Feb 2026 15:13:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o5xpp9sMIjUehHsvX55P9eK5LC55BlG3eSn3k6NyRkk5jBJbxaJdXMhTTw4BD6jsI1C1FqhGO3PYiex3qlDUkTyOOoCd8OOY1uWuUjKY4onDnLicj4dxoEWVag93UUUriZkyLB0UIq1xwn8x5dfJ5BAGpqjwuWb+ftUuw1dvfy9Ccg9NpAdGJWV3aYmI48V19ZOLxuk35QsbqbEEDraryQI8Hlgm65hGpwDSn7m19fFsZ3CxG9wpRFn8UU/4EDiPcLrQKfWDnE+3YbsnLB3Taj4Dx9tP3Y7Hb3e5AhmPDgEAqkAuS8fxUEMtPPivLBoJTpuuVtjPnMj9OtB7eiD6Yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=06FikvJtkT+BRU8chCDcnzcQlaF7+BJXbUGT3vKFTd8=;
 b=oenK8lgk1JK/ynolCF1Ydk2YDAP/nhbNKLFHm80juBpKSDi8INQ5GgL6tc7G3un+UcOs+ueh4M9E1LCZt0U/6vjinfnLUgefwM2r/KD5LFfxE9B2Ao9OMUt02aekVW20iPsPDiB9qNjpiavM+dprhvtZEmML2GRBOsDcHUALmRQSSMbLDnTJrGqiJuvIKXp+x85nv3Bl9FBtYInV1gvQFzqnDR5cwN1p3z/FRJdkctNPmCgigM9F6C3JfDJY50RqXDCtWMdRwxqFYVcBKLsctkA6AxuJV2YFRo0N/OxQOLCq9leXAjH/+0XOlgzH2m2F4ZLsPNKYOb0yHvW4Z10tEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=06FikvJtkT+BRU8chCDcnzcQlaF7+BJXbUGT3vKFTd8=;
 b=l0m7tyGurZFwvRutfREJRyTayczK8KXa0J+UNrPvvjX/GAfVXt75ahuJ+OFRLKbIRQL0k73/MoEr/IfIN6j4kC2FstGW64JqVFYCjeRzwUFLrwzM8V/JruukjhGEF8b3/FtZI+HrDObcfovogsND58R117W/oczYOnHKn0AppvQ=
Received: from BN0PR04CA0100.namprd04.prod.outlook.com (2603:10b6:408:ec::15)
 by SJ1PR12MB6074.namprd12.prod.outlook.com (2603:10b6:a03:45f::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Tue, 3 Feb
 2026 15:12:59 +0000
Received: from BN1PEPF00004689.namprd05.prod.outlook.com
 (2603:10b6:408:ec:cafe::fa) by BN0PR04CA0100.outlook.office365.com
 (2603:10b6:408:ec::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.12 via Frontend Transport; Tue,
 3 Feb 2026 15:12:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN1PEPF00004689.mail.protection.outlook.com (10.167.243.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Tue, 3 Feb 2026 15:12:58 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 3 Feb
 2026 09:12:57 -0600
Received: from tom-r5.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 3 Feb 2026 07:12:49 -0800
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Wayne Lin <Wayne.Lin@amd.com>
Subject: [PATCH 01/16] drm/amd/display: Avoid updating surface with the same
 surface under MPO
Date: Tue, 3 Feb 2026 23:01:43 +0800
Message-ID: <20260203151229.3673042-2-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260203151229.3673042-1-chiahsuan.chung@amd.com>
References: <20260203151229.3673042-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004689:EE_|SJ1PR12MB6074:EE_
X-MS-Office365-Filtering-Correlation-Id: a2db73fd-7780-4a66-bdee-08de6336b6f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?dN/5njWiw3Lns6P6xgI3UR19GOqK98Kxgj5ilurO1n4n3jaITNVnMHqPQtGJ?=
 =?us-ascii?Q?+mmoKLVnUQkHQMEN/eI3tAah4m6/NjWGYz4upEyoa1TBuI5ZDjqp3XwQM8hL?=
 =?us-ascii?Q?QMqz6C7gikhRCXT27x23Zx8M24gZjDmwfzSPKZkJCbOhv3yaAUtK9XoHEF74?=
 =?us-ascii?Q?XaNWef8vKU38hT9KMpEBR2WqP2nh7wkwmo7YsSYL5H1tO3X4c1WpOdY/J3Rt?=
 =?us-ascii?Q?a1IdgesRpMuOIlbNObH6R/8CEUXlyZQe58DaE+nzBfNUltS7y6IbCOq8PhQD?=
 =?us-ascii?Q?fQ0opv+kNZMboT34YcLLohlsxe9JN2DP+WoZfqoPFA3gUp9T0grysf4s42rT?=
 =?us-ascii?Q?TOU3vy66seHpMtw4eD2M3ToGpE4HYsDnVOCaqC316aKJSjqMtjrUoBCgkaD+?=
 =?us-ascii?Q?CUZrEXQdJnW1h0yR8gQkbwJEAIDidb+MwzIoHHvf15xqxKb+Y4cRY+TYC+5w?=
 =?us-ascii?Q?KcN3Qc3lNuNfL3awN70MB/xVslOkbpIZ5DwX/nZlCkg60PFJiNNL3TodBH0H?=
 =?us-ascii?Q?PRo39UVzcFOQKYz6Sdo7OqfryULZQNqMowCZ7pCdoR7eWwNmSNgppaXhQ3bM?=
 =?us-ascii?Q?cHkfBW7GAw3YrQgvlyj7kXfHf2aJC6w1MEI9LRa6tOxpzrBZYoSOBLsiPleR?=
 =?us-ascii?Q?LRJZ4BichLn/lLIVKQdsiqhJvWM6iNbtizCAdL0V61Dfi/RlGdZuli5MP0dV?=
 =?us-ascii?Q?vg0mk7sT7CjwZRn/h/BDpT/MUbakt2PtCGId0287Ol/ZPH9vEaiIXAfww4HP?=
 =?us-ascii?Q?0HSu+3Bha6v0In3NyYm1qu1h8OV02GRSwApkx9DhNnfPbvaDwjLTXoXdySb6?=
 =?us-ascii?Q?ilHCsYWDa9EsDbfbBUEe4fX/cGDtGfxhukgt6PMrfSCJe7nr/h9SB0rVZ4vI?=
 =?us-ascii?Q?vJ7Rj5ww2L0qdkGdLly7Tq/trfPf8iEgT5VhLIE4o7D0x6DOPq2AE7IVIPb9?=
 =?us-ascii?Q?s+FtvA9xI57lJpSM56PJZF1EofvDCJQ0n85sgzRwgJyybePHnSys9Uw31YqR?=
 =?us-ascii?Q?4nDX7MKhWzX4RKD2PBsx1NJep760hxELRhVUgi+1VMnU4qc+mCwPwM4lzBGt?=
 =?us-ascii?Q?R26YONRM/OKZRhLUpe2rgiEg+Ffk9P1JTsyhXKb9diTSXfP8WMTrj1KrUsra?=
 =?us-ascii?Q?anjr5IxRlUqBzzrAwUVBJmnOMOhwHEssaExvwnJyY0LqDbDNTg5fIpbRQW2g?=
 =?us-ascii?Q?7h+EPPgvBRSo7HbNsS0E4nOR4VdsUiy/zFE/g4T9IcLWS4m97ORk9WWZH7kF?=
 =?us-ascii?Q?rt5TW4bviPUG+hXkax3Pn3ZPV6Ruh1Dm0m16p3zpF8v2UZ/RumCw3bba1Fgo?=
 =?us-ascii?Q?eP00s+SrNafl6ZDInkUbbBfwSARoWIPXB47nSwEzqerE+dh2RswKdy6FPy/r?=
 =?us-ascii?Q?N4BgZhXKZS+s87vqsIJz/YJ0u+le7Qa/vBSIFE02TMr/iRewNdncwzzk2KGE?=
 =?us-ascii?Q?Um4j+Pe/cU4gyiakmejR+X4dzSKCuteQh0O1Gr8ulDMU6XQvf4LTZ8ljOypP?=
 =?us-ascii?Q?SApaMsRANNkg1JNkrGYEPnjLaRcINoXMV8PKR+nMlQndA5q+UjEqrK4TdQhW?=
 =?us-ascii?Q?MI42k1/TzykicQxjqe0WHNGBSiwMslLfWn5lMR1dZRdMvCLAn+CR6Guip4AG?=
 =?us-ascii?Q?c4W8C7SGe3tyHCt5sIGv3LpKMQ7dK/lLJpD+A2IiANcizHKLVDG4l9b6dlFz?=
 =?us-ascii?Q?5ZHNOA=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ywaDbTV1qp5Ox2N3KacpivtqaWGVaePBlQf45vmzVPnVpmVYvvhxP9fLU4aHCgpFs+PyWc/P9trAjLR1biV4mqsAuktzFEGqI7ljGqmwX+LEDBayYewE+8/wUzOBUGSlqaWP18W8w0GVJ7XS0WekG5/xQh/GorPLG+hmxuF9pSSpjsV+n6Tr5Iz+k07rD+7G0XL7Dha9X0EDrcQ3weeLkNR1NEr9a6a9zLUqMXnX+g9Dv6Wfr5DRlTEJADavxHmv0tUUGZ1E+/FkXGmdDA7kNLR/jDpDoNNn19l37z0V2TrA0ai4wtJWQyA3L9Gap9jmMS17ezuEWY9KGxkZwnvSrtiMnYPp5W02O4SdA0bZeY5NqZWltejZQx5/MSCx7l7F2eQXcUFtWPNGd2+YQbheoRumYAVncz3n+xQ+pmbHs9ee61sVEij6dUO9am5iDTtG
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2026 15:12:58.1574 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a2db73fd-7780-4a66-bdee-08de6336b6f3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00004689.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6074
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

From: Wayne Lin <Wayne.Lin@amd.com>

[Why & How]
Although it's dummy updates of surface update for committing stream
updates, we should not have dummy_updates[j].surface all indicating
to the same surface under multiple surfaces case. Otherwise,
copy_surface_update_to_plane() in update_planes_and_stream_state()
will update to the same surface only.

Reviewed-by: Harry Wentland <harry.wentland@amd.com>
Signed-off-by: Wayne Lin <Wayne.Lin@amd.com>
Signed-off-by: Tom Chung <chiahsuan.chung@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 00375d208ff9..b9e8ea4396b5 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -10960,7 +10960,7 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_state *state)
 			continue;
 		}
 		for (j = 0; j < status->plane_count; j++)
-			dummy_updates[j].surface = status->plane_states[0];
+			dummy_updates[j].surface = status->plane_states[j];
 
 		sort(dummy_updates, status->plane_count,
 		     sizeof(*dummy_updates), dm_plane_layer_index_cmp, NULL);
-- 
2.43.0

