Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA2A1CF2597
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Nov 2025 08:32:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 707E410E22C;
	Wed, 19 Nov 2025 08:32:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="GiMiwE0M";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012049.outbound.protection.outlook.com
 [40.107.200.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4E02510E22C
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Nov 2025 08:32:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WNcLXwHDNWNdu/7Z/9lV1S5rGyN3gc5YJDKbGDGnkOb2PwX2K6iG/s7QGe4CAs+5E78asoYUMunZATKWLP3Wxcn38LHrSVT0xMao4v07I6kod4mUiw6zKgaba6zrF3qYKU7oXeXmEzajNNBXCyUuteUKbMLSToCVwZiFmb6sOXa7b6nXEMK7f+OXmvV5ZEAx2acwv/s68wKncQsjNoD364PfmcIT5a4+LTLqNEypI/1K8V66LfDEvsiUw8cg6DW9/AqTAnXU9p1fPDqRoqzOMSqiKaWhTWx5uLizCacKHc7EC/RqAsyxBeU2+YOM4Nxz4GJcsw/5s1vfaMIFWiWi5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GbIQ820SJrgx8G5Ln3SvIKesknWErqjC5O9Ejq3IWtU=;
 b=TAb/N0YICqMQiDJQnWm4Q7ZNYffZaRJNd/ZahQFDoJcpeqRYPePsLQuWaRrxeussmuX/IYR2c2X7avfjTjpNr1Fr3eXfMkMDdhxMCw3IHqROJNzB6gRs/wZoFCesYb8wnLs4+jyIqN2m4CflVbJ554LVybCODG+r+cZZQTg+7IWP9+GR1UgRjfLmMoN0yFY+GujKCbfFqRY35oakUgmaPkPETAAJ7N7OheMh3Trpv9YiXQYMNh+Jj79ObtpqC7Z5L2VX7iUkGHoYzJB1nGeWHdBE3+WMj/0KmQiqjEMEo/tBVDlBmO5y8aICTBN+XwxpUhgT4ftb7/XISkF3UwfX4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GbIQ820SJrgx8G5Ln3SvIKesknWErqjC5O9Ejq3IWtU=;
 b=GiMiwE0MR287OHqcrVtnui+7WvYawleAsPpVgXsI1HyciFKJETw8Ym8plvdrYi/IruEKIDWIJ4zQ79qc45Ubd7DPzP/ViCYbW8aDLSqc4QrccDN9PxIMzskNEHBetszPGoX/wmZFh0LRzTKhEo4mv4u8YgwloHkYELMq2TE3LTc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by PH8PR12MB6844.namprd12.prod.outlook.com (2603:10b6:510:1cb::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Wed, 19 Nov
 2025 08:32:41 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%4]) with mapi id 15.20.9320.021; Wed, 19 Nov 2025
 08:32:41 +0000
Message-ID: <7efd581c-8ab2-4c1d-b8d4-5d3c28a854ee@amd.com>
Date: Wed, 19 Nov 2025 09:32:37 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] drm/amdgpu/vm: Check PRT uAPI flag instead of PTE flag
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>,
 amd-gfx@lists.freedesktop.org
