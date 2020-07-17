Return-Path: <SRS0=DbcS=A4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C842C433EB
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Jul 2020 17:38:33 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E942B20737
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Jul 2020 17:38:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="hk0XfFQS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E942B20737
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B40266EE1F;
	Fri, 17 Jul 2020 17:38:30 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2063.outbound.protection.outlook.com [40.107.223.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 598976EE1A
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Jul 2020 17:38:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JmpbHgNvKUk4BXM/yKmYTFf3hJJ4lGg+iffC8rmY/JMIz6S5QpaQpX2R0UnqIBlx/VqX6KBWeHUbomAJnshnS04QUQlG6Hby1TUy9u1jsb07dYKHp3t+lBiy2YkA7jI188/RoP4s72VMTNDdviNcdJFb5YOYRyaXl2WOL+UtbgZK95kC+rODoV1i+D7yuHbfE/39a2ym5KTJrrnAbVsWoVBtsnOPRdy/A8QyBnX8MNXBgsAa2ESF/bOjnvfb2/swR9mgqL7uE5lXKwP0IfQKic5RBrC6AwybHUfYMO/myWKiyQJR5moYhjvNdWfcIAmIYM5fb4dL49ilf+Bs2tujiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sE200ANjFRICcujqNkCWMgFvLiqM2z91qu0xvO9LHOQ=;
 b=oKahsArAxIxLGljszwt6J3ezJFwQ6bpNLX4zJEzZjTKr6rlH3EWBBGOCdHHHYLCkgBrz4is/MQEpgqH7T9c/V3j63Bk16hAdCWxQyawPN1J95rzKTe2SrndH0nOkbD4KfTb5piABMcc3cIN+bFLBOezDmB6Fa8VqoxPyFsLyINezywd60ENgib3uIpSu1cX9jut8HMp5k/+94DUoN1pOSpW2eu3yehfbzpMSC5VQFPfoYa+uSJE5ECgbfSekjkIdOPfb+dWR18HAxeODJqy9Owy5jodWp/kVf1s0FrxMpg/4zDSKzd2K8cQZpcjzs1YXkCUnBX3ZJJGxJcoMODaiTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sE200ANjFRICcujqNkCWMgFvLiqM2z91qu0xvO9LHOQ=;
 b=hk0XfFQSzt3GhODHKxOYInxeA/GePlY7BJzZiSdg0Av6h4XGK5uphjO6wAhuiw98SqWDpU/mtmAHt/96km3fu9PzTGDlcSws4EjmACg94+NslNYuOlxIxOJWSE3NbmEJUdiK+lIMauER6MuHx1Bhb7YEwX7X+8STBYP+lXLN+HY=
Received: from BN6PR21CA0019.namprd21.prod.outlook.com (2603:10b6:404:8e::29)
 by DM6PR12MB2828.namprd12.prod.outlook.com (2603:10b6:5:77::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.28; Fri, 17 Jul
 2020 17:38:27 +0000
Received: from BN8NAM11FT049.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:8e:cafe::51) by BN6PR21CA0019.outlook.office365.com
 (2603:10b6:404:8e::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.7 via Frontend
 Transport; Fri, 17 Jul 2020 17:38:27 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 BN8NAM11FT049.mail.protection.outlook.com (10.13.177.157) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3195.18 via Frontend Transport; Fri, 17 Jul 2020 17:38:27 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Fri, 17 Jul
 2020 12:38:26 -0500
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Fri, 17 Jul
 2020 12:38:26 -0500
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Fri, 17 Jul 2020 12:38:26 -0500
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 11/12] drm/amd/display: interface to obtain minimum plane size
 caps
Date: Fri, 17 Jul 2020 13:38:12 -0400
Message-ID: <20200717173813.11674-12-qingqing.zhuo@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200717173813.11674-1-qingqing.zhuo@amd.com>
References: <20200717173813.11674-1-qingqing.zhuo@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(376002)(396003)(136003)(39860400002)(46966005)(4326008)(2616005)(70586007)(70206006)(81166007)(82740400003)(44832011)(47076004)(83380400001)(82310400002)(356005)(426003)(336012)(36756003)(86362001)(186003)(1076003)(2906002)(26005)(8676002)(316002)(6916009)(8936002)(5660300002)(478600001)(6666004)(54906003);
 DIR:OUT; SFP:1101; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1bd8bb71-07aa-40fd-37fc-08d82a783690
X-MS-TrafficTypeDiagnostic: DM6PR12MB2828:
X-Microsoft-Antispam-PRVS: <DM6PR12MB2828B4BA8712FAF4ED73C786FB7C0@DM6PR12MB2828.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1850;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: URV4OIAh3EMPn5u9y3VeU+hyTpv1EtorudAGPF2KKfv0VWDwdI1QSL4HrsSoWLiKtaxmzPN5zcuBwzUBuFCzn8oaEbW9scCr55CuSS502WEG90VQxmrlAcE3ypCRc6KuDnzAZMGyEb69CQl0hbh4LKq7H2Gmwqxkdiqd8Tze8NVRV5X96sGeP/Vx4iqEI5W8YMw1eQuGkN7r651ZkPe7rloumx3L/Gn3TAWzqs8t0k9Q0XyTeP6DFVqvH4vAQIg30aNJgtfbCWQHLo7GkVzE+LSLqpKJ2giJLxeV9ZQyyj2+dC4MK8IS8nozKeItqWYZGAZdrIc0b2n81wjnCyarxNd9TOWBLnGx59y+wmEMFDV63spf+ChQX6ghlTpfy4bEUPRsNi3MtNgBhamtkKARAg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2020 17:38:27.2348 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bd8bb71-07aa-40fd-37fc-08d82a783690
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT049.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2828
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
Cc: Eryk.Brol@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 Igor Kravchenko <Igor.Kravchenko@amd.com>, Bhawanpreet.Lakha@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Igor Kravchenko <Igor.Kravchenko@amd.com>

[Why]
Implement an interface to obtain plane size caps

[How]
Add min_width, min_height fields to dc_plane_cap structure.
Set values to 16x16 for discrete ASICs, and 64x64 for others.

Signed-off-by: Igor Kravchenko <Igor.Kravchenko@amd.com>
Reviewed-by: Aric Cyr <Aric.Cyr@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h                     | 3 +++
 drivers/gpu/drm/amd/display/dc/dce110/dce110_resource.c | 8 ++++++--
 drivers/gpu/drm/amd/display/dc/dce112/dce112_resource.c | 4 +++-
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c   | 4 +++-
 drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c   | 4 +++-
 5 files changed, 18 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index e5a1a9eb6217..a5faedf66470 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -96,6 +96,9 @@ struct dc_plane_cap {
 		uint32_t nv12;
 		uint32_t fp16;
 	} max_downscale_factor;
+	// minimal width/height
+	uint32_t min_width;
+	uint32_t min_height;
 };
 
 // Color management caps (DPP and MPC)
