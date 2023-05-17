Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D457C77B7D
	for <amd-gfx@archiver.kernel.org>; Wed, 17 May 2023 16:19:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B688A10E209;
	Wed, 17 May 2023 16:19:35 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2062e.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eaa::62e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5D73F10E209
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 May 2023 16:19:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aL1qUn3Nt/jJo0xamdfZYPES1WykRZRQQzRghNH+jPOobKwg9U5LI7m87MLXPIFaIF+zhW++HdTmoEXqqAmMrZ7Vz/1SZHAFWWXaPAp10ehQeR5tlADRUmjbhvTF+s+gV1PLdsnpmyw/mOETGQ/yayZSTbMo2E/3dkSRSMUox5ndR7RIFbUGJ39opIiouftzuQciOoLmEMY/awi/y8nMKX1jRqlW+sCKpLu+78+jLA/1ex7gv9+QpDN3+fAuyj5Zk4+howln6+m4W0IQvJAXumq/qoyThxVHCgarDF+NojRERHp49QtzflzpiDlhyLbE4B63bYsMM2hJYv7bQMoEqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MBJO9k1++AmGTJQk5dBnkeLKGavN7NcsUqx/5qIzDIA=;
 b=FU6//ifBXulO91wMuLqdb+bNk3JzxB3sNFyD8PgSMWug1s4ldHhuavc+qVx14glHwRF0Ev9QDlH0PF6spkP63ibOKegI90xz1kBBvzKhGcWpEP7a98xsW/G0yU2WxfL2faNr86ycOnA0rt6ex351c03pXqBfgt12FH89IOfb0GRTj+dpsfjAY33sampAf9+YfcEEkiqgocbv45OmE7yYCzL9oD2Gk9AHMkJdtuwROKpUJnKEOIMICC6y888txmhVRrJEHrVT7/4e36wLoyliZaIgueznMpF/fYOvq0I9BCxDZ9eDeVnf/Da1ztzTFtnJEwyAH6LrOsDkonsHjlt8rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MBJO9k1++AmGTJQk5dBnkeLKGavN7NcsUqx/5qIzDIA=;
 b=wuyIKZDN+tR+C1a0fhAairUSOaB+y+5y2KibG8MJrZ/L45HfPMfhdptFrKYvaUbLVrAoNxMCe63uto4/jsDWWBuMUh5qeifSQV2TrofS07eJEXGzCNQ15Xb6v9ss2QJk+3ndhBtjERLHB94LhMoLep+/zMv3Hgce9IN/tR5XV2o=
