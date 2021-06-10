Return-Path: <SRS0=2har=LE=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDBDDC47094
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Jun 2021 16:29:24 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE8EF61263
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Jun 2021 16:29:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE8EF61263
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 81B7F6ED92;
	Thu, 10 Jun 2021 16:29:24 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2081.outbound.protection.outlook.com [40.107.237.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 819396ED93
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Jun 2021 16:29:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F/RgINHt1uwSWirk3ywA9mIIj3ge/1H81b7mqqj0NMy8mwlaLsMqYCb90TECXNZY+D2fUCY6m/H/dkgzMLYeMzjo1qM51+ADtxoT9xT4dfAEI/UkWZQiJvz/qjhEBkHfbXzH7F1nYrruHeevO7yGwD+HN9aYrkK4dA0LEUIMX+mHzedgEczFc8CO+ub82G36H+s8apHj4D67mPHPPZw0b8LcAHxfWLiQhPwKbWnL6Vffq9hqbc/gBBAGeHOFS+/1lgrlTAf7FE56/oznSSNjJwJIycXkDJHECb06VNnzVq6+n9TCSLc4E+Pf5a1WB5RqvmkVBM42ccIIZNkNfrFIGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C1JDwTBtbCGhMKcUn4MJD6V9vrxr6QbhFb2+lfefAhk=;
 b=fX5/8Re6ol9/+xQB0X0MGJnVUOfp1mqm0bx5nrdMUzTWzMfvdu1Miygx9QxQ+ZYPM6HGTnpa0gQyirSeuZ1t/gdQmiou66RyR1kLYNJZqSlryn1HfzvsVxGckFQ8BzQhwMUGJy46qkI3Pb2Zet1+AzITfRerUKD9hT3Qb/iWROFZ5QIw9cbycWNmZsK2nVGvhD1YhJRLRaCwHtikSjDfBWnXVdwu3VVRsJsIDSS1Pb9/cJ650RvxAX+zaE/qvMsZFWjr+o1TA9XpoRTS4Yjh4bzKqsnxxVYzy/kLYJ1XGq9jGhKnc9MkmBvF/iy1ww0eV7hTVpnbFw82AvMOM+eXtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C1JDwTBtbCGhMKcUn4MJD6V9vrxr6QbhFb2+lfefAhk=;
 b=sm4nkt7CX17S86ZrszPvKD09vq3arI8ufB+WoD2DhJimCZOkpfX1OkGV7tr0lncYQa6eOvn4PSvyFASzi38ki407eB+kiQCE4ddQlAYqEaTJP28sGV5qZ3bNUVFsfkRIWU8xnMn5V58h1pg6c6vc1vmuWTpmlgtATPkLXBw0mLs=
Received: from CO1PR15CA0090.namprd15.prod.outlook.com (2603:10b6:101:20::34)
 by BL0PR12MB2545.namprd12.prod.outlook.com (2603:10b6:207:4e::32)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.23; Thu, 10 Jun
 2021 16:29:21 +0000
Received: from CO1NAM11FT039.eop-nam11.prod.protection.outlook.com
 (2603:10b6:101:20:cafe::ad) by CO1PR15CA0090.outlook.office365.com
 (2603:10b6:101:20::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.22 via Frontend
 Transport; Thu, 10 Jun 2021 16:29:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT039.mail.protection.outlook.com (10.13.174.110) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4219.21 via Frontend Transport; Thu, 10 Jun 2021 16:29:20 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Thu, 10 Jun
 2021 11:29:17 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Thu, 10 Jun
 2021 09:29:17 -0700
Received: from Bumblebee.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2242.4 via Frontend
 Transport; Thu, 10 Jun 2021 11:29:15 -0500
From: Anson Jacob <Anson.Jacob@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 08/24] drm/amd/display: [FW Promotion] Release 0.0.70
Date: Thu, 10 Jun 2021 12:28:22 -0400
Message-ID: <20210610162838.287723-9-Anson.Jacob@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210610162838.287723-1-Anson.Jacob@amd.com>
References: <20210610162838.287723-1-Anson.Jacob@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d4901b2f-63ba-4c9f-c0ff-08d92c2ce6ac
X-MS-TrafficTypeDiagnostic: BL0PR12MB2545:
X-Microsoft-Antispam-PRVS: <BL0PR12MB2545E901FCF7D518A127B067EB359@BL0PR12MB2545.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:296;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: B/6D4tyqYjK7ivQeAZaIKMTxxp3WSe12aG87zITEVLqjzpYb21wig8dTFYwo2VPR4YlOhDvo3Vmwe03U9kagE2/wIaADG9Gn4XMYjf8WcbcUyXnid+6dOgnxtR6p2BAOPTE+HhKRUdn165aRsgd3C+lEjdfkhz/pwtWdKZ2XylQuHBJ+r7gxj+Fly0lZs/APBsWsanI0CZFrAfj98qG4N+U/6sjJ7PO8J10/IZNnU4OIhDTWH9bAJ3I+YFigQrRkcgptvyTyDQ19uDCDm4Fl3GPE/9HHh+fQlsKF9CXx4sL/JQjoL3B1my7UkdySRxkfQ5X75pNso6v7cLSBtB4YdJoyaRTpd02R1QzN/Kpb1xVPdzIL7kG8F2uYabvp6aIVOOMp+viljiBHHpI0CKZltP8o7/MoWvtbFntD/FjVspMDqhNbxeogHPW7yYFWkM7ZNpJtSWZROZH2q0u0nQJhKA3ZdT1vtfC4QrvxcUVGxnMyKJlrTKr+uOT9gRU4ZkkJm7KxmMuJ+XpLpIwRiS1vr8jXdDk/38rWbjIbUizB1fy50Xn5iBel8DwMb0286YfkGLVxdX543wjHBH2Lso/A5vwDOY+VLkUtHdJSFrWZs2v8y8zutM9j+l/WPboMnUom9hTPmLDSrw+57rTzyy3k2srKtX5Y0VtFJ6wd9JUWMAdOm3snP1Z7LqcryJ4mI5vu
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(376002)(39850400004)(136003)(396003)(346002)(46966006)(36840700001)(70586007)(83380400001)(47076005)(336012)(426003)(36860700001)(82310400003)(4744005)(6666004)(478600001)(7696005)(5660300002)(2616005)(8676002)(36756003)(6916009)(4326008)(316002)(186003)(8936002)(356005)(54906003)(86362001)(2906002)(26005)(82740400003)(1076003)(70206006)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2021 16:29:20.8301 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d4901b2f-63ba-4c9f-c0ff-08d92c2ce6ac
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT039.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2545
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
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, Anson.Jacob@amd.com, Aurabindo.Pillai@amd.com,
 Bhawanpreet.Lakha@amd.com, bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Anthony Koo <Anthony.Koo@amd.com>

Signed-off-by: Anthony Koo <Anthony.Koo@amd.com>
Reviewed-by: Anthony Koo <Anthony.Koo@amd.com>
Acked-by: Anson Jacob <Anson.Jacob@amd.com>
---
 drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
index ff1f4ec1531e..18d2f51eb50d 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -47,10 +47,10 @@
 
 /* Firmware versioning. */
 #ifdef DMUB_EXPOSE_VERSION
-#define DMUB_FW_VERSION_GIT_HASH 0xefd666c1
+#define DMUB_FW_VERSION_GIT_HASH 0x5cac099d3
 #define DMUB_FW_VERSION_MAJOR 0
 #define DMUB_FW_VERSION_MINOR 0
-#define DMUB_FW_VERSION_REVISION 69
+#define DMUB_FW_VERSION_REVISION 70
 #define DMUB_FW_VERSION_TEST 0
 #define DMUB_FW_VERSION_VBIOS 0
 #define DMUB_FW_VERSION_HOTFIX 0
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