References: <20251118165620.216753-1-timur.kristof@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20251118165620.216753-1-timur.kristof@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0372.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f8::18) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|PH8PR12MB6844:EE_
X-MS-Office365-Filtering-Correlation-Id: d6384420-96af-41c9-c34b-08de27463401
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RTNWNFdIcVkwcm5CSUV3MmVWY3cvN1hyUUY1U3dqV2ZFUUV1bjRzV0VEL0lU?=
 =?utf-8?B?aVNsbzdUSWdqR2UvRFI5Vnk2V1JSRE5mVUpCYnlxZjNIT25HZEoxVW1vWTJS?=
 =?utf-8?B?ek9uY09ZSy9IU0FoVjQrSmZxK3hqc1R0NEtDc0hIRGZmVWdMdktHb3BRbmhz?=
 =?utf-8?B?UFRYQU9jMnZrbUdXeHY2TllieGM2bXpOb0wrOThjWWZuTHE5RDF4ZE9RNGtE?=
 =?utf-8?B?WStXT3gwamlwaHdaSUFDbW40eW5RaVJTQWk4SUU4YkJLZC8yaTRBYjdnbG9k?=
 =?utf-8?B?M25XM3IwNmlCTzVsVEFpMnRrTlhuVWNhMUQ0WGVNWTNEWlpYRmkyMnhyayta?=
 =?utf-8?B?SnN0ZkZvREV1OUVwUnRDSEpXcFhuZS82a1U2SExLbmU1b29BTXJlMXVBRUdB?=
 =?utf-8?B?L1ZaOWw2UDJjU0tHTGw5bEk2Ti9weEkxQ2QzQ2J2bmt1WWpIWkI3cUYxeHpM?=
 =?utf-8?B?c0hnaEErMHZreWd5RDVOYkY1M1ZoRVcvWmlWN2FIRGw2RHRkQndrMjR2SVlo?=
 =?utf-8?B?WFZwUlJuVktpa0s5aDNGQi91L2VEUnFMYnFUdW4weDZiVThGbjdEK3YwNUY5?=
 =?utf-8?B?ZTRKYkVLcUNrNG5ycDRXOG9GTVkyZFo3TW1QaGxzOXQ1aVEzcXJCcWtxeWNI?=
 =?utf-8?B?SWJKTVdscDNjcHRENjRjV2wyb0FsV2U5UDhWakxxTXZ6QXcrRjkxOWRENHg5?=
 =?utf-8?B?TEp1eW1UWWY3OEdPZ0EzN0NIcENnY0dtYmpPc3cwQ2EzL3pUb2pEcklhOGRn?=
 =?utf-8?B?RThCTHhzT2NRRjNLdGY1cmZsSGpYajBuTEdhY0FnQ3B0M2lVVGNXQ0s4MVA1?=
 =?utf-8?B?VlMybi9SakNNcS9MREpYLzdaSnFISitwMkFSZ3ovVk9NWTJ6bE1WQ2dwYzVK?=
 =?utf-8?B?Q0R3VUl2d25vMDhvN21ZWmtPQTlSazBFK3Jad2lGWDgwTjYyK2tVSFpMWXJl?=
 =?utf-8?B?N3k2V1U3SDNMQUVhbDBZOWo2Tkw2QVMzT21wbCtRWnRFWVpGcDZqeXlKNEdV?=
 =?utf-8?B?NnZXMnE0c0RMMFBhczR4UisrK2JKNldQY1pJd3UyNWxobEhJMUJKaTVIeXBs?=
 =?utf-8?B?UzJTYnF5am1sMGl0UytIM0lxbXkvRXZxYUVocUNVV2JPUzVsMnFTSWFBT1lh?=
 =?utf-8?B?d21XMktwSEdKWnFxRElBR1o5bnBOVld0KzlCRFRxSHU1dHdoclJvWHd1Wkxz?=
 =?utf-8?B?QjhXRVJ1dHNBS3F3OFJNNFlmcDZUbTM2azM4SkV1SDJFWHJ2a2xzNjJYUUNJ?=
 =?utf-8?B?QW9lYkJrL0FsWDdENndmMkdld0gyTFRxQmNTSWNpREhVMHBBMWhTZU81UTg3?=
 =?utf-8?B?Wk1iRUhpaDgvaHZrQ202ZHl1aTBMSDJxTHZxWjlIQ24rYlh3U3M2cDFHekV4?=
 =?utf-8?B?bDZ5UnBKK1hUVDVBTFkrLzRxdXFkVWRSMVdURUM3RDh0dDdxN2NXY1dJZkNl?=
 =?utf-8?B?eElvdjIrdThJOVIrbHg5VDBnNnNNU2lFaEpoLy8yWWgvc05ta3ZncTBDcWwv?=
 =?utf-8?B?MmluNGw1SEt1enp5VU5FWlgyNGJNZEVTS1N0L1FuQzVveXhjMitoQThsYnVC?=
 =?utf-8?B?OWFSYzd5TFRZL1g5YUxIcFZMN3RzWkE3R0RkSkZlczd6RU9ya3ZJYzBDeG1C?=
 =?utf-8?B?NEV1Uk41UmZZdUVhOGx3bTdGb1VJUFlLemo4TjZQemR5b0pQbkYydzhGRXJo?=
 =?utf-8?B?aU4zbUFnVDIybFhGWHNPNjNOVVZtWnMzQkJ3c3FpNkZwakpPeHBxd283TTRE?=
 =?utf-8?B?T3ZWZ3ZZWTQ2VFJZMDZhdEVMMGphNnd3UFgxUStRZ0JqSjQ4TklHL0tmZmpQ?=
 =?utf-8?B?TS95K29yMFVSUkE5aGxka1FTdHhoRlN1VkJsM0ZyVUY4dys5OTZzNmE4OXp2?=
 =?utf-8?B?OXdNajlnZ3o5Zk96ZkJsZzR3UnNTK3o4U2FBWHVocDhxR2FiWkJZRXVjbE5j?=
 =?utf-8?Q?t232RS3TB+7Na4oXFT+/8xI29DdS9lgS?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TGJxVmFzcmViTzErSEZ0VXBQRzJWRldTbkU0TDVVVmdFdEdUTGRqVi9JUm5h?=
 =?utf-8?B?bm5YK2g5THYrNTRpclFCYU5tMnFkMWxGdE9GV0hQcm40WktLODI0UkVLUGha?=
 =?utf-8?B?ZTVsbjUxeTBDNkFaNmNoRGZZTDVGVHNjY083YXRzeGF4QTVLMHhBZGdXZmwy?=
 =?utf-8?B?akJrZVI4VWd5VDFXK1Q5b0RjOHZtV3hvQTBHRFJVdXFvY0NzeWRvTFd6cVRa?=
 =?utf-8?B?dk9tQkJLenBmTFN0Q2hCTkdFZUgyRjVhL2RkYXEydmNYWDI5YWhCeFgwZGo3?=
 =?utf-8?B?cFgrK3BEdjFtQldodXVKd1FSanR4end2bWE5djI5eDZYd0QwZHBRWEh1dDE0?=
 =?utf-8?B?TDUyTGNGUzd0K1hLMFNicVl1dWR0M0JYLy83NHcwQTJhd0k4RXJabitrOEpD?=
 =?utf-8?B?bXhsQnpjVGsvV0dTT091a00yQkxVVmZQeGZwMmNOL0VjWVUyQ3hBOWFaOFAz?=
 =?utf-8?B?TUl0RGFLSG5DTElVd3FZdkpRVVBDcTJSRm9CNTVuTzJWU21ZdTM3MGhxajY3?=
 =?utf-8?B?MnZjdjJRemJUU0pMV0ZEc3AzKzdYWDN5ZldpL3BYYS81RHF3MStBUXczZHpR?=
 =?utf-8?B?M3UwWEoydFZNU2c0YnhjZGtOL0NxbjZ4UFBML3RoYTVLRHpBdVhKTHdBM3o1?=
 =?utf-8?B?aWpRdnlSKzFXY25jVldxWXJWdTFxN0J2NC9RcDQyUXlLc0JxTEw5WXlVQ2tx?=
 =?utf-8?B?WFIyOVptaTF4NU92SGZYZTNBS3NxbDMxeVZ4Nm9hWHpzUDlGS3hIaHdyTUxn?=
 =?utf-8?B?QXRMMk4zMTlkbmZiZ0h2ZC82V084cWE1c1V3ODRCOURjeWJxdzN0ZlB1cjlZ?=
 =?utf-8?B?aHVNeGEvWmdVUGhtYXpsNHA0b2h6ekNNdzd1aCs4Ui9KRHpEeTRDQ3VZTUFM?=
 =?utf-8?B?ZzBqVUNKbUExNFhVVWxlWkpSOEFyTnBaUXdUazZpVE1CSHNnd1o5aFNpcGVw?=
 =?utf-8?B?Q08wTmduWXJGa0pJdnA2Q0FkeTM5K1R6UU9hSEl0QUVBMVdrZTllS0pvZXlk?=
 =?utf-8?B?VWRoZDg2SEJkd2JXZDhTR2JTS20vc21PKzBFSFVwNk00c2ZndXQzY2dKcWoy?=
 =?utf-8?B?TGZsV2wydWhvVjZuNVA1RDFFUkxmbUFRR29NaVovOHJib1U3M0NuOUNXY1pz?=
 =?utf-8?B?cEUrMVdPSlc5Ri9JaU1peUZXZE1tc1I0S0hrOVpCZ2RKR1NKTWgrVTRGZkNj?=
 =?utf-8?B?STY3blZLZW90M2puSUJkK2h6dTZDa29EM2pveTFONVBleXpGVUwxSUd5U0p4?=
 =?utf-8?B?ZXpRMDgvTTJJR3BrY0M1dVpKejdGeUdjQ3l2aDhlTzFCSzY1RE94Ni8yK0d4?=
 =?utf-8?B?M2ovM0J2TlY4L0t2aGNveFVNYXdLU1pkRFVCa3ZnVWt5S2xNRWdlVTZXemJX?=
 =?utf-8?B?Vndob1lobU5GQjFIeERpcFRmZE1lUzJwYXB3VWNYMlVLZnIwTnRhajBPMU93?=
 =?utf-8?B?a29RMm1nUlM0TDZzVkg0eTVvclJVZEdKQUNxMHJudG9vTXJ3L05vRU9WU2dT?=
 =?utf-8?B?TEwycjZpNlZoT0I5eWNoK3NLcDh1bFIyeXhLL2EvOVh3V2tXTVVJVTJXZWpV?=
 =?utf-8?B?RTVMYXlBTmNEbEtWWGRXRE1aTDFmdEtadEZOYXpEV21PTVdjN1JKdzRSdHdj?=
 =?utf-8?B?cFFPQmgzaTFHZWRNd2V2Z0p4NVVoTWNoUFNZa2QrWi94MThqcVVHNEJobkFH?=
 =?utf-8?B?c1BhT3VIMW1DdHpkL1BqM2toOTRpVzJMV2kwaFA4d05DUDhwaGJpeTZnZTE5?=
 =?utf-8?B?dHVMcTlOamtVR3lNNmlPWUhyWUM2Z3doWkpIYnV4WGhlajZ4NUVJd1pOdC8z?=
 =?utf-8?B?bDU5cWV1YVBEcHRwcDY4LytJSE9OT2JSenRVcHhZOXJMWlBFakVPMUtkdngx?=
 =?utf-8?B?OTllWEs2N2xMbXZBNG5jZ2hsbmw0Q1VEOWRzQWdodUZ3TDF1UUdnbW9OYXMr?=
 =?utf-8?B?blNkQ2pZMTRnMGpyN3p4M05COGVtRVIwRStvZnJkZVFXYWF1aVhiRFlURmNp?=
 =?utf-8?B?bzQ5dHNNak11eEtFNjRNaWpVbDZJVXp6WmNiUHd2TlV0enJRcG9DWVdaeERC?=
 =?utf-8?B?T3AzTXo0S0JJOURnUStYZGF5dmpiMVFUYXpUS2MrTDRYTC9VTG5vKy9BK01F?=
 =?utf-8?Q?4SJm9HYwWXjj25OeDtYYQ5A88?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6384420-96af-41c9-c34b-08de27463401
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2025 08:32:41.0259 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x/uKGTfniXOeYpoCdBJtLQ06LzwAVq+mQ+sSGZUsSecWYR3dBnAbrEBfurxflkMm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6844
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

