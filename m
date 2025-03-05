Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92C72C28B2F
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Mar 2025 20:47:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 04BD210E787;
	Wed,  5 Mar 2025 20:47:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="jahkaMH/";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2088.outbound.protection.outlook.com [40.107.223.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D05BA10E338
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Mar 2025 20:47:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hiCXZ36E0c5llm9IxYeuifRWNFIAvshDE8P1ogZtlikVL2KsiIsSBph8gtaRRIjqNmVIawDrfIAXXlgbsJxWlguGnxIVFJShTK1SQNXFd+TBdc7AwcBOK5TzDWWKPrL4lw8NnSS9GOqQdSAeAaZALY/cXJItSyxjFlVucBfH3axttlwP2kVBESgW0uVarC7CGFSUP+kaxmjQcjIPxF52v3t3x3o5hvZEa+Kb64nl206Ewp7GfSFkvf/wHgC7ADzVRJphTafKGr3zx9JLCTYfUXLj73tbyM1Is6VN2n6KNrJa9E3w7Lx9y7+PdfDoQu0Co9Iy4cLc+8yVRnzunZ00sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2smbLFVX3mg7Pu+LgPQYuIaw0JUnQw5RTKAh/9f1rI8=;
 b=wUVMxZtqp3lbqOCd7mRwzGPnLOVbjBG7ITuHB7fdgNIsiiMH0KB0YSE2wyyVvri1VSW/h24PRD95RNr/72LQHiLXtmdIU0xyC6rjKdKrPmBAttQ81FDgQ5AflAgYtUqWZ9i++plqxBMn5PTohp3WJyu1UjV0ypnmJlre4W0aD8xj/Q8bHzmWqjLpVyUGZWUYZ++2osmqQ5zo02Q0QJToaUfweDOxtZb5vCUBoqvLnvOPCWNpcBj6VGcrcuMtYFWohcL3/dVf77B1rI3FncTR/3xOtBlSFjr38c1mPD24Nz11Gdg6cc/fiVDcYZ4tbR5Cw8bGPxNXtCH1fWz0RKBdYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2smbLFVX3mg7Pu+LgPQYuIaw0JUnQw5RTKAh/9f1rI8=;
 b=jahkaMH/M+2N3rB9tU7e4ls+g3he3cZ7Uda0ZGebGMH7Q3hoYGcpio6JYiqFheBb4kmgGVLzCDfjCzVCGz3nilBDJZrI7j88//5hjlAXX36df6Hs6Dj9C/3Iof1lW+gIjBwgQ3w21FmZynMvr1j+V+RX+WAJ8DjNZA24GHBw1SE=
Received: from DM6PR17CA0019.namprd17.prod.outlook.com (2603:10b6:5:1b3::32)
 by SA1PR12MB6680.namprd12.prod.outlook.com (2603:10b6:806:253::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.16; Wed, 5 Mar
 2025 20:47:43 +0000
Received: from CY4PEPF0000E9DC.namprd05.prod.outlook.com
 (2603:10b6:5:1b3:cafe::45) by DM6PR17CA0019.outlook.office365.com
 (2603:10b6:5:1b3::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.17 via Frontend Transport; Wed,
 5 Mar 2025 20:47:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9DC.mail.protection.outlook.com (10.167.241.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8511.15 via Frontend Transport; Wed, 5 Mar 2025 20:47:43 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 5 Mar
 2025 14:47:39 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 11/11] drm/amdgpu/sdma7: add support for disable_kq
Date: Wed, 5 Mar 2025 15:47:21 -0500
Message-ID: <20250305204721.1213836-12-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250305204721.1213836-1-alexander.deucher@amd.com>
References: <20250305204721.1213836-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9DC:EE_|SA1PR12MB6680:EE_
X-MS-Office365-Filtering-Correlation-Id: 532c51a1-58bf-45e6-8126-08dd5c26fa4e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Y/t1Nra231DRZMtrWKohlCuxmcC97Y0ACdgeQ0Z3hVWjDx+9XO0QfZDpWdoQ?=
 =?us-ascii?Q?ScF8vCF6Ch5LdsXVKQXf/DL6G93Q8OVLuQvcfN1OEF3of7gB6LZp+uvaBxsd?=
 =?us-ascii?Q?XQCsOJLCBIJqOlLKiTqUNyInOspsxjNb0KRBOyK/Tqzk2858d6uYfw2G4P2O?=
 =?us-ascii?Q?ZPuZHnZBieaneyDLF+WYVnG9Q+KDGrOEDI0h/H0HEsJ7KQbpZtXYdaI5SnI8?=
 =?us-ascii?Q?GnVirmm0uQ3eOvbba5PkdrzhjawEHyG2oa0HxtHredPEN/WBUJ5Y2shcKcpy?=
 =?us-ascii?Q?J4naXr5oHhvMZsZ3BvzYPC2akvFedko8Oma/E04ELBNAywVjIW65lIItcIl5?=
 =?us-ascii?Q?3LfchncBTKNGajcnTZhpVZwEWPAd08fsVOJ0c6RghACqdOrmLo4vvkVB0kQ1?=
 =?us-ascii?Q?pVjIY2lOU/LdAQZA6ZS+BRMnc9qPmn+3OsJZvU3HUJfllqvRTNbbxh6kdbfL?=
 =?us-ascii?Q?MEm8n+yYHDk4Y0iWT9Zp5zGKLP/RRMBrADr59LV1qlwwrxco3H974Nyd5zAe?=
 =?us-ascii?Q?r9LSodAswAR36MJP07fUn0uC+1V2M+Sd6zTFcbvu7/UAOvx/zI0QbcS/5UGx?=
 =?us-ascii?Q?wiaWDO9QrrN3hr2uacZZH/SFVrW7TqJ2MbU8CzHzSY00SHAS9gyth7xCiuvu?=
 =?us-ascii?Q?di+C26HTR+PdE3Wx412Zcx5db1rNJ0/DsTyCfiQuSXehN3mzB24F5kLDY5UW?=
 =?us-ascii?Q?vkhI1vxYf/i8lGuFk9bGpYLTh3kF4H57quI0e4+y5fxSseOJ3j7wuPmnOcf1?=
 =?us-ascii?Q?hrsiXZgas3aOKwmxa1jSZ82e/AQW/DFVBnRxvjb5T/QuzniiM6mZQfI8SI8b?=
 =?us-ascii?Q?qnPYdkG6yTUOtiCFU+TgWtdvfDTaaoYVF75Ti8vFokDlGkRg30wwHoxETpen?=
 =?us-ascii?Q?6o8mxZlG36oXM5N3nhEb20/2Xs13A77Dsy7tbNVVtPu1fP9CaARF9reGmNkV?=
 =?us-ascii?Q?MiiyzuEvM4uUvj4t0aE1qy1gURyqPeQywERSv30vjXFEnwL8deZXbM6sswqN?=
 =?us-ascii?Q?bY6M2iRxQBgCzk4rvjgQ6ckIPkEliYTJd/uXIbG9XVSg2aoUgokoqM0q6U/4?=
 =?us-ascii?Q?EME+EW8yfx+fQNyeOzHoNGaqZy3z+31avp5oo0G3WBGlkLBTwJDzIcyEFY0m?=
 =?us-ascii?Q?Hv9BGLAiudilzqpe79aIvfbKybJoQbLaOUiEb+aYFfknYLQwEMNdToT7vzRo?=
 =?us-ascii?Q?meOhz50iMGzW9cXCL3amYDiRf95EpLvmnxw94CO7kk7a1rUfxs/46hu/jqXL?=
 =?us-ascii?Q?G2/f3MOqdQLBBab/nv55bfHmv4+BqeZ/RlvDT0szXCEtPtOctOAlaSxy7swl?=
 =?us-ascii?Q?jCeR/hSzfjB0WLqlD5SjSsw6xzGErnSzjCmGAv2dPhAQM0OrzQnZ2coWVABO?=
 =?us-ascii?Q?pzTENscq5RSrVmpUDHbYZrSS++u57nyOMBWhZNS8oq0zNlyOmJvURphzTTuL?=
 =?us-ascii?Q?B4hgW85lfpGhjVJowNyV2lDQc+5AbwiO0aMFiBqHHjc9zVSUbLFZcw=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2025 20:47:43.2721 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 532c51a1-58bf-45e6-8126-08dd5c26fa4e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9DC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6680
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

When the parameter is set, disable user submissions
to kernel queues.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
index 92a79296708ae..40d45f738c0a8 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
@@ -1316,6 +1316,9 @@ static int sdma_v7_0_early_init(struct amdgpu_ip_block *ip_block)
 	struct amdgpu_device *adev = ip_block->adev;
 	int r;
 
+	if (amdgpu_disable_kq == 1)
+		adev->sdma.no_user_submission = true;
+
 	r = amdgpu_sdma_init_microcode(adev, 0, true);
 	if (r) {
 		DRM_ERROR("Failed to init sdma firmware!\n");
@@ -1351,6 +1354,7 @@ static int sdma_v7_0_sw_init(struct amdgpu_ip_block *ip_block)
 		ring->ring_obj = NULL;
 		ring->use_doorbell = true;
 		ring->me = i;
+		ring->no_user_submission = adev->sdma.no_user_submission;
 
 		DRM_DEBUG("SDMA %d use_doorbell being set to: [%s]\n", i,
 				ring->use_doorbell?"true":"false");
-- 
2.48.1

