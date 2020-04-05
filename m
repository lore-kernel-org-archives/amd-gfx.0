Return-Path: <SRS0=w0EQ=5V=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07A22C2BA19
	for <amd-gfx@archiver.kernel.org>; Sun,  5 Apr 2020 20:42:41 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D15472072F
	for <amd-gfx@archiver.kernel.org>; Sun,  5 Apr 2020 20:42:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="m3C8oa0b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D15472072F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8176E89EA6;
	Sun,  5 Apr 2020 20:42:40 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2054.outbound.protection.outlook.com [40.107.94.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 52F2F89EA6
 for <amd-gfx@lists.freedesktop.org>; Sun,  5 Apr 2020 20:42:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aLPcBoMWR8JvcYZvOAnpN+8Yh4rMHgtyA0bDrIPCsjZ6fNaWTaflA3UIuUIoVMGK1LyR4q1gXBIWED1kO3FnjKJTdLuGjdd7nI0FZ1+XBWimyd0ZYhiiAYvdddI4XEIJ5vXep2OV4FSrpjuAgPsaxy/UZE1hMib81RaxBPsVUc9IBJooETPLKUIsCtTSfLDq2Doc2x+dwWz9LoG4C9NqRFxz+QX6zvYrOBvHzEF4fLbF0TmkwG+91no8znXpkdAyHmMdr9wKsTQs74rmwAfyMlZnJh4hJAmId6utZk9dxZ1K5l8s10Z6S3ckJ1GgBxzhAF8M+Yre4PS8Ag5amrXdmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i4OV4JCnwA1zZ1jZTDEwPUmtA19o3G6Qx2U2scwo69I=;
 b=CxvxvMcBvsCh5ED21qnhl0EhZW7bF2idr/O9Pgh9jrjl8aqlTwPidttH8AGsfHIcdUfn9o55zaWOLJeVOvIY5k4p1qINYqHakO44WwoY6HETnpOeyBvizJWadD+LX6zXgQkpnme9o/IWedi3qyn2jjQA/q8PjJ9wMpUkdDoXp+Ba/3EPX5S0apabGE8hvNcYV+OVFtlOTgpnSWwe3015j/QMM/zAoAWwgU+asq7tC+dHaETyZ2n9aBUCU0zezRG1BNryjaIxVrkJ8107rx5Lf/8jADtCPAOePlEoP6gljTkjr/g91IWoR52ppNdIYzMSTM9+zxy+I5zUxRU3dSYvNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i4OV4JCnwA1zZ1jZTDEwPUmtA19o3G6Qx2U2scwo69I=;
 b=m3C8oa0blmV9hR0fpaCxPhsg2xdEO/ilJ3gTesHo8Ts4PCK0VLp59UI8+z1D2tetXL6hMr8M9F8u6YiotXmI3QkdJGbRjIKHAvyObTTp1QdOm217PZfDnQ6m/0MJwJox4XCNNk83ppllpADP+2cCh3+YIx2KrkPpNozUQkdQ4L0=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Rodrigo.Siqueira@amd.com; 
Received: from MW2PR12MB2524.namprd12.prod.outlook.com (2603:10b6:907:9::27)
 by MW2PR12MB2555.namprd12.prod.outlook.com (2603:10b6:907:b::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.15; Sun, 5 Apr
 2020 20:42:38 +0000
Received: from MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::91a7:e6f7:b17a:bfa5]) by MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::91a7:e6f7:b17a:bfa5%6]) with mapi id 15.20.2878.018; Sun, 5 Apr 2020
 20:42:38 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 31/36] drm/amd/display: Update DRAM watermark before checking
 to update TTU
