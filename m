Return-Path: <SRS0=jwYW=3U=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 724EBC35246
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Jan 2020 22:17:35 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 46A9E2082E
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Jan 2020 22:17:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="sO25fFwp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46A9E2082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A95946FC48;
	Fri, 31 Jan 2020 22:17:33 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2048.outbound.protection.outlook.com [40.107.220.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0FDE66FC4E
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Jan 2020 22:17:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UqH4PvTINLDKwCu8p/rvv200qJCPO3a1xLiwRsFGycg5IhXswbW6uv1hhtoumjQZ2kqQTg4GdnNzFxygwASHJAC3peehLWTe6TeUPLe3ARL/uNHZKItUv+4Dlp3s5/9E4NhL9w6six78t2egph8WMmdkWPzhzZMOMPYOQVhWX1W48beNLsEHokj0gQAXmAkya0pMubvB5o17huAF9kytj1x7rk/de67uAwcyWa0rasRgOqu0fH9aiGOKSyHR+RzK+rAozoq+9l3tULsGvycaWGD+cme7XIYbJkDkXBgb8k8HSbLBp1TCUn6FPRhBBMGNb4OA2f3bMusBC98r6ikZCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V0vwQNGfdrnvXZUKcV+Smqa3PmgPwWfpzTxSDKynCtc=;
 b=WPGhxpQN7UT/XNXa4YCj8E/abL1A5VxLTE6xknkMPIdhwYse2v8Ukpetn049Y3U9xw2PzZCEvd4m3rlR3Aq07hzqD/swp+bmqjqLGSaZdwWpuLvK3ELESyFpKl4q/N5hVgvuwsJb3GCqXveZO49c8a7LiZGGcNUGTfbcvrLcTq9+65gVGHTjdnDUVtVpCTfXubVWztLMSGtJxVfjILFufwBY/5vMZoaUSyRqQ5/Rqk+qXO/4IgA3suR3p4Yw1ED2Nt+NWFP15DyVHJHFNkyN/15wZzQncuMHpytTLVsgAaQuKsLBunwgaCfKQFFgTtCW8xVESWvB229BwpuJn/DTfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V0vwQNGfdrnvXZUKcV+Smqa3PmgPwWfpzTxSDKynCtc=;
 b=sO25fFwpNwV35cpjMXdOlL3ZYPlBnMoXN1Dq7nnPd+GYf7jbGvWROp8IYy6za5jCoMYbYW8GaRRMi7YJocq2xGhEuUKSD8Mk+lxRdciAks0TUgifCTPuPvYiyM5PaGy4Jmc80tD7UfsZ9XakITeWM+gRgvwLdohjlsEK9/U2V3s=
Received: from DM3PR12CA0084.namprd12.prod.outlook.com (2603:10b6:0:57::28) by
 DM5PR12MB2456.namprd12.prod.outlook.com (2603:10b6:4:b4::37) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.26; Fri, 31 Jan 2020 22:17:23 +0000
Received: from CO1NAM11FT007.eop-nam11.prod.protection.outlook.com
 (2a01:111:f400:7eab::209) by DM3PR12CA0084.outlook.office365.com
 (2603:10b6:0:57::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2686.27 via Frontend
 Transport; Fri, 31 Jan 2020 22:17:23 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 CO1NAM11FT007.mail.protection.outlook.com (10.13.174.131) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2686.25 via Frontend Transport; Fri, 31 Jan 2020 22:17:22 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Fri, 31 Jan
 2020 16:17:13 -0600
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Fri, 31 Jan
 2020 16:17:13 -0600
Received: from blakha.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Fri, 31 Jan 2020 16:17:12 -0600
From: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 27/33] drm/amd/display: 3.2.71
Date: Fri, 31 Jan 2020 17:16:37 -0500
Message-ID: <20200131221643.10035-28-Bhawanpreet.Lakha@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200131221643.10035-1-Bhawanpreet.Lakha@amd.com>
References: <20200131221643.10035-1-Bhawanpreet.Lakha@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(136003)(346002)(396003)(39860400002)(428003)(199004)(189003)(5660300002)(2616005)(7696005)(6916009)(36756003)(4744005)(86362001)(316002)(54906003)(186003)(336012)(4326008)(8676002)(2906002)(81156014)(1076003)(70586007)(356004)(70206006)(81166006)(6666004)(426003)(26005)(478600001)(8936002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB2456; H:SATLEXMB01.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; A:1; MX:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5a41a251-aa69-4259-3778-08d7a69b5820
X-MS-TrafficTypeDiagnostic: DM5PR12MB2456:
X-Microsoft-Antispam-PRVS: <DM5PR12MB245604A7F67CC9A3A9F85394F9070@DM5PR12MB2456.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:296;
X-Forefront-PRVS: 029976C540
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mJCCHKJ1dDYnP+J1VHELlODK1g7Uv8Nd4M3V0fvPJUMiPpU+hH5sTvwOAPZk9tZQmzKU2ubbsrUW719GsTFO11+nFmOKTZSKHSVGBvnkAw2j/sU3FHusGd91zvHCXgJeE33FAxNE05vae5A+llcKhJxfiCu/hTqvuh5TgSl+hOa4i1Sod86OeNwXsDpWmxnZSnOMGuxzI9QmPjUoWOH9dzXcSQrDG5M3zOQVx9Qv2g95UUgmbmtdKuWD1Cuoo5BTrKKaFFgnUbNE233zBq3NLGYWZm+7sXfya1l57r+G4VCop68qBOG7hxa43jwOydL6WnbBTkZDVAGIOw/ZN41E76bALbx8Nb7o77UcSOYre6KHKTUDeflojWqpb5C7Ba7vJm3m/JBtZjYPceDHUTyz3UVXOkAQ5aB3Ed5BCGulCvjCnBOdRm2C2bHZPZr1nXgy
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2020 22:17:22.3241 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a41a251-aa69-4259-3778-08d7a69b5820
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2456
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
Cc: sunpeng.li@amd.com, rodrigo.siqueira@amd.com, Aric Cyr <aric.cyr@amd.com>,
 harry.wentland@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Aric Cyr <aric.cyr@amd.com>

Signed-off-by: Aric Cyr <aric.cyr@amd.com>
Reviewed-by: Aric Cyr <Aric.Cyr@amd.com>
Acked-by: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index c489a863f108..e52a469b4672 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -39,7 +39,7 @@
 #include "inc/hw/dmcu.h"
 #include "dml/display_mode_lib.h"
 
-#define DC_VER "3.2.70"
+#define DC_VER "3.2.71"
 
 #define MAX_SURFACES 3
 #define MAX_PLANES 6
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
