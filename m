Return-Path: <SRS0=uqvu=KN=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D292C43460
	for <amd-gfx@archiver.kernel.org>; Tue, 18 May 2021 04:10:23 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F79360C3E
	for <amd-gfx@archiver.kernel.org>; Tue, 18 May 2021 04:10:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F79360C3E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4873D6E04A;
	Tue, 18 May 2021 04:10:21 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2071.outbound.protection.outlook.com [40.107.236.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C03716E5B9
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 May 2021 04:10:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BwhDT708ULKtoV3zZ/W1UemaWZLveZhijVH30wQQu2W68R0+L5ewdi7hE6YRufPv/G8N+ipYQrtTYGoKVjS0V+vqf00biO0+u38YDc3sN50dos3X6QwWfEphJSVc4B4+onuLtv7FxytRu3WMTFXRhxCTyuZfxxOCgDJMis/04I9CY7eEQM0vHQMfBZgXFGTodIiGGd0RmDLDB2WHijXlFBkUDc/O+DMY+RwspSj1K71t5B9FAwsRRVF+8lAtpbUZX3uq0/3I+7WobD3HbaLkYX1GUXMowMAI95yuN4hvE+du42afrdaANQP9gWH4gW0WRSMlJCIBhzd//pIKvgDS5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hjiQUJHZe3WoIUUWCVojN2wfbqHpvvu4DKGQsMFm6Sw=;
 b=OZdkDDKIHIU4bPOLd/vt0oDXLcO45k4TJbmpOJ2QsLeeUmmu7LeGcHc5uHOgdnTiRh1+bnE1KyQZjPPyX7O2nTDrjK/rG/CJTUsHD+7jXaRcjVx98Pp1DCLqMoz/VOe7qdw0TLmmM+zAWTnkTKF+WAG5T7DMRedfcedGX442EOQ3+4KylXNW1fdShCKiq16Z1hgSqiJC4PXDtJExfCHNbZIl4hnazAI94Wzj8V/tkN7WORxIgO9P7Wt21RIvfaCjfjE4qhl61vBAlmywscr5YkawianFKp4WpGGdJLeteEicSO5o5OcuISLqB55ysmJycqNH+ZNYPbO+RCrrJDGtGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hjiQUJHZe3WoIUUWCVojN2wfbqHpvvu4DKGQsMFm6Sw=;
 b=l90MrG97TfFvKt44juO50ze+eXGSnUOwYog1k1A5TyoQWLU4Yg8e6gOTG6Fnnk54KS5+zmqFXrV/ppaym2Iw34M1Gm2NkG9OyN9DB91FNIVUCZzxWiVKeahqzfdlXlGgNUbja5HyrCg683fe7RgB5rpLPHB46P1cvPJ0zfZVqQs=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB2840.namprd12.prod.outlook.com (2603:10b6:a03:62::32)
 by BYAPR12MB2981.namprd12.prod.outlook.com (2603:10b6:a03:de::26)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.25; Tue, 18 May
 2021 04:10:12 +0000
Received: from BYAPR12MB2840.namprd12.prod.outlook.com
 ([fe80::7c65:7181:6d1d:8616]) by BYAPR12MB2840.namprd12.prod.outlook.com
 ([fe80::7c65:7181:6d1d:8616%7]) with mapi id 15.20.4129.031; Tue, 18 May 2021
 04:10:12 +0000
From: David M Nieto <david.nieto@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/3] drm/amdgpu/pm: add new fields for Navi1x
Date: Mon, 17 May 2021 21:09:56 -0700
Message-Id: <20210518040957.23266-2-david.nieto@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210518040957.23266-1-david.nieto@amd.com>
References: <CH0PR12MB534810EC2A9AB95FBF09E06B972D9@CH0PR12MB5348.namprd12.prod.outlook.com>
 <20210518040957.23266-1-david.nieto@amd.com>
