Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 711BEC021B5
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Feb 2025 14:49:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1C50C10EA7B;
	Fri, 21 Feb 2025 14:49:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="IxQUtmju";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2041.outbound.protection.outlook.com [40.107.93.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4B07110EA79
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Feb 2025 14:49:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a9vPbaxwJKW+poOt4txgsEz4oAxoH5k0srSRGeuJhEVCn+xFbyfAktbbcIkdhnOOidS11MjPTzSyyfLD6scDoyChUtozTJmX9HdtqRW/Du491S+BZ8is1k/ZNemgQV0VI8HsRVCWtvwKhYjaNspZ9dys4+RX0dm0zwpUuPEno4x/CtwKJryMmY8xMJGWYmo6U2rsxU7SSDiW20sHnPJA2PBeibZTOzqrtgcRrs8P/VrO/Nyic5chO44f1skhDh54wIXrXS60HMKr3yUi6vPHWxz+kXQBpCf/AzuTVicq3q3LRMHWIicuIVuBIEsSV80t53dp7OVOmLCk4afUGyTJfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SCymc6jXRuVq+ln3kFsQdNwrlgYgc/SPAynlNSe/Z/M=;
 b=NdLCLN5JWpReLyab3QBIzRiMguL96plRPNalvBDylxvuQPAbA9hyCNkSRdmuDgm4ykBM0QgbDB49VwdXrGCGsgJYOITGfp/7YRgrgOfRNuHqEOEmI838GktfpRMma1RwOTSbgHaz4hVKZLJBxJEvXVjM2YioeeZmqeZ+86laPRV7JGdvEW6Nz4kDQSomWCNJ8vLhuG89fXCHjYFqmNzm+gLcav+JjNWYp7/QLysR5LoiWb3cSB/EApgjPPtlCROpThDENbNfIJA8+vPMIH+kwpwvSUVyaoCcZz8q0etJc0aGLnj+xuWQmuvYkY3fjMs3LeJIsnypyCAcjp/usQvu/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SCymc6jXRuVq+ln3kFsQdNwrlgYgc/SPAynlNSe/Z/M=;
 b=IxQUtmjuyIOYAhQmF1SJmEL9hIrNFzmBMpDh4sJ6pEfv3Ez7Az5RvCvL/7JhHVMyNLb+t6+k/khvLwnx4r0avSAjbLR1uZvI3JnU2MgCV0xwhTlLn5tlacwqH7lf3pQiCdUQ7UiVdUr2CGwU9qQUtXEmm3JZbj92V+8cp7odwm8=
Received: from MN2PR18CA0018.namprd18.prod.outlook.com (2603:10b6:208:23c::23)
 by MW6PR12MB9018.namprd12.prod.outlook.com (2603:10b6:303:241::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.16; Fri, 21 Feb
 2025 14:49:49 +0000
Received: from MN1PEPF0000F0DE.namprd04.prod.outlook.com
 (2603:10b6:208:23c:cafe::56) by MN2PR18CA0018.outlook.office365.com
 (2603:10b6:208:23c::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.16 via Frontend Transport; Fri,
 21 Feb 2025 14:49:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000F0DE.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8466.11 via Frontend Transport; Fri, 21 Feb 2025 14:49:49 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 21 Feb
 2025 08:49:48 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 2/2] drm/amdgpu/mes11: drop
 amdgpu_mes_suspend()/amdgpu_mes_resume() calls
Date: Fri, 21 Feb 2025 09:49:33 -0500
Message-ID: <20250221144933.3440420-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250221144933.3440420-1-alexander.deucher@amd.com>
References: <20250221144933.3440420-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0DE:EE_|MW6PR12MB9018:EE_
X-MS-Office365-Filtering-Correlation-Id: 12799411-9256-4339-eac0-08dd5286fdd6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?9kveNctEL1DNwueDubW3uUYOnQlvoNdGsaLobJVU9S3lcRDY+ab5pGDS9Q1S?=
 =?us-ascii?Q?nhbrHimJuSykT3ctvU5ymDVC7MzhpW133H6OC14+V/WHpZ0xfHNnTsOwXtk5?=
 =?us-ascii?Q?g/15XXeBHOKNum9kRc9hSMOCIIxKtuSkas48yR5+RguHxgs6gI3U7C550FjJ?=
 =?us-ascii?Q?nS0mFYcFkOYycZP9qPUZwoYkRkjfywNqBZ6PMBvcV/hpVLQQ9UyWjXVZiWLU?=
 =?us-ascii?Q?I+VbLD6xFXTfMS6aYbytMQac98kudCreSRzo6eutAwvr0oUh8VU1lZtCiRHN?=
 =?us-ascii?Q?TwWiKmxQRRsG9pu+lFHG4w6GhY2w+fpb88lJe3IuWGozzrZiDKjtl5e2Chfp?=
 =?us-ascii?Q?HDKvjvLzgZx5ycz9Bpl889g/KUaYN59I4KyOI9WSWxq7La6R+bOnxbzDJArZ?=
 =?us-ascii?Q?4EfmC3DRuGAjSkNciAAaoKbmsSIKh5/ypJWPNrTg9f+v39mkKWxIGqJPEy7F?=
 =?us-ascii?Q?aMsRMKis/IdvnF1KU5kKaVEgHoyo6CQCypDh/JO9QtbFzq5+9hmg+LffSOqI?=
 =?us-ascii?Q?YLD1pAK6sb+HXgOZllI3qg6qOrFvHevivKzc9t9ibby5sr1gLxYh+aIz95PR?=
 =?us-ascii?Q?g1MeAcx0q7GMsuTxhRahiNpHEX8p3/sq1fSPBpoUIPVYRtQNCIVlznx8uPCV?=
 =?us-ascii?Q?nyEFoR9tEArLZCbqul2Mw29bYbOSH9O7c5rdVuXwc9gXhzKVbO+AeJvuKeKj?=
 =?us-ascii?Q?Mz195kA7tcaKLrEhk7fVLRwU9LYcaSuFYxXCiNXagvC6lXDW/wLEiCOnUNvW?=
 =?us-ascii?Q?osvX/VMSsOo/e1J94QCRtI2qWu8h4UdJuZidNVb3DOuM5ieENHTDGXqWTZz6?=
 =?us-ascii?Q?J6iqvXBmzWuOGcmJLAYq5JmARjv9zYI3iLeR1wg4EFU3VZMgxZfGwFGWPhyf?=
 =?us-ascii?Q?svzDj3Dd0F3WMCOIs9rdE1i37q4BxwfiFpVM3LtFrbIt8JnU3bdlnQ61Vnd1?=
 =?us-ascii?Q?nHwcBTaMOjYhZ3qkMQ9UEUQpTiLRaQ7Uy2c8pLTo1RnTBej0vky/ZNDIYxss?=
 =?us-ascii?Q?YESk7wZm+smly0MB8vXGfpaC2Ci/R2W+58KpcW7rnx2TuuItUU+RGNI6P6Yh?=
 =?us-ascii?Q?lNL2DWQvI7SI4a78UlnasIMIQrRYa8cuxExGiK6kAdMz+sTxMPmdmvGOlgBf?=
 =?us-ascii?Q?aNvofEdanvOPXIqAWQpfHIh+SFbzZQnR8HFFgGIpOw2YoIZzqeIz5khm8rk4?=
 =?us-ascii?Q?t9w5rBM/j+oBhGlmvqsFmic4bi5+ux8hnWy8t5JsiCINEwKql6FIka9T4HKF?=
 =?us-ascii?Q?uVsyJ1624ekc1ut0T2EPgwHtg7DiT6+7ZUQoMtrWHj77mau/JiYBl0JtCvIs?=
 =?us-ascii?Q?bCBaSmiGxqwyMFAnwgZLSmxDntdZVrafDUOcKk43IVm0Vt4ZUEWF9IHrQ/ob?=
 =?us-ascii?Q?QZ+qgsl/BdxS4mVS7KgIvjV5ZHpkZPNhRqH8wT6hpyqAfEgPGjclPVKQYhU2?=
 =?us-ascii?Q?GqxTiui2LiiWL8TdStBfgaPnvx/OAjDtFEHSTErrBEwjkjW/jbwoLQlQ73Jo?=
 =?us-ascii?Q?s3smWQjNwkNZsy0=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2025 14:49:49.3825 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 12799411-9256-4339-eac0-08dd5286fdd6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0DE.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB9018
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

They are noops on GFX11 for most firmware versions. KFD already
handles its own queues and they should already be unmapped at this
point so even if this runs, it's not doing anything.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c | 14 +-------------
 1 file changed, 1 insertion(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
index e8aa28184bdd0..a569d09a1a748 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
@@ -1685,24 +1685,12 @@ static int mes_v11_0_hw_fini(struct amdgpu_ip_block *ip_block)
 
 static int mes_v11_0_suspend(struct amdgpu_ip_block *ip_block)
 {
-	int r;
-
-	r = amdgpu_mes_suspend(ip_block->adev);
-	if (r)
-		return r;
-
 	return mes_v11_0_hw_fini(ip_block);
 }
 
 static int mes_v11_0_resume(struct amdgpu_ip_block *ip_block)
 {
-	int r;
-
-	r = mes_v11_0_hw_init(ip_block);
-	if (r)
-		return r;
-
-	return amdgpu_mes_resume(ip_block->adev);
+	return mes_v11_0_hw_init(ip_block);
 }
 
 static int mes_v11_0_early_init(struct amdgpu_ip_block *ip_block)
-- 
2.48.1

