Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19403C25B50
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Jan 2023 21:12:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9215D10E087;
	Fri, 20 Jan 2023 21:12:08 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2084.outbound.protection.outlook.com [40.107.223.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 01A1710E087
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Jan 2023 21:12:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NXBHlOabGzMtnKNK1TfuZCr7LzOAwUrRFY2y7cYTsTzWMUeX75bPvI+KAiVXrviQRX9XckM2lEISfH1hfTr5xUaauda4x6YvtAb7qDctSTUHaeDE0+T3fZC6twqCmaMbobk0g3vdHI0O/oh4gU8+3ziAwU0ycv48krzy5H8QXcGPfDB29eBBEc+lLD1utTRcO8sQPp1SFopTlm7e4GWiFnIqnzb1OFKTi9zdLFxnnV4+wV6yISEG4zdeIIoopzkdLO+gr/Vz4Kh1xI29SAUCGZGD3+RxA4a2YFH4HWxizw6WGcsT+KPm0ab+w4z1rO54HsA5+vpG4tDv+uKALvoWgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0hriVzl4RalNaiMCmBcgHJu5sOpWSAnlc8CZveXRabY=;
 b=jt31H1lZyFPgFsR/pFdQ5zWBBz43D2HJ1gViU2XUUMBTMQapT8OrBFAoW5w2kbtjmolCOAOvBHnYkYEYDfzjr4aovDwrjZcmVFb9BRB/UBq2BiKN4YIoeAVV1+g2Ay4oF/nea1zeH8RF2lUNkhct15m9GhOmlpyDEnZ+bH1q06aKRsjbm/6i20oV8gBARYD8pNkpQKTBsGsiyQp2dX66VhTkl8f/eem6h+9Ry2revZKFB+sDyTZtXTVInbvGtVvkRxqtOSAOQQvx7OmTIbMyquBJXv9gitswYcrxe5LgKdCvsOvoLf+ZBu7Ywvi6TukPSeb2+9Tuzdtnff71bduNhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0hriVzl4RalNaiMCmBcgHJu5sOpWSAnlc8CZveXRabY=;
 b=tSprSyMeE2jKVFFmqRel+z0tUQ6E50s4oJEVaIt4QGFsb3x1J51HGyeSEchY4DT4H92P/WAz72n0ijFvDh7SNVW+BVylqEKWeLCssvfAEWf3G0ntT6EnXv8V2EYV8c+JT9knsmzqyVC0laMChGLl64x9ZJPHOU12tYHL50lAfzI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.27; Fri, 20 Jan
 2023 21:11:56 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::c3f5:aede:fa4d:5411]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::c3f5:aede:fa4d:5411%4]) with mapi id 15.20.6002.027; Fri, 20 Jan 2023
 21:11:56 +0000
