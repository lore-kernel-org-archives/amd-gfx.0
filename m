Return-Path: <SRS0=BIvg=DA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B396DC4727D
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Sep 2020 18:35:50 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 28AA72068D
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Sep 2020 18:35:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="2GI2ojhW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28AA72068D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AD4EC6E9EA;
	Wed, 23 Sep 2020 18:35:49 +0000 (UTC)
Received: from NAM04-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr700080.outbound.protection.outlook.com [40.107.70.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 990886E9E8
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Sep 2020 18:35:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=elxzl0N6tqT+5wAq9YDgg1fexndT8YhqVXGwxVO16qX1l8tsWxLmYmrgcjRpBSPF6MFvm+i0N9vADpIfiPCmjUsVLipqG0k1/5ocdPcMCzV0ICNLa46DxcYpg0hmN6FiX9HjpnYnUwvK3qZ5PD8M6Xwxqjn7fa9vghzsRzA1FDpS3xVghRQ511VEUIUMIOO4EL+7kxr1ZDOxX+AUO/AlLrAs2nWWGgb/gZzKa9YkxCY2p/VeNWgG0forEfxZx/6RS6jXA8lRLLZ4YCTKL6lWgWrQ3JC0u4V+l/EbmXGEZixwJC4vAmXsowh7qfggR2dTsdMqTxISLLHc4VoiXtaAZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wbL46tNYiHkuowvd5edo4t84uSyhK9JybLPBbRCet30=;
 b=Am0dCV1gU5wgY9tVEMyifF7uG9Y442VBy99LJ9R9PoKIdq9y7R8ZR1Tw1eV1oOWATqjTEXc7I+4iWUOsoexBDDNXQ4FNoVAZpMHpxLC9g/+ogaxGs1ZPoGkvt82T8CCfipQRqKypTYKL/1nwvOJU5O+UZeCT8vxHzCnlKhf0FMwThAH5qtOxKgpzteUzzwZRi5W8XuNdlFLTtx2brM++48h/drrWvY88aUbFxaAtDjH2b3LB+Qbt0JFVILKFWYixzOHPjgSIUjhHB2PxNL+aC6e1v2NKhngrNcWqZT3/LuUH0Kwk9fhqfNiCprtCJD1B6M1jiIU/ko+OBg9J1JFu8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wbL46tNYiHkuowvd5edo4t84uSyhK9JybLPBbRCet30=;
 b=2GI2ojhWlt4pf7pYYKgPeIhpQocsG3hJKT4MZq2W/J1G2p58EevIj9C6RQVCtH5evN77Bule5p8oL3B437E9yLbzrPPtdl7SGouF3oCBQIkFFMld4A8gH5nLraP4/UWrALx28ndLYj14vSpEcGcGCvKZ+e/d5fpZ3kO6aY2Aj2E=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BN6PR1201MB0146.namprd12.prod.outlook.com
 (2603:10b6:405:59::18) by BN6PR1201MB0082.namprd12.prod.outlook.com
 (2603:10b6:405:53::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.15; Wed, 23 Sep
 2020 18:35:45 +0000
Received: from BN6PR1201MB0146.namprd12.prod.outlook.com
 ([fe80::615d:bea9:8838:92be]) by BN6PR1201MB0146.namprd12.prod.outlook.com
 ([fe80::615d:bea9:8838:92be%4]) with mapi id 15.20.3391.027; Wed, 23 Sep 2020
 18:35:45 +0000
From: Jonathan Kim <jonathan.kim@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/3] drm/amdgpu: add per device user friendly xgmi events for
 vega20
Date: Wed, 23 Sep 2020 14:35:17 -0400
Message-Id: <20200923183518.65789-2-jonathan.kim@amd.com>
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
 Transport; Wed, 23 Sep 2020 18:35:44 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: d6963ab4-46af-48cf-006b-08d85fef7bb6
X-MS-TrafficTypeDiagnostic: BN6PR1201MB0082:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN6PR1201MB008214DD945B080F20E9575085380@BN6PR1201MB0082.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:556;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9CkZP+f3p+rAr/i92jd7PYEbVlzFKQXlQNc55S3TwfTGqToGL6XBBiA0F6GJbpcgNGZUmwoxOJGmga7ZcuDxkyh1/Pa5qClK5vNw58tBFF8L6clP+YMarSX7rBUJ0+PAZ2LgemvpAUsMtoJCfiZ0/Nj4aztEOkyuxC25GjaN3MnYnOpiFquiSiqSY2weBcVpt20B0MLyX7S+vo8xaqQx7xL4gRgLLj6V/feYUw4ECDwSGbhH/CzugLq3bUxvydDj6aafUcCK8Axv1n5rNvHa4GEp9wgUOOBnzCAkG5J2q5wbT7/4d/1HKkTjKeLHZ0cn
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN6PR1201MB0146.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(376002)(39860400002)(396003)(346002)(136003)(86362001)(6486002)(316002)(478600001)(1076003)(66946007)(66556008)(66476007)(956004)(2616005)(8676002)(186003)(16526019)(26005)(83380400001)(6916009)(6666004)(2906002)(7696005)(54906003)(30864003)(36756003)(52116002)(44832011)(8936002)(5660300002)(4326008);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: oWwvzGY8b9zzbMF6HKibNjEB2/PgLqvYOY/OFcQl1+PPRm/QbMNcig9IrbM/1LHzewd/hJZTFnGE6CjCrRGz+Dj/oTnwz4at4HSZrxz/S2iu4yePyYjlsAksZXevTVjGhID1ua8RP/r6G9TqL6q2Qd7QoG4R6VJ1J6ZY1F+SxItV2drd/IQWb4o+kk4TQB2tDqApxfP97o44K9I37LctyLkrO1rSqKmf7ZShIZdObRzMx+742ovb+SVlp8CxE4cD+b8Sict38Ro9bub20/7HA5xoInnd6wlIomkAkFmuKNEB6lTF3Ntwpgu3kJ2pF3416ZCe3Kp0EuEq3nCp0utUdGYwQRw+ZyUqLOYA6jlO9/qno+O/VHxUOpjPvICEMIDIiS58OoA/bGRB32eINBaFamu8cteUDexTre2WJ2HhWHJ/5Em4Unib0iM9IYnT4zO4+f4P6IQv8/5UtBUxybS56hXgnhbTmFyDR66lTI0/EKMrHG1HfMtw9YHy/troxoATiJLyxizX5Wq9LuizJ3R1+I8gMhcDqDNC7a51kAiq1yXYCD5k2XjejoRbjKb9LDWQXnXo7CytOjhsVcdNBQTInIGAaQzUTGO0A7jMNeb/CcSODkZdAFJAjl2UlmqluNyrGxulEUd3MgPU5UNMdxxebw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6963ab4-46af-48cf-006b-08d85fef7bb6
X-MS-Exchange-CrossTenant-AuthSource: BN6PR1201MB0146.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2020 18:35:45.3261 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Le/dU4rLkis4lmSQiehNPyHO+1QP9TM9OSWeOjKJOrVKKh0XylyE+mNVSwRhn3OT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB0082
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

Non-outbound data metrics are non useful so mark them as legacy.
Bucket new perf counters into device and not device ip.
Bind events to chip instead of IP.
Report available event counters and not number of hw counter banks.
Move DF public macros to private since not needed outside of IP version.

v4: After more discussion, abandon the idea of legacy events and instead
use the concept of pmu-typed versus event-config-typed events for
flexibility.

v3: attr groups const array is global but attr groups are allocated per
device which doesn't work and causes problems on memory allocation and
de-allocation for pmu unregister. Switch to building const attr groups
per pmu instead to simplify solution.

v2: add comments on sysfs structure and formatting.

Signed-off-by: Jonathan Kim <Jonathan.Kim@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h     |  13 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c | 380 ++++++++++++++++++++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.h |  26 +-
 drivers/gpu/drm/amd/amdgpu/df_v3_6.c    |  72 +----
 drivers/gpu/drm/amd/amdgpu/df_v3_6.h    |   9 -
 5 files changed, 356 insertions(+), 144 deletions(-)

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
index 1b0ec715c8ba..610f96bb0239 100644
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
@@ -37,10 +48,79 @@ struct amdgpu_pmu_entry {
 	struct amdgpu_device *adev;
 	struct pmu pmu;
 	unsigned int pmu_perf_type;
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
+static const char *amdgpu_pmu_formats[NUM_FORMATS_AMDGPU_PMU][2] = {
+	{ "event", "config:0-7" },
+	{ "instance", "config:8-15" },
+	{ "umask", "config:16-23"},
+	{ "type", "config:56-63"}
+};
+
+/* Vega20 events */
+static const char *vega20_events[NUM_EVENTS_VEGA20_MAX][2] = {
+	{ "xgmi_link0_data_outbound", "event=0x7,instance=0x46,umask=0x2" },
+	{ "xgmi_link1_data_outbound", "event=0x7,instance=0x47,umask=0x2" }
+};
+
+static const int vega20_event_config_types[NUM_EVENT_TYPES_VEGA20][2] = {
+	{ AMDGPU_PMU_EVENT_CONFIG_TYPE_XGMI, NUM_EVENTS_VEGA20_XGMI }
+};
+
+/* Vega20 DF formats and events */
+static const char *df_vega20_formats[NUM_FORMATS_DF_VEGA20][2] = {
+	{ "event", "config:0-7" },
+	{ "instance", "config:8-15" },
+	{ "umask", "config:16-23"},
+};
+
+static const char *df_vega20_events[NUM_EVENTS_DF_VEGA20][2] = {
+	{ "cake0_pcsout_txdata", "event=0x7,instance=0x46,umask=0x2" },
+	{ "cake1_pcsout_txdata", "event=0x7,instance=0x47,umask=0x2" },
+	{ "cake0_pcsout_txmeta", "event=0x7,instance=0x46,umask=0x4" },
+	{ "cake1_pcsout_txmeta", "event=0x7,instance=0x47,umask=0x4" },
+	{ "cake0_ftiinstat_reqalloc", "event=0xb,instance=0x46,umask=0x4" },
+	{ "cake1_ftiinstat_reqalloc", "event=0xb,instance=0x47,umask=0x4" },
+	{ "cake0_ftiinstat_rspalloc", "event=0xb,instance=0x46,umask=0x8" },
+	{ "cake1_ftiinstat_rspalloc", "event=0xb,instance=0x47,umask=0x8" },
+};
 
 /* initialize perf counter */
 static int amdgpu_perf_event_init(struct perf_event *event)
@@ -53,6 +133,7 @@ static int amdgpu_perf_event_init(struct perf_event *event)
 
 	/* update the hw_perf_event struct with config data */
 	hwc->config = event->attr.config;
+	hwc->config_base = AMDGPU_PMU_PERF_TYPE_NONE;
 
 	return 0;
 }
@@ -72,8 +153,9 @@ static void amdgpu_perf_start(struct perf_event *event, int flags)
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
@@ -101,14 +183,14 @@ static void amdgpu_perf_read(struct perf_event *event)
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
@@ -132,8 +214,9 @@ static void amdgpu_perf_stop(struct perf_event *event, int flags)
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
@@ -160,10 +243,22 @@ static int amdgpu_perf_add(struct perf_event *event, int flags)
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
@@ -196,8 +291,9 @@ static void amdgpu_perf_del(struct perf_event *event, int flags)
 
 	amdgpu_perf_stop(event, PERF_EF_UPDATE);
 
-	switch (pe->pmu_perf_type) {
-	case PERF_TYPE_AMDGPU_DF:
+	switch (hwc->config_base) {
+	case AMDGPU_PMU_EVENT_CONFIG_TYPE_DF:
+	case AMDGPU_PMU_EVENT_CONFIG_TYPE_XGMI:
 		pe->adev->df.funcs->pmc_stop(pe->adev, hwc->config, hwc->idx,
 									1);
 		break;
@@ -208,25 +304,96 @@ static void amdgpu_perf_del(struct perf_event *event, int flags)
 	perf_event_update_userpage(event);
 }
 
-/* vega20 pmus */
+static void amdgpu_pmu_create_event_attrs_by_type(
+				struct attribute_group *attr_group,
+				struct amdgpu_pmu_event_attribute *pmu_attr,
+				const char *events[][2],
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
+		pmu_attr->attr.attr.name = events[i][0];
+		pmu_attr->attr.attr.mode = 0444;
+		pmu_attr->attr.show = amdgpu_pmu_event_show;
+		pmu_attr->event_str = events[i][1];
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
+				const char *events[][2], int num_events)
 {
-	char pmu_name[PMU_NAME_SIZE];
-	struct amdgpu_pmu_entry *pmu_entry;
-	int ret = 0;
+	amdgpu_pmu_create_event_attrs_by_type(attr_group, pmu_attr, events, 0,
+			num_events, AMDGPU_PMU_EVENT_CONFIG_TYPE_NONE);
+}
 
-	pmu_entry = kzalloc(sizeof(struct amdgpu_pmu_entry), GFP_KERNEL);
 
-	if (!pmu_entry)
+static int amdgpu_pmu_alloc_pmu_attrs(
+				struct attribute_group *fmt_attr_group,
+				struct amdgpu_pmu_event_attribute **fmt_attr,
+				int fmt_num_attrs,
+				struct attribute_group *evt_attr_group,
+				struct amdgpu_pmu_event_attribute **evt_attr,
+				int evt_num_attrs)
+{
+	*fmt_attr = kcalloc(fmt_num_attrs, sizeof(**fmt_attr), GFP_KERNEL);
+
+	if (!(*fmt_attr))
 		return -ENOMEM;
 
-	pmu_entry->adev = adev;
+	fmt_attr_group->attrs = kcalloc(fmt_num_attrs + 1,
+				sizeof(*fmt_attr_group->attrs), GFP_KERNEL);
+
+	if (!fmt_attr_group->attrs)
+		goto err_fmt_attr_grp;
+
+	*evt_attr = kcalloc(evt_num_attrs, sizeof(**evt_attr), GFP_KERNEL);
+
+	if (!(*evt_attr))
+		goto err_evt_attr;
+
+	evt_attr_group->attrs = kcalloc(evt_num_attrs + 1,
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
+static int init_pmu_by_type(struct amdgpu_pmu_entry *pmu_entry,
+			char *pmu_type_name, char *pmu_file_prefix,
+			unsigned int pmu_perf_type,
+			const char *formats[][2], int num_formats,
+			const char *events[][2], int num_events,
+			const int event_config_types[256][2],
+			int num_config_types)
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
@@ -237,59 +404,158 @@ static int init_pmu_by_type(struct amdgpu_device *adev,
 		.task_ctx_nr = perf_invalid_context,
 	};
 
-	pmu_entry->pmu.attr_groups = attr_groups;
+	ret = amdgpu_pmu_alloc_pmu_attrs(&pmu_entry->fmt_attr_group,
+					&pmu_entry->fmt_attr,
+					num_formats,
+					&pmu_entry->evt_attr_group,
+					&pmu_entry->evt_attr,
+					num_events);
+
+	if (ret)
+		goto err_out;
+
+	amdgpu_pmu_create_attrs(&pmu_entry->fmt_attr_group, pmu_entry->fmt_attr,
+							formats, num_formats);
+
+	if (pmu_perf_type == AMDGPU_PMU_PERF_TYPE_ALL) {
+		int i;
+
+		for (i = 0; i < num_config_types; i++) {
+			amdgpu_pmu_create_event_attrs_by_type(
+						&pmu_entry->evt_attr_group,
+						pmu_entry->evt_attr,
+						events,
+						total_num_events,
+						event_config_types[i][1],
+						event_config_types[i][0]);
+			total_num_events += event_config_types[i][1];
+		}
+	} else {
+		amdgpu_pmu_create_attrs(&pmu_entry->evt_attr_group,
+					pmu_entry->evt_attr,
+					events, num_events);
+		total_num_events = num_events;
+	}
+
+	pmu_entry->pmu.attr_groups = kmemdup(attr_groups, sizeof(attr_groups),
+								GFP_KERNEL);
+
+	if (!pmu_entry->pmu.attr_groups)
+		goto err_attr_group;
+
 	pmu_entry->pmu_perf_type = pmu_perf_type;
-	snprintf(pmu_name, PMU_NAME_SIZE, "%s_%d",
-				pmu_file_prefix, adev_to_drm(adev)->primary->index);
+	snprintf(pmu_name, PMU_NAME_SIZE, "%s_%d", pmu_file_prefix,
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
+	if (pmu_perf_type != AMDGPU_PMU_PERF_TYPE_ALL)
+		pr_info("Detected AMDGPU %s Counters. # of Counters = %d.\n",
+					pmu_type_name, total_num_events);
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
+	pr_warn("Error initializing AMDGPU %s PMUs.\n", pmu_type_name);
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
+		pmu_entry_df = kzalloc(sizeof(struct amdgpu_pmu_entry),
+								GFP_KERNEL);
+
+		if (!pmu_entry_df)
+			return -ENOMEM;
+
+		pmu_entry_df->adev = adev;
+		pmu_entry_df->fmt_attr_group.name = "format";
+		pmu_entry_df->fmt_attr_group.attrs = NULL;
+		pmu_entry_df->evt_attr_group.name = "events";
+		pmu_entry_df->evt_attr_group.attrs = NULL;
+		ret = init_pmu_by_type(pmu_entry_df, "DF", "amdgpu_df",
+						AMDGPU_PMU_PERF_TYPE_DF,
+						df_vega20_formats,
+						NUM_FORMATS_DF_VEGA20,
+						df_vega20_events,
+						NUM_EVENTS_DF_VEGA20,
+						NULL, 0);
+
+		if (ret) {
+			kfree(pmu_entry_df);
+			return ret;
+		}
 
-		/* other pmu types go here*/
-		break;
-	default:
-		return 0;
-	}
+		pmu_entry = kzalloc(sizeof(struct amdgpu_pmu_entry),
+								GFP_KERNEL);
 
-	return 0;
-}
+		if (!pmu_entry) {
+			amdgpu_pmu_fini(adev);
+			return -ENOMEM;
+		}
 
+		pmu_entry->adev = adev;
+		pmu_entry->fmt_attr_group.name = "format";
+		pmu_entry->fmt_attr_group.attrs = NULL;
+		pmu_entry->evt_attr_group.name = "events";
+		pmu_entry->evt_attr_group.attrs = NULL;
+		ret = init_pmu_by_type(pmu_entry, "", "amdgpu",
+						AMDGPU_PMU_PERF_TYPE_ALL,
+						amdgpu_pmu_formats,
+						NUM_FORMATS_AMDGPU_PMU,
+						vega20_events,
+						NUM_EVENTS_VEGA20_MAX,
+						vega20_event_config_types,
+						NUM_EVENT_TYPES_VEGA20);
+
+		if (ret) {
+			kfree(pmu_entry);
+			amdgpu_pmu_fini(adev);
+		}
 
-/* destroy all pmu data associated with target device */
-void amdgpu_pmu_fini(struct amdgpu_device *adev)
-{
-	struct amdgpu_pmu_entry *pe, *temp;
+		break;
+	default:
+		return 0;
+	};
 
-	list_for_each_entry_safe(pe, temp, &amdgpu_pmu_list, entry) {
-		if (pe->adev == adev) {
-			list_del(&pe->entry);
-			perf_pmu_unregister(&pe->pmu);
-			kfree(pe);
-		}
-	}
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
