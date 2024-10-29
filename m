Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 263D5D5B16B
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Oct 2024 08:42:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C60E510E399;
	Tue, 29 Oct 2024 08:42:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mvENpVCP";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2048.outbound.protection.outlook.com [40.107.93.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B22AB10E399
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Oct 2024 08:42:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g0lvSC0m6LlJuEJls9lta9KU0dISPeUfnhcaxiRkJ7cdrLGIwW1cQpCK5hmi9aKJ9HXYmo0CCGYfdGnhvSGLpnYq5EdcXiS2/mzgQWuCgMqt6iYPeYMAnhXHkcESQOC01lcTR8mfBzZ7uYw8gwKCwwY4kaOLqzERmcOnNHeP07FuVkDusXuw7YEfSNZzWSMmtILvEkt7MD8TeKUG/cSYS3d/EBuw5fC8P7tTfA++s0Xjuyx5fAxYpUhM6NmoYPLqUufBXLqtk85tVuTQBFtGbNaE72tjJdadYWO4CwmrG5HpKMjVbL1SIEQCdLr0LvjeNVg802gRyVeKtEq33bPg7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p6hYVq+QnSEIXaOFLRa5YTNVyavQex0fUDuHo5qptWU=;
 b=X/CMwJy9m+gbpgCtS5HgtTBVfjrIJ0XyBiicCB8jj5AvOQ9FuYT9FM58VRRftv908VepoQ6mUvkoKwM5G8mUmwiMmv9Dte24nFJAjPiRbvYWMNW8iQHFCILgxAxNuNPNHiDGUKji0II0Xiev2vYsl5t0r3QUFcMx8tZWv4SEqJYnYgDo9pVGFfGt7cJoZuipqInzVm9jiFLrhPbysXEUwHQx39Xj7QFnL80nFd8w1DMhgeGEu3ywsCUPENxJvFMFjbpbRHO6gNHywdh2RPO3oymOosTwsACkMoyFfCQAan0d0PJOtXQnodwTWF0VlgCJXBZy927zcQXS102PpHvitw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p6hYVq+QnSEIXaOFLRa5YTNVyavQex0fUDuHo5qptWU=;
 b=mvENpVCP8C8mPvmr05RZK6Tdq0ibCtqEQUOF4db1U72OzcW0VGt3ILo+N8yUg5kLuFxao/Fubc54bY707svxiQ9O7+AdxS0nsZqQfq+v98i6wy6yEysJiYBPjQBKqzFuBx+Sf4lxK6mdUJZa5O2QeFaSqio6F764TtyxDMIltJg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by LV8PR12MB9407.namprd12.prod.outlook.com (2603:10b6:408:1f9::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.21; Tue, 29 Oct
 2024 08:42:15 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%2]) with mapi id 15.20.8093.021; Tue, 29 Oct 2024
 08:42:14 +0000
Message-ID: <9ba915e5-2266-468f-a978-f89a33bb9fc8@amd.com>
Date: Tue, 29 Oct 2024 09:42:10 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] drm/amdgpu: add userq specific kernel config for
 fence ioctls
To: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>,
 amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com
