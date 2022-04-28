Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EE23C433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Apr 2022 21:30:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DB70610EA43;
	Thu, 28 Apr 2022 21:30:10 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2085.outbound.protection.outlook.com [40.107.94.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9298410E93F
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Apr 2022 21:30:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sc0GaCHaziot46yC9JqbnuD/DIz8u2vgiI8oN0Y1KHWSMw7X1q8Jcw5jha4/9G9zDJ0Mxjt4sEpjYBa2ZAIvC6JZW9/OAqjcA+4HQxZXfdhRMEJA43iTGuCSO/ZRWYC4nSEb1IWoUEDClxTuob3pDU5qtNn92Jl/S5vHfC5SMhqkoaQPRN0ArJnIuOyBO3itREKBsrK8nF1tH8wekpouRyW/8DUeA6Ty0JKcL9fI6xPF9SgK/B18UZRufHILN7kplnGVaaCy8X/aogdyVCE/yUsyHl3yQJmZRsysY/4zFMJxbt76JGfO4B9z67N9ydzAcMsVm298Yh47qZ94cw90GA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=we8A9LzCZVfpVYRtx/PFF2N6WK36uEktglI8C7MWTmE=;
 b=cww28nEQ5oKpxu9U3KZZpdiTFlvqBpIV2+29OXmah9IEpaB7/KSYbXqDSdc8I8lfrXTZxVwmnpyuYAdsLdfhk7Tt9LhiLaxFIRtnJ85DWOzp1gd39IELIQFo0evvQKeLmv00zzSz+13Awf7S8WoVGw3gE5YeQ/v5JlM1qa4G3MlALZJSzjD+H3PlgQFljVicke3MhKpajvqeqyHPDSxK31f7yb42L59QEfvonuy1irgxGh3NiVNcdW4YYxa1Wx72RVsKvBAyHBHCkHU8FoBal9JCSKKuydXaGZMU77CkmDwQLCSIve9NOMBpRpOFXSzrahe619mIhPp7h5QGVjqnsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=we8A9LzCZVfpVYRtx/PFF2N6WK36uEktglI8C7MWTmE=;
 b=lomJavPdiw+6rgchp6cXbD+PnkCVNfB/cEN/p7pGCWh9eOimvYiQBsou+wETxEWruFhzVlJsgbBRgqk/SHCXy+XUUW5olSwMY77KwY6Z+XWtaT82ZvXCQmlWcw6ra2k0O8PI2jh5nVbjBt3sUGHKQl/QXookD5dvyIKzCfaEA+A=
Received: from MW4PR03CA0158.namprd03.prod.outlook.com (2603:10b6:303:8d::13)
 by MN2PR12MB2943.namprd12.prod.outlook.com (2603:10b6:208:ad::33)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.20; Thu, 28 Apr
 2022 21:30:05 +0000
Received: from CO1NAM11FT006.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8d:cafe::e9) by MW4PR03CA0158.outlook.office365.com
 (2603:10b6:303:8d::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.14 via Frontend
 Transport; Thu, 28 Apr 2022 21:30:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT006.mail.protection.outlook.com (10.13.174.246) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5206.12 via Frontend Transport; Thu, 28 Apr 2022 21:30:04 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 28 Apr
 2022 16:30:00 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/pm: correct the way for retrieving bootup clocks
Date: Thu, 28 Apr 2022 17:29:41 -0400
Message-ID: <20220428212946.700296-7-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220428212946.700296-1-alexander.deucher@amd.com>
References: <20220428212946.700296-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f94ba2bb-c3ca-4171-b582-08da295e42c3
X-MS-TrafficTypeDiagnostic: MN2PR12MB2943:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB294352B34CE1E4F7657B315BF7FD9@MN2PR12MB2943.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FdB5zVGx9hAPhN2uz/kgZeCDeNabS2inHLn7cCiIhjDEC/S/CR/1KxnbCLS1GKC6BEk/jKa3LcP+FZmPWmVrDZRMUE0UsbihZiLALHaXwT2iFoa4FAM4Z4OfrSptsazZbMv7RWoPI0HBwSam5mEFdS6OzABu3K0zS3TeKOi3p2We9D2wpYRak2oYfDy3dTu2JcOFytNgQdtNYC5y0SftoUkWn2vQNVF8wSFwDWrOfb6FDY4fDqJCPYWGBytfKQVGnFNzJD9feQJ2oF7LQYS00U7ijEKK/UyURz7w37DWkfD0l3nbxtoDHlz5ZDlHVNXRfnGIvRit09VD12vBTylUChLQqZMKoOeQ8pZYOsN2fSlMcqy9BkqWoi62pa6RU56o2tYcLxKWuD2L0yfDDn8baJis+SEEo2qGe5FlF1fkvM2w0qL88+5aO8pwwSF8sM8tZnBb+yvWXzFuu6CVghTpwf8GOn5urqjSt+Am5vRpJwQdS9uA6CVCed2EEBlhkghrDPqkWaHDqGFAykeT9ewlobr11ANUUcz+2V1MD0hFAFGKlorXqGJxMpueaDn4306+O2cqj4f8upqU6m+MsqXdllfy6Pa97QTtGrk3a1TOz6kvguamQ9yUmz+kqAgQrS4g/MJeyR2UTxzPSjlrkcalWcRBuBvXu9RqHGX0yvS+wzYSw7WLYil2t6ts4Kenb9NSRe9l1qU562NkeNJ3dSbhiw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(70206006)(70586007)(426003)(186003)(4326008)(47076005)(8936002)(86362001)(16526019)(36860700001)(508600001)(40460700003)(5660300002)(336012)(2616005)(8676002)(81166007)(26005)(82310400005)(2906002)(356005)(36756003)(6666004)(6916009)(54906003)(1076003)(7696005)(316002)(83380400001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2022 21:30:04.8258 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f94ba2bb-c3ca-4171-b582-08da295e42c3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT006.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB2943
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
 Kenneth Feng <kenneth.feng@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Evan Quan <evan.quan@amd.com>

The bootup clocks can be retrieved from the smu_info table. That
is light-weight compared with existing way.

Signed-off-by: Evan Quan <evan.quan@amd.com>
Reviewed-by: Kenneth Feng <kenneth.feng@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c    | 83 ++++++-------------
 1 file changed, 26 insertions(+), 57 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
index 21b1187028fd..79541844ce5c 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
@@ -488,32 +488,6 @@ int smu_v13_0_fini_power(struct smu_context *smu)
 	return 0;
 }
 
-static int smu_v13_0_atom_get_smu_clockinfo(struct amdgpu_device *adev,
-					    uint8_t clk_id,
-					    uint8_t syspll_id,
-					    uint32_t *clk_freq)
-{
-	struct atom_get_smu_clock_info_parameters_v3_1 input = {0};
-	struct atom_get_smu_clock_info_output_parameters_v3_1 *output;
-	int ret, index;
-
-	input.clk_id = clk_id;
-	input.syspll_id = syspll_id;
-	input.command = GET_SMU_CLOCK_INFO_V3_1_GET_CLOCK_FREQ;
-	index = get_index_into_master_table(atom_master_list_of_command_functions_v2_1,
-					    getsmuclockinfo);
-
-	ret = amdgpu_atom_execute_table(adev->mode_info.atom_context, index,
-					(uint32_t *)&input);
-	if (ret)
-		return -EINVAL;
-
-	output = (struct atom_get_smu_clock_info_output_parameters_v3_1 *)&input;
-	*clk_freq = le32_to_cpu(output->atom_smu_outputclkfreq.smu_clock_freq_hz) / 10000;
-
-	return 0;
-}
-
 int smu_v13_0_get_vbios_bootup_values(struct smu_context *smu)
 {
 	int ret, index;
@@ -523,6 +497,8 @@ int smu_v13_0_get_vbios_bootup_values(struct smu_context *smu)
 	struct atom_firmware_info_v3_4 *v_3_4;
 	struct atom_firmware_info_v3_3 *v_3_3;
 	struct atom_firmware_info_v3_1 *v_3_1;
+	struct atom_smu_info_v3_6 *smu_info_v3_6;
+	struct atom_smu_info_v4_0 *smu_info_v4_0;
 
 	index = get_index_into_master_table(atom_master_list_of_data_tables_v2_1,
 					    firmwareinfo);
@@ -588,37 +564,30 @@ int smu_v13_0_get_vbios_bootup_values(struct smu_context *smu)
 	smu->smu_table.boot_values.format_revision = header->format_revision;
 	smu->smu_table.boot_values.content_revision = header->content_revision;
 
-	smu_v13_0_atom_get_smu_clockinfo(smu->adev,
-					 (uint8_t)SMU11_SYSPLL0_SOCCLK_ID,
-					 (uint8_t)0,
-					 &smu->smu_table.boot_values.socclk);
-
-	smu_v13_0_atom_get_smu_clockinfo(smu->adev,
-					 (uint8_t)SMU11_SYSPLL0_DCEFCLK_ID,
-					 (uint8_t)0,
-					 &smu->smu_table.boot_values.dcefclk);
-
-	smu_v13_0_atom_get_smu_clockinfo(smu->adev,
-					 (uint8_t)SMU11_SYSPLL0_ECLK_ID,
-					 (uint8_t)0,
-					 &smu->smu_table.boot_values.eclk);
-
-	smu_v13_0_atom_get_smu_clockinfo(smu->adev,
-					 (uint8_t)SMU11_SYSPLL0_VCLK_ID,
-					 (uint8_t)0,
-					 &smu->smu_table.boot_values.vclk);
-
-	smu_v13_0_atom_get_smu_clockinfo(smu->adev,
-					 (uint8_t)SMU11_SYSPLL0_DCLK_ID,
-					 (uint8_t)0,
-					 &smu->smu_table.boot_values.dclk);
-
-	if ((smu->smu_table.boot_values.format_revision == 3) &&
-	    (smu->smu_table.boot_values.content_revision >= 2))
-		smu_v13_0_atom_get_smu_clockinfo(smu->adev,
-						 (uint8_t)SMU11_SYSPLL1_0_FCLK_ID,
-						 (uint8_t)SMU11_SYSPLL1_2_ID,
-						 &smu->smu_table.boot_values.fclk);
+	index = get_index_into_master_table(atom_master_list_of_data_tables_v2_1,
+					    smu_info);
+	if (!amdgpu_atombios_get_data_table(smu->adev, index, &size, &frev, &crev,
+					    (uint8_t **)&header)) {
+		if ((frev == 3) && (crev == 6)) {
+			smu_info_v3_6 = (struct atom_smu_info_v3_6 *)header;
+
+			smu->smu_table.boot_values.socclk = smu_info_v3_6->bootup_socclk_10khz;
+			smu->smu_table.boot_values.vclk = smu_info_v3_6->bootup_vclk_10khz;
+			smu->smu_table.boot_values.dclk = smu_info_v3_6->bootup_dclk_10khz;
+			smu->smu_table.boot_values.fclk = smu_info_v3_6->bootup_fclk_10khz;
+		} else if ((frev == 4) && (crev == 0)) {
+			smu_info_v4_0 = (struct atom_smu_info_v4_0 *)header;
+
+			smu->smu_table.boot_values.socclk = smu_info_v4_0->bootup_socclk_10khz;
+			smu->smu_table.boot_values.dcefclk = smu_info_v4_0->bootup_dcefclk_10khz;
+			smu->smu_table.boot_values.vclk = smu_info_v4_0->bootup_vclk0_10khz;
+			smu->smu_table.boot_values.dclk = smu_info_v4_0->bootup_dclk0_10khz;
+			smu->smu_table.boot_values.fclk = smu_info_v4_0->bootup_fclk_10khz;
+		} else {
+			dev_warn(smu->adev->dev, "Unexpected and unhandled version: %d.%d\n",
+						(uint32_t)frev, (uint32_t)crev);
+		}
+	}
 
 	return 0;
 }
-- 
2.35.1

