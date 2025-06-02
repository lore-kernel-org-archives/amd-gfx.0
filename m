Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADE2BC5B549
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Jun 2025 08:44:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2BFD910E4C4;
	Mon,  2 Jun 2025 08:44:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="VBiG6VNk";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2088.outbound.protection.outlook.com [40.107.236.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C894D10E062
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Jun 2025 08:44:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TTFiMhT8ZNJ7QAgYyl8hSncBrdPkHa6CXw5BTK3yJvyxAXZYAw1VxkzcULew2+N7m2zDF3eMwqLORCxyRyB2q+KAKV6VBkjiyK8xWDLegc00Zzj0rBvjtrayRL+cyQRg25+uNT0igLbW15JHJi1ilIrRQ2NUGxcEAkg3lXvjEasytJUkAYn2XpL7oT51HRC3vKRgkHBSfeLlw5wk1RFfELP4tdjNaN8wXBQkG5Lxv6/+pg+jK750SuZipQYRGbxUPGxYyTUifNivA2cX01ktlLqCCPkJ4ZKmpTPL8LIcXkF0pPcBFJGHM0jLjTFgpTqsnMmE5aff66qzGMtPvlovMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+5cGItf+HMN9fmbwPSGjNqfGq0TjRaQ0gQmGDiuEKm8=;
 b=YntepeTPkzVAvEiT/W99fMKlbsh3kt4ZHPAheKUpJ5ie/UgZkVATpQwOlmm2tSBIvGGsLLQoCNkmjbeoOpbndnQ+1+vw5T9yhwweZ1QMPIf+bySbqjGQ5zVkT/x5+V0V7xcds8IqeAAXs51oniYxeJj+BDYcam0ORJz9r2CsGpkfyzPDYFgd10F7yMpir0i2mYQskaJgwQGK2zD7d7zbW6amq/7jkUjg50AdukmsYX1nSllXneqoDAy+XtVSyuRpW1B1pvBTCC/h7pFM5suhqhBSkm7lsb8ak5UX/VmI+25fpPZzAaHuLpOzRlxtq5eimwqC2T3NlyOGd8xpgPygqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+5cGItf+HMN9fmbwPSGjNqfGq0TjRaQ0gQmGDiuEKm8=;
 b=VBiG6VNkZRkApAZpWmIzd++VmPfmkb3jzSu68XD2UU92PGoUsJf715oeqe97fqSE2HJYT3ruh3jHmiWP1N6OBPpQqRtvg1zvyCv2YJRfJLwQ+b1q8eZOrBbutYrrIPHiK+VstbEbgcF8Uh613D2sYxyAnDpCZTpXycCPFFKjwNA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CY1PR12MB9557.namprd12.prod.outlook.com (2603:10b6:930:fe::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.37; Mon, 2 Jun
 2025 08:44:50 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%7]) with mapi id 15.20.8722.031; Mon, 2 Jun 2025
 08:44:49 +0000
Message-ID: <fa655142-980c-457c-aa0c-93f3e04755fc@amd.com>
Date: Mon, 2 Jun 2025 10:44:43 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Fix potential dma_fence leak in
 amdgpu_ttm_clear_buffer
To: Li Ma <li.ma@amd.com>, amd-gfx@lists.freedesktop.org,
 Arunpravin.PaneerSelvam@amd.com
