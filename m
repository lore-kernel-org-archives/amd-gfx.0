Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 586CCC28B2F
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Mar 2025 04:19:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0438E10E2BE;
	Fri, 14 Mar 2025 04:19:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="YpG8oSAH";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2057.outbound.protection.outlook.com [40.107.243.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D11A010E2BE
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Mar 2025 04:18:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uWMUchoOpu0P8vDhyVW1mIZe4WZhcgizSD0kU/m6l0kPTnoIcJlA3Ql2VF0m9doY4z3/++R8NAkczapKty3fvgLltnNL6pc5FfEvD8PWpkYhZ3iM4tBQd0oeaqHPaSGrupYkvoKPkDxKjY6b7//D4ksSIrlet3xhLMRs5zDRrzz76fbMDFMSmEC6zm+zsdmnZQMWwUu8TT06gGRPRm/ryQ3i/OIzq4J1oHLIRsfCQnUmrHmLsasADLoHrdJq2AnS0gKIpt4K4UKzq0P5mmRSkKdVQ9UBizUPfZB3EiqS1Q2OQVJFuVkuoY8cLTzpH7aH8qEqBl5Ciqvck6luWvinLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mIjwyhHLZGYTyGldwbufGMrVbykxMF80KE3/+hqDmOQ=;
 b=JRMMYxeDz/QN1X+sA8+H7xrmxqeCnYa1svX4R+W/BBa6ia0pSpSVPBwMljNz+k9lSyGtxpyyUd/U+BL6j/F2bsho8lh55sOW2eQhKRbEujDbuVcZlxuaxT87KAVrHStMOA2ftqybjODvxIMDq3MmmlhhnTLODY1ge3EddIJlMvM+1xmoCAc0bzbBqeuQK4qCayRRs24p35Ujcq92GXNf/zEC4Cag2wW6OEYgcG9C/sP35ofLz7ttSHbQJw7TQEcUe7btdUm6ocaQ8be9n/HT6BRKW7vrEWG09FiDH2i83emDplC0XrVnzYCYgVI7bAVWl3j80v1jrvOROXplm0EIPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mIjwyhHLZGYTyGldwbufGMrVbykxMF80KE3/+hqDmOQ=;
 b=YpG8oSAHGSXSEnRAKcK7DjG/nYy7XopYWB8NZ/B7TdX0KQBedCnjq5gxH8KfJ5WimgpNkY3fEgq9Ruwhrv1vfBBBvq/2manvu7F+BvUYqDeXnlllBgmx951cKrdG4zo68G6+reRyMz0pFF3bLBzN2TVRaUGC2gns0zAzMEDEqVE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA0PR12MB8208.namprd12.prod.outlook.com (2603:10b6:208:409::17)
 by PH7PR12MB7330.namprd12.prod.outlook.com (2603:10b6:510:20d::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.28; Fri, 14 Mar
 2025 04:18:55 +0000
Received: from IA0PR12MB8208.namprd12.prod.outlook.com
 ([fe80::14af:1677:d840:8d2]) by IA0PR12MB8208.namprd12.prod.outlook.com
 ([fe80::14af:1677:d840:8d2%5]) with mapi id 15.20.8511.026; Fri, 14 Mar 2025
 04:18:55 +0000
Message-ID: <009ef264-b48b-46fa-89c2-3c74f76de720@amd.com>
Date: Fri, 14 Mar 2025 09:48:48 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/8] drm/amdgpu: rework how the cleaner shader is emitted
 v3
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 amd-gfx@lists.freedesktop.org
References: <20250218161401.2155-1-christian.koenig@amd.com>
 <20250218161401.2155-5-christian.koenig@amd.com>
Content-Language: en-US
From: SRINIVASAN SHANMUGAM <srinivasan.shanmugam@amd.com>
In-Reply-To: <20250218161401.2155-5-christian.koenig@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR04CA0168.apcprd04.prod.outlook.com (2603:1096:4::30)
 To IA0PR12MB8208.namprd12.prod.outlook.com (2603:10b6:208:409::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR12MB8208:EE_|PH7PR12MB7330:EE_
X-MS-Office365-Filtering-Correlation-Id: b424758d-eca2-4e3d-885e-08dd62af5568
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Y3o5akFFcFZ3VWJyQlVTaUUrU2Z5QTM1aTNIRlZ2NzdFQkowNzBPdFRENW54?=
 =?utf-8?B?a1RxMFd4SkNTUFBNcE1RcmtDTHpXbWlTWFpiQWhaNEd3R1p0U1ByakFnbXhE?=
 =?utf-8?B?QVZ4MlRsUnprSml4a2QyaVpZRCttcnRkVlFaT0habWZlSW81U0hDODV3SUdQ?=
 =?utf-8?B?YldKblJtR2RxU3k1UGE4VEFNODdiUXNLTUlQL2pHd3psQ3RYbjNmWEQzYU1u?=
 =?utf-8?B?aFUrNHhFZms4OEM1bUJNQ3FwZm9QWGxTZlp0amJ2eW1hV056djhBWjV5ZkEx?=
 =?utf-8?B?VjgzY284b1Y1dEtUYlZMUFpNcWFGVzhrSWxmT0hMVTg2dTU5SnBIa0Fpc2VN?=
 =?utf-8?B?RzZNQW5md1lOY2dDOGNiVWZDeTlmMkNHSU9IMG5pYWFoMEljRDhiTGk4UEdy?=
 =?utf-8?B?UjdEL0syM2hsbkZIY05RMWFYUmpLckcveFpuR2RaK0xQc0MyREU0RTBWOWlh?=
 =?utf-8?B?dDZaT00vaE5xVEJHeTFldHQwR1BrY2xqaE0vc2Q2Ty9Mb1hQUm1zQ1BBTlhW?=
 =?utf-8?B?bHluWENlZStnL3g1SEdpOHFHM1VuY3Nka2JjMlZ0dTRGMjdlQjhVYmRkNmNU?=
 =?utf-8?B?UmpQMWNNUmQ0bC85bkM0UlQ0MENubDJqenF5SkhpalgyWk16S0dhZUdQemRs?=
 =?utf-8?B?c1Fic0UyV240RlBRQ0Z6eFFWK1k0MnpHOWsxZW40c3RGQ09zMEs3OUtCQS8x?=
 =?utf-8?B?QWp1K3ZQdFI0MVhQS3lwdnBscis4ZFdUMUpyVngxRStWcHNKallZK1FiUCtH?=
 =?utf-8?B?QjZQbHJIUGh2U2lkOS9EZnFuQXF2eGtCNVorRFNLZmM2bWJDalBEa1orYUhM?=
 =?utf-8?B?K1puVW9oMytPckVKbmJ1VDRsVUYyV2x5cmwyeWZ3UWdQM1N5RTBOVk94VXdU?=
 =?utf-8?B?M2VRMmYrTkhnZEI5eVhraXVlTUg4TDhQNGVuekRBNmlqNUpvNmkveW9sUGpE?=
 =?utf-8?B?YmEreDJGTXBrSFFJWG5pWmlKV1g5RnZrQk9HWXlyd0JYZlpwNWQwWko4Tmw0?=
 =?utf-8?B?eURzWVUwbEwzQ2NxSUFXbitOKy8rT0JaSEllVGRzSHcvMkVSTGFiT2ZiTjB4?=
 =?utf-8?B?Mnp6dmZtcFkrV1dMY3EzazFNNDNXZU1McjVxQVY0ZVY0TWJYM1ZvTmhaQmQr?=
 =?utf-8?B?QllBVEQ5TTRVZFh6bHAyaGxHeE8zTkhjNE9SWEFPSWNMWnhrVzJrSDg1eVNR?=
 =?utf-8?B?aEcyNW4vNXBUVWZVMjVBakZsRmtSNHRwbktIOWpNdUMzZjVpNVUvdllrZnBJ?=
 =?utf-8?B?WEZkdWRUOEJscHpEdHgxUWtqd25TalhkdStKVXFQNWIrZ2NPY0llcmRPV0pF?=
 =?utf-8?B?N2dyNXRjRnBEdTNFZk84ell4cGJKaGQxcjNNOW1TVDFvY1phT2E2RTUrMzVx?=
 =?utf-8?B?SzBxWTZUVysyOEUxQ1ZyR29RU0FtUjJJMkRNRmpIV2VFYnZRZ0x4b2dGcFI4?=
 =?utf-8?B?bmx3UEVkK2dnSTV5cFZVYXVMZG1MN3pmQURlK3NsZXB6WHlhdytVZGNoYmhu?=
 =?utf-8?B?c3dncWZtZ0pyalU1aDhra2paWVRxRlBvNVIxMVZUU1RJeGhVQzlhdnh5TVox?=
 =?utf-8?B?SjZBWEhBRmNzWXhINXFrUGRRUmNWSDc3bS9jTWsxSzBOUmNZM3NuTUZFUDl1?=
 =?utf-8?B?QWc0QUN4UzZocWpGRFlMeWRSNmVPYzNCdjFBekVYcXdIT2NUOWVRd0xLZjVp?=
 =?utf-8?B?ZjhCMjlONzd2bnRqMjd2aHZjb1NFRVZZS3JueVVBSDV1c2FVaEFBYjJOeGY4?=
 =?utf-8?B?VnN0ZmVGTFF1WUZYbXJuQkN3ZVNDRlE2djNpUCtLMWN6czF1cVJ6MHJjdXcz?=
 =?utf-8?B?UE9PZ2kxWFRiR0V5NVZmY2UwVUJCN2FyUUNQRnRFblNUZEhORXdGbnR2NGtR?=
 =?utf-8?Q?Np28EvBrPMn2C?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR12MB8208.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eEZFYVQ4aVFyc0FpSjRzVVlJSUtPWnE5andEYjNYVHc3ZEZjUHJlNFI1ZGww?=
 =?utf-8?B?Tk1xbGFENHBwZnRLNGg2MjVBRklrNXRUa0hGRklTbU5oMUVzb1hQa1czVTEr?=
 =?utf-8?B?bklra21wVXUzcDQ4b20rbXRJODIzWURRTUpReWtMWmVnU2ZneWxUVGlQejFl?=
 =?utf-8?B?NENXbDRRa3d6VnhtSGxacXh3RlZGcGg2QWVqeVI3dTdKKzYzeDk0UCtmUnV2?=
 =?utf-8?B?SHhrQXNIc2dnUUxld2JLcVNLOVFWRXg1KytMYTh1Y0pFU3JORVJ6NFBxN2xC?=
 =?utf-8?B?OGNvbGFPTWJFME9JTzYzcVV6MDhtY1BhNEJoc0o3V01SYjZVdGFINzc1QnRZ?=
 =?utf-8?B?VFFWYldqVVJlYVUvKzBPRlJqbWZsbEtGSFdoZjY0Q21XdHUzNTZvMDJhaDF1?=
 =?utf-8?B?TzMra1kvZ1ZQRGNPVkg1NlFWMlhHS29TOEk3Rndtc1lKUkJoaEI0Qy9yb0lO?=
 =?utf-8?B?ak1zeW0wdXl0cS9vYjhRSWRiNEZmVWh6OEJCdkEvUGZxUEY3ekVscysrTHR5?=
 =?utf-8?B?Mkt3WG5KdDFjT0ZoNUV5OGJJWjhBbXNkZ1VqR3FDeHk1RjlOQ2FPcWZrSG1r?=
 =?utf-8?B?SENiaEJ5eWp3bkYwVEZmREpaSkdwQWFjR2xPT3Q1Q0FlSWtDMVVwMCtmelFQ?=
 =?utf-8?B?NmFwbnBVbFZaZ1dTdTRib3VNc2NjRkw2NDdzSlVZQThJS0hmcUo0QmR6NVNF?=
 =?utf-8?B?ajQrY2l5QVRZbStZUW1FcUR4Q1Z1SmpBRHdFQXJJYm1HVDFhS0YyZzF5UE1E?=
 =?utf-8?B?OXp4VmN0UGJSeklTRXUwZ0g5eEtPUHFtaWdLK2J2anFWUmhSbTNiWU9UQUti?=
 =?utf-8?B?SGJUY3FIektzYStuL1lLYm5wcWszK09lYXRwbXhFMVBER3p0dkNjYytrNXFX?=
 =?utf-8?B?MDFza3Qxek90MitmWnVjbElHbnl3cEtOdEF6Qko0dWZkNWh6dzFlaUlhZkZN?=
 =?utf-8?B?MHZTS3VZMFBYdC91MVpvRk5oekFyR1BzV0w2blRrSWtQYlM3dk5NVGRvckdt?=
 =?utf-8?B?ZngraVFTN3lJQlpZT0wvcXQweHIwM3BEeVZFTmtXRDRiNDVrckJHWG9jTmhp?=
 =?utf-8?B?TmFleEtzUE9jQ3l3T3NZUjg5a0lrK3huTlVXc09xUHp5Wk01VFVyeW83Z0Fw?=
 =?utf-8?B?M0w5aElDSFk1bUQya2Q2SDRvRVZQV3ExZkowcjNZVExNdUdvenVqdFJoNktB?=
 =?utf-8?B?dVIrSVJHVVlBZVZQVS85aXRkUkFPdFc1RlF4SHdFRm1YUm9ST3ltdGF5NWRR?=
 =?utf-8?B?c3lLbmVlbzlVZU9aWWl3Z3JqV25UOGR0NFFkSmlTdjA3RkhWczJXQXpiakc1?=
 =?utf-8?B?NS9pL0tKMUlrTlJLdTUvQ3FUUnEweGdIcmgwclV3TWFsNVBISkM2ZHV1SDlz?=
 =?utf-8?B?VFRtUTdUb3VjWlNaZDBOckE5RDdnMS9URno2L2ZWbUZ1Q1BuZUo0K0drL1FN?=
 =?utf-8?B?ZWVkbDVITWZJT3NXd3lOMDQ1ajgwdmREL1c3RklaemQ4Ri84M08vUXZhcSs3?=
 =?utf-8?B?WDJHOWYxdWE2d2RRakFpVHFHd2gwY2hPSTJSaENTOXdLazYzM0VuQXBDak1v?=
 =?utf-8?B?OU5BRU1rY2dzb0FLczZVWDlHUU9iQ2x1WHN4eHdHM3plR1hUNGFQeFlTT0Y0?=
 =?utf-8?B?enl5RlcwNERmcTIxT0J0Ykx2V0hOaysrVk16Tm9MT1lrMVZTYjBkYlM2Mnc4?=
 =?utf-8?B?aDBHVXJPRVlBV2NjNTc1Vmt2TW95a0dJZVdoMGdMZXdGMFVvMEpmZHE5ZTBB?=
 =?utf-8?B?Wnk4M0E3b1FEZ24vWk9IZUZ3Q3djWWoyRkhoanZXeXk5dVFtamNtTDBxbjNH?=
 =?utf-8?B?d1NHVWs4MjlpYTJIVTduRktsSjlod3B5b1pvcDN1TFI5ay9vNkN6VStoelA3?=
 =?utf-8?B?UjZDZGd0T3RiaGwvcGJ2SjVUaUJISVhNZ1VoUVhzaU9JSndDcjY3bm8yZXVC?=
 =?utf-8?B?T2dmZ3VIeFNRVEFFR2xPVmkwaFBRelpSL2QySmxJR1pSR3Y4NURvUU1aS3dC?=
 =?utf-8?B?QmwzRmRLZVdodldyK0V1WXFJZ2JiSURyVWpieCtvVWxISGxXdXZlRVBsZTBu?=
 =?utf-8?B?bk5ydXkrWHlkb3pYT0tNTWxjamRCYk5tR3dOMkI1dHBzNUxLamZxazNkdHpu?=
 =?utf-8?Q?WiDjeGucjAgGMUA3Q/GFsLAPy?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b424758d-eca2-4e3d-885e-08dd62af5568
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8208.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2025 04:18:55.2315 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lHPCBlD0quzNy8BGGdFcXRiPOh0H5G7T98O2PcSIuKXZWCmlo6gRJEHM4DzNLlWd/dqSbyUFn+mTUgm8jK8gWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7330
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


On 2/18/2025 9:43 PM, Christian König wrote:
> Instead of emitting the cleaner shader for every job which has the
> enforce_isolation flag set only emit it for the first submission from
> every client.
>
> v2: add missing NULL check
> v3: fix another NULL pointer deref
>
> Signed-off-by: Christian König <christian.koenig@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 27 ++++++++++++++++++++------
>   1 file changed, 21 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index c9c48b782ec1..5323dba2d688 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -643,6 +643,7 @@ int amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job,
>   		    bool need_pipe_sync)
>   {
>   	struct amdgpu_device *adev = ring->adev;
> +	struct amdgpu_isolation *isolation = &adev->isolation[ring->xcp_id];
>   	unsigned vmhub = ring->vm_hub;
>   	struct amdgpu_vmid_mgr *id_mgr = &adev->vm_manager.id_mgr[vmhub];
>   	struct amdgpu_vmid *id = &id_mgr->ids[job->vmid];
> @@ -650,8 +651,9 @@ int amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job,
>   	bool gds_switch_needed = ring->funcs->emit_gds_switch &&
>   		job->gds_switch_needed;
>   	bool vm_flush_needed = job->vm_needs_flush;
> -	struct dma_fence *fence = NULL;
> +	bool cleaner_shader_needed = false;
>   	bool pasid_mapping_needed = false;
> +	struct dma_fence *fence = NULL;
>   	unsigned int patch;
>   	int r;
>   
> @@ -674,8 +676,12 @@ int amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job,
>   	pasid_mapping_needed &= adev->gmc.gmc_funcs->emit_pasid_mapping &&
>   		ring->funcs->emit_wreg;
>   
> +	cleaner_shader_needed = adev->gfx.enable_cleaner_shader &&
> +		ring->funcs->emit_cleaner_shader && job->base.s_fence &&
> +		&job->base.s_fence->scheduled == isolation->spearhead;
> +
>   	if (!vm_flush_needed && !gds_switch_needed && !need_pipe_sync &&
> -	    !(job->enforce_isolation && !job->vmid))
> +	    !cleaner_shader_needed)
>   		return 0;
>   
>   	amdgpu_ring_ib_begin(ring);
> @@ -686,9 +692,7 @@ int amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job,
>   	if (need_pipe_sync)
>   		amdgpu_ring_emit_pipeline_sync(ring);
>   
> -	if (adev->gfx.enable_cleaner_shader &&
> -	    ring->funcs->emit_cleaner_shader &&
> -	    job->enforce_isolation)
> +	if (cleaner_shader_needed)
>   		ring->funcs->emit_cleaner_shader(ring);
>   
>   	if (vm_flush_needed) {
> @@ -710,7 +714,7 @@ int amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job,
>   					    job->oa_size);
>   	}
>   
> -	if (vm_flush_needed || pasid_mapping_needed) {
> +	if (vm_flush_needed || pasid_mapping_needed || cleaner_shader_needed) {
>   		r = amdgpu_fence_emit(ring, &fence, NULL, 0);
>   		if (r)
>   			return r;
> @@ -732,6 +736,17 @@ int amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job,
>   		id->pasid_mapping = dma_fence_get(fence);
>   		mutex_unlock(&id_mgr->lock);
>   	}
> +
> +	/*
> +	 * Make sure that all other submissions wait for the cleaner shader to
> +	 * finish before we push them to the HW.
> +	 */
> +	if (cleaner_shader_needed) {
> +		mutex_lock(&adev->enforce_isolation_mutex);
Should we need to ensure spearhead is valid before putting?
if (isolation->spearhead)
         dma_fence_put(isolation->spearhead);
> +		dma_fence_put(isolation->spearhead);
> +		isolation->spearhead = dma_fence_get(fence);
> +		mutex_unlock(&adev->enforce_isolation_mutex);
> +	}
>   	dma_fence_put(fence);
>   
>   	amdgpu_ring_patch_cond_exec(ring, patch);
