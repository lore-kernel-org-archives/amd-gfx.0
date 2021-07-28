Return-Path: <SRS0=0Udm=MU=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34732C4338F
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Jul 2021 00:11:43 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E4F426069E
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Jul 2021 00:11:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E4F426069E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 936FE6E23F;
	Wed, 28 Jul 2021 00:11:42 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2053.outbound.protection.outlook.com [40.107.244.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8415B6E1DE;
 Wed, 28 Jul 2021 00:11:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iRrzVnkJI6bNsOzt1cmTNenFqmM9FOfenYcV6mD20r9fBj7R74uJwHuTuMCWKXxbtMzF1dYvpMMhwPLeg4AksK6SAQy3ZqEMiAWt9Z0nvT3zsbc0CrVHggxCFIorE0scyENy3mJSrvWPgTw89dFj8ZnRkIFu0RnWkQd9eixOi4swpXaISib97VZHOGbTC682z6FssFl7b0+sYvay6OREpryYJA3edYaQG2kv8PLRtjODUrT3icl1tqNabq2lUaL6tWQgivSXPPdMHNA0LXqEABqcm0sU1LcInUb71dlTk843wOpO9bDEG5SobFs/iIq9oaGlSSr6PM5+WhkmcqiHKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GjfYk5WmUSwAEkCyZLHL3zA0NqlivsnAUH4dubiRFDs=;
 b=HOd/0iMSyDHSoxVyQbXe0h+Hx2iffA71A+19nlw/9zB1pJv6Ti7yw173z5eui0wci6OKCL9fSOuq5nvmDpYWazozNdfrPUw+jdyra36o66fnormuLC3dyiYfnt/dV68lpwnBFbIUt9Z8GPzFfcgdnhhh3O0hpO7yoSYObpjG5PZ8A9i4Bo53cxGvR+GLs9Zotet5v8E3ne76toaHqM8F6Kd/0ruVblTjLCxl9A0stmIyLEEEHwfzA3hHUb131ZZO9v7KL5Tw4c0FMFpoGIYXtbN7l5ozAmE3ABjabBQjKqOSR6vtwZ08nFp1xIwvcR00Aw0RhsfAkDpxuOAAJBCKvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GjfYk5WmUSwAEkCyZLHL3zA0NqlivsnAUH4dubiRFDs=;
 b=mWbiRgd4a+Dzqp2i3TIXkOAuEWA8KuSCZG04D+2DfJfKx/73fryxj0EioHtTzHrCaPop3djcd4D1i37vTKkPxXAw3UhsSKnnyVMJPToJQ3OxIe9wB4lnQR2I5btR5rp3FQSnAbADip31CpAI/bRtV7aPHyg3sqyuriAt2TmpwoI=
Received: from DM6PR13CA0069.namprd13.prod.outlook.com (2603:10b6:5:134::46)
 by DM6PR12MB3962.namprd12.prod.outlook.com (2603:10b6:5:1ce::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.28; Wed, 28 Jul
 2021 00:11:38 +0000
Received: from DM6NAM11FT068.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:134:cafe::ce) by DM6PR13CA0069.outlook.office365.com
 (2603:10b6:5:134::46) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.7 via Frontend
 Transport; Wed, 28 Jul 2021 00:11:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT068.mail.protection.outlook.com (10.13.173.67) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4352.24 via Frontend Transport; Wed, 28 Jul 2021 00:11:37 +0000
Received: from devbox.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Tue, 27 Jul
 2021 19:11:37 -0500
From: Ryan Taylor <Ryan.Taylor@amd.com>
To: <dri-devel@lists.freedesktop.org>, <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 0/3] drm/amdgpu: modernize virtual display feature
Date: Tue, 27 Jul 2021 17:11:16 -0700
Message-ID: <20210728001119.12807-1-Ryan.Taylor@amd.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b1a96ac1-c21e-436d-07e9-08d9515c44b0
X-MS-TrafficTypeDiagnostic: DM6PR12MB3962:
X-Microsoft-Antispam-PRVS: <DM6PR12MB396236F3C324F9A7244BD985EAEA9@DM6PR12MB3962.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ehFkzRCFK/ZbOi+NQsy6zdVqjYNF24C7MU5HLQFDBEzrwVtPn4nPCqC9w45s2wKZ09I5Po7l52HbQH3mAR57Y13qafUE7xWcUHkusf7pqFSx8jXQ0muw1PYDC5WoR9vzUZuNf1L1RUbS+iPVUnhbb8FTWux14X6RBJyEOgR+7BQ2x7Phgt40waLhMtQQEBMuV2Zo3j9Clro9gsEScIXU3wyGM7h+a4KXDykEuUxBPyxem98N6TufStpQoH831Ew/v8ESjmWn63d//7wRErYENEgcz2W7j6J7o7DI9ONUnmiO2edtFqy50YpeeCEnq008bSj77DeVkYFIsKauu53se6dadpeVt6ctnvLIZCQyi4LdNvgW/6bT0BtkFcHvOnjVo2kR3HRZ7XNFHLm9f1Hceq4/jityf4KgRXEM8tWbKeJAIIwQ+oTXrGqRceCttIwB2CEal42sVlJX0sNVJPV3yb2ZgXTjLHR9IUuxT897cZXu8foxxGZA63FmmiqeGo7E0Xp17d6OdmQXJNpzsfdOY4TOtfjch2EKCRfKJHqGSRP/Ir8jC8yTKdiB67YPh/cn6NmN/D4UUHANVO5bT72Z8QAaKMZAY8VK0NOn7B7cd0Pgq432t5ovFtWvjMiIy9am54Qb/WNBJH9pwvAvKqRKtjQbn7v/X2DqtYgexLheU7wyRGv3Gt3VOWvVzE9Ux8ySnKcv+fP5+PPT+xONuE1jJVMEgD98K7f+qFDEWYnaFo8=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(376002)(39860400002)(346002)(136003)(396003)(46966006)(36840700001)(36756003)(82310400003)(70206006)(70586007)(478600001)(36860700001)(81166007)(186003)(16526019)(47076005)(426003)(8936002)(336012)(1076003)(316002)(2906002)(2616005)(54906003)(83380400001)(82740400003)(4326008)(86362001)(26005)(8676002)(7696005)(356005)(110136005)(5660300002)(6666004)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2021 00:11:37.9824 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b1a96ac1-c21e-436d-07e9-08d9515c44b0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT068.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3962
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
Cc: melissa.srw@gmail.com, daniel.vetter@ffwll.ch, rodrigo.siqueira@amd.com,
 Ryan Taylor <Ryan.Taylor@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The amdgpu vkms interface provides a virtual KMS interface for several use
