Return-Path: <SRS0=J3+H=CZ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E238C433E2
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Sep 2020 02:08:30 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F248A2087D
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Sep 2020 02:08:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="ITCrpRNm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F248A2087D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4C9526E27A;
	Wed, 16 Sep 2020 02:08:29 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2044.outbound.protection.outlook.com [40.107.243.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 320E66E27A
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Sep 2020 02:08:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dg22l5kENGS38l3lA/gcYh3cFXRlYt2iss5NO6nPhfWFJdoh/dCshNOqXEYeV7K5shpii1tMzzP98rCWtw6hWqTy/JqpWM2jWBFLVZVY7sS2F/4eBn5why+6bKGpP3a8ehMjNEPwS2/QMhChMo46D4Lvjk8GfpMHwWmx9PV+aEy4TTOZC5wlJPjEEvtrZDMdtLGWehrf7tVFFUSzGtBytVH7J6fw7sudHEw9BipLwzy9G7Sx7tntPkNwVu5MSpiEp6L1TJDFf5tZ7gJEIK9mJVUZzH6sZmPMj2Pol4A7QlLcfxT4E/bM/mo/VqWCD5xB2tFZOkIK0ZkZvK6kH763Og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o7e1cvwjabhg+6g3KclxMEgVRW3a+qMo/u1clwDqPiY=;
 b=mq5NeV7y/zVgslkxDnkhSegPEyjBwXq0lzLRN6Pmf8HwnGAy4dD9eXZhwNYftqM2prcFz0+VHFSGIeAkxol2LJZifxXs1iGCGkVhZvaElxrHKD/JKhY1pjwzwdsWHkP05TJxyTN9H0JUZdS5uhjP4pcVENkWiH6gCZ161qFjdby7mcTMrijDDC17Vt+yLR7jUv5oNxJIS0DCSeASuKzRXCHVxbv91BcTLm2ON3OaeG7U6DrsLu7HPW9Nk4cJd2ZAd/2YY1ttfrA2Gv2Tv17uuAIAc+Cq2nZ/NTBDV91+nKjvo7tlf/HgyQ+/ylleJpwa1pSau8+asdGygQ3O8ziZGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o7e1cvwjabhg+6g3KclxMEgVRW3a+qMo/u1clwDqPiY=;
 b=ITCrpRNmS6ghmnzDiLqW0QgjiLuUzgTbeWkoKUum9L/FdVXddcB3CHKW9LvigkiRooySg50FlFYuAhaFduKTNtAsTTkcH2nZwsI1V15c9wR7feBXGeFF8dNCf/J/Ab7OVgNA/O+ujkxkAdnckhcG4L7Klr/peVlhr2JQ112qbdU=
Received: from DM6PR12MB2761.namprd12.prod.outlook.com (2603:10b6:5:41::27) by
 DM6PR12MB3898.namprd12.prod.outlook.com (2603:10b6:5:1c6::18) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3370.16; Wed, 16 Sep 2020 02:08:25 +0000
Received: from DM6PR12MB2761.namprd12.prod.outlook.com
 ([fe80::479:1e93:7ee2:839]) by DM6PR12MB2761.namprd12.prod.outlook.com
 ([fe80::479:1e93:7ee2:839%3]) with mapi id 15.20.3370.018; Wed, 16 Sep 2020
 02:08:25 +0000
From: "Kasiviswanathan, Harish" <Harish.Kasiviswanathan@amd.com>
To: "Kim, Jonathan" <Jonathan.Kim@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 2/3] drm/amdgpu: add per device user friendly xgmi events
 for vega20
Thread-Topic: [PATCH 2/3] drm/amdgpu: add per device user friendly xgmi events
 for vega20
Thread-Index: AQHWi6ujf3/xQ+BiikW4J3RxONa4r6lqeAgg
Date: Wed, 16 Sep 2020 02:08:25 +0000
Message-ID: <DM6PR12MB2761BC65AFA0B2396F94137A8C210@DM6PR12MB2761.namprd12.prod.outlook.com>
References: <20200915220015.2646-1-jonathan.kim@amd.com>
 <20200915220015.2646-2-jonathan.kim@amd.com>
