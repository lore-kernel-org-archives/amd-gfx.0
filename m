Return-Path: <SRS0=P3OX=CR=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90851C2BBD0
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Sep 2020 13:06:58 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4DF8D22D04
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Sep 2020 13:06:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="WJQDnBSb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DF8D22D04
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0CBC66E824;
	Tue,  8 Sep 2020 13:06:58 +0000 (UTC)
Received: from NAM04-BN3-obe.outbound.protection.outlook.com
 (mail-eopbgr680088.outbound.protection.outlook.com [40.107.68.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 686D26E1F4
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Sep 2020 13:06:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AG0jFDkOxypk78FQSVHOL+AYk+sCipusuchV5Vq85xriQm+EL9B4Jnrido3HPjXP6J6e1N+hNyX8xd9j0CeS/TZLIQm3VW422v21MfV5OAJe3WJRH10r2I0vt27B5jifp+HM1PHJJpQEXA0UpV5S1HYhWQcpVaBujgzlVLqXTifS18E7kiBM2WuObujxgBMNI9Cxn/utlioY8O6b3bU3WKgPLnfLvXJON9l3zzRvtvUkQrrrqW6vxLFuudCwVcLiXNEY+tpTE+VRxGnjJS98VGWAV7AcdpxdJnghhVbi9XqDYIJ6G/bDvFLGCCSNw6LRDHY/vKMCtnXvlmMyHvRj4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3FhAnXBygExmIVLCYtUL2a5sC1F0Xy8+zAyucQFdAc4=;
 b=e1IVWAEpmGD4PYmhDzi/HEz1dCQg3JnUjOlSjBI33HME1oGoLfnQ1tdTI1LO30YYViKeBWV5cXg6tLWM9UqRLn3utz1KV6xuJerwZCxgen+2T4ediBX/eFY6f+fxTqunPW+DYrp70U6mpX/u1QDYcJkeqlxg+eWNKJ1PjtOTDbDv+M0FeCNDrGGjNYnOYlb0et4rpcAJmywRy7j9m2JD/nInOwWDDBQKUp7S2i6rvyJps/VcyN43uqBRSs3DaJMwkmJgilDCgZ/o+1UyyjI+lEUftG3BBf8RKbV8AYEP7UzIX4NmBZPUBXWWLyNgVEQU7RCjzxnlGZyxZmGEdM1U0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3FhAnXBygExmIVLCYtUL2a5sC1F0Xy8+zAyucQFdAc4=;
 b=WJQDnBSbFSS5M/UeiclBq8u0Oz7zdMxlgktrn+WUuxIzDAClZ9azA4Uw8fZcM5G77lplw1TNGoKN6vS8mPW3NlbBvCwdbW99dVicf5izYgQlLGwr2+DyM5bcetqZknB/dDdwfa070d2eoRTXmll3tT7kbHWfmRtVn3vXEt8Yc48=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BN6PR1201MB0146.namprd12.prod.outlook.com
 (2603:10b6:405:59::18) by BN8PR12MB3604.namprd12.prod.outlook.com
 (2603:10b6:408:45::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.15; Tue, 8 Sep
 2020 13:06:50 +0000
Received: from BN6PR1201MB0146.namprd12.prod.outlook.com
 ([fe80::615d:bea9:8838:92be]) by BN6PR1201MB0146.namprd12.prod.outlook.com
 ([fe80::615d:bea9:8838:92be%4]) with mapi id 15.20.3348.019; Tue, 8 Sep 2020
 13:06:50 +0000
From: Jonathan Kim <jonathan.kim@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 3/4] drm/amdgpu: add per device user friendly xgmi events for
 vega20
Date: Tue,  8 Sep 2020 09:06:02 -0400
Message-Id: <20200908130603.10344-3-jonathan.kim@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200908130603.10344-1-jonathan.kim@amd.com>
References: <20200908130603.10344-1-jonathan.kim@amd.com>
X-ClientProxiedBy: YTXPR0101CA0061.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:1::38) To BN6PR1201MB0146.namprd12.prod.outlook.com
 (2603:10b6:405:59::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from jonathan-KFD.amd.com (165.204.55.251) by
 YTXPR0101CA0061.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:1::38) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.16 via Frontend
 Transport; Tue, 8 Sep 2020 13:06:50 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: b4e884cc-baf9-4b0d-d857-08d853f80cd4
X-MS-TrafficTypeDiagnostic: BN8PR12MB3604:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN8PR12MB36041D4EA8198693F3502C2285290@BN8PR12MB3604.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:175;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: L6w3rzmmNmFCj09ABsjwlp00Ae8nA9oy+JVPw1/LoLDqg7QKQOKykgxIoFDkZUsBHe/PwWbd/nHVPkPOIbV7M7KNezrVf+QGcYbSqCCjFd/m2r4lnf8c35+SeN24nr3FlZa56f+PpHodAmgnaVDLX93kjtuDytZ6q7fSclqWK/RvOsqRGkQuPd/2F6R+SASYT+LXcVjxG2lQ+8ioXSXAdNyCRMhezZNcpqu+2jTiOUjTO6AjbGfDBdIK1q/wvLu9/UHTi49hZ/4JNn1XK6h5SPXRZxHyoTaEC/MPpjiF3dM2ae/fH+eF3XRJr8+zXmhq
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN6PR1201MB0146.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(39860400002)(376002)(396003)(346002)(366004)(36756003)(26005)(956004)(16526019)(2906002)(83380400001)(6916009)(2616005)(186003)(44832011)(7696005)(6486002)(66946007)(8676002)(6666004)(5660300002)(52116002)(54906003)(66476007)(66556008)(316002)(4326008)(478600001)(8936002)(86362001)(1076003)(30864003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: Asy9W9rLS6C3JCeofs3ePGcWeAg1maDDzxjaNhBO2unrAG92UUDpXWKgruq5SsIzRT3QXQZhlzpy09ArTLC6ATQ3dTlXIIiXRsUJAuNg0Qyu05tUQo7mZ4dBju9cy7CNnG3SKb1n9iNKMvn+HT7ek6EuBurcO2obVBJI2t5mHO0TQm6sgWKHAyZ8qHWsdnE8nBxPmmwGmzMVp2wNHrKK6ERjoyL2Dd4pTjx88wgqkbX5gmTwpuLc8FLvMoaKwhywgLOMvtozFtpZ5M0UrZMOSCTrC9ZHUlzxiJxwDN2PpbG4Qds+3BFvP5pvY4aUCsYPkx95fNJ3s/OZnUgkdssqISJKKiQHzFWV0WjoOh26OiORqX+DolKD63jztMy5E4tofGWR3Meia5BvDBWXUl82CyWbHDJMW3i841/sPLs7O3KJ8LvTB+BpKCkEJIumZct8ebyXfBVh8duJRYFyGjGWaw2xyWOG+sx1Gh1cU4wqS6yL+JIFwz2hZCAxTkexQAxQRES7dNuLjI2DnTnNwSIsnIiKNAQUqhwnGt3TsvyFekM5jVbMRTp4T2q6NmnbtU6sDNDZWPzoRaXRZB2sn1K9IRXlwRTeG4UpsSrgDa5KtlX75MPieoDrIoXHLRmOLrUEtOALn/Un4aJWfxC4aIlTIQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4e884cc-baf9-4b0d-d857-08d853f80cd4
X-MS-Exchange-CrossTenant-AuthSource: BN6PR1201MB0146.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2020 13:06:50.7774 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bgnSsnyLhGIZ46exvkCsiONDg3d3KzVHwP7OFdpO3zhjF0oTh0Xaq3Bzpcw4d4rF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3604
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
Cc: Felix.Kuehling@amd.com, Jonathan Kim <Jonathan.Kim@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Non-outbound data metrics are non useful so mark them as legacy.
Bucket new perf counters into device and not device ip.
Bind events to chip instead of IP.
Report available event counters and not number of hw counter banks.
Move DF public macros to private since not needed outside of IP version.

Signed-off-by: Jonathan Kim <Jonathan.Kim@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h     |  13 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c | 327 +++++++++++++++++++++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.h |   6 +-
 drivers/gpu/drm/amd/amdgpu/df_v3_6.c    |  72 +-----
 drivers/gpu/drm/amd/amdgpu/df_v3_6.h    |   9 -
 5 files changed, 299 insertions(+), 128 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 49ea9fa780c4..0cb2f12a1fbd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1265,19 +1265,6 @@ void amdgpu_unregister_gpu_instance(struct amdgpu_device *adev);
 
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
index 915c580d30be..82f57bd38716 100644
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
@@ -39,8 +43,91 @@ struct amdgpu_pmu_entry {
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
@@ -72,7 +159,8 @@ static void amdgpu_perf_start(struct perf_event *event, int flags)
 	hwc->state = 0;
 
 	switch (pe->pmu_perf_type) {
-	case PERF_TYPE_AMDGPU_DF:
+	case PERF_TYPE_AMDGPU_DF_LEGACY:
+	case PERF_TYPE_AMDGPU_XGMI:
 		if (!(flags & PERF_EF_RELOAD))
 			pe->adev->df.funcs->pmc_start(pe->adev, hwc->config,
 								hwc->idx, 1);
@@ -102,7 +190,8 @@ static void amdgpu_perf_read(struct perf_event *event)
 		prev = local64_read(&hwc->prev_count);
 
 		switch (pe->pmu_perf_type) {
-		case PERF_TYPE_AMDGPU_DF:
+		case PERF_TYPE_AMDGPU_DF_LEGACY:
+		case PERF_TYPE_AMDGPU_XGMI:
 			pe->adev->df.funcs->pmc_get_count(pe->adev,
 						hwc->config, hwc->idx, &count);
 			break;
@@ -127,7 +216,8 @@ static void amdgpu_perf_stop(struct perf_event *event, int flags)
 		return;
 
 	switch (pe->pmu_perf_type) {
-	case PERF_TYPE_AMDGPU_DF:
+	case PERF_TYPE_AMDGPU_DF_LEGACY:
+	case PERF_TYPE_AMDGPU_XGMI:
 		pe->adev->df.funcs->pmc_stop(pe->adev, hwc->config, hwc->idx,
 									0);
 		break;
@@ -155,10 +245,15 @@ static int amdgpu_perf_add(struct perf_event *event, int flags)
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
 		retval = pe->adev->df.funcs->pmc_start(pe->adev,
 						hwc->config, hwc->idx, 1);
 		if (retval >= 0) {
@@ -192,7 +287,8 @@ static void amdgpu_perf_del(struct perf_event *event, int flags)
 	amdgpu_perf_stop(event, PERF_EF_UPDATE);
 
 	switch (pe->pmu_perf_type) {
-	case PERF_TYPE_AMDGPU_DF:
+	case PERF_TYPE_AMDGPU_DF_LEGACY:
+	case PERF_TYPE_AMDGPU_XGMI:
 		pe->adev->df.funcs->pmc_stop(pe->adev, hwc->config, hwc->idx,
 									1);
 		break;
@@ -203,18 +299,42 @@ static void amdgpu_perf_del(struct perf_event *event, int flags)
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
 
@@ -232,59 +352,182 @@ static int init_pmu_by_type(struct amdgpu_device *adev,
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
index 8dadcdcffba0..569c40be6e75 100644
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
