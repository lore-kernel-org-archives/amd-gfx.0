Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56029CCF2D6
	for <amd-gfx@archiver.kernel.org>; Mon, 19 Oct 2026 08:35:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E186B10E88D;
	Mon, 19 Oct 2026 08:35:01 +0000 (UTC)
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011069.outbound.protection.outlook.com [52.101.62.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B2F1B10E892
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Oct 2026 08:34:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eIYPAdLggHsCfehtsib24dG/G8sDZgPi4OkGIz1y3gkJ5G4fc4ZQVhHq/KT0B9wi6R5dsGPv0HbrzfFAQ6olUldQe4wyrP2mCEHaK1hFrj9MO0X0wI7KnmbSIRKiVbgw3GDMdd3Z0HR6qdscYxuAHY6/LvZOEaFOALOxH8S9SsTNdmzhDy4x0yB0Tehv9ALbEG+uL8O1ZauKz2y18wtEFQ8RTq7AwyqyfhQpb/9msxTvr6NLCQdzIJZHWGfWpHqK6ts2Zm0s512o9NyyLKA/UaNQUPcI3gntYLacobOvccEK0pdWo+Z/9hfb8V+WnKWltGrj8pc8/iBDV8Y/+o1rGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kA14xy2YK54LfLk16tmfyWSUpE9HbAaqE4UY2io3XyY=;
 b=wL7VPV7TXQqWJc5+961PCsgXhilKeJ9y5KCEK2iCfbRpCOFTtjpYJNwIJYmtQU/8LhyH7F3ju+4VV1wCWem4aG8k/dh5uM6gMlUMMQ24hT9XyCobJYq/XaKTVrW1071GtErWsWnno736Yd8+h1kvSBFstpA8uEWS1iHsIzeWu95UUdRo8TgR1rprb6jwiyljdd27B4Q4Dv5gMn4zjEcokSMdxaW4imYLwbB6oHVA3Q02xOvjwkmDkjoHBvC75OyZYFGawmt64NAAaJbH89nwcwf8GgkvgRpWVUedOMaI1w1rZg+Qqa0tBe/B8ZO3SnYL4UatA9v103683guaNi+7lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kA14xy2YK54LfLk16tmfyWSUpE9HbAaqE4UY2io3XyY=;
 b=Zkl6nNKiknOxSKhq4QA8VgCTt9cgSxnJ6OZOR0Mcrbc+UbtBS3wBQOtoktcgpxJt6067+C2LWP13Xvy7kCOVGAmaoA8w7pyGaBGU2D5wrR3zCRbnktmnT/zQ4712GgDHwvrDgCtUN7VJlLKGsCajq9RlVz5sQAlApO7+rzU7EDk=
Received: from SJ0PR13CA0077.namprd13.prod.outlook.com (2603:10b6:a03:2c4::22)
 by CY5PR12MB6382.namprd12.prod.outlook.com (2603:10b6:930:3e::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Mon, 19 Oct
 2026 08:34:31 +0000
Received: from SJ1PEPF000037A8.namprd03.prod.outlook.com
 (2603:10b6:a03:2c4:cafe::84) by SJ0PR13CA0077.outlook.office365.com
 (2603:10b6:a03:2c4::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.19 via Frontend Transport; Mon,
 19 Oct 2026 08:34:31 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ1PEPF000037A8.mail.protection.outlook.com (10.167.244.181) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Mon, 19 Oct 2026 08:34:31 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Mon, 19 Oct
 2026 03:34:19 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Mon, 19 Oct
 2026 03:34:18 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Mon, 19 Oct 2026 03:34:17 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 <lijo.lazar@amd.com>, Jesse Zhang <Jesse.Zhang@amd.com>
Subject: [PATCH 13/13] drm/amdgpu/gfx11: enable the gfx engine reset
Date: Mon, 19 Oct 2026 16:33:13 +0800
Message-ID: <20261019083402.2033724-13-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20261019083402.2033724-1-Jesse.Zhang@amd.com>
References: <20261019083402.2033724-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000037A8:EE_|CY5PR12MB6382:EE_
X-MS-Office365-Filtering-Correlation-Id: ca4e7221-1eb3-4d8a-55e0-08df2dbbcc41
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|36860700016|82310400026|1800799024|376014|6133799003|18002099003|22082099003|11063799006|10067099003|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info: T7kKCyR9KIRDwDALnhHBuaylNdF3hu4ZgnmUVc81vh/W953Gf3wabzYCXZ44ndy3D1YPuP9Y+4HhYlqc2sHBH54gROmfsLyzfg3zY7ES5aH9PTJXkt7KDGxZkpnlfb0StSbKdxdsvehbmheATPmHl0DmxFIlh2PMOQ+m1XuKxWbpz69k7XuvQJ5CwKGUZbDiPcx76Xv4NqhywSWUtD6eD7ZSirrS+/dSu2R/e8+XvQUww6qWfMxtqM861H86muspTyv7Yy9JgFCRhDgMHpKjXMr37L0XgFTFBowFpMEAXrv6hIp/4y+CGKltSqRxN2uPWnFb9HSoFHYyUCTzn0BplKUmEl3OgQFhWZNn+bPwxNtmjwoT0XdVPDqqV0bXFE+419K+QsJbHbTPBvlUmjqwFF99k89muODN6dpK6Wvy1PcUjON4HVcF/AfMx3x3NOEF5mjGuB3mzaDok58llmjL5Kb6nljn/X742Nk6/1vFb0bgS2/O30X0E+2EsoU5JlYtUjM3+ijaTWtoKttf1KJ3D1R3MTcbot1vKbYtcJLs8sMSUq0Doj/er4Pko8GVugo3VEICyWhPRCxKLos8aOfNmr16rLm4EMgm36onXMEpBMOdDHicD5+Awl4kOJyX1LNjlxF+MIzrkvz7MMhmuoS+v+5bpN1eQDZE9B+ZE2xRfu0Yn4aLznTggojxYtdhciDNavB8GCmSwUF+3brnpXrCoQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(36860700016)(82310400026)(1800799024)(376014)(6133799003)(18002099003)(22082099003)(11063799006)(10067099003)(261009223027099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: yew1luQJWJC5aMhO9yUNAkt94RvoGz/+X5KYIEz37R3ar1s1PQ7iR4VpBupOh3Mw4zFKHRFLG6s8Tdgf9Lw9cq6iH6Q13lDMG6ivLT1xDQgyVYdTV/ZdH9r0zBmMqIkJL8mPJlZ72k6igZXtOzJAUBTMqaMsG831xZEkR/GCHLeqq8Znfa64o7nXk96RVsP28h9Hxj9Rl7IbtU7960WXO2b7oZe/RLB4FwyiyOrRgIQQu2BLi1D1lm2JyVzgYMqYwULVzbBPmxbRxYj7HZiqw6Y6ElgVMIU5KXkKYOwNyeAViDNcS3e0Zn+xDymQ7GiTULbkRuDA7oSOf7NfbSF7ESM+HroUBmHccpXVPN9JdbwMgysWzymBtf/+BsoSshYiGO9JiCz49c78Ey5nk59x+R9P+5lkbQW5RyJ6U1cnRTXsMRpHkXzxJaZ/ElZTaJLI
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2026 08:34:31.7865 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ca4e7221-1eb3-4d8a-55e0-08df2dbbcc41
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000037A8.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6382
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

Report AMDGPU_RESET_TYPE_PER_ENGINE for the graphics engine when the
reset_engine callback can be used: with MES, async gfx rings and the
RS64 firmware. The reset restarts PFP and ME from the start of their
RS64 firmware, and remaps the kernel gfx queue through MES from its
MQD, which the kernel gfx queue only has with async gfx rings. Not on
SR-IOV VFs.

The kernel gfx queue and gfx user queue resets then fall back to a gfx
engine reset before a full reset.

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 61811db62faa..8d3a52899fbf 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -363,6 +363,7 @@ static void gfx_v11_0_ring_invalidate_tlbs(struct amdgpu_ring *ring,
 static void gfx_v11_0_set_safe_mode(struct amdgpu_device *adev, int xcc_id);
 static void gfx_v11_0_unset_safe_mode(struct amdgpu_device *adev, int xcc_id);
 static void gfx_v11_0_userq_priv_fault_work(struct work_struct *work);
+static bool gfx_v11_0_engine_reset_supported(struct amdgpu_device *adev);
 static int gfx_v11_0_reset_engine(struct amdgpu_device *adev,
 				  enum amdgpu_gfx_engine engine);
 static void gfx_v11_0_update_perf_clk(struct amdgpu_device *adev,
@@ -1937,6 +1938,10 @@ static int gfx_v11_0_sw_init(struct amdgpu_ip_block *ip_block)
 		break;
 	}
 
+	if (gfx_v11_0_engine_reset_supported(adev) &&
+	    !adev->debug_disable_engine_reset)
+		adev->gfx.gfx_supported_reset |= AMDGPU_RESET_TYPE_PER_ENGINE;
+
 	if (!adev->enable_mes_kiq) {
 		r = amdgpu_gfx_kiq_init(adev, GFX11_MEC_HPD_SIZE, 0);
 		if (r) {
@@ -6919,6 +6924,18 @@ static void gfx_v11_0_emit_mem_sync(struct amdgpu_ring *ring)
 	amdgpu_ring_write(ring, gcr_cntl); /* GCR_CNTL */
 }
 
+/*
+ * The gfx engine reset restarts PFP and ME from the start of their firmware,
+ * which needs the RS64 firmware, and remaps the kernel gfx queue through MES
+ * from its MQD. Without async gfx rings, the kernel gfx queue has no MQD: it
+ * is programmed through the CP_RB0 registers, which the reset clears.
+ */
+static bool gfx_v11_0_engine_reset_supported(struct amdgpu_device *adev)
+{
+	return !amdgpu_sriov_vf(adev) && adev->enable_mes &&
+	       amdgpu_async_gfx_ring && adev->gfx.rs64_enable;
+}
+
 /* Restart the PFP and ME pipes from the start of their RS64 firmware. */
 static void gfx_v11_0_restart_gfx_rs64(struct amdgpu_device *adev)
 {
-- 
2.50.1

