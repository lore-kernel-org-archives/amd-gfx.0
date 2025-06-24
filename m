Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70B3EC7EE2A
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Jun 2025 08:26:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1362C10E21E;
	Tue, 24 Jun 2025 08:26:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="h2WPxY0r";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2043.outbound.protection.outlook.com [40.107.244.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0994210E21E
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Jun 2025 08:26:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YATwBv6NT8LfsSHFJE6J22cvUonnG3ERZD7oDyjAfDwJ2oBhPXxtjoZVqPmcGFXhPhebzLFQ0y+1Zb2Kp2EW+fj+jhm/s4n1owiHHeDdT2Hx5V9OuePhCCZhj8twPI3cFzZrBlJ+AbNvwt0hjtsJTcXBxVYHsv8+Xts5BzQoB8kIcSNjI7YQSkBL6wKI67sKq5JJsVxIYqhxYuI14edoLCSdow1zpzrnFdM9KRD34JVXRAqyrJ20Nwu69IzOMXlnr/cEpJujaXBQqvsYCetlSh7Ov1kds629OnlCrGfqN3CN66kRxWWcjAs9/fIz4YxwAuYcJEz9CCvCcB2jT+DXyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D/egrd2OE591nrhiCZxvwWRzQ+IH8oudnxT7W8GC22k=;
 b=lXRCXh5cKDjPv/Tk+gcL1o0LR2ZJbEQZweXdEaCDR7tWRyUC+XV1X8jLrTcDB046z6/iKsuYwC0DRIX/2pUxumwsYu7pUUND+EV2hKEN0uehniwWhVAsefRkgMUiu4MpTjoHYaALPsDLIZMZqe0VmPRNdylDQfy3MMSx4AH5IKGbpW4/JdPMMO60aeo/fFm7gkRNzHPKmLHP/ccwaL9WKPcm7bC8cvj8oKpxXtqm51jr/360xW80aUgSIGUChFtIsEbRINIh4yXQmh0OP89AGz8qLlFcplYGkGQhOEk/rLMmN7Y8wvEA36PBxHBmCCAcEi61RW5ELrgOjJjza6VxLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D/egrd2OE591nrhiCZxvwWRzQ+IH8oudnxT7W8GC22k=;
 b=h2WPxY0rDW6tqDSH18zcu65PMAQB13J9QmX88LZxgqQP2Ng73ioxO6HxPVmK3X+bsdZgvPmE3nyhgA0SdCuhboQ9zM1wcxrvBCZ3oRmLker+6zHyfZrJb1Eaj9jtd2h+RLvI2TKO24sesWuWFZKfWRvJXLBuLJZ+Z4i7B6MNG8I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by IA0PPF1D04084C7.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::bca) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.28; Tue, 24 Jun
 2025 08:26:08 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%5]) with mapi id 15.20.8857.026; Tue, 24 Jun 2025
 08:26:08 +0000
