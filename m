Return-Path: <SRS0=93xL=DJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E36A9C4363D
	for <amd-gfx@archiver.kernel.org>; Fri,  2 Oct 2020 20:19:36 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 38CBE206FA
	for <amd-gfx@archiver.kernel.org>; Fri,  2 Oct 2020 20:19:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="LzoXT2pZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38CBE206FA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EEE096E9CD;
	Fri,  2 Oct 2020 20:19:35 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2065.outbound.protection.outlook.com [40.107.236.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 422526E9CB
 for <amd-gfx@lists.freedesktop.org>; Fri,  2 Oct 2020 20:19:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oF84J9dghUBfF2R6KL6l+mLfkNykrUGdjKRfwNWNFgFq4pV4TkEVuQcpo9UNNS1OJiYtS1s6s/f0AUYpZqUPT3b5PT9+EFb4/oQLxJ7BhycS7hX2KkNKb5Z0ccqi4DDmnpNyuOvEX+EyEBFhhA9ifsw22oqJfQbw/H1nlWZp9gEk0xeYA8pJrdSPhfcGQ7tubWY+Dl6jtnMe4gZmmaJhGLq0GXXpUlmMgoY5VBEeyfJ8w7+Zroqti6UeYinDijHdpKRmBivVUdxbLp3yfgpaEtxo6dgO/bNBM7hJnq39tQf6OXJmbtjiVY7eKHjmZmXrO0NU6z/lURE9C40ia2+xCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1j3JeTZm952oOaKlwGjEYPLFws0XpxhD57csQu72468=;
 b=f3AJ+FLmGgYmgSKqWk/po1lVpCzGC3qN639DYblvzwzQB1Ux8e5uzOsQ2jIeJrnuARMr1+nA+FNMJAdLAsTlmJktBJOthBYGbtUN8KKpZizcjBsP9hucUsJu/zg+hxYgpolx+rBFNjSoDu5rSRD58dE33c2axfThXo2AIY5ZwcEU7yymAqWvaYl+9pa0JwZkd8kYaUe1IFGaB5ooblrQ/7jtx/YjUyHloL0lmIy5vDGkXcuUfNyu0U+BooKKUYSVsqrDBeoXvqdYJPy2lNlo5Snv7Fgmj0HygrDi/LHZ3iP/oBF9NQi72FdkRvqcSuQWQag+hqKVdCQ8Eo7UUmTjZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1j3JeTZm952oOaKlwGjEYPLFws0XpxhD57csQu72468=;
 b=LzoXT2pZSyGMgwdtRhblwHbHM1VL/Afk+n77jhH5LUN2AXHiRqCmCam7L6SlnJflOoaa6q8zD2zxPNiFxtQQd7Gnk9o6fluu79YmE+0PmhrQj6wuH0O/Ek7kB1dIbmTzDjtBXKe4gcZgP8vzQpifDKWhGj0mIF6T0mvrKpuF27c=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BN6PR1201MB0146.namprd12.prod.outlook.com
 (2603:10b6:405:59::18) by BN6PR1201MB0018.namprd12.prod.outlook.com
 (2603:10b6:405:54::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.32; Fri, 2 Oct
 2020 20:19:31 +0000
Received: from BN6PR1201MB0146.namprd12.prod.outlook.com
 ([fe80::615d:bea9:8838:92be]) by BN6PR1201MB0146.namprd12.prod.outlook.com
 ([fe80::615d:bea9:8838:92be%4]) with mapi id 15.20.3433.037; Fri, 2 Oct 2020
 20:19:30 +0000
From: Jonathan Kim <jonathan.kim@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/3] drm/amdgpu: add per device user friendly xgmi events for
 vega20
Date: Fri,  2 Oct 2020 16:19:12 -0400
Message-Id: <20201002201913.126122-2-jonathan.kim@amd.com>
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
 15.20.3433.34 via Frontend Transport; Fri, 2 Oct 2020 20:19:30 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: a566d8f4-199f-4bac-3aa4-08d867107839
X-MS-TrafficTypeDiagnostic: BN6PR1201MB0018:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN6PR1201MB0018954FBE2A918DD8D49AFF85310@BN6PR1201MB0018.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:556;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FlFY1Y3GzxUh38kwm9AjTtd4X2R2ntitfD9rY34oYZoGLgde2OIjzLdDBi81xE9aot23+Hw4jnyfKBRpgx213C+79uR91oz2+vPrvxEy8feJKnOWx26UNHTXuurKvZpLm9YBF/rv4roYNFFTCsKFhk4WB1Oc/9Llw2/U+arZanPducKfwQtjR3quug2r20941TXZkh3jxtVUEVMU1AYt+Z9FmMCMIGRr2vC1KJJrqqntLEJuYc36RtsM47VzgL4y9QmXVgW8wYsI9rCsrlpMUjw8+MZJPSA1LXWrwN5p9IeEEjTfC+t0YGxaZ+DUiydn
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN6PR1201MB0146.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(396003)(376002)(136003)(39860400002)(366004)(8676002)(4326008)(186003)(16526019)(26005)(956004)(8936002)(83380400001)(6916009)(44832011)(1076003)(30864003)(2616005)(86362001)(316002)(6486002)(7696005)(66946007)(2906002)(66476007)(66556008)(52116002)(5660300002)(6666004)(36756003)(478600001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: UQLT0T9mRgG3O28Ulctj8usTLwjo6DlvnJlZmW07RAPGAPkosxTu1cVGQr6YfACQ7C1gbC6hYHvnuzIS1uPwWOOssigzoaLosPHU8TxM4g1jL8a0Y4WI9lN73vXKKzbPQ+orNcrDf1ALI/nBq9qCZpr2VykMygVVA3+/U+6PjYCSrbQUK2Jl9sUYXtWALHb0/eF90INjvxPLNBuJdUn8H5+FYrC1X62/FaiIPrahXl97p/+Yt5PwWEWZewyLW0RqExevKRn5lnOFnKwp10GsqwvaJDawEFNWhqWDKu+hBlk855GD4x5UjNsU/CwOK91EUvFd7oSQzuqMiXbOPVjpvXVzAiravOwsl80doj2F7gTOHVotZYowi9JkRKFlH+J13RWCxepcRaU8oQ+dM+XVDOINBLNVPOyEsfh429a/2V+yCIx5fdv/MXuL4wMpKM47/41X9jlaF85WdnNemLC6iaIk3vPKk/l51xi/nsWHDHFnaXdNFzbvpGJE3qzAxRad21j9ap8JV3HYrhEqWh++s12vxSS1Eyw0q6xNKLcPmZ5rVVQi/wlWoJJy05K+IrO4wlgHIdcIVmnZqdmgIHMHo08hR0L+0ji6iHj/+MADR1B0F0Wf/NhVYZrlOz0fNd74frrIm5VSgf00rC3W/h0HbQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a566d8f4-199f-4bac-3aa4-08d867107839
X-MS-Exchange-CrossTenant-AuthSource: BN6PR1201MB0146.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2020 20:19:30.9538 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IO85o5hgl+L1Oee4ZMrtWfAIld0zX/gkNKgTmaYESYZqJN6B3jpQWCHkyC/Hucn6
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

Non-outbound data metrics are non useful so mark them as legacy.
Bucket new perf counters into device and not device ip.
Bind events to chip instead of IP.
Report available event counters and not number of hw counter banks.
Move DF public macros to private since not needed outside of IP version.

v5: cleanup by moving per chip configs into structs

v4: After more discussion, replace *_LEGACY references with IP references
to indicate concept of pmu-typed versus event-config-typed event
registration.

v3: attr groups const array is global but attr groups are allocated per
device which doesn't work and causes problems on memory allocation and
de-allocation for pmu unregister. Switch to building const attr groups
per pmu instead to simplify solution.

v2: add comments on sysfs structure and formatting.

Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h     |  13 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c | 432 ++++++++++++++++++++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.h |  26 +-
 drivers/gpu/drm/amd/amdgpu/df_v3_6.c    |  72 +---
 drivers/gpu/drm/amd/amdgpu/df_v3_6.h    |   9 -
 5 files changed, 408 insertions(+), 144 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 13f92dea182a..f43dfdd2716a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1279,19 +1279,6 @@ bool amdgpu_device_load_pci_state(struct pci_dev *pdev);
 
 #include "amdgpu_object.h"
 
-/* used by df_v3_6.c and amdgpu_pmu.c */
-#define AMDGPU_PMU_ATTR(_name, _object)					\
-static ssize_t								\
-_name##_show(struct device *dev,					\
-			       struct device_attribute *attr,		\
-			       char *page)				\
-{									\
-	BUILD_BUG_ON(sizeof(_object) >= PAGE_SIZE - 1);			\
-	return sprintf(page, _object "\n");				\
-}									\
-									\
-static struct device_attribute pmu_attr_##_name = __ATTR_RO(_name)
-
 static inline bool amdgpu_is_tmz(struct amdgpu_device *adev)
 {
        return adev->gmc.tmz_enabled;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c
index 1b0ec715c8ba..20c500f61b40 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c
@@ -27,9 +27,20 @@
 #include <linux/init.h>
 #include "amdgpu.h"
 #include "amdgpu_pmu.h"
-#include "df_v3_6.h"
 
 #define PMU_NAME_SIZE 32
+#define NUM_FORMATS_AMDGPU_PMU		4
+#define NUM_FORMATS_DF_VEGA20		3
+#define NUM_EVENTS_DF_VEGA20		8
+#define NUM_EVENT_TYPES_VEGA20		1
+#define NUM_EVENTS_VEGA20_XGMI		2
+#define NUM_EVENTS_VEGA20_MAX		NUM_EVENTS_VEGA20_XGMI
+
+struct amdgpu_pmu_event_attribute {
+	struct device_attribute attr;
+	const char *event_str;
+	unsigned int type;
+};
 
 /* record to keep track of pmu entry per pmu type per device */
 struct amdgpu_pmu_entry {
@@ -37,11 +48,132 @@ struct amdgpu_pmu_entry {
 	struct amdgpu_device *adev;
 	struct pmu pmu;
 	unsigned int pmu_perf_type;
+	char *pmu_type_name;
+	char *pmu_file_prefix;
+	struct attribute_group fmt_attr_group;
+	struct amdgpu_pmu_event_attribute *fmt_attr;
+	struct attribute_group evt_attr_group;
+	struct amdgpu_pmu_event_attribute *evt_attr;
 };
 
+static ssize_t amdgpu_pmu_event_show(struct device *dev,
+				struct device_attribute *attr, char *buf)
+{
+	struct amdgpu_pmu_event_attribute *amdgpu_pmu_attr;
+
+	amdgpu_pmu_attr = container_of(attr, struct amdgpu_pmu_event_attribute,
+									attr);
+
+	if (!amdgpu_pmu_attr->type)
+		return sprintf(buf, "%s\n", amdgpu_pmu_attr->event_str);
+
+	return sprintf(buf, "%s,type=0x%x\n",
+			amdgpu_pmu_attr->event_str, amdgpu_pmu_attr->type);
+}
+
 static LIST_HEAD(amdgpu_pmu_list);
 
 
+struct amdgpu_pmu_attr {
+	const char *name;
+	const char *config;
+};
+
+struct amdgpu_pmu_type {
+	const unsigned int type;
+	const unsigned int num_of_type;
+};
+
+struct amdgpu_pmu_config {
+	struct amdgpu_pmu_attr *formats;
+	unsigned int num_formats;
+	struct amdgpu_pmu_attr *events;
+	unsigned int num_events;
+	struct amdgpu_pmu_type *types;
+	unsigned int num_types;
+};
+
+/*
+ * Events fall under two categories:
+ *  - PMU typed
+ *    Events in /sys/bus/event_source/devices/amdgpu_<pmu_type>_<dev_num> have
+ *    performance counter operations handled by one IP <pmu_type>.  Formats and
+ *    events should be defined by <pmu_type>_<asic_type>_formats and
+ *    <pmu_type>_<asic_type>_events respectively.
+ *
+ *  - Event config typed
+ *    Events in /sys/bus/event_source/devices/amdgpu_<dev_num> have performance
+ *    counter operations that can be handled by multiple IPs dictated by their
+ *    "type" format field.  Formats and events should be defined by
+ *    amdgpu_pmu_formats and <asic_type>_events respectively.  Format field
+ *    "type" is generated in amdgpu_pmu_event_show and defined in
+ *    <asic_type>_event_config_types.
+ */
+
+static struct amdgpu_pmu_attr amdgpu_pmu_formats[NUM_FORMATS_AMDGPU_PMU] = {
+	{ .name = "event", .config = "config:0-7" },
+	{ .name = "instance", .config = "config:8-15" },
+	{ .name = "umask", .config = "config:16-23"},
+	{ .name = "type", .config = "config:56-63"}
+};
+
+/* Vega20 events */
+static struct amdgpu_pmu_attr vega20_events[NUM_EVENTS_VEGA20_MAX] = {
+	{ .name = "xgmi_link0_data_outbound",
+			.config = "event=0x7,instance=0x46,umask=0x2" },
+	{ .name = "xgmi_link1_data_outbound",
+			.config = "event=0x7,instance=0x47,umask=0x2" }
+};
+
+static struct amdgpu_pmu_type vega20_types[NUM_EVENT_TYPES_VEGA20] = {
+	{ .type = AMDGPU_PMU_EVENT_CONFIG_TYPE_XGMI,
+					.num_of_type = NUM_EVENTS_VEGA20_XGMI }
+};
+
+static struct amdgpu_pmu_config vega20_config = {
+	.formats = amdgpu_pmu_formats,
+	.num_formats = ARRAY_SIZE(amdgpu_pmu_formats),
+	.events = vega20_events,
+	.num_events = ARRAY_SIZE(vega20_events),
+	.types = vega20_types,
+	.num_types = ARRAY_SIZE(vega20_types)
+};
+
+/* Vega20 data fabric (DF) events */
+static struct amdgpu_pmu_attr df_vega20_formats[NUM_FORMATS_DF_VEGA20] = {
+	{ .name = "event", .config = "config:0-7" },
+	{ .name = "instance", .config = "config:8-15" },
+	{ .name = "umask", .config = "config:16-23"}
+};
+
+static struct amdgpu_pmu_attr df_vega20_events[NUM_EVENTS_DF_VEGA20] = {
+	{ .name = "cake0_pcsout_txdata",
+			.config = "event=0x7,instance=0x46,umask=0x2" },
+	{ .name = "cake1_pcsout_txdata",
+			.config = "event=0x7,instance=0x47,umask=0x2" },
+	{ .name = "cake0_pcsout_txmeta",
+			.config = "event=0x7,instance=0x46,umask=0x4" },
+	{ .name = "cake1_pcsout_txmeta",
+			.config = "event=0x7,instance=0x47,umask=0x4" },
+	{ .name = "cake0_ftiinstat_reqalloc",
+			.config = "event=0xb,instance=0x46,umask=0x4" },
+	{ .name = "cake1_ftiinstat_reqalloc",
+			.config = "event=0xb,instance=0x47,umask=0x4" },
+	{ .name = "cake0_ftiinstat_rspalloc",
+			.config = "event=0xb,instance=0x46,umask=0x8" },
+	{ .name = "cake1_ftiinstat_rspalloc",
+			.config = "event=0xb,instance=0x47,umask=0x8" }
+};
+
+static struct amdgpu_pmu_config df_vega20_config = {
+	.formats = df_vega20_formats,
+	.num_formats = ARRAY_SIZE(df_vega20_formats),
+	.events = df_vega20_events,
+	.num_events = ARRAY_SIZE(df_vega20_events),
+	.types = NULL,
+	.num_types = 0
+};
+
 /* initialize perf counter */
 static int amdgpu_perf_event_init(struct perf_event *event)
 {
@@ -53,6 +185,7 @@ static int amdgpu_perf_event_init(struct perf_event *event)
 
 	/* update the hw_perf_event struct with config data */
 	hwc->config = event->attr.config;
+	hwc->config_base = AMDGPU_PMU_PERF_TYPE_NONE;
 
 	return 0;
 }
@@ -72,8 +205,9 @@ static void amdgpu_perf_start(struct perf_event *event, int flags)
 	WARN_ON_ONCE(!(hwc->state & PERF_HES_UPTODATE));
 	hwc->state = 0;
 
-	switch (pe->pmu_perf_type) {
-	case PERF_TYPE_AMDGPU_DF:
+	switch (hwc->config_base) {
+	case AMDGPU_PMU_EVENT_CONFIG_TYPE_DF:
+	case AMDGPU_PMU_EVENT_CONFIG_TYPE_XGMI:
 		if (!(flags & PERF_EF_RELOAD)) {
 			target_cntr = pe->adev->df.funcs->pmc_start(pe->adev,
 						hwc->config, 0 /* unused */,
@@ -101,14 +235,14 @@ static void amdgpu_perf_read(struct perf_event *event)
 	struct amdgpu_pmu_entry *pe = container_of(event->pmu,
 						  struct amdgpu_pmu_entry,
 						  pmu);
-
 	u64 count, prev;
 
 	do {
 		prev = local64_read(&hwc->prev_count);
 
-		switch (pe->pmu_perf_type) {
-		case PERF_TYPE_AMDGPU_DF:
+		switch (hwc->config_base) {
+		case AMDGPU_PMU_EVENT_CONFIG_TYPE_DF:
+		case AMDGPU_PMU_EVENT_CONFIG_TYPE_XGMI:
 			pe->adev->df.funcs->pmc_get_count(pe->adev,
 						hwc->config, hwc->idx, &count);
 			break;
@@ -132,8 +266,9 @@ static void amdgpu_perf_stop(struct perf_event *event, int flags)
 	if (hwc->state & PERF_HES_UPTODATE)
 		return;
 
-	switch (pe->pmu_perf_type) {
-	case PERF_TYPE_AMDGPU_DF:
+	switch (hwc->config_base) {
+	case AMDGPU_PMU_EVENT_CONFIG_TYPE_DF:
+	case AMDGPU_PMU_EVENT_CONFIG_TYPE_XGMI:
 		pe->adev->df.funcs->pmc_stop(pe->adev, hwc->config, hwc->idx,
 									0);
 		break;
@@ -160,10 +295,22 @@ static int amdgpu_perf_add(struct perf_event *event, int flags)
 						  struct amdgpu_pmu_entry,
 						  pmu);
 
+	switch (pe->pmu_perf_type) {
+	case AMDGPU_PMU_PERF_TYPE_DF:
+		hwc->config_base = AMDGPU_PMU_EVENT_CONFIG_TYPE_DF;
+		break;
+	case AMDGPU_PMU_PERF_TYPE_ALL:
+		hwc->config_base = (hwc->config >>
+					AMDGPU_PMU_EVENT_CONFIG_TYPE_SHIFT) &
+					AMDGPU_PMU_EVENT_CONFIG_TYPE_MASK;
+		break;
+	}
+
 	event->hw.state = PERF_HES_UPTODATE | PERF_HES_STOPPED;
 
-	switch (pe->pmu_perf_type) {
-	case PERF_TYPE_AMDGPU_DF:
+	switch (hwc->config_base) {
+	case AMDGPU_PMU_EVENT_CONFIG_TYPE_DF:
+	case AMDGPU_PMU_EVENT_CONFIG_TYPE_XGMI:
 		target_cntr = pe->adev->df.funcs->pmc_start(pe->adev,
 						hwc->config, 0 /* unused */,
 						1 /* add counter */);
@@ -196,8 +343,9 @@ static void amdgpu_perf_del(struct perf_event *event, int flags)
 
 	amdgpu_perf_stop(event, PERF_EF_UPDATE);
 
-	switch (pe->pmu_perf_type) {
-	case PERF_TYPE_AMDGPU_DF:
+	switch (hwc->config_base) {
+	case AMDGPU_PMU_EVENT_CONFIG_TYPE_DF:
+	case AMDGPU_PMU_EVENT_CONFIG_TYPE_XGMI:
 		pe->adev->df.funcs->pmc_stop(pe->adev, hwc->config, hwc->idx,
 									1);
 		break;
@@ -208,25 +356,92 @@ static void amdgpu_perf_del(struct perf_event *event, int flags)
 	perf_event_update_userpage(event);
 }
 
-/* vega20 pmus */
+static void amdgpu_pmu_create_event_attrs_by_type(
+				struct attribute_group *attr_group,
+				struct amdgpu_pmu_event_attribute *pmu_attr,
+				struct amdgpu_pmu_attr events[],
+				int s_offset,
+				int e_offset,
+				unsigned int type)
+{
+	int i;
+
+	pmu_attr += s_offset;
+
+	for (i = s_offset; i < e_offset; i++) {
+		attr_group->attrs[i] = &pmu_attr->attr.attr;
+		sysfs_attr_init(&pmu_attr->attr.attr);
+		pmu_attr->attr.attr.name = events[i].name;
+		pmu_attr->attr.attr.mode = 0444;
+		pmu_attr->attr.show = amdgpu_pmu_event_show;
+		pmu_attr->event_str = events[i].config;
+		pmu_attr->type = type;
+		pmu_attr++;
+	}
+}
 
-/* init pmu tracking per pmu type */
-static int init_pmu_by_type(struct amdgpu_device *adev,
-		  const struct attribute_group *attr_groups[],
-		  char *pmu_type_name, char *pmu_file_prefix,
-		  unsigned int pmu_perf_type,
-		  unsigned int num_counters)
+static void amdgpu_pmu_create_attrs(struct attribute_group *attr_group,
+				struct amdgpu_pmu_event_attribute *pmu_attr,
+				struct amdgpu_pmu_attr events[],
+				int num_events)
 {
-	char pmu_name[PMU_NAME_SIZE];
-	struct amdgpu_pmu_entry *pmu_entry;
-	int ret = 0;
+	amdgpu_pmu_create_event_attrs_by_type(attr_group, pmu_attr, events, 0,
+				num_events, AMDGPU_PMU_EVENT_CONFIG_TYPE_NONE);
+}
 
-	pmu_entry = kzalloc(sizeof(struct amdgpu_pmu_entry), GFP_KERNEL);
 
-	if (!pmu_entry)
+static int amdgpu_pmu_alloc_pmu_attrs(
+				struct attribute_group *fmt_attr_group,
+				struct amdgpu_pmu_event_attribute **fmt_attr,
+				struct attribute_group *evt_attr_group,
+				struct amdgpu_pmu_event_attribute **evt_attr,
+				struct amdgpu_pmu_config *config)
+{
+	*fmt_attr = kcalloc(config->num_formats, sizeof(**fmt_attr),
+								GFP_KERNEL);
+
+	if (!(*fmt_attr))
 		return -ENOMEM;
 
-	pmu_entry->adev = adev;
+	fmt_attr_group->attrs = kcalloc(config->num_formats + 1,
+				sizeof(*fmt_attr_group->attrs), GFP_KERNEL);
+
+	if (!fmt_attr_group->attrs)
+		goto err_fmt_attr_grp;
+
+	*evt_attr = kcalloc(config->num_events, sizeof(**evt_attr), GFP_KERNEL);
+
+	if (!(*evt_attr))
+		goto err_evt_attr;
+
+	evt_attr_group->attrs = kcalloc(config->num_events + 1,
+				sizeof(*evt_attr_group->attrs), GFP_KERNEL);
+
+	if (!evt_attr_group->attrs)
+		goto err_evt_attr_grp;
+
+	return 0;
+err_evt_attr_grp:
+	kfree(*evt_attr);
+err_evt_attr:
+	kfree(fmt_attr_group->attrs);
+err_fmt_attr_grp:
+	kfree(*fmt_attr);
+	return -ENOMEM;
+}
+
+/* init pmu tracking per pmu type */
+static int init_pmu_entry_by_type_and_add(struct amdgpu_pmu_entry *pmu_entry,
+			struct amdgpu_pmu_config *config)
+{
+	const struct attribute_group *attr_groups[] = {
+		&pmu_entry->fmt_attr_group,
+		&pmu_entry->evt_attr_group,
+		NULL
+	};
+	char pmu_name[PMU_NAME_SIZE];
+	int ret = 0, total_num_events = 0;
+
 	pmu_entry->pmu = (struct pmu){
 		.event_init = amdgpu_perf_event_init,
 		.add = amdgpu_perf_add,
@@ -237,59 +452,162 @@ static int init_pmu_by_type(struct amdgpu_device *adev,
 		.task_ctx_nr = perf_invalid_context,
 	};
 
-	pmu_entry->pmu.attr_groups = attr_groups;
-	pmu_entry->pmu_perf_type = pmu_perf_type;
-	snprintf(pmu_name, PMU_NAME_SIZE, "%s_%d",
-				pmu_file_prefix, adev_to_drm(adev)->primary->index);
+	ret = amdgpu_pmu_alloc_pmu_attrs(&pmu_entry->fmt_attr_group,
+					&pmu_entry->fmt_attr,
+					&pmu_entry->evt_attr_group,
+					&pmu_entry->evt_attr,
+					config);
+
+	if (ret)
+		goto err_out;
+
+	amdgpu_pmu_create_attrs(&pmu_entry->fmt_attr_group, pmu_entry->fmt_attr,
+					config->formats, config->num_formats);
+
+	if (pmu_entry->pmu_perf_type == AMDGPU_PMU_PERF_TYPE_ALL) {
+		int i;
+
+		for (i = 0; i < config->num_types; i++) {
+			amdgpu_pmu_create_event_attrs_by_type(
+					&pmu_entry->evt_attr_group,
+					pmu_entry->evt_attr,
+					config->events,
+					total_num_events,
+					total_num_events +
+						config->types[i].num_of_type,
+					config->types[i].type);
+			total_num_events += config->types[i].num_of_type;
+		}
+	} else {
+		amdgpu_pmu_create_attrs(&pmu_entry->evt_attr_group,
+					pmu_entry->evt_attr,
+					config->events, config->num_events);
+		total_num_events = config->num_events;
+	}
+
+	pmu_entry->pmu.attr_groups = kmemdup(attr_groups, sizeof(attr_groups),
+								GFP_KERNEL);
+
+	if (!pmu_entry->pmu.attr_groups)
+		goto err_attr_group;
+
+	snprintf(pmu_name, PMU_NAME_SIZE, "%s_%d", pmu_entry->pmu_file_prefix,
+				adev_to_drm(pmu_entry->adev)->primary->index);
 
 	ret = perf_pmu_register(&pmu_entry->pmu, pmu_name, -1);
 
-	if (ret) {
-		kfree(pmu_entry);
-		pr_warn("Error initializing AMDGPU %s PMUs.\n", pmu_type_name);
-		return ret;
-	}
+	if (ret)
+		goto err_register;
+
+	if (pmu_entry->pmu_perf_type != AMDGPU_PMU_PERF_TYPE_ALL)
+		pr_info("Detected AMDGPU %s Counters. # of Counters = %d.\n",
+				pmu_entry->pmu_type_name, total_num_events);
+	else
+		pr_info("Detected AMDGPU %d Perf Events.\n", total_num_events);
 
-	pr_info("Detected AMDGPU %s Counters. # of Counters = %d.\n",
-			pmu_type_name, num_counters);
 
 	list_add_tail(&pmu_entry->entry, &amdgpu_pmu_list);
 
 	return 0;
+err_register:
+	kfree(pmu_entry->pmu.attr_groups);
+err_attr_group:
+	kfree(pmu_entry->fmt_attr_group.attrs);
+	kfree(pmu_entry->fmt_attr);
+	kfree(pmu_entry->evt_attr_group.attrs);
+	kfree(pmu_entry->evt_attr);
+err_out:
+	pr_warn("Error initializing AMDGPU %s PMUs.\n",
+						pmu_entry->pmu_type_name);
+	return ret;
+}
+
+/* destroy all pmu data associated with target device */
+void amdgpu_pmu_fini(struct amdgpu_device *adev)
+{
+	struct amdgpu_pmu_entry *pe, *temp;
+
+	list_for_each_entry_safe(pe, temp, &amdgpu_pmu_list, entry) {
+		if (pe->adev != adev)
+			continue;
+		list_del(&pe->entry);
+		perf_pmu_unregister(&pe->pmu);
+		kfree(pe->pmu.attr_groups);
+		kfree(pe->fmt_attr_group.attrs);
+		kfree(pe->fmt_attr);
+		kfree(pe->evt_attr_group.attrs);
+		kfree(pe->evt_attr);
+		kfree(pe);
+	}
+}
+
+static struct amdgpu_pmu_entry *create_pmu_entry(struct amdgpu_device *adev,
+						unsigned int pmu_type,
+						char *pmu_type_name,
+						char *pmu_file_prefix)
+{
+	struct amdgpu_pmu_entry *pmu_entry;
+
+	pmu_entry = kzalloc(sizeof(struct amdgpu_pmu_entry), GFP_KERNEL);
+
+	if (!pmu_entry)
+		return pmu_entry;
+
+	pmu_entry->adev = adev;
+	pmu_entry->fmt_attr_group.name = "format";
+	pmu_entry->fmt_attr_group.attrs = NULL;
+	pmu_entry->evt_attr_group.name = "events";
+	pmu_entry->evt_attr_group.attrs = NULL;
+	pmu_entry->pmu_perf_type = pmu_type;
+	pmu_entry->pmu_type_name = pmu_type_name;
+	pmu_entry->pmu_file_prefix = pmu_file_prefix;
+
+	return pmu_entry;
 }
 
 /* init amdgpu_pmu */
 int amdgpu_pmu_init(struct amdgpu_device *adev)
 {
 	int ret = 0;
+	struct amdgpu_pmu_entry *pmu_entry, *pmu_entry_df;
 
 	switch (adev->asic_type) {
 	case CHIP_VEGA20:
-		/* init df */
-		ret = init_pmu_by_type(adev, df_v3_6_attr_groups,
-				       "DF", "amdgpu_df", PERF_TYPE_AMDGPU_DF,
-				       DF_V3_6_MAX_COUNTERS);
+		pmu_entry_df = create_pmu_entry(adev, AMDGPU_PMU_PERF_TYPE_DF,
+						"DF", "amdgpu_df");
 
-		/* other pmu types go here*/
-		break;
-	default:
-		return 0;
-	}
+		if (!pmu_entry_df)
+			return -ENOMEM;
 
-	return 0;
-}
+		ret = init_pmu_entry_by_type_and_add(pmu_entry_df,
+							&df_vega20_config);
 
+		if (ret) {
+			kfree(pmu_entry_df);
+			return ret;
+		}
 
-/* destroy all pmu data associated with target device */
-void amdgpu_pmu_fini(struct amdgpu_device *adev)
-{
-	struct amdgpu_pmu_entry *pe, *temp;
+		pmu_entry = create_pmu_entry(adev, AMDGPU_PMU_PERF_TYPE_ALL,
+						"", "amdgpu");
 
-	list_for_each_entry_safe(pe, temp, &amdgpu_pmu_list, entry) {
-		if (pe->adev == adev) {
-			list_del(&pe->entry);
-			perf_pmu_unregister(&pe->pmu);
-			kfree(pe);
+		if (!pmu_entry) {
+			amdgpu_pmu_fini(adev);
+			return -ENOMEM;
 		}
-	}
+
+		ret = init_pmu_entry_by_type_and_add(pmu_entry,
+							&vega20_config);
+
+		if (ret) {
+			kfree(pmu_entry);
+			amdgpu_pmu_fini(adev);
+			return ret;
+		}
+
+		break;
+	default:
+		return 0;
+	};
+
+	return ret;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.h
index 7dddb7160a11..08b9f7ca6375 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.h
@@ -26,11 +26,33 @@
 #ifndef _AMDGPU_PMU_H_
 #define _AMDGPU_PMU_H_
 
+/* PMU types. */
 enum amdgpu_pmu_perf_type {
-	PERF_TYPE_AMDGPU_DF = 0,
-	PERF_TYPE_AMDGPU_MAX
+	AMDGPU_PMU_PERF_TYPE_NONE = 0,
+	AMDGPU_PMU_PERF_TYPE_DF,
+	AMDGPU_PMU_PERF_TYPE_ALL
 };
 
+/*
+ * PMU type AMDGPU_PMU_PERF_TYPE_ALL can hold events of different "type"
+ * configurations.  Event config types are parsed from the 64-bit raw
+ * config (See EVENT_CONFIG_TYPE_SHIFT and EVENT_CONFIG_TYPE_MASK) and
+ * are registered into the HW perf events config_base.
+ *
+ * PMU types with only a single event configuration type
+ * (non-AMDGPU_PMU_PERF_TYPE_ALL) have their event config type auto generated
+ * when the performance counter is added.
+ */
+enum amdgpu_pmu_event_config_type {
+	AMDGPU_PMU_EVENT_CONFIG_TYPE_NONE = 0,
+	AMDGPU_PMU_EVENT_CONFIG_TYPE_DF,
+	AMDGPU_PMU_EVENT_CONFIG_TYPE_XGMI,
+	AMDGPU_PMU_EVENT_CONFIG_TYPE_MAX
+};
+
+#define AMDGPU_PMU_EVENT_CONFIG_TYPE_SHIFT	56
+#define AMDGPU_PMU_EVENT_CONFIG_TYPE_MASK	0xff
+
 int amdgpu_pmu_init(struct amdgpu_device *adev);
 void amdgpu_pmu_fini(struct amdgpu_device *adev);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/df_v3_6.c b/drivers/gpu/drm/amd/amdgpu/df_v3_6.c
index 0ca6e176acb0..6e57ae95f997 100644
--- a/drivers/gpu/drm/amd/amdgpu/df_v3_6.c
+++ b/drivers/gpu/drm/amd/amdgpu/df_v3_6.c
@@ -30,71 +30,17 @@
 #define DF_3_6_SMN_REG_INST_DIST        0x8
 #define DF_3_6_INST_CNT                 8
 
-static u32 df_v3_6_channel_number[] = {1, 2, 0, 4, 0, 8, 0,
-				       16, 32, 0, 0, 0, 2, 4, 8};
-
-/* init df format attrs */
-AMDGPU_PMU_ATTR(event,		"config:0-7");
-AMDGPU_PMU_ATTR(instance,	"config:8-15");
-AMDGPU_PMU_ATTR(umask,		"config:16-23");
-
-/* df format attributes  */
-static struct attribute *df_v3_6_format_attrs[] = {
-	&pmu_attr_event.attr,
-	&pmu_attr_instance.attr,
-	&pmu_attr_umask.attr,
-	NULL
-};
-
-/* df format attribute group */
-static struct attribute_group df_v3_6_format_attr_group = {
-	.name = "format",
-	.attrs = df_v3_6_format_attrs,
-};
+/* Defined in global_features.h as FTI_PERFMON_VISIBLE */
+#define DF_V3_6_MAX_COUNTERS		4
 
-/* df event attrs */
-AMDGPU_PMU_ATTR(cake0_pcsout_txdata,
-		      "event=0x7,instance=0x46,umask=0x2");
-AMDGPU_PMU_ATTR(cake1_pcsout_txdata,
-		      "event=0x7,instance=0x47,umask=0x2");
-AMDGPU_PMU_ATTR(cake0_pcsout_txmeta,
-		      "event=0x7,instance=0x46,umask=0x4");
-AMDGPU_PMU_ATTR(cake1_pcsout_txmeta,
-		      "event=0x7,instance=0x47,umask=0x4");
-AMDGPU_PMU_ATTR(cake0_ftiinstat_reqalloc,
-		      "event=0xb,instance=0x46,umask=0x4");
-AMDGPU_PMU_ATTR(cake1_ftiinstat_reqalloc,
-		      "event=0xb,instance=0x47,umask=0x4");
-AMDGPU_PMU_ATTR(cake0_ftiinstat_rspalloc,
-		      "event=0xb,instance=0x46,umask=0x8");
-AMDGPU_PMU_ATTR(cake1_ftiinstat_rspalloc,
-		      "event=0xb,instance=0x47,umask=0x8");
-
-/* df event attributes  */
-static struct attribute *df_v3_6_event_attrs[] = {
-	&pmu_attr_cake0_pcsout_txdata.attr,
-	&pmu_attr_cake1_pcsout_txdata.attr,
-	&pmu_attr_cake0_pcsout_txmeta.attr,
-	&pmu_attr_cake1_pcsout_txmeta.attr,
-	&pmu_attr_cake0_ftiinstat_reqalloc.attr,
-	&pmu_attr_cake1_ftiinstat_reqalloc.attr,
-	&pmu_attr_cake0_ftiinstat_rspalloc.attr,
-	&pmu_attr_cake1_ftiinstat_rspalloc.attr,
-	NULL
-};
-
-/* df event attribute group */
-static struct attribute_group df_v3_6_event_attr_group = {
-	.name = "events",
-	.attrs = df_v3_6_event_attrs
-};
+/* get flags from df perfmon config */
+#define DF_V3_6_GET_EVENT(x)		(x & 0xFFUL)
+#define DF_V3_6_GET_INSTANCE(x)		((x >> 8) & 0xFFUL)
+#define DF_V3_6_GET_UNITMASK(x)		((x >> 16) & 0xFFUL)
+#define DF_V3_6_PERFMON_OVERFLOW	0xFFFFFFFFFFFFULL
 
-/* df event attr groups  */
-const struct attribute_group *df_v3_6_attr_groups[] = {
-		&df_v3_6_format_attr_group,
-		&df_v3_6_event_attr_group,
-		NULL
-};
+static u32 df_v3_6_channel_number[] = {1, 2, 0, 4, 0, 8, 0,
+				       16, 32, 0, 0, 0, 2, 4, 8};
 
 static uint64_t df_v3_6_get_fica(struct amdgpu_device *adev,
 				 uint32_t ficaa_val)
diff --git a/drivers/gpu/drm/amd/amdgpu/df_v3_6.h b/drivers/gpu/drm/amd/amdgpu/df_v3_6.h
index 76998541bc30..2505c7ef258a 100644
--- a/drivers/gpu/drm/amd/amdgpu/df_v3_6.h
+++ b/drivers/gpu/drm/amd/amdgpu/df_v3_6.h
@@ -35,15 +35,6 @@ enum DF_V3_6_MGCG {
 	DF_V3_6_MGCG_ENABLE_63_CYCLE_DELAY = 15
 };
 
-/* Defined in global_features.h as FTI_PERFMON_VISIBLE */
-#define DF_V3_6_MAX_COUNTERS		4
-
-/* get flags from df perfmon config */
-#define DF_V3_6_GET_EVENT(x)		(x & 0xFFUL)
-#define DF_V3_6_GET_INSTANCE(x)		((x >> 8) & 0xFFUL)
-#define DF_V3_6_GET_UNITMASK(x)		((x >> 16) & 0xFFUL)
-#define DF_V3_6_PERFMON_OVERFLOW	0xFFFFFFFFFFFFULL
-
 extern const struct attribute_group *df_v3_6_attr_groups[];
 extern const struct amdgpu_df_funcs df_v3_6_funcs;
 
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
