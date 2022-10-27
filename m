Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC061ECAAA1
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Oct 2022 18:38:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 299A710E0E2;
	Thu, 27 Oct 2022 18:38:50 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D0FA010E0E2
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Oct 2022 18:38:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iIeQtHxvjwMzYFPyQAQDNf6rTUCWp75nm8bHEW2o1gVFNN65FUxz+Qf9FHr0uKTNJDzaPnbYxCYC4xggXlQf70Nm1N63vO3JkGEdwpPTfTWw55bL47yRM5WNlH159UTRUofSPCZ6Y51XF+8ARABr+QPaqlqHCIs0YBAKDR0C5TNvYhFynfjRNhlXPRN5aM7J6qMbMJK9VNq5T8AnnVtWh2kFQD31SK0f249pXlxaeVdFk9yL6v3c3dLka7xMWkfR8OYI6pCZjJiIS/ETUzekoFKp99o1q/3hL1f0otTDpV5GnwPAx5RxIByc5NhVcAihTJxvJ9eD2/gYgVdkB6be1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PLa+TdMQPKZfBm/S8r+O7A1jC8y2ySosV7ogIvWFAOo=;
 b=SBKXDYDmgs/YHuJqdT1HVVPJwtZD78ZCgtN2P6Y1sj98k+YATg1PNLBVEmxYPDCWXMo0dhDWx56cdq7cA1tELQ7W12mAKRROXIeDztL2l11jAFYlj8NNseUTfjwcikP4fADr6Vjr6bO7UMei3bzjAp56ZUjyfVB48dseZEGySBc35QraYCJ89JiPmk5yxBvuewbh9ypY1J8mFz6OmQy/B0myDM2AfTDzDeGNf034m2i36cF2xw5TKo8kU18/gLn88zLdQqFCDLA21rU7uti8QbWN6hCbIFi0cRTdBoqvfwxWxF0KpiE8M7rAGwQueI1dhG8KYgCG8BUPIkCDIiZP+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PLa+TdMQPKZfBm/S8r+O7A1jC8y2ySosV7ogIvWFAOo=;
 b=fkwGs1O9Kj9Gq8e1SVWn8sLNRhNIKQPtcfOE910WrLwjDVK0fQHQYgj7dJsyAYCbDxyU4JSwIyIVvsOS0LSmcIs669oe/UILZvV7A+dvOThvXgdtNVr5nISbxzIloHge9pvMlW4E5w4G1XLc82vtx/m7IMq47f1bvwvINEXZTsI=
Received: from BN8PR07CA0030.namprd07.prod.outlook.com (2603:10b6:408:ac::43)
 by BL1PR12MB5061.namprd12.prod.outlook.com (2603:10b6:208:310::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.28; Thu, 27 Oct
 2022 18:38:43 +0000
Received: from BN8NAM11FT038.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ac:cafe::5e) by BN8PR07CA0030.outlook.office365.com
 (2603:10b6:408:ac::43) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.29 via Frontend
 Transport; Thu, 27 Oct 2022 18:38:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT038.mail.protection.outlook.com (10.13.176.246) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5746.16 via Frontend Transport; Thu, 27 Oct 2022 18:38:43 +0000