Message-ID: <771f083d-be07-4080-a191-d264c355c66c@amd.com>
Date: Tue, 24 Jun 2025 10:26:04 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Unify Device Aperture in amdgpu_info_ioctl
 for KGD/KFD
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20250623111717.224707-1-srinivasan.shanmugam@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20250623111717.224707-1-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0151.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ba::17) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|IA0PPF1D04084C7:EE_
X-MS-Office365-Filtering-Correlation-Id: 553ac5bc-1c6b-4f7f-5a13-08ddb2f8c4f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dUhtZktoNE5EQU4yMFFrRWp0M3prbk9ORWlZWG4wWC9kNzBHcWNmY2I1QUtK?=
 =?utf-8?B?MEx6MFNUNzgrSWFobHl4NG9SL2l6T3NXaXAwcnhpak91dWlib1VaOVRaOVZm?=
 =?utf-8?B?UXVvV0F5WWlxbi9sbXBPYng3eFI1VFowMkdUbFhIam1tYmpKVTZtR3FrS1lE?=
 =?utf-8?B?dEp4dlFnbnFBZGZGNkUxdHVuQUgraitWWE16UEZxU3EyK1dQV3A3ZG83WGRx?=
 =?utf-8?B?Z2Z4VTBjTG5RTnpGNEgxNndPSENnZGkxYTZlVUQ4dzZTalpFc3FHMjVXV2FV?=
 =?utf-8?B?Ry9JZVhMWTNteGIxUytCKzNXYmt0ODVDdVdpVldWaHVQS1pXamUvcnFDUTlT?=
 =?utf-8?B?a0pTVFNsOUxNelFta1RGaFlSYm5wRUkybklCdVJqOHhUU3MvNm5iWXR3L3Vy?=
 =?utf-8?B?TGVTaUF3bGI4YU52MVlGQnk3R0EvM3Vvd2hCQWhUSlYwQ21ia0xDVEJtcnUx?=
 =?utf-8?B?cTNvNDRPZTlTR0hqRmpQSjU4QjNETUxYZHdsQURkbXZQMEZCd3BvbENOMW96?=
 =?utf-8?B?QVFzS3BvRlllWFlkZ0V5TnhoalZpUUlWdENOZ2xRV0pSazlCTUFINWlCUUxp?=
 =?utf-8?B?YWMrQ0lmTVJqZSs2SG54QURCS3poN05lUFYrLzhUOWlRdGtoVFcwdE1RbUts?=
 =?utf-8?B?NDBsUTlIdXc3bDNMV0NwdWllSi9Qd1RJNG5Ub2FXUnVUaEV6d3ZaanBOSWor?=
 =?utf-8?B?bXFwbFR4ZW8xRXNyeVJlUUp1TXBVTkh2eit1MlRzQ1hKRXZGd1NGR3VyU0Nz?=
 =?utf-8?B?UVdtSC9RalJzNUlJK0lZWU5PMUZvVFJrZ21Db01mcFhkM0U0WFBBdFhyNits?=
 =?utf-8?B?dEtUZ2txVXpTUEN3VHdzLzg1dXpLRHoveklXODNEV2hWWWczajdYUmNybFNa?=
 =?utf-8?B?M0xEUlhLUXhmKzR3emFyd2Y5M3lNS0pUNVZUZktKMDdwa0hqRVB5Q0tDRjUw?=
 =?utf-8?B?QU9acGEzTzIrdXBnMmM3R2dJNE5WbFJ1bzFaK3B3dllpdm5XQnJxL2lrbzFM?=
 =?utf-8?B?dDdudUNsWkVsblgvTjVmS3pGMGlBSEs2cDk4eVBUSVNYWUdZbTFaTmVHdkcx?=
 =?utf-8?B?MXFSYzNXOWZpbUhYR2FaUlJVb0h2cDBkY0ZpQ1VWdVFnbHh4S3l1MllWQ0Nu?=
 =?utf-8?B?UkxhQ00rSS8vUXp4YlZac2V5VDdkK2ZhZHZveTBvYkYxZktGMWNMakxKRVNN?=
 =?utf-8?B?a3YvWUNNMlFqbUxubEh1Vk1UNk8rakpBU2M1YmJ2RjdWZWs3TjVJYTU1cmZ3?=
 =?utf-8?B?SGVpZlZvN1ZFcUc3ZjlWVEtadFk2ODVQb2xqY0lvSC83WVlLSWs0VXpIc0x0?=
 =?utf-8?B?Umt6ZmNzZnp5anVyTnN6UExOL016cmJoTklLTmRMRDhybXdEMkppZkZQU1Ju?=
 =?utf-8?B?dVlyZDIrc3NwYUpkYm41aFJpWVhNR1g1U25udjF4NUUwcVR4MVoxd2IybG9z?=
 =?utf-8?B?dU5oamJoUHIzcHYrM3BZeURUTlNmYUlxazNZaUQrTmh2TzhCaUVnUDBlYk44?=
 =?utf-8?B?WXQ4YTB0c3MwdU9oVFpzb0Y3REMzNUc2NHZKejhLN3QzellPOFVxcmxnK0cz?=
 =?utf-8?B?WU1NTWI2YXZZRE8xQ083QktEcWcwNHdaeGQ4NjZ6MGx6RmdEYmpvdzFIYUdz?=
 =?utf-8?B?d1Y2WHZoQTBqRVpZSmlpTG1lRUU5RGZVdDR2YVZlaHpqdW5sWTl4S2NTS0RE?=
 =?utf-8?B?L2RleUpaWTFhVDI4cXZCNWgzMlJUWnZyeEpNREFLdWtkelVETFhLSEVjQ3Jr?=
 =?utf-8?B?RDFzaEZ4K1ZkU0RPVzhhaCtqeDdhYytzVGFXYTl0MlhHZHBkWEtwei9GbWVx?=
 =?utf-8?B?cWdnSDZZc0I4TmZ0KzhWa0xJaThacWZJQ0xWMGRvQXhwM0Y3TlM5SzJVRnZS?=
 =?utf-8?B?aHFOdnl4c0hib1I4ZGdWOUhZTkoySktCMnFlTjd2NkNsK2l1VjJnT24xMUlh?=
 =?utf-8?Q?YWLq6mtJXDo=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VUIvNjJCTTBPT1lqL29MQVFTVTJzUXRja1RSd2VCRkthTmswV2FPbXBTbVhi?=
 =?utf-8?B?bGJha0kyS2k2Mjk3VzBrOTRCVDFIT3g3TjQ3Q3Y3MzZBOVdOV1lEdm1lTFBa?=
 =?utf-8?B?U3Ewd3ptTnNGRlU1cnljcFU2NDFOZUNlRklpUnN6V1BseVhZcXhmdXdNY29a?=
 =?utf-8?B?dzIydlBJR2p4UlhCTk9YRWo4VExjUDNuTjBBanRxalVySXNoL05wUUovV0ov?=
 =?utf-8?B?ekJKejlQUnY1RmgzMUR3cnpQR1BuSkd3dHBVTFBmQkZZRy92NUZXUm1vRXdH?=
 =?utf-8?B?d0ZJV2xqYzVMN3BDakZKa2xCYkhITDAwWnFSRGVNSkZXcllXNHpPdjBTdU1I?=
 =?utf-8?B?allqczhMcDVjeFdEYy8rSXhnVXBaSnRSSnNETnNNQUo4b2R4SEdxNWRiNVpp?=
 =?utf-8?B?SzFtVXdKT28rT2toNWx2QTlvZm0rcUxocTlHOCs1T3kyWEtFdDhhY2NwTmJj?=
 =?utf-8?B?ZnRoZUU4OU1DTk10bHdUSzBBRy9VYThZblVtZVFJUjdqSkpBS0pHbWNxYmtn?=
 =?utf-8?B?U1Y0RXFaMGhWc2hua09UczFrNGpCTGJZRHhrV3ltbVpDWjN4SkxiK1RPZUZY?=
 =?utf-8?B?UUZRUzBtdWR1NDRQSzZoWHdJTElyVnc0d1M1Z284V0V6T0ZrcWpLZEMrYmJQ?=
 =?utf-8?B?a0l6T1FER1NSRThYd3hrTDRnN2JkRmUzaVBxUzJ2RU9JK0ZrbnVXUU5KYXR2?=
 =?utf-8?B?MUloSFBHU1prWUdzdjZYNnFNdzlDSThqRFo5Vjc0L3dHdFpIT0EwQVBZTVdQ?=
 =?utf-8?B?aFVBWkFFQjlIcTZ5SGYrd1dRZzFMb0FIdzJXT2J3aWZLbG9DWW9vY1BKbFdo?=
 =?utf-8?B?YVFQY0UzQlRhbFYycjhiL0llZENDVEJOeDlVWHI0TkhXckZGWFZrc3RlV25E?=
 =?utf-8?B?ZEpXVENVOWo1b1JzNXI1MklnYkNUUDdCTS9zbDFaVTJhdHlROVdTOExMZkJF?=
 =?utf-8?B?NHVMNnZpRzdzSHBJUGxmS3V5RnY4ZmNHVkFQN0Q1STY1RXNzSk5NV3VHOVJt?=
 =?utf-8?B?VmFtdHEvS2xkbzNvRGk3ZzJ3ZFllekhJeE04QWpHV05XZEhLZUM1cmFWaWRF?=
 =?utf-8?B?ZkFoSXRGeFIvdHJuczBzRXcwY0VEZm85S0k0dHF2Zis2S2NiNloxZ1R3dlZG?=
 =?utf-8?B?Rm5jM3hpdDhPU0dyWmlqRmc0SCtBY3BWbVpPZW85N1VxUFpIYzR2bUJCK2ZR?=
 =?utf-8?B?U0ZielBvejhmcFRmcGt5RlNNUlpzVEt5eGR5YTBSQ0dZQk1UbjlPUHdKaWxN?=
 =?utf-8?B?UENhMWtTeDA0T05nS2M2UkY1a0tkNzY1SjBWRUdHTWZJT1hGNE1xQUJYSHFY?=
 =?utf-8?B?VlBiajBBU1Q2NDR5RktmUGNHeEM2SFI0aXk0TGt1ZXlvdVNTODNaUHg1bjEz?=
 =?utf-8?B?QmpPTGVmZVkwS0MrSWZqMllSbXJTV1hxdlJjRSt2akp2a2hBekV4dDB1UFls?=
 =?utf-8?B?MEVDd05uKzluRDEwMnZ5TWwrWk9xZFBlVHJyV0h3V0ZVcmRNTDkwbUFabnlo?=
 =?utf-8?B?eGc4YzZDVmJTOEVuREFzUWljd2NKVXhFYWZBMWVMM2VobEYveUdVUmJuZEM1?=
 =?utf-8?B?Y003TGE1T3dPbGJ0QjNvczIxSDlJSWR1bjVyRGVDU2V6Q1FXSkozZzh3NGJE?=
 =?utf-8?B?MjZFMFpLeFhDdDF1akIrV0tBK3RPRWpxek1LL0dVcU1OMjI5RXVuVGZDOGti?=
 =?utf-8?B?dGVhWE5qV2xIZmlYNmQ4bkRvY3JnL2RFL3UxVXkySWI1R2VlVnJObWRkUVph?=
 =?utf-8?B?Y2g4UVY5bG1Ua1VralZncHRzSFpFNWxlSEFCdkVFZVppcFB5NG5OZkFGNnN1?=
 =?utf-8?B?aVU1ZDNxbUEvMjJTa0l1VWxsTWVjcmlKcytNdzVuYVVFUGJhODhVM1pleHZs?=
 =?utf-8?B?UW5mZGZ3NjdiSWtZcUR6STFGemxlK0czMkcwYk9EbTBhWExRNEFyd05jZlQ4?=
 =?utf-8?B?NUVkd01FeFpGRWN6ZkxVdmlkM0djNGJsSEMyVEZMWWswN3B0UG5tM3RpQVU2?=
 =?utf-8?B?TnFuT3VBeHU2NXlQUmxwRlU0M2dnNTdpdkUvdnltWkNNdi9qN1JabTlqc2ky?=
 =?utf-8?B?Mm0zbEE3ZWE5cTFVMkpQMHpzWXVOWWEwS3BDRjFTZVNFQ3VkQzJ4QkxWeUlj?=
 =?utf-8?Q?50nmgLPpZNiWJAN5EGFy+iWw+?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 553ac5bc-1c6b-4f7f-5a13-08ddb2f8c4f8
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2025 08:26:08.5526 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nVPKHb2soPq3FOxmhlj7RHYIT67Yu83q52Rrxb3F0cPttftfinrcnFUSHVeZ+hzl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPF1D04084C7
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



