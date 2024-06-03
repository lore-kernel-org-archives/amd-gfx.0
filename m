Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33BF1C27C44
	for <amd-gfx@archiver.kernel.org>; Mon,  3 Jun 2024 01:43:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8E1BB10E224;
	Mon,  3 Jun 2024 01:43:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="tHT7eyXR";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2087.outbound.protection.outlook.com [40.107.94.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1804310E242
 for <amd-gfx@lists.freedesktop.org>; Mon,  3 Jun 2024 01:43:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KZeYOZRdlFh4ZIyFk7niJg3DH1QEdCnvTWpAsM8T+Ak+P0JnHE6FkW3lCuZv/u0MZB8Lf4R27bIjAb1jAveotieJs2//w5N9xJr8x42g61vk172dhraG+5mLGMuFLcYWC+z8HO5dpzcdRuOd7wrXuWlrYqA+iqWLd7YgCk45OhzLB3Bbul/YWfUIpSf63rxgLNoqRt7IBhJpCTXC6sQ50zq3tBn25frLvooFj0F1l375chceW7k7JSXi5z+1CJJ4Q/eJ6Kv4SLL1h205FXAfQn5CfiY00K2othosVos2zt1Nr80oA2d/BWWwMqPLcjEx12pnEVfouhcsS1md5aIGMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=agnTnPacIgbTkNmDeQ1u8sxHqhwRjLWKIicKCAqJjCA=;
 b=H8gW49+98ER5Utf08t19KwaV7LJlPVBW4aEHR+rQfD2liDdfsbOKJxKsal/pY1qTgvjQ6uaaqGfQ6rVsbGW4LQdsF7cmgRyZQmj1UqtchoyakcNvrwkgKqX5697e/nvjA5D5CfJRpG2IuXQtiXgP+HAKAYoQM6T2IPtt/dZd9uEm5x7ToWNUrUddnbRFk+tOisWOqstZLtbIKL/RvGOA3PjUfSwsPAy8e72iq/JpwsvFCJRssa/i8jeiKptI6+3xX+WngBAIYcMsJ1/eRImjn+e/PYY2L993Ts3CiC6R7oLSxpHLPBa6EBs/ZxhgcXiBgcVrCJaKRz+Na+fFKgcOoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=agnTnPacIgbTkNmDeQ1u8sxHqhwRjLWKIicKCAqJjCA=;
 b=tHT7eyXRtDh/5f2mHOJgG0dxzL4F/AD/n1y33j+6NJhio7yRgbcRFj264MfeW11CCFhzTBlS8ObtiOJIlXK3biCFwi6kVHP/TdviZQzvUgNmA9ES/YFD+BtGOv2UIrFKSLRSJ8MLDoQPMRGxliRBt/8oFzbBe+7kM/75RKh/SwY=
Received: from SJ0PR13CA0235.namprd13.prod.outlook.com (2603:10b6:a03:2c1::30)
 by CH3PR12MB8234.namprd12.prod.outlook.com (2603:10b6:610:125::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.27; Mon, 3 Jun
 2024 01:43:11 +0000
Received: from SJ5PEPF000001D1.namprd05.prod.outlook.com
 (2603:10b6:a03:2c1:cafe::4f) by SJ0PR13CA0235.outlook.office365.com
 (2603:10b6:a03:2c1::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7656.13 via Frontend
 Transport; Mon, 3 Jun 2024 01:43:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001D1.mail.protection.outlook.com (10.167.242.53) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Mon, 3 Jun 2024 01:43:10 +0000
Received: from kevin-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Sun, 2 Jun
 2024 20:43:02 -0500
From: Yang Wang <kevinyang.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <hawking.zhang@amd.com>, <alexander.deucher@amd.com>
Subject: [PATCH 16/18] drm/amdgpu: refine gfx10 firmware loading
Date: Mon, 3 Jun 2024 09:42:10 +0800
Message-ID: <20240603014212.1969546-17-kevinyang.wang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240603014212.1969546-1-kevinyang.wang@amd.com>
References: <20240603014212.1969546-1-kevinyang.wang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D1:EE_|CH3PR12MB8234:EE_
X-MS-Office365-Filtering-Correlation-Id: d8d2d34a-39ac-43f7-7f9f-08dc836e86cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|36860700004|1800799015|376005|82310400017; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?LAufOCNjc5h9cxyVTEQTHOvOFJHnYKXvFwUj7BgS65GPmQSL+slOzVeRdV9l?=
 =?us-ascii?Q?BvIvaTFurd6Ty9fo1ODyf4o7i695logXiFUu1dfB3UN40s+w3WyIy6ydMoZv?=
 =?us-ascii?Q?tFFK01gS9jY41yap3YGMLZpns9dS6bp96Es3MTBKHteVy36UrGgY/utirYHI?=
 =?us-ascii?Q?ctdnDqkQGZXxnzp6gMPnVN96eb8HTW/sT8j1fTfpnGwwk63rGH7Pjw/Gc4kR?=
 =?us-ascii?Q?8LQoQH//xNZLRWyb+JWbaPBVF8iAhRp32vzAeJxCdRc+lYvZ1LxS/Dk9mU7j?=
 =?us-ascii?Q?BTeByHCl57C7nU9qEgWaLlaAohZWD0vu1GpwWt2Nq4ui6X/UVntiPiko+hnk?=
 =?us-ascii?Q?KPQdBqxofUe/ZNlcOZjpzOsHD8tC66RvsqdWWZnvfW5FnI3Ja3h28HO4w+SO?=
 =?us-ascii?Q?TzDxCJUyborGycg55H+Iabo2V2iVXfjrWnJAGV2H/1vFvG687ny/WWDm4x54?=
 =?us-ascii?Q?0MUg67jXqAj1P+QN4+2GolFrKqkHi97ufnqqvmOfx4LWHFRJ4Z8a3xfoZ0eJ?=
 =?us-ascii?Q?/HlvU9YHAVJRdXUPwXZ3rM23MuodJ6jat8UbrtnXpkI5pS0QCGg3l6zFwnmB?=
 =?us-ascii?Q?MhWUrS7wgM/4Wz08fhDfrIKnz+HXe8Ng09JvEF6jzSgP252NL8j2GPjBrh1+?=
 =?us-ascii?Q?3QJLAK2LfyOx/FeuXFzbc3Sf++gNlLDV+wbk9QMG00Z2n8RYB8FwEIWMLDAb?=
 =?us-ascii?Q?mg8mMWfIH6AUjfj8pRZKtonCqs8lCtZeEQOGgAHFjLE3dC9y8EEL+v2TAvCs?=
 =?us-ascii?Q?5Vg3CfgaHz11cdnHaLRxrq/oDdCx5aWnzru31Sgmk+ri7nkqdn2+5HxyE7it?=
 =?us-ascii?Q?P6wYKGkvGRyW1J6K3g3zswp5BMOkgT9CbkIX3xqC5r3s1JQkcGrRQIu+Br4g?=
 =?us-ascii?Q?FYSIU29HT/7O5v8Z/IYYSJlxAZ0rZhk+IZYTH5rTVbQNCmVpBgafkJ36zwSk?=
 =?us-ascii?Q?jxBVUApQNzJ/SU0NSE04ZpbHFhS4TqXoJ1zcfyG7coa9e1sDecQojQmKEUVB?=
 =?us-ascii?Q?mj+Fev1/q9dqlHyCHijl16bN8nrHiLDQtaWOQbH677dgXsow9avAizgFTij+?=
 =?us-ascii?Q?zXkrijzCOBGj1CheVnAEPj57QUigrgg9YG/HO33oM0GTxe53mF2KC0zaujfh?=
 =?us-ascii?Q?pXwcL6FWBF8fUluIzomopKz3hHWH6VJn26a0YxvxcCTdOXgBWtS9L/LQ57Nk?=
 =?us-ascii?Q?UIxGNL+KOYbzAv5NcuUFWlUl4rYE9hhTqH/zjWSaGcaSCADAkPAKOqNzxaS0?=
 =?us-ascii?Q?Vxh0uEZPvFnmKVVyDT4P5urTBpdsoauLRV7kiRGVfZir9YI0shU98KwnGFps?=
 =?us-ascii?Q?/ThDyf6KM0elP2cRz4NmmCHAA4NkVKJPXcVU+HSpT+Mp7DlNqDXvKRs8C/bv?=
 =?us-ascii?Q?6feJLZo=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(1800799015)(376005)(82310400017); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2024 01:43:10.9798 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d8d2d34a-39ac-43f7-7f9f-08dc836e86cb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001D1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8234
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

refine gfx10 firmware loading

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 25 ++++++++++++-------------
 1 file changed, 12 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 3b0d8d3af58a..18488c02d1cf 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -4116,7 +4116,6 @@ static void gfx_v10_0_check_gfxoff_flag(struct amdgpu_device *adev)
 
 static int gfx_v10_0_init_microcode(struct amdgpu_device *adev)
 {
-	char fw_name[53];
 	char ucode_prefix[30];
 	const char *wks = "";
 	int err;
@@ -4131,27 +4130,27 @@ static int gfx_v10_0_init_microcode(struct amdgpu_device *adev)
 		wks = "_wks";
 	amdgpu_ucode_ip_version_decode(adev, GC_HWIP, ucode_prefix, sizeof(ucode_prefix));
 
-	snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_pfp%s.bin", ucode_prefix, wks);
-	err = amdgpu_ucode_request(adev, &adev->gfx.pfp_fw, fw_name);
+	err = amdgpu_ucode_request(adev, &adev->gfx.pfp_fw,
+				   "amdgpu/%s_pfp%s.bin", ucode_prefix, wks);
 	if (err)
 		goto out;
 	amdgpu_gfx_cp_init_microcode(adev, AMDGPU_UCODE_ID_CP_PFP);
 
-	snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_me%s.bin", ucode_prefix, wks);
-	err = amdgpu_ucode_request(adev, &adev->gfx.me_fw, fw_name);
+	err = amdgpu_ucode_request(adev, &adev->gfx.me_fw,
+				   "amdgpu/%s_me%s.bin", ucode_prefix, wks);
 	if (err)
 		goto out;
 	amdgpu_gfx_cp_init_microcode(adev, AMDGPU_UCODE_ID_CP_ME);
 
-	snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_ce%s.bin", ucode_prefix, wks);
-	err = amdgpu_ucode_request(adev, &adev->gfx.ce_fw, fw_name);
+	err = amdgpu_ucode_request(adev, &adev->gfx.ce_fw,
+				   "amdgpu/%s_ce%s.bin", ucode_prefix, wks);
 	if (err)
 		goto out;
 	amdgpu_gfx_cp_init_microcode(adev, AMDGPU_UCODE_ID_CP_CE);
 
 	if (!amdgpu_sriov_vf(adev)) {
-		snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_rlc.bin", ucode_prefix);
-		err = request_firmware(&adev->gfx.rlc_fw, fw_name, adev->dev);
+		err = amdgpu_ucode_request(adev, &adev->gfx.rlc_fw,
+					   "amdgpu/%s_rlc.bin", ucode_prefix);
 		if (err)
 			goto out;
 
@@ -4166,15 +4165,15 @@ static int gfx_v10_0_init_microcode(struct amdgpu_device *adev)
 			goto out;
 	}
 
-	snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_mec%s.bin", ucode_prefix, wks);
-	err = amdgpu_ucode_request(adev, &adev->gfx.mec_fw, fw_name);
+	err = amdgpu_ucode_request(adev, &adev->gfx.mec_fw,
+				   "amdgpu/%s_mec%s.bin", ucode_prefix, wks);
 	if (err)
 		goto out;
 	amdgpu_gfx_cp_init_microcode(adev, AMDGPU_UCODE_ID_CP_MEC1);
 	amdgpu_gfx_cp_init_microcode(adev, AMDGPU_UCODE_ID_CP_MEC1_JT);
 
-	snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_mec2%s.bin", ucode_prefix, wks);
-	err = amdgpu_ucode_request(adev, &adev->gfx.mec2_fw, fw_name);
+	err = amdgpu_ucode_request(adev, &adev->gfx.mec2_fw,
+				   "amdgpu/%s_mec2%s.bin", ucode_prefix, wks);
 	if (!err) {
 		amdgpu_gfx_cp_init_microcode(adev, AMDGPU_UCODE_ID_CP_MEC2);
 		amdgpu_gfx_cp_init_microcode(adev, AMDGPU_UCODE_ID_CP_MEC2_JT);
-- 
2.34.1

