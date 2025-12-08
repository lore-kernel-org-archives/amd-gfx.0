Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08A2BD3B7EA
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Dec 2025 17:20:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8B48410E179;
	Mon,  8 Dec 2025 17:20:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="zUGasBJQ";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011067.outbound.protection.outlook.com [40.107.208.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DF52A10E179
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 Dec 2025 17:20:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cXCPkmzNuwmn6eVkAqqHosNRR0xdAQ2E4VCpJVunsaqAfi54TFtzHvMM5FWho2ZN1z+OAPM58AUeD5RcUd8qIXHubJjNPFB9o89A4SnAWmwlkZvy2e0GaL9bSpUbLRQZWxbtcD3wlT3n4iO8J5xXhU2uMDliVHPwTnncO/DztF5NY2L1nyEH/8xYsZmPIr5F3tl7cYgXOWLjspYMa00VLjsdncPLkFvFZ8z1/1/QdPiv+Ep96oZkj8oeXT2gFrFHHzS7nu6pFcQekVldaI9SsRwJYmxL8IOGjFTSz8LKyu+lu7Qqp+1ZbnpbOxuX8K/7Wj8AJwgxF0Ap9Odv64FZlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y/NbJEedlSteU8qS05ZUHQn5xIbmc5V0tDEey+xdsqY=;
 b=LGachnIWWxCGx6zNpuMueM2c7bG9HwLZsnrXOHeY8MlxRrzEcIEart/EE3T7Uh+MLpa6yvjkCvOEDVeqnGULCjfaDy6WIo319dhhGU+iu5i1O5LlVrkDONpbtvju/WZHObdlPBi6U1K8fogRZDujaIacYkXXDd4Yfz9jrHtgRHT+s3wIVD8JqvRHTp5wq5KW0ioUdnCLpO7GTF6lhP21gS6TuWdEVvgCDZkzLbQ2nZO2JNMmJT12xS6dsCuDhg2kfmYH9d54IRcIU0t0jnxBm2No65JJTvwGCfv1FvimqSNNznB8trjBV2Ipt1Key9OSUTi0eXUR1ukfRPG8+DniMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y/NbJEedlSteU8qS05ZUHQn5xIbmc5V0tDEey+xdsqY=;
 b=zUGasBJQXIFpF+lToAYHTV0TbeedgZO8lx1uIcHo2oUheIBLnqOSn5x0miR3lZ5mEXV7qcMja/Znmo/Lp9FQw5gjXxV4ykZzwv/aPZKc/1mmkskwaYGCi4wE1UyLe/rSNp/2ZBjHf0arWYMUqfWfQCB6CrX3v73ifHzr0cnoSxM=
Received: from SJ0PR03CA0144.namprd03.prod.outlook.com (2603:10b6:a03:33c::29)
 by DS7PR12MB5768.namprd12.prod.outlook.com (2603:10b6:8:77::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.10; Mon, 8 Dec
 2025 17:17:52 +0000
Received: from CO1PEPF000075F2.namprd03.prod.outlook.com
 (2603:10b6:a03:33c:cafe::6) by SJ0PR03CA0144.outlook.office365.com
 (2603:10b6:a03:33c::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9388.14 via Frontend Transport; Mon,
 8 Dec 2025 17:17:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF000075F2.mail.protection.outlook.com (10.167.249.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.8 via Frontend Transport; Mon, 8 Dec 2025 17:17:52 +0000
Received: from tr4.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 8 Dec
 2025 11:17:46 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Hawking Zhang <Hawking.Zhang@amd.com>, Likun Gao <Likun.Gao@amd.com>,
 "Alex Deucher" <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu: Init compute partition mode for gfx v12_1
Date: Mon, 8 Dec 2025 12:17:11 -0500
Message-ID: <20251208171720.153355-11-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251208171720.153355-1-alexander.deucher@amd.com>
References: <20251208171720.153355-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075F2:EE_|DS7PR12MB5768:EE_
X-MS-Office365-Filtering-Correlation-Id: d12442cd-df2e-4370-39ac-08de367db826
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?I8MxbGT2+2rzqEU+C2CU4FTFe1X8BqddLwE8iYTCg8I2LLe/nEki9iJMDngr?=
 =?us-ascii?Q?Xfj25SAofdJmJpQL/DYOM7qjeCUX79dODKYARZlcajzS2qgmuiEYh7tvYJ1A?=
 =?us-ascii?Q?Av9mNNcsArPYFgbVEHIar8YjPbAtIWQ5ylldcFzr0/SSOU0YEokg4iYYCwZc?=
 =?us-ascii?Q?p5u+SLqLHx+hICLIMpx/AVdjdAmki41vXr6yUQeMgntHeJKn8NVoyiDQWeVX?=
 =?us-ascii?Q?zDJfGXaacc9/KVGj8hGOiNWXqyzS2cm4gfAv6+xqYDpmpNEoiLsuuCpBYvPM?=
 =?us-ascii?Q?HRunmasTK/vf7Ru5I2ixb5D4HwQY9tCe4BWlf2EjBmF3aZj94qEiVO/BvgRm?=
 =?us-ascii?Q?9NEs3+SZLjaPR0uU10vOTQm9tPm8yJmza/wFrnyR/qAkzIFu5slGHbSH4bpL?=
 =?us-ascii?Q?7ghdO9pGnaQRw+H+pZB4iqIZ7y3CsQegzK8gQFz9T7KA4AosY9XZYFUFCJCN?=
 =?us-ascii?Q?OKpHKyCFOB9zROnX50haPJgqOirmGNZgNHkfK7RHkRS8shzhMm4QGada5e8B?=
 =?us-ascii?Q?cC+2BwDx1YYdM8krdp2+3+aySAXz88+XG2Wg2f9+J4e5d7yRLTcuu56GEk/c?=
 =?us-ascii?Q?nyFTmuqp+iEucyoDeG6jLAbFYETufaiFjGephVmyndcXR4nLo6bmv8HJsZz9?=
 =?us-ascii?Q?YY5gzuUZmBapv51vRe8jsixa7j/fgvmfyUqdkG/tQahgulPvcXSRmESeLX5P?=
 =?us-ascii?Q?lglc/EmIn+1+srFdWmyoFiuSMOnhIySQyTt5H+TqJOXEsIxwRrbGPI8j26DC?=
 =?us-ascii?Q?kG/YpQeTCBY+q7LGXddW3HrX/SHYCFP0syftCVSZJwFtyDmvmi4ZRvhsir1q?=
 =?us-ascii?Q?hBu/HAdyQCGP+KEPeiPHNbmbXOGs8eY0j9+EhRThSglAZCf8edDJJYhsO1mn?=
 =?us-ascii?Q?nMZN2/q+FaPJHVBuu3hwKUgw1gRdBROzsXUqbv28XjxZLpqRRLxDTGBzDRYN?=
 =?us-ascii?Q?f8nZaXtlVJFIH2WnjA3KFUgh0BWebSZI89fhq5fD87oER9opMuJJ1HKIzHZ8?=
 =?us-ascii?Q?KM4x1Nw3IJ/WseuOqVcT0LTXzLTEwiLFMtuRu3UO2/UB/REpJE5flOCzIBiq?=
 =?us-ascii?Q?w8uj2OTVd0NHkuTaV7so/mJDnDvR4WN5Dr8Munf6e7KfJ2gUER+Hhbm12Sz0?=
 =?us-ascii?Q?6Oz1b/WrM0wGt+FUoPtcorYDp6nbJdRdMQLM4jvNeXwPCAMES9g5YYhmMSH9?=
 =?us-ascii?Q?qmOLM9dpTEWzy4+6PgHy7hNRWpVJcmhSv9e7I3JLXFvRLzS/g5I0JGtWfm4m?=
 =?us-ascii?Q?cfHmVzZl1PIn2G5VYqrDrtZ9FOLxg6lahUiP886XXPRiq9hJKuYBeWjVcdFL?=
 =?us-ascii?Q?q4SoTvhBmQ8LbKM2gX75e841CHKn58GfNNBq7o2j38wH1uxK7Zptcvm6FHed?=
 =?us-ascii?Q?qaFHoXmjfkFfnbvSb4UhR7aa7Fb7HWhxO+KNhMZRadQtEH2YlSa1n2wtF4x1?=
 =?us-ascii?Q?/yQgBw2D710imiMnGJoDvXKbog0NjgfnFhDv9JDuczRNLoZRtxDvpz3A0tCc?=
 =?us-ascii?Q?JAHMhGDSU8K1aoVmfZMspIxmJzgnGEwj6x4nKQlJG+vUVSd7y3LvrnMHwCAP?=
 =?us-ascii?Q?BynhV6il6Yv5L8McGoc=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2025 17:17:52.0164 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d12442cd-df2e-4370-39ac-08de367db826
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000075F2.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5768
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

From: Hawking Zhang <Hawking.Zhang@amd.com>

Init compute partition mode for gfx v12_1

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Likun Gao <Likun.Gao@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c | 34 +++++++++++++++++++++-----
 1 file changed, 28 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
index d761150410083..5e9ab3a5184e5 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
@@ -2447,17 +2447,39 @@ static int gfx_v12_1_xcc_cp_resume(struct amdgpu_device *adev,
 
 static int gfx_v12_1_cp_resume(struct amdgpu_device *adev)
 {
-	int i, r, num_xcc;
+	int num_xcc, num_xcp, num_xcc_per_xcp;
+	int r = 0;
 
 	num_xcc = NUM_XCC(adev->gfx.xcc_mask);
+	if (amdgpu_sriov_vf(adev)) {
+		enum amdgpu_gfx_partition mode;
 
-	for (i = 0; i < num_xcc; i++) {
-		r = gfx_v12_1_xcc_cp_resume(adev, i);
-		if (r)
-			return r;
+		mode = amdgpu_xcp_query_partition_mode(adev->xcp_mgr,
+						       AMDGPU_XCP_FL_NONE);
+		if (mode == AMDGPU_UNKNOWN_COMPUTE_PARTITION_MODE)
+			return -EINVAL;
+		if (adev->gfx.imu.funcs &&
+		    adev->gfx.imu.funcs->get_xccs_per_xcp) {
+			num_xcc_per_xcp = adev->gfx.imu.funcs->get_xccs_per_xcp(adev);
+			adev->gfx.num_xcc_per_xcp = num_xcc_per_xcp;
+			num_xcp = num_xcc / num_xcc_per_xcp;
+		} else {
+			return -EINVAL;
+		}
+		r = amdgpu_xcp_init(adev->xcp_mgr, num_xcp, mode);
+
+	} else {
+		if (amdgpu_xcp_query_partition_mode(adev->xcp_mgr,
+						    AMDGPU_XCP_FL_NONE) ==
+		    AMDGPU_UNKNOWN_COMPUTE_PARTITION_MODE)
+			r = amdgpu_xcp_switch_partition_mode(adev->xcp_mgr,
+							     amdgpu_user_partt_mode);
 	}
 
-	return 0;
+	if (r)
+		return r;
+
+	return gfx_v12_1_xcc_cp_resume(adev, adev->gfx.xcc_mask);
 }
 
 static int gfx_v12_1_gfxhub_enable(struct amdgpu_device *adev)
-- 
2.51.1

