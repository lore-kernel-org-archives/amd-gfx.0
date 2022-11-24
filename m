Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A0F9C433FE
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Nov 2022 07:25:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6D13510E052;
	Thu, 24 Nov 2022 07:24:59 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2041.outbound.protection.outlook.com [40.107.244.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DE2C310E052
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Nov 2022 07:24:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SPUTa+IKjDaXrq9Ea/ZHDVNbBHCLVf+b3BeCBsDRQYv3qfA2Hu5ypJe0GFPmWhy9RrqPOObE+ianM5mR8jJcg1Vw7pa36Qp1RteDoXSrVGV+8erLgX2dpzyyXUtJBDBlKYRRtViN8PtQUW8dHAXhwuGf+dDJpx1mLSBU5D/t7oMQtOe0RwvoeLFmmcyvv8ZlVpy3CNMmqwDSTUw1nP8EJsfsNcUoQATwkLSDmbgHgBNEy1rT+zMjG+XRj77HCh/uH04yIrr/S9dGl/ncvSv9ZkNOD5D1TfciylVyq5QIDB7q0Tyijq1V5QIQzfhIyYSKSZIf0U7YAHdIGxYm/LumFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DVihGImj7m2pVgyNDpfA9ENXmzyO6ugdtMJJfPr4Wfc=;
 b=BY3p3ByPChGoeA+u7JxifDTKWI+DQF/d+WzVQ0oy82HZdZ62pzUoMevXDKZP+h20RiTDXgXzBdSzT2SodCMhtUhqHj7uUZy6Aoq8oShzsB2H6nWuhSXlbNh/VXCRozDKvL0xM+h3ceSd2Dm2Kl5WmVMbTHWBFDcv0555zaIUj8MwBTMpOxxp9YSGDoQj/9+QcPSi+2znEddCoQsjBDPqYMKTpWYSM8IBk6Bt3wlqOgHnNCQCBxju033K3TiIEVUhRLQ7MlhYKPxu3TTi/nb216FOe2CJlGAKavoHT4PMfPOcQvgOvvVu2GWyVuntYyv0B1iQIkMyHQ/A6/g/7H6u4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DVihGImj7m2pVgyNDpfA9ENXmzyO6ugdtMJJfPr4Wfc=;
 b=Cj/l8wErHtyTUWEgVOLCqvRzZC0sNGn5mpsxbrUlRGUApx4PwTLu//FscA7qmFIyZlmAyQz2L2P8Eg9EKijMYaR0lNDnAYZIrtUW0IkHPMIKiZz8KAKGFzKE+ZNN9DLve30NVL8cRk9KXaxaLQZrgcTCxwFk1puu/RRkgfKxGUs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by CH3PR12MB7547.namprd12.prod.outlook.com (2603:10b6:610:147::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.19; Thu, 24 Nov
 2022 07:24:52 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::7d43:3f30:4caf:7421]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::7d43:3f30:4caf:7421%7]) with mapi id 15.20.5857.019; Thu, 24 Nov 2022
 07:24:51 +0000
Message-ID: <7ad77cd9-6c35-1785-6f5a-31397d8432e7@amd.com>
Date: Thu, 24 Nov 2022 08:24:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] drm/amdgpu: add amdgpu vram usage information into
 amdgpu_vram_mm
Content-Language: en-US
To: Yang Wang <KevinYang.Wang@amd.com>, amd-gfx@lists.freedesktop.org,
 "Paneer Selvam, Arunpravin" <Arunpravin.PaneerSelvam@amd.com>
