Return-Path: <SRS0=V/Q8=BI=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68BFAC433E0
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Jul 2020 02:57:07 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E5CD2076E
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Jul 2020 02:57:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Nl3HAraF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E5CD2076E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EC7786E438;
	Wed, 29 Jul 2020 02:57:06 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2045.outbound.protection.outlook.com [40.107.237.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 76B816E436
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Jul 2020 02:57:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ktCl9i1C2qBwITaeVqSvU3soRC/WBjdB78HSgjH9eyiJfP6QS/e5Moz3xin59LUd2Rp912jLLUGqdze7CxvQXkj5hlaVvK9hVonArioh5+yF06PHuGtvr0iFo8YZ8D5O+IE2M738rBkkl4XOwdHMK3ydvph5Xaac2rNTy+uv+gtYxiAbrAAmvQ7x2Kwr5K+A6h4QGHoCjgJGNfSjixbau1YNitQVpp66TEBaEulxpMhB5JqKhY1snpvAyHtuMVA/SwbTmv6QIG0Z3xeDajw/GRuRWuF2oCfBPSmT+jnpq9oS4uidF5h8PIVcGCcGR0mjZXkdsbVq1quEHX/mR4obhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P37OcHYlJ1C50DZ4H477Sq+eVNO5LNFYETJXj3pv4xY=;
 b=eLaAl2oCaTQOT5zv9/TZTKFvLxsVP+hASasDqpfRVGqupyhDIvNn4BzavKG1UsqCk6N+vIaRxa/P7wzJ8TL5C1pIkpopM3BprtOt60iWjViVQGa8jvstGm+WdqykzfrZRL8fHhdvzVjAQ/bQgFzOnu+uIBSLhjOw7CcQBEzAfjzU/ZBEzmWY1aDFhUMJBmBZsozVjMqP5FZaxQoF2GQYUJy7l658pavNK1ERxKfLVaRleK/K7ecyg34xumTQwdXkNnFjlb51C6YW+zaTU4QD/wxT12ZFFt8Kfio2TOuKjT4hNj7fkuClCrh7IdZgb7Szfucw9psfdjC4m6VqQCa9jA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P37OcHYlJ1C50DZ4H477Sq+eVNO5LNFYETJXj3pv4xY=;
 b=Nl3HAraF1BRtZ+2kcydLPC58z6Ddh5OJVGAZzR4VG5HwjFJoXbQWmJ9ZQyiDRzEzQQdsFc7cDmNvEmU2/umR5lexMc36KPX9MjHj06O3RVt6jZ0FIt7fP1LZy5sEGg/xVsvw4JfMZqGUl9SnkCJgc6jYDz1c8VIfSzhLkxb6Ugk=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from CY4PR12MB1287.namprd12.prod.outlook.com (2603:10b6:903:40::8)
 by CY4PR12MB1285.namprd12.prod.outlook.com (2603:10b6:903:3e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.26; Wed, 29 Jul
 2020 02:56:59 +0000
Received: from CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::e0b1:48e7:bcbc:351c]) by CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::e0b1:48e7:bcbc:351c%11]) with mapi id 15.20.3216.033; Wed, 29 Jul
 2020 02:56:59 +0000
From: Guchun Chen <guchun.chen@amd.com>
To: amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com,
 Hawking.Zhang@amd.com, Dennis.Li@amd.com, andrey.grodzovsky@amd.com,
 Tao.Zhou1@amd.com, John.Clements@amd.com, lijo.lazar@amd.com,
 christian.koenig@amd.com
