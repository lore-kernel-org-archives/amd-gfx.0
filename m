Return-Path: <SRS0=S25v=LM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4340FC49EA4
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Jun 2021 17:35:38 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 05BBF613F0
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Jun 2021 17:35:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05BBF613F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B02B56EA4E;
	Fri, 18 Jun 2021 17:35:37 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2083.outbound.protection.outlook.com [40.107.220.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 26C3E6EA4A
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Jun 2021 17:35:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Iudr3s3K93B5RMipz/L9ObnPCatPuD91JN0aTA4q/dXbqNKJU4W6veKMlGgfY2k871bpQdi304bWHUbFhb2ZhFsAxSiZtIXjOlO5w6CboujA0tLtT5N66K/Qmr4zDT8Ld52zCcty3cwOGd9eQzg2mzd4pPl6byq/EVZT3FVVtbFQ0bA61bAjhjqVpohaM672qKC/ZPLSG2IpHAVN75Mmo3ObUFJ7a9onCOJoNUYDg1/Yb5BZf9rsCqWVhnRQLKnnGeMAImPaitb5SWSql0cxeDLslb3r0VVp9YT2lEIRBuMfYitgxO8X0wIsM7PxeY12LJwShJq5mhpETbtTLR2cOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CHjqizFoIGB4lN+W/hhPuXbCdtcb2w0iU/Sp1ioUr+Q=;
 b=CTqn+ZJN08UldEiw6r16EyLFS1qHFxk7vARv6SDgYzerU4tVgRWGGXs/fCn4YjErC5p/cXwn65CN5WKiZsEmy475ZNtFKepG2bH1YbSQjHA2GACyzDpeVqx5ay3kRhZrSLO0Qpi5wAob8CQM8DO+WBkIhgqBOAeVcMQq+iconNLRoY0wBzHloQbk5KES44/L7lobWjyIQmh/mgUheZI69W4WxapzfJRGLHaXZbSNJDkNB9NB/SV5/gmLzitIuYjQE8clb2dwcjhMbNT5b+vBb6paTQGkgMwcHLgwrhrjgcAyvecTBQh+gI4NmtyNjfCACblyND+AhM6aukazh1GOog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CHjqizFoIGB4lN+W/hhPuXbCdtcb2w0iU/Sp1ioUr+Q=;
 b=kB7ncY23Bo5yyaCV4cERjLsE+ShYJujlylR94m9oaqVNheGcBMiazI8Rk1LLBmQKoExukWFVt9xS6oeJr9eoUYtnAVwTMJku5ViGmDAOiOcxO0YAB0zdV4JYSenPYOhQJuLVnCSIQG/0c8OZeqOrGGSaijeUkurdwNX/sE7PjMg=
Received: from BN9PR03CA0724.namprd03.prod.outlook.com (2603:10b6:408:110::9)
 by DM5PR12MB1804.namprd12.prod.outlook.com (2603:10b6:3:112::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.21; Fri, 18 Jun
 2021 17:35:32 +0000
Received: from BN8NAM11FT043.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:110::4) by BN9PR03CA0724.outlook.office365.com
 (2603:10b6:408:110::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18 via Frontend
 Transport; Fri, 18 Jun 2021 17:35:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT043.mail.protection.outlook.com (10.13.177.218) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4242.16 via Frontend Transport; Fri, 18 Jun 2021 17:35:32 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Fri, 18 Jun
 2021 12:35:31 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Fri, 18 Jun
 2021 10:35:31 -0700
Received: from bindu-HP-EliteDesk-705-G4-MT.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2242.4
 via Frontend Transport; Fri, 18 Jun 2021 12:35:30 -0500
From: Bindu Ramamurthy <bindu.r@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 04/12] drm/amd/display: Fix incorrect variable name
Date: Fri, 18 Jun 2021 13:35:06 -0400
Message-ID: <20210618173514.430647-5-bindu.r@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210618173514.430647-1-bindu.r@amd.com>
References: <20210618173514.430647-1-bindu.r@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4ddbbf73-dd7f-497f-e2f6-08d9327f78ed
X-MS-TrafficTypeDiagnostic: DM5PR12MB1804:
X-Microsoft-Antispam-PRVS: <DM5PR12MB1804B3D3BC0128620A456DE7F50D9@DM5PR12MB1804.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1360;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xqldmplhMyXY4CDwgRP9wBtwJl5iCNZrvlDJNRuANKjjvvg2qcKCfHrfn9UEYw6Mm7K1qmu4RiPx0nBIQa2o8ATLUyuS8iOvdB6+fK8qnqt1///EGSNjhkSDVZZO8u14YsolDTOTkJ5Rxfu2GEHMPU1b7DBsVHLmWi0pnjRbvEA4uYyq9iT5c5pwrrxLxQVpLhJAfooJoJ2tTBpF5LAZrOt/LcxwfhgeeA+BB0S+DSe2wiRY9U3I6ee4ENaa5mnFj9UkQJH2Mm7iiL/bQGXuJCF5/Ic/lbMj7fUI0JBSWjkX6m5a9gnHocHEjWG6/BuKIC+D8OpsPjt9Hs1DruqfdyUtJVA1i/PfxkclyOG5JuXIXUQ0LUXA1/tKUYHyWbyR+WwdS5e5NLLwKF3XO1Wxj3WVKbQHtmxq4EL090LyidcoI+Tp0vpygiqf3lrmwPPvnrATvx/01e6mehGfDZxYyHcMXAKe55z/vKwzlRQ9wyJP1Dd4IPBmLoow2Qi7+aTL4nQPucl0ayQUDpzO6mQIcqQqukTzU2ioIGHtm0xRuYYlBDeYIZdxhd6xllui2UD0rKkUm/ub/qpKrIfg9o3U695qNiSrvVnbBUKuw4mbouBaJ6AKdsYdMaIatHeYPWT2ALWiMKeoqz2+kFtWcacZcsi3xC3qZTFw1lnWyKTdDroSD88ju7Mbk684eD8xHE7U
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(86362001)(70206006)(4326008)(186003)(6666004)(2616005)(54906003)(498600001)(6916009)(26005)(7696005)(70586007)(2906002)(5660300002)(82310400003)(336012)(36756003)(426003)(1076003)(8676002)(83380400001)(8936002)(81166007)(47076005)(356005)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2021 17:35:32.0297 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ddbbf73-dd7f-497f-e2f6-08d9327f78ed
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT043.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1804
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
Cc: Ashley Thomas <Ashley.Thomas2@amd.com>,
 Wesley Chalmers <Wesley.Chalmers@amd.com>, Eryk.Brol@amd.com,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, Qingqing.Zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, Anson.Jacob@amd.com, Aurabindo.Pillai@amd.com,
 Bhawanpreet.Lakha@amd.com, bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Wesley Chalmers <Wesley.Chalmers@amd.com>

[WHY]
extended_end_address can only be calculated from the extended_address and
extended_size

Signed-off-by: Wesley Chalmers <Wesley.Chalmers@amd.com>
Reviewed-by: Ashley Thomas <Ashley.Thomas2@amd.com>
Acked-by: Bindu Ramamurthy <bindu.r@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link_dpcd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dpcd.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dpcd.c
index 27ec1e6e9c43..fe234760a0f5 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dpcd.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dpcd.c
@@ -152,7 +152,7 @@ static void dpcd_reduce_address_range(
 		const uint32_t reduced_size)
 {
 	const uint32_t reduced_end_address = END_ADDRESS(reduced_address, reduced_size);
-	const uint32_t extended_end_address = END_ADDRESS(reduced_address, extended_size);
+	const uint32_t extended_end_address = END_ADDRESS(extended_address, extended_size);
 	const uint32_t offset = reduced_address - extended_address;
 
 	if (extended_end_address == reduced_end_address && extended_address == reduced_address)
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
