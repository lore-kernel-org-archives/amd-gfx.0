Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2626C433EF
	for <amd-gfx@archiver.kernel.org>; Thu,  5 May 2022 06:47:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3F7FF10F566;
	Thu,  5 May 2022 06:47:04 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2051.outbound.protection.outlook.com [40.107.237.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 87B0E10F566
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 May 2022 06:47:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cE8ffN+/DAp9c7LTkaOPjSoOqxckkP5Dpw7J9J9SwXKZ0e5LrKDy6nke/s+hlU9aDxRGxb9gon1gX0IbLvjOtcFJp1yTDZefJ4ILJWuh6QkEuWnkrYmgxGm5En998J94GmPcyOJ5g8dmS+MJ/9tUSu7MXoU0hnNycba8lxuh/p4vGdygKQx8ofSUJGpgVJcjf2nu7II1JC0jfOFr6e53/rUlzzVY/5Ey8k73ZHd5BEhhHtyBN6Gffq/Axf70H8MS/xrD5uZ6TEraolXlGYX0JV6WEYKsvwQP6JnlmovkpJH/fQNOn08fhAbnN50KwqAPXCveYmOX7XVGMId2IwummA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Op/rRdWXFmXI/TahWol1DvLr2Uw5Uv9BUZVbmSxZci4=;
 b=XRIbFmlWzZBvgaMmr6t9BuG4lTdeVzjQ6xZ2QEP88n9df1EO+2Gs8OCcp6He3YBHr94yfXKg0oIVnMVf0ARxeQxGPM3OdpBLiaqpbfuYt2CUvaBqtsM4c46xkm9vBuLJ8QCJ8GnqTi6WrkwyP4Em+wNwHcFc5ZB356CYw4l5N77rBlXxG08dbkjorOM/zhSd0f7CEZD5fSxKbDNwRTHYGEaMa8+uo1ZLQNQgHLzIdoSWMG/VC8POuS2CkR/nGX/BzhmhoYLu88PhEFSG7Ciiar6VxsuVdXU+GfF5BpVzx3X7OXB7Nk66DLla/UkJv9PnpHfQ0MbHbYnkqHPniMKcJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Op/rRdWXFmXI/TahWol1DvLr2Uw5Uv9BUZVbmSxZci4=;
 b=fk+mSG8VQow5+mTiB2TqZ8LlcnpdDJMLg3RYWq6arutgxr1IB2dXFZxM9YY48jGcnj+KookGpIQlhD0cAta2aCTBZtXOJG7t4iNSGnMDxHDbFilKd3endq1AR3nqFVb/Ur3PA8Q/RBmz5N4eDKJDak0r26r2+Az1QlZwjo9Q6lg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by MWHPR12MB1200.namprd12.prod.outlook.com (2603:10b6:300:9::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.17; Thu, 5 May
 2022 06:46:58 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::fdba:2c6c:b9ab:38f]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::fdba:2c6c:b9ab:38f%4]) with mapi id 15.20.5206.025; Thu, 5 May 2022
 06:46:57 +0000
