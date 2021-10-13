Return-Path: <SRS0=F65H=PB=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9A3BC433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Oct 2021 03:11:10 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 81DF260F94
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Oct 2021 03:11:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 81DF260F94
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 97F056E075;
	Wed, 13 Oct 2021 03:11:05 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2087.outbound.protection.outlook.com [40.107.92.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 871C06E071
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Oct 2021 03:11:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KIe8KsytzYUU8NWoAFtDqMdqAbIbXFDWMgi2ynUonWHQ9V5RoLrV4fpc5QEa0tUcrWv77B+kFd4peD92iqgyk7P5ommLNf1lwGzKG5OwDgMBEKd5UKr+8kz4k24Ut8Rq3iNNaHdisb2KXzycNs8V1TaDFk2sBKWhIfALdEvSik/YufbwwzW+HVsyAIHAXYPu9BaRgq7QVeFhzyrsSByawBNCPP/YUgHwDDP0g2i2LcVFOnyf2QVJ2Lejkb9uxpiYKfeD1YoZKRX2I+Tl2SY0unggyXpE6hVMvde6oy4WT4Eve4gPjnt77Njk48JNeREq6XanUd5XKmz1CCWDQljuZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W7TJC1k05YAwzcYAvmdxLMoVCNSoCDPMy9fd3zUvwQk=;
 b=n4NFO/rUfBswG3af6nVfs+thPZuho/06V+ZCzQb4Sot+/vDsfqy+DpY4/U+PpBeVP12GKcQYitTvuWwdCce8qpPdhXAwpTq81W4q4Z6murkoCn/GjVCAwDPlNu0oQn8xFUeGj3zKv1+3zx444gO3Z+cI6+zdgjHtfW25zgz+R5pEpjDYxTo9rM+g1Yq1u4FsPzd/5adiQF9uyX1G0gwi2q0nrwh4VR6LXcOOEI4Qsvc5e5LUoJ2BgmFz24J/2+OAh1cLUOwORtxjSd2Rt92jbLGm1a6EEbsw812MH+p+AacnTFSQX3XbtIxUK/yrIIe1cqyrWuMohGs3XIgoDNKvCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W7TJC1k05YAwzcYAvmdxLMoVCNSoCDPMy9fd3zUvwQk=;
 b=1xMHIsPpuldBmFXxfLwzU2i8CaH6SB6P8hLxunQJOJmypz/0w6O7OfeKtC3SmSUDavxeGfXUpIAgBoS4zwR3n429ZgcAUlHJO0AShrwbxjx7w+I7Z1rr1v8p+raZuWUMBvo0mAk03KwL2wT2T0qFUxcbC1Am4lor0Cd5PaAkPek=
Received: from DS7PR05CA0019.namprd05.prod.outlook.com (2603:10b6:5:3b9::24)
 by BL0PR12MB5523.namprd12.prod.outlook.com (2603:10b6:208:1ce::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.22; Wed, 13 Oct
 2021 03:11:02 +0000
Received: from DM6NAM11FT062.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b9:cafe::6d) by DS7PR05CA0019.outlook.office365.com
 (2603:10b6:5:3b9::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.14 via Frontend
 Transport; Wed, 13 Oct 2021 03:11:02 +0000
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
 2021 22:10:59 -0500
From: Luben Tuikov <luben.tuikov@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <Alexander.Deucher@amd.com>, Luben Tuikov
 <luben.tuikov@amd.com>
Subject: [PATCH 5/5] dpm/amd/pm: Navi10: 0 MHz is not a current clock frequency
Date: Tue, 12 Oct 2021 23:10:42 -0400
Message-ID: <20211013031042.53540-6-luben.tuikov@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 3b1f4d2f-f9c3-4e05-d551-08d98df71639
X-MS-TrafficTypeDiagnostic: BL0PR12MB5523:
X-Microsoft-Antispam-PRVS: <BL0PR12MB5523DD1465D5742573608D1C99B79@BL0PR12MB5523.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:478;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2ZB5m3PlXh8d/j8F4qabXftpShCRfPW7B1M6Ium+tocSe+2oJ/FvanLKesWHq/wEbYzamSjYX3u14KGXMdV8rlX6Jwwm8norzTlacs7WpVIa8TwnJjgXiTvjU5QJWLiHIMihhXyLmExKNR9ZNyb1XUSjk+mQh1hq/wRMdEFqLQWRXkrDPToMq70SXSXSMeWTmkTZSPJEsoICugdClavJPp39EvMEmOJ8Zm6CoPpNL52fkQQY+hsTrS5OJn44YJfEHitS/stSPhIKwwuWBsdy97gmco9DO90/mMfG7oHwkhOHz3f/RINjE41tdz0Nsw4B43nmnScWsOpuFXgUwu7OlTTVdUO2w6SZJ64IjFZRQ2Avl0RhLNeb4NltTV+Khcg4eLdNJmA+coMabfIWttaZfk+tS4VdPnGhjVadpg7dOAzedNdbPmH+PFYbftgftVVsLvAoM21s9v8S7kIikolgAwr8FR+g1XzXg1AZvEjPCOhZP0pEr6gunyMEvy3M250rnBz5GrvRk8munEEEqKlkMpScq5pTdAGxoWf7uFe7V7ct7pQmGclMV0vm0UokRDNI5MG77Le/nVyD5JTZEwJj1GHfBXy1IMXJUbo1jRDb5aqhzRam3BkGOzop/jjQXbzL9uqGvPXpkxTgOe9DlxQpcevKb0BvKks8yVuxYY27tIIvAHK0HLlF1dQVarazHbYN3JpSuZeHM9V3E9pT2WWX8fmMQfyBbkd5tc/TJxKjca4=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(47076005)(8676002)(6916009)(426003)(5660300002)(86362001)(82310400003)(83380400001)(26005)(36860700001)(2616005)(8936002)(36756003)(6666004)(186003)(16526019)(336012)(54906003)(44832011)(2906002)(1076003)(508600001)(81166007)(70586007)(316002)(356005)(7696005)(70206006)(4326008)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2021 03:11:01.8153 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b1f4d2f-f9c3-4e05-d551-08d98df71639
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT062.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB5523
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

