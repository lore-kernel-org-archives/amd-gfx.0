Return-Path: <SRS0=XteM=PG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87987C433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Oct 2021 23:49:42 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 56542610A2
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Oct 2021 23:49:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 56542610A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 505E36EAB4;
	Mon, 18 Oct 2021 23:49:38 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2083.outbound.protection.outlook.com [40.107.243.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D676D6EAAF
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 Oct 2021 23:49:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jVKAHZjkrLOPH9KgEYKencBHgHgFPZKNeL3ut8axsT2nADG0qxOvzPg5YV6n2PxoPWwZeYOdxYf2SfiCM3e6n+IlLZNy13p/XfAlIpeCHl5FasYLcmb1chdVPIg3D/WaOc8hz1tWkLeJMEHQsTK16+t1ifMyDgVWNcLTC9MCsP4bzbp7SlgOXjbCo467tpD/q+Qn6JL8Yj04YHrPKbU2VXYm6HHRJwdGs0Y4Hmgl37BT4ZFh88yC/yV3R1SUvgpQwDgrk+wjqli7yhCMfR/l5q6Y8S1rN5NId+o2yzP+vfD+XbxoqMvjfeVLAAhnD+l0JxPM3ydjakRaRAUZIBiNAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+uFErse6u/Nul9LghaX0GzrU25xzDaP9WfUOEKogcVw=;
 b=WmVOx91ytWQsotrrcH4Z8L2KTOJqD80OB+0P6GrgoiXsSoJMMXejMysIQ04/d6x2eWKpvvaDiuX8exokrMpeedmK9H1IDTS7TpDvVeMbEUV4W/ciAzYXw0Lv1JKM1EikDVJJ/6TSQD2L9zebULhvVrJzXJSyABYrGWhJljlrubPyjusflFOD4xxAzRU6F6kecpAuKOTUmEA2iMe7wAvBI1XrTGVel57kGamZvOQgxoAfdjN9vzDV9C09HwMm69E02afE7ps0cfNnzIXmUU22iglLLMKt0MnNIjWqOyCDWQZDNRr/ibaj41Rz3IvEcv4D1n7W0vnpYqkNF2QQg+gVwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+uFErse6u/Nul9LghaX0GzrU25xzDaP9WfUOEKogcVw=;
 b=iDovk+MB3lKaKtiDH2hIQA2wwD3z1w8ybMn2z2Sxrzx+lh1Cg1Awp7slNSjOYHhqUX4vLO4IMSEhwhzKN3KpIU+64dKS6RJbzEeAz1FqobCHSnOP+VDLcUEhJEpXrXjEVp3jECfki+xI84k5qRLQcvqw+d7OLWUwdBQlrFCqpO8=
Received: from MW4PR04CA0351.namprd04.prod.outlook.com (2603:10b6:303:8a::26)
 by MWHPR1201MB0176.namprd12.prod.outlook.com (2603:10b6:301:59::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.16; Mon, 18 Oct
 2021 23:49:31 +0000
Received: from CO1NAM11FT031.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8a:cafe::3b) by MW4PR04CA0351.outlook.office365.com
 (2603:10b6:303:8a::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.16 via Frontend
 Transport; Mon, 18 Oct 2021 23:49:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT031.mail.protection.outlook.com (10.13.174.118) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4608.15 via Frontend Transport; Mon, 18 Oct 2021 23:49:31 +0000
Received: from localhost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Mon, 18 Oct
 2021 18:49:28 -0500
From: Luben Tuikov <luben.tuikov@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Luben Tuikov <luben.tuikov@amd.com>, Alex Deucher
 <Alexander.Deucher@amd.com>
Subject: [PATCH 3/5] drm/amd/pm: Rename freq_values --> freq_value
Date: Mon, 18 Oct 2021 19:49:11 -0400
Message-ID: <20211018234913.42349-4-luben.tuikov@amd.com>
X-Mailer: git-send-email 2.33.1.558.g2bd2f258f4
In-Reply-To: <20211018234913.42349-1-luben.tuikov@amd.com>
References: <20211018234913.42349-1-luben.tuikov@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ce4a3b3e-dc80-4942-1f0e-08d99291ee4f
X-MS-TrafficTypeDiagnostic: MWHPR1201MB0176:
X-Microsoft-Antispam-PRVS: <MWHPR1201MB0176FB59DD3CF79D2C4A481499BC9@MWHPR1201MB0176.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:232;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1qfWJIbV6SLk8uTHbKr1mbf6kzo+2VjgknOwIWlZ6Xb180VYrw50FaFsJjnupnfGtsN0NAo9X/b5rue+oLvwEnmNwjV0dWTA3DJHC9tvaS7OUCN1y5r2mTe6r4uHgdDnNHMntZZauIoMPXW8/mrRxgwO7kun0sB47Ld8dUhupABDeH7iYa2kGqzoYcwH0/+MX+qJVmCCpK8EdFoOoSQEHONC5wOLlfLtwtPmD0zuk2/j2FcH/TrbDDxjBj4zupr6tbazNcqXIga7gJOH/jpXr8wHhH4gL8TauWeNTptPNWNA1Dw0S+SPaSkQd9UxIGhgQcZIpPLq0LhithELd+XToMf/qPwrg756Venm0/y4m+E02sBxrdF64PFrcwLvKQp0HeaLOhBYX75liL88VIFlVK8z2HErcPn4QL6ebh8ymCTqcx8zjQ8KxZukyncV/lVWYmEqEsJV1H8or0U++XNhSxgdKJcgtTJbGdd8U/z9F1HmhK7JdPR7hBDb/y6YfIbI/SF/jIEqzCL4YnaZ+tVLoBTIuQLGK+amhcq93rIP2avZV2Ye1d6jb7qGD9CZuJ+jkJiXJhCXCE0g0klnfrLLjWKJNs3BU4TxdLkCfyjelrvp7VXXbJ8QIylQoeGvzxMn1Y6rJ5K2R2cXseVsr8sp7R2AEOLBsGH3TfD3RJHPkS6wIvI4cgmoMh/k0fOAuBdXiTz89Cn+J8vbLpK5yS44480qzGJvsq9ctLfr/h7V10Y=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(2906002)(36756003)(70206006)(336012)(16526019)(186003)(426003)(8936002)(54906003)(83380400001)(7696005)(6916009)(2616005)(26005)(70586007)(36860700001)(5660300002)(4326008)(44832011)(81166007)(356005)(316002)(82310400003)(8676002)(1076003)(47076005)(508600001)(6666004)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2021 23:49:31.2228 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ce4a3b3e-dc80-4942-1f0e-08d99291ee4f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT031.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB0176
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

By usage: read freq_values[x] to freq_value[x].

Cc: Alex Deucher <Alexander.Deucher@amd.com>
Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>
---
 .../gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c    | 16 ++++++++--------
 .../amd/pm/swsmu/smu11/sienna_cichlid_ppt.c    | 18 +++++++++---------
 2 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
index f810549df493d5..646e9bbf8af42a 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
@@ -1268,7 +1268,7 @@ static int navi10_print_clk_levels(struct smu_context *smu,
 	uint16_t *curve_settings;
 	int i, size = 0, ret = 0;
 	uint32_t curr_value = 0, value = 0, count = 0;
-	uint32_t freq_values[3] = {0};
+	uint32_t freq_value[3] = {0, 0, 0};
 	uint32_t mark_index = 0;
 	struct smu_table_context *table_context = &smu->smu_table;
 	uint32_t gen_speed, lane_width;
@@ -1310,21 +1310,21 @@ static int navi10_print_clk_levels(struct smu_context *smu,
 						curr_value == value ? "*" : "");
 			}
 		} else {
-			ret = smu_v11_0_get_dpm_freq_by_index(smu, clk_type, 0, &freq_values[0]);
+			ret = smu_v11_0_get_dpm_freq_by_index(smu, clk_type, 0, &freq_value[0]);
 			if (ret)
 				return size;
-			ret = smu_v11_0_get_dpm_freq_by_index(smu, clk_type, count - 1, &freq_values[2]);
+			ret = smu_v11_0_get_dpm_freq_by_index(smu, clk_type, count - 1, &freq_value[2]);
 			if (ret)
 				return size;
 
-			freq_values[1] = curr_value;
-			mark_index = curr_value == freq_values[0] ? 0 :
-				     curr_value == freq_values[2] ? 2 : 1;
+			freq_value[1] = curr_value;
+			mark_index = curr_value == freq_value[0] ? 0 :
+				     curr_value == freq_value[2] ? 2 : 1;
 			if (mark_index != 1)
-				freq_values[1] = (freq_values[0] + freq_values[2]) / 2;
+				freq_value[1] = (freq_value[0] + freq_value[2]) / 2;
 
 			for (i = 0; i < 3; i++) {
-				size += sysfs_emit_at(buf, size, "%d: %uMhz %s\n", i, freq_values[i],
+				size += sysfs_emit_at(buf, size, "%d: %uMhz %s\n", i, freq_value[i],
 						i == mark_index ? "*" : "");
 			}
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
index 3ebded3a99b5f2..f630d5e928ccfe 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
@@ -1053,7 +1053,7 @@ static int sienna_cichlid_print_clk_levels(struct smu_context *smu,
 		(OverDriveTable_t *)table_context->overdrive_table;
 	int i, size = 0, ret = 0;
 	uint32_t curr_value = 0, value = 0, count = 0;
-	uint32_t freq_values[3] = {0};
+	uint32_t freq_value[3] = {0, 0, 0};
 	uint32_t mark_index = 0;
 	uint32_t gen_speed, lane_width;
 	uint32_t min_value, max_value;
@@ -1096,26 +1096,26 @@ static int sienna_cichlid_print_clk_levels(struct smu_context *smu,
 						curr_value == value ? "*" : "");
 			}
 		} else {
-			ret = smu_v11_0_get_dpm_freq_by_index(smu, clk_type, 0, &freq_values[0]);
+			ret = smu_v11_0_get_dpm_freq_by_index(smu, clk_type, 0, &freq_value[0]);
 			if (ret)
 				goto print_clk_out;
-			ret = smu_v11_0_get_dpm_freq_by_index(smu, clk_type, count - 1, &freq_values[2]);
+			ret = smu_v11_0_get_dpm_freq_by_index(smu, clk_type, count - 1, &freq_value[2]);
 			if (ret)
 				goto print_clk_out;
 
-			freq_values[1] = curr_value;
-			mark_index = curr_value == freq_values[0] ? 0 :
-				     curr_value == freq_values[2] ? 2 : 1;
+			freq_value[1] = curr_value;
+			mark_index = curr_value == freq_value[0] ? 0 :
+				     curr_value == freq_value[2] ? 2 : 1;
 
 			count = 3;
 			if (mark_index != 1) {
 				count = 2;
-				freq_values[1] = freq_values[2];
+				freq_value[1] = freq_value[2];
 			}
 
 			for (i = 0; i < count; i++) {
-				size += sysfs_emit_at(buf, size, "%d: %uMhz %s\n", i, freq_values[i],
-						curr_value  == freq_values[i] ? "*" : "");
+				size += sysfs_emit_at(buf, size, "%d: %uMhz %s\n", i, freq_value[i],
+						curr_value  == freq_value[i] ? "*" : "");
 			}
 
 		}
-- 
2.33.1.558.g2bd2f258f4

