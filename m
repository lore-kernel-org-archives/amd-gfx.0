Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5665DC98318
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Sep 2026 17:57:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EE12410F6D8;
	Thu, 24 Sep 2026 17:57:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="YuakauKb";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010037.outbound.protection.outlook.com
 [40.93.198.37])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1B86110F6D8
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Sep 2026 17:57:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jEkHhZryv30o1e5Sx3Ft5WioP3HxueuKXus8Hr5UhXKbdlaQwlP/QwZ4sjP/e59pZ2ofvj5YrZw/uzmaKctx9/KVUBk5IYOAiz38WFvJbMPFM+CmtYg00udED+riy4dseWcqgAUYBuxp+78ynn0B6qZjyCtRk3zSH0RFtw1IOGUMV9MHl0W51f1NgyUfmbRoEMkeiaYLZuQLtRvoJrgn1VVQaXR/JMJ/UIk91kInNQxBsTrJDCi9tc3eOJmubEl3N3tEdv+20shblDVT8B5/RWVrLuOJsFAQgI2v5BEMvQNyM/RWA7XvSY20810Nw46AYZUGFBzQiJ5rmBrJ3dRY8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OQw9GBydTJ/zijM/UTaSs+FZ83KMXa+R9GXBE6upUkY=;
 b=fmTEZyuezI45AEyqwc1kCmpFXUB7P+GdHqFt0v5neNVmF1zeYrnrMw8qmt2ZkS3+X2HQDpkMFuEmMPyz7NxhxTRXyum3WKwBzWywEQmWrMIRGT4ciDGK+qgwW8qN5oW4lFJnOHAbwiJlXuozSM+THE/UnZw+uKlPTKg6adurRFvyYRB0CgAIDxEMKwOgsQFaaYHEXaCW1TFUzSGzeUBTV9OhKf4MYi2pYJxA9wUDSYht7jGpyPtqHruWORqXv2e6/wGm8oIggK26gnmkzqsEbFv1DFXYBANbRuWzaGZfzo07PFw25wdI81bjlYon0KX2MgmNRRozS85YYNpupdhOCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OQw9GBydTJ/zijM/UTaSs+FZ83KMXa+R9GXBE6upUkY=;
 b=YuakauKbSW8Lwdzvu1YX5NtNrnBkFDppUKCEteleAi+A3wj7nP7CKkrcBujuYRQPIC+3BgB/ZFjrpxEoG1rf5ZJ+EOBjHZ1FvuqExBEM3rnOGoCXLj2BNGs09tCUJbNwxV2TQZ10MhczzvhoTqF7G3+0FzawFuKEhv2ZhxThNhM=
