Return-Path: <SRS0=RbrA=N6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6751FC433F5
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Sep 2021 14:54:57 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B32760E77
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Sep 2021 14:54:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 3B32760E77
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A43056E1CE;
	Wed,  8 Sep 2021 14:54:56 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2067.outbound.protection.outlook.com [40.107.93.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 68BE06E1CF
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Sep 2021 14:54:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XEC3dSqnFLIPC4fPfXp7EFYipOddEMsSuiV/zuPEOWBRurRs7MM65VPAOwtdtdM32dhymOjscCJxn8Rxkbx/gFtvgCaxKC2mBoTlpibTztsqiQmGVClb6mVmNbPb/66GGyCSGMRJjD0HZ3Nr4jE4OvVAxk2TyF8u7qVYKy24diBU24fUbLEm8I5RHSYSMJ3qW/D0trWCKQA7DW66Ak7SbbV30x/aRKnXtdNrPjeHfOXR/Bk8ZcneBRILShaScwVVJO/JmtbBAyiBn1uWdYFPswXNxsvGoM91CuF1CKLrgH3+lBrLxndgnrs7IhpeZQwHHrQ+4nOTHqwwlXWm45kFdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=r0hK+FjjVwHo5joJLJWZuE6OjLQrPGBUXLr10+Zmaag=;
 b=B+TtS+DDyVxWqQv/tXGylYU8hSpqr7fP4Nqv5O1Bgx+xr376CuXFfPBW1bP1eK68zt2W+m0I2ntFMi/YBo8fNZ0dIdswl2I/nyquPexZqJmMif+lc8qcRkV6fS7IiWl5dl44ARS2mUNAH/X8L6YWj38qOzMsFwXCXoj6kHJaS8t3xO5my7lhTdpS4/hB6pC3q7I6El+MVMm2H0o8WU4lomtFqlW4aZIsnRSaiyQ/x0OgXYk3EWZRzdIZrQOCrj5aB5HepGCv0BuXbfq8IzT59j8DkjKlKb/aSMEeXwcrXzsfL2QCb+qGz24EcUbG8ppBTMd3qwc/kPhh7A6yvIpkGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r0hK+FjjVwHo5joJLJWZuE6OjLQrPGBUXLr10+Zmaag=;
 b=T5RK4lRvZxg1dZSVP8UKCjurikPDR5pgRG+bWGAT7eiBZ5PULrvQUtxR4flf7B9Apz9AVIX8o77IahYSaewhrp6SiRtCOuz+mP2fu5YNHQF/7Kss1oyLbhNHrUUGPcMWpof1iuA5cElmvjD+HzFjDp0rY79UQi60mJMHqm+JZcY=
Received: from DM5PR13CA0022.namprd13.prod.outlook.com (2603:10b6:3:23::32) by
 CH2PR12MB5547.namprd12.prod.outlook.com (2603:10b6:610:64::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4500.14; Wed, 8 Sep 2021 14:54:53 +0000
Received: from DM6NAM11FT033.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:23:cafe::88) by DM5PR13CA0022.outlook.office365.com
 (2603:10b6:3:23::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.6 via Frontend
 Transport; Wed, 8 Sep 2021 14:54:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT033.mail.protection.outlook.com (10.13.172.221) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4500.14 via Frontend Transport; Wed, 8 Sep 2021 14:54:52 +0000
Received: from DESKTOP-9DR2N9S.localdomain (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Wed, 8 Sep 2021 09:54:46 -0500
From: Mikita Lipski <mikita.lipski@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Bhawanpreet.Lakha@amd.com>, <Rodrigo.Siqueira@amd.com>,
 <Aurabindo.Pillai@amd.com>, <qingqing.zhuo@amd.com>, <mikita.lipski@amd.com>, 
 <roman.li@amd.com>, <Anson.Jacob@amd.com>, <wayne.lin@amd.com>,
 <stylon.wang@amd.com>, <solomon.chiu@amd.com>, Wesley Chalmers
 <Wesley.Chalmers@amd.com>, Wesley Chalmers <wesley.chalmers@amd.com>
Subject: [PATCH 10/33] drm/amd/display: Fix false BAD_FREE warning from
 Coverity
Date: Wed, 8 Sep 2021 10:54:01 -0400
Message-ID: <20210908145424.3311-11-mikita.lipski@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210908145424.3311-1-mikita.lipski@amd.com>
References: <20210908145424.3311-1-mikita.lipski@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cce2f8cb-53ca-43db-059c-08d972d89d74
X-MS-TrafficTypeDiagnostic: CH2PR12MB5547:
X-Microsoft-Antispam-PRVS: <CH2PR12MB55477894E19887B7CA6C2CEFE4D49@CH2PR12MB5547.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VrPE1n1ZIFadj3x8x6YCE0DSAQfGLoKSEw6mIKbbrzccTp8Zb8MZZZzSEj8sPvWj+MbD4O5lzymhKm6fnKnNmGqTcP49g/1B4/KrkhGANiTHeRe3SZHf0aWSLLNvdLBEgZoyzzEgKotlvu181qcf9uOOaR5CazHvUEVtuI+Fuk7iJE//w/aFhCt/jMdPR1PyJy8/bfP6GN6bjRkMHaTN9wUAqHrGeC65iiRieUk39+1XzuJlVLjn1fhKRKM8NEJVNvlh0By9yXe/qfRKH4ALJTacZ5HrDSPesz7hxcUGLHSeGg/Qjbl5m+PLh2yvZBjxJUh6ySv56M67WnM6xEH46hQGe+HJvOuGVeJ8qBBEUVgBilXcrYo1GGMkk3mGDE8/6O1B+RGksqVYMMhy20vX3HuZP7FtlnLEwKzRtP05P/O9r042fpiU9XI3vKDb3q1gBk3aE61qZtB4qF4t4kj4Ak4CUHlsi6VXZ8QSayQSQdptPQMV4Xdw5SUYxiyPhA9g7L/R2CeGSuIwKRJELQ+LFpOuj2EISTbOTnGcINBNmraOjMmeUZOgpV5/i/ZUX+dkpQnIgHVAr0RAkPI1Ir5+J4jnTNF7x33zHH1LTkanM3H9bghCf+pieoQ8O6XQM0Oi1r+Ng76EhqluHHBwEYnSOKDx6gaWe3H4vpon1VVNAwCObf+Fx/jQjSxdxU5KvB/TA54Gj2cYroY/kYe2+ZfyDUWwEEsaP+QgjFIm9mp1ChQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(396003)(346002)(376002)(39860400002)(136003)(46966006)(36840700001)(82310400003)(83380400001)(6916009)(86362001)(36756003)(2906002)(316002)(356005)(82740400003)(81166007)(4326008)(36860700001)(54906003)(426003)(2616005)(336012)(6666004)(1076003)(47076005)(478600001)(70206006)(70586007)(8676002)(44832011)(186003)(5660300002)(26005)(16526019)(8936002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2021 14:54:52.8855 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cce2f8cb-53ca-43db-059c-08d972d89d74
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT033.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB5547
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

From: Anson Jacob <Anson.Jacob@amd.com>

This is an attempt to fix false warning raised by Coverity
via multiple CID's.

Addresses-Coverity-ID: 1487412 ("Free of address-of expression")
Cc: Wesley Chalmers <Wesley.Chalmers@amd.com>

Reviewed-by: Wesley Chalmers <wesley.chalmers@amd.com>
Acked-by: Mikita Lipski <mikita.lipski@amd.com>
Signed-off-by: Anson Jacob <Anson.Jacob@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link_dpcd.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dpcd.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dpcd.c
index 72970e49800a..7f25c11f4248 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dpcd.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dpcd.c
@@ -176,12 +176,15 @@ static void dpcd_reduce_address_range(
 		uint8_t * const reduced_data,
 		const uint32_t reduced_size)
 {
-	const uint32_t reduced_end_address = END_ADDRESS(reduced_address, reduced_size);
-	const uint32_t extended_end_address = END_ADDRESS(extended_address, extended_size);
 	const uint32_t offset = reduced_address - extended_address;
 
-	if (extended_end_address == reduced_end_address && extended_address == reduced_address)
-		return; /* extended and reduced address ranges point to the same data */
+	/*
+	 * If the address is same, address was not extended.
+	 * So we do not need to free any memory.
+	 * The data is in original buffer(reduced_data).
+	 */
+	if (extended_data == reduced_data)
+		return;
 
 	memcpy(&extended_data[offset], reduced_data, reduced_size);
 	kfree(extended_data);
-- 
2.25.1

