Return-Path: <SRS0=gUFK=E2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55791C56202
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Nov 2020 20:20:30 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E37EE22D0A
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Nov 2020 20:20:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="1LqwFdPO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E37EE22D0A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DAC7389A08;
	Fri, 20 Nov 2020 20:20:28 +0000 (UTC)
Received: from NAM04-BN3-obe.outbound.protection.outlook.com
 (mail-eopbgr680040.outbound.protection.outlook.com [40.107.68.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AD6156E916
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Nov 2020 20:20:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SIQVGon8M8bGALzNfHFZJG3uwMAjVYOfAn8XIWDXT/8L+O+2m08TbuArwB4SrNSNfIDj5im3Wjjn2hoWdX8kVewZucENNvyu5Z1kAUENhJyzx7yx2Xuw1084HV5KGmhbN2bCFs2fW88yw08bdF276RgkQJay/FT2DAuFFk3kfRURKKHaWnOJZssXjSdqEvoltTol74lNvGZZvYjFvGLOP3yTJa0ndC8z/IwU2K2t3nvDVg5XZtukt1OEYft730csjYfzVrThI5xRBCXwWTGfnatjwBwbhCNSp45EgTCH0PCfSQeOtBkjSWncW3lvDe84vx87JqVdSzaJF6uKChmX6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jdEPot5YN+K52n7kRcXpwJ6hE/523C9iWPXO7/6kQYo=;
 b=WBwmWr6S5xrhvfNZyqNdTL8X69saP/lcRkYzddDtvW2GlKFEzBcNHnFLMrW9G3DnfvapdiKtIL0iSD8piKgaOXb5TofVChipTsbJV7fMjAv4vHVDc20222ZY093dcD6lwMnxBcJ2DlC2j6Hl3fk2lJWvuDeA55W1R3qJNsgAM8s7jzJsXF3iNS+voAujImxvE8ifOw28N0H4kIpeKrrvRkmqKpDnOobAYbI9cTjZqICNdiFa9IcRn8Ikm439kbtLQS0h9NS80NKP/7rCUHdI2KBoe9jSAOLb/JzLo5A5aUy1IU6WLz9Ssrv0HYjzGKAk5daAc/7+93X2we8OoOMpaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jdEPot5YN+K52n7kRcXpwJ6hE/523C9iWPXO7/6kQYo=;
 b=1LqwFdPOIl/RoTajz4krUqC+Zlw7/zhgbpHdX0CVBw0v9jjOJ5zrpsw3Fu5bX9RgsLsbOlCmA0ULD6zZ7RNexubFeFQoq36SAoRX/3m0T/uWmtA3AcA0g49Dcw2R7d3KukO6gc9wydphUxLlaGwQb+BW1sdUIqZ/Tml9+O5QGRk=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from CH2PR12MB3781.namprd12.prod.outlook.com (2603:10b6:610:27::11)
 by CH2PR12MB3717.namprd12.prod.outlook.com (2603:10b6:610:24::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3564.28; Fri, 20 Nov
 2020 20:20:25 +0000
Received: from CH2PR12MB3781.namprd12.prod.outlook.com
 ([fe80::9d:35d6:ff59:1cfa]) by CH2PR12MB3781.namprd12.prod.outlook.com
 ([fe80::9d:35d6:ff59:1cfa%4]) with mapi id 15.20.3589.024; Fri, 20 Nov 2020
 20:20:25 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 05/18] drm/amd/display: Add DMCU memory low power support
Date: Fri, 20 Nov 2020 15:19:45 -0500
Message-Id: <20201120201958.2455002-6-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201120201958.2455002-1-Rodrigo.Siqueira@amd.com>
References: <20201120201958.2455002-1-Rodrigo.Siqueira@amd.com>
X-Originating-IP: [2607:fea8:56e0:6d60::c908]
X-ClientProxiedBy: CH2PR16CA0025.namprd16.prod.outlook.com
 (2603:10b6:610:50::35) To CH2PR12MB3781.namprd12.prod.outlook.com
 (2603:10b6:610:27::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from atma2.hitronhub.home (2607:fea8:56e0:6d60::c908) by
 CH2PR16CA0025.namprd16.prod.outlook.com (2603:10b6:610:50::35) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3589.20 via Frontend Transport; Fri, 20 Nov 2020 20:20:24 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 5148b9f9-fef2-4c6e-a273-08d88d91b6da
X-MS-TrafficTypeDiagnostic: CH2PR12MB3717:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR12MB371744BEB5AED17760DE1BBE98FF0@CH2PR12MB3717.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: k1wiWAEgGSTj690hotREP82B7Gt8k5lsVlKMUOga5mP4e2eVhREljHUU+LjpZkad43we8CoNj4jhpzjJoZgVeX+vfCwGpIjvW3XcuGl+c1Lt3IOl5bZ6zyD2jxFMo+SVjdIz8xgRylDsor56MJZiy0QeNUJ+dSgHRh0kTNnXU/d+82Sy359EjxgUslnadZiKaIT4OfNn7e7YI3F4I3oMxtJh5XTXUZnKsU/e01ytMZRluxl9UZzMqyP2ktiHbkDMFLcdBqa/k5i1S5La4FO8FrxC7bT/5gDjhj5NLxQiSXqCPTsIryQ78JsMWnOlzml081XPi9gZnLkYg2xdAIkiXA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3781.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(346002)(366004)(39860400002)(376002)(136003)(86362001)(66476007)(6916009)(8676002)(54906003)(6512007)(8936002)(66946007)(52116002)(6506007)(16526019)(83380400001)(5660300002)(2616005)(186003)(1076003)(6486002)(36756003)(478600001)(66556008)(316002)(4326008)(2906002)(6666004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: hKkY3MV0i1B6MDWON3muOi4GzpeVSbVzKehI7ZPpkFkpErAChAiSxwlfh8AoFNlQ9NMWMymt6bz3wg/qMlcWaLDrs3eGAEPIfhculQNQIPw4kQ0Av5zDkFeQgwiz5kJT6JAU5HY84XYUj32k9g4MCIGvojoPL6r8LoWexo+LV2v6MO/2YrXNt7GAKqvwqjzQS6CuTT3mim8PwUcCLNIZDnsYFkuwH3ar72zb8iaFUmjbmdC6Kx0Hpl/WLJtt7oJ9JIVjoEnC8XZALt4G96Q/2NWCIObZxOU/Erz5xkdDYku6gxm7wiJ01Uid43c7FAVcCQn4+mPcIbJDlQrQz2lN2bAnBSM+q6BaKo0RZmd5Qt2VzApOyq7jW9bCScfQsod/CYWpOlzgFjHmr5XeiBD36GpNHltCQb6W8E7ehXqnWzh4aNMYyXexmMYfTq4OP7CpMcZZP7Q2y956so2iF5fc3wxKXTx5pemDrEaX3v1MfDWX8oDswYLKIAFVqTqKxYRRJkKLL+WotYksPFaw7MCGKVOFYXQM6J4wZ8AeRSizLGVbhAsKcFO3a1iy/nCjreWn9tjjKpAsN++yinFCgQ62CbH3PmSLWAI66EWCkem5usk+1/LpMcFyRSBegUxOfNcPyZXutywTrOlPe2pGbh65djurxExSUr+5bSQAUIq98rlyEle9wECcMWF9805A9vG7y53TuJ6YM4Wj3KgJgGn6sJqhQgVpZ2ry06hcqHni4+TKvJqO+MBUAHsoa17Lf/ANKEf0AArSXrMywMMD77bFecWItX70MEuvTk0a7ag/5kQICirPkeDfEC8Tzk/cF5sRbwi+8CUq3pKj19SGqWG2pV3yn6B3egygYSD0KHdXLIXA1suib5xpd6ypZOlUNeD5q1up64LoDI8y6VayOS6sQaiald74fwOBZVyH/vbksi0ER741eyuhxW5T4onzXbyx
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5148b9f9-fef2-4c6e-a273-08d88d91b6da
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3781.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2020 20:20:25.2759 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: weS1o9OXrnES3OLxosKm28exUKW0kMouFyMRxh22P0Cvx3gXi9Uv3VhfJ5gDq3QEjTeZy6HW/iXRneX7zWim5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3717
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
Cc: Eric Yang <eric.yang2@amd.com>, Eryk.Brol@amd.com, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, Aurabindo.Pillai@amd.com, Jacky Liao <ziyu.liao@amd.com>,
 Bhawanpreet.Lakha@amd.com, bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Jacky Liao <ziyu.liao@amd.com>

[Why]
On some platforms, DMCU is no longer used. In these cases, some DMCU
memory should be completely powered off to save power.

[How]
1. Set DMCU_ERAM_MEM_PWR_FORCE to shutdown memory when DMCU is not in
   use
2. Added a debug option to allow this behaviour to be turned off
3. Set all memory low power debug options to off first, to not
   immediately cause problems

Signed-off-by: Jacky Liao <ziyu.liao@amd.com>
Reviewed-by: Eric Yang <eric.yang2@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h                | 2 ++
 drivers/gpu/drm/amd/display/dc/dce/dce_hwseq.h     | 7 +++++--
 drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c | 7 +++++++
 3 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 443b1f1ad546..b170e653febc 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -420,6 +420,8 @@ struct dc_bw_validation_profile {
 union mem_low_power_enable_options {
 	struct {
 		bool i2c: 1;
+		bool dmcu: 1;
+		bool cm: 1;
 		bool mpc: 1;
 		bool optc: 1;
 	} bits;
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_hwseq.h b/drivers/gpu/drm/amd/display/dc/dce/dce_hwseq.h
index ad0ae1f7b513..fe31abfa6c85 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_hwseq.h
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_hwseq.h
@@ -597,6 +597,7 @@ struct dce_hwseq_registers {
 	uint32_t AZALIA_CONTROLLER_CLOCK_GATING;
 	uint32_t HPO_TOP_CLOCK_CONTROL;
 	uint32_t ODM_MEM_PWR_CTRL3;
+	uint32_t DMU_MEM_PWR_CNTL;
 };
  /* set field name */
 #define HWS_SF(blk_name, reg_name, field_name, post_fix)\
@@ -836,7 +837,8 @@ struct dce_hwseq_registers {
 	HWSEQ_DCN2_MASK_SH_LIST(mask_sh), \
 	HWS_SF(, AZALIA_AUDIO_DTO, AZALIA_AUDIO_DTO_MODULE, mask_sh), \
 	HWS_SF(, ODM_MEM_PWR_CTRL3, ODM_MEM_UNASSIGNED_PWR_MODE, mask_sh), \
-	HWS_SF(, ODM_MEM_PWR_CTRL3, ODM_MEM_VBLANK_PWR_MODE, mask_sh)
+	HWS_SF(, ODM_MEM_PWR_CTRL3, ODM_MEM_VBLANK_PWR_MODE, mask_sh), \
+	HWS_SF(, DMU_MEM_PWR_CNTL, DMCU_ERAM_MEM_PWR_FORCE, mask_sh)
 
 #define HWSEQ_DCN301_MASK_SH_LIST(mask_sh)\
 	HWSEQ_DCN_MASK_SH_LIST(mask_sh), \
@@ -1046,7 +1048,8 @@ struct dce_hwseq_registers {
 	type D4VGA_MODE_ENABLE; \
 	type AZALIA_AUDIO_DTO_MODULE; \
 	type ODM_MEM_UNASSIGNED_PWR_MODE; \
-	type ODM_MEM_VBLANK_PWR_MODE;
+	type ODM_MEM_VBLANK_PWR_MODE; \
+	type DMCU_ERAM_MEM_PWR_FORCE;
 
 #define HWSEQ_DCN3_REG_FIELD_LIST(type) \
 	type HPO_HDMISTREAMCLK_GATE_DIS;
diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c
index e76d6ab8d93a..7a7efe9ea961 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c
@@ -462,6 +462,13 @@ void dcn30_init_hw(struct dc *dc)
 		hws->funcs.disable_vga(dc->hwseq);
 	}
 
+	if (dc->debug.enable_mem_low_power.bits.dmcu) {
+		// Force ERAM to shutdown if DMCU is not enabled
+		if (dc->debug.disable_dmcu || dc->config.disable_dmcu) {
+			REG_UPDATE(DMU_MEM_PWR_CNTL, DMCU_ERAM_MEM_PWR_FORCE, 3);
+		}
+	}
+
 	// Set default OPTC memory power states
 	if (dc->debug.enable_mem_low_power.bits.optc) {
 		// Shutdown when unassigned and light sleep in VBLANK
-- 
2.29.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
