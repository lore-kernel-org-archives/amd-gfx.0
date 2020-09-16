Return-Path: <SRS0=J3+H=CZ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3206C43461
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Sep 2020 19:42:36 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A1A7208E4
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Sep 2020 19:42:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="EqYMlrrK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A1A7208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A5DFA6EB10;
	Wed, 16 Sep 2020 19:42:33 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2053.outbound.protection.outlook.com [40.107.237.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2B1EE6EADE
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Sep 2020 19:42:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DXow+Z2CQIpsy5UJqoWxjnXYYm51QN3a2dYTlhjcmMYsLxZL3HWOTXY8iZgGyP+BjPYPLax2qxnkL+H/vJ7GLS8Xr+oKEiEoIDXWytNLWNxxQDN8vRZBvdR4mMZee2VizjkCTkxcw3lOvqBziVhVJLMo3824wj2h0onzqeAfl0gL/SOkCHhpriL7UeFqSmW1PqnN9m8eSqsWcsMQzg8CHr77A8zAYY+sAFAZ7LfqwNExH9vXU3Ahhs9vpYIZnoUPG+cK6OMcJuEZw41cZPG7qCq5Gk+lpOxMtMwAokoDST8MOdi688eQp/28+WNOwg1KEiNWhUFrZMRc8ztiyeNi6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xxLMxfoIgv91bmsCmruVMHnuWRc2Hw/XqZdAakMzhto=;
 b=Veu0L1PRJqibbGtlmyuQieSj+6TtO2VBZfGZUheCFcxvV8O+Mg2yeGSJ2Vq3FrFQygzsxWRefkB/1Jm0nMSGX7yQwvbaPg/RaEl/D5D7wtSM3Q2EGz5EwmFbC69r2kp3ron6nkbPF9kl0PiiuhK0Lct6t30KONjJ8epfbFgSirckSyCJuyMCaEyg9gQK6ZbYrIzPrgJeJERH8p/z1Hlp+YsMYrR0EckdZd6/WAv4cgbLMXOTfMx9PltFguSy7XUc3kQPHWYQ1fhezaimdjuIjk/l9HcgvWjGeL26AJRvTPL/DDM5H3YNGOU1t2mgCgY8CgQiU60CYX7tpVxOcomfQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xxLMxfoIgv91bmsCmruVMHnuWRc2Hw/XqZdAakMzhto=;
 b=EqYMlrrKMWJTkAbqnXZXzfap+yY5aLHpV/LJjDTF+Xm83JI4X7eolsDxpFqfHlJmG7ZjUHMb2Oz0XKyGOa7h/TvDRBCF8NL+oxuhZnpRindnmFZ9DvgPBl29BolCwFvTJe3d+bputtb5BzNl+Odc48+fca4agwXWCEMinFnaoA8=
Received: from DM5PR22CA0003.namprd22.prod.outlook.com (2603:10b6:3:101::13)
 by DM6PR12MB2971.namprd12.prod.outlook.com (2603:10b6:5:118::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16; Wed, 16 Sep
 2020 19:36:40 +0000
Received: from DM6NAM11FT040.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:101:cafe::8) by DM5PR22CA0003.outlook.office365.com
 (2603:10b6:3:101::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.11 via Frontend
 Transport; Wed, 16 Sep 2020 19:36:40 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 DM6NAM11FT040.mail.protection.outlook.com (10.13.173.133) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3370.16 via Frontend Transport; Wed, 16 Sep 2020 19:36:40 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Wed, 16 Sep
 2020 14:36:39 -0500
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Wed, 16 Sep
 2020 14:36:39 -0500
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Wed, 16 Sep 2020 14:36:38 -0500
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 05/15] drm/amd/display: Bug in dce_is_panel_backlight_on()
Date: Wed, 16 Sep 2020 15:36:25 -0400
Message-ID: <20200916193635.5169-6-qingqing.zhuo@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200916193635.5169-1-qingqing.zhuo@amd.com>
References: <20200916193635.5169-1-qingqing.zhuo@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ab0e28aa-78f7-4d42-b13f-08d85a77d577
X-MS-TrafficTypeDiagnostic: DM6PR12MB2971:
X-Microsoft-Antispam-PRVS: <DM6PR12MB2971E760CE23DB72E468DF97FB210@DM6PR12MB2971.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:227;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /X7S6N7qlWLlP4KEmz25iA6KiAlKG+rB4eUQGbMi1zcOTgA6fRShSkkcX1FHu3YYN3gT14zW4iTuvsVRS17LL4r2EjKd96igo7IUASj3XP/CHJ6/Ktl3Zfx78sEL3B9Ul5xBKNxMQWo52sbsillqM+NvuhCzUGII+zyDCGVuJ4j7GOPwvNI4DVrVqWqOZtz7EtkJy1+UuzrfMGwZG+GBxkErceQtHAbiJ54uCZoJ9RdFynfC0jBVHb8sAdheYrN5XNCKoBQgNTWRiGTlOkaUauNxrPfIlMDkxSWU4r629pkwwTS7NZlpaiy5kTx7Son70o2IzCRkyTyIv/HWLoDqvXg5w3NTJ6rQaxBaN4bUU7SNR1YmB8PYJaiARF3bpLdAxlXJTIUsFdGmTjXNN4civw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(376002)(346002)(136003)(39850400004)(396003)(46966005)(478600001)(70586007)(2616005)(8676002)(26005)(5660300002)(426003)(81166007)(1076003)(82310400003)(356005)(6666004)(4326008)(186003)(82740400003)(8936002)(86362001)(36756003)(2906002)(83380400001)(70206006)(44832011)(6916009)(316002)(47076004)(54906003)(336012);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2020 19:36:40.1074 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ab0e28aa-78f7-4d42-b13f-08d85a77d577
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT040.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2971
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
 Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 Peikang Zhang <peikang.zhang@amd.com>, Bhawanpreet.Lakha@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Peikang Zhang <peikang.zhang@amd.com>

[Why]
dce_is_panel_backlight_on() will return wrong value if
LVTMA_BLON_OVRD is 0

[How]
When LVTMA_BLON_OVRD is 0, read
LVTMA_PWRSEQ_TARGET_STATE instead

Signed-off-by: Peikang Zhang <peikang.zhang@amd.com>
Reviewed-by: Anthony Koo <Anthony.Koo@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dce/dce_panel_cntl.c | 10 +++++++---
 drivers/gpu/drm/amd/display/dc/dce/dce_panel_cntl.h |  4 ++++
 2 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_panel_cntl.c b/drivers/gpu/drm/amd/display/dc/dce/dce_panel_cntl.c
index df7f826eebd8..74f7619d4154 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_panel_cntl.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_panel_cntl.c
@@ -159,11 +159,15 @@ static uint32_t dce_panel_cntl_hw_init(struct panel_cntl *panel_cntl)
 static bool dce_is_panel_backlight_on(struct panel_cntl *panel_cntl)
 {
 	struct dce_panel_cntl *dce_panel_cntl = TO_DCE_PANEL_CNTL(panel_cntl);
-	uint32_t value;
+	uint32_t blon, blon_ovrd, pwrseq_target_state;
 
-	REG_GET(PWRSEQ_CNTL, LVTMA_BLON, &value);
+	REG_GET_2(PWRSEQ_CNTL, LVTMA_BLON, &blon, LVTMA_BLON_OVRD, &blon_ovrd);
+	REG_GET(PWRSEQ_CNTL, LVTMA_PWRSEQ_TARGET_STATE, &pwrseq_target_state);
 
-	return value;
+	if (blon_ovrd)
+		return blon;
+	else
+		return pwrseq_target_state;
 }
 
 static bool dce_is_panel_powered_on(struct panel_cntl *panel_cntl)
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_panel_cntl.h b/drivers/gpu/drm/amd/display/dc/dce/dce_panel_cntl.h
index 967d04d75b98..6bd1196083a3 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_panel_cntl.h
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_panel_cntl.h
@@ -61,8 +61,10 @@
 
 #define DCE_PANEL_CNTL_MASK_SH_LIST(mask_sh) \
 	DCE_PANEL_CNTL_SF(LVTMA_PWRSEQ_CNTL, LVTMA_BLON, mask_sh),\
+	DCE_PANEL_CNTL_SF(LVTMA_PWRSEQ_CNTL, LVTMA_BLON_OVRD, mask_sh),\
 	DCE_PANEL_CNTL_SF(LVTMA_PWRSEQ_CNTL, LVTMA_DIGON, mask_sh),\
 	DCE_PANEL_CNTL_SF(LVTMA_PWRSEQ_CNTL, LVTMA_DIGON_OVRD, mask_sh),\
+	DCE_PANEL_CNTL_SF(LVTMA_PWRSEQ_CNTL, LVTMA_PWRSEQ_TARGET_STATE, mask_sh), \
 	DCE_PANEL_CNTL_SF(LVTMA_PWRSEQ_STATE, LVTMA_PWRSEQ_TARGET_STATE_R, mask_sh), \
 	DCE_PANEL_CNTL_SF(LVTMA_PWRSEQ_REF_DIV, BL_PWM_REF_DIV, mask_sh), \
 	DCE_PANEL_CNTL_SF(BL_PWM_PERIOD_CNTL, BL_PWM_PERIOD, mask_sh), \
@@ -76,8 +78,10 @@
 
 #define DCE_PANEL_CNTL_REG_FIELD_LIST(type) \
 	type LVTMA_BLON;\
+	type LVTMA_BLON_OVRD;\
 	type LVTMA_DIGON;\
 	type LVTMA_DIGON_OVRD;\
+	type LVTMA_PWRSEQ_TARGET_STATE; \
 	type LVTMA_PWRSEQ_TARGET_STATE_R; \
 	type BL_PWM_REF_DIV; \
 	type BL_PWM_EN; \
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
