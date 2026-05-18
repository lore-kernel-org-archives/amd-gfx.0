Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06875CD4F3C
	for <amd-gfx@archiver.kernel.org>; Mon, 18 May 2026 06:59:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9170010E5BA;
	Mon, 18 May 2026 06:59:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="sMlaWZeu";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010033.outbound.protection.outlook.com [52.101.56.33])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3DC4E10E5BA
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 May 2026 06:59:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ks/ebtohCKMe+TnNuFyY64bF7sSIBjMP5o+VrweNLBYJHInkTcn35R15Wx7QrbR4iHtmdWGAqcuxnyfUCW2ui09KTsnltFOyABz4mrwpWoQZaemdw+c/eeL2ifWpSyyHAIXrSYpjOg6r1uu3X6rPC4qYl+1j5XQGZJHz8J0fbX086FP50hTYCu7wM44N+vefQHbKUjt5J8yr2BWmmqo1uCZWCDNndDHkIscxQ9WC+r8QTxA8sNAee0Igx3ZZ4z2SQi0hhMMD31J7DuqCQVvaiWphGkuB0CVaC+X/TYdQ4ckkMNfLFm89YlMybvh2+wkiiyFS0uPEVt4cI994mLtS3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uceRM0zWxGRdCI4xk9UI/kdkUfi0w8H0daiKTD5fsnI=;
 b=X21sfX4ETZXGvKpk3j4BMG2NwBA7tCpJ1CkZ0D8+N1ha4tned/20U73Jqupnu1UzYkOa2XNUONsKQf8d3zFCGEyolegJsNvksnMNMfc5KxVuezQouBWpuBQVXB/infPgnUk70TT8eS6fP3tiqASqbBWBU4gDVYnioISIj55X40PzfDL+S+BtnyRwsJJvY75jv+QzZQzt2pLiLq//EckZXA5lC45tsgNKmZrcxjzZJZhB41R28zb8gz+WkaOIY5Rk5aUKcF8pyMfXKM07GX2BRUMm2L+2YX667jsGzCAECjcWK6s/mibhXgUwRmxFNGQ1JMYxHX/qs8kNHDEppLpVoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uceRM0zWxGRdCI4xk9UI/kdkUfi0w8H0daiKTD5fsnI=;
 b=sMlaWZeu1xThIyGF1szkYmFGBBimMOQxJjGbRyNgJeklYriYdoPha/gDd7eY6VIHuMAa7bDLAqBdopcws9Dz3ckTZax+FXJVI/Msc+ULOKgcol2fBVQm1VVqEUka+SmSCBCkOtE6Kmwuy31CUTbOZrPprrBGxcE256M/pxptCaM=
