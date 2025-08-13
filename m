Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF95BC87FCF
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Aug 2025 23:29:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 91DD310E7EA;
	Wed, 13 Aug 2025 23:29:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="NNs4w7l7";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2083.outbound.protection.outlook.com [40.107.237.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0E09010E7EA
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Aug 2025 23:29:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z/zCoKG4B8ZlHO6tIHGx+kPfiuIbtAUuoBM2ilpKd2nkVI9pprYsWGLB2scq/P8a/Y+d8xNoSTSZNYE4TNF6ddOQqphNV2AUmALoEd8xvGRrTYkzasBzFADYJ9FJQC/E7KTiPkVZfNCXUYXMusPsNKjsrU18mpK50Kw5VxdnO5X0wlQpIBHKaKem+cH61H5UJcHkR0KP/Dcn1UfHIKhUOLuRKCnpNkd3jcGlqlOZW1RkEuPxk11zExoaqyIQTOtigQhsto8L5qQ16ChY2/JxHYSMbGp4kXbPUBAJNQnQv/rnF/LNT7m9sNocbaUrC/3NTlJJeGTu/LRaCDr2Ft96+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jAi1phTOgqdSvMGyqIxFrP19OQgTJKy2TUdWoxDo3N4=;
 b=KN0kR3qUpEbDwvyN1Ry1eZgdjCB7g2rD5bjrOAHTlqNkhY2EgCppdDLL/eM7s9K3wIjfa1KbNtZ9RUCd+atmCYMJnLRJyfKoR8VTPNy3M/qr4NlTKPl7Sxd0yBcLVue3u4alL1JP0yd3Wgp21LlzQx3OI3okq5Mp3LueHn1xPVIGK1LQ3ChvGrC1o0lXeLUpR4L8zZtVGzL2aXShQZxJveRVfyC3GhXJdiDUMqRJwXAJ0ZIb6oEa+QVWtNKIVD5u0pWyPTaNes6neTJBjW2eBm3TgjgoewI5HQL7alnmj9Sfy/794W4oO5Nc/9oRKs20SdyWkmVGOIROOEjenHurfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jAi1phTOgqdSvMGyqIxFrP19OQgTJKy2TUdWoxDo3N4=;
 b=NNs4w7l7c1KCa8riGqfSuKR9K1kgPpBb0ONiK3meXx9PPhr4l6eyEcxQeC4Gz0Ojnjuyx+XC7Vj+4ofd+i60x4yWzHY6Xe1wZ2i2fwcgvbBJm1qb9NQRcFpFxFzmaCfQNFzUH2gtMyBwXjWlhlD/G5oC9WUAok1a9cCYp25GUUM=
Received: from DM6PR12CA0007.namprd12.prod.outlook.com (2603:10b6:5:1c0::20)
 by MN0PR12MB6198.namprd12.prod.outlook.com (2603:10b6:208:3c5::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.15; Wed, 13 Aug
 2025 23:28:59 +0000
Received: from CY4PEPF0000E9D0.namprd03.prod.outlook.com
 (2603:10b6:5:1c0:cafe::94) by DM6PR12CA0007.outlook.office365.com
 (2603:10b6:5:1c0::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.16 via Frontend Transport; Wed,
 13 Aug 2025 23:28:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D0.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9031.11 via Frontend Transport; Wed, 13 Aug 2025 23:28:59 +0000
Received: from SATLEXMB03.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 13 Aug
 2025 18:28:57 -0500
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Taimur Hassan <Syed.Hassan@amd.com>
Subject: [PATCH 11/11] drm/amd/display: Promote DC to 3.2.346
Date: Wed, 13 Aug 2025 17:18:19 -0600
Message-ID: <20250813232532.2661638-12-alex.hung@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250813232532.2661638-1-alex.hung@amd.com>
References: <20250813232532.2661638-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D0:EE_|MN0PR12MB6198:EE_
X-MS-Office365-Filtering-Correlation-Id: e89d9b7e-ef15-4460-d8f5-08dddac12e0d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?o84K3XVrOWJV889nxon5Aj7jb8tSVM21Lq24xr2Y+hNiapJOhrfx3XvmhnZy?=
 =?us-ascii?Q?4obQWls1cLY4nNbC+yXcJP0Xn1Ia5mDytukC1b2tRExwLq/xYIFsLdxpdMiO?=
 =?us-ascii?Q?2gN+JhAHaDVeQOVzZdeCZYJPE+X3OOn0A8uQs3tyeavaRG2aw8ZhqsT0nxsO?=
 =?us-ascii?Q?o9zhjtKY8rCWKzMy844JI+pqbYMPbTuKPLgOTMcyW9UaFf4mAUKd+eRgw3wR?=
 =?us-ascii?Q?NhVvAMObrPPLJKX+J88mungrLxIeZWGDhzAMIKPfEf+4XVmvjCh0xrzjhp+f?=
 =?us-ascii?Q?Lds79SFNhqS6QaRvVg1y4sSPi+X28YLxq6wySX1pWdBjWqTZarcStHB/rpXN?=
 =?us-ascii?Q?BEnixKMA6CV9RWKiRgwkPbw+RComEicvrx0i51XuB5QoST5SDpRuLQkRblEy?=
 =?us-ascii?Q?ukG2Go45oznS06GMZLTPZDcf1UPDo+ObatvqcNr01XCJEItMiFa0EQzAaG3m?=
 =?us-ascii?Q?yEktjlh2jVbZ76Rz/n1E69y8pVoSHMDTBOBB5QZoTRHwcOK4DbJ63mVhW3GU?=
 =?us-ascii?Q?SPS1S7lSGpTSm3JzJVPzOJ8bhWFJJW+/b0ZmGRkEVB/Es/4AK+3VyClmq1m+?=
 =?us-ascii?Q?9SwLE8am7RZdYam2nMbfDXVDZ5osx1zBvI+71nOC6TcLda+8skdB22knY05V?=
 =?us-ascii?Q?dI2sUzuW8P+sLVbKv2DkFezXORDR9XxN+KNgN5sjrEemMv4my37RBjggezYv?=
 =?us-ascii?Q?QOPZZpq1Q+ATvhbdNz/IIRsiVWYStbRhIyLGGei3xwh92U2Mds1tS0GYSrbY?=
 =?us-ascii?Q?TG8MLS4smij1DyZ4yYrCuCzTQ5COQNERagQSWlMabuw0i9qAMGeHGIpARR26?=
 =?us-ascii?Q?w1gfyKCr5xquDGuiLJ8uEBcZj5sS/ajsAs5oaw5P25Zcik9be6W1C4ipW2ha?=
 =?us-ascii?Q?c4LNYDoyFIeRJWDlebycD1+p0FVzjOze9x0dh+hjqGzkYosZnC4ipkb72ubW?=
 =?us-ascii?Q?Y7r3SfxRds1TWWuZryDYDYi9nuxDbE159QznaG7AoT+bVYS8MjdF6+gpTddn?=
 =?us-ascii?Q?qg7899x7rBSNFieUdf2Sa7XYn2JvyVsXF52JkE7VXzrAkRkQEHz1iKkmtz9l?=
 =?us-ascii?Q?p5HUalPQyXgaPDqQkBXI501hVm2MHsHFX3T9k6aT4vqyRTH+s0oTiw0H6KzH?=
 =?us-ascii?Q?nIUBXFL27dcgX0v82WPTBV504GYOSJNZn5qiHajMT5pW+nDjn9bdqUMh3lF3?=
 =?us-ascii?Q?Mv9UjGPhBPH6zhXyscI+QDM6dauizhMbqwCgTMeSbT8bZB/uKA3a/GpTb6QM?=
 =?us-ascii?Q?6hE/jrpvLmYrT1cHT7faqbIQfAPTbnEFUHpp5GH4gW0FBQNCS4/doRNOXnTc?=
 =?us-ascii?Q?S5d6s5sSdTLXq4HPKm/+i2LPrgWRBbCBgUUhG2UKbmNnz2fdB8L876hIiYnz?=
 =?us-ascii?Q?Az9xqljY2DfZPzfjA5zdrGnKyyYKvqhtNn+/UbILagyLb5JrgsozKA2TJYpK?=
 =?us-ascii?Q?RdXUZ3wM2RF9X2AHVayOGa0WTyw0sD7U3KMMuplFv9mw0cB9fRbmoDnDuN8e?=
 =?us-ascii?Q?4HNDTrdgw6ENmjkzsPIPI6UAmiW3g6AnNopK?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2025 23:28:59.1804 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e89d9b7e-ef15-4460-d8f5-08dddac12e0d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D0.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6198
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

From: Taimur Hassan <Syed.Hassan@amd.com>

This version brings along following updates:

- Fix Xorg desktop unresponsive on Replay panel
- [FW Promotion] Release 0.1.23.0
- Avoid a NULL pointer dereference
- Attach privacy screen to DRM connector
- Setup Second Stutter Watermark Implementation
- Align LSDMA commands fields
- Delete unused functions
- Optimize amdgpu_dm_atomic_commit_tail()
- Add primary plane to commits for correct VRR handling
- Refactor DPP enum for backwards compatibility.
- Add LSDMA Linear Sub Window Copy support

Acked-by: Sun peng (Leo) Li <sunpeng.li@amd.com>
Signed-off-by: Taimur Hassan <Syed.Hassan@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 29aaa38cc784..eb7019ed92b2 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -55,7 +55,7 @@ struct aux_payload;
 struct set_config_cmd_payload;
 struct dmub_notification;
 
-#define DC_VER "3.2.345"
+#define DC_VER "3.2.346"
 
 /**
  * MAX_SURFACES - representative of the upper bound of surfaces that can be piped to a single CRTC
-- 
2.43.0

