Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 211D1606A31B
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Nov 2026 03:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=qKDH6HCj
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A924C10E0D3;
	Thu,  5 Nov 2026 03:06:30 +0000 (UTC)
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010002.outbound.protection.outlook.com [52.101.201.2])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7185010E91F
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Nov 2026 03:06:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LQvKzsEsizwsi4Ft4tS4GtKyRQN2BlKkZqdckMyUpKHwS+2ye0yQFDIbEbCqszojZXio7/U3dLWSnv6avvxbzwjDDaYIjWt+/DBkNuViEpdIuXXn6Pt3bh9kU3HVNg76+Pg1Z2Moy0VONZI0l5WN6lGevupgZXU8z3vPi0YHoueblcw6IEUDFlfGlpF/Ojpo6b0xF4E9X7zVDps25VYH3z0XLIEXQDOqroact8Q28dx6j+L6CIzB6Jhppg/hpgEZ7Wggb4H0tDeebbCYgZID+TGMxZHv/yBXXuYKjl+xGINrxABk7NN0fKJJfk/up/ZHc42ZPt4D3Ivtz6uaLsSTCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8a4orZ3RspCANrXIk09qSgCSMjGbHlFCCvtJVqZ4OY4=;
 b=ehUeT2OwkYlgI/p6/xa3AncdBNwTkTzKo2P9/ceeSfq8T8wYdWhtxEQ6HmN6a5N7EdhhyLik4fYr3kzr9+mnRV84N5GMcXfKrqK35a3doN3P5P77H1VEkwQ9+4urzW51DN9w98xE4ZK/4bd8XMUU97Bwk3n56LAndQCka8kRfccguWkksPS4eXCcSD7V+V8RgJEeKQHoDuRh8d+Xdd3hokReu4poolqz0Sb3QGE9SzfETcmPUlH9PV9O7akDyJ785FYTrPyuFghCDSuZWLzVkQWhFg3VPjA8Lwt2am2AAsY2q6jYaBk86oJgYrb8RPGPyTLYPJ2yo1bri9Lg8bGBtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8a4orZ3RspCANrXIk09qSgCSMjGbHlFCCvtJVqZ4OY4=;
 b=qKDH6HCjC0nbGvJQIQm3g8pmKyVJnM+t3XzU6oHxYBEFShxAXbqU8fSIc8tF0jWoOlFuFGwrZpQuH0iFb0dTsQbCrjyWG6b5/SYEGZf9rn8nXts1kjubPmM1NJOOu2J7bWp2KUueErHMJOmP0Ud3ubxzrD4Rx7qmFjUO4iGOwJQ=
