Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B68C7C9830B
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Sep 2026 21:25:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2C72C10E9A1;
	Wed, 23 Sep 2026 21:25:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="hDLNYwU9";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010003.outbound.protection.outlook.com [52.101.85.3])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CCC5A10E17B
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Sep 2026 21:25:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fnFjL1JG8bYXOXGzbQxuKHo7l+DVZI3DXx3Jv4/6pr2bJol6mBYdCoxlh31sYwpDNz+apWny96CIrEjAF5jn0Nl9u2RE8issqJdgi4l+tVCt481hjpHQLxrfu1cxXKLQTEl9LgzAlLjtSrdCmGzcIJuiLIQ7zXAmQBvcTSHHHo/qAN4qQpGJtj+PlBSbZ79kTlNrDof/86wmCQ7yOUOu84v3XFL6FgakZUW1WN2ONYUVRMb7l9X9/MVANiqitP5sh3ZRseiFHUSvxL1bBSYxK/9YZzxY+See4FwhO8+74Tw5QhhWZXot10fwny6S0JfwewhMMsLGVcT8u59NGvvl4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MH3JozxWtzcowSt5LpuRKSeMMqxyPpd1mDLqzhaeecM=;
 b=QgeCXdRpmypXrY+YHFlPm2mRaMT8K3fM28nqs8a9UMYtHrG59shDZ8OkdHoUHeLLQMyFHAcirEG3wYtzoFRF/OHlF3frb4rHXpAz+ZInjoWVd/kTOfCQDiYgzv1jaINL2oAvO00J1gZkhqxBBeLc4lsPq4v7ioY1I6TN2aYdWHuKiqv96vMG6WasxLWC7rTqm+6YsbFMIbGiAu1wKXSuiF4DrjtkQG6D+Ze/Hb4k8Smx8PmW91JsD9tnlhhfMo3L8G7f68t+Z8BBwkXE/C1c/JagrVUogpnSopjmuhlevabx1xzGTOL0aLFwj9qvFlHRZZTT7I2ViPwo5iVCXT2Weg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MH3JozxWtzcowSt5LpuRKSeMMqxyPpd1mDLqzhaeecM=;
 b=hDLNYwU9tlDF6+YWFgXuwlSVc25ZKYzFkv5QpIdO+VZLa0EYYqvFjUM69T0KY5dYC6naT3gHNgwvnCFdZ1lGwW4TGMAFzzKRR/jgBIUsbut/31eiFcD4vYbG5JiDuYz8CobjU5FHeAqe5p2gaPD+LRnmhRDqb9bKapvk0Udg4yo=
