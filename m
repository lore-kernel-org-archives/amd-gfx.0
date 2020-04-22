Return-Path: <SRS0=Hoyj=6G=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64F6FC54FCB
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Apr 2020 22:08:30 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 377E42076E
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Apr 2020 22:08:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="QHpWwvch"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 377E42076E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E14516E120;
	Wed, 22 Apr 2020 22:08:29 +0000 (UTC)
Received: from NAM04-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr700085.outbound.protection.outlook.com [40.107.70.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A621889E0C
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Apr 2020 22:08:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZIG1iX/cwOVqEJVsARKXfhQguoRwuQyH8Vf8ViavYMADrRRHtBy2geJ6mf17+9ZWBJO1cmTTylY73ELTCxG5nT4HHhE6vIXSESrSX10mCoCEfa/el1zLQe2z25ZXz9b1CmIXQdIC6qz5C7/KGbM2urRqicBKU9cdlVQphp4MBFlPOeur0EXxS24W/nKDD/s1njDWgRBJriV5iCnujmq481xezDhmxks9vYzeKr1P6TXJtr5srJPNrMP3sGcTMUAg2Sd/9kD23J4S80fK8GZZ0gJ9yYkSB5Yjipg7bbdDqXFs+/rA96UqWQJDfy3N6UKLyoAbEI2q7X/ot4q7F8g8uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MbrkDAi/7MBtnI7Sp38eIFhp2oaGnAJC0zx7+Y5hC40=;
 b=fKDMRIY7VPJd8E9w0ffHHFJbVBkOZYCicY82xSjVwqJkRoKaQvLsld1yYMsSquqPYuYGRO6LeMEGFON9um0ANmVOkafghJlH9P04lhHnGBgXdYdlKhc+7SyOm0zSNHIiCjij3VuXz4Wg4kDJ3og9CjjDSpAsnpYyITd6FU07faUu7+WY8YZsrRFmVeeZ3MvL4ikB78Q+HCiTp9RJ56oLk6oYwsoveSOcLUGVcUukYa+h852ML7FMWhjzYtL+0xY5Z4m9Ktik61zPvkvur1FhB4Vrnf6D8o7u3HM4ENcu3SEnFdrjK/26zI3RaXaFo+KZPmECHQE2RxugDhEu4VZHtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MbrkDAi/7MBtnI7Sp38eIFhp2oaGnAJC0zx7+Y5hC40=;
 b=QHpWwvchVQLaFc4PzMNslXRb61HfTimiR3XFaB6iOIhz8v21KdMlEoly7caSEU5X7liNXP7jNuwRpG1X/Uty59g0qjoKnpSVoVbd1UATQH7Ndmh4n+3WV0Ix4ig48tt0an2QvSxeu65rqTBIR7Ppv1j446UinlsHScN7XLIeXGk=
Received: from CO2PR04CA0109.namprd04.prod.outlook.com (2603:10b6:104:7::11)
 by MWHPR12MB1807.namprd12.prod.outlook.com (2603:10b6:300:113::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.27; Wed, 22 Apr
 2020 22:08:22 +0000
Received: from CO1NAM11FT010.eop-nam11.prod.protection.outlook.com
 (2603:10b6:104:7:cafe::98) by CO2PR04CA0109.outlook.office365.com
 (2603:10b6:104:7::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.29 via Frontend
 Transport; Wed, 22 Apr 2020 22:08:22 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 CO1NAM11FT010.mail.protection.outlook.com (10.13.175.88) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2937.15 via Frontend Transport; Wed, 22 Apr 2020 22:08:21 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Wed, 22 Apr
 2020 17:08:19 -0500
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Wed, 22 Apr
 2020 17:08:19 -0500
Received: from aes.amd.com (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Wed, 22 Apr 2020 17:08:18 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 09/19] drm/amd/display: Change viewport limit to 12 for DCN2
Date: Wed, 22 Apr 2020 18:07:55 -0400
Message-ID: <20200422220805.15759-10-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200422220805.15759-1-aurabindo.pillai@amd.com>
References: <20200422220805.15759-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(376002)(396003)(39860400002)(346002)(136003)(428003)(46966005)(47076004)(2906002)(478600001)(5660300002)(82310400002)(82740400003)(6916009)(70586007)(81166007)(4326008)(356005)(81156014)(8676002)(336012)(26005)(8936002)(2616005)(36756003)(86362001)(54906003)(426003)(44832011)(316002)(6666004)(1076003)(7696005)(70206006)(186003);
 DIR:OUT; SFP:1101; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 813e3d72-8feb-44c1-5fa1-08d7e709abc2
X-MS-TrafficTypeDiagnostic: MWHPR12MB1807:
X-Microsoft-Antispam-PRVS: <MWHPR12MB180767C594AAB01C078558CC8BD20@MWHPR12MB1807.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3513;
X-Forefront-PRVS: 03818C953D
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ng6FflbCmUMtQp+6nlBuZtnootISph3d7ye5a3ICz3I49CENUNcj+pCPkKuptJU5JCMjNhM/G/4fh4VC0cXDcGOY0JTthhvog1kPoY82CVqzJGgzsannI35GRym7Naa2FxMuzXN9xXNnOw4eJLrXJ2YcxP6RLp3H5oqAW0AtaOFG7tLBJRgyMgjnA8HxHzbY7RTOODoT/cY6RzUtSNzKXPRfOvd02aiug4IHRqoNxSF9+/J1IZrGPLK2nY5K5RIZzg5JTnCX4yJg01CObDgmWvNhRSis/0uBa6+byx1u/kCjQ29UQ/wfNyLUS43by9asCJi9lKaTK+zbQHn9A7x0QmYf37e1i4tlY1PE8HMEaIRl0VClTeUSlcRyXbpQ8+UhvLen5yeXga3Gnw/EcUk94nJTBQRxZVa2u0GxArTTkO8Nc3w7PUx/7FkfWAGxxhKUKfpTTLPTIkh4oe/ze1d8Y5AEo9DFgfqntT5w0pwyQwkMA8mUsIq+I+FiM+RNFnFdMn1Q0bIkpSTrmvJwfTdPhA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2020 22:08:21.6979 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 813e3d72-8feb-44c1-5fa1-08d7e709abc2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1807
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
Cc: Sunpeng.Li@amd.com, Bhawanpreet.Lakha@amd.com, Sung Lee <sung.lee@amd.com>,
 Rodrigo.Siqueira@amd.com, Harry.Wentland@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Sung Lee <sung.lee@amd.com>

[WHY & HOW]
Viewport limit was set to 16 pixels due to an issue with MPO
on small viewports. This restriction does not apply and the
viewport limit can now be lowered.

Signed-off-by: Sung Lee <sung.lee@amd.com>
Reviewed-by: Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>
Acked-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_resource.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index 12f5c6881cd0..1a01c038632b 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -1064,8 +1064,8 @@ bool resource_build_scaling_params(struct pipe_ctx *pipe_ctx)
 
 	calculate_viewport(pipe_ctx);
 
-	if (pipe_ctx->plane_res.scl_data.viewport.height < 16 ||
-		pipe_ctx->plane_res.scl_data.viewport.width < 16) {
+	if (pipe_ctx->plane_res.scl_data.viewport.height < 12 ||
+		pipe_ctx->plane_res.scl_data.viewport.width < 12) {
 		if (store_h_border_left) {
 			restore_border_left_from_dst(pipe_ctx,
 				store_h_border_left);
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
