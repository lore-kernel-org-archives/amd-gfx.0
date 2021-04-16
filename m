Return-Path: <SRS0=1d99=JN=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A559C433ED
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Apr 2021 14:34:53 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 20226610FC
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Apr 2021 14:34:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20226610FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CE0226EB9F;
	Fri, 16 Apr 2021 14:34:52 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2044.outbound.protection.outlook.com [40.107.243.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6BBB96EB98
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Apr 2021 14:34:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NyDr+ASTN8q95hX3bwwLCa78EEzsRSBZ34uYLhMd2HFmGxHjeYCXGuREsE1tT7rXKZi6X1pXh3/IuFI56xonYfwjG2BnC5f5YhilEi2v01BUh1UGmgZ3/v8kHzBR1Z1x3fUoAgNbKRASOGfaJ0J3eHI9dB5PtpfhzR6h43BKlcZHtr4oVN8nk+ti0xn3PjZB+8v/Hqyzs1JOi0sEv4tNKJXwzSqyuHUN0cX5JF3mlrRZMYEzRTITW1pkbrp702R9bRQ2C1zWDIaCDooptuQsUMm+vCEnzCmpiy/lDlFnZ2U5pNOi1niCVPIIrM4XKMhbtuqgbKwJH13mx0MAKfGGbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n9GnJ1NI7yGLxB4YWx39k+LX0rzn7Qgei0lIGYLtb/s=;
 b=QIZ3QF2fWGTfji5kJrT+rkThiw2WYfUCcdMWvhPbJrPZrPXPcvdNe7tGLaU8CLlLWdxomFnYd3VzVFV4aekTpmy+C6TMhy4agLfcTNjiq+t4/6L6hujlMEOhjqXMPo56mfpwRqiJP2QEUfUx6dBtDONJmDvp1peddu6bvvHy5CcOOTwjfY6vsciyt7ifjzrbAA/P9xy83czgwtp8JNBuIwbD6FyN3zz0Z4TvWZ6ZxaH809zD1ohRV2Aul6WZBPFN/OEQ5vOomQZZ5rTfvlXspbHPOigkSDPaQG6MyN6mtN/CGXy3oOZQCVrAXFyTmD2EdmDd9gezjNod9Gs3KU/u0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n9GnJ1NI7yGLxB4YWx39k+LX0rzn7Qgei0lIGYLtb/s=;
 b=2+WY9OeuUDHxThCWqrcXPQlBGCICCmT/Pc8S8WbKGVMke0xyO6s5lD40hwzcGp+bZN5prRX4QzLulJnWNbhJxd23nDo5UM7KZSukxXUPSwo7DaX2aYWsUkzR1FDLHXSkFrs7FvFC4+sjHvAHypUN4TZDSAQYPr3hc/ZTDhXVy5Q=
Received: from BN7PR06CA0060.namprd06.prod.outlook.com (2603:10b6:408:34::37)
 by BL0PR12MB2483.namprd12.prod.outlook.com (2603:10b6:207:4c::26)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.17; Fri, 16 Apr
 2021 14:34:48 +0000
Received: from BN8NAM11FT010.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:34:cafe::64) by BN7PR06CA0060.outlook.office365.com
 (2603:10b6:408:34::37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16 via Frontend
 Transport; Fri, 16 Apr 2021 14:34:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT010.mail.protection.outlook.com (10.13.177.53) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4042.16 via Frontend Transport; Fri, 16 Apr 2021 14:34:48 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Fri, 16 Apr
 2021 09:34:47 -0500
Received: from elite-desk-aura.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2242.4 via
 Frontend Transport; Fri, 16 Apr 2021 09:34:47 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 18/19] drm/amd/display: [FW Promotion] Release 0.0.62
