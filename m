Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4CB1C61DD3
	for <amd-gfx@archiver.kernel.org>; Mon, 31 Aug 2026 05:25:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1F9C510E5DC;
	Mon, 31 Aug 2026 05:25:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="EIwFDBpG";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010002.outbound.protection.outlook.com [52.101.201.2])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 12E3E10E5D9
 for <amd-gfx@lists.freedesktop.org>; Mon, 31 Aug 2026 05:25:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Cc17BOc1h7NmRuR1J1lfHjZrPJrrB1i0TYwD18MCcJ3pqzcoWXbEbayyDmt0FdhNJnxczJkO4Gt8QyWb2BjOWZRqVO66iiIYISJy3Ji351N7PofdqlWheHAdCcodnHoumseOhcyPD195zQ+LPudINnoTf2JsA6PsBgN1CXL5quRJ8vjUVltkXzHOYw04LFmcHpSPyN3OdR6G9SdxS5j92j83kQTwq16Kp8CfmxGzf5yrkNsvc+nhvZCMBJWsfrc2UYUkV6pBwxMLPN0CSM9EyWxd4dAZEXPVqyVjMqON4eah9pbBSy6yeRWxyoHRg5+SwoCQhUZO5ep6xsmIXbynmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CDQXr5z+PhZiSLaYjWok+bOdM6DI4eyKvlXCC4ecRyc=;
 b=BaqpqoTk4+5PqnbTDG7Xu1WGXWbhK1LNEC1q5f6OWDi3mawHlpBcC1h1XtWJV6/Q0EdShTpDgk6QK+6QL8FWRGclO5bKLDr2asme9pomZ9Uv73uONCV0gtIs6dY4PtfzJ0rCf7cPk1ShY3R/niE/Pha/lQTOa6FnGcCdHWQEejUbn66oog8IcdI2xO2PRJSzYHxPFUpaPMkqzf8xBAOYBNxR86yjNKA5nfMUDf3R1KxteYekYaliWR3864PBNuKl9LJxqlV65V4h02wsh0UcgDBodnR3gZmhhl8hphP/pYOFj6pxsQYwpIYNSUJyI1oO1BIKnYghfa+3/vOmRcIPMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CDQXr5z+PhZiSLaYjWok+bOdM6DI4eyKvlXCC4ecRyc=;
 b=EIwFDBpGCERhKet2wDPnJTOvfCQkyhBarwEGx6xoqwy6L5vVMPvs4yrc9M6RCdYyTTANz9zbaUYPf/NuNsBzWpL4VcEhauRT72bucA358gbSpKsdARUSBdDxbZV12jgegyWN5fcIMUGpeiT75h+iN9oEtFNz95yCfslJKitktIo=
