Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C4B3C98304
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Sep 2026 19:34:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A438510F12B;
	Wed, 23 Sep 2026 19:34:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3fUzN7Sw";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012012.outbound.protection.outlook.com [52.101.53.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 208DF10F12B
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Sep 2026 19:34:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gmp8CNuT2mfFFRsN34jtdLjo2Nk8rIqEFnATVdeBDbg20pYvnbKYH7rvHJXskcHH9hF7seAO7YcjZ+Zbl5zpFUGvQx7QjylZ/TGvuYSJJm7ctBW4y5ZkDPQw+XxedwgtxCq+7xEWggZHvopjz3SWMcrKRZocHd8YqSAzmckJq78aysNIvuwAuaGEOmMKmHPZrhB1ydSh7Y+RGu7W+9kKX9SMaoXSP8u1vOT1qjhNElx1RQomIeqhDH89ZuXzmoHj2pWlRPo+VX1MVXO0R4TSkW+QQXQY8k3VDtacGDsAWW4koPriKnhF6axmOdGvLibMiQZz/8e9DmhelBZToTil1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2ByH17a1pUX4OnrrYqmIO7EC6yDpN8JCRYBkZkpzN28=;
 b=jyiw34VT7gLvRDybUWimbYWA4M/ZlywJX5K7HjvgXJ5DgGhpYuiDP05K8kSSzQns2XFBtQ10W/kSoRE91pvPQXkD6rdeTcYWQTgYorxGBcuGOX+ynp87zCHGMpPiedCZDLtyb8byNy70BehAKg5wqg8bcUxNr8OQPv+qjImmRdBX/tYz1A5n7BO5uHc0PGy7o2yMGYtJXlUFB0Z2OVUJ9bgwPRzwPfuh/cT23p4S4BupeChu1Z+1uVN+02vkrTSDPW2jCWlJ4D8jZCEZUXcRtsFkusVIUPM5QW+hKPB6L3VMrg10B6gtde4W1l/GOOGocWpAnHMifDh0QRZUq+Uf2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2ByH17a1pUX4OnrrYqmIO7EC6yDpN8JCRYBkZkpzN28=;
 b=3fUzN7Swq+WTth6cIoo+dQn0Htnj2XTScnPysQtfM7e9dnt1fiM9+a9+VcCmnNQ11CQdLSm3gKDV000/sUM3ikPjxfPU9F9Hzs00DmAuEyMQECpYpP8j5TE1dBezZbwdEGLArbHInuYM2cv+aDyvwJMITG6HnGbmtfA4ox2FqS4=
