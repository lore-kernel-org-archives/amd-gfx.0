Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CA73CD11DD
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Mar 2024 17:48:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1213D10F0B6;
	Thu, 28 Mar 2024 17:48:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="TNmlxiFe";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2076.outbound.protection.outlook.com [40.107.243.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 41C1410F0B6
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Mar 2024 17:48:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jwvEW9GaOdqdjoKUnlL8fplk9y4khnbT1b6mamFXw63K8tYyr9PwwqYOVSy6qv16xUAOKTz7fgQvPf7APeMGs1HbrG6SPkxfk/FFfxsr6hyqz5MaiVKk3E/hkXaSKQ3mbkrRNT35jCQdeBwxRW+n/VtWysTencKO22sp9vBa4yb1fhRmUbJ5ZGtrGv5RJfSQWWwXFa6bnJMco3YME+jFRCFo2D+fs0lcXWdHCB8jLq2mhaM+KaVn5a6qozIlTVprRT4RBVb8CSzbV7ycz6oLiFq52Z+iPnvnN0ckn6U2y7AmKDxFRzcOgOkj8nJMKF94mAtl76EMNgGB4fN6Uhu12Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z7+e9FfTwUE4dCPPEES4rsBC0MnbybxFIT4TbCjjy68=;
 b=gK6jmqBHn+U1QSkvknmM87klBa+VYNqj23V25w/arv3rd/POs/N8zqxw0qEyFrLl0zzZu6Sxswow12DwZdmKdplEZUDH65IpGZ7HVpLXqhQggILeiOJLXULBqhxK/eKa11j0zMcQeP9lzPXTZ0y0rxI3yOAKbqCnIZpOS8MtbuqstFespRx8jMSTVmuw5D+r+W9iuKv2Hqw9BEywLO2CSMz9GcFRZmajBY13DAsBpr2EZVt1HYsHdAgUhCUO04c+rUvOJXiW7YTPIkHk3xDzwDufINf5KN+EvnrCKmmIkC+C2+juTXiHnqUTxf6bMSKgVC4rN8VzyfJROlomJ+g2RQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z7+e9FfTwUE4dCPPEES4rsBC0MnbybxFIT4TbCjjy68=;
 b=TNmlxiFe4ICCzJj4jKJLhVttTKC1riJU0kKwjDdNVDxMiofik8V/9vrYut402lNKAAJtjsYx6qiWUGPLlkMBPkd6Y9sBy8XZSQPmMEUnzqT2Fge9Uf2UMx44EgwBvsD0UFtDJp7jVwK9m/3vF1We3sosUU6uGpqCiroXfqLdEEo=
Received: from DS7PR03CA0026.namprd03.prod.outlook.com (2603:10b6:5:3b8::31)
 by PH0PR12MB5677.namprd12.prod.outlook.com (2603:10b6:510:14d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.32; Thu, 28 Mar
 2024 17:48:25 +0000
Received: from DS1PEPF00017097.namprd05.prod.outlook.com
 (2603:10b6:5:3b8:cafe::ff) by DS7PR03CA0026.outlook.office365.com
 (2603:10b6:5:3b8::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.13 via Frontend
 Transport; Thu, 28 Mar 2024 17:48:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF00017097.mail.protection.outlook.com (10.167.18.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7409.10 via Frontend Transport; Thu, 28 Mar 2024 17:48:25 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 28 Mar
 2024 12:48:24 -0500
Received: from sriov-SERVER4.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Thu, 28 Mar 2024 12:48:24 -0500
From: Danijel Slivka <danijel.slivka@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Danijel Slivka <danijel.slivka@amd.com>
Subject: [PATCH] drm/amdgpu: use vm_update_mode=0 as default in sriov for
 gfx10.3 onwards
Date: Thu, 28 Mar 2024 18:59:00 +0100
Message-ID: <20240328175900.161968-1-danijel.slivka@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: danijel.slivka@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017097:EE_|PH0PR12MB5677:EE_
X-MS-Office365-Filtering-Correlation-Id: d6529fa5-c445-4fd4-ce2d-08dc4f4f44bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6rrZdUjTrsJBHlm+hX++KX8598DAxDtByw2FcTQ+bHz4yjIqSvw3S86WgNyW659QCCdcUsH/GRCeH9l+qoChDPuBcJcby71vrHZCijc0of0SivZvaC/f08B54klnOWWt7wpKmtQzR4JanOydJyz0oVuQEhqXeojvNW2J7GLuB2D49cqkLJppqlmivYOA+rb8XYZrfumUHSFV6PjHI6Xh+ufNZEbsxjIpwIz+VfO5GuYXqGMwaEhiBdEWG3CSmXzEIDNbHgwNyw7VJwHI91OYYImzXuzaHBCbY5cBvA9c6exuXNDpCYWxUbPGkF84LxUkCRG2nAibiZZtAdiFzoH2jAsTdq0zy/HcI2hTas77sHn/0IwB8hFAUBBpX0VfRD/5vqvwcoXxjFPQgjM3akbT6PmdkMkR1qsKBCzaLerKqeaJGNXtLRKCIkrP4CDcJNcdgzfyOKA2NL7BsIq8n/n2HjI0ZfyEMWafJGrcSodGLxu96sUSyn7AqgzWJ8zrNeZoXdudCx5YQeI3bOumfeLZNJuRXGHkgOm+IBA0bM+azRUwtajmYWWDPOTFyqnhRjR2PTx5Q3ZQLPTLLxmhQFrEBzDIxUZcByzvZIaWFmPPDz0xvXPbWNaTnP8p5FtK+k1BwigTtsG5sM2qIUZu0dH3ZPfZD7GwQSNsA9SwB+f+RZkn/rBxQyug5g5JtaE8hzsozjwwnkLXeqI6Otl+euR+DuVJPXPNeHvjUsfyxpBs331jPA7bIXB2OeAqYSgRyaSR
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(82310400014)(376005)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2024 17:48:25.3287 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d6529fa5-c445-4fd4-ce2d-08dc4f4f44bd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017097.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5677
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

Apply this rule to all newer asics in sriov case.
For asic with VF MMIO access protection avoid using CPU for VM table updates.
CPU pagetable updates have issues with HDP flush as VF MMIO access protection
blocks write to BIF_BX_DEV0_EPF0_VF0_HDP_MEM_COHERENCY_FLUSH_CNTL register
during sriov runtime.

Signed-off-by: Danijel Slivka <danijel.slivka@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 7 +++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c   | 6 ------
 2 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 12dc71a6b5db..59ee902a1eaa 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4072,6 +4072,13 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 	/* Enable TMZ based on IP_VERSION */
 	amdgpu_gmc_tmz_set(adev);
 
+	if (amdgpu_sriov_vf(adev) &&
+		(amdgpu_ip_version(adev, GC_HWIP, 0) >= IP_VERSION(10, 3, 0)))
+		/* VF MMIO access (except mailbox range) from CPU
+		 * will be blocked during sriov runtime
+		 */
+		adev->virt.caps |= AMDGPU_VF_MMIO_ACCESS_PROTECT;
+
 	amdgpu_gmc_noretry_set(adev);
 	/* Need to get xgmi info early to decide the reset behavior*/
 	if (adev->gmc.xgmi.supported) {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
index aed60aaf1a55..6f01de220c44 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
@@ -724,12 +724,6 @@ void amdgpu_detect_virtualization(struct amdgpu_device *adev)
 			adev->virt.caps |= AMDGPU_PASSTHROUGH_MODE;
 	}
 
-	if (amdgpu_sriov_vf(adev) && adev->asic_type == CHIP_SIENNA_CICHLID)
-		/* VF MMIO access (except mailbox range) from CPU
-		 * will be blocked during sriov runtime
-		 */
-		adev->virt.caps |= AMDGPU_VF_MMIO_ACCESS_PROTECT;
-
 	/* we have the ability to check now */
 	if (amdgpu_sriov_vf(adev)) {
 		switch (adev->asic_type) {
-- 
2.25.1

