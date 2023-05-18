Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E74AC7EE24
	for <amd-gfx@archiver.kernel.org>; Thu, 18 May 2023 10:53:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2216C10E4FF;
	Thu, 18 May 2023 10:53:49 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2062.outbound.protection.outlook.com [40.107.237.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 877CB10E4ED
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 May 2023 10:53:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gTZd7HWf7dzO3uKzbUrr+5q/ZBt7rC6zWZKXD3PzUmYbFT/ZZ03J5r0P32R0bHTBTwGeJpUOJo5N6OAV0MaFSOM01TfOIeDW/ZDhCE/CvrMkKF5Ysj48ExZLigs23zLItO3UwOrALSOW5ezUkOaupGjvGcfJVfeMEGRYi/BnkB9k8z//zhiFMxDo6N2T1oYzdAL08VXLVGU01ZA7+T5WlU03v50j7PLxdod+MBp2tVe+zt8f4/lE/qWobE/FhLLepjVBXcqRqRRkd0Es8rA3btQXl6JMD5NOpAIweJIdxY5V7wn0wwV2K3XQRxsVR+vLNZEEl6XM4LCIBvU/noEinA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=abwpamO/pyGNnP8KfgdDLTBSzBvgVXN2+F6qie6JpFw=;
 b=ZWmYjuRhA2fGkqC2SFj97NrC2afLnDckCLTtpl89Rs1cvnwaWD63suOGPUSoGw4CYHmNl4RevkROM7CMbENqWMLRCSoo5P83JjJ2LYXq89bUVIb9wZNOxPg8UHTTXHR7N+QMSnYTed65frH4y/fT/ozfl4PnhTmJyiHDge34aMG8YK29Lqb93toQJ6q39e33JcFoNJ5HwNrSblrcPJjQUSQXBwI+vXZ3+x1TT8TXUmZ/mPOAuZImJYwo9GSZDlEMQewSUY7dXlP4/9+Tsk+JhCdfcS0NkUKy8VI+nSfztEEJqmbv1XBTq6FqxkHu25JtCUxMPqSfy6+kypzHc2UWJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=abwpamO/pyGNnP8KfgdDLTBSzBvgVXN2+F6qie6JpFw=;
 b=fblXOL7NS2cc8L8BzVCMNNWUKOcNHhyegH0obtptpSXcoq5Bv5irvPJ74utNpXrMIinLVGKm4Npi2y3TF6mkzC8cU75aoIK69xeqhWglTTY1oUmnniyvOV4o/ZwKb7+XRr+VVStcMAh8hjf3CuZoBrk+UavOBPx66XG/+SNJCKc=
Received: from MW4PR03CA0110.namprd03.prod.outlook.com (2603:10b6:303:b7::25)
 by DS7PR12MB6141.namprd12.prod.outlook.com (2603:10b6:8:9b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.33; Thu, 18 May
 2023 10:53:44 +0000
Received: from CO1NAM11FT063.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b7:cafe::ef) by MW4PR03CA0110.outlook.office365.com
 (2603:10b6:303:b7::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.17 via Frontend
 Transport; Thu, 18 May 2023 10:53:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT063.mail.protection.outlook.com (10.13.175.37) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6411.15 via Frontend Transport; Thu, 18 May 2023 10:53:44 +0000
Received: from lnx-ci-node.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 18 May
 2023 05:53:42 -0500
From: Shiwu Zhang <shiwu.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 0/8] KGD bringup for aqua_vanjaram on drm-next branch
Date: Thu, 18 May 2023 18:53:17 +0800
Message-ID: <20230518105325.15609-1-shiwu.zhang@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT063:EE_|DS7PR12MB6141:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c575cb9-8f58-4ba0-8935-08db578e267a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UWU2YZCGGk570MrKCU+14y8tDysrRgyL8BGVH2OLc8ZsiarBK3liKqOkAxndLG6RGcYnpU/V3aFauEhIBJYVXRXzqZhlnvtfPKzr1vBJNAapw0NCNH/e40cJ1ubtftmhGC+1Y6GT6ZdXYRYjEgdE5a6y0mpCbzhPw6Ugz+GLqKLeaq+2JMNrSTgiCRCLlxL92cTs2PCFxDnfLLPyQTD4lzPbzqFPrRP4/SFbZNxd/7JtsLYYZ3jpnq5kgrwPlY5nBA1veiFIykDYmcpVGlNSYI0G3sSsHY6vCLnSmg+Du/RhMVglBnZ3+FJK56KibXxe+5lwiQlTAnxiGUxTG59iqj2EsD+Ku5e3gBLE+Isng6mCQZedX+tnEYDc9tYOYLPAhq4U0QTEo59zOeG1k5PZwrAYPYnt7zm9WBVNrH9umfnhlm9G+5sng586eqjdRMYsyCd0+nQ3Bqu3LX/mGWjHmiV44O94l204Iy+msxR9qGK/DdBwe+CmwahZijEGJqOEJBj8zyDeQwDlAHTsR/Nyb8xV9k79QBk8XaDUQZVrsGrQ9OPjPAm6vesVm04kOIH4ZxnFc1H3e9NthL8Rmjhsyjage8NEmUvRG9ua5mgup8CgTMXF+uuttAGI5iCmKjybaHrIFQFK66dJYmZ22kQk/zdEJ5zkzgT9uI3AaFMiNX02QfKbWon1ch5C7lxo1FZL6KPvXWkjaYZ/ZcCAghh0SitMm5HUqLeaUfifDYVB60V1WgX9fQa874Eka5JjLB8iPGDiLabXiaK+6X1vZD+kiQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(136003)(376002)(39860400002)(396003)(451199021)(40470700004)(36840700001)(46966006)(478600001)(83380400001)(7696005)(36756003)(70586007)(316002)(86362001)(70206006)(6916009)(40480700001)(81166007)(82310400005)(2906002)(8936002)(5660300002)(44832011)(41300700001)(6666004)(356005)(82740400003)(8676002)(336012)(1076003)(426003)(26005)(186003)(36860700001)(2616005)(47076005)(16526019)(40460700003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2023 10:53:44.4032 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c575cb9-8f58-4ba0-8935-08db578e267a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT063.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6141
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

This series aims to enable the basic KGD functions during modprobe

Le Ma (1):
  drm/amdgpu: add asic type for aqua_vanjaram

Lijo Lazar (1):
  drm/amdgpu: Use single copy per SDMA instance type (v2)

Shiwu Zhang (6):
  drm/amdgpu: add the pciid for aqua_vanjaram
  drm/amdgpu: add the smu and gfx ip block for aqua_vanjaram
  drm/amdgpu: bypass bios dependent operations for aqua_vanjaram
  drm/amdgpu: skip bar resizing for aqua_vanjaram
  drm/amdgpu: fix the memory override in kiq ring struct
  drm/amdgpu: complement the 4, 6 and 8 XCD cases

 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    | 68 ++++++++++++-------
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c |  5 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       |  4 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c       |  4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c      |  7 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c       |  7 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c       |  3 +
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c         | 61 ++++++++++-------
 include/drm/amd_asic_type.h                   | 23 ++++---
 9 files changed, 117 insertions(+), 65 deletions(-)

-- 
2.17.1

