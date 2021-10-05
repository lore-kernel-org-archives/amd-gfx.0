Return-Path: <SRS0=e3IM=OZ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A228C4332F
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Oct 2021 07:59:53 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F0F4D61354
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Oct 2021 07:59:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org F0F4D61354
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 51CAF6F5AE;
	Tue,  5 Oct 2021 07:59:52 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2058.outbound.protection.outlook.com [40.107.243.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ECE6C6F5AF
 for <amd-gfx@lists.freedesktop.org>; Tue,  5 Oct 2021 07:59:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lkeUOivEyshGsLI7vT18yPKminxJ0KytqzUsuATh2yTLAqQdPEW+2IH8zNQEhgDsM9ugLRo+aBHmFWGGzMWdqJRj0JqKl5t1p3f6DD+rh4nOvsilG+HQ9tOuUFMRwn4ZkHt6SsOujbabc+g4iPh/yzg3+vuKQSflfMMOAUNB+SxPS2ITnmDmStSR4dzJFh6v6Hl8FX7LZdLbdjqp39T4dPdQQjzrEylCFquy6+9ALawd8iYJ8ANep2+NXOq79wJ3r3zkmpO81KakZRD3Jjrn3Ca5y/0UQ5/pvhSGoGvZPt1+RyeZSC4iMpKhw0n0LkHZ8KV3BpYqy0scmtY4ii+8QQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2bBzge4xsfsEkXy+aTQu5+m7DPDwbHVxjAzUgnXWR6Q=;
 b=jCgY2c+Y/PMv4E7qsvgNescxRBMdRu48P/JMqEB6L0+4ANPOE2ILV8m3Ha/S3c+w7NVCovseoefbNSCa6Kzr5NZMbEt88HuP3kWhAsxHDY0t/TkyuiNijy9eFRKdKk7I3JUhnTtuWPbmBfEJnXrpdooIsCDuxtgzeGd9wvYkgwY5R0h6tnGToXuy+zoH2rxpRi0x8YrAatQu3mM9HhjNYFlfyFkftC8vC5LSLuRoiKStanpdMbuExaCve5pS2m5JEgh1iURRlg/wfIVmC912JI1qxqVGY+yMEt/OHnPacrQqhFOBGSLLoRiNmKiu6LqhZ+dRncbpBmsaBTpd+1Nhvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2bBzge4xsfsEkXy+aTQu5+m7DPDwbHVxjAzUgnXWR6Q=;
 b=ylryMEFOlg0b9OKsLpV8KuVyo/d99yoxk1fF9t14kAJ3N9JGnzHVr3+dPewrqAr+ATBn06lPHfKjTKc7SoahtbcJ9Dsa62z7xbrvNDDdprD033Z1MKfmr+3uruhbj4kYUjGtXTYjJIsAGQR+i2rcH7meEii8/SffJdcl/Eva0ec=
Received: from BN6PR13CA0001.namprd13.prod.outlook.com (2603:10b6:404:10a::11)
 by BN8PR12MB3316.namprd12.prod.outlook.com (2603:10b6:408:42::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.21; Tue, 5 Oct
 2021 07:59:48 +0000
Received: from BN8NAM11FT025.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:10a:cafe::94) by BN6PR13CA0001.outlook.office365.com
 (2603:10b6:404:10a::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.7 via Frontend
 Transport; Tue, 5 Oct 2021 07:59:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT025.mail.protection.outlook.com (10.13.177.136) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4566.14 via Frontend Transport; Tue, 5 Oct 2021 07:59:48 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Tue, 5 Oct 2021
 02:59:47 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Tue, 5 Oct 2021
 00:59:46 -0700
Received: from wayne-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2308.8
 via Frontend Transport; Tue, 5 Oct 2021 02:59:34 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, <Harry.Wentland@amd.com>,
 <nicholas.kazlauskas@amd.com>, <Rodrigo.Siqueira@amd.com>,
 <wayne.lin@amd.com>, <stylon.wang@amd.com>, <jude.shih@amd.com>,
 <jimmy.kizito@amd.com>, <meenakshikumar.somasundaram@amd.com>, Jimmy Kizito
 <Jimmy.Kizito@amd.com>, Wayne Lin <Wayne.Lin@amd.com>
Subject: [PATCH v2 18/23] drm/amd/display: Fix DIG_HPD_SELECT for USB4 display
 endpoints
Date: Tue, 5 Oct 2021 15:52:00 +0800
Message-ID: <20211005075205.3467938-19-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211005075205.3467938-1-Wayne.Lin@amd.com>
References: <20211005075205.3467938-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e70f92df-d6e8-4450-b627-08d987d61a1f
X-MS-TrafficTypeDiagnostic: BN8PR12MB3316:
X-Microsoft-Antispam-PRVS: <BN8PR12MB33161D78EBCBDA2E07689095FCAF9@BN8PR12MB3316.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:949;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dvy/A7sBk16k/3MXyvb+vSrC2w41VyOzN/jcdYsEoGEpkPwrtzWr3HNdmvC9+iniGRZjZy6sl3PQ6CGUR/foiYzPekrWrepYGoF0fvu8CNIvNAfKC+ZARJ4X+/wqwAGSnORZJ1NVwK0s4Hj8266FVWvqvvn0kQGs3A3Y9r3zb+Lo9jrWKRcQquYvLUWxdtCc9lrFekqVQ9LKDjunga4rFS5IolyDvQNpoiKDR5DkQEEYZYv8gg9uZaOfU5ugO6yGMBr8qrhaXmfKntL0ZBTFEcHBGxICSNe/ySKaskvKVoaCeIzFnpa8YUby+usRr46xc96AMBMfdJW8v8ePBjUMk1UEA+W8jWm96lGEh+hxioK67KsYHBczJsCui4U3NKnS1IXR7lS4srXGbWGaLVjTYV5HQQzrOLdedtnzMWlscgMSrdJviznIqydt1sCmg3JyLnnxLLHLJsk7sa9G7sEoDCA/quFoWx3rd71ilP876CdGz1wlhCep6uRDZg4otNHuNoskIddSOz5AzrIbLx5a5oBrR7MqCPPiLFhTIO4ej8nabk+wY/4+038obYRXHT1IgYrCjiJhQXNMYa7sekYwHtPjfEvajIhUsEWVenRMSo52+CXgNdBT/XaWHNLB5YoD7lHEx/PaO1pMoPa/pkmZXrrY2L2jmhM/cktTrm4iKkwUl17IAH8PLgajmdhHl+8+SQGyJ3+/pbwUKAieR45owLAxysWEnsnna/c+F2ebTFE=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(5660300002)(7696005)(356005)(2906002)(6916009)(81166007)(8676002)(508600001)(6666004)(186003)(26005)(1076003)(316002)(336012)(426003)(83380400001)(2616005)(82310400003)(36756003)(54906003)(4326008)(8936002)(70206006)(70586007)(47076005)(36860700001)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2021 07:59:48.0243 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e70f92df-d6e8-4450-b627-08d987d61a1f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT025.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3316
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

