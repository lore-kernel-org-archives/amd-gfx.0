Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8C47C00140
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Aug 2022 17:59:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B2A77A12F8;
	Fri,  5 Aug 2022 17:59:18 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2066.outbound.protection.outlook.com [40.107.243.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D100C18A7D8
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Aug 2022 17:59:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fd2rmPeRzKkpzMHTs0B0YOGVyUO/WaoeklT6TAHLYgOBIhhfGuHEDk4MAUyMvyKxELpNZcbZx5JPKTc5AGkl9Obl/M9UfM0oyZPCtt659xZPCI+ax3b5A/URYHbI2uPSY/E0+Ey0q+AA4w4lHUdk5IhpDxVB3fWfp509bwhDuShOxCCuLPx7OBKyMBtafJsuckrbtNcJHdsdra+IOFs6mUj71Wg9AJIhejUCeAYnEaFymkZu3KDir+HNl3iPXgMr5HQOkvBBqhwDiV06GtPJUYn2/XR+iFNbXGvZrd7DftZax6LDsp96NtRYd8ICNcyvR4p9AHivxEgyQvDXlvNsww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YpBN0E4adx4g0AgIEULhK1xJpWevl0mvMb/KKu/XvaU=;
 b=S8SJzf3q5lMFiebIPUA0Om9o8ritrjjOYjonOeXUvNdvWA4MBCkDG1kvQOiEKpOSLOkJ338Ww8Fs3NXO0AZ5cd/p/lmRti+FFh3KgUwKMh5UKNTItEezGH+vFImDhyJxhNtc7YCLQZ+tXpqvJxWfNiscHB5q8swTgo/u7BnZMKv9hST46+tTzNJAU1ulFJZLBGxLZ+Z1pjhBf7WlQJNXgpR7vxSZpxFtL2HAJMWMyKV1D+MiEPe9J36x8kurCLb7Z47DdIdUhuKRAeE3elO82fV1ZSPkU4dpgzKDg2r7EC+124O6s/7K1bNibY4AgOAsjD9tUzmL2NbEocq2xoL5pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YpBN0E4adx4g0AgIEULhK1xJpWevl0mvMb/KKu/XvaU=;
 b=eWFJLio6QPLVhzNK9jEGXzeiE5EDYlXKxuEvBkoir8+tq2pdj35as1WR7lApnY/vOQl+ex3ZEc3fE3uNW0TrnTR3AZoVxTTbEkkiM1P0cMAf4A0BareFJ9/bPExvXzjpFUucG3xXE/T7DB5+XPAu7Ks7PXsE366gr8UODpamiUg=
Received: from MW4PR03CA0173.namprd03.prod.outlook.com (2603:10b6:303:8d::28)
 by MW4PR12MB6729.namprd12.prod.outlook.com (2603:10b6:303:1ed::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.14; Fri, 5 Aug
 2022 17:59:02 +0000
Received: from CO1NAM11FT005.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8d:cafe::e1) by MW4PR03CA0173.outlook.office365.com
 (2603:10b6:303:8d::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.16 via Frontend
 Transport; Fri, 5 Aug 2022 17:59:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT005.mail.protection.outlook.com (10.13.174.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5504.14 via Frontend Transport; Fri, 5 Aug 2022 17:59:02 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 5 Aug
 2022 12:59:00 -0500
Received: from tom-HP.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Fri, 5 Aug 2022 12:58:55 -0500
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 04/32] drm/amd/display: Drop FPU flags from Makefile
Date: Sat, 6 Aug 2022 01:57:58 +0800
Message-ID: <20220805175826.2992171-5-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220805175826.2992171-1-chiahsuan.chung@amd.com>
References: <20220805175826.2992171-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 117b12ac-7823-4c14-357f-08da770c2e14
X-MS-TrafficTypeDiagnostic: MW4PR12MB6729:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8Yn6Kk9vyyKOVtwHkiSMH0KClvA5vspN/vYg2RNrg8+rKBhbBqaAI+Z96VobMvhV2yT05VeaphaX4QWGNGHoECr4pvI1KQiW9fn/DZ3Gz7an3EMdCXqhEh+aO8p68uoMVc8vKUy2OC4KheoCc++KC+QiZ/pKhE3YFOx4WFZgvKDLfZRHrPm67Jl4Ll9gXtnefQxCHjwFY9snfUCFQRdJv00TQfHa2wh/mwjwkZqXI4qWYhxgfh8aix7DYkwR3LNfOt2XGDFyNBm116wkLvc3MQb5H3C5cQlckT1zZY9BQTODKEoZjyFE7jnscYjEmISMQCWPWwC2OyOBBaQlCBZjQBGZbzeLsM3fcadOv36fkrwxzXAstDz34p6GPkedJRkOI9O++BuzMPh6hJIEZ5hk0o+lGKnpYWmjfL2gb2gjdTLVIh4HV+wQ+VwiUJtrjKJZEPOTnKDuWozuZS/kzacbTlsxKRIAu9fcnjK07zI+JINxOtKX29zPOaBAeXrwvKknKE9I5SnCGITbqfTt4mxThKgQpoZJExQR9wUKyEVYcWm16mfS4kB5caPWl8EeLCsLyDsWSf33+8GYwHLfdeFaG/2d6N/EcrQ4l0bl0F6LViB2YwCt/yaPsEQTTMlv87JUChnigQBxDqKMG+YhhW/TuRHrNaTERj6IrumDKhemtF4Uj1TITadS9rjyQ4AlP4F+bu1AoG+QdKdJT4OLzkOGDTRzRPIifAonSRPzkkEsWWbkxek+2jegT8w3AWLETMklj/lty94QkhGB6c9tD90hdS9LkRsDfy28G0Ja5IYNc1aBefUarALOx08Otr08AyD6+dthf89n3k7zJis0yvXtXQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(396003)(376002)(39860400002)(136003)(346002)(40470700004)(46966006)(36840700001)(4326008)(5660300002)(40480700001)(36756003)(70586007)(54906003)(478600001)(8676002)(6916009)(316002)(70206006)(8936002)(7696005)(26005)(47076005)(40460700003)(86362001)(426003)(2616005)(2906002)(186003)(356005)(1076003)(336012)(82740400003)(82310400005)(83380400001)(81166007)(36860700001)(41300700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2022 17:59:02.0860 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 117b12ac-7823-4c14-357f-08da770c2e14
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT005.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6729
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
Cc: stylon.wang@amd.com, Tom Chung <chiahsuan.chung@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>

At this point, we isolate the FPU code associated with DCN314 under the
DML folder. This commit drops the FPU flags from the Makefile.

Reviewed-by: Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
Acked-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 .../gpu/drm/amd/display/dc/dcn314/Makefile    | 25 -------------------
 1 file changed, 25 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn314/Makefile b/drivers/gpu/drm/amd/display/dc/dcn314/Makefile
index e3b5a95e03b1..702c28c2560e 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn314/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/dcn314/Makefile
@@ -13,31 +13,6 @@
 DCN314 = dcn314_resource.o dcn314_hwseq.o dcn314_init.o \
 		dcn314_dio_stream_encoder.o dcn314_dccg.o dcn314_optc.o
 
-ifdef CONFIG_X86
-CFLAGS_$(AMDDALPATH)/dc/dcn314/dcn314_resource.o := -mhard-float -msse
-endif
-
-ifdef CONFIG_PPC64
-CFLAGS_$(AMDDALPATH)/dc/dcn314/dcn314_resource.o := -mhard-float -maltivec
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
-CFLAGS_$(AMDDALPATH)/dc/dcn314/dcn314_resource.o += -mpreferred-stack-boundary=4
-else
-CFLAGS_$(AMDDALPATH)/dc/dcn314/dcn314_resource.o += -msse2
-endif
-endif
-
 AMD_DAL_DCN314 = $(addprefix $(AMDDALPATH)/dc/dcn314/,$(DCN314))
 
 AMD_DISPLAY_FILES += $(AMD_DAL_DCN314)
-- 
2.25.1

