Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72AAFC6FA8F
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Aug 2023 21:58:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1556210E093;
	Thu, 24 Aug 2023 21:58:53 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2061c.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8a::61c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1523010E093
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Aug 2023 21:58:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CWin1sMDkqYXkfX/qmwu+lOiaQ++mGcmatUkTauEJFP30+lZ4TCQO2C2D3wD6aWQ0NoXZLyNFx+rTQERxW4WJKTuJ0b5aXKxpaM4iQX9nJSlG7uYqABncH9t+LDHpltqLtlo/oJTzd/inQRwyeDrUVtRmK4tK1ls+PCXkbvJl1cDexmwl7+QPdRJQsps9xJNgoqMHeD+86tC+jrW9z/1rjZ54wc82blWf4Ug/K/HqeBe2umLLSJVk8Fnbwpe1asBoviVilL63K45r2NZoY8sopDG+yodg1Nq/6eTh+jhEbfQOzCjcxZZSlqJtbR41QLw8c4IPzUcl7bz11o4LjilUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=biThWKPr2SviH1Wjc4vuM6rNPQysAo+11zlx5C0o2QM=;
 b=NcDlyQjxEC8KakPwcXL2ZRHjw3looOlKloZnIe5Eztavn3i4mnlcm5OFMHdv3cuM1m23qAY6YSk7TekrtF4tcGVlDu57KE/xFVT+wrX2O1P1NuXduDqVSHrHvzOOaWitFeR4sKca4HPQcOpebI86vQQAh9pe+zgPPJiwYR3Ly5HV5nD6CO0mDeRsC2CZASggzJzXbi6lRJseIZpMnrWIkEg9jDTFpm63BuVi2IOBkV4xCQ5p7992as3rLXguKZZD1ls/zGCWiq9DT9at6QddRtD86SEk3pjePI0jFH1iLIHXkviOcclQs/nPuaW5Its++0VGMmKNbcIV5PmDhZFwhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=biThWKPr2SviH1Wjc4vuM6rNPQysAo+11zlx5C0o2QM=;
 b=p4vdTxGN5lSY1BOCQyEhPYka2pn+VxL9jTh+j3jRLSKQCXbRMRfT7mrbt2VkXAMqiDcpfNmvGTAqdCaJjklApKKBrVQJJLgl0Zl+ctXDuXgNkJ1TrwjGJNve8jlpRm219ijXGNOjq3j4d3ufI6tzDKwixIcz5UH/c18v+8LLP0w=
Received: from DM6PR06CA0083.namprd06.prod.outlook.com (2603:10b6:5:336::16)
 by PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.27; Thu, 24 Aug
 2023 21:58:49 +0000
Received: from CY4PEPF0000EE32.namprd05.prod.outlook.com
 (2603:10b6:5:336:cafe::88) by DM6PR06CA0083.outlook.office365.com
 (2603:10b6:5:336::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.27 via Frontend
 Transport; Thu, 24 Aug 2023 21:58:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE32.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.15 via Frontend Transport; Thu, 24 Aug 2023 21:58:48 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 24 Aug
 2023 16:58:47 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 00/14] UMSCH 4.0
