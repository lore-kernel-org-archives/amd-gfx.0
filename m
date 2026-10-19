Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C874ECCF2DE
	for <amd-gfx@archiver.kernel.org>; Mon, 19 Oct 2026 13:38:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 62E5F10E768;
	Mon, 19 Oct 2026 13:38:32 +0000 (UTC)
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010019.outbound.protection.outlook.com [52.101.61.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3AC3210E947
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Oct 2026 13:38:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MY9rdztX0IMNSvTovyi9Aai8VhMrFU23KYjmGzCMj339sn9HogScs2wiTD0QptwvIHnRP7RP2JOZpqj67Fhfisexp9FZDQIl6XE4a55I1ap6qTdEESZ6aC1EnZfH4L4UrL1/rMbTa58luPFqRUNYWm9ukKheuPzKBiPpzB+TK8qcPiOLuE7kXZVdKqbJwaH7teBmysLOgq1CdW6dhouLIqoGy210oVmNeMFel5D80OzCDXsI4Fy+9tTxP0z6BOPGznhjAihr7EgNItodMMEYi7JXSG30hjLSV1qRirr/G9U8AVEz9czbyXN032EhQXHr3nj5XZdoXm2hvtWkrTW9bA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5JbVrWmar/D933hjzGLOljE621uooRvpEFXYviEFt54=;
 b=k5xNL0f04K/+aORG4P3eCNuk3MAHSyP2WA4BlvJzKqqqGD7J+kryKinMK7HEEPtLuh0ufr234g2H4D9+ZAHnvVSeyburCtqwKFTvxMD2Tiwdo2NuT6jpTBsN2eV5xAs91vbnPlqINvt28X/7wyy23DX5lY4jgCiZ8jBV9/O4hm2dmo3mOn+r6Lfxl+4P2NaTNW9lKFSl37b8FR/PrLHA+hk92d0EDqpABxxQKmEEsTzaFTePDU7pHe6wWd5y435zJPlKBxy+EwPt52P/8RSdnookoxWKi28BqeOWHgRmgyfrmfWu69DUP4A2TCzIeihzor+R+oo1QG+TW3/EBFYbww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5JbVrWmar/D933hjzGLOljE621uooRvpEFXYviEFt54=;
 b=K+vZA0P0MHhDg1LQJydYYP7ExZGIXMI8EMWT9vJCHT/fpfzUptK/Q6YedwyLSLug6DjWQmbKrU+BSSR1pYMtV1m71Pm0roDY+ANgbb7CPMs/TvC9Nt/nUDwHsAKWCc36GUTiiS1NQxISYcf8i0CTP9fUJAocAb64kPRMBFDsy5k=
Received: from CH0PR04CA0007.namprd04.prod.outlook.com (2603:10b6:610:76::12)
 by SA5PPF8BD1FB094.namprd12.prod.outlook.com
 (2603:10b6:80f:fc04::8d3) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Mon, 19 Oct
 2026 13:38:09 +0000
Received: from CH1PEPF0000A348.namprd04.prod.outlook.com
 (2603:10b6:610:76:cafe::45) by CH0PR04CA0007.outlook.office365.com
 (2603:10b6:610:76::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.19 via Frontend Transport; Mon,
 19 Oct 2026 13:38:08 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000A348.mail.protection.outlook.com (10.167.244.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Mon, 19 Oct 2026 13:38:08 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Mon, 19 Oct
 2026 08:38:00 -0500
Received: from Xiaogang-ROCM-Dev.amd.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53
 via Frontend Transport; Mon, 19 Oct 2026 08:38:00 -0500
From: Xiaogang.Chen <xiaogang.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Xiaogang Chen <xiaogang.chen@amd.com>
Subject: [PATCH v3 0/3] drm/amdkfd: Enable device private memory THP support
 in kfd svm driver
Date: Mon, 19 Oct 2026 08:38:42 -0500
Message-ID: <20261019133845.166916-1-xiaogang.chen@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A348:EE_|SA5PPF8BD1FB094:EE_
X-MS-Office365-Filtering-Correlation-Id: f916bac9-f357-4e24-2b94-08df2de63625
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|36860700016|82310400026|56012099006|11063799006|261009223027099003|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info: HYXa4kutBu+JjmYjvc4WMBHBMrsAoNYeYV3JZ3jL73RHSBg/Pf7G3akDvMADj4jHJj4YPoBmVjXGs958H4+qDARSqVpR8mh66rq7aCVtelz/EexKn+IUuCHTaR7YDtMuDc8WNE5lcuew0FHiQg13zvZcpetiFb4qC+Id7pe99Xh780Vxch4RY91oB6zCWLJVBUMUHxqiPQjuS3SgITNFbXT1CTUSQ7t1rq6Uj0WzzX2QmL8am+GltDGIFgm2uE2aoFXe1gVHgW8s0SDOe4yYkIx5k7PrJGVIErEJrlGpL2YuWU7999ifJDs6/xWq5N1+6ysvDrJ8yzsuy4KxL7z72O/0CDr/wSUdRZ+76dpBbVtwwN3EnfTHaOitOK0mzXY5GoJyjxb+DCVLkB1eI9ftdXhb7ince061ZBWNjmbqYmWzgG2/Wmxf0GUNGCYPcD957OHzZeTsFjuVM+705/RG6xFrn56kgePVlCNUCmovbA4ivqiEIn4BeDJenzjBNK+ljv1Ie7Pzcv3My4mu468LduR5BJXIE7yp00nB5esCc+6/wkrU3eQUQ56Hemst2CZD4nmSZpbyTEjUEhlo7a5XhtC2BgAhgXFGx6G1pmu60lA/x5UiF75UnE30JP3YjEqCFNwK8rD5whNevhAUO+2l3gsw8+N3HSLrEPIuTyEnTvk=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(36860700016)(82310400026)(56012099006)(11063799006)(261009223027099003)(10067099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: m6iAOeRXZUQqXuf4DhWN/jPs8m3fUXG5/GOmOj/3Q5iGPEui0RMY/+dpuzw1UIUFcLDnWx383EyOdFtAsSgH3Jk7YGPK7cKadijmGLNcGMdzDMN5l2uZVMO1icS+G6mzRMHdsn4qGeef/lANAEHRKBd+uC6Jo8Ymg+DsuXIQTN3k73q0GE1ZGWOZHNL6o+Ad+EGZCZTooN3gXcq8O8zHTDE8+Pmn/8hTsWj0Hl3G3qtfbQav1h0SqqYvdgPssuGXAA9NsTvw8PBfsa6fXetj4b+b8aHy7+fqMhfjPqRYOuqF34w6ms9c+y1nW4sI9IDzSvsEnQNY1SKKScVff7bkm0JqoIVdu8HP9/WGCRfhx1ZH74cYlUb8NAWDFkfewpSuyIzNAOYnKGRauR9Pf+oN42wfO7+yqsqFIRPuux0RnOUh1aJmcFn/jQJSrKZuxpZ9
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2026 13:38:08.3439 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f916bac9-f357-4e24-2b94-08df2de63625
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000A348.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPF8BD1FB094
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

Add device private THP support to migration in kfd driver by using following
work [1]. The implementation enables efficient migration of large folios 
between system memory and device-private memory.

A benchmark test shows the migration speed got improved more than 5 times
comparing to current kfd/svm driver. 

[1]https://lore.kernel.org/linux-mm/20251001065707.920170-1-balbirs@nvidia.com/

v2:
- Reset is_large each 4K page iteration
- Unmap the THP DMA mapping once as DMA mapping, at its real size
- Leave migrate->dst[i] zero when the source is not migrating
- Count THP migrations as HPAGE_PMD_NR pages in prange->vram_pages
- Implement folio_split and hold one svm_bo ref per subpage

v3:
- Do not migrate partial THP memory at CPU/GPU page fault handler
- re-configure compound device folio after it is release from core HMM.
  So, it can be reused by ttm as 4K pages. 
- Remove SDMA page entry FLAG(9) setting at GART page table since 
  not see noticelbe perofmance change.
  
Xiaogang Chen (3):
  drm/amdkfd: Add awareness of THP of device and system RAM in kfd svm
    driver
  drm/amdkfd: Do not migrate partial THP memory at CPU/GPU page fault
    handler
  drm/amdkfd: Enable HMM device-private THP migration in KFD SVM driver

 drivers/gpu/drm/amd/amdkfd/kfd_migrate.c | 372 +++++++++++++++++++----
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c     | 119 +++++++-
 drivers/gpu/drm/amd/amdkfd/kfd_svm.h     |  13 +
 3 files changed, 435 insertions(+), 69 deletions(-)

-- 
2.34.1

