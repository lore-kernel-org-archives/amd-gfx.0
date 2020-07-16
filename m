Return-Path: <SRS0=xwQz=A3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E525FC433E2
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Jul 2020 05:12:55 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A6244207BB
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Jul 2020 05:12:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="jJpuKPip"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6244207BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1BC176E11A;
	Thu, 16 Jul 2020 05:12:55 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2069.outbound.protection.outlook.com [40.107.243.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6D3B56E11A
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Jul 2020 05:12:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jiTlKM5G2vlA4SYwAqJZyexbXNeSzM7TL68m/LPeb7XlY1T4rBR421gI8QQ/4t6hiiUPmc6UZYjiX2Cwmxpwb0gpX6OTH6uwKx/Lf8M9g+3N4jT9OtI96gCMlNxpmxPLq5ue5EdXk7fB27zcDDTjhXWE+DJKTJMVZIu89y7bjHGuItXGHFln8221Ch7wQu6+pWXhcl44N3pMiW9lYXXDdShM+Kyr4W6nc9oni1jDzsArlCzPMCbr+F+bPgR/pByjPQOctRlBodg/v7/2SXhO1aPFw7tGBr31yINkc0XQXU9sHdgLzdNXpvuZ4ujo0BpbenBntjVFsFXLjCn7TLKrmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jMbxwtDPnI0Upy8rZHTSWVQvX7BFwSpZ3VjFjixBlY4=;
 b=LBP99jcJhSZI6JPuDOHrytWN3DdYkzE8U5mqUoOq8ufQz0OLTAlUzdD6hl6gzivP7Lal4BbJ4TvlDbcQxGEfjJmMW8oP9ofzobpcnZ/njwDYhSj6uOQdUtgzVwE5fc7pVMJRLDWT0F6zbNMtl4fJy9auZ4PmZ1CSpGdcMbU7LcNxhE32OORhGKpd+smz8JHStFdq2CyJ7P9kXUO8ERkTZkvntB7rQ28x1iku3vnH4lTfwr7n8P6ArYuK8ZBV6fBigbmVjqAGDkF2oeGXJ94G0IGwRTM+dKMZuaDRCK7ozJoUdCGnWnhJ/XcTfS2Q53cDnuZVLACsH6FiXmEisspevw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jMbxwtDPnI0Upy8rZHTSWVQvX7BFwSpZ3VjFjixBlY4=;
 b=jJpuKPipsqbEg27e/E9C55/5tgFnXVtGWGrCHolioFp4MoeGsrHr3hk227RNUbJ7lRiEn02KPvULU6o4HZyPmOf8HHd2CYkQMFJp0lFIWSg32nZXI1/jM9YcBLo+Ng/SDrDFscZAwFQb3VfGPy7VKKanOP+VmR5ySBE43PV6B1o=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB2891.namprd12.prod.outlook.com (2603:10b6:5:188::13) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3195.17; Thu, 16 Jul 2020 05:12:50 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c157:8999:dcc3:536f]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c157:8999:dcc3:536f%3]) with mapi id 15.20.3174.025; Thu, 16 Jul 2020
 05:12:50 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amd/powerplay: widely share the API for data table
 retrieving
