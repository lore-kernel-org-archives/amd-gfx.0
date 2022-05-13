Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5289C433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 13 May 2022 20:51:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EA36E10E565;
	Fri, 13 May 2022 20:51:29 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam07on2089.outbound.protection.outlook.com [40.107.95.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A28AA10E565
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 May 2022 20:51:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ahECWJ6LSYMYOp1bxol5oCZxEVfxmxmxRVYpSwx5ATLqvOy/L9mk6z684EYNuBUu6DlcHwjCaPz5ld4bX+fpPMRBXFBWgrtklOD9zUHDbj3JvT33AyNUr+HsX40DNolNqnoaueAu9XXkaTMHorZv6HtJA1h3v/V3GfZqqhcP3zkKQGscMpnG9qoe4P2HRLFi+UOBBp+je7AGCNV8oL48yQIgkR6tPVx8p6VtNcdjDfzwIfP1GP8wn68IUhYjutIhpe2Kzgwb23OfIPGUdqkXjPSewUzaCKl6bD9z2tjl0ZRPankxMdvIyX8pPpObSRc536EoGIIv81P+ZCMsvIV4Rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OMeqxLyOWlwElEI6Dfq6daxvVMnRD3gD9TsD5LFrMJ0=;
 b=kB3nQVFBMbDRLSKUgRmIxZL3PcWY6jfNBEN9G5Cagvl8kSe3SHTUWIQ925XiaHzw1SKoqCMl+3+Hs69P4ILqkCvkHwfj/s7BgIvS5qzh947EEwNyMXoztn+8ARV9stW8hWnqvxVxQGyjdCQI2v2dvhxeEn4P35hhiIQGrPYL8IXi1MaoshHX7zXTAtP0/qfho1aItoPNpJUfcIO7eM/ZAdqIxeHi6yqT0k1QH+Bk5sKp4LBwqi00rDkkw6XF6xTtdE0Eo+NtNjOOLD8Zh64CgC0X9dMZ4aDMGW0TAvCSmWH8LK5H6bpQ10Y90LhhdJ9gNsoTxrq1LbSA+9Vjp6zv+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OMeqxLyOWlwElEI6Dfq6daxvVMnRD3gD9TsD5LFrMJ0=;
 b=PW6kRJZBy5ZKdPuGEa3aXPWz7e9AHbVI5+bu2WVtNedZHQFpLUFYhJv7YZ98/BvjztqRdrFW1XrxsPZx8rr7ciYlu+OuyVoaVV/3Ol/RAYUqxr4iG+h+2TMWvTxwyFA9OIqUdqzd9xpf+WNMvS5o0J/mLzAxovJZOunnip6+6jM=
Received: from MW4PR03CA0285.namprd03.prod.outlook.com (2603:10b6:303:b5::20)
 by CH2PR12MB4055.namprd12.prod.outlook.com (2603:10b6:610:78::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.14; Fri, 13 May
 2022 20:51:25 +0000
Received: from CO1NAM11FT048.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b5:cafe::aa) by MW4PR03CA0285.outlook.office365.com
 (2603:10b6:303:b5::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.23 via Frontend
 Transport; Fri, 13 May 2022 20:51:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT048.mail.protection.outlook.com (10.13.175.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5250.13 via Frontend Transport; Fri, 13 May 2022 20:51:24 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 13 May
 2022 15:51:22 -0500
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 00/11] DC Patches May 16, 2022
Date: Fri, 13 May 2022 16:50:30 -0400
Message-ID: <20220513205041.1311639-1-qingqing.zhuo@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fcf73f90-ef71-4703-899c-08da352257de
X-MS-TrafficTypeDiagnostic: CH2PR12MB4055:EE_
X-Microsoft-Antispam-PRVS: <CH2PR12MB4055EA060AF1DCD8D94E73F3FBCA9@CH2PR12MB4055.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Y9N6S/BGZOlF3LWoPIxAtWHJbDoUe4EXSZ/5kCBIIpHeY2pSRMJUesSH70xM9n88G11DgEmlxd9+NgcBhne52mVqgeZTbjLk3QmXIrTTBPo/+p2piIvwn/+TH48Rw/cUDxYB4bAG7TCGLNT9I+udgJPK8YEfHE/l7ZY3cbR6O9d/W5TWRRxK+lSjt9ssxE3Hr44NXDujjWhC/xsaZGatDu7VG3uPHt/avciJZt+orHqCO76YRfQugcqyg+OhZ0w/PP46HBK2NcTk/vzQkcBJjrfdxiOmoEhCMc4cvfl4R1SeOgS6COjnhiGPNBV/t9dbwQvtfSOiJHLwjPnSrNDguroZrCrpl46fC2tCietiA64h0dt3Gplkr74sF1fySDFTWgjtiUIV+kTnjwCU2J0MGhjxTHxvguYW87P0Jk4Mz3PYS4MCvrbGuQPZYa5Wbpfha+fhAVXrVeYxg9OARSKiJY2ycPrSHXk0yzbSCC8wELhPdavzPZRrNMftNZSBjFroa0kxEMJMKuWblenDr8i+I2EkMbIGIciv9adZFOJvW+JPGNBuneD1vr98HYmJfkEZY1U6SXUHbo80VI3TeSt7gcslBHkABmNfjGPkdpnNHO0ZUkdJw9DumONQxvXCrAHXAEgSOxQ2uGrTvk14bOM05+KrQV/I0fMCwt8d1ppyS4sbLs1q538fZMKtR2h5T8HnedDdQJkkmOtVDum0SWo52A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(316002)(6916009)(8936002)(2906002)(44832011)(82310400005)(54906003)(36756003)(508600001)(16526019)(6666004)(26005)(2616005)(1076003)(426003)(47076005)(336012)(186003)(81166007)(356005)(8676002)(36860700001)(5660300002)(4326008)(70586007)(70206006)(40460700003)(86362001)(83380400001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2022 20:51:24.3833 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fcf73f90-ef71-4703-899c-08da352257de
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT048.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4055
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
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This DC patchset brings improvements in multiple areas. In summary, we highlight:
 
* Improvements in link training fallback
* Adding individual edp hotplug support
* Fixes in DPIA HPD status, display clock change hang, etc.
* FPU isolation work for DCN30

---

Alvin Lee (1):
  drm/amd/display: Clean up code in dc

Aric Cyr (1):
  drm/amd/display: 3.2.186

Bhawanpreet Lakha (1):
  drm/amd/display: Fic incorrect pipe being used for clk update

David Galiffi (1):
  drm/amd/display: Check if modulo is 0 before dividing.

Derek Lai (1):
  drm/amd/display: Allow individual control of eDP hotplug support

Jasdeep Dhillon (1):
  drm/amd/display: Move FPU associated DCN30 code to DML folder

Jimmy Kizito (2):
  drm/amd/display: Update link training fallback behaviour.
  drm/amd/display: Query DPIA HPD status.

Michael Strauss (1):
  drm/amd/display: Revert refactor LTTPR cap retrieval

Nicholas Kazlauskas (1):
  drm/amd/display: Check zero planes for OTG disable W/A on clock change

Paul Hsieh (1):
  drm/amd/display: clear request when release aux engine

 .../amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c |   2 +-
 .../dc/clk_mgr/dcn315/dcn315_clk_mgr.c        |   3 +-
 .../dc/clk_mgr/dcn316/dcn316_clk_mgr.c        |   3 +-
 drivers/gpu/drm/amd/display/dc/core/dc.c      |  15 +-
 drivers/gpu/drm/amd/display/dc/core/dc_link.c |  24 +-
 .../gpu/drm/amd/display/dc/core/dc_link_dp.c  | 248 ++++---
 .../drm/amd/display/dc/core/dc_link_dpia.c    |  19 +
 drivers/gpu/drm/amd/display/dc/dc.h           |   4 +-
 drivers/gpu/drm/amd/display/dc/dc_link.h      |   2 -
 drivers/gpu/drm/amd/display/dc/dce/dce_aux.c  |   3 +-
 .../drm/amd/display/dc/dce/dce_clock_source.c |   9 +-
 .../drm/amd/display/dc/dcn20/dcn20_hwseq.c    |   1 -
 .../gpu/drm/amd/display/dc/dcn30/dcn30_optc.c |  10 +
 .../drm/amd/display/dc/dcn30/dcn30_resource.c | 516 ++-------------
 .../drm/amd/display/dc/dcn30/dcn30_resource.h |   5 +
 .../amd/display/dc/dcn301/dcn301_resource.c   |   2 +
 .../amd/display/dc/dcn302/dcn302_resource.c   |   2 +
 .../amd/display/dc/dcn303/dcn303_resource.c   |   2 +
 .../drm/amd/display/dc/dcn31/dcn31_resource.c |   2 +
 drivers/gpu/drm/amd/display/dc/dml/Makefile   |   3 +-
 .../drm/amd/display/dc/dml/dcn30/dcn30_fpu.c  | 617 ++++++++++++++++++
 .../drm/amd/display/dc/dml/dcn30/dcn30_fpu.h  |  67 ++
 .../gpu/drm/amd/display/dc/inc/core_types.h   |   7 +
 .../gpu/drm/amd/display/dc/inc/dc_link_dp.h   |   3 +-
 .../gpu/drm/amd/display/dc/inc/dc_link_dpia.h |   5 +
 .../amd/display/include/link_service_types.h  |   6 -
 26 files changed, 947 insertions(+), 633 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml/dcn30/dcn30_fpu.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml/dcn30/dcn30_fpu.h

-- 
2.25.1

