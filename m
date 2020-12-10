Return-Path: <SRS0=6/kp=FO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00EC7C433FE
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Dec 2020 02:45:33 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E183239D1
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Dec 2020 02:45:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E183239D1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4AF776E2B8;
	Thu, 10 Dec 2020 02:45:32 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2078.outbound.protection.outlook.com [40.107.244.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C4F2A6E2C7
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Dec 2020 02:45:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RlKgwkOfaAz05YiTC3fGcq04jdkHy1DhUdNP5+KyCJz0UwF+6dgro+6EImOV6wobyTvoI4z20cghag+icGxbKQRvO+a+19IKUt/shrvU+diIW1nENFGhqYZtXcKWB7V8VDsFiymfTMBH0eV7DbKULwdP/6xXXVReysclD+stTX3+7d3wDIIx311oAneU8dgcfxt1rZxJ/Mm/fSybtQgTR8QswsrR8vOZ5wi12PRtW/CzeHkyYOHWIBbhMo7JqXXCFHC7bu7y0+AiXNyrj4yn5amRPnYNOSd4vXeBrDRF6OEu1/NcoUrVbSk0snjx6Rc1UDkP3A3qPSXMdql5t7m7VA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+xtLjlFsxIF+CQp4VUs+jJ2Vu1kAEPiXJ+7HWjiz5Cs=;
 b=Cl+EFQNd2dXtT7GLzN5bDPW4b8bf98qTDGq5yY8p3scnGqRW1kDQvzkYIwx9taTacvoPNrH+9YGFosSIppBKofEj5+NzLHRnmWqkHvGqeQ0IETkH4kiySsBbSDNGK3zlsh65bzwc6afo/2kWh/qUVwIun2cUqRcX2QIDUyKcmF4nqaJXRB0yun99hH/HM9jIUSXt9c+9idxp5bs96cUSxFYhRtFZ63eOE5vsXuz4ZmIxZoOdVSo1l+iM/ac2m+wovj+aEsTtOJ1JFwpx7KLX+l8YRzSBQFGEcSmCFD0XqmOVPGX97uNNtBR43flvZUHVGO0kN9ciEFQOGZY2JnQmXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+xtLjlFsxIF+CQp4VUs+jJ2Vu1kAEPiXJ+7HWjiz5Cs=;
 b=2+MdxMDjBvn9oG7W/Kjiiv/1J1N3KM3+IVh//8C5Rddub4wy3qAwXJmYW2pyH6r7054X/CsY/uDbf9mqZKwTk91BbRDkU7zOJnhI1ToIQCyRbEtJlk7i7/tTkC5z3h5AZm6JLBFos6IDZ9OLNdP08lwaYR49zeMU81IMn8y6ft8=
Received: from BN0PR02CA0048.namprd02.prod.outlook.com (2603:10b6:408:e5::23)
 by BYAPR12MB2773.namprd12.prod.outlook.com (2603:10b6:a03:72::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.21; Thu, 10 Dec
 2020 02:45:30 +0000
Received: from BN8NAM11FT031.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e5:cafe::f9) by BN0PR02CA0048.outlook.office365.com
 (2603:10b6:408:e5::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.12 via Frontend
 Transport; Thu, 10 Dec 2020 02:45:30 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none
 (message not signed) header.d=none;lists.freedesktop.org; dmarc=fail
 action=none header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 165.204.84.17 as permitted sender)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 BN8NAM11FT031.mail.protection.outlook.com (10.13.177.25) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3632.17 via Frontend Transport; Thu, 10 Dec 2020 02:45:30 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Wed, 9 Dec 2020
 20:45:29 -0600
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Wed, 9 Dec 2020
 20:45:29 -0600
Received: from aj-EliteDesk.amd.com (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Wed, 9 Dec 2020 20:45:28 -0600
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/3] drm/amd/display: Add module parameter for freesync video
 mode
Date: Wed, 9 Dec 2020 21:45:24 -0500
Message-ID: <20201210024526.1151447-2-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201210024526.1151447-1-aurabindo.pillai@amd.com>
References: <20201210024526.1151447-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f8411f87-1022-4e4a-5475-08d89cb5a863
X-MS-TrafficTypeDiagnostic: BYAPR12MB2773:
X-Microsoft-Antispam-PRVS: <BYAPR12MB277328D5F835A44B7ED3E54B8BCB0@BYAPR12MB2773.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4O+RNJml68OL57VzVdqDYbJAKkKBkE6Wiy46LKwxzNSf6l/Tm2rXJrQj3j0dW9NZy1j+x7Z/kq+USyKWren8iuMSSbWMGSkMRPYzc69wiC8+Qs0PZG3JIzAeM1sCMluo1PlNNLBmaiOQgz/v8cVen6lUDX4xcmGv62NHszrH/2aAwYWrJua+aFIV8WSDcQc6LSfIMlujby+ROYBfRGsuZsP6KMrwpqX0AebclwavLdDwQwoWn+sWxa5GPcikn56HSlakubIuMgwNMLYgMOU3gx0zbEXVwat5eduCT6rTqRFOhwMugvh7yyMOiUGBVCHE0WNQt++JLYs3ZFoG2Fav5pC6Z/9fIMi136XMWeqgjjTnQ6WFHOn4fuSOtgdkgQRu6OT8lim+BYpief+39Aya1Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(346002)(376002)(136003)(46966005)(6666004)(2906002)(70586007)(356005)(82310400003)(508600001)(7696005)(83380400001)(4326008)(8676002)(6916009)(1076003)(54906003)(5660300002)(26005)(44832011)(2616005)(81166007)(70206006)(8936002)(336012)(186003)(86362001)(426003)(36756003)(47076004);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2020 02:45:30.0571 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f8411f87-1022-4e4a-5475-08d89cb5a863
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT031.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2773
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
Cc: stylon.wang@amd.com, shashank.sharma@amd.com, thong.thai@amd.com,
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com, alexander.deucher@amd.com,
 Harry.Wentland@amd.com, nicholas.kazlauskas@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Why&How]