Date: Fri, 16 Apr 2021 10:34:16 -0400
Message-ID: <20210416143417.611019-19-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210416143417.611019-1-aurabindo.pillai@amd.com>
References: <20210416143417.611019-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 297c3c63-7e13-4f6e-b2aa-08d900e4c9a9
X-MS-TrafficTypeDiagnostic: BL0PR12MB2483:
X-Microsoft-Antispam-PRVS: <BL0PR12MB24837C9279001D8E19DCC4E38B4C9@BL0PR12MB2483.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:296;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gXILqqljfy2sQnTYV5X4mXGBGTnsAvAD9yUqfmQVpSOD1F16/McxLEF9mFACJNFOkvqXCxwenwI2iTDZO4hurYk1qY9TtbUVF+roVSR+6RcbgbZA+GrTu9SoZ66gzQcMpS5HehtJbXpaSpIftyPd9BD6oau9+0s5JmCtX039np34RAhGAONbhL+7EclBh8/FVIUBScA2wiUcRzSTvhlDYrf9KRQ4GBww4UhRC6vQo0HVVNuaDWCxjzBP2msLHDCes5u6NGsNJbeHq6H6FfPvcqbkJBud+TGlp8IVHG5LWBm6o8FmSAA4AdW+qz2A6KODN8HZhVf6oibxPR70OEa5uaAbdSSa0jVxflqCA5hzdmaT6lCC5t5uSKYqwKuYFOaBcKeTKOr8fOt0xNFcl7+FcqYv04G7+6Bz6kBExnr7v5C4eLbzqf7jcxYCzMrftdE1HndfU6UwQiUmNo9OSyGorzb4FF0qFDeRN9vZEpL60oqYQ9njDEGxvDoTIMXndwNm1JTTIaYLkUR/Y4cSjq0ixVWQXp68ZBSnJNqKW5Rm9dOaIH7xR+t3+lq6x0mj+mUi8rNkLsiZ9TSmb9c1GJimh7+6QG+z/UG2Q/ITAd92uSVJxEbS4nZbbapJ6AakvMxI03dkAQrI3N16CzYJs9O6NdV+WLvhPeVJShWloggo6gQ2LXs2z5ASU0Mt1FeyuN2N
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(136003)(346002)(396003)(376002)(39860400002)(46966006)(36840700001)(8676002)(36860700001)(47076005)(82310400003)(356005)(86362001)(336012)(82740400003)(70206006)(316002)(4326008)(2906002)(44832011)(6666004)(70586007)(83380400001)(426003)(5660300002)(478600001)(6916009)(54906003)(26005)(2616005)(81166007)(4744005)(186003)(8936002)(1076003)(36756003)(7696005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2021 14:34:48.4701 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 297c3c63-7e13-4f6e-b2aa-08d900e4c9a9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT010.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2483
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
Cc: Anthony Koo <Anthony.Koo@amd.com>, Eryk.Brol@amd.com, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 Anson.Jacob@amd.com, Aurabindo.Pillai@amd.com, Bhawanpreet.Lakha@amd.com,
 bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Anthony Koo <Anthony.Koo@amd.com>

Signed-off-by: Anthony Koo <Anthony.Koo@amd.com>
Reviewed-by: Anthony Koo <Anthony.Koo@amd.com>
Acked-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
index ba93e139a47e..4195ff10c514 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -47,10 +47,10 @@
 
 /* Firmware versioning. */
 #ifdef DMUB_EXPOSE_VERSION
-#define DMUB_FW_VERSION_GIT_HASH 0xcf6f1711c
+#define DMUB_FW_VERSION_GIT_HASH 0x23db9b126
 #define DMUB_FW_VERSION_MAJOR 0
 #define DMUB_FW_VERSION_MINOR 0
-#define DMUB_FW_VERSION_REVISION 61
+#define DMUB_FW_VERSION_REVISION 62
 #define DMUB_FW_VERSION_TEST 0
 #define DMUB_FW_VERSION_VBIOS 0
 #define DMUB_FW_VERSION_HOTFIX 0
-- 
2.31.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
