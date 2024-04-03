Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99A62CD1299
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Apr 2024 18:12:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DF564112E10;
	Wed,  3 Apr 2024 18:12:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0PH1+IYg";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DEA931127E2
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 Apr 2024 18:12:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b0BuM1vydPvSoJwp6hHOKQmuc5YU6/dE8L9Cq27lpfa26WevgyifW1ti++QnTJ7kFm7QIixMnMa7DoWatC5j/wUx9o4hV6GHe3J0BXIQd2TPI/ZOSO3SHPsmctYExUZ1uHuAg/D7nCGoSRe1iine4Nlu6cj3GPxdFEYibAvmvRnF6v+I/YKpFR66+hQUxQJkxIWd6P1MrLBe6TyhJqlTyzZGsO1gB62n8V+eshCilX0EG/knTvuNVlmltYXglDz+itheriMZ5n9OhtXX2Sk9QkEKezglKUfpxsnFxJsFnErdTzk/zV8BcWKkGEkSNxcs25R5YwJ57uAA4G6JGdvPtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xJAlGuJXD8JyWnUtN4FUz0/mI+dmFB8+i07TIPeayUs=;
 b=KMuP6U3eYHhlcwqvw+5r95Ok9iyQStss9b7moMYG5tbvcfW5p+eHjxxyR9onwVeerAt/SBMbrYBvAjBvhQ4NiYs0WKzjvtHEqBrlvQLDdFlhTfqMtyNFxWywk+dfWg993y3YC0zdznGSuQbJdTLgObLj/CulCo+dI2WxV4UzA+ZXUhES38O2Z8q07dQFWiJ9xHCCKVo+XwhNaJGo/IkodFm9n1wB4uPvHX/nJ/F0HjxVxJDDZ/RuZRvONtufdHYT6CP428UFY/1W/d+ow4UI6ymaTIDuC85/oPjNam1X/wC0qtuLlSnkd/3j1d/hZUnwN7cqJvGCXiEQcYuT3rg/GQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xJAlGuJXD8JyWnUtN4FUz0/mI+dmFB8+i07TIPeayUs=;
 b=0PH1+IYg66mn8nCkFVJf/OLLr8zGbUHNqmF8aOotB75m8hEq8YrvpvOW4tzmS7wXZTJaeRCNIWejiA5hclYuLlba7bg3WMGG2tDZntkNaQgNWQdbtls2X6BOSLOuI1IeiOTOWPwVSilpSH+7nwpmpDq3CKKWuE2B07Hbw5ncWOE=
