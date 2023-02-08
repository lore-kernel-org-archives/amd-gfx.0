Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6C60C636CC
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Feb 2023 07:26:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 38A0D10E6A4;
	Wed,  8 Feb 2023 07:26:17 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2066.outbound.protection.outlook.com [40.107.93.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 89CFF10E69C
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Feb 2023 07:26:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VPGfOCAXJosdspm9t4/QRlGeuCCFydVIT4z+ZY/fic8KXiYP7MD/xi0zZPnPepLXj4SjTAgb2YU5KoeRIT2HxgtsEJIJN5ZNYLCR3sbtM/l61FV+txMZU+QGWWt8f8jNv5zyC96wO3DuGBATfwbfnk7CG+cffifh6CWkCGaVrq+Exj/7Pd81zjyxgWtFay0BuVoAkOh+Qyt7JfskNMbowe9iapw02+lAjWgmrjQay5Is0wzqYkfKZn6WgUvd7+8Gsw0H5wbrms09CBJTZildPa/hBrWASWVGPo8M0rAIpbSXPSRPU21ovOMhaZT13PwQdH9BXNrOvIw7NXvl6g5Cgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fV73Y5snOOpjw4Vh1H/KB+fqagyW/Km6cR/LapE+1j0=;
 b=OS+jG/jGrnBOAjuM09QxE6mu66TWMet0AEtVJml8q5xstHcAd5W0F3/HMKqoEvrEktxYHuKEL3nHPLswc3SGCfJtAMpZtYpZ5UCG4XDgAL+w/5uPrA2UEc+0wCEK24INLQOHuYzhMZbMYiEAjj87fOL9CpJJww2nsrjuhIvDa2RmsvcrZ2XwXA+d7QlmvVIJgWuCXOAFr721sxz0k0Ni4Y7miY7jKUuAQJeRb4itdWUz3YE5p5z5Vbf+C02iZgKG0c75c+LA6frujnOyJkZL5z4XOd4fnZQ9F7ZurPZSoOeNK7w7ErR9ep98tae8YLcybS6YHKjpX3mUn9qBum4Fjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fV73Y5snOOpjw4Vh1H/KB+fqagyW/Km6cR/LapE+1j0=;
 b=AOCfz/+HOUA8f/3t9wMaIaKmh6LxaS/VLy3cEpenh3xVZ0gbFoUQlLJxk3h1lCVtuSeTPjdWTmOxa0AVGv27ezEbatwxwOuCRBHojWu8fs0hPeJA7yCkkIvM+ebbRwK/DPSsexbYheZm2q17sWVd7Dw048q58C9tZCZbVB99kwo=
Received: from BN9PR03CA0170.namprd03.prod.outlook.com (2603:10b6:408:f4::25)
 by BL3PR12MB6596.namprd12.prod.outlook.com (2603:10b6:208:38f::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.17; Wed, 8 Feb
 2023 07:26:12 +0000
Received: from BN8NAM11FT032.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f4:cafe::b5) by BN9PR03CA0170.outlook.office365.com
 (2603:10b6:408:f4::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.36 via Frontend
 Transport; Wed, 8 Feb 2023 07:26:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT032.mail.protection.outlook.com (10.13.177.88) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6086.17 via Frontend Transport; Wed, 8 Feb 2023 07:26:11 +0000
Received: from majun-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 8 Feb
 2023 01:26:07 -0600
From: Ma Jun <Jun.Ma2@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu: Fix the warning info when unload or remove amdgpu
Date: Wed, 8 Feb 2023 15:25:19 +0800
Message-ID: <20230208072519.2412564-1-Jun.Ma2@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT032:EE_|BL3PR12MB6596:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c0d39af-d243-4474-237f-08db09a5c14d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CWALQd/YqpHTyJrLq2v5ns2qSN8stx8rdvrUbWoBAfrTVId6FvJKszDg4Nr9/OFr3EQA04+KObFJHz7yYnn8fDQRAN2wXCV44TrEwHd04oxJ45OJPFY962MzNVQrHBXVrExkXYpTVRIFyFywYuC6YoDv/DrdX6H8bcYTZj48GZFTHGFAYzau5lrk7XkO2HT8k+25u0R8IsVC2TtIj9ZFvzDhjYnWR+fGvfoH1gusKL0SnBW3T6IYEsW+VxAm8lzr1Vg5M7J2DsXRd5bbLgHh5cYtXtjMlRy8YQL/sDBHEtgFBaj1ipkHacIXIzJAbu8vRCkPp+mODkb17Ne1mPfsndg0G0x3Bzx6VDtAiV7CYoFbbas2eq0/JOrqY2NxfC8mFgv6JqzgvQzRP+ajVETVY18RlpD87Cmto4Dms1vaO+k4QFYcVVpX19SK/7OIfLyuhSez994ZV1rMRT7WGqDbBVsK8pJW3wKU6Hf8tlCeTJKZ74Pj7/2ZbFfVxZbuRmwBHlAKBCtDcmhwYNlcbSdqQ/Tf3I+iM9PRywakqAv9i1HbNZB7609p18XbYXePIF8+cmG4X95dY3E+D1Egz+kX0jaZ9Ai1lIEaiI0VI30esei7+cYKbl7rpjYO7tS1FQS9kRIpsSXFIHEBc/+9/nj11aDoiEWLnUJO9J0ZljREsu6I2VdSi8APmfp8dAR8H9kjBXAB/R3okcBx2B/Ir3antHtQlmyDS4ihqjUhl82WUtFhaP/n+4yWAr1RoXvLIdxU
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(346002)(376002)(396003)(136003)(39860400002)(451199018)(46966006)(36840700001)(40470700004)(82310400005)(83380400001)(2906002)(8936002)(4326008)(6636002)(54906003)(5660300002)(40460700003)(36756003)(47076005)(426003)(41300700001)(70206006)(70586007)(8676002)(40480700001)(86362001)(336012)(316002)(110136005)(356005)(26005)(186003)(16526019)(2616005)(7696005)(478600001)(1076003)(6666004)(82740400003)(36860700001)(81166007)(36900700001)(2101003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2023 07:26:11.9900 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c0d39af-d243-4474-237f-08db09a5c14d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT032.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6596
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
Cc: Ma Jun <Jun.Ma2@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Checking INVOKE_CMD  to fix the below warning info when
unload or remove amdgpu driver

[  319.489809] Call Trace:
[  319.489810]  <TASK>
[  319.489812]  psp_ta_unload+0x9a/0xd0 [amdgpu]
[  319.489926]  ? smu_smc_hw_cleanup+0x2f6/0x360 [amdgpu]
[  319.490072]  psp_hw_fini+0xea/0x170 [amdgpu]
[  319.490231]  amdgpu_device_fini_hw+0x2fc/0x413 [amdgpu]
[  319.490398]  ? blocking_notifier_chain_unregister+0x56/0xb0
[  319.490401]  amdgpu_driver_unload_kms+0x51/0x60 [amdgpu]
[  319.490493]  amdgpu_pci_remove+0x5a/0x140 [amdgpu]
[  319.490583]  ? __pm_runtime_resume+0x60/0x90
[  319.490586]  pci_device_remove+0x3b/0xb0
[  319.490588]  __device_release_driver+0x1a8/0x2a0
[  319.490591]  driver_detach+0xf3/0x140
[  319.490593]  bus_remove_driver+0x6c/0xf0
[  319.490595]  driver_unregister+0x31/0x60
[  319.490597]  pci_unregister_driver+0x40/0x90
[  319.490599]  amdgpu_exit+0x15/0x44e [amdgpu]

Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 466054719842..5fb919cd9330 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -620,7 +620,8 @@ psp_cmd_submit_buf(struct psp_context *psp,
 	 */
 	if (!dev_entered)
 		WARN_ON(psp->cmd_buf_mem->cmd_id != GFX_CMD_ID_LOAD_ASD &&
-			psp->cmd_buf_mem->cmd_id != GFX_CMD_ID_UNLOAD_TA);
+			psp->cmd_buf_mem->cmd_id != GFX_CMD_ID_UNLOAD_TA &&
+			psp->cmd_buf_mem->cmd_id != GFX_CMD_ID_INVOKE_CMD);
 
 	memset(psp->cmd_buf_mem, 0, PSP_CMD_BUFFER_SIZE);
 
-- 
2.25.1

