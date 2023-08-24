Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82AF7C27C40
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Aug 2023 21:31:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C989A10E140;
	Thu, 24 Aug 2023 21:31:48 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2062c.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eaa::62c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B19B910E140
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Aug 2023 21:31:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J554ijimy0nnmR2+ZSm5DQw4beAr7NdoRON1n5vyZxYbX+NPbSFDF29YRvgcB8SzU0IAESYYl5sS38tfEOMAptlD/aeCncPfYpROAUYZyl9L+l14p6pN1/iJKh7X+ocHiW53/kfmYXQqRkKZ1oaIHDeRUF9XwpRjsboeWorMCzrYQ23sZlFwOEMtoWIfKWEtB56rDqJauHwjjeWmNCMtuX7iMxDivVsoYdU8txeVS1QIodN82sUCKfKdZEVy8CPa68YVVggatIXm+VOJvW9JqrF4xFZ2OFw+fgueKe4wEUr7ek7/RNZXPDG+b7178smakb4FUogkDimAdd3xSONDNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E9ds/cOS4jYFe+ThuBaebm22wLXnESXRuTeFYlTxlrY=;
 b=HyZ/3yzDgKrPYirs6I8pHfUFmUaAkwsjnH1MPSaAT0mtLS32n5iWlr8Wtu3TjlpD8khBBxykWcuA9PSR8mJnZqh2XV9VPU/tyiS/sEQCnFiodOKU/vDcSIQaYiKb1EcUoS8CwXIlocPuAR0SQPQRmGoD212z31/rwXZ7Rae9ireVz2ltWlsEEWwGzSI+AVZENHaweTprw4o7efkehedMKTGhcJtKBDFBDzUbYAx57LlLLwQl2L7TkGMjAq18QoIV43pu70Yswm9rf7KTti6R2O+D7mXkYBGPUXRGFMDPjr26WjwyLn7d96htWQtfHDwbn5+7ZwJhE3o+Ss1zH+xhTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E9ds/cOS4jYFe+ThuBaebm22wLXnESXRuTeFYlTxlrY=;
 b=edUpwltvdNBn6pR107pYJkus09kZcFrhIr+Df9X5ZCLc/4QT0zYEbWQn0Zpw+1u9fMFDs/lvqjcLjcDMwTiarBXPs/xcNkrXE2GczThcT79kR6xJii4jHg+9SBc4/ITqJsA77uP6iuUgPSRSiS391MaRYajG1KcJ50mGUyIMQao=