Message-ID: <1bee6da6-fd6e-e251-757b-feb626be803e@amd.com>
Date: Fri, 20 Jan 2023 16:11:53 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCHv2] drm/amdgpu: Enable IH retry CAM on GFX9
Content-Language: en-US
To: Mukul Joshi <mukul.joshi@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230119215918.3629146-1-mukul.joshi@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <20230119215918.3629146-1-mukul.joshi@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0301.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:6d::10) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|BL1PR12MB5144:EE_
X-MS-Office365-Filtering-Correlation-Id: b980eda4-aaf7-4414-e52c-08dafb2af601
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MKyLgFgt0dYlRJ+LByPavqIrovK1/ADsTjR2nSkHQ7RsJKKSB9kVJ6P0KOfDF1HGRA5MwuXn36F86WBbt6aGvEoOj8uqVD8XAkz//YAZvml3Sk2bSZ6c+LpxbwtLUoAZzXpUNjMlWLqbCkqFviq4UDAm7AUn5g5F2NMf67mjDV1n9mgViZ4w/nvn5KpDmSmZZktUb9PxljE4WLMxlG+BsWJzUDcwYSnYhkJK4twSUzXdS4mBNFds6EKFT19Vk4vJtPEogG6b5CZ6DkmYotcIiQyE85MHVlOC2DDdjbkRXYa5DZ2DSfAz6QGfFH25WXF1w8N9SvvEMSEApIRkQ/7abYuS7HNDsXuDJmQ9uAw/BptjK/ujFK7UrkxlIx3/hO9A1U6Vjf25mzeLdG2Vv43OCY9owYbIL8vpy3ptwJYWr1dd6xn0wq56kikSLfI9cKu0pUjtuCJ88mK2dAOytD80B9uO718Km4TW7zMUzuyKJPuZ4IVyGXTs8wUNrYCBkKRarRahCZjg+/Sq4cDAfbhrxqBXXLyYVYdxE4sNOlhhQEyhG/KPmMfBmLzna3LO+CdsfoqKAvMK+R7hstmYsxYzBKntgcppQmBGVnsj7rTaZhcIZvicVlKivQNHMQ8KojSLHPW3DYR5wa8CkreqjKefYF4F1LtPd8ocYFV3+nod+y6BuO5McKbALqlBufTaqgt56q83hVn/DFfbmgvvQuQVF0ao30+A7ooFJ4YI1/LK1YA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(376002)(346002)(396003)(366004)(39860400002)(136003)(451199015)(8676002)(66476007)(316002)(36756003)(31696002)(86362001)(6666004)(83380400001)(6486002)(186003)(478600001)(38100700002)(6512007)(26005)(2616005)(30864003)(8936002)(6506007)(2906002)(44832011)(66556008)(5660300002)(66946007)(41300700001)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WDI0MllteUpmNkJyWmswYURSbGs5aXJSNVFyS0xxNlQydjFPU1UrRWx5Rjc2?=
 =?utf-8?B?NDUwTlUvV2UwdUtCNnFxK3JiMGNaak01RFBFWnZ3SmVPQXJpZUY1NnBLajJ3?=
 =?utf-8?B?Y292MUtnZ1NnRjNIaURWcVZ2Ym1vQXdUSjlvR2xMcUtUTXYySHcySnh0Yks0?=
 =?utf-8?B?U1FjMGpzcmtmdWN1SFNzYm5wTU9sTWJZcUhDUTlzN2VlOUsrL01ncVluT01q?=
 =?utf-8?B?dWpPUU01aWcxa0R2Q0NnREQ4OENHSmJpTUY3eERqRnJxeXYzTlZoTUdGQ2o4?=
 =?utf-8?B?cDRiTis5Q0x6TjkwVXQ4bmxVZURwU3JhS1AreTFUU3ZpdFVvbDQ4ZUJzQ3Jn?=
 =?utf-8?B?Vms4MGxiM25PSzRrdmtPSEdRaUppZDhsb2h6YkVkZVhMUHFXOUQ0bGw0SzRR?=
 =?utf-8?B?UmFvVU9SRWVnQ3gzZ0VxVkNlM0lIdmhGbjJGYW9YbjZTOVNTcFE4VFcvUlZn?=
 =?utf-8?B?UDhCSXhpUkwxUDRwTlhKY2tkdlR5WFVzVWw0dDFlSHBDTUltNGJEalpDZFQx?=
 =?utf-8?B?VkhSdG9MbmVDUWpMTlVIZGRhRjFEVHFBS3htdTJsU0k3RGZaZHhEcXBwQ1NW?=
 =?utf-8?B?NWhrM3FIRkkyUHJHdDV5VHkzbGVTdWM5eUdLdEV4RXFRTG9ETytzOVEvbU1y?=
 =?utf-8?B?eEZuS08yVndFaVRtVldqbGIyZ1RLb1JVa253ZXN4cmwweHNqWUlhZWxadGhh?=
 =?utf-8?B?WEZubUhqcU8wOW1hajZNZjM1Q2FDTDdYYnZxMWo0YlNpMURNSUtXWVZXaU5t?=
 =?utf-8?B?VWpMZUkzbTllZkYzMTJMZmJBcmlsSHRGeGJwVG9VT1RGNEJTU1lpb3ptZUYy?=
 =?utf-8?B?WXRrNnkyVFVjRDFvc1BaZ3U4VXBFdmIvUlM3TlRscHhxZHRwbkVvc3ZmZWtS?=
 =?utf-8?B?Kzd2cnMzZFI4c3pXbkRyQ1RFbWd1MnFzbTVSd3JQOUpENEV6VHVxN1BwT1hp?=
 =?utf-8?B?bXVLUEsxNVhLNWs0aW5SKysvNmZzZEtkM3kvRlpMZU4rUFAyK1YzSEdYakZn?=
 =?utf-8?B?R3ZDWkduVDBURlowU1U5NzFrc1liOWJVTkdoYUtHWUdnR09oNVdOQjFQRysx?=
 =?utf-8?B?YzZoSDNWS2VHTnIyWjNXdksvK3RFWmNBVFJRblZ4M1RRbGtRVFRudXZHUVhU?=
 =?utf-8?B?VXJCSk9ZS2VZQytIcnBmdXZ1UzVtY00xWlRxSm5zNE1zbzczZVg2K0JVQzJ0?=
 =?utf-8?B?eW9xSTU5anRtUGlXZTFmR25FbGNySS9NdDl6Rzh6aDhsN3NYek51UllPaVkr?=
 =?utf-8?B?SHVqM29NZUlERk9rRWZwQUwzRXNiU1o0eWZ3a0FSYlRPbGg4eWhZT1REanpp?=
 =?utf-8?B?a29FWnVSa05TTGNFRlRJWWg5SG9wUU53K291M0ZTT2NpcCtIeFlhSXUwbS9p?=
 =?utf-8?B?THd5U2xKZGVLK0R0K0FYSkI4ZmYyQThDOElOOEtuTTdyd2p0WUFPek96Z1gx?=
 =?utf-8?B?dFJ1enBKK2JsZVFiZEhyZFJOOVdoNys1ZzZPLyt6YnBOMGdwUG04enZLUTli?=
 =?utf-8?B?ZmJDa2FPMDJmWFhHZWM2OUdzR3RBaWpveUZ0WVBPdlJ4T010Z0lFQ096S29Y?=
 =?utf-8?B?Z3kvb3pnNktTLzhBQnlleDFuazJWbktXQlFZVW5CQ0xCL3g4V2JuWnJ3Tlln?=
 =?utf-8?B?VWtmZXkxQk1rdnluODRsR002ZktFczhrNXo1TTQ2b3hyN1ZPSytIbkxJZlQ4?=
 =?utf-8?B?eVdMVDZJMk9kUmhsTkNnSGpHSjc4eTgzVUczZTVoKytLdVpoMUNkVDJlMkJT?=
 =?utf-8?B?TWx0aFNOTUZXNytwV1JYWFhLMHNicnp0UDNyRFMwRExWd0xDQ2ttTGpLckpl?=
 =?utf-8?B?aDNkdlpXT2dZSFh0R2x1NDNIOGx3bUlOVkhValdidGZ6QTVIODZUVUpSUjRG?=
 =?utf-8?B?MmtJRHhYRFJoRzVLclRrWjBqSVB5VHZtaVc4Z1pBdTRkRmM4ZWtUSUxZQXA0?=
 =?utf-8?B?WHRKeXhJZ3k0YzEwMVUveVkzM0d0U0x0a0tZd0ZtRHFHREtkand6RzF3dUp0?=
 =?utf-8?B?dGlLSFdKaEZmdkRIK2FFbU9PbVdWOTFHdnczMG5aMGxoZFV0akZxNGNGUW9z?=
 =?utf-8?B?eVUxYUpOL1ZSYjY1aEpKK1BUQk4xbzN3UHE3TVFZWkRINFZYZzNJQnpPd01L?=
 =?utf-8?Q?ocpcpjq/5oqDZHux7waTDcTUE?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b980eda4-aaf7-4414-e52c-08dafb2af601
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2023 21:11:56.1801 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xaH7P1yTP6lss5/wwjeUpJn/+q4o2BR7NCbUhSdSuwaC3UKygmynivNfgWg5p7GwkYCOVjXHw63MeZ1UfLUy7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5144
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

