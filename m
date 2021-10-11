Return-Path: <SRS0=iyzK=O7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2354C433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Oct 2021 08:32:09 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B960460EB1
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Oct 2021 08:32:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B960460EB1
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4EC1D6E440;
	Mon, 11 Oct 2021 08:32:09 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2076.outbound.protection.outlook.com [40.107.220.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 008116E440
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 Oct 2021 08:32:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JZvbkyBhmjjGeXsho/ylwzZieJX9rrlezEDN366lGFB/4BXwIFrbMFOzLdjSy2LdfRxsVVFUZ4KZFZHZy0XXfZW3eADVW04EkbajtCe1aoYRO8cCTLcbwdljtgc+MwGH1/cUOzZDalS4yS3oDfM6jyjbqcz4QJwrsZWac/MFeWV8BA2r2lgoVt7RhWQQ/7olCi9Gd6LHfS79kKiK/Rrrr5v9FWNNECsnc178bYNfe0YICnk3HpRL3po814Rz6HSWkiGys12Oow8/cXypBZBo3pT7dfg+RvVHWllwMLLt17SJRaHnDsqTxxZNvtPRPVfxelHDoS95InqSW6/coS14+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JXVGUVOEgGjA9nMaMzUNJht1RwKCyCppQo3Lh2waLIA=;
 b=PdKdiZViUT4S8t8zXE2a9a384CAJ+qyl6fjZQ2kouI6ZdWbovJE0zzdUQPzDsU5p3H9kcAR1+ws1BC69VF6VDWlKDDYsd4/AZX34dQAJVpzBAVS4Qaan6Say8ichqaDIh2Hv5hl9WKdVYkJa1pR30jLBmI/JgkPbGFg3COc2Ysfs1gs0OyDtyp/19XQRxTW7a0Fb8i8gh1ehxvf68bZRzpO4dSXW95wXoEHCFp5Plr7UiRXrMEGzhU0QU70CaEIkvrhLMdd4U2o6hy3uzPrKMDCTDhO8jhu41wXNIWxwHE3s8m3CYtmJfh6aSJo7OVqFHSZt4kOQ11tx0orNjGIy1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JXVGUVOEgGjA9nMaMzUNJht1RwKCyCppQo3Lh2waLIA=;
 b=rps8xcqiucCSPcKcN5DnX4KYCM/L1SB/+NQLn7CezsgaBSNnbgc9H/F5oAPpfw8Ix8oLyX0LQUM/NrJNjDgqk/pVzgYw2dK3G7VgRzXWShF6l3Nv3wQ51LCFTl3+g0tNFcxCPTZAC+5aJtfvAKCLlp5zjdJt3hpRA8W3m75Dneg=
Received: from DS7PR03CA0202.namprd03.prod.outlook.com (2603:10b6:5:3b6::27)
 by MW2PR12MB2377.namprd12.prod.outlook.com (2603:10b6:907:11::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.18; Mon, 11 Oct
 2021 08:32:06 +0000
Received: from DM6NAM11FT032.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b6:cafe::92) by DS7PR03CA0202.outlook.office365.com
 (2603:10b6:5:3b6::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.24 via Frontend
 Transport; Mon, 11 Oct 2021 08:32:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT032.mail.protection.outlook.com (10.13.173.93) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4587.18 via Frontend Transport; Mon, 11 Oct 2021 08:32:05 +0000
Received: from lang-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Mon, 11 Oct
 2021 03:32:03 -0500
From: Lang Yu <lang.yu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>, Huang Rui <ray.huang@amd.com>,
 Lang Yu <lang.yu@amd.com>
Subject: [PATCH] drm/amdgpu: query default sclk from smu for cyan_skillfish
Date: Mon, 11 Oct 2021 16:31:47 +0800
Message-ID: <20211011083147.577024-1-lang.yu@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1835c0a2-b406-4f4b-5967-08d98c919b80
X-MS-TrafficTypeDiagnostic: MW2PR12MB2377:
X-Microsoft-Antispam-PRVS: <MW2PR12MB2377D4777DFD5B660216B1EBFBB59@MW2PR12MB2377.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:376;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: s+ZYxguUSW9QRihvLgUfM7H5Nb7X8QYKq92ZR5yv0CS2WvClmuOAV7DxS/rPZVFqpjdEnPpoNY0BPQFrIOxN7ze8pGqGMjTi9n12RJpVfJTnIQZLL1GDKRt2XQ55vQ1q5y5NmjI7W6jXtEw0/yYqsbeVlaKjGzR7sMT92yvo258cUa4A70d9tsIWfxM1U3RYurvHYtWqbpzkSYQmi1bFv3r6mptiH/gxR3bIPZaEPzHSo4pEnxxjSfaF0cHVKKlb+wnjkyNenl0xVVsG2wYoEJ1cb+u26X9i5UoXomiLyegqonuza9Jg09FHsKGIoC2r2Lm7YRU0b9QPu2Yb5w/A1Gm+MhSPmf6er6xooEdncfJ9ifJA7iZ5dYfAAKuMKTegntPrZEeqWNypVlFxVYyHlgYMtWhdg6mc558DssJWI18aDzjiNxd+2KzGCl6x+2KpuJ2wOAOQohchx8/ZojcbwQk+Qs45dpveM33elLm6C7aUFkWbrxGjleZP3XmNtpRzKB1moxjrAulO6wQUEiG7DN973+HH575Qlm+KlatdJpkR6EOefk8CqYVoD5MBwjl0mxHPuCdqpis8LwSJeTIHzo8UOFuiwc24I80FO17J7KKduGpcAMOH7cjFy64n7BMUlKkwky3NW7V5l3eggeOsZoyfo43DRr4BYbCWpwyVMnx5aJGUxJ3ZiH04mOTuspI/770C9lWh7E7WGvtwjiOzDn0DNuvfEtZwY5ZCqhBwwcY=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(36756003)(2906002)(6916009)(186003)(83380400001)(16526019)(36860700001)(8936002)(508600001)(6666004)(26005)(8676002)(82310400003)(81166007)(2616005)(7696005)(336012)(86362001)(47076005)(1076003)(426003)(316002)(356005)(44832011)(70586007)(70206006)(5660300002)(54906003)(4326008)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2021 08:32:05.5873 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1835c0a2-b406-4f4b-5967-08d98c919b80
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT032.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2377
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

Query default sclk instead of hard code.

Signed-off-by: Lang Yu <lang.yu@amd.com>
---
 .../gpu/drm/amd/pm/swsmu/smu11/cyan_skillfish_ppt.c  | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/cyan_skillfish_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/cyan_skillfish_ppt.c
index 3d4c65bc29dc..d98fd06a2574 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/cyan_skillfish_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/cyan_skillfish_ppt.c
@@ -47,7 +47,6 @@
 /* unit: MHz */
 #define CYAN_SKILLFISH_SCLK_MIN			1000
 #define CYAN_SKILLFISH_SCLK_MAX			2000
-#define CYAN_SKILLFISH_SCLK_DEFAULT			1800
 
 /* unit: mV */
 #define CYAN_SKILLFISH_VDDC_MIN			700
@@ -59,6 +58,8 @@ static struct gfx_user_settings {
 	uint32_t vddc;
 } cyan_skillfish_user_settings;
 
+static uint32_t cyan_skillfish_sclk_default;
+
 #define FEATURE_MASK(feature) (1ULL << feature)
 #define SMC_DPM_FEATURE ( \
 	FEATURE_MASK(FEATURE_FCLK_DPM_BIT)	|	\
@@ -365,13 +366,18 @@ static bool cyan_skillfish_is_dpm_running(struct smu_context *smu)
 		return false;
 
 	ret = smu_cmn_get_enabled_32_bits_mask(smu, feature_mask, 2);
-
 	if (ret)
 		return false;
 
 	feature_enabled = (uint64_t)feature_mask[0] |
 				((uint64_t)feature_mask[1] << 32);
 
+	/*
+	 * cyan_skillfish specific, query default sclk inseted of hard code.
+	 */
+	cyan_skillfish_get_smu_metrics_data(smu, METRICS_CURR_GFXCLK,
+		&cyan_skillfish_sclk_default);
+
 	return !!(feature_enabled & SMC_DPM_FEATURE);
 }
 
@@ -468,7 +474,7 @@ static int cyan_skillfish_od_edit_dpm_table(struct smu_context *smu,
 			return -EINVAL;
 		}
 
-		cyan_skillfish_user_settings.sclk = CYAN_SKILLFISH_SCLK_DEFAULT;
+		cyan_skillfish_user_settings.sclk = cyan_skillfish_sclk_default;
 		cyan_skillfish_user_settings.vddc = CYAN_SKILLFISH_VDDC_MAGIC;
 
 		break;
-- 
2.25.1

