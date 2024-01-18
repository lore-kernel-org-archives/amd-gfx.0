Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F576C4707B
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Jan 2024 14:34:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B4C0710E823;
	Thu, 18 Jan 2024 14:34:47 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2057.outbound.protection.outlook.com [40.107.243.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 52AB310E823
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Jan 2024 14:34:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nPAltgW0rk5Q4CMhXcASkdBkqQE4mAcw7fxhXg0oumwZgd4uiqTqRQMNmR3C1o67Xn+3HBO4tX6eX5/kwl99P8ZwDWeTLs66hn+3vpwCst5Xg7AGjwpzL5Zu2G0xrgQnMLRZMljbcHxsTHvN/8gTSBdgqkxJEsfWh1m0zSRnn8lZFSHInVv4I8Vi55R/bZc4RKAynhY6z7tUuYjepuFWws4/JnhMa8ExbzH7T/Bcvta+YpgM7QFLE3ii+DsC/5Vs+eEe21zqEbYYLeqQ7gbHF9tPj8vpxILel9ZUQQs1mrdwen/oAhD/I4yi/Bb6WE9MVcJT9MW0aaphEx4e/8v4mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4hrlCraU6Kh2BAFQ/whCwBr6lNFfwz8RRnpMibxn45M=;
 b=UBrehJ2G/C5TL0Cl5dxq7tVkkwbxCoNzE7La6PvcttV4UsMOUmUR7d5H/JY7DaQzmdDck8Du88sNlHdXby7zy25meH8FPsWBkO3rJN+hM1Np+0jRU46kJauPFnJXyDZFqNE1AR7rSw6QjKyM/D0U0sZUJSvvDJMBg75GGAUcvmzZ+NlJRIpNmquH9Q8DnDvy8o5wExBVwnYdIlQzL0/CHzeGs0mCb25bKNbuo3Y0K+A+9Xbamm5MoK8STjzetkFQDd1sOJ6XFMgwdiMR70LyagufWq4FKIa9B6xmdR+f4zfI/GZMIa7xXRJuxVu2MJguaKzfR7iDwqcjmwYHRqxwLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4hrlCraU6Kh2BAFQ/whCwBr6lNFfwz8RRnpMibxn45M=;
 b=mtYWvMiwSQfonaisif9468DcWojC8KRTsFq6PJUhFqt3ImYsDffk9ZLvM4vs7BButxfH4hv3ZXPC+BkNRcPHtUzdQKojmbkTp+wD4cCgmf+obHrrx8DnDknkidGuQHooWEU0M3QUGsIpL3zdphx4ayky04dc7Mo09Hxhbf9Sa7Y=
Received: from PH0PR07CA0108.namprd07.prod.outlook.com (2603:10b6:510:4::23)
 by BL1PR12MB5972.namprd12.prod.outlook.com (2603:10b6:208:39b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.23; Thu, 18 Jan
 2024 14:34:42 +0000
Received: from SN1PEPF0002529F.namprd05.prod.outlook.com
 (2603:10b6:510:4:cafe::df) by PH0PR07CA0108.outlook.office365.com
 (2603:10b6:510:4::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.24 via Frontend
 Transport; Thu, 18 Jan 2024 14:34:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SN1PEPF0002529F.mail.protection.outlook.com (10.167.242.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7202.16 via Frontend Transport; Thu, 18 Jan 2024 14:34:42 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 18 Jan
 2024 08:34:40 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 18 Jan
 2024 08:34:38 -0600
Received: from roman-vdev.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.34 via Frontend
 Transport; Thu, 18 Jan 2024 08:34:32 -0600
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 00/12] DC Patches January 18, 2024
Date: Thu, 18 Jan 2024 09:33:48 -0500
Message-ID: <20240118143400.1001088-1-Roman.Li@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002529F:EE_|BL1PR12MB5972:EE_
X-MS-Office365-Filtering-Correlation-Id: ef2d4a08-2f4d-4f78-9ce4-08dc18329bca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DQZHp66sdM32aGw+8NngbSddFMLMeIXuT1ILDkVC0qFVd7ps3UBDKHb87oFlxvoQfxzScRcryminjFF5NLeCeO0va14O5L2VC+pIfZ8qF0VSXg6b38LRDkKLzNZcrWCc6tTJGlIisYzs7Y09G4PR9B3lk3+ViXWoQLu7zvbFJoGq1rKVQ2J9GnVXhH9iVHQJybnPSHt1aA3/YaemURtbTR9+kgASPbNywnIEwLFpGZpFuwuJQK9okIMN268LoLQapP3kp6i9lW6dwo1D+1PPyJLVlyHerjfSxrYRIC/as044RBXH52VmcsFzsUPCaOAnXGfWQLAAybeLsdQP92wJHc+UlM2Z3FTzWa6rIuF3wpnlMotMiJDSwR/QPuwu9U7/+zqXRtW/ljxmnXhbitOylyZbvbUNREY7KaHP9eDjx27UEonOdYTt6u1LYpklDeAOr/3g+L1fJX+Cx+QDQSEblZoPugoXRfIEM8XGirQVgenXVeYVdTfndAQFPCGiRoX6+41ynruHvaip1uqDYBsNhfuvjHc8rSiZQjvrlPPZtU2qXX+7ShID+mnHeYqQ8JibYCeE7NuYdv6Xnx7ngFKBjPkvfndBxelKGmdgrSVXzRx94DB4R+SeyCqkI98+5IADU1ZJw9wSN7B0bfzfRxYgvvVbriVgFQ9Szk5/2IXspisY3UJUzEEFp54/veUvFBMONEHlWMEMw/NevKYVz4swH1ZpO/gekj2HyQCvHGcD3EFNQOzNxbmQOmUzndeRUTGuz4qUd2bnbhuz6Isz5DotGQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(376002)(39860400002)(136003)(396003)(230922051799003)(186009)(1800799012)(82310400011)(451199024)(64100799003)(36840700001)(40470700004)(46966006)(5660300002)(4326008)(40480700001)(40460700003)(54906003)(2876002)(2906002)(8936002)(8676002)(356005)(316002)(1076003)(81166007)(83380400001)(26005)(86362001)(7696005)(70206006)(6666004)(70586007)(6916009)(36756003)(478600001)(82740400003)(336012)(41300700001)(426003)(2616005)(36860700001)(47076005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2024 14:34:42.0321 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ef2d4a08-2f4d-4f78-9ce4-08dc18329bca
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002529F.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5972
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
Cc: chiahsuan.chung@amd.com, Sunpeng.Li@amd.com, Rodrigo.Siqueira@amd.com,
 Roman Li <Roman.Li@amd.com>, jerry.zuo@amd.com, Aurabindo.Pillai@amd.com,
 hersenxs.wu@amd.com, wayne.lin@amd.com, Harry.Wentland@amd.com,
 agustin.gutierrez@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Roman Li <Roman.Li@amd.com>

This DC patchset brings improvements in multiple areas. In summary, we highlight:

* Add power_state/pme_pending flag/usb4_bw_alloc_support flags
* Add GART memory support
* Improvements for HDMI, IPS, DML2 and others

Allen Pan (1):
  drm/amd/display: Add NULL-checks in dml2 assigned pipe search

Anthony Koo (1):
  drm/amd/display: [FW Promotion] Release 0.0.201.0

Aric Cyr (2):
  drm/amd/display: Promote DAL to 3.2.268
  drm/amd/display: Promote DAL to 3.2.269

Charlene Liu (1):
  drm/amd/display: Revert "Rework DC Z10 restore"

ChunTao Tso (1):
  drm/amd/display: Replay + IPS + ABM in Full Screen VPB

Fudongwang (1):
  drm/amd/display: Add GART memory support for dmcub

Leo (Hanghong) Ma (1):
  drm/amd/display: Fix timing bandwidth calculation for HDMI

Muhammad Ahmed (1):
  drm/amd/display: add power_state and pme_pending flag

Peichen Huang (1):
  drm/amd/display: Add usb4_bw_alloc_support flag

Roman Li (1):
  drm/amd/display: Add IPS checks before dcn register access

Wenjing Liu (1):
  drm/amd/display: turn off windowed Mpo ODM feature for dcn321

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  29 +++--
 drivers/gpu/drm/amd/display/dc/core/dc.c      |  11 +-
 .../gpu/drm/amd/display/dc/core/dc_stream.c   |   9 +-
 drivers/gpu/drm/amd/display/dc/dc.h           |   4 +-
 drivers/gpu/drm/amd/display/dc/dc_hw_types.h  |   1 +
 drivers/gpu/drm/amd/display/dc/dc_types.h     |   5 +
 .../display/dc/dml2/dml2_dc_resource_mgmt.c   |  19 ++--
 drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c   |   5 +
 .../amd/display/dc/hwss/dcn35/dcn35_hwseq.c   |   2 +
 .../amd/display/dc/inc/hw/clk_mgr_internal.h  |   1 +
 .../drm/amd/display/dc/link/link_detection.c  |  18 +++
 .../gpu/drm/amd/display/dc/link/link_dpms.c   |  58 ++++++++++
 .../dc/resource/dcn321/dcn321_resource.c      |   1 +
 drivers/gpu/drm/amd/display/dmub/dmub_srv.h   |  19 +++-
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   |  59 ++++++++--
 .../gpu/drm/amd/display/dmub/src/dmub_srv.c   | 106 ++++++++----------
 .../amd/display/modules/power/power_helpers.c |   5 +
 .../amd/display/modules/power/power_helpers.h |   1 +
 18 files changed, 244 insertions(+), 109 deletions(-)

-- 
2.34.1

