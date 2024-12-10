Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4BC4E77182
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Dec 2024 22:54:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6A39210E9CD;
	Tue, 10 Dec 2024 22:54:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="J2DvPex8";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2071.outbound.protection.outlook.com [40.107.243.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E9FBE10E9E5
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Dec 2024 22:54:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HpHc0rUZcoYlAE1iBWFb59zwH4NKgVoNTIuTbCg2D/33jEvUdR4aZQ9NgTHkM91WFrT1+ekIhtAWiaFzcGT9Ap0p9XgEtzf/g9zM4Ty6gazUQahsJKVXYyo92Awavo3HrawhE0RAva1mfFdp8EZq/mvSqMtdXeex0hf8rlUCGRZnCg/i7NuwwiO4tFtEjhiPzZei3+9WPTpAMMbf95+TNMgwe7a1tbItx3B8TLpEaTVx6q3c4qJkdEShL/swPfLbaXI3pTByyyaKDRGCibflg02HzjwFyN9PQgH15ULKgCmhcLcfcd1Hh6i79qJvNAvHrYj/ifXD+sDAhwBE9pl4Xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U9cSSkRrXc0zD7B1eh2uX2ewnFEO69GnWcOww9geah4=;
 b=XDsIY+gA2EF4qWQpEWg3zpYGz7qZ9KfiL8PgWppdOjh4+Un9CbSxW1QQmmuI0pnI6EibhlxB7yI6k7w26iutz5wqyEyRg35/TyG4C7U5AICJlXYv5x9yxo5E8P4wozAc0HlWzq1bT5CmC5AySmDyF7AEKPi0s5DWhQkBZRMkofTDjOfvsxtFrxCPKqdAFImOVU5OKnnyy+iC9Lp1WBHhrEyGSKg209MjODPJu59ZqxuwwFoDMpkWMmWsvqooj49q5sFICnXlT1vrxuaPzM2yRN4nHlAzRyXAMa1uAr/Zi0m5/waEt6nzB60GdubjnY4IkxqRZWCBJ+hcepjumI1mrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U9cSSkRrXc0zD7B1eh2uX2ewnFEO69GnWcOww9geah4=;
 b=J2DvPex8n9+GXQEElkhE0W2oxJNma0xOOlPBzt9HnQvBSPXSi842UYPzTQYM0wG48g9Vc2nWpDqiBFDRMCaD9eBpLh4t9dfUuv4shYAaWbjEN2piyryBrZpq/i0+EEm0ZwxZMhYRnk0K98Ls3y+73LuhE/WPsHw2DBOor9CXXDs=
Received: from MN2PR01CA0003.prod.exchangelabs.com (2603:10b6:208:10c::16) by
 PH7PR12MB6588.namprd12.prod.outlook.com (2603:10b6:510:210::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.12; Tue, 10 Dec
 2024 22:54:10 +0000
Received: from BN2PEPF000055E1.namprd21.prod.outlook.com
 (2603:10b6:208:10c:cafe::56) by MN2PR01CA0003.outlook.office365.com
 (2603:10b6:208:10c::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.13 via Frontend Transport; Tue,
 10 Dec 2024 22:54:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000055E1.mail.protection.outlook.com (10.167.245.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8272.0 via Frontend Transport; Tue, 10 Dec 2024 22:54:09 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 10 Dec
 2024 16:54:04 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 22/48] drm/amdgpu/vcn: add new per instance callback for
 powergating
Date: Tue, 10 Dec 2024 17:53:11 -0500
Message-ID: <20241210225337.75394-23-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241210225337.75394-1-alexander.deucher@amd.com>
References: <20241210225337.75394-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000055E1:EE_|PH7PR12MB6588:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e66c409-29ae-4ecc-7b11-08dd196d8f0f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?f6BxXmV9xKerZRzxbqNP2C9F1i09HwBU82cQQxbyt8zBh0Hjzuf3GBLBJb/8?=
 =?us-ascii?Q?v5tCkMHfNA6ElVF6G0DIMR6xv+7szgHfZ8RvLvc8V21grbETJt8aBocvA/hn?=
 =?us-ascii?Q?ZSmtYjJdn/wKyo9WXyUFmhcwFVHjFG1ULA1Ul8fm41v10A+qSQ3C818ILXGI?=
 =?us-ascii?Q?7PjS5jELC62ZUs77aHJLBaCOf2VabQvEpPFgPBVraZ/zvf8k+rCQsIUl7Iah?=
 =?us-ascii?Q?twgfvYjCIWmCMiOsa2G0F1Btvd/yzhU69bY0/XNjltP6QzE0aGCaRb845pjb?=
 =?us-ascii?Q?NDybQQ6GfiZeYjKU8RstVeGnga5fp034yofwW0hba63zE2fEqZz7osf0dniW?=
 =?us-ascii?Q?I+A38XQODiikkPQ9iHbRhY4HQPeK5T2V69+QT74Sj5ecJeeRcCb3YSPmJQKM?=
 =?us-ascii?Q?cNdRE5YymXXTHIOih6OoBJOramy7GZ/7aPlIN/eCN461jVbLWhTs8sQUzwv9?=
 =?us-ascii?Q?EK1fmEePC9TO9pq3ZvA9ldtsn1Vbxe6CsB6UY4INQDzClTE3Q7S6CzmOf21m?=
 =?us-ascii?Q?FOzpKtD45AUvPdbC2lSDKpqpExEcAAdtgIUP1MfzVNJ3zdCA5foRifrP8+Om?=
 =?us-ascii?Q?AArNuqPxxYZEiQomebH1aRwDMQ97wCHJ9dmeiONkEJj4K6qak877eIKtZ+8K?=
 =?us-ascii?Q?9PrEx+TZzTA/+CVEC8Wvrc82aWvdm+Enq9JDPwtnmoUbEwj+JZTcRfdwP+Gv?=
 =?us-ascii?Q?QzJ8g1rZPiykb1aLR2TCpiqXFrwZ/vPjf6VjD3ncH7use8YCvoETkArV5+82?=
 =?us-ascii?Q?iypYKX38l6z5g8dzKAlwMI2eYIIICO6CAHDaIb3XMrmnl1JTOcp5cWVSbMj2?=
 =?us-ascii?Q?KM+QsG/gWYrNzN86w2rsPAbxxUmOHkMm51A24YD5pkdMtFmlps42aws+JFcv?=
 =?us-ascii?Q?t9HxgzoA29n8d8VX9yXhyAGaIqOTNod0nzeZDy6az82V2MmrchEuA0klulsy?=
 =?us-ascii?Q?VfWvZ/G/oqU6W3BVu0Ag4Vy/DuGudh2PwT0587eHm2uNIwsy9K0ZpTgFvrup?=
 =?us-ascii?Q?/+yrLNUZzqK4Qc9CeZd/ocK9mSnqKwNoPWb2VPPIAdwqQN+YT2cBblOW2IbU?=
 =?us-ascii?Q?hP64XHXFstyv8li2mhWLPtybXUdtxpfpsdHOvBSWdit/lS+jtCGdgSw92toz?=
 =?us-ascii?Q?ONF8lgAO5p6zwh57D3QJN6RXduiHtB3+NG4v8qZ2UXkT53R0H4lvqLA66ej1?=
 =?us-ascii?Q?hhmmGxkqfOs5WvtWYO6VA/WqjkDcs/LuNRDeOavf5vWYXZs3NXYgsSW+OemJ?=
 =?us-ascii?Q?hWNPvPgRLXeQh9sjtbMtHkth0yEjTbZrd9kOUNbCKpChzJ78nCmPPME94hO+?=
 =?us-ascii?Q?JKQgOgUMKZNlJ68VFWTYlTmF/HtEoFscPGK2e7Z5YISNORhB9PHDzUSSdCDM?=
 =?us-ascii?Q?qBwghUkObL0CqjwpOxwBDa43GR42/D/DxeP0n9qlPQ23emRvuQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2024 22:54:09.8139 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e66c409-29ae-4ecc-7b11-08dd196d8f0f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000055E1.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6588
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

This is per instance so add a new function pointer for it.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
index fc35895be5c4a..d7467abf9cd5e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
@@ -323,6 +323,8 @@ struct amdgpu_vcn_inst {
 	struct mutex		vcn1_jpeg1_workaround;
 	int (*pause_dpg_mode)(struct amdgpu_vcn_inst *vinst,
 			      struct dpg_pause_state *new_state);
+	int (*set_pg_state)(struct amdgpu_vcn_inst *vinst,
+			    enum amd_powergating_state state);
 	bool using_unified_queue;
 };
 
-- 
2.47.1

