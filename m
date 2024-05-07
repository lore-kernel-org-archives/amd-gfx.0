Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 126C9C25B5C
	for <amd-gfx@archiver.kernel.org>; Tue,  7 May 2024 05:52:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4474410E2BB;
	Tue,  7 May 2024 05:52:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Tx/Kzyar";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2040.outbound.protection.outlook.com [40.107.220.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B9FF710E7D9
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 May 2024 05:52:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iEjEUix9HoU2juBlZspNjmzhafKdXOJVxJK3EVi4kbPEbSf1McDWi7HfRFCgO+SRCINVPMwOEg/hgR6qmG1OQAXSi1q01XetsEckc4p7wsSxjT8Axkj0MUBviygBR8tm0UWqGtfkEJKtFFOWQax3+yNcjY6OfFiZP4i7Y17C7GYQgEJwL4fW57PplXFRCGuzI6zjZV0Ddbz/khPlp216jIC8p29XdvMpSM2C4MIkUTG8yXJmS11mg/wpi+b9rrTuB8IE/0E4rasZl7eHupUWebaU8ELO3bLxSzPb2+UYbeFPwCEtOvrDyYehwnCGh6lDmH33WIPvOoxBkKgJFct+sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6+pe4k/Q5v1ZuKOjWHFe9/NeKwI20Fpo/PVT4T8kOVg=;
 b=oOwfygDagTSmpPgC6cixX8d1dDa1/lCXAkOroq7w2Ml/QjWQmin2qKIdnqY2EKHVspSDQm7rKkLJlH/wj7PDQWayM71LsNKmXjs4mi5gqX1Sou/jCb2WYPwhjM0vX0F5DauzcZtG5BxSAjkHjTbjLBGxRQzdlvPr6X/i1GKJN0ICdg29NQloEBqLjlKKZ24xGzXUa3/DcGbfnbpBFQJu0wiVQkDmgHBEkPeAI0/qsW2XduTMGsf2RG8M1qDbDaxXZZaRs7fTnrgC8rfGBzHE396ETgJULs/exK0GS1MLuxXuLr8n/r5AGMl3lTaa6YwZS1TBrO5/t9opxZinrn1T9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6+pe4k/Q5v1ZuKOjWHFe9/NeKwI20Fpo/PVT4T8kOVg=;
 b=Tx/KzyarpxbRdxlbwdNdVatTiGpmZGe/THJyjUNmul14PduucXA11cw3KfVdKZ9Oylv9+8OwpQUA/g5aS5nmAxznU9MEK17m5CwB98ggE5rXNeD1d0DrUWHYZoFlaAB+Y42xPGClHVh5bRGvljFWfoNKoThfuBb6ANR6sNSGdwI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 PH7PR12MB5655.namprd12.prod.outlook.com (2603:10b6:510:138::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.42; Tue, 7 May
 2024 05:52:28 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%5]) with mapi id 15.20.7544.041; Tue, 7 May 2024
 05:52:28 +0000
