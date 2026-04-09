Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D56A8E9DE59
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Apr 2026 07:21:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 788D110E75C;
	Thu,  9 Apr 2026 07:21:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="cb8vvaif";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010066.outbound.protection.outlook.com [52.101.201.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7011510E758
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Apr 2026 07:21:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rMwdev2XVWz2HlRf2GkuZOlioQaB65JsloEVPyLYMoocgHrTJ2h4RLjGjys9XOgXDI1mWsoQ+EXl8QEffWImuBwaFjyzfiv8qQzlDsvra3fLremwKEe3l5Ae015DSQ7sUegVSLsiseXzg4lpHFIMEhrkk0jFER3S58JToFNML2YR2QxzAyJHL/eALT6AhZFoVXROJyeT2RhpTinskoi0HyHaO+puu+uhfbtnSrLpK5kw7M3ZoCLngzHzuRqsP2EUEsTSW5qH4xlIQ2/N3wKZ64d5dkcHOfmm2eTlp0M2yLgkxn55b59mNpR6rDf4USlrmV7jW8Ej2pm3EsTiOa5LYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9XRMBoDi6wfptbhr2bxevMINeDP9k2dthnSfWUnyV0Y=;
 b=KKL8Aqh23xwHz8130Eb4mG7+VK49cyNwJeY108uIjIADNMKkxyul86LzKDBl7g/R8pPrHcQQTJHt9S9E2xwGtoGac9kAlweBOV6z3AifIlkUUyVoxkEki4K3PY7Jxt1puq/pLPn8fw4hjZoi81fueXWcecR0uzadzES7P5wf7R0FZ9YDgIVCjBpbyS8yrxme15pQxvP7WKLxPVUP1KDLQQT8zUGgr5cN9ZQJKyM/3Jci2QoUIFI1OS+WO22UXm70nRl43v/ULF6ujshbUOeECPZp468SnsavsAHH1t9iKRVX5yN1fxxGXRT4IWCgqO02zeUytdhGC0Ono7A4s3l5vQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9XRMBoDi6wfptbhr2bxevMINeDP9k2dthnSfWUnyV0Y=;
 b=cb8vvaif0a1HkhdGb2FrDHdqwRZ7ZnGz+8MEA7KFGDkMe2fp1n33YRUVhu2KvO5aQt3hm6Aw0dt5v89grDf1qaYSLrFBNBxmD4GXPc6Zn884k8/3BiWP2mAhHndkdtlyJytcwx6wQTKUfm46V6Pp6bpl+Q4kh0G7HHPt5jOkw6U=
Received: from DS7PR03CA0103.namprd03.prod.outlook.com (2603:10b6:5:3b7::18)
 by DS0PR12MB6485.namprd12.prod.outlook.com (2603:10b6:8:c6::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.19; Thu, 9 Apr 2026 07:21:11 +0000
Received: from CY4PEPF0000EE36.namprd05.prod.outlook.com
 (2603:10b6:5:3b7:cafe::8f) by DS7PR03CA0103.outlook.office365.com
 (2603:10b6:5:3b7::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.33 via Frontend Transport; Thu,
 9 Apr 2026 07:21:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000EE36.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Thu, 9 Apr 2026 07:21:11 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Thu, 9 Apr
 2026 02:21:10 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 9 Apr
 2026 02:21:10 -0500
Received: from ray-Ubuntu.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Thu, 9 Apr 2026 02:21:02 -0500
From: Ray Wu <ray.wu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Ray Wu <ray.wu@amd.com>
Subject: [PATCH] drm/amd/display: fix NULL ptr deref in ISM delayed work
Date: Thu, 9 Apr 2026 15:20:41 +0800
Message-ID: <20260409072057.1133476-1-ray.wu@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: ray.wu@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE36:EE_|DS0PR12MB6485:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d5496f6-ac52-448d-03e8-08de9608938f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700016|376014|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: q0Adw6m6Vy0aC7ikiKO2aK7luyQOcAtAFH1Ds2af5IorKXoFt2tS5/wxUgE59P7Np+0sFZnfmvUjlcQniFe7BScqB07MW1tsPnrxF2lt2QNcXPWLfKuaa9clmXwNNAF82smu8hJVJWsJU5EO1RCJAcgStL0keF/y+D1zGrPNYX8Zt3HBqbNt1FkiYPeYz5WdWRCfwq1XL8Vnsx8A8E+Imj0hrldX3CW61ClrgydNxe/R9/BD7QqtxQrwvUyIY3NXafR0VwjxFQTtb9X6nN0bEiBwHAyGFZLPwJxGJrLTgfyvtn57SjKqCjDLP3w/yK1qX7fUdw4BzfZjh1vRh9LsELvw3h02UR1luQp3lF783tXX02NiSRGr/wkyGbvQcQXUOd3C5xWOmxH+8OKQvyJe5dJ8Go8yKgk9zUMG/lb6+guWfkQQXyt7/k7MPKh3I6G3ISVJz2tSetptMnnLMWbgEABGSZc5zugorcNn7ociaeL2G6rOwzD3Tt8eRFO+vL+RhtAKdOdSHgFy85XD1eeyHht6VcwNalfmKWdCbrJjJHOXHUiiPwvPluikzrBuhhbWhA6KKhblNQqUe7k3oAsOZdj0Rma6we+UY1NO/4vYghf9RkPJWC+MMhB/FIo4iPww+0C9A+lITGZqMmRLq58vToPs3G92n0sCcqqB6oROl6VYdRuIWUczfDGJDSgbahey54uSc5UQIZcXGb10Uf3g6n0PmUkw/kU8cSNjgge3F7z9UvpBJyQ9BbEa0iL0ZIiqoizi/mUQGWqYYvN/XGW3/A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: BevtSZIXw61zJyfAgQgRg4mp3fwn/dvCsguLcwvgwq8B7WNp9+v3hI57CGJgnill1doCKsKcPlLHzzhZ6RTJbp7C2shchGPzEezpSNDHeBOGllRqfEhGjwDm6ep5PkwDOTdct+joGJLkPiccK6alpeB1yIXCZzm9V8N0rhNksqbcgaHPnFJwO7c4vfyv9C9jaWQbhmnTmUVZA85wFbMVpn3F9rjLNpCfU1cX1YPhJla9aJDvgfgKiiE9aPR3h7OvEC5whk53WFQ208p3TI61tvpQAPh18OYScTQqdueSObuZQVAeoDXbZPN2rALZms89gOQSFVi1lY1Hzvzu5TYaIANkOZ5ZJLALqN89z0MiUo8FWFL+gF3bEkHu/cy1Ssk5a9EcuhhF5OLbg0M7l3jJJ/KAU3CJZXlXavurIwP/Lo8ywZKFEGbl0c3gMOA/O+/7
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2026 07:21:11.1824 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d5496f6-ac52-448d-03e8-08de9608938f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE36.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6485
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

dc_destroy() sets dm->dc to NULL before amdgpu_dm_ism_fini() is called,
leaving a window where in-flight ISM delayed work dereferences the stale
pointer. Call amdgpu_dm_ism_fini() in amdgpu_dm_fini() before dc_destroy().

Fixes: f5d0d3f3439e ("drm/amd/display: Add Idle state manager(ISM)")
Signed-off-by: Ray Wu <ray.wu@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c      | 9 +++++++++
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c | 7 ++++++-
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index bac02ea15b8a..bb79b6bed3c4 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -2236,6 +2236,8 @@ static int amdgpu_dm_early_fini(struct amdgpu_ip_block *ip_block)
 static void amdgpu_dm_fini(struct amdgpu_device *adev)
 {
 	int i;
+	struct drm_crtc *crtc;
+	struct amdgpu_crtc *acrtc;
 
 	if (adev->dm.vblank_control_workqueue) {
 		destroy_workqueue(adev->dm.vblank_control_workqueue);
@@ -2252,6 +2254,13 @@ static void amdgpu_dm_fini(struct amdgpu_device *adev)
 		adev->dm.idle_workqueue = NULL;
 	}
 
+	/* Finalize ISM for each CRTC before dc_destroy() sets dm->dc to NULL */
+	drm_for_each_crtc(crtc, adev_to_drm(adev)) {
+		acrtc = to_amdgpu_crtc(crtc);
+		amdgpu_dm_ism_fini(&acrtc->ism);
+
+	}
+
 	amdgpu_dm_destroy_drm_device(&adev->dm);
 
 #if defined(CONFIG_DRM_AMD_SECURE_DISPLAY)
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
index 26f3d513576b..de203445e084 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
@@ -459,7 +459,12 @@ static void amdgpu_dm_crtc_destroy(struct drm_crtc *crtc)
 {
 	struct amdgpu_crtc *acrtc = to_amdgpu_crtc(crtc);
 
-	amdgpu_dm_ism_fini(&acrtc->ism);
+	/*
+	 * amdgpu_dm_ism_fini() is intentionally called in amdgpu_dm_fini().
+	 * It must be called before dc_destroy() in amdgpu_dm_fini()
+	 * to avoid ISM accessing an invalid dc handle once dc is released.
+	 */
+
 	drm_crtc_cleanup(crtc);
 	kfree(crtc);
 }
-- 
2.43.0

