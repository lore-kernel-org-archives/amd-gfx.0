Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30889C48BC1
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Feb 2024 21:34:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B682B10E40F;
	Wed, 14 Feb 2024 21:34:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ulM/c5S8";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2085.outbound.protection.outlook.com [40.107.92.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AD48710E172
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Feb 2024 21:34:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M5tGSdRJoVqhzijVW7qKf43t1eK1K33rOuCEoWcXuJSGqHVjajHGgcpQOrua5n1AXUpAt5kQqRh6IcoVqDlN69rUXiKM9xQgjmp0sDF/F1ViHOmD65HIWtIBDur/mRUrQSJkEGvSqhj9Fvl+nLPulrLN/qGhK5KskMBh3ii7/daogqgrstQQ8M0Q29hoBe6NYpwm4UC5RQXPQBerqbkUShpnub5Hd7Us4SrEXkr0TZSHDkFDpbYeNP9wO7+KHTm7NKnq/eiX+LcxfkEM+oSKhnkBShpmNnhknhThQveydOtJEifN0UwZ4So02VneazuGPGWE7V10J4Jaa9MJ363BtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mhpBx/nbCjKVbfn/BZ3bHodxHjUPPSydmTYg/aNX1Uw=;
 b=eyG2rODhMxJTd/QF6/7CfnM13/X3OoYc6atbWGF+wwR2MYYAlpW3O247IlfeUH5l6W8ulv5d9EkMrp5i+6MVcmC8a6tOKvYWXDQTDyoPatJHcGT0y/zHV759FdKA7eRzfMrRc8niHwnbKiWc9YeK+ARNxJEgqs4tl5CL1g4nR8KMcODDpc1OOGDB3HL4LfGBjQHe7+exXPaGDHyV3s+0ecuJ6HqxnV0vTrP3q0TtaWfUADcgJDyCnSUl9i7Cl/5uey6XsaND84ihlyfl8PJkfwo5r5DOnK9FPz52KactJVAGaxizS++nhgXAoFVhF+rnxX7fVoVr3T1Y/vrtoX/c+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mhpBx/nbCjKVbfn/BZ3bHodxHjUPPSydmTYg/aNX1Uw=;
 b=ulM/c5S8th9Q4ttRkQqZNFh0TFWWA1yst2ocaFxdf/tiMbzzyheufZstjwlUB6XjhIprrimk11+/nWZu8HY3ED8VROZU7TSwEPJfNKawIoKu2rFN5iO24qMlFFiequTdUKxO+SAhhCs9fh8Ej1Zy4ycU1RCOTgG7aYUJWlrCMmI=
Received: from DS7PR03CA0344.namprd03.prod.outlook.com (2603:10b6:8:55::28) by
 DS7PR12MB6072.namprd12.prod.outlook.com (2603:10b6:8:9c::14) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7316.12; Wed, 14 Feb 2024 21:34:31 +0000
