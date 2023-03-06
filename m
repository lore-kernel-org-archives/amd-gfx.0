Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18D9DC678DB
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Mar 2023 02:32:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E6C6610E02B;
	Mon,  6 Mar 2023 02:32:39 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2064.outbound.protection.outlook.com [40.107.92.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AD39C10E02B
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 Mar 2023 02:32:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FVQYH+DJ2XIA+JUMhtemBzp7QsJISsmFTPejLb9XSYJ8MtDpOx136i4/ap4TdSGvhHZFoWD10hHq58gnIkTIXyoKClTBSpYoRxvLspUO2bJyHmPM0TqFRfFloo6L3iIHr44Kn3qMS+rT0vJ9rE7Sy/wIR2bmNWSLo9ksdwD97W1J+wnwyL4B21AMk66WDKATMuvZ70WUyYnhv2M08NCgy8N1LpwdAZN9wK0+LrpeHw0IJKUo8Gq7m1oemm08UZfxeanhbyiJI2n5P3qa9ma+CsotUfJH52Za89amzRth9spP9AWiPSpGOMf+N015YS8jUtzx7lmi9ndtmZobQgEOuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ylHySCTuJf/0wAvip3wNF6jq52Wv3JShqUORgriPyHo=;
 b=lTZtHh83T4gGmw2PcWUtzCBBcdfZ/UXeBEtknh9Ah9JDUGaDxOVPglFerll99XgUnEH+DY7RH701mzGsyy1LmoHmfRF+GvKs8ismC5bsB4l8nf+xlz7jvGii+TE7IO/gpuUcALC/QVi46U9X1+lUVWKJC8GObF6CErRJ+ymYY0EFtyPLH+vkVuhfMNj+RyLnn/2lV+r5J5psjI/W2elgJOkrpm5Pk/pOgnUJRPRweU7FrtvJb9IJ0mj+nuaRXAsTwuO1ENLLj6k/msG6RtEtFIXZ5rkCoe2uk0kcIyGbRnnZfSkFsi55c0lZHo4TGyg9d37hLxCMYZjDOKzmUJCqRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ylHySCTuJf/0wAvip3wNF6jq52Wv3JShqUORgriPyHo=;
 b=xPZ3YpRerU+KjFcL/QPhfff2q6ilJA0teDBQzi0mlWrG3rcjnNTDitomhU92FeSr3jc67I2kfboPQWSWfD8zroybFjIHlz24cUi18TrjhGAUT1OmUjSXKcNwmB3lgFSANRkRG40bs8XUfBOO3WtsWLJdJJOlaKfFohxE1qPa4NY=
Received: from MW4PR03CA0044.namprd03.prod.outlook.com (2603:10b6:303:8e::19)
 by IA0PR12MB8861.namprd12.prod.outlook.com (2603:10b6:208:487::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.28; Mon, 6 Mar
 2023 02:32:35 +0000
Received: from CO1NAM11FT074.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8e:cafe::f5) by MW4PR03CA0044.outlook.office365.com
 (2603:10b6:303:8e::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.28 via Frontend
 Transport; Mon, 6 Mar 2023 02:32:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT074.mail.protection.outlook.com (10.13.174.254) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.14 via Frontend Transport; Mon, 6 Mar 2023 02:32:34 +0000
Received: from hawzhang-System-Product-Master.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Sun, 5 Mar 2023 20:32:32 -0600
From: Hawking Zhang <Hawking.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, Tao Zhou <tao.zhou1@amd.com>, "Stanley
 Yang" <Stanley.Yang@amd.com>, Candice Li <Candice.Li@amd.com>, Thomas Chai
 <YiPeng.Chai@amd.com>
Subject: [PATCH 00/11] Add ras sw_init
Date: Mon, 6 Mar 2023 10:31:49 +0800
Message-ID: <20230306023200.29158-1-Hawking.Zhang@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT074:EE_|IA0PR12MB8861:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ba8317e-675e-4092-d2da-08db1deb0b7c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 064Cp1LZf076B9wKQloKwgBAI3rLZRmU4EjJNU5K8auhHSV7WENVil2KYjjLKgAafvxRg2i7E5S8hw08StO67vDusMxE35/e8h9MggWcOLU21bc88cydmsISyLluZsHxj6021s/1w+kOXrQgnmHKvHDUO7dnZh7K3OImHQE/9kN5qIpea3Po5rNjUTqYiS0Id0ILIGTp65l6rYuIjC002al3iJX5fpp7WRiQQreIf5QX2d1j3Wc4Dd7htUZ83b0xVdm0B24AKg3VGZ6K5xnAxpzIzyHD3pPOejdq1e2aYVQTUZ++i+xcIPY4TBumKNb8WNDiOzSvYfqtmMV3Ms9QRzyKTqI3w/KcnECiwvIqde5n4LcBnpEmLuOg40ZeSA5IYylJ6wS0mMsoObDzFto1GpRZbPhHQ6u/8zHegVOlT1QV3Oyrf5jNF+V7efKJGo9EnoZsk7QrKfDZhAsfsi5HSCUYGbX2lyR9BY0bK/am9dWVd6YhmfEdpdyGKNsB62l08YA6sJCMdDAFQFjFMeeEdBX6CLgHiQmkYVV1v0yaw685HVUgpmACEhFa93jU2EuTeDK7qC2FB5LoJsbBXCRq44oyk6s2hueAOQCt1r3Ub0kz9Vcm+VvLliOIhwL84TprY1vfFV4/opU6le/V6HPsRMNwA5yG3oQkUBk0UxpXdXv68CZG4QP63BTndZKULUsjCT4VVWiF6JhGQEgVyPCdJ+olUgtDDP/90y+3yhuSfKc=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(136003)(346002)(39860400002)(396003)(376002)(451199018)(40470700004)(36840700001)(46966006)(40460700003)(16526019)(186003)(6666004)(81166007)(356005)(8936002)(36860700001)(4326008)(8676002)(41300700001)(2906002)(82740400003)(70586007)(70206006)(5660300002)(426003)(47076005)(7696005)(478600001)(2616005)(1076003)(26005)(336012)(316002)(110136005)(6636002)(36756003)(40480700001)(82310400005)(86362001)(83380400001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2023 02:32:34.8744 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ba8317e-675e-4092-d2da-08db1deb0b7c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT074.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8861
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
Cc: Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

We are moving from soc ras to ip ras to address issues
as follows
- RAS sw block init is mixed in early_init and sw_init
- RAS cap check is mixed with both soc check and ip check.

RAS cap check is now only avaialble in amdgpu_ras_init,
based on the cap query from bios. RAS sw block init is
all moved to ras sw_init and follows ip based ras cap
check from amdgpu_ras_init, instead of the check in
soc level.


Hawking Zhang (11):
  drm/amdgpu: Move jpeg ras block init to ras sw_init
  drm/amdgpu: Move vcn ras block init to ras sw_init
  drm/amdgpu: Init gfx ras block when ras is supported
  drm/amdgpu: Init sdma ras block when ras is supported
  drm/amdgpu: Move umc ras block init to gmc ras sw_init
  drm/amdgpu: Move mmhub ras block init to ras sw_init
  drm/amdgpu: Move hdp ras block init to ras sw_init
  drm/amdgpu: Rework mca ras sw_init
  drm/amdgpu: Rework xgmi_wafl_pcs ras sw_init
  drm/amdgpu: Rework pcie_bif ras sw_init
  drm/amdgpu: drop ras check at asic level for new blocks

 drivers/gpu/drm/amd/amdgpu/Makefile       |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c   | 64 ++++++++++++++++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h   |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.c   | 48 +++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.h   |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c  | 29 +++++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.h  |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c   | 72 +++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_mca.h   |  9 +--
 drivers/gpu/drm/amd/amdgpu/amdgpu_mmhub.c | 46 +++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_mmhub.h |  2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.c  | 23 ++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.h  |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c   | 19 +++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c   | 30 ++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h   |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c   | 29 +++++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h   |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c  | 28 +++++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h  |  1 +
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c    |  9 ++-
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c     |  9 ++-
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c    | 26 ++------
 drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c    | 21 ++-----
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c     | 59 +++++++------------
 drivers/gpu/drm/amd/amdgpu/hdp_v4_0.c     |  5 --
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c    | 10 +++-
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c    | 10 +++-
 drivers/gpu/drm/amd/amdgpu/mca_v3_0.c     | 44 +-------------
 drivers/gpu/drm/amd/amdgpu/mca_v3_0.h     |  4 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c    |  9 ++-
 drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c  |  8 +++
 drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c    |  9 ++-
 drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c     | 10 +++-
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c     | 10 +++-
 35 files changed, 462 insertions(+), 193 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_mmhub.c

-- 
2.17.1