diff --git a/drivers/gpu/drm/amd/display/dc/dce110/dce110_resource.c b/drivers/gpu/drm/amd/display/dc/dce110/dce110_resource.c
index a043ddae5149..70c6f917139e 100644
--- a/drivers/gpu/drm/amd/display/dc/dce110/dce110_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dce110/dce110_resource.c
@@ -423,7 +423,9 @@ static const struct dc_plane_cap plane_cap = {
 				.argb8888 = 250,
 				.nv12 = 1,
 				.fp16 = 1
-		}
+		},
+		64,
+		64
 };
 
 static const struct dc_plane_cap underlay_plane_cap = {
@@ -447,7 +449,9 @@ static const struct dc_plane_cap underlay_plane_cap = {
 				.argb8888 = 1,
 				.nv12 = 250,
 				.fp16 = 1
-		}
+		},
+		64,
+		64
 };
 
 #define CTX  ctx
diff --git a/drivers/gpu/drm/amd/display/dc/dce112/dce112_resource.c b/drivers/gpu/drm/amd/display/dc/dce112/dce112_resource.c
index 51b3fe502670..5d83e8174005 100644
--- a/drivers/gpu/drm/amd/display/dc/dce112/dce112_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dce112/dce112_resource.c
@@ -424,7 +424,9 @@ static const struct dc_plane_cap plane_cap = {
 			.argb8888 = 250,
 			.nv12 = 1,
 			.fp16 = 1
-	}
+	},
+	64,
+	64
 };
 
 #define CTX  ctx
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
index c8c6225c7e9e..968a89bbcf24 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
@@ -1043,7 +1043,9 @@ static const struct dc_plane_cap plane_cap = {
 			.argb8888 = 250,
 			.nv12 = 250,
 			.fp16 = 1
-	}
+	},
+	16,
+	16
 };
 static const struct resource_caps res_cap_nv14 = {
 		.num_timing_generator = 5,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
index 7d82648bec90..88d41a385add 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
@@ -857,7 +857,9 @@ static const struct dc_plane_cap plane_cap = {
 			.argb8888 = 250,
 			.nv12 = 250,
 			.fp16 = 250
-	}
+	},
+	64,
+	64
 };
 
 static const struct dc_debug_options debug_defaults_drv = {
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
