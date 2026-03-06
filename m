Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EDA8FCB61A
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Mar 2026 15:40:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 25E9C10ED54;
	Fri,  6 Mar 2026 15:40:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="y7yzh/CV";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010025.outbound.protection.outlook.com [52.101.201.25])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A4E2E10ED54
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Mar 2026 15:40:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VbtgkllsM1uY5W5xjYvF/L0FNMwkB5QRUsJ78p9MY/gAsW7c1GcOPeTHr4NEXr9vVyuBm3BDGj4s7L8oQgjo5Ra1nb1HHAV+z45ZR62NYxhnauduLd5cJQBmJJob1NECNrJmvIeZLcH+JjTVerO0PBSZG+9KnW3HGQvkKKyYWiHWtXnbN/qo/TuINvlAkgssD2V53UeKYf5rcDsSugCfU4bCjYBug8f6ZWcOcuRdOj0UD79DeoDq2YavRRCMwyPkJvSPrb4gpuHQIDgqhm0My529zQKCbuKk5Tq4rNp6tA68XeyYyK6XIkRSpKsXQCr73P8zo/7OjBGNA36tLgLPpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3uahbBglJxy6eVNswVpwXfaG4cnleNhZPnUFVUUTcDQ=;
 b=gKpbKUQHueGP2SkIYEIDOnxmo74atoILG5PyXcqTmpJ6paY+1dG2AN0+3CTeTazJX/e0LIHTclweWh00eirWuSHbIGBywKCjA5O0ktbvyuxw86IfqN3v9d238RjEeJhh2fWZHEW2xDYWwBmlsYmNm/soFLvMAGoQOr2QhMrPsA/363QKPaYVJOVMvs8mdy4YGbRidqlJAj73FOHXc3DsTmraFSuvKE4fvgE/2gQNPPTboe9enXwK57bOBTyVz4iRtX0Q6FFesSU0x50U5pZ2zga7i7WLYqjJ4bnCcNnwmtuUfexJlhtEiDDeMjMrwCDKbkg1YEhWr/mGQuPm1YdfdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3uahbBglJxy6eVNswVpwXfaG4cnleNhZPnUFVUUTcDQ=;
 b=y7yzh/CV+9BArJkT7Wj7onfDtDJ94JGoS2Iw9i/sXpNwsYVbzwoL5G7g0qZOjFvi4IQHsunP92/7+Rp1v7r68eQUKdfVvYrFv4CkSBUdsj9CtNFlmwp4RrN+GbzN9fcYI4CAfrB5f7wqU8h86RpsUyd2e9QRknEpN8jJ9wo8E6o=
