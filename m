Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77403CD6E7C
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Jun 2026 19:21:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D0F0711AAD6;
	Fri,  5 Jun 2026 19:21:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="rJvbokp7";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012038.outbound.protection.outlook.com
 [40.107.200.38])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0901F11AAD6
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Jun 2026 19:21:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eikkqNeCc8fHryOGKxqJErmcq0TKLqw1vx2mdxfzPGGSkzgP9kfRp3GGTY6QXXtITEfLbRo3yYpw3vLvqdTlZDcT9S2/2tEme4n8MhJbvetXNq9kE+fzOer4qVD887rmSsAh0s7zqW6o0ItJ/nOUSqlGs3wNQabYhoiSRMnpnkzc/ASTX/zW+p2hOGDAabFnAoItS8E3zRN/2qEy2jWGF+rPjvNd3Gu4zT8ocRY2S7ktGJh0hJM94r/2/c0R3i4UElYlcM7/G0ADYxhc6k/rakEPWkqY4utn+uaaWzfbN1AYexH0NWosLHalzmd1CkMHHZ92629F3RDGKcloK+ujJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hFPCsdXZ1dEouozlHwdsw5nR0RMXi0uF7fcHcVyAqCw=;
 b=oFQRq+6nxj/hoj3EZwM1O4xJsONU7OeuERQg4HWjPGY6Fdz58g4dry8SKm/w9W1K2A3MdYujqY5/WXw7mDfvDKB9n5kKAtcW1bQw4NpNZTTrwSShu84ulRVh47Vg4eCJuSV788N1CK5TCbwWw4wB+aK7nhVds2BCQOPjanRO6mzFHyqOWcjmadLRSiX9+/81viR2MZLZGbg0yAoms1JBxifKVgtjko3uPOYoqqNnu1I3lWZIu+IgcgvMu0RcrSJl6SNLQ5hcRn6v9tdmDEmIRpfK6H8zBk0o0FOTIcnj0g9lOOROq0JT7Qlg3rwkD0Jal8HxWaX0MaTRZJO1q+oZKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gmail.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hFPCsdXZ1dEouozlHwdsw5nR0RMXi0uF7fcHcVyAqCw=;
 b=rJvbokp7wN7ats9LVWMMYkAemSayWTpWRmsBWBKUxXwquPJJvNf/4v71Dua/r5qwHj7Qy9wXvU1wgg15IVJflc+CrHniOu4GxHb8aO2WOGBj86CP97N+P90Uq0uEe7EFCARhksP0M4YEkvL4CkdEKGKKQidDPPIGr91UBgHpbtU=
