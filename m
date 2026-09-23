Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD1C4C98312
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Sep 2026 15:12:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BC20E10E2DE;
	Wed, 23 Sep 2026 15:12:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="b+xsk/SQ";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011023.outbound.protection.outlook.com [52.101.57.23])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 124D110E2B8
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Sep 2026 15:12:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D6KjxQrP2h4PYiqLh5K4KSMvg5nLnqy4zb2OXTPqoXljMzYvm7ZNFcJvMmxENlTiRKpKyLy3wg7KNpDkyGq9n8GMQjsz2bezYZmYr19BVDJMZ+w0N+IL6XKoda3OHj62bWHnlvlj31R6/Emr65+ljoMC8bZz/84A/+rj1B3umdPz/K74EU6oLz/rqgZ5aJP138z43FFgrBjmT46rg1PHDnyWuXAItmQwVZLoIEijpNGGHn1xUvoR/L3+ereT8mWsdLQNRR6kAB/95VPtjb7eLPn/a3Dj3nh5EXSIJ7UYmbgVETqZxbfTHEFQRe3BISW3mhU1aGg9Rja7eo83eZ7dxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xmF7bpTVTJycZ8Nuih3J0z5Z1beIEUbX4pxvWKOB7NU=;
 b=DRWieFoPIzqP/POTvJsqTHZCwLuJzpgS3dg23WjaHlduHtZWWpAftOV2QXobBPbOHqVxLJZXWRdrniRmk6sFPTRsI6CIlUq8ueeChb65g5HQ7OxBy3hyI01/copuDKZSEfeRtsD+olKNZNCU3vQCzbOyXob/jkljuCI9gkPMr8W2WTOVSwxsp++CVfxdtK1l2H0nzQzl1Z+pdcVvN6/fj+yw6114wrI0I3C0IneqhSRnrNs7I36fNPPPA7yfL8AUULs8Aips18Tltav3pi+DcKqsdFS7vtTSwQGTij7Ckiby5//O8xjhDdDt98YtiikvKSf9gvC9gvSDX3eUdtLS9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xmF7bpTVTJycZ8Nuih3J0z5Z1beIEUbX4pxvWKOB7NU=;
 b=b+xsk/SQu9KfJ7qER7jrC8fBqYSK+4v2QqdtGkk7n9jHbxIVU+1J0t7sgGjs6ntLOZQDtf02OLBFJRVsLTp2qtZfW2lgUiH+y8AUI5QCfa1urxqg4tF86pAB7JVq8DZ3qnLsPdsaitMr1/UK9inCebNKB2P2vXUqje5Wkj9L7UA=
