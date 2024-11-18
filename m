Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E008D43FE6
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Nov 2024 08:04:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4E8E710E336;
	Mon, 18 Nov 2024 08:04:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="MBEHZ0dZ";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2089.outbound.protection.outlook.com [40.107.94.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F22CD10E336
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 Nov 2024 08:04:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UkhK7ofhkJ3zk5FHNRrA4lW/9X2aoeHxPB7c0oh1MZKgc/GwNe0wB4Y39yEPyRTrycNd7pglk4r9NA3YtUfhxHJqzGjoiG3VtkbONPe+vFxHhNczT8vAzJcIi5fNr10x/Leyo/Y/2fUB0b0K7Zc71zMPNwCggYaUS/g1ItVZ4cYQvx/9jEPhbMPg9vhu9F9hURAXG+O/fMowzmCXj4mkjADaruHKXxZV+QqXfaXe8cJSwle4kgskXNyQxo0svVsNUG0FEHb0x4jrX38CZS2MDIPaxqawO3ImiJFo0NHekaUg8zTZxK8SDaTYSO2GVHyQBu3L8oUh+W3LbG+IY3DhCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RQVhix89JsN00PsZ2HWZf5W2QTWxhC8XNo6NidrWbmU=;
 b=kwYTE7ysKSZu9Ou+gaDMJrQU2/+CGds37py8iaTWvyyCZxerh4R/H86oP53zDmHIkym5aw5HPXUnKUTh4obVqqVa3Bq5bZsI7s+/UL6ci0oZJH+gKrxBN9koSUw+yisB77h7hM2b5ccOjTKuDsX1Q+i/Vd/DLGxL9Jsms4S1Ra8zrTv8Xap2CYuiLN7ilYlWBxVnV7/ehIyhlghtM3p63obHxwv9uvtl8ZQH8ZaoN8Th/7KL2onw6JyVvqQP2O7gzqSfUpWozT490jciqFcmmbFGgX+BqF2MMwQQsqdW3TPvU9ZfGEsqUwzjeHURZdaLkJgwxHQqehgSUFkPX4zhzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 165.204.84.12) smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=fail (p=quarantine sp=quarantine pct=100)
 action=quarantine header.from=amd.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RQVhix89JsN00PsZ2HWZf5W2QTWxhC8XNo6NidrWbmU=;
 b=MBEHZ0dZaDLbJ47IDT0MUYVXRfTpLl4nXpJcS/fsSf5V4Sgqgp7JY+8U5a4Dr4QwPWpwdAyHrwVXPidbCcLVN32PsuSxr5qe4Ki+HBJ2O471TK/d/xhFG8/cDH4hCX+fuFu2tvH9g3tKFbs474ICWrhi8nquL88beQ1Rau0oeSM=
Received: from CH5PR04CA0022.namprd04.prod.outlook.com (2603:10b6:610:1f4::19)
 by SA1PR12MB8741.namprd12.prod.outlook.com (2603:10b6:806:378::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.22; Mon, 18 Nov
 2024 08:03:59 +0000
Received: from CH1PEPF0000AD83.namprd04.prod.outlook.com
 (2603:10b6:610:1f4:cafe::12) by CH5PR04CA0022.outlook.office365.com
 (2603:10b6:610:1f4::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.23 via Frontend
 Transport; Mon, 18 Nov 2024 08:03:59 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 165.204.84.12) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 165.204.84.12 as permitted sender)
Received: from SATLEXMB04.amd.com (165.204.84.12) by
 CH1PEPF0000AD83.mail.protection.outlook.com (10.167.244.85) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.14 via Frontend Transport; Mon, 18 Nov 2024 08:03:59 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 18 Nov
 2024 02:01:17 -0600
Received: from kenneth-mlse-vm.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via
 Frontend Transport; Mon, 18 Nov 2024 02:01:16 -0600
From: Kenneth Feng <kenneth.feng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <kevinyang.wang@amd.com>, Kenneth Feng <kenneth.feng@amd.com>
Subject: [PATCH] drm/amd/pm: disable pcie speed switching on Intel platform
 for smu v14.0.2/3
