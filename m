Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E6C7C47BE0
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Jan 2026 10:14:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1EC1B10E4CE;
	Tue,  6 Jan 2026 10:14:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="OxGmFXnB";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012042.outbound.protection.outlook.com
 [40.107.200.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A0C3610E4D0
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 Jan 2026 10:14:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WxbrjJZMFtN+qBMgBdQAhONc6RZVf+Y6lX6mGlJlNsuFnasAU9MO7pmsGGE7SEVBbNpUQ/Skc3ffOwQhN4Ml5V7XmzrY5z/clV+MvmtwJ+gPlRJdu3Pkv3qZOPhaEUXezMNRtlQBHfL2NAaGCyzYEYQLomDn4um7fWw0Z2YjnsVni1kWNniFniY+MaHuAtaag8EhXCfam6uCdpFdnZwnbTWpvZ4CkiyM43XDvWNUjuqXPJcTSZhE3/rCURXY3ozBew+iqe9FCL60XNbWxZEeECu1KEEh1e9pYc9nrkhKb9Hwm004H1WO+6o3SVnV3SeyGvKS8wJcBTl7uZsU8gXOPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HbyfLAaxCkBeMzPBId2IwHTlQYG29QKusQ/fjKlCZgw=;
 b=WN6wjeP8kFR1xHgpXa6aqO9QharvyxcV+uPj4S+kEVkZul1VDH2t8b9/H61ayFGvFPF3PF6TP9H/DqJwsSTYXPvo1+djH8R7NQvbdD+pTF7VQ54hd3mlZhLmpzu3RULFsuiSQiHAurJ1nyT6wMjQkBr+09lyYvQjcVBFQR8RS/517hmEcTRnqE6rXvyVVHK1b6Ag7AndMGc1vMp+su3xGivIxbtpAg1NdI5EXrX6RRgdB1OZ/HWaxpmXbJlyHV5wgkDFAx0HEsUl5xIG3VC6nkArq6v37VaQoASmCHI4Rih4daasG0P8t4HLjeXnFjJwFPIC6MAo2l5SM2OiJqYovA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HbyfLAaxCkBeMzPBId2IwHTlQYG29QKusQ/fjKlCZgw=;
 b=OxGmFXnBimbE2DF+eT9Qhln1wgFQtOeKTdOzrQU6t7UDej6yflXowX/8Mdw55eF3Blo/Dt7TuubHluuPrTlo/qb2dtM9caXRi2+n+koh8rIYYu6IJBMgA/9BqlmP0Siri0kUeqGSX3zWYyk9IJbJLsj7AJupfPeQcreJHGuPczU=
Received: from SA1P222CA0053.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:2d0::27)
 by CH2PR12MB4296.namprd12.prod.outlook.com (2603:10b6:610:af::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Tue, 6 Jan
 2026 10:14:13 +0000
Received: from SA2PEPF00003AE7.namprd02.prod.outlook.com
 (2603:10b6:806:2d0:cafe::28) by SA1P222CA0053.outlook.office365.com
 (2603:10b6:806:2d0::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.2 via Frontend Transport; Tue, 6
 Jan 2026 10:14:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF00003AE7.mail.protection.outlook.com (10.167.248.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9499.1 via Frontend Transport; Tue, 6 Jan 2026 10:14:13 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 6 Jan
 2026 04:14:10 -0600
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <Asad.Kamal@amd.com>, <kevinyang.wang@amd.com>
Subject: [PATCH v2 18/21] drm/amd/pm: Drop unused ppt callback from SMUv14
Date: Tue, 6 Jan 2026 15:42:38 +0530
Message-ID: <20260106101317.3856153-19-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260106101317.3856153-1-lijo.lazar@amd.com>
References: <20260106101317.3856153-1-lijo.lazar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE7:EE_|CH2PR12MB4296:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d8e00af-4925-4ce6-e57b-08de4d0c5730
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?gN79inTxKI3EW7K8z3tN5dmG0gz+w16VsQ9tKkDFVRUDfWuYB8HZHnYICzix?=
 =?us-ascii?Q?2uUQhAk4N7gFJvtEJoRlOMWrBuaQQQvuItQFENpt3AD/i5UdZLWUC6rKHplW?=
 =?us-ascii?Q?Ej/EwambmBp0hsAtLLaVH9zEcBHfrbuinZFwZi7LVTOhxDuc6Z9hTI+QTYaL?=
 =?us-ascii?Q?U50mp6gWtbUpXM8Wf6uVQBdZ4343wXqlFq+XyPcJ/wRCsn0vaOo3z4M2A1kn?=
 =?us-ascii?Q?EjNewrqJZX/Yrcx5FSHdNOmd94hswHRzWU+8/mFx6dpajaabsrSDgEE3nfA8?=
 =?us-ascii?Q?BnWM1QYsyPRqazVvdMDwsfNgv/VJ7Fli6Vfn/yPu+vk/cuUgPhCYamg2KnQ0?=
 =?us-ascii?Q?p9+m1tkiIH3qPIUBcJiY9hmVqtIvLaHUpnpp/D7oCAWMKndzZ/rzUKYDLmtj?=
 =?us-ascii?Q?it5NpHbg/lep8LBDXo0oRc/Nb8W7POR6GCjE/vwrWsmvORk0C/iaxOCkmCPF?=
 =?us-ascii?Q?gqmU+Zf8ovwnJZAZAydAbrtmdxVy8MOSD9KIOvHFycbo6VQ4mluVnUr7+l1o?=
 =?us-ascii?Q?1L4Ltg90YrU7bvgKuOrdL5oeRWEGHEcPZPpT0qY0b21aXq+YLgZBGxzz1M1p?=
 =?us-ascii?Q?cAsuhqVz8HGh3U+QYpXcPzMGaNxgUglcKjnMPXxag8eqABwW/wpHuyCCp9Aa?=
 =?us-ascii?Q?RttxueL2otOjFbN9X+K7OaCW+BafsFkVq/reGimq8nX1M+W6vqAuH5N19MgS?=
 =?us-ascii?Q?JP8alqtNNZQOWtp7Vq7BGM8AdZAiM24r+yz+k/YDw5ZD+k3pPIJP8T+2DFQQ?=
 =?us-ascii?Q?mpSClasweKJTEwF+cABK2p5YH7pO1cJuM4GLqXO9IlOl7uhFnXkxGMZFdTzh?=
 =?us-ascii?Q?ACTVSViY7lyclyrhDXW22RBcVvyrMJ3BhwsJafbtoa1ID1BODo5fHD6tQrU9?=
 =?us-ascii?Q?PFtVv7v8DZl0KW2DBJ1My7Y+UzJSh9DuopUgl+Qv3HxEi2bZYREjjQuz2xQU?=
 =?us-ascii?Q?4pZfnDHMR6CZ6UCVL8kXafEGN1DuTfBNv8OAhUSH/Z6ZXLe03xQvwyeJ8Zp1?=
 =?us-ascii?Q?PSeXgBpOZTYSWJwkderiJaeqp8tinlwoXyJiiUZfWDnW7PRsP9ery26xv2wT?=
 =?us-ascii?Q?6NPXgqX39ifpWqj+0xwa6FCZm/gtUP0WXwm1W3h8a3Kpu6oVKbJyEGmlNXXs?=
 =?us-ascii?Q?QPChwsbNxHEqJt758ySeUt1Q2pjwUKeCq41YyIHPV7TqqJ+u9F+OnLUqHbqB?=
 =?us-ascii?Q?gGkTaQL0fSvRLeoqPosrIrkX95IfuqspxZ5xL6cyRD2ZW8iANHbkV2hg30i3?=
 =?us-ascii?Q?WI42Km7B0OwM/m5ecbQoQ6BzWDBY1/z9S1N/xBIH0pY3+WXUApcnNuiEVgcn?=
 =?us-ascii?Q?uOve6OGmITR4+tUMbbOi14Kon34zuc2IqaAoNwtg5vRWiMu+1RV9WI6OoWE5?=
 =?us-ascii?Q?iBQ/qqWCYtL75/pDR+d2+j4rdK92Ly8ulI8O5iYYmDRt6XO8+gJx+/2ZrkQh?=
 =?us-ascii?Q?BRj83w6Nr+32FlglD1QIzZm+x0ZzHNme3X1WrTA4wxYv2BsPqEKi4Vf3GoIr?=
 =?us-ascii?Q?RWCuuhnak/maCzvNod4xVEGxC09n6KCeWmko20kkdsWVmUZjsfpE4/lJX9Tk?=
 =?us-ascii?Q?iW73/16o3FO7nmdRcbA=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2026 10:14:13.0216 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d8e00af-4925-4ce6-e57b-08de4d0c5730
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003AE7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4296
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

SMU message related ppt callbacks are not used. Drop from SMUv14.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c
index 0a509fec2180..a4e376e8328c 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c
@@ -1701,8 +1701,6 @@ static const struct pptable_funcs smu_v14_0_0_ppt_funcs = {
 	.fini_smc_tables = smu_v14_0_0_fini_smc_tables,
 	.get_vbios_bootup_values = smu_v14_0_get_vbios_bootup_values,
 	.system_features_control = smu_v14_0_0_system_features_control,
-	.send_smc_msg_with_param = smu_cmn_send_smc_msg_with_param,
-	.send_smc_msg = smu_cmn_send_smc_msg,
 	.dpm_set_vcn_enable = smu_v14_0_set_vcn_enable,
 	.dpm_set_jpeg_enable = smu_v14_0_set_jpeg_enable,
 	.set_default_dpm_table = smu_v14_0_set_default_dpm_tables,
-- 
2.49.0