Received: from CH5P220CA0020.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:1ef::18)
 by CY8PR12MB7313.namprd12.prod.outlook.com (2603:10b6:930:53::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Thu, 5 Nov
 2026 03:06:20 +0000
Received: from BN2PEPF0000449D.namprd02.prod.outlook.com
 (2603:10b6:610:1ef:cafe::a6) by CH5P220CA0020.outlook.office365.com
 (2603:10b6:610:1ef::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.10 via Frontend Transport; Thu, 5
 Nov 2026 03:06:19 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN2PEPF0000449D.mail.protection.outlook.com (10.167.243.148) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.5 via Frontend Transport; Thu, 5 Nov 2026 03:06:19 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 4 Nov
 2026 21:06:18 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 4 Nov
 2026 21:06:17 -0600
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Wed, 4 Nov 2026 21:06:15 -0600
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 <Lijo.Lazar@amd.com>, <timur.kristof@gmail.com>, <Mario.Novales@amd.com>, 
 <Manu.Rastogi@amd.com>, <Jiongyu.Zhu@amd.com>, Jesse Zhang
 <Jesse.Zhang@amd.com>
Subject: [PATCH v4 02/13] drm/amdgpu/ring: During multi-queue reset,
 only call begin helper if needed
Date: Thu, 5 Nov 2026 11:05:44 +0800
Message-ID: <20261105030612.726542-2-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20261105030612.726542-1-Jesse.Zhang@amd.com>
References: <20261105030612.726542-1-Jesse.Zhang@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000449D:EE_|CY8PR12MB7313:EE_
X-MS-Office365-Filtering-Correlation-Id: 739ffe51-09be-49bb-2b13-08df3ae9c3b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|82310400026|36860700016|11063799006|56012099006|261022105027099003|261021121427099003|261021123027099003|261102123227099003|261009223027099003|261028144727099003|261026121527099003|261026140227099003|10067099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info: j+2axSsLgkUth3ul5BlOZvI2CLsn0pnF/8LKCW8jWuWhB7+aple38bdFGcftUOlwZYis4xPle5fXrYsZ/o2o/gbjz2u7vtfIAdUj8DxMZI9sm7tBJ2uRUbZ6lOOw57neAF3Gxy6R9XXx1AHSEWkermb8gxpEVGukZwS8VbtXpSW96ARDLXetwZLXGhZNP0AhUsgELmzYSEAkb3kqTtfeJ4Ae3u/hiSNZu9ZXJq7b8ChrjkjnqT5R+4ugz7ynyxqBTuchx+/iRYRw7qFk639dyJ1txa43f1v22py84ercEVHll0R3tqMUf9N1IVIf/j1Sr6G5Ceec9ZJg0CU/943XfDuc/e/imC1isyExDcpjTcJnkHOy30witKLVget2vQ49/ZjQEZ3LMT/JzGhFYO+/ybMuoeNZ4kppPPJfXkVMl+6R7C5KOcUznph+heNj5EfuzDb3PT2coa7zb3RbgGvhmv2QFem3TW7dMymiol6l8GYIZKg+5o8x7gQjYrt6Y6WptnmkOP9oyqzf4NX/NVSh4wKumNnSV5Hq5JyIhMZQjwYCVdSYPx8pXKq7weHkbdN8BTeiaBzPngMp5AYxvvi2UYtUbpokuHhEQ3DaXP+89prKn0CdUuLoQqB+Uubr9u7RhdXV2DGiM8Cd31rXFZSpnuHh4tQLW/owB+R0Qa6i3qERkPGgIA9O6JqlQMptxIKI9QctKNBgLMlaukxRbw2how==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(82310400026)(36860700016)(11063799006)(56012099006)(261022105027099003)(261021121427099003)(261021123027099003)(261102123227099003)(261009223027099003)(261028144727099003)(261026121527099003)(261026140227099003)(10067099003)(18002099003)(22082099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: weKdY888J2huj4phSHnjknWG29wwC7/aITfZOVOt6FHzRmJYy++JPqjWC+lkqlSAYBJJW/MSafaBx1+761DRXAPF7gYNFasjxTaCvikn/iLraX+9BGhkm+5SAFx+Uh3x/NjZ5sfi7q/3coFtRrCl+sSQ9TCqGkjsHOBYhCZC7TUWtwTxzdrg8z+p29/qPO6TFat95VuKpk74jg0AHr/yffzbRmRLzAjbZHf5OelQrTUplBU4GnDHM1+/iYOP404kHVCfLhtdlLDpROCL48ynB9Imp8HVxrw8TrV+w9txbl30n9Zz1vmpHaqDOA/TEuAVWQ0dYuyyIqv4fD3vY4Z6/BhNllRtwbVjJ81+xp2lnQyWYWxAoKtTRUNLelLQR/UkCaviZk5Baj5kZc5LXAa5d5NZPAKokmfMN/FBTinmMU3TzAK1Yfzhs6rkvMOx4cnQ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2026 03:06:19.4458 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 739ffe51-09be-49bb-2b13-08df3ae9c3b2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF0000449D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7313
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Timur Kristóf <timur.kristof@gmail.com>

This is necessary to make soft reset work after a failed queue
reset. Otherwise the ring reset begin helper would clear out
the guilty fence and the backed up ring contents.

v2: skip the begin helper only for the guilty ring already backed up by
    the failed ring reset, and keep backing up the other rings (Jesse).

Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
index edae764eb0c4..c71e1c3b6d7b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
@@ -1027,8 +1027,10 @@ void amdgpu_multi_ring_reset_helper_begin(struct amdgpu_device *adev,
 		 * Backup current contents of the ring.
 		 * The helper takes care to only reemit unsignalled fences
 		 * so we don't have to worry about that here.
+		 * A failed ring reset of the same job already backed it up.
 		 */
-		amdgpu_ring_reset_helper_begin(ring, ring_guilty_fence);
+		if (ring != guilty_ring || ring->guilty_fence != guilty_fence)
+			amdgpu_ring_reset_helper_begin(ring, ring_guilty_fence);
 	}
 }
 
-- 
2.50.1