X-Originating-IP: [165.204.53.123]
X-ClientProxiedBy: SJ0PR03CA0223.namprd03.prod.outlook.com
 (2603:10b6:a03:39f::18) To BYAPR12MB2840.namprd12.prod.outlook.com
 (2603:10b6:a03:62::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from loud-cracker.amd.com (165.204.53.123) by
 SJ0PR03CA0223.namprd03.prod.outlook.com (2603:10b6:a03:39f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25 via Frontend
 Transport; Tue, 18 May 2021 04:10:11 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 918e2d6d-31ce-4445-433f-08d919b2d4e0
X-MS-TrafficTypeDiagnostic: BYAPR12MB2981:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR12MB2981B1C3B2ADDE53C4C77055F42C9@BYAPR12MB2981.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1060;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yh7T1JG64KKKURmVGAqCp8CU8+Jt03GRfuI0tgQ/o/0JZk+/Z/eCNqNZBeANCcbVCvjHE0lVOIuBd7W5LtSBq8OAhpCoyu2CksOcoPFbXh3Q22QoEz4VXggXXi/y177Hg/4Z6Jnpa2KdsNgTHEbpS4o8/wRKrNUteJ3/22jf5LteMsW+IQJ9xIHSOUT5ICzN3FekR2Y/5QYUHslI9fmhIBk33RoVfQC9pyKyyBmoCyTCYpaGq4uOjLWMsyljkDrN+oCOcrLfuHKpY4fzK5n14qmfQ4+mxa7gwtl3XGLym/nHJMUvVtXttdXyjMdY+/4fGjSmyjdL6S0wFm+IdTQD7yrrx8Xhv4sUCVhiUqqJtUmhDk/LHVJH1HucUF4Jf/aMudISFW5+21qk2ULZ4vaIXcJDJIlErkEmc/6EpGkYj6yFWvnkCp2mVUBBSv9gcyFjYqPdUMN+C8B2e15/bQ5dlk7vGO+qiJqipCVFXX/x7bowUkCAINb+WMJi44I+y+F+3JzTl1du4n4+SXLeag6pqQGxdNCBEORAVlOwyCgGzipHP0nEaCfpTcYKnq3eV7iopBD3XhgUxuHjN9MZpk5FMTxaT6NJSTB7OZpxUwZVhUpUqeWHAgMGhnXCxoaD87t1s3/5CWlvxALYgNNKG3AR7vXv1CggSqcWQMtMn/p4Gl+Ahzrshdq1EIz3fWYx1wi4
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB2840.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(136003)(376002)(39860400002)(346002)(366004)(83380400001)(6666004)(6486002)(8936002)(8676002)(38350700002)(4326008)(38100700002)(2616005)(956004)(19627235002)(1076003)(66476007)(66946007)(66556008)(52116002)(316002)(5660300002)(7696005)(36756003)(6916009)(478600001)(186003)(16526019)(2906002)(86362001)(26005)(32563001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?0smRUlA2j0U2SfoqBEqRw84WqB+Pd+obA4bBkFfJ7dameJNs1oWg3bwbLHTJ?=
 =?us-ascii?Q?9f3H+TVdjG5dMlJvdv3hvr58JWI5GXY3vy3TNubt04ulYfnLOa8SdjLqz8iW?=
 =?us-ascii?Q?mM18S6B2QGgcbahuF6lwOy1WcwTVau15HcKmmHEwjKEuRLDhWnjim+3NSTGC?=
 =?us-ascii?Q?Aqg8BuCEstP9Rm5IomQYYB0G9V9LuL9Ov+u5w/+JB43vTiVvVzHPsLgb+Jpc?=
 =?us-ascii?Q?oHAW7H3+z6zfWA3oVcAUhWtKJfVT7E3a2F4dcPgv9vkBN1Nw9wcL/VlIkcZk?=
 =?us-ascii?Q?JwVuIgT1zczmzkRxMZZENqtKI+kzvpFs2c/gvOksvnsKd4LwTDbM21x+A4sV?=
 =?us-ascii?Q?F8z9J1DUIqeAbuhX/Ww9VhnnWXMcnThOAZBBa0Fp/1odYfR/J1WvFb6y9yJG?=
 =?us-ascii?Q?rWWAQeAAhnzDQlz6Kz7pyoP4WKDY4dKde1Sms1StsmdxZNUejIwCVJn7e/Ni?=
 =?us-ascii?Q?NX9OSePdaNvnrS9X0UeP5Jr13I5e4yYQ+mb3OtHVK8NYMhkOhYu1RNHz9q/r?=
 =?us-ascii?Q?NEHf4zd0eHzRjTa7vdHwRqIaQmSVXEFFTH74G+pYuK3yKNy5mkaPQyiXT+eZ?=
 =?us-ascii?Q?Vb+aZKrIsn3ySrdqtArqBNTAt75XKf3tLcH2gzcGC6t2aW94AhCogUXSxIA+?=
 =?us-ascii?Q?ab72CZLVf0ZQTpGwVMqnLhDSFG/imST2R1blmrhqkYruvhw3db4sBHjlgO/4?=
 =?us-ascii?Q?pQxTm8iR5vmJEtTCBhMSsM+mtg3eZXdCM0jhrO0myVkUvkTPgmeVpDH2FKWu?=
 =?us-ascii?Q?z6naTwaXhXxOhGGT3NTVxP3dimQFwqWA02Jfx15B8puHIZp+CSXqebeDWkz/?=
 =?us-ascii?Q?vpA+U+VkV/UoQFVR8oKSwktZJWj3WMBDCQU4Jb4hoEB1QqzwgJpZZrsoMO9x?=
 =?us-ascii?Q?9KFsul4JcBkq0iWntO5leQlTlO0pq1WuUhD6qVZMRhDRTWn3TESRbRa+H6zi?=
 =?us-ascii?Q?UCCgWesTCDADD/nG/Zh/GEl6QJVL5Vk84M2t/NcaqShX6gm9yfJbw8JLTfDI?=
 =?us-ascii?Q?z/oQU5qULOdpOs++Vv7lQgiMFshjJSh3PSimlj8kKEPEnnZCNwgY5whdMTVA?=
 =?us-ascii?Q?ePeM4jEpJVQkJY6TdE9p/2bw6nXSCOy0eX7uYYH8g6+AnrVGY6SItMhFcZh2?=
 =?us-ascii?Q?mm2/m84UrpEtRUjix/948B9azSfrckicy7wHGttaCvgPBmsshS6FpatNOWlb?=
 =?us-ascii?Q?tlbKeCMAtO9wydVNJ4Xdxj4R75BOsUPBtyo2Fd4knPiruxxy85Rm8/Bd4c3Z?=
 =?us-ascii?Q?tECHbDq+gGbNQ5Ny6rY+QrxBLcWyHXx5vPIScnlfo+Ma+AYiTixooKSolpJj?=
 =?us-ascii?Q?QW+7tEtczhQcZq9CYMJuXsXA?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 918e2d6d-31ce-4445-433f-08d919b2d4e0
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2840.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2021 04:10:11.7904 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f3EOc4tkxHIRluQn97BKh2K6ZD62NSiu9GTMMfQb/LCxg5MyD50x64bDTqeKD8SS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2981
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
Cc: David M Nieto <david.nieto@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Fill voltage fields in metrics table

Signed-off-by: David M Nieto <david.nieto@amd.com>
---
 .../gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c   | 62 ++++++++++++++-----
 1 file changed, 45 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
index ac13042672ea..9339fd24ae8c 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
@@ -505,7 +505,7 @@ static int navi10_tables_init(struct smu_context *smu)
 		goto err0_out;
 	smu_table->metrics_time = 0;
 
-	smu_table->gpu_metrics_table_size = sizeof(struct gpu_metrics_v1_1);
+	smu_table->gpu_metrics_table_size = sizeof(struct gpu_metrics_v1_3);
 	smu_table->gpu_metrics_table = kzalloc(smu_table->gpu_metrics_table_size, GFP_KERNEL);
 	if (!smu_table->gpu_metrics_table)
 		goto err1_out;
@@ -2627,10 +2627,11 @@ static ssize_t navi10_get_legacy_gpu_metrics(struct smu_context *smu,
 					     void **table)
 {
 	struct smu_table_context *smu_table = &smu->smu_table;
-	struct gpu_metrics_v1_1 *gpu_metrics =
-		(struct gpu_metrics_v1_1 *)smu_table->gpu_metrics_table;
+	struct gpu_metrics_v1_3 *gpu_metrics =
+		(struct gpu_metrics_v1_3 *)smu_table->gpu_metrics_table;
 	SmuMetrics_legacy_t metrics;
 	int ret = 0;
+	int freq = 0, dpm = 0;
 
 	mutex_lock(&smu->metrics_lock);
 
@@ -2646,7 +2647,7 @@ static ssize_t navi10_get_legacy_gpu_metrics(struct smu_context *smu,
 
 	mutex_unlock(&smu->metrics_lock);
 
-	smu_cmn_init_soft_gpu_metrics(gpu_metrics, 1, 1);
+	smu_cmn_init_soft_gpu_metrics(gpu_metrics, 1, 3);
 
 	gpu_metrics->temperature_edge = metrics.TemperatureEdge;
 	gpu_metrics->temperature_hotspot = metrics.TemperatureHotspot;
@@ -2681,19 +2682,26 @@ static ssize_t navi10_get_legacy_gpu_metrics(struct smu_context *smu,
 
 	gpu_metrics->system_clock_counter = ktime_get_boottime_ns();
 
+	gpu_metrics->voltage_gfx = (155000 - 625 * metrics.CurrGfxVoltageOffset) / 100;
+	gpu_metrics->voltage_mem = (155000 - 625 * metrics.CurrMemVidOffset) / 100;
+	gpu_metrics->voltage_soc = (155000 - 625 * metrics.CurrSocVoltageOffset) / 100;
+
 	*table = (void *)gpu_metrics;
 
-	return sizeof(struct gpu_metrics_v1_1);
+	return sizeof(struct gpu_metrics_v1_3);
+out:
+	return ret;
 }
 
 static ssize_t navi10_get_gpu_metrics(struct smu_context *smu,
 				      void **table)
 {
 	struct smu_table_context *smu_table = &smu->smu_table;
-	struct gpu_metrics_v1_1 *gpu_metrics =
-		(struct gpu_metrics_v1_1 *)smu_table->gpu_metrics_table;
+	struct gpu_metrics_v1_3 *gpu_metrics =
+		(struct gpu_metrics_v1_3 *)smu_table->gpu_metrics_table;
 	SmuMetrics_t metrics;
 	int ret = 0;
+	int freq = 0, dpm = 0;
 
 	mutex_lock(&smu->metrics_lock);
 
@@ -2709,7 +2717,7 @@ static ssize_t navi10_get_gpu_metrics(struct smu_context *smu,
 
 	mutex_unlock(&smu->metrics_lock);
 
-	smu_cmn_init_soft_gpu_metrics(gpu_metrics, 1, 1);
+	smu_cmn_init_soft_gpu_metrics(gpu_metrics, 1, 3);
 
 	gpu_metrics->temperature_edge = metrics.TemperatureEdge;
 	gpu_metrics->temperature_hotspot = metrics.TemperatureHotspot;
@@ -2746,19 +2754,26 @@ static ssize_t navi10_get_gpu_metrics(struct smu_context *smu,
 
 	gpu_metrics->system_clock_counter = ktime_get_boottime_ns();
 
+	gpu_metrics->voltage_gfx = (155000 - 625 * metrics.CurrGfxVoltageOffset) / 100;
+	gpu_metrics->voltage_mem = (155000 - 625 * metrics.CurrMemVidOffset) / 100;
+	gpu_metrics->voltage_soc = (155000 - 625 * metrics.CurrSocVoltageOffset) / 100;
+
 	*table = (void *)gpu_metrics;
 
-	return sizeof(struct gpu_metrics_v1_1);
+	return sizeof(struct gpu_metrics_v1_3);
+out:
+	return ret;
 }
 
 static ssize_t navi12_get_legacy_gpu_metrics(struct smu_context *smu,
 					     void **table)
 {
 	struct smu_table_context *smu_table = &smu->smu_table;
-	struct gpu_metrics_v1_1 *gpu_metrics =
-		(struct gpu_metrics_v1_1 *)smu_table->gpu_metrics_table;
+	struct gpu_metrics_v1_3 *gpu_metrics =
+		(struct gpu_metrics_v1_3 *)smu_table->gpu_metrics_table;
 	SmuMetrics_NV12_legacy_t metrics;
 	int ret = 0;
+	int freq = 0, dpm = 0;
 
 	mutex_lock(&smu->metrics_lock);
 
@@ -2774,7 +2789,7 @@ static ssize_t navi12_get_legacy_gpu_metrics(struct smu_context *smu,
 
 	mutex_unlock(&smu->metrics_lock);
 
-	smu_cmn_init_soft_gpu_metrics(gpu_metrics, 1, 1);
+	smu_cmn_init_soft_gpu_metrics(gpu_metrics, 1, 3);
 
 	gpu_metrics->temperature_edge = metrics.TemperatureEdge;
 	gpu_metrics->temperature_hotspot = metrics.TemperatureHotspot;
@@ -2814,19 +2829,26 @@ static ssize_t navi12_get_legacy_gpu_metrics(struct smu_context *smu,
 
 	gpu_metrics->system_clock_counter = ktime_get_boottime_ns();
 
+	gpu_metrics->voltage_gfx = (155000 - 625 * metrics.CurrGfxVoltageOffset) / 100;
+	gpu_metrics->voltage_mem = (155000 - 625 * metrics.CurrMemVidOffset) / 100;
+	gpu_metrics->voltage_soc = (155000 - 625 * metrics.CurrSocVoltageOffset) / 100;
+
 	*table = (void *)gpu_metrics;
 
-	return sizeof(struct gpu_metrics_v1_1);
+	return sizeof(struct gpu_metrics_v1_3);
+out:
+	return ret;
 }
 
 static ssize_t navi12_get_gpu_metrics(struct smu_context *smu,
 				      void **table)
 {
 	struct smu_table_context *smu_table = &smu->smu_table;
-	struct gpu_metrics_v1_1 *gpu_metrics =
-		(struct gpu_metrics_v1_1 *)smu_table->gpu_metrics_table;
+	struct gpu_metrics_v1_3 *gpu_metrics =
+		(struct gpu_metrics_v1_3 *)smu_table->gpu_metrics_table;
 	SmuMetrics_NV12_t metrics;
 	int ret = 0;
+	int freq = 0, dpm = 0;
 
 	mutex_lock(&smu->metrics_lock);
 
@@ -2842,7 +2864,7 @@ static ssize_t navi12_get_gpu_metrics(struct smu_context *smu,
 
 	mutex_unlock(&smu->metrics_lock);
 
-	smu_cmn_init_soft_gpu_metrics(gpu_metrics, 1, 1);
+	smu_cmn_init_soft_gpu_metrics(gpu_metrics, 1, 3);
 
 	gpu_metrics->temperature_edge = metrics.TemperatureEdge;
 	gpu_metrics->temperature_hotspot = metrics.TemperatureHotspot;
@@ -2884,9 +2906,15 @@ static ssize_t navi12_get_gpu_metrics(struct smu_context *smu,
 
 	gpu_metrics->system_clock_counter = ktime_get_boottime_ns();
 
+	gpu_metrics->voltage_gfx = (155000 - 625 * metrics.CurrGfxVoltageOffset) / 100;
+	gpu_metrics->voltage_mem = (155000 - 625 * metrics.CurrMemVidOffset) / 100;
+	gpu_metrics->voltage_soc = (155000 - 625 * metrics.CurrSocVoltageOffset) / 100;
+
 	*table = (void *)gpu_metrics;
 
-	return sizeof(struct gpu_metrics_v1_1);
+	return sizeof(struct gpu_metrics_v1_3);
+out:
+	return ret;
 }
 
 static ssize_t navi1x_get_gpu_metrics(struct smu_context *smu,
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
