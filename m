Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3748C433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 26 Apr 2022 18:53:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7144610E1D2;
	Tue, 26 Apr 2022 18:53:13 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2047.outbound.protection.outlook.com [40.107.96.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0746D10E4E6
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 Apr 2022 18:53:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h6zfA6TQ4L2Ha6mMYQ8lmebPG4j/5JVDqUHRxSZe0sjM6gnNmIz7h/eXV0aJFnshO7phdkec18UPdAEc5Xl7l1npj7Erd5GDUh3Ydj5OsJ8o0Uu0NPV6KSSq6zeMPEWJ4e9X62AcrqlYzDhK5mQWrWd/jozS3yr+GCaaipxIVv88nkkJnQlRIX3IIutUZ41/1NDfxvHNzKjwemAUAr1ZCe1NQfxPvGmynhlSdHTt/I8fNl8W/OhGLzW/SIll4Na7sFjZhI19vM+bcO/UD/SdaEq3coLV1pUzLYsHJtPFy6gK18M4rxPf6q2SJxFfkhNZO+VuYBp5ehQ27DK4D273ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KlyhkT69d16Wkzz96CTsE79CWaYpkiXWtoRSd1/g6/8=;
 b=RShk2ykDHr/zq27Eec+f0rafjzIQOdTBT/e5Te5dK4Me/dXmzndwbwF/KWV9fDsgbD0UlHj4VCpkT5SQDPMKAW1ooGDJa24JCRSzetKCSuu78Wk3I7CLNo5m4Q3vYdpNi6uxR8AhQpBsZ+f8IKfcUycXg/vJ4PAmZKX/lLAeomG2qHRH225UpYaLri8f01XqgQfVRH2O/BvXRpCEIRYL0oPQvoM8cAY1hA0x7UA+INp/8JSLmyjP0XcLT1+4deARE1k3EUA6ya4eJlvPaBaYcKxFhctzTS65ZLw/g3HNXZrsxGPrBqCaLTEsUqghI1FJc0m/B1nJ7M71mE7/hQyuYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KlyhkT69d16Wkzz96CTsE79CWaYpkiXWtoRSd1/g6/8=;
 b=NvS15/poJsTWkT5bomFCJOPXkLlf/YLS+AY2syjizlRKbKqjLlHQQYgXB4cXbHVMDsr+6HaQJb1pbUP+yxIw5LUenCNen3PgPNmD/54u3qtIVTaA/1muon3Qf3h2mpOxW9AANPRd1Ri7npTfiVVNoHGkM/Z/FpbqbvniuvV+GsE=
Received: from DM6PR03CA0063.namprd03.prod.outlook.com (2603:10b6:5:100::40)
 by DM5PR12MB1594.namprd12.prod.outlook.com (2603:10b6:4:e::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5186.14; Tue, 26 Apr 2022 18:53:10 +0000
Received: from DM6NAM11FT004.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:100:cafe::bc) by DM6PR03CA0063.outlook.office365.com
 (2603:10b6:5:100::40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14 via Frontend
 Transport; Tue, 26 Apr 2022 18:53:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT004.mail.protection.outlook.com (10.13.172.217) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5186.14 via Frontend Transport; Tue, 26 Apr 2022 18:53:09 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 26 Apr
 2022 13:53:08 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 0/5] Add new SoC21 infrastructure
Date: Tue, 26 Apr 2022 14:52:52 -0400
Message-ID: <20220426185255.3039590-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 91ebf063-459b-4976-932a-08da27b60242
X-MS-TrafficTypeDiagnostic: DM5PR12MB1594:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB15945C32B571511679539C7DF7FB9@DM5PR12MB1594.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: j81sOiP1+ILOnZRLYjv+fcXpONYBVszKT23412t+jNfALvpw8g35J9BbSAdGAYb2Mt+uYtiUwagzwrbVKyJCHOGuBmhr6M4OnjRicwDUzWrapAYgCj3E89YWyxTFec4iX5nRt6Xfa8/O+fXKWE0Pq16e4LQt4ZYL77IiGA1R4BRfjA6vcflwhHs6/Xr/2J6Hrtn1ikZ3yTdeXQwRYIKzBOoUIRfJmhAf6pL01r5RS22Cutb5Z7P9xs6W+dfz6V+Vy/ZOnaXVS/GPZ/L4UDq3bp+q8KFRIk2xymBqAYu9sK8nFiRYXiSIyey4G8UP9T/0fYdJtelf5L+dJzxNAs36BXwJQV/I0FSfZnjoigTVdAP19eiV/R9B9MjFbhJr/b6cEyKNudq7OFv2X30w3nHe3MWd4vmxuWEDrrC0P3q4XRAVHMtfNjpcbZw6sVMD+e6cv3feYjZwcTMnOlBaE/0P5ZL6nCnIbM+SlkO5MKZ8eYNFmEpk/Kq1uBzDo7oKx2v5kKEa0DvOCNOKpysl/c8HvPIlfu8MeGmp9OCX70/BJhDiI6+XfmRq8IS0MSpReV8SEYVZLre8pFT1jeniU8A6sg2L7H/iNnaj4T+xUSCXxwhd54Ik5BBHyuAu7Xf/RbMDE3PhMth8pC8oj7/xiITMIlrt0066WDOCMUirq7J3aICM7289oQVnkPfrz/uhNZC2vV5OZN1UijUggUbrvmNyTw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(36756003)(2616005)(8676002)(186003)(16526019)(47076005)(336012)(426003)(4326008)(81166007)(316002)(86362001)(1076003)(36860700001)(5660300002)(8936002)(26005)(40460700003)(82310400005)(83380400001)(70206006)(6916009)(508600001)(7696005)(6666004)(2906002)(356005)(70586007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2022 18:53:09.9451 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 91ebf063-459b-4976-932a-08da27b60242
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT004.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1594
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This adds GPU SoC infrastructure for asics which
use the soc21 design.  The first two patches are
register headers which are too big for the mailing
list so I have omitted them.

Hawking Zhang (3):
  drm/amdgpu: add mp v13_0_0 ip headers v7
  drm/amdgpu: add gc v11_0_0 ip headers v11
  drm/amdgpu: add nbio callback to query rom offset

Likun Gao (1):
  drm/amdgpu: add new write field for soc21

Stanley.Yang (1):
  drm/amdgpu: add soc21 common ip block v2

 drivers/gpu/drm/amd/amdgpu/Makefile           |     2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c      |    13 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.h      |     1 +
 drivers/gpu/drm/amd/amdgpu/soc15_common.h     |     8 +
 drivers/gpu/drm/amd/amdgpu/soc21.c            |   620 +
 drivers/gpu/drm/amd/amdgpu/soc21.h            |    30 +
 .../include/asic_reg/gc/gc_11_0_0_default.h   |  6114 +++
 .../include/asic_reg/gc/gc_11_0_0_offset.h    | 11670 +++++
 .../include/asic_reg/gc/gc_11_0_0_sh_mask.h   | 41635 ++++++++++++++++
 .../include/asic_reg/mp/mp_13_0_0_offset.h    |   461 +
 .../include/asic_reg/mp/mp_13_0_0_sh_mask.h   |   682 +
 11 files changed, 61233 insertions(+), 3 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/soc21.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/soc21.h
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/gc/gc_11_0_0_default.h
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/gc/gc_11_0_0_offset.h
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/gc/gc_11_0_0_sh_mask.h
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/mp/mp_13_0_0_offset.h
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/mp/mp_13_0_0_sh_mask.h

-- 
2.35.1

