Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6D0BC531DC
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Aug 2024 00:05:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2658D10E324;
	Thu, 15 Aug 2024 00:05:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="VTEPQb7L";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2070.outbound.protection.outlook.com [40.107.92.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AD88210E322
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Aug 2024 00:05:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iZTIrR0xjx7sNcsg4GE2Jh7sF7QoXoteHfRN5NFY3D1g7RxKN4isUvanLI5YPnYv92JUF9VGyZBUeolQNPLD9zRnJRuN9atGqL0toryuE4KhertUNOncRFRdgnXkH9isDzFSYyz3itB44R8pozAChyADfLtbmF4rRNfB9YdKzYXze+dWfsdZ6TIACNVhamwHVvEQ5+1pLH+Qo1gMC2STAhTS+yfYsF7B8sI3oYpunrx/ZsEeUZQSjhH9qtbYCyIhxsSy0GOxt8MpbjmvPJuAa5Gdpm3xXLgGU2uKCoyVJTXP0sdVNekS7kejfBx7YhxHefyxbENDdVuBGnHhVfaAMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L4Fo/d/MHmk5sqknDW0y+AffmTuovo/oUkMEsBFV6Io=;
 b=q0stGr6Fsgfwn2NHQ4Spbz+wNLppn+G/wMBX2HZ8q9LkSZ1QKauH2C3fbejokGkXAFvvrAkSJg+Kb1bcMG6qmrII1usjQw1Gb09oHImUZwEkhEgQYvzauuPHHPNNsSxdAUDsYNQ3LgWf0JLBB8bpiky3f6+7zydNre/bq38F3i7XJNhDlmTemjdLF5WwfbvCO2BbE17/WSXGWrZPOedQheKIyVNZJsS9wLHZtFY+LHUvBdcK/aFwBxl5C4PvGn+1R7DYu7Apyi0pBkFK+Qdr119w/Nc/bJSfN/ut+EtdVG9SfUogCkNy9K373wBtf90ozoPPnPbMfDiwMLDonADwLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L4Fo/d/MHmk5sqknDW0y+AffmTuovo/oUkMEsBFV6Io=;
 b=VTEPQb7LrtPOFFHf2B4oGX/ORTWzGLpsYJD855osP+QtvKec8TCTZrCubWni5tk8S5sPEvqHke1uAWpu3ejv3nMGW20rDYAJsVHm4MHpOcMdUzuDH9KTr5LJqkithc3IJNRSFY4PS+SfkJiM8VS8oD/ivBAgNte76iVyfdiUgNU=
Received: from BL0PR0102CA0022.prod.exchangelabs.com (2603:10b6:207:18::35) by
 CH2PR12MB4328.namprd12.prod.outlook.com (2603:10b6:610:a6::14) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7875.17; Thu, 15 Aug 2024 00:05:20 +0000
Received: from MN1PEPF0000F0E5.namprd04.prod.outlook.com
 (2603:10b6:207:18:cafe::7b) by BL0PR0102CA0022.outlook.office365.com
 (2603:10b6:207:18::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.22 via Frontend
 Transport; Thu, 15 Aug 2024 00:05:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000F0E5.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7849.8 via Frontend Transport; Thu, 15 Aug 2024 00:05:19 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 14 Aug
 2024 19:05:19 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Srinivasan
 Shanmugam" <srinivasan.shanmugam@amd.com>
Subject: [PATCH 03/17] drm/amdgpu: Emit cleaner shader at end of IB submission
Date: Wed, 14 Aug 2024 20:04:47 -0400
Message-ID: <20240815000501.1845226-4-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240815000501.1845226-1-alexander.deucher@amd.com>
References: <20240815000501.1845226-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E5:EE_|CH2PR12MB4328:EE_
X-MS-Office365-Filtering-Correlation-Id: f60b79d8-f614-4c92-4f56-08dcbcbdf37a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?T0EzYlBRNmtIUnZSVUxPNENtRXlsd3p3ZHRYeVB5VFdSckx4QUlXQ2I3Z0kv?=
 =?utf-8?B?TjR3NVZlVGVqRzl5V0xvVHROQ1hBWVZ3NTlmeWIraUI3aFF1K2xQUlpvVmZO?=
 =?utf-8?B?TWtsT0x4bFFKcGoyaEIwelRlMk5TQzhZRHlEZHA2Um1uT1JwMWcrcmcxNWRL?=
 =?utf-8?B?RUoxWlpnZ0U0YVJGNU9ndmxKdGZ2S2tBMi9oZTAyckptb2ZoSzRCRmNYZnJt?=
 =?utf-8?B?VlRnb281aWtBNkJlV1REZE5NZ0JkRnI1ZjRqU0pabkIza1lnbW9qbkFFVDNh?=
 =?utf-8?B?bGdYTzRHZVZRcTl5aVhhblIwK1N3Z1JuVFhVZVhOaitGWTBUaS9ydUlhY09O?=
 =?utf-8?B?MW9Kck14akRucjVZUndDZzBzNzIyaHBOVzBrcEhWYW1iSEQxY2VWOUhCTGlw?=
 =?utf-8?B?T2ppdVJWWkVqUnpnTE84TzZ6UWsyZnBOd3g3eU5aNGVSY0dxQXJtUytNYUhP?=
 =?utf-8?B?TktGblpmZkZjcmw0TWNIdGtkclU2YzIwSlpLRGt5WXArb2VNcnljYWNWZFJs?=
 =?utf-8?B?Z1RFY1NuUG5BMHBwUlQ5WE5La01XaTIzVlMxMVdvMHdUcmlFVHdjbHBPbytQ?=
 =?utf-8?B?aTY3ODRwVTJndldJQ2lsQnZtR2dSa1N0bTlSUTA1bHZKM2NpcUt0dnJGaHVM?=
 =?utf-8?B?b3JOU0xCa29DajlUNDRRSlNoNlhKQy9jL3JDRnllVFp5M2IwZllkODB2T0or?=
 =?utf-8?B?R2RHeUJDYXJ5VHFtM1VwaHJvSW1rMEJrVUhKOEI2NjlJaENIdkpWOVNwdUNi?=
 =?utf-8?B?c0NiYVV5ZTJ2TWVCQ0hsVFVBeXVqa1NHcW4vcW1NTDlTSnRpeTVVMWxMbTEx?=
 =?utf-8?B?dlkwdEgvVWNOZm1wdnNRTkxHcTdEL3lWVGRWcDUvMDFwNndQWTBjdllOejFx?=
 =?utf-8?B?TVZxbWRHRndpZG82SmkzUXVja1QwTkRBVVV1aEpZNFlERG9oalVES2Rxazln?=
 =?utf-8?B?WlZXZmphdzhscCswVmFTQ1ZyczR6WUV4ei9lSGlxc3A5ZnlyMGx0UkdjU0dH?=
 =?utf-8?B?cTdZQlV6VlhzaVRyU0ZYNWVyYzFEQWZKUTdDallwdENYYWNyYklad3VBWks3?=
 =?utf-8?B?YWNCMHFybVBoYmJmWk1pZlRQcVFoNEZkcUNrQUpFVXRCNHY0cm41VUk4cFlw?=
 =?utf-8?B?YTFrVVBSanF2RzVzTVFwMVkrUzFDdmYvWlJLaUlGbEpla2JsRHk3STBUY3FF?=
 =?utf-8?B?TTlObU9UUC94K24vcmRHYnovbG9vT1dsUDcwQTM1T2RoVHFGeVZGTXNLeXVu?=
 =?utf-8?B?Q1dhQ0pubVovNXk2OWxCU3NwMi9WeUt5ZUFyQWI4YTFaMklJeVNkd00vNTMr?=
 =?utf-8?B?dDBnaUVwOVBwSVVqSlE3SW1Kb1hoV2FIa2lTc0JFUXd1ZitRbUlWcUtpYjh3?=
 =?utf-8?B?KzR0RGNDLzYvbk9GRGFpZTE3cXpHbTFlbzUyMElZeUpmQThpbVlCT2N4UVY4?=
 =?utf-8?B?dnhoSktYTXp0SFR4VUZta2k1VXh5dnI5V3N1aEVobk1xS2k1OFhvaE8zZzJS?=
 =?utf-8?B?d0tWWFh5dkJCL2N2N1hZcnJsSW05REc1NlpBS3M3VzFhdnUwU2ZyZ3NScTVh?=
 =?utf-8?B?QWwvR1h4cndid05qZm80VkNWc1QxQU9Cc0VDTTByNFdnZDBINDlQNXd1VUVL?=
 =?utf-8?B?YTZJem1BZ2FwaHdUQ1hzZ0EzZGJOVndiejFnUWtsaVZLMWtZQU9iSW02NWFz?=
 =?utf-8?B?OTdaTXZBV005VXJsNDlDTU1pbmxKZmYzSHZBZmo4cnFwS2tFOG9jODZ2UUE3?=
 =?utf-8?B?ems3anhYNGQwUFdXVmxjTzBudW9Td3Bsd004MlFNRE9JbEFIM1NPWTRIZXVG?=
 =?utf-8?B?S3poK1ZPaGx4MnlqT0V6UThGYlBFNDlaM2xQblBaU3lFZHFNOXFqcUJXWXZw?=
 =?utf-8?B?U1FLWklRaWRJenRtWHFJd2xxaGhiN3NrNzM3Ylp5SHRkc1I1QTBUdEUyc1Rp?=
 =?utf-8?Q?VEbtnwiIzvaTCVL1cugwMNEz1sU0lLTN?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2024 00:05:19.8862 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f60b79d8-f614-4c92-4f56-08dcbcbdf37a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0E5.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4328
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

This commit introduces the emission of a cleaner shader at the end of
the IB submission process. This is achieved by adding a new function
pointer, `emit_cleaner_shader`, to the `amdgpu_ring_funcs` structure. If
the `emit_cleaner_shader` function is set in the ring functions, it is
called during the VM flush process.

The cleaner shader is only emitted if the `enable_cleaner_shader` flag
is set in the `amdgpu_device` structure. This allows the cleaner shader
emission to be controlled on a per-device basis.

By emitting a cleaner shader at the end of the IB submission, we can
ensure that the VM state is properly cleaned up after each submission.

Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
Suggested-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h | 1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c   | 5 +++++
 2 files changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
index c7f15edeb367..f93f51002201 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
@@ -236,6 +236,7 @@ struct amdgpu_ring_funcs {
 	void (*patch_ce)(struct amdgpu_ring *ring, unsigned offset);
 	void (*patch_de)(struct amdgpu_ring *ring, unsigned offset);
 	int (*reset)(struct amdgpu_ring *ring, unsigned int vmid);
+	void (*emit_cleaner_shader)(struct amdgpu_ring *ring);
 };
 
 struct amdgpu_ring {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index bcb729094521..71ef3308be92 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -681,6 +681,10 @@ int amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job,
 	pasid_mapping_needed &= adev->gmc.gmc_funcs->emit_pasid_mapping &&
 		ring->funcs->emit_wreg;
 
+	if (adev->gfx.enable_cleaner_shader &&
+	    ring->funcs->emit_cleaner_shader)
+		ring->funcs->emit_cleaner_shader(ring);
+
 	if (!vm_flush_needed && !gds_switch_needed && !need_pipe_sync)
 		return 0;
 
@@ -742,6 +746,7 @@ int amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job,
 		amdgpu_ring_emit_switch_buffer(ring);
 		amdgpu_ring_emit_switch_buffer(ring);
 	}
+
 	amdgpu_ring_ib_end(ring);
 	return 0;
 }
-- 
2.46.0

