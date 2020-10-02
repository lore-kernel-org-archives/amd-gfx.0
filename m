Return-Path: <SRS0=93xL=DJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2D8CC46466
	for <amd-gfx@archiver.kernel.org>; Fri,  2 Oct 2020 20:19:37 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 96E0B206FA
	for <amd-gfx@archiver.kernel.org>; Fri,  2 Oct 2020 20:19:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="vSjIIF41"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96E0B206FA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 553276E9CB;
	Fri,  2 Oct 2020 20:19:37 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2048.outbound.protection.outlook.com [40.107.236.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D549D6E9CB
 for <amd-gfx@lists.freedesktop.org>; Fri,  2 Oct 2020 20:19:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nZ5VvAWF1CRPwAidKNOK06g7lVttSwl3XVSGyqHnVyzHqIcww+D6NO2SLGbcojCGObGPKxh0gG5/dfBRJ/maNKI56o/SfcW1ELMd63xLQ6ckB2umN47493YI81QZDZm4EXgQ0k0+YbtgayMeHqViN7Ia8MWRl/q2MknpV21meBwcd1GmjRMuPSTtN2DkrHI4jus3HgDTzIRLCvA8HdSa1k6r088kNJsxbyqYUN7VaozINs5YBu3Zr1+k17YOEyDeTuaXG6rY1MXJwfAIg6WOof/CpIEZ6x0WmB7V57kxJ5TxnWKVQLuPYArEn8VDOT32Sg0uxKXt8aDeTej1aX//JA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b+F1eIdJadm4l+M/FBe6EoRODtscuxRTx7rsc/JqQCM=;
 b=Zx2btJVpxomj6nzEOYOQXU8oHhJSrHhQKmS4tPridizCtaheRBbSwN7QOJvQD4K9BMHjOmvg6Au5/lbUBwTkF2JUXErE9UD/CKJJOA5EH3pL+1gEb6qUPmTTbU3QFKDoit0wMZYbm0CPgVb2yLGjumPTCmc/1NoIBaxlvG3C6OSsFGVJ7ijwna68wbLhHilPhX7rfOYqErfi5NrwoTcReYMmv4OmxEjIfn4uZEv4uVnfQhILMfLU1y3/PAOEt0tWm1MUSGjGTNgOiGzoNdo1JDRi7CAcADuwOou0kYmjSXZpv1nIg6+HY5AO9zzeZxMyxYXjN3vGpPQNg1Y+PAssUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b+F1eIdJadm4l+M/FBe6EoRODtscuxRTx7rsc/JqQCM=;
 b=vSjIIF41y9RrZOZjn/igxLanLEghDU3tq0rO7HBa+Q3qbr/LUK13NeOpSPDn73g+k6j8x4OoE3Q/4OZjuu8et24WKtSHbEsTnxs4/C3yhngxAp5e8+2j3ZjGbfYxrNiVzAp6u7E8Q87rXx2bipvkva0FiAnlMmwG9uOtHVwD5OM=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BN6PR1201MB0146.namprd12.prod.outlook.com
 (2603:10b6:405:59::18) by BN6PR1201MB0018.namprd12.prod.outlook.com
 (2603:10b6:405:54::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.32; Fri, 2 Oct
 2020 20:19:32 +0000
Received: from BN6PR1201MB0146.namprd12.prod.outlook.com
 ([fe80::615d:bea9:8838:92be]) by BN6PR1201MB0146.namprd12.prod.outlook.com
 ([fe80::615d:bea9:8838:92be%4]) with mapi id 15.20.3433.037; Fri, 2 Oct 2020
 20:19:32 +0000
From: Jonathan Kim <jonathan.kim@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 3/3] drm/amdgpu: add xgmi perfmons for arcturus
Date: Fri,  2 Oct 2020 16:19:13 -0400
Message-Id: <20201002201913.126122-3-jonathan.kim@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201002201913.126122-1-jonathan.kim@amd.com>
References: <20201002201913.126122-1-jonathan.kim@amd.com>
X-Originating-IP: [165.204.55.251]
X-ClientProxiedBy: YT1PR01CA0050.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2e::19) To BN6PR1201MB0146.namprd12.prod.outlook.com
 (2603:10b6:405:59::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from jonathan-KFD.amd.com (165.204.55.251) by
 YT1PR01CA0050.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2e::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3433.34 via Frontend Transport; Fri, 2 Oct 2020 20:19:32 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: ed7b713c-407a-4cf5-ca98-08d86710796b
X-MS-TrafficTypeDiagnostic: BN6PR1201MB0018:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN6PR1201MB0018D453F7584B1520B2633285310@BN6PR1201MB0018.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1051;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Q7bSzN018nttk+e/0//vAZJA7Ywv6syjN6ueuWS1R/rKg0xT8amsfyZc2BCbdOC1yYIgkXYAC4zYd6BPGM3uMSCPd/3H6qd5aORqBoX/F3Wr6jze13EdHKEBR7t72alQdk5GAxcAybcWghD88zINxNNxl4Xndx1n7JE7Ma34UewQ5Mtxwi7WIhGT6s0VSxMeVtqOmyjIGKuynsJUn1+OnoL96kqBSFfLN3DOUlhqqqmO1kUpNR3tI02VMYZVk8opk1HoVqGwPnNNVSMn19jBlX3UPMdxbDam41SIKYCNBsqPvdvywmO/3xgscPDl1uahehgwnF1VdoI2dfUByws9yQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN6PR1201MB0146.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(396003)(376002)(136003)(39860400002)(366004)(8676002)(4326008)(186003)(16526019)(26005)(956004)(8936002)(6916009)(44832011)(1076003)(2616005)(86362001)(316002)(6486002)(7696005)(66946007)(2906002)(66476007)(66556008)(52116002)(5660300002)(6666004)(36756003)(478600001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: SDxl6O4f7lWVN1GAA2kYfmH79MgL02I0lQ0abwsA32IFlk/XOs6eIR3yAE57Fk26zqhX5mdLTvtjs1CYr4UMSnIxKFb6eFb94q0IFgdlw3YtkjXKRmWvT/hVCA2eiVDBPkqnpVGszsn8WDeoNiFqiH1tRJ81UjwSd4PFL9HWZqaKj++qy56o7bdyJ8o+dIQJAiPLMlPFq/Bojo8FayCsu1edr4hAc3uIzu4DJUKNhZjrQkwAWHGRUA7n59YfoeOn5zMA0M4xuf/uS9Rxxv0zl7RBfAD8QeYjowMZvxltdrZsw5WB5E832kF1eOJKu1gLMTKN3Zqfrh8V5sk1n/yhTUYst8DcURncWMnWtw2le1Sph+Uq2vQwotMKq+Y9sOb+IBpemyC2/d3zlikwpQ1mtq9VpFJsOJpDjY5V0KgjOKVhJfRs32DrbJgmLJdKDCraWPVLrD/dS+rXnxsuGwAyiFiYdx8Ood+/1kr0DFfidcUlFZwCoFsR3dkHAZJCrDf80d913RHpL47vxMkMh5zQBw5W7yzXtfmE2QEPVlQxQBRW0QOVRT3Uj7qK6veMmdRez9c9aWTUEKOsZ2PB2RgcqLfdaDN6FExTi/z7zZQJqwq0r0Wrcncjm2WlTLiI8fZRibWNAeZkqIehBpcOCmwZ1Q==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed7b713c-407a-4cf5-ca98-08d86710796b
X-MS-Exchange-CrossTenant-AuthSource: BN6PR1201MB0146.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2020 20:19:32.8829 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZgPKpEB0VE56J8VnWj/F2BNmw591OjG8rnXsc58dCurclGIc4cb1ruiyQFx1O/lV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB0018
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
Cc: Jonathan Kim <jonathan.kim@amd.com>, Harish.Kasiviswanathan@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add xgmi perfmons for Arcturus.

Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>

v4: Align with patch 2 with struct improvements
v3: Align with patch 2 streamlining perf types versus event config types.
v2: Resend for re-review with alignment for v3 in patch 2.
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c | 49 +++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/df_v3_6.c    |  3 ++
 2 files changed, 52 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c
index 20c500f61b40..d29226f7b6ea 100644
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
@@ -174,6 +177,36 @@ static struct amdgpu_pmu_config df_vega20_config = {
 	.num_types = 0
 };
 
+/* Arcturus events */
+static struct amdgpu_pmu_attr arcturus_events[NUM_EVENTS_ARCTURUS_MAX] = {
+	{ .name = "xgmi_link0_data_outbound",
+			.config = "event=0x7,instance=0x4b,umask=0x2" },
+	{ .name = "xgmi_link1_data_outbound",
+			.config = "event=0x7,instance=0x4c,umask=0x2" },
+	{ .name = "xgmi_link2_data_outbound",
+			.config = "event=0x7,instance=0x4d,umask=0x2" },
+	{ .name = "xgmi_link3_data_outbound",
+			.config = "event=0x7,instance=0x4e,umask=0x2" },
+	{ .name = "xgmi_link4_data_outbound",
+			.config = "event=0x7,instance=0x4f,umask=0x2" },
+	{ .name = "xgmi_link5_data_outbound",
+			.config = "event=0x7,instance=0x50,umask=0x2" }
+};
+
+static struct amdgpu_pmu_type arcturus_types[NUM_EVENT_TYPES_ARCTURUS] = {
+	{ .type = AMDGPU_PMU_EVENT_CONFIG_TYPE_XGMI,
+				.num_of_type = NUM_EVENTS_ARCTURUS_XGMI }
+};
+
+static struct amdgpu_pmu_config arcturus_config = {
+	.formats = amdgpu_pmu_formats,
+	.num_formats = ARRAY_SIZE(amdgpu_pmu_formats),
+	.events = arcturus_events,
+	.num_events = ARRAY_SIZE(arcturus_events),
+	.types = arcturus_types,
+	.num_types = ARRAY_SIZE(arcturus_types)
+};
+
 /* initialize perf counter */
 static int amdgpu_perf_event_init(struct perf_event *event)
 {
@@ -605,6 +638,22 @@ int amdgpu_pmu_init(struct amdgpu_device *adev)
 		}
 
 		break;
+	case CHIP_ARCTURUS:
+		pmu_entry = create_pmu_entry(adev, AMDGPU_PMU_PERF_TYPE_ALL,
+						"", "amdgpu");
+		if (!pmu_entry)
+			return -ENOMEM;
+
+		ret = init_pmu_entry_by_type_and_add(pmu_entry,
+							&arcturus_config);
+
+		if (ret) {
+			kfree(pmu_entry);
+			return -ENOMEM;
+		}
+
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
