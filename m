Return-Path: <SRS0=7kRa=CY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D44E6C43461
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Sep 2020 22:00:37 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 70E412064B
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Sep 2020 22:00:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="vBqPyA9e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70E412064B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2C5626E226;
	Tue, 15 Sep 2020 22:00:37 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2060.outbound.protection.outlook.com [40.107.223.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 337156E226
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Sep 2020 22:00:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oYcvqESD/WUNuGNXuzgX9njd4Eks2SDnhhLTtFU65OgIliI8D9OGvrMuEMMhCqix1u3jSqYJq/met7Q478NHpSjw+A+lJFhxMnGHFoAcUYsgu/kESYvNzt9SFEB9+7aFd4p5Fd9oUk8ZnOvZi4bKs+5KL05w8fQI8YtPuTMedAGqXTBfbFoRhNd5PieIXuebH48jqew9f/icwF6+t4VqnP4pSzCf5Zjn5HXf+wkuT0EPQB3RHzXpnc38hLYWePjGpfBACQEh8yX0t98S5HHpgMsElJrOUQE3cIo+toTkycCOXcPNDRl9E5tnQYqkEPcRD/VfjRNvYL0bdq8cvLRoJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nWIUaiH2DEgd1oibNmUF3NtcgaseYmGpiaa+68Nwx74=;
 b=IjgQ5030uTqsBCJl+O8xRFIVzn5Q7ydZyu+U8nJa4mbCopKz6xkQLmtecZvo69gnGrmKy4XMGSTpjHYrw+fLoz0ejvfh1Fsi3wqd59L8Rr/btxbTrVWW/rO+kuzzCA87uTHPifK1N+QL4bfxGscog8XT0hVuqcWyoKlsjIkvE4y1SVmJ92vqvHJXOUklpWLSpV84LkkRIN+xBdJxOvv32NgBrzoHtjq9kaf4zjMpbSquqtrSOqdq9b0EjQ77Bx9xMkmNApWUIf1rmH5s3JKEKkwQ5zyjNOnJnugYe282PfOQb5euys+ZlvxLUR4Epj93PjCBlepSCXT2aIDygrqC6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nWIUaiH2DEgd1oibNmUF3NtcgaseYmGpiaa+68Nwx74=;
 b=vBqPyA9e9su9URJ7vVmPSehl6RiIYTKwO+VqbmSw+tJ9i2DTpm1w51rIfyHYpPIYpykLFcke63vI7zAiIWr6xB5c2NWrS9G8ITpJpqLvS0+tS0EpXEgOxLYfoEfnhPShz9WnsuSV18F2XG8l/QKX8NxXYXbaihVB/xjVirJq+4E=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BN6PR1201MB0146.namprd12.prod.outlook.com
 (2603:10b6:405:59::18) by BN6PR12MB1188.namprd12.prod.outlook.com
 (2603:10b6:404:19::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.17; Tue, 15 Sep
 2020 22:00:34 +0000
Received: from BN6PR1201MB0146.namprd12.prod.outlook.com
 ([fe80::615d:bea9:8838:92be]) by BN6PR1201MB0146.namprd12.prod.outlook.com
 ([fe80::615d:bea9:8838:92be%4]) with mapi id 15.20.3370.019; Tue, 15 Sep 2020
 22:00:34 +0000
From: Jonathan Kim <jonathan.kim@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/3] drm/amdgpu: add per device user friendly xgmi events for
 vega20
Date: Tue, 15 Sep 2020 18:00:14 -0400
Message-Id: <20200915220015.2646-2-jonathan.kim@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200915220015.2646-1-jonathan.kim@amd.com>
References: <20200915220015.2646-1-jonathan.kim@amd.com>
X-ClientProxiedBy: CH2PR12CA0003.namprd12.prod.outlook.com
 (2603:10b6:610:57::13) To BN6PR1201MB0146.namprd12.prod.outlook.com
 (2603:10b6:405:59::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from jonathan-KFD.amd.com (165.204.55.251) by
 CH2PR12CA0003.namprd12.prod.outlook.com (2603:10b6:610:57::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3391.13 via Frontend Transport; Tue, 15 Sep 2020 22:00:33 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: cf7b4e24-1201-4275-bde9-08d859c2c55d
X-MS-TrafficTypeDiagnostic: BN6PR12MB1188:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN6PR12MB1188A8AF012D679A13C825C685200@BN6PR12MB1188.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:546;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yFluAsZbSL1Zt51OXfcA8SJ3FJ5iIiCQlmf3o7oDtmtAXlQgBzIsuTr/SZMdHkWkXKNTGHZyvlwZNvEpJfyXSLyLb9hBVFBR1chAXbgqw3ZgDPtIEk9vZEVWt2/1CAAWr+hNMRgAU9K0bW62wiMSMOob+2Q9IYYYCqlmoFvhrj7JMrxCOL1YrB+S2dKsLziyNyUCpBPdTAnJGTENyG57RBCaSi8OSvvDQafca6lpslaLk6j3/V7n85eVNwHzBFOOxanH6iV1+7jq8oGfX8NuLSxKWvtv0g90tB1pItPrfRckleW5PiHUU5EHtzaEjdp8
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN6PR1201MB0146.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(366004)(396003)(136003)(376002)(346002)(54906003)(7696005)(316002)(66946007)(8936002)(66476007)(66556008)(478600001)(6666004)(86362001)(5660300002)(30864003)(36756003)(2906002)(83380400001)(8676002)(1076003)(956004)(4326008)(6486002)(2616005)(44832011)(52116002)(16526019)(186003)(26005)(6916009);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: 9FJGV+tASP10M6cmV35WWoRjh9RrEfHs8AHhOUkYuXb4yO1ztNawgClTF7Bw9GCyUIDtksQ5FqzybYJOvipC0SW9u2sj5evoz06h4OmX8LJELGY9lH2C3gG+xk84Un3FBOL6HpgxnEtiIsb80SyFg50ZslwJ0BYGPSjGm9MtwBvPzUerH6vW9s6b5TKxefaePOaqKc4bcqF8oqR+l60ddRqLCx/E2LNokcymfzthfNYp77ZzqY9ltJOYa/w4GsrkVaMKm2uBqg55SahndB1G9nUC5xJrluOP1qcz027wtmlNgDcrHcmuGTVFT6hN03fq+LLUF9Jm/BI/yiCVEK/CaDh2PuACgeuNlzATc8mDdgnSV1pR89JouTkUHWekzJkMvIKNEuBkpzXMM9fVy5pwA/A6SbNJ3Jn+MaG/wiX4xARIN4aCrxtdqEXj20a9agFxVq+eSi+z4W0j/wkQHcXKA54rMtLOR/bbw99pIyZzgWEi35iejpYSsNGQBMc6o6y8zHFpGzjoXqs/8pcjupyxtjLnPQQA8Yk5GIomhSS3VyxPil9B3bapKbB5uQYDXYr4ZLxz8BeVHlAWZbxFqiTAyk9f/D3cqsVSJsgxvBotM1sA3iVGQogaXY6SgPPeS5waTQSxVQKmTKGTwbJ9T7hpRQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf7b4e24-1201-4275-bde9-08d859c2c55d
X-MS-Exchange-CrossTenant-AuthSource: BN6PR1201MB0146.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2020 22:00:34.5496 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rLHvrBodQifRmzBq1sA1ds97uRWWCDeCmR+duO5ee/hvzjs3m5yrIOjf6AZ2b7bx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1188
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

v2: add comments on sysfs structure and formatting.

Signed-off-by: Jonathan Kim <Jonathan.Kim@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h     |  13 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c | 342 +++++++++++++++++++++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.h |   6 +-
 drivers/gpu/drm/amd/amdgpu/df_v3_6.c    |  72 +----
 drivers/gpu/drm/amd/amdgpu/df_v3_6.h    |   9 -
 5 files changed, 314 insertions(+), 128 deletions(-)

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
index 1b0ec715c8ba..f3d2ac0e88a7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c
@@ -27,9 +27,13 @@
 #include <linux/init.h>
 #include "amdgpu.h"
 #include "amdgpu_pmu.h"
-#include "df_v3_6.h"
 
 #define PMU_NAME_SIZE 32
+#define NUM_FORMATS_AMDGPU_PMU		4
+#define NUM_FORMATS_DF_LEGACY		3
+#define NUM_EVENTS_DF_LEGACY		8
+#define NUM_EVENTS_VEGA20_XGMI		2
+#define NUM_EVENTS_VEGA20_MAX		2
 
 /* record to keep track of pmu entry per pmu type per device */
 struct amdgpu_pmu_entry {
@@ -39,8 +43,106 @@ struct amdgpu_pmu_entry {
 	unsigned int pmu_perf_type;
 };
 
+struct amdgpu_pmu_event_attribute {
+	struct device_attribute attr;
+	const char *event_str;
+	unsigned int type;
+};
+
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
+static struct attribute_group amdgpu_pmu_format_attr_group = {
+	.name = "format",
+	.attrs = NULL,
+};
+
+/*
+ * Event formatting is global to all amdgpu events under sysfs folder
+ * /sys/bus/event_source/devices/amdgpu_<dev_num> where dev_num is the
+ * primary device index. Registered events can be found in subfolder "events"
+ * and formatting under subfolder "format".
+ *
+ * Formats "event", "instance", and "umask" are currently used by xGMI but can
+ * be for generalized for other IP usage.  If format naming is insufficient
+ * for newly registered IP events, append to the list below and handle the
+ * perf events hardware configuration (see hwc->config) as required by the IP.
+ *
+ * Format "type" indicates IP type generated on pmu registration (see
+ * init_pmu_by_type) so non-legacy events omit this in the per-chip event
+ * list (e.g. vega20_events).
+ */
+static const char *amdgpu_pmu_formats[NUM_FORMATS_AMDGPU_PMU][2] = {
+	{ "event", "config:0-7" },
+	{ "instance", "config:8-15" },
+	{ "umask", "config:16-23"},
+	{ "type", "config:56-63"}
+};
+
 static LIST_HEAD(amdgpu_pmu_list);
 
+/* Vega20 events */
+static const char *vega20_events[NUM_EVENTS_VEGA20_MAX][2] = {
+	{ "xgmi_link0_data_outbound", "event=0x7,instance=0x46,umask=0x2" },
+	{ "xgmi_link1_data_outbound", "event=0x7,instance=0x47,umask=0x2" }
+};
+
+static struct attribute_group vega20_event_attr_group = {
+	.name = "events",
+	.attrs = NULL
+};
+
+const struct attribute_group *vega20_attr_groups[] = {
+	&amdgpu_pmu_format_attr_group,
+	&vega20_event_attr_group,
+	NULL
+};
+
+/* All df_vega20_* items are DEPRECATED. Use vega20_ items above instead. */
+static const char *df_vega20_formats[NUM_FORMATS_DF_LEGACY][2] = {
+	{ "event", "config:0-7" },
+	{ "instance", "config:8-15" },
+	{ "umask", "config:16-23"}
+};
+
+static const char *df_vega20_events[NUM_EVENTS_DF_LEGACY][2] = {
+	{ "cake0_pcsout_txdata", "event=0x7,instance=0x46,umask=0x2" },
+	{ "cake1_pcsout_txdata", "event=0x7,instance=0x47,umask=0x2" },
+	{ "cake0_pcsout_txmeta", "event=0x7,instance=0x46,umask=0x4" },
+	{ "cake1_pcsout_txmeta", "event=0x7,instance=0x47,umask=0x4" },
+	{ "cake0_ftiinstat_reqalloc", "event=0xb,instance=0x46,umask=0x4" },
+	{ "cake1_ftiinstat_reqalloc", "event=0xb,instance=0x47,umask=0x4" },
+	{ "cake0_ftiinstat_rspalloc", "event=0xb,instance=0x46,umask=0x8" },
+	{ "cake1_ftiinstat_rspalloc", "event=0xb,instance=0x47,umask=0x8" },
+};
+
+static struct attribute_group df_vega20_format_attr_group = {
+	.name = "format",
+	.attrs = NULL,
+};
+
+static struct attribute_group df_vega20_event_attr_group = {
+	.name = "events",
+	.attrs = NULL
+};
+
+const struct attribute_group *df_vega20_attr_groups[] = {
+	&df_vega20_format_attr_group,
+	&df_vega20_event_attr_group,
+	NULL
+};
 
 /* initialize perf counter */
 static int amdgpu_perf_event_init(struct perf_event *event)
@@ -73,7 +175,8 @@ static void amdgpu_perf_start(struct perf_event *event, int flags)
 	hwc->state = 0;
 
 	switch (pe->pmu_perf_type) {
-	case PERF_TYPE_AMDGPU_DF:
+	case PERF_TYPE_AMDGPU_DF_LEGACY:
+	case PERF_TYPE_AMDGPU_XGMI:
 		if (!(flags & PERF_EF_RELOAD)) {
 			target_cntr = pe->adev->df.funcs->pmc_start(pe->adev,
 						hwc->config, 0 /* unused */,
@@ -108,7 +211,8 @@ static void amdgpu_perf_read(struct perf_event *event)
 		prev = local64_read(&hwc->prev_count);
 
 		switch (pe->pmu_perf_type) {
-		case PERF_TYPE_AMDGPU_DF:
+		case PERF_TYPE_AMDGPU_DF_LEGACY:
+		case PERF_TYPE_AMDGPU_XGMI:
 			pe->adev->df.funcs->pmc_get_count(pe->adev,
 						hwc->config, hwc->idx, &count);
 			break;
@@ -133,7 +237,8 @@ static void amdgpu_perf_stop(struct perf_event *event, int flags)
 		return;
 
 	switch (pe->pmu_perf_type) {
-	case PERF_TYPE_AMDGPU_DF:
+	case PERF_TYPE_AMDGPU_DF_LEGACY:
+	case PERF_TYPE_AMDGPU_XGMI:
 		pe->adev->df.funcs->pmc_stop(pe->adev, hwc->config, hwc->idx,
 									0);
 		break;
@@ -160,10 +265,15 @@ static int amdgpu_perf_add(struct perf_event *event, int flags)
 						  struct amdgpu_pmu_entry,
 						  pmu);
 
+	if (pe->pmu_perf_type == PERF_TYPE_AMDGPU_MAX)
+		pe->pmu_perf_type = (hwc->config >> AMDGPU_PERF_TYPE_SHIFT) &
+							AMDGPU_PERF_TYPE_MASK;
+
 	event->hw.state = PERF_HES_UPTODATE | PERF_HES_STOPPED;
 
 	switch (pe->pmu_perf_type) {
-	case PERF_TYPE_AMDGPU_DF:
+	case PERF_TYPE_AMDGPU_DF_LEGACY:
+	case PERF_TYPE_AMDGPU_XGMI:
 		target_cntr = pe->adev->df.funcs->pmc_start(pe->adev,
 						hwc->config, 0 /* unused */,
 						1 /* add counter */);
@@ -197,7 +307,8 @@ static void amdgpu_perf_del(struct perf_event *event, int flags)
 	amdgpu_perf_stop(event, PERF_EF_UPDATE);
 
 	switch (pe->pmu_perf_type) {
-	case PERF_TYPE_AMDGPU_DF:
+	case PERF_TYPE_AMDGPU_DF_LEGACY:
+	case PERF_TYPE_AMDGPU_XGMI:
 		pe->adev->df.funcs->pmc_stop(pe->adev, hwc->config, hwc->idx,
 									1);
 		break;
@@ -208,18 +319,42 @@ static void amdgpu_perf_del(struct perf_event *event, int flags)
 	perf_event_update_userpage(event);
 }
 
-/* vega20 pmus */
+static void amdgpu_pmu_create_attributes(struct attribute_group *attr_group,
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
 
 /* init pmu tracking per pmu type */
 static int init_pmu_by_type(struct amdgpu_device *adev,
-		  const struct attribute_group *attr_groups[],
-		  char *pmu_type_name, char *pmu_file_prefix,
-		  unsigned int pmu_perf_type,
-		  unsigned int num_counters)
+			struct attribute_group *fmt_attr_group,
+			struct amdgpu_pmu_event_attribute *fmt_attr,
+			struct attribute_group *evt_attr_group,
+			struct amdgpu_pmu_event_attribute *evt_attr,
+			char *pmu_type_name, char *pmu_file_prefix,
+			unsigned int pmu_perf_type)
 {
 	char pmu_name[PMU_NAME_SIZE];
 	struct amdgpu_pmu_entry *pmu_entry;
-	int ret = 0;
+	bool is_legacy = pmu_perf_type == PERF_TYPE_AMDGPU_DF_LEGACY;
+	int ret = 0, num_events = 0;
 
 	pmu_entry = kzalloc(sizeof(struct amdgpu_pmu_entry), GFP_KERNEL);
 
@@ -237,59 +372,182 @@ static int init_pmu_by_type(struct amdgpu_device *adev,
 		.task_ctx_nr = perf_invalid_context,
 	};
 
-	pmu_entry->pmu.attr_groups = attr_groups;
+	amdgpu_pmu_create_attributes(fmt_attr_group, fmt_attr,
+			is_legacy ? df_vega20_formats : amdgpu_pmu_formats, 0,
+			is_legacy ? NUM_FORMATS_DF_LEGACY :
+							NUM_FORMATS_AMDGPU_PMU,
+			0);
+
+	if (is_legacy) {
+		amdgpu_pmu_create_attributes(evt_attr_group, evt_attr,
+					df_vega20_events, 0,
+					NUM_EVENTS_DF_LEGACY,
+					PERF_TYPE_AMDGPU_DF_LEGACY);
+		num_events += NUM_EVENTS_DF_LEGACY;
+
+		pmu_entry->pmu.attr_groups = df_vega20_attr_groups;
+		goto legacy_register;
+	}
+
+	switch (adev->asic_type) {
+	case CHIP_VEGA20:
+		amdgpu_pmu_create_attributes(evt_attr_group, evt_attr,
+				vega20_events, 0, NUM_EVENTS_VEGA20_XGMI,
+				PERF_TYPE_AMDGPU_XGMI);
+		num_events += NUM_EVENTS_VEGA20_XGMI;
+
+		/* other events can be added here */
+
+		pmu_entry->pmu.attr_groups = vega20_attr_groups;
+		break;
+	default:
+		return -ENODEV;
+	};
+
+legacy_register:
 	pmu_entry->pmu_perf_type = pmu_perf_type;
-	snprintf(pmu_name, PMU_NAME_SIZE, "%s_%d",
-				pmu_file_prefix, adev_to_drm(adev)->primary->index);
+	snprintf(pmu_name, PMU_NAME_SIZE, "%s_%d", pmu_file_prefix,
+					adev_to_drm(adev)->primary->index);
 
 	ret = perf_pmu_register(&pmu_entry->pmu, pmu_name, -1);
 
-	if (ret) {
-		kfree(pmu_entry);
-		pr_warn("Error initializing AMDGPU %s PMUs.\n", pmu_type_name);
-		return ret;
-	}
+	if (ret)
+		goto err;
 
 	pr_info("Detected AMDGPU %s Counters. # of Counters = %d.\n",
-			pmu_type_name, num_counters);
+			pmu_type_name, num_events);
 
 	list_add_tail(&pmu_entry->entry, &amdgpu_pmu_list);
 
 	return 0;
+err:
+	kfree(pmu_entry);
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
+		if (pe->adev == adev) {
+			list_del(&pe->entry);
+			perf_pmu_unregister(&pe->pmu);
+			kfree(pe);
+		}
+	}
+}
+
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
+	if (!fmt_attr)
+		return -ENOMEM;
+
+	fmt_attr_group->attrs = kcalloc(fmt_num_attrs + 1,
+				sizeof(*fmt_attr_group->attrs), GFP_KERNEL);
+
+	if (!fmt_attr_group->attrs)
+		goto err_fmt_attr_grp;
+
+	*evt_attr = kcalloc(evt_num_attrs, sizeof(**evt_attr), GFP_KERNEL);
+
+	if (!evt_attr)
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
 }
 
 /* init amdgpu_pmu */
 int amdgpu_pmu_init(struct amdgpu_device *adev)
 {
+	struct amdgpu_pmu_event_attribute *fmt_attr = NULL, *evt_attr = NULL,
+				*old_fmt_attr = NULL, *old_evt_attr = NULL;
 	int ret = 0;
 
+	if (adev->asic_type != CHIP_VEGA20)
+		goto init_events;
+
+	ret = amdgpu_pmu_alloc_pmu_attrs(&df_vega20_format_attr_group,
+					&old_fmt_attr,
+					NUM_FORMATS_DF_LEGACY,
+					&df_vega20_event_attr_group,
+					&old_evt_attr,
+					NUM_EVENTS_DF_LEGACY);
+
+	if (ret)
+		return ret;
+
+	ret = init_pmu_by_type(adev,
+				&df_vega20_format_attr_group, old_fmt_attr,
+				&df_vega20_event_attr_group, old_evt_attr,
+				"DF", "amdgpu_df", PERF_TYPE_AMDGPU_DF_LEGACY);
+	if (ret)
+		goto err_old_pmu;
+
+init_events:
 	switch (adev->asic_type) {
 	case CHIP_VEGA20:
-		/* init df */
-		ret = init_pmu_by_type(adev, df_v3_6_attr_groups,
-				       "DF", "amdgpu_df", PERF_TYPE_AMDGPU_DF,
-				       DF_V3_6_MAX_COUNTERS);
+		ret = amdgpu_pmu_alloc_pmu_attrs(&amdgpu_pmu_format_attr_group,
+						&fmt_attr,
+						NUM_FORMATS_AMDGPU_PMU,
+						&vega20_event_attr_group,
+						&evt_attr,
+						NUM_EVENTS_VEGA20_MAX);
+
+		if (ret)
+			goto err_alloc;
+
+		ret = init_pmu_by_type(adev,
+				&amdgpu_pmu_format_attr_group, fmt_attr,
+				&vega20_event_attr_group, evt_attr,
+				"Event", "amdgpu", PERF_TYPE_AMDGPU_MAX);
+
+		if (ret) {
+			kfree(vega20_event_attr_group.attrs);
+			goto err_pmu;
+		}
 
-		/* other pmu types go here*/
 		break;
 	default:
 		return 0;
-	}
+	};
 
 	return 0;
-}
-
-
-/* destroy all pmu data associated with target device */
-void amdgpu_pmu_fini(struct amdgpu_device *adev)
-{
-	struct amdgpu_pmu_entry *pe, *temp;
-
-	list_for_each_entry_safe(pe, temp, &amdgpu_pmu_list, entry) {
-		if (pe->adev == adev) {
-			list_del(&pe->entry);
-			perf_pmu_unregister(&pe->pmu);
-			kfree(pe);
-		}
-	}
+err_pmu:
+	kfree(fmt_attr);
+	kfree(evt_attr);
+	kfree(amdgpu_pmu_format_attr_group.attrs);
+err_alloc:
+	if (adev->asic_type == CHIP_VEGA20)
+		amdgpu_pmu_fini(adev);
+	return ret;
+err_old_pmu:
+	kfree(old_fmt_attr);
+	kfree(old_evt_attr);
+	kfree(df_vega20_format_attr_group.attrs);
+	kfree(df_vega20_event_attr_group.attrs);
+	return ret;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.h
index 7dddb7160a11..0d214abe720e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.h
@@ -27,10 +27,14 @@
 #define _AMDGPU_PMU_H_
 
 enum amdgpu_pmu_perf_type {
-	PERF_TYPE_AMDGPU_DF = 0,
+	PERF_TYPE_AMDGPU_DF_LEGACY = 0,
+	PERF_TYPE_AMDGPU_XGMI,
 	PERF_TYPE_AMDGPU_MAX
 };
 
+#define AMDGPU_PERF_TYPE_SHIFT	56
+#define AMDGPU_PERF_TYPE_MASK	0xff
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