On 23.06.25 13:17, Srinivasan Shanmugam wrote:
> This commit refines the amdgpu_info_ioctl function to unify
> the reporting of device apertures for both KGD and KFD
> subsystems.
> 
> Cc: Christian König <christian.koenig@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c      | 23 ++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h       | 29 ++++++++++++++++++++
>  drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c | 29 --------------------
>  include/uapi/drm/amdgpu_drm.h                |  6 ++++
>  4 files changed, 58 insertions(+), 29 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> index d2ce7d86dbc8..6ca399a92814 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> @@ -46,6 +46,7 @@
>  #include "amdgpu_reset.h"
>  #include "amd_pcie.h"
>  #include "amdgpu_userq.h"
> +#include "amdgpu_vm.h"
>  
>  void amdgpu_unregister_gpu_instance(struct amdgpu_device *adev)
>  {
> @@ -1011,6 +1012,28 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
>  
>  		dev_info->userq_ip_mask = amdgpu_userq_get_supported_ip_mask(adev);
>  
> +		/* Retrieve Device Apertures */
> +		if (adev->ip_versions[GC_HWIP][0] == IP_VERSION(9, 0, 0)) {
> +			dev_info->lds_base = MAKE_LDS_APP_BASE_V9();
> +			dev_info->scratch_base = MAKE_SCRATCH_APP_BASE_V9();
> +
> +			dev_info->lds_limit = MAKE_LDS_APP_LIMIT(dev_info->lds_base);
> +			dev_info->scratch_limit = MAKE_SCRATCH_APP_LIMIT(dev_info->scratch_base);
> +		} else {
> +			dev_info->lds_base = MAKE_LDS_APP_BASE_VI();
> +			dev_info->scratch_base = MAKE_SCRATCH_APP_BASE_VI();
> +
> +			dev_info->lds_limit = MAKE_LDS_APP_LIMIT(dev_info->lds_base);
> +			dev_info->scratch_limit = MAKE_SCRATCH_APP_LIMIT(dev_info->scratch_base);
> +		}
> +
> +		dev_dbg(adev->dev, "Node ID: %u\n", adev->dev->id);
> +		dev_dbg(adev->dev, "GPU ID: %u\n", dev_info->device_id);
> +		dev_dbg(adev->dev, "LDS Base: %llX\n", dev_info->lds_base);
> +		dev_dbg(adev->dev, "LDS Limit: %llX\n", dev_info->lds_limit);
> +		dev_dbg(adev->dev, "Scratch Base: %llX\n", dev_info->scratch_base);
> +		dev_dbg(adev->dev, "Scratch Limit: %llX\n", dev_info->scratch_limit);
> +
>  		ret = copy_to_user(out, dev_info,
>  				   min((size_t)size, sizeof(*dev_info))) ? -EFAULT : 0;
>  		kfree(dev_info);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> index f3ad687125ad..6ee09df0d345 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> @@ -184,6 +184,35 @@ struct amdgpu_bo_vm;
>  #define AMDGPU_VM_USE_CPU_FOR_GFX (1 << 0)
>  #define AMDGPU_VM_USE_CPU_FOR_COMPUTE (1 << 1)
>  
> +#define MAKE_GPUVM_APP_BASE_VI(gpu_num) \
> +	(((uint64_t)(gpu_num) << 61) + 0x1000000000000L)

AMDGPU_VM_* prefix for those defines please.

> +
> +#define MAKE_GPUVM_APP_LIMIT(base, size) \
> +	(((uint64_t)(base) & 0xFFFFFF0000000000UL) + (size) - 1)
> +
> +#define MAKE_SCRATCH_APP_BASE_VI() \
> +	(((uint64_t)(0x1UL) << 61) + 0x100000000L)
> +
> +#define MAKE_SCRATCH_APP_LIMIT(base) \
> +	(((uint64_t)(base) & 0xFFFFFFFF00000000UL) | 0xFFFFFFFF)
> +
> +#define MAKE_LDS_APP_BASE_VI() \
> +	(((uint64_t)(0x1UL) << 61) + 0x0)
> +#define MAKE_LDS_APP_LIMIT(base) \
> +	(((uint64_t)(base) & 0xFFFFFFFF00000000UL) | 0xFFFFFFFF)
> +
> +/* On GFXv9 the LDS and scratch apertures are programmed independently
> + * using the high 16 bits of the 64-bit virtual address. They must be
> + * in the hole, which will be the case as long as the high 16 bits are
> + * not 0.

That is not 100% correct. The high bits should also not be 0xffff because then we get into trouble with sign extension.

> + *
> + * The aperture sizes are still 4GB implicitly.
> + *
> + * A GPUVM aperture is not applicable on GFXv9.

That's also not correct. We have one APU case where even GFX9 has a limited GPUVM aperture.

> + */
> +#define MAKE_LDS_APP_BASE_V9() ((uint64_t)(0x1UL) << 48)
> +#define MAKE_SCRATCH_APP_BASE_V9() ((uint64_t)(0x2UL) << 48)

But I don't see where those defines are actually used.

> +
>  /* VMPT level enumerate, and the hiberachy is:
>   * PDB2->PDB1->PDB0->PTB
>   */
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c b/drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c
> index dbcb60eb54b2..fdcbb400f618 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c
> @@ -277,35 +277,6 @@
>   * for FLAT_* / S_LOAD operations.
>   */
>  
> -#define MAKE_GPUVM_APP_BASE_VI(gpu_num) \
> -	(((uint64_t)(gpu_num) << 61) + 0x1000000000000L)
> -
> -#define MAKE_GPUVM_APP_LIMIT(base, size) \
> -	(((uint64_t)(base) & 0xFFFFFF0000000000UL) + (size) - 1)
> -
> -#define MAKE_SCRATCH_APP_BASE_VI() \
> -	(((uint64_t)(0x1UL) << 61) + 0x100000000L)
> -
> -#define MAKE_SCRATCH_APP_LIMIT(base) \
> -	(((uint64_t)base & 0xFFFFFFFF00000000UL) | 0xFFFFFFFF)
> -
> -#define MAKE_LDS_APP_BASE_VI() \
> -	(((uint64_t)(0x1UL) << 61) + 0x0)
> -#define MAKE_LDS_APP_LIMIT(base) \
> -	(((uint64_t)(base) & 0xFFFFFFFF00000000UL) | 0xFFFFFFFF)
> -
> -/* On GFXv9 the LDS and scratch apertures are programmed independently
> - * using the high 16 bits of the 64-bit virtual address. They must be
> - * in the hole, which will be the case as long as the high 16 bits are
> - * not 0.
> - *
> - * The aperture sizes are still 4GB implicitly.
> - *
> - * A GPUVM aperture is not applicable on GFXv9.
> - */
> -#define MAKE_LDS_APP_BASE_V9() ((uint64_t)(0x1UL) << 48)
> -#define MAKE_SCRATCH_APP_BASE_V9() ((uint64_t)(0x2UL) << 48)
> -
>  /* User mode manages most of the SVM aperture address space. The low
>   * 16MB are reserved for kernel use (CWSR trap handler and kernel IB
>   * for now).
> diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
> index 45c4fa13499c..a52683ae7115 100644
> --- a/include/uapi/drm/amdgpu_drm.h
> +++ b/include/uapi/drm/amdgpu_drm.h
> @@ -1477,6 +1477,12 @@ struct drm_amdgpu_info_device {
>  	/* Userq IP mask (1 << AMDGPU_HW_IP_*) */
>  	__u32 userq_ip_mask;
>  	__u32 pad;
> +
> +	/* Additional fields for memory aperture information */
> +	__u64 lds_base;          /* LDS base */
> +	__u64 lds_limit;         /* LDS limit */
> +	__u64 scratch_base;      /* Scratch base */
> +	__u64 scratch_limit;     /* Scratch limit */

It might be better to have a separate IOCTL instead of extending the amdgpu_info_device structure.

But let us discuss that with Alex and eventually Felix on our weekly call.

Regards,
Christian.



>  };
>  
>  struct drm_amdgpu_info_hw_ip {

