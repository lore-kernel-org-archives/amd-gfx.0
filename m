Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B279C369BD
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Apr 2025 11:01:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D045E10E097;
	Wed, 16 Apr 2025 11:01:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="WonjBrzM";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2053.outbound.protection.outlook.com [40.107.93.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C1EEF10E097
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Apr 2025 11:01:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pWZ1XbRIVsrqop4go1nVfh6f9HQeo0eh5uRINegSTRQTL+5c+znXAgDwLk9rlHCV5sKpg9hzb4eOcLlOfacVyuIJLtONIKMwI3VhPJqIo2UR0wzSVelDir01m3NWAbEevr4RHCNRWTdBY4kzqqFqlf0f5KqmgOZxbqd8gOG2v/LfAEr3T6kf6M1WEmBeh9XNs7lSxmv7i6q3Br+Lgrwb3NFoYqSDsIkwka5/IrwPSzgamTldRFzeBHMYa7oIBGZ6IPJMnn7MUZiYDSGFU5Oc4vt2k1LWTGBZuu8eKavURD57Rnpum/f16DEYLy9xnus0xUER+Vd296AJkinK6xV9Kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LU/3mE0vS0BSdyRs9iXFgqduoVR8GVewFzRNs14i51Y=;
 b=SRGUVmiurqNEnwyQ3pqBcRlXUTDhSv8IzGQMKaqo67IyenySo6bOYZ8bp43cgxKIqeDmk1DUuIr1OOM0I1Q+AIdzUZqV2piaYu5P9wFvmyd3/xvf/19q4jKwWFWVgeESxKhtPKhUzqx4pEUGOg2oeeF/c3lMToTD56r2e+H0eGAOP8ngjqgWN/g4YrPd387T89pwd7+EfXOwoV7tdh8n+OSqlAEabkXac2EBujlnHdHP+klsr5iNM6qpsvMwFnQPbHRW/dgT9VxyciZ0XUvwRc1dqgMyApym8sLs6Ib8euirJ45PnMAv2ocWhZuIUNC3IkMAQMGrzQ/BeMTOaE9w8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LU/3mE0vS0BSdyRs9iXFgqduoVR8GVewFzRNs14i51Y=;
 b=WonjBrzMiYZzxzCZif8EWceNax0LQ7mcQh4DRv5HShtw98pC0WBb7oLUMdPyL7R7p7UbM0Jh1uEFa57HZXMvq4vxlcG5Ihf+H3Fix6Hy9Uenrp9RigyhGagMloESAgmS/vKMLYSpT4bJX8jG6sp0pUV/fzuJe/HuWmmf6lbDnjg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by BY1PR12MB8446.namprd12.prod.outlook.com (2603:10b6:a03:52d::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.32; Wed, 16 Apr
 2025 11:01:29 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%5]) with mapi id 15.20.8632.025; Wed, 16 Apr 2025
 11:01:29 +0000
