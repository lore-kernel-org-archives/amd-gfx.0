Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EB7CC433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Dec 2021 23:05:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CE6A610E395;
	Fri, 10 Dec 2021 23:05:08 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2086.outbound.protection.outlook.com [40.107.92.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5A52410E397
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Dec 2021 23:05:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z3GFGUB5NxH37fDykz9omtectSE5xnYjnjz7j5qBA7u2onMZ7IAR7PG4W+mmW9xCagCZ6hy3/InTvSGkbSEEw+43GQnIaJsZXzyiNkDNdSw4gBnW3msaERytExkY2qY852i/dtuhay9ufRMOGvpTD5nN/hmf8BNJCFXe1iYrsto3uBAZLn/pPml3muT8/HO2yVF/JaSOlWKDBZEteaZ7hJtWFCCUKa/7ULY8FVyN1qh532FtarnJhbPRlo6MUDyDqKh6yMrRqQ3p+MyWg+xXEqSboANWOTP4ZLqCIVJsXoGQr7N4deN3JVus2ugoxIAMGzCB3IwVRePqEHwHIg0jWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9K30Y1fwTTv75dNMoqVm8GTgkC2ZpTH2XvhMTGl31fw=;
 b=JAMfFe6CBM8Tdlv4ACZXw+00Lhb3BtOOZ3vsUxoeL3Z6xDaYrDFQTJpJallB03b5XxPOpuQUiwUFnoLbwFonXYbS+5otHQ5H8Nh0fkricdInv1x/jlg46QRzZbHOfikxqzrJ+RuYLYLVDF4L8tVpyNgTw1yaBcfCKgfkWV+ZZyiAt7jhjMmBOKA43nBTHpOcOcfsDerVj7sNsH6FvhMtyuZapDjPNjJKM85fdtv2f3vNidU0tq2J/WZ4m3UZORg36vL7Na9qiwBnn9UAMDetQ2dHTEl4TVu6m0n4Ne//9GSlZnnzNITE6WrTkseCKS9Jhl/qEogx8SaJsL5StGO2vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9K30Y1fwTTv75dNMoqVm8GTgkC2ZpTH2XvhMTGl31fw=;
 b=Y3Aoo1Zi4n58rhSw9OfoemCOjItBuKTVsqHNkelW/dQQzu4omJsz67VL/1rhDRdRJhQLSvtImbIORTiWxKSYn0ZAr5nLvHeGy47QTBwCkc1kX3I9Bnj2szViF/Lq/q/C9m7UaZLQi5Dn6nQHqSAU7OMlYUwO7U3K/wfU/V3+V5I=
Received: from DM5PR07CA0038.namprd07.prod.outlook.com (2603:10b6:3:16::24) by
 BYAPR12MB3048.namprd12.prod.outlook.com (2603:10b6:a03:ad::33) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4734.24; Fri, 10 Dec 2021 23:05:00 +0000
Received: from DM6NAM11FT033.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:16:cafe::bc) by DM5PR07CA0038.outlook.office365.com
 (2603:10b6:3:16::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.11 via Frontend
 Transport; Fri, 10 Dec 2021 23:05:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT033.mail.protection.outlook.com (10.13.172.221) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4778.13 via Frontend Transport; Fri, 10 Dec 2021 23:04:59 +0000
Received: from ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Fri, 10 Dec
 2021 17:04:56 -0600
From: Pavle Kotarac <Pavle.Kotarac@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: DC Patches January 10, 2020
Date: Fri, 10 Dec 2021 15:03:58 -0800
Message-ID: <20211210230408.619373-1-Pavle.Kotarac@amd.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6f3a9fa4-dddf-4a00-a087-08d9bc317dd1
X-MS-TrafficTypeDiagnostic: BYAPR12MB3048:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB3048F85254269071F52198E0FC719@BYAPR12MB3048.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vNCs5+004VvD5V/mvuM7c6htIciUIrOWfJf4objE56ANod54CdXUcAkLJbQqABnrUcPZZVwxvhqNGC9wiyp1Kt8yJqTSWH30vB4Ey/wRLR3u+VhDkR1HphDFLTwDCNvmF1fzV50JHmZPbdWinhNulft//QIcLUZjPWSw2/tm1zfiYilrGL//5+YsJDs3i4YH0BXFlZQUF+0Ffq13Lg+OXls0YIGcShO2tDsT0oFKFg0td+Dsxgvx1uJNv3VyE+hVCdxB52YzeO+qtiwvrpUpksbEladlPp3ONhHvqB4P4fc7J1A2XnmI6Qbk/PDtakST8AuzpLH0+4SejPdDK7tJpaBKsn43XaBUc/UTjE+l6L8uE3ycfhUmolzUq6TqfKCXT0GWS+NIzkBgsM4mZ26mm/92Zsq4RHueH7QduXbIpNLjoEwbHbNPuYClByGoa5HRWoOcMCbKuqER2lCAgb5dDjBqmprGuNKSBDEHHKmjZ35I4L0OqCJjFyDNjvU6S8x8FAgT2Q2EeW1teSajHBxUARenurJHkC2BshlG0501QWLUXl8VHBsJehf8AM4L591VF9uPbxYanls5wgbKbCl28WyINn1PFzrxZNCSHA+5gmhEcFU3/EpkNgmErELFXoF+yvxN+S4j4/hzw6zKZy9ydATgKf3rKmyltCIOrv9cJ0fdMIghX0lkROwTTQLbq2CyluinVdN8NItlm21wi25uaNN7vpn7L67Ur9iIGiB6/x7ufLQJwSg9UWSlc16WUMFeDKGh0w/YYquY9rNFr9tPekiLIxCDwuifFk4syT7BlJw=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(40470700001)(82310400004)(316002)(5660300002)(426003)(16526019)(186003)(83380400001)(47076005)(36756003)(70206006)(336012)(508600001)(86362001)(8936002)(2906002)(2616005)(356005)(36860700001)(8676002)(4326008)(1076003)(7696005)(6916009)(54906003)(26005)(70586007)(3480700007)(40460700001)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2021 23:04:59.9164 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f3a9fa4-dddf-4a00-a087-08d9bc317dd1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT033.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3048
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
Cc: stylon.wang@amd.com, solomon.chiu@amd.com, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, Anson.Jacob@amd.com, Daniel
 Wheeler <Daniel.Wheeler@amd.com>, Aurabindo.Pillai@amd.com, wayne.lin@amd.com,
 mikita.lipski@amd.com, Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 Pavle Kotarac <Pavle.Kotarac@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This new DC version brings improvements in the following areas:
 - FW promotion to 0.0.97
 - DSC fixes for supported Docks
 - Fixes eDP display issue
 - Vendor LTTR workarounds
 - Fixes Tiled display audio issue

Anthony Koo (1):
  drm/amd/display: [FW Promotion] Release 0.0.97

Aric Cyr (1):
  drm/amd/display: 3.2.166

Eric Bernstein (1):
  drm/amd/display: ODM + MPO window on only one half of ODM

Martin Leung (1):
  drm/amd/display: implement dc_mode_memclk

Michael Strauss (1):
  drm/amd/display: Force det buf size to 192KB with 3+ streams and
    upscaling

Mikita Lipski (1):
  drm/amd/display: parse and check PSR SU caps

Nicholas Kazlauskas (2):
  drm/amd/display: Set exit_optimized_pwr_state for DCN31
  drm/amd/display: Reset DMCUB before HW init

Solomon Chiu (1):
  drm/amd/display: Add src/ext ID info for dummy service

Wayne Lin (1):
  drm/amd/display: Add debugfs entry for ILR

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |   5 +
 .../amd/display/amdgpu_dm/amdgpu_dm_debugfs.c | 134 ++++++++++++++++++
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c | 101 +++++++++++--
 .../display/dc/clk_mgr/dcn30/dcn30_clk_mgr.c  |  44 +++++-
 drivers/gpu/drm/amd/display/dc/core/dc.c      |  92 ++++++++++++
 .../gpu/drm/amd/display/dc/core/dc_resource.c |  81 ++++++++---
 drivers/gpu/drm/amd/display/dc/dc.h           |   5 +-
 drivers/gpu/drm/amd/display/dc/dc_dp_types.h  |   9 ++
 drivers/gpu/drm/amd/display/dc/dc_types.h     |   1 +
 .../gpu/drm/amd/display/dc/dcn20/dcn20_hubp.c |  14 +-
 .../gpu/drm/amd/display/dc/dcn20/dcn20_hubp.h |   1 +
 .../drm/amd/display/dc/dcn20/dcn20_hwseq.c    |  10 ++
 .../drm/amd/display/dc/dcn20/dcn20_hwseq.h    |   4 +
 .../gpu/drm/amd/display/dc/dcn30/dcn30_hubp.c |   1 +
 .../drm/amd/display/dc/dcn30/dcn30_hwseq.c    |  11 ++
 .../drm/amd/display/dc/dcn30/dcn30_hwseq.h    |   5 +-
 .../gpu/drm/amd/display/dc/dcn30/dcn30_init.c |   1 +
 .../drm/amd/display/dc/dcn30/dcn30_resource.c |  11 ++
 .../gpu/drm/amd/display/dc/dcn31/dcn31_init.c |   1 +
 .../drm/amd/display/dc/dcn31/dcn31_resource.c |   8 ++
 .../gpu/drm/amd/display/dc/inc/hw/clk_mgr.h   |   7 +
 drivers/gpu/drm/amd/display/dc/inc/hw/hubp.h  |   1 +
 .../gpu/drm/amd/display/dc/inc/hw_sequencer.h |   1 +
 .../dc/irq/dce110/irq_service_dce110.c        |  10 +-
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   |   4 +-
 25 files changed, 514 insertions(+), 48 deletions(-)

-- 
2.32.0

Cc: Daniel Wheeler <Daniel.Wheeler@amd.com>
