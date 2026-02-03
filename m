Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1B33E8784D
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Feb 2026 17:05:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 94B1210E727;
	Tue,  3 Feb 2026 17:05:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Goko/0Jr";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013065.outbound.protection.outlook.com
 [40.93.196.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 227D410E724
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Feb 2026 17:05:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cOrmHD18QzTbR3mZgbR1SupOV3VvNMcKTXJU7DJq/artIlbPaN/uiGo8UlacXJMgOQ8H2yjlZze2coWLyrafmsn0jCHPZFLu8offvvQ9lIMk+tPpKAqsVt2qnKuOlr3a7hfeG3tshiyEG4SOJs3+4Uc+aYU90YOiS6ED9e3Ezz0bsfji9bctu4ZqVFr+ALnwh8QgBtQCtq77oNT3mTPbp99Etj9M0dOfWwfRBwTp3VePNmPVWPaybqhGA74GEdXJt12T6J3YKmmYY2PPwaw70jraYcOBAlGf34v5i80ES5sUo68tSeKCnSP0DQkq+qqRubfKmbrQ91ig/SHCH2NpJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BTjp+fhtiVpYwNzNwb1kYZ8j+alstZbGYbVr4GCKm0Y=;
 b=VcYZFGwidRt/0wJcKG6ItJsDAE6Nh7zhqXWz+4F1Xa7Mh8X3DZBjtvm+RGF/wBxZ9HQoxSfofqmGZI5TmnoFDsMZ2Q6k1BbVGGqE+A/p6ifh1RugzNZBHL4IvdfkG9rKOCoVIvmLzoDkkIHu+Y686m+5Zjb3lpUxpjwoGAow+zCrDlSFLJNivMofI7eMeYMnWRan8HP4BMxJBcf4eUeJ9enZreHNCsEf0HrxvihdkZwx3X2SDc0uX+DhG6jZN8oDqRjiDjloRhBDd3Wsf+ajLbJ9dBPyT+MKRk3phzkhI4ozSS9q681u2PJGyBj66/G7H33d+8GTW5GV4dWMkCAa3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BTjp+fhtiVpYwNzNwb1kYZ8j+alstZbGYbVr4GCKm0Y=;
 b=Goko/0JrUWd2Ta/bfySlF+gSoWUuWyzmj5jzczq+5Alo/QnZhXRy2ckXB97X54DOEFAvEAJlOczlR8o4y6dkJjzPQoSxm31KKciU+JnyWlEhUtaWk9epL2u+nwIV4pKpepyYRMhkoEB4l7osZ+tsWXOujElAUBLRWVPw5G+xSBs=
Received: from SJ0PR13CA0002.namprd13.prod.outlook.com (2603:10b6:a03:2c0::7)
 by SJ2PR12MB8649.namprd12.prod.outlook.com (2603:10b6:a03:53c::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Tue, 3 Feb
 2026 17:05:17 +0000
Received: from SJ1PEPF000026C5.namprd04.prod.outlook.com
 (2603:10b6:a03:2c0:cafe::9b) by SJ0PR13CA0002.outlook.office365.com
 (2603:10b6:a03:2c0::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.12 via Frontend Transport; Tue,
 3 Feb 2026 17:05:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ1PEPF000026C5.mail.protection.outlook.com (10.167.244.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Tue, 3 Feb 2026 17:05:17 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 3 Feb
 2026 11:05:17 -0600
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 3 Feb
 2026 11:05:17 -0600
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 3 Feb 2026 09:05:16 -0800
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>, Jesse Zhang <Jesse.Zhang@amd.com>
Subject: [PATCH 3/3] drm/amdgpu/sdma6: enable queue resets unconditionally
Date: Tue, 3 Feb 2026 12:05:06 -0500
Message-ID: <20260203170506.21205-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260203170506.21205-1-alexander.deucher@amd.com>
References: <20260203170506.21205-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C5:EE_|SJ2PR12MB8649:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e766f61-6d4c-4d12-b8ae-08de634667e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?AqGM5VCDbpEy5rKy8FlzcZ1VKzTvpDWsxAKz1Vjk2eqPdhA6vFJABdE4g/H7?=
 =?us-ascii?Q?vnMn+i52JLQ4d5LmrTAmg0fM//3fV86r2yFpzQ0HCTv4ObqsxJBvPYQvqljX?=
 =?us-ascii?Q?nrz+vtFokoLJ/kgWOp3+XgPdaNWxdZH40k5qBw2ZNyp4GXBU/yK2n+eRNLry?=
 =?us-ascii?Q?01fvnfrf0r9tW10+0D+nXzETCWi30ePC/UOFbvlP6OoYQeCSc4SYjKKJQZvz?=
 =?us-ascii?Q?5nsHPHuFl5JalhPG40DwOdhMnUfCuyrc6Cnv/ELnIEQbJPM8KCq5BD04QTV9?=
 =?us-ascii?Q?Vs8kgoD3Q/bpAT+1DdKvACXILEa8tyAZ3yNXRjWYIwHrGZfh/Zb4VqHk0o3h?=
 =?us-ascii?Q?Xr57LOeCgepHFPBh1vDTBeZ3oFANiPqxtdtYAVn9Ydp216+ZaDOuuQzDU6xh?=
 =?us-ascii?Q?XFtZGXEzC8HJQ2dRiO7UGXS74q65mw3yQeMlAQY2DivF+PU2EmbWGtYztNbr?=
 =?us-ascii?Q?U6CDMBbhotHONLYXHmn5XUZqcBlMnXyFPzIvs7+EYlsN3oj+oM+TjMIkcf2O?=
 =?us-ascii?Q?iPsfNAUX8Cl6yKOX/HXiF5P/X//sUGnlJggecAZR3+AXuHd+IEKq45bux23C?=
 =?us-ascii?Q?qiqXPCxVqNo3s2r4HNfEl4Yx2MqjO8nRgle2IMFnGdMiN6eJfTQAjK8iXjpv?=
 =?us-ascii?Q?omCslt+9BJBB2rpjnBqVHZTiLGPehw/mjTG/OmS/jmC5kaEWcYWdeupAVUcg?=
 =?us-ascii?Q?JZqixAMLqV3srE9znF4enDZITEPb58OfcQvsII7LwBXDK7om15PaqassmL8k?=
 =?us-ascii?Q?GIdxIMC+mf14Kab5o9OHPrlexWvEJOjthvC5L52wfKpwx7PbXjqiCVeUVbHc?=
 =?us-ascii?Q?E/pai0ZzfnJBGSgjUSbpFHxNMChqsk+JeuLeha7vQVmdkDncwelAdbrb4Z4G?=
 =?us-ascii?Q?s2L/kc+hQ1+5xNMm0b2jc+CTuvDQkH8kfgqDGRVLTJkQzypoxmrr6nWtIs7K?=
 =?us-ascii?Q?VR7lqf1OEltLdvUX7uspFNEdrx57uHbo7/sTCp+22PKb7b//Wr0J0WZzEFSr?=
 =?us-ascii?Q?5b4tebXI4SoCdnOkM1neSY5CXxS3L7VaUVpY0d9F2WQswRzDrkDveTmnxl40?=
 =?us-ascii?Q?RWsBrSH2Obhm+NrY6RQ1VzhV+6Hy2WVn3o51nfbrP95tuWh3w4R4SE4Fhhcz?=
 =?us-ascii?Q?V2YhLampaoWNb2e2ZA3ZmZAlYZ9n8OeDWp8q/AhZH5fUaBCFH2GllhuOgU1o?=
 =?us-ascii?Q?bcaC8qhTow3fJg5643dZAQy4/ElJVkb/R0ehbY406gZV3/sa4xL6C7/ccFfu?=
 =?us-ascii?Q?O3haFG6+wp170AfHAf2TuKNiWXlY4DcdSM/TaKaGJLFmkown0FpiWbm8yGT/?=
 =?us-ascii?Q?ibUCvZ9o4wppq3onaU8UMgsT63nA8syZCBWP0eKc/fT2juxhLwu414wlWQPH?=
 =?us-ascii?Q?/uLTAjnjwdDd7eEDrhFXb4kpUCyLytBaMvU7Y7c9IqCoyDaNvWiWSaKm1BAh?=
 =?us-ascii?Q?EIxvSaFzEX+3tVOGjuqn53FG+K057Xf4EzZ6dPpkiaAbbNRo1EFYWsLpJf9f?=
 =?us-ascii?Q?qSjpkxu8R4oRWO1PkVRr9Vhaau3x5eePdRmnzzAMDA36leZ+r+oXJ0pOXxHK?=
 =?us-ascii?Q?TgDfGZnmjZQ2KwU9Od1k/HF58oA3KW2TZ131Xr1FW/C+ZLejAV+vPQ9jB1yp?=
 =?us-ascii?Q?nnWtWhYyxjgZdsLpnC3GIjcTVWtxkJOXJazhbrWpTPTssQ1UhIVJfTuDspJe?=
 =?us-ascii?Q?GsX75Q=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: dXqx3h3ToJ6FdaXG08lLXzxd09SB8lsY8fbBWHZxP6IzISsWKA2Q5FwL3HjfDt7Oi+NYXAiyJ3sb54U6jLTAgnHf6Pggl7j+PbNiL6e4XzmSJxMekqX1JmSJVjuwUl56fGxD+fIm6McDyJYbGyUvsDzEnE7ogU6QWJaXCvL8bfrpjl7z6AeOxO+hNyoynvkjxZ0/+51aclQUUC9enrgnEj5d0AhwqYGKrHkXVVmOEssSlmBA0xaBZWMROMv4FYkr4jCPC8fuM9C5KpmrXjGoWL0UqjaHHoZvc00l8dh/3g9AhJ/WmB2YGZ0uiV+9e8Ebdx+kkheFptjgJaPxI0f/Dgsa8MT5j9aP6oVTYJ+S7pt4FIz9ELHeKlpAEyD9GpkZlu1AkuLpRe/JDPwuk43gaMeh/+/M6vk5C1EaEI/NB1vf2o7zbWtd1bBz0/AHnY55
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2026 17:05:17.4366 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e766f61-6d4c-4d12-b8ae-08de634667e4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000026C5.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8649
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

There is no firmware version dependency.  This also
enables sdma queue resets on all SDMA 6.x based
chips.

Fixes: 59fd50b8663b ("drm/amdgpu: Add sysfs interface for sdma reset mask")
Cc: Jesse Zhang <Jesse.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c | 15 +++------------
 1 file changed, 3 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
index 210ea6ba6212f..6070345ed91ad 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
@@ -1368,18 +1368,9 @@ static int sdma_v6_0_sw_init(struct amdgpu_ip_block *ip_block)
 
 	adev->sdma.supported_reset =
 		amdgpu_get_soft_full_reset_mask(&adev->sdma.instance[0].ring);
-	switch (amdgpu_ip_version(adev, SDMA0_HWIP, 0)) {
-	case IP_VERSION(6, 0, 0):
-	case IP_VERSION(6, 0, 2):
-	case IP_VERSION(6, 0, 3):
-		if ((adev->sdma.instance[0].fw_version >= 21) &&
-		    !amdgpu_sriov_vf(adev) &&
-		    !adev->debug_disable_gpu_ring_reset)
-			adev->sdma.supported_reset |= AMDGPU_RESET_TYPE_PER_QUEUE;
-		break;
-	default:
-		break;
-	}
+	if (!amdgpu_sriov_vf(adev) &&
+	    !adev->debug_disable_gpu_ring_reset)
+		adev->sdma.supported_reset |= AMDGPU_RESET_TYPE_PER_QUEUE;
 
 	if (amdgpu_sdma_ras_sw_init(adev)) {
 		dev_err(adev->dev, "Failed to initialize sdma ras block!\n");
-- 
2.52.0

