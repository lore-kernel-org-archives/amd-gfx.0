Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BCC7C433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Feb 2022 16:59:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 865DA10EE6B;
	Fri, 18 Feb 2022 16:59:14 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2050.outbound.protection.outlook.com [40.107.243.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C85C710EE4D
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Feb 2022 16:59:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c1P+Qw1+jwf+pFUwPK8NiPr3WtPJU0p/Hys1uiKH2Cb6KaGMleD8V9ujaCF94edoW/dV9K0GIfqtEBnK1P0/sNNlDuPCfBcDPSs2ov3wHijJPiD6n0Rq6LMxTnipfTVhDJYemjMtebucYWNpf37g2agMIECsywkvJbmNiQaqRY4skhiW4q1m9mMh0oyZPxk1KNr9rKGKB3mUg1VA6hRVklrcfq/iM0JGBdi9ED91DFg+5f/q1cmVXSwNev4bWDO9ldqmwTl2g/eZq3a5z29XJBGH7huvsCk++mA+B6jMRdRtEQZqVpTHVG7sYuNKcvxsNT3UG+XqNrKctxl1yh8J4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DSi49gaesEHi8GquQOhQ7eyALdu7lIEL0RkyiJJQ76Y=;
 b=HW3JY9TUFn0AJ/s1cuA6PHD5VIdTbXPjEUMqe0QwWQd1XbgW99Rvaidnuub4J8u0YcNkmb9NilqF2R9sqmwEdnEWj5C/66PZ2S1g+961ot78CuNbvSmz6b3Uf7vFbILXMr/52L5Gs+Tyzu/52MCmypJwOlr3rd0PZxFTPC8CBUvLPs04c+7H7U7JueIvWXO7wro2TR4nUkvx5NvKijNMQRZ6DLEPDA6Df29V8gjXoZj2FbMKKWp60e/WANo2yZZNc0hBzieIDdam0yp/dXQtM5UnHdZjzMY54cyCD9ni2aZ6obloG04hbMX3RQZZKyS7yZG2McsivlLa4yuOK5ctXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DSi49gaesEHi8GquQOhQ7eyALdu7lIEL0RkyiJJQ76Y=;
 b=pvPhUykzGSKl2I0f5TwGjkaD64nFNa3oZCsKbGaTySfRYoNZMtURAIwXAP0DSld/85L+Hov1NJYNZf7vvCu2WeKaVVqHooieD4O991rBuonizIo4gAtQ8lNgvwIIovPxov+jSjJfx9TfF6FICVpx7rsLbAhK6amONyW2pwUNduI=
Received: from MW4PR04CA0331.namprd04.prod.outlook.com (2603:10b6:303:8a::6)
 by BN6PR1201MB0161.namprd12.prod.outlook.com (2603:10b6:405:55::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.15; Fri, 18 Feb
 2022 16:59:10 +0000
Received: from CO1NAM11FT019.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8a:cafe::6) by MW4PR04CA0331.outlook.office365.com
 (2603:10b6:303:8a::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.15 via Frontend
 Transport; Fri, 18 Feb 2022 16:59:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT019.mail.protection.outlook.com (10.13.175.57) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4995.15 via Frontend Transport; Fri, 18 Feb 2022 16:59:09 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Fri, 18 Feb
 2022 10:59:08 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 00/13] Update DCN 3.1 support for 3.1.5
Date: Fri, 18 Feb 2022 11:58:43 -0500
Message-ID: <20220218165854.1417733-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 89bf3970-3e18-46bb-42ed-08d9f2fffb64
X-MS-TrafficTypeDiagnostic: BN6PR1201MB0161:EE_
X-Microsoft-Antispam-PRVS: <BN6PR1201MB0161D8D9F78B36B72DE634ABF7379@BN6PR1201MB0161.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: X/BuwuN1e14ClC8jePkVuMxSKcNBi0J4ZYCT1Ph4m+Ep3b6M2/Lmj2Kg8TPgdG+PBon9qxrGSViYPFPTvnQ3J0Orr+YPyQLmsbM8qFdj0Mxn+m9vScYRct/0bsAMqlwRGYyQvXXJp3rGU3sxE86KRRKx3wW6KTJwkf1jk+GoggWrVg+1hRJNmyM9urpqEegRnIINE9k+3HWIHNCUbtQ56Gopz/586aK/94/QJQCMMCTZpqSNXD1jPzdfU6rMNdFdwegFKrIaENWhfvbHUCGiM5l5Yx1gysbtjt9uoET0ewpHlzy91KK4YzLehuZE53+SDMEEeoTcIqHQx7+Uji37dEeoLPOP5asD/U+fl0QCamEejF8cXVKraf2LZDI2bBJWRcl53IFgRUH4nk1JdlFZQqiGzxSTj7T0qwNaDue228j0sGQfPCsmVr6abfgaSJYfuleb1t/H0zOO4LF4lVDJ6R+HDclWfV6F+34XooTL6P1+VOAaljeBzRzgaHODCy+pD9QYlC3zei8+lEMUzRzl5rLbRxngsAeFxP85Vwr2sD97CdzD0B1ge9mkKIfDCYkdka6xY3Us2MZmYkuy4gKYdj8rmg6zNniFDXcDzv0mMXg4ztxstF/dzDmr9XWUDSskpRJeceBRCld1sdlQy4CGFsy+mzQHJrLjySikPK9EPqtN3Bce5i0jDuL5Gfl2h5TGJLw3+1lLbgt88TWwABGaIQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(2906002)(26005)(316002)(356005)(6916009)(81166007)(15650500001)(86362001)(4326008)(8676002)(82310400004)(70206006)(70586007)(336012)(36756003)(1076003)(5660300002)(8936002)(426003)(47076005)(6666004)(2616005)(83380400001)(186003)(16526019)(7696005)(40460700003)(36860700001)(508600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2022 16:59:09.5995 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 89bf3970-3e18-46bb-42ed-08d9f2fffb64
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT019.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB0161
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Update DCN 3.1 for 3.1.5.  This is a minor update
to DCN 3.1 display support in amdgpu.

The first two patches are register headers so I did not
send them out due to size.

Qingqing Zhuo (11):
  drm/amd/include: add DCN 3.1.5 registers
  drm/amd/display: Add DCN315 family information
  drm/amd/display: Add DCN315 CLK_MGR
  drm/amd/display: Add DCN315 GPIO
  drm/amd/display: Add DCN315 IRQ
  drm/amd/display: Add DCN315 DMUB
  drm/amd/display: Add DCN315 Resource
  drm/amd/display: Add DCN315 Command Table Helper
  drm/amd/display: Add DCN315 blocks to Makefile
  drm/amd/display: Add DCN315 CORE
  drm/amd/display: Add DCN315 DM Support

Yifan Zhang (2):
  drm/amdgpu: add mp 13.0.5 header files
  drm/amdgpu: add dm ip block for dcn 3.1.5

 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c |      1 +
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |     14 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_hdcp.c    |      1 +
 drivers/gpu/drm/amd/display/dc/Makefile       |      1 +
 .../display/dc/bios/command_table_helper2.c   |      1 +
 .../gpu/drm/amd/display/dc/clk_mgr/Makefile   |      9 +
 .../gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c  |     23 +-
 .../dc/clk_mgr/dcn315/dcn315_clk_mgr.c        |    607 +
 .../dc/clk_mgr/dcn315/dcn315_clk_mgr.h        |     49 +
 .../display/dc/clk_mgr/dcn315/dcn315_smu.c    |    329 +
 .../display/dc/clk_mgr/dcn315/dcn315_smu.h    |    126 +
 drivers/gpu/drm/amd/display/dc/core/dc_link.c |     13 +-
 .../gpu/drm/amd/display/dc/core/dc_resource.c |      8 +
 .../gpu/drm/amd/display/dc/dcn315/Makefile    |     56 +
 .../amd/display/dc/dcn315/dcn315_resource.c   |   2302 +
 .../amd/display/dc/dcn315/dcn315_resource.h   |     42 +
 drivers/gpu/drm/amd/display/dc/gpio/Makefile  |      8 +
 .../dc/gpio/dcn315/hw_factory_dcn315.c        |    260 +
 .../dc/gpio/dcn315/hw_factory_dcn315.h        |     31 +
 .../dc/gpio/dcn315/hw_translate_dcn315.c      |    374 +
 .../dc/gpio/dcn315/hw_translate_dcn315.h      |     33 +
 .../gpu/drm/amd/display/dc/gpio/hw_factory.c  |      4 +
 .../drm/amd/display/dc/gpio/hw_translate.c    |      4 +
 drivers/gpu/drm/amd/display/dc/irq/Makefile   |      8 +
 .../dc/irq/dcn315/irq_service_dcn315.c        |    438 +
 .../dc/irq/dcn315/irq_service_dcn315.h        |     34 +
 drivers/gpu/drm/amd/display/dmub/dmub_srv.h   |      1 +
 drivers/gpu/drm/amd/display/dmub/src/Makefile |      4 +-
 .../drm/amd/display/dmub/src/dmub_dcn315.c    |     62 +
 .../drm/amd/display/dmub/src/dmub_dcn315.h    |     68 +
 .../gpu/drm/amd/display/dmub/src/dmub_srv.c   |      9 +-
 .../gpu/drm/amd/display/include/dal_asic_id.h |      6 +
 .../gpu/drm/amd/display/include/dal_types.h   |      1 +
 .../include/asic_reg/dcn/dcn_3_1_5_offset.h   |  15191 +++
 .../include/asic_reg/dcn/dcn_3_1_5_sh_mask.h  |  62061 +++++++++
 .../include/asic_reg/dpcs/dpcs_4_2_2_offset.h |  11957 ++
 .../asic_reg/dpcs/dpcs_4_2_2_sh_mask.h        | 103633 +++++++++++++++
 .../include/asic_reg/mp/mp_13_0_5_offset.h    |    455 +
 .../include/asic_reg/mp/mp_13_0_5_sh_mask.h   |    672 +
 39 files changed, 198885 insertions(+), 11 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn315/dcn315_clk_mgr.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn315/dcn315_clk_mgr.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn315/dcn315_smu.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn315/dcn315_smu.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/dcn315/Makefile
 create mode 100644 drivers/gpu/drm/amd/display/dc/dcn315/dcn315_resource.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dcn315/dcn315_resource.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/gpio/dcn315/hw_factory_dcn315.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/gpio/dcn315/hw_factory_dcn315.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/gpio/dcn315/hw_translate_dcn315.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/gpio/dcn315/hw_translate_dcn315.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/irq/dcn315/irq_service_dcn315.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/irq/dcn315/irq_service_dcn315.h
 create mode 100644 drivers/gpu/drm/amd/display/dmub/src/dmub_dcn315.c
 create mode 100644 drivers/gpu/drm/amd/display/dmub/src/dmub_dcn315.h
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_1_5_offset.h
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_1_5_sh_mask.h
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/dpcs/dpcs_4_2_2_offset.h
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/dpcs/dpcs_4_2_2_sh_mask.h
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/mp/mp_13_0_5_offset.h
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/mp/mp_13_0_5_sh_mask.h

-- 
2.35.1

