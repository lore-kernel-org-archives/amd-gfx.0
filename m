Return-Path: <SRS0=Rd3N=H3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B16DC433E0
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Feb 2021 18:56:41 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C27B564F1A
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Feb 2021 18:56:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C27B564F1A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4F9786E1E8;
	Thu, 25 Feb 2021 18:56:40 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2060.outbound.protection.outlook.com [40.107.94.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 253DD6E1E8
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Feb 2021 18:56:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m55rrD2+6WSZt5FsrLsFISHmojDUpCPYsv8pZww9CEa6Er8TZZGG15hnCVwDXMBWsr+++EJ9KyO+xtkaPp2Da2FuzTwoMkkuKpwXuEzoFsMTb4jjC15FdcRRFYRuKKEhehUNTjZZIHllH03+IQq98Jwp1OhKkRepjEKF6KMVSJPfcG34v1A+D2uShcEdt/4f6X77GfQ7dcyQFi2eYWQZ2HBvbBuawuBDKEDlEpQP/a9vd1M9/Mx2BH3pgXuPWlG6xCA/nF7KgVVHrltS5UzCjMJ33pszO5Ptyv1D/smLheahmCsYJMule6o+wgYuAO+WdlSWbQXWQeRLSRCCeGxElQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kY2x+it6gItd5jY4aXm0u0O67ExFdp5HSf6nZauI2bw=;
 b=B+P3NCm4k41HFCbVr3GbPQvVBpU1B9ZJRsYU5gUSU3w7rYX0go8Sw70WwwvXEb5BYFz3g7dRw4vlHI08BhlSisWolVjo4Fkeu9Me1m6bDiVihDHgSAisnrGRc0Zgn66dvcMWnG+kiXLEoDZz7+JWe95zPA8TBs7UDPtiXvxx4vHDk1ohnuUxe2XTR65hAYx8kaRvmaar4q3Y9n3S5vU66f+rRdjsciei9ihaTI2VTnIoRjHZDQ2PoGidoXXhBW1e0h9WbLKYuNWc1y1g2wsLbJhDpmOgeeEoLBXr6fwok2mkj7nzvdNyHrJTn3qtXu7tQVcaDy91ZP0A6diojlF/5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kY2x+it6gItd5jY4aXm0u0O67ExFdp5HSf6nZauI2bw=;
 b=nsj+HPyNzmh+B/jsFoQsQEW5/WPMcD4x+xz+qBHy2qS2SDWVYXRAifeGli1S069PtcjWoSmp4evSn+UgaQfln9yInhN62tlRACTZTaAKboiCQhDaxX5p/ahk2PTHU8uJUu3RL2ETaZgH/2piiWX+PhtYd+4sOtiTuCDpfociZ9k=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB4456.namprd12.prod.outlook.com (2603:10b6:208:266::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.32; Thu, 25 Feb
 2021 18:56:37 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::b0c4:9a8b:4c4c:76af]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::b0c4:9a8b:4c4c:76af%7]) with mapi id 15.20.3890.020; Thu, 25 Feb 2021
 18:56:37 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/3] drm/amdgpu: update default timeout of Aldebaran SQ
 watchdog
