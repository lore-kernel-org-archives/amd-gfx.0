Return-Path: <SRS0=jp5v=GS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85D2CC433E0
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Jan 2021 17:31:42 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3AF66206D4
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Jan 2021 17:31:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3AF66206D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BD6CB89468;
	Fri, 15 Jan 2021 17:31:41 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2064.outbound.protection.outlook.com [40.107.244.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AE082894C1
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Jan 2021 17:31:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DCkA1GC3diClO8vI9f4RQhM7IFLnotSgdIA1IjFIriDYdGTL9I6l4f2TsPL+9OYcn82uCvM12VMmxZZdm6lBT0/p52WXQ5KQsoIw1ViwVACI9t6SEHTH+UlIeEPafpqDW64+2jOZ/Ah//jlObdvBztGv9FsbkLNvfOGm5HMJ1eajIfRpKvzByqsCq2ruU4grv6RvrxgW3aPIiQ7u8J+/XdVuiZKZT86NzeR/ofX0hjMU2iF3YaLHON2w2NYa7RZeOr7COz4VJAw680OuiGEZv0BLZaP4+AF+DfMnwLjrqDtA0jd2CSRmKZIKW4uhag3vnURLZ/BybRoghb7Kt4yEzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tv2SWjbrOkkNjUeC5svLjbG7PcsJMSDLowrkt4oKDOA=;
 b=BKH+Wz/1AEkpcpHYxSOgaNJ/yYgL/p5FPR8CmW8CHKQYWilFgk+VPJ027ndYDAp/GZ07n7UVK9nl/tVbAxfNxKe37bfHesnNlIG3dYt2WzbEfBvfsZSXKptAiA9mpTR9/4yL3Hi+yzoPJHx+zfRrfl4vx4gEsj3UU6k/Z6fmBzMawznPghakzcm64LjHlBSTj3E/SMrTb+yew5tpW/I7DZmYjfUbBs7bLx5wkK7FMqn9FXWjTzd/3TBYUcKZ5catPtvzkcOvzEI11fyvkwHmGFcl/9r5NlujQ1UQLBaMrQLqM1dSyR6CagggNhnSP3OEGYKSAE+2V92MuE/tZIAOxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tv2SWjbrOkkNjUeC5svLjbG7PcsJMSDLowrkt4oKDOA=;
 b=Rx3MP/cfdoyXt3jjp+SE1bzEimfvKuyCvefz4Z8K0ghtDcr9lfgetCh55CdQp/veNKmYEMWEd26gzN0jXf7H5wDCKoTrItyaawnjqFzwWiV45JpvO7FrtZRjO7HwYF4LMTmygvj2ArIzZ3tlNfV+uhwrsuRpd1gBLM4jAGxzS6c=
Received: from BN6PR08CA0077.namprd08.prod.outlook.com (2603:10b6:404:b6::15)
 by DM5PR12MB1514.namprd12.prod.outlook.com (2603:10b6:4:f::18) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3763.9; Fri, 15 Jan 2021 17:31:37 +0000
Received: from BN8NAM11FT050.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:b6:cafe::d) by BN6PR08CA0077.outlook.office365.com
 (2603:10b6:404:b6::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.10 via Frontend
 Transport; Fri, 15 Jan 2021 17:31:37 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none
 (message not signed) header.d=none;lists.freedesktop.org; dmarc=fail
 action=none header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 165.204.84.17 as permitted sender)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 BN8NAM11FT050.mail.protection.outlook.com (10.13.177.5) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3763.12 via Frontend Transport; Fri, 15 Jan 2021 17:31:35 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 15 Jan
 2021 11:31:33 -0600
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 15 Jan
 2021 11:31:33 -0600
Received: from ajacob-ThinkPad-X250.amd.com (10.180.168.240) by
 SATLEXMB02.amd.com (10.181.40.143) with Microsoft SMTP Server id 15.1.1979.3
 via Frontend Transport; Fri, 15 Jan 2021 11:31:27 -0600
