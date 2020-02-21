Return-Path: <SRS0=HRUr=4J=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99878C35657
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Feb 2020 16:04:20 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6EFBA2067D
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Feb 2020 16:04:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="s5S2ITIG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6EFBA2067D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E641C6F4BA;
	Fri, 21 Feb 2020 16:04:19 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2069.outbound.protection.outlook.com [40.107.92.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5468E6F4B4
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Feb 2020 16:04:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cVMoOba+HHropfxBdtGWamn43nNnUHGZvpH1aqi/W4TlnDNMAWNPVTT+JwTbV5EuFk/TmDPXEViB82gQw06zL3AC7toGbxbFoNhaWIVqv2x26RO0c9CXnt3ppq7qMh6NxVbZyz0w2bDRbzab+awEAvYyd6tp1eAgkesUKNFwL/b9gwhu7ZlUrRQbve/ErVKAJ0J5sCYXXMtenGOIesqYt8M1b9mRszwcFqGjq5FP8A8hD5XvqBIYoedw/4pagYOybP3DuAO1hG0BRbEcqVtnzuH+rhU29LXh7Hxg6cCcoVcRrqR+uby9RL7Zf/nAHA7sUHrccAcdK2CfxeJyqJvLlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hR1+AS+/Glt77E2la2LZ6DdydWkxj8jVAGWSnPvnZLw=;
 b=fSVnbcYR2vny8YA5WR+bjyOH6gBpQJc1kbUKftJayS29Z06PThfv3sJ1BhCLg135U/+EcUiYIXvDpr95NnrU/9eapnoIpY9ATbZQeENsx7Y4kU3hUDh25Ycsvgvq4oGYtRDZ0LCoF5mS6ytoQ6G6ITBwNEIZEmg83XikQ7nrgo5l/rn2cRrC1FzCi7BMqMh6k61FDTB2Kj1zTi26sAPiHHH3R/exXpbEsd7zrVtCLwCmOK3gxbSCLfZ2NjRS0w8iAuUH0GsM1UTrbzhS345apg31DraZAlWjK/aViPwq9VTrbL/QzHk5+cfwChKVGgmm+Kvqq7aUfIxZWTC1uWhLhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hR1+AS+/Glt77E2la2LZ6DdydWkxj8jVAGWSnPvnZLw=;
 b=s5S2ITIGAnJRSpTGE7s6Xoe+ywYNF2chTRfw1enkJaplkEb34miX9OTo+U4Xn1xVkzJn1hfdzem8S2YKKE3Z4GVTeNKL6PlQQAbXMSS6WEbrSf4XCkz1DxYqh9M8EzHe+NLzzJLNoiyoHn7LdiFLPDDOz/iWNAn0sxnPUo8wT0s=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Rodrigo.Siqueira@amd.com; 
Received: from MW2PR12MB2524.namprd12.prod.outlook.com (2603:10b6:907:9::27)
 by MW2PR12MB2409.namprd12.prod.outlook.com (2603:10b6:907:9::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.21; Fri, 21 Feb
 2020 16:04:14 +0000
Received: from MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::b8ff:6893:5820:420f]) by MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::b8ff:6893:5820:420f%6]) with mapi id 15.20.2729.033; Fri, 21 Feb 2020
 16:04:14 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 29/35] drm/amd/display: Update TTU properly
Date: Fri, 21 Feb 2020 11:03:18 -0500
Message-Id: <20200221160324.2969975-30-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200221160324.2969975-1-Rodrigo.Siqueira@amd.com>
References: <20200221160324.2969975-1-Rodrigo.Siqueira@amd.com>
X-ClientProxiedBy: YTOPR0101CA0008.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:15::21) To MW2PR12MB2524.namprd12.prod.outlook.com
 (2603:10b6:907:9::27)
MIME-Version: 1.0
Received: from atma2.amd.com (165.204.55.250) by
 YTOPR0101CA0008.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:15::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.18 via Frontend
 Transport; Fri, 21 Feb 2020 16:04:11 +0000
