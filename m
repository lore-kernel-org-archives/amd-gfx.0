Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1416C43458
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Jul 2026 14:34:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 71E3F10E4DA;
	Tue,  7 Jul 2026 14:34:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="FydzKi03";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013027.outbound.protection.outlook.com
 [40.107.201.27])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3E39210E4DA
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Jul 2026 14:34:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w5xz/cmc9EiAAhX5t6kXYKsDHRg0Ph6/lHzsETAJkZz9qB85uc5lxZeah2PJgwXD/TtoRyExeDpx0kuTbIaEKfCH9Egme0G5ZLqblbhlqkCtSdfm/XyAiFuK9jPmzqq573xUttfW2h1yIThjnTatYKBt4FUdJi/gX9JD8aS1lfCuE1MvpCuYoEMMtemGlHBsKf6ciHDPDnuMRtIE4AAInUzZNN65/dXl351D4W9ySH4b2Y8q1ohF8i39EgaoFL8DSa3a9sK+R0TCeKezohQrdU8eg17uj+JMMOfpUsKaXYufMUJDHtLgV1REVpIbpUW2HATPC1X1YGEKzF6iIM0A7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Waz+ZyL9rOacfuezixXS2IoJUw+DTyzZF0Moz07/d7s=;
 b=Lp9ad0yBP9cpKVn1xhs5lA1JwpWjuPzOQ5IVJfGTCJk+8O/yjsM6vf3yW1Xl3xaH0UagZP/B7xXM0VUcxm1oUedLLewRtyc2dsQO0JlOksgkbO8+S2cxeUwnPh64CNQX0Ri6WBz3UaB++ojkEGriWjnl/7ttj9LOuKJsbvOOBz9miv3gruMbsWpcb+Pawf8yrKZQVGzXNATZuVMZKAHam6GV9QufuVDpPffIgVsxTPNvBlqewbioQwKnbEkezVnx3j1CzYDizknr7SxI1SnmSJXNXA12sX5VznGPCjQ5PDTYRc6T5gre6dD/ZD+xkZO12nWz92NBUl0+oPUQRJVMYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Waz+ZyL9rOacfuezixXS2IoJUw+DTyzZF0Moz07/d7s=;
 b=FydzKi03O2dmQMNq+4Z8TiaVoaCkEB07JOdcRazyfUOzbdKGV/lqcywL87Wr6HFtU2oxOlFbiIT99QQOSG2TUgwFjLpvo5eG3JC371C2Hp5LnOuqAwKG+8XfvzVsTW7JypdZLJcaChZyzJcdlUKrDmXo79fk/uLQxszs9J0+gxY=
