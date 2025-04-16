Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCA26C369B1
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Apr 2025 05:32:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 674B410E82E;
	Wed, 16 Apr 2025 05:32:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="YGyIwIi6";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2065.outbound.protection.outlook.com [40.107.95.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D354510E82D
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Apr 2025 05:31:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pX70I+GzcBT77QCGM5SkTIvpiqCLremEsi3rHFChJ3RPdzVPlP214/piL430g4P5QSaeVrz/JixYM9NjBXqvHikQ1IbcYbHS9WRhJLng7rS3tEQrhIt/416f0r76XMVdlfecry7bLL2l6vmUe+Av0sAAY8xZDujaKVsZ59gKPsH22IDoGVi50g8Hnlm1AvhHhJ+8EqNrGtCfOGGQzjVaUqZ0oidlYB442S69fVqgV12Y40RYiPAj89yXqpBUWE3e0+9Kvt8ykm6/zF9ynJ7S195IpxsXIrJ2gFF41vm6jGSeMb5fMnM/NzQ3AXQ4MAg158QNS+dY2QM5C2xBnskxWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qbPClgpPty9KezVrs2c29xDigHYxk9sFN3JaBC/hGuM=;
 b=cCNOSa+VixmoUu4dL0XU+c3VBhs1PZhxqsy7XeVkyKsD21rf+Od3RtQD7iMf8pd7SzcBpw55XdVJnz30sTimsC0E7E+qZnmAytviD/EvyhMY5CGuAYF50V/XmmGyWCsi5rNfh6Ef+r0Zd2q9tZA8eYYVyje2BAJL5aLtqoIVLuwqwR0HZyXqnPvPb3JWD0CJ2UIdZ+gq1DjCtW6tjBQx0dfMDPJhu+N2GdTsBLAxUOIo7Km3d9TXVo878ReuF6CkbDQ5lWKWgtbWUlTVAoWCGE0IXS+QY5ftbGbgnKvxBBtJhPkoNI7Kzq2xBRPmavqQPOKoIrcTeVFdVhBHZzMMqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qbPClgpPty9KezVrs2c29xDigHYxk9sFN3JaBC/hGuM=;
 b=YGyIwIi6pypU/QVYvLvsprL1ugHtcNh1XbmYnTfTM52ocB6ouMd+sRgcGIE/72lIIqMshUzvnogDhNWvbzNLD9O4+WCqhTzq/ISuvj7dbbQnZCp/PVq2QnoTNj+ovL8ie8DKLlCidRh5x7iHCS6tDNAvL/iuMkb8AqoNSbXpeEo=
Received: from MW4P222CA0024.NAMP222.PROD.OUTLOOK.COM (2603:10b6:303:114::29)
 by DM6PR12MB4388.namprd12.prod.outlook.com (2603:10b6:5:2a9::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.34; Wed, 16 Apr
 2025 05:31:54 +0000
Received: from SJ1PEPF0000231D.namprd03.prod.outlook.com
 (2603:10b6:303:114:cafe::33) by MW4P222CA0024.outlook.office365.com
 (2603:10b6:303:114::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.15 via Frontend Transport; Wed,
 16 Apr 2025 05:31:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF0000231D.mail.protection.outlook.com (10.167.242.234) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Wed, 16 Apr 2025 05:31:53 +0000
Received: from asad-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 16 Apr
 2025 00:31:50 -0500
From: Asad Kamal <asad.kamal@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <lijo.lazar@amd.com>
CC: <hawking.zhang@amd.com>, <le.ma@amd.com>, <shiwu.zhang@amd.com>,
 <asad.kamal@amd.com>, <alexander.deucher@amd.com>
Subject: [PATCH v2 5/7] drm/amd/pm: Fill static metrics data
Date: Wed, 16 Apr 2025 13:31:25 +0800
Message-ID: <20250416053127.377955-5-asad.kamal@amd.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20250416053127.377955-1-asad.kamal@amd.com>
References: <20250416053127.377955-1-asad.kamal@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231D:EE_|DM6PR12MB4388:EE_
X-MS-Office365-Filtering-Correlation-Id: bebdc7d8-0d70-49e8-8462-08dd7ca7fec9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?PW+tCcMZmoAETW1772ctSvubKdYB2w0Ed+wNMiIQleeLyythLi1DKRB6vauR?=
 =?us-ascii?Q?8bkICyjLvO3RNhKEmOKrrwiSISuso9J0FAnuq2QRMij315FX7TQ1pAtbNjuX?=
 =?us-ascii?Q?5Tpk0ZR493YJSZRzgYam5WdTJ7CHvTagJX/stC3cOt41QDBZIQA5KazWmbq0?=
 =?us-ascii?Q?H+gTYmKWZFcJp5Ht3bo9rM4y/RkKgLsaoQKEfJBGQVs6MFHxkGiaeLLYesiW?=
 =?us-ascii?Q?iUSHmt/IqoGDrOnW84eKmFR+zYkw77nyTIuFq1ZIaiWMnAxlWpiAvpuDjEhg?=
 =?us-ascii?Q?34+7QBKpldCJxVjDv8I4IdQmbaiJD+cSxVoeAh97BOqHQHTIBBc89prlkkT+?=
 =?us-ascii?Q?yf0bPJrv1BtdFBNpaXfvvoqdI8WDK0wOyMGuPbJZaeAUiPb7eMOtwYJSF8aK?=
 =?us-ascii?Q?YJf5dXDMspr5sFE21u33u/URPQf2essBxSjKB8IBl4QbZs0jf+6+or7VOFIf?=
 =?us-ascii?Q?6ttpEQRoAENs5Vf8ZJjlE4qlWEJMqmi9HmUMIOTtQE6xL17p1t4rcgDMOkei?=
 =?us-ascii?Q?K/yVWmt356PAetZJAzyyTM7EIB+YhWL8qMka5sMpwP49ZExoKtszQYdLKVYI?=
 =?us-ascii?Q?ve44FRvEEvowNxRRdnCBQajSGH2AMw9xtfKBvIbt8t+Ev5ee6wUlaOP/eTxl?=
 =?us-ascii?Q?Evmy1bWCPXw27gxh/DtFPvrIvXD3pNnrisnyfmbqyhALpUtOVFRe99nH9eLC?=
 =?us-ascii?Q?rT5RgIZwc+EH2XYGGhjRow8+FaijJXZes7kFF8OkuVZQjswT69tDTCxbeK3b?=
 =?us-ascii?Q?2JnY5wmYo0Y2fwjnLs6iRWV0LfID39yVRVDHXX2jIh24DR7dXW2QLT9Gbw90?=
 =?us-ascii?Q?gnOQG2Ib+V82rL9t6cT3jt83bYSAz+LZ15oCAVU1vSVKjAHP4z27j74nipuS?=
 =?us-ascii?Q?BbZZtSpQ7jDEnVl/T1VmSltv9sgnCVtuPqrtW+dc0A5CCO0ACzGYLWtjtWvB?=
 =?us-ascii?Q?3DTL6+TTL37CXfuf7lW0phqf578eTOLnw+xmqpsC++Eeld1B8H6g98bzovEZ?=
 =?us-ascii?Q?oCJ9dH7Gk4g9Mkedcinp0nzvJDf3lrMBodHv4Kaih4LEA1QiVBeR8pFGhrse?=
 =?us-ascii?Q?LEy4R/Gund9/L8SdGcn0R+FBP07SSkb9wmWV8MudpRO/lenXxKRLYHDyGk1b?=
 =?us-ascii?Q?wt2MdaRAvOAnxEBZvf1i9ggc34oUpDbqwhDGhhfVoIiK/7DhWQCsAE8dSQum?=
 =?us-ascii?Q?pZMypV4VALF4aeNkK9qHPxnsBEZBnsb9J9bSpyZ5HmrRSfu+8NTXQ5W1t6Mu?=
 =?us-ascii?Q?uikavSBmZxHl7ycl/+JE7+0fbwUuo0PwKCGkKkZrkR+Woq3eusVfSW8A/wtQ?=
 =?us-ascii?Q?M4Ohf7RRSayZmS3OLcpiOaHWq7T/I+aZ7Jrcwtj5bCzNO1xjsp5T4nCJjcm3?=
 =?us-ascii?Q?52cp6vEbnIQf+RXDTVGTRttc6BU9phGfmPckLtj3clhgosKA+5YPkYKc24h2?=
 =?us-ascii?Q?ihxa7fOj98DuWYxIrM/h8QVp9RkhkYCZkzCXgRb+kADSZ94Ob4+BP2RzcLw/?=
 =?us-ascii?Q?Ddhph9hPFxzVO0X8ByjrbRzKAO/+xxTNaQ+1?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2025 05:31:53.1074 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bebdc7d8-0d70-49e8-8462-08dd7ca7fec9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF0000231D.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4388
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Fill static metrics data for smu_v13_0_6

v2: Proceed with driver load just with warning even if board
voltage reads invalid value

Signed-off-by: Asad Kamal <asad.kamal@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h      |  1 +
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c  | 15 +++++++++++++++
 2 files changed, 16 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h
index cd03caffe317..ce3d042de5db 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h
@@ -112,6 +112,7 @@ struct smu_13_0_dpm_context {
 	uint32_t                    workload_policy_mask;
 	uint32_t                    dcef_min_ds_clk;
 	uint64_t                    caps;
+	uint32_t                    board_volt;
 };
 
 enum smu_13_0_power_state {
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index 3fef50df85e7..cbbeae9f05f9 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -739,6 +739,19 @@ static ssize_t smu_v13_0_6_get_pm_metrics(struct smu_context *smu,
 	return pm_metrics->common_header.structure_size;
 }
 
+static void smu_v13_0_6_fill_static_metrics_table(struct smu_context *smu,
+						  StaticMetricsTable_t *static_metrics)
+{
+	struct smu_13_0_dpm_context *dpm_context = smu->smu_dpm.dpm_context;
+
+	if (!static_metrics->InputTelemetryVoltageInmV) {
+		dev_warn(smu->adev->dev, "Invalid board voltage %d\n",
+				static_metrics->InputTelemetryVoltageInmV);
+	}
+
+	dpm_context->board_volt = static_metrics->InputTelemetryVoltageInmV;
+}
+
 int smu_v13_0_6_get_static_metrics_table(struct smu_context *smu)
 {
 	struct smu_table_context *smu_table = &smu->smu_table;
@@ -762,6 +775,7 @@ int smu_v13_0_6_get_static_metrics_table(struct smu_context *smu)
 static int smu_v13_0_6_setup_driver_pptable(struct smu_context *smu)
 {
 	struct smu_table_context *smu_table = &smu->smu_table;
+	StaticMetricsTable_t *static_metrics = (StaticMetricsTable_t *)smu_table->metrics_table;
 	MetricsTableV0_t *metrics_v0 = (MetricsTableV0_t *)smu_table->metrics_table;
 	MetricsTableV1_t *metrics_v1 = (MetricsTableV1_t *)smu_table->metrics_table;
 	MetricsTableV2_t *metrics_v2 = (MetricsTableV2_t *)smu_table->metrics_table;
@@ -830,6 +844,7 @@ static int smu_v13_0_6_setup_driver_pptable(struct smu_context *smu)
 			ret = smu_v13_0_6_get_static_metrics_table(smu);
 			if (ret)
 				return ret;
+			smu_v13_0_6_fill_static_metrics_table(smu, static_metrics);
 		}
 	}
 
-- 
2.46.0

