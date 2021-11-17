Return-Path: <SRS0=qNnc=QE=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 753B4C433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Nov 2021 22:46:06 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2AFB661AFB
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Nov 2021 22:46:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 2AFB661AFB
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C8C8A6E037;
	Wed, 17 Nov 2021 22:46:05 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2087.outbound.protection.outlook.com [40.107.212.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AD5FC6E037
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Nov 2021 22:46:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fonV2qlB85YM8aQwcr0Wt/8XyT9ol3VztMIxsqvAKyYmePcx3SdsQuX2k95MEoX1aIdvJ71mBpIXkHU6ktzFBcg9pCKfDagQrE8Tzp3zu4zOiECurLMJc3rj9txwQMQrTFzr+x1KdYdbyvMBCjLmxiq0T3Hb7NqSr8kiWo+JrSiTy/0EZv8ecJKYXBIyQL+1ngXz/v8GcjM+a8g5e6yVg4l4EkRdezF+rFz0XCgr90yly2qw1Z5/c6Sasyu2K7RgMm2GDGIqy8A9lIJgQ2UbZXV2DJlf7L2kTsEMlb/I5XKDaefPMaXg3MpjunNYhQhq/nX4VpeQyehnxYJ+MKBKcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OX+4+FBkD/bOVc3er8w0n19VwVM8iGKbqEwPQO13Nao=;
 b=G3e0jB1aiJ87lcfRkcoS75T5IW9E+7qt/tGBKpE6G3NDWGE4ES7bObpv7YNNTNPK4VbA04nsg8lvHNSUk0jqwK3xNicnFaHDkOYZveG2/mR1IjqLZFwGAZ6wrJ3np3ES93p22X0vzRta97IETyI4dpGeHpzkdE6Ije2iv8LDs3VqsIw0pPa+HaObh6ULtCKTqE6so3rZbDDgF90Iny6209uHo7BxE6p2vwRcVvmeu3pDePZcK2cdq00eNB1c1doJ3lvJar/rd/H5jeQr9bpP0yyrjY55b+5AyaiYIgfxP6CpdyWTGp1PkHLUa58HPbGBOSRfFtyIvTlktsFj18L+lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OX+4+FBkD/bOVc3er8w0n19VwVM8iGKbqEwPQO13Nao=;
 b=q0ohXQJwvCtE83F2oTUOrlgTvDlK1IWY8u0TqjUoAKuv4l+mFlSLdlxTatxfDBOTXEL2oHeM/FQTyKA5jwzTYlxiGPi8RScuyrZGTpewAk6eoYZRxP+hvkvMsWMWDYYJgLXnT5p31pVgCKpA47fHKwiI3oj4eAgal1weuVqBWnA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19; Wed, 17 Nov
 2021 22:46:02 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9dfe:ccc6:102c:5300]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9dfe:ccc6:102c:5300%8]) with mapi id 15.20.4713.021; Wed, 17 Nov 2021
 22:46:02 +0000
Subject: Re: [PATCH] drm/amdkfd: Retrieve SDMA numbers from amdgpu
To: Amber Lin <Amber.Lin@amd.com>, amd-gfx@lists.freedesktop.org
References: <20211117203648.26521-1-Amber.Lin@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
Message-ID: <1113aaa9-1d8c-e64b-b489-fdcfd35047e7@amd.com>
Date: Wed, 17 Nov 2021 17:46:00 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <20211117203648.26521-1-Amber.Lin@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: MN2PR04CA0020.namprd04.prod.outlook.com
 (2603:10b6:208:d4::33) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
Received: from [172.27.226.80] (165.204.55.251) by
 MN2PR04CA0020.namprd04.prod.outlook.com (2603:10b6:208:d4::33) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4713.21 via Frontend Transport; Wed, 17 Nov 2021 22:46:02 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ffea8e8c-7e66-4cc5-a49c-08d9aa1c0858
