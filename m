Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F576FF8860
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Apr 2026 16:00:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9E19410E7EB;
	Mon, 27 Apr 2026 15:59:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="zJwpjSjb";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011031.outbound.protection.outlook.com [40.107.208.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 183F310E7F5
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Apr 2026 15:59:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E9KHwBd0Dxy+Oex4W2qx762yPhG2YKvmanYza8YfLugAHJiBbs/e8Z3e8uFRZL/Ijw3BZUdy73JGZRznJW9VpgaQ7qBZECG5Wi3Yj1rVs1BD+S3vQDDaiAnS7v0iINLFn3tp3dU4d9inUaNW7U5x64B7CGEQpjOnH4WBWidZjiTQitQzvPz070Ws8a9DzLGxLnEMe3unkIbr5PjyXH8A88qe4ZDXKcBLuXc5SSP+djAhCqSFtLn69svI/sZcsLUt9EC3Xkry/6cLJAjDeQ/2F2sv9Kq/JkBXObfwKPxZY6rPsXef3wVEkIWEUnafpwJaYXcA2g5YXLvJlTgw342hqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oZTCpZ7AkPfmjFy6DijV0/GJogf/WXDZFvxDgcQD3pY=;
 b=GvSgSKLqhPgbD5YPeC+tl2fUpEwlqYffjrKXeDtemO8wudOixnKrYKbRTCg5vNeEHSkCKHVAxIDhiQoWchu5ufe32+0LPKMISo5XlO9JknYfvhh9P4Ov19bYVvTAOAtiQQlzk9FTCwimiSMPhGMoXyA8X2ZLTHm1CnZpf+7j7YG35QZnKRB14xEspBZsVo0jXFri/A73YAaL9tHzAwe34RFm3d3zVOHVdBOn44Mzohok2gZFvaBRN9WWenRWgUuEJJOrxSGMvEZrgPByY5B1kVyG3qmkZnLGW2HqvURzIYemvfzKAsYu94GwWfrE1zWRRaZcj+mpB8nrK45sVH25Pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oZTCpZ7AkPfmjFy6DijV0/GJogf/WXDZFvxDgcQD3pY=;
 b=zJwpjSjbD6NEcFIMRCYQzALqRbfKTmwMwlVw3DIPC0cvRneXiRPo56ZVL5QftaTj31sRFQjMtfrA6cvJ8vZu6cYLTVPYmUQMA2p/A8mLBtundlAzHibrJjsUGUfEIS0lRCzvbSrCyTAghU55v9ZdgCsRXKhEZZ7tQlKLTX3wC58=
Received: from MN2PR20CA0055.namprd20.prod.outlook.com (2603:10b6:208:235::24)
 by MN0PR12MB5788.namprd12.prod.outlook.com (2603:10b6:208:377::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.16; Mon, 27 Apr
 2026 15:59:50 +0000
Received: from BN3PEPF0000B070.namprd21.prod.outlook.com
 (2603:10b6:208:235:cafe::c6) by MN2PR20CA0055.outlook.office365.com
 (2603:10b6:208:235::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.26 via Frontend Transport; Mon,
 27 Apr 2026 15:59:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B070.mail.protection.outlook.com (10.167.243.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.0 via Frontend Transport; Mon, 27 Apr 2026 15:59:50 +0000
Received: from yinjiyao-dev24.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 27 Apr
 2026 10:59:49 -0500
From: Yinjie Yao <yinjie.yao@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <christian.koenig@amd.com>, <alexander.deucher@amd.com>,
 <leo.liu@amd.com>, <ruijing.dong@amd.com>, Yinjie Yao <yinjie.yao@amd.com>
Subject: [PATCH v2 08/19] drm/amdgpu/vcn: set no_user_fence for VCN v5.0.1 enc
 ring
Date: Mon, 27 Apr 2026 11:58:46 -0400
Message-ID: <20260427155857.1370151-8-yinjie.yao@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260427155857.1370151-1-yinjie.yao@amd.com>
References: <CADnq5_MPJG=S+B4kg6v64xD+8pDEbG5z1Q7j-2A+CfStmuejTg@mail.gmail.com>
 <20260427155857.1370151-1-yinjie.yao@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B070:EE_|MN0PR12MB5788:EE_
X-MS-Office365-Filtering-Correlation-Id: 7bc8b44f-249f-44cd-f2d1-08dea4760383
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|1800799024|82310400026|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: AX9f+EV6lAuJwkasBJXAnbIvwsbFJ8chQ9/eJsbYZlIX+XZTjrEciZWYRyQ3D1nfoKz/q+p85mZnj93npKak05fvBldE40SVC7aG3ajjVb3sR+wgHVAbCIg57PtWYUJXDXAEbGUe2Riz6wuNeA+9Zc1uIXV7l3YCanRKby4eBA/DinFVHls14GUkVF5npK15yE9oxLdXX1eXddbakNXvPd8LXK3pzLx/CMhQCwyahxKF38yutewFd2mIN3jhZRxRNWY1dUqYR4Qh7rA35/ZkuerYH4qD/vDl94W+SkbAlqb8EcvZdwjXLbiDO8IJjNKM2YxvpdwuVsHWvCtHBHnNK/7WFTNKs6fSneTVI0/WjNH17Kc9hoxfcou2ajsY7kpQ67WDmO6Q6O1Zrq7JyK+Xyfa6WLB9GsVA0KouMCb6V/8i5b5AaupRjswkzwFVmEgDcie1GYTvTXIZw/qzW6HQfMUHm2nnpCp3ZhQjOlFQGoy31yS/XpJLAgZACOVRoLN/IyOeF4hnAb5Oi/yACadC/UGEMvDkJ3hrlpnv8e8qsx5wE6l4Mw4AvxE0A3+YSYyQMnltDgxcoePkmmq0k97C2WA9cBWNBZWSCnEpCj7OksGQqmbGPwU9mkso5qWfdkDg800WB01/fRHmNq0PpUZoaZhGgPOWR7wOHny6fJZJ40OSf0QQPhoQ1dI8tX0LU+vjV+VP7EYNhElEgzEjCwXpaqgCYQuOffIBdEwaoPWkisK3euhN8LJxki60FekoY4sYZ9KP8GrDtca2bscPUOLtaQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(1800799024)(82310400026)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: UDxGpvH2V+YJSgYlLmRPR7vdSapPIrHh3eKelENj2AhbxiLQ8JKblVvXw2ngRLnB0rG7oXpdDF5WqNAGtJe6DU2iVf/03009wc1v4rz1LaY4VJ9UE4u4gW7F2zTg6C+7DfXhK0ZEXIz+UWl8uJUI4x1xopZ3SaRmjCHt/vez7xvVg3MS1/gWdWBYkq+XLOd+tbe2jakYmsuGe2ujboWxbRsOWrC8+D9vIZnFhx0u5/9Okj0zncxeSCHY5qr5rs3KFud+G2ITERKgFLGBA6ARjjKtJgFkBMbgxK4q5hhZ8zAFDpg7N1TBfJLCjhTtq1LsqyJSEacX5vsWJGHdOIAbClAK/VsEq4Bsv+rFaOdR6rhrcx7UFRLcCZ+6jTl4aU9QGPNWQK7xIqDmM98ypY+lCBb06juhICgp8Tp/D+vziebXRF8aR6tqn7iwINEpQeRd
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2026 15:59:50.4834 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bc8b44f-249f-44cd-f2d1-08dea4760383
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B070.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5788
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

VCN encoder and decoder rings do not support 64-bit user fence writes,
reject CS submissions with user fences.

Fixes: 346492f30ce3 ("drm/amdgpu: Add VCN_5_0_1 support")
Reviewed-by: Christian König <christian.koenig@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Yinjie Yao <yinjie.yao@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
index c28c6aff17aa..54fbf8d73ca6 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
@@ -1419,6 +1419,7 @@ static const struct amdgpu_ring_funcs vcn_v5_0_1_unified_ring_vm_funcs = {
 	.type = AMDGPU_RING_TYPE_VCN_ENC,
 	.align_mask = 0x3f,
 	.nop = VCN_ENC_CMD_NO_OP,
+	.no_user_fence = true,
 	.get_rptr = vcn_v5_0_1_unified_ring_get_rptr,
 	.get_wptr = vcn_v5_0_1_unified_ring_get_wptr,
 	.set_wptr = vcn_v5_0_1_unified_ring_set_wptr,
-- 
2.43.0

