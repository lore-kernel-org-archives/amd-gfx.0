Return-Path: <SRS0=vd7l=OL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0A67C433FE
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Sep 2021 18:08:09 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B048F60527
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Sep 2021 18:08:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B048F60527
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4D6F46EA80;
	Tue, 21 Sep 2021 18:08:02 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2069.outbound.protection.outlook.com [40.107.236.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 62CB96EA7F
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Sep 2021 18:07:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IZSTX/WTdudfrcEh32MiIv+QVgBpvsFSHctOPINKCyNKisgyDrrX0r3WdGrPnGmiKKc1eqIZ5Xr6QeY8xzo5K6/+Uy5Hui03dzXec+EaMeeSm6rDVQBu/6ra4gtrFUg5ScayAibrChkww7tto8g9x5PmppWJlpWQjUmKrHNgwLDX0gD6TgjfBW0ZU1O4WTcrA7gFoOYo3WxZMgjCcn04c2R85ULCBFkKUPdP0cUAJ0SNkMdSQxrB9GurRn12LCh54YLTJoghbaQeySQMMbv6xYCJS1w3smG4d/ky7eWwMMvGiSMPrUdkweV2SRrEvaQdlfvBm9A79YR1PKuszIsO8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=G8YJlgCYBdgPE5vVTtFZa67NZEYNPvBinENAaoZcr9k=;
 b=KT4VyAZ2+VV6CVX2EKTg915RIu3B+TMx9zwWnLeJpRtkd3W8sdpDkPtlYvlLO5R/E5cuURQ+fQ80IeGXpogfyO17/u4Wv7K39owNjRYLwMMjk1WEG0O+fH7GROsOSfu/jfdSNFEcgwixx3md00TeM+Wai4mRwayZY3o+tc2GoD5GMBfeubnTXblTWgKUkmRoeH6QRsII+2v7HC2nGHsN++nHAEdiawVRFT4YKW43D/xHmyNuMpV79TDIMqPjQJYog9lF+rgIi2paxzDIV1/AgfIWwmmTC/gHXCtI9Tn/j5MJdtEaxxfkE3UbJWR9GykkYkFJnHxqRlsWoGiRRbHNDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8YJlgCYBdgPE5vVTtFZa67NZEYNPvBinENAaoZcr9k=;
 b=OXbU/UBM39XK1o6AEDDPBYVuPVqwRudF3YKKj0iZEYQ/eGCwYz90yKf+t0BETt6wx5fpAgzjIiVvt+ZoAnzeOiFpJKX5po9DvH9froGSSGBA/saf8lKXg3IfWqweA+PR3oN6SO1CWQoFiJvg7bgjidyA31IhlPL9CMhtbq3e1fM=
Received: from DM6PR03CA0085.namprd03.prod.outlook.com (2603:10b6:5:333::18)
 by DM4PR12MB5136.namprd12.prod.outlook.com (2603:10b6:5:393::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13; Tue, 21 Sep
 2021 18:07:55 +0000
Received: from DM6NAM11FT042.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:333:cafe::7f) by DM6PR03CA0085.outlook.office365.com
 (2603:10b6:5:333::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14 via Frontend
 Transport; Tue, 21 Sep 2021 18:07:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT042.mail.protection.outlook.com (10.13.173.165) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4523.14 via Frontend Transport; Tue, 21 Sep 2021 18:07:55 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Tue, 21 Sep
 2021 13:07:54 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 31/66] drm/amdgpu: make soc15_common_ip_funcs static
Date: Tue, 21 Sep 2021 14:06:50 -0400
Message-ID: <20210921180725.1985552-32-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210921180725.1985552-1-alexander.deucher@amd.com>
References: <20210921180725.1985552-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2af73827-4236-4424-0605-08d97d2abc97
X-MS-TrafficTypeDiagnostic: DM4PR12MB5136:
X-Microsoft-Antispam-PRVS: <DM4PR12MB51365331F2E565C42416990FF7A19@DM4PR12MB5136.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:590;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8IOnKG+okN7uebnt4PD6lQZB4q2U0FU4JCmFFg+LF0ghxmq9pakkE5bxkXKIH9tGc29s2+1dVaSrr2HQB2pYUmelqPp0jx32O8vhcSbbs2k/JIfBcd2Nu+jgty1IrRvdyF3yuWjhAyOnFuLclftDn5jjkP3gRmOEQh0RYWVZnRtvGZeHSDuStRCa3vccQ1CQO42szfj1qMAMW56WqFWMdceU422/a39DxgNSBPdIpIG9udc3cV3jkYLDKhm5p4FI4VsAizCjeA6vtZGyZgl7AnOrTa20RoLBtwKI1jwZyUVL596hmgykGHndDejuZSHyHVJlnB79KChCsywURwdLAFRcgXMZeXSg9QBY9bLCNrYmskMxpH1gcEQHSZ7QNnYrXgh5xKsAAcWxn7M1d59pA3wH4QH2BkTEOwOpWDNjgNibOr3HFIF73fCWOzheDigm0DnQHTeFmW5KiEbZQm1gDCZfQkiDKpQEegbX7gQgaBArGZIWGdjaSiJix/yYpUdsrWwIUr2W0y/54ICQi0b2njXmtX+R2Qn7PELduLJA6q6VP22xBx5A4MuXGQi2oRyQ84gBCGe6HDUxCDojzxzJwYfEZY948u+Qd71n5JZBJfjQfeUisJjQ4Lkrq+5er2PPEdnshg/Y2oVCOe4780HomLaDAdhfNtykopRzAcI64ZO+RIl3p3B7ryJu30TuSkejaY5M8O8TKD+M4Q4HGc6YjZxs7tujo5WJHt5ZnFWTjqc=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(70586007)(36756003)(6666004)(83380400001)(47076005)(86362001)(5660300002)(1076003)(82310400003)(36860700001)(316002)(6916009)(8936002)(70206006)(8676002)(81166007)(356005)(4326008)(336012)(508600001)(2616005)(426003)(7696005)(26005)(186003)(16526019)(2906002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2021 18:07:55.4968 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2af73827-4236-4424-0605-08d97d2abc97
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT042.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5136
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

It's not used outside of soc15.c

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/soc15.c | 4 +++-
 drivers/gpu/drm/amd/amdgpu/soc15.h | 2 --
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
index f75130cad98e..1b1e9bfd20f1 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
@@ -85,6 +85,8 @@
 #define mmMP0_MISC_LIGHT_SLEEP_CTRL                                                             0x01ba
 #define mmMP0_MISC_LIGHT_SLEEP_CTRL_BASE_IDX                                                    0
 
+static const struct amd_ip_funcs soc15_common_ip_funcs;
+
 /* Vega, Raven, Arcturus */
 static const struct amdgpu_video_codec_info vega_video_codecs_encode_array[] =
 {
@@ -1646,7 +1648,7 @@ static int soc15_common_set_powergating_state(void *handle,
 	return 0;
 }
 
-const struct amd_ip_funcs soc15_common_ip_funcs = {
+static const struct amd_ip_funcs soc15_common_ip_funcs = {
 	.name = "soc15_common",
 	.early_init = soc15_common_early_init,
 	.late_init = soc15_common_late_init,
diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.h b/drivers/gpu/drm/amd/amdgpu/soc15.h
index 034cfdfc4dbe..a025339ac5e9 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15.h
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.h
@@ -31,8 +31,6 @@
 #define SOC15_FLUSH_GPU_TLB_NUM_WREG		6
 #define SOC15_FLUSH_GPU_TLB_NUM_REG_WAIT	3
 
-extern const struct amd_ip_funcs soc15_common_ip_funcs;
-
 struct soc15_reg_golden {
 	u32	hwip;
 	u32	instance;
-- 
2.31.1

