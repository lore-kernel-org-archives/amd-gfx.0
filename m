Return-Path: <SRS0=+arJ=BK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C82FFC433DF
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Jul 2020 02:45:13 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9DB292083E
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Jul 2020 02:45:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="gccbFXqc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DB292083E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 67D216E993;
	Fri, 31 Jul 2020 02:45:13 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2054.outbound.protection.outlook.com [40.107.237.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8D2BB6E993
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Jul 2020 02:45:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lmRZaoXgbK2ke5CFu5sb35tAKAadLTdm8p9e2HFho+XIYiMTaHEUWYjEGO032Ql6EZ9BW2mTq4cABTaQ23Ju+pxS2PtAJT8CagJn+GkbXejePbL1Rd+7MLvDd3x0FUnAg2WHc2+MexNRFFMN015bNM5fGjJWPnNQOv8S3qj3N8vDZpU86bFEU/deTfv3/xbY2L+/VZhSFv6hVMBGC8QYQu3jIHnwyqJfJOE/cVxGJJtTGFgYYCaaGQM3W4xCoCaHOY/w6ETcD40UWCQWY7w1h1W8MGHB+1anc5crC5nAPDubKKow5TSR1d8zSAFOUPCaYtPCFAsBuLp36w54bk0b5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jEdzmGCHwX2fR62+imZKlSMx42UnY9+50/JsOHb3GrE=;
 b=l05jdAwl/rghzjeJ0tkwdRD8I8G+pLf7AH5fViGa3oeu+w3W/QqIzGLnpsGVdgp3HhV2aPSir9/tsVuirRfCUYveZI8r3X5jyK72bmqQHig9fSc2sxV/K69GqNxR5xDnhKUWitm59cfKz4MJ4fN76+LxPvN2GfLBrkEGM0+/ddbX/ZgeVcRwjE8tPchntZErGFA0Z5yGzZoRfyzdAhedI73ztOu3c2j+gj4uK0Q2CPBoHss6c9eeQvCnvBt1cvSxkRHyL4pQEwygfDdGV9Ikbhy0c3RHi38JFh3sWIF/3PjfEJzOykjtanaBpe3haF1mBBif1YYQ4Wm1fVByxpX2+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jEdzmGCHwX2fR62+imZKlSMx42UnY9+50/JsOHb3GrE=;
 b=gccbFXqcEA7w/rpPcgH8B64IMi9HcOrWbm1iUu0T9llt/2RF1eXjvht97Gehwr+EjsnmniidBNIDeTO6LX4QPXcm9LdDttD9+tOWazAn4r2RQN4wXrrZDQI7asCnUSh2u1Y3KaPKc/PARSuD/r7JBuBDLFRKs41URARK7tEFFk8=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB2618.namprd12.prod.outlook.com (2603:10b6:5:49::24) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3239.17; Fri, 31 Jul 2020 02:45:09 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::fcd0:74a:b9d0:6b66]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::fcd0:74a:b9d0:6b66%2]) with mapi id 15.20.3239.018; Fri, 31 Jul 2020
 02:45:09 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 17/17] drm/amd/powerplay: add control method to bypass metrics
 cache on Vega12
