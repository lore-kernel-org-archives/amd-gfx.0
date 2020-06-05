Return-Path: <SRS0=/kPV=7S=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 539E5C433E1
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Jun 2020 11:02:45 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 26C5C207D5
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Jun 2020 11:02:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="KaYk89Oq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26C5C207D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B6A4B6E8CA;
	Fri,  5 Jun 2020 11:02:42 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2074.outbound.protection.outlook.com [40.107.236.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 600206E8BE
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Jun 2020 11:02:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a7cBLB2Go8oo2bytao2R6iGWxuUcjSgR7ebUoDQvMHpMAETRLdePIuTPN62IirK88KPoyjiKZ99prDIkIbfZ5i8Ab1bhq6RiYqNkUXuiMWqfNuSSJo51uoRTzBUgfh28HvOKTm33rPpGEuORn0Ig9rOEWbZLOB0PKi2JWf17IvSl2QhshiEpaFwxv/5t3cCafYx0HCGzDIJVOyptJ1m0IcbKk9raEUSPWMYnprGuU7bA4oAd500mdX5grBjb5+5p9k1xu3lF4TMKcuTESf+UXuauuz9X8oq/BkpSBmqCo9PBnqKuhmySsEA1s6IrMPAv7/4KpCYkUUra4jMjCJULtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SJWpFTl1/MdmtFUce+7spPTgbOpUNgDKEMui68DaMtk=;
 b=LIT8j+rndbcEKYyZ8k8eUF7Fr3yLupjpJX4qNEnUwO+6qHDgXSg6D8Pndy2SZ4qxPrW0mJa5khCF9WEH10lbPil+LxJuVg9+WdB0rjBVTw+7gmwb5pwz5Tzm/anNaHT4easxybxm5maOLPb843yUhZem/A+xFvOVC3TavxDITSpIkp5LU6yeGF9f6ugi6Got+W89nalm9vwHK1F/mdg93b5RW+TZm4JnFEy0XZ72eFLx46IVR7vqkRsScc3D6hhoGbtv8FqsimLeEJokk3mXqi2tCxYjumDTen7lPjkMSLlPNj3uqz6GbuXHVxpC0JsveyGeUsZS1fP1nKAxUWGkYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SJWpFTl1/MdmtFUce+7spPTgbOpUNgDKEMui68DaMtk=;
 b=KaYk89OqJgy2xpqbm8wI/D26PFXrhJJFcOiau4xKevNmjQO/PomqAuAK/8KJ9jllRG70/7VPMpZerWb8hH7Am2VhpANO8Tp6YqPVCCyhTFcGSfbhvWTZ22F7/KNeS66h18jyKeFuzu4ZZ9l1DomtDQrxLZGPqcjUnTBgfZinujo=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB2615.namprd12.prod.outlook.com (2603:10b6:a03:61::29)
 by BYASPR01MB2.namprd12.prod.outlook.com (2603:10b6:a02:ce::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.18; Fri, 5 Jun
 2020 11:02:40 +0000
Received: from BYAPR12MB2615.namprd12.prod.outlook.com
 ([fe80::4c16:1697:3e6d:9157]) by BYAPR12MB2615.namprd12.prod.outlook.com
 ([fe80::4c16:1697:3e6d:9157%7]) with mapi id 15.20.3066.019; Fri, 5 Jun 2020
 11:02:40 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/3] drm/amd/powerplay: forbid to use pr_err/warn/info/debug
Date: Fri,  5 Jun 2020 19:01:59 +0800
Message-Id: <20200605110200.27206-2-evan.quan@amd.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200605110200.27206-1-evan.quan@amd.com>
References: <20200605110200.27206-1-evan.quan@amd.com>
X-ClientProxiedBy: HK2PR03CA0050.apcprd03.prod.outlook.com
 (2603:1096:202:17::20) To BYAPR12MB2615.namprd12.prod.outlook.com
 (2603:10b6:a03:61::29)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from equan-buildpc.amd.com (58.247.170.242) by
 HK2PR03CA0050.apcprd03.prod.outlook.com (2603:1096:202:17::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3088.7 via Frontend Transport; Fri, 5 Jun 2020 11:02:39 +0000
X-Mailer: git-send-email 2.27.0
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: e91b1f24-cc28-41d3-c2ec-08d8093ff6d7
X-MS-TrafficTypeDiagnostic: BYASPR01MB2:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYASPR01MB21AB37960767E437B3C73E4860@BYASPR01MB2.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-Forefront-PRVS: 0425A67DEF
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: B3grr0r+bLu79An9l8DVXoZoc2mXhni3KVXQetSRFS4uFN8jIced5AH8H0DdjbZrzozZXcH6eX+a+kY6aSncc+keDULKzs6wIhJhbcu6hsxOi0YWxcY4gi1Hk9FB2A4I5T9SytSCdxyfkDHnwE4sqnVOZsh4AudQDLZN1boeeARzteEO52TAlBv92mitaiG1JLrzomYSjBU7bypKmR9eJ3oEi5h3hLdWq8NP8MEKFYxJrOPEFlKnHMYibEGyqvfafIDj5fw4UazZ5n0p3nU4+M+xZMfPIyysyhgcctFpEm5ikkoJAR3FcViq4ufHdPwu5U+dRMFtPCpBwJxii1vANw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB2615.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(136003)(346002)(376002)(366004)(39860400002)(4326008)(8676002)(83380400001)(2616005)(1076003)(956004)(8936002)(6486002)(186003)(6666004)(6916009)(2906002)(16526019)(478600001)(66556008)(66946007)(26005)(36756003)(66476007)(5660300002)(52116002)(86362001)(316002)(7696005)(44832011);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: r6PWeGVeoBqSiexWWnkqiXWmbBRtNbcLIgFK92racKk+enBhwyj6Yd3baYPJRMPbquW+R/fUOb7EO95OY9xpEPcYe7Zy+akMt0z34T7hOEL2Ov0HF0KFHBzGYslsJOCBdKTmGLTNETv+a88hC5eGEC+i8HxnPT14l8gmGbKMX1SrVdMOXkU+z2cH+mN81VhE/f1pWi0neXUCvZU0xuQfXP3yiY/igTWwhLcFKTy+KSfRjvCuk58e+WFzMJgSDZ168JrIuFTCuSaB8Og7ub6WSn3bPKZGbt0Gm0p5c+GS+z1l+bOnTvEgwZZV7ARdcXwwMq5emN2l1FQBenz0aST8fz5g4qRbFt1NhX5caCgDY9uFVfZO1t+9Aqe/NeIaALOO3EB9KhAmiFYNQ3cVWvpc12ZrSacu4OwVHBdJM0TsApjTcz+fh4UuHIlEgO52WSt14LP4qwX/KuChPJh9hSH2yi20UsNNzJzQKXaEMLEaj4sPSoiB1zHU1z2qufdlXLFn
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e91b1f24-cc28-41d3-c2ec-08d8093ff6d7
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2020 11:02:40.4031 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gEW8Zwn/5LQJTZ70HfFcnEG1sGLk6hkdS7YFzKbCzR/1rsELq2UB5Vcu0LkjpWK2
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

Use dev_err/warn/info/dbg instead. They are more MGPU friendly.

Change-Id: I07ad32c11dcf86cb1e3d1da1afa449f1f7dbd645
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/powerplay/amdgpu_smu.c         | 10 ++++++++++
 drivers/gpu/drm/amd/powerplay/arcturus_ppt.c       | 10 ++++++++++
 drivers/gpu/drm/amd/powerplay/navi10_ppt.c         | 10 ++++++++++
 drivers/gpu/drm/amd/powerplay/renoir_ppt.c         |  9 +++++++++
 drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c | 10 ++++++++++
 drivers/gpu/drm/amd/powerplay/smu_v11_0.c          | 10 ++++++++++
 drivers/gpu/drm/amd/powerplay/smu_v12_0.c          | 10 ++++++++++
 7 files changed, 69 insertions(+)

diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
index 30302ac37046..0c5e062a21a7 100644
--- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
@@ -34,6 +34,16 @@
 #include "sienna_cichlid_ppt.h"
 #include "renoir_ppt.h"
 
+/*
+ * DO NOT use these for err/warn/info/debug messages.
+ * Use dev_err, dev_warn, dev_info and dev_dbg instead.
+ * They are more MGPU friendly.
+ */
+#undef pr_err
+#undef pr_warn
+#undef pr_info
+#undef pr_debug
+
 #undef __SMU_DUMMY_MAP
 #define __SMU_DUMMY_MAP(type)	#type
 static const char* __smu_message_names[] = {
diff --git a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
index c6c20699884f..b47b5f257671 100644
--- a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
@@ -42,6 +42,16 @@
 #include <linux/pci.h>
 #include "amdgpu_ras.h"
 
+/*
+ * DO NOT use these for err/warn/info/debug messages.
+ * Use dev_err, dev_warn, dev_info and dev_dbg instead.
+ * They are more MGPU friendly.
+ */
+#undef pr_err
+#undef pr_warn
+#undef pr_info
+#undef pr_debug
+
 #define to_amdgpu_device(x) (container_of(x, struct amdgpu_device, pm.smu_i2c))
 
 #define CTF_OFFSET_EDGE			5
diff --git a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
index ce91743c7d1c..70d93a0fd3d0 100644
--- a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
@@ -40,6 +40,16 @@
 
 #include "asic_reg/mp/mp_11_0_sh_mask.h"
 
+/*
+ * DO NOT use these for err/warn/info/debug messages.
+ * Use dev_err, dev_warn, dev_info and dev_dbg instead.
+ * They are more MGPU friendly.
+ */
+#undef pr_err
+#undef pr_warn
+#undef pr_info
+#undef pr_debug
+
 #define FEATURE_MASK(feature) (1ULL << feature)
 #define SMC_DPM_FEATURE ( \
 	FEATURE_MASK(FEATURE_DPM_PREFETCHER_BIT) | \
diff --git a/drivers/gpu/drm/amd/powerplay/renoir_ppt.c b/drivers/gpu/drm/amd/powerplay/renoir_ppt.c
index 7cc3f0cd6aa7..7a4e1bd9bafd 100644
--- a/drivers/gpu/drm/amd/powerplay/renoir_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/renoir_ppt.c
@@ -29,6 +29,15 @@
 #include "smu_v12_0.h"
 #include "renoir_ppt.h"
 
+/*
+ * DO NOT use these for err/warn/info/debug messages.
+ * Use dev_err, dev_warn, dev_info and dev_dbg instead.
+ * They are more MGPU friendly.
+ */
+#undef pr_err
+#undef pr_warn
+#undef pr_info
+#undef pr_debug
 
 #define CLK_MAP(clk, index) \
 	[SMU_##clk] = {1, (index)}
diff --git a/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
index 8ba40926b641..4be244787fad 100644
--- a/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
@@ -40,6 +40,16 @@
 
 #include "asic_reg/mp/mp_11_0_sh_mask.h"
 
+/*
+ * DO NOT use these for err/warn/info/debug messages.
+ * Use dev_err, dev_warn, dev_info and dev_dbg instead.
+ * They are more MGPU friendly.
+ */
+#undef pr_err
+#undef pr_warn
+#undef pr_info
+#undef pr_debug
+
 #define FEATURE_MASK(feature) (1ULL << feature)
 #define SMC_DPM_FEATURE ( \
 	FEATURE_MASK(FEATURE_DPM_PREFETCHER_BIT) | \
diff --git a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
index c3f860168f04..98082c1569b7 100644
--- a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
@@ -46,6 +46,16 @@
 #include "asic_reg/smuio/smuio_11_0_0_offset.h"
 #include "asic_reg/smuio/smuio_11_0_0_sh_mask.h"
 
+/*
+ * DO NOT use these for err/warn/info/debug messages.
+ * Use dev_err, dev_warn, dev_info and dev_dbg instead.
+ * They are more MGPU friendly.
+ */
+#undef pr_err
+#undef pr_warn
+#undef pr_info
+#undef pr_debug
+
 MODULE_FIRMWARE("amdgpu/arcturus_smc.bin");
 MODULE_FIRMWARE("amdgpu/navi10_smc.bin");
 MODULE_FIRMWARE("amdgpu/navi14_smc.bin");
diff --git a/drivers/gpu/drm/amd/powerplay/smu_v12_0.c b/drivers/gpu/drm/amd/powerplay/smu_v12_0.c
index 29bc6c07e536..f10113fc4571 100644
--- a/drivers/gpu/drm/amd/powerplay/smu_v12_0.c
+++ b/drivers/gpu/drm/amd/powerplay/smu_v12_0.c
@@ -35,6 +35,16 @@
 #include "asic_reg/smuio/smuio_12_0_0_offset.h"
 #include "asic_reg/smuio/smuio_12_0_0_sh_mask.h"
 
+/*
+ * DO NOT use these for err/warn/info/debug messages.
+ * Use dev_err, dev_warn, dev_info and dev_dbg instead.
+ * They are more MGPU friendly.
+ */
+#undef pr_err
+#undef pr_warn
+#undef pr_info
+#undef pr_debug
+
 // because some SMU12 based ASICs use older ip offset tables
 // we should undefine this register from the smuio12 header
 // to prevent confusion down the road
-- 
2.27.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
