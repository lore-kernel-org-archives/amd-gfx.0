Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C208C4829E
	for <amd-gfx@archiver.kernel.org>; Mon, 12 Feb 2024 17:59:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BB27410EE54;
	Mon, 12 Feb 2024 17:59:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2PyJ5JoM";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2076.outbound.protection.outlook.com [40.107.102.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F076F10EE57
 for <amd-gfx@lists.freedesktop.org>; Mon, 12 Feb 2024 17:59:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KfweR8Uy7ptcNwCNhqvoWW3CYpPU2fjBax3AGTQq5vluYhN+vt6w95cFYrbj8F7R2/HcFWtvdE7rlbdHF600vjpS/KcTv0CA5/ishdJAKL+ry2rDthggp+BnM3VXN7rOKUiWL7BNW6DDUl95iRiR9vn8zID5Tl4YYqyhcyaJ5Ral2GDvgNzE6YH9rK51lP6hNXLEiRmAIVBEM4/Iq/6y4NDdrzFExIn7uWa7gDyNdZ/BELFu4hywzxn72T+2rCsiU51Ka3Tl9grxx4ESOfRMDkcehPave6V/hPrEpjRACX6ublHkpT1IU4WC5QW8siBhzyJ3X6EJNXz9JXw5bZvGCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ILQwgu6D+tYKKxopsQ901/farDUqT4jMVJbJ6ohlMqE=;
 b=U41SnEevCg/Yal3CMkR2qpHgK1JbaKxgo/qSWR5Gs3cFB+ht7tH0kv0O4jhtmA6DOc0ByotN7W3BPvYCaPw9SDfa1j2vRqZsdBwp/I1fgQwXaOSrNtKMX5vHgn+EZ0IVhppgkLx4X3JqkERbew6KrNcGSR8Cx6prLqDiGioYixfHojqEjge5SUmZQu/4+7wiO0i9TheUZdhdzqJTjuTrhqUSHdHpGi8ZxuirBUb50eXEBCcSi3BvhN8s0rqfEveRLIH6Ghv5l4X9e/ivgRhvD39WLHtYbn9Ka2bJPSdgEzue7Ier0hm27jaYDkDQNm3bSh8nM9q6Bt4h2t7GIYw3QQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ILQwgu6D+tYKKxopsQ901/farDUqT4jMVJbJ6ohlMqE=;
 b=2PyJ5JoMT9wiSXJt8tncLprKaJXOvzFxTNmonro9E50lfgJY6Z17M/BHW461VvtnuoCNymsn1ubcfUzoHBh4AW7/UTZmaICbqMlk0yA+k/FF8OKRXTx8JKgTJmF5Kvp768j/QvDH2HoI/l41xvxLJaVdujqZJgzbsSMS9A+OLF8=
