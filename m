Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17270F31E21
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Apr 2026 15:05:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A5CAE10E817;
	Thu,  9 Apr 2026 15:05:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="VIwsYCzu";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010056.outbound.protection.outlook.com
 [52.101.193.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2F86C10E817
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Apr 2026 15:05:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V1Ct7WZN8iYhEcxlDoGky6C7B0eQ0mxN8+ItavfIiCPzKJ4oFecfSmmZny/f2zCVUXJsJKFlIkvXPONJM30803wM+RQ2kxpVf0dFGf6GRulVA/6VLe/yQhdc/eNaOYZyvL+jHPcMYZzcQ6hMfSYyfVWZAdOTvf6lpp4LORvUKRVEDuw22JyHePfTEzwXmQjLPNDacn/ib963NASP8/c3+QSt4YO1053hTsFUmXBi3TNVWnRbm8qb9efmfRetLGF2jL6NyLB7IojU5y+io2buBTs55CYKNrpm8WGa9YMLWSTavD4/kdQG3lHSvE9jt/OMAxJOvEPl0oULCqLhFFpPGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JOFdQnTKfFPYBhUXbinXv77eej1GYXHtNUuBIJRDwL4=;
 b=qLzac/wX6SB0XXnVPXK54Y+x9sScBqYAM5rXQKiZzuJSVFpylo6KCrfTfOCjsYf+Pvurr5pWNzzKkNnyqbLnANnb4eO2jhSAB/3zscBWLCgg0ShvM2uWpdAewCjVUOSzEypkOVFfdv+xOsvIhWP+Dky3wvO9LS63gfOfSiOpEOfPe4jVmHzS01LL9LUMkdeJxOnjA1M4hMaWnDK8FKfKC51l2pywtJfxL7AJGKlfJjSgb+Cseg4mt3AS0kh/kB9PlAIBrqp5aGJ/KyC61NZyC54L7VODAta72fn5TeRta2V0SW9NfmPd5VVXCShV6cvLoHi7acYLKbrZtdSDqFpYPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JOFdQnTKfFPYBhUXbinXv77eej1GYXHtNUuBIJRDwL4=;
 b=VIwsYCzum9thosZAxCdLL/aJXBBXoNGrAhh9wb3lmGRT9Xl3X8hDmHOLFndnIOiZ+jTkcwAW+kNVvDdSm6lKT+xgu/Tdmt1A+kk8Kz+qU+QzYatxzPnZiEPicklACKOE40PiDPIErHVhYtjAzDa23O+4N/EYODd65ZrrH129xh4=
Received: from BY1P220CA0010.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:59d::12)
 by IA0PR12MB7775.namprd12.prod.outlook.com (2603:10b6:208:431::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9791.32; Thu, 9 Apr
 2026 15:05:25 +0000
Received: from SJ1PEPF00001CDD.namprd05.prod.outlook.com
 (2603:10b6:a03:59d:cafe::71) by BY1P220CA0010.outlook.office365.com
 (2603:10b6:a03:59d::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.40 via Frontend Transport; Thu,
 9 Apr 2026 15:05:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00001CDD.mail.protection.outlook.com (10.167.242.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Thu, 9 Apr 2026 15:05:24 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Thu, 9 Apr
 2026 10:05:24 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 9 Apr
 2026 10:05:24 -0500
Received: from [10.254.92.39] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Thu, 9 Apr 2026 10:05:23 -0500
Message-ID: <93d8626a-03ec-49f9-9730-82e902e461eb@amd.com>
Date: Thu, 9 Apr 2026 11:05:23 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/display: fix NULL ptr deref in ISM delayed work
To: Ray Wu <ray.wu@amd.com>, <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Aurabindo Pillai
 <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>, Wayne Lin
 <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, Fangzhi Zuo
 <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ivan Lipski
 <ivan.lipski@amd.com>, Alex Hung <alex.hung@amd.com>
References: <20260409072057.1133476-1-ray.wu@amd.com>
Content-Language: en-US
From: Leo Li <sunpeng.li@amd.com>
In-Reply-To: <20260409072057.1133476-1-ray.wu@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Received-SPF: None (SATLEXMB04.amd.com: sunpeng.li@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CDD:EE_|IA0PR12MB7775:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e2dec35-473c-4f56-9c79-08de96496d9e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|42112799006|1800799024|82310400026|36860700016|376014|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: LrFbxKQqZtm0GRt4ewjO+lhbSuBJAUnaO9VD25dZwpDnuyFL6LgngYgmNhRWiOzOMrmwYOe+NHrWrPavsrjg3XMaObGBwWSm4U21vdeU0WqPnFbrvID57HLHFiwe5ptDY+KXAjfJyA58jCaAYZMQbR6/DISStqUjkX2ZUxjhGz7nyj3Ve/PuvuqhKXExJ8LR+yHjFTJ0m6jcZb3tnrOeRxcfwxa0wrKP8ipyqh+8O4mNAuHfy5R2sw3UbL+D2AdhswvNy8pfrAO5B09nh0IB0xShhqMU49lBffsF1xaUmWB1ZDLpjHXSRf2HKFZ5GQeRnK0WmkJl3j8wyzUcgjVYjjyqTCemdwWxL04zQ2cuqTLHZWBQBxBaFXDuZYaTdMG/qnNkHYkV4w0bxoWsAXI23nT8J51EQ3CmuDoZnWDxcYH3H6ztnSJNp5W8l583j5DYjpoUgclqCIGE9CXM6geTloZLRwFQ1WcrwwGrnCqITQDIuLoPWuSG1NrEUxA4g33CNKjP+s/BhCb7c3Z/8O5+vXe7LTPhsOkGjAgiwlyqTNcPKAHcdWfJsRhE1u1rUdVj5s3Jr5y/Ui2PBiGgy/lFJzyumDi4JYkW6KL7/vP2fKO8PnFz0LqyqKnzRogJ6FiTMotFgdb75fcEj6dwwrFm8BZf7EmoNXj9hm9ngZDn1YUUMSxEYUR54u8v4YRthb+4nR+bGMaZ1lSB1LhXa04/BEwN1AVJ/qINwSPh/pndww7HdDDFll5TMQ9qXER84laxhArru8ACVBw5mP/Ak0NhCw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(42112799006)(1800799024)(82310400026)(36860700016)(376014)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: IdwUKjp/odvYjeEFULSxo12sGDh/1wP9S2sBcO8++WU0x7mcRabq5vkkqviQtzefmLNyE1Y2roodLSo3z+xuxGRB99UU5HkTPi/b6WrZwzGPwundZ/LpLAELz0KeXO2QCFsC4hMzKXz8yLwjDMIz+1JGypXicINId9N4l0LbeSEiX7Eo5v2t0w+Smz2H9YkWcVQb7z7/VDClqNoDTE+R0AbfSOXh+3eK81kLJDTlh5xRf63ZB2MBVt0ssfbYviN4A1GUyUc9bQHpr/v/8S3xHcc59V4pn4XSqsUeO/c1iu6h/gOXRdjaTgOGR0xP6LXTt9M1nWTXgbtOCbMXBotmocmrYfPe9gKr0cgjmrIyl0Do7ytygITFuDyRbYgoUriHRD9x5hHQQdZM53Hd7BfxQ0YOXvZVm7HOTHiB7ZcKTBfDlFb4JK+rWDgd8UDrKFri
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2026 15:05:24.7984 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e2dec35-473c-4f56-9c79-08de96496d9e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CDD.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7775
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



On 2026-04-09 03:20, Ray Wu wrote:
> dc_destroy() sets dm->dc to NULL before amdgpu_dm_ism_fini() is called,
> leaving a window where in-flight ISM delayed work dereferences the stale
> pointer. Call amdgpu_dm_ism_fini() in amdgpu_dm_fini() before dc_destroy().
> 
> Fixes: f5d0d3f3439e ("drm/amd/display: Add Idle state manager(ISM)")
> Signed-off-by: Ray Wu <ray.wu@amd.com>

Reviewed-by: Leo Li <sunpeng.li@amd.com>
Thanks!

> ---
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c      | 9 +++++++++
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c | 7 ++++++-
>  2 files changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index bac02ea15b8a..bb79b6bed3c4 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -2236,6 +2236,8 @@ static int amdgpu_dm_early_fini(struct amdgpu_ip_block *ip_block)
>  static void amdgpu_dm_fini(struct amdgpu_device *adev)
>  {
>  	int i;
> +	struct drm_crtc *crtc;
> +	struct amdgpu_crtc *acrtc;
>  
>  	if (adev->dm.vblank_control_workqueue) {
>  		destroy_workqueue(adev->dm.vblank_control_workqueue);
> @@ -2252,6 +2254,13 @@ static void amdgpu_dm_fini(struct amdgpu_device *adev)
>  		adev->dm.idle_workqueue = NULL;
>  	}
>  
> +	/* Finalize ISM for each CRTC before dc_destroy() sets dm->dc to NULL */
> +	drm_for_each_crtc(crtc, adev_to_drm(adev)) {
> +		acrtc = to_amdgpu_crtc(crtc);
> +		amdgpu_dm_ism_fini(&acrtc->ism);
> +
> +	}
> +
>  	amdgpu_dm_destroy_drm_device(&adev->dm);
>  
>  #if defined(CONFIG_DRM_AMD_SECURE_DISPLAY)
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
> index 26f3d513576b..de203445e084 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
> @@ -459,7 +459,12 @@ static void amdgpu_dm_crtc_destroy(struct drm_crtc *crtc)
>  {
>  	struct amdgpu_crtc *acrtc = to_amdgpu_crtc(crtc);
>  
> -	amdgpu_dm_ism_fini(&acrtc->ism);
> +	/*
> +	 * amdgpu_dm_ism_fini() is intentionally called in amdgpu_dm_fini().
> +	 * It must be called before dc_destroy() in amdgpu_dm_fini()
> +	 * to avoid ISM accessing an invalid dc handle once dc is released.
> +	 */
> +
>  	drm_crtc_cleanup(crtc);
>  	kfree(crtc);
>  }