Received: from BY1P220CA0023.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:5c3::11)
 by MN2PR12MB4440.namprd12.prod.outlook.com (2603:10b6:208:26e::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.13; Tue, 7 Jul
 2026 14:34:31 +0000
Received: from SJ1PEPF00001CDD.namprd05.prod.outlook.com
 (2603:10b6:a03:5c3:cafe::15) by BY1P220CA0023.outlook.office365.com
 (2603:10b6:a03:5c3::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.9 via Frontend Transport; Tue, 7
 Jul 2026 14:34:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00001CDD.mail.protection.outlook.com (10.167.242.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Tue, 7 Jul 2026 14:34:30 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 7 Jul
 2026 09:34:30 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 7 Jul
 2026 07:34:29 -0700
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Tue, 7 Jul 2026 09:34:29 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 2/6] drm/amdgpu/sdma7: don't do MMIO in MQD init
Date: Tue, 7 Jul 2026 10:34:16 -0400
Message-ID: <20260707143420.2104857-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260707143420.2104857-1-alexander.deucher@amd.com>
References: <20260707143420.2104857-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CDD:EE_|MN2PR12MB4440:EE_
X-MS-Office365-Filtering-Correlation-Id: b1ed9211-6e8e-45f6-60d0-08dedc34db56
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700016|82310400026|23010399003|22082099003|11063799006|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info: 0uY7TO86YAFNgGJSIwOpsyqSlY4FPzq7VbHrd0hW9Mq4KdYwRxIcN8Jel9tbTZA+9SFYZ8ZdriEZBgMhw73IaSc4JpqTkjmM2eo8F5Qj1R9HKGMg2eh09XV0Gxmi33VKtkCOLBsgaKTlTyZfj97Iz7Nvce8bbLzWvDgKe1YSciiiQtlm1cOfvy8XbW9N/DwrbKzoiz1Tv18SvL9xZ2fVEpUiW3YtPWYk64tiPKApjVmwsjc7h8zT9/i4+9XEn93UQqQ9SFvrzj8FxXLspz3dqDwErndGj1xrMi5Gn1mAlsLGc9L+9BocM49ONQ6JIBmd7iD24X/6uzzPtSqU2XSDJzVNGkj+P2KqHVbGCDICnJv819LH1BymJus79qC+lR4JGNjUlfWlt0+VmgQYXtRboeT3hUzaldzb/Ml2wVRpoZYZmwmUimyRemqy4n0lhNcAoDAdF8IDsrHI6OQjx6CX3pm5vV9UuAHIA7kqOKob2kAEGzANRLcDUBnG/Ds5l7kx1xaPV+isGxtOwellzRlCDczp6A6iNPiktcX7xEVo1eqyJ9BQwKH/W6mBAKjZbdOpPnR17O1kewgqwsnU6T7cilBbVLwo31vVPrkAz0vjbj7OGvLAWF1O63x3AkI6SzopceHEmjUYtieQwI/Z/UErKlvg/qu8HYVqNCbw7B7oCPvHepKFWxSif+9/OEDi3nRDtBcV/UQwdspAPBKd2cSZLw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700016)(82310400026)(23010399003)(22082099003)(11063799006)(56012099006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: tBtHJyLqB7fyPX8K2Q5Ez0YqYEmfnsmNPg0wn+E2LmesV5SbhBQcRTB3EYz0fm5XaJaygUJBxpUYmxfqf1EScfylWEw4YyMyo5f7IQxtLfPeirg+esv+Y+R9XyrxtC/rJ37fjsE/Gt7aPOyJWNLRscjotDmMlcYMMGQ3GBT+8adn8vkF7B2+eMGWUjw6NH2UslHIJHlWUhf7ApcE6UhFGJmy2+PDNn3+KQVm/ygvTmo/hWdL0kWvowN/CswoDO0PaAaVKy12eTtKpitH47pmK3FBnNN4wp6iFfMYPhPsrMvg0IXcCDztm8ui4s5bxGBZCwG1B5iRPDO9eeFzErgwm2MfyxtgahPv8Lu0lOwZRNUTbc30NXAs2TjovnGgtUSIi35jFG294mOsFPaS9vNB/8UGbV8YKwT4X8RsnJe/CnPG8F/g9pUQCNXvYQTpkGK7
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2026 14:34:30.8253 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b1ed9211-6e8e-45f6-60d0-08dedc34db56
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CDD.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4440
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

There's no need to read the register, just use the default
value.

Assisted-by: Claude:claude-opus-4.6
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
index aee370b2725af..eb27fba285c1a 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
@@ -886,8 +886,7 @@ static int sdma_v7_0_mqd_init(struct amdgpu_device *adev, void *mqd,
 	m->sdmax_rlcx_rb_rptr_addr_lo = lower_32_bits(wb_gpu_addr);
 	m->sdmax_rlcx_rb_rptr_addr_hi = upper_32_bits(wb_gpu_addr);
 
-	m->sdmax_rlcx_ib_cntl = RREG32_SOC15_IP(GC, sdma_v7_0_get_reg_offset(adev, 0,
-							regSDMA0_QUEUE0_IB_CNTL));
+	m->sdmax_rlcx_ib_cntl = 0x00000100; //regSDMA0_QUEUE0_IB_CNTL_DEFAULT
 
 	m->sdmax_rlcx_doorbell_offset =
 		prop->doorbell_index << SDMA0_QUEUE0_DOORBELL_OFFSET__OFFSET__SHIFT;
-- 
2.55.0

