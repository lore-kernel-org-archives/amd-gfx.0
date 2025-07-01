Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68F95C7EE30
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Jul 2025 18:45:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 56DB810E633;
	Tue,  1 Jul 2025 18:45:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="N9+78zzx";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2081.outbound.protection.outlook.com [40.107.100.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E668110E627
 for <amd-gfx@lists.freedesktop.org>; Tue,  1 Jul 2025 18:45:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vGeMvWPOqp1ESP9e5vHNDYFZYyAVJSEmgbHQPUtYFGVoYUwrQ+b6JHyHp71KG6o52nTqX7Fuy3LZUti/88iNs/fpeVIY0/SRzXxYGNIAJJV2DkiT8Ci5il5eqOYdVZRhTUefb/2d1tWS8GxmRNd4Mhx0eb1S/+W9zyFErvrn/ozRpyA3OGLIn2CP/bplUbZ0+xqj6MinxSTXhbiBWMjIaiEmaZzR2502J6xk1LqCODFZ4E1loXTx9cfslGjj+hIOexamP2ZL7JJ9wSTsMPeDkpvJmv18rs0rDy26ciFJ788JJc7qG2jXPRRZcogFSyZt6yPcKo7XG9C3zPeU69reYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WXVpr+TQTOc/CNdusWJlMee9AgPICcF+8373axFJcM4=;
 b=K86uxMzWIKyE23xnY7VHWXaCeYFSpmd8cevl/Jk7Ojn2Qf2ot95KGUbSAoRq7hMTzLbnPhOaoHV55ftXAlFaXz3BEMA1qE8jQPlQRQWPV2regm10UQmpbrxSPb2mmTIULN6o93O3P7qx27ZRHpMqGpckqORstSnogCHr0WCVAf7fWb5A2pK5ZHelxRNxl7qNGidKZrqE2IZ19/qVWCGpj1ZfjUEL7dZSA+UDJ+/UKzeHkTZaE6mj+Nw763FJz/nhLWT36DdiYL9O7A01xO9Lip1rXqq3C1NLOYA9TKvo50WS9abfdcjfa7m2uDrLDUVUp9tb2u0tdt81SVqAvWNMPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WXVpr+TQTOc/CNdusWJlMee9AgPICcF+8373axFJcM4=;
 b=N9+78zzxLT8HxzSj3PQ0T304OMQFkNOomCh2zdosCeCfev17ymxDlovgcRgLsIHVUSAw1nBqUuLm+lPsXoqu23Eee/FSbfT1xclvs30hEKGS9jPv8aohSwz8OeP7Mh1/6M0CQ2BUlpb0Lt+Hl1kCrIwzudD+Pmpi3hFkbRCxPWU=
Received: from SA0PR11CA0008.namprd11.prod.outlook.com (2603:10b6:806:d3::13)
 by IA1PR12MB6233.namprd12.prod.outlook.com (2603:10b6:208:3e7::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.21; Tue, 1 Jul
 2025 18:45:18 +0000
Received: from SA2PEPF00003F62.namprd04.prod.outlook.com
 (2603:10b6:806:d3:cafe::28) by SA0PR11CA0008.outlook.office365.com
 (2603:10b6:806:d3::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.20 via Frontend Transport; Tue,
 1 Jul 2025 18:45:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00003F62.mail.protection.outlook.com (10.167.248.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8901.15 via Frontend Transport; Tue, 1 Jul 2025 18:45:18 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 1 Jul
 2025 13:45:17 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <sasundar@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>, Sathishkumar S
 <sathishkumar.sundararaju@amd.com>
Subject: [PATCH 21/28] drm/amdgpu/vcn4: re-emit unprocessed state on ring reset
Date: Tue, 1 Jul 2025 14:44:44 -0400
Message-ID: <20250701184451.11868-22-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250701184451.11868-1-alexander.deucher@amd.com>
References: <20250701184451.11868-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F62:EE_|IA1PR12MB6233:EE_
X-MS-Office365-Filtering-Correlation-Id: dd01e483-8f59-4559-8a83-08ddb8cf6d2f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?P4XzPuP/IdiIIu2/UZUIQI7sDekTbd9LpNk39D1HO1vKzy+lg05d6Cdcmu6P?=
 =?us-ascii?Q?vyjA8kCSz5C29I9N52w3kJMGHJHJt0pCI4178xqtREey101O2qYuyXNhUmrp?=
 =?us-ascii?Q?JaagqSBAPMDsDJLX7jX4QhEoc33eNRvr1GOdrDXBuZ7l8XpGXJZIYSoDpcAV?=
 =?us-ascii?Q?OrLNXddk595T88ky9jdg6OOZhZ2f4zY796qyVs1+ylq7Qqy4ljGbs32GOsYA?=
 =?us-ascii?Q?PrwNehpjGn3rHqkWs3VTdm/PLrO40c9iZOBnLxh8aoB4E5ff3cxfPXuGeZyT?=
 =?us-ascii?Q?/rN2qUToXLekbVtC/CQFN1N42azhMB2pskazLjV/4DbtVPHVg38CKYZaBZ8+?=
 =?us-ascii?Q?uKG2ghycJ1rznBTRoewxTgnrIMiRA54M1fP7fVZArdP1piY+t4hsjEFSxeW1?=
 =?us-ascii?Q?rVfKtaftdQMCNR8ENWjhQak/KGZa/kbITTMLpdLpmJhAaku5Z4ymLb7jnsDW?=
 =?us-ascii?Q?OiHfsWz175KWvlRpp0pryH0GS9uuDxaOWcerh6UJCZYDthSGtvmHE/fkIoqZ?=
 =?us-ascii?Q?//hG4XCc3Gp8QszgZCAijQ2R0U05NgGq4zBARIdYXvlMFIfMlUfdfh9Aa5OB?=
 =?us-ascii?Q?4tIXvhec5B+lTx3YLLrzudko3Gh8xtiNAHAEdYNADVMEYBuTR2MUcjnAF8CQ?=
 =?us-ascii?Q?gxcXgQlvWQ8ioaYrzOj9BQXAt/jnRTpYIVJUtMpDi7MJ3R65UNk6sIvczjJ6?=
 =?us-ascii?Q?DurYENWSbi55ArFr6/FpCS/b+MURz6jZ48/j5gagqNfiqL58CPI/J5Eaioq9?=
 =?us-ascii?Q?6oqKKyedziZslaAFDwgLZB9l4BxwdQxpzbUqrVffzDq4aumvRSRSc9FZycc8?=
 =?us-ascii?Q?nTFGFvc8FzRjQgJzYKBhZMFNtxB6L0mNMDCrc5AWFt/mlzZ4/zK6Q455EzEE?=
 =?us-ascii?Q?eY4mhtUxSIx3/zbyRh+Dq1UtTa8ZugrfVjdcR5eZo50wovvjSuOw2Rd02+xU?=
 =?us-ascii?Q?NLy0ZIoBT9Yj+NqaKzfGLV+ZzmHpsHHSSjiPhWds+w5YIwEMjB7LbVcvob0m?=
 =?us-ascii?Q?9/kL8quTRM+nOm1ADyRoeI7oohnDT3TL/1XSz5Dh+TVRmeYrq1J0Bsr5IF+x?=
 =?us-ascii?Q?a2/HOeKqSdlO/jziizM6NtjLAmbT8aJoJQu/wRxoQk/8j4/rm5j4bsOGicAt?=
 =?us-ascii?Q?hRNQb1G38AZmZJzmsXmdhP76O8cIsyA+U+cVBaxoHfnSbus4f96g7p5J4vob?=
 =?us-ascii?Q?ZEH0l16utAxKqQj3Rtoi2O0qowWcrl1rzt8Nv6MAlUEc630kjHMrXw2kt3G3?=
 =?us-ascii?Q?FIp1JHIEgQP2qQza1rPqPzw9+ErS4O0qpoTOXFZcQwXVh4nGMKrREdM4R2QW?=
 =?us-ascii?Q?iymKtvuwq5csuGBfeHglIFHmyAlX8m7zQ3E8F4PVu19v+fAxIXOMqjxjFgNe?=
 =?us-ascii?Q?7neMCNfdZH9Jj5LKN2Zt8CF0CIXuQdDgqi1OK89gU3HwKckvadrnzITplPwF?=
 =?us-ascii?Q?z2SNsuHOFZ7zhgMi2A8jT1Hgj0rtH8YpWwAux8RVTXEXTZCqXeHHe3wh7F08?=
 =?us-ascii?Q?bSXEK0gySR8zQjiP6ZJfRBn5053CGeUmSXXi?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2025 18:45:18.5404 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dd01e483-8f59-4559-8a83-08ddb8cf6d2f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003F62.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6233
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

Reviewed-by: Sathishkumar S <sathishkumar.sundararaju@amd.com>
Tested-by: Sathishkumar S <sathishkumar.sundararaju@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
index eec9133e1b2c4..9bf1a345ac2cf 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
@@ -1973,21 +1973,14 @@ static int vcn_v4_0_ring_reset(struct amdgpu_ring *ring,
 {
 	struct amdgpu_device *adev = ring->adev;
 	struct amdgpu_vcn_inst *vinst = &adev->vcn.inst[ring->me];
-	int r;
 
 	if (!(adev->vcn.supported_reset & AMDGPU_RESET_TYPE_PER_QUEUE))
 		return -EOPNOTSUPP;
 
-	drm_sched_wqueue_stop(&ring->sched);
+	amdgpu_ring_reset_helper_begin(ring, timedout_fence);
 	vcn_v4_0_stop(vinst);
 	vcn_v4_0_start(vinst);
-
-	r = amdgpu_ring_test_helper(ring);
-	if (r)
-		return r;
-	amdgpu_fence_driver_force_completion(ring);
-	drm_sched_wqueue_start(&ring->sched);
-	return 0;
+	return amdgpu_ring_reset_helper_end(ring, timedout_fence);
 }
 
 static struct amdgpu_ring_funcs vcn_v4_0_unified_ring_vm_funcs = {
-- 
2.50.0

