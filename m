Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B1FFEB64DA
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Jun 2023 21:58:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 98AEC10E5A2;
	Thu, 22 Jun 2023 21:58:10 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2051.outbound.protection.outlook.com [40.107.95.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 04E8010E5A2
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Jun 2023 21:58:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dSL3Zefv3lpHRHHmvitaW61iaybTYCaJhVYrxDhLv43ODOAEi6vG+njIZxu9wwiwxUbTSe8mBO/10KFr00vamlcs5HxIyJL4APFaGY91kAcmW7D48WUlZ18fs0E2A4oXBXJJ4WrbYFQCh2vNxMFw8Rul9E45KQ0b1dznq+CmwL1F6/lfcyzvy0Rf8AbRGW8HN6KC+BZVlBdPU0x+4GtLlQeHelEXqMbVoG82nAKTbBE/NWno9le202c5AXgAOTnon5LE9bjN80dl6OQSZJW69C8wz454yGtDjgA/GR9jtCbSkZe2UH5n7jV8H/X81BzeTvKJsjFxTK084MsnoMm7pA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wYsYuhWY7yk1QF5Sg5gCJaOyiS7qJJ03aQ0V9k01jz0=;
 b=jHfAzHinmAx9GAAyGQokKbb/dJinHLi8vchnEB0wqw2WL5BhDxDrYo60HD+K9ScWq1YP+vEjKRsDdE5ovfxCVxB/9ReU6wAziN4gLIQgsGhWqdOJs40jjs9EOCIrKdkjH0RvsrL6j25IGKcuDYRDA1bM5b7+7qYjPJ2QCDfYMtS+WrXSfmhwCt21xx4O6zUQLNFKRv604xR29a4bzoWeag99FRqE0yxGPq83wmNBNaEuO5bX8bgGo/JQoqyZqdc9MZY17IkWkLArpN+zloHYL4kMuT6OsVJXqC8VNEktX+kKmjYhSGGWoASlazq40n450R5IqXXMECSBNNRLc9m4uA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wYsYuhWY7yk1QF5Sg5gCJaOyiS7qJJ03aQ0V9k01jz0=;
 b=A5SUcG0/xpfcuVJbVyUFuE1F3jmGFXftEylji4sM1l73zGir6k5Y8uWFamXfWtonDZQHArwM7Z339LvXfMWqLKARdC22KrSgVh85V7bmRIQ1DTc6ibBYcJ116DsCkfhGpenCY3VJCFJM3JAM5k0tUvHHq0YirPfa3/yHHkDD+Wo=
Received: from SA1PR05CA0020.namprd05.prod.outlook.com (2603:10b6:806:2d2::22)
 by BL3PR12MB6427.namprd12.prod.outlook.com (2603:10b6:208:3b6::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Thu, 22 Jun
 2023 21:58:03 +0000
Received: from SN1PEPF00026368.namprd02.prod.outlook.com
 (2603:10b6:806:2d2:cafe::40) by SA1PR05CA0020.outlook.office365.com
 (2603:10b6:806:2d2::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.10 via Frontend
 Transport; Thu, 22 Jun 2023 21:58:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF00026368.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6521.23 via Frontend Transport; Thu, 22 Jun 2023 21:58:03 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Thu, 22 Jun
 2023 16:58:01 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 00/11] DC Patches June 22, 2023
Date: Thu, 22 Jun 2023 15:57:24 -0600
Message-ID: <20230622215735.2026220-1-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00026368:EE_|BL3PR12MB6427:EE_
X-MS-Office365-Filtering-Correlation-Id: ebc64b18-ffb1-4634-6e9e-08db736bc0a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eo9z1l5AQ57d48jVYn1GbDT1u1JPjTFzfMSKFeYwjCRL1gsowkJhiCQbNBeCxgcZaIuKzT0h3EUOcR8IKlMI+gUuutURFCFo3XgbLrY6BCL7RzsNOB4AzAHljLMyZ4XIrGsKm7liqrTSvGoGQE3+ydJxPD0xKFCiWR5AN5DMQy7hgniomdSf1J4wSPjZSXP7upGRsdeDyo7uKUgcBvZaZbXttAOsbHQi1NIYyQXMYhAS/rkl6LiqJqdGmkqydPvIr1zV/uwvaUieFGyulJLzZu5rXoZlWMWA3HQTQKxNvpGZqPiWGRCgKGMNN77K80pbfbPaSsBjN1Cb6Jt+XZRJQ2xhxdrcW6HB2rKzz+yfGZeu2gAqx30FOUUMINK6ai+DsuwjDgToNdxVgQBPGfFcaS2ZvtTIZmTu81X3dyztgE62sRcvpF01rvsnmKNz0s6j64kQGmRRg6aLEmtGxmZ+AgkDTcDG7RbOUIM5D5BgzVmLNJqbJVpPHlPrVNSziiD2JHqMu3nBWSbHENgBx27R7VLT6JVHyXh/9ll2rHxTcPjcNq28GwmMMdFRe0cx6ozUuvBXxwApbvNCow9k0hxJLfqg9HCbi2cI/z3ftKr1vTD3Qvu/r03thgRSS0GSGtjwKn/5NuNezJQsd7+GnNnlHkqGhroMrMXquBKrWdABQq5T/kc9PtwvHrNbFrhxXPhzQUF/ZK2GUYaPu+QnkonPijr43htF0GeJlIPT4XrzJtpQFaqeriecOLRLJJ0A0vkXT1mdFnDvuDAOiNreNVU4cA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(136003)(376002)(396003)(346002)(451199021)(46966006)(40470700004)(36840700001)(70206006)(186003)(1076003)(16526019)(8676002)(26005)(2616005)(336012)(82740400003)(83380400001)(426003)(82310400005)(2906002)(36860700001)(478600001)(47076005)(36756003)(6666004)(316002)(54906003)(40480700001)(81166007)(4326008)(70586007)(86362001)(6916009)(40460700003)(41300700001)(5660300002)(356005)(8936002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2023 21:58:03.3128 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ebc64b18-ffb1-4634-6e9e-08db736bc0a4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00026368.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6427
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
Cc: stylon.wang@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 solomon.chiu@amd.com, Daniel Wheeler <daniel.wheeler@amd.com>,
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This DC patchset brings improvements in multiple areas. In summary, we
highlight:
 
- Improve debugging mechanism for Gaming FAMS
- Add monitor-specific edid quirks
- Fixes for Phantom pipe
- Fixes for Shapper LUT
- Clean-up asserts
 
Cc: Daniel Wheeler <daniel.wheeler@amd.com>

Alvin Lee (3):
  drm/amd/display: Limit new fast update path to addr and gamma / color
  drm/amd/display: For new fast update path, loop through each surface
  drm/amd/display: Take full update path if number of planes changed

Aric Cyr (1):
  drm/amd/display: 3.2.241

Aurabindo Pillai (1):
  drm/amd/display: Add monitor specific edid quirk

Austin Zheng (1):
  drm/amd/display: Remove Phantom Pipe Check When Calculating K1 and K2

Gianna Binder (1):
  drm/amd/display: Create debugging mechanism for Gaming FAMS

Harry Wentland (1):
  drm/amd/display: Fix the delta clamping for shaper LUT

Hong-lu Cheng (1):
  drm/amd/display: Remove asserts

Ilya Bakoulin (1):
  drm/amd/display: Work around bad DPCD state on link loss

Melissa Wen (1):
  drm/amd/display: program DPP shaper and 3D LUT if updated

 .../amd/display/amdgpu_dm/amdgpu_dm_helpers.c |  26 ++++
 drivers/gpu/drm/amd/display/dc/core/dc.c      | 121 +++++++++++++++++-
 drivers/gpu/drm/amd/display/dc/dc.h           |  14 +-
 .../amd/display/dc/dcn10/dcn10_cm_common.c    |  19 ++-
 .../amd/display/dc/dcn10/dcn10_cm_common.h    |   1 +
 .../amd/display/dc/dcn10/dcn10_hw_sequencer.c |   2 +-
 .../drm/amd/display/dc/dcn20/dcn20_hwseq.c    |  11 +-
 .../drm/amd/display/dc/dcn30/dcn30_dwb_cm.c   |   2 +-
 .../drm/amd/display/dc/dcn30/dcn30_hwseq.c    |   2 +-
 .../drm/amd/display/dc/dcn30/dcn30_resource.c |   3 +-
 .../drm/amd/display/dc/dcn32/dcn32_hwseq.c    |  10 +-
 .../display/dc/dcn32/dcn32_resource_helpers.c |   3 +-
 .../dc/dml/dcn20/display_mode_vba_20.c        |  16 ++-
 .../dc/link/protocols/link_dp_irq_handler.c   |  26 ++++
 14 files changed, 224 insertions(+), 32 deletions(-)

-- 
2.39.2

