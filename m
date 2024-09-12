Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30B6BEEE270
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Sep 2024 23:29:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D2CFD10EC7B;
	Thu, 12 Sep 2024 23:29:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="oyrcpahi";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2069.outbound.protection.outlook.com [40.107.223.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 99BD710EC7B
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Sep 2024 23:29:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SdDO8nW8qdY+3hO+yFTHcMDenhj3h+Z46q1evzHWFlPhLlQwmGwijD/OWtMlKuyEQRv8dbAkhzoXS5UcWYb0EZr6zxu+9DZNPMI67wYgIZcDziKs/mK7LyiKZQuEJRS3RbPqZEUVC2wYd3KW6vMziq7qgo36fyASeX7R55IZI+xjSpJUxgJgeG1qC9jH73h/X6i4QQ3W5i+Txa1tV3xkolZndy7UNPSoVj4uasZVRd44jcuQnGP9HmNP0jbdma02ZfK98cL4f+HxMAlUCgBbwGVNNPSJgbe8Gkxs1vNFjfIW4dlW8Xcjbwbrap6uSGYMgIpQlevWTYNl77J89vN0+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g4pOnCwfq4kGAnmEgdVPO52yvX2D3Yo0oCnT6H8yJPc=;
 b=l2+4RfObHSITth29n56W+wmSdOFOp0sQiQhcxzeseTdcpSkzv6gOy/q19P95jnUesEknK1ClTrAUH7Wj9ySUiiJX29B/YKQZGySu0YCmD1jBOgRJ6VyTtm9dcAKCIZ5EgxqBSipAsnlPUkINqx524z/LIaAZARZt0rQTkIucoVyxV0BobCqOZ2okrpN1C5me/0XH2ZGdJbanj15i49oQpcrOpVYf3rQBF/BTz2fJBBSj3bM5HdONW6SWkJUCZxiHMHMwfemb9A60pI7Xs9gQBpvxtH86Nhrmo8na3bvD7T3JJX9tZ8ym624QH6xpQG3Mr/errvEjg/8UZWtnfE1nbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g4pOnCwfq4kGAnmEgdVPO52yvX2D3Yo0oCnT6H8yJPc=;
 b=oyrcpahil2zaidZDF1cJtDyYE1BV2F6FQmy5Uyx7+DYfI6YHMRgN5EeYG5mzcF2Ovf/4a0i2Ll4m79N7tHkO5uOa17zUP98gUOF1fzm0NUxzMWJRffaduT8KMpIYycDAXmrIQMBicujURVPTY7yuDWijTVp848cssw1lErH8EWM=
Received: from DS7PR03CA0169.namprd03.prod.outlook.com (2603:10b6:5:3b2::24)
 by CH3PR12MB9429.namprd12.prod.outlook.com (2603:10b6:610:1c9::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.27; Thu, 12 Sep
 2024 23:29:41 +0000
Received: from CY4PEPF0000FCC4.namprd03.prod.outlook.com
 (2603:10b6:5:3b2:cafe::25) by DS7PR03CA0169.outlook.office365.com
 (2603:10b6:5:3b2::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.25 via Frontend
 Transport; Thu, 12 Sep 2024 23:29:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000FCC4.mail.protection.outlook.com (10.167.242.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Thu, 12 Sep 2024 23:29:41 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 12 Sep
 2024 18:29:40 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu/gfx9.4.3: Explicitly halt MEC before init
Date: Thu, 12 Sep 2024 19:29:24 -0400
Message-ID: <20240912232924.2489214-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.46.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC4:EE_|CH3PR12MB9429:EE_
X-MS-Office365-Filtering-Correlation-Id: a2c79037-ccde-4291-23c1-08dcd382c6db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?VJaV3TUCUjEWcrPYBM4+y1DocV/4vf6HNN4WTD/gDDs/SxFeU1u2KAUrDOh8?=
 =?us-ascii?Q?E+UBWVDoTPhvsnDquGb74A06vInVhI80PkOCXxaWp8BFkUfw1UkjxSWIS1IT?=
 =?us-ascii?Q?f5vFxgoo/nof4Rt8h0sK0cRbeAaX39zTdVSNvpssYN7npbw8Fy6MEYUWA2go?=
 =?us-ascii?Q?GvzdzM5aa9islgQdHlAy6qp2OvtWZs6I+dBqXSo7XTR7uhtj025ERhDoML2O?=
 =?us-ascii?Q?ZUu6JKqhL7b5uWHFnw+lzRcrjA0JmvtwAW/8YZl2xyLA4Dc+lGashQh7rnkY?=
 =?us-ascii?Q?t4Fml847yEODdbmzKKKdvEIL2y7OAhNwqbQa5B86ZxFUmGIrKyQbzxvLcl5N?=
 =?us-ascii?Q?CeFNivtAnvEgl/nST+9yNf4k6k+gNC2eq3o6/xD55XND5HMICIiHKqblVDXQ?=
 =?us-ascii?Q?2XcjiinlNaLIu2pkTu+eunKW5bVgb4etKpBRjx3NUiVLXvjWbpVv36Exh0rY?=
 =?us-ascii?Q?Y5CG5Gg/UvWT29awxKI4yPzDhd0Y6ATTxfsLMFStLEtqiRRPfM0eXAI7HDvt?=
 =?us-ascii?Q?FZ6Dn+3fFqCbTsoMAaZfKri97INIRDI5xP2A2uuTYt/6kOmNEZ0yR7Ruc2bM?=
 =?us-ascii?Q?wSn4qwdxFzBPpAAVjjWu7eU7ou3kllGC5zpcWpHBhcIREJ54mFhmycjLMF7u?=
 =?us-ascii?Q?m04vCXGRbnd6eE9mnrQmYj6B4SchAGBxxIqI5ts/T5716lwMqFbV5IKmEMNg?=
 =?us-ascii?Q?x2hbC7CH34OaCRfpKJRIj1aG/qUrrY/a8oGk4yDAzWb3wxclFzRTooUzpA29?=
 =?us-ascii?Q?I42TfOxV/sNYVZWh9I/aQlggschqY5oVRmjdNHHJ7cPymrNAI4mRRvhrsxL2?=
 =?us-ascii?Q?kXTK5lRgHf6MdDgT+RNFkxLQJ07EkxFZb73rF0/jIwxPrREaO6zCv83YLSS6?=
 =?us-ascii?Q?QczfBiOXoEyQxUkY9tlUGvxa+sPqCaFo4wK77xRNrZjrVT/28o/uMNkoxPUt?=
 =?us-ascii?Q?ZxMlKEQOGuTepUaV5KfEBozt4swv0fTlWa2Xt+9FViHLENhIGMB7muq6AZOk?=
 =?us-ascii?Q?ufo5DNxvoPvJQ/xiHMcBmCN82FPEN0qNvLOBE+gWHyu5igzOIsscuwH/I7uc?=
 =?us-ascii?Q?Ad2eSpBlW+e0sl8YrwSw4du/eCo89VL5BzTMvxYE7PPT6Nvu3jDa9W3CrmJw?=
 =?us-ascii?Q?zIiYfXdn2W7qqrM6x5GAG/WbPVyMgr1z3r1EdNnhEPiHXTYsr3bdVXzg7sPg?=
 =?us-ascii?Q?rk1C2bb4RuiUECn39bbLVyvm6kJNgNBds6ziGSSj61znlJd/x1AIRKyhdNqq?=
 =?us-ascii?Q?ThEepmX9jfUIgju9vu0AFWnfzIyRav1jMU9GPH+/qto0a4J69+JewYn7cw0h?=
 =?us-ascii?Q?NBbw54C/xRf8dbPjQB6yLEVNyDXjcgkUL7Tf5c9gvsz+ffwjbPIChmtBt6V/?=
 =?us-ascii?Q?TNiEtGcjcIzXD4gqSpZ8/OoSlNq5JCQmZcYK9DcMEh/2WEtLpSW5XpLEQDmX?=
 =?us-ascii?Q?Je+wGG6euNgi32lAQTsS069DhHifbIli?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2024 23:29:41.3664 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a2c79037-ccde-4291-23c1-08dcd382c6db
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCC4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9429
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

Need to make sure it's halted as we don't know what state
the GPU may have been left in previously.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index 611659404703..c100845409f7 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -2248,6 +2248,8 @@ static int gfx_v9_4_3_xcc_cp_resume(struct amdgpu_device *adev, int xcc_id)
 		r = gfx_v9_4_3_xcc_cp_compute_load_microcode(adev, xcc_id);
 		if (r)
 			return r;
+	} else {
+		gfx_v9_4_3_xcc_cp_compute_enable(adev, false, xcc_id);
 	}
 
 	r = gfx_v9_4_3_xcc_kiq_resume(adev, xcc_id);
-- 
2.46.0

