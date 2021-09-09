Return-Path: <SRS0=g6Hj=N7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFCD5C433EF
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Sep 2021 16:55:54 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9014E61100
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Sep 2021 16:55:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 9014E61100
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2543E6E8C7;
	Thu,  9 Sep 2021 16:55:54 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2072.outbound.protection.outlook.com [40.107.237.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 63F3D6E8C7
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Sep 2021 16:55:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RqCfx8DvxqmCd2mwisSMGTG9BQik/6Bi+MEasXPspZ5EvD6mBVMT6aaDaLOQ87F91diZUNcbm0w0OZ9ZMFVpXAgpnfVX69H7k0C9w896v8f6+OXStrH4ceDAgi801S3mU74ELhLN5tTPN56DRZ4RSe9SRXL8PWewZnx65rif8pxX6UvhJDd8nXtXX6zeFzxGwgHaqNm0Az0Zx1y1a1Uf3WAyDmpLmehYx9aPZ6TUa351KMn2CCiz2IinLFKlR6Lz9ICVrflciFivO3lxCMNLJDtbtilEl9zFsTm1QWOfrytSEElW6X5Y1ZMihYQEQw7WMstjNMjOwH1itVZZQ4BaqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=AD0W/Dfap3GzszCjTR3mx3daNoWpBDg/LpqPYXKww0o=;
 b=OHuRxp9TYT+KPzRviTgO+QjrZVTLiSExw+j/gSAZDl4JdThAy3+z7/QeLjHDzoFI5j1LtghzVQ//dS5qY2V/MuQzz6Ep1bRt5n+llKAXvXblbd1dcUaAQATs5vJuqNowppN1xhpb00VEWF4PElDmyrahzw3JSid5q8qx6RiLJ3974ioAZGFrLAkidAF/DLSGHhEGkhjYCjjfCgnyQ//o+gmbEFYJ8FL7ikQARQd5p78DH/nC4eQCbF4GMFnEv2tJysiXKqI6S38xYILbz4pBBQ8WXjw3lRxcC+9Y3024DxDZdRfTy9ZLpVC9x+I39SCiXw8Jhxqtc2Wd6e1SV+kn6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AD0W/Dfap3GzszCjTR3mx3daNoWpBDg/LpqPYXKww0o=;
 b=1FPDH56Qsh+2cbbflOwsKxO/dGiUn/M1T/X4on7yRySpUiTGNf7I/86UaRGj69TlFcDmqZ0Hs/4i4JbGmVKebv0rCfLxe39omHXo2ZZnNk19zE9C1teubFxkf49U2Fcgt1ydCrkknidmto/4YD2k1iwGpZuVTjHcUwgZC2gMFJ8=
Received: from MW4PR04CA0332.namprd04.prod.outlook.com (2603:10b6:303:8a::7)
 by MN2PR12MB3872.namprd12.prod.outlook.com (2603:10b6:208:168::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.16; Thu, 9 Sep
 2021 16:55:49 +0000
Received: from CO1NAM11FT054.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8a:cafe::c6) by MW4PR04CA0332.outlook.office365.com
 (2603:10b6:303:8a::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.16 via Frontend
 Transport; Thu, 9 Sep 2021 16:55:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT054.mail.protection.outlook.com (10.13.174.70) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4500.14 via Frontend Transport; Thu, 9 Sep 2021 16:55:49 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Thu, 9 Sep 2021
 11:55:48 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Thu, 9 Sep 2021
 11:55:47 -0500
Received: from Optimus.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2308.8 via Frontend
 Transport; Thu, 9 Sep 2021 11:55:41 -0500
From: Anson Jacob <Anson.Jacob@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Bhawanpreet.Lakha@amd.com>, <Rodrigo.Siqueira@amd.com>,
 <Aurabindo.Pillai@amd.com>, <Qingqing.Zhuo@amd.com>, <Anson.Jacob@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, Hersen Wu
 <hersenxs.wu@amd.com>, Harry Wentland <harry.wentland@amd.com>
Subject: [PATCH] drm/amd/display: dc_assert_fp_enabled assert only if FPU is
 not enabled
Date: Thu, 9 Sep 2021 12:55:32 -0400
Message-ID: <20210909165532.1351652-1-Anson.Jacob@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7ea3c7b0-c787-44f6-3e01-08d973b2acef
X-MS-TrafficTypeDiagnostic: MN2PR12MB3872:
X-Microsoft-Antispam-PRVS: <MN2PR12MB3872E4B35FC795B0CD9D2569EBD59@MN2PR12MB3872.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:663;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XWHlJc3zis0bo1nHAsnva+VyXGYtxJKpUOsqHYZfmpf3zmS7jIkBd8EVIP4w7EksFiWbcV/6O7wtxLCBdWHQWahXzkjKXDD1PN53omNQbIt1ajHkqtJDYm2KmryXEoLjsYP/arGgNSMRGF0X9SrCHXGN4jLzQ0xLYf3woIhJ+hs+kqgtuTHGdQe3rKgk+5iCPvlMfd3oy5FwKzEu4x79tSk+qFvLzrpJuI2YbSBF8bZ0YVKsGQQa8CKW+K7YgeIC/zuQ3I52v6FqFWwQKK88BcgyCM1pOWzZqtDajdWKDWIrRQauNx/urdD3wpjbmA26/U1GJxC/fvzd/PT1/Zn+toU4TCh/cKI6/HJsR8j6paleS5z3UC6p1Y10S0Tj2pDWEdD7SNPNxvBs49+LPXTwIYITVYu6PeA+JCtPopOBAtqLBoD6LxaGfkwWE46Q6GPWc/gEqGWozNtdyHFaAfbAbw5R9wh3LqNyrtqk3sdzDXHkq2seSd2290mgU7tkrgDQKq5NN5gAsJsmzbXCNEvrRgBKrrmQVbtY/go41AO1TLFapwddGBXUxixaqAdC7LTtYUj8Wd8q7MSnrUbnmwQLm6zSSYgapL0bLP6MgqRH7wXPdWWx8nL1mdqrahJjfadcM4JqRchYy2X0Rjxao8VCvNMbhXltwPQmqMsrwNA0ivB7Ssd6ZhNDxgy1y473IDfMkAY0ty6yhYiAkfAKXR8+AjuHQEpLm8q6+NRDFRsxJyA=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(396003)(346002)(136003)(376002)(39860400002)(46966006)(36840700001)(83380400001)(66574015)(2616005)(1076003)(2906002)(82740400003)(186003)(336012)(6916009)(70206006)(4326008)(426003)(6666004)(478600001)(86362001)(7696005)(70586007)(5660300002)(8936002)(36860700001)(356005)(4744005)(8676002)(47076005)(81166007)(26005)(54906003)(316002)(82310400003)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2021 16:55:49.0699 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ea3c7b0-c787-44f6-3e01-08d973b2acef
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT054.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3872
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

Assert only when FPU is not enabled.

Fixes: e549f77c1965 ("drm/amd/display: Add DC_FP helper to check FPU state")
Signed-off-by: Anson Jacob <Anson.Jacob@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: Hersen Wu <hersenxs.wu@amd.com>
Cc: Harry Wentland <harry.wentland@amd.com>
Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/dc_fpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/dc_fpu.c b/drivers/gpu/drm/amd/display/amdgpu_dm/dc_fpu.c
index c9f47d167472..b1bf80da3a55 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/dc_fpu.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/dc_fpu.c
@@ -62,7 +62,7 @@ inline void dc_assert_fp_enabled(void)
 	depth = *pcpu;
 	put_cpu_ptr(&fpu_recursion_depth);
 
-	ASSERT(depth > 1);
+	ASSERT(depth >= 1);
 }
 
 /**
-- 
2.25.1

