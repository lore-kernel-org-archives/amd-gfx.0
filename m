Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D566D12D46
	for <amd-gfx@archiver.kernel.org>; Sun, 10 Nov 2024 15:42:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B723310E2D1;
	Sun, 10 Nov 2024 15:42:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="i2RxWXkf";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2062.outbound.protection.outlook.com [40.107.95.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CF52710E042
 for <amd-gfx@lists.freedesktop.org>; Sun, 10 Nov 2024 15:42:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UpBIhCVK9OoeO1XcXCADw47em+1vZhbv4WlUrFAcuznjqUtg9G5IB9PgeuhftfIKEpWTlGPorZP7OTFrW7PAt7JuEjGibSQOzx5oUWGWUWRnWGHC64VOg02C8tpuUs8U7nM18uPNIEb/F/tFHRY2W8prFCEVv7CJ6EkU95vVV0Ca2+8dncsUQSmDgHk9MNoJDorT32zR4iMCHrLwaYgVs5cVC8LRXRaS+SxTFIDZEr9oa1dAQ6S14N7IVpRa+5OslP0fFlQE06jhsL+AohreJaWzXrLPgKX1L1rFZwOj69n1hMvR3z75svFVh11ZTlwFELvILQRuO1rhybURNMT0oA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LAFuTJ38B2h6fm00OmNcqqct2U3LP/O42nEvWuuYBGc=;
 b=CrZtrOxVpl0FrHsgQt56tR5Y6zTiLSxUN0L/szQKyuBnhPBGrP4oloRqkU0fveBzqicNIWItqtfXgIHuTgvjTxdCztc/ctfoDdXiP0peugVIfz3VbVbvqzX/HyalUKtPLSFdy04ysVhXtKZIRxCnV3rrSEX7P6tO7/BfvMYc9x0VkK70PbuLuh60x+YasfzwUOQ1rYI1eaHc6h+QN4FrrmthGoGuWdzpNz/tlZknEFPNmIpbufgNcb91L9EqnatT2z18g3V1G2l9c+JqdW12RV196v6UBO83UaDYng+utG/t8HO+WS7bpb1+1Dk9MhT/nBmDdZIdLee7/ry0+cDYjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LAFuTJ38B2h6fm00OmNcqqct2U3LP/O42nEvWuuYBGc=;
 b=i2RxWXkftGTrn88JKi9zL9QZ7ar9BhBsC7pT3boCJMx+U6Ciyd8EQ3HTDvCR3LcTaPC1v5OdMUC43f9ZBdujMyUeBKiCJRsxeo3tZ9z0HJUe60GGCN1m/ObVPUZso4ffIrxqWSlEhzqRsoJyoblqeEIplSQfrzTGfh1rQYb3a/4=
Received: from CH2PR14CA0011.namprd14.prod.outlook.com (2603:10b6:610:60::21)
 by IA0PR12MB7626.namprd12.prod.outlook.com (2603:10b6:208:438::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.28; Sun, 10 Nov
 2024 15:42:25 +0000
Received: from CH1PEPF0000AD75.namprd04.prod.outlook.com
 (2603:10b6:610:60:cafe::c7) by CH2PR14CA0011.outlook.office365.com
 (2603:10b6:610:60::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.27 via Frontend
 Transport; Sun, 10 Nov 2024 15:42:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD75.mail.protection.outlook.com (10.167.244.54) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.14 via Frontend Transport; Sun, 10 Nov 2024 15:42:24 +0000
Received: from MKM-L10-YUNXIA9.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 10 Nov
 2024 09:42:23 -0600
From: Yunxiang Li <Yunxiang.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <tvrtko.ursulin@igalia.com>
CC: <Alexander.Deucher@amd.com>, Yunxiang Li <Yunxiang.Li@amd.com>
Subject: [PATCH v7 0/4] rework bo mem stats tracking
Date: Sun, 10 Nov 2024 10:41:48 -0500
Message-ID: <20241110154152.592-1-Yunxiang.Li@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD75:EE_|IA0PR12MB7626:EE_
X-MS-Office365-Filtering-Correlation-Id: 8dba0b59-b4bd-4877-bfbb-08dd019e460c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UmZtSGxZNEZsYS9zZjk2UXdwVStQSlR5VlphcHc5eWYzbWt4czBST3BkeE5S?=
 =?utf-8?B?Nm45OGJMZDc2Q00yVXdreGxPMmRxQnRHSktOR0NHQTVDSjhWcTdNQ2JGN3Zn?=
 =?utf-8?B?WkV3aUNHK3NsL2F5cXM0TGpockNPNjczbVpLOGFmZFEwTndsUGZBNzNMekwr?=
 =?utf-8?B?cStJOWhZNlhhaENBek9id1ZOdzhMRUsySHllb01GNDYvL1lmczlNdVpWMzdo?=
 =?utf-8?B?MUVDWjIxa0YzdENWWG9vNmNnUmtBaE8wSmRzSGpyNzFtNSs2WjMybVIyT0ha?=
 =?utf-8?B?dVBLT0M2T0pBWkFQU3IvTzA5UkQvUVdVQ0NYcWhDaEQydW5lUXVUSS9sZ1Rh?=
 =?utf-8?B?YTc3YWdPZzI0K290bldRWDlsVWh1VlQzOHh0dU1YWUdvN2gvNVkzZFErdlV4?=
 =?utf-8?B?RWVQeWp6NE9TSGozVHhvOUovb2loeGk5bTE2cVgra2FMMVI3THE1Z2lWc2xt?=
 =?utf-8?B?WUFqcUtnQjZNUjYwbk14bloyOHFaZHIzQlZMQXNnRHIxZVhUSW5za3c0a0pF?=
 =?utf-8?B?QWVQQkpJV2Jhb3JpQ0RMTUNPQzRzajNRbTBjTHp1cUNHTUpNUjQwaFBBbGRH?=
 =?utf-8?B?OTUvSm5CZzVLem9ZOVQ3eE14ZSt5Wko3RFVYcE02Tzl6RUdRSno5N2xRZHhq?=
 =?utf-8?B?Nlp2OE5CeEhwZkF6b3hKNWt6dUlPdGlrRyt4SDBiVTk4QjlmNGw4aDU4b3dK?=
 =?utf-8?B?bzRjc3Q0Y3pOcWphRzhuaHI3RTFQdFJLN0JjMldKOGRFaEZUT2R5aEhqV01q?=
 =?utf-8?B?SlQwUTNKSFJVbmZjUFg0S3dRUUh3T3k2eStLQzVvZ054dkZIVXU1MlQ4REZQ?=
 =?utf-8?B?a2c4VVg3Q2hxL3VyN0U3U0xzMi8yRnNvcDhvclRxMmpuYXN6YkNjdzJ6SEZG?=
 =?utf-8?B?VnA4cEtWclJSOXpaeldSenBOVjFGRjdRK0E3UTZJRGEvTjkzWmRselhESkNS?=
 =?utf-8?B?Q1lrb2xkbm8xbFc2SnN3RUZzSkZsc3BKV1lnRmNraitENlVRL2RsbU5HTGdh?=
 =?utf-8?B?bUROclNzaGVmbXZuTEdhM2d6WlpuejdTVmROcmIxckMwY256QmdZZUdTbW5B?=
 =?utf-8?B?WlJrKzB2MmNvTU9NbmE4MFBITEhBSGozL20rTWVOekxueFRHelFKMlVKZThH?=
 =?utf-8?B?c2JtMDlpQWpLa0UvdElYZ2NTY2MycU5LaFNLK1JFU1JuVXdoWmZaaW92a2VT?=
 =?utf-8?B?NEo4dzh3U2VCLzFBU2E4bW5KOENvTjh2NzllN1BtMWIzY2xLSmNsOWp6RXIr?=
 =?utf-8?B?YWtMSDRpZWc4RWtGLzlNRHQrUE5kVmJrN0ViRkRpQXg5VS9GSHVWYnVGWnFo?=
 =?utf-8?B?OUFtdmpabTJ1R0RWbWpnNldSOVo5OWpNb29NMnJtN25hSGN2d2MzTVdhZ1pp?=
 =?utf-8?B?Nno2Y2p3TGZ6OXlVcE1SaUo1N1VOMGJwWlFmKzUraGdiRjdOVk5QV3cyTndC?=
 =?utf-8?B?NzdwZEJ1WFVFNFpxR0VhL09mZllpbWxMcVpJaUJXNGZLcEZwa0dERE1Bd1g4?=
 =?utf-8?B?YUhhRHR2cHJaS3FodXRRMGhCaTlCaVgycWNnN0VCZkZxTmoxTWpWZGZKSW5V?=
 =?utf-8?B?cmJ1SHpVMitzWkhKZVB4bWV5dWhDWGVKcWNnd2JuYmlrQWlKZjgwZWZCaVRt?=
 =?utf-8?B?OXJ5TzQwWnhVcy92U3Jla1RiNXpJSUkyMVpSZCtUSGs3dWF0cHhJQkJpaSt3?=
 =?utf-8?B?UlBHb0ZNUVZFeTV3WndKNVdyNGplRTd1VVRObGloZHNmVUM1KzFKZXJOZWZJ?=
 =?utf-8?B?R3RKdWdiWjdYcC9UQ3Qzd1RwVkZrYjh5Um1mVS9CeDBaRjJjK2YxemtBMXh3?=
 =?utf-8?B?dENITkx2NXZYZW5yeGUvbTB5R3ZLZHZoYjZLalAvWkpRRE1KSVIxbVdGUkQ3?=
 =?utf-8?B?ektQcGdjb2YvQ0kvdVBvS1kwREhkTzR4RUdLdEFBRDFzVlE9PQ==?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2024 15:42:24.7398 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8dba0b59-b4bd-4877-bfbb-08dd019e460c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD75.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7626
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

Right now every time the fdinfo is read, we go through the vm lists and
lock all the BOs to calcuate the statistics. This causes a lot of lock
contention when the VM is actively used. It gets worse if there is a lot
of shared BOs or if there's a lot of submissions. We have seen
submissions lock-up for seconds due to fdinfo for some workload.
Therefore, rework the implementation to track the BOs as they get moved
around.

The amd-only visible memory stat is removed to simplify implementation,
it's unclear how useful this stat is since kernel map/unmap BOs whenever
it wants to and on a modern system all of VRAM can be mapped if needed.

v5: rebase on top of the drm_print_memory_stats refactor
v6: split the drm changes into a seperate patch for drm-devel review,
fix handling of drm-total- vs drm-resident- and handle drm-purgable-.
v7: make drm-active- optional


Yunxiang Li (4):
  drm: add drm_memory_stats_is_zero
  drm: make drm-active- stats optional
  drm/amdgpu: remove unused function parameter
  drm/amdgpu: track bo memory stats at runtime

 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c      |   4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c |  17 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c  |  10 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c     |   3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c  |  99 +++-------
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.h  |   5 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h     |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c      | 197 +++++++++++++++-----
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h      |  18 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c   |   1 +
 drivers/gpu/drm/drm_file.c                  |  23 ++-
 drivers/gpu/drm/i915/i915_drm_client.c      |   1 +
 drivers/gpu/drm/xe/xe_drm_client.c          |   1 +
 include/drm/drm_file.h                      |   1 +
 include/drm/drm_gem.h                       |  14 +-
 15 files changed, 241 insertions(+), 155 deletions(-)

-- 
2.34.1

