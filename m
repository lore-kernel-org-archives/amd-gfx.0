Return-Path: <SRS0=Kz8i=4N=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 644A0C35E03
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Feb 2020 14:33:16 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 35BA221744
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Feb 2020 14:33:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="pVKQB7Zv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35BA221744
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DD9BD6EAF0;
	Tue, 25 Feb 2020 14:33:15 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2077.outbound.protection.outlook.com [40.107.92.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A56396EAF0
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Feb 2020 14:33:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jn4EbnjrtPgnFbLpFV9r25LRTeFA12HUZtp6z+lcWydAvUb09XyzKMjNyjvUa30NpTtM0Z7W2I84p4JxUEXw7eiS2yevPRKYQjj47LTui5UlIuoHWB2gPwTBV10OsFZnyCcrTpPiBYAoGcj5hI+Dl0m4ckgNE8+6qcrLSld0FXxJC+ja9WR4uBc1AVIVPf49iIOdSEn2SLujJOsSMIjaPurC66YuR92aaMXgPPVcyfBWf2It9Xgr0tTQehMjOjSG0lTcSxMlsp5R/ZZra5v3Sz8QX4LJYeTOW3KmCO6PdrwlYCtq66BnXo6FQ0t8KnewPT2rzbPmCj2su0jaVJwRZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yd8X9MOJn7jY/1wSyG3gHaVeogSbNr50XMwEmvFf/M8=;
 b=L8lge1ctOWMXV52BT0VCZZOraI7R/Lx9ihFvmdn7KSDtmwHVIrkWXRMW0pFEaROiguKG7yvj+D259yPzYO37AOGCycgYV7Niisk7R+fZZOZuhwm/Tit3O2eUjtG6foJ9b7Us0f0nelj86OyfRymFYzOsGfkyooKCNQMyGIOY2PZDsyRGm3zi73fIfydpOq/Sb9WLjX9b09ZdQKXfroCKOeXnlBR0XkbycNjVpG0h1EkGcTeidf2b9XPLmFxrbkayMvv7GBDR7g7MHXX+mMQRf5qt7tXy02G/XbQUnyfOs8aITuDXhu83CYSP8rmb8U5ky+qb50gw1Fi6/kFYsMEb1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yd8X9MOJn7jY/1wSyG3gHaVeogSbNr50XMwEmvFf/M8=;
 b=pVKQB7ZvAOlxpZxXq09uQ+O+hOJAyPXpMsZwnTfEwghtWZOBC0v6H4zmIM5AdKFIfjT1GceDNHfi+nmWRqHTYbbnSpRW5JcyI+LgHrfcEwBT/xjlKR+xClXQRFXNzwSHQorQwEF/9lb/BFyEvZ7s2PY6c9Mo+2dL0yrT6aUMfWw=
Received: from DM5PR08CA0036.namprd08.prod.outlook.com (2603:10b6:4:60::25) by
 SN6PR12MB2621.namprd12.prod.outlook.com (2603:10b6:805:73::15) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2750.22; Tue, 25 Feb 2020 14:33:11 +0000
Received: from DM6NAM11FT005.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:60:cafe::c0) by DM5PR08CA0036.outlook.office365.com
 (2603:10b6:4:60::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.18 via Frontend
 Transport; Tue, 25 Feb 2020 14:33:11 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 DM6NAM11FT005.mail.protection.outlook.com (10.13.172.238) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2750.18 via Frontend Transport; Tue, 25 Feb 2020 14:33:11 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Tue, 25 Feb
 2020 08:32:54 -0600
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Tue, 25 Feb
 2020 08:32:54 -0600
Received: from hawzhang-System-Product-Master.amd.com (10.180.168.240) by
 SATLEXMB02.amd.com (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5
 via Frontend Transport; Tue, 25 Feb 2020 08:32:52 -0600
From: Hawking Zhang <Hawking.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, Alex Deucher <alexander.deucher@amd.com>, 
 John Clements <John.Clements@amd.com>, Evan Quan <Evan.Quan@amd.com>,
 Kenneth Feng <Kenneth.Feng@amd.com>
Subject: [PATCH 1/2] drm/amdgpu: update arcturus ppsmc header to 54.15.0
Date: Tue, 25 Feb 2020 22:32:47 +0800
Message-ID: <20200225143248.13324-1-Hawking.Zhang@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(39860400002)(396003)(346002)(376002)(428003)(199004)(189003)(6636002)(4744005)(7696005)(110136005)(1076003)(316002)(86362001)(36756003)(8936002)(81156014)(8676002)(81166006)(478600001)(5660300002)(336012)(2906002)(356004)(70206006)(70586007)(2616005)(15650500001)(186003)(4326008)(426003)(26005)(6666004);
 DIR:OUT; SFP:1101; SCL:1; SRVR:SN6PR12MB2621; H:SATLEXMB01.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; A:1; MX:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3f980cd4-9ac2-47ad-c21b-08d7b9ffa3ec
X-MS-TrafficTypeDiagnostic: SN6PR12MB2621:
X-Microsoft-Antispam-PRVS: <SN6PR12MB26215BC7AC81F1D65D33834FFCED0@SN6PR12MB2621.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1079;
X-Forefront-PRVS: 0324C2C0E2
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RESly14zazv98ohmB6chn6uHGIuqARRUY8voJDSxRkFvunSl0pNKnVusY5dtAEcV6cZfAAz/A6ggJEW4EiSttACfVsP9MToq1Xv+pfRRoqEFjqfEZb/S09lAr7zuB4xWSuevtYiXYfHuW5zqTUVs2oyJB3yy16q1MRnWRYea0gzK332/9a3ZNcjpHpN9wWqDfcnN3Se9OjNq77SZSeBArOGa4eatByAmn1aLz8yL66Fn75xZCHXvfgAP2cSwStTUHMPXxP4oF5JQcVKqhipvo+lyu/XKH4oDbSfivOD8Mfzlq+i+QBnOlBQXFOfP9hAQt+pdCli7X3gPmGYQJpj3jMi8A9lhnNUGdrlwIYg4hpSEANabcwTARFspoyD2My/xTt2x6P4cCjkPpyPC0fSyEeITlgk3CK0I8jgDBC1HRrfLMGwBVsY4ubaP8cRI/qg4
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2020 14:33:11.3266 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f980cd4-9ac2-47ad-c21b-08d7b9ffa3ec
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2621
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
Cc: Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

two new smc messages added for arcturus with pmfw 54.15.0

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/powerplay/inc/arcturus_ppsmc.h | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/powerplay/inc/arcturus_ppsmc.h b/drivers/gpu/drm/amd/powerplay/inc/arcturus_ppsmc.h
index e3291259b249..f736d773f9d6 100644
--- a/drivers/gpu/drm/amd/powerplay/inc/arcturus_ppsmc.h
+++ b/drivers/gpu/drm/amd/powerplay/inc/arcturus_ppsmc.h
@@ -110,7 +110,11 @@
 //Others
 #define PPSMC_MSG_SetMemoryChannelEnable         0x39
 
-#define PPSMC_Message_Count                      0x3A
+//OOB
+#define PPSMC_MSG_SetNumBadHbmPagesRetired	 0x3A
+
+#define PPSMC_MSG_DFCstateControl		 0x3B
+#define PPSMC_Message_Count			 0x3C
 
 typedef uint32_t PPSMC_Result;
 typedef uint32_t PPSMC_Msg;
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
