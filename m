Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11467C5CFDB
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Aug 2026 11:30:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 019A510F2CF;
	Thu, 13 Aug 2026 11:30:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="WT3wBuAG";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011070.outbound.protection.outlook.com [52.101.52.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CFDEA10F2CF
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Aug 2026 11:30:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S2OuMiuV+jZxwer3cpq+6z3bOE/Qt71bU751+LkYDM+rkxYFUpEThjD5t9+SHVKOQQqFTvVnX6f4GGkUscPh8Kh6k1GKEmMsTmfepI7/TH5SpHlARn/ZC0TBI38ki02eNOtetea5gpbyWA0SoNOFy9Io2gSDvzfPgNb+V7gzsEgw9b+zCucqeqkK+1tC7qbdVusdFPVNV64Sl9xo/K8qG4aNtbKXDHZzw611DxrvRVAERdKIjHlyxuafFLDb6vsf6sOOfkiaZ61/zuiz2uwIF6w6cnlV4/v9L3cS0D9P1mIPW6z8qS5aMMCilEmmeZGN1xt/0AiWrEVWlSLtT+MJ1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IrT6OTxuFp9Up3XCXmrbSFql0s0Nz322FWqz1G6Tc1s=;
 b=nCnofZ/xbCMnEYRvyvFyLiV9snjUf1HfodfgHhEWwKe6p+2DquZWK+82Z5lHBAKQHQqi6xTlX3pqoYukC22PGlnyzhqTfVlP8IBA4hiMDQ/Zl388ruwYYF8MVj25q09Pye3tqU7RgNMiR3d928+L82tn8uhDhFWE2LqnBPApRijK/kGKVDdzywenfHsbVCAjnYoRcAVZuvEK3pLFfkojU2ISnaluKWiWgAeocfHImA0HjxJw1joY0BTLAUsrTq39bqYYaAQaepW8vytlctOGQCdX9w21zUUOEqXp0alw4IQqvZWVQ8Kuakk+7Mcc6U3Uga/Y48IMPt1tTLjBEY62Gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IrT6OTxuFp9Up3XCXmrbSFql0s0Nz322FWqz1G6Tc1s=;
 b=WT3wBuAGp+jUtr/hNiJgscfAc5erUOXo3jFhgFxrgCAv4WumwtwT9czNdO1hUgcSJEg4LnXj09gru0PrxUemOyRGtCC9AaksDvAtSAKlkxsrryAklByuEEe5//a+tV6LUauvxyFs3mkkEGYQqC02u7Dasnw4nMyC2hOCni1i8nY=
Received: from BN0PR08CA0024.namprd08.prod.outlook.com (2603:10b6:408:142::14)
 by BL3PR12MB6595.namprd12.prod.outlook.com (2603:10b6:208:38e::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.14; Thu, 13 Aug
 2026 11:29:58 +0000
Received: from BN2PEPF000044A0.namprd02.prod.outlook.com
 (2603:10b6:408:142:cafe::7b) by BN0PR08CA0024.outlook.office365.com
 (2603:10b6:408:142::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.14 via Frontend Transport; Thu,
 13 Aug 2026 11:29:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF000044A0.mail.protection.outlook.com (10.167.243.151) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Thu, 13 Aug 2026 11:29:57 +0000
Received: from ubuntu.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 13 Aug
 2026 06:29:55 -0500
From: Zhu Lingshan <lingshan.zhu@amd.com>
To: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>,
 <felix.kuehling@amd.com>
CC: <Ray.Huang@amd.com>, <amd-gfx@lists.freedesktop.org>, Zhu Lingshan
 <lingshan.zhu@amd.com>
Subject: [PATCH] drm/amdgpu: validate rptr and wptr of a userq
Date: Thu, 13 Aug 2026 19:29:56 +0800
Message-ID: <20260813112956.28616-1-lingshan.zhu@amd.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A0:EE_|BL3PR12MB6595:EE_
X-MS-Office365-Filtering-Correlation-Id: d344ca2f-6ef9-414d-ac39-08def92e349c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|36860700016|376014|1800799024|82310400026|11063799006|6133799003|10067099003|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info: GCU0KtblLijE4uTN73FSfE1ltZcDjGES8NWuaq44jSOsgMVOZbG0l2VeZphpK11xXror/nuOqZ8RJyOItvYqsiJdnwunWOBcpfGNYx/XQ0heYAr2Mpbj9Ks8tst9NMLOcOT2GtnDG97Lawr2aFDuPRkaz1xQzMonhHQTyRYhrU2GKae5Zq4T59f2KTLKHJg6owzDSJ1hS6JcaLwyyiahyBw0GhDZ1t8/RATmQlzATRqMhoywVEOr+SMuaOKeV2D++bcFRcbjpfJZYkYZ8r7STDC0QTD55EMkNWHIpN/8qEQReVsypIn7yMNiLPwfGhdShNfH7lJKNtER1d2LuKsJw7qjJDVAfSd2bKcWrQM1DSdMm1Pxn0GJfwL0I0F2bG5EEXbJ/3RoBEErh7JUd7bGs9hRnkLwqZvGvP5lEK/CcC3HrML7yARBhNtQpTeGJWSY9BAKFwzk7r4wAysDoAIASErwl7yZD3ys+oQ4U0uoRJBLnD7c4ynGLP02saHUBv27ad2GDY7VvXiNZhRAVvSBsqVG6Bcw5bhLttTZzm/rszDK++BkgNKkaxEH1djAOmz62R5j0Tr4WOrjQuXINY/fAaIDq+hq2RsNerZhYUnJ5uDl2cyyqu3aPi+Hzw17FA9UxXNqQUBbQ2f8DWxz+DxhbYxwO+f+etl4NQLre7nZFUm1g4Oc/gTKmGH6ZASavHzK3oqzhExRUAg9M7c35gKgfg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(36860700016)(376014)(1800799024)(82310400026)(11063799006)(6133799003)(10067099003)(56012099006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: rF3DRmwQfW/k+LjIastNu5QOfTDyA6D6dvtTD+/E6M1A52ynUoD3L10CGwZEeL4wMS8Wbc4YjFjHvlnYzj9BjHWppfOQY07Qa1242j/H8oO6A1IuVMf3EaptghMQSPyFC0jgsAM12p2AMhWV+2NEzockUMXmenBvWiicQpPg1JfWtIa+RU82yV+4fFNz9CdMylvbtsmpPu93TmRcWo0CM1b1oaMbgTchCs8veQJPJMQ+iqrwEqXIPnzP8t6z3iJJhmffBIlbDCaX1dyBVUXZkRT3e9TINez03hyX5IOezOZSczKK+Bn34yP2fAPkxNRxKreVGyDZ56Gd4QlGzX2GfebvKOD/EqJYzb8Bwl3MEbQWqw0IgjTQHuIBdB7CZOd3hdWSi/lUN1Ar/F0s+FrlloC4srvyCy9hXNYOm9Bju/7badTlj0f6KvvrAVDox6T4
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2026 11:29:57.9254 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d344ca2f-6ef9-414d-ac39-08def92e349c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A0.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6595
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

rptr and wptr of a userq are 8 bytes aligned, and may
not placed on a page boundary.

This commit checks whether rptr and wptr are 8 bytes
aligned, and expectes 8 bytes when validates rptr/wptr VA.

With above changes, this commit fixes an regression
in amdgpu_userq_input_va_validate, where
end_addr is caculated by:
check_add_overflow(start_addr, expected_size - 1, &end_addr).
Wptr and rptr are very likely not to be page aligned,
when validating rptr and wptr, if they are located in the last
mapped page(or only one page is mapped)
and expected_size is PAGE_SIZE, end_addr will exceed the last
mapped page, means (end_addr >> AMDGPU_GPU_PAGE_SHIFT) > va_map->last,
and causing an -EINVAL, even it is a valid VA.

Signed-off-by: Zhu Lingshan <lingshan.zhu@amd.com>
Fixes: e91d10a5aacd ("drm/amdgpu: fix userq VA validation for sub-page buffers")
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 04639f894903..17cc48d87c4d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -702,10 +702,10 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 					   args->in.queue_size,
 					   &queue->userq_vas.va.queue_rb) ||
 	    amdgpu_userq_input_va_validate(adev, queue, args->in.rptr_va,
-					   AMDGPU_GPU_PAGE_SIZE,
+					   sizeof(u64),
 					   &queue->userq_vas.va.rptr) ||
 	    amdgpu_userq_input_va_validate(adev, queue, args->in.wptr_va,
-					   AMDGPU_GPU_PAGE_SIZE,
+					   sizeof(u64),
 					   &queue->userq_vas.va.wptr)) {
 		r = -EINVAL;
 		amdgpu_bo_unreserve(fpriv->vm.root.bo);
@@ -850,6 +850,12 @@ static int amdgpu_userq_input_args_validate(struct drm_device *dev,
 			drm_file_err(filp, "invalidate userq queue rptr or wptr\n");
 			return -EINVAL;
 		}
+
+		if (!IS_ALIGNED(args->in.wptr_va, sizeof(u64)) ||
+		    !IS_ALIGNED(args->in.rptr_va, sizeof(u64))) {
+			drm_file_err(filp, "user queue rptr or wptr is not 8-byte aligned\n");
+			return -EINVAL;
+		}
 		break;
 	case AMDGPU_USERQ_OP_FREE:
 		if (args->in.ip_type ||
-- 
2.53.0

