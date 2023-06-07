Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21B53C7EE25
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Jun 2023 15:38:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 91E2410E09D;
	Wed,  7 Jun 2023 15:38:18 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 19B6D10E09D
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Jun 2023 15:38:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jlx5G8ezWKB5r68R9UzZHjHtmyRLTv01SLXdEl3xGw+gUtYcI4QkG5TnW7V9/qVOKalNqPtnxtCMJwcohEvxffZWdNYgapvYoDO76wFRFIDXnOLkyeNHGT+mxHq7+St7SpCLa3ghQonK2p2QsoUXaLYM/U+s++D6SDGf/hi3Uv7KilmFBGh1HoedtqUQByqf4jQCwmxP+iH3IJuqOquDTBKKAnTZ/b3q987RjiUiiA/oLLcuoEzsv7NmprznzjHUHG3Gie3RWoIFP8ZHO9jiECdMAHyLkNYavs/yYrJIOXkx2yA9q3SKvOQY/Pbc2y8u4wmaoolviKF+pjoIPKO7tA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5stO9wlcUH/LdpC6CyFCJ4SDC3qnZoLNwDLSrOxhIBk=;
 b=iOXg9fvirCmnrKs5pO3cJdZQz842aZTyWtT72csYUZ2Uy4QKNbSY58JQ5Z6pj//DpQryAa7jybX7Mld6tD9j3yg8WVM+GL+KHNzdxS8tSXCdpV7wx8xT8LZJPtvO1sSdGOaxFhpp6/e2dzRmCPKSMECKlkZWAZqDAN8MhPmhaAu3FDgWO0rUUuLbX7EcaT0yynsiYUewiLaUPiNyNBDsGFrUKt/Ri3ISWPIPi/jozEudt07I/OxsXd1UiLjMST4WCL4+WaJy2XBnJGDpWosf8zI6kepyF/9qgK8TM3/kaBSUNUKogPkv31dogSrfo76H0oCeGC2VwbqtQlDr6uT5XQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5stO9wlcUH/LdpC6CyFCJ4SDC3qnZoLNwDLSrOxhIBk=;
 b=Rplhti2inb067FpSPgDRznNVv4f4Vbl5ecZUg6vA+GnUj99EcJC71lFAgPKMTGGtc4E/Qd+Jlo13YYbieB+N94OF3GDp+6DK1k6PqvX96OTO4TaOeS/KYG8Qhmzzo8SE5NweD9G4IfFxNeDT758cRmvGBVYT9oV6GdPw1QpFCGg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by DM6PR12MB4912.namprd12.prod.outlook.com (2603:10b6:5:20b::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.38; Wed, 7 Jun
 2023 15:38:14 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::2dc3:c1:e72d:55bc]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::2dc3:c1:e72d:55bc%6]) with mapi id 15.20.6455.030; Wed, 7 Jun 2023
 15:38:14 +0000
