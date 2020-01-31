Return-Path: <SRS0=jwYW=3U=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA308C35240
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Jan 2020 22:17:35 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ADC2D2082E
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Jan 2020 22:17:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="BRhwx9Zk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADC2D2082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E10496FC4B;
	Fri, 31 Jan 2020 22:17:33 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2042.outbound.protection.outlook.com [40.107.236.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 760CE6FC50
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Jan 2020 22:17:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TH9PTpRrv2GjbDzdZsWkCKZWzpJSb+EtKwda4tVnOPIf5gLzEtMebg/p+WQhAYj8z+FOOg0RNCK7FqpUrWbAh9hGiNj98W3ppByIINE9pOnC+NJ8iI2z3qr6g06pxYduKFtcFSVP4q+wQQjIPkudmLO4xCoNzAwFb9+zDQ1EV69QAEOA/vmEoL1ppSP2aO6DEt5wlXeZJMIjtUYu/xhcP/rhvvwGAla5yV8Fb6pmgbeZZQRMxY/UUi6BGA0VcetNcmJgUSlhgpq1GhyDCd5/4SEDHphoqk2LSwpn8AFPFnA3E+mncbD1U0Q3+ZiPXOpQPdvrP9Ud9kjelt78PmQMLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O+bA/KMCm+ZP0NeXX7l+W6hf/vhERU6s1W+4s8ABzK8=;
 b=lw2CX2T5mHL68IdeheTbb17MHB/rvTBwLn6QWLTUmHasP9w+Ct22fNR8P89LaEPS6w/WXm1/6hGReAsJ7HPHPLgB4me+NrDg93MqgVq2T65RoEp7e2oTq3v6M+rpX3Yo7VJ+VmyyFjYYmF75eyjWA4pBgCLDwqPy9+afhgv126OXYch7698icaSocV3bdbRStm2D05W7+5htHTF2gjhY5h2mIqEY5s7ZAGJ0HUr4V7b1fc/Zo7aoHubjdLDfUuPKsLirGDKyysuuYiRq7uZ4vV5QKqfG9gTPWLRFCcv3dqM8WCryBx1gd2hhn7K0Ln68WqE19PYnIxHVew/m7OKFfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O+bA/KMCm+ZP0NeXX7l+W6hf/vhERU6s1W+4s8ABzK8=;
 b=BRhwx9ZkbFV+7EH4jz/9wNPTgq5fiYf4lBrLvJBWoaa9Mf32JLknPOI6G971RvKevrbJYX7G6e/E0/loLTrnNgJoi30PYoZ6XNhcn6ZZtn83mWb2NzRPkXsDEe/ldtTiKU4piAC4yPwKInAOkeO/gTux0qvsbaStWyPztXjxZiQ=
Received: from DM3PR12CA0081.namprd12.prod.outlook.com (2603:10b6:0:57::25) by
 DM5PR12MB2455.namprd12.prod.outlook.com (2603:10b6:4:b7::39) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.26; Fri, 31 Jan 2020 22:17:23 +0000
Received: from CO1NAM11FT007.eop-nam11.prod.protection.outlook.com
 (2a01:111:f400:7eab::205) by DM3PR12CA0081.outlook.office365.com
 (2603:10b6:0:57::25) with Microsoft SMTP Server (version=TLS1_2,
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
 15.20.2686.25 via Frontend Transport; Fri, 31 Jan 2020 22:17:23 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Fri, 31 Jan
 2020 16:17:15 -0600
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Fri, 31 Jan
 2020 16:17:14 -0600
Received: from blakha.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Fri, 31 Jan 2020 16:17:14 -0600
From: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 31/33] drm/amd/display: fix workaround for incorrect double
 buffer register for DLG ADL and TTU
Date: Fri, 31 Jan 2020 17:16:41 -0500
Message-ID: <20200131221643.10035-32-Bhawanpreet.Lakha@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200131221643.10035-1-Bhawanpreet.Lakha@amd.com>
References: <20200131221643.10035-1-Bhawanpreet.Lakha@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(346002)(39860400002)(136003)(376002)(428003)(189003)(199004)(6916009)(4326008)(7696005)(5660300002)(1076003)(2906002)(36756003)(54906003)(316002)(81156014)(8936002)(8676002)(81166006)(478600001)(2616005)(426003)(336012)(26005)(186003)(70586007)(70206006)(86362001)(6666004)(356004);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB2455; H:SATLEXMB01.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; MX:1; A:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c275a860-62af-46fb-4871-08d7a69b58ad
X-MS-TrafficTypeDiagnostic: DM5PR12MB2455:
X-Microsoft-Antispam-PRVS: <DM5PR12MB2455B84087CA9632D13C0874F9070@DM5PR12MB2455.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-Forefront-PRVS: 029976C540
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9O2kMTFeQvM/3IGdLtZcMEI/EbnDiXBBP2TF+vo/K2bQaPJE3WualAzDG6xtyfqU83xnUzewYMrDo8EpIAuWHr/BkrRTXP0qtsWv6KjXSngg+hqMHpQ35LElPDg4IH0+Hq+lPtlm58e5Tk1JjgfU5kdX47phYnTmVcCpDA7M5NR/ivj74hcZ+yFad+SrOzeED49+NhB7vhiiLFJGjqXTnFGejNn32qsWLHUHLGO/mLtkGHjIypZ5RT/TvxbIcEwAr1N4Gr+yeogA7Vv+UfzeeXcy+EYlrhNmDTT3VIfwa3IERraE3vSmF3yr8Noh5Fgsr1JWMp2O9lVmIcTGWRD9C5FufYhKQYyZL8Bvvgl2syEUBwCgiHeYdjFqm+TAoAZAKry30MnFujawLcuHA2G/sD0SReBGvqVZ0Nz2HtlR1yz54/wy5xIJ8oXwdgLSBkqV
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2020 22:17:23.2503 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c275a860-62af-46fb-4871-08d7a69b58ad
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2455
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
Cc: sunpeng.li@amd.com, rodrigo.siqueira@amd.com,
 Tony Cheng <tony.cheng@amd.com>, harry.wentland@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Tony Cheng <tony.cheng@amd.com>

[Why]
these registers should have been double buffered. SW workaround we will have SW program the more aggressive (lower) values
whenever we are upating this register, so we will not have underflow at expense of less optimzal request pattern.

[How]
there is a driver bug where we don't check for 0, which is uninitialzed HW default.  since 0 is smaller than any value we need to program,
driver end up with not programming these registers

Signed-off-by: Tony Cheng <tony.cheng@amd.com>
Reviewed-by: Yongqiang Sun <yongqiang.sun@amd.com>
Acked-by: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
---
 .../gpu/drm/amd/display/dc/dcn21/dcn21_hubp.c | 35 +++++++++++++------
 1 file changed, 25 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_hubp.c b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_hubp.c
index cf09b9335728..aa7b0e7eb945 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_hubp.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_hubp.c
@@ -79,32 +79,47 @@ void apply_DEDCN21_142_wa_for_hostvm_deadline(
 		struct _vcs_dpi_display_dlg_regs_st *dlg_attr)
 {
 	struct dcn21_hubp *hubp21 = TO_DCN21_HUBP(hubp);
-	uint32_t cur_value;
+	uint32_t refcyc_per_vm_group_vblank;
+	uint32_t refcyc_per_vm_req_vblank;
+	uint32_t refcyc_per_vm_group_flip;
+	uint32_t refcyc_per_vm_req_flip;
+	const uint32_t uninitialized_hw_default = 0;
 
-	REG_GET(VBLANK_PARAMETERS_5, REFCYC_PER_VM_GROUP_VBLANK, &cur_value);
-	if (cur_value > dlg_attr->refcyc_per_vm_group_vblank)
+	REG_GET(VBLANK_PARAMETERS_5,
+			REFCYC_PER_VM_GROUP_VBLANK, &refcyc_per_vm_group_vblank);
+
+	if (refcyc_per_vm_group_vblank == uninitialized_hw_default ||
+			refcyc_per_vm_group_vblank > dlg_attr->refcyc_per_vm_group_vblank)
 		REG_SET(VBLANK_PARAMETERS_5, 0,
 				REFCYC_PER_VM_GROUP_VBLANK, dlg_attr->refcyc_per_vm_group_vblank);
 
 	REG_GET(VBLANK_PARAMETERS_6,
-			REFCYC_PER_VM_REQ_VBLANK,
-			&cur_value);
-	if (cur_value > dlg_attr->refcyc_per_vm_req_vblank)
+			REFCYC_PER_VM_REQ_VBLANK, &refcyc_per_vm_req_vblank);
+
+	if (refcyc_per_vm_req_vblank == uninitialized_hw_default ||
+			refcyc_per_vm_req_vblank > dlg_attr->refcyc_per_vm_req_vblank)
 		REG_SET(VBLANK_PARAMETERS_6, 0,
 				REFCYC_PER_VM_REQ_VBLANK, dlg_attr->refcyc_per_vm_req_vblank);
 
-	REG_GET(FLIP_PARAMETERS_3, REFCYC_PER_VM_GROUP_FLIP, &cur_value);
-	if (cur_value > dlg_attr->refcyc_per_vm_group_flip)
+	REG_GET(FLIP_PARAMETERS_3,
+			REFCYC_PER_VM_GROUP_FLIP, &refcyc_per_vm_group_flip);
+
+	if (refcyc_per_vm_group_flip == uninitialized_hw_default ||
+			refcyc_per_vm_group_flip > dlg_attr->refcyc_per_vm_group_flip)
 		REG_SET(FLIP_PARAMETERS_3, 0,
 				REFCYC_PER_VM_GROUP_FLIP, dlg_attr->refcyc_per_vm_group_flip);
 
-	REG_GET(FLIP_PARAMETERS_4, REFCYC_PER_VM_REQ_FLIP, &cur_value);
-	if (cur_value > dlg_attr->refcyc_per_vm_req_flip)
+	REG_GET(FLIP_PARAMETERS_4,
+			REFCYC_PER_VM_REQ_FLIP, &refcyc_per_vm_req_flip);
+
+	if (refcyc_per_vm_req_flip == uninitialized_hw_default ||
+			refcyc_per_vm_req_flip > dlg_attr->refcyc_per_vm_req_flip)
 		REG_SET(FLIP_PARAMETERS_4, 0,
 					REFCYC_PER_VM_REQ_FLIP, dlg_attr->refcyc_per_vm_req_flip);
 
 	REG_SET(FLIP_PARAMETERS_5, 0,
 			REFCYC_PER_PTE_GROUP_FLIP_C, dlg_attr->refcyc_per_pte_group_flip_c);
+
 	REG_SET(FLIP_PARAMETERS_6, 0,
 			REFCYC_PER_META_CHUNK_FLIP_C, dlg_attr->refcyc_per_meta_chunk_flip_c);
 }
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
