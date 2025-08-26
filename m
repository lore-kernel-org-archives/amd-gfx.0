Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17F5CCA0EFA
	for <amd-gfx@archiver.kernel.org>; Tue, 26 Aug 2025 07:47:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A41C810E5F9;
	Tue, 26 Aug 2025 07:47:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="yXHgODDF";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2062.outbound.protection.outlook.com [40.107.223.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5F01610E5F6
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 Aug 2025 07:47:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r9jquCHNE9pT6nqvF1VH3CXnk2XuYEobJWsBVhdoSr+gE/VjXSvHsQ9WmQBf9vli+wj8o28wsu5BC257RRFgfZOSN52CD+nH76iktyzGIvWTnF34ELUCEHO0Rfl2qCh0JWSs2XblGC1u+62swZUk9jhbIgKX16ySUFYgorr6MElkF0mxvWN+GQFOufUXvn6Q6KMCBJ3/40LuKbpHRGfxA48BCJ81x6u0K/VcuMzJo3ym3Y8x6HlBAH3++4c62oqK4KTFpC9yJ19MZ0KrqabWZOWp8CRiWrb01bRe8R+WjhXAvL32QqMRzqlBW2mRTzV98C4fvO2y6fvW2Tifi7UXkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LpHgvVe78MBTs1ZWTswpQTGHqv463fbJaRTpw2s2IvI=;
 b=Gp0UqJWSPISLG1twqH/BU2N5oXRhQVvn5i7AIqQFuB4VQUBAb0M7ziUZ1R/pyR+QUcgwbjCK+ibDScTNYoJQc27rvxJ6cF8DArcyWfilPl2yb21rdRFzgOp5YPOPJzw4yVTnFhsGeDZNP0j7RXbv2QZ7jHAY0J/WSojMYHfSJrsNxsDEfi687rC1aWnQWAyIXBheLTyBPdJNi2+AWSDLdNocqHB46wDZC2yjajbvcfcRe+q/IKJFaIYRD+5tlOBlTraEC5SVkqXq8C6rMn4sGnQ693NvGn1ii+fNa396eEbvUlMX0ePsFa7Db0oCF9rWvcIAxqJ84pzwpgQQSeRp5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LpHgvVe78MBTs1ZWTswpQTGHqv463fbJaRTpw2s2IvI=;
 b=yXHgODDFADWV+AWCbcQvNJly3y4RMTSNNKlpfXAVQnLvHVZZ4Y/+ict6wh1KRtlr9GHCnmvnY8aPYdvDgEynOGVTZEW8OX62x/LZB1euHE6C8VefXq5eUNdO6TV98FHCa42L99uFpjwYGBUOzZ4DWTYSwQ+s8gDuXwaDSzjlvk8=
Received: from MN0PR03CA0026.namprd03.prod.outlook.com (2603:10b6:208:52f::23)
 by MN2PR12MB4222.namprd12.prod.outlook.com (2603:10b6:208:19a::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.20; Tue, 26 Aug
 2025 07:47:14 +0000
Received: from BL6PEPF00022575.namprd02.prod.outlook.com
 (2603:10b6:208:52f:cafe::c3) by MN0PR03CA0026.outlook.office365.com
 (2603:10b6:208:52f::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.21 via Frontend Transport; Tue,
 26 Aug 2025 07:47:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00022575.mail.protection.outlook.com (10.167.249.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9052.8 via Frontend Transport; Tue, 26 Aug 2025 07:47:13 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 26 Aug
 2025 02:47:11 -0500
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>, Prike Liang
 <Prike.Liang@amd.com>
Subject: [PATCH v9 10/14] drm/amdgpu: validate the userq va before destroying
Date: Tue, 26 Aug 2025 15:46:42 +0800
Message-ID: <20250826074646.1775241-10-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250826074646.1775241-1-Prike.Liang@amd.com>
References: <20250826074646.1775241-1-Prike.Liang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00022575:EE_|MN2PR12MB4222:EE_
X-MS-Office365-Filtering-Correlation-Id: f523aae8-6033-416a-910e-08dde474c5a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?grzf4gAq3QV8BjqteFbAAu/qtzJx1n4qqQhS6pdxy3eO7H9EkEet8Pp8Snyl?=
 =?us-ascii?Q?Ild1XQ1w9Foz03nP0woN5sfa+oD3F7Lz9IunHEu804mQBMB4OZN2V+xuQi2D?=
 =?us-ascii?Q?ZdjNslS5tsccqn8OukI8It+myBtOR54bBwGpdRUtvgd1qa9G7gqBnOPORRaS?=
 =?us-ascii?Q?j6g2B3V0Cpnff3Vj2iBY3BPJFwg1sh+aUaAD3DvCBKCciRxoxr/OqJhvnmlc?=
 =?us-ascii?Q?nkgViv8ItD3ZQP+6eLD+RWxpiyoyV4OP/OPHt2vVqqzSGgukAdAWQfeDpJlG?=
 =?us-ascii?Q?X0w47rwIppj87nwDtXaVYwdMsUxRSVLRdF5SauO+j38BD0TVX95oita5PM/y?=
 =?us-ascii?Q?CJDxoTuw9oOz2X7rdCCGOdZyMNz+s4vA14qK7oypQE2HK97YMeTEYOz6TKwY?=
 =?us-ascii?Q?iXYkdw+KOyz2Mv2JymGb7EgPs9yZ+4pYGeQpvbmZ1t+rYq+8u3phlmSe/Qir?=
 =?us-ascii?Q?uD4FBlnsMArY1v3RiEkoM/0t7ozZGr2XluLYVT3RGVmTy3aHj93vlSHYbmgz?=
 =?us-ascii?Q?8MaRT6dPvXFTPp6DcRL24cyYyaj6sDtIhclimh6NNhRokkHTNg/jY2olnDOB?=
 =?us-ascii?Q?GtMU5ksJ87YUjConJ7iWk5mybKJ6NnKbudIWZT4Uw52F2V2s8+fv9WCNq+aD?=
 =?us-ascii?Q?wg98gx5kID0s4mUuboBPNZZzAkNGjFd+S2YDmy9I9nV1beYjwAjA+cKbPLLu?=
 =?us-ascii?Q?8Vj2Qwh1Y+gQmERQ/68a9Dh9MKBGA6Or6nQUXiDFj0lHhzqTWG8yRLOHeUQG?=
 =?us-ascii?Q?+07a8/hYapTVH/cG640ykqyjIMpLWlEKPYZ//xqBEYKY4EDsRBXRK6BGvtL0?=
 =?us-ascii?Q?lXVTKxjqjxwBvZf2D9+P1H27ZwKOmw4mVBGGmxrMqbT7P5xLinS35JH+6miH?=
 =?us-ascii?Q?CjNAQXYtfIkWFxpmncXh+l945XQgFmByLlHDzJrnimiYf7vaOIcHTicRaIYd?=
 =?us-ascii?Q?VCOynz/Fxk6phgEGTt6aOr+b4gz4ogIe/SpskedWkMkxYyNgmq9+945a4A4w?=
 =?us-ascii?Q?SkG/poAY+R0G6eJiOcnLwm8oYk29M4NlD5va10877FM+acOgBs8dHVPRl0Eq?=
 =?us-ascii?Q?jmoQX+o69L4XKupWqtmk1BHKg6HEczfSMiZIcYC0BSx3ihBYwStyh2WfJmW+?=
 =?us-ascii?Q?8Xbompxu72YyMI3zcAdCZkA1Ct+eOTix3lmk2Rqp8E4I+lTiuVNbhJDnmdy2?=
 =?us-ascii?Q?nWGSkP6tKbO+QpWbGh6kXCnO6YYsRaQWHJkfgLq6Re8rBiRJlvJFKfmvjYCt?=
 =?us-ascii?Q?24si82nhHrHQ0rZczbz6KQoiLJSAK09h3VCrf5YHW6bkg3VrW2bBmTVmzXwa?=
 =?us-ascii?Q?v4USTs1EN3IARjrn83xGV58AwSRyyUjTfS+RV1KeTYk5mF/3/zwVo7XkNd43?=
 =?us-ascii?Q?WS4GmtoXcnMepPFxYtha32BxJasaBAZPQ2rm61NtopvNE11f9VaC0ZyFInGq?=
 =?us-ascii?Q?S7ziIyxaWzi+r7nCUp91g+Q70o2iq1h8LiSRqmV0kKp+Yr7OQh8taZdEgIaB?=
 =?us-ascii?Q?61SNnJRe/1H1LcOT7iFXxSE9G1IJPo9g1cki?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2025 07:47:13.9474 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f523aae8-6033-416a-910e-08dde474c5a7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00022575.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4222
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

The user queue object destroy requires ensuring its
VA keeps mapping prior to the queue being destroyed.
Otherwise, it seems a bug in the user space or VA
freed wrongly, and the kernel driver should report an
invalidated state to the user IOCTL request.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 6cdfeb224f6c..e5891674b4d0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -520,6 +520,13 @@ amdgpu_userq_destroy(struct drm_file *filp, int queue_id)
 		amdgpu_bo_unreserve(queue->db_obj.obj);
 	}
 	amdgpu_bo_unref(&queue->db_obj.obj);
+	/*
+	 * At this point the userq obj va should be mapped,
+	 * otherwise will return error to user.
+	 */
+	if (!amdgpu_userq_buffer_vas_mapped(&fpriv->vm, queue))
+		queue->state = AMDGPU_USERQ_STATE_INVALID_VA;
+
 	r = amdgpu_userq_unmap_helper(uq_mgr, queue);
 	/*TODO: It requires a reset for userq hw unmap error*/
 	if (unlikely(r != AMDGPU_USERQ_STATE_UNMAPPED)) {
-- 
2.34.1

