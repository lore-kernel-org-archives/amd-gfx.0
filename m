Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2FC8C46CD2
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Jan 2024 21:28:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 68EBC10E7AE;
	Mon, 22 Jan 2024 21:28:14 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2088.outbound.protection.outlook.com [40.107.212.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DFE5B10E7AE
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Jan 2024 21:28:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dv2PHTttRgKcDNaRR0lrCV/PaTPkOjnfLf//Mm7XyhkYOyRJIVgBx2cvPXhun4sETDdBD7oFPjf64HBjuGk+zGBRBqB4ufKTz/6O69qVGrkLnJOT03dnAo5Tvv8ZeKXniy2QxklkehZEAUVq7/toWFNCM+L4KwMT/DuKZWUl54Mc+lfuVEsrbDUeFm7txOU77HjlQgzR5RMxUAORP1NuBWfUdAbrO6I8BFA26iWdbYXWsHUjZ8gpnChi/uWc36Whhw9aseKd8LnP3mDVjEnEDP+ygcx2hV5WxX3MBKD2SsJlMLL0c58cdqvE15lC4mWeoZ6LI3Lo64bHGO3iP1A2KA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SsUfgtcTqL7EZclsjmPwe9G6CZ18vKHFPSaR7LINxAU=;
 b=MXimnB0MmM6BpvZI1Xi73mMv/y3SnsdInk0P/nCiXvvJidNLFwtR2JDip/38M2tx2K1g/6STmmpptWpCUseWXdg3dm+EdjBcQmpKAElhxYf1lg6sXi0W8X5DhsmOSjCZpmDs2DQCXrO0dO2OmVfXsMpfv1tt1TzJ65FDmebhh7Tybm3cSg2hcDfozGs05b9Kwr3ZmeP621v55LwUrINLrhhhWyzHKIZr4qr7QmAbdoCZfi7Q1MJKbA0R5/v7Pc1/MZISA8/dM4Il+MaP4f69WAlapzSID6NVqfcR87uGSM+U9oQ7y/FywZVJrPEj/ozq7C2MAPuml3tHBLxrwMVxFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SsUfgtcTqL7EZclsjmPwe9G6CZ18vKHFPSaR7LINxAU=;
 b=RdE3IoFPx+1WnTrJHEZMo4CDvXglXim+PQQEdFFoHEasRm2kVbwsowUeCWf+0kpwlEnrsZkP720lRBsdg7JzW0wX7QNTMvX3pRkPSvP4BWG20K/YKhee/tv0ACROtUxDeAdBq7qIYqC4XOj73YNExh9yI217tYUXU3yfa/aSrn4=
Received: from BL1PR13CA0191.namprd13.prod.outlook.com (2603:10b6:208:2be::16)
 by DM6PR12MB4531.namprd12.prod.outlook.com (2603:10b6:5:2a4::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.23; Mon, 22 Jan
 2024 21:28:09 +0000
Received: from BL6PEPF0001AB4D.namprd04.prod.outlook.com
 (2603:10b6:208:2be:cafe::f3) by BL1PR13CA0191.outlook.office365.com
 (2603:10b6:208:2be::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.16 via Frontend
 Transport; Mon, 22 Jan 2024 21:28:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB4D.mail.protection.outlook.com (10.167.242.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7202.16 via Frontend Transport; Mon, 22 Jan 2024 21:28:08 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Mon, 22 Jan
 2024 15:28:06 -0600
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Mario
 Limonciello" <mario.limonciello@amd.com>, Harry Wentland
 <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, Hamza Mahfooz
 <hamza.mahfooz@amd.com>, Aurabindo Pillai <aurabindo.pillai@amd.com>, "Jani
 Nikula" <jani.nikula@linux.intel.com>
Subject: [PATCH v2 0/8] Expand and improve AMDGPU documentation
Date: Mon, 22 Jan 2024 14:24:53 -0700
Message-ID: <20240122212719.647008-1-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4D:EE_|DM6PR12MB4531:EE_
X-MS-Office365-Filtering-Correlation-Id: 7103f116-8506-4425-47ef-08dc1b910770
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zgVNQ3pyVyPPP1/SpOuKUITLzaJC9WVndUuF9lwTkH/8gdf3N0xSh2baagcE2spcaCrBgemCkDqoi44x5NbVY446Bgtyn5r0qT2INRi/BzcVOn7IuKqGUwJQ/3Ixo6E39W5jE8mI4rUN4n0FA0bDpxUca/hhid6NTOqAKbKs5LeQAd/bY86uOMAFrofiNmVz4sMy+Bzu3AT20C1zMdKsXWTWqIoJPg/P/cFC3u9h3h4Lc5giuMScZi7Vuw4lwK4v4l1wIBu4IuTxrnq1AkpzG+aWvxhMnKZIn33xTmgr2c2FMZob7t/ibU7gkQ6sRY6wD0ov8vxAuVprHnGB4k/T8JqpAO29HJ/cYazRMmkt6JrIccpeXCGME5mW7nMHExEzD2p6GTBh3RSlkjctXFaCJ+jrvsNF5HfDbqgg8PjFKoHNbN/kjtftRT2dKoyfUAu1DDELWZXddoKvuVvB1F8zRzZ2qoZ6KWZCsUwtAr++Y4T2Ydck0Yr6hpA+4BVES7vABQ1vLR2PLRsg7mFssKfhrMLBI3tHe21xWX6fNt4pLCdCFmysACaYEmnXwvIq5y+7SyicRdfwpxzSDJkwEaeVm51vI0kSpK9Ko89QLNfq/h4CPF3tEwYaJRJ5NR9lny1txnemVe22aR7Sn8Gb8ko1KbUE/3/vhxPByWOlj5Btca1arpUZMxYe2WtMo168JcvRRGLY1CeddRKWmzF5nDmzDy53Imb2PW5JZiZf69jPtdwe9xmw6QpJWCZ+5OONL/vMCsshFdNU5wc+836oJGpSxQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(376002)(346002)(39860400002)(396003)(230922051799003)(1800799012)(82310400011)(451199024)(64100799003)(186009)(46966006)(40470700004)(36840700001)(5660300002)(8936002)(36756003)(8676002)(4326008)(2906002)(16526019)(316002)(1076003)(426003)(26005)(54906003)(356005)(81166007)(70586007)(86362001)(336012)(110136005)(70206006)(2616005)(40480700001)(40460700003)(6666004)(478600001)(41300700001)(47076005)(36860700001)(83380400001)(82740400003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2024 21:28:08.8305 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7103f116-8506-4425-47ef-08dc1b910770
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB4D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4531
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
Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, amd-gfx@lists.freedesktop.org,
 linux-doc@vger.kernel.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This patchset improves how the AMDGPU display documentation is
organized, expands the kernel-doc to extract information from the
source, and adds more context about DC workflow. Finally, at the end of
this series, we also introduce a contribution section for those
interested in contributing to the display code.

Changes since V1:
- Remove unprecise information about the DC process.
- Expand the contribution list.
- Rebase.

Thanks
Siqueira

Rodrigo Siqueira (8):
  Documentation/gpu: Add basic page for HUBP
  Documentation/gpu: Add simple doc page for DCHUBBUB
  Documentation/gpu: Add kernel doc entry for DPP
  Documentation/gpu: Add kernel doc entry for MPC
  Documentation/gpu: Add entry for OPP in the kernel doc
  Documentation/gpu: Add entry for the DIO component
  Documentation/gpu: Add an explanation about the DC weekly patches
  Documentation/gpu: Introduce a simple contribution list for display
    code

 .../gpu/amdgpu/display/dcn-blocks.rst         |  78 ++++++
 .../amdgpu/display/display-contributing.rst   | 168 ++++++++++++
 .../gpu/amdgpu/display/display-manager.rst    |   3 -
 Documentation/gpu/amdgpu/display/index.rst    |  78 +++++-
 drivers/gpu/drm/amd/display/TODO              | 110 --------
 .../gpu/drm/amd/display/dc/inc/hw/dchubbub.h  |   6 +
 drivers/gpu/drm/amd/display/dc/inc/hw/dpp.h   |  26 ++
 drivers/gpu/drm/amd/display/dc/inc/hw/hubp.h  |  13 +-
 drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h   | 250 ++++++++++++------
 drivers/gpu/drm/amd/display/dc/inc/hw/opp.h   |  16 ++
 .../amd/display/dc/link/hwss/link_hwss_dio.h  |  10 +
 11 files changed, 560 insertions(+), 198 deletions(-)
 create mode 100644 Documentation/gpu/amdgpu/display/dcn-blocks.rst
 create mode 100644 Documentation/gpu/amdgpu/display/display-contributing.rst
 delete mode 100644 drivers/gpu/drm/amd/display/TODO

-- 
2.43.0

