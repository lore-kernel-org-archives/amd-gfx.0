Return-Path: <SRS0=F65H=PB=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CD76C433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Oct 2021 16:12:26 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 26E6F60EBB
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Oct 2021 16:12:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 26E6F60EBB
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6C71E6EA84;
	Wed, 13 Oct 2021 16:12:25 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2053.outbound.protection.outlook.com [40.107.94.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 441776EA84
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Oct 2021 16:12:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oUGkl2A90lbfyDovPGZuzbmyHbhRHpXFlEnILbIRot0D2pyECQhOG4F9HWHH6/4keeXEu/XiF2VvUDXIRfmwvR8QfU15Xcv6nKlSupz6mTEeIrvgI8KEO7IsyeScGNothY9UKCNFulqyXVEK6S4Nj3Ob/hCGgFmavPqlQ4GUPms2g6HNnZGGcTYJbcIqfRTCr7kUE1e0WirG6Cq18kntJ5w2NkvwYS9tWcCvp46TTDvpVgTlfFEjFeCMmJx7yOnU0NZJgWAk8dv2NcxEDOEGIg39v1YUa9a7s3ETREliBY50X4AlO+9AsvgGWdioWHlaLCZ7SV0bH8YcECIkmFEmDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+uFErse6u/Nul9LghaX0GzrU25xzDaP9WfUOEKogcVw=;
 b=CulgPaAbZZUF6BfK5b+Y61Dfdkt5saypPOUCXYLPpGpzXitzaUiLAwT/B9+qngPHpyYxhVCnupYYETUbH5zYxosZT61YmnaSS94k13+6cOxl/ejXIUzjbDFS/vdpjr87OKhh0xxluUy1Q1dAP0fRv6lZHejvMIE0/3K4ylbIzJxn4920AT+qKgVxCyF5eTKuUKS8gd5qcCO6aiZkzKO80JkHmFx6mn002DJTSwEL8I9XFRHNMd0Lt+IFk3XM98OKaQpSVpSJlP7lIq8RCgY6WjFkizpyKzQsNPyKLPuje76yqPZOkB/0UKefddIVzO6n+bQT7oiG0zHdca7VJwpowg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+uFErse6u/Nul9LghaX0GzrU25xzDaP9WfUOEKogcVw=;
 b=NqdAs6rPiV+iOJjpP3+KnofYGc9KXyrOIjKAlhjq3o9dz3he2a6lNR7oeT2pJFaO6NowidSt/dnTU5/ZghVZxoPi2fiwO4m9VIiR5Q76bMsbPfGA7k8SzgJmpx7IqCO3HQGewTyRcctmtsgo89xPFok+UQ1kqwWJ9227BFEwuMo=
Received: from MWHPR17CA0083.namprd17.prod.outlook.com (2603:10b6:300:c2::21)
 by BY5PR12MB4003.namprd12.prod.outlook.com (2603:10b6:a03:196::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.15; Wed, 13 Oct
 2021 16:12:17 +0000
Received: from CO1NAM11FT057.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:c2:cafe::38) by MWHPR17CA0083.outlook.office365.com
 (2603:10b6:300:c2::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.16 via Frontend
 Transport; Wed, 13 Oct 2021 16:12:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT057.mail.protection.outlook.com (10.13.174.205) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4608.15 via Frontend Transport; Wed, 13 Oct 2021 16:12:16 +0000
Received: from localhost.localdomain.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Wed, 13 Oct 2021 11:12:13 -0500
From: Luben Tuikov <luben.tuikov@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Luben Tuikov <luben.tuikov@amd.com>, Alex Deucher
 <Alexander.Deucher@amd.com>
Subject: [PATCH 3/5] drm/amd/pm: Rename freq_values --> freq_value
Date: Wed, 13 Oct 2021 12:11:58 -0400
Message-ID: <20211013161200.9052-4-luben.tuikov@amd.com>
X-Mailer: git-send-email 2.33.1.558.g2bd2f258f4
In-Reply-To: <20211013161200.9052-1-luben.tuikov@amd.com>
References: <20211013161200.9052-1-luben.tuikov@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a83246e7-c910-46ad-694d-08d98e6439a2
X-MS-TrafficTypeDiagnostic: BY5PR12MB4003:
X-Microsoft-Antispam-PRVS: <BY5PR12MB400365F3A4903406E4AFB99E99B79@BY5PR12MB4003.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:232;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EwPrulRPO/s2mvXDNDQK8qlbdxWAqUAGokxVpAxKsfjwxur7jkKjvwvLisZ1NQR5vvFptfQEz0VbaHBJ7KY2HMk85+ziq/qnyEeuYY4p2VpcH8xttb3SAiUzjYYWbKqvT8ve1Rss6LZUFj/H9Oy5V9AKKtQJ2gqj1cMQeMnQBE9k05Oy2/9g5OE1VT4owDInJYq6+NhT5+uFst4PegPjdp/JjsnKy7hXumYciNEQn7eGXsfW3BgWXPG+C+T8AHnBxdcgOVx5davVTJ7KWQ/xFa0xnZg/lo4QhEMa7WX6g0S4XzZmOT9Ks91LDVaU1NYMICHccaLRhezz8/k3YQARTLjl5pYXAkRSCVCRiGwzO4a3ommIvtJ9rIz4lfXghWS/w2im5A7Z/U7VSZi3ci3DKXxAKHTAa6cq3I2g4va435So8Emc+pnju61USki03fR3VnLmViI6FDcl+JX/EkQroUDe8RiV9u7pAJnjcotFucS0xXC+w91xwqvvfDn3vl6K8gAC2QXb+i4xvejPUNNPQsEX2tIliG+4koqoNJz9LLoK+SEWHilGLXy/7fUPNZ1zDZDYE8n6BVYG74XoHmxUsLkW3Q6XWAK4Zpep+E6gmxRYWDUTum76HtFMwS/mgUU83ZJ/7AcOg+nw92Rz9SErLSWFBkzO5EkKbh5qLbJ2FElja5vcLBc06jH3iTFhYLx4AOq7Do4b338VeisjrfrxnpBkoJkKLSWTDVReOj2C9aE=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(8936002)(70586007)(16526019)(4326008)(7696005)(81166007)(70206006)(356005)(336012)(508600001)(47076005)(86362001)(44832011)(186003)(5660300002)(83380400001)(36860700001)(6916009)(8676002)(1076003)(26005)(316002)(54906003)(36756003)(2906002)(426003)(82310400003)(6666004)(2616005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2021 16:12:16.2995 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a83246e7-c910-46ad-694d-08d98e6439a2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT057.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4003
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

