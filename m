Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 869B3C433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Apr 2022 02:40:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EFA9210EF70;
	Wed, 27 Apr 2022 02:40:24 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2042.outbound.protection.outlook.com [40.107.93.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1C53010EF70
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 Apr 2022 02:40:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XM1Qz/x0PFosMG/rv9xm7WUy/ClIwSZBHvFBH1RrY5wqJK9vOH5toDOsVSUIidzvoVe/XfGKt9WbbWHHR7vFM+KyYhpKfVrJT3uCfDEKEYffmL3U/6Lc4/yhyB1ypxEUPdtZtp73+Svkp5q7FypJW60z4cHyqNtRDSS/Vl2n1q0BVEaZoTwQ7LKKDaAZJRv+uVMgd4jBEDGoTheKnhg2ydS8ncKToqJ9caTeu8sm/ee8MkZ7cirsrKegpDQrSqYCNJTWmyT9HqhpDG7ofEBWYLMvXg4EaPDlvTqvftYT4/SD0qnhJOD09wuh1BicrzaKXdyYRxLqh0C0ggHIvD1hag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pd3RSnOYlKWY8J1dfdicbmotxLub6eTtcJPROIFyFrk=;
 b=HmIrIos/uULXg3AqFmU0I12/lIDiGYimw0evQ+8+tBopfs+sIZDhdntVaka81cBSxfXsdoQTvHPSjiwBZCKOyCsJHQrFbSF0kjzkGCTjeSiaYkMZUsRhiRKU+e4Q0abuHzSOrBm9PWv2lUto0NayXWi/FDL1kJWSCoTdRloxpeiVoV+5qE6RKYkpgwnK86l0R8UOcjCsDQRQxVt83EJ+KIyHI+oF4ex6UfRn/jbCuda/A1cbqCyCS08ORYVpAbcNMSPCJ+1C5fI8dhMusMwxQbw5AJQi1FaSePxcVZ75nXSXDAAB7L9S/YM+lC4VI2Ie38NY73Yj0mgcbOJX3m2vKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pd3RSnOYlKWY8J1dfdicbmotxLub6eTtcJPROIFyFrk=;
 b=b+qqyXAfUYusKLNnNgZnBsc5OmqwQw5HdX+/MfX1mPI6w1o6+CLWBSS8J81/3B0KipBOLVGTEr2B7TuIJKFkNWJEy47nv1YTjd8qd1vb3ksocyBEkvpEYrh3X/tDlXgKCpsePJLiE4ah9oX+dMbfPRIe5hemcB+U3dXe6ztN9FY=
Received: from MW4PR03CA0118.namprd03.prod.outlook.com (2603:10b6:303:b7::33)
 by MWHPR12MB1488.namprd12.prod.outlook.com (2603:10b6:301:f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15; Wed, 27 Apr
 2022 02:40:18 +0000
Received: from CO1NAM11FT011.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b7:cafe::38) by MW4PR03CA0118.outlook.office365.com
 (2603:10b6:303:b7::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14 via Frontend
 Transport; Wed, 27 Apr 2022 02:40:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT011.mail.protection.outlook.com (10.13.175.186) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5206.12 via Frontend Transport; Wed, 27 Apr 2022 02:40:17 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 26 Apr
 2022 21:40:17 -0500
Received: from wayne-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.24
 via Frontend Transport; Tue, 26 Apr 2022 21:40:08 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 0/8] DC Patches April 27, 2022
Date: Wed, 27 Apr 2022 10:39:51 +0800
Message-ID: <20220427023959.1241450-1-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.36.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f378622c-768e-4136-059c-08da27f7442b
X-MS-TrafficTypeDiagnostic: MWHPR12MB1488:EE_
X-Microsoft-Antispam-PRVS: <MWHPR12MB14888F34D7894EFDCF127832FCFA9@MWHPR12MB1488.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FPudD3sssSW4uutny5cc4zziBDMhlD6oj6nuFho35Fxd2qxwNekI8dGBVAtrHNJgzL5poUUvZiCXZcYvQNGCpd/OvkI8UrjsmjzbqIFsLW8iFGgplO6Rdlx+IjyxKGtH8ss2AMyUMvVoFBRs0ynz+ZYIJv8zlv1WFcWbbPnxO9rcX8BlqbWdnrSMGkup051bQpyNaWXL4TmouIwjBsjRe13Th6p7a7fNDYh1TZItSJSN9dR2UduSlaExLIfkfFeIV4Yh+N40PadQXQycyvcweWa+5rtjiE1RmwKybbHNpPJSUUZJyJ78oD4GIMcTHLHC+QiRnKKaSgyK2WRhfEdjdUObxnx9gnh4tTz768uRhXDLZKYCgmyH8gTEaidqMwjltDg7ZrFzw0qYH8Hi+wJ/uV8n8JYYM9Rwcoh76yoNPPALxX5ZWYu1A75fSV2rZLpBn4GSjXFgHre7VAwW/t5flrdtRuPvkQre545nWubus9uJQqbmeDqp43AK57cwAGlLAjexUMP6GTesHfsXxrMhKmqvnqPWEbqDBT23KKX8Jf1rOV+vlXcXUUypo+7bCMF7VzFsNigSLj+wkLWYT07jiciQa0WQ/pHMy1JG0DHfecGLxhculwjm4tJCIKcxHF4d2igoWUU/pXpyhVmqwmYKuVQ0H0Ve8YwWr8yY9V0dbk5NTnixKY737+KY/s/5uFyBdvHcHpA7AEPiNeo7XpSZBw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(336012)(47076005)(83380400001)(186003)(1076003)(508600001)(86362001)(426003)(36756003)(356005)(5660300002)(8936002)(2906002)(81166007)(4326008)(2616005)(7696005)(26005)(54906003)(6916009)(70586007)(8676002)(70206006)(36860700001)(40460700003)(316002)(6666004)(82310400005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2022 02:40:17.8547 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f378622c-768e-4136-059c-08da27f7442b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT011.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1488
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
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com, Wayne Lin <Wayne.Lin@amd.com>,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This DC patchset brings improvements in multiple areas. In summary, we highlight:

* Have optc3 function accessible to newer DCN
* Add CM boot option for USB4 tunneling
* Fix system hang issue when game resolution is changed
* Remove outdated register for dcn3+
* Add new DSC interface to disconnect from pipe
* Clean up pixel format types in enum surface_pixel_format

---

Anthony Koo (1):
  drm/amd/display: [FW Promotion] Release 0.0.115.0

Aric Cyr (2):
  drm/amd/display: Clean up pixel format types
  drm/amd/display: 3.2.184

Eric Bernstein (1):
  drm/amd/display: Add new DSC interface to disconnect from pipe

Evgenii Krasnikov (1):
  Revert "drm/amd/display: Reset cached PSR parameters after hibernate"

Jimmy Kizito (1):
  drm/amd/display: Add Connection Manager boot option.

Lee, Alvin (1):
  drm/amd/display: Make OPTC3 function accessible to other DCN

Tse, Kaitlyn (1):
  drm/amd/display: Remove outdated register for dcn3+

 drivers/gpu/drm/amd/display/dc/core/dc_link.c |  7 +---
 drivers/gpu/drm/amd/display/dc/dc.h           |  2 +-
 drivers/gpu/drm/amd/display/dc/dc_hw_types.h  |  3 +-
 .../gpu/drm/amd/display/dc/dcn20/dcn20_dsc.c  | 11 ++++++
 .../gpu/drm/amd/display/dc/dcn30/dcn30_mpc.h  |  5 ---
 .../gpu/drm/amd/display/dc/dcn30/dcn30_optc.h |  2 +-
 drivers/gpu/drm/amd/display/dc/inc/hw/dsc.h   |  1 +
 drivers/gpu/drm/amd/display/dmub/dmub_srv.h   |  1 +
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   | 36 ++++++++++++++++++-
 .../gpu/drm/amd/display/dmub/src/dmub_dcn31.c |  1 +
 10 files changed, 54 insertions(+), 15 deletions(-)

-- 
2.36.0

