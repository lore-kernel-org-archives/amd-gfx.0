Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C9CFCA5FA5
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Sep 2026 02:53:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3D22310E19C;
	Tue, 29 Sep 2026 02:53:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="zVffXYOf";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010057.outbound.protection.outlook.com [52.101.61.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1D61B10E19C
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Sep 2026 02:53:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tFJDRWGRsJFyk562b80kwSRD2k0JjoYAfa0d7dwAd8zmquAQKfTDprWyiko0fx1FyDmHEQ2KyPrQYPLeXk61Y+K0hbm74rITprTnA8OVVcFjsh+f7iYHn2nHrW4uT9XcWiw7a4MGPuTX+whtH0huoz5fLI4XIes/q4OBTwQHicKfMmhmqQzJ0daIdkThnLatZARrAaUY6CxI8MONH/ALLmy1gAFow+IZhS+xgxRAqPZwW6vJ86txNdqpN3YYqpoVoXsBM/8OTm0eeS9JKc9x39nzYqneaJCT/cPJ7sh5WvGo83Yf9JNuevRg1+fAK+dh4EOzkXU36b6o5v94ThCU4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qjGSBe+0pTnLxzqQwOzjDzW3lSPQFrXteqU5AAe1PKU=;
 b=EuuMkuF87lCgJLzhPbpzTutCHCJjtvTVAjfI1sn3DWT3qEy8hbrw1qVOVwB6EY10ieIuqcLA86E5aLBR6CENyVc3pYEcM0y3yuTyd+8+x4lCvxLiL8Yi/GYv1n7nCJlOVrGLUGSLYF05czF9pGaRNuPigQNMnfzX8p0c7dc1DDvsCywL8LzHX85sccXvEnnnBC4sN39SEOu67qPkLfjCHHgN/SV6ZX+K+iD5QZ8DzeGNgMMuePgmlghJ6i3dh9hT51rA98Kj7DafO6HoyCHdlwPImyLwemKJAOL7kJKUx8MRosM6hFYaYcHJ+VOfYaqrgchH6SBO4L/C+/+3ZH3u0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qjGSBe+0pTnLxzqQwOzjDzW3lSPQFrXteqU5AAe1PKU=;
 b=zVffXYOfTypfmMYZFb9rX1a0KI8Re/n87/vBW/39GwPNFKO+w/LDZIA7RcgcPawziGE4tjICZr7f8Q6rt+v3xzb9Ny/ASn1EcAUANa7DxWgJYYAW7foE3wL0mxOgPRJLyafHS4u0A+lmx+1leHcowM3vWSIgiYxGFzndTxQw9wU=
Received: from BN0PR04CA0048.namprd04.prod.outlook.com (2603:10b6:408:e8::23)
 by PH7PR12MB7353.namprd12.prod.outlook.com (2603:10b6:510:20c::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.23; Tue, 29 Sep
 2026 02:53:10 +0000
Received: from LV8PEPF0000005F.namprd02.prod.outlook.com
 (2603:10b6:408:e8:cafe::92) by BN0PR04CA0048.outlook.office365.com
 (2603:10b6:408:e8::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.24 via Frontend Transport; Tue,
 29 Sep 2026 02:53:09 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 LV8PEPF0000005F.mail.protection.outlook.com (10.167.245.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Tue, 29 Sep 2026 02:53:09 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 28 Sep
 2026 21:53:06 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 28 Sep
 2026 21:53:06 -0500
Received: from yubiwang-dev-linux.amd.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.49
 via Frontend Transport; Mon, 28 Sep 2026 21:53:05 -0500
From: YuBiao Wang <YuBiao.Wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Hawking.Zhang@amd.com>, <Lijo.Lazar@amd.com>
Subject: Re: [PATCH] drm/amdgpu: add sriov microcode init for MP0 15.0.8
Date: Tue, 29 Sep 2026 10:53:05 +0800
Message-ID: <20260929025305.3897772-1-YuBiao.Wang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260924070121.2150251-1-YuBiao.Wang@amd.com>
References: <20260924070121.2150251-1-YuBiao.Wang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PEPF0000005F:EE_|PH7PR12MB7353:EE_
X-MS-Office365-Filtering-Correlation-Id: f43c59fe-9b40-4dbe-eafc-08df1dd4cb6a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700016|376014|23010399003|11063799006|10067099003|6133799003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: g06Hl2dvxYMIrmNJD3KIjR/3mma4Y0erUZCBrwdQ2iW+nHJZRCfycq0siV07c9quUrIVzJHZ64wU+w5Xm7uyTRRz5DypHWSVtLy0xE6spOsIOWh5pBzm49TtjGrMihG91vVhYtIB+jMwF4kzaItnzGWpmxtK1rVbG7TRv5TgRrCvzJG9IwjIaIykmu8Ewe+AfQRLTMU4Sw8VjeC2ezkM7mufjJL94yb6w1x8asL7E3dTYBM9eiPLfbeuV6ZIlpBKHmQK4jXNMXN+OzyhSEbnXBn/VCgU9hHqg1IVeU5Y6t9yO87Fm7NjM5wG+Tqakx5k65+BOc2x7upX7PfmRq7XfmxMqrvR79Hwi9ESUN/J9YGeurqJkHOS+FXyNAC8LhLKvazStaShc+4kRJ5awzM0S6dWNKGl7uZwbLfMDGG9/Fp/S1B0Fl8kJOvYm7isEtdYh5uXaRNrh7InZeYlgn67Lara5euuADLNYaiNRfn87UoJaZg/nL+9PNPzXYU5w+2n03EHLZy3Wq0gpghBC2RYBiqazMcB0YBhAg/fXdteFC2k9JLiyTWBlXuLRIOptvFXdbFZqEa3vE/cJ99Ov7J3I5/m35XP/8aEm1//2GFi5Oqqeche+WXoM+ke6+h1rhWDcupAPNjHtmSPAgn3R0eKsPMdg8keu9Bw2dZb/sjNTXG8S6nHOER9tvlpYbPhM2gGaTSvCkbyEGu3Vg4KTYlF+g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(23010399003)(11063799006)(10067099003)(6133799003)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 99MWUWgFi8+94iXIxwDHEjHB3J3f6+WFTM+ZkVckpdkG0Aq5VRde9txOplqkquJZVjoIFiBqkQvgV4ZWlf8eSURR1rO0AKuXqHAtSk7qs/KatsQF/1GPkh1ErxbEZB9EGRWxeu+j466pVzNLvJvUvGhhVCknBoz7OVlGzH246yAiNdw9cMNF5EPJa6bx/1/uK9wI54VjB2T3pKuImCev3rrilNfTBkqUZQGSnpt5NWyzGfowlTzKD60jywOJJzailyWj9MKFX5R3aBiN/t5t8Lf+NUm1+rUPLg947h2GY1PKDvRdUWytLANsjDKjiLvfWgUrbOoMTylwvsvFwaW2KQ88dOegL42/a3ImPF+DrjJnyurHvPGsHFTI0LkfFkNMkkYO1kAoFq1LBFFM4/uJS+ckKO5Su4n4QEffqS8mGQtYjSm09bD6YjAB/43IRX3w
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2026 02:53:09.2500 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f43c59fe-9b40-4dbe-eafc-08df1dd4cb6a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: LV8PEPF0000005F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7353
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

Ping.

On Thu, Sep 24, 2026 at 07:01:21 UTC, YuBiao Wang wrote:
> psp_init_sriov_microcode() returns -EINVAL for an MP0 version it does not
> know about, so PSP init fails on a VF before any firmware is loaded.
>
> Add the MP0 15.0.8 case. It needs neither cap nor ta microcode, only the
> autoload trigger: on a VF psp_load_non_psp_fw() starts RLC autoload once it
> has handed virt.autoload_ucode_id to PSP, and on this generation IMU comes
> from the IFWI and is skipped, which leaves MES1 DATA as the last firmware
> PSP receives.
>
> Signed-off-by: YuBiao Wang <YuBiao.Wang@amd.com>
> Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> index 66eb2f34cc0d..453aef42556d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> @@ -173,6 +173,9 @@ static int psp_init_sriov_microcode(struct psp_context *psp)
>  	case IP_VERSION(13, 0, 12):
>  		ret = psp_init_ta_microcode(psp, ucode_prefix);
>  		break;
> +	case IP_VERSION(15, 0, 8):
> +		adev->virt.autoload_ucode_id = AMDGPU_UCODE_ID_CP_MES1_DATA;
> +		break;
>  	default:
>  		return -EINVAL;
>  	}
