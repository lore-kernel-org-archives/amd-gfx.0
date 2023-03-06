Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFEBAC678DB
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Mar 2023 02:32:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 44AF910E03F;
	Mon,  6 Mar 2023 02:32:54 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2049.outbound.protection.outlook.com [40.107.237.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 620E810E03F
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 Mar 2023 02:32:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cJ0W8S8EPKEOGCAiH67pAfuTICzs5YizVEMVJfrrO1f2d3cm0JPi9BMFvP9J0lKh7TNJdUoxbRhvrbrP8e5mgkLrBskBntifELrlN8vaZbetxM9fE5T/q09qe4CjhSed+3Jel5JrQCnQHuTnFDCvsGYD68HT5QH05t1EW0SqLu4BATPedgtfakEY35CqyaeljrCWg1TLGgxPGD3RKMN9qLOPncl0Qhw+90Fv+jO/1iaCz8BQXp2N699W+8I3ZclOTR1b1Nh6PFvyCH9mHO5iNFf06JgD5LcTjrptFdlbQ6Bj/S77MNnViPyac2fNVpnaj+01DTY29TO+9OJDytSaiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JkLdAyrd8DhQlCCZJE6CD2+Zajt5b9kvgRkyQs1Syn4=;
 b=fCK0QHbgHCe6UDhW/MBHKJWXyvfdG7/hQgtwllFn3r3pkyTjb8fpZR1810bjz5dQar5WLZieYwx7XcYErXdYqfM2tkhEBDZUcn3qarq9SNxrsgCQ2gDAy2wAk0Z2+gB08bSs1NmgPir/BCwKfXrvKEogOeo2jI7+Hjo1XCsWHDffyFzrqEVawJ7W3i226TjMnB+v9g2jlLOGC57qZ1LjJQZongGKC3K9fq3MYvJ1jmkJtPBT+7OR+pKnDcAfoAmSjL8cfShYBRzigeqNWBNlNS9Rc03CQprDmX3H9d6+3tcdHLDNDqjlqwhlodnwC4o+gk7M4zDZxyWoiMB8Ld0KVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JkLdAyrd8DhQlCCZJE6CD2+Zajt5b9kvgRkyQs1Syn4=;
 b=l5TFJG1YZFo0KLg7H7BW9FZkFXNUXEYahPYEaZBpXgF/qYdTDD8ojMnRkFDeh1RYaW7fo0lBTd1w6LnvSnhfZaz4xcZH7UlFbfsXQ2Wlii4ykKIJHKU2zsYY+MIYqIRFNlEcL2SxFXQA7d7hkzlv36fXgoQ1c6fsYiRdUb+R6LU=
Received: from BN9PR03CA0661.namprd03.prod.outlook.com (2603:10b6:408:10e::6)
 by IA1PR12MB8360.namprd12.prod.outlook.com (2603:10b6:208:3d8::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.27; Mon, 6 Mar
 2023 02:32:50 +0000
Received: from BN8NAM11FT053.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:10e:cafe::3e) by BN9PR03CA0661.outlook.office365.com
 (2603:10b6:408:10e::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.27 via Frontend
 Transport; Mon, 6 Mar 2023 02:32:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT053.mail.protection.outlook.com (10.13.177.209) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.15 via Frontend Transport; Mon, 6 Mar 2023 02:32:50 +0000
Received: from hawzhang-System-Product-Master.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Sun, 5 Mar 2023 20:32:48 -0600
From: Hawking Zhang <Hawking.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, Tao Zhou <tao.zhou1@amd.com>, "Stanley
 Yang" <Stanley.Yang@amd.com>, Candice Li <Candice.Li@amd.com>, Thomas Chai
 <YiPeng.Chai@amd.com>
Subject: [PATCH 03/11] drm/amdgpu: Init gfx ras block when ras is supported
Date: Mon, 6 Mar 2023 10:31:52 +0800
Message-ID: <20230306023200.29158-4-Hawking.Zhang@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230306023200.29158-1-Hawking.Zhang@amd.com>
References: <20230306023200.29158-1-Hawking.Zhang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT053:EE_|IA1PR12MB8360:EE_
X-MS-Office365-Filtering-Correlation-Id: 37cd9cb7-f98e-4870-2615-08db1deb1489
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /X3U0BLhlzkz6oNyVUarU4Q2UYUG0kmSXqL911WA2udSn83SQcgti1gEG9muTdAfaYkjTuEK3oxDWW+/bUnjNzx67rapBs61Ag4bmX1vRHCk/YbIK38eH1GxqofMmGRR06Vg6klR7ZfK9Z7fNQzhilrst7WJ6B3+WumndY43lDh14vuV9t3+vPRVdDEc2MEjijC4RYdh+JPt1MxNlqFLLTJuGLEpGwfR25LWMPwJpVHBQY7oHnXq7e2LkZD3ZT+TH2mA4LN+IbISsjaPXtASLhZ5ku8eEClTVdXmtZWSFqs64mOgNfvk0UKgZOaFs4dt6LdWrOCmfvm4SGZQ9kwo0/iAhUINp6h8zGzR2aGmv1bpPCkKarum3EZG7+C8kVrjboMHNPNlSRrJZW0wj0hlsSyZ+4/NSlvlv6+FQHgOUqtwYTqJ8gKdpzU7PDsSM773+2KKZiJo2E+MZeiQcHgLHaUtq2QB6Y+RNvotTBy9mwIwu0D/P3A8QE1uSvAlMP/27HE2go/pzFOFJtH66d7ycOksrLx0gzZe5cKCu2YXDAl/R8fbaNdG4BD62YDQZA2Qh2uQrAXerXHjx38gANag20WboVXswKA+1aFtAhpgmeWOcTRcKB+td5VeC2D3yrKOdRtADbGrGLd0E4lzm/pBebjxqeTYeqV/FduOwLXUyI1n0X4r6rCSLzQilSjuf07ohlGZsrKz5RMcMK5vpJ4r3FQTogHzN5/sAeCQYSSKank=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(39860400002)(136003)(396003)(376002)(346002)(451199018)(40470700004)(36840700001)(46966006)(82310400005)(82740400003)(36860700001)(83380400001)(47076005)(426003)(36756003)(478600001)(110136005)(81166007)(356005)(6636002)(316002)(40460700003)(336012)(7696005)(2616005)(6666004)(1076003)(186003)(26005)(16526019)(5660300002)(70206006)(70586007)(41300700001)(8936002)(2906002)(8676002)(86362001)(40480700001)(4326008)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2023 02:32:50.1640 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 37cd9cb7-f98e-4870-2615-08db1deb1489
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT053.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8360
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
Cc: Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Initialize gfx ras block only when gfx ip block
supports ras features.

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 9 ++++++---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c  | 9 ++++++---
 2 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 3bf697a80cf2..d7d4847e2644 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -1409,9 +1409,12 @@ static int gfx_v11_0_sw_init(void *handle)
 	if (r)
 		return r;
 
-	if (amdgpu_gfx_ras_sw_init(adev)) {
-		dev_err(adev->dev, "Failed to initialize gfx ras block!\n");
-		return -EINVAL;
+	if (amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__GFX)) {
+		r = amdgpu_gfx_ras_sw_init(adev);
+		if (r) {
+			dev_err(adev->dev, "Failed to initialize gfx ras block!\n");
+			return r;
+		}
 	}
 
 	return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index ae09fc1cfe6b..c9657e89d40e 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -2177,9 +2177,12 @@ static int gfx_v9_0_sw_init(void *handle)
 	if (r)
 		return r;
 
-	if (amdgpu_gfx_ras_sw_init(adev)) {
-		dev_err(adev->dev, "Failed to initialize gfx ras block!\n");
-		return -EINVAL;
+	if (amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__GFX)) {
+		r = amdgpu_gfx_ras_sw_init(adev);
+		if (r) {
+			dev_err(adev->dev, "Failed to initialize gfx ras block!\n");
+			return r;
+		}
 	}
 
 	return 0;
-- 
2.17.1

