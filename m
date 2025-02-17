Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 848A2C021A0
	for <amd-gfx@archiver.kernel.org>; Mon, 17 Feb 2025 05:15:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E2A1D10E307;
	Mon, 17 Feb 2025 05:15:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="U6hooLZl";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2059.outbound.protection.outlook.com [40.107.237.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 24F0810E237
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 Feb 2025 05:15:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gm+pBg0p2liu0YC6GEWvCenA3gqmX8triEUOxSEUUHIV+kFaZJAFkD5PlgUv0lgWIrgMKspa+pZrfvv2cwFgNsY7ccmxESLk6EeI1qlnECEqgpI3Q4c8YYQsLOl6qJSssPealTxpIsOd4fIKYGPyu+aU/NPstdaKHvPb2wtuEkDFDckpjGCoZKsu2cNJSoVOh/jwdOf6lehJqj/j38NbJqCgQvWpoPPR9CQ9CxckuPhgQWh0mKkDCwC3gtInyF0Wcr1aqOs2xfCdTkqPSdabZDgOeYpLIS+ogdS0qPrOU6uCNh5KzhQLDicBzZ3S6JpGKNg6mapM8F232JCZLVrGCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o0Fu895VNzB/3jFzvh1sHFOAQMZNA29DHG1ZwlL5d/I=;
 b=gxDTsIBPQPapMDTXkclYiMugIaxtYOydiNrFvVjrcgWWrn/chBs/y0fXQ+tEGqUuDITBFrvGc8KmxIPQXIrtkVWYHQtObcAZgdvgISMYtxmuO+Br6qNFsuDve3NAvLmje2DTQGLsnDqGmoqvzJZV7dLKfVlzxQ9ygO5JVSn4023hmV/f7gtuvUo4Gt4QPX+FBsSJhu6e/EPbGw4ngHnw6aTAIGEdVAdTL79WOWpghYlHGcGjUSMwiffwjpSM1FLXeOPk+JWexYeRbxhd95CHId7I0ngtxJvFch2W0jGJpFa3YtfzTRQF1y1iUGn86YgMMkwHnCSCsoqZaZqx63dPZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o0Fu895VNzB/3jFzvh1sHFOAQMZNA29DHG1ZwlL5d/I=;
 b=U6hooLZljZVZpmnGeuh1Eu+hFLox7iGW60MpTw7BCgrrpKHCEP1mYEXV3bn4IvQttNKqfMUhzG4ZvwJIivUIdahJ+imFpGZi93seKE1vYA8xMSwBz6nyLV3Uzm0kf8D0v+ytpyubxhdQ4zfTS4KNJzw0RvzztoLMr4Qcjp6kILY=
Received: from DM6PR04CA0025.namprd04.prod.outlook.com (2603:10b6:5:334::30)
 by CY5PR12MB6250.namprd12.prod.outlook.com (2603:10b6:930:22::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Mon, 17 Feb
 2025 05:15:29 +0000
Received: from DS1PEPF00017094.namprd03.prod.outlook.com
 (2603:10b6:5:334:cafe::97) by DM6PR04CA0025.outlook.office365.com
 (2603:10b6:5:334::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8445.19 via Frontend Transport; Mon,
 17 Feb 2025 05:15:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF00017094.mail.protection.outlook.com (10.167.17.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8466.11 via Frontend Transport; Mon, 17 Feb 2025 05:15:29 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 16 Feb
 2025 23:14:59 -0600
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>, <Le.Ma@amd.com>
Subject: [PATCH] drm/amdgpu: Remove redundant logic in GC v9.4.3
Date: Mon, 17 Feb 2025 10:44:35 +0530
Message-ID: <20250217051435.10996-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017094:EE_|CY5PR12MB6250:EE_
X-MS-Office365-Filtering-Correlation-Id: ea47c788-a0ae-4bba-68b6-08dd4f121867
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?phnEDqVXpbe6qQPJEpV0YCKTSbWHacPSDxmpsmUbUYMEF61x0gfYjZO2SAqp?=
 =?us-ascii?Q?D1NyLAnPITi/isCAy6LKfcjdarFYgHNTzhWKwMVVX99j+Frqkbyp6JRiJ6tg?=
 =?us-ascii?Q?LSiPhzU36GzBJz/YvjD1Ln5xcnqS9spJuWrTgywc8s8M1CW/w/VSNXtQl2wj?=
 =?us-ascii?Q?i/5/kLTcT6Uu7CvkAeQIefjHGkTvsZjAH4O4umdrLwhWEx66Mi0Onmq2jGO0?=
 =?us-ascii?Q?mEjUjHVKYPv1C635dKloHQZhvlHJHLKY4JYBC42/Jp9PWOnOwyTg6Bue8UUW?=
 =?us-ascii?Q?AhJDdbU9TLupITLreMz+ggPt0QvQSZ1a9bAvFYswssYVIuxQ7E6+v3Vy6DqU?=
 =?us-ascii?Q?H6RhIg2Tmb9EQiqpsDvfr2fuhJCbx3wI+d7A0Y3yCA1KzqC2osFOYk7XaOaQ?=
 =?us-ascii?Q?coCx1FDbQQTkPW1jb4h2mYopbp33KNNOM5yGdFRUjw+2e+zpqmEGlNFcSOP9?=
 =?us-ascii?Q?5j2juSub8LwP9Ym9Sc/5l7xCMbAn9WJ/2OWH+rPLFwKKIkwPvEx++mrYvwc9?=
 =?us-ascii?Q?QrFUNLwfiXtWZTP689uPMEOXBxk2mIrmNBKkRkhGFoDSk4agZlqUwcBPFTYT?=
 =?us-ascii?Q?4LYQaU2HxYZArdIdCE6YDxew7zoAP9dqmuEGHRKtf1bf+hboBw7msYVb23vd?=
 =?us-ascii?Q?R4ez5pIadSPKQzVcY80mQfLzD/rw/t0h5MdbikpSeYJM+qBY3CvJwP9h37Y+?=
 =?us-ascii?Q?2yMGsgOtioSfpS9hUAQk/1gyfsQvmMKhxdOTCIfB+Fpz6RHkx89m2FJB+Qn0?=
 =?us-ascii?Q?nUQ5wu+x1i4gGb6KdaxA76r1ZUNRcO3GRLNKtR0zjOKj6XsupMFlsppddQGW?=
 =?us-ascii?Q?3Ojpj7klBVy93j43UWw8jlzgcVF8ygBM7N1WrRC1wyHPmgJ2sWF9KftYpsT9?=
 =?us-ascii?Q?kB0zz9HiZ8WGw1/47ZjQFfpNXStgV3Nt6j67oDrKfXd2M63gozRPti6AyNa9?=
 =?us-ascii?Q?5SHQid63S3SxlP+xWhWa+0L3dSwYyE2LGa45S+cvDZU10GqJTpVWuk3dC1dY?=
 =?us-ascii?Q?2dDMhvnbqTvQN5yAXJiUoXDuFnz1al8Q/CQJ9lWbsoz439ieHS9oojl4KGHu?=
 =?us-ascii?Q?u0wTlgNJ4uQ17R84WvWK0pA8vrHk27YzjlzWuI6C+D9ozjCNWFuuEk81cox9?=
 =?us-ascii?Q?QdXyGqUt98TSx95mvPxJM3zjSOrGTEjbb/8NG9thBVRge7kgHD743cEKrTJg?=
 =?us-ascii?Q?LJBMQg9F15JHUbWRp3kSeRlNGqmfvfS9Ok/YpcW0Xco6agojQC+tDAXILdww?=
 =?us-ascii?Q?LyHNBNq+aXZbNMYDJR04gMcx0+IYFbxCTi1G4mOyRpY4ecCtpOlAM3LPhHve?=
 =?us-ascii?Q?2ECFdfWzW5r52AoTaJgZw6JebNUG+ReKEefpxELP3UuP4+vw36R2BP4ugeo1?=
 =?us-ascii?Q?nwDpGpnb/yHlMlyz6nUYLqIZv3eaZp7JL+HPPEeXHHgzDLSrNEWnW0y64ulk?=
 =?us-ascii?Q?Qf7EzDqhzyLVxs5+gvH0tsbLXyql0OWsV3oQwcLJTtS9RGSx0mVaSo/AFJ/Y?=
 =?us-ascii?Q?olrKqgexnIKB7vY=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2025 05:15:29.2820 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ea47c788-a0ae-4bba-68b6-08dd4f121867
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017094.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6250
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

GFXOFF check is not need for GC v9.4.3. Also, save/restore list is
available by default.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c | 17 +----------------
 1 file changed, 1 insertion(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index f4635fc8a7ca..f1d6f4b92e99 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -563,17 +563,6 @@ static int gfx_v9_4_3_init_rlc_microcode(struct amdgpu_device *adev,
 	return err;
 }
 
-static bool gfx_v9_4_3_should_disable_gfxoff(struct pci_dev *pdev)
-{
-	return true;
-}
-
-static void gfx_v9_4_3_check_if_need_gfxoff(struct amdgpu_device *adev)
-{
-	if (gfx_v9_4_3_should_disable_gfxoff(adev->pdev))
-		adev->pm.pp_feature &= ~PP_GFXOFF_MASK;
-}
-
 static int gfx_v9_4_3_init_cp_compute_microcode(struct amdgpu_device *adev,
 					  const char *chip_name)
 {
@@ -600,8 +589,6 @@ static int gfx_v9_4_3_init_cp_compute_microcode(struct amdgpu_device *adev,
 	adev->gfx.mec2_fw_version = adev->gfx.mec_fw_version;
 	adev->gfx.mec2_feature_version = adev->gfx.mec_feature_version;
 
-	gfx_v9_4_3_check_if_need_gfxoff(adev);
-
 out:
 	if (err)
 		amdgpu_ucode_release(&adev->gfx.mec_fw);
@@ -1360,10 +1347,8 @@ static void gfx_v9_4_3_xcc_init_pg(struct amdgpu_device *adev, int xcc_id)
 {
 	/*
 	 * Rlc save restore list is workable since v2_1.
-	 * And it's needed by gfxoff feature.
 	 */
-	if (adev->gfx.rlc.is_rlc_v2_1)
-		gfx_v9_4_3_xcc_enable_save_restore_machine(adev, xcc_id);
+	gfx_v9_4_3_xcc_enable_save_restore_machine(adev, xcc_id);
 }
 
 static void gfx_v9_4_3_xcc_disable_gpa_mode(struct amdgpu_device *adev, int xcc_id)
-- 
2.25.1

