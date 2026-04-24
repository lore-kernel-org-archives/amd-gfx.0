Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74D5DFB44C4
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Apr 2026 08:20:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1545710E3CC;
	Fri, 24 Apr 2026 08:20:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Hpkaju9h";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013011.outbound.protection.outlook.com
 [40.93.201.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2C51010E3CC
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 Apr 2026 08:20:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jEb7nxi/rD1le1OdmiEZyadQen1uD3FzSLKRL0Xrxw6KQU8YUHx18vIrOuDZWl2M5u4KNQv4pUNZXgf/3NoKrZHfbxqrR+OtdMeSrJ/MNDA0QRCrBGJWXO6cyoUI2r1W9pgBFxm+QxYZxTZNe2namAtx0b4boHZu6i8Q2eWTXYFCNQ3z6TKb+N7Ad3gH1djHHCh3/5VgM2YMRa6dfBnnpHBjriW1ckcLPwHrNSj0vVyD9qdWiuD3miAxuAGuzHhmldK7iT7BoBpwSCG6H8SjCoxRAYz9IH/LRqtUCBoJgFWxTSVQXq1ogdfj/gs35ioIcYSJULm2zSINy6le3NJ/+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7U45K3DHX8cXQTlPYh6hMdi3lyQqmJSkEBByOy02b7U=;
 b=ud2J6bOKdT9lZ9XifeJqrSVgSOsfya8NPLzPPpqhUm2I3jWibfpw0pDU5wjU7cbGYOu3TlyVlibRR9OXPIz9GP8E+a6B4OGP2i4nY6RLGnKA3W/1VVLXC8gAKj7YBTBblWPtEdfi0PsbHF/ZWdMN12oK4AJCdKTPWl4wr5fwgOOt2EEYBEGQecujWT/9RPi3yGM5yyNgLhTujtyicmFgT4UUeOGgVon76UDcN9qJAX9NCnxgZr0I0PKyyWxTzILL6P9XWRUmqyuhpbPFhhvuNEl4aG9L/KFtzQgmh6HteOh6wm9fghdlI3MXbWCzqtHKClTzKsAaKaE+yQ1a2k5wsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7U45K3DHX8cXQTlPYh6hMdi3lyQqmJSkEBByOy02b7U=;
 b=Hpkaju9hs7WhGuX2X9HRPyaVlCo/Zc6KN5hd+qsnj/RYaN09UX9/wlQAf1ikmKu9Ngn1b7du5+Ijh62+8roum5RwtXL5hQ5CNd40Mriie+IX9an1VGYgOLnyY+OWC4HU4+zWUFTZtusgR9UUIn5W3wIChQCnVRBz9TjNsREDLfc=
Received: from SJ0PR03CA0062.namprd03.prod.outlook.com (2603:10b6:a03:331::7)
 by PH7PR12MB7137.namprd12.prod.outlook.com (2603:10b6:510:1ed::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.22; Fri, 24 Apr
 2026 08:20:24 +0000
Received: from SJ1PEPF0000231D.namprd03.prod.outlook.com
 (2603:10b6:a03:331:cafe::24) by SJ0PR03CA0062.outlook.office365.com
 (2603:10b6:a03:331::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.22 via Frontend Transport; Fri,
 24 Apr 2026 08:20:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ1PEPF0000231D.mail.protection.outlook.com (10.167.242.234) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Fri, 24 Apr 2026 08:20:24 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 24 Apr
 2026 03:20:23 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 24 Apr
 2026 03:20:23 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Fri, 24 Apr 2026 03:20:16 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Jesse.zhang <Jesse.zhang@amd.com>, Jesse Zhang <Jesse.Zhang@amd.com>
Subject: [PATCH 04/10] drm/amdgpu/sdma6: register SDMA UMQ doorbell pool
Date: Fri, 24 Apr 2026 16:18:49 +0800
Message-ID: <20260424081955.873090-4-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260424081955.873090-1-Jesse.Zhang@amd.com>
References: <20260424081955.873090-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231D:EE_|PH7PR12MB7137:EE_
X-MS-Office365-Filtering-Correlation-Id: b6ccdc6e-55ee-445b-6ccf-08dea1da55a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700016|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: kQy6Z7WTULx1zJui+/I8DVV/ZD4DDJTyhpwNz3nnZSftO9JmfWZhq9cIuiLOyJX96NgCJtLs8lxggVfD8pyFXS5PYdpJzDcqQpttsE++JSAEKzNqupf12U9ESI2TTg3ZRHruYzYHfreZEiO9kSI/bcuTs7QhlGO5DRx1kv+retmWhlBT8WjWuEUBqKnxZVL7V5CKaYeCP+NUutUwqJ/wM1grj/Q8jz6HPWRGfF+EQ1FQVRlkIdyzPoFIHFDWrCC1RtmkbgVo2jHLUWxwtUYr8ymg45o2jWtdzsIE9XMFEj5Wg0KSH1w9AJT4vFP47xtIfqIVpDPTCzzMhj9/oOEtJzqAh9kVsMb8RULHbwhqT0SnZf0z2kMKvLhJE53zTEFqgftTe1eS2/quZddykoHczkB8LbKs9TBf0V3aUs09GfqHQIsBPOPWzCgBCBSdk5V9UnMVvegg3BxH1xbkXZtrm2zZgxaOISVjJ0AChVOZ5ykpVHd+IJYwFTxeHJvzJmLGzfEL0QkgYunF+Y9KowY/nm5Ze3yJEnq+TKGnGc2rEFfhWbCBRjgG4uUwvCUsfHXO/y1tz398P+GfkXURdt9NrsolZRt7XqHLAYUdLjs9Fm74v/P96WHCTaRoMhVJ4goRbmgfOWVquFMTcaLBcEdlukQPVMTpJPBULL7uM5eBFAUVK9dyOINO2TZprOYy0cFQXlZAImW4/gN//hck6KHna20IM8CKpcIIwSG/nx6CAes3FA9MstJRob1EKNgGq+/vxw9cN5S+r7T2Cr15RcpXNA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700016)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: hbdPOry6f6+cibx3vLw8oRc5ArmmmknTqNNn4Z8oDnf6RJbT0hkPgd2MymrmX448mW7EG8hhXMaskU47iAl5N+YOWK+sLPchof3DYHDSq9NPhPuG+kHGCT9QWs4y2ZtZqznfxyYWvkmcHnxmQCSvo4rQQbze+KRGOpX7Thy0Gb3XNC5viNcs/wg6JUG48UHwsrgONhlA1LAychcXDF6qOYmtNrkiozPj9K10nOP4sIY+9UX+RQ5LhA2DKKOWepkSJtWxc+ja0boOPMYBRrRkwLdApsxDHWmk/kRhdFF3NGuOyWMcRxHWrMTtrNkzAvSahizRHJRXaQHHzS6bP428PLltXdfk/E7lZaFGFo9d9wtKA9hlRRZUSlYpg9/7Xuc2Z2cW+wJ4tq+Je1BcaqyD6L8suzIOQD5HNeLy7qu+/DVUFwK0RXn9ZicQV1GziuBp
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2026 08:20:24.3689 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b6ccdc6e-55ee-445b-6ccf-08dea1da55a5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF0000231D.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7137
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

From: "Jesse.zhang" <Jesse.zhang@amd.com>

Call amdgpu_sdma_userq_doorbell_init() at sw_init time (gated on
userq_funcs[AMDGPU_HW_IP_DMA] being set so we only run on chips that
actually expose SDMA UMQs) and amdgpu_sdma_userq_doorbell_fini() at
sw_fini, so SDMA usermode queues get doorbells from the
firmware-managed NBIO routable window.

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
index de329b76a00c..02eeac3b2e11 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
@@ -1426,6 +1426,14 @@ static int sdma_v6_0_sw_init(struct amdgpu_ip_block *ip_block)
 	if (r)
 		return r;
 
+	/*
+	 * Init the SDMA usermode-queue doorbell pool inside the firmware-
+	 * managed NBIO SDMA decode window so user SDMA UMQs get doorbells
+	 * that are actually routable to the SDMA back-end.
+	 */
+	if (adev->userq_funcs[AMDGPU_HW_IP_DMA])
+		amdgpu_sdma_userq_doorbell_init(adev);
+
 	return r;
 }
 
@@ -1437,6 +1445,7 @@ static int sdma_v6_0_sw_fini(struct amdgpu_ip_block *ip_block)
 	for (i = 0; i < adev->sdma.num_instances; i++)
 		amdgpu_ring_fini(&adev->sdma.instance[i].ring);
 
+	amdgpu_sdma_userq_doorbell_fini(adev);
 	amdgpu_sdma_sysfs_reset_mask_fini(adev);
 	amdgpu_sdma_destroy_inst_ctx(adev, true);
 
-- 
2.49.0

