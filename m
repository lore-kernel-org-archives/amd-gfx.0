Return-Path: <SRS0=Uu1B=IY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0146C433DB
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Mar 2021 22:06:38 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8FEC4619FF
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Mar 2021 22:06:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FEC4619FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1FF336F4C9;
	Fri, 26 Mar 2021 22:06:38 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2061.outbound.protection.outlook.com [40.107.102.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C97426F4C9
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Mar 2021 22:06:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m66Yq2QW7YWo4MfOnFE1B90/BKbAear19iJ18r8II3+gkkc6HbVpO/lVKTZwoiWJR7uC9REujmEAC9PscrXeUEPGYQ+PjKTjbgrWBqghD4KP8XzGKiHsRJBAt6elOkx5bq3hAkbN6241AbvK4C+XWZ8DjPJWDWza85Derx4etV0uOrYnhlm0E4p5u1fphcDX/aMQAoDte/Vc8b3Ood86x4PYmRISyh9AddmOnYyu1k48N6iHR9ZPPK2iWZZ+xM5YMTsbNUwCny8W4a9ZRK+Z8mxjZeC80nxGniluD5wyb1/wDzbFzcFluS3fM/y9FM3HbFbMajgr6dgE8YMybKWn7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wifpxwP9IlvZxwirK9AX++zj7mRTSBNBDAMorzvkVJ0=;
 b=cFlnh2UYHTIZAfz7N4frYC7b8EfNmGpVJvfFkRkXKCzZU+e/2/jN0R+uDE3bR875Pzg1UOeE8M9vzVtl7kDk9t3oSjCZerBQZb574s3H4WqZs4rye+QnCv+zdwcychZZYbtizsxUU6ODdt+1eq3S/LhB92OuvskymcDm4xNZvc1ZVbIFcI0Na5uMUCtyVcTK774iHXIjLyukeH5N8u9tZ1T1oDqia7Kt27ji4Rt1CPiTlvECRGkkBgBowl+gqSjPsob53jWmriTWwA4m+rWXn168M0Qp9IrJVZFqkN/U192YwgKdp675KqDjGB0hEZdg81qZksCOpoCzZS0XvNIDZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wifpxwP9IlvZxwirK9AX++zj7mRTSBNBDAMorzvkVJ0=;
 b=tXU6QLboyJhXlU2DR4Px3KlsZCkOOrd4epAsfcApTgUhW1neWioWG+2wG9g1dJK2/imqEn4gc9Kb3EAYvamQ6cDryoDzzFopNOI5p6vOwXUIfytAN1MDUuAGQbxa9P55R6sl2IiC9WOX8OBFoc9xwvaT6Li3m34qJLwRWm+Fq9w=
Received: from BN9PR03CA0481.namprd03.prod.outlook.com (2603:10b6:408:130::6)
 by DM6PR12MB3099.namprd12.prod.outlook.com (2603:10b6:5:38::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.29; Fri, 26 Mar
 2021 22:06:32 +0000
Received: from BN8NAM11FT021.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:130:cafe::18) by BN9PR03CA0481.outlook.office365.com
 (2603:10b6:408:130::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.26 via Frontend
 Transport; Fri, 26 Mar 2021 22:06:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT021.mail.protection.outlook.com (10.13.177.114) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3955.18 via Frontend Transport; Fri, 26 Mar 2021 22:06:32 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Fri, 26 Mar
 2021 17:06:32 -0500
Received: from Bumblebee.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2106.2 via Frontend
 Transport; Fri, 26 Mar 2021 17:06:26 -0500
From: Anson Jacob <Anson.Jacob@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 21/21] drm/amd/display: 3.2.129
Date: Fri, 26 Mar 2021 18:05:34 -0400
Message-ID: <20210326220534.918023-22-Anson.Jacob@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210326220534.918023-1-Anson.Jacob@amd.com>
References: <20210326220534.918023-1-Anson.Jacob@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9fbd162d-a14c-49f5-edbd-08d8f0a36a3a
X-MS-TrafficTypeDiagnostic: DM6PR12MB3099:
X-Microsoft-Antispam-PRVS: <DM6PR12MB3099E89664C61D1E9C2361E9EB619@DM6PR12MB3099.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HMvOBIFFFaXhDJmyy2Y6XIDG7pvGfnSh3QTNkprB6r1Z4SkbUlDySCMlGi9HoJzzS9dUZR3GdyWO4K6VU1Hhjmt1kcg1DmtJMckWpJdsbXMn5pg6ok+vLhYjDmR7rPbqxfBCvfBOyl3CzOyutPX5rK1XPxs1yYGKrc51VHXuXrH9muDmAkmgGfrvGGPFeR64ZV4hS+KrOmFQ9mexfRVUJLvNpFXAAQBATzpytL10yV+R6DBIJm5ynSq/vStWz08JAuYyx2uDK2u6baRk7OkvAVeCD3te/HXb6gJTn33qy9VhfTcgWTleV1ebkq4BN7IWICy7fBitLZ3ScYibpcf3F2vPbAo21bZHwtn0LbiOhayuuzYzbIN+2qMknLp082HQZFgjtvENGi3NEH4oJpyzyqY0QQIrzrLRnR4reQI2uRDybG9DTvFtyOpSSpgS0I596BGcsdfhLgOJmf5o7+rwcwS4HnujtkfmLbjgnyAKbT+97uyev9N2bvG5jaMYCe8URie7vMGrlhxSOjXxxFYLrkQs7zDiTj2GccoNLEjds+0C5lm+GfnpYu+yxHT9461BCreB7yxgacA8Q2pEzK9f0YrJjv0C3sKw0NGqs+BssZwih1IjTRdnKHoU5+8uXKx8wsuw2QncquBbYHCJmktCmMnIzeQqPkEZWBDFCyR9/kWLAQ4YuWW8l7f8GBL6l9OB
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(376002)(136003)(396003)(346002)(39860400002)(36840700001)(46966006)(47076005)(356005)(1076003)(81166007)(8936002)(6666004)(336012)(2906002)(426003)(82740400003)(36860700001)(2616005)(186003)(6916009)(82310400003)(7696005)(83380400001)(478600001)(8676002)(26005)(316002)(86362001)(54906003)(4326008)(36756003)(5660300002)(70586007)(70206006)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2021 22:06:32.5067 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fbd162d-a14c-49f5-edbd-08d8f0a36a3a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT021.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3099
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
Cc: Aric Cyr <Aric.Cyr@amd.com>, Eryk.Brol@amd.com, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 Anson.Jacob@amd.com, Aurabindo.Pillai@amd.com, Bhawanpreet.Lakha@amd.com,
 bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Aric Cyr <aric.cyr@amd.com>

This version brings along following features/fixes:
- LTTPR improvements
- Disable MALL when SMU not present
- Fix bug in HW that causes P-State to hang when DPG is enabled in
  certain conditions
- Update code path for enabling DPG
- Update display endpoint control path
- Add dynamic link encoder selection
- Fix debugfs MST topology to dump from the root MST node
- Enable DP DSC Compliance automation for Linux
- ASSR is enabled only when DPCD is supported and the display
  connected is internal
- Added kernel trace event to print real-time refresh rate value
  to debug VRR issues

Signed-off-by: Aric Cyr <aric.cyr@amd.com>
Reviewed-by: Aric Cyr <Aric.Cyr@amd.com>
Acked-by: Anson Jacob <Anson.Jacob@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 55f3c76823d8..8b725347e2ed 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -45,7 +45,7 @@
 /* forward declaration */
 struct aux_payload;
 
-#define DC_VER "3.2.128"
+#define DC_VER "3.2.129"
 
 #define MAX_SURFACES 3
 #define MAX_PLANES 6
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