Received: from dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Thu, 27 Oct
 2022 13:38:41 -0500
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 00/18] DC Patches Oct 27, 2022
Date: Thu, 27 Oct 2022 12:35:25 -0600
Message-ID: <20221027183543.1117976-1-alex.hung@amd.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT038:EE_|BL1PR12MB5061:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e202906-3cba-4775-b0c0-08dab84a79a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /qrFZA8Fs/k+uUbIPUF4GUxqInoCSKfEeLvY7BQgxQtVSFoGzOzNC7NNvrE2CO9ymSKguKgQRIs+SM0aoxDmaxBXAPBlWBgKFmM1zwS4JyPsrkC8enfx2vCyHCem/LSuoISCMAqOBzYed/YYQZvFcRqpMGuiyOxvygoJ1lksAas3X0oQvfPe3KKcsUkKjLmnTgoLpCuAvk1nygx0MLgg23Ox8/2xdg4sCg6lRUbBHIMBPsG9k6Jpg/toQ1oV9S1yYDcdWorTti7O4q4dznqkkGhf58YXCdBxq+rAmUSW/kVrD1OWiw0smclOdOAFv/U/qaJgQvnPGv+U95MzWUweykyl+UhB7EsAFW+ZO590ZEa4E5fcaWMtEqp45zfWpvGWbTzEG5He7wyYU1e12228C665fylwHawnweLCIelmhWaQn2J86wP2OPkFyt6jL/e0n7fBpcdxQ71oPE1hv0ynkjjwIs3ARlEHs/koRJPsfejnrjjXk6HwyfauGa/AdsflOIiTW6K3HILSMNleWTPaBNz24ksN2Ex72G+TBRPJ6ih+biv/shZXGXnCG/o+3LygdrggsYJjFMhMihZSS0vJ/BtWaiDxw+8ZCQVcTTTO9tnScVJZ322Nsg3IOjMcjgPSQZLD7Afk3ri25Ah6T5Ib+veWTitYWY3jde1UKkD7A0pjMefePKPZ90PoOLG7DQUpWMstFq/w5XpUY2wscv5n4gK9auYt6xhdwefMSCU2bKCpLkpTUi+MXDC8ebI6ZJ4pQ/WPNo0IDxZ2bnlF/D3jWlvzOq/QVlCOIIX6hGyOdtwNNUEfsDu1WOfP9EK03oRn
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(39860400002)(346002)(136003)(376002)(451199015)(36840700001)(40470700004)(46966006)(82310400005)(44832011)(36756003)(2906002)(6666004)(8936002)(41300700001)(1076003)(86362001)(4326008)(70586007)(70206006)(8676002)(54906003)(26005)(426003)(7696005)(40480700001)(316002)(81166007)(356005)(82740400003)(5660300002)(36860700001)(6916009)(83380400001)(16526019)(2616005)(186003)(40460700003)(336012)(47076005)(478600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2022 18:38:43.4132 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e202906-3cba-4775-b0c0-08dab84a79a9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT038.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5061
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
 Aurabindo.Pillai@amd.com, Alex Hung <alex.hung@amd.com>, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This DC patchset brings improvements in multiple areas. In summary, we highlight:

    * Investigate tool reported FCLK P-state deviations
    * Fix null pointer issues found in emulation
    * Add DSC delay factor workaround
    * Round up DST_after_scaler to nearest int
    * Use forced DSC bpp in DML
    * Fix DCN32 DSC delay calculation
    * Use min transition for SubVP into MPO
    * Add a debug option HBR2CP2520 over TPS4
    * Stop waiting for vblank during pipe programming
    * Modify checks to enable TPS3 pattern when required
    * Remove rate check from pixel rate divider update
    * Check validation passed after applying pipe split changes
    * Update DML formula
    * Don't enable ODM + MPO
    * Include virtual signal to set k1 and k2 values
    * Reinit DPG when exiting dynamic ODM

Cc: Daniel Wheeler <daniel.wheeler@amd.com>

Alvin Lee (2):
  drm/amd/display: Don't enable ODM + MPO
  drm/amd/display: Use min transition for SubVP into MPO

Anthony Koo (1):
  drm/amd/display: [FW Promotion] Release 0.0.141.0

Aric Cyr (1):
  drm/amd/display: 3.2.210

Charlene Liu (2):
  drm/amd/display: Update DML formula
  drm/amd/display: Fix null pointer issues found in emulation

Dillon Varone (2):
  drm/amd/display: Reinit DPG when exiting dynamic ODM
  drm/amd/display: Check validation passed after applying pipe split
    changes

Eric Bernstein (1):
  drm/amd/display: Include virtual signal to set k1 and k2 values

George Shen (4):
  drm/amd/display: Fix DCN32 DSC delay calculation
  drm/amd/display: Use forced DSC bpp in DML
  drm/amd/display: Round up DST_after_scaler to nearest int
  drm/amd/display: Add DSC delay factor workaround

Iswara Nagulendran (1):
  drm/amd/display: Modify checks to enable TPS3 pattern when required

Leo Chen (1):
  drm/amd/display: Add a debug option HBR2CP2520 over TPS4

Martin Leung (1):
  drm/amd/display: Stop waiting for vblank during pipe programming

Nevenko Stupar (1):
  drm/amd/display: Investigate tool reported FCLK P-state deviations

Taimur Hassan (1):
  drm/amd/display: Remove rate check from pixel rate divider update

 drivers/gpu/drm/amd/display/dc/core/dc.c      | 43 +++++++++----------
 drivers/gpu/drm/amd/display/dc/dc.h           |  4 +-
 drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c |  6 ++-
 .../drm/amd/display/dc/dcn20/dcn20_hwseq.c    | 24 ++++++++++-
 .../drm/amd/display/dc/dcn31/dcn31_hwseq.c    |  6 ++-
 .../drm/amd/display/dc/dcn31/dcn31_resource.c |  2 +
 .../drm/amd/display/dc/dcn314/dcn314_dccg.c   |  2 +-
 .../amd/display/dc/dcn314/dcn314_resource.c   |  2 +
 .../amd/display/dc/dcn315/dcn315_resource.c   |  2 +
 .../amd/display/dc/dcn316/dcn316_resource.c   |  2 +
 .../drm/amd/display/dc/dcn32/dcn32_hwseq.c    |  6 +--
 .../drm/amd/display/dc/dcn32/dcn32_resource.c |  2 +
 .../dc/dml/dcn31/display_mode_vba_31.c        |  3 +-
 .../dc/dml/dcn314/display_mode_vba_314.c      |  3 +-
 .../drm/amd/display/dc/dml/dcn32/dcn32_fpu.c  | 14 +++---
 .../dc/dml/dcn32/display_mode_vba_32.c        | 10 +++--
 .../dc/dml/dcn32/display_mode_vba_util_32.c   |  7 +--
 .../dc/dml/dcn32/display_mode_vba_util_32.h   |  3 +-
 .../dc/dml/dcn32/display_rq_dlg_calc_32.c     |  4 +-
 .../amd/display/dc/dml/dcn321/dcn321_fpu.c    |  5 ++-
 .../amd/display/dc/dml/display_mode_structs.h |  3 ++
 .../drm/amd/display/dc/dml/display_mode_vba.c |  2 +-
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   |  6 +++
 23 files changed, 108 insertions(+), 53 deletions(-)

-- 
2.38.1

