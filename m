Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8151C77B6E
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Apr 2023 15:55:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1042610EDF4;
	Fri, 14 Apr 2023 15:55:20 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on20605.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eaa::605])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D86CA10EDED
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Apr 2023 15:55:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oMWZM6o99nLVJU2hvB969vpz6a5317194+k5EWnt0X0FBHfv1qrcNJZjCwhA5pYKHWLO7qiSTmcviPtK74hf48UkotsTTC/iLD34gUQRnv4e3xyNKtzIKXVUowQZsmAaXgLGR96WKrTSAFizIitjsMsq0ibwzbMU7oL2yen9ZLRj6nmbvE4ke3DVSoMqW+1sw9o7D1NCQHxEKa3Gn63T6u1+3pJ/aMHJocNSPO8KzvvPvf9cSeYJ7fdGWLfGMCbG7yffMZb+PELNAFklVYfX5Hxzf/mT4Kj9A6mTZvAQU9qH3Bh/bzyDtQcijrEwXDwjcCD/EntE5wyROsqKvk1s5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k4V8ORXn0mopO1jQiERWXjeKO09QtBGWJRbCK/vd6ao=;
 b=QRiXu4fMu4gmKYaruPkR0Dr7RUrO/UAniMuyDEDYK6yV9IwZGUaqwrJl5ZRr3wuruUvy+BvtEDA1LqnyTynl7iSAIf02iBnnCQjY77Duzinbkoqb+dTKMqsBlVdKOAk/d5luqZkuno/An45WkFtilnDMNjlfkHlU6a4bUPgW92tbFgKSJXgm23ZMLWTUjfZUpl1aDkMGEBb9jjeES8eHy2hSP3TWT6snDpPSnrEcnjqUgGqSb22zJZ42l4c1H6Q54WfvQPBUhUx9mEahbdX+PQA4ZS4JVI52uAUETCeAkc3YZsYbD0WhXtFVRswSzb2xKYkyBCsMSNM5qj3/AoMQXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k4V8ORXn0mopO1jQiERWXjeKO09QtBGWJRbCK/vd6ao=;
 b=nDYriGfvPYZd0hWp3lj3yzrAlTJmabmLkLUOpiqdFF/JPlijYPBk3LvyEtKRDdxMt1SfIwfKYDscl2w8lxw4bGrJXBTncFuLJfVAn6fRSur0N6PbvGrrFEabNWh9xSizGMiT3mi9Jp9fX/FSezFrtyoHrlpHSwy4TGgmZxP4/9w=
Received: from DS7PR06CA0021.namprd06.prod.outlook.com (2603:10b6:8:2a::23) by
 IA0PR12MB8326.namprd12.prod.outlook.com (2603:10b6:208:40d::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6277.38; Fri, 14 Apr 2023 15:55:13 +0000
Received: from DM6NAM11FT087.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:2a:cafe::18) by DS7PR06CA0021.outlook.office365.com
 (2603:10b6:8:2a::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.36 via Frontend
 Transport; Fri, 14 Apr 2023 15:55:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT087.mail.protection.outlook.com (10.13.172.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6298.38 via Frontend Transport; Fri, 14 Apr 2023 15:55:13 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 14 Apr
 2023 10:55:11 -0500
From: Qingqing Zhuo <Qingqing.Zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 57/66] drm/amd/display: 3-plane MPO enablement for DCN321
Date: Fri, 14 Apr 2023 11:53:21 -0400
Message-ID: <20230414155330.5215-58-Qingqing.Zhuo@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230414155330.5215-1-Qingqing.Zhuo@amd.com>
References: <20230414155330.5215-1-Qingqing.Zhuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT087:EE_|IA0PR12MB8326:EE_
X-MS-Office365-Filtering-Correlation-Id: bd359c81-fbeb-403f-8fe3-08db3d00a257
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vMvABsSdWPgGz38iBdDt2bZ7tgb+u2gNko6AI4dc8ugJjYNAO7JiAKbEmxK/Psaa5RygDmjYFqNocuVXihO7jbNNIE//QviEppIAuJNvyfHO8ME9zG062k1CXZv8Ojo+qH2pfT7y9kxgfuRLShcE6XXkxGTkPHiVrJhjTU7YZEVNyg5f5guSBAqaERdYAanuxaVdKPOjoP5Y0iYQWJ9J/mcFpAYU6FsL41JJqPqcQEx8yT516YuZehFsRAHe4BMeZmVzWOCiL/PGCdkA54ZuTw04cAnzwQ1Sl4u0H124GT7L52WbNXfJT4sVMF85mwRy5eR+qgAF0+9QMk5kABHTT6sE2bdffSfMgUIqB+S1aA5qpx7iJ82y1gKhQAwQYURXlhn3y0j7NQ4Qyz9O98gJfCTykqvTlc9tjNZoB9j9vPwLf4A3VWEueVEnSXPECqw9hjTemhJmzTHhxzAYy0miGiUdgcHTonTxTBhCxisbqCKBjK3u8CCr1hgQRcoKpn8KkDYPNfCk7hYFkrHThIz522UqdCDg8klFNbEehgSNKblvUoFDBTx416JnoOHyuSENqjFRkkAdjsfvW6lwzfM9q4aZGoemBUV8cBW/wL9pvSEhwBLl/ERhhMtOs5LyrqDmT3+XTJv3KCtGy4/x7DJ1Fs1EF3xlSZbZ5+I5lv6zXw/Jspp642IFfDGaGbHqkolqyuLXzlsVj+5wVeSjXMSx3omSmdOUbv55iooEhnQD4qE=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(39860400002)(346002)(136003)(396003)(451199021)(46966006)(40470700004)(36840700001)(478600001)(36756003)(86362001)(316002)(41300700001)(70586007)(4326008)(8676002)(54906003)(70206006)(6916009)(8936002)(82310400005)(36860700001)(40480700001)(2906002)(356005)(16526019)(186003)(81166007)(5660300002)(82740400003)(6666004)(1076003)(26005)(426003)(2616005)(336012)(83380400001)(47076005)(40460700003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2023 15:55:13.5217 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bd359c81-fbeb-403f-8fe3-08db3d00a257
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT087.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8326
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
Cc: stylon.wang@amd.com, Krunoslav Kovac <Krunoslav.Kovac@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Krunoslav Kovac <Krunoslav.Kovac@amd.com>

Enable 3-planes MPO for DCN321 by reporting max_slave_planes in DC caps
for each ASIC.

Reviewed-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: Krunoslav Kovac <Krunoslav.Kovac@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c b/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c
index cf21b240fc55..138657c38afe 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c
@@ -1727,9 +1727,9 @@ static bool dcn321_resource_construct(
 	dc->caps.subvp_pstate_allow_width_us = 20;
 	dc->caps.subvp_vertical_int_margin_us = 30;
 	dc->caps.subvp_drr_vblank_start_margin_us = 100; // 100us margin
-	dc->caps.max_slave_planes = 1;
-	dc->caps.max_slave_yuv_planes = 1;
-	dc->caps.max_slave_rgb_planes = 1;
+	dc->caps.max_slave_planes = 2;
+	dc->caps.max_slave_yuv_planes = 2;
+	dc->caps.max_slave_rgb_planes = 2;
 	dc->caps.post_blend_color_processing = true;
 	dc->caps.force_dp_tps4_for_cp2520 = true;
 	dc->caps.dp_hpo = true;
-- 
2.34.1