References: <20241024121027.3397-1-Arunpravin.PaneerSelvam@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20241024121027.3397-1-Arunpravin.PaneerSelvam@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0216.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ac::20) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|LV8PR12MB9407:EE_
X-MS-Office365-Filtering-Correlation-Id: 9957cf50-182b-465c-1065-08dcf7f59698
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NE9yRm5pdWZLc2tWUjdOejlUemRjTThWeXBFRjh4QmV3bEN2ZFhKZE5NVll4?=
 =?utf-8?B?LzNBZlhTV2NJSEkzT2tlWXBNREV6SGNlOXNKd0FNUGd4bDJyaEpGVUR3RlNM?=
 =?utf-8?B?V1dsM0lyWFpSR3VNV1FnVURmN05zSlBRNWtJL1cxbW9TTXc0MmpFdVJid04v?=
 =?utf-8?B?N3V1anJoWGF2OGx3OGdvcTViYnhLSmd0SktyNUZqczRNVys4Z3JwTzBMVHBt?=
 =?utf-8?B?azFIR1dxZEFudUJjZEwySHhZNGxyQjV0UmhPa01UY0tsK3hGa0sxUDBNRyt1?=
 =?utf-8?B?YXltN2J3dUUveWVka2VUSUxseGxFNmF6QU5pRUtUZ0IwTVZZK3pYYmxob0xy?=
 =?utf-8?B?QjhSUWlzSC81SWlkMzd0UXYrMmZDamE4Rkl1Tm1oV3ZtMGx3TVdodnFFMGRi?=
 =?utf-8?B?SzFiYVBnRWZKWC94Sk12YXdKWEZPeTYrcDFIWVlxYjA4Sm9MOUNQSVJ1YXRw?=
 =?utf-8?B?OEJDWHZnZWFwMGxnY09rZk52Z3pnZU0xc1lqODRmSlFveGcxSjY2RnQzU0Vn?=
 =?utf-8?B?UFVqTDRNck5RdEphVUtCUFVhbjQ2UUk2L1lWdEJVSDR2RWQ2ZlVFK3NpcXBR?=
 =?utf-8?B?aWlYZDlmZGJOSm9rN3ZYR1NPWnZpak5LalAyT1ZRSEdieDlxQWVwd3F5TGdB?=
 =?utf-8?B?L3hZYTF0dWJxS2k0UTZnc0lYN0tGL2hETkdZWUR3RVE0Q3F1N0FyLzRFMFpF?=
 =?utf-8?B?Mm04UG5MVFFXVWtNd0d6VjJaaTc2TUxscW9CSU90U1B2aHd6RWNvQS82N1Jp?=
 =?utf-8?B?VXAzNzJSTkxLaEtjT2t0R3doditCRWF3TGNBZGsxblVCWm1ueGZtd0h6UGhD?=
 =?utf-8?B?N3ZZN0wxZEowT3ptazk1dkNRaW5BU2VkWGUyTFBHYzlXT3MzelhCVnVsM3Zs?=
 =?utf-8?B?UitRdk5uOTVIdm9CUGV3TktSc2xDYVBHc0hpNE85UWt4Z0ZKejFaMnJKOVBt?=
 =?utf-8?B?MnZTQ3JnVFR0RWJldWJNK0lKcUsrS3lzdkFpVnh4RE5DS3NjMG5IUndtSWhU?=
 =?utf-8?B?RlVkcUpMelRhSkQ0UURhOXVmQjY3a2hJdG1Pb2c4T29abFpCVDZMQ1Z4WjlY?=
 =?utf-8?B?bmljNXJjTHU5c0pmVytWa0ppTzZueTBrWnVhdXVLM3NRdkVid1ByYU4rcFl0?=
 =?utf-8?B?WENHaWJGMXgydjJoM3NCM2ZvNWdiYllGVXI4eHZncTVQL2lVMGJFNnZVOTNm?=
 =?utf-8?B?TEMvSjFxWDVrcE41UWtYc0JORW9UVVlwajVUK0hVRDI1WSt3MFJXVVVleUN6?=
 =?utf-8?B?YXR4UVRTbjNkQ21XY0ZvT04yc1l3RmVpdVpiT2xSZDlwdEgwR2tGUEttcGFC?=
 =?utf-8?B?bFFLbFpiMGwwK1ZCVElHMFR2MHpXVStFSmpVZnV5K3p3bjR1NXhZNTNWRnV6?=
 =?utf-8?B?Q2creUpYZDdITEtxVHZsODZ0RmdKL1NTTStPcEt3dVhDUHp0N1dtMzZ4U1No?=
 =?utf-8?B?dThHNFI0QldoM3ZNSXlSdEhwTmRxNzF2VXhWUWpjaHJ1SEIxb2F1dXhrRXVU?=
 =?utf-8?B?MjZEeXo0ZXNLNDhLV0dKdGYyMDdKRm9vNUErR3FacGliUENHQjJ4YS9iU01n?=
 =?utf-8?B?ZzlPME5vQURKMGhGL0RKYTg1cFVVeXRoNW1maElGK2t6UEhPN1l6UFNuNGVD?=
 =?utf-8?B?bExua2NLNUlSUjVUSXVVMjFIMFIwNVVSVGV0Um4wVWFZR3JlZkxDcjlvRUlu?=
 =?utf-8?B?MjR5bkRxMlc5MWltUkJIcWd0WjJnaWN5Yi9uVy9sdkhUb0cxVWc0YVFOWVFP?=
 =?utf-8?Q?bNWpXwzCLFbj4pf99Q=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z0UzQy9mQk9Xc2hVMkh2ZW5QdFh2ZUs5cDVMNTVvTno2cXIrVFMycURWTXha?=
 =?utf-8?B?ZjI3djRzTUVPbjFLMklkaDNieUt6RlBobkVuUlJxNlBEV3lLaDAvMlRINkh5?=
 =?utf-8?B?WUxMTWV4TjlkalNPUFQrMDNjcWhrYVJLSlJJT1Bpc2hMWHNSbzEwTWlod3dO?=
 =?utf-8?B?ZWtOb1BvRTFDc0piRDVBWFRWNW05eGtkdTVINVpjYStaVms4QW0rNXhGUEli?=
 =?utf-8?B?ZWE1dVlhaWlKUXpTWWUvUUVRaU41b1VVdjFxVnROVDQ1WWZhQzdUNklleldE?=
 =?utf-8?B?ZElZSFNmYUlxSTN1L2Ixd28wQnhMRDlIWXJ3bFM0UGYyOTF5ZkY0WDd3SDhT?=
 =?utf-8?B?ZFY3Rmw2VjZ3ZGxHTko1QWV1Ukh0SE1NRExWTXl4bWtrRU1vc1dwVjM2Ukd1?=
 =?utf-8?B?NmUxaklyQWZjN0RJTlhDMFhzdHdLSUZITXNMWk5McmdEVkx4MUg5TDFwQmJB?=
 =?utf-8?B?OXNjTXdYT0NZMW9yOWx0NnVERm01eFoxcmREVDJEYUJsUXFicmZkM0R2czkx?=
 =?utf-8?B?NzVud3cwVkN0ayt1SVQwMk82bGlpUlNCRzBoSWJZanNld29MYjZiRTVQK3dM?=
 =?utf-8?B?V3B4TXdXOVpKR1pRZHlrVTBQQ0lTdWk2Zk0wUkFzMTdQSCtqU2tWVU1KZ1Jq?=
 =?utf-8?B?TWpLQXhoL2lOdUJlYVdwYysxNDMwWGNaajBHZUJCbEl0TFFkUko0d0g4WW1m?=
 =?utf-8?B?cFVUUmRZZ2dlUDhldUkxK20yUFQzSnFzMFZNVkFmZ2lyeVBIbmtKRkhvdURn?=
 =?utf-8?B?WXNIbUZ5b1VjYlFNZ2V0cHV4VlRzR2pWUkFtVHFEZ2VZMU82ejkrZCs3bGFH?=
 =?utf-8?B?ZUZSUEFwR1M4dGZKdWlzUHFEMFlNTlk2L0JxUUNsdlA2bzFJVFFkK09pdU56?=
 =?utf-8?B?czlBZ2FKVGpOS0UyWERrMnpHWjV6OEIyTFVnRzhEc3AvdWZhclVsWGE2Q2Rn?=
 =?utf-8?B?K2ZCbHUzTCtObUQrS1dHZm9ncU4zQi9kd0VFc2xwTVpNV25hOWJlSjVneHF4?=
 =?utf-8?B?Z0xjT2Z3ZXV2YkdWS0wvUWhNVEIwV2NFYlRZdERISEoveFNJZXI3Ty9WYTA0?=
 =?utf-8?B?VVR0VEt1NWRBek02Q3pjMmFscDV1SXdXUTBPbWQ0NEdWYWtzVEtmK1I0emhj?=
 =?utf-8?B?OVdWWTlIQWErbC9DeHEwcnpSTitua3lxcVNyN0hnYVhLRUJRTzhmTDFKaVlG?=
 =?utf-8?B?dkdDUTZ5YlZ2ekxCc2Z0bHE4QiszQ2NDMXZiSURUcGpwUWxpYXJCZFBUNXlZ?=
 =?utf-8?B?aGZ2aEFTVHZYK3ltWEtrWnlXd2xUM0pmcGcvSFIyazgzTmltQ0RQTjJRaVZq?=
 =?utf-8?B?UVIrMi80dWQ1ZEVZeXNySkRpWVZRRVQxeFBUcXp6ckowaXMwS2dZM2M3VWpq?=
 =?utf-8?B?cjNIUmlxdmRiVFVXRHNLT01lUUh0UFp3azdwL0twK0VrMkNpSXJmenFhczR6?=
 =?utf-8?B?ZWNVNHdKbmhYbXh6RVpUQUExQno5K2FUYVdoN21TM3ZyenZOSWlrNm9Oa1dP?=
 =?utf-8?B?UDVRUlN5ZXgyRFBMRjdSU09MTkRvMG9qQnByZU5mRy9ENXRFaVNIRWZvU1Bi?=
 =?utf-8?B?TEthWDdzSmF2RW96cExHODZMcWRQYnNIZXRjR21xQ1hpeGx4NndyeG13bTBW?=
 =?utf-8?B?QjdsNGdMS0NTQ0Nra3daUk43ci9aZ2IweHdXdDUrZkRZQXpnMjFRbG50Vzcv?=
 =?utf-8?B?S3BTQTgzQUh6enhhb29LaVZIVEtiZ1A1bVBKTEdzTkxyRFcrZUNIQ3BId2p0?=
 =?utf-8?B?TS9SYVo1a2NvdXZHT3RxOVVPem4wcG5ZUHd0b21rMy8rUkNwbkYxUWlZc3Ev?=
 =?utf-8?B?bXl4ZUs5VE00bEUzdzJTRit2NVNEVXVwUTNxZHNsY2VuTmpCNXN0S3JsaGpT?=
 =?utf-8?B?NGptNzVqb1h2YUd0bTJmNXZydm1rUzBESGxuUlU1OGx2Q1V0Ri9LSFdSUlFM?=
 =?utf-8?B?N1JvQU1qemJIbkpxdEdIL2J6bFlKbmdsWkZlV2EwN0JnZUJNN0RYT2t4NGJX?=
 =?utf-8?B?WDNZZngvR0xFMHE5SXRzbjUyL1k5TWJaODRTbWFCeVJMekpqWnU0bTdGdnZ3?=
 =?utf-8?B?cnA2OTkrVlUzVTdzdHV4OXdLZm10b1lkbFd3blNESnIvU1QvTzVyd0FPZmR4?=
 =?utf-8?Q?OWKQ8r57tiZ0DjMtFaEu9xCeD?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9957cf50-182b-465c-1065-08dcf7f59698
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2024 08:42:14.7136 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5slNnqhH4tiBezEY0ML7UivBFgkYIU7vE0EOCW9Y0zh3AoEBNZkk3S73JTeRxm5U
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9407
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

