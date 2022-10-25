Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C33EEFA373E
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Oct 2022 07:56:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 23C2E10E236;
	Tue, 25 Oct 2022 07:56:50 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2060.outbound.protection.outlook.com [40.107.220.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 849DB10E226
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Oct 2022 07:56:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DtN1c53NIfFsSKnzCV0etG7btagFFwl1AEKK0RWGc1mb5wiqzmYwQfIhCfZFmP23GYTbrK6tn7DXwEVYSAVXwHZnfk0zc9dUp92UgMkKJwUo/QUtov9gBBnc3w/q0QZ8HzWBbB7OJgeUMSI3FVo1v6QB0Kz3hp1rreG6NVhcPyCCFxp3f/GJoYFUlGnxyVvtno2o4RPVMxzfu0nfp/TxLl8h2Ig0z65jgYZF/PTULsIxLJYlhgZOscnPQTzFsYEYOWu2MmwTYpAhy5z3sKwDOEQZ7UmVe5iX0Aarz2TsK/txPfrAkAfB0mKXm+qfsI7ZJfVEQpg3cj4nFW/YTgd3DQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0sZWSgVjWPxWuAUxejD1Dszi/SoNQWq3L5WWwR0/fd4=;
 b=HHFzKH3IG6dMjlm+7Ad8OJXXJJoBTrWXtDTsSM3hDJ8vxrXVa/M7hm0BH1WGY5Z1/2fxO+prtoSjxIpoJhNPUBQ7pliLxDdoNALya5T2BkvrM0Lg87L9dxOZhjDZUkQEoun42HXirCcyIz/tlxTrwdRPk7iP9g3xCOtNJvPDZ2QKnAJQVHT5nuUMR3PMXWL4CFBcb/o8Zvdks0Spb1jk8Ley9UNG0ugPjCu+MbUyvzUgWRleCtj5A7/k/6dYUMjmTlbmNyq/7lO5UUoFH36Yl6KAMxXa8JzMt/61kmGJRoZjmvPwBK0XHn/R4QmhazEkXAk4df8Sr9INAjlE/B6Pgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0sZWSgVjWPxWuAUxejD1Dszi/SoNQWq3L5WWwR0/fd4=;
 b=Sd/Kd/HzCT8PhIo6csbXTkAKz+OtVXkwaGW6geE4Uldx8plQI1KnFh7Tqh7hJSWgNepk5a4kC+OMb6f8nuhFKBLfAffgfr8Yzx33EhOiRdRRXIYKE58K73jDrR0jTpfCghU6+fWKF2pUMOY89rFGxaNnZDMoQn305Q6dJs+65hQ=
Received: from BN7PR02CA0026.namprd02.prod.outlook.com (2603:10b6:408:20::39)
 by CH0PR12MB5139.namprd12.prod.outlook.com (2603:10b6:610:be::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.23; Tue, 25 Oct
 2022 07:56:43 +0000
Received: from BN8NAM11FT095.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:20:cafe::bc) by BN7PR02CA0026.outlook.office365.com
 (2603:10b6:408:20::39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.28 via Frontend
 Transport; Tue, 25 Oct 2022 07:56:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT095.mail.protection.outlook.com (10.13.176.206) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5746.16 via Frontend Transport; Tue, 25 Oct 2022 07:56:43 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Tue, 25 Oct
 2022 02:56:38 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Tue, 25 Oct
 2022 02:56:17 -0500
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.31 via Frontend
 Transport; Tue, 25 Oct 2022 02:56:16 -0500
From: Yifan Zha <Yifan.Zha@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Alexander.Deucher@amd.com>,
 <Hawking.Zhang@amd.com>
Subject: [PATCH 1/2] drm/admgpu: Skip access SDMA0_F32_CNTL in
 sdma_v6_0_enable under SRIOV
Date: Tue, 25 Oct 2022 15:56:06 +0800
Message-ID: <20221025075605.1408663-1-Yifan.Zha@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT095:EE_|CH0PR12MB5139:EE_
X-MS-Office365-Filtering-Correlation-Id: 50fabf91-b308-43d1-296b-08dab65e7544
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kkJx3BVP3T+vg+41SiugslOvQCt14r6uBbVRQvSDEJMYTH6BORX5Fh0640z4+irvbXP4rFNQvx1zG/KbSSHlIi5Oug4UUzogMt1rzmIWPXu5yPFG5hfHrEFQHfHBKuj9Xn6fGtG3KvUz+lj8EJDakLEcL7TgoZf/68m1+TkobbNsgnRho80uqn7sSIDCLjbkVOCPfswHgP8NXbwuPTsPaOFYGa7WeFhcO2aoqpzEwD6auY0D0XysOFPY/Hufi1Fz7KRgUW/1z3q/97nIQ/r/QsT6T9q2mE9M62DPQJTKeBvcfbR+PScJ1WkRkbZFYDWiHDQqoTQE9IVU2tAERC7pF3e/zXNgF+yhew8Czx6b7TZd1Dw5agIX2nijR2cjP/W19BshwmFJagTm+9zo1piEt1vkxzTQP0WCJLQ3PCCR///m7teK5qsg2YZy+piEbnISIfWUXvdHvJNaH2JzIBHJB44DZlMQuWhohryOS+rZoeVHVsD1vXC3cWx5zv7GdMUUDFGgPUJlpyxrkKWcoIeNPP/dDAmIGCuBSDILe6wBPPQgK7+0iYR9NH53olKDbKjiZUpTiN1rQIosEL0+UZlrB3ziM1Qu8FJkMWmyrFoh7phxTOcri7qhwKl+AC/OQaEYlP3Ky/clrx37oJELXiXxGeRnz4BDhzILk7uA7osO5b8DvFQacGjhlfEugqKtPO0OA2BHknOqBL2rYZyvez1gON9GMaI/ypSWq0z1QIzHT16TnUPBB67g7GzLdGC1zwOYug71tNkO5yNWLQP1kaVlmmG+nuSQ1OywnlSWGQ6bP2WT6A1qc98Iig4r90VkPNIilj/+b4yYtQzLuMjFAOYfEg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(39860400002)(376002)(136003)(396003)(346002)(451199015)(40470700004)(36840700001)(46966006)(83380400001)(70206006)(70586007)(8676002)(4326008)(478600001)(40460700003)(426003)(47076005)(81166007)(356005)(5660300002)(2616005)(8936002)(82310400005)(40480700001)(2906002)(82740400003)(36860700001)(6636002)(86362001)(4744005)(41300700001)(54906003)(110136005)(336012)(6666004)(26005)(1076003)(186003)(36756003)(316002)(2101003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2022 07:56:43.6460 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 50fabf91-b308-43d1-296b-08dab65e7544
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT095.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5139
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
Cc: Horace.Chen@amd.com, Yifan Zha <Yifan.Zha@amd.com>, haijun.chang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Why]
SDMA0_F32_CNTL is a PF_only regitser which will be blocked by L1.
RLCG will not program the register as well.

[How]
Skip to program SDMA0_F32_CNTL under SRIOV VF.

Signed-off-by: Yifan Zha <Yifan.Zha@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
index d9ae69be5ea4..049c26a45d85 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
@@ -455,6 +455,9 @@ static void sdma_v6_0_enable(struct amdgpu_device *adev, bool enable)
 		sdma_v6_0_rlc_stop(adev);
 	}
 
+	if (amdgpu_sriov_vf(adev))
+		return;
+
 	for (i = 0; i < adev->sdma.num_instances; i++) {
 		f32_cntl = RREG32_SOC15_IP(GC, sdma_v6_0_get_reg_offset(adev, i, regSDMA0_F32_CNTL));
 		f32_cntl = REG_SET_FIELD(f32_cntl, SDMA0_F32_CNTL, HALT, enable ? 0 : 1);
-- 
2.25.1

