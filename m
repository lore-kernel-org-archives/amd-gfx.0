Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E849C021B2
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Feb 2025 06:38:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0237110E574;
	Tue, 25 Feb 2025 06:38:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="V1zOYTpC";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2044.outbound.protection.outlook.com [40.107.223.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1ACF010E574
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Feb 2025 06:38:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nJ1Uy9k4WJw8SzsrbWhdKcxz0qde/j4W+1D4HnggZzZJt/Sf8Rxl/z7sBZhzZTD0eMIxOsOCVyDUpcsLxEVJCwozZ900J1DNr2Kn/QVnwJnWHWCsC13v6LwOivqomiGx0/F3/Po+s1YXYyCdrfDuv85NKn/nveb/fR/K1hxxPBnZnfseClUWH+MOHMH021WyhDMQ+jnWtxAG/36uj1K9POu8eSieqfmWojegrdNMBJwDPPfevzLtxkdaevtTaX7TfN0Ji1gFtQWOUAIlWqcsH5szlcSROIYA/KNQx77h2471YI0N89DsI1WEqBhMRkJoFBkTqi5uWXDD5Ax72ozlBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S47gZmZf9umjsB1B/fvS7P84V1Q4R6tKSKxwXDocIag=;
 b=INlhbSbdeGOQa1FEm5C0xISlHAoCPL+0fUm+ldUk5EAlb1YgIY2MBEhX1juNAa1SInUwqzV/dQ1c//7kS2tazRTZLPrWeG+vbhn5k2kHwQfongDJ6BhJUn7zszXS8Ad9Ri9mmhwQ1sNnwh4o6eUcEHZ6j+QuVJGolop/pUEYVs2G3pS/uSDH/g35hpV7d2jOm3+DL8WKdu8XJnfdVCmDjU5oHRIC7pKpYVmaVoJpr7YK6ziVO+X6WF/mjA16t3oiN81Pw5mfHEoasoV3zh5GGYkSnklLzocRsFgSXEDSic3wG0rLfyIteU6xZ2KczGrVIWmr9PaD8M+sZaOPiUOqhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S47gZmZf9umjsB1B/fvS7P84V1Q4R6tKSKxwXDocIag=;
 b=V1zOYTpCD3G9ZQeLV0jTDp+3Ko+F9lGhfhJl/VHBomo5KKTyZwHL/LhcZq7cprUkrd4sOnw4YFDtPWmLnym82aLulEPtgWGw3ivJ2Hxg91VE8RC9S5elgxVB0k7X69q/5xpmgThKgf/U2bID65Ju3vr3ymlh9yoSm+ucI9VAFtk=
Received: from BN1PR14CA0023.namprd14.prod.outlook.com (2603:10b6:408:e3::28)
 by SA1PR12MB6948.namprd12.prod.outlook.com (2603:10b6:806:24f::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.19; Tue, 25 Feb
 2025 06:38:42 +0000
Received: from BN1PEPF00004688.namprd05.prod.outlook.com
 (2603:10b6:408:e3:cafe::56) by BN1PR14CA0023.outlook.office365.com
 (2603:10b6:408:e3::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.20 via Frontend Transport; Tue,
 25 Feb 2025 06:38:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF00004688.mail.protection.outlook.com (10.167.243.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8489.16 via Frontend Transport; Tue, 25 Feb 2025 06:38:41 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 25 Feb
 2025 00:38:41 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 25 Feb
 2025 00:38:41 -0600
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 25 Feb 2025 00:38:36 -0600
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, Solomon Chiu
 <solomon.chiu@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Alex Hung
 <alex.hung@amd.com>, Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH 26/27] drm/amd/display: Use drm_err() for
 handle_hpd_irq_helper()
Date: Tue, 25 Feb 2025 14:36:09 +0800
Message-ID: <20250225063610.631461-27-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20250225063610.631461-1-Wayne.Lin@amd.com>
References: <20250225063610.631461-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004688:EE_|SA1PR12MB6948:EE_
X-MS-Office365-Filtering-Correlation-Id: 81d2b38d-3bc6-4a06-7dfb-08dd55670b8e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?N9sw5zz1EXqn6JX8w6EYoZzskZlX2g6qgDvmj1uWN8ISWDVmNZHorej1tLSz?=
 =?us-ascii?Q?MI/tmcmHTVKlUBo7Pa5gXoYtE/+quFxaeMMZchH11IG/kttm7nWi5AWHqv2X?=
 =?us-ascii?Q?D1m8xJ6M9+5AwbH2mN1eJrqIT/BnXils4i78Vznz7XlX0WOTl+xqignwVbwJ?=
 =?us-ascii?Q?rz+ZtbTTAsdpp5Rb1tIXGZ+VIuOnr5FLRudE788kRvdaa6MFi97CWc2WEgPm?=
 =?us-ascii?Q?ox6NvGR2FmVvb7qvyZQ0I/Z4pg1JOTPWgbMqdF4fYETc3Zz19w6j3z5Lfd6y?=
 =?us-ascii?Q?Bm6UNYlD1N2xJSQEtMfqQee5Ns+TqwuMaebi09YJNFtwGvqgLMKCByoTReE0?=
 =?us-ascii?Q?UwDfmePAYXajmXNgVmhGa18XUP8Zyo3aEvGGF5OcXaZ9JxMi+2uUOnjiuBUl?=
 =?us-ascii?Q?iW0pNMEbfEfXd/DpCCl35OJOiJucCrg+0OArlhveDUybCTyJCnJ0SPBKwQn/?=
 =?us-ascii?Q?AeKK6gk1dzGx1sV4/k024elrPQz7A9jNjncQ47H/MiNaEK+w/SJs6RNKJWIY?=
 =?us-ascii?Q?hfFM0mZrH41epUoownWZdno7O0OMxdhRzW41BopawqZ7rlhJ8kv1WW7W3agF?=
 =?us-ascii?Q?YWeRGKmN/xJvwpD5qKjolg8ftX8/D+El9Wx/kQqKl7ggv+Wn3IIqZRKBc0pY?=
 =?us-ascii?Q?3r5iBIFUyWC707bBipCV7tmTm5rQV/lbetT34D99l1wwOBhyCucMsrkz7t4R?=
 =?us-ascii?Q?vkimaaeP+OL7guznx0Lo3cdNPg6LwJXv7t/Iv82fj9rfW0sTfO2Dbz7cTANf?=
 =?us-ascii?Q?JZBSAKm/w4rdEZumW7phFIAeeNZfaJThaJncnNwp3cptrdJtzv9wvbOAJrcE?=
 =?us-ascii?Q?fCUOWkytF7lPTMndaBi96rNTto1eDut/IsnPaDvW/oXn0LteDvVCsl1lEcwu?=
 =?us-ascii?Q?3bLhI7ojwaowRws011bpU9127n9IrZLzdhz+V2NXg68nZOYLkTJGZwZ1l5h1?=
 =?us-ascii?Q?87fQ2q85jWGJuOGMoY3Qmv4lkcP8qHNEYUHl9INZUXlYiAxQ+bsoscjlJ11v?=
 =?us-ascii?Q?oqu+pRMIaPmSqfE5SXda/TywQjoN75WAldI+2lxHAi69L70n61N7uilWggAv?=
 =?us-ascii?Q?bGLJTejGoW0ztLR1c1s9slVl5tbNG+RYWYh3VhayNhMHB/aSTR4F0K/6ZSZj?=
 =?us-ascii?Q?A2RLlas/EwlypwdaEE1Oldb2SrnT8b5VdKeph/popDEGJHqkb4JQkj8dj1Lj?=
 =?us-ascii?Q?IRR9/HNpUQiB0vapq7HR+5GmgDxNK9VjCBp0sVu6Itw6a/gc0hoUXgcKPmkT?=
 =?us-ascii?Q?fCh9Yx4l2LfjIMXuF/aEMGJ9lTVokTwiMuwawkCkta/s3UnK2mgFkdH5DlUI?=
 =?us-ascii?Q?AkUWmDByhMSP3SmKef5E3oh0RS9Fuj9OYPwF0mzpV2JcPcfMcSMVM7MK63ij?=
 =?us-ascii?Q?8MYVMyiKXbjm8oYjgfxI7gHAreCM7IbP1i9Lt1IGptj2UADxmuMBMOVaZiPB?=
 =?us-ascii?Q?tNeFzRN6teuNYjEm/XMA0AKZeXgXU0LI8vHL7e+SfcbmHbKuO4+86WqE9Syb?=
 =?us-ascii?Q?7OWBdZaFImEDlk0=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2025 06:38:41.9733 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 81d2b38d-3bc6-4a06-7dfb-08dd55670b8e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00004688.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6948
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

From: Mario Limonciello <mario.limonciello@amd.com>

drm_err() will show which device has the error.

Reviewed-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Wayne Lin <wayne.lin@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 03b6f31fd792..73c95c3c39f9 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -3817,7 +3817,7 @@ static void handle_hpd_irq_helper(struct amdgpu_dm_connector *aconnector)
 	aconnector->timing_changed = false;
 
 	if (!dc_link_detect_connection_type(aconnector->dc_link, &new_connection_type))
-		DRM_ERROR("KMS: Failed to detect connector\n");
+		drm_err(adev_to_drm(adev), "KMS: Failed to detect connector\n");
 
 	if (aconnector->base.force && new_connection_type == dc_connection_none) {
 		emulated_link_detect(aconnector->dc_link);
-- 
2.37.3

