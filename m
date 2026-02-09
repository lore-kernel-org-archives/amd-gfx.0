Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFAF9E81BB1
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Feb 2026 13:04:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 631B110E3E1;
	Mon,  9 Feb 2026 13:04:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="D3zzuyDB";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010064.outbound.protection.outlook.com [52.101.61.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9FC3910E3E1
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 Feb 2026 13:04:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LuFMbd5atBjQs0N2HMi1tnTJTzRQpqHO8utHWpJGUbfgHr0jaNEmVqQlnIGWjXa0wv75bYbe/lEcr5YHglPvTFwMjhqFhQO7IE3YmrXMFrXcvlIKUSO7++KqrBdQNNkRrOXOfFM7DL7OYofeLGILVpmLYiNtw+5lMILejwj9NrvYp8AKuwMo07hkX2KzZGdvaD+nMEf6wD25OAO1lOYMhmcg8n8plXB5e6eOlNFhFzXjMXJr08tuGBlmUwEC0MOSx9bJHfibStM+XjedDuvdtuYe8GSVEFweBBiRAzJAccAjf9ag2kdpnLis/2v2lFeGppTc1eevzGq9e9zSaN2F7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lRBAmpbuZsQd8zgY7BNR2XyVsTbzsA76fmqeilYz+yc=;
 b=e8CRWjujKVxkBa+hAhUzipHXIEDr55/UoafbOMpTp1pg103o5+SeAS+d4gNhfX+OsPB1YRyat3AJDj7lcrFxEmwzQlxbKJGDIhnavpcqeY5Reg7FzQnqE1kvIYow7TVazu2F+kDXw/PE0Jf8QhoAD3leA/PHC0PNWWs799zrwJiyXvWCIGeMqZ0C1SWpqYqfsYq7iAfBTjvsgSdOFesZSCKaDZjqZr3AXhjxUefHaDGEFRFG6LVZz5f1f9JH2UBFGx7E5vd85LE2Ptq+2HWvIDtXOTRF5J8vdrpAiPE4RLzeQCwya8s3uoLG2e48XzzXbD1InL8D2vCgIY2uxoqQLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lRBAmpbuZsQd8zgY7BNR2XyVsTbzsA76fmqeilYz+yc=;
 b=D3zzuyDBLz6u9qGOB1eL6MtdTSN52Ari5Y2ZVZ3vgul6XEcUB7Zu3ND4f7VLVG5ypGwnRhrKecqmLm89Svr7kDYX88rR6n1Uuoo/iLfgDK5hDASd8r++TY6L+Ig6gSAJNts19g6c2/QLFSJ9gu4CPWvBrPmRLnZ7hDpluprDtLM=
Received: from CH5PR03CA0014.namprd03.prod.outlook.com (2603:10b6:610:1f1::16)
 by CYYPR12MB8923.namprd12.prod.outlook.com (2603:10b6:930:bc::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.17; Mon, 9 Feb
 2026 13:04:43 +0000
Received: from CH1PEPF0000AD7C.namprd04.prod.outlook.com
 (2603:10b6:610:1f1:cafe::e2) by CH5PR03CA0014.outlook.office365.com
 (2603:10b6:610:1f1::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.19 via Frontend Transport; Mon,
 9 Feb 2026 13:04:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000AD7C.mail.protection.outlook.com (10.167.244.84) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Mon, 9 Feb 2026 13:04:42 +0000
Received: from BLRPVISHWAK.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 9 Feb
 2026 07:04:40 -0600
From: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>
To: <Alexander.Deucher@amd.com>, <amd-gfx@lists.freedesktop.org>
CC: <Lijo.Lazar@amd.com>, Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>,
 Lijo Lazar <lijo.lazar@amd.com>
Subject: [PATCH v7 04/11] drm/admgpu: Update metrics_table for SMU15
Date: Mon, 9 Feb 2026 13:04:06 +0000
Message-ID: <20260209130413.118291-4-Pratik.Vishwakarma@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260209130413.118291-1-Pratik.Vishwakarma@amd.com>
References: <20260209130413.118291-1-Pratik.Vishwakarma@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7C:EE_|CYYPR12MB8923:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e87c25b-7ec0-4758-a545-08de67dbcab4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?vGZ/lfsEfkHvT6rmUN9SZLafpFRO7JXwBl5WE5iXNNiwFa2FMVfbVY1PsbqL?=
 =?us-ascii?Q?wBrBGUOeycLFLHJYW0LGvvi98c8t6tIB7SNmen0tX99s3wrDoOiqKepMHcSY?=
 =?us-ascii?Q?4v3xo2ViFL9aiQNIj0njRyP7zSfGfZObuwgw7/1kAKs1zUm62SOJm0WnbVB8?=
 =?us-ascii?Q?DRHB2DO6D7nvSYx7q1Ok4KqlKTZ1v3v0PaKq1vjP75Wlte6g2KASTalDpPq3?=
 =?us-ascii?Q?OWnFDbyJw1/OFBpmcuV74da98ODX012cqN/e5FTY3TYErvu5ESAH1Qi4yEo+?=
 =?us-ascii?Q?Q0RLDhGIA2hlQGwZW+jc4EQFGXulAvGkVhvEjj9xeItWoM1G0DYSBQMq1YsK?=
 =?us-ascii?Q?dj7Vl7L6eUwf3Uhl4dRA8A25DuzYMTSTYqNP9fBH1o3l/s5mYpzrP/LWhIG0?=
 =?us-ascii?Q?YWQ4ZnAmE6TD2388c1m//iHeM/1QNAUvYGOc866c4sjEnTPCvH8GriRnDNer?=
 =?us-ascii?Q?sMWjxa+x+R0LAkXbwyfQAj3wVbWD/vNI9YACTChk8lExRvMVbk2nLBvOZj1l?=
 =?us-ascii?Q?eVIcnYt+uGVFPkQvMlcccS926lGnCdS9UruQweVTVTnEcIfoCarbPi4LYfLg?=
 =?us-ascii?Q?ikrsNdPlTx1K6+BEMxj8eVbAfvT9Hx9g7nPPGI5ABNYMHYIl0bQc0W/hn8Kc?=
 =?us-ascii?Q?KKTvbIAI1HotMqaWMkGH+JTnd4i/Zv1VATPfMWCueYV81oeI2bbZ3pEu+33V?=
 =?us-ascii?Q?gJwHIcp6BMZ1b9eMroq2rhM386K2RvhPdP0CuV/01ioYaEm6SgBbsDGvgHBv?=
 =?us-ascii?Q?jHihn33XMuAt24LZxAFkzN2QvEnCdfBpEK3LTnmQo4BlHWcCaZqmqYr7PDdz?=
 =?us-ascii?Q?cJYQWjk7vLq/oboySirj2S3E8viAgsmBzsjbJlFkCFg7ORDkWuPX169iLiDT?=
 =?us-ascii?Q?jkD3e8fzpk5kabJYcha4SXTzNgzHLTh3QMl++P4mCp6NLG1bh0tXHdOlDdIL?=
 =?us-ascii?Q?1fvkChCR2imQftiYJXSP/s1hhw1OIZkypvVNYPvB5VMzSffNEPahrC6EVOth?=
 =?us-ascii?Q?MRU6X+hXVW50pp7qCZHW4d3T4msVm+pkqcINBDrckU4YCoQB04WgtfJ3fzhf?=
 =?us-ascii?Q?aUz6qiwUvQKJgZqfeiBdycdm8rtMM4R8SN66Egb3YpwZ11N+D3f+QroaupH9?=
 =?us-ascii?Q?oBvchQLJtOB+A3DaY1BxEsLIRWTtrZtkh4Srdkc/OrdGkjZzYpqp6lqJOdgN?=
 =?us-ascii?Q?p27vbWUsHsw5qcNJwgJXmkx2dw2LrYVs3K6g0gz+suMlO9MW0Ql1omDbDVmc?=
 =?us-ascii?Q?bFkngmUSTA4n+47GXi14d2kDgL4reyS+CHFPTjf0QKtVTRliIqwvBitB8J2v?=
 =?us-ascii?Q?7aZa+YjOorD2FduTcTx7M222JWXzFiU0xgKtGHwrM2zXmwlgW9zZgReoHiLb?=
 =?us-ascii?Q?Vgi/NGIR5utEPwNx6w0Q/nbFqp7DKT1oRpLrLnVdM4LFxUVytOMzmAjG7FzZ?=
 =?us-ascii?Q?GwxonLc0+zYLOHotTYC3vEG48CWPk7LZ7UOJQ72IElbrOh5gHV3r0NNroF+7?=
 =?us-ascii?Q?zCadoDJ7dNcZu7UE2IxCCdULEgUUSwD/3+HTfQ4yAsNJtp+/o6qKgaWv3KW7?=
 =?us-ascii?Q?9n2JLlrWlpUZgWCdZKb46XkTpZLQb20bdQawOjYWi39EDSy4AIyvuMrV3zlM?=
 =?us-ascii?Q?ido9vY7xcHvhGYZ45s13dDz6EzqXaviixzsUxQnRuYVgFYROqUN4wFDut/RC?=
 =?us-ascii?Q?Fyqo+Q=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: A535+51h1qxZ35jcGOly8zWsBWL07iMzTKswyovBiSGGA1FdY6PgV+s36RkRTsZUwGVXi6i4h/z1K4atkB5POvety94gHUcRKirj+EexdQKD0SWhE3f/03yrMSrFMERuDFSmJIa8fzTjy1JzaJDHPayw6X46b5nrrclbMJ7tE0AQHwruyd0ryVDQdD5Gc1M1/kObqTOjbQN/MiQR+35DG6xE1RBNj6JlSovyRCDMKHeeLVK9ck/I+Pcjd9vQA0CsD/wFbSXwPQJK82wv8Ft1O7fEtvPtrAM4DYnE5iPUS2M/bDq1cSz25lC+azcCq4ccLzXX1PgvQRGbSKwwdj09yKeslsQIquRt7qdYOrdsBbrt3GD3bLNd9iFOGBpbzv5hGdZaehWu5yP6CzAR91BG6RyKpI26/Ucsu8CPPVmTI3dWyDyMe2N/3CzzKKBeIJK2
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2026 13:04:42.8993 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e87c25b-7ec0-4758-a545-08de67dbcab4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD7C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8923
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
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
---
 .../drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c  | 34 +++++++++++++++++--
 1 file changed, 32 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c
index d58b0bc2bf78..b42d56f7e621 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c
@@ -246,6 +246,36 @@ static int smu_v15_0_0_system_features_control(struct smu_context *smu, bool en)
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
@@ -255,7 +285,7 @@ static int smu_v15_0_0_get_smu_metrics_data(struct smu_context *smu,
 	SmuMetrics_t *metrics = (SmuMetrics_t *)smu_table->metrics_table;
 	int ret = 0;
 
-	ret = smu_cmn_get_metrics_table(smu, NULL, false);
+	ret = smu_v15_0_0_get_metrics_table(smu, NULL, false);
 	if (ret)
 		return ret;
 
@@ -530,7 +560,7 @@ static ssize_t smu_v15_0_0_get_gpu_metrics(struct smu_context *smu,
 	SmuMetrics_t metrics;
 	int ret = 0;
 
-	ret = smu_cmn_get_metrics_table(smu, &metrics, true);
+	ret = smu_v15_0_0_get_metrics_table(smu, &metrics, false);
 	if (ret)
 		return ret;
 
-- 
2.43.0

