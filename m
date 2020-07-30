Return-Path: <SRS0=EB5G=BJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6680C433E0
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Jul 2020 09:15:29 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D8D920656
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Jul 2020 09:15:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="vjFqrMDT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D8D920656
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6A70C6E8AA;
	Thu, 30 Jul 2020 09:15:29 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2057.outbound.protection.outlook.com [40.107.223.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3D1136E8AA
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Jul 2020 09:15:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JAb0E7cXCfxdEughtixWtHmPn0sQ6CZEXMFs5uFSpbi0h3R6/PaLo1B345JLVHE1Qox3x0swBPPk3iHIslk796XsqWCudSP7GgyRoCqCSqo0ZbB+V4n+ZxTw/NdSDPIHf0c1gzBKiBgPyASo5bePyAhKje7DfAtLU2c4sKbwVx2abI76cVOaVKmKfqy9USQtxNTvYBOP/QxuHFH+LMPWV1/dKk4s2Yq8I0SUY1hVNNfk7KOiyQirMlO6sR5cGz48bYZenB+lF22O3tAmbmYPP3fxtHbuY+EKFtac36zE/aAPiqXMClGT/xz8RQJ9az8Q3TbK6KdHZT3bpA1hfyU2Fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QDJUbcxLLjlM0yIeISKsmfIQJmOj3kh6hejUqcBhqmg=;
 b=PKdXQ2kP6s6u5HRpSsRdc6F+W8zUhWhP5Mlb3wuTg7rOdaqmMc71GSqfCrPEo5MPCuLzcZWyi4ISD0ghssaAO//STus+imf/sLarcJWlBzPS6NYoJDJsGWDSOwhiQBqnQtGyCHeQjNTqa1pN0gysevYJkGfbnrDCOfQCZ5Fx726SJr3TOoAYPx8JMMQRoUvM3Ea5C/VzjeECBimXeGBooYmQpiuHrip11kRd4zVBwK1cAIB6QDzu27PlKAHZp7gUwL5PGtRJiGY2p2JD0p1aSKxysHQJmrZ8eSEMgrtQJx2YZFCuSljb0AZzLxFdFEsA26Je3s8SQjIrEugpcjRp3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QDJUbcxLLjlM0yIeISKsmfIQJmOj3kh6hejUqcBhqmg=;
 b=vjFqrMDT0Mee7d5Sg7qJaJY+6VFbbw6KpDtFjzqTM2dONeLOCU/t82ExukL7aibkHivjpSstOx+d9nnOqFQbYW0iCuCoF+k1F4xbJOV2Xd+zC8CkAs0yi8Y7REi4Zwwck8nBqUo01DjdIIRNG8Rgfon2nfrP9nWZq2/mitNI3fw=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB4092.namprd12.prod.outlook.com (2603:10b6:5:214::14) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3239.16; Thu, 30 Jul 2020 09:15:27 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::fcd0:74a:b9d0:6b66]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::fcd0:74a:b9d0:6b66%2]) with mapi id 15.20.3239.018; Thu, 30 Jul 2020
 09:15:27 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 8/9] drm/amd/powerplay: add control method to bypass metrics
 cache on Vega20
