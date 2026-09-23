Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1437CC98304
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Sep 2026 15:33:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 801A210E54B;
	Wed, 23 Sep 2026 15:33:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="CRkRW7kS";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012059.outbound.protection.outlook.com
 [40.93.195.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3990B10E54B
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Sep 2026 15:33:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LYAizkqN2VsypUvaa/90ZZXSBYRts/w8hEH+mEa0Lbl2KRWEOy7xXULniiK95n8rslL+fuARhjxjc63V7mcnHc7uG4mWTUpDLvi33Mynv+3jQvrqBAC6Qs6SAhlu/tOPmLpwFDODXhmtEd14dzUFzcI0S9t+dCrra41Qi++0ZJSCKro+G2feR7QHQ7T25ijVnGZGok+GIji1KXSnUbcpZmKL0LcjtryY+hqQzOyJ97WtnLiqc4BfB0//EuEOjx+SJAoufb63TgE46MhqVRwolf7SSNylgNTMZGrRHzn0l/L16FtqrVtRRBv0prIjMX55zMp9JmxQn5zWw+dq9pGC5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cyyUzKSveVtCZuv/bVqDU7aOgf8Ve04kWF6ixXSj1ro=;
 b=uv5Yy4pUm+o/qmEDH6f8M21x/IIl7yIxVcy0QdezkzHjNPvxjeELOfYxnIVcsZ+ktkFLI24sXtn2+2xGldj8RWtuveQPru0kG+RCzGYb6VRMlpbqlxNWDzpEluMEQzBzFY96crw8tejdm7LLYdQ/yg5WtgIWpys6y51qstSg0texK4Yr+61WN6fU+fiE+0oeyhA7fC0LshCxV8+IX77hI0Djo4JLVoig/UAnAaTdnLRgqObz4zrciGxzW+ZH6u24CZIOCF+u1yKp9Be1yolPpASHcayhVHTdu4mVQdSysje3ubJdPBNU1//eekAtovEFgzsNfq9PmpdXptWWeMcdUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cyyUzKSveVtCZuv/bVqDU7aOgf8Ve04kWF6ixXSj1ro=;
 b=CRkRW7kSxUNVgUPGI2eaCTftUIVkTguVf3Y7zFiSQ/8oBy+a4LpxkbWcG8hYmstsYASBV3Ttn8jBmkvrVvc7gl3UFglPuioNljW7AXlvaxexR9cooK3uPsK3i+B1Elg4jLCkEtkxJdj6nCFgeVmNyPxHRose+cyE0H5YhAIe+JU=
Received: from DS1P221CA0004.NAMP221.PROD.OUTLOOK.COM (2603:10b6:8:451::17) by
 IA0PPF89A593F05.namprd12.prod.outlook.com (2603:10b6:20f:fc04::bd8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.17; Wed, 23 Sep
 2026 15:33:14 +0000
Received: from BN2PEPF0000A805.namprd02.prod.outlook.com
 (2603:10b6:8:451:cafe::e) by DS1P221CA0004.outlook.office365.com
 (2603:10b6:8:451::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.16 via Frontend Transport; Wed,
 23 Sep 2026 15:33:12 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN2PEPF0000A805.mail.protection.outlook.com (10.167.245.169) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Wed, 23 Sep 2026 15:33:11 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 23 Sep
 2026 10:33:11 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Wed, 23 Sep 2026 10:33:11 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 0/2] LSDMA v8.0.1 support
Date: Wed, 23 Sep 2026 11:33:02 -0400
Message-ID: <20260923153303.2807340-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000A805:EE_|IA0PPF89A593F05:EE_
X-MS-Office365-Filtering-Correlation-Id: 048169c2-70cb-488d-8e79-08df1987fa23
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|82310400026|376014|23010399003|18002099003|11063799006|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info: +ZAC839dRptv29+2TNVUV8UCwU/EvwQOJrU3TtzQcgnt8hry7Lg8wtc5FqgTHwsnsrldDq14X4YoGFdFUGJoxtHPhPVsO4Q0I/d1EPzJM1ecPcA1iyeKTHSDuqpQCA2L59ryGu1NBEhVajRwjmWMioxd1O6IPx1nkvV8ny/j4FIqBYGuB8t9EHi6tCTgpwj001EG2Y8m6SZrv6wWY/g8HppuyL4OaZyFYTWmErOTLGB41uTenNElWdDsYdK9w4AjiWMkcp9MwmekjAjJo4mXFVYmLXmxOUA88BgPl14Pax2dypAHo8tFa1fPe2jVJfnNPi9ETX2elB6s17qVV1bvmX8EGNCma7Ou489oglv+nQDPhBPrZLKgBXm1ooi2OPbXHt6ezs1jIgaDflIXwR6HehP7H1M3ikg/6zLgLHs59cKSeo1nPyFD4Iz0nWsQm57fOw+928uvp1mc7pV97Sy5YX7wL0q+hnbqEOkhWwMmROtGluBkyY+adgr//lIBxH1sxgyXDYbuA5WDkTb8BSje8on9nq8nE1ZXdUv8+PrQovNd8qtEIcjpmxgY2LtWFkT3/kN++4Vz7WSS5VpZXXGIgoNmP9Xmr949NniaTojNEP99ZqztFtkD9sgs/qmJHv7Hd175+5n9l56qqPR7b5UePqqVUVoYccuHq9CxLAiKtHVL++KMA0pfKgonSxykvaPQh6cD5OGIZa4jrXew0DTdGw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(82310400026)(376014)(23010399003)(18002099003)(11063799006)(56012099006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: dmnh6wwgCPgsXftBYl5znEzYurzfLnMMri4Kxo3368P6VVPDrzjJ04F6VdYCWKo9nYNva5LcyT5CM2ZwA5I6nuyEnaDxDW7DLrqylIsg6nW8wsLPGZ9w9wZLaJI0RW/SSqix/pIBB1jrWEu5vm1gFkp8ahUaz9tKWNVziL9e5+0IPlvrBEV0xfM5Yui2NJ7reuD7vue9DE/QZURvNTxHCfnaM+wmwb6Ub+AhXMDjQ7DFoA2nW+y6TKAEM2RD6j+3k8h0fUpUcJuSRUI4gtxVdPjwst5DnaE32ElehSuFdV1Lrc9J7qsYX5uR1CXWhqnNCGrA0+KI1mnQzhZb4dBFkS6uJtIvrrsC/9wdsCV5AzM0VDeMfnwMDepMd5h4+esovIPhvhLsTYJ6OvE5sQyDsRT6FwSRu4nvbGx6tDqn5sXgfzeCkC0sJoe/rEizY4fU
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2026 15:33:11.7422 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 048169c2-70cb-488d-8e79-08df1987fa23
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF0000A805.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPF89A593F05
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

Add LSDMA v8.0.1 support.  First patch is register headers.
Skipping to avoid spamming the list.

v2: fix wait_pio_status() per Philip

Hawking Zhang (1):
  drm/amdgpu: Add lsdma v8_0_1 ip headers

Likun Gao (1):
  drm/amdgpu: add support for lsdma v8

 drivers/gpu/drm/amd/amdgpu/Makefile           |    2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c |    4 +
 drivers/gpu/drm/amd/amdgpu/lsdma_v8_0.c       |  138 ++
 drivers/gpu/drm/amd/amdgpu/lsdma_v8_0.h       |   31 +
 .../asic_reg/lsdma/lsdma_8_0_1_offset.h       |  385 +++++
 .../asic_reg/lsdma/lsdma_8_0_1_sh_mask.h      | 1399 +++++++++++++++++
 6 files changed, 1958 insertions(+), 1 deletion(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/lsdma_v8_0.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/lsdma_v8_0.h
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/lsdma/lsdma_8_0_1_offset.h
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/lsdma/lsdma_8_0_1_sh_mask.h

-- 
2.55.0

