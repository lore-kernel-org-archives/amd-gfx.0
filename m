Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C0A4C43334
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Jun 2022 14:16:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8FD2C10F193;
	Wed, 29 Jun 2022 14:16:17 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2052.outbound.protection.outlook.com [40.107.94.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 152E610F177
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Jun 2022 14:16:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YTJpdKTJWKFdu9mxgReUlxqnCzkm0dCm5Xwy19ttEWRY8ykMmMJoR8G4T0WX73eSdXwyCIrBaopTI6KmHZ5OqvB12ykBKfQFaGdfvDx1evP8boBj/mw0A2/46P3izyIEi2fvIzqYXsQq06S9wZiGMesSTt4rm3mDLGPBQRZEphwQ5uFF1ozZKomSyFbTRgp0su0Xt+RIXa19UJdy4zyHJlRdeI9RwqE4jLfxzjAZOw29onLuFjq6mV63WkHeDprO9+QadVjErMGjtOo5PlCEGSXRf3+m+dp4P/1+hV6mkDk2SnfseYEEjzvP71bE3knw9km9ytNoa1Yqrp788QI6zA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q0lH2gYQ3c99KPZIs27XR15eqp1tBwgn2q5JMpH8TNw=;
 b=DRVyTfXV8Xh18WXRXLAvE5DrscRPzRBL09el2WNfgG9sknbYRzZRh9+13fV8D+SyiTO9l5UMKbOu1jO7pzdu+tWQB8klmFldx1tgw7gikQFzKc9/cH9nQ4LcVdSDLI+q6qfd8MksXtDJp7SPX6UgTswAg1m3+IJSRx7LkcCpj5uUDwk76Ewpw6HBE+Ws3a4+TshD7H6DSHRVIfArd98/ddhUfellP7WPnl1oZ315Ukzv5jQlrk+kOIZZRmzQI6GJJwweUhr4qcun8B4Li1M9ayefMjJOVgrcPhtSp9ZWIHgSx32lBFsxd/CB5zJZD68YIjFV45PUlkw37AyOxzqnwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q0lH2gYQ3c99KPZIs27XR15eqp1tBwgn2q5JMpH8TNw=;
 b=Fcim7Ts1fXHdHYuDLI2jAMDTorJliSTgkWamr4f2gsjxOG8CMOsUSWxReoEfG6Fzc9/zF6alLEB2cg/dL6KLwh3xXDVyP/qBsFH4KPnj7h7ZDqlK+M8Fkr/bBGHEInVo3i7R06Jd1YpQazKTIMsLBOyX+QSpAK1HwdxkM2UvKIc=
Received: from DS7PR05CA0078.namprd05.prod.outlook.com (2603:10b6:8:57::24) by
 SA0PR12MB4367.namprd12.prod.outlook.com (2603:10b6:806:94::13) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5373.17; Wed, 29 Jun 2022 14:16:13 +0000
Received: from DM6NAM11FT029.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:57:cafe::ee) by DS7PR05CA0078.outlook.office365.com
 (2603:10b6:8:57::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.6 via Frontend
 Transport; Wed, 29 Jun 2022 14:16:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT029.mail.protection.outlook.com (10.13.173.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5373.15 via Frontend Transport; Wed, 29 Jun 2022 14:16:12 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 29 Jun
 2022 09:15:41 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/2] drm/amdgpu: keep fbdev buffers pinned during suspend
Date: Wed, 29 Jun 2022 10:15:29 -0400
Message-ID: <20220629141530.2501360-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8518ae30-e607-449b-9f96-08da59d9ec11
X-MS-TrafficTypeDiagnostic: SA0PR12MB4367:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lYAo68N8WHTCg4NLY0XI0MAimCf+fWlnRVBgQp/qKkDzrjettrof7BUB6hnavcsH04d1cIOQVci4Uqb1wiGYatat65zffHP1TUjJ8EtJexgpf3QlU0HttpDI9uNSryCaGqSJshMaps8ysE5nCHTkhnuuw1aPOzYfnDIZUH6r2OB2KgCNeQR3MnZyTTHJ0d2l+tm0XuK3H0xJ//O0F8ofF1GSMIhtFTaN7K7L8mnCuPjY+jmifrPioe79ru6wknGT81+tZ86D9EgwFMTVO3eKRouC1nynarZNdS3TO9DJs3eMxpRBsIXWDGsc98LF5NyJJbjBpUlIW2WI0wiFjTXIydKwysdSIoFa4DjqUo4RwBiiDrxcLj8cbccaCQHmQZNzfPcdTYoDHTj+XU9+ehG3O98NsBoQK4S+BmSS0O1+QDAzzD5xYSaF+FZIOYDBr9jbm7CPmnXHogHcK52W/6wVxf4ExQOcTNiB2e7Ss+U/RhwSrgdqM3fo+4aQvNifjPYADjwP2lQ6HegpAFYVnY9bgTDfvxe0jG8iRv39rUOxo9F8emtMadY65yyNXFB81a2KdOqSXFeGaY3HSh0nQQiBeF4kHZqF5lf51KxXIhwpWKJsleaYn7HUrt43sNx2Q4mhv0TNA5lFhfPLyN3GeK3qpMgztxYAupFsf14/yWkThaNBzyyx0AiqLfBst2VNkAav6mmEIzKDZTiaD9UJl+4g5nPxV+8efXY4lHMzjhSb7YLUaxTKIKCOLX9NZX2RjncVMEGuyCVkNLlIAzukd8NfUjjbm+Wbu5E33GlaW2lJO0gLqWspc7Z/DTtcMGpxAIyZ/urxA59wc8hdG2dHdNG2+Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(376002)(396003)(136003)(39860400002)(346002)(36840700001)(46966006)(40470700004)(86362001)(83380400001)(6916009)(70586007)(316002)(478600001)(5660300002)(36860700001)(41300700001)(6666004)(70206006)(47076005)(4326008)(82310400005)(426003)(40480700001)(8676002)(336012)(40460700003)(7696005)(2906002)(8936002)(186003)(26005)(356005)(2616005)(36756003)(16526019)(82740400003)(1076003)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2022 14:16:12.8762 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8518ae30-e607-449b-9f96-08da59d9ec11
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT029.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4367
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Was dropped when we converted to the generic helpers.

Fixes: 087451f372bf ("drm/amdgpu: use generic fb helpers instead of setting up AMD own's.")
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_display.c | 25 +++++++++++++++++----
 1 file changed, 21 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
index 8ef489fad707..a2e62d9405e7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
@@ -1560,6 +1560,21 @@ bool amdgpu_crtc_get_scanout_position(struct drm_crtc *crtc,
 						  stime, etime, mode);
 }
 
