Return-Path: <SRS0=hFGi=CM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,RCVD_ILLEGAL_IP,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6C75C433E2
	for <amd-gfx@archiver.kernel.org>; Thu,  3 Sep 2020 16:22:18 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E4D5208CA
	for <amd-gfx@archiver.kernel.org>; Thu,  3 Sep 2020 16:22:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="uREV4cdd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E4D5208CA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0614A6EA12;
	Thu,  3 Sep 2020 16:22:17 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2057.outbound.protection.outlook.com [40.107.243.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3A68A6EA12
 for <amd-gfx@lists.freedesktop.org>; Thu,  3 Sep 2020 16:22:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IpXl2hagPCb7OQCbz++kppNyhCNM9c80O0QX00P20BD149W1OAd/GmXKhnzw9hAVNbNuXMpE6a9+eV9f40nA68A3/Pruh4vgBmKNkd8ibR9ti8eH5Tn+Kydz1jQWaI2vEE273+aDIACusYmTAKmlZo3ujiGK45YgA3DfIKmOxfOBlbh4jA7ZddzUNzrTRHqOYUjZmu0yJluheHzCCk/STAEKTUWsNv96FXui0Cq88qkR2SsD5ExrTjLh2zfUZzjeB1jaiP4lXTZWrSUDU2UyR6XuMvPXjQZKkQr1Dgz3szpt16H+ec+hxZIPo0F3Z1c9BY08xhV/cxUS9CDejM+hdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UW1hX4LrjOVvkWNTAxFfKb17gQiACs0ayzSblPTAcSc=;
 b=WBDe781yCRw4JAmZGvYImTdbNtdOOJEDtig+/xZYmT1voTo4/Gax6LaNLjlNzIM3Jyg15Fgi6wYnkUGcqGHlGgJ6JiS/uHcuPSZ3TIr/+LslZkclNZ7QGecsPdNYbQEawY8CZsXaFI/by9RDHqyD+MTnbiu3B1XHqfinmH/h2CQpMPxA+4jk5Ieh367qERQjcoAGLM5xp2g9cCWF9Z0AVpGVVzFoAWeB1KRei1Jea0VcEuDhnbxVHkr2L24BvT5iGoacy13zXlSL2nbTeljxqkEFgbAorgFaL+eExMdlkTr4/UAYtzu8HImnKhGttemc8CGlP9fPCZQbMpv2Ca8BRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UW1hX4LrjOVvkWNTAxFfKb17gQiACs0ayzSblPTAcSc=;
 b=uREV4cddUTiENwpEkSrvyejhUjJkR/b2kxL5fpHpAT4LPqpINHm5Iv+8yOWcpQEMzd3Ss0HPOXToo7G8gU3uzCHk1ZHoMdMrI1knwT+J7oRByxV8lEB5cZavbVqR9gCb0nCNbgFrbh6gsFVfjr1UANFTyWk44yp/i+xNPiQcCeA=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BN6PR1201MB0146.namprd12.prod.outlook.com
 (2603:10b6:405:59::18) by BN8PR12MB2978.namprd12.prod.outlook.com
 (2603:10b6:408:42::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.23; Thu, 3 Sep
 2020 16:22:14 +0000
Received: from BN6PR1201MB0146.namprd12.prod.outlook.com
 ([fe80::615d:bea9:8838:92be]) by BN6PR1201MB0146.namprd12.prod.outlook.com
 ([fe80::615d:bea9:8838:92be%4]) with mapi id 15.20.3348.016; Thu, 3 Sep 2020
 16:22:14 +0000
From: Jonathan Kim <jonathan.kim@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 5/6] drm/amdgpu: add user friendly xgmi events
Date: Thu,  3 Sep 2020 12:21:53 -0400
Message-Id: <20200903162154.55694-5-jonathan.kim@amd.com>
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
 15.20.3326.19 via Frontend Transport; Thu, 3 Sep 2020 16:22:13 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: ef7210c2-760c-4af6-4112-08d850258498
X-MS-TrafficTypeDiagnostic: BN8PR12MB2978:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN8PR12MB2978ED17A6FA4154BF38F8B2852C0@BN8PR12MB2978.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:411;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: a9F/gBBQaNQ8AADdEpx8Ftl1xwDl1msgtx7WBT0KoM8ks6YloxQfEo85/TW/s2pgi0BHLRxtXZ++mevsGNwxMlROG0TbdnEinVwN3cajVSEIS4Xwbm+uJiCQ7hxNW8zxjPq++laGBBIK0x+C+P6IVnKNENOj5JewVkCQ6UfWI5WSyfnCYIS4hofnjqopDuWmY4jLIjEoTGhK7CLq86gc5PRJ7KUisMs3T6chZgiHk8mGW4C0XIUQOrWsU5/8hjkHRfjzHrM7zhRSrHLKtC20DL6ViW7hL2xmHju1VQRGQ2+qs8We9uy8P7lq4hoxau4ZG4YZLijHpyn1QuGdhOXrDw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN6PR1201MB0146.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(39860400002)(136003)(376002)(346002)(366004)(316002)(54906003)(2906002)(6486002)(4326008)(16576012)(478600001)(8936002)(6666004)(8676002)(66556008)(52116002)(6916009)(66476007)(5660300002)(86362001)(2616005)(186003)(44832011)(1076003)(66946007)(956004)(36756003)(26005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: OjMxeKHhp6r/vDPmAUSTASZDxRGEAKJPnO0/ta5LeTwdiAu64xtMnZY1JC7HKbB+kdp48njmblJDqsejmluwHNzJiMBlVmlZMebmH8HbB4rblLNK0HErtMIxKxcQig/ik/ulmtUcC9iP72FP6jwKFZf3qxi7JpDvOkd93DeJZDSCrN5kACw7pauCyGCZba/bVWI4egzXHozHUx/4U12C9LSlXag5W1j7f4g+Jqcc1WNmopeAqkzGxh/45TBfxqKmRvR3cLJX3Ou+81ilZTvrYTYsr7ik2lW69Qq4MXOSpS0HlVRbrz+a9nrjowfqdZAEQlVxWMWofx2AZZZGiodvt9GwtXxA074Lui1eP95nBUhI5DfaorKPd6dZwJALjr9QWwy90IeK1IA9mQLR0HEKTBpXgCK6I0qinL7opt4eLHb1xexueho6wke6Tc23Q6X54bY+RdrKBwfPHJb3tPHl44+gPCOe2CsXy+4x3k9OSHxKMvWg4E2cOmqXfRhfl+uR7YvAl5czvm1d8Nkq2dlPzNJVkzfGlP8x7qN4NTJGQPJBUOMWUPb3LPZVRGiWVuVjT0MbTcWL5MYQR9FYAtAT5/sfWpCVJQZIiWjTWNgX4Uj5E4fj5txGmvAYNcEUv9Efo322NnlqR+zATiPPeadg5w==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef7210c2-760c-4af6-4112-08d850258498
X-MS-Exchange-CrossTenant-AuthSource: BN6PR1201MB0146.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2020 16:22:14.3157 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yDIUPvAB0gbhH8r5y5BbJiKSi+oFqvJksfktFny38au5BHLIn8qMrjPcvu31Bz0C
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

Non-outbound data is useless for throughput metrics.  Add human readable
events and note deprecated events.  New events are now per-device and not
per-device-per-ip.

Signed-off-by: Jonathan Kim <Jonathan.Kim@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c | 38 +++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.h |  1 +
 2 files changed, 39 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c
index 517448aa2d50..eaa44c99d423 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c
@@ -31,6 +31,7 @@
 #define PMU_NAME_SIZE 32
 #define NUM_FORMATS_DF_VEGA20	3
 #define NUM_EVENTS_DF_VEGA20	8
+#define NUM_EVENTS_XGMI_VEGA20	2
 
 /* record to keep track of pmu entry per pmu type per device */
 struct amdgpu_pmu_entry {
@@ -52,18 +53,33 @@ static struct attribute_group df_vega20_event_attr_group = {
 	.attrs = NULL
 };
 
+static struct attribute_group xgmi_vega20_event_attr_group = {
+	.name = "events",
+	.attrs = NULL
+};
+
 const struct attribute_group *df_vega20_attr_groups[] = {
 	&df_vega20_format_attr_group,
 	&df_vega20_event_attr_group,
 	NULL
 };
 
+const struct attribute_group *xgmi_vega20_attr_groups[] = {
+	&df_vega20_format_attr_group,
+	&xgmi_vega20_event_attr_group,
+	NULL
+};
+
 static const char *df_vega20_formats[NUM_FORMATS_DF_VEGA20][2] = {
 	{ "event", "config:0-7" },
 	{ "instance", "config:8-15" },
 	{ "umask", "config:16-23"}
 };
 
+/*
+ * DF events for xGMI - DEPRECATED.
+ * Potential for non-xgmi DF counters in the future.
+ */
 static const char *df_vega20_events[NUM_EVENTS_DF_VEGA20][2] = {
 	{ "cake0_pcsout_txdata", "event=0x7,instance=0x46,umask=0x2" },
 	{ "cake1_pcsout_txdata", "event=0x7,instance=0x47,umask=0x2" },
@@ -75,6 +91,11 @@ static const char *df_vega20_events[NUM_EVENTS_DF_VEGA20][2] = {
 	{ "cake1_ftiinstat_rspalloc", "event=0xb,instance=0x47,umask=0x8" },
 };
 
+static const char *xgmi_vega20_events[NUM_EVENTS_XGMI_VEGA20][2] = {
+	{ "xgmi_link0_data_outbound", "event=0x7,instance=0x46,umask=0x2" },
+	{ "xgmi_link1_data_outbound", "event=0x7,instance=0x47,umask=0x2" }
+};
+
 /* initialize perf counter */
 static int amdgpu_perf_event_init(struct perf_event *event)
 {
@@ -106,6 +127,7 @@ static void amdgpu_perf_start(struct perf_event *event, int flags)
 
 	switch (pe->pmu_perf_type) {
 	case PERF_TYPE_AMDGPU_DF:
+	case PERF_TYPE_AMDGPU_XGMI:
 		if (!(flags & PERF_EF_RELOAD))
 			pe->adev->df.funcs->pmc_start(pe->adev, hwc->config,
 								hwc->idx, 1);
@@ -136,6 +158,7 @@ static void amdgpu_perf_read(struct perf_event *event)
 
 		switch (pe->pmu_perf_type) {
 		case PERF_TYPE_AMDGPU_DF:
+		case PERF_TYPE_AMDGPU_XGMI:
 			pe->adev->df.funcs->pmc_get_count(pe->adev,
 						hwc->config, hwc->idx, &count);
 			break;
@@ -161,6 +184,7 @@ static void amdgpu_perf_stop(struct perf_event *event, int flags)
 
 	switch (pe->pmu_perf_type) {
 	case PERF_TYPE_AMDGPU_DF:
+	case PERF_TYPE_AMDGPU_XGMI:
 		pe->adev->df.funcs->pmc_stop(pe->adev, hwc->config, hwc->idx,
 									0);
 		break;
@@ -192,6 +216,7 @@ static int amdgpu_perf_add(struct perf_event *event, int flags)
 
 	switch (pe->pmu_perf_type) {
 	case PERF_TYPE_AMDGPU_DF:
+	case PERF_TYPE_AMDGPU_XGMI:
 		retval = pe->adev->df.funcs->pmc_start(pe->adev,
 						hwc->config, hwc->idx, 1);
 		if (retval >= 0) {
@@ -226,6 +251,7 @@ static void amdgpu_perf_del(struct perf_event *event, int flags)
 
 	switch (pe->pmu_perf_type) {
 	case PERF_TYPE_AMDGPU_DF:
+	case PERF_TYPE_AMDGPU_XGMI:
 		pe->adev->df.funcs->pmc_stop(pe->adev, hwc->config, hwc->idx,
 									1);
 		break;
@@ -346,6 +372,18 @@ int amdgpu_pmu_init(struct amdgpu_device *adev)
 					df_vega20_events,
 					&df_vega20_event_attr_group,
 					NUM_EVENTS_DF_VEGA20);
+		if (ret)
+			break;
+
+		/* init xgmi */
+		ret = init_pmu_by_type(adev, xgmi_vega20_attr_groups,
+					"XGMI", "amdgpu", PERF_TYPE_AMDGPU_XGMI,
+					df_vega20_formats,
+					&df_vega20_format_attr_group,
+					NUM_FORMATS_DF_VEGA20,
+					xgmi_vega20_events,
+					&xgmi_vega20_event_attr_group,
+					NUM_EVENTS_XGMI_VEGA20);
 
 		/* other pmu types go here*/
 		break;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.h
index 7dddb7160a11..2f1a80c42dbf 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.h
@@ -28,6 +28,7 @@
 
 enum amdgpu_pmu_perf_type {
 	PERF_TYPE_AMDGPU_DF = 0,
+	PERF_TYPE_AMDGPU_XGMI,
 	PERF_TYPE_AMDGPU_MAX
 };
 
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
