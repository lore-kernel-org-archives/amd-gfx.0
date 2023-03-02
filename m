Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CDD3C6FA8E
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Mar 2023 07:53:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F023310E0F6;
	Thu,  2 Mar 2023 07:53:40 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2080.outbound.protection.outlook.com [40.107.237.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 41C4E10E0F6
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 Mar 2023 07:53:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CtjtLsyrhTPzBgAfW5zM9Xpzjszw/5afvvqMwTUpsD8lurguW+8+7PmsRPDTODfNGlefIL8iNNMfBongsrZ4Txa0K8BIbX4ncXmxWLF60hRO3FZulCeFmijCjj84kGzzkJuBniaC6HTfe0Vk28j/v7w+pzE1S1PEB3bAJa80OO1wzrCX5FVpRU3rY0jWjO1mrt97BOi2ImbFqrnBMFfzW3ALtnHImAG2jgFmgmnn4YCtNiJRzgGmwQ+r5Y3vLQJEIcD6R8SCQTVqa9hjSKM0GiYkoj1caouI2nhC38VNx1ZcHyXaBcFSqIdsmDi8F6S9M8nrpo+oW/D481z6iQw4gQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2GQO7+ZeY6+udqjTCK8H6uOEmYWqRpSneSVjKrmDhb8=;
 b=Nyqvui6AwWTzixtjxYvaODHK2ImzdffiDudUb6hzWp/nCsv0PYuw69xH2onuX05Zt9NnZ0pjkSU4W62L7FQn4VlJl66nOfBIo0pefPU4b0ut0Ec/wRVcny6uPWCYAxZ9eX51A3jUgAPAMuFHLLKrcYElERjUbQ7ZdqJjV+QdenKKjyuElG7gj6vdAsmC2awR0NjING8HTWb6EcRRyCoJSIJ0yrv/KD6E2wucl3Uoa4udykEYU+yZcRWctHOJUwb7uRYVrj25OYE3p0pv5DA7oXBc49z54zRxUCyRH9FRbbap4h9fGqaa4IjEK1MWQ65hA6bLvf/AA7lgFAz/90bG2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2GQO7+ZeY6+udqjTCK8H6uOEmYWqRpSneSVjKrmDhb8=;
 b=z7cKQcoaAVxx3QtQu3Qp4LgGrWrfBPwTMKhbB/9adKOWP+2rOTpcueTxYypFGn0tLmPbnCLtgtK5WYP6+N2ITfSC/9ftWVBymfF6gJVttVpSfQgO2esAm1arpavA6BPsPMGzm3vU/ud58rUgVYgiLI6iWsemkY2xEjEoAEIKKuM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by CH0PR12MB5124.namprd12.prod.outlook.com (2603:10b6:610:bf::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.18; Thu, 2 Mar
 2023 07:53:37 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::d23f:bb1:df95:3918]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::d23f:bb1:df95:3918%4]) with mapi id 15.20.6134.030; Thu, 2 Mar 2023
 07:53:36 +0000
Message-ID: <6c8d863e-6f1a-66fe-0c33-c85505b3102e@amd.com>
Date: Thu, 2 Mar 2023 08:53:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v2] drm/amdgpu: Fix call trace warning and hang when
 removing amdgpu device
