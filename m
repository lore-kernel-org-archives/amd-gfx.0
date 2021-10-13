Return-Path: <SRS0=F65H=PB=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D37BFC433FE
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Oct 2021 03:11:11 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 79AB360F94
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Oct 2021 03:11:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 79AB360F94
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7C77E6E06D;
	Wed, 13 Oct 2021 03:11:05 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2063.outbound.protection.outlook.com [40.107.220.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EA27B6E061
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Oct 2021 03:11:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a0bJeDHsyXGU9qWxuUZJsfxQHOB0hDO1GvICUQKDc0+KJSbdU+h2Vt9hDTUJDRn6k4CjuPSgiMibZLsT8RAbFkUXY5ZJVwc9FJ/b7u0VfoO4M7Gm4eXa4a2mxB/d2WoAZrtiX1ZYrb1GuGpPE8VZZpAGk5cS69H5O/xye1X8iE2GfjeElXKD/6nm2cOGdCkG+H2FtaWPLqB/IrcV2EYh13lzQP7kuSmpZfzLYN65CLvSRj91g73s9g4KT9x0anQCPKAl9UlCYOnf8dm+3Y3HgtCqqr4k9fmP5JbjTPynJ0XEMwMv5Gt4WEYifcHxn3AtYw0Svl+PjuU9Ksj9dELN/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PwG5GFVqX5wdYTRLh1YaCOv6wq4OEBG75dIoHSZwfvY=;
 b=MwYVZfZrYA9m3IfzIgB9RYHk9+fc+fXTqhY1KTPnJWdK/5P6zq+BFVdZWAZslBc1FQYT4smoybjXwpaRv6lsfI7Dosv1tK8UskZiQsvfImW224dLfbAxOn6BCAgvV1NemWEnD3W13bKLqXNwJv5vRlciRiPZryaP+nz/WgVgLB6wxaRFeLYgmnFt3bOWsF47pC5r5MgzZ2f7mCaMg+vDZE1ESnK3BUvURBJHtWDb9BoQnz26kbvSySKXXyq0QHxJAE7v4geb5AJiBSafuLzRemFIKkeCIMI49Os7aibacsF2X0cH+rqzUwnjcSIcdYCVuymNxrip2Y5Ex1ZyCX2afg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PwG5GFVqX5wdYTRLh1YaCOv6wq4OEBG75dIoHSZwfvY=;
 b=f7CDFOUcU1t3J3AQsFG2iZiXSWsiJIeFNR2FaTMkkoXGlp3H7CmfwOsqyuiYN6gZlOsnkTDb/GT5+RK0JoPHDVI1QqdjZIxbmA5J7GylQknJc9EIol4BqdxoI52GLtU7XADpRnRDcAXY2x4hkP1B2/MfdbMk7MtjzV0kfd0bnzk=
Received: from DS7PR05CA0002.namprd05.prod.outlook.com (2603:10b6:5:3b9::7) by
 MN2PR12MB4029.namprd12.prod.outlook.com (2603:10b6:208:167::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.22; Wed, 13 Oct
 2021 03:11:01 +0000
Received: from DM6NAM11FT062.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b9:cafe::cc) by DS7PR05CA0002.outlook.office365.com
 (2603:10b6:5:3b9::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.15 via Frontend
 Transport; Wed, 13 Oct 2021 03:11:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT062.mail.protection.outlook.com (10.13.173.40) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4587.18 via Frontend Transport; Wed, 13 Oct 2021 03:11:01 +0000
Received: from localhost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Tue, 12 Oct
 2021 22:10:58 -0500
From: Luben Tuikov <luben.tuikov@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <Alexander.Deucher@amd.com>, Luben Tuikov
 <luben.tuikov@amd.com>
Subject: [PATCH 3/5] drm/amd/pm: Rename freq_values --> freq_value
Date: Tue, 12 Oct 2021 23:10:40 -0400
Message-ID: <20211013031042.53540-4-luben.tuikov@amd.com>
X-Mailer: git-send-email 2.33.1.558.g2bd2f258f4
In-Reply-To: <20211013031042.53540-1-luben.tuikov@amd.com>
References: <20211013031042.53540-1-luben.tuikov@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1c35b704-8417-4fae-4aae-08d98df715c0
X-MS-TrafficTypeDiagnostic: MN2PR12MB4029:
X-Microsoft-Antispam-PRVS: <MN2PR12MB40292742371C8EF32B0E4EFA99B79@MN2PR12MB4029.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:232;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WhzLe40RA8KpCdiHDwcnijWyAHvGjjY96rhqPFfTUdErqc9aA62444oUjkNMnXg8ixR4+QMtE/H6gJh9+mIoedKZwwSUHenXBH/ikWopCzfHD4jtmjf0DfrcyPpr9NFWa5t64MiOgqTKD7gHTlqYDmhHC6eoJAzB4URObhNXj7cgH1QMMOnnrKbL0c7NSKEpugPgtUYSNptYBgY4vVObt1e6U9/IdoNiNlzCvYNO3KpWeYRTP+GeXtUm3Z9E0wA3QWjAWp4KbApx05sCYNKLDCcqo1T6hanrRUfTHy/b9JHgxDHhgL8M65cDdXfAWhibTkwoNUuj3BapP7IuKcYcWqgzXlt3k6PszR2YgglmVkzEbQ2oWaOouivnG1A6FrJt+nqg4BnRMQb7CuyyTpxCv9PhuEcG8JndbqspmZ3UNk9K5AsGiOAu0TecR6/FbbTMTX5DlIGsjeflRNzv9A0Yrwfr2WoBq4emOoepg9dT92Wk31kmt1I1/2wZmIxCMI5n0KPBJzTU2yy3tcFX8MTKze7PQyEO7vLhCT+flQhRbuOflH6FWUdCiwxYAN0C02398T5WSOad9vhzOYJDVdhWC0sRMixG0KXadLsamkXK/tj7/u1PX1H8XjTnFu4M6LrCm5S6LAI4P2szeZg9tDPH7YjWPkIiWPckzoO1IDsTklGBENBzuIjgOxgy6AlA/IzPa9xgXvqVHnke3/fLCsKZlE6NJ+eqqSTjsgb4UDrpihk=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(7696005)(16526019)(36860700001)(8676002)(8936002)(26005)(356005)(36756003)(81166007)(47076005)(186003)(508600001)(336012)(6916009)(2906002)(82310400003)(83380400001)(2616005)(5660300002)(1076003)(4326008)(6666004)(426003)(54906003)(70586007)(44832011)(70206006)(316002)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2021 03:11:01.0178 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c35b704-8417-4fae-4aae-08d98df715c0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT062.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4029
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

