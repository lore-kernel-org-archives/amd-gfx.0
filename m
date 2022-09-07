Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3699AC38145
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Sep 2022 18:13:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2456410E819;
	Wed,  7 Sep 2022 18:12:54 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2061.outbound.protection.outlook.com [40.107.237.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 361CF10E80B
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Sep 2022 18:12:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DGw2dAEvncsvd9OlQMgQ+zvaXOh5wbCVqEhSgMMuDCoH4226ommwPMR5BFWfhlmRve6DzygJOv4IOPajCsbjktA3VRK9pZn2Dh9FFdujRKaosoe/QwWu6zNhEMayMa9PFADuw5SD4PNpkLgBvwwxRl9M6nlTEKd+ffD2rYY8HzAMQdCBQCuzRxAXHC3tvDlX/vX6gOgc1EQYpZUxQ6ncjygPz4S8wcG7AanZTFluRgvXyX2Xa4qfeoKAQrhbWAGAKr/e7WrK4lRixouXZba5jivvla+KtCzv9INCcZOcP06s4H6Thkdy8QOTMFpvk5Bx6+HFXB92MoQBlKT2Z8g6Xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g1Gnf8fPO8tomxLfu7kUCrmguZaKdCY2vHZ7F7ynYOI=;
 b=DrFyGsnlBI0FUPsDJbdZZc1SQQ8mQfwpgcjIqep6RBEoPlXmNx1JqlXCqXZ7eTDFFzy+8FAJcGNP2MxYmAhKdQlTocIyhfbjmbrbTFhK/OIug9yFQ5Myl+6HCQ7W4jm6oOFiQVfWkewtgznuUsWbEXKjS9kFwcIG1uMtyCq3dmMAzt1tG1SdvC8X58ar53Rf3fVCKZHqUMhxEMe5IHVVFiwwOExrIGlp1+fTrlUxA4ihgOCTSgliix+qbu7opMkk2Rn7SYiLEm37+y5mlKS+YujKAP2nNRGD3Ha7hyFG9TVh+oFxwZIJTt9/v7/9lbYTyPq9g98e5HT3vIxqxnyiew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g1Gnf8fPO8tomxLfu7kUCrmguZaKdCY2vHZ7F7ynYOI=;
 b=Psk0gjUqHABjM9xC+LBtwEy0LdXA01lY+t5HXSAIuYDZhHBUEHjmMu6fkR+gk+n83KyNpCovIh3hfsVPvd6+hZz5a3KMiKGUEKS8B6LNckiZC0IC6YOTs5xvZznmUXYSQZ+0IMnhfrIAxwdMw+zNe03nLp+0dsgGo2VfMAWnlJc=
Received: from DS7PR03CA0045.namprd03.prod.outlook.com (2603:10b6:5:3b5::20)
 by LV2PR12MB5967.namprd12.prod.outlook.com (2603:10b6:408:170::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.12; Wed, 7 Sep
 2022 18:12:35 +0000
Received: from DM6NAM11FT065.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b5:cafe::d1) by DS7PR03CA0045.outlook.office365.com
 (2603:10b6:5:3b5::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.14 via Frontend
 Transport; Wed, 7 Sep 2022 18:12:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT065.mail.protection.outlook.com (10.13.172.109) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5612.13 via Frontend Transport; Wed, 7 Sep 2022 18:12:35 +0000
Received: from promo.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 7 Sep
 2022 13:12:31 -0500
From: Pavle Kotarac <pavle.kotarac@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 15/21] drm/amd/display: Limit user regamma to a valid value
Date: Wed, 7 Sep 2022 14:11:54 -0400
Message-ID: <20220907181200.54726-15-pavle.kotarac@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220907181200.54726-1-pavle.kotarac@amd.com>
References: <20220907181200.54726-1-pavle.kotarac@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT065:EE_|LV2PR12MB5967:EE_
X-MS-Office365-Filtering-Correlation-Id: 67b6ff56-4724-4320-61d3-08da90fc8a44
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Qhe51Y3D2xwHeDKDbaojCuWFCtciq6zvrc6cZKzrRtdcgFdAIMJbiaGMEl+fI3tT7bSmawICaaQx5nidc5Clx1BwNonid+x5WG6kDAdo6HuvqtzHJHmBnEqAsFwkwg9ujyJl/wIxzGxU9fNP99wgxOasfpqSVGrHpwDDRq6Kno9JQirAoZo1a10YJR8N4bqEZ//T1M5mkEXMODDJc4TA/NnlCkccnq//72E4pazAREJ8Gnjr9dH+vKCha+N+u3sNsuLH8R+zt6FKVwtq44SMHily4Kp0cwncFB5qlwAUsW2RN9xJ7WumnI2M18QIua1ifp1hqk+99ikbjA6QLp3Rt9wd1v1pCh0QeZL0689sC5P2GFyNiUG+CuNiqcbAw0ijmcY0I1ojriHsGwVU8T+eqeoI1P35TnEyVYApYZZxsOVeqcC8fAN7MJe1JCU1IxLZJH5ZX6E8dx+nZdLTksCKJf4RDFDmlm+u1zXJAulW8Q0wOhBi+DbycMluUGZ4yojSfWx7EQBlDdf2mZEZE7jEqsBl1tuZrNZik10C14eT9CVbYTuUeX4V2WFoTT+4thrIlSl2dS+FtfMjttaIEXLW470qjJAlVcM5802Tb5DC0BRXbpQuGManx9pAq4aVoXFJe77yoxXEK7EpR62ttWc5fa8dZUwGmaDZxvbwmghl6jiLf0dds9CPEMU5v1Y0q4phcy6hQLFk94s+VI44xqAZHbp+b7Eaz9GO24omOwqthc3kQb+2DG2r6v2xGBjpRptDfmDkG0gcDW/m7ghAF50qw8A7omvqOsbtpDn+nLjtWf0=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(376002)(346002)(136003)(396003)(39860400002)(36840700001)(40470700004)(46966006)(186003)(40460700003)(81166007)(356005)(54906003)(82740400003)(36860700001)(4326008)(70586007)(8676002)(70206006)(6916009)(82310400005)(316002)(40480700001)(44832011)(2906002)(5660300002)(83380400001)(41300700001)(1076003)(2616005)(8936002)(47076005)(426003)(7696005)(336012)(16526019)(478600001)(26005)(6666004)(86362001)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2022 18:12:35.1304 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 67b6ff56-4724-4320-61d3-08da90fc8a44
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT065.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5967
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
Cc: stylon.wang@amd.com, Aric Cyr <Aric.Cyr@amd.com>,
 Krunoslav Kovac <Krunoslav.Kovac@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com, Yao Wang1 <Yao.Wang1@amd.com>,
 agustin.gutierrez@amd.com, Pavle Kotarac <Pavle.Kotarac@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Yao Wang1 <Yao.Wang1@amd.com>

[Why]
For HDR mode, we get total 512 tf_point and after
switching to SDR mode we actually get 400 tf_point
and the rest of points(401~512) still use dirty
value from HDR mode. We should limit the rest of
the points to max value.

[How]
Limit the value when coordinates_x.x > 1, just like
what we do in translate_from_linear_space for other
re-gamma build paths.

Reviewed-by: Krunoslav Kovac <Krunoslav.Kovac@amd.com>
Reviewed-by: Krunoslav Kovac <Krunoslav.Kovac@amd.com>
Reviewed-by: Aric Cyr <Aric.Cyr@amd.com>
Acked-by: Pavle Kotarac <Pavle.Kotarac@amd.com>
Signed-off-by: Yao Wang1 <Yao.Wang1@amd.com>
---
 drivers/gpu/drm/amd/display/modules/color/color_gamma.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/modules/color/color_gamma.c b/drivers/gpu/drm/amd/display/modules/color/color_gamma.c
index 859ffd8725c5..04f7656906ca 100644
--- a/drivers/gpu/drm/amd/display/modules/color/color_gamma.c
+++ b/drivers/gpu/drm/amd/display/modules/color/color_gamma.c
@@ -1600,6 +1600,7 @@ static void interpolate_user_regamma(uint32_t hw_points_num,
 	struct fixed31_32 lut2;
 	struct fixed31_32 delta_lut;
 	struct fixed31_32 delta_index;
+	const struct fixed31_32 one = dc_fixpt_from_int(1);
 
 	i = 0;
 	/* fixed_pt library has problems handling too small values */
@@ -1628,6 +1629,9 @@ static void interpolate_user_regamma(uint32_t hw_points_num,
 			} else
 				hw_x = coordinates_x[i].x;
 
+			if (dc_fixpt_le(one, hw_x))
+				hw_x = one;
+
 			norm_x = dc_fixpt_mul(norm_factor, hw_x);
 			index = dc_fixpt_floor(norm_x);
 			if (index < 0 || index > 255)
-- 
2.34.1

