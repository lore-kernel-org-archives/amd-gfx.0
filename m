Return-Path: <SRS0=uIzi=PX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EBB8C433FE
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Nov 2021 20:53:07 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6FA6F61220
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Nov 2021 20:53:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 6FA6F61220
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0535E73870;
	Thu,  4 Nov 2021 20:53:07 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2066.outbound.protection.outlook.com [40.107.243.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C0C7473871
 for <amd-gfx@lists.freedesktop.org>; Thu,  4 Nov 2021 20:53:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UpPEwEDk4aVYhzkO7TE+rQ/agHaigmmEQnKK8rCthq0OWyy6WiFIp5NAbwuw+PSBPeGj8ujwLlU6Y2IjXPZk01N2H6LiQqaVOq3chVRcJXO/PT7mHA/3I6AcZsK+GYHhZNxpxWZYUfJFS65pMMzrUC5u/NI/q2xYWlq1x6WtgKMFFtBa9mWdIoLjYU0fooUMt7w3x5ToiyqgfLFI+ZTQdvMWOszdtUVmMxKrwQPApX7Ts7du9GHw+s38h+XsS5RL4RX+2oQ4EJ4Rek+cG1jWm6aIFavRnD5oBTHUXuGkkJs3oo7ToINVpRK8P94DGBilPXjRBKzpLFBGbetWEjleNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VaUFOs424ZW9QULCj5RiNnQinVVWqJZe3ed1pAYWrCM=;
 b=TrigNc0WJwAdgRruIjLcOPiccaY/KJJ2d0X0MEgddsl229f432ojA6euIVI8x9kwMLipXi1y6KIE8nS9HTGxwlX6Kt5ogi7uJZyO/VZQFB+5wljGP+OV+9D0GDXvfLvr05aT8dmk9KF2vyno2Asu3RLcSd/qPbN6MIPbuliV1rIBaHpsAWzGkY3CPA7AJCu6LuthLKCrDsiteoj3qEjRferCi7IUAFdd30v0H9xtc59VyKZ2g+C9Ka8038da8StHtdbllWFe14j+AeIsqI/xUP9u5Ka3+MXhtmee+UYM2V5Ckr0wbBkGkineZRnUqHYC5pKiNgzzAE8lpd+3h01mbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VaUFOs424ZW9QULCj5RiNnQinVVWqJZe3ed1pAYWrCM=;
 b=yDoAeUkXKtbVygosoQe2iWW3jpA3v9OcEDsWXFCYWumqAhVLBdKAOQFtI294urq2a169gEPnUFJVgiySriXtaXWgvrsNJ64U/j6mbjcQrbyu27Jw96pAWUTD4UwKc98LA3Bgh1LAwt82Eu9GFPi8xVKypCLaPiEBc20CCGJLVfI=
Received: from DM6PR12CA0036.namprd12.prod.outlook.com (2603:10b6:5:1c0::49)
 by BL0PR12MB4705.namprd12.prod.outlook.com (2603:10b6:208:88::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.11; Thu, 4 Nov
 2021 20:53:02 +0000
Received: from DM6NAM11FT049.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1c0:cafe::a5) by DM6PR12CA0036.outlook.office365.com
 (2603:10b6:5:1c0::49) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.11 via Frontend
 Transport; Thu, 4 Nov 2021 20:53:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT049.mail.protection.outlook.com (10.13.172.188) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4669.10 via Frontend Transport; Thu, 4 Nov 2021 20:52:59 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Thu, 4 Nov
 2021 15:52:51 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Thu, 4 Nov
 2021 13:52:51 -0700
Received: from Optimus.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2308.15 via Frontend
 Transport; Thu, 4 Nov 2021 15:52:50 -0500
From: Anson Jacob <Anson.Jacob@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 18/22] drm/amd/display: 3.2.161
Date: Thu, 4 Nov 2021 16:52:11 -0400
Message-ID: <20211104205215.1125899-19-Anson.Jacob@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211104205215.1125899-1-Anson.Jacob@amd.com>
References: <20211104205215.1125899-1-Anson.Jacob@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a0217e10-79cc-4c26-5a6d-08d99fd5163e
X-MS-TrafficTypeDiagnostic: BL0PR12MB4705:
X-Microsoft-Antispam-PRVS: <BL0PR12MB4705DEE1594140109262A4CCEB8D9@BL0PR12MB4705.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1388;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AV4Z90XhidOpKrp5RzdxtwSB0Zq74N5nlEkqa6BCgwydcFItYd5CGcU5XG47R9PonswIqwkeUJASix3WLBw/QIb9J7uZ9IEMp6yT4jfxbZCXs+3CI+mFBQsEifRQQlLoaoPyRZvGOFJsQ13HNS8FvTwOO2n5weNFTdb5d9X+u2HbmA8eBeyPSKayL9Gz/u68iSeSvH/GTJPRRWcc30EQkTgoWtfsatzayC6axuLCP486Ps5DZ6efg9IEpVe/7aVeQxTwKWjVSpaVZA+yfV6aPSnnOSkKVNvq0IoyddUZ+aGW9DiDnlLmm+nrLXseE1hae9+537mPs94jB7YYRM6g4RafxFYcRWL5NsrF7vKZqEJCBkM0WUG9gAujcppTpZHYXmRFejztAbxaoKirfLf3rvDFVL8kh/30hfVjM/HhNBmybBZEMHDTV0mylYt/Ovw4USzf3zdOuOMFkJu85WCQrr/29oz6jwLalmS8SKq7EOsLJsZCQDJC+UHxHEx/1MxVI2pu4hNh485NpqLOInF8akOjxModuBPyXpKA5/NCbb/kno9R7xIB0BrIZ5eo4rmT2CPVMZbySgn5pYFmMr4+FuR56vL7w52DsVXR+IUexDF3sJKYgenP5DD6hXZAoJ/xgrgLqBlFSIq8K4wfXJmSzVt/aKXjHDeYku0wgdoNmvcR2ERpNr41fjgVQfIgzNXLotZblKZIoeiUqpjHGABm6EycER8pknC9AYjdMpqhdkM=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(7696005)(81166007)(356005)(426003)(336012)(5660300002)(47076005)(86362001)(508600001)(70206006)(2616005)(70586007)(186003)(2906002)(26005)(4326008)(6916009)(36860700001)(6666004)(36756003)(4744005)(8936002)(8676002)(82310400003)(1076003)(316002)(83380400001)(54906003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2021 20:52:59.8871 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a0217e10-79cc-4c26-5a6d-08d99fd5163e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT049.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4705
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
Cc: stylon.wang@amd.com, Aric Cyr <aric.cyr@amd.com>, solomon.chiu@amd.com,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, Anson.Jacob@amd.com,
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com, mikita.lipski@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Aric Cyr <aric.cyr@amd.com>

This version brings along following fixes:
- Improvements to INBOX0 HW Lock
- Add support for sending TPS3 pattern
- Fix Coverity Issues
- Fixes for DMUB
- Fix RGB MPO underflow with multiple displays
- WS fixes and code restructure

Acked-by: Anson Jacob <Anson.Jacob@amd.com>
Signed-off-by: Aric Cyr <aric.cyr@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 3aac3f4a2852..2bebc52c8ed9 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -47,7 +47,7 @@ struct aux_payload;
 struct set_config_cmd_payload;
 struct dmub_notification;
 
-#define DC_VER "3.2.160"
+#define DC_VER "3.2.161"
 
 #define MAX_SURFACES 3
 #define MAX_PLANES 6
-- 
2.25.1

