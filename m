Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B315AC79F85
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Sep 2026 19:54:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E61A510FB2E;
	Fri,  4 Sep 2026 19:54:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="d/zYKmUU";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013015.outbound.protection.outlook.com
 [40.93.201.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8BF9D10FAEA
 for <amd-gfx@lists.freedesktop.org>; Fri,  4 Sep 2026 19:54:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qu0XYqWnDTrVTfttT9A01QqNFEwZkixhGFvXIracPnd0ytQmLBTVq/ZpeDodP0y2XysfOyhDEYiPn37hMYwPq7IwIYaPVYyw8M+6rGpOrnL09jni7jjZy3Dt9qiyHP6o5oooWPKGD4rcsts5sHmL2ThMZxQaHwiDaHzz4ASBF2mj1qnD/iN/TXfBPYgm17izDLT6mGPYEdQIPMecnHQL6NXiPmV7YbVe80mavm5nts1+bAyZgYqEkDmD08SdfHOmYYwVeuRqBylb7JpEFZ/ySPmXWPEJKoqI7o80CXUXXqRBk/h56NLK8iF4XE25e58hXHM5SIa+4ikzpz0NYP+yuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mf4gk2Iq+5sR9USPAuc7kshEQdKtURf5v72uHRxo94c=;
 b=aJi9QZJiCP35bcnzYi3kq6s2MHvjXUUAI659iFKjVaWEtTdIHe6CSYHyD4zQQARotIcDmexzWHS11uSWuLAmLuioE9Bqqzl/cf1SPcAtPc0IsI2vsJL7KrTqtsMSulf3+G1WLsDueisTpWhtbtnPnAs5M9A1lZLLtbncG5xXRRvE519PLUGSdGV2lALR/I1Ep8jxIDihMYcPov4E55hd4wubZ2kZu6JfFWsWymWeABRScFYBm1Bgbi+xiLkvweQHhg/U8+F8APxofajj4cUFdI+IfloLow8m5EXdwwuMczrsrfoDyaulS6HajHlVA8T0Jq3MHyZeAIt8bccR2nE3aA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mf4gk2Iq+5sR9USPAuc7kshEQdKtURf5v72uHRxo94c=;
 b=d/zYKmUUlyWwv9TsX0Cuft4ixmpIVlx/EHrMY1eoLPU/ZQH16Nw61G65vizuK35WWaY0qHyO1a2+WMqGVCBM+hxkH6LT3a3+WV0dlL0Asf29Gb3ppIae6pX4E+hTS3ZHFDEFAxGrq1LPinDJbgoUAcFlh5Vd+N7yFayzHfGwAiY=
Received: from BN0PR04CA0001.namprd04.prod.outlook.com (2603:10b6:408:ee::6)
 by SJ2PR12MB8832.namprd12.prod.outlook.com (2603:10b6:a03:4d0::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.9; Fri, 4 Sep 2026
 19:54:27 +0000
Received: from LV8PEPF00000066.namprd03.prod.outlook.com
 (2603:10b6:408:ee:cafe::2b) by BN0PR04CA0001.outlook.office365.com
 (2603:10b6:408:ee::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.13 via Frontend Transport; Fri, 4
 Sep 2026 19:54:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 LV8PEPF00000066.mail.protection.outlook.com (10.167.248.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Fri, 4 Sep 2026 19:54:25 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Fri, 4 Sep
 2026 14:54:25 -0500
Received: from Xiaogang-ROCM-Dev.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.46
 via Frontend Transport; Fri, 4 Sep 2026 14:54:24 -0500
From: Xiaogang.Chen <xiaogang.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Xiaogang Chen <xiaogang.chen@amd.com>
Subject: [PATCH v2 0/4] drm/amdkfd: Enable device private memory THP support
 in kfd svm driver 
Date: Fri, 4 Sep 2026 14:54:17 -0500
Message-ID: <20260904195421.42919-1-xiaogang.chen@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PEPF00000066:EE_|SJ2PR12MB8832:EE_
X-MS-Office365-Filtering-Correlation-Id: 255bf899-634b-4eeb-b9ba-08df0abe529d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|23010399003|82310400026|376014|1800799024|10067099003|11063799006|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info: /AgbgdRUtMLuGXcMxt7Y8iARagKpXfjgr+BmXo/lYbpSPFGUqneIhtTNuNeF7mRxBTLw+Udx1H0sPGlGACAQYOr3sz+mA8pJLuHgtVVvZWKuUzuHhhoE5AZuI+iNA0yGzwNNxpyHEMTBUGMEPUmGWuiWqUyS2sPPm8XJhEcytpZCBQqEmbpDCc37cd0utYR7mrD31Y1gf2sT1Zy6SxaZDyPpyOiLJstW2D/enQLF6w38bFgWfrX25fPDU80cTnHd2+0fLvM1oLnyFIk6IEhFF46XarUk575gls46EORMAwZgTM4deAC2k5E8Ihv+Tm2tTke6xTpy1UtydKL6thO75bMQRDNV/Fp9ZKGhUWUR8ZPo0mLqabdGvpUULOzTzGiatD7r+HKof3O5LwV05nOQZY/C7TpXsDbJ36DH9/dawEGjQyvwHg9w9nu3t3MYDo7FD1FPZhuty2AaGp1WU01wMnFJqpyItlm86NHqLO7UnGvc5nX+BT8rBx+AHY5ncbOhYKH1GfeupcIEPZRmjI2U0v4D8li4RqukIRl7MdpMxG95esldWkokS3ZoWEr/fU+M0fKnbkkWjBIJyFm/B+9VBiuoxsuS2ecSanZctVsNdx+QP89hw4kNF9LYERQfaEcJn66b9v81UU0L7KriflZ8G4NeHMM1frw+mGCmGhNLBMvQ7eafz+WEC8Cg++39KdSfg28qBXO/H3HJ9S0WYL6FWQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(23010399003)(82310400026)(376014)(1800799024)(10067099003)(11063799006)(56012099006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: J+4OwrztqXWUmuzmoQ6apn7CUwgBftFkeqyEJBZ9BPkbEMOmSi2twUMnVB5IUYvhXueWIfn6qJc4REsnXVSUd3LKby71B7BlYz9PcNq/u3moNccxwJeoTuUETa1TTh2npaFO4KJ9vx6xQgXgFEH5EJDNyLjJTXWD2VzF4LiLzRIN2ztim1kFKG6blNEhZuKnJdR/2D42/Vf4GADei7UQcQMCg5DANBFlBXqjmWN94KgRe3sQUtc7kQHXoU4LzkBLe8lgTt7b9Vh8sBLsQBFGJjYYJ+5I2CkpsWMK8l/WscClbdFKJANRq1J6/GQDMNGqQf0g29VpjLuuscAAdgTIsMbE90VKMhrH7WeqMW2awKtFLEVXQK+BML2b4EW3o9EYmRLAmY1+TRXE+OFDSBqdihkuX6zOkUW/3B1tuy+9Z1GMtperlyAmtI953rjimhbo
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2026 19:54:25.5595 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 255bf899-634b-4eeb-b9ba-08df0abe529d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: LV8PEPF00000066.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8832
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

From: Xiaogang Chen <xiaogang.chen@amd.com>

Use following work of device-private THP support [1] in kfd driver to add
2MB/THP support in migration. The implementation enables efficient migration
of large folios between system memory and device-private memory.

[1]https://lore.kernel.org/linux-mm/20251001065707.920170-1-balbirs@nvidia.com/

v2:
- Reset is_large each 4K page iteration
- Unmap the THP DMA mapping once as DMA mapping, at its real size
- Leave migrate->dst[i] zero when the source is not migrating
- Count THP migrations as HPAGE_PMD_NR pages in prange->vram_pages
- Implement folio_split and hold one svm_bo ref per subpage

Xiaogang Chen (4):
  drm/amdkfd: Add awareness of THP of device and system RAM in kfd svm
    driver
  drm/amdkfd: Change migration size in CPU/GPU page fault handler to THP
    size
  drm/amdkfd: Apply HMM THP zone device-private memory migration in kfd
    driver
  drm/amdkfd: Apply AMDGPU_PTE_FRAG to pte of gart page table for THP
    mapping

 drivers/gpu/drm/amd/amdkfd/kfd_migrate.c | 348 ++++++++++++++++++-----
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c     |  28 +-
 drivers/gpu/drm/amd/amdkfd/kfd_svm.h     |  13 +
 3 files changed, 315 insertions(+), 74 deletions(-)

-- 
2.34.1

