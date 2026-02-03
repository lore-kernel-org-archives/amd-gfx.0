Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5877AE83062
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Feb 2026 08:57:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EB54B10E261;
	Tue,  3 Feb 2026 08:57:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Q7J4HLp2";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011030.outbound.protection.outlook.com
 [40.93.194.30])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F034B10E261
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Feb 2026 08:57:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U5bVOr30zEFd7Jz3Lf+5LSWV9JdP5TzlhR4ndqBL+Gw0jXgtJnNOx6hs+MxzOhzdLS+B6GCvGdF6gqbm+USa5SYUmyL9Ovg8wmQ9U5tk0hD015hH6+RmFXy7xXsV3vu7JXKUoCGFRA3a2jD0CHgJQDcRM5mZ3CC2ePqzduAM6SViXfVnarTsA3chcBQ40kFjY7FnAObzoo6sde0ZEBlFTf9bFILUN5z3uTnCXpXhMpPX3Oc/FLIZkGWqQhRUw0vLuS8X22uINdG8W8mIvzUVw+WlG6VVAOGY2ABW8NtAwn2zvI9S4XuUYtU/z+36IXMafrv1RTvWiyoIF2QzWgfuVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4bw/DsuhkHj4tDGXsHkm6W+h3RIuahqBUG+fBHdLSXs=;
 b=LZHxG5ffviMLOuFD1fxlLBVGzx+anJWFHgjdc9JMqfdZeWEejgz25K99VYwV7jJM0fXYZCRcMPCveGuyO26a93XTyepRG4Fxrm+FNd8BBQyBDJbzwS3UWqr0nxCeSSz8Av6dlJzwn2ZeX9ljxFi2FtN+Xk4xlcgQsssZeuXosxz4YSo/oltn6InipubfC6wBbHdR7ncdYCswgKJVG4AAC1KYzfRi2uMFh4taKQDuFRfVYmL0hdvQoYne60GUD0wnUJh7zCe0s0d4Ix73pWpcXn3lrvkdYdmpvBLvg+Du5ajimZlFg2/Glyg+aL3EqjGDDQuOF+FTfQ0fO80fchRveA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4bw/DsuhkHj4tDGXsHkm6W+h3RIuahqBUG+fBHdLSXs=;
 b=Q7J4HLp2j8IovKB1Iy5RuySMH/ld5OSonWM1so6AEhmhupqzFhYURhfT4hkujQV9KtttqvhBkU/jVyTABW2t2roEYNJ7QzZmIaDPoHrXYiIUoWyggCZ7t1yfkH8Zx9NJtM7S9NHdSCVgjw+q8bEy10m1N1CQAPJDdHJalySI/to=
