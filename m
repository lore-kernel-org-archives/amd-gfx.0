Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6AF9F9D0F4
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Apr 2026 19:47:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7545C10E65E;
	Tue, 14 Apr 2026 19:47:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="TuoxWh+v";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011056.outbound.protection.outlook.com [52.101.57.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AE2A010E65E
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Apr 2026 19:47:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hB2TIxOHZ+hlREGh+J8DpwqjwV3Nykap1gNlLmoasjd4WmiSjSNr1NwDF5d2Oq85Sl1gMFckb6o7d3X0rAbVcXxCjapjxfa+SyHTiUdZiMzpbxntegw4FNIdfE6YJ+P2qeSC72P6yqRjYBvL9h4sLTTUg/1dYk4yEPw5pcadNm4K2/wZGxYmcH/x58lolvR1nIF8VySJQuwmHQ2X4gVRrzjVnrPBtrzBF65ukv2zb3KrxoyJXtCVEw3KeBQzOmy/PKxuM6EPRyxLb3jCsRaVkNb+pVLS04YMA5tqf02kXCL/AjNllWGhDVoH7m28l/qGW8Wqe3orxE0a4/icAeAK+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Am8ksLZAGsl8PSKYmJfjBGMoFO7oGx6pyvcQlwN3/f0=;
 b=l6nzbubV9JFrdZbKTGW7gWaxUo9P2DoYZJTIBMhtGJO/GH8+53nv7rTyvXW4j1RgRJLTIrJxiyiErbZ0yw+53xU5RrIJZWUioEyHe666HnX6vtg2NZgxN+A/RioZeafE+8aKmxtHHPy0VLE6SphcZUm75Z1p5NPrjiOEl8Cle4wPLNoUZihHKcjTuDrLBYGdmBJbma4mQly870aOz3L/JYpR5ioB3A8aLhmflUw9jYPwpOdUhioSWn5FUHO7VScTlnWGqYQhBnevaRQAn2cx469bBhvfY/UkG/Sy4WxNRNqjvmJTD1oVjKi46af5dkJOZy+5L+mLACaZTDO60Rtm9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Am8ksLZAGsl8PSKYmJfjBGMoFO7oGx6pyvcQlwN3/f0=;
 b=TuoxWh+vRDJ+wtbe0bo62T26Rl9CWGcMNmkY3IfaeJXxFVG+JLqQ4uXN3X5LRbVjfd35QE+VN0867TV4wwLb3wYhPhejrXFOI0DdsKYkW7IziAYWjBjyvd1UKLGtjvXzgK35u9H+xkTQQJHBE2XZqNZZIgf/L7BQMNXRW+MKM3s=
Received: from CH0PR03CA0415.namprd03.prod.outlook.com (2603:10b6:610:11b::26)
 by SA0PR12MB4398.namprd12.prod.outlook.com (2603:10b6:806:9f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.20; Tue, 14 Apr
 2026 19:47:07 +0000
Received: from DS3PEPF000099DD.namprd04.prod.outlook.com
 (2603:10b6:610:11b:cafe::40) by CH0PR03CA0415.outlook.office365.com
 (2603:10b6:610:11b::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.49 via Frontend Transport; Tue,
 14 Apr 2026 19:47:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS3PEPF000099DD.mail.protection.outlook.com (10.167.17.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Tue, 14 Apr 2026 19:47:05 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 14 Apr
 2026 14:47:04 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 14 Apr
 2026 14:47:04 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 14 Apr 2026 14:47:03 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Likun Gao <Likun.Gao@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>, Alex
 Deucher <alexander.deucher@amd.com>
Subject: [PATCH 1/2] drm/amdgpu: support rlc_1 fw load for gc 12_1
Date: Tue, 14 Apr 2026 15:46:51 -0400
Message-ID: <20260414194652.2213734-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DD:EE_|SA0PR12MB4398:EE_
X-MS-Office365-Filtering-Correlation-Id: 441ec802-7dbf-4924-96d8-08de9a5e9b7a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700016|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: ILn4LotfXiuD5gTZ3AdUnVqJIIhDfDvUHPrkphK52r3AChNw6RdCEQXR3lxg1Iq72FJb11/HoHpz0wEbChfU67cepRID1MrfJ1sXs0MsxOC/srYP99Tr12DA9DytkjO5s9+wdwm2rYR6YOSFire5zd3IT6i/WL+6bpFSNw4d8aQETyzzpii9NJtic7i0zw/fyI/YnhdPnyhuMmXBrD1mCh5mUz1//lEdxcDLMj1apgiE6Jp5MDYkMQhWb/2RM2wXsRMs9+xQKIJMgjBYLK7B3Se3A30zAFLNG9XxFpPKIWDw64+hd1TlV3F6rUSNKFL61X8OaLCN7/P68WSDEC+/RQJm/Nln8EkCMhGGBVDpLMpOirvODpG5aDLpaxlBLW8NtEFuXVpM7lTUbqxKXJkDQxoc9dowoDR/rwcuUgDOwBryEFkMCvgVUMlW6B7Aa2b0bm3erHocZ3U6xKL0R/xEY/8ec//cNkvxeIDEqXHRKjw1Q0aHtc51BE7IeJktNaz1gDufOluxXnkpgsEcIoYupLQdZoboOBAQjIsreqI7UhTSrL8ReSdNJ/tRNl7++ZvRRZ/RNkh1nlXgkV1oCaEYX6ixZo2Li7oS/HpiM5HNLpu06dVJFlCFZd9iGQxpXMa/yWk01qzoALlHWQjVytpvu6s7lYHEExNuXak4pB2q906/MCvnazM3kllKF2dI52SuoP3E+eTsYOJfzss+0RdICYz9odx5Odts3k5qGAZbmKEx164Fi8IY4QrFYUq2+cJHzP5H+x1pN5JZP6Qez26HGg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700016)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: XyhNWELRx1TZCuh5bPfAhxUs18aznIfSEVx5SKUa8STaBD9uCLkR01iKCNI9DD9QmRSs3eZ0dH5sYq52ZlQ4h26R1t+9UYUQ7ZfP8V4/IMprnsuV6oQKOPyTn+XTJi+IbojD0iXVdGIwzxlg8Za0RUvUm8ULBW1Np3PWAUPDprgZIlpTowxgahJMndLz/FOR6S8614v9VTXjqtpJEHTZ4g+SQxFMKJHJtiLD9jor9DKYYOdC1k3jCVRBXLr3Tvb6KhEaMUCNV4k/07BaNvdEjhsRhpwU69s3y/L+BYNvMhXR7SRbF8B6IDW9YUKoTzdbRtoZqHDVkBhVZQq6o6QMQ+nilYGvqxqAAOKUOc5+TCZ9Z2ckwDpxjeh5kJkjuF1KJ+0m/6AqCiHeHPqB3j8SaSyrrD/Ol5PYgJo+RuiT6UAIC8qGgjShBOvVSIlwegFt
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2026 19:47:05.8865 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 441ec802-7dbf-4924-96d8-08de9a5e9b7a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099DD.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4398
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

From: Likun Gao <Likun.Gao@amd.com>

Add support to load rlc firmware for rev_id 0 of gfx v12_1.

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
index 68fd3c04134d8..3bef36f5a487e 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
@@ -61,7 +61,7 @@
 #define regCP_HQD_IB_CONTROL_DEFAULT                                              0x00100000
 
 MODULE_FIRMWARE("amdgpu/gc_12_1_0_mec.bin");
-MODULE_FIRMWARE("amdgpu/gc_12_1_0_rlc.bin");
+MODULE_FIRMWARE("amdgpu/gc_12_1_0_rlc_1.bin");
 
 #define SH_MEM_ALIGNMENT_MODE_UNALIGNED_GFX12_1_0	0x00000001
 #define DEFAULT_SH_MEM_CONFIG \
@@ -409,7 +409,13 @@ static int gfx_v12_1_init_microcode(struct amdgpu_device *adev)
 	amdgpu_ucode_ip_version_decode(adev, GC_HWIP, ucode_prefix, sizeof(ucode_prefix));
 
 	if (!amdgpu_sriov_vf(adev)) {
-		err = amdgpu_ucode_request(adev, &adev->gfx.rlc_fw,
+		if (amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(12, 1, 0) &&
+		    adev->rev_id == 0)
+			err = amdgpu_ucode_request(adev, &adev->gfx.rlc_fw,
+					   AMDGPU_UCODE_REQUIRED,
+					   "amdgpu/%s_rlc_1.bin", ucode_prefix);
+		else
+			err = amdgpu_ucode_request(adev, &adev->gfx.rlc_fw,
 					   AMDGPU_UCODE_REQUIRED,
 					   "amdgpu/%s_rlc.bin", ucode_prefix);
 		if (err)
-- 
2.53.0

