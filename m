Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 757A3C5DF7D
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Aug 2026 19:52:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0881A10F438;
	Fri, 21 Aug 2026 19:52:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="NFACfaEn";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010041.outbound.protection.outlook.com [52.101.56.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F12C210F436
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Aug 2026 19:52:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rhRpmNR9nzDobZ3Hi7DX7+mlePuY4X+PD9csQsNz6wRfixlBUDfNTFWpe5LWvJrlZ2CvBzB7eUZfqICNUqm840JEj9DP0Y1HOyuyMH4Zdkkxv9ioxN6wZgt5y/3tSa8htcxJweTXh49LJbDj0ctlX68fQe1bDDHel/eo1LM1KJ9C2f2ZTyPinFkrGBqMbETUPpmEszIhDHHL14Z7esopQ1W/tnmdRM0s3N/sl7JBJQUDp2134ROyrIaElawZX3tW3im1jX6ImCWxL+Hb9uQxuMNOoJwuDNhMxKgTDbVg0FTkU0TgyrbgsIjbx/DSjTl4bnjkLOy/fbn8f8xUGFwAvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tt8x4FCT4WeRYf904ppURI0A1gpC6v3Sou7cszHo0cc=;
 b=FfWsvlVdMAU9nbCGnNiYsXtHhwiUOS7/DouQCUk891C6RBTB6TOAHdk5WslTmzCARob+Hoo/1INA19TMoWD/IfrALNtzubF7qEI/N5RzHwUbuQDF+Ytol8oa5104wM4OCi7ZnsFQANmKfEoSrYzUHV4nTq00kr/YlDLEtx2XydKelERfT3soOr0+X6yvaX/MT1Vhd3ELJXVfZqXPJBIOICXsoae5cD1PVaCVDIFg/zRMOgvA5bNaxm5iVWzTtxHERWm0lNGb+R65YwfFei+GW+AlCvO0uBwgmGfTxDcXu02BWHOR4dW+WU5C63tvKxa3VzNPN/qwGxRrFAvQDbzTiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tt8x4FCT4WeRYf904ppURI0A1gpC6v3Sou7cszHo0cc=;
 b=NFACfaEnMqKbZB8LG7h7RiVyefORC1Jj/SKSVhvSU2Fga1ZsWvfD/Y0Ta8CBnK64jz9M9p4g1oyQObJ4yWtxVFNqFBk4gx7IJ1Bg1b+Gmki+lroMJI2aYnxI8HBf2G6m8Hy4vu722r50YMwPX/SFAIy/mSDkhqB1AUA4tSy6vko=
Received: from CH5PR02CA0002.namprd02.prod.outlook.com (2603:10b6:610:1ed::14)
 by CH3PR12MB9284.namprd12.prod.outlook.com (2603:10b6:610:1c7::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.11; Fri, 21 Aug
 2026 19:36:03 +0000
Received: from CH1PEPF0000AD7C.namprd04.prod.outlook.com
 (2603:10b6:610:1ed:cafe::5c) by CH5PR02CA0002.outlook.office365.com
 (2603:10b6:610:1ed::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.11 via Frontend Transport; Fri,
 21 Aug 2026 19:36:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000AD7C.mail.protection.outlook.com (10.167.244.84) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Fri, 21 Aug 2026 19:36:01 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 14:35:57 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 14:35:55 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Fri, 21 Aug 2026 14:35:55 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Felix Kuehling <felix.kuehling@amd.com>, Mukul Joshi
 <mukul.joshi@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 72/95] drm/amdgpu: Initialize NPA PT/PDs to noretry
Date: Fri, 21 Aug 2026 15:34:35 -0400
Message-ID: <20260821193458.808626-73-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260821193458.808626-1-alexander.deucher@amd.com>
References: <20260821193458.808626-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7C:EE_|CH3PR12MB9284:EE_
X-MS-Office365-Filtering-Correlation-Id: d7f4cada-51a4-4cea-e09c-08deffbb6f0a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|36860700016|82310400026|11063799006|10067099003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: R887WrRK+gptBucOzK3i5cF9FmwRK9rbahVpwvGsgxptYp9OD5yOVFIUwpRRdTWtCb6775sUhQouTbJ5ThPWZrc50P4U0UwpoT3Ou7e5uOyhWvqGZSyl7au0lZow2npckVy6fo3FPLZQ3xGB4FZqpQmivn2ok2Wk57JjhiLGQErP7mNSWN916sv20dw3M/uIogfD/tLjwKVPvC4qDWd9M6ow3/nCJF/08QP3VihFVxZ3kKD00DTG11/zihRG8TmO3xtgGL5EznH0zzQaJ2ZNuPa6CXE7aHfIlZ3CK2WaZHEN7CuacZAeUO0xL6VzW//onInZo0NFmWgGmobKTdDmgP7XZnb0hca+1fbMYhdtqtq68Rk0NtC06Sn2BVCsQaOi9AL8qjjMC3gjhUV8sAf5X/GdImGO58qNCwTPbAGD8HR9G12A+sG0V/vcErIK+6qmFJxjnAxTvfAatkKuGZPxw20ul6+LcKk2TDipYDJCq+XdUwB86X79+QWtHVPIUJPdVoo4Qdt5LyXew/3JdwJ3cz8IuwdHftMR+xix7SmiEFiGZX9+2TXG3OhNVpDwheWWE4BNnWoVClVwUAmnLQlFasCFQv6T/UvhgguRXr+FBTUozKy14nTSvjEbA3VUhELAlF+lV1sQ29IVOCfAmb/WBPeSzN+rCIpYMN+XadxwqptTRSHGj3fwVGuzKjgBUaZMoK150XN7jTQa23Er33wnsQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(36860700016)(82310400026)(11063799006)(10067099003)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: +HkvMq4mT/icmcfo2RibFmTteWkuj7trNW4Q7tmT9AtUW85BNe1naGaKfCNniquRDC7CYEa/1kePjmTz+6e48CRAGRObkuulDhirDKNArSSzxFGZ6UzmyOJK8as4xNkAmnL90I2ytNi0q3Gz1b6u/vhTOGmUsf05tAE9PGoQw6LCeWAVrDxBC+yFzsCEHhaucVz/2zlRBA1V1XDSRY3XZ4vjyHWEpGPboW3+/zLfvIdk2NI7RKj7/u01FAf4kJbNoCsTnO6YWyUJrHE2cqFjt9z/z9O0BH8pZd6TkRF8pW4k9d9dOk2vPc6opcSsR0wsYuuChsjU5QasaQ2VJSVQoqWHH85mQwE2NrcUb42VTN7/knMQq6FgFb1reGE/q4GgWcN7XQVYqfKPz1ACWai0Ktisp+3Kmqc6YLRykBQ6lXybe9HNv97mivn8L6Ne8n/Y
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 19:36:01.9608 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d7f4cada-51a4-4cea-e09c-08deffbb6f0a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD7C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9284
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

From: Felix Kuehling <felix.kuehling@amd.com>

Unmapped NPA addresses should result in no-retry faults on the importer
side.

Signed-off-by: Felix Kuehling <felix.kuehling@amd.com>
Reviewed-by: Mukul Joshi <mukul.joshi@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
index ff69a3c828de3..35ec1a3c11a36 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
@@ -407,10 +407,14 @@ int amdgpu_vm_pt_clear(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 
 	if (adev->asic_type >= CHIP_VEGA10) {
 		if (level != AMDGPU_VM_PTB) {
+			if (vm->is_npa)
+				flags = adev->gmc.noretry_flags;
 			/* Handle leaf PDEs as PTEs */
 			flags |= AMDGPU_PDE_PTE_FLAG(adev);
 			amdgpu_gmc_get_vm_pde(adev, level,
 					      &value, &flags);
+		} else if (vm->is_npa) {
+			flags = adev->gmc.noretry_flags;
 		} else {
 			/* Workaround for fault priority problem on GMC9 */
 			flags = AMDGPU_PTE_EXECUTABLE | adev->gmc.init_pte_flags;
-- 
2.55.0