On 11/18/25 17:56, Timur Kristóf wrote:
> This fixes sparse mappings (aka. partially resident textures).
> 
> Check the correct flags.
> Since a recent refactor, the code works with uAPI flags (for
> mapping buffer objects), and not PTE (page table entry) flags.
> 
> Fixes: 0fdf257286d7 ("drm/amdgpu: rework how PTE flags are generated v3")
> Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

@Alex this needs to go into 6.18, but not older kernels.

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index e803d173e25b..1a8155bdce5e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -2091,7 +2091,7 @@ int amdgpu_vm_bo_clear_mappings(struct amdgpu_device *adev,
>  		struct amdgpu_bo *bo = before->bo_va->base.bo;
>  
>  		amdgpu_vm_it_insert(before, &vm->va);
> -		if (before->flags & AMDGPU_PTE_PRT_FLAG(adev))
> +		if (before->flags & AMDGPU_VM_PAGE_PRT)
>  			amdgpu_vm_prt_get(adev);
>  
>  		if (amdgpu_vm_is_bo_always_valid(vm, bo) &&
> @@ -2106,7 +2106,7 @@ int amdgpu_vm_bo_clear_mappings(struct amdgpu_device *adev,
>  		struct amdgpu_bo *bo = after->bo_va->base.bo;
>  
>  		amdgpu_vm_it_insert(after, &vm->va);
> -		if (after->flags & AMDGPU_PTE_PRT_FLAG(adev))
> +		if (after->flags & AMDGPU_VM_PAGE_PRT)
>  			amdgpu_vm_prt_get(adev);
>  
>  		if (amdgpu_vm_is_bo_always_valid(vm, bo) &&

