Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFF54C4725D
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Jan 2024 09:57:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6630C10EC27;
	Mon, 22 Jan 2024 09:57:48 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2086.outbound.protection.outlook.com [40.107.243.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1DBF310EC27
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Jan 2024 09:57:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k2B158Q43aTQPctWIXjqRAY17nVIOeuBi4HFfrHX5kJn5ny8u1bHGOprGWhqIyCi99x3m9d3KeRpIc5IE7yzvmkZrcEb0i5PXSlG4NSLmu8UBPQTRMwfvxOHDyhw2Yrn37baiGpURdrOjiQ+5ZekcJAksvAVE3mGAJUyJ3pD3baMeAcY1OU2LFgQ6IejrAyif7xGwPPci49x0jxMQG2IPK2ZJCM46GLgvBrPsMtzz5G2BssS4sPh2inBkcdFKEZwL93D29GfZH5NojRl0WZOJygECOEm8qGB2cSRo9r1SRM/L01psmUWx9+Ax0194hJSma7YQgyBzlYy4Kb+M0BnSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=paPNfcIryhnFqBVGCv1lZ+ufA4FmayFWhiKScuAt3Sc=;
 b=GFjh9XXjBavSTAegMjNz2xsByRULFl0iQzP5z2E3bYz7O4BX5sifZlqNa7oqwNbH+5iODOtZqOjNUZcVAftXwJ4fyGBREnPq4ql3m2iecoGEekdocL6KUtBMPJijIK9YhyGPF1BeqXwkZLAhVzMJqNAe07uOSttMmPaVUCxcERuDOvIWfDMHt2LfSqgv6B+87/oLX138Es4qoP5OasgMKRmqO90svISLTpszpDd9Crgead40oyActspui1q+w2jyuQqB2xLURiyv12AK0EEqBPBKExpzCEL+yjDrP9W8ZLyRAfPUqs50crmzKIbok4//n0EeT7fGn/oNNNxeT9sVXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=paPNfcIryhnFqBVGCv1lZ+ufA4FmayFWhiKScuAt3Sc=;
 b=ASDylftxFRx3qm2ulftvfmccuOPZSQQSbvQlGMTMZyzND89rG0UU8NF93ak3rwmKmeqZx+PHFc6j52JcEdgEmVvkf8+i3jbF6YkLEjB+MnLd3aoOxzz3z5aRNdpFJyecls6/DmgFQ0boqLG5VpwT7eRiBNh5dOSvOZ1j/4f62Sc=
Received: from MW4PR04CA0118.namprd04.prod.outlook.com (2603:10b6:303:83::33)
 by MN2PR12MB4160.namprd12.prod.outlook.com (2603:10b6:208:19a::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.34; Mon, 22 Jan
 2024 09:57:27 +0000
Received: from CO1PEPF000044FA.namprd21.prod.outlook.com
 (2603:10b6:303:83:cafe::8f) by MW4PR04CA0118.outlook.office365.com
 (2603:10b6:303:83::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.32 via Frontend
 Transport; Mon, 22 Jan 2024 09:57:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044FA.mail.protection.outlook.com (10.167.241.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7228.0 via Frontend Transport; Mon, 22 Jan 2024 09:57:26 +0000
Received: from hawzhang-System-Product-Master.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 22 Jan 2024 03:57:24 -0600
From: Hawking Zhang <Hawking.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, Lijo Lazar <lijo.lazar@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>, Le Ma <Le.Ma@amd.com>
Subject: [PATCH] drm/amdgpu: Fix null pointer dereference
Date: Mon, 22 Jan 2024 17:57:08 +0800
Message-ID: <20240122095708.3759-1-Hawking.Zhang@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FA:EE_|MN2PR12MB4160:EE_
X-MS-Office365-Filtering-Correlation-Id: 84d4931f-63a8-49c8-35cb-08dc1b308a1e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7Syyc3siD3V5JSApXBmseFwCeYRBsigefOfmYAuZKHIY2y405QV8k0F9PmgD9/3zjAWdirzqAGFoO12cOWGfx63aVZMpADckhsO6UMOlfLG223odoOOV6+SycRdanf9IZiBlbsAgZD+LdLMZc9PpLKr7vdjs9iXKo8KNMMSV2xWtd7VSTJCrTYnchcX6BtOF9txdXWSiJWW9NiTB8xK7er2UIuU9WTZQLI+mhPJJtZfBGqx7F0X7oXDf5k5AWq/FMkTtu5NSAPKmM1H2EnoU/hlUgHHK1OF1QeliJDMmfiX0/UwpXWOyTXg2ou4nUhz7rhVcV6tCT2GqTRecRzGe3nztTsQtc5DC6OoiCLupR7ef1C7N3P9qVBvA581t3b9HSZ69tVGUZHU6H8acY7NkBYMZ37qWt4xl5M1U9lZBExTCQvYsMhGKu3VWNCx+/VXiGBYir6vNdtERRSIGnYhN2ZRgvk/GOqftT6Um+WQaRfCmEfj3Bjh5K0mxLJtJsa749/s9xeAT02DClerECKthYNYjS8ulz1BLygc+E4tRRgvArt6AgmBuSfUa0u+wBxbiCGtSWENUPNMc4AV7xV6QLphty3c2DK/JtxXTjtP4n1ENsrsDlAbaR3ZM98BXH3l079Buo+Xft+xyW+6CCyCair3oe8F9EUaMskPvUTbpg4htnCUaBwsJCHVqeRDxyMQ4zfmqNVHyAoMMwCXE8+U6a+zto78RCQi6LNC1MlbLWZE/xodMCzPxgOTdzfHaIh/nR2ZR6ZCfv0Zedz0dUYWhUg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(39860400002)(346002)(376002)(136003)(230922051799003)(1800799012)(186009)(82310400011)(451199024)(64100799003)(40470700004)(36840700001)(46966006)(81166007)(356005)(82740400003)(36756003)(40480700001)(40460700003)(86362001)(83380400001)(16526019)(336012)(426003)(26005)(1076003)(2616005)(316002)(110136005)(70586007)(8936002)(8676002)(7696005)(70206006)(6636002)(478600001)(6666004)(36860700001)(47076005)(4744005)(2906002)(41300700001)(4326008)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2024 09:57:26.7821 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 84d4931f-63a8-49c8-35cb-08dc1b308a1e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044FA.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4160
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
Cc: Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

amdgpu_reg_state_sysfs_fini could be invoked at the
time when asic_func is even not initialized, i.e.,
amdgpu_discovery_init fails for some reason.

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/include/amdgpu_reg_state.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/include/amdgpu_reg_state.h b/drivers/gpu/drm/amd/include/amdgpu_reg_state.h
index be519c8edf49..335980e2afbf 100644
--- a/drivers/gpu/drm/amd/include/amdgpu_reg_state.h
+++ b/drivers/gpu/drm/amd/include/amdgpu_reg_state.h
@@ -138,7 +138,7 @@ static inline size_t amdgpu_reginst_size(uint16_t num_inst, size_t inst_size,
 }
 
 #define amdgpu_asic_get_reg_state_supported(adev) \
-	((adev)->asic_funcs->get_reg_state ? 1 : 0)
+	(((adev)->asic_funcs && (adev)->asic_funcs->get_reg_state) ? 1 : 0)
 
 #define amdgpu_asic_get_reg_state(adev, state, buf, size)                  \
 	((adev)->asic_funcs->get_reg_state ?                               \
-- 
2.17.1

