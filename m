Return-Path: <SRS0=V/Q8=BI=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E45D4C433E0
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Jul 2020 02:57:09 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B856C20663
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Jul 2020 02:57:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Wgy3kDIv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B856C20663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7DDFF6E437;
	Wed, 29 Jul 2020 02:57:09 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2078.outbound.protection.outlook.com [40.107.237.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D80746E437
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Jul 2020 02:57:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mooqu5+FQAzeN/7BbQXMc3SVZ3NkwakRvY97izYGylwfYAOK77/Oq7FUYsU8a+UMYO+VbI0XuRxdnGrxo0LITE1/lVthkfwLHB5VkzCtN3xUBmU4qW8of39D8hj67XiN1sS7rZ6VpvlUYICG+ZWdihkQOekHvCGUvFeLxRc1kqLoLtZJpDQhaTGuqHYbqR8CYaBIcJGMS7PYL2Rp2h8VzlzhJw6oUwkIoy3LFz3MLR5hFQzAlKln09a8g8TXLsjFFOQhBHPGImupCowKSC4a+EIjGs86q975HTBB3/XQ1TnWS1lzXJhWpMkL53ph7l+0xmrLaAtOOReWF8+3mg1k6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KcMtiSccenHXO8SKYZmjV7Sq8+7opwNR8GquwdxJD5A=;
 b=CHLF5tqpFINyp1VGcFZ9VypieoK47hcbEU3bocSRgwhGdgP5UQBfckmJPODm166SV6xslIcQSOD2zEzy8BE8w6yWBN1Yd7aOTlkeV9jyG7utqP3SJeTIQhiV8P7c+rLzpcrVDuDfvsB3jUCT0AIJsjU9pTLvVKVTKM1GKiCVtS3c88P/jsDo0Jgv4WlJwpUFQJf9XyhMYWr025AVrqOe+pQL/NwiZhzgVnLYfv3jplEvzeqv4tFjMLo9fj27h4bSNKWQTIlDSLvm4chzJ/viHP8EbYVk8cFpoJ7MKM1OmqECutCu3IlIkCbYWOkd+DMnixTMYq3t2onbycBCRT5WXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KcMtiSccenHXO8SKYZmjV7Sq8+7opwNR8GquwdxJD5A=;
 b=Wgy3kDIvcHPRa6IZUiKYR4BUkrH+AWz6JFEDznr9NWAosNqgdn5nLxwtr9hM9n9HkvYR+gtYMq/JNvs+aZ+oTmjm9uwAqHh09dy9W1QZRPhOkFF9X8hiUk3WudDdNrGZIXKfbqkf8f4T4J6ZtLhpQ4hUlA5sZ/mLZZrddkRGvXA=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from CY4PR12MB1287.namprd12.prod.outlook.com (2603:10b6:903:40::8)
 by CY4PR12MB1285.namprd12.prod.outlook.com (2603:10b6:903:3e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.26; Wed, 29 Jul
 2020 02:57:05 +0000
Received: from CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::e0b1:48e7:bcbc:351c]) by CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::e0b1:48e7:bcbc:351c%11]) with mapi id 15.20.3216.033; Wed, 29 Jul
 2020 02:57:05 +0000
From: Guchun Chen <guchun.chen@amd.com>
To: amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com,
 Hawking.Zhang@amd.com, Dennis.Li@amd.com, andrey.grodzovsky@amd.com,
 Tao.Zhou1@amd.com, John.Clements@amd.com, lijo.lazar@amd.com,
 christian.koenig@amd.com
Subject: [PATCH 04/12] drm/amdgpu: break driver init process when it's bad GPU
Date: Wed, 29 Jul 2020 10:56:21 +0800
Message-Id: <20200729025629.19355-5-guchun.chen@amd.com>
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
 Transport; Wed, 29 Jul 2020 02:57:02 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: aceeaa57-f53a-4878-c1da-08d8336b1351
