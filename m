Return-Path: <SRS0=b/N7=3C=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB6EBC33CAD
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Jan 2020 10:16:40 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 738202080D
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Jan 2020 10:16:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="qEpbojEl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 738202080D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1280889D9A;
	Mon, 13 Jan 2020 10:16:40 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2086.outbound.protection.outlook.com [40.107.244.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B358789D9A
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Jan 2020 10:16:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kUEXx3E7zMPUzwpE8uwOTQdGWKF84hVsfpJFROrWYoL+IjskX2NeVXzXGpKWCR9kZtPdaUyGuntJGmllpWiedIY53l6dTiLjg+2ofy7Avp/VSxLzrN09YdxrtqQzzVfk12FuKNFf83QbTAF/BC+CDpkOtiNG1A49a1CNS3rDpM4hT/mJ0EAK7avAVAMoCYflwdzUHLv+lwSiFNl+zXT5+OKOcOaF0eunLAcZRMYgWx9c8OaXjogitDWuDgVqqj+71PCk8v0jYXAktQ6xmclF1Yudh/Jz6lCHv1gBQfIAuH/nbT0UJU+p+8czNqUNSl6gSGdj3fcStKIEW7h1HOZN3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U//CYk0hAr1IJ1UQauCdzrNsSL73QNs4rK1p1tN0M6c=;
 b=cAmxQSpvuYt6+HV/piVviiy6dQF5NjojnWzSYDWBrLHcjDpAD3ZpWwpznPUKiwB3YBcY4Y0x87/GQBDbbL9jEhTxrofjXuH3GsG70NE97+aqDNyYeftq63DTwwwf1yFQ3WCFOjbq9QJTvmzO/EsvyLkSgAsMBFtdOw/Wbgmm2b/xAvEnc3Zp6YAzSJHwD+W/GTlAcvTwjlkA0GeefsFc2I4xn+GHGyNHO3Z/urpMwc4205PWCSJD6yGuqcdewhjKySmcR8SwKUsAhrLe9emJYgvG/zVye96128SZ6Cv+pdE8Xyo7I36LlBuAMGlahR8ph6n0fWVLU3Yf9hp+gEOKkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U//CYk0hAr1IJ1UQauCdzrNsSL73QNs4rK1p1tN0M6c=;
 b=qEpbojEl63c2DnL1h7UBCYl4sfNchPMjuLiWpvVkb+qe+renqWHXTm9D/xcIF0rEGQ/qVQAxLcyM3QcvbKuO1+pACDKHwjDzTocNldoWnYNUBUaUoSMQIbGGlrVyKPZ1Mf4SvqGorh5ShvNgBefShHI9lwMVkwgECVvMm7GMH18=
Received: from MN2PR12CA0029.namprd12.prod.outlook.com (2603:10b6:208:a8::42)
 by DM5PR12MB1915.namprd12.prod.outlook.com (2603:10b6:3:10c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2623.13; Mon, 13 Jan
 2020 10:16:37 +0000
Received: from DM6NAM11FT052.eop-nam11.prod.protection.outlook.com
 (2a01:111:f400:7eaa::202) by MN2PR12CA0029.outlook.office365.com
 (2603:10b6:208:a8::42) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2623.11 via Frontend
 Transport; Mon, 13 Jan 2020 10:16:37 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 DM6NAM11FT052.mail.protection.outlook.com (10.13.172.111) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2623.9 via Frontend Transport; Mon, 13 Jan 2020 10:16:37 +0000
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Mon, 13 Jan
 2020 04:16:36 -0600
Received: from gc-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB02.amd.com (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5
 via Frontend Transport; Mon, 13 Jan 2020 04:16:34 -0600
From: chen gong <curry.gong@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/2] drm/amdgpu: reading CP_MEM_SLP_CNTL register using
 RREG32_KIQ macro
Date: Mon, 13 Jan 2020 18:16:22 +0800
Message-ID: <1578910582-4505-2-git-send-email-curry.gong@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1578910582-4505-1-git-send-email-curry.gong@amd.com>
References: <1578910582-4505-1-git-send-email-curry.gong@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(346002)(136003)(396003)(376002)(428003)(189003)(199004)(4744005)(478600001)(5660300002)(2906002)(356004)(6666004)(316002)(2616005)(8936002)(70206006)(70586007)(86362001)(26005)(81166006)(4326008)(186003)(426003)(336012)(7696005)(36756003)(6916009)(8676002)(81156014);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB1915; H:SATLEXMB01.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; MX:1; A:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 028e0ddf-7728-4f68-0933-08d79811ac98
X-MS-TrafficTypeDiagnostic: DM5PR12MB1915:
X-Microsoft-Antispam-PRVS: <DM5PR12MB1915ADFA45D3FEF12840DECB9D350@DM5PR12MB1915.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1360;
X-Forefront-PRVS: 028166BF91
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iv9NwOljwzepGIhAle4Hf/+gq04ZIabaaTmxQPwnsz+oKxANEApufqsRfcFBpnVkSi7quToiyMNvQH3UtWA8Por/bwHK674cNkSirSKlFrVwc5vWqdcAht0rn3FxkRvGivs511G7HnJY4aPGyyx9PdFG0iDcBeP75JhPqkvHP3hR+PVZgeW/Bt4LnvoZHOE6xRYYXKJfRbaqC/T1uFATiX0k8juT4MpZyuEHeAMA3tGOWnIUH3tvfmxiFnPFAtNNxEVYJO7dcXjvgt1Ahi1QfeOLtLsSabb0ZkhxXYwmwqskvVJPizd9MKkEaeguyj/3NO4RxlhYCCT9kbgfLr3iv32H93udHY+Ogp549UbxRJ7ehes8812l+a3OL2CdVHG9yBFySmTtNi+VFjbuOVd2xfnPccjOk+ladg0W1quofwstgjxxXuQ6CksIPxpvxH/p
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2020 10:16:37.2914 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 028e0ddf-7728-4f68-0933-08d79811ac98
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1915
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
Cc: chen gong <curry.gong@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Reading CP_MEM_SLP_CNTL register with RREG32_SOC15 macro will lead to
hang when GPU is in "gfxoff" state.

Signed-off-by: chen gong <curry.gong@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index e3d466b..a666086 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -4702,7 +4702,7 @@ static void gfx_v9_0_get_clockgating_state(void *handle, u32 *flags)
 		*flags |= AMD_CG_SUPPORT_GFX_RLC_LS | AMD_CG_SUPPORT_GFX_MGLS;
 
 	/* AMD_CG_SUPPORT_GFX_CP_LS */
-	data = RREG32_SOC15(GC, 0, mmCP_MEM_SLP_CNTL);
+	data = RREG32_KIQ(SOC15_REG_OFFSET(GC, 0, mmCP_MEM_SLP_CNTL));
 	if (data & CP_MEM_SLP_CNTL__CP_MEM_LS_EN_MASK)
 		*flags |= AMD_CG_SUPPORT_GFX_CP_LS | AMD_CG_SUPPORT_GFX_MGLS;
 
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
