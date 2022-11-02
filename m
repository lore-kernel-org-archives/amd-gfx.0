Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8779C4332F
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Nov 2022 15:23:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1F38810E1C0;
	Wed,  2 Nov 2022 15:23:52 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2080.outbound.protection.outlook.com [40.107.220.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AD2A510E1C0
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Nov 2022 15:23:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fB4Ecc1EBRKHTp2zM0jseA1Yq/ZVcK7zaOvaspAssx3Pz1yJsaVaxbQjmV3wty07p2huSvMeUxlrB4JZG+kdLM6S1pRjpY8XFOTM6lvsYUrFaG7kmeNcjGaYn15XZARhPHI0jBdPLgGtmNXZfm4EB9i1U8LE3y25RpSWkPD66A6jfLdLrqfRg5EJE7g1qfpsuNK8Ba4QfT6UgfKFuv+qg82abNvzIdbyoKr/dqVQyEXErPtB8kTxw9dDykFX07KaaRWQo0AF1BLX7RQykkQ48yGpDV6Pc+ChwXCYdPuXuHuA1tINH2Q3jLNsdax8zFXKGA7gZM9GsDpbS2SMiApD1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XlzCgyqSn3wIxPT6iY/ZstFmDFqMgx2e+vtXSzoLErg=;
 b=OnxEMWaK3Vd6AUGZJ0wTwtoffCzV5/zDbTMV7bSuezkdKHD75S76lP/kDEq4atfDAJKINKyNkk/iwRSs+/MGEUin4e02AWFc5Fg3AqOFo3EMt0sSCHButJItC0ZQC/ZaJMFcXh3qUAjXcMxZ8TYUQJigf8noVSZ9B3zxSthj42DJ6OX3XrwHKQ6mPCaIfPo5P00gjYPcysrdQBqns3dXLSittyYnizXmsefz7euRnZz0E5Y1TQPdKlVBN91BG3h5BsLJb+P6QR5DQzx+ZMTQFZim/edhK5HP9+GFYc4sy6kYbbfX+B10Foe1IlDQ+E6jQxZgHlsHlCaAPIYB8KSyZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XlzCgyqSn3wIxPT6iY/ZstFmDFqMgx2e+vtXSzoLErg=;
 b=pNR/1pGyBS0EN0I5iiwrH/gShWnNuahvrmqfanFUXBuOjgXZG4Zll4q8FQTCUCr/LYBWqpgIlTn3ZtUDyN4Hn7eS3a5bllqnjHjHA2GS3gGAgRcLmbmjStqI8xd/HxQ3XuAGSUQP/xbjgZHfQ8xv6QLJsR6O5u+61tTTIJy4jyE=
Received: from MW4PR02CA0009.namprd02.prod.outlook.com (2603:10b6:303:16d::20)
 by BN9PR12MB5083.namprd12.prod.outlook.com (2603:10b6:408:134::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.22; Wed, 2 Nov
 2022 15:23:49 +0000
Received: from CO1NAM11FT018.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:16d:cafe::8) by MW4PR02CA0009.outlook.office365.com
 (2603:10b6:303:16d::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.21 via Frontend
 Transport; Wed, 2 Nov 2022 15:23:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT018.mail.protection.outlook.com (10.13.175.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5791.20 via Frontend Transport; Wed, 2 Nov 2022 15:23:48 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Wed, 2 Nov
 2022 10:23:47 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/3] drm/amdgpu/gfx9: set gfx.funcs in early init
Date: Wed, 2 Nov 2022 11:23:31 -0400
Message-ID: <20221102152333.553521-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT018:EE_|BN9PR12MB5083:EE_
X-MS-Office365-Filtering-Correlation-Id: d2a9aa34-bece-49c5-d508-08dabce63d9c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: g7RP4rtW1Wsb1YCdhRH7K+dsScAhlCkIEHu6q7xlGzJ33H8amMJnZRbn13knv6j/3UQNwwIuAQbvnGkL091XfP0kpQYZwhDLAnXrenHc/d1DZBb8MoMr2mWrPx6T0x/FSSt5NcaL8tmb+LwXHwwzCZ+sehgjWP0tOU+JgaPnqeN4kO+PzrLPSmcXp+S1yXXKhH3SsAo4vpoMPTa2X/D5Qc5TpAcqp78Me7PxnACDJtCc9Y2NiJhJMAdagky0ZsuRQq9byZLaBbSRuqwBSJbnQLNLD6Svdupxxr1i7l2kBAcY5CIXfBlVHT9h54d5uJLKhBNXB0SNCgJlCeylw6+qHw+iT/sbEBoDx/R7n6EVIvClObYVU+SLiD2KGY2Oz8C8nw8AnAbVYG9vBaJMgZ293qZhYm6rK/2eLpQPduTY1z6ldZ5791wnhGCGEK5P5kIXQxVSw9oxTevuPisJuEdHr0zMKmSqWw5+Xy71hvEeQbfLmz+gBqv2fn/AAjpKn1O+aXKxA0FffBzptU9uCJcraCa8rvP2XCZHNQ140x7IJ0G0Uj66b2mmd3/RlZj0HpedHo1y0KNWqev47SFWE3PL6wB1c9Zo4z4K3E8dxpT5/jN1nXRa5IS+MYFeEcGGjjDaHV924KWTcaG0NJuwe0DP/Zsb4XFkBKerA6bNoaYW38QvIck79bgsZFoYthisH64Z8b5tA9qO8HtDI1c8wgB9+kzdgV7Q87daFKOTIqakW1ZEKazea0nP9z075qUB+IJM9xl2RO26CpstXy9yesksTzOmnAT7CE73djnCdnEfzUfUjStnCHeTQlp3CCbh1xVL
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(346002)(376002)(39860400002)(396003)(136003)(451199015)(40470700004)(46966006)(36840700001)(83380400001)(426003)(7696005)(1076003)(186003)(16526019)(82740400003)(6666004)(336012)(47076005)(478600001)(26005)(2616005)(40480700001)(70206006)(316002)(70586007)(4326008)(8936002)(6916009)(8676002)(41300700001)(5660300002)(36860700001)(36756003)(2906002)(356005)(81166007)(82310400005)(40460700003)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2022 15:23:48.6816 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d2a9aa34-bece-49c5-d508-08dabce63d9c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT018.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5083
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

So the callbacks are set before we use them.

Fixes: 0c9646e1a043 ("drm/amdgpu: switch to select_se_sh wrapper for gfx v9_0")
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 877521230529..5d23a0f03615 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -1921,8 +1921,6 @@ static int gfx_v9_0_gpu_early_init(struct amdgpu_device *adev)
 	u32 gb_addr_config;
 	int err;
 
-	adev->gfx.funcs = &gfx_v9_0_gfx_funcs;
-
 	switch (adev->ip_versions[GC_HWIP][0]) {
 	case IP_VERSION(9, 0, 1):
 		adev->gfx.config.max_hw_contexts = 8;
@@ -4541,6 +4539,8 @@ static int gfx_v9_0_early_init(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 
+	adev->gfx.funcs = &gfx_v9_0_gfx_funcs;
+
 	if (adev->ip_versions[GC_HWIP][0] == IP_VERSION(9, 4, 1) ||
 	    adev->ip_versions[GC_HWIP][0] == IP_VERSION(9, 4, 2))
 		adev->gfx.num_gfx_rings = 0;
-- 
2.37.3

