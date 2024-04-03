Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 421A7CD128A
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Apr 2024 14:36:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C37EE112B86;
	Wed,  3 Apr 2024 14:36:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qw4v95Nc";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2052.outbound.protection.outlook.com [40.107.223.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C6F45112B86
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 Apr 2024 14:36:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cDf9pXr404GnoGycEuELn71+rRrENOlUsVfWSA+5P8+HUEw8gcPwvZqBQmNhPtMG4SUv4uWUPbKDP9gveqveHu3IN8zLaA1YbG/QbRnLI9lpgoZr6bm/FkzpbNclFE5oVQfYHPZGP3GB6+SkE/P7f7qSIs5Xs4AJreUSJi0fP1EaSzJ2xdS/FAQQiztsNl7Q5r3UfPPRsPW+Nl1QfrYVcuNbbYGkPvJPo+ZE9GQQBshmbQGeni0DsJXM9ir59hYcPRdTH7ncYvEChessC8Dwx0a43SgP9wrEP0WR9TwA8gRYCIhZZc2uTWsQVOVU/RQEiPYq7zlq1zC1IY6ihgHEAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xJAlGuJXD8JyWnUtN4FUz0/mI+dmFB8+i07TIPeayUs=;
 b=Ol9EkTGLD5rKUIRzhAdRLdbeQmbptdk0Fm3ZtCKTs7Lg7uYXenoN8/0NIMAcx9xWVFtMVWBN6hSQiVZgkhR/PFLbNhCM9sIFj9CyfB4sBLrKqT7eNMLI81Nayc7ZZPld0kf4X8UzLqkqCJ4+tOXollDEk66gZQzpDTv0rwYKrymKYhq3c8SYQsBG8ika8mPbry/urxuj9MNIJMsvZHV5yACAZfyN9WZRrCPY5DkjhDKBb8/r3AiydAIQZwA89K0Tf26SA+zbwBHCNJz+MOp7LC9otqacfM+HvduMihrZ9W5XEbbp5IJVQmKRFGVjV5Oj+9p44Y8oCzaT9NuU6dci4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xJAlGuJXD8JyWnUtN4FUz0/mI+dmFB8+i07TIPeayUs=;
 b=qw4v95NcTeW53evNqHtg9aPFufEGSr6Ib6HmxAdK0K0UvFcvpOhc34ja7sYD+YYFuOSJnSBvwA9dmvIABdYMIdCBaOQYY0POeJWNbEHcL3AUO4TzqG6qyyO8A1Kbc1iaN1BFMW7x1QwDajB8BGr/i256C0YCYktiUGFewyTXve4=
Received: from MW2PR2101CA0033.namprd21.prod.outlook.com (2603:10b6:302:1::46)
 by SN7PR12MB7451.namprd12.prod.outlook.com (2603:10b6:806:29b::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.32; Wed, 3 Apr
 2024 14:36:43 +0000
Received: from MWH0EPF000A6732.namprd04.prod.outlook.com
 (2603:10b6:302:1:cafe::2c) by MW2PR2101CA0033.outlook.office365.com
 (2603:10b6:302:1::46) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.10 via Frontend
 Transport; Wed, 3 Apr 2024 14:36:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000A6732.mail.protection.outlook.com (10.167.249.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Wed, 3 Apr 2024 14:36:42 +0000
Received: from MKM-L1-ZHLUO987.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 3 Apr
 2024 09:36:41 -0500
From: Zhigang Luo <Zhigang.Luo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Sashank.Saye@amd.com>, <Jeffrey.Chan@amd.com>,
 <philip.yang@amd.com>, <lijo.lazar@amd.com>, <felix.kuehling@amd.com>,
 Zhigang Luo <Zhigang.Luo@amd.com>
Subject: [PATCH 2/2] amd/amdgpu: improve VF recover time
Date: Wed, 3 Apr 2024 10:36:24 -0400
Message-ID: <20240403143624.5160-2-Zhigang.Luo@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240403143624.5160-1-Zhigang.Luo@amd.com>
References: <20240403143624.5160-1-Zhigang.Luo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6732:EE_|SN7PR12MB7451:EE_
X-MS-Office365-Filtering-Correlation-Id: d8f176d4-7388-4ae4-0fef-08dc53eb7aeb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: R7pirYXSE9MDRZkaofu9AF3t3LZtmQXEb/oeyXL+0ds6h+BopJYL9uzJZB4NcBzFzAIWSgE4Lh2l915Ifp3vlkQrpGe6jEVNBD+Nm3wx9B9iy1CEYBwkBXf7oqAN5b+vAPnf+tzJTpvxdqfKrI4WZXJuJVEqtFQOydx/xCu/FOrdTLev1Chz/OsvmjywZafgnuNgBNqa09clL76Vw0Dxr/6pv2fa02dJ5Kv6zyvhkLd07VbA3HEI70rSWKWuPSC4lfa2krordbe14HkyS1cC78J3rgV9ddPMacySsEN+FL87lBKBbS2crUymvklRYiDON+m2gKMYSCBW9bT3pBxJ56T1aB4nAs3u0Y2NvVH9iDNsrS+MhI2X71naBuAhB1lwVOlFwy3SZ1W2jsSpUWbDUWGCRkPGnEyCr8Dm76fcpxHladWdigPDh1765xMUfXHRAqf/U124ht1YCyJdgBRrytEt2PihwV/PIs09nHmIw9PnsQ6IY71Sn/z2tcKkenH8hiD71K3lEVsg9giwKrtrIOk9HaVkPV5w+pu4OS+sAsl48bNgGRfL32lbFnsA613n2AuHwd7iWGewWz0ZPA3uQyTlHIbfOMfMxFVQ2zRtHAx2Du3EfmwhcNgAtylsihYHVnjIQ9iW91FJv5MNgaNbYLnX69mVDcoyc7+O5iYCMwGEwF/B9yjktehWDMinTtJWufKgIpQvRzOq48TZZrkt/IqK4Gnow9Ud7XngF+lHzTqpsHhmj1kGAd2Ae58JbVYn
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400014)(376005)(36860700004)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2024 14:36:42.1444 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d8f176d4-7388-4ae4-0fef-08dc53eb7aeb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000A6732.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7451
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

