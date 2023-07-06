Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0796CEB64D9
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Jul 2023 18:19:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 70F9910E486;
	Thu,  6 Jul 2023 18:19:38 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2059.outbound.protection.outlook.com [40.107.223.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5355D10E486
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Jul 2023 18:19:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ri8nyC6799oEWbQ0r9KLnaTClNL0EHLxKygjQFE/dSTLPb4G2ilGXMRjA1iRma1mipRIihkCeBz1a++K7Y2K3A7N2gNHeh7EmoKdc6zXcg7fb8YStwPdHRK7xgkoxFphiVEPz/ybk7cE8bcbSSB2FHL2oKfm94hs3IKgq2qw1wX2AvkWXKuvf2drPY/RyJAKRyOCR09kqEOWBnG3EI/y8fP/IVtUwN7d3cVQB+rAsp5AtIFdoC7eqFaEEUWemulHotcuh7EO/xkvZiohEQXzIJ0H3jZSv1IWfCG0rtUwRqtcGzyCwq/fxt65Qsuk3syXCiJa8bPJbbXT19z/fjpQRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ADIce1hA8MJQIyEwzT0tx2XqO7THZUfHYGcYWXBItdY=;
 b=hgXY6oSu7rXBrRaoAQbOl+aDpkgr3+yOz4GXCaNvv67vopSgXo01iGjFpBtCHcDGDjDT1nr9y4fJHjTDqrjQJl6RxYhn4AY/s09tV1Sx4oixslId/VFSWLQnMuEIuR06d8PLoTS427mh1RejS3TW+JXnJdBPf+hmeFab3XzqIHUPxec/CvxhgtCxsh7zCUnOrrposgbnCywti24rV4lsL1FMbcal7LeE3e9uyYhdxmOsJfnzpZV5dUqtJSYPAdhhdcEXHUDoJK4nZkiQEVk1vUribZezmX3iMajkQRWIT9h9rXIM5insl610WOWhlNt6be55emGDfAZ0BKpPFr/0nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ADIce1hA8MJQIyEwzT0tx2XqO7THZUfHYGcYWXBItdY=;
 b=Oh3uDxM3F3lhuBOVgv2kuLQaruLBmHr19iE1gvFxG70mY91FxeWrAc3cG7KDh6OfMoJISFTLhfaQmgT6VNAcnc1Df0/DAYG+hujHcruDeCHT3v8voRVxJgvxfxoF+xrceHnasBSUQBo9If59t2yT1429dBXjUhQbQ1iCu41WNsk=
Received: from MW4PR04CA0053.namprd04.prod.outlook.com (2603:10b6:303:6a::28)
 by CH3PR12MB8235.namprd12.prod.outlook.com (2603:10b6:610:120::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.25; Thu, 6 Jul
 2023 18:19:34 +0000
Received: from CO1NAM11FT049.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:6a:cafe::cc) by MW4PR04CA0053.outlook.office365.com
 (2603:10b6:303:6a::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.18 via Frontend
 Transport; Thu, 6 Jul 2023 18:19:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT049.mail.protection.outlook.com (10.13.175.50) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6521.45 via Frontend Transport; Thu, 6 Jul 2023 18:19:34 +0000
Received: from eric-hp-elitebook-845-g7.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 6 Jul 2023 13:19:32 -0500
From: Eric Huang <jinhuieric.huang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 0/6] Upstream debugger feature for GFX v9.4.3
Date: Thu, 6 Jul 2023 14:19:12 -0400
Message-ID: <20230706181918.189722-1-jinhuieric.huang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT049:EE_|CH3PR12MB8235:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e746d54-a3ae-41ad-2c7f-08db7e4d8cd0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wdhrWfW2EAiu6kqCHqnVTqNmFuMmIc7aWFStVGkGVGY7j2d+Sw4IAWa70YSaggTS3GI6oUEY8UZXjYuGvXCFK+QVp3akUfpaha66yllbVRMJKdjPou0ZQaNuEiPGU2A5WNFv16G3P2TYa+7q8ctKLueBqg9baufmRolxQ0QQegokvW+OYmFts89nOwu8ezXQmtqbTHUGV7oNcwVb7+d1h04+ucCinarVEQf/DhAgnWo3RMGHKNab7RhWQClM5ICZ8MYvUeZXqsdTNZVJIotGoCw2KiYqr0sOZlD97FZ6ru8cMWpjWAxKznlkEAvrcl8C4Mku8ix5HYYTa9S4JT1saye/bfjFSvOijoGBTDM0JOzYvi2NxHq7+ZvZ0bSO5LntM5ZEl/p3d0863XC5YKUQdNiUnkT18mIluDSBpXocIKsEyeC2wsEUbEs+LLoRsieoDhC1uwoOud1X5dTqPbhqY9R4riPgmSpUai29d504r0Oyz1MI3YBBMII+QJhKDEGTwoUxMUDjErbB0zw7W/A4H8IEVWBwcaW2uU4UUp1pTgdUx6nKKGXyl0u++gPMJKL/zqUkDQRgJg/nzNJJtvPfbIjjeGrZpPdmmPfXTYuLYc0uxIuNasUaTl5G6Rmdbf3rISt03Fn3LyM8RNRvTKL+jponODypqsZpH27BZ5vUl6HvgE/EbcZlFj5QZpK08K4DDWhhWVoz1OaygTBhWwajhbq9KGphxYdAzq0PU4fFHAuUfo8tBGL6o0eBTCLPhRJQnoYwEq783HgXymGqeTsefQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(136003)(39860400002)(346002)(376002)(451199021)(36840700001)(46966006)(40470700004)(6916009)(41300700001)(4326008)(316002)(86362001)(54906003)(478600001)(5660300002)(7696005)(2906002)(82310400005)(8676002)(8936002)(70586007)(70206006)(6666004)(426003)(1076003)(16526019)(186003)(40460700003)(26005)(47076005)(82740400003)(81166007)(356005)(2616005)(336012)(83380400001)(40480700001)(36860700001)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2023 18:19:34.1529 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e746d54-a3ae-41ad-2c7f-08db7e4d8cd0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT049.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8235
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
Cc: Eric Huang <jinhuieric.huang@amd.com>, Jonathan.Kim@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Eric Huang (2):
  drm/amdkfd: enable grace period for xcc instance
  drm/amdkfd: always keep trap enabled for GC v9.4.3

Jonathan Kim (4):
  drm/amdkfd: add kfd2kgd debugger callbacks for GC v9.4.3
  drm/amdkfd: restore debugger additional info for gfx v9_4_3
  drm/amdkfd: enable watch points globally for gfx943
  drm/amdkfd: add multi-process debugging support for GC v9.4.3

 .../drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c  |  10 +-
 .../drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.h  |  30 ++++
 .../drm/amd/amdgpu/amdgpu_amdkfd_gc_9_4_3.c   | 152 +++++++++++++++++-
 .../drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c    |   9 +-
 .../drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.h    |  10 +-
 .../drm/amd/amdgpu/amdgpu_amdkfd_gfx_v11.c    |   3 +-
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c |  15 +-
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h |  10 +-
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c      |   2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_debug.c        |  12 +-
 drivers/gpu/drm/amd/amdkfd/kfd_debug.h        |   5 +-
 .../drm/amd/amdkfd/kfd_device_queue_manager.c |   9 +-
 .../drm/amd/amdkfd/kfd_device_queue_manager.h |   2 +-
 .../gpu/drm/amd/amdkfd/kfd_packet_manager.c   |  32 ++--
 .../drm/amd/amdkfd/kfd_packet_manager_v9.c    |  10 +-
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |   2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_process.c      |   6 +-
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c     |  10 +-
 drivers/gpu/drm/amd/amdkfd/kfd_topology.h     |   3 +
 .../gpu/drm/amd/include/kgd_kfd_interface.h   |   9 +-
 20 files changed, 284 insertions(+), 57 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.h

-- 
2.34.1

