Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDBE2606A31B
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Nov 2026 18:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=P8MzuIOq
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7919110E974;
	Thu,  5 Nov 2026 18:51:02 +0000 (UTC)
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012020.outbound.protection.outlook.com [40.107.209.20])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1A4E210E99E
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Nov 2026 18:50:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i6cRKFU7caVGJoiSMUjN+CRtGVc96f0MYra2ER8Tz8+nFTpxOFvjPX6+vS/F5f+1wks8b+7OGQxAqzshUG5KlM/FPFMGgiv/Whxx5p/X0d5Iide0WaOcAZYMr+tT73zXiNPgV3Ddsv3u/ZLhNG70J893OgskUk89l7z8Hr2SBR0DZWJduA7bxt1NyPnOcya7zgDcu2smbTUUZCleqTukLnGBj3PIh6VCtb5oVUqrtuCF2uY21whyxgCDYc8vB61p6YscmsDG1umNX3lXAiYJvRWLKhd1znzPzTeHFCCtXRQurOjd6kkFHVot9AIcYWcLtf7Z5TH94VglCOeRHUgrew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NC3cJk9jzifZmF0yCPSu65tOFjGVyTZ2CAzbW8C0ZEQ=;
 b=t+63vfStR25OC4Kbh9G4OMytaL5DQ+EMyWGwswW5Z8QVjzPOhbVGc9Sa8WRkwC9UOD+gehDQ6BLculFSw1AZ8NvO8zz68MHJNn0qRD4A7l+hjF72GsWMA6p9yn72A2sAFNdODXa/1s3w0OcVMHXylDZJP+qGBMg++B37xLo/6FEFtPCBkINzpwXsmlGp9TY1i+VaE00K1OGCOe8cVeqJTfGp5d5sZ6hyKlemR4pR7ohLM1xBs/o3sqiMKdHNWVE5jE5UGUz096p24nUlisWMgeYH07XcjRquhVMJyQQgkEHBIgIbzmPsKSXn6pqkyJn2E6EnHx/KNh9wc1Z7M+d82g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NC3cJk9jzifZmF0yCPSu65tOFjGVyTZ2CAzbW8C0ZEQ=;
 b=P8MzuIOqbnN+46umT9ZfAngZGxBAPSHkFn/Xdbbs7K2gRfzX4Not8JqxGIr5A6huqj55BQlSCi3Wprn9BOpYhTrfuVmEP8AG6hBIc0wC45IYPEkzX4afqsTdIFwJxDTXgaEM9qFpj3/sxIxdKMFvCCndVrO9hH5ckyTx9vLUhNA=
