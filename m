Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D0E3C04FF8
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Apr 2024 08:27:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 053781131F1;
	Tue, 23 Apr 2024 08:27:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="wh7mU7g+";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2040.outbound.protection.outlook.com [40.107.237.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0F6E91131EB
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Apr 2024 08:27:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jDWvyaCImelqJ4FJsu3DCjde6uaTQmil+ouaWevj9m36ieEEtEPHueUrZbjfl/goLhvF7sEKD3Nw4EvZCX2CtoBZjy4fpOBL0sqlPM5/vdY7qFK/eIkQ6jV8/ftmylFTWLWBi5s044+gx0v8iacdFjAsuzVeV+zb2RrTEzP/aQ7PJgzrHqra5qhFQTKwWyRnRqsQABnlrVeQlkHuIJwCeCOBczW30cjnrUyH8nuII3QZ2MoP6DrpXwWC9nf87YRpz845JprRvdrtCYG0y1ZfW2aTHI3fPxPF6+K3aRWv8hlD0djIUnqBKjdmCXlht5DlFv7bDHShzF5+Vb66xZM0SQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n55WNq5byuDsNbEVb0owIq93ySr467xkVnuJZH7sIoE=;
 b=Jxb+2/CpY6/Z3Yn+w7Pm3A/aRQN3PFQM3PXlRaom/3L3U27Bmr0wtPD8VeIb5SW84qpaGKblEyt65Ew1oRSoW2ZGiBbDnVYXL2xM7hhGtEV/+VG1f/Fyrx3UG18iA90Hza6xy/fvbjii7sCC46sXIUx0JaxGxQnHAEqWou+RbRmtHH6IYP5gqOZP23OoyzEX09BgrCgBMysod41lta0OqOhsMp6LcubH5YpeHH23TIumkvyyqAq6loVNbp0l2lX01VV/SOT4W6DDnLeyAg+ePrqBBam7UM5QxHZvOAVQL9hEqg5zLvF378wyXd8Xez4PojPda2wSus7+Cc8ETcoswg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n55WNq5byuDsNbEVb0owIq93ySr467xkVnuJZH7sIoE=;
 b=wh7mU7g+BFPKg2JxLCGzJIV5bLMUMToVhwre5479Ae0aZbGzVkNwejmgbj7e+wEs3GcoTIfR4zB4ttiEzklqy6S49flCmh7CF5Z+M3O+VRBCn0fByG9/iZrDCfKIfxFiynqcIf667sjt/7UuUO5tNb2fBoqjxH1KNUG5AXV/n8c=
Received: from BLAPR05CA0028.namprd05.prod.outlook.com (2603:10b6:208:335::9)
 by DS0PR12MB8786.namprd12.prod.outlook.com (2603:10b6:8:149::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Tue, 23 Apr
 2024 08:26:59 +0000
Received: from BN3PEPF0000B06F.namprd21.prod.outlook.com
 (2603:10b6:208:335:cafe::56) by BLAPR05CA0028.outlook.office365.com
 (2603:10b6:208:335::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.22 via Frontend
 Transport; Tue, 23 Apr 2024 08:26:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B06F.mail.protection.outlook.com (10.167.243.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.0 via Frontend Transport; Tue, 23 Apr 2024 08:26:58 +0000
Received: from kevin-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 23 Apr
 2024 03:26:57 -0500
From: Yang Wang <kevinyang.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <hawking.zhang@amd.com>, <tao.zhou1@amd.com>, <Candice.Li@amd.com>
Subject: [PATCH 4/4] drm/amdgpu: avoid dump mca bank log muti times during ras
 ISR
Date: Tue, 23 Apr 2024 16:26:40 +0800
Message-ID: <20240423082640.3273762-4-kevinyang.wang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240423082640.3273762-1-kevinyang.wang@amd.com>
References: <20240423082640.3273762-1-kevinyang.wang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06F:EE_|DS0PR12MB8786:EE_
X-MS-Office365-Filtering-Correlation-Id: 24419ce8-22d1-4a07-b0cb-08dc636f24b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?z1V+chYvXHtp7XI7QCpJFsgskP9GNUm0N8o1QfFJYsLpZ98ihLpKfxZjhP/1?=
 =?us-ascii?Q?+y5yKfUp9Jo3VKYNOuHlRmBsuAhpYq06D5WgtYBGFPERzaIZP2zTDB1VViUh?=
 =?us-ascii?Q?7J1Kx8qg0BJg3y128h7pWwzw/T6t6hNF5Hvow6uq1NF0le7LLObFqumKw5KB?=
 =?us-ascii?Q?X1+MiOV/8ziSOgym1To686slMsjIyYKG/rR5j5+v0MUDlUQim6jqQcqPBEeg?=
 =?us-ascii?Q?a2a6BVSybJQK4K7DxGQDs66tBfhD+7l7xwUEYPYQvyA4yNiHXbXXfxjbWSUj?=
 =?us-ascii?Q?64d79zDhzJX/Ydh3E4RXQ4mY4WFeV7F9O7YYkty5qEsgB+1M1Fool8fUvRGE?=
 =?us-ascii?Q?z6CWTUKiLHTKgXPJtKigmcuFUFaAPlHsoEOcyJvZ+4FZVLhAqkVOkDNB/kmM?=
 =?us-ascii?Q?M71k+ncA2hle2/KgOrSH0xjn7Ly7lyqWncqPOU4uL6G80VsFhBbpEXB6Xeol?=
 =?us-ascii?Q?igxQWIb0wT9qE9ZUJ0Pl35ITvzyBwZGJfAhx/szgUt4lXF/Kxh1ePR1zZ/xY?=
 =?us-ascii?Q?exvk0S852rJgaGMcBdyLl9gguR5UuhBnMAXSv6nhC5DYH4+2KKUX9E8Ygms1?=
 =?us-ascii?Q?9kePH3xBECw06DSU3ABt09M/Uv15osksmUHekj3yCMUZ9gsPU01h3h1C0mwG?=
 =?us-ascii?Q?xklpJaFNSdg63NULIKxm0R+mb8ZTd8Yv6jMh4Jj3zCXEbMVpwmhNNlGUKzcu?=
 =?us-ascii?Q?t3VdnKcuFg5ZKCKpwVYX/FzDX+FOMyzh1EGv59IyCefbGMONNWsROD58J2+D?=
 =?us-ascii?Q?5/jjbJYqsGAXibk0bFlN2cGrdGgfa7lVSSHv9uVh5rO4HdAu9HQUKmBphV0K?=
 =?us-ascii?Q?MNYRU3HKJZbW58qplGH/dFZEbr2atobPzNfI99tUxo9BK9mwy611iyHZZT/9?=
 =?us-ascii?Q?WVVHlWrg+0J7LP0PKjYizGTT7cKUl4sIfSvOc4jq8I2RPW07EaDmAV+3rL/A?=
 =?us-ascii?Q?I8ltBFx6V+EnM6F/lUJGsh/jjRKkAms8n/h9RdM6+KCunrhyr09bGUYCMESA?=
 =?us-ascii?Q?iDxJAWnZ5DFiUcHNHZizRIt49RAHESBzDIZ0QIyw7dsFzyshl4ZRYNgV8nv4?=
 =?us-ascii?Q?zCoJUR4tkAu8aBlUjV+E6kJ/i35y2FwZj+VajVBYCZnfVIpL/gVV3KYk/31Z?=
 =?us-ascii?Q?3nuxEHKSfxseZAskZkPdLtBFJ2bFXQpT2Fpgm3AePngZVVhAdInRf237ijDX?=
 =?us-ascii?Q?G0PPtWmJoXeoFVtJZT/XTJx4TZrV0zckbHW0erFWZun6kpBkd18V22228zeO?=
 =?us-ascii?Q?vOiKE/yXonLtVHbs1GZmFhl50fAwim12Zn1soL7mu6RBzeFRmR5UbdgykB8T?=
 =?us-ascii?Q?NfmFrbpYJ69eVBqN32YulV3PTi+5kQwnR7rHpVSOYMlAadiUMR3fV0VdfYVx?=
 =?us-ascii?Q?zmH57z8s2Wt2mQ+/V8Q52IyN4vTF?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(82310400014)(1800799015)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2024 08:26:58.7443 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 24419ce8-22d1-4a07-b0cb-08dc636f24b1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B06F.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8786
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

because the ue valid mca count will only be cleared after gpu reset,
so only dump mca log on the first time to get mca bank after receive RAS interrupt.

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c | 28 +++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_mca.h |  1 +
 2 files changed, 29 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c
index 264f56fd4f66..b581523fa8d7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c
@@ -229,6 +229,8 @@ int amdgpu_mca_init(struct amdgpu_device *adev)
 	struct mca_bank_cache *mca_cache;
 	int i;
 
+	atomic_set(&mca->ue_update_flag, 0);
+
 	for (i = 0; i < ARRAY_SIZE(mca->mca_caches); i++) {
 		mca_cache = &mca->mca_caches[i];
 		mutex_init(&mca_cache->lock);
@@ -244,6 +246,8 @@ void amdgpu_mca_fini(struct amdgpu_device *adev)
 	struct mca_bank_cache *mca_cache;
 	int i;
 
+	atomic_set(&mca->ue_update_flag, 0);
+
 	for (i = 0; i < ARRAY_SIZE(mca->mca_caches); i++) {
 		mca_cache = &mca->mca_caches[i];
 		amdgpu_mca_bank_set_release(&mca_cache->mca_set);
@@ -325,6 +329,27 @@ static int amdgpu_mca_smu_get_mca_entry(struct amdgpu_device *adev, enum amdgpu_
 	return mca_funcs->mca_get_mca_entry(adev, type, idx, entry);
 }
 
+static bool amdgpu_mca_bank_should_update(struct amdgpu_device *adev, enum amdgpu_mca_error_type type)
+{
+	struct amdgpu_mca *mca = &adev->mca;
+	bool ret = true;
+
+	/*
+	 * Because the UE Valid MCA count will only be cleared after reset,
+	 * in order to avoid repeated counting of the error count,
+	 * the aca bank is only updated once during the gpu recovery stage.
+	 */
+	if (type == AMDGPU_MCA_ERROR_TYPE_UE) {
+		if (amdgpu_ras_intr_triggered())
+			ret = atomic_cmpxchg(&mca->ue_update_flag, 0, 1) == 0;
+		else
+			atomic_set(&mca->ue_update_flag, 0);
+	}
+
+	return ret;
+}
+
+
 static int amdgpu_mca_smu_get_mca_set(struct amdgpu_device *adev, enum amdgpu_mca_error_type type, struct mca_bank_set *mca_set,
 				      struct ras_query_context *qctx)
 {
@@ -335,6 +360,9 @@ static int amdgpu_mca_smu_get_mca_set(struct amdgpu_device *adev, enum amdgpu_mc
 	if (!mca_set)
 		return -EINVAL;
 
+	if (!amdgpu_mca_bank_should_update(adev, type))
+		return 0;
+
 	ret = amdgpu_mca_smu_get_valid_mca_count(adev, type, &count);
 	if (ret)
 		return ret;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.h
index 9b97cfa28e05..e80323ff90c1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.h
@@ -93,6 +93,7 @@ struct amdgpu_mca {
 	struct amdgpu_mca_ras mpio;
 	const struct amdgpu_mca_smu_funcs *mca_funcs;
 	struct mca_bank_cache mca_caches[AMDGPU_MCA_ERROR_TYPE_DE];
+	atomic_t ue_update_flag;
 };
 
 enum mca_reg_idx {
-- 
2.34.1

