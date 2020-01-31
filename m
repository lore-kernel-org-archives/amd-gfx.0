Return-Path: <SRS0=jwYW=3U=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 865DAC35240
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Jan 2020 22:17:27 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B9BF2082E
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Jan 2020 22:17:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="ZVKrp/i8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B9BF2082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DE9536FC4A;
	Fri, 31 Jan 2020 22:17:22 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2057.outbound.protection.outlook.com [40.107.220.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 92EDD6FC3C
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Jan 2020 22:17:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UkRJjlK2PhzizAGYnYRpgItChfPrbdlm7chRbPlLLyLmbCngt/Q7iM280WEx3R8iqWJNl/RxlQjy2fGVcKE7GmX3xLG8zpfXoyjMnHbtKVfXtwqzOV/nV/dJJCohLAJ7DuE3ObDnGPNqi1yCPkKkXsyuxwqSRYtbNR1jNKSdXKMvAxAWg8jC8GHc8FuTZ4dauQryaJ8A4cyuE62QFSDABMJVYK0wPFQW2SrhKJQpZSFQH73ZAYGlkpGiqolgX80ONn9rOaET5P5hv7yHl78d6Gc01phHDA/ysoO0fKkElv5zIFT+Z0kp8wwmhVT+d+80BB5Pq0/2kZeGrL1RtcGa9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vggLN7SmcvUoo17xW8G34+vnxjMwhZ/kofQQZHC5s+E=;
 b=QiV9FHdOLGLBSauek+nsdwxUF4MUYeLg7lSKn3jdBw+zgk3t7+WM/23Kg47nRIXmB3MrqrbBMHsh8/sBrnETWtgLyV6pTGpgpoVbBjBSPbHxYvx8Q97HdkXer6tBl3MNEbAmsZngywVY9A+e2OE1tNnUvaXsA8yKEyI8Fnk9kt4koswyB1AoqsUDeP7snLR3vq5B1vM1FpxH03OlnZhBqAVkGErET9PfHGqlV4fYfcRo0HA/zYuqdzr1rI2r8fagZho61snXmJ5Lf2mThSWimIVj4oSAlV4BmqQ7oAlIVsYn6Z0zS7OBcFVjFitiOZORs4gPXaPDtcAndCjBpY5R2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vggLN7SmcvUoo17xW8G34+vnxjMwhZ/kofQQZHC5s+E=;
 b=ZVKrp/i8Ne8BQ5cN7NmoKlIi1p21Cxs/BTm7s8OuwOaoD80jsFTv62Im6Kdxfx8kcZlTESEYwjEE6VzO9zMYbHFL3GYZlw/Vp+/3XHMa3lfVLmMAt6T1G2USmrNs+MsuLpiVGsdndkIK/9zQ5jNkecBEGsASX68XGR5vhopLMnQ=
Received: from SN1PR12CA0098.namprd12.prod.outlook.com (2603:10b6:802:21::33)
 by CH2PR12MB4149.namprd12.prod.outlook.com (2603:10b6:610:7c::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2686.26; Fri, 31 Jan
 2020 22:17:17 +0000
Received: from CO1NAM11FT067.eop-nam11.prod.protection.outlook.com
 (2a01:111:f400:7eab::204) by SN1PR12CA0098.outlook.office365.com
 (2603:10b6:802:21::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2644.23 via Frontend
 Transport; Fri, 31 Jan 2020 22:17:16 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 CO1NAM11FT067.mail.protection.outlook.com (10.13.174.212) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2686.25 via Frontend Transport; Fri, 31 Jan 2020 22:17:16 +0000
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Fri, 31 Jan
 2020 16:17:07 -0600
Received: from blakha.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Fri, 31 Jan 2020 16:17:07 -0600
From: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 16/33] drm/amd/display: remove early break in
 interdependent_lock
Date: Fri, 31 Jan 2020 17:16:26 -0500
Message-ID: <20200131221643.10035-17-Bhawanpreet.Lakha@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200131221643.10035-1-Bhawanpreet.Lakha@amd.com>
References: <20200131221643.10035-1-Bhawanpreet.Lakha@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(376002)(396003)(346002)(136003)(428003)(199004)(189003)(2906002)(86362001)(356004)(2616005)(4744005)(6666004)(336012)(36756003)(70206006)(4326008)(426003)(70586007)(7696005)(8676002)(8936002)(1076003)(186003)(26005)(5660300002)(478600001)(316002)(54906003)(6916009)(81156014)(81166006);
 DIR:OUT; SFP:1101; SCL:1; SRVR:CH2PR12MB4149; H:SATLEXMB01.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; A:1; MX:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 084a533f-2a13-4450-9214-08d7a69b5486
X-MS-TrafficTypeDiagnostic: CH2PR12MB4149:
X-Microsoft-Antispam-PRVS: <CH2PR12MB4149BFEA8557B751A6E59A0AF9070@CH2PR12MB4149.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-Forefront-PRVS: 029976C540
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1YvMnZjPlVVusT+YSqSM0l6veUzOJCb8lbOsgW2Cc0FOkcJ4WnXEcnvhHRNZerSAih2wtcsBggi0SieiZyjwYfUkxDttiTmMUhpyN98gh61WjUzhFpKmblC5BSiFFL9p5qUSkW4ukVCLS1xmzjV55oCwUlTSDRRrUPDu4WvSfNCGH0YObs+JQb0iFmpR0QtLsCdcWcBwh5zicFIz9NDKw+I9lkYexUiOHVNxhRuVYWROC3pJ+z2dbjDmRTqRTfiidTlk2qKkvIQSpbEJy8HrdTHgntlPsz2zG0rn11c/pccoqoPxfNaFDOJ+aaxMhmqJJrezpwq79OQPlCBMH6cNlqUthZDJ0nfXbMib7uyjCp7yn54h/ohqbsgt9NV65fnjv5H0kzETqKLwtgSQ8iAJ2fsNkcin9p9MGNSKzguLiyL9bP8QUJbbUFBlni539Ph/
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2020 22:17:16.2840 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 084a533f-2a13-4450-9214-08d7a69b5486
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4149
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
Cc: sunpeng.li@amd.com, rodrigo.siqueira@amd.com, harry.wentland@amd.com,
 Roman Li <roman.li@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Roman Li <roman.li@amd.com>

[Why]
The break in apply_ctx_interdependent_lock() may potentially
lead to early break from the loop leaving update plane unlocked

[How]
Remove break

Signed-off-by: Roman Li <roman.li@amd.com>
Reviewed-by: Anthony Koo <Anthony.Koo@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 2208282ea6cb..7fdd82b7708a 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -778,7 +778,6 @@ void apply_ctx_interdependent_lock(struct dc *dc, struct dc_state *context, stru
 				if (!pipe_ctx->top_pipe &&
 					(pipe_ctx->plane_state || old_pipe_ctx->plane_state))
 					dc->hwss.pipe_control_lock(dc, pipe_ctx, lock);
-				break;
 			}
 		}
 	}
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
