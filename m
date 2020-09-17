Return-Path: <SRS0=QzDn=C2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28951C433E2
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Sep 2020 18:15:38 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A3D4B206A4
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Sep 2020 18:15:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="1G1ZWhHe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3D4B206A4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 572F86EC6E;
	Thu, 17 Sep 2020 18:15:37 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2086.outbound.protection.outlook.com [40.107.92.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5364B6E2D5
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Sep 2020 18:15:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CnItng0uBRgJzAHEMT5X6hlG91aV9a7OhGqMA95oANSZbdQ+kyPHcu/J4y/V0ttfaPYDW21c4IBSNbI0hOHo1IAOrZiWv5HTsb0eiy2sy/0YueinjPhInsV1y8HEyzGXyYo0x2XUo1+muploKbAr/HRQ+OzmSgLOEK4RYDSLbyPqcsjVtHdFn8bNd25fc0A0a3U6j/HZqD1Jl8T3TjfDnYIZ6FgYzIACWK2o6rIeASwFMiT0mtiob3Ry5hzXZ/lTp5AuLfpuLq+rNDXZft6kpYEaGZuO2OgQZZ8yibubYPZHjY9tl6zytT6DtNPzzt5r9QSgz6A0g5wHTjlG8p8K9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pW7p59FmLU4BS8QDuRZWGLySOHFoV/1D1ce2it6nhr4=;
 b=BWe/HI1QrROa3bWKfBClj3sjSlUmnYNVOCXad6GHP7RvMsdgx2axNgrudIDh6daWTV7swr1lTLPQ/BwOeyArZ/V+mxXyIM6D3MtCsF2Jg/IwDgoUv2fHlf5AOCFPi3AL7V9uhWuE5W60s5UJOjU73uRCAjgA0dzWTb3xEPaBLfvqIhJxfPthNEIMSPqOpVhhX98MWn4WiALacLSGLiIMICKEhhoEqJ6exYD0Ye53JdOeZB7020bZQH5FeVIM8nUPIhled9ZQwirv60tOVNgh+MM77GHLbGF8prYvW1xEC9osXomutAzIuz92BRD4ndrGGodOB4Ncn94M/XI1Z1c0UQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pW7p59FmLU4BS8QDuRZWGLySOHFoV/1D1ce2it6nhr4=;
 b=1G1ZWhHe+MHYLgEn3Fy5e7n2hLSPNb+Egexc1eYjKIaZmOCkrDjo5wASvH/Q7X2XmYwlehiVKUDl+q5KFWQlqIELNdUAPM85I1oS4KZlKP3YPlAL8L8rIMiNelQT94t2y8qFG+aUIIqvdGDpCDbF+EVJsSOoS51XBiWg9grZ/kA=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BN6PR1201MB0146.namprd12.prod.outlook.com
 (2603:10b6:405:59::18) by BN7PR12MB2833.namprd12.prod.outlook.com
 (2603:10b6:408:27::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16; Thu, 17 Sep
 2020 18:15:32 +0000
Received: from BN6PR1201MB0146.namprd12.prod.outlook.com
 ([fe80::615d:bea9:8838:92be]) by BN6PR1201MB0146.namprd12.prod.outlook.com
 ([fe80::615d:bea9:8838:92be%4]) with mapi id 15.20.3391.014; Thu, 17 Sep 2020
 18:15:32 +0000
From: Jonathan Kim <jonathan.kim@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 3/3] drm/amdgpu: add xgmi perfmons for arcturus
Date: Thu, 17 Sep 2020 14:15:14 -0400
Message-Id: <20200917181514.38292-3-jonathan.kim@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200917181514.38292-1-jonathan.kim@amd.com>
References: <20200917181514.38292-1-jonathan.kim@amd.com>
X-ClientProxiedBy: YTBPR01CA0010.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::23) To BN6PR1201MB0146.namprd12.prod.outlook.com
 (2603:10b6:405:59::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from jonathan-KFD.amd.com (165.204.55.251) by
 YTBPR01CA0010.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:14::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3391.11 via Frontend Transport; Thu, 17 Sep 2020 18:15:32 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 7ba62da8-2ddd-42e4-14b3-08d85b35aa72
X-MS-TrafficTypeDiagnostic: BN7PR12MB2833:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN7PR12MB28339A0CFC100021F92FB4FE853E0@BN7PR12MB2833.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:800;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bHuzfXEiXEJ5SmvzR2MaBOOpqJf3zRFc+4qUX6SyMdOr/pMLHuEqxgXt+ps5ea5LdzKbPVugXr7NTj0Yv0YdvgRKpe1h2Gvc5qRjIgL2EFUHLDybeOqXw8EII4DBXTtkNTFDFD0CTqtLc7WCBA8Pdme4nhPFzH4OIrUzjEjv8TgAwr69LyZoSZA/75NXcS0CWAE8Mc+ELREJ85zp0QRrAlawgjRIiU35C3e2GPI1mRA46RSKy3u8UccW0DKLD9fYeeAYNbHCb0W4XjYXQ7JfXopC2wwwI2sATwZQy8PHNEzE4t86YoMOZDjRCAkLGehS9aNTILb/R2C95swRl/cJbw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN6PR1201MB0146.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(366004)(39860400002)(376002)(396003)(346002)(8676002)(54906003)(26005)(316002)(6666004)(1076003)(2616005)(4326008)(956004)(52116002)(66946007)(66556008)(7696005)(83380400001)(6486002)(2906002)(86362001)(6916009)(66476007)(44832011)(16526019)(186003)(36756003)(8936002)(478600001)(5660300002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: Ji/JMDx6uvD6hbjD1m6S9MAiLeS9CB6EOw04hb3JVl4cqTsuaQLXeYnLL+PbS3vj2wtHPZBQrB6PYmvgDRVS5hkqgioolIW26yDj6cjazniD94+kq5UtHQI6jN2nXtnfTmG9gbtdkjhhVcUzLL1zx0MiWYX0N7kiODeb2HzuaVJHLyk+sA3JywF3/yyBE2/OlWJLGA6IdAWL015wdb9bgWR2pUo4EYHceAI2c0bmZqijHov9SSLXc3ArrCVDcC/sUeBZ36mpbXV7OKWLewK1Xurs45hy5o4hmfYOzpFVdlnCSv0iXLP/PVOwfTUJEX4+X8eARNWnsGYclPtpBO6NJIxULu4YYRRmG6Z0pZ/RY0SkV2ovC41Vc6AD6jbX3O0i14CxVMvqlDdjm9apqKjLkgBYiZVMbIfg8HToe1FPEgJ2gdQ3TwsVDCyOywXwtfWzMMW0GP9eFZwydiNseAL5XTbw8t3P/KyO13JDfy/LplNVWluM77IT2sv/IxeHcnaMmQPJvhVyqJiqkoNWZlav8I2mxDMGIShng0Vbl80OCc9kSFHqT7XMdCmJH7k1bHWwf0/wqHDf/HuZnf3Y5ElJv2od7iPSs5qx2b546GeCBIYfvq/6CBPOO57LUiRmwxn9fB7VY0IrwSXwnm1NwDFHWQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ba62da8-2ddd-42e4-14b3-08d85b35aa72
X-MS-Exchange-CrossTenant-AuthSource: BN6PR1201MB0146.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2020 18:15:32.6131 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hY6x6WMwsKmzU/aggS7NWjW2r0ASfVEbi85gsWMr2jC47wCShlvystB9FWqHkp0g
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR12MB2833
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
Cc: Jonathan Kim <Jonathan.Kim@amd.com>, Harish.Kasiviswanathan@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add xgmi perfmons for Arcturus.

Signed-off-by: Jonathan Kim <Jonathan.Kim@amd.com>

v2: Resend for re-review with alignment for v3 in patch 2.
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c | 41 ++++++++++++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/df_v3_6.c    |  3 ++
 2 files changed, 43 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c
index 74fe8fbdc0d1..c58af4495c5a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c
@@ -34,6 +34,8 @@
 #define NUM_EVENTS_DF_LEGACY		8
 #define NUM_EVENTS_VEGA20_XGMI		2
 #define NUM_EVENTS_VEGA20_MAX		NUM_EVENTS_VEGA20_XGMI
+#define NUM_EVENTS_ARCTURUS_XGMI	6
+#define NUM_EVENTS_ARCTURUS_MAX		NUM_EVENTS_ARCTURUS_XGMI
 
 struct amdgpu_pmu_event_attribute {
 	struct device_attribute attr;
@@ -98,6 +100,16 @@ static const char *vega20_events[NUM_EVENTS_VEGA20_MAX][2] = {
 	{ "xgmi_link1_data_outbound", "event=0x7,instance=0x47,umask=0x2" }
 };
 
+/* Arcturus events */
+static const char *arcturus_events[NUM_EVENTS_ARCTURUS_MAX][2] = {
+	{ "xgmi_link0_data_outbound", "event=0x7,instance=0x4b,umask=0x2" },
+	{ "xgmi_link1_data_outbound", "event=0x7,instance=0x4c,umask=0x2" },
+	{ "xgmi_link2_data_outbound", "event=0x7,instance=0x4d,umask=0x2" },
+	{ "xgmi_link3_data_outbound", "event=0x7,instance=0x4e,umask=0x2" },
+	{ "xgmi_link4_data_outbound", "event=0x7,instance=0x4f,umask=0x2" },
+	{ "xgmi_link5_data_outbound", "event=0x7,instance=0x50,umask=0x2" }
+};
+
 /* All df_vega20_* items are DEPRECATED. Use vega20_ items above instead. */
 static const char *df_vega20_formats[NUM_FORMATS_DF_LEGACY][2] = {
 	{ "event", "config:0-7" },
@@ -413,6 +425,32 @@ static int init_pmu_by_type(struct amdgpu_pmu_entry *pmu_entry,
 
 		/* other events can be added here */
 
+		break;
+	case CHIP_ARCTURUS:
+		ret = amdgpu_pmu_alloc_pmu_attrs(&pmu_entry->fmt_attr_group,
+						&pmu_entry->fmt_attr,
+						NUM_FORMATS_AMDGPU_PMU,
+						&pmu_entry->evt_attr_group,
+						&pmu_entry->evt_attr,
+						NUM_EVENTS_ARCTURUS_MAX);
+
+		if (ret)
+			goto err_out;
+
+		amdgpu_pmu_create_attributes(&pmu_entry->fmt_attr_group,
+						pmu_entry->fmt_attr,
+						amdgpu_pmu_formats,
+						0, NUM_FORMATS_AMDGPU_PMU, 0);
+
+		amdgpu_pmu_create_attributes(&pmu_entry->evt_attr_group,
+						pmu_entry->evt_attr,
+						arcturus_events,
+						0, NUM_EVENTS_ARCTURUS_XGMI,
+						PERF_TYPE_AMDGPU_XGMI);
+		num_events += NUM_EVENTS_ARCTURUS_XGMI;
+
+		/* other events can be added here */
+
 		break;
 	default:
 		ret = -ENODEV;
@@ -473,7 +511,8 @@ void amdgpu_pmu_fini(struct amdgpu_device *adev)
 
 static bool amdgpu_pmu_is_supported(struct amdgpu_device *adev)
 {
-	return adev->asic_type == CHIP_VEGA20;
+	return adev->asic_type == CHIP_VEGA20 ||
+		adev->asic_type == CHIP_ARCTURUS;
 }
 
 /* init amdgpu_pmu */
diff --git a/drivers/gpu/drm/amd/amdgpu/df_v3_6.c b/drivers/gpu/drm/amd/amdgpu/df_v3_6.c
index 6e57ae95f997..6b4b30a8dce5 100644
--- a/drivers/gpu/drm/amd/amdgpu/df_v3_6.c
+++ b/drivers/gpu/drm/amd/amdgpu/df_v3_6.c
@@ -513,6 +513,7 @@ static int df_v3_6_pmc_start(struct amdgpu_device *adev, uint64_t config,
 
 	switch (adev->asic_type) {
 	case CHIP_VEGA20:
+	case CHIP_ARCTURUS:
 		if (is_add)
 			return df_v3_6_pmc_add_cntr(adev, config);
 
@@ -554,6 +555,7 @@ static int df_v3_6_pmc_stop(struct amdgpu_device *adev, uint64_t config,
 
 	switch (adev->asic_type) {
 	case CHIP_VEGA20:
+	case CHIP_ARCTURUS:
 		ret = df_v3_6_pmc_get_ctrl_settings(adev,
 			config,
 			counter_idx,
@@ -590,6 +592,7 @@ static void df_v3_6_pmc_get_count(struct amdgpu_device *adev,
 
 	switch (adev->asic_type) {
 	case CHIP_VEGA20:
+	case CHIP_ARCTURUS:
 		df_v3_6_pmc_get_read_settings(adev, config, counter_idx,
 						&lo_base_addr, &hi_base_addr);
 
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
