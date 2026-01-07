Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2F54D0D16D
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Jan 2026 19:25:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8327E10E15A;
	Wed,  7 Jan 2026 19:25:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="KsQ2E8WH";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010000.outbound.protection.outlook.com [52.101.46.0])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 504DE10E15A
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Jan 2026 19:25:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V3Ig5K2+adjb8GP+Dl8y5jfpjWWTOfBVr5yU5PMTIMljOd/k3E1eViFTIhXAxMShZhj9uBgwr1LmdcZsnJdoaJCB2av7YK5jste/63NXBBgCn5hmHVSkluo+0BgdM4n5hpPDr2tQUUbkOUigSDF1h6GMfz45YaaHXyVK8oAg6tM8wIXTEuqF7xwiPVDMZ6uYso8YO7ZcBusCyzrMszca+YtgRnR3WAW8ZSdDyS+jZS5i78IPHMxK+v2xUCdgNPmD65ssNKlKxG4B2fa+/TFzk/VI36HIEjDmcMQvPP5Q8iDcFLG/B1NAyC8XtLICbPCgDg2pV8njwAd8cpJdw1Bu8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1Je57zue6WA1XDrslOsfVaRpgXX+wQQtPIMjXOloTrc=;
 b=X69XD8KfEyM76c9JNBC7Md6D+QkTHIdjcUh+5pHDvXj/F1xhNo4MYLbco7kfhFLIUgpkomEPGUCL94o8Nb2ZkJzbYUavK8CdEnt7v4m8N6BUMJZMsRaM98V0u1GrSLegTqVN5/fcpMeKl0ZyTWcjM0FeZeHt/pc42AnkgZMvbZeczSioWreou8ZzWbGeSsypmCSYfybGm66dhmhPipSS6qX67RZ3nuHJrbHfe4SIwlJOsMcODcQWnzONxKXTbYQaVL80hbJvUuIRgYxjzeycLUia7z3rgCL5riKjNEfL5MpP0dw+Gmy1WRBfc4cf0t+xxYf+WcvYOeUUbH8ULoAz7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1Je57zue6WA1XDrslOsfVaRpgXX+wQQtPIMjXOloTrc=;
 b=KsQ2E8WHcycU5In8GWhDo4ttEdfA/mgv602gh8eQTdCbg885fiUL3YlrRnhmJYRfS5c/ehZRublOFf8CqZZ7N/XdWcFp1wIYPTr6x68qzw/aWij7yQD3tVCtFrSov2prPi6lxkLUlwjOT+eBtBs3YE9u3akbfGQ5y+Eae3PlAoY=
