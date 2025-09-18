Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC138CAC5A8
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Sep 2025 08:18:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E9EB910E666;
	Thu, 18 Sep 2025 08:18:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="jMG8XeVe";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011063.outbound.protection.outlook.com
 [40.93.194.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8011C10E666
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Sep 2025 08:18:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j837v7MVYAQ8PlEKej4wCqjlUHTE3sku2c2XUesu7LX4nTmM2l7fGxIPTQ9tfFA1MabOMpaNryZVABOxynXdp2edntF3VfWK0n7LQfydanog5HcpFlE+y0jR5nO5Oyrhc7CjJvy7ecHkUhTSOFtIxNoXrAmGAeePxPXmlGe1fi1+RRQvPHr3pY63jLVElGpEg7HCQ4b09CZ3oOo5cNQIdPyZPG4Pc9N1njp/LkwegBKcuLtRw0kG9YdAXIBZ7y1a3lPOEwGsDN+oZzUQQaKgMU/ROcajXV53T6sTAKx5lYVxq4tbWjq4HpTmxP/GuakCJkx8KI24IRTrKb0qHq/peA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pJd/yfeJhZxX9GuSnPwAzsLc0whdDu+4cyld4kAGwp8=;
 b=c/Ql7K7T5xTviAcX8a2WctiHtlX3z0wA5hwGuUs1dpFMNaa5kL/cP1B5Jdu+nMIGENWJNFNF03pOHUDbgezX8A/CEso+T6sE/geft36NR33ei+UYYRV5kDTT83oKJ1yDchyaCsMsj6Md0YKH/hE85l7P2BFc88JV22F80VaMvBpLcZUQl9Ds9/DATwCM5wTfzOLxTnwoGNQHVGEvdwCoNv6fekbDs9upYPdDdO5G7UwkOY35/Xeb74OZerVMFFM73o8jsn1e3gU9Edx18dyqgdODIHyJVkl+DxHdGse4aHxFGd9/HKs/k0cfFIhePmOHN1b4Fg/lzPSLICrnguCyHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pJd/yfeJhZxX9GuSnPwAzsLc0whdDu+4cyld4kAGwp8=;
 b=jMG8XeVef/Ow3zBrt4HmPorONJMKxmcddyo7N0hTPkOXuRr7m1NsnfLd+ijjjnq47I9x0JTP+geCieZQ+u9aT7JdopQPrRkdAFAyVETDAIv2wd3+IZRGihPgIaJLzLLyhztj7hVs8LtA2ouCzgiLs4fpVbxYO1G7hsn+M95Ze+k=
Received: from MW4PR03CA0250.namprd03.prod.outlook.com (2603:10b6:303:b4::15)
 by DS7PR12MB8083.namprd12.prod.outlook.com (2603:10b6:8:e4::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.13; Thu, 18 Sep
 2025 08:18:45 +0000
Received: from SJ1PEPF00002324.namprd03.prod.outlook.com
 (2603:10b6:303:b4:cafe::a) by MW4PR03CA0250.outlook.office365.com
 (2603:10b6:303:b4::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.13 via Frontend Transport; Thu,
 18 Sep 2025 08:18:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00002324.mail.protection.outlook.com (10.167.242.87) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Thu, 18 Sep 2025 08:18:44 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 18 Sep
 2025 01:18:30 -0700
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>, Prike Liang
 <Prike.Liang@amd.com>
Subject: [PATCH v3 04/10] drm/amdgpu/userq: extend userq state
Date: Thu, 18 Sep 2025 16:18:09 +0800
Message-ID: <20250918081815.2755437-4-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250918081815.2755437-1-Prike.Liang@amd.com>
References: <20250918081815.2755437-1-Prike.Liang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002324:EE_|DS7PR12MB8083:EE_
X-MS-Office365-Filtering-Correlation-Id: 63a76e27-6aed-4577-a492-08ddf68bfc30
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?8PG44i6yOoy83tuMIRPc417KsOLU0Jq22BfDC7L4upM/1Re/K07t2MIjKvZe?=
 =?us-ascii?Q?ofDr8bxwYb6/F+wcVAlv5gqJCtOSW+mjCVTWuJjdjf+MiG4ptXKj86xW7Sel?=
 =?us-ascii?Q?lCjWu0b196PHnoBsjxv+5FAdpq4UXL3I0JyTTBvliqVKV+XwVvAhV7Kt0Qi1?=
 =?us-ascii?Q?/1cFwc/b9UgfDW7oakgOlppbWtMkzqYxZ30Lkl3tdFMrp6mIAewJlBXT2ptb?=
 =?us-ascii?Q?yKdK7mxAiPCiJVjedmA92M7OHm66Y6XcdZG1SuvvKzhpAIWCtzhG/JTfWxaZ?=
 =?us-ascii?Q?tDYHAIrJZR9IquZraA72LhzWxK5/4+Sim7tYRCA64PwOTGTohiV3edvU+dH8?=
 =?us-ascii?Q?IRLDzr62eE69B/dxh8bC8U9J2V/uQ74r3M3BlvSs5tZhL2FcRqINxJnTjmAO?=
 =?us-ascii?Q?zq5mYb2BbD72RQygz0FujVkTk1LlpG8hUZ77raYtXkBoy6khVhs+IEZTMGWV?=
 =?us-ascii?Q?fgijwPcP7bNXDpwEQVg0p0ceVtizwmANCsc+a26lwaP8sUil7fA9Ub5ZX7Mh?=
 =?us-ascii?Q?t9jYRpfKqYI1aDb3iViZEaJKuclmDXSmYcHQQk6UmPUm1V0OXvgK7ZBRf0pa?=
 =?us-ascii?Q?Ye4xdVqzr+k8CmEvC4zwq7aV3o4i+spY3OzvRIGue1BXxzySecMtMH6SIazc?=
 =?us-ascii?Q?oabsZF3bqj7HL+NDHST+LYxn4s1RMvGRxeEh8jguI2NFzz/UIhq8XwqHIg+U?=
 =?us-ascii?Q?2jEGoCmnG6Hfv5ssX1YiEULQsRayY2SyNZXW91IRskYiIg7LobtqUMe+hjZ8?=
 =?us-ascii?Q?nMm4W8NSG5Ij1hgpTbb+3F8Xff+MdzQZN2K1oeSbNBgajB76NFGAGqSL0Tk5?=
 =?us-ascii?Q?ml4YNRD6JiegfVaZQJqEo+4MkSqxBYerkQAhJJNbal8webnxU3p/7/SppxlC?=
 =?us-ascii?Q?vlz79zmqJ1kmRz2DH21MQy2pJ5350AF4bgjsEUAs+JSroHw7wOQRySWiApTJ?=
 =?us-ascii?Q?boJvsOCZNe30bGoY8n4tuzmBeWi7WJp6ZRBWJaJ9phDnIp2l41ugBLYzZS3n?=
 =?us-ascii?Q?lDhmil8rsHIOgIHzCj/5henCRdy1fLtNWqfFPhfm6PvH6A/e9oOT4B18zMRo?=
 =?us-ascii?Q?//XYP+LehBNwLvE4jJZFBHrRK9+htCWTtzfiOWKLjMZQz4TcOAbZwobVWtJz?=
 =?us-ascii?Q?yKu22wpsNhdeOenCXIFnkJAtXZ/rdQVYki/1gAjOrDtv6ZAt2lLIfs7NoRUz?=
 =?us-ascii?Q?o0dRvC7uRVaLGD7+x9cnDRE6Xa4L3bCniXf5RnNzER+R2PpX9y2nLCU+i/i0?=
 =?us-ascii?Q?MyNbVzhDX2bdFzdIfhEFg41SfGUhObPdNdJh310YVrII9kLRN0TlBF3+ERpe?=
 =?us-ascii?Q?P+GVTrws0eCuYXUJXiwOHjbYA8I/eyOLy/OAVa8gXsGUWztftzELCTYqk6qz?=
 =?us-ascii?Q?Yvxz/M+6wiYw9YFAFgy3qqzZ17Ab7tPBWSn3xaHdObF55zZ/YiekLJ507B68?=
 =?us-ascii?Q?CeRVwnbkaM+DBkfBJy/AbAnC4aAmYW9SMjoxgf8SLcd/ozjyh2uQ60SO0oOq?=
 =?us-ascii?Q?15QhBYv89pcE6BqyCDdtIGcTiluHuQKkiD8a?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2025 08:18:44.7071 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 63a76e27-6aed-4577-a492-08ddf68bfc30
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002324.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8083
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

Extend the userq state for identifying the
userq invalid cases.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
index 2260b1fb8a22..33a582200dda 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
@@ -37,6 +37,7 @@ enum amdgpu_userq_state {
 	AMDGPU_USERQ_STATE_MAPPED,
 	AMDGPU_USERQ_STATE_PREEMPTED,
 	AMDGPU_USERQ_STATE_HUNG,
+	AMDGPU_USERQ_STATE_INVALID_VA,
 };
 
 struct amdgpu_mqd_prop;
-- 
2.34.1