Message-ID: <a50ee9ef-1a2a-4723-a638-936ac4e92653@amd.com>
Date: Tue, 7 May 2024 11:22:20 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdkfd: Ensure gpu_id is unique
To: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20240503220639.335198-1-Harish.Kasiviswanathan@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20240503220639.335198-1-Harish.Kasiviswanathan@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0203.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:e9::15) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|PH7PR12MB5655:EE_
X-MS-Office365-Filtering-Correlation-Id: 2111165c-60a8-4d8a-796a-08dc6e59e05d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|366007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bnhZYzcrTTgvcGYrTzRVcDlaa0JPTzFKYitoZDhLalRYTmNFemU0UDBrZmFv?=
 =?utf-8?B?L2YvQTFSV2VSQzB3eUhFZTE1VHVlNW1vNlRrWTc5SFZEemh6SUNtbmQrcEhi?=
 =?utf-8?B?QkwzdXZBYytUSHZaVmJxM1pEb2lLTWNzeHcrU0lsZnRaUTU0N0VnSVBiemdL?=
 =?utf-8?B?MVpRZHlxelpuVUx4c1VqTmRQSVdEMDlxMGduT1FLWG9wVXY1SUczT3gzVkFj?=
 =?utf-8?B?RHF0R0ZHUFJrNndKRWNKUGJyWklHWENEWWJNaWxzRUt1Z1doNklvbmFsOEJi?=
 =?utf-8?B?TEs4RlpwNkQrZTZEUXllTnF2aGk2K0ZobU1Sc1JNdHB4UVNYcS9HSitHZmZp?=
 =?utf-8?B?WE9BRlFveTNMVWxmQmhiUWdRVmozU0c2b2lUaytCb3p3dzVsK0JYc0JzRU93?=
 =?utf-8?B?a09TNmVEcStKUVFMcjRjRkJOSzlrT1RtRm9UWUdnazY1a01LU2NhN1lxSWcz?=
 =?utf-8?B?a244SzVHakJCeTBYY3ZYV2hLbFFneUl4K0hsd3RxRVdRVVVnY2E1bE1MMDkr?=
 =?utf-8?B?Z3JKQ3RBOWM5cWVGTEQ1bXVsWVF3aGpJZEQ5T3lOQWR3TG5qeXZTSnJjSEcw?=
 =?utf-8?B?V3pzeHBWNXBCVXJuQ0FkUVU0TkZaRjVuOC84REtleDVpVDlycnMzbDZRQ0ln?=
 =?utf-8?B?V0VOY1BwdXNDaDh1bWF0dTR2blV3Z2VpTTluQVZJTXRhQmJGdlF3bStZdGo2?=
 =?utf-8?B?cE1SclAxdnpnYWRZWHdRSHREVWkrTisyWms5VGEvTHpJSVllM2VBSm9SZzNJ?=
 =?utf-8?B?S2h1VG5TZUQ2RENHejBiUllET1NGTEJGa3lUSlJaQjNnR1JqSndqVGZWSDNq?=
 =?utf-8?B?VDlLaFNWMHVYSy85WHlVU2M0QitkOUtuUUM5VGJZbGIrbjdZbWsvWSt0N2JR?=
 =?utf-8?B?VURLR3BBOE9mSkJCR2hzQVVNRnR3d2tRSmRJM3ZrWmc2and4K1dJNjBqTFRU?=
 =?utf-8?B?YlV2Zjk4SE83cUJWMlZGRTE1elBUVTQ1N1dhWWZVYUNoUVk3S2VhOG5TcVZq?=
 =?utf-8?B?Z3ZXSzlMaDQ4RGFtMUlxTERFNFFiYjFGWm1CUXkwaU1kbTdWZEllclg1VUc2?=
 =?utf-8?B?LzVRbVQ3cHAyWUFXeEd2cjRCODl2RDhwQzdSWGFCeG5vaGM5WS9SSTBGNjZ3?=
 =?utf-8?B?Tk55dlpWUllWbUtqMVdPUmxjMStQMk9MeWVjcElCWW5yTURqSUJ6ZTdXbU5C?=
 =?utf-8?B?NU8rcGFqWStYR0pYeTg1RnZyb1RTWFQ3ZW5tNWkyZVZPeTY1Uk1yVUh1enNr?=
 =?utf-8?B?djBxZzNsTUpHWGtqU2Y0b1lvTDhCNksvVm1MQXh2cjc4V1I4SzNRRmdHNUhv?=
 =?utf-8?B?Mlo4SjRmbWh3eUVBZEFvelJrd1R4V01aNnFZdkxPMzNEZzY4amh1NU5uT3hO?=
 =?utf-8?B?V3pabXMxcmRMcW1lbDRoc3E5RGhrRmh4LzRzVW1LbVZEMmM2SG1VRzhHSFVH?=
 =?utf-8?B?eC8zZk5OVEVyaS9SSEV2TGNxY09kTTB5Z0phTW5tS3oyUXhkcGZQbnJPaFk3?=
 =?utf-8?B?NWxNaUJUOXRPbFJXbXZRVVdFSS91aEJJblBHeDVCc3RIYklXYWlFNWs2THVi?=
 =?utf-8?B?SmlhWGpvaUo5UnZQeC9VZ0NCbGVXYWFzNGE4RnZzOXZsSFFVaU5qWG9jRkRY?=
 =?utf-8?B?SkZXRUN6dllmM3hXNUJiUXBJcFB3RENiTUVYcjVBL25XVG5LYWJFMURla1hL?=
 =?utf-8?B?SytBa2xvNEc4UTUzY0FGNTVYTUtOSGdGYm9CZElSRWVieklGYjRHMlh3PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(366007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NnZCQjc3RDYybGJGRzExaStYWHNBdVIwQ28wMkp1Tjh3Vk1KZDNNaTdKM1lT?=
 =?utf-8?B?UFE1Z3pjdW5kREtDcm5pQ1VKVlBpOXVDd251MEJxU1lGdDNJQ1hZOTNRbzBO?=
 =?utf-8?B?OW1ZdUdhakE2Mi9waVpqM204eHVjSUNjSjZXYWErbC90QUtsdnpBenZrL2oz?=
 =?utf-8?B?NU40SkkyclIxbWpMUHhoK1hFeXBaRUx3Z2R0M1Y1aXk1L1pnK3lFUlpjZ2ZT?=
 =?utf-8?B?Tk1FdmgxWU5yMmNRdkdXVnp5elJKRU1sUWVpQ3lzb1RJby9TQVdudHdrazhx?=
 =?utf-8?B?UDNESXhCT3NldDV1RCtGTHVTeS9hTVF6aTMyK1ZaVlpkb2tsdEFIeTdkNmJU?=
 =?utf-8?B?VzFYYVE4MFErTi9zYTJoTVdDZ3BoWnhWbjFERVNQUE5JRFJWRkhYT0JpQVRP?=
 =?utf-8?B?ekU4UzhmSEdpZXFxZWcxYjJVYUFOS3VvWGZzSllTd0hoVVdqUlZxd0Q4ZmZt?=
 =?utf-8?B?dDRnaFc1UW95dXNHem5Bc3JURUdrU3lQaXdXZFd4U3h6Nm1Id3U1ckloM0JU?=
 =?utf-8?B?NDAxNndSS1MxZGI5V2lkd3I3a2RBZFp6OFI3L05sYVVrZ1Nyd1pDWi9YSk9J?=
 =?utf-8?B?RkxqZGl3Skxtc2RhZGRNSlJncG1Lb1hxY1lIaTZNdS9nU09ubVNpcFpGeDA0?=
 =?utf-8?B?S2ZXN0ZmRjBYVTdZUlBmckFueUREK1dnKzlrQjJCRGVBUXpQVkV4YkU0dU13?=
 =?utf-8?B?WlBaNVhuVkIxTTFUMVZhalVBNWZEcy83NkJBVkw5QjgzSnk5M1IyelZ2d0J6?=
 =?utf-8?B?RE9pRElEM0p0amZPRjZRU2RmOTVnV1R1Z3ZLZmtESG9uU29YOWltQWhObWRz?=
 =?utf-8?B?eEJGdyt4Q0srRjgrMDd3Q0RIQXlRYU1MdGgwYS8rRWFhUjhTSm5FNE8wL0tn?=
 =?utf-8?B?TDIvVElZRTlSdytjVmxJSXRaQXJXRGRzb2hER25FZDdXb1RoQVVvaXhqWkc2?=
 =?utf-8?B?SitPZWlNNythVHc5V2FLdTVZYVV6TVZJUVY5bWp3Q1dOd1ZzNnVWQmZHZjlK?=
 =?utf-8?B?c0JmdHJxZlNMb2E3MlZGaWtVb3NmOHYrMmFLSWM2OEFEY3VxTW9tY05TeGpB?=
 =?utf-8?B?VUFVc2xpSE1UejB4S0k2WmEvQTRBWExjYXZjYlRsdWtYK2MzOUlZaExxTnRT?=
 =?utf-8?B?djErRUN6eldRMFk4MHhMVXVtdlc2bHBsTG5FKzhHN2x0SmxrdVpqd3pJTm9k?=
 =?utf-8?B?OHZDcVlQdERmeUpINWhyM2M2Zy9BVzlqVTVtUWpoemVhZzc0ajBQcXQ5aXRF?=
 =?utf-8?B?OW1NZnRBQmlTTUJGTVIwUHYzdW1kcDVuMjZnZnBUenZFSStJNXY1TUVaQkY1?=
 =?utf-8?B?Y3BVV1I1aUNTTDkvZjdxMzFnU3Z6QVVwdXlZUVhucE9uaXAxZHJ6MTlHeG1B?=
 =?utf-8?B?Mk5CcGdpSXJYUVdBYVNRNDJRcVp4dVA5K1N1TDdYNmd3bTQrM3EwODVRemNP?=
 =?utf-8?B?eVlmS2VITTdGY0ErNUNwNUE0dzBmS0FRamRXbnJscDVTVzBPZnpyLzNpd3Vz?=
 =?utf-8?B?M1daWGxrVmZUd3k3cjlRcDhhQlhHS1JFcHFDeitpN1NNWUtWTDRRK1VURUYv?=
 =?utf-8?B?aWl4L0FRWGJET1dNRVlLYlJLaEZvMW9JRTB0L2ZrblQ3SVZFRWNGV1d1cWlM?=
 =?utf-8?B?OUNrOVQ4TDZjMzhXbytRWDNZVHNpcEFCRmh1UVduL1JtMW03YlRVdk5UbDJ1?=
 =?utf-8?B?QWJjdnNDVm5NaUN2MHgrMHdlQlljMWZEa3Bsd1p1b09MTWtNU3RRQlU1ejRr?=
 =?utf-8?B?MFUxdCtPTWhJOWQ1TWFWcXVLZ3puTnNQSDlxenc0WU5JVEhzcUNlL3A1U0pU?=
 =?utf-8?B?OGFoZzBmeG5CTHdyMFdlUFk2QUlTWjRUUHljNTFvSmI0WTRwVHJMWHhVZ01i?=
 =?utf-8?B?SHNnUi9UK05XSEs1ck1ZQlgrVFNmOHZDSzNsL0VHLzBBNS8xNHphSU1vQWdn?=
 =?utf-8?B?WDk1R0JGOUdpY1F4bk5kL0tNbEUzSTRYbHlDMWpDb2NqWFE5RXRjb0ZlQTdH?=
 =?utf-8?B?SEJxeWFSLy9WcWFPcnpjUnVNcmwreDVpd1lWOWt3N2sxS2I0NytQclpvZUlF?=
 =?utf-8?B?TmNZa3VvcVk3WDBaL2FuOHM1enBJdVlJS0RTbEZFUWRJMXNrSjNMMnRxS3NX?=
 =?utf-8?Q?n+88ekunFWUeGGULfe92sZjqV?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2111165c-60a8-4d8a-796a-08dc6e59e05d
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2024 05:52:28.0458 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BLc3wsa4/5cPVHx55hBSrvvp7Bj/stpg/LaY/P/rQ4nsuA8x09d6qtgOJmgJba54
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5655
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



On 5/4/2024 3:36 AM, Harish Kasiviswanathan wrote:
> gpu_id needs to be unique for user space to identify GPUs via KFD
> interface. In the current implementation there is a very small
> probability of having non unique gpu_ids.
> 
> v2: Add check to confirm if gpu_id is unique. If not unique, find one
>     Changed commit header to reflect the above
> 
> Signed-off-by: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_topology.c | 26 ++++++++++++++++++++++-
>  1 file changed, 25 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> index b93913934b03..01d4c2e10c6d 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> @@ -1095,6 +1095,8 @@ static uint32_t kfd_generate_gpu_id(struct kfd_node *gpu)
>  	uint32_t hashout;
>  	uint32_t buf[8];
>  	uint64_t local_mem_size;
> +	struct kfd_topology_device *dev;
> +	bool is_unique;
>  	int i;
>  
>  	if (!gpu)
> @@ -1115,6 +1117,28 @@ static uint32_t kfd_generate_gpu_id(struct kfd_node *gpu)
>  	for (i = 0, hashout = 0; i < 8; i++)
>  		hashout ^= hash_32(buf[i], KFD_GPU_ID_HASH_WIDTH);

Instead of this, suggest to replace this with crc16(). That has a better
chance to avoid collision as it takes into account the whole contents of
the buffer. It may work better than combining hashes with XOR.

Thanks,
Lijo

>  
> +	/* hash generated could be non-unique. Check if it is unique.
> +	 * If not unique increment till unique one is found. In case
> +	 * of overflow, restart from 1
> +	*/
> +	down_read(&topology_lock);
> +	do {
> +		is_unique = true;
> +		list_for_each_entry(dev, &topology_device_list, list) {
> +			if (dev->gpu && dev->gpu_id == hashout) {
> +				is_unique = false;
> +				break;
> +			}
> +		}
> +		if (unlikely(!is_unique)) {
> +			hashout = (hashout + 1) &
> +				  ((1 << KFD_GPU_ID_HASH_WIDTH) - 1);
> +			if (!hashout)
> +				hashout = 1;
> +		}
> +	} while (!is_unique);
> +	up_read(&topology_lock);
> +
>  	return hashout;
>  }
>  /* kfd_assign_gpu - Attach @gpu to the correct kfd topology device. If
> @@ -1946,7 +1970,6 @@ int kfd_topology_add_device(struct kfd_node *gpu)
>  	struct amdgpu_gfx_config *gfx_info = &gpu->adev->gfx.config;
>  	struct amdgpu_cu_info *cu_info = &gpu->adev->gfx.cu_info;
>  
> -	gpu_id = kfd_generate_gpu_id(gpu);
>  	if (gpu->xcp && !gpu->xcp->ddev) {
>  		dev_warn(gpu->adev->dev,
>  			 "Won't add GPU to topology since it has no drm node assigned.");
> @@ -1969,6 +1992,7 @@ int kfd_topology_add_device(struct kfd_node *gpu)
>  	if (res)
>  		return res;
>  
> +	gpu_id = kfd_generate_gpu_id(gpu);
>  	dev->gpu_id = gpu_id;
>  	gpu->id = gpu_id;
>  
