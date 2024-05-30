Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D88DBC25B74
	for <amd-gfx@archiver.kernel.org>; Thu, 30 May 2024 21:48:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4E17D10E1CB;
	Thu, 30 May 2024 21:48:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="DAcQ8+PL";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2052.outbound.protection.outlook.com [40.107.94.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8F018112E30
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 May 2024 21:48:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UZFgzGwMU+PGBKUwX7hxNuercEzl7xaJqLyHa0lDDzBlFZJWe04gsPyoW5AJSHH6p2v1EtpPxREoaW/9vTHe4Fv6H+FT9YQWAm9pUW/nZz91/nr3T8hDAVa4fgovQZ8lEAchdjTeY2quEUtLrpTB+7Dj3i8Zxuszy+EeQQYv9lWC5mPLLV/kzRcXd4wtHwp/Um3IHTzW1dHHHosJoXFZaAqpUL5L7pK13ctwhDERHHL38BNvtLZ+j3Vn93QLeTCIsxIvIJ4BsQW1yN9QJIoLqlCZsCmegtjTx1bYQl/df6HgL0nb7cWzyjQBtHhCZ5nR2aU3gBxV2RY8oG3Qhd9VyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rjv/YCosaME3e0cM2PkHKRx6jPcQJszC8iAhFWcU3Yg=;
 b=Go8T4nHpW/chnVvR8qeVzo6D0DVliHGeOPgGADOo6juwYvvFd8qbw3bOJVlmNJcPvAfoLLi8ECSh3hKhE9BWIPHQR3bYFp2/pcS9cUBX1fwy3DO2ftvWaLrYoY0FYq8/9+iCOGxYEzDm+DQN2EFK674/LBXjNL0crc97lYsgGTBWbdFnUSRw29u6NtEXv+1tMW18eMw3XRXpFV+Al1EEdrsj2ASzFD9zzr2O+hoayke19G7KKxAd/7BdhacRa1X84FftnwlrsCpk5c0n77i+ml9qWGyY/HRu6lCppkRQs9ACQl9BIzoZKgPkg2SVypb581Xqa2mymUvN49Uqb7WHyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rjv/YCosaME3e0cM2PkHKRx6jPcQJszC8iAhFWcU3Yg=;
 b=DAcQ8+PLZtIsng/CTHldeQzqYd06gWY6zJUUte87nO+J/piQMlXXzwtP+6+UDmue++jtg7xAJEr2MdkwgM4M6a3BQufdzbmS1FQTkArkEJDFibNzCxxTPFczzyny4anT3WEu3xSrgwYJDsxHdIv/NWyVfExvXI5v7icVz9MBdKY=
Received: from SA0PR11CA0142.namprd11.prod.outlook.com (2603:10b6:806:131::27)
 by BL3PR12MB9049.namprd12.prod.outlook.com (2603:10b6:208:3b8::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.30; Thu, 30 May
 2024 21:48:27 +0000
Received: from SN1PEPF000397B1.namprd05.prod.outlook.com
 (2603:10b6:806:131:cafe::ea) by SA0PR11CA0142.outlook.office365.com
 (2603:10b6:806:131::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.30 via Frontend
 Transport; Thu, 30 May 2024 21:48:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000397B1.mail.protection.outlook.com (10.167.248.55) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Thu, 30 May 2024 21:48:24 +0000
Received: from MKM-L10-YUNXIA9.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 30 May
 2024 16:48:23 -0500
From: Yunxiang Li <Yunxiang.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <christian.koenig@amd.com>, Yunxiang Li
 <Yunxiang.Li@amd.com>
Subject: [PATCH v3 0/8] drm/amdgpu: prevent concurrent GPU access during reset
Date: Thu, 30 May 2024 17:47:57 -0400
Message-ID: <20240530214805.40970-1-Yunxiang.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240528172340.34517-1-Yunxiang.Li@amd.com>
References: <20240528172340.34517-1-Yunxiang.Li@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B1:EE_|BL3PR12MB9049:EE_
X-MS-Office365-Filtering-Correlation-Id: 212a0b9c-0102-4d18-fbfa-08dc80f23b3e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|36860700004|376005|1800799015|82310400017; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UXZZbkFiZGNBVE9XZHY4OU5abWhaaVBjUUlIRzE0eGpWT0UveldrMWw3VjIx?=
 =?utf-8?B?TTJaTUVRNEdRYTkwM3VkQ09aYzFBZ20vRjJTWEtuSXF6TGFMeHg3M3Y4OWxR?=
 =?utf-8?B?VDRST2NwZk1ZZjl0WDIyUmRGVzRqOEd3Q0JGZkpnV3FNVEN5YysvN3BjUjFt?=
 =?utf-8?B?SC9NMnFZQXQ4OHpiekgwQm9rOTVuS2pRdWZzTnlOQTlWeWFYcHJHTlJnZkxj?=
 =?utf-8?B?bGtNQzNTTjlkNUEzNUFpWDBjTGh3LzF4TVlBM1NLN0J0OTBFUVZtc0ZQRHcz?=
 =?utf-8?B?L1ovQ3ZpZCtnRW4vWHhGSmVPVndldzZsTU9uN3RiUTlldGNEM0VvUTZFbGZi?=
 =?utf-8?B?K1BCaGJDNEt1MUNidzRCODBjL2VVdnFKdmZldHhRNEM1NlR5MzFsYjBkTGlZ?=
 =?utf-8?B?MU9kWUl6dkVwSlR6cm9FNER3cmRIVEFuRkZRaU9Xbk9LOHp0OHhGWnVZWHJY?=
 =?utf-8?B?VzJvSnBVU1pvZ3VsNElCL2MzOGpSZjMzU0pmZVFHa1Ira09GVkU1TTFQTERU?=
 =?utf-8?B?dFRLeHV2aTdRMXMwK0pCdnNDS3ZVYlY5ZlI1VGZBVEYrZGFSUHNocVBDN0FP?=
 =?utf-8?B?VVR3d0hIVFNNdkttdmduQXJNanNYTDNlNUlzbzlIZEJjajdveUNKMjc2bjQ0?=
 =?utf-8?B?dUN0aElxcmIrRytQSDNUS01NZHQzaDVvWjdkQ1B6emlUZk9iSUQ3aEZUczRD?=
 =?utf-8?B?K3hSM1ZoNFF1cjgzTEVFeVBMUmhPdmU0WFhiOXJWTzJWcEFVOHRIeWtlUlQ4?=
 =?utf-8?B?cUgrSFkxMlAzMVpJdUlyNGdoK05EM0ZscWQ0cGxyUUh4ZXZJK2RHamlGR0Ex?=
 =?utf-8?B?bU4xKzI2aUYyMHpDVGpaWFM4ZXpya2ZlS29LLzNoWmVSNTNTNVYvYXVNRXc0?=
 =?utf-8?B?WkU4Ym9PKzdtbmg4dlcrT2lrWUdtUHlhQjUvNitZU0pCeWFaZXRibXgzTE1M?=
 =?utf-8?B?N1dyVXdHUkJ0TEdGdFk5UUlCaWd3QVhONG5LNGl4S0VickNPZlIrMkZZb09S?=
 =?utf-8?B?b3MzSXN0SmF5akJYUWhQcHNxYm41a3NIZ2luTWVjeVBOUFhnRk4rWVV1YXNz?=
 =?utf-8?B?TXNkM3dwb2hLaXN4dVVkVFp3elhhVVlSQ3kweXNlVCtpT25DVlhuc3Y2QmNN?=
 =?utf-8?B?OHljdktwdjU2c1JyNkhyZndkTlF5NUlyVTNlbFpoVFNlS0hDaFRYQk56Z1lT?=
 =?utf-8?B?T1NnTFZ4WWNtelF1bFNFT25YV09sL05IMVJOeDRqSUd0SUhFQ0NyUWZoMGtW?=
 =?utf-8?B?MmgzWkFpcHQ0UFdpNEZqblYxKzVZVnRJNDFyK08yWlRGUDRYR3NTWXFnNHZj?=
 =?utf-8?B?WlM5eSs0b0d0WUp5WlIrVkw4N2NCd0U5bEx3bThlSlZmeEpBZGVIZWJzZTJl?=
 =?utf-8?B?aDd4MWx2K2ZtZU1GOWp1Qzhlc1ZobUUzMXMwMytpejAzVmJZemQ4SUFrRCtv?=
 =?utf-8?B?MGp3R01obktHTzI2UnRVbWxtd3BOL2lLSVhSem85bGFyRU52TFAwbnVCdmpU?=
 =?utf-8?B?THFRbFllWE81TVJLbEJsN3FXVDYvSU5YUnFGTllFRzNwMXBrZ3ZUUDJZQ3c5?=
 =?utf-8?B?SGdySzByZVhhWnIrYkMyMm5uY3NxM1NyVFAyUXo3M1JnU09PNXplY3hCN0k3?=
 =?utf-8?B?MlF5QVl1ZU5GNGJ5bGJ5dXRqV0JJTnRuN25wcHR1RXZTbmcrbnlzSEZ3TkRS?=
 =?utf-8?B?MG9vUU92Z242bmVRdllVMk1UUjVOa1BJcDI3bERxMXBONzU2QTN3aTU4ZUlI?=
 =?utf-8?B?NkRCVmI1dUN1aGpYVVR2S0VDRSt0aUZOZjJTdjBFL0cyTitGVnlYTUVSS1dk?=
 =?utf-8?B?dVFkK09LbE42QVg3TnRCNzFpaFdVeC9seXNRVHJ5c2lieUlJam9UZkZmbWhj?=
 =?utf-8?Q?DghZCzctLs22u?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(376005)(1800799015)(82310400017); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2024 21:48:24.3410 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 212a0b9c-0102-4d18-fbfa-08dc80f23b3e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000397B1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB9049
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

If another thread accesses the gpu while the GPU is being reset, the
reset could fail. This is especially problematic on SRIOV since host
may reset the GPU even if guest is not yet ready.

There are code in place that tries to prevent stray access, but over
time bugs have crept in making it not reliable. This series hopes to
address these bugs.

v3: dropped:
      drm/amdgpu: abort fence poll if reset is started
      Revert "drm/amdgpu: Queue KFD reset workitem in VF FED"
    updated:
      drm/amdgpu: fix sriov host flr handler
      drm/amdgpu: fix missing reset domain locks

Likun Gao (1):
  drm/amd/amdgpu: remove unnecessary flush when enable gart

Yunxiang Li (7):
  drm/amdgpu: add skip_hw_access checks for sriov
  drm/amdgpu: fix sriov host flr handler
  drm/amdgpu/kfd: remove is_hws_hang and is_resetting
  drm/amdgpu: remove tlb flush in amdgpu_gtt_mgr_recover
  drm/amdgpu: use helper in amdgpu_gart_unbind
  drm/amdgpu: fix locking scope when flushing tlb
  drm/amdgpu: fix missing reset domain locks

 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |  2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c      | 11 +--
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c       | 66 ++++++++--------
 drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c   |  2 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c      | 23 ++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h      |  2 +
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c        |  3 -
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c        |  3 -
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c        |  3 -
 drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c        |  3 -
 drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c        |  4 -
 drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c         | 39 ++++-----
 drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c         | 39 ++++-----
 drivers/gpu/drm/amd/amdgpu/mxgpu_vi.c         |  6 --
 drivers/gpu/drm/amd/amdkfd/kfd_device.c       |  1 -
 .../drm/amd/amdkfd/kfd_device_queue_manager.c | 79 ++++++++-----------
 .../drm/amd/amdkfd/kfd_device_queue_manager.h |  1 -
 drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c | 11 ++-
 .../gpu/drm/amd/amdkfd/kfd_packet_manager.c   |  4 +-
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |  4 +-
 .../amd/amdkfd/kfd_process_queue_manager.c    | 13 ++-
 21 files changed, 151 insertions(+), 168 deletions(-)

-- 
2.34.1