Received: from PH2PEPF00003848.namprd17.prod.outlook.com (2603:10b6:518:1::65)
 by LV2PR12MB5848.namprd12.prod.outlook.com (2603:10b6:408:173::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Thu, 24 Sep
 2026 17:57:23 +0000
Received: from SJ1PEPF00001CE9.namprd03.prod.outlook.com
 (2a01:111:f403:c902::11) by PH2PEPF00003848.outlook.office365.com
 (2603:1036:903:48::3) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.11 via Frontend Transport; Thu,
 24 Sep 2026 17:57:22 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ1PEPF00001CE9.mail.protection.outlook.com (10.167.242.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Thu, 24 Sep 2026 17:57:21 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 24 Sep
 2026 12:57:11 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Thu, 24 Sep 2026 12:57:11 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 0/2] MMHUB 5.0 Support
Date: Thu, 24 Sep 2026 13:56:55 -0400
Message-ID: <20260924175656.636354-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE9:EE_|LV2PR12MB5848:EE_
X-MS-Office365-Filtering-Correlation-Id: 992b82a5-be5f-491a-cf64-08df1a654849
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|23010399003|36860700016|376014|1800799024|10067099003|56012099006|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info: 4aQImLMCS/EIwwlUL9iTgJAKMpdT8UrUEc7uuRDWLz7iIFcnul8yi5pqPsJbwve1SCku5sJCw/YpVkEsyYEaIbfKb/j2DzjopZOffHsfSMez4g+pZjkUJG8N+qdPGpUClGrnv4aXyAgrv70iJpEPb3NcbPqrovsbBFQB4sll3rI/LJYX1lV+JCM6F5G6iyWe8aXRG5zaS1g73LEmg8mFdHKnnDWjUMQlY+xxtqtEFfQ4UEvKtyhMPjEneIhlYVo9dHimNLgdZMb4A7311K85sWWpRL1oLDGrlbCAO044b4ShqPcaA15z4LZ7h+A7xCON+OAfMmhSTg89lPdvUPCJSAxoUQZ3K4xIEGoo9LgqCGS1diLsXbYzJ+DlUhiNMTlRrnJjh65EhIoXXvELL3Oov4mfDWEZzucvQ3mZ2fEXSN+ZgH6ZmS87U4sIEsbmYk6Hip8k1CYPVghqWnhOCuWLdrgBeYa+/AbSBdIfUEyMQomB9uh35+6YxI0pzVWgQIMttPDXuVm4JErSlCGYyRWi/euMYg8j+FGLWXBpSWGflNgqfqXqJERLwHHp/DsdeO8EeU5/OMffejMLjDyu5HX7bi6f7cowPWVNvtGFofTAuAiw1UpuYWVM7RiRb4pcazPXBK+lPhlahDqf2vJ7TsnJoQtN8161qbe+PPMf/0FMDjkxIvgY6APyCUJxqccNtKuADR46DGgv1Tp+lhNATQA7eQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(23010399003)(36860700016)(376014)(1800799024)(10067099003)(56012099006)(18002099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ocVeCNK/r+N6o4g5v8ftxMEPxDi+K3mfv9W6ipeY+FqhBxjFnPw02NSoX3hQ6kEZ7O5zkflnviQ+dZIWMZsKjeDze09sjbtbFpN+CuLptcP2SUitm2l3u6QXxdtkWE+KU+lycEqD3BFYY/ACjKNgg5WVoEjRwRsDSi7BGXML4jyUd31ynxqF3zYq+E1LyiFmhIwMzKyUno0bftOGvyOjJeSANxh4c5DP13DwyJu9pr7Q4O0hpyaZZzIeX2Lqimc9tOoHsomuYjdCzmWuhG0YwWx0JcgI0iwc3Sc2lMfTqCyU2Y4qnv2hxnO3VoXt0QUCdFqRor4k8Di5aQ+bhkVv4MUqS5meJQpdEvseqrTbya1PVGXx21EgsWKYHnpfXEBXhIhBboHdxHWz03fkGUZ1q6RSo1P4ixeqfADf1BJVapa8vF5Nw7omtQfgJjosB47d
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2026 17:57:21.5432 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 992b82a5-be5f-491a-cf64-08df1a654849
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CE9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5848
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

Add support for MMHUB 5.0.  First patch just adds
new register headers.  Skipped to avoid spamming the list.

Alex Deucher (1):
  drm/amdgpu: Add mmhub v5_0_1 ip headers v3

Hawking Zhang (1):
  drm/amdgpu: Add mmhub v5_0 support

 drivers/gpu/drm/amd/amdgpu/Makefile           |    2 +-
 drivers/gpu/drm/amd/amdgpu/mmhub_v5_0.c       |  603 ++
 drivers/gpu/drm/amd/amdgpu/mmhub_v5_0.h       |   28 +
 .../asic_reg/mmhub/mmhub_5_0_1_offset.h       | 1494 +++-
 .../asic_reg/mmhub/mmhub_5_0_1_sh_mask.h      | 7489 ++++++++++++++++-
 5 files changed, 9607 insertions(+), 9 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/mmhub_v5_0.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/mmhub_v5_0.h

-- 
2.55.0

