Return-Path: <SRS0=buuZ=D4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 349DAC55178
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Oct 2020 14:23:37 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA4CC2224E
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Oct 2020 14:23:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="RTq+P440"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA4CC2224E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 418DD6EDDB;
	Wed, 21 Oct 2020 14:23:36 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2082.outbound.protection.outlook.com [40.107.92.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0A1E56EDD3
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Oct 2020 14:23:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d6oa4wjL7DV8Ml0iEg0jyv8tEybMmnemIev4tM/I6q2ITBjEz9uDMaAhQdfx3H62roDa5Gxha2he4r2VYCTCyNi+XifHl0BsQZGON+ezbi9T0D+WmzNA7tXMGMOdzbO654iTbXdu5lyMYqFri6LCF4UoGr5A6PnDlI75T8SULQMkWGwCDfn2Y4F3EZ11wEUIJvKTMG/OzRI01AARo2mI40oR6vTl7Eh3gqCPT09bnokswPedS7Tkoz4kM0CrV7APD8XI2XCk+kYvqje/Tzxidz7rgnb8FPxSJ64U4SLl2M8/8SB2iTKOLp8ABe7RrjAd0uAGFOUdAagNgLcTHN9LrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OjDMb6daWD6gDXTC8uOg9brLKCefHkBR7XU0Xk8kWgM=;
 b=Us4pgi2VxAtnPmqF7ggnC7suBXvcT7umahaITi0v0GGk02Hti8UrlJry+rqoJjIRh/xMP9CeJrW0vAQfQYylJ1fle+OMvdW6EUy8BmfPmbyDhmQpbsklUUH3MZuOAyp1Tkd+JwS2Gw4Wf1vP3lsYGHeCjhZNg9R0jlZvnwVdd7e3hGkl3mc/LyoKazMadDojhYmvAaRNqQQ6R6whpcEWn1KOB8j6qsSbvlDs3eaSgC6iuwBiAxaeFFdPAmk0rX5lkk3WN9I6knfktKWZp4/I1VEMPW6bvwZYPweaKm6RMvu8veOKwtASeZ+APTRPzlL/LN6SvqYvIFVc4RU2cPlg/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=none action=none header.from=amd.com; dkim=none (message not signed);
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OjDMb6daWD6gDXTC8uOg9brLKCefHkBR7XU0Xk8kWgM=;
 b=RTq+P4401n97PlZoS70MFIBB45m5mi31SOPLng8qXTlO5AuwCgnkfywgQoplORN3Nx/bNfoMQWJuSEGTZ8AMO8dYi9MhB8HItFLPIFE/MOYtmohY7Zvuf7s9UvMM1dARh5UYpFvtjsBQ7WjHq+O2MFo6a2kdJfh9OJf/CXygwxY=
Received: from DM5PR16CA0042.namprd16.prod.outlook.com (2603:10b6:4:15::28) by
 SN1PR12MB2496.namprd12.prod.outlook.com (2603:10b6:802:2f::12) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3477.22; Wed, 21 Oct 2020 14:23:26 +0000
Received: from DM6NAM11FT047.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:15:cafe::32) by DM5PR16CA0042.outlook.office365.com
 (2603:10b6:4:15::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18 via Frontend
 Transport; Wed, 21 Oct 2020 14:23:26 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=none action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 DM6NAM11FT047.mail.protection.outlook.com (10.13.172.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3499.18 via Frontend Transport; Wed, 21 Oct 2020 14:23:26 +0000
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Wed, 21 Oct
 2020 09:23:25 -0500
Received: from aj-EliteDesk.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Wed, 21 Oct 2020 09:23:24 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 26/33] drm/amd/display: Rework registers tracepoint
Date: Wed, 21 Oct 2020 10:22:50 -0400
Message-ID: <20201021142257.190969-27-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201021142257.190969-1-aurabindo.pillai@amd.com>
References: <20201021142257.190969-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fdcdb1a4-c473-4759-a9a9-08d875cce022
X-MS-TrafficTypeDiagnostic: SN1PR12MB2496:
X-Microsoft-Antispam-PRVS: <SN1PR12MB24968BF3049780D17F1F9C9E8B1C0@SN1PR12MB2496.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1303;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vyZRxmDSu1uqmmB/pdycGbB5ymrSQcXx26sHBMK66eHDnenE9fNHtAfAd0dxY5Gqpd+cWgNGVpDTdIj9GsVvyqKXpy4LhUlMVWG8+iCqnioQnWfhLEAsmaiQ4jHJMi9WP1Rbj1rdSCi/8+WxU6aFxHpFctC996LcU7eniKqSixbzyhxRwZaKSTTPjXwM3oM0ObSzoKBqX0/L6fxbrVIQOZs6qNpxUBfymTpnNulMKEfNH3Zk+vRlz8+LNHTwtxF3q2pQu33sQkfRqNyPzd9Xein2zGhJUIPeq8GbO0PzbnJ/OLOga4UxwhP0FAx2LbQGGOR7SDv8ckUIFWLtyUfG++jYI+FxUB74/v/geQ/BF518FYrI6W4NQX6YhsYQ7lM048j7H3qB2y9um0mA5MAIVg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(396003)(346002)(376002)(136003)(39860400002)(46966005)(81166007)(6916009)(36756003)(26005)(7696005)(478600001)(47076004)(2616005)(82740400003)(44832011)(1076003)(426003)(4326008)(70206006)(8936002)(54906003)(70586007)(5660300002)(186003)(336012)(2906002)(82310400003)(83380400001)(8676002)(6666004)(356005)(86362001)(316002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2020 14:23:26.6081 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fdcdb1a4-c473-4759-a9a9-08d875cce022
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT047.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2496
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
Cc: Eryk.Brol@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com, Aurabindo.Pillai@amd.com,
 Bhawanpreet.Lakha@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>

amdgpu_dc_rreg and amdgpu_dc_wreg are very similar, for this reason,
this commits abstract these two events by using DECLARE_EVENT_CLASS and
create an instance of it for each one of these events.

Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Acked-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 .../amd/display/amdgpu_dm/amdgpu_dm_trace.h   | 55 ++++++++-----------
 1 file changed, 24 insertions(+), 31 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_trace.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_trace.h
index 1151e03365a3..11941c69c420 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_trace.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_trace.h
@@ -31,40 +31,33 @@
 
 #include <linux/tracepoint.h>
 
-TRACE_EVENT(amdgpu_dc_rreg,
-	TP_PROTO(unsigned long *read_count, uint32_t reg, uint32_t value),
-	TP_ARGS(read_count, reg, value),
-	TP_STRUCT__entry(
-			__field(uint32_t, reg)
-			__field(uint32_t, value)
-		),
-	TP_fast_assign(
-			__entry->reg = reg;
-			__entry->value = value;
-			*read_count = *read_count + 1;
-		),
-	TP_printk("reg=0x%08lx, value=0x%08lx",
-			(unsigned long)__entry->reg,
-			(unsigned long)__entry->value)
-);
+DECLARE_EVENT_CLASS(amdgpu_dc_reg_template,
+		    TP_PROTO(unsigned long *count, uint32_t reg, uint32_t value),
+		    TP_ARGS(count, reg, value),
 
-TRACE_EVENT(amdgpu_dc_wreg,
-	TP_PROTO(unsigned long *write_count, uint32_t reg, uint32_t value),
-	TP_ARGS(write_count, reg, value),
-	TP_STRUCT__entry(
-			__field(uint32_t, reg)
-			__field(uint32_t, value)
-		),
-	TP_fast_assign(
-			__entry->reg = reg;
-			__entry->value = value;
-			*write_count = *write_count + 1;
-		),
-	TP_printk("reg=0x%08lx, value=0x%08lx",
-			(unsigned long)__entry->reg,
-			(unsigned long)__entry->value)
+		    TP_STRUCT__entry(
+				     __field(uint32_t, reg)
+				     __field(uint32_t, value)
+		    ),
+
+		    TP_fast_assign(
+				   __entry->reg = reg;
+				   __entry->value = value;
+				   *count = *count + 1;
+		    ),
+
+		    TP_printk("reg=0x%08lx, value=0x%08lx",
+			      (unsigned long)__entry->reg,
+			      (unsigned long)__entry->value)
 );
 
+DEFINE_EVENT(amdgpu_dc_reg_template, amdgpu_dc_rreg,
+	     TP_PROTO(unsigned long *count, uint32_t reg, uint32_t value),
+	     TP_ARGS(count, reg, value));
+
+DEFINE_EVENT(amdgpu_dc_reg_template, amdgpu_dc_wreg,
+	     TP_PROTO(unsigned long *count, uint32_t reg, uint32_t value),
+	     TP_ARGS(count, reg, value));
 
 TRACE_EVENT(amdgpu_dc_performance,
 	TP_PROTO(unsigned long read_count, unsigned long write_count,
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
