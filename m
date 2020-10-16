Return-Path: <SRS0=ko+j=DX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,TVD_SPACE_RATIO,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A062C4363A
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Oct 2020 03:29:09 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 88542206ED
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Oct 2020 03:29:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="hEN9cNjZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88542206ED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 30AC26EA8D;
	Fri, 16 Oct 2020 03:29:07 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2049.outbound.protection.outlook.com [40.107.92.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1CB746E9BD
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Oct 2020 03:29:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BlAjUMfDcxB+bonhLLHRrwz/vKYM4VlyAeqx5vSDcFpddXK+DyKe0bSko1zIaDN7KmMONT9jHMvSlPe6d8qr0PpMl2+W5aOSaMzS/suzWPALLfpA9A+JsJ8KfmVjMdS+Af339pQRqUPmuQR6sWvM4LECaAA6pmFTBvMmkL4C6F8uHqX65q7npHexXXdDb4kjzpVosTqzuIfNZI7hEnxEsrXSt3ojIk4lB1xoUPqTvyzY0qBd+xJ83isM0VE3DfliK3gw5RFrzfBt/SBqCG4M3pjSs+L8cjp0Y87yzTjNX16Nv8MTLL8Ljc1dFrGl8EMJ20QvLt6M5kjgCIpe1fnvbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f0pQ6mUIAXPoiPyfymH3lJBqzMH/fDIAQM1G5nMIjaQ=;
 b=S2EDeyF0CJ/7waioAu1Lo7At0vthWYpAG23A1V+v04eaU8x6vvLycEI8icm5dZHzwoEFZFrs6I8tW3PjQH8vbngJWMAuXf6F9U8pNIcm4pb7Kqt5AgRTgi+wyVZ+CpUXyfnR/wvbdBGxn68DlxMWFPc54c872PPLGOTl23sVVys44MnyUSUoqRfSuAV31F2FrZPUBPkgWALHksAD6GvhFiwYk7yisgk/cdL7mEdMLEk2kOY1tDH49CeLr6qwbN3zHAM8nwzyW00RgbTiszmKZLTg3oOCZXROV1uKMxm69qtuwNkS5JyZrZKbha5I440XIyNTZ9InKfipEsQX/sQJNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f0pQ6mUIAXPoiPyfymH3lJBqzMH/fDIAQM1G5nMIjaQ=;
 b=hEN9cNjZ3NjQOBi39Cv4+Yq8qzPo1I1aHu+XbXVzh5J2GIp9XN7NtnB8EaSkhKIC0z+mnKaW5FgciXa2YsW4/fTSjhKCajpCZ4xOt+qjQhvyapKLIbNmRhyHjwkgly/ALtN3Ec7DUrOkZ32iTZpOy4RTzKqp1fp8HPvUfnFRqO8=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM5PR12MB1354.namprd12.prod.outlook.com (2603:10b6:3:7a::17) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3477.21; Fri, 16 Oct 2020 03:29:04 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::bcb1:de80:f60c:8118]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::bcb1:de80:f60c:8118%5]) with mapi id 15.20.3477.023; Fri, 16 Oct 2020
 03:29:03 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 35/40] drm/amd/pm: correct vddc_dep_on_dal_pwrl setup
