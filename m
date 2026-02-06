Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74DC4EE20A8
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Feb 2026 14:01:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E753010E7A0;
	Fri,  6 Feb 2026 14:01:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="CkJ32B71";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010017.outbound.protection.outlook.com [52.101.85.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 25BE610E79D
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Feb 2026 14:01:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WSFTax/BQxfNPAcIufEHU9uhNSiWik159MD18sDJF5ZJnRPIWSclV1w8hBw0qOuqnpf8Z4Si127G6NMFiuezGjCK6NDG8bDo9KhbPCOPJPeMtkqgOIDiwh7kPX7tYjTBs63awN3eET82wkkXL1okWyNIt/HUoSvDMlNdH8fLGAfVo14xwUsfKTdUxa9NwchJCOSQKyKE85HIWkNCJgmD8Pec1E1z6yr/wPiZC5KrUs9ncz54s1jth33p6IGqwfRBXk6H5y3kw1Sg62jIotLjPizGh+/0ZgC80pPmI1cQZVdprf+pghD4XE+I3iRxzXWkoJ7WcEBIXIqzVmIaRn6TOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8ZSxsQwjRqYQBHoO4pZaw/5FZMJkwIZ5DT8nAkzlIzQ=;
 b=rxG0bYOBEdRL4hE+xGubiADmWOsZhcfatG3vJap5hCI07P1X3xfnCVnUC3fyXtutLENxxIMpHqYOsqlQLW4clVLQFfvy+owqJH/+qM+QOMI6asxjJbygjn7G6CW/ei2C6Pt+Rh9zqnJq7YwUYB9XhjBEgBtstjHQ2IgS6SW2t33ql3z/4SXMlYRerO5g2ACteKHZQg8YRTKGy/SC9YMr4cZMGZMfiz+ygVrI3F1XhuAA3hJ0S2V7zoNV5zscVn+6UJ60AyCXzKdMc9YX2cdeaXlL06G62BvaUPsaedk5Ld4v7wesPwVBaxf0By6Cds/1Fw2TMIo0PU/N+kQNPVmX4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8ZSxsQwjRqYQBHoO4pZaw/5FZMJkwIZ5DT8nAkzlIzQ=;
 b=CkJ32B71YU6tq0x5mPQ1icV8n9qJVpb+/S62usafBwMUEZY6H6EoQ5J9IfHzbXiAWYWU69tChst1rr6pFj3VeuZKzPeVPQ5cplpNxYqGcHBOVghEQdLiLWWaEjzr4+gePg9OxW+ImjXOwKVDYsVsWrTMMVDDvMIXzhvMHixeZSI=
Received: from BLAPR03CA0165.namprd03.prod.outlook.com (2603:10b6:208:32f::9)
 by DM4PR12MB6301.namprd12.prod.outlook.com (2603:10b6:8:a5::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.15; Fri, 6 Feb
 2026 14:01:13 +0000
Received: from BN2PEPF000044A7.namprd04.prod.outlook.com
 (2603:10b6:208:32f:cafe::61) by BLAPR03CA0165.outlook.office365.com
 (2603:10b6:208:32f::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.15 via Frontend Transport; Fri,
 6 Feb 2026 14:00:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF000044A7.mail.protection.outlook.com (10.167.243.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Fri, 6 Feb 2026 14:01:12 +0000
Received: from BLRPVISHWAK.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 6 Feb
 2026 08:01:09 -0600
From: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>
To: <Alexander.Deucher@amd.com>, <amd-gfx@lists.freedesktop.org>
CC: <Lijo.Lazar@amd.com>, Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>
Subject: [PATCH v5 04/11] drm/admgpu: Update metrics_table for SMU15
Date: Fri, 6 Feb 2026 14:00:41 +0000
Message-ID: <20260206140049.105294-4-Pratik.Vishwakarma@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260206140049.105294-1-Pratik.Vishwakarma@amd.com>
References: <20260206140049.105294-1-Pratik.Vishwakarma@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A7:EE_|DM4PR12MB6301:EE_
X-MS-Office365-Filtering-Correlation-Id: b0f326aa-7544-49b0-e4fc-08de65883007
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?bdlgQ0t4dv7vGvAnpX/JaYQkVeB1wOjYFeYjSodGvOyzpLTVJTBVaR0uwmpA?=
 =?us-ascii?Q?LgyOC4K99KkdVXMw1cjl3RscuH4O3dUasC6CuO6UHO+Lp/cNRhgb7Yh/EPOC?=
 =?us-ascii?Q?/1pUMF0i6ROoEX815ibYSRmfGRW1z8sxfRuJ7O8WRw0tmirn/xb9/YhHvohx?=
 =?us-ascii?Q?+mKeBsYLqYMwGYb2OYHfQVbkWSKMrqPuQX265QI50FCPmn3/AmcOzNdCAzW1?=
 =?us-ascii?Q?bGtscDVXJ742qgGR1kOZMmKEL7SUF9Ep1T2dL/AVyPaxXgW87K8GIcmR1DxH?=
 =?us-ascii?Q?TzHOUnljE7yWzByS7SoIaooM7m/lbqv6rz3xClOlSeXF8VODFK3QbQzD/KLN?=
 =?us-ascii?Q?maOi+GGabGgPmwJHhccEmJME5O7lnro+l71X0S6k+TLPFtoUf3TC7dR4WFkF?=
 =?us-ascii?Q?WR4XqsXNucZU7Y9gLgdabauujQOB52W0TRu/VFFHRqyz/vQPz80A5qAP5voN?=
 =?us-ascii?Q?JMPKC9hPfvRxJ4TftqS85szHEaeruZxvw8YwpUtB7sKlRAXk1Iqt9gAhibUr?=
 =?us-ascii?Q?XcOF3DT84SVahwRk145zItFVKkS3Iuf15EIwIMH6mWT/xz0bzfzplSKl5w4f?=
 =?us-ascii?Q?F3Z3FSMyuPYgfE8BF8p2Dp2wYNQPwgtl2d0rZ36dHoLhayjYvJt71XD085rv?=
 =?us-ascii?Q?T+QBNupBvCL+y1c193/1cAhm3Y8fINS1/rCOT+/L6l6MBdYu+rx+lQHZ4vHt?=
 =?us-ascii?Q?Vn+SyahNwT/9MRAfRqqcs4F4EBSzpqXfDg9t9oeQVTcEQ1jDeP42IUt74ocK?=
 =?us-ascii?Q?xu7qnNC6Kj4q+Cn6Mr1TioqFhXiBYDIraMQEgQ6UZNDQApRzsHNfeismPgo4?=
 =?us-ascii?Q?VLD/yKYKSm7qkBEGsmTeMGBt3iwYJrIaltm9+Qqx02EyK+Qd4YySMFcUdYjt?=
 =?us-ascii?Q?RLZ0IE1WXiWk125AZS4GdCqQXKpgOqj1d1ewBD1wL+sF2bCfU6pt86NlXAxF?=
 =?us-ascii?Q?TT0KkW222o+8cRbsj+DP7z6oIj3IBrJzhMaLD48hkVaAO7no/lR7g+R4Z2sz?=
 =?us-ascii?Q?YjXq0mWvL1zalMv8pD+9pCGQLdgVBNYRa5orIWgPU9LLV5QBaQ0mo54vC8ty?=
 =?us-ascii?Q?zluR7Mcl3E9XjxAMQI/MjDH2vjh0mk6kyDdV37DsqEpavbW4lxgHh0qSY63c?=
 =?us-ascii?Q?T9Fr+2SadTAl19U27Bs22hD/m3raegPudTi45ill4RmTEo+ggwV187DAZ5E4?=
 =?us-ascii?Q?HgRsw77Cmht674vVWBKyjVHJRgd+23kfyhBAOwRfxD28fjPb7dP7Lm7PxEQk?=
 =?us-ascii?Q?QpbMB1rmSnX4gUe/QisX26A/jEGZlZOk8zgc01MJCNhgGJk7q9rlk4tmBfNC?=
 =?us-ascii?Q?ghXhnVFZe1I4wIZYeEGO7028o93AW7327Sb3gN4kvwK4FUMIeaZlu2/Fi+Di?=
 =?us-ascii?Q?47dBuyd2wpuN+jcf7FiMo2nQDfVUCzH769qTAGRNvto71zfQLV+0S4N3H6YK?=
 =?us-ascii?Q?Vjet5iemKxuWIfgt9Ov6xN1qd/6Ey2afGmyqrVhY0fq1qHgdFyijSux5o5iP?=
 =?us-ascii?Q?AvmmnY3ZKxz6hJlZP+Su6PWTE1QRG4qB1zGJzJjyA/UkvVw8FvtHcam41wG+?=
 =?us-ascii?Q?MXilqT9PFV/ygJ0zW3sx+iPrKGCASB3Vaq7U6hwPni/rd3nwI9pJTdkOL3TR?=
 =?us-ascii?Q?ibptISKekW0jtuR98/V4/aWainkLyDj2lMwy/KtxJF1bRB+ttMUa+Hr/Fqpz?=
 =?us-ascii?Q?8uFd5g=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: nJaJYPv+gEAh8Zz05wSCfcHrvCN71I/pfcC1EwlDXe1+U89O5U7jWZyZDF7JTP4lUmFI0WHJlfhyQXEbQRC35wdeONZAgox3+NwOaMGHiA/v1TLodyiqdoA1qIMh3leWv/7uGxbrj2Z3JWwm/HxgkWsuHg6IDzsalWcxZ2UH52DBa8fRd84yBrbSbSVhVuyreWBl4Btt9K7nuOGczR7iWsAJbCZJIsx6bsixv9QbqwI3nmb/butyCIKs/6ifYDtQHwbMO37mHaZJPei6E6TKic/SDukdwt/H5F7RK52nxIN9OlmYiXSBkX8i5u1CY2zNCMw7xSlm7XYUeipNBE0q+FcWIjQH6UttKDYJre6ntnYW4aUtCSVEty0sXssW5/zp+1rx+SU27nCPPtc+xsr5mCW+gPK7vurlFVZeWKCoTa7pDEY2Ot6+ezCInUPcQTXY
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2026 14:01:12.8039 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b0f326aa-7544-49b0-e4fc-08de65883007
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A7.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6301
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
index 9a2e2c2f4e06..e53201f42e40 100644
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
+	int ret;
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

