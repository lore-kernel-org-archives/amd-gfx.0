Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E43DCC433EF
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Jun 2022 20:12:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 680AF1123D0;
	Fri,  3 Jun 2022 20:12:29 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2084.outbound.protection.outlook.com [40.107.96.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CB1971123D0
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Jun 2022 20:12:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QRjNjNyIdg+dzBbXuYqIJer+VHNuSXubRrpTpTmiXCuAlBqyVRzEQlfALIEe48ljHpRiu0HTO8sDNWjoQTLdh3wa3ccDQAk2YCMUur0crrf4BEt8DrD6IdFX/aEaa4qn//RRZ1ot4xM3jZnbUpuuDs8lI0E9QdYzQPkzo3iP4Apbs7xI0QtqSEEgVOdbXj2NapQ+ZVm1appl4UNqhHiJGalvu8i/eDcnc9jPnuiiMYudWim+DH+EF1fHN60hA9sjS8onsl3RmW/isM08Z1YLb9Jo/3pInax3boTJ8o75UNp2JYhjKBj0rM4qaAjUGEpUSMEkqr9ho+BdRP+ogl9VpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pNu57R9PhLWmtuxPY4sdnEi6u2r9m85NcPoQIZPnPDU=;
 b=U5zr38EhyRwhjx5gYkPYdzZizVDSRO7D8U/HSz+RwAlgoAZKyf3E0BoWd2xavOEBxOr3SXTV93XE5aQKgmkTLVqD4q8bsKry4G3kPvfYLM3pATi4Ex0Ls6+oDPR0+fkw7C9RuWCkwEDdkz4USVlBDs5z40M1ddYnTmH2W/BX1aYOrf6vihjOdfl73LGdpuCsqWngHYc6kPi9esPhJ9lmY/wxSSwWMge3sBODrJOyVsb3m32QlHi0PEjGQXZlqe8Hybpbm9On2unezDV7VhQ3cl/4dfp2c+GJGpZEtnLZ7j+G3X+ldtwoO8+bcHYzmFyQzMhy2kpEN48gt03Y/8Lu0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pNu57R9PhLWmtuxPY4sdnEi6u2r9m85NcPoQIZPnPDU=;
 b=qldjCTpxhbLDAArBkR4WO/jOoiPVFA6/j+mFPQcO7WRoAIGTiD+3LUPejNSuDk8SJ2QjI7IQbw7cC8fUABQF6kiYuvYgNbbCiPop80GloNmAtfB7M8EgZkJ1QzYa+y+LCSW1z2VXYy5beO8g6kYHMrw9hk9cxTeiLQVbYfgzVLQ=
Received: from DM6PR03CA0052.namprd03.prod.outlook.com (2603:10b6:5:100::29)
 by BN6PR12MB1780.namprd12.prod.outlook.com (2603:10b6:404:107::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.12; Fri, 3 Jun
 2022 20:12:23 +0000
Received: from DM6NAM11FT042.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:100:cafe::70) by DM6PR03CA0052.outlook.office365.com
 (2603:10b6:5:100::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.15 via Frontend
 Transport; Fri, 3 Jun 2022 20:12:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT042.mail.protection.outlook.com (10.13.173.165) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5314.12 via Frontend Transport; Fri, 3 Jun 2022 20:12:22 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 3 Jun
 2022 15:12:21 -0500
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 00/16] DC Patches May 30, 2022
Date: Fri, 3 Jun 2022 16:11:31 -0400
Message-ID: <20220603201147.121817-1-hamza.mahfooz@amd.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5f87231a-ba58-4417-6b63-08da459d5ee5
X-MS-TrafficTypeDiagnostic: BN6PR12MB1780:EE_
X-Microsoft-Antispam-PRVS: <BN6PR12MB178096032B30610255D09BD8F4A19@BN6PR12MB1780.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5+pcuPfjXaVrVmaFXpR1/EEh8ZqWxTRcvoHWGN9fM5utRLNiq5zSdGMUU4Fs1QCG4M1i+8acNdeqdMMBf5auPs1B8iUoUGvzHmcKZhHyZTGBxLe+5GsjiQajneEE4qn5uM+rne7ebvB+7tFOf0MMPNSJ/+m1hOJHuPtMpHWoPivas7qQNislP8VdmmcpvsK2tP5+ScAirZ7NJrzCbyY4jzKETJ3rkd8dNrg/2B+5Obf4rS24OvYwnqws0jNZh9dZu3u7k4ZUihyu3Sg7fsBK/SjV7QctoWnU427SgxnCoeFQ4B5auLoA1Bb7slEushDTLGqDObZzsIw/lAX12uuGFHsHrL3UGCFfOLbV+jyqI/8uivgjR3NGScwSz8PQUcI+3eJsQkAfmYVn8NIOlJ/Dz19FxMUpLrBV7lC6alsLUxRJY2uq41D4aYCkT+Mpm2ORfmEGiBQa07ZCmgcSV4ugdz+P3tduRSRlj7UpTV+EV5crdesksobrzMi7c9eturlgWyP7RlYUfQlZSE7PqAkI0jQ9OJ+C8kyjXrxJg5KmuzwmvmzpqCUkXEgxH/txFTzIDjAWFqPVFZ3ltzCbuwIWznzWQoFHrm5OtgjZ533L0I8DI7z6GJDmpRQQ2BBCljldTIIqyLgsq7poK/on270AjL90Jc5CKJ+NZcLtBGps3NUtG4mH1EQxV6osTrUXtoZjqfd8YlKQ6k9BEUfFh8gqSA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(426003)(16526019)(186003)(336012)(83380400001)(2906002)(44832011)(1076003)(316002)(70586007)(47076005)(70206006)(8676002)(4326008)(36860700001)(36756003)(82310400005)(5660300002)(6916009)(54906003)(8936002)(81166007)(40460700003)(356005)(26005)(6666004)(86362001)(2616005)(508600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2022 20:12:22.9528 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f87231a-ba58-4417-6b63-08da459d5ee5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT042.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1780
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
 solomon.chiu@amd.com, jerry.zuo@amd.com, Aurabindo.Pillai@amd.com,
 hamza.mahfooz@amd.com, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

* DPP DTO fix                                                                    
* Transient encoder fix                                                          
* Restrict the reading of LTTPR capabilities in LTTPR mode                       
* Increase maximum stages for BB                                                 
* Distinguish HDMI DTO from DP DTO                                               
* Optimized blank calculations                                                   
* More robust DP MST hotplug support                                             
* eDP bug fix relating to ODM                                                    
* Revert a patch that caused a regression with DP                                
* min comp buffer size fix                                                       
* Make DP easier to debug                                                        
* Calculate the maximum OLED brightness correctly                                
* 3 plane MPO.

Anthony Koo (1):
  drm/amd/display: [FW Promotion] Release 0.0.119.0

Aric Cyr (2):
  drm/amd/display: 3.2.188
  drm/amd/display: 3.2.189

Chris Park (1):
  drm/amd/display: Add HDMI member to DTO

Duncan Ma (3):
  drm/amd/display: Blank eDP on enable drv if odm enabled
  drm/amd/display: Correct min comp buffer size
  drm/amd/display: Fix dpp dto for disabled pipes

Gabe Teeger (1):
  drm/amd/display: Update optimized blank calc and programming

Hansen Dsouza (1):
  drm/amd/display: Enable 3 plane MPO

Jimmy Kizito (2):
  drm/amd/display: Fix entry into transient encoder assignment mode.
  drm/amd/display: Avoid reading LTTPR caps in non-LTTPR mode.

Lei, Jun (1):
  drm/amd/display: Extend soc BB capabilitiy

Nicholas Kazlauskas (1):
  Revert "drm/amd/display: Pass the new context into disable OTG WA"

Roman Li (1):
  drm/amd/display: Cap OLED brightness per max frame-average luminance

Wayne Lin (1):
  drm/amd/display: Detect dpcd_rev when hotplug mst monitor

Wenjing Liu (1):
  drm/amd/display: add DP sanity checks during enable stream

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  8 +-
 .../display/amdgpu_dm/amdgpu_dm_mst_types.c   | 38 ++++++++-
 .../display/dc/clk_mgr/dcn31/dcn31_clk_mgr.c  |  8 +-
 .../dc/clk_mgr/dcn315/dcn315_clk_mgr.c        |  8 +-
 .../dc/clk_mgr/dcn316/dcn316_clk_mgr.c        |  8 +-
 .../gpu/drm/amd/display/dc/core/dc_debug.c    |  2 +
 drivers/gpu/drm/amd/display/dc/core/dc_link.c | 21 +++++
 .../gpu/drm/amd/display/dc/core/dc_link_dp.c  | 77 +++++++++++++------
 .../drm/amd/display/dc/core/dc_link_enc_cfg.c | 45 ++++++++++-
 drivers/gpu/drm/amd/display/dc/dc.h           |  4 +-
 drivers/gpu/drm/amd/display/dc/dc_link.h      |  1 +
 .../drm/amd/display/dc/dcn20/dcn20_hwseq.c    |  4 +
 .../display/dc/dcn31/dcn31_dio_link_encoder.c |  6 ++
 .../gpu/drm/amd/display/dc/dcn31/dcn31_hubp.c |  2 +-
 .../drm/amd/display/dc/dcn31/dcn31_hwseq.c    | 24 +++++-
 .../drm/amd/display/dc/dcn31/dcn31_resource.c |  1 -
 .../amd/display/dc/dcn315/dcn315_resource.c   |  6 +-
 .../amd/display/dc/dcn316/dcn316_resource.c   |  6 +-
 .../gpu/drm/amd/display/dc/dml/dc_features.h  |  2 +-
 .../drm/amd/display/dc/dml/dcn31/dcn31_fpu.c  |  3 +-
 .../dc/dml/dcn31/display_rq_dlg_calc_31.c     | 16 +---
 .../amd/display/dc/dml/display_mode_structs.h |  1 +
 .../drm/amd/display/dc/dml/display_mode_vba.h |  1 +
 .../gpu/drm/amd/display/dc/inc/core_status.h  |  2 +-
 drivers/gpu/drm/amd/display/dc/inc/hw/dccg.h  |  1 +
 .../gpu/drm/amd/display/dc/inc/link_enc_cfg.h |  7 ++
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   |  1 +
 27 files changed, 234 insertions(+), 69 deletions(-)

-- 
2.36.1