Message-ID: <0ce0c2ef-f6d1-4d44-9d6e-ece14d17de45@amd.com>
Date: Wed, 16 Apr 2025 13:01:24 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] drm/amdgpu: add the evf attached gem obj resv dump
To: Prike Liang <Prike.Liang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com
References: <20250416085029.2278563-1-Prike.Liang@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20250416085029.2278563-1-Prike.Liang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0068.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:49::13) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|BY1PR12MB8446:EE_
X-MS-Office365-Filtering-Correlation-Id: 54964a74-f61d-4b50-133c-08dd7cd60a19
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SDF5aDIwNDRSeURVZ3ByYVVlNGNFQytna05YZnpjWDAxeWRjdkk5cUdQejBJ?=
 =?utf-8?B?OERxSVNheGRqQzZZdUE0SjU3Z0x4eDF5WmtWaStJQkxZaFI3eGMxN1pySGV1?=
 =?utf-8?B?NEVpRnBMbDh2TndxM3UrL3BiMnJtR0VIUWo4ektPOUt0VWlUTkY1S2sxL2FT?=
 =?utf-8?B?VTMzVGQyeFpESm5WUkt2ZFpOdjJ0M3R5ejlrN0NuZkp6VzIydk1lV3RKdTd0?=
 =?utf-8?B?TnFFQ0gxb2pDOGppUVhrMUpCZm03R0F3SVU2aXQvYm5CY3JVblN0TS8yQ0Zl?=
 =?utf-8?B?ZWE1MmlqTGdYdzBCbzZVTVlNQ21lUlNmRmlVWGN4N1FsZTg4NEhKM1pTVmtY?=
 =?utf-8?B?YU9PUDk4RVdTRXdDSUU5MmZ5bmhkRlNNQ2JSNXR3V0xlYmx4SnM0aTM5aXg2?=
 =?utf-8?B?MG5IN2J2d3JkbjMyVGVaV0RaQmZ1U3plM0I4dTIyWjR6ZVRVZnNDdGZLUGVZ?=
 =?utf-8?B?ZUFVTWdYZWlmUFF2ZnVCYW5XWnlpSVJ0MU9LY0VNZWo2QlNHZWFFZGZpbGdm?=
 =?utf-8?B?SzF5ZEVxRjZxVlRGYVNGbTNwTFBxUVdzcUFnK0F0aVhUdDdhcG9DQ1ZrZWQ4?=
 =?utf-8?B?eC9DUWVTQzREV3ZUdEZxYmJBSzdTZDdiZHRXQm9Cb0RvcnVOWG1Ra0VEVUo4?=
 =?utf-8?B?aHVPTzdpTFB0bGJIQmN5aGRDSlBYdGRKeWpZdjV6Y2xhMGhxckZnVGp4SGkw?=
 =?utf-8?B?L0NVdDFNRjFWVHkzWnpGaTk4cWdHMlJEcU54TXoxNjJEZjB5YXgxZ2VkZkQ1?=
 =?utf-8?B?SStkeEtJdzZqQndiakovQnQzNHhkbm9CTFp6cGhwYXlSRjVSeCtHU0l0djRy?=
 =?utf-8?B?SjV3WlVrWWhKY0t0ZnBWVjBoNXh4NkYyemRjU203UUZaT01vRjJPR1ZmL3FR?=
 =?utf-8?B?UkQyeU9NTm9HVktyQVRta0dhM0pkY2RJUXM5RnVkaTBiYXV0OWxEOEkyY3F6?=
 =?utf-8?B?VnpwTzArVHlxSGZXTCtpb29nbUFZZ0I3L2FyVFZwSERSTnowUFZoRm93b1Jn?=
 =?utf-8?B?eFdpajl3U2xKZnBUckdDbVJRcFdtNHV5ZEZEQTA4Vm9kUG5VVTBLYVVVek1q?=
 =?utf-8?B?VzFoalloYnJJQnJnKzJMUjNnd1crNSt1VkdnNVZ3VnJJb1VFRGxOOVJsdUJF?=
 =?utf-8?B?R21WcjJlMzVlOE1nTHFHMFFpZ0hiUWZaZy9YS3dGRy9oTndrYjhjN1pma2dW?=
 =?utf-8?B?QW95NFFSNVJ0S3RGNFgwWHh5NnlNSGJhTEk5TW1SOTNvb25OQ1RISGpsYlc5?=
 =?utf-8?B?L0c5WDQwcll0YXBGWWNSNXkvK2VLNlF2dW9wQTBOTFdDNTBZT0h1QUEvNFp0?=
 =?utf-8?B?ZXRqRk1odlBQcjQ5S3M4RWZxRG9IdkNxNW1WSVE2R3h6cDd3Rk1mYWszckJ1?=
 =?utf-8?B?Q08zSk8rQnR0U05HbkdIRWFMNWVjTzh2SGNyTWJTMTUrWTNBOHJqT1dURkZl?=
 =?utf-8?B?NmxOTmxaSWYwR3liQ1RTSlltbFhnM3Urc3ZJd1E5L0ZaQUhwYVdPRE5HWERO?=
 =?utf-8?B?V0dBUTJmZDVSTjR4UU9YZmVaUVlia3o1WGU0NW1WSVBGeHZncmIzeWZSZXY5?=
 =?utf-8?B?M3JkdlgvMWFvOVZwUktqYVM0YUllZzM0cjZ5MFVzK0tPZzduOTJJVlNXQk9r?=
 =?utf-8?B?a1E1a2ZPVmRQYVgrZU1tRFVWWHJROS90eUxPekJhVVRsS1FTR1M3V2xMcEZw?=
 =?utf-8?B?aVBDQU1vTzMrc2hIS0JvblNpWElmbWVGU1JYQVd4bFNkSGNwRjQ4aVdTNGM3?=
 =?utf-8?B?NVhueUllS3d6bXZqQWJhUklRWG13V1Yza0ZvQisrWEVEVDlXdlV6d1NSRU9u?=
 =?utf-8?B?aTFpZFhoVjVmTEV3NUNYeVJZU1V2SlJteERxOTAvNjM2dnNGbVpSMlV1bjlW?=
 =?utf-8?B?QXE3NXNmcVowVmtjVjdqS3Vnd1RzMnNDWHR0SXB2ZzJIL3JiVE4zZXZURnB5?=
 =?utf-8?Q?s/gkJU0/PA4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SlZJaXZZWFVmaWF1SlRFc1k1UWxFandEQ3QvV0wwZzJoOVRsaVVGWG95TkJz?=
 =?utf-8?B?c0ZaR1g1ZUJiY0RxTGVlUCtGeEM1aC9uT3Z6aDlCL09nUkM4WnhpZmFMa1dw?=
 =?utf-8?B?UkovS01SLzc2dzNnODBLcGdlcCs2MFJIc3dJaDg0c2tGYk9xN1BGd3h5TUxz?=
 =?utf-8?B?MUduVlJsUHQvRTBuUVZXRldsa2g2b0xPNFJ6Mm9ITzZUR3hsbTFNcUc1WCt5?=
 =?utf-8?B?TVlsdXM0ZjVtWGUzOVRaMVNSK0R4UmtyZDJsR25ra3RsZkNPWU5GWHVyWURY?=
 =?utf-8?B?blBISmVYL1h6OWxVZno4c3RKSzU3cFFxMDc2a2gwd3dxNXJGWFZBZnVoZEJ4?=
 =?utf-8?B?bGZXRnhVaXRNSXdYRGZKWFh2dWw2S1JvUjRjZ2cvc3FVdURFK0tBQ3laS1lx?=
 =?utf-8?B?L3Rtb2s2dHJMeXhmWTJ5V2FSdVpPL05aaWJwK0NLWFpZSEJlZitIemhCcFVJ?=
 =?utf-8?B?aFpHTk1tb2x5TXk2b3MxcTRXVjF5RXJNS3ZnOTk4cmlaT2FTVnJzMFJNN0Jk?=
 =?utf-8?B?YlkzVTdSL01DR24rRzQ4K3ZPVjIzMWIzUDRmRVU4dW42T3dzZUhiM3JtNUo2?=
 =?utf-8?B?aWlocWJBSUR0L2F0Nlo0eFczNWNYdW43YzY1cTdjY0lGZ2JISE9KRmNFNU1K?=
 =?utf-8?B?RWdnQ2FzaFhIenZJeWJ2dERTSXYrZUtuMXR3Wm9ONXJlZ3hYcXg2N0xydGJS?=
 =?utf-8?B?YnR6SkI5L2NHVXlkeFUwUURNNllaZWc4bTd4Y0QrY3lSOFBhWmFRaU9yWEdn?=
 =?utf-8?B?YjBaejRjaUZZVXZ0L0RrczFPQ2tsbVN4VkpaNng5R1BqL1k0Q0lZZ25xSk5M?=
 =?utf-8?B?anI0RXBqa3I5MGlnYjdlTFFnZU9FRmo5T05VSWlCZ2dtNDBSMDZ6K0RPL1J2?=
 =?utf-8?B?TmhxQzFJaGdQbWs5Y2ZiNW1FWCt1SXgyUHRKcWlMQzM4U013a0sveGNJempZ?=
 =?utf-8?B?R0x5My9ZcHlObXNlR0VrOW9ZSktEcmZGL0NrSXJ2a05yY1QxWTVpSjNxNStL?=
 =?utf-8?B?Q3JQU0p2WWttSHFVSDFEWWpTUUw3VE9WOTRQM2U1aXBBVDlYVHpReEhMck5D?=
 =?utf-8?B?b0w5K2h4SWxqNkM0WHpXeWVMSXBNUEt0ZnRUQzJQS2xicXQyaFNoRXpDMER3?=
 =?utf-8?B?SU5PLy8vUERhUElZdi83MFNwY3pkcFFENzJSeEJEK0hWMW53OW1aYVJaQWNz?=
 =?utf-8?B?U3huL1JQRkZZajl2Q1B1RmNlS3ZRQjNMS2w5Y1FSaTVwSmVuckF4VnQ2bTBD?=
 =?utf-8?B?Ri9OM2o0THBXK3pYcmlBeW40WDNHa1hnL2ZuS2tWRUIvdWlLb29iSFRHTHpt?=
 =?utf-8?B?bW42OUt2R2pVdDF5YVc3Tm9kbmVRUmo0cG9qM2M3NHFFMzhUcU1mVWxSVURD?=
 =?utf-8?B?U0tlTzFPTW11Ni81dGphVmJtdWFhRGVLbUNvRWxwREVUVmZrMXlVM3ZLNVJn?=
 =?utf-8?B?MWNwbnJZOHkvOHFUMDc5RllpRWkvZmkrampRakp0T3dIRVR0UjBQREMraysw?=
 =?utf-8?B?VnJlU01xZ0JibnpoVHViUkU4Zk1XNW1HUlFaZFhIOGs3Rzdjd3E5STEvRTgv?=
 =?utf-8?B?dytuWlpkaFdySGZ1cVRUcUE3QXBSaTg0V0hQMERHNWZSQ3JBdXNoeHFDZGQr?=
 =?utf-8?B?aFFURlZ0ODVZblFaZ0pvb2twbGN1YWYrWUZvQzZDN3Bpc3lKRTQreEdBd2th?=
 =?utf-8?B?VkJmZVhEQnpoV1kydmd5RHI5TVJFTnlRU2l6UER1ZTJTbTNUNFBZVVZXTU02?=
 =?utf-8?B?T21sM0lmK0haOTZPcksrQ3pNbERzcndmellob2FKeEZNRVd0L1AwTXI4aUY0?=
 =?utf-8?B?WlJJVjRQT3R1K2MrUDJ6d2pCa0hpb1RPT29UZHBjK24yTmw4MzAwNFhtd3hS?=
 =?utf-8?B?S1VoZmhFaFptQ1E5ZCtGYzRoUWJUcnJrNXdXSlQ0TUc0RzZybjdFeHdRZEJn?=
 =?utf-8?B?ZFVxWGZOa0t6dlBkeDJxOGVlak53UTQrSnlkUUQrOXRNanNBRzZLYnMrR3hq?=
 =?utf-8?B?TzJheGlqNFUwQVIvMlQ5aUtyMHRWUWg5WFBuNWhIbWNwRXN2TllhTjRWV2VJ?=
 =?utf-8?B?MFZ3alA3RGs1dG1MNElWU3c3amFqY1BYaWhjc3BYWUpCNWNPWFhVcUNNY1FK?=
 =?utf-8?Q?M/7YrPHnwlCOaIWQj7MeTH2CE?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54964a74-f61d-4b50-133c-08dd7cd60a19
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2025 11:01:29.3119 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uTvsItUxFvAFQmhWUogyZaUjWklXZYn6EV8Ngqs4+VL+CFa4Ngk4fKvK76uwyqX0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR12MB8446
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

