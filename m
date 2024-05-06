Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC8E4C25B10
	for <amd-gfx@archiver.kernel.org>; Mon,  6 May 2024 19:55:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4FB8B10F28B;
	Mon,  6 May 2024 19:55:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="w8EkBCa4";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2045.outbound.protection.outlook.com [40.107.243.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 60A9911234E
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 May 2024 19:55:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Oa8cMSKMlUkxoJv/LYehQtXWELZkQqb375yjU1eg6Ms6TBtxuZ6vVW4AycZIX1H5BeSdxXBMTALeIGkcjyMymQH1x1ZQaxEbK7Kpv0xNuVACs757XGxxOcRiIg/tZbRh1q3Skwz+Nl0gAfhJDcLMvzyLMEeTWySUJ+AsbmeaWGSKD5tRgSmJIqIiHNMjOyQVZ+3nx0WEtOe+wsA5fSW4J7BOQJdAbA72xwxSGp8WOO0jdv17azM2gHH0MelJyddKkwyXf+WI+0Dw/uB94QQwt1DozEwpfsSiYwpJZLvf6O8OcQG/FEYJyaWeyzKY80kpHOEyEORVEfJ7LhSEeMeP/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vipQCPDyOZ6NQU8QNSuVa+3cZ3AIPUFiawvEJART2Nw=;
 b=aFSEDcMf2BHFKuljoc7bUhcPb4em7eUZQcZKLatZH74emV++hvKGwIC8fQHOt++F2z3gXDc7l1U1GyJtk5aEwrP9uTCh27b7w73+6v8m1V3ndC6HQUCeVltut8NUJPQE6wnNgwtGa/Wj+MXgDAQZO2iw/XkpNln9jFjW2ORQLlG3qpW0q2lZXJ0DACTlQK57fvqPsGvSn+vIo1U3kWHgFM2K46hNSPzaMDeBYUvz6ICqDaRHAriajuimBlJqvzKILu3O1XzaLjezMO1LrIxoIKP/0g/B59dvI6yOEnYB8ihIBrZ5I0kqvQqEdhYL1iCneZnOlX5KFTy0xnTiTVnVUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vipQCPDyOZ6NQU8QNSuVa+3cZ3AIPUFiawvEJART2Nw=;
 b=w8EkBCa4j1ZhCxJZMA527z+vkPTdiVjuNHcIgzcT5eyOltPvKpup/O0IZml3wP9hq3T5dYCgXGOaD5RtlqGK89EYC8GCiQtqDM6A/314VVGqW4dAWkLODnJUYVtnx37Z8htZAbVqz6NMnxmaHE0+rA8e6/kMF84/H0ixXh/ieGc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by DM4PR12MB7623.namprd12.prod.outlook.com (2603:10b6:8:108::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.41; Mon, 6 May
 2024 19:55:11 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81%4]) with mapi id 15.20.7544.041; Mon, 6 May 2024
 19:55:11 +0000
