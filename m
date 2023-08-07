Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5B8AC001DE
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Aug 2023 18:04:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 41E5310E377;
	Mon,  7 Aug 2023 18:04:41 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on20606.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e88::606])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E37E110E382
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Aug 2023 18:04:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z7I+4jlpKckpKqvuClSDppTGSed9ceeqIpGVAvyVPTjTaxrmdFhUvCTRpSm3+ypXrrak6ky5qQimBqm/FZlmCyeXwSO9xSeRqHMEWMaQVoqGs+7fkC1667/Cd1oP/9mRjK6dPNVqH9XAIGcLChrsLnJgPomXqUIo3dS1Ov6SFCbeZOmz2jCen7Rp/36lheflQXW5pfATW8hfhmOROGpc3MyCHEh563so5Ro4Dax/x0tcnQqmTtQ+GH0sUgub98daZGm8gMfONE5FhaO6FsmMqNgzPSSb6HOUGAFSIiUlBmzgfZVnnWHHeF7nm/2+3sdfqxApArhrwWnnTG+QLbLVpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J0FvVFoUpmpESSfN9GepPQqIRlQHoxDOtUK6nGMBbYk=;
 b=SO+NzDuZNUU7ugWA9SpNkNyGm57CN0punTgXfcKTiJOQvMdWeBlfQK5hrClX4wopFBnv/oaHCmBl2W5CyjnlQk5paqkjXcCi8edyN5tx0ZRfdCge4hDkKhxTjwUgtw1rVNC/MBuh2mg75IYXAoBdyWcWNSmrMgyNqy+jCwJhssSjCSymZENFK7QTGWkOpd/QkDgQqKmt5lF/fO4u5ykK1YIvjMlOUKDLWnP0r4u+BOpGEVRTbMnaQzj5FNFErQ3rkC9JlSU+HDFmaWzurBaIBqWGt5RMX0lAml+WSLH649Z+FwZTayT+8TdemD/K2S695hy4v2qlEuQCcTQkzEaL7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J0FvVFoUpmpESSfN9GepPQqIRlQHoxDOtUK6nGMBbYk=;
 b=A9Z5PBHOvGURaPDxGPijW/UygV8rtq2iwjRPpe4k6ctIJSQU99cRI8Md1fJ4zrt47ywpOezYiXRXsEhE+J9xyxVPQriEDDYY8E5D+VSxUM+fz+bWbd3OUKs4pxgsb7B79Bo5wgf3lQtFKfyhl7XdpQz4xXk4Nh59B75OGcZUwEY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by PH7PR12MB5928.namprd12.prod.outlook.com (2603:10b6:510:1db::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.47; Mon, 7 Aug
 2023 18:04:33 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::3d:c14:667a:1c81]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::3d:c14:667a:1c81%4]) with mapi id 15.20.6652.026; Mon, 7 Aug 2023
 18:04:30 +0000
Content-Type: multipart/alternative;
 boundary="------------9qVcRJqUdIaq5wE0dLwXhYUE"
Message-ID: <7981ee52-11b3-9589-3d2f-7258a47e3750@amd.com>
Date: Mon, 7 Aug 2023 20:04:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3] drm/amdgpu: refine amdgpu_bo_create_kernel_at()
Content-Language: en-US
To: "Yu, Lang" <Lang.Yu@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20230801071601.2124220-1-Lang.Yu@amd.com>
 <DM6PR12MB4250A5E1A001AC54DCC0F471FB08A@DM6PR12MB4250.namprd12.prod.outlook.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <DM6PR12MB4250A5E1A001AC54DCC0F471FB08A@DM6PR12MB4250.namprd12.prod.outlook.com>
