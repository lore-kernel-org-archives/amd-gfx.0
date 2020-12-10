Return-Path: <SRS0=6/kp=FO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F34BC4361B
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Dec 2020 18:48:29 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE61622AAF
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Dec 2020 18:48:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE61622AAF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 478046EACF;
	Thu, 10 Dec 2020 18:48:28 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2062.outbound.protection.outlook.com [40.107.220.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 193B26EACF
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Dec 2020 18:48:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kmTbTqTxziJDE753wrHNPufbXJxweOMMICeso0SKsX0yY8nJ6HLYqfwAaFmbWdkteSJ4ei8aKVsEyCWdC5MDMbmsMS1TOMIdO6BOZjBpnx/MSwq9HrM8nhT8kETZmV8EzCekD62i5TQzRw4KqB5bbfmck/zt05tXpGR9AAFPLXK8y0wPdjClgSk9m1mcgjkZYMh8ovB+eZL0ApNLIhKLOUzepCY+4p5zslhR021LLcX43B8AewGOwTK39VIoYGn1+L5Fa4atGAh7E2RnF/rP9x1YqHWT4wuADwgIJBZqSr2Wxw2w7jvF0hxIYQwq09fc69ScrZI7uGLHDfOuRYQMOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N5nSK+BsjT4t+z3kZZyXauTz1EzCxIpenQGkBHh+Gg0=;
 b=VS2KkvYW2E/0ZD9y85sS0OcXH8mbv6VCfDUTWsn3qs2Xa1AAst3Sv+2LHpH+5j+6KTFwIPU4F3qxMGBoWFbUvFGYYTUAzUdKJOre+VKy1kk3HFMLJ6ttQHDZm7b/NJYHiW98V3TN8/2U9juz+Mu/h+s4U85mktbf8rpNcEJ+bGBp9gr1MXn6ot5+RiATnq6w5L+NcXIdgF++CcB1c1fWtSJak1NVUWFcNxEC+DsWQ+yev/maj/GVetS02yRlbqcj2KepsKpYKuSilID/mCaA9Q8T+shoCB8ljHpJSc2ktKlthvCgDT2ky0yiI9YUxPSoG4nXhA1V0013bjTpgNE1NQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N5nSK+BsjT4t+z3kZZyXauTz1EzCxIpenQGkBHh+Gg0=;
 b=AK0nnbd0PckAYU35vThSVvx1m0+Ujcea6qr/bcLH0MpqUM6fGjhWO8QO6MSiCgXQxMmuCS3z2f1vz7MBovY3BybSKRp1lQC4feCESfojndWdjWm7smDjCYAfDAe3/D3oK0vKt8R0MPFjm8q4bMi/hiT5q3rdozpf0w4VwQxGLGc=
Received: from BN6PR04CA0092.namprd04.prod.outlook.com (2603:10b6:404:c9::18)
 by DM6PR12MB4402.namprd12.prod.outlook.com (2603:10b6:5:2a5::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.12; Thu, 10 Dec
 2020 18:48:25 +0000
Received: from BN8NAM11FT023.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:c9:cafe::f0) by BN6PR04CA0092.outlook.office365.com
 (2603:10b6:404:c9::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.12 via Frontend
 Transport; Thu, 10 Dec 2020 18:48:25 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none
 (message not signed) header.d=none;lists.freedesktop.org; dmarc=fail
 action=none header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 165.204.84.17 as permitted sender)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 BN8NAM11FT023.mail.protection.outlook.com (10.13.177.103) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3632.17 via Frontend Transport; Thu, 10 Dec 2020 18:48:25 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Thu, 10 Dec
 2020 12:48:25 -0600
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Thu, 10 Dec
 2020 12:48:24 -0600
Received: from aj-EliteDesk.amd.com (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Thu, 10 Dec 2020 12:48:24 -0600
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 0/3] Experimental freesync video mode optimization
Date: Thu, 10 Dec 2020 13:48:20 -0500
Message-ID: <20201210184823.285415-1-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a4d50025-28d3-4cc2-e25e-08d89d3c2d39
X-MS-TrafficTypeDiagnostic: DM6PR12MB4402:
X-Microsoft-Antispam-PRVS: <DM6PR12MB44020ADCE644F1DEB147F12A8BCB0@DM6PR12MB4402.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jmZE9xXmifrMrZHzf56L7h2MHlbbA9TdsRqdEQlZWUxT9Dn7gKYbae+Hb/8GPsaMJLQLsvXs3hOAkyBGH13QXovYwsufCp42dvV+5C7dgKqOT6QY40b3QMR4EQ9Y3pxjxGJIHWDWj9N1oqSrIsAPvzydgwewr1ktaWx5eG1IKYi4Pg0Bq1d2hdh7VCoQoGDWUxgnvASsLX9+nrSPUY8/tqAth/u+MipmS2QhTt6owIJTt5RTcGfeNoLEI0Lv745biUaHV1KS0htDKG5icSwo6leCCw/vREDZSTxXjdu9hNIWjcgvtKaop/kNg33q2mkeCJp2+2IfnyDSKwkM4kmjwJiWYiA5cQ5VBacq4HWJo70eXHNXA8hSS167JtqjW1VWSA3WfdE7w94bOaZUqdOb9A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(346002)(136003)(376002)(46966005)(6666004)(83380400001)(8676002)(336012)(26005)(70586007)(2616005)(1076003)(8936002)(70206006)(6916009)(186003)(86362001)(54906003)(36756003)(426003)(5660300002)(47076004)(356005)(4326008)(82310400003)(7696005)(508600001)(81166007)(44832011)(2906002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2020 18:48:25.4842 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a4d50025-28d3-4cc2-e25e-08d89d3c2d39
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT023.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4402
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
 aurabindo.pillai@amd.com, wayne.lin@amd.com, alexander.deucher@amd.com,
 Harry.Wentland@amd.com, nicholas.kazlauskas@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Changes in V2
=============

1) Add freesync video modes based on preferred modes:

* Remove check for connector type before adding freesync compatible
  modes as VRR support is being checked, and there is no reason to block
  freesync video support on eDP.
* use drm_mode_equal() instead of creating same functionality.
* Additional null pointer deference check
* Removed unnecessary variables.
* Cosmetic fixes.

2) Skip modeset for front porch change

* Remove _FSV string being appended to freesync video modes so as to not
  define new policies or break existing application that might use the
  mode name to figure out mode resolution.
* Remove unnecessary variables
* Cosmetic fixes.

--

This patchset enables freesync video mode usecase where the userspace
can request a freesync compatible video mode such that switching to this
mode does not trigger blanking.

This feature is guarded by a module parameter which is disabled by
default. Enabling this paramters adds additional modes to the driver
modelist, and also enables the optimization to skip modeset when using
one of these modes.

--

Aurabindo Pillai (3):
  drm/amd/display: Add module parameter for freesync video mode
  drm/amd/display: Add freesync video modes based on preferred modes
  drm/amd/display: Skip modeset for front porch change

 drivers/gpu/drm/amd/amdgpu/amdgpu.h           |   1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       |  12 +
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 330 +++++++++++++++++-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |   1 +
 4 files changed, 329 insertions(+), 15 deletions(-)

-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
