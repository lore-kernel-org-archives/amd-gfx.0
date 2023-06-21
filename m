Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70310EB64D7
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Jun 2023 02:51:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 61FE510E3A1;
	Wed, 21 Jun 2023 02:51:31 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2044.outbound.protection.outlook.com [40.107.95.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7E88F10E3A1
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Jun 2023 02:51:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Df2vNM7Lv2nOKTgISEuTOcR9xwMbZnXyN2jTx7KgwrI/uxzh/YNJ5MonTp3cJMZHx/YcXIXQZ5ON8dzgf2aw1VxZNg6jPFIwO//u+17Q+CmPQLW5T/Kkya0sphr+dzParzAoqf3o8JcX7ugV5BR20ljNWhI7oZIM1ODfJgwBoQTP0yinnaJVLLboHhKsNYvcUdUEDsZjygFtluE0PmMxFQ69vYfvC+ZTqzUoyOHPX4qU6Sf47FPmUEPvL2KGbu+JK0llgQsi20yExZYAJZ4nNvEjSVDC6KbTsuWZnnGhfYHpwXQ/b3m67J79EDTyMTzVFbVbGhgmNNz03lUQZYzQvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YKitTkBwCZ6ZLZuvTVkk1j2p/abggpCIYQoZbhUjXHI=;
 b=e6mc7ZWgPH+PW2a86EAT+HH+4sFCNIU7T3qj9/jJOvB4LoHho/5KbYig679voLP4aBGSVcF4Uo7h1U4XOzmzNOWh/7vi/B3K8kSVbmYtYf9LukgO5i+jXM/HywJw4smKLL4Pg9ub8b/N5qdGaFygvodaf8avCkNBLm8xvOxDzLtRwtLogIH7ATK9v/VExU/QAURVJGSmRVJnBl+f68fUnPl9nHRZ6CEd/oBX9D0Ds20+vO9n4MxuEn5ReTfuoz5e9Mx9mKpg0ZEx+l4oEVADFXStdGbsv4+W8vBftLajgdiXx4cOzdMwEURpKXVHMqmbKIXFsPtkjrjyDso5rZVOmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YKitTkBwCZ6ZLZuvTVkk1j2p/abggpCIYQoZbhUjXHI=;
 b=faIeLLVlM84pTuFk+t5SeUHBuWLemCwBlu+BnM8SOM/krvrtG18iuD1Z+dvU27sIJpMRqYds4D8g4ZYYlKXOpkS37L2tn24oZxqZGqZCWeRo29mXYcaCtxl85y8s3P1Srm8gFYbRGSOttPaOURmGYsKEvUP0jxN2ChzO/fSxdFM=
Received: from SN7PR18CA0003.namprd18.prod.outlook.com (2603:10b6:806:f3::23)
 by DM6PR12MB4942.namprd12.prod.outlook.com (2603:10b6:5:1be::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.37; Wed, 21 Jun
 2023 02:51:27 +0000
Received: from SA2PEPF00001505.namprd04.prod.outlook.com
 (2603:10b6:806:f3:cafe::fe) by SN7PR18CA0003.outlook.office365.com
 (2603:10b6:806:f3::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.21 via Frontend
 Transport; Wed, 21 Jun 2023 02:51:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00001505.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6521.17 via Frontend Transport; Wed, 21 Jun 2023 02:51:26 +0000
Received: from TRX40-1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Tue, 20 Jun
 2023 21:51:24 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: Aurabindo Pillai <aurabindo.pillai@amd.com>, Rodrigo Siqueira
 <Rodrigo.Siqueira@amd.com>, Alex Deucher <alexander.deucher@amd.com>, "Harry
 Wentland" <harry.wentland@amd.com>
Subject: [PATCH v2] drm/amd/display: Remove else after return in
 'dm_crtc_get_scanoutpos()'
Date: Wed, 21 Jun 2023 08:21:09 +0530
Message-ID: <20230621025109.391331-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001505:EE_|DM6PR12MB4942:EE_
X-MS-Office365-Filtering-Correlation-Id: e361316c-75cc-435d-45c7-08db7202681a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 052c1RFqDeVBZNpo/nedGxp+cL5T7oKtsZPv8pJvoblNJT3s2sexUOeVYW9hAIY8fipMVL3JtqvTsXAFIk3FGXcCU84VCx0MJ57JnDEMJdBXu1R1trH/DZmpfuv3W7xxEd0m0lvqzXq70xvBEfRbjymELsFbt2UPmt79ymcALuR2XkDyI7KJ56GHK3Mhuy1L8ZGhKbYNT12QpKZc19i5NM77JGYmbUx9DXL2QOl6Bq1y1oSD4Cim3PloCDWY2oFd32BM5g+7fFVgc9YWlWeTo04RoqIWu/z2R1rsZKhZTweAN1LsedDZb80mG3J+c0LIfOgmPJvVqno6LeZ+oJLnzGGYApjSCGP9Nuehf4/uHLkU/rF9aKyGC/Q3DYMdaKZYATpF+aXKI65q72bcOEya33VmqrSnJ+FmDQ2St8yd+ltWQLPj00ugc/WlGTwZhPX8e/mZKVD6HMtFS9BRkOFDSHKVvsaWHg0xoCVcZc4NN9syRVtPYUR/GpsMqKV2wZwWw7H49cmX/eYxWPCdGCIEaQhbJcwcOrE+Mht5mGKcGCDKVWxkdNFVcZPfwVyKZjHPgCSTiMSEWtHkW0GCA9srJpOPilGFVRFyKjXY+dNBv4+AI8lBZiii5loqri5lJgDhKyN7hu0kFpbipF7Yq4WDNAMRneziX3ePHZHGbQKNp/3HKZvvA98rgWGgsbkwuptYa6/BjUuonEoi/MxZCb7dg0niW4JKSC4an2im25uwOltO0b422uC3Qn0xj0nExui4329yjcV6atB07aAN4asKGQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(136003)(376002)(396003)(39860400002)(451199021)(40470700004)(46966006)(36840700001)(186003)(1076003)(16526019)(26005)(82740400003)(36860700001)(40460700003)(40480700001)(2616005)(47076005)(81166007)(356005)(8676002)(426003)(83380400001)(336012)(478600001)(4326008)(41300700001)(6636002)(70206006)(70586007)(36756003)(82310400005)(316002)(110136005)(54906003)(8936002)(7696005)(44832011)(86362001)(6666004)(2906002)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2023 02:51:26.4485 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e361316c-75cc-435d-45c7-08db7202681a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00001505.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4942
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
Cc: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Conform to Linux kernel coding style.

Reported by checkpatch:

WARNING: else is not generally useful after a break or return

Expressions under 'else' branch in function 'dm_crtc_get_scanoutpos' are
executed whenever the expression in 'if' is False. Otherwise, return
from function occurs. Therefore, there is no need in 'else', and it has
been removed.

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Harry Wentland <harry.wentland@amd.com>
Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 38 +++++++++----------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 2446529c329a..a2048ffbbdb6 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -264,32 +264,32 @@ static int dm_crtc_get_scanoutpos(struct amdgpu_device *adev, int crtc,
 				  u32 *vbl, u32 *position)
 {
 	u32 v_blank_start, v_blank_end, h_position, v_position;
+	struct amdgpu_crtc *acrtc = NULL;
 
 	if ((crtc < 0) || (crtc >= adev->mode_info.num_crtc))
 		return -EINVAL;
-	else {
-		struct amdgpu_crtc *acrtc = adev->mode_info.crtcs[crtc];
-
-		if (acrtc->dm_irq_params.stream ==  NULL) {
-			DRM_ERROR("dc_stream_state is NULL for crtc '%d'!\n",
-				  crtc);
-			return 0;
-		}
 
-		/*
-		 * TODO rework base driver to use values directly.
-		 * for now parse it back into reg-format
-		 */
-		dc_stream_get_scanoutpos(acrtc->dm_irq_params.stream,
-					 &v_blank_start,
-					 &v_blank_end,
-					 &h_position,
-					 &v_position);
+	acrtc = adev->mode_info.crtcs[crtc];
 
-		*position = v_position | (h_position << 16);
-		*vbl = v_blank_start | (v_blank_end << 16);
+	if (!acrtc->dm_irq_params.stream) {
+		DRM_ERROR("dc_stream_state is NULL for crtc '%d'!\n",
+			  crtc);
+		return 0;
 	}
 
+	/*
+	 * TODO rework base driver to use values directly.
+	 * for now parse it back into reg-format
+	 */
+	dc_stream_get_scanoutpos(acrtc->dm_irq_params.stream,
+				 &v_blank_start,
+				 &v_blank_end,
+				 &h_position,
+				 &v_position);
+
+	*position = v_position | (h_position << 16);
+	*vbl = v_blank_start | (v_blank_end << 16);
+
 	return 0;
 }
 
-- 
2.25.1