X-ClientProxiedBy: FR3P281CA0199.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a5::16) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3587:EE_|PH7PR12MB5928:EE_
X-MS-Office365-Filtering-Correlation-Id: 23d4abdd-abfa-486f-35d5-08db9770bef2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +CuVACwFsv0Mw6KUXLAKdDbn2tJqM+i+ZflitdUtyN+GNMP1zfLY8xgmPCyEtej+m/P5xNcDq+epgA5aclHcPMmSDFuxJgNnljcLjOS7lyFBh9dKOdfHBNFzidIFdHno8ml2V/atkYSS/1nqNtJ/61LLnBA+VikZvu3LqV1ubBWK+20JNNVnsHjIviFQzst9ptDp0TgCPsJiREirFHh0MRsmWovpVLQa3WZyFwQ1fYWJ91XO3eIdqpmG2GvG+N74RBCF4HAu7P2lhdIjcG4Pw+HVDeyABquaqz1ti2iRUERUYUwB3vDkXe3PTylvUUzXyK5eymev0RsoOj+/h+jBEeBLP73X30woVAWCEvkcG0ZvrF9YGFl4NtG5HonlFh4aNc9JaghioDt34ml96h2C4QzzFENQjaB7fpnZr7VNJkroNWGX1YOge8XoxpaSSTgZqgTP/Qc5ne384Vjd1uAKtmNBq4jngwhPpJev0KBhR1hdWs8adGMFAiJzmD+cqRF82xVF6DVTxEkBQzX3hUm/F66j67VFN2FmON88wcRmaW1Ok1gXjYB90L9kwnb438VhAZfseGvN1hh7GsjEti13qWASJefxIsFRxLaP2IsNO3KguHjhibnjBSWKgSDjb/pM8/Ji+XaUu7ZFbS0so+sxTA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(136003)(396003)(346002)(366004)(376002)(451199021)(1800799003)(186006)(2616005)(54906003)(6486002)(33964004)(6512007)(86362001)(478600001)(31696002)(36756003)(6506007)(41300700001)(316002)(5660300002)(8676002)(8936002)(38100700002)(110136005)(4326008)(2906002)(66556008)(66476007)(66946007)(83380400001)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bktCUDFCclhHV2NBUXEvNDA0Vjk3SmxlUmZFL2wvMFQ3K3dGOFl6VW9Ud2xt?=
 =?utf-8?B?MURNSGNGTVVtbW9yazNodnZKcVdBNENDZHN1TTNOUkN2b1VqWHF3bU1nM096?=
 =?utf-8?B?M3dNMDdHZU1rbi9nUUZ0UWpsdnBwSDBjV05pZy8xOGFjc1B4emQxRHk0MUlp?=
 =?utf-8?B?bDBYbk41UDlyZUtzbDl1THlUUEkyTUNvQWpoT3M1Zll4SVV2ZmtDU1pvZEJo?=
 =?utf-8?B?WVNJc05rSzJON0dVNFM2bmU4WmN0L2wxZXVENzRZc00rclp2R0pCSWFvSHZh?=
 =?utf-8?B?K1JhU3FuSDNPRVliTTR0MVJBY2lBajdGZ0tScXdLK1dxSlFZeXJ6S2NHbUZN?=
 =?utf-8?B?MzUxWitXVTFqZm1nWWhpTkJhTXUzSUdvZWJXMEt0SVpZbUpNS1RkY0xvWlNV?=
 =?utf-8?B?VitMcTdnbDQ0cWRqRUVoZHhIbXdtWDh4TzU2Z0V5ajNzTHNkcE1BdFl2VC9V?=
 =?utf-8?B?UTJwWk42a21heHZXWUFyQk1qTFIvT0JUamNkc1Z2YmV1MUxMWGV2Wi85S25s?=
 =?utf-8?B?TVg3OUlkVlo5a3g2VElNQ2x6NUJKMVJMSWFBeFU3OTV1VlZkejRWNDN6YzV0?=
 =?utf-8?B?ZjdZUkFCamNYM0w4ckMyVEk0c2JkY2I4MVpPRndHbDFsNFpPd3FRN2ZvaVlm?=
 =?utf-8?B?RWxkcjBLbkwxSUMzckVsb2NYbGwwY2xvSWxJbHFuZ1pqeEd2cFk2M0lBL1Vv?=
 =?utf-8?B?OUxIWVBJdi9jd3ptbEhJd0pVRW5tUzRMdEcvOVNReFFvb1kvU1RDNkJpWjd0?=
 =?utf-8?B?S0dpdWNIVStoSzNFTEhHRUNmUlFJMnRyQW1uZFJoTWxhREVwQ2swS0xRaHZM?=
 =?utf-8?B?WTErVU05VDlEVmFjVlVwdmF4d3JNRUk3Ulo5bjZpemx5MzZ0Tzc2OXBRMlF1?=
 =?utf-8?B?a0Z3T2RpMVRqYlo5dGViL1NvTlZabFVsOWszNEVSQXd3cG02VWtWTTVBRkxp?=
 =?utf-8?B?QkEwNkd5UVNrOURVK0NpUWg5ZkZESmVLTjJkK0Z1dktySjlUSWp4TjFPS0ZH?=
 =?utf-8?B?Umt6Z21ZZ0V2YmZCOGNhK1VyeW9HZGlGUTBTcWlXUEpWQUtYbEZ1U3I5dzhR?=
 =?utf-8?B?RTF6c016Zm43UjJtYXVWdmkwQVV4SFNwT3RsS1VVRXRSL29ONVVya1JGbE5t?=
 =?utf-8?B?MjV1aU0xeHdweEFFbW1KdTVnUVEvS2EzVUdOdjJzeGV2V2pVMWtsTW9kUkI5?=
 =?utf-8?B?a3RDV2h6bXRHOTVRWW0zNDAzd3lYYnZkNEplNi9OYVd2ZENHT0N4R1JzbjdX?=
 =?utf-8?B?ckdvb204cUFwazNQR1FjaktNcUU3RXMrRFh6VEdlbDdTd25oQWF0RUVnQVds?=
 =?utf-8?B?N3p3QWlHbU5SRlUvR080aWovaXlQMDUwSTVQRklIWEQzMEVKdm9zcW4wWlBC?=
 =?utf-8?B?dklueWhZQkIzaHBsTDhKVkp5aHdES0wrTS9jNUp6Y1dWU0RJQzRha1pzQS94?=
 =?utf-8?B?ZWk2UTV6ZjZtY0J6SHZ2ZVNQdTFYeWVxOGN0RU1heThJeDhUY09RNFh2bzF2?=
 =?utf-8?B?R1pCZHdKS09mcFlPdjdHbzNtNjhxdVZBdWRGVktreTRTeXFqMitQQTlaeWJx?=
 =?utf-8?B?Vkx3cHMyOU1oWGxrUGxZNy81ZSt3VE5CL2xsYzZLZ2dMNW40SVE1bmVna2c3?=
 =?utf-8?B?eWI2ZmVnaUxPVUJKVGxZbzBXcWR4RHNRNlNTS25QTFhqK3IycEViL21uQmh1?=
 =?utf-8?B?aW8ybDRnamR1WnlzZEh4OU1OTk9oa3JTTkE0em16V1hDd3kzSTBzRUdKS013?=
 =?utf-8?B?V1FlejV0OFZGKzUyQ0V6OTl1RzZDSVMyUWxFVVh4Y0k0NFV0ZU1HZVlOTndM?=
 =?utf-8?B?VlZLQk1YQThZUWpMVzVPZUZJa09vZjQ1K255Q05VWFNKS1JIbDcwOGVUcXBQ?=
 =?utf-8?B?b1IreWRBbGRTL3NXcjNBVGN4OE0wRCtxeEpzWGU5aVZXUkFEWndyUWFhSWJO?=
 =?utf-8?B?eVlaNHNzNGNtZnAraG9MUi9VcVpkMmxPRG1ROHkzSFUvUFM1SFlxRlgzM1R3?=
 =?utf-8?B?Njc5MUdxT3RJSTJzWEVicVl5TU50djhxV2MwNGV3UHBWZDR5WGwxSEtNN21O?=
 =?utf-8?B?YU4vSDFSaXNwNGdRVkxrNHBNSE9xSnFIbUpDL3RWTGFRL1BnV0JXQkt0N0pi?=
 =?utf-8?B?T3FlUkJwWU9FUTZZc1RhdDF6QkU1bk5VcitQVlBNdDk4M1ZxRHpLRUNSc1RD?=
 =?utf-8?Q?8kMD5hzxjd+PrWkvEeUN9uEPi3a+RyK23bWEUUgP1xBn?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23d4abdd-abfa-486f-35d5-08db9770bef2
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2023 18:04:29.9800 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wdvg/gygG9DB8VLhNWnbHM3JZfwQ1Eule4zsOWOfmamNFCoym5cOrS7X59oXFBRs
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5928
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
Cc: "Zhang, Yifan" <Yifan1.Zhang@amd.com>, "Paneer Selvam,
 Arunpravin" <Arunpravin.PaneerSelvam@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--------------9qVcRJqUdIaq5wE0dLwXhYUE
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Am 03.08.23 um 17:27 schrieb Yu, Lang:
>
> [Public]
>
>
> Ping
>
> ------------------------------------------------------------------------
> *发件人:* Yu, Lang <Lang.Yu@amd.com>
> *发送时间:* 星期二, 八月 1, 2023 15:16
> *收件人:* amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
> *抄送:* Koenig, Christian <Christian.Koenig@amd.com>; Paneer Selvam, 
> Arunpravin <Arunpravin.PaneerSelvam@amd.com>; Zhang, Yifan 
> <Yifan1.Zhang@amd.com>; Yu, Lang <Lang.Yu@amd.com>
> *主题:* [PATCH v3] drm/amdgpu: refine amdgpu_bo_create_kernel_at()
> Use amdgpu_bo_create_reserved() to create a BO in VRAM
> domain would fail if requested VRAM size is large(>128MB)
> on APU which usually has a default 512MB VRAM.
>
> That's because VRAM is framgented after several allocations.
>
> The approach is using amdgpu_bo_create_reserved() to
> create a BO in CPU domain first, it will always succeed.
>
> v2: Don't overwrite the contents at specific offset.
> v3: Don't return GPU addr.
>
> Signed-off-by: Lang Yu <Lang.Yu@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 19 ++++++++++++++-----
>  1 file changed, 14 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c 
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> index ff73cc11d47e..df5ba9509a41 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> @@ -377,27 +377,36 @@ int amdgpu_bo_create_kernel_at(struct 
> amdgpu_device *adev,
>          size = ALIGN(size, PAGE_SIZE);
>
>          r = amdgpu_bo_create_reserved(adev, size, PAGE_SIZE,
> - AMDGPU_GEM_DOMAIN_VRAM, bo_ptr, NULL,
> -                                     cpu_addr);
> + AMDGPU_GEM_DOMAIN_CPU,
> +                                     bo_ptr, NULL, NULL);
>          if (r)
>                  return r;
>
>          if ((*bo_ptr) == NULL)
>                  return 0;
>
> +       (*bo_ptr)->preferred_domains = AMDGPU_GEM_DOMAIN_VRAM;
> +       (*bo_ptr)->allowed_domains = (*bo_ptr)->preferred_domains;
> +       (*bo_ptr)->flags = AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS;
> +       (*bo_ptr)->flags |= cpu_addr ? 
> AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED
> +               : AMDGPU_GEM_CREATE_NO_CPU_ACCESS;
> +
>          /*
>           * Remove the original mem node and create a new one at the 
> request
>           * position.
>           */
> -       if (cpu_addr)
> -               amdgpu_bo_kunmap(*bo_ptr);
> -
>          ttm_resource_free(&(*bo_ptr)->tbo, &(*bo_ptr)->tbo.resource);

