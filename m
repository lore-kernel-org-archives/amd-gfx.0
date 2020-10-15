Return-Path: <SRS0=r20P=DW=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80A87C433E7
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Oct 2020 18:21:18 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC85620760
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Oct 2020 18:21:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="I42Xb/rY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC85620760
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8CE406E1A2;
	Thu, 15 Oct 2020 18:21:17 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2089.outbound.protection.outlook.com [40.107.244.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1225E6E1A2
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Oct 2020 18:21:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BDCemtJg/URP6Cny1opUYvCbppaUJM8+7/62HVk7igbh/l3DZxefXpQBYl5y+ttQLhRj01H0m14lbKadRMl0noQpYoXhWslph5JA8CFwmXiqGSKt1qWEn/GpKdRDM0Rj0YUszsHWc4Np6+KvJem3RrPO14YtluVH7xzGHocKQwJ9pIHypcV7nIb4TH+S6BzndQ0sUoMCzE+Sq0WFw8bSm5o9jbCpJ+Rmd8phiCGkA2BREiDsweavpkDfNQjTnaE8FNjSV0uSXXvErpDcCrfvd0B1sdaQ9ATWcezt2K75SrnsjgSUbnHg11VsVwj1E5Jp0Bd/Rrb39sIT+kOj92YrAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IHRH18TWjVW/S1sULvhikWqVSzf3dnlRhxmD3mkB79Y=;
 b=U1POwqUmiweeYjDaDmZhCbSvFCe4mJdH8+cRwidyV013WrIvk6U+mqIGDteSfUFKLtc99imdjbt4SDLbKASUZHDnoGupJgaxsXmXsrZRGgWRcRhO8u+I5myVOkSE3MVzmiG9dwbERTmp3Edd0eh/m2s9/37wjAmzBz3YOgHDolfK8lhsIzi2JsOX32QoWS0QYZJHio4j6UhpVlePiurO8lDLwmHeqPJJUqMzyE8euYNY5IJVIJR2Gvvy5gkXsSWQ5cED1MCdHLC7iIiHJ5c5v5NU1PLK6i8pvcwWmAjgkLUHGiy2/VeY2Strj+Dns0220lP+e/0VVY3IjaNNk9pDpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=none action=none header.from=amd.com; dkim=none (message not signed);
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IHRH18TWjVW/S1sULvhikWqVSzf3dnlRhxmD3mkB79Y=;
 b=I42Xb/rYnj9bNks5om44qVStQdTD7sguVsWLoVbW/Ybp+VHRLcxYgGRTq87uFeCJKwpe2TFfjDs/rJHn6ohrZIhae9FmBt8nJ/YtRoSZLiaLl+0aHrxv98OzMuL9X/tVqDSrn40yBsV6L1D0CbXr4ASXGh+g2WG37WmySmrZRIA=
Received: from DM3PR12CA0106.namprd12.prod.outlook.com (2603:10b6:0:55::26) by
 DM6PR12MB4434.namprd12.prod.outlook.com (2603:10b6:5:2ad::12) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3477.20; Thu, 15 Oct 2020 18:21:14 +0000
Received: from DM6NAM11FT048.eop-nam11.prod.protection.outlook.com
 (2603:10b6:0:55:cafe::8) by DM3PR12CA0106.outlook.office365.com
 (2603:10b6:0:55::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.20 via Frontend
 Transport; Thu, 15 Oct 2020 18:21:14 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=none action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 DM6NAM11FT048.mail.protection.outlook.com (10.13.173.114) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3477.23 via Frontend Transport; Thu, 15 Oct 2020 18:21:14 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Thu, 15 Oct
 2020 13:21:14 -0500
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Thu, 15 Oct
 2020 13:21:13 -0500
Received: from blakha.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Thu, 15 Oct 2020 13:21:13 -0500
From: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
To: <nicholas.kazlauskas@amd.com>, <alexander.deucher@amd.com>
Subject: [PATCH 2/2] drm/amd/display: Fix DCN302 makefile
Date: Thu, 15 Oct 2020 14:20:04 -0400
Message-ID: <20201015182004.4079457-2-Bhawanpreet.Lakha@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201015182004.4079457-1-Bhawanpreet.Lakha@amd.com>
References: <20201015182004.4079457-1-Bhawanpreet.Lakha@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 81819e3b-229e-4fc9-04d9-08d871371a0d
X-MS-TrafficTypeDiagnostic: DM6PR12MB4434:
X-Microsoft-Antispam-PRVS: <DM6PR12MB4434FD7CB9EA7AD38AD04D66F9020@DM6PR12MB4434.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:198;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: x7af2AG3yHoTX3GN6dLm4HPJ8TuFUSK6X94Eqm76BDJdhQ3aemNC7+Mrm2nd9uddEzNIY8aWy8sBtMJztp+l9drMprlNs6gCQ6Yy5dUNaFWxpetQ+rcbxUqLD+LEzOWu4lbycX2BkLSNjBYyI8i9kVmDVd/Y1Y3yWZBAiSHH2m8bosFzm3j2bBHaDd68RAlgB9dkoMjGkkVnfEjPjdywlRnvcqR4YnT1UINNw8Yiu1KwT1pO5FpvKEyg4h0cjmupVyF1Q2C3pGWqwTa0ITvc+Mzzppa/DU5Ac5CZIgRd5SHzJqgFAXFK6+llpEpbyZexrfIckzNDSLAPEcizvdah3NUb2CA/4tloOt482Prz3X9SxtYro7SAovu1yx0A7ps0hTqxBQyZS+AY+m3x6G9Eig==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(39860400002)(376002)(346002)(396003)(136003)(46966005)(6636002)(6666004)(70206006)(356005)(7696005)(110136005)(26005)(336012)(4326008)(2616005)(426003)(54906003)(186003)(1076003)(478600001)(316002)(82310400003)(5660300002)(70586007)(86362001)(2906002)(36756003)(47076004)(81166007)(8936002)(82740400003)(8676002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2020 18:21:14.6166 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 81819e3b-229e-4fc9-04d9-08d871371a0d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT048.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4434
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
Cc: rodrigo.siqOFueira@amd.com, Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>,
 amd-gfx@lists.freedesktop.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Some setups will fail to build. So copy dcn301 makefile setup
which is known to work

Signed-off-by: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
---
 .../gpu/drm/amd/display/dc/dcn302/Makefile    | 29 +++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn302/Makefile b/drivers/gpu/drm/amd/display/dc/dcn302/Makefile
index 3ea9bff27912..36e44e1b07fa 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn302/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/dcn302/Makefile
@@ -12,6 +12,35 @@
 
 DCN3_02 = dcn302_init.o dcn302_hwseq.o dcn302_resource.o
 
+ifdef CONFIG_X86
+CFLAGS_$(AMDDALPATH)/dc/dcn302/dcn302_resource.o := -mhard-float -msse
+endif
+
+ifdef CONFIG_PPC64
+CFLAGS_$(AMDDALPATH)/dc/dcn302/dcn302_resource.o := -mhard-float -maltivec
+endif
+
+ifdef CONFIG_ARM64
+CFLAGS_REMOVE_$(AMDDALPATH)/dc/dcn302/dcn302_resource.o := -mgeneral-regs-only
+endif
+
+ifdef CONFIG_CC_IS_GCC
+ifeq ($(call cc-ifversion, -lt, 0701, y), y)
+IS_OLD_GCC = 1
+endif
+endif
+
+ifdef CONFIG_X86
+ifdef IS_OLD_GCC
+# Stack alignment mismatch, proceed with caution.
+# GCC < 7.1 cannot compile code using `double` and -mpreferred-stack-boundary=3
+# (8B stack alignment).
+CFLAGS_$(AMDDALPATH)/dc/dcn302/dcn302_resource.o += -mpreferred-stack-boundary=4
+else
+CFLAGS_$(AMDDALPATH)/dc/dcn302/dcn302_resource.o += -msse2
+endif
+endif
+
 AMD_DAL_DCN3_02 = $(addprefix $(AMDDALPATH)/dc/dcn302/,$(DCN3_02))
 
 AMD_DISPLAY_FILES += $(AMD_DAL_DCN3_02)
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
