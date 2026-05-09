Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56A24CD3447
	for <amd-gfx@archiver.kernel.org>; Sat,  9 May 2026 10:20:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CE01F10E3B1;
	Sat,  9 May 2026 10:20:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5o8u7VcZ";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010034.outbound.protection.outlook.com [52.101.61.34])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D792010E15C
 for <amd-gfx@lists.freedesktop.org>; Sat,  9 May 2026 10:20:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WI4dhPV2B2/IST+NnuLZeu6pCLSg6cAAla6/Yc49ggqFHC7GSVFW15iIEAn3xRPGu2DIe+yTWqZ8FSbS9D6KJZBrV0T2ETGSkHVyW0DghL65CTLKCCUjAEUv8RsaFfGMpRk708/Nt9DMVfe699uZdFkvI+mYQKIeRshuG16MwRtOdlrmz+iKrST/XUXAV69NPIxGq2Ru7Mo3ydJAgmGQZOHsGOASuSMdtahIfz3yfFnnzXhmlLkuabXTleUGnN7OJtTRvM3NKzsVznQdR+3W8Akvjy1NjfEPqP9ntvBIZw2/oFRFDML//QmDL6Eprlg+1WPMyWehcp5/lY0YHPS9+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WQy1nntc2IYfZDhQXRozA5F6sfc87ilVJlVPpZ/GiSI=;
 b=TNudvohhEhfEitN+w1Qg+0rLihZxkHwE18jclKiOJr927fitBB1x0xOEV0VpagXN0U/qTfnTD1cU5vEWdyCRYAmOPXqtI4/z5me/0vIt/iKVh5gw2E39OjAl9E/cbqs/hs2JkunSfE7Hsv7drk7HE/aarmIh01oKXPUsGaZRoeJLzwVMwOSHNtRXM87hPeHhN9V6mz1/jbuf0zitfFuQW77Ar3t4pixSVQnIA1CE3Qsc8QpXkNCHM7gvVXuVSMbpccJDtq6+x9OBAuY8h7GgyPD+kNYkpEYHIgTIOwUumLc1SUJzUDbavL9CbXT3Y/IUYuAzBBY28Aj0F5GybAOKhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WQy1nntc2IYfZDhQXRozA5F6sfc87ilVJlVPpZ/GiSI=;
 b=5o8u7VcZP+dbdvm4JvWaGMAX+JYeb6v69meIX8c4BUkf5G+dr6G0ehsSIt09nu6nrZjxS8Yf12IkNqeGGL874A2C9+ay179LlbvZAB5jUUSaWJTYTIpMdZFn6/d6rk8enHkWMo9c/n/V2BiWCQhI6nrlPn+5kxbuHKSGATwP8ww=