Received: from SA9P223CA0011.NAMP223.PROD.OUTLOOK.COM (2603:10b6:806:26::16)
 by MN0PR12MB6174.namprd12.prod.outlook.com (2603:10b6:208:3c5::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.14; Wed, 23 Sep
 2026 19:34:24 +0000
Received: from SN1PEPF00036F42.namprd05.prod.outlook.com
 (2603:10b6:806:26:cafe::7e) by SA9P223CA0011.outlook.office365.com
 (2603:10b6:806:26::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.14 via Frontend Transport; Wed,
 23 Sep 2026 19:34:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF00036F42.mail.protection.outlook.com (10.167.248.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Wed, 23 Sep 2026 19:34:24 +0000
Received: from amd-desktop.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 23 Sep
 2026 14:34:20 -0500
From: Shahyan Soltani <shahyan.soltani@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, <christian.koenig@amd.com>,
 <pierre-eric.pelloux-prayer@amd.com>, <kevin.wang@amd.com>
Subject: [PATCH v3 04/10] drm/amdgpu: push down runtime pm handling in
 amdgpu_gem_create_ioctl
Date: Wed, 23 Sep 2026 15:33:40 -0400
Message-ID: <20260923193346.2292597-5-shahyan.soltani@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260923193346.2292597-1-shahyan.soltani@amd.com>
References: <20260923193346.2292597-1-shahyan.soltani@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F42:EE_|MN0PR12MB6174:EE_
X-MS-Office365-Filtering-Correlation-Id: 37d2e037-167f-471c-89a7-08df19a9ac51
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|82310400026|36860700016|376014|10067099003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: eELfPP6rRJY9LsrUIB4HyOTB13XHZJY7jVMwsyjvufZ8yBa9vqJ4rlpyuYGPtR72m7hmom4QifmQPz6faGn/8yPkYrlReOWDxsTfS7DoUtGJDd+vV6CLBYcj88pIvzgfMnloI74gfWEv+lxWAwaM+pAutzS61tsKBHSqLlxxEVn8sfKmPr9bEPYXLwExX3hNpmTl7yMoqcr+XBa/IDo3M7j9ZY6DA+CB6qlLRKSAu02O+Ls28aZNKhcLcJk3bEv7e31DsToqiE1ZKAymT15IQW7OiSDF78MvXLKK24AA1U9ytCaAxOzpWNA33M2OjvTooj1/8dkTR+dbTNuzZkWhdtMXK2a7bkjmPZat6UjaVt3uOjYlr6PS92iE4QeXf1SWP2NsoTK7JSnFQNOTRY+qnoMe5AC6PWIXGkPMzwPz9wo5CqIRkydDPyqAYBDHTUXrcepI8J7kWOSEXoFuITkrZnj+oaJsbz9KHkmVtV9i16JwG/gWe4Sp5iTg2fOornYuCjARFcaqHVzrNS9yQGcb/htMkqC3vvE/AXCqp9L1GPrH/QkBGgV4VE2vrK+7Pod0iZpxfhHLmReqbs8DaUPX/c1zmUpCX9FrCyRX/qJPqQ0NDWX39OC4indNhgHgt/i1CmbMuClHpzM+UzOSSuVipM/V8WYr46moIGqhUKAcwFNso6lAmMGmA7YqAOR5OhivPX5MalYK33DzFJg1bwjqyw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(82310400026)(36860700016)(376014)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: XObpj/IzVYn6sPqjAj54zwl7ZRHg+mNWELrS2qHJf2X7VpG4lSa/HZmwF51V29j85zd72beLsOQeGo+r7k39Mug9BhJt/Kyi69XaAz3gicsnUi0N44GDmBaBjzL5KYsEXyPB0b6WV3kJONlkSqfLIxtdbOHg6I/YvNkxPfHva7D0I7CP/J/eWLy/sHoLMQBP+Ntfhrf6KBRSTORyh/LFx8BCR7Xs/PAQXYdFlFgAMVPxXarZwD3Bfh9PtljyaR7SErqwfjXNjABhUjtHXLEg4I2PgPWK8aFjzp6UqWFUNfcWNtIEnb3NH7ygDLvOxEICqO2NJzuGk5vcfhVx7dqfH8md8X1nFO6Fli0cKpS+e8r90JZhB8zqwQ5jUN59xNvJZYlMnKthIhicuuLTFLx5GrtcDUW+NOzBicsS9RwgABbyfbMCR+huTRY5vnyXIgR2
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2026 19:34:24.0439 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 37d2e037-167f-471c-89a7-08df19a9ac51
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00036F42.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6174
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

From: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>

For now use the same logic as the existing one, but it's not 100%
correct since:
1) most operations don't need the GPUs
2) some operations that need it are actually deferred

Signed-off-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
Co-developed-by: Shahyan Soltani <shahyan.soltani@amd.com>
Signed-off-by: Shahyan Soltani <shahyan.soltani@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
index 4e4814caf61a..5d2802009cd9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
@@ -929,6 +929,12 @@ int amdgpu_gem_va_ioctl(struct drm_device *dev, void *data,
 		abo = NULL;
 	}
 
+	PM_RUNTIME_ACQUIRE_IF_ENABLED_AUTOSUSPEND(dev->dev, lock);
+
+	r = PM_RUNTIME_ACQUIRE_ERR(&lock);
+	if (r)
+		goto error_put_gobj;
+
 	/* Add input syncobj fences (if any) for synchronization. */
 	r = amdgpu_gem_add_input_fence(filp,
 				       args->input_fence_syncobj_handles,
-- 
2.55.0