In-Reply-To: <20200915220015.2646-2-jonathan.kim@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-09-16T02:08:19Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=8217f3b4-1be3-4489-bce5-981c9fa0ea63;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_justification: I confirm the recipients are approved for sharing this
 content
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [2607:fea8:3f40:293:987e:1074:7be8:407a]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 5ed8c858-9c85-4e73-a6fe-08d859e5658f
x-ms-traffictypediagnostic: DM6PR12MB3898:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB3898C99AB9EF14817EFD8A058C210@DM6PR12MB3898.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:374;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: V7NQuordSh+//y4ca3c2Yv8EY5fznsk1F3xgIhFbHzDXHlFNjC0b/5FUWpujnDd1Z6DfqJGRTawZgtSJ2xAq5p1DmdzI0Or7gJ/U5vBEz0s4wU/+IeMvn2DuIpABROh/L16ERGUV5gUO+LDs7sTmwVQAYMre/4SZaRWb38R6gB4bX3WYcVBz9LqMuQSsTh7G4+W/6FQ5OD9+HRCYWkKL22S8D1+dRCUvgHFMtt76Aw91TnHKcjqwQ6sCqBwjUgFvxeZlEs/BzGVeBQiHLrln/J9pipCe3KZ7qxAMCxBYgML2aa7ZtXUm/6sCSMfdTnTr
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2761.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(396003)(376002)(39860400002)(366004)(346002)(2906002)(66446008)(66556008)(64756008)(316002)(86362001)(66476007)(66946007)(71200400001)(76116006)(186003)(7696005)(83380400001)(6506007)(53546011)(8936002)(478600001)(30864003)(110136005)(52536014)(33656002)(55016002)(9686003)(8676002)(5660300002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: I+ZSr4XWZanPKPG8sBqpxau11nfMP85Rg7J7KjwIt+R4ANgIW9aPUlT84XhA1siJtJSakcp3ZkBxQatiZmOteEnF8EcKdFOAcMz8LGhELmhM2TOM1npYolblYHBoQHO2bLJ1dpcOWpzVDvuBH7+rkqcEkTbd/pDkT5fENQhfA3WwMHD4g3LQkPngBcEy5CTMKOh8K4V/DVX4IAiteQoz8dOotqNBeiwdnKbgUYhjEqVZrvv6knsYyXLE+DT/h4Mf7mV56e24hx9JqVXeZWeoLZqgWQGaWT7nBdLvwDbEhtAKC249mtrXV7DpoFrAfb+wW2SIXnudyFVbG6aqqjOaAYsaTONGy84Jn73eORXuN/9ttYDf4x0Yisq0DaHsHwBdrm6OU0Y9N0Wh5V552Pat0ucQJ/W4/lLYT4kbEoM6n5ywDc9htI3qpzH7naNG2eJOMasc26dy0RC80nsanHsVzUk7jYqqrnWD9vFNDUG1gc9ekX3zpeJKEaBFtx8ggjj+sVSMpW95t54tBHv82O4G2LYZfz7wLMZ6kYo6jKh7J4m3EnhSsM9F0jpVauVJMF6BxhGOLpnsGn8boHTL5cMmY0/StS3T2YDr9SkNZOHSbMgbXE4mFr6SCHUtlCIYNtLhP7Q1FpPvKLKIhQxlHfRpt+EkhPzEcCrOh55yd/6gsBwAgmYit0sA2vFci6t9bHmyIwEFP6Og60SikocZYcsbuQ==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2761.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ed8c858-9c85-4e73-a6fe-08d859e5658f
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Sep 2020 02:08:25.7532 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oZJCjekip2VXymWLTiXrwerckRqXGG3wBlZ5vtHIMsfsj303ozJhA98FkOt9t8Pt3usMHZI3C6hcSRAQrf+VRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3898
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

Some comments and a question

-----Original Message-----
From: Kim, Jonathan <Jonathan.Kim@amd.com> 
Sent: Tuesday, September 15, 2020 6:00 PM
To: amd-gfx@lists.freedesktop.org
Cc: Kasiviswanathan, Harish <Harish.Kasiviswanathan@amd.com>; Kim, Jonathan <Jonathan.Kim@amd.com>; Kim, Jonathan <Jonathan.Kim@amd.com>
Subject: [PATCH 2/3] drm/amdgpu: add per device user friendly xgmi events for vega20

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

where do all these allocations get freed?

+	*fmt_attr = kcalloc(fmt_num_attrs, sizeof(**fmt_attr), GFP_KERNEL);
+
+	if (!fmt_attr)


I think you want to check *fmt_attr

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

I think you want to check *evt_attr

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