Received: from BN9PR03CA0904.namprd03.prod.outlook.com (2603:10b6:408:107::9)
 by IA1PR12MB6090.namprd12.prod.outlook.com (2603:10b6:208:3ee::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.33; Wed, 17 May
 2023 16:19:31 +0000
Received: from BN8NAM11FT025.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:107:cafe::af) by BN9PR03CA0904.outlook.office365.com
 (2603:10b6:408:107::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.18 via Frontend
 Transport; Wed, 17 May 2023 16:19:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT025.mail.protection.outlook.com (10.13.177.136) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6411.18 via Frontend Transport; Wed, 17 May 2023 16:19:31 +0000
Received: from mkgs-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 17 May
 2023 11:19:28 -0500
From: Graham Sider <Graham.Sider@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: disable extra gfx943 legacy flush on rev1+
Date: Wed, 17 May 2023 12:19:09 -0400
Message-ID: <20230517161909.359715-1-Graham.Sider@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT025:EE_|IA1PR12MB6090:EE_
X-MS-Office365-Filtering-Correlation-Id: 9296fc76-048c-4a57-eb21-08db56f27f24
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +wMX3g5Ts97WY458SaOI5pB5ch03MwTuKI3v6fUYd8Q0plBRC3vW23lL1mDiXojkPNNKvWSow9QdF74TLewY8RK1dCNiI5oG9seZe9F++lgPB+zT6F+0f+ohwRLgnDVgPIrnb/Wgqpwb9APKREiyJukD34WNx9HhZbAmGCZuIe592bdlBojuvFCqm94O0sUvhlTTAHsLK4f7atVNSisLQYKHWCBJ170KKJYjwunduVKfLP1sFdrCYUpek4uB4/+10jmSAU5pNM98mgZqt7xhigYTDJLRqxgvsAvPETtj3ZdtQuFgk3K9a5RixesELFhPihnGmSS9XGKdDAVmsA1GhEynYKrZHI9KteD0ko4uDAqtxz8n2qABrdb0gBbrZF+TYeDs2JcPSd5qR9IZyZt33f0wmt+cp+dH3nx+1NfdukKwgj64b0Zg4aZccqYJwarMA0Bx33xDJ9HbbeAHG0aG+h6dbya2vkAsBxtOZHAxg9i0qO7RYjpBaWKWEX26m38/ckrrscCWgHCH7v+e8KXYt4GFBXMH6s01hpODQcacbT7erdNaXt178L3NV0QaHD9P/Q6xOfreesG8ZzofwEcM1Y/EOHWn7gSfjZiy/AEkZZ9xiFH86MgpfrC6OeHtBR26GbX7MOTaGzxVEkiUfNCe/FGkGgR4b3kk1cC990SKVBulUSa0OXgIwMf033yCrfN00fEpxsF5HHzOc3/S0w7h3e/pEdFTF5sVOq0hGEqEhrLCREYBOF02aEz1S4GMhXdUJDB8/+JxN+8bwgFSq/lBtA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(39860400002)(136003)(396003)(376002)(451199021)(46966006)(36840700001)(40470700004)(40460700003)(5660300002)(36860700001)(8936002)(47076005)(16526019)(36756003)(83380400001)(82740400003)(81166007)(2906002)(2616005)(356005)(186003)(426003)(336012)(82310400005)(86362001)(8676002)(40480700001)(1076003)(26005)(6666004)(316002)(4326008)(6916009)(41300700001)(70586007)(70206006)(7696005)(478600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2023 16:19:31.7788 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9296fc76-048c-4a57-eb21-08db56f27f24
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT025.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6090
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
Cc: Graham Sider <Graham.Sider@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The extra legacy TLB flush mitigation is only required on rev0.

Signed-off-by: Graham Sider <Graham.Sider@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index 38e4828f574e..ba8251b6b279 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -844,11 +844,8 @@ static void gmc_v9_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
 		inv_req = gmc_v9_0_get_invalidate_req(vmid, 2);
 		inv_req2 = gmc_v9_0_get_invalidate_req(vmid, flush_type);
 	} else if (flush_type == 2 &&
-		   adev->ip_versions[GC_HWIP][0] == IP_VERSION(9, 4, 3)) {
-		/* FIXME: Temporarily add a legacy flush (type 0) before heavyweight
-		 * flush for gfx943 to mitigate a bug which causes CPC UTCL1 to return
-		 * stale translations even after TLB heavyweight flush.
-		 */
+		   adev->ip_versions[GC_HWIP][0] == IP_VERSION(9, 4, 3) &&
+		   adev->rev_id == 0) {
 		inv_req = gmc_v9_0_get_invalidate_req(vmid, 0);
 		inv_req2 = gmc_v9_0_get_invalidate_req(vmid, flush_type);
 	} else {
@@ -993,11 +990,9 @@ static int gmc_v9_0_flush_gpu_tlb_pasid(struct amdgpu_device *adev,
 			kiq->pmf->kiq_invalidate_tlbs(ring,
 						      pasid, 2, all_hub);
 
-		/* FIXME: Temporarily add a legacy flush (type 0) before heavyweight
-		 * flush for gfx943 to mitigate a bug which causes CPC UTCL1 to return
-		 * stale translations even after TLB heavyweight flush.
-		 */
-		if (flush_type == 2 && adev->ip_versions[GC_HWIP][0] == IP_VERSION(9, 4, 3))
+		if (flush_type == 2 &&
+		    adev->ip_versions[GC_HWIP][0] == IP_VERSION(9, 4, 3) &&
+		    adev->rev_id == 0)
 			kiq->pmf->kiq_invalidate_tlbs(ring,
 						pasid, 0, all_hub);
 
-- 
2.25.1