Am 2023-01-19 um 16:59 schrieb Mukul Joshi:
> This patch enables the IH retry CAM on GFX9 series cards. This
> retry filter is used to prevent sending lots of retry interrupts
> in a short span of time and overflowing the IH ring buffer. This
> will also help reduce CPU interrupt workload.
>
> Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


> ---
> v1:
> - Reviewed by Felix.
>
> v1->v2:
> - Update the CAM enable register offset for Aldebaran.
> - Add new register defines for Aldebaran in vega20_ih.c.
> - Drain IH0 ring also along with soft ring.
> - Setup CAM doorbell register before enabling CAM.
>
>   drivers/gpu/drm/amd/amdgpu/amdgpu_irq.h       |  2 +
>   drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c         | 51 +++++++++++------
>   drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c        |  2 +-
>   drivers/gpu/drm/amd/amdgpu/vega20_ih.c        | 55 +++++++++----------
>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c          | 10 +++-
>   .../asic_reg/oss/osssys_4_2_0_offset.h        |  6 ++
>   .../asic_reg/oss/osssys_4_2_0_sh_mask.h       | 11 ++++
>   7 files changed, 88 insertions(+), 49 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.h
> index e9f2c11ea416..be243adf3e65 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.h
> @@ -98,6 +98,8 @@ struct amdgpu_irq {
>   	struct irq_domain		*domain; /* GPU irq controller domain */
>   	unsigned			virq[AMDGPU_MAX_IRQ_SRC_ID];
>   	uint32_t                        srbm_soft_reset;
> +	u32                             retry_cam_doorbell_index;
> +	bool                            retry_cam_enabled;
>   };
>   
>   void amdgpu_irq_disable_all(struct amdgpu_device *adev);
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> index d65c6cea3445..4847117d67a1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> @@ -553,32 +553,49 @@ static int gmc_v9_0_process_interrupt(struct amdgpu_device *adev,
>   	const char *mmhub_cid;
>   	const char *hub_name;
>   	u64 addr;
> +	uint32_t cam_index = 0;
> +	int ret;
>   
>   	addr = (u64)entry->src_data[0] << 12;
>   	addr |= ((u64)entry->src_data[1] & 0xf) << 44;
>   
>   	if (retry_fault) {
> -		/* Returning 1 here also prevents sending the IV to the KFD */
> +		if (adev->irq.retry_cam_enabled) {
> +			/* Delegate it to a different ring if the hardware hasn't
> +			 * already done it.
> +			 */
> +			if (entry->ih == &adev->irq.ih) {
> +				amdgpu_irq_delegate(adev, entry, 8);
> +				return 1;
> +			}
> +
> +			cam_index = entry->src_data[2] & 0x3ff;
>   
> -		/* Process it onyl if it's the first fault for this address */
> -		if (entry->ih != &adev->irq.ih_soft &&
> -		    amdgpu_gmc_filter_faults(adev, entry->ih, addr, entry->pasid,
> +			ret = amdgpu_vm_handle_fault(adev, entry->pasid, addr, write_fault);
> +			WDOORBELL32(adev->irq.retry_cam_doorbell_index, cam_index);
> +			if (ret)
> +				return 1;
> +		} else {
> +			/* Process it onyl if it's the first fault for this address */
> +			if (entry->ih != &adev->irq.ih_soft &&
> +			    amdgpu_gmc_filter_faults(adev, entry->ih, addr, entry->pasid,
>   					     entry->timestamp))
> -			return 1;
> +				return 1;
>   
> -		/* Delegate it to a different ring if the hardware hasn't
> -		 * already done it.
> -		 */
> -		if (entry->ih == &adev->irq.ih) {
> -			amdgpu_irq_delegate(adev, entry, 8);
> -			return 1;
> -		}
> +			/* Delegate it to a different ring if the hardware hasn't
> +			 * already done it.
> +			 */
> +			if (entry->ih == &adev->irq.ih) {
> +				amdgpu_irq_delegate(adev, entry, 8);
> +				return 1;
> +			}
>   
> -		/* Try to handle the recoverable page faults by filling page
> -		 * tables
> -		 */
> -		if (amdgpu_vm_handle_fault(adev, entry->pasid, addr, write_fault))
> -			return 1;
> +			/* Try to handle the recoverable page faults by filling page
> +			 * tables
> +			 */
> +			if (amdgpu_vm_handle_fault(adev, entry->pasid, addr, write_fault))
> +				return 1;
> +		}
>   	}
>   
>   	if (!printk_ratelimit())
> diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c b/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c
> index 19455a725939..685abf57ffdd 100644
> --- a/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c
> +++ b/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c
> @@ -238,7 +238,7 @@ static void nbio_v7_4_ih_doorbell_range(struct amdgpu_device *adev,
>   
>   	if (use_doorbell) {
>   		ih_doorbell_range = REG_SET_FIELD(ih_doorbell_range, BIF_IH_DOORBELL_RANGE, OFFSET, doorbell_index);
> -		ih_doorbell_range = REG_SET_FIELD(ih_doorbell_range, BIF_IH_DOORBELL_RANGE, SIZE, 4);
> +		ih_doorbell_range = REG_SET_FIELD(ih_doorbell_range, BIF_IH_DOORBELL_RANGE, SIZE, 8);
>   	} else
>   		ih_doorbell_range = REG_SET_FIELD(ih_doorbell_range, BIF_IH_DOORBELL_RANGE, SIZE, 0);
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/vega20_ih.c b/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
> index 1706081d054d..6a8fb1fb48a3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
> @@ -38,6 +38,11 @@
>   #define mmIH_CHICKEN_ALDEBARAN			0x18d
>   #define mmIH_CHICKEN_ALDEBARAN_BASE_IDX		0
>   
> +#define mmIH_RETRY_INT_CAM_CNTL_ALDEBARAN		0x00ea
> +#define mmIH_RETRY_INT_CAM_CNTL_ALDEBARAN_BASE_IDX	0
> +#define IH_RETRY_INT_CAM_CNTL_ALDEBARAN__ENABLE__SHIFT	0x10
> +#define IH_RETRY_INT_CAM_CNTL_ALDEBARAN__ENABLE_MASK	0x00010000L
> +
>   static void vega20_ih_set_interrupt_funcs(struct amdgpu_device *adev);
>   
>   /**
> @@ -251,36 +256,14 @@ static int vega20_ih_enable_ring(struct amdgpu_device *adev,
>   	return 0;
>   }
>   
> -/**
> - * vega20_ih_reroute_ih - reroute VMC/UTCL2 ih to an ih ring
> - *
> - * @adev: amdgpu_device pointer
> - *
> - * Reroute VMC and UMC interrupts on primary ih ring to
> - * ih ring 1 so they won't lose when bunches of page faults
> - * interrupts overwhelms the interrupt handler(VEGA20)
> - */
> -static void vega20_ih_reroute_ih(struct amdgpu_device *adev)
> +static uint32_t vega20_setup_retry_doorbell(u32 doorbell_index)
>   {
> -	uint32_t tmp;
> +	u32 val = 0;
>   
> -	/* vega20 ih reroute will go through psp this
> -	 * function is used for newer asics starting arcturus
> -	 */
> -	if (adev->ip_versions[OSSSYS_HWIP][0] >= IP_VERSION(4, 2, 1)) {
> -		/* Reroute to IH ring 1 for VMC */
> -		WREG32_SOC15(OSSSYS, 0, mmIH_CLIENT_CFG_INDEX, 0x12);
> -		tmp = RREG32_SOC15(OSSSYS, 0, mmIH_CLIENT_CFG_DATA);
> -		tmp = REG_SET_FIELD(tmp, IH_CLIENT_CFG_DATA, CLIENT_TYPE, 1);
> -		tmp = REG_SET_FIELD(tmp, IH_CLIENT_CFG_DATA, RING_ID, 1);
> -		WREG32_SOC15(OSSSYS, 0, mmIH_CLIENT_CFG_DATA, tmp);
> -
> -		/* Reroute IH ring 1 for UTCL2 */
> -		WREG32_SOC15(OSSSYS, 0, mmIH_CLIENT_CFG_INDEX, 0x1B);
> -		tmp = RREG32_SOC15(OSSSYS, 0, mmIH_CLIENT_CFG_DATA);
> -		tmp = REG_SET_FIELD(tmp, IH_CLIENT_CFG_DATA, RING_ID, 1);
> -		WREG32_SOC15(OSSSYS, 0, mmIH_CLIENT_CFG_DATA, tmp);
> -	}
> +	val = REG_SET_FIELD(val, IH_DOORBELL_RPTR, OFFSET, doorbell_index);
> +	val = REG_SET_FIELD(val, IH_DOORBELL_RPTR, ENABLE, 1);
> +
> +	return val;
>   }
>   
>   /**
> @@ -332,8 +315,6 @@ static int vega20_ih_irq_init(struct amdgpu_device *adev)
>   
>   	for (i = 0; i < ARRAY_SIZE(ih); i++) {
>   		if (ih[i]->ring_size) {
> -			if (i == 1)
> -				vega20_ih_reroute_ih(adev);
>   			ret = vega20_ih_enable_ring(adev, ih[i]);
>   			if (ret)
>   				return ret;
> @@ -346,6 +327,20 @@ static int vega20_ih_irq_init(struct amdgpu_device *adev)
>   
>   	pci_set_master(adev->pdev);
>   
> +	/* Allocate the doorbell for IH Retry CAM */
> +	adev->irq.retry_cam_doorbell_index = (adev->doorbell_index.ih + 3) << 1;
> +	WREG32_SOC15(OSSSYS, 0, mmIH_DOORBELL_RETRY_CAM,
> +		vega20_setup_retry_doorbell(adev->irq.retry_cam_doorbell_index));
> +
> +	/* Enable IH Retry CAM */
> +	if (adev->ip_versions[OSSSYS_HWIP][0] == IP_VERSION(4, 4, 0))
> +		WREG32_FIELD15(OSSSYS, 0, IH_RETRY_INT_CAM_CNTL_ALDEBARAN,
> +			       ENABLE, 1);
> +	else
> +		WREG32_FIELD15(OSSSYS, 0, IH_RETRY_INT_CAM_CNTL, ENABLE, 1);
> +
> +	adev->irq.retry_cam_enabled = true;
> +
>   	/* enable interrupts */
>   	ret = vega20_ih_toggle_interrupts(adev, true);
>   	if (ret)
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> index 859159093ffd..5c67f177dc6c 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> @@ -2171,7 +2171,15 @@ static void svm_range_drain_retry_fault(struct svm_range_list *svms)
>   		pr_debug("drain retry fault gpu %d svms %p\n", i, svms);
>   
>   		amdgpu_ih_wait_on_checkpoint_process_ts(pdd->dev->adev,
> -						     &pdd->dev->adev->irq.ih1);
> +				pdd->dev->adev->irq.retry_cam_enabled ?
> +				&pdd->dev->adev->irq.ih :
> +				&pdd->dev->adev->irq.ih1);
> +
> +		if (pdd->dev->adev->irq.retry_cam_enabled)
> +			amdgpu_ih_wait_on_checkpoint_process_ts(pdd->dev->adev,
> +				&pdd->dev->adev->irq.ih_soft);
> +
> +
>   		pr_debug("drain retry fault gpu %d svms 0x%p done\n", i, svms);
>   	}
>   	if (atomic_cmpxchg(&svms->drain_pagefaults, drain, 0) != drain)
> diff --git a/drivers/gpu/drm/amd/include/asic_reg/oss/osssys_4_2_0_offset.h b/drivers/gpu/drm/amd/include/asic_reg/oss/osssys_4_2_0_offset.h
> index bd129266ebfd..a84a7cfaf71e 100644
> --- a/drivers/gpu/drm/amd/include/asic_reg/oss/osssys_4_2_0_offset.h
> +++ b/drivers/gpu/drm/amd/include/asic_reg/oss/osssys_4_2_0_offset.h
> @@ -135,6 +135,8 @@
>   #define mmIH_RB_WPTR_ADDR_LO_BASE_IDX                                                                  0
>   #define mmIH_DOORBELL_RPTR                                                                             0x0087
>   #define mmIH_DOORBELL_RPTR_BASE_IDX                                                                    0
> +#define mmIH_DOORBELL_RETRY_CAM                                                                        0x0088
> +#define mmIH_DOORBELL_RETRY_CAM_BASE_IDX                                                               0
>   #define mmIH_RB_CNTL_RING1                                                                             0x008c
>   #define mmIH_RB_CNTL_RING1_BASE_IDX                                                                    0
>   #define mmIH_RB_BASE_RING1                                                                             0x008d
> @@ -159,6 +161,8 @@
>   #define mmIH_RB_WPTR_RING2_BASE_IDX                                                                    0
>   #define mmIH_DOORBELL_RPTR_RING2                                                                       0x009f
>   #define mmIH_DOORBELL_RPTR_RING2_BASE_IDX                                                              0
> +#define mmIH_RETRY_CAM_ACK                                                                             0x00a4
> +#define mmIH_RETRY_CAM_ACK_BASE_IDX                                                                    0
>   #define mmIH_VERSION                                                                                   0x00a5
>   #define mmIH_VERSION_BASE_IDX                                                                          0
>   #define mmIH_CNTL                                                                                      0x00c0
> @@ -235,6 +239,8 @@
>   #define mmIH_MMHUB_ERROR_BASE_IDX                                                                      0
>   #define mmIH_MEM_POWER_CTRL                                                                            0x00e8
>   #define mmIH_MEM_POWER_CTRL_BASE_IDX                                                                   0
> +#define mmIH_RETRY_INT_CAM_CNTL                                                                        0x00e9
> +#define mmIH_RETRY_INT_CAM_CNTL_BASE_IDX                                                               0
>   #define mmIH_REGISTER_LAST_PART2                                                                       0x00ff
>   #define mmIH_REGISTER_LAST_PART2_BASE_IDX                                                              0
>   #define mmSEM_CLK_CTRL                                                                                 0x0100
> diff --git a/drivers/gpu/drm/amd/include/asic_reg/oss/osssys_4_2_0_sh_mask.h b/drivers/gpu/drm/amd/include/asic_reg/oss/osssys_4_2_0_sh_mask.h
> index 3ea83ea9ce3a..75c04fc275a0 100644
> --- a/drivers/gpu/drm/amd/include/asic_reg/oss/osssys_4_2_0_sh_mask.h
> +++ b/drivers/gpu/drm/amd/include/asic_reg/oss/osssys_4_2_0_sh_mask.h
> @@ -349,6 +349,17 @@
>   #define IH_DOORBELL_RPTR_RING2__ENABLE__SHIFT                                                                 0x1c
>   #define IH_DOORBELL_RPTR_RING2__OFFSET_MASK                                                                   0x03FFFFFFL
>   #define IH_DOORBELL_RPTR_RING2__ENABLE_MASK                                                                   0x10000000L
> +//IH_RETRY_INT_CAM_CNTL
> +#define IH_RETRY_INT_CAM_CNTL__CAM_SIZE__SHIFT                                                                0x0
> +#define IH_RETRY_INT_CAM_CNTL__BACK_PRESSURE_SKID_VALUE__SHIFT                                                0x8
> +#define IH_RETRY_INT_CAM_CNTL__ENABLE__SHIFT                                                                  0x10
> +#define IH_RETRY_INT_CAM_CNTL__BACK_PRESSURE_ENABLE__SHIFT                                                    0x11
> +#define IH_RETRY_INT_CAM_CNTL__PER_VF_ENTRY_SIZE__SHIFT                                                       0x14
> +#define IH_RETRY_INT_CAM_CNTL__CAM_SIZE_MASK                                                                  0x0000001FL
> +#define IH_RETRY_INT_CAM_CNTL__BACK_PRESSURE_SKID_VALUE_MASK                                                  0x00003F00L
> +#define IH_RETRY_INT_CAM_CNTL__ENABLE_MASK                                                                    0x00010000L
> +#define IH_RETRY_INT_CAM_CNTL__BACK_PRESSURE_ENABLE_MASK                                                      0x00020000L
> +#define IH_RETRY_INT_CAM_CNTL__PER_VF_ENTRY_SIZE_MASK                                                         0x00300000L
>   //IH_VERSION
>   #define IH_VERSION__MINVER__SHIFT                                                                             0x0
>   #define IH_VERSION__MAJVER__SHIFT                                                                             0x8
