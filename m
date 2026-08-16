Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6E01C5DF6D
	for <amd-gfx@archiver.kernel.org>; Sun, 16 Aug 2026 17:26:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4AFC510E2BA;
	Sun, 16 Aug 2026 17:26:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="o0hr/XCg";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011003.outbound.protection.outlook.com [52.101.57.3])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 380D010E2BA
 for <amd-gfx@lists.freedesktop.org>; Sun, 16 Aug 2026 17:26:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RjGpG5UAGpdSXIyPj9qa8D3hB0RsHROcw2iexvwu+6k4th9HhlKuLhSYdgeoh1IqcfiImOTLhd5Qag+A+3PPSl65FyDLkZwvJPzRZbMX0k9k4SKiGDCvpVWgA463ctjtO6YhN9pC423sJ5svOSk+sUMqn7Q4WpiMJp6Ur7xjdDxV/ZJcJinKDrknPdVzpyxs4Vbe6e41yRvKqTuNpVSpGYsZtGXXCFglcQbs6siWLM6QV0YWaRerje/lnUW63VFpp0nAjhmohjY+ylBm3BZQvY0mJJnBAuudijSQtWQqN9RNVzHniTq7KCyvTzAENHX4+eW/O/sOHBQJG4Hw9j9TLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O/mKjJcgDeR0xlj8zt5HeLrPXkjv7UZgGO4llyyot5o=;
 b=d/py0/5kGXzfbIFl6Wv2XfoYA/TOxoWkcN2ZqRzKqsEcyrNQnQM+ZiHy104gC5FBC5czTiMJ1PCRTARCtCr6fT2n8YGfZjXW7ZkcqVTH2nkRF0mDLUdOw7VOeBtdteoTqWvFEIYGKIc2m+DCwhV2OIwhdMuDosiKEblnkg0L88PML90FJ4WUkgK3EXL55NZojB0eGS6+X2v9Z0Av79Bfn/5M0e6eS4GVNqZ2knhf14r6nnVMfEjRX+6zvYsKm+Mnf/3uyiEZjfV+VmO0MuDM/r6pdIpQ8BvlvC3vT3hWaAw/UlIOVUQMJm1mzhFmEDgu7swPVb8e+u2v1zaJi1wSrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O/mKjJcgDeR0xlj8zt5HeLrPXkjv7UZgGO4llyyot5o=;
 b=o0hr/XCgnDor2wAUEHTmJAKt0OXaB/gIcc7xKQn7DDnxx4xF0bqJrGBy/GnOwrPAflltZ81fmAsl/9+AMaegMmVgqcP5LUdNqs5q3s1eq2/e46/pIhxp+MYfMOteZcVMuTRd2ppA4qsIBik1qtK3vxjVV+9nt7ulDUCmTfjL82M=