Message-ID: <270445f7-ca79-784e-5060-e6e0b0782277@amd.com>
Date: Wed, 7 Jun 2023 11:38:11 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] drm/amdkfd: Fix reserved SDMA queues handling
Content-Language: en-US
To: Mukul Joshi <mukul.joshi@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230607152741.320428-1-mukul.joshi@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20230607152741.320428-1-mukul.joshi@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0032.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00::45) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|DM6PR12MB4912:EE_
X-MS-Office365-Filtering-Correlation-Id: 5edc25b2-5107-4134-52f9-08db676d34fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8SA52kkOqVdYcJ2KkFQckKoO0g7NW8cA3Wtvhh0xL6KTxKAmvQGyWfJYRsSFkigt2mXTNfj9cwgppkveRiM2vkTNR5uHN7RcVQ2OUOYnaH/rnMfiUZoN0INec6v4NSukByash+4hJCNN+B6LqtyjPQOXLP49iBBZu6T4rdevI9Hys0AfAGg6xtC2WthYkDqLS99zXqs1l1ooVlgjTMBymh8A6DUITZt4tLUG7BpyoP4BfVb3hqlVRBexvSBrugw4YkzltlWAwx5uIwsxcbRDZnkQnDdHWD5wfIU0XoAkABI88Q0hlbx9bISFTjRHvlXlniYs31cYuG1B05vaWHONP7CEeyHfys7YoJr9y7Yxov9emaYzOX3zw7XzHdevontbM//PTFgSEd/fsS8Bf4KE2cPgU6h07Wbmkj7Zyqyy3+LN6r2Xl5cbydJub7PL54nYfu4zH3US0qN0J6nFwIra5Xog/epE0PUynK4s5Zq9PRghiVbsK4ES+6QQ8FozBgOalIuuVYfmBG2uXsb0MvtMTBrrGLSNj1X7ZyS4IX3u6cGiL847RSbsF/Ha150IjxNEV9iC+AwnBHceTVfQQTNd4X/mwUMdyzKZFBLOQOcPkxQ5w5VqGifam17qsAkG6I+9c6dnNwZ0IbrBVU24cU+/Mw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(346002)(396003)(376002)(366004)(39860400002)(451199021)(36916002)(6486002)(6666004)(2906002)(66946007)(66556008)(66476007)(36756003)(38100700002)(5660300002)(44832011)(8936002)(8676002)(86362001)(31696002)(41300700001)(316002)(478600001)(2616005)(53546011)(6512007)(26005)(6506007)(31686004)(186003)(83380400001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UlJ3ZG1NWDBPaytHdloweUZTSFpGZWZ2VmE5Wlo4c3Q0cWxvZ1hJTkg3dXJX?=
 =?utf-8?B?S3NJM0RSaGlQZzJsMFV0SVhJS1oxdGZxb0hlT0dMRnVGNmtOeHRIaitibjU1?=
 =?utf-8?B?UmwwZFovMVZXZGdvWWg4NFVrbGt6cXJEZWcvanh6MXFaY21ZNzN3ZUY2MDF3?=
 =?utf-8?B?SnFqZDNLc3VxUFh3Z295S0U3VWxESjhhOWE5amZNUXJVQVd3SUVUbXlGNk1U?=
 =?utf-8?B?dTIwc1JVdi9OelVhQzBnYTU2UnlLTS9NRkNzQ2oxYmNpSmNMUGk3c1RLbjJJ?=
 =?utf-8?B?S2x2OXhrZ3VyMFBVZm45eUJ4NitoZzg2eExBaGxkWjFqK0N0cUpGZWhNTWp6?=
 =?utf-8?B?ZWlFaDdMOGY5S2premZVcUlYbUpBYVovMFdza0NkV0pnQVhVU1BvWm9nczk0?=
 =?utf-8?B?NXhwTmhpUnZPUGJQYXVsU1YrUnA2Z1BFMWRkUzRMNE9FT3BMMG1Vc3Z3K0F6?=
 =?utf-8?B?VWRqbTVjNUV3WUc5eE9xS1hvdFVSa0xRZG5sS3IxZldWeFlxcHUrYUcyQmNh?=
 =?utf-8?B?Y1pHQ094eVJwaUpYcFJKbFJBK3B1dlUyS1BRQmdUeEsrNnNISnBNcmxyWU5k?=
 =?utf-8?B?WnROY3kxVC9xbHJyM1F2a3dtekRKSkg2WUREeWNOSTllbjFoYStRSlRoTFVX?=
 =?utf-8?B?d1R4T1JtZmc4VVF4bDVzL1JsRnowZjkweHlPWGZxaVR5Z2FYeitvVXNreTNm?=
 =?utf-8?B?UUtvdzV6UlRLUDg3a2QyMVlFRWdhSWpTN1JEL2YwSVB3RGxZc1hQZGMwUWF2?=
 =?utf-8?B?NDZQZVBacUxWOGV1VmhHdnc3OXdBTmJxRW1FcjIwc1B3Y200c1FvTDJkbGRo?=
 =?utf-8?B?eUU2bXkweFJmVnk0eHBiekRTQU9TekFEZmpHZmxlSFBrTi94UmJ5ejhQSE90?=
 =?utf-8?B?SGo2MGRwalRqTUtHVnNrQjgxSDY3WWw5cTdtNkorekVZNE1sYWtjRnlZbjhi?=
 =?utf-8?B?Nm1Oa1NaamdINlVpaGJ5ekVrMW52bi83M21INWZBaEV4Yld6a0pMOTBWa0ln?=
 =?utf-8?B?MFVOeDNGSFNTTzZMbm1Ddjk4RS9ENVlpbTZVVzYzRjJGVktxcnE4dHgrRUJt?=
 =?utf-8?B?Y1IrRE91OEQvNzZVQ2tGUE5vUzVHcDhBKzIxMU1hZXp4aGNEOVdUVXFyeHhP?=
 =?utf-8?B?dUQwMmVKeXZ3WnNkaWdTeGNXK3lBWUZFSmtidHFnWXd2dUpGeEkwWDAveTVp?=
 =?utf-8?B?aHNkbWhwQVZOZnJPWWtPRHRsTFdCNHRrYXBGbmZ5U0NuVDdBUVNJWmQ4YW1G?=
 =?utf-8?B?NXRETHVVTDJTcktWM2ZmcXBkNVY2UU1ObXNWeVBDTnRZbUxTWlR5MXkxeE1o?=
 =?utf-8?B?bTVCcW9vS3JYZU1vVEF5V21qZWM1ZGVSQVdnUitLc2xTUGFmU1dJYk5WZ2pY?=
 =?utf-8?B?VGFjUjFoNis5MFVWeGJZY1FrbEdiVVgyb3IvTFdOZjBSOUlMNVB3QjVXc2Ur?=
 =?utf-8?B?aWx3L1k1OUVLSUt2a0VTU0tjcWNlOUdWM1J3Mm9kYTRFbGM3WDltZzFpd2pX?=
 =?utf-8?B?RlRQTUNGUDJ1ay8zTURRQkp0ZkFvT3FVR1FkUThoSXQ1dm96a3Blb0tUcy9I?=
 =?utf-8?B?MWNPcFEzbEF3WEdUT2RtM3ZoMmRJNnlIS2RZeG9EcEowa2tEOFBVMUlVNmVh?=
 =?utf-8?B?c2ZKNEdVOVdWUFBTUjVtT1RaSGFXeVB6cVNGNFpsOUtkUWt4WjZHblRhZHRU?=
 =?utf-8?B?Qy93b0pXZTNGdzdJOTl6dFZtcVh1a2RMM3JSWDEzVTFUYjJpaGdkUWNDWDVn?=
 =?utf-8?B?MTRKK2J5azhhVTk4bk1BVXE2TXlGU2JoeVlSTTNINDI2WkZ0aXhYd3dmSXVu?=
 =?utf-8?B?NzgrZTNhdDVXQTlhWUdHNUJDck94NFJrdit4aDRoTU5sWmJzRzRFOXVOK0dM?=
 =?utf-8?B?SVV4QUlhakJ0UjNxNjQwc24ySzAyQjRiZk5jT0hPODI2djlHU3o3T2hEVXQz?=
 =?utf-8?B?RU9XdUZBK3RKdWcySHRWd3MwVTRtWlFFanRnWVlwZVROWmNvUnpQbDBrVE9s?=
 =?utf-8?B?NFdYY2FYTy8wbVQvTEl3QnM3ekx0aGFzZHA2TU1PeVFaQnY0ZWVRVHVtclds?=
 =?utf-8?B?U1hycWlYSEhFRTVHdFpsM1lVSmJjZ0xHMk1kQ3RtRDBiRm83R0Q1NGgvQzBU?=
 =?utf-8?Q?gnZRQAcY/5D8fr/eRhdB33LGh?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5edc25b2-5107-4134-52f9-08db676d34fb
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2023 15:38:14.2235 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9uWWfTHGlyAyRuMPM1GodkeQPPZLhQ/K6o9tgN4aU8joTO5Pb6w5hG70o0gzfQMdLxpIpA69Cy+SBmLWfbWZLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4912
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


