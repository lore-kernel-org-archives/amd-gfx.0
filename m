Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F06D4C48297
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Feb 2024 20:07:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7F6A0112DCE;
	Tue,  6 Feb 2024 20:07:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="YO9JSkwy";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2071.outbound.protection.outlook.com [40.107.92.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EC0AE112DC8
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 Feb 2024 20:06:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LoGWpMZsqLaA2hgrqDlw4O9exs0FBPQMIseT8LFPlnC3is2iCtj+K++OEtC+wBiHeq21VZkKgAxsakuBel/NScNNXTG7/dH319Yhq+QnYL126AfstNzLSrUhxZoKm5VBq91ACbLBGblfrwHgPg02ribZLMPrMp6Bo//AkuxJ766cWVYnZkMxMHae7oHX8ghuToYZvFYEugi0GjCFs5BAl8fNCyshFz0cxct0JnrGr5lQGSDr7kuhw5dQ/PoXnqhjRkunzL2Gd3oIs068+7WyNg4RyfE+3VwWaDAlnqSOnBzJ9RK/oMZQaXPf0YvXpLwDl4nZa5i20l7Ui0SaMWmsVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZrbHM/Hzpi+WmcUHStGVfWv9wCL1Xk4yNlCcxRVRp7M=;
 b=PoIXzFzYFMVAPlSrg4bX3d12f3xGoX96ddaHxQp+7PQ310Rl9m/7YJnrE3ENrYhSYpO8rYP1jUoQGjC8iFjHnU0+Q04ZMV7OfGP7voW5tXFQ8XjNpIpCYLOtFWl1XvrukyxxusoFO4mwb4fBlhXvsHK3c/SrwrUXJo+yVsnbRPeRq0l3IefF8a284DTE7hJm9uabTcQsMGZTduMViC+xpovLNb9+yyy9hJlUjF72JvAu53oBJ4UDNYSuFo0OsWZNznaNGTonHxbxcJiHzLYIDhZhqt+Ekqep9E2Py9krUXIjqih/1Iwm/zg0Ixj9/i+k3QGurbtRx/S8jslGQPWijw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZrbHM/Hzpi+WmcUHStGVfWv9wCL1Xk4yNlCcxRVRp7M=;
 b=YO9JSkwyPPLE2ojDch+g7AFrY3gvpo1l/T02JWVRv6Q6kuo3BXKuNB+Q/gX9NzVhBgXpNfPdO/Vg5J/fID7UxGXsHYiiBjb8W67SrWeRGZ/X94Q+vta17EGr5AGEYzF/tiKv3q1Re3iYEtEj4Rk+CbJWFMrPRQ68mDyrcZBy1V4=
Received: from SN7PR04CA0186.namprd04.prod.outlook.com (2603:10b6:806:126::11)
 by CY5PR12MB6035.namprd12.prod.outlook.com (2603:10b6:930:2d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.24; Tue, 6 Feb
 2024 20:06:56 +0000
Received: from SA2PEPF0000150B.namprd04.prod.outlook.com
 (2603:10b6:806:126:cafe::14) by SN7PR04CA0186.outlook.office365.com
 (2603:10b6:806:126::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.36 via Frontend
 Transport; Tue, 6 Feb 2024 20:06:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF0000150B.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7249.19 via Frontend Transport; Tue, 6 Feb 2024 20:06:56 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Tue, 6 Feb
 2024 14:06:54 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Likun Gao <Likun.Gao@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>,
 "Alex Deucher" <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu: skip ucode bo reserve for RLC AUTOLOAD
Date: Tue, 6 Feb 2024 15:06:38 -0500
Message-ID: <20240206200639.1670753-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240206200639.1670753-1-alexander.deucher@amd.com>
References: <20240206200639.1670753-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF0000150B:EE_|CY5PR12MB6035:EE_
X-MS-Office365-Filtering-Correlation-Id: 789e5a1d-a82f-409a-b35d-08dc274f2b86
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dO3GeahnVPXwq1cpPDh9MrzIxNkoNamhNzJQx50VtII+Bi5T+ZkG42PmifLlyFxRBB+ru2F4Om1OJTDjNzqPHFNXEzZ2Z10XIMQaBLjIjVmMMdLd13g63s/Q+SlGkRtxa38xs3zFe+a9EhMTTYdCp7U0Yl9Nl2BqTJsJx6/GkNeoTyPjXqQ3J9KSS4b8+U05PwTUrcONFY0yPfCR/3ZKu54+Zj4/hm+pbmMm45PAEfOdWb1SnfpzMQzDezkOc1ny3xjQrJoH34yETsOABhThE5uYkncsY9TBDzNME3xEE2GqJEQejPYOlD+ay3G18U+XJssk92mN+pMTIVTgb+ish2dzp3n2shYe7PVllaMK4iiv+4Df/FeiJSMYXSUksZ9AC6JIfPSANRUQjofkUFRpxBz7pO3oOEoqXp9gVdUaYbjgutvDDCSxdItbpD20L5tqQa74UfWDdt9YhmdBO/ThJmd0TYJNu60/fzl2sZhyj2nZKQqCxVeHgMGDRZyVV0CO58yyPBaCaX8/fxUbFE0wGpTTRe9fvEGQiRQ6FJYFoYCp2aJzeEQgu8wQWGEzI1HM6RxIyfKY9in3aBRjCyIQfOXASZ7wuzXVTZCqhyujZYdh/2uy6u9I31J12STw3nDqhGPxrqLT4y8PmlDcCi28qCCSqLZTy8Wznh2es5sXbe7u7tFnJFcagHgjPU6QSBXOHRtiWsaSW/LRv/DTd46EAe9awM4H6yjSlHkQeFW7mQ0biRumeUrje2sfxtA+t7ucfPBi4NVfPAnxT6gTHuE1Ow==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(376002)(396003)(346002)(136003)(230922051799003)(186009)(451199024)(64100799003)(82310400011)(1800799012)(40470700004)(36840700001)(46966006)(2616005)(2906002)(336012)(1076003)(8936002)(478600001)(70586007)(6916009)(47076005)(70206006)(4326008)(426003)(5660300002)(316002)(54906003)(8676002)(7696005)(6666004)(36860700001)(82740400003)(16526019)(356005)(26005)(83380400001)(86362001)(81166007)(40460700003)(40480700001)(36756003)(41300700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2024 20:06:56.5290 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 789e5a1d-a82f-409a-b35d-08dc274f2b86
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF0000150B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6035
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

From: Likun Gao <Likun.Gao@amd.com>

Skip ucode BO reservation for backdoor RLC autoload.

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
index 3e12763e477a..afa3ac931638 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
@@ -1060,7 +1060,8 @@ static int amdgpu_ucode_patch_jt(struct amdgpu_firmware_info *ucode,
 
 int amdgpu_ucode_create_bo(struct amdgpu_device *adev)
 {
-	if (adev->firmware.load_type != AMDGPU_FW_LOAD_DIRECT) {
+	if ((adev->firmware.load_type != AMDGPU_FW_LOAD_DIRECT) &&
+	    (adev->firmware.load_type != AMDGPU_FW_LOAD_RLC_BACKDOOR_AUTO)) {
 		amdgpu_bo_create_kernel(adev, adev->firmware.fw_size, PAGE_SIZE,
 			(amdgpu_sriov_vf(adev) || adev->debug_use_vram_fw_buf) ?
 			AMDGPU_GEM_DOMAIN_VRAM : AMDGPU_GEM_DOMAIN_GTT,
-- 
2.42.0

