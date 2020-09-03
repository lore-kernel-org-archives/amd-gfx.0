Return-Path: <SRS0=hFGi=CM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,RCVD_ILLEGAL_IP,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0434FC433E2
	for <amd-gfx@archiver.kernel.org>; Thu,  3 Sep 2020 16:22:16 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C50BB208C7
	for <amd-gfx@archiver.kernel.org>; Thu,  3 Sep 2020 16:22:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="uNKLQymo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C50BB208C7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0E6C86EA0E;
	Thu,  3 Sep 2020 16:22:14 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2063.outbound.protection.outlook.com [40.107.243.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 13D626EA09
 for <amd-gfx@lists.freedesktop.org>; Thu,  3 Sep 2020 16:22:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=crvVwE3HW1TB29CRpJAcZ12j+BH2RQuZUBHe4/354k/r0cxsy08+9qplbrCFqKQiisY7hjXorG8Oj9z0fesg/V8oZxJw2fC+SbCvYssIm0v4wcum+gr8CbvRD8FC7DvyJG406A3ZqEQKEv8N3iP98tLjCHQTyp3yIPKLdq0Zxuq2h0SCHgVgxpSwIzFBVKa7UfirnXvpeF82/5zZnxn0Q/CMEiBjptjOV0lL9+5ImYaNCH+EviBgTgwfdGjrxGIALuXecSj+OnyuawzoDnQ9iqTsDS3AmejcBFHRIa4Ug6sS+LAxpUwB2N3c8CTNXzdWLcgpDRRDhMEsMN8lqMk6Sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u+zV0N1rjrYFosc9w18A7POWH1UkAGTWWCTE3dFUHkM=;
 b=KUfZieE8RD3s5EzAGRqvCXQt3RBHDsHxGztaxyKDhAQS5eJ+4OijTiIa3+nh2UjSErDWgvLzvUgYJjF6iCbiLA8I9lENNsBdgsE5kvQH681x5xay/JZ/ygvKaEF01NUqTa5d1bSXvzmE0ISz7Z0GSyiSXN9qgqZX2XjoKkyeh/0d8N+6mmut3+tfSUFYHujRxUGQKBFPqM3xdT/OAY1xVBu8vgxN4wbBs9i0N+DbMaAexrM1GzRVdqRTa8V/+MHdpJeYRk/NCmwxla5VB7OMjUMlhIfllGQAWnxuCVis2WI1BUTtnCANKBgZYYq+a/RUxnvAmWLal38Gmi8OpzrqsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u+zV0N1rjrYFosc9w18A7POWH1UkAGTWWCTE3dFUHkM=;
 b=uNKLQymohTnFRrF9OUfhp3OkslgiesHAEE8kGmDlXaljvm/dM/B/AfNzUOaEzudCuyV1x1r5yWzFO/RES/jqtgn5ysP8webHaCg7YkuMCVJfE2cHWP2JGuYt7SicuRIGTGJEEPDSen8/US0TGVLbbdjz1OrlzssoQVvMuCMIdyE=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BN6PR1201MB0146.namprd12.prod.outlook.com
 (2603:10b6:405:59::18) by BN8PR12MB2978.namprd12.prod.outlook.com
 (2603:10b6:408:42::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.23; Thu, 3 Sep
 2020 16:22:12 +0000
Received: from BN6PR1201MB0146.namprd12.prod.outlook.com
 ([fe80::615d:bea9:8838:92be]) by BN6PR1201MB0146.namprd12.prod.outlook.com
 ([fe80::615d:bea9:8838:92be%4]) with mapi id 15.20.3348.016; Thu, 3 Sep 2020
 16:22:12 +0000
From: Jonathan Kim <jonathan.kim@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 3/6] drm/amdgpu: make df defines private and change counter
 report
Date: Thu,  3 Sep 2020 12:21:51 -0400
Message-Id: <20200903162154.55694-3-jonathan.kim@amd.com>
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
 15.20.3326.19 via Frontend Transport; Thu, 3 Sep 2020 16:22:11 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: ee23e0e2-eb19-4670-ff31-08d850258365
X-MS-TrafficTypeDiagnostic: BN8PR12MB2978:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN8PR12MB29788EAFAE78B77E65979EDD852C0@BN8PR12MB2978.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YQqhLMt/w1G+NG5EqHm6xnoUqghlMAVSh3zLS348AN8oczu/4HVVx3K8JFY1G0Rh5AvqMlXozhtDtkOM1UIevfeHTq1tSMhl2aJbmZqycQOZBKhUkjoyHGD7YTmZ2OmnkiLMKm37D0ZBFXNn/86/o9mB/bzY+aFL0Yc2+Qvkz/c9//aFCD+22Se2Vwe54ZvK8+zBzZ/AscD42D3WnJedCY2oRUOZyo578u9gJHiHd/FVmlyjQ/JeGObVqOmZ9BqGuEfhCPvSBmygGxGZ2D3OveFVolwkJRPWQcW68Dxl1BVfomK6/wKaJ0LBuFAycoc5aOCQWqY77dc75xvJykBhNw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN6PR1201MB0146.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(39860400002)(136003)(376002)(346002)(366004)(316002)(54906003)(2906002)(6486002)(4326008)(16576012)(478600001)(8936002)(6666004)(83380400001)(8676002)(66556008)(52116002)(6916009)(66476007)(5660300002)(86362001)(2616005)(186003)(44832011)(1076003)(66946007)(956004)(36756003)(26005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: 0hqYXZBEkJvrhEqiwRQSKTLJeiNr8VEtB4jI4HZN1gmK5By2NekMtJnK6erEwujD4c+HSwmSQedNanZPi4bkQVyn5Oga4mPdvzZMYDbvL6PInS4eZdn+Okq8Uom/hgAK6zOMFNm4xv3FAGAjxZKpSpIV/urIZYHA/1roAB0/1iIJ06BgJU3Gyb8DXFtuykOO8qJdChkmgFAmcOdtca7EJN2j9PoFCp4eune0sXQKHW4v6op6iPx04VcMWIYWQA230pfr7E5DDO6UEsZXqVAT9dEKNoaMARKXDENdRowTJEaUyODbEen36uG+ftI+fiMkBnXVhuZ8lw4cYx34OMSPC4F6/eJT1yBHdX3jmRhVz/TPRENn4x/BfBHn69C1XfykEAlyvHN2M8WSUKOe3qM4OUdXKRJJieyRv1IdEtnoDOGNP3otL0mI1OJ+9H12tr+z0IMqnGu6xHCdTW7pOipo/aSiubhJ14YJzwES06OGAoKcKw15680JN0Ql/01/g9sO/jTBpmcq/W6AJvcZ4m5fp4drBSnv5a4g23l0Sp/MSwa9iX2E6qAmH3VuD9+fD9fn9xeCNE0b5+ljVQdsZ6WqpiuWbZ0OxrQI5c7sUPbqrtLhPYSoV5wUwReubTG1ONXntUpE6noe4Zh93hD7m51B4A==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee23e0e2-eb19-4670-ff31-08d850258365
X-MS-Exchange-CrossTenant-AuthSource: BN6PR1201MB0146.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2020 16:22:12.3306 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NBF/jbyBrfmzanfKMwqQACAFjhphFdlooo7JkQ8ROltnPlhUUqe3wRTWX6NON+q2
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

DF public defines should not be used outside of DF IP version so make them
private.

Also, users do not care about the number of available programmable hardware
counters so report the number of events available instead.

Signed-off-by: Jonathan Kim <Jonathan.Kim@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c | 8 ++++----
 drivers/gpu/drm/amd/amdgpu/df_v3_6.c    | 9 +++++++++
 drivers/gpu/drm/amd/amdgpu/df_v3_6.h    | 9 ---------
 3 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c
index 915c580d30be..0aef565acabf 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c
@@ -30,6 +30,7 @@
 #include "df_v3_6.h"
 
 #define PMU_NAME_SIZE 32
+#define NUM_EVENTS_DF_VEGA20	8
 
 /* record to keep track of pmu entry per pmu type per device */
 struct amdgpu_pmu_entry {
@@ -41,7 +42,6 @@ struct amdgpu_pmu_entry {
 
 static LIST_HEAD(amdgpu_pmu_list);
 
-
 /* initialize perf counter */
 static int amdgpu_perf_event_init(struct perf_event *event)
 {
@@ -210,7 +210,7 @@ static int init_pmu_by_type(struct amdgpu_device *adev,
 		  const struct attribute_group *attr_groups[],
 		  char *pmu_type_name, char *pmu_file_prefix,
 		  unsigned int pmu_perf_type,
-		  unsigned int num_counters)
+		  unsigned int num_events)
 {
 	char pmu_name[PMU_NAME_SIZE];
 	struct amdgpu_pmu_entry *pmu_entry;
@@ -246,7 +246,7 @@ static int init_pmu_by_type(struct amdgpu_device *adev,
 	}
 
 	pr_info("Detected AMDGPU %s Counters. # of Counters = %d.\n",
-			pmu_type_name, num_counters);
+			pmu_type_name, num_events);
 
 	list_add_tail(&pmu_entry->entry, &amdgpu_pmu_list);
 
@@ -263,7 +263,7 @@ int amdgpu_pmu_init(struct amdgpu_device *adev)
 		/* init df */
 		ret = init_pmu_by_type(adev, df_v3_6_attr_groups,
 				       "DF", "amdgpu_df", PERF_TYPE_AMDGPU_DF,
-				       DF_V3_6_MAX_COUNTERS);
+				       NUM_EVENTS_DF_VEGA20);
 
 		/* other pmu types go here*/
 		break;
diff --git a/drivers/gpu/drm/amd/amdgpu/df_v3_6.c b/drivers/gpu/drm/amd/amdgpu/df_v3_6.c
index 8dadcdcffba0..42937c474e46 100644
--- a/drivers/gpu/drm/amd/amdgpu/df_v3_6.c
+++ b/drivers/gpu/drm/amd/amdgpu/df_v3_6.c
@@ -30,6 +30,15 @@
 #define DF_3_6_SMN_REG_INST_DIST        0x8
 #define DF_3_6_INST_CNT                 8
 
+/* Defined in global_features.h as FTI_PERFMON_VISIBLE */
+#define DF_V3_6_MAX_COUNTERS		4
+
+/* get flags from df perfmon config */
+#define DF_V3_6_GET_EVENT(x)		(x & 0xFFUL)
+#define DF_V3_6_GET_INSTANCE(x)		((x >> 8) & 0xFFUL)
+#define DF_V3_6_GET_UNITMASK(x)		((x >> 16) & 0xFFUL)
+#define DF_V3_6_PERFMON_OVERFLOW	0xFFFFFFFFFFFFULL
+
 static u32 df_v3_6_channel_number[] = {1, 2, 0, 4, 0, 8, 0,
 				       16, 32, 0, 0, 0, 2, 4, 8};
 
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
