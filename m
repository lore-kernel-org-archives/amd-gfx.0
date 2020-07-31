Return-Path: <SRS0=+arJ=BK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8834EC433DF
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Jul 2020 02:45:09 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B6242083E
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Jul 2020 02:45:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="H/2M1v3R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B6242083E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EC5376E992;
	Fri, 31 Jul 2020 02:45:08 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2065.outbound.protection.outlook.com [40.107.243.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AA5746E992
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Jul 2020 02:45:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UmgAe54UiOWam3hd1JOyA/tT5Mzwh338nsnnzXUxbmp6wlfJDeEI88ve4dT0WV0c1JFw46PLxTE3B4R3tUoy99kTCXhHt4wcfNJssaLgjSdkX+JutHUG1lCH7bbeRJRPUUZc7Fd1qGtzksTfogIdQgoVPMDGFkbJ+ywj60BgiRv5kmi++AFXKYhyrXXZHoMfdPfZWF7HoT3u4imIJ3N3j+oJ42SX7GkMAhUI7IJs/U+hK72m5nICK3OeJEUSThq/9vutBZyMf7hNRtaHyT5LsLGukw27x+UUe5w0fZpI9guAYoblg2B4rizd6Od+txEd2MHzLcNZ3/w7U+oavbz7bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uAVi5R/A3keI8uZ1Jl3VH40nKctynq+6NfMHPQVuLs8=;
 b=MINXcZ2h8C57g6e2CD8KM6OiGsIN6GtIcyEoyOElIZ7EFT3sE3k4g29OhSVs7qV74mhBOmbD76rtrt36jNXMup1XlZV126RoeFcvFQlexE4ZquxxoNvCpjAr5Cngdh1cDKdUZf+I6sMa0pf3UrhfyF/mcSqW4HdoB6KiMXgG3wR9r/UXXHbWTTuMrT5Odjr8XVI1+rTNZlORtNXwtrdHLP5PI8R25yNwWDmaI+v5WcslAyqQ4x3C1SG0ej1vmdx12i7Z5si7vRlp82eCeqkMJFYceEpVDrz84kPmApCLhem2r4VIjPkagSslAnFZa4HiK3kwoEqZDmh+YbINApduvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uAVi5R/A3keI8uZ1Jl3VH40nKctynq+6NfMHPQVuLs8=;
 b=H/2M1v3R9jwXHt5GLbvFPyN/Z/WDkq7QrMYLNXPlDSYpUYyHM9HAucoiUSOSSbry54HdcpqdK0nBAG10cVN8Dk+O1VsP7l5nQHKM4i+GWPXgl3NoHdRK/NcBhhq+d+p1Fxb8dCVYE4VlzEIlcc+HWFxoPwRnuCmIH8IsBtAy5I0=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB2618.namprd12.prod.outlook.com (2603:10b6:5:49::24) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3239.17; Fri, 31 Jul 2020 02:45:05 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::fcd0:74a:b9d0:6b66]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::fcd0:74a:b9d0:6b66%2]) with mapi id 15.20.3239.018; Fri, 31 Jul 2020
 02:45:05 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 16/17] drm/amd/powerplay: add control method to bypass metrics
 cache on Vega20
Date: Fri, 31 Jul 2020 10:43:15 +0800
Message-Id: <20200731024316.28324-16-evan.quan@amd.com>
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
 15.20.3239.16 via Frontend Transport; Fri, 31 Jul 2020 02:45:03 +0000
X-Mailer: git-send-email 2.28.0
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 991f5739-bd90-4ecb-fe75-08d834fbbb39
X-MS-TrafficTypeDiagnostic: DM6PR12MB2618:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB26180E1C25295691BF4F9009E44E0@DM6PR12MB2618.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NktD7UmjmHBEEut4qB/+jBlJcIzF6+ljQX97BULE6JfDaJfPu1wiR5XFw087aZKPALZbk/6/IpChWZN6cTwDA/EyNvS36P7fBZgBqkzgkVcUGSGSiieaCUwV851PqMqgKet104MU7e1059KO3jXi8Vsuy7xo05EQAE6HiDLvMxt3zfR7dXJKOhwSli/PXtFZmIb0N57vDUKPLYppwmpCjkvHApQkJkz8xt6zDmYrxgT2GXHZ0tXXZaXgRSoKChh36vOY2wh7xrkHPnKIqWghEQiV6wiyn93FuJnm3WKC2KurjQVxV2ckAMwRZ9KRtFz+le547JmemRThKEituzLa6g==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39860400002)(396003)(346002)(366004)(136003)(376002)(8936002)(1076003)(478600001)(6486002)(26005)(83380400001)(6916009)(16526019)(36756003)(186003)(2906002)(5660300002)(66946007)(8676002)(956004)(2616005)(6666004)(4326008)(7696005)(316002)(86362001)(66556008)(52116002)(66476007)(44832011);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: PvVlrXN5w2b5KMyCwWycyPX681ZCE61fqs+Znvd2U0gH1eIqbGvE/JsBE7DDMp//Q+mQPol5e9B4r7VcFvp16OlPrME/f8ZnRRzFObFyU+ubkXuUcvRC4zIuF4LIndzkfOlwpa/ox+1L0cdu6t8eovSdj7UMFDD2oK5LL5Sm0ECGyAZ9FcjoEfQIuZO+Mk3UcPrrWG5mWwzCKAp9O5V22LdRFOIU6pLF/Rd0MHBt0Z/lpgisaDv54bujCWlpBeX/bH75hPErB1TkgThfjPpxUXTRsRGKBWe00SzvwZriy9IACAmM+z6Sle4410CZqDp8PT+5sB4zGo6qMLMQb0g6PkO3sloOwRnlU75VfJvwKJ2uLev2jZQFtmCEl/DiZZYhWpaHMveI4k7+4mvGlVZdj11UHTbF7Jz+dEXl1hDVXsxD8AmM2tmwoCepT1imeZacxfBfJfLBpSPLjtyK2kMkoWpy6/2ODpGZL075n31hgNZRVCCBq2xAbR1zRnhjRUP0yY7OHh7zNSqVmvE+sEfUGq30a3om8ogzDteStqYzTSJvrFOqKEP0c/IuLJ7diR/wNuf+mDbUPC/joceiIh3Wh99Nzn7UXh7thzNFjpTDfsNT0PnWfUmg5shJNFs/Af7boK4VQ51FSeHVtUQ3c120Fg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 991f5739-bd90-4ecb-fe75-08d834fbbb39
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2020 02:45:05.7289 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iEPaaq88cosE6CWN8q87QWWYEzflZvSy18OfzLjWTO+t6eEnA3CWa69ArRCebmp4
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

Change-Id: I8836f7f096dceb08a90dd3c899d2e9ccea1ef1f3
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 .../drm/amd/powerplay/hwmgr/vega20_hwmgr.c    | 31 ++++++++++++-------
 1 file changed, 19 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/vega20_hwmgr.c b/drivers/gpu/drm/amd/powerplay/hwmgr/vega20_hwmgr.c
index 037bebda2eae..86d3a10379be 100644
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
 
@@ -4283,7 +4290,7 @@ static ssize_t vega20_get_gpu_metrics(struct pp_hwmgr *hwmgr,
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
