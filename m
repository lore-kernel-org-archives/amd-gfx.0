Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1FAAFF8862
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Apr 2026 08:36:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4D4B010E60C;
	Mon, 27 Apr 2026 08:36:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="lcU8h7qj";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012024.outbound.protection.outlook.com
 [40.93.195.24])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3362310E60C
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Apr 2026 08:36:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xAQ6U7tggXzI+5BRHh+eFFpznhFQiHJv5p5gnFr3fT//KwcsgHZWIBt2M5DgHgZdZGUC+2BmIlzfTGcCGAnlRwqKJVyD40LFn7vMrLP5e2/EqjzTGRP39Jxl7x7QpMXVpGmaSPbQxcmbcihqLkEz9xzYhZXpeioRImtbm5eGL+TQiGitmXGINS1ndwYmeLvwq5IwyUZuJ73cXkIZt1Ual9GBYH0FXVBJiMLrbmDA9PKoCdQlgivTguBhESl7/R57Saf1t7B9rqY48K6LBdpWfmI32qNfc2grp6VbjhzD1oLTtlYeBEkaxSUXswPAko41eIMAZ75IDRfDiXXc91xZMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7U45K3DHX8cXQTlPYh6hMdi3lyQqmJSkEBByOy02b7U=;
 b=slZ6jSPiHKpBSXA7+VO1iD/dLsGN9Wb34MxFD9X0HkKgh+MM9Edz/Vd8IzABfwn9TEIL9oCsEZmfjoSv5+49zMSYRr1YyQi84RVn6I4TByGS3LaEO+tQh5fw45U176DkgDmWEpuMcbOyJhSGdQJEy95d45Y6RWbA4rWFrkEofzC6jD3JzZqjgtcZg87T6vTha9O1ktDKoOhmkeWfxHE2gnWq9kPkww8I+eF/6xTbbNkpmAXrX/FXY6ngu15upK5xyieXKNRtxicdOQ//u+WKodCdyQkKeP0vpQsv5elqqrgH6IErxQF1rR5BZf/0590NxfOVFf3Ylpj2Hz3C50WZNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7U45K3DHX8cXQTlPYh6hMdi3lyQqmJSkEBByOy02b7U=;
 b=lcU8h7qjO77KLMjF4wDx4imOxeeMyrU8SzXPAK9KQgcV7aWLx91iAwZwDG9Y6mI6LrDLCMQfUDR/v9dWThH+pkmyx+xpn1LKFezuROFb0b1+HIfy97zsW17zgkxGdCml+7dtjsGiHEVBIKKaZbdv81uFdp7QnandJz7UtVMjj9E=
Received: from CH3P220CA0026.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:1e8::33)
 by SJ1PR12MB6362.namprd12.prod.outlook.com (2603:10b6:a03:454::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.16; Mon, 27 Apr
 2026 08:36:08 +0000
Received: from CH1PEPF0000A347.namprd04.prod.outlook.com
 (2603:10b6:610:1e8:cafe::bb) by CH3P220CA0026.outlook.office365.com
 (2603:10b6:610:1e8::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.26 via Frontend Transport; Mon,
 27 Apr 2026 08:36:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000A347.mail.protection.outlook.com (10.167.244.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Mon, 27 Apr 2026 08:36:08 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 27 Apr
 2026 03:36:07 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Mon, 27 Apr 2026 03:36:01 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Jesse.zhang <Jesse.zhang@amd.com>, Jesse Zhang <Jesse.Zhang@amd.com>
Subject: [PATCH v2 05/11] drm/amdgpu/sdma6: register SDMA UMQ doorbell pool
Date: Mon, 27 Apr 2026 16:34:31 +0800
Message-ID: <20260427083543.1328533-5-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260427083543.1328533-1-Jesse.Zhang@amd.com>
References: <20260427083543.1328533-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A347:EE_|SJ1PR12MB6362:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e736ad9-1663-47a4-261e-08dea4380760
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|376014|1800799024|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: wPO2r2qTdlwvJ56Nwz1Ay073lFrhKadIPRaPB/k0sQKlbkebzyVPPwQ42Rtz0OIZoZXxMCC5wS0VcHi/0rmUS+zy8V6CYkQNQRpL3Wl/DW24VXz2GyU0EfD1zq0dlRwrYElWKY4k9zlhbOD+ztqJ3NTbtulgRIrAqnRQZP7za1y6BZIdf5EvkwwHreFruAWdKb9Kxy7DqZ1p8OJW9XSh2jTYL78WZl3b5p2VSRFjEnhe5m3nNKIsIQgifWhDjHXyyK4s/HUs9OwuXVftP4j05ufsEF9XtYp6WbFSY8cqcID4j5QHI7bOwBeJMUA7uUILq8Xk3mD0iVvjNkPn13KZNL4oAGOvUQ9bWSAk+R9uVlikd06LsRJO4zBY5wl5Ebtplf95G1GUMUjG9E6HxoBbSgzSQ9KPWqrtvqu9X41T0LoSeOnvFyu2WxjKnOU6RB6jYXNpYhUFQ+tPPTrtebCT2oahdLxuv4esJAirfJ+CV8dSmUYc/7wJ/D+bX8ZGFQ7ipC5CIV1MXja8ADU4UeAdvWg+3geudkOjojGNUCKgverAKzn3GvCp8o9eDpmjD3Dm8aMk1u3quK3gBBbrWaFlM505BIcJaGrVt4UpJr9dZJjm8wWUwbhbwVr6GW0H0J2TXN0puxWZJi3SnfswpLm5j6HIId7gFnCLQ8DjtNNG7iswSaB8sUHicUOijjTdonwUm0P5QMdAGC5wRVs7p3NwxTPi0MzVLbq031ob6zHcqwMIuBsatBiO8+xf11IYKKvL1iG4WXl+6LAlFZlISlI43Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(376014)(1800799024)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: olDWePGu3PXkGsdloftYpU/y9evqGAwt4a+MJvWpGZOoO01fz9PVQnQG3duyTc5QCI7e363LS9akjrpBB4sul8ZFcfU/PFooAYda9G8X1JxgKTPjmG++2LJS+jKWpF40cQDk34aq0mZza+hMr41ra68dFPMW+/7/qbDFv3abuijt1pj8aa/FEC4bCxVPs/4a0Ag9PZ/DIG3ihT8OsbFIAQN9/CwWVB/39dmnqb4TGkmfyeyudLuzlPVGdkK5Tp2IBWcXx/WvyuHh05/FP4fxytGR8J2eUH6EZlU5TOgoGtKv6sw2Tr3OeL0TAusN8LNbwpyeaS0N4OXInQJ8FSjY6wdJSRtuxJleAKXaFw5SMpFoCwS9YKSukV4+6sOdsQ4GfHWjqd2AFS3d/40NcrFI8OYLIoZKJ4/eQfYPCduwcRiIeLJXYtbuhKwdMUnmvVZM
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2026 08:36:08.1780 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e736ad9-1663-47a4-261e-08dea4380760
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000A347.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6362
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

