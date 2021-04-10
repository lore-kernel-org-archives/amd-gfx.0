Return-Path: <SRS0=wHtS=JH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29823C43461
	for <amd-gfx@archiver.kernel.org>; Sat, 10 Apr 2021 02:04:53 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DEDC9610CB
	for <amd-gfx@archiver.kernel.org>; Sat, 10 Apr 2021 02:04:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DEDC9610CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 412C26E4E6;
	Sat, 10 Apr 2021 02:04:51 +0000 (UTC)
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-eopbgr760077.outbound.protection.outlook.com [40.107.76.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1608B6E4E6
 for <amd-gfx@lists.freedesktop.org>; Sat, 10 Apr 2021 02:04:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iKKnt4DZ4tyzsbtQLscR1UIHccbblPVEVnq+mTFVmx/144kQ6iU5rhsH0kQ2YoKYzpc27fnmJOkfRVdFRjzlv2ZL60kJwaTJH1+kbUgw7riguPm+J+aHfAAEPY01i/I348Btpp6O7PP1ZQU6cm8aUHRT2y69BzovBrIY0esG/5HR3L1bXsTdoqgHqA6p441LB8AGlabuqDrme+51cDhnE6zEjioM5wusQSt+ONNKQGWvC48JeitVUCoUPtep5c4KCNqRYpURZfN48TUwSJADGEGawIgO2vS7fPQmbWWsPGs1auds+poQk0NskvZPV4x2IjIIsL5pigNqHyMkbrpYsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tf6bHoX6gg8wfqCaXqJWg1edZh9Rh3BWr3+7g2NnzLk=;
 b=Yyk72xja/R9lzvCpL9FkPKApCdGpXxaXDW2LT1a55ELE84vqfIobGXQTz7QXB/m8gp5F2Ry5o1uMcnRJ2PBNNj8Sn5KrornSQSAdpPU0pLPXcTCS+CPjJ6inbTPC0vHEqtsLAaJwrHp0WNkNoMJA/uexf/h02GnpFF1IYY3wy7K88jv2+z2ym4Cm1UrV/bKYmuaO8D63A4InkAf66OinN+U8MA2TPmqYILaKAFo3ujprIItEGRnkGuZ1GuBL4GztsWzxI1SNmec/ehuqBdqyFD59JT5Rs0rRsfRmSqEjiAUHU0p7GE28uvuo+0p1snPdV7tGUWoKzumlHaJ459sJIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tf6bHoX6gg8wfqCaXqJWg1edZh9Rh3BWr3+7g2NnzLk=;
 b=TmdWSRiNiRmY7/1Mf6lvmuH55cngpqtzgNg7CKdcmZ/pbAiiHZBEZz2xXYFIrYtzBclDC3TSwXrfYekuFrCaJr5NUH4YyWXNdxm/m4FjTnuBgOfE2rf+nzj+l+HPQtX7xVYYNyv+NVoPyOWvbSP+Kmfi+o2knVLdXB5XKJFwu80=
Received: from DM5PR18CA0072.namprd18.prod.outlook.com (2603:10b6:3:22::34) by
 MN2PR12MB4565.namprd12.prod.outlook.com (2603:10b6:208:26b::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4020.18; Sat, 10 Apr 2021 02:04:46 +0000
Received: from DM6NAM11FT051.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:22:cafe::15) by DM5PR18CA0072.outlook.office365.com
 (2603:10b6:3:22::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.17 via Frontend
 Transport; Sat, 10 Apr 2021 02:04:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT051.mail.protection.outlook.com (10.13.172.243) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4020.17 via Frontend Transport; Sat, 10 Apr 2021 02:04:46 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Fri, 9 Apr 2021
 21:04:45 -0500
Received: from bindu-HP-EliteDesk-705-G4-MT.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2106.2
 via Frontend Transport; Fri, 9 Apr 2021 21:04:45 -0500
From: Bindu Ramamurthy <bindu.r@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 04/16] drm/amd/display: Remove static property from
 decide_edp_link_settings
Date: Fri, 9 Apr 2021 22:03:49 -0400
Message-ID: <20210410020401.1100228-5-bindu.r@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210410020401.1100228-1-bindu.r@amd.com>
References: <20210410020401.1100228-1-bindu.r@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 27f35948-1ce8-4ac2-1057-08d8fbc50404
X-MS-TrafficTypeDiagnostic: MN2PR12MB4565:
X-Microsoft-Antispam-PRVS: <MN2PR12MB45655750CEABEC00B01195B5F5729@MN2PR12MB4565.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1079;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: V4Y95dAAHPS9+Ktp1PbfiY6RPQ07n7MRL2s7uM38xGRb9FXkNZkOGBmZqOZ3jDifEXHawDLwzTFAKQAEYTYG4Ept0Floh5ROY6xUgMlGf5RUdJqPrZqL3xvZnVOugAp4L9UAxmgFeud6r1SzRGcgl7GrrgE/xedpNRVGTL5OHo09eKJFGveulR13c2QHLd5AIUanE2g0YD+G9JmPVp8ubd0qRW6qOnhx+9KScWd0BSBgPFBosz6KPTLWhQxmGgBSGOEz7Cce/Gty3thcCyCP+jzGVI++QmhmL/xv6aUGQJmGK4xnkgx4CYNB4rUsug4Scd9niaP4TQJ0Unm1PyXDQJzUby6GTQx0sDibgMxjzxnOljytMXPZbVv4VDGZ2w9sPlptDJ0i+8zDCOhqNJOpBYCDct8ffhowXYTFj+LJ9zPiolF4u16zKeKsZefaWQusZLXfq07WrsL3M4qdlt+0MkhzzAQVG/pEzGdDZ0D5Gav4b19AwARSGQqufVyIQHAmt2vC30vm86K2TBLe0fCsHbUworZyXqUOuxxlgOXLWRPDpsozV8QbGdl4jbIlDrz+Qlu7kNOfd9EvoYoS7SWlBBPeR+n2XZYFm+qA+7+ng5nzDCL9gD3H+kKOKHy20HNcNDuaVTwfAV8NW9UUiTC/fkOumn8HgfzjUAYpj/xeY2GtLdpqBJExuWi/Z7ELPPKL
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(39860400002)(346002)(376002)(136003)(396003)(46966006)(36840700001)(2616005)(36860700001)(86362001)(70206006)(82740400003)(186003)(1076003)(5660300002)(26005)(70586007)(2906002)(83380400001)(478600001)(316002)(36756003)(6916009)(8936002)(47076005)(81166007)(336012)(82310400003)(426003)(54906003)(4326008)(8676002)(7696005)(356005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2021 02:04:46.6370 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 27f35948-1ce8-4ac2-1057-08d8fbc50404
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT051.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4565
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
 Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com, Anson.Jacob@amd.com,
 Aurabindo.Pillai@amd.com, Michael Strauss <michael.strauss@amd.com>,
 Bindu Ramamurthy <bindur12@amd.com>, Bhawanpreet.Lakha@amd.com,
 bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Michael Strauss <michael.strauss@amd.com>

[Why & How]
Static cleanup for eDP ILR Support.

Signed-off-by: Michael Strauss <michael.strauss@amd.com>
Acked-by: Bindu Ramamurthy <bindur12@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c | 2 +-
 drivers/gpu/drm/amd/display/dc/inc/dc_link_dp.h  | 4 ++++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
index 2e4740648e3c..9d6a8e728317 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
@@ -2490,7 +2490,7 @@ static bool decide_dp_link_settings(struct dc_link *link, struct dc_link_setting
 	return false;
 }
 
-static bool decide_edp_link_settings(struct dc_link *link, struct dc_link_settings *link_setting, uint32_t req_bw)
+bool decide_edp_link_settings(struct dc_link *link, struct dc_link_settings *link_setting, uint32_t req_bw)
 {
 	struct dc_link_settings initial_link_setting;
 	struct dc_link_settings current_link_setting;
diff --git a/drivers/gpu/drm/amd/display/dc/inc/dc_link_dp.h b/drivers/gpu/drm/amd/display/dc/inc/dc_link_dp.h
index 9a5ef86b2aa0..3ae05c96d557 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/dc_link_dp.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/dc_link_dp.h
@@ -52,6 +52,10 @@ bool dp_validate_mode_timing(
 	struct dc_link *link,
 	const struct dc_crtc_timing *timing);
 
+bool decide_edp_link_settings(struct dc_link *link,
+		struct dc_link_settings *link_setting,
+		uint32_t req_bw);
+
 void decide_link_settings(
 	struct dc_stream_state *stream,
 	struct dc_link_settings *link_setting);
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
