Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE233C28B23
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Mar 2025 15:16:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D8DDC10EBCC;
	Fri,  7 Mar 2025 15:16:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="WyoPku8d";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2061.outbound.protection.outlook.com [40.107.223.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 50CE110EBC4
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 Mar 2025 15:16:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CCLtGfpgp/WeGd9sdJ/KpPT0Q71qlXK8VyH0EnZRjBBpJtLSJfhh/uRYe3Z/wPyE3ukQ+l8Pwz4VVItiBBvgTAE3TQl0H2NS1ksSyIlH8ysERCNHaxJcv/nBAPnIqpOcTQlQExJnwH02yaRZ52V/hdapYOreup3bkopnXd0r3NrmSf5qtN3fk11E8PPPRMwEaYzXxBD3mmtVi2kSCD6Q7AXnbG/GHzI7A5Fk/VEgW36mNTb+Qi6zMRySk8PiqcCS6pQs8pVqw6KqJOzDa86ON63rQewXRn2zUS17hzqsMSeS9WqpnctUZgZyZ/eitZ0MNgF/CE66J5u66eH9zmCtlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ka1a9wsOMH7Xf//Wdv04QPQAxao39nybQfj1OdXyNdo=;
 b=KzJgGgvih1pUzO7VGabZ7u9Lo1ZM1Y0LgH5tcADSiJgeHPD9bHpeFwjYdGH/e+J/JtLq5U2SwT4IGC2bgoVepRpRvx2OQjxKizBSGikKPuc+qJfsx+xgMkx7OUM/AjLdyVHSBiksgFJyvpTjm9ZE+J24OiqTNav/DrmOK6KOMgwEBRN0Ma0M+TJmO5Nohczo0j+wKwQapH6hj4D/Kxlu98WwMCCcSfmIb+54scrPquGPQqp7SH568A0Wzenqn1pwJ1ig7GwKQ6fNiyRMDX6T33d9eN6W9yG8wZHPJeLLGzDH1aibblyWPFDLlPtI2keI7Or2CAPQZYmbyRaX0RIgrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ka1a9wsOMH7Xf//Wdv04QPQAxao39nybQfj1OdXyNdo=;
 b=WyoPku8d26vj+UI1fcP+pE1eDbMVBnguiiXMr5OXBqdUn3VQsp4i1ckv6NGRokEywR4f5iJM+jWYNpcXM8gucgh74kcafJgOj9h1xLyMIFXCNnyehJVCsOST8ym9DjerzairPxhi7Y7Sp3kSBFRFanSVAxU4kI/zWDdnXoxPXm0=
Received: from DS7PR07CA0018.namprd07.prod.outlook.com (2603:10b6:5:3af::27)
 by IA0PR12MB8905.namprd12.prod.outlook.com (2603:10b6:208:484::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.19; Fri, 7 Mar
 2025 15:16:19 +0000
Received: from DS1PEPF0001709C.namprd05.prod.outlook.com
 (2603:10b6:5:3af:cafe::53) by DS7PR07CA0018.outlook.office365.com
 (2603:10b6:5:3af::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.19 via Frontend Transport; Fri,
 7 Mar 2025 15:16:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0001709C.mail.protection.outlook.com (10.167.18.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8511.15 via Frontend Transport; Fri, 7 Mar 2025 15:16:19 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 7 Mar
 2025 09:16:18 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>, Sunil Khatri
 <sunil.khatri@amd.com>
Subject: [PATCH 01/11] drm/amdgpu: add parameter to disable kernel queues
Date: Fri, 7 Mar 2025 10:15:55 -0500
Message-ID: <20250307151605.946109-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250307151605.946109-1-alexander.deucher@amd.com>
References: <20250307151605.946109-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709C:EE_|IA0PR12MB8905:EE_
X-MS-Office365-Filtering-Correlation-Id: ea9b698d-e808-40c0-f2ec-08dd5d8b0378
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?lbc647HiXVPGRUMlCZ06wqmha1j4IP/I8G3bPGSH02l60XjzVPJO9DeavRu5?=
 =?us-ascii?Q?OeqALLH+1vh7GFk2lj5tSv8d1vD12b+lCTgmMM+jFfE7U3H6n28wxoWd2YXh?=
 =?us-ascii?Q?fcX2+3wN0y6F7XyKhPKfiHmZ8n4HP/x9SeqmrvChJUZ9arZYFO/kKs7I/0la?=
 =?us-ascii?Q?+1XTrv8D4GpJFOCuW+pwYCENNaxCOq5YqHEA7GFGVDojgUUgxv6EqBzkVGpT?=
 =?us-ascii?Q?ok/VELuL0FsMYKrqDyWlSDTO7JnovZyBtE4TkP3A3mG+qahcGceumGPbwDgt?=
 =?us-ascii?Q?jOVHWYDuylgWgZCaCoGhwAZMtp8TcVREeXYUdN1DwBusKNZ7vxxIoeSgD1NF?=
 =?us-ascii?Q?rSXPW24CSuid9UnXi1JjZYW0icxHc3dTCZ3ozFpeOz8rKlfVwjEOQrnmfDdp?=
 =?us-ascii?Q?5lfMb4zcaoLkIHJNqQt1rIfZFlhl9HNgvCqXYDziR0RmFfPH4z2ZWgXyFJFj?=
 =?us-ascii?Q?hWOq6MwQ5HYEJzDAL2BAAXb3Goi89dtSLgWA5Ny1/X9mDYeLtYxfWpNma4/c?=
 =?us-ascii?Q?yf6Jy9BG9DSe8j5dTLZv0Ou7Xc2rqkEuMF1Lq/uNfcZwGeAoQs5XcNRuCkyL?=
 =?us-ascii?Q?YmJMtKx7B7q+NUQmffKjPog9lmqHPrGPhqFytlQz17Jj/fhSvsru+KNzA83r?=
 =?us-ascii?Q?13mbBVULmb8cBZLIC3GMq3+zi9viWoTwqsYSnhXss6asDBYq3edvM5WKh8M7?=
 =?us-ascii?Q?Dbr4xzJi91/l+9PNbLc4fPd/jIfrfrGAmVyR9ll192NRZDWDdwIg3sBj4+LH?=
 =?us-ascii?Q?etOl6GPqjmiypZ/49QJtZDLRDjpI1uVz0l457V3ATsUmFTRvutbzEWnsQxIC?=
 =?us-ascii?Q?c/I787VY8SuMFvqDoSBm91sjGWoA1TsCOGucXO9SkL1Y1bQBevXyItZN+Iwp?=
 =?us-ascii?Q?0tIgzFqvOqhDTVaES2j0U1z6dFkyzVV9qRS1LVep5/8/1kV7u1a7T9e+QKrp?=
 =?us-ascii?Q?9t3XGhpIKb8nyLNHj7p8gXhI2EjE5sKfIOI1ZSh9JHRKFrJlaq1LbFelR9Rx?=
 =?us-ascii?Q?pocGYcq+XeXFIOIQK3ehZPooGPjTUDC8dH7tQJ936PkUshBcSZaguNGzoQG/?=
 =?us-ascii?Q?4KuVrDn/RH0qB/GZnh1PIv4qjf3IrpfA1hzU8JxN8hZOQ1i/VuDyloRqtDFi?=
 =?us-ascii?Q?MKnu6riVZzZkqYsXWUMBWPt1hOYreCYPp6n/fPv7zOFlKZK5Lsyi6E3QQuL4?=
 =?us-ascii?Q?27FA/lsUw/QlXIg604FQ5pXv0sc20IFNbGzoX8f/EEQmXWNfw4Kq3qBJFh4y?=
 =?us-ascii?Q?tqEAZ6LvKaMVWVEZQVNwAD7iPTsuMV1y/NDRxJ5EuAShnQTRGoaxUT/H/1R9?=
 =?us-ascii?Q?Q7mHPObvcENxLNWs7Yxb3lmLHSMb/8QNIBAHY20jN9BUMWamc0P1kFwGHkXE?=
 =?us-ascii?Q?eU7tGDF42/eR2F91ms8UGBHErwDcmjU/dHa+kATpm0RI+8Ec5bnnbne3hVjc?=
 =?us-ascii?Q?OSq2kws4793zSmeiSsJ70/X1jozNpgCr4avXzVe64P35RsUTZpvJlwyeMI3N?=
 =?us-ascii?Q?PKAQkxbeT9ywF6E=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2025 15:16:19.5636 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ea9b698d-e808-40c0-f2ec-08dd5d8b0378
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0001709C.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8905
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

On chips that support user queues, setting this option
will disable kernel queues to be used to validate
user queues without kernel queues.

Reviewed-by: Sunil Khatri <sunil.khatri@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h     | 1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 9 +++++++++
 2 files changed, 10 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 87062c1adcdf7..45437a8f29d3b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -270,6 +270,7 @@ extern int amdgpu_user_partt_mode;
 extern int amdgpu_agp;
 
 extern int amdgpu_wbrf;
+extern int amdgpu_disable_kq;
 
 #define AMDGPU_VM_MAX_NUM_CTX			4096
 #define AMDGPU_SG_THRESHOLD			(256*1024*1024)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index b161daa900198..42a7619592ab9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -237,6 +237,7 @@ int amdgpu_agp = -1; /* auto */
 int amdgpu_wbrf = -1;
 int amdgpu_damage_clips = -1; /* auto */
 int amdgpu_umsch_mm_fwlog;
+int amdgpu_disable_kq = -1;
 
 DECLARE_DYNDBG_CLASSMAP(drm_debug_classes, DD_CLASS_TYPE_DISJOINT_BITS, 0,
 			"DRM_UT_CORE",
@@ -1083,6 +1084,14 @@ MODULE_PARM_DESC(wbrf,
 	"Enable Wifi RFI interference mitigation (0 = disabled, 1 = enabled, -1 = auto(default)");
 module_param_named(wbrf, amdgpu_wbrf, int, 0444);
 
+/**
+ * DOC: disable_kq (int)
+ * Disable kernel queues on systems that support user queues.
+ * (0 = kernel queues enabled, 1 = kernel queues disabled, -1 = auto (default setting))
+ */
+MODULE_PARM_DESC(disable_kq, "Disable kernel queues (-1 = auto (default), 0 = enable KQ, 1 = disable KQ)");
+module_param_named(disable_kq, amdgpu_disable_kq, int, 0444);
+
 /* These devices are not supported by amdgpu.
  * They are supported by the mach64, r128, radeon drivers
  */
-- 
2.48.1

