Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E7D2C36000
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Mar 2025 19:09:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CC67D10E1CD;
	Wed, 19 Mar 2025 19:09:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="yv/oLB5C";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2084.outbound.protection.outlook.com [40.107.93.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0BF3B10E1CD
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Mar 2025 19:09:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iBYb38S+4ovCxtML3QoW8SMD2JauyGUgZoLjE8B8FtNk3Gy4RwK8IK7vhQuWBLkg81R0zqWb88qxG9b9lDQBMnA33WSgfbE+6NSJMGxgT0gIs4irfUBhhdRA/DrE3eQoUuQ0qZ8xcwN0uHZBPJcggrWB2MwaqeAT5lFhbURKaiCjQr9/ZW2SMk+L2o16sNOfzjp3fXXks9Q5mq2QQUr4Ox0RCM2fD6D/ELxj85sHUBSEW30liKXUXOrWqXvD4v8uBdtxWGwdqd4PsEyzvWPXT2tv6F6Erp3Z2j2JpIbeRZKscDZmMrUaJNup6zgkXePa8FP3ibsIgnBywO02WLOiug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y7YTMCxtHYR5iBp052HGiWwz7y9DrOrdtfpoGXR2Ygc=;
 b=S9GIUtt8ivL8/B2rc0e12gS/itZ/SAQMLzXLYDviPOWAn0wbio6g2M5GlLsPZb8rCj8VCcZgKbABsc3SwMne5VeOLfNStM7k788bhJ7QsGxLmOt6hO22k/R5CAwUgLiUBtxituBjHbWf12pKs4KTeMaYfIcUnNF8NRy9ryW1XESkvkbR5qUux5FIy26JOxMDA5qK9qgpipbZLOCcncFXDIjOGZEaW0iu+APiJErUmHCpNDpaksasVax+RPBZl+aF31HGAW5yUmO67CvDx8g01d4I+pE5m9zcYIoJZ6eiRwF7QF1sKxGfaKZ2I+KlcLEzkMfyUfIpNPN+Up0hfIME5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y7YTMCxtHYR5iBp052HGiWwz7y9DrOrdtfpoGXR2Ygc=;
 b=yv/oLB5C11S+rOuFPHgdxGXjphYM0i0W0zEe6jiw6gLNhfawTWX+p2lpJzdsxuchVfSdo2Iil4DJ4FwheBYmI0SN32ifdx+PPDSkmFaU4+gmX8zChrgBN92cNHHyOsn78aZnus/iNvrgiOXUkpphSK3l2K6uaf5Pr3Zk14zpTMQ=
Received: from BL1PR13CA0370.namprd13.prod.outlook.com (2603:10b6:208:2c0::15)
 by CH2PR12MB4262.namprd12.prod.outlook.com (2603:10b6:610:af::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.35; Wed, 19 Mar
 2025 19:09:05 +0000
Received: from BN3PEPF0000B06F.namprd21.prod.outlook.com
 (2603:10b6:208:2c0:cafe::c7) by BL1PR13CA0370.outlook.office365.com
 (2603:10b6:208:2c0::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.27 via Frontend Transport; Wed,
 19 Mar 2025 19:09:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B06F.mail.protection.outlook.com (10.167.243.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8583.3 via Frontend Transport; Wed, 19 Mar 2025 19:09:05 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 19 Mar
 2025 14:09:02 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 2/4] drm/amdgpu/mes: enable compute pipes across all MEC
Date: Wed, 19 Mar 2025 15:08:48 -0400
Message-ID: <20250319190850.3899718-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250319190850.3899718-1-alexander.deucher@amd.com>
References: <20250319190850.3899718-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06F:EE_|CH2PR12MB4262:EE_
X-MS-Office365-Filtering-Correlation-Id: 23cb9329-36cc-4640-09f2-08dd671984d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?WDDf31xSIsp6N8JYA7/CYwXLkSYR0CZlEduMlPQkxR2ZiaFR3+RuUIAKM6ga?=
 =?us-ascii?Q?UQFzmTKpZg7BW4k2UQTOJWYRZh7coLOEvuz8qnkHMifSZmgXMy99uxn/H3v4?=
 =?us-ascii?Q?ASZfTT0p/CBiPSmhSNMwN2NUF47JNEFr7otrg5N7QkjbkrJg7AdsPA3AQ4fg?=
 =?us-ascii?Q?KqcHXkvQzwTi4Ixw8c5h6x4A9eY2I6Uxxu913DTllHtA164eayPzIUsj5MOZ?=
 =?us-ascii?Q?9M8MJEe/n4hNU/h/5gFGG9ODirIA7elTluQYDQ/DBd8Nquw1qNLxuWSzCM8b?=
 =?us-ascii?Q?AYHzH2fayEN7+P2luBRV3YSpWhq8/jD5hLpL16nKaDNCy5Cmra6ZXUtSIIQo?=
 =?us-ascii?Q?iLkbYl+SvQTiJfR/3X7TNRwqagTZGvrgxXso30FicwL+J5N88IQsKa07fU2+?=
 =?us-ascii?Q?yi6/NmDEvh9qSqCcYw7gOyGUbtRBbocVOAGENL52huoGxstgeZeJ5PjiajMc?=
 =?us-ascii?Q?Yslgp/2l5bE588jbQ1Ja2wKqbgLOC8m1ngF/jnsZ8iCg/U1DAj1cl9WSyEk2?=
 =?us-ascii?Q?GtPG9IZPu0h9PbP4Q0gai+YrFStSqFEY/sq/LW4idGi2MZi/Bog/I//JP4p0?=
 =?us-ascii?Q?pld+2HccG1fSiYRHBNJDOcglsAgj5Zn9kKvuqp+gXN9mTRtrUcMQdalr8rza?=
 =?us-ascii?Q?JBCCzPIm9lFaCif3hWt450dcV0KPi0HwVyZGssowK0aUr0LfWYKRQdol7jCz?=
 =?us-ascii?Q?HkMP/JpSh8RWWNbrzf9HGOj2xJCv4qRt7KoWI8hwmWSF22uOS3nF2tHgG0ws?=
 =?us-ascii?Q?8+D7SWcfHyzCTlDOvvPyUUzGxBagsTSVoymmWKZ3Uuf/oEoPMuFjxUH2ULKG?=
 =?us-ascii?Q?4hiR5COJnPmf/NlyYpbxi8RoJZc1p75CMaA8q9vMmhHrF+H1HwRWwBBq6Zow?=
 =?us-ascii?Q?+eaXYBZC/y4Kd1CG/p5coESXLFBi6CfFSbjJAP3JpuQjkMPImbYZM4ftwkCx?=
 =?us-ascii?Q?T6awhpT/HmS3/7f5jQkVNFp2mfWLUxStvZK+ou8aeJNYzKWo+4wXcEeYQWkP?=
 =?us-ascii?Q?sUzEFcGS/9NQqZejTPaP12vkKRAjZ/pIKzjRC2vQWCWFvJYzxpW4oVoDPeF9?=
 =?us-ascii?Q?nuA3cLmoQZPbCUvbbJrn7sW9r3Tp9pG8UJJaUXX2ENZ9cQAc0O2qNSrUifYT?=
 =?us-ascii?Q?DTsz2llD0ScqW0pig9Z1RRFFaAv2iWYyUNp8R0QpArR1/1PIEHq24Ru+69kq?=
 =?us-ascii?Q?6q2HWeRXqDfi1cx7o5mw3GFVqnClMErHIUCUmCajWrspm7NBEoN5v6XloAhN?=
 =?us-ascii?Q?Y6I2Cp6hpe8ESa3gGCILcns+SYOnV2ouhPDmK+4sLdBsOY8EPSRjOs2iLig/?=
 =?us-ascii?Q?H5Y7ZaBm5i6lGYuJwwIfyDZNb7t4zhquQWo/iskKXABaJchHJ2QT0tfYV/G1?=
 =?us-ascii?Q?a7btb20ee1Vfyodq0evHddcZn8rpfhjD5A2SNm26gYXUfbWepOoaX5TicmXY?=
 =?us-ascii?Q?VJYKuzKcoefEk09hFXU1zRe2GpIk9UIJAeNqNQncLz9242otA1OS66W4DYCo?=
 =?us-ascii?Q?JG/XxNZKw9IjhIc=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2025 19:09:05.6669 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 23cb9329-36cc-4640-09f2-08dd671984d9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B06F.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4262
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

Enable pipes on both MECs for MES.

Fixes: 745f46b6a99f ("drm/amdgpu: enable mes v12 self test")
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
index 10f14bf925778..ac9b1708e20d8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
@@ -130,8 +130,7 @@ int amdgpu_mes_init(struct amdgpu_device *adev)
 	}
 
 	for (i = 0; i < AMDGPU_MES_MAX_COMPUTE_PIPES; i++) {
-		/* use only 1st MEC pipes */
-		if (i >= adev->gfx.mec.num_pipe_per_mec)
+		if (i >= (adev->gfx.mec.num_pipe_per_mec * adev->gfx.mec.num_mec))
 			break;
 		adev->mes.compute_hqd_mask[i] = 0xc;
 	}
-- 
2.48.1

