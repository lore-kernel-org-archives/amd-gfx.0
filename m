Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31BBDCF6499
	for <amd-gfx@archiver.kernel.org>; Mon, 30 Sep 2024 12:21:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D13C410E409;
	Mon, 30 Sep 2024 12:21:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="BxisUWCt";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2060.outbound.protection.outlook.com [40.107.244.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A829F10E409
 for <amd-gfx@lists.freedesktop.org>; Mon, 30 Sep 2024 12:21:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RS9b452MoZQYs5UXSlPOUa7C8JP+79Sw60jMM6lokt3N1JqGibVYywNC4Iyv+BzGMTGMbtLqxhHg/xZEj6EfbjRaGfuUTgiYWSaGWKDZ8HnQQuCKp705+pSZejJHkBTPmObD/cMdjGK1MQTdWgOiOQJNCN7bZ/jTol+CChK39A80OxKOHi7bSOO6z0ojheurFSE//M5GIGsJ7zZEi3nJSK2wwfRPJfQb9dIq6gEV+Zdhb9uq3dyvAPtYZkKjYoK0AcmxXN3XQ1qUMpaqsYFr/ycfjN77UlQNky3e5SSVfe3rzRZoYwxZnB6vKB9D+pJPz2uzU/wKJy8hE6MTAmYMcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wJ9wmvjL5X0cyAhXcETwEaDk/8gesvnIhUXaVA2N+U8=;
 b=j4iWpiO7rFAEVrnfubltc1RNjWQf4XpmLLyXtU9ZolVeIypo6CoBCboy7In9nA7Kh4jl3EB6SVpcpMzs4+vw+Y9Q7CfIBluYrqVCE97ouPcmePgssBjfEoVYx3FxKaGozLoDWfisyojIAbAZcta8v1Y8tIZ7NZZqBM/5jerWGTN/3IgOmVXbSmUmQMqvqvtqgV1vggzVAl6QYkn4SwLHAKHx7/ZOihHgWoQ0r4+JLEzBNxKndfvhL1j058Ch5QQ8QTHQloZ4IkA0W1umC6X4i6zeelEwdnOhLvie2VSW709QYZqmEBegzTXEnlDptE6Pa2FinrMK26Ey8dGFku/r3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wJ9wmvjL5X0cyAhXcETwEaDk/8gesvnIhUXaVA2N+U8=;
 b=BxisUWCtwl0L8o67g7ZTcrOdyie7Y0BJWJoFZC4KAzwjSifzLm4Ou51c5K38TAz9xil77lxp4eqcXUp1vYer5uPE5Szlzk3mEbbTsbkyz8tmA5wP2gvrr4EoLAiG5ZGLqZuJJZEIV0j65YvohPfVvODievIFALv//dRDuTuOAB0=
Received: from PH7P223CA0022.NAMP223.PROD.OUTLOOK.COM (2603:10b6:510:338::14)
 by MW4PR12MB5601.namprd12.prod.outlook.com (2603:10b6:303:168::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.26; Mon, 30 Sep
 2024 12:21:24 +0000
Received: from SN1PEPF00036F3D.namprd05.prod.outlook.com
 (2603:10b6:510:338:cafe::a4) by PH7P223CA0022.outlook.office365.com
 (2603:10b6:510:338::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.27 via Frontend
 Transport; Mon, 30 Sep 2024 12:21:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF00036F3D.mail.protection.outlook.com (10.167.248.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8026.11 via Frontend Transport; Mon, 30 Sep 2024 12:21:23 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 30 Sep
 2024 07:21:21 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <rajneesh.bhardwaj@amd.com>, <Feifei.Xu@amd.com>
Subject: [PATCH] drm/amdgpu: Fix logic to determine TOS reload
Date: Mon, 30 Sep 2024 17:51:03 +0530
Message-ID: <20240930122103.2918787-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F3D:EE_|MW4PR12MB5601:EE_
X-MS-Office365-Filtering-Correlation-Id: 39f76400-d5ee-4ac5-70d5-08dce14a6620
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?aejFgXVv8+fhOiLBzDq9v3gdtljO0z3xCLTjVjX4W7RDX7MKwFeGxE5JJduS?=
 =?us-ascii?Q?cck8xbrNjKOAKDf6d7s3zUneoAApEFKHyqlHnUxEutFnpTirwTdS1b50kCJZ?=
 =?us-ascii?Q?1s2+VP86VgfuHTidISoMQrRbFyNFvdDSAufK7Db9D1Wzdi2AoTYYujL+R3Zn?=
 =?us-ascii?Q?COekYkruvw9Br9+ZLWSlDIConmco8I2oSto3VuNf6uUcMHWNaKJ43ziJFGwV?=
 =?us-ascii?Q?o+0+JiKPUolMIY8/35ZD6n6FYiqp8ThPaeFa2194LJ744U6S9Mq9tlfhR5tf?=
 =?us-ascii?Q?KgdQkY+QI0/pWq016Emvl/dgi1VGqsM/LJZStoQvQgzyTSTvCzTr7HzDvwRK?=
 =?us-ascii?Q?ZwiR7zclwz7bpAJZEgo029vtAF1L+dt5XKYHAjSZRNJ/7fYcUpdqrHPQEbi6?=
 =?us-ascii?Q?T+pi6T9B8qWKKwuZs5fJDe3/FbklC4cL/HjFJ+gjekt7hH7wTY2gkABDXSsN?=
 =?us-ascii?Q?Jx8d353qIclcul8M/XR2bG/O885ctRasxzrp/uAM69pfxvoWpU8coYuiwlUH?=
 =?us-ascii?Q?yBf2ijHIR9Np4IDdkNNEjZ09e7Z5DPxKRq4u62RTOi4z4QcFTfIJkXRauFoF?=
 =?us-ascii?Q?8QU5HiauNlqAc2k7xfxO0KoAn882lObScOIX/KI8/QRUIj5WENiMKUSXkc2E?=
 =?us-ascii?Q?FG65aa++8tRTX4UkwC2iPsr5sJ8fIWUAUQWE6MC0uTVN6qm9oaUYmYkn/AXR?=
 =?us-ascii?Q?f/hIA4F7Zch0ZCan5y9MwK7S8/sNHVWDVzKk4zqrvpG0IfT9IYqsroGEY/DD?=
 =?us-ascii?Q?2xsgfUYGUelzh7p4lUXNDI66kcSRX8zxY2kdVtjgKt90rAuTLpfbeAZOmmII?=
 =?us-ascii?Q?m2RXZpZs33o/kJYHPHwf9o79IE700ft3DP3vxWxYrVQsIUWNaR05ql/zqIOQ?=
 =?us-ascii?Q?kzcbkrOY8jUK+P2h6lG41RFpZXIjCUi4STy1bt2S0XiNUwD6eMMF7Y7mAbaJ?=
 =?us-ascii?Q?l8uQTgZzUIik14lx2UQob/JIbsuAz2SgXDScGAaJU+98ldwU+PQnsSnVsmzs?=
 =?us-ascii?Q?w3uLnVyviNF98ddpsuAlvkg6dkvqvpzpHSQ2QtVk1HPnEpvMUkjKKHGobl4S?=
 =?us-ascii?Q?6owV87WWm+x8GYovLE4Rlebf8TKu2oJT2sRSsGKP2De7+o1G1eqDSPSbe2Ls?=
 =?us-ascii?Q?OftDYhf3hiLm20AAn/bzjFHIphenXQ3SsBlkrrI/q16WWf3w0Hc2dsyXPs4b?=
 =?us-ascii?Q?EEOzS1I0v8GCiQ4vyrOge2rcAU1tQVlyAN87hvKj3H+FUBxbnjzI5mWvhzWT?=
 =?us-ascii?Q?DQRMMLJ0nIZA6zof9hN70vABetj7lvaZvHhHI1xYHAwHz4wKId5hak0vayd2?=
 =?us-ascii?Q?1jlexHDrFx08DInH+XTCEhfLnOd/4Py8JNns2FLRszdHqU1dmtukbw6tM96W?=
 =?us-ascii?Q?U1Xe2bLdrjXNOBRxXE1s10LhjB70il7Ssb6XW99RwAxda6DOGOuFw6OpNQA9?=
 =?us-ascii?Q?EcOtSKXXmeXYEOWu1PAGS2VUEED9+pZp?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2024 12:21:23.6218 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 39f76400-d5ee-4ac5-70d5-08dce14a6620
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00036F3D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5601
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

Avoid comparing TOS version on APUs. On APUs driver doesn't take care of
TOS load.

Fixes: 2edc5ecbf1a9 ("drm/amdgpu: Add interface for TOS reload cases")

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 04be0fabb4f5..2a2d34fe8707 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -2295,7 +2295,7 @@ bool amdgpu_psp_tos_reload_needed(struct amdgpu_device *adev)
 {
 	struct psp_context *psp = &adev->psp;
 
-	if (amdgpu_sriov_vf(adev))
+	if (amdgpu_sriov_vf(adev) || (adev->flags & AMD_IS_APU))
 		return false;
 
 	if (psp->funcs && psp->funcs->is_reload_needed)
-- 
2.25.1