Date: Fri, 16 Oct 2020 11:26:47 +0800
Message-Id: <20201016032652.507-36-evan.quan@amd.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201016032652.507-1-evan.quan@amd.com>
References: <20201016032652.507-1-evan.quan@amd.com>
X-Originating-IP: [58.247.170.242]
X-ClientProxiedBy: HK2PR0302CA0007.apcprd03.prod.outlook.com
 (2603:1096:202::17) To DM6PR12MB2619.namprd12.prod.outlook.com
 (2603:10b6:5:45::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from equan-buildpc.amd.com (58.247.170.242) by
 HK2PR0302CA0007.apcprd03.prod.outlook.com (2603:1096:202::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3499.8 via Frontend Transport; Fri, 16 Oct 2020 03:28:33 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 6570e046-149e-4eb0-ef6d-08d871839058
X-MS-TrafficTypeDiagnostic: DM5PR12MB1354:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB1354D6819142224CFA4B6A7CE4030@DM5PR12MB1354.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:346;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mm7tfV9X7jxZvFcLp2M6Gpx4F7DQSNjeFRSgSNYrV6mfYvGOxy3WxyOPqYBtIRQVx7xyJP9tIuqq8lYIlEY9ZNcPML/bLk1WOPhiKB6/3gJs7yJG/+PVZt5GSV33h0KS3R1PPNGndY49/yUGAu2WixrGpW/MggQD4nm+UvkzMf8CAbbSyXgNSZrZCXDSaVjIkPkm59wE8xcbJZfrFjwa5FjPaPhFkpJogepk/fNRXog1S8tZ976vs8LcNPS+oBHvGV50HdtMFh/o5qUty2SuYxjbWzNFk72ihRlDiq5GUJE17DE6umw5mvEeJrfJs2JV3d8XdpfG1pMbsqpNBfsMKKN2q2mVhIWzgwYqTTsom/UN8mk0KKh9uK5BHuh3V78H
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(39860400002)(346002)(396003)(136003)(376002)(66476007)(66946007)(83380400001)(1076003)(8676002)(6486002)(5660300002)(8936002)(66556008)(6916009)(86362001)(52116002)(36756003)(7696005)(4326008)(2616005)(34490700002)(478600001)(316002)(6666004)(44832011)(16526019)(186003)(54906003)(2906002)(26005)(956004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: UruhN0iM4D84n6JSSU9ps9fbzAHOm1/B/I2f5NE//8df2N2g7SOk1ngfMlzwH2j9pIFu6IySJAcg+0MLLmvEClow6Y0UFgzMXgURR3LjtQW4x21GUC+HT2NXFOP81ZmKLKmhk6dsEOIBQbXoKt6iJ35r7xO+xaWwc9yhKny2yD+tZ7vUSl8/tBwmSCH6kqLGpyf1zXyhePoOxgGgguNdXDX8q6lRxoWjOEHYkqty6bL+z5ULZUUZcT8FDVHubLwKjNqq9fVPPGT0PzeGtJVO+IgbgNJY31W+KXzjBBdk16AY1hWSxr2l33VZ1vEqE2iXKrHcM7mLKIAXCcCL54TQ9LwmhzSOn8bhtNoDhbK6c3iL/12j4aI9Hxe2MPqNtsSMUtMaL5ir13T7TCg6cj9uLnDbC7nroMR+IzskdCL+CcuPr32rUqyKEWfWYShDOTqweBLKMamKi8i2Tn9ulghlpqE2HHkV2xol8rQYItKliYv7yd/I+/L2q83mPFNFBckCrc7KLGGAVn1eD9ulmgXz7hMFhWeJP6RH5npsd11sabcqdPGJvRGH90VLKJLaXi7SHIWNC48Tw/it0qCkUjjJqTlvjvw9nisTy6EdjJFAyipl7iPwS0wTFf/FbF3arhyqnYSVhwyDJhzniSGGaS4s/Q==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6570e046-149e-4eb0-ef6d-08d871839058
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2020 03:28:35.0586 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Za+JBNO9nO7yxxQFdrJvDzvLfrZi26lJ9GZ8DfxoPTk769D+dlT+Q6irxWIYw+nx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1354
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Evan Quan <evan.quan@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Correct Polaris10 setup.

Change-Id: Ia97b0995320ea06264b2b382331ff0b54b801665
Signed-off-by: Evan Quan <evan.quan@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../drm/amd/pm/powerplay/hwmgr/smu_helper.c    | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu_helper.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu_helper.c
index b485f8b1d6f2..2a0ca5194bbe 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu_helper.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu_helper.c
@@ -505,11 +505,23 @@ int phm_initializa_dynamic_state_adjustment_rule_settings(struct pp_hwmgr *hwmgr
 	} else {
 		table_clk_vlt->count = 4;
 		table_clk_vlt->entries[0].clk = PP_DAL_POWERLEVEL_ULTRALOW;
-		table_clk_vlt->entries[0].v = 0;
+		if (hwmgr->chip_id >= CHIP_POLARIS10 &&
+		    hwmgr->chip_id <= CHIP_VEGAM)
+			table_clk_vlt->entries[0].v = 700;
+		else
+			table_clk_vlt->entries[0].v = 0;
 		table_clk_vlt->entries[1].clk = PP_DAL_POWERLEVEL_LOW;
-		table_clk_vlt->entries[1].v = 720;
+		if (hwmgr->chip_id >= CHIP_POLARIS10 &&
+		    hwmgr->chip_id <= CHIP_VEGAM)
+			table_clk_vlt->entries[1].v = 740;
+		else
+			table_clk_vlt->entries[1].v = 720;
 		table_clk_vlt->entries[2].clk = PP_DAL_POWERLEVEL_NOMINAL;
-		table_clk_vlt->entries[2].v = 810;
+		if (hwmgr->chip_id >= CHIP_POLARIS10 &&
+		    hwmgr->chip_id <= CHIP_VEGAM)
+			table_clk_vlt->entries[2].v = 800;
+		else
+			table_clk_vlt->entries[2].v = 810;
 		table_clk_vlt->entries[3].clk = PP_DAL_POWERLEVEL_PERFORMANCE;
 		table_clk_vlt->entries[3].v = 900;
 		if (pptable_info != NULL)
-- 
2.28.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