Received: from PH8PR22CA0009.namprd22.prod.outlook.com (2603:10b6:510:2d1::25)
 by DS7PR12MB8201.namprd12.prod.outlook.com (2603:10b6:8:ef::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Sun, 16 Aug
 2026 17:26:14 +0000
Received: from SN1PEPF0002529D.namprd05.prod.outlook.com
 (2603:10b6:510:2d1:cafe::28) by PH8PR22CA0009.outlook.office365.com
 (2603:10b6:510:2d1::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.17 via Frontend Transport; Sun,
 16 Aug 2026 17:26:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SN1PEPF0002529D.mail.protection.outlook.com (10.167.242.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Sun, 16 Aug 2026 17:26:12 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Sun, 16 Aug
 2026 12:26:12 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Sun, 16 Aug
 2026 12:26:12 -0500
Received: from rtg-MAPLE.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Sun, 16 Aug 2026 12:26:09 -0500
From: Priya Hosur <Priya.Hosur@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Alexander.Deucher@amd.com>,
 <Sunil.Khatri@amd.com>, <Felix.Kuehling@amd.com>, <Shaoyun.Liu@amd.com>,
 <Lijo.Lazar@amd.com>, <Mario.Limonciello@amd.com>, <Christian.Koenig@amd.com>
CC: <Pratik.Vishwakarma@amd.com>, <Veerabadhran.Gopalakrishnan@amd.com>,
 <Priya.Hosur@amd.com>
Subject: [PATCH v4 0/1] drm/amdkfd: Add TLB flush after MES queue
 eviction/suspension
Date: Sun, 16 Aug 2026 22:56:07 +0530
Message-ID: <20260816172608.14470-1-Priya.Hosur@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002529D:EE_|DS7PR12MB8201:EE_
X-MS-Office365-Filtering-Correlation-Id: 25a09852-4a7b-49bf-4e2c-08defbbb785e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700016|23010399003|18002099003|11063799006|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info: +83K7AnLzo55is/r5LCU5uDtxDe1t0VQR87j9FQ+tw+sGfMPjPvsx/lcqOrNkpX01tOX/EpL5cxuvNMbuDpw8zVrf6ELsZvtSdo1VAEa61U5irRlMoT/TmodcY1sKiZg4U4PHFrM2CwWp8IBj5k+GYwW3QKsVaXH90g49hHyPe0kztWh1OoC5c3u0f97a02Sa+c/cagcPuMYxtt2QzqFtZeOKhq3z7bUUMLPdHZ5v7z5yBQ3hm5fS82iMfXkFukfJ0b/gjuGKphWaJODLgV8F+L6KmSEeky7ZFlZWHcpGYf+589av5rtIvyieerJdJenf00jamxCGqeUAP87Va1XcS57QIXyEzsdZ+4c9ZkLxSc4UKkKkVIu5sPwYB0Mng02GqA752qMF/33H28KcaCBbHYo44gH/QWKAiuYQLinHVHplH/xtynPVeHI6T4aDFpdr+WBL5iesIPMSkfUW4QbDeR3+oatpcoXN3WS8hRdxuiArvk4rY8BofCBXHeg67z59VhVguCWr1VpXX3tkWeX9oNptn+n6Pb3gfIm+jCAxG38zKNUhMnBiRhu51qR3imYFitdw1ZByhN+Jd1GxvETtjePXH0NVydk7JbDnfFLFa5bE0pfeR2OqOveqvlF6z2i61S1DqT9/P4YajtPz+B9P0QUZiruXjKJ/VqzSdwtpR6RXzr3EqMyYa5U7pFprd36ES38rr1vcURdXjl2dpRYcw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700016)(23010399003)(18002099003)(11063799006)(56012099006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 39rrG46s3RDUH61c89R4Z/9R+9gd6R+dJr/dzzhev0s375pmU49Rcbq/Q5Qp/6kXOOb/JPbIXOlCQ505ZcDXYt2Hff4QcIOCTQS3b1BPgAnjoPfAL1/9y3ad2FTqaIl2PxPanBs59PXYlCRmPPJ+SAh1JENyl3vWOIzwWvWLe4djlmDBdOjCx1NUFPkC6obiQxFCbUHHtHMWjzSNJqsad+tLvXn3SkomyK2L57IwgOWFFtdqtQvyY0Di1I5nJa7KPIFXvZovDY/uB9g4h0gpVIOBFufto7P+jhHPg87fvmebYrCTtEB3bN5WZTblooEua4NQ+ePqDQ4//t7odiIKohfyDf9VnsizF93NwDCmI6UBDAPMAtvEGK8GAX/on4iah7KhfJnswFAehZ7agRqcDhmsqeIGa0S4hW7NSF6h7hHAwiUd8X51f+y4LLcS3dNR
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2026 17:26:12.9427 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 25a09852-4a7b-49bf-4e2c-08defbbb785e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002529D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8201
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

This patch adds heavy-weight TLB flush after MES queue eviction/suspension
to fix SVM page migration hangs on gfx1151 with XNACK mode enabled.

v4:
  - Dropped userq TLB flush patch per Felix/Lijo feedback: TLB flush is only
    needed after batch unmap in amdgpu_userq_unmap_all(), not per-queue unmap

v3:
  - Split into 2 patches per Alex's review
  - Added userq TLB flush in amdgpu_userq_unmap_helper() (amdgpu_userq.c)

v2:
  - Removed "SDMA" from comment as this affects all in-flight memory
    accesses, not just SDMA (Felix Kuehling)
  - Added Reviewed-by tag

Priya Hosur (1):
  drm/amdkfd: Add TLB flush after MES queue eviction/suspension

 .../drm/amd/amdkfd/kfd_device_queue_manager.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

-- 
2.43.0

