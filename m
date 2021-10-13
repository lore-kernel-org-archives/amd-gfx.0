Return-Path: <SRS0=F65H=PB=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68426C433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Oct 2021 03:11:09 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 31E3F60F94
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Oct 2021 03:11:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 31E3F60F94
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 96B7E6E071;
	Wed, 13 Oct 2021 03:11:05 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2048.outbound.protection.outlook.com [40.107.212.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 521436E06D
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Oct 2021 03:11:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F45FQrD7/fS6k7HtdrUmAOp9YRObSYJaaJBjSWcK4Dt5raTUtmpnFSzm8dBASEydBIFtUhPExJ3/ccHnzryOo5No673CamxT+1Gzs0MQJ2mpWEizMQTRWJ7vVkoJ5vHPW+BZHCb2IZ6lAehhayO0IKVuUn7lAoEI3vj+BNDzmUxWN3+eFy845xxPW6DOiJm/5rzrwtBp9FhKMqF+fqaNElI72y+EKsPbNiLdpZ2teqclKOaADyt7QKR6VAEXpdKBMqD8uWyguGmy1x4fg8SnJqaNOGQHq9IkEVHcU1RJ5taEZoUG7MRow4KKLvr6Q5AgbwHTN11kO8yjmfomx07vpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=71H2gGjCDFhYFUtfGBJPp9SklKUjZIet4xyG4xWsq2c=;
 b=ClQ/4UbS9rD5tkAmjPKeh4cPRqlYMldioCMTw/rZiVU5qyxiTVdB8axLsgEtXE0KW9uBwAvvkr4hmNweQMzrnlPwOPD35PMDDQiQHiN834XW9UnGYF3dgwQUsv8BTJVwl8H3giHVAsdaUJmAYzQ/QSkyT9zMIH2XMWtdt+WIeCXxtMYMgRIgSHBXXwdpABKYpIoKtdb4ITTY51Kcrpp/2Z74Ktl4k5jbVUxLeevVN/fAbrWu44G3IRaLRh5jCdlgcMAJAHKNA+ndzDLJTdjszP9yID6sqWb8sfywFt4jSfqbDQBs816DUzFtr25JJmt4IHFC1aXifLKsttPV2uOU6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=71H2gGjCDFhYFUtfGBJPp9SklKUjZIet4xyG4xWsq2c=;
 b=35/TvMtPDBOqGmNdoXZdzMjjwYZImd8s5twUjFfGSRjonHSF79vzReE/lAUeSHkVe/DwA8/QhgiNRy7ydOnArUMmVyjSu/doQ997BqH+0eySFotXxvc8wUTbv4ck2fNwCSQXZsWRuYXd79J8mOF4tLLA5fAi6itQ5yNiPK1jqmM=
Received: from DM5PR19CA0016.namprd19.prod.outlook.com (2603:10b6:3:151::26)
 by DM6PR12MB4620.namprd12.prod.outlook.com (2603:10b6:5:76::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.25; Wed, 13 Oct
 2021 03:11:01 +0000
Received: from DM6NAM11FT039.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:151:cafe::e) by DM5PR19CA0016.outlook.office365.com
 (2603:10b6:3:151::26) with Microsoft SMTP Server (version=TLS1_2,
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
 DM6NAM11FT039.mail.protection.outlook.com (10.13.172.83) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4608.15 via Frontend Transport; Wed, 13 Oct 2021 03:11:01 +0000
Received: from localhost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Tue, 12 Oct
 2021 22:10:58 -0500
From: Luben Tuikov <luben.tuikov@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <Alexander.Deucher@amd.com>, Luben Tuikov
 <luben.tuikov@amd.com>
Subject: [PATCH 4/5] dpm/amd/pm: Sienna: 0 MHz is not a current clock frequency
Date: Tue, 12 Oct 2021 23:10:41 -0400
Message-ID: <20211013031042.53540-5-luben.tuikov@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: e49324dd-64cc-46ef-1f8f-08d98df715d6
X-MS-TrafficTypeDiagnostic: DM6PR12MB4620:
X-Microsoft-Antispam-PRVS: <DM6PR12MB4620EFA5DB55C7E18955708699B79@DM6PR12MB4620.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:597;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5fMPqTx4pQuh1ow49fD0CyRjLOqP8/0jVKxPW+wTUNaPZbkRzsm/pOc+MB5g5rPcSMskdAcKpA1+ET/dSkzxCoDT1oUQtLJqYHpCB52JDYdnFM2QMkN4CXiZnYvsDmvlNAs3bZzhpordBLVInJAD7XZ58B7VjB3w1/Nym+BAR3RL4bngUFlaJAODHBybxKLV29WpReTsNtXEmEQcaypI7oMe9DL0VnB/sGMlI3/0yLCGq6vHwIGBsBuH1YK/N695HN8/12z/MLlhkSf0M+qOT6KgMb9yXQQUPGcC2d3YP0Y+POi+AQAuHVJpZTy4ya2uX/2BZDeZg9WeKJwCw3IQh3iZwuDN1GyYhVYw2RdrynR8XR+oG+vAA0dkEWXSoEPVSl1xe9HpgMYOz+3Q474fJEvubPhg0qz+zmcIM6lApaGhb9NpDlUh5BynWIGgblEagDkkA3lNTLuLazDsboy9T5iah6d98cxwSF33x15SWkLBIO7WkaVal+65DG4lo2DPOjsvqmR2Y8cAMWCnmFV1nGT0gM0BGwMvYD3d/GVmqn7mmrVA9Y9WSQpkxLRLMRRGa2Vcoau9JUIpHE8msmixrhBeLXYfjMTHPbkNhUMlKncEPiwVrvz+xSsLgJR9kWlVnJK6gXwSm0SOhy+9U1TBH1+78qnI8Lz9tIVgCrFw2XVs75eRq9YTqcTxgOdKb7ryGq0igVBjDCYoAu9NSLAnRf8NVKMpVoIpmlbBezCwD/s=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(86362001)(54906003)(70586007)(81166007)(508600001)(1076003)(356005)(6666004)(83380400001)(70206006)(82310400003)(8676002)(6916009)(316002)(336012)(5660300002)(2906002)(44832011)(36756003)(8936002)(16526019)(36860700001)(186003)(47076005)(426003)(4326008)(7696005)(2616005)(26005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2021 03:11:01.1619 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e49324dd-64cc-46ef-1f8f-08d98df715d6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT039.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4620
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
 .../amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   | 57 +++++++++++++------
 1 file changed, 39 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
index f630d5e928ccfe..00be2b851baf93 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
@@ -1054,10 +1054,10 @@ static int sienna_cichlid_print_clk_levels(struct smu_context *smu,
 	int i, size = 0, ret = 0;
 	uint32_t curr_value = 0, value = 0, count = 0;
 	uint32_t freq_value[3] = {0, 0, 0};
-	uint32_t mark_index = 0;
 	uint32_t gen_speed, lane_width;
 	uint32_t min_value, max_value;
 	uint32_t smu_version;
+	bool     fine_grained;
 
 	smu_cmn_get_sysfs_buf(&buf, &size);
 
@@ -1077,6 +1077,22 @@ static int sienna_cichlid_print_clk_levels(struct smu_context *smu,
 		if (ret)
 			goto print_clk_out;
 
+		ret = smu_v11_0_get_dpm_freq_by_index(smu, clk_type, 0,
+						      &freq_value[0]);
+		if (ret)
+			goto print_clk_out;
+
+		/* A current value of a clock frequency of 0, means
+		 * that the IP block is in some kind of low power
+		 * state. Ignore it and don't report it here. Here we
+		 * only report the possible operating (non-zero)
+		 * frequencies of the block requested. So, if the
+		 * current clock value is 0, then report as the
+		 * current clock the minimum operating one, which is
+		 * non-zero.
+		 */
+		if (curr_value == 0)
+			curr_value = freq_value[0];
 
 		/* no need to disable gfxoff when retrieving the current gfxclk */
 		if ((clk_type == SMU_GFXCLK) || (clk_type == SMU_SCLK))
@@ -1086,38 +1102,43 @@ static int sienna_cichlid_print_clk_levels(struct smu_context *smu,
 		if (ret)
 			goto print_clk_out;
 
-		if (!sienna_cichlid_supports_fine_grained_dpm(smu, clk_type)) {
-			for (i = 0; i < count; i++) {
+		fine_grained = sienna_cichlid_supports_fine_grained_dpm(smu, clk_type);
+		if (!fine_grained) {
+			/* We already got the 0-th index--print it
+			 * here and continue thereafter.
+			 */
+			size += sysfs_emit_at(buf, size, "%d: %uMhz %s\n", 0, freq_value[0],
+					      curr_value == freq_value[0] ? "*" : "");
+			for (i = 1; i < count; i++) {
 				ret = smu_v11_0_get_dpm_freq_by_index(smu, clk_type, i, &value);
 				if (ret)
 					goto print_clk_out;
-
 				size += sysfs_emit_at(buf, size, "%d: %uMhz %s\n", i, value,
 						curr_value == value ? "*" : "");
 			}
 		} else {
-			ret = smu_v11_0_get_dpm_freq_by_index(smu, clk_type, 0, &freq_value[0]);
-			if (ret)
-				goto print_clk_out;
+			freq_value[1] = curr_value;
 			ret = smu_v11_0_get_dpm_freq_by_index(smu, clk_type, count - 1, &freq_value[2]);
 			if (ret)
 				goto print_clk_out;
 
-			freq_value[1] = curr_value;
-			mark_index = curr_value == freq_value[0] ? 0 :
-				     curr_value == freq_value[2] ? 2 : 1;
-
-			count = 3;
-			if (mark_index != 1) {
+			if (freq_value[1] == freq_value[0]) {
+				i = 1;
+				count = 3;
+			} else if (freq_value[1] == freq_value[2]) {
+				i = 0;
 				count = 2;
-				freq_value[1] = freq_value[2];
+			} else {
+				i = 0;
+				count = 3;
 			}
 
-			for (i = 0; i < count; i++) {
-				size += sysfs_emit_at(buf, size, "%d: %uMhz %s\n", i, freq_value[i],
-						curr_value  == freq_value[i] ? "*" : "");
+			for ( ; i < count; i++) {
+				size += sysfs_emit_at(buf, size,
+						      "%d: %uMhz %s\n",
+						      i, freq_value[i],
+						      curr_value == freq_value[i] ? "*" : "");
 			}
-
 		}
 		break;
 	case SMU_PCIE:
-- 
2.33.1.558.g2bd2f258f4