Received: from SJ0P220CA0005.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:41b::12)
 by DM4PR12MB5231.namprd12.prod.outlook.com (2603:10b6:5:39b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.27; Thu, 24 Aug
 2023 21:31:44 +0000
Received: from MWH0EPF000989EA.namprd02.prod.outlook.com
 (2603:10b6:a03:41b:cafe::b8) by SJ0P220CA0005.outlook.office365.com
 (2603:10b6:a03:41b::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.25 via Frontend
 Transport; Thu, 24 Aug 2023 21:31:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989EA.mail.protection.outlook.com (10.167.241.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.14 via Frontend Transport; Thu, 24 Aug 2023 21:31:43 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 24 Aug
 2023 16:31:42 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 00/21] Add VPE Support
Date: Thu, 24 Aug 2023 17:31:07 -0400
Message-ID: <20230824213127.2725850-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989EA:EE_|DM4PR12MB5231:EE_
X-MS-Office365-Filtering-Correlation-Id: 88649631-25c3-4e0a-ae1f-08dba4e982f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EtPdm9h6HyBKsoaY7ExwcZqPSKWyuBJvnX56AWzL1e2DuruChbKwyV5wQ/FZrXtQ/tw2GYl6ya9VS5+JcYVdL+zoLEFAylGNOlR/079IDh0/vOWofooAVN5MDzXaVg51iAlzvcQYYAv6+YUvfv7ltuB6dEJqxB/Gy2SXQ/+A7kWgU7x0DLS3NjxvBdyK4Y8AZ7zuxuH9eFzcNw9czg+Klj6xPWxVrfLMCkeSwn8yHX5KynwpgajWO0NHng1lJn0j20ALK3bd0rgg7+aHJX0IYv6worrDZPMhCO3O1vroVmdfqcYwBZGk/k5zqqCbukrU/wKbPlEFSt8TGx4t5qvuKIxjqONRppAJbkxBcYOo0CjKO37mN23P7iVH6f4xVN5MslI1IX7k7KkQ30OZnCEGN+zNdWFom4DS3wMz3NACjVQe1MIPHZcpyAQwB0QLp11d/ntS6hcq78w2t5PNSLtE1HxDvjCmbeo/UNueqzUtArLX60+JmBw4QkbvuEk2Vwzhmwz1Np908U/1EJnb0x327kFAiNxZRC0aAgfY2Xs6Ol9qY3OMdbKYzYd5F15cg4f2Zf+L3Uhfjed06duZi2hyuf+Jv9B8PAee8wmrRNfXx0Fr4aEuy/nDGEoMaSdpje6nPePVlD8lQPtSp5AAbp1xhQbBjxApbItme/7FN0xJzyMWrlAIawI1PNSRTSwp2Fk5Xj7S/SiiktDOwg+ywA3gON5pNsQGTegEwUfUuh7l2+8XyWkEY+HxoOIpF1BjoLqhTbeN8ftmp3JYIfHrXshdGQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(396003)(346002)(376002)(39860400002)(1800799009)(82310400011)(186009)(451199024)(40470700004)(46966006)(36840700001)(2616005)(40460700003)(4326008)(8676002)(8936002)(83380400001)(5660300002)(426003)(1076003)(336012)(36756003)(36860700001)(47076005)(40480700001)(16526019)(26005)(82740400003)(6666004)(81166007)(70206006)(70586007)(6916009)(316002)(478600001)(356005)(41300700001)(2906002)(86362001)(7696005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2023 21:31:43.2994 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 88649631-25c3-4e0a-ae1f-08dba4e982f3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989EA.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5231
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

VPE is a new general purpose copy engine.
It supports a variety of scaling and transform features.

Mesa code will be available shortly to utilize this.

The register header patch is too large for the mailing
list.

Huang Rui (4):
  drm/amdgpu: add VPE HW IP definition
  drm/amdgpu: add VPE RING TYPE definition
  drm/amdgpu: add VPE IP BLOCK definition
  drm/amdgpu: add VPE HW IP BLOCK definition

Lang Yu (17):
  drm/amdgpu: add VPE 6.1.0 header files
  drm/amdgpu: add VPE firmware header definition
  drm/amdgpu: add VPE firmware interface
  drm/amdgpu: add HWID for VPE
  drm/amdgpu: add IH CLIENT ID for VPE
  drm/amdgpu: add irq src id definitions for VPE
  drm/amdgpu: add doorbell index for VPE
  drm/amdgpu: add support for VPE firmware name decoding
  drm/amdgpu: add UCODE ID for VPE
  drm/amdgpu: add PSP FW TYPE for VPE
  drm/amdgpu: add nbio callback for VPE
  drm/amdgpu: add nbio 7.11 callback for VPE
  drm/amdgpu: add VPE 6.1.0 support
  drm/amdgpu: add PSP loading support for VPE
  drm/amdgpu: add user space CS support for VPE
  drm/amdgpu: enable VPE for VPE 6.1.0
  drm/amdgpu: add VPE FW version query support

 drivers/gpu/drm/amd/amdgpu/Makefile           |    6 +
 drivers/gpu/drm/amd/amdgpu/amdgpu.h           |    5 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c       |    1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c |   21 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h  |    7 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c    |    1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c       |   19 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.h      |    2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c       |    6 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h      |    2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c     |   15 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h     |   15 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c       |  638 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.h       |   86 +
 drivers/gpu/drm/amd/amdgpu/nbio_v7_11.c       |   24 +
 drivers/gpu/drm/amd/amdgpu/psp_gfx_if.h       |    2 +
 drivers/gpu/drm/amd/amdgpu/soc21.c            |    1 +
 drivers/gpu/drm/amd/amdgpu/vpe_6_1_fw_if.h    |  217 +
 drivers/gpu/drm/amd/amdgpu/vpe_v6_1.c         |  272 +
 drivers/gpu/drm/amd/amdgpu/vpe_v6_1.h         |   29 +
 drivers/gpu/drm/amd/include/amd_shared.h      |    1 +
 .../include/asic_reg/vpe/vpe_6_1_0_offset.h   | 1553 ++++++
 .../include/asic_reg/vpe/vpe_6_1_0_sh_mask.h  | 4393 +++++++++++++++++
 .../amd/include/ivsrcid/vpe/irqsrcs_vpe_6_1.h |   40 +
 drivers/gpu/drm/amd/include/soc15_hw_ip.h     |    1 +
 .../gpu/drm/amd/include/soc15_ih_clientid.h   |    2 +
 include/uapi/drm/amdgpu_drm.h                 |    5 +-
 27 files changed, 7361 insertions(+), 3 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.h
 create mode 100644 drivers/gpu/drm/amd/amdgpu/vpe_6_1_fw_if.h
 create mode 100644 drivers/gpu/drm/amd/amdgpu/vpe_v6_1.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/vpe_v6_1.h
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/vpe/vpe_6_1_0_offset.h
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/vpe/vpe_6_1_0_sh_mask.h
 create mode 100644 drivers/gpu/drm/amd/include/ivsrcid/vpe/irqsrcs_vpe_6_1.h

-- 
2.41.0

