Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1863EC433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 25 May 2022 16:20:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A3E4B10F349;
	Wed, 25 May 2022 16:20:31 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2065.outbound.protection.outlook.com [40.107.237.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A738410E7E0
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 May 2022 16:20:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aU4z8m6T4K3gnKGsteCZ9gfmfSn9NvGIvvD9OSdC06ivMinrlWMvT1xXUy2hOxPYM/onqg1pMvgsHfbsPJ/aFrs9iNeI6ZB8zzI7DjHcNIZN6btGWg0kSP3JZnevjSIE+jKPqc5Y7BImQcMSdalKn0wajTF5vL7np2pZB/QcR+i5B52MFyTfPQlMD69DpSvTrWax34RH8idnJd4ypniL58EkPqV5Dqrql0JIArdxc9RZduFBf/y1f7hess1+7z4EuaKxTePm1MFnXnw8mjF85Ei401np654IMxnHktqWaYA3G9jf/SEkBDCXXWyFnk8T0VVEL3BA2MswWb5De7F2aA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i8j8yqY3IuHm4pZBvadKJZhqq8bXSUPV9trQB/UUN88=;
 b=l0lzMCSBUPc9sBamn8Zy2e7/cH4LQ/pbRRaaODPFBKVtzyWTQWZjohzHgYiOxhcTQafbO9/+sB8t8XnDgu7vjq8oO+o7H8Hw9GLm6w9Q6HBU7OdnTHV8MuyiCdz5vmOYx4hY0IekHemsnk8Hqr1kMy2HkX1lLv4jzL7jKzXuSUPyqeVGcZrMqvMVUuVMD7Qthjl4JrR/ZI6y/dv+vEHi/h0fhPz2e5xCbEE/L8fZ9Ww0VkCFhNy3KZOUEMKOZV+ElQKUAuJgFBSdZLIZr3f4c/nJHSJp1wsNJWYyIlXvfFQ8caWCH8Asj6tiTcsHq2PyBkZJcx2n7KXjIwKSxAkdVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i8j8yqY3IuHm4pZBvadKJZhqq8bXSUPV9trQB/UUN88=;
 b=j/9efyuXVzADFHz6p3nVxRnLQAgKQ7ewUFnQ1/0P7owr5wAvBAbteOc96wOEsRbIckbmZ20l7OLlB3AK4+AF6Qjf4ogjK7yZv3k4gwI13zmYs9MaLPQrhWxDIVZak3rrKZOCo47/rNGTx2bXmSGDon4/RjVYbUqnFMG13P0+2mg=
Received: from DS7PR05CA0106.namprd05.prod.outlook.com (2603:10b6:8:56::24) by
 BN7PR12MB2722.namprd12.prod.outlook.com (2603:10b6:408:2e::18) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5293.13; Wed, 25 May 2022 16:20:17 +0000
Received: from DM6NAM11FT057.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:56:cafe::2) by DS7PR05CA0106.outlook.office365.com
 (2603:10b6:8:56::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.5 via Frontend
 Transport; Wed, 25 May 2022 16:20:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT057.mail.protection.outlook.com (10.13.172.252) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5293.13 via Frontend Transport; Wed, 25 May 2022 16:20:17 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 25 May
 2022 11:20:15 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 27/43] drm/amd/display: Halve DTB Clock Value for DCN32
Date: Wed, 25 May 2022 12:19:25 -0400
Message-ID: <20220525161941.2544055-27-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220525161941.2544055-1-alexander.deucher@amd.com>
References: <20220525161941.2544055-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c7a283fb-abe5-42cc-4d63-08da3e6a74e1
X-MS-TrafficTypeDiagnostic: BN7PR12MB2722:EE_
X-Microsoft-Antispam-PRVS: <BN7PR12MB27225021CCB9098C9749C3D1F7D69@BN7PR12MB2722.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 26bIURq3tl8I0/Tp2clAjBJdojyO+tVP1NeRZ6cjVGLEnlUtLvmD6s5gDOC9vUthWr/M0stYyw3x3Lb6JmxA8KWjNWYZ1Qa/EKtwhkAk5O3WPQl2mpjFpuGZOu4JeAGQGOZuZsLpfVTB9GM2boZScK6vlkt8sjnjFSkz52r4UrPyNJkNyLoeaMNWYjhkRrjQ9cL93wz8i3hiKNRQUTRU06iYNIHdfodSYOpnAG8c1xyswuDMIKOBM2VGOQKpjvBBQY7V2HNehs6wZxD1CEiAp0ojwLL/m8XWWVym7YG99qFlUqgbl7B1nIV16GncEA/BURFesHE0a1h/lG2YKs+hP8fkYtLbCMex991upyuS4FQW9/1U8njyYACtvp69BYcoiRTBTVOE9cXs45xpsN9Sfw3hkBbVQ6n0vYOyflBHmnoP1cQxLDqUZxJ9vlQTDcFy7O4NZf43GCIoMYtyzM8AVjB8pKiECT4h2M0ylNaYnjYMeOfnGfjtobZnLPGQguQ3VY+nfwsPem9c8tRDRACiGsxr1dIV3KNa67/kAkrOf7xUu4GflHc/gXgEVKUS1pRI21rzr5PgVvLLJHREObEQUFC6TFp9nP5ploCLqQeAzZQgdVFzUQzduNRhZ2VnwOGOWdofE3DXBGfDCPlO16cKw3EDfbdh35n7aokOcn5HlGgaZ3PT2Uk2KP6yBccBPTYuDDwy2PTCODud2RIHJWlMQg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(2906002)(36860700001)(82310400005)(5660300002)(8676002)(81166007)(8936002)(4326008)(70586007)(356005)(54906003)(86362001)(16526019)(1076003)(47076005)(6666004)(7696005)(2616005)(316002)(186003)(336012)(426003)(6916009)(70206006)(26005)(40460700003)(83380400001)(508600001)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2022 16:20:17.3630 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c7a283fb-abe5-42cc-4d63-08da3e6a74e1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT057.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR12MB2722
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Fangzhi Zuo <Jerry.Zuo@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Fangzhi Zuo <Jerry.Zuo@amd.com>

VBIOS default clock value was halved, so the hardcoded dtb value should be
halved as well.

dtb clock should come from SMU eventually, but now dtb clock switching is not
fully supported yet in SMU.

Halve the dtb hardcoded value for now to have UHBR10 light up. Will rely on
SMU for dtb clock switching once available. The w/a is for DCN32 only, DCN321
should adopt the original value.

Signed-off-by: Fangzhi Zuo <Jerry.Zuo@amd.com>
Acked-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c
index 9d2d2cda5543..774de29fa532 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c
@@ -599,7 +599,7 @@ void dcn32_clk_mgr_construct(
 	clk_mgr->dfs_ref_freq_khz = 100000;
 
 	clk_mgr->base.dprefclk_khz = 717000; /* Changed as per DCN3.2_clock_frequency doc */
-	clk_mgr->dccg->ref_dtbclk_khz = 477800;
+	clk_mgr->dccg->ref_dtbclk_khz = 268750;
 
 	/* integer part is now VCO frequency in kHz */
 	clk_mgr->base.dentist_vco_freq_khz = 4300000;//dcn32_get_vco_frequency_from_reg(clk_mgr);
-- 
2.35.3