cases: devices without display hardware, platforms where the actual display
hardware is not useful (e.g., servers), SR-IOV virtual functions, device
emulation/simulation, and device bring up prior to display hardware being
usable. We previously emulated a legacy KMS interface, but there was a desire
to move to the atomic KMS interface. The vkms driver did everything we
needed, but we wanted KMS support natively in the driver without buffer
sharing and the ability to support an instance of VKMS per device. We first
looked at splitting vkms into a stub driver and a helper module that other
drivers could use to implement a virtual display, but this strategy ended up
being messy due to driver specific callbacks needed for buffer management.
Ultimately, it proved easier to import the vkms code as it mostly used core
drm helpers anyway.

Ryan Taylor (3):
  drm/amdgpu: create amdgpu_vkms (v4)
  drm/amdgpu: cleanup dce_virtual
  drm/amdgpu: replace dce_virtual with amdgpu_vkms (v3)

 drivers/gpu/drm/amd/amdgpu/Makefile      |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu.h      |   1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c  |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_fb.c   |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c | 641 +++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.h |  26 +
 drivers/gpu/drm/amd/amdgpu/cik.c         |  10 +-
 drivers/gpu/drm/amd/amdgpu/dce_virtual.c | 780 -----------------------
 drivers/gpu/drm/amd/amdgpu/dce_virtual.h |  30 -
 drivers/gpu/drm/amd/amdgpu/nv.c          |  22 +-
 drivers/gpu/drm/amd/amdgpu/si.c          |   8 +-
 drivers/gpu/drm/amd/amdgpu/soc15.c       |  10 +-
 drivers/gpu/drm/amd/amdgpu/vi.c          |  14 +-
 13 files changed, 703 insertions(+), 845 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.h
 delete mode 100644 drivers/gpu/drm/amd/amdgpu/dce_virtual.c
 delete mode 100644 drivers/gpu/drm/amd/amdgpu/dce_virtual.h


base-commit: e0186426a7efeb506164da7d4a56cfdaea38b380
-- 
2.32.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