Content-Language: en-US
To: lyndonli <Lyndon.Li@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230302063243.11096-1-Lyndon.Li@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <20230302063243.11096-1-Lyndon.Li@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0102.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a9::18) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3587:EE_|CH0PR12MB5124:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b293f39-0c64-46cf-7049-08db1af33a7c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Fs/9pvNQvfvgwVWXl9IaFqfemj8ZEagiMk8kYJLAjsoZbQq0LpzxvT0bNgWYsZV/3k3aIByGOBo7WY3QxFdtqyMlSelQf2QgVtNMSrh583BEhNuksoMQkNqBEyVvxdxQcwyguQWJpVw2SilfQ2ltQQ3tgk6uesZ5XaqUXwENsPKzDXJhm8Usj/afqYaMdKGNbHDUEQtnuQ1okSOoRab28b9B4pRlrXjWdzHSlOHxwtCCX5fK35yQP8MHtkN8Xiitwq0ybtSfDzTMzwmNFM2V9mjAeGFmE5/zdn3Go6QOY2BeVxb5cPLwQbRbx7AVy+yodsz6JRWKzE2LYWCQJevOAjTdbU+ZhcUerIh7Dd+k/v8zX2t2ZpTxS2l1+/b6xJIMf8tk8dGbsvXUsOURPADeabQVt9tsGS30rxF8+20ByZ512f8tipnVMzLt/T/sjKo1d380oi2LO1Wy4wUktMKUtIn/PmHQfiuaJCX9zdQPe2+eqkJeAKMqzzQhfGz1bzQpmitgYn7KRxTIBX4SzAQllTaqrgfKf4UuR0HwMg9UfKyhbLJ9ltQ5qcLESgfQkrxHOhY1w1dCWjdguq3DRoquiw/5iHMuKYI41AzGF6w5VwmanTYCJu74mVtS/Xq52YpEIE/mYu4VAsS2UlWITBSPputZw24ol1Mj3VkmRwTvOB3pdrv8OubsEUSeJMsAmYBQLTgjVNLc3rAYg/Gp5MkTL5YkXyyQImS64HkpqsgKh7k=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(396003)(39860400002)(376002)(366004)(136003)(346002)(451199018)(38100700002)(31696002)(86362001)(36756003)(6666004)(41300700001)(66946007)(2906002)(66556008)(8936002)(66476007)(8676002)(4326008)(5660300002)(2616005)(6512007)(26005)(6506007)(186003)(66574015)(83380400001)(478600001)(316002)(31686004)(6486002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WC82dnpuMEE0ZjBUL1p2WEJaNHpjdlhrbW9vV1pLUlpuMWJ6VDMxSW1CQ2Rq?=
 =?utf-8?B?TEorek9LMjhoaDh5ekI3TVdSeHZHNGRVVHRpWTVLVzRRTUQyci9YdVlaQXo1?=
 =?utf-8?B?ZGphbDNabnNuaFdrSkZEUkRlMSt0TGhRQWYzc0UzNk04QXZVVHc4UUhLbDhV?=
 =?utf-8?B?VU9nOTNTamJZZGI4TEpwNjZEZkZnclNaWHBqZzBwaUtVc2M1UlVIcldFN2hn?=
 =?utf-8?B?ZHZNWTJDb2dCcks1alhhaTM1QnJocmRYSWkrRmk0cEVkN1J1T2swTXFNWHlQ?=
 =?utf-8?B?SVBOL1ZmNmhZVW1oTm1WRmtEZjFSL1ZDbWNSaW9nU1hqZFloMzRUam95ZVlB?=
 =?utf-8?B?MWx1ZlluSXVmYjY1ZHI3VzhXUnJTcFhRb09VaFRmMU9iZU5GSzNHNm1VOFJR?=
 =?utf-8?B?R2luV25ibTNldU8vRFZGSFVXLys5UmxXTGtScUdUc1YvZ2ttSy80WnMwMUFZ?=
 =?utf-8?B?cVgrWWNBdUowOG5oRFZiVi9kLytJYUNXZEdYMThpSm9wdWF4Um9tMTlzM0Qv?=
 =?utf-8?B?RWtMOG5jcUpJNWdjdXJzZG9mSE1OMWJuOGlkbkZHT3paaENkRmVHdUZXbnQ5?=
 =?utf-8?B?bGl5UjJTV01nYmdENEY2L0dDNlVsVTlZRkVycEZZOSt6NHMxb3d5RDhHb1Jn?=
 =?utf-8?B?V1FTdWFZOFhqaEsrSEQrN1AzWDhuQ1Z0RU1OSXByMGNKc1NpMUVsSUpMM2FJ?=
 =?utf-8?B?aU10bGdGNGlnNlNkd29vekk0SkpSUnZ3UkhQZDVVeDdCWlFRcXF2S292bjhw?=
 =?utf-8?B?ZmZRb3lPekt0OUVvUmEvUk84Q21BaUhHRzUyQXZpVldKYWszS1Ntb3BRZnl5?=
 =?utf-8?B?Y2U3WVkyUVhyNzhKL1hiOHVRWnE3bnVFdFNYYzQ0MXI0Tlc3VDBNSGpDRWtp?=
 =?utf-8?B?LzlJVEhoSEo5QnhyZmk0aGIzZnNuNFpUQVQ2ZkhiQXFJbVIwYm00WmpoY09G?=
 =?utf-8?B?LytLam9NWFZKSmVRQjQyWDRBZE1oUGRLaEpyaW5qK0JsU3l3bUd3YnhycTR6?=
 =?utf-8?B?djdnZjlLQ2YxUG1ldjdBN2ZwVC8xMVdad3gzOFk1TUUyb1M5SWRRY3cwQlVB?=
 =?utf-8?B?NFhYYTZBVmtPWW5ZQzMxMmJsN29MNVF5TlJVdnpNbjRMVVlWSC9qUUZTdkRZ?=
 =?utf-8?B?RFZXbG5kVHRlRHVXOFE1aG5pVk9GbjcyWHVVS2w0SHZpSUo2MGZITzNXSDFM?=
 =?utf-8?B?Q3ZpcnhPY3FuZXFyazhrditiWVR5OWZKdlJBdDYybGI4bEVWcVhIS1gxQ016?=
 =?utf-8?B?TmtKQ2ZXSzBaa2tJUkhSWTU4K1JWS2J0Y0lQWUkyaEwzVHdlNmxHTTdBZEZC?=
 =?utf-8?B?b2YvUCtqczB6VEFncXh2ZVFXMVZpaHJRaVZpRzZVeHhzZWs4cUorbUJDQ3NC?=
 =?utf-8?B?UDEvNXlRM0w4RkpDeGtRdHplMkFzM0tYdk04dkdWRFUwL2R0UEpFS2ZjcFRt?=
 =?utf-8?B?cFM4NXREL2JSYy9heWNXOEJ0YTIyWGhraWUxdHNtaWpCUSsyV3UydDZ0RzlL?=
 =?utf-8?B?MzlNZTRUdkhWT0dQS2NlSUZwaGlJbTdqZFJHUGtvVWZock9LTWcxRE1OOU0z?=
 =?utf-8?B?T0pFVXRQenlOVTZMa3ZtcjVZUE9SNHRYUnpIQ2swUHBzT3VSR1l0WjZ5dlZT?=
 =?utf-8?B?cy9YVkdoZ2Z2bElOTTVZbXpSOVRGZUVRS1pWM1V2dHlhMUxsYXBkSGRrUmxt?=
 =?utf-8?B?cW5UcGVkU3BkRmQ5bVJ5OUN6VlNxRENOSTdqSXlPQXJadWNETENKV2w5aTRa?=
 =?utf-8?B?YjlNeXZYSUN0RGdlVFJVMFBsTGhDcGZWY2FlaEN4ZW5MUS8vVVJESWhvQzRL?=
 =?utf-8?B?bm1pKzltQUpuUHo4K0djM0xQMmkvU2xpUVBZangxZ2xudXJnY3Vza3lVUy9M?=
 =?utf-8?B?SjVmUGZZSU42VzJCQ0pENzZiTVZXUjJybW1YdllFcUIyOHRTV3VycWl4R01r?=
 =?utf-8?B?bENBZlFTSFIrYk9lWjdwaDh4bGY4UkR4MzZocWoxT2dXbDRwRVdPRkFkWTVp?=
 =?utf-8?B?UVJUS29TVU5QOUFldTRBdmducnVxVHQ1L3hrOXUzQmppMEJWVk9iUXFXU1M3?=
 =?utf-8?B?SkR1Z0lYV3lOdmVCWEdMZktvN3A1UUlOTC9lemRUZkZUS1RmY3lXL01KaGFU?=
 =?utf-8?Q?IqyD+KP4rl1G/8/VJpkf/Hmf3?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b293f39-0c64-46cf-7049-08db1af33a7c
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2023 07:53:36.4915 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XyqllXpEhvcRthKwsj3ClOC4zwrlEeIY1AC4Dz3XNq2EQBVrC2UOQVgOGcOw8OeJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5124
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
Cc: feifei.xu@amd.com, YiPeng.Chai@amd.com, guchun.chen@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 02.03.23 um 07:32 schrieb lyndonli:
> On GPUs with RAS enabled, below call trace and hang are observed when
> shutting down device.
>
> v2: use DRM device unplugged flag instead of shutdown flag as the check to
> prevent memory wipe in shutdown stage.
>
> [ +0.000000] RIP: 0010:amdgpu_vram_mgr_fini+0x18d/0x1c0 [amdgpu]
> [ +0.000001] PKRU: 55555554
> [ +0.000001] Call Trace:
> [ +0.000001] <TASK>
> [ +0.000002] amdgpu_ttm_fini+0x140/0x1c0 [amdgpu]
> [ +0.000183] amdgpu_bo_fini+0x27/0xa0 [amdgpu]
> [ +0.000184] gmc_v11_0_sw_fini+0x2b/0x40 [amdgpu]
> [ +0.000163] amdgpu_device_fini_sw+0xb6/0x510 [amdgpu]
> [ +0.000152] amdgpu_driver_release_kms+0x16/0x30 [amdgpu]
> [ +0.000090] drm_dev_release+0x28/0x50 [drm]
> [ +0.000016] devm_drm_dev_init_release+0x38/0x60 [drm]
> [ +0.000011] devm_action_release+0x15/0x20
> [ +0.000003] release_nodes+0x40/0xc0
> [ +0.000001] devres_release_all+0x9e/0xe0
> [ +0.000001] device_unbind_cleanup+0x12/0x80
> [ +0.000003] device_release_driver_internal+0xff/0x160
> [ +0.000001] driver_detach+0x4a/0x90
> [ +0.000001] bus_remove_driver+0x6c/0xf0
> [ +0.000001] driver_unregister+0x31/0x50
> [ +0.000001] pci_unregister_driver+0x40/0x90
> [ +0.000003] amdgpu_exit+0x15/0x120 [amdgpu]
>
> Signed-off-by: lyndonli <Lyndon.Li@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> index 1c3e647400bd..5554ff22d724 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> @@ -1314,7 +1314,7 @@ void amdgpu_bo_release_notify(struct ttm_buffer_object *bo)
>   
>   	if (!bo->resource || bo->resource->mem_type != TTM_PL_VRAM ||
>   	    !(abo->flags & AMDGPU_GEM_CREATE_VRAM_WIPE_ON_RELEASE) ||
> -	    adev->in_suspend || adev->shutdown)
> +	    adev->in_suspend || drm_dev_is_unplugged(adev_to_drm(adev)))
>   		return;
>   
>   	if (WARN_ON_ONCE(!dma_resv_trylock(bo->base.resv)))