Message-ID: <1f1773a8-88f4-e034-4453-ddcc2c17e4c3@amd.com>
Date: Thu, 5 May 2022 08:46:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] drm/amdgpu: make scratch_get/free more general
Content-Language: en-US
To: Lang Yu <Lang.Yu@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220505032022.3197203-1-Lang.Yu@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <20220505032022.3197203-1-Lang.Yu@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS8P250CA0005.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:20b:330::10) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4f2400c1-dae5-45ee-7e14-08da2e630c80
X-MS-TrafficTypeDiagnostic: MWHPR12MB1200:EE_
X-Microsoft-Antispam-PRVS: <MWHPR12MB1200D6128176AA9DB6BF44FB83C29@MWHPR12MB1200.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jWqz6PxaWL86292RVPN39qNefYRXGEx0Kzf6a0nXz+pHLf8SiWKALEbUjDjfqyzxcyWzkvjz3SCGQLLsaJ4TGxWhwb8Ali4A9lHd7lLlAxJZ9XD4SAqc+rAB++SYMe6/OVOdvXDtF1bPdwyKrLqvPwttfluCgKFuo0vUx7MNric/ERJLkJ1xSBO++af5n0ilAT0r3WF1dZapPI5PVZML8HWFF14bOfdiqrYjSfj+J69s5yu9kWnqjVLjayH0jxe+d3K9hjrW4k1FdYZWVVyf0SGwsOXgCtD6LvxOk+XV5HX1cUVFGrn4czhBdsikiE4CG4nZyRhi+imJ4PJqoSkUjm6IcE2o1SwstkY7NmKwUBZ4/OsvajzskhdUc1h8fiClC+KWhkNahTk5NoXAVqusGRMAEXGew/lbXbNcsrbr7NxEYc8xrf6cJ4lWdg/0LdJW+t5seF49X0LN5RtW3P0QtE27vWa4cZIOX0kBY+wSlHfYLhNy/DGkbOJgbIJ5spsN6OvLluY1VNW2d0ZkamAhWvDGJdX3nHykq2KlivhRVcxkXOTDm5UpubZ3P3CsbjbhxvzbL6uJznwXuJpmEIG3lpbmLRxA5P0506oVEFgrBVVdvefgYLjJhCW22dz9JZYHGxRL7xmJmlH+LPXS0zSOVzXAZAhy9kdQwtMF1Z7Zvq122lo8pLTTY4EsHBSyDqBo6qH/jF8XnJ7tsnJSjpWWbi/z+416dpY5HDHD7b0UUol+Nw2S+hkoTwPOE70nq4LP
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(508600001)(8676002)(66946007)(4326008)(2616005)(66476007)(66556008)(8936002)(2906002)(186003)(5660300002)(83380400001)(31686004)(316002)(31696002)(54906003)(36756003)(6512007)(86362001)(26005)(6506007)(6666004)(38100700002)(6486002)(30864003)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cjJjNVhXOC9aSW9CaFphZWlQTzhOV3NucnRCQ2JNSlRmckdGTjBMQjI2aVpj?=
 =?utf-8?B?OGhGRSswT3E3MC9ZaFl5NjFLOERoVi9lUUVIa3JSR2NSRW9KaXZ2NHJZbVNY?=
 =?utf-8?B?YTg0ZDdwcjVPNlh2THhhQ2c2UmRta2xxamxBclMxM2pZWmpCN2NEdFBRZmV0?=
 =?utf-8?B?NGVaYTdYN0VHTUZnVGI5eUVBbldISmVBajVtejJaNlFqdE5Ra3BtSXhGR1Za?=
 =?utf-8?B?UXNONUNva1BSb2drN1doaFJqVEhMTUQwWjdQa3FNRG1weS9OalRHNUtEanp2?=
 =?utf-8?B?T0ZBUUY2WHdCcWxzbk1wZkRvM0VrNUZWSzZiYWt2M0tTUzhiN09YbWJsMkxF?=
 =?utf-8?B?Rk5iNDZweUlLMGJCNGtUN0lNRVF1ZVBpY0l6SGVFVVZoazNZdFI4cmowMjMz?=
 =?utf-8?B?UFZadytrQ2hOTDRNTXRQS0M1Z2wzVGwzdnpob01mVzhDdk9SOGgrdi9qbW5J?=
 =?utf-8?B?cUNaYW9FQzB2QWZBOThCbGIxaDVoZVBTWkJIZGUyWjYyZEY0UXp3S2RGQWRm?=
 =?utf-8?B?UzBBRUNkOHJwb3F5aEhlQlNiWmJwbEVJU0YySERLb1ZRdTRnLzNEbHJOQU03?=
 =?utf-8?B?WE90THZxcnBJZHBTWFpZMkN6K254alViQVFBQkg3NWkxazBzYk1qdW92ZHdB?=
 =?utf-8?B?ZVh3dGNiUVZVcHZ6YWxYTUZOMlhudnFrU3lpNm0wNHcvWGVUSDQzVnZBRVdh?=
 =?utf-8?B?MDNlSFMxc0w1eUY2SlNiVXRlbk5WZHJUajQrb0xCUmdnbDdCVUt6MGUrb3hr?=
 =?utf-8?B?Z25pSStRZ2FCaHVscWUrT2ZmQjFHbmdUYlpaUEtKcUNzQzgzOWNjaFJ1K0tl?=
 =?utf-8?B?NWhkcVdUdzZ2eWtid1pMZjZCNzAvdmNBcmdJOTVLMnc1ZGRvSjVGdGhKeVds?=
 =?utf-8?B?T3lUb0VlOXZ1dFFWdWN3a1c1dCtBUVFOb2JRNEpkN1djcmUxL0ovYXVxcTJa?=
 =?utf-8?B?T0ZZNzRiR3pQNUdhMUI2M05oNnIvTjBEdEk2UGZ4MHAzOVhvcjhGVDJQWjVD?=
 =?utf-8?B?V1QzUTY1M3dYNlE0ZFVUOEVXdEtPYTJ0ckVnV1pUUnE1SC9oeEJCU3ZsUVhr?=
 =?utf-8?B?TDJXOHVPTzgvWlJPaW1rdCtCT0twa3c0MFJsZXFnLzZ1cjMzNEdzSk5iQzJR?=
 =?utf-8?B?TWdieU1ubjVoK2dUaW1jMDZSd2hBaTJpSmQxelVReTRGbHNkN1BETmYzNWk4?=
 =?utf-8?B?eEMvRG1UUXZHbUJrSllJRTZ1ak56NGlyT3p1dVcvUElKT1pRSDdwS1AzWlRa?=
 =?utf-8?B?dGNycU1pbVRsMzY4aGRqUG5kd1lTZ2pJdVhJYnBnZ1JLeW11eDdzVHlsNmxK?=
 =?utf-8?B?TDF4Q2kvRlh3emhZc2F6WU5IZHFXQ1ZZRm1GejE2MU1JZGJVbmI4U2hzUENO?=
 =?utf-8?B?cG9vN3NxbWFWZXFlSkhUbEJUM3pwR0hkQXZ4cnA4KzlmcjNWZlBOLzNtZGlT?=
 =?utf-8?B?ay9WY1R3ZFcrRjJsQnBvSTJQQ2N6WDVRRjJoaXBaRTN4a3J3RW93Z0RtMy9a?=
 =?utf-8?B?bTB6azNtMmhMYlZLTVdITFdMdUdLWWNJZlJIYzZxNGF5SmF5c0lZRXE5RFdP?=
 =?utf-8?B?ZnlJNVhRZVdkOWNJdm9zVnBla3dKam9YLzZ3QllISGF4dSt0UFZ0Z1ROYUlZ?=
 =?utf-8?B?NDhHNlV3a2dPbXN5ai9TN0ttS1FoR0w5YnlkRVdxb3M2anNFQ3p4QzduVit3?=
 =?utf-8?B?cWJTQnF0bU9EdEFobjZwUXlya3RxT2trMzFHenpQRHM3clRxT0RCVHB6dTBo?=
 =?utf-8?B?NzV4WDI0cEoyc3lITmdHTkpKWVRTRm16QW9DUDBwM2tjMklsQkpNQ1hMb1dP?=
 =?utf-8?B?cVAybnVoVmh6SWt4QnduRjFzNVpoSFVVUDRHUFZLaFlrTlo2TFg3TEprcVdK?=
 =?utf-8?B?SklBYm4yd2VySVRUUHZ0SnVnTjQ5aTZlcHBqaUZzciswNG85a3ZqQlV1VURT?=
 =?utf-8?B?QzdLT05jOVkvMng1TGp6WDQxdmRtQnd3UDhnOFRSVUVmRTFCenk3OFFVSWlO?=
 =?utf-8?B?VUx5UVU0ckl3bXVmVmtJQzl4R1U4V2ZEOG80NGdIM1hidWpsb3p2ZGxjb0xl?=
 =?utf-8?B?Z1NXQlh5a1I3RThLWjlYUytUWUpqQStNanhRdjEwZ0JWU2tNYlBqTjQwcjRG?=
 =?utf-8?B?enRLSmNGVktHdXhPZkRqNHZrb1BMekdsVEVwU2RDWXlDeGVPdExYNHBPSWI5?=
 =?utf-8?B?NFpnVFRHa0g1WUEva08vc3RXVVU4bDdVajlkYUdxUzI0OFJOMmhNNnlodHdB?=
 =?utf-8?B?c3MwbnVOTmNGN2lwazJqSnIxWUp4N2RCaEVvNnhjNGpONmRTRjNQb3Q3L0M4?=
 =?utf-8?B?RnpGc0FtTy9FekRBSldPVm9zN01oSlQzbGNHazlMNk5xTE1FNVMrZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f2400c1-dae5-45ee-7e14-08da2e630c80
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2022 06:46:57.3983 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2TxI1srJxsANMK7bZyH+UL1CxhC/6IELs+c4kE9nlDd5sbAlPD+2Y5Ufikc2KY8F
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1200
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Huang Rui <ray.huang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 05.05.22 um 05:20 schrieb Lang Yu:
> Then other IPs can use this utility.

