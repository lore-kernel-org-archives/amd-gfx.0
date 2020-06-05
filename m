Return-Path: <SRS0=/kPV=7S=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2E23C433E0
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Jun 2020 11:04:35 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B93C5207D5
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Jun 2020 11:04:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="GeagviBC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B93C5207D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 765246E8CD;
	Fri,  5 Jun 2020 11:04:35 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2055.outbound.protection.outlook.com [40.107.223.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EC3ED6E8CD
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Jun 2020 11:04:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z3VYjw+hlfT0VtGoq70vcsP5Waa7+bfyfAC7P0iuUyXPNXgER3OYBfBede2X8Gvnr3KkoN0rxtTqjrXsqc5OTnNubfJRF3ryM7cMuCZuq+fcxOLJ0IZ6WCWyX24jSYlC7K+g390Ox5Yujzaxr/ofdn0zi0EI070l/+IamSjTqoovIDZX5fbi/1GkkHwBta/4igHjeVtGQm9obR0xupu2KEJ7NaX/EXjbzZaCg5EmDptU3AMQZXHAMK5tSqKnQbt2Fn17QG2Wp6WgeglBKt5MPWGqSdwNj8GrzxYzxH0Mk1xNxeVbPJHXdWdxfwrNc0xtyYnadboaQo+p4KLpffM8mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jh8Dd3jVk7fknKQJ2KGh8k7m13Z54ORAMcAShTLfFT0=;
 b=jlR7ELkxEj3RkGYwDN96zN0IGr2fUwLuFAWVXPgJYfeV5I0uzIoQ9bnWdjWhZHWHJVl9WHtJ4gjQkANoyJAEigKJJGaFnVIwvusdJ+roAVpyB9Qk7Y3YQqIgcYLIKOv8Z6K1qf1CSnyM/gzAhIXAvkAaMYTLdPGRLnBJHeNZql+XxscSv0loaglS3TtkbPrBTHfenshUyKrkMAGR+Xg4IERQMSrGIi9W2F3q87waD2cL0na4lOt3WsNROs1IcG/brjK7E4lYy762OraHMHF6JoO0bk1iZfwIC2OSBfh6PgvvCgXhcnS0r8rTew6WK+MMlnjZDIyJ0W1x3kBm1BNfgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jh8Dd3jVk7fknKQJ2KGh8k7m13Z54ORAMcAShTLfFT0=;
 b=GeagviBCdH6GTNWaJ5PdQu8Nxo5Q8iJl4Y1KwmVa0Wh9wnFvnhAHQIei8gvctDh5kEIvJifhjMe39/yFH4sRQZ1CEU5awAKLalmW6UlVCJKlPDl2LewfN4ngt6RXKJdBEZrzHYk4dOIouRYmoiMA/eOdAGQEgQc0jlE9/Qgd4pE=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB2615.namprd12.prod.outlook.com (2603:10b6:a03:61::29)
 by BYASPR01MB2.namprd12.prod.outlook.com (2603:10b6:a02:ce::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.18; Fri, 5 Jun
 2020 11:04:32 +0000
Received: from BYAPR12MB2615.namprd12.prod.outlook.com
 ([fe80::4c16:1697:3e6d:9157]) by BYAPR12MB2615.namprd12.prod.outlook.com
 ([fe80::4c16:1697:3e6d:9157%7]) with mapi id 15.20.3066.019; Fri, 5 Jun 2020
 11:04:32 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/3] drm/amd/powerplay: drop unnecessary wrappers
Date: Fri,  5 Jun 2020 19:04:10 +0800
Message-Id: <20200605110411.27302-2-evan.quan@amd.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200605110411.27302-1-evan.quan@amd.com>
References: <20200605110411.27302-1-evan.quan@amd.com>
X-ClientProxiedBy: HKAPR04CA0017.apcprd04.prod.outlook.com
 (2603:1096:203:d0::27) To BYAPR12MB2615.namprd12.prod.outlook.com
 (2603:10b6:a03:61::29)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from equan-buildpc.amd.com (58.247.170.242) by
 HKAPR04CA0017.apcprd04.prod.outlook.com (2603:1096:203:d0::27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3066.18 via Frontend Transport; Fri, 5 Jun 2020 11:04:31 +0000
X-Mailer: git-send-email 2.27.0
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 1465869a-cf50-4fab-649f-08d8094039a4
X-MS-TrafficTypeDiagnostic: BYASPR01MB2:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYASPR01MB2FAFA05C924411D1B89A2E4860@BYASPR01MB2.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:605;
X-Forefront-PRVS: 0425A67DEF
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 97lF9wGn1d1+Un+xEeawQL+Mj+/8bFdveX5DeV1lG+Ky9aquIvlShwzI+OH7otbjKE9mdtn/RCYJd44ZwbLGuvwRz6DDDg1DrkbzU+rcG5xE/QfsykBGlgs9M6kSWT6sTsWUEbMJOiYCbZsMP4luy8lF+yTxeMBTCpUYw2eLWjs0rd3pkMKGCVaUJVS2ealvAJgOKC0PgjhlH+Z3wKMmGvW0Np/DyuWipK/LINxRm3/reTEhXphpILV5hdSE+nC/zv7RV7Lz8WssSdzsAUTKp6OnVeNZhz6PrjUOqGCtAAR+gmQlZqPAV8ZsO0dtEcX9t8PYgmfrVbyUU/AePJuN4g==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB2615.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(136003)(346002)(376002)(366004)(39860400002)(4326008)(8676002)(83380400001)(2616005)(1076003)(956004)(8936002)(6486002)(186003)(6666004)(6916009)(2906002)(16526019)(478600001)(66556008)(66946007)(26005)(36756003)(66476007)(5660300002)(52116002)(86362001)(316002)(7696005)(44832011);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: KHronE2hnttsxX0Uubdnr5ZLCbTsObyr1wzbOuL72OJwJFlYp1olDlLDFyEAEz30eBaJGjE8gx7gka46rDV8bUwF//6yrZaBFpbH1POR6zu5nwrb/7hxxufSxTdxuC5JJ5uWG/35bcW6Fn2rkuWWdbYto5gmPqjoCwPTbSrPozsQ0uGNa9q15a7ejv8mQdFhzN9ArYhJe0E5N8NSZIX9u3Es47XyOeDIJAa1+dWxPuqXCs2L7mn+fndfG8R40WEIEgufC6p6xjhLVCiQOJKSXe+9pKoX8/B6mEXpd2/gNHRK8d5ywPx8Z2e0FrmKWH62AbmGUiLFpZ4v1B+DSSMPcvy/2jTFK19ZA5qmq2h3tkpNqg1Xi4oczi0E8BISQTGBEnX8dJQHczaCJkwk3dIYz1FEMDEVZAFIz5eVHLPj+Q30suqR4rMqurlWOg9lH8DAKkkzMTCyPZOrYMtMztsMly4wW+4HFkUa8UQbBEwgaGtB4CZWVbR/yM0NeF9cPxZn
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1465869a-cf50-4fab-649f-08d8094039a4
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2020 11:04:32.5092 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ksCZtglp2Awf92eOCLQEEj6XfkU5JI8bQPcDfluCHHpFdUA8Vfit7eqyhPfrdvyQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYASPR01MB2
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
Cc: alexander.deucher@amd.com, Evan Quan <evan.quan@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

These APIs are used in amdgpu_smu.c only. Thus these wrappers
are unnecessary.

Change-Id: I7768a84e3a7dfbbfa624ac97d94138de52402827
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/powerplay/amdgpu_smu.c   | 24 ++++----------------
 drivers/gpu/drm/amd/powerplay/smu_internal.h |  3 ---
 2 files changed, 4 insertions(+), 23 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
index 00bf24c9ac45..8ea100b3187b 100644
--- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
@@ -1328,8 +1328,8 @@ static int smu_hw_init(void *handle)
 
 	if (smu->is_apu) {
 		smu_powergate_sdma(&adev->smu, false);
-		smu_powergate_vcn(&adev->smu, false);
-		smu_powergate_jpeg(&adev->smu, false);
+		smu_dpm_set_uvd_enable(smu, true);
+		smu_dpm_set_jpeg_enable(smu, true);
 		smu_set_gfx_cgpg(&adev->smu, true);
 	}
 
@@ -1460,8 +1460,8 @@ static int smu_hw_fini(void *handle)
 
 	if (smu->is_apu) {
 		smu_powergate_sdma(&adev->smu, true);
-		smu_powergate_vcn(&adev->smu, true);
-		smu_powergate_jpeg(&adev->smu, true);
+		smu_dpm_set_uvd_enable(smu, false);
+		smu_dpm_set_jpeg_enable(smu, false);
 	}
 
 	if (!smu->pm_enabled)
@@ -2832,19 +2832,3 @@ uint32_t smu_get_pptable_power_limit(struct smu_context *smu)
 
 	return ret;
 }
-
-int smu_powergate_vcn(struct smu_context *smu, bool gate)
-{
-	if (!smu->is_apu)
-		return 0;
-
-	return smu_dpm_set_uvd_enable(smu, !gate);
-}
-
-int smu_powergate_jpeg(struct smu_context *smu, bool gate)
-{
-	if (!smu->is_apu)
-		return 0;
-
-	return smu_dpm_set_jpeg_enable(smu, !gate);
-}
diff --git a/drivers/gpu/drm/amd/powerplay/smu_internal.h b/drivers/gpu/drm/amd/powerplay/smu_internal.h
index bb4eabd6664a..f9041f981daf 100644
--- a/drivers/gpu/drm/amd/powerplay/smu_internal.h
+++ b/drivers/gpu/drm/amd/powerplay/smu_internal.h
@@ -208,7 +208,4 @@ static inline int smu_send_smc_msg(struct smu_context *smu, enum smu_message_typ
 #define smu_log_thermal_throttling(smu) \
 		((smu)->ppt_funcs->log_thermal_throttling_event ? (smu)->ppt_funcs->log_thermal_throttling_event((smu)) : 0)
 
-int smu_powergate_vcn(struct smu_context *smu, bool gate);
-int smu_powergate_jpeg(struct smu_context *smu, bool gate);
-
 #endif
-- 
2.27.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
