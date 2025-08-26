Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C849DCA0FED
	for <amd-gfx@archiver.kernel.org>; Tue, 26 Aug 2025 07:47:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6BDD310E5F3;
	Tue, 26 Aug 2025 07:47:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="l82+G0SL";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2067.outbound.protection.outlook.com [40.107.212.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F0DCD10E5F3
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 Aug 2025 07:47:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C/yvSYKN9PSacZ3D2RPqHpHe1bFI43ur5UMx7cZMQ+6qQi3LdozxU6gmwvY7sYkuAyE8pF/c8WwwesgQcgmo7Afaxfu2zuiWYvdrxpQ9NIpJs6P2gjELM0rOf+SJVeIVsxn8/sd0/+edLH379ZGw5vuMvDbHudefN+yLhXDwbJYtLOFzmmcXIvvmpiyqqsu/FMxgi7uUjGt+rFn6PalyAWYGoMIRrLX9gi+5VGrguPPH0JDpD+pNTWE4J1VocJj1vFsHMwBHJ4jullRlsQLRMvjfIXJ1qaRejPnty6OiWWMW9SI+ipoJJ/LHMY3QBwKwrk6U7j1Yec0qBGQmJnbDfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9HKMiyYb3JOsHdDDafMg4Lf7cAZ/qcnO15JNGj67GLY=;
 b=iEF0Opj0EJJlO7hWfR2P2YHc/lPjZSXzumLLmks+Oa/In3HTyhhsXCghoQp+MLgVubBoC3P36J/sF3WgkL4iLaE+f5CUQ4vHrFU1JNxexLAB/pvyFOYSJB0qrqF7n+opDUp8TkMX04+cxPONUbBCNZTUU3v3DdxkMytRzcM4NgNpy+kU4Cpnrzx0lqya8W8o3DPEd2w07/g95T6ntExTpTJZeHklviaO2YcpraZe6OT+yoR2eeKmBDIlOnWNZGqPRX+cokyzaUxgVkSVKG5gFQBga9tge9T75EuZILYWS6yQtMA6LxN7+ptY8h3qCKUi7O8yyKByst7PRegkh7PxeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9HKMiyYb3JOsHdDDafMg4Lf7cAZ/qcnO15JNGj67GLY=;
 b=l82+G0SL2xRL7Jm6k+Zy35kRnq5cvWA5aYX7N7jYD3e/bMRS6Y6/Pnh9VSmvq5eHoQ2wMCpUjBuhd/nBwT/ZM2Xi1bOcfb/eS283kbLuVGyHgbdgRQSSMArCrAkZCFT77/R7rjsGOtIEZjb6NftfrI7Al/tJM63Zdx6/i1eUjpY=
Received: from BN8PR04CA0023.namprd04.prod.outlook.com (2603:10b6:408:70::36)
 by SJ2PR12MB8690.namprd12.prod.outlook.com (2603:10b6:a03:540::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.20; Tue, 26 Aug
 2025 07:47:10 +0000
Received: from BL6PEPF0002256E.namprd02.prod.outlook.com
 (2603:10b6:408:70:cafe::f8) by BN8PR04CA0023.outlook.office365.com
 (2603:10b6:408:70::36) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.20 via Frontend Transport; Tue,
 26 Aug 2025 07:47:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0002256E.mail.protection.outlook.com (10.167.249.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9052.8 via Frontend Transport; Tue, 26 Aug 2025 07:47:09 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 26 Aug
 2025 02:47:04 -0500
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>, Prike Liang
 <Prike.Liang@amd.com>
Subject: [PATCH v9 06/14] drm/amdgpu/userq: extend userq state
Date: Tue, 26 Aug 2025 15:46:38 +0800
Message-ID: <20250826074646.1775241-6-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250826074646.1775241-1-Prike.Liang@amd.com>
References: <20250826074646.1775241-1-Prike.Liang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0002256E:EE_|SJ2PR12MB8690:EE_
X-MS-Office365-Filtering-Correlation-Id: c48cd9c4-0f27-408a-04d4-08dde474c31a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?oA+zW1KtC3UUSFmd5u2OUpj8vafHC4gUcBE3TtYbcIW9JaS5VMKoscSu/jXr?=
 =?us-ascii?Q?JEJRt3ysQctHb8DAkxFoytJ+wN8fppS27yHj4oI2bUvloCQnuK3d3ZW13T+X?=
 =?us-ascii?Q?8r47Pdc4eHFWE9EYBFamhYYXUbMRIXi+oHjzSqXJP+9+Se9RaI8mjoGR4nci?=
 =?us-ascii?Q?D5InoXnbxh2gcXsjhN1A34i8IJg/LSx3n0Kf4BDwaZR/gg9e7pkQZsLS0dJ8?=
 =?us-ascii?Q?X0kQ4b+u29vr5Ehp/iQNkQmyPES4XHOdyCRAywOBzcS7EtfmDyJHny5VOM0Y?=
 =?us-ascii?Q?2JG6v/8rhKrQeW5PVT+ozT4QDsLUsdIVafDFGkecyqActSsXXhPDGFRwI+4O?=
 =?us-ascii?Q?p/ze/hbb1XCmvfdpLk3A/ybD4Di6HIc2+CHY79A9s1ZMaiGKUODSNlpOKzik?=
 =?us-ascii?Q?Y7R4X9sBpcYQ+P2C6/4Hw6tLlkOmCtO+rvg1FbT1YDsrcHLZpX9TETmfnjKM?=
 =?us-ascii?Q?tNV/0ruZLdkVRURpGKav6TA/xfbvrH+EWK8WAzuqNrosnQj+9wMCIMP+95Uq?=
 =?us-ascii?Q?AXS4Cd0J6i7hhqJfGRSNUTBWUuqzBg96pqXCbt2DIVrev52xSodbKxACUgu9?=
 =?us-ascii?Q?kATmKCyN6FR+7NdrAUU1+Sn8/WstJ/NTgEQn3xNvqWbI/br2dhJcD/vvLbka?=
 =?us-ascii?Q?+MTEbmcvYG6G4BCmKFn/MoexL2r/Nsbx4x3V63ka4vxxUCLaBxN2K4idjL/I?=
 =?us-ascii?Q?L1gchyTpzV2+aiwkAhk9ff0OL72qU1Ky7Z7Hb5+AwzzR/Ha6PqAjAroW58SI?=
 =?us-ascii?Q?lM4cBHgnxBkBzmhiiL2A2bRLl40EkNy96qYQ5sxEOlvRRAFYSWaczfuEQkDP?=
 =?us-ascii?Q?u9/lXigkhyyQsSpjs97bv2uy4a10kh1lrorGDVPlNSMwenl54yRsK35CQ32d?=
 =?us-ascii?Q?OH6anFSyL0RGl/Kb14uwCPmbrh4vtJnN7WOk5xqS+VZ4WBxIt2eNIApLKhWA?=
 =?us-ascii?Q?S9iRDzBuCCvE9WBHpVkZ96LJkbOYsFFfhhgE0K4DV8wE3t4ciQP7bxuuw/Uq?=
 =?us-ascii?Q?EftdAK9yEYHf3KMQM6vjWu+ZL5l5ISe0RYKGAg89sN4q393JfWDAFFRcMGht?=
 =?us-ascii?Q?tC69NWO8rv1lCOJFvWv3dGRH/+4oBbKSerXATrjzlXHGR0y49AAWT9NtE0LO?=
 =?us-ascii?Q?vjN9HX2tl0lVFB953INAhm7znvn9L8VDJTb3n7aPMukAmYnT9TTz9YL6cD8t?=
 =?us-ascii?Q?8vNgEvl27n7E79BRF87W0PdFQzTM56Kui7oiWdMKUwtwNAjza80zTk+B4Xqn?=
 =?us-ascii?Q?BOkpPMd9TkW/zlS+AZjQRTSVXyRFPOOuT85GjEN7kUU8eOh2GT/n6Yy14+2k?=
 =?us-ascii?Q?cnaLrZdoDm0inl/50opVIzsHOWYBsekX6yOj5agPbtrHeykrzqk26PD/ZAYK?=
 =?us-ascii?Q?I/QpN3XrlJwu7t7Yi4PCKlhaciHdv0ZHF3FmO95dRf+zknH5OOPTN2EVPgzn?=
 =?us-ascii?Q?DYPyQwCvXk5OHCGdrB11gHUBmn2xdQURlXStavR8gyCdlLKT9HjGQKybTh4K?=
 =?us-ascii?Q?Xtwa1awYHwPjKgMug2d1/bxRwh127IZoGODV?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2025 07:47:09.6612 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c48cd9c4-0f27-408a-04d4-08dde474c31a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0002256E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8690
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

Extend the userq state for identifying the
userq invalid cases, such as the IOCTL invalid
input parameter, and unmap the VA before destroying
userq.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 4 ++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h | 2 ++
 2 files changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 75b7e39ee576..b670ca8111f3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -496,6 +496,10 @@ amdgpu_userq_query_status(struct drm_file *filp, union drm_amdgpu_userq *args)
 		args->out_qs.flags |= AMDGPU_USERQ_QUERY_STATUS_FLAGS_HUNG;
 	if (queue->generation != amdgpu_vm_generation(adev, &fpriv->vm))
 		args->out_qs.flags |= AMDGPU_USERQ_QUERY_STATUS_FLAGS_VRAMLOST;
+	if (queue->state == AMDGPU_USERQ_STATE_INVALID_ARG)
+		args->out_qs.flags |= AMDGPU_USERQ_QUERY_STATUS_FLAGS_INVALID_ARG;
+	if (queue->state == AMDGPU_USERQ_STATE_INVALID_VA)
+		args->out_qs.flags |= AMDGPU_USERQ_QUERY_STATUS_FLAGS_INVALID_VA;
 
 	mutex_unlock(&uq_mgr->userq_mutex);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
index 48722936ff70..694f850d102e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
@@ -37,6 +37,8 @@ enum amdgpu_userq_state {
 	AMDGPU_USERQ_STATE_MAPPED,
 	AMDGPU_USERQ_STATE_PREEMPTED,
 	AMDGPU_USERQ_STATE_HUNG,
+	AMDGPU_USERQ_STATE_INVALID_ARG,
+	AMDGPU_USERQ_STATE_INVALID_VA,
 };
 
 struct amdgpu_mqd_prop;
-- 
2.34.1