Received: from MN0P221CA0002.NAMP221.PROD.OUTLOOK.COM (2603:10b6:208:52a::26)
 by CY8PR12MB7244.namprd12.prod.outlook.com (2603:10b6:930:57::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Fri, 6 Mar
 2026 15:40:22 +0000
Received: from BL6PEPF00020E65.namprd04.prod.outlook.com
 (2603:10b6:208:52a:cafe::b1) by MN0P221CA0002.outlook.office365.com
 (2603:10b6:208:52a::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.18 via Frontend Transport; Fri,
 6 Mar 2026 15:40:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BL6PEPF00020E65.mail.protection.outlook.com (10.167.249.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Fri, 6 Mar 2026 15:40:22 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 6 Mar
 2026 09:40:22 -0600
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 6 Mar
 2026 07:40:22 -0800
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Fri, 6 Mar 2026 09:40:21 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Le Ma <le.ma@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu: update GFX CGCG/LS flags for gfx 12.1
Date: Fri, 6 Mar 2026 10:40:05 -0500
Message-ID: <20260306154012.22525-6-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260306154012.22525-1-alexander.deucher@amd.com>
References: <20260306154012.22525-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E65:EE_|CY8PR12MB7244:EE_
X-MS-Office365-Filtering-Correlation-Id: e2d06f65-773a-448d-2527-08de7b96adc6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: xBgcnYofVideTk5aIR1hmq9LCDCufUGqcdLaJASJG73TYAWkKg8jYQbH+LHwCrk5dWC1gmyD9HDDzjvW1qaZvK2q32YCy2tqOCrfCMr+6JdIqoqGe7++1qtcLnQdgq8IyfjhWBXWn13QPB/IS2tCgplIEQ2kPcSRsCNfYCby0ndQIyBegj8InBQtsgUcJ7pjZEf+48/Vtum2zsYEkYbHr0k5ZtvLb73O/R6376xQbh35NHVV2BpVIBy9y6C4SRWPnZtGpS2aPzTloeD3kr6r7TJDQOxy2MHinV4q14NQa1zJa0GNpn4cr0zTLu1qGR2r4HDctgQx+mKKitn48xbXK5Ucp3qwGbCyBUa3sQd2EwufgczVNGy0flpJtFDFiXGBC9cXDLec91dqZZ/fD/cyzDeCltV7+eqTPLgZvlYgr/P41qxcZ4yWWjuzIi4yBh45T2D5yIcLpSec9kOdorsZc1UR5Sh2mH9Inl7i7ocC8RUmsuE6a+x91kgMmw++Y+fM+L+W71436yp67xMDxAYrkuC4+Ve3QKdpygfNsjKv/+/nUxLSk6vRzH8r6ryVgcjit/SFwwudVEAeMoyryFXaN3sJ4YryRBnkcnzN01bmoFZTpWgy7k0SecNhp4YtY8Z1ORxGtdLi2Ho8DwzH2qENxGPKhTjUzZO3BFPFJTITho3TpDmzDMmHuHKQB/cOxnAx21gliyplIOCNMNiCg7tEwBQ4CrcdUAFyZP4nWD1FKJHEqOk/A/FbabfQzUADCwZ+VkIpC760pTfabBTcNFCH3A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: xSyY5+WjjCLUYNuKKtFYdPuKywn/ql3I5GUdXlmAXubU1nzUnJWemcVp0clc8Be6uH+rZY/IwUCHpx+Ioy5nhbusyCZyRFmXtLPALQ6nO0pU23Bh1g9le9IuRnEmiLrfHfVHY2Ejb1TQgg8O2xxTpI+nhX/Ne9AAGEecOpMmzfu9x/amOdw4dIj6bBf7cF6PZXTG1lcL1DG4XmK8X9LA5TCUlEaY1kqKAwcXLnug3ElFPk3qfkXrNS42okFwo76a86InKhdZTdLmcCZQoxUbsYlIiVkazBf3tZC0CvDSJdN627/NPVUW73AJGJNBtTeCLH3LtegwldYBDMZW6VEGoM8JC8Bklyank7yBrKfkBL3J49zVvgsL7+KJileT41NEYwdDCUO/WgIE4EOU8zwnsgEepMxG8jbwCXZKs3EMSyWvviC6I7CdGOhQJ9/86AM+
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2026 15:40:22.3531 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e2d06f65-773a-448d-2527-08de7b96adc6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00020E65.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7244
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

From: Le Ma <le.ma@amd.com>

Update GFX CGCG flags and fix num_xcc assignment

Signed-off-by: Le Ma <le.ma@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/soc_v1_0.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/soc_v1_0.c b/drivers/gpu/drm/amd/amdgpu/soc_v1_0.c
index 43209eae81bbc..a0e10dbf07337 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc_v1_0.c
@@ -281,7 +281,8 @@ static int soc_v1_0_common_early_init(struct amdgpu_ip_block *ip_block)
 
 	switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
 	case IP_VERSION(12, 1, 0):
-		adev->cg_flags = 0;
+		adev->cg_flags = AMD_CG_SUPPORT_GFX_CGCG |
+			AMD_CG_SUPPORT_GFX_CGLS;
 		adev->pg_flags = 0;
 		adev->external_rev_id = adev->rev_id + 0x50;
 		break;
-- 
2.53.0

