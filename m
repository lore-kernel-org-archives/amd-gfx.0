Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F150EC46CD2
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Jan 2024 03:44:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ABAE610E10C;
	Tue,  2 Jan 2024 03:44:56 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 98C2510E10C
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Jan 2024 03:44:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QNBcqDVawRP7xHuT1mJ41AZePsXIRex2bZY7fvw5z+cRGyH1lWFJ2xcS+k/OrbLQw5wcesmBbRwEGiRFAAv/eQL5EiUzW40cBnckgCli8tspUv/f2BEOt5vwn4MzqZwK130CWVZa2LODykx/EMRJ61BkJsVqvv/Z7aBsETd8kLyOyGBkkif2E6XZSsd/VRLJlRDGZN6lcxx1EgxExQYT28VyZW/O2XxL0PCP5AExxVfKgw7ieaOTvb8ojTRVFUgRY/qz0hhYfbfT24a/QMf2VJmTmX4DUcJ9jubsFUwg7Zyl4zZHu3wg1OTfW7D7jzUvON1lS1Ut9K7sYhxm2i37MQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pNCTDJkzSCBgYrDDJU+GQ8NIkpUve+xZpcj8YE7inGk=;
 b=CUm1VQznd2rEn1x1P/fS1odsBsPB1G5A4g6uv/zFTZLcq0QDRALpVnzIhjN7RJIJAqG4Zd1agcB2XuyU+jbLxfae12Pjo3CMSoSUYsifXmnFKeG0ko2zfyWRVDAqtwX/seZCtV+k6XaGxr3sCphPdmTxmvTV1m+EUFvfb6LeeP3OvNQKXufDsNy2MCkyorw5pNSwjdpEYfJqGyPQwYG2iO0GInsM/QZzr0mCuGrBI7f0BF535bIALUuWdQH/W618e8yLgfV8j0o/iP6NZg25pVEOZEd8cRsAaRt5acUTZ25DJbNGXSqA82cSZYNUVBFDHtWURid6qiVchjMlROXfig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pNCTDJkzSCBgYrDDJU+GQ8NIkpUve+xZpcj8YE7inGk=;
 b=VnczqPifYPQy88nW3lKrbwCB91TVjBNiiIQicaHcBsXh6GUEoskICQreRbDN/BkcWvXh8faTMxncHdVQiOl6A9YcZKNfvwVPXEfUPOoCdVgs+DwfyCwvD2Ma9T8hgxWNB8z0lFvM7jzchc0iMLmcZPgTSrez3q8EQpOXxBhmz2A=
Received: from SJ0PR05CA0060.namprd05.prod.outlook.com (2603:10b6:a03:33f::35)
 by CH2PR12MB5018.namprd12.prod.outlook.com (2603:10b6:610:6e::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.25; Tue, 2 Jan
 2024 03:44:51 +0000
Received: from SJ1PEPF00001CE1.namprd05.prod.outlook.com
 (2603:10b6:a03:33f:cafe::f) by SJ0PR05CA0060.outlook.office365.com
 (2603:10b6:a03:33f::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.12 via Frontend
 Transport; Tue, 2 Jan 2024 03:44:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CE1.mail.protection.outlook.com (10.167.242.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7159.9 via Frontend Transport; Tue, 2 Jan 2024 03:44:50 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Mon, 1 Jan
 2024 21:44:46 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Mon, 1 Jan
 2024 19:44:46 -0800
Received: from hawzhang-System-Product-Next-Generation.amd.com
 (10.180.168.240) by SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP
 Server id 15.1.2507.34 via Frontend Transport; Mon, 1 Jan 2024 21:44:44 -0600
From: Hawking Zhang <Hawking.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, Tao Zhou <tao.zhou1@amd.com>, "Stanley
 Yang" <Stanley.Yang@amd.com>, Yang Wang <kevinyang.wang@amd.com>, YiPeng Chai
 <YiPeng.Chai@amd.com>, Candice Li <Candice.Li@amd.com>
Subject: [PATCH 0/3] Add ras cap query from psp
Date: Tue, 2 Jan 2024 11:44:37 +0800
Message-ID: <20240102034440.16376-1-Hawking.Zhang@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE1:EE_|CH2PR12MB5018:EE_
X-MS-Office365-Filtering-Correlation-Id: 334b0ce3-8544-4283-416f-08dc0b452cb4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6Npsa/tXlgqQjH6fdBbm1ceg0SmCNgu+AeZN2vpTJK3slz0zvrnMV3ovVjgqNbjK+TV/P4mvjv12t5KATsj4h8AeIr0NuImNQyteZx5hlxNXsf+3KTdENItNR8+gUyu2OIiQemSzXpaQLaCKjbgcxDsXgB7SkvH97Dpdt/9s5HMVBx03Pxl4JFUPVehy3jnqaEps3b5JXSrp3qVfL4oWuHfarx6XLr0s9796OhYVzqRQ6OJ+k3FQl8iqn+FZW2k14RIYceTLlOE6pVD+bMixqA+gqXYyxGgf0q3ZXnY3oUwIYFfYyDEvjc3DPeJZhn57s8IMPAwZxwUGP/Z/SzDJipcNHhm5iYL+NVa5qJCoVRXfB4NOeXl2oJwgbRMVnULilL8Y0DOuAhn1alQZ2b6faWbexO/B60vRae6wQGqUhtdmyTyhrOFVNM6ctpceOeVxFKxL9XyBx6UQCwE3foY4FKpmi72u9FKyNOhPbcuc0FnmBltLKydddpBJl75aFx6KSWd00buyK/kCj/fxVJ+bp1zPX1XAMBYf1kImTZJQon0v1BQRD0rMcipIt76CCbkSu3BoDvzhKc03wXCbnrMpSGSOU1Re6+TYisv86v+tuVAsegOzOwp3jagOYbA+0ZSMUrIZxdt3ACuIWxwdCoPMRjKgus9oASHlIvil+LSGM+s/BQ3tY9Rr3Ys82yaW+SyJoOKqg8kaFYwz+fDX1MC6z5eLFHL9gO9hGVSLsJsIJa2OFzmmf4XHYt06IddC6BnVa2f8fQx5gMukFoIGT3i+9A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(376002)(136003)(396003)(346002)(230922051799003)(82310400011)(451199024)(186009)(1800799012)(64100799003)(46966006)(36840700001)(40470700004)(336012)(426003)(83380400001)(26005)(2616005)(1076003)(47076005)(36860700001)(8936002)(5660300002)(41300700001)(8676002)(4326008)(4744005)(2906002)(478600001)(6666004)(7696005)(316002)(54906003)(6636002)(70206006)(70586007)(110136005)(36756003)(82740400003)(356005)(81166007)(86362001)(40480700001)(40460700003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jan 2024 03:44:50.9177 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 334b0ce3-8544-4283-416f-08dc0b452cb4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CE1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB5018
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Le Ma <le.ma@amd.com>,
 Lijo Lazar <lijo.lazar@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Driver can query RAS capability through psp or bios.

Hawking Zhang (3):
  drm/amdgpu: Align ras block enum with firmware
  drm/amdgpu: Query ras capablity from psp
  drm/amdgpu: Centralize ras cap query to amdgpu_ras_check_supported

 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c |  13 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h |   2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 170 +++++++++++++-----------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h |   2 +
 drivers/gpu/drm/amd/amdgpu/psp_v13_0.c  |  26 ++++
 5 files changed, 136 insertions(+), 77 deletions(-)

-- 
2.17.1

