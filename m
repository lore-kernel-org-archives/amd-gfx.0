Return-Path: <SRS0=G8as=BB=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53DF0C433E1
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Jul 2020 03:14:51 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 22653207CD
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Jul 2020 03:14:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="WdgeeyQ6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22653207CD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CDCBC6E2BC;
	Wed, 22 Jul 2020 03:14:50 +0000 (UTC)
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-eopbgr760073.outbound.protection.outlook.com [40.107.76.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3232F6E2BC
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Jul 2020 03:14:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CUQzK+LZcY7YFGFhxjK3Omz8DIZJEKF18P8Ddt1ooyDgGnjcbMFUBzP6DSlhbQxO5uPcebDL5z2FFbXSfKkKYfbm8SdopwsvKXvznR2isOZE5kpY4KOUDsmf0eAth8b/OfaV9idEkwPd2447TpZl2S2FMncPgytJrC03L05pqDnxCv2Ckbh2YvLpcuUdVmN3VU+K/lK9T9mpgV5mNQNZKVw8i2WImspQ/J6yvmfJJDGni/IRPMGwMjziUYn9zNiEFPbfrUlIAXekEyGrfpS5QlKN5kmU+jcnlcmERJYPV7B0mz+E6jkpm5O6RzE9xRKRCpoXcdcfAPszMDOvgLKq6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yJx9uXb47cUEQ+NX39qiG6fy2ZQfrox4eDxkwar9u8U=;
 b=bzx3THyAZ3dXEgqdqHJsoP39vlDdgZcMbj/zuZE41c/Skjhz8uWWTeLjN1Al3x+bK/wmpKxZQsHQqQfP6Edg/DLt3Gz6PaW6MzKYe5VbzXMvHXAW3iil5TS14iSxZaUGP/Gd6j0+M8ugCioixdxZQu8Ovo4yO8PmP1/rcsMt096Fx36Ks+BCjPAbjM5bbM3jhoFDMt3I3bakthlbKIR3uu1+G0+CqYcuFA61hhLWjuWFoF8NFHsajVBZAuc0maptQCZVgI26h5RA+X/9J2gI36GPEOlUyxibOqs0sMFKsw+/uIgi6OJ6UeVbTSKMHiG0ApR4Hv/rA5LTMph/0B4gzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yJx9uXb47cUEQ+NX39qiG6fy2ZQfrox4eDxkwar9u8U=;
 b=WdgeeyQ6Zf1sIovQWymWJXmPsJ2NFxGh5QZt5MQvlvYESPpeRU4oKU3l/k2ZZ3a5XDEW1fQWDg3Lm33lylXJbNL/3MjxpOKI/9waK3GgKDZJikw/4hr1ePiWDGAdXQ9cN6QJA2/T8g/PeT0qxxzQYzYJ4FiRAaf5xR5B4Z1sfiY=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from CY4PR12MB1287.namprd12.prod.outlook.com (2603:10b6:903:40::8)
 by CY4PR12MB1909.namprd12.prod.outlook.com (2603:10b6:903:124::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.17; Wed, 22 Jul
 2020 03:14:48 +0000
Received: from CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::e0b1:48e7:bcbc:351c]) by CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::e0b1:48e7:bcbc:351c%11]) with mapi id 15.20.3195.025; Wed, 22 Jul
 2020 03:14:48 +0000
From: Guchun Chen <guchun.chen@amd.com>
To: amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com,
 Hawking.Zhang@amd.com, Dennis.Li@amd.com, Stanley.Yang@amd.com,
 Tao.Zhou1@amd.com, John.Clements@amd.com