References: <20221124054945.3409867-1-KevinYang.Wang@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <20221124054945.3409867-1-KevinYang.Wang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0006.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a::16) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3587:EE_|CH3PR12MB7547:EE_
X-MS-Office365-Filtering-Correlation-Id: 50c2050a-a47e-4f1a-3db5-08dacdecfa07
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tMQiHbq82KzjPa7IENYkI1eqdEHoMg1Vapp8sr2LVWpE4G8JAoaIFrHGfPgTznfj/QRv+PEFNu4tQtIBeI9T5RPCSeJNLgeF3rrFaKx3AubOSc+9g9m+RNWufCIrXLl0FVt/G5Wc28AE4IiRFaq8lEv2q7rUQ9tytxVTARcrY5v93mlBfSq8ug1GkP+E2+VVAqkCJBfpj1m7nDLVEaXqWw7KJqFvpgYr2ZFZ7DtVUj+aF5TJi/5SUtNt+LjIajLQnDFwko5lE2TM8JctQdypG++OR6dvyJhfn5Is1Wbq4/nPw+8K8ml+oyRU16ULSRdCun3/ww7Mk5/H2wg21eGic1qmuxtHFUfkQvmctU24/X0jM/7iPtkIweXfnPdBPI9zU1v1XElYK5msCQ4BmmyqUgv0KsdNjOlprdn3C49xGm8tpig8bqRirqthTYtHWqZJ7bntrGW9rgLEBniINLV1QWsuLIyYijWsR8wNAp4GdlY4KUs+uvv4+zINQpJaHwiarXZizOmLhrotfph+0RkvpozZzFLXdKWY1fGDCLqnIC4ziC+BcC7LiSTLdvYSGF+adO77Luq8K2XgnAVYfSNB6yvugGfleaFtsv3xBHEjBbgNP0iaKWPanGBfWpPAPOtxrOevtsWwZ2cYuWLZUCA7A/S2Wy3jtuCnVEM9+d+Yz1Y8HINwvegPY1x0hE8MioQmsch8MmXigNkD0pQyyB13VSaepyIxSmMWHnjOalbQcIc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(346002)(39860400002)(366004)(376002)(136003)(451199015)(66476007)(4326008)(8676002)(66946007)(110136005)(6636002)(66556008)(31696002)(86362001)(41300700001)(5660300002)(30864003)(8936002)(6486002)(316002)(31686004)(36756003)(83380400001)(38100700002)(2906002)(478600001)(186003)(2616005)(6506007)(26005)(6666004)(6512007)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NjQ0cEdMZWpIUEg5VHRNZ0RJOGdPbnkrNjlxV0ZEVW5UaDFDWlhQY2NSQ0xt?=
 =?utf-8?B?QWluTDNxbXRXQ1hCUFYraVVtbkhUNWlQVC9qTXpPbFZXM3hqblA2L1UydXBB?=
 =?utf-8?B?YXdSUHQycldUOHByWko2WDdacjhDQlJ6VmRMSGFTWktqeGtmQ0lmeGhHSmZ2?=
 =?utf-8?B?Rmx2M09KM2lONFFsV3djYm1nRGhuaUxzNmNWMFVYV2ZodUdsbVI3M0pXclZ2?=
 =?utf-8?B?UGpYREwxVnhYTGNiejFTN09TOUcvZFh4d21FY0lzaTdWUmptenJ5am4wRHZU?=
 =?utf-8?B?V2ZtczVYdHJlVi9xSFZiVnUwRDRKdlBCSjBiaTB3NEJsSG1jSmJGYnpsN3BM?=
 =?utf-8?B?bnJLelk3U0tEVDNPZDdoMnMwV05Jc2lPVVhNbmFWdlhBUVdBQkVTVDZaNkxG?=
 =?utf-8?B?eFZXdHgwRmFZb2FoS3cxeHlSTFBjeHVBMFRnRlhVZGZBclcyK3pwdzMxL0hk?=
 =?utf-8?B?ZndHUTJNVVIrT3MyajFjdnhqUVBsL0lkMVBqamNraXdJa2tOS0M4S1ZyM1RI?=
 =?utf-8?B?UXhBSDBkMEw3N3VnVytGM1FvR1pMdU5oZUMzRVlOc0ZIQzNpRVNmQ3JzOWE4?=
 =?utf-8?B?NXYvb0QxcFNyVVJTb3QxUzhXQVdPRm5Cdm9DVk13K2l4ZkxnNW9BZTU1L3RP?=
 =?utf-8?B?YlY1SFhsWFpBSG4wb2ptNWtvTGlJSHlENGxCMWl5a2lmNVp1NWJRNjVON083?=
 =?utf-8?B?Umc2cDcxV3A1dlBsRWRvcDhlaURibVNLSk9CV0tSdzkxc04xVkFabHRqN2hK?=
 =?utf-8?B?bDFpNGkxcU9GUGpLcEl5RXgvQ2VEVWdaS1BvNFZYMytrUDZ2eUNwanRseExr?=
 =?utf-8?B?em9wUFFCWkR2ekd5UmZ3VzE4MlJxUzE1RmMxV2FBTHFJakRISTI0MVRvUCs0?=
 =?utf-8?B?TklxUVNSaXZmTWw0T1RZMnRvSTlRNU5kL29tUklEM3JrYi9tck8xeXBzZUpD?=
 =?utf-8?B?SDB3d0Q4Sitha0lXQ1NxTXFxMi9RZ1MzdTJRaWE0ZldVZlExSHRpcjZCaDdT?=
 =?utf-8?B?QktRMWJFRzMvdm5jVmpxY0RVSzRaUW1TdlZlbUhER1h1d1dUdVI4ekNrTTBU?=
 =?utf-8?B?M1JndTY5SEJ5R3hoNXFlMVlsditlcTZIZUFnb0p4Sy9zMDhKRzJaZlA2TDlk?=
 =?utf-8?B?VjhWdU5FQmwxMEh5SUxrZUhVM1dWamI2bDJRNnFVcHFzV093QVFYVXo0V0dZ?=
 =?utf-8?B?VFZNM2syRzhBV3RURGNkNkRibS9WVlpicTUrNEZFQlpvb1NxQVRTOVRvbDZy?=
 =?utf-8?B?ZGxoZmZWb0ZrdHY3MytsRWl3YzFGbk9VdGlydXFIZWpBT2l5K2JtUmJkTmFF?=
 =?utf-8?B?QlVUVkZoMlZwWVFjN2RYYW1nTy9ReGg0cUdQd1hZbU9BSEpWUGNKZ1NBRXNt?=
 =?utf-8?B?SUFvZW94OEg5c0lJaHp3VDNRM1ZFK3o3ZURkQXhobTU1TzlDWTN0K3FYU1FM?=
 =?utf-8?B?TXVBWWw3VVJWWEpkenUyYUVmSlU4ZDYvOFo3anY3RHdoNFM5dTJJTzhPOEZh?=
 =?utf-8?B?OWYvcXB2Y0FzTkdlVzlMNmsxVkJBSklXSFVSUFZ2Mk92NWFNaE5ObTZQUzMx?=
 =?utf-8?B?MUpUTUo5Ukp4WDlCdTZ0NXM2T1N5Q0pCcnN1OStDb1c4Tld6MjFKYjAzbXFX?=
 =?utf-8?B?Qy8xbWM0ZHZUbTVUSzB6Lyt4YXJKaTM5WnJsM1FqTi9saEFlWlYxZVFYd1hz?=
 =?utf-8?B?akM4VXB1dGRvKzA1My9zVkRpbHNZakpUTVJEVmxFNXd1OWFPOTI1YUszeGR6?=
 =?utf-8?B?b242NVI2RUF1cUxFMzc3ME0rQW84REFmMzg0dUFZVE4yeWtQNzB4KzFqZWd6?=
 =?utf-8?B?aEpzMFQzZDRsQlR1L2dDR2ZWM0lPeFdnZHFqTDA4RHRVK1UzNStYaGxkdlF6?=
 =?utf-8?B?c1FLNndiclJ3bVM5MmJZeUNhVTF4ZlM3NFFiU1J3a1JxWG11L0wxRWMxRHB3?=
 =?utf-8?B?ZElPWUM5SjJuWUZoQUp3NXZ4T0w5eTZBMGV6eXFYRnN4S2lPZUdKQTRwODRt?=
 =?utf-8?B?QWZqUEU3cEwraWs0YkpnVTlsckZZcUV2YmU0SlBXNnlSVmlsNGZZdFEyVGR2?=
 =?utf-8?B?SVFUOTAwZ0haemtTV1BnSjVYN2N6SG55U3hTaDVOMjZ1ZGVMdTFyUmhReVk2?=
 =?utf-8?Q?ZH0bG4lgC45W2TaZOhFOZOyFY?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50c2050a-a47e-4f1a-3db5-08dacdecfa07
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2022 07:24:51.8194 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SRJzAElDWQ6EAsKMRXBHvxOy8qiKsJMyUcYrtJrLpyMRSFllXPM/ZkJzqi9TxsxP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7547
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
Cc: alexander.deucher@amd.com, Hawking.zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 24.11.22 um 06:49 schrieb Yang Wang:
> add vram usage information into dri debugfs amdgpu_vram_mm node.
>
> Background:
> when amdgpu driver introduces drm buddy allocator, the kernel driver
> (and developer) is difficult to track the vram usage information.
>
> Field:
> 0xaaaaaaaa-0xbbbbbbbb: vram usaged range.
> type: kernel, device, sg
> usage: normal, vm, user
> domain: C-CPU, G-GTT, V-VRAM, P-PRIV
> @xxxxx: the address of "amdgpu_bo" object in kernel space.
> 4096: vram range range.
>
> Example:
> 0x00000003fea68000-0x00000003fea68fff: (type:kernel usage:vm       domain:--V- --V-) @000000001d33dfee 4096 bytes
> 0x00000003fea69000-0x00000003fea69fff: (type:kernel usage:vm       domain:--V- --V-) @00000000a79155b5 4096 bytes
> 0x00000003fea6b000-0x00000003fea6bfff: (type:kernel usage:vm       domain:--V- --V-) @0000000038ad633b 4096 bytes
> 0x00000003fea6c000-0x00000003fea6cfff: (type:device usage:user     domain:--V- --V-) @00000000e302f90b 4096 bytes
> 0x00000003fea6d000-0x00000003fea6dfff: (type:device usage:user     domain:--V- --V-) @00000000e664c172 4096 bytes
> 0x00000003fea6e000-0x00000003fea6efff: (type:kernel usage:vm       domain:--V- --V-) @000000004528cb2f 4096 bytes
> 0x00000003fea6f000-0x00000003fea6ffff: (type:kernel usage:vm       domain:--V- --V-) @00000000a446bdbf 4096 bytes
> 0x00000003fea70000-0x00000003fea7ffff: (type:device usage:user     domain:--V- --V-) @0000000078fae42f 65536 bytes
> 0x00000003fead8000-0x00000003feadbfff: (type:kernel usage:normal   domain:--V- --V-) @000000001327b7ff 16384 bytes
> 0x00000003feadc000-0x00000003feadcfff: (type:kernel usage:normal   domain:--V- --V-) @000000001327b7ff 4096 bytes
> 0x00000003feadd000-0x00000003feaddfff: (type:kernel usage:normal   domain:--V- --V-) @00000000b9706fc1 4096 bytes
> 0x00000003feade000-0x00000003feadefff: (type:kernel usage:vm       domain:--V- --V-) @0000000071a25571 4096 bytes
>
> Note:
> although some vram ranges can be merged in the example above,
> but this can reflect the actual distribution of drm buddy allocator.