From: Anson Jacob <Anson.Jacob@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 12/16] drm/amd/display: Fix
 dml20v2_ModeSupportAndSystemConfigurationFull() to check DesiredBPP.
Date: Fri, 15 Jan 2021 12:27:14 -0500
Message-ID: <20210115172714.126866-13-Anson.Jacob@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210115172714.126866-1-Anson.Jacob@amd.com>
References: <20210115172714.126866-1-Anson.Jacob@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cb759bd8-baad-4cb2-6729-08d8b97b6879
X-MS-TrafficTypeDiagnostic: DM5PR12MB1514:
X-Microsoft-Antispam-PRVS: <DM5PR12MB151404F6F13AC0228793434FEBA70@DM5PR12MB1514.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1002;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0Ml6d+fpY1AC6eFsJa7y6mLnPaoSE74AqC8q+7Hv88KrIG4Uo70xdGYS9OsiazISOlCd2LzMMi63GzLftNBjwUh/OS0+oSZ7oeObEKTZsVKZjQloaQSUnzYMNRaHUIHHzi3aSEliMrblMTKukB4VcInRfyxZ2Mdl070DbQPn5RG43hPcoXT/B3hhwC1gVmT0m/aEv8gSaKsVWxucPsEBVBHqo+9X98bLTPMaN8N3DUWxAIQvrh5TuZRmnWNKKXQoS4fTVTCTvk/O/CGESRPp1/EpS2kpbrG+QHd//qz6yG/t8jA8gnpUYWhpV632L7tCj22GwE0jtf7QjeKpPYn+XQ4c9VZxeWpHU802tmW9Iq0FOaPe+RbMLNeABU6lkl4cLu33E9sPGJSL/ogUsKsPc9k8v+SRmO1FgtRwEJHySY3pXQj0vZLWowHfhPgj1D9epmPoPSBeJffjGWAqpBasfHBUN0ZSj+ltZoZgan4H3w+NpGuY55JdBrdtcHdUk3oxpsOeHIqmty2XC3eqP6LOrA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(4636009)(136003)(376002)(396003)(346002)(39860400002)(46966006)(336012)(8676002)(54906003)(4326008)(83380400001)(6916009)(186003)(70586007)(47076005)(26005)(2616005)(356005)(1076003)(34020700004)(81166007)(36756003)(8936002)(82740400003)(6666004)(426003)(2906002)(5660300002)(478600001)(7696005)(82310400003)(86362001)(316002)(70206006)(213903007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2021 17:31:35.7378 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cb759bd8-baad-4cb2-6729-08d8b97b6879
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT050.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1514
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
Cc: Eryk.Brol@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 Anson Jacob <anson.jacob@amd.com>, Aurabindo.Pillai@amd.com,
 Bing Guo <bing.guo@amd.com>, Jun
 Lei <Jun.Lei@amd.com>, Bhawanpreet.Lakha@amd.com, bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Bing Guo <bing.guo@amd.com>

Why:
dml20v2_ModeSupportAndSystemConfigurationFull() didn't check against
DesiredBPP, so it doesn't work correctly when DesiredBPP can't be satisfied.

How:
Port the TruncToValidBPP() version from display_mode_vba_21.c to
display_mode_vba_20v2.c.

Signed-off-by: Bing Guo <bing.guo@amd.com>
Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Acked-by: Anson Jacob <anson.jacob@amd.com>
---
 .../dc/dml/dcn20/display_mode_vba_20v2.c      | 117 ++++++++++++------
 1 file changed, 79 insertions(+), 38 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_mode_vba_20v2.c b/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_mode_vba_20v2.c