+static bool
+amdgpu_display_robj_is_fb(struct amdgpu_device *adev, struct amdgpu_bo *robj)
+{
+	struct drm_device *dev = adev_to_drm(adev);
+	struct drm_fb_helper *fb_helper = dev->fb_helper;
+
+	if (!fb_helper || !fb_helper->buffer)
+		return false;
+
+	if (gem_to_amdgpu_bo(fb_helper->buffer->gem) != robj)
+		return false;
+
+	return true;
+}
+
 int amdgpu_display_suspend_helper(struct amdgpu_device *adev)
 {
 	struct drm_device *dev = adev_to_drm(adev);
@@ -1595,10 +1610,12 @@ int amdgpu_display_suspend_helper(struct amdgpu_device *adev)
 			continue;
 		}
 		robj = gem_to_amdgpu_bo(fb->obj[0]);
-		r = amdgpu_bo_reserve(robj, true);
-		if (r == 0) {
-			amdgpu_bo_unpin(robj);
-			amdgpu_bo_unreserve(robj);
+		if (!amdgpu_display_robj_is_fb(adev, robj)) {
+			r = amdgpu_bo_reserve(robj, true);
+			if (r == 0) {
+				amdgpu_bo_unpin(robj);
+				amdgpu_bo_unreserve(robj);
+			}
 		}
 	}
 	return 0;
-- 
2.35.3