Received: from PH8PR07CA0022.namprd07.prod.outlook.com (2603:10b6:510:2cd::21)
 by DM4PR12MB6277.namprd12.prod.outlook.com (2603:10b6:8:a5::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Thu, 5 Nov
 2026 18:50:52 +0000
Received: from SJ1PEPF000026C9.namprd04.prod.outlook.com
 (2603:10b6:510:2cd:cafe::45) by PH8PR07CA0022.outlook.office365.com
 (2603:10b6:510:2cd::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.10 via Frontend Transport; Thu, 5
 Nov 2026 18:50:52 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ1PEPF000026C9.mail.protection.outlook.com (10.167.244.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Thu, 5 Nov 2026 18:50:51 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Thu, 5 Nov
 2026 12:50:51 -0600
Received: from [10.254.93.142] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Thu, 5 Nov 2026 12:50:50 -0600
Message-ID: <b660ffbe-741f-4606-b827-a31d03512497@amd.com>
Date: Thu, 5 Nov 2026 13:50:45 -0500
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: return cached hw vblank count when reset
 blocks the read
To: James Lin <PingLei.Lin@amd.com>, <amd-gfx@lists.freedesktop.org>,
 <alexander.deucher@amd.com>
CC: Harry Wentland <harry.wentland@amd.com>
References: <20261103211302.2899044-1-PingLei.Lin@amd.com>
Content-Language: en-US
From: Leo Li <sunpeng.li@amd.com>
In-Reply-To: <20261103211302.2899044-1-PingLei.Lin@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C9:EE_|DM4PR12MB6277:EE_
X-MS-Office365-Filtering-Correlation-Id: f69725ae-60af-41f1-cbe5-08df3b6db724
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|42112799006|23010399003|36860700016|56012099006|18002099003|22082099003|261021123027099003|261026140227099003|261021121427099003|261022105027099003|261009223027099003|261026121527099003|11063799006|10067099003|261028144727099003|261102123227099003;
X-Microsoft-Antispam-Message-Info: LWGrIRp7n31B7YWO7NVlgoMrjsXjbdHNIS84x2sqU15fSC9L6GjbIr/yhGEmKtuqUXtay1sCKr/B7FbYLpJYy5AtuSP2ZQYXKgLwuM9CUCowPZz9lMN0nBLD2E/XFJ7SVIrbfhjJA+O2EwdwNxPrdsU3ydMMFKSode3Jb1GuoK++N+LQSeS9CMVXoJFDPhoknYaJo8yTQ1Vaq+S2f7BBVyMmwZJzg2Ryk5jE7d9UMf64UpRKO447bCbwnO0X56fb6kXXGBooZYcBLHDCVQGegxl+RblQWdYZ2SOc/bABn8B8sZLpBqAwwLUgnPCbUze2NaDovf2Dch9KmN+y2O6Y/eOi1eNXmL2eQ7OCU6RVg0f1KeWS6wSBtaqyJRruUN6nC66s4UkA37wQSWfi6UHA2IF7FQl3zZ0LFfncYpxOnLKkvK+hkp5F7K7R0cTGxdhwTy60RvzL/P+G8Ii8hl28Yi7luMU2u2a3m/kARy5LILroTFLf7NK9/7qwJdqYBASwWKSuZb8jYHu+E8GhPpvO5AbbsOyk+M80Mip2REKT5seEMf8HzN9N1ApHoJLTKjzpvdzTHZ/4RuQLcwTJX06P8J3Xu+gZAtKuzGBe7laUn6QvjNu7Kr8EhqpZRWxMPHSK0mZGXCiWwpumRk7xqbsEUpDwFbLyrd39AWC/KtAzWPs5chIYHIgf6ci0oFqKxJ9FRRAT5Jq7XKf/xUWm+lTaHw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(42112799006)(23010399003)(36860700016)(56012099006)(18002099003)(22082099003)(261021123027099003)(261026140227099003)(261021121427099003)(261022105027099003)(261009223027099003)(261026121527099003)(11063799006)(10067099003)(261028144727099003)(261102123227099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: tyoXJD3YpysHP3rAVON9XEQowQk9mG1Z9Oedr+wPaIkdOT4adZWItyea1m0EGU5F0uCUcJKwrdwAjxALmBna87X/sS/u5WMYAE7/3dEeDPGky0tEiggXzIuBDVWdRh27ZJccWws47DZXFKflNwlSRf+JpAsvIpTC6DiN4VtGUyXyRcnuQnYnZZ35FGNrQFPki3oaH4IBAJ8f/ontu4W29T+8nu1Im80Or9IK6ezWuiEssWAXnwHNgSu3B01J04KMMu15HBOsFMx8OBT+ztRX0fyUwGNPB4hG71vZIJBRAhqv3W7o3rI4J1zTyMPpZd1CQdUx5UE5GjlivQb7/V4SpgmaDPenJsxo32WAtDI9nAq6GMggzVfJkunIe/60BNTHk2XUfvHXopefJkSAwsoWZI3WaPEh/mxgXS5Mc9w/x0/pBP6hpNy9roGzUz77kf4C
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2026 18:50:51.8716 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f69725ae-60af-41f1-cbe5-08df3b6db724
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000026C9.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6277
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
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 2026-11-03 16:13, James Lin wrote:
> From: James Lin <pinglei.lin@amd.com>
> 
> amdgpu_get_vblank_counter_kms() is DRM's hardware ->get_vblank_counter
> callback, so drm_update_vblank_count() stores its return value into
> vblank->last and derives diff = cur_vblank - vblank->last.
> 
> Commit f2bc71d16e73 ("drm/amdgpu: serialize vblank counter reads
> against GPU reset") made the callback fall back to
> drm_crtc_vblank_count() when the reset semaphore is held. That returns
> DRM's software vblank count, which is a different numeric domain than
> the hardware counter. It poisons vblank->last, so a later update hits
> diff == 0 while cur_vblank != vblank->last and trips
> drm_WARN_ON_ONCE() in drm_update_vblank_count(). Reset still succeeds,
> but the WARN fails the mode1_reset dmesg check.
> 
> Return the cached hardware value vblank->last via drm_crtc_vblank_crtc()
> instead, so the core sees "no new vblanks" and keeps its accounting
> consistent. vblank->last is protected by drm_device.vbl_lock, already
> held across this callback.
> 
> Fixes: f2bc71d16e73 ("drm/amdgpu: serialize vblank counter reads against GPU reset")
> Signed-off-by: James Lin <pinglei.lin@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> index 14a72a406d37..365b4fc86a9e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> @@ -1699,9 +1699,18 @@ u32 amdgpu_get_vblank_counter_kms(struct drm_crtc *crtc)
>  		DRM_ERROR("Invalid crtc %u\n", pipe);
>  		return -EINVAL;
>  	}
> -	if (!down_read_trylock(&adev->reset_domain->sem))
> -		return drm_crtc_vblank_count(crtc);
>  
> +	/*
> +	 * A GPU reset is in progress and the display hardware cannot be read
> +	 * safely. Return the hardware counter value DRM already cached rather
> +	 * than the software vblank count: the core feeds this callback's
> +	 * result back into vblank->last, and a software count lives in a
> +	 * different numeric domain, which later trips
> +	 * drm_WARN_ON_ONCE(cur_vblank != vblank->last) in
> +	 * drm_update_vblank_count().
> +	 */
> +	if (!down_read_trylock(&adev->reset_domain->sem))
> +		return drm_crtc_vblank_crtc(crtc)->last;

Reviewed-by: Leo Li <sunpeng.li@amd.com>

Thanks!
>  
>  	/* The hw increments its frame counter at start of vsync, not at start
>  	 * of vblank, as is required by DRM core vblank counter handling.

