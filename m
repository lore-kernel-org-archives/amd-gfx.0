Return-Path: <SRS0=i8pd=27=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DF7BC282DD
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jan 2020 14:47:31 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6385D2082E
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jan 2020 14:47:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="ZAwG2Hgx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6385D2082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BEF456EA34;
	Fri, 10 Jan 2020 14:47:28 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2061.outbound.protection.outlook.com [40.107.236.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5E6EC6EA2C
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Jan 2020 14:47:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lEm2FmhgYzcqQJnCfac2ALFikZVKEyw3mRqg7k0m/1amypDNXVlEwlMBfAzCSR6/ZO9SpAb1PU7nPhFd6OZndWIPzDMq330YxdGeYmDXAtOLJICBzywpCx5A39PozHpcrfjctEgymTcpA6EKYMrfjNZBLqjvqcE7DYDxBHEgyYwUmMrQ1PG5UmlPFonWw+2x3nUXAvbcSJLiJ/nOgZNx6zlEp9DkszNEGYb0uuSkHIIFTsZV6ZUCHN3djRbJvUlWw0x5EUUjoSquEtebv14egHt5SSJn5pkJLDip2Iov43WHcAFtl8eel2aknBnjZW0C4+8jFE47f/punrTUPzCHqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CwmwpBkg8o2xeiOIbry/T1Dp5wLVHZ+tph0ozqE7iSY=;
 b=JdN6dEPuWCES4D7pTDBm6HZGKizbwFJeXoQyitGGqWwP/c2bShEjHcRgPPDGmEhoa/LtPZc+RQJlFVXI29zN+cnh9Q2OrWcjOnb6zFX5xV/Hck8cEaGzMotv0NXBeBYplNXAaff3JeGxBwadRcKCG6I4xqN2hB7P9vJFRtpg43a63mSSzl856mOVq6eXd+3Be/W5Mj+AHujhkIHOsrhYhvMYk2veKUTQIeCMHnPbN6ijDZAtfivaSwgZr+6fnyE3ItixTvz2A8f7L/XC74p5N0XqJadWJuUp680HzzrpDE/Zitv5yWprMTlYFDFtL7Njx7yzVGNmwQM14xiZ3IScRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CwmwpBkg8o2xeiOIbry/T1Dp5wLVHZ+tph0ozqE7iSY=;
 b=ZAwG2Hgx0G9TGx/yLzQPL4zmJEe7E/265K/xMYPRFxHQvv5sG1G4z2wilKYO6RIEgf66fheUBSAp1wCK/VT/E+mN/hDD5aA34xM84YFFZUIpEZMYJknjfYcnUabGRdJVxXUy/2udJ9UHUwSTc2gtD/dyySDyx0CXflSa30/5hqQ=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Rodrigo.Siqueira@amd.com; 
Received: from MW2PR12MB2524.namprd12.prod.outlook.com (52.132.180.155) by
 MW2PR12MB2524.namprd12.prod.outlook.com (52.132.180.155) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.11; Fri, 10 Jan 2020 14:47:24 +0000
Received: from MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::699c:a877:13ef:6ae2]) by MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::699c:a877:13ef:6ae2%6]) with mapi id 15.20.2623.011; Fri, 10 Jan 2020
 14:47:24 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 04/43] drm/amd/display: fix chroma vp wa corner case
Date: Fri, 10 Jan 2020 09:46:16 -0500
Message-Id: <20200110144655.55845-5-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200110144655.55845-1-Rodrigo.Siqueira@amd.com>
References: <20200110144655.55845-1-Rodrigo.Siqueira@amd.com>
X-ClientProxiedBy: YT1PR01CA0009.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::22)
 To MW2PR12MB2524.namprd12.prod.outlook.com
 (2603:10b6:907:9::27)
MIME-Version: 1.0
Received: from atma2.amd.com (165.204.55.250) by
 YT1PR01CA0009.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.8 via Frontend Transport; Fri, 10 Jan 2020 14:47:23 +0000
