Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6506D3517D
	for <amd-gfx@archiver.kernel.org>; Wed,  1 Apr 2026 13:25:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 82E0410ECD7;
	Wed,  1 Apr 2026 13:25:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="DTUZjcx2";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010018.outbound.protection.outlook.com [52.101.85.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C8F6410ECD7
 for <amd-gfx@lists.freedesktop.org>; Wed,  1 Apr 2026 13:25:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=np7p8LUEuYDKf8yfIKMMcxDeVY9korau+rhNETyStRZPd6X/RsHq2zuNJjLySC/Tf7g++eHjIxfJzSck82mGLUxST0amntYl6tXB+a+MdWOgdwYQ3Ohm1C1Xbpna70+TKeC5frIXmau5gStMSHoZ3RbXNR+X9nYNDeticHbSv06wbWaRmuHcRyYyNBK4zi7WVhiNMQ1Yx30H3oN4uYjUQbxstNMZlj/r3lg8ycbm3XBwKDGA4KIAs/F8JwTZz0mOtWmL6wiVQ+jChLWyNx6z4RGklzrejgGHCxlUiIRB89nlAyNbXMQqz1idY88+4ugiW6fh4L1U8AfG52cxXMutHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mB5N+uWtpzdMVKs7Z1ig88eH1YjJjW8Qj6Asz5myLh0=;
 b=lscus7n9eAbyaZ1aFLX/qIxLZFWZcTd71lr8vN0hYZlP6DBjOOIaPyoBRfQdYQmCg0wfw9y6v2pw0OJj0wHH7iL/kpkDSSH+KN+mZri5kYauIyprsyz7Nts04SB8Q54+MSB5RCSBrlKievBpLSt1Mgcg5xuw6H8k0PqBqzudStK6zLDGPWWUrk5h6VQ8oTctKa9di2L4844gw/iZ//WxzcAaMRVOe+SIJnMQQJL9MdMxDVeBoaXjMMFx19lPBaiJEAVgMvWEvQoWQto9iDOuJhHY1aQgYXSM/2mEdYClmmxLzXvrZA+cOPNDgChET0ErzOttReYg3PpKk+f351cGIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mB5N+uWtpzdMVKs7Z1ig88eH1YjJjW8Qj6Asz5myLh0=;
 b=DTUZjcx2qP52y/Hon3OH0GrrdaNdBGeTf2ML3V8URKxfoha0A4KlvPWxGLpH93++MN68Ox0QxQJNz19lnLWgUioQgC6wMsFANX2Otm4oWFW1RBxBn8onTL6qhAczy+bdlPgY+jz0Yi1ieze5PJVtzvoviRZgrUY2xRevPJY21eI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by PH7PR12MB6977.namprd12.prod.outlook.com (2603:10b6:510:1b7::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Wed, 1 Apr
 2026 13:25:30 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9769.016; Wed, 1 Apr 2026
 13:25:30 +0000
Message-ID: <86c2ca55-5c08-434c-8055-b88e9beed52d@amd.com>
Date: Wed, 1 Apr 2026 15:25:26 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v5 1/5] drm/amdgpu/userq: fence wait for max time in
 amdgpu_userq_wait_for_signal
To: Sunil Khatri <sunil.khatri@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20260331134654.2762805-1-sunil.khatri@amd.com>
 <20260331134654.2762805-2-sunil.khatri@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260331134654.2762805-2-sunil.khatri@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL1PR13CA0277.namprd13.prod.outlook.com
 (2603:10b6:208:2bc::12) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|PH7PR12MB6977:EE_
X-MS-Office365-Filtering-Correlation-Id: 4969374f-201b-4b68-416e-08de8ff2253d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|56012099003|22082099003|18002099003; 
X-Microsoft-Antispam-Message-Info: xe9D1QLThcCClPKtvjB9KJtOgUzK+ngBGCy6iO60MlrK/WHVbHhq+MYODz0YDUzjmuPk9kVBohYlhMt2y6BtxsOZq2IlYltLhNQM3q3iqQSTW4QPaz1PkLpjcCF9tOTdp0F7A19H0k5WO6DY3K3YVzogI2Cm36+/bkKhmQd2rXQAUp6orylMvFXPTGXR6OYvoh4s+hNH9DAV8nrFzj60o0i17wv0+Sn9sKU1H52KOR2Zq3XNyzjioyhFl9vv0DrzoJToB+S25hFuRLmCbgcj+fX36Gy1SpgMPBIJuDu3ERCOghx8dToPLdj7AVw5K835uQVC8yS7qOU65+XbTwGyPcTvQ5dxmSZ8FREhSXdM9kFluVzdV7ibxTjTTnVcZgb1vSBOcV9dybfvap2TUkhmpMT1u0ydPpooEnooEKOi8WMVDZjJgM1KYoE+BE8xQxh/qJqU72mYHCicqRGNBuDa1gwlYgOYKKZDJQbqdP6gFCIhKvyyKR9ZhsaIs76dC8A7MVoK4d7ppbmjLZ01E/ujVAIAIiwa7ws9ODxpL9jV676GZgxJ7+1vqlvm2NlQdlQdoiNmSW16fcMFmQhwkRqWV0bX9gmitsFfASxm27H9d8KHJZy2JsxApW2yxKERi5tKh5oj9/J9qtevFupRsGl/vSAXVU0iGouWkPVVqmwuKSjJx4/AIOMXoRQjyhBq5htWKHEDgqdbTt/oG63JRjjDe0NVu9WfDBJxQVvU5GVHgBM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aEZlOU42N0hzQVJVTER5SGNPRG1wTjhVeXpGTTdtREY0MWIzOTNhVCtTRURl?=
 =?utf-8?B?TExDUjY3ZzlNbTc2U0srcFY1cFNkWGYwVmVuRUM0eW1wM3JTTUVpcUlzbVc1?=
 =?utf-8?B?N1JzcXh5QlVpM2FTaXB4N0VtRzkvS3BSSUxKcjJpYnBwVlJkaHl1ZlZNaExs?=
 =?utf-8?B?cWVCMmNCWGIrYXR1UVpiUTROaUV3WG5IR3RtRTVsNWhQT1QrdGRJUUwyaWY1?=
 =?utf-8?B?T0RNalpaNndlVGJtZWhUT2gxRHh5ZXhQZEo4RzVVRmk2QWt6cmRUREZPY2c3?=
 =?utf-8?B?bWs0eHoydHJkS3Mwdkc0WFoybXJFN1BINE5Eb1FTeGp5WDJ1OTlXaEFmSkRG?=
 =?utf-8?B?aW53aDhCblN0K3g4WCs5QmI1WU1IL1VvSGs4Tkl6M0NqMEpPSW1IaXA3cFE0?=
 =?utf-8?B?cEI0cTBnQTh0WHhDKy9KZ2dmWTJpYkF5Rml1ZHpkOHBybUx3ZmVHUUE3M1V5?=
 =?utf-8?B?RlpWN2NzQkpSYmw5Q3g2R2NlckI1UDVPL044Z0Iwa1F6dTl4Q0I1SE9sK2My?=
 =?utf-8?B?ZnpxeWxvSzVKN21jS1dRN0dQS3ZwWTlmcStZR2RIS2phcHluUmhFcmdFMTBL?=
 =?utf-8?B?RzlYKzNWajZyNVhkQkEzQnl6cFMwN3dYWHphTDY1eDRwT09NVnFmc1VpemRk?=
 =?utf-8?B?L2g1UXU4YjE2eDZua2Q5Z3NNdkVrQW55OGg1SGtwMjgrUnIzUW1nSDNjQlht?=
 =?utf-8?B?UXNmKzh4d3J4U1RtZFFsaitHQUQ2UGFqODhSMUxIYVZLWnphWnhaVjV3dDlo?=
 =?utf-8?B?L21ZSEZpY0RLQmd4Zit4Wjh6L2xCMC9iT2lhUkY5VHVoMWp4aW04TlpOTTFn?=
 =?utf-8?B?VEhMOVFyNDhIdFJORGpFbytZWnp2Q1VoTERoaUx0UnNNOEhMejkvMmtQZVIz?=
 =?utf-8?B?M1QwckdBN1dVTWQ5dlkrVkoxZlprNmoxNE43NmZDM3J1czhzTW9OaHVVcEMy?=
 =?utf-8?B?cmVwL216Q0xYanNudkV4T2RQMmRsYVo5UFg0ZVh4WVVGK3ZnWklya1RFWGMr?=
 =?utf-8?B?RWYxM3RYMWFOV3E3c2x1ZXFGeFJzaTF1WGJ0S0JpVTVoVlJiTGhNWWZ3K3l4?=
 =?utf-8?B?V2l4dWxBTzI3dWlxWTRjclV6UVNXcWVRa2o4N21INnJLY2cvWUdIMUNqYjRP?=
 =?utf-8?B?TEgvVENGTlFVSWl2ZUJUWUV2a1JtQ2ZMQUhSSUZKQnhEeVRjcHZOaE4ydWU0?=
 =?utf-8?B?Vkp5ZjNRV3U4YVkzMmFkeDVCSlZKbmdqNGI3NXIvYkkvRTgza3poR0ZYT3NC?=
 =?utf-8?B?MjF0bDJaZ3gyd1pHYklTSks5UWcxYWJYQzVYTlFtVWtXU1M1ejhtVzR1dDh0?=
 =?utf-8?B?NXhCZTJKdjAwQVZhZ2dFd0FQVXNmQm9MdkFEQnQ3d3d4WDA3c1Fxc3hsVWgv?=
 =?utf-8?B?VmNVWlJlWjVsWWlJcy83SlBXa1J0bmM2Rlg3czAzMVRqNGtLcHpIRjVUUGM0?=
 =?utf-8?B?d0R6QUcwRWROZ0FMalpSbStqSnlRb2hhclBhLzdQTytOSmlrajJtc1UwN3FD?=
 =?utf-8?B?OVZONVEybzRBVkNJMFNOTmZWSk1RdDNZL2kvc0JkWGp2VEk0SkJac3BkQVVj?=
 =?utf-8?B?M2ROSFIzVjBBRXhhUm03RVJXOTFsdjY3Q0tTbGVramJMRWV4N0dTMmNYRUJV?=
 =?utf-8?B?bkwxazh1VDhsd1E4UUNMNFVNQThGTHM3WWNXbHByRHp5bWFXSWdvdXh0Z1p6?=
 =?utf-8?B?dWk5dnJ2TFNGaUR5SDVxN1hRcU9HUWJHR3BVVkFHRmxTTTZGUFdpRWpYWUZF?=
 =?utf-8?B?ZFYwcnV2cjZIOStCMHozeG5QRFJFTkZSMktPOWtwdkR1U1hoMG9IOXFoZ2Nl?=
 =?utf-8?B?WWJQbDcyTjhxVUp0Y1RROVNVYy9RTjRmVFMzVW1NaFVkS1VYM3FFcmhkR2sy?=
 =?utf-8?B?MEwrUzdxRmF4ZjBvZ1NiamFKQSs1QWpHalpSTTQ5eTdsVEpCZitNaEYvYTNq?=
 =?utf-8?B?eVBObGt0ZVkveXJBZUd1Zmo2a2xqN1FvZWRJN2FyL1hhSlMxNHI5RHp5djhw?=
 =?utf-8?B?cUdvK1BQVjdPWHZFbDlTSUxRQnI5S1ZYV0tvdWZiWGVtUTZ2blljeDRGeVl5?=
 =?utf-8?B?TW5odE9pT3JKZFc3RWJ3YUN2WHFuOGxkWVZhdmpnbkkzRXEzUE9zbEcrZ0Vv?=
 =?utf-8?B?N2ZnYmFINTFEU2N5SEIzdkNHVjdzOVFpSVJlcUF5RUdCcUhBQjJ4cDd4TXlK?=
 =?utf-8?B?RjkyWHBKN3E1ZGV6bmxDR3ZFNFNRYi84N2FmSmpMa080ZENVaUlMTkJ5b21J?=
 =?utf-8?B?WGRNRld3dm5SQ3MzdkpweXR2SlBFczA1bnhrN0RVbnRPUmJrc3lNSTZsK1lv?=
 =?utf-8?Q?aMyRuj8tJRrbFa9KUX?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4969374f-201b-4b68-416e-08de8ff2253d
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2026 13:25:30.8148 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RKAjBEn+Gm4/UTLIzam+MNvekEoaP+iNwruX1xdNZdVOX/iJ3X6UPmy9pbTl7c+y
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6977
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

On 3/31/26 15:46, Sunil Khatri wrote:
> wait for infinite time for fences in function amdgpu_userq_wait_for_signal
> and for that use dma_fence_wait(f, false);
> 
> Suggested-by: Christian König <christian.koenig@amd.com>
> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>

Assuming that compile fine even as stand alone patch: Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 15 +++------------
>  1 file changed, 3 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> index fdae8c411aaa..a98118898832 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -1279,29 +1279,20 @@ void amdgpu_userq_reset_work(struct work_struct *work)
>  	amdgpu_device_gpu_recover(adev, NULL, &reset_context);
>  }
>  
> -static int
> +static void
>  amdgpu_userq_wait_for_signal(struct amdgpu_userq_mgr *uq_mgr)
>  {
>  	struct amdgpu_usermode_queue *queue;
>  	unsigned long queue_id;
> -	int ret;
>  
>  	xa_for_each(&uq_mgr->userq_xa, queue_id, queue) {
>  		struct dma_fence *f = queue->last_fence;
>  
> -		if (!f || dma_fence_is_signaled(f))
> +		if (!f)
>  			continue;
>  
> -		ret = dma_fence_wait_timeout(f, true, msecs_to_jiffies(100));
> -		if (ret <= 0) {
> -			drm_file_err(uq_mgr->file, "Timed out waiting for fence=%llu:%llu\n",
> -				     f->context, f->seqno);
> -
> -			return -ETIMEDOUT;
> -		}
> +		dma_fence_wait(f, false);
>  	}
> -
> -	return 0;
>  }
>  
>  void

