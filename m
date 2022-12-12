Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89D2FC4332F
	for <amd-gfx@archiver.kernel.org>; Mon, 12 Dec 2022 12:40:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 98DED10E040;
	Mon, 12 Dec 2022 12:40:52 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2045.outbound.protection.outlook.com [40.107.212.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 21E5510E040
 for <amd-gfx@lists.freedesktop.org>; Mon, 12 Dec 2022 12:40:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CLR3xZhzqD2qq0qp8IC5tPQ9DHrnazD5M7bAmP24fJck6vZFvzkSt+RGUwdj5+dbUPIWksun8HpZG5D7YFwFygnnxXmoCEFEFzhCdhMYwlSftTf0zi6gJrMfbr6UnOfLOl/MX2FScrE8Rjn0/vkHTqLr7L9gpjh9UovddVdnkFpSgG6VtuHG0+u36+EDLf0Du4HqEIhuwAzKjQxk7mzDps7ZBJWEboGesj2H2KVEjFYe2CIehkvGIk/ty2r3MHek6cALcJdJpWNAZfa0j8OxgJ2T1PULe+j+QaJx+tZuuipkQnHuutRbU+e8vpCYgwMHsshR+zGE5HwlCe8bPg4r7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zTgpapYPH1Vo/Mu1K7O421MlZ1yC/x6JnDFOcLg4RAA=;
 b=IdsEwd9ryTtWbbQH76l8o+HOimPqfMNKbw6X/us6Flhf1QiPDUb6ZujgSEb+qLNosrT52BLSQruQFz2uS3mJMX0O69gXwIRASqlB0lUG2UsEbJ5UgyIqXMdV+JQ+MzPw43brbMM/XS/pZYBK7O7BXqRxl54t+iz+97S5vbsroC+YqOPQokKYWVQruPSB59claBWU5SG0h39ygzommi4AaYCY41u3MALiAiYwt26/xRlMkrMjARl1hSxj1i2xNFbKsPMlR06R8dCRGAjOj22UtSIpS5S7Kk6/R/MBeFS5cX1yGxGXcrGO3/TiFaxNeBt7cQHyHFruBhVYMY3pMzBykA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zTgpapYPH1Vo/Mu1K7O421MlZ1yC/x6JnDFOcLg4RAA=;
 b=F3xd9n5q7o+aE2FfD3T9U+G9s6lvtjNAgmPaOEXbuDvzaaJ8bnk7V8GDKFUOSBUXEsGR8DjbfiWn2m+7OSwllEzTLETpeM2x4B6sMusAO493CY6hBpbcb6zM7sWwV6emeM9D8iwxyWljwF6V3FU47hZsSsScHk8Ratb9CccmbCE=
Received: from DS7PR03CA0019.namprd03.prod.outlook.com (2603:10b6:5:3b8::24)
 by DS7PR12MB5960.namprd12.prod.outlook.com (2603:10b6:8:7f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Mon, 12 Dec
 2022 12:40:47 +0000
Received: from DM6NAM11FT005.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b8:cafe::9c) by DS7PR03CA0019.outlook.office365.com
 (2603:10b6:5:3b8::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19 via Frontend
 Transport; Mon, 12 Dec 2022 12:40:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT005.mail.protection.outlook.com (10.13.172.238) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5901.21 via Frontend Transport; Mon, 12 Dec 2022 12:40:47 +0000
Received: from yifan.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 12 Dec
 2022 06:40:45 -0600
From: Yifan Zhang <yifan1.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/display: fix the crtc array out of bound issue.
Date: Mon, 12 Dec 2022 20:40:27 +0800
Message-ID: <20221212124027.4113533-1-yifan1.zhang@amd.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT005:EE_|DS7PR12MB5960:EE_
X-MS-Office365-Filtering-Correlation-Id: a8988384-c26b-4254-658f-08dadc3e17f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RcWFMQHxKzvmFib/6JktxGpw3N3A/CXMO/PjR2C6S5MTN+Vtd+7bHfRp/Xdsn6QlzCJAi5FAvQNaeft9uJS7BqHDypx9iyLa/wAoXO5qDjkd1soR9QB16YI2+xB8vmfcZOOipxbnDSPnGBYOLY9uKdTs5Ej63VoeeLYmI9U+/i2xqWE/J0+lXxOwSLYIInDugSpDUMIlniTJwD3qw+Vu62F9aoLOojWUx0g0HFuQqFqJyKejqc8JOkgH+pgRNjdNa8LqRLohTb/L0iVnW7BAJKKMsIUl/rD2eRNOOWlqxnN07V5ymJ7k/v0qbjtVJEHodpy1xtuwAlW3UWrB/a1yP0b0/nNfsIuyHyJ2LJSJxr+xZ7hOMCh4e4LfvH3AOMTf3ena2Pvpzwx8OXZA5OeZe+/qUYmm5CatuqaCG4O84EeePcaJcQqQyWWwH177h957dcUCISePox+NQxHIKv0fv2/Sgz7j4uVQUNw7BFzTTwjMO0lgCDaFd5pANt2fXP56gn20G1PFuNvyALIkzHKoNLtRyvvG3jA3TnlifnA7LvIXxXBfqXeDyXE+hJOxiUW8IM6w+/kT/cgiDx8ZmYzp7TcmZ1aTxySFeEJf4Whk/HSwj59ZygQjUyFt3udBmNTvQ4j1XSd/Le1zo57ufpWXRdevFceUDkuOzz07fGpFLTV7zqeSfL8LuxhwCXlTXWjW2saXFTE++pBjtF7qHKr7JJjMWyQV0A1bg9Yd2T1c6/U=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:CA; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(39860400002)(136003)(376002)(346002)(451199015)(36840700001)(40470700004)(46966006)(82740400003)(36860700001)(186003)(356005)(6666004)(40460700003)(81166007)(478600001)(82310400005)(86362001)(316002)(41300700001)(2616005)(70586007)(1076003)(7696005)(70206006)(54906003)(26005)(8676002)(40480700001)(6916009)(8936002)(426003)(16526019)(5660300002)(2906002)(83380400001)(336012)(47076005)(4326008)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2022 12:40:47.3500 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a8988384-c26b-4254-658f-08dadc3e17f1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT005.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5960
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
Cc: HaoPing.Liu@amd.com, Yifan Zhang <yifan1.zhang@amd.com>,
 harry.wentland@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

adev->dm.dc->caps.max_links could be larger than AMDGPU_MAX_CRTCS,
change the iteration upper limit to AMDGPU_MAX_CRTCS to fix the issue.

[  276.069644] ================================================================================
[  276.069652] UBSAN: array-index-out-of-bounds in drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_crc.c:550:55
[  276.069660] index 6 is out of range for type 'amdgpu_crtc *[6]'
[  276.069665] CPU: 11 PID: 1092 Comm: modprobe Tainted: G           OE     5.19.0+ #15

Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c
index 8bf33fa4abd9..af2230797be9 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c
@@ -217,7 +217,7 @@ int amdgpu_dm_crtc_configure_crc_source(struct drm_crtc *crtc,
 #if defined(CONFIG_DRM_AMD_SECURE_DISPLAY)
 		/* Disable secure_display if it was enabled */
 		if (!enable) {
-			for (i = 0; i < adev->dm.dc->caps.max_links; i++) {
+			for (i = 0; i < AMDGPU_MAX_CRTCS; i++) {
 				if (adev->dm.secure_display_ctxs[i].crtc == crtc) {
 					/* stop ROI update on this crtc */
 					flush_work(&adev->dm.secure_display_ctxs[i].notify_ta_work);
@@ -543,7 +543,7 @@ amdgpu_dm_crtc_secure_display_create_contexts(struct amdgpu_device *adev)
 	if (!secure_display_ctxs)
 		return NULL;
 
-	for (i = 0; i < adev->dm.dc->caps.max_links; i++) {
+	for (i = 0; i < AMDGPU_MAX_CRTCS; i++) {
 		INIT_WORK(&secure_display_ctxs[i].forward_roi_work, amdgpu_dm_forward_crc_window);
 		INIT_WORK(&secure_display_ctxs[i].notify_ta_work, amdgpu_dm_crtc_notify_ta_to_read);
 		secure_display_ctxs[i].crtc = &adev->mode_info.crtcs[i]->base;
-- 
2.37.3