Date: Thu, 30 Jul 2020 17:14:35 +0800
Message-Id: <20200730091436.4551-8-evan.quan@amd.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200730091436.4551-1-evan.quan@amd.com>
References: <20200730091436.4551-1-evan.quan@amd.com>
X-ClientProxiedBy: HK0PR01CA0052.apcprd01.prod.exchangelabs.com
 (2603:1096:203:a6::16) To DM6PR12MB2619.namprd12.prod.outlook.com
 (2603:10b6:5:45::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from equan-buildpc.amd.com (58.247.170.242) by
 HK0PR01CA0052.apcprd01.prod.exchangelabs.com (2603:1096:203:a6::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.16 via Frontend
 Transport; Thu, 30 Jul 2020 09:15:25 +0000
X-Mailer: git-send-email 2.28.0
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 3b99f7d7-3a73-4e02-986c-08d83469192a
X-MS-TrafficTypeDiagnostic: DM6PR12MB4092:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB4092087F07A9D419752173A9E4710@DM6PR12MB4092.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: b5lCnjNXsSLXJJ3vMqmyO4AtvzNTbGBvxslQKrJKORMlRKpcB33MHOGY9YVhrJ44W7YE3+FavLlTo0UxFw0LNB3A1u/Dob3a5wcFi3erwYNMKbnucWbdLJ1F6nhGRJEIQQzdWZRcctl5/mfryQkK7bAftKL2iK9m20tlfuFe7JCjO9RIQY8k7YAXkrZWtoMGEmAp8lQ7l8vQw2tlXPJy/Bkei0sAlcaEcrYGBbUjP7BV79CEmjAPYmGxMqCm4g856a56VPZmkZ+l8kxBBw8bZfY9AJ9L+n+6ddS9K3ARuYvggUj6gQ3uYNGVUoo1HXzReTkoTfLmiKsAnCYFZoLsfA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(376002)(39860400002)(346002)(136003)(396003)(16526019)(5660300002)(478600001)(4326008)(186003)(26005)(6916009)(44832011)(6666004)(316002)(6486002)(66946007)(66476007)(66556008)(7696005)(86362001)(1076003)(83380400001)(2906002)(8936002)(956004)(2616005)(8676002)(52116002)(36756003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: ZJeA/N2iGgXCGfvYLHHh8WnqqzoR0M5tpQqe0qSownkHczzkRGWhVo/S61mJjXGufld8stZHm//xfqUB5TwzWJGEg27rM6u9zBL3M5ZOjaG0UtHZWn1Y/u/1SKn/Al2hr4AOXlif1rip3m+90eI9wWDdr2eABD0/zmdvzTdHqIQkYHLaKkqZqODgqhrVKFT88iiXlCtXajcBab93seS8G9jn2+UXMIxxoaAhvnGT1CYXl9+uOdXYA9nADFihF3zsC+aesWWWkEXiea0ipR0UnEzXl+mK2IN0svQBQ/B0OkQ9hlxS9EgM3SxKkCNsQdLRY2MOMNdSH/EvJzoW0zY5QHkcNzeaUyxtzOARkUC23STPCAr0p83+1B3fHBc04Qor+90sID3LW4DOQZsM38V8AbkcTG3WiwhG8FOm9KvEWx37Lx7aY6VeytGrJQ7dDJq6ELdMIJ/nQU0xNDbTYwuKixsgx2z9FpySfmNY3nhslnJR4fqWuU6CJVQ5etFXveiSxn/mM8oKAkMIl6Tb50T6e6oQzddmymeBZaXvUkxwZM9DuBEz8IzJa5wbCrD+yB/uIwQOqDtdpES0Qh07vA4dY3pxfVoTYDUsE8srKCvE6aEasjb41VBSXHuzJ7EELFHoo0ZgIWc5f1nvLYUub9qVKA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b99f7d7-3a73-4e02-986c-08d83469192a
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2020 09:15:27.3666 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q8iFqJXVmoATUss6uSGU//DP+0YakfAxPOjQJvLRTx78delRtYn23Zooq9DT5Q2z
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4092
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
Cc: alexander.deucher@amd.com, Evan Quan <evan.quan@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

As for the gpu metric export, metrics cache makes no sense. It's up to
user to decide how often the metrics should be retrieved.

Change-Id: I8836f7f096dceb08a90dd3c899d2e9ccea1ef1f3
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 .../drm/amd/powerplay/hwmgr/vega20_hwmgr.c    | 31 ++++++++++++-------
 1 file changed, 19 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/vega20_hwmgr.c b/drivers/gpu/drm/amd/powerplay/hwmgr/vega20_hwmgr.c
index 77de8d88ae3a..f2f69ea5b695 100644
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/vega20_hwmgr.c
+++ b/drivers/gpu/drm/amd/powerplay/hwmgr/vega20_hwmgr.c
@@ -2090,22 +2090,29 @@ static uint32_t vega20_dpm_get_mclk(struct pp_hwmgr *hwmgr, bool low)
 	return (mem_clk * 100);
 }
 
-static int vega20_get_metrics_table(struct pp_hwmgr *hwmgr, SmuMetrics_t *metrics_table)
+static int vega20_get_metrics_table(struct pp_hwmgr *hwmgr,
+				    SmuMetrics_t *metrics_table,
+				    bool bypass_cache)
 {
 	struct vega20_hwmgr *data =
 			(struct vega20_hwmgr *)(hwmgr->backend);
 	int ret = 0;
 
-	if (!data->metrics_time || time_after(jiffies, data->metrics_time + HZ / 2)) {
-		ret = smum_smc_table_manager(hwmgr, (uint8_t *)metrics_table,
-				TABLE_SMU_METRICS, true);
+	if (bypass_cache ||
+	    !data->metrics_time ||
+	    time_after(jiffies, data->metrics_time + HZ / 2)) {
+		ret = smum_smc_table_manager(hwmgr,
+					     (uint8_t *)(&data->metrics_table),
+					     TABLE_SMU_METRICS,
+					     true);
 		if (ret) {
 			pr_info("Failed to export SMU metrics table!\n");
 			return ret;
 		}
-		memcpy(&data->metrics_table, metrics_table, sizeof(SmuMetrics_t));
 		data->metrics_time = jiffies;
-	} else
+	}
+
+	if (metrics_table)
 		memcpy(metrics_table, &data->metrics_table, sizeof(SmuMetrics_t));
 
 	return ret;
@@ -2117,7 +2124,7 @@ static int vega20_get_gpu_power(struct pp_hwmgr *hwmgr,
 	int ret = 0;
 	SmuMetrics_t metrics_table;
 
-	ret = vega20_get_metrics_table(hwmgr, &metrics_table);
+	ret = vega20_get_metrics_table(hwmgr, &metrics_table, false);
 	if (ret)
 		return ret;
 
@@ -2155,7 +2162,7 @@ static int vega20_get_current_activity_percent(struct pp_hwmgr *hwmgr,
 	int ret = 0;
 	SmuMetrics_t metrics_table;
 
-	ret = vega20_get_metrics_table(hwmgr, &metrics_table);
+	ret = vega20_get_metrics_table(hwmgr, &metrics_table, false);
 	if (ret)
 		return ret;
 
@@ -2185,7 +2192,7 @@ static int vega20_read_sensor(struct pp_hwmgr *hwmgr, int idx,
 
 	switch (idx) {
 	case AMDGPU_PP_SENSOR_GFX_SCLK:
-		ret = vega20_get_metrics_table(hwmgr, &metrics_table);
+		ret = vega20_get_metrics_table(hwmgr, &metrics_table, false);
 		if (ret)
 			return ret;
 
@@ -2210,7 +2217,7 @@ static int vega20_read_sensor(struct pp_hwmgr *hwmgr, int idx,
 		*size = 4;
 		break;
 	case AMDGPU_PP_SENSOR_EDGE_TEMP:
-		ret = vega20_get_metrics_table(hwmgr, &metrics_table);
+		ret = vega20_get_metrics_table(hwmgr, &metrics_table, false);
 		if (ret)
 			return ret;
 
@@ -2219,7 +2226,7 @@ static int vega20_read_sensor(struct pp_hwmgr *hwmgr, int idx,
 		*size = 4;
 		break;
 	case AMDGPU_PP_SENSOR_MEM_TEMP:
-		ret = vega20_get_metrics_table(hwmgr, &metrics_table);
+		ret = vega20_get_metrics_table(hwmgr, &metrics_table, false);
 		if (ret)
 			return ret;
 
@@ -4281,7 +4288,7 @@ static ssize_t vega20_get_gpu_metrics(struct pp_hwmgr *hwmgr,
 	uint32_t fan_speed_rpm;
 	int ret;
 
-	ret = vega20_get_metrics_table(hwmgr, &metrics);
+	ret = vega20_get_metrics_table(hwmgr, &metrics, true);
 	if (ret)
 		return ret;
 
-- 
2.28.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