Adds a module parameter to enable experimental freesync video mode modeset
optimization. Enabling this mode allows the driver to skip a full modeset when
freesync compatible modes are requested by the userspace. This paramters also
adds some standard modes based on the connected monitor's VRR range.

Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h     |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 12 ++++++++++++
 2 files changed, 13 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 83ac06a3ec05..efbfee93c359 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -177,6 +177,7 @@ extern int amdgpu_gpu_recovery;
 extern int amdgpu_emu_mode;
 extern uint amdgpu_smu_memory_pool_size;
 extern uint amdgpu_dc_feature_mask;
+extern uint amdgpu_exp_freesync_vid_mode;
 extern uint amdgpu_dc_debug_mask;
 extern uint amdgpu_dm_abm_level;
 extern struct amdgpu_mgpu_info mgpu_info;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index b2a1dd7581bf..ece51ecd53d1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -158,6 +158,7 @@ int amdgpu_mes;
 int amdgpu_noretry = -1;
 int amdgpu_force_asic_type = -1;
 int amdgpu_tmz;
+uint amdgpu_exp_freesync_vid_mode;
 int amdgpu_reset_method = -1; /* auto */
 int amdgpu_num_kcq = -1;
 
@@ -786,6 +787,17 @@ module_param_named(abmlevel, amdgpu_dm_abm_level, uint, 0444);
 MODULE_PARM_DESC(tmz, "Enable TMZ feature (-1 = auto, 0 = off (default), 1 = on)");
 module_param_named(tmz, amdgpu_tmz, int, 0444);
 
+/**
+ * DOC: experimental_freesync_video (uint)
+ * Enabled the optimization to adjust front porch timing to achieve seamless mode change experience
+ * when setting a freesync supported mode for which full modeset is not needed.
+ * The default value: 0 (off).
+ */
+MODULE_PARM_DESC(
+	experimental_freesync_video,
+	"Enable freesync modesetting optimization feature (0 = off (default), 1 = on)");
+module_param_named(experimental_freesync_video, amdgpu_exp_freesync_vid_mode, uint, 0444);
+
 /**
  * DOC: reset_method (int)
  * GPU reset method (-1 = auto (default), 0 = legacy, 1 = mode0, 2 = mode1, 3 = mode2, 4 = baco)
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