Date: Thu, 16 Jul 2020 13:12:26 +0800
Message-Id: <20200716051226.23316-1-evan.quan@amd.com>
X-Mailer: git-send-email 2.27.0
X-ClientProxiedBy: HK2PR02CA0145.apcprd02.prod.outlook.com
 (2603:1096:202:16::29) To DM6PR12MB2619.namprd12.prod.outlook.com
 (2603:10b6:5:45::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from equan-buildpc.amd.com (58.247.170.242) by
 HK2PR02CA0145.apcprd02.prod.outlook.com (2603:1096:202:16::29) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3195.17 via Frontend Transport; Thu, 16 Jul 2020 05:12:49 +0000
X-Mailer: git-send-email 2.27.0
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 994d601d-0cea-4b46-8437-08d82946e2f8
X-MS-TrafficTypeDiagnostic: DM6PR12MB2891:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB28919C71ED15A9B0A3989333E47F0@DM6PR12MB2891.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1169;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6X02T6yIMP17fEEkv7S/kLFVEr6L4x32bGwTNm473IbHKXiwYJDqOc/Na8EqkTbXarvDyO4wCXcYEK7UWP8kLgBDmwJA1WPFgaKcTTxUO5cGOgP9yBKJZXUeAKe+TnQz/9eCmsdpCfo1Hg/8Kaj60TkXHpT2cesb8YF+44f9i066JEwgMe2SD9DOzrK0+Y+y3eop42RMMZMCtm4a8p5qekAWEYk0udirD7TMZjrqzA4fws2JjgFKs2kD5nBO4HbS1/l0f3daR/l7ldTE3ZkANU9o4Iwkm0qEWQXA4I/ijZtW75H62W+afrOCzL5PPKnS
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(346002)(396003)(376002)(136003)(39860400002)(316002)(83380400001)(6666004)(6916009)(66476007)(26005)(5660300002)(66946007)(66556008)(86362001)(44832011)(52116002)(4326008)(36756003)(6486002)(478600001)(7696005)(1076003)(956004)(8936002)(16526019)(2616005)(186003)(2906002)(8676002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: MAKEWrvH6vMRpVsbXqcFx/5vNKAUNiVw3U6DqHVnsDhHX5uT9hHrzMnIAoMmmZjv9QctOoHjxgjhdP8ZrD5Yu78Yvofq9RFieTNy7mWTlpzQR4VXAPSRZalyBsiSbBIjzyvgh+xzLALL/FwlAoGCC04v6egoSHoKKNOCCXTNUIqF0NSGhj6vBzc8b5dqYHgg4/PEZXQic+muJyh4of9wtir0Gz6hiwc6af+NYd/6DxFUfMzDytr3IpM8FVn2Vo5zSJ2Wc3tXJQmI7H2CKvonVlNVyO+2aRaSh7ZK3B/F/TxXM19yJ51m26KC+S1Yp10Ka5zTTIOVVpkaZMb+f9CbGpzLmxTHDq+D7AmXxqCHjICniwmb4U3m+Ro8zcsif4t+ZCopEWjb9ATjrHldc9zP1OXyHTQ1OZ5iaEK5hpdaltB6XBxigL/gKx/0BX5IQICx1qX/huJEGqWbDDXylHGgFrBbX+y9a2whrDZjILyQDz1KSvcZRWMFyTYSUtOmgSWR
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 994d601d-0cea-4b46-8437-08d82946e2f8
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2020 05:12:50.7840 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UMHfA4ax1qZ4IyrPghu9kwORdzjGvDOvz6QXYsR3FhdA0QRam5yMVNdWVvfDKtnU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2891
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

Considering the data table retrieving can be more widely shared,
amdgpu_atombios.c is the right place.

Change-Id: Id89476c14709b5676bbf043371a27f27b94a58ed
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c    | 17 +++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.h    |  7 +++++++
 drivers/gpu/drm/amd/powerplay/amdgpu_smu.c      | 16 ----------------
 drivers/gpu/drm/amd/powerplay/arcturus_ppt.c    |  3 ++-
 drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h  |  4 ----
 drivers/gpu/drm/amd/powerplay/navi10_ppt.c      |  5 +++--
 .../gpu/drm/amd/powerplay/sienna_cichlid_ppt.c  |  3 ++-
 drivers/gpu/drm/amd/powerplay/smu_v11_0.c       |  5 +++--
 8 files changed, 34 insertions(+), 26 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c
index c687432da426..29f767e026e4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c
@@ -2036,3 +2036,20 @@ int amdgpu_atombios_init(struct amdgpu_device *adev)
 	return 0;
 }
 
+int amdgpu_atombios_get_data_table(struct amdgpu_device *adev,
+				   uint32_t table,
+				   uint16_t *size,
+				   uint8_t *frev,
+				   uint8_t *crev,
+				   uint8_t **addr)
+{
+	uint16_t data_start;
+
+	if (!amdgpu_atom_parse_data_header(adev->mode_info.atom_context, table,
+					   size, frev, crev, &data_start))
+		return -EINVAL;
+
+	*addr = (uint8_t *)adev->mode_info.atom_context->bios + data_start;
+
+	return 0;
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.h
index fd8f18074f7a..1321ec09c734 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.h
@@ -216,6 +216,13 @@ int amdgpu_atombios_get_svi2_info(struct amdgpu_device *adev,
 			      u8 voltage_type,
 			      u8 *svd_gpio_id, u8 *svc_gpio_id);
 
+int amdgpu_atombios_get_data_table(struct amdgpu_device *adev,
+				   uint32_t table,
+				   uint16_t *size,
+				   uint8_t *frev,
+				   uint8_t *crev,
+				   uint8_t **addr);
+
 void amdgpu_atombios_fini(struct amdgpu_device *adev);
 int amdgpu_atombios_init(struct amdgpu_device *adev);
 
diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
index 03125c8a2145..01d669a36e1f 100644
--- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
@@ -676,22 +676,6 @@ static int smu_late_init(void *handle)
 	return 0;
 }
 
-int smu_get_atom_data_table(struct smu_context *smu, uint32_t table,
-			    uint16_t *size, uint8_t *frev, uint8_t *crev,
-			    uint8_t **addr)
-{
-	struct amdgpu_device *adev = smu->adev;
-	uint16_t data_start;
-
-	if (!amdgpu_atom_parse_data_header(adev->mode_info.atom_context, table,
-					   size, frev, crev, &data_start))
-		return -EINVAL;
-
-	*addr = (uint8_t *)adev->mode_info.atom_context->bios + data_start;
-
-	return 0;
-}
-
 static int smu_init_fb_allocations(struct smu_context *smu)
 {
 	struct amdgpu_device *adev = smu->adev;
diff --git a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
index 56dc20a617fd..578c50e294c7 100644
--- a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
@@ -27,6 +27,7 @@
 #include "smu_internal.h"
 #include "atomfirmware.h"
 #include "amdgpu_atomfirmware.h"
+#include "amdgpu_atombios.h"
 #include "smu_v11_0.h"
 #include "smu11_driver_if_arcturus.h"
 #include "soc15_common.h"
@@ -488,7 +489,7 @@ static int arcturus_append_powerplay_table(struct smu_context *smu)
 	index = get_index_into_master_table(atom_master_list_of_data_tables_v2_1,
 					   smc_dpm_info);
 
-	ret = smu_get_atom_data_table(smu, index, NULL, NULL, NULL,
+	ret = amdgpu_atombios_get_data_table(smu->adev, index, NULL, NULL, NULL,
 				      (uint8_t **)&smc_dpm_table);
 	if (ret)
 		return ret;
diff --git a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
index 70181ba7ee0c..ba9beffb887d 100644
--- a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
@@ -678,10 +678,6 @@ bool smu_mode1_reset_is_support(struct smu_context *smu);
 int smu_mode1_reset(struct smu_context *smu);
 int smu_mode2_reset(struct smu_context *smu);
 
-extern int smu_get_atom_data_table(struct smu_context *smu, uint32_t table,
-				   uint16_t *size, uint8_t *frev, uint8_t *crev,
-				   uint8_t **addr);
-
 extern const struct amd_ip_funcs smu_ip_funcs;
 
 extern const struct amdgpu_ip_block_version smu_v11_0_ip_block;
diff --git a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
index ead135f39c7e..0c21e5de8997 100644
--- a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
@@ -28,6 +28,7 @@
 #include "smu_internal.h"
 #include "atomfirmware.h"
 #include "amdgpu_atomfirmware.h"
+#include "amdgpu_atombios.h"
 #include "soc15_common.h"
 #include "smu_v11_0.h"
 #include "smu11_driver_if_navi10.h"
@@ -467,7 +468,7 @@ static int navi10_append_powerplay_table(struct smu_context *smu)
 	index = get_index_into_master_table(atom_master_list_of_data_tables_v2_1,
 					   smc_dpm_info);
 
-	ret = smu_get_atom_data_table(smu, index, NULL, NULL, NULL,
+	ret = amdgpu_atombios_get_data_table(adev, index, NULL, NULL, NULL,
 				      (uint8_t **)&smc_dpm_table);
 	if (ret)
 		return ret;
@@ -487,7 +488,7 @@ static int navi10_append_powerplay_table(struct smu_context *smu)
 			sizeof(*smc_dpm_table) - sizeof(smc_dpm_table->table_header));
 		break;
 	case 7: /* nv12 */
-		ret = smu_get_atom_data_table(smu, index, NULL, NULL, NULL,
+		ret = amdgpu_atombios_get_data_table(adev, index, NULL, NULL, NULL,
 					      (uint8_t **)&smc_dpm_table_v4_7);
 		if (ret)
 			return ret;
diff --git a/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
index 5faef41b63a3..389d8350534a 100644
--- a/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
@@ -28,6 +28,7 @@
 #include "smu_internal.h"
 #include "atomfirmware.h"
 #include "amdgpu_atomfirmware.h"
+#include "amdgpu_atombios.h"
 #include "smu_v11_0.h"
 #include "smu11_driver_if_sienna_cichlid.h"
 #include "soc15_common.h"
@@ -399,7 +400,7 @@ static int sienna_cichlid_append_powerplay_table(struct smu_context *smu)
 	index = get_index_into_master_table(atom_master_list_of_data_tables_v2_1,
 					    smc_dpm_info);
 
-	ret = smu_get_atom_data_table(smu, index, NULL, NULL, NULL,
+	ret = amdgpu_atombios_get_data_table(smu->adev, index, NULL, NULL, NULL,
 				      (uint8_t **)&smc_dpm_table);
 	if (ret)
 		return ret;
diff --git a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
index 829c15984847..06a2ea12cba0 100644
--- a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
@@ -32,6 +32,7 @@
 #include "smu_internal.h"
 #include "atomfirmware.h"
 #include "amdgpu_atomfirmware.h"
+#include "amdgpu_atombios.h"
 #include "smu_v11_0.h"
 #include "soc15_common.h"
 #include "atom.h"
@@ -416,7 +417,7 @@ int smu_v11_0_setup_pptable(struct smu_context *smu)
 		index = get_index_into_master_table(atom_master_list_of_data_tables_v2_1,
 						    powerplayinfo);
 
-		ret = smu_get_atom_data_table(smu, index, &atom_table_size, &frev, &crev,
+		ret = amdgpu_atombios_get_data_table(adev, index, &atom_table_size, &frev, &crev,
 					      (uint8_t **)&table);
 		if (ret)
 			return ret;
@@ -631,7 +632,7 @@ int smu_v11_0_get_vbios_bootup_values(struct smu_context *smu)
 	index = get_index_into_master_table(atom_master_list_of_data_tables_v2_1,
 					    firmwareinfo);
 
-	ret = smu_get_atom_data_table(smu, index, &size, &frev, &crev,
+	ret = amdgpu_atombios_get_data_table(smu->adev, index, &size, &frev, &crev,
 				      (uint8_t **)&header);
 	if (ret)
 		return ret;
-- 
2.27.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
