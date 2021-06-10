Return-Path: <SRS0=2har=LE=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5EA0C48BD1
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Jun 2021 16:29:41 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8DD09611B0
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Jun 2021 16:29:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DD09611B0
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 302C46ED9A;
	Thu, 10 Jun 2021 16:29:41 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2054.outbound.protection.outlook.com [40.107.94.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9CE936ED95
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Jun 2021 16:29:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MgwfMwrvaOjjBfjYrfFYqb2F7Pes0XYvdS4MXA+EX8aHiBn1dhIs41OwPxrmk3gy9zO6N3Z1ey1kc5M3p4Scz4c89ILe4sMfAMWmx359Bh8HgskrShFFOoIBZ0NXUw+fimxgJqLeCs5rqnmdjVNemdFmIc/mlimrgaeLjxQmvsbaPD5XLDgSP2QhmS374lO+PflJcYUtHGkzQQbxjIcE5R8Hsdag5FOuVz+yY8ATHvsAqz90mvwfTzRpCpzzk7JKk0FqEl2jL1WLD8ikoVynzzel5+5oKynMh3JYr05Ioz9C0qbWjxM+HNOkJUxKAqdSy3bayEevz+dQ8dbOLKP87A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9IfmzUi0pYjZrOgdoYB7iK4UJqv5OyMbOKLcCUEa4jE=;
 b=GodTKGZOnC8vTB6bJqBJP3nc/PNv8MPue2icGcdFFUyUtTbh5TtvOz4VuwjLnmNtaOTO5Y8ZvfHnwG8TdWVsPpJ7VhH786gCDBcLEy3SE+//cD2VFB56jCrU9D6iPFa0DicrCjCLBsjzJwIrVNxj1VeQotOTqvvRydqCbmYbGjq1Z843zrmgi7zxnBUIJhHoENmdtWz4JkFecv1W6CqcR90UgqIw5P8VnwFHFq8kGb5m/RH/LTYrxTXd3TbpI/pj0FcAVO/qIHySRWJkDI3GMOt7fEjGN5GDI9WXAuBrXNb5DiA57Phi1UI8s5omOq/vrC5U0pFz6JMjcOe8rX+1GA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9IfmzUi0pYjZrOgdoYB7iK4UJqv5OyMbOKLcCUEa4jE=;
 b=wfneCw+YXHabghdBAyxSrZR+6qP+MNmD+oeMywSKuEyvTwEtpeelFnAqzUNgZDJdFVXcmc4Wl3RBDE6d7AjzIl2Ba6Ce/xfcF1iYRB4VcbhlsqTwbiVKSb7tZMFQeLGlWVbAHEscKQ5tkC2dVBaMxzFYPqN1Q+6HwZctqcK9lkk=
Received: from MWHPR21CA0026.namprd21.prod.outlook.com (2603:10b6:300:129::12)
 by BL1PR12MB5206.namprd12.prod.outlook.com (2603:10b6:208:31c::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.22; Thu, 10 Jun
 2021 16:29:36 +0000
Received: from CO1NAM11FT024.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:129:cafe::fa) by MWHPR21CA0026.outlook.office365.com
 (2603:10b6:300:129::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.5 via Frontend
 Transport; Thu, 10 Jun 2021 16:29:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT024.mail.protection.outlook.com (10.13.174.162) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4219.21 via Frontend Transport; Thu, 10 Jun 2021 16:29:35 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Thu, 10 Jun
 2021 11:29:33 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Thu, 10 Jun
 2021 09:29:33 -0700
Received: from Bumblebee.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2242.4 via Frontend
 Transport; Thu, 10 Jun 2021 11:29:32 -0500
From: Anson Jacob <Anson.Jacob@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 16/24] drm/amd/display: Improve logic for is_lttpr_present
Date: Thu, 10 Jun 2021 12:28:30 -0400
Message-ID: <20210610162838.287723-17-Anson.Jacob@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210610162838.287723-1-Anson.Jacob@amd.com>
References: <20210610162838.287723-1-Anson.Jacob@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9f8516d1-5074-402d-d053-08d92c2cef61
X-MS-TrafficTypeDiagnostic: BL1PR12MB5206:
X-Microsoft-Antispam-PRVS: <BL1PR12MB5206245EC64E857BB9E4A9FCEB359@BL1PR12MB5206.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KcmHPHUpiQ06uZkJoJhfwtRv84NjBB5JhIEbNQqUF/r5jnM6KTRzKisUd4M694TOJ6NlbFz+gYiio9hSrEy5VD9tndMxYveMl4wH1rDtK2aDCpKtlv3jSdVqNUFSW44MbdebZavOY3Ib+ILGUZ6957OfB9F+SCfkETmY2ih3pGc2wXCQjMm9bdvgYku2vybIQrFmIa9L1gIoIxyd2TFu2ofRBA5tC0+/wOVkEFwMg3AevEUGenZeZmZgFIlax+OUACrh7BzB7zad0H4s3q5iJx304vkYDitB5idHr5em5Sqh3uKwAZQel4fVTjAEtQYJAf0rFms/iCUv/nvq+BYEJ7zQd0l/vpadg0ae5nIRa7h5t5KtKcQUGlK1iRUXo0rxcyxC8jWWf1JGNRCCXps22ei3f19YlKZW+61goSYUjE/ckjxPEmnXeBIyzGo8vVgiDaBIhvNgcFSUMlJOhIC2mtKgjn5XPdSri8QS6yrSWBsnj7qXZ3fxDiSKx3KVW0Knknm33bxnO+ce8YFT4V7oHyow0NtXk9jf2bxdCavyVrTh8i+RDhlNAwaLr/29jjhN0tzFAb2kL3zvZuFLDWgzfHeaIzENeTHzeyAuxd55QJZDswED+DJRuFQq2bVbzSGPHad69Je6GH07yF5iVcaLR/81ZdV59pHs1HTPNt05JIhf6m+m7mj/aK491b/UVnf1
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(346002)(396003)(376002)(39860400002)(136003)(36840700001)(46966006)(316002)(70206006)(54906003)(70586007)(8936002)(81166007)(82740400003)(83380400001)(8676002)(478600001)(86362001)(356005)(186003)(82310400003)(7696005)(47076005)(1076003)(6916009)(2906002)(5660300002)(2616005)(26005)(36860700001)(426003)(4326008)(36756003)(336012)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2021 16:29:35.4374 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f8516d1-5074-402d-d053-08d92c2cef61
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT024.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5206
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
Cc: Wesley Chalmers <Wesley.Chalmers@amd.com>, Eryk.Brol@amd.com,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, Anson.Jacob@amd.com,
 Aurabindo.Pillai@amd.com, Jun Lei <Jun.Lei@amd.com>, Bhawanpreet.Lakha@amd.com,
 bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Wesley Chalmers <Wesley.Chalmers@amd.com>

[WHY]
DP specifies that an LTTPR device is only present if PHY_REPEATER_CNT is
0x80, 0x40, 0x20, 0x10, 0x08, 0x04, 0x02, or 0x01.

All other values should be considered no LTTPRs present.

[HOW]
Function dp_convert_to_count already does this check. Use it to determine
if PHY_REPEATER_CNT is a valid LTTPR count.

Signed-off-by: Wesley Chalmers <Wesley.Chalmers@amd.com>
Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Acked-by: Anson Jacob <Anson.Jacob@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
index c68b49a14f88..7e52bb3047bc 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
@@ -3699,8 +3699,7 @@ bool dp_retrieve_lttpr_cap(struct dc_link *link)
 								DP_LT_TUNABLE_PHY_REPEATER_FIELD_DATA_STRUCTURE_REV];
 
 		/* Attempt to train in LTTPR transparent mode if repeater count exceeds 8. */
-		is_lttpr_present = (link->dpcd_caps.lttpr_caps.phy_repeater_cnt > 0 &&
-				link->dpcd_caps.lttpr_caps.phy_repeater_cnt < 0xff &&
+		is_lttpr_present = (dp_convert_to_count(link->dpcd_caps.lttpr_caps.phy_repeater_cnt) != 0 &&
 				link->dpcd_caps.lttpr_caps.max_lane_count > 0 &&
 				link->dpcd_caps.lttpr_caps.max_lane_count <= 4 &&
 				link->dpcd_caps.lttpr_caps.revision.raw >= 0x14);
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
