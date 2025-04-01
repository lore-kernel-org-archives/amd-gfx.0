Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF267C36014
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Apr 2025 08:08:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 600BE10E50C;
	Tue,  1 Apr 2025 08:07:56 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2041.outbound.protection.outlook.com [40.107.243.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D0E0910E50C
 for <amd-gfx@lists.freedesktop.org>; Tue,  1 Apr 2025 08:07:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FB14z4vpU+mnrVJN1iissfk3XoF1r7vUob4fI0MpB5AbUUwixYR+n0Knkga4kmANIhzWVmfJfw2rdjRvcerR94LnKESRzcWNPHnp/H8Ixhs0rJiaJKatTWQJNd+EdG4ALyR9ZGZqH9W63kOefKn1+kT4+wYBhzwVCOfCS9tB0thx+UXQGIrQonuf5OOf7t1DNBSpJrJgn9wHdf1jIwByx0UDoNpZ4Y5gMmBgkxKOlbY4LZPBeNUix4AAxQi4yVZJvIGk4wYWLPXxBzTqDppLkPnoLnvJiOpnD+2beNL/m9kk+Qtq7lV8vu8qtlwZrKkHMC41jUyprvUk4RkTJsnmGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NSTtf/aBAPUwflIi84OexD+nPVTBhm6Xxq50sAI+EF8=;
 b=ZZ0H0I5xK6bsEFDvuJbrDZgpxWHJwWLOaMgZCGsJoHXE4dQPfwU3ieY/9FJS/CepGaTJzOZA+AwWrcyUFUTva64iKgHoPhIqjaGusKjD+EQQ8wQB+pzF0mrlnF+NoYSclx8w5/7/QsVdDFZ7iYOy3UeeHq3hiCjbz1iwAJ+Br/9ZVdUECzc8GDTpUF3IfzHK8aTigqDldRsWs7669GCCJa1rk1Zo5Ndk07Z6AxhGgvE4BZgFZdJPC54kXx0DEj18nlASQzl41nS9TMdWYgKwb4RpxbZHfj7XzhqE5oNURzhkP9N/IMoi1JZ3GvugauE82ecNgsLTm0Vsg2ADrnjyDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NSTtf/aBAPUwflIi84OexD+nPVTBhm6Xxq50sAI+EF8=;
 b=Rnrlc3NcTnBdDHzxSAQc9ayLKAj6Zrq28baYkArpbpiC9jjkdIuwG+bpCje92y4h0IykuBRZDmNEYcRRLbe9qiGuIweHd6ZcVnYfKnN+GYForiJJszoU7HIOjkh3v/5BPE96nfYE7fiWs8bKRKIdGmrd7dr7oxYdBgjWqAnrs6I=
Received: from CH5P223CA0006.NAMP223.PROD.OUTLOOK.COM (2603:10b6:610:1f3::23)
 by CH3PR12MB8185.namprd12.prod.outlook.com (2603:10b6:610:123::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Tue, 1 Apr
 2025 08:07:46 +0000
Received: from CH3PEPF00000018.namprd21.prod.outlook.com
 (2603:10b6:610:1f3:cafe::8b) by CH5P223CA0006.outlook.office365.com
 (2603:10b6:610:1f3::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8583.39 via Frontend Transport; Tue,
 1 Apr 2025 08:07:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CH3PEPF00000018.mail.protection.outlook.com (10.167.244.123) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8632.2 via Frontend Transport; Tue, 1 Apr 2025 08:07:45 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 1 Apr
 2025 03:07:44 -0500
Received: from kenneth-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via
 Frontend Transport; Tue, 1 Apr 2025 03:07:43 -0500
From: Kenneth Feng <kenneth.feng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <kevinyang.wang@amd.com>, Kenneth Feng <kenneth.feng@amd.com>
Subject: [PATCH 1/2] drm/amd/amdgpu: decouple ASPM with pcie dpm
Date: Tue, 1 Apr 2025 16:07:41 +0800
Message-ID: <20250401080742.816734-1-kenneth.feng@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: kenneth.feng@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000018:EE_|CH3PR12MB8185:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e377e72-a458-4a85-2441-08dd70f448fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?dVv2W54KJBX3fDf4Z6bUADjjdSdEiXjDH1TrfQ8xYYPz8vPGS3gJFAP7sBl7?=
 =?us-ascii?Q?fS26u2WVyfndnwm6bwqiOR9ZWFW5Zrtq4s0Ak6rC/3U/8Xb69CDBDZog8l7Y?=
 =?us-ascii?Q?Z0XEZzzAnKMsGjF0FJgB1+efWanIAY7L3owBhd3Ide+GICd/Yo+iODITXuC0?=
 =?us-ascii?Q?xnY7Un8nkZvnKdP78qhLJ8l07XhnYfDOonrF508MS/aFmLaFaoZJTRx7sroq?=
 =?us-ascii?Q?0Du+/+J20nJuDgngcAJk3TXRI03qorhvp7loEmKnZ6h6v4NNm9zePWQP4BO/?=
 =?us-ascii?Q?3/wg/SKobajLgvSyQCz7Yusq8Rk/mtNquo1JVB5cjoadIP92D8z3fH2QCMiP?=
 =?us-ascii?Q?Jhnl6Rc2O67AfddNitzmujI4H1WFoJ5yjRAjeWjoFHI+J+IMkKzQ6PtDCsHY?=
 =?us-ascii?Q?CBoNfrz13DQRgAI//zX+hrV58MJAJphKrG/oBX2/UHDe2NiZ1a19kSYnV63i?=
 =?us-ascii?Q?5FR7E86TrKNE0bb6BYW+DKj769Frsxwlm+qw8lXFn8x+ILKWEj9gkASlgS2D?=
 =?us-ascii?Q?R3qe72qk93UaeKwqQj1gxwi26Q3XXfeA2OyQADzfZ50vm6xzwQmV/eT51Sgc?=
 =?us-ascii?Q?GaO0kHEJQE/HySNXC8wKND7bz7zKDN9WmOL/5O9qso8tdn88Y+y0geo2xOxF?=
 =?us-ascii?Q?/PuE3XQVZwNUXOBr/n0jqo1b+DR3eQgTsmdQKuhtcW2eWlH8TLzQIvGzBVg2?=
 =?us-ascii?Q?gOxFB4VFm12Ha+SgjWRJw2qItt2x/8KzuS1l8J4/009L2AVdLqtr4YujJ/9V?=
 =?us-ascii?Q?OM9M+Bvx2/8R0ooS8/JlKzs7KP3l73Q9cXA3fxh8FAgH3297U8fP2H05fNbD?=
 =?us-ascii?Q?dhyxT6p4tBAbcRUACt5foIJM9p74LJcoyeEiIaUMpsgNWM5AjVkQO6FHnj18?=
 =?us-ascii?Q?i0HsRrGpGP1kgVthvET2Zit06uOJuHiy8Q9vne7aaEoTiSbI5t5BxEBh1Re9?=
 =?us-ascii?Q?mr/ucI5tkY3IqhGu4x/nlJ1rpA8H11oEBHGsVl0L8MeNhxPg0sVpEVz/UdLM?=
 =?us-ascii?Q?AIKnvhq5eVEdQrdnacrgxbjCsNiThSt6ZOJ3Bu+PsEjjKhRjPe5KM6OZ7lPL?=
 =?us-ascii?Q?o+hUfnnkwfxqwHb3Di2GaIeSAvAfQlXhG2ZB/TXI0v/5L1brMjVSCM/rPDF5?=
 =?us-ascii?Q?P78W1i/DwyqM+KpdK5x0EP45B0AcU92psFQA4lzTcEqS+StcKwfqdWZYoIal?=
 =?us-ascii?Q?qLjB3xgLLo31Yw5rEB5S4qbP1Jo3VV92+z/klHFUWi1b//rygvmZ7h4BdSLW?=
 =?us-ascii?Q?aVyTABGIQvn/IQYI3UqFtWDnNwkhiUz61vq/vO0PGABCq/E4p6sooWBzrcRk?=
 =?us-ascii?Q?Qmnh57dHsQ0HB98WMRBI86WPtE6aSfk3fX+z0eb1C63VwV8aHUA8nD3apKzz?=
 =?us-ascii?Q?5PEGUg9UlLASr8z/sWWhuM+px9vQyPJCLz790R17S/ACd5xKNcSjOIbIE5Wp?=
 =?us-ascii?Q?rjXTU/7eYEtLl+/q9zg72i4RQ5JjuyZ7EYfBtXUDOqHqAE1kLJajigxfDO1/?=
 =?us-ascii?Q?+dX4B1wu2gFSt/okpNl7VPtc/zvMey2FTF7H?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2025 08:07:45.4776 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e377e72-a458-4a85-2441-08dd70f448fe
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000018.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8185
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

ASPM doesn't need to be disabled if pcie dpm is disabled.
So ASPM can be independantly enabled.

Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index d4b01ef00025..e4793e56cead 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -1897,8 +1897,6 @@ bool amdgpu_device_should_use_aspm(struct amdgpu_device *adev)
 	}
 	if (adev->flags & AMD_IS_APU)
 		return false;
-	if (!(adev->pm.pp_feature & PP_PCIE_DPM_MASK))
-		return false;
 	return pcie_aspm_enabled(adev->pdev);
 }
 
-- 
2.34.1