Received: from BL1PR13CA0341.namprd13.prod.outlook.com (2603:10b6:208:2c6::16)
 by DM6PR12MB4057.namprd12.prod.outlook.com (2603:10b6:5:213::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Wed, 7 Jan
 2026 19:25:49 +0000
Received: from BL6PEPF00020E62.namprd04.prod.outlook.com
 (2603:10b6:208:2c6:cafe::7f) by BL1PR13CA0341.outlook.office365.com
 (2603:10b6:208:2c6::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.0 via Frontend Transport; Wed, 7
 Jan 2026 19:25:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF00020E62.mail.protection.outlook.com (10.167.249.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9499.1 via Frontend Transport; Wed, 7 Jan 2026 19:25:47 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 7 Jan
 2026 13:25:47 -0600
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Felix.Kuehling@amd.com>, <christian.koenig@amd.com>,
 <david.yatsin@amd.com>, <kent.russell@amd.com>, <jay.cornwall@amd.com>,
 Philip Yang <Philip.Yang@amd.com>
Subject: [PATCH v1 0/3] Move gfx9.4.3 and gfx 9.5.0 MQD to HBM
Date: Wed, 7 Jan 2026 14:23:37 -0500
Message-ID: <20260107192341.3521748-1-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E62:EE_|DM6PR12MB4057:EE_
X-MS-Office365-Filtering-Correlation-Id: 678c2b85-a493-47e4-e509-08de4e228fb5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?+Q0kGocY1n1CNreY8sH9icAx8pXsve21XoFXkBmGAqpu6icE3u7QXFosH4Ug?=
 =?us-ascii?Q?fRogK4B9mhTU1Gwu4LKMlKm4x0bO/mJfwCPwtBcsKjSAx1xlpvzVhz84Q9Bb?=
 =?us-ascii?Q?AUgBl8j21M4WmKZKJohI15vbFXN/I+HK+zQVMI+X+3ymdiESgnOvPWpiyOVS?=
 =?us-ascii?Q?wis9hRP4nb8XKP3BDChVibsBpMms6UbX4581gP1a6MU7uJENf4WMj/03dTqH?=
 =?us-ascii?Q?LEIu1i8D9t+9cVIB7GM2HyMdvrOjmgx5l4AaeFFf2CsXSg5qQvxMJTc9JURX?=
 =?us-ascii?Q?ko1bZ5IEJyOg0ss9q3zSNjIGKwmrtjYzQb6jeb/AjQ4og8teYtaJTSzFkHDs?=
 =?us-ascii?Q?xP8CjVs+NPQs9p6Y+RBcTNuK6HdPLu9OnxZWruVMay9ncK47emlZ9TELz/vy?=
 =?us-ascii?Q?mu/AwRFkyolKOY1jsHY/z6SfdPfN83oA+Uc6LEvj6RKXXddXuKmFNU7a63pG?=
 =?us-ascii?Q?qhc/4olb5hx+TMxdYBO76Os08257Xr/R/oU01hUyRpio8dhXJdgBLsIIWA94?=
 =?us-ascii?Q?LGrNs1TktmrcBdmfhDz2GXxLHB99thkQOmGO77J7GP1bFLDeHpndrSU+6VRk?=
 =?us-ascii?Q?UhrwxBtScBgPsfdSVw7Fw9gKrnnWtLdX5HdhdIxAsvIRm3uvTYIP0MVeKt9r?=
 =?us-ascii?Q?wlW4f3SzuPHs7kB/YSlhALS5IXsjcXamKe8JuPUT/eTe+/0NBZiagme1+VwQ?=
 =?us-ascii?Q?M3fa/X5EZgUTl5gVdCzper3ioSAyq8p9CblecEPCEkYCliXfy0PVAFTwBCxq?=
 =?us-ascii?Q?8uOzx5xIPOkZ2iPSMhBN1V9TYNBb5ZmZUY73oKnI2CyK0PbrEJaYW6VicJlO?=
 =?us-ascii?Q?H/LLohClcNVkiWGx7AGwX3J8PGxIuADZL1+aZOaCPjzR0Y6X6fj/rkMg53fy?=
 =?us-ascii?Q?U09AjGL1dtHPwtbrzECVe46wccO7Ulwx0a2pp5k1laKm9A2KbbhCY93Etzvd?=
 =?us-ascii?Q?tsiozhxQbwP13tuXGLdqx78gYrDZ6GQKjJz7aRIAIP3KSt82UO23R7o9rO6r?=
 =?us-ascii?Q?1KUpDbLffe7QEnRiHaq7Z6NIbQ1vBvHwV1cZtOASehntblNq7SMzDIUMB1PJ?=
 =?us-ascii?Q?uVFOcOTDDEr4fc4aMmKFRbhNnxkhnOoTwTQ6NPFA+2In2oVrvsgE4klsh98D?=
 =?us-ascii?Q?kzqK/tIseVKt0J1aN8Lag7FsZM88690b47mBdzyOCFPtV7V1zOM6CJFyCuCl?=
 =?us-ascii?Q?na9mQ53Cqa9BKhQILS71tmfUAsjmbNGc1RP6YRbyIS3PlljlLltu3NVHXnyg?=
 =?us-ascii?Q?nSILbKksw+ZerZbzKOTsxeqQPswPw/Jt+0OAYRJXFlLlnpFkjue3ZbWeH38z?=
 =?us-ascii?Q?aSkZz5RxZ68D97Db2DUzxUHJ7TX+sP9pWtyfh6euA3id6Hl6FLpMftafI71V?=
 =?us-ascii?Q?COc8Cj+BNaITzsLme8K/viXr8927CpUhFvDyfl+slT+qd1VhUnmE47uY6o1e?=
 =?us-ascii?Q?dYlz9UwfLmROlgtrnGU4fPdoFpd8aUA0SHLNR7N3agXsOz7veLi3+jVcgNNk?=
 =?us-ascii?Q?XBRBFMIvsC73CHNLT+DGToCWNfMuY8q6oJlArJpnnUM0zaV73kQo9JVm3g59?=
 =?us-ascii?Q?OLf8A/ZtYUDptD08ao4=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2026 19:25:47.9664 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 678c2b85-a493-47e4-e509-08de4e228fb5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00020E62.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4057
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

To reduce multiple queues switch latency, move user queues MQD to HBM,
and map on GART with mtype RW.

v1:
  - patch 2 add HDP flush after MQD updated

Start new patch series v1 because two patches in previous patch series
merged in already for general fix and helper function.

624bf8ab05ff drm/amdgpu: Add helper to alloc GART entries
d33a6691b65b drm/amdgpu: Fix gfx9 update PTE mtype flag

Philip Yang (3):
  drm/amdkfd: Add domain parameter to alloc kernel BO
  drm/amdkfd: Move gfx9.4.3 and gfx 9.5 MQD to HBM
  drm/amdkfd: Map VRAM MQD on GART

 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c    | 13 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h    |  6 +-
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c       | 74 +++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h       |  6 +-
 drivers/gpu/drm/amd/amdkfd/kfd_debug.c        |  3 +-
 drivers/gpu/drm/amd/amdkfd/kfd_device.c       | 13 ++--
 .../drm/amd/amdkfd/kfd_device_queue_manager.c |  7 +-
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c  | 16 ++--
 .../drm/amd/amdkfd/kfd_mqd_manager_v12_1.c    |  4 +-
 .../gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c   | 42 ++++++++++-
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |  3 +-
 drivers/gpu/drm/amd/amdkfd/kfd_process.c      |  2 +-
 .../amd/amdkfd/kfd_process_queue_manager.c    | 12 +--
 14 files changed, 161 insertions(+), 42 deletions(-)

-- 
2.50.1