Am 16.04.25 um 10:50 schrieb Prike Liang:
> This debug dump will help on debugging the evf attached gem obj fence
> related issue.

That looks like overkill to me and will just massively spam the debug log.

Christian.

>
> Signed-off-by: Prike Liang <Prike.Liang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c | 13 +++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_object.c         |  6 +++++-
>  2 files changed, 18 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
> index 0075469550b0..7030d721196b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
> @@ -86,6 +86,19 @@ amdgpu_eviction_fence_replace_fence(struct amdgpu_eviction_fence_mgr *evf_mgr,
>  		if (ret) {
>  			DRM_ERROR("Failed to attch new eviction fence\n");
>  			goto free_err;
> +		} else {
> +			struct dma_resv_iter cursor;
> +			struct dma_fence *fence;
> +			static const char *usage[] = { "kernel", "write", "read", "bookkeep" };
> +
> +			dma_resv_for_each_fence(&cursor, obj->resv, DMA_RESV_USAGE_READ, fence) {
> +				DRM_DEBUG("after attach evf the resv dump usage:%s\n"
> +					   "after attach evf name:%s timeline name:%s seq:%lld %ssingned\n",
> +					usage[dma_resv_iter_usage(&cursor)],
> +					fence->ops->get_driver_name(fence),
> +					fence->ops->get_timeline_name(fence), fence->seqno,
> +					dma_fence_is_signaled(fence) ? "" : "un");
> +			}
>  		}
>  	}
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> index d09db052e282..1e73ce30d4d7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> @@ -1675,7 +1675,11 @@ u64 amdgpu_bo_print_info(int id, struct amdgpu_bo *bo, struct seq_file *m)
>  	amdgpu_bo_print_flag(m, bo, VRAM_CONTIGUOUS);
>  	amdgpu_bo_print_flag(m, bo, VM_ALWAYS_VALID);
>  	amdgpu_bo_print_flag(m, bo, EXPLICIT_SYNC);
> -
> +	/* Add the gem obj resv fence dump*/
> +	if (dma_resv_trylock(bo->tbo.base.resv)) {
> +		dma_resv_describe(bo->tbo.base.resv, m);
> +		dma_resv_unlock(bo->tbo.base.resv);
> +	}
>  	seq_puts(m, "\n");
>  
>  	return size;