X-MS-TrafficTypeDiagnostic: CY4PR12MB1285:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR12MB1285928E66818A85083E8659F1700@CY4PR12MB1285.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +3oaoCy7qA0W3vcdRPk9GG2TKqujY7RKgY2YP8r80XiLBG2ruJCI1kq3nk1dcWepKZjEer91NPId0dNYy1s7Woqy1XDEAby1lu7WksT7Ymn870x/bNxp7N+UbWZ5e5FGyMVHKCEoPVuJnQz2EAvL3OPJJ/PuiIphPx4UVMWVLhv1K8G102GJnZCG+IEbqvOjp3HtKFXvkMnG5Se0HURGf8HCN2tRXwTK97Tt67MrIukPsmfsyDjo1XwLo//X+YkPmvHjNrYJJnyhXTSq/g2OyZIhLTYkDmVlJepJhZJ/PJQvUuKqxwyE7GYYiH6Flp4CufHm4Ep9SIpv+rdgT8sX4w==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR12MB1287.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(39860400002)(376002)(346002)(136003)(396003)(26005)(2906002)(66946007)(6636002)(52116002)(66556008)(8676002)(86362001)(66476007)(186003)(7696005)(16526019)(6666004)(44832011)(36756003)(5660300002)(4326008)(1076003)(316002)(8936002)(956004)(83380400001)(6486002)(478600001)(2616005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: fASIBJPIf9SilImk2Okw9JvxvIwy5ySzlnHK6o0XvuTNIUIcxekv1a8LTfBugQXZGtPjtFoeMMcVBIaK6KiIgY0flq/1+fR2si2gSi6thcHcea576vDx/CZ/ahmE0fjNP1boB5GWT5ROVnoGTDjon8w6K1pMjVaDnA4aM1zyTTFsvEomx+vGWUXJFzPw1/JjfvPKJ4GrPL3hWxjv0ZvhxgpF6Klh7RgAUqjaTTrbbYAQluQ2fo+/LiU52GcL7/ewBRZ3Q4zbE7jLMQiJfEteWC1GqeH866opkzIbslxXbdZPK+PS8Hy4HnyB7HxzdgxhwmFuXbqLQXemQgEYDviyoxTnv+rjkbbWeQLh2ztm/vecx9xumYNYdLInIukkqCjEY9gLfdwUt/aY3pdsjwDtxLpYOLpTV5/4l5dr5VSCA7m/HTaWY2Ifgtd+GC7uCIY7zCn6WivmipJjaPAKYddxhvERBNFQ4Y6cMXMiHZVZFTXGt+zyyfnUhIml7HLcYDGR
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aceeaa57-f53a-4878-c1da-08d8336b1351
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1287.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2020 02:57:05.3806 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wVE7uPCHlRvcBDYTWUqUcYhiyAlv9Q7w1qOGCrV6lJSKHHrWcxYz1puGoGwpxlWXfGxmpgLO9cQV/Thk1YYngg==
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

When retrieving bad gpu tag from eeprom, GPU init should
fail as the GPU needs to be retired for further check.

v2: Fix spelling typo, correct the condition to detect
    bad gpu tag and refine error message.

v3: Refine function argument name.

v4: Fix missing check of returning value of i2c
    initialization error case.

Signed-off-by: Guchun Chen <guchun.chen@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c     | 12 +++++++++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c        | 18 ++++++++++++++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c | 10 +++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h |  3 ++-
 4 files changed, 36 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 2662cd7c8685..30af0dfee1a1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2059,13 +2059,19 @@ static int amdgpu_device_ip_init(struct amdgpu_device *adev)
 	 * it should be called after amdgpu_device_ip_hw_init_phase2  since
 	 * for some ASICs the RAS EEPROM code relies on SMU fully functioning
 	 * for I2C communication which only true at this point.
-	 * recovery_init may fail, but it can free all resources allocated by
-	 * itself and its failure should not stop amdgpu init process.
+	 *
+	 * amdgpu_ras_recovery_init may fail, but the upper only cares the
+	 * failure from bad gpu situation and stop amdgpu init process
+	 * accordingly. For other failed cases, it will still release all
+	 * the resource and print error message, rather than returning one
+	 * negative value to upper level.
 	 *
 	 * Note: theoretically, this should be called before all vram allocations
 	 * to protect retired page from abusing
 	 */
