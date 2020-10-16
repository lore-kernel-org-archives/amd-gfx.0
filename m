Return-Path: <SRS0=ko+j=DX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5EE0C433E7
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Oct 2020 03:28:29 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3ABD1206ED
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Oct 2020 03:28:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="OAftCdu9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3ABD1206ED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D182D6EA81;
	Fri, 16 Oct 2020 03:28:28 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2042.outbound.protection.outlook.com [40.107.92.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E74FF6EA87
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Oct 2020 03:28:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=El954ZzYGBCcpSQrYHj4ZUl+R+5OYZOPRDX5B68F78jJsCudWF7DS19fucCcrB3t4JdyL1PcVCxibDVlWF4aMECkZ86AKlht4hty1oypYzM/3bEGpV/aiNts4Hbp1yanBwZyuGCZqg9Xy4AuhWVX8NVByRLAhY7dw4G5hKRYqdHjODFBL9pffNr1lTujXRty4T818KPIc6qZenHdalg9TonTGtEiVBFRYdBscSC3OpEvZCy1+WboATdisX0lGgKdGbHL/WBOvMRCGmbXUMCJLWw/3qiU8MkQ+KzC5aT7tvXXwQ7i8F3AQiM8OR++KbLDYLFQRpuhUTLDD3oQsekF/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vGBugJ4daBYK255h7rTn0wSdXj7U6qLdOLCiXBhZmV4=;
 b=VIi3gX2HqYtJgdMxSof8vHF5GBsjAlrzQ1FnpWfekxnSQYlY7+wZGJtoWIJB/S5GPoqMD3Kw+F+nnsDXyVvJ1m2YiyQWSeSNhpvjcH2Ab3cHQHjN7OA63OISeO+UJsL+A5o0FatKYWLXPKUzLo02YcseynZtPpC8z0fmwCbXc1XvfmUSY10uKm875gL4T0iBg9qBMBOGC/xLXE9WhtJaI5pXgcoPV2vOPfWcTgUjFOqjl8/FirLTiB8ggA5kI1RiYD8/WlWTh8rAkSyeOkGSHI2yag2nOdBhtggYuWNy5HuS8p9k0Aheful4Td5lCnor3bfR4fEcMQNUflxzoqJtMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vGBugJ4daBYK255h7rTn0wSdXj7U6qLdOLCiXBhZmV4=;
 b=OAftCdu9wHkBsAVDg1/qqQi6HEJCF8y5hUrwlUSXwRXYX9MeYqH005sCAOnbF+CcmSNcTsGictsQF5Ie52qosdaKC8GPdUF/a5tjF8xl6CkWpZ4AuKOy+ksSeZNmwcf9+tHDJUFl0Hf5fqvwVsCLZrojOL4h922wsLXuN6duGIw=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM5PR12MB1354.namprd12.prod.outlook.com (2603:10b6:3:7a::17) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3477.21; Fri, 16 Oct 2020 03:28:25 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::bcb1:de80:f60c:8118]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::bcb1:de80:f60c:8118%5]) with mapi id 15.20.3477.023; Fri, 16 Oct 2020
 03:28:25 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 30/40] drm/amd/pm: correct sclk/mclk dpm enablement
