Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A150CCF2D6
	for <amd-gfx@archiver.kernel.org>; Mon, 19 Oct 2026 08:34:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7039310E702;
	Mon, 19 Oct 2026 08:34:17 +0000 (UTC)
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010061.outbound.protection.outlook.com
 [52.101.193.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 78FED10E702
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Oct 2026 08:34:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZMFe91CrbE6+My6ix7qjY544jiPo7aG/i3JClsw+ESwbielRA9YTcVYigFYKUGuXQ+8hevWLslPeHYeQWRgdaQAXO5Re003dXruGZ2uCV/Z2Xq0NfnWQgL9Ou3UrgP4zEVHpDbxKWhX1gZSgfYSoetgmzjoRUnasUexv7umw6tKWvL4qwrjGiHOy02eSI5Sbu7tnJTrAVcq+HM1Sm1E+1ELFTmeS/qpp15qIjMYHGBjAOG2uhpH7zpLSB6r9i+67kn3TVh6PbdL4rX6JAZQAbB+y7tMyx7yhYRW9IaaZzUmt6CkT4HvML0jmB61MrQbSzanU6CipKCVk9x+WgFr3wA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rygehLqm678oKJJndZte6X0u1RY8qxxynGkbTxAPan0=;
 b=lw81zFJgOIp/ReXUGSERHB0pgZ2VdDSss7zCg0Dy1BTg6eSGZyjGwB4XFJNVFf1z7QHJ0SGY8xrKuK9HBGXfzX5TwCqjPEjXM/UG7YTEAkB/4EviPbpf2YPOkUgPtU45oVcFPp1U27PaQfBeBmuN9XIgDIWjKuTA9BE8L5ydjDz9Hvk03lZJ4+g64oRHMolookVi6vVWTL8WhRiqrdvHDGJPfV6XUkcq/hYfuoY3O0wuAeJq/PKSZd6AwTnnDvPFEN7UBGikWuk561jbzTs7HRcPWzlhFa19PUslpAMGS4AJ0Gy8PNa+QEcGLxCdL/n+O8N21tFiEzuHe0AxNOVrzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rygehLqm678oKJJndZte6X0u1RY8qxxynGkbTxAPan0=;
 b=HxKQeyfJkCeo+8qKSFKuMOXlsnZqGSuONHk6CXroSIQot7MPsvKJetnxDjtSRlkIpu61CW9dxNlXzn4QTUfRa9jQvHAjUyZ6CtBtRu8jy5MmHxHPZqyKnx/1mgk/fEICOWSHMojupnEkR9AZvEi/j7VJvECClaiydfSYXPP9BxI=
Received: from PH7PR10CA0012.namprd10.prod.outlook.com (2603:10b6:510:23d::26)
 by PH0PR12MB999114.namprd12.prod.outlook.com (2603:10b6:510:390::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Mon, 19 Oct
 2026 08:34:05 +0000
Received: from PH1PEPF00062F23.namprd02.prod.outlook.com
 (2603:10b6:510:23d:cafe::1b) by PH7PR10CA0012.outlook.office365.com
 (2603:10b6:510:23d::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.20 via Frontend Transport; Mon,
 19 Oct 2026 08:34:05 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 PH1PEPF00062F23.mail.protection.outlook.com (10.167.243.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Mon, 19 Oct 2026 08:34:04 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Mon, 19 Oct
 2026 03:33:57 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Mon, 19 Oct
 2026 03:33:56 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Mon, 19 Oct 2026 03:33:55 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 <lijo.lazar@amd.com>, Jesse Zhang <Jesse.Zhang@amd.com>
Subject: [PATCH 01/13] drm/amdgpu/gfx: add a reset_engine callback
Date: Mon, 19 Oct 2026 16:33:01 +0800
Message-ID: <20261019083402.2033724-1-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH1PEPF00062F23:EE_|PH0PR12MB999114:EE_
X-MS-Office365-Filtering-Correlation-Id: 7cde3354-eae3-4b31-c122-08df2dbbbc03
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|23010399003|82310400026|1800799024|261009223027099003|10067099003|56012099006|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info: 8EJNkLhI7JhM9kRCeXJkvNif3oVVv0xpeCOgl6krn0u6EodpHrmTux+njojyFnx61g3lOzvfrSqsK36p4gIzzDPBjWg19k8dtqnc4qzXbtsBkJo94fPKnn8Crf7YA8J/8UnuMiAF7UyvvHve+/GZz1KJ/w00Gay0M9hbZ/iGFQmI3EhvXkI/FViAyWTz6+Bi4hLRBJs9vMuLLfobYe+IJbCQ94LZd016kb6fQJ54jq6QoDPOVHKXqeLrDHsnrAh6Y02daeI8k8IL9CE+CHQnGV5nuoNFgd7G0QFVeAbh0jyGU+ewPgI0fXS0h+LMsQ4fJ+xs0260MvmIEZOJwaM+/XVlAFxNg9FIi2KJXPWZ3JBoFCLMMJDyBMpKIZTKT0Sa488Uhrhi02Yo/y8QErbAV4Pq+zVleeWiOG1XLJpNOMsufSRlploDZBylRLHxpxguvVBuBc9yBiOYh6jAwadgHdy/ofI5ZxighaDjEJoG2Ov019nJOtPwnUCc4Ctugu/AlrhzW6cCZ1RQZAbMCJMcqphOv7R3/+bw/QKRJ6RfGEaXWsnsYxFx/YclMdPtYq2kyPcGXnIxyhEbYC85gzf1hi2HUDuti2LgytScUMOxBd6chJhNamkkhWgzbYISKU0b09StncmoghoTff1w1uT+l5/WrQrQCWjNO9ffsGG+9Y6ipbyzOULnz/Bmkiz0lSBe
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(23010399003)(82310400026)(1800799024)(261009223027099003)(10067099003)(56012099006)(18002099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: LT9fBjbxSMr9CuTY0+LFllbtIjee5yorTJ/Tc+NEmTYnp7GtsC5rQOxO4Tp+eF6dP3F90zkbLmAxTD1u9fR0mFannXPuddUkDycjvLA1JB0bvkOMLlIa6bbjl+yv5bWbO7hw8VPtvmv1Rl4gnA2GUJnOvAV9hQ+P3tsL1S+yottcir6KjAuHONWI/Lx/sr7YjNXvOVYHuYnmjCxYqhj9f8gRwoJQxMVD3U4BErIs11J7Tgu3pe+bXyzpOuE3Z6coUZuIjyfuUYIgtq0aadyzzHfLY0EXoXlsrW31l9BNWM0L8bQwcsuGc0WZRhXjWI5KgeS4PPdcN/1/wNTFMmC+Md0mObAhhZMrNSAZNhu3pTTpESvZ3K6tXFfX1IC5dG9eYeEcZfs/pn1j/ecG/CMNizLyrYIuj+RVRqXMzhhArycZODn40dwFrR5gAvEHW7eQ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2026 08:34:04.5756 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cde3354-eae3-4b31-c122-08df2dbbbc03
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: PH1PEPF00062F23.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB999114
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

Some gfx hangs can't be recovered by a queue or a pipe reset, eg. a CP
front-end stuck in the middle of a packet. They currently end in a full
GPU reset, and VRAM is lost. Resetting only the graphics engine is
enough for them, and leaves the compute engine running.

Add an optional reset_engine callback to amdgpu_gfx_funcs that resets
only the graphics or only the compute engine. The split is specific to
the GFX IP, eg. CP_SOFT_RESET_CNTL has GFX_ONLY_SOFT_RESET and
CMP_ONLY_SOFT_RESET, so it doesn't belong in the amd_ip_funcs that all
IP blocks share.

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
index 5939e1fb3b24..5bee0ca6a209 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
@@ -345,6 +345,13 @@ struct amdgpu_gfx_shadow_info {
 	u32 eop_alignment;
 };
 
+/* The engines of the GFX IP that can be reset on their own. */
+enum amdgpu_gfx_engine {
+	AMDGPU_GFX_ENGINE_GFX,		/* PFP/ME and the gfx part of the CP front-end */
+	AMDGPU_GFX_ENGINE_COMPUTE,	/* MEC and the compute part of the CP front-end */
+	AMDGPU_GFX_ENGINE_NUM,
+};
+
 struct amdgpu_gfx_funcs {
 	/* get the gpu clock counter */
 	uint64_t (*get_gpu_clock_counter)(struct amdgpu_device *adev);
@@ -376,6 +383,9 @@ struct amdgpu_gfx_funcs {
 	/* find the gfx HQD slot (me/pipe/queue) for a doorbell */
 	bool (*detect_hung_queue)(struct amdgpu_device *adev, u32 doorbell_index,
 				  u32 *me, u32 *pipe, u32 *queue);
+	/* reset one engine, leaving the other one running; mec.reset_mutex held */
+	int (*reset_engine)(struct amdgpu_device *adev,
+			    enum amdgpu_gfx_engine engine);
 };
 
 struct sq_work {
-- 
2.50.1

