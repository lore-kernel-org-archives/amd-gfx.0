Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CE53606A887
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Nov 2026 14:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=smPcm4vi
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1F49410E804;
	Fri, 13 Nov 2026 14:41:50 +0000 (UTC)
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010019.outbound.protection.outlook.com [52.101.85.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8E3C410EC21
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Nov 2026 14:41:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SvrWbdmpg8o4Lyap1JoFawGnuYj+hp2IAgRJKfQNhDWpZU/Kcfoj1bS5etw25JU/NWsJZa/js0RD8U3fBMft9e6oNx7ofhdZlwh5qIxl7ocufshyw1v0TO3e7Zmh5Kn0kH5aAHt35PHtXqcepqchnhFhJIa8ierCxNezTTfGnlBnbxXoq7NOiK4N2APbpIYc8VbDAJ987ixnnWzIDB37T6VfMmBb0oscZIIIdD+rV6x6JXBE4SB2xPrZZ8GhvDemXWHdOxAx9iZJdOJEnou65kBLBLEX/1mNGkRkeqAuFz1mua7rU6s+uAB5ytef2KGGqXRnuS/Hbp4QHOzojNqMag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H1zzj2fYs6guCQRI8PHKPMjye1eQVKbqS9cz23FI8LE=;
 b=po2PzR1UxvwID6NujXLKN+lrFDrSAyDsFoA/RK7402+HKwjKWZiw+zRYtyCMg7rHxMQAjaCpS4bTsZVe3Urfa265EEnKChQb6Wpu8mGB2no1wJn8tZqLqFYL881fYB8Ry8oDVzxh46bhA29uPqxGwe9T+j4CjLonD94cKO9VonfbNCDwklL1YLis2oF+UtE35GPAYiF+/GOn+WCoWG764x/8eYOZx9bKqn2Zm0firZ9/vJFf2LdJ2C1Dw1+ZeEEOtBKSgC7XsafR4Tc5w1RUTNGWQRhmzlLyBBfITfLDVNacXLFhANVUKgOn9b2cZ0ZPzSwEsOZcV2iHD7v+9oabXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H1zzj2fYs6guCQRI8PHKPMjye1eQVKbqS9cz23FI8LE=;
 b=smPcm4vi6E03HPKxJoYyMAvZq4Wt1MXlw+AwTObDifcOcBWDbp9loleWsR5kuE/7aWu2xLWaFAurZASxmprS+44KZf3Smt0jgIf7INWxRLh2IWgDh2qL/0E4xiEWJPfK3BNjRid4PfJ+7xxaTGA7ZvqupJFUVv3rE/ePQCpvDgI=
Received: from BN9PR03CA0423.namprd03.prod.outlook.com (2603:10b6:408:113::8)
 by LV5PR12MB9778.namprd12.prod.outlook.com (2603:10b6:408:300::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Fri, 13 Nov
 2026 14:41:39 +0000
Received: from BN2PEPF0000A890.namprd04.prod.outlook.com
 (2603:10b6:408:113:cafe::9b) by BN9PR03CA0423.outlook.office365.com
 (2603:10b6:408:113::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.10 via Frontend Transport; Fri,
 13 Nov 2026 14:41:39 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF0000A890.mail.protection.outlook.com (10.167.248.182) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Fri, 13 Nov 2026 14:41:38 +0000
Received: from [127.0.1.1] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Fri, 13 Nov
 2026 08:41:37 -0600
From: Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH 0/3] drm/amdgpu: fix TTM device_list use-after-free on
 failed probe
Date: Fri, 13 Nov 2026 08:41:31 -0600
Message-ID: <20261113-superm1-amdgpu-memory-leak-v1-0-4a495cfc2c92@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJsh92oC/yXMwQrCMAwA0F8ZORswHQz0V8RDumUzareSWFHG/
 t2qx3d5K7iYisOxWcHkqa7LXEG7BvoLz5OgDtUQ9qEjoha9ZLFEyGmYcsEkabE33oVvyIG7GPj
 QyhihBtlk1NcvP53/9hKv0j++I2zbB01+QVJ+AAAA
X-Change-ID: 20261113-superm1-amdgpu-memory-leak-a2a6b2a93efb
To: Alex Deucher <alexander.deucher@amd.com>, =?utf-8?q?Christian_K=C3=B6nig?=
 <christian.koenig@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Mario Limonciello
 <mario.limonciello@amd.com>
X-Mailer: b4 0.15.1
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000A890:EE_|LV5PR12MB9778:EE_
X-MS-Office365-Filtering-Correlation-Id: cb6f6173-8dbe-41bc-9c49-08df41943965
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|36860700016|82310400026|10067099003|11063799006|56012099006|261022105027099003|261021121427099003|261026140227099003|261028144727099003|261021123027099003|261102123227099003|261009223027099003|18002099003;
X-Microsoft-Antispam-Message-Info: bvDOax6NpZU3iyVKKMeHsCXGh2hxgwFINNf2fSHF8A6USEK8jw1xYvLLim1kU+lZGPZRhV8DWe5Xn0uWR6U+3v0PxwAGHs20L9J6lrwmDGt6rmUR/VJfMTPZLu62L3mCwKgx+nFd5EC0gbXEWZAQ1zqFPZkvEKs+O2IB3BwLpJ/ZTpZjGYyKt608Wzo+t+Vq+jRUiUXl30c/AP2lXvSTiiqB2F9nwiI3Cdy21w6fgA7IOSOH1CIGF7dUHOnYDgrYPNQmgQ14dbLtafpb0ZGIS0Af3CDx8GdAIMZIE47mc8z5o2fCZbmCL69qZ5XKhEhvcwTBp0lfmnwXNRjU3o475D7Re4S6p2sESpSqG/v21gAVWdKSC4u/IwsKFafJvuwKaQ1blrndLYZyydBAZc6bKoRir08Ej4THvUZ/IWznqcwkE7fzJU1t2YtL+zD785M5KfWV07lXtDhVIB8Hy0aZ8q+62HxsAB2w34S/qrhDEMMd7y8/mQrVuBPBoEKhKGMJZSVnDvPYBBe9VX312KTj4qcbIRI6MUkrepA43ui0TEWytKatM8zHylzFgcGjjZ8EZ1xtkGMwrauhyIYO1GI7TES3JXveJ97Oi7CDVxz7j/RqGHgZOV+kh0RXPzJaxCbt5/pGIVL22/WjCZA6+PpUCmLzTN7LrQN1tAUiMWG/7LiD4vzPszvASKfmZrTywdY2XfTPP85VaQrnZ/l8EezmDg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(36860700016)(82310400026)(10067099003)(11063799006)(56012099006)(261022105027099003)(261021121427099003)(261026140227099003)(261028144727099003)(261021123027099003)(261102123227099003)(261009223027099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: PI4A2TzjnPN2ZE1HOyThl7q70y+3SkUUuIIn8hXyPZqJoPvzwzud0NP0k3mWFs93uQL/bzxr9lcKBEwOrK9/timjfZhaYpkNv7qBOx6jSiATBGsyeBf0AzrOOEOvexQ3+qN5IHEAx86ZsUgG84U8j/Y9spBHKKa+FfQZNJNpodpxMrC+Y2urukiJps3nSkAs3/ObpX5w/kvfAMEE8tBb4wWhZ6dQnOjZ7axsne2YAM9N4hUtbw0hrxfG8azMAWLIwFbVakk0Bi0guF/Mhh0hr5PafOfrrE/6oVT2sMffwWaqS5VD6RGBlZOoQcU4vs8hy/CrAAkE6y2g1+5VUZmgv/EY3JzcxfWpuxgDi9mbmVwHN30e2+VjRg9l11pT7iEoExnpwP3oc1ub03WiWMFC32fpwv2cA6eEq7TIgtfDFCrHgXEE3wgPciQI9rhuAAnE
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2026 14:41:38.3379 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cb6f6173-8dbe-41bc-9c49-08df41943965
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF0000A890.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV5PR12MB9778
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

When amdgpu probe fails after ttm_device_init() has succeeded, the freed
amdgpu_device stays linked on ttm_glob.device_list. The next
ttm_device_init() or ttm_global_swapout() then touches freed memory
(list_add corruption on the following bind).

Failure points are any error return in amdgpu_ttm_init() after
ttm_device_init(), and gmc_v*_sw_init() failing after amdgpu_bo_init().
In the latter case GMC's status.sw stays false, so amdgpu_device_ip_fini()
skips its sw_fini, which is the only path to amdgpu_bo_fini() ->
amdgpu_ttm_fini() -> ttm_device_fini(). The leaked MMIO_REMAP BO also
shows up as "Memory manager not clean" on the next bind.

Patch 1 unwinds amdgpu_ttm_init() through amdgpu_ttm_fini() and makes
that function safe on a partially initialized device.
Patch 2 unwinds amdgpu_bo_init() in the GMC sw_init paths (v6-v12).
Patch 3 releases the WC memtype and MTRR when amdgpu_bo_init() fails
after reserving them.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
Mario Limonciello (3):
      drm/amdgpu: unwind TTM on amdgpu_ttm_init() failure
      drm/amdgpu: unwind bo_init on GMC sw_init failure
      drm/amdgpu: release WC memtype and MTRR when amdgpu_bo_init() fails

 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 20 +++++++++++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c    | 43 ++++++++++++++++++------------
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c     | 10 +++++--
 drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c     | 10 +++++--
 drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c     | 10 +++++--
 drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c      |  6 ++++-
 drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c      | 14 +++++++---
 drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c      | 14 +++++++---
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c      | 10 +++++--
 9 files changed, 102 insertions(+), 35 deletions(-)
---
base-commit: 71830abced88ee7665010e79b51f0789b033cc3a
change-id: 20261113-superm1-amdgpu-memory-leak-a2a6b2a93efb

Best regards,
--  
Mario Limonciello <mario.limonciello@amd.com>

