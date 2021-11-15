Return-Path: <SRS0=ctnh=QC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EB26C433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Nov 2021 07:42:40 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3EFB561BE2
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Nov 2021 07:42:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 3EFB561BE2
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A8D876E44A;
	Mon, 15 Nov 2021 07:42:39 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2086.outbound.protection.outlook.com [40.107.236.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DC87C6E44A
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Nov 2021 07:42:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ef9wEQdurOR5l/k7hj/igfKN5VePJZYjLR6bdJg/Ve/UkwMjX3u1qvOdZXexTFfFHOWHZ4v5UwRfDLlMSt6vEKy354xdNWRxFmQqScmO2iITtnSCNrXMDl/WFtLGYrfHEEZub7ukmErwnGjxmLQN+k84Oyfr28VwXWp1k4gKG2tJXvSswS2HFGr3CY0KsoNQI+YoyUeIR9lDanNWk8W6EwtUzUFWCaXeQ+EzCX21s7UOp14AQjm3RFXjo8xcw9lpq1VMs2yjqjQvFr11YljapDDE1a04g+kXFmdJCv3AYoNkYnOmdPDVX8pIDorLav+B0gbH9r2nOo04bvC68+xrYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pn6qf2WFSY9/XPKmafcMkYMU5pdH8lKf8ABwMhypTvU=;
 b=VEcKjno8/jDL9NcHhb94se8wXjZdNbffpYGDrL1UjSH8bAjq9sAvQCWUHQlK1b85hzXtLmIKQqi4vFLxQiuMDUtmPzWE6PmRNXIG5dp2Jm8+1lIluxG4RT/uGuH4rr2ODhHkMDYy1weeTN53Z3zgGG2DV9FTOjs2yXI0xV/+B7WTD1mGsxW7JWDhUR7nBEJkcnL0O58H4Kc5Aq96QN76qmEPzlullXRzE4QSfDku7rw7e6/zYpeGU1JCL/yLZoPs9zEukjz7V/txVaRkpf4QsCRBYDo2H4AhneMfJ/NjgTHMuJOSNiOQgGiIBLKzThGOYUett3M+BOsv1ikyly3pVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pn6qf2WFSY9/XPKmafcMkYMU5pdH8lKf8ABwMhypTvU=;
 b=n8ii7wNF+UxDXXKi83EcQUDria8zbwYc/jk3IpNIJLiYDhlCV+7j96BzPpjBV6N+JwkTaVuhtrKkPlETaBUVVxQg+7Sgk5oLayI0qql4SVPI3k+7Tau4+LuoUfcMK/DMgM0Q4ymCilS8Is2NEinR/swUXLB0ReCx4wgpCE+uxmk=
Received: from CO1PR15CA0104.namprd15.prod.outlook.com (2603:10b6:101:21::24)
 by BY5PR12MB4870.namprd12.prod.outlook.com (2603:10b6:a03:1de::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.26; Mon, 15 Nov
 2021 07:42:35 +0000
Received: from CO1NAM11FT020.eop-nam11.prod.protection.outlook.com
 (2603:10b6:101:21:cafe::c4) by CO1PR15CA0104.outlook.office365.com
 (2603:10b6:101:21::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.25 via Frontend
 Transport; Mon, 15 Nov 2021 07:42:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT020.mail.protection.outlook.com (10.13.174.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4690.19 via Frontend Transport; Mon, 15 Nov 2021 07:42:35 +0000
Received: from lijo-u1804-kvm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Mon, 15 Nov
 2021 01:42:32 -0600
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/pm: Remove artificial freq level on Navi1x
Date: Mon, 15 Nov 2021 15:42:16 +0800
Message-ID: <20211115074216.16025-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2bbea7b2-310b-40bc-e352-08d9a80b7d70
X-MS-TrafficTypeDiagnostic: BY5PR12MB4870:
X-Microsoft-Antispam-PRVS: <BY5PR12MB48703B61B421B3DF5AEE4E7A97989@BY5PR12MB4870.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2276;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ebO937eqyBWa0EU7ugrKyMuD8/AV0Vc1JU8zmlIUOCeUGjDkaiIoa2OXGtwzaWKaWSNmfkWm18UYRcWSzd1CFDSC9Vojezh7iwg2MoTIc6jXLMGqsyT8ay+ZMwDjgJuHSDuRpuVpzVTyBKgBzPKiICMPvR0Si4USGvHXWHpAIyD4Ua8Q6u0bOf0/PZJ4j4AnCUX3f8kClboXsXVKarBBUDwB0h/bC3L9hQziDnYc1eCcSncYdfUyTSiunfLFv5IzVYpyL1t4xp9vSLKTMOGKdpi9aAzpl2tMi5AWU2ckwIRZiCx+1QByfmXhoE9TlzBHJ3JKj6LiciU/IS2eUnDkpscbKBkHvwOApf+hLUSllIZzdDEVdrON0hbUTQy7VYriOEUhAeMd3+3o14QQAYgrAqCjBvwiTRL4keTk3GNjPmlACBPFgtviWTjIIpkH0noOLC/eJdJaQwG09Krs6/bzqgyMOAzRRj2uq1jBfmtzhiawB//iAap2ekalAindXNXL2t+eLI/Mlt6BN8TitwYx7SzDX/bFrXdN3scFPnngybpHMnhe4b6y04L0cPS4KJwmzGBaYc9iQC2ZFJv5flf+VHgwryL9ZZrMc0mLXtdRGrdB3R29UIFsaC84yfmLUPh1OxjneqA/pB0RZ7Mio2uJK7BnHKVXQiGkaD9tlSRu+SSHXIpyOkFm82efF0aswLNrskS44I08BPz9OhE5+AMK5nSPNeKTfeNvmFi9XewEPMIcYTdiYHcuaSlO6h5B0HBC
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(70586007)(70206006)(5660300002)(426003)(8676002)(336012)(2906002)(16526019)(86362001)(186003)(54906003)(44832011)(8936002)(508600001)(6666004)(2616005)(316002)(83380400001)(82310400003)(1076003)(26005)(6916009)(4326008)(36860700001)(81166007)(36756003)(356005)(47076005)(7696005)(32563001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2021 07:42:35.0733 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bbea7b2-310b-40bc-e352-08d9a80b7d70
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT020.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4870
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
Cc: Alexander.Deucher@amd.com, Evan.Quan@amd.com, kevinyang.wang@amd.com,
 Hawking.Zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Print Navi1x fine grained clocks in a consistent manner with other SOCs.
Don't show aritificial DPM level when the current clock equals min or max.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
index 71161f6b78fe..60a557068ea4 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
@@ -1265,7 +1265,7 @@ static int navi10_print_clk_levels(struct smu_context *smu,
 			enum smu_clk_type clk_type, char *buf)
 {
 	uint16_t *curve_settings;
-	int i, size = 0, ret = 0;
+	int i, levels, size = 0, ret = 0;
 	uint32_t cur_value = 0, value = 0, count = 0;
 	uint32_t freq_values[3] = {0};
 	uint32_t mark_index = 0;
@@ -1319,14 +1319,17 @@ static int navi10_print_clk_levels(struct smu_context *smu,
 			freq_values[1] = cur_value;
 			mark_index = cur_value == freq_values[0] ? 0 :
 				     cur_value == freq_values[2] ? 2 : 1;
-			if (mark_index != 1)
-				freq_values[1] = (freq_values[0] + freq_values[2]) / 2;
 
-			for (i = 0; i < 3; i++) {
+			levels = 3;
+			if (mark_index != 1) {
+				levels = 2;
+				freq_values[1] = freq_values[2];
+			}
+
+			for (i = 0; i < levels; i++) {
 				size += sysfs_emit_at(buf, size, "%d: %uMhz %s\n", i, freq_values[i],
 						i == mark_index ? "*" : "");
 			}
-
 		}
 		break;
 	case SMU_PCIE:
-- 
2.17.1

