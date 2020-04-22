Return-Path: <SRS0=Hoyj=6G=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A224C54FCB
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Apr 2020 22:08:27 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C3082076E
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Apr 2020 22:08:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="nTT1ytBZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C3082076E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 44A6B89E47;
	Wed, 22 Apr 2020 22:08:26 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2061.outbound.protection.outlook.com [40.107.92.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CD97289E47
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Apr 2020 22:08:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J2kKAF4JH5Z0UN5Qe6jEekuDlZDcrl9ge6x6/bk7TtSAZVlSMpAqFfgocPxIiEf4QyO08GdE5brk9o4cTbs4TUGWZf0ViL1g3Qb1EUIbUfvwWWBvNYvIeeKZ/WTGDiD/lbQIoJaZSIfGxzlYKH9IS/x3f7cRZq10kglaculGP7zHByhLRa6LIgh019IjSkhGdT2Qxo6iXmfrIVC+k/1dn622yDd9oBq+29ySDbjsfluQpdwRJh05rF6QDHuQ2AAgIyphPSLjaoVeQaJDBZbtjhyY+y1bGKSjJTtFeNKOREgE/2oRl6L8HmQb1L0cTywOLtk90O8ReeseWqfh3ZJIGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=McoAMaImn+d2lXE9MWEmvOJVyuUGjYEeyIbZFn72eDo=;
 b=dP2WbtU+x25i/2cWFHDqvvLxVKLXARg3w9ZGNp9F8pzS5uqY92f392+j1PzsWs+pdGcrpesVKzhQ2tgvPXtEseI83GGMQGA9ANIcaTPxqanuUT07LLjJ+8bV+VcBQkujnzNINCs+o/XID5hLBp6JUlQ9IWKprmSpHrxOGTgUuk8YmqswYRggiUiDCBqLzDLPNRlqVqJO/lcLKEyR5kIR5Bk5RfiDvAmatYVfbBBdA9aI44VF4mweKZjzGxYI3+Bz9JEa2GlW/bYD1bBaJ2eZ9kj+PW0h7bQka5vPwu2z4/pGCk790xLaAqDdue0kjVeuiOb8LRI/5FzLWd0Oj09q8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=McoAMaImn+d2lXE9MWEmvOJVyuUGjYEeyIbZFn72eDo=;
 b=nTT1ytBZAvFQZlkS2TAn3cWl+BxjFZs+Keak47SRX8RLm/O3YOMKUOiYvEDYcdXFlX6AX6qk2HPQHo2ePuKxDdp7xNLSCQRNdeG8a92NU/jxYAVmNr5rAA3FsPAeY3tWbgGlmeasB+4lzIa2Ab0ACU1y5amb2DwRYI35+kdo5ek=
Received: from MWHPR12CA0042.namprd12.prod.outlook.com (2603:10b6:301:2::28)
 by MWHPR1201MB0158.namprd12.prod.outlook.com (2603:10b6:301:56::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.29; Wed, 22 Apr
 2020 22:08:15 +0000
Received: from CO1NAM11FT011.eop-nam11.prod.protection.outlook.com
 (2603:10b6:301:2:cafe::ca) by MWHPR12CA0042.outlook.office365.com
 (2603:10b6:301:2::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13 via Frontend
 Transport; Wed, 22 Apr 2020 22:08:15 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 CO1NAM11FT011.mail.protection.outlook.com (10.13.175.186) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2937.15 via Frontend Transport; Wed, 22 Apr 2020 22:08:14 +0000
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Wed, 22 Apr
 2020 17:08:14 -0500
Received: from aes.amd.com (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Wed, 22 Apr 2020 17:08:12 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 05/19] drm/amd/display: Add DML variable for future asics
Date: Wed, 22 Apr 2020 18:07:51 -0400
Message-ID: <20200422220805.15759-6-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200422220805.15759-1-aurabindo.pillai@amd.com>
References: <20200422220805.15759-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(39860400002)(396003)(136003)(346002)(376002)(428003)(46966005)(8936002)(86362001)(7696005)(26005)(2906002)(316002)(336012)(186003)(1076003)(82310400002)(81156014)(4326008)(8676002)(70206006)(70586007)(2616005)(47076004)(6916009)(82740400003)(54906003)(81166007)(6666004)(5660300002)(426003)(36756003)(478600001)(356005)(44832011);
 DIR:OUT; SFP:1101; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 872d4fbf-2b72-44a6-b618-08d7e709a78a
X-MS-TrafficTypeDiagnostic: MWHPR1201MB0158:
X-Microsoft-Antispam-PRVS: <MWHPR1201MB0158A96F26BA08C72C63843D8BD20@MWHPR1201MB0158.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:296;
X-Forefront-PRVS: 03818C953D
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +qq/Xm7Sk42YTUHMgXXL3T2n9Wcqd9dO98+gYhtxG6y4pW5Dt/kJYHIE9K7OjnxCpll/kZpQUtqUBQ6FE2Q+dS7MmguLf8EWCanumMAyQGhTWuguzWb28xU7Ey7orSAxCKgCqBtCimc+T8C3jHRAOiAesmNBRhEqjQbhZwFc+nFXk2kg60qJsiM4KpFFRceAvXxH86Amhrn4QOsuigerd+zjVzFXvHlxL+UtV/58WFIuLWsB5iZldw224vnM8b1mal4CXzP7cxmTEIjimdpwTpnIlLwvbYve3kl/j847SOgDWsixtOoG3X3MaVwaMaE91sdDZv2YBTaZi5elrgngyF1CGinv6m533ZWCSvojt3pQv/ydY574QcFB2qejk0+WQG8l73V2+hrh6DhOXJx/Tvtlq4cbxR+UTKsGr/6ZcdrlD316pmwBqLeIhz6qPmi+wGy6mhWTyOPD07NEzxG4ZXuycYxTtZWCpu09CYI2JbaBnUzHRBcQPvzLZGAiAsA7
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2020 22:08:14.6203 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 872d4fbf-2b72-44a6-b618-08d7e709a78a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB0158
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
Cc: Sunpeng.Li@amd.com, Bhawanpreet.Lakha@amd.com, Rodrigo.Siqueira@amd.com,
 Harry.Wentland@amd.com, Joshua Aberback <joshua.aberback@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Joshua Aberback <joshua.aberback@amd.com>

Signed-off-by: Joshua Aberback <joshua.aberback@amd.com>
Reviewed-by: Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>
Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Acked-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dml/display_mode_structs.h | 1 +
 drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.c     | 1 +
 drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.h     | 1 +
 3 files changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/display_mode_structs.h b/drivers/gpu/drm/amd/display/dc/dml/display_mode_structs.h
index 687010c17324..b2ecb174a93f 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/display_mode_structs.h
+++ b/drivers/gpu/drm/amd/display/dc/dml/display_mode_structs.h
@@ -121,6 +121,7 @@ struct _vcs_dpi_soc_bounding_box_st {
 };
 
 struct _vcs_dpi_ip_params_st {
+	bool use_min_dcfclk;
 	bool gpuvm_enable;
 	bool hostvm_enable;
 	unsigned int gpuvm_max_page_table_levels;
diff --git a/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.c b/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.c
index 6b525c52124c..6e4e8a452e66 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.c
@@ -280,6 +280,7 @@ static void fetch_ip_params(struct display_mode_lib *mode_lib)
 	ip_params_st *ip = &mode_lib->vba.ip;
 
 	// IP Parameters
+	mode_lib->vba.UseMinimumRequiredDCFCLK = ip->use_min_dcfclk;
 	mode_lib->vba.MaxNumDPP = ip->max_num_dpp;
 	mode_lib->vba.MaxNumOTG = ip->max_num_otg;
 	mode_lib->vba.MaxNumHDMIFRLOutputs = ip->max_num_hdmi_frl_outputs;
diff --git a/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.h b/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.h
index 5d82fc5a7ed7..a1884ffe63ae 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.h
+++ b/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.h
@@ -898,6 +898,7 @@ struct vba_vars_st {
 	bool dummystring[DC__NUM_DPP__MAX];
 	double BPP;
 	enum odm_combine_policy ODMCombinePolicy;
+	bool UseMinimumRequiredDCFCLK;
 };
 
 bool CalculateMinAndMaxPrefetchMode(
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
