Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EED7BC433F5
	for <amd-gfx@archiver.kernel.org>; Sat, 26 Feb 2022 15:41:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 58FA610E288;
	Sat, 26 Feb 2022 15:41:30 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam07on2077.outbound.protection.outlook.com [40.107.95.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1A3F510E288
 for <amd-gfx@lists.freedesktop.org>; Sat, 26 Feb 2022 15:41:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LhFhulyJoZK9ARqRrQGc8EzFHyedYNSa7vzo1yQmVnjTw7JdFqcPylfQ4Q0YygVC+BatRS6MVjBMT9Wms85hwf9fiILunHbrSC4XBSlMMosp3YYxnWuoWUegLvkgVLTiGZqfV6OUOS8/1IhZ9SdbMphjQkKDlY+eTD1trk3uM4FQ8kzBd46wmh6iys4YLl+wwY71+YB7wJwbS0DyBSzIwNXUIdXYDCqqLjhsyaZ9Mfa8JW/dQV535lSLDRETISNGwrFVJqQelFcfvuOj5Tvn6YlkHLUMSgp29bahf3yxaunmHo1q7rTWnqZ5ZAMo2XA63+Gwsf6nkF92Wj/oNlSxVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u9qubU6SF9BRrUJo8UbWIKsx4RWV/HV6pOVnNMPq3j0=;
 b=PVwVcFmPByQLFZOhcmAQed0D0y0dNka0u+gINH2DYSG9jxcYJTp1XWGvGhD1gJAsScMlkoSZsoI0pbOh8N8BhuDA9UfjHIa7pOexKcNLpcysG4YgCKv2yHA42ygzVYjobWB7BMJQp3LDhwlx/6DjhP1jEjR5hH2b2eFpIBOCgcbbebf9Ubw7ldVAevZ9Qq6dgGPXJtpNKIGHQB43LO8eU/CVCwYDpQ/yWfdbt5jUqP7gM+JJzElMN8G+tBDVYY9IRpbz2bTDmVncloThDI7QcFYzkEKTvMHuR49Wc5BgY9VRCPCsHBnGjhUt3Z2EXRkF8ZOpjoRKwcDSVq4LTcPPfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u9qubU6SF9BRrUJo8UbWIKsx4RWV/HV6pOVnNMPq3j0=;
 b=MAHPG1Ahcujt0FfLkw961TDgEi+Mep/J37u2vOONdL7G3yF37S7Evtrs2LtwPN+ugtrbPsLhxG3pcVb9yALR9RpG0TXim9R1wZdx5huksnDboJJqgSEaJiJ6wUvMViA4/wAkrY65rnJIWovByto8Nvp1m8lztFXaSvHs7VuNrzk=
Received: from BN6PR11CA0055.namprd11.prod.outlook.com (2603:10b6:404:f7::17)
 by BY5PR12MB4641.namprd12.prod.outlook.com (2603:10b6:a03:1f7::29)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.23; Sat, 26 Feb
 2022 15:41:23 +0000
Received: from BN8NAM11FT036.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:f7:cafe::20) by BN6PR11CA0055.outlook.office365.com
 (2603:10b6:404:f7::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.22 via Frontend
 Transport; Sat, 26 Feb 2022 15:41:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT036.mail.protection.outlook.com (10.13.177.168) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5017.22 via Frontend Transport; Sat, 26 Feb 2022 15:41:22 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Sat, 26 Feb
 2022 09:41:22 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Sat, 26 Feb
 2022 09:41:21 -0600
Received: from alan-dev.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.18 via Frontend
 Transport; Sat, 26 Feb 2022 09:41:18 -0600
From: Alan Liu <HaoPing.Liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 00/14] DC Patches Feburary 26, 2022
Date: Sun, 27 Feb 2022 07:41:03 +0800
Message-ID: <20220226234117.3328151-1-HaoPing.Liu@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c9cc29d7-a350-4621-d4e3-08d9f93e70d1
X-MS-TrafficTypeDiagnostic: BY5PR12MB4641:EE_
X-Microsoft-Antispam-PRVS: <BY5PR12MB4641ED8E2305EB2AFE2147A7F53F9@BY5PR12MB4641.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uDUup+FgcfiI2TsssfAa8e2eVBVaUIIHfaLEj0gZgI5Kt252ZO8OdLhsRtiCqRk9wIqpwDuB4/M4lYQhik827AeO9SdVNoXZ/3ssQ1scFaJCbapvzlqoGVYjKtCHsCYVZMaZ33xWAs3ak45RStGQxXt5HehwH/OX7daOZ4/JUFvSL3oN6xjXvNhzdXnATzyr42AqBfHyyu2fJMU7C3nty9jQNGgXTByNU6Z1pqzcPaUWH5+V+pX8OHY9645bra+p8OCcYb90cZHC/PWi4AIiyYa+umdVAr26TtUp7uOBx9XOvfxgYcNdX5QEHTOg37JDXFDJYQSVrH0vcNoPO+X5EUHZw49PUEHq0kKhKaKcJZR9m4a5zPqSSHhedcdTR34d80txLcSjlowzAQ5GCCRa2T+d46tdqggdeNqUB2EjDxkB42+sI4+XsUCKEI5g291Em37otPbxs3fpbl1FN2YvWhWdsbi/uXbNMIeFMGKCjPmfrMW7QqUjbcrnFBIxwOSbYV6zjVHG5oT3AFmC4fPuicSrFlNOQ1tNIediazXfUAtZM80sj7iYapxhex6bC9XL+So5JPHB0AUZm+aJdQLK1P/zqBG4M3rJSrreGnhZCbswKmHYTAu5+jZnoxmlKjT+HMAS3+vQMRj8YMhk+UvzUFqUw9Jyw045FBsDHmvUQSpLTYADeUkb5R9hGBJ17kYd73P7eizVAI3bfZpycc2NCQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(70206006)(70586007)(356005)(36756003)(2906002)(186003)(26005)(1076003)(316002)(40460700003)(54906003)(8676002)(4326008)(5660300002)(6916009)(81166007)(8936002)(426003)(336012)(508600001)(83380400001)(82310400004)(7696005)(2616005)(86362001)(47076005)(6666004)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2022 15:41:22.4942 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c9cc29d7-a350-4621-d4e3-08d9f93e70d1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT036.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4641
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
Cc: stylon.wang@amd.com, Alan Liu <HaoPing.Liu@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This DC patchset brings improvements in multiple areas. In summary, we have:
 