Cc: Alexander.Deucher@amd.com, Perry.Yuan@amd.com
References: <20250529130738.2352725-1-li.ma@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20250529130738.2352725-1-li.ma@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0148.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b8::13) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CY1PR12MB9557:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ee445f6-b077-4407-322a-08dda1b1bc26
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?b3pERGticnFlYlEyUGtUVzFaY3I1NUNXeG11YkZpQkdibEpKT1hnYitkcWdP?=
 =?utf-8?B?TDNETzZkeDNTWnVsM2JXSWJ5dVMzRWpxZ3lMMDR6Rys0M0xrdVdNUnNpdjBU?=
 =?utf-8?B?K1UvWWdQeCtJNmNkSzlyZEIvT0NuSWNHWVlBWmdxaHBGUlBsNXdQMUxFalNZ?=
 =?utf-8?B?S1ViQTNHY0Z3NTM3WDB1cGlMVUtiNDI1TGtFdDZEN3l3YVFMaUs4czZjYlhz?=
 =?utf-8?B?T0xCejJXVjk1K2s1SGlwaWd4TFRPMHYwMHRPaE9XbHJxak5qUFowejhDcVlu?=
 =?utf-8?B?TlJMK3pVaWFveEpIYXlkTUNXT2V2KzlHRVpsYzhSdkdjdGVScG5DSzhucXdl?=
 =?utf-8?B?Q3pULzdCRjltYjIwSXgwVTAxb2dNaHVPejY2NU1nMkgrZmFFenByQmJwTk5y?=
 =?utf-8?B?WFFiYUZoTEt5TVkyZEx6c2llUWZQQ1Y2S2k5dVlIL1hKQVpsbVowR2g4TnVq?=
 =?utf-8?B?QW8xU1BYQjhaTSs4Wk16RnAzaURmZjJvYWRMWHBNajh6dEhsMXl1cTFJUCtQ?=
 =?utf-8?B?RTk0cmpvdVlnNytZLytxK1A3QjBRVy9xV1k0Yy9scUlBdmZNSnRjTGdpWnZG?=
 =?utf-8?B?eXN4Mm1sWEtQbHo5Nk93RzhhcXFhQnNWeno1SUdMRitiUGdVOE1wbi91Q05F?=
 =?utf-8?B?YlJCQ1IzazZCMGNncktibUlvcGYzQndxNjUzQUxpaHV6ZVZpaFMvVm10c3Nl?=
 =?utf-8?B?Q0RiZC9icWpJK3pTdU1kSWRySVMrTUpFZkJ6QisveklMaE9tOTF1MGVBK2Vl?=
 =?utf-8?B?bjdxT2lJR3haVEhYYlBFQnhxZFQ0bVp1Z2ttRXhUN3VnRytScFcyTGdSSlFQ?=
 =?utf-8?B?aGpZY004NDNSM0E3eUlBbnlmRTZVQ0ZRVUk3ejVWY0hYajZjeVdHK041elQ2?=
 =?utf-8?B?MDNGVTBUMmk5a2NmMFJCSGJTV3E2NUZ2NWFUUXk3QWk1VTFCbnlrZXJBMDVN?=
 =?utf-8?B?U09oR0VDcjRoV1JkelVUOXFydjI5NmlGNmtLTTllWW9ndGRjSDN2a0RsQVJp?=
 =?utf-8?B?KzZ6c2RHRUZucHV4dXJEWHVQVzVXaW4rY2RWN1ZKS1ZSWUsrNjdQS210Rm45?=
 =?utf-8?B?OENweThJcnM5ZVdQd3ZlaXdwVVVYUDIwN3FKRVl2YXRaOHNSTngzY0Zxa1d1?=
 =?utf-8?B?K2NCLytkS2sxUFcwVUMwSTY1L3JMblpGR3VzU0laOC9JWFhUeVZ1L1RyZ2pR?=
 =?utf-8?B?T2NYL0R2SHlLZHdScWV3ZnF5Y0VjTXE4VkJuOWNyVWZZU3dESUpvcndNYnNP?=
 =?utf-8?B?cWo1VWduY0NxSzBuWEUzYkZSbTlpRE5kNzQ2R1RZOGpvOGhGaUJHMEgvTmFm?=
 =?utf-8?B?MTdXVmVRMkhTWUloOHR6MytVeHlDcjcydEtnYWErV2o4RzBHdFE5ajBkT0xu?=
 =?utf-8?B?UmlDTUNpWVRZODY5WUZ1N3RoVXI1Z2Jsc044NVVyZk9SMFlJdll6Wmx1ZTBP?=
 =?utf-8?B?NWk5VUlEMVcvNXVnRzBxZnBweDFRN1NqdTR0N2lXdWVWcDJJQi9YUlFpbWZG?=
 =?utf-8?B?Ylg3S0UzWGpIUEwwOXRzbEtDRlVDcmwvUmtCSjVaeDBIWnUvbEpHSVhLRVBx?=
 =?utf-8?B?YXEvVGYxWnc3NFo5enUwZ0Y4QnY4c3d6azYwT1FYNXoycTA2SGhROXZzSWgr?=
 =?utf-8?B?MDZoYTFHR29aVGNvRmMwNDNnNVg1WkZnRmdac1cwY05tZk1ZMkNkU1dJZG1L?=
 =?utf-8?B?TDVFekswTEZXMHNxRjFzdExKVjJBUzh6MWk4SzIyc005YlFIRFluV1JIMGZo?=
 =?utf-8?B?eGV4a1pWS1VhWXlucVc0T21NT2pob0VvOEs5RkJ3VGRJeFBpUElXWVlXbU9U?=
 =?utf-8?B?c2pFV2ZZclJ6L1d3K0h2emdVV2Jzbm1VWWRFcDdUZzdpRmNjbXhuN1lUNXZZ?=
 =?utf-8?B?OXRvRjlEM29wWk1DMkgxRm1BYWZZd0xqZ1pZRE9UVGlSMXc9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c3g0SHRwcEpqRGxER2duWmxLYkFqQm5yaVJmUkZBdVBZZWRhSEVpTnNjQTBE?=
 =?utf-8?B?L3lDSjlqbGpwdXdzU1M4VUZadk5PVHMwSmovR1pkWEZsQ1JmaWdqOENrYlRX?=
 =?utf-8?B?UWRVTS9jWHZ5TTA2aVRiNDU0RllnWHpkWmRZc2FONjBxaGtNQ2Qydmwvejdl?=
 =?utf-8?B?b0NySWpvL084b05DYWZIR0hGYTY3NEN4aVRNWFRrTlUxb2kyYy9wakxWK01E?=
 =?utf-8?B?UmVVU3kxVElvOUpaSzQ2dFdhdTRjdUw3cXBKUVpUZjhubjRPdXdjaE9Lc1JG?=
 =?utf-8?B?VFdDWUd4ZnM1K1hJU29HclJUT2wzWm9zQ25xc1lwczkyOWk1b0lsOFdjMVNL?=
 =?utf-8?B?K00rb1BDQUFDTlp5RE5EZFpBZk0vWkVzUTNtYUxwVk9nazZjZXpBTnI5Ylpt?=
 =?utf-8?B?TVUxY0p5dXg3V0hyWjFxQmltR01SK25aeGgrY25lMXZDcTduMm1RNHZMVWRi?=
 =?utf-8?B?THRPUER2L0JUbzY1eUdBY1o1akpLOGNqdExERk5Ndk9sVmlmM01wbTFhTVVr?=
 =?utf-8?B?SENGSnlvR3JCL0tWcUF4dktiQ01hN1NXN291NFZ1eThlZ3oweVFjZlBUaTlB?=
 =?utf-8?B?czF0VXlWNVQzMHNjUDBzOWJjZzNzUnpZamplV3IrNlF1czkzSVBhbUNkeEJ0?=
 =?utf-8?B?SXVENjdpZXBtaTM4QWxPR3dBSElRelh0Rk1HTkE1OFY5ZENjV2o1Uzh3RWsy?=
 =?utf-8?B?Rmo1M3NYMXQzTUZuc1lDa0lvKzR6MXJtb1FyMk5oN0tHMFN3aGNDUjg2SUll?=
 =?utf-8?B?dEdiQzBVQm5vUnhWNE92Skp4N2RvRmlqQTF6TS82T0ZpWU9qbC8yZ0NCaEsy?=
 =?utf-8?B?aWU0Q2tsT2FaN0F1Ry9kc3BBK0dSZzR3TU5ETzQ4V1BlUGwyaExWelA4ZXNq?=
 =?utf-8?B?ZXdaNTJJTTVXcUVaOW5FdWtSYW1KNzIva2FNbG5RYjRsV2lyZmR3OWVHTHBT?=
 =?utf-8?B?K2VDQnJ6WnZxOEkxRmg1d3M5NGZpZlRtT0VoZ2ZRT3pHejdjQnpZVjcrdDY0?=
 =?utf-8?B?UGFtSE4xS2ZqNk1JdnRnRUR4M1huLy9oUDIzQkk0c3JYbllncGl5MGJzTWtw?=
 =?utf-8?B?L2pjbndJVkdLL0p6Vm1MSXZjQnVHY3dvQko2MVFROXNjano1ZDlPSk5EVHNt?=
 =?utf-8?B?VjFibFdQYUxkbGZmQjMyeStuRnlYdlBFTm1WRUJhTGVTRWV6Q0FrWEE0TTRM?=
 =?utf-8?B?b0xVdGF4K0NDOTZDczZ6Umxxb0RqSm85cmVLcWxodnpvUnM1ZUtMc1dzR0JD?=
 =?utf-8?B?Y0N4TU81NGg4ZWZhemVJdVRTVVhocXVFa2U3UlBhR2hFcVdqOHlNNHU3elpj?=
 =?utf-8?B?OUdLMU9TcWtmL2pBTTQrVVpFOWh0d0lIS09sYUVEVktTMGhJalRRc0M5QU51?=
 =?utf-8?B?TEhNczJrT0UxbUh2TGxIanZ5bmpuakh0RDJ0Z2t3SndLLzNEVGxDdmlhU3pD?=
 =?utf-8?B?b1BpeUR0Y05wNDVTV01pSzA4YnRTdE93c0FJZmJVZ3VKazV0ZDZYUEdmRmFy?=
 =?utf-8?B?N3pRTjhNMm1Sa2haMThGRENic0RVOGJTd3h3WDc0M0xabFI2aXlTaGRlOTFm?=
 =?utf-8?B?Q29TZ1RKcnRpelB4dDRFSWllKzZ6cGxCOHhPQ0FzY3Q1N0xMZS9yb1RuWlRz?=
 =?utf-8?B?N21qYUQ4QlRkc1FQZGJIVWUvWW1rZ3dVTlFYaEoyODN3ZzRTM2VZSlNZeUUx?=
 =?utf-8?B?RE9JaUdGTXJyYnZxRUtic1pzK0d2ZWRzcytROEhNVklxdGhOTFFwUXRMcEpy?=
 =?utf-8?B?blJwQ2xYQ2hMNXB2S09VK08wNEdMaFRCcUhTVm1aV0tEdGpTREVpdDZoT0R4?=
 =?utf-8?B?MTZzOTV4K3RMNzliQWQzSm5nZ21Zc2o3anVabjNsSjdIcU1zcUlZMVc0YjZm?=
 =?utf-8?B?eVhFOTZXVnAzYVFUOUQxeVU5R0dFaWlZVU11VFl1SmEzWVhwc2xWUnYyZ2dQ?=
 =?utf-8?B?MjJwRC9Sa05XeFN1MnNVTi9qMFJScVhzb0g0L3Nabng3a2UvRi9pdFZ5czQr?=
 =?utf-8?B?c2ZKV2ZpL2hReENIaFBFMk1XczBuQWsrVk1xcVRycVM3N1dHWlBFdWR6UjJx?=
 =?utf-8?B?d1luNVY4anN3dmdJZzhpMEF2eTdQSUkrS1R4MHREckQ5RUNIMkVPZWJsUHlM?=
 =?utf-8?Q?y0On8i18j2DXTNVAO4+ACV3nV?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ee445f6-b077-4407-322a-08dda1b1bc26
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2025 08:44:49.6942 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BJBg1+8RtxJn3FL1WmUYxFWkw06JVELGRNe1t3PUSanDZHrK/THPe/vKsRMXhVvt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB9557
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

