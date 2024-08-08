Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB6BCC3DA4A
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Aug 2024 04:25:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 88D1E10E03E;
	Thu,  8 Aug 2024 04:25:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="t84HoucT";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2058.outbound.protection.outlook.com [40.107.244.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DAA2310E03E
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 Aug 2024 04:25:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g6XpQHIZLaxuhpOSRMB5sWWCIvjTHqe/0he1SfZ6uIW31tu9W3SmMd0BYw0XRoWnFHP8iL0NPMAS3WwTNefU2UwTJfn1u3h/f4JXYeK/lAUzwpF7RVN9lsaMUluapUVjKc9vRK/K8wwCJvIeQZ1JX0vtAMUN8G5VJN4L6wxnl8dZX83IaH18LYlz9wkE0kLb6C6w086fuYznHp5hfl4nAsSJFfKmojcC7hg69L11oCfmFmsk9iCqSdvtA8I08h3gU7oQaSR/6d4Nfm/Xpo4q1kpIV0b4E7S/iV3yR94AF66SaQqUGf4B0ZpKBr8/pcHS3HEFp6HSstfsCdLfsPI2YA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WcmtnGR0aSSXOGb+dGtoNBMO1iT86I5uph+QYRNnPf4=;
 b=PtH0YJAn8O7eNVKjk6GQYKzMXm+sg9UeEbBUUoDPM7Db789x68dEuMkMVmFoJINiaogJSOoAEuwcw40jBu4dstC+vAT1GrNi4k4j4MzlW5CYwEwDux+bV4XcfLMw2FlyU1uPbwCEsNSpnYmU7dg7pFZdGa5gWaCQHrU5YjNO5oXqnhA3cDWwOzepMLsQltlPKQsDooLmhzmnU3mTgYdIJtseQ4tAnnh2Llwv7JFHzRtetKsGJIEQXTrlWXzZ4cG4CmVKmG/+82PPkgOiQMDKPihRKyud6UpIp/8rTScOJqN1rNBVRVg9ZsG1tBaqAbBSieQq6oQ/mscoL6tuKfktIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WcmtnGR0aSSXOGb+dGtoNBMO1iT86I5uph+QYRNnPf4=;
 b=t84HoucTgCFMSwKA1ssU5MgTSsurXLVFx54q0x8XI6aHHI3nRn2ZF+76NzsZm53IGxO//9Sx+PuhNl96eUacShCkbiQMV1dIP8pHXWsfeRmlfl67TggAjUWpoS4XMNeMiJhL4So9jBfRkOEBn8FUXiG5FOQO8r+XrheDO1hNI6k=
Received: from SJ0PR03CA0036.namprd03.prod.outlook.com (2603:10b6:a03:33e::11)
 by PH0PR12MB5648.namprd12.prod.outlook.com (2603:10b6:510:14b::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.22; Thu, 8 Aug
 2024 04:25:46 +0000
Received: from CO1PEPF000044F0.namprd05.prod.outlook.com
 (2603:10b6:a03:33e:cafe::65) by SJ0PR03CA0036.outlook.office365.com
 (2603:10b6:a03:33e::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.30 via Frontend
 Transport; Thu, 8 Aug 2024 04:25:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F0.mail.protection.outlook.com (10.167.241.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7849.8 via Frontend Transport; Thu, 8 Aug 2024 04:25:46 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 7 Aug
 2024 23:25:43 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 7 Aug
 2024 23:23:46 -0500
Received: from kenneth-mlse-vm.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via
 Frontend Transport; Wed, 7 Aug 2024 23:23:45 -0500
From: Kenneth Feng <kenneth.feng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <kevinyang.wang@amd.com>, Kenneth Feng <kenneth.feng@amd.com>
Subject: [PATCH] drm/amd/amdgpu: add HDP_SD support on gc 12.0.0/1
Date: Thu, 8 Aug 2024 12:23:42 +0800
Message-ID: <20240808042342.248708-1-kenneth.feng@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: kenneth.feng@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F0:EE_|PH0PR12MB5648:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c887b6b-a411-4868-bb0c-08dcb7622c92
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?7gjvECIuw6NykCCJEV/yAOFldx+s3R42TBtHJZ7WvHjyVnBJxgxCY0OLsXK4?=
 =?us-ascii?Q?orOEH0rtCSXCZLCIYEypFE/cKy1+6Lm8z9e6AI6U/fWD6VHSF3s24KyiQPy9?=
 =?us-ascii?Q?6zgOjWP4Rd0r0mOM/tbXowvbKzsCP02WBU+YbIp1VT0Dgi8Pc2erSrbT8yBC?=
 =?us-ascii?Q?HndedkuVY38zgTJvRWmuDIF3UimCYrr+Dae/NNKUgCHlSMnHJm92eEAB1QBU?=
 =?us-ascii?Q?PHLzFggS7o2Qr5uLFaOh4ulBMVpj2kk3F550mb4KsCKfQy5ZH0t10+uaPMXo?=
 =?us-ascii?Q?PPL+XTcUM02g2MfTi3iZ34tBF9d7EktL6VrZ09atQN7jKq8UApY+f8upCTKz?=
 =?us-ascii?Q?PQWJ8Qr25x7pi7peiF74Vjcc3l4w81nkVg0pEgUtjxmU9cvPaXzQpz48WQTM?=
 =?us-ascii?Q?gd3QU4aPuSNhHbwQyzP+T9y5EBdGnmzioi6ejOnQomEPpUWpEtoAttQAr7II?=
 =?us-ascii?Q?YKcOe6HP291fhvla5itzZ+yQHBzWvNhXLsRVaWt1uHh1zbSlK1EP0r2Tc+YR?=
 =?us-ascii?Q?rx+F33sbsa6ycMbeRDblUV7VabJKBvnV7SdOr3MIMCHvYY6RhJFP+roTBi26?=
 =?us-ascii?Q?dApiB+dWSgtmF/aVPvUj++oqcq5Vere9O+mayqDfYXNyEzXgP01tJuCxOOEa?=
 =?us-ascii?Q?d67VaL/bWoiIcSNhuLTriiOdrgzfOA6bxe4T4pTHc3U9wwUuOnjBWXF3wqOu?=
 =?us-ascii?Q?eajaFZpZfgxc6bU323NnUPIkDnU5Qwahq+RqhViU/0IS4a5mAjhhL9ZxWhoD?=
 =?us-ascii?Q?umW5oUm+a5cSlgMmWG46Wy08MdJeoKf+hXPP3bWHfG/l9P578FuP2oANy87a?=
 =?us-ascii?Q?kr6ZugPqw8unpNVE/pGfNDcz6XU2goJ0B4TKUbaGxg/PtnQQNmFrmbZ1+ueN?=
 =?us-ascii?Q?pcIB5btygc0VtLrsPr+LGiDHEymP5EQFnSKinBeEdcQFa/JCBrfXnouaCSTO?=
 =?us-ascii?Q?AvBr5zwOma6F60eh5nDgFOZ12YVD7NEFMSxRoEIxbciFT562STDWcnFoq4Y7?=
 =?us-ascii?Q?J1gav1eWDNF9pLxjksh+U+A3LyiuQjkDfzcmlx4QKPN3rUFC01P8BN9onKAa?=
 =?us-ascii?Q?89EUS1gWCDfk1qjW2kOfE6SSEWJDyiKImHy5IGs8AUwq8G5hOjY7ONQkHt6E?=
 =?us-ascii?Q?I6jb2jaWrLmZjMQsGvDxA9pn6elNO71tE82AxHSKv93e4jIsLEPdXQ+1DzHT?=
 =?us-ascii?Q?vnFcV0DpGW2ukSl7XlFpT1GwmXIJYWZHmae+q72sd64w3K6CjNtvScqCH5yG?=
 =?us-ascii?Q?S5fiOOwJSm4uQFAtKPwKuHJsp8ohlF9NmU7x4vjieEOiq4EH1OWGL6YoqkjG?=
 =?us-ascii?Q?57Ja+/HD3yPzouPFEJCHKFnEZlD0tUzxL38Ntfb4u0xNoFtWP8e00flmCvUY?=
 =?us-ascii?Q?c1qcq4tuyUjj1uE3+ZUJzbUFI/M8/XRBoM91V2tK/jtwryJOswkAfvpYWSHD?=
 =?us-ascii?Q?KUBlAM5LdkdJFqJ/LR0DQeUoptYYixjp?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2024 04:25:46.0853 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c887b6b-a411-4868-bb0c-08dcb7622c92
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5648
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

add HDP_SD support on gc 12.0.0/1

Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/soc24.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/soc24.c b/drivers/gpu/drm/amd/amdgpu/soc24.c
index 7d641d0dadba..b0c3678cfb31 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc24.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc24.c
@@ -406,6 +406,7 @@ static int soc24_common_early_init(void *handle)
 			AMD_CG_SUPPORT_ATHUB_MGCG |
 			AMD_CG_SUPPORT_ATHUB_LS |
 			AMD_CG_SUPPORT_MC_MGCG |
+			AMD_CG_SUPPORT_HDP_SD |
 			AMD_CG_SUPPORT_MC_LS;
 		adev->pg_flags = AMD_PG_SUPPORT_VCN |
 			AMD_PG_SUPPORT_JPEG |
@@ -424,6 +425,7 @@ static int soc24_common_early_init(void *handle)
 			AMD_CG_SUPPORT_ATHUB_MGCG |
 			AMD_CG_SUPPORT_ATHUB_LS |
 			AMD_CG_SUPPORT_MC_MGCG |
+			AMD_CG_SUPPORT_HDP_SD |
 			AMD_CG_SUPPORT_MC_LS;
 
 		adev->pg_flags = AMD_PG_SUPPORT_VCN |
-- 
2.34.1