Received: from DM6PR06CA0071.namprd06.prod.outlook.com (2603:10b6:5:54::48) by
 SA1PR12MB7318.namprd12.prod.outlook.com (2603:10b6:806:2b3::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.24; Mon, 12 Feb
 2024 17:59:06 +0000
Received: from DS3PEPF000099D7.namprd04.prod.outlook.com
 (2603:10b6:5:54:cafe::b1) by DM6PR06CA0071.outlook.office365.com
 (2603:10b6:5:54::48) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.39 via Frontend
 Transport; Mon, 12 Feb 2024 17:59:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099D7.mail.protection.outlook.com (10.167.17.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7249.19 via Frontend Transport; Mon, 12 Feb 2024 17:59:06 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 12 Feb
 2024 11:59:03 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Likun Gao <Likun.Gao@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>,
 "Alex Deucher" <alexander.deucher@amd.com>
Subject: [PATCH 3/9] drm/amdgpu: use spirom update wait_for helper for psp v14
Date: Mon, 12 Feb 2024 12:58:43 -0500
Message-ID: <20240212175849.433812-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240212175849.433812-1-alexander.deucher@amd.com>
References: <20240212175849.433812-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D7:EE_|SA1PR12MB7318:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c94f663-3cb0-4133-fb5e-08dc2bf44e0b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9z2GIjdRffE85o9NswOdVKkP32GQBfrd/6NTYjMpCm35uHm69JFfnqh6zp+Rc3hVjv58wb8b5mlnYRlqe/PRRtkf3TWHRm8ZPAp0mnr9CBCpRodwmQ7u3f2/YClFPvyNTmKiBHeJLY+GLSZHIs9LaBNZiIXACKTGh2La3kzL1fScCBay9W68WT3kRJWkeoM8IWtTgUSDK2QuT4OIvUwZ3pvdqOukVsuKWNaMDS41WtPxbX8FoK7OtLCPNiCpJkSH5z1bwwQjP1AK+pk1E2fTYuEWThux9WBjUxvGhOkg2wymlop9fhVZdFrq9FWjlCgHkDT9veU+jyeIsdBFC8KLibLv7ZVFtdQvurTfkwnVyVDrKW1As7SSb5pon5yJdjzhCluQpFepCFj5lr/BB2YJIOSiX3rrS24KXxMIlU9KEcmHObLaYrWAjyM0XtkdZmYEhd1+x36sK6QL4LXT5sTqLP/KrfknD6LTOnjJsev6mqsqKRX3/DLgz+gSssZXmtoQAdZfA+v4FzMG4dsvbUgLQn6zlMY7VgtehEUlDmFFasgzau+E25zxnRno32vs+VVmnOLnwyxgtNnVcOvz19Zgy+ZHl8A1xM9HgSTMvlz/iq8=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(346002)(396003)(39860400002)(136003)(230922051799003)(451199024)(82310400011)(64100799003)(186009)(1800799012)(36840700001)(40470700004)(46966006)(1076003)(41300700001)(83380400001)(2616005)(26005)(16526019)(336012)(356005)(82740400003)(426003)(81166007)(4326008)(5660300002)(6916009)(70206006)(8936002)(8676002)(70586007)(15650500001)(2906002)(478600001)(7696005)(6666004)(316002)(36756003)(54906003)(86362001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2024 17:59:06.0409 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c94f663-3cb0-4133-fb5e-08dc2bf44e0b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099D7.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7318
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

From: Likun Gao <Likun.Gao@amd.com>

Spirom update typically requires extremely long
duration for command execution, and special helper
function to wait for it's completion.

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/psp_v14_0.c | 6 +++++-
 drivers/gpu/drm/amd/amdgpu/psp_v14_0.h | 2 ++
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v14_0.c b/drivers/gpu/drm/amd/amdgpu/psp_v14_0.c
index fc4caf752687..998758a1b209 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v14_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v14_0.c
@@ -577,7 +577,11 @@ static int psp_v14_0_exec_spi_cmd(struct psp_context *psp, int cmd)
 	WREG32_SOC15(MP0, 0, regMPASP_SMN_C2PMSG_73, 1);
 
 	if (cmd == C2PMSG_CMD_SPI_UPDATE_FLASH_IMAGE)
-		return 0;
+		ret = psp_wait_for_spirom_update(psp, SOC15_REG_OFFSET(MP0, 0, regMPASP_SMN_C2PMSG_115),
+						 MBOX_READY_FLAG, MBOX_READY_MASK, PSP_SPIROM_UPDATE_TIMEOUT);
+	else
+		ret = psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, regMPASP_SMN_C2PMSG_115),
+				   MBOX_READY_FLAG, MBOX_READY_MASK, false);
 
 	ret = psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, regMPASP_SMN_C2PMSG_115),
 				MBOX_READY_FLAG, MBOX_READY_MASK, false);
diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v14_0.h b/drivers/gpu/drm/amd/amdgpu/psp_v14_0.h
index cb7ee54529b4..dd18ba2cfad5 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v14_0.h
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v14_0.h
@@ -25,6 +25,8 @@
 
 #include "amdgpu_psp.h"
 
+#define PSP_SPIROM_UPDATE_TIMEOUT   60000   /* 60s */
+
 void psp_v14_0_set_psp_funcs(struct psp_context *psp);
 
 #endif
-- 
2.42.0

