Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA527F417F6
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Mar 2026 14:56:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4068410E517;
	Mon,  9 Mar 2026 14:56:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="flLnyTIB";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012047.outbound.protection.outlook.com [52.101.48.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EA88310E517
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 Mar 2026 14:56:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sRN/FWIu0auoPWni0LxylxmoXz7W58cSJXD0qSN9qmkH82gcYWmpIlRvi+4HRBTAhqJ4ZKnMD5eo7icPSn4DsBctuVLSu+P8zRDWk+SvaCWn9XE2jOyjohMQirOMifKvnTJ8NCnB7QaCLOTuKdBfRoJe9dVmeYssnLzNE0AyEYNBNzS7OyDOnjPOLM2Si5rNbxRaFizkGPXmWVONt9EWs0efgyPiwd2McTVUqBByEFJN8Yink7JmjyCW6ZCCpWt6LagmMiuL7MWZ8Mc1X9sTs+kmn/FL/rmTq/KVVr/E9gU9NGKhBg6SkL2Ii/tILoYN156f8ePJXV6FmlzRnX5E4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jGLfSNarxof6bHfrCFWGUrC0zJkWTbrWyQhwF2FZ+b8=;
 b=R/7AhzX9DDfso7uTAaSdqwYKgNqFYHFfVOgq3S8ySF/LuqjjA9m/1X8rPPCqXIlhZSgsEZnUsVKtEgVoDNhpejXOEsdFBEgcwV7+eaixAv85ZD62ebHupxHuW58uqmrhD3svcYywbYv/ckwF0xdUzetCyYcmyTE9cl82HnLoofd6ZuGTAco+dCQaCFO1/o3Delc6cJCQDK5KV1+LwagLL/NVzeL4aURdxW/d5EwmcVgGwINmuz786365p8SuqefMFvL+qotRK+f1XgQptCUtdoV/ZMmyP2PnlRtr3PHOugMQa4RgVV7Hsq5oIl2kkfFG7klb8j86naoITHcPF/H1bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jGLfSNarxof6bHfrCFWGUrC0zJkWTbrWyQhwF2FZ+b8=;
 b=flLnyTIBfVbdpRo5BrKO2/Vri+GADIY6scb6WmlJByhhT3YkMSTjKQVP9+YgrnQJUf6KHH0Ut14+p/R8cn9M4o5wEhoSrUafEWi0GC2P/yvwEeiezcnDgP6JAQOQIMpav1FgNn6GplYnogYot51Eo/CZiYSzXOVTan7KHuppAxg=
Received: from SJ0PR03CA0240.namprd03.prod.outlook.com (2603:10b6:a03:39f::35)
 by CY1PR12MB9602.namprd12.prod.outlook.com (2603:10b6:930:107::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.8; Mon, 9 Mar
 2026 14:56:46 +0000
Received: from CO1PEPF000066E8.namprd05.prod.outlook.com
 (2603:10b6:a03:39f:cafe::93) by SJ0PR03CA0240.outlook.office365.com
 (2603:10b6:a03:39f::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.25 via Frontend Transport; Mon,
 9 Mar 2026 14:56:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF000066E8.mail.protection.outlook.com (10.167.249.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Mon, 9 Mar 2026 14:56:46 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Mon, 9 Mar
 2026 09:56:43 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 9 Mar
 2026 09:56:43 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Mon, 9 Mar 2026 09:56:42 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Hawking Zhang <Hawking.Zhang@amd.com>, Le Ma <le.ma@amd.com>, Feifei Xu
 <Feifei.Xu@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu: Init table depth and block_size for A + A
Date: Mon, 9 Mar 2026 10:56:15 -0400
Message-ID: <20260309145629.2844495-5-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260309145629.2844495-1-alexander.deucher@amd.com>
References: <20260309145629.2844495-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: alexander.deucher@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066E8:EE_|CY1PR12MB9602:EE_
X-MS-Office365-Filtering-Correlation-Id: ae0608b6-bffb-4009-f1a6-08de7dec15f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: p0NMPM7wiy7tHuFehmHetl1tsIq/ugSVMgHbD9+OHUBbSuyMl7z1KGppkNSQ2r/hjM/08Lljo3FiBUUmwrOgptdVs7B+JK9YcwT96OKRHUCfAGQVziP8mlA9UilN18OdcV0RQY+uJlvAyVsdEOFGFY8Lnrflr6myI6j2VzEnHFMydDQ7LFD2pFWHopl20tqtUBA/sg+tYUb+f35KWLipaGKdBnhNy/Ea6TkOUk8cN61veZtqrKf3gKsiBKK3BiTE+xfGrJFVsmfUP4N/CTgS2YD0B8Sc7kDuyzmEoMcfFu7iOuv+g/wHD7NAmLZfCNSNTUNHnSW4yqlA2cDNJW5+qY8gm+prKMNeHTb92IJkP7WuOSHBpr58Pp5cE3tbb+G1rnp7puwoMiSQxE5ReE1poxAtQGT2if7Yit55TJ165NExbxwI44Eg0ZttiMLq6ai+6x9bv92wMh+GtmqBKZM/kpTjrrqLePphRYQNjjFuTecvXNC1L7tli5dovawhmQZ/CcRUMMJnehmQP+kCsn6L/mhGrfh4KBiRh1q4PHud6ePNUP3XHyWuzf7shaD85qLdAVsyOm4E4gM6yEqybZLQUQvChPalPKnhD/jp4rvOSQAl+iugCHa8vAHicD5/HUIrKD3eL3qInK4NIE4AHUt0EWCC/j5Uy6yEcB0AjqLMRU+kOAuqf/48YN+kHkkMGyUwl6UKMtZ9dWK1y6QElonANAj4QeEgM96kyUvvc4zCJm+H0gFPTM2wri01Ms3LQKwQhjCM3RlaNxwyZxn+uEynPw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 6vgRs+Kry9BMo8K0fdG+/ElXISehqmPhCRJnDXMJuRKQTHNYwLv0EsIs7pTClaptzQ1bnz+jEVDJ8Eb3VldVC+4z//USArEIOwTYbZl8RJbTOvEW+rUF8XYKXNlM/oY+iATYh6QZxuMDfFS9WcA9HvujpXH8J3lr5vyBbAKYqFiQSH4SaGd5mYxzE/uF4RjYwdvJBuA1dY+pVTJSNlRsQq6Ma9DdJb669626nHj0d74KjfL0qQN7wugapAinsKniHlvNHP+sRse5P/SFidG5R0trCIHOK/vDo4DOadqbrNGODGvqXXQ55pRfjHPJwCERTDFPhiAw48AZR9RSqf3jlc17KPwMyDIBlaWp+MHj9x8rBK0QGJV78yA7jJQVjWkBjvFx3IPt58aJmqNHmIJSj0TGbKJtlGvhX0m42DACM2R5WQSy6Mq0vnIoJs2blojq
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2026 14:56:46.5969 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ae0608b6-bffb-4009-f1a6-08de7dec15f4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000066E8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB9602
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

From: Hawking Zhang <Hawking.Zhang@amd.com>

Initialize page table depth and page table block
size for 2-level gart table construction on A + A
platform

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Le Ma <le.ma@amd.com>
Reviewed-by: Feifei Xu <Feifei.Xu@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
index a68a398afebec..f5a328bb421db 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
@@ -765,6 +765,14 @@ static int gmc_v12_0_gart_init(struct amdgpu_device *adev)
 		return 0;
 	}
 
+	if (amdgpu_gmc_is_pdb0_enabled(adev)) {
+		adev->gmc.vmid0_page_table_depth = 1;
+		adev->gmc.vmid0_page_table_block_size = 12;
+	} else {
+		adev->gmc.vmid0_page_table_depth = 0;
+		adev->gmc.vmid0_page_table_block_size = 0;
+	}
+
 	/* Initialize common gart structure */
 	r = amdgpu_gart_init(adev);
 	if (r)
-- 
2.53.0