Date: Thu, 25 Feb 2021 13:56:00 -0500
Message-Id: <20210225185602.661486-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.29.2
X-Originating-IP: [165.204.84.11]
X-ClientProxiedBy: BL1PR13CA0206.namprd13.prod.outlook.com
 (2603:10b6:208:2be::31) To MN2PR12MB4488.namprd12.prod.outlook.com
 (2603:10b6:208:24e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from tr4.amd.com (165.204.84.11) by
 BL1PR13CA0206.namprd13.prod.outlook.com (2603:10b6:208:2be::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.14 via Frontend
 Transport; Thu, 25 Feb 2021 18:56:36 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 2b57e1ef-7f6a-4d0c-fbd6-08d8d9bf141b
X-MS-TrafficTypeDiagnostic: MN2PR12MB4456:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB44568A5936C6B69A42FFF56AF79E9@MN2PR12MB4456.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1728;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8jYKUnTKzLTA3dMg8xLL+rr9jI2evBILYhxCkMR+3LcQcRIKIQR5BRP6jkbeQYGhq5eo2KS6XntReNe/57qWNHfbOrbGzLy7GU8lPLkh6fGLvfaHQDi0E8ZfIpFmUeK+x+eg5msHsJR4lR+7Zw04L+gENNBovjX80P2+n91uhKPLul90tvf6GeLz1ch64UGSDzbBsT1Gwf2/NIvie0GWgT0Ummz5aedoZ0MiTBrFJ5raHTDa3YVCd1Pm2DmpZjrQtcm9iTkup24H14fE3EwRlXefZas4cL1QxDTqprQw7zgMO2uJewhseXhiWxy7W3LBT2IqQrvX3ftQCZ6oxUDL/hXk45RPDe7WimVul9MC5XUyh1ltqX0GDQqpJLrDE5paGqOQobKTOxufqVm7fp0oXLvWpR9/QudgvdYxebM1P8WdO1Hnnuoyy/di6n+42eG+l/ZK8Yd0ge2DH4qGdDwJmvsnQ+d0OBKdUC0qpyNPFEqVdLmpI33+mxn99DuCjpya+rMA1TCkwrNLwdp8zArtCw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(366004)(346002)(39860400002)(396003)(136003)(52116002)(186003)(6486002)(26005)(5660300002)(66476007)(54906003)(6916009)(956004)(16526019)(7696005)(8676002)(36756003)(2616005)(316002)(6666004)(86362001)(83380400001)(66556008)(1076003)(478600001)(8936002)(66946007)(4326008)(2906002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?0DxyryQ2rTbmd6RRpYsTkTFfOmqVVhKeiqKXG1DmfTq5r2YXfCa06sCmgpUo?=
 =?us-ascii?Q?B4TyPG+ksX7fS/RtGDAMXyU22tFsBVXEj81trc3KmCxW0d0rpDSPZ5zLvD0+?=
 =?us-ascii?Q?rehJOQcU3zjZ2S44TgPoQ/i3ItWtqWIdMHASW36HuAJEtQqcz8J5+iK4LYZL?=
 =?us-ascii?Q?5IbWzC0U1Cn/ycmxwJwSlY6uNaxju+17+vRq4WEtZOwBTT0q2JNIyW/cwZO3?=
 =?us-ascii?Q?35sfvOY5M09FBssKV6G9w6sjEOKZNMqqyJQ5O83BBOKwIJqBQZMjRWB7adJD?=
 =?us-ascii?Q?RM1OEZzufurqQyMadcuTBL5txkCw0xpo0B+8DDkycIE3go2GQMxW3rwtx8UU?=
 =?us-ascii?Q?yEU8v6mNb+a1mxuihiwL6LVbxjrZqCLsosD8ZAHszaZvDfVqSHuxckPGVqbH?=
 =?us-ascii?Q?IqvzsCu95biUIcThfyKCfSnjKKjhi279VaYes9zxuLIPvQIuBKy2ExELwZum?=
 =?us-ascii?Q?8wVxjgXDjHKky4oX9GyJ9K4Nh8LT8/JUniBp4YJCwiVaxKgLuiim1SOnpX+f?=
 =?us-ascii?Q?4Ojc57zLSMeKsRWF3OpOdB+hlT8m9B0FxiOATzpufu6fBdp37aNSOMC8soRq?=
 =?us-ascii?Q?9Lvpws78kImx/Jd3SqllY2+Az4znsyMp+kONNOjilX78EtJUViMUtljWC2+D?=
 =?us-ascii?Q?uDMh1r/Suu5Q02hrjlgvUi2HTVetuetgiAOHE6226j2q98752HBD9pVZxtjK?=
 =?us-ascii?Q?Og07xZy1n4M09WuxshpdlFe2471Gmgv67hLdAaPUV3RBqwJ6lbwGyHi8Hal8?=
 =?us-ascii?Q?u2XJtzm6xaXOXQ0Vry1GKGmjThYXUE92odu5dvauhdKwu7ZFpsqo7UvVASDY?=
 =?us-ascii?Q?4wvIvWW2jZAGUWl5kOloK3zGDJAGWf+HKYNgwclaDQgCB/dNCbnH8VxCiHbz?=
 =?us-ascii?Q?s0H+FnozO9m1p4bK/JFYn8OlMJQubtOCu8KtJLYnXpT/b5uaqhyECCTqrBgo?=
 =?us-ascii?Q?RLoKe7RjrVcbajkPzsEXhe9TClAvdN6egzZhzR4s9DAOkmxyMVtK+8XEkpeJ?=
 =?us-ascii?Q?gSWFjZCj2Yx7cl++V1kO8cG4ZO/izCbf2mEfgGvlqYx2TRRIQnFH7KnReEcq?=
 =?us-ascii?Q?DzaeGYEZAup9tPuKoe9yCc5nc4R4q5639Mekvi9ZhHEQMtwssxjRoF134qof?=
 =?us-ascii?Q?3IF2sau0VO8kK+jlChKztboig/IdGMgP/28QfnbSpUHcMkTCTB10/F3jK3bv?=
 =?us-ascii?Q?8mC7TI6xwyT/8s0TInlWhEbEgm6dF6qa7LmSXvORa2z4be04zJyvkhNHV4Lh?=
 =?us-ascii?Q?owtFCMCH2e+nyoKLChKeteyUFG5YKMCecLbQeNHEL+yRZRlN+MV30xH7F/aW?=
 =?us-ascii?Q?07Ci7ytF700Gan7BGtO/7XZ9?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b57e1ef-7f6a-4d0c-fbd6-08d8d9bf141b
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2021 18:56:37.5679 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EkeUsLZXdehtD6RAoOSG0nIS2hCcvK301mB1X+w61VOtWYapOZyXCInZgRFSl5SJInMXZB+bIEMVaYoi0Bs+tw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4456
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>,
 Hawking Zhang <hawking.zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>

Signed-off-by: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
Reivewed-by: Hawking Zhang <hawking.zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 4 ++--
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c | 7 +++++++
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 42654deb9c55..29a2fc56e51b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -174,7 +174,7 @@ uint amdgpu_ras_mask = 0xffffffff;
 int amdgpu_bad_page_threshold = 100;
 struct amdgpu_watchdog_timer amdgpu_watchdog_timer = {
 	.timeout_fatal_disable = false,
-	.period = 0x3f, /* about 8s */
+	.period = 0x23, /* default to max. timeout = 1 << 0x23 cycles */
 };
 
 /**
@@ -542,7 +542,7 @@ module_param_named(timeout_fatal_disable, amdgpu_watchdog_timer.timeout_fatal_di
  * DOC: timeout_period (uint)
  * Modify the watchdog timeout max_cycles as (1 << period)
  */
-MODULE_PARM_DESC(timeout_period, "watchdog timeout period (0x1F = default), timeout maxCycles = (1 << period)");
+MODULE_PARM_DESC(timeout_period, "watchdog timeout period (1 to 0x23(default), timeout maxCycles = (1 << period)");
 module_param_named(timeout_period, amdgpu_watchdog_timer.period, uint, 0644);
 
 /**
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c
index 1faeae14ead9..44024ab93577 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c
@@ -1138,6 +1138,13 @@ void gfx_v9_4_2_enable_watchdog_timer(struct amdgpu_device *adev)
 	data = REG_SET_FIELD(0, SQ_TIMEOUT_CONFIG, TIMEOUT_FATAL_DISABLE,
 			     amdgpu_watchdog_timer.timeout_fatal_disable ? 1 :
 									   0);
+
+	if (amdgpu_watchdog_timer.timeout_fatal_disable &&
+	    (amdgpu_watchdog_timer.period < 1 ||
+	     amdgpu_watchdog_timer.period > 0x23)) {
+		dev_warn(adev->dev, "Watchdog period range is 1 to 0x23\n");
+		amdgpu_watchdog_timer.period = 0x23;
+	}
 	data = REG_SET_FIELD(data, SQ_TIMEOUT_CONFIG, PERIOD_SEL,
 			     amdgpu_watchdog_timer.period);
 
-- 
2.29.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
