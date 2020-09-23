Return-Path: <SRS0=BIvg=DA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A25AC4727F
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Sep 2020 18:35:51 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A8AA8206A1
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Sep 2020 18:35:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="FMZQ6cK5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8AA8206A1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 315486E9E9;
	Wed, 23 Sep 2020 18:35:50 +0000 (UTC)
Received: from NAM02-BL2-obe.outbound.protection.outlook.com
 (mail-eopbgr750052.outbound.protection.outlook.com [40.107.75.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7322E6E9E8
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Sep 2020 18:35:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LRjTmghbEWd7FNbFc0h73GnTQeK38GB2MK3hyvz2qLPRujs4Cuk3JCqTWphbHlNxdb/uEqXdIMmbeEejDvNNd3xMF3dSnzDokEmJMdJkJpKnG3J/qLSoOqpAGIy+E2Zx1GsK1ADZtW/J68A2Q4W/QVrV9EtceiKNA+VUYuIj3AoqvHknx52xzw5uGP7dklVsQRpT0GOfI9nC5cwkWyehyOtPxXPmSsjgvhAX9JX3D3EaPuBUwx3xz5kqKpzFXbV2kX5v/kIL49DqBPDuCskyCoEn44jvsnjYTCisbb8kBQxX0s8eV9Os8LKBESiIfrZ9tl8LcjgQ7VA5K18gccj0Rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f4CkNTQBIqHsR1Owb1ADRMPbx16G59NzDu9K4Tmpy7E=;
 b=V0NyVXCjqHGDkz2L/6myqf8dwRuT3FYdodiFdiU0y0XbQtllVBITHGLGiccZilm7UFTVQXrO5aa9gfhAX5cYh7jVsiWFF8cGa1LOO31eUj73MwdJA5cXWvEQLu8DpgtQSnAk1Ivb8soO8rqKCJioMzmrC6QJZyJuGk1qh5DzNiKqzVCnL8O6DKX+3UkqFSIpaHC6x0r2XJAkPelaRkVJBt4xd/kSROH9PgI10fVA2uuGEpUppn/3G/JRKil+YFEmAyhyQ8qpQkcYfW/LWieXtQYHu0IBAW4AkaDyhDGlMKlysvTrJlAFr+0BX1Tzgr+SCSzhvzxOKBrD9vFYx2oYKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f4CkNTQBIqHsR1Owb1ADRMPbx16G59NzDu9K4Tmpy7E=;
 b=FMZQ6cK590a91/3ZyIa2bg9N3HMN/TWYvJNNAOD0JfXz4awQl7rLgTFac3vWSzCVvUymh5gD/DQ+NSiN4wVSMePCC0XCIBwlA/i5RR0lZSQvgj6M4x33TBegSOlm5qsORbRdunkpZemXW7bOwgGnFgHHTDV9lEkC4C6+w5tYtkc=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BN6PR1201MB0146.namprd12.prod.outlook.com
 (2603:10b6:405:59::18) by BN6PR12MB1938.namprd12.prod.outlook.com
 (2603:10b6:404:fe::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.15; Wed, 23 Sep
 2020 18:35:46 +0000
Received: from BN6PR1201MB0146.namprd12.prod.outlook.com
 ([fe80::615d:bea9:8838:92be]) by BN6PR1201MB0146.namprd12.prod.outlook.com
 ([fe80::615d:bea9:8838:92be%4]) with mapi id 15.20.3391.027; Wed, 23 Sep 2020
 18:35:46 +0000
From: Jonathan Kim <jonathan.kim@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 3/3] drm/amdgpu: add xgmi perfmons for arcturus
Date: Wed, 23 Sep 2020 14:35:18 -0400
Message-Id: <20200923183518.65789-3-jonathan.kim@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200923183518.65789-1-jonathan.kim@amd.com>
References: <20200923183518.65789-1-jonathan.kim@amd.com>
X-ClientProxiedBy: YTOPR0101CA0007.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:15::20) To BN6PR1201MB0146.namprd12.prod.outlook.com
 (2603:10b6:405:59::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from jonathan-KFD.amd.com (165.204.55.251) by
 YTOPR0101CA0007.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:15::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.21 via Frontend
 Transport; Wed, 23 Sep 2020 18:35:45 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: d4bd1296-da10-45d7-cea5-08d85fef7c62
X-MS-TrafficTypeDiagnostic: BN6PR12MB1938:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN6PR12MB19383B2D838434DB10A9A5EF85380@BN6PR12MB1938.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:962;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vUewyYSlRxBXSPic2p3XkpkH1ZhkyCEEhNjqVcWWfIpk5R181WUyTTPVNGlsuEV0+DQJ9OPlIupm/jn1L36kq2zyKdKokFR3ByVou4k2qgoBeIx1odYxIJpOwwBkle6zh07jaMDiJ7/IaQf5fbjJmJOlPBXcw8vofNv01sRvGjIyc3v1YiE14jnzMACPI0gAsnvo4r2XACOWxxUAZWSIMbChuhXNcbj42bvzQcZM7oiOshuqfwGTIwgSI3lJEn5ncvuBP6Cos+JoFvbBWwZnQERCmJMa2lRQNYAaXkoccgNdvkjBYw+ffStHJwM6+NbM+l/Bl0TmHyCffpjeC2NNx5NW8W8ncawvSyd7DGQEuCd94dkiD8qwhm0T9+q0k66C
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN6PR1201MB0146.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(346002)(396003)(376002)(39860400002)(366004)(6916009)(66556008)(66476007)(86362001)(54906003)(2906002)(1076003)(5660300002)(66946007)(4326008)(186003)(7696005)(52116002)(16526019)(8676002)(26005)(6666004)(44832011)(36756003)(6486002)(316002)(956004)(2616005)(8936002)(478600001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: kNBhUMyNs0o89me7stnv41wOYU0Bm74Tvu72IXfMUQFleJQyfeF6/prh7ehtiaDKhiX2WtJkeGpbTsOzHsn99155LKzV4C81Eotu9SXE/BTD5L9GIBsIbRFUH0SKfpxPxAgG03kPd01Gq23tOak7RgFwqUReydn/xWQxtGK9P8qbPEq150CfV12LQSRP6kYp/uDJx3cck9tNtiYQm4FCuWfqkzvSiftRLDl0ltlf38lr7d1/zL7MWMW4ZdXoGfgn3Kcu+KQCZtLszhJVBQC0HwkwCmzR/fwMBiTjJ8SliR3SfPUOqrAcq2U7ikEkRld5Ywvk3Fenz4OYJ7kqUYLaskgV5Dkt98Nucp/4iGhSZVauwGMX0qgjKEqLI8JberztccqAhPxfzBu3imSHZw10ma007Kh3YvYwXlpUWwKgjXYyPqlz+ikfQ+7dwhr9gmnC6Ww7rn5nfQGa5bqtkk+dnm0jJRbBICL/E7gy7TVQTrcs2hccuuPCG1/1qPTFNmIr/log1gQTwDegcrxk2P3Ck7SOK60VMeYRUoW8Bfpx3yiyJyufUMv8Yf4md44FViFgFwuvK81CzebPD8nTgxW7r2MgMItDBv7GNY1yxRzW2ARwH4IpFQRnLuzgWl8oAs1AIRZMlcgtKgw6pFvzIbuzuA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4bd1296-da10-45d7-cea5-08d85fef7c62
X-MS-Exchange-CrossTenant-AuthSource: BN6PR1201MB0146.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2020 18:35:46.4596 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rVZL2xz8h5uCoVQOCKbMoUn4NJqeTfDrA3SK5XuaBi5BevGajzB16YWeWhNJLqFu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1938
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

v3: Align with patch 2 streamlining perf types versus event config types.
v2: Resend for re-review with alignment for v3 in patch 2.
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c | 43 +++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/df_v3_6.c    |  3 ++
 2 files changed, 46 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c
index 610f96bb0239..5f6de18cfee2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c
@@ -35,6 +35,9 @@
 #define NUM_EVENT_TYPES_VEGA20		1
 #define NUM_EVENTS_VEGA20_XGMI		2
 #define NUM_EVENTS_VEGA20_MAX		NUM_EVENTS_VEGA20_XGMI
+#define NUM_EVENT_TYPES_ARCTURUS	1
+#define NUM_EVENTS_ARCTURUS_XGMI	6
+#define NUM_EVENTS_ARCTURUS_MAX		NUM_EVENTS_ARCTURUS_XGMI
 
 struct amdgpu_pmu_event_attribute {
 	struct device_attribute attr;
@@ -122,6 +125,21 @@ static const char *df_vega20_events[NUM_EVENTS_DF_VEGA20][2] = {
 	{ "cake1_ftiinstat_rspalloc", "event=0xb,instance=0x47,umask=0x8" },
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
+static const int arcturus_event_config_types[NUM_EVENT_TYPES_ARCTURUS][2] = {
+	{ AMDGPU_PMU_EVENT_CONFIG_TYPE_XGMI, NUM_EVENTS_ARCTURUS_XGMI }
+};
+
+
 /* initialize perf counter */
 static int amdgpu_perf_event_init(struct perf_event *event)
 {
@@ -553,6 +571,31 @@ int amdgpu_pmu_init(struct amdgpu_device *adev)
 		}
 
 		break;
+	case CHIP_ARCTURUS:
+		pmu_entry = kzalloc(sizeof(struct amdgpu_pmu_entry),
+								GFP_KERNEL);
+
+		if (!pmu_entry)
+			return -ENOMEM;
+
+		pmu_entry->adev = adev;
+		pmu_entry->fmt_attr_group.name = "format";
+		pmu_entry->fmt_attr_group.attrs = NULL;
+		pmu_entry->evt_attr_group.name = "events";
+		pmu_entry->evt_attr_group.attrs = NULL;
+		ret = init_pmu_by_type(pmu_entry, "", "amdgpu",
+						AMDGPU_PMU_PERF_TYPE_ALL,
+						amdgpu_pmu_formats,
+						NUM_FORMATS_AMDGPU_PMU,
+						arcturus_events,
+						NUM_EVENTS_ARCTURUS_MAX,
+						arcturus_event_config_types,
+						NUM_EVENT_TYPES_ARCTURUS);
+
+		if (ret)
+			kfree(pmu_entry);
+		break;
+
 	default:
 		return 0;
 	};
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