Message-ID: <df6a0155-61b3-415b-b23b-ff52537abf40@amd.com>
Date: Mon, 6 May 2024 15:54:50 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdkfd: Remove arbitrary timeout for hmm_range_fault
To: Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: christian.koenig@amd.com
References: <20240501225655.5215-1-Philip.Yang@amd.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20240501225655.5215-1-Philip.Yang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQXP288CA0030.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:c00:41::36) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|DM4PR12MB7623:EE_
X-MS-Office365-Filtering-Correlation-Id: c42b26e6-a4d0-4d27-978a-08dc6e0664c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|366007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?U1FNbFFXaWFvOFA4RDN5VllHeGFjc1I3SkN5TWVNT0diaEFETUlteEIwOStT?=
 =?utf-8?B?QzBQTWlHVS93ZG9MV0tTRkVIWC9nSElOYUZnYjVBNDI0ZzFEb1lJR1FPSk4z?=
 =?utf-8?B?dCtDeEN0NmxiZ2VJK0VkS3phYjdhNXd4UDh0RXYvV1JvVE9iL20wTlZEVENM?=
 =?utf-8?B?b3hjZ2dGWDhaRHJla2lYUVpteGkrME9SeWFhVU5YN3NKcUY4RHB1dWgrUDJz?=
 =?utf-8?B?ZDE3OWJDclhhNkd5MjN1dXRYMFJITEloNERoaWNidTBwTVNBVTVwWHNmVWw1?=
 =?utf-8?B?WmRCbUpkZllkWlFDQ245MnhVMXprRTV0MWZsOVEzZFd4bmZuTjkzOCtTZ0hQ?=
 =?utf-8?B?eUxDdmJDRW9QTFo0UVEyaUNVR2N6cU12TXcrNTJ0cUtBSUZPVWsvN3lNREx1?=
 =?utf-8?B?THF6aXI0SFQ4eER2eml0MXZmdjVCVlVFbzNrZWhlTjc4SjB3QXRTMTdUenha?=
 =?utf-8?B?M0t0Ym1VYUQ4eXFWTmRMaUE1cEdtSkNvZ0tiSzFsdUdLeHZ6RWljaFdVdm15?=
 =?utf-8?B?ZXgvZXZsZ1FRSDV4Z040NUlyZXdTQ2Y1N25KdCtlYk1Jc1Z2QlVCVDB1MFM5?=
 =?utf-8?B?bytwU21YdXJYT1NKWWloTkZxRS9COUJZdFRFdFF5SENtcFR5TEIxWG1DeStz?=
 =?utf-8?B?Wnk0Z0hqWTBPbXRqU0xBSERmcU01c3VLVW45MXdnTFgxdmVFU3MwQ2FUOWlN?=
 =?utf-8?B?Q2RVRnNBb2FkMUozUFNnRlhzUXZrWWFtdEFRUFZaY0NVMU5NdjcyWmlHZlFx?=
 =?utf-8?B?NDQ0S1pmcjJNcC80Y0NvV3NNdjAvS2JsQ0hhSXZoVmdMajlLVDNUSnltbjAv?=
 =?utf-8?B?U1B1clFrODFSemJpS0wrMWFod0ltaVNCR2Y4S052KytUSmxtOEpMRGh4S2Ri?=
 =?utf-8?B?SkQ4eU54SnFONUk3LzRCdEtQa3o0OFUrdW9lQURLQ0dpeG95VjBKbGR0OFJr?=
 =?utf-8?B?Rm5CK2pCK1RsRE9LYXF0RHl6TC9XM0Z3aDVUMGlERlNiazVlcCtPandsUlJJ?=
 =?utf-8?B?OHhlb1d2NVNUYW1SbTIvbkcvTlIzNmFFSEJOY0VvMCtsam5XZEdhcUZwRi9M?=
 =?utf-8?B?VDBIcytwc2hEcUF1a1hiQUhWamdsVS9zdUpianEzODBuUThpRjhyY0p2NXRU?=
 =?utf-8?B?SWJLQnpFNUVRYlVxZGVjcGVzOEZwUGZKU2IrNHFTL084eUpEakg0cmZVUFRO?=
 =?utf-8?B?c1RmWGZjc2xJbEdKWXo2UE5uWVdrV0szWE9NUFlVTGdMOWJWay9qWkRFQjhO?=
 =?utf-8?B?MVRXaUVqbDFwVldxY05PVTk4OGx6Vlo3WmxlY2JYcXAzTHVzdHNGVHp1MVVL?=
 =?utf-8?B?ckNQVDM0K3pROE01a0l2N0tvcUtzTVd5UmFsWFpkWWg2c0dwNlJjckV2T3E1?=
 =?utf-8?B?U1hzVWl5bVF2ZGJsYVB2SmF4VlREdis4Wi9SdUhFMXpTQmJWUkt1QUpTSC92?=
 =?utf-8?B?SVFUb1ZkeHY2Wlo2Nk1LcVZzOEFWcEFPQWpiQ1d5enVRcDA1MVBMVXBtYzFh?=
 =?utf-8?B?V1BwZ2dXcHBVUkIvQ0FVdzhUUzNUTHZGUmFETktsa2d6WlBZNDRoaWkyS1ZR?=
 =?utf-8?B?MEJydGVWOTBQcnZEb1F3QmNLTXdpcjh6S2hJc08wR2Y3cjZRdFVEUS9vcTRk?=
 =?utf-8?B?UE5TYlg5ODBWSWNTblRnMkxDZTRYWHdiczNYbmdpcW1ZMUwyaFF4YXU4M3hM?=
 =?utf-8?B?VFJidzZtNlBDZTdGVGRzWndRc1p2VnlnZVFnY0lrZ1ErYi9FOGxJV1N3PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(366007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YzlvSVZlQzNGS1VjVkJrRUJsZjk3YzhJUC9Cdm9wNnQyUWhTVldiYWhVT3l6?=
 =?utf-8?B?bFBWS1c5SFo2N2EwQ2pKcml3SElvQ0VrRnE1eitSbHdJNzNpZUFvdUxvVzRL?=
 =?utf-8?B?b1JIazV4aExJeFBxWG5aRER2MHloZE5wdmNRLzJjSmRSWHRyb1RwQjlBTTcv?=
 =?utf-8?B?Vmh3QWowaFkrVGErNTZRclhlME9OVzRKS0N4dENVaUVJZktEYVlIMmNUSyth?=
 =?utf-8?B?S1BReW91UVRQV2tOSk5IYXk4NGxwTHR5eVNFK2lZZldodGJhYjExMDgzVHJD?=
 =?utf-8?B?VHNQZnZlQkFySVVRS2F4b2NYaVNRVmxtcmlRSm92Q1MwdXo5S1lvSEFCbE1D?=
 =?utf-8?B?emcxZXRjZ0NHN0FqZzhLcS9ZUmZ4Y2FMNkV4MDV6QW9xUE1hQmpGZUxOcXBz?=
 =?utf-8?B?Vmo3ZWgvcjJYTlRaaTZuSmx6bVdIMTN2c05nZEFPZUkyUXBUcXB3b1ZGZXlL?=
 =?utf-8?B?T2RvbldrdVZMTWF6RXZqaTZMQ2RZSk5PaVorRWdlcXoveFlRTGF3a2R4VENO?=
 =?utf-8?B?b3YyK1N2MVNocHBJQTNzTGwvUytYS0FzUWVNV0hJdW50eHZrc0JJUHFhKzRh?=
 =?utf-8?B?T3liTWN5T1phL2JucU10WTR6dnRuMFIvRVNNSkxGalQrbGFJYlZXNkl6aVFS?=
 =?utf-8?B?QVd1WnQ4K1lkTHhLblMzcHVmaVF5REFHQXRocFV5MHNSeEZ2d2d2K0l1QWFw?=
 =?utf-8?B?dkFVVG1CTHhvc1FjL2xKQkVKYkNMNXhlL3J1dXE3SjAyRWJ5Q3Mxc1p1NmlP?=
 =?utf-8?B?Z0dYR1hRRDROZ1dDbGpFLzJ4dzk5NVg3WjRSd0dQemxheDFFa0RZYkQ3ejRn?=
 =?utf-8?B?S0FzY0xzY1dOeHR0eXN1OHY3ZXlyQzl1OWtwWlBZMFFnTWJHaGxZcnBjM0Nq?=
 =?utf-8?B?MUxRTGo1NWZMeGxiblJOSXQ1ZkxJMXRadXRLR2FwZ0RzdFo3OWVPSjgvUFFW?=
 =?utf-8?B?ZUhFcHVHaFl0TW1XS3hlajZlNnZFTkFxb3RFczd0bjIyUE5RRUZOSm1GMVpK?=
 =?utf-8?B?c1BXS3M0RG5CMDNTNGdJSUlQWnZWQ0o4TGdKL2h5NzV1U1o3SFZpWlA1azdV?=
 =?utf-8?B?bnhqZHdxSU00MVBJVm9pKytFbTY0SHF6bW5HdjdONUljYXJoRXdiMStKalRV?=
 =?utf-8?B?cWVvbVVGc3pwN0Z5OFBVaHZYM3dncUZ5eU1zNlhQVTVvWi9BWlNTMnFhRnZi?=
 =?utf-8?B?dGFOaEkxdnV4THcvd1NPcC9jSURPMEF0bGxSYmZqMUFNcHZZSTc0SzcxcU8y?=
 =?utf-8?B?c3M2L0VCWG9JR3h0cFpmdkE5SW5UWlpXeGVYYUtMaW5zR1pGTTA4b0ttNWh5?=
 =?utf-8?B?UGNBeWUyOTExT1FibmtrVFE3OG9hd3VDVmhUb3MwcEpqQ0VVZHVKNkdVZGUz?=
 =?utf-8?B?TlNZVFF3UjMrV0ZUa3RzUTdGem96QjFsdHZ3RjM5NlpyS3dqSGNMYnE3TERN?=
 =?utf-8?B?SU9XVlpWMFppWkxFY2VBMTc1ODRjMDhDdGRrb0xGU1hydklSOGlaMW9WaTBy?=
 =?utf-8?B?c0tYRUJUUjhEdlowNmtTYnpBL1hyblNVTHJldi9zS0IrMTR5dGdpVGVSZEVT?=
 =?utf-8?B?d3ZYK1hZcy9VdTZGSkpwdnV0dU1oMlhnRXZ3bTZXYVB0V1A3U1BCOUJINlJD?=
 =?utf-8?B?NGs0UURISnlSeG5oNDRLN2czVWFxNUFIajRZM3I4VXFlVUgzQU1VajdBZXRW?=
 =?utf-8?B?NDJ4VXhCMlBtQWZjd01SOWZkY1JIdlk0U1Y1aGk1RDlEaE9SY2dzUlNjMDEy?=
 =?utf-8?B?M3JxQUhab2txaTBLSFB3bnB4QWdrdFNOSDlCeCs5Lzk5am5CckEyUUNLTWpy?=
 =?utf-8?B?ZGZ0RVpzaUNtU0RhUWpMa0EzVjlLL0ZXaWhjekRseHZESVdscEZWMFZEcjR0?=
 =?utf-8?B?VkpIS1JNZW9XYldFS21ub1FGZm8vSnhna0RJemoyM0RhOSt3MHJMc3lBclpo?=
 =?utf-8?B?elFPbkxEd1ZKZmQ5TzdhYnh4ckluRERFeVA2Wk4xOWQwRGVHVnJoM0x5OUFJ?=
 =?utf-8?B?MHdQMTJDQ1RveEordFpTYThrcUszWU9yUWJpWXk3VWVVelQ5WjBLRW9YOXlo?=
 =?utf-8?B?b09qbVZNOWVaaXhtdGNhbTJLK2IzcmlVdndoS3pjelI2N3RGd0dYUHRCNlJh?=
 =?utf-8?Q?Iq+cBCNoN1Ze0Mpxb7lIaz+6o?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c42b26e6-a4d0-4d27-978a-08dc6e0664c4
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2024 19:55:10.9950 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TtZViwCVkZbFIzTXEzBIpU9dQYeK4/Z+GB9SeCaYZJkQlmpTkl7GVZspyDpooTo8rOzgvfR9EljLzgee705dJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7623
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


On 2024-05-01 18:56, Philip Yang wrote:
> On system with khugepaged enabled and user cases with THP buffer, the
> hmm_range_fault may takes > 15 seconds to return -EBUSY, the arbitrary
> timeout value is not accurate, cause memory allocation failure.
>
> Remove the arbitrary timeout value, return EAGAIN to application if
> hmm_range_fault return EBUSY, then userspace libdrm and Thunk will call
> ioctl again.
>
> Change EAGAIN to debug message as this is not error.
>
> Signed-off-by: Philip Yang <Philip.Yang@amd.com>

Assuming this passes your stress testing without CPU stall warnings, 
this patch is

Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>


> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c |  5 ++++-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c          | 12 +++---------
>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c             |  5 +----
>   3 files changed, 8 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> index 54198c3928c7..02696c2102f1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> @@ -1087,7 +1087,10 @@ static int init_user_pages(struct kgd_mem *mem, uint64_t user_addr,
>   
>   	ret = amdgpu_ttm_tt_get_user_pages(bo, bo->tbo.ttm->pages, &range);
>   	if (ret) {
> -		pr_err("%s: Failed to get user pages: %d\n", __func__, ret);
> +		if (ret == -EAGAIN)
> +			pr_debug("Failed to get user pages, try again\n");
> +		else
> +			pr_err("%s: Failed to get user pages: %d\n", __func__, ret);
>   		goto unregister_out;
>   	}
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c
> index 431ec72655ec..e36fede7f74c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c
> @@ -202,20 +202,12 @@ int amdgpu_hmm_range_get_pages(struct mmu_interval_notifier *notifier,
>   		pr_debug("hmm range: start = 0x%lx, end = 0x%lx",
>   			hmm_range->start, hmm_range->end);
>   
> -		/* Assuming 64MB takes maximum 1 second to fault page address */
> -		timeout = max((hmm_range->end - hmm_range->start) >> 26, 1UL);
> -		timeout *= HMM_RANGE_DEFAULT_TIMEOUT;
> -		timeout = jiffies + msecs_to_jiffies(timeout);
> +		timeout = jiffies + msecs_to_jiffies(HMM_RANGE_DEFAULT_TIMEOUT);
>   
>   retry:
>   		hmm_range->notifier_seq = mmu_interval_read_begin(notifier);
>   		r = hmm_range_fault(hmm_range);
>   		if (unlikely(r)) {
> -			schedule();
> -			/*
> -			 * FIXME: This timeout should encompass the retry from
> -			 * mmu_interval_read_retry() as well.
> -			 */
>   			if (r == -EBUSY && !time_after(jiffies, timeout))
>   				goto retry;
>   			goto out_free_pfns;
> @@ -247,6 +239,8 @@ int amdgpu_hmm_range_get_pages(struct mmu_interval_notifier *notifier,
>   out_free_range:
>   	kfree(hmm_range);
>   
> +	if (r == -EBUSY)
> +		r = -EAGAIN;
>   	return r;
>   }
>   
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> index 94f83be2232d..e7040f809f33 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> @@ -1670,11 +1670,8 @@ static int svm_range_validate_and_map(struct mm_struct *mm,
>   						       readonly, owner, NULL,
>   						       &hmm_range);
>   			WRITE_ONCE(p->svms.faulting_task, NULL);
> -			if (r) {
> +			if (r)
>   				pr_debug("failed %d to get svm range pages\n", r);
> -				if (r == -EBUSY)
> -					r = -EAGAIN;
> -			}
>   		} else {
>   			r = -EFAULT;
>   		}
