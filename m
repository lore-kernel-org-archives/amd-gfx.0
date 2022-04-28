Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66E0CC433FE
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Apr 2022 18:45:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EC0D510E6E6;
	Thu, 28 Apr 2022 18:45:37 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2051.outbound.protection.outlook.com [40.107.220.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ED3B010E6E6
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Apr 2022 18:45:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hbydYroJgZO3AvmQ8JE3coyKpx3s+rV8DkBkCgVcypV2zoe9iayz9bFA+iMqzZ3ki6Kc7tViiKrJTTbS/aRrUfIQBSrNlT1eWVbPoONxXM7mpLQ+XN3N/1vYkgTuQvYSTgd0BLRylYGDHZNk3K9bD0PEtN63ZClIO+IyXEmyS/n1mkP1jWnwm0qYIohpeAyfX6sXP9OXwqzPdaByZe9cn59vrO1szh355/Bixxfjm74+TtTWSesIQ0e7dF3WIdJbpvNIPhkwxzfFgoOH3UyxqdA9lSjV0bYgNdPZXDU8TA8mngWX97yZZqJzKoQdUveeHZyLWuV0gwKurfFHIUdVdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U1qfmA6Kn7z92tqg4M+tGXwa2zrqSvqYiqpbSJOAKNA=;
 b=AtcANx5c+er5Tava0pm02HxUktyG1M+2mM2eqCv5GcoCZF1bEE7vHxqOWaMJm2mAzjaIQmL2gH3lybYr/owNaJB7ndwjZldKCw7Rgo2j+pD6aDMT+ODSbi2xKqUic5HdLsI6CweYjYETG2s6Mo35lHxVqiyiVC7Q1LtWqReiuGfQ1+y2SAHCaq9nE4UAWgffI8C7yymr0RqsKw9/g4/eYEoESq3D9eitjsdbOl5q+WEJv+HWB5caiZOqq6GPfRTr8m8W1VzD0w3C0crsK0CLBggsJUlGnomJ1GUyw0szBqGWY3EyTIjMmtKLp8CM8VsIlkuAd59Lqx0+OqimXNsMjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U1qfmA6Kn7z92tqg4M+tGXwa2zrqSvqYiqpbSJOAKNA=;
 b=II3T3VlIA8zC+Sg6Updsjt1uszVcI3oP2gA4kD3kSc3SF7PCF3ZlGP/sotF0F8bKx705N/A1JDgAJwp3yFYYNo/tkiWaajixq2oEcCny8DR70kRo4hm47hB/mHTdiDqbrfNV+4u6tWsdVXyvZ52xZkaCITNXTaOAp7mRnrex7JE=
Received: from DS7PR03CA0205.namprd03.prod.outlook.com (2603:10b6:5:3b6::30)
 by MWHPR1201MB0109.namprd12.prod.outlook.com (2603:10b6:301:52::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Thu, 28 Apr
 2022 18:45:34 +0000
Received: from DM6NAM11FT012.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b6:cafe::a2) by DS7PR03CA0205.outlook.office365.com
 (2603:10b6:5:3b6::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15 via Frontend
 Transport; Thu, 28 Apr 2022 18:45:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT012.mail.protection.outlook.com (10.13.173.109) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5206.12 via Frontend Transport; Thu, 28 Apr 2022 18:45:33 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 28 Apr
 2022 13:45:32 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/7] drm/amdgpu: extend PSP GFX FW type
Date: Thu, 28 Apr 2022 14:45:15 -0400
Message-ID: <20220428184520.651971-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220428184520.651971-1-alexander.deucher@amd.com>
References: <20220428184520.651971-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 48065a8a-1472-4a3a-aa3d-08da2947471e
X-MS-TrafficTypeDiagnostic: MWHPR1201MB0109:EE_
X-Microsoft-Antispam-PRVS: <MWHPR1201MB01094C157513DF0D63E09C46F7FD9@MWHPR1201MB0109.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EnGgPNi4jGgK5EBoimSehjD93mdLqClTpBHrWdzhLKW86V62oayjNgEVCpXtyQPxYiLS9w6IO3YrAc1RVZqR9O94gtFc7AyMnhBxn4Vm6VhRFncxSbKXKY/dIU4mFAHEnGH8k+9w3jzAZwUnRIM31duUkvRNEFsvgZ7QRP/2UXcqR7MZku87NWp2M1EpU3Z82t0hL7Hds62nIZYJjGJnur5wl3SkYe5GPoK7mc6H6OuXoO2F5APVOiGVcm9GmkBVDK07JClZWUhU70xTwcn6RQPp6yu2YeF3X8O/jOjKn9FUKNf+GnS8beHi1lSGmloYn7UC9azcXMAGhvYLJ12qPmPNuTzX0PCcH1it3XquBxtRlwQ2gCk4SdDAj74W/JyDeaspugqS7p3Zq/+e3vdlSVBiif1PeJe71/uH2ayNl1ntmvkUkZAB4XLztKwhanO4Kes/B4wh1SnCzwkRLju953S7hd0MZTp7aOnHdTdQQoH57ykCQf/YTbAfZe3BgzfhqQ/ZsQePiwPfaAqo8oayz+iLugJs/MWhBSgcn4cERWzIAbAskXIP7c9Wu6BrbRiplHpH4Is8UZN+9qQQzKKMVGJnZ48DOJ/lplnEWvu/O0WjcsAp0HNPQBo1Is/LLWYaU59+IpVAC9FG522CAEUzcRQAob4ak/WGnAyjqTwjpffm04o97HnVhaJAZzmV3l/2cTxfQH50DxmpLSjFb9nPoA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(6916009)(316002)(82310400005)(54906003)(26005)(508600001)(4326008)(36756003)(47076005)(8676002)(336012)(426003)(70586007)(1076003)(186003)(16526019)(2616005)(70206006)(40460700003)(5660300002)(356005)(86362001)(8936002)(36860700001)(7696005)(6666004)(2906002)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2022 18:45:33.7861 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 48065a8a-1472-4a3a-aa3d-08da2947471e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT012.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB0109
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Likun Gao <Likun.Gao@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Likun Gao <Likun.Gao@amd.com>

Extend PSP GFX FW type to support IMU, LSDMA, SDMA v6, RS64 MES related
fw load.

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/psp_gfx_if.h | 30 +++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/psp_gfx_if.h b/drivers/gpu/drm/amd/amdgpu/psp_gfx_if.h
index 1f276ddd26e9..236b7a61443a 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_gfx_if.h
+++ b/drivers/gpu/drm/amd/amdgpu/psp_gfx_if.h
@@ -260,6 +260,36 @@ enum psp_gfx_fw_type {
 	GFX_FW_TYPE_VCN1                            = 58,   /* VCN1                     MI      */
 	GFX_FW_TYPE_CAP                             = 62,   /* CAP_FW                           */
 	GFX_FW_TYPE_REG_LIST                        = 67,   /* REG_LIST                 MI      */
+	GFX_FW_TYPE_IMU_I                           = 68,   /* IMU Instruction FW       SOC21   */
+	GFX_FW_TYPE_IMU_D                           = 69,   /* IMU Data FW              SOC21   */
+	GFX_FW_TYPE_LSDMA                           = 70,   /* LSDMA FW                 SOC21   */
+	GFX_FW_TYPE_SDMA_UCODE_TH0                  = 71,   /* SDMA Thread 0/CTX        SOC21   */
+	GFX_FW_TYPE_SDMA_UCODE_TH1                  = 72,   /* SDMA Thread 1/CTL        SOC21   */
+	GFX_FW_TYPE_PPTABLE                         = 73,   /* PPTABLE                  SOC21   */
+	GFX_FW_TYPE_DISCRETE_USB4                   = 74,   /* dUSB4 FW                 SOC21   */
+	GFX_FW_TYPE_TA                              = 75,   /* SRIOV TA FW UUID         SOC21   */
+	GFX_FW_TYPE_RS64_MES                        = 76,   /* RS64 MES ucode           SOC21   */
+	GFX_FW_TYPE_RS64_MES_STACK                  = 77,   /* RS64 MES stack ucode     SOC21   */
+	GFX_FW_TYPE_RS64_KIQ                        = 78,   /* RS64 KIQ ucode           SOC21   */
+	GFX_FW_TYPE_RS64_KIQ_STACK                  = 79,   /* RS64 KIQ Heap stack      SOC21   */
+	GFX_FW_TYPE_ISP_DATA                        = 80,   /* ISP DATA                 SOC21   */
+	GFX_FW_TYPE_CP_MES_KIQ                      = 81,   /* MES KIQ ucode            SOC21   */
+	GFX_FW_TYPE_MES_KIQ_STACK                   = 82,   /* MES KIQ stack            SOC21   */
+	GFX_FW_TYPE_UMSCH_DATA                      = 83,   /* User Mode Scheduler Data SOC21   */
+	GFX_FW_TYPE_UMSCH_UCODE                     = 84,   /* User Mode Scheduler Ucode SOC21  */
+	GFX_FW_TYPE_UMSCH_CMD_BUFFER                = 85,   /* User Mode Scheduler Command Buffer SOC21 */
+	GFX_FW_TYPE_USB_DP_COMBO_PHY                = 86,   /* USB-Display port Combo   SOC21   */
+	GFX_FW_TYPE_RS64_PFP                        = 87,   /* RS64 PFP                 SOC21   */
+	GFX_FW_TYPE_RS64_ME                         = 88,   /* RS64 ME                  SOC21   */
+	GFX_FW_TYPE_RS64_MEC                        = 89,   /* RS64 MEC                 SOC21   */
+	GFX_FW_TYPE_RS64_PFP_P0_STACK               = 90,   /* RS64 PFP stack P0        SOC21   */
+	GFX_FW_TYPE_RS64_PFP_P1_STACK               = 91,   /* RS64 PFP stack P1        SOC21   */
+	GFX_FW_TYPE_RS64_ME_P0_STACK                = 92,   /* RS64 ME stack P0         SOC21   */
+	GFX_FW_TYPE_RS64_ME_P1_STACK                = 93,   /* RS64 ME stack P1         SOC21   */
+	GFX_FW_TYPE_RS64_MEC_P0_STACK               = 94,   /* RS64 MEC stack P0        SOC21   */
+	GFX_FW_TYPE_RS64_MEC_P1_STACK               = 95,   /* RS64 MEC stack P1        SOC21   */
+	GFX_FW_TYPE_RS64_MEC_P2_STACK               = 96,   /* RS64 MEC stack P2        SOC21   */
+	GFX_FW_TYPE_RS64_MEC_P3_STACK               = 97,   /* RS64 MEC stack P3        SOC21   */
 	GFX_FW_TYPE_MAX
 };
 
-- 
2.35.1