Received: from DM6PR13CA0020.namprd13.prod.outlook.com (2603:10b6:5:bc::33) by
 PH7PR12MB6977.namprd12.prod.outlook.com (2603:10b6:510:1b7::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7409.46; Wed, 3 Apr 2024 18:12:38 +0000
Received: from DS3PEPF000099DE.namprd04.prod.outlook.com
 (2603:10b6:5:bc:cafe::c3) by DM6PR13CA0020.outlook.office365.com
 (2603:10b6:5:bc::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.13 via Frontend
 Transport; Wed, 3 Apr 2024 18:12:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099DE.mail.protection.outlook.com (10.167.17.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Wed, 3 Apr 2024 18:12:37 +0000
Received: from MKM-L1-ZHLUO987.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 3 Apr
 2024 13:12:36 -0500
From: Zhigang Luo <Zhigang.Luo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Sashank.Saye@amd.com>, <Jeffrey.Chan@amd.com>,
 <philip.yang@amd.com>, <lijo.lazar@amd.com>, <felix.kuehling@amd.com>,
 Zhigang Luo <Zhigang.Luo@amd.com>
Subject: [PATCH 2/2] amd/amdgpu: improve VF recover time
Date: Wed, 3 Apr 2024 14:12:23 -0400
Message-ID: <20240403181223.25079-2-Zhigang.Luo@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240403181223.25079-1-Zhigang.Luo@amd.com>
References: <20240403181223.25079-1-Zhigang.Luo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DE:EE_|PH7PR12MB6977:EE_
X-MS-Office365-Filtering-Correlation-Id: fd420412-100c-4039-b9bf-08dc5409a4f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qp3bJF2ONuu6QtdHUyrTMZ5YvIT3Jx9vkVEziZ6t7aWqSBfpvvWDlogI9d6fByM4hC208d/aXptL9ceOJaZ8Xn3Xzec74F/+tC9nqMJGOz8nd176gPq7yeMpBHnor9IWYEFvGCPdQWoAwJpAegcH6nO8nuKjPWFiRhOy0QsNhGqcEHHHV+i5oUzMKV0F61/UBimJjmYKwLl23oWAG42xgiS+twVw9CIo/mbEeRhpdBrkLtU/6ISpVauLX28zqdPBlP7efKgLrPobxO7v9/uRephzycHuHMP6/AhiyGIgufY4d9jUCIjKYtCqKrfRWbi+J0uIv89Apaj0eI7nHXXJ8ldTV5A9vALuLEIZKik7eRtN2a8SyqeWtE0zhKN3DTlIYC1ApJuN5GaEkhzEVAAW1Z/kjgGtWv+69GF1dwrYJFsdpmn0i6h3TJjZnmeHK2Urjkm+c3AdNCn3HnQGnvr4qHuC5eVp4nByXqd01Q29rjK19zKv/6QVzqjwhHi90pKO9oyIbFtGhvAAGJgvHp3N9go67BOpTxZ0FEd1fb0aWYvSvZU8Ebf/FT9xPEoLge5aT5n1RKXxyiwZALHX9dH/QsZUgsc4oDoNv9HoLg8J4le78h0oYWTZJKcA5e3WNsrtLzynxpMLfRHyT3T9A1PY79A7gUjUTSylZFMbqtFzNH4Y+7n22yB1cTAv0jgurdRarzjJiXa8GuvTLDbGOiO1B3sLJstxNQZBPcGZCOwWsXQfyVYA9rRxrGi6HtDURCq/
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(82310400014)(1800799015)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2024 18:12:37.7639 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fd420412-100c-4039-b9bf-08dc5409a4f2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099DE.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6977
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

1. change AMDGPU_VF2PF_UPDATE_MAX_RETRY_LIMIT from 30 to 5.
2. set fatel error detected flag.

Signed-off-by: Zhigang Luo <Zhigang.Luo@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c   | 1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h   | 2 +-
 3 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 70261eb9b0bb..5e88f6f6a481 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4982,6 +4982,7 @@ static int amdgpu_device_reset_sriov(struct amdgpu_device *adev,
 		r = amdgpu_virt_reset_gpu(adev);
 	if (r)
 		return r;
+	amdgpu_ras_set_fed(adev, false);
 	amdgpu_irq_gpu_reset_resume_helper(adev);
 
 	/* some sw clean up VF needs to do before recover */
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
index aed60aaf1a55..4b6e50cfba08 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
@@ -593,6 +593,7 @@ static void amdgpu_virt_update_vf2pf_work_item(struct work_struct *work)
 		adev->virt.vf2pf_update_retry_cnt++;
 		if ((adev->virt.vf2pf_update_retry_cnt >= AMDGPU_VF2PF_UPDATE_MAX_RETRY_LIMIT) &&
 		    amdgpu_sriov_runtime(adev) && !amdgpu_in_reset(adev)) {
+			amdgpu_ras_set_fed(adev, true);
 			if (amdgpu_reset_domain_schedule(adev->reset_domain,
 							  &adev->virt.flr_work))
 				return;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
index a858bc98cad4..0a57b637c4bd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
@@ -52,7 +52,7 @@
 /* tonga/fiji use this offset */
 #define mmBIF_IOV_FUNC_IDENTIFIER 0x1503
 
-#define AMDGPU_VF2PF_UPDATE_MAX_RETRY_LIMIT 30
+#define AMDGPU_VF2PF_UPDATE_MAX_RETRY_LIMIT 5
 
 enum amdgpu_sriov_vf_mode {
 	SRIOV_VF_MODE_BARE_METAL = 0,
-- 
2.25.1

