Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE1AFC369D9
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Apr 2025 06:29:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 31A3D10E1D4;
	Mon, 28 Apr 2025 06:29:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="YaucwEL0";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2080.outbound.protection.outlook.com [40.107.96.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C740B10E1D4
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Apr 2025 06:29:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bHKGMkIS1Tlv2a7RzwK6YcfrVBaJNSaPrbLiMT+bmqOecaQd/k5aqZ/YnaOoPPVmpd7zr+x05GkiQeQDLbZ3Z6iMrReP5wnnKE9IVyPnVLUp2Z3hW8pKqmsYnj6GMrI4002PYp2trbEA+8UIvLAmTS43Rw5Mc4Tfi0YJ5OwVNoO64oQj5yxzLa0CimLzcMzu0NXfyCSaNzIAgU3J2+Yze6wzlJBWuW/815BCZlwjpn8KRm0Lh5rhHtBRQ6G3+4Q01KVk8LizRsisHEqbGMcnSKN3jAgET8hf7fvVwDlzh2NkqEGA7DtYz3EmUXvA15dGM3XzWhqZbdVsQ/anL93svA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rxVM0fP17NtclBMeqp9X/u9SnJNwm29Mx7vip5KOiAU=;
 b=wB0vuhgDjYSDjbD8DJEcIdlREmNaABhHf0sTDuciGqWm19AEQu3Cz6nsuVfIWy2eka8MknTTENCNEfoiQZ77Go+fe9eof3DtjQn2Bw27GsvCDSqZtZCqKjX+8XVtP1NTcHEMIUvfUD41hPX3sW4CYDW82mklZvUAyxc7nOOoWRK2FpXROvvE/Dl565vJE+HR4PZ1dal7kdzO+N5S7z8QVEWf7Vt17HkDZXjt8PswaMSBvA7SonzX2jNrUTYKn/tqwij0ch0r6SePo5sDsw6w9zbAlSUygA671T88wCj8bWry0oYQIlwtKxAOD2IWsIDgFOEEpx84Glmpu5woiIhwAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rxVM0fP17NtclBMeqp9X/u9SnJNwm29Mx7vip5KOiAU=;
 b=YaucwEL0hK+0eXU2B1o4+1vJwdUZWGnRnBeK1An6AG3LLbjWrnenWNO53vnQC9RbQc8S3JLrWQFsn79zEip6Z/iO3yvB9owPD2RItTv47+Z8QMNgVAFjoSOq2El9csfzLqyIxY820Cxw8QE15BERha+BkGRbiMwTY6efBWvEQqM=
Received: from DS7PR05CA0096.namprd05.prod.outlook.com (2603:10b6:8:56::28) by
 CH2PR12MB4038.namprd12.prod.outlook.com (2603:10b6:610:7b::19) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8678.29; Mon, 28 Apr 2025 06:29:10 +0000
Received: from DS1PEPF0001708F.namprd03.prod.outlook.com
 (2603:10b6:8:56:cafe::99) by DS7PR05CA0096.outlook.office365.com
 (2603:10b6:8:56::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.31 via Frontend Transport; Mon,
 28 Apr 2025 06:29:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0001708F.mail.protection.outlook.com (10.167.17.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8678.33 via Frontend Transport; Mon, 28 Apr 2025 06:29:09 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 28 Apr
 2025 01:29:06 -0500
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>, Prike Liang
 <Prike.Liang@amd.com>
Subject: [PATCH 2/2] drm/amdgpu: log the user queue object PRT mapping
Date: Mon, 28 Apr 2025 14:28:53 +0800
Message-ID: <20250428062853.4057900-2-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250428062853.4057900-1-Prike.Liang@amd.com>
References: <20250428062853.4057900-1-Prike.Liang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001708F:EE_|CH2PR12MB4038:EE_
X-MS-Office365-Filtering-Correlation-Id: 9076963d-974a-4897-125a-08dd861dfc33
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?cr/TOD45+Opl8xZnHaj1H2SdU/7Z2vgF9SgeIzqE9KuRz4eWd0eT8oXe4GTY?=
 =?us-ascii?Q?Tw1Aw2S4OuwpBAjx+PonBQ16f5DuHkfQPJr9FZMbc8ZIscFZH3pfC7iXjr7v?=
 =?us-ascii?Q?DOOS9EArjWZf2Xff6SluqYejC3llg8/e6Dmto1kWosl28ZPQnGDKzIKQ3lyF?=
 =?us-ascii?Q?rejEp9xYob3drQp3N0jazJkzDAD48RjkpZncQ0L94UnN085sa33GByljMDmY?=
 =?us-ascii?Q?iGpOyuJ1ooozWrC2m5TdFy86VzG2iofMs49A6a/rPjsE6r63zzPWMbnBMawO?=
 =?us-ascii?Q?yB4XwYHHQ5ztpGOym/wehYmEBcPcSBvTh+KwzK4qdyD0eaFJRQtyz6HeW1Zl?=
 =?us-ascii?Q?MRuW8gNlaRtMPS+vXrjHwXDAGwamuIiaiZkkmvbzTiEBpLvBdCiXdSN9jh1v?=
 =?us-ascii?Q?Msiinux5k2D15F92Ohy6QJm1kC0O6PNur10/hnHe2fhIJJh+PM9ybPTJoyU9?=
 =?us-ascii?Q?fzfcg63EID4OeBvzE6lEkTiDnSzAYQWf1BhF0ZZihApnqYDmr/t3arqUk6Ky?=
 =?us-ascii?Q?rxwvcvby4bct2dP7VmIEkCdfL1lhYkL5wYA9cV66TzF953SKOxckjNM4Hcba?=
 =?us-ascii?Q?f4ypwRqtr5f7lG5om2R8QWpDcPsnPhkAt9ayETlR3bLCsBWuX0Li1QjrWYiW?=
 =?us-ascii?Q?jn2Elh1OaHZwcR+ZWtjIvc3MWGoRl7572UviIhpGcCSYQOXbLVj5qxeplu5r?=
 =?us-ascii?Q?uD0AziFw3thcT2CZgzdmfymTL7UXmHVwD/NvqN/YgyiZqFDmi1tVTiksj63L?=
 =?us-ascii?Q?eg/KddVBYd0k7dHu9aoDongh6OjRsva8kWC0zrb3sFHYVX9idUSO88RECto7?=
 =?us-ascii?Q?1uOQK3njIAhtHjMhhICoQ39Y4zbjmvz+L6ANJhKQPSIr7zw+DJBaracm5hm5?=
 =?us-ascii?Q?bU9qZMZcuYb1AdLJJy6Y+bhdqOtRpeSu+v/sXu4Qn7hOQRCtd8n3pzakT4Ko?=
 =?us-ascii?Q?xX6Wf6rURWpZrE6JaZzxbMyj9IQs2ebhcBxy8K/TAbbRePG6ErdxiVS2Be9x?=
 =?us-ascii?Q?PL0Rowo6KpfGTI+DJDgnOQ4mVgz1XHkihdrZCOHqLc223eyMuXqbSBMk9s+T?=
 =?us-ascii?Q?ZLy6ECSM1Wf3xHNtHZ1Xj4MoIEdyF+Ftb5/k+vKpFaHnUAgpT3oeQrWcXyr5?=
 =?us-ascii?Q?qZ3aQdIwdlDRdTquCgivpeKs25jzSLf8en4MxXyDX4sZxAiOFenw20RuiSUR?=
 =?us-ascii?Q?ad1/scOm4F8bMCVuAj62hgwyG4Ewvg/YfjRmCIBO3wy5s2RREcP5ht1h1hG5?=
 =?us-ascii?Q?qCE9KAeJ1pH65sIECWW6VSVuRMHan8UiNZiUaSkkfBpDRgBU7Umq+tjpkm9U?=
 =?us-ascii?Q?sEcQ6Oh7tbZ9aHdWDlPNT+64Og4EbjX2PhZRU8wV5geuLGrNENclhIWMDTtl?=
 =?us-ascii?Q?avbnveAUbjD2J8Aq+029Id1RQqHJCrUXf2JnHZJw28roAOk3NPBVGiR22B+z?=
 =?us-ascii?Q?tR4RKKeug8L0bOWZiEDgZZXBD/0M4ur2ULgGSqGfneG45BcvQfqhEOyhE5oi?=
 =?us-ascii?Q?5cYZDAoGuO9WUxvLyeunsqBlqJjo6JhOTPQs?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2025 06:29:09.9033 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9076963d-974a-4897-125a-08dd861dfc33
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0001708F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4038
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

This patch will log the user queue buffer PRT mapping,
and this will help on checking the user queue PRT functional
status.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
index 30022123b0bf..7992a97f8745 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
@@ -903,6 +903,10 @@ int amdgpu_vm_ptes_update(struct amdgpu_vm_update_params *params,
 						    upd_flags,
 						    vm->task_info ? vm->task_info->tgid : 0,
 						    vm->immediate.fence_context);
+			if (upd_flags | AMDGPU_PTE_PRT_FLAG(adev)) {
+				if (params->vm->is_userq_context)
+					dev_dbg_ratelimited(adev->dev, "The kgd user queue PRT map is functional\n");
+			}
 			amdgpu_vm_pte_update_flags(params, to_amdgpu_bo_vm(pt),
 						   cursor.level, pe_start, dst,
 						   nptes, incr, upd_flags);
-- 
2.34.1

