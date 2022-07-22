Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E640C433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Jul 2022 20:41:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DABB211BC1A;
	Fri, 22 Jul 2022 20:41:02 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6B817112EC2
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 Jul 2022 20:40:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=idz79WGXzOk94T6zzlj6+WLsgFRluLCTF8Jln12Uew1rK/vTyFb7so4EKdQL1Thj1UH7mvm9zZrFajO6956eLfOZx9N/Pc/JcwKubmHEygz7+uF49HiXsOiZEjCcrswXvLQBzccf86K6UDO7kSc60CPcTPuL40tppn9d/euqNGIKxCOJeMMrheczpmqzw0PMRGJ4SA2woo7wdQQ15GqTWTyhdXFoGWUiPz8jlLjxZA4r/uuRhYygUYGvi3VtSD2dsLP1SQkOwmHJ+w/HgcFqr1WR+mHZboK3yH2i2xDovY8FT71u68JGTUJiO76IQHNRGxY2yITsq5q/7Y66osMmrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ts34PB7jZmZf5DdTDysLX/BaLqU4bvqT9RQEo2rFkAU=;
 b=EF1S07pHey7zW8yKKZrQd6+pKhUXAlU8hpSqzT2smhmukKjnpyE2QHTDQ1YfT+MerJ9xCb/3p96j9x7RlSLCvNIVhciwSmMlTMApQkniotThe0+puzqItiWBXX5+XhFD0klfyJpjcE9hZ4w8dPZLz88BTJWA0SuzZZ7nAslce9AlkMijgNlf9jOzuo0IUH079YkkvZuxprfDykXQb6dI8lL17zCk06T7Wn51RhGaayYmtcDGw037snm/ERiDMTpfx2erOBx5WM+JxPfN+AV/o6+qJoj7FbiGMmzpuTpc+t3uMOyk2NExtsp80nZqRiNwGxRaqLu+KXYFgtmoRAeQ9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ts34PB7jZmZf5DdTDysLX/BaLqU4bvqT9RQEo2rFkAU=;
 b=QhWaNPD4YXf0jWg/4M5+eaIt7k8e7oXeQeu1b4hCb4/UfCtCIkw69KtpPlsDrYEIUiF9atrKGgq8zThtvive1j1GdKXvREuPo1VqcKLXj8RTwD7tYEta0OJGBURuuD7+IB/PVF4QECKXESQCQgTGlDNQPTzpTuI5LO9SGBsD6qU=