Received: from SJ0PR13CA0219.namprd13.prod.outlook.com (2603:10b6:a03:2c1::14)
 by IA1PR12MB6138.namprd12.prod.outlook.com (2603:10b6:208:3ea::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 05:25:23 +0000
Received: from SJ1PEPF00002315.namprd03.prod.outlook.com
 (2603:10b6:a03:2c1:cafe::94) by SJ0PR13CA0219.outlook.office365.com
 (2603:10b6:a03:2c1::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.10 via Frontend Transport; Mon,
 31 Aug 2026 05:25:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ1PEPF00002315.mail.protection.outlook.com (10.167.242.169) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Mon, 31 Aug 2026 05:25:22 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Mon, 31 Aug
 2026 00:25:22 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Mon, 31 Aug 2026 00:25:21 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Jesse Zhang <Jesse.Zhang@amd.com>
Subject: [PATCH V3 05/10] drm/amdgpu/sdma6: honor mqd_prop modify flag in
 init_mqd
Date: Mon, 31 Aug 2026 13:24:17 +0800
Message-ID: <20260831052513.1518180-5-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260831052513.1518180-1-Jesse.Zhang@amd.com>
References: <20260831052513.1518180-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002315:EE_|IA1PR12MB6138:EE_
X-MS-Office365-Filtering-Correlation-Id: a5ebac7d-79f9-4117-ba3b-08df0720417a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|1800799024|23010399003|376014|18002099003|22082099003|56012099006|6133799003|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info: iNvVbgyIDEQwOW4YVe/bjJdtS5rVe6VMHwF4LQyrvrJtLbqaZnHMDa62oprqqmV886TOTlDtooSWpmrDRpTBYUfwTZmoTp3WKvjBo4VkWPXrEWzd71xH9k+louLf5FCU52yNM5BVvicjB1d0NQhbN5vQKrj+D3CyZK3bZTmccB7uLTrOv42UDoNK9+zYvYHU4/veGhYN0Lomk/NcHXSRFY5RBQSaTccQW+FMlq1Ag5e+vxjPZ8NFygNEPrBtcLihCJagldvj91QQLkafjbgUmjfs1AST0dBB6ymUx39tnkK2+I50QLHHunrhGyxAsGNFJvZOOvcx+3QgGc43lw803hKbUP77Dt7MgCDijU5+pmf5TLdPWced9Uwh2r1ouovVrSWPBbRwon9pSsY8rLz5Uj7sr+azUrfPYfHA9GgR6QJqUw8eTAGod3gQZkkrA/QY7I9v8v2yvdpiD7XEhNgorg/npL3J/IC6sWo7+Nct1Ul1/IcgJP8sOd+BFIN6uIubXdL45e9VbAOZJx1mOSkBLKxZSKgSuqVPJ7hUc0JziqyJPhXYk9Orj3OH7C6BwqZPvKNnjfKGjPCftQIaf7Ca+Gx16uqLr6oizvpnnRXc2BYcMdZvN6xfWic3rAq28HSFFjGZF84ZtZYORiKfaVWAMUgXAX4qfvPLgAmvdfp1EUYtz46sNWdhyZXsA4hQK4TRF6mgLnhwZvp9lJDP9boe/w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(1800799024)(23010399003)(376014)(18002099003)(22082099003)(56012099006)(6133799003)(11063799006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ETn3Jbz3IQpQsjC4qpkHLkFvzj8n0OR+ZIpbq6fNJJv3i4jqTUeCtrGlG/CLcEo0zZjM18wfBkvQop31N1X1v0R7RcbsEeVVnEb8Zptee+lfFpkX8o67b0JusqSTNtQXlcmCJh5sAWcCBwObxdRXiDDfbTr01fiUksHw8GT+SkFn0tOgmgt1P+k3iSz9vYYqngEsZbctfFtEch/F76BCGjxJPV8LOwbFRWhhiO25z9RDjL+yaQiRFMjSFbJXJzIfkuZbF2MnMd3Plj43zyueWR3WLS+7HbEjd6zwN9t3xDJE1mmQw1kDmRP6KlzvJW+BbSQYMKUbfKrz+HZnu+L5KixwxHi8tVysPtmumc2V3NzZhSOhpyPDPxAl9zbcsdGbssLRERt1iZhTKbSx0P4aZhX7zA8j3jp+KehbdkJLzPHzg1rjewtxCGtwIF9AeKnQ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 05:25:22.7531 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a5ebac7d-79f9-4117-ba3b-08df0720417a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002315.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6138
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

On a queue MODIFY (prop->modify) sdma6 init_mqd keeps the context-saved
rptr and uses prop->user_wptr as the wptr, so a re-enabled queue resumes
at the first un-consumed packet. It also forces IB_ENABLE back on, since
ib_cntl reads back IB_ENABLE=0 on a stopped queue.

v3: consume the mqd_prop modify flag inside init_mqd instead of adding a
    separate sdma6 update_mqd callback, per review.

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
Suggested-by: Alexander Deucher <Alexander.Deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
index 3fd3e530c76b..d859e89289d0 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
@@ -881,6 +881,15 @@ static int sdma_v6_0_mqd_init(struct amdgpu_device *adev, void *mqd,
 	m->sdmax_rlcx_f32_dbg0 = lower_32_bits(prop->fence_address);
 	m->sdmax_rlcx_f32_dbg1 = upper_32_bits(prop->fence_address);
 
+	if (prop->modify) {
+		/* MODIFY: keep the context-saved rptr, use the live user wptr */
+		m->sdmax_rlcx_rb_wptr = lower_32_bits(prop->user_wptr);
+		m->sdmax_rlcx_rb_wptr_hi = upper_32_bits(prop->user_wptr);
+
+		/* ib_cntl read back IB_ENABLE=0 on the stopped queue; force it on */
+		m->sdmax_rlcx_ib_cntl |= SDMA0_QUEUE0_IB_CNTL__IB_ENABLE_MASK;
+	}
+
 	return 0;
 }
 
-- 
2.49.0

