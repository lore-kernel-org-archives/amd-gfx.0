Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2ABCE7FDCD
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Feb 2026 20:29:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3172C10E2D2;
	Mon,  2 Feb 2026 20:29:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="PYpU+znl";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010039.outbound.protection.outlook.com [52.101.201.39])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6CE8A10E2C0
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Feb 2026 20:29:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bFG+aRgvpoCtZxcPkO3HN6adss6gQ0tXXg+HFP3d8or2AkNxkl1v1spjlu3YwCM3iW8B0cXN4hnxM1XYZ6B6Dv3lAXHy2nsOF8Ja/eWTiQyIJh3nWyHvSzf92D+gNjObFdPG7nsoxheG38fdT950LvhzpeG8guT1mkQkJz05thwtX9Af0s2uCcnab6fbVYYiu4DNgdiWfxxwdpMQj4sN5Ys7SxIJflH2zZvxpZydQolhSz1KxV4PMnpl5vO0y76b1me1XlNAfO0IMM8jaShW3Bm37SrilfEBA/m22Xr1dAYb3SJMqFoZ4oy8mdxUEMm8iRAfUr+9iI+rGAopFNKPgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ih/ORx3gbfc51mneD+S7Xjix4xNEiO8TdoS5eLNz2pw=;
 b=X2+QBNabSVJr3apsKPXIKY8OeIuivxuu9FNkjgk2ZLTgMD4h+uGgKMkbaWviMHyBt1eAQyHHI/cpICkCe+PmJHeCZb3sahTzDmDlO77PyjoVVF4MeQkqDYcLLzK14mIPYLX+EQ+icP3eMbcSYx0StVTmQ+dBoaKSeQi3SYCBwHqLPhnbBnRxRBRzQeF34zZieCtx7GgRHm5W6vQQTJXMi6xvseThYpCwdUYKIu3bZWy18XyhgnAuNF+uVio/ozhtyuBecsKPMBEkxlrE1bXStI/ctfWiCk7MEPu2YqCaPWuIuJBP1RaBv3/mjcdmo6QQIqk2J1HfeG5DNCpcBk6rKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ih/ORx3gbfc51mneD+S7Xjix4xNEiO8TdoS5eLNz2pw=;
 b=PYpU+znligYM70gp5PqL1SOu6kk166eFFe1A/bfg/ZW4XahaMCnFkCnCwL1DXmce3zhB19aYnaHToQkbosSph+79LdT6BS5BAFDKXq/Bxk6sMRzketeI2WyuVQxdFFmhhZmugPcTmHQvYLF7C0Tx4BDZidT7PT1NRxgkysZmb88=