Date: Fri, 16 Oct 2020 11:26:42 +0800
Message-Id: <20201016032652.507-31-evan.quan@amd.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201016032652.507-1-evan.quan@amd.com>
References: <20201016032652.507-1-evan.quan@amd.com>
X-Originating-IP: [58.247.170.242]
X-ClientProxiedBy: HK2PR0302CA0007.apcprd03.prod.outlook.com
 (2603:1096:202::17) To DM6PR12MB2619.namprd12.prod.outlook.com
 (2603:10b6:5:45::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from equan-buildpc.amd.com (58.247.170.242) by
 HK2PR0302CA0007.apcprd03.prod.outlook.com (2603:1096:202::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3499.8 via Frontend Transport; Fri, 16 Oct 2020 03:28:24 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: fbf06b93-a69d-4506-3a96-08d871838aa8
X-MS-TrafficTypeDiagnostic: DM5PR12MB1354:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB13548985F4FDF7937E58479DE4030@DM5PR12MB1354.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1148;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8BDpPtBC3NmrFpTVG01QTN0qDLJDwNrvClofZ7DdElkuYjOF1cZnwog8suX/o4oTj4GkAH3GblrO+TopRdsUf8f/OYwu6BQb51/O4q8uyvYlQ9aJ6aas/faR1gzGRfFInTeauZXFDM5CMR7T2YHoz1SuEkrlVZyNPZXbZp6nNSltA7tt1Tv9w4VKWeQVtAwPdSCT5rpqnyHeR7dcwTcYV62JwW6W7c43RKkwc9CHRpBZ+kxe4Q4jyf/7DkNxt4TSMqnvYUsbGHk1bPiB8xVLbKQru2U2/CXu9DuOJcxabuKTrii6qdcc4/ID1PPU4EyJDl0H3GB1VKg/yrcspwTj/lOg18PW+ZABy7xS6op1T/dSOZAybQXysSI32wlN+t8p
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(39860400002)(346002)(396003)(136003)(376002)(66476007)(66946007)(83380400001)(1076003)(8676002)(6486002)(5660300002)(8936002)(66556008)(6916009)(86362001)(52116002)(36756003)(7696005)(4326008)(2616005)(34490700002)(478600001)(316002)(6666004)(44832011)(16526019)(186003)(54906003)(2906002)(26005)(956004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: 7un0eFTg79W+0Inf2zNROWmYc+7Yy3Bon225YSEWUWvhoKgNZoPc8AzTmCxWjVcd0V7B9VQeEL8FVZ63a84eC82E7gLJ3P9KbldEa9xExFFbtC4ho/DYQ+t7jyfEp9flmPBwyf2mzQ7dinmZR0ywpgCQ0zxYb3UFNNBeaye6Lm7p61sRTW9e+JG3rg33O5IHQYZp0Yq6cMskeQOJdQIGLvJbf/kNtAUzSctEIXNOgyUZax8eHWNCfoOfL5fcEKiqTatT9cAoNmgxBpBCvFJFRATy6pmB54HlD5fTa1FmDoMFmTdCj81rckgx5Tv1oiruTF+GIvtk18Ba51xr5qa1BhFmWzQWy51nocuUktb7JuEfriDDxBXLJnvqffk/H5jbTPgatuaKJDfdd0vzBrF4TTGCvV4dZELNhKMcj+7tudZOGSTUG8NmZ0z6RPzXIxxVelRbc6stkr2rIbdOKIvaGkguKUrGNnML9asfJX6Gmvd86CRkwaSAtplf6K4zHcbF8oI+50eo+pekETf/vaNR0wothVzLR4hxtUEyrFeFi8BZN0f/Lfhnw3uYJP3VpFyiPIU5Ukn3XA9CZKd2Zc686py8jYz75k7END59h+mEJCcsGURzWS4X+YXd4JkiFBB3tBp52Rcz5mB+XfhPBbc6Sw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fbf06b93-a69d-4506-3a96-08d871838aa8
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2020 03:28:25.5259 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t+f8N2ENeW/fZ1yWLvXrlkuehrTExzytSVhI30dXUE1LLMFzFzwzKh5DI9iTW5Gj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1354
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Evan Quan <evan.quan@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Correct Polaris10 sclk/mclk dpm enablement.

Change-Id: I629ed96cbf88230179f26ff77f9cd95e485b9539
Signed-off-by: Evan Quan <evan.quan@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c      | 9 +++++++--
 .../gpu/drm/amd/pm/powerplay/smumgr/polaris10_smumgr.c   | 3 ++-
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
index 7ec83a826816..1f13b88409c7 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
@@ -1148,7 +1148,8 @@ static int smu7_enable_sclk_mclk_dpm(struct pp_hwmgr *hwmgr)
 
 	/* enable SCLK dpm */
 	if (!data->sclk_dpm_key_disabled) {
-		if (hwmgr->chip_id == CHIP_VEGAM)
+		if (hwmgr->chip_id >= CHIP_POLARIS10 &&
+		    hwmgr->chip_id <= CHIP_VEGAM)
 			smu7_disable_sclk_vce_handshake(hwmgr);
 
 		PP_ASSERT_WITH_CODE(
@@ -1169,7 +1170,11 @@ static int smu7_enable_sclk_mclk_dpm(struct pp_hwmgr *hwmgr)
 				"Failed to enable MCLK DPM during DPM Start Function!",
 				return -EINVAL);
 
-		if (hwmgr->chip_family != CHIP_VEGAM)
+		if ((hwmgr->chip_family == AMDGPU_FAMILY_CI) ||
+		    (hwmgr->chip_id == CHIP_POLARIS10) ||
+		    (hwmgr->chip_id == CHIP_POLARIS11) ||
+		    (hwmgr->chip_id == CHIP_POLARIS12) ||
+		    (hwmgr->chip_id == CHIP_TONGA))
 			PHM_WRITE_FIELD(hwmgr->device, MC_SEQ_CNTL_3, CAC_EN, 0x1);
 
 
diff --git a/drivers/gpu/drm/amd/pm/powerplay/smumgr/polaris10_smumgr.c b/drivers/gpu/drm/amd/pm/powerplay/smumgr/polaris10_smumgr.c
index 8176b855b9df..41df6e7813ea 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/smumgr/polaris10_smumgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/smumgr/polaris10_smumgr.c
@@ -2470,7 +2470,8 @@ static uint32_t polaris10_get_mac_definition(uint32_t value)
 	case SMU_MAX_LEVELS_MVDD:
 		return SMU74_MAX_LEVELS_MVDD;
 	case SMU_UVD_MCLK_HANDSHAKE_DISABLE:
-		return SMU7_UVD_MCLK_HANDSHAKE_DISABLE;
+		return SMU7_UVD_MCLK_HANDSHAKE_DISABLE |
+				SMU7_VCE_MCLK_HANDSHAKE_DISABLE;
 	}
 
 	pr_warn("can't get the mac of %x\n", value);
-- 
2.28.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
