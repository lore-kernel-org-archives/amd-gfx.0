Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86731C433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Dec 2021 21:24:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 28B0810E4E0;
	Fri, 17 Dec 2021 21:24:29 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2089.outbound.protection.outlook.com [40.107.96.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D904A10E4E0
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Dec 2021 21:24:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fp+6v2G81Wp3jVmXGFAp+MZdBbs+Dva35I3g7NXQsnK1CqEU8A7FtOUH0P2fWfhPdeK+VgRO0XmFjo5O5KHX/Ebd8k64kv2Bm+S3/QorRhI8uPibKs1JYFcWaOEhAjF9EyrAEeCtsfMFhNXY2rk5Fj1xOtrJsETjQ/uq1dEPA36g4HKwIVI0hSTTX8JL9UWuhtJ1vBRT2H4quP7WLYxozTnP2cBXLd4hMCZAAIRPSVKua3SwZ1jVi03LnfIRDCnvqQstZiH8/ok7Gj9R70wOyKPj1MuY9amHqkJ1PGqIm3tJZ2XUrBJX6+ccSqDTo3aQrPXcpESRCkOCA0Enk0u+Ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=31hsCzKzRTOkR+xXnzaj2OPWfchdnB+e8OKAs6w2xvM=;
 b=Q9h2+ZtKunaVQ5jOEt0Vvpiq1kLeYVe4g3MotArM/sSMxd9LunZASmFoKGjhz6ILkWszHiCHftlpd+vvtwR95dfGJLK1jnlM7vioHqN23elvibz41opoRZaN5T3fuzvp78dPHiDYw9NHjVd5g03P08jOTskohhyd+DZqbpNGcY+EEgfdP5og1Hla/G1GoEFtDC7Z1xDHw1j54FKt+L07lA9AqheFpaYGhzEjeyBy1VBv/WD2IDIE+AEFv5pKmcL7l1+hhiytveuNdKddl+Si9LrpsHKcWtobTR7TdQOu9CN5dZdKLj4ngOOI9GzD9LoXDAThJIiH/rTpyR4psN8icQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=31hsCzKzRTOkR+xXnzaj2OPWfchdnB+e8OKAs6w2xvM=;
 b=Ndef7OBmJ/3w0rwft9NfQRZO0wcBauf2nXiP8okhN7eZRrW/BJe+DpEhAAtm5LSSsceFxTd4/xRnIH+v4L9VAIocaJCYZhnUCiDB8esDgspmAWChwomrsUkjixFHt8Dqpao2/HAnFKF8I3/vkBGmwI138pnziejftxM6FT9VayQ=
Received: from MWHPR20CA0032.namprd20.prod.outlook.com (2603:10b6:300:ed::18)
 by BN8PR12MB3523.namprd12.prod.outlook.com (2603:10b6:408:69::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.14; Fri, 17 Dec
 2021 21:24:24 +0000
Received: from CO1NAM11FT058.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:ed:cafe::f4) by MWHPR20CA0032.outlook.office365.com
 (2603:10b6:300:ed::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.14 via Frontend
 Transport; Fri, 17 Dec 2021 21:24:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT058.mail.protection.outlook.com (10.13.174.164) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4801.14 via Frontend Transport; Fri, 17 Dec 2021 21:24:23 +0000
Received: from atma2.hitronhub.home (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Fri, 17 Dec
 2021 15:24:22 -0600
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 00/19] DC Patches December 17, 2021
Date: Fri, 17 Dec 2021 16:23:48 -0500
Message-ID: <20211217212407.3583190-1-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 201e99a8-6a80-4956-e0d4-08d9c1a39912
X-MS-TrafficTypeDiagnostic: BN8PR12MB3523:EE_
X-Microsoft-Antispam-PRVS: <BN8PR12MB3523CCED1A9208356C0050E698789@BN8PR12MB3523.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xk3kmDZ41ujn+QRWME+RjhdupFz5Byu2NXrEGyBOPRzBXfu3X6XPz49XRVmBVOrNGFYnf+8Pbr9q7HplmSv4NFj6r+946I4I39UNwgqP8edYap+0116/8Nzi77CoLQ5BTx9mAYz5DLj4L7SuUN+MbeXuuE/l1j67JsZp95rvAX+ylDAbkePRlnu3cSI8Z+WrK2EOVYTXfw4cJabaxaLDByj3g/MTNRROSiMhV+Z8k4pEtdG/VFZu0BDMI8uunxBrRDkQK/r1ZQpkFLbk+FfZ43CzfZqNT6VhopoP1iXxjJa8gQlk6ioXCLeKi8A9wL3P5sPqyuwLCMz3A0GWcbV+ahbuvLKuLEzJSusncNDPNlBMt/eiIB4ELb1lkKm1vF7Sl4pTRaDLAk3V2KgwlJueL3nINxHLKLThjkVx4Gj4a+JdMZSAuzAYemMQVWP9reJxKs/Q+P4zbU4DkpC6N0GmbnRIGHruMicA3j281hX2v0wjgucra8ek23UU6Y6ZVSIuORJUQpww8DWNP3hkhkVbfCJ5zqYRWxjbK9YQYb4NH9KHopNDKWAsgRXhyrSW64i9n1f7xTgx11VQ6+QcMoLVnb4mxaVw2ZGCq7LBY9Z76X0t1vdCxY34gR48doplncXGiOAX/I91CuouoMWf6+wFBZZBtgo+83fwcfmfOG66//tPnSB1NjDFH5xdvJDj9okYGQ/vveLkL0Z4dWG/FQ29IxscfvSmkhUMvifJk7CdLxhm4QYfc0OYFhx152SD50sc8k3Lu2tzyLMqMyYtFya/sh7N1B5MN5F+Wjgn3ZoEaMs=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(40470700001)(70586007)(70206006)(1076003)(47076005)(86362001)(6666004)(356005)(426003)(4326008)(36756003)(316002)(81166007)(2906002)(82310400004)(36860700001)(8936002)(2616005)(40460700001)(54906003)(26005)(186003)(16526019)(5660300002)(508600001)(83380400001)(6916009)(336012)(8676002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2021 21:24:23.9898 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 201e99a8-6a80-4956-e0d4-08d9c1a39912
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT058.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3523
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
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com, mikita.lipski@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This DC patchset brings improvements in multiple areas. In summary, we
highlight:

- Fixes and improvements in the LTTPR code
- Improve z-state
- Fix null pointer check
- Improve communication with s0i2
- Update multiple-display split policy
- Add missing registers

Cc: Daniel Wheeler <daniel.wheeler@amd.com>

Thanks
Siqueira

Alvin Lee (1):
  drm/amd/display: Fix check for null function ptr

Angus Wang (1):
  drm/amd/display: Changed pipe split policy to allow for multi-display
    pipe split

Anthony Koo (1):
  drm/amd/display: [FW Promotion] Release 0.0.98

Aric Cyr (1):
  drm/amd/display: 3.2.167

Charlene Liu (1):
  drm/amd/display: fix B0 TMDS deepcolor no dislay issue

George Shen (2):
  drm/amd/display: Limit max link cap with LTTPR caps
  drm/amd/display: Remove CR AUX RD Interval limit for LTTPR

Lai, Derek (1):
  drm/amd/display: Added power down for DCN10

Martin Leung (1):
  drm/amd/display: Undo ODM combine

Nicholas Kazlauskas (3):
  drm/amd/display: Block z-states when stutter period exceeds criteria
  drm/amd/display: Send s0i2_rdy in stream_count == 0 optimization
  drm/amd/display: Set optimize_pwr_state for DCN31

Shen, George (1):
  drm/amd/display: Refactor vendor specific link training sequence

Wenjing Liu (5):
  drm/amd/display: define link res and make it accessible to all link
    interfaces
  drm/amd/display: populate link res in both detection and validation
  drm/amd/display: access hpo dp link encoder only through link resource
  drm/amd/display: support dynamic HPO DP link encoder allocation
  drm/amd/display: get and restore link res map

Wesley Chalmers (1):
  drm/amd/display: Add reg defs for DCN303

 .../display/dc/clk_mgr/dcn31/dcn31_clk_mgr.c  |   1 +
 drivers/gpu/drm/amd/display/dc/core/dc.c      |  18 -
 .../gpu/drm/amd/display/dc/core/dc_debug.c    |   2 +
 drivers/gpu/drm/amd/display/dc/core/dc_link.c | 234 +++++---
 .../gpu/drm/amd/display/dc/core/dc_link_dp.c  | 501 +++++++++++++++---
 .../drm/amd/display/dc/core/dc_link_dpia.c    |  48 +-
 .../drm/amd/display/dc/core/dc_link_hwss.c    |  63 ++-
 .../gpu/drm/amd/display/dc/core/dc_resource.c | 199 ++++---
 drivers/gpu/drm/amd/display/dc/dc.h           |   3 +-
 drivers/gpu/drm/amd/display/dc/dc_link.h      |  15 +-
 .../amd/display/dc/dcn10/dcn10_hw_sequencer.c |  14 +-
 .../gpu/drm/amd/display/dc/dcn10/dcn10_init.c |   1 +
 .../drm/amd/display/dc/dcn20/dcn20_hwseq.c    |   2 +-
 .../drm/amd/display/dc/dcn20/dcn20_resource.c |   5 +-
 .../amd/display/dc/dcn201/dcn201_resource.c   |   2 +-
 .../drm/amd/display/dc/dcn21/dcn21_resource.c |   2 +-
 .../drm/amd/display/dc/dcn30/dcn30_resource.c |  13 +-
 .../amd/display/dc/dcn301/dcn301_resource.c   |   2 +-
 .../amd/display/dc/dcn302/dcn302_resource.c   |   2 +-
 .../drm/amd/display/dc/dcn303/dcn303_dccg.h   |  20 +-
 .../amd/display/dc/dcn303/dcn303_resource.c   |   2 +-
 .../dc/dcn31/dcn31_hpo_dp_link_encoder.c      |   6 +-
 .../dc/dcn31/dcn31_hpo_dp_link_encoder.h      |   3 +-
 .../gpu/drm/amd/display/dc/dcn31/dcn31_init.c |   1 +
 .../drm/amd/display/dc/dcn31/dcn31_resource.c |  27 +-
 .../drm/amd/display/dc/dcn31/dcn31_resource.h |  31 ++
 .../gpu/drm/amd/display/dc/dml/dml_wrapper.c  |   2 +-
 .../gpu/drm/amd/display/dc/inc/core_status.h  |   2 +
 .../gpu/drm/amd/display/dc/inc/core_types.h   |  17 +
 .../gpu/drm/amd/display/dc/inc/dc_link_dp.h   |  15 +-
 .../gpu/drm/amd/display/dc/inc/dc_link_dpia.h |   5 +-
 .../drm/amd/display/dc/inc/hw/link_encoder.h  |   3 +-
 .../gpu/drm/amd/display/dc/inc/link_hwss.h    |  10 +-
 drivers/gpu/drm/amd/display/dc/inc/resource.h |   6 +-
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   |   4 +-
 .../gpu/drm/amd/display/dmub/src/dmub_srv.c   |   4 +-
 36 files changed, 964 insertions(+), 321 deletions(-)

-- 
2.25.1

