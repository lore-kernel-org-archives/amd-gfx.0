Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E84A5C3600B
	for <amd-gfx@archiver.kernel.org>; Mon, 31 Mar 2025 11:26:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8E56510E3DE;
	Mon, 31 Mar 2025 11:26:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="kcQr25IP";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2069.outbound.protection.outlook.com [40.107.244.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2C8E110E3DE
 for <amd-gfx@lists.freedesktop.org>; Mon, 31 Mar 2025 11:26:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zQ0KyJG2iuc5B/6ERWbBosfGmxKpsIGkyH934B+W38TULu2ctW5O2RRB1ZJSXj59bUPI4WMcud0XtRah2kIrjjPHh/c6KaOpMvSqcYUQrnl+nC9n2Y9NWqWgKXnZuIvDNVjtqVC8vF2pqnRzWVKAP+u1GO036ePIs5sEq8yOBivMei4PO7GHtTlGFVYlFHPseTD9TGmumVOdbjv7m5cjE0MFKS6iuZJaWrSGgN4r7FS27r6g+loI+emEPKBK6yT9vm3fPQM0UxQDK6jnJSmNmLLPwfcCMVY4n5DRU97bshbGU0xSLhS4MItEADss4UrH5o+J178bIt/FSG93yEASaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O0nL0++gHculQrdXeEJoocnBmS3toSXxlb6Hh3MiVbw=;
 b=ECgsZ7aJMCud62l9Hicumcxu8qU8yQL8vnAFIE3DSUqpJF5SRzw6tvRd1YyFDOHqqDX2O+SQBiJuFDzxm1NKFLTDzIEAiVuwqcpwVTv/9N7UccU3gsymla2j+rt9p5nrtUg9fzpTevUJF6gVbrYcgknCcmBpFCV/BBTPwZsiorLqfCEJx52lOxn4nKcF1/t0Kj1Ae/z1+s5XZ9xKmEJ7uPs8/BJcWoGkX+ojOSaDZZKz035p8HvYtEqjLghBH90tY4NvRTh9+knq4CGp5FTdp7AeSkueacdBhw2YeUH5561fGx8WBZvtqsoel0vpexTsRB290IP2zd3uvzry8hFu0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O0nL0++gHculQrdXeEJoocnBmS3toSXxlb6Hh3MiVbw=;
 b=kcQr25IPm1p3ZaYhyS8KcZxSOvznsmZMjayFf+Ytiwtv2/SDRFQBDWHv6iccMOF5d3rk9I3lJihysD0jNwlJCvgCQdYRi6j7N7UOLsgfttX++aML9AKeKQzdllg7ZkIMV2h4eKlR43jYLp8xpEPM71BSmv1APMb/6WSY53Lp208=
Received: from BY5PR13CA0026.namprd13.prod.outlook.com (2603:10b6:a03:180::39)
 by SA1PR12MB6725.namprd12.prod.outlook.com (2603:10b6:806:254::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Mon, 31 Mar
 2025 11:26:49 +0000
Received: from SJ5PEPF00000204.namprd05.prod.outlook.com
 (2603:10b6:a03:180:cafe::b0) by BY5PR13CA0026.outlook.office365.com
 (2603:10b6:a03:180::39) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8606.21 via Frontend Transport; Mon,
 31 Mar 2025 11:26:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF00000204.mail.protection.outlook.com (10.167.244.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8606.22 via Frontend Transport; Mon, 31 Mar 2025 11:26:49 +0000
Received: from amdoffice.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 31 Mar
 2025 06:26:47 -0500
From: ZhenGuo Yin <zhenguo.yin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <christian.koenig@amd.com>, <shashank.sharma@amd.com>,
 <alexander.deucher@amd.com>, ZhenGuo Yin <zhenguo.yin@amd.com>
Subject: [PATCH] drm/amdgpu: fix warning of drm_mm_clean
Date: Mon, 31 Mar 2025 19:26:34 +0800
Message-ID: <20250331112634.81008-1-zhenguo.yin@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000204:EE_|SA1PR12MB6725:EE_
X-MS-Office365-Filtering-Correlation-Id: ba5423b2-d54b-4276-449f-08dd7046edbf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|34020700016|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?SzukDJfNGwcQtVslL+vlOcV+S/oqvDE6/TD/xVymlF10ajLLAY/PNaYWkj2t?=
 =?us-ascii?Q?jFgf9bg3/MJhiSnbZ/l7WKpveOior2Sb7pYhuo/KxqE0qtRFfyID4CDQWG4/?=
 =?us-ascii?Q?kHYIM+7X4+2gz/JYvfm/uhtOiFwdVnxhXGDV/pWXCGHcjp843I1LBondXavQ?=
 =?us-ascii?Q?/KBQ7NgOwk73ir6hdvyXOYNILmbGu6Xxmka+IUNfFYnUKXoFs6Z1CDSLHklD?=
 =?us-ascii?Q?2ao2Q4BAfF2vgB2fVkSBPwcFM9DnoNBl7AQvZ+ccuBlH1KQ6u/1P2Y42QzZ/?=
 =?us-ascii?Q?t9YucKGUSehPlVTaNazBpwz2K2kqULMm7hmuQBdwsI9BaCyjNAd/fREz6LEZ?=
 =?us-ascii?Q?Rnjh09ljZ6Bg5HfjbMA85H9EA9Bw2aDI3yxMdnALBCK8elGa7s5LnWwWzmxl?=
 =?us-ascii?Q?N10gGMUnVYsuvcBpA7KhlgVzvUnSdEoFvWqn7RYRJs9ZeZHt3bprrZSlVGwz?=
 =?us-ascii?Q?TGytw6EuxtU926RyLq56GhPwv8wDFiEFmlL5BAbpQ3wRp8/D4rX/yF4G1wtX?=
 =?us-ascii?Q?NGG/GHS5Y8v69cEyP1fizBWiKTwshnM4J3uyX6YWN8aHFOdnI7KSF9pwX6p3?=
 =?us-ascii?Q?4DCQg/bUgU3IuJwUpOsnGBOigIdzDdnHtx44dPLfkFJKbxwtJ1YEAMhM0SL/?=
 =?us-ascii?Q?A5AOd1kLS5IWwtEyL5xXu4ux+sWUoI6Hxyxa6+KQTUr4DkxwjoNiV3dL4AK8?=
 =?us-ascii?Q?mdkVZ+9q2mGqj5CfOCCWA9TayqSky5IRteMlc6mDFXNBREbTiGXwgZXH6RHU?=
 =?us-ascii?Q?u3MeCsAMAbw+O+k6Jj9oy+gOetCVnY0ZdOZjhmcdDoaNz0XYgDAW4tzYTEXf?=
 =?us-ascii?Q?BkS+o7oVWQTzyVScPQi3EHd2jCV1u2dYdgZWHI9Lz7K65fwMh3Uj3nRyZ/jE?=
 =?us-ascii?Q?I96zcS+u9LfoC9Rr3Xu6tnSkK0VHDOr/Pv8BB65qFjim9eRYriXZYEx8N+Px?=
 =?us-ascii?Q?JDUZ5565ceWQ05TBBsunfC2BUo5VbocdcGt/+hvuQR0kPXbeV4ypPhdl5Fds?=
 =?us-ascii?Q?7A/2uoF/TFy2tngZMXiYLFKzT22nfn7b/yhITsSy7L8oWC7WtZcR6c5znVs8?=
 =?us-ascii?Q?rSRSm5A1HolCvtX/POzLsuzML0rs5SnUPh61jJxw0R5aDKSsZXZ+daRgGJIA?=
 =?us-ascii?Q?bUDYa1O01xiCEUu75Wl8+QQ49E0D6KkP6nKfxPWXUDqZSNcJu6Oa6TTF0hgL?=
 =?us-ascii?Q?9YYjBizPAitzqorFsF01bTt/4W5yKuMZYis3FIbyB9oGFg8aVPwYQQcA9af3?=
 =?us-ascii?Q?7esBGnjxCEfMGZc2Wy/sYZ5dSHm1V/NdFTCyuwFqmnw+3xK7h4UTNsC4Eudg?=
 =?us-ascii?Q?pZ8S6jwcs2fsSkne2o4OP7yn3bvMl9yB6caZG7+P/npn99+IbbKtR8q9BlYa?=
 =?us-ascii?Q?4I0VKIutLhQiGipeF/nuzRS5F3bmj2eILf0ZcUPReMQdG7bkZ3y4gJhf311z?=
 =?us-ascii?Q?vaWpLCbnjk1ujLFtUAGi1gL6BNhaF7ukPgqEuTV8dCeY1aLAZOkhVw=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(34020700016)(36860700013)(82310400026)(376014)(1800799024);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2025 11:26:49.3985 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ba5423b2-d54b-4276-449f-08dd7046edbf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF00000204.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6725
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

Kernel doorbell BOs needs to be freed before ttm_fini.

Fixes: 54c30d2a8def ("drm/amdgpu: create kernel doorbell pages")
Signed-off-by: ZhenGuo Yin <zhenguo.yin@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index d4b01ef00025..b49604ade6c2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4807,6 +4807,13 @@ void amdgpu_device_fini_sw(struct amdgpu_device *adev)
 	int i, idx;
 	bool px;
 
+	if (drm_dev_enter(adev_to_drm(adev), &idx)) {
+		iounmap(adev->rmmio);
+		adev->rmmio = NULL;
+		amdgpu_doorbell_fini(adev);
+		drm_dev_exit(idx);
+	}
+
 	amdgpu_device_ip_fini(adev);
 	amdgpu_fence_driver_sw_fini(adev);
 	amdgpu_ucode_release(&adev->firmware.gpu_info_fw);
@@ -4847,14 +4854,6 @@ void amdgpu_device_fini_sw(struct amdgpu_device *adev)
 	if ((adev->pdev->class >> 8) == PCI_CLASS_DISPLAY_VGA)
 		vga_client_unregister(adev->pdev);
 
-	if (drm_dev_enter(adev_to_drm(adev), &idx)) {
-
-		iounmap(adev->rmmio);
-		adev->rmmio = NULL;
-		amdgpu_doorbell_fini(adev);
-		drm_dev_exit(idx);
-	}
-
 	if (IS_ENABLED(CONFIG_PERF_EVENTS))
 		amdgpu_pmu_fini(adev);
 	if (adev->mman.discovery_bin)
-- 
2.35.1

