Return-Path: <SRS0=B7jy=6A=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B284DC2BB85
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Apr 2020 23:41:47 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 88DC621841
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Apr 2020 23:41:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="GABwtlRh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88DC621841
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3A7EE6E354;
	Thu, 16 Apr 2020 23:41:47 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2061d.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe59::61d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 025B26E353
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Apr 2020 23:41:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LV5RxT+JFaK5m4K/HBz7LMhfKZYRCgb+vxF/+AQgGeBBa6ApNnndtj7uoCc7mLUT2VpSVWsXaGyN/hDTKRmyRDKh7OTaXSwp8wJ9v467VtRg/za7QLyoCrd+pj93MrsUKgkpNWHYzIXrFSOM46kgl2g35KHDgBYQ4AIUMoaBdi9AYwktpGrFI5Izezo3z8CIhMX7S+UyAte//9lx3imS6iB7y30RHgoYgEc0Tq5uyaqUdg3hap57XRXXgBoTkzxReRasXoeZQEpMVLmEkTQjQuwLt7eXQNFWIieMzQNmAUUbVhn6TS7tGjTaTMzNiHHW8kCaEnRKAQFAxtmn92HO4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D++iwQmQlohy5Bg7l9v2eXjDlY9terKBS32HRXLGUIo=;
 b=S1WnaqtoQgcb0CuyXGS1drqqQiw4WqtPsinmF/QS0SuIgavfbCfxGTIqCLldnPeu5IWTcpVr6L4pwILofHioE1FVggkA/qXFAl5sEDW1+eiVb2EUpbRxNWuWpTHEiVG6bpppNwJDu/9NHL7fS8MD8RWQ/TFH76HvAK8OTteOU1meMHBVIH0rbaBF/Bfu5ClZ+MaktlLDqsSYqchN3/dJpwkAs8sYym7K7G+4IzMPLn5PHgEZO9MOiiy17B/IHK6HVCM8jWf5CSM+6R4FT9BO5YEChOLk2Xp0pb5+6rUIDp+VnNvalNxMJkkAJ3Nnbj+JzkSlcbuPiOVh0u9x3KR1Jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D++iwQmQlohy5Bg7l9v2eXjDlY9terKBS32HRXLGUIo=;
 b=GABwtlRhHPtkPIB0X2fJ7ZRMJgs6xm9F2AWoPqMKD0nY5Tix0tAA9qWPDVURtcIZoHte0t2NeXZrHboG2JAHRW9/y66rLAATv6ZWtIOS2W8skvB2srdWbgasQBN0bhF4KwOh70mXtRJfmaAcL7fomJNAGqlEMqq4hMW1+nnDEVM=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Rodrigo.Siqueira@amd.com; 
Received: from MW2PR12MB2524.namprd12.prod.outlook.com (2603:10b6:907:9::27)
 by MW2PR12MB2459.namprd12.prod.outlook.com (2603:10b6:907:c::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.15; Thu, 16 Apr
 2020 23:41:44 +0000
Received: from MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::91a7:e6f7:b17a:bfa5]) by MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::91a7:e6f7:b17a:bfa5%6]) with mapi id 15.20.2921.027; Thu, 16 Apr 2020
 23:41:44 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 25/35] drm/amd/display: dmcu wait loop calculation is
 incorrect in RV
