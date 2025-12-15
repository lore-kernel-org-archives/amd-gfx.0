Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2061DD5B862
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Dec 2025 18:16:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1144810E4B9;
	Mon, 15 Dec 2025 18:16:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="nCs2eDrK";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013014.outbound.protection.outlook.com
 [40.93.201.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B54C910E4B4
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Dec 2025 18:16:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PLh376mXiQFNiUt9ix8/919CHIQupnl3pn5DRuqk2xbflYyLbXeiy13+pZFUS6+HOrBN/ZTRXWWUFwmBjkaESyN0miokVwfxcUU3zlsc+MauPN2fzJZDC6FOGMrjlxJXh13S1PQGekYpakNgBwpsj0acpqu0Q3mF/lIXqgN0MAGc3dbYOoD2LA1VWTLiukFnlwcjR1WVRw3C+hkd0yHmeA9BtI9LMQ7NWu7Ru1CvmtqAwpycAdNbSy71Jt0Ag5NDPo4+kTsm2YJBYjH6YpgE6EaJzCi5NeQui4TbnbbhigApYCYJtltrFRfrM5Vjgyyu53sKspBZeJVLCYB9NDM+mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fY8cZfKwW+v1pjt93N+xn1pP4DUMcz4cank7HU8I83g=;
 b=OVGuqQygftuedUQINOYU5Ixl6wMFxvvOYohr0pjdw1miqHu9I7zbK8wW9dwr4xQlxbYGRvBzwaWYtawCPdhhxjv0Q29EJ9T+8ktfOAZ2UkBAj11IqbcJl8h2cX4k01ouze9ybAxLdxEKwQH6r/oNcz57lCrNogl46qp/qTwc3AXuPA6hPDoGcQyNbz0Yj4BwtPt2snWauU3ZvEewHYT3NdLL6f8i2ef2OJsEMjKln4BEMWfI23Q1qLnKVKwN78j/FWahE5lEUu3pzGuyPzDkcWAfufQ1tCcvVqzgklll2M7ftuHNe5+VKPaXnm9UdA0qDSwW2QSjVUMGg+z20ilaPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fY8cZfKwW+v1pjt93N+xn1pP4DUMcz4cank7HU8I83g=;
 b=nCs2eDrKfXfDYOVLGVE5gZVqlj0JY3oB3dcw4yi4xlhS21k2c4r/uFBvma635QHq/KVyHQe42U+OmxMdk5ZZtQF/1nlUIsL17ttccbbmqt2TpuaBynab5LKTlGfqBJz36BAj5Zi5l+BexaFeqOlbeXfqnRoOP3Vq71rjvfkyuRw=
Received: from BL1PR13CA0211.namprd13.prod.outlook.com (2603:10b6:208:2bf::6)
 by MN0PR12MB6344.namprd12.prod.outlook.com (2603:10b6:208:3d3::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Mon, 15 Dec
 2025 18:16:20 +0000
Received: from BL6PEPF0001AB74.namprd02.prod.outlook.com
 (2603:10b6:208:2bf:cafe::cf) by BL1PR13CA0211.outlook.office365.com
 (2603:10b6:208:2bf::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9434.6 via Frontend Transport; Mon,
 15 Dec 2025 18:16:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0001AB74.mail.protection.outlook.com (10.167.242.167) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9434.6 via Frontend Transport; Mon, 15 Dec 2025 18:16:20 +0000
Received: from tr4.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 15 Dec
 2025 12:16:20 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Mukul Joshi <mukul.joshi@amd.com>, Michael Chen <michael.chen@amd.com>,
 Alex Sierra <alex.sierra@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu: Program IH_VMID_LUT_INDEX register on GFX 12.1
Date: Mon, 15 Dec 2025 13:15:49 -0500
Message-ID: <20251215181607.29132-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251215181607.29132-1-alexander.deucher@amd.com>
References: <20251215181607.29132-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB74:EE_|MN0PR12MB6344:EE_
X-MS-Office365-Filtering-Correlation-Id: 90036b62-7b02-42ec-03fa-08de3c060c5a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?hz6dlWdZxgFJppcxv71bjMDhgAy5Wn8w7iAi0BS7kOEKMwRUAkaBlJuc3PiY?=
 =?us-ascii?Q?FHwgHojOYZfoO0rVIeeFUgIRRu3zwmCDIBKaxlirvdK7lD///hj+Aj7XUjBp?=
 =?us-ascii?Q?X8h0dJHJ6EO7e+XIfBSpcPyFuWRfunBj5rODvHJ9xnnUUyhQqkhhPEdz8Ent?=
 =?us-ascii?Q?aDtxR+KhbECQGH/TLaqmQ3U8zzh0ZLu9kxDe6FotBNAgNglGHLl0jPVD3lnz?=
 =?us-ascii?Q?IYQEAPKw4ZAsV78H/bW2DuiEAfqEtJxpqp37f0zGrsyHLhrRRE0koZ0IV+mu?=
 =?us-ascii?Q?u1yU6o18YVhztY2lE4NK8HCGMl9TOt/F2RSXYyBB8CapGY1ClF2QzLYKpM3Q?=
 =?us-ascii?Q?dnCUeKuoydwq9I3Z1jDLF807MQrURlOz8sqs6jXYZVcrycULDnxiHGnWk2+S?=
 =?us-ascii?Q?6hbD5taaoZcAG8RljF8bXfJfN7U26oSmi66yR+0t9niiRXvW2lIb84NgZOC/?=
 =?us-ascii?Q?JXV/FjzlixblxUE7RKhvUws8SKTVf2gA8PHNJo4Kni7p44x76JsrpmOmJKA6?=
 =?us-ascii?Q?23jP2pXj2JJ0b3kSxHPvyWN8K6OJVqjg24qONs9ofU7FikCnAzFaCK8e6q8l?=
 =?us-ascii?Q?orgL8Om4+YcqBlNvNEPGPEDsMo7y4JeUpMPn/BIl4mvYT5sH92WDdoxU6i/J?=
 =?us-ascii?Q?iUDNOIkVBI3KHrteAD1C5QgjIx/cauPPG2cBtG1ENAEEOvFJCJtPek8EcSMr?=
 =?us-ascii?Q?w/I95HMO7HxaFEGQ1eZ2pILPSAlB/wdZEfRMIrq6RaiLTuydvgtjybc+89d2?=
 =?us-ascii?Q?CaHWGurTPfhcUFGDUmUqHTxim1fWUaHCdhnNoN+lFCDsUnQtueb85Zx+ZDmO?=
 =?us-ascii?Q?I4oyyKWt1YlmVwu4xiAGYoRHVIdNglI36kc3qm+3t/U431bfLN+txJgWfAPC?=
 =?us-ascii?Q?DDD+3sFKbtx0uV0ZgtRqxXqgD3eQ1l5mgenHAMXGssz3wRjypoPLMs3nhx1Y?=
 =?us-ascii?Q?rCl4Ol/V3zeSPNCyYekxIURShNIqQ0rGqMp+ukcyA+rwGo6EyhMlskOHrToB?=
 =?us-ascii?Q?gWhEBSWl1eSN2Aed4kOR5TWdVPO36GXO+qPaZfG7FtMiAPOQAUJsHwkFls9W?=
 =?us-ascii?Q?jOa5VX8wEt7PbNQcsAE0DGiNt0BALeIz4sP1Dw0kTdyJjUlXLD8l7ICSSq6j?=
 =?us-ascii?Q?udZz2J8jR+Cbsn8XnHotW/wdT2mKxP78t4HSOJhH1AjlpBx0oSU1Edl4dadm?=
 =?us-ascii?Q?ECtsRiW5fJDew1V7cd8bjieopJk9dRHHY23xfuYa9NztlHV/kxLSAOPRsLU2?=
 =?us-ascii?Q?8nziXsOQ8WBVsiKafgxrEudCl5dHYbduWJFXUTNkTMwU4LzRUoSIwGsWy/KB?=
 =?us-ascii?Q?hpbFD4q0Q3YWt7dTeD/MLDLa8AOrZZALuz5hwI8LI6mbp9TllkO0De3UjtoP?=
 =?us-ascii?Q?8NxjM1/LtRYVkPL82dg8eN3hu3cLA0/5Ggx34W0MkNyZEi97Ss9BdHFm+Zuq?=
 =?us-ascii?Q?TUM7ZAy+Y6r7ffa+oxAwdrHjAaO/TZGZX4Kyx2UaJ13a5EoNPpsTMr99Pxe+?=
 =?us-ascii?Q?goII5fWfLGOnkwcNTXk4SKlLQH0su7o+g6flYZy2BuDOPjkxqI4EhC+mlZdf?=
 =?us-ascii?Q?CPdcUaTf3lwAuOHuafo=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2025 18:16:20.7429 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 90036b62-7b02-42ec-03fa-08de3c060c5a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB74.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6344
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

From: Mukul Joshi <mukul.joshi@amd.com>

For querying VMID <-> PASID mapping on GFX 12.1, we need to first
program the IH_VMID_LUT_INDEX before fetching the LUT mapping. Without
this TLB flush may not work.

Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
Reviewed-by: Michael Chen <michael.chen@amd.com>
Reviewed-by:  Alex Sierra <alex.sierra@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c b/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c
index 061d1be723408..d68e5a2377b63 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c
@@ -230,8 +230,18 @@ static int gmc_v12_1_process_interrupt(struct amdgpu_device *adev,
 }
 
 static bool gmc_v12_1_get_vmid_pasid_mapping_info(struct amdgpu_device *adev,
-						  uint8_t vmid, uint16_t *p_pasid)
+						  uint8_t vmid, uint8_t inst,
+						  uint16_t *p_pasid)
 {
+	uint16_t index;
+
+	if (inst/4)
+		index = 0xA + inst%4;
+	else
+		index = 0x2 + inst%4;
+
+	WREG32(SOC15_REG_OFFSET(OSSSYS, 0, regIH_VMID_LUT_INDEX), index);
+
 	*p_pasid = RREG32(SOC15_REG_OFFSET(OSSSYS, 0, regIH_VMID_0_LUT) + vmid) & 0xffff;
 
 	return !!(*p_pasid);
@@ -350,7 +360,7 @@ static void gmc_v12_1_flush_gpu_tlb_pasid(struct amdgpu_device *adev,
 	for (vmid = 1; vmid < 16; vmid++) {
 		bool valid;
 
-		valid = gmc_v12_1_get_vmid_pasid_mapping_info(adev, vmid,
+		valid = gmc_v12_1_get_vmid_pasid_mapping_info(adev, vmid, inst,
 							      &queried);
 		if (!valid || queried != pasid)
 			continue;
-- 
2.52.0

