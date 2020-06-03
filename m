Return-Path: <SRS0=8ysN=7Q=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29937C433E0
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Jun 2020 13:32:25 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A87B520679
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Jun 2020 13:32:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="3/nxmXFN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A87B520679
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 45B1989BFE;
	Wed,  3 Jun 2020 13:32:24 +0000 (UTC)
Received: from NAM04-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr700088.outbound.protection.outlook.com [40.107.70.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0A33589BFE
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 Jun 2020 13:32:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aeiEcSd3B1eLKaek1DTIs/sDINlhpdnJWZ9/XaJnrAjuDWGI++8UPYmmrASn+trxXoi30vljiPXLEOy9spZmx6OFebrIh/WssbzTl6nm9+ycnYx7UTkkdWs7i7xDuAao5n2Ft1t9s/IGhe5Zk/w7WqtTgAiTO91x6WcViPYE8SvDWxWelWSUfMrMJXpzgvKRm8RaitEc2V5wN2+6Zq+ckL/jHQcVvLHnkkZUWx7Qb4Vl2TeSdkigEKN3/lCyuk15FK+oVMfZs+uh8omvDbPws6Jy3F88NxFOZrRlFWwh+WW1AMsEt1tozemkvH07PDTXKeed+OsGEh3dLKguVV1eWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F5f1prIi3yqXundTpbsBLpep8gbokHcQquh3L/6CreU=;
 b=CMY84WYYCpFRkE+OLPQ/y8OQtiXStkqNctHSNloQhWia0/IzZk/5Zlo6hBoCOie5CnDxGWCHPWJ7x8+JKrILdgVcs6hNUc4D/snmq4uPc9Dt/VV8wQTiHwd9F8aAqpG3aJuIzRSWFM8RNOKo0kZ5NvRGIIhyZbvOo4D1ZTzbArkVuIYr4nS2fj1vJZD0ndr31+J2ox4910Bst07JS5kZz5XnVjSOh80UTXd6k/21+/t5/0VV8FGD1Vf80hNoR0gQReII7x2kdhgkQvxLfvNTepu6s2FvC8qzBCB8hpwmqrysZ7782gmuZWV2a306a+tW0Huq9FwmcaPjdj/6Atfg6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F5f1prIi3yqXundTpbsBLpep8gbokHcQquh3L/6CreU=;
 b=3/nxmXFNx0n4eoNqRvFNnybymJGFXz7BonBu3q2nwmd4OKHpKjqdakm5UjrM1ErVeSgN3ys5W/lJQND6fhZYSP3WAmYGn9sksTDAKAGapkAUoeNo3Z7Wpf+yTj1guEafewyAHsxmXsbla4dUHgi06U6mkEIfKIVRy/Q0D+EyP+M=
Received: from MWHPR04CA0042.namprd04.prod.outlook.com (2603:10b6:300:ee::28)
 by MWHPR12MB1520.namprd12.prod.outlook.com (2603:10b6:301:f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.18; Wed, 3 Jun
 2020 13:32:21 +0000
Received: from CO1NAM11FT017.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:ee:cafe::f5) by MWHPR04CA0042.outlook.office365.com
 (2603:10b6:300:ee::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.18 via Frontend
 Transport; Wed, 3 Jun 2020 13:32:21 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 CO1NAM11FT017.mail.protection.outlook.com (10.13.175.108) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3066.18 via Frontend Transport; Wed, 3 Jun 2020 13:32:20 +0000
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Wed, 3 Jun 2020
 08:32:18 -0500
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Wed, 3 Jun 2020 08:32:18 -0500
From: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/display: Only actually breakpoint if DEBUG_KERNEL_DC
 is enabled
Date: Wed, 3 Jun 2020 09:32:10 -0400
Message-ID: <20200603133210.5238-1-nicholas.kazlauskas@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(346002)(396003)(136003)(39860400002)(46966005)(426003)(336012)(316002)(186003)(2616005)(70586007)(54906003)(86362001)(83380400001)(44832011)(82310400002)(47076004)(81166007)(356005)(26005)(5660300002)(82740400003)(4744005)(478600001)(1076003)(8676002)(36756003)(8936002)(4326008)(6666004)(2906002)(6916009)(70206006);
 DIR:OUT; SFP:1101; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5c84757a-d790-4754-b73a-08d807c28b10
X-MS-TrafficTypeDiagnostic: MWHPR12MB1520:
X-Microsoft-Antispam-PRVS: <MWHPR12MB15205ECD7DA1794AD7FC47F2EC880@MWHPR12MB1520.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1201;
X-Forefront-PRVS: 04238CD941
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 41fmBcNh9C5QBI3IKqgkg8TKkvLlKXfoGcCMrvNw8KvpCljpmfltPi3ytR3oPcXRUyFiusOmibRMmfq61JWb9kZka5MGrHlmSp/11b4jWk0vtIB7es1JKQXtDFUMFX7L72lhRwC6wCtNZ7+SzOW8iQGwYtea/bbslLUtUDJGIH9Ke6s4Z6mnEBNJmNU6Ver2ixPknz4osytHWUciISQXKYh+kBn5cl2aN0sGK+BIb8czxQoESS+Nhc6UlF1xuu2m3PA3jtR6w6LLp8MHGPvslZgc1oNCpxoqucN8z9Dv4icBO4Oue0p5jhmGk79ac1cGg41db5NBuXR13ZmbG1nJeyyQ0YUHPXHURCJd+j8KC/sY9kZRIaNJpTa7wSaSC3aKqAG2Wcf1zpfJSIFc1uxzmA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2020 13:32:20.9404 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c84757a-d790-4754-b73a-08d807c28b10
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1520
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Harry Wentland <harry.wentland@amd.com>,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

To match previous behavior and to not hang the kernel if someone
accidentally builds with KGDB enabled.

Fixes: 4324a1752045 ("drm/amd/display: Make BREAK_TO_DEBUGGER() a debug print")

Cc: Harry Wentland <harry.wentland@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
---
 drivers/gpu/drm/amd/display/dc/os_types.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/os_types.h b/drivers/gpu/drm/amd/display/dc/os_types.h
index 604ceb6c0375..c3bbfe397e8d 100644
--- a/drivers/gpu/drm/amd/display/dc/os_types.h
+++ b/drivers/gpu/drm/amd/display/dc/os_types.h
@@ -111,7 +111,7 @@
 #define ASSERT(expr) WARN_ON_ONCE(!(expr))
 #endif
 
-#if defined(CONFIG_HAVE_KGDB) || defined(CONFIG_KGDB)
+#if defined(CONFIG_DEBUG_KERNEL_DC) && (defined(CONFIG_HAVE_KGDB) || defined(CONFIG_KGDB))
 #define BREAK_TO_DEBUGGER() \
 	do { \
 		DRM_DEBUG_DRIVER("%s():%d\n", __func__, __LINE__); \
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