X-MS-TrafficTypeDiagnostic: BN9PR12MB5257:
X-Microsoft-Antispam-PRVS: <BN9PR12MB52570895D420510AF8145B19929A9@BN9PR12MB5257.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LTRT/xl/dfJujSVOgfxJRqz8yyim5QBJQCEsOExZEPOOEYWWVZl4jqvsG+Kfauw+L7zLlsGqgGLG3Zp6Ty0KciVfXft2jmkGO1bbjzB8fqgUQjNHJRN2j53KOhASV+rtvVQKf4cCu4SOa2RzPO2DMeEZNOrkEAuItbisya3+zynJQdhC9+iUpItPYHEdrIei3fiodbJM96kcTw+rQMHNiQnRldPRntUUzFalCqXbfoCck3uBtJ4YC1FiSaB6VQpsUrSnxiogzQd8nVv7fCLtoLR8LxVS8jYYbEGBZ8CsTY19oU4SC5wvYLsqAE4G9CpNiHOQhvKrWb5hPd+aslejzJx/gX1HQu/8ZQcPbTio2GpoZKtg7VQQQBEMWD9QOmhcn4Ndb+wgae2GjeMGuIQ3/6CjHFWoG3Yc5yrmOcicTW5bx5SLBMR5YPaOEL9y0/q1sLuWGR9NbiGv90pIvrmzB3WgOpyYzVscyNSkPlnqO4nw8viQMjuGy+FcmEv/5xQ1magt3l2uDzCDGTCsA0NNx2EjWC6a+WWqmzWwF6DSnJABw+pPq19nZ8FCd+FnIzcvFDAqRaSIq2M+DoVb633o2+ezJHMhrg1Vi0NOEJorYu/pkK6yQEMWLJaRpfHfqliOB/uaCOY16lDQnrmBiPDlky/FsDNEY6bgERmrBBSt+kzaVGNlOLls0nAPTBJNDLEACFAa72Q5tqZ+b7WlDzofr+KP7mWd2CnR5nJNzaddXP8+ZbEY/mJ65NWGwmlLIeT6
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(8676002)(2906002)(8936002)(31686004)(186003)(53546011)(66946007)(66476007)(31696002)(26005)(36916002)(66556008)(44832011)(6486002)(36756003)(2616005)(38100700002)(4001150100001)(86362001)(83380400001)(16576012)(5660300002)(508600001)(316002)(956004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aWg1MlpJNjFEdVEvZFkyc0RMUlQrQnJQYVRFVWR5SmF4SldVL0ZYN3lUUFEx?=
 =?utf-8?B?dFpkVVczbFF6bTZMd1VGMTlycUJzOTY0cmdyazNRSlNueS84WkQ4ZGt5TEw0?=
 =?utf-8?B?dXhrYzdOR2Q2bmZSRmozd0E5VXVyZTdqaFk5RE1UT1JlWFJPU1V0Sk9vZlJE?=
 =?utf-8?B?WXQ0Ti9vYzhZQk9lWUo3cEM3T3p1Tm10eGF0OGhERTdOZ0hlWUdGMDRCSnQv?=
 =?utf-8?B?ZUZWQnIyRkRwTExxNHZYNXJyOFFSeGs4Q2JsczNCTGppQWZaT3BzeE9HZ2F5?=
 =?utf-8?B?RVNlTWluVHcxYUlaUThpZitoVUU1dXJLQ2liSjRURHRYd1hia1hXTXh3Ry9V?=
 =?utf-8?B?SXpkQ1lBdm5jRk1MeVlZNVJpV1VCcVMzVTNMcGlndWVRVGduY0MrZ0FkTEZR?=
 =?utf-8?B?aEJ5ZnNMcjhzeUk4Q0hFWHBRM01UR0grZTRkR2JZa2pKM1NpZzB1YWdMUXBt?=
 =?utf-8?B?Y2NXL0hMczZKYnFJL0xFVEZBbE5kVkhyR3hzR3Q4djFLSjVlbnZSSG5UUXVv?=
 =?utf-8?B?YUR4R3VCUjlRREFGQUJselZTVFIrZTlmYjA0YXZGUTUva0U2dFFkYllsN3k1?=
 =?utf-8?B?SnUxeFhRcUpLUlZsc1BGSG9oNDJlYktoRExkS1dXeld0Sk1BV3VuRktxMkUw?=
 =?utf-8?B?STBjYzl1emh6cUp1aWN0bktTdzFLelhQRTVnM2ptZ1pYM284ZUZMNzBEMW5q?=
 =?utf-8?B?SDJMWGQza0Y2NnA0MVJUUlkveDJKSnJHRzhOMlowOGR2L2dGYTE0OUVLR3c0?=
 =?utf-8?B?c092cnZ1NmpXZmpiK29YWUM4SVJxL08rZFF2MUt1WVRHNS8wY2tFNWVsL2t0?=
 =?utf-8?B?UGtqbHBCcmRTVTB0aFFxNGRJMEVFc1FOQ1F0VVVWMWttb2JhcnhyeXNzb0VN?=
 =?utf-8?B?d2N4ZWFtaEtQUUdyMDQwMEVzTDVHcEtaQzhRcndsWndVYVJlNElUQURsczVE?=
 =?utf-8?B?d0FXUzNoRk40QkRKS2dieTNwd0ErcWtuZzBzUllMWWJucHp0K2RpTGQyYXdX?=
 =?utf-8?B?ZWRVSFhUaFJkRWVZaGtFT1VFb0dybXBBNWNHMC85Qi9vQTdLRmJPM3d6NnFC?=
 =?utf-8?B?VTJhcU8xeGRvRlBHV1VmN3JhRU5hOTYxNSsxNURpdlI0cSsvSjUrdnNYUDBD?=
 =?utf-8?B?ZFVLTXhtNk5MYzRkUkZINlFnNnkwUjRZZFRQY0Uyd01pSGZJVjFEcTV5aWZr?=
 =?utf-8?B?OW9xQ0N4Q2Rrd1FlNDFjbWJuY1hwWFlQQkh4QmRnS1FtSUVWS0hBSC9TOUE2?=
 =?utf-8?B?U1NuOC9QOXozL0Y2cEF4enEwZXF5Z3dnVVZDQ2FqNVhsY004d0d4YkdRMkhR?=
 =?utf-8?B?Z0luWjArc1ZaTExZYlZIclZhM0YyY1NkWjYwM1R2aThIdDJiSmsvbVQzamx0?=
 =?utf-8?B?bkJDMWIvNmt3TFZxOW1kcWlBNHV6ZzZDRlN5WGhQb3JJMmFKVEo0SGJRUEt3?=
 =?utf-8?B?dlN1dGVvcDJ5NTNGTU00V0c1VjB1UVRFWEhaNTljbzVMVW1EUWwwdEtiMklv?=
 =?utf-8?B?eFRQWHZwUTY4ZG1EYmNhcjQyVmNnbTA2K1g0WkRCM1RKTmVFbXhnY3BlV0JD?=
 =?utf-8?B?cC93ampVTDhFRmhpMjRJeThxVHFGQ3hOV1ovR3ZRNVcybE43RWlHdmdDclpM?=
 =?utf-8?B?c2lwTVRuMkxrOXZFU0pHaVBaMFRITjdIbm9RZmlFV09oTy9QUGNuNkxPUUda?=
 =?utf-8?B?M01wTlozVEljSUczSnI0N0U3aVZLVTFERmdxcStJZDZqa2NwMnF4RXU4OGJ5?=
 =?utf-8?B?MFROSkE0KzNaWElLaGZmNjU1RTY4MHh0c3h3c0MyNXAxYWcrOFBRNkdjQ3Ev?=
 =?utf-8?B?NEJlTm54VmR6K1BocTZINWJraXJjRHVJVGZETXRKcEtGc05Od1A5MTRNRDhB?=
 =?utf-8?B?bzA2NHF5dUI4MzBJMmxabzl6SjJvbXgybE15bVZDQXhKMkJUK0FYZHNsc1Fk?=
 =?utf-8?B?UFJmT3FZczhReTdkRWl4VGQrRTNwSzRFZDhIODR6VGsxTjFUSlEzZkx5VHYr?=
 =?utf-8?B?amszcEs0Ny90aUE3c3ZaSW5wd1BCTHdjcUliLzdUd2c5eE4yaTVybTFrWS9r?=
 =?utf-8?B?L1ZMS282SExJbkxCSmx6SzJGa1BTSkk1N3B4MTIzNDNFVldocmJLOFgvNjJq?=
 =?utf-8?B?cWxwZ1NSZWhNdEdqRGJZM1ZHWjMrK211Zi9jZDU2OHdkbmpiUlA0Nm9wMzND?=
 =?utf-8?Q?dwVKd2mIG/IpEh2qYuGJQXg=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ffea8e8c-7e66-4cc5-a49c-08d9aa1c0858
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2021 22:46:02.7420 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U1ueUSwaSigUsP1zf3c4Dpn2VqAQ9eaN47vCJReuLobU/hF39mck6NvUxHDC8bHhSAsYrvz/+D/CYBGwwNMhCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5257
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

On 2021-11-17 3:36 p.m., Amber Lin wrote:
> Instead of hard coding the number of sdma engines and the number of
> sdma_xgmi engines in the device_info table, get the number of toal SDMA
> instances from amdgpu. The first two engines are sdma engines and the
> rest are sdma-xgmi engines unless the ASIC doesn't support XGMI.
>
> v2: Move get_num_*_sdma_engines to global and shared by queues manager
>      and topology.
> v3: Use gmc.xgmi.supported to justify the SDMA PCIe/XGMI assignment

You can remove this version history, since this is the first public review.

One more nit-pick inline.


>
> Signed-off-by: Amber Lin <Amber.Lin@amd.com>
> Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_device.c       | 20 ++++++++++++
>   .../drm/amd/amdkfd/kfd_device_queue_manager.c | 31 +++++++------------
>   drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |  3 ++
>   drivers/gpu/drm/amd/amdkfd/kfd_topology.c     |  5 ++-
>   4 files changed, 36 insertions(+), 23 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> index ce9f4e562bac..ec1f6bacb61e 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> @@ -1516,6 +1516,26 @@ void kgd2kfd_smi_event_throttle(struct kfd_dev *kfd, uint64_t throttle_bitmask)
>   		kfd_smi_event_update_thermal_throttling(kfd, throttle_bitmask);
>   }
>   
> +/* get_num_sdma_engines returns the number of PCIe optimized SDMA and
> + * get_num_xgmi_sdma_engines returns the number of XGMI SDMA.
> + * When the device has more than two engines, we reserve two for PCIe to enable
> + * full-duplex and the rest are used as XGMI.
> + */
> +unsigned int get_num_sdma_engines(struct kfd_dev *kdev)

