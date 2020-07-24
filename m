Return-Path: <SRS0=9uL8=BD=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE8E6C433EA
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Jul 2020 21:06:58 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E9E6206F0
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Jul 2020 21:06:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Mxo0Gwfk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E9E6206F0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 44B196E98C;
	Fri, 24 Jul 2020 21:06:58 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr770071.outbound.protection.outlook.com [40.107.77.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 41B6D6EA08
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 Jul 2020 21:06:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eDTQwHuDlj5+ihBlTUe2pMzuZC9/OmMD8E8KQKo1JVhOCIubfWJfnyAhhvLvrBd3m0YAfQFEZxgfHujoO62QXhy9e2aVCjP/NaQdD/IvKhFCJRytnrzqCPei0G6s3DwkyjRv7cyWM0vhRHg3l7kvWlYXnDBhfmyDsz3dKgwjyYs1sciIDvSxvQ6FNNmEYMsKAB7ei/FRTkqZ+OGXFJTJQvW+KhkICwB/BQy1wzgkQPV3pDwrfNSJiU7+B7CYsc7iKyebM2Q2CaAujmjddEWEc2igAFX20skqc7ZzD7/b/MJfujOOzUAD+9hiu82c7IBoMP5+q0t7QS4vFI4ZS0Cs9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VLNlaTtSp9lEpIyNBE47uRyivjcHu9BEEB+JA8JzGs4=;
 b=Ri8pMReouwZhYHXVvJCWW+wliQj9eBb9ZTfs/Vm7uMJUtXNwhOLl9axZm7oYbqyW52NwVjv5ZV7OBJO591ZT4eGx7f1rDAb4MNf+hDHi7Z8mihuf2NTKQw2/akOX1zvlaauJnTFZ0o24oVSZUTfEWdzgCgEOzNJi0zgRnR+Kp/Wso2NM9aa6/FaTq6V3LSiFNiOhce41nycH8FjV2UerAPgEPaaDxyTAHgEuVF+5vNxcxANpufQD2xT5zE/JGSXHOD1eITVd8zdOfRtJA4vgXbEm3kfy7HUIznlGf3p5c2GrZ53kvyPV1tx1Uj3xXVTjHxnepoe/QQE/UmdMHuDWkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VLNlaTtSp9lEpIyNBE47uRyivjcHu9BEEB+JA8JzGs4=;
 b=Mxo0GwfkNIN5VRirJ6zV6gqS9riNnbF05rYvupurEF9lkyTEZbVleAbwWaoH2/MTT0fRLPaPgeK3X0VEM3UfeVmpohXGSH+XW/ugD6IkCt859NLuYg/9D9kO0XhJf3ZKfSdhVa9OrEDkNrae1hqcLf+WQm5TSRl3KcKReCcEpTY=
Received: from MWHPR10CA0063.namprd10.prod.outlook.com (2603:10b6:300:2c::25)
 by CH2PR12MB4261.namprd12.prod.outlook.com (2603:10b6:610:a9::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.26; Fri, 24 Jul
 2020 21:06:54 +0000
Received: from CO1NAM11FT060.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:2c:cafe::41) by MWHPR10CA0063.outlook.office365.com
 (2603:10b6:300:2c::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.23 via Frontend
 Transport; Fri, 24 Jul 2020 21:06:54 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 CO1NAM11FT060.mail.protection.outlook.com (10.13.175.132) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3216.10 via Frontend Transport; Fri, 24 Jul 2020 21:06:54 +0000
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Fri, 24 Jul
 2020 16:06:52 -0500
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Fri, 24 Jul 2020 16:06:42 -0500
From: Eryk Brol <eryk.brol@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 02/15] drm/amd/display: Rename bytes_pp to the correct bits_pp
Date: Fri, 24 Jul 2020 17:06:05 -0400
Message-ID: <20200724210618.2709738-3-eryk.brol@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200724210618.2709738-1-eryk.brol@amd.com>
References: <20200724210618.2709738-1-eryk.brol@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5cecee31-a7b1-48b1-6c68-08d830157e58
X-MS-TrafficTypeDiagnostic: CH2PR12MB4261:
X-Microsoft-Antispam-PRVS: <CH2PR12MB4261224DC82ABF421A751122E5770@CH2PR12MB4261.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:644;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hqlIhKSCgEE5bhxD2V+v66zbtftKFHF7pqFHCNS2MuP62SR0I7FpwXYWVlVLSICBj7uT/HU/o81GYC8ZFVODB7dTQeum93rT101F8yv0xTlLr8QoZLQbfFvqLJnes5yl5lX/5tcJzeWRulX5lK2pi5NipbaMUSClgDUGjbaADoCkdCw3rAd92CGFbmF1QIYWqJS1S/6by8EX8HMVjFK9FOWbyn53SKvY0BopOElax+YqH+rH9tYIxQpfRBEezMEM1j+Lms2OtSaYKwVW1kZQFdOHE4n24ANlEwj4JDwiyB11gDsU0DEVNImxJs1RnVnncu2HnlEwQMejVzX0s6sAuodGW20l096k73HLCNvYdzLAUoi8njtpC+uM5xC9dhfHcpJ3syl6zPF7dKuR2DHU9w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(376002)(396003)(39860400002)(346002)(46966005)(44832011)(70206006)(8936002)(186003)(54906003)(5660300002)(83380400001)(2616005)(6916009)(70586007)(6666004)(26005)(82740400003)(81166007)(36756003)(316002)(478600001)(426003)(356005)(86362001)(336012)(4326008)(82310400002)(2906002)(47076004)(8676002)(1076003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2020 21:06:54.2247 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cecee31-a7b1-48b1-6c68-08d830157e58
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT060.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4261
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
Cc: Eryk Brol <eryk.brol@amd.com>, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 Mikita Lipski <Mikita.Lipski@amd.com>, Bhawanpreet.Lakha@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Why]
Struct dcn_dsc_state is used for reading current state
and parameters of DSC on a pipe, the target rate parameter
uses bytes per pixel even though its reading BITS_PER_PIXEL
register.

[How]
Changing it to Bits Per Pixel for consistency.

Signed-off-by: Eryk Brol <eryk.brol@amd.com>
Signed-off-by: Mikita Lipski <mikita.lipski@amd.com>
Reviewed-by: Mikita Lipski <Mikita.Lipski@amd.com>
Acked-by: Eryk Brol <eryk.brol@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c | 2 +-
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c | 4 +++-
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dsc.c          | 2 +-
 drivers/gpu/drm/amd/display/dc/inc/hw/dsc.h               | 2 +-
 4 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
index 8bbf54ffe01b..3dd7da16cc18 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
@@ -1204,7 +1204,7 @@ static ssize_t dp_dsc_bytes_per_pixel_read(struct file *f, char __user *buf,
 
 	snprintf(rd_buf_ptr, str_len,
 		"%d\n",
-		dsc_state.dsc_bytes_per_pixel);
+		dsc_state.dsc_bits_per_pixel);
 	rd_buf_ptr += str_len;
 
 	while (size) {
diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
index da0897fe3b54..a643927e272b 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
@@ -390,6 +390,8 @@ void dcn10_log_hw_state(struct dc *dc,
 	}
 	DTN_INFO("\n");
 
+	// dcn_dsc_state struct field bytes_per_pixel was renamed to bits_per_pixel
+	// TODO: Update golden log header to reflect this name change
 	DTN_INFO("DSC: CLOCK_EN  SLICE_WIDTH  Bytes_pp\n");
 	for (i = 0; i < pool->res_cap->num_dsc; i++) {
 		struct display_stream_compressor *dsc = pool->dscs[i];
@@ -400,7 +402,7 @@ void dcn10_log_hw_state(struct dc *dc,
 		dsc->inst,
 			s.dsc_clock_en,
 			s.dsc_slice_width,
-			s.dsc_bytes_per_pixel);
+			s.dsc_bits_per_pixel);
 		DTN_INFO("\n");
 	}
 	DTN_INFO("\n");
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dsc.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dsc.c
index ba50214d6c32..79b640e202eb 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dsc.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dsc.c
@@ -156,7 +156,7 @@ static void dsc2_read_state(struct display_stream_compressor *dsc, struct dcn_ds
 
 	REG_GET(DSC_TOP_CONTROL, DSC_CLOCK_EN, &s->dsc_clock_en);
 	REG_GET(DSCC_PPS_CONFIG3, SLICE_WIDTH, &s->dsc_slice_width);
-	REG_GET(DSCC_PPS_CONFIG1, BITS_PER_PIXEL, &s->dsc_bytes_per_pixel);
+	REG_GET(DSCC_PPS_CONFIG1, BITS_PER_PIXEL, &s->dsc_bits_per_pixel);
 	REG_GET(DSCC_PPS_CONFIG3, SLICE_HEIGHT, &s->dsc_slice_height);
 	REG_GET(DSCC_PPS_CONFIG1, CHUNK_SIZE, &s->dsc_chunk_size);
 	REG_GET(DSCC_PPS_CONFIG2, PIC_WIDTH, &s->dsc_pic_width);
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/dsc.h b/drivers/gpu/drm/amd/display/dc/inc/hw/dsc.h
index 5915994f9eb8..f520e13aee4c 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/dsc.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/dsc.h
@@ -55,7 +55,7 @@ struct dsc_optc_config {
 struct dcn_dsc_state {
 	uint32_t dsc_clock_en;
 	uint32_t dsc_slice_width;
-	uint32_t dsc_bytes_per_pixel;
+	uint32_t dsc_bits_per_pixel;
 	uint32_t dsc_slice_height;
 	uint32_t dsc_pic_width;
 	uint32_t dsc_pic_height;
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