Thinking more about it. As far as I can see this change should be 
unnecessary.

We remove the BO resources anyway and this interface here is only meant 
to be used for small reservations needed for BIOS handover.

Might still be a nice cleanup, but not something we should be doing easily.

Christian.

>
>          for (i = 0; i < (*bo_ptr)->placement.num_placement; ++i) {
>                  (*bo_ptr)->placements[i].fpfn = offset >> PAGE_SHIFT;
>                  (*bo_ptr)->placements[i].lpfn = (offset + size) >> 
> PAGE_SHIFT;
> +               (*bo_ptr)->placements[i].mem_type = TTM_PL_VRAM;
> +               (*bo_ptr)->placements[i].flags = TTM_PL_FLAG_CONTIGUOUS;
> +
> +               if (!((*bo_ptr)->flags & 
> AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED))
> + (*bo_ptr)->placements[i].flags |= TTM_PL_FLAG_TOPDOWN;
>          }
> +
>          r = ttm_bo_mem_space(&(*bo_ptr)->tbo, &(*bo_ptr)->placement,
> &(*bo_ptr)->tbo.resource, &ctx);
>          if (r)
> -- 
> 2.25.1
>

--------------9qVcRJqUdIaq5wE0dLwXhYUE
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <br>
    <br>
    <div class="moz-cite-prefix">Am 03.08.23 um 17:27 schrieb Yu, Lang:<br>
    </div>
    <blockquote type="cite" cite="mid:DM6PR12MB4250A5E1A001AC54DCC0F471FB08A@DM6PR12MB4250.namprd12.prod.outlook.com">
      
      <p style="font-family:Arial;font-size:10pt;color:#008000;margin:15pt;font-style:normal;font-weight:normal;text-decoration:none;" align="Left">
        [Public]<br>
      </p>
      <br>
      <div>
        <div dir="ltr">
          <div>
            <div>
              <div dir="ltr">
                <div dir="ltr">Ping</div>
                <div dir="ltr"><br>
                  <span id="ms-outlook-ios-cursor"></span></div>
              </div>
            </div>
            <div id="mail-editor-reference-message-container" class="ms-outlook-mobile-reference-message">
              <hr style="display:inline-block;width:98%" tabindex="-1">
              <div id="divRplyFwdMsg" dir="ltr"><font face="Calibri,
                  sans-serif"><b>发件人:</b> Yu, Lang
                  <a class="moz-txt-link-rfc2396E" href="mailto:Lang.Yu@amd.com">&lt;Lang.Yu@amd.com&gt;</a><br>
                  <b>发送时间:</b> 星期二, 八月 1, 2023 15:16<br>
                  <b>收件人:</b> <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.org</a>
                  <a class="moz-txt-link-rfc2396E" href="mailto:amd-gfx@lists.freedesktop.org">&lt;amd-gfx@lists.freedesktop.org&gt;</a><br>
                  <b>抄送:</b> Koenig, Christian
                  <a class="moz-txt-link-rfc2396E" href="mailto:Christian.Koenig@amd.com">&lt;Christian.Koenig@amd.com&gt;</a>; Paneer Selvam,
                  Arunpravin <a class="moz-txt-link-rfc2396E" href="mailto:Arunpravin.PaneerSelvam@amd.com">&lt;Arunpravin.PaneerSelvam@amd.com&gt;</a>;
                  Zhang, Yifan <a class="moz-txt-link-rfc2396E" href="mailto:Yifan1.Zhang@amd.com">&lt;Yifan1.Zhang@amd.com&gt;</a>; Yu, Lang
                  <a class="moz-txt-link-rfc2396E" href="mailto:Lang.Yu@amd.com">&lt;Lang.Yu@amd.com&gt;</a><br>
                  <b>主题:</b> [PATCH v3] drm/amdgpu: refine
                  amdgpu_bo_create_kernel_at()
                  <div>&nbsp;</div>
                </font></div>
              <meta name="Generator" content="Microsoft Exchange Server">
              <!-- converted from text --><font size="2"><span style="font-size:11pt;">
                  <div class="PlainText">Use amdgpu_bo_create_reserved()
                    to create a BO in VRAM<br>
                    domain would fail if requested VRAM size is
                    large(&gt;128MB)<br>
                    on APU which usually has a default 512MB VRAM.<br>
                    <br>
                    That's because VRAM is framgented after several
                    allocations.<br>
                    <br>
                    The approach is using amdgpu_bo_create_reserved() to<br>
                    create a BO in CPU domain first, it will always
                    succeed.<br>
                    <br>
                    v2: Don't overwrite the contents at specific offset.<br>
                    v3: Don't return GPU addr.<br>
                    <br>
                    Signed-off-by: Lang Yu <a class="moz-txt-link-rfc2396E" href="mailto:Lang.Yu@amd.com">&lt;Lang.Yu@amd.com&gt;</a><br>
                    ---<br>
                    &nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 19
                    ++++++++++++++-----<br>
                    &nbsp;1 file changed, 14 insertions(+), 5 deletions(-)<br>
                    <br>
                    diff --git
                    a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
                    b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c<br>
                    index ff73cc11d47e..df5ba9509a41 100644<br>
                    --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c<br>
                    +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c<br>
                    @@ -377,27 +377,36 @@ int
                    amdgpu_bo_create_kernel_at(struct amdgpu_device
                    *adev,<br>
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; size = ALIGN(size, PAGE_SIZE);<br>
                    &nbsp;<br>
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r = amdgpu_bo_create_reserved(adev, size,
                    PAGE_SIZE,<br>
                    -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    AMDGPU_GEM_DOMAIN_VRAM, bo_ptr, NULL,<br>
                    -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cpu_addr);<br>
                    +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    AMDGPU_GEM_DOMAIN_CPU,<br>
                    +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bo_ptr, NULL,
                    NULL);<br>
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)<br>
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return r;<br>
                    &nbsp;<br>
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if ((*bo_ptr) == NULL)<br>
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
                    &nbsp;<br>
                    +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (*bo_ptr)-&gt;preferred_domains =
                    AMDGPU_GEM_DOMAIN_VRAM;<br>
                    +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (*bo_ptr)-&gt;allowed_domains =
                    (*bo_ptr)-&gt;preferred_domains;<br>
                    +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (*bo_ptr)-&gt;flags =
                    AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS;<br>
                    +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (*bo_ptr)-&gt;flags |= cpu_addr ?
                    AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED<br>
                    +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; : AMDGPU_GEM_CREATE_NO_CPU_ACCESS;<br>
                    +<br>
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*<br>
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * Remove the original mem node and create
                    a new one at the request<br>
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * position.<br>
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
                    -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (cpu_addr)<br>
                    -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_bo_kunmap(*bo_ptr);<br>
                    -<br>
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ttm_resource_free(&amp;(*bo_ptr)-&gt;tbo,
                    &amp;(*bo_ptr)-&gt;tbo.resource);<br>
                  </div>
                </span></font></div>
          </div>
        </div>
      </div>
    </blockquote>
    <br>
    Thinking more about it. As far as I can see this change should be
    unnecessary.<br>
    <br>
    We remove the BO resources anyway and this interface here is only
    meant to be used for small reservations needed for BIOS handover.<br>
    <br>
    Might still be a nice cleanup, but not something we should be doing
    easily.<br>
    <br>
    Christian.<br>
    <br>
    <blockquote type="cite" cite="mid:DM6PR12MB4250A5E1A001AC54DCC0F471FB08A@DM6PR12MB4250.namprd12.prod.outlook.com">
      <div>
        <div dir="ltr">
          <div>
            <div id="mail-editor-reference-message-container" class="ms-outlook-mobile-reference-message"><font size="2"><span style="font-size:11pt;">
                  <div class="PlainText">
                    &nbsp;<br>
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i = 0; i &lt;
                    (*bo_ptr)-&gt;placement.num_placement; ++i) {<br>
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (*bo_ptr)-&gt;placements[i].fpfn =
                    offset &gt;&gt; PAGE_SHIFT;<br>
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (*bo_ptr)-&gt;placements[i].lpfn =
                    (offset + size) &gt;&gt; PAGE_SHIFT;<br>
                    +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (*bo_ptr)-&gt;placements[i].mem_type
                    = TTM_PL_VRAM;<br>
                    +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (*bo_ptr)-&gt;placements[i].flags =
                    TTM_PL_FLAG_CONTIGUOUS;<br>
                    +<br>
                    +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!((*bo_ptr)-&gt;flags &amp;
                    AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED))<br>
                    +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    (*bo_ptr)-&gt;placements[i].flags |=
                    TTM_PL_FLAG_TOPDOWN;<br>
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
                    +<br>
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =
                    ttm_bo_mem_space(&amp;(*bo_ptr)-&gt;tbo,
                    &amp;(*bo_ptr)-&gt;placement,<br>
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    &amp;(*bo_ptr)-&gt;tbo.resource, &amp;ctx);<br>
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)<br>
                    -- <br>
                    2.25.1<br>
                    <br>
                  </div>
                </span></font></div>
          </div>
        </div>
      </div>
    </blockquote>
    <br>
  </body>
</html>

--------------9qVcRJqUdIaq5wE0dLwXhYUE--
