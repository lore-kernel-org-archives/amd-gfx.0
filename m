Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 254E2E8B399
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Feb 2026 04:44:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A937310E2BE;
	Wed,  4 Feb 2026 04:44:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="OxHg0MDs";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010071.outbound.protection.outlook.com [52.101.201.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6DE1D10E2BE
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Feb 2026 04:44:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dmNLRR9g0c7zWJHt8NB1N+zRo6X9qGKULeCZV3+8tGwKxfkTVJwYDpuv/8D9oumAovCSZ69Z0uNTdCJmUosN8k7pz4EdjGtIDBjaeLcSbjlqUy2TxlvR645ZiKok/+2APbL454EtXRHfPAZ+BJ0GqCelZqBkfj8P4w1Kvr0DDmGWsdlSWQLkH/253k9GsCSafNNivJeBKgoHk67hux87eKzVsOvKlLXPamasy463G+4Qe5L4aTbZ6FuKBJ85mdHnw1a1k3zpS1Fqs59/Zylo1KidMwaYEWo2orackZxeN7azbK4PWRFgigwzepX4v83Zb0PfwPEfhqk+pLMtH692yA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yV1zPb7IcM4wSvzZ/uRNkiN4aZStSpOgeWZfiZfibNY=;
 b=XP4jfYIZV77ZW01fnC1k7pZ6IqHbtgkCRMV/83K3Hrfig9jsMWwALv15p7z0AluBYlV4hUXOmwLlVEmm0+1HGIs9UkenIVyxq3ppPT35hX3h2/+BZlk7VjMgNpT+UyGezhdH8AcLLtGd6jiudyzYHMHFsUO/nmRaHyYex1I8nzEry8kHhgOgzuz3XNa985ShdfFgtHjlElbAWF4VJjSt8ZScdXlqGU+pVbVJMXpT9Ve1iQ6Jj6N/S5y1iH/943hpMSKicYyCE7ohZoVXNaYRNey1zNgRU6zR3dQEAuNS+6Dvc2c5TgyEgPaMjo8AayHYsyS63vV8SH3Pof7SVYyaYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yV1zPb7IcM4wSvzZ/uRNkiN4aZStSpOgeWZfiZfibNY=;
 b=OxHg0MDsg0NqGYSNGEiQf8NcQIOSJ2Sh0+YekzUYEWxA8c+EASJCUXSoSTtTzb3dumSmonf9zTUTqf8NmxiwBFBLqas7okM8dVyeG17XnUDd6gzWIGMnTf8aZ8Hl7UywbTbbDyZnvmVO9/vvz8flrukRCZgOFs5Y1QnF4XM0y0U=
Received: from BN0PR04CA0147.namprd04.prod.outlook.com (2603:10b6:408:ed::32)
 by PH8PR12MB6889.namprd12.prod.outlook.com (2603:10b6:510:1c9::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Wed, 4 Feb
 2026 04:44:03 +0000
Received: from BN2PEPF000055DB.namprd21.prod.outlook.com
 (2603:10b6:408:ed:cafe::f8) by BN0PR04CA0147.outlook.office365.com
 (2603:10b6:408:ed::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.12 via Frontend Transport; Wed,
 4 Feb 2026 04:43:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF000055DB.mail.protection.outlook.com (10.167.245.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.0 via Frontend Transport; Wed, 4 Feb 2026 04:44:02 +0000
Received: from BLRPVISHWAK.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 3 Feb
 2026 22:44:00 -0600
From: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>
To: <Alexander.Deucher@amd.com>, <amd-gfx@lists.freedesktop.org>
CC: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>
Subject: [PATCH v2 04/11] drm/admgpu: Update metrics_table for SMU15
Date: Wed, 4 Feb 2026 04:43:31 +0000
Message-ID: <20260204044338.96093-4-Pratik.Vishwakarma@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260204044338.96093-1-Pratik.Vishwakarma@amd.com>
References: <20260204044338.96093-1-Pratik.Vishwakarma@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DB:EE_|PH8PR12MB6889:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f11e6e0-2579-4c86-5d90-08de63a804fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?GFUACXkouvwrxCP/69A4WH3pqM9LorGDFy+8PNoxmtulUbO0mx6aEaCcG72M?=
 =?us-ascii?Q?O5I2bwZPoyjfc4J1t+oxls79U7ZV4igznTPtZUZNU7VT6ffLbjN4KoMcuJG0?=
 =?us-ascii?Q?J+3MQ7x54MIHXx4/E8p/ISt45r8yukNRIEZ0NkpylJIWr0Kah83P2quoabd6?=
 =?us-ascii?Q?XhK09vHBCRS7acGO0TehNj7Mpf8C800GNqmDOuDKTR0makYCraYA9R7Tb5kP?=
 =?us-ascii?Q?QArXRCob4Lyq9lGVmQu6uEmcgHoPGSUaRRAx366St/TBl8Lj8UaZHhcyfnLn?=
 =?us-ascii?Q?aiCgMyV11RLxZm1yyhygPbYqvETYMnvcex8wrTSeJPo90XfclPEuBj0qhcVH?=
 =?us-ascii?Q?H8o4YSq8B+YyZJ59KUEOiIv/y/ltoJNEqxxdR1nY3K2nha/HsKR/9e2ChjUy?=
 =?us-ascii?Q?+99sCV5l/rb5SyXxLv/V1Djqfi6q33LWhvSuMCfIKwVdk5Kjz65UOYGcEgxT?=
 =?us-ascii?Q?5dHX3ttv+OsgU9x/ig3JHeCLczR8fCnKsxwYXNkkLZ+MUEMJ0L6kvLh3HJRw?=
 =?us-ascii?Q?Ti4NTO1bpiEMKNHQEjfzvuS6beWVQ6u9a9Gr9toYr+sk8mapi5BwTMXAp753?=
 =?us-ascii?Q?pzSWZfTTX3rFchyjbHXGVX7Ti8CeV3w3yrNL1MsfFMM0ZBtsWHdql97/vg9G?=
 =?us-ascii?Q?blKt+sZTXBtHIQFsLRCnSgw/fKSJq+9uHKgeMxGz2ukTMCAE69kPe+vGnIy5?=
 =?us-ascii?Q?2B7UodgbhwmqStDv9rKLD44P+j7IcGLztk3WTR3iuuyMstyZzm5zyEGrPML8?=
 =?us-ascii?Q?cQ6RUPMnHAgBv7HMucW+B/gtho4REjeEk66FPmVbSNt8oLll+UTXHzdVzQQC?=
 =?us-ascii?Q?MzGHLZJUEDgl626ySkD+xAi424cOaDfG03CLbjhHciXAeMELrQZ2FhRECZ8m?=
 =?us-ascii?Q?/J5WZHKxnLBSWsXCJYllN1H7iNtrKoY6FH+Thbz8TYNRGyreICRst9XDc05f?=
 =?us-ascii?Q?Yc5h5nK/Zv2EuFZVQrjjeKb8MFY5I5VZ3lioxkDubCgoVhHKCttayOCADPO6?=
 =?us-ascii?Q?TkFhbAT1wUhQwV6f2IQMMV7z9nIENrksQLh7JXI4S6e7wAaNLjoms8SIJuFo?=
 =?us-ascii?Q?RjOaJzsodN4Rwg/fcq6zameF7QzgHp7Q3z2Le5qoy+PxUclvNj80CI0HbMtF?=
 =?us-ascii?Q?I/RtF6ZRgQ9r30iWqASu3S3jLhGCBuABMW3QBuCN/1pZnOYgqbYndtOgCd8D?=
 =?us-ascii?Q?gxpNF8A57fnFQ9vKbOsirO1GAvN1ucYr5PaA1WUSN7MfwRjMRI+y8M+rwEnO?=
 =?us-ascii?Q?B9o2KFh2O7dsZ3cDJo3EvYAoJSgP/U9Y+w07H8sEwXNnhPmFezjZeWayguLg?=
 =?us-ascii?Q?d6L58+Q/Z3mSU4eSIc43iAkt8ij8qYdjWrNtCVXwTNjrUQbyadoQFOwDy+73?=
 =?us-ascii?Q?q1MzbMwsBEnjcCS5t4ERAUnRffmR4XDitm0IElJsyk6brBa6MP5mATJLMlyE?=
 =?us-ascii?Q?zJKrV9Ax/fqa9kuavOYEMU4Ld8EDWTiUSh+Vw4iEdC/XT+Z7OT95iafeYpHJ?=
 =?us-ascii?Q?E029WhTXtjBRJgPK0IOW0A8QxCPrG2p4dzFLF7Sj2Uxiyql+95NW531D8++l?=
 =?us-ascii?Q?AXI178gXf2YPbOO8acNjLPvKBWUIQGwxsqfnEiPA4SV3izNvmXYYqQDlxCOU?=
 =?us-ascii?Q?sa9lDVto3jJPdRXiaHCEXVYZjiMY8e/RCBiHXsR+hTHFT4ioafS/iqVzxWz7?=
 =?us-ascii?Q?BrnFOg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 6+EZ3YnZ6ZOJ8TX2h/+uVLdAeElQ3jzqawoaZnU7K52h5KFpKNVOa+UQjCB8I5KYh5E8nqAhXqTkXWRVe0iCX4lu9lsjBWn0mMIgC+SBsldWm/Spzpussa6+F/JPPfeQH0PilNBLIROUgwMrS3UXJPX/PSCO/C9GPgXf6BZkT6OXKWRFrUf/rAPGC+gU4XeeZc2YunYxzU2qfg2HFzHjzyX+9a04n2mOHkTMWtceiHjXQrjAdUrZBqLcSTRFdq0vHCmzw0n3JLTKF1/bmFKNgCeNg0uibfsRmxJBtEalAzepS9aQ52aswUwkaxheKEEgxFnHNmUs19ReVvFRwMsz1ujS3T61Y+SNhw0VzusvyqzGu4gE/+mTYkCILKZdmf5g4SIfoZTjssLT5LmdQNj6lcD+9iVnw5XLrR6arGQ7n1MiAMah29vGbw576/JG9E8z
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2026 04:44:02.1943 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f11e6e0-2579-4c86-5d90-08de63a804fa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000055DB.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6889
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
index d58b0bc2bf78..2987ff1b13e4 100644
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
+	ret = smu_v15_0_0_get_metrics_table(smu, &metrics, true);
 	if (ret)
 		return ret;
 
-- 
2.43.0

