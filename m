Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D1C5C4332F
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Feb 2022 18:44:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 25D8B10E737;
	Fri,  4 Feb 2022 18:44:24 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2044.outbound.protection.outlook.com [40.107.220.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 42C4010E737
 for <amd-gfx@lists.freedesktop.org>; Fri,  4 Feb 2022 18:44:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AmcQ+X3t4IGhzE4i7ff4NtCWsnEFqO9HN79PEkr0vuEJ1LKd93fY8qHjv0v079k4ZSeziOVBconYZRabEVj7YwcXP6QViCLaRik1O1hwVwxWRZuPZ/TdXpKSWKNqVSSjR6cD80kooigxPeBp/ZTGy8Aao+n6Cqd+SdhVtbQ25HFIXKx4MnQUj289GKlMZqUVw8oZ6yFDy0tnziNO8WQ4g1IjvKv1A4y1QKFh27SRQ6u4HFbxZULI4OuFdnitblap4y1SwytQhZvJRToT1yadfgnb/JR9g26yRacQX1cXWMQ+ZI5M/rQZ63tatqn/KIUhrZQGYI1TWjFTbHXpl7mmpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EmGuRFFrXq1D81Qky/IkdkDWKHBJ4+Q1Xql9ZzZCwLE=;
 b=lg7pF9y3ukZjiRN7r7hXWMku1nDoBVOsVuOwlU51HRECS7NOP9Xwaliu23oBMHy6JnO1p54OsvJl5SimfsNeXpWGRJZ3+8okPjjL2GTs6mcUiZH0c9AH8sryf7XVPb1lgBNjf+7wqFzZjZBVI1xLyGJ89KMeQwLCCUPMR/vA0QcVLUi1S3ig2dj+lzk+roaSDtsD/BuaziooV5Oxt4mfb47QZKs/LGV/yZW71YFiNyAiZ4gOC3M57J1/pOlggvrI29iIRNtkZM29Z/d+XFOWM3wKIEP1KtidQtnytJS6D+Bk8OdyX40cp0bIgWJqzdgRHVrvo5AAoD6DfOBvaBlpiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 165.204.84.17)
 smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=temperror action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EmGuRFFrXq1D81Qky/IkdkDWKHBJ4+Q1Xql9ZzZCwLE=;
 b=oDlvdQ1i7wM+ZTAmpJE4RN4dySHFmkPUX3n9gO3hkAyWs3DCIKnVb35y2F7/ou70YbWUahlpmZvoj3nhS6YMnLN62g1Y0N/dk04vlf/FphYNNByranRjNP6hMbuSS5L/1mser/a/0IgXkCJII2JJryGMlkJiwxiHyYN1WuJ+oLw=