Subject: [PATCH 2/5] drm/amdgpu: validate bad page threshold in ras
Date: Wed, 22 Jul 2020 11:14:12 +0800
Message-Id: <20200722031415.4792-3-guchun.chen@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200722031415.4792-1-guchun.chen@amd.com>
References: <20200722031415.4792-1-guchun.chen@amd.com>
X-ClientProxiedBy: HK0PR03CA0106.apcprd03.prod.outlook.com
 (2603:1096:203:b0::22) To CY4PR12MB1287.namprd12.prod.outlook.com
 (2603:10b6:903:40::8)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from guchchen-System-Product-Name.amd.com (58.247.170.242) by
 HK0PR03CA0106.apcprd03.prod.outlook.com (2603:1096:203:b0::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3216.20 via Frontend Transport; Wed, 22 Jul 2020 03:14:45 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 85b09e46-8055-49fc-c772-08d82ded63cc
X-MS-TrafficTypeDiagnostic: CY4PR12MB1909:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR12MB190999A4A282BA99B614B0A9F1790@CY4PR12MB1909.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: a+lH0vn8b+5CiRCqfWK33Z8jnT6/HBvOO0V9pxrHDgUJ3K847JE9rpE1i+168aJ8Ipnzy1c/Si+CGTP8jo7sutHfsHjXoaZG/YOQL6LTqDfZJLDgmckI5uk5WEa8B/AJhOwKcwuhvw/BSwc99fJYRZX5xCNn+oRa+fTfN71ayCKC/A+8lt94uGiPukS+nvdeUtgkUxU0z4xOnzo0t4wf5SFy6jUZlRxga5/Hrz4i8iLG+jDxGEtTzVnzSL9q/gD3K8dJhxPcmYaDK+QmtfU1/UqrRb2V4lDIemLZwRCyxMxJteSWV13k7wl4WDvmIksXHyEBlBrRDD1ENhrnIkMbzQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR12MB1287.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(36756003)(1076003)(52116002)(7696005)(2906002)(66946007)(8936002)(8676002)(6636002)(66556008)(66476007)(5660300002)(26005)(6666004)(6486002)(83380400001)(44832011)(2616005)(86362001)(956004)(186003)(498600001)(16526019)(4326008);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: b82T8f4ACupGt+cBj9JKzvoA3C+/QtaNYR/q8V4OKRNmm0fz1QdFAZUqJ9TeOzLlIZh0JLeIFwMWgM9rjVFaOD0jWzp/jgPZyiAeUjUYHmZeBGUHFJeCuqse8Owp7KOhdXsAz9TXopvNUhxx4wBZqFnwgbt+d4u3aa6UfWGOzzmFtuJed1l3Oq5J14i+uPRH6GuX45B1lcnakPdxTJiMDf26Yo/kMN/cJ/DSeW/hxlZF1LOG+ZlHSITgG8/BIF4rochVMvK2H64x3AgalGRYwo/t+88038jtKWkhBdhT4A6yw/0inn39MaXCQGAOOxMXuOpS46xGQA6YtepG//ADhlNHUs5fCN2yfUaryZ62xb4I0KuRq20UCiAC/syEtemCHSC+IkbtYSS+D/G/HP805DH0E5ctBLHJxqz+7wWm72LomAjydf32W6uosk598qMNvzdDDQN5DmGKBDmfRZJbjzze9saXBWCrwn05L/SGGsA=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85b09e46-8055-49fc-c772-08d82ded63cc
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1287.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2020 03:14:48.0267 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KdYx+KJWdFLaCMgwRIKlNcBUh0z2mxsb4Noc5ko1AdIQYCYPmZ2XC7SCvoJB53yHm7p7UZadgnqahOvtM7NiPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1909
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
the GPU should be retired.

Signed-off-by: Guchun Chen <guchun.chen@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c       | 43 +++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h       |  3 ++
 .../gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c    |  5 +++
 .../gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h    |  2 +
 4 files changed, 53 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 6f06e1214622..e3d67d85c55f 100644
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
@@ -1700,6 +1703,42 @@ static bool amdgpu_ras_check_bad_page(struct amdgpu_device *adev,
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
+	 * 1. -1 <= amdgpu_bad_page_threshold <= max record length in eeprom
+	 * 2. if amdgpu_bad_page_threshold = -1,
+	 *    bad_page_cnt_threshold = typical value by formula.
+	 * 3. if amdgpu_bad_page_threshold = 0,
+	 *    bad_page_cnt_threshold = 0xFFFFFFFF,
+	 *    and disable RMA feature accordingly.
+	 * 4. use the value specified from user when (amdgpu_bad_page_threshold
+	 *    > 0 && < max record length in eeprom).
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
+		con->bad_page_cnt_threshold = lower_32_bits(val);
+	} else if (tmp_threshold == 0) {
+		con->bad_page_cnt_threshold = 0xFFFFFFFF;
+	} else {
+		con->bad_page_cnt_threshold = tmp_threshold;
+	}
+}
+
 /* called in gpu recovery/init */
 int amdgpu_ras_reserve_bad_pages(struct amdgpu_device *adev)
 {
@@ -1777,6 +1816,7 @@ int amdgpu_ras_recovery_init(struct amdgpu_device *adev)
 {
 	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
 	struct ras_err_handler_data **data;
+	uint32_t max_eeprom_records_len = 0;
 	int ret;
 
 	if (con)
@@ -1795,6 +1835,9 @@ int amdgpu_ras_recovery_init(struct amdgpu_device *adev)
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
