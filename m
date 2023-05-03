Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CBB8C77B78
	for <amd-gfx@archiver.kernel.org>; Wed,  3 May 2023 01:39:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B9CD810E181;
	Wed,  3 May 2023 01:39:36 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eae::601])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6A34610E181
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 May 2023 01:39:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IW+zEN9IJFNrqDj4Xdwc8R0E9L/BJ7asBBScipXnkRGu0dCabJBu0j/vBLxQuPFPeXcgRotEs+YbVGLAxmAGM9jW/VhSsDt+8uRF2CZTOjw26gbtfC/fpjmp08ZeOahoNylyFLdgF6fsIpOw6qt1GAUUmgFfeQfSKikcb5OSGV1GMcS1FyBMVwc1WJSulfgWR9Zywb3vujKO27WF0l6nGUDmXc8lP2ILG8upN/g3mPKpOpdEqjMrEnvOcPZ8qXVMs96U9hNfpv7j1uVax5IsTzrQpkv5jQzYCa7UVFXS0UuFIvf0aibZCifdokvctpIZawZsm22A4GNC1sdGCZjkLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+Rraubp/IHUSFQID6N/iCMA8VwfzPMi85oddZFO8/Mo=;
 b=Wef1kIcJcujKQvOGnAOIW5+30RwkAYXUftnADxbiyUcZsGrnTfWpAciNSD8/ZNntmno+SIp6L+frnorMetqxoV75+7AH+GHUCQTCnQ2/c+w7e+zqeP7RbTgRqV3/OiK7pr6HelBqN3VKNc/Vin9NfQjVCktvYl1/tuPr2goO459dpJowmsdWg+0awADepiL4sz8dg2DR1rrznafIMAe3TLz19MT89hq5zbGjtRVBwZdFAk9D+aELXFGXfOHYTub1YIqx18Hz9jqMyqo5uzSypMdzImOeEAC75l4pDLN+NgFAn+P7hLLBBRpizAA35YZs94E3s2DZ7FUWR1XxqnDg8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+Rraubp/IHUSFQID6N/iCMA8VwfzPMi85oddZFO8/Mo=;
 b=5loiBaAC0iKD0/yVdDv/lcZn60+51vJeaWCezY3mtOfyiCcydnC1tE3NopygV3WkbsVzeeC82Vrio5L4pf4ZSHtcY6pWX/sQVsG6iHXtTSoyuPEsi1tT95dbtS+d2FP91eIaQyKjyyoJu+z3jLc7+1j4s5HisXyO7YA9wLsZ7EI=
