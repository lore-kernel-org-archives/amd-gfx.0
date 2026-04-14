Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E963F9D0F3
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Apr 2026 19:49:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F31F610E662;
	Tue, 14 Apr 2026 19:49:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0H9RwubJ";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013069.outbound.protection.outlook.com
 [40.93.201.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 801AA10E662
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Apr 2026 19:49:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E5f91f17hbqE3rgfs1Q6Pd2soCf0RLTRp56/Qli3xd5f8RHAraTPABA9jdvHV3lNWhj5mf7u7EJAYlECRlfiX6tq6aTDMz0TDx/+D9Zc9Dg6VI0pUbp+7kZHRvvexv51dmhcXnEDOpl76Vrd4lOwPRSmpvfvHa5E1EuDOKq2+r8+ifMSmXG1H2BOiP712fIHMZZnS7T2709LC2QRZR0fB3Wvg82vFa0w75MPUlY+VRl3uoqL8znaHA1KTGJLeZpUcuk9bTJhtA1ohxO7EnqJUlbidZknAqkcZgL5HuRh1YcOCCdln9hzwPls7zc8i8HURtoYCBRWwVvAo2jlRD8S3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pZWBWHayzl10O7I5gTnriZCJIlcXW8Phwtc6b4kEFJQ=;
 b=S9TVDXGVUKW6g0dmJnvh4M+j8bu7juDCqMJLCnQPvQ6Jrf8gcq9SNM5cr3cC02+J05v40JQhUCBKCjfeO48r3WIks57/7hB2bVNybcjD0EXs0MPbrejrz4teWA6JTEepnquxPpkdmoigMeStEn8xqqvzcSF54v4awjlj2fTLXL7l3iL9nTtdnajfiyrip5fklop0IUCDlD4ERLGrP0us44XHn0iIH4qmH4uCuwkKxAMZqklpCPw2GmgZ8rb+23nW2uhLSez462A/2B8AzlsOQvIkI6yJP8uyCQfDtZbZ/kSzn32jEErWRnAKm2+4jhDJEAnhq9W0AVr0s8j1PGxLCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pZWBWHayzl10O7I5gTnriZCJIlcXW8Phwtc6b4kEFJQ=;
 b=0H9RwubJNCDNofgUVkjK3jci9P/jf4wB8JAYYeqEgGSRfVWh56HwVZ7VKEy1/Ci3iPgD8L/8y7vlkIW0ySn6YoQyjP4geGR9sdUeQ1CMGjm5gHsuKwOPCflMWQsdmfMdaumwQDbhY7PGviSe5rwWi/jSdQqJY1u3o6jcjKK3dXg=
Received: from BL1P223CA0010.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:2c4::15)
 by IA0PR12MB8352.namprd12.prod.outlook.com (2603:10b6:208:3dd::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.20; Tue, 14 Apr
 2026 19:49:41 +0000
Received: from BL6PEPF0001AB4B.namprd04.prod.outlook.com
 (2603:10b6:208:2c4:cafe::9c) by BL1P223CA0010.outlook.office365.com
 (2603:10b6:208:2c4::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.48 via Frontend Transport; Tue,
 14 Apr 2026 19:49:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BL6PEPF0001AB4B.mail.protection.outlook.com (10.167.242.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Tue, 14 Apr 2026 19:49:40 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 14 Apr
 2026 14:49:32 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 14 Apr 2026 14:49:32 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Feifei Xu <Feifei.Xu@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>,
 "Alex Deucher" <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu: Place psp pri_fw bo to VRAM on A+A
Date: Tue, 14 Apr 2026 15:49:23 -0400
Message-ID: <20260414194924.2214196-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4B:EE_|IA0PR12MB8352:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ea879fb-39a4-4ba7-a327-08de9a5ef7cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|376014|82310400026|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: cd3RyyqLGuw9xCUyPRlVFHUuGlgco5qQ2ZlxbLlnPZyDRzdMJXT1md+W3yJSz3rNF/fRRcJpDq8WrFIbIEcCn9yZ+hhNRNfstXo5uoUvjJbbKziJ5S6ICLpQuM6cxY0BN+leMWSZJzQETqK9tixRSIoFMnCeIOvs0RTt5YUo/s7f+Sw+hvW8GzMD6NgTPGAC2lPUoNmVZjpIujPYjYybnodoo4lHkgh7zfziFq6PG/msiQf9+L3mEajhnXwLxhS5q93MoqCnd9htjaZI01Nu/zemaRtISUfu6wUimRkDr5KNxyWRkT5BnpC8yXRMrnSaQjBKGpbzI+U0nYUawHzZp9l4fkOldUdFLcos56rJnfRBuKZPFeS1ft1CUlMs5pKBxLEACbzPDTTJ+lHtqroWqd6hnyQbl4QrFmSPCHmuZbEMnnMY26UgrY4xd9BqstFjBvrisg0RtkavPg5k/rn1aoBFNHFUSFr3TwcCSf7lfVZNy6bkX69nqxKKH9okIt214hNLm7XEgDxc8JDX9mc+hnoSVrLp0TysWDGMSaLUFAtBy4xsoKUaEN74KSahIe26g1caCCCpUVHd/nbjEruYRv/3lhD5aL/tw1NHLPOfLcSpz/47eX1RkwBRCWZBtMjrWnRL7+Is/orLz7VpcNdrxhBN96mNn+ufEiyI7YhK/Wz8Ljw1x0NIe8EgJEKQiBaeZ3QIxjU0zy7nXDKLatvMd8Ru5e+G30Qkn8tg3MgcyKFnHCC3/KwFQCLNQtV9Sfdku90Er1M0mAa2ARkUSk5Szg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(376014)(82310400026)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: XK9C277623PAMVWhHiBbjQt8tmxypo2g6fCS7DGhKn80mO44XuXo/QXL9ROSsIGKZ2du2mA+xhslbox8Kp0xAY2BNZpi7UVtcj/Xe1gKq/QKKJDB15SGsQcluEhqMm3Q3Ql7Yb+nwJNeM1T5+AolTej9H7mijlSTApi7+ARSUCnS1S7zjEQenaAAhjZ4qMjWSzEUKBnregpBadSXIt3D0RKIvzJr7IxRXnyUjx7GXISAupKgWa7m4mXs7laJ/Ru2EZvqHNVjlVSjnohaND56U5QzZGtfDuHYGogzNyYVEfFgts+j1RlC921YXOv0z+/B002KNZjjAl8hezszBxxzYZQP2/BORE+S1urO001U0S1gxO63yeaKNsBfJsiq+qmYfm9v/uuBSBMBZht9+hnNS/HRXzP9Tzgazno8LxL5iRuwCtifny8Duvgp++oHY4s7
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2026 19:49:40.7734 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ea879fb-39a4-4ba7-a327-08de9a5ef7cc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB4B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8352
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

From: Feifei Xu <Feifei.Xu@amd.com>

On A+A, psp requires firmware bo be placed on VRAM.

Signed-off-by: Feifei Xu <Feifei.Xu@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index e48903df60118..5563f35e830b5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -529,7 +529,7 @@ static int psp_sw_init(struct amdgpu_ip_block *ip_block)
 	}
 
 	ret = amdgpu_bo_create_kernel(adev, PSP_1_MEG, PSP_1_MEG,
-				      (amdgpu_sriov_vf(adev) || adev->debug_use_vram_fw_buf) ?
+				      (amdgpu_sriov_vf(adev) || adev->debug_use_vram_fw_buf || adev->gmc.xgmi.connected_to_cpu) ?
 				      AMDGPU_GEM_DOMAIN_VRAM : AMDGPU_GEM_DOMAIN_GTT,
 				      &psp->fw_pri_bo,
 				      &psp->fw_pri_mc_addr,
-- 
2.53.0

