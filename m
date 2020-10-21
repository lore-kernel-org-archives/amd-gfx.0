Return-Path: <SRS0=buuZ=D4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF940C388F9
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Oct 2020 16:09:29 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 19A482177B
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Oct 2020 16:09:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="yzQ9RZj/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19A482177B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6CA2B89402;
	Wed, 21 Oct 2020 16:09:28 +0000 (UTC)
Received: from NAM04-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr700086.outbound.protection.outlook.com [40.107.70.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7071E89402
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Oct 2020 16:09:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K2FjmdpUYCHFUBltMslYQvVVZdMTOmYr1hId8/Lf3EzoC/kRbjev1W+lqvW8pCcjNPec268C933qFa5acNZTYFPgwygk9dfkLvl8virJSW1+WFX4qGqGlSbu64kDkGnxXCqftQypqqiexcBr4Rtix5g4ht2kUZEDow559pg8s0FGDs5pIHb7Cx5qfbNLQWiWVenVbwagFYy+n584Gz8vKJWRrexSDyCKG2A5WpR+rSkBmckNi59jCV9F9UOam3whABrnYZ/R/z40zo872HL/y0Ctd6Ib9MnLRA0HJKAkIvwQXRnUpfUNs+CjPwMrliv260Aic9FYHlXN86TN9JCUMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jftAChYye/RdrbpLuUuDiYu2Dn/RQ0RmXD0weefxg50=;
 b=IFox0cN1bzQAA9s0Jy9CTcDxlD4bauIdTsW2h6oyB94ykh8/zMEi8Fs+R8Li79wEDDLEECatCTSFDPm2kNuB3dh6CQKT+MIAXwW59UpIixmgsqVbQ8uAmNieKnypQ86Kz7ILckanA8aII2TzJKzI/cvTQSc9sgbjAgXOIvEuw2+tESr9GrQ9w2Fksnk7A7zyf4ISHl6ss8rGj3zUKp26UQaFo+BUf+uEoQ/ZB7ytnx93uwJJMZQ7PcfLdUzEVy1zFvXDKuYOYZZcelqhNtwemtmMeMEe+hU+NWIBiE4Pg4bCf5cz7rk4GbHjgHugFCMSZr1gvb4TeBQ8nPEUGRTPZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=none action=none header.from=amd.com; dkim=none (message not signed);
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jftAChYye/RdrbpLuUuDiYu2Dn/RQ0RmXD0weefxg50=;
 b=yzQ9RZj/cRbK1y55TY67bamUho0TI5t/KoLrpM1XQvmGF1fQna9XQjJEhYTD/AU4l6d5XoaPhKlktG900679PfglS0GWibcK0xQBHTvW/48acrGPOStkWIyrnOUBw3RWTYmA3qquz4KX/092sc12UrdltrNiqAQD/m5rSCAwwUM=
Received: from BN8PR15CA0044.namprd15.prod.outlook.com (2603:10b6:408:80::21)
 by MW2PR12MB2460.namprd12.prod.outlook.com (2603:10b6:907:9::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.25; Wed, 21 Oct
 2020 16:09:25 +0000
Received: from BN8NAM11FT056.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:80:cafe::9b) by BN8PR15CA0044.outlook.office365.com
 (2603:10b6:408:80::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18 via Frontend
 Transport; Wed, 21 Oct 2020 16:09:25 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=none action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 BN8NAM11FT056.mail.protection.outlook.com (10.13.177.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3499.18 via Frontend Transport; Wed, 21 Oct 2020 16:09:25 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Wed, 21 Oct
 2020 11:09:24 -0500
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Wed, 21 Oct
 2020 11:09:24 -0500
Received: from hwentlanryzen.amd.com (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Wed, 21 Oct 2020 11:09:23 -0500
From: Harry Wentland <harry.wentland@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <alexander.deucher@amd.com>,
 <Roman.Li@amd.com>, <bas@basnieuwenhuizen.nl>
Subject: [PATCH] drm/amd/display: Interpret log_2(0) as 0
Date: Wed, 21 Oct 2020 12:09:22 -0400
Message-ID: <20201021160922.210403-1-harry.wentland@amd.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201020223113.310402-1-bas@basnieuwenhuizen.nl>
References: <20201020223113.310402-1-bas@basnieuwenhuizen.nl>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ad7ee89c-08f1-4e32-b0ed-08d875dbae11
X-MS-TrafficTypeDiagnostic: MW2PR12MB2460:
X-Microsoft-Antispam-PRVS: <MW2PR12MB2460A35A52A3FF66962F0BAB8C1C0@MW2PR12MB2460.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EouJHVsjWAcOoU3SghlsFfwfHiKGi7JzNVGzGDRAJA6VXPBNPT8KrupcWWb8vkBiDB21oyNne3qDc6oFpMiyetZBRXYHxmB23Tfv9WR5wm2up4S55F4RuZKzPr3Fp8XaRRG+0M3se1RJWUb2ysicN3i5DX0slwD7dhs7XUBQal7Uy4oJUShHBx+JHOf7kTCgswuI+xyZAnCR9Dw8DkCRt/TfXVD2V4Fp8x6z31iBkO5WEqfC/MB117KiyeOKZIrQLaAoaA37PxYrm9h7CDYCxDxVaqgNKX0/IlptRJAIdArjcdWZxy5W592P/jcMkggi16VoVYXEpRygU25hX14F9ljpzfyOtg09sY17UrEH+7gR+xHMVsWc330ZWmZNLxYazyJRKJQN3wL4/qaf8+cazF4vsf66ReDAbB++GlHCNlY=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(346002)(376002)(136003)(396003)(39860400002)(46966005)(1076003)(186003)(478600001)(336012)(316002)(70586007)(2906002)(44832011)(83380400001)(82310400003)(86362001)(81166007)(7696005)(82740400003)(4326008)(356005)(47076004)(70206006)(8676002)(26005)(2616005)(5660300002)(426003)(8936002)(110136005)(36756003)(2101003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2020 16:09:25.1168 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ad7ee89c-08f1-4e32-b0ed-08d875dbae11
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT056.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2460
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
Cc: Harry Wentland <harry.wentland@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Even though log(0) is technically undefined our code assumes that
log_2(0) is 0. This mirrors the current behavior of our log_2
implementation on non-Linux platforms.

Signed-off-by: Harry Wentland <harry.wentland@amd.com>
---

What's num_pkrs value is upstream Mesa providing for CHIP_VANGOGH?

I saw that problem at bringup with an internal Mesa and had this fix
for it.

Harry

 drivers/gpu/drm/amd/display/dc/basics/conversion.h | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/basics/conversion.h b/drivers/gpu/drm/amd/display/dc/basics/conversion.h
index ade785c4fdc7..da9883ec7b1c 100644
--- a/drivers/gpu/drm/amd/display/dc/basics/conversion.h
+++ b/drivers/gpu/drm/amd/display/dc/basics/conversion.h
@@ -40,7 +40,11 @@ void convert_float_matrix(
 
 static inline unsigned int log_2(unsigned int num)
 {
-	return ilog2(num);
+	/*
+	 * Technically log(0) is undefined, but our code is structured
+	 * in a way that assumes log(0) = 0
+	 */
+	return num ? ilog2(num) : num;
 }
 
 #endif
-- 
2.28.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