Date: Fri, 31 Jul 2020 10:43:16 +0800
Message-Id: <20200731024316.28324-17-evan.quan@amd.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200731024316.28324-1-evan.quan@amd.com>
References: <20200731024316.28324-1-evan.quan@amd.com>
X-ClientProxiedBy: HK2PR02CA0206.apcprd02.prod.outlook.com
 (2603:1096:201:20::18) To DM6PR12MB2619.namprd12.prod.outlook.com
 (2603:10b6:5:45::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from equan-buildpc.amd.com (58.247.170.242) by
 HK2PR02CA0206.apcprd02.prod.outlook.com (2603:1096:201:20::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3239.16 via Frontend Transport; Fri, 31 Jul 2020 02:45:07 +0000
X-Mailer: git-send-email 2.28.0
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 70e6c41a-780a-4651-f56b-08d834fbbd74
X-MS-TrafficTypeDiagnostic: DM6PR12MB2618:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB2618BA2EEF6062811EE68A4DE44E0@DM6PR12MB2618.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8loWedC9XCa4EKlZHV7tUV7YWWOX+muJ0IrBHJ+LSEBf/cAUh4W15XPuehX8qTkiZO+hNNDFuif2ZMkwCMOTyEADkBIo+M6qS1Rf1x1xKQ+faGvrJkhH4eRDaT7zuncbElU+ooFWmhXXLn2Nve2HhaF57aCZh6LqFBvmg5FFWorlSJaTBCHE4wz+tpPufKvVL4ijQ7LdzKwzym1u41TXd03sOS/DaSkNJPJSfUkRqoMhUoK535Axs8ymEVraqwABqYb5ZR4vsfqK3KQvqMmRpJV6L7pnVWsC+/XoK6u9Z5VpS6V8peGAOkR84tYtb14zBAdpUnpaFXKqI9ig9PGR2w==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39860400002)(396003)(346002)(366004)(136003)(376002)(8936002)(1076003)(478600001)(6486002)(26005)(83380400001)(6916009)(16526019)(36756003)(186003)(2906002)(5660300002)(66946007)(8676002)(956004)(2616005)(6666004)(4326008)(7696005)(316002)(86362001)(66556008)(52116002)(66476007)(44832011);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: F90wr/B4zLUnPYDNs7jYC+WKKD5FxZSuh8AUH3T9yprNshBitNJMR0Owhkngmn21F8ZyuIsMp37zSwN+54ps/sYtaW5C92j83uSSQOrSSO5YCjc+IC/gB/jxsz98N6W5ol52UiaHmqIH4RAIm8+wVfJuwdOa9YRZ+JR6Bi9ixGPiqf0nOyz17Tv+SqgQTdtBHf8QjQGTHrBvK0xQUlkxJgYpwsd2tFhb5wQ5SLp1DHNtyznOgLXUX1WUzpzT7K2TrWPYUYAJLnOfGYAEuQkYYDkuj1RZX5DW3qgTBWKZavYMOCScMKm86iaJ3lfsb9r5zHTBA540qxp5ec2Qqyr32OPUSyyguyaSXCfgikL/h1La/5rC3iQyy+4OeOsv3xI7MKj01rcamIeyoa+RtpHpMZsRoCPusFCfP9/RO+zThK/f63S3FC0smgPPl0kyB+B6AvuyqO328jZXwHwTgF3O4q/lSZJL7jsnHKKQG0YCmtbgTvMkYjhJIXa+L5PsGtUEATPrzxa5yDhASBWr0OzuhKH7L5Lr1SJLo1LTiyy/DsIBH4ZAKqpo+euDr3T0RqKLQeVARZx8uK6laPavgLTXTj3TEVpekQY4ZSIY1WsbmEk9KkfUQWw0wPbu3oOSx0sEt+X2SUm9PoFIUaG9LECbxw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70e6c41a-780a-4651-f56b-08d834fbbd74
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2020 02:45:09.4628 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yMatACYxjHYQBNBbyvLawonDgaBEp/D8/u7iFdimcIa3uHc/tGx34SWYiDHi4+KC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2618
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
Cc: alexander.deucher@amd.com, Felix.Kuehling@amd.com,
 Evan Quan <evan.quan@amd.com>, Harish.Kasiviswanathan@amd.com,
 nirmodas@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

As for the gpu metric export, metrics cache makes no sense. It's up to
user to decide how often the metrics should be retrieved.

Change-Id: Ic2a27ebc90f0a7cf581d0697c121b6d7df030f3b
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 .../drm/amd/powerplay/hwmgr/vega12_hwmgr.c    | 29 ++++++++++++-------
 1 file changed, 18 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/vega12_hwmgr.c b/drivers/gpu/drm/amd/powerplay/hwmgr/vega12_hwmgr.c
index 40bb0c2e4e8c..c70c30175801 100644
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/vega12_hwmgr.c
+++ b/drivers/gpu/drm/amd/powerplay/hwmgr/vega12_hwmgr.c
@@ -1262,22 +1262,29 @@ static uint32_t vega12_dpm_get_mclk(struct pp_hwmgr *hwmgr, bool low)
 	return (mem_clk * 100);
 }
 
-static int vega12_get_metrics_table(struct pp_hwmgr *hwmgr, SmuMetrics_t *metrics_table)
+static int vega12_get_metrics_table(struct pp_hwmgr *hwmgr,
+				    SmuMetrics_t *metrics_table,
+				    bool bypass_cache)
 {
 	struct vega12_hwmgr *data =
 			(struct vega12_hwmgr *)(hwmgr->backend);
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
@@ -1288,7 +1295,7 @@ static int vega12_get_gpu_power(struct pp_hwmgr *hwmgr, uint32_t *query)
 	SmuMetrics_t metrics_table;
 	int ret = 0;
 
-	ret = vega12_get_metrics_table(hwmgr, &metrics_table);
+	ret = vega12_get_metrics_table(hwmgr, &metrics_table, false);
 	if (ret)
 		return ret;
 
@@ -1339,7 +1346,7 @@ static int vega12_get_current_activity_percent(
 	SmuMetrics_t metrics_table;
 	int ret = 0;
 
-	ret = vega12_get_metrics_table(hwmgr, &metrics_table);
+	ret = vega12_get_metrics_table(hwmgr, &metrics_table, false);
 	if (ret)
 		return ret;
 
@@ -1387,7 +1394,7 @@ static int vega12_read_sensor(struct pp_hwmgr *hwmgr, int idx,
 		*size = 4;
 		break;
 	case AMDGPU_PP_SENSOR_HOTSPOT_TEMP:
-		ret = vega12_get_metrics_table(hwmgr, &metrics_table);
+		ret = vega12_get_metrics_table(hwmgr, &metrics_table, false);
 		if (ret)
 			return ret;
 
@@ -1396,7 +1403,7 @@ static int vega12_read_sensor(struct pp_hwmgr *hwmgr, int idx,
 		*size = 4;
 		break;
 	case AMDGPU_PP_SENSOR_MEM_TEMP:
-		ret = vega12_get_metrics_table(hwmgr, &metrics_table);
+		ret = vega12_get_metrics_table(hwmgr, &metrics_table, false);
 		if (ret)
 			return ret;
 
@@ -2752,7 +2759,7 @@ static ssize_t vega12_get_gpu_metrics(struct pp_hwmgr *hwmgr,
 	uint32_t fan_speed_rpm;
 	int ret;
 
-	ret = vega12_get_metrics_table(hwmgr, &metrics);
+	ret = vega12_get_metrics_table(hwmgr, &metrics, true);
 	if (ret)
 		return ret;
 
-- 
2.28.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
