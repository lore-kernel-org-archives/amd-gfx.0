Return-Path: <SRS0=r7JW=B7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72038C433DF
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Aug 2020 22:58:05 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 419132067C
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Aug 2020 22:58:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="toCrVpfh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 419132067C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0243A6EC1F;
	Fri, 21 Aug 2020 22:58:05 +0000 (UTC)
Received: from NAM02-BL2-obe.outbound.protection.outlook.com
 (mail-eopbgr750075.outbound.protection.outlook.com [40.107.75.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3D7E56EC1F
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Aug 2020 22:58:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CqwiZDqqUF5drkLQ4NW+WjflFM2z3iFfTWv05tKkFfeBUFWfSSDN5tF4ouAJZ13gbej9Zwp9bWh6Hpk/moUAjW7/itE6sxRkg2lokgKKh6tZlzbeRbNPqbg56R1N2vf+yNijCeVzcyb2l7ufewGeltw2cEa5RAycPgi51uopCJCD0VeyzgNdRO6NCN5LHeY8WxH4Ql7xLboqPJ9NB8VGPfPFrUnEqn0JkwrH0jXUwmeL7FS0Wme+hHeoRvaYEHtuj2FxzgymhHa26XeybIiCZg2tAiThkPltwm73gwMWRn9xYQvU2S3FotpcjYYIWeor5waoHKpv+0LUTj1muk7szA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eJaFkW0SEetx8Z3rCvHwI+XJZOYj2sXW6bryjq9fXE8=;
 b=nV+g4Y4XTm5uDgeelmCTzG/M4fU2aQ37uMwmH3gCZNbWzbPxXszzZNpa/r0IXA/JfJDKswOIHjByxlr+iWtrX2t4zjXInLFoZqu+1exqKAVVc8PL/QequyL5jYUTsb0+36oFszIZv0LGZrAk3yYqBVyiBymC3+6nZFvaWxl5TXXXQAnSylUaho64h+7QveY7PSorgm2syheb0wKfkX5dIDLIL7wX7IcWcHOx+lFe0TfioeDZvOdDpY4fzUl+buJgHi/4Gw0ELjhxbhq6nLC1MO1j6VwAIeuNvYbuhs2j2XdjgTZJ6qXw7Ic+UQ+/GoFaZ0InCZSx5WxlDxSNwd1d/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eJaFkW0SEetx8Z3rCvHwI+XJZOYj2sXW6bryjq9fXE8=;
 b=toCrVpfhtqmXeX687OtcgiVyyBAGc4S+rDWeES4hlLNYNL9tAw/iZUnK51Bz394CSmhNOR9DLnviziMA1vu9XaoHWEIJ1c8fBBppYGlvohH+UDyrz6wZSqRxFKuM8yRPTqgU3VHN0Rv5w9/PMxG0ZZSI1ox6zue5LuVqBzGF6hQ=
Received: from DM5PR18CA0087.namprd18.prod.outlook.com (2603:10b6:3:3::25) by
 MWHPR1201MB0062.namprd12.prod.outlook.com (2603:10b6:301:54::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.25; Fri, 21 Aug
 2020 22:57:50 +0000
Received: from DM6NAM11FT041.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:3:cafe::78) by DM5PR18CA0087.outlook.office365.com
 (2603:10b6:3:3::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.25 via Frontend
 Transport; Fri, 21 Aug 2020 22:57:49 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 DM6NAM11FT041.mail.protection.outlook.com (10.13.172.98) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3305.24 via Frontend Transport; Fri, 21 Aug 2020 22:57:49 +0000
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 21 Aug
 2020 17:57:49 -0500
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Fri, 21 Aug 2020 17:57:38 -0500
From: Eryk Brol <eryk.brol@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/9] drm/amd/display: 3.2.99
Date: Fri, 21 Aug 2020 18:57:01 -0400
Message-ID: <20200821225709.136571-2-eryk.brol@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200821225709.136571-1-eryk.brol@amd.com>
References: <20200821225709.136571-1-eryk.brol@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1f5c91fe-879c-4fa4-2a00-08d84625a0be
X-MS-TrafficTypeDiagnostic: MWHPR1201MB0062:
X-Microsoft-Antispam-PRVS: <MWHPR1201MB0062A0D02492A397DB4CBD48E55B0@MWHPR1201MB0062.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:296;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ib9mYrM89TwqGhDsy+BVTJTF4vpneChmdWBumLXb9bCsBf2nMy1g/gTG6/AJ6HrL1K/rZ2Zk7ktgssGEcZi3LxRpB9VBqS0SIMacr4UFDs8oLWD34BNlgcyJehrKVXowty/CMvONmVGOMhM16R4sfRimn+YgyboivzxzpiZNnnbBnRujRNxI5BhvIeDDBmO3MuaOuEbaLD0VsHahf401YkO/UIbNxgzGYWLyj3SMvzHAtPOK5FNgRS0H3gBFxnfZBvz+tT535ZJa43/TUoA78Svh/HAn+g+IhfeZbHpzI9sRt1eOhE8nd8FPpyw2EF5qR7CQcQR0kndnZnpNiZ7qOfI2dRGTQIUUAFnLb2zs6cvAIWFzSc7VwxQcpMMgvhad1sA4ft+O6V6m3HzPO7ezNg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(396003)(376002)(346002)(39860400002)(136003)(46966005)(4326008)(426003)(316002)(2616005)(83380400001)(82740400003)(336012)(4744005)(6916009)(1076003)(186003)(356005)(82310400002)(44832011)(47076004)(86362001)(81166007)(70206006)(5660300002)(8936002)(26005)(6666004)(54906003)(8676002)(2906002)(36756003)(70586007)(478600001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2020 22:57:49.6637 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f5c91fe-879c-4fa4-2a00-08d84625a0be
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT041.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB0062
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
Cc: Aric Cyr <Aric.Cyr@amd.com>, Eryk Brol <eryk.brol@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, Qingqing.Zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, Aurabindo.Pillai@amd.com, Bhawanpreet.Lakha@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Aric Cyr <aric.cyr@amd.com>

Signed-off-by: Aric Cyr <aric.cyr@amd.com>
Reviewed-by: Aric Cyr <Aric.Cyr@amd.com>
Acked-by: Eryk Brol <eryk.brol@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index f3ac9e3df760..1d9c8e09c08b 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -42,7 +42,7 @@
 #include "inc/hw/dmcu.h"
 #include "dml/display_mode_lib.h"
 
-#define DC_VER "3.2.98"
+#define DC_VER "3.2.99"
 
 #define MAX_SURFACES 3
 #define MAX_PLANES 6
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
