Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 455FAC3DA60
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Jul 2024 20:40:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8988010E422;
	Wed, 17 Jul 2024 20:40:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="V7mzXVhT";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2076.outbound.protection.outlook.com [40.107.101.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3A0BC10E41C
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Jul 2024 20:40:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ICYXsZ0cI+T6U01rKU8EMgKa1q+XGABmqPOktxi+sekmHlIewjpqslNhW83hIRBkXeosIizIjAx1oHggbW82e728xJVDpP+QKBw5YdBetlFjgO+v96RvGHp8PjbSfI4HqNz6mtIUJ4GynGnnKHlkQUfIeiGmnSFynTQZqBS8rHOiWR87Z9iAdyQs+SlkT6hwZhCtVAJJKl8MNutQkmZXMvKQPT6HfGNZPMgzeeZYGMfaqrU1VlFL/9na/48ooDABAbamIf7+GPRQBysTC8A+9ne3wq0vtSM4WFxKqEOSL3JUyaADPtRZAbQ885fJqJWecxESfoi/jwzREn9PGcdXPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gqbL9W+4oLvgLqvfzphe7YQ+ZGDSXCFtH0ZtyxtfTqc=;
 b=BgNYLCLvpjWk+i1VDbsJlUbxixm02njxZiaDhppSDEhRy8e7Zm5A3nbTXQy7ELrs6f7oHJY+SEKCL8tD97Q+2LWQn1zUqyJBaCcFPcgbxiO98dmPro1d66eUNjq49Lu/Gp9VIXfbE3I5Er06qdbuU4DApS4An8coSp/R5UmgCDM1l02BcPwfBIqUomLr14s7hxB595KnEfcRLECLCAtK62KRee1iDzkX4tgBJAy6Pd9zjYRMbvKcfHe+oL+WPjcDS30Dclp5NzqAYu3sOhYRVxzd7Jk2wsvL1Jq+Ea3wbnsVrOPDFmRZsgqou/4yzNQKNf5zEkkG/F5FMKMwOpmxGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gqbL9W+4oLvgLqvfzphe7YQ+ZGDSXCFtH0ZtyxtfTqc=;
 b=V7mzXVhTwyGCfV0ltR8cGO/1StDOwFeiutgx+uCSjwSgsY1ZDtCwN5DfkpKSaoTvdHc6NhRqozUx2ts2ySKg8pSyd1lVb+DGxlWeOVmEDhzYlx7WC4JpvT0bsUQcI1LGRgFvFC0Sli8L9lWXkpi3/1qR8BFuE0DH8dTfVSXJ5Aw=
Received: from BL0PR03CA0033.namprd03.prod.outlook.com (2603:10b6:208:2d::46)
 by SN7PR12MB7977.namprd12.prod.outlook.com (2603:10b6:806:340::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.28; Wed, 17 Jul
 2024 20:40:32 +0000
Received: from BL6PEPF0001AB55.namprd02.prod.outlook.com
 (2603:10b6:208:2d:cafe::a9) by BL0PR03CA0033.outlook.office365.com
 (2603:10b6:208:2d::46) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29 via Frontend
 Transport; Wed, 17 Jul 2024 20:40:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB55.mail.protection.outlook.com (10.167.241.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.11 via Frontend Transport; Wed, 17 Jul 2024 20:40:31 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 17 Jul
 2024 15:40:30 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 1/6] drm/amdgpu/gfx: add bad opcode interrupt
Date: Wed, 17 Jul 2024 16:40:06 -0400
Message-ID: <20240717204011.15342-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB55:EE_|SN7PR12MB7977:EE_
X-MS-Office365-Filtering-Correlation-Id: e0b24c78-6807-466d-54ac-08dca6a0b367
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?RSURyjrK3hTzoDmot/C+0YfRAckOTPIld0Ym6n045kZv1lRSOwR0c6HjYZqw?=
 =?us-ascii?Q?aGpAYqTX0hzM/SFOCWGAbQtluIgni4qFEecZAtn6yQYIfsLhiss6Xt2fLRdB?=
 =?us-ascii?Q?gFmRY6RCjND4vuKJqkuhVKNmHx1vR5Jw2KcqYwKvTjrZij94DQLFx143JAws?=
 =?us-ascii?Q?m07ZrMqPzw0HhVYYR7BUJxErkc31h5KoIHg0SyGxRWiPXtczpmSHy4G5pRhH?=
 =?us-ascii?Q?z1Wa7xowX2GNS2VRjDsRSJf+RJlJwFjL/YyXWagfx0Sc9h2VbMymWXq+zFHD?=
 =?us-ascii?Q?Q4wBCLbX240XdrQxZOahk/Pdbwyy/XXrpi2B3/mDu4nuz/LEBXJPslR6BlBu?=
 =?us-ascii?Q?00JOsIj/P1wACChrXkb6t5nKn/xmaO7ROrPXLgtgfKVQRP7vuDTurvAqEceZ?=
 =?us-ascii?Q?+16UBo2oNq67+gHpUn+7KssRu2az9IphNuQg4t6MiyJNs4l6jRCg9Izeagm5?=
 =?us-ascii?Q?XhUOOEgCkT+ucUVi8Z+6BsRMNvCCNaWW56DvTD7YQrXug74XqMIaSnIFpins?=
 =?us-ascii?Q?U9/eFI93uQNMYJbNqAPOhIAyraFON0jHPsSkdalMSz+LQXHF6JevR/KWHM5i?=
 =?us-ascii?Q?loHgiExDiqn7LLO1900AhoTPc6DlHiasYOW6giY+RIGm1hjgbohJZFMRkHDR?=
 =?us-ascii?Q?Tz0IosTGcb0OwCEaGLvfwQ5eidhDulxLxzJ+hHXiZgPJu46N5GYjqmh3DkhN?=
 =?us-ascii?Q?82KtJVPgpCvDZ0ckcDYu+GwZly3+M/d9W3AYcLKB4r1T+UzVpcBj7zzQ5Tkp?=
 =?us-ascii?Q?MjYwjhE0dGFud8v4m1oMNLAhti8h+1QRiAvbkwjSMHPWR1iaavrmfnl05yPB?=
 =?us-ascii?Q?TquMJyODiOZ5cq20RwMxv8t6Ev+rIDgz+x3SD2z1Hwu5GH50EQVuBImiLgQ1?=
 =?us-ascii?Q?7nAV1iDovqxg3pK4ehr8iibCBve2m2cbgmPOHF6i0ZQw3/TSWyJAZwdOG8iK?=
 =?us-ascii?Q?3pcGBJyk3U2BxWQnJTFsVFdFCk2sbNJ8HR9LSB43700ZuONG/XxQbZD+2I4/?=
 =?us-ascii?Q?OhkqvdzX3h/16+U8x7Tgljnay4PShtnpAmaG5ymzQyBs98Q7J/4/+VXa+Kql?=
 =?us-ascii?Q?/ADVcX3qyol60RErEmDeCCDIgm0h/z/rsj2Zl6cnQCzKHshLqEpT81FCFDGB?=
 =?us-ascii?Q?7ZbQI54Kn6LrwrG4zEXpcTPT4BG0qIPiALqD1/ACLLMbGlcjacK8uZUVhvB6?=
 =?us-ascii?Q?MAvgR3oN2/Blbx85CtbOt/mVrjtvEfFyeRT3xQhFAH7TU2VqdLmNTlLYIA4m?=
 =?us-ascii?Q?oh77j8kwlHnww4FVG8jCamR6H+Nqy9DwvqKwbhQSX8G+TRZWsRs+H3msGN7u?=
 =?us-ascii?Q?02Xx2QLzy2fo87mC39WJlsG0AenE20ZOTfdiicfmbz4e3GCSzUxqF2vF6kzc?=
 =?us-ascii?Q?8xDy34YXypx6C5CNoKUV0oKzEGpgFeXA6UaH/QtHrvKMjFdXugBik+8zgImu?=
 =?us-ascii?Q?kV6DzrNB5e6H/r6O3Zzhknwgvf6fxKA3?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2024 20:40:31.4014 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e0b24c78-6807-466d-54ac-08dca6a0b367
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB55.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7977
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

Add the irq source for bad opcodes.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
index ddda94e49db4..86d3fa7eef90 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
@@ -391,6 +391,7 @@ struct amdgpu_gfx {
 	struct amdgpu_irq_src		eop_irq;
 	struct amdgpu_irq_src		priv_reg_irq;
 	struct amdgpu_irq_src		priv_inst_irq;
+	struct amdgpu_irq_src		bad_op_irq;
 	struct amdgpu_irq_src		cp_ecc_error_irq;
 	struct amdgpu_irq_src		sq_irq;
 	struct amdgpu_irq_src		rlc_gc_fed_irq;
-- 
2.45.2

