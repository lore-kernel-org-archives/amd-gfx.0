Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FB5EC77B61
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Apr 2023 12:32:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E6AA610E6F9;
	Tue, 25 Apr 2023 12:32:21 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on20615.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eaa::615])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2C52010E27D
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Apr 2023 12:32:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=USGA88N3gcshKx0WTyAKfEBw30IPCsmAr6MBBVYjUScwFYGVGrzft0kqnpppV6Dyl2e4EtDaITQJJHLAf/ppcf0kTDz3NARDZTn3Vx3NfyUkw2d2Vg2taGF5ewD92WXI34KNfmabb+v5CEKdDcmyKbfksUgohZ86OQrlCUwrIG3fNEQ2XSo+0pS+/zMssNRut3EtnMadlv79sLAEKDUE9v37M69h6ReFtuVqAgnPk6zzqyroP5EgG6mqGSS7qGnorpkZQUxkcTa1SCh4Gh53tJ+mAj4O1IaxABw71MxtXfD1SfHZEPR+s6gmPJCRKG7ob8j9xybZFPlPTQXlzrUVLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8BU8/u+/UALKMMkwAx2UbIUA6B+o9qpDt23jiGeE9S0=;
 b=OqhiiPMJNF+WvwqT3crP7JGjMdvp3x0ee5nJVIFgysuv3/Gpv5qasrCBJ7qGYyJPwm0vcc+9qsOavqR32FkEXrJynnphAL1PKdZU6dsiKcPtWr/lEv9kpG+Ns3Ux8f7rdGVNkCDv2BjSoAoIwF+32wFWOvlKVap4bGoJDe/n34esFhKlZTLdWjS49P65e6iVtIOU3j18uHb+o9szlnQPao6Mz9o45lADUKgB9wiH430rqaaM/obxfT+VaoMHkJTf/5AME7nQWUyI2sVLbjdV/Xi4+cm4gLtcd587WWYsNBxt556DDmkhjq7dDv1K7LJdnVrD3gIoW7qxmzZZoyXoKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8BU8/u+/UALKMMkwAx2UbIUA6B+o9qpDt23jiGeE9S0=;
 b=Ca6awOxCGS7IBMQlizDY03p1PEube0a0O9GKIRdkXiiTv34uoNHO3kg8MC27IK+ff21o86j76IGh5giASur6ATNZhQhTjXcq9YzpY+GaruNxhbT/9AgaWHV1K9pzrCgElJ4+02wtOcA5I7fOBGzEtWWakUrUZFLRg/ySwGEr3oE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by BY5PR12MB4097.namprd12.prod.outlook.com (2603:10b6:a03:213::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.34; Tue, 25 Apr
 2023 12:32:17 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::d2f8:7388:39c1:bbed]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::d2f8:7388:39c1:bbed%3]) with mapi id 15.20.6319.034; Tue, 25 Apr 2023
 12:32:17 +0000
Message-ID: <3ce3210e-bc0a-bcf5-a83f-629c1792ad43@amd.com>
Date: Tue, 25 Apr 2023 14:32:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v4 06/10] drm/amdgpu: set FW parameters in v11_struct
Content-Language: en-US
To: Shashank Sharma <shashank.sharma@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230424173836.1441-1-shashank.sharma@amd.com>
 <20230424173836.1441-7-shashank.sharma@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <20230424173836.1441-7-shashank.sharma@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0110.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a8::6) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3587:EE_|BY5PR12MB4097:EE_
