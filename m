Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D09DC4345F
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Apr 2024 11:31:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8FF3A10F584;
	Wed, 17 Apr 2024 11:31:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="LQPl5jhg";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2054.outbound.protection.outlook.com [40.107.236.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DCB4510F584
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Apr 2024 11:31:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k6+qjXOxfTS8DI3ztw50FEsOvX1bPAK3cLLGoulm2QKb2hJVqBKCWjpSd9XSBFNoogtbXekyrQ/PeeSMMK6ptxs+D8O0C5wD/U6yB4Mr1lS4gteMgIHOnXf7G3rVgkJZrYlbvRKVIVsnDD5t74K77QwcMLPkvsUetFgRjIGfHFuoz3jIOuHzzWxgqt7EFxRey9mVvU/wRCGvey2iN3/jW6RHSCRmOg08BQsHZEztYAYQjd+j3/lRSMArLoVSu3dZuTFLY1JBD4+IyZXobucO8kJow6AGOw90vvl+DZ1DW9J5tmiNfURYLm1i4WTvVqPFStpJfAghIYN+uyENig6XUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w2rPnH+sDCMZGvlmcxC4dJzqm6lPZBRG42tujTm5Q9E=;
 b=Lkdgmv4DfUUngj5ZS9gB0OGQZbOCRhoMtf7s6xF7H2HsSe616akcMLW7hehYfUbd1DPz5oNaFtr8lerKIZQVG10HwNCPF11V0XdDaJ+LUldi92iBtpJ/t+Airh1BHvhvNKCfUDdjyHYd0MJLyyh7pAuBWCNIy3976Pf40/of9+UzA6jE3nAZ387Jn1qfnGEpb6xN1Xot2yi4EfIJoebEdkDcu/YAejp0l7GSXMee7YjftH/gMlcqPPmuxg0NvZfS3QylcDnFpgvDAqi49EaGr6KLq40Kp2yboVK4XIIbY6fCM7C8uQzK/2uclQXURgiBmOWBTQ5Pw+HFufP8ksvy1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w2rPnH+sDCMZGvlmcxC4dJzqm6lPZBRG42tujTm5Q9E=;
 b=LQPl5jhgWcIvJdl1fvvy8bwNuu66P4wM1WFqBpOAPGC3Rtf+xcZ+231fFlqZsEpuUMSSfbMJkkOkr6AdQH3wBiHI3PSPGGZToJqk02NL0e0tTp0PS6vZVHWFn6/3sPjRf/mRgxgtp+wWYy/nTyhJMSbefyGYPKtGVIMsqKdd/F8=
Received: from PH1PEPF000132FB.NAMP220.PROD.OUTLOOK.COM (2603:10b6:518:1::2c)
 by CH3PR12MB9078.namprd12.prod.outlook.com (2603:10b6:610:196::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Wed, 17 Apr
 2024 11:31:32 +0000
Received: from CY4PEPF0000E9D0.namprd03.prod.outlook.com
 (2a01:111:f403:c802::) by PH1PEPF000132FB.outlook.office365.com
 (2603:1036:903:47::3) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7495.20 via Frontend
 Transport; Wed, 17 Apr 2024 11:31:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D0.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Wed, 17 Apr 2024 11:31:31 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 17 Apr
 2024 06:31:28 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 17 Apr
 2024 06:31:28 -0500
Received: from horace-sm-debug2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.35 via
 Frontend Transport; Wed, 17 Apr 2024 06:31:19 -0500
From: Horace Chen <horace.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>, Felix Kuehling
 <Felix.Kuehling@amd.com>, <horace.chen@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Deucher
 Alexander" <Alexander.Deucher@amd.com>, Jack Xiao <Jack.Xiao@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>, Monk Liu <Monk.Liu@amd.com>, "Feifei
 Xu" <Feifei.Xu@amd.com>, Haijun Chang <HaiJun.Chang@amd.com>, Leo Liu
 <leo.liiu@amd.com>, Jenny Liu <jenny-jing.liu@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>
Subject: [PATCH 2/3] Revert "drm/amdgpu: increase mes submission timeout"
Date: Wed, 17 Apr 2024 19:30:24 +0800
Message-ID: <20240417113025.2886905-2-horace.chen@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240417113025.2886905-1-horace.chen@amd.com>
References: <20240417113025.2886905-1-horace.chen@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: horace.chen@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D0:EE_|CH3PR12MB9078:EE_
X-MS-Office365-Filtering-Correlation-Id: 407f8f35-a4ad-4378-0aba-08dc5ed1ee12
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UgNrzX9+wbYpFhz+EmQg9lf8yiqTker1gndEsmhhQWGqloT6fwN1QG6iOoS5FfPPJBqjHuAI98d2Uxr8ZvixEjYP8J0LAXCNyV3kKNfKnaNLFjQF7GfLGFdRiMy1iO8FMenOd2ikaA0lZwZRYnynCJiDWkJWWsfqkps0ld+zz0aaSk1xWM+O2YsShdurwbMwGsLeEAcKLsvroRh8mMhAyY/jeKlFT2b0C+uCZX/8s0oRC9Y0zDA4J52cscpDFtInxMNJu1MjSi0CkPhXsfxTB7Iv6vicQvrnxSxxRCsG4f9GZyDsXuOowbLD/8wy3dDk01yx9YptwJTMBkOK43SeD8wvmWqGzXgo+UxmzTWMHHlTFY5lRAdC+liszNUhm2wXMpmUV8x917QUzrr8zdqMNK4dnZjuLwZ+cAmQZfj0KfXPH/8ORpmfnk2j8gvyTqgV+a2xz17zAy+zpokDjLQNjyo4l9NjdJ/SCuvUqe3UqQH/98n0f69FP5C2LwrkoiKU7IGuSTpjTxLOea7+yF8gJPWxv2kY/fjwIQS6Tq+rQDIAVAFrasyWZIxCD5rKV7e+mMiuvTDHE0v0E8SmTg9noIYdaxlLjhwvYnhXWk8+znuPo7pOOh0DvOphx7aXypdUFkoz3YjZOQNfyan62NGCRzetmJgdDoWpNUSof58QYWSNhf2q6ngRAa7oiT5BfxerYBk5MHoOtb7XmiMil4+f0lT3b6drbzAEFU5xiqYgNrZ30OSNy09Sa2B5cqq7VOMN
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(376005)(1800799015)(82310400014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2024 11:31:31.4165 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 407f8f35-a4ad-4378-0aba-08dc5ed1ee12
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D0.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9078
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

This reverts commit a518c746510e03d8a78db432a659770182546b9e.

Reduce the time we wait since we are waiting for the
fence with the spinlock held.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
index 784343fb7470..e40d00afd4f5 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
@@ -161,7 +161,7 @@ static int mes_v11_0_submit_pkt_and_poll_completion(struct amdgpu_mes *mes,
 	struct amdgpu_device *adev = mes->adev;
 	struct amdgpu_ring *ring = &mes->ring;
 	unsigned long flags;
-	signed long timeout = 3000000; /* 3000 ms */
+	signed long timeout = adev->usec_timeout;
 	const char *op_str, *misc_op_str;
 
 	if (x_pkt->header.opcode >= MES_SCH_API_MAX)
-- 
2.34.1