Date: Sun,  5 Apr 2020 16:41:10 -0400
Message-Id: <20200405204115.683559-32-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200405204115.683559-1-Rodrigo.Siqueira@amd.com>
References: <20200405204115.683559-1-Rodrigo.Siqueira@amd.com>
X-ClientProxiedBy: YTXPR0101CA0049.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:1::26) To MW2PR12MB2524.namprd12.prod.outlook.com
 (2603:10b6:907:9::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from atma2.hitronhub.home (2607:fea8:56a0:11a1::4) by
 YTXPR0101CA0049.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:1::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.16 via Frontend
 Transport; Sun, 5 Apr 2020 20:42:08 +0000
X-Mailer: git-send-email 2.26.0
X-Originating-IP: [2607:fea8:56a0:11a1::4]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 426dca11-60a3-4579-2aa4-08d7d9a1cf9b
X-MS-TrafficTypeDiagnostic: MW2PR12MB2555:|MW2PR12MB2555:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW2PR12MB2555B5AA95610FA139F813F898C50@MW2PR12MB2555.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 03648EFF89
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW2PR12MB2524.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(376002)(396003)(39860400002)(366004)(346002)(136003)(1076003)(15650500001)(8676002)(6916009)(8936002)(6486002)(81156014)(81166006)(16526019)(52116002)(36756003)(2906002)(6512007)(186003)(86362001)(316002)(54906003)(6506007)(66556008)(66476007)(2616005)(66946007)(6666004)(478600001)(4326008)(5660300002);
 DIR:OUT; SFP:1101; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: b0A0FqXXlhzglqH0CJYr7Vd6LxhEK5MJN59yv5TZeOX54VdvZFsmwUdq6cwcmA7l/qSTGUjcmaivwURlE+CcZwkUc7oVuDiUkNbpx+86rxy5CwOCDPuAX2GceZ5eX/fGTf1UYK1N2YANIJ08uxjoSX4uthA8782yGypgjjf7QUKOlojckNZHL3GQDA1eL93xpxSNzTFc0UoMTrNbBdnPu4XivPv1pF2jBii9XLCyLsHZyQDBnZt9jSiNQq6eftZpK6CwmNmqUuE5QspO2tkXDYoZJK5RuLI/4x6ekeScIMJ2e9+TFO9H+9NPd+5cBB0nzeIDPal8zkrb2z9g8H7Vgy4EAmQgLMQdjx9De5x1s7K+88PboiM0yRzaLRQ9wl9wrTjWGs71TrYUgJvwrF5UwVvDN29bykH/RfvJSfzO/U0mSJaRldF6OICcFl+0vpPT
X-MS-Exchange-AntiSpam-MessageData: HozBbwi5ogKLASM9E19RhDOjr6wTj9rrslXqGui6sWjjS7ckn9l9/JAZcSoGZnXJHYBeDGT2aGccrF+yuzJVNX48+wwBRwWAbSSirEmh5yHm75ZFhqT8g3gpcxAVErWOxSKieWRsJTKDzLI3YXKMwBxX8oDocm3Jk171XA7Zj2U=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 426dca11-60a3-4579-2aa4-08d7d9a1cf9b
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2020 20:42:09.4198 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KlwpfTkxVI7O7CxQyj1DDEBM7FpRkZO0QMuUZmHj/rrKufFWM1bJADiXho54ei/VguBGq3abYnvwGShJnaBfbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2555
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
Cc: Sunpeng.Li@amd.com, Bhawanpreet.Lakha@amd.com,
 Jaehyun Chung <jaehyun.chung@amd.com>, Harry.Wentland@amd.com,
 Jun Lei <Jun.Lei@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Jaehyun Chung <jaehyun.chung@amd.com>

[Why]
In most cases, DRAM watermark is large enough that the result of the
condition to increase TTU doesn't change after DRAM watermark is
increased. However, there is are cases where the condition fails and
becomes true after DRAM watermark is increased. This results in minTTU <
DRAM watermarks which leads to PSR hang since p-state is requested but
not allowed.

[How]
Check whether to update TTU after DRAM watermark is updated.

Signed-off-by: Jaehyun Chung <jaehyun.chung@amd.com>
Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 .../gpu/drm/amd/display/dc/dml/dcn20/display_mode_vba_20v2.c   | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_mode_vba_20v2.c b/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_mode_vba_20v2.c
index 5bbbafacc720..922ab7169e52 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_mode_vba_20v2.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_mode_vba_20v2.c
@@ -2614,6 +2614,7 @@ static void dml20v2_DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndP
 
 	if (mode_lib->vba.DRAMClockChangeSupportsVActive &&
 			mode_lib->vba.MinActiveDRAMClockChangeMargin > 60) {
+		mode_lib->vba.DRAMClockChangeWatermark += 25;
 
 		for (k = 0; k < mode_lib->vba.NumberOfActivePlanes; ++k) {
 			if (mode_lib->vba.PrefetchMode[mode_lib->vba.VoltageLevel][mode_lib->vba.maxMpcComb] == 0) {
@@ -2622,7 +2623,7 @@ static void dml20v2_DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndP
 					mode_lib->vba.MinTTUVBlank[k] += 25;
 			}
 		}
-		mode_lib->vba.DRAMClockChangeWatermark += 25;
+
 		mode_lib->vba.DRAMClockChangeSupport[0][0] = dm_dram_clock_change_vactive;
 	} else if (mode_lib->vba.DummyPStateCheck &&
 			mode_lib->vba.MinActiveDRAMClockChangeMargin > 0) {
-- 
2.26.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
