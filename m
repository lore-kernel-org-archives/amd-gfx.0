Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6BC9EB64DE
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Sep 2024 14:50:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 630F010E82C;
	Tue, 10 Sep 2024 14:50:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="TflOLu9n";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2047.outbound.protection.outlook.com [40.107.94.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3459310E82C
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Sep 2024 14:50:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uEy/xEmF1n9cTuWn9hs7FAwDl16J1EBY7/Kxs7jUSwIYQI0UxB7bFPo8/DIMXQYf3mkVBIHtnqXY0lRXLd2STYUtoVXlvy8g8x93U0ReyL31VAh4ajq2dw+GRDmLqSVxf1WzvW5fkHDwEoBmGfO2pCNc9CABK4fsgP4cD1KBXEe4FyCABfBG9HY2jaCOUWNi+98w6QYME7Crr6lLAuw6oszAOU9ag/vKxsbW+lnMaSulIfx7GTjQ9fhdtG5+WAv1VUQiCe3G3AkU9NOJgVvDTcnw4zj8BqwEX3lLc93Y3zdyTyiAKRHD6vMS27utpDYLF7xfwXwl6LO1xV5uHmAi2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WKX4mRuFcdzeGtvztL4ivulR0+N1dbS4bho/rnvK/Jo=;
 b=BJPtdNJssG2WFGsHaLEvdlX/hy8JtngwzQJ4M6dKFwPFaWN3LavIXMHIRCS9qG3N6+6xjBjgBcidyiIl9oGuPPjBHBJcJ1LGDV2UaJxQ7I+Yv9DXLrxZHcIX4WO2MHutyvavpdEgMiOE4d70m7+kv/SV2BJF2zNIBVp/oKC2K9ar+DyPvaScx7C3q125iVn79Nb5shAxSDRKbMFT+Mqzcj107cngy+O6VFQ1j5GSQF0uDVqdPjMu91KLnkkx7UYij0qvW4JqOGPMKX93UyvIhe13asd1N9US5ONW/S/OBe8Y44gkob02drkXKEtGjE9kV/4coM6OwkTB1pPqLqSGPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WKX4mRuFcdzeGtvztL4ivulR0+N1dbS4bho/rnvK/Jo=;
 b=TflOLu9n94OiKxXqec7UrvrmSATf53p+lp0noSTLpTMQkLo4Wvqw0fssDRFtM+0+Uwx08PKfobTcln3SgeGS1JgWDif90JilnEosi15IhfRC0oeGaYkT8vAz/bvzkhWfKw4AY8qgcp8MpTJpkZG9B3qX6zwVR3CVqQcWHTlkC7Q=
Received: from CH2PR12CA0013.namprd12.prod.outlook.com (2603:10b6:610:57::23)
 by SJ2PR12MB8883.namprd12.prod.outlook.com (2603:10b6:a03:538::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.25; Tue, 10 Sep
 2024 14:50:13 +0000
Received: from CH1PEPF0000A34B.namprd04.prod.outlook.com
 (2603:10b6:610:57:cafe::26) by CH2PR12CA0013.outlook.office365.com
 (2603:10b6:610:57::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.24 via Frontend
 Transport; Tue, 10 Sep 2024 14:50:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000A34B.mail.protection.outlook.com (10.167.244.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Tue, 10 Sep 2024 14:50:12 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 10 Sep
 2024 09:50:11 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu/gfx9.4.3: drop extra wrapper
Date: Tue, 10 Sep 2024 10:49:56 -0400
Message-ID: <20240910144957.2728976-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.46.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A34B:EE_|SJ2PR12MB8883:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b65bcbb-a928-495b-838b-08dcd1a7dffa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?hUPs6UaCilnGubBWgjvvsObwl9U4f3jcAssDhDY2Xd6JgI87qQbs8UgdDezz?=
 =?us-ascii?Q?rYX622WCPr6VvmTyM/TEOaJZVDLqM+YrLKcwBxat/xPvPn56F+Pn1jPq55Zh?=
 =?us-ascii?Q?y0jP4P+KK4sZjhOv+VltrG5bnDWTaG55UZM//ZBA5h+eg93Ljts/Rp/0pyq3?=
 =?us-ascii?Q?pULVtuB9CwblB18MJ9MAsz+LxYhNQw+IF2DmiPitcl6qFr7ETTf5ISIG9Jzh?=
 =?us-ascii?Q?d5bfooaUsC2My0n+hdFpmS+EX28ouB28AU4h+QNjwWRijKM9anIGDOMKHHIW?=
 =?us-ascii?Q?3+zw78JweXmi+I/HpcwPKU0ZjEDPcZWtHB4MxZPdPeBeGIXPECNaogHA51HL?=
 =?us-ascii?Q?ZrQU77AA+aEJj+IpjYjYdealGanZPo963FKxbeJEfWyB+4WEhkfzO9EbPw3V?=
 =?us-ascii?Q?dCFGPP+a7tN980s79l2qqhx0Cpob6qqc1nzdA046EoeIheRDg7iV4S6hl2nt?=
 =?us-ascii?Q?AQ0YfmsODk85I/c6Rdzi3ZtiTacTK8k3MJDkqepDnqxBJGSaY1o+PE0mSkOx?=
 =?us-ascii?Q?H9XpFe3gPBDEkvb7EGXH21XqJs9LPc2+8fx6FpyKDz0VE8KwfKQQcU8fxAZq?=
 =?us-ascii?Q?WXs6F0J06S3mKeNAZAP8oKS/n0FaeVk4OLIWjaikB/DzcJMJYONkyh3fidBz?=
 =?us-ascii?Q?Raxv3CyDHl7jXEh0nvvzoWpymSKEA0o48V9GRxLao0j4g6R+5TCQcCR8V9ST?=
 =?us-ascii?Q?0XdLwyZTSoRvoh9I/pJXC51mm/zxqTeHLZnu3RryjszmRrV8gsZIgGC385Sm?=
 =?us-ascii?Q?/k2wd80JVFDWpwWdSuXcr5gtHuBK1K9Z/J9vFCj0TZi5UaBMRfSvz2k5CCCB?=
 =?us-ascii?Q?9gGRUihlknDWGJnBVCn/tZRxzl/LOgGEUTtsYoAE4SBtiF3B+LgGKk3WbC3A?=
 =?us-ascii?Q?KNFOBKyWTQzGRS9D1ZXcCyJsiUhUEKh2djO/97D8312K6215REom/eqjWMa2?=
 =?us-ascii?Q?4iFFhfWPcEoMIu1TfRNXF92ejJof33xI63OFBI8G/Jg+ImZKLAIMHdCw4ANT?=
 =?us-ascii?Q?Mua8Eq/wBogbKmTRhXk69fc/FItJ8ksEOHuQDqQ+2BX8TlPmygQG4qshpaYt?=
 =?us-ascii?Q?ppzIwr4PVmJzqfl66NZTHPA3H0rMnGv5Te4xx+SDoJUKE5YujLixHHznPgHq?=
 =?us-ascii?Q?45VzlYAKT38BftnLL71VbOw5kjvhkgkvafrvEvqr7IrRnLdwPJDDr4XbUYvY?=
 =?us-ascii?Q?EQrbSgSUXek78eFHIz6XlJ/0Qfcds5obVQngWfwf6zNd7Egm0yqKAUfAJZ3Z?=
 =?us-ascii?Q?NVL+uHd/gD/NL4sYncXlS2zF/KEb0Yd5wVfTVGNGl+i1a7O/Fs/NjU65uTzn?=
 =?us-ascii?Q?h1y6xidhT+T4LBCYUTDi7+2yAjXjX6K5EZP44BNOyGdtW6srTdekKdql25AS?=
 =?us-ascii?Q?lFS7N/uuNFkUtYjVlcvwOHBlfPakDxJzUWqzEphoORudOSH2bw0vZWHSRQVM?=
 =?us-ascii?Q?BpQK0OqM2N9i8hFfoBXgnF306UUG1a3W?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2024 14:50:12.5841 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b65bcbb-a928-495b-838b-08dcd1a7dffa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000A34B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8883
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

Drop wrapper used in one place.  gfx_v9_4_3_xcc_cp_enable()
is used in one place.  gfx_v9_4_3_xcc_cp_compute_enable()
is used everywhere else.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index 408e5600bb61..b940d2ad57db 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -2299,12 +2299,6 @@ static int gfx_v9_4_3_cp_resume(struct amdgpu_device *adev)
 	return 0;
 }
 
-static void gfx_v9_4_3_xcc_cp_enable(struct amdgpu_device *adev, bool enable,
-				     int xcc_id)
-{
-	gfx_v9_4_3_xcc_cp_compute_enable(adev, enable, xcc_id);
-}
-
 static void gfx_v9_4_3_xcc_fini(struct amdgpu_device *adev, int xcc_id)
 {
 	if (amdgpu_gfx_disable_kcq(adev, xcc_id))
@@ -2336,7 +2330,7 @@ static void gfx_v9_4_3_xcc_fini(struct amdgpu_device *adev, int xcc_id)
 	}
 
 	gfx_v9_4_3_xcc_kcq_fini_register(adev, xcc_id);
-	gfx_v9_4_3_xcc_cp_enable(adev, false, xcc_id);
+	gfx_v9_4_3_xcc_cp_compute_enable(adev, false, xcc_id);
 }
 
 static int gfx_v9_4_3_hw_init(void *handle)
-- 
2.46.0

