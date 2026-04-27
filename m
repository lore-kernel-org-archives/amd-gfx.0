Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70172FF8868
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Apr 2026 16:00:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E4C9710E7F4;
	Mon, 27 Apr 2026 15:59:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="dGUe6oVO";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011019.outbound.protection.outlook.com [52.101.52.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0C1FE10E7F4
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Apr 2026 15:59:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CBqask34f4DitoElUv26yKfkCR2jdfTs6CbJONuFx//47OH2dyeOW3u039+mrey5TZhh+yoLMrUItnM44o8dM/tjuCBtL7ATffRCFGZ0Tjl4xGkmzl3hh4aKSMUxtlu307dtaQqRkXJ7w5E3M4mB4ErUbmiq/LqmC18YVvQUDjA8wTK9ZINecgUiHKNj6bKdXQzpPiH9qeyxl1D+D1G/AJhHY0CDz4E2nRA7b6gQ40a+mj3ZQh7R5rUWRJ/TJ32a7NKGL/WPJBSviL9gNKfNCE8bfU1hH8PISFmD2Db7hL+MjWsYOMvtsaGlHTNzTSUKXyX3AWPWci5MyIxAQmCdZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qj9aZYwWaBWv4c1O/zjbdiLh8z4cANu/WWSQWKz6qkE=;
 b=VHJuWxfHxQCNhKq4V+knMzUT8hDvl666+cm42NWx9jQBoC284GxnecEFSi82ZKFuVx1Zm4P5yq4qZsEFi5Jy3P+Y2EuATPdpp0Dd2VC+P2vAzhXrTWZZv1/7UK3DMvEu4pB4f9BfA0Pt3O8c+ftqL2Is0NJffh/xEnVGzUDcwvRBjRj3W+6xvoCiM5TC9oj1p84wZPNrua4kkLwanytKeYCVKcUhFcx+I3Z0/Azcue90F2tLzMUb23R59w3YgYrOcwUgAfUrkRLBhx+OQh17LIiVz56Anhc4CVWg8EqRIL9LVDip5DPploAcsyKwJlWlEvwFd20y4/N3it3bKOj6AA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qj9aZYwWaBWv4c1O/zjbdiLh8z4cANu/WWSQWKz6qkE=;
 b=dGUe6oVOT9wpTAxSZ66cNOrMmvvgGicShfrH2gPLHBt8dMhpr/NLhQfnh28PL9+3C0xnwwoRBGzh3cyCCeYnw2nksA95g9r8iocq4MbKeTiczSMTs4h6A6fLjGmOB3qARsIHu7WPN7Gn+PV55ba3XTBRc+RiEU+OCyUDGGijV4I=
Received: from CH2PR11CA0024.namprd11.prod.outlook.com (2603:10b6:610:54::34)
 by DM4PR12MB5796.namprd12.prod.outlook.com (2603:10b6:8:63::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.15; Mon, 27 Apr
 2026 15:59:48 +0000
Received: from BN3PEPF0000B06F.namprd21.prod.outlook.com
 (2603:10b6:610:54:cafe::f1) by CH2PR11CA0024.outlook.office365.com
 (2603:10b6:610:54::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.22 via Frontend Transport; Mon,
 27 Apr 2026 15:59:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B06F.mail.protection.outlook.com (10.167.243.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.0 via Frontend Transport; Mon, 27 Apr 2026 15:59:48 +0000
Received: from yinjiyao-dev24.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 27 Apr
 2026 10:59:47 -0500
From: Yinjie Yao <yinjie.yao@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <christian.koenig@amd.com>, <alexander.deucher@amd.com>,
 <leo.liu@amd.com>, <ruijing.dong@amd.com>, Yinjie Yao <yinjie.yao@amd.com>
Subject: [PATCH v2 07/19] drm/amdgpu/vcn: set no_user_fence for VCN v5.0.0 enc
 ring
Date: Mon, 27 Apr 2026 11:58:45 -0400
Message-ID: <20260427155857.1370151-7-yinjie.yao@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260427155857.1370151-1-yinjie.yao@amd.com>
References: <CADnq5_MPJG=S+B4kg6v64xD+8pDEbG5z1Q7j-2A+CfStmuejTg@mail.gmail.com>
 <20260427155857.1370151-1-yinjie.yao@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06F:EE_|DM4PR12MB5796:EE_
X-MS-Office365-Filtering-Correlation-Id: a1597df0-016f-4528-3400-08dea476021c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700016|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: +USPUfqAN27R24hxRMcD269NFxOP87D7oBQIukcD2jCKXWvP4IcUmV2X8sabxyJdAml6SGgXTnOX7HKOSBfb6YNhblRlJzgQphtDnXG5itMGan85vv4FTpBEmqelHtzXgy9+4a4ST2TgFL+Pi4/DARxFPHcJt/r/LhTnQZq9XgOgs4giq2fqaEOvyoYnURByxUhG1Cku3L6zgDcrC+dvjFnt1w1+k8f6deaxsdLrNVnxWGhrFLdwaCzTDhKXAmDoK59zMxlWS46tcCRa2kVH7PND8GCmuWtlFcS35NfLvIo/Zfi0pwIOw+LKocaYP9G0shGEeCZGTxPDOchlT8H5FNH1OfpGvVTLW39IVkZ+V2KPwzmQBJQiccQINohy4KjwUGAqcaXQ5/HGiRjVudZk9PAbbTFDLGEbRn+d438woJFzoJduU0vQzv1B43Z1X2QvD2TItCgtnEhN4CFQ7rkn+WVqyzbIfoOx2RwG63dpp690Dxo+9BllAHJRe40Hvga5ILhdD1c6l+3HcqDUjgY/XlTO0pXxC6NYY95HnWpCH5dVVWX+TfsWIZNLPOWsmoPYZSEowt5hagyxCGRKk0yCALH+y66xtf5Z2/2Y7FZFn1INrFkxocio+o6pA1i2BLoG5lret+A+B60lj5YqkeDiaHFvDScg+RX3lJ+O5JJjfCIuIwOQB9QjgWeosRuoDKaNbJkkpdSQFQgTGxoE7jrJSWKNkuFpugX8xNWJxJWAP66BG6wAccdygsBgjPrqOFql4+6o4VS4sYfvZiHvJk0wwg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700016)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 3BcHtZ4DvlUC5Ql1/UW5SN+tdZ7GnO2UgpP8TG38XY554/TpDhscjwIfPKY7MOL/XxrSF6AkfPhKZFRywi3Hre8wXZn4PHvvZV41HDdjg2r2cO0QCrb2NPjULrKaJd9prwIW6vinX04Hcs2UACRlG3FBkftuKtmhc7KNuTsMBSKx9Pi3oiPp/A2S8IbBwV/r8mS8sbCZUalkvAXruxR1N5lYxTuT1zBC90+mvlJ6062YcvLtM3NSp+PPsSOAKiJHjQVnj8ZZZ3J478QaJqoPxlrO0cBl1Gx+8yYDLamKWzBCWaZBhvKL5+pWGDyWaKfeo8uI8knbvteskC+P2Shga5TvztQIUGN/yGG1ln11ZLa1eK65MqGEYrT2kLbejd69/R68PfKIhaGSc0nP1sEUbKL+DReE3nVSZAeoY8foVkDcX5lFGJnWRAa+Jx9eovHV
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2026 15:59:48.1256 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a1597df0-016f-4528-3400-08dea476021c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B06F.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5796
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

VCN encoder and decoder rings do not support 64-bit user fence writes,
reject CS submissions with user fences.

Fixes: b6d1a0632051 ("drm/amdgpu: add VCN_5_0_0 IP block support")
Reviewed-by: Christian König <christian.koenig@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Yinjie Yao <yinjie.yao@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
index 6109124f852e..d5f49fa33bee 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
@@ -1207,6 +1207,7 @@ static const struct amdgpu_ring_funcs vcn_v5_0_0_unified_ring_vm_funcs = {
 	.type = AMDGPU_RING_TYPE_VCN_ENC,
 	.align_mask = 0x3f,
 	.nop = VCN_ENC_CMD_NO_OP,
+	.no_user_fence = true,
 	.get_rptr = vcn_v5_0_0_unified_ring_get_rptr,
 	.get_wptr = vcn_v5_0_0_unified_ring_get_wptr,
 	.set_wptr = vcn_v5_0_0_unified_ring_set_wptr,
-- 
2.43.0

