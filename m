Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3999FD374AD
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Dec 2025 21:49:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A50CC10EBB3;
	Fri,  5 Dec 2025 21:49:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="wsIXaWxg";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011035.outbound.protection.outlook.com [52.101.62.35])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C85EE10EBB3
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Dec 2025 21:49:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h2KGH6JbDbUGEGByO5qHeDd/XtdTaw3xbEeYuIZmpDnRdcCclj72LSIHcJm8gvzwEQ7HixOj46+AAEJmS21yonbMY/O+XNflAytZzHG1NkaMuj8ZbVzoMl8dCluJv27nE6dvIvf/SaTusY83nxpWsOUTCVPhdhuKk8mzfXi1VtTAf31M4tNTHFmH9VSPjfj8V55u9P14vMxrQtDZ+YGlNoAJuC9dvjHGbdsUH8odq55P/d4qDIWc4GQfnkI53C0tQXyLdNR7efJlhF56zqw4YQO32wFTgqOq3d3j6T6HJO8yXeg3z4uNL2LYW6wAcewux+15Or6mIB2LE+v3MnBWiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IHSQcuadxe5/20Z7vnNlbqLzmaqIMhreF1J7AejHstg=;
 b=AmYIGTNP51MBJZOaEGfrnO6TPJTFNNGw3T1TcrEAMc2q1UnGUE4R3io2W446yzhsVHUClU/ytazdz5YzFTPCFy+i/3uif47WgQKdYKQ7tJ2ti4zncuSV1sNqZDEyeX7xQny/KAfEIQJtgDn2fqz4gpifBnsyzxYC3kDp1925urmse/TygLxFKPrq2yyEu6cqjcYC7tz274LC2r2ZQ8DxUZTp4L2qMkdjsNvTSN7ROF2W1QI9EQ3LmtadPoqkdaaIdy7fg6Bzg5MqLI4M6AA1sNJELkipxI9Q/F8+pV9b2c6QZx9cAvcNq6Ghx81VH4+0NqY6Jzq1ExcOLXH8AD6Zcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IHSQcuadxe5/20Z7vnNlbqLzmaqIMhreF1J7AejHstg=;
 b=wsIXaWxgY+4peeHdR79lfNZKoax8G5IcwPbZDxtpNPlG1Ii3zck/L+61kOMIILAOwg35MpkrzTcuiQF35LngWwTx8UIKZDXFIrq/ZiXJu87s5jX3pmiQlhP7F3FrRXoz4Pj6l6wFuf7bofZIGCVYHT4rnRajndqfosPAkOB3VKM=
