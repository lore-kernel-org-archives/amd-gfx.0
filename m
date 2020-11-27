Return-Path: <SRS0=Guv+=FB=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC946C63798
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Nov 2020 14:11:38 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 195CC21D7A
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Nov 2020 14:11:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="4AK9NXjm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 195CC21D7A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A533A6EDEA;
	Fri, 27 Nov 2020 14:11:35 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2087.outbound.protection.outlook.com [40.107.243.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0E8316EDE9
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Nov 2020 14:11:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F50kR3mldVAWv0xYzNLi2+eZgn0bJRauJNJRaHEVCjMFO8LKdTHdTvpcWGdiEO5awgS/V3o1zFyBVEPhC2Bt5ggwu5G0r3YgJC/OAnnTOhkTc9BWyq3vPpA2V2DKA+9dDObGPo5urD5Ahj4R0jv+3D+/5O67KeMPNsux1X9ep3pYduCyRxk7+ZWxNktUxu3yv6lW7YHI3k9UNeonhePA5IhsnFu5XxHaC44iHhuYgghpR0uZxy3EW4meE/kJZDm92sPR/jHC6zZfyJLJfJhxY8eVURU3KAgjIAHYBro98HHZoSmvts2zeW4RQjFUh9iwMIQC6gcgsE/MElw1vBo4CA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sW6i5KtYGegS6hHcyyfOseP+FIElj6chJXAiILvodV4=;
 b=Z5pJZZUzY+WFaNZrJI0Bhd04sN5DAEOTuHlcTnPvKu+s2Y70oqWLnyxHVDE/FJQOCou2Jn/+J0QHnss1zZoNcUzYBM8Gi7kPA/JdKJl7LGjuwsfyBN9HpAa/LD/j4xXrldBBMxO0EbTVtWzJz81LL4AD7ekU+5dKlq0LxGbASHWQAPAZrUdBxuJqCCJPEuVV0xXoR7htXyp32+5vfi79pAiEwHEcTRcm4VAhARsOPerdyYo3HgB+jCS64VP+/On4qGWRD7OhHhRCf86MhQrD7diw5nTNC38JV7RNi7RnODCkCWUbor5v/hI2S7rFyyV+yo89q4E1Y3/WjUqg7OhsNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sW6i5KtYGegS6hHcyyfOseP+FIElj6chJXAiILvodV4=;
 b=4AK9NXjmNvYzzEra2yDmYKQRaDsq2s4lrttj5j8bgZlBEDr26KNDu7v7b+YsdjHdEc7y+dO59FQYJw/u4rUeNWM4B3o0iq7XAJzVp6CDb0ceWVGyi1yXcqTJBM0K04QmoRmg1nnuc3O81UdQmyGk0nTm5Clq5jzRJxnWkUZiynE=
Received: from MWHPR11CA0013.namprd11.prod.outlook.com (2603:10b6:301:1::23)
 by BYAPR12MB3077.namprd12.prod.outlook.com (2603:10b6:a03:db::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3564.28; Fri, 27 Nov
 2020 14:11:32 +0000
Received: from CO1NAM11FT030.eop-nam11.prod.protection.outlook.com
 (2603:10b6:301:1:cafe::e8) by MWHPR11CA0013.outlook.office365.com
 (2603:10b6:301:1::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.20 via Frontend
 Transport; Fri, 27 Nov 2020 14:11:32 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none
 (message not signed) header.d=none;lists.freedesktop.org; dmarc=fail
 action=none header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 165.204.84.17 as permitted sender)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 CO1NAM11FT030.mail.protection.outlook.com (10.13.174.125) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3611.25 via Frontend Transport; Fri, 27 Nov 2020 14:11:31 +0000
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 27 Nov
 2020 08:11:30 -0600
Received: from aj-EliteDesk.amd.com (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Fri, 27 Nov 2020 08:11:30 -0600
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 09/11] drm/amd/display: Properly define DPCS related info for
 DCN301
Date: Fri, 27 Nov 2020 09:11:05 -0500
Message-ID: <20201127141107.7731-10-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201127141107.7731-1-aurabindo.pillai@amd.com>
References: <20201127141107.7731-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 901350a0-4fc5-48bb-eac1-08d892de5764
X-MS-TrafficTypeDiagnostic: BYAPR12MB3077:
X-Microsoft-Antispam-PRVS: <BYAPR12MB30773B0A0B1851F4E1EF24A68BF80@BYAPR12MB3077.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:506;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 59g0UC54gNGzEjBgbjhMyjJL+rn/GswG7YuxRwgv2KVYIBBNuPK/OUnGA0Xl2dBpQvgDaU3+f+hXxXOyZvXDPXkTH4gJ+r9vs+As2cnvo7yAspwhkKYyH4Xje/+7MMNTnYLCEwe3Ns6bnwZpBjtvLweRf+DDyO3kyC6AvXyHZqDEj4pZIDSCkAUUojDtpfv5HbSwzOh4n0XsEJ4853vEJebMun79UP1+5OGFJUEQTuhIN4M4g8REv7/jFAJXIRL51/ZgcSGf0NmlZQ8GazC2A3DxZt7x+tVVEm4U5SR4cED3d973ZC3W2a5cyRhtaAsY9csKO44hNo3+YxO7jXPar6LvcqXhyzHjwYwIv0FPzrSh9gbhnW9a/rL/9RyRE64IkWlOWW7PPrJ6ckm7Vbc8SA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(136003)(346002)(396003)(376002)(39860400002)(46966005)(83380400001)(4326008)(356005)(81166007)(44832011)(7696005)(316002)(70206006)(1076003)(70586007)(2906002)(82740400003)(8936002)(478600001)(54906003)(47076004)(6916009)(186003)(36756003)(336012)(86362001)(8676002)(26005)(6666004)(426003)(2616005)(82310400003)(5660300002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2020 14:11:31.7872 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 901350a0-4fc5-48bb-eac1-08d892de5764
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT030.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3077
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
Cc: Zhan Liu <zhan.liu@amd.com>, Eryk.Brol@amd.com, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 Nikola Cornij <nikola.cornij@amd.com>, Aurabindo.Pillai@amd.com,
 Bhawanpreet.Lakha@amd.com, bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Zhan Liu <zhan.liu@amd.com>

[Why]
DPCS related info needs to be properly defined within code.

[How]
Add missing DPCS related info to code.

Signed-off-by: Zhan Liu <zhan.liu@amd.com>
Reviewed-by: Nikola Cornij <nikola.cornij@amd.com>
Acked-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 .../gpu/drm/amd/display/dc/dcn301/dcn301_resource.c   | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c b/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c
index 7e95bd1e9e53..4825c5c1c6ed 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c
@@ -73,6 +73,9 @@
 
 #include "nbio/nbio_7_2_0_offset.h"
 
+#include "dcn/dpcs_3_0_0_offset.h"
+#include "dcn/dpcs_3_0_0_sh_mask.h"
+
 #include "reg_helper.h"
 #include "dce/dmub_abm.h"
 #include "dce/dce_aux.h"
@@ -517,10 +520,12 @@ static const struct dcn10_link_enc_hpd_registers link_enc_hpd_regs[] = {
 		hpd_regs(3),
 };
 
+
 #define link_regs(id, phyid)\
 [id] = {\
 	LE_DCN301_REG_LIST(id), \
 	UNIPHY_DCN2_REG_LIST(phyid), \
+	DPCS_DCN2_REG_LIST(id), \
 	SRI(DP_DPHY_INTERNAL_CTRL, DP, id) \
 }
 
@@ -540,11 +545,13 @@ static const struct dcn10_link_enc_registers link_enc_regs[] = {
 };
 
 static const struct dcn10_link_enc_shift le_shift = {
-	LINK_ENCODER_MASK_SH_LIST_DCN301(__SHIFT)
+	LINK_ENCODER_MASK_SH_LIST_DCN301(__SHIFT),\
+	DPCS_DCN2_MASK_SH_LIST(__SHIFT)
 };
 
 static const struct dcn10_link_enc_mask le_mask = {
-	LINK_ENCODER_MASK_SH_LIST_DCN301(_MASK)
+	LINK_ENCODER_MASK_SH_LIST_DCN301(_MASK),\
+	DPCS_DCN2_MASK_SH_LIST(_MASK)
 };
 
 #define panel_cntl_regs(id)\
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