X-Mailer: git-send-email 2.24.1
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: a27f7e64-46a8-4488-4bc0-08d795dc0117
X-MS-TrafficTypeDiagnostic: MW2PR12MB2524:|MW2PR12MB2524:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW2PR12MB252499D787731EFCC79FAF8198380@MW2PR12MB2524.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-Forefront-PRVS: 02788FF38E
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(346002)(39860400002)(396003)(136003)(366004)(189003)(199004)(8936002)(5660300002)(6916009)(54906003)(81156014)(6486002)(81166006)(36756003)(316002)(1076003)(2906002)(6666004)(956004)(7696005)(52116002)(478600001)(186003)(2616005)(86362001)(26005)(16526019)(66556008)(8676002)(66476007)(4326008)(66946007);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MW2PR12MB2524;
 H:MW2PR12MB2524.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3I5+KnFwDSiB4OfXCCapp/ssR5SNNBo/WZLtbI90uZBA6LxOiudKPUFMSmJlMCaXuV2ODLZwIoe41M1MEsiTQGrxdQIUmwOfEGfu/GwFwEzcxzsHJXSEviZPu9rsNbqKPVBon/cOIPWV9IX3MF9L4YbyA3JlPOQetJs1uDoc3QJ8VYly7KPkjA7vWHfqQf7ExdpwR8UTAvTihSZMPikIBTwPNYbrlGSBhZiISPlbz2S8qe28XOw7s14Pdh48+sg19MaxO57zdpy5ZPYcv1dVOsGTaXvXB/3AYVhJKyqfNA9d1gH5mstYv9cfizeSZnDQY6mHKX3WfUHG6le9j/hMvlWRSMlSrgiMsC40rkNS4FgFAPxDHNyrufBtxcH4T8T8mcE9/gN9UauW0/ZzwSzVGMkVj3ktrcyJTbqBk+usRXLIIN4DDRWzb98RGMAz0f1l
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a27f7e64-46a8-4488-4bc0-08d795dc0117
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2020 14:47:24.1291 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8uL8JJslrVKKB6IOtLRHbMxxXe5J0L5dAQPw8Fvf5uU+C47kUmad2JtxQ7AWU0pInjQcT2EzzxQSodJK7B/RSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2524
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
 Tony Cheng <Tony.Cheng@amd.com>, Harry Wentland <harry.wentland@amd.com>,
 Eric Yang <Eric.Yang2@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Eric Yang <Eric.Yang2@amd.com>

[Why]
Previous implementation we may have residual chroma address offset
if transition from wa enable -> wa disable.

[How]
Clear address offset cache when viewport updates. Also update the
vp size check condition to account for rotation angle

Signed-off-by: Eric Yang <Eric.Yang2@amd.com>
Reviewed-by: Tony Cheng <Tony.Cheng@amd.com>
Acked-by: Harry Wentland <harry.wentland@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 .../gpu/drm/amd/display/dc/dcn21/dcn21_hubp.c    | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_hubp.c b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_hubp.c
index 216ae170bc50..4d2564f79395 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_hubp.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_hubp.c
@@ -251,10 +251,20 @@ static void hubp21_apply_PLAT_54186_wa(
 			ROTATION_ANGLE, &rotation_angle,
 			H_MIRROR_EN, &h_mirror_en);
 
-	/* apply wa only for NV12 surface with scatter gather enabled with view port > 512 */
+	/* reset persistent cached data */
+	hubp21->PLAT_54186_wa_chroma_addr_offset = 0;
+	/* apply wa only for NV12 surface with scatter gather enabled with viewport > 512 along
+	 * the vertical direction*/
 	if (address->type != PLN_ADDR_TYPE_VIDEO_PROGRESSIVE ||
-			address->video_progressive.luma_addr.high_part == 0xf4
-			|| viewport_c_height <= 512)
+			address->video_progressive.luma_addr.high_part == 0xf4)
+		return;
+
+	if ((rotation_angle == 0 || rotation_angle == 180)
+			&& viewport_c_height <= 512)
+		return;
+
+	if ((rotation_angle == 90 || rotation_angle == 270)
+				&& viewport_c_width <= 512)
 		return;
 
 	switch (rotation_angle) {
-- 
2.24.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