Oh, we intentionally move the scratch register handling from the device 
code into the GFX code a few years ago.

Why is that suddenly necessary here again?

Regards,
Christian.

>
> Signed-off-by: Lang Yu <Lang.Yu@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  3 ++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 36 ++++++++++++++++++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c    | 36 ----------------------
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h    | 12 --------
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h   |  9 ++++++
>   drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c     |  6 ++--
>   drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c     |  6 ++--
>   drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c      |  8 ++---
>   drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c      |  8 ++---
>   drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c      |  4 +--
>   drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c      |  4 +--
>   11 files changed, 66 insertions(+), 66 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index 578a405f777c..2f85d5a228a9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -1272,6 +1272,9 @@ u32 amdgpu_device_pcie_port_rreg(struct amdgpu_device *adev,
>   void amdgpu_device_pcie_port_wreg(struct amdgpu_device *adev,
>   				u32 reg, u32 v);
>   
> +int amdgpu_device_scratch_get(struct amdgpu_scratch *scratch, uint32_t *reg);
> +void amdgpu_device_scratch_free(struct amdgpu_scratch *scratch, uint32_t reg);
> +
>   /* atpx handler */
>   #if defined(CONFIG_VGA_SWITCHEROO)
>   void amdgpu_register_atpx_handler(void);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index e582f1044c0f..abbccede3586 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -5846,3 +5846,39 @@ void amdgpu_device_pcie_port_wreg(struct amdgpu_device *adev,
>   	(void)RREG32(data);
>   	spin_unlock_irqrestore(&adev->pcie_idx_lock, flags);
>   }
> +
> +/**
> + * amdgpu_device_scratch_get - Allocate a scratch register
> + *
> + * @scratch: amdgpu_scratch pointer
> + * @reg: scratch register mmio offset
> + *
> + * Allocate a scratch register for use by the driver (all asics).
> + * Returns 0 on success or -EINVAL on failure.
> + */
> +int amdgpu_device_scratch_get(struct amdgpu_scratch *scratch, uint32_t *reg)
> +{
> +	int i;
> +
> +	i = ffs(scratch->free_mask);
> +	if (i != 0 && i <= scratch->num_reg) {
> +		i--;
> +		scratch->free_mask &= ~(1u << i);
> +		*reg = scratch->reg_base + i;
> +		return 0;
> +	}
> +	return -EINVAL;
> +}
> +
> +/**
> + * amdgpu_device_scratch_free - Free a scratch register
> + *
> + * @scratch: amdgpu_scratch pointer
> + * @reg: scratch register mmio offset
> + *
> + * Free a scratch register allocated for use by the driver (all asics)
> + */
> +void amdgpu_device_scratch_free(struct amdgpu_scratch *scratch, uint32_t reg)
> +{
> +	scratch->free_mask |= 1u << (reg - scratch->reg_base);
> +}
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> index 5d6b04fc6206..ede2fa56f6c9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> @@ -98,42 +98,6 @@ bool amdgpu_gfx_is_me_queue_enabled(struct amdgpu_device *adev,
>   			adev->gfx.me.queue_bitmap);
>   }
>   
> -/**
> - * amdgpu_gfx_scratch_get - Allocate a scratch register
> - *
> - * @adev: amdgpu_device pointer
> - * @reg: scratch register mmio offset
> - *
> - * Allocate a CP scratch register for use by the driver (all asics).
> - * Returns 0 on success or -EINVAL on failure.
> - */
> -int amdgpu_gfx_scratch_get(struct amdgpu_device *adev, uint32_t *reg)
> -{
> -	int i;
> -
> -	i = ffs(adev->gfx.scratch.free_mask);
> -	if (i != 0 && i <= adev->gfx.scratch.num_reg) {
> -		i--;
> -		adev->gfx.scratch.free_mask &= ~(1u << i);
> -		*reg = adev->gfx.scratch.reg_base + i;
> -		return 0;
> -	}
> -	return -EINVAL;
> -}
> -
> -/**
> - * amdgpu_gfx_scratch_free - Free a scratch register
> - *
> - * @adev: amdgpu_device pointer
> - * @reg: scratch register mmio offset
> - *
> - * Free a CP scratch register allocated for use by the driver (all asics)
> - */
> -void amdgpu_gfx_scratch_free(struct amdgpu_device *adev, uint32_t reg)
> -{
> -	adev->gfx.scratch.free_mask |= 1u << (reg - adev->gfx.scratch.reg_base);
> -}
> -
>   /**
>    * amdgpu_gfx_parse_disable_cu - Parse the disable_cu module parameter
>    *
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> index 45522609d4b4..54455961720b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> @@ -110,15 +110,6 @@ struct amdgpu_kiq {
>   	const struct kiq_pm4_funcs *pmf;
>   };
>   
> -/*
> - * GPU scratch registers structures, functions & helpers
> - */
> -struct amdgpu_scratch {
> -	unsigned		num_reg;
> -	uint32_t                reg_base;
> -	uint32_t		free_mask;
> -};
> -
>   /*
>    * GFX configurations
>    */
> @@ -376,9 +367,6 @@ static inline u32 amdgpu_gfx_create_bitmask(u32 bit_width)
>   	return (u32)((1ULL << bit_width) - 1);
>   }
>   
> -int amdgpu_gfx_scratch_get(struct amdgpu_device *adev, uint32_t *reg);
> -void amdgpu_gfx_scratch_free(struct amdgpu_device *adev, uint32_t reg);
> -
>   void amdgpu_gfx_parse_disable_cu(unsigned *mask, unsigned max_se,
>   				 unsigned max_sh);
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> index 7d89a52091c0..7d09842730cd 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> @@ -102,6 +102,15 @@ struct amdgpu_sched {
>   	struct drm_gpu_scheduler	*sched[AMDGPU_MAX_HWIP_RINGS];
>   };
>   
> +/*
> + * GPU scratch registers structures, functions & helpers
> + */
> +struct amdgpu_scratch {
> +	uint32_t		num_reg;
> +	uint32_t                reg_base;
> +	uint32_t		free_mask;
> +};
> +
>   /*
>    * Fences.
>    */
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> index 64d36622ee23..bd5b2e1ab2c3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> @@ -3792,7 +3792,7 @@ static int gfx_v10_0_ring_test_ring(struct amdgpu_ring *ring)
>   	unsigned i;
>   	int r;
>   
> -	r = amdgpu_gfx_scratch_get(adev, &scratch);
> +	r = amdgpu_device_scratch_get(&adev->gfx.scratch, &scratch);
>   	if (r) {
>   		DRM_ERROR("amdgpu: cp failed to get scratch reg (%d).\n", r);
>   		return r;
> @@ -3804,7 +3804,7 @@ static int gfx_v10_0_ring_test_ring(struct amdgpu_ring *ring)
>   	if (r) {
>   		DRM_ERROR("amdgpu: cp failed to lock ring %d (%d).\n",
>   			  ring->idx, r);
> -		amdgpu_gfx_scratch_free(adev, scratch);
> +		amdgpu_device_scratch_free(&adev->gfx.scratch, scratch);
>   		return r;
>   	}
>   
> @@ -3826,7 +3826,7 @@ static int gfx_v10_0_ring_test_ring(struct amdgpu_ring *ring)
>   	if (i >= adev->usec_timeout)
>   		r = -ETIMEDOUT;
>   
> -	amdgpu_gfx_scratch_free(adev, scratch);
> +	amdgpu_device_scratch_free(&adev->gfx.scratch, scratch);
>   
>   	return r;
>   }
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> index c5655128fd9c..c6d33d6be778 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> @@ -313,7 +313,7 @@ static int gfx_v11_0_ring_test_ring(struct amdgpu_ring *ring)
>   	unsigned i;
>   	int r;
>   
> -	r = amdgpu_gfx_scratch_get(adev, &scratch);
> +	r = amdgpu_device_scratch_get(&adev->gfx.scratch, &scratch);
>   	if (r) {
>   		DRM_ERROR("amdgpu: cp failed to get scratch reg (%d).\n", r);
>   		return r;
> @@ -325,7 +325,7 @@ static int gfx_v11_0_ring_test_ring(struct amdgpu_ring *ring)
>   	if (r) {
>   		DRM_ERROR("amdgpu: cp failed to lock ring %d (%d).\n",
>   			  ring->idx, r);
> -		amdgpu_gfx_scratch_free(adev, scratch);
> +		amdgpu_device_scratch_free(&adev->gfx.scratch, scratch);
>   		return r;
>   	}
>   
> @@ -351,7 +351,7 @@ static int gfx_v11_0_ring_test_ring(struct amdgpu_ring *ring)
>   	if (i >= adev->usec_timeout)
>   		r = -ETIMEDOUT;
>   
> -	amdgpu_gfx_scratch_free(adev, scratch);
> +	amdgpu_device_scratch_free(&adev->gfx.scratch, scratch);
>   
>   	return r;
>   }
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
> index 29a91b320d4f..896bbf50a494 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
> @@ -1794,7 +1794,7 @@ static int gfx_v6_0_ring_test_ring(struct amdgpu_ring *ring)
>   	unsigned i;
>   	int r;
>   
> -	r = amdgpu_gfx_scratch_get(adev, &scratch);
> +	r = amdgpu_device_scratch_get(&adev->gfx.scratch, &scratch);
>   	if (r)
>   		return r;
>   
> @@ -1820,7 +1820,7 @@ static int gfx_v6_0_ring_test_ring(struct amdgpu_ring *ring)
>   		r = -ETIMEDOUT;
>   
>   error_free_scratch:
> -	amdgpu_gfx_scratch_free(adev, scratch);
> +	amdgpu_device_scratch_free(&adev->gfx.scratch, scratch);
>   	return r;
>   }
>   
> @@ -1909,7 +1909,7 @@ static int gfx_v6_0_ring_test_ib(struct amdgpu_ring *ring, long timeout)
>   	uint32_t tmp = 0;
>   	long r;
>   
> -	r = amdgpu_gfx_scratch_get(adev, &scratch);
> +	r = amdgpu_device_scratch_get(&adev->gfx.scratch, &scratch);
>   	if (r)
>   		return r;
>   
> @@ -1946,7 +1946,7 @@ static int gfx_v6_0_ring_test_ib(struct amdgpu_ring *ring, long timeout)
>   	amdgpu_ib_free(adev, &ib, NULL);
>   	dma_fence_put(f);
>   err1:
> -	amdgpu_gfx_scratch_free(adev, scratch);
> +	amdgpu_device_scratch_free(&adev->gfx.scratch, scratch);
>   	return r;
>   }
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
> index ac3f2dbba726..b60e3bcba050 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
> @@ -2087,7 +2087,7 @@ static int gfx_v7_0_ring_test_ring(struct amdgpu_ring *ring)
>   	unsigned i;
>   	int r;
>   
> -	r = amdgpu_gfx_scratch_get(adev, &scratch);
> +	r = amdgpu_device_scratch_get(&adev->gfx.scratch, &scratch);
>   	if (r)
>   		return r;
>   
> @@ -2111,7 +2111,7 @@ static int gfx_v7_0_ring_test_ring(struct amdgpu_ring *ring)
>   		r = -ETIMEDOUT;
>   
>   error_free_scratch:
> -	amdgpu_gfx_scratch_free(adev, scratch);
> +	amdgpu_device_scratch_free(&adev->gfx.scratch, scratch);
>   	return r;
>   }
>   
> @@ -2359,7 +2359,7 @@ static int gfx_v7_0_ring_test_ib(struct amdgpu_ring *ring, long timeout)
>   	uint32_t tmp = 0;
>   	long r;
>   
> -	r = amdgpu_gfx_scratch_get(adev, &scratch);
> +	r = amdgpu_device_scratch_get(&adev->gfx.scratch, &scratch);
>   	if (r)
>   		return r;
>   
> @@ -2396,7 +2396,7 @@ static int gfx_v7_0_ring_test_ib(struct amdgpu_ring *ring, long timeout)
>   	amdgpu_ib_free(adev, &ib, NULL);
>   	dma_fence_put(f);
>   err1:
> -	amdgpu_gfx_scratch_free(adev, scratch);
> +	amdgpu_device_scratch_free(&adev->gfx.scratch, scratch);
>   	return r;
>   }
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> index e4e779a19c20..d268522b743c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> @@ -850,7 +850,7 @@ static int gfx_v8_0_ring_test_ring(struct amdgpu_ring *ring)
>   	unsigned i;
>   	int r;
>   
> -	r = amdgpu_gfx_scratch_get(adev, &scratch);
> +	r = amdgpu_device_scratch_get(&adev->gfx.scratch, &scratch);
>   	if (r)
>   		return r;
>   
> @@ -875,7 +875,7 @@ static int gfx_v8_0_ring_test_ring(struct amdgpu_ring *ring)
>   		r = -ETIMEDOUT;
>   
>   error_free_scratch:
> -	amdgpu_gfx_scratch_free(adev, scratch);
> +	amdgpu_device_scratch_free(&adev->gfx.scratch, scratch);
>   	return r;
>   }
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> index 06182b7e4351..a383808b566f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> @@ -999,7 +999,7 @@ static int gfx_v9_0_ring_test_ring(struct amdgpu_ring *ring)
>   	unsigned i;
>   	int r;
>   
> -	r = amdgpu_gfx_scratch_get(adev, &scratch);
> +	r = amdgpu_device_scratch_get(&adev->gfx.scratch, &scratch);
>   	if (r)
>   		return r;
>   
> @@ -1024,7 +1024,7 @@ static int gfx_v9_0_ring_test_ring(struct amdgpu_ring *ring)
>   		r = -ETIMEDOUT;
>   
>   error_free_scratch:
> -	amdgpu_gfx_scratch_free(adev, scratch);
> +	amdgpu_device_scratch_free(&adev->gfx.scratch, scratch);
>   	return r;
>   }
>   

