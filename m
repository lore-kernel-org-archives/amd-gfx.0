Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60282C27C4F
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Jun 2024 16:44:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DC6EA10E734;
	Tue, 18 Jun 2024 16:44:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="BclCAewm";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2080.outbound.protection.outlook.com [40.107.244.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3397C10E734
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Jun 2024 16:44:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A6ek/s2Ift4xfts+qld+x1YKyfpZr81k2q5aISQWLR+clXCBlU1XT4euiGjImsmK7r8WAc1rdW5snQy9VMa4ClhxAG1TseVMFuTr8Ay7pxpypsKKnqaA69QfMBiYx3ISlEvTMf7V9zjiKu7G9Gf4udO/FLZdTeRXGS0LrA389y0+G+uTm9kOo+AIKIbqn+3FJitJxI8FBvIOuDrK0mraA3ZASrxu8RnpF3qsutAag2Eo6tTOAMEYoBeJyPUHZ4le47sd/bwJFg4S1p622eqX+Cq3ORPAIiikF5U3vZC8zgbb8pJ43fkCX676uD2SXcNn7fstDmcDLbfJkTDVec6d6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ET1+rLGNcrkgCoLoXFjW0r/wY6u3OjaW2FFDW8qDTRM=;
 b=E0CzvLVIFWrDXnMKaTsmhx/Zr3RXbg1v/cV7xah3eLwyMK4xa4oiRsLcCHfQ37rVoxS6UdNIgbVt4RMCHCssfsPGSTT68oMHS/7rmhsDhbA9aZu8mY7dRmowtpNBfaqbxiIEhMAkhJdyGWFwDHEg5emxe0fYRpmGfo4SNAMHStVA0J6XC+dvvuCsIo+O0jhyzYO+NPVBJAYp8CGj712kyYKWjIZdplcy2JFZiCXfl0aTTsoNchOXnqjPGxo1yRUB9qwbSVDmY2unc2dJkjlnnIUH/l1oL4x1cpXsnYeWLJXwdB3INofUJj8ytX5m5tL8lY4mrLU2S2VXv8xtPONcow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ET1+rLGNcrkgCoLoXFjW0r/wY6u3OjaW2FFDW8qDTRM=;
 b=BclCAewmfnp+oenSbX9QZItu+CaC3zg7BCxRAnxt/32KS+yScLCOUFqr1jWKwXhsYlg3F+o6ZW+Y+R0HZ3HW+drE/yrU+yqUS96jpEHK4ohsZT3tJ7wm0vsljOarQ6xDUCDEYo/84TqI+8t9b4HFjK8+Xu5JEteasur1lfpzFfY=
Received: from BYAPR11CA0050.namprd11.prod.outlook.com (2603:10b6:a03:80::27)
 by LV3PR12MB9411.namprd12.prod.outlook.com (2603:10b6:408:215::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Tue, 18 Jun
 2024 16:44:07 +0000
Received: from MWH0EPF000971E3.namprd02.prod.outlook.com
 (2603:10b6:a03:80:cafe::38) by BYAPR11CA0050.outlook.office365.com
 (2603:10b6:a03:80::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.32 via Frontend
 Transport; Tue, 18 Jun 2024 16:44:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000971E3.mail.protection.outlook.com (10.167.243.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Tue, 18 Jun 2024 16:44:06 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 18 Jun
 2024 11:44:03 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Pratap Nirujogi <pratap.nirujogi@amd.com>, Mario Limonciello
 <mario.limonciello@amd.com>
Subject: [PATCH] drm/amd: Don't initialize ISP hardware without FW
Date: Tue, 18 Jun 2024 11:43:05 -0500
Message-ID: <20240618164305.24221-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E3:EE_|LV3PR12MB9411:EE_
X-MS-Office365-Filtering-Correlation-Id: df44dd55-ebb9-49bd-eba1-08dc8fb5dea3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230037|376011|36860700010|1800799021|82310400023; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?KUZ9Zbg8d4dhgJzFZy4L1/CS8c3nx9Dw+wcQvN4TK22S+GFsNQn5KXHp/q0k?=
 =?us-ascii?Q?MVFUBtfec2bihyJlRJg/3H8R6LDzHtsfswYxpFDlT8cJfzmvuc246Mi4/nlQ?=
 =?us-ascii?Q?6HEhhqIXSbNUVpKm9F+0NHAumZYh7N5wYM9Wt/RXfm+/w0xW9OoEeArBsDm9?=
 =?us-ascii?Q?oJtRUnQgNYqyjEvwoDQ+XEb+UHQN9PxWcaCiL75FJlODVYnZywP7cYFq0Ixn?=
 =?us-ascii?Q?xdxa1flr1YRimrAQQQofZjbSPyUIPztQtVA+FCEncoLgQQ5Cfn4NYFZ9cTiA?=
 =?us-ascii?Q?Z2XMqhQSMfhyvygnEFY6JVa2YMPUo/lj548ChIsjxBjX5QYO4/GHZdIB5lNG?=
 =?us-ascii?Q?Z6Mgg8mzDPILBg1Zq9SBuSUdNbhFdGnXfQxuERQnaHQpCUk9aw1M9GHZZCuI?=
 =?us-ascii?Q?ZsJkb4yrdu/+aN7uvLWoGT2ud0dfk5ZcVumtYRTrCdz83hmmWDoEU6/XVwC8?=
 =?us-ascii?Q?TbEItqB6AujEO2BHr0jQjp7JeiZUnuV4kvST8uqbSP9JrHZVBtbEnSBvBNtd?=
 =?us-ascii?Q?3QVqFujO4ekc9MWAXWMcpEHN4gvIj7/rTvWVaN5F32+9htOyua4nC8eiG+2q?=
 =?us-ascii?Q?jJIV5RzRuwmrAmyXnY5OAsi0m05QBBF5qEr62acncrPkAJjI4WpYZg2JyR5j?=
 =?us-ascii?Q?o2cr49O5fIXwuYDM/JsHIYgxSutzJw1j9Y7uqmPpiSs0siudv+tTtHIqO3nD?=
 =?us-ascii?Q?q5nvvpzmZNWOijmykcKRkSsPGktxzBc1jsmC7p8waq7hDollTstMG5fQhhN1?=
 =?us-ascii?Q?ZyrlsTz6c22WwMl3zYzpzSqsVwoXHCqYk0ob/TIPR1vxQT2vFQd2P7QcMfG5?=
 =?us-ascii?Q?zlCn6gLkcUYOWlmP2TC9FaczUKXfEl7k5W1Yl/Td1ZqpqaWimi07gWRm7VsR?=
 =?us-ascii?Q?3eiEY1wC3galSflJXFUHhz3ow3sDuKR02AhAb0tfQr8D7YlmzM/0a2EcHbqC?=
 =?us-ascii?Q?ix2EXRv5wH7bZ0J9EXdTDrP0mjzV/eU9nigzHDEowmFwD4mdYT8g5JHjVolr?=
 =?us-ascii?Q?eHuxmj4qGx082nJvgu/KrZLUKJQEgmNqDHGJSdiSVQ81VoIfYAiPTVb7pepr?=
 =?us-ascii?Q?K3fTS5oopIPXhNXnCkZIdV5TbNi0c3CUK8b9v8sHN5s6rz/ngqpBDjiJs55r?=
 =?us-ascii?Q?hNftB4s7HSn3XdvzvNc69GDF7wXz9g5XlIRjgDaI4akjdo3BDngIkn6VOWyf?=
 =?us-ascii?Q?MPVctJBfVPkBWsF4I31GanR0F7mY/G8ck6NZcdlhTDas1rNWurDaptAin2Bz?=
 =?us-ascii?Q?fdLVFEpfUy43+iG+WUFA6I9pktcGOx0jg/kQunzuzu/C9+VjYeNgOjsc1eEs?=
 =?us-ascii?Q?maHvW64KWi84PFNgZORAklo9KoKKk8qGUrmYqS7orwnbMSiwWTN2qso8AlHn?=
 =?us-ascii?Q?+ObYaaLtXhsHLkK251MKOcNP874XURHjXY2AJ7HkHwacgtw16g=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230037)(376011)(36860700010)(1800799021)(82310400023); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2024 16:44:06.5186 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: df44dd55-ebb9-49bd-eba1-08dc8fb5dea3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E3.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9411
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

Although designs may contain an ISP IP block, the camera might be a USB
camera. Because of this the ISP firmware is considered optional from
amdgpu.  However if the firmware doesn't get loaded the hardware should
not be initialized.

Adjust the return code for early init to ensure the IP block doesn't go
through the other init and fini sequences. Also decrease the message
about firmware load failure to debug so it's not as alarming to users.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c
index 215bae809153..4766e99dd98f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c
@@ -142,8 +142,8 @@ static int isp_early_init(void *handle)
 	isp->parent = adev->dev;
 
 	if (isp_load_fw_by_psp(adev)) {
-		DRM_WARN("%s: isp fw load failed\n", __func__);
-		return 0;
+		DRM_DEBUG_DRIVER("%s: isp fw load failed\n", __func__);
+		return -ENOENT;
 	}
 
 	return 0;
-- 
2.34.1

