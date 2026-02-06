Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DEA8EE20A4
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Feb 2026 13:36:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 248D810E708;
	Fri,  6 Feb 2026 13:36:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="DrIFSq6x";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013066.outbound.protection.outlook.com
 [40.107.201.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 98F0E10E72A
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Feb 2026 13:36:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=akE8k/1cFfrKxPTAGg6A8qyNqg79R7MPsDyAmhEaoIsRuX8iivDccCIlFuD5eyhAlm9omXz7DFiqPp4GEWgIwbuPMqjYlJ4RYEWOtEAwGy56oxDEs3nInj0R2yMkkvjjcEHsqlgYd+WKYTKjKR/KL9H/EKU85rgEsnQ/a9l76j3F0TFqmgbF7XbdQdzMgVPoMEtQhwU5aOwCtpF1U/yZL3eZhpTPtEp56i2Sg8N57FfuSlcYCKY7gYm3AJXrP2QaeSuY5ri+r8B+6VrdVy+Ze9YD0dFKcsjBJt9ZXW0b74y7Cd+php2Q23UbAUsEaOnujTrYNapFWrruBj9H2yvL+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S/88TPQ1nXgczC/CrAaATq6kpLempCrFExCIMca5SKw=;
 b=UcJzv0QZrK604kWJwq8RU78EJlf/T4gxs9E8n/b7eum7lJKyOM5gZ+uvcnMwjtxJU6ZKN6CHQu4acJT9TYvoTY7qgHJkjIPosnllXE/Bqu/6Z6mhe+C53V7IQxbiLHfkiMcnY3HrSBhMgGmBju2P7xj8krCObeHgim2TqGxP5ZRRWZ6owI6WdkVyZYrA6O6v4/LXrllMvdTVsGDTrGfm5KMZSy4JgLFaEWMmA8AfjftWPFOqkadMO0F/hYGZ3lHXpS21PK1qoH4jrrEyzzGs6xx7Jxyrce9gC4HdA92tfLsZzd/Iybwz+HXxa8tz0/JMnuYo+3dHFYuqNgzJfeglRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S/88TPQ1nXgczC/CrAaATq6kpLempCrFExCIMca5SKw=;
 b=DrIFSq6xluXeLjXk3BE2OT7um6LP+Joo3KQUmny4tni24w1wgr9HAuMw03MbfFc6cRXMw+5yL554sxyrMt2kzrceK5cbsIy3w73dve+huk5VFX6PXHoIlnRfcj7G1RSXl7J+wxGv/GAWYQ113FvTd5Fg3aefkoNtXeZGwCHUO2M=
Received: from SN7P222CA0026.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:124::24)
 by IA0PPF8FC6E1236.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::bda) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.14; Fri, 6 Feb
 2026 13:36:28 +0000