Well completely NAK. This is way to much complexity for simple debugging.

Question is what are your requirements here? E.g. what information do 
you want and why doesn't the buddy allocator already expose this?

Regards,
Christian.

>
> Signed-off-by: Yang Wang <KevinYang.Wang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_object.c   |   6 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_object.h   |   3 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c | 130 ++++++++++++++++++-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.h |   1 +
>   4 files changed, 136 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> index 90eb07106609..117c754409b3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> @@ -53,7 +53,7 @@
>    *
>    */
>   
> -static void amdgpu_bo_destroy(struct ttm_buffer_object *tbo)
> +void amdgpu_bo_destroy(struct ttm_buffer_object *tbo)
>   {
>   	struct amdgpu_bo *bo = ttm_to_amdgpu_bo(tbo);
>   
> @@ -66,7 +66,7 @@ static void amdgpu_bo_destroy(struct ttm_buffer_object *tbo)
>   	kvfree(bo);
>   }
>   
> -static void amdgpu_bo_user_destroy(struct ttm_buffer_object *tbo)
> +void amdgpu_bo_user_destroy(struct ttm_buffer_object *tbo)
>   {
>   	struct amdgpu_bo *bo = ttm_to_amdgpu_bo(tbo);
>   	struct amdgpu_bo_user *ubo;
> @@ -76,7 +76,7 @@ static void amdgpu_bo_user_destroy(struct ttm_buffer_object *tbo)
>   	amdgpu_bo_destroy(tbo);
>   }
>   
> -static void amdgpu_bo_vm_destroy(struct ttm_buffer_object *tbo)
> +void amdgpu_bo_vm_destroy(struct ttm_buffer_object *tbo)
>   {
>   	struct amdgpu_device *adev = amdgpu_ttm_adev(tbo->bdev);
>   	struct amdgpu_bo *bo = ttm_to_amdgpu_bo(tbo);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
> index 147b79c10cbb..3f6a687309a7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
> @@ -332,6 +332,9 @@ int amdgpu_bo_restore_shadow(struct amdgpu_bo *shadow,
>   			     struct dma_fence **fence);
>   uint32_t amdgpu_bo_get_preferred_domain(struct amdgpu_device *adev,
>   					    uint32_t domain);
> +void amdgpu_bo_destroy(struct ttm_buffer_object *tbo);
> +void amdgpu_bo_user_destroy(struct ttm_buffer_object *tbo);
> +void amdgpu_bo_vm_destroy(struct ttm_buffer_object *tbo);
>   
>   /*
>    * sub allocation
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
> index 27159f1d112e..165f4f1a8141 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
> @@ -23,9 +23,11 @@
>    */
>   
>   #include <linux/dma-mapping.h>
> +#include <linux/interval_tree_generic.h>
>   #include <drm/ttm/ttm_range_manager.h>
>   
>   #include "amdgpu.h"
> +#include "amdgpu_object.h"
>   #include "amdgpu_vm.h"
>   #include "amdgpu_res_cursor.h"
>   #include "amdgpu_atomfirmware.h"
> @@ -38,6 +40,122 @@ struct amdgpu_vram_reservation {
>   	struct list_head blocks;
>   };
>   
> +struct amdgpu_vram_node {
> +	struct rb_node node;
> +	u64 start;
> +	u64 last;
> +	u64 __subtree_last;
> +	struct ttm_buffer_object *tbo;
> +};
> +
> +#define START(node) ((node)->start)
> +#define LAST(node) ((node)->last)
> +
> +INTERVAL_TREE_DEFINE(struct amdgpu_vram_node, node, u64, __subtree_last,
> +		     START, LAST, static, amdgpu_vram_it)
> +
> +#undef START
> +#undef LAST
> +
> +#define for_each_vram_mm_node(node, mgr) \
> +	for (node = amdgpu_vram_it_iter_first(&(mgr)->root, 0, U64_MAX); node; \
> +	     node = amdgpu_vram_it_iter_next(node, 0, U64_MAX))
> +
> +static void amdgpu_vram_mm_add_block(struct drm_buddy_block *block, struct amdgpu_vram_mgr *mgr, struct ttm_buffer_object *tbo)
> +{
> +	struct amdgpu_vram_node *node;
> +
> +	node = kvzalloc(sizeof(*node), GFP_KERNEL);
> +	if (!node)
> +		return;
> +
> +	node->start = amdgpu_vram_mgr_block_start(block);
> +	node->last = node->start + amdgpu_vram_mgr_block_size(block) - 1;
> +	node->tbo = tbo;
> +
> +	amdgpu_vram_it_insert(node, &mgr->root);
> +}
> +
> +static void amdgpu_vram_mm_remove_block(struct drm_buddy_block *block, struct amdgpu_vram_mgr *mgr)
> +{
> +	struct amdgpu_vram_node *node;
> +	u64 start, last;
> +
> +	start = amdgpu_vram_mgr_block_start(block);
> +	last = start + amdgpu_vram_mgr_block_size(block) - 1;
> +
> +	node = amdgpu_vram_it_iter_first(&mgr->root, start, last);
> +	if (node) {
> +		amdgpu_vram_it_remove(node, &mgr->root);
> +		kvfree(node);
> +	}
> +}
> +
> +static inline const char* ttm_bo_type2str(enum ttm_bo_type type)
> +{
> +	switch (type) {
> +	case ttm_bo_type_kernel:
> +		return "kernel";
> +	case ttm_bo_type_device:
> +		return "device";
> +	case ttm_bo_type_sg:
> +		return "sg";
> +	default:
> +		return "unknow";
> +	}
> +}
> +
> +static inline const char* amdgpu_vram_domain_str(u32 domain, char *tmp)
> +{
> +	int index = 0;
> +
> +	tmp[index++] = domain & AMDGPU_GEM_DOMAIN_CPU ? 'C' : '-';
> +	tmp[index++] = domain & AMDGPU_GEM_DOMAIN_GTT ? 'G' : '-';
> +	tmp[index++] = domain & AMDGPU_GEM_DOMAIN_VRAM ? 'V' : '-';
> +	tmp[index++] = domain & (AMDGPU_GEM_DOMAIN_GDS | AMDGPU_GEM_DOMAIN_GWS | AMDGPU_GEM_DOMAIN_OA) ?
> +		'P' : '-';
> +	tmp[index++] = '\0';
> +
> +	return tmp;
> +}
> +
> +static inline const char* amdgpu_vram_bo_usage(struct ttm_buffer_object *tbo)
> +{
> +	if (tbo->destroy == &amdgpu_bo_destroy)
> +		return "normal";
> +	else if (tbo->destroy == &amdgpu_bo_user_destroy)
> +		return "user";
> +	else if (tbo->destroy == &amdgpu_bo_vm_destroy)
> +		return "vm";
> +	else
> +		return "unknow";
> +}
> +
> +static void amdgpu_vram_mm_debug(struct amdgpu_vram_mgr *mgr, struct drm_printer *p)
> +{
> +	struct amdgpu_vram_node *node;
> +	struct ttm_buffer_object *tbo;
> +	struct amdgpu_bo *abo;
> +	char tmp[5];
> +
> +	for_each_vram_mm_node(node, mgr) {
> +		tbo = node->tbo;
> +		abo = ttm_to_amdgpu_bo(tbo);
> +		drm_printf(p, "%#018llx-%#018llx:", node->start, node->last);
> +		if (abo)
> +			drm_printf(p, " (type:%-5s usage:%-8s domain:%s %s) @%p",
> +				   ttm_bo_type2str(tbo->type),
> +				   amdgpu_vram_bo_usage(tbo),
> +				   amdgpu_vram_domain_str(abo->preferred_domains, tmp),
> +				   amdgpu_vram_domain_str(abo->allowed_domains, tmp),
> +				   abo);
> +		else
> +			drm_printf(p, " (reserved)");
> +		drm_printf(p, " %llu bytes\n",
> +			   node->last - node->start + 1);
> +	}
> +}
> +
>   static inline struct amdgpu_vram_mgr *
>   to_vram_mgr(struct ttm_resource_manager *man)
>   {
> @@ -288,6 +406,7 @@ static void amdgpu_vram_mgr_do_reserve(struct ttm_resource_manager *man)
>   		dev_dbg(adev->dev, "Reservation 0x%llx - %lld, Succeeded\n",
>   			rsv->start, rsv->size);
>   
> +		amdgpu_vram_mm_add_block(block, mgr, NULL);
>   		vis_usage = amdgpu_vram_mgr_vis_size(adev, block);
>   		atomic64_add(vis_usage, &mgr->vis_usage);
>   		spin_lock(&man->bdev->lru_lock);
> @@ -540,6 +659,8 @@ static int amdgpu_vram_mgr_new(struct ttm_resource_manager *man,
>   		vres->base.start = max(vres->base.start, start);
>   
>   		vis_usage += amdgpu_vram_mgr_vis_size(adev, block);
> +
> +		amdgpu_vram_mm_add_block(block, mgr, tbo);
>   	}
>   
>   	if (amdgpu_is_vram_mgr_blocks_contiguous(&vres->blocks))
> @@ -583,8 +704,10 @@ static void amdgpu_vram_mgr_del(struct ttm_resource_manager *man,
>   	uint64_t vis_usage = 0;
>   
>   	mutex_lock(&mgr->lock);
> -	list_for_each_entry(block, &vres->blocks, link)
> +	list_for_each_entry(block, &vres->blocks, link) {
>   		vis_usage += amdgpu_vram_mgr_vis_size(adev, block);
> +		amdgpu_vram_mm_remove_block(block, mgr);
> +	}
>   
>   	amdgpu_vram_mgr_do_reserve(man);
>   
> @@ -747,6 +870,9 @@ static void amdgpu_vram_mgr_debug(struct ttm_resource_manager *man,
>   	drm_printf(printer, "reserved:\n");
>   	list_for_each_entry(block, &mgr->reserved_pages, link)
>   		drm_buddy_block_print(mm, block, printer);
> +	drm_printf(printer, "vram usage:\n");
> +	amdgpu_vram_mm_debug(mgr, printer);
> +
>   	mutex_unlock(&mgr->lock);
>   }
>   
> @@ -769,6 +895,8 @@ int amdgpu_vram_mgr_init(struct amdgpu_device *adev)
>   	struct ttm_resource_manager *man = &mgr->manager;
>   	int err;
>   
> +	mgr->root = RB_ROOT_CACHED;
> +
>   	ttm_resource_manager_init(man, &adev->mman.bdev,
>   				  adev->gmc.real_vram_size);
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.h
> index 0e04e42cf809..a14c56e1e407 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.h
> @@ -28,6 +28,7 @@
>   
>   struct amdgpu_vram_mgr {
>   	struct ttm_resource_manager manager;
> +	struct rb_root_cached root;
>   	struct drm_buddy mm;
>   	/* protects access to buffer objects */
>   	struct mutex lock;

