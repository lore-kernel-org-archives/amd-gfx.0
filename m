Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFD48D68BE1
	for <amd-gfx@archiver.kernel.org>; Sat, 16 Nov 2024 04:45:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E755410E197;
	Sat, 16 Nov 2024 04:45:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="V4gWcW/j";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2074.outbound.protection.outlook.com [40.107.212.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1DBE110E197
 for <amd-gfx@lists.freedesktop.org>; Sat, 16 Nov 2024 04:45:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xKeDFREpOMrJcSs8TYwlRRjRJIaOLEZc/IoaFFUwIgQ5EZN8lPPxfSS9Fg275IQ5npvNcHffZCCd5qBW+/TC6rPRR7MWXpNBnyiXwqmzICN3hc/QkOE6BPfIKCEoELvFgN+ryjntdAfqxnss/zTMSX3mcgy2z4ZaAIt4fYiC95n7Q18E/D/r8a1qF2HGPXc5haplr9c+0Bqm7/pTD0qJm+ODfI+fcBiMcPQ4KN1Z1wrvTJBmo/sibotuh4cMcXAPJQyEiOszYsb1Bl5RRj6ewraSryUmpI79i6B9d85ceB+ywC+OcibloMWZbStiic6lyhKHMaZr7/eCc52N4TBMjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=REDRM4il7njBYyjDe36b/nf90ILcqKIJn2qlcJTUMRk=;
 b=vpw1N54k94Lq4tqRUF54fa0Xf/VL8dwiKLlHMLuOCwlr9TrXOBo2t5PxK9D2ljiOrz0buAFSB76KGdn4ilHyoHKA4CJBRiDIWj9AgtN/cRt5gfFIHZhQ3SYpsbBZvAbXHjLvkCi/X36oDnL8SSA5hHw1/mDCdyflOYb8bYDFlzFDEiTsBzEuAmhXcYKWhNAYKzKXAJmTbnfTFfEc+MqUjiWSPJI9wDF9sjCdzDihZ85H1WCqnC74ei9BlI0+Jri1Vi/aZZR5QuxxRgLze09nhbLCsOtB4Eb+10eV3eIs6Pz/aopiZ6YOLA2d7uZH0bMs/giXsNPDRcyekIgNCvxVMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=REDRM4il7njBYyjDe36b/nf90ILcqKIJn2qlcJTUMRk=;
 b=V4gWcW/jBTX3/e3gCMiGAE9SwrYTMM8w/v4p8yEPcA8Q4yz1JGzqRUT1hJjjEhVfRpyysZcj+x8AJF1anMGhH9NTVe99w9Rur8E3KzbkRYDnOl4gek++Gifs8U+rWXq4Jaw1YgWDKCpY2ltKpipupISY8tH5OGOwbBvwPflPxrI=
Received: from SJ0PR03CA0386.namprd03.prod.outlook.com (2603:10b6:a03:3a1::31)
 by IA0PR12MB7673.namprd12.prod.outlook.com (2603:10b6:208:435::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.19; Sat, 16 Nov
 2024 04:45:13 +0000
Received: from SJ5PEPF000001F1.namprd05.prod.outlook.com
 (2603:10b6:a03:3a1:cafe::7) by SJ0PR03CA0386.outlook.office365.com
 (2603:10b6:a03:3a1::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.18 via Frontend
 Transport; Sat, 16 Nov 2024 04:45:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SJ5PEPF000001F1.mail.protection.outlook.com (10.167.242.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.14 via Frontend Transport; Sat, 16 Nov 2024 04:45:12 +0000
Received: from MKM-L10-YUNXIA9.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 15 Nov
 2024 22:45:10 -0600
From: Yunxiang Li <Yunxiang.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <tvrtko.ursulin@igalia.com>
CC: <Alexander.Deucher@amd.com>, Yunxiang Li <Yunxiang.Li@amd.com>
Subject: [PATCH v8 0/5] rework bo mem stats tracking
Date: Fri, 15 Nov 2024 23:44:47 -0500
Message-ID: <20241116044452.5925-1-Yunxiang.Li@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F1:EE_|IA0PR12MB7673:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d2321da-610f-45c9-88a3-08dd05f9750d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aVpvZFlxRGdRd2l6a1pDODZuYUVUc0lERlM2OVhjeCtEblJhYkJkTWoxT1N3?=
 =?utf-8?B?ZTZTcmRqamVhYmtmZDNTc1lkc1VZMjFsdmJRa25EaU1IVGpwR210eWJMbVQ1?=
 =?utf-8?B?M0R0cTNMSTBVcDl3dmNGZ3BUYXVYcHorLzQ3SDE2d29FZjhkK2V1d1RTNkVK?=
 =?utf-8?B?RkllQUVxNWlEWGMwdWFPalphYVI2TUo4U3FvRVZUUi83UitYUmwzZzhicEJs?=
 =?utf-8?B?WW45ZXZxUXVsL0h6S3FaTFpLVlArNUN0bk9SYUMxRTJkNjdBTUtmUUxPTXVu?=
 =?utf-8?B?eXVFKzFyb0Fqd2xGNFJqa2M4U1d2UWRaV1BDWjFvaUhldkEvUzgrZ0JkT3hu?=
 =?utf-8?B?Y01DQWtkRm9tMytPamZjNWxrdUt3Q2RkNHU5RGkrK0EyZ3UrVlpESE5LWWxS?=
 =?utf-8?B?dmRpU2VZWFNOU0l3dWw2d0tjOE5MMGdUaFFvSjhBckJSZ2hyVVdSWit4WjdC?=
 =?utf-8?B?ZWVOQ2FJTklQRXNNK3c1aGo4cUtVVlRIaWFwSkkwRCsvTS9qVzJGaEo2aEp3?=
 =?utf-8?B?WVdnY3lVQ2VNbTdrUFU0MGlvMGdwdXNvMmRrNXJpSXhGTGxMSjJpQkttN3pP?=
 =?utf-8?B?Z0xLc2hrMlNPU3ZnL3AxRGNHT0Q1bUZseVV3T28xcnBHYUcxNk9QZmNJSElt?=
 =?utf-8?B?b3J2SzlRMXdqWEdlYXJVc3k4MlUrc0RIR2svMkp6amdibG0xMU1GY3BkSnda?=
 =?utf-8?B?NWJtTUl2eStIY2VXSTdHL3FqN1ZvRUw5bk1iQjJzcHhETXk3TWFWa0s5K2pT?=
 =?utf-8?B?YnBBTndYUU01Um9HdDdUVWdGcGQza3ZSNmFmeDdybWRiY1F4TWU4U3lDbUR0?=
 =?utf-8?B?WUhNZFcyNTh2VVp4NGJ0bFFZWjFNVmhXa3ZNQmhwNFRPZGFPbkMyemxLVkcy?=
 =?utf-8?B?RXZFUkVkSkkyTlZDMzRjazRGNkNReW91QmYwMU0zbHBTQWVIT0IvK1owZGZt?=
 =?utf-8?B?RVRxcTZYWTBLcnNjc3dIYXNkNXpYUzkyRDJHMUxkQXB0bTJ5cWV2MG5VeC95?=
 =?utf-8?B?OFQrYjI3V2lDSW93Q1dGblVWYVNJVGxUS3ZHMU4ycnZManEvSFA2NEpOVHJN?=
 =?utf-8?B?cnRhWnJlQ0xod0VrMUdqR0VJRXdIQW1jc0p3MTlkby9FRXg1R3MyS3R5TTIz?=
 =?utf-8?B?aVpiL054NGRudDFvcWRRQitaenBGYVp0UFp3dEtvdnpUdDBLbHkvcUJDakNz?=
 =?utf-8?B?K1c0Q1VqeW9zVGlWY3BBelljUlNrZXBhTkVzcTNuKzdhekNtR2k3bE5YYmo1?=
 =?utf-8?B?SUdZdjluWkU5TGFyRTErQ0RkQVkzY0xWNlNxQ2l5bU1kNDA3NGJsNnY5Y1ox?=
 =?utf-8?B?RW1mbG91SXBBN0wwY3RycnlhbE5aMFlzeVI3eDI1NTV6bG5jeFozOVZjRTlT?=
 =?utf-8?B?NWt0VkpBeFFPclNUR0htN2x2dzZlb2VTVEFweFpvRzVaYUc4MG0vS1pBVGlU?=
 =?utf-8?B?cGlIZnc5U3B1ZE5YeCtFcDk1UWFFRVhRK0RUL3YvZmQ5L0Fpei9VYWNWcDdO?=
 =?utf-8?B?NkVCcVUwbktkbDBaMVJPU2ltMVBWZndyVVk0UVhpRGN3ZnEwQ1F1cHNpTEdT?=
 =?utf-8?B?Y3FrRWlSWFFGQzIvcVBSODdzUTBBcmJ5MmQ4VVJ6ZXk3a21rbldOYjdkQzZW?=
 =?utf-8?B?MWVjVFlhdStNNTdvTnhqTDROSG9wZnYzVzRmemdrWlJmTGd6VmtYM1cra0d4?=
 =?utf-8?B?R2NkRG5HUFhqendpODZML2N2ZXhnRVNlUGduSFJ5VXFlSVJTVDA2eWVRWGZR?=
 =?utf-8?B?T29lblFKc2tWU2h1Qk1YN0tCV2xaWHNadUErbUtDaklhcUNjbkFBTXBFT3lq?=
 =?utf-8?B?ZExvWWdOS2RoZytlVEFRVjkyTjdYamRYTDF0SzVzUG5xVU9sVUlZWFVjVlB5?=
 =?utf-8?B?WGtRYmZBdHR4MFFldlZ3eE4vdWJaNlQySGtmcFFYUUpPT1E9PQ==?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2024 04:45:12.3576 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d2321da-610f-45c9-88a3-08dd05f9750d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001F1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7673
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
v8: clearify documentation, minor tweaks, and some bug fixes found
during testing

Yunxiang Li (5):
  drm: add drm_memory_stats_is_zero
  drm: make drm-active- stats optional
  Documentation/gpu: Clarify drm memory stats definition
  drm/amdgpu: remove unused function parameter
  drm/amdgpu: track bo memory stats at runtime

 Documentation/gpu/drm-usage-stats.rst       |  36 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c      |   4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c |  17 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c  |  17 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c     |   3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c  | 111 +++++-------
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.h  |   4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h     |   4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c      | 179 ++++++++++++++------
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h      |  20 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c   |   1 +
 drivers/gpu/drm/drm_file.c                  |  23 ++-
 drivers/gpu/drm/i915/i915_drm_client.c      |   1 +
 drivers/gpu/drm/xe/xe_drm_client.c          |   1 +
 include/drm/drm_file.h                      |   1 +
 include/drm/drm_gem.h                       |  14 +-
 16 files changed, 254 insertions(+), 182 deletions(-)

-- 
2.34.1

