Return-Path: <SRS0=buuZ=D4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAB41C5DF9E
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Oct 2020 14:23:20 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 66ACE2224E
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Oct 2020 14:23:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="kjaDQElW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66ACE2224E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2A2346EDC6;
	Wed, 21 Oct 2020 14:23:19 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2040.outbound.protection.outlook.com [40.107.92.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2A5066EDC2
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Oct 2020 14:23:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KqTBjJVJwtv4hkjMaxrHzDrTBpN6stThPGbKPCp874tD05iq6207gp7CtSYUv7occ1/cKTUisZVUn6/7+isNWANNEMOWk1GGJtd00OXJ4P6v+gXsZoA2vvd/hWP3epzPwcLExACZW85iwU6NhxCk3wokNRKvyB9dgzuJTHIX/BOfAK5Cjgr3MJXDLtNtAH2VIdDWogjTE8vc2yRDdW7vmEuGN/9yzegQUmsQjkAc+J5KJ6Gw386hEe2wdSCSP2UZBt97KI7DnkQ9TZZ58g1Gaw82t8hEJRlJ0bSc9Xys0J9TgFR3DtbdAb2oo5goraJ0Cub1WSpl78YdnFP/BK9F1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LuIUJXSUE+2GjE0UnhSB1A3wo93Z57nwITnKCThFE7I=;
 b=RHWzVnWgG829COCIVQ3mN3SHowmh2ScuxWjkhSMH8e7ugHWG3MgsH1BNIcUjTrS9glhGQrDq3LhubEdFlL415XaC+FBuwXxgbfIgR9asr8zymml06iciWOn641IjZSQowS4Vujny/VoKLfGmjEhTciP/Cma1mWXI4n/uJTnVfMIFB4exD84uVmmzX5IxJVT4zlKMEMhACR7LehsXkRthA5WClh/5FBi9+oeIdR632YHKmLEt7Inz/NdhCj1mDwggihPnqKRzfoO/nSD8yi2zv6+Nh+A/3TcAEkg6RgDwWvyuV36G9GPlVlXVkoWLMfa/ydd9ob7/ftYspcEQqixFPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=none action=none header.from=amd.com; dkim=none (message not signed);
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LuIUJXSUE+2GjE0UnhSB1A3wo93Z57nwITnKCThFE7I=;
 b=kjaDQElWy8SLVHB27K1GbZ1eTYTvRfBzlYGl/oymMz9xjVXIJSooyGuNZHnSs+nH4K/Ds/OkBibvDoopKshRx1xMt2rVa82tbaeQxBTyz1j90DEBGjmwyNXknaJBxVXPLRrogrzGljbWKEfcXHJWmSA5pQCXQaz4uxphcpiv+Lo=
Received: from DM6PR07CA0072.namprd07.prod.outlook.com (2603:10b6:5:74::49) by
 BN6PR12MB1203.namprd12.prod.outlook.com (2603:10b6:404:19::18) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3499.18; Wed, 21 Oct 2020 14:23:14 +0000
Received: from DM6NAM11FT064.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:74:cafe::1d) by DM6PR07CA0072.outlook.office365.com
 (2603:10b6:5:74::49) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18 via Frontend
 Transport; Wed, 21 Oct 2020 14:23:14 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=none action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 DM6NAM11FT064.mail.protection.outlook.com (10.13.172.234) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3499.18 via Frontend Transport; Wed, 21 Oct 2020 14:23:13 +0000
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Wed, 21 Oct
 2020 09:23:12 -0500
Received: from aj-EliteDesk.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Wed, 21 Oct 2020 09:23:12 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 11/33] drm/amd/display: 3.2.107
Date: Wed, 21 Oct 2020 10:22:35 -0400
Message-ID: <20201021142257.190969-12-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201021142257.190969-1-aurabindo.pillai@amd.com>
References: <20201021142257.190969-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7a8fad1e-5240-458a-b680-08d875ccd889
X-MS-TrafficTypeDiagnostic: BN6PR12MB1203:
X-Microsoft-Antispam-PRVS: <BN6PR12MB12037AAB50EB04D4E430E64D8B1C0@BN6PR12MB1203.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:296;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zEz+J1/4Fn2ZSOZ+dL/ww+jNiu/A2/Cyrzk3m/RTRgp/ZEYlgcjOo0s4OsIPVa/9iW41t5qlJCaLf2Q/ZTU0n5CM99X+3dFTYkuB4kRi36MVLE8UCJIZQDY2BGIPIJdIeaPcbRU7Rjl2O0MgRNPyZhcBSXjlq/ve3vmN5AwpmEEiPxVZrUvNiAIJhbnj5wByn4bl1SM2k5kXEp2qJkwYy98M7UsjY189TuhMQJWYUJt88GQISFMpiDr/Y8Ez8Ardt3Mik1TVnddBc+SCzuYorbe1GwX/7WAzpuqX2w3w9Nr5STyKc2h0LcUJ2KCEovdvC7J6rUWJiLnXlLmGBm18MpZP2qWrvqdOiszcu3JyLsAGmMhSjeYUo0VXFfKR2lu2LC2AilahxXVo9/oqGVuaIA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(346002)(396003)(39860400002)(136003)(376002)(46966005)(4326008)(426003)(44832011)(2906002)(7696005)(6666004)(70206006)(70586007)(336012)(86362001)(36756003)(5660300002)(26005)(54906003)(83380400001)(316002)(82310400003)(2616005)(4744005)(1076003)(6916009)(478600001)(8676002)(356005)(82740400003)(81166007)(8936002)(47076004)(186003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2020 14:23:13.8627 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a8fad1e-5240-458a-b680-08d875ccd889
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT064.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1203
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
Cc: Aric Cyr <aric.cyr@amd.com>, Eryk.Brol@amd.com, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 Aurabindo.Pillai@amd.com, Bhawanpreet.Lakha@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Aric Cyr <aric.cyr@amd.com>

Signed-off-by: Aric Cyr <aric.cyr@amd.com>
Acked-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 3f888570ffad..daa2589464fe 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -42,7 +42,7 @@
 #include "inc/hw/dmcu.h"
 #include "dml/display_mode_lib.h"
 
-#define DC_VER "3.2.106"
+#define DC_VER "3.2.107"
 
 #define MAX_SURFACES 3
 #define MAX_PLANES 6
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