X-MS-Office365-Filtering-Correlation-Id: e7ef185f-8c4f-4b4a-f482-08db45891b3c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: plDIsUDh3iQleJRLxyh4gPXnAf8FdstHwvBl3YHNvioIiyZ6zbcnCbSROa6kjkTKxfElgvAO48yeApboMkoP9cyDM+lzlAu8TbydmVSvIp2wueb2QGVySj6YsRjYQBO80B8J73zwipZjN7N97ktTc1+OIsfLYSJy/paQPGByQkK6fRlsr/0VdavLRL8Rbsh33/FzjxVaOrlvh7bJyTcAH3Pmo3hpn0Xcf9XDRn0LGMrhDFo7m1CIonrWcEhKkeRUTd1lVDL+RyssFbdrWIXcm6Mlv7hm/PB6sLi77vW7JB/uYKkdqNm2pamoaEx/CIuoXT329OOj4AbCTUIvLZ446Lee0bdA1s2yTLf+0LGViTtzy54jFe4qcYuDnec15z9TCkjOGjUPb6AJZEXgOGHHH6+JtWhlFGmGzFlopWhHoIoKQQNy9W4Uw2+i1yUA62gCxpXN5bavY13nPAKTaraDIQGxFtQkw/ZMhO7DstH2QP8/2DvbLS76ZdkzsaCd6680ZKe21QM0vkZrbzovLa1a9DBZ68QT0oKwIpfZzxaUfJknLQj+SeTHjpKE6tZKFIsrDmrVEW8Xxg/36p1xTqdmIyGDetWrcCmnROitEBw21uLp79/odrOYom6Swugrp6Tt4jcwOZUiIZDrw2SDlFqEvQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(396003)(376002)(39860400002)(346002)(366004)(451199021)(36756003)(31696002)(86362001)(478600001)(38100700002)(41300700001)(8936002)(8676002)(2906002)(4326008)(66476007)(66556008)(316002)(66946007)(5660300002)(186003)(6512007)(6506007)(31686004)(83380400001)(2616005)(6486002)(6666004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V2RYUlUzVzZYZ29ILzg5eXZXSnpxeWUzL2Z5UEtaZXhLdDJYaWZ5ZXVvNVFC?=
 =?utf-8?B?NUV0MkpDMDlOczZkR1NWSUVuYklTU1Rxa1p2RDk0QTcwMTBjaWlHdVcwMG02?=
 =?utf-8?B?czR4b0dST1ZhMVd4azJVSm9Qc2t5ejlzUG9FMDNoVGY2aFhjMkltdzlGR2t5?=
 =?utf-8?B?LzhNVWRVWTRMRlVtcFlrWC91RlROOGZjL290SFJobzl6d1doR1Y2U1ZIU1Rq?=
 =?utf-8?B?Vi82SURmOExpUk8rUlJ0NVZMREduMFlNbmpOcGVsSUVIWjRFK284RHZlYkk1?=
 =?utf-8?B?UDg1TWVTd2M3MFYrOERLSk0waHNXb1RyZTFOenlZRU1rZ1EvenR0R1hNMFVN?=
 =?utf-8?B?bEhoZmhtUVg2QVVnTGFGZWg4ZWRRQ3MwSHY0OElIUEdHUDI3Wld1VndZZXVR?=
 =?utf-8?B?UHg3M3lhYzluc09xSkJjL0tKTnNuTHZjMzAwT2hYUURUTkZWNllLR0RqU2Z1?=
 =?utf-8?B?aTQ4OENRYXRVQyt5dWZ6d0tySFQxd2V3M1djSjZTN0R0VDIzSDViUmJzMG9v?=
 =?utf-8?B?clRoUE5DWUVCTmlVZXRrL21lc0ZvWCtwSUFTaGZmRVV1TWJnVDdCT0tHSnlL?=
 =?utf-8?B?WFJnRmJYUndIdlBPbGw2M2FxaE1RclRGcTgxNmZ1aDkzSzBFcGEyaUR4Y0xB?=
 =?utf-8?B?RW10b1l3RFYwS2JZem5CVFBMZ1YzOUd3bDRvWjljaWpHeGxpRy9XS00zYitq?=
 =?utf-8?B?OWpKcGNGbzA5Z09pdUdtUHVwUmtIT0ZrWUFMQ210SWQ1dS9oNWs1TjRab0tJ?=
 =?utf-8?B?SG9QbDF5NGJEN2FzZDlLVW1HaFJSK2p2VUtoaWdPZkZnTGZYbDMzYlhaWHBZ?=
 =?utf-8?B?cXFkTkdKVm1tMVkvOTBRMDl4cUFHT0JMSEh6dUdQdnpxeHArOSt0Qk9zaW10?=
 =?utf-8?B?aXVpdHJmazZodWJYL3RuOFIvSXluNFF6eHpQOFE0NFN1d0pVeThkaXdwd2ZB?=
 =?utf-8?B?NjdkRnNIeFFNLzBPY0N3aTAzRGRkVDNZSDVGZUdOSGdpd2d0ajI3dUtwdFBx?=
 =?utf-8?B?bW84c08yb3hSM05zZXhWNjV0L3ZuSVhhMWc3dHprcm1BK0dsUzY3Q1k4dEpC?=
 =?utf-8?B?cnpUNDIyTjFBWHhKOUk3Q1dmc3E5THVqTndLSThXbGM2TkxJVU9vZzNTUWJX?=
 =?utf-8?B?UDl5bnBGMmcwQWFqZHZYUkRHUXZUU1RKbXJlZzRtNVJVU0FTVk9raEdkWnF4?=
 =?utf-8?B?aHVEampkdlNNQ09KeGcrYjRBdFRrWDRTRWt3WG92ZEtmbnlEcHUrV3dwc0pn?=
 =?utf-8?B?SzZialcvalo3dEV4MVhLQzRoQnA2dFd4MjBaV1ZlUWVhcng1MnhYbGY4VTR2?=
 =?utf-8?B?RExMSUczb1BPTGRVazljc2VRVUd3NTJKR0UxSGJjVGZPaEF1Ui80RUtFTUts?=
 =?utf-8?B?U0c1K3AwZmhRSlM5UTB1ay93Q0hoQmZGYU1jazJsb2h1S2tsNjdYR1o2TTZR?=
 =?utf-8?B?QmdMeWYxMnJYTVh2YjNyRHgwaXNnKytMQmNyaGR2V1RLYWRqTTNGWnFDNjRa?=
 =?utf-8?B?NG5iMEQzaWhBdlMyRTlpN0hjRjdMWEthWVBDTzV3RUlQMmdWRWV6cU1FSy9m?=
 =?utf-8?B?RjR2ZUhkNnhERWFpc0lndGt3OXBSMTdkTUhUVkEwbklSWGRVSUlPRzhlOWs3?=
 =?utf-8?B?a0RpbjBhUDFrd3E2RE1oZ0RtemMzSVZvbjRVbEFFUGtaN0MzbDgxdWhRY1Rj?=
 =?utf-8?B?ejJnVzhFVHBpSmJ4N1lrRzBtUmFIK3pwdmEwQkkxNmt6c281WW1zZFFISnBa?=
 =?utf-8?B?WU1HWk9yVmVFVkNsczhBZ1REd014ZlBsK3ZHdWlzUUVGN3ZQR0syY3BDVDF6?=
 =?utf-8?B?SUl5TEZGV0ljUGluMmZ6TW1RZnhOenNwdkpvVUVJUlRHTjhnNzd2b1d6TVBy?=
 =?utf-8?B?ODJ0YlU4bkF2aExZUnZIbVh4eVBNNkZxYUxoL0JPRUFnMkVvcXBSckpDbzhV?=
 =?utf-8?B?WE40OEN2dDRGcUpYVU5wSXNYVXhtYk1OVzdheTZ5ekRWNnJFWEdGbDA3b3BK?=
 =?utf-8?B?VU1SSXh5WGZXMXEwWGZzbzdnTVR0S0phS1lWMmFIcGVlQnhaSzlNWDZGS2Jr?=
 =?utf-8?B?THM3NW54SjA5dVY0VnhwNmlpNkxOQjdYWnRFTkUzV0dybmg3Ymh5Vk5qNFQv?=
 =?utf-8?B?SUhDaDJCZkI0ZmZQTjhYU21nL2NxWkFoalFRYkVaMDlNMjNzTy92N3BBT0ZP?=
 =?utf-8?Q?NEO/2AM5vKDW1GM3Tks2JC+7jVeJSt33RPVg2GKnwcyZ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7ef185f-8c4f-4b4a-f482-08db45891b3c
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2023 12:32:17.4506 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DsLqXUrsKrE4RAwQ3gnpcPPxywqdDfV0/jclKCgFhhKwzc4ePkaV8U4a/SM2PbYD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4097
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 pierre-eric.pelloux-prayer@amd.com, contactshashanksharma@gmail.com,
 arvind.yadav@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 24.04.23 um 19:38 schrieb Shashank Sharma:
> From: Arvind Yadav <arvind.yadav@amd.com>
>
> This patch sets new parameters defined in v11_struct for
> usermode queue with the respective allocated gpu context
> space addresses.
>
> V4: Split the patch into two parts, keep only the set parameter
>      part in this series (Alex).
>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Christian Koenig <christian.koenig@amd.com>
> Cc: Shashank Sharma <shashank.sharma@amd.com>
> Signed-off-by: Arvind Yadav <arvind.yadav@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 19 ++++++++++++++++++-
>   1 file changed, 18 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> index f6b33faea86f..86de35292f69 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> @@ -6411,6 +6411,21 @@ const struct amdgpu_ip_block_version gfx_v11_0_ip_block =
>   	.funcs = &gfx_v11_0_ip_funcs,
>   };
>   
> +static void gfx_v11_userq_set_ctx_space(struct amdgpu_userq_mgr *uq_mgr,
> +					struct amdgpu_usermode_queue *queue)
> +{
> +	struct v11_gfx_mqd *mqd = queue->mqd.cpu_ptr;
> +
> +	mqd->shadow_base_lo = queue->shadow_ctx_gpu_addr & 0xfffffffc;
> +	mqd->shadow_base_hi = upper_32_bits(queue->shadow_ctx_gpu_addr);
> +
> +	mqd->gds_bkup_base_lo = queue->gds_ctx_gpu_addr & 0xfffffffc;
> +	mqd->gds_bkup_base_hi = upper_32_bits(queue->gds_ctx_gpu_addr);
> +
> +	mqd->fw_work_area_base_lo = queue->fw_ctx_gpu_addr & 0xfffffffc;
> +	mqd->fw_work_area_base_lo = upper_32_bits(queue->fw_ctx_gpu_addr);

Mhm, first of all please use lower_32_bits() here instead of the mask.

Then are you sure that is correct? The shadow, csa, gds are supposed to 
be VAs as far as I know, but you use MC addresses here.

Christian.

> +}
> +
>   static int gfx_v11_userq_create_ctx_space(struct amdgpu_userq_mgr *uq_mgr,
>   					  struct amdgpu_usermode_queue *queue)
>   {
> @@ -6484,12 +6499,14 @@ gfx_v11_userq_mqd_create(struct amdgpu_userq_mgr *uq_mgr, struct amdgpu_usermode
>   	queue->userq_prop.use_doorbell = true;
>   	queue->userq_prop.mqd_gpu_addr = mqd->gpu_addr;
>   	r = gfx_v11_mqd->init_mqd(adev, (void *)mqd->cpu_ptr, &queue->userq_prop);
> -	amdgpu_bo_unreserve(mqd->obj);
>   	if (r) {
> +		amdgpu_bo_unreserve(mqd->obj);
>   		DRM_ERROR("Failed to init MQD for queue\n");
>   		goto free_ctx;
>   	}
>   
> +	gfx_v11_userq_set_ctx_space(uq_mgr, queue);
> +	amdgpu_bo_unreserve(mqd->obj);
>   	DRM_DEBUG_DRIVER("MQD for queue %d created\n", queue->queue_id);
>   	return 0;
>   

