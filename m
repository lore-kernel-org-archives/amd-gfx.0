Return-Path: <SRS0=j5hG=ET=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9DB2C63697
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Nov 2020 20:58:13 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5926E2224A
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Nov 2020 20:58:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="kdWQAb8q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5926E2224A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DC6846E844;
	Fri, 13 Nov 2020 20:58:12 +0000 (UTC)
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-eopbgr760043.outbound.protection.outlook.com [40.107.76.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5FB1D6E843
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Nov 2020 20:58:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IDCBUiJKG58RE31tpBBYBOI1ya1E9wNRqor56cPGsYzoPV33gRCNKDznU2jZh6hCOGzah8izBRolFYvpNWbwiSVR6Y2YN99J7wHzMsW/dx01A1De67xepbXVdxP6fK+UUCjVcVXE6eEA47/eI8ucSQ4gc5VaIV81OSAlqXsvLVcBuJxP2zh/zCQY6M99IdcHFZTGVWbtu9gBaPjWYoyF4SsVGp/52FQ3OoT7Wux4ZbnhjnCjzFM+T5aV/TNkQAGYqodZgo8AzHgpxHMo26mzExsU1Hqz/LIjbb75YVNJmFB9xTLP1wXJYcKP/+DiAwP8ljsrfETTCKSqWcWfSQmc6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XJtrusegIwut2MJsseEDxPyN/ZH34wu5TpsonT3fRfI=;
 b=iV/XLpcZQBYYRxNk30U+tQD6lVT2GLaCeYeYnfBQQPLMhhV/u8RhPGJBVUgZ4/xBHWcEZgHJx/O8m3NHsKFpHsrKFBj2ToMmleYvEgqlArQj/VBbSDZPsBXp8aGrON57lSQ1euD6HjaKm5trfLtuH9PhVZA9pe2tA3dCD4kCXBKucJ8HWc2/bRRGy/gDuy8wGNKHO8wfkKSG0R2550r+jsXq1OnJX7sA5YCVcSLRxDMMnFOHC5hgqy9Mf/PQVC9TtrIAejERUtetOV5ROtEFRAJRLT5vwYggxgNzXn3nVqDAvf4DCYys+S22a5Q3QNA+qs50DHBzEAUf10QLd+XjUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=none action=none header.from=amd.com; dkim=none (message not signed);
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XJtrusegIwut2MJsseEDxPyN/ZH34wu5TpsonT3fRfI=;
 b=kdWQAb8qAY4sffie4gRZU6LCkBAqutWobrgsinDvHZ4GtbnY4SfaJMB3rKdFelJjTKEkBHrNvkM9tIGe/IXW5aHxpDsOCRMsq+lKqi3PkUz62rlPDcYLF+iybsbcuLRZO26PES5S3LJpR+VEbqIc3DPB390u5SqxD6vuaa7OZtY=
Received: from DM5PR2201CA0013.namprd22.prod.outlook.com (2603:10b6:4:14::23)
 by CH2PR12MB4213.namprd12.prod.outlook.com (2603:10b6:610:a4::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21; Fri, 13 Nov
 2020 20:58:09 +0000
Received: from DM6NAM11FT067.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:14:cafe::6c) by DM5PR2201CA0013.outlook.office365.com
 (2603:10b6:4:14::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3564.25 via Frontend
 Transport; Fri, 13 Nov 2020 20:58:09 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=none action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 DM6NAM11FT067.mail.protection.outlook.com (10.13.172.76) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3541.22 via Frontend Transport; Fri, 13 Nov 2020 20:58:09 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 13 Nov
 2020 14:58:07 -0600
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 13 Nov
 2020 14:58:06 -0600
Received: from bindu-HP-EliteDesk-705-G4-MT.amd.com (10.180.168.240) by
 SATLEXMB02.amd.com (10.181.40.143) with Microsoft SMTP Server id 15.1.1979.3
 via Frontend Transport; Fri, 13 Nov 2020 14:58:05 -0600
From: Bindu Ramamurthy <bindu.r@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 12/17] drm/amd/display: [FW Promotion] Release 0.0.42
Date: Fri, 13 Nov 2020 15:56:40 -0500
Message-ID: <20201113205645.640981-13-bindu.r@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201113205645.640981-1-bindu.r@amd.com>
References: <20201113205645.640981-1-bindu.r@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 708e5814-0c09-4479-166e-08d88816d393
X-MS-TrafficTypeDiagnostic: CH2PR12MB4213:
X-Microsoft-Antispam-PRVS: <CH2PR12MB421369AE45402B4959382D46F5E60@CH2PR12MB4213.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:296;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OCZcvfApvs21FCy2sbOsTIwtTqBGJpeB5xT4lMX5OoUuFuUFGSUXc/Gss+1DCvG5gbsnbJzrl3GDo42zqc5ZKoj8X8aDEuMGoAGsEcpUhaapedtd6S3x14UnWQQqY/+3W8kpWsMNR2t2Nqz4wtN1o5Qj5r/jpc7m5GOXge2U2ETcjozuAzb+vmkNvLxUvcjp5xoTZ5EOCvhqVI8LW1w2vss5E7mtmXRP6tTtwD9y34WlmLRq/iKJWUw2lHe4kBnXd7f0AreOjkWvhCd5SWR/PJh4LiN+dt8BjG7+nU1ehgi7Rqi8Rdc4baeXgsePHKBGQTZY9zrj/cSwn94XFrqjJ+T/Q0MK8UKlM+uKSThlmAVRKG3KSghM75jcQFMw09LKPM2BaVCurTBESESC4pQUag==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(136003)(396003)(346002)(376002)(39860400002)(46966005)(7696005)(82310400003)(1076003)(83380400001)(36756003)(186003)(478600001)(2616005)(82740400003)(426003)(54906003)(5660300002)(70206006)(4744005)(70586007)(2906002)(356005)(47076004)(6916009)(86362001)(6666004)(8936002)(8676002)(81166007)(4326008)(26005)(336012)(316002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2020 20:58:09.2235 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 708e5814-0c09-4479-166e-08d88816d393
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT067.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4213
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
Cc: Anthony Koo <Anthony.Koo@amd.com>, Eryk.Brol@amd.com, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, Aurabindo.Pillai@amd.com, Bhawanpreet.Lakha@amd.com,
 bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Anthony Koo <Anthony.Koo@amd.com>

Signed-off-by: Anthony Koo <Anthony.Koo@amd.com>
Acked-by: Bindu Ramamurthy <bindu.r@amd.com>
---
 drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
index 9e6a4b4f2f1f..a49641c0f90f 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -36,10 +36,10 @@
 
 /* Firmware versioning. */
 #ifdef DMUB_EXPOSE_VERSION
-#define DMUB_FW_VERSION_GIT_HASH 0x821097815
+#define DMUB_FW_VERSION_GIT_HASH 0x52d68b82f
 #define DMUB_FW_VERSION_MAJOR 0
 #define DMUB_FW_VERSION_MINOR 0
-#define DMUB_FW_VERSION_REVISION 41
+#define DMUB_FW_VERSION_REVISION 42
 #define DMUB_FW_VERSION_TEST 0
 #define DMUB_FW_VERSION_VBIOS 0
 #define DMUB_FW_VERSION_HOTFIX 0
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
