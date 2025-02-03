Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7850C02192
	for <amd-gfx@archiver.kernel.org>; Mon,  3 Feb 2025 15:40:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5838D10E4E5;
	Mon,  3 Feb 2025 15:40:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="suipTRqb";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2081.outbound.protection.outlook.com [40.107.102.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B321910E4E5
 for <amd-gfx@lists.freedesktop.org>; Mon,  3 Feb 2025 15:40:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ngqPmhBFBKMiJAEmcSavn8n6HsIAUljekrST5PWueoGu8HUTon1A3t9jYf9VZiPKl67er01nTyzBqjd5qG2hIphrcpxeTZQpPd2+qWI8rZ29txWixbN57Q5m5WPBtEZmJDzP89rQ0vOgZuXkDsi7L3CuoHlODFrqHUYhZAcndjiQqjNlWZ8aTA746QGL199V7YuMl7GT9AE4Wf6wucxSlQYCmximvBB/Q0eqby05lPc7tlBLpubf3TziK/Db+99cmIBalfB7Et+beG48bD/ylEsFgjh3EMIRrs1yjg/GpOW5JbYzkITjWY3EpAakq3j5G65NkFR6+RFUeZCaWiXEQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mA4O718W0aFky7jNO6Y+IlToOwS1bPcKuH4SmrxZWUU=;
 b=ZxqpZEZwqF4R/WbozZYVDkY5ZO1UxNVMT34o43eX1yTmBzQYO6LvLcxM8YM1HlwQ19EYNzz2AslkOBfaxC9q2eWf6gtgi3NPn4R304oX+GDUw/cRY+99hi3DsBg96QwcKEGhN6CqICjERSEIVq8Vu63Xqb7POfuelWO5T4ITNh4DzXYxUlwUCGzU9gTrb8L8rxI+f1J4qR1xpsjhZj/Z6o+KO7Gmz6YiYgDShwFTDW8SSFM89dlwzoS8lxlGWoGQG5vx1nII4FWjeD3d/sA92/sQSOLZto7GHqBbxTlS6WLvXarUiFd15Dd3rTBm9c8TCAcse1aFi4j9R6Mluf2NpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mA4O718W0aFky7jNO6Y+IlToOwS1bPcKuH4SmrxZWUU=;
 b=suipTRqbgmPwJ3cUiXtzb4nTr+2Gi6xIWTFE+MhSV9JOFJFONl8/LkesBgM8vWOOj+CdzCeY57WM8GHrzT+JjjRNxafuVotzyvDHCipbHjr61jwG+qOZlnwa1CatXvu3Tdvz51ZLQ0IIx5M6eEIlGAdWGlLJ6E0IfrqpgWOo6dc=
Received: from CH5P221CA0018.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:1f2::13)
 by DM6PR12MB4092.namprd12.prod.outlook.com (2603:10b6:5:214::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.24; Mon, 3 Feb
 2025 15:40:46 +0000
Received: from CH2PEPF0000014A.namprd02.prod.outlook.com
 (2603:10b6:610:1f2:cafe::51) by CH5P221CA0018.outlook.office365.com
 (2603:10b6:610:1f2::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.22 via Frontend Transport; Mon,
 3 Feb 2025 15:40:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF0000014A.mail.protection.outlook.com (10.167.244.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Mon, 3 Feb 2025 15:40:45 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 3 Feb
 2025 09:40:45 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu/sdma4: drop gfxoff calls in dump ip state
Date: Mon, 3 Feb 2025 10:40:31 -0500
Message-ID: <20250203154031.2824949-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000014A:EE_|DM6PR12MB4092:EE_
X-MS-Office365-Filtering-Correlation-Id: f94ae61b-5a0d-4b00-f5f3-08dd44692049
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?GE3TILDun7PGmKP9qPH+Yp3bMYi1c9i439ZL/Y0PtFa2LoW6/AzSY9lytxf5?=
 =?us-ascii?Q?KyfxUOqruFvyqGfB34RLd23I5EgBGRl4HvKrfW/sBskfoix5AuCeA8HV7Erm?=
 =?us-ascii?Q?XfRmt/Eh1dJFq+hiKSWc0rBq336q4bHtuQJnftNB20HYFbdGc6hgjakgVmvz?=
 =?us-ascii?Q?poq3EWsvUxINOpNMjcJ0iDvEB52a/eCYnOpwM2FWI9lPHeHPM3o/YPe1BChT?=
 =?us-ascii?Q?k4WH/S5FGrNFPHHOkO3qq/X52Hn5DliXrqxOimYLEDiTDF/737aFIu8X9t4X?=
 =?us-ascii?Q?YGcjQiXrsqA9iypMjOIoxlHxT/4ajPZEMo5HfNGDz9YGU6bOKqp6ZV/u7Fgi?=
 =?us-ascii?Q?omiYtQNnxFTRMq9JUH3trsxU3cC/YYlT2SpNbClhmWJwApF7pXueO35iGHU3?=
 =?us-ascii?Q?8aLKKyHtf++e3YjPNXpYZ/XaZAdytaJmycSg8K4XM+ersC/qriTsXTHTTWt3?=
 =?us-ascii?Q?Pp7GpFzFOssRKtR54wyZ4uE16bty3CYcClDVbTQYU8nnwXkKbdUp65O5cse4?=
 =?us-ascii?Q?Wek/inemYq34y9x2jNURMr2Yxb8Y4h9bG+Mwo/qy3Kz2+Z+j49SDrezEYwGJ?=
 =?us-ascii?Q?jUNNknMPlKzKvsM1EFpKsZEUolVWboFMVPBSWlWTdI55hX/zLw2SNuCvf7h9?=
 =?us-ascii?Q?TNz6bqIYC/Rhi/N30FTaAXJdV6kaIGry0wm0hh48hYmrGelxCcqh4LTS/kPJ?=
 =?us-ascii?Q?6dhig1iKxrrt1vxipxSEs/58YSxfANEHJYpuXsAcolI3ZOqRLH45hkkp7s+I?=
 =?us-ascii?Q?ym2dGMPILOrK586H3yNem8eCR2Dkh5GpxVrJL+7Tt1vTNs7+nZ3Elgg/iRBy?=
 =?us-ascii?Q?gWTgHvTrcbQu9m4YDoUTKlcAO0MFyZTmSHxCsqFOWcJsFjyEsFun/5dfhU8L?=
 =?us-ascii?Q?QQHyKkZ3Tf5pr0MT5hl89mNM3YFkR9rSKETfDzseNIOKho/aotDivCoE0AWd?=
 =?us-ascii?Q?SMTPrA99aeoB0bbukg7LtZn/S6firYFsJXJYSP4sJOVZMeTWJcYJ+ZyQmF1k?=
 =?us-ascii?Q?ApC4sPmYF8+PqLmA3q2MGMyZ/HYS35q0Oj6WbWpNoPgu4F3ewAQQcZhsqYeu?=
 =?us-ascii?Q?aVaro0JMw+Scoz3NycNYWvarFKWI7LTKS6aB1USDEUjC2o3ZgeM7WY7todNk?=
 =?us-ascii?Q?bkU+n6DnWpMbF6pwFzZcaM0bMz918In7/mI1oPe4mlh6mIyOO705X5cup7WK?=
 =?us-ascii?Q?pzXMbqvvgdhXUBauinfoUNSXxVExp3m11l42LvQoDEj9Ko3+wXcUXqC2zE33?=
 =?us-ascii?Q?WC1et6FjAowSF8pkXRmKomve9MjCcfkJjdVtUUXded/T1IdKfM5CY+8SIYb8?=
 =?us-ascii?Q?o9YBP1Bmef/pFCNA2vHgWltlhbDNM80N2cu2H5x/lyaiIcpzfXilKGfDBmtY?=
 =?us-ascii?Q?zOT1qiObMQ/YYLFCaIe2RPRH45Dyv0Wm0/KKBMJV59gpfqTE52yD+JR7iPVX?=
 =?us-ascii?Q?BQJgjACXOxOwI+kqsAbHqnpRZaUXRr5ILo9me/z95Ldk75hb6ixP8WEIN9KE?=
 =?us-ascii?Q?G75h3gZjj+l5yrQ=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2025 15:40:45.9670 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f94ae61b-5a0d-4b00-f5f3-08dd44692049
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000014A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4092
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

SDMA 4.x is not part of the GFX power domain so this is
not necessary.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
index b48d9c0b2e1c3..ea42fb10d2076 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
@@ -2381,7 +2381,6 @@ static void sdma_v4_0_dump_ip_state(struct amdgpu_ip_block *ip_block)
 	if (!adev->sdma.ip_dump)
 		return;
 
-	amdgpu_gfx_off_ctrl(adev, false);
 	for (i = 0; i < adev->sdma.num_instances; i++) {
 		instance_offset = i * reg_count;
 		for (j = 0; j < reg_count; j++)
@@ -2389,7 +2388,6 @@ static void sdma_v4_0_dump_ip_state(struct amdgpu_ip_block *ip_block)
 				RREG32(sdma_v4_0_get_reg_offset(adev, i,
 				       sdma_reg_list_4_0[j].reg_offset));
 	}
-	amdgpu_gfx_off_ctrl(adev, true);
 }
 
 const struct amd_ip_funcs sdma_v4_0_ip_funcs = {
-- 
2.48.1

