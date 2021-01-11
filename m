Return-Path: <SRS0=2jl+=GO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21302C433E0
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Jan 2021 21:02:51 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B9C1122D00
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Jan 2021 21:02:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9C1122D00
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 58DE289DDD;
	Mon, 11 Jan 2021 21:02:50 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1F69D89DDD
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 Jan 2021 21:02:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i1ag++JHeveuYXNe3vNna81Dhv2405lQ65ScFp4sgTIDnSizaqJNgaiikoibzELaI3IoSLD7rHFem2RG9CvpAkcU0varXoWhBlMv4KSi/M3TjvJfmQn2284y73clhu9Op5/GrzZW0lxsmcgh4Eq4HgNexAiUL0mfsMDOf+EZ7ItxmfFT8kbw3sU8AzFtcNRFluCWaRu34PwC4uJ0qhSJ7gHvZMDzZw3bwIZRJtXVJQNCUf9/PEYPMDDj8a6KxEeHZtpUHbEW84dqU5VSXp9s+2qDu7HgvGTxsFV03w7wMUQKKACDZhbWRijVHESDdJh20btYc1zaJpZxTfrqmHGC/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0WtYDAK2UFYUrB44Bq9BnJYgApMoopeX0ekz297Lluc=;
 b=nJSar0AMOnDbxtZk2O0UQAa+uBw0Wa5QslhY3YQUAPV7n7NUWWniILayc5gQ6YpZtzO5mcPRFe1w69UJg+E85HStkKJTz6wJ2/MlJyveoGOm228K5DrcMuw5qd3WIq7SyXOyCLKkPi8Rn1GS0KLAfmvyKaBlAGiC/TZKc26vkdzC31CVMnVdYMLqeAyVcj4oZrYP0f3MQ9Ehzp6potCimAH77AcLmd/HL7YNXYUksLvdiXSDxd3qgwlaHBLg0qjz/vDB5mFfqk1QTrqhqIPs0CNBxIl9NsjXCFA52LZPDbPyZh9o/EoYb82/ynfjm6FPYU3rh1F97BfcwZ+pR6mVNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0WtYDAK2UFYUrB44Bq9BnJYgApMoopeX0ekz297Lluc=;
 b=MeBpu8PvyHUXUQQ+3tEvXEB4mnHc0SMVAg3Qu/oFDXSf7V1uMvBirValmPvZy5hZYZFTU1S9UEhp1tCW+akuMt2Vfgdbw/01hfyOsWm49CQx0GtW7XhV4viTTNhVFUjUrXyUUcXPLsXgWNxRxV5kTYzCtCw0qcpHcO3XGs1MpMA=
Received: from MWHPR12CA0045.namprd12.prod.outlook.com (2603:10b6:301:2::31)
 by BYAPR12MB4710.namprd12.prod.outlook.com (2603:10b6:a03:9f::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.10; Mon, 11 Jan
 2021 21:02:47 +0000
Received: from CO1NAM11FT067.eop-nam11.prod.protection.outlook.com
 (2603:10b6:301:2:cafe::d1) by MWHPR12CA0045.outlook.office365.com
 (2603:10b6:301:2::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.6 via Frontend
 Transport; Mon, 11 Jan 2021 21:02:47 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none
 (message not signed) header.d=none;lists.freedesktop.org; dmarc=fail
 action=none header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 165.204.84.17 as permitted sender)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 CO1NAM11FT067.mail.protection.outlook.com (10.13.174.212) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3742.6 via Frontend Transport; Mon, 11 Jan 2021 21:02:45 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Mon, 11 Jan
 2021 15:02:42 -0600
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Mon, 11 Jan
 2021 15:02:42 -0600
Received: from blakha.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Mon, 11 Jan 2021 15:02:42 -0600
From: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
To: <nicholas.kazlauskas@amd.com>, <Guchun.Chen@amd.com>,
 <alexander.deucher@amd.com>
Subject: [PATCH] drm/amd/display: Fix deadlock during gpu reset v2
Date: Mon, 11 Jan 2021 16:02:36 -0500
Message-ID: <20210111210236.2376738-1-Bhawanpreet.Lakha@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2f888035-3a6a-434b-c869-08d8b6743ea2
X-MS-TrafficTypeDiagnostic: BYAPR12MB4710:
X-Microsoft-Antispam-PRVS: <BYAPR12MB47100B76E73B4253B73E4486F9AB0@BYAPR12MB4710.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yP8KhjxNWGXtYX7S1/9+ZTGw3dAmWJ6QEtBBEg7uqmF8/YKtiRwn5iBiJvm/Mpwg4tl9+HVfvQuYirCw0svpT7gYwsfxqxXuYzE0xprQU6gP85ZLsUvqGoIm286naIxVHmFu6zluu1tuYpnGB//4mBgLIqMexw+nNR49d7ReRIBoj3PgAoL21FoPa+vvDuzVpqQFwUzgtdh+rBykjafYj5fxuMNUHY1ZmPtkIXKqV0q6qaeFaS23S6/7BEZ5jwd9qGVJRHZvzZBRmUJqMgVaigAOSvJ9oG/S9pGAp52QAGAFnnoYAmU8+362i/94K0oPTSjvgtLRJQf3KDRCCeBG/HImGgFBiR9Lc+I6cduz1te17sbGlofZ3BQnJXWNK3hAs2T1/Mq+8Vo9uiwOuLXT4EhK1LCDxa1/v7rZ3alxwwpectXWpNsYYRbYol9cBLLLgqp6YnqFfEnGfoJP8gDD35Rcq5qsfpNMI+7xXFqjWSIMwvYi8jFWPyAmYFqDm6jN
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(4636009)(136003)(376002)(346002)(39860400002)(396003)(46966006)(316002)(47076005)(5660300002)(8936002)(2906002)(2616005)(6636002)(478600001)(82310400003)(83380400001)(110136005)(86362001)(1076003)(54906003)(34020700004)(26005)(70206006)(70586007)(186003)(81166007)(36756003)(82740400003)(4326008)(7696005)(336012)(8676002)(6666004)(426003)(356005);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2021 21:02:45.4633 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f888035-3a6a-434b-c869-08d8b6743ea2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT067.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB4710
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
Cc: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>,
 amd-gfx@lists.freedesktop.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Why]
during idle optimizations we acquire the dc_lock, this lock is also
acquired during gpu_reset so we end up hanging the system due to a
deadlock

[How]
If we are in gpu reset:
 - disable idle optimizations and skip calls to the dc function

v2: skip idle optimizations calls

Fixes: 06d5652541c3 ("drm/amd/display: enable idle optimizations for linux (MALL stutter)")
Signed-off-by: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 99c7f9eb44aa..858c6ff173ba 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -1816,6 +1816,9 @@ static int dm_suspend(void *handle)
 
 	if (amdgpu_in_reset(adev)) {
 		mutex_lock(&dm->dc_lock);
+
+		dc_allow_idle_optimizations(adev->dm.dc, false);
+
 		dm->cached_dc_state = dc_copy_state(dm->dc->current_state);
 
 		dm_gpureset_toggle_interrupts(adev, dm->cached_dc_state, false);
@@ -5556,6 +5559,9 @@ static inline int dm_set_vblank(struct drm_crtc *crtc, bool enable)
 	if (!dc_interrupt_set(adev->dm.dc, irq_source, enable))
 		return -EBUSY;
 
+	if (amdgpu_in_reset(adev))
+		return 0;
+
 	mutex_lock(&dm->dc_lock);
 
 	if (enable)
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