Received: from DM6PR03CA0009.namprd03.prod.outlook.com (2603:10b6:5:40::22) by
 SN7PR12MB6790.namprd12.prod.outlook.com (2603:10b6:806:269::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Fri, 5 Dec
 2025 21:49:41 +0000
Received: from DS1PEPF00017090.namprd03.prod.outlook.com
 (2603:10b6:5:40:cafe::80) by DM6PR03CA0009.outlook.office365.com
 (2603:10b6:5:40::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9388.12 via Frontend Transport; Fri,
 5 Dec 2025 21:49:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS1PEPF00017090.mail.protection.outlook.com (10.167.17.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.8 via Frontend Transport; Fri, 5 Dec 2025 21:49:40 +0000
Received: from tr4.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 5 Dec
 2025 15:49:39 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Hawking Zhang <Hawking.Zhang@amd.com>, Likun Gao <Likun.Gao@amd.com>,
 "Alex Deucher" <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu: Remove redundant pmfw backdoor loading
Date: Fri, 5 Dec 2025 16:49:14 -0500
Message-ID: <20251205214926.146844-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.51.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017090:EE_|SN7PR12MB6790:EE_
X-MS-Office365-Filtering-Correlation-Id: a9828bf4-2ab9-4d58-f8e8-08de34483155
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?KI60BdwuBmL3HwfTA+mmoHwsN2Prq5uUe9xurTeJWrGV1UomID07umJnUBeg?=
 =?us-ascii?Q?Es8EXw7wvBkIg1yKWEgViuusa14gt02vT2A/Y74w9/2cUA0rrOM3xjJlKFeq?=
 =?us-ascii?Q?pJ2En+v6B+7Vilr63xa8T2Mk7H585LFPLvOE/e5euLmYrQ4KQ3kgt3HsdngX?=
 =?us-ascii?Q?c0v8nowZlPcJemmpS3+fQNnMBM3dFbixbMHMIFBe4tfzRX+bnvzUYSuW5yOg?=
 =?us-ascii?Q?VwUCCkn3lSymlF8P1EPeea/iEsv3hGx5Bm9lImXB84Ok++3NUVD2IxprTAGG?=
 =?us-ascii?Q?fjZlX5oGsZmiOCDBIeo81QyTLvrJTocRRlRk/nhVa+VHHkPJ3N1Zm08D6MWf?=
 =?us-ascii?Q?18GLsk/24wfsha3zTEqEwSEZvg7esFbA2BmCrCzUbf+12TjWb0tjGG6M1o7p?=
 =?us-ascii?Q?2nHssjHZ/fNJJ6oJ9z9dITG8fREJYpKm7UuZu5SF+TUroAc9rPYkIO7ChlXC?=
 =?us-ascii?Q?NaelyAdH22BtscMVAwZ5SU8tXDzac9gW2KClZAgO9rlkUV1xQYG2bSm9wDNB?=
 =?us-ascii?Q?eRMa1RttQzMHjtzeVCFg+H473R7TWz4jS2RGHRfjuZVLGGnHJoLxMXU6lwqr?=
 =?us-ascii?Q?PUuMR1tNr/M3OAdzbGLjhydejwHwmjL976O64T1Rfj3kAi0Cd8exGkompSA4?=
 =?us-ascii?Q?DgGtcnF+nQMa4LG3pes75UTSPbh1HGpeGjOeSVLz4B9BlL3dda9OsHz3aiN7?=
 =?us-ascii?Q?il0S2MGpzZDh80GZcRCoLhFjNP5XJeS0fCS5sssE6cgrp79v2xgRtoDQYKQ7?=
 =?us-ascii?Q?PY9VTRmrY/9tOn8U0uTaFu+VVaiPYtSwOsffXTTRRw1VqGMND1N4/SqVenw6?=
 =?us-ascii?Q?TVnItK4pACsI+c3WZzTyuDiOSz0ulzgXLCNmwbfapoqrGo5G4mrI+UQgpLzP?=
 =?us-ascii?Q?85VYqv+hYdgTQFajUT17aFKRKQLz2HMZSxYdEtfp/E8CXgq2yWwhpiZXRQlt?=
 =?us-ascii?Q?GRYRisYc07p0NycqXlQDTMA8FYF+4G0vAdPHoiAEQlFoToUcd4T3CDXtfZgI?=
 =?us-ascii?Q?p93qDtI7Bv+M4Xtday/CPIDVi+bIyZOwW6hFfoePdeeCeG+TmLbp9A1DTnIZ?=
 =?us-ascii?Q?HwlqI9qOzDlafg8EG73r8UpiR86IqgRzhdgUdKNXTpfAWo3Bv8syM9cYTfCt?=
 =?us-ascii?Q?OA7fTCShGwv84+qQkIiHc05WGtskvrhtRFJ+BAoBOJTsitwH//qViASNBfJP?=
 =?us-ascii?Q?kvLdkICraDoIbpeh3G6STqPRLmnBgp133tet5nhcIytYua7VOjlF74fM04EE?=
 =?us-ascii?Q?u42fEKov7TXaNR9mtC0jlXfhrLZ2NLT2FXF0QJxxcnkwsiA8CVzCG4W72lVx?=
 =?us-ascii?Q?AoykJ6YMD+VA+aat6Acp+0NPTA1dtz5Vur6rKKdssQ5CZ5cRjX/bgisXVeDY?=
 =?us-ascii?Q?L2SRF9aYlmypKnH6Vw6g2Rr+iOY4sVoL1s6bZrSqDp9L7lYXE+xr0LUJTL7B?=
 =?us-ascii?Q?Xwa9OQSznC5w7Q+RrvoY+OaxWr/ObkWUZphPgs+t/zRXfxbQAwqbtJcaB9Wn?=
 =?us-ascii?Q?Nuo+cYJ/oglDJuJvNdY2ZS7ioAzWImR/ua+IQrXgoO1wmV/TfiY9Qd3pCMDc?=
 =?us-ascii?Q?KdzgL7AcfBmug1VSO8I=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2025 21:49:40.2400 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a9828bf4-2ab9-4d58-f8e8-08de34483155
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017090.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6790
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

PMFW is integrated into ifwi for gfx 12_1 adapter,
making PMFW backdoor loading unnecessary.

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Likun Gao <Likun.Gao@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c | 15 ---------------
 1 file changed, 15 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
index 51173d551671f..447395d36a3eb 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
@@ -2559,21 +2559,6 @@ static int gfx_v12_1_hw_init(struct amdgpu_ip_block *ip_block)
 	if (r)
 		return r;
 
-	if ((adev->firmware.load_type == AMDGPU_FW_LOAD_DIRECT ||
-	     adev->firmware.load_type == AMDGPU_FW_LOAD_RLC_BACKDOOR_AUTO) &&
-	     (amdgpu_dpm == 1)) {
-		/**
-		 * For gfx 12, rlc firmware loading relies on smu firmware is
-		 * loaded firstly, so in direct type, it has to load smc ucode
-		 * here before rlc.
-		 */
-		if (!(adev->flags & AMD_IS_APU)) {
-			r = amdgpu_pm_load_smu_firmware(adev, NULL);
-			if (r)
-				return r;
-		}
-	}
-
 	gfx_v12_1_init_golden_registers(adev);
 
 	gfx_v12_1_constants_init(adev);
-- 
2.51.1