Received: from CY4PEPF0000EE34.namprd05.prod.outlook.com
 (2603:10b6:8:55:cafe::dc) by DS7PR03CA0344.outlook.office365.com
 (2603:10b6:8:55::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.26 via Frontend
 Transport; Wed, 14 Feb 2024 21:34:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE34.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7292.25 via Frontend Transport; Wed, 14 Feb 2024 21:34:30 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 14 Feb
 2024 15:34:28 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Yifan Zhang <yifan1.zhang@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>
Subject: [PATCH 1/2] drm/amdgpu: add PSP 14.0.1 support
Date: Wed, 14 Feb 2024 16:34:12 -0500
Message-ID: <20240214213413.2592186-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE34:EE_|DS7PR12MB6072:EE_
X-MS-Office365-Filtering-Correlation-Id: 0199b086-0d09-4c98-edc2-08dc2da4baa6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: q4c7/BEa9oaY7uLkyoPC8eCKpL7A91Ni+u0wRlNzj4Knvu+pHDCwqcdBbXTj6uNSmu3au8C2A++Eo2LAEKHlxmqdt9oZgbJ/RBTMiKTaek+lb4GPFUwsK7x+kKjPYsquODV98cI3g0F1qRPbE+5dK/GIbwIBoNMzTqoIZLo7MV5Oe3mQflsN15XXH3ZL7sWQNcJpzGVCFRrcebdGCi+4A/bkbXix2D0espQ3Oh+b5JyH9L66a4xvsuvstS0uAIBGqOi+d6K3eN1D3Kt3Ct04c+o+W/b+hug6f/YsJpUtFyrCbef3yyhUXw/GBQ5ajTev6/gGECbgsuKWWsATOEmsnHHL3JWt70fHrAxpyErZfY7OAJh8Do+pSE5VEj421a4jsDGWADi9FjsgvKJEW+KFV09lT1TVGUn0ozCFq+oi5wTEzI4xrnytkS4Xvt5W46iiLSaYGDYOeMISh/jYGPVKsx6/6mmJEgcVcWmeZos3vMMEhez1m31FoNZtHnjCCRALvj8kaN5LoC1LALbRnQTk22cdQ51Dh7N7CgXvp6jF/vm9KpBfFxxzqQRePzapGH54CtTCLTQ6SBsh1LZ8dhFjvX5a+24ez0qVAj+prAzpuwAV6kDJ/9Xk/mUlX/CQ6GhZV8DCS671tXiKma/UI3A2Z+0O0HyKmrLCYwwyYatZWm0=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(136003)(346002)(376002)(39860400002)(230922051799003)(451199024)(36860700004)(82310400011)(1800799012)(64100799003)(186009)(40470700004)(46966006)(83380400001)(81166007)(86362001)(336012)(54906003)(70586007)(316002)(6916009)(70206006)(2616005)(6666004)(82740400003)(7696005)(478600001)(5660300002)(2906002)(426003)(1076003)(26005)(8936002)(8676002)(4326008)(16526019)(36756003)(356005)(41300700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2024 21:34:30.8062 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0199b086-0d09-4c98-edc2-08dc2da4baa6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE34.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6072
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

From: Yifan Zhang <yifan1.zhang@amd.com>

This patch to add PSP 14.0.1 support.

Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 1 +
 drivers/gpu/drm/amd/amdgpu/psp_v13_0.c  | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index f0f01eac534a..3c2b1413058b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -216,6 +216,7 @@ static int psp_early_init(void *handle)
 	case IP_VERSION(13, 0, 8):
 	case IP_VERSION(13, 0, 11):
 	case IP_VERSION(14, 0, 0):
+	case IP_VERSION(14, 0, 1):
 		psp_v13_0_set_psp_funcs(psp);
 		psp->boot_time_tmr = false;
 		break;
diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c b/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
index 0e4329640ecb..0da50ea46eaf 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
@@ -53,6 +53,8 @@ MODULE_FIRMWARE("amdgpu/psp_13_0_6_sos.bin");
 MODULE_FIRMWARE("amdgpu/psp_13_0_6_ta.bin");
 MODULE_FIRMWARE("amdgpu/psp_14_0_0_toc.bin");
 MODULE_FIRMWARE("amdgpu/psp_14_0_0_ta.bin");
+MODULE_FIRMWARE("amdgpu/psp_14_0_1_toc.bin");
+MODULE_FIRMWARE("amdgpu/psp_14_0_1_ta.bin");
 
 /* For large FW files the time to complete can be very long */
 #define USBC_PD_POLLING_LIMIT_S 240
@@ -101,6 +103,7 @@ static int psp_v13_0_init_microcode(struct psp_context *psp)
 	case IP_VERSION(13, 0, 8):
 	case IP_VERSION(13, 0, 11):
 	case IP_VERSION(14, 0, 0):
+	case IP_VERSION(14, 0, 1):
 		err = psp_init_toc_microcode(psp, ucode_prefix);
 		if (err)
 			return err;
-- 
2.42.0