Date: Thu, 16 Apr 2020 19:40:34 -0400
Message-Id: <20200416234044.2082886-26-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200416234044.2082886-1-Rodrigo.Siqueira@amd.com>
References: <20200416234044.2082886-1-Rodrigo.Siqueira@amd.com>
X-ClientProxiedBy: BN8PR12CA0012.namprd12.prod.outlook.com
 (2603:10b6:408:60::25) To MW2PR12MB2524.namprd12.prod.outlook.com
 (2603:10b6:907:9::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from atma2.hitronhub.home (2607:fea8:56a0:11a1::2) by
 BN8PR12CA0012.namprd12.prod.outlook.com (2603:10b6:408:60::25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2921.25 via Frontend Transport; Thu, 16 Apr 2020 23:41:43 +0000
X-Mailer: git-send-email 2.26.0
X-Originating-IP: [2607:fea8:56a0:11a1::2]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: ffcf076d-8e5e-4f5f-b6fc-08d7e25fb8af
X-MS-TrafficTypeDiagnostic: MW2PR12MB2459:|MW2PR12MB2459:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW2PR12MB245927657B4B737169A6125498D80@MW2PR12MB2459.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1360;
X-Forefront-PRVS: 0375972289
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW2PR12MB2524.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(346002)(136003)(376002)(396003)(366004)(39860400002)(316002)(2906002)(54906003)(36756003)(6916009)(6486002)(1076003)(478600001)(6666004)(86362001)(81156014)(8676002)(8936002)(6512007)(66476007)(66556008)(66946007)(2616005)(5660300002)(16526019)(186003)(6506007)(4326008)(52116002);
 DIR:OUT; SFP:1101; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IGzJigCPRBgawNU4xdEacvnusDYGbDPV2bESavlFXEjBAsk095DGdk60O7RwEkTp29LQPCCFq16oQGTwL6o/MS4NxyKI2YXm7C7FiDjl9io9JWZGeJVjJw5f7Gu+efG+wUirnEyzzeYxcHYqm+nKfpzjh4+RuhtkpxctAqpwVGLmyUhkZM4N/Y/3U2BTKtFtyiHDJyFGS6RxT08c4j+NAqRd/uqhz2PPWldlJ6gFm7HSGFj4q2lISnSSNvDNpdAEqiiPY3K8SEpSrWE6uCyakZ6O+Gpv4mX+FjVrHJPzwhKj1Hx1y2uIOm+gUbhnzx768C2/NlXsHUUcneUU7XfQP5XfO37ZInNhYyTMtGp0h38B+UWFXO1mfXUIwfb/66vUokQhzFqle+5jCKrfO/FMX/ca1Y4PbKQH3uwVMJ7nVkDowu/495mlM5q/zyx+fb8h
X-MS-Exchange-AntiSpam-MessageData: xUfc9lyXUSnNHTBhFX8MO9srOLAjzp596QGORKGnMfQ/AnYETzUl7MmI/cFAMDVk+5YcMq+42jA6MzhpA3Fg8eyjKNRuLiuzk2X03h3FA9kALCTSv903WblZBDpvW84AnwGv5a/y2fWix+42h/MS5WX0hyMwE9xikOhpfjL8o5c=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ffcf076d-8e5e-4f5f-b6fc-08d7e25fb8af
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2020 23:41:44.7606 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 476X0kdf75iggIBYApd0f/9JW/xKhaLHEMKYRIohrk5FGWpA3KHL0/KvJyOWiOrO55EfM69QZaZi/xm8wujOgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2459
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
Cc: Eric Yang <eric.yang2@amd.com>, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 Rodrigo.Siqueira@amd.com, Paul Hsieh <paul.hsieh@amd.com>,
 Bhawanpreet.Lakha@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Paul Hsieh <paul.hsieh@amd.com>

[Why]
Driver already get display clock from SMU base on MHz, but driver read
again and mutiple 1000 cause wait loop value is overflow.

[How]
remove coding error

Signed-off-by: Paul Hsieh <paul.hsieh@amd.com>
Reviewed-by: Eric Yang <eric.yang2@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 .../drm/amd/display/dc/clk_mgr/dcn10/rv1_clk_mgr_vbios_smu.c   | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn10/rv1_clk_mgr_vbios_smu.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn10/rv1_clk_mgr_vbios_smu.c
index 97b7f32294fd..c320b7af7d34 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn10/rv1_clk_mgr_vbios_smu.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn10/rv1_clk_mgr_vbios_smu.c
@@ -97,9 +97,6 @@ int rv1_vbios_smu_set_dispclk(struct clk_mgr_internal *clk_mgr, int requested_di
 			VBIOSSMC_MSG_SetDispclkFreq,
 			requested_dispclk_khz / 1000);
 
-	/* Actual dispclk set is returned in the parameter register */
-	actual_dispclk_set_mhz = REG_READ(MP1_SMN_C2PMSG_83) * 1000;
-
 	if (!IS_FPGA_MAXIMUS_DC(dc->ctx->dce_environment)) {
 		if (dmcu && dmcu->funcs->is_dmcu_initialized(dmcu)) {
 			if (clk_mgr->dfs_bypass_disp_clk != actual_dispclk_set_mhz)
-- 
2.26.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
