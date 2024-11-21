Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A578D6ED2B
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Nov 2024 13:33:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 046D810E940;
	Thu, 21 Nov 2024 13:33:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="S88m7ioW";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2041.outbound.protection.outlook.com [40.107.94.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 78E4010E40A
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 Nov 2024 13:33:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QvZvjuvcVdkyKBj733rde31x+J3MJ6LhdM6hBgceEGy3TV8VbrXc3zI2sz/qeSbdgQmsDzTjY3Ymccx6121Ol8sVzOx1JjmUDyHAqGIRaXjm1lruccUtnvftXKdRzzFM8iiVxmMpd626hl1yvZoZjb9cFz0/Hjyot+gWOBLp+t/0COi+5sLGYBk85QekYB2TLVlZrOWwG+iitPzL2SZjvZyg8T1CZxqS/G4Cw15z/HGLYODx/3Gs1/MdC/8brvz12P3J6aYsO9U/cC4u68UK9fYwoM5w2/FRXE/ldMGmspSJ2OIJuzFpXGCpAn+CUgOm6FTbn8fqq7Kk70swyiFHtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+yc2XFMhdNNEW0MWXxWmBV7RyeM2Ii9JO9ica/IFVYE=;
 b=g7v0sE6gMVGWvZSPgMjus5lAk4PB5eSCxU++OHICQNc695do/6aV0/kjFZ1z2VEqenWZf19SHkLCLy7SQyzxecTG3DTp3Dc1uoG7NEuVYM9/UR9a1AsMPgfD8qYMw8I5j0xf93VbmgDVCVe/KUB350JiJ15RIfeJZUQbaIjGyEHyzAwkNFsiy5LeORCCg+ZUZuVAkATZMgnNtY4RdoRcZua89kkGdsR6REcD66/8JH2d5FWLYxe60j6ZZylMid78DW96Nake/NGIuPQnI5g7iAy4118JQKvo9zqYyFolkAEp2JFAqQozVibgi/knX5F3xFN54rPSjD13V35anRO71w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.12) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+yc2XFMhdNNEW0MWXxWmBV7RyeM2Ii9JO9ica/IFVYE=;
 b=S88m7ioW3ps/muSLWlAzQTKPaP5X9svWwaTmlQ+67jv0FdPCuVw5w/xVCHCmi7ixpVwX+6FNfU8XRJhIHVQlk22vV3+5K1W6TmI7iuCWGEkT4/DiSnZmrkQ1og++UND2dxru9cNF+eH2UPAsKrdGxKkmEqZoqf7JvNf7ZiHYbeQ=
