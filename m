Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7621EC433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 17 Jan 2022 21:02:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C1FF710FCD2;
	Mon, 17 Jan 2022 21:02:51 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2048.outbound.protection.outlook.com [40.107.237.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CE7D810FCD2
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 Jan 2022 21:02:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h0SxoR9Rg2NxjLMJqqP9Xq/81107eLsl4vrJrZHB8cd1oC/jGvhuPVkf8TFrGtBh8NI6Jzx4VgawW3btXCCIs6s7QoDq/0ApPX0HTfL/IHdt9vMr1uTcrqsz1qkqXdqsAAE93zp/uXqp1424zlJ7kV/GAjrWhWjvSUWdmswyapXHIGiXj7fFqemzXv6qnedWPq+GEhkl3u/7NoKgnZpzx2BjQRejelQV5qnbR7nibDk4q45NAr+mLoaD88F1ixQ6nbYxzxUlv8Oh5BJAlf8fXEOrqInM1mf6omTnsveG64iSU+kEcWpfqfe8+WbARHXDZOJfnurMJEnJOEDmTzm6Jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7aBxgzZlrGcMbhv1Jc8oOsC1eudu8l+o1tl/WXT0SXo=;
 b=DLrh48deVQo+kAa3FIyR4nTfJGHEtPeMwKcLA/ybHvDz73UWGqLtT/rBidAqKeeRwjmAKb2AOEveMIGkerhekLqQaOqS1WygRCBo0j3LkORmqON1X56SObaZXqN2D857pz8y8pzrjlyqjsnvLuAGhIgh/NHRxwFzH00757zA3kM/CUjxkXueGgaxnTDYHNt+X8s819Sc31wiq16cEPMCUWfQ2OPG3GfC49HftjMO6Pn3PNR5txKsb495UQ0AyN9eC6wQafZdflehCSHI7PdvWpi6fVwvpCTzyNb2Yrh/W9+Seo1OILizskmzk6COijNMEJh835kLkk7Nzd2tKEffKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7aBxgzZlrGcMbhv1Jc8oOsC1eudu8l+o1tl/WXT0SXo=;
 b=kiyINd0KJpm0VWcVfVsPMNGoqhc00ABLX7KlLHjEjgYiXiPEWR9vy6DsqRjee+z2F882Vp5Ap7v45CZyiyIdA3Hr+YURIUFQX5/zxKC+MQfq1kNzHWSOuM+uj6//ofJYbVEk0IbWPjPviuqBVVZd3DA1SJePKnOr/xgD/UAaTwY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by DM6PR12MB3993.namprd12.prod.outlook.com (2603:10b6:5:1c5::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.11; Mon, 17 Jan
 2022 21:02:48 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::971:531c:e4f4:8a9a]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::971:531c:e4f4:8a9a%7]) with mapi id 15.20.4888.014; Mon, 17 Jan 2022
 21:02:48 +0000
Subject: Re: [PATCH 1/1] Add available memory ioctl for libhsakmt
To: "Bhardwaj, Rajneesh" <Rajneesh.Bhardwaj@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Phillips, Daniel" <Daniel.Phillips@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20220110205457.3165572-1-daniel.phillips@amd.com>
 <BL1PR12MB51449917D93BE664ECF3E5B5F7509@BL1PR12MB5144.namprd12.prod.outlook.com>
 <DM5PR12MB1531361295346BED5D6B4486FE579@DM5PR12MB1531.namprd12.prod.outlook.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <45197089-51b7-0f03-713a-87948fb87705@amd.com>
