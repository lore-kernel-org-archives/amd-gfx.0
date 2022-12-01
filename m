Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C85B1C3A5A7
	for <amd-gfx@archiver.kernel.org>; Thu,  1 Dec 2022 23:04:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8AD7110E67C;
	Thu,  1 Dec 2022 23:04:09 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2054.outbound.protection.outlook.com [40.107.93.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1091510E0CE
 for <amd-gfx@lists.freedesktop.org>; Thu,  1 Dec 2022 23:04:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ni65obypODCrlktJbNF03dSqX7jg5HoFifEOwwZJ6aIlUc90oNNznQB1c0YJQcQa6y20pQaJd8/Oa4FTKPPGsdqeQlzfd0ooThVJAIMnL155SCA+fKoAOs5nQYGPSQ2ukokEqTJSQ8F7vBo3djXGvy/mljoyHhl2lhoWAPea+fxMMnbnTMV43/IEtbQDz4K1Js9ZXzuFiwMWntLMAdZMcGDZT98bfo3qZNqJ9qTfxpXQOZ6trW5je42xxMFJZWKf+6qHfAjNvZnLKkzq3MUmLJ44YsFyqAvQUZP4QRASqTS4tnmfXQWaRUpClzUSxk/HC84VGMPMKT2wJ57zozEsiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=owOLLtkQx7E8ifGI2CgOFA1cnYDiAwNnav2ZtJeZkBk=;
 b=HmV9sDza8bpANKbepegjsXxA6XrHRVrczdqRyGlhsqvz6fgS2cwoBwPQAixv9On7RI0+oBO9PeuaF7cuzCfm/QwErmw/PXDCKAMXnsl9qCZwHQQMtBpc1rlZ0i04BTBOScaTV59u4Qn0RFRe5taV4oEEXXvMfg71ZmJGV9ykF6pth/ALLihVwuOwT+cSrn0EMCDVdV3cU1L2WajjwOcyA2DIvHc9osHWcPO+EW2Ms7T+yCYK9s37u0a5KWrEaUqZIdzFsrFbg9XrGVHOxD888cxoF4J7jDyjZajP194Udob8kP5jDwI2xxRAe4qc67cFSMJ5KULF5iWYNa1sT0mqpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=owOLLtkQx7E8ifGI2CgOFA1cnYDiAwNnav2ZtJeZkBk=;
 b=e73VQ06XD5ex4fleHdSUJjQHrMoVbuvEjT9f0fJMvTADPxALHltx3gSBzsWGwZ0lF9mGf9Y7tCnmCPWVnFUve75vL92HIcE7ai0Tcf2DztakcbyhWO61X1Z3BBmoQYeZs4AaVpxdLyOTze91qdh++jxHarRIE289d7ZiTUoZNaU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3370.namprd12.prod.outlook.com (2603:10b6:5:38::25) by
 IA1PR12MB6140.namprd12.prod.outlook.com (2603:10b6:208:3e8::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23; Thu, 1 Dec
 2022 23:04:02 +0000
Received: from DM6PR12MB3370.namprd12.prod.outlook.com
 ([fe80::2fd1:bdaf:af05:e178]) by DM6PR12MB3370.namprd12.prod.outlook.com
 ([fe80::2fd1:bdaf:af05:e178%3]) with mapi id 15.20.5857.023; Thu, 1 Dec 2022
 23:04:02 +0000
Message-ID: <016f79cf-3bb1-0b35-f522-93ecf81d32b0@amd.com>
Date: Thu, 1 Dec 2022 18:04:00 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH 2/2] drm/amdgpu: expand on GPUVM documentation
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20221201214153.8453-1-alexander.deucher@amd.com>
 <20221201214153.8453-2-alexander.deucher@amd.com>
Content-Language: en-CA
From: Luben Tuikov <luben.tuikov@amd.com>
In-Reply-To: <20221201214153.8453-2-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT4P288CA0022.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d4::20) To DM6PR12MB3370.namprd12.prod.outlook.com
 (2603:10b6:5:38::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3370:EE_|IA1PR12MB6140:EE_
X-MS-Office365-Filtering-Correlation-Id: d7e62a7b-6332-4954-4c33-08dad3f0566b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: awBxL43UAWlHgRJ//AYqgzsUTyzAEnYiCWxIuBpvmJCgQ5eZ8DCZCf/OM+d9AC1x3mKNymSpbn3XSNYO0V3a7FnCvdQSnj0jy7kczou9Lq50utdXq1THBKrdzl4lA0LMGIZmdSzo9f+apmaJ2NejHWg2J6bTSB/xW0L2iAvhuq8XCWpu3dt/dX8i3X0PUrPK5TGgvwaFpqPWEYIVNu+alk/CPFXkjp19UbJxnRqt3+BiPhkEHoXQR5T3B8SWW8zJgW/R9o58dFlu1T394pGB7d9LGsOGj94Ggd+VaF1fS2nG9rdNKPw3tDXcaBwj9akkXue9RVGyg4wRj61lIer0uL6fY2Td4I4iEbzIrSNSu0jCgOAcGNqnvBTOvCtbCtgj2O9Af8UGn85TgthLWz1NWVNdBo3TcMIjn5g31SmHRD9/Fzado0WGfTSLMQhRH9mTK74rij1wqNhMO/wLIp8862TyVhqta6ixcjZZjUMISb3fNdkojZ38OTeWhKvLw7y1y4etwBNCI4vs8SkFSVg+FSmI5266mpEao/BMB2gIZRvyuR+X6RS9+jSEeyopvbVMWZxMXjQrGhiuBwZSOFYytygkRIbfGUgrzDeJkFCdY4Zwq86YOnVrcjY74xXgFKfYG8LctU04znogSWc36ZFmkntxPcFRK6JLv8BTmvtDm/7yy9bHN0AFY9RcvS6oiIqaEiGRHXfgko+lEqEy3YSJJTNFf7LHRSq4xBRR0yTJq2s=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3370.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(376002)(396003)(39860400002)(136003)(366004)(346002)(451199015)(2906002)(31686004)(316002)(66476007)(44832011)(86362001)(31696002)(6512007)(66556008)(36756003)(41300700001)(8936002)(5660300002)(8676002)(66946007)(6486002)(478600001)(38100700002)(6506007)(26005)(83380400001)(186003)(53546011)(2616005)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dGtiK0dQd2JDODBqZmpZRWF3YllHWGlLWmhFVEpON3BnUmt0TllQYWt4a0lI?=
 =?utf-8?B?b084QWg1RU53S0k0emgrZEp6Tm1rRkxLNVlOdVNFV0JlZFFOdnRnRnZ3OUJR?=
 =?utf-8?B?NWc4Vm81UGhWSVpSdjNJZlJYaXZCaENNMXlKY3ltaEdnZkwxaHFVbEk0TXhD?=
 =?utf-8?B?REFlbVJGeXpWY3JYN0hxSGJJdHFWWGJpZFNNYXFWWEFNSlZuMHZtRGlIU2tS?=
 =?utf-8?B?NE84Yy8wT1JPNldSTDB4eFlKTVc5V2hkZTd3amRFT3BvWXgzQVN5YTVYTlps?=
 =?utf-8?B?ZUI0T3dxZTUyUkZyUUNRU3YvYWhvaldzU0wrZGx6VkF0M1Y0MkZnbGoyZk5x?=
 =?utf-8?B?N3hLWCt0MWhmYWtSRFlCRGtFaGhNeUoxRzRXRCttbVZ2R0pBY0swaWN6aVJu?=
 =?utf-8?B?V3BTN3QyNXYrYmxhdmpEK1hYWnhtVFNoM3lTdDArN2Z3L0w2MitJLy92M2Nw?=
 =?utf-8?B?WnRIUUlpVDF3VEhuRW9DR08vMnVnWEcrSXpJRm1WN1NuNStxUy9obHVEYnhr?=
 =?utf-8?B?ejRoZDcyOHdZTkUwUkltaHZRSis0ME9Nd2Y0RFk5TWEzcFlDZmt3cnFTS2l5?=
 =?utf-8?B?YU5tL3gzM2ZxZldoNVZZLy93RHp5cC9hOXJwa3NrcFdabTVEZzRUUnNVVUNs?=
 =?utf-8?B?RmNmV1ZuTHFWcHk5YlZiSFVoS3UycTVObzh1eXMyckpHWW00ZVpTY29wUzBK?=
 =?utf-8?B?Q1VpYS9Mc1BIZDJob2N4OEhwdGtkMXpNQnFQUmpIaFZuK255RFUvRk41S3Zh?=
 =?utf-8?B?T1RMQU9PVG43U1FFZS93bXlmSWhIMGlqbGNFbDJxY1p0eithaDErNTgySXZ6?=
 =?utf-8?B?Wk9QcXFXenhvbFFlK1NlQ1hoc3BQNnY3amVsRTBZY2lrRWU5WkcraGtmVXJp?=
 =?utf-8?B?aFE3UlRiQTVSRExpemgzR08wOGFvTkcybFNUbWdXNE1jL0NiVFZNNnRqeTJv?=
 =?utf-8?B?d2NBQ0ovMEd2ZXREUGpZVHNzMUk3V2NnZEFEQmxtMTJPYkZtRHBiR0g4TTF6?=
 =?utf-8?B?QjcydjBMeDdUMVV3elphK3prWEZQSjRnc0lpTVN2MnlLYlhWbmEvdUk5R282?=
 =?utf-8?B?SUx3Y3lIdkZ0cmVqSVBDSWVSOUdON1BJOW5SaU9VZWNXbytQUDk1cVBMeHI1?=
 =?utf-8?B?ZERLb05ndCs2N0c5bGVNMkNnUFp2YmFqeUk0R2c4SzhoR3VJdWNBQ0pNc1Az?=
 =?utf-8?B?ZTV6N0I1dnZiQk5MQlRHUFNaSjJ3ZG03R05ZQTV2b3Z3UVloUFplZTRMOFZH?=
 =?utf-8?B?VkczMnNURnhTVDliK0xMZkRFVyt3RUMvYWVmdFpqb295VWVGdzcrK3RXSjh1?=
 =?utf-8?B?Nk1DTVQ2R3NoT3hidG8wRzIvVytoR09GTkNBYnEyMkphcytLekNMK0RjcUky?=
 =?utf-8?B?Vmp4MzlLRmdGZnF5Q1lwUFNUUkxxYTIrb3ZURnUwSW45YlY3dXl0YWMrWWlw?=
 =?utf-8?B?R0QrbjlVcjNlMS9XODEvRVJsb2g5S2dPNEpTUHppc0xmTlI2ZnZBR3pjU1pN?=
 =?utf-8?B?cWFHaGdjcmVJLzU0cDgxaGttUjBCLzFjbkdjc014UGMzTEpSTkZsNmlKYTYw?=
 =?utf-8?B?OXRGTmRNUHlVRStVM2VyTnZldG1oc3VWZEFEZElGQUJ6T2FPamhGb203dHRB?=
 =?utf-8?B?Z2tGMjk1SFFHYzY4UHRxOUZWUHg4WFNHQ3BEeEZ3NVZybGFyWFE3QkE0WWNn?=
 =?utf-8?B?ejYwTWlWeWJseXlPY3hsL3ZjV2FtczdmWXRRSGpoZ1pEU3hPMTI4aUdGSndM?=
 =?utf-8?B?SnltV1VOcTZZOGYvRy80anliejNSa3dwdUU4OGtlY29ZT01Pai8vaDdEcjVi?=
 =?utf-8?B?Nk9CREhhbStTbWcwZTF6SFY4ZHlZbkxNSEJDeWV0ajhKY3BWdGR4UElaRHhk?=
 =?utf-8?B?VkdQSlFjR1p3NFZXNTBMRkVvMHFXRXJtK2h1b21nRWhPdWxab3JaMWd3bFZP?=
 =?utf-8?B?T3dBQ1VFRHl4Q2pLMFRVNVBBUWZiRW5EV2svd2tOdFhYUloyeE1PdWg5SUN3?=
 =?utf-8?B?Q0ZYVmFJbzZiWG1hSzd0U2EyWWd2V3k0RStKWmUrNFo1dlpyZ0FqdG9jcUJ3?=
 =?utf-8?B?VmxZbXRmeThybTlNZyt4KzFlZFdyVG5ERkxRTW0vU2QyR1dBckg0SlhodGxw?=
 =?utf-8?Q?6Cz8pyimJaO7LZ9RKW6Ih4ZUD?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7e62a7b-6332-4954-4c33-08dad3f0566b
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2022 23:04:02.3705 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JVAyV4O7mubp+w3s1BAlEQjG//GjMahWe70eokl+dzSSTA5WMklgvfAzpyK3XPsW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6140
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

Reviewed-by: Luben Tuikov <luben.tuikov@amd.com>

Regards,
Luben

On 2022-12-01 16:41, Alex Deucher wrote:
> Expand the GPUVM documentation to better describe the
> hardware functionality and use cases it serves.
> 
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 41 +++++++++++++++++++-------
>  1 file changed, 31 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index 003aa9e47085..cb57a7bf5e2c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -45,22 +45,43 @@
>  /**
>   * DOC: GPUVM
>   *
> - * GPUVM is similar to the legacy gart on older asics, however
> - * rather than there being a single global gart table
> - * for the entire GPU, there are multiple VM page tables active
> - * at any given time.  The VM page tables can contain a mix
> - * vram pages and system memory pages and system memory pages
> + * GPUVM is the MMU functionality provided on the GPU.
> + * GPUVM is similar to the legacy GART on older asics, however
> + * rather than there being a single global GART table
> + * for the entire GPU, there can be multiple GPUVM page tables active
> + * at any given time.  The GPUVM page tables can contain a mix
> + * VRAM pages and system pages (both memory and MMIO) and system pages
>   * can be mapped as snooped (cached system pages) or unsnooped
>   * (uncached system pages).
> - * Each VM has an ID associated with it and there is a page table
> - * associated with each VMID.  When executing a command buffer,
> - * the kernel tells the ring what VMID to use for that command
> + *
> + * Each active GPUVM has an ID associated with it and there is a page table
> + * linked with each VMID.  When executing a command buffer,
> + * the kernel tells the engine what VMID to use for that command
>   * buffer.  VMIDs are allocated dynamically as commands are submitted.
>   * The userspace drivers maintain their own address space and the kernel
>   * sets up their pages tables accordingly when they submit their
>   * command buffers and a VMID is assigned.
> - * Cayman/Trinity support up to 8 active VMs at any given time;
> - * SI supports 16.
> + * The hardware supports up to 16 active GPUVMs at any given time.
> + *
> + * Each GPUVM is represented by a 1-2 or 1-5 level page table, depending
> + * on the ASIC family.  GPUVM supports RWX attibutes on each page as well
> + * as other features such as encryption and caching attributes.
> + *
> + * VMID 0 is special.  It is the GPUVM used for the kernel driver.  In
> + * addition to an aperture managed by a page table, VMID 0 also has
> + * several other apertures.  There is an aperture for direct access to VRAM
> + * and there is a legacy AGP aperture which just forwards accesses directly
> + * to the matching system physical addresses (or IOVAs when an IOMMU is
> + * present).  These apertures provide direct access to these memories without
> + * incurring the overhead of a page table.  VMID 0 is used by the kernel
> + * driver for tasks like memory management.
> + *
> + * GPU clients (i.e., engines on the GPU) use GPUVM VMIDs to access memory.
> + * For user applications, each application can have their own unqiue GPUVM
> + * address space.  The application manages the address space and the kernel
> + * driver manages the GPUVM page tables for each process.  If an GPU client
> + * accesses an invalid page, it will generate a GPU page fault, similar to
> + * accessing an invalid page on a CPU.
>   */
>  
>  #define START(node) ((node)->start)