Received: from BN9PR03CA0347.namprd03.prod.outlook.com (2603:10b6:408:f6::22)
 by DM6PR12MB4436.namprd12.prod.outlook.com (2603:10b6:5:2a3::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.27; Thu, 21 Nov
 2024 13:33:34 +0000
Received: from BL02EPF0001A0FB.namprd03.prod.outlook.com
 (2603:10b6:408:f6:cafe::dc) by BN9PR03CA0347.outlook.office365.com
 (2603:10b6:408:f6::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.24 via Frontend
 Transport; Thu, 21 Nov 2024 13:33:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.12)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.12 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.12; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.12) by
 BL02EPF0001A0FB.mail.protection.outlook.com (10.167.242.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8182.16 via Frontend Transport; Thu, 21 Nov 2024 13:33:34 +0000
Received: from MUN-L-SHSHARMA.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 21 Nov
 2024 07:33:32 -0600
From: Shashank Sharma <shashank.sharma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>, Shashank Sharma
 <shashank.sharma@amd.com>
Subject: [PATCH 2/9] drm/amdgpu/gfx11: update mqd init for UQ
Date: Thu, 21 Nov 2024 14:33:00 +0100
Message-ID: <20241121133307.594-3-shashank.sharma@amd.com>
X-Mailer: git-send-email 2.38.0.windows.1
In-Reply-To: <20241121133307.594-1-shashank.sharma@amd.com>
References: <20241121133307.594-1-shashank.sharma@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FB:EE_|DM6PR12MB4436:EE_
X-MS-Office365-Filtering-Correlation-Id: abf9d40c-3fa1-4f67-9f30-08dd0a3118e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?FmjmJ9Kuxsm6Fbq9q26XcH6H+N3367fdd976XFQlsBeg3pfMmClcNgkGNNdD?=
 =?us-ascii?Q?g1wRpIVVjMiI8hCs/+3rtRYIp4F6JE+j1K2FNOIDQWbKXYCT+GHgfgEzfVGC?=
 =?us-ascii?Q?egDcc4EmqJ3r67DSaTVlNZLuDL/+8x15t39K+nevhRJeIwOfixiA6DZ9ebvR?=
 =?us-ascii?Q?QyT8JeCZUEwumEChpMS/sO/o9/hoV7X0OXdf7Ygh6m6cr0rGYabYdkxuVtmn?=
 =?us-ascii?Q?p8tu75f8mRW8wHvxH1/Q6Zje3JRfX/yvxRV4vBdxPhUbZBopibRXmgSGnlDX?=
 =?us-ascii?Q?/aVXrMX76ZiYSbacGOSbZCfvAZojQ2bxNADPiq5WKIgauaeMhBGLjVeBQMAl?=
 =?us-ascii?Q?KF2OP+wqYak8Jc/LCa6aIEJm8FpX/YcJVudxNPsTlXu/uLhJuJgxuYs1QMP7?=
 =?us-ascii?Q?lrSaVgb5Oavz9qKER8/OzdypR2sB88UCBcxhLhhmw9tSut/c+o14MbKURXWb?=
 =?us-ascii?Q?NxNPcY1GRPoVZQGH8u9jpnzYgIvY9ywzbp74QlwkSA+emdfkpuRMts+hs0R0?=
 =?us-ascii?Q?4pS9TSoukTUc5NmXpkkl5vjewHWpj4r75kiwGkdamsx+TRd7QMDQsW9Uo5T7?=
 =?us-ascii?Q?EVDBz/tmBjXs8SBRSCkYMWAWmlrLDmVoZwDiWjT0Rixe0ZstBpLQdvNwxasL?=
 =?us-ascii?Q?HRUBFJF2+w6kmB9MROY9eIUptYZVQCtagUeRncaFYH+VgtfyT5rt79e13vlY?=
 =?us-ascii?Q?jb3frsh/kPoyFZDdaP7YGG4kyuSaY3s2vV7wCzg99iRVdmkuIqSuA8NcdWUh?=
 =?us-ascii?Q?j6DLgfYAQAumNFs0SzCKL5DOlt38IbCvEdRNYFVPfmPxbsyKohwRmjNRh7fk?=
 =?us-ascii?Q?Jkqzb3nwOSU2tbuzMDuxEnawUfRwgT49dp+/n/0gPFDV62KQ21ZTGd/BWpjL?=
 =?us-ascii?Q?gj+S8JYAzwOD2TjTjWLaWqFuT1l+MRjLBhAntpOCIslJ+Fel5rM6yAfmTapk?=
 =?us-ascii?Q?FdTPLhPyAwJiD52V4G7vDmotUbj8m5ECDL+NeXwUztOvKnsVotP0/y435YTt?=
 =?us-ascii?Q?N/UZzGgEMh0MzcxmTsD9i7rkjoUenuqrm460S2+gIyfqVnqSahLTwM4Zzn8T?=
 =?us-ascii?Q?ImnrIMhJ1qEbV7Cgs0Xy5e71Fps1vA7bKRU+eGAReiwKlM4VAvfZFUzlOerZ?=
 =?us-ascii?Q?ohJ+a7sRip1UomZwLJSn0vz541Ho3hqktH5O5Bx7HZHT7z1aPfRBWUhYrPRw?=
 =?us-ascii?Q?eknqDWD7GCaeGm048LKUvJfkeraV3dEIHbKsrGUFMOkgbE9Ae06PXAGnvzkx?=
 =?us-ascii?Q?KFSqJbAQgP51CBfzYWSjuDRp3DyeOGHyxHsrf/pJ6Km1JPvCQG5zb2SyLz3F?=
 =?us-ascii?Q?uDtx9GCtYGDYG7EgRJ3O3ZGaCUkcXniQjFteDVgKWG3M7NAC/2grWC807ltv?=
 =?us-ascii?Q?6H+k4sJSe88hSz/qDQAB/jn6IpgZ1p8kUV74UC2iroA5IFZ5UA=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.12; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:atlvpn-bp.amd.com; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2024 13:33:34.3139 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: abf9d40c-3fa1-4f67-9f30-08dd0a3118e6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.12];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0FB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4436
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

From: Alex Deucher <alexander.deucher@amd.com>

Set the addresses for the UQ metadata.

V2: Fix lower address (Shashank)

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 19851cbc00fd..5b9005e39b92 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -4051,6 +4051,14 @@ static int gfx_v11_0_gfx_mqd_init(struct amdgpu_device *adev, void *m,
 	/* active the queue */
 	mqd->cp_gfx_hqd_active = 1;
 
+	/* set gfx UQ items */
+	mqd->shadow_base_lo = prop->shadow_addr & 0xFFFFFFFC;;
+	mqd->shadow_base_hi = upper_32_bits(prop->shadow_addr);
+	mqd->gds_bkup_base_lo = prop->gds_bkup_addr & 0xFFFFFFFC;
+	mqd->gds_bkup_base_hi = upper_32_bits(prop->gds_bkup_addr);
+	mqd->fw_work_area_base_lo = prop->csa_addr & 0xFFFFFFFC;
+	mqd->fw_work_area_base_hi = upper_32_bits(prop->csa_addr);
+
 	return 0;
 }
 
-- 
2.46.2