Received: from BY1P220CA0004.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:59d::15)
 by PH0PR12MB7079.namprd12.prod.outlook.com (2603:10b6:510:21d::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.22; Wed, 23 Sep
 2026 21:25:44 +0000
Received: from CO1PEPF000066E6.namprd05.prod.outlook.com
 (2603:10b6:a03:59d:cafe::32) by BY1P220CA0004.outlook.office365.com
 (2603:10b6:a03:59d::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.14 via Frontend Transport; Wed,
 23 Sep 2026 21:25:44 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF000066E6.mail.protection.outlook.com (10.167.249.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Wed, 23 Sep 2026 21:25:43 +0000
Received: from mukjoshi-dev.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 23 Sep
 2026 16:25:42 -0500
From: Mukul Joshi <mukul.joshi@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Felix.Kuehling@amd.com>, <Harish.Kasiviswanathan@amd.com>,
 <philip.yang@amd.com>, Mukul Joshi <mukul.joshi@amd.com>, Sashiko-bot
 <sashiko-bot@kernel.org>, Felix Kuehling <felix.kuehling@amd.com>
Subject: [PATCHv2 1/5] drm/amdgpu: Reject UALink handle ioctl on devices
 without UALink
Date: Wed, 23 Sep 2026 17:19:59 -0400
Message-ID: <20260923212515.1420047-1-mukul.joshi@amd.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066E6:EE_|PH0PR12MB7079:EE_
X-MS-Office365-Filtering-Correlation-Id: 090e3a82-30fb-4151-e013-08df19b939cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|82310400026|36860700016|1800799024|30052699003|10067099003|11063799006|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info: PhvLK8Mo6qydsRzuYJXfFCTgadzVs+g7fnsi0BRegeeXClrsvByZRXgqdyMAbam0pj3R6kQNdiCNIFHTjwjXGUOIduY1M56lfrLkTPMRWc7qFLqmnT/CO4tUVrJw4wY76ISe5C/NDiL7qEQyTT4GGkEqdUtVw38wJn3uNPkjmJc5cSLLagZq0vtMzoPne7+vQ4fG18dvFzXqqpoWZFaq5HTH4Z/1sCcBm6r6FPZavpxyxuzVlTw5pAEGYZLJq+kXyoRSSrhLe1i3qjFZK91jwYKMuspL6rnOAPxh71g6LFRS20An2zd8iSb5adGDB5hUnm6FDbMSPysS7JbbR3ARk7LB2nNnWyJq8Dsh7QAeNq7XvcafBGQF3MAMT7mcQfS6/n/0vna20Fxwa5/597+S4oM35K2Glgp8cQjkzYNqNlMmfmp66+W00nKoty69boppWa//VQZj4lfdJG7xk1/knX12hz0/T9LdIS6P0xR+X86LoaTs2IN+GTg6bySFiVw9Tj9Me+6F8sifgCsItffduL3nR4/QTIfnmOicMCWlauyCR/FVJEA9ujdBCqdOp1TiwJlJXJCNmr8ed3c3lVGqXkBWYZPAOJ43fX1s0xvga73zY8P3cT1HB++Aae3k0a6RTjYag8mF1YcDmb5Suv3UOI41zBlolGbJxdKsz3XY6zRNwH5x1nJQIJM8xiiOD2/qHMmdp4jNhOCeaSFgxkdAlw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(82310400026)(36860700016)(1800799024)(30052699003)(10067099003)(11063799006)(56012099006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: A2ANMJUILEilDSstoHVPhwFFePuAoboTTHyMORAVE/KU2va6Uxl41BZSJFWPMAPR8hvU1pvD99bI+HGv6K8xYYMMYyVplNcmigx1yC2qK2eA9L3cV9ClZvpx3ErmJ7+0avTXdsklJQb7qfA9bRAm4cjU6nJxKOaqcmyiyFweLbShJ7CRPYe1BsJJ8vW28jb5iPMcdp8p8qCZJSmP7XBhoTTFATWtLOmd9wSFfmHHo7hiM5CXnDfTp9+WuK+Q18mt/YZebRPriYr4YKPRBvuSUzY2OTus07XeAXUlVVyrxSm6FGKV1GGfLaLIJ97Jk5FwLcSNyJGAI/kgNbBTErQAOn1YUbKNh69NB7NH1WpVUT41T5s7kvnvmkip50kZK29PYpkECvG15W97vdpQBJIO+HeugfyYgqppaKUK7iYiEuhsd6a6XyGG3ZTQjRW45Nl2
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2026 21:25:43.8132 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 090e3a82-30fb-4151-e013-08df19b939cf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000066E6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7079
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

amdgpu_gem_ualink_handle_ioctl() dereferences adev->ualink.info before
validating it, but that structure is only allocated when the UALink IP
block is present, which is currently added only for GFX 12.1 only. The
ioctl is registered for every amdgpu device with DRM_RENDER_ALLOW, so
on any other ASIC a render node user can oops the kernel with a single
call.

Return -EOPNOTSUPP when the UALink software state is absent.

Fixes: 8a8bb5cb0410 ("drm/amdgpu: Add ioctl infra for exporting/importing UALink handles")
Reported-by: Sashiko-bot <sashiko-bot@kernel.org>
Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
---
v1->v2:
- Updated the failure message.

 drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
index 8411ea17172f..d55570d083f7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
@@ -4072,10 +4072,15 @@ int amdgpu_gem_ualink_handle_ioctl(struct drm_device *dev, void *data,
 	u32 gem_handle;
 	int r, fd = -1;
 
-	if (adev->ualink.info->accel_state !=
-	    AMDGPU_UALINK_ACCEL_STATE_ACTIVE) {
-		dev_err(adev->dev,
-			"ualink device is not in active state in vpod\n");
+	/* The ioctl is registered for every amdgpu device, but the UALink
+	 * software state only exists on ASICs that instantiate the UALink IP
+	 * block. Bail out if it is absent, and short-circuit before the
+	 * accel_state dereference below.
+	 */
+	if (!adev->ualink.info ||
+	    adev->ualink.info->accel_state != AMDGPU_UALINK_ACCEL_STATE_ACTIVE) {
+		dev_dbg(adev->dev,
+			"ualink device not available or not in active state\n");
 		return -EOPNOTSUPP;
 	}
 
-- 
2.55.0

