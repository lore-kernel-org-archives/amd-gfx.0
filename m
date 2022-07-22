Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4A90C433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Jul 2022 20:39:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6E224937B6;
	Fri, 22 Jul 2022 20:39:50 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2047.outbound.protection.outlook.com [40.107.220.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8D76E92E26
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 Jul 2022 20:39:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FNHkxl32MBTm3uBD3ccU382d90VQCq/8VBGuazW91x+lVwzfMBHDFwpF/45htc19F2G+jZJD8OofPtzHvBYxsXOhryuahtmSrodvzbvyzAQpsIO2R438nfJCi5t3euQmDu73xAsFNU/avr6F4x6BUOk5xAgSoSF7tkOdEA4ySnFWMOa2qgcdFDqfwm6E3sgMbhzwpOmQULe7mWlkVYMOUxg9qRTEDTyygCmPca4mTKB636ywv0YMUZMoWq9tcMseldJZGy9n89YXOJe9Fz0Jmxj2cgHLY/oqAQ0tUk9oRlDV5KpYnpzszWfThQJsoHNKQAZ/dZK4t2XyE3PEERPnkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WqjVP7d/ealDbFRs/AP/xndCp8v6wJrb/SbOIR7u3vo=;
 b=OC79+OaSRXgCzCd7Aho0hm0P8TMA9DAlYKFprzuB/Kof86K2f1Tm4AZ9ruDg8HSvdABq5xKmUv4DyoE5dQ2z4/ZL7aVUCIZEMKvF6Z4PVs526tHDsm56V0vcq4Lp23BmJxHd/pHlmh8QJppxNbdxkT9TnO6dzb7stObTL4qWxq7MFzBB8soR7B6hvAqsG26F75sJyOXgTcGgmKf1uCTDYIXTvSvh1nNKQGQ2dkw02RYoGmqCkcTPYT2KbvznnIQmYeBSXnV4Kqz16HS0RaBD1BhBub5NrH1RhUvwb8RgIsgJasAIWPiV3SPlphxb9zIuLKO0+pSLLL7jc29MN/Oldw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WqjVP7d/ealDbFRs/AP/xndCp8v6wJrb/SbOIR7u3vo=;
 b=gRg6UV/MXcBfCopTStJ3p0aw4Z/3t+7hBcC3JvoPfmkeqj/ZtmqWRvJOUhHM7VdegswnytcKST1EsTttXFqe6oDdkoT+XewRgxfe0Um5QMMmwv0rItjflbgGHYkZzh72bAWSNMyQWVMDGp4Gf9tMN0YOiip9jFwkjfisl/hLc1c=
Received: from MW4P222CA0008.NAMP222.PROD.OUTLOOK.COM (2603:10b6:303:114::13)
 by DS7PR12MB6069.namprd12.prod.outlook.com (2603:10b6:8:9f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.19; Fri, 22 Jul
 2022 20:39:47 +0000
Received: from CO1NAM11FT017.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:114:cafe::42) by MW4P222CA0008.outlook.office365.com
 (2603:10b6:303:114::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.23 via Frontend
 Transport; Fri, 22 Jul 2022 20:39:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT017.mail.protection.outlook.com (10.13.175.108) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5458.17 via Frontend Transport; Fri, 22 Jul 2022 20:39:47 +0000
Received: from dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 22 Jul
 2022 15:39:38 -0500
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 10/31] drm/amd/display: Drop unnecessary FPU flags on dcn302
 files
Date: Fri, 22 Jul 2022 14:31:16 -0600
Message-ID: <20220722203137.4043516-11-alex.hung@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: d874de72-d1c4-4ccd-7b8e-08da6c225161
X-MS-TrafficTypeDiagnostic: DS7PR12MB6069:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NM9vPhMYTix1QXnNXxp8/qgEEbLtTuhFc8YI1N2GTmGlRDdFYmTqoidXvshliuHeqIwLvSMY9coZ7JPbAkToXMUDv/1jHJUVSmJZrvqi2idxL26qr4QczadGtINsp3ifgVGjjEFJD4TBIgnGE3/N1BcELftNan6CZCnt1cMghuFk6HQiq8NhplBg4TVI3NUewBJ4sCD8BxGXR10ywMYyHCGwH8cHeOnNKw15zCVTwaZjlrg0rCQ88Va5qm5AU5h6pvRrjXgoeSifBKVQInH+KKjMncW0+K65bHw3HgF04jvHRBtCliz/6tZqwZDGJXgkBdryRWzJoqwT6Lr2yP8mjWJ174kyFdvkhRdnVtHM74yBW3L1WUiciE2TfWC+pUvt+djDnAsaOwb4PzjQSb2zN9hqqo9LwuHYXbnj7tL3wKKmA39zaCi9S4lHHSXkfpQNMbhy1ZtBiDP9lC8ur/UdKs3BGUmCerv4nD+MIizixX7m4TKqZJQA9Gx8SlquhhKMroaUl9GvXkjktmI72Mw9yQQd877GUJanrP+ZyUPC7AwWjKEFhgx9WEYevNoDJI9UG0psJ6vMxsn2vafZvtMdsEf+VjHuASI2YpQkG8GdEfNayIaCRfvd9OMjQ+6qfbfxK4dXQd53Ob2R2LyamzI7s1tv0XopQDoVRodaUpXJPkCqOLhmoUueSWC4PATs1vOyL8GGHY6zLaz6cGHpAMaL70gV1hFpDvF4uJyNY9V9qYKYPwMck3jh2QN63tbQkXh60eyHJULouOVLmu8zHiIB7v2WIbnTCzxt19c3Kdtl60AAchtpo496VXsyipmaceIoNe1VxaEzVrZFvaoqtAJM6Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(376002)(136003)(39860400002)(396003)(346002)(36840700001)(40470700004)(46966006)(41300700001)(316002)(6916009)(40480700001)(54906003)(82310400005)(2906002)(44832011)(478600001)(8676002)(70206006)(70586007)(4326008)(40460700003)(2616005)(5660300002)(36860700001)(7696005)(36756003)(82740400003)(86362001)(8936002)(81166007)(1076003)(16526019)(336012)(6666004)(26005)(356005)(47076005)(426003)(186003)(83380400001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2022 20:39:47.4502 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d874de72-d1c4-4ccd-7b8e-08da6c225161
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT017.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6069
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

We already isolated the DCN302 code in the DML folder, but we forgot to
drop the FPU flags from the Makefile. This commit drops those flags.

Reviewed-by: Harry Wentland <Harry.Wentland@amd.com>
Acked-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 .../gpu/drm/amd/display/dc/dcn302/Makefile    | 25 -------------------
 1 file changed, 25 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn302/Makefile b/drivers/gpu/drm/amd/display/dc/dcn302/Makefile
index e4b69ad0dde5..ebd01cb467b7 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn302/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/dcn302/Makefile
@@ -7,31 +7,6 @@
 
 DCN3_02 = dcn302_init.o dcn302_hwseq.o dcn302_resource.o
 
-ifdef CONFIG_X86
-CFLAGS_$(AMDDALPATH)/dc/dcn302/dcn302_resource.o := -mhard-float -msse
-endif
-
-ifdef CONFIG_PPC64
-CFLAGS_$(AMDDALPATH)/dc/dcn302/dcn302_resource.o := -mhard-float -maltivec
-endif
-
-ifdef CONFIG_X86
-ifdef CONFIG_CC_IS_GCC
-ifeq ($(call cc-ifversion, -lt, 0701, y), y)
-IS_OLD_GCC = 1
-endif
-endif
-
-ifdef IS_OLD_GCC
-# Stack alignment mismatch, proceed with caution.
-# GCC < 7.1 cannot compile code using `double` and -mpreferred-stack-boundary=3
-# (8B stack alignment).
-CFLAGS_$(AMDDALPATH)/dc/dcn302/dcn302_resource.o += -mpreferred-stack-boundary=4
-else
-CFLAGS_$(AMDDALPATH)/dc/dcn302/dcn302_resource.o += -msse2
-endif
-endif
-
 AMD_DAL_DCN3_02 = $(addprefix $(AMDDALPATH)/dc/dcn302/,$(DCN3_02))
 
 AMD_DISPLAY_FILES += $(AMD_DAL_DCN3_02)
-- 
2.37.1