Date: Thu, 24 Aug 2023 17:58:21 -0400
Message-ID: <20230824215835.2740115-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE32:EE_|PH7PR12MB5685:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e08e358-0a60-41bc-c387-08dba4ed4b83
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AL10QhtvBSOwmkLhDxeLBio7ErK4lW1szfrww9la9W1tACt7ltfQzkluV2+UJ7bQzl03Bcyu1wlkHhzsQFZIbt1Yl0U4G5jiRLIlDTpc9r81Ppb+r2AjNpIS8/nG9Do9n4YsmdZbs6oGyt2/C16y13bIQwnbrLTszACXOQDGILUoPqlhqjLRAgG6gCaezWdDaG4pHRXKXwrqnhsEK80Lwzk8x9k8hPtqtx36T77ZfrjocHVIj0EmfSmBx5abm2IW8qO3Lq0HC71PE2/zmIpXAQGKT+rAoOvziwBiNniwpQ4njSV8f4vmDACoGCGPfi/LWadcFQnsgI0yB/hi3EIDTJ/5w054JAEnMS+SsWiJnpoUxJDc7N6N0AEX0hcQZktfvMV/LWEot+QYqlUKU3FA8bTqgei7HT1p9rGoAVbSX0Tb/RwVkQVp9nmvTUmVVT1ffL27ESJLqb3QM5MSeq9/fZY/g6evekbciE9/aiPULHDC0PrPgZpYqhv2q8TV+VlmSvAeki98cWBDlqP/EBiopPBPsMGFYgdOOjGK6qXqeXcBogr7cUM9Q2eTdFKYuPR3ZQiOysHlpd8nBZG3iejSEdAow5UqujE0huvgMCBYzTX4lo88dvZjG3kquFlIHWoeMoIoMHjvwJqQutz84SZeZVrLWJ6laCuqdAFviv065XJX4AO7aW/VcM11Je/rgcAwOCw9kwgQEbWh3iP2YCQxb2+NsoLHEbCzQD/8jlc4vBgOq3E4rzGT27jwv49A4t5y1sDRLB5OBK8E1e6duHuaKA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(376002)(396003)(136003)(39860400002)(186009)(451199024)(82310400011)(1800799009)(40470700004)(46966006)(36840700001)(40460700003)(336012)(426003)(26005)(16526019)(83380400001)(2616005)(1076003)(47076005)(36860700001)(41300700001)(70586007)(2906002)(6916009)(316002)(5660300002)(4326008)(70206006)(8936002)(8676002)(478600001)(6666004)(7696005)(40480700001)(86362001)(81166007)(356005)(82740400003)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2023 21:58:48.3094 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e08e358-0a60-41bc-c387-08dba4ed4b83
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE32.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5685
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

Add UMSCH 4.0 support.  UMSCH handles scheduling
of multimedia queues similar to MES for GFX and
SDMA.

Lang Yu (14):
  drm/amdgpu: add UMSCH 4.0 register headers
  drm/amdgpu: add UMSCH IP BLOCK TYPE definition
  drm/amdgpu: add UMSCH RING TYPE definition
  drm/amdgpu: add UMSCH firmware header definition
  drm/amdgpu: add UMSCH 4.0 api definition
  drm/amdgpu: add initial support for UMSCH
  drm/amdgpu: enable UMSCH scheduling for VPE
  drm/amdgpu: add selftest framework for UMSCH
  drm/amdgpu: add VPE queue submission test
  drm/amdgpu: reserve mmhub engine 3 for UMSCH FW
  drm/amdgpu: add PSP loading support for UMSCH
  drm/amdgpu/discovery: enable UMSCH 4.0 in IP discovery
  drm/amdgpu: add amdgpu_umsch_mm module parameter
  drm/amdgpu: update SET_HW_RESOURCES definition for UMSCH

 drivers/gpu/drm/amd/amdgpu/Makefile           |   5 +
 drivers/gpu/drm/amd/amdgpu/amdgpu.h           |   6 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c |  20 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       |  10 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c       |   6 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c       |   9 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h      |   3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c     |  21 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h     |  20 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.c  | 875 +++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.h  | 218 +++++
 drivers/gpu/drm/amd/amdgpu/umsch_mm_v4_0.c    | 408 ++++++++
 drivers/gpu/drm/amd/amdgpu/umsch_mm_v4_0.h    |  30 +
 drivers/gpu/drm/amd/include/amd_shared.h      |   2 +
 .../include/asic_reg/vcn/vcn_4_0_0_offset.h   | 422 +++++++++
 .../include/asic_reg/vcn/vcn_4_0_0_sh_mask.h  | 882 ++++++++++++++++++
 .../drm/amd/include/umsch_mm_4_0_api_def.h    | 437 +++++++++
 17 files changed, 3372 insertions(+), 2 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.h
 create mode 100644 drivers/gpu/drm/amd/amdgpu/umsch_mm_v4_0.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/umsch_mm_v4_0.h
 create mode 100644 drivers/gpu/drm/amd/include/umsch_mm_4_0_api_def.h

-- 
2.41.0