Received: from MW3PR05CA0003.namprd05.prod.outlook.com (2603:10b6:303:2b::8)
 by CY4PR1201MB0102.namprd12.prod.outlook.com (2603:10b6:910:1b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.19; Fri, 22 Jul
 2022 20:40:54 +0000
Received: from CO1NAM11FT016.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:2b:cafe::29) by MW3PR05CA0003.outlook.office365.com
 (2603:10b6:303:2b::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.1 via Frontend
 Transport; Fri, 22 Jul 2022 20:40:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT016.mail.protection.outlook.com (10.13.175.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5458.17 via Frontend Transport; Fri, 22 Jul 2022 20:40:53 +0000
Received: from dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 22 Jul
 2022 15:40:45 -0500
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 15/31] drm/amd/display: Remove FPU flags from DCN30 Makefile
Date: Fri, 22 Jul 2022 14:31:21 -0600
Message-ID: <20220722203137.4043516-16-alex.hung@amd.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220722203137.4043516-1-alex.hung@amd.com>
References: <20220722203137.4043516-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c45f2445-ebb7-4782-aaa7-08da6c2278de
X-MS-TrafficTypeDiagnostic: CY4PR1201MB0102:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uox49PoLMXaXNsYcMlcScgYOKjCquDM48jphwoD3ShxvW9bU3qrh/X4oeoPqw/FV5o4zFl29HarjC3a3J+xpxZ0TMP5nvG/45SykSjkYmaRUfMcs5pMsWiev0E2LsC9WxIYBFYtjI+ZQgeTxcFZeh5LqSpAZYF4H4+FkKCJ7pRxLYGPrFoQ20/VCZ6QJYC0ERK5SHfvtnf5bHtMMkB2VWMEZpOBQ+clgPRslHUsBTIAtDvFLe0nE7z9EzMA9cWZn/M8vxKsMgeY4B6llt7NkkFx4jdhkWm7C1sCykfyu8EGnruNzjmeWkUsoHQEY7UFj5TavprYcYFFnPrGxM9wp+0rDrWwjbJjwecEOZV4OxH+hln/VKTGg/gaoa36FhmTcxnmwd34BboOboCUcSZzizAF00IeS3pQg1s1/WQQH1uzm5y7HJPYNunPT/COCNtLP9CRobVzd+r2N3PjOHOZbJdEol3iCeedqbHgR8zWUCETIFk22fe+0305+pqneQOxmqLXU4AD73Bx0Ls2BWwGbmEF/QdYpC/ZIQM6Pr1DcVkAxb+1tJvg4JybijzHZbwFTdq2+AckgdDLmhvGxIulF3YIdocN7iSig+DOSAqjYaNNw2FZG/3Znm27C9e+pGtrvlJXdpbbBNgjaYvREjWcUDtjPFj9OsoS+UuMe+qjllyU3Lwc5zjCQEE67Q4jNCDX82tvnvp6un+uv9xvPtLFyDMKmgLQE5AiEsOc8li6ZubekRj3c1NY+5Q0vah5CeylqjlDL8hE0YTzoXEyu0M6Yo7zyRw7tPENqRjvVy140NthA9sN/VGvHfye2XSNhfSN05CVcIAMSmNbbfjIYLsNzBg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(39860400002)(396003)(346002)(376002)(136003)(46966006)(36840700001)(40470700004)(186003)(2616005)(26005)(82310400005)(6666004)(316002)(82740400003)(44832011)(1076003)(41300700001)(16526019)(478600001)(36860700001)(2906002)(5660300002)(47076005)(336012)(36756003)(8676002)(86362001)(426003)(4326008)(7696005)(70586007)(6916009)(356005)(54906003)(40460700003)(81166007)(83380400001)(40480700001)(8936002)(70206006)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2022 20:40:53.7018 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c45f2445-ebb7-4782-aaa7-08da6c2278de
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT016.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB0102
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
Cc: stylon.wang@amd.com, mark.broadworth@amd.com, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com, daniel.wheeler@amd.com,
 Aurabindo.Pillai@amd.com, Alex Hung <alex.hung@amd.com>, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>

At this stage, we must have all the FPU code for DCN30 isolated in the
DML folder. Drop FPU flags from Makefile.

Reviewed-by: Harry Wentland <Harry.Wentland@amd.com>
Acked-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn30/Makefile | 30 -------------------
 1 file changed, 30 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/Makefile b/drivers/gpu/drm/amd/display/dc/dcn30/Makefile
index c20331eb62e0..b7c2ae9ddfda 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/Makefile
@@ -30,36 +30,6 @@ DCN30 = dcn30_init.o dcn30_hubbub.o dcn30_hubp.o dcn30_dpp.o dcn30_optc.o \
 	dcn30_dpp_cm.o dcn30_dwb_cm.o dcn30_cm_common.o dcn30_mmhubbub.o \
 	dcn30_dio_link_encoder.o dcn30_resource.o
 
-
-ifdef CONFIG_X86
-CFLAGS_$(AMDDALPATH)/dc/dcn30/dcn30_resource.o := -mhard-float -msse
-CFLAGS_$(AMDDALPATH)/dc/dcn30/dcn30_optc.o := -mhard-float -msse
-endif
-
-ifdef CONFIG_PPC64
-CFLAGS_$(AMDDALPATH)/dc/dcn30/dcn30_resource.o := -mhard-float -maltivec
-CFLAGS_$(AMDDALPATH)/dc/dcn30/dcn30_optc.o := -mhard-float -maltivec
-endif
-
-ifdef CONFIG_CC_IS_GCC
-ifeq ($(call cc-ifversion, -lt, 0701, y), y)
-IS_OLD_GCC = 1
-endif
-endif
-
-ifdef CONFIG_X86
-ifdef IS_OLD_GCC
-# Stack alignment mismatch, proceed with caution.
-# GCC < 7.1 cannot compile code using `double` and -mpreferred-stack-boundary=3
-# (8B stack alignment).
-CFLAGS_$(AMDDALPATH)/dc/dcn30/dcn30_resource.o += -mpreferred-stack-boundary=4
-CFLAGS_$(AMDDALPATH)/dc/dcn30/dcn30_optc.o += -mpreferred-stack-boundary=4
-else
-CFLAGS_$(AMDDALPATH)/dc/dcn30/dcn30_resource.o += -msse2
-CFLAGS_$(AMDDALPATH)/dc/dcn30/dcn30_optc.o += -msse2
-endif
-endif
-
 AMD_DAL_DCN30 = $(addprefix $(AMDDALPATH)/dc/dcn30/,$(DCN30))
 
 AMD_DISPLAY_FILES += $(AMD_DAL_DCN30)
-- 
2.37.1