Received: from MW4PR03CA0247.namprd03.prod.outlook.com (2603:10b6:303:b4::12)
 by PH7PR12MB5973.namprd12.prod.outlook.com (2603:10b6:510:1d8::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Tue, 3 Feb
 2026 08:57:27 +0000
Received: from MWH0EPF000989E8.namprd02.prod.outlook.com (2603:10b6:303:b4::4)
 by MW4PR03CA0247.outlook.office365.com (2603:10b6:303:b4::12) with
 Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.15
 via Frontend Transport; Tue, 3 Feb 2026 08:57:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000989E8.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Tue, 3 Feb 2026 08:57:27 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Tue, 3 Feb
 2026 02:57:26 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 3 Feb
 2026 02:57:25 -0600
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17
 via Frontend Transport; Tue, 3 Feb 2026 02:57:14 -0600
From: Jesse.Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Jesse.Zhang <Jesse.Zhang@amd.com>, Alex Deucher <alexander.deucher@amd.com>,
 Jesse.Zhang <Jesse.zhang@amd.com>
Subject: [PATCH 2/3] drm/amdgpu: extend per-queue reset fw check for
 5.2.1/5.2.6/5.2.7
Date: Tue, 3 Feb 2026 16:56:11 +0800
Message-ID: <20260203085706.450079-2-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260203085706.450079-1-Jesse.Zhang@amd.com>
References: <20260203085706.450079-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: Jesse.Zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E8:EE_|PH7PR12MB5973:EE_
X-MS-Office365-Filtering-Correlation-Id: ad36092a-9001-4af5-3ba3-08de63024178
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?dbni6JZ+bj+I5B7rIQRVnOFiqDsKYHTQpwbrO8g16fgP8PioqtvmVSu7ZtYe?=
 =?us-ascii?Q?bA5Ca8ptP1I+EOBkDrHa2EyGdmTXKHCgHamjZhu8saxsWf8v0/0bLbWtwCIY?=
 =?us-ascii?Q?q3d8+1i1zKD7UeG6Fjc7FZLUxF2S3h9Jou2zYkQn9FQ7v3KOAMhF2OKrxYXg?=
 =?us-ascii?Q?//TmS0fd5PwSusOHL2sxZLwlVWPqbfvCWJZxtIkUb3jnH6wnZFReZCWidJn4?=
 =?us-ascii?Q?IehJwX4FW9wqrAa7R4t3+wc4adoiBzuoc3qe/CY53AhXydOw9f02rO29JcIP?=
 =?us-ascii?Q?iGcoCnVYBMtcVM6JDNAApNLJlN0RBM1hIG8b6K/3gCZgYoAzN7JQkXOT0gq7?=
 =?us-ascii?Q?99+VAddtxpyGh0o/MssvRCBTy8CRdNp1RSMwEbfoVShZXdwmhW+dNSMXN0Jy?=
 =?us-ascii?Q?RCSM/kBrAWH+wvBEQXus8MFgobWRCOwdp2gAvFIl8/iF9LlTZa8JLagAwL54?=
 =?us-ascii?Q?0BtokEzQor3pfis2MzxJer+gNEEzgJFTMfimxuQqAZVUQ+mt2YTc8Xi6kgZr?=
 =?us-ascii?Q?YZY35HtNxkQkCZ36eoTMh8+rXKyYLz9CD/LDprflvdAA6i1WIO1QtyTxZhDv?=
 =?us-ascii?Q?/Swow30Mzhq31vk//cqshOmnLBin9VYp6IZxT9xQXTgpzEAAxXSQRMSH4gge?=
 =?us-ascii?Q?Ec4KheJ4tJpYTJ0j3Pf6B/GYZIDkZsQwsFCSSDo54hAgrrDc3P3tXkYhJg3j?=
 =?us-ascii?Q?d2YDlFibV6DxWkjtPOu/ebtDs7pFBdjXJWa/Yp0wwOgG5+H+qIPFTJ+ZEEtI?=
 =?us-ascii?Q?s3MaabEPe3k9cQeNIDnB1+SN+arakP98hkKmZVfj97T0Dgd6ZJE0yLz2zf0l?=
 =?us-ascii?Q?isHOMlWQNrth2MuvV+JEYoGpYOPdv+aXtXYuLGqrLDVuLAFV8E620sOXq73t?=
 =?us-ascii?Q?31++ieMr3fiJiBBZkWuvzCKwdWilggQQIJOfiwT4g2s+8nPA/SQyReNB02CT?=
 =?us-ascii?Q?IgLzdkRhdZ9JjR+jJl2B3b+Kl1DurIddkAsqpPb8sBJzsaxDazGJm0jRzjwA?=
 =?us-ascii?Q?ohtCAmvH+sQpsneAyZXlf2cyn4PApf+Fi4jM9BVWDVa5m+srz4c4Tb7WSxEG?=
 =?us-ascii?Q?cnhsm3qUMhgNplMhkuN5RT/JHK2Nnl7e62qNDW19rFXy7KdoiF1kqj6oQu2D?=
 =?us-ascii?Q?XHzoY7T23MM37cVVbMScf798Im044emFpOOV3jA2Vdn+pOj3KYxMiJDnwUAC?=
 =?us-ascii?Q?mrxvG95OeOGAH4/gFb3aoZxubrXBdFpGtNdudR0+O9zl1jaBF5LLu2VV9qV6?=
 =?us-ascii?Q?0NWgKpmLHLGAA94/0BAHY7gQu8AP5xBzAPzzggjo3kCPX8yxQmgkgZDAoO9v?=
 =?us-ascii?Q?F9l99NhYNFVrCt4GeBntyQIZMmTR1kjD5WWfpqKIc57ewPM7RrBuz+hLpxKi?=
 =?us-ascii?Q?NuavLrIvHggWh3vkyQtRI6unWPU7MMP7dyJDPQGAZTYoHMZ1H0kwHMMh9ed0?=
 =?us-ascii?Q?H/qdgEN6oBb/19GnqWZom3PFpcy2gLYWerSRZEEiQ3GKfg1aSxnF303F2TWl?=
 =?us-ascii?Q?pQK1K+m981cszTnlaguRjroFWJgcMlhIaIAAnAU3oIWNiKkT+NIfJvnpqD+n?=
 =?us-ascii?Q?V3+S/9k3B+XPuL7mFCwTtgKQfi0ZE5OCL8IInnRLT4m23VRHobpZbzQunOGw?=
 =?us-ascii?Q?jBg0O7/FAAtx6JJNvXy5anIHWXKxcKM7+MYUNOk6RFK4anvJlIRd8mXoTc6u?=
 =?us-ascii?Q?eUD+4Q=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ltmnkj8/eqQMDOAM/l53QS20JqVgX6BW2ZZkvYzLCptz4Brf4E2WrcDD7g4dENRKtWuTLfKR96/rIGPFyj8dzUJP8bfX4Pq0C8cXnI7VJW0znEQoUigOVZfFRkC1oJgEz3Jm8cUu73SHLgvFU8ype3RWFIhBfuSY0ZYS4zQOaQVZaPlucpsln14iWduiCtfCI4ktCz44WIArsESDM5Z/NfoUyDZ53DPalK7fAEARbXmlqHbz/rY2X7CcTuKcH/CkTfS+LpGwf4Uoj1IXJgZyfusbsL5Nbvaw9mVAa1kBdxWkOYMSZgmzBY9EpvHzk8hiEKoEC/OJ0Lir5Lxi9xAXQHDk0Zfnd6C98wMn06SyWOFELAdqpWPwH6E13CMAZXai+Xo3Zpajxg+xAeV+aMRM4qicOtICTAJDA5pkZiKrKjBcDEYbNoApRhoge0/ba+ci
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2026 08:57:27.1334 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ad36092a-9001-4af5-3ba3-08de63024178
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989E8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5973
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

Add per-queue reset fw version checks for new SDMA 5.2.x variants:
5.2.1: >=41
5.2.6: >=8
5.2.7: >=1

Suggested-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Jesse.Zhang <Jesse.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
index 78dda51cd9e0..53618d8a2439 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
@@ -1355,6 +1355,12 @@ static int sdma_v5_2_sw_init(struct amdgpu_ip_block *ip_block)
 		    !adev->debug_disable_gpu_ring_reset)
 			adev->sdma.supported_reset |= AMDGPU_RESET_TYPE_PER_QUEUE;
 		break;