Received: from SA2PEPF00003AEB.namprd02.prod.outlook.com
 (2603:10b6:806:124:cafe::5b) by SN7P222CA0026.outlook.office365.com
 (2603:10b6:806:124::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.14 via Frontend Transport; Fri,
 6 Feb 2026 13:36:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF00003AEB.mail.protection.outlook.com (10.167.248.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Fri, 6 Feb 2026 13:36:28 +0000
Received: from BLRPVISHWAK.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 6 Feb
 2026 07:36:27 -0600
From: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>
To: <Alexander.Deucher@amd.com>, <amd-gfx@lists.freedesktop.org>
CC: <Lijo.Lazar@amd.com>, Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>
Subject: [PATCH v4 04/11] drm/admgpu: Update metrics_table for SMU15
Date: Fri, 6 Feb 2026 13:36:00 +0000
Message-ID: <20260206133607.91047-4-Pratik.Vishwakarma@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260206133607.91047-1-Pratik.Vishwakarma@amd.com>
References: <20260206133607.91047-1-Pratik.Vishwakarma@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AEB:EE_|IA0PPF8FC6E1236:EE_
X-MS-Office365-Filtering-Correlation-Id: f5bd4e35-408e-40fd-3ca4-08de6584bb74
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?PU3KnQ7R5VBG99U5G7HWQIQXSwt4uuxyoXNd4SswH+RSeeTDpKkLEQBe0VV1?=
 =?us-ascii?Q?U+xsXmPL+Fb2A3FHLNxSzWkAJ4LQsHpZ4Lewr4G5ShT+cpwepnvAGAjSmtzG?=
 =?us-ascii?Q?zwqiYddrPkxFCIQkm+wArzRdzeCyYoHzkCv+8Rw4cDzCuV4lEle8EKtyvj0T?=
 =?us-ascii?Q?y3xb27iwF7ax6Ze7Shi+S4SlsjEsehGufWNvzS9LT3+XcOJCD1LiVflZ/GkZ?=
 =?us-ascii?Q?coO2R9AyOgPM/8FqnIxEuHXiZ8ka/vE74auy/2BWAodkKQyV2uxgrOSG0K90?=
 =?us-ascii?Q?8SBZuIwH5N9IDBIVqOcf+0rva3ZSXNl0A26rahYJrLwqPdq9xcTR9JRIdvg+?=
 =?us-ascii?Q?xtS3t9TUXMS54uC/j42+xvpcSwVZ80scpQI8kVmk1YXtf8IVKyqLazAl5qCN?=
 =?us-ascii?Q?VQVIZkNq2A299Z0hb6HstmzERBRU72yHFMgkdRuI/r6PybTmwETNQ/ddv2Tb?=
 =?us-ascii?Q?DgVPbnm/Nj2PgcKjvsUrGr/58Q0dEAl+92wL/IGe2z3mtFomM7NCDl8t+wER?=
 =?us-ascii?Q?4u85TGj0QFRYnscODeT0BIH19SBAvS8Nv+xr76nSINLDd8M2W3jmF+jOhCfz?=
 =?us-ascii?Q?Eyw+Tm/PWaSztpszc/Bnb7Uxlg34h95p48z9XkMxLumLFp13Rnv9iBiu3v/i?=
 =?us-ascii?Q?oPrVc4kR7r9M5TVKCjYRMwuIB3wF3/fXSk/mL9fA1+ouGvsLL1eGe47f9EqU?=
 =?us-ascii?Q?K41i4mrCD7Ha597eHAMlX2Bh3H1ZvbUqWUABIZTgXH22evJolgJpjJhAMrmH?=
 =?us-ascii?Q?q3KkNdKF2gV4oDqDwAsi0mUtx8i/lwU9ySFkN0aqMM4blQP0vCyL5EM/WCbr?=
 =?us-ascii?Q?nWk+IX6sfk5R3st0+wf4t6DgL/dSJFeTJ8cNU8fP2CV+iZALzsHwKTLv+ddn?=
 =?us-ascii?Q?dU8NEg9u4u3ez9+lc7I7xwmFtna6PY382vVggF1uvsDn4m7RVV05TFrRCpbE?=
 =?us-ascii?Q?dNaArRBBG2M4Lc5kzHPM35afABu96fEEJ9DLcmRuyKR+Bf9hLfXd9rZEYpGA?=
 =?us-ascii?Q?7H7qMPh+9PEknOlCw3ptMMJHXaarIByouQRK/CE8HQqPnptmF2XAkoxU2Kic?=
 =?us-ascii?Q?QBKT2njSUR4iixvF8braDZ2+coJ+LXnPaWKr8bvuNhwDjcw/dNo5xeWxm/H+?=
 =?us-ascii?Q?Y3h58mLeU8uaOyZjx41RKXZOkn1ZzOPhPPYe9WlWLk3n75CIjLPG2n65UqN4?=
 =?us-ascii?Q?jPFz/xil4N6tCX7fHUPzOUxju4Gq+kJjzZy2K+kkAgBYlyxl4vHbHBfAc6U3?=
 =?us-ascii?Q?8Kqy6bJbta2t5BZY0BSS2neJrlN8La5XD/vx335hAFnLFJFnCBBFQFD0xHAs?=
 =?us-ascii?Q?nZCeU/FrKjYHPLJOZ50/5OJ8BE+mx4S2uj/FpCaBs487kgEndSMZVL9tSp7I?=
 =?us-ascii?Q?isZTQNVl1XD+PndrVJ8ZFRfn6lDOJQaNGy5oLrbmDrjTpJddfg3oeiVZvy7N?=
 =?us-ascii?Q?AriP6c9KYpB3Hy51yQgOAZ6QlmYulp2HKDlMB6PiEYLUdpu8KPyFGCneeJ2Z?=
 =?us-ascii?Q?ypiNxWYG/4giDVUn8CYDc/TuGEOq1cBTr0lDGKGJeoPdqVzf6VAYEDpa3rqr?=
 =?us-ascii?Q?M7FclVBeDpw4+6Hen2MXnn0gWf2cvzDyrICRv2qW7ARZKpZ8BX2icsVRXggu?=
 =?us-ascii?Q?rv+jUnuWSPghvooNc8fyHjwunv8QloAdhDGALZKxpn4VgwSqjbaSbcHAJED3?=
 =?us-ascii?Q?r/4SVQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: uwPDfmJ7Uj/RIXYmwSTWTpwtXxCqfgUnqBb9dJS/GrMGEyLfJYyhKILkotOWxpg0gOf1fYhnN8jf8RrhmykkjWBHZvNVY6Ap9dGOJ9Pb4viVjERXSOcsVuVdCozbx8DarVQiNjxyp4ZJLMAQOWE7nwQNLXAVZgYKrcvZj1Jujdf+hBbDvQqe9ntzvH0fPqrWQn3CNT9FCpOVBJQuC9vDV7FaH+HAbd39KJRi8KXzQ61slKbX7Q/KAiSafIxuDvgO/FSOW8dpWGkW1nHQ6YWcNFSmnRyA65YyNtU7swsBq2gIkJe5BjfoUnQBUEYjG5tDIIBsrNJwurvBXhClMoDlSoQ4yKbgah+LYb9jhUtkQTZXUc6YNS7BdxsOZCEjGAMweV3dKQ1d+o43FVH4gQ9UI4giFaPNaAp/497ELufMPE6Z6/rr3FB6iDkU3RFU96np
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2026 13:36:28.7580 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f5bd4e35-408e-40fd-3ca4-08de6584bb74
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003AEB.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPF8FC6E1236
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

Use multi param based get op for metrics_table

Signed-off-by: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>
---
 .../drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c  | 34 +++++++++++++++++--
 1 file changed, 32 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c
index 9a2e2c2f4e06..c07cf438e4c0 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c
@@ -284,6 +284,36 @@ static int smu_v15_0_0_system_features_control(struct smu_context *smu, bool en)
 	return ret;
 }
 
+static int smu_v15_0_0_get_metrics_table(struct smu_context *smu,
+							void *metrics_table,
+							bool bypass_cache)
+{
+	struct smu_table_context *smu_table = &smu->smu_table;
+	uint32_t table_size =
+			smu_table->tables[SMU_TABLE_SMU_METRICS].size;
+	int ret = 0;
+
+	if (bypass_cache ||
+		!smu_table->metrics_time ||
+		time_after(jiffies, smu_table->metrics_time + msecs_to_jiffies(1))) {
+		ret = smu_v15_0_0_update_table(smu,
+						SMU_TABLE_SMU_METRICS,
+						0,
+						smu_table->metrics_table,
+						false);
+		if (ret) {
+			dev_info(smu->adev->dev, "Failed to export SMU15_0_0 metrics table!\n");
+			return ret;
+		}
+		smu_table->metrics_time = jiffies;
+	}
+
+	if (metrics_table)
+		memcpy(metrics_table, smu_table->metrics_table, table_size);
+
+	return 0;
+}
+
 static int smu_v15_0_0_get_smu_metrics_data(struct smu_context *smu,
 					    MetricsMember_t member,
 					    uint32_t *value)
@@ -293,7 +323,7 @@ static int smu_v15_0_0_get_smu_metrics_data(struct smu_context *smu,
 	SmuMetrics_t *metrics = (SmuMetrics_t *)smu_table->metrics_table;
 	int ret = 0;
 
-	ret = smu_cmn_get_metrics_table(smu, NULL, false);
+	ret = smu_v15_0_0_get_metrics_table(smu, NULL, false);
 	if (ret)
 		return ret;
 
@@ -568,7 +598,7 @@ static ssize_t smu_v15_0_0_get_gpu_metrics(struct smu_context *smu,
 	SmuMetrics_t metrics;
 	int ret = 0;
 
-	ret = smu_cmn_get_metrics_table(smu, &metrics, true);
+	ret = smu_v15_0_0_get_metrics_table(smu, &metrics, true);
 	if (ret)
 		return ret;
 
-- 
2.43.0

