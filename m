Return-Path: <SRS0=2har=LE=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EC01C47094
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Jun 2021 16:29:33 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D83C61263
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Jun 2021 16:29:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D83C61263
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D57176ED9C;
	Thu, 10 Jun 2021 16:29:32 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2040.outbound.protection.outlook.com [40.107.244.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C56246ED8A
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Jun 2021 16:29:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A3SE0RsIQbbOKn1rkuJoGKKMsrK5x2IhKofiqLJtt72TXlIstVcoTfibSPfslc1cWTGvA+3WWGdXK29n1xL12CLBiwlw/WDPEfhyXSQHWsFvm90FCveXr7OmOLHBdcbwk353FSkkSHMqkHq0tgpAsmpNqZ+oAwxaQSFoSEXFnZHUHpiKmr0b7Tn0SiLjeoWUUtillIYdszFzCAobDI/4Ryh2WfdJBPK4vQmedEe2adwVqsDCcrcXQ+zGKZ6r5KV0AJ7Lm2wAHMN4fRbZICfjXyLw9dd80b7WAC2g9gK0V+nlRD8cw63cD434ccXVgtM4Pm6/oUvHevVTsYv0siFVKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4M0tNwW5fuhhT6fUDnHLP8+Rlwh6475Ss9Ge/kzwYCI=;
 b=jrjgTbkgMlX53xdlU7y9lnDDZNO2qV4jGUM2ol/PuX2CpLjMO2O/paORGyqwnk9VBTZ4dqbrQ+HW/Bks944Se1QWQ6XmY6MEO8tQJQM01u2sTxwPrCAseCkrf0v7iOCP5alpbB5drorYmDANk2I1rVgCj3FjOq0KGb/iYJF/omYQchq3cXqLpi/z7UFgRDD+8/HacMmwlJ6mu8/O0+wlb/S7OskGomzg6jbZ3RFyba9/F37XoCVM4O77Q8m31o13Hlvvfds7NdKpJijbH+cMHN3vn5GZqs+/UyDgNA7VG6urddv5TwoAwPpEl1GuAxovVy0zTmW3wca3oRlVuFBcPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4M0tNwW5fuhhT6fUDnHLP8+Rlwh6475Ss9Ge/kzwYCI=;
 b=vv1vDvNaZwaeeIpR5aKAU2Jfckwh8FrPJVFgOzB7U8VRLK14GiJGV26ShAkP5K+KAm8qE/TUB8yK6N6/g6abFTZgHnJmA+nX4DskKJeOb4jMVyNo9vF4LsEgzxlFToZ0gMrQ/psmXfKlcyi8mT+ImigUupjgaX4Uf1GWUYuWRgI=
Received: from MW2PR2101CA0014.namprd21.prod.outlook.com (2603:10b6:302:1::27)
 by BN8PR12MB3234.namprd12.prod.outlook.com (2603:10b6:408:95::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.21; Thu, 10 Jun
 2021 16:29:25 +0000
Received: from CO1NAM11FT066.eop-nam11.prod.protection.outlook.com
 (2603:10b6:302:1:cafe::57) by MW2PR2101CA0014.outlook.office365.com
 (2603:10b6:302:1::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.1 via Frontend
 Transport; Thu, 10 Jun 2021 16:29:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT066.mail.protection.outlook.com (10.13.175.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4219.21 via Frontend Transport; Thu, 10 Jun 2021 16:29:24 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Thu, 10 Jun
 2021 11:29:23 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Thu, 10 Jun
 2021 09:29:23 -0700
Received: from Bumblebee.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2242.4 via Frontend
 Transport; Thu, 10 Jun 2021 11:29:17 -0500
From: Anson Jacob <Anson.Jacob@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 09/24] drm/amd/display: 3.2.140
Date: Thu, 10 Jun 2021 12:28:23 -0400
Message-ID: <20210610162838.287723-10-Anson.Jacob@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210610162838.287723-1-Anson.Jacob@amd.com>
References: <20210610162838.287723-1-Anson.Jacob@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a7d65905-bf6d-4a6b-783d-08d92c2ce90e
X-MS-TrafficTypeDiagnostic: BN8PR12MB3234:
X-Microsoft-Antispam-PRVS: <BN8PR12MB323485BD2FCC86EB698D7BF2EB359@BN8PR12MB3234.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:296;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ch28f60cGADr5efU/mukGGWlEZl5qgj14gWghYLn0SdTtP3Q6sX8LbWR4jMV8ZEN5nRe3zX+1WhQ6rYzub3xdNxEHzQFlMbqcB9PH93hyASlhrc6YiMt8AUVOBHK89z8WYJZKRN66iIH8WAKKIHTc/xfCstk66Emx00fSacYMhnu5EKSNtpC2Hw2B2SQ5cZzVurNPsxubkjyQmLdrX8jVVxoc5agxJkAGcanif+IaFifBIPV1CFKcew2w/4Pme5qW3Wte1S+0cHZ3DiTHi8HAiv7QlL7gSNnmUdYaF9GfPBbZjaGsv5o/mwPRPkouPqV5xr25rDvD37BoGKgrkWx4/N11ueBJAurzOHbglQdHsJ0egXIMJKNsewU1mrESdRxwafkuHxBWiaPfj5LT5PXsVS4Px8aZ5ZX5VF6q1dUJzEhsrlzYcT1I5ibrMmIEuzcFBy8bHIZ0FjgFEPbcgHrd+yEpdpA7xjtNDcb21vfqjMHIWDDdnosZhBOjG8Eoyk4JwLTudMiew8qptabrJGTfAkWm1CTXfUijL7dYZpZcdT8wcjYcSmKQuQzkDwrtlMXn1n/a9ve0TZ8GMG/kSuoKPItH5Rc6ja6EAs7nyf1QQzfNffrp8/IdELVfdOL9R1ENKeCIWK/h6qvfdCVZKuJHG9mtwyTyFQ7BMA1orDXRJaYHtczL7JupbtUqOil5WmL
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(376002)(39860400002)(346002)(136003)(396003)(46966006)(36840700001)(316002)(7696005)(70206006)(82740400003)(36860700001)(54906003)(4744005)(70586007)(2906002)(47076005)(1076003)(356005)(6666004)(8676002)(5660300002)(36756003)(426003)(336012)(86362001)(8936002)(26005)(186003)(81166007)(83380400001)(478600001)(4326008)(82310400003)(6916009)(2616005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2021 16:29:24.8219 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a7d65905-bf6d-4a6b-783d-08d92c2ce90e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT066.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3234
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
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, Anson.Jacob@amd.com, Aurabindo.Pillai@amd.com,
 Bhawanpreet.Lakha@amd.com, bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Aric Cyr <aric.cyr@amd.com>

This version brings along following fixed:
   - LTTPR improvements
   - Backlight improvements
   - eDP hotplug detection

Signed-off-by: Aric Cyr <aric.cyr@amd.com>
Reviewed-by: Aric Cyr <Aric.Cyr@amd.com>
Acked-by: Anson Jacob <Anson.Jacob@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 6470eee8e212..9d924e8496f9 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -45,7 +45,7 @@
 /* forward declaration */
 struct aux_payload;
 
-#define DC_VER "3.2.139"
+#define DC_VER "3.2.140"
 
 #define MAX_SURFACES 3
 #define MAX_PLANES 6
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