On 2023-06-07 11:27, Mukul Joshi wrote:
> This patch fixes a regression caused by a bad merge where
> the handling of reserved SDMA queues was accidentally removed.
> With the fix, the reserved SDMA queues are again correctly
> marked as unavailable for allocation.
>
> Fixes: c27842c84a848 ("drm/amdkfd: Update SDMA queue management for GFX9.4.3")
> Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_device.c             | 13 ++++++-------
>   .../gpu/drm/amd/amdkfd/kfd_device_queue_manager.c   | 10 +++++-----
>   drivers/gpu/drm/amd/amdkfd/kfd_priv.h               |  2 +-
>   3 files changed, 12 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> index 9fc9d32cb579..9d4abfd8b55e 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> @@ -106,20 +106,19 @@ static void kfd_device_info_set_sdma_info(struct kfd_dev *kfd)
>   		kfd->device_info.num_sdma_queues_per_engine = 8;
>   	}
>   
> +	bitmap_zero(kfd->device_info.reserved_sdma_queues_bitmap, KFD_MAX_SDMA_QUEUES);
> +
>   	switch (sdma_version) {
>   	case IP_VERSION(6, 0, 0):
> +	case IP_VERSION(6, 0, 1):
>   	case IP_VERSION(6, 0, 2):
>   	case IP_VERSION(6, 0, 3):
>   		/* Reserve 1 for paging and 1 for gfx */
>   		kfd->device_info.num_reserved_sdma_queues_per_engine = 2;
>   		/* BIT(0)=engine-0 queue-0; BIT(1)=engine-1 queue-0; BIT(2)=engine-0 queue-1; ... */
> -		kfd->device_info.reserved_sdma_queues_bitmap = 0xFULL;
> -		break;
> -	case IP_VERSION(6, 0, 1):
> -		/* Reserve 1 for paging and 1 for gfx */
> -		kfd->device_info.num_reserved_sdma_queues_per_engine = 2;
> -		/* BIT(0)=engine-0 queue-0; BIT(1)=engine-0 queue-1; ... */
> -		kfd->device_info.reserved_sdma_queues_bitmap = 0x3ULL;
> +		bitmap_set(kfd->device_info.reserved_sdma_queues_bitmap, 0,
> +			   kfd->adev->sdma.num_instances *
> +			   kfd->device_info.num_reserved_sdma_queues_per_engine);
>   		break;
>   	default:
>   		break;
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> index 0c1be91a87c6..498ad7d4e7d9 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> @@ -123,11 +123,6 @@ unsigned int get_num_xgmi_sdma_queues(struct device_queue_manager *dqm)
>   		dqm->dev->kfd->device_info.num_sdma_queues_per_engine;
>   }
>   
> -static inline uint64_t get_reserved_sdma_queues_bitmap(struct device_queue_manager *dqm)
> -{
> -	return dqm->dev->kfd->device_info.reserved_sdma_queues_bitmap;
> -}
> -
>   static void init_sdma_bitmaps(struct device_queue_manager *dqm)
>   {
>   	bitmap_zero(dqm->sdma_bitmap, KFD_MAX_SDMA_QUEUES);
> @@ -135,6 +130,11 @@ static void init_sdma_bitmaps(struct device_queue_manager *dqm)
>   
>   	bitmap_zero(dqm->xgmi_sdma_bitmap, KFD_MAX_SDMA_QUEUES);
>   	bitmap_set(dqm->xgmi_sdma_bitmap, 0, get_num_xgmi_sdma_queues(dqm));
> +
> +	/* Mask out the reserved queues */
> +	bitmap_andnot(dqm->sdma_bitmap, dqm->sdma_bitmap,
> +		      dqm->dev->kfd->device_info.reserved_sdma_queues_bitmap,
> +		      KFD_MAX_SDMA_QUEUES);
>   }
>   
>   void program_sh_mem_settings(struct device_queue_manager *dqm,
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> index 023b17e0116b..7364a5d77c6e 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> @@ -239,7 +239,7 @@ struct kfd_device_info {
>   	uint32_t no_atomic_fw_version;
>   	unsigned int num_sdma_queues_per_engine;
>   	unsigned int num_reserved_sdma_queues_per_engine;
> -	uint64_t reserved_sdma_queues_bitmap;
> +	DECLARE_BITMAP(reserved_sdma_queues_bitmap, KFD_MAX_SDMA_QUEUES);
>   };
>   
>   unsigned int kfd_get_num_sdma_engines(struct kfd_node *kdev);