Date: Mon, 17 Jan 2022 16:02:46 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <DM5PR12MB1531361295346BED5D6B4486FE579@DM5PR12MB1531.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: YT1PR01CA0102.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2c::11) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9cee481d-d995-4658-9d44-08d9d9fcb76f
X-MS-TrafficTypeDiagnostic: DM6PR12MB3993:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB399336953AFF3A7484ABD94092579@DM6PR12MB3993.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FYlHUNPI9QOqg4J3dHCdc5Vb6H7UFQOKV/x/oyF21L2++zmem0x/vINDINd536yUjkFdUmT22T/xcaodie8Km+/BQPAjcAHvW5MHfyUbmj3cvkbLObohGugFDLEM1JgtdEnCpjCR6Ez2pKEXHPlVeBNLKRtCpC7wWCh7IUQokdcAlTnnkHZFVX1XP1oQX78+0uFfaurFYO+YAQV7PWhu7mgv+A3eSfmsIgSgv28RqbMtUo4QAPsJ/HVlC0YSlua8CUfjtUlw+kCTdC/KEO/ptBLBcay2QfnQtlf3o8/27HmO46j/VsdzYaR1eZUQfRkQ9dkQRm0mMFmf8nkXG2m/5PCNjxb1MtP1rrKvHkg9f2OTGVrNUCX2P2uF/V92W6RRMazJt8mH/rgj3UoOUFwlZQej/An55Fgy6KffeZmuIqp33W1SdXhpoFBnOfpk3GWmAwjSk0E/KETijLQ7Mkfsc9ghyh8/ukI/rPzI/5T7cZrwo1b8lDnXsSfiXvWtNcmVQGH9Q39KtwjbTTzY6PoVZpjuF7J8k6j1mV9Ez+n0MF9RCMPjFqNsl3qbqhsJ8k7KA0jHaxZDWDO4RKXLYZKKCZKJnLrYlQA9V/nyHvPlYdVC1pNDyzifWAPqN1JWNGUKNyvGvu+HAp+xCLfAX0x1W7hB6FPYeB+FfFCByAJDFgXj0zhGNnH06HmP9HkWKLoOLyNQrEyTcYcZAPfASFozdesnx1s4E43MPZWRZIjgs1cLVfmvU+bd9PmNFIcagtOF1lAu1a8e+qmHypZS2+isww==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(38100700002)(36756003)(44832011)(31686004)(83380400001)(6512007)(110136005)(8676002)(2616005)(31696002)(26005)(6506007)(2906002)(186003)(66946007)(5660300002)(316002)(66476007)(66556008)(86362001)(6486002)(508600001)(8936002)(131093003)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YlpyYUR0TmhZWFB5NCttZ1lDL2pDcDJleWJpWGFJMXlGRWJqdTIwaVp3VGlX?=
 =?utf-8?B?SVpaY2o1Y2xweGt1WXlpb1dVZnhyK2lPa3IxWDhqVVBtZDUveUJBZDJCSm52?=
 =?utf-8?B?ZzU3REVxYlZWSlJ2bU1Zd2ZjclAzOFFpcHdYVmtPYndONy9iOEpzTnhSbTZx?=
 =?utf-8?B?ZGpwUkpiT3dGcWVHbjFNNmZzbW5jK203WXFxS0lIMjZaQmpZU3lrN01TMzBJ?=
 =?utf-8?B?TUg2NHU3M0R6YkFUSmV5dHI1MW93L01QWnV0THk1SlJRMzc4WWxaZTM5UEgw?=
 =?utf-8?B?eUhyS3NTOUd4QU9ZQlZ6L0RkQ2p0L05xU3Fjc2FnNkdxQWlzUUJ6eFNuUjJT?=
 =?utf-8?B?Nk5tNXAwTC9JemNEeVBETnFZaDdtcVE1OU8zMk1xR2lOU3dBc2Z1Ylg3MWd4?=
 =?utf-8?B?Sk02TFNRTjc0MCt1YUEvbDlPeHpyUlVESkR6NmI0d2NuRE1MVVhiRnR0dmRI?=
 =?utf-8?B?SjhWZlE2bi9HSXRkZXo0c3RjajRLb0FaMTVqQk0rWnJHQTlCM1dXcFVwazRL?=
 =?utf-8?B?aS8xOHJJWUJhMTlBaHp1ZGFxM01ubGs5bVNXU2lFUXJVclF6T0NoYi9YeG1H?=
 =?utf-8?B?bUlBUnhrUnovSm80SllXOStDSlpSWnJWTjhjVmdRQlYxK2xvTVRhUjAyZWRS?=
 =?utf-8?B?dE9LcytJb3VVeTBRQVpxVGNFWlpoZURlVkRsWWoyMzhxaUs1S1Q0Q1dpc1VD?=
 =?utf-8?B?YTltMk5UOTZ6STA4aVd0TTk3NDRDSnVkc1Z4Q2tTeDA2M3A2cTBGVUNwZnNJ?=
 =?utf-8?B?VXU2UHRwdlpWMzJySE4xN3dpRnp5R0VKMWR3VWxUcUN6aHZsQVhrN2ZFanpv?=
 =?utf-8?B?ZlpsNXZRQ1JRazg4aDVTa2F0RGpVOW1YYVkzUmVnMFVCR0ljOWhKT2x0TmFD?=
 =?utf-8?B?S0ZvVVFDQ1Fudk1FejlrVmpYcGZsRGF0N1pNVEVRaDBOQjZsU2pWWHBqMTNX?=
 =?utf-8?B?UW8xNFV1YlZIU0JGbXJNNUQ1ZkJCK2FOUitJckczMjFBNDQzVG1MQjZ4L2VZ?=
 =?utf-8?B?T3Q1MU1vc2NZWFQydTB1cElzcFYyTG03Vmh3RXJ6Mkd1ZUNOMDhEVVZEVkVM?=
 =?utf-8?B?cnVPSGQxTTFubGtxWXV6VngxTVA4WDMxbzVNRzQrNDEzODBUUFlYNWd0YzlP?=
 =?utf-8?B?b28zdkZyUDBLWTlnNVp6anFkZXpnV3IzYnVWdVQ3SVc1a2ZIUFR1c3piUTdz?=
 =?utf-8?B?a21DbDJsVGlrWHhlUVE4WWZDbjlQOVphTFNHK1ovbU5SVWVwRUNIbCtQWjc1?=
 =?utf-8?B?ZWdiaWVKOGtrUGpFR1RpYTZPa0JHSU1CSjlBR1RMdVRHMm0vaHh0dU1Mb0lJ?=
 =?utf-8?B?NEZZMkVrOXQwSjJWQnRTNEtYdGpJQ3NFMjhkOTNTUzFCV29md25rbXR0ZDIw?=
 =?utf-8?B?Tkk0UzdzYXN1Y3lBbVdCWE1BWURRRzhXdzYySGdENW5WTmlOU3B3Z2sxSTVk?=
 =?utf-8?B?cTNUUUhkV0JodUUrQjkzRDhaVVlYZVZoem9iSEJHMUlRb29SdXRmUyszZHFy?=
 =?utf-8?B?UVI0VzBDU3hSSHhadnFzWm1BempRR2hPK3dMMkltN0lyRTR5c1hXYkVSd1Zh?=
 =?utf-8?B?WUhTNmVieHYrWWxLUE4rM1pOT25Eem9yNVdGRHR2MGNWNExSaTFCcUJVeHN6?=
 =?utf-8?B?Qlo1WElmTmEwdGprcTFacFQ4U01ubGVqR1B2T3ZRYitqNFNJOWhVSjBjUDh5?=
 =?utf-8?B?RmRSYTA2T3E2TEgwRlU3elhVNWtXTnFlMXN3ellrUTJkVW9YaXg3YlF6RTFi?=
 =?utf-8?B?amQwbjRmMStVU3ZpYUJWODJsRlRtMG00d09qdVdDelh3NDJsYlRPb0U1T3B5?=
 =?utf-8?B?VEZzWjdsL2tNSGY3NEM1RXR2STZYZ0d2dUtXRDdEamZTZndUUnRMdFFBOVNj?=
 =?utf-8?B?aHhPQjhuSzZNbW5UczFTazh6eVhOdWxTWnF1UmlOSTJBaXp2cDlYMFlRT2g0?=
 =?utf-8?B?YjRMUjVhbHA0ejV6UkxPZDJRd1ZCa1J0YmlRVWR5VjVLeUZNVFNqUXBnVm85?=
 =?utf-8?B?eTZnUldyN1dVT3VmMGdtbWc5RmxvdE9uT3NIU0thUGM1aHkyVEpPZXNIUE1X?=
 =?utf-8?B?MTdQQTZnMDczV2w0T3d2dlRSQW1DcU5FMUVCSnh0N0xUc0dRdlpaTXRuNkdI?=
 =?utf-8?B?SnZhcFdsL0xWcXE1RTJnK29kYWZIQWhhVzcxV0JzQXBha1IxTEVMZ0paUjU4?=
 =?utf-8?Q?aRsszrb+ya8+BEYVJEMPYD8=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9cee481d-d995-4658-9d44-08d9d9fcb76f
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2022 21:02:48.3573 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pPiqy5a6aMmfGUDdn7d+QeagOFt/vfhSlptamcCcMU13YFZW6I5lNHfsxjHum34WEyAZns6OjDI39Lk30nOTLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3993
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

