Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41724C25B75
	for <amd-gfx@archiver.kernel.org>; Fri, 31 May 2024 06:53:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6F30F10F2E3;
	Fri, 31 May 2024 06:53:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="TEaRXY/0";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2048.outbound.protection.outlook.com [40.107.93.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5609410EC6C
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 May 2024 06:53:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UtCXu7mFPtDjno4JdDaEjDLM+bGBJ7oJOWz7y6ZlJ6NJ95WYpvt16QaMh2Uw79TBCopLAK2jGlNM/IKXD7bHRLhyf+WRmXu7WXzNdcf8dyqkVUsFGJqJgMSokw6xZtS5DT8TNKMLKdIzu1869R70H4VQ0h9fNDUjQVgHuz9knotEttzWkTDhhaw84kxtiQ0mqqsrxWFlLk30ofdGUvaCLb53tY3FRo+mE820CBJ1XVDZtEttXtLasYmW3/zAHzmpvbgQDgpFcMR+ZwG79rufl7cSsHbwPmVRJ6CoXYDTEuItcCLuTLXIo8cVz2kCa1UG5UFKRCzXk+oZp5gwfpT2xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z8zwOD/E/Q2UTqZlBLpJKk1yjSncO2ofgfQqAcw54Ro=;
 b=Jqr2u7LyXx+cd55PU/TR2McnNS7a7uttY8uacsNpf1f3dO3xYMUDXk41gwDgfH33CBOMZfrCRAfCpG6voCVU2AZnqZdSFbVFkouo7WtzPL78/5Njsblyn7yzUyUyqr1hUvyVi+en0GMKYloaFzbe6fbmjqXGHSPFD7hx7dVWCw+cJTgLWbkvVOJgK4aZ9QlPpHHQOPv6AjF0EjfHGfMoKGBYdBLcYpdXt7AneZrva4PlYMh1T7rZkShLHVGzKrue+NX95uAXhZDIkAdpbJIECU4x4qpSUdN71Xr63hDyajzKO3NpHMRpl8jbYVKAFC0kf3gjEK/gFrLaRA+HXGl9TA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z8zwOD/E/Q2UTqZlBLpJKk1yjSncO2ofgfQqAcw54Ro=;
 b=TEaRXY/0Y9pBA8eI9VKzRuMj+YRFHahkvHSfxnSUtGIRWVYY4SeLMlKR3WInsIVKTNHXr5y1dHmckrq+f9ZJTMf8pdtNt4d+VlyXsSgsBktxgbiLoKotZZRrqaWEqUXMZtS7ScPTsIVOknoe3J3z/G5dWIqO/WQFnQFmMhMJLkM=
Received: from BYAPR05CA0072.namprd05.prod.outlook.com (2603:10b6:a03:74::49)
 by BY5PR12MB4274.namprd12.prod.outlook.com (2603:10b6:a03:206::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.24; Fri, 31 May
 2024 06:53:06 +0000
Received: from SJ1PEPF00001CE0.namprd05.prod.outlook.com
 (2603:10b6:a03:74:cafe::22) by BYAPR05CA0072.outlook.office365.com
 (2603:10b6:a03:74::49) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7656.9 via Frontend
 Transport; Fri, 31 May 2024 06:53:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CE0.mail.protection.outlook.com (10.167.242.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Fri, 31 May 2024 06:53:06 +0000
Received: from kevin-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 31 May
 2024 01:53:03 -0500
From: Yang Wang <kevinyang.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <hawking.zhang@amd.com>, <alexander.deucher@amd.com>
Subject: [PATCH 04/18] drm/amdgpu: refine mes firmware loading
Date: Fri, 31 May 2024 14:52:35 +0800
Message-ID: <20240531065249.1746350-4-kevinyang.wang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240531065249.1746350-1-kevinyang.wang@amd.com>
References: <20240531065249.1746350-1-kevinyang.wang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE0:EE_|BY5PR12MB4274:EE_
X-MS-Office365-Filtering-Correlation-Id: c9a9b76e-569b-448a-dbc1-08dc813e537e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|82310400017|1800799015|376005|36860700004; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?rIo/kFc5u45rIgUUnX96bXKynhfNBr+OthpwuRAyMf/v3I9WZF/7ngHuOe2j?=
 =?us-ascii?Q?7bupsvJTIWPuihjEeh0AJlIb3lLPNkG5LVOOiFPZAGX6qGN8SdMmdNP02T6J?=
 =?us-ascii?Q?uyR32VeIczZIzXSVarwb3N1GSmWA01yFntfMXnKmvh8rcG5Z22YWIwGIH7f+?=
 =?us-ascii?Q?8cb/38tCMhFr6Gv8CmwwqqgC7/Fa+nwa0k/5BMjnuRsrUBCGpYYoD5I0y46f?=
 =?us-ascii?Q?bg3V0gCu9MgBCIZBWknfbuojwnhCHovAqK2jXXflNg11kZTtk06BpfVsZQJt?=
 =?us-ascii?Q?AXPxhFBQ0xm2xTJ2vrbCfQFgHdw+aTc1YXFrF5etSPIEmdMoBl71OqvQFTcs?=
 =?us-ascii?Q?kbfOEN88hZfcrppAyMNMLB/AO1rXi5JnvjWI6uy7QVvT0BCzP183SsukrElS?=
 =?us-ascii?Q?YET9Tc8sM3lWYT/Ij3Ja42s+iMYRHSA2DzAC4Y3FDmkBE/YH9ina5RtYaUm3?=
 =?us-ascii?Q?AVpDVCCHC9y56WYP9bJytU4SzoZlKXV47txXUUePBDO25D2vP5B76yPumGQj?=
 =?us-ascii?Q?wMkuFzp13npdPvp7vVIUZYnS1Spv31lEJDwr0b1kWCFQr/flWJ3gEzWgvwRb?=
 =?us-ascii?Q?Uxl9Xj+2aVhrqPT0PDvamcs0NRPEb40Yu/Qn0/IGefg0c2i07ZbiVGpdyYr7?=
 =?us-ascii?Q?sY075ZJsHz7aRiPfFE7x/c8BfYPFrPxpTKwWaMg58Z9ATv7htcKaHuWkyEiJ?=
 =?us-ascii?Q?x9zgwvUYGBKSxpNYvdH2V7RdCstrqO6/4izgU5Twf1xzYD03R2Jf/EHVtN3T?=
 =?us-ascii?Q?mXSGugT516RB6LfyjDrOlxwI2umFoYGVXKpXnYpt4QTQhx5RrinNNM5YrNer?=
 =?us-ascii?Q?rSkuspG14WWV1daSqERfHwy0niKfZfxIl9xzVsXOMV5dfsD1AyHJCVKOuxan?=
 =?us-ascii?Q?qvzS4K7UUdGu4vnVPxntpX8rsmMC5ZSmbzWpqMQTJrPCR757YLZAXzU5hXG4?=
 =?us-ascii?Q?GPutBewc4RUEj1HJljCyORfZXLoHA8uyYt0LtAwMncWuwQUmftFiRMTmeppN?=
 =?us-ascii?Q?qGKMbKginj8QeboJEUbA1IVT0y8nn+tYTv4UVostruicSGv82LtA5qM72IOQ?=
 =?us-ascii?Q?zoYSGb1JVfYJc3aBjKivBsRcG0uDH5L4uWNc2k19a1GVeHDGM6WMjyOgUhXm?=
 =?us-ascii?Q?p6EmqeQwd3aT7vmmOsIf3uwoBonmkZnM3LSHoHC94m8RhqzbuLE+X5b5w/iG?=
 =?us-ascii?Q?GRHnDiXhnMzBNoZDrrm9VW0Ft5TDsCHfGcXrH1svwbyFuN3Zvj/b8TaJ/iWn?=
 =?us-ascii?Q?ZzoQIZhy7EWGGOcchQ9eBiZ5xeGY3u0+LAuMGHtnjSXzo6LsyyK1M91PVfTL?=
 =?us-ascii?Q?4Rh5SYqNiEApnJbY5KqqCTjkvNVd2mHFS3i/ghEaI2Lq0nOPJh/nNmasuSKh?=
 =?us-ascii?Q?lrk+SZ17JmvCWb1WgYkhCNTEnqrW?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400017)(1800799015)(376005)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2024 06:53:06.7295 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c9a9b76e-569b-448a-dbc1-08dc813e537e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CE0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4274
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

refine mes firmware loading

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
index 62edf6328566..9194a53b7c14 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
@@ -1528,11 +1528,9 @@ int amdgpu_mes_init_microcode(struct amdgpu_device *adev, int pipe)
 
 	r = amdgpu_ucode_request(adev, &adev->mes.fw[pipe], fw_name);
 	if (r && need_retry && pipe == AMDGPU_MES_SCHED_PIPE) {
-		snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_mes.bin",
-			 ucode_prefix);
-		DRM_INFO("try to fall back to %s\n", fw_name);
+		DRM_INFO("try to fall back to %s_mes.bin\n", ucode_prefix);
 		r = amdgpu_ucode_request(adev, &adev->mes.fw[pipe],
-					 fw_name);
+					 "amdgpu/%s_mes.bin", ucode_prefix);
 	}
 
 	if (r)
-- 
2.34.1

