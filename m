Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6109CC4332F
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Nov 2023 19:04:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2D5C710E820;
	Wed,  8 Nov 2023 19:03:59 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2058.outbound.protection.outlook.com [40.107.92.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 53C2A10E824
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Nov 2023 19:03:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=grv0Uyica1VOXhfBhxvJCpHuNzvDMvSXXAf5Y04mjEu44OI7aeo2CTxp2pgqO7DRV9VMkmsqt4+Kn2i9j27El54mvPBCDGC8oi944FGp/punb3ETcsHEs2b7RPk9YK9qW+xVsGWWvtpnxSfHZgcX4AvCfAQc3UbNX4hSvGMoGc6f8kIxidGP4fmdhcx6JRQQAPX1f1uRpl1PG4y4J0mTQ5MDjwYuASVLZMe1M1N73IBtsCvINIqaJLXFEp5xJfXqq9vN/y2GBKLKdYJRdoCMJxgpE4Fu9HoBaeQuzmXC/RQVx/p/Yc0QpaRYs4i6cxyNoVtB1fGYP/wZVnSOtYwipw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fvCdFzrwMoG5glZp/VcxCJqrNwYrwqIU6oqgKl0it24=;
 b=HkFxuaPU0a1uaS2iw4Z4htBYN6rGLHVcfqXp0Jk8gxGZEJqYdp9af4G6jqIfmzgD3DlNft8GjbZCLY5t6GggcefFAj7ZgBePhD8ArriLpwIwWHb9p7GK2GWFGNkdM2ArVyE9uOBcMPF1lldQdM8OibwBb/neLr6JnGdX2y7SMSZ/SS/hUhio/qB2gf9mlnmxvGvOWhFWz4RXCQ6SJUK0eVRvCv57ztN+nIfTRLivfYgjvMwt0bj1Xi3pbFnfN3ch7lqdHCeowilDAqwUjf4xPhq75HMK1gA3FS5LUllUb1SsjB4JvVAuELoFlD2NF9TkzXlJiQlCQ5QxNyfecruF0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fvCdFzrwMoG5glZp/VcxCJqrNwYrwqIU6oqgKl0it24=;
 b=49HGjaItwYXFpwmdi3c1nuPPiMvZg0ydPegPjyYzckWcKThv4w/uekgY9uOI14Fhjs0qUoVajmCMQKwPxC+1LjP59hr78JMaLaiQlY8plknrH38X0F5QQQnMbCMwo6Hcv4Ou+ds9ZSNgz0tnCfxLbBIf/NIHl7ve3fFrUnDJJEg=
Received: from MN2PR03CA0020.namprd03.prod.outlook.com (2603:10b6:208:23a::25)
 by CH2PR12MB5515.namprd12.prod.outlook.com (2603:10b6:610:34::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Wed, 8 Nov
 2023 19:03:19 +0000
Received: from BL6PEPF0001AB58.namprd02.prod.outlook.com
 (2603:10b6:208:23a:cafe::e8) by MN2PR03CA0020.outlook.office365.com
 (2603:10b6:208:23a::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.18 via Frontend
 Transport; Wed, 8 Nov 2023 19:03:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB58.mail.protection.outlook.com (10.167.241.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6977.16 via Frontend Transport; Wed, 8 Nov 2023 19:03:19 +0000
Received: from dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Wed, 8 Nov
 2023 13:03:16 -0600
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 05/20] drm/amd/display: Refactor resource into component
 directory
Date: Wed, 8 Nov 2023 11:44:20 -0700
Message-ID: <20231108185501.45359-6-alex.hung@amd.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231108185501.45359-1-alex.hung@amd.com>
References: <20231108185501.45359-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB58:EE_|CH2PR12MB5515:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b3b3d3c-7f2f-4757-1851-08dbe08d5f59
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nJBnSzU83qFg98PV0AIQZDF1AZZewztGDxZj97F8xSDJwuYQw5DIp09FqQPPk46QNyOkJJSm3Rh3pmSf5j2whXk3x9mGT3uvP60LAgm/Ik6ryt4u3huNLtWWo3dDtdO8lA1dIzs5X1uvs4n9voVcsyXirmHyZ1tLJGyj56AhNurnammsRg1Do1wDeKJSQf4s31OAvD3Kv20Jk6DZDCtp82+ZCpZ00oieglthaLghT3pbRnHHILOhnyiypXDomWfPTVGhREPUVc4awl4iJ1iLXjt8RhtTYqN49T2VFKQTooGm/S8y5x8ilcWo4RKdcAofqs8wHhoqW/hB0whHITAhGwOumWYx3V/Y0Z8aLv4Y/X+stmKAkoV6bI5VDyEFuB03PuXlX2hDFBp8ItRjICBY7Ap4jX7/EOqilr65weGMfgeSYfeSXmibfOBBXcOO0COeoOSdGsTaCBa6e4xZ1aGRg0XXq+CEGIvcntiDMg/huVuk/c3OouTfBtpeq0e87uYioxB38xiWL+28nzhyeYjKLEJ1GrD7HvAgGhdfI9YCrJsm4PIXT7PQtt5ZxB03Rh2UN8Z6ta0YicpLLopD7zTcNxQfWx03/VdtGpabr34GuElfDNrZ6+FLKQZfr2htSDROjMEiRP+6dzxc4sdu1w4epM7Y4j4PJx26fJyoWMn9sjGRr9y3hDYq615QyCedvFyd4XzF9bAxvOSfnJ3bTFL0PPfTabaaFu7ndsxoaQCz3O/+okhp0ZOEJdLfqo/hRmkkPnjmbK/Gvxtr6zih1OqWLLBUZJ32BkzTloJs8JUikCLyUoIXqItrQPOS6BK+llXh
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(136003)(376002)(346002)(39860400002)(230922051799003)(230273577357003)(230173577357003)(451199024)(186009)(64100799003)(82310400011)(1800799009)(36840700001)(46966006)(40470700004)(30864003)(66899024)(40460700003)(40480700001)(6666004)(2616005)(7696005)(19627235002)(478600001)(36860700001)(36756003)(81166007)(86362001)(356005)(82740400003)(26005)(5660300002)(41300700001)(1076003)(70206006)(70586007)(44832011)(2906002)(16526019)(336012)(83380400001)(54906003)(8936002)(47076005)(316002)(4326008)(6916009)(8676002)(426003)(36900700001)(559001)(579004);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2023 19:03:19.7273 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b3b3d3c-7f2f-4757-1851-08dbe08d5f59
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB58.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB5515
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
Cc: stylon.wang@amd.com, chiahsuan.chung@amd.com, Sunpeng.Li@amd.com,
 Martin Leung <martin.leung@amd.com>, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, Alex
 Hung <alex.hung@amd.com>, jerry.zuo@amd.com, Aurabindo.Pillai@amd.com,
 hersenxs.wu@amd.com, Mounika Adhuri <moadhuri@amd.com>, wayne.lin@amd.com,
 Harry.Wentland@amd.com, agustin.gutierrez@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Mounika Adhuri <moadhuri@amd.com>

[WHY]
Move all resource files to unique folder resource.

[HOW]
Created resource folder in dc, moved the
dcnxx_resource.c and dcnxx_resource.h files into
corresponding new folders inside the resource and
made appropriate changes for compilation in Makefiles.

Reviewed-by: Martin Leung <martin.leung@amd.com>
Acked-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Mounika Adhuri <moadhuri@amd.com>
---
 drivers/gpu/drm/amd/display/Makefile          |   1 +
 .../display/amdgpu_dm/amdgpu_dm_mst_types.c   |   2 +-
 drivers/gpu/drm/amd/display/dc/Makefile       |   5 +-
 .../gpu/drm/amd/display/dc/core/dc_resource.c |   4 +-
 .../gpu/drm/amd/display/dc/dce100/Makefile    |  46 ----
 .../gpu/drm/amd/display/dc/dce110/Makefile    |   4 +-
 .../gpu/drm/amd/display/dc/dce112/Makefile    |   3 +-
 .../gpu/drm/amd/display/dc/dce120/Makefile    |   2 +-
 drivers/gpu/drm/amd/display/dc/dce80/Makefile |   3 +-
 drivers/gpu/drm/amd/display/dc/dcn10/Makefile |   2 +-
 drivers/gpu/drm/amd/display/dc/dcn20/Makefile |   2 +-
 .../gpu/drm/amd/display/dc/dcn201/Makefile    |   2 +-
 drivers/gpu/drm/amd/display/dc/dcn21/Makefile |   2 +-
 drivers/gpu/drm/amd/display/dc/dcn30/Makefile |   1 -
 .../gpu/drm/amd/display/dc/dcn301/Makefile    |   2 +-
 .../gpu/drm/amd/display/dc/dcn302/Makefile    |   2 +-
 .../gpu/drm/amd/display/dc/dcn303/Makefile    |   2 +-
 drivers/gpu/drm/amd/display/dc/dcn31/Makefile |   2 +-
 .../gpu/drm/amd/display/dc/dcn314/Makefile    |   2 +-
 .../gpu/drm/amd/display/dc/dcn315/Makefile    |  30 ---
 .../gpu/drm/amd/display/dc/dcn316/Makefile    |  30 ---
 drivers/gpu/drm/amd/display/dc/dcn32/Makefile |   2 +-
 .../display/dc/dcn32/dcn32_resource_helpers.c |   2 +-
 .../gpu/drm/amd/display/dc/dcn321/Makefile    |   2 +-
 drivers/gpu/drm/amd/display/dc/dcn35/Makefile |   2 +-
 .../drm/amd/display/dc/dml/calcs/dcn_calcs.c  |   2 +-
 .../gpu/drm/amd/display/dc/resource/Makefile  | 199 ++++++++++++++++++
 .../{ => resource}/dce100/dce100_resource.c   |   0
 .../{ => resource}/dce100/dce100_resource.h   |   0
 .../{ => resource}/dce110/dce110_resource.c   |   0
 .../{ => resource}/dce110/dce110_resource.h   |   0
 .../{ => resource}/dce112/dce112_resource.c   |   0
 .../{ => resource}/dce112/dce112_resource.h   |   0
 .../{ => resource}/dce120/dce120_resource.c   |   2 +-
 .../{ => resource}/dce120/dce120_resource.h   |   0
 .../display/dc/resource/dce80/CMakeLists.txt  |   4 +
 .../dc/{ => resource}/dce80/dce80_resource.c  |   0
 .../dc/{ => resource}/dce80/dce80_resource.h  |   0
 .../dc/{ => resource}/dcn10/dcn10_resource.c  |  25 ++-
 .../dc/{ => resource}/dcn10/dcn10_resource.h  |   0
 .../dc/{ => resource}/dcn20/dcn20_resource.c  |  24 +--
 .../dc/{ => resource}/dcn20/dcn20_resource.h  |   0
 .../{ => resource}/dcn201/dcn201_resource.c   |  14 +-
 .../{ => resource}/dcn201/dcn201_resource.h   |   0
 .../dc/{ => resource}/dcn21/dcn21_resource.c  |   6 +-
 .../dc/{ => resource}/dcn21/dcn21_resource.h  |   0
 .../dc/{ => resource}/dcn30/dcn30_resource.c  |   2 +-
 .../dc/{ => resource}/dcn30/dcn30_resource.h  |   0
 .../{ => resource}/dcn301/dcn301_resource.c   |   4 +-
 .../{ => resource}/dcn301/dcn301_resource.h   |   0
 .../{ => resource}/dcn302/dcn302_resource.c   |   4 +-
 .../{ => resource}/dcn302/dcn302_resource.h   |   0
 .../{ => resource}/dcn303/dcn303_resource.c   |   4 +-
 .../{ => resource}/dcn303/dcn303_resource.h   |   0
 .../dc/{ => resource}/dcn31/dcn31_resource.c  |   2 +-
 .../dc/{ => resource}/dcn31/dcn31_resource.h  |   0
 .../{ => resource}/dcn314/dcn314_resource.c   |   0
 .../{ => resource}/dcn314/dcn314_resource.h   |   0
 .../{ => resource}/dcn315/dcn315_resource.c   |   0
 .../{ => resource}/dcn315/dcn315_resource.h   |   0
 .../{ => resource}/dcn316/dcn316_resource.c   |   0
 .../{ => resource}/dcn316/dcn316_resource.h   |   0
 .../dc/{ => resource}/dcn32/dcn32_resource.c  |   4 +-
 .../dc/{ => resource}/dcn32/dcn32_resource.h  |   0
 .../{ => resource}/dcn321/dcn321_resource.c   |   2 +-
 .../{ => resource}/dcn321/dcn321_resource.h   |   0
 .../dc/{ => resource}/dcn35/dcn35_resource.c  |   2 +-
 .../dc/{ => resource}/dcn35/dcn35_resource.h  |   0
 68 files changed, 276 insertions(+), 181 deletions(-)
 delete mode 100644 drivers/gpu/drm/amd/display/dc/dce100/Makefile
 delete mode 100644 drivers/gpu/drm/amd/display/dc/dcn315/Makefile
 delete mode 100644 drivers/gpu/drm/amd/display/dc/dcn316/Makefile
 create mode 100644 drivers/gpu/drm/amd/display/dc/resource/Makefile
 rename drivers/gpu/drm/amd/display/dc/{ => resource}/dce100/dce100_resource.c (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => resource}/dce100/dce100_resource.h (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => resource}/dce110/dce110_resource.c (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => resource}/dce110/dce110_resource.h (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => resource}/dce112/dce112_resource.c (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => resource}/dce112/dce112_resource.h (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => resource}/dce120/dce120_resource.c (99%)
 rename drivers/gpu/drm/amd/display/dc/{ => resource}/dce120/dce120_resource.h (100%)
 create mode 100644 drivers/gpu/drm/amd/display/dc/resource/dce80/CMakeLists.txt
 rename drivers/gpu/drm/amd/display/dc/{ => resource}/dce80/dce80_resource.c (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => resource}/dce80/dce80_resource.h (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => resource}/dcn10/dcn10_resource.c (99%)
 rename drivers/gpu/drm/amd/display/dc/{ => resource}/dcn10/dcn10_resource.h (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => resource}/dcn20/dcn20_resource.c (99%)
 rename drivers/gpu/drm/amd/display/dc/{ => resource}/dcn20/dcn20_resource.h (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => resource}/dcn201/dcn201_resource.c (99%)
 rename drivers/gpu/drm/amd/display/dc/{ => resource}/dcn201/dcn201_resource.h (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => resource}/dcn21/dcn21_resource.c (99%)
 rename drivers/gpu/drm/amd/display/dc/{ => resource}/dcn21/dcn21_resource.h (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => resource}/dcn30/dcn30_resource.c (99%)
 rename drivers/gpu/drm/amd/display/dc/{ => resource}/dcn30/dcn30_resource.h (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => resource}/dcn301/dcn301_resource.c (99%)
 rename drivers/gpu/drm/amd/display/dc/{ => resource}/dcn301/dcn301_resource.h (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => resource}/dcn302/dcn302_resource.c (99%)
 rename drivers/gpu/drm/amd/display/dc/{ => resource}/dcn302/dcn302_resource.h (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => resource}/dcn303/dcn303_resource.c (99%)
 rename drivers/gpu/drm/amd/display/dc/{ => resource}/dcn303/dcn303_resource.h (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => resource}/dcn31/dcn31_resource.c (99%)
 rename drivers/gpu/drm/amd/display/dc/{ => resource}/dcn31/dcn31_resource.h (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => resource}/dcn314/dcn314_resource.c (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => resource}/dcn314/dcn314_resource.h (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => resource}/dcn315/dcn315_resource.c (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => resource}/dcn315/dcn315_resource.h (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => resource}/dcn316/dcn316_resource.c (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => resource}/dcn316/dcn316_resource.h (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => resource}/dcn32/dcn32_resource.c (99%)
 rename drivers/gpu/drm/amd/display/dc/{ => resource}/dcn32/dcn32_resource.h (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => resource}/dcn321/dcn321_resource.c (99%)
 rename drivers/gpu/drm/amd/display/dc/{ => resource}/dcn321/dcn321_resource.h (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => resource}/dcn35/dcn35_resource.c (99%)
 rename drivers/gpu/drm/amd/display/dc/{ => resource}/dcn35/dcn35_resource.h (100%)

diff --git a/drivers/gpu/drm/amd/display/Makefile b/drivers/gpu/drm/amd/display/Makefile
index af17ab8027df..71192fc81a20 100644
--- a/drivers/gpu/drm/amd/display/Makefile
+++ b/drivers/gpu/drm/amd/display/Makefile
@@ -30,6 +30,7 @@ subdir-ccflags-y += -I$(FULL_AMD_DISPLAY_PATH)/dc/inc/
 subdir-ccflags-y += -I$(FULL_AMD_DISPLAY_PATH)/dc/inc/hw
 subdir-ccflags-y += -I$(FULL_AMD_DISPLAY_PATH)/dc/clk_mgr
 subdir-ccflags-y += -I$(FULL_AMD_DISPLAY_PATH)/dc/hwss
+subdir-ccflags-y += -I$(FULL_AMD_DISPLAY_PATH)/dc/resource
 subdir-ccflags-y += -I$(FULL_AMD_DISPLAY_PATH)/modules/inc
 subdir-ccflags-y += -I$(FULL_AMD_DISPLAY_PATH)/modules/freesync
 subdir-ccflags-y += -I$(FULL_AMD_DISPLAY_PATH)/modules/color
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
index 11da0eebee6c..ec87e31c6fe8 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
@@ -44,7 +44,7 @@
 #include "amdgpu_dm_debugfs.h"
 #endif
 
-#include "dc/dcn20/dcn20_resource.h"
+#include "dc/resource/dcn20/dcn20_resource.h"
 
 #define PEAK_FACTOR_X1000 1006
 
diff --git a/drivers/gpu/drm/amd/display/dc/Makefile b/drivers/gpu/drm/amd/display/dc/Makefile
index 3a169b78e7e4..ab51a065cf0e 100644
--- a/drivers/gpu/drm/amd/display/dc/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/Makefile
@@ -22,7 +22,7 @@
 #
 # Makefile for Display Core (dc) component.
 
-DC_LIBS = basics bios dml clk_mgr dce gpio hwss irq link virtual dsc
+DC_LIBS = basics bios dml clk_mgr dce gpio hwss irq link virtual dsc resource
 
 ifdef CONFIG_DRM_AMD_DC_FP
 
@@ -38,8 +38,6 @@ DC_LIBS += dcn302
 DC_LIBS += dcn303
 DC_LIBS += dcn31
 DC_LIBS += dcn314
-DC_LIBS += dcn315
-DC_LIBS += dcn316
 DC_LIBS += dcn32
 DC_LIBS += dcn321
 DC_LIBS += dcn35
@@ -51,7 +49,6 @@ DC_LIBS += dce120
 
 DC_LIBS += dce112
 DC_LIBS += dce110
-DC_LIBS += dce100
 DC_LIBS += dce80
 
 ifdef CONFIG_DRM_AMD_DC_SI
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index 1d48278cba96..06fc4c5a3b69 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -69,8 +69,8 @@
 #include "dcn314/dcn314_resource.h"
 #include "dcn315/dcn315_resource.h"
 #include "dcn316/dcn316_resource.h"
-#include "../dcn32/dcn32_resource.h"
-#include "../dcn321/dcn321_resource.h"
+#include "dcn32/dcn32_resource.h"
+#include "dcn321/dcn321_resource.h"
 #include "dcn35/dcn35_resource.h"
 
 #define VISUAL_CONFIRM_BASE_DEFAULT 3
diff --git a/drivers/gpu/drm/amd/display/dc/dce100/Makefile b/drivers/gpu/drm/amd/display/dc/dce100/Makefile
deleted file mode 100644
index 0d2f6bbf7558..000000000000
--- a/drivers/gpu/drm/amd/display/dc/dce100/Makefile
+++ /dev/null
@@ -1,46 +0,0 @@
-#
-# Copyright 2017 Advanced Micro Devices, Inc.
-#
-# Permission is hereby granted, free of charge, to any person obtaining a
-# copy of this software and associated documentation files (the "Software"),
-# to deal in the Software without restriction, including without limitation
-# the rights to use, copy, modify, merge, publish, distribute, sublicense,
-# and/or sell copies of the Software, and to permit persons to whom the
-# Software is furnished to do so, subject to the following conditions:
-#
-# The above copyright notice and this permission notice shall be included in
-# all copies or substantial portions of the Software.
-#
-# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
-# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
-# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
-# THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
-# OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
-# ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
-# OTHER DEALINGS IN THE SOFTWARE.
-#
-#
-# Makefile for the 'controller' sub-component of DAL.
-# It provides the control and status of HW CRTC block.
-
-CFLAGS_$(AMDDALPATH)/dc/dce100/dce100_resource.o = $(call cc-disable-warning, override-init)
-
-DCE100 = dce100_resource.o
-
-AMD_DAL_DCE100 = $(addprefix $(AMDDALPATH)/dc/dce100/,$(DCE100))
-
-AMD_DISPLAY_FILES += $(AMD_DAL_DCE100)
-
-
-###############################################################################
-# DCE 10x
-###############################################################################
-ifdef 0#CONFIG_DRM_AMD_DC_DCE11_0
-TG_DCE100 = dce100_resource.o
-
-AMD_DAL_TG_DCE100 = $(addprefix \
-	$(AMDDALPATH)/dc/dce100/,$(TG_DCE100))
-
-AMD_DISPLAY_FILES += $(AMD_DAL_TG_DCE100)
-endif
-
diff --git a/drivers/gpu/drm/amd/display/dc/dce110/Makefile b/drivers/gpu/drm/amd/display/dc/dce110/Makefile
index 695a50ed5ad2..f0777d61c2cb 100644
--- a/drivers/gpu/drm/amd/display/dc/dce110/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/dce110/Makefile
@@ -26,8 +26,8 @@
 CFLAGS_$(AMDDALPATH)/dc/dce110/dce110_resource.o = $(call cc-disable-warning, override-init)
 
 DCE110 = dce110_timing_generator.o \
-dce110_compressor.o dce110_resource.o \
-dce110_opp_regamma_v.o dce110_opp_csc_v.o dce110_timing_generator_v.o \
+dce110_compressor.o dce110_opp_regamma_v.o \
+dce110_opp_csc_v.o dce110_timing_generator_v.o \
 dce110_mem_input_v.o dce110_opp_v.o dce110_transform_v.o
 
 AMD_DAL_DCE110 = $(addprefix $(AMDDALPATH)/dc/dce110/,$(DCE110))
diff --git a/drivers/gpu/drm/amd/display/dc/dce112/Makefile b/drivers/gpu/drm/amd/display/dc/dce112/Makefile
index e846ef58cab3..7e92effec894 100644
--- a/drivers/gpu/drm/amd/display/dc/dce112/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/dce112/Makefile
@@ -25,8 +25,7 @@
 
 CFLAGS_$(AMDDALPATH)/dc/dce112/dce112_resource.o = $(call cc-disable-warning, override-init)
 
-DCE112 = dce112_compressor.o \
-dce112_resource.o
+DCE112 = dce112_compressor.o
 
 AMD_DAL_DCE112 = $(addprefix $(AMDDALPATH)/dc/dce112/,$(DCE112))
 
diff --git a/drivers/gpu/drm/amd/display/dc/dce120/Makefile b/drivers/gpu/drm/amd/display/dc/dce120/Makefile
index 097cf407a15d..1e3ef68a452a 100644
--- a/drivers/gpu/drm/amd/display/dc/dce120/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/dce120/Makefile
@@ -26,7 +26,7 @@
 
 CFLAGS_$(AMDDALPATH)/dc/dce120/dce120_resource.o = $(call cc-disable-warning, override-init)
 
-DCE120 = dce120_resource.o dce120_timing_generator.o \
+DCE120 = dce120_timing_generator.o
 
 AMD_DAL_DCE120 = $(addprefix $(AMDDALPATH)/dc/dce120/,$(DCE120))
 
diff --git a/drivers/gpu/drm/amd/display/dc/dce80/Makefile b/drivers/gpu/drm/amd/display/dc/dce80/Makefile
index 93dd68c31275..7eefffbdc925 100644
--- a/drivers/gpu/drm/amd/display/dc/dce80/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/dce80/Makefile
@@ -25,8 +25,7 @@
 
 CFLAGS_$(AMDDALPATH)/dc/dce80/dce80_resource.o = $(call cc-disable-warning, override-init)
 
-DCE80 = dce80_timing_generator.o \
-	dce80_resource.o
+DCE80 = dce80_timing_generator.o
 
 AMD_DAL_DCE80 = $(addprefix $(AMDDALPATH)/dc/dce80/,$(DCE80))
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/Makefile b/drivers/gpu/drm/amd/display/dc/dcn10/Makefile
index 2d2007c3e2b6..1eb7418ced3a 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/Makefile
@@ -22,7 +22,7 @@
 #
 # Makefile for DCN.
 
-DCN10 = dcn10_init.o dcn10_resource.o dcn10_ipp.o \
+DCN10 = dcn10_init.o dcn10_ipp.o \
 		dcn10_hw_sequencer_debug.o \
 		dcn10_dpp.o dcn10_opp.o dcn10_optc.o \
 		dcn10_hubp.o dcn10_mpc.o \
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/Makefile b/drivers/gpu/drm/amd/display/dc/dcn20/Makefile
index d7dc9696a8c8..1cac1eca8111 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/Makefile
@@ -2,7 +2,7 @@
 #
 # Makefile for DCN.
 
-DCN20 = dcn20_resource.o dcn20_init.o dcn20_dpp.o dcn20_dpp_cm.o dcn20_hubp.o \
+DCN20 = dcn20_init.o dcn20_dpp.o dcn20_dpp_cm.o dcn20_hubp.o \
 		dcn20_mpc.o dcn20_opp.o dcn20_hubbub.o dcn20_optc.o dcn20_mmhubbub.o \
 		dcn20_stream_encoder.o dcn20_link_encoder.o dcn20_dccg.o \
 		dcn20_vmid.o dcn20_dwb.o dcn20_dwb_scl.o
diff --git a/drivers/gpu/drm/amd/display/dc/dcn201/Makefile b/drivers/gpu/drm/amd/display/dc/dcn201/Makefile
index 3a41a97b0729..c069a894db92 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn201/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/dcn201/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: MIT
 #
 # Makefile for DCN.
-DCN201 = dcn201_init.o dcn201_resource.o \
+DCN201 = dcn201_init.o \
 	dcn201_hubbub.o\
 	dcn201_mpc.o dcn201_hubp.o dcn201_opp.o dcn201_optc.o dcn201_dpp.o \
 	dcn201_dccg.o dcn201_link_encoder.o
diff --git a/drivers/gpu/drm/amd/display/dc/dcn21/Makefile b/drivers/gpu/drm/amd/display/dc/dcn21/Makefile
index ce1be0afae4a..dd1eea7212f4 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn21/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/dcn21/Makefile
@@ -2,7 +2,7 @@
 #
 # Makefile for DCN21.
 
-DCN21 = dcn21_init.o dcn21_hubp.o dcn21_hubbub.o dcn21_resource.o \
+DCN21 = dcn21_init.o dcn21_hubp.o dcn21_hubbub.o \
 	 dcn21_link_encoder.o dcn21_dccg.o
 
 AMD_DAL_DCN21 = $(addprefix $(AMDDALPATH)/dc/dcn21/,$(DCN21))
diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/Makefile b/drivers/gpu/drm/amd/display/dc/dcn30/Makefile
index af4d2065d2c1..9dcf06c0954d 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/Makefile
@@ -38,7 +38,6 @@ DCN30 := \
 	dcn30_dwb_cm.o \
 	dcn30_cm_common.o \
 	dcn30_mmhubbub.o \
-	dcn30_resource.o \
 	dcn30_dio_link_encoder.o
 
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn301/Makefile b/drivers/gpu/drm/amd/display/dc/dcn301/Makefile
index 30fbc5e06dca..cbf59d7e78c4 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn301/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/dcn301/Makefile
@@ -10,7 +10,7 @@
 #
 # Makefile for dcn30.
 
-DCN301 = dcn301_init.o dcn301_resource.o dcn301_dccg.o \
+DCN301 = dcn301_init.o dcn301_dccg.o \
 		dcn301_dio_link_encoder.o dcn301_panel_cntl.o dcn301_hubbub.o \
 		dcn301_optc.o
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn302/Makefile b/drivers/gpu/drm/amd/display/dc/dcn302/Makefile
index 95b66baf39e9..0fcd03569d74 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn302/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/dcn302/Makefile
@@ -5,7 +5,7 @@
 #
 # Makefile for dcn302.
 
-DCN3_02 = dcn302_init.o dcn302_resource.o
+DCN3_02 = dcn302_init.o
 
 AMD_DAL_DCN3_02 = $(addprefix $(AMDDALPATH)/dc/dcn302/,$(DCN3_02))
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn303/Makefile b/drivers/gpu/drm/amd/display/dc/dcn303/Makefile
index d7b3ad780e5d..a954e316aca2 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn303/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/dcn303/Makefile
@@ -6,7 +6,7 @@
 #
 # Makefile for dcn303.
 
-DCN3_03 = dcn303_init.o dcn303_resource.o
+DCN3_03 = dcn303_init.o
 
 AMD_DAL_DCN3_03 = $(addprefix $(AMDDALPATH)/dc/dcn303/,$(DCN3_03))
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/Makefile b/drivers/gpu/drm/amd/display/dc/dcn31/Makefile
index 96e45c9efb46..212287008c0a 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/Makefile
@@ -10,7 +10,7 @@
 #
 # Makefile for dcn31.
 
-DCN31 = dcn31_resource.o dcn31_hubbub.o dcn31_init.o dcn31_hubp.o \
+DCN31 = dcn31_hubbub.o dcn31_init.o dcn31_hubp.o \
 	dcn31_dccg.o dcn31_optc.o dcn31_dio_link_encoder.o dcn31_panel_cntl.o \
 	dcn31_apg.o dcn31_hpo_dp_stream_encoder.o dcn31_hpo_dp_link_encoder.o \
 	dcn31_afmt.o dcn31_vpg.o
diff --git a/drivers/gpu/drm/amd/display/dc/dcn314/Makefile b/drivers/gpu/drm/amd/display/dc/dcn314/Makefile
index 72456debb99f..6ea47e00d62d 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn314/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/dcn314/Makefile
@@ -10,7 +10,7 @@
 #
 # Makefile for dcn314.
 
-DCN314 = dcn314_resource.o dcn314_init.o \
+DCN314 = dcn314_init.o \
 		dcn314_dio_stream_encoder.o dcn314_dccg.o dcn314_optc.o
 
 AMD_DAL_DCN314 = $(addprefix $(AMDDALPATH)/dc/dcn314/,$(DCN314))
diff --git a/drivers/gpu/drm/amd/display/dc/dcn315/Makefile b/drivers/gpu/drm/amd/display/dc/dcn315/Makefile
deleted file mode 100644
index 59381d24800b..000000000000
--- a/drivers/gpu/drm/amd/display/dc/dcn315/Makefile
+++ /dev/null
@@ -1,30 +0,0 @@
-#
-# Copyright © 2021 Advanced Micro Devices, Inc.
-#
-# Permission is hereby granted, free of charge, to any person obtaining a
-# copy of this software and associated documentation files (the "Software"),
-# to deal in the Software without restriction, including without limitation
-# the rights to use, copy, modify, merge, publish, distribute, sublicense,
-# and/or sell copies of the Software, and to permit persons to whom the
-# Software is furnished to do so, subject to the following conditions:
-#
-# The above copyright notice and this permission notice shall be included in
-# all copies or substantial portions of the Software.
-#
-# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
-# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
-# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
-# THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
-# OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
-# ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
-# OTHER DEALINGS IN THE SOFTWARE.
-#
-# Authors: AMD
-#
-# Makefile for dcn315.
-
-DCN315 = dcn315_resource.o
-
-AMD_DAL_DCN315 = $(addprefix $(AMDDALPATH)/dc/dcn315/,$(DCN315))
-
-AMD_DISPLAY_FILES += $(AMD_DAL_DCN315)
diff --git a/drivers/gpu/drm/amd/display/dc/dcn316/Makefile b/drivers/gpu/drm/amd/display/dc/dcn316/Makefile
deleted file mode 100644
index 819d44a9439b..000000000000
--- a/drivers/gpu/drm/amd/display/dc/dcn316/Makefile
+++ /dev/null
@@ -1,30 +0,0 @@
-#
-# Copyright 2021 Advanced Micro Devices, Inc.
-#
-# Permission is hereby granted, free of charge, to any person obtaining a
-# copy of this software and associated documentation files (the "Software"),
-# to deal in the Software without restriction, including without limitation
-# the rights to use, copy, modify, merge, publish, distribute, sublicense,
-# and/or sell copies of the Software, and to permit persons to whom the
-# Software is furnished to do so, subject to the following conditions:
-#
-# The above copyright notice and this permission notice shall be included in
-# all copies or substantial portions of the Software.
-#
-# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
-# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
-# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
-# THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
-# OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
-# ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
-# OTHER DEALINGS IN THE SOFTWARE.
-#
-# Authors: AMD
-#
-# Makefile for dcn316.
-
-DCN316 = dcn316_resource.o
-
-AMD_DAL_DCN316 = $(addprefix $(AMDDALPATH)/dc/dcn316/,$(DCN316))
-
-AMD_DISPLAY_FILES += $(AMD_DAL_DCN316)
diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/Makefile b/drivers/gpu/drm/amd/display/dc/dcn32/Makefile
index 8bb251307247..3bb17dd01e4c 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/Makefile
@@ -10,7 +10,7 @@
 #
 # Makefile for dcn32.
 
-DCN32 = dcn32_resource.o dcn32_hubbub.o dcn32_init.o dcn32_dccg.o \
+DCN32 = dcn32_hubbub.o dcn32_init.o dcn32_dccg.o \
 		dcn32_dccg.o dcn32_optc.o dcn32_mmhubbub.o dcn32_hubp.o dcn32_dpp.o \
 		dcn32_dio_stream_encoder.o dcn32_dio_link_encoder.o dcn32_hpo_dp_link_encoder.o \
 		dcn32_resource_helpers.o dcn32_mpc.o
diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource_helpers.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource_helpers.c
index bc5f0db23d0c..ef0a2b01734d 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource_helpers.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource_helpers.c
@@ -24,7 +24,7 @@
  */
 
 // header file of functions being implemented
-#include "dcn32_resource.h"
+#include "dcn32/dcn32_resource.h"
 #include "dcn20/dcn20_resource.h"
 #include "dml/dcn32/display_mode_vba_util_32.h"
 #include "dml/dcn32/dcn32_fpu.h"
diff --git a/drivers/gpu/drm/amd/display/dc/dcn321/Makefile b/drivers/gpu/drm/amd/display/dc/dcn321/Makefile
index 0a199c83bb5b..c195c47f58b4 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn321/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/dcn321/Makefile
@@ -10,7 +10,7 @@
 #
 # Makefile for dcn321.
 
-DCN321 = dcn321_resource.o dcn321_dio_link_encoder.o
+DCN321 = dcn321_dio_link_encoder.o
 
 AMD_DAL_DCN321 = $(addprefix $(AMDDALPATH)/dc/dcn321/,$(DCN321))
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn35/Makefile b/drivers/gpu/drm/amd/display/dc/dcn35/Makefile
index 20d0eef1a13b..719afb5a3b12 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn35/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/dcn35/Makefile
@@ -10,7 +10,7 @@
 #
 # Makefile for DCN35.
 
-DCN35 = dcn35_resource.o dcn35_init.o dcn35_dio_stream_encoder.o \
+DCN35 = dcn35_init.o dcn35_dio_stream_encoder.o \
 	dcn35_dio_link_encoder.o dcn35_dccg.o dcn35_optc.o \
 	dcn35_dsc.o dcn35_hubp.o dcn35_hubbub.o \
 	dcn35_mmhubbub.o dcn35_opp.o dcn35_dpp.o dcn35_pg_cntl.o dcn35_dwb.o
diff --git a/drivers/gpu/drm/amd/display/dc/dml/calcs/dcn_calcs.c b/drivers/gpu/drm/amd/display/dc/dml/calcs/dcn_calcs.c
index 50b0434354f8..0c4a8fe8e5ca 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/calcs/dcn_calcs.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/calcs/dcn_calcs.c
@@ -30,7 +30,7 @@
 #include "dcn_calc_auto.h"
 #include "dal_asic_id.h"
 #include "resource.h"
-#include "dcn10/dcn10_resource.h"
+#include "resource/dcn10/dcn10_resource.h"
 #include "dcn10/dcn10_hubbub.h"
 #include "dml/dml1_display_rq_dlg_calc.h"
 
diff --git a/drivers/gpu/drm/amd/display/dc/resource/Makefile b/drivers/gpu/drm/amd/display/dc/resource/Makefile
new file mode 100644
index 000000000000..0a75ed8962a5
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/dc/resource/Makefile
@@ -0,0 +1,199 @@
+
+# Copyright 2022 Advanced Micro Devices, Inc.
+#
+# Permission is hereby granted, free of charge, to any person obtaining a
+# copy of this software and associated documentation files (the "Software"),
+# to deal in the Software without restriction, including without limitation
+# the rights to use, copy, modify, merge, publish, distribute, sublicense,
+# and/or sell copies of the Software, and to permit persons to whom the
+# Software is furnished to do so, subject to the following conditions:
+#
+# The above copyright notice and this permission notice shall be included in
+# all copies or substantial portions of the Software.
+#
+# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+# THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
+# OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
+# ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+# OTHER DEALINGS IN THE SOFTWARE.
+#
+# Makefile for the 'resource' sub-component of DAL.
+#
+
+
+###############################################################################
+#  DCE
+###############################################################################
+
+RESOURCE_DCE100 = dce100_resource.o
+
+AMD_DAL_RESOURCE_DCE100 = $(addprefix $(AMDDALPATH)/dc/resource/dce100/,$(RESOURCE_DCE100))
+
+AMD_DISPLAY_FILES += $(AMD_DAL_RESOURCE_DCE100)
+
+###############################################################################
+
+RESOURCE_DCE110 = dce110_resource.o
+
+AMD_DAL_RESOURCE_DCE110 = $(addprefix $(AMDDALPATH)/dc/resource/dce110/,$(RESOURCE_DCE110))
+
+AMD_DISPLAY_FILES += $(AMD_DAL_RESOURCE_DCE110)
+
+###############################################################################
+
+RESOURCE_DCE112 = dce112_resource.o
+
+AMD_DAL_RESOURCE_DCE112 = $(addprefix $(AMDDALPATH)/dc/resource/dce112/,$(RESOURCE_DCE112))
+
+AMD_DISPLAY_FILES += $(AMD_DAL_RESOURCE_DCE112)
+
+###############################################################################
+
+RESOURCE_DCE120 = dce120_resource.o
+
+AMD_DAL_RESOURCE_DCE120 = $(addprefix $(AMDDALPATH)/dc/resource/dce120/,$(RESOURCE_DCE120))
+
+AMD_DISPLAY_FILES += $(AMD_DAL_RESOURCE_DCE120)
+
+###############################################################################
+
+RESOURCE_DCE80 = dce80_resource.o
+
+AMD_DAL_RESOURCE_DCE80 = $(addprefix $(AMDDALPATH)/dc/resource/dce80/,$(RESOURCE_DCE80))
+
+AMD_DISPLAY_FILES += $(AMD_DAL_RESOURCE_DCE80)
+
+ifdef CONFIG_DRM_AMD_DC_FP
+###############################################################################
+# DCN
+###############################################################################
+
+RESOURCE_DCN10 = dcn10_resource.o
+
+AMD_DAL_RESOURCE_DCN10 = $(addprefix $(AMDDALPATH)/dc/resource/dcn10/,$(RESOURCE_DCN10))
+
+AMD_DISPLAY_FILES += $(AMD_DAL_RESOURCE_DCN10)
+
+###############################################################################
+
+RESOURCE_DCN20 = dcn20_resource.o
+
+AMD_DAL_RESOURCE_DCN20 = $(addprefix $(AMDDALPATH)/dc/resource/dcn20/,$(RESOURCE_DCN20))
+
+AMD_DISPLAY_FILES += $(AMD_DAL_RESOURCE_DCN20)
+
+###############################################################################
+
+RESOURCE_DCN201 = dcn201_resource.o
+
+AMD_DAL_RESOURCE_DCN201 = $(addprefix $(AMDDALPATH)/dc/resource/dcn201/,$(RESOURCE_DCN201))
+
+AMD_DISPLAY_FILES += $(AMD_DAL_RESOURCE_DCN201)
+
+###############################################################################
+
+RESOURCE_DCN21 = dcn21_resource.o
+
+AMD_DAL_RESOURCE_DCN21 = $(addprefix $(AMDDALPATH)/dc/resource/dcn21/,$(RESOURCE_DCN21))
+
+AMD_DISPLAY_FILES += $(AMD_DAL_RESOURCE_DCN21)
+
+###############################################################################
+
+###############################################################################
+
+###############################################################################
+
+RESOURCE_DCN30 = dcn30_resource.o
+
+AMD_DAL_RESOURCE_DCN30 = $(addprefix $(AMDDALPATH)/dc/resource/dcn30/,$(RESOURCE_DCN30))
+
+AMD_DISPLAY_FILES += $(AMD_DAL_RESOURCE_DCN30)
+
+###############################################################################
+
+RESOURCE_DCN301 = dcn301_resource.o
+
+AMD_DAL_RESOURCE_DCN301 = $(addprefix $(AMDDALPATH)/dc/resource/dcn301/,$(RESOURCE_DCN301))
+
+AMD_DISPLAY_FILES += $(AMD_DAL_RESOURCE_DCN301)
+
+###############################################################################
+
+RESOURCE_DCN302 = dcn302_resource.o
+
+AMD_DAL_RESOURCE_DCN302 = $(addprefix $(AMDDALPATH)/dc/resource/dcn302/,$(RESOURCE_DCN302))
+
+AMD_DISPLAY_FILES += $(AMD_DAL_RESOURCE_DCN302)
+
+###############################################################################
+
+RESOURCE_DCN303 = dcn303_resource.o
+
+AMD_DAL_RESOURCE_DCN303 = $(addprefix $(AMDDALPATH)/dc/resource/dcn303/,$(RESOURCE_DCN303))
+
+AMD_DISPLAY_FILES += $(AMD_DAL_RESOURCE_DCN303)
+
+###############################################################################
+
+RESOURCE_DCN31 = dcn31_resource.o
+
+AMD_DAL_RESOURCE_DCN31 = $(addprefix $(AMDDALPATH)/dc/resource/dcn31/,$(RESOURCE_DCN31))
+
+AMD_DISPLAY_FILES += $(AMD_DAL_RESOURCE_DCN31)
+
+###############################################################################
+
+RESOURCE_DCN314 = dcn314_resource.o
+
+AMD_DAL_RESOURCE_DCN314 = $(addprefix $(AMDDALPATH)/dc/resource/dcn314/,$(RESOURCE_DCN314))
+
+AMD_DISPLAY_FILES += $(AMD_DAL_RESOURCE_DCN314)
+
+###############################################################################
+
+RESOURCE_DCN315 = dcn315_resource.o
+
+AMD_DAL_RESOURCE_DCN315 = $(addprefix $(AMDDALPATH)/dc/resource/dcn315/,$(RESOURCE_DCN315))
+
+AMD_DISPLAY_FILES += $(AMD_DAL_RESOURCE_DCN315)
+
+###############################################################################
+
+RESOURCE_DCN316 = dcn316_resource.o
+
+AMD_DAL_RESOURCE_DCN316 = $(addprefix $(AMDDALPATH)/dc/resource/dcn316/,$(RESOURCE_DCN316))
+
+AMD_DISPLAY_FILES += $(AMD_DAL_RESOURCE_DCN316)
+
+###############################################################################
+
+RESOURCE_DCN32 = dcn32_resource.o
+
+AMD_DAL_RESOURCE_DCN32 = $(addprefix $(AMDDALPATH)/dc/resource/dcn32/,$(RESOURCE_DCN32))
+
+AMD_DISPLAY_FILES += $(AMD_DAL_RESOURCE_DCN32)
+
+###############################################################################
+
+RESOURCE_DCN321 = dcn321_resource.o
+
+AMD_DAL_RESOURCE_DCN321 = $(addprefix $(AMDDALPATH)/dc/resource/dcn321/,$(RESOURCE_DCN321))
+
+AMD_DISPLAY_FILES += $(AMD_DAL_RESOURCE_DCN321)
+
+###############################################################################
+
+RESOURCE_DCN35 = dcn35_resource.o
+
+AMD_DAL_RESOURCE_DCN35 = $(addprefix $(AMDDALPATH)/dc/resource/dcn35/,$(RESOURCE_DCN35))
+
+AMD_DISPLAY_FILES += $(AMD_DAL_RESOURCE_DCN35)
+
+###############################################################################
+
+###############################################################################
+
+endif
diff --git a/drivers/gpu/drm/amd/display/dc/dce100/dce100_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dce100/dce100_resource.c
similarity index 100%
rename from drivers/gpu/drm/amd/display/dc/dce100/dce100_resource.c
rename to drivers/gpu/drm/amd/display/dc/resource/dce100/dce100_resource.c
diff --git a/drivers/gpu/drm/amd/display/dc/dce100/dce100_resource.h b/drivers/gpu/drm/amd/display/dc/resource/dce100/dce100_resource.h
similarity index 100%
rename from drivers/gpu/drm/amd/display/dc/dce100/dce100_resource.h
rename to drivers/gpu/drm/amd/display/dc/resource/dce100/dce100_resource.h
diff --git a/drivers/gpu/drm/amd/display/dc/dce110/dce110_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dce110/dce110_resource.c
similarity index 100%
rename from drivers/gpu/drm/amd/display/dc/dce110/dce110_resource.c
rename to drivers/gpu/drm/amd/display/dc/resource/dce110/dce110_resource.c
diff --git a/drivers/gpu/drm/amd/display/dc/dce110/dce110_resource.h b/drivers/gpu/drm/amd/display/dc/resource/dce110/dce110_resource.h
similarity index 100%
rename from drivers/gpu/drm/amd/display/dc/dce110/dce110_resource.h
rename to drivers/gpu/drm/amd/display/dc/resource/dce110/dce110_resource.h
diff --git a/drivers/gpu/drm/amd/display/dc/dce112/dce112_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dce112/dce112_resource.c
similarity index 100%
rename from drivers/gpu/drm/amd/display/dc/dce112/dce112_resource.c
rename to drivers/gpu/drm/amd/display/dc/resource/dce112/dce112_resource.c
diff --git a/drivers/gpu/drm/amd/display/dc/dce112/dce112_resource.h b/drivers/gpu/drm/amd/display/dc/resource/dce112/dce112_resource.h
similarity index 100%
rename from drivers/gpu/drm/amd/display/dc/dce112/dce112_resource.h
rename to drivers/gpu/drm/amd/display/dc/resource/dce112/dce112_resource.h
diff --git a/drivers/gpu/drm/amd/display/dc/dce120/dce120_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dce120/dce120_resource.c
similarity index 99%
rename from drivers/gpu/drm/amd/display/dc/dce120/dce120_resource.c
rename to drivers/gpu/drm/amd/display/dc/resource/dce120/dce120_resource.c
index 962de79be169..20662edd0ae4 100644
--- a/drivers/gpu/drm/amd/display/dc/dce120/dce120_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dce120/dce120_resource.c
@@ -36,7 +36,7 @@
 
 #include "dce110/dce110_resource.h"
 #include "virtual/virtual_stream_encoder.h"
-#include "dce120_timing_generator.h"
+#include "dce120/dce120_timing_generator.h"
 #include "irq/dce120/irq_service_dce120.h"
 #include "dce/dce_opp.h"
 #include "dce/dce_clock_source.h"
diff --git a/drivers/gpu/drm/amd/display/dc/dce120/dce120_resource.h b/drivers/gpu/drm/amd/display/dc/resource/dce120/dce120_resource.h
similarity index 100%
rename from drivers/gpu/drm/amd/display/dc/dce120/dce120_resource.h
rename to drivers/gpu/drm/amd/display/dc/resource/dce120/dce120_resource.h
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dce80/CMakeLists.txt b/drivers/gpu/drm/amd/display/dc/resource/dce80/CMakeLists.txt
new file mode 100644
index 000000000000..19dd73bc9ab0
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/dc/resource/dce80/CMakeLists.txt
@@ -0,0 +1,4 @@
+dal3_subdirectory_sources(
+  dce80_resource.c
+  dce80_resource.h
+  )
\ No newline at end of file
diff --git a/drivers/gpu/drm/amd/display/dc/dce80/dce80_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dce80/dce80_resource.c
similarity index 100%
rename from drivers/gpu/drm/amd/display/dc/dce80/dce80_resource.c
rename to drivers/gpu/drm/amd/display/dc/resource/dce80/dce80_resource.c
diff --git a/drivers/gpu/drm/amd/display/dc/dce80/dce80_resource.h b/drivers/gpu/drm/amd/display/dc/resource/dce80/dce80_resource.h
similarity index 100%
rename from drivers/gpu/drm/amd/display/dc/dce80/dce80_resource.h
rename to drivers/gpu/drm/amd/display/dc/resource/dce80/dce80_resource.h
diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn10/dcn10_resource.c
similarity index 99%
rename from drivers/gpu/drm/amd/display/dc/dcn10/dcn10_resource.c
rename to drivers/gpu/drm/amd/display/dc/resource/dcn10/dcn10_resource.c
index b94c5c97eee7..af1b31f4e69a 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn10/dcn10_resource.c
@@ -26,29 +26,32 @@
 #include "dm_services.h"
 #include "dc.h"
 
-#include "dcn10_init.h"
+#include "dcn10/dcn10_init.h"
 
 #include "resource.h"
 #include "include/irq_service_interface.h"
-#include "dcn10_resource.h"
-#include "dcn10_ipp.h"
-#include "dcn10_mpc.h"
+#include "dcn10/dcn10_resource.h"
+#include "dcn10/dcn10_ipp.h"
+#include "dcn10/dcn10_mpc.h"
+
+#include "dcn10/dcn10_dwb.h"
+
 #include "irq/dcn10/irq_service_dcn10.h"
-#include "dcn10_dpp.h"
-#include "dcn10_optc.h"
+#include "dcn10/dcn10_dpp.h"
+#include "dcn10/dcn10_optc.h"
 #include "dcn10/dcn10_hwseq.h"
 #include "dce110/dce110_hwseq.h"
-#include "dcn10_opp.h"
-#include "dcn10_link_encoder.h"
-#include "dcn10_stream_encoder.h"
+#include "dcn10/dcn10_opp.h"
+#include "dcn10/dcn10_link_encoder.h"
+#include "dcn10/dcn10_stream_encoder.h"
 #include "dce/dce_clock_source.h"
 #include "dce/dce_audio.h"
 #include "dce/dce_hwseq.h"
 #include "virtual/virtual_stream_encoder.h"
 #include "dce110/dce110_resource.h"
 #include "dce112/dce112_resource.h"
-#include "dcn10_hubp.h"
-#include "dcn10_hubbub.h"
+#include "dcn10/dcn10_hubp.h"
+#include "dcn10/dcn10_hubbub.h"
 #include "dce/dce_panel_cntl.h"
 
 #include "soc15_hw_ip.h"
diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_resource.h b/drivers/gpu/drm/amd/display/dc/resource/dcn10/dcn10_resource.h
similarity index 100%
rename from drivers/gpu/drm/amd/display/dc/dcn10/dcn10_resource.h
rename to drivers/gpu/drm/amd/display/dc/resource/dcn10/dcn10_resource.h
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn20/dcn20_resource.c
similarity index 99%
rename from drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
rename to drivers/gpu/drm/amd/display/dc/resource/dcn20/dcn20_resource.c
index 0a422fbb14bc..f04bb5b1471d 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn20/dcn20_resource.c
@@ -29,7 +29,7 @@
 #include "dm_services.h"
 #include "dc.h"
 
-#include "dcn20_init.h"
+#include "dcn20/dcn20_init.h"
 
 #include "resource.h"
 #include "include/irq_service_interface.h"
@@ -39,29 +39,29 @@
 
 #include "dcn10/dcn10_hubp.h"
 #include "dcn10/dcn10_ipp.h"
-#include "dcn20_hubbub.h"
-#include "dcn20_mpc.h"
-#include "dcn20_hubp.h"
+#include "dcn20/dcn20_hubbub.h"
+#include "dcn20/dcn20_mpc.h"
+#include "dcn20/dcn20_hubp.h"
 #include "irq/dcn20/irq_service_dcn20.h"
-#include "dcn20_dpp.h"
-#include "dcn20_optc.h"
+#include "dcn20/dcn20_dpp.h"
+#include "dcn20/dcn20_optc.h"
 #include "dcn20/dcn20_hwseq.h"
 #include "dce110/dce110_hwseq.h"
 #include "dcn10/dcn10_resource.h"
-#include "dcn20_opp.h"
+#include "dcn20/dcn20_opp.h"
 
-#include "dcn20_dsc.h"
+#include "dcn20/dcn20_dsc.h"
 
-#include "dcn20_link_encoder.h"
-#include "dcn20_stream_encoder.h"
+#include "dcn20/dcn20_link_encoder.h"
+#include "dcn20/dcn20_stream_encoder.h"
 #include "dce/dce_clock_source.h"
 #include "dce/dce_audio.h"
 #include "dce/dce_hwseq.h"
 #include "virtual/virtual_stream_encoder.h"
 #include "dce110/dce110_resource.h"
 #include "dml/display_mode_vba.h"
-#include "dcn20_dccg.h"
-#include "dcn20_vmid.h"
+#include "dcn20/dcn20_dccg.h"
+#include "dcn20/dcn20_vmid.h"
 #include "dce/dce_panel_cntl.h"
 
 #include "navi10_ip_offset.h"
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.h b/drivers/gpu/drm/amd/display/dc/resource/dcn20/dcn20_resource.h
similarity index 100%
rename from drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.h
rename to drivers/gpu/drm/amd/display/dc/resource/dcn20/dcn20_resource.h
diff --git a/drivers/gpu/drm/amd/display/dc/dcn201/dcn201_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn201/dcn201_resource.c
similarity index 99%
rename from drivers/gpu/drm/amd/display/dc/dcn201/dcn201_resource.c
rename to drivers/gpu/drm/amd/display/dc/resource/dcn201/dcn201_resource.c
index bca22d867696..914b234d7f6b 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn201/dcn201_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn201/dcn201_resource.c
@@ -26,7 +26,7 @@
 #include "dm_services.h"
 #include "dc.h"
 
-#include "dcn201_init.h"
+#include "dcn201/dcn201_init.h"
 #include "dml/dcn20/dcn20_fpu.h"
 #include "resource.h"
 #include "include/irq_service_interface.h"
@@ -36,16 +36,16 @@
 
 #include "dcn10/dcn10_hubp.h"
 #include "dcn10/dcn10_ipp.h"
-#include "dcn201_mpc.h"
-#include "dcn201_hubp.h"
+#include "dcn201/dcn201_mpc.h"
+#include "dcn201/dcn201_hubp.h"
 #include "irq/dcn201/irq_service_dcn201.h"
 #include "dcn201/dcn201_dpp.h"
 #include "dcn201/dcn201_hubbub.h"
-#include "dcn201_dccg.h"
-#include "dcn201_optc.h"
+#include "dcn201/dcn201_dccg.h"
+#include "dcn201/dcn201_optc.h"
 #include "dcn201/dcn201_hwseq.h"
 #include "dce110/dce110_hwseq.h"
-#include "dcn201_opp.h"
+#include "dcn201/dcn201_opp.h"
 #include "dcn201/dcn201_link_encoder.h"
 #include "dcn20/dcn20_stream_encoder.h"
 #include "dce/dce_clock_source.h"
@@ -55,7 +55,7 @@
 #include "dce110/dce110_resource.h"
 #include "dce/dce_aux.h"
 #include "dce/dce_i2c.h"
-#include "dcn201_hubbub.h"
+#include "dcn201/dcn201_hubbub.h"
 #include "dcn10/dcn10_resource.h"
 
 #include "cyan_skillfish_ip_offset.h"
diff --git a/drivers/gpu/drm/amd/display/dc/dcn201/dcn201_resource.h b/drivers/gpu/drm/amd/display/dc/resource/dcn201/dcn201_resource.h
similarity index 100%
rename from drivers/gpu/drm/amd/display/dc/dcn201/dcn201_resource.h
rename to drivers/gpu/drm/amd/display/dc/resource/dcn201/dcn201_resource.h
diff --git a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn21/dcn21_resource.c
similarity index 99%
rename from drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
rename to drivers/gpu/drm/amd/display/dc/resource/dcn21/dcn21_resource.c
index 42277b280586..c07da45e1e2c 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn21/dcn21_resource.c
@@ -29,7 +29,7 @@
 #include "dm_services.h"
 #include "dc.h"
 
-#include "dcn21_init.h"
+#include "dcn21/dcn21_init.h"
 
 #include "resource.h"
 #include "include/irq_service_interface.h"
@@ -44,7 +44,7 @@
 #include "dcn20/dcn20_hubbub.h"
 #include "dcn20/dcn20_mpc.h"
 #include "dcn20/dcn20_hubp.h"
-#include "dcn21_hubp.h"
+#include "dcn21/dcn21_hubp.h"
 #include "irq/dcn21/irq_service_dcn21.h"
 #include "dcn20/dcn20_dpp.h"
 #include "dcn20/dcn20_optc.h"
@@ -61,7 +61,7 @@
 #include "dml/display_mode_vba.h"
 #include "dcn20/dcn20_dccg.h"
 #include "dcn21/dcn21_dccg.h"
-#include "dcn21_hubbub.h"
+#include "dcn21/dcn21_hubbub.h"
 #include "dcn10/dcn10_resource.h"
 #include "dce/dce_panel_cntl.h"
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.h b/drivers/gpu/drm/amd/display/dc/resource/dcn21/dcn21_resource.h
similarity index 100%
rename from drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.h
rename to drivers/gpu/drm/amd/display/dc/resource/dcn21/dcn21_resource.h
diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn30/dcn30_resource.c
similarity index 99%
rename from drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
rename to drivers/gpu/drm/amd/display/dc/resource/dcn30/dcn30_resource.c
index 7b259cb5f418..2b6dcb489b90 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn30/dcn30_resource.c
@@ -27,7 +27,7 @@
 #include "dm_services.h"
 #include "dc.h"
 
-#include "dcn30_init.h"
+#include "dcn30/dcn30_init.h"
 
 #include "resource.h"
 #include "include/irq_service_interface.h"
diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.h b/drivers/gpu/drm/amd/display/dc/resource/dcn30/dcn30_resource.h
similarity index 100%
rename from drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.h
rename to drivers/gpu/drm/amd/display/dc/resource/dcn30/dcn30_resource.h
diff --git a/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn301/dcn301_resource.c
similarity index 99%
rename from drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c
rename to drivers/gpu/drm/amd/display/dc/resource/dcn301/dcn301_resource.c
index f3b75f283aa2..511ff6b5b985 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn301/dcn301_resource.c
@@ -27,7 +27,7 @@
 #include "dm_services.h"
 #include "dc.h"
 
-#include "dcn301_init.h"
+#include "dcn301/dcn301_init.h"
 
 #include "resource.h"
 #include "include/irq_service_interface.h"
@@ -61,7 +61,7 @@
 #include "dcn10/dcn10_resource.h"
 #include "dcn30/dcn30_dio_stream_encoder.h"
 #include "dcn301/dcn301_dio_link_encoder.h"
-#include "dcn301_panel_cntl.h"
+#include "dcn301/dcn301_panel_cntl.h"
 
 #include "vangogh_ip_offset.h"
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.h b/drivers/gpu/drm/amd/display/dc/resource/dcn301/dcn301_resource.h
similarity index 100%
rename from drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.h
rename to drivers/gpu/drm/amd/display/dc/resource/dcn301/dcn301_resource.h
diff --git a/drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn302/dcn302_resource.c
similarity index 99%
rename from drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c
rename to drivers/gpu/drm/amd/display/dc/resource/dcn302/dcn302_resource.c
index 63ac984a04f7..5791b5cc2875 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn302/dcn302_resource.c
@@ -23,9 +23,9 @@
  *
  */
 
-#include "dcn302_init.h"
+#include "dcn302/dcn302_init.h"
 #include "dcn302_resource.h"
-#include "dcn302_dccg.h"
+#include "dcn302/dcn302_dccg.h"
 #include "irq/dcn302/irq_service_dcn302.h"
 
 #include "dcn30/dcn30_dio_link_encoder.h"
diff --git a/drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.h b/drivers/gpu/drm/amd/display/dc/resource/dcn302/dcn302_resource.h
similarity index 100%
rename from drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.h
rename to drivers/gpu/drm/amd/display/dc/resource/dcn302/dcn302_resource.h
diff --git a/drivers/gpu/drm/amd/display/dc/dcn303/dcn303_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn303/dcn303_resource.c
similarity index 99%
rename from drivers/gpu/drm/amd/display/dc/dcn303/dcn303_resource.c
rename to drivers/gpu/drm/amd/display/dc/resource/dcn303/dcn303_resource.c
index 49cb7fde416a..25cd6236b054 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn303/dcn303_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn303/dcn303_resource.c
@@ -23,9 +23,9 @@
  * Authors: AMD
  */
 
-#include "dcn303_init.h"
+#include "dcn303/dcn303_init.h"
 #include "dcn303_resource.h"
-#include "dcn303_dccg.h"
+#include "dcn303/dcn303_dccg.h"
 #include "irq/dcn303/irq_service_dcn303.h"
 
 #include "dcn30/dcn30_dio_link_encoder.h"
diff --git a/drivers/gpu/drm/amd/display/dc/dcn303/dcn303_resource.h b/drivers/gpu/drm/amd/display/dc/resource/dcn303/dcn303_resource.h
similarity index 100%
rename from drivers/gpu/drm/amd/display/dc/dcn303/dcn303_resource.h
rename to drivers/gpu/drm/amd/display/dc/resource/dcn303/dcn303_resource.h
diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn31/dcn31_resource.c
similarity index 99%
rename from drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
rename to drivers/gpu/drm/amd/display/dc/resource/dcn31/dcn31_resource.c
index 79416cfb22f0..31035fc3d868 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn31/dcn31_resource.c
@@ -70,7 +70,7 @@
 #include "dml/dcn31/dcn31_fpu.h"
 #include "dcn31/dcn31_dccg.h"
 #include "dcn10/dcn10_resource.h"
-#include "dcn31_panel_cntl.h"
+#include "dcn31/dcn31_panel_cntl.h"
 
 #include "dcn30/dcn30_dwb.h"
 #include "dcn30/dcn30_mmhubbub.h"
diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.h b/drivers/gpu/drm/amd/display/dc/resource/dcn31/dcn31_resource.h
similarity index 100%
rename from drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.h
rename to drivers/gpu/drm/amd/display/dc/resource/dcn31/dcn31_resource.h
diff --git a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn314/dcn314_resource.c
similarity index 100%
rename from drivers/gpu/drm/amd/display/dc/dcn314/dcn314_resource.c
rename to drivers/gpu/drm/amd/display/dc/resource/dcn314/dcn314_resource.c
diff --git a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_resource.h b/drivers/gpu/drm/amd/display/dc/resource/dcn314/dcn314_resource.h
similarity index 100%
rename from drivers/gpu/drm/amd/display/dc/dcn314/dcn314_resource.h
rename to drivers/gpu/drm/amd/display/dc/resource/dcn314/dcn314_resource.h
diff --git a/drivers/gpu/drm/amd/display/dc/dcn315/dcn315_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn315/dcn315_resource.c
similarity index 100%
rename from drivers/gpu/drm/amd/display/dc/dcn315/dcn315_resource.c
rename to drivers/gpu/drm/amd/display/dc/resource/dcn315/dcn315_resource.c
diff --git a/drivers/gpu/drm/amd/display/dc/dcn315/dcn315_resource.h b/drivers/gpu/drm/amd/display/dc/resource/dcn315/dcn315_resource.h
similarity index 100%
rename from drivers/gpu/drm/amd/display/dc/dcn315/dcn315_resource.h
rename to drivers/gpu/drm/amd/display/dc/resource/dcn315/dcn315_resource.h
diff --git a/drivers/gpu/drm/amd/display/dc/dcn316/dcn316_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn316/dcn316_resource.c
similarity index 100%
rename from drivers/gpu/drm/amd/display/dc/dcn316/dcn316_resource.c
rename to drivers/gpu/drm/amd/display/dc/resource/dcn316/dcn316_resource.c
diff --git a/drivers/gpu/drm/amd/display/dc/dcn316/dcn316_resource.h b/drivers/gpu/drm/amd/display/dc/resource/dcn316/dcn316_resource.h
similarity index 100%
rename from drivers/gpu/drm/amd/display/dc/dcn316/dcn316_resource.h
rename to drivers/gpu/drm/amd/display/dc/resource/dcn316/dcn316_resource.h
diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
similarity index 99%
rename from drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
rename to drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
index 89b072447dba..36e4c7bef403 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
@@ -27,7 +27,7 @@
 #include "dm_services.h"
 #include "dc.h"
 
-#include "dcn32_init.h"
+#include "dcn32/dcn32_init.h"
 
 #include "resource.h"
 #include "include/irq_service_interface.h"
@@ -41,7 +41,7 @@
 #include "dcn31/dcn31_hubbub.h"
 #include "dcn32/dcn32_hubbub.h"
 #include "dcn32/dcn32_mpc.h"
-#include "dcn32_hubp.h"
+#include "dcn32/dcn32_hubp.h"
 #include "irq/dcn32/irq_service_dcn32.h"
 #include "dcn32/dcn32_dpp.h"
 #include "dcn32/dcn32_optc.h"
diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.h b/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.h
similarity index 100%
rename from drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.h
rename to drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.h
diff --git a/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn321/dcn321_resource.c
similarity index 99%
rename from drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c
rename to drivers/gpu/drm/amd/display/dc/resource/dcn321/dcn321_resource.c
index f7de3eca1225..bedb70b98162 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn321/dcn321_resource.c
@@ -63,7 +63,7 @@
 #include "dcn31/dcn31_apg.h"
 #include "dcn31/dcn31_dio_link_encoder.h"
 #include "dcn32/dcn32_dio_link_encoder.h"
-#include "dcn321_dio_link_encoder.h"
+#include "dcn321/dcn321_dio_link_encoder.h"
 #include "dce/dce_clock_source.h"
 #include "dce/dce_audio.h"
 #include "dce/dce_hwseq.h"
diff --git a/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.h b/drivers/gpu/drm/amd/display/dc/resource/dcn321/dcn321_resource.h
similarity index 100%
rename from drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.h
rename to drivers/gpu/drm/amd/display/dc/resource/dcn321/dcn321_resource.h
diff --git a/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c
similarity index 99%
rename from drivers/gpu/drm/amd/display/dc/dcn35/dcn35_resource.c
rename to drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c
index 7a3faf2b1f06..a4027bf053c5 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c
@@ -78,7 +78,7 @@
 #include "dcn10/dcn10_resource.h"
 #include "dcn31/dcn31_panel_cntl.h"
 #include "dcn35/dcn35_hwseq.h"
-#include "dcn35_dio_link_encoder.h"
+#include "dcn35/dcn35_dio_link_encoder.h"
 #include "dml/dcn31/dcn31_fpu.h" /*todo*/
 #include "dml/dcn35/dcn35_fpu.h"
 #include "dcn35/dcn35_dwb.h"
diff --git a/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_resource.h b/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.h
similarity index 100%
rename from drivers/gpu/drm/amd/display/dc/dcn35/dcn35_resource.h
rename to drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.h
-- 
2.42.0

