Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6D87C7115B
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Jun 2025 22:19:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8A7F410E968;
	Wed, 18 Jun 2025 22:19:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="WmcWKsy5";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2067.outbound.protection.outlook.com [40.107.101.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ADDAD10E96A
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Jun 2025 22:19:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B9A8XRszKoA8mj0q87ylqKkHmmdDlVyFR2/hgTnWA7ltQfIWT5mgN8dzS31cXOjVGbRrKFSqiAwa881X/wztTi+7KKgiznde/zUTtOJywgT3ASAhc05Tirh3cRcO0hJyhOkpjE8IsjATjohZgIH1HmUS7yr2xWQDVQeb9FTc2h+O+1MVCGIdoYUPWu23j4EvKCl86iIP+4U+5uYOeSwxbgxDjL4Xw14vdBMJLUvMdCjkvVN8h3EYSE8jKNP3DXXU04IHlcMXLTlUqWbRoi3DjWncOfsSJh3GuKrOSc32v9xinRDRtfQZM6G4uS0KKucTJ/BBanQ+0++JrC9L9LngFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LbprKb8OtuspBiQl+M8KI5BydfSZTUUUM19H1BR6WNo=;
 b=IMbXa3Bh4CH/1sAKI+khI5Mv9yQY+eDGfNnhO5k2aPH/LnWcbT+QQ75v+RZizslt+xqjiiR460DkMEN2jHH/gWVAdraFXfyvQKd7iG54Lm6+94eWAVenRRFPFKTHVmcnMn5QfJt2yZx6zfBpovkav0U+F5aAFsJM8+mxRd+BOt5vwsrAA4Akd/M+LMMZjcJMODs8NZMRP1HbVBFrT2m1wmEPPp8OsjUQXk9rxn7SOh3zcQQ3IuFjMk1VDUHRg6J7pUvDpE04WmdmpgbNqKDyJHgWO4MxaOCd4VmTAtgTCXKuCCFFpAd0NVhPrTX11oPwqUc7wLxlshSV/bkUL2ptng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LbprKb8OtuspBiQl+M8KI5BydfSZTUUUM19H1BR6WNo=;
 b=WmcWKsy5Qy9NpWFi10HKdyFc3ZPaxxgRLyicCSfQM2oG94QQqZmkCcBu8EtVUgsPEsmsdYPKTVhAfXL4bcbwpE20I2Yz/7TDDK77Rcj3Cb1+24m6EJhwVIChOIM5ZkTqKOwtVdDX23RHwKDcw3eDzW6R5dbWxw2kxHf4KCbT8qA=
Received: from SN7PR04CA0080.namprd04.prod.outlook.com (2603:10b6:806:121::25)
 by CY8PR12MB8315.namprd12.prod.outlook.com (2603:10b6:930:7e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.21; Wed, 18 Jun
 2025 22:19:52 +0000
Received: from SA2PEPF00003AE7.namprd02.prod.outlook.com
 (2603:10b6:806:121:cafe::3c) by SN7PR04CA0080.outlook.office365.com
 (2603:10b6:806:121::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.30 via Frontend Transport; Wed,
 18 Jun 2025 22:19:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00003AE7.mail.protection.outlook.com (10.167.248.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8857.21 via Frontend Transport; Wed, 18 Jun 2025 22:19:52 +0000
Received: from maple-stxh-linux-10.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 18 Jun 2025 17:19:51 -0500
From: Pratap Nirujogi <pratap.nirujogi@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <mlimonci@amd.com>, <lijo.lazar@amd.com>, 
 <xiaojian.du@amd.com>, <alexander.deucher@amd.com>,
 <christian.koenig@amd.com>
CC: <benjamin.chan@amd.com>, <bin.du@amd.com>, <gjorgji.rosikopulos@amd.com>, 
 <king.li@amd.com>, <dantony@amd.com>, <Phil.Jawich@amd.com>,
 Pratap Nirujogi <pratap.nirujogi@amd.com>
Subject: [PATCH 4/4] drm/amd/amdgpu: Refine isp_v4_1_1 logging
Date: Wed, 18 Jun 2025 18:17:25 -0400
Message-ID: <20250618221923.3944751-5-pratap.nirujogi@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250618221923.3944751-1-pratap.nirujogi@amd.com>
References: <20250618221923.3944751-1-pratap.nirujogi@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE7:EE_|CY8PR12MB8315:EE_
X-MS-Office365-Filtering-Correlation-Id: f5531727-6c20-482b-e101-08ddaeb63f14
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?dgmtq9q+YDamXG30f2AUHEzJ6Ti0pIL4a6W8ufVdnaX2ByUXcgT6IThU4uj1?=
 =?us-ascii?Q?3U3O4sNTfTdAro6qjLFNgp5kKWr3/Xv+mvvcCYanLR3Yc5vUlxOzsxT+3UoU?=
 =?us-ascii?Q?6bjxRIVcQN4oiJu4DFF2h5FQu6ijrf0ug+pxmatyagz2YmCNKeQea41CPtLq?=
 =?us-ascii?Q?07oVpYybbbEraLRllhYsk1KtgFEL8bOodgp07FsPC246Kc++4hst8E2O83wN?=
 =?us-ascii?Q?P+UlBB/OUW7+iMzY1wtxWT1bCIMtGzyhJVxCAdR3LQACGUIEv81neYpiX1jh?=
 =?us-ascii?Q?3MrjKgJJqe2GbxtzKYfOaaRionxulIlFQkXi3GOwb88QJEPiUQ04WiYpzWVa?=
 =?us-ascii?Q?MUwwsTbfeh+zemwhTCLb9Tkfgi+o0V7VTMiqIBa1A/SMCt25aaZ48yk5hA7P?=
 =?us-ascii?Q?i9a1xYqR828D21BdkwdZh9QxjhOrkt/q+tH+yTgCN3LygKSYSUneCmSoTEXp?=
 =?us-ascii?Q?r2U8AHyM5rK46FH+9c+t6YI4ahqDh4XFebF7SGnx7Yk3FOcPuxIXncXkVrP8?=
 =?us-ascii?Q?c5/t1QbZPCVOMRxyqbUbcQgA3+lWu2B0OS4qaKVT5R3nOlGxGON4h9+NuAsW?=
 =?us-ascii?Q?vt12E5vEs4q7yItZv0Rj89RFaE05J5txHelXb16Z4ahAMD5wwwzi42g2pSj9?=
 =?us-ascii?Q?YpTJKp6qmZjnQ/cJyosEOcS5XyLDiAsrF75c7zCd3dmyRTnTDu5TOp0BlVYg?=
 =?us-ascii?Q?3GMgS4CCRteH+i/STj+yh61vmUKAw0yZk8UQ4R23DjwP4E5OEzvLk7S3nQIb?=
 =?us-ascii?Q?P3vLGqQIBIyuorL/p0qIdkSWkPsRfWfaHBetymx/JjmTLtYHt2k8sjoFz5//?=
 =?us-ascii?Q?ITYcIKSzly9e+V3O3UNEBYc09HgbhGHF23VoQQvgu+Bx5pagq5ZQEupAd2uI?=
 =?us-ascii?Q?3TbbPehwKh5pcSltjQehtC4u2rpMHDJiHpdxptmWu1How75kDkmWH+/KTMJY?=
 =?us-ascii?Q?lGjMBgzdro0CwXdUUx+ac8FMQ2ITaO47DIuNEksZEviO4E+qQY78QnaHBeWX?=
 =?us-ascii?Q?9XN3lFZPDLdwU0BhS9zWzbKF7aNIxCQpgmqLHfnm524xdS9yMcjn3Jro0YZ0?=
 =?us-ascii?Q?aOJ6Zww1cJj4qs6HBL42yhzp1tk8gsUai2IzCrNe9Ii4KPilj6VeOtEH6/B2?=
 =?us-ascii?Q?BkLwPKQ1vuuGLIKMaf747L80q1zvcSSamM/vCjeKoFq9Ru5PsLy2jGJwDdmB?=
 =?us-ascii?Q?hMwPXeL2Fjqn7m80lZkCDaKK1W5fhKc/PzVyHzf+/CQCSXXn1Li5Y21jPK4B?=
 =?us-ascii?Q?6bQXk8Q3AljexBE98gg2iC4pPtofDSW1cM+NyDBM4Urh0homm+Yd78LRZRs4?=
 =?us-ascii?Q?9ZmvrudBxIoThu3HcT1Qo+FZfPaSecscPt9Io6CABToJ4QqEpj0ZlPo5CbIY?=
 =?us-ascii?Q?ZGxsBwMLD6TYapaxUBZYwk2nJi8RCpDH7RfPuJlwDWRm7v+PCh4+YKcGQ3dw?=
 =?us-ascii?Q?XhC6Nnw/5HItQucYtLPq9/oSlVcGf9TLQIF+s2munf8PiQU6WWPf9fqBT+yZ?=
 =?us-ascii?Q?mkN7ShLEeOj4guOXOHDMx4RvFTVHc6YH95Bq?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2025 22:19:52.1360 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f5531727-6c20-482b-e101-08ddaeb63f14
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003AE7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8315
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

Replace DRM_ERROR with drm_err function and update log
messages to drop __func__ and print return value.

Signed-off-by: Pratap Nirujogi <pratap.nirujogi@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.c | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.c b/drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.c
index 753cf3b014e2..f857796f0297 100644
--- a/drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.c
@@ -220,8 +220,7 @@ static int isp_v4_1_1_hw_init(struct amdgpu_isp *isp)
 	isp->isp_cell = kcalloc(3, sizeof(struct mfd_cell), GFP_KERNEL);
 	if (!isp->isp_cell) {
 		r = -ENOMEM;
-		drm_err(&adev->ddev,
-			"%s: isp mfd cell alloc failed\n", __func__);
+		drm_err(&adev->ddev, "isp mfd cell alloc failed (%d)\n", r);
 		goto failure;
 	}
 
@@ -231,16 +230,14 @@ static int isp_v4_1_1_hw_init(struct amdgpu_isp *isp)
 			       GFP_KERNEL);
 	if (!isp->isp_res) {
 		r = -ENOMEM;
-		drm_err(&adev->ddev,
-			"%s: isp mfd res alloc failed\n", __func__);
+		drm_err(&adev->ddev, "isp mfd resource alloc failed (%d)\n", r);
 		goto failure;
 	}
 
 	isp->isp_pdata = kzalloc(sizeof(*isp->isp_pdata), GFP_KERNEL);
 	if (!isp->isp_pdata) {
 		r = -ENOMEM;
-		drm_err(&adev->ddev,
-			"%s: isp platform data alloc failed\n", __func__);
+		drm_err(&adev->ddev, "isp platform data alloc failed (%d)\n", r);
 		goto failure;
 	}
 
@@ -278,8 +275,7 @@ static int isp_v4_1_1_hw_init(struct amdgpu_isp *isp)
 	isp->isp_i2c_res = kcalloc(1, sizeof(struct resource), GFP_KERNEL);
 	if (!isp->isp_i2c_res) {
 		r = -ENOMEM;
-		drm_err(&adev->ddev,
-			"%s: isp mfd res alloc failed\n", __func__);
+		drm_err(&adev->ddev, "isp mfd res alloc failed (%d)\n", r);
 		goto failure;
 	}
 
@@ -298,8 +294,7 @@ static int isp_v4_1_1_hw_init(struct amdgpu_isp *isp)
 	isp->isp_gpio_res = kcalloc(1, sizeof(struct resource), GFP_KERNEL);
 	if (!isp->isp_gpio_res) {
 		r = -ENOMEM;
-		drm_err(&adev->ddev,
-			"%s: isp gpio res alloc failed\n", __func__);
+		drm_err(&adev->ddev, "isp gpio resource alloc failed (%d)\n", r);
 		goto failure;
 	}
 
@@ -318,8 +313,7 @@ static int isp_v4_1_1_hw_init(struct amdgpu_isp *isp)
 	/* add only amd_isp_capture and amd_isp_i2c_designware to genpd */
 	r = mfd_add_hotplug_devices(isp->parent, isp->isp_cell, 2);
 	if (r) {
-		drm_err(&adev->ddev,
-			"%s: add mfd hotplug device failed\n", __func__);
+		drm_err(&adev->ddev, "add mfd hotplug device failed (%d)\n", r);
 		goto failure;
 	}
 
-- 
2.43.0

