Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EB8AC433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Mar 2022 21:48:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1455F10E146;
	Fri, 18 Mar 2022 21:48:21 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2060.outbound.protection.outlook.com [40.107.237.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 22D4010E146
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Mar 2022 21:48:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n6Rd3zG4ingkPbxwEsW4CaBrZ5EbZrP9v+/j2S+r8rtkoA4AF5MVkH1jAzRekSZ6/Paffdr2GNfCeeDumLU7mzAXNDntWYmYUYGJRLKvgH/UJmNUamzdOVDPuGnSsOunSZ1e4GBcjMjOaxgNkxwZiH+r/OkTraKMXkemkHbym4XvPsal9x7BBd1YjnmGgWtEdLf2FoPZnBYRmkH4IOw6tCdsDjOiCRJrwAN2I/lIPFrTGsyv0eIlA3ZeohMixbwaKvigpkQY5SSy4gDOeXAc0oxHGumvopznTnNmS9pw+25Cg51bKYPN58xcf+br8D5R+k7rafcYMZY/aBzC0TjQVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KwemXNSTlIuEfCpiV0Y6sNU6Wopgey7JQnSjoV2ddHw=;
 b=MwcO+lyDp5pLQMfLtT114vi+XZbkM+S8gAyj3P7WgNp55sP1A6YMcRdbs/r0ZLBY3aOZIWqX5rSdyBuNUmbwd8CQjG7J/VvrqrrUZzriwktATEOMJ6GoNZjZexG0Tupep3xrbbEIgkJpdq1QGo48zPjNXGaymLELIwOaegplCLxnXxAIDRujKyeV2b7emY2LRan0s7VxfXQrDngQQNM14Ua401mXE0YP9LcH0pap/HHwWMmi/iDuLoy9dHUvVjTq1P9+pTImlXExxjEU390UgjPn+vSW9/f/QuLxWDApvnIonQLYXGR1JHDeuo4oIjBjaC6VEafiN1tFXzGQ3GLCBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KwemXNSTlIuEfCpiV0Y6sNU6Wopgey7JQnSjoV2ddHw=;
 b=iuQ588ygsauQERujqUn6VoFbPYljYt3cA9Pkoo3a02U9euhtyCUK0Z7H6EbCz19QxUdpiKmhCaxAZ7gaKtqEHXMBzXSuJh5vbGHpDN/cclWtrs3eqSUJELRd4VOcn9LLeBxJNQeQ9TShdF3dk64iVXwjN2nHJcXF1fNHepT34dY=
Received: from MW4PR04CA0339.namprd04.prod.outlook.com (2603:10b6:303:8a::14)
 by BYAPR12MB2966.namprd12.prod.outlook.com (2603:10b6:a03:df::27)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.14; Fri, 18 Mar
 2022 21:48:16 +0000
Received: from CO1NAM11FT034.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8a:cafe::26) by MW4PR04CA0339.outlook.office365.com
 (2603:10b6:303:8a::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.18 via Frontend
 Transport; Fri, 18 Mar 2022 21:48:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT034.mail.protection.outlook.com (10.13.174.248) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5081.14 via Frontend Transport; Fri, 18 Mar 2022 21:48:14 +0000
Received: from dev.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 18 Mar
 2022 16:48:12 -0500
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 00/13] Title: DC Patches March 18, 2022
Date: Fri, 18 Mar 2022 15:47:47 -0600
Message-ID: <20220318214800.3565679-1-alex.hung@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 684f52ac-0efa-461c-beae-08da09290194
X-MS-TrafficTypeDiagnostic: BYAPR12MB2966:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB296685E651838EAFD9173B10F7139@BYAPR12MB2966.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4K0+FBAYt3weL55YI5O9SuxpKtP/9qoZKDEdOa4qlT5IuLZ1aE8mrpWNyJ+Xg+e2zY2wmUa7/4JDNlIZvM2usyB6/FvI1df2f+7wYzkaQ63XCtP2m9Pped58RcuN1+n12Q+2aof+AeURfc8DkKmn5jMFFpA/96zuLpith7wf8mNWIRyI2NnMqeH7edBdyR7epWimwebDTW5NiBYGcb/HgJN0rleE5cNszmn0GKGnUpmPATRB/nbSW8Kig/FBePy45u1hQoZK6C5t/QoE49xSouzE5ELn54hCEPdnWv0/NzCAl0FzQu69rGeFuDppRQPwWiK/kBW7/B0KQBJtCKUrPd2d9gT/H2srtNmJFTnQyzGeaPERtkEquyQqytpjNnnAePP8Cr1zVn9vRtisw+2AGbY5unVJ2c5ClsShB6m28xmWy/D05Qq0TVBPAdpIG7M7NPz8rml0JXHtumavnx0e1a4xPT7zcz3UnufWwchOxcr+4D3LQ0G/QToakc+POchXyxpEOC/3wrHw07hXQSTuCNf85jiUnYu/6yBDJ2gi8+Pj8L5ZaOrUvg4gStDHgotWQlI/kXuBVeLX7ac9Sl3+CeLy4jEksZ1eKRQPLm3sZ4Yty1Mxvv07OdqF2D9nJE7pbycgxDUmrz/7xeRPV85EwZ8F5W1BNoJyZBwvFIPZy6pXcz5mrdTEpq07E+InrMPqyGWmwvddDh+svl19udGTpA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(426003)(7696005)(336012)(6666004)(5660300002)(40460700003)(316002)(36756003)(82310400004)(6916009)(1076003)(16526019)(44832011)(186003)(83380400001)(36860700001)(2616005)(26005)(47076005)(2906002)(508600001)(8936002)(4326008)(8676002)(54906003)(70586007)(81166007)(70206006)(86362001)(356005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2022 21:48:14.9306 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 684f52ac-0efa-461c-beae-08da09290194
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT034.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2966
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
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com, Alex Hung <alex.hung@amd.com>,
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This DC patchset brings improvements in multiple areas. In summary, we highlight:

* HDCP SEND AKI INIT error
* fix audio format not updated after edid updated
* Reduce stack size
* FEC check in timing validation
* Add fSMC_MSG_SetDtbClk support
* Update VTEM Infopacket definition
* [FW Promotion] Release 0.0.109.0
* Add support for zstate during extended vblank
* remove destructive verify link for TMDS
* move FPU related code from dcn31 to dml/dcn31 folder
* move FPU related code from dcn315 to dml/dcn31 folder
* move FPU related code from dcn316 to dml/dcn31 folder

Ahmad Othman (1):
  drm/amd/display: HDCP SEND AKI INIT error

Anthony Koo (1):
  drm/amd/display: [FW Promotion] Release 0.0.109.0

Aric Cyr (1):
  drm/amd/display: 3.2.178

Charlene Liu (2):
  drm/amd/display: fix audio format not updated after edid updated
  drm/amd/display: remove destructive verify link for TMDS

Chiawen Huang (1):
  drm/amd/display: FEC check in timing validation

Gabe Teeger (1):
  drm/amd/display: Add support for zstate during extended vblank

Leo (Hanghong) Ma (1):
  drm/amd/display: Update VTEM Infopacket definition

Melissa Wen (3):
  drm/amd/dicplay: move FPU related code from dcn31 to dml/dcn31 folder
  drm/amd/display: move FPU related code from dcn315 to dml/dcn31 folder
  drm/amd/display: move FPU related code from dcn316 to dml/dcn31 folder

Oliver Logush (1):
  drm/amd/display: Add fSMC_MSG_SetDtbClk support

Rodrigo Siqueira (1):
  drm/amd/display: Reduce stack size

 .../display/dc/clk_mgr/dcn315/dcn315_smu.c    |  19 +-
 .../display/dc/clk_mgr/dcn315/dcn315_smu.h    |   4 +-
 drivers/gpu/drm/amd/display/dc/core/dc.c      |  23 +
 drivers/gpu/drm/amd/display/dc/core/dc_link.c |   3 +-
 .../gpu/drm/amd/display/dc/core/dc_resource.c |   4 +-
 drivers/gpu/drm/amd/display/dc/dc.h           |   8 +-
 drivers/gpu/drm/amd/display/dc/dc_stream.h    |   2 +
 .../amd/display/dc/dcn10/dcn10_hw_sequencer.c |   8 +-
 .../drm/amd/display/dc/dcn20/dcn20_hwseq.c    |  12 +
 drivers/gpu/drm/amd/display/dc/dcn31/Makefile |  26 -
 .../gpu/drm/amd/display/dc/dcn31/dcn31_hubp.c |   8 +
 .../drm/amd/display/dc/dcn31/dcn31_resource.c | 356 +-------
 .../drm/amd/display/dc/dcn31/dcn31_resource.h |   4 +-
 .../gpu/drm/amd/display/dc/dcn315/Makefile    |  26 -
 .../amd/display/dc/dcn315/dcn315_resource.c   | 232 +----
 .../amd/display/dc/dcn315/dcn315_resource.h   |   3 +
 .../gpu/drm/amd/display/dc/dcn316/Makefile    |  26 -
 .../amd/display/dc/dcn316/dcn316_resource.c   | 231 +----
 .../amd/display/dc/dcn316/dcn316_resource.h   |   3 +
 drivers/gpu/drm/amd/display/dc/dml/Makefile   |   2 +
 .../drm/amd/display/dc/dml/dcn20/dcn20_fpu.c  |  18 +-
 .../drm/amd/display/dc/dml/dcn31/dcn31_fpu.c  | 863 ++++++++++++++++++
 .../drm/amd/display/dc/dml/dcn31/dcn31_fpu.h  |  44 +
 .../dc/dml/dcn31/display_rq_dlg_calc_31.c     |  13 +
 .../amd/display/dc/dml/display_mode_structs.h |   2 +
 drivers/gpu/drm/amd/display/dc/inc/hw/hubp.h  |   3 +
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   |   4 +-
 .../gpu/drm/amd/display/modules/hdcp/hdcp.c   |  38 +-
 .../gpu/drm/amd/display/modules/hdcp/hdcp.h   |   8 +
 .../drm/amd/display/modules/inc/mod_hdcp.h    |   2 +-
 .../display/modules/info_packet/info_packet.c |   5 +-
 31 files changed, 1085 insertions(+), 915 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml/dcn31/dcn31_fpu.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml/dcn31/dcn31_fpu.h

-- 
2.35.1