index 80170f9721ce..47e8e71113ee 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_mode_vba_20v2.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_mode_vba_20v2.c
@@ -3263,6 +3263,7 @@ static void CalculateFlipSchedule(
 
 static unsigned int TruncToValidBPP(
 		double DecimalBPP,
+		double DesiredBPP,
 		bool DSCEnabled,
 		enum output_encoder_class Output,
 		enum output_format_class Format,
@@ -3270,31 +3271,31 @@ static unsigned int TruncToValidBPP(
 {
 	if (Output == dm_hdmi) {
 		if (Format == dm_420) {
-			if (DecimalBPP >= 18)
+			if (DecimalBPP >= 18 && (DesiredBPP == 0 || DesiredBPP == 18))
 				return 18;
-			else if (DecimalBPP >= 15)
+			else if (DecimalBPP >= 15 && (DesiredBPP == 0 || DesiredBPP == 15))
 				return 15;
-			else if (DecimalBPP >= 12)
+			else if (DecimalBPP >= 12 && (DesiredBPP == 0 || DesiredBPP == 12))
 				return 12;
 			else
 				return BPP_INVALID;
 		} else if (Format == dm_444) {
-			if (DecimalBPP >= 36)
+			if (DecimalBPP >= 36 && (DesiredBPP == 0 || DesiredBPP == 36))
 				return 36;
-			else if (DecimalBPP >= 30)
+			else if (DecimalBPP >= 30 && (DesiredBPP == 0 || DesiredBPP == 30))
 				return 30;
-			else if (DecimalBPP >= 24)
+			else if (DecimalBPP >= 24 && (DesiredBPP == 0 || DesiredBPP == 24))
 				return 24;
-			else if (DecimalBPP >= 18)
+			else if (DecimalBPP >= 18 && (DesiredBPP == 0 || DesiredBPP == 18))
 				return 18;
 			else
 				return BPP_INVALID;
 		} else {
-			if (DecimalBPP / 1.5 >= 24)
+			if (DecimalBPP / 1.5 >= 24 && (DesiredBPP == 0 || DesiredBPP == 24))
 				return 24;
-			else if (DecimalBPP / 1.5 >= 20)
+			else if (DecimalBPP / 1.5 >= 20 && (DesiredBPP == 0 || DesiredBPP == 20))
 				return 20;
-			else if (DecimalBPP / 1.5 >= 16)
+			else if (DecimalBPP / 1.5 >= 16 && (DesiredBPP == 0 || DesiredBPP == 16))
 				return 16;
 			else
 				return BPP_INVALID;
@@ -3302,53 +3303,86 @@ static unsigned int TruncToValidBPP(
 	} else {
 		if (DSCEnabled) {
 			if (Format == dm_420) {
-				if (DecimalBPP < 6)
-					return BPP_INVALID;
-				else if (DecimalBPP >= 1.5 * DSCInputBitPerComponent - 1 / 16)
-					return 1.5 * DSCInputBitPerComponent - 1 / 16;
-				else
-					return dml_floor(16 * DecimalBPP, 1) / 16;
+				if (DesiredBPP == 0) {
+					if (DecimalBPP < 6)
+						return BPP_INVALID;
+					else if (DecimalBPP >= 1.5 * DSCInputBitPerComponent - 1.0 / 16.0)
+						return 1.5 * DSCInputBitPerComponent - 1.0 / 16.0;
+					else
+						return dml_floor(16 * DecimalBPP, 1) / 16.0;
+				} else {
+					if (DecimalBPP < 6
+							|| DesiredBPP < 6
+							|| DesiredBPP > 1.5 * DSCInputBitPerComponent - 1.0 / 16.0
+							|| DecimalBPP < DesiredBPP) {
+						return BPP_INVALID;
+					} else {
+						return DesiredBPP;
+					}
+				}
 			} else if (Format == dm_n422) {
-				if (DecimalBPP < 7)
-					return BPP_INVALID;
-				else if (DecimalBPP >= 2 * DSCInputBitPerComponent - 1 / 16)
-					return 2 * DSCInputBitPerComponent - 1 / 16;
-				else
-					return dml_floor(16 * DecimalBPP, 1) / 16;
+				if (DesiredBPP == 0) {
+					if (DecimalBPP < 7)
+						return BPP_INVALID;
+					else if (DecimalBPP >= 2 * DSCInputBitPerComponent - 1.0 / 16.0)
+						return 2 * DSCInputBitPerComponent - 1.0 / 16.0;
+					else
+						return dml_floor(16 * DecimalBPP, 1) / 16.0;
+				} else {
+					if (DecimalBPP < 7
+							|| DesiredBPP < 7
+							|| DesiredBPP > 2 * DSCInputBitPerComponent - 1.0 / 16.0
+							|| DecimalBPP < DesiredBPP) {
+						return BPP_INVALID;
+					} else {
+						return DesiredBPP;
+					}
+				}
 			} else {
-				if (DecimalBPP < 8)
-					return BPP_INVALID;
-				else if (DecimalBPP >= 3 * DSCInputBitPerComponent - 1 / 16)
-					return 3 * DSCInputBitPerComponent - 1 / 16;
-				else
-					return dml_floor(16 * DecimalBPP, 1) / 16;
+				if (DesiredBPP == 0) {
+					if (DecimalBPP < 8)
+						return BPP_INVALID;
+					else if (DecimalBPP >= 3 * DSCInputBitPerComponent - 1.0 / 16.0)
+						return 3 * DSCInputBitPerComponent - 1.0 / 16.0;
+					else
+						return dml_floor(16 * DecimalBPP, 1) / 16.0;
+				} else {
+					if (DecimalBPP < 8
+							|| DesiredBPP < 8
+							|| DesiredBPP > 3 * DSCInputBitPerComponent - 1.0 / 16.0
+							|| DecimalBPP < DesiredBPP) {
+						return BPP_INVALID;
+					} else {
+						return DesiredBPP;
+					}
+				}
 			}
 		} else if (Format == dm_420) {
-			if (DecimalBPP >= 18)
+			if (DecimalBPP >= 18 && (DesiredBPP == 0 || DesiredBPP == 18))
 				return 18;
-			else if (DecimalBPP >= 15)
+			else if (DecimalBPP >= 15 && (DesiredBPP == 0 || DesiredBPP == 15))
 				return 15;
-			else if (DecimalBPP >= 12)
+			else if (DecimalBPP >= 12 && (DesiredBPP == 0 || DesiredBPP == 12))
 				return 12;
 			else
 				return BPP_INVALID;
 		} else if (Format == dm_s422 || Format == dm_n422) {
-			if (DecimalBPP >= 24)
+			if (DecimalBPP >= 24 && (DesiredBPP == 0 || DesiredBPP == 24))
 				return 24;
-			else if (DecimalBPP >= 20)
+			else if (DecimalBPP >= 20 && (DesiredBPP == 0 || DesiredBPP == 20))
 				return 20;
-			else if (DecimalBPP >= 16)
+			else if (DecimalBPP >= 16 && (DesiredBPP == 0 || DesiredBPP == 16))
 				return 16;
 			else
 				return BPP_INVALID;
 		} else {
-			if (DecimalBPP >= 36)
+			if (DecimalBPP >= 36 && (DesiredBPP == 0 || DesiredBPP == 36))
 				return 36;
-			else if (DecimalBPP >= 30)
+			else if (DecimalBPP >= 30 && (DesiredBPP == 0 || DesiredBPP == 30))
 				return 30;
-			else if (DecimalBPP >= 24)
+			else if (DecimalBPP >= 24 && (DesiredBPP == 0 || DesiredBPP == 24))
 				return 24;
-			else if (DecimalBPP >= 18)
+			else if (DecimalBPP >= 18 && (DesiredBPP == 0 || DesiredBPP == 18))
 				return 18;
 			else
 				return BPP_INVALID;
@@ -4137,6 +4171,7 @@ void dml20v2_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode
 					locals->RequiresFEC[i][k] = 0;
 					locals->OutputBppPerState[i][k] = TruncToValidBPP(
 							dml_min(600.0, mode_lib->vba.PHYCLKPerState[i]) / mode_lib->vba.PixelClockBackEnd[k] * 24,
+							mode_lib->vba.ForcedOutputLinkBPP[k],
 							false,
 							mode_lib->vba.Output[k],
 							mode_lib->vba.OutputFormat[k],
@@ -4153,6 +4188,7 @@ void dml20v2_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode
 						mode_lib->vba.Outbpp = TruncToValidBPP(
 								(1.0 - mode_lib->vba.Downspreading / 100.0) * 270.0
 								* mode_lib->vba.OutputLinkDPLanes[k] / mode_lib->vba.PixelClockBackEnd[k] * 8.0,
+								mode_lib->vba.ForcedOutputLinkBPP[k],
 								false,
 								mode_lib->vba.Output[k],
 								mode_lib->vba.OutputFormat[k],
@@ -4160,6 +4196,7 @@ void dml20v2_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode
 						mode_lib->vba.OutbppDSC = TruncToValidBPP(
 								(1.0 - mode_lib->vba.Downspreading / 100.0) * (1.0 - mode_lib->vba.EffectiveFECOverhead / 100.0) * 270.0
 								* mode_lib->vba.OutputLinkDPLanes[k] / mode_lib->vba.PixelClockBackEnd[k] * 8.0,
+								mode_lib->vba.ForcedOutputLinkBPP[k],
 								true,
 								mode_lib->vba.Output[k],
 								mode_lib->vba.OutputFormat[k],
@@ -4182,6 +4219,7 @@ void dml20v2_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode
 						mode_lib->vba.Outbpp = TruncToValidBPP(
 								(1.0 - mode_lib->vba.Downspreading / 100.0) * 540.0
 								* mode_lib->vba.OutputLinkDPLanes[k] / mode_lib->vba.PixelClockBackEnd[k] * 8.0,
+								mode_lib->vba.ForcedOutputLinkBPP[k],
 									false,
 									mode_lib->vba.Output[k],
 									mode_lib->vba.OutputFormat[k],
@@ -4189,6 +4227,7 @@ void dml20v2_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode
 						mode_lib->vba.OutbppDSC = TruncToValidBPP(
 								(1.0 - mode_lib->vba.Downspreading / 100.0) * (1.0 - mode_lib->vba.EffectiveFECOverhead / 100.0) * 540.0
 								* mode_lib->vba.OutputLinkDPLanes[k] / mode_lib->vba.PixelClockBackEnd[k] * 8.0,
+								mode_lib->vba.ForcedOutputLinkBPP[k],
 								true,
 								mode_lib->vba.Output[k],
 								mode_lib->vba.OutputFormat[k],
@@ -4213,6 +4252,7 @@ void dml20v2_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode
 						mode_lib->vba.Outbpp = TruncToValidBPP(
 								(1.0 - mode_lib->vba.Downspreading / 100.0) * 810.0
 								* mode_lib->vba.OutputLinkDPLanes[k] / mode_lib->vba.PixelClockBackEnd[k] * 8.0,
+								mode_lib->vba.ForcedOutputLinkBPP[k],
 								false,
 								mode_lib->vba.Output[k],
 								mode_lib->vba.OutputFormat[k],
@@ -4220,6 +4260,7 @@ void dml20v2_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode
 						mode_lib->vba.OutbppDSC = TruncToValidBPP(
 								(1.0 - mode_lib->vba.Downspreading / 100.0) * (1.0 - mode_lib->vba.EffectiveFECOverhead / 100.0) * 810.0
 								* mode_lib->vba.OutputLinkDPLanes[k] / mode_lib->vba.PixelClockBackEnd[k] * 8.0,
+								mode_lib->vba.ForcedOutputLinkBPP[k],
 								true,
 								mode_lib->vba.Output[k],
 								mode_lib->vba.OutputFormat[k],
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