Subject: [PATCH 02/12] drm/amdgpu: validate bad page threshold in ras
Date: Wed, 29 Jul 2020 10:56:19 +0800
Message-Id: <20200729025629.19355-3-guchun.chen@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200729025629.19355-1-guchun.chen@amd.com>
References: <20200729025629.19355-1-guchun.chen@amd.com>
X-ClientProxiedBy: HK0PR01CA0066.apcprd01.prod.exchangelabs.com
 (2603:1096:203:a6::30) To CY4PR12MB1287.namprd12.prod.outlook.com
 (2603:10b6:903:40::8)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from guchchen-System-Product-Name.amd.com (58.247.170.242) by
 HK0PR01CA0066.apcprd01.prod.exchangelabs.com (2603:1096:203:a6::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.17 via Frontend
 Transport; Wed, 29 Jul 2020 02:56:56 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 98b5f598-c90c-4d9d-fa9c-08d8336b0fa8
X-MS-TrafficTypeDiagnostic: CY4PR12MB1285:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR12MB12856E3329C1C1A9A40B95CCF1700@CY4PR12MB1285.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eM38BuHebbqanSUcN5l+4MyifYcGysoNDAkIw2P0e6WgsfBHrGgb80zXknQvxhyyMbb+yKo2KSR+xfvHvdLQnn6fo/hKzQWU17GzBmmTB2hxklIf5CyQ//LbBeKHH4KE6LrSKVob/i75eZGVo81asCkwvxV04cSbY6dd05vF7ArZJxcafYYMtXovAOXcasGJpeyn+ihs+mfdUKOLGq55vGjQwuEjQ5v/IuZeijFrptzNTmMi5ZR7m7fdMMp2CybWbYb+3iPEsBAkkSuDMr2S7MJ/LrDwxbOPm7un7YP3a36ytF47keeu8HzwlReXUV7tgXBeYVmo435aYzJLsEPVXQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR12MB1287.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(39860400002)(376002)(346002)(136003)(396003)(26005)(2906002)(66946007)(6636002)(52116002)(66556008)(8676002)(86362001)(66476007)(186003)(7696005)(16526019)(6666004)(44832011)(36756003)(5660300002)(4326008)(1076003)(316002)(8936002)(956004)(83380400001)(6486002)(478600001)(2616005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: iWyl0Gg6jFPqQSJSkMSAyZY27ylRr5CSBlvyL7y9RbHCF4z98U9NXwGmfRwPVvM9TIN7lbtmN1ujmyq26aANDZ7lbSdMYHNKngcCeFXw8NpsWaeXU5wz7JB8tMFgTyff0xKaMOoR7FgzvnLZrkJRELJIZdFOsuZZhLkORLiBsxGKrfFXG/X9awYdKYnpEQscMYvqw9RbYo5HLWGdfEXyOv+hxBMe53h/fmFXRWaZGl6d3ucgzRJ+7SmR/ixHdOvKUN60+aoCYhneleUCyb/EkZAO9Q2325erLAqrfhoTGLHWYoRsyy7cscewhYyX5Qz+aLRcSToZSVzijvcAr6RtJ0X9k6XPg09gcvIkJbpVKWTrp3bnzcltsPT2vocxqii9UVjZATDlHJDJUl3x/DUCaJ6HbFtKTCvn8k5CEW6t7xSZ0LhHIViq5anRkyQEKt1wwPm2BVcIlpDv45x7Pj15lD7V9eSSrJWPmsTfoAvcwMPB5waDMmgYK64JtgAW0txo
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98b5f598-c90c-4d9d-fa9c-08d8336b0fa8
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1287.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2020 02:56:59.2673 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oN5lpmNRh3WLKnFRq3qAiC6D7Ldga+RmbdODOmRk8r7h2OTnvWRLOAMj8g4avw/FUVRj57TTRzwjRGV9ML/gsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1285
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
Cc: Guchun Chen <guchun.chen@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Bad page threshold value should be valid in the range between
-1 and max records length of eeprom. It could determine when
saved bad pages exceed threshold value, and proceed corresponding
actions.

v2: When using the default typical value, it should be min
value between typical value and eeprom max records length.

v3: drop the case of setting bad_page_cnt_threshold to be
    0xFFFFFFFF, as it confuses user.

Signed-off-by: Guchun Chen <guchun.chen@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c       | 48 +++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h       |  3 ++
 .../gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c    |  5 ++
 .../gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h    |  2 +
 4 files changed, 58 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 6f06e1214622..3c4c142e9d8a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -69,6 +69,9 @@ const char *ras_block_string[] = {
 /* inject address is 52 bits */
 #define	RAS_UMC_INJECT_ADDR_LIMIT	(0x1ULL << 52)
 
+/* typical ECC bad page rate(1 bad page per 100MB VRAM) */
+#define RAS_BAD_PAGE_RATE		(100 * 1024 * 1024ULL)
+
 enum amdgpu_ras_retire_page_reservation {
 	AMDGPU_RAS_RETIRE_PAGE_RESERVED,
 	AMDGPU_RAS_RETIRE_PAGE_PENDING,
@@ -1700,6 +1703,47 @@ static bool amdgpu_ras_check_bad_page(struct amdgpu_device *adev,
 	return ret;
 }
 
+static void amdgpu_ras_validate_threshold(struct amdgpu_device *adev,
+					uint32_t max_length)
+{
+	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
+	int tmp_threshold = amdgpu_bad_page_threshold;
+	u64 val;
+
+	/*
+	 * Justification of value bad_page_cnt_threshold in ras structure
+	 *
+	 * Generally, -1 <= amdgpu_bad_page_threshold <= max record length
+	 * in eeprom, and introduce two scenarios accordingly.
+	 *
+	 * Bad page retirement enablement:
+	 *    - If amdgpu_bad_page_threshold = -1,
+	 *      bad_page_cnt_threshold = typical value by formula.
+	 *
+	 *    - When the value from user is 0 < amdgpu_bad_page_threshold <
+	 *      max record length in eeprom, use it directly.
+	 *
+	 * Bad page retirement disablement:
+	 *    - If amdgpu_bad_page_threshold = 0, bad page retirement
+	 *      functionality is disabled, and bad_page_cnt_threshold will
+	 *      take no effect.
+	 */
+
+	if (tmp_threshold < -1)
+		tmp_threshold = -1;
+	else if (tmp_threshold > max_length)
+		tmp_threshold = max_length;
+
+	if (tmp_threshold == -1) {
+		val = adev->gmc.mc_vram_size;
+		do_div(val, RAS_BAD_PAGE_RATE);
+		con->bad_page_cnt_threshold = min(lower_32_bits(val),
+						max_length);
+	} else {
+		con->bad_page_cnt_threshold = tmp_threshold;
+	}
+}
+
 /* called in gpu recovery/init */
 int amdgpu_ras_reserve_bad_pages(struct amdgpu_device *adev)
 {
@@ -1777,6 +1821,7 @@ int amdgpu_ras_recovery_init(struct amdgpu_device *adev)
 {
 	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
 	struct ras_err_handler_data **data;
+	uint32_t max_eeprom_records_len = 0;
 	int ret;
 
 	if (con)
@@ -1795,6 +1840,9 @@ int amdgpu_ras_recovery_init(struct amdgpu_device *adev)
 	atomic_set(&con->in_recovery, 0);
 	con->adev = adev;
 
+	max_eeprom_records_len = amdgpu_ras_eeprom_get_record_max_length();
+	amdgpu_ras_validate_threshold(adev, max_eeprom_records_len);
+
 	ret = amdgpu_ras_eeprom_init(&con->eeprom_control);
 	if (ret)
 		goto free;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
index b2667342cf67..4672649a9293 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
@@ -336,6 +336,9 @@ struct amdgpu_ras {
 	struct amdgpu_ras_eeprom_control eeprom_control;
 
 	bool error_query_ready;
+
+	/* bad page count threshold */
+	uint32_t bad_page_cnt_threshold;
 };
 
 struct ras_fs_data {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
index c0096097bbcf..a2c982b1eac6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
@@ -499,6 +499,11 @@ int amdgpu_ras_eeprom_process_recods(struct amdgpu_ras_eeprom_control *control,
 	return ret == num ? 0 : -EIO;
 }
 
+inline uint32_t amdgpu_ras_eeprom_get_record_max_length(void)
+{
+	return EEPROM_MAX_RECORD_NUM;
+}
+
 /* Used for testing if bugs encountered */
 #if 0
 void amdgpu_ras_eeprom_test(struct amdgpu_ras_eeprom_control *control)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h
index 7e8647a05df7..b272840cb069 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h
@@ -85,6 +85,8 @@ int amdgpu_ras_eeprom_process_recods(struct amdgpu_ras_eeprom_control *control,
 					    bool write,
 					    int num);
 
+inline uint32_t amdgpu_ras_eeprom_get_record_max_length(void);
+
 void amdgpu_ras_eeprom_test(struct amdgpu_ras_eeprom_control *control);
 
 #endif // _AMDGPU_RAS_EEPROM_H
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
