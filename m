Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0120CC4828D
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Feb 2024 20:13:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 84333112DD9;
	Tue,  6 Feb 2024 20:13:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3b1zqRGl";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2073.outbound.protection.outlook.com [40.107.92.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E7FA3112DD9
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 Feb 2024 20:13:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BTuRw00veFpsLzIi15l74dxO8bY0ybd8gRIn/AjZHPqxRaeBG9XnkL21GjOKDhy2/NRQZSUwgU27dls5k+EYiP8dhGmL9Ki9LXRRuhrLXiE0CLUQkSfkMkCSZigmtV2padFdv/4EE9P4iCtK8nc1kMY0DvJYryhAO2GQm3QbPF6oYziQ5GpEt6ahs/aQbnJPVU/NcqtKi65/KFZ//QSCXA9QHq56zZOTUDmjz3J4S6gMo1ENuKsxPqzbB1G3Rrplb8rvXNthIRoTmA1NkpZ6UlNecEHKl9naeYYt5Q60b88lbfuKeaDm6A5JLMMuOTMD4b3pHAHoIsf5e7MR1XWXEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6eGASfhwYxVnswAmEd2VVjs2PkIN7JnAwRJ3vU01Ycc=;
 b=Zue/qzpAqn5aQJOPQaLxI7IMjU+M23X7HplKyhjeJavJy7nAyZlMp3YjrteJpcqw5D8eBUO12wNYThMwhWKraXzqjkETIdlTgL0WPRyno8AsDdQCNTdMTvZK45d0l1r0wXM3HgD/TI1JDLntczK+kTVpsxtxJ0gS97Zo+PRXaRdkRZW3Qe9ihC9efk0snzo7bYHh/wF36XLPMhCk0+2LiUY0IQcFbhlWgCsc0lMm1xDuGXhyIlfZ2vUCAB6VUTMmo/ZreGHMIMl5SOd2ZdA/X4a2LfTAVrJtIUbExNCDpoJGP8JtMzo3in+wtNVaHCuIqDQS0GC5BdtPNwYxqgs44Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6eGASfhwYxVnswAmEd2VVjs2PkIN7JnAwRJ3vU01Ycc=;
 b=3b1zqRGlbKloojCOR3vSuHmReaEv7wtNz2nN8D4tcweFTGyc0PqdTLEX3ZxdGQS68opyCzBStDTLC3AiLBGlWREFlIshn4FRA3joc/okiNQgiWVV3LV/otXTa02sXi6iyJHuqqrJs6Ejh7xau+Pzt1qC7QgpWqRcz5I/6iyyfno=
Received: from BN0PR02CA0025.namprd02.prod.outlook.com (2603:10b6:408:e4::30)
 by IA1PR12MB7565.namprd12.prod.outlook.com (2603:10b6:208:42f::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.17; Tue, 6 Feb
 2024 20:13:08 +0000
Received: from BN3PEPF0000B075.namprd04.prod.outlook.com
 (2603:10b6:408:e4:cafe::b5) by BN0PR02CA0025.outlook.office365.com
 (2603:10b6:408:e4::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.36 via Frontend
 Transport; Tue, 6 Feb 2024 20:13:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B075.mail.protection.outlook.com (10.167.243.120) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7249.19 via Frontend Transport; Tue, 6 Feb 2024 20:13:08 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Tue, 6 Feb
 2024 14:13:07 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 0/2] Add ATHUB 4.1 support
Date: Tue, 6 Feb 2024 15:12:50 -0500
Message-ID: <20240206201251.1670941-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B075:EE_|IA1PR12MB7565:EE_
X-MS-Office365-Filtering-Correlation-Id: 16225523-af5f-4c5e-6177-08dc27500905
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UYNzAtZacP3x58jU/zRVAqIruYuRjbKFGTeWIzS9bElqtPLDUWbw3wXehJCZgk3pzIYFSmUHITqYtu2xsupI0x6tkWh2AyEBnbFUPOS6/VJPLjj4duIMJ9wAh4MASjp+mE5R4D+vhrsbrt6bZcf87P4a8iAGptOb4fanRfeRn2V26+JDCBP92SP8PxcU5YA1qC39z1hibDt6dGHmXOqwdbEOICINDkg140ytGAT2bT0L495U52JU6aqATS3nWhp/415gw2uogYRksmk4FrGU8+TKOZu0YItddluHdk+fqJ8rLF3emMYpwK5qGprp811m9AWevLHOE8PbspmeC6sR68YKlIKbVfED1BoYuBUXrjOt0Vzbsdd2WoxHnSOuVhm1jPCiimMnQPJBDtcZLoaivP+LpCc41+Gy0jIjIGeFf1Q3lXQCyw92hxUkmVSllntPcnwBTCoiJWcTZhblkuKZJkDXpO3ZViEISmWqUiLGS9bOfFiKLE6jzFPF1M6fHimntxRF6EP/oE5cdrZN3AZoK7uHUs1xm9DEuU2uBUf9KtRoXr2KflqJIowQSTQ36cUxyC9EyzFqhGpm9FSmMo0zy+/G6NsMuMQ5mZRBMNwhg8oB7ntE1vmgfNf/nm2P66NSWSDbFIQRL7f7ht90Ap4wmDmECIaU6cGfn+ZQis+YlNM4QV87S+fHI8ZKlFRHNnd208VxUolCZmvXbPOGkc/BrQfyceicmegReBZ7ZmRWUdUktuNxfzLmJ30g/nYZeuYLq8wMwZId/la5bem0tpPHtw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(39860400002)(376002)(136003)(346002)(230922051799003)(82310400011)(64100799003)(186009)(1800799012)(451199024)(46966006)(40470700004)(36840700001)(7696005)(6666004)(2616005)(26005)(336012)(47076005)(426003)(16526019)(1076003)(36860700001)(4744005)(70206006)(478600001)(2906002)(5660300002)(83380400001)(70586007)(8936002)(8676002)(316002)(6916009)(4326008)(356005)(81166007)(82740400003)(86362001)(36756003)(40480700001)(40460700003)(41300700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2024 20:13:08.1669 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 16225523-af5f-4c5e-6177-08dc27500905
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B075.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7565
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

This adds support for ATHUB 4.1.x.  The driver's
interaction with this hardware is largely limited
to enabling clockgating features.

The first just adds the register headers and is
large, so I've omitted it.

Hawking Zhang (2):
  drm/amdgpu: Add athub v4_1_0 ip headers (v5)
  drm/amdgpu: Add athub v4_1_0 ip block support

 drivers/gpu/drm/amd/amdgpu/Makefile           |    3 +-
 drivers/gpu/drm/amd/amdgpu/athub_v4_1_0.c     |  121 ++
 drivers/gpu/drm/amd/amdgpu/athub_v4_1_0.h     |   30 +
 .../asic_reg/athub/athub_4_1_0_offset.h       |  287 ++++
 .../asic_reg/athub/athub_4_1_0_sh_mask.h      | 1348 +++++++++++++++++
 5 files changed, 1788 insertions(+), 1 deletion(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/athub_v4_1_0.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/athub_v4_1_0.h
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/athub/athub_4_1_0_offset.h
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/athub/athub_4_1_0_sh_mask.h

-- 
2.42.0

