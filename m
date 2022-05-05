Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AE36C433FE
	for <amd-gfx@archiver.kernel.org>; Thu,  5 May 2022 20:08:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5699710E4FB;
	Thu,  5 May 2022 20:08:41 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D53FE10E705
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 May 2022 20:08:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FnkSKOQwqkPnELU+8Zcw9bKOoQ/KHKjw/mIDWFxYhudo76CnoQTmCkGwjLIbCsReLsKzngmoKBf1FoXy0f2gl8IS6VwQ4ZLjJ75YavYVdN7kqg15OSTh3v8HrmvVkQKDsoQLEarT7Wv4Jre6sIajjt44ia33z8ftXjqr0wlJ9NRjz71IfgoRUIYbccOPvMl22OgxP0F6RAiMRZudLcGK2cxDoKyvh5UzZ7a77TUD3RPfRYRqyPYBIUqIGbwYcVGvdjCqu8Th6A7v/MkXsEafV7qTmFX7ITnyPRU+kmekFqkjN1nHFOFn+fqETjEb3JG5FsH6tveN6Tu2hFniiWZUvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ymQ8FlVYPxzq+VC7n/BN7Yf7TCxN0+GZWBpbIEqw79Q=;
 b=Bs1QQvfmkz+C9omdQXXOVmtMy+I7p9SsfowlLljUztTYVbeYi9Fotz75AHckyDetcWm/h09qVHQpqOS39nSgA4seR63dpSSqIgr8WZyqw3yY3uxl6yOKpZDlOTwE6EhRqTJDKoBc+NeKv5HUJKzXq2VOR37f8+Bgv0HF/PG4xS3HdzWTdIRshFOz9sXMWBttrMGDFBmxnOp033wukJwSYSjIqQhBDEDVDWXqMciZS4sD0HqYAGqO03HSplueerQQExdjMJyf9HDwE/PR7uFSpVh3kxRd8rgnjh8IXiYT5QIJI4OBgFa6hfMae5wAKfUoxp80HxFMI5b/XViO9SrCiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ymQ8FlVYPxzq+VC7n/BN7Yf7TCxN0+GZWBpbIEqw79Q=;
 b=tEv1hCaAmaV9fZ0izCJ0tHdSiMy2kXID4rzPV/CV6bm8HzKKZQFEt1Z+C2sGsSF6EJ7346Awl5DoXMlsddAZ9tiQnh9DeqGYTh04D90av8+db7V14WeSrvqdqJzvamzpAaO0oFLmYy81Dl5JB+lKrRfTIvbCqRKufDmRUj0Uwss=
Received: from DS7PR07CA0021.namprd07.prod.outlook.com (2603:10b6:5:3af::23)
 by BL1PR12MB5175.namprd12.prod.outlook.com (2603:10b6:208:318::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.24; Thu, 5 May
 2022 20:08:37 +0000
Received: from DM6NAM11FT016.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3af:cafe::c9) by DS7PR07CA0021.outlook.office365.com
 (2603:10b6:5:3af::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.13 via Frontend
 Transport; Thu, 5 May 2022 20:08:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT016.mail.protection.outlook.com (10.13.173.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5227.15 via Frontend Transport; Thu, 5 May 2022 20:08:37 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 5 May
 2022 15:08:33 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Disable SDMA WPTR_POLL_ENABLE for sdma_v6_0
Date: Thu, 5 May 2022 16:07:47 -0400
Message-ID: <20220505200750.1293725-11-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220505200750.1293725-1-alexander.deucher@amd.com>
References: <20220505200750.1293725-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 80ebe5b8-8e06-4c3d-e114-08da2ed30a93
X-MS-TrafficTypeDiagnostic: BL1PR12MB5175:EE_
X-Microsoft-Antispam-PRVS: <BL1PR12MB51752EF134CA44C9D61FBE5EF7C29@BL1PR12MB5175.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SexN7Fcc3ugDbq86kT5eKEDm2zFX76UTJmB+MldPGr1FPN6rA0OSHCBewUv021MDqiXqnkueCS2OCNfTB0jo8FO4uQCGzv9/ck+w7yPUaGYHSyI3LG9/Js0U5c/R1Lrr2W7LXqGqjX5Dyd161QpeMyhDMo9ncEhA0KT7LMTmh4lAzrhgx1Aiu8DaJoZNgGteIQPqO81CSJJ1iw2THYLAF12W4EVZPl/XnNDdJxJ4U4T2BHbSSB0S1wO+/BleX3BGhZuwMm8CpiF/vaYql1I5s8cbjqXFSqDTcZtBzG+BVqkrcr8kO9Cyi5VtZWocaC3fQbdfgfaDNLyGgTzcPgGHdfV0POfiSXP4Y+m1/Wzlm75tNpw0PoNAhjhqzKD47b0rLt44YNZI14Xo876i/WeoksUGQ+a+F5Nm3ObooVQ5AHmQo3JFP0TaGvt6jEDhhYO1DuJcetvtxCKdWgrjn45xyKyT3UU75GOtGG1DqglLQ42uN0fmuOUSbakCjIMGZonNYHJpb/EfxrNDAzvl+7ZMGzpBaIHe1EAAV5VieDPNemoF3I0LS6Q5wI+ieNUHaJOfEolhnb/LX1Snj4JEEXODi5Gi0AqvPN+npp0Ej5mQPzY6BWvGmNF7Qm8vvjd3LN9R6oTQyScxMy2wZzAfxQkJ5o0cyHRWkEnWsc7BqfPCJiWMUjPX/eE9QT3deVfzPLohXBLv6KuNsP4d5kyCQB8Mnw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(26005)(356005)(40460700003)(7696005)(336012)(81166007)(426003)(83380400001)(47076005)(316002)(86362001)(82310400005)(186003)(16526019)(36756003)(1076003)(36860700001)(4326008)(8936002)(70206006)(70586007)(6666004)(6916009)(8676002)(54906003)(2906002)(508600001)(2616005)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2022 20:08:37.5849 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 80ebe5b8-8e06-4c3d-e114-08da2ed30a93
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT016.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5175
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Graham Sider <Graham.Sider@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Graham Sider <Graham.Sider@amd.com>

WPTR_POLL_ENABLE = 1 was kept to support legacy doorbell programming in
SimNow environment. Disable for real hardware.

Signed-off-by: Graham Sider <Graham.Sider@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
index 6cc6a81a7d73..8cfaed55b192 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
@@ -558,7 +558,7 @@ static int sdma_v6_0_gfx_resume(struct amdgpu_device *adev)
 		       lower_32_bits(ring->rptr_gpu_addr) & 0xFFFFFFFC);
 
 		rb_cntl = REG_SET_FIELD(rb_cntl, SDMA0_QUEUE0_RB_CNTL, RPTR_WRITEBACK_ENABLE, 1);
-		rb_cntl = REG_SET_FIELD(rb_cntl, SDMA0_QUEUE0_RB_CNTL, WPTR_POLL_ENABLE, 1);
+		rb_cntl = REG_SET_FIELD(rb_cntl, SDMA0_QUEUE0_RB_CNTL, WPTR_POLL_ENABLE, 0);
 		rb_cntl = REG_SET_FIELD(rb_cntl, SDMA0_QUEUE0_RB_CNTL, F32_WPTR_POLL_ENABLE, 1);
 
 		WREG32_SOC15_IP(GC, sdma_v6_0_get_reg_offset(adev, i, regSDMA0_QUEUE0_RB_BASE), ring->gpu_addr >> 8);
-- 
2.35.1

