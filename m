Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BB2CC4332F
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Nov 2022 15:23:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6DA0C10E4BA;
	Wed,  2 Nov 2022 15:23:56 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2069.outbound.protection.outlook.com [40.107.237.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A9CF810E4B2
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Nov 2022 15:23:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ezV9vfpS8DYWSNra8XysDqlzsruQFNulYMu+fy9KVAVsDSMMfPaZQYMNgWrtKKuWfuMcOueB8VrPcr6NP59OsiuKk7JF4YZ5rEk9cMPtcjB30rZoxbOWzGpxDtzFX2k1gxYR5QFK0/lbTgN8ZdA24ws4Jn7K0+W2aAf8pwnlaWC/07haxw4pMCz2EyAT8DFFXObW3KE/1q3vIJMVrigGYSlURgYnVfNYSN5HGQs/JYuUsA0coPhzzbKV6CjSBhPX/xPi/msxmOIPHA+FHbbAMwxFm/U2dDbAZYBo4huu8QkQj1VS2hLqcAjQ2Qiql3r/BLw/kbg6QhJ609mwYGEf5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cfnSNbzvQ1AmUVuQXfFHtNXX1EbbQiXrbZi67whBRZs=;
 b=BZ3l5apyXeC6PiWFW3Gqnv0on3tb82Ph4mA13Cz2/1ppedsvXRMsBgE8V4h3QyNwG8WXQuI58KB8JhL/v6lrRI7yp1Ota/STMzfwP1HkeygpqSWHs/dEmfT/4Wct2oz8RkH9cZiNEGz8QkCoY7/why0CsrcTYMEWvu+KXbzPzAEHDPNlVx0J2Q0gTJmP7HtK1FDvBcrrnZEbGhVqSzwwp67VhVuVoPM/NVFB7qFvuBHL2mvuasBtw2R6qPqyTMW2YynTI6pOgwjaKJsfRQ2wRfkOUftRu8TUOwzGRwKmELoYYzeIaO9aSE9yNmuO3VP7v6kw760wSCTLwQJKzs8aBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cfnSNbzvQ1AmUVuQXfFHtNXX1EbbQiXrbZi67whBRZs=;
 b=b0fIMIvD8y+WI98sQBxnEVKqBBbyzsnB0rundEcHFPJ025YU474CRj4ucomJ/YXqSwuIsmLGDTT8zSwDsw9Kierp9escG1bD6aqIGdkD6EY6g7lSvHJXB/9o9YQkrd2r01C2+qHsPBGoAsVoVgzRlk7R0qFei7vOga8k6S2Xaak=
Received: from MW4PR02CA0020.namprd02.prod.outlook.com (2603:10b6:303:16d::26)
 by DS7PR12MB5885.namprd12.prod.outlook.com (2603:10b6:8:78::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.19; Wed, 2 Nov
 2022 15:23:51 +0000
Received: from CO1NAM11FT018.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:16d:cafe::c4) by MW4PR02CA0020.outlook.office365.com
 (2603:10b6:303:16d::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.21 via Frontend
 Transport; Wed, 2 Nov 2022 15:23:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT018.mail.protection.outlook.com (10.13.175.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5791.20 via Frontend Transport; Wed, 2 Nov 2022 15:23:51 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Wed, 2 Nov
 2022 10:23:48 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 3/3] drm/amdgpu/gfx11: set gfx.funcs in early init
Date: Wed, 2 Nov 2022 11:23:33 -0400
Message-ID: <20221102152333.553521-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221102152333.553521-1-alexander.deucher@amd.com>
References: <20221102152333.553521-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT018:EE_|DS7PR12MB5885:EE_
X-MS-Office365-Filtering-Correlation-Id: e858ad24-6e50-4da1-5bbe-08dabce63f0e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4xSafpmfF144NOBB76Lm9EE1wrtdhQ9MBwDHcSc0bOd2atD/4xlICOTLCrs2eSvV9lFb0pQegkKMYMoMy6xUqAYmriJisPk1Ex8pxrOSf+nJr73KJXxmTIi5P7Chjd7P42LiHn6sN+z44ZMS8f29ZGOG7UZDaGumXMDxQBoEhiTlPuZ1FVNghVLAt5q4XNIzVcI0kBqhltJg5d+Sr66hBKf5fcZyXhgtpZCEyvX9F//ztAGLA4NFO6g5pBeIRjE6Ayjvqtzxkj0/fVmAtY94ThUUVrlLVi3wFOPr0WmW7yIt2nQeNqiMiepDPIcBRdbJDwy5xFzJoYjGz3EEEM4tIMvwmZItzqNIey5iMWBHGZnIz+0uE8hvCOyyroe3Fk3ghO9+tzGzm0E/e7j3nStuuQMhLNzxVU9Gh9tUng0LwDEBej5yQXpoccmo9xQpQ1ErnCKV5Ok1t1xDmARvCruil19P80PDmUW9b8fkv2ueJsa19pn8eKsgB3OD/0mOCm5SGVKtoHU5KewxSzsR/DthAwUXaKWV5L9pbvoDWJzBV3tr3qAuy2HSONeWSFJeR60J4sf6WBAQjarS4dgVnX/1RMUZJQ11iF8KlVyfsYFH3gc603QomFhDl95uw2lgOdcaVe6fo37Z3MkJ0lhKKYcCrvnNnSZdjIp27wDOH86nUYePHSbLyc47glkjo9tbxwIvL6fcygMV2XbvVSXK3wZNTSbmCzPHQ3Oj6kgGD5Osbtr52fk8OGW9cl1sesqdsiFbQl+1OM8b8fjvNRrysG4J0+K1Sis/NXezMmH2bWhFwpfy3UByguD21jKoaP8XSARf
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(376002)(396003)(346002)(39860400002)(136003)(451199015)(46966006)(40470700004)(36840700001)(336012)(82740400003)(36860700001)(478600001)(47076005)(426003)(2906002)(83380400001)(26005)(40480700001)(70206006)(70586007)(8676002)(4326008)(356005)(6916009)(2616005)(82310400005)(81166007)(316002)(86362001)(5660300002)(1076003)(7696005)(16526019)(186003)(41300700001)(40460700003)(8936002)(6666004)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2022 15:23:51.1033 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e858ad24-6e50-4da1-5bbe-08dabce63f0e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT018.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5885
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

So the callbacks are set early in case we need them.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index f68e13b6282c..4ebef1b33f3c 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -843,7 +843,6 @@ static const struct amdgpu_gfx_funcs gfx_v11_0_gfx_funcs = {
 
 static int gfx_v11_0_gpu_early_init(struct amdgpu_device *adev)
 {
-	adev->gfx.funcs = &gfx_v11_0_gfx_funcs;
 
 	switch (adev->ip_versions[GC_HWIP][0]) {
 	case IP_VERSION(11, 0, 0):
@@ -4657,6 +4656,8 @@ static int gfx_v11_0_early_init(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 
+	adev->gfx.funcs = &gfx_v11_0_gfx_funcs;
+
 	adev->gfx.num_gfx_rings = GFX11_NUM_GFX_RINGS;
 	adev->gfx.num_compute_rings = min(amdgpu_gfx_get_num_kcq(adev),
 					  AMDGPU_MAX_COMPUTE_RINGS);
-- 
2.37.3