+	case IP_VERSION(5, 2, 1):
+		if ((adev->sdma.instance[0].fw_version >= 41) &&
+		     !amdgpu_sriov_vf(adev) &&
+		     !adev->debug_disable_gpu_ring_reset)
+		adev->sdma.supported_reset |= AMDGPU_RESET_TYPE_PER_QUEUE;
+		break;
 	case IP_VERSION(5, 2, 2):
 		if ((adev->sdma.instance[0].fw_version >= 41) &&
 		    !amdgpu_sriov_vf(adev) &&
@@ -1379,6 +1385,18 @@ static int sdma_v5_2_sw_init(struct amdgpu_ip_block *ip_block)
 		    !adev->debug_disable_gpu_ring_reset)
 			adev->sdma.supported_reset |= AMDGPU_RESET_TYPE_PER_QUEUE;
 		break;
+	case IP_VERSION(5, 2, 6):
+		if ((adev->sdma.instance[0].fw_version >= 8) &&
+		     !amdgpu_sriov_vf(adev) &&
+		     !adev->debug_disable_gpu_ring_reset)
+			adev->sdma.supported_reset |= AMDGPU_RESET_TYPE_PER_QUEUE;
+		break;
+	case IP_VERSION(5, 2, 7):
+		if ((adev->sdma.instance[0].fw_version >= 1) &&
+		     !amdgpu_sriov_vf(adev) &&
+		     !adev->debug_disable_gpu_ring_reset)
+			adev->sdma.supported_reset |= AMDGPU_RESET_TYPE_PER_QUEUE;
+	break;
 	default:
 		break;
 	}
-- 
2.49.0

