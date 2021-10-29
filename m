Return-Path: <SRS0=vl2N=PR=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A819C433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Oct 2021 15:15:03 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 40AED610FD
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Oct 2021 15:15:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 40AED610FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BB5FE6E10E;
	Fri, 29 Oct 2021 15:15:02 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2085.outbound.protection.outlook.com [40.107.220.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 03F1F6E10E
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Oct 2021 15:15:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=grEr4f0Eefo+5kRHhtSkdIXF8Jz7Yqfg3XE4lENyl40GSalrULrm8QN5QSG3obn4ADZ+33Q075ru+RyID47qxkjD5t4eASlpeFZVZeL42DFcsePR5CWeKajhWtQa2k4EgrlcyBCo4Ki0cbcrmAVqhdPCNWczygtAgUGS2lOdkteyyrNr6so1TA4r8B9ywm54CUfw1G1s2JHYjI/SuTtxvmdqYcBNl2TigfEbpOiXs+0pwWVkZK8wbNr6T0mNTrDxPFBdh9iBm3JcNBgWzo2O28GAzJT1c1t6dPrPzX8FufIq2XH0/ZwuQawY/fdjW6zJlLW5/MVCqaAwnYhz+2DbFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n8r81IBBZsILWVhP/mQ2u/sKbk+8/+1PcNpChOY3ji0=;
 b=QE5u1JC0lERUqDip8L1ftCz6d72tzCI1sy3fdUHY7Ei0WTy6tQdJ7aTMUt3Bj02wPSIUetRQsFWrY4E9xLbJmEtdeudRnu5InOIqxtygqUbTCW5eC6bJwMKKTT2WWzAbGGSaB6/NV2kbT/ya2Tg0kBEIFFZZVjU/tRUJNQbd2MH6WkwNvgoMXRXjmsDd2iwzKPdL1OUKgzqoWjBgCTjII0+TgQwk5NcDcRFMoobxOadMq692Ke/8L9HbxrFAI7Ft2Ij7DJ12SLxLiwdqpY64trvUeCvSWQyojV1atJdzPD/2WxGhcAwXe3R6hnSjgZdHCPJS/M/kQatyUN/6oMJM+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n8r81IBBZsILWVhP/mQ2u/sKbk+8/+1PcNpChOY3ji0=;
 b=Dqqne+36d+3B5LEKc5KoUO0uTQxK/CDTwhFYdKOnzLYvDNIFweEb03KUnmn8nEx9eFIHdzKQdogUK/86UNi2wf8Id+OD1cxwAm6ewC3RHn5ijIsFTVhVTkOQ9yeMGPhc6lCvGbH/IdmjP1LC47FP3zgRvMUnrMmFm9/sNH0/4pw=
Received: from BN0PR02CA0017.namprd02.prod.outlook.com (2603:10b6:408:e4::22)
 by BYAPR12MB2693.namprd12.prod.outlook.com (2603:10b6:a03:6a::33)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.14; Fri, 29 Oct
 2021 15:14:59 +0000
Received: from BN8NAM11FT026.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e4:cafe::20) by BN0PR02CA0017.outlook.office365.com
 (2603:10b6:408:e4::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.15 via Frontend
 Transport; Fri, 29 Oct 2021 15:14:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT026.mail.protection.outlook.com (10.13.177.51) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4649.14 via Frontend Transport; Fri, 29 Oct 2021 15:14:58 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Fri, 29 Oct
 2021 10:14:58 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Fri, 29 Oct
 2021 10:14:58 -0500
Received: from elite-desk-aura.lan (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2308.15 via Frontend
 Transport; Fri, 29 Oct 2021 10:14:57 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Bhawanpreet.Lakha@amd.com>, <Rodrigo.Siqueira@amd.com>,
 <Aurabindo.Pillai@amd.com>, <qingqing.zhuo@amd.com>, <mikita.lipski@amd.com>, 
 <roman.li@amd.com>, <Anson.Jacob@amd.com>, <wayne.lin@amd.com>,
 <stylon.wang@amd.com>, <solomon.chiu@amd.com>, <pavle.kotarac@amd.com>,
 <agustin.gutierrez@amd.com>
Subject: [PATCH 00/14] DC patches for Nov 1, 2021
Date: Fri, 29 Oct 2021 11:14:42 -0400
Message-ID: <20211029151456.955294-1-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8e0d1868-cced-4343-baca-08d99aeedf4c
X-MS-TrafficTypeDiagnostic: BYAPR12MB2693:
X-Microsoft-Antispam-PRVS: <BYAPR12MB2693A6A88B0EBE4A0B2CD6A58B879@BYAPR12MB2693.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ro0FoQr1X2lCveuwNlXuHLhSLtxPts+KK8Fr2UXLyK896GQTtbU8+aYp1vZwfosdgfmDJvabRAoLBaeFm7LnQ7ZX6XngmsfL3RRY0fjxBwOg2qvLqr5iULh2RxAjkYTj2b3FLcxWRzBPpyAG2CyTemVXYINyHe4LPGommEjyY1Znh5L6tx3O3CCRLhiK2vMkkjo959RdM50hdZVZWa9IjQ4v7gU+Ak0jOGzaFI/qsIQTwsvhvOBK5yib5zm0p4btOizYZdFXFw5Jb3crnS3sQq2B0U7uUQFVa/JXFKROL7wEus4g8iBuabgdt4Tv6wfm2s+z+8rpgzGyUe5bTfgyO2UBOjkL4nRLtF+wmjW387YhFwM2uKP+DkG5YFC6sc6FF5Jsg6gwcHqKCBarCplTCgTHeop7Ou8YwJoqyoF7b7VvbrYA4RQRpjCzMQmd1muXJhdlb0gCkyPxbLHKE4K48kufaMWpLqIfKoPTXa53clJvy1KiRlFZz63EXgwKcwlavS+FdOaMuHdJCjCeoW2BWPLFLx9y8mqrrz3lgGs61K12Vi5Uk3R4WAMtpQfXB0vo/6yyxlHWI7r0vcON3aMHmq8AL7xmUqQxAiFizMx2+DWvB8eisyT4XkRdhDKVSKyc1xeddxSD84EFFe2B890t4YJQR71fRRlCc5FJXVDWBFiUw+VT4iYUtJ3+izeLDIz1lmbRiV+Y/lb/Kgkjf28eLmv8z7FzORlq8sjTO2d97noqi1598jnD+HIvtHE91EWsi989JuVKf3Y6rsonNNhmHg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(26005)(6666004)(5660300002)(426003)(186003)(336012)(86362001)(2906002)(508600001)(36860700001)(4326008)(82310400003)(316002)(54906003)(83380400001)(6916009)(8936002)(70586007)(47076005)(70206006)(1076003)(44832011)(356005)(81166007)(8676002)(2616005)(36756003)(117716001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2021 15:14:58.8447 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e0d1868-cced-4343-baca-08d99aeedf4c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT026.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2693
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This DC patchset brings improvements in multiple areas. In summary, we highlight:

* DC release version 3.2.160
* DMUB fw version 0.0.91 and bug fixes
* DSC related fixes
* Minor power optimization improvements
* Bug fixes and improvements in display pipeline

-------------------------------

Anson Jacob (1):
  drm/amd/display: Fix dcn10_log_hubp_states printf format string

Anthony Koo (1):
  drm/amd/display: [FW Promotion] Release 0.0.91

Aric Cyr (1):
  drm/amd/display: 3.2.160

Aurabindo Pillai (1):
  drm/amd/display: add condition check for dmub notification

Bing Guo (1):
  drm/amd/display: Fix bpc calculation for specific encodings

Felipe Clark (1):
  drm/amd/display: Fix dummy p-state hang on monitors with extreme
    timing

Hersen Wu (1):
  drm/amd/display: dsc engine not disabled after unplug dsc mst hub

Jake Wang (3):
  drm/amd/display: Added HPO HW control shutdown support
  drm/amd/display: Add MPC meory shutdown support
  drm/amd/display: Added new DMUB boot option for power optimization

Jimmy Kizito (1):
  drm/amd/display: Clear encoder assignments when state cleared.

Roman Li (1):
  drm/amd/display: Force disable planes on any pipe split change

Wenjing Liu (1):
  drm/amd/display: fix register write sequence for LINK_SQUARE_PATTERN

Yu-ting Shen (1):
  drm/amd/display: avoid link loss short pulse stuck the system

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  31 ++--
 .../display/amdgpu_dm/amdgpu_dm_mst_types.c   | 150 ++++++++++++++----
 drivers/gpu/drm/amd/display/dc/core/dc.c      |   8 +-
 drivers/gpu/drm/amd/display/dc/core/dc_link.c |   2 +
 .../gpu/drm/amd/display/dc/core/dc_link_dp.c  |   8 +
 .../drm/amd/display/dc/core/dc_link_enc_cfg.c |  22 +++
 drivers/gpu/drm/amd/display/dc/dc.h           |   3 +-
 drivers/gpu/drm/amd/display/dc/dc_dp_types.h  |   3 +
 .../gpu/drm/amd/display/dc/dce/dce_hwseq.h    |   4 +-
 .../display/dc/dce110/dce110_hw_sequencer.c   |   6 +
 .../amd/display/dc/dcn10/dcn10_hw_sequencer.c |   2 +-
 .../drm/amd/display/dc/dcn20/dcn20_hwseq.c    |   3 +
 .../gpu/drm/amd/display/dc/dcn30/dcn30_mpc.c  |   7 +-
 .../drm/amd/display/dc/dcn30/dcn30_resource.c |   7 +-
 .../drm/amd/display/dc/dcn31/dcn31_hwseq.c    |  78 +++++----
 .../drm/amd/display/dc/dcn31/dcn31_hwseq.h    |   1 +
 .../gpu/drm/amd/display/dc/dcn31/dcn31_init.c |   1 +
 .../drm/amd/display/dc/dcn31/dcn31_resource.c |   6 +-
 .../dc/dml/dcn30/display_mode_vba_30.c        |  13 +-
 .../dc/dml/dcn31/display_mode_vba_31.c        |  14 +-
 drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h   |   1 +
 .../amd/display/dc/inc/hw_sequencer_private.h |   1 +
 drivers/gpu/drm/amd/display/dmub/dmub_srv.h   |   1 +
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   |   4 +-
 .../gpu/drm/amd/display/dmub/src/dmub_dcn31.c |   1 +
 25 files changed, 271 insertions(+), 106 deletions(-)

-- 
2.30.2