Received: from SJ0PR13CA0027.namprd13.prod.outlook.com (2603:10b6:a03:2c0::32)
 by DS7PR12MB5743.namprd12.prod.outlook.com (2603:10b6:8:72::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.8; Fri, 5 Jun 2026
 19:21:27 +0000
Received: from SJ5PEPF000001D6.namprd05.prod.outlook.com
 (2603:10b6:a03:2c0:cafe::14) by SJ0PR13CA0027.outlook.office365.com
 (2603:10b6:a03:2c0::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.9 via Frontend Transport; Fri, 5
 Jun 2026 19:21:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ5PEPF000001D6.mail.protection.outlook.com (10.167.242.58) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Fri, 5 Jun 2026 19:21:28 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 5 Jun
 2026 14:21:28 -0500
Received: from [10.4.12.116] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Fri, 5 Jun 2026 14:21:27 -0500
Message-ID: <305ba66f-93fb-4c2f-bfb4-d0d2223d5721@amd.com>
Date: Fri, 5 Jun 2026 15:21:27 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] drm/amd/display: Always create delayed HPD work queue
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>,
 <amd-gfx@lists.freedesktop.org>, <Alexander.Deucher@amd.com>, Ivan Lipski
 <ivan.lipski@amd.com>, <harry.wentland@amd.com>, Alex Hung
 <alex.hung@amd.com>, Ray Wu <Ray.Wu@amd.com>, Wenjing Liu
 <wenjing.liu@amd.com>, Roman Li <roman.li@amd.com>, Dan Wheeler
 <daniel.wheeler@amd.com>
References: <20260531105744.28717-1-timur.kristof@gmail.com>
 <20260531105744.28717-4-timur.kristof@gmail.com>
Content-Language: en-US
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
In-Reply-To: <20260531105744.28717-4-timur.kristof@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D6:EE_|DS7PR12MB5743:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a1a65f5-77ee-4e54-b844-08dec337a4d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700016|4143699003|56012099006|11063799006|18002099003|22082099003|921020;
X-Microsoft-Antispam-Message-Info: hKRfCgB9ZOkh5GpViQoAJ8oM2wqBl5UxcP+LQrm3xSflHmTWCFBPn9vhzdQCuFvK7LxMMUEmRoQA8TFMW9yqXKzzWc1Nd+nU2vHs3aN0Vt2hQTuwfMtPd0kXnqYdkElGmq5G3AIJEPOsqYn/96bhvWbDiI8aYDPXuR5eIrvmmH4fWXEIxFDHjyuZoMXgL6OJ+ZsVzLTGdYzrUXHhUB/edYX9kde8ozTB9TsRFRHYuqeprZ31VBAXYesS8itD7z5mgMYilMK9kZXAmD95oWvD1HgE84qAvE2CSmdG9B4+RKPN0xulNLdssICuIs0PijJtUBUxTSItjr3xRtdixvJsyKtfDWN5+ugLOD4WvEzdH/ZOOeBUZldBOLM4+MJhGL3YXVsukcjBLTUKwnm6n8LVOTxo0SCWYkcfTi4nqooXqCokRtwKzJjrEWoEMXrZ6o+vg6WdPh3HZXjSIxZZOVt5A4dkEzEoy3wcopAF9AsHt0LlzuEuTV/W26c0NF2zJWzscijShyeq8BP6ASQ95ca1aYhnSGXzclKFeRA9lLfIqZBpjDcU/4DA58m/2xGVlJLG4kYb1Kk5MSRfGre+0g3biiR3BbkqKMUL/84KFqrrdZtH2kmd9Ap361+Fx8qfR4shTjN91xrh6cLKE4foIx+6aJtLztRScvsE7XuQfCb6XGrexVqg1ZUZWoDiDT0SFlwihDHh3YWsFc7gCDW2OM+EOg+AOO8849qNpovj3Sj5FlyVVkpRz4HJmoa/g6yToq9quhKtGDRA8YsG3nKBwWSHqg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700016)(4143699003)(56012099006)(11063799006)(18002099003)(22082099003)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 31o44KAAqPvZ3CzAHd6ZfVIh17BX9LsIKeoECLJez1auwn4agyqvWu04BuV/1P6RDE3VPpwlVBHO7duDvQdE1/GXPidnqk6umCJndgqrZsvKc/CQo4x9VzWnn8YFuVYQFysBe/EffBwSTo9frxLTZSfsQcynny92bEq7tj3g33Q7yvc+9KLU/R1wFENXTwXejgAzCzoa7CHyB4RXMbnMc/dz+wYCPuzFGAYNHy8fGhBGWlJMy676BVtgbxFPwpKanEvypXRpFpuQYO4q84Xl4a2aNg+9BXJoNRc9Mt/XgF0ObKRtShssZifge9Eg2hjr5wuteTsI+9QEOj7UVajx4A9WK6Tx7/Upg314hs1+oYJjF3ble7AFmduEPqm4Oe3N7LcsGFKx96SCUmMov2bOanyIBTbmSCHrreMzoGbdJQ4xAijhZ5F61uyGt39FpEyx
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2026 19:21:28.8330 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a1a65f5-77ee-4e54-b844-08dec337a4d1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001D6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5743
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



On 5/31/26 6:57 AM, Timur Kristóf wrote:
> Not just when DMUB outbox is supported.
> It will be used for normal HPD events too.
> 
> Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
> ---
>   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 12 ++++++------
>   1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 28092ac052ae..255903d000c2 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -2197,6 +2197,12 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
>   			create_singlethread_workqueue("dm_vblank_control_workqueue");
>   		if (!adev->dm.vblank_control_workqueue)
>   			drm_err(adev_to_drm(adev), "failed to initialize vblank_workqueue.\n");
> +
> +		adev->dm.delayed_hpd_wq = create_singlethread_workqueue("amdgpu_dm_hpd_wq");
> +		if (!adev->dm.delayed_hpd_wq) {
> +			drm_err(adev_to_drm(adev), "failed to create hpd offload workqueue.\n");
> +			goto error;
> +		}
>   	}
>   
>   	if (adev->dm.dc->caps.ips_support &&
> @@ -2223,12 +2229,6 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
>   			goto error;
>   		}
>   
> -		adev->dm.delayed_hpd_wq = create_singlethread_workqueue("amdgpu_dm_hpd_wq");
> -		if (!adev->dm.delayed_hpd_wq) {
> -			drm_err(adev_to_drm(adev), "failed to create hpd offload workqueue.\n");
> -			goto error;
> -		}
> -
>   		amdgpu_dm_outbox_init(adev);
>   		if (!register_dmub_notify_callback(adev, DMUB_NOTIFICATION_AUX_REPLY,
>   			dmub_aux_setconfig_callback, false)) {

Hi Timur,

We'll drop this patch as well, since its logically related to the two 
other patches being dropped. When we have a fix, we'll merge all 3 of 
them together.