Received: from BN9PR03CA0798.namprd03.prod.outlook.com (2603:10b6:408:13f::23)
 by CH3PR12MB8901.namprd12.prod.outlook.com (2603:10b6:610:180::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Mon, 2 Feb
 2026 20:29:02 +0000
Received: from BN1PEPF0000468A.namprd05.prod.outlook.com
 (2603:10b6:408:13f:cafe::dc) by BN9PR03CA0798.outlook.office365.com
 (2603:10b6:408:13f::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.16 via Frontend Transport; Mon,
 2 Feb 2026 20:28:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN1PEPF0000468A.mail.protection.outlook.com (10.167.243.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Mon, 2 Feb 2026 20:29:02 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Mon, 2 Feb
 2026 14:29:01 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 2 Feb
 2026 14:29:01 -0600
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Mon, 2 Feb 2026 14:29:01 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu/sdma6: enable per queue resets on more ASICs
Date: Mon, 2 Feb 2026 15:28:50 -0500
Message-ID: <20260202202850.992745-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: alexander.deucher@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468A:EE_|CH3PR12MB8901:EE_
X-MS-Office365-Filtering-Correlation-Id: f657db7f-4d36-4e2c-b664-08de6299b3f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?jihH0I5eXv4tLLe1y/WqNJ+MuZrcB/tQkN/yRN7FsvuKdupE0ulfRnID406v?=
 =?us-ascii?Q?23HJ/OA4zwe9Xtrk7oz0lvbtWxYSgYMpXpKoh2kprRdqGVAHDOEfFQNrvLjP?=
 =?us-ascii?Q?/RNNi6NcmY5fcjvWU6MoE5/OxDgNMNUGHJ7tUAkIK8oCXqZFvyobB8jfMV2E?=
 =?us-ascii?Q?Vam4DiDS0u/swp9MqL8AtGagMIwxI24ofdHb47WGiciSG84ZHb7YdmQ0pd9F?=
 =?us-ascii?Q?6DuUXre6SJ5gtwHYtQ5mfTqpHEUIfi6t6/UiyAaJJfNr2O+2utPykgejzKTT?=
 =?us-ascii?Q?Ah8fRT4yYGSotfMi79Cnzschaxf2qORB1UmtWqaqdW8XNqjFmfMvyCl0AySv?=
 =?us-ascii?Q?ZDMt5XS6odvlVirrzp17V9NKFqL2iEkraO2KqdQqXl6GJagfy/VmemEtRSQh?=
 =?us-ascii?Q?DR5aI67rF11RYbT52sRZP6A7M7ZhfVKv5g3XxHj0TzqWFE14eUcNDMMRY7ME?=
 =?us-ascii?Q?gvrME8y/5aFtaDxbBlPPrNYHxSi+eEdEOBZOFwFxM84N4Vvwbxexhuj9C0HB?=
 =?us-ascii?Q?rv0hxxXnLPFqdequpPttNN1B/0eNwnrc69yXP9y1+RwRBK4iHC6wJ6fSRnMD?=
 =?us-ascii?Q?3wMzNo8P1Jg3AEsp0hAcgjUo3pCisUmbzwGmPWDPZGy5uBOarCa/2uqGrZ0e?=
 =?us-ascii?Q?h1Cl2REV4tQml75c4++qsezqckkFGdGLiA6lV8qhR93Gtz8rgP4/K7I9KH7S?=
 =?us-ascii?Q?XIZacJJ4ozEnxiWOcfWplZbdLLcsnrIX/oCs91a5rZt2FfCTOZeScj6Y8r8d?=
 =?us-ascii?Q?XDsJcOU6fX3sb044MyO4KMVOFoRcZ/Rgpivcqk/E7F57JT/cRpQO8YTHvPdV?=
 =?us-ascii?Q?gLBPfQHDwzcKzAIx96d/YQE4fHvZofCwmyk7unlUkeYAG+Gp3NvtGPHKuCYZ?=
 =?us-ascii?Q?MX3KXN0ZmZsqvbiEBmlUZEecx2TTiM3j5iy1/QJvDJRR58aFaSAwGjHGA1YR?=
 =?us-ascii?Q?0uN0vs9GprGy9lj9XTCMYZsiXYHnpixHyBjT5irVDuCdhqx048v+pU/m/58s?=
 =?us-ascii?Q?ihfvaPgr/9tp3e9FwgdJTE1A5SKdXXlO9Z4KvVpr7gHyOREcJYEeLzuPjeXv?=
 =?us-ascii?Q?e2JwP+XYJUfK+VhHl2T4ujw0LJv3LW01Pr7W8TXUijempcparOFyI/O+Hi7I?=
 =?us-ascii?Q?BT55SGLM4vDBCN2ctpbCUOOwd4859qtxuCVTchQaaF4zT3s8Hm2WGwunj4G5?=
 =?us-ascii?Q?P7e3tsSwLO7z1iyPP5kgYdddeGdrwyfrpE7P6IicCvVc0rC4jgOFqF+M1vKA?=
 =?us-ascii?Q?D9QBlNutFx4dLY+AK49xo8gKW+nzK7TdmfhIRDy3UTbpjmre8qnADaa0YSy3?=
 =?us-ascii?Q?+HGdSdhJS2tu7FfEGvg5S8X8Y62NytJ1f0HFIz/Z5XRooJNteZmA5/ZFUa6w?=
 =?us-ascii?Q?/L6txLrIEDIkyKSQXxg9zSUrlmxW3619cwgGztV+ojcNWj5WbMm6nzwxV7Tw?=
 =?us-ascii?Q?bk8dLKrW0YwNbF9Ri2Qhthqc9RaUoMp7EdcCbLYlKp/1RggVaTo7en73a9Jm?=
 =?us-ascii?Q?GYqzpy+akbNp0G5qW9YjM2uNcKz04BR/Br8asAzjPB2Pq+PyReRICtLCMF1v?=
 =?us-ascii?Q?L9CKDAibQfxZFe6yAq5cHeAT9xczMmJ4E0HYZvCyHf8nMt1zBptTPRU8reJq?=
 =?us-ascii?Q?JR6UVnmVIeYhNgT7srtWGt2CbbxxzbH7ILmmCzC2jDRiovtqsvuD8eqyMMhR?=
 =?us-ascii?Q?gEqcdQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: kJ5YKJqzG7GzHPvRGXuCcQIInxdLLbAGWHS19rJ16tlBgQkXck6jg4JFbfGpvTkO7w6F9o0Cc0a7ZbhErFgUQNFP2INdsgq0riHENZcYl3eJeT4vHjmK/sWBjAfuDFKHMohrkWYJ9ttIElqgUXQfoz9/kGzNYm49obSWL7daFC0Xg2hJU9WbKvfFfw4Uelx651VFXiyqxwWxnwCYAw7fzFMNtPoLoUOU4Xbo/2fZ/57BVCYUiaGlhDKbwGV3c2qiNw53xUJs4S7IDfAQqlhB5p53Gjrm7NUQ4knvHLXRZvDnpypghuc9zAaWGTLORg/xdtKTgUrLEN2ESPDP6icutY42wjVBzGsZktgiG9wg8ua5iCC3CrICQGQKHFk8D3pr5dqQF/hU8spG6aQo/JYuzLGXswBghAVKVz2hw5pVIcPMlyXAi8ikCrKaP1vpuGDM
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2026 20:29:02.1571 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f657db7f-4d36-4e2c-b664-08de6299b3f6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF0000468A.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8901
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

Enable on the other SDMA 6.x ASICs.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
index 35e00ebba0300..6f4704c1b3a10 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
@@ -1380,6 +1380,9 @@ static int sdma_v6_0_sw_init(struct amdgpu_ip_block *ip_block)
 			adev->sdma.supported_reset |= AMDGPU_RESET_TYPE_PER_QUEUE;
 		break;
 	default:
+		if (!amdgpu_sriov_vf(adev) &&
+		    !adev->debug_disable_gpu_ring_reset)
+			adev->sdma.supported_reset |= AMDGPU_RESET_TYPE_PER_QUEUE;
 		break;
 	}
 
-- 
2.52.0

