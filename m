Return-Path: <SRS0=a8HN=AA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE1B1C433DF
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Jun 2020 20:13:10 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B3436208B8
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Jun 2020 20:13:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="XCXdDrgO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3436208B8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AC2AC8985A;
	Fri, 19 Jun 2020 20:13:02 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2061.outbound.protection.outlook.com [40.107.94.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ADF9A89354
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Jun 2020 20:13:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Otz8gAvSMUNjR1Sfvh1dPl1zsrfboMvvEtRP+UUEVNFkklPwL4JzyYGsBw5q3KQnT6aWj/jZVB/YFYeIhRBT20tUm4LDcGCoOBl5tBYI+saFCqAX0tCMwXooJZByS6xiWjqqzFnd/c7BzyEExRsO0N1/QLoK7wRhgij8ENOggVVpfrWPk5VJN0GV48hKECG2OUAEOMsqXj/GDIapBQqYJ76Kk9WQyHdo0sdYXbRNRwUl/PRoznVr5A2hk/7IO6G5q/oC97qdY/Kg13PqDy7/PTF2Thihg1fXkZLDRFyzto9n33/VmGXJ6tZFElfCCKyFBmdyMyTIWxzazRZcjxSagg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d0nx/97gsUT93z0/3InSciDwtn4DhpuAZ0pdrDtGVbY=;
 b=Aat15qy9jThXCqHSTrQO3TsNoZnYFCKaCAmfccW0MooxaBQw4XDcn9PZZTxEFupUJLejr4a917DvHwts9Mh5a57ccRr6P/KlNi2o3oqj2ccWOefDF0VmdRQFE5V7LxwFcwySmjaDxrsAtNajhXrDSL2jFzkSvPD7V6tygCDIJuewZymjkevvSMj2YLszskTBhwUnEdhgqf28NTuYsYLNQvU2XI3ZSQfEjZJvHjt3EZJlojNS1jqQAwE8krHl2m18T2yCdkR56TDFmE/SNcIKK45b5RpExuZWArs5JwiEI7AnEOkohA/bhHIK3re8+JT83BFYv4ZwLTpMQlti8ZTddg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d0nx/97gsUT93z0/3InSciDwtn4DhpuAZ0pdrDtGVbY=;
 b=XCXdDrgO7lku8aRa1FgQLPHXdnsoQKNpXlSagPDKwN2B6+apU1RWtn3WXJW3v3NutyCTE9huLQbVCqjexiuGbgKILf8isSoCRdf30G/U7nO6fhK850l6LiEZ3cgKcTkJhU1KCcpszS9n1ycYO2keI2DuCzCUFvayKZ1hi5lFqkE=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from CH2PR12MB4198.namprd12.prod.outlook.com (2603:10b6:610:7e::23)
 by CH2PR12MB4087.namprd12.prod.outlook.com (2603:10b6:610:7f::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.23; Fri, 19 Jun
 2020 20:13:01 +0000
Received: from CH2PR12MB4198.namprd12.prod.outlook.com
 ([fe80::812c:cc72:6d14:9580]) by CH2PR12MB4198.namprd12.prod.outlook.com
 ([fe80::812c:cc72:6d14:9580%8]) with mapi id 15.20.3109.021; Fri, 19 Jun 2020
 20:13:00 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 18/30] drm/amd/display: Force ODM combine on 5K+ 420 modes
Date: Fri, 19 Jun 2020 16:12:10 -0400
Message-Id: <20200619201222.2916504-19-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200619201222.2916504-1-Rodrigo.Siqueira@amd.com>
References: <20200619201222.2916504-1-Rodrigo.Siqueira@amd.com>
X-ClientProxiedBy: YTXPR0101CA0024.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::37) To CH2PR12MB4198.namprd12.prod.outlook.com
 (2603:10b6:610:7e::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from atma2.hitronhub.home (2607:fea8:56a0:f5c::9) by
 YTXPR0101CA0024.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00::37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3109.22 via Frontend Transport; Fri, 19 Jun 2020 20:12:59 +0000
X-Mailer: git-send-email 2.27.0
X-Originating-IP: [2607:fea8:56a0:f5c::9]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 10537076-1f4a-44d4-3dd6-08d8148d29cd
X-MS-TrafficTypeDiagnostic: CH2PR12MB4087:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR12MB408747B78F674526909DDFA698980@CH2PR12MB4087.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-Forefront-PRVS: 0439571D1D
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: C3aySnaMlEr/sisoEq1S5ZahdEK/7KZOOoae6A3XpXGW/xqVY2EYqy4rQg4WXRpizop26dXEwXbyUvY99JIitMp5s0Ac26QEX/Iz3Sd/OiSuZfQUAVjKgyKABOCt3IntUaGZW2PaFb7pI5G5dSRihIfV2ktG6TVGy9lELukgTjhEK1ZL9i7aMaQS+N42XAqhAoRNFivxsq2/92pJnxnZFg3KvAfAEs6cjK4mMghKOX4ZbVQwMccAu+DT2M8jpdKORQ/qD2n8XpVq0D+ktvxqkwuAXpsC1IASV50TWlO8fPw2CiYYMG6SlDbAXMNMD7XVYGmbA6gb9Ar2J2dYfct0+vsrPtEM8wrfSjv1KAjGNDy6ZVZTnVbyhAUBIbyAELCC
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB4198.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(366004)(39860400002)(136003)(396003)(346002)(4326008)(36756003)(6486002)(83380400001)(86362001)(5660300002)(8676002)(2906002)(6666004)(2616005)(6916009)(8936002)(1076003)(6506007)(66946007)(52116002)(478600001)(186003)(316002)(6512007)(54906003)(66556008)(16526019)(66476007)(44824005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: xU/gxFAh/p9ZinIHvX0rzbOzGJ42b3YbTgMlUcJTpfZ+vfK3dru9gaCk5qCk9iGUVtGfag1v6NJVXZuyAID5kPjCwgMrPYUCu+GHPYiId9jXouCsPU84qWmosqBYumIA7QRKPVZdZzUHgeZ/TiVAhiVC6a9N5EUN1sb4ycXs6plOXzx2msY59ulzfcVgFcWhD1r2ieVaQFfJJza/OmOoAwy4oBc3mqu0u/kPgkPz0t+76/SMGnqgUCrVlq0pwuMHC/TvJEptCNgXzpMg3GPrOTgWXYKgNqt5/dynvH5bYKIFnzunXT5+ZMtsBjcqVGaHLi0j1S2Oe6pyckLMShhDHM+fw+F6jOL2GLFRy70ueuYL4e0jDOOrJ8V8Mca2dvB+LePpvh0asgX7kvEdSxGsAdyc6daaoqvwZiSdKAo2TqdYx37BeF1cBzca1K6Csh3GGO8YizvL9AwAjvD0cRVBkYX1R8Mpsi9iFmWNfxJK/DRgQDmpBHc2m6UWOjHsGrE81uziHqQgi/RAO4gY3YRt4Q==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10537076-1f4a-44d4-3dd6-08d8148d29cd
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2020 20:12:59.9261 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x8gkSdbKwYXDL9innSvYdSJUxMdzzsu9egWSpcH0Ozpz3jvdGytOQcfev1fDHtOnd+bDuZS+kipCJNKELwaOVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4087
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
Cc: Charlene Liu <Charlene.Liu@amd.com>, Chris Park <Chris.Park@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, Aurabindo.Pillai@amd.com, Bhawanpreet.Lakha@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Chris Park <Chris.Park@amd.com>

[Why]
All YCbCr420 resolutions 5K and above have tiling and discoloration
issues.  The issue can be remedied by forcing ODM combine from 5K to 8K.
10K resolution requires ODM 4:1.  The mechanism of what the real problem
is, that is inherent in ODM combine programming, doesn't seem to be
pointed at singular register programming (CLK, MPC, DCSURF, etc.), and
needs more in-depth programming sequence review for these new use case
scenarios.  Until then, workaround to enable ODM combine is proposed.
While it is not our policy, HW spreadsheet also recommends turning on
ODM for these scenario to lower the voltage.

[How]
Make pixel encoding and resolution size specific workaround to enable
ODM combine on YCbCr420 high resolution modes.

Signed-off-by: Chris Park <Chris.Park@amd.com>
Reviewed-by: Charlene Liu <Charlene.Liu@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 .../drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c b/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c
index 2a32ed6682fc..5909af0a25fb 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c
@@ -3986,9 +3986,19 @@ void dml30_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
 				} else if (v->PlaneRequiredDISPCLKWithoutODMCombine > v->MaxDispclkRoundedDownToDFSGranularity) {
 					v->ODMCombineEnablePerState[i][k] = dm_odm_combine_mode_2to1;
 					v->PlaneRequiredDISPCLK = v->PlaneRequiredDISPCLKWithODMCombine2To1;
+					/*420 format workaround*/
+					if (v->HActive[k] > 7680 && v->OutputFormat[k] == dm_420) {
+						v->ODMCombineEnablePerState[i][k] = dm_odm_combine_mode_2to1;
+						v->PlaneRequiredDISPCLK = v->PlaneRequiredDISPCLKWithODMCombine2To1;
+					}
 				} else {
 					v->ODMCombineEnablePerState[i][k] = dm_odm_combine_mode_disabled;
 					v->PlaneRequiredDISPCLK = v->PlaneRequiredDISPCLKWithoutODMCombine;
+					/*420 format workaround*/
+					if (v->HActive[k] > 4096 && v->OutputFormat[k] == dm_420) {
+						v->ODMCombineEnablePerState[i][k] = dm_odm_combine_mode_2to1;
+						v->PlaneRequiredDISPCLK = v->PlaneRequiredDISPCLKWithODMCombine2To1;
+					}
 				}
 
 				if (v->ODMCombineEnablePerState[i][k] == dm_odm_combine_mode_4to1) {
-- 
2.27.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