On 5/29/25 15:07, Li Ma wrote:
> The original code did not properly release the dma_fence `next` in case
> amdgpu_ttm_fill_mem failed during buffer clearing.

NAK, that is completely intentional.

We must return the fence even on a partial failed clear or otherwise the already submitted clears could work with freed up memory.

That's also why the *fence pointer is initialized with the stub fence before the loop.

Regards,
Christian.

> 
> Signed-off-by: Li Ma <li.ma@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> index 9c5df35f05b7..b7284f0a5ac0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> @@ -2296,6 +2296,7 @@ int amdgpu_ttm_clear_buffer(struct amdgpu_bo *bo,
>  	struct amdgpu_device *adev = amdgpu_ttm_adev(bo->tbo.bdev);
>  	struct amdgpu_ring *ring = adev->mman.buffer_funcs_ring;
>  	struct amdgpu_res_cursor cursor;
> +	struct dma_fence *next = NULL;
>  	u64 addr;
>  	int r = 0;
>  
> @@ -2311,7 +2312,6 @@ int amdgpu_ttm_clear_buffer(struct amdgpu_bo *bo,
>  
>  	mutex_lock(&adev->mman.gtt_window_lock);
>  	while (cursor.remaining) {
> -		struct dma_fence *next = NULL;
>  		u64 size;
>  
>  		if (amdgpu_res_cleared(&cursor)) {
> @@ -2334,10 +2334,13 @@ int amdgpu_ttm_clear_buffer(struct amdgpu_bo *bo,
>  
>  		dma_fence_put(*fence);
>  		*fence = next;
> +		next = NULL;
>  
>  		amdgpu_res_next(&cursor, size);
>  	}
>  err:
> +	if (next)
> +		dma_fence_put(next);
>  	mutex_unlock(&adev->mman.gtt_window_lock);
>  
>  	return r;

