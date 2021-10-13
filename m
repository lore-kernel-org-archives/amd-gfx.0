Return-Path: <SRS0=F65H=PB=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6412C433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Oct 2021 16:12:18 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A03B960EBB
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Oct 2021 16:12:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org A03B960EBB
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 36AFF88862;
	Wed, 13 Oct 2021 16:12:17 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2051.outbound.protection.outlook.com [40.107.243.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CB4E46EA76
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Oct 2021 16:12:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d69Spnqeujes9lraQJVaGhyWuO28MKYFm5HPqYzcOLAvu5lX5vD1g6bH/gWZIUR1/Q1LpPkid/dOnWtxgWKbpJnXHvr9AEKzDxBOFdOfxhMF9vxiH1/uPmQNdy/dQiQ2fNLhwN97Qg9YVMn19dmfF/GUltsS9wFUHEZCS3q43u85b14MWPqiGbHfU84pwJpvG9rvWt7iwvCTmZmx+re1xtoqay9Euv3CXQEsqI0IfseZ8+DTzopRXj7iX8TwCFVUfsD3j/+1nUEPXaEmlhHd2UmaCbNHIwZILNhv6C/+afhcYAEoX+kzpg9qUvKWC0uaXFZ9+8zitruVZQKzAGpdtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5BZ09jl5qgRicXAtu0CzcxrdH+If04+qbTZ7uAt+keY=;
 b=RCUPzls7cjUsk9VsC1gtsOyrraO0Ppxy6S0OfYkjmv8I4EawdBLM23m49uEc+rSzUtXe3KoH3lzbaT3s5tGT6Vqssdsw+cKBYoEkPMzHcuI62/E6z1vvahZjy0mJug1i+1yq2rX15taNYMcfMhONccbE+2atTNBt+rejiTRBTVkHImCEaT33HHHsUC1O0/1nrdAzG/wROCzWPSsqSVXrGqUxPNMvNjbDIQYQknw6DAVBrRpj5VnyvSPCH+fDvHEdBsD5ESIxvEV4e82Y5tZTeJFyyeuzMmBsV8JQBSK4JwzEAWdN00NUPBnbfzrvlS3oN3CSDMni3ZNwffJK8lGyhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5BZ09jl5qgRicXAtu0CzcxrdH+If04+qbTZ7uAt+keY=;
 b=MsZuEM9pVXBB8zXvXiD/6uDQldI9XQrybj7F8DDKtUyMgqmD2qoqmYM+4meyyBa23yioitegrGmMj58noutZK9MvRu9GsEUlZTF16a4CTWxPa7eomdpuhSA5Owur6mwF7jGFAJJLXNRRrcV9sMnMetvQHiYHavNYvk6z4GRrTuA=
Received: from MWHPR19CA0058.namprd19.prod.outlook.com (2603:10b6:300:94::20)
 by BL1PR12MB5030.namprd12.prod.outlook.com (2603:10b6:208:313::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.16; Wed, 13 Oct
 2021 16:12:15 +0000
Received: from CO1NAM11FT035.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:94:cafe::f9) by MWHPR19CA0058.outlook.office365.com
 (2603:10b6:300:94::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.16 via Frontend
 Transport; Wed, 13 Oct 2021 16:12:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT035.mail.protection.outlook.com (10.13.175.36) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4608.15 via Frontend Transport; Wed, 13 Oct 2021 16:12:14 +0000
Received: from localhost.localdomain.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Wed, 13 Oct 2021 11:12:12 -0500
From: Luben Tuikov <luben.tuikov@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Luben Tuikov <luben.tuikov@amd.com>, Alex Deucher
 <Alexander.Deucher@amd.com>
Subject: [PATCH 1/5] drm/amd/pm: Slight function rename (v2)
Date: Wed, 13 Oct 2021 12:11:56 -0400
Message-ID: <20211013161200.9052-2-luben.tuikov@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 79d52354-8e85-46e9-9616-08d98e643860
X-MS-TrafficTypeDiagnostic: BL1PR12MB5030:
X-Microsoft-Antispam-PRVS: <BL1PR12MB5030AE850F85ADD13D5FC8B399B79@BL1PR12MB5030.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:262;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rSZPPx7dtLqFvEoeSUjEC0Umqj6hP9Jf/g/pgUK0RffVcUrW4Qw11ttUKlTW42vVEQSmUlnCWBHm4BgaQnwh0AG0GC7RSz/5D13wuOEkECEqE9uE1i3gBDpEDVd/WuzRa6xyS6qVZ8ZnZuZeWOd7lcQbImAgBwz5vKbZ1mRlX4+vGKtYyUtIXcS6yiREDb81sXOe+5bIinfLRpLBocPPsgN/+k4XF3n2l3IRDys5JJuk9gX2tMpgvfDGKQLd+t0RI+Dm1IunYDN1KJaGD+TQZJlp9ZvS6wMVCJnq+Nu5RMN9QJU0I8PZ4iXMpcMAd7jcwXNoiEMXcKb1kO6SwuW8DUyj+xoGPZDTd+DkPyoTgb3+QbM4htAE+f2AZbs9gcjdeLajyUkeCIkEbSZx8kj+jtOLR03sF4Un83fA2iHhLpn+3U2Ee24WcXf51TAK1jmUzxK6T/8GWQKMhdYi2EGOVrH4+pfOaY5jyrQCTTODXBy1XAi92POyBefwDsyK9oyaBwiRYptwiUuConT47h1/9s6TinTtO2pYYyPNAS8cVDd7z6XBbLKbohHMLPp3RXi9b//K7jeFmrYXVDLcIABK2BrG6tH/baFYKhFfwSmD3NrGqEN1pH6kwSgoxtiEEflIgM0MsuiRL7yyu6zd+dSSGMnTT6fC5jrf8BZDFPqtepuGLZGfK21sgXB+06DdWaWzdzxbjtkzBGBgRhAeNf1XivPBG6Kt28n0jDh6pTrAbr4=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(426003)(356005)(4326008)(1076003)(26005)(6666004)(508600001)(5660300002)(81166007)(336012)(2616005)(36756003)(83380400001)(2906002)(16526019)(7696005)(316002)(8936002)(186003)(86362001)(70586007)(36860700001)(8676002)(6916009)(44832011)(54906003)(47076005)(70206006)(82310400003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2021 16:12:14.1744 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 79d52354-8e85-46e9-9616-08d98e643860
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT035.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5030
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

Rename
sienna_cichlid_is_support_fine_grained_dpm() to
sienna_cichlid_supports_fine_grained_dpm().

Rename
navi10_is_support_fine_grained_dpm() to
navi10_supports_fine_grained_dpm().

v2: Fix function name in commit message to reflect
the change being done: add a missing 's'.

Cc: Alex Deucher <Alexander.Deucher@amd.com>
Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c         | 7 ++++---
 drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c | 7 ++++---
 2 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
index 71161f6b78fea9..0fe9790f67f5af 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
@@ -1231,7 +1231,8 @@ static int navi10_get_current_clk_freq_by_table(struct smu_context *smu,
 					   value);
 }
 
-static bool navi10_is_support_fine_grained_dpm(struct smu_context *smu, enum smu_clk_type clk_type)
+static bool navi10_supports_fine_grained_dpm(struct smu_context *smu,
+					     enum smu_clk_type clk_type)
 {
 	PPTable_t *pptable = smu->smu_table.driver_pptable;
 	DpmDescriptor_t *dpm_desc = NULL;
@@ -1299,7 +1300,7 @@ static int navi10_print_clk_levels(struct smu_context *smu,
 		if (ret)
 			return size;
 
-		if (!navi10_is_support_fine_grained_dpm(smu, clk_type)) {
+		if (!navi10_supports_fine_grained_dpm(smu, clk_type)) {
 			for (i = 0; i < count; i++) {
 				ret = smu_v11_0_get_dpm_freq_by_index(smu, clk_type, i, &value);
 				if (ret)
@@ -1465,7 +1466,7 @@ static int navi10_force_clk_levels(struct smu_context *smu,
 	case SMU_UCLK:
 	case SMU_FCLK:
 		/* There is only 2 levels for fine grained DPM */
-		if (navi10_is_support_fine_grained_dpm(smu, clk_type)) {
+		if (navi10_supports_fine_grained_dpm(smu, clk_type)) {
 			soft_max_level = (soft_max_level >= 1 ? 1 : 0);
 			soft_min_level = (soft_min_level >= 1 ? 1 : 0);
 		}
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
index 15e66e1912de33..3f5721baa5ff50 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
@@ -1006,7 +1006,8 @@ static int sienna_cichlid_get_current_clk_freq_by_table(struct smu_context *smu,
 
 }
 
-static bool sienna_cichlid_is_support_fine_grained_dpm(struct smu_context *smu, enum smu_clk_type clk_type)
+static bool sienna_cichlid_supports_fine_grained_dpm(struct smu_context *smu,
+						     enum smu_clk_type clk_type)
 {
 	DpmDescriptor_t *dpm_desc = NULL;
 	DpmDescriptor_t *table_member;
@@ -1084,7 +1085,7 @@ static int sienna_cichlid_print_clk_levels(struct smu_context *smu,
 		if (ret)
 			goto print_clk_out;
 
-		if (!sienna_cichlid_is_support_fine_grained_dpm(smu, clk_type)) {
+		if (!sienna_cichlid_supports_fine_grained_dpm(smu, clk_type)) {
 			for (i = 0; i < count; i++) {
 				ret = smu_v11_0_get_dpm_freq_by_index(smu, clk_type, i, &value);
 				if (ret)
@@ -1235,7 +1236,7 @@ static int sienna_cichlid_force_clk_levels(struct smu_context *smu,
 	case SMU_UCLK:
 	case SMU_FCLK:
 		/* There is only 2 levels for fine grained DPM */
-		if (sienna_cichlid_is_support_fine_grained_dpm(smu, clk_type)) {
+		if (sienna_cichlid_supports_fine_grained_dpm(smu, clk_type)) {
 			soft_max_level = (soft_max_level >= 1 ? 1 : 0);
 			soft_min_level = (soft_min_level >= 1 ? 1 : 0);
 		}
-- 
2.33.1.558.g2bd2f258f4

