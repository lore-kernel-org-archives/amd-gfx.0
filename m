Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64A3ACD98E0
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Jun 2026 23:57:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ECA1B10E6DF;
	Mon, 15 Jun 2026 23:57:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="dBlgXd9v";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012011.outbound.protection.outlook.com [52.101.43.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D61A910E771
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Jun 2026 23:57:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FA1voRYmptjYpDTmJZIZdwwZUvZqGzhmo9fmzQC0/TwdHQMwyfdVWOXj1V9zsNOzsVxJ0TgRgmJtcMtTxkaEhtS4nvNVEo/ehgcfx7/rgHvBskzvByAd3rDghzgHEGjsOQe1OR6sQZmXzHX+SEbCrqXus2PEz4KMzhjjunPMoVReAyT4udNa+vUCVtf+P25PrI6knXBeDzAUcNusnvSg2TRf68hqbLQ85AfDEJID3NDiOVYC6NPSVLrVsCLKGeQYIEflFRt9AjPRSSgbxGfi7bhRajAtWZUGrPiwEKPl8qeWcYpzTtsrv3dhscY547SjuVAe2SuU0SJ6/g9sjyR2yA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YvP3g9ZxM8etliD/Q6/A39lUk3724Rf8JzeheZyipoQ=;
 b=iEKCFiAfUg6ViEn9t5/V5TLPLCECfNi3fZuF+ohUJgjD3M5btdAr5l8bKblklpU87aFUXeKWwjVaNKNcsnAyYUZg+CfdPF43NzIcTfQ90jiZw4AdQdjDOOd/bLOMWr6AnQo3Trq+SJUMNdASEQd9HMXG3Q4EcT5bayMOEl4oYOHZcUwQYnzZXmEbTKmkEB2TMTgmAS4Geu+BHyYTdDjhnIyo3A6VoRONEd/toE9Ksf+ugfOO7ILCAffiWrvKcFApe91QTOyXt2k4B9E3xsncqPS862xe6sWcmIpatnwgidPEeec2ah8SxXjUm1+odu7P8KQ5vEmT7LMzZ2A3OQjD7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YvP3g9ZxM8etliD/Q6/A39lUk3724Rf8JzeheZyipoQ=;
 b=dBlgXd9vf1deSUDlIjZjY2tNUM1A7CHJHHEUOLpz6Jf89nj4n5Dtufi4gxHT48rypnjAQg0ix7Dkn4MNOE2qGIhRwbzKKNJxvePaN6flZGs5Jd+RwWMD7ivzM8bzhwuMB+KU9w4BIGw/vZVCBu4xI1EjKo5cLi6opX6E1uUknlo=
Received: from SA0PR13CA0006.namprd13.prod.outlook.com (2603:10b6:806:130::11)
 by PH0PR12MB8029.namprd12.prod.outlook.com (2603:10b6:510:26c::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.13; Mon, 15 Jun
 2026 23:57:05 +0000
Received: from SA2PEPF00003AE8.namprd02.prod.outlook.com
 (2603:10b6:806:130:cafe::5) by SA0PR13CA0006.outlook.office365.com
 (2603:10b6:806:130::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.11 via Frontend Transport; Mon,
 15 Jun 2026 23:57:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF00003AE8.mail.protection.outlook.com (10.167.248.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.8 via Frontend Transport; Mon, 15 Jun 2026 23:57:04 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 15 Jun
 2026 18:57:02 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Mon, 15 Jun 2026 18:57:02 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 20/43] drm/amdgpu/ucode: WARN() rather than BUG()
Date: Mon, 15 Jun 2026 19:56:22 -0400
Message-ID: <20260615235645.737189-20-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260615235645.737189-1-alexander.deucher@amd.com>
References: <20260615235645.737189-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE8:EE_|PH0PR12MB8029:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b373636-897f-4a76-3a25-08decb39cd19
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|36860700016|1800799024|82310400026|376014|22082099003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: +8DqwHsxkjk7gQxRPDbZPtDd9eJkadBJP7kHPbwFqrAFEOUYnpA7BrJwuPdXaUuZ7/N81Ee8PEt+gknH3rrbltZ1MzBS+y1C2pabbOiNyyRc150/gRxJmiSceZGtNfRMbj2ho0cV4lx3Y1JVNQVfpYyNQ/JIH/gmM1R0/kJtSOjvOCLK3i1/ON+DbPojfvD7MHLRYwA+4Jf+1zn/uA+UuVyVFtfcP0njHTQCss/hU6bsMaK/A7QO/L0dd471cObEDP3O8jY3UybaTLXZSWSWf0+/44H5upIjo75ytGdaCp2YOyCizrxk36sNfwmqCYXAT2y2BKk5377l1tXU8WL3d5Tugs8GNYJLG7+tMzRjTCtlRiyqo7yZ7w1XkOn40rcfDM3O3KvOLgw77Jtn5kTH/eZZ2JVpngCyOj1AKwi9f4QJGg8Op8JkBIbBKJLZww2f7NxJHGJRER4Qfzt4pLpjHdR8Pp8yn2/gTua8gIVspdYTJzONL5DgchamSXNnzLRfMmi5XrMTuIzlVDN3pb3yOvh76rvcpy/EofPf2oFpdtlfsLS0Y62yPBgLIWFE4X6Y2MjzzSdhvCs0qryHBwgJAUU9nN08MxuaSHKOvmTD3hdUFEN0t24ETtXBhxdvkC1UZkLHgdO6RwJhd3qQBAvz+Hd73kN7TUba+ZtzIeXfvjo7bQTXtHztT8W93IDt84At3mOS6CdGEwfkHP8GhkM7+hGlzZ9TM9O5uxaIa92SL6Y=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(36860700016)(1800799024)(82310400026)(376014)(22082099003)(18002099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: K09Sic1jsylXtwfulG1fXjVaPYviSnAj2r3MGq6JPz28sVdAhMsnfJQ8To5MLiZN5MgjBXw+Ugt5K7pBS6YByBq76JDvZFKhtVttmLe4qUknjrloZbhhncgTpsVEjezdwYnfBgikpA4VQcCErHpEyljAJ++8+O5/FxBxJxSn82Uv5yQhphHRofSG6GjS1QDvL/PVdkxIoMQ0lX+ls77c22lDbaLtdqV1v0Cm2tVzy4OKMJ876ymnbfUhd+E2Bq+uATNCOnYypajouT5dt5ZSgLwRDRhjL+gcmRHEHGj9vl/I3jwSJxneWizEP5FzqxV3caiutnYJvAEqyn/+VJaW5wqOSCDmb+yk3mfiTI2rKqZSgoud/wESNkTpbtZQs1+y6BE2o+22m+GtdlaBtNyrvL9JPhvCysMb1E38iYeNNxwVztlha4px9npKyFh45EKg
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2026 23:57:04.7065 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b373636-897f-4a76-3a25-08decb39cd19
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003AE8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8029
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

There's no need to crash the kernel for this case.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
index 6d9e96fabd581..4f1c711df5bd7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
@@ -1478,7 +1478,8 @@ void amdgpu_ucode_ip_version_decode(struct amdgpu_device *adev, int block_type,
 		ip_name = "isp";
 		break;
 	default:
-		BUG();
+		WARN(1, "invalid HWIP %d\n", block_type);
+		return;
 	}
 
 	maj = IP_VERSION_MAJ(version);
-- 
2.54.0

