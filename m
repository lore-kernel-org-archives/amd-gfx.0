Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4AA2CCA479
	for <amd-gfx@archiver.kernel.org>; Sat, 16 Jul 2022 14:43:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 866F9112B04;
	Sat, 16 Jul 2022 14:37:17 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2085.outbound.protection.outlook.com [40.107.100.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A607A10E1EA
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Jul 2022 18:17:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LC29cnq+Q6e7FVvgxELoWdPGQ6LjneqvAjvICk1appsp2NEQmpDmlXKztEzTPQlw+W3MJ1RHW7eTvkb7nK79IhfZJkFgodpZak+vGAHI1wxUjx0qtLm/kA6/g5rAM8UTiMazlWqkm/DxMdeTIFknBb3japx0pQZjbQ2RyOqX4kfYWDd64rsd3+kzcKiQ+FLk1kKtfqkpy3Y8wn3GsYENuC4OkMb5VlnmKvvRSP33SkzELFEjCDe/uRRnLDm1mi95fAEQu/l22nXGGSDpmwB/OYtXyx+DtX1d6Pwqhcr1osKYrOz2zqt4fLhk5rLSPRqVDJIXHT5wmzYgIBYEvUaUOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PaH5ZptwTPzOWu53v2/QeAw4AB6wasKD9B3Up4NXf7o=;
 b=dXZD3Xz/+CKD07uzd+9YFNqCnjqFUr+oJD8c/heKIGYO4dedfWOwaIMOyee9w4yMycKTItmz9p4CZUUlC4ht4dTflmHD8SNbeY6hW6Ut2U/ertRn8TKJVF+6M3gE65Ix1g8Ay2gsK3a4ZBozXdXWQeDPSaHgbk9ko7yVHh6QfxfxXRi9Vt3h4NEwrgRLLprijuuuAKM2W32HT2cqmSJPYwJvHZGnCE9Bei4xUurgz8r0STOa2FZdcdPzRWbR3lJmSa01u4paCzpb/qTE9RvUXJHEfLLTHipT2T3n/TRzmzh2Hh7IFuxLEIVOXuBH/0q/+rnAcysFSZomoS8qPXztNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PaH5ZptwTPzOWu53v2/QeAw4AB6wasKD9B3Up4NXf7o=;
 b=5dwxbe1JwmEGsI02VyBd0S94G2MSMW/LpI8ei6xiBb0FypMmdtoUq0PfcszFFCI3ncStg2eXG6T6gb+oNLkrENQBh8tz6nr2quBcF9L1tVGVZcciS6BW2iivlSG7vhurlygO8401RYgIVoKeKLE8Mlcqd90XJnd3lYJW20DTiyc=
Received: from DS7PR05CA0107.namprd05.prod.outlook.com (2603:10b6:8:56::25) by
 MW3PR12MB4409.namprd12.prod.outlook.com (2603:10b6:303:2d::23) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5438.14; Fri, 15 Jul 2022 18:17:40 +0000
Received: from DM6NAM11FT024.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:56:cafe::90) by DS7PR05CA0107.outlook.office365.com
 (2603:10b6:8:56::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.7 via Frontend
 Transport; Fri, 15 Jul 2022 18:17:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT024.mail.protection.outlook.com (10.13.172.159) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5438.12 via Frontend Transport; Fri, 15 Jul 2022 18:17:40 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 15 Jul
 2022 13:17:39 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 15 Jul
 2022 11:17:39 -0700
Received: from arch-sec.hitronhub.home (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.28 via
 Frontend Transport; Fri, 15 Jul 2022 13:17:38 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 11/31] drm/amd/display: Fix hard hang if DSC is disabled
Date: Fri, 15 Jul 2022 14:16:45 -0400
Message-ID: <20220715181705.1030401-12-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.37.0
In-Reply-To: <20220715181705.1030401-1-Rodrigo.Siqueira@amd.com>
References: <20220715181705.1030401-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1c21589a-9820-4e04-3a65-08da668e4ddb
X-MS-TrafficTypeDiagnostic: MW3PR12MB4409:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5WQ2EwMaHxZ4Nu3+DK/5HlSPr8Sncat8sFtMzE0d3HCuKBERAJaIOSZio6NzEYogkiMvg4VCzIuapLkP2QhmGLvbdhgvVRPmT5t70Xje2ZMZcLyt0oA3mjSGLv8tDLsPSCQfRrqE4/vlKffPJBK3CK1qlkEu25dQIZ3YFZpp/yFhNrbgsZ9EG/camQIVbaQU8IJLCqKqfiNzzm9QtcRp4mJyj+2IQhFB5ceXNTd7xyczKRJTVj2wbk/JRX7OrmOqCb1Vn5dphpTqCVMu3+2GLmhvAl/af3+o1rDwa+zotD1Cnd4DZJwfJD14S+mnHXsRBG0MRsk2BaDH5GONCiNVRDTOkFQ6ibzWzwusgOfmrm9af8k/6uUXrYo/uGPGcrl0AETgK1iVZSAf3HnM56neffgzfq248ADkCzH6ADVzjG7mq0azNUVnjvorA8Ge81Y289fbtKO0YvBKSh1pdjzDaHJKY8ToNtfiHm1WALK0432EDMHnOOohrTZRoOl6AffHHbxnfDfDXmbhP2K873dt8q/fMPmeiXpcsMrsxhA9mlr2GSlQ+wIzc86K58QmSMzJTcKNpwG5rF0nf4Rg4KDs1ApitPog0GX4V/7mHU1+hHLi8E1d65kevfDOQ1PHGWcA3JLXSNi2iGAjlfe97FhRuevlFLd6RUcdwuACuMiQBzWJgFayyQ/7vIyJV3y9+IEOuJpZgSVonLmUMGLUOoO7GMe6bm1Heie8JpTO5vUtFXC8P/TxpBvKOcmE/0pGS/P47ighYrVO5fkqG8ZA8i+8QS8OTBirLMnhRU9/WFm5aMfzfEvVb7abn80ZQi2wALrLYz9OXwBCAwbrI0R9jPVTrstttCz3xlBx7Yaie7MR82E=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(396003)(39860400002)(136003)(376002)(346002)(40470700004)(46966006)(36840700001)(186003)(41300700001)(1076003)(86362001)(26005)(2616005)(6916009)(82310400005)(6666004)(40480700001)(54906003)(81166007)(478600001)(356005)(40460700003)(316002)(82740400003)(336012)(47076005)(36860700001)(36756003)(70586007)(70206006)(8676002)(5660300002)(83380400001)(4326008)(8936002)(426003)(2906002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2022 18:17:40.3011 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c21589a-9820-4e04-3a65-08da668e4ddb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT024.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4409
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
Cc: stylon.wang@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

We want to calculate the DTB clock values when DSC is enabled; however,
this is not the current behavior implemented in DCN32. Right now, DML is
trying to calculate DSC values even if DSC is disabled; as a result, we
can have a hard hang due to wrong clock calculation. This commit fixes
this issue by moving the calculation after the DSC check.

Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 .../dc/dml/dcn32/display_mode_vba_util_32.c   | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c
index 5a701d9df0f7..febaff7d7343 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c
@@ -1686,17 +1686,22 @@ double dml32_RequiredDTBCLK(
 		unsigned int              AudioRate,
 		unsigned int              AudioLayout)
 {
-	double PixelWordRate = PixelClock /  (OutputFormat == dm_444 ? 1 : 2);
-	double HCActive = dml_ceil(DSCSlices * dml_ceil(OutputBpp *
-			dml_ceil(HActive / DSCSlices, 1) / 8.0, 1) / 3.0, 1);
-	double HCBlank = 64 + 32 *
-			dml_ceil(AudioRate *  (AudioLayout == 1 ? 1 : 0.25) * HTotal / (PixelClock * 1000), 1);
-	double AverageTribyteRate = PixelWordRate * (HCActive + HCBlank) / HTotal;
-	double HActiveTribyteRate = PixelWordRate * HCActive / HActive;
+	double PixelWordRate;
+	double HCActive;
+	double HCBlank;
+	double AverageTribyteRate;
+	double HActiveTribyteRate;
 
 	if (DSCEnable != true)
 		return dml_max(PixelClock / 4.0 * OutputBpp / 24.0, 25.0);
 
+	PixelWordRate = PixelClock /  (OutputFormat == dm_444 ? 1 : 2);
+	HCActive = dml_ceil(DSCSlices * dml_ceil(OutputBpp *
+			dml_ceil(HActive / DSCSlices, 1) / 8.0, 1) / 3.0, 1);
+	HCBlank = 64 + 32 *
+			dml_ceil(AudioRate *  (AudioLayout == 1 ? 1 : 0.25) * HTotal / (PixelClock * 1000), 1);
+	AverageTribyteRate = PixelWordRate * (HCActive + HCBlank) / HTotal;
+	HActiveTribyteRate = PixelWordRate * HCActive / HActive;
 	return dml_max4(PixelWordRate / 4.0, AverageTribyteRate / 4.0, HActiveTribyteRate / 4.0, 25.0) * 1.002;
 }
 
-- 
2.37.0