Received: from MWHPR22CA0006.namprd22.prod.outlook.com (2603:10b6:300:ef::16)
 by DM5PR12MB1324.namprd12.prod.outlook.com (2603:10b6:3:76::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.16; Fri, 4 Feb
 2022 18:44:21 +0000
Received: from CO1NAM11FT027.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:ef:cafe::f3) by MWHPR22CA0006.outlook.office365.com
 (2603:10b6:300:ef::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.17 via Frontend
 Transport; Fri, 4 Feb 2022 18:44:21 +0000
X-MS-Exchange-Authentication-Results: spf=temperror (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=temperror action=none header.from=amd.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of amd.com: DNS Timeout)
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT027.mail.protection.outlook.com (10.13.174.224) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4951.12 via Frontend Transport; Fri, 4 Feb 2022 18:44:20 +0000
Received: from jasdeep-System-Product-Name.hitronhub.home (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.18; Fri, 4 Feb 2022 12:44:18 -0600
From: Jasdeep Dhillon <jdhillon@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 05/13] drm/amd/display: remove static from optc31_set_drr
Date: Fri, 4 Feb 2022 13:43:47 -0500
Message-ID: <20220204184355.91198-6-jdhillon@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220204184355.91198-1-jdhillon@amd.com>
References: <20220204184355.91198-1-jdhillon@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 58e74112-8271-4842-2a2c-08d9e80e5b1f
X-MS-TrafficTypeDiagnostic: DM5PR12MB1324:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB13243798FA02D792E0C17757FB299@DM5PR12MB1324.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:341;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4esQ4QV59VX40MLCXD8hYYhA8+Qmp5j5jqOuhz6MTMrKD4uJsNHFWSF9iqT8/OUVYy4JWiL0HARf551oyzZxyw5HkPvBtpUT9f6FcQKN+2LGdJRCSxEb6StWdP8hcs8Z2qFgZg9z0y6jFX2zHeEbNAdvxM28qGMGVT8qxw9U6GK1Ti8aNYfJgmGGj9OcvMfKNnGT5hjurRF6kzm+qT4Ar5HXzl1DRejBK+v0THmEhFxYKD6YmnqPDhAeCDJfv933uynq7CxJor9YNfI9SbxUa3DcTKp6NXiDTpRNmyVXKNSYKEuM95c04/esM2HQrSavhyhUUnvKlkaosG27brEAxAX4cKHhI5Ux8GUU1OB5piC+vvyD7JLAuVqkK6Nqaq88ndnCm+2xs/Y8rzD1VP8Q4EJYdA1pcNTRISIEyKvePTgipYIGEtGzlbtsEg7MEIwIu2uTd4DRjkMUitpkYG3JzfS0sM++mhnsVvUgIQJ9QyOBEcI2lKQyXz1p8U1M3Eur3u+6ZbaXM7p1nf1u38VyVnlvO7Alect54U4Y/xohpmBdntS8p7DVKh6LUIRvc7Xk0ezn8bqKwCTov0BvpfZjBhxdYruLj85xDZ38WQbwpexk1s4opG310fzGdTFBuqIOn7F1ZgKgDr5q8Xhk5zshL2nHONCUubeBTDAFcZPh3cG6Cwumt46RTzWT9Y6+TswnRDXVkOnhfc3eBLPvV+5XtQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(2616005)(336012)(26005)(316002)(6916009)(83380400001)(4326008)(186003)(356005)(6666004)(81166007)(5660300002)(36860700001)(426003)(16526019)(2906002)(8936002)(47076005)(1076003)(82310400004)(70586007)(70206006)(8676002)(54906003)(36756003)(63350400001)(63370400001)(40460700003)(508600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2022 18:44:20.3716 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 58e74112-8271-4842-2a2c-08d9e80e5b1f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT027.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1324
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
Cc: stylon.wang@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Jasdeep
 Dhillon <jdhillon@amd.com>, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 Eric Bernstein <eric.bernstein@amd.com>, wayne.lin@amd.com,
 Nevenko Stupar <Nevenko.Stupar@amd.com>, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Eric Bernstein <eric.bernstein@amd.com>

remove static from optc31_set_drr

Reviewed-by: Nevenko Stupar <Nevenko.Stupar@amd.com>
Acked-by: Jasdeep Dhillon <jdhillon@amd.com>
Signed-off-by: Eric Bernstein <eric.bernstein@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn31/dcn31_optc.c | 2 +-
 drivers/gpu/drm/amd/display/dc/dcn31/dcn31_optc.h | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_optc.c b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_optc.c
index e8562fa11366..8afe2130d7c5 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_optc.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_optc.c
@@ -161,7 +161,7 @@ static bool optc31_immediate_disable_crtc(struct timing_generator *optc)
 	return true;
 }
 
-static void optc31_set_drr(
+void optc31_set_drr(
 	struct timing_generator *optc,
 	const struct drr_params *params)
 {
diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_optc.h b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_optc.h
index d8ef2f0d0c95..a37b16040c1d 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_optc.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_optc.h
@@ -256,4 +256,6 @@
 
 void dcn31_timing_generator_init(struct optc *optc1);
 
+void optc31_set_drr(struct timing_generator *optc, const struct drr_params *params);
+
 #endif /* __DC_OPTC_DCN31_H__ */
-- 
2.25.1

