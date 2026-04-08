Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2735105D991
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Apr 2026 01:16:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 685A210E4F3;
	Wed,  8 Apr 2026 01:16:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="faLC1X98";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010004.outbound.protection.outlook.com [52.101.201.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 192F210E4F3
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Apr 2026 01:16:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S+JrQVVY9iGvsUFOM0CSBd/4mhLl8NMJm4RpNVp/O2IrhGJ4Of57AUjBDRO6hMbXlcy6axk/MEeytFzrccka0SRfPnmdjlhfiDMwMx/Ps3ihgJYHjMH+wgADZRJjk/YsLUzw1Dm1LFXqpDpjyQHoGee4EeUYTPEjXrrvpKMUaQ8RRBGsMulBLZYr4+ZIRiUMx6uCUBngXtq9PmqfBJmcd3nfKFNX+cJ+w0q+I1VCzuxjZpSe4abT97wpoCoCpIzPgFLM7e0c0czMRrzPvdmKmPOkfbQ6RBNJBwRvXOgCk01os6ij89Kt8HearPmmQ/6jmH5m79VZRTtk/uKbauNHtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WMjRDqshfBcnH+oYaZW78TCSKX6x24PTXP7nWOVl8Wg=;
 b=vaRa1Y2ZTR102lgd7OlQkVKHwmMvB3xA7tbUBz3xQHGohh/t8jWpzh5X+dsdRkp3q1MKvbLtJ1kXc6S+3i6OPU0+339Wyh/3VlVu2Og7BZc9uAcyBI1d/ZATajzic+Q5NFsyEFXdykXDZV861WW9THJtMBXJV8a7xP+ggar7QhN2u7O9QlBAIFhZ4qo3Od27RjKzoavIpXq7HIYPF2pg4zeBo4X1wW1o/bZE7Tlg9mYxptGVp+L42IrpoUoHR2Ma66CvbvAbw95czAUOkO+CQ4JgG+lajTfwyt8qDjunz1FJ+IgoBCYMjF9vZ7h7S5A8Gv1Qk7STB6kgQNNea6eT1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WMjRDqshfBcnH+oYaZW78TCSKX6x24PTXP7nWOVl8Wg=;
 b=faLC1X985VLS1qEhS0tVWe0E/QR3WrtZX/tbam9UENVPWhh83mTYYN11HlNwivB6UDwAUJH5JyNdyMzl/7uA2Kxc54IxzCWfF1BjC2hrv+ZC10SbOqgVqnC2KZ3fa6Y2bei3O5euwuOE9Pc4UbCq3nrPzEJRx8lpRPPx29wBIxI=
Received: from BN1PR14CA0011.namprd14.prod.outlook.com (2603:10b6:408:e3::16)
 by SN7PR12MB7129.namprd12.prod.outlook.com (2603:10b6:806:2a1::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Wed, 8 Apr
 2026 01:16:33 +0000
Received: from BN3PEPF0000B06E.namprd21.prod.outlook.com
 (2603:10b6:408:e3:cafe::ca) by BN1PR14CA0011.outlook.office365.com
 (2603:10b6:408:e3::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.33 via Frontend Transport; Wed,
 8 Apr 2026 01:16:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B06E.mail.protection.outlook.com (10.167.243.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9818.0 via Frontend Transport; Wed, 8 Apr 2026 01:16:32 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Tue, 7 Apr
 2026 20:16:32 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 7 Apr
 2026 20:16:32 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 7 Apr 2026 20:16:25 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Jesse Zhang <Jesse.Zhang@amd.com>, Jesse Zhang <jesse.zhang@amd.com>
Subject: [PATCH v2 3/5] drm/amdgpu/gfx_v12_0: set gfx.rs64_enable from PFP
 header on GFX12
Date: Wed, 8 Apr 2026 09:15:10 +0800
Message-ID: <20260408011600.2512734-3-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260408011600.2512734-1-Jesse.Zhang@amd.com>
References: <20260408011600.2512734-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: Jesse.Zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06E:EE_|SN7PR12MB7129:EE_
X-MS-Office365-Filtering-Correlation-Id: 8499a51a-6ec4-43db-3b0d-08de950c7886
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|1800799024|82310400026|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: D2SaeGNfc10lebJhLOE6BkluREa9YDUK4Cd20/+pEdsq320sCtbm/F4LVfDsEkEPj6ILFOPZisTgCFLCLWjIh8RSs0qe2lbRXHBz/payZN4JlIrzKfTcHUi5vQR8SmmRT0SnCQKAGLQ5n7svAz7gXJyE5zuPBi/j6w3lSKaEtz3eS5grVAky9Drw9YBxsomK61ZDgepQLSAgXFGsvYuOK18UHykunzOEyRD1BcufT2dcw/dgNUleVapEgQJWfK2ZEoGxLkhQPovzfhL321D2PNVrmC/k8cgrrq7d791Xs2ooBAQIIPHW3A4JxlAwvmZ0bbHbCUUeTHKaFdgmqNcy5GRYphGdr0UkarCuEfLZcUdPGxPR2Kn3I2JlCcT2BFKWQbRy4fAbC9pruxrV/rrM6/PB4zsw1oxnGndB2GlnOZqq5BRoxEWSH1ZL7g6pl8l1Hhas517EEaKlwW7qESw7b5J2L0lPjRJ7SJO7g+7EHnndLTjRNs7gHg7B+HclaEZhe72YiTekmTQ/5XSX28xuHSvdCEJkQ6PY2Kt+1w8nyHLa9qmV+tHoQo6FHyVSclUx+RNkaYLhqr+5mE3phSlKy2MAorl7LfuslMEv5Zpeh5oDFrjD3Kx6jUaSDgzl/tfiklHDalo4G/OMcti7Ayx7q41o/vlYG455FFxCurqsRWIuRxMGQy9V/vX3A7y0JekW3wmxGQfIgpjQfXFT/HPyFT6gsr+yF3vqrcllsef1IU0D9Ckvgnvh5wCM0umTPD22tY9BvL8mj673YMZgpetuEg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(1800799024)(82310400026)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 7Vm+HdOiCRjbVtJrMRp4FZkJNzbZR/p/Iwi/tAJ5gk/S4jWFv6rzc9lXdupe6XL9BPZFCSVAHoNIGLGEtJXcqhssGDd6JmrjNKprSq/Huq+SghvGXEwOr7umdWMLL/UPyxb8+cEHhADn0uV44dJToNEXgPP2GuL5c804Lo2dAPncd1usyIcbb3QYKxG2G6950D/wQGM7GenNU3/xnybdkyXLSTeP/9lwstPGcHF1hwi3Wuf5jtQI1FavJ6VPZTun273i24CSfC5OLvFzAmqlUs5NlqStpfyHtp+mNhvGIcSRcNy0chAPYhzGQ3OTkD+P+H6GH+nmrB2NpaewkjPYpTiPBDg6YvLqmU7DWvzZlSBGKOGECdPqrl2CLyVmWoC3FAUa2QKU4DEA99AfJ5xacPEiihONIahzNBy3YxqfN25SWJ8Pl5MXEFbgMGS5Rl73
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2026 01:16:32.6972 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8499a51a-6ec4-43db-3b0d-08de950c7886
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B06E.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7129
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

gfx_v12_0_init_microcode() always loads RS64 CP ucode but never set
adev->gfx.rs64_enable, so it stayed false and code that branches on it
(e.g. MEC pipe reset) used the legacy CP_MEC_CNTL path incorrectly.

Match GFX11: derive RS64 mode from the PFP firmware header (v2.0) via
amdgpu_ucode_hdr_version(). Log at debug when RS64 is enabled.

Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
index a418ae609c36..65f308b15691 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -602,6 +602,13 @@ static int gfx_v12_0_init_microcode(struct amdgpu_device *adev)
 				   "amdgpu/%s_pfp.bin", ucode_prefix);
 	if (err)
 		goto out;
+
+	adev->gfx.rs64_enable = amdgpu_ucode_hdr_version(
+				(union amdgpu_firmware_header *)
+				adev->gfx.pfp_fw->data, 2, 0);
+	if (adev->gfx.rs64_enable)
+		dev_dbg(adev->dev, "CP RS64 enable\n");
+
 	amdgpu_gfx_cp_init_microcode(adev, AMDGPU_UCODE_ID_CP_RS64_PFP);
 	amdgpu_gfx_cp_init_microcode(adev, AMDGPU_UCODE_ID_CP_RS64_PFP_P0_STACK);
 
-- 
2.49.0

