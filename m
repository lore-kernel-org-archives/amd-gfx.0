Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A85FC47088
	for <amd-gfx@archiver.kernel.org>; Thu,  1 Dec 2022 17:20:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7EACA10E655;
	Thu,  1 Dec 2022 17:20:38 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eae::600])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5A6BF10E655
 for <amd-gfx@lists.freedesktop.org>; Thu,  1 Dec 2022 17:20:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jsCaCxep5Dj5DhQrXozqtkeHbjI02gKfMd6pu3HWXeeaQlhiKNRO2ImR+hhnnZt9roq+5ShfAK39kYdplVQDYREy4FT91iH6ka+XyEj8lS1Q6RmJ4HqyzWJSJYzHCwO96DMvAD01NsJbnxvWOqLMWZM/Ov1HQnPPmCFcHJatZwlT7Pvu9up01huU1E2n93p7z998NmI7Yi/pU40kQniBIyOtR6XbGiJGk7wxAHoRfaR2q3s+MF74Kjj0RP8zwYzwjgk7+TzDDkEcCvNXx5KRDpr2BFGrbMPPlENkb70q0w7r8caCCzDdfqhuss/VOyXo2qHFrYNCyr5JH7RU2u9hXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FfSKjB5VBMWXgYqKL89LmEU9y3jLk5WmgZNGhFHNVXE=;
 b=he0RLO1B2AIz0n61cNRWf3XC0tnmqNEGGtMLjA4io0EGk6zE3bts9sj6p8g9ftSAnuzor2rzByce/W+UuIuTZ8E7zjAytzBr86lEFe64VnbxCOo5RDLSKO59OwMbky24edADMhTjp4lA9i4p53QUwPnqn7vRyt9AKlESeCTsEvLWH0ZES5lTwN3IlmumScQ0ReJBZV4102ABGL2q4PvBodUcRNAyInxqx0xDhtx2R6KDUaFP9ahZtHG6Mm38nem7iZnSOECbzko6FR3sQsoQmpjg0MUpF1V1EPbEQ75B42JFWiViWrR5wNIBkQiP2M4ZLIkJMwJ9Zm+Xd3drF6NKTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FfSKjB5VBMWXgYqKL89LmEU9y3jLk5WmgZNGhFHNVXE=;
 b=kSam0Pt5GA1Rm7oFe5tNSLRpZPIVAWmI3iRemE7w3Qu3K90kV2FZ/pRh0+6BN+mBjkWb8XKvHAqV+pKUGfYv4s7WNgYpIp6fsh5NPxrk2H77fyjW6F1mUXNGn4dcRURkEwkaHOidbig3D8zGPAfrucAdNbK5sgc1HCKd5jrCWIU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3370.namprd12.prod.outlook.com (2603:10b6:5:38::25) by
 LV2PR12MB5917.namprd12.prod.outlook.com (2603:10b6:408:175::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23; Thu, 1 Dec
 2022 17:20:34 +0000
Received: from DM6PR12MB3370.namprd12.prod.outlook.com
 ([fe80::2fd1:bdaf:af05:e178]) by DM6PR12MB3370.namprd12.prod.outlook.com
 ([fe80::2fd1:bdaf:af05:e178%3]) with mapi id 15.20.5857.023; Thu, 1 Dec 2022
 17:20:34 +0000
Message-ID: <774af616-0781-a4fb-116b-9d5da9a78fa7@amd.com>
Date: Thu, 1 Dec 2022 12:20:32 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Content-Language: en-CA
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20221201162309.3112713-1-alexander.deucher@amd.com>
From: Luben Tuikov <luben.tuikov@amd.com>
Subject: Re: [PATCH] drm/amdgpu: add GART, GPUVM, and GTT to glossary
In-Reply-To: <20221201162309.3112713-1-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR18CA0030.namprd18.prod.outlook.com
 (2603:10b6:208:23c::35) To DM6PR12MB3370.namprd12.prod.outlook.com
 (2603:10b6:5:38::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3370:EE_|LV2PR12MB5917:EE_
X-MS-Office365-Filtering-Correlation-Id: 37292abd-6619-49a0-56db-08dad3c05b3b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9eogui7Z77qH9lv3kRWp74Tb6FilQHgsxOvJHfD3X/P6phHd5ZD4gSc1OoWIcWCqk7Tt36s53LGvb2WXoxQIotC1YbK1vosIrc3uF82L/R66SzAs8UEeKmUVLQPfz6kPUiwPPL7XNN19O+XZ7ubBG7Z1FG3BK0lSgiArROZkejcqDCYuqn3u/vyTeb8K//pVFeN+yePBIsHkGpxssSnuxS+mpsffo9GMiIL2iLciSBI3p5rftxDdL/o3bg99uoys3/f5kfqipGqZSyQe8WmquqODN3W0p6S4AmyNFdEYFRy1Qji8kXET3jypTN4KmFlf+0ZgPAw2kfTjebZ6XHTScqJ/SB8YvIRDXx6xzaHeu75IIhhEWhjxu1jIE4EuvWh0wAXpLdnceOOQqjNbskznkmgqH0W0v5wIvd7PHwPRt7xWk86mNzEYHtrEGrtLvVIQkzanbjv5210LGDAFvQGEJV9cFqtzWX0iS4Esx6TBZeWWqZ6LyYvS7rkR68qYOp3+i7BE/xtY2fTAY9pZYo6Cq/DcEfOTzcVqjO5YpGahTBmoDyZ3x2jl1pWrVpR6BvmmiQz4PlfEFmmlCPElIgfEMLJcwVqE46+haqPf48HlF198K5ICUR5EmRjBiOGgZeqr13tBIGrf3XUBPhal8k/yqKo0Fa47f6YpkQ4oJlBMsIuEN3DKJf6e8vDpOJe7rD+ORzYv4gsJqfv8nm2PgCX4UwqokS3SzJfp5Q4/VhPqv8s=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3370.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(346002)(39860400002)(376002)(366004)(396003)(136003)(451199015)(2906002)(6512007)(316002)(6506007)(53546011)(66556008)(26005)(66946007)(36756003)(478600001)(6486002)(41300700001)(8676002)(83380400001)(66476007)(44832011)(4326008)(186003)(2616005)(31696002)(8936002)(5660300002)(31686004)(86362001)(38100700002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TXJWaHhoT09sRi85QUJoNjh3YWdDMGJpNGdSdytNRFE0TVYzOTQ5WWhuelhV?=
 =?utf-8?B?YUVPOG1BNGtQeEU2L1QrR2hWSlV1RUJCeHpqU20vK0MwTWtjVXd2SDlHME5i?=
 =?utf-8?B?d3kzdEs1STJobkJKb3hZZnF2YmJNeHkxcERWeUo0ayt3MU1GbU5ndndmaHpC?=
 =?utf-8?B?MkY5K3BOVUcrY1g0VTBrdmQ1MC9tSEU0U2I0NWdVRE5QK0xXRWEzSGV2cGhj?=
 =?utf-8?B?VCtxUkpDVXR0SUxKdkJabzRDNURBZDBUVGRKUk90T1E3WS9Ga1J6U3NWY1dm?=
 =?utf-8?B?OTA2Nm5oM2VTRDZFY0YvTGJkaDNVaXFkdnl6aEhuNU5NbVJJMjc4L3l6MVRE?=
 =?utf-8?B?VG5XSDlPQ3I5aVlGQ0xtcE9iRllFZm5lejBLdEZiWk42OVhkR2ZsQ002NlJU?=
 =?utf-8?B?RnJhdlU0T3c2dTZrQWdLclU0ZlVxYTlMZ3pnRWJCQTREekZiN1Nhc2NFMjRk?=
 =?utf-8?B?Y1NKUjZ4ekpLK1BiSis2R291L2piU2FHV3RSK0FCcjYzVlROOTAwUHYyaUZ0?=
 =?utf-8?B?WERjTnFBS1RmbXEzN1Zib2F6MlU3MHE0T0d4cVliWnFmNXFqRUhZcS82YjdE?=
 =?utf-8?B?RWxmSndnVTNOSWtNR0xnRTgwdzRhSFlpZEZHR1RYUERaOEwzK2lxaDJzeEpS?=
 =?utf-8?B?RGhzVWppOWl2aW1aRThuTWdoU0t6N2xSSDFLeHcwTFk4TVc5UDZNM3N6bnFj?=
 =?utf-8?B?MitPR0V0ZEVtYUdlbGVqYUtzQzJvOS9rWGdCdFJxZk1uVXZvdXRZaVREdFRQ?=
 =?utf-8?B?QnpybkJlWnpqMFNyM3VFYWpDYzR1OVFDYzhDKzZiNWpuVmxDTWtCbS9Od1Zz?=
 =?utf-8?B?OGxSenBTRjFtaUd1RWZHTFc5aUVhd1hDbzRwOWdGZ0RDU1E5eElFVkgrVDFn?=
 =?utf-8?B?NEw3aGdoelJ6R25jaWtCK2g2OEFJZWR1ZGl1Zm0zVGlkdjhvMUt6a0N2cWkz?=
 =?utf-8?B?M2tQd1J1WDVmL1pXOXVKOGY3TUxNUDVhc1JqakhQMFdzZTJZcjJLNFZoV0tm?=
 =?utf-8?B?U1pQem9zQlFOd0JuMFpyU3paRXZob0hmMWl5VGNTQ3NoU0l0bXVuckl2ZWpI?=
 =?utf-8?B?T3B6VjZmeHBGdmNOTTdRcEJlVEVWNGxVc3NkREtLN1RiK21RM2RsdHVrV0Q3?=
 =?utf-8?B?RVU0ZldNTjZIMVNTV1UvdzRWTWVJYXJSTWJXWmphYmlrNUErcnBnd0k5eDQ5?=
 =?utf-8?B?ci9jVXEwTFJ2ZUZSeTJjNUw2TEEraEhlemtWcXpIOXFJZXpwalJPdHFTK0pS?=
 =?utf-8?B?T2NQdU16ZVRaQlJhVDFFTTlPaUFwS1NBREhVdHBPdlNzSmhVdmVxTDBpZGpL?=
 =?utf-8?B?aWNTMndYNFFPcGRUUTdWWXNWZVEvVGx2UGFzT05zdkJXbzMxcDBTd2t3UUNK?=
 =?utf-8?B?Zk8xSDZzQU5mMGtaazR0TGgrWDVFU2VlQy9HcnVTT3hObW1DdzY2RENwQ0Fv?=
 =?utf-8?B?Tzd0ZGM3NVNnRmRUU0NXY2E4dGpUZldMSUFMdDhORlNMVmV4cld1cURicjZO?=
 =?utf-8?B?UEVTby9IWEx6R0xHNFpQVmhidEFKd0VYcmFWd2VoNEhyWmxLZUl0ZGl4OXEr?=
 =?utf-8?B?ZWZhd2NyNFVVOHhMR1dXSHpad1VuOWJxK0ZRWU42YXNFSjBYcGZYdDhjRk12?=
 =?utf-8?B?bzZreWtDdzhNYmc4bTdIVkx3L0FxeUZpbVhyUXJpTEtEOFNySHYwTVJvZXhL?=
 =?utf-8?B?bVpHZEp2aVk1ZXZnK3hSZ0lDNExMZUo5UGhSRGNYcDROQlM4NDd2Q3R3QXJC?=
 =?utf-8?B?czYvZk5aSTZ2Q0k3VjdtRDZKRkZIUUxkMEUyUWRtUXNqa0pEZGJXRVU5SWdM?=
 =?utf-8?B?MnZhSTg0emRSY0k1WmFBNnozOFl3UkVLUFJrSlg5WUttblZrbWNYMU9LQmE1?=
 =?utf-8?B?ZFVPRTNqYmFtMklDZGQ1aktQT1BFeHZ5WWZ4Wk42YzRlcFp4SlgyQlQyakM1?=
 =?utf-8?B?RVZlWTQ3TTlDUzU1WkU1Z04wM0pORXVuYlptdGtza0N6ZkkyY1daMm81emk5?=
 =?utf-8?B?eWlGOFM2N2hkelQxbjVnT2U2YUlrYXpYeWwvQnhSQVJsdFZoRWVTM0FiQnE1?=
 =?utf-8?B?OUpwbFBBWkJuYjRDR0hTZk5iOUpqbGR0TlRtVyt6MVYxd3RrYnhWUThxM1Bw?=
 =?utf-8?Q?aZjxmt+ZQPi/OXQQKpp0yvexX?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37292abd-6619-49a0-56db-08dad3c05b3b
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2022 17:20:34.5705 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: obf6c6OKSVYqUalRePKNTicbH7U8kwKlX51btSm7TtsLqIOV4TnmI1s46VEB+BQA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5917
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
Cc: bellosilicio@gmail.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2022-12-01 11:23, Alex Deucher wrote:
> Add definitions to clarify GPU virtual memory.
> 
> Suggested-by: Peter Maucher <bellosilicio@gmail.com>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  Documentation/gpu/amdgpu/amdgpu-glossary.rst | 21 ++++++++++++++++++++
>  1 file changed, 21 insertions(+)
> 
> diff --git a/Documentation/gpu/amdgpu/amdgpu-glossary.rst b/Documentation/gpu/amdgpu/amdgpu-glossary.rst
> index 326896e9800d..944ebcef1d28 100644
> --- a/Documentation/gpu/amdgpu/amdgpu-glossary.rst
> +++ b/Documentation/gpu/amdgpu/amdgpu-glossary.rst
> @@ -30,12 +30,33 @@ we have a dedicated glossary for Display Core at
>      EOP
>        End Of Pipe/Pipeline
>  
> +    GART
> +      Graphics Address Remapping Table.  This is a GPUVM page table that maps
> +      system resources (memory or MMIO space) into the GPU's address space so
> +      the GPU can access them.  In the GPU kernel driver's virtual address
> +      space is referred to as the GART for legacy reasons going back to AGP
> +      and the early GPU remapping hardware.
> +

I'd probably mention that this is an actual IOMMU IP.

>      GC
>        Graphics and Compute
>  
>      GMC
>        Graphic Memory Controller
>  
> +    GPUVM
> +      GPU Virtual Memory.  The GPU supports multiple virtual address spaces
> +      that can be in flight at any given time.  These allow the GPU to remap
> +      VRAM and system resources into GPU virtual address spaces for use by
> +      the GPU kernel driver and applications using the GPU.  These provide
> +      memory protection for different applications using the GPU.
> +

I'd probably add something like:

"... These allow the GPU to remap VRAM, using GMC, and system resources,
     using AGP or GART, into GPU virtual address spaces ..."

> +    GTT
> +      Graphics Translation Tables.  This is a memory pool managed through TTM
> +      which provides access to system resources (memory or MMIO space) for
> +      use by the GPU. These addresses can be mapped into the GART GPUVM page
> +      table for use by the kernel driver or into per process GPUVM page tables
> +      for application usage.
> +

I'd probably clarify this simply by adding something like:

"This is system memory, mapped by GART or AGP, into the GPUVM, for access by the GPU."

I'm ambivalent if you want to add these, but it might make things clearer, as I'd
struggled with what something is, as opposed to what it does.

Having said this, this patch is generally,

Reviewed-by: Luben Tuikov <luben.tuikov@amd.com>

Thanks for doing this.

Regards,
Luben

>      IH
>        Interrupt Handler
>  

