Return-Path: <SRS0=EPaF=PD=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35121C433FE
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Oct 2021 00:51:16 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA6BD6108B
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Oct 2021 00:51:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org EA6BD6108B
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 632A36ECB5;
	Fri, 15 Oct 2021 00:51:15 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2087.outbound.protection.outlook.com [40.107.92.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1EF166ECB3
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Oct 2021 00:51:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A8Jg/0befRPqkPqT8rx6zIQbPEwEK+orRJSQJU8eNc91hzyuokRQF0msMR89ulj/Z2L+1i7Z7tqUId7xGJkhoyx7LOna918ZI4e3KO1wZQemVIIlm0ldD1NcjsJpY6rBTfjXHsQ0y+OckQcTnLNdSMwDR6MXUpDwDyV+aJDxltuAj2BCOUSFcX+D+3+CRTTTtEL6QW0LIF2aZxMfrwTq/kKYRZGH8QdFirDGkozjrdKHJNWMV2+n/uxjKfctw1Miny3ahi5bK7y6XYNYOdxuYiztdOc4BhaGpb20rNoS/FRaLiGaFPzUw4mOX/Vcmpfr7fqjoqXf00fIK81l9ScfbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+uFErse6u/Nul9LghaX0GzrU25xzDaP9WfUOEKogcVw=;
 b=U4/VSAHMExOOfZckOqkeyU354HvF7TyXugHRX9vfdPjVWAVV1fdLd86A+th6qett38VLRGMfPlP9je/8A3MJNyCewmNQ5spoXB7if3hw4JIzTQti4IZgv8jzggMnwUlQYl15RShR94iJEhGT1lms7l5bWFMABV6ONOM6APKg40/x5Gbl35Ja7eJ5oK5xgA0tQeF++A10GUyR9KH2DYwubPa/n9CvaZBa/Nm0Oz63lTPW//4ppP70vKt01Qrjs+b3S8PbsfWyZeJGK3MFM1NQ21QHE+VMeEfJmtz5KyzklQNtwscjEOzXYwdltMRFjuehJ32XvJRIL1xM+CF30Onkbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+uFErse6u/Nul9LghaX0GzrU25xzDaP9WfUOEKogcVw=;
 b=iGcGhz1b8KvssDRC23BbabnMp3DuHA3jziBOAdEcp68SCFnUFrceVGot1gBJ5rzgVTp3br2YTSz1HFOMT6lwUceAtlzWMYhzEBzk7DFj7NWs3LGFV3M6BnmMTjEzWLzNj8zm/K/qXsA+GDIfBXlw3yDtUZ2Z1eRkVoux5I6xh64=
Received: from MW4PR03CA0281.namprd03.prod.outlook.com (2603:10b6:303:b5::16)
 by BYAPR12MB2631.namprd12.prod.outlook.com (2603:10b6:a03:6b::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.20; Fri, 15 Oct
 2021 00:51:10 +0000
Received: from CO1NAM11FT021.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b5:cafe::40) by MW4PR03CA0281.outlook.office365.com
 (2603:10b6:303:b5::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.16 via Frontend
 Transport; Fri, 15 Oct 2021 00:51:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT021.mail.protection.outlook.com (10.13.175.51) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4608.15 via Frontend Transport; Fri, 15 Oct 2021 00:51:10 +0000
Received: from localhost.localdomain.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Thu, 14 Oct 2021 19:51:05 -0500
From: Luben Tuikov <luben.tuikov@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Luben Tuikov <luben.tuikov@amd.com>, Alex Deucher
 <Alexander.Deucher@amd.com>
Subject: [PATCH 3/5] drm/amd/pm: Rename freq_values --> freq_value
Date: Thu, 14 Oct 2021 20:50:44 -0400
Message-ID: <20211015005046.43486-4-luben.tuikov@amd.com>
X-Mailer: git-send-email 2.33.1.558.g2bd2f258f4
In-Reply-To: <20211015005046.43486-1-luben.tuikov@amd.com>
References: <20211015005046.43486-1-luben.tuikov@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 37ec100e-8c22-49cf-85d3-08d98f75e140
X-MS-TrafficTypeDiagnostic: BYAPR12MB2631:
X-Microsoft-Antispam-PRVS: <BYAPR12MB26311E748378EEAD43006D1799B99@BYAPR12MB2631.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:232;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pgZP4Frm8U2dl5HV4FNh+/YbL0qb0G2Thd80cQgY5uGa8EJ0LIUNTjs+PKTKY5P1rR1NP759ULmiDpGRKws8ME/Wv4OQ9MF0o/1PadJd2+90jZ3PA7Zd4Qnwd8MluZNVtMq3h64xyjBz1c76xORJkXU7ojMIwMy0qfclfxDaNGeRwm5ekAsuEZPXW1fn+J6UNlwjVhxHBRFjtTwi+PCjJlSEXvDlf1gzVrk5Pp+x84SI/wDtlUhBvIEUUEzpjSbXiMl80/UISIFHn6tvJJ1UVxAtRysWE4YCWgOLaB/JNcONuOKQHJJ4bmEkUWIEmuW9HjzmoM2P0TGkc9dPJBgMR6aZyJJZmRlD/sO9Yz65UtkrTFfsl0WtqLfUkK3qOZg1yssGDl7qoUVW5qKbMx53zcFcr2Akg9WUtQ4x6/eawjteVyVstPSEAkCTOxJcoG/xaehdfzYOEOb98NHGxerHbyQwuN5w5+lNnwvYqgJLdTm98Uvul6sKx8JFjlFu/pARRjHxl/lbbMksYwLsCz7tyJpnVE8fRCdOg/h7hyEHLLtHanihUfed89OpVNqbC5o+A4zwMauNTU7PX/OOHMzd2Gd/rZa/zYmfNYFiOM89dicMw7QSkIx68vLvkbgJVQztroL9MeUaC1vRuAvRBHdUrunPE7YGFEPtvHwztWfM+ASNqSIJifLp9CGYGEgp/7Ejq2zZpFqy3jiWEWYrGmN4Br6R6AZR7ngv77td40KwXIs=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(86362001)(356005)(81166007)(4326008)(6916009)(1076003)(16526019)(5660300002)(2616005)(54906003)(6666004)(186003)(26005)(36756003)(70206006)(336012)(83380400001)(82310400003)(426003)(47076005)(44832011)(70586007)(8936002)(8676002)(2906002)(36860700001)(508600001)(316002)(7696005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2021 00:51:10.0474 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 37ec100e-8c22-49cf-85d3-08d98f75e140
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT021.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2631
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