Am 2022-01-17 um 9:50 a.m. schrieb Bhardwaj, Rajneesh:
>
> [Public]
>
>  
>
>  
>
>  
>
> *From:* amd-gfx <amd-gfx-bounces@lists.freedesktop.org> *On Behalf Of
> *Deucher, Alexander
> *Sent:* Monday, January 10, 2022 4:11 PM
> *To:* Phillips, Daniel <Daniel.Phillips@amd.com>;
> amd-gfx@lists.freedesktop.org; dri-devel@lists.freedesktop.org
> *Subject:* Re: [PATCH 1/1] Add available memory ioctl for libhsakmt
>
>  
>
> [Public]
>
>  
>
> [Public]
>
>  
>
> This is missing your signed-off-by.  Additionally, for UAPI changes,
> we need a link the patches for the userspace component that will make
> use of it.
>
>  
>
> Alex
>
>  
>
> ------------------------------------------------------------------------
>
> *From:*amd-gfx <amd-gfx-bounces@lists.freedesktop.org
> <mailto:amd-gfx-bounces@lists.freedesktop.org>> on behalf of Daniel
> Phillips <daniel.phillips@amd.com <mailto:daniel.phillips@amd.com>>
> *Sent:* Monday, January 10, 2022 3:54 PM
> *To:* amd-gfx@lists.freedesktop.org
> <mailto:amd-gfx@lists.freedesktop.org> <amd-gfx@lists.freedesktop.org
> <mailto:amd-gfx@lists.freedesktop.org>>;
> dri-devel@lists.freedesktop.org
> <mailto:dri-devel@lists.freedesktop.org>
> <dri-devel@lists.freedesktop.org <mailto:dri-devel@lists.freedesktop.org>>
> *Cc:* Phillips, Daniel <Daniel.Phillips@amd.com
> <mailto:Daniel.Phillips@amd.com>>
> *Subject:* [PATCH 1/1] Add available memory ioctl for libhsakmt
>
>  
>
> From: Daniel Phillips <dphillip@amd.com <mailto:dphillip@amd.com>>
>
> Add an ioctl to inquire memory available for allocation by libhsakmt
> per node, allowing for space consumed by page translation tables.
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h      |  1 +
>  .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c    | 14 ++++++++++++++
>  drivers/gpu/drm/amd/amdkfd/kfd_chardev.c        | 17 +++++++++++++++++
>  include/uapi/linux/kfd_ioctl.h                  | 14 ++++++++++++--
>  4 files changed, 44 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> index fcbc8a9c9e06..64c6c36685d3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> @@ -266,6 +266,7 @@ int amdgpu_amdkfd_gpuvm_acquire_process_vm(struct
> amdgpu_device *adev,
>  void amdgpu_amdkfd_gpuvm_release_process_vm(struct amdgpu_device *adev,
>                                          void *drm_priv);
>  uint64_t amdgpu_amdkfd_gpuvm_get_process_page_dir(void *drm_priv);
> +size_t amdgpu_amdkfd_get_available_memory(struct amdgpu_device *adev);
>  int amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu(
>                  struct amdgpu_device *adev, uint64_t va, uint64_t size,
>                  void *drm_priv, struct kgd_mem **mem,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> index 86a1a6c109d9..b7490a659173 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> @@ -190,6 +190,20 @@ static int amdgpu_amdkfd_reserve_mem_limit(struct
> amdgpu_device *adev,
>          return ret;
>  }
>  
> +size_t amdgpu_amdkfd_get_available_memory(struct amdgpu_device *adev)
> +{
> +       uint64_t reserved_for_pt =
> +               ESTIMATE_PT_SIZE(amdgpu_amdkfd_total_mem_size);
> +       size_t available_memory;
> +
> +       spin_lock(&kfd_mem_limit.mem_limit_lock);
> +       available_memory =
> +               adev->gmc.real_vram_size -
> +               adev->kfd.vram_used - reserved_for_pt;
> +       spin_unlock(&kfd_mem_limit.mem_limit_lock);
> +       return available_memory;
> +}
> +
>  static void unreserve_mem_limit(struct amdgpu_device *adev,
>                  uint64_t size, u32 alloc_flag)
>  {
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> index 4bfc0c8ab764..5c2f6d97ff1c 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> @@ -486,6 +486,20 @@ static int kfd_ioctl_get_queue_wave_state(struct
> file *filep,
>          return r;
>  }
>  
> +static int kfd_ioctl_get_available_memory(struct file *filep,
> +                                struct kfd_process *p, void *data)
> +{
> +       struct kfd_ioctl_get_available_memory_args *args = data;
> +       struct kfd_dev *dev;
> +
> +       dev = kfd_device_by_id(args->gpu_id);
>
> Once CRIU changes land, this need to change to
> kfd_process_device_data_by_id() and then use pdd->dev
>
The CRIU patches will apply on top of this patch. So the CRIU patches
have to adapt this code, just like other existing ioctl functions.

Regards,
  Felix


>  
>
>
> +       if (!dev)
> +               return -EINVAL;
> +
> +       args->available = amdgpu_amdkfd_get_available_memory(dev->adev);
> +       return 0;
> +}
> +
>  static int kfd_ioctl_set_memory_policy(struct file *filep,
>                                          struct kfd_process *p, void
> *data)
>  {
> @@ -1959,6 +1973,9 @@ static const struct amdkfd_ioctl_desc
> amdkfd_ioctls[] = {
>  
>          AMDKFD_IOCTL_DEF(AMDKFD_IOC_SET_XNACK_MODE,
>                          kfd_ioctl_set_xnack_mode, 0),
> +
> +       AMDKFD_IOCTL_DEF(AMDKFD_IOC_AVAILABLE_MEMORY,
> +                       kfd_ioctl_get_available_memory, 0),
>  };
>  
>  #define AMDKFD_CORE_IOCTL_COUNT ARRAY_SIZE(amdkfd_ioctls)
> diff --git a/include/uapi/linux/kfd_ioctl.h
> b/include/uapi/linux/kfd_ioctl.h
> index af96af174dc4..94a99add2432 100644
> --- a/include/uapi/linux/kfd_ioctl.h
> +++ b/include/uapi/linux/kfd_ioctl.h
> @@ -32,9 +32,10 @@
>   * - 1.4 - Indicate new SRAM EDC bit in device properties
>   * - 1.5 - Add SVM API
>   * - 1.6 - Query clear flags in SVM get_attr API
> + * - 1.7 - Add available_memory ioctl
>   */
>  #define KFD_IOCTL_MAJOR_VERSION 1
> -#define KFD_IOCTL_MINOR_VERSION 6
> +#define KFD_IOCTL_MINOR_VERSION 7
>  
>  struct kfd_ioctl_get_version_args {
>          __u32 major_version;    /* from KFD */
> @@ -98,6 +99,12 @@ struct kfd_ioctl_get_queue_wave_state_args {
>          __u32 pad;
>  };
>  
> +struct kfd_ioctl_get_available_memory_args {
> +       __u64 available;        /* from KFD */
> +       __u32 gpu_id;           /* to KFD */
> +       __u32 pad;
> +};
> +
>  /* For kfd_ioctl_set_memory_policy_args.default_policy and
> alternate_policy */
>  #define KFD_IOC_CACHE_POLICY_COHERENT 0
>  #define KFD_IOC_CACHE_POLICY_NONCOHERENT 1
> @@ -742,7 +749,10 @@ struct kfd_ioctl_set_xnack_mode_args {
>  #define AMDKFD_IOC_SET_XNACK_MODE               \
>                  AMDKFD_IOWR(0x21, struct kfd_ioctl_set_xnack_mode_args)
>  
> +#define AMDKFD_IOC_AVAILABLE_MEMORY            \
> +               AMDKFD_IOR(0x22, struct
> kfd_ioctl_get_available_memory_args)
> +
>  #define AMDKFD_COMMAND_START            0x01
> -#define AMDKFD_COMMAND_END             0x22
> +#define AMDKFD_COMMAND_END             0x23
>  
>  #endif
> -- 
> 2.34.1
>