Received: from SA1P222CA0182.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:3c4::20)
 by BN5PR12MB9463.namprd12.prod.outlook.com (2603:10b6:408:2a9::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.20; Sat, 9 May
 2026 10:20:28 +0000
Received: from SA2PEPF00003AE7.namprd02.prod.outlook.com
 (2603:10b6:806:3c4:cafe::82) by SA1P222CA0182.outlook.office365.com
 (2603:10b6:806:3c4::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9891.21 via Frontend Transport; Sat,
 9 May 2026 10:20:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF00003AE7.mail.protection.outlook.com (10.167.248.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.13 via Frontend Transport; Sat, 9 May 2026 10:20:28 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Sat, 9 May
 2026 05:20:27 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sat, 9 May
 2026 05:20:27 -0500
Received: from chengjya-System-Product-Name.amd.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17
 via Frontend Transport; Sat, 9 May 2026 05:20:25 -0500
From: Chengjun Yao <Chengjun.Yao@amd.com>
To: <alexander.deucher@amd.com>, <christian.koenig@amd.com>
CC: <sunil.khatri@amd.com>, <Prike.Liang@amd.com>,
 <amd-gfx@lists.freedesktop.org>, Chengjun Yao <Chengjun.Yao@amd.com>
Subject: [PATCH] drm/amdgpu: add rcu_barrier() in module exit to prevent
 use-after-free
Date: Sat, 9 May 2026 18:20:25 +0800
Message-ID: <20260509102025.1259927-1-Chengjun.Yao@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: Chengjun.Yao@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE7:EE_|BN5PR12MB9463:EE_
X-MS-Office365-Filtering-Correlation-Id: 80092170-05c5-4c0f-d103-08deadb497a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|1800799024|376014|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: /Kvy0N3NmQ7lXfJXCciBDg1qKVTRxVc/Em9vrH6hmiIowzOxKfgZ9F7ZYSTgR0FSXXgeL4LqvJ0A5FTxBVKUvej9nHI7tCuxjnUG5qrfLqxB0bL32i8fxNg8ZHiyqnLewv9Ba9nXkPXH7zXEHRVQh2Kw7u8Kt1pLTsJV9hJ4hs1qaHuDyJbK2Su4F8udTE4/ZxmLiu2Uk1oYBYY9eQ+CNaZP8DnbKwkSx3h5mHHghW/sB0M395FVLFs3lOIiPuHZGkDYvjxtIBc9/EouM4h8YqbfhmzyasEgnYHDEIXI0jT1Z5QG/nZXXKLd6jmvhpGToBlb2GPl2bJ8ZgySi9XhB5KOwIM5dCMTUO4cQYs9+3lZpfU+11ge40rzNwvj0jD2+V/B45YchCrwkYRKUDrOCSxFdDsXlPbzpMkUqEcAWq3udF8hlR5DwTFJVby38kvfNdt23QbCBBZvGaX7vMzelYCHYIF/WugnzJTrNEEn9SFUrlt2wk4l9tiu75chp17p8u4tbcA12dpnx9h7ZCiXeOOz0pDinxId/8vAXeEok4q0bgjF5KE3jxipFcniaJSkBV6x/kOiHfMyVR6MeG4nQsigbl9h32CXfBhk3wkmBMb8AINSpgS+RADs57Ng3XB8oF3EmKRM5Iq2wO1Glf/vqptY0P8wSSmuv4FUKBEcI8UyOqRLYZ3fYUohKqNOTHgShhBPPEhW75r+HJqBi54xnRCLs0Hq+XtVsb9fcD5fpmg=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(1800799024)(376014)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: pIb9+3mZ33RgzOraQGTaFslMDGAJ3dZRehap1gUZwA/vpyNJTE0tVxRlO4rE9GfMiVpSaACZNrnqkBbYH8NFYt6M/oEespbos5hzX+/OZ1lzGpcaaOzt9itrT8nA7GEmfaShCW5nUp1ss8sd8JIHYg5SFwzPZbuQM/VO8Qjk3yXfyN7gH+oGQNGwh9nsCTNLSPabgJvK/5BbfShF9TTn9AkFWLYAMjOe71wvVu4Bzgmz55nEU4bn9pKGyU8G7jhVGNioQVZuTeX1x8zY6GxsNs3aWWtYoxirEvzXHAX3gkcwIvgQaHfYkykNQ11yxL65LNJjIZec9yrkovtjCH6Nb4Lef9g69l61KVr1GyZZUc+ZsLP3wW09MKmC5a8+34iWgO63AwjujLG+MgGRYuBC2Y/00eKXPhuqlAHOAX7gofJ1vrwx0rPjFBxYUhTb+GfI
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2026 10:20:28.2406 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 80092170-05c5-4c0f-d103-08deadb497a4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003AE7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN5PR12MB9463
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

commit 9c85025c7ac2 ("drm/amdgpu: nuke amdgpu_userq_fence_slab v2") removed
the dedicated slab for userq fences along with the rcu_barrier() call that
was in amdgpu_userq_fence_slab_fini(). However, the amdgpu module still
registers RCU callbacks via call_rcu() in amdgpu_userq_fence_release() and
amdgpu_fence_release(). Without rcu_barrier(), pending RCU callbacks can
reference freed module text after the module is unloaded, causing a page
fault in rcu_do_batch():

  BUG: unable to handle page fault for address: ffffffffc115e910
  RIP: 0010:0xffffffffc115e910
  Call Trace:
   <IRQ>
   rcu_do_batch+0x1c4/0x7f0
   rcu_core+0x14d/0x330
   handle_softirqs+0xd0/0x2b0

Add rcu_barrier() to amdgpu_exit() to ensure all pending RCU callbacks
have completed before the module code pages are freed.

Fixes: 9c85025c7ac2 ("drm/amdgpu: nuke amdgpu_userq_fence_slab v2")
Signed-off-by: Chengjun Yao <Chengjun.Yao@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 99688391e70b..e9681eea122c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -3193,6 +3193,7 @@ static void __exit amdgpu_exit(void)
 	amdgpu_unregister_atpx_handler();
 	amdgpu_acpi_release();
 	amdgpu_sync_fini();
+	rcu_barrier();
 	mmu_notifier_synchronize();
 	amdgpu_xcp_drv_release();
 }
-- 
2.43.0

