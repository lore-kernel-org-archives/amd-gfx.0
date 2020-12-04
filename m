Return-Path: <SRS0=65vk=FI=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B030C4167B
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Dec 2020 21:29:50 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A1DD922AED
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Dec 2020 21:29:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1DD922AED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 324F76EC77;
	Fri,  4 Dec 2020 21:29:49 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2067.outbound.protection.outlook.com [40.107.94.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 75FD66EC77
 for <amd-gfx@lists.freedesktop.org>; Fri,  4 Dec 2020 21:29:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Huk4N8M+1khu8dc4w7uS2TVAl7nNiKuvAnt5lCk/ia5vxOYRZm/T79nupP+vqML4FShjgtymkkSBVbkBsJXfdTKi6+QiTcEU3NNxkiTSy99f811eb6YO0pJ9cRf1IYOBlwmpxMwzHZsXmeQhiMAQth4xMinB8BO9P3KJEGP/YsRVujO6auHxLtvl8/TXpeOrqNAjr+ogXoujqlE4ipC9B64zF+CfrcdLkWDUO7dAVkc8sp+5SFZglQVt0pM6RYt5FBBJcrc4vFERTYoNgRG+qmuhtV8ZFWWHKhgjfJ5AyolS/MyQXogwPxm2p3tVA0cI3aqbMODjdJhi+ZpCfMTYGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pi+5Ri10h+BxQLMcZ5LljPl7JMc7jPja7ScQx2hp+uE=;
 b=cQG9RC8npj9qA9AdKUptPBdMgWAbi3ghRx0AE+LVi5NY2RxZwP1fxjTEwIempGKxSyMhKpOoWI5hzpeSFgmXp4tnwXMfdhpwnizm38hAFaMPXGuTYgRRjXXhywYBbdzgq4UF1k3i8/KuRjLy/VnuQZNV6+t5e6e7ZQkGBM0UjPbfH3iIzGOwxeUVm1FmDtlxkopYqH11+aveuoEjqY3iM7U5NEfRYSL0/yIvFgrBnI8rVxsTSCdga5teq2nHY0H+k9mqhbfHVwysb32h6a1KzO0TBbDNCoMIDsAIaRPtblXt9eqLIdAATE7Czm7HljSPRAzGvfTfrPFCFdAA0SpTEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pi+5Ri10h+BxQLMcZ5LljPl7JMc7jPja7ScQx2hp+uE=;
 b=2P+SgvOchAUYCVwf7M6cgFCu25K1PwuLXDgKiajsqr9rGgPpXg9XBe3zQcKgvsHo9gZMBRp9vgefGVg4ppZh5FYUe0iNE2dWlPkenZJ93lV0A7Z0lUpRrN4fZn+Is7zKjOlU8z+mCxPoSGxjR34DtkGoH3znAWFc/6lAmsGo64A=
Received: from BN3PR03CA0094.namprd03.prod.outlook.com (2603:10b6:400:4::12)
 by DM6PR12MB3515.namprd12.prod.outlook.com (2603:10b6:5:15f::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.19; Fri, 4 Dec
 2020 21:29:46 +0000
Received: from BN8NAM11FT044.eop-nam11.prod.protection.outlook.com
 (2603:10b6:400:4:cafe::23) by BN3PR03CA0094.outlook.office365.com
 (2603:10b6:400:4::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.17 via Frontend
 Transport; Fri, 4 Dec 2020 21:29:46 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none
 (message not signed) header.d=none;lists.freedesktop.org; dmarc=fail
 action=none header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 165.204.84.17 as permitted sender)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 BN8NAM11FT044.mail.protection.outlook.com (10.13.177.219) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3632.17 via Frontend Transport; Fri, 4 Dec 2020 21:29:45 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 4 Dec 2020
 15:29:45 -0600
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 4 Dec 2020
 15:29:44 -0600
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Fri, 4 Dec 2020 15:29:39 -0600
From: Eryk Brol <eryk.brol@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 01/17] drm/amd/display: Implement VSIF V3 extended refresh
 rate feature
Date: Fri, 4 Dec 2020 16:28:34 -0500
Message-ID: <20201204212850.224596-2-eryk.brol@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201204212850.224596-1-eryk.brol@amd.com>
References: <20201204212850.224596-1-eryk.brol@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2fdfaa7d-3db7-4f87-c6d0-08d8989bb8b2
X-MS-TrafficTypeDiagnostic: DM6PR12MB3515:
X-Microsoft-Antispam-PRVS: <DM6PR12MB3515868AA900681074A102C7E5F10@DM6PR12MB3515.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eI4ZI/g1fZIBHl8KQA0/R7uoUh7szKymxrj05bxVs66P4hi0VgJZd/J6/fsSIM61u7Z5hrquL6SJRFGgVx7KtDdZhifxtRMBl80X1xvKPP+aGwTJI3wFnbX0zG5pa4vlZBxV9qZKsLfIn7qACmLx9l65clBOQ12HfU5aUcSIRJDfpnie4xkngr0WGZCOYcA0uxBpGKCPLgw8ggv2O3FpQTM1PBUFFL76pie5Gx1ptOmOiBtKvUbzcTnuM3oBrzMCN0yaYmYlgAjGMw726CKj+EI5yQrKPc9xWPu1ndUHSj26a9IbIEJ7QqrFEJJ5WXY4hNoiKjr1fmW32NPFW90O0l5hLO7T5mcSRSF1Qe1iidhks+0Mj/rImgFT0cLQPHVQ3xotKloMKwd44vN/hGGvqA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(39860400002)(376002)(396003)(346002)(136003)(46966005)(70586007)(356005)(44832011)(6666004)(82740400003)(70206006)(6916009)(47076004)(36756003)(1076003)(8936002)(336012)(316002)(8676002)(5660300002)(81166007)(86362001)(83380400001)(426003)(82310400003)(4326008)(2616005)(54906003)(2906002)(26005)(186003)(478600001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2020 21:29:45.8552 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fdfaa7d-3db7-4f87-c6d0-08d8989bb8b2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT044.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3515
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
Cc: Reza Amini <Reza.Amini@amd.com>, Eryk Brol <eryk.brol@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, Qingqing.Zhuo@amd.com,
 Anthony Koo <Anthony.Koo@amd.com>, Rodrigo.Siqueira@amd.com,
 Aurabindo.Pillai@amd.com, Bhawanpreet.Lakha@amd.com, bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Reza Amini <Reza.Amini@amd.com>

[Why]
Implement feature of VSIF V3

[How]
Set refresh rate MSB for extended range

Signed-off-by: Reza Amini <Reza.Amini@amd.com>
Reviewed-by: Anthony Koo <Anthony.Koo@amd.com>
Acked-by: Eryk Brol <eryk.brol@amd.com>
---
 .../amd/display/modules/freesync/freesync.c   | 100 ++++++++++++++----
 1 file changed, 82 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/modules/freesync/freesync.c b/drivers/gpu/drm/amd/display/modules/freesync/freesync.c
index 52c3cb6b439a..2decdd8a5e20 100644
--- a/drivers/gpu/drm/amd/display/modules/freesync/freesync.c
+++ b/drivers/gpu/drm/amd/display/modules/freesync/freesync.c
@@ -569,6 +569,12 @@ static void build_vrr_infopacket_data_v1(const struct mod_vrr_params *vrr,
 static void build_vrr_infopacket_data_v3(const struct mod_vrr_params *vrr,
 		struct dc_info_packet *infopacket)
 {
+	unsigned int min_refresh;
+	unsigned int max_refresh;
+	unsigned int fixed_refresh;
+	unsigned int min_programmed;
+	unsigned int max_programmed;
+
 	/* PB1 = 0x1A (24bit AMD IEEE OUI (0x00001A) - Byte 0) */
 	infopacket->sb[1] = 0x1A;
 
@@ -598,23 +604,29 @@ static void build_vrr_infopacket_data_v3(const struct mod_vrr_params *vrr,
 			vrr->state == VRR_STATE_ACTIVE_FIXED)
 		infopacket->sb[6] |= 0x04;
 
-	if (vrr->state == VRR_STATE_ACTIVE_FIXED) {
-		/* PB7 = FreeSync Minimum refresh rate (Hz) */
-		infopacket->sb[7] = (unsigned char)((vrr->fixed_refresh_in_uhz + 500000) / 1000000);
-		/* PB8 = FreeSync Maximum refresh rate (Hz) */
-		infopacket->sb[8] = (unsigned char)((vrr->fixed_refresh_in_uhz + 500000) / 1000000);
-	} else if (vrr->state == VRR_STATE_ACTIVE_VARIABLE) {
-		/* PB7 = FreeSync Minimum refresh rate (Hz) */
-		infopacket->sb[7] = (unsigned char)((vrr->min_refresh_in_uhz + 500000) / 1000000);
-		/* PB8 = FreeSync Maximum refresh rate (Hz) */
-		infopacket->sb[8] = (unsigned char)((vrr->max_refresh_in_uhz + 500000) / 1000000);
-	} else {
-		// Non-fs case, program nominal range
-		/* PB7 = FreeSync Minimum refresh rate (Hz) */
-		infopacket->sb[7] = (unsigned char)((vrr->max_refresh_in_uhz + 500000) / 1000000);
-		/* PB8 = FreeSync Maximum refresh rate (Hz) */
-		infopacket->sb[8] = (unsigned char)((vrr->max_refresh_in_uhz + 500000) / 1000000);
-	}
+	min_refresh = (vrr->min_refresh_in_uhz + 500000) / 1000000;
+	max_refresh = (vrr->max_refresh_in_uhz + 500000) / 1000000;
+	fixed_refresh = (vrr->fixed_refresh_in_uhz + 500000) / 1000000;
+
+	min_programmed = (vrr->state == VRR_STATE_ACTIVE_FIXED) ? fixed_refresh :
+			(vrr->state == VRR_STATE_ACTIVE_VARIABLE) ? min_refresh :
+			max_refresh; // Non-fs case, program nominal range
+
+	max_programmed = (vrr->state == VRR_STATE_ACTIVE_FIXED) ? fixed_refresh :
+			(vrr->state == VRR_STATE_ACTIVE_VARIABLE) ? max_refresh :
+			max_refresh;// Non-fs case, program nominal range
+
+	/* PB7 = FreeSync Minimum refresh rate (Hz) */
+	infopacket->sb[7] = min_programmed & 0xFF;
+
+	/* PB8 = FreeSync Maximum refresh rate (Hz) */
+	infopacket->sb[8] = max_programmed & 0xFF;
+
+	/* PB11 : MSB FreeSync Minimum refresh rate [Hz] - bits 15:8 */
+	infopacket->sb[11] = (min_programmed >> 8) & 0xFF;
+
+	/* PB12 : MSB FreeSync Maximum refresh rate [Hz] - bits 15:8 */
+	infopacket->sb[12] = (max_programmed >> 8) & 0xFF;
 
 	//FreeSync HDR
 	infopacket->sb[9] = 0;
@@ -733,6 +745,58 @@ static void build_vrr_infopacket_header_v2(enum signal_type signal,
 	}
 }
 
+static void build_vrr_infopacket_header_v3(enum signal_type signal,
+		struct dc_info_packet *infopacket,
+		unsigned int *payload_size)
+{
+	unsigned char version;
+
+	version = 3;
+	if (dc_is_hdmi_signal(signal)) {
+
+		/* HEADER */
+
+		/* HB0  = Packet Type = 0x83 (Source Product
+		 *	  Descriptor InfoFrame)
+		 */
+		infopacket->hb0 = DC_HDMI_INFOFRAME_TYPE_SPD;
+
+		/* HB1  = Version = 0x03 */
+		infopacket->hb1 = version;
+
+		/* HB2  = [Bits 7:5 = 0] [Bits 4:0 = Length] */
+		*payload_size = 0x10;
+		infopacket->hb2 = *payload_size - 1; //-1 for checksum
+
+	} else if (dc_is_dp_signal(signal)) {
+
+		/* HEADER */
+
+		/* HB0  = Secondary-data Packet ID = 0 - Only non-zero
+		 *	  when used to associate audio related info packets
+		 */
+		infopacket->hb0 = 0x00;
+
+		/* HB1  = Packet Type = 0x83 (Source Product
+		 *	  Descriptor InfoFrame)
+		 */
+		infopacket->hb1 = DC_HDMI_INFOFRAME_TYPE_SPD;
+
+		/* HB2  = [Bits 7:0 = Least significant eight bits -
+		 *	  For INFOFRAME, the value must be 1Bh]
+		 */
+		infopacket->hb2 = 0x1B;
+
+		/* HB3  = [Bits 7:2 = INFOFRAME SDP Version Number = 0x2]
+		 *	  [Bits 1:0 = Most significant two bits = 0x00]
+		 */
+
+		infopacket->hb3 = (version & 0x3F) << 2;
+
+		*payload_size = 0x1B;
+	}
+}
+
 static void build_vrr_infopacket_checksum(unsigned int *payload_size,
 		struct dc_info_packet *infopacket)
 {
@@ -818,7 +882,7 @@ static void build_vrr_infopacket_v3(enum signal_type signal,
 {
 	unsigned int payload_size = 0;
 
-	build_vrr_infopacket_header_v2(signal, infopacket, &payload_size);
+	build_vrr_infopacket_header_v3(signal, infopacket, &payload_size);
 	build_vrr_infopacket_data_v3(vrr, infopacket);
 
 	build_vrr_infopacket_fs2_data(app_tf, infopacket);
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