* Removing legacy invalid code.
* Fixes in DC, DCE110.
* Enhancements in DMUB.
* Improvements on DCN10, DCN31.
* Firmware promotion.

drm/amd/display: 3.2.175

	This version brings along following fixes:
	- Remove invalid RDPCS Programming in DAL
	- Make functional resource functions non-static
	- Reset VIC if HDMI_VIC is present
	- Add frame alternate 3D & restrict HW packed on dongles
	- Reg to turn on/off PSR Power seq in FSM
	- Modify plane removal sequence to avoid hangs
	- Pass HostVM enable flag into DCN3.1 DML
	- DC Validation failures
	- Program OPP before ODM
	- Refactor fixed VS w/a for PHY tests
	- Pass deep sleep disabled allow info to dmub fw
	- Refine the EDID override
	- [FW Promotion] Release 0.0.106.0
	- Add verify_link_cap back for hdmi

Anthony Koo (1):
  drm/amd/display: [FW Promotion] Release 0.0.106.0

Aric Cyr (1):
  drm/amd/display: 3.2.175

Charlene Liu (1):
  drm/amd/display: add verify_link_cap back for hdmi

Chris Park (1):
  drm/amd/display: Reset VIC if HDMI_VIC is present

Dillon Varone (2):
  drm/amd/display: Add frame alternate 3D & restrict HW packed on
    dongles
  drm/amd/display: Modify plane removal sequence to avoid hangs.

Hansen Dsouza (1):
  drm/amd/display: Remove invalid RDPCS Programming in DAL

Michael Strauss (1):
  drm/amd/display: Pass HostVM enable flag into DCN3.1 DML

Nicholas Kazlauskas (1):
  drm/amd/display: Make functional resource functions non-static

Robin Chen (1):
  drm/amd/display: Pass deep sleep disabled allow info to dmub fw

Shah, Dharati (1):
  drm/amd/display: Adding a dc_debug option and dmub setting to use PHY
    FSM for PSR

Shen, George (1):
  drm/amd/display: Refactor fixed VS w/a for PHY tests

Wesley Chalmers (1):
  drm/amd/display: Program OPP before ODM

jinzh (1):
  drm/amd/display: refine the EDID override

 drivers/gpu/drm/amd/display/dc/core/dc_link.c | 14 +++++-
 .../gpu/drm/amd/display/dc/core/dc_link_dp.c  | 16 ++++--
 .../gpu/drm/amd/display/dc/core/dc_resource.c |  2 +
 drivers/gpu/drm/amd/display/dc/dc.h           |  4 +-
 drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c |  1 +
 .../display/dc/dce110/dce110_hw_sequencer.c   | 49 ++++++++++---------
 .../amd/display/dc/dcn10/dcn10_hw_sequencer.c |  5 +-
 .../gpu/drm/amd/display/dc/dcn20/dcn20_hubp.c | 21 ++------
 .../display/dc/dcn31/dcn31_dio_link_encoder.c |  9 ----
 .../drm/amd/display/dc/dcn31/dcn31_resource.c |  5 +-
 .../drm/amd/display/dc/dcn31/dcn31_resource.h |  5 ++
 .../amd/display/dc/dcn315/dcn315_resource.c   |  1 +
 drivers/gpu/drm/amd/display/dc/dm_helpers.h   |  3 ++
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   | 12 +++--
 14 files changed, 83 insertions(+), 64 deletions(-)

-- 
2.25.1

