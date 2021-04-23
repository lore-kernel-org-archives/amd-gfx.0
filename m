Return-Path: <SRS0=d4Si=JU=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40230C433B4
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Apr 2021 02:39:37 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C541661425
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Apr 2021 02:39:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C541661425
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 375D16E05C;
	Fri, 23 Apr 2021 02:39:36 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2079.outbound.protection.outlook.com [40.107.236.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 90E956E05C
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 Apr 2021 02:39:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LCMxvEGc++Hv+j3qu8aJbiwHcjhnxXx2OMfgqf/Hf1ItoRjOU4ldYhAwDQeQLAJZu5b3r6zSRS6FgfOHSGtAZdGZ5FOOWzR8bQdXnSO8HTryseVS+swY6PHQLDbHyW84xhom5B6fPhR+X3z9LUOTOl3KDrd1G4S+7J0domXIgoQbwQzEya1OCUsZhpNRNFDVpkA2efLr3YO/5J47/bGfamEk2KeRUt2a569Q4zTLBNDzWJr/Xzuyr88qfBLT/D7k1e+eIXhabRTn9d3BYXtDz5MtL9avnFmS32QcWhqt4NoHK91aZjPFbH1Zef0O3Md2OGN0WFDEmjWj4EtVQ37Jaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=23O9ZJGKD82RSpa5KA24AHrRfUW1/hVaKJJL6ihCneY=;
 b=Cquiui1L0xkcSNuCkRUszeuiL7DgBro9Ldk/zhn/lJRycRsB1ePgm7j0NASlBWcUD9489GAb+/AZcW5pgDGq+Pw5tJr8B2yj7JdmMaiwU6IOxZb9udLPBM5HbqEoeyGSWajzmpkUlUzdCt2SMKxk5+axcRSEEZRpQsOd+1bzlMEUHr4j6rbIRJP5g8+8h2toPgaugQRXC0ArxINTznuVlXb8r140kDVu/pEKTVm3Qx1P96YfpivE8fmqyUiHcnk/vTibdhXpvlHeGv1K82Nx95cW+HXPdtgBrVx7SgQ3VC59BksOw8mgp/LYNYpz2GDZdpZeZXDyu8I+GNlsQjo/BQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=23O9ZJGKD82RSpa5KA24AHrRfUW1/hVaKJJL6ihCneY=;
 b=hPn98cLcyW9ZD6JqWtaLF1/IY0xf/MYzhW0bmWcOP0+ARaK9ZvOibr84RnMMstcvi9ky1PA+vuQzAlI7fnRolzpnyQzixgppgk3fqeO7/UcAwZxmH87HUp8Flx2DHw/A9BeepN2dhmbZiKl6obcA5EJlRay50oop4YXy1Z0iUOA=
Received: from CO2PR04CA0151.namprd04.prod.outlook.com (2603:10b6:104::29) by
 MN2PR12MB2943.namprd12.prod.outlook.com (2603:10b6:208:ad::33) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4042.16; Fri, 23 Apr 2021 02:39:33 +0000
Received: from CO1NAM11FT015.eop-nam11.prod.protection.outlook.com
 (2603:10b6:104:0:cafe::a6) by CO2PR04CA0151.outlook.office365.com
 (2603:10b6:104::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.21 via Frontend
 Transport; Fri, 23 Apr 2021 02:39:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT015.mail.protection.outlook.com (10.13.175.130) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4065.21 via Frontend Transport; Fri, 23 Apr 2021 02:39:32 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Thu, 22 Apr
 2021 21:39:31 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Thu, 22 Apr
 2021 21:39:31 -0500
Received: from wayne-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2242.4
 via Frontend Transport; Thu, 22 Apr 2021 21:39:28 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 00/16] DC Patches April 23, 2021
Date: Fri, 23 Apr 2021 10:36:58 +0800
Message-ID: <20210423023714.22044-1-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f8b8a7ee-9d75-4eb0-cd1f-08d9060106c4
X-MS-TrafficTypeDiagnostic: MN2PR12MB2943:
X-Microsoft-Antispam-PRVS: <MN2PR12MB29433E8B16D6A2A2E704D697FC459@MN2PR12MB2943.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pKiCR+aKXGAEwq/xPMECzd+doUvj7Wob18M9SIn5RQRv3bnM8z8aBIS1wprpU2/54s8A0GsNp2aMe0CfgsfX3u4dBVbJpm7DaGW5Bf5aGUwZDyFULJH3QqhwdTm7aIDZ6FD0qeDeFQHMegiXvgCOqTS9Janjq1+prbAKG5Afq8EBf68wiZKt38jrif8e3BhKwW+X7QkYVoAimlXjqjwj7NWzDhOrY1yASREnes7/w0fJMnwXNbD1f/UyRwVwlpJF9wO0JkWdYxiTNL6zAat3j3jtSy638oNG+OdwUvD8OxYF5qzL01FdFrqiy3dUwDpMccaUKgMNS8A+hbY0hsBwmeIDX5xdS7dGYU2aMWPvq/Wn01stbwVBOYscBijuKoc311M3Zl8Xmg89iuMxOrGCwthqZaq7LlXX4aeXRiHFkmPsivxNWe7p7cI0xgxhzihL3U+1Vm2xiJTyqAGNV4yg+d1ikDwntU7XS7ZtrkCL6ErLkztMahGzEu3tQpBnasoUQv4ihXma5VfJQi+0ve/yeVUuXUDjnyJ7BEGW4MgUBZnmQt35n3ObJyPa5apTitW38l0gc4FqtJAMIytGauG/xd6a1zwnG8BIG51HeNc8la4KKR4kM85/5buDpBVHniM3M0zJA0Wf7yI3dLn0Ak2nyb5lO9D8gN6mfiOGVrfYGe+KfnDOI1vX0AVaSEyUuw6H
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(39860400002)(136003)(376002)(346002)(396003)(36840700001)(46966006)(86362001)(8676002)(2906002)(82310400003)(6916009)(356005)(36756003)(316002)(6666004)(426003)(36860700001)(70206006)(2616005)(478600001)(81166007)(1076003)(4326008)(82740400003)(186003)(7696005)(70586007)(83380400001)(336012)(8936002)(5660300002)(47076005)(54906003)(26005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2021 02:39:32.6311 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f8b8a7ee-9d75-4eb0-cd1f-08d9060106c4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT015.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB2943
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
Cc: Eryk.Brol@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com, Anson.Jacob@amd.com,
 Aurabindo.Pillai@amd.com, Wayne Lin <Wayne.Lin@amd.com>,
 Bhawanpreet.Lakha@amd.com, bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This DC patchset brings along following fixes:

* [FW Promotion] Release 0.0.63
* fix HDCP reset sequence on reinitialize
* Fix BSOD with NULL check
* Added multi instance support for ABM
* Revert wait vblank on update dpp clock
* skip program clock when allow seamless boot
* Add new DP_SEC registers for programming SDP Line number
* Add SE_DCN3_REG_LIST for control SDP num
* Add new case to get spread spectrum info
* fix wrong statement in mst hpd debugfs
* Clear MASTER_UPDATE_LOCK_DB_EN when disable doublebuffer lock
* Expose internal display flag via debugfs
* take max dsc stream bandwidth overhead into account
* ddc resource data need to be initialized
* avoid to authentication when DEVICE_COUNT=0

 .../amd/display/amdgpu_dm/amdgpu_dm_debugfs.c |  22 +++-
 .../drm/amd/display/dc/bios/bios_parser2.c    |   2 +
 .../amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c |  10 +-
 drivers/gpu/drm/amd/display/dc/core/dc.c      |  15 +--
 drivers/gpu/drm/amd/display/dc/core/dc_link.c |  22 +++-
 drivers/gpu/drm/amd/display/dc/dc.h           |   3 +-
 drivers/gpu/drm/amd/display/dc/dc_dsc.h       |   5 +-
 drivers/gpu/drm/amd/display/dc/dce/dmub_abm.c |  30 +++++
 .../drm/amd/display/dc/dcn20/dcn20_resource.c |   2 +-
 .../drm/amd/display/dc/dcn21/dcn21_hwseq.c    |   2 +-
 .../dc/dcn30/dcn30_dio_stream_encoder.h       |   4 +
 .../gpu/drm/amd/display/dc/dcn30/dcn30_optc.c |   2 +-
 .../drm/amd/display/dc/dcn30/dcn30_resource.c |   2 +-
 drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c   | 113 ++++++++++++++----
 drivers/gpu/drm/amd/display/dc/dsc/rc_calc.c  |  43 -------
 drivers/gpu/drm/amd/display/dc/dsc/rc_calc.h  |   2 -
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   |  88 ++++++++++++--
 .../gpu/drm/amd/display/modules/hdcp/hdcp.c   |   1 -
 .../display/modules/hdcp/hdcp1_execution.c    |   5 +
 .../display/modules/hdcp/hdcp2_execution.c    |   5 +
 20 files changed, 260 insertions(+), 118 deletions(-)

-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