Received: from MW4PR03CA0205.namprd03.prod.outlook.com (2603:10b6:303:b8::30)
 by CY8PR12MB8299.namprd12.prod.outlook.com (2603:10b6:930:6c::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.17; Wed, 23 Sep
 2026 15:12:37 +0000
Received: from CO1PEPF000066E6.namprd05.prod.outlook.com
 (2603:10b6:303:b8:cafe::8d) by MW4PR03CA0205.outlook.office365.com
 (2603:10b6:303:b8::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.14 via Frontend Transport; Wed,
 23 Sep 2026 15:12:36 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF000066E6.mail.protection.outlook.com (10.167.249.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Wed, 23 Sep 2026 15:12:36 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 23 Sep
 2026 10:12:35 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Wed, 23 Sep 2026 10:12:35 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 00/12] PSP v15.0.3 Support
Date: Wed, 23 Sep 2026 11:12:15 -0400
Message-ID: <20260923151226.2778589-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066E6:EE_|CY8PR12MB8299:EE_
X-MS-Office365-Filtering-Correlation-Id: 34f2a6ab-7e87-4f62-02bc-08df19851a06
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|82310400026|376014|23010399003|6133799003|18002099003|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info: JJb7sqe0eB3bli8qxtks91JUuYUkkvJWBN3orINJpqIJj29+CxnpWxRjl9NjuWoEVv8j76L+MmVc1Vf5fTi3BUiEGI7Ya7MMaqbxuieysW8e7Rbv1E8CEln9FEkRjfhmF6LqeIb8y7ZnnYZO71CGOHPYu8wl5v0TV4AA+Oz6/rzNBKHKGPXVX+dTY7V0tKUS2pf1a8uxvHdlCGK6wxL/Y8RJFXwIjVaRQYtetCIFHdrkA0Ndpqwh96ADTHLLgM8a8+Y6PWNVcgiSLp2dAPczugf2J9avah2FlB7zhQAgp9wSJJ/uLGLRsQZ3+LlHxrUFlOWaY1E3SCkUiA+yVxlnsjuNqnLcAlHnHhsMf+MuBv2qFQMwwMyhIy0oozCszqHLZlkD7unn2p/QrlwhI0I7/CMF4XtPkGAhyfvlCkKXOl2RgoghxljBDhrB9++XjE/QSi8L2+tNXmBpvYkdD+oDO0Gkb07bffz/0818wo6hOOkDNGOuLSnDemcFcMknSglSjLnxVhFOTkj4dlYnP2LVejvFIJwA7M3/vWC1Gf3y2zN7JXfR0CDsmWWG818Pg+SPlf4jIUbtOmnE0Ch5234Lc2SfHwVMH7yeMu5geNH10wPyh0iV8OhoAeRRAbDt927VFs9Bu3rlrxgRH8DFfPIR73hNxWCJ2K2m9RtePS2ton7A6SATU4livV4eQbJxqWomGVQOTO9gbHQVVTJuhHsK7g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(82310400026)(376014)(23010399003)(6133799003)(18002099003)(56012099006)(11063799006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: DhjHdDoyYO17HB7zNSu91mkZC3G6IgLUE/aVVUQrjDLbZMqfIAEqREwFjGu2WN//pLyaujmUvVcQvg4yUD3CbTKvau0gun4+jz9K8/CFkjiid/RBD4f1578JjH+xFEPuKN1jELSnjRjWAIh6QthWE9rGOiOlaL3FofbcoI/SQx1mHv2SwrfqQIqPJ5AobU4SPS+QAryXnNbWeMH34QMZEvOD+FRECn7L9A17ViJzh4lxuEcgv4aC0gTC96vonW+HosveH2ljKmg9G0Hc7sd+z7lI3/SmZLDdrsIjElsW2InJ5asf74ST3zQLPbHR2VvcHKQN2K9LgUl7jI0mWqM1I63QcU13GCsbVJJiPbTSz9IVB7H+WW5oa8gRRZK8sWg+VElLPzviP0lp61oKB10Wru1vo+kvEgEwMgUGfrrId16bydr5hqm7E3upSXaZuv9a
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2026 15:12:36.6489 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 34f2a6ab-7e87-4f62-02bc-08df19851a06
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000066E6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8299
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

This series adds support for PSP v15.0.3.  The first patch adds new
register headers.  Skipped to avoid spamming the list.

Emily Deng (1):
  drm/amdgpu/psp: wait for TOS ready on all AIDs in v15_0_3 ring create

Frank Min (3):
  drm/amdgpu: Add support for PSP version 15.0.3
  drm/amdgpu: Add firmware type retrieval in PSP v15.0.3
  drm/amdgpu: add infrastructrure for handling mp5 firmware

Gangliang Xie (1):
  drm/amdgpu: add ta loading in psp v15_0_3

Hawking Zhang (1):
  drm/amdgpu: Add mp v15_0_3 ip headers v4

Lin Cao (3):
  drm/amdgpu: add new MEC2 firmware loading framework
  drm/amdgpu: Add GFX FW list to PSP_15_0_3 under SRIOV
  drm/amdgpu: Add VPE FW list to PSP_15_0_3 under SRIOV

Yang Wang (3):
  drm/amdgpu: fix ASP 15.0.3 runtime DB offset
  drm/amdgpu: expose MP5 firmware version in sysfs
  drm/amdgpu: support MP5 in firmware info queries

 drivers/gpu/drm/amd/amdgpu/Makefile           |    1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c |    4 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c       |    4 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c       |   12 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c       |   54 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h       |    2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c     |   32 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h     |    5 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c      |   25 +
 drivers/gpu/drm/amd/amdgpu/psp_gfx_if.h       |    5 +
 drivers/gpu/drm/amd/amdgpu/psp_v15_0_3.c      |  836 +++++++++
 drivers/gpu/drm/amd/amdgpu/psp_v15_0_3.h      |   32 +
 .../include/asic_reg/mp/mp_15_0_3_offset.h    | 1105 +++++++++++
 .../include/asic_reg/mp/mp_15_0_3_sh_mask.h   | 1646 +++++++++++++++++
 drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h       |    2 +
 include/uapi/drm/amdgpu_drm.h                 |    2 +
 16 files changed, 3766 insertions(+), 1 deletion(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/psp_v15_0_3.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/psp_v15_0_3.h
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/mp/mp_15_0_3_offset.h
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/mp/mp_15_0_3_sh_mask.h

-- 
2.55.0