Am 24.10.24 um 14:10 schrieb Arunpravin Paneer Selvam:
> Keep the user queue fence signal and wait IOCTLs in the
> kernel config CONFIG_DRM_AMDGPU_NAVI3X_USERQ.
>
> Signed-off-by: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c         |  4 ++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c | 16 ++++++++++++++++
>   2 files changed, 20 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index 70cb3b794a8a..04eb6611d19b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -2971,9 +2971,11 @@ static int __init amdgpu_init(void)
>   	if (r)
>   		goto error_sync;
>   
> +#ifdef CONFIG_DRM_AMDGPU_NAVI3X_USERQ
>   	r = amdgpu_fence_slab_init();
>   	if (r)
>   		goto error_fence;
> +#endif

That here makes no sense. This is for the kernel queues and not for the 
user queues.

>   
>   	r = amdgpu_userq_fence_slab_init();
>   	if (r)
> @@ -3003,7 +3005,9 @@ static void __exit amdgpu_exit(void)
>   	amdgpu_unregister_atpx_handler();
>   	amdgpu_acpi_release();
>   	amdgpu_sync_fini();
> +#ifdef CONFIG_DRM_AMDGPU_NAVI3X_USERQ
>   	amdgpu_fence_slab_fini();
> +#endif
>   	amdgpu_userq_fence_slab_fini();
>   	mmu_notifier_synchronize();
>   	amdgpu_xcp_drv_release();
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> index 279dece6f6d7..bec53776fe5f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> @@ -318,6 +318,7 @@ static const struct dma_fence_ops amdgpu_userq_fence_ops = {
>   	.release = amdgpu_userq_fence_release,
>   };
>   


> +#ifdef CONFIG_DRM_AMDGPU_NAVI3X_USERQ
>   /**
>    * amdgpu_userq_fence_read_wptr - Read the userq wptr value
>    *
> @@ -502,7 +503,15 @@ int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
>   
>   	return r;
>   }
> +#else
> +int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
> +			      struct drm_file *filp)
> +{
> +	return 0;
> +}
> +#endif
>   
> +#ifdef CONFIG_DRM_AMDGPU_NAVI3X_USERQ
>   int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
>   			    struct drm_file *filp)
>   {
> @@ -797,3 +806,10 @@ int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
>   
>   	return r;
>   }
> +#else
> +int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
> +			    struct drm_file *filp)
> +{
> +	return 0;
> +}
> +#endif

Not nice, but since CONFIG_DRM_AMDGPU_NAVI3X_USERQ depends on 
CONFIG_BROKEN at the moment probably ok as intermediate step.

Regards,
Christian.

