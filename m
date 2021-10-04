Return-Path: <SRS0=otPk=OY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41C71C433F5
	for <amd-gfx@archiver.kernel.org>; Mon,  4 Oct 2021 14:45:43 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F6DB61391
	for <amd-gfx@archiver.kernel.org>; Mon,  4 Oct 2021 14:45:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 0F6DB61391
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5A9FC6EA15;
	Mon,  4 Oct 2021 14:45:28 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2077.outbound.protection.outlook.com [40.107.236.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 21B2D6EA17
 for <amd-gfx@lists.freedesktop.org>; Mon,  4 Oct 2021 14:45:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dBTq8Jv01uC2exPD4mymVvg/J/9jaoZLPKNSt9YKcehMXWXz4PMQzTkTxQe4AgGjx6qqQVGjYrxRmGZk8Ni4stR32LGDLXagw1QAg9OyHveFt5zmMm9tEJeIv3keylHZUSPeY0Fmrj5X04SF9bcijFMbIbCZofM4Az6+hYrVE6ee1D8AtuccVo93R/WdBCDUz10R+gCfs1rJvh8MXeBfR/WWildyLErI5Bf19p3AvesswcAgkpE1IsDrItMelNyNmnVtG+oD09Pj8+rK1e67tMZOrh+aMMBfZeurIa7Ff63yg40+PMaSC/UX6uQllktqkP5WhgBVgSAN65XyWJuOmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2bBzge4xsfsEkXy+aTQu5+m7DPDwbHVxjAzUgnXWR6Q=;
 b=fUsNtp4xNv+TsnGkgRSuKmBrYNjQvek4p4mNPgQpXIhD5wXhtXoLk5qeeOBBq+sL/QRiCzd14S0f6XuUS0m+kMwL8nuzdUkyY47RKm5gJU38aq0THRpjbRLf51F1PsVIHuRYP+7b6yNbOnEN5LCDhB8zp67gGX81l8RjTVCxURKemLm+uPCxdNfmCAHXUzk/8KMxOWAHwdekKOelbo+EZsOkY73OJMR3sqZPcl+jX49E+EVu77thXhMlSqeyjZ+HHsioyZlZ3aThggavBxZt6tF3Ewi2XBc1QGyaQTTHFu0IZl1I883icS1ZpfT5TI3Rc+OolcgeWC2EgK3LlF0VGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2bBzge4xsfsEkXy+aTQu5+m7DPDwbHVxjAzUgnXWR6Q=;
 b=zYCR352yGgqMNjoyG3frfYUFrLbMCu+tjRDbQQe8SImaGKsLCQTHe9eCswcPAzya+lkqVIgO00qwV1Omds31ifVCWmVObMvRGF9c/lx//m5kESBCX8Vw5+CBt+gqlc4+YXFs2WKAyxMDMbdlEIsJaASrKjWYDQUaiuhfCbtmihI=
Received: from MWHPR15CA0032.namprd15.prod.outlook.com (2603:10b6:300:ad::18)
 by BL0PR12MB2402.namprd12.prod.outlook.com (2603:10b6:207:45::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.22; Mon, 4 Oct
 2021 14:45:21 +0000
Received: from CO1NAM11FT034.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:ad:cafe::d3) by MWHPR15CA0032.outlook.office365.com
 (2603:10b6:300:ad::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.14 via Frontend
 Transport; Mon, 4 Oct 2021 14:45:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT034.mail.protection.outlook.com (10.13.174.248) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4566.14 via Frontend Transport; Mon, 4 Oct 2021 14:45:20 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Mon, 4 Oct 2021
 09:45:18 -0500
Received: from wayne-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2308.8
 via Frontend Transport; Mon, 4 Oct 2021 09:45:06 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, <Harry.Wentland@amd.com>,
 <nicholas.kazlauskas@amd.com>, <Rodrigo.Siqueira@amd.com>,
 <wayne.lin@amd.com>, <stylon.wang@amd.com>, <jude.shih@amd.com>,
 <jimmy.kizito@amd.com>, <meenakshikumar.somasundaram@amd.com>, Jimmy Kizito
 <Jimmy.Kizito@amd.com>, Wayne Lin <Wayne.Lin@amd.com>
Subject: [PATCH 18/23] drm/amd/display: Fix DIG_HPD_SELECT for USB4 display
 endpoints
Date: Mon, 4 Oct 2021 22:40:45 +0800
Message-ID: <20211004144050.3425351-19-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211004144050.3425351-1-Wayne.Lin@amd.com>
References: <20211004144050.3425351-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a0781807-0e95-48ae-f116-08d987459709
X-MS-TrafficTypeDiagnostic: BL0PR12MB2402:
X-Microsoft-Antispam-PRVS: <BL0PR12MB24028EB07AE7EEA2066DA91CFCAE9@BL0PR12MB2402.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:949;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yDaA4Mr+Et/GS9UAklpCqT/HJwP3sR9BMeeZCR/ZLJ/OyGyj7xnmd7jYdnytT7dc4OrKzFmTfkfAEDW3PaFUU2oTFz2jFoWm7hFEY43D9EXC9uMXje/mDy3cKkHkDe+ow0gLOzxrkn8lF4kqXvDNLXylGS9XXDMmlSkiAV0J+UatHUpR0zzmj0RWp/JnlFL8gr7iMtofI/VVGKRIV40AxJTWyr5O5E0LyzoROrpz48PPo43wsF0/pvsd3p4DHgAlCNtUvZ0/MKFGiYlfYhw3xklFGY4OXkEAgYBISK3pNvyxN7RKWDU/DhrfvH12/sm+l0nQ5b8S01pGrs6YdcLXDv3vSO0ZNCMJxta9TQkpj2e3mLVuzmTZFFuIoa4m+aFpSEvalkNcJIM9AU/0LZJFf+tWQKFC2BpFjjJvmWGAw5EehIQN5rZXS3hQdH5bR3tRoXRO23TypOUEcnyMNbWt/vUhdjsLSoymA+PbKvNnwYvkma69YeCsxxn9e9teegShEIPJkQw+veU22UulSh8QxId0ekoEmv1+P/iVdqY6CPP+PcQze7z2jIz+FeSCZuxwdTp7020fj35i5WZzXBHP7NAlqTdF8GXBIgdZi9j+EJNHXMGWuBrYYUbyPkZ88xh2OMTQEoXYVLZljve1mmEen2h/f285k3ytv0Iy1hp+Qz08p8KgNYYIXXYC3P4Pwi8jnFCjqsPIUG3K36GmgHTc1VweIOaHix7jd4fTJpxBXzY=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(86362001)(54906003)(508600001)(70206006)(36860700001)(316002)(47076005)(83380400001)(336012)(426003)(1076003)(2616005)(8936002)(5660300002)(81166007)(8676002)(70586007)(6666004)(4326008)(356005)(7696005)(6916009)(186003)(26005)(2906002)(82310400003)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2021 14:45:20.4671 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a0781807-0e95-48ae-f116-08d987459709
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT034.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2402
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

From: Jimmy Kizito <Jimmy.Kizito@amd.com>

[Why]
DIB_BE_CNTL<i>.DIG_HPD_SELECT selects the HPD block being used
by the display endpoint assigned to DIG<i>. In the case of USB4
display endpoints, no physical HPD block is assigned.

[How]
Setting DIB_BE_CNTL<i>.DIG_HPD_SELECT to 5 indicates that no HPD
is assigned to a display endpoint. Firmware decrements the
HPD_SELECT value by 1 before writing it to the register.

Reviewed-by: Meenakshikumar Somasundaram <meenakshikumar.somasundaram@amd.com>
Acked-by: Wayne Lin <Wayne.Lin@amd.com>
Acked-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Signed-off-by: Jimmy Kizito <Jimmy.Kizito@amd.com>
---
 .../amd/display/dc/dcn31/dcn31_dio_link_encoder.c    | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_dio_link_encoder.c b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_dio_link_encoder.c
index a5266d5999d7..8f8eee475144 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_dio_link_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_dio_link_encoder.c
@@ -388,7 +388,7 @@ static bool link_dpia_control(struct dc_context *dc_ctx,
 	dc_dmub_srv_cmd_execute(dmub);
 	dc_dmub_srv_wait_idle(dmub);
 
-	return false;
+	return true;
 }
 
 static void link_encoder_disable(struct dcn10_link_encoder *enc10)
@@ -424,7 +424,10 @@ void dcn31_link_encoder_enable_dp_output(
 		dpia_control.lanenum = (uint8_t)link_settings->lane_count;
 		dpia_control.symclk_10khz = link_settings->link_rate *
 				LINK_RATE_REF_FREQ_IN_KHZ / 10;
-		dpia_control.hpdsel = 5; /* Unused by DPIA */
+		/* DIG_BE_CNTL.DIG_HPD_SELECT set to 5 (hpdsel - 1) to indicate HPD pin
+		 * unused by DPIA.
+		 */
+		dpia_control.hpdsel = 6;
 
 		if (link) {
 			dpia_control.dpia_id = link->ddc_hw_inst;
@@ -466,7 +469,10 @@ void dcn31_link_encoder_enable_dp_mst_output(
 		dpia_control.lanenum = (uint8_t)link_settings->lane_count;
 		dpia_control.symclk_10khz = link_settings->link_rate *
 				LINK_RATE_REF_FREQ_IN_KHZ / 10;
-		dpia_control.hpdsel = 5; /* Unused by DPIA */
+		/* DIG_BE_CNTL.DIG_HPD_SELECT set to 5 (hpdsel - 1) to indicate HPD pin
+		 * unused by DPIA.
+		 */
+		dpia_control.hpdsel = 6;
 
 		if (link) {
 			dpia_control.dpia_id = link->ddc_hw_inst;
-- 
2.25.1

