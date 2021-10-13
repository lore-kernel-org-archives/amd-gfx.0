Return-Path: <SRS0=F65H=PB=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4474DC433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Oct 2021 16:12:25 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0573C610C9
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Oct 2021 16:12:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 0573C610C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1D2DE6EA87;
	Wed, 13 Oct 2021 16:12:23 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2069.outbound.protection.outlook.com [40.107.102.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3B4206EA7F
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Oct 2021 16:12:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FtX9g7JeqdMdrN9gqBtfEmUZtZEm8kUn/zG7bRZ6hKJnFzNFSUfNeHZqAQbHYbfL6HD5G8L+MxcksMxC7CI4hXpXLWxvCBHh08ZwcVXbc62oxaav11QF2ziq3o4RBWQzngdD31MhqT3sMFlEVpq93cbTBbg4QxfYqlzITmK5S7Q1g/E2eH0sC7d3cgAOluaAq11wbudATCO9nz7zsAymDPu2aYs3O5OLtTWlT9uMyDc7lyC27rnnnZpNq0I89HW5W+KwivVrCsUBseRjwdPnKmQyddlgbK9b0fM1kJ6xY4T20URNOf+RRd7qUeNxOwbssqrfr8X3qQXA3S5Xd9QcfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VoqFD7KjGah7b9HvTqwjLv+GuC4hD9x4QQHk7NuIw/Q=;
 b=PlV6BOzjFrlvCmzkmhgvh17VrYgKqc0fg1a+yOgDh6jgFP0oDbFJf4Y3vf8+pS/MJl+1lHsLf8euVjFKyCyPk1NcsDknieNreahAZWihPbmpDlXhF0Dc/qVDhCoZ0ZfZaROR4GaH32g91DguiTemJpCACOKcxLAc6KJGFrc4XzfA5fHZ8GIVyFY6ep8klkHcWzgft/MhRZmk57HkIepqhnVy3mN4AlgYPinlR7E8EvIVBqQY2Ua1x/UCSSduq8XR3HR151V/qG3IcD6Y6/RmZ5MSroh76pDQoGMQW16ChnlbEOWuq5AdW1s6a6sIL1uAvrlXNK01dKWNK2NErF4nBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VoqFD7KjGah7b9HvTqwjLv+GuC4hD9x4QQHk7NuIw/Q=;
 b=dsRr2gxi7VNioupcDa0jHeo7VXLJsC5805sPNPR2Gqo26IMlAetcOFXybBe0uHS0xvSfe5a19W/lXeoYE5S9M1eOuhhqbjgsSX3m+WBhRSMnmSNNzVPQc8JPDpJdWe6ilhAfsQx+HuwTNwPqfWbgNrgiAUgACNgpiWgMI+ayOIU=
Received: from MW4PR04CA0055.namprd04.prod.outlook.com (2603:10b6:303:6a::30)
 by BYAPR12MB2727.namprd12.prod.outlook.com (2603:10b6:a03:71::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.16; Wed, 13 Oct
 2021 16:12:17 +0000
Received: from CO1NAM11FT041.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:6a:cafe::3a) by MW4PR04CA0055.outlook.office365.com
 (2603:10b6:303:6a::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.26 via Frontend
 Transport; Wed, 13 Oct 2021 16:12:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT041.mail.protection.outlook.com (10.13.174.217) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4608.15 via Frontend Transport; Wed, 13 Oct 2021 16:12:17 +0000
Received: from localhost.localdomain.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Wed, 13 Oct 2021 11:12:14 -0500
From: Luben Tuikov <luben.tuikov@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Luben Tuikov <luben.tuikov@amd.com>, Alex Deucher
 <Alexander.Deucher@amd.com>
Subject: [PATCH 5/5] dpm/amd/pm: Navi10: 0 MHz is not a current clock frequency
Date: Wed, 13 Oct 2021 12:12:00 -0400
Message-ID: <20211013161200.9052-6-luben.tuikov@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 1e2d9fe1-f67c-43b6-77c2-08d98e643a22
X-MS-TrafficTypeDiagnostic: BYAPR12MB2727:
X-Microsoft-Antispam-PRVS: <BYAPR12MB272792EA55A3BDAED711B73C99B79@BYAPR12MB2727.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:478;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Uv/IgH8tqMewkjPDdwkobhJts4cX0jmgrQeGNHnMj+4LcjSLzF2VHh/Vwm/zPUmLb7QZKNCevKsB2yOMdZ7KV2ZDFhmcjTYZx6HAG4yB7CuaQWusldfMf7ivjYm6CKrCoG3cFvKZPg5/BVYZOSdFsvCdtSVwZ/qxoqXOnVzRhl1k81m6ezPefKwHIljBMKJoj4BbDkG8h24UxHcxheu4nM5tsYr0uhjtls7q2GWzHKedG7Nwh4ceM+Bu1LL0+O2u5Ihk1rU9GZZLfKIW81l/qrM4ZQH1vWdTLl5WGp2xtwFKHjxkXfqy6pE1/EbHlrTYoLBtxVLhU+JB7PTsjwJDYRpSMDDsr/tRKyfyf5dT63IIiF2qg5w1pKkFfvt0/XNlkOIymW4XgWcqQgL3KJkT07ZwnZCCMlqAree6FqS5JLzUjHiTzMlKvzxq7YzHiOB9fC8qKX6akK0EubycWAOAl9Xrs/9yclkGbOMRBGX8LO9ExwXrtN3j2kCb+fenw6hnD2xkpNGLvEvzBWVKt/0xwt1E55qlMJXLwBM+JneFLjWZwdEct/Taq25KAzm4Tz77SxFkO9P3XSSY827wDyYXcVs96Ob0xUxKCfL05C43TjeErgiYb99vE3rdd7sOBHgvHvSzN4Shmiqa5vaiTqFuHjkLhHoDjGIOSOhBaf0tqpgTfgWghGZuI3ijghzHHrDDbi83N+iukcKZcAAUY18WBOERzgU1mRfkFBUWucpyUK8=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(1076003)(26005)(5660300002)(356005)(86362001)(83380400001)(7696005)(186003)(336012)(47076005)(81166007)(16526019)(44832011)(316002)(2906002)(36860700001)(70206006)(36756003)(8936002)(508600001)(426003)(82310400003)(70586007)(4326008)(6916009)(2616005)(54906003)(6666004)(8676002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2021 16:12:17.1397 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e2d9fe1-f67c-43b6-77c2-08d98e643a22
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT041.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2727
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

A current value of a clock frequency of 0, means
that the IP block is in some kind of low power
state. Ignore it and don't report it here. Here we
only report the possible operating (non-zero)
frequencies of the block requested. So, if the
current clock value is 0, then report as the
current clock the minimum operating one, which is
non-zero.

Cc: Alex Deucher <Alexander.Deucher@amd.com>
Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>
---
 .../gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c   | 45 ++++++++++++-------
 1 file changed, 30 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
index 646e9bbf8af42a..de1a558dc81047 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
@@ -1269,7 +1269,6 @@ static int navi10_print_clk_levels(struct smu_context *smu,
 	int i, size = 0, ret = 0;
 	uint32_t curr_value = 0, value = 0, count = 0;
 	uint32_t freq_value[3] = {0, 0, 0};
-	uint32_t mark_index = 0;
 	struct smu_table_context *table_context = &smu->smu_table;
 	uint32_t gen_speed, lane_width;
 	struct smu_dpm_context *smu_dpm = &smu->smu_dpm;
@@ -1279,6 +1278,7 @@ static int navi10_print_clk_levels(struct smu_context *smu,
 		(OverDriveTable_t *)table_context->overdrive_table;
 	struct smu_11_0_overdrive_table *od_settings = smu->od_settings;
 	uint32_t min_value, max_value;
+	bool fine_grained;
 
 	smu_cmn_get_sysfs_buf(&buf, &size);
 
@@ -1296,12 +1296,23 @@ static int navi10_print_clk_levels(struct smu_context *smu,
 		if (ret)
 			return size;
 
+		ret = smu_v11_0_get_dpm_freq_by_index(smu, clk_type, 0,
+						      &freq_value[0]);
+		if (ret)
+			return size;
+
+		if (curr_value == 0)
+			curr_value = freq_value[0];
+
 		ret = smu_v11_0_get_dpm_level_count(smu, clk_type, &count);
 		if (ret)
 			return size;
 
-		if (!navi10_supports_fine_grained_dpm(smu, clk_type)) {
-			for (i = 0; i < count; i++) {
+		fine_grained = navi10_supports_fine_grained_dpm(smu, clk_type);
+		if (!fine_grained) {
+			size += sysfs_emit_at(buf, size, "%d: %uMhz %s\n", 0, freq_value[0],
+					      curr_value == freq_value[0] ? "*" : "");
+			for (i = 1; i < count; i++) {
 				ret = smu_v11_0_get_dpm_freq_by_index(smu, clk_type, i, &value);
 				if (ret)
 					return size;
@@ -1310,24 +1321,28 @@ static int navi10_print_clk_levels(struct smu_context *smu,
 						curr_value == value ? "*" : "");
 			}
 		} else {
-			ret = smu_v11_0_get_dpm_freq_by_index(smu, clk_type, 0, &freq_value[0]);
-			if (ret)
-				return size;
+			freq_value[1] = curr_value;
 			ret = smu_v11_0_get_dpm_freq_by_index(smu, clk_type, count - 1, &freq_value[2]);
 			if (ret)
 				return size;
 
-			freq_value[1] = curr_value;
-			mark_index = curr_value == freq_value[0] ? 0 :
-				     curr_value == freq_value[2] ? 2 : 1;
-			if (mark_index != 1)
-				freq_value[1] = (freq_value[0] + freq_value[2]) / 2;
-
-			for (i = 0; i < 3; i++) {
-				size += sysfs_emit_at(buf, size, "%d: %uMhz %s\n", i, freq_value[i],
-						i == mark_index ? "*" : "");
+			if (freq_value[1] == freq_value[0]) {
+				i = 1;
+				count = 3;
+			} else if (freq_value[1] == freq_value[2]) {
+				i = 0;
+				count = 2;
+			} else {
+				i = 0;
+				count = 3;
 			}
 
+			for ( ; i < count; i++) {
+				size += sysfs_emit_at(buf, size,
+						      "%d: %uMhz %s\n",
+						      i, freq_value[i],
+						      curr_value == freq_value[i] ? "*" : "");
+			}
 		}
 		break;
 	case SMU_PCIE:
-- 
2.33.1.558.g2bd2f258f4