-	amdgpu_ras_recovery_init(adev);
+	r = amdgpu_ras_recovery_init(adev);
+	if (r)
+		goto init_failed;
 
 	if (adev->gmc.xgmi.num_physical_nodes > 1)
 		amdgpu_xgmi_add_device(adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 3c4c142e9d8a..67d9d65b069e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -1822,6 +1822,7 @@ int amdgpu_ras_recovery_init(struct amdgpu_device *adev)
 	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
 	struct ras_err_handler_data **data;
 	uint32_t max_eeprom_records_len = 0;
+	bool exc_err_limit = false;
 	int ret;
 
 	if (con)
@@ -1843,8 +1844,12 @@ int amdgpu_ras_recovery_init(struct amdgpu_device *adev)
 	max_eeprom_records_len = amdgpu_ras_eeprom_get_record_max_length();
 	amdgpu_ras_validate_threshold(adev, max_eeprom_records_len);
 
-	ret = amdgpu_ras_eeprom_init(&con->eeprom_control);
-	if (ret)
+	ret = amdgpu_ras_eeprom_init(&con->eeprom_control, &exc_err_limit);
+	/*
+	 * This calling fails when exc_err_limit is true or
+	 * ret != 0.
+	 */
+	if (exc_err_limit || ret)
 		goto free;
 
 	if (con->eeprom_control.num_recs) {
@@ -1868,6 +1873,15 @@ int amdgpu_ras_recovery_init(struct amdgpu_device *adev)
 out:
 	dev_warn(adev->dev, "Failed to initialize ras recovery!\n");
 
+	/*
+	 * Except error threshold exceeding case, other failure cases in this
+	 * function would not fail amdgpu driver init.
+	 */
+	if (!exc_err_limit)
+		ret = 0;
+	else
+		ret = -EINVAL;
+
 	return ret;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
index 35c0c849d49b..67995b66d7d4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
@@ -241,7 +241,8 @@ int amdgpu_ras_eeprom_reset_table(struct amdgpu_ras_eeprom_control *control)
 
 }
 
-int amdgpu_ras_eeprom_init(struct amdgpu_ras_eeprom_control *control)
+int amdgpu_ras_eeprom_init(struct amdgpu_ras_eeprom_control *control,
+			bool *exceed_err_limit)
 {
 	int ret = 0;
 	struct amdgpu_device *adev = to_amdgpu_device(control);
@@ -254,6 +255,8 @@ int amdgpu_ras_eeprom_init(struct amdgpu_ras_eeprom_control *control)
 			.buf	= buff,
 	};
 
+	*exceed_err_limit = false;
+
 	/* Verify i2c adapter is initialized */
 	if (!adev->pm.smu_i2c.algo)
 		return -ENOENT;
@@ -282,6 +285,11 @@ int amdgpu_ras_eeprom_init(struct amdgpu_ras_eeprom_control *control)
 		DRM_DEBUG_DRIVER("Found existing EEPROM table with %d records",
 				 control->num_recs);
 
+	} else if ((hdr->header == EEPROM_TABLE_HDR_BAD) &&
+			(amdgpu_bad_page_threshold != 0)) {
+		*exceed_err_limit = true;
+		DRM_ERROR("Exceeding the bad_page_threshold parameter, "
+				"disabling the GPU.\n");
 	} else {
 		DRM_INFO("Creating new EEPROM table");
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h
index b272840cb069..f245b96d9599 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h
@@ -77,7 +77,8 @@ struct eeprom_table_record {
 	unsigned char mcumc_id;
 }__attribute__((__packed__));
 
-int amdgpu_ras_eeprom_init(struct amdgpu_ras_eeprom_control *control);
+int amdgpu_ras_eeprom_init(struct amdgpu_ras_eeprom_control *control,
+			bool *exceed_err_limit);
 int amdgpu_ras_eeprom_reset_table(struct amdgpu_ras_eeprom_control *control);
 
 int amdgpu_ras_eeprom_process_recods(struct amdgpu_ras_eeprom_control *control,
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
