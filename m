Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE989CD5BD1
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2026 05:51:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7E28210E234;
	Mon,  1 Jun 2026 05:51:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="w9NUVMeD";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012016.outbound.protection.outlook.com [40.107.209.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EB5B910E234
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Jun 2026 05:51:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=frmDLEFjwB3Ah61bSR1wuKd7WcSrmE/XzM4pMvO9So8yEP3k9ybxLeN+wgv4JB+k4Khuc2PF95KdsSznsObQqQTImHPsLiwy/EMXJehe4ecLEEVbKkCfcYApWhAV9NG4sVIw7Nqu5AfXu0tQW3omGfhZh8Q/KVX3Vil6+nwWjy7WiYcubUxoRaMW56MmySmuXkXZkQZe0bnAQ3qfy5217vMeMbVEZ+Y+/5dKHr9J6HzcL/ABEtJ28hIzf4wmSRActNYhMhOBAMfs70a82qGulBI1h0n3+IHt7UbDnAHFnFEo52mu79fhpk0ThHy9YjqCjMtH7s9V+MPPzMS8XJYkRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BqnyolBxSSbqKNGbO0b0JohepgsoJzEfseN6FlsPJmo=;
 b=lsiWETT3ZWiIfsgiqJ+SA+g7IgOYHWCfQPQhzk3lhhOwMDR0BC8nCSakluA7L1iuOgShlbksXRgn39YcKcrbrGvCkjGhABo8BAktG8z/8BWU1Rgzl6GRzWnl+K0EribCI1XJmUpiMxKtwa4/UkR+NgsZ0xzkMJejfd1AJi9bupMPgAZmG3LtiYzhLbtkQiKIDWgz5s879j3+Un68D7140BWGxSfHB7uK6eXO2Aezynf19xApCezhsT8YkcEZL/xf7hN9FUaC89hlQGgFmlqDR4BUXx5q77xI01CIWfNGbZzyogS0ggT6TZ5dKD2ArQrjMmX+1pt+LYQS8Ij5xUrpCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BqnyolBxSSbqKNGbO0b0JohepgsoJzEfseN6FlsPJmo=;
 b=w9NUVMeDQ+hZ2oYBC8jkJb9LCayUiARhYbjnLVcj6AXXow1gKxeJxcNtDNVe24kyE31ItLjDWDJI7B+DjNU/M1fQXD6hqt4tFenTC+HCxvpAmfRMIxzThP2oKgzfLVb8SF51KaAlmx/knpXLPJUAaSEWpNFdmC0wuHOtaepAVuU=
Received: from CH2PR20CA0011.namprd20.prod.outlook.com (2603:10b6:610:58::21)
 by CY3PR12MB9656.namprd12.prod.outlook.com (2603:10b6:930:101::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.17; Mon, 1 Jun 2026
 05:51:36 +0000
Received: from DS3PEPF0000C37F.namprd04.prod.outlook.com
 (2603:10b6:610:58:cafe::94) by CH2PR20CA0011.outlook.office365.com
 (2603:10b6:610:58::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.16 via Frontend Transport; Mon, 1
 Jun 2026 05:51:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 DS3PEPF0000C37F.mail.protection.outlook.com (10.167.23.9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Mon, 1 Jun 2026 05:51:35 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 1 Jun
 2026 00:51:35 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 1 Jun
 2026 00:51:35 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Mon, 1 Jun 2026 00:51:29 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>, Jesse Zhang <jesse.zhang@amd.com>
Subject: [PATCH v2 09/42] drm/amdgpu/gfx11: only need to remap KCQs when reset
 via MMIO
Date: Mon, 1 Jun 2026 13:48:55 +0800
Message-ID: <20260601055034.3700921-9-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260601055034.3700921-1-Jesse.Zhang@amd.com>
References: <20260601055034.3700921-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37F:EE_|CY3PR12MB9656:EE_
X-MS-Office365-Filtering-Correlation-Id: 83384920-32a9-4a55-d4cc-08debfa1d78d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700016|82310400026|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 5Ms6RlVlYs0VW9WcrSleZFJ4pAzoDRBWScdhBYuH186KEBBwDX+Ovqkw0hC+DvNTPoekarSjEhCAS5qTkIirp26YmCIZXaVFn5WHMaCW/5/bmgV4yYkYxyLYrqV9b8h8b9Tn1vNmJOsRwhuXa9xl+XzyI5RcnpRWHfGjrXbTsbib7ArWLaE4mM03IYFYRCmeGDyK4rsA7K8UMvfw+roBWUwaUZtdaA5O2SGqa6J4xf8o9RXaf+KvASsULhR2HUT6Z105gsBpXJIx+ONdATvE/pgGQhleDHbk1yPi1RRD9VdY6KWoQTYwujkUlyGWUZmP96z7ISegueI8rwM3WPFXzcagTBuUEktBaBagjXcMIlpwSdzgF1rl9cMXfDL27rGwqaD+HLM7WQ+iIOex1Ijw/g65cSKiG3bsjSdBcn1kwLs0sL4bPgfcD1d7ZMDPyjd0FYRXRzHzCrPm2vwiMjUuLcXGy+PdyiUS8gSdlL0QIweu4osDAVs5tt8bYYQDCWiMkNEiDvkalZ9jvKqVJ5Fr5Tdl0zL1Lq/8RlCMNp30XrJ9Q+zNOtWnWP8BYYAKgYZeHamSlHB7TTdb5mP3sg9SF6gJ4Sj6yWpTl/cilNBFW7B7gvuA+NP081JbG0vFje/2FJh7/Icsit7Vwtiasi3AqNcoP0drShn2Evky9DVXtEgxsoRFXYhWmxbtS1smW62MBadCAWnMKKKKFCMK0SISgE6hNRPlYaIL8wMYcv7yt2Y=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700016)(82310400026)(11063799006)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: SFZk3TUuQciSqK3WPWhCO42sjLnYiLNh4I/OYi24PXpDyOGDpfjmVh0gkCi7eE6CFLrYpIaI8c68XzQdI5bd0Vr44VsHIhXDwb5tMYwvxi53qHZZuUwRhmkewY72tmF4LOuwgJqrSUik45eiq1RA8mdMSqWMU/KQ5tn/PX850Ydo8ZzY2/loJOJY0wzKfUwcsQM3+R+D1t59sWch4SUPvgJmncAuakeD6nIgXdIh70t5DtHQh0uVB/1Fuh8HV9Sw4vpYaGf84ukS/GsT33JMWBxJx4pV7qAUl3yeD/J0ml3QWcXQAy20sMGel9tXewwzH+bmHqBWbZuXgOnQjOUX8tbpWprgiNxhqzVUPUERVKuYqBUj6Nvuil1Gq8OK7OD74gGdIris1hMTbcMLwtQguizV2o16Ywu405wzpqqtmTZ/OSfyLK5vLboQoVpmwv8w
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2026 05:51:35.9643 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 83384920-32a9-4a55-d4cc-08debfa1d78d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF0000C37F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY3PR12MB9656
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

From: Alex Deucher <alexander.deucher@amd.com>

MES remaps kernels queues as part of it's reset sequence.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Reviewed-by: Jesse Zhang <jesse.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index fabdbbd0abb7..dd4f33d2ce45 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -7009,11 +7009,12 @@ static int gfx_v11_0_reset_kcq(struct amdgpu_ring *ring,
 			       struct amdgpu_fence *timedout_fence)
 {
 	struct amdgpu_device *adev = ring->adev;
+	bool use_mmio = true;
 	int r = 0;
 
 	amdgpu_ring_reset_helper_begin(ring, timedout_fence);
 
-	r = amdgpu_mes_reset_legacy_queue(ring->adev, ring, vmid, true, 0);
+	r = amdgpu_mes_reset_legacy_queue(ring->adev, ring, vmid, use_mmio, 0);
 	if (r) {
 		dev_warn(adev->dev, "fail(%d) to reset kcq and try pipe reset\n", r);
 		r = gfx_v11_0_reset_compute_pipe(ring);
@@ -7021,15 +7022,17 @@ static int gfx_v11_0_reset_kcq(struct amdgpu_ring *ring,
 			return r;
 	}
 
-	r = gfx_v11_0_kcq_init_queue(ring, true);
-	if (r) {
-		dev_err(adev->dev, "fail to init kcq\n");
-		return r;
-	}
-	r = amdgpu_mes_map_legacy_queue(adev, ring, 0);
-	if (r) {
-		dev_err(adev->dev, "failed to remap kcq\n");
-		return r;
+	if (use_mmio) {
+		r = gfx_v11_0_kcq_init_queue(ring, true);
+		if (r) {
+			dev_err(adev->dev, "fail to init kcq\n");
+			return r;
+		}
+		r = amdgpu_mes_map_legacy_queue(adev, ring, 0);
+		if (r) {
+			dev_err(adev->dev, "failed to remap kcq\n");
+			return r;
+		}
 	}
 
 	return amdgpu_ring_reset_helper_end(ring, timedout_fence);
-- 
2.49.0

