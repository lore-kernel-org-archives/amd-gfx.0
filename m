Return-Path: <SRS0=EPaF=PD=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B550C433FE
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Oct 2021 18:44:23 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3882E60C4A
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Oct 2021 18:44:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 3882E60C4A
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3C7096EDF0;
	Fri, 15 Oct 2021 18:44:20 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2070.outbound.protection.outlook.com [40.107.243.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E89386EDE9
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Oct 2021 18:44:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YXWv5u8Im6ThmFPU9V0AkNHxCiO9Hdv2kbV3gGCID7KSKB/52AK/st7Nrcjw2hfRHboSi9oIbJHQGe26h5aHOemGviMidUhCiqR2MOkLuqeXB0Iv5ycWraiVFnfYKlmpbq36LyPkbmNSb5HNalpjHXygKxEw8YfbrpRay/hCpmL9k4Cqn/t8tI+NRIDNxkzo+ypB/LUXsyMV7Xf0qKT2Atdqi0jVhWbT11fIpeYTC7if7hI6rIy1iI45SLG9E6jXCXs51zyJjKOVgRLDi6lKGhg+MWfeMiLxRtc2WpR7ezCyEIKBjfeCCiMG6xYs/SquZ+3hGazo4K7pvI5he7JipQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RLEisll7Zv4h3tGFx+ToGTCHrAkVzrwc9b8NquPcIw4=;
 b=l2rLv+XnCe1ygYMFsbBDxrr+AAptdmEpsze0qnzzfdLU6S+t0+z4RfRKq8jQaQl+16g2/hXykrqu/gGXEnjibi8Qs+wVliOjTL4raI1lnqybnPQzeOU0BgSvpJYSdiM4654Hom8fVlRlQXZFsUnimtIj/pCY4jNAn/qsSHhzdFrHd/PPV+tyXBzq4FN4WToW/qcATmSm8jEmSoTa5m4yJd1W4RlXXjHTqCbi5WOrI4qlrPig3Wl0hiLE30ndLnlKfmGe5tGhb/zy7lr5WvjvVYi35iOQXRSMvmsJGch6Pxswi4CBNxiLOIYGeFDRM8qf+T6FIKzp+vQkJOkgtpOwDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RLEisll7Zv4h3tGFx+ToGTCHrAkVzrwc9b8NquPcIw4=;
 b=ug23UWTpBZyT5MO6nt5at/BYkdMDHo8Xt8Ukfch4VyCdoYsk5qlfeHAi8noK1Zy7BuD5k2GAwEauPVMV5Lljhsq3BOXH0i3N15Vf+cPWYdBTSdsB+P0XJjfimcSIjeffjP95WUASHV01S3hUAIIxBzOOaVArgYLpgZ4Oa/n+2eI=
Received: from DM6PR02CA0081.namprd02.prod.outlook.com (2603:10b6:5:1f4::22)
 by BN7PR12MB2705.namprd12.prod.outlook.com (2603:10b6:408:25::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.17; Fri, 15 Oct
 2021 18:44:13 +0000
Received: from DM6NAM11FT009.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1f4:cafe::ea) by DM6PR02CA0081.outlook.office365.com
 (2603:10b6:5:1f4::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.16 via Frontend
 Transport; Fri, 15 Oct 2021 18:44:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT009.mail.protection.outlook.com (10.13.173.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4608.15 via Frontend Transport; Fri, 15 Oct 2021 18:44:12 +0000
Received: from ubuntu.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Fri, 15 Oct
 2021 13:44:10 -0500
From: Agustin Gutierrez <agustin.gutierrez@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Bhawanpreet.Lakha@amd.com>, <Rodrigo.Siqueira@amd.com>,
 <Aurabindo.Pillai@amd.com>, <qingqing.zhuo@amd.com>, <mikita.lipski@amd.com>, 
 <roman.li@amd.com>, <Anson.Jacob@amd.com>, <wayne.lin@amd.com>,
 <stylon.wang@amd.com>, <solomon.chiu@amd.com>, <pavle.kotarac@amd.com>,
 <agustin.gutierrez@amd.com>, Aric Cyr <aric.cyr@amd.com>
Subject: [PATCH 23/27] drm/amd/display: 3.2.157
Date: Fri, 15 Oct 2021 14:43:28 -0400
Message-ID: <20211015184332.221091-24-agustin.gutierrez@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211015184332.221091-1-agustin.gutierrez@amd.com>
References: <20211015184332.221091-1-agustin.gutierrez@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b2c28e7e-9621-41e3-5438-08d9900bc848
X-MS-TrafficTypeDiagnostic: BN7PR12MB2705:
X-Microsoft-Antispam-PRVS: <BN7PR12MB2705CA0B2EA1799E26828F9DF5B99@BN7PR12MB2705.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2089;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bR8df/iNkONmLyGgBhhRjaXFrqWGojCbTaCIUYXrl8J9IkdbLYmqH2z59k07Nr3pT9cCc/P6ZTrcOIv6V++E2lSPlNKfoH578oztTEJzZHveDa9j7PHkVrXiulMyLCCxJUg3bwi3s4EZUXIt/ZufXcUugNT9sprFqaa47cS7Cv0j02JiTp8JY2HlLl687fWeTQWKYSm0xZiM5u2Von7h+i2sjzEvgfQKV6BRljvj1KgVTIt9SSRL1obdjU99OT5/jApWJiFGqyRy5Qan9/l7kdFcuOnmepj1+nAlmCLp2RCD8lkslaCcR5whHez4f6DZseCD3byafDXM390U66oxkpXgt02bJpVlOkDIcu8rTMTWwZ8rSVKG1083MFmYDxwLWII84cf9QjRiZU5e3M+keAmpygh0O8vSijzJD0pSnTCY0tDO3Ge3X0wJBT2Iy3LN6L5i1RjqA7ncv42s5rd3MP1Da1BvNSBcMPzAzDKZYTrLtvop4MgJk5M0AIog7vT0ex9Gjsos/v5NsCUVOqpUmBE/2M0uZtkKg5zYWzcpb1j0ziv76LSTu8emj1Id/sKF56xhtok+xLS7s5rDGT6s34s4RovYqtgnIuP4KzXRdXh0hEge28h7z33p6nmy6zhGOpUKB+0vjbfKvkmJ0dUMtGcfDB08EzUihqSvj2WWEdO35+kAozAN6LgFOzJxugvRhmhlnqNi/7AqsT+k1NaagtszkNZGFazLIIuhLTrD/j4=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(356005)(426003)(44832011)(6666004)(2906002)(36756003)(2616005)(4326008)(83380400001)(336012)(8936002)(81166007)(5660300002)(47076005)(6916009)(86362001)(82310400003)(4744005)(316002)(8676002)(36860700001)(70586007)(54906003)(26005)(508600001)(70206006)(1076003)(16526019)(186003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2021 18:44:12.8050 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b2c28e7e-9621-41e3-5438-08d9900bc848
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT009.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR12MB2705
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

From: Aric Cyr <aric.cyr@amd.com>

This DC patchset brings improvements in multiple areas. In summary, we
highlight:

* Fix some issues such as DP2 problem, prefetch bandwidth calculation
for DCN3.1 and others.
* Increased Z9 latency and removed z10 save after dsc disable.
* Revert a couple of bad changes.
* Added missing PSR state patch.

Acked-by: Agustin Gutierrez Sanchez <agustin.gutierrez@amd.com>
Signed-off-by: Aric Cyr <aric.cyr@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 254b760ae91f..fc3f0fd1f068 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -47,7 +47,7 @@ struct aux_payload;
 struct set_config_cmd_payload;
 struct dmub_notification;
 
-#define DC_VER "3.2.156"
+#define DC_VER "3.2.157"
 
 #define MAX_SURFACES 3
 #define MAX_PLANES 6
-- 
2.25.1