Date: Mon, 18 Nov 2024 16:01:14 +0800
Message-ID: <20241118080114.428845-1-kenneth.feng@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: kenneth.feng@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD83:EE_|SA1PR12MB8741:EE_
X-MS-Office365-Filtering-Correlation-Id: be2b6d24-5c42-44ef-6553-08dd07a78ef3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?2mXP30p6jTP0g0/ISHPgmNygmNGZLZ9fnjFH9PPM3Rmnv4o94+jsQ45q2Dxa?=
 =?us-ascii?Q?Lu8RRaIUSV/v+P8DpjiuKLjXZhJvLa2czMYxrQmzPnj3F89rHL72tXCvVYjt?=
 =?us-ascii?Q?lRPNofm4jOZWBdCH9f9K9UgA30vUzE81duP8LzyIXiZUQssS+3RsARXJLAQM?=
 =?us-ascii?Q?ZM9SxwTEDXmxl6l59SCz2KwCsF7MFQ7UnOQ/GUCeVaVHi7nVyG6RqyBsbpPP?=
 =?us-ascii?Q?Y0XcZ+D7plvn8VzVy2S1L/NUIjJL80pRjbffXJ1DlI+xJuODuUx+dP9sIDUf?=
 =?us-ascii?Q?fVnTlil473OmWUuBsdh7c9jlISpnoYpT+7bxdY0xlG37roO48+TFRLSIoN9w?=
 =?us-ascii?Q?uTf9+hMsHiiDpt2JuIusdCuD9XwKJE8cXslBHMyqBosGeF4XSm9KfULuaVp1?=
 =?us-ascii?Q?7FH9LXom7Iu548AsAtyqSJvGG8RX5RgFLXMAaIGF1DZ5FMxqibRENDCf2uoZ?=
 =?us-ascii?Q?/Radie+VqmuoZg1yCq5bJmKLf3WOu3i0+yfSY0/fciauKFLTzny2o1LBKgb6?=
 =?us-ascii?Q?crDjp74EQ2dOxVBAPy6ErgQwNmaqM/ZI4N3t3yp5ryfSMaW7zNF5FqlJpj8c?=
 =?us-ascii?Q?y9kREv256H6ahFiDY5heq/ndxpI49oUfzvMskK3LEHQHLdTIp9Wex80dwDTU?=
 =?us-ascii?Q?RSZks4E5TK7AsTYdTAXTLyUfRszDrNZwIz3PnXnBu66/UsjWrZnQDfw4c5Ux?=
 =?us-ascii?Q?TU648vkmbOI6nzm45qQhcJEAe/pTzoOPuZKV5xPmExPQvYOUADZ/CituaDPo?=
 =?us-ascii?Q?lxhIqNwWAmDKhBZh9aJ5srRB3fN3OU7SG2Im7vCYQmZOnFK101JuV9ZSZCLQ?=
 =?us-ascii?Q?8bkTTvuauy48cdXjAssOd1EI2NBikk6k3v5E6hlTaa9irybndgPpxnmm5uHj?=
 =?us-ascii?Q?ohHlW27oz/HFKqqxCmqoELCXtrGmHUlWQ+aPT3drOa47xQ3KeWH4FWoukdgb?=
 =?us-ascii?Q?uN8Pzpx4O7jw6+tbrsu6mh/WtaDFdR85rFHOXx4wF7niqKhDGvccYKy1MUN9?=
 =?us-ascii?Q?+qve5PgjRyUGuJKnNNc6iQ9/t71m++HXN2OvcEfBpobNriihauCRtriDQT3G?=
 =?us-ascii?Q?6JjwO8VsAq5Jvw3wrNqhLQO6xuCG5llNwQHFVOz89dEjcRyKU92I2bD3MyAc?=
 =?us-ascii?Q?mxSsHnIAhtYXcrJ/HMlmSeFe0CJ5ctpr7NwAiNAnxP1jULvZMj9HTscNqcjC?=
 =?us-ascii?Q?LFKml0wfo7Kz/2tpyhF93/A70jjj3yVyLDuv3g7s7Uxzqmd1dLge6RthCvde?=
 =?us-ascii?Q?2ygn2muQvE4ci6KHhGBptVBGs9unksy6r+Yg+RIgg6SFR/GgLpsfivceLG1P?=
 =?us-ascii?Q?UZg8q6Jz88V1BSKhkQ8m7S261tiWe7DVlEtCgXBVaM+2xuq+VoJrNNfnoXfE?=
 =?us-ascii?Q?WcOISZiXd4Oj9pwAEjvHUVG3m2dadmxOXR2fjZ3OJfi4Sgy0iQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.12; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:atlvpn-bp.amd.com; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2024 08:03:59.4946 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: be2b6d24-5c42-44ef-6553-08dd07a78ef3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.12];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD83.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8741
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

disable pcie speed switching on Intel platform for smu v14.0.2/3
based on Intel's requirement.

Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
index 59b369eff30f..337d3312ef30 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
@@ -1472,6 +1472,14 @@ static int smu_v14_0_2_update_pcie_parameters(struct smu_context *smu,
 		if (pcie_table->pcie_lane[i] > pcie_width_cap)
 			pcie_table->pcie_lane[i] = pcie_width_cap;
 
+		if (i < pcie_table->num_of_link_levels - 1 &&
+			!(smu->adev->pm.pp_feature & PP_PCIE_DPM_MASK)) {
+			if (pcie_table->pcie_gen[i] < pcie_gen_cap)
+				pcie_table->pcie_gen[i] = pcie_gen_cap;
+			if (pcie_table->pcie_lane[i] < pcie_width_cap)
+				pcie_table->pcie_lane[i] = pcie_width_cap;
+		}
+
 		smu_pcie_arg = i << 16;
 		smu_pcie_arg |= pcie_table->pcie_gen[i] << 8;
 		smu_pcie_arg |= pcie_table->pcie_lane[i];
-- 
2.34.1

