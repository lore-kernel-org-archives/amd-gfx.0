Return-Path: <SRS0=yWhT=GL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE2C8C4332B
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Jan 2021 08:55:59 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5EA6D236FB
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Jan 2021 08:55:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EA6D236FB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E4A586E81C;
	Fri,  8 Jan 2021 08:55:45 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2066.outbound.protection.outlook.com [40.107.220.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A009A6E7FA
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Jan 2021 08:55:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LVtidQiQtnZDXkNPtPjAU3zth0u3fm2COzgk7K0K5YKQlKOc0ILOmiR6c8dgfhNPEUzr7s9KjZVzYDP69qfBxOdt/Ytgl0YtM+wiTPVtUbvtbpFjBawxnBJZ9kc5/gGnh/CIquZp9XLAxsf4mkfhwCZOwbLumOYHDKPW7yqnRlM1S3IrwQdyD4fpZaNQ31S15zhbRdfiRb8LoTlr+ILoPmLANn0WXSxefV6pYfF4lAjnRPGh+lFV7WvW0rDf1ESq17G1VtdFEN81pXQy8K9Dgu3gUz3/kUBZJhDOjy9H6Q31YCLIl2gYEDAMEfYrzANn+biazOAFcmFDP17FZOCxXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vrmNA2MtkHSVqmm1TXl4tJfBMAjpfJ9hH4lC/FppTYs=;
 b=mo9R+4y2niNXcY93SwJGWGkEpD4oDMyAb+T33gyMKoh+sVIZ78mUtmCE4s6qlJl9r9gbA4BiZYvJLZm1FyfzbOaXbq2ayzOFNAzU7sPNas3jDG3rzpe3xi3ST0TJxQ+dVI4mbuQSNzBf9NoC8gqdT6ltlnUMQkNLUlPMisx2E7+pMCiFEPtRlKfKx9OKet+rcKKyXVdVYUjBTBrOMfoAvh8WanBY9lj7qJOJGMyjB86rqZKPXiNuS0gTX07D/GeILyR0VGjer0LezwT8wesnQym/oQwA4RXalf/nSdWPDspFhX7GlbqurE8wypb/OI1GOY2oxQz7S9Vx6IvpCbLcrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vrmNA2MtkHSVqmm1TXl4tJfBMAjpfJ9hH4lC/FppTYs=;
 b=GnwI2KIFIWH0zmmo4PCwkLPaspPxTNhINu3irjsckZnvCuk9AsHEQpyDlRqaQuWItWoWVZ7X3pcdSSVWl5JkDdsVeSo7x6qONVa7quu8Y3JkyorWBcc3QDcTtr9ZDrykyZtgRA/54+lYA3XBJA/Hqd2NVl2yj1WTH7+ORShJxvw=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MWHPR12MB1248.namprd12.prod.outlook.com (2603:10b6:300:12::21)
 by MW2PR12MB2458.namprd12.prod.outlook.com (2603:10b6:907:8::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3721.20; Fri, 8 Jan
 2021 08:55:42 +0000
Received: from MWHPR12MB1248.namprd12.prod.outlook.com
 ([fe80::8c0d:7831:bfa8:d98]) by MWHPR12MB1248.namprd12.prod.outlook.com
 ([fe80::8c0d:7831:bfa8:d98%6]) with mapi id 15.20.3742.009; Fri, 8 Jan 2021
 08:55:42 +0000
From: Huang Rui <ray.huang@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 6/7] drm/amd/pm: implement the processor clocks which read by
 metric
Date: Fri,  8 Jan 2021 16:55:06 +0800
Message-Id: <20210108085507.1164588-7-ray.huang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210108085507.1164588-1-ray.huang@amd.com>
References: <20210108085507.1164588-1-ray.huang@amd.com>
X-Originating-IP: [180.167.199.189]
X-ClientProxiedBy: HK2PR02CA0162.apcprd02.prod.outlook.com
 (2603:1096:201:1f::22) To MWHPR12MB1248.namprd12.prod.outlook.com
 (2603:10b6:300:12::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from hr-amd.amd.com (180.167.199.189) by
 HK2PR02CA0162.apcprd02.prod.outlook.com (2603:1096:201:1f::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3742.6 via Frontend Transport; Fri, 8 Jan 2021 08:55:40 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 71e524f1-1700-42b1-4c70-08d8b3b32e12
X-MS-TrafficTypeDiagnostic: MW2PR12MB2458:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW2PR12MB2458104B4541A83BE6D5D4AFECAE0@MW2PR12MB2458.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:279;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PEvioCldhsztDYiFuW/A38+xlkEZtpSipV92RCbisoH/AYguNU0C4rg0Sx/0kZuDtT2+fJK6rPiwjbusJpuqGr15Ew2L9GcRtxg9vE3M8VkBMUbdeV/OR7Ax9dhSWs+TReqrvQVGVMnbY83GeLbYvwuxc3CquN0BmJ3GfU7DgWrLrYzkA0ehXUjOOWK2DOUuvKQ3J4B+cQmSsZxa6HTmnO4Ar5X5GjVV9kpqEcNYBaKK6QUMvjort/HuAoos302C1at7yFNsTmhKUq6gim/E7ERzpdPMfPleB37tQc3lK8wjWO3XVatTgd7W2rjN1YY8PIiUR0VWXxB4FLLzyyiy4zafVpI4KCnth3iPUHtRjznE/ap5+anwUraa90iMjfwhMNMzBGhfyWd/GVD2wbul9Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR12MB1248.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(396003)(366004)(39860400002)(346002)(376002)(2616005)(956004)(83380400001)(36756003)(26005)(1076003)(7696005)(86362001)(4326008)(66946007)(6916009)(186003)(2906002)(8676002)(8936002)(52116002)(6666004)(6486002)(478600001)(316002)(66476007)(54906003)(66556008)(5660300002)(16526019);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?4cDmA0+LKKiMBufJJQwcfOGhCpbCPz/T4GfUzezsw0/Qs4h7h/XWk52rgRbt?=
 =?us-ascii?Q?7nkkeUZZUklcyztiOEZAzmsr/Ji00hEcNM5Utgjl5NTV4easrbqcu6viBUzw?=
 =?us-ascii?Q?maBkAA23taCJW6izqrL3mzdaApIcoKbBA1yzzmq9XPUAnsNblcahYs6Jehhv?=
 =?us-ascii?Q?SrBm0gK2RRyxKjK1rs9FTxR0urvtgyc1tOwDB5rxQipjzxsMxQ9Wq1Ad2xwT?=
 =?us-ascii?Q?qKgl6v0qOXI+0SIh8HjrY6G6g9cxHOYJAQbrmQ1zCBg7+IhQpphtlORmg+ch?=
 =?us-ascii?Q?5elZwk25zzVJF5aB8H1xUxm/z5TouUXxPk9vqrMYmurDMLClA6x0u8y9mONu?=
 =?us-ascii?Q?o56VKVE3PWiutU2ClaaHgiUonMB8yS+Y0GmBYcIR+SvJC27CKXk3twlIerWJ?=
 =?us-ascii?Q?UdcDUWACPGfTX8Da1BrID2N2MPVey99kK6f7kmZAK+fuqw8N4pmoCBqGy1ny?=
 =?us-ascii?Q?aEXcmSijumVRinu68wKxg5eISNnhWGVbd/tscNn6ra6lYIwgnEGUL3PJN/yz?=
 =?us-ascii?Q?W6jKVXlVgZrZ/TsnHqkQbS5R4UYGdn1fo4pGCYksp7vbBNrzxNklPz2yF6lp?=
 =?us-ascii?Q?y07YJYoeBTUPLQBIaKOYf2h5eYaRC9+Ah71SMN/Czze0kJMkjL1cwvnSWhDi?=
 =?us-ascii?Q?ooQFXasS8kiKwreUtDFB3KM7oyz74Wto3kd73SCzyHfESVDPJSVoTI8x8fvk?=
 =?us-ascii?Q?BsICfXlMdKHkVKN5SzQQMIVNpy2FnM8STPZbRYDhLilhb1ooKPRa1D7okECv?=
 =?us-ascii?Q?KpDKFUR8UvDPdyIFhKQAq/Xk5YpcUQu13qDP6YMuH4YrhaY+cpzy+W2suhfn?=
 =?us-ascii?Q?fAM96CwOsJGsLRtEsFPBlHv+++SO0KBe4i6E/RCyI4D86EqE/lr46lLt6ct0?=
 =?us-ascii?Q?QPo/zImJA0HxXI9P+XNIfNG58hrn2NeYU3I6RgYBf1NRwJCg/xEBzWlHFhFP?=
 =?us-ascii?Q?Neu87unjKun/6WT6ZtntuJrp3xrZWs/OmxCSq4kNaBjxyRnov9ktKezSF3oH?=
 =?us-ascii?Q?STiw?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthSource: MWHPR12MB1248.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2021 08:55:42.4295 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-Network-Message-Id: 71e524f1-1700-42b1-4c70-08d8b3b32e12
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T2d8WCtytoNBlfwe5j3kvGtXji6/GqFIQGluuEmZaAzVPJARgutdoWvvmvBVIDsxytEYlQq21ikuKEdr4hjrRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2458
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Xiaomeng Hou <Xiaomeng.Hou@amd.com>, Huang Rui <ray.huang@amd.com>,
 Aaron Liu <aaron.liu@amd.com>, Xiaojian Du <xiaojian.du@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The core processor clocks will be stored in smu metric table, then we
add this runtime information into amdgpu_pm_info interface.

Signed-off-by: Huang Rui <ray.huang@amd.com>
---
 .../gpu/drm/amd/include/kgd_pp_interface.h    |  1 +
 drivers/gpu/drm/amd/pm/amdgpu_pm.c            | 25 +++++++++++++++++++
 drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h       |  2 ++
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 14 +++++++++++
 .../gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c  | 11 ++++++++
 5 files changed, 53 insertions(+)

diff --git a/drivers/gpu/drm/amd/include/kgd_pp_interface.h b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
index 270f8db5115a..57b24c4c205b 100644
--- a/drivers/gpu/drm/amd/include/kgd_pp_interface.h
+++ b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
@@ -103,6 +103,7 @@ enum pp_clock_type {
 
 enum amd_pp_sensors {
 	AMDGPU_PP_SENSOR_GFX_SCLK = 0,
+	AMDGPU_PP_SENSOR_CPU_CLK,
 	AMDGPU_PP_SENSOR_VDDNB,
 	AMDGPU_PP_SENSOR_VDDGFX,
 	AMDGPU_PP_SENSOR_UVD_VCLK,
diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index 97c669dd4cac..a5be03aa384b 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -36,6 +36,7 @@
 #include <linux/hwmon-sysfs.h>
 #include <linux/nospec.h>
 #include <linux/pm_runtime.h>
+#include <asm/processor.h>
 #include "hwmgr.h"
 
 static const struct cg_flag_name clocks[] = {
@@ -3621,6 +3622,27 @@ void amdgpu_pm_sysfs_fini(struct amdgpu_device *adev)
  */
 #if defined(CONFIG_DEBUG_FS)
 
+static void amdgpu_debugfs_prints_cpu_info(struct seq_file *m,
+					   struct amdgpu_device *adev) {
+	uint16_t *p_val;
+	uint32_t size;
+	int i;
+
+	if (is_support_cclk_dpm(adev)) {
+		p_val = kcalloc(boot_cpu_data.x86_max_cores, sizeof(uint16_t),
+				GFP_KERNEL);
+
+		if (!amdgpu_dpm_read_sensor(adev, AMDGPU_PP_SENSOR_CPU_CLK,
+					    (void *)p_val, &size)) {
+			for (i = 0; i < boot_cpu_data.x86_max_cores; i++)
+				seq_printf(m, "\t%u MHz (CPU%d)\n",
+					   *(p_val + i), i);
+		}
+
+		kfree(p_val);
+	}
+}
+
 static int amdgpu_debugfs_pm_info_pp(struct seq_file *m, struct amdgpu_device *adev)
 {
 	uint32_t value;
@@ -3631,6 +3653,9 @@ static int amdgpu_debugfs_pm_info_pp(struct seq_file *m, struct amdgpu_device *a
 	/* GPU Clocks */
 	size = sizeof(value);
 	seq_printf(m, "GFX Clocks and Power:\n");
+
+	amdgpu_debugfs_prints_cpu_info(m, adev);
+
 	if (!amdgpu_dpm_read_sensor(adev, AMDGPU_PP_SENSOR_GFX_MCLK, (void *)&value, &size))
 		seq_printf(m, "\t%u MHz (MCLK)\n", value/100);
 	if (!amdgpu_dpm_read_sensor(adev, AMDGPU_PP_SENSOR_GFX_SCLK, (void *)&value, &size))
diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
index a9622b5e9c7b..97d788451624 100644
--- a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
@@ -1122,6 +1122,7 @@ typedef enum {
 	METRICS_CURR_DCLK1,
 	METRICS_CURR_FCLK,
 	METRICS_CURR_DCEFCLK,
+	METRICS_AVERAGE_CPUCLK,
 	METRICS_AVERAGE_GFXCLK,
 	METRICS_AVERAGE_SOCCLK,
 	METRICS_AVERAGE_FCLK,
@@ -1250,6 +1251,7 @@ extern const struct amdgpu_ip_block_version smu_v11_0_ip_block;
 extern const struct amdgpu_ip_block_version smu_v12_0_ip_block;
 
 bool is_support_sw_smu(struct amdgpu_device *adev);
+bool is_support_cclk_dpm(struct amdgpu_device *adev);
 int smu_reset(struct smu_context *smu);
 int smu_sys_get_pp_table(struct smu_context *smu, void **table);
 int smu_sys_set_pp_table(struct smu_context *smu,  void *buf, size_t size);
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index d80f7f8efdcd..22868ad87628 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -288,6 +288,20 @@ bool is_support_sw_smu(struct amdgpu_device *adev)
 	return false;
 }
 
+bool is_support_cclk_dpm(struct amdgpu_device *adev)
+{
+	struct smu_context *smu = &adev->smu;
+
+	if (!is_support_sw_smu(adev))
+		return false;
+
+	if (!smu_feature_is_enabled(smu, SMU_FEATURE_CCLK_DPM_BIT))
+		return false;
+
+	return true;
+}
+
+
 int smu_sys_get_pp_table(struct smu_context *smu, void **table)
 {
 	struct smu_table_context *smu_table = &smu->smu_table;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
index 233c6e4ddd01..63be82386964 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
@@ -34,6 +34,7 @@
 #include "soc15_common.h"
 #include "asic_reg/gc/gc_10_3_0_offset.h"
 #include "asic_reg/gc/gc_10_3_0_sh_mask.h"
+#include <asm/processor.h>
 
 /*
  * DO NOT use these for err/warn/info/debug messages.
@@ -285,6 +286,10 @@ static int vangogh_get_smu_metrics_data(struct smu_context *smu,
 	case METRICS_VOLTAGE_VDDSOC:
 		*value = metrics->Voltage[1];
 		break;
+	case METRICS_AVERAGE_CPUCLK:
+		memcpy(value, &metrics->CoreFrequency[0],
+		       boot_cpu_data.x86_max_cores * sizeof(uint16_t));
+		break;
 	default:
 		*value = UINT_MAX;
 		break;
@@ -1113,6 +1118,12 @@ static int vangogh_read_sensor(struct smu_context *smu,
 						   (uint32_t *)data);
 		*size = 4;
 		break;
+	case AMDGPU_PP_SENSOR_CPU_CLK:
+		ret = vangogh_get_smu_metrics_data(smu,
+						   METRICS_AVERAGE_CPUCLK,
+						   (uint32_t *)data);
+		*size = boot_cpu_data.x86_max_cores * sizeof(uint16_t);
+		break;
 	default:
 		ret = -EOPNOTSUPP;
 		break;
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
