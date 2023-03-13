Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7723EC6FD19
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Mar 2023 01:44:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E6B1B10E44F;
	Mon, 13 Mar 2023 01:44:26 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2058.outbound.protection.outlook.com [40.107.212.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0DC2110E44F
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Mar 2023 01:44:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ScVmbrHNF4EyMPTy4D9jKwyAK6xcaTnFNxEjcmlWj37osBsyClCXMjL6F6evEcla7lLzGCkKngnq+Me7TevQb1yyuAUmDMIDEq5EaZ0g0a5Lfcek1tYpxJc+9hq1f41c4+YT9B1h6gaOD4jqopTR9/Sy/KuFGsJNBVknAHVtWo0sBLez4+VDI0MT9NGbP4XT0SQ61ryc9DWu5W2e4J5Gr7sV69RwqJJsbLv25KYO8WuI2pEgr8yahL9Jnebh9A4oxaaANF0kFVmefwKQtm85fg7mXRmulqXr1vaZThKql6E2Jp4Nmx4DBKOTea74RF9In4//DcY3h0U42i7I8A/FrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HIGsWc81Hvfurj3QBPjl5BTcLyXo3d/Vs99JsS8dCSg=;
 b=SdFbZcT/n+QGrFloCWftZU1GGKcvrcp9TuS+f/HFaqYs1c5E8yAaSR8ZwuzakowsxWPS/2bH205xV7UNBHk3KcppiNEsmXlFtBhLpOv1qL2TbN3MxmId3ANazk1nFRqgei/oGs8O3IqZmEfSvbCDSvy/3rXTDTqebf3frVgW0zbzttmZQMr5lsss14LcnnPHrlUHgZzpkmGIwTZzzGUkTtSFwpDIZ47KZo6WNt2Jyi0sHqCJMKcaIhMFqE+1TfOn3qlzIWFA0UOyYcmkTVV2nTuqG1ATeMH3Lzu6afp1SDO1Bl6bvDai9JQLa328rR4h/PQgewjbBmOgU9TjAw2fhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HIGsWc81Hvfurj3QBPjl5BTcLyXo3d/Vs99JsS8dCSg=;
 b=dsIRh+ZZFz8YIIhXXYdwRZXz8mWglX6wGjYgrcX2BUf1p1q86uYwMWbHTjnUdYIkLSkizsNMqRCj9Lg8mrp5bVKm3Lzml9a3JJijtQa6i91r3tZsyucQalRx+s/gilZM3625X4/5/1FIWHCbQlHXLAhmUom+IKcSH3d+RGB8ctI=
Received: from BN9PR03CA0220.namprd03.prod.outlook.com (2603:10b6:408:f8::15)
 by CY8PR12MB8195.namprd12.prod.outlook.com (2603:10b6:930:77::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.24; Mon, 13 Mar
 2023 01:44:22 +0000
Received: from BN8NAM11FT012.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f8:cafe::73) by BN9PR03CA0220.outlook.office365.com
 (2603:10b6:408:f8::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.25 via Frontend
 Transport; Mon, 13 Mar 2023 01:44:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT012.mail.protection.outlook.com (10.13.177.55) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.24 via Frontend Transport; Mon, 13 Mar 2023 01:44:21 +0000
Received: from hawzhang-System-Product-Master.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Sun, 12 Mar 2023 20:44:19 -0500
From: Hawking Zhang <Hawking.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, Tao Zhou <tao.zhou1@amd.com>, "Stanley
 Yang" <Stanley.Yang@amd.com>, Candice Li <Candice.Li@amd.com>, Thomas Chai
 <YiPeng.Chai@amd.com>
Subject: [PATCH 00/10] add ras sw_init (v2)
Date: Mon, 13 Mar 2023 09:43:53 +0800
Message-ID: <20230313014403.21903-1-Hawking.Zhang@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT012:EE_|CY8PR12MB8195:EE_
X-MS-Office365-Filtering-Correlation-Id: 8aa4b024-73da-4799-9c19-08db236477ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yxWEQDJemncdjcBtRiu4jYi6k/ChHy2/Nnl4Sq4PtKdt2CmpXadJCuGtyuv3G1U2pt/S1DJLgBNIsIK3NxtBA2zRXHlZ+r81wYOIodZw3YLvhz3duLx2Rn4sHC+5bcQe8PdJvHAaKSMNSQ9+N6WiARpHf0pQBcTsWjJr5g/KtTfLl05WeUtJXlbtYVUyQCDirxYDQxZwk3MAfIEUmPn/T5zEkT7oT6e270gZmaq6zxAnAMyJ4icIzIQ7UVveym3Ox5DaaWvSBkG6aIgI+EaFqAIjURPPTw0Bo7DPB5n8+kIkBlMk7SOyYVMiGgY7Rf2sNWJLOmf3NRaLdf3cSLUQZYANjb20aXLRGJxXfFXSSedtCrLOcq5hMYjAds8DjpiWFHgjzFdw+9F9enNz36T0dmzwccr0fz6jsbQgC9auQvGWeynApYB+Ma4lA2VEezi92ADOzb4HQuH1NGoJflswMN5oalI8usvqDnr54mzQvgTon9qz9ftT8xxCxvA+dhcp9JvH048TZHyXyaQPGaysVuoFn61UiwrSieunYDj39jpU6pH8HJfXu2UfYUlTq/g+D/rPFvZ2ygUpWtRQpD82Q7Qg7eEloOajX5lNthVpknfLEQ6I2NWzDrwhsVAIZ5X6LSFEUybnfntow2xmCpfoIbYRa8datMjza9jqtDm+RvM/Kw94V8G48QH/1hWlZQFE7DO+BaSVydsC+DKSvmmMw6ToA2UwTVku/DtbfTSJNwg=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(396003)(346002)(39860400002)(136003)(376002)(451199018)(46966006)(40470700004)(36840700001)(81166007)(2906002)(82740400003)(83380400001)(36756003)(40460700003)(5660300002)(40480700001)(70206006)(70586007)(41300700001)(8936002)(4326008)(356005)(8676002)(36860700001)(6636002)(86362001)(110136005)(316002)(82310400005)(478600001)(16526019)(47076005)(426003)(186003)(336012)(2616005)(26005)(6666004)(1076003)(7696005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2023 01:44:21.4156 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8aa4b024-73da-4799-9c19-08db236477ad
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT012.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8195
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

We are moving from soc ras to ip ras to address issues as follows
- RAS sw block init is mixed in early_init and sw_init
- RAS cap check is mixed with both soc check and ip check.

RAS cap check is now only avaialble in amdgpu_ras_init,
based on the cap query from bios. RAS sw block init is all
moved to ras sw_init and follows ip based ras cap check
from amdgpu_ras_init, instead of the check in soc level.

v2: simplify the ras check (Stanley/Tao)

Hawking Zhang (10):
  drm/amdgpu: Move jpeg ras block init to ras sw_init
  drm/amdgpu: Move vcn ras block init to ras sw_init
  drm/amdgpu: Move umc ras block init to gmc ras sw_init
  drm/amdgpu: Correct gfx ras_late_init callback
  drm/amdgpu: Move mmhub ras block init to ras sw_init
  drm/amdgpu: Move hdp ras block init to ras sw_init
  drm/amdgpu: Rework mca ras sw_init
  drm/amdgpu: Rework xgmi_wafl_pcs ras sw_init
  drm/amdgpu: Rework pcie_bif ras sw_init
  drm/amdgpu: drop ras check at asic level for new blocks

 drivers/gpu/drm/amd/amdgpu/Makefile       |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c   |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c   | 41 +++++++++++--
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
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c   | 20 +++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c   | 30 ++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h   |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c   | 29 +++++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h   |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c  | 28 +++++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h  |  1 +
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c    | 26 ++------
 drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c    | 21 ++-----
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c     | 59 +++++++------------
 drivers/gpu/drm/amd/amdgpu/hdp_v4_0.c     |  5 --
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c    |  6 +-
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c    |  6 +-
 drivers/gpu/drm/amd/amdgpu/mca_v3_0.c     | 44 +-------------
 drivers/gpu/drm/amd/amdgpu/mca_v3_0.h     |  4 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c     |  6 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c     |  6 +-
 31 files changed, 389 insertions(+), 186 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_mmhub.c

-- 
2.17.1