These two non-static functions should have a proper kfd_ name prefix.

Regards,
   Felix


> +{
> +	/* If XGMI is not supported, all SDMA engines are PCIe */
> +	if (!kdev->adev->gmc.xgmi.supported)
> +		return kdev->adev->sdma.num_instances;
> +
> +	return min(kdev->adev->sdma.num_instances, 2);
> +}
> +
> +unsigned int get_num_xgmi_sdma_engines(struct kfd_dev *kdev)
> +{
> +	/* After reserved for PCIe, the rest of engines are XGMI */
> +	return kdev->adev->sdma.num_instances - get_num_sdma_engines(kdev);
> +}
> +
>   #if defined(CONFIG_DEBUG_FS)
>   
>   /* This function will send a package to HIQ to hang the HWS
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> index 62fe28244a80..5f2886cf4d7e 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> @@ -99,31 +99,22 @@ unsigned int get_pipes_per_mec(struct device_queue_manager *dqm)
>   	return dqm->dev->shared_resources.num_pipe_per_mec;
>   }
>   
> -static unsigned int get_num_sdma_engines(struct device_queue_manager *dqm)
> -{
> -	return dqm->dev->device_info->num_sdma_engines;
> -}
> -
> -static unsigned int get_num_xgmi_sdma_engines(struct device_queue_manager *dqm)
> -{
> -	return dqm->dev->device_info->num_xgmi_sdma_engines;
> -}
> -
>   static unsigned int get_num_all_sdma_engines(struct device_queue_manager *dqm)
>   {
> -	return get_num_sdma_engines(dqm) + get_num_xgmi_sdma_engines(dqm);
> +	return get_num_sdma_engines(dqm->dev) +
> +		get_num_xgmi_sdma_engines(dqm->dev);
>   }
>   
>   unsigned int get_num_sdma_queues(struct device_queue_manager *dqm)
>   {
> -	return dqm->dev->device_info->num_sdma_engines
> -			* dqm->dev->device_info->num_sdma_queues_per_engine;
> +	return get_num_sdma_engines(dqm->dev) *
> +		dqm->dev->device_info->num_sdma_queues_per_engine;
>   }
>   
>   unsigned int get_num_xgmi_sdma_queues(struct device_queue_manager *dqm)
>   {
> -	return dqm->dev->device_info->num_xgmi_sdma_engines
> -			* dqm->dev->device_info->num_sdma_queues_per_engine;
> +	return get_num_xgmi_sdma_engines(dqm->dev) *
> +		dqm->dev->device_info->num_sdma_queues_per_engine;
>   }
>   
>   void program_sh_mem_settings(struct device_queue_manager *dqm,
> @@ -1054,9 +1045,9 @@ static int allocate_sdma_queue(struct device_queue_manager *dqm,
>   		dqm->sdma_bitmap &= ~(1ULL << bit);
>   		q->sdma_id = bit;
>   		q->properties.sdma_engine_id = q->sdma_id %
> -				get_num_sdma_engines(dqm);
> +				get_num_sdma_engines(dqm->dev);
>   		q->properties.sdma_queue_id = q->sdma_id /
> -				get_num_sdma_engines(dqm);
> +				get_num_sdma_engines(dqm->dev);
>   	} else if (q->properties.type == KFD_QUEUE_TYPE_SDMA_XGMI) {
>   		if (dqm->xgmi_sdma_bitmap == 0) {
>   			pr_err("No more XGMI SDMA queue to allocate\n");
> @@ -1071,10 +1062,10 @@ static int allocate_sdma_queue(struct device_queue_manager *dqm,
>   		 * assumes the first N engines are always
>   		 * PCIe-optimized ones
>   		 */
> -		q->properties.sdma_engine_id = get_num_sdma_engines(dqm) +
> -				q->sdma_id % get_num_xgmi_sdma_engines(dqm);
> +		q->properties.sdma_engine_id = get_num_sdma_engines(dqm->dev) +
> +			q->sdma_id % get_num_xgmi_sdma_engines(dqm->dev);
>   		q->properties.sdma_queue_id = q->sdma_id /
> -				get_num_xgmi_sdma_engines(dqm);
> +			get_num_xgmi_sdma_engines(dqm->dev);
>   	}
>   
>   	pr_debug("SDMA engine id: %d\n", q->properties.sdma_engine_id);
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> index 1d3f012bcd2a..85efa100a80d 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> @@ -213,6 +213,9 @@ struct kfd_device_info {
>   	unsigned int num_sdma_queues_per_engine;
>   };
>   
> +unsigned int get_num_sdma_engines(struct kfd_dev *kdev);
> +unsigned int get_num_xgmi_sdma_engines(struct kfd_dev *kdev);
> +
>   struct kfd_mem_obj {
>   	uint32_t range_start;
>   	uint32_t range_end;
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> index a3f590e17973..fff4cc99fb5d 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> @@ -1392,9 +1392,8 @@ int kfd_topology_add_device(struct kfd_dev *gpu)
>   		gpu->shared_resources.drm_render_minor;
>   
>   	dev->node_props.hive_id = gpu->hive_id;
> -	dev->node_props.num_sdma_engines = gpu->device_info->num_sdma_engines;
> -	dev->node_props.num_sdma_xgmi_engines =
> -				gpu->device_info->num_xgmi_sdma_engines;
> +	dev->node_props.num_sdma_engines = get_num_sdma_engines(gpu);
> +	dev->node_props.num_sdma_xgmi_engines = get_num_xgmi_sdma_engines(gpu);
>   	dev->node_props.num_sdma_queues_per_engine =
>   				gpu->device_info->num_sdma_queues_per_engine;
>   	dev->node_props.num_gws = (dev->gpu->gws &&
