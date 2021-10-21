Return-Path: <SRS0=oZ58=PJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F03CC433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Oct 2021 14:50:36 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE67B6121F
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Oct 2021 14:50:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org CE67B6121F
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7AA916E0EC;
	Thu, 21 Oct 2021 14:50:35 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2049.outbound.protection.outlook.com [40.107.93.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2F4496E0EC
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 Oct 2021 14:50:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eB8i5dIYTl1QaxF1tM+g8GiDTV2VeGc7HZM1E24Fh0f0hVSBdpTwmfRMphYn+zK7eklnZTKqijaNdUVNPz+wAbw3FFzKOYN9Yjt5H2XlbmNS1MpCvha94eUdVc0AEXwF6UtaHGYzLLH6cqC9mP0byNJSElslJHJ5kImaadnUYPPCKyOzT6FnmsfgTSbdAPFsFtJCngZBIatYTFcBbDTIbXXF9+PdLly3bkHNAUFvnYueD++Yhl+9SENlbGRVaFJqm9kNftKude6qD3TVc7LDokBI+XwPH2xsmcaN29QezOTr/38MlGGtlYznlM+gKX0pj4dcfdtr9rJS6KvLWBIuXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O192KU6+7aF4PfSQKImKifNL2BE8hRKRWPlMifWBsKY=;
 b=iPrmsb/2bXDBPXpv6xrtUDXpS+2BOKPcVtqioa4C25qaUkPM133+EvKDSbHkHvJshIB6aWexg30ZsLz26IQasgWy5w753KFdJUcjF+Vb5HflkuUnhsojGluVWGrTr8chJ1KZ9OcFFqGUyrkaxdL1uJFvE3JW0novk2o39Q+TwCgWiKFSSRCP5GMCarHrDuI8OvV9yz7wTM3YZh7PgnIaV4UyjZL/i3PvJ2e1Inn/Qmm/+3ResQZYdR5FDZv7ykHlarAXqFF6HioZbJ2NaNOslXet1Zw+ISWDpBktuzJKQ0rIi52XrFDBjQFq3KsmwldYA0Iga9EnqnVlBaxLgp68Gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O192KU6+7aF4PfSQKImKifNL2BE8hRKRWPlMifWBsKY=;
 b=4KwB/mySvPDDU2bCk61wsb6NlYSC/yt4sCw0P3Zx4IpvSGRHTUMsth3VtGKPo0TvITQdm852WBSXCWqTZgSLG9F8chvY/znynYSCqOd1i6GwZ0HPmpTVZ2XeV36lEn2rOyVy2DmkeygFuXBoXRXBQVSSG/PQv1eE+ExTi/k8wX8=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MWHPR1201MB0192.namprd12.prod.outlook.com
 (2603:10b6:301:5a::14) by MWHPR12MB1405.namprd12.prod.outlook.com
 (2603:10b6:300:13::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18; Thu, 21 Oct
 2021 14:50:21 +0000
Received: from MWHPR1201MB0192.namprd12.prod.outlook.com
 ([fe80::55c7:6fc9:b2b1:1e6a]) by MWHPR1201MB0192.namprd12.prod.outlook.com
 ([fe80::55c7:6fc9:b2b1:1e6a%10]) with mapi id 15.20.4608.019; Thu, 21 Oct
 2021 14:50:21 +0000
Subject: Re: [PATCH v2 1/3] drm/amdgpu: do not pass ttm_resource_manager to
 gtt_mgr
To: Nirmoy Das <nirmoy.das@amd.com>, amd-gfx@lists.freedesktop.org
Cc: lijo.lazar@amd.com, andrey.grodzovsky@amd.com
References: <20211021143142.4900-1-nirmoy.das@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <48e98217-9f73-3e44-2a4b-1df9a00de248@amd.com>
Date: Thu, 21 Oct 2021 16:50:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <20211021143142.4900-1-nirmoy.das@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: FR3P281CA0043.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4a::15) To MWHPR1201MB0192.namprd12.prod.outlook.com
 (2603:10b6:301:5a::14)
MIME-Version: 1.0
Received: from [IPv6:2a02:908:1252:fb60:46a4:dec3:9292:691a]
 (2a02:908:1252:fb60:46a4:dec3:9292:691a) by
 FR3P281CA0043.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:4a::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4628.10 via Frontend Transport; Thu, 21 Oct 2021 14:50:19 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e02811cd-9ae5-4e52-e658-08d994a21af5
X-MS-TrafficTypeDiagnostic: MWHPR12MB1405:
X-Microsoft-Antispam-PRVS: <MWHPR12MB1405C6349EFAC810CEE3F9CB83BF9@MWHPR12MB1405.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5vsnPHZ41/WELOQLg5Irvc5wnHq9QdQxg2C4gFNpG4DLAeLuMDpsvOliHHsQ7p9s0RCtsI0iU1kQSAqMPQyfQDBI1vDWUguQaZv4HMoSrDG672/kcOs7xSTFuWlm5mAM8pd/m2iFFSWpcYLVziwS9D5ItXffe3dI7Lq+dCY40d2XJNGB8/3MHTznRXswd+MPm3hsPKSlb+j9UqVgqZX/17hqAmiUEEwtnlARPVugcw92PtmY0m3C5Yp6LVTaZRtr0ToCNPbzXlTlDFSOmCGBtivHx1VYzlBUJvdh7mOGxoBEEJ56gnusGCqoskVWIzoVRhUKaJ9yMkFQ39bD4oiPC+WAh6lw0gWRbnvKkf8ximk71wrpSyye8HM9Z+LyHH1A2fnLTMgwebcXCOCXXRFv3cP1xRuuToVW5RTYoq4+Ii3tyrcb/z0NMS+6fcxRjAb1EqFo3AQOdO13F5hDHFYZluet22EUF3P36yD9RKwoWG8UCFwr/cfp2UUu3mOuYGcYs68zjwG3wxniEhju2gQ8TTqxQGeq9Ax5KUk6nP3c9Ryo2kppDnDT+MzMFno+aU9/Q61VeplJyd/3WX+l6sZePtSSHtnYfdsXypPWqeVz8miqSwP78Yq54g/wT0DJziFzKWpSOX8aplHN8YzQGjcL4ivUdl8IhpVWThYqrAlZGyck4kPPqJp/4ErP68wq/UU/wQ9Wki+M7/ijBNI9JThnxBcP2AXoItv/dGb4kkCIUJY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR1201MB0192.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(186003)(31686004)(66556008)(2906002)(6666004)(6486002)(2616005)(83380400001)(5660300002)(4326008)(8936002)(38100700002)(36756003)(31696002)(316002)(66946007)(86362001)(508600001)(66476007)(8676002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VXBBc2I1UVBVdEtLc05SRHlqWXB1VWN6U2NRbDlYRDFua2ZOU2VJYlgwT0ov?=
 =?utf-8?B?QVVuVENScFdPczVteGNVM20wbjJIaXB3VHNDR0hTLzh1TlhHaUM0Q2k4dVBC?=
 =?utf-8?B?WU55OUs2Vk9MY2pNWC9PaTluUEVZZjdUNjV1VnpvbmtKV25peGIrRHJqOHY2?=
 =?utf-8?B?VVlUTUpJMUd2ZmFSSXhqSWh0cGUvR1dkaGt2c0xnQnNFckxmTmt3ZDRla2p2?=
 =?utf-8?B?TjFIMUcxcTJ6dG9VYVNReWJiZ0VXbG5aTVR3bFI4THZWVlFweXlPVEw1REJZ?=
 =?utf-8?B?UTRpUUZsTjJSdjZDbm1qcVlUamVhVEZiQWptMXladVVYVXZXOENkM2tIREl5?=
 =?utf-8?B?YjFzSTYzVzZlZXZLWWphYTY0QldsYnVETHFtckZXQW4vbklreDllTU05WExC?=
 =?utf-8?B?d1pNdEF2MlN4K0t0bHU0ZEJnWENNZytSTWVtUldYMVNPSXBHY2o1amsweHVx?=
 =?utf-8?B?UTVsMG03dlBSN2FaSHFFaUxlWG5xcjJmK0JTWWZXQTg3MTJKVWgyN3ZrRHlO?=
 =?utf-8?B?K2QwdmlLWTBBWCtRMVRIMW1VUUdnVUhEbkVwYnBMcWxueVZlQmp0aVpjc2V3?=
 =?utf-8?B?eGtuZE1CRUxKYVIrdHBycnN2dzk0b3Q3REFPbVROVStWeWZud1V3cXJKa2sv?=
 =?utf-8?B?RVZRTmFKQlRic1QzM3JKck9SUGM4TEVIS01EZW9uVE55WU1IQ2xJMjMzYVgx?=
 =?utf-8?B?b0gwaGZzaUlmVWl0UjNOWHBaclVGbnc1R3NDc3JmcUI0MzgyNEdwSXV1SWJU?=
 =?utf-8?B?aWNHUFRSeTdrUlRCN2ZuRFIvRlYxMzFGK3ZVRlQ4OFI3amErbVp0czdQNVdP?=
 =?utf-8?B?R2ZqU0JpTm1oRk5xV2lhTHJTWWFudExMOG10SUNBUDRHdWNJSzQxYkRreXVr?=
 =?utf-8?B?YWNVbFpabGRxVWRxVXVXM2l1NWJkZXQrMXZoaFBBQWR0bndyR0JudDlyUTlQ?=
 =?utf-8?B?dXEwYlpOUW4wd3JkZkZxUnlyTEVIRGUrQUk4anRTdmhNR2tGajJOald1NEZ6?=
 =?utf-8?B?TzVRaCtIUDJDUUNMMTF6a2xzOEJUNDhaY0xUd0JVODBIenhJMkx3L2N0UVhs?=
 =?utf-8?B?bmUzYzRvK2VCdE9VOEFiT21ZN1hMUHd6MncrWGZlOWVmaWc3V1pEVGVHdDhW?=
 =?utf-8?B?MWQ0RkprL2Zzc0NSbVZ6dU9pc20vbXJwczhleG9IelkyWm5Xb0ZLUDRWMnls?=
 =?utf-8?B?K2QveTJjZGVsU2xwSGpJcVVuUW00a2JqSjM2bTYweEF5TURqVHU1cGFzSjdn?=
 =?utf-8?B?ekNFUkdjR1laR1BGTWhwZGltME9IMm15TGsvS0wzSzBXS2dmR3B6WXYvc0Fy?=
 =?utf-8?B?MVBrK2hOeUFSYzNtc2djQktUTUc1aS9jSWRoRjNwQnZ2NWdNNEFKRUJ5TUlP?=
 =?utf-8?B?K0JFaXNFRE1xWjhpeHQwbXdLYVZQUjRFVmFmTUs2eVlqVnVtVU9zNE9NU0hD?=
 =?utf-8?B?UEYrWnNSYldhQjh1RWR5NnFmclkzcXhwalp4WlVPdXJIMENWYldIYklOK0d5?=
 =?utf-8?B?SWJJMXV0NmFwNTFYQmF4K2UxRmR1NTUrLy80N2NjZjFSV1lJcGVnOTIxS2pX?=
 =?utf-8?B?dGxuUjFtUTRaWU4wd1lJbXRCUzNTbnAvOUIxaHE3WE5RNmdIY3lpTlBUQnhz?=
 =?utf-8?B?R2thSHdrVDZvWXp3Qm41eTQ4ODYvWEViTDBhZCtJcUgwSlpGZHBLbFdpV21L?=
 =?utf-8?B?TFh1bHVCTWpwYnB0YzhrQmF5ZVlkR3ZWb0puR0hib2Zic1dxMnNObkZrQllL?=
 =?utf-8?B?M0MzRWIvNjRxeTB2NVNvQkorclltVEYxMFNjQVJCV0RNU0VjL2UrZEh0bDJi?=
 =?utf-8?B?YWN2a1hKa1NzWHFUS0pOeENMYW1TemhNWTNhL01GVUhDNFEzSkJzdzl3N1Rx?=
 =?utf-8?B?aUVOMUZxL3B1Wjc1VjBVUVNjRjN4dmNMNHoyZzJqRG9lc094bmVlM1NiaDAx?=
 =?utf-8?B?bGtoR1R5RnZaSThMaTlCZHNFRi9QdUxMUkgzcXBCQ3g1aHN2Tkh5Z055V1J1?=
 =?utf-8?Q?P/ti03qYHBm9OwmsaXLE6KECAtethw=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e02811cd-9ae5-4e52-e658-08d994a21af5
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1201MB0192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2021 14:50:20.9980 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ckoenig@amd.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1405
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

Am 21.10.21 um 16:31 schrieb Nirmoy Das:
> Do not allow exported amdgpu_gtt_mgr_*() to accept
> any ttm_resource_manager pointer. Also there is no need
> to force other module to call a ttm function just to
> eventually call gtt_mgr functions.
>
> v2: pass adev's gtt_mgr instead of adev
>
> Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c  |  4 ++--
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c | 23 ++++++++++-----------
>   drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c     |  4 ++--
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h     |  4 ++--
>   4 files changed, 17 insertions(+), 18 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 41ce86244144..2b53d86aebac 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -4287,7 +4287,7 @@ static int amdgpu_device_reset_sriov(struct amdgpu_device *adev,
>
>   	amdgpu_virt_init_data_exchange(adev);
>   	/* we need recover gart prior to run SMC/CP/SDMA resume */
> -	amdgpu_gtt_mgr_recover(ttm_manager_type(&adev->mman.bdev, TTM_PL_TT));
> +	amdgpu_gtt_mgr_recover(&adev->mman.gtt_mgr);
>
>   	r = amdgpu_device_fw_loading(adev);
>   	if (r)
> @@ -4604,7 +4604,7 @@ int amdgpu_do_asic_reset(struct list_head *device_list_handle,
>   					amdgpu_inc_vram_lost(tmp_adev);
>   				}
>
> -				r = amdgpu_gtt_mgr_recover(ttm_manager_type(&tmp_adev->mman.bdev, TTM_PL_TT));
> +				r = amdgpu_gtt_mgr_recover(&tmp_adev->mman.gtt_mgr);
>   				if (r)
>   					goto out;
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c
> index c18f16b3be9c..e429f2df73be 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c
> @@ -77,10 +77,8 @@ static ssize_t amdgpu_mem_info_gtt_used_show(struct device *dev,
>   {
>   	struct drm_device *ddev = dev_get_drvdata(dev);
>   	struct amdgpu_device *adev = drm_to_adev(ddev);
> -	struct ttm_resource_manager *man;
>
> -	man = ttm_manager_type(&adev->mman.bdev, TTM_PL_TT);
> -	return sysfs_emit(buf, "%llu\n", amdgpu_gtt_mgr_usage(man));
> +	return sysfs_emit(buf, "%llu\n", amdgpu_gtt_mgr_usage(&adev->mman.gtt_mgr));
>   }
>
>   static DEVICE_ATTR(mem_info_gtt_total, S_IRUGO,
> @@ -206,14 +204,15 @@ static void amdgpu_gtt_mgr_del(struct ttm_resource_manager *man,
>   /**
>    * amdgpu_gtt_mgr_usage - return usage of GTT domain
>    *
> - * @man: TTM memory type manager
> + * @mgr: amdgpu_gtt_mgr pointer
>    *
>    * Return how many bytes are used in the GTT domain
>    */
> -uint64_t amdgpu_gtt_mgr_usage(struct ttm_resource_manager *man)
> +uint64_t amdgpu_gtt_mgr_usage(struct amdgpu_gtt_mgr *mgr)
>   {
> -	struct amdgpu_gtt_mgr *mgr = to_gtt_mgr(man);
> -	s64 result = man->size - atomic64_read(&mgr->available);
> +	s64 result;
> +
> +	result = mgr->manager.size - atomic64_read(&mgr->available);
>
>   	return (result > 0 ? result : 0) * PAGE_SIZE;
>   }
> @@ -221,16 +220,15 @@ uint64_t amdgpu_gtt_mgr_usage(struct ttm_resource_manager *man)
>   /**
>    * amdgpu_gtt_mgr_recover - re-init gart
>    *
> - * @man: TTM memory type manager
> + * @mgr: amdgpu_gtt_mgr pointer
>    *
>    * Re-init the gart for each known BO in the GTT.
>    */
> -int amdgpu_gtt_mgr_recover(struct ttm_resource_manager *man)
> +int amdgpu_gtt_mgr_recover(struct amdgpu_gtt_mgr *mgr)
>   {
> -	struct amdgpu_gtt_mgr *mgr = to_gtt_mgr(man);
> -	struct amdgpu_device *adev;
>   	struct amdgpu_gtt_node *node;
>   	struct drm_mm_node *mm_node;
> +	struct amdgpu_device *adev;
>   	int r = 0;
>
>   	adev = container_of(mgr, typeof(*adev), mman.gtt_mgr);
> @@ -260,6 +258,7 @@ static void amdgpu_gtt_mgr_debug(struct ttm_resource_manager *man,
>   				 struct drm_printer *printer)
>   {
>   	struct amdgpu_gtt_mgr *mgr = to_gtt_mgr(man);
> +	struct amdgpu_device *adev = container_of(mgr, typeof(*adev), mman.gtt_mgr);
>
>   	spin_lock(&mgr->lock);
>   	drm_mm_print(&mgr->mm, printer);
> @@ -267,7 +266,7 @@ static void amdgpu_gtt_mgr_debug(struct ttm_resource_manager *man,
>
>   	drm_printf(printer, "man size:%llu pages, gtt available:%lld pages, usage:%lluMB\n",
>   		   man->size, (u64)atomic64_read(&mgr->available),
> -		   amdgpu_gtt_mgr_usage(man) >> 20);
> +		   amdgpu_gtt_mgr_usage(&adev->mman.gtt_mgr) >> 20);

That here needs fixing, we shouldn't use the adev->mman.gtt_mgr here but 
rather upcast man.

Regards,
Christian.

>   }
>
>   static const struct ttm_resource_manager_func amdgpu_gtt_mgr_func = {
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> index d2955ea4a62b..603ce32db5c5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> @@ -678,7 +678,7 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
>   		ui64 = amdgpu_vram_mgr_vis_usage(ttm_manager_type(&adev->mman.bdev, TTM_PL_VRAM));
>   		return copy_to_user(out, &ui64, min(size, 8u)) ? -EFAULT : 0;
>   	case AMDGPU_INFO_GTT_USAGE:
> -		ui64 = amdgpu_gtt_mgr_usage(ttm_manager_type(&adev->mman.bdev, TTM_PL_TT));
> +		ui64 = amdgpu_gtt_mgr_usage(&adev->mman.gtt_mgr);
>   		return copy_to_user(out, &ui64, min(size, 8u)) ? -EFAULT : 0;
>   	case AMDGPU_INFO_GDS_CONFIG: {
>   		struct drm_amdgpu_info_gds gds_info;
> @@ -738,7 +738,7 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
>   		mem.gtt.usable_heap_size = mem.gtt.total_heap_size -
>   			atomic64_read(&adev->gart_pin_size);
>   		mem.gtt.heap_usage =
> -			amdgpu_gtt_mgr_usage(gtt_man);
> +			amdgpu_gtt_mgr_usage(&adev->mman.gtt_mgr);
>   		mem.gtt.max_allocation = mem.gtt.usable_heap_size * 3 / 4;
>
>   		return copy_to_user(out, &mem,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> index 91a087f9dc7c..af1c4e414979 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> @@ -114,8 +114,8 @@ int amdgpu_vram_mgr_init(struct amdgpu_device *adev);
>   void amdgpu_vram_mgr_fini(struct amdgpu_device *adev);
>
>   bool amdgpu_gtt_mgr_has_gart_addr(struct ttm_resource *mem);
> -uint64_t amdgpu_gtt_mgr_usage(struct ttm_resource_manager *man);
> -int amdgpu_gtt_mgr_recover(struct ttm_resource_manager *man);
> +uint64_t amdgpu_gtt_mgr_usage(struct amdgpu_gtt_mgr *mgr);
> +int amdgpu_gtt_mgr_recover(struct amdgpu_gtt_mgr *mgr);
>
>   uint64_t amdgpu_preempt_mgr_usage(struct ttm_resource_manager *man);
>
> --
> 2.31.1
>

