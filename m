Return-Path: <SRS0=hFGi=CM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,RCVD_ILLEGAL_IP,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9118AC2BC0E
	for <amd-gfx@archiver.kernel.org>; Thu,  3 Sep 2020 16:22:17 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 684A020775
	for <amd-gfx@archiver.kernel.org>; Thu,  3 Sep 2020 16:22:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="kz20L6mF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 684A020775
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A179F6EA11;
	Thu,  3 Sep 2020 16:22:16 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2057.outbound.protection.outlook.com [40.107.243.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 06E676EA0C
 for <amd-gfx@lists.freedesktop.org>; Thu,  3 Sep 2020 16:22:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D37h8GBh8QwT29wstt7KbYxwt5kBZjHIKCXvNN89bEMRQGbrlNzV4RxQQZquIBTneFDR5Y2GVefoxMa8/lELibA0XyB7AhoNobBTDaxgEXAbb7bqorvcc2UaUqbnsK/aJaP8dgh7k8OQpMFWMGbxclRMha3h5TiuAgkWsAxm/YAvA7plUS0Kko+Z+I9iSC3GRrx3yEg04ZMTBDL+024Aeq/iI/1MxQaFuVNOwcVQMkPyrEB/B7xpmpxZWfagpESHtScfFy2Sl5ByEanWAFUP2fKP4IRfitpl8eRmnUEoj+RSHYfNFFbT34Ep3WVuWO3C3+h2wS1SRdOiXd5mXvMstA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qLSGIqnWT08j0lhr5EspO/sK+jjDvySH8dIr6dmCK3Q=;
 b=kedkGfaVF6nUF6sXGIGe+Fk2Rl7rxIkKWCtE+sx19BKJ0hPEbG+fqh4RCoF1MFGdEGrnfjjcxxAZCY4YrK+8FwyNFmRU2TICiFmbU6nivD+hpMXoPH278ulYNCTIBSnjlthZqsE48b7lQf209blACLeGEAhBB5ysFvke8ArUzJG8wo7GQiyfvUoeLVGuYhKqHhUtMaA1LUmr4vwOwuTARgyeYvP+1RBF21+GXN6IB2Oy1BpAJY/bNNAVmcuEAIawKPfs4ue5x8nDM+Aj9cSQDx7+EOgUpUww/bB+oXG3amQEVv+j7bTOMrISl/0uJgfN2WERVCjTG9lcXIHzXkcMDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qLSGIqnWT08j0lhr5EspO/sK+jjDvySH8dIr6dmCK3Q=;
 b=kz20L6mFK2g94QAGOkNGeONTiwFS+fzWHb/66aTyhy2rtC+jalwV0xwe+NGyo92h3ew3Cz5p/1NiuS9kW3SaCH1rw3hnf9Xq6Ez8OkmuCGse3QBL2SGemTC4yBi2m5OQNfYbQt2S4Ae2fe1439vmkXGir9+ndNNFmOzvaCDmZB0=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BN6PR1201MB0146.namprd12.prod.outlook.com
 (2603:10b6:405:59::18) by BN8PR12MB2978.namprd12.prod.outlook.com
 (2603:10b6:408:42::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.23; Thu, 3 Sep
 2020 16:22:13 +0000
Received: from BN6PR1201MB0146.namprd12.prod.outlook.com
 ([fe80::615d:bea9:8838:92be]) by BN6PR1201MB0146.namprd12.prod.outlook.com
 ([fe80::615d:bea9:8838:92be%4]) with mapi id 15.20.3348.016; Thu, 3 Sep 2020
 16:22:13 +0000
From: Jonathan Kim <jonathan.kim@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 4/6] drm/amdgpu: cleanup pmu
Date: Thu,  3 Sep 2020 12:21:52 -0400
Message-Id: <20200903162154.55694-4-jonathan.kim@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200903162154.55694-1-jonathan.kim@amd.com>
References: <20200903162154.55694-1-jonathan.kim@amd.com>
X-ClientProxiedBy: YTXPR0101CA0027.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::40) To BN6PR1201MB0146.namprd12.prod.outlook.com
 (2603:10b6:405:59::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by
 YTXPR0101CA0027.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00::40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3326.19 via Frontend Transport; Thu, 3 Sep 2020 16:22:12 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: c23528bb-76c5-4f8d-e7c2-08d8502583fd
X-MS-TrafficTypeDiagnostic: BN8PR12MB2978:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN8PR12MB29781C91C61F5B5EE3407676852C0@BN8PR12MB2978.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:262;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: n0xsgKo+tqVEm33Boc5XJIs2AfxJT6kUTE2nWHEtAOdfkVa1UNCNJohQlbHJYLfpTxIAPiZj4gvoqJ/J23cG+RfY2IbpfkmC/VTim54NoOml4Lp3DU1Zi0lktXG0+LgnLCT+OMC9j7xuZ/DS+RNz0FsK/PGwS7MUpM8+TLZodX6qbUYqf/ONeH6D/rvv7QSv3hlgskmGXWDaBfUO+l27kHFjhRVNQgQL4iP3sg3gq//Jm196k9h4lM1Pijn1KtGHici8UvBuztnnP8XJbGcUpPkmR+rVGO/d16h6mShjdEgMXlOrPdM5XMUhxay2Rrxs
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN6PR1201MB0146.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(39860400002)(136003)(376002)(346002)(366004)(316002)(54906003)(2906002)(6486002)(4326008)(16576012)(478600001)(8936002)(6666004)(83380400001)(8676002)(66556008)(52116002)(6916009)(66476007)(5660300002)(86362001)(2616005)(186003)(44832011)(1076003)(66946007)(956004)(36756003)(26005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: MGYZcN5cHLtmkIY4TILoD8W88bG8F5T4P7U1PTXHa0ygW0UuAiOOY4FgPgW2tPN8Z0aeS0yqv2W1UzmA0aQeoXzkZgbXN41S2tWOHWPrQaS45VUPwLMqybcUEC0ztrz43Euja9FsCTxT+z+oUOLQAznr8ywpnxNp7kMGDuOSaABAPHj3WS5wfC1h/nc4kMBLnKk3UnI6ev9zGREKhKEOzLUsFDliwm42XPRXUEsDqIU9BEp41M4YGY4ss6DkP0Piobaozf9RpLbD6+QayDo8JIRf23zc31d1GpqCHCAktFP3I7Jt1e/FRLrwOXXrUkeME3WFNnU2USV7x3yWsOjUn7oUE0Sz6dYu12ZtH63BBFW3T6k0yGJl5894WzUiHAODvHsa8EGpmiI9hk6VpGUToCLPfwOWE6Y9ZGybL6ttRJuvVY95lx729B8QgCzNTIHKiC6WUJgo4Vy78s3QoU1/KRL9N/p6KT95QNlZ3yqtJtKSXE0WOB706dEt3Vll1nPZJoKcUARLWlYejOraStLN0ksyxPxb9det3iMaZ94BaquE+yoWvmuK8ZT3l+14Jl0aKYwBROuKakX83BwQirOi55m9pKEMWMSZE7FHngBkrNOIn0Dxlo587M/oNSUNBzoQnCc5HU/6EofoadhpkJEy+w==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c23528bb-76c5-4f8d-e7c2-08d8502583fd
X-MS-Exchange-CrossTenant-AuthSource: BN6PR1201MB0146.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2020 16:22:13.3531 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +enICXD3YkZvSGIwYGOd0kGS/gwn8V7QiIem9/yz7n3NmWa97OLYr7aa611e+OQx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB2978
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

Switch from marcros to helper that builds events per chip.
Also abstract IP events from version since they can bind to chip instead.

Signed-off-by: Jonathan Kim <Jonathan.Kim@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h     |  13 ---
 drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c | 108 +++++++++++++++++++++---
 drivers/gpu/drm/amd/amdgpu/df_v3_6.c    |  63 --------------
 3 files changed, 95 insertions(+), 89 deletions(-)

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
index 0aef565acabf..517448aa2d50 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c
@@ -27,9 +27,9 @@
 #include <linux/init.h>
 #include "amdgpu.h"
 #include "amdgpu_pmu.h"
-#include "df_v3_6.h"
 
 #define PMU_NAME_SIZE 32
+#define NUM_FORMATS_DF_VEGA20	3
 #define NUM_EVENTS_DF_VEGA20	8
 
 /* record to keep track of pmu entry per pmu type per device */
@@ -42,6 +42,39 @@ struct amdgpu_pmu_entry {
 
 static LIST_HEAD(amdgpu_pmu_list);
 
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
+
+static const char *df_vega20_formats[NUM_FORMATS_DF_VEGA20][2] = {
+	{ "event", "config:0-7" },
+	{ "instance", "config:8-15" },
+	{ "umask", "config:16-23"}
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
+
 /* initialize perf counter */
 static int amdgpu_perf_event_init(struct perf_event *event)
 {
@@ -203,13 +236,48 @@ static void amdgpu_perf_del(struct perf_event *event, int flags)
 	perf_event_update_userpage(event);
 }
 
-/* vega20 pmus */
+static int amdgpu_pmu_create_attributes(struct attribute_group *attr_group,
+					const char *events[][2],
+					int max_attrs)
+{
+
+	struct perf_pmu_events_attr *pmu_attr = NULL;
+	int i;
+
+	pmu_attr = kcalloc(max_attrs, sizeof(*pmu_attr), GFP_KERNEL);
+	if (!pmu_attr)
+		return -ENOMEM;
+
+	attr_group->attrs = kcalloc(max_attrs + 1, sizeof(*attr_group->attrs),
+								GFP_KERNEL);
+	if (!attr_group->attrs) {
+		kfree(pmu_attr);
+		return -ENOMEM;
+	}
+
+	for (i = 0; i < max_attrs; i++) {
+		attr_group->attrs[i] = &pmu_attr->attr.attr;
+		sysfs_attr_init(&pmu_attr->attr.attr);
+		pmu_attr->attr.attr.name = events[i][0];
+		pmu_attr->attr.attr.mode = 0444;
+		pmu_attr->attr.show = perf_event_sysfs_show;
+		pmu_attr->event_str = events[i][1];
+		pmu_attr++;
+	}
+
+	return 0;
+}
 
 /* init pmu tracking per pmu type */
 static int init_pmu_by_type(struct amdgpu_device *adev,
 		  const struct attribute_group *attr_groups[],
 		  char *pmu_type_name, char *pmu_file_prefix,
 		  unsigned int pmu_perf_type,
+		  const char *formats[][2],
+		  struct attribute_group *format_group,
+		  unsigned int num_formats,
+		  const char *events[][2],
+		  struct attribute_group *event_group,
 		  unsigned int num_events)
 {
 	char pmu_name[PMU_NAME_SIZE];
@@ -232,18 +300,23 @@ static int init_pmu_by_type(struct amdgpu_device *adev,
 		.task_ctx_nr = perf_invalid_context,
 	};
 
+	ret = amdgpu_pmu_create_attributes(format_group, formats, num_formats);
+	if (ret)
+		goto err;
+
+	ret = amdgpu_pmu_create_attributes(event_group, events, num_events);
+	if (ret)
+		goto err;
+
 	pmu_entry->pmu.attr_groups = attr_groups;
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
 			pmu_type_name, num_events);
@@ -251,6 +324,10 @@ static int init_pmu_by_type(struct amdgpu_device *adev,
 	list_add_tail(&pmu_entry->entry, &amdgpu_pmu_list);
 
 	return 0;
+err:
+	kfree(pmu_entry);
+	pr_warn("Error initializing AMDGPU %s PMUs.\n", pmu_type_name);
+	return ret;
 }
 
 /* init amdgpu_pmu */
@@ -261,9 +338,14 @@ int amdgpu_pmu_init(struct amdgpu_device *adev)
 	switch (adev->asic_type) {
 	case CHIP_VEGA20:
 		/* init df */
-		ret = init_pmu_by_type(adev, df_v3_6_attr_groups,
-				       "DF", "amdgpu_df", PERF_TYPE_AMDGPU_DF,
-				       NUM_EVENTS_DF_VEGA20);
+		ret = init_pmu_by_type(adev, df_vega20_attr_groups,
+					"DF", "amdgpu_df", PERF_TYPE_AMDGPU_DF,
+					df_vega20_formats,
+					&df_vega20_format_attr_group,
+					NUM_FORMATS_DF_VEGA20,
+					df_vega20_events,
+					&df_vega20_event_attr_group,
+					NUM_EVENTS_DF_VEGA20);
 
 		/* other pmu types go here*/
 		break;
@@ -271,7 +353,7 @@ int amdgpu_pmu_init(struct amdgpu_device *adev)
 		return 0;
 	}
 
-	return 0;
+	return ret;
 }
 
 
diff --git a/drivers/gpu/drm/amd/amdgpu/df_v3_6.c b/drivers/gpu/drm/amd/amdgpu/df_v3_6.c
index 42937c474e46..569c40be6e75 100644
--- a/drivers/gpu/drm/amd/amdgpu/df_v3_6.c
+++ b/drivers/gpu/drm/amd/amdgpu/df_v3_6.c
@@ -42,69 +42,6 @@
 static u32 df_v3_6_channel_number[] = {1, 2, 0, 4, 0, 8, 0,
 				       16, 32, 0, 0, 0, 2, 4, 8};
 
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
-
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
-
-/* df event attr groups  */
-const struct attribute_group *df_v3_6_attr_groups[] = {
-		&df_v3_6_format_attr_group,
-		&df_v3_6_event_attr_group,
-		NULL
-};
-
 static uint64_t df_v3_6_get_fica(struct amdgpu_device *adev,
 				 uint32_t ficaa_val)
 {
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
