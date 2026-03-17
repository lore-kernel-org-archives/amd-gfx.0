Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0777BF33810
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Mar 2026 08:24:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9B51E10E419;
	Tue, 17 Mar 2026 08:24:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="OCiJC4JT";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011046.outbound.protection.outlook.com
 [40.93.194.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AEB7210E419
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Mar 2026 08:24:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dyuzdLoz8FikSWbNrf0/AOnCBEyCgfqZlcKrGa4J9ijVOtQvhZ6cHgb7GSxUPeXFZ8ntmoe0b7yve/WsQDBn2BapAea5HnkMTD0AJU/snGQciSWmirgT2f9qwYuufb2ynSPa9gf8qfh1GTa5Zo0lewpyTu7CWfep7+vHFhn01On6Q9ueKcSkvK+51pg0aSPUmv12hZiVrwslHFNLrPVB3XBoMhiQIasfNso/A2e6GQXRNGmCfVTXwoucGPPfmUl+/EhCdqJj4WY3MMz2KI+Fg63nute7yhXLgkZFG5WObGjP2N3ieP0DlCZT6L/0z2Qu9saXT9fr5lbRQzKtwMaUug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VRmWXXZOAGUIY9j3YZbR5f61QrJBXG852Rbod87vHxM=;
 b=RfgGmfmCHwoOBMJ7zBoijliD1u2y8YKKMOKKl+SNNKg+uE6rAizQHIyucfaXUdz0tDLTfMbCjrgtMMjam/nL9/2JrU0TSpOYJOsKipnuVq3ZvD+Q52iwdnIaYPsn+vOLRZ01T3fE1EMKT0czsaPusxogLElDkmaGHsv+xMsbu0lzbW3d5GBntLqd1ex6SCxjwsP8ZoGP68OcDhxMbC1yvpq1q7OttCmfa1H55cR5YmGHMJXU/6pg/bHkRigIZx/P/GJF06hpF0ihnW+waYoV3C8rlqVwk5rQ2JVbS/FYYROm9T+mNl9T50p7H5lUqW224eGIUZv9wQqBsYBA2hEHPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VRmWXXZOAGUIY9j3YZbR5f61QrJBXG852Rbod87vHxM=;
 b=OCiJC4JTretkwyFi+Xpwpyz/SAb6Z+ScUJy81C47SD6cA88zk06/duuaNE4mccnjrZ+kZ2gh+gpZGiY4sXBVMVMvfQpM4WpF1/QSHEEwtY6ZgWs1LB/XPg7p6C5z/yrdGu9gGnwETnPMCumywAn346laVC6VFLdj2wc4Y/+S0pY=
Received: from CY8PR10CA0018.namprd10.prod.outlook.com (2603:10b6:930:4f::26)
 by BL3PR12MB6451.namprd12.prod.outlook.com (2603:10b6:208:3ba::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.13; Tue, 17 Mar
 2026 08:24:36 +0000
Received: from CY4PEPF0000E9D7.namprd05.prod.outlook.com
 (2603:10b6:930:4f:cafe::1b) by CY8PR10CA0018.outlook.office365.com
 (2603:10b6:930:4f::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.27 via Frontend Transport; Tue,
 17 Mar 2026 08:24:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000E9D7.mail.protection.outlook.com (10.167.241.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.17 via Frontend Transport; Tue, 17 Mar 2026 08:24:35 +0000
Received: from gangliang-mlse-vm.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 17 Mar 2026 03:24:33 -0500
From: Gangliang Xie <ganglxie@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <tao.zhou1@amd.com>, Gangliang Xie <ganglxie@amd.com>
Subject: [PATCH] drm/amdgpu: reset ras eeprom table when it is invalid
Date: Tue, 17 Mar 2026 16:24:05 +0800
Message-ID: <20260317082405.1725482-1-ganglxie@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D7:EE_|BL3PR12MB6451:EE_
X-MS-Office365-Filtering-Correlation-Id: 9322770e-1bc2-4d37-bac2-08de83fe9fd5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|82310400026|376014|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: h/mf80Iv6Lttb8ZKjcojyGCbNpaVkfc6w3FOE9xl1YxF0njT8uWgdPsPciFrbXBxSJTUh0sPHIFKVyi5dVMTpzqD3RQJThDcCGY/sgGNZi/GN5JZTrhJm1C83nruYDxw3a0H629wUmZkwY6s87tt+T3XY0s6Ph/ZhjSiVYw+tgdS3+Msc6rqDYObPY8mZfpEnr/37gGiVLzyqWW4wr4i0dLoYbYEOtQ4gnJciGGrVIfeD/LBykDiTTZoUKq8Z+XxOmMaocq+Dxe/LwpQBuC3tACJWTV0Z0kyaNNxJdxGhcruMxYnX+6chQVG7nKpE85tGbYS1aj8wPHPcWN/qBWLzt1njuIbRQ01n+wukWYx0uJu6xayKG84PSfxGAC6SmIenxuZn2PR2FPMhkmKvZCR0IDW8+Wwn2M8xJQ6IOeZknOgHcczKtJ0gGr8g7IMMd0FDhnU2ffRAFfrSZgo0gEgrDAzspwxzm/twr1TS5aSuZV8RGbmipcw2g8MzJju4qRj2ompIS9n3YE8mnwBT62vITGTvGMLjwnCzbV9Rz/45HNBW9QFebt9MYX5wbcq2XMdUOa6kbld10272b32fXcsvVVdjMDSdusEXQyN8N+YZ262DjdrqBzrmwi5pNPL+aNk6iioxnNHoJrXzrz5FTWCu5rHPG/VSYQnheGlZadbeQ6JPKHGnIsngXh+aWyGIk3NZ01S/eNEiR9HayMxh4l+8GGd2ysHqPXHeBZeWCw2hOxA0aY+y9LaMeb46RWeKiIjItSMi2whIWHF++73DYel8g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(82310400026)(376014)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 0SUOisrqUrNiLknS3CvlbveDCwzzTGzQHKbFF9GVdanMG4uzjDIj9Ct6cE3ymMGwqGw5P8R3eAm1yW+Y0xSZi2O0KsNFjH5rb2QkObqLXslV61ksFM4FhZ6H1QueYTAToAsJVa+Fjw4cCJrY8YYLf8p1tMHVd0r0dIVj9wDoe0d6UPoSeuVC4u3qDIo5IMFpeRcpvCork9994WJWcnYCT/welrfpWcEIeXeAIm5zEzY6T941uA7siEJqJRJL87lWlYmzKHgwxLrI1xT1gRW+JwWsOsRFCgAqVAhaAIgf8sUXrQ2Khq4fSZquvHNcQ+fl3xBXl18glQAMOr7tgQekYCwwxjv6Ys1ysitFpaVQwt5i7+syBHsj7vfasab8NmjnefM5HFVTNJj9fDQWDteTUhxQA+GgAqYqFBAe7ThlPwo46lYdJXj8SEp6sogqcVfS
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2026 08:24:35.8819 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9322770e-1bc2-4d37-bac2-08de83fe9fd5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D7.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6451
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

reset ras eeprom table when it is invalid

Signed-off-by: Gangliang Xie <ganglxie@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
index 6fba9d5b29ea..3e818b411ac7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
@@ -1555,6 +1555,8 @@ int amdgpu_ras_eeprom_init(struct amdgpu_ras_eeprom_control *control)
 	unsigned char buf[RAS_TABLE_HEADER_SIZE] = { 0 };
 	struct amdgpu_ras_eeprom_table_header *hdr = &control->tbl_hdr;
 	struct amdgpu_ras *ras = amdgpu_ras_get_context(adev);
+	int dev_var = adev->pdev->device & 0xF;
+	uint32_t vram_type = adev->gmc.vram_type;
 	int res;
 
 	if (amdgpu_ras_smu_eeprom_supported(adev))
@@ -1594,6 +1596,12 @@ int amdgpu_ras_eeprom_init(struct amdgpu_ras_eeprom_control *control)
 		return amdgpu_ras_eeprom_reset_table(control);
 	}
 
+	if (!(adev->flags & AMD_IS_APU) && (dev_var == 0x5) &&
+	    (vram_type == AMDGPU_VRAM_TYPE_HBM3E) &&
+	    (hdr->version < RAS_TABLE_VER_V3)) {
+		return amdgpu_ras_eeprom_reset_table(control);
+	}
+
 	switch (hdr->version) {
 	case RAS_TABLE_VER_V2_1:
 	case RAS_TABLE_VER_V3:
-- 
2.34.1

