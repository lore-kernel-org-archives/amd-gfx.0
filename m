Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5DAFD111A8
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Dec 2025 10:14:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5CA9210E359;
	Mon,  1 Dec 2025 10:14:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="UBgmYTA9";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012041.outbound.protection.outlook.com [52.101.53.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5653710E359
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Dec 2025 10:14:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=huzGdGydkuO7CBQhvxxFmpXGSBobbqmL07eOsHCnBNu0pZ14mb+EwplTumnTP60YuPiL50Gl7s4uiFtE7tllQy8Y7e2R1xWo4BIx7uEhSuTo6Atkj4Ml9APdeVZbt547hPnH4AcaGqMuoFAq3A/NIQ05IzMmpUbuRqLgvPCoRIAOGkJbMobWyFaIqu3yDzp2ZNjXLKRLkXoGQ8ulE9Y+tEy9UXG9LZnPPCo4Yc7pD8e2B/oml1Hpq45B9py8OCPwAFrn0hq320VKrproMuKFLdkTP2FAAbHSU7ILqi2OmLoycBb737OYAHE9w0lpW9OC0B6wXUK4bgROH68gZHvxDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DmDwO1/iKZQrEt1Ki/KvJH3Zvsbk5VOXeGqTlkDwWpw=;
 b=UR9VvzQsBsQnwDkqFE0AKPglFUXPl7rTrgBMFl5gOJ6MklkKdLfFGvJX05X+HEObhLdf5dg3FKxXyNwrsHyCsoKwItR0DDJRp0yzvxDGiVDKaP7ew6CcDyMbAljfkuBjlFfHe/aEKNyT/2KJVSg4VU2m3S1kPfnGdtgQlQzda0eIP3J1izu2iKq6JIww9No4OKR0S8iqfTHm42zGJEehtTYFmMmGkX+mepaX0ajNBx4mbvSaLzKafp+PLg+vx+04deVa3Aeyzqni/NHMM76PHJv9lt0pWw1wnKgJ+P0xIukQTVPeW3WWTX7pWhfu5bZsFkdXiXMr47UdaSnTHZPAHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DmDwO1/iKZQrEt1Ki/KvJH3Zvsbk5VOXeGqTlkDwWpw=;
 b=UBgmYTA9uuKUtz3ARpD5Wz9PA2iNRCAF5xPxs4wY1weccRP9KrsbK+5NMft5iT3QMITnsE0cjz0sOoTNBAyzipBHopaz1iFUxsL9T+oSn4OKtvPDc7/ya7v04UNWKlcOMANVM1et30GEdFPQvLwBWboBCew8H0+frrQLBRPcFew=
Received: from CH2PR03CA0030.namprd03.prod.outlook.com (2603:10b6:610:59::40)
 by BL1PR12MB5898.namprd12.prod.outlook.com (2603:10b6:208:396::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Mon, 1 Dec
 2025 10:14:29 +0000
Received: from CH3PEPF00000009.namprd04.prod.outlook.com
 (2603:10b6:610:59:cafe::d7) by CH2PR03CA0030.outlook.office365.com
 (2603:10b6:610:59::40) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9366.17 via Frontend Transport; Mon,
 1 Dec 2025 10:13:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH3PEPF00000009.mail.protection.outlook.com (10.167.244.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.8 via Frontend Transport; Mon, 1 Dec 2025 10:14:29 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 1 Dec
 2025 04:14:27 -0600
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>, <Asad.Kamal@amd.com>
Subject: [PATCH 09/17] drm/amd/pm: Add a helper to show dpm table
Date: Mon, 1 Dec 2025 15:33:22 +0530
Message-ID: <20251201101331.101584-10-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20251201101331.101584-1-lijo.lazar@amd.com>
References: <20251201101331.101584-1-lijo.lazar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000009:EE_|BL1PR12MB5898:EE_
X-MS-Office365-Filtering-Correlation-Id: 568c5f82-807b-4812-3e99-08de30c269ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?mx4D1VhEn8VgX63KW0ZgrIeMMswSS4n5PFO6RkNA6fYFb4JdUb6eNGhGBbJ5?=
 =?us-ascii?Q?IeP07LX1OM+iy9cT/1R0ctpV+GIuh6zc1GeNNOQ50hZvx5YiuiODC8R7jYg4?=
 =?us-ascii?Q?SUqBTQ9TaJz9LnqIh5OMAWOhh9WFJmeMZWHcc0Aw3xYmQ0eHQ9a4w07LCQuP?=
 =?us-ascii?Q?ETSzxtn5V5OSpEfjfdb57sV2myebR/wdNeja1cz2s0lyii4qqjoFYWwxG/V2?=
 =?us-ascii?Q?tP/ieqGxnZ8CvJve8XBq/U/5He5NfEFUpz7q3dXw0BIOz//z8X31TGcP6jVK?=
 =?us-ascii?Q?lARjwW+Wj6331pznFLj6CZ03nI6j4sNT5d+AVxHUmF1wdNOdSvteip9Sb+2m?=
 =?us-ascii?Q?ZTKj4faLhvLHDwVVNR4rDp++3MkhADOZXf7QcZ/svMdinVSr4rm+j7s8RByi?=
 =?us-ascii?Q?9RGfaXRC64PN94VYMAd/fDuDb1a3tv/QsUYrjrLiTMNDGkmZKw5BQfCQDGRm?=
 =?us-ascii?Q?dlnBRqGrReUafRFwpGd6dQKs/kzcy7TGnNGYVIFDCUj35/aWXKa+h7ym3E04?=
 =?us-ascii?Q?JOzjEqg2V0mylb6moMY0UlRPn3ng8u1ObBhmzyDpB3wvdr5yoM2nwdF1KVJS?=
 =?us-ascii?Q?Nf12xfiZ9eZemO+XdPN+L0RdYiTjj55KHdgqWS1OYLuRQLXoGghPJ1pbt340?=
 =?us-ascii?Q?uV7Qm5cey98Mo/stL0vzV+A7qauPdNahK5ksZbtcczmmXMJdE9E0pq47yeKy?=
 =?us-ascii?Q?Yy3lRncBdSC5gm6lV/rgojcWA+nCf7p0WX7WC9d7b3kpoO0oeeCFNykjV0rB?=
 =?us-ascii?Q?7wuXBcg/XmtoYRaduIpK+hv0d7m4tK9q2cksUB/IJnT933LxPJdhVs0XWWn/?=
 =?us-ascii?Q?I+vUbrf0dCopwlo8yIgI5BLxvfsVzDOPxEamtOMweoiHoIcMLQv+DZiMxRe7?=
 =?us-ascii?Q?vPk4S5EOBrA8gqEH7NDZorqKCQHcUimt+/Pw2VFju8jLYY+ou7k6jZs2FtV5?=
 =?us-ascii?Q?KkqkXj1iEEvk5koqsOIoFmC8KRXa48uIUDBwQoRe+vDVJjfGt+BL2yqkgR3c?=
 =?us-ascii?Q?VWd4FtkWLL3EkQZ4N94eIxjIDvuLtPU0ZReRqzgnCX4jrnGRs+sw3LS1h4Rj?=
 =?us-ascii?Q?MO9BRO4T9pFTkf0nlJbfrVmK2vp8HjOveWJkDY294MPzAG1GW0s5MNGxwGgk?=
 =?us-ascii?Q?68FrM5QFCtkTZxNimh1Rg1AKCbXH56TorAjM/KGU1y4w65JTIp3EpQvOzL2Q?=
 =?us-ascii?Q?wJizKPoTR3KcB3rov6JHIc8uqU/vTY+HVXobhoDM+Hsw/eehiN/8lwqBMdQU?=
 =?us-ascii?Q?haQ2XUM3rJw9+K6aIC0hI4qrWEc6LK+HWNVzuPXkehe7Ru7gWuXnoqWnmt8u?=
 =?us-ascii?Q?LDy785mMQ+yv25eNT8HuoIiPu2xBU6NSFLJHVlyvI+hzmJbRnXdc3Wx4159A?=
 =?us-ascii?Q?Qh/fwikhmpIVGKo6T52KkpJ5l6B4HkwO4GLBo3Fm1Mz2qF9YG9h9LxXNmYfS?=
 =?us-ascii?Q?rSI0nx46aK5rKWjFO+R9VdvipYJ/5plarVdSF1PRyYmxElGys/iMc4qbcLb0?=
 =?us-ascii?Q?qzTRMcpVQmpRJdSWgJyp0Cs7mYQgOSVfudZdjRU5btQqaaKfV7GzH1Zyk/x3?=
 =?us-ascii?Q?9nRWY+Eq1ZBU6APLeIo=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2025 10:14:29.1529 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 568c5f82-807b-4812-3e99-08de30c269ec
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000009.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5898
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

Add a helper function to print clock and pcie dpm levels through sysfs.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c | 118 +++++++++++++++++++++++++
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h |  10 +++
 2 files changed, 128 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
index 4040ff926544..88e9699d9cc1 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
@@ -1199,3 +1199,121 @@ void smu_cmn_get_backend_workload_mask(struct smu_context *smu,
 		*backend_workload_mask |= 1 << workload_type;
 	}
 }
+
+static inline bool smu_cmn_freqs_match(uint32_t freq1, uint32_t freq2)
+{
+	/* Frequencies within 25 MHz are considered equal */
+	return (abs((int)freq1 - (int)freq2) <= 25);
+}
+
+int smu_cmn_print_dpm_clk_levels(struct smu_context *smu,
+				 struct smu_dpm_table *dpm_table,
+				 uint32_t cur_clk, char *buf, int *offset)
+{
+	uint32_t min_clk, level_index, count;
+	uint32_t freq_values[3] = { 0 };
+	bool is_fine_grained;
+	bool is_deep_sleep;
+	int size, lvl, i;
+	bool freq_match;
+
+	if (!dpm_table || !buf)
+		return -EINVAL;
+
+	level_index = 0;
+	size = *offset;
+	count = dpm_table->count;
+	is_fine_grained = dpm_table->flags & SMU_DPM_TABLE_FINE_GRAINED;
+	min_clk = SMU_DPM_TABLE_MIN(dpm_table);
+
+	/* Deep sleep - current clock < min_clock/2, TBD: cur_clk = 0 as GFXOFF */
+	is_deep_sleep = cur_clk < min_clk / 2;
+	if (is_deep_sleep) {
+		size += sysfs_emit_at(buf, size, "S: %uMhz *\n", cur_clk);
+		level_index = 1;
+	}
+
+	if (!is_fine_grained) {
+		for (i = 0; i < count; i++) {
+			freq_match = !is_deep_sleep &&
+				     smu_cmn_freqs_match(
+					     cur_clk,
+					     dpm_table->dpm_levels[i].value);
+			size += sysfs_emit_at(buf, size, "%d: %uMhz %s\n",
+					      level_index + i,
+					      dpm_table->dpm_levels[i].value,
+					      freq_match ? "*" : "");
+		}
+	} else {
+		freq_values[0] = min_clk;
+		freq_values[2] = SMU_DPM_TABLE_MAX(dpm_table);
+		freq_values[1] = cur_clk;
+
+		lvl = -1;
+		if (!is_deep_sleep) {
+			lvl = 1;
+			if (smu_cmn_freqs_match(cur_clk, freq_values[0]))
+				lvl = 0;
+			else if (smu_cmn_freqs_match(cur_clk, freq_values[2]))
+				lvl = 2;
+		}
+		count = 3;
+		if (lvl != 1) {
+			count = 2;
+			freq_values[1] = freq_values[2];
+		}
+
+		for (i = 0; i < count; i++) {
+			size += sysfs_emit_at(
+				buf, size, "%d: %uMhz %s\n", level_index + i,
+				freq_values[i],
+				(!is_deep_sleep && i == lvl) ? "*" : "");
+		}
+	}
+
+	*offset = size;
+
+	return 0;
+}
+
+int smu_cmn_print_pcie_levels(struct smu_context *smu,
+			      struct smu_pcie_table *pcie_table,
+			      uint32_t cur_gen, uint32_t cur_lane, char *buf,
+			      int *offset)
+{
+	int size, i;
+
+	if (!pcie_table || !buf)
+		return -EINVAL;
+
+	size = *offset;
+
+	for (i = 0; i < pcie_table->lclk_levels; i++) {
+		size += sysfs_emit_at(
+			buf, size, "%d: %s %s %dMhz %s\n", i,
+			(pcie_table->pcie_gen[i] == 0) ? "2.5GT/s," :
+			(pcie_table->pcie_gen[i] == 1) ? "5.0GT/s," :
+			(pcie_table->pcie_gen[i] == 2) ? "8.0GT/s," :
+			(pcie_table->pcie_gen[i] == 3) ? "16.0GT/s," :
+			(pcie_table->pcie_gen[i] == 4) ? "32.0GT/s," :
+			(pcie_table->pcie_gen[i] == 5) ? "64.0GT/s," :
+							 "",
+			(pcie_table->pcie_lane[i] == 1) ? "x1" :
+			(pcie_table->pcie_lane[i] == 2) ? "x2" :
+			(pcie_table->pcie_lane[i] == 3) ? "x4" :
+			(pcie_table->pcie_lane[i] == 4) ? "x8" :
+			(pcie_table->pcie_lane[i] == 5) ? "x12" :
+			(pcie_table->pcie_lane[i] == 6) ? "x16" :
+			(pcie_table->pcie_lane[i] == 7) ? "x32" :
+							  "",
+			pcie_table->lclk_freq[i],
+			(cur_gen == pcie_table->pcie_gen[i]) &&
+					(cur_lane == pcie_table->pcie_lane[i]) ?
+				"*" :
+				"");
+	}
+
+	*offset = size;
+
+	return 0;
+}
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
index 8d7c4814c68f..f458125e8d4e 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
@@ -202,6 +202,16 @@ void smu_cmn_get_backend_workload_mask(struct smu_context *smu,
 				       u32 workload_mask,
 				       u32 *backend_workload_mask);
 
+int smu_cmn_print_dpm_clk_levels(struct smu_context *smu,
+				  struct smu_dpm_table *dpm_table,
+				  uint32_t cur_clk,
+				  char *buf, int *offset);
+
+int smu_cmn_print_pcie_levels(struct smu_context *smu,
+			       struct smu_pcie_table *pcie_table,
+			       uint32_t cur_gen, uint32_t cur_lane,
+			       char *buf, int *offset);
+
 /*SMU gpu metrics */
 
 /* Attribute ID mapping */
-- 
2.49.0