Received: from DM6PR02CA0166.namprd02.prod.outlook.com (2603:10b6:5:332::33)
 by MN6PR12MB8591.namprd12.prod.outlook.com (2603:10b6:208:471::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.30; Wed, 3 May
 2023 01:39:30 +0000
Received: from DM6NAM11FT093.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:332:cafe::a) by DM6PR02CA0166.outlook.office365.com
 (2603:10b6:5:332::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.20 via Frontend
 Transport; Wed, 3 May 2023 01:39:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT093.mail.protection.outlook.com (10.13.172.235) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6363.22 via Frontend Transport; Wed, 3 May 2023 01:39:30 +0000
Received: from dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 2 May
 2023 20:39:27 -0500
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 0/8] DC Patches May 02, 2023
Date: Tue, 2 May 2023 19:38:45 -0600
Message-ID: <20230503013853.2266793-1-alex.hung@amd.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT093:EE_|MN6PR12MB8591:EE_
X-MS-Office365-Filtering-Correlation-Id: 73203006-6574-45f4-3ed2-08db4b773d25
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9El87tZ+EFKjG26Kx+UNHTGILy9/E3h/VD8WYgAcoNxw+uFPs0kJrzEAKuqLT/Q2qSWrVQ2Ec/DvstDCIkzpf2YVvEcBRxPVsJR62x3fpZfvtAINyViBNXBMrCm5GszVcFWsVlVS7L6JuB1VOKKesbLpJh4/LGC6lOHpp9EAPxsV+7qj26T85F6PfCrz5n1c2zoDsHCa6WpDLeVoxF7qz5HdjcGnh7LVK8emES2uExpzGRz87vKKlGjlpN+WmkpXNjZR3qsvhvJv/KZEOmO7h35cVRyoRYwQdtKF0ypOFfS9BPIYt1qqtS3XwkBuyMeX38oxGN4lJ/XR29f1B4jgzf3/pjgAPhyFbWu4YF7Y1/ZHBDaRe9PwYqwfqvoZDDw/H0CvqjecCCXlMXBb9R8GTVlG+uWvHMAX1T9lp/IFkzi7BLFMK7QgukibU4BUJUtc4cbrK6VUmeGtrtLW0Wj+UO12bjgQ0G07cOM8g/4PE3l/Vu/0Y6ExxwnAr26IZUpklwt3/nBoi3azYFhzRQRaSTalKwew84U7YyJTdxcIkDPOVOMtFqgSKnN92w5g4JurCdF/6WQBEA3QjgInAKN5STGinw4Bk5W2PFr6cryIGfE86jM9V2IDgpg0U7WufMIYRWbKQwapo5ShHUj8WuMTT/kgmzWbiCiXuydsqQTG5rej27jGcVM76OsLBlpFHARCgDUoY+Nb8IDRDjtOac3l+ZO3Q+xuC47lkQ4P/+HO/kA=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(136003)(376002)(346002)(39860400002)(451199021)(36840700001)(46966006)(40470700004)(70206006)(6916009)(70586007)(36756003)(316002)(4326008)(54906003)(7696005)(478600001)(6666004)(356005)(82310400005)(41300700001)(40480700001)(44832011)(2906002)(8676002)(8936002)(5660300002)(82740400003)(81166007)(86362001)(426003)(36860700001)(1076003)(16526019)(40460700003)(186003)(336012)(2616005)(26005)(47076005)(83380400001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2023 01:39:30.1318 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 73203006-6574-45f4-3ed2-08db4b773d25
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT093.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8591
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

* Block SubVP on displays that have pixclk > 1800Mhz
* Block SubVP high refresh when VRR active fixed
* Enforce 60us prefetch for 200Mhz DCFCLK modes
* Check Vactive for VRR active for FPO + Vactive
* Add symclk workaround during disable link output
* Show the DCN/DCE version in the log
* Add additional pstate registers to HW state query

Cc: Daniel Wheeler <daniel.wheeler@amd.com>

Alvin Lee (4):
  drm/amd/display: Check Vactive for VRR active for FPO + Vactive
  drm/amd/display: Enforce 60us prefetch for 200Mhz DCFCLK modes
  drm/amd/display: Block SubVP high refresh when VRR active fixed
  drm/amd/display: Block SubVP on displays that have pixclk > 1800Mhz

Aric Cyr (1):
  drm/amd/display: Promote DAL to 3.2.235

Leo Chen (1):
  drm/amd/display: Add symclk workaround during disable link output

Rodrigo Siqueira (1):
  drm/amd/display: Show the DCN/DCE version in the log

Sung Lee (1):
  drm/amd/display: Add additional pstate registers to HW state query

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  3 +-
 drivers/gpu/drm/amd/display/dc/core/dc.c      |  5 +-
 drivers/gpu/drm/amd/display/dc/dc.h           |  2 +-
 drivers/gpu/drm/amd/display/dc/dc_helper.c    | 56 ++++++++++++++++
 drivers/gpu/drm/amd/display/dc/dc_stream.h    |  2 +
 .../gpu/drm/amd/display/dc/dcn10/dcn10_hubp.h |  2 +
 .../drm/amd/display/dc/dcn20/dcn20_hubbub.c   |  6 ++
 .../gpu/drm/amd/display/dc/dcn30/dcn30_hubp.c |  6 ++
 .../drm/amd/display/dc/dcn314/dcn314_hwseq.c  | 65 +++++++++++++++++++
 .../drm/amd/display/dc/dcn314/dcn314_hwseq.h  |  2 +
 .../drm/amd/display/dc/dcn314/dcn314_init.c   |  2 +-
 .../drm/amd/display/dc/dcn32/dcn32_resource.h |  1 +
 drivers/gpu/drm/amd/display/dc/dm_services.h  |  2 +
 .../drm/amd/display/dc/dml/dcn32/dcn32_fpu.c  | 10 ++-
 .../dc/dml/dcn32/display_mode_vba_32.c        |  5 +-
 .../dc/dml/dcn32/display_mode_vba_32.h        |  1 +
 .../gpu/drm/amd/display/dc/inc/hw/dchubbub.h  |  2 +
 17 files changed, 164 insertions(+), 8 deletions(-)

-- 
2.40.0

