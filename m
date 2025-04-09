Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADE1CC36002
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Apr 2025 12:10:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1706210E86C;
	Wed,  9 Apr 2025 12:10:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="m8hy5Io2";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2064.outbound.protection.outlook.com [40.107.220.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D377F10E86C
 for <amd-gfx@lists.freedesktop.org>; Wed,  9 Apr 2025 12:10:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tBPFfhnXpMbsNBmnkTQcbZq+sumEO7HFtnBR95HKiqik4dL3UibrGhYHCGu1xOZCJwGSRPwKe1gaGKP9EL3gQ/CS7w7gNfIAhfc71qDLgpyBgSdq5FfKvivoTFYoPyc6Vp8hfwShH9L+XxTLjqF32iwTKPHXwQxSDFeKHDLF+Buw/GglHrgz9WYJvpNrZMrhhLXHot0w7BN0bgI/fCTxaoD0WPAbQSzignPoen4ifBdGg5OhJEy5GSzTDedpxisce0dH/YRllXthWHXR73CfDVdUaUoOhLSoAwt/4GbcFTTzHr5XVzBPdKiftMBhjHQc6btEpP//dsEsLL35lMemEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nU6Ye4w2FfazF3PPlpWVGicy5EUr3oLc2My6/c6rdTw=;
 b=BCjaYkvaqm5us51LUXwDtjXkqbh2VWPTbABqRmKDY9/CalBqjSTUekU5lzJfrEyU5qCrXsG6i4jcgEYr3FqioIrI74Yq8PKo6BpEfsAHd0mSVFNSTLOjjzpyayusDA/32g/C4aSdxd//49BkqV0eJGTHC/Bcldo8FBaEwweWPrabXy6dffvNdGiJ88ix0jKULjNfrhlwtMybKZ5oavAXCJcDJx0cU0a73PkbaquNMWQ7JYub88UjUqX5UyHdSRHNYgiXvY54Rxpfe6uhpMwvxjOofJXjKrTc8lxkA/4/pJnDy1ccjgrNmBFH5pAAVGCUJJXPGeFVuvYT1u1gm4LDdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nU6Ye4w2FfazF3PPlpWVGicy5EUr3oLc2My6/c6rdTw=;
 b=m8hy5Io2V3US/qfACDzeGH3DAL7TVFCNvnxYK5Cdf3+dOqtVJHzFRBVc94w9uDGS/vaCyael8bWHWpCxIiS3u7jlvdOUzCrG9o3sFPvITT34qllglznK93N4FgRhpjhY9PoRXkbrukdNZ5hpEh59vD5ZzOanQzTREhtnFLRgZGE=
Received: from SJ0PR13CA0186.namprd13.prod.outlook.com (2603:10b6:a03:2c3::11)
 by DS7PR12MB6311.namprd12.prod.outlook.com (2603:10b6:8:94::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.23; Wed, 9 Apr
 2025 12:10:13 +0000
Received: from SJ1PEPF0000231C.namprd03.prod.outlook.com
 (2603:10b6:a03:2c3:cafe::42) by SJ0PR13CA0186.outlook.office365.com
 (2603:10b6:a03:2c3::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.19 via Frontend Transport; Wed,
 9 Apr 2025 12:10:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF0000231C.mail.protection.outlook.com (10.167.242.233) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8606.22 via Frontend Transport; Wed, 9 Apr 2025 12:10:11 +0000
Received: from sunce-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 9 Apr
 2025 07:10:09 -0500
From: Ce Sun <cesun102@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <dan.carpenter@linaro.org>, Ce Sun <cesun102@amd.com>
Subject: [PATCH v1 1/1] drm/amdgpu: fix a smatch static checker warning in
 amdgpu_pci_slot_reset
Date: Wed, 9 Apr 2025 20:10:01 +0800
Message-ID: <464215422a8b934b9280fac884f6f389b64fca05.1744200284.git.cesun102@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1744200284.git.cesun102@amd.com>
References: <cover.1744200284.git.cesun102@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231C:EE_|DS7PR12MB6311:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c3926ef-c967-42c3-3fbf-08dd775f7a9b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?BLRIU3wFyYqeZqr2B98y2IeVdNK57TEkYiGlIS/GbhGQ3df2vTBokYDS6U92?=
 =?us-ascii?Q?No+m1tnTJYWDm71eiZjZu2qX45cMEe3xhEU8M7eZHB3Mo/yvobHjIfV4lz6e?=
 =?us-ascii?Q?IgOWUP4iXFjiyBV/zSwq5Cnhb+EnJjfoP+mMwVGcwvb7ageJcZXNf/OX7nnQ?=
 =?us-ascii?Q?7uBJIJXbIYo8OR7A77bnSQEHGpv4i3AnfEUy+K629jaW+9hjHlnR3wYGlC3Y?=
 =?us-ascii?Q?iXFnlX4jgptjp0Lt7uSemTaHsXyeKO5w1Vvna1wEHXoPdrjfNZPirg3YrmFk?=
 =?us-ascii?Q?H6+wVxKPl5TpTboOdy+uz70Ci3CLAwPsRviKDqLiQLx4k1hZCmlM4kTpRe3J?=
 =?us-ascii?Q?cz79BJze3TZQ0Yq6y5ZF05fnza6ifMAyEMNJ2VbZaP6Iu10P5GgyBeWvCQx2?=
 =?us-ascii?Q?tuaZXmIDnWoCvwVPCEfTL5gK6OYi/ee7UmmLF9mWKFcf9EqBkEbZjsawZbOP?=
 =?us-ascii?Q?fcZre2kmSoJwYcPpXbGHmcYwOpNBjk9hr3yuqSpiyddBaXaiVeNRe3hgImsg?=
 =?us-ascii?Q?22Rl3d+nwxmHsna9fMzoUko47TWkC/Dt7ot8UcKNQ4x/OKb9ig8vOL3JtHAU?=
 =?us-ascii?Q?+KTx56EKg9EZYUF4l+K/tUeki5N53eWZ9zuvQ1f7F0gohC2ra3vmqZyYOk/C?=
 =?us-ascii?Q?bksBijWRgWOWo4D/YpxyAHNSZ+n4QQyjBXvhTp/AHTtMHp5Io0+YeKzXKTBs?=
 =?us-ascii?Q?TmKAtfnv1H3pGYJuBgot31kbGaCO64A9c2eQwMtnFkeNmgyf7NZwdvSCHKN0?=
 =?us-ascii?Q?C6qjV6+vc11MwDuMEbiCKbPDVlgzDD7cDCFyMk+LNT4i/GlKhLItmAesCvQ3?=
 =?us-ascii?Q?Er3go0ajfkoW/Hub57xpvH+EJFdLaHCXmZU2F70uegMkiHbZoXc94LQT8V0d?=
 =?us-ascii?Q?IYcFXa9u8Dg/29viLyE9a5OUQ/FtSsfp4KWAR40K+V2gWc2qFJFB8QXNFy/n?=
 =?us-ascii?Q?t3muFIrhykm2tud1bBsNqPPUEKakX3N/H8WoeIupDQ69YtYDguyFn5i1k3Y7?=
 =?us-ascii?Q?02epjUHx/s2fN5oHuc9vKYepmjkIl0EW8xOJyKLXjxwgN18JK8q1fAvndJ62?=
 =?us-ascii?Q?ZUVgIThcre4Tf3lmpgXaI8d0mD6hN6Ea0WXR18x3KD2V6f58u3KvPrUBeFym?=
 =?us-ascii?Q?yXaRtI345AxvfQYi+0XV5F+Zw6aAW+JXz/FF8lReN1uAsg8Axu0WSzFapjvW?=
 =?us-ascii?Q?C0sW+tOk3rF5pKv+rZT4erlkLkomSkHP+ZdZXwOjh3i9ZSgs9hYOSYyGdvzZ?=
 =?us-ascii?Q?5gAZseRmZtsr8QZK/YmjxtpxVp6HZyJv8yGPpWVqsZN5XMfg9o/4tUEd8MEu?=
 =?us-ascii?Q?CQleGeprazS1uUjMurIRWLE92pw5FlzD9kBchPoOLlcb5i9NpppwWgMYtrck?=
 =?us-ascii?Q?VuFC+HMl0YEhjUxOWpO7KVY/KJk+Jxwui+6jXwia022NMDN0zr23J9HX+CDW?=
 =?us-ascii?Q?lKAnAERFOqrQ1WqdHQN1FJRj2evWRx5xRuLaHTeVXj7OycMkuBVqykRyiR/p?=
 =?us-ascii?Q?gpnB846NRGdazdfjTZ9n1QP1+c9/Bg1mrCst?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2025 12:10:11.7665 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c3926ef-c967-42c3-3fbf-08dd775f7a9b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF0000231C.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6311
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

Fixes smatch warning:

drivers/gpu/drm/amd/amdgpu/amdgpu_device.c:6820 amdgpu_pci_slot_reset()
warn: iterator used outside loop: 'tmp_adev'

Fixes: 8ba904f54148 ("drm/amdgpu: Multi-GPU DPC recovery support")

Signed-off-by: Ce Sun <cesun102@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 60269fba5745..eb0589a09a27 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -6846,7 +6846,7 @@ pci_ers_result_t amdgpu_pci_slot_reset(struct pci_dev *pdev)
 		dev_info(adev->dev, "PCIe error recovery succeeded\n");
 	} else {
 		dev_err(adev->dev, "PCIe error recovery failed, err:%d\n", r);
-		if (tmp_adev) {
+		if (hive) {
 			list_for_each_entry(tmp_adev, &device_list, reset_list)
 				amdgpu_device_unset_mp1_state(tmp_adev);
 			amdgpu_device_unlock_reset_domain(adev->reset_domain);
-- 
2.34.1