Received: from CH3P221CA0006.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:1e7::32)
 by LV2PR12MB5797.namprd12.prod.outlook.com (2603:10b6:408:17b::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.19; Mon, 18 May
 2026 06:59:00 +0000
Received: from CH2PEPF0000009D.namprd02.prod.outlook.com
 (2603:10b6:610:1e7:cafe::4a) by CH3P221CA0006.outlook.office365.com
 (2603:10b6:610:1e7::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.25.23 via Frontend Transport; Mon, 18
 May 2026 06:59:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF0000009D.mail.protection.outlook.com (10.167.244.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.11 via Frontend Transport; Mon, 18 May 2026 06:58:59 +0000
Received: from sunce-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 18 May
 2026 01:58:55 -0500
From: Ce Sun <cesun102@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <YiPeng.Chai@amd.com>, <Tao.Zhou1@amd.com>,
 <stanley.yang@amd.com>, Ce Sun <cesun102@amd.com>
Subject: [PATCH v1 1/2] drm/amdgpu: avoid integer overflow in VA range check
Date: Mon, 18 May 2026 14:58:42 +0800
Message-ID: <8e1a101af4c64414fc0cc6f97483e551ce5ea7ea.1779087459.git.cesun102@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1779087459.git.cesun102@amd.com>
References: <cover.1779087459.git.cesun102@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009D:EE_|LV2PR12MB5797:EE_
X-MS-Office365-Filtering-Correlation-Id: 054115db-2dee-4db6-0e0d-08deb4aaf00d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700016|82310400026|56012099003|18002099003|22082099003|11063799003;
X-Microsoft-Antispam-Message-Info: qbZe2pwvFYqi6Hb0fofRb1MsijiIcwmwUqz3yncP9h8HF58mglEbnbP/Cj9cttJ7pRT7Vh6FBTqTkAan5rSCvxDgmx6PtxnlV9bc2rglO3JEikwzSVAiESefi+/W+nc5iyM8Vlets++zz5hIM0ZjyE0daoz823I9X8q+SA8GyMi8w78084QFh9E3HFRAliXAXEdXHa+jQrfgYynbkRrhbzRsuDRYt6SSnB6EviDbvAoQEaANNyxsn+/95PUrdPkCi8UdTEV2y/7BI2urlCGpL3Tp0wstZVEyi9fV6gagPrUqioTl8AXjJU3l6DC86wK/mpp9jjm1tBwG1uGkDCpAk30oeDqcomFFSkRCgdhkvy/IKr3wWj07GF25s7SAaQ1Gl3qK2s1GP4RhPYa5kCcrITwjvEM/9X30xC5zJn6SNIX7+UlnWSCcwlZ61hL+QV2ZKQdPA3ZhAx6vXbpGt/HBtM7txsZT+PPkQfYSWFWc3fSuFc2Fo7rOwOtI/8p+/rgWZLfDxOP2EbNuPW14SYeCxvHOkOhw83gO1bFUC8NQKKc3qJXragS7dfq7G4D0TkztdLsqoV8skQEjTfT7CH4Pz2DQ4M0ZI6mmHerlS0yDk6gtRChexCrIyOiRHtCbZeLgxRKgaY4Vp2/wdlFyjNt2kU0mfP6pzOqwot9xT4S6BKK7UU/9QvZmPblka5Z7u7eDPn+nlvK0trPb8pneZk9bUIX5cOIN1zKgbS550AgHkbs=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700016)(82310400026)(56012099003)(18002099003)(22082099003)(11063799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Ge1yaspPx7LTRXBcGw+1m0OUfct0rxXk82aRZuhOCswIyfWXiexesng3OC3H0+T/Ho7PXevS1SNUxlBpyV6QYBONPhhmJZBVc3UWatt+JE/N++Xgp4IhGeu2oSumAx+fuPwAbY1jC7FhV2HO/xkSbiluFWAMuZkq353xLHvOZgz5un+vBTcar0cLtePTXopApFhn3jcso4fBZX3h6LuldbqZS4/BhAE+crO0eVtm+OxpsocJFQWlpSNm5jXQDwAy2It0Uiv9DWnN1B0z09y4tz95KigdB3H1HHgvMSiLfFTTzsdvuLOb3+2UPHdmqU7DnZ3ET2uQfJ4kCyiXu2Q706FpgKkrJpHaNI9ZZptiSnfgyzViLSK+UnemN+7jK8bM1H9k+5ai0TaoSbn8E+PyBbu3Zv4/lhjfJd7W8bfZ32xGkAXi8PE1z8fJ2Wh8dTgQ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2026 06:58:59.7684 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 054115db-2dee-4db6-0e0d-08deb4aaf00d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000009D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5797
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

The original addition operation in 64-bit unsigned type may encounter
overflow situations. To prevent such issues and safely reject invalid
inputs, the check_add_overflow() function is used.

Signed-off-by: Ce Sun <cesun102@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
index ad3d371ad7b9..a3de2481a054 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
@@ -826,7 +826,7 @@ int amdgpu_gem_va_ioctl(struct drm_device *dev, void *data,
 	struct drm_syncobj *timeline_syncobj = NULL;
 	struct dma_fence_chain *timeline_chain = NULL;
 	struct drm_exec exec;
-	uint64_t vm_size;
+	uint64_t vm_size, tmp;
 	int r = 0;
 
 	/* Validate virtual address range against reserved regions. */
@@ -850,7 +850,7 @@ int amdgpu_gem_va_ioctl(struct drm_device *dev, void *data,
 
 	vm_size = adev->vm_manager.max_pfn * AMDGPU_GPU_PAGE_SIZE;
 	vm_size -= AMDGPU_VA_RESERVED_TOP;
-	if (args->va_address + args->map_size > vm_size) {
+	if (check_add_overflow(args->va_address, args->map_size, &tmp) || tmp > vm_size) {
 		dev_dbg(dev->dev,
 			"va_address 0x%llx is in top reserved area 0x%llx\n",
 			args->va_address + args->map_size, vm_size);
-- 
2.34.1

