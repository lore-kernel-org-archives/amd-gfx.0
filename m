Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9A4BC54E76
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Nov 2023 02:10:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DCD7210E2F5;
	Fri, 17 Nov 2023 02:10:09 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2051.outbound.protection.outlook.com [40.107.94.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 340B910E2F5
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Nov 2023 02:10:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XZzZrPEXYcxUltTSNzB+1+cGWdGXbxrQSq5d8mlFMHoT+QKMAk8RLT+Z8cPiOBFASbOpV0ivC0NgCMVk1Oaun/B7XUgw5roRurbWFj2ZU5BhjHR3V3c4Jl+tyR0HH6WNvXUQBM7nExlElza3a+2KtLv+DbSE9UcIVslPoHpwW2jt+0RuYqgM9AWe9rWpfB0KcKxFnoGKvKE/0VBFd4sSPxS+u8k/eiA7f0iy5b2VKk1XBt1DDEUjFOHrI8qBPJ6tlhLfuKlzCz453WtxIbZHVRVEseZyydPeYIhlXV1w0MGyR2YgYgcblEd3/l4GMwTOh7pbcYs47pqTggfcFuDNJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lzU6g3tRPy5jYVftwIGBpX2h23Gy5xlz8arn07Cw3eI=;
 b=EFaFv9fE1GGQL/RIx2bI18BX4vKXCCSpUrndwblkw5UkxVhRCjfI9teHaKVwuY3p4QP1SBqNu4me26lXP2uf1zFvpPSR6RRU4chw55jqmPe/NAwOw0tg8590WUoEdBJssX3MnEooLoIbkOvjzG4FI1HNnHmZFbDFxx12o/8L1b4j83MNQ69vwrzskXc+nCEtzoRa8cxoJG5uQ4FvF1OM7xCXoX/BsBIl3bUW+hXROaITnUuHSvICVvjuoO73WCE4Hhs20tvtFCI4kiS7WTmR3cr0AQlUkvt7IFZFhWA/lw+EOKQ9XqH9HaGtDHdWITCxg8ETR8ND+93IiMwtnBeRew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lzU6g3tRPy5jYVftwIGBpX2h23Gy5xlz8arn07Cw3eI=;
 b=XGH8AxDdGl5/oFm7ipid6IvO2+Mf0mOwt09egsdYG7q3Fo/z3DYPq3QnM2er12kixGNb4m1dunkfkRt/yuTI2KSBOksBeNMRDvIwv6RyBasMxnEjgiHP5kcykrVDPmoIQRem7GRSOWolYlPpg2nB5M3CFFCWWjp5pwVKxzoFLx0=
Received: from DM6PR06CA0040.namprd06.prod.outlook.com (2603:10b6:5:54::17) by
 DM6PR12MB4267.namprd12.prod.outlook.com (2603:10b6:5:21e::16) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7002.21; Fri, 17 Nov 2023 02:10:03 +0000
Received: from CY4PEPF0000EDD0.namprd03.prod.outlook.com
 (2603:10b6:5:54:cafe::9) by DM6PR06CA0040.outlook.office365.com
 (2603:10b6:5:54::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.21 via Frontend
 Transport; Fri, 17 Nov 2023 02:10:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EDD0.mail.protection.outlook.com (10.167.241.204) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7002.20 via Frontend Transport; Fri, 17 Nov 2023 02:10:03 +0000
Received: from yifan.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Thu, 16 Nov
 2023 20:10:00 -0600
From: Yifan Zhang <yifan1.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 0/6] Enable LSDMA ring mode
Date: Fri, 17 Nov 2023 10:09:40 +0800
Message-ID: <20231117020946.2912865-1-yifan1.zhang@amd.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD0:EE_|DM6PR12MB4267:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b58ff02-5e80-4932-8371-08dbe7124fa4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ojX7huKBW9h7uOTMr5hjX4fFICYozvFHSf9bCyF856jm1ak9DQx6bbgShiXGr0s83Epbbt/YLtd4ca38wObomoMjLufhbLKaOj2n0oSrqnz/XO2ctxkdEYALKMNohiu68uMHkdOk+XHyhd1vcw22HeeIUHhSpCzXxxB22mIS8i4ztjqFl/ntfua+im7W0p7KeANoO2lBctrmyJwddFH8LZrpqSOJxbCdto49ETuMYAfnvgE3E9rkb0w+APomYwSY2PR2Mq0z+zJOfxwBWMaVX0Wu4WiNBR0dhGmuroruzGaDQqREmTOsegdMom4g+WDg3PEutTGEdtFlePvjTXGLEzv9wfPFYe52Vn76luxMqPQKm4nF8RZVoqe1s1gfqC0gSITSFl1TqZLzM13VT34qexxcYACVjzZJop2uQd32oql7/888JavqFS/Is0mqpSw5+lviTc7IcQ/Ys5aZWFW5F0bwvVq7ywmfb6B98u2GvMSdqWOfDDsMfdQdX64xPNoe/mNTS9tNJrb22LMkVnVQWYtmuM8PQD2CDuca8XEV9wKCeAQDMmI7eqN/MbTErf7cQtA+yHU7e5VKj8FkGiMAxjsxzM2xOv/Obw5w3Dxoh3nw+3csEg2lxT02qgLGWKP3qvWrUqKXlE3RjzvIFg5FtFoHAqAtVlGinBHH5zoVmQvhC8lOkaRoqgg6ejGZLt1aVAIyIReyPYGD+W5/pLSE98Yi5rNtm2S4agKk8cmafS1thABNHKTlS0a2UG2Hl61drjaPc+1kgwDUjLZqOSMH1Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(376002)(346002)(396003)(39860400002)(230922051799003)(64100799003)(82310400011)(1800799009)(451199024)(186009)(36840700001)(46966006)(40470700004)(82740400003)(81166007)(2906002)(356005)(86362001)(36860700001)(47076005)(5660300002)(83380400001)(41300700001)(8936002)(4326008)(8676002)(40480700001)(336012)(16526019)(426003)(2616005)(6916009)(54906003)(36756003)(316002)(26005)(1076003)(70586007)(70206006)(40460700003)(6666004)(7696005)(478600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2023 02:10:03.3572 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b58ff02-5e80-4932-8371-08dbe7124fa4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD0.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4267
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
Cc: Alexander.Deucher@amd.com, Tim.Huang@amd.com, Lang.Yu@amd.com,
 christian.koenig@amd.com, Yifan Zhang <yifan1.zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This series implements LSDMA ring mode, creates LSDMA ring and implement
amdgpu ring related functions. Introduce a new module parameter amdgpu_lsdma
to enable LSDMA, switch buffer and paging funcs from SDMA to LSDMA. It changes
amdgpu driver buffer operations to LSDMA, changes default page table update
to LSDMA. Since LSDMA is outside GFX domain, it can work without waking up
GFX which saves power in mutiple scenarios. With LSDMA dedicated ring create,
it also exposes interfaces for users to utilize LSDMA capabilies. It is tested
on gfx 11.0.4.

Yifan Zhang (6):
  drm/amdgpu: add lsdma hw ip definition
  drm/amdgpu: add lsdma interrupt src id
  drm/amdgpu: update lsdma headers
  drm/amdgpu: add ring mode support for lsdma
  drm/amdgpu: skip LSDMA for mes self test.
  drm/amdgpu: Default disable LSDMA until proven stable.

 drivers/gpu/drm/amd/amdgpu/amdgpu.h           |    1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |    1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c |   22 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       |   10 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c    |    1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c       |   15 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_lsdma.c     |   40 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_lsdma.h     |   33 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c       |    3 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h      |    1 +
 drivers/gpu/drm/amd/amdgpu/lsdma_v6_0.c       | 1293 +++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/lsdma_v6_0.h       |    3 +-
 drivers/gpu/drm/amd/include/amd_shared.h      |    1 +
 .../asic_reg/lsdma/lsdma_6_0_0_offset.h       |    2 +
 .../asic_reg/lsdma/lsdma_6_0_0_sh_mask.h      |    7 +
 .../include/ivsrcid/gfx/irqsrcs_gfx_11_0_0.h  |    2 +
 include/uapi/drm/amdgpu_drm.h                 |    3 +-
 17 files changed, 1431 insertions(+), 7 deletions(-)

-- 
2.37.3