X-Mailer: git-send-email 2.25.0
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 2f4156ff-9958-4a7d-499b-08d7b6e7b0ec
X-MS-TrafficTypeDiagnostic: MW2PR12MB2409:|MW2PR12MB2409:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW2PR12MB24095D969002ED77BCEE44CF98120@MW2PR12MB2409.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-Forefront-PRVS: 0320B28BE1
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(376002)(346002)(39860400002)(136003)(396003)(189003)(199004)(16526019)(36756003)(66946007)(66476007)(7696005)(66556008)(15650500001)(6916009)(26005)(52116002)(6486002)(1076003)(5660300002)(4326008)(8936002)(81166006)(2906002)(2616005)(956004)(81156014)(54906003)(186003)(316002)(478600001)(8676002)(86362001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MW2PR12MB2409;
 H:MW2PR12MB2524.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wYt1EYB3vooHdcxP3p+0rENf90xBThf/cbRZZfPWoE75p6SwEireJBzIMFPwbhQIUAzWGokSMk0MTJzjtAxWAovK2q6WOncYBuYjOeCf82h5Mt5zpT68VGNIHSIbgtRrwbzub6p9b9klt4llrzfFbBeat6/nt3hY7lBga/fFQ5kEbV0N5eEmCMJC4OhhfnggDbXGSWd9monmD43dR7iykjbVgwjwiT6bo7wAIQoItcS5yQHdFKPh8RWwnD9zmhwCxrq7khc9j0YBqVIQ3t1RMEgDn+rBxqjYow9z8c12HWyF+nfUkgcffwoBLcbUsE2d7ywfDFC5ZfBl1/ueSvQMAr+bgfTvuhNGoncUbzcKCWwOKx6YaE+0h7s7U18CFgnsrpqgq1jNwBlsrsQnVcx5ArKwfOMyQa7P5i9TbE6JsOiXtbR5+PCs7DjZO3R70iwG
X-MS-Exchange-AntiSpam-MessageData: Gt8daE0FCZuNFhRXYSt2eAg5kgpNS2vOqhntWKxGaZePRoOkmswJoW6MURt5n9dWf5GA+CMJoF2Q4Lt5v/HhG9oC3xXntBAcU3zLj2XWsnH6z7e0Wei65MBeGaal06/Y30k8tN+VO3/+7tLJkl9z8Q==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f4156ff-9958-4a7d-499b-08d7b6e7b0ec
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2020 16:04:11.9929 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1VgFOnqgjJLjA6UDW+EOsyGrdRdVR/xfas0pCLDVVKFCUBzqNs1lJfvSYCkyErN3AfdU1jzyAiJKUY5Kmo4MtQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2409
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
Cc: Sunpeng.Li@amd.com, Harry Wentland <harry.wentland@amd.com>,
 Rodrigo.Siqueira@amd.com, Alvin Lee <alvin.lee2@amd.com>,
 Jun Lei <Jun.Lei@amd.com>, Bhawanpreet.Lakha@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Alvin Lee <alvin.lee2@amd.com>

[Why]
We need to update TTU properly if DRAMClockChangeWatermark changes. If
TTU < DRAMClockChangeWatermark, we pstate won't be allowed and we will
hang in some PSR cases.

[How]
Update TTU if DramClockChangeWatermark value increases (only if TTU was
dependent on the watermark value on the DRAMClockChangeWatermark value
in the first place).

Signed-off-by: Alvin Lee <alvin.lee2@amd.com>
Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Acked-by: Harry Wentland <harry.wentland@amd.com>
---
 .../drm/amd/display/dc/dml/dcn20/display_mode_vba_20v2.c  | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_mode_vba_20v2.c b/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_mode_vba_20v2.c
index 485a9c62ec58..5bbbafacc720 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_mode_vba_20v2.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_mode_vba_20v2.c
@@ -2614,6 +2614,14 @@ static void dml20v2_DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndP
 
 	if (mode_lib->vba.DRAMClockChangeSupportsVActive &&
 			mode_lib->vba.MinActiveDRAMClockChangeMargin > 60) {
+
+		for (k = 0; k < mode_lib->vba.NumberOfActivePlanes; ++k) {
+			if (mode_lib->vba.PrefetchMode[mode_lib->vba.VoltageLevel][mode_lib->vba.maxMpcComb] == 0) {
+				if (mode_lib->vba.DRAMClockChangeWatermark >
+				dml_max(mode_lib->vba.StutterEnterPlusExitWatermark, mode_lib->vba.UrgentWatermark))
+					mode_lib->vba.MinTTUVBlank[k] += 25;
+			}
+		}
 		mode_lib->vba.DRAMClockChangeWatermark += 25;
 		mode_lib->vba.DRAMClockChangeSupport[0][0] = dm_dram_clock_change_vactive;
 	} else if (mode_lib->vba.DummyPStateCheck &&
-- 
2.25.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
