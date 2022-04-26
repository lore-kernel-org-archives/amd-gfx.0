Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AB24C433FE
	for <amd-gfx@archiver.kernel.org>; Tue, 26 Apr 2022 09:47:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7CC1910F1C0;
	Tue, 26 Apr 2022 09:47:42 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2051.outbound.protection.outlook.com [40.107.236.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DCF9110F1C0
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 Apr 2022 09:47:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oQp2iGCXxktEDRCTTWOweUdyNjm7jttWn20qJVGMMwzFMf7YUFrmvsnz0WqBjsaH7FfcXhmV2qq7EMLHYRE86lg8ISZqdsi88jjiOW+lp9BHVcHtKG0h7toAZRTQX6w5a/QFkhWZUSv8MVjJYAgNmlMr2u/WjPjryGds35XrodCZYr4Eju4FRHKtBg12vyhyuyKbIHD/Ba423dI9SaqiHg+XIpzkS7FnsdzmTuitlkRronCYUSHXRdzX734Zniwb5cfhC303Mwn11+U4K1AMgFlQU1sSm2PO2qECnK5uI8yin9kYM6NoBHKXcIUp4G8jGOMA54vhMZimL8LSgPIjlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xG5/w6onVoWD9kjRUhcxYUsQ5bc56sN0XTvpfLo3jLA=;
 b=fW4vl+7Fwrvaf6JsUbQEuFpoPlbVvpBwX7RfQnF8+lk2sXnaUWdI3ClMXhxLwqGO0egVcysm5uiD9oXvvSuhi9I3UWYcTxaLpuwKfiLUqzo+c8Gnlr3/5SpU/PM7oFpw2dTB0j3sLLXSG3Kq0qO3vSNLvjiHS52lUwc+Ita+D6OG+FXZ4s9saXTyJEG6pcErxVhwwhjT6P7kHWXdb2zx/Srkpe0R+digdjnvRthf9v0AVtv5uAP8kKTIIf9a312QhKOoc9A6mhEUSCh6zB/sEdH57gm2Jt0kPHfR1xGDcR+//cvq2amUumB5DaS8FnWv94k1UyNx0CH7hja3Va681g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xG5/w6onVoWD9kjRUhcxYUsQ5bc56sN0XTvpfLo3jLA=;
 b=4lT5TnMrObonSbA5MTb+Q+HFOf6dV1/EuFYcyZiwz1cvdFEUG1KFmXYZ/kD+C7+TBWEfJ7G5C9lvQfHZdn2lPI5Rh9z55xsm/d5/r2t5XUv2Ynw0HhNo3w8JUpwjZ/Rjg3jC6Cj332f6+a4foQmSMW/GYSSumZRhIQhwe7uW0CQ=
Received: from MWH0EPF00056D04.namprd21.prod.outlook.com
 (2603:10b6:30f:fff2:0:1:0:c) by MN2PR12MB4093.namprd12.prod.outlook.com
 (2603:10b6:208:198::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.13; Tue, 26 Apr
 2022 09:47:38 +0000
Received: from CO1NAM11FT037.eop-nam11.prod.protection.outlook.com
 (2a01:111:f400:7eab::204) by MWH0EPF00056D04.outlook.office365.com
 (2603:1036:d20::b) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.4 via Frontend
 Transport; Tue, 26 Apr 2022 09:47:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT037.mail.protection.outlook.com (10.13.174.91) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5186.14 via Frontend Transport; Tue, 26 Apr 2022 09:47:38 +0000
Received: from equan-buildpc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 26 Apr
 2022 04:47:35 -0500
From: Evan Quan <evan.quan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH V2] drm/amd/pm: fix the compile warning
Date: Tue, 26 Apr 2022 17:47:20 +0800
Message-ID: <20220426094720.436117-1-evan.quan@amd.com>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: af3784c4-272e-4b1c-b1b4-08da2769cc7d
X-MS-TrafficTypeDiagnostic: MN2PR12MB4093:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB4093E0079D1300BE1A1393D1E4FB9@MN2PR12MB4093.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AjyAHFSY5NyCaRXp5HpHn3g7fDngFB2DBNxU8Je6678MsfVqYQH8bNLbFDPa4v3+80jkkuR3rH7e3LnKdXi9vM/nSDYcCFQ5ZKeN6TdKGdk5qvOzVfduOh6IKf2aLCYHEzS5dVHUbM9EvhT4Mp3x2uNEzKs1tiFFcVC4IkHP1z1DWjpuOOxiTQcISg/tNuqYSQVAOP143nQSTburJuzMAK2MmeQ/NV3wx01F+0MnhxmC0FETdUW8Z2R9UCia6Q8VFoMUg8HNkLx5ork1Z9pP07emaXxkCd/dFQNe+9ER8sctf6kZfxCdS/oazand1qhdvEomYMq7VC5583hdVj7USgJMY9Oi5sFszlrf57IYU0B8jk3x6PAg0podKQUC/R61gEuqQX2id4Nzcss4bJa3AbC3orpXi6jY4y+9m4dRsARop/L3WFj95RWMAloNkaDjxZoVGonrsOWNEiwS+JMEJbJ+U9ys/Yru/YV038U4fE+4z3vA+wb3uFWyJxOCJuxVNNKBFhHGbhzXfmX4giR1N6zZGrYUmirbmLJRCJuF/KkcLRZ87xetLTBaTs6bM6gIdy0tzWlQywRpkpc5+aILTffO0wl3gvgWNjS0baeG0dH8VwaK6gq/N0zAzxtfUmoEPM4ul+DpfbK911JQhmYeQJ5JLT/6tMcLxhlEgNzzIXyukVOI9r6f/ohhMH09Uq39d6IKPcWDMbpui8Q/lefhufMP3hZSAmSv/OH/icAP/r4=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(6666004)(7696005)(40460700003)(47076005)(1076003)(4326008)(54906003)(82310400005)(2906002)(356005)(81166007)(36860700001)(6916009)(86362001)(8676002)(316002)(44832011)(70206006)(70586007)(83380400001)(186003)(26005)(336012)(426003)(36756003)(2616005)(508600001)(5660300002)(16526019)(8936002)(21314003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2022 09:47:38.0310 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: af3784c4-272e-4b1c-b1b4-08da2769cc7d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT037.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4093
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Evan Quan <evan.quan@amd.com>,
 kernel test robot <lkp@intel.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Fix the compile warning below:
drivers/gpu/drm/amd/amdgpu/../pm/legacy-dpm/kv_dpm.c:1641
kv_get_acp_boot_level() warn: always true condition '(table->entries[i]->clk >= 0) => (0-u32max >= 0)'

Reported-by: kernel test robot <lkp@intel.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Evan Quan <evan.quan@amd.com>
Change-Id: If4985252017023d6711b4d7eb1192a397baff813
--
v1->v2:
  - drop dead code(Alex)
---
 drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c | 14 +-------------
 1 file changed, 1 insertion(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c b/drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c
index 8b23cc9f098a..8fd0782a2b20 100644
--- a/drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c
+++ b/drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c
@@ -1623,19 +1623,7 @@ static int kv_update_samu_dpm(struct amdgpu_device *adev, bool gate)
 
 static u8 kv_get_acp_boot_level(struct amdgpu_device *adev)
 {
-	u8 i;
-	struct amdgpu_clock_voltage_dependency_table *table =
-		&adev->pm.dpm.dyn_state.acp_clock_voltage_dependency_table;
-
-	for (i = 0; i < table->count; i++) {
-		if (table->entries[i].clk >= 0) /* XXX */
-			break;
-	}
-
-	if (i >= table->count)
-		i = table->count - 1;
-
-	return i;
+	return 0;
 }
 
 static void kv_update_acp_boot_level(struct amdgpu_device *adev)
-- 
2.29.0

