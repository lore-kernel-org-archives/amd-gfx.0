Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22479E7717D
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Dec 2024 02:46:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 91FC610E375;
	Tue, 10 Dec 2024 02:46:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="HbWECIMj";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2085.outbound.protection.outlook.com [40.107.94.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D15B210E5AD
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Dec 2024 02:46:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ezAZZoL+UQD07Ht6TKeZH3iQz8c3qDkGfhH8oE2jVkGB65CFyf5F68yn/8BJw7bokubqF7sBKPCY7zGEqViKqJPLyfeIpTWb75OH1XdteU2tiXwRsda1GImpmq6dK/6g4ofElFPhoOkU9CMWyIQdWShS6tWgcS2SnAf2KhoacVZ1TBmBUHxPLbtENSR+SIfz89atPeDHJVnHB7h3+j885nhRK4MUYjWMKEqWa1BVW0GzcRfEUWmZGHkYLW5UrRqzqkl4I5w/FpqWekU5eiI3N5NtFmHrusHkmjZz957tLvypE/hWw9z5ymlV62N2oHKyiZm6PoOCWlx6TC5Y2UKB3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FdKJokFHzeUU3+rOariDpCGAiZbRnjmcKOrAOo5Fk5M=;
 b=FupKf8rAIayQ7ps5xrtLR50WOgp7GTkZpKMMUiUNEe0WbikWVKvIAEeBY8/ryO8iI61PSUOcdSTH0qz2cFQgqcRWgVmiTeK0k2fdadC/lGQ2WhvYp7ggkYUVPe/W2odw5eCaB71jdB7cMpTFK2Nw1x8WIZYvhKaDKxBq52m0Ub/TIoPs1BZG4JQtqX6fna+bD6up/IblBpq9DTB7q0hF7XjvmgG6Thcl9VNjxF2YnwtMPvNepLLkQiHFo6Ih0pVl36HcOrLMaAdaCXPFBKJbG9XXG4XEJkHcijtTxlXEh92MjfnE5dlGb5ctRPKAZHa0i+3Ialgbfq9WDU/KldrKgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FdKJokFHzeUU3+rOariDpCGAiZbRnjmcKOrAOo5Fk5M=;
 b=HbWECIMj4cKZpcsXFEyHRUqiujQVJZAbtKPyl0j1gUu2mr4UuGekO2x/0MI1JPnE88lEHKSnBE/0WVOds95G2gEJMBgcEIvnUlGhBDGDTP9VNG+f/BzAmqS9auToU8TLTyZ0c9yWN1uPtQE6q2kXp5008ZTSPTFmVEI8Z8WU3C4=
Received: from MW4PR03CA0065.namprd03.prod.outlook.com (2603:10b6:303:b6::10)
 by DM4PR12MB6541.namprd12.prod.outlook.com (2603:10b6:8:88::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.18; Tue, 10 Dec
 2024 02:46:15 +0000
Received: from SJ5PEPF000001F3.namprd05.prod.outlook.com
 (2603:10b6:303:b6:cafe::6e) by MW4PR03CA0065.outlook.office365.com
 (2603:10b6:303:b6::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.12 via Frontend Transport; Tue,
 10 Dec 2024 02:46:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001F3.mail.protection.outlook.com (10.167.242.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Tue, 10 Dec 2024 02:46:14 +0000
Received: from mkm-d10-yfeng11.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 9 Dec
 2024 20:45:27 -0600
From: Yuan Feng <yfeng1@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: yfeng1 <yfeng1@amd.com>
Subject: [PATCH] drm/amdgpu: Fix for MEC SJT FW Load Fail on VF
Date: Mon, 9 Dec 2024 21:44:59 -0500
Message-ID: <20241210024459.2993-1-yfeng1@amd.com>
X-Mailer: git-send-email 2.39.1.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F3:EE_|DM4PR12MB6541:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b2ba3c1-b2f3-4de8-73be-08dd18c4d061
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?NvPPOvCk/nZANKvys/4Z4XnlDHqGPuM2fOHvHrOzRkx9I4ywFu6Vx95/7tQT?=
 =?us-ascii?Q?FpOa4tsX2Fm2eeiURf3f7IRhPc97KJ4Q5ZekVkYadl3FYH+lRG+WHjczOvIT?=
 =?us-ascii?Q?SXl9T5TCQEzD0wYTSelxOHd1tnBxUMWym6cb6mJYL6R7abMSOMIpoKXEt8A5?=
 =?us-ascii?Q?pewWFzOHB1/2ptLnkUi8P11akbdQFw4+aXTJCinEzQt0y1p4dzoocGgu8c8O?=
 =?us-ascii?Q?53aYuKTOWmfVVcRGputWl2eCZ9c1ySdw3dlPcPWWIXXa/uMfN3BTi+S6l73E?=
 =?us-ascii?Q?MpyIpzo11EzWHyG6AOwgkDICoTC5s10ha6SrLvSEC7Aw/3kE+wpZns50qaJc?=
 =?us-ascii?Q?vcVz7z/ad2b7dbXAYQRPhGKqNpOsDxXcIR6ejASuLXi/JGcqAeH5NgolEXdO?=
 =?us-ascii?Q?Cmm2XrOSNT/UH63685Ade2hs2U4Lm0BeYKahvV+V62VvPW7TSHeNq0Ynr5Hc?=
 =?us-ascii?Q?/SeuV+jXUi66hyxzm1Z8dr3Xsz/0TrLexkAcTLkylMkJ9wqLmFxzPiYXQ2G3?=
 =?us-ascii?Q?VTs/7lR7Dje/9TwTqmb4qRNHLu2G6WaFNpgkhnEMAWs2KzLjWqh7Pk9b6SuA?=
 =?us-ascii?Q?yrGCep2OGvhtNgf+y6cNaEN6tAGtchNMUcuE3uR6K+bIODrXDWJxni7K4sJ/?=
 =?us-ascii?Q?Z9Tdw1fBk3ub/3sN9kcfGAOx5Dvt6E4GoBs8FOJb8M6v165zyGDWN8DEwyOs?=
 =?us-ascii?Q?smFzrfTWQiTSosP1XfnUxbxe0+DjpMeTmqnDEevvJ0VEj72nOYDO9mn0i9Bi?=
 =?us-ascii?Q?liszbcxxRGdG+aZ4LbH+DCXHH4jt7hXfCoeTAkcv+wjekIvbRdDh/Y7bVM0E?=
 =?us-ascii?Q?Ft6qTRz+o5EwnWqhTC5YF0IS1S2wzh4yw3V6PSndKg7Bb9vT3wwLNL1/vR67?=
 =?us-ascii?Q?VDmN3YGjxsA34kecqMwktV1yW0S92QOntLuQMxbsNoS/gXUII3RNHWsP6kt/?=
 =?us-ascii?Q?brO/+uQGE9lZH1GU26ffe/VIPuUmcqmTJRmecb1i5Moq53+EvGGWqlxUtz/L?=
 =?us-ascii?Q?O23CI674hwKouvx0K3dsu1VPdeniPF82IUOeGYpqiYSMNXuV51ATSq+E8iHV?=
 =?us-ascii?Q?OCzGxHebpKRNtExsnGn/5uPzF5TnfT5HRNF/KYeTq1qJc1rjxgcsCne3vd90?=
 =?us-ascii?Q?SVtIroKtJBgsfk1tztIxIqOCbD0JsUV37i3qSU7k1zBxTT6bQFUIwltGyUkB?=
 =?us-ascii?Q?TBaP0XpngKbH44zHx69hXCS0c9aiPC9Z2XTapyccx4PAWM/WA0A5bQZE/RNy?=
 =?us-ascii?Q?CVjJ0pE2jqKtHpgH91kG5CWH1rkbuJSrBzBzyxO+bpr/+afujtzDVUZla6iO?=
 =?us-ascii?Q?/3qI+vSIw0oiqhy/uiRMEdFpPK28c4XyWhBKYpM1sfxzgTeUY4HWnmIJCk5w?=
 =?us-ascii?Q?Bd/no9Gv821iArp+fEMoqWJkYo1FVMJy/G7vphD6mF1QmIZWqFXj2BgWcKj9?=
 =?us-ascii?Q?/h75V/aYZ42a/HnGHJHwnhgmdU9mPfjr?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2024 02:46:14.3776 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b2ba3c1-b2f3-4de8-73be-08dd18c4d061
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001F3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6541
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

From: yfeng1 <yfeng1@amd.com>

Users might switch to ROCM build does not include MEC SJT FW and driver
needs to consider this case.

Signed-of-yfeng1 <yfeng1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index cc038f300a56..5e6c1aab2e83 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -579,10 +579,15 @@ static int gfx_v9_4_3_init_cp_compute_microcode(struct amdgpu_device *adev,
 {
 	int err;
 
-	if (amdgpu_sriov_vf(adev))
+	if (amdgpu_sriov_vf(adev)) {
 		err = amdgpu_ucode_request(adev, &adev->gfx.mec_fw,
 					   AMDGPU_UCODE_REQUIRED,
 					   "amdgpu/%s_sjt_mec.bin", chip_name);
+		if (err)
+			err = amdgpu_ucode_request(adev, &adev->gfx.mec_fw,
+					   AMDGPU_UCODE_REQUIRED,
+					   "amdgpu/%s_mec.bin", chip_name);
+	}
 	else
 		err = amdgpu_ucode_request(adev, &adev->gfx.mec_fw,
 					   AMDGPU_UCODE_REQUIRED,
-- 
2.34.1

