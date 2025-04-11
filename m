Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 201A8C369B2
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Apr 2025 14:12:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9B7DF10EBDD;
	Fri, 11 Apr 2025 14:12:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="sA9y9/tt";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2052.outbound.protection.outlook.com [40.107.220.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7119110EBD5
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Apr 2025 14:12:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CQ0h/DAMmZFIeKtfWyorDRGNJZPJOUWka13E0HS1gbLrUV0eE+KkxFFqfIZNllh1zEJu0MzRV1T14m967ij+f7YDiyD81fnsyF0lNfiIsjG8HgR5P4cDO39fvu1SC7QxS56SByQlRmES+AWclJt0lp82QQEm0ZcgwKZ/1yxUGGx7b+oP2BvaHE41j0NTIis8Erk0PlJj9mQxb9Cxbrw/yMB1Dnw5ukuBpHnKlsOv9dnJS9pS/ZLSZYn+smSxSf0LWBZzrCroH3/1LSurx/WKlep+ZyPMI1G3t/mXnNXrgfpY1nx8kNDK22qfXyIiLBNWnZ++SKxtzKnaY/UEvvTJsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fJWSN73SJ0Yxener6PDVQ3uV7YIColGpgyhGv41lWMA=;
 b=ri+VbxliAKukJSvhTqbW72y4fnSYQUzRq+JDf2ARBSIiM660tV+VByoQFPduMqcDtE+qYShJP2kCA+sZx2tDvRG9ur94kZY0RasFVLLFh5DNoZgladK4ONpclmZG9MEujwH7+uJuO4KMZZYks2kMQF1Wu36HSlVOD7vyzrWDgnfKSJIUwFvKYM0rIHn31Vp35ldi7EI93X9o/Hexve6JEOMEcW+0TRsoKGIX+Aq+UJaO8rCDD70QQXDw3mD1e/TZY+rqYVxfPup6uoEn5MCXSy7BltzYa69d/pz8eC57UwemHMteJOrfpcbQ7RtwP+WonoJqKG2pcoD//6rkAJWHQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fJWSN73SJ0Yxener6PDVQ3uV7YIColGpgyhGv41lWMA=;
 b=sA9y9/tte8EEW9HE2nYvkjcUBkAboLEhThKia4LCZfbh2xqjhxG8uS69VyEISako1sgHLJYttf/RxWkOvv+F47oFBLVyGfbM7AIJNkiJXrLuVUFtxy/F6S41KeBipGAXYgn1v+SkEjjBOEqANweOwCRRblYJ610XU75v/gQeePY=
Received: from BN9PR03CA0652.namprd03.prod.outlook.com (2603:10b6:408:13b::27)
 by SA1PR12MB7197.namprd12.prod.outlook.com (2603:10b6:806:2bd::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.32; Fri, 11 Apr
 2025 14:12:45 +0000
Received: from MN1PEPF0000F0E2.namprd04.prod.outlook.com
 (2603:10b6:408:13b:cafe::ae) by BN9PR03CA0652.outlook.office365.com
 (2603:10b6:408:13b::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.26 via Frontend Transport; Fri,
 11 Apr 2025 14:12:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000F0E2.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Fri, 11 Apr 2025 14:12:44 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 11 Apr
 2025 09:12:42 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 6/9] drm/amdgpu/userq: handle system suspend and resume
Date: Fri, 11 Apr 2025 10:12:25 -0400
Message-ID: <20250411141228.2722962-6-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250411141228.2722962-1-alexander.deucher@amd.com>
References: <20250411141228.2722962-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E2:EE_|SA1PR12MB7197:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ec973f3-0bac-48c6-759d-08dd7902ee3f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?m8MY5XkUcLPd7bOAWeaiy9ZbLXKKNVLdlFbN+iO3U2E3Xx5hxxj8yWpcRmi1?=
 =?us-ascii?Q?HpPDkOf+NsKkzsNLrn16/yF89lzKt4BaBBPwFu0cy8aMNiB5SPVo0ycB59YU?=
 =?us-ascii?Q?VUIxe2hJ7s7jwz6rImbTqIXF2RjAHNba5Bi7SAc7LoAWwhZkMRWf8r9HpSH8?=
 =?us-ascii?Q?gZ/JOEHQcOJA7jOIOiXWk6Zc1jTbR/TDEROVNXaFg02Cj5TwztD8kWa70f/A?=
 =?us-ascii?Q?f9hZKF4HdoB4sLSy2pH1Q6MCBml7DYtdT69EyM6oOZOR1tJBHjDszefWFMp0?=
 =?us-ascii?Q?shOSLAiqJhiJtRpQF7lh5CYG+v47J16vJORmVG/3zYwGeQn92AQZXPoLMyZj?=
 =?us-ascii?Q?o8RQ5K5LlQ/H1YdzjK0n3r8TVkyeziCHOp7A+dwgCSnIyq5mYtbRr34FckYW?=
 =?us-ascii?Q?Fe4SNug7asYLmhSs8QtbEX3GJSd9i6TmVY8XUCAAzzQLxOud20p1aRFIkpNZ?=
 =?us-ascii?Q?ABFNfcFdrvWN/0SpG/pecUwaiv9akKzuvQxRChoqieiJy4jqV9KYGLhyTtS3?=
 =?us-ascii?Q?93Dv4QKYdGN86iv7zRXoAZUQMJp06GLKgF+xmJz9xdH3IONKHbfVmUrEhUYj?=
 =?us-ascii?Q?ThqnbGeZn9XH/erA/jqXhvA/rRqD36eCslR+FfcJXiiWvBC93gBAFpGNOtTN?=
 =?us-ascii?Q?LVF0MZWbx1129I05VKVjqlpxz7cXi8CDzu1L+M1WoEQJxGWScuy2WUlQBbwH?=
 =?us-ascii?Q?tBintp6nk3tLXWLwdeCyY8LO+KKev1SfergHTR07pztTXLcxL+fBqsn5Mg6t?=
 =?us-ascii?Q?l3wDuAzwo3fLkOJIsf+cxBLfpe2jvVagNQNa0eAtAyxu2HCt2znf6L+Dl5mZ?=
 =?us-ascii?Q?ZZTX2ty4/VX9q+dP1cMMI9HwNsZ2VY7MDpQx4GVGvXbsRSQJbsdhtLBKF0Nf?=
 =?us-ascii?Q?pMazaQqUOg/8vYk4A0eI1W1L79kDQQ5uD0UqN66E7U7/0jXml2IEcdXYkrLs?=
 =?us-ascii?Q?qz6J0o/EiPJe5ehngookUte2zinUT/UIR7OygmhzWQ0p4PxxYAUjcjYba8eG?=
 =?us-ascii?Q?qxOYMKKovnHgVQD7P0+L6pFxTP+vIgTFlJRxE/TsQe/xW/vrnM3b9AVNCV2l?=
 =?us-ascii?Q?Jdgzi61ZGS5URE8/GlVngLOVLruxmv+0ON6ZXuWF4G66ALIQ5KUZdmyZXGbT?=
 =?us-ascii?Q?5zhREl5OreEp1Q1Oih39DEsd4dWLGc7XedNsnchg66YtLfOjLM2HHt7klEK5?=
 =?us-ascii?Q?bvPKIutwOPRYnFVNB/6J6ob9+hieWdZo3/X6Rhoc7gPnyjouPoaVftF9IFKX?=
 =?us-ascii?Q?VzhdkiErgaDWf2G7cyuUUcusyj7SzOMdHE0aGRlVl+y/U6VVW/0FTmAhZCvR?=
 =?us-ascii?Q?3qlQPmWv7OhVBTLg67MyjbgNbDC1np930XAP8nGTcOG4Hahi8qxbAGNqTO/j?=
 =?us-ascii?Q?Ex7njekrX2B8kUReEiSgwBgcFTsXB8Mk4e7XXTiMUgA+wggnmB37J84m2hiE?=
 =?us-ascii?Q?X9GZsevhBTld2jHJU84Xdp1Dt3/OYdDd7DAUIl9foHqLwkMw882uud2uqK4D?=
 =?us-ascii?Q?4oEs6pIcjvZc5s4tpwPEE2kO080QlDVv7aYG?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2025 14:12:44.9885 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ec973f3-0bac-48c6-759d-08dd7902ee3f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0E2.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7197
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

Unmap user queues on suspend and map them on resume.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index f212ce3f5d34a..e7398e70d6795 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3507,6 +3507,9 @@ static int amdgpu_device_ip_fini_early(struct amdgpu_device *adev)
 	amdgpu_device_set_cg_state(adev, AMD_CG_STATE_UNGATE);
 
 	amdgpu_amdkfd_suspend(adev, false);
+#ifdef CONFIG_DRM_AMDGPU_NAVI3X_USERQ
+	amdgpu_userq_suspend(adev);
+#endif
 
 	/* Workaround for ASICs need to disable SMC first */
 	amdgpu_device_smu_fini_early(adev);
@@ -5075,8 +5078,12 @@ int amdgpu_device_suspend(struct drm_device *dev, bool notify_clients)
 
 	amdgpu_device_ip_suspend_phase1(adev);
 
-	if (!adev->in_s0ix)
+	if (!adev->in_s0ix) {
 		amdgpu_amdkfd_suspend(adev, adev->in_runpm);
+#ifdef CONFIG_DRM_AMDGPU_NAVI3X_USERQ
+		amdgpu_userq_suspend(adev);
+#endif
+	}
 
 	r = amdgpu_device_evict_resources(adev);
 	if (r)
@@ -5143,6 +5150,11 @@ int amdgpu_device_resume(struct drm_device *dev, bool notify_clients)
 		r = amdgpu_amdkfd_resume(adev, adev->in_runpm);
 		if (r)
 			goto exit;
+#ifdef CONFIG_DRM_AMDGPU_NAVI3X_USERQ
+		r = amdgpu_userq_resume(adev);
+		if (r)
+			goto exit;
+#endif
 	}
 
 	r = amdgpu_device_ip_late_init(adev);
-- 
2.49.0

