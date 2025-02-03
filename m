Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E31CC02197
	for <amd-gfx@archiver.kernel.org>; Mon,  3 Feb 2025 21:16:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 908EF10E57A;
	Mon,  3 Feb 2025 21:16:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Dzpcr0OY";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2072.outbound.protection.outlook.com [40.107.220.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 072DD10E571
 for <amd-gfx@lists.freedesktop.org>; Mon,  3 Feb 2025 21:16:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Cb5f1uYziHNcWc+ZlBJ+bjq6LIh8tRwA80bPhXn6//Xp9MmyBfgpeqJFRcS9rsBKqAScbax3zUQz1nZ9OLVsM9PfoW/96uTz8IQ37bzBVhBmu+6Kx/Eq+VjtYU24w8uEZ2CY/9NMHUGkafV/JyTpGRiAkXB/Lvp4UQ+vnW7Kb292IJ4vqbf8sR/9yOPzQrNRJ4UAUCuohcXzDPYecBaEk3bhCQLjEktR6fAOFxDXOE1OwQ64+T+vrUMVEkbUSFduxO4d9dZuILziSDahu9G6nqswvqbESu1vISDGjlDoo/qwS0oPQJSV9m8ir/xgNVBE+JcZOa1Bb4aGgkJQ3b3F1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a6SMFRwtyW1q/HPxlc4XerxIA0ab48qyEv8871yyYi4=;
 b=F360ueutHHcrjz1GGRHoauNd+Hn50RECcE35z+oxD0PAuj4JhLfLrlu/wQ1PM+1lso91+Goo0nAD8DNVEDEdwTtZmA7y0oKK3LaINGN01emCiLOCSf+GheSbykTTgZuy3Jarmu6ZNpdFbpW6wSg+eu3oWIbFTPE/3Q108yvnZL76gCxf4kQUzwysvqpn9rnJnNcRge7t64psnKcSg6qVeQZldTLsCpHlrjn4GPYFgOGr+lIKbv31XdvAv8uX5ctSD/U5Hh31vmRA4lPRcsVARg/YYbwphs2hT4AmV48u6gH7boPXygreECUEuDBX2Zm3Q2k0fh/UGUJkgn/0WdNzKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a6SMFRwtyW1q/HPxlc4XerxIA0ab48qyEv8871yyYi4=;
 b=Dzpcr0OYLjDCGCtdqMUTLHngDNDT+7SHhJsHeSagumSlfEAMqKswCvDzj8C1yZj6vkqHLu81MRXqwilT9Q/vlXv6QfnX5KgnOdFcoQoszsIKij5/ah2XhUvZs3r+0yv1NTcUX98sX+WrOMtuWU0r61zn3DvttWJQbCGEiGdaBmA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ0PR12MB6760.namprd12.prod.outlook.com (2603:10b6:a03:44c::18)
 by CY8PR12MB7195.namprd12.prod.outlook.com (2603:10b6:930:59::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.23; Mon, 3 Feb
 2025 21:15:57 +0000
Received: from SJ0PR12MB6760.namprd12.prod.outlook.com
 ([fe80::25c8:f399:b2e8:1947]) by SJ0PR12MB6760.namprd12.prod.outlook.com
 ([fe80::25c8:f399:b2e8:1947%2]) with mapi id 15.20.8398.021; Mon, 3 Feb 2025
 21:15:55 +0000
Message-ID: <166a0328-ad27-4d41-9bac-8962dc52bafc@amd.com>
Date: Mon, 3 Feb 2025 16:15:53 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: allow pinning DMA-bufs into VRAM if all
 importers can do P2P
To: amd-gfx@lists.freedesktop.org
References: <20250109165756.26401-1-felix.kuehling@amd.com>
Content-Language: en-US
From: James Zhu <jamesz@amd.com>
Organization: AMD RTG
In-Reply-To: <20250109165756.26401-1-felix.kuehling@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQ1P288CA0001.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:c01:9e::8) To SJ0PR12MB6760.namprd12.prod.outlook.com
 (2603:10b6:a03:44c::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR12MB6760:EE_|CY8PR12MB7195:EE_
X-MS-Office365-Filtering-Correlation-Id: 880693b9-a748-4903-4281-08dd4497f290
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MEcxM1FIUldkeWxMWldvR2F2bDVNaEcyZHNYTDR6SDk3bjArckZkUmlYNU9i?=
 =?utf-8?B?eW1sSWJuWU1LNE1LOUhYSklkZXFoTlVTOFJId1pOV2E2bmR3S1pKUzdLVytB?=
 =?utf-8?B?WUd1amEzSDdINGZ0ZitBYThOTWRzQjdOQ0VBcTRpM0pvV2laK0gxcEpGa1RT?=
 =?utf-8?B?Vjg3cGFFOUxtdnpEVVc5WktiTEZJb3VMemEvbGMvcFhhTUM5NU9xUkp4ZnJh?=
 =?utf-8?B?RW1KZTBGVXE0UzlpUHBXZlpjbkk4S0RZMzUzOE9ZRDlveEZXSWFVazRzcEE2?=
 =?utf-8?B?RWJOL21WSmpuSzRROEdGdER3eUNPQytUTncrb0JRMDk1UmhMT2hSaDFCRHhj?=
 =?utf-8?B?cnN0WVkvc0tsUjdKaDJBUHBOK3NLa2RDRzFGMFBLM0hmWkhFWXlFbzIrTUhl?=
 =?utf-8?B?TVBxa25FeFBrbUVTcjBxL2E5cnRSdkJ6d1JkOHlxNDJzVEovNXREYVFhNU5R?=
 =?utf-8?B?cWZoOTdwSEZzN0VTYkFIZGVmVWhFRHBpWGd2amE0WUJlOUJNVFRhSDRPdGZT?=
 =?utf-8?B?Nk9TT3NLcUxsdXNTZmE2YXJFR29QNUNmK0p5bGxERkhMNW5IOVpMNjhNVFFK?=
 =?utf-8?B?YXhiL0NCblVXdFovT1h3WjhiRlEzMjhYTEp4M2JHM29FQ1JaWWtNRjFKcWFy?=
 =?utf-8?B?UWlab1QrUnhCSUJPLzVLWW0rODg1WnZVa1lnNnJobjd2ZzAyOWpQWXArMmdX?=
 =?utf-8?B?ZjVPNFk3WGp0STVkanVWck9peUFvM0NPZktxWHcwOWRDSVpDUUdmaXAwdENF?=
 =?utf-8?B?V2dGaHJwWG1ObnRkZHNWNzYrUjlNVWdUUkFFMUR5MnBVVlg5Qjl5aHEvckNj?=
 =?utf-8?B?YWJVbW5qZnQ3N1B6Z05ySzcyU1oyby96SFdWSklKREtDREZiSEozbWpaZWcy?=
 =?utf-8?B?dDQyUW5iQWJYUzh4bmdtMENyUmVzMFhDNS9ZTSt2R0J0WWlzbU80ckVVZk5z?=
 =?utf-8?B?d2RsNVA1Q3RnTXhUb0xma085V3dya0w3TkJ5MDNHTHFRM09qb3EveUN6N0cr?=
 =?utf-8?B?dUd3Um82UnMxVmw4MHpxWEhZN08xbGloQnZaclJIdFk5QmVDL0I0UjduaTQ4?=
 =?utf-8?B?ak5iVXAzOHBubTZNZGVuVE5GT0R5Mm51WUJETzRzSk81MitJMExRY1pxeUhp?=
 =?utf-8?B?TTNLckRiSksxclZQcXY4RVZLYU56VEI2NmJXWHFPaWdPb1VOVWNWUTNMT0Jj?=
 =?utf-8?B?WktKSktBN3lkL0sxc0RxcFBJNXd6SFRLTjhvd2V1MEVkbDRISjFVbzhjWlZz?=
 =?utf-8?B?Qm9GcW8rSXRNeFE4cC93dUFhMnV0NWdvbEFlR1N6bWtXLzhXemUwMDI3amND?=
 =?utf-8?B?ZGkrd1QyczltbWlhbjI1QzFid0FTWjdPMGIyT1A4VWhCcHVON29INGVydWph?=
 =?utf-8?B?VTdFVjZ4WjVKUmJrTDZCUjFFam0wZUNvWUR1MkpKSUZtTFVSVWNPQnQ3VGxj?=
 =?utf-8?B?T2UwaTAyZG1xUVl6bjVaVmxJZFhlOXFBODZKUis1elcvLzBCdkR5WTJsT2Yz?=
 =?utf-8?B?eUI0SmwrZUNyVTJ0NTBkejZWUjVaVStVTllnczZjU1BZUU8wSU5leVQ4M3Iw?=
 =?utf-8?B?SStkWmtMZkkrV1FVTWtyc25JSjRQVHp6NVhkVEhnVkMwdXZ6NzdVZk1QUmJx?=
 =?utf-8?B?bjVsR0dMNjRtYjNzOFRCUmVMOWNRMGdOaGk3bzF4V29DRmZYeU5Zc2FPMjQ5?=
 =?utf-8?B?NTNnUXIwQXBTdndtdHFaS09vcmdxdnpUSkZycTFjVUcvS0RBcUlqUGV4NzEx?=
 =?utf-8?B?UzRDQ3hlK0EwWmtwRHNUakkrY0ZtSFJZOENCN0FDUDNUaGh4R1ZhS0kvSzh0?=
 =?utf-8?B?cXlFc1AzUmU2QUtLOXRtVmFzV3hmMGt5bEJsWlpKTGNXV3hXT0FVbU8xeHZl?=
 =?utf-8?Q?rt7rAczHZLazr?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR12MB6760.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QkN3Wm4zcTY5NmpralpiZStudUxkMDR4emJuK25lUHFvN3pOSDhYWXlRMVhY?=
 =?utf-8?B?THZrVVZxS0xjZUd2L084Rmw2dE9OWEFGY0hOa0pIMjhEcXE5V1lqQkRXc0Uv?=
 =?utf-8?B?cjN1WTN0Tmt0YnRvTnNvcFZRNTI4WGY4dTNwWU5aMzJGM2RORENJWEpqUGpj?=
 =?utf-8?B?M2I5aVFEcWF4QTVPc05QUUl3L0RDNnpzM29hVjVZNFZYaFRKWXc0aUp2R0E1?=
 =?utf-8?B?UmVVaVcwblVwK0JHYkRaOGQyUk5yaWYwbUpsbHZpZE1OVDFFNkNGL3ZMNEpl?=
 =?utf-8?B?OGEzeDkxbzFEK1RQMHVsN0F5eHczRnVkbFVqYVcrYzRQZHIrSjNiMG9mcVVD?=
 =?utf-8?B?dW1raWtXSWYwZFRVTnhoM2VLUjBzbG5UVG9DKzJ5UHQ4bWdOdmF4NEVYeWRh?=
 =?utf-8?B?SExPL1g0UzJoNTdGQjJxWVVPd0M2c3luTzlHLzhJdjdTcW9sdE4xZHQwQmlB?=
 =?utf-8?B?TC9PcUp3Q3hyUmoyUFBLYVRlZEo2elBaejg4N0ZXcVhSei9EWVdpTHZhMjdC?=
 =?utf-8?B?Y1pZUVJjVit5R0UzTGYzVTUxMEsvdnhIeXMxdlorZW53UnhUVS80c203aFVl?=
 =?utf-8?B?cEw0UFlLOFVoVVREdUNTZjZtWTlFRkluQTRsSHdwZUQ0K1huVlVueFQ1MGpa?=
 =?utf-8?B?YkROMnR6V0V1TXRKbGs5OEM3RHk2SHJ3Qk1BSllzQVhydEtKYmM1SjkxaG8z?=
 =?utf-8?B?aGlQaFRnNFM5NGlKRWtFUlJ1QUF3TzNXNytIRnRSZmRQeFNaaTdFT3RrL2lk?=
 =?utf-8?B?dndpTlZrbWRqZEhCU2xnMEovejZjZlBKTTdzbXd5dWJjdmNaYnBPbEhHKzBy?=
 =?utf-8?B?emViZmx6eVRUV3B0L0l6UXcrZG9SOHNYVW1xeUNNQTExN0F6WnUzdWhIazhH?=
 =?utf-8?B?S0hKdFo1eWNOSmtCNDZjUGVuNFcvSEdRQjBGNEI2NWFhdFdvcDZEdlptc3Fy?=
 =?utf-8?B?UC91Uk5XMlBIRGRpVTJlWjhKRU5Ydm9zL1pJa0gzRGRLWEhFMXJIS3U2K3I5?=
 =?utf-8?B?bGhVcW9oY1kweDZmT01vUEJteHhqVmpwd2M0WWdNaVZEUXBxWm9DaWhFQzh0?=
 =?utf-8?B?VUlJZEpXazFQcUViYXdYNHo4L1B1dyt6MWlZc3pPZHZPTldFUjdIMDFSWFF4?=
 =?utf-8?B?WkFET2xrMXZIR2IwZ3d3RmJxRlBJSGRMSnNHektFT0lONHduRkZWUnJkSU9a?=
 =?utf-8?B?QUVhdVBCa1I5OHVFeWhQd0NSZ3NBaEEwYW80VUJHbnQ0VEpVN1UwcWV0bVhP?=
 =?utf-8?B?SDJiRXUrbW9RQWZRSmY4NEhtQkVYU1RvR2hMMWx1V2xseGNYaHZ2K0MrVEtj?=
 =?utf-8?B?Ti9RMFNDNDBJbFhKbGtiSi95ZzgwbGN2YnhraWw2eWpid2xGc0sxa0twUFQz?=
 =?utf-8?B?WitPNmtiSUdCZkJFZDdtQXZadHVlVWtiMTNiOFd0SHlqVW0xa1dHbWRBYy8r?=
 =?utf-8?B?TlQ4cUExWTRjbHZPaWc0TWY3OVhJc0Y2clpXekRKT3lodVdzQlBHZVk4Tnp0?=
 =?utf-8?B?SDNpVWMrNDk5REZIS0ZlUzBzNzN0aXlSaWxzRDNCQTQwNmdDdXl2eXZjUUkx?=
 =?utf-8?B?L1Bzbjh6bVJxNzRkeStDS2QvM2pDZjhLRUE5aE1iaXVxVlpZVUhtR2VrS25a?=
 =?utf-8?B?eVBzdDk3bzVFRE45d3I5Ymx3NmNsVXNWRVNyTEpXaFBoTDhvbm9USkg5QWI2?=
 =?utf-8?B?bGVWd3hOZUppeWptZmlVRXZPWFphbTQ3dzFpZVE0bjFHL1djN3Y3UW4xditY?=
 =?utf-8?B?ZksyRW0xN3lXOENxTEZtNWZQVVk3RlcxS2cydDY4R0RydGVnTU91VldiUmVl?=
 =?utf-8?B?OXdtT0pHMUhQUFdRbllkbkpVbkdKU2RWZHlpRlhwVUxiNjNoR1VYNW5QRUJY?=
 =?utf-8?B?SXlYR2hMOVNKRnVnMlZxbVRqelcxSHk3eUtJOU92NWhDV3R0TlJkb0RmQnc1?=
 =?utf-8?B?MGFSYVFDNWtrMDUxUVB3RktyZWxGdURNbXU5OUM4U0xNOGh0UlIzc1ZobWdn?=
 =?utf-8?B?eFNuSDRjcHl2TUF3SFZzRi8xN0p5L2FvdzNyQUI4aS9hMmlXVi9NZFkwRFd4?=
 =?utf-8?B?cmREdllzWklPOGluSG1WeEkwL243QjdqcUZGRjFrMDdzVXNBRERJczBIYkNr?=
 =?utf-8?Q?TOz0bPine0cm7x6Mj6hYqiJS3?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 880693b9-a748-4903-4281-08dd4497f290
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB6760.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2025 21:15:55.8662 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Tq9l/EjdeAO4x7jSnG9KuOhZb77DjUy8YVc9Bs/pNwRQIcdNFSwPshPM1fytgBfB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7195
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


On 2025-01-09 11:57, Felix Kuehling wrote:
> From: Christian König <christian.koenig@amd.com>
>
> Try pinning into VRAM to allow P2P with RDMA NICs without ODP
> support if all attachments can do P2P. If any attachment can't do
> P2P just pin into GTT instead.
>
> Signed-off-by: Christian König <christian.koenig@amd.com>
> Signed-off-by: Felix Kuehling <felix.kuehling@amd.com>
> Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
> Tested-by: Pak Nin Lui <pak.lui@amd.com>
> Cc: Simona Vetter <simona.vetter@ffwll.ch>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c | 25 +++++++++++++++------
>   1 file changed, 18 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
> index 8e81a83d37d84..83390143c2e9f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
> @@ -72,11 +72,25 @@ static int amdgpu_dma_buf_attach(struct dma_buf *dmabuf,
>    */
>   static int amdgpu_dma_buf_pin(struct dma_buf_attachment *attach)
>   {
> -	struct drm_gem_object *obj = attach->dmabuf->priv;
> -	struct amdgpu_bo *bo = gem_to_amdgpu_bo(obj);
> +	struct dma_buf *dmabuf = attach->dmabuf;
> +	struct amdgpu_bo *bo = gem_to_amdgpu_bo(dmabuf->priv);
> +	u32 domains = bo->preferred_domains;
>   
> -	/* pin buffer into GTT */
> -	return amdgpu_bo_pin(bo, AMDGPU_GEM_DOMAIN_GTT);
> +	dma_resv_assert_held(dmabuf->resv);
> +
> +	/*
> +	 * Try pinning into VRAM to allow P2P with RDMA NICs without ODP
> +	 * support if all attachments can do P2P. If any attachment can't do
> +	 * P2P just pin into GTT instead.
> +	 */
> +	list_for_each_entry(attach, &dmabuf->attachments, node)
> +		if (!attach->peer2peer)
> +			domains &= ~AMDGPU_GEM_DOMAIN_VRAM;
[JZ] I think we can stop check once one  entry has no p2p support.
> +
> +	if (domains & AMDGPU_GEM_DOMAIN_VRAM)
> +		bo->flags |= AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED;
> +
> +	return amdgpu_bo_pin(bo, domains);
>   }
>   
>   /**
> @@ -131,9 +145,6 @@ static struct sg_table *amdgpu_dma_buf_map(struct dma_buf_attachment *attach,
>   		r = ttm_bo_validate(&bo->tbo, &bo->placement, &ctx);
>   		if (r)
>   			return ERR_PTR(r);
> -
> -	} else if (bo->tbo.resource->mem_type != TTM_PL_TT) {
> -		return ERR_PTR(-EBUSY);
[JZ] Not sure if kfd_mem_dmamap_dmabuf needs update also.
>   	}
>   
>   	switch (bo->tbo.resource->mem_type) {
