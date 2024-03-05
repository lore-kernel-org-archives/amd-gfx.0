Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EC3BC54798
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Mar 2024 09:40:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AB27211299F;
	Tue,  5 Mar 2024 09:40:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="rOagUI60";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2067.outbound.protection.outlook.com [40.107.244.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D6C8511299F
 for <amd-gfx@lists.freedesktop.org>; Tue,  5 Mar 2024 09:40:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BCjEqxDEoyy6uO9oFiVf/X+Qixs2POiwQVoJHxqk/SOdxgQjCI946wPGv5SJqKBPXvHEsAAx2i0T1UHUJVER98K9xqRWzPOAE+Yq39M+xlqWgghffhiMqMbfwENC+NGdkAwruiId/q9o/evikWg+XivjcNsly/Kt/bhmAmipM7P3kyYZKwNdgMb4ohDbo9Z3RsvKn3+wiOuOne9EZOo0LeFcazeGt/eg/QkNOpmF/I4Gbf0nF83mDY/yPa2tPi/sFVD/Wb9cNiPmaas3x0mB/3I5jSYUYBKeZOZcN4Lyz6toz35jQ8sDKZYlcRjTOSjqDNsrl7TXfB54V7cmvAd+1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iaMKJyE3pyQ5Aweih6EJw1pmYx17W6FcV9+1CEP3LW4=;
 b=T/azpYvTWE1fnX/m/LPN4LpEDneV91AThyczlNYVSDlbkUl8/HBCCq2ARwA953EwkJHFUpCt2jXaEG3v04kvtni+e2i4DmEny0tbBVX+3VA6nxvOXMW+hIY16/+g9MMbFQ7AT6j/2a1s3HpUaA556z109FvqVHMP8icHp05ITFrpfuxm9HMFhPMXjQD/QihPDBwV0E72uG0BAuOpGKTLVLF1PPIM3pjIO3WSmtXf9M6cAdjoAZEu6r+h7q11WocQJW+qol6h9CAmwdUWylWTXVgYtaAcZv3nn9loKenpgHtBHvt35BbFqPtHmQ7fiGdsnS6dd8zoK+FLEFTWahnCMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iaMKJyE3pyQ5Aweih6EJw1pmYx17W6FcV9+1CEP3LW4=;
 b=rOagUI60WzgZ2E68N/qDzUawnJswDTFV/A1HPgUjfQMEtZ4NIBGRNfjZmUREmNMIr+DJA02fArads4379ebBSHW4MWacF6Y2q9y2uwvXpm4f8bB1pMcbyRqjfRb3FMlIeEE0eC2+4QimcGUj3SpTkpCQkpUS/MCgavZuoT+85hE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 DS0PR12MB7897.namprd12.prod.outlook.com (2603:10b6:8:146::13) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7339.38; Tue, 5 Mar 2024 09:40:27 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::621:96e2:a3a0:486a]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::621:96e2:a3a0:486a%4]) with mapi id 15.20.7339.035; Tue, 5 Mar 2024
 09:40:27 +0000
Message-ID: <b110e652-c15c-49c1-9b59-46b8188a4220@amd.com>
Date: Tue, 5 Mar 2024 15:10:19 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] drm/amdgpu: Add HDP flush to VCN v4.0.3
Content-Language: en-US
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 amd-gfx@lists.freedesktop.org
Cc: Hawking.Zhang@amd.com, Alexander.Deucher@amd.com, samir.dhume@amd.com,
 leo.liu@amd.com
References: <20240305064031.548905-1-lijo.lazar@amd.com>
 <ea7e75ed-0060-4c40-b43a-1baecadd4ef9@gmail.com>
 <f01dea79-b5fd-4026-8b87-8c333bb01c15@amd.com>
 <aacba67b-ecab-486b-9cc6-58f7867f792c@gmail.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <aacba67b-ecab-486b-9cc6-58f7867f792c@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2P287CA0006.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:21b::12) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|DS0PR12MB7897:EE_
X-MS-Office365-Filtering-Correlation-Id: f27dac0b-27b3-4ba6-0e7b-08dc3cf849eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FofGCZQxAHCEc/NRJCNj7jafhm/VZzyLC+8aq3knfasTHTE2eskOdgAULViiOVAhHxyrHmheikNGMobET38Tasr3ZpaxQFB6coTBwoiTxGUU9VwWqlDVy2YeEdsM2Jl1OcOi5GrutRzcXuVsfrNLB7REFCMtH/jHqkkyWv7mAK+LEVxMRMMRwoSTT5vJew2x35lJox8gyJPbYXpvyYBk34UtOm4BthBCpt+WBmuzovdMre9xIOxHRjI9MuSzxIdNIK+Y9k0LLbAF8BhrSbD5HyWDXpzh5bSd3linqW9VrvHz0UlKVLspnwAbSFVcOerzPaOuEx4Vy3Yja+dD8mTizy9SfbfPY5yPVDs01e+4gRkp2gIbuge86rO7q/lxkuXG+3mFY/2tbfLsUU4UK2JH2UZSYHzMbqcsgoahaqlXo2rSiWZCeZVuQ78OiOqDkzLwSoqo9mHWE80Hs6ffkUIMO4al8pn4uP4zBExVGiNvLy1mIgqH+RY9+rTGfjBbUAS6rTenaFa17vv9bAS62FcSe8U/rwsy10iFcln4xNmztHp88Kt3pQZrbSNCAGGRhTCmq+8DZWDljWJYvTLTzIny+7P511WYz2f4Gx84Roq7m34cVUPA3lKIi2BYrckf8yYSxNmoSPczIXGlec0mm1c7JnGYDHcS9aHAQOoOCtfLB9M=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SXRqN1dVWTA1VS95cGU3TFk0dk1nM2JiTlNJUzl4cnlvaDAzUVFwRzJEYStB?=
 =?utf-8?B?Ukd3TEZXcTBsajZyL2lPQUFOWTVCUnNLNGRxcjZxak5oTTRjYUFlTVVJRG5Z?=
 =?utf-8?B?YVhCTFVoTUxFblhZeTRzOTNQUXlZeFdja1kxQjIzYjhUWWNjQ01zRy9zYkhr?=
 =?utf-8?B?OFpBbW16S0lFaTlpV3lJdHFHNU52eFRURjFISzdNcHlNbm03WEZpelRlalox?=
 =?utf-8?B?YU55cU40dy9zVFVMeU9HWlFvRlcrWkh0b2ZyWTVadTZIUTBPYlI4RTlXd3dh?=
 =?utf-8?B?N2FOUnpmay9XOGRwMnZnRG9FaSswNkhYMHFjVHhoRUlkMGJaaHVRenR3Qmlp?=
 =?utf-8?B?M2RRV0hYRFliTHlGUVNrVGdPWHRjdmlabGJlZjhXcS9KSDZUV3Nwakt6WWZR?=
 =?utf-8?B?bE55am56Mm5zcjR2L0MvUnMzS1ZSNVVyanNNcHFEZ1d4eGxpVElwSnErNFJX?=
 =?utf-8?B?NW1KTHlRbm1pempIY2Z1Tkx3M0U0bHhiTFZxVUhiN1lBMitXT3Z5dnhMRTlH?=
 =?utf-8?B?VUpXSUt5cTNHamhleU9NWmpvNFlTa0JvTVZVaGtPa012TXkwa1QzaUVjS0kw?=
 =?utf-8?B?cFFhb1NSeXArRmpFQ2pWSU9JTVJkTUxJQkVpaUdTZFlHNm91TFVPUkNRT09p?=
 =?utf-8?B?RFY0Z2YzTWIzczZpREdDUUxEMll1YktZb2VVcGp2Nkd3NnFWRVF0YUk5K3F2?=
 =?utf-8?B?bWdHcHpFZjdxYXEwYUpNSlU3VlZyTWpuYUg0VHFEZFJJcjJZenNJRS9yM2lF?=
 =?utf-8?B?WFBUZ1crc2xQakJ0Mm04ZWpxV2Frc054aE1zNjRyelc5VURZMHlzOTIyWkc1?=
 =?utf-8?B?VkNpOVhwSEZiNVc2MWNPRDV6Zk16Tkx6aFJlcU02QUEvb2pGNFV4UVhFQnd1?=
 =?utf-8?B?WllHWHJGaVRqUFBlWGJxdmxSRHVad0dnOWJENVIwaEpRZ0JLcmlGb2NoS3Uz?=
 =?utf-8?B?cWhsQ2VnTXpPbmRDUkZYalRoQ3dMdG84UHkvd29PNFM5K2NBOXcwUzhzTEVC?=
 =?utf-8?B?clhkOFVFbktQNkpBc2lpcm5FdVQ2ZEMyM2t4MjMycEVaOXZYQ29UUGJyQnRK?=
 =?utf-8?B?OEJraVZKWWx3ODF2cm1yN3dGL0MvK2lEWlZ1eS9EQWNHc3M3STBuMkdIMjFJ?=
 =?utf-8?B?SWdiSXo4QnIzWUlHdDJVL3NtaVZOTjdLTHhMeVZRVnZNYXpROS9EdFlaQlUx?=
 =?utf-8?B?ZU54clJiQk9EWndjUnd3WnU3WmRJV21LRkl2OWY3Yk1WZkZaNE9pUzl6K2tX?=
 =?utf-8?B?cjFrcFdsTDNGcGZvcVBCeUU2endHV2RsUE9aWHhHL3VKd0xLcVU5Wm1Kbjgw?=
 =?utf-8?B?WGNLdllWNjFHUFprbkFiYjZPK2JwSnFXKzh6MkhMNUlZNThUTGo2dXhZdDE2?=
 =?utf-8?B?SGdkSHhiMFJuVlZ4bkVXYTBKb0hPUDNuS0sxbVlPTWYzdU45MlN3SVY2cVBY?=
 =?utf-8?B?U2dGU0NWZFIxeXBjQ1ErS21jakZtcXZPR1czbld3cWs3RFBLb05adHM1bU1z?=
 =?utf-8?B?MitlMmdjbGcvNGIzeHJTWVlOMitzRGVDcXE2czN3Q0NPNlNtck1uanpOMHhY?=
 =?utf-8?B?bnlxVjkwWTZHcHBIKzZUc1k5RE00SHYvQk5BcEVvdTdxbzMyb1JFM1pYSjBZ?=
 =?utf-8?B?dHdiZjgzUHZ4RVNMdW9CUHhWeWxMRU5mQzJBcTc5dkxaVGlCd0UwcmNkang4?=
 =?utf-8?B?MXJ4Slh5RGp4SDZXTkRFcGFicVJWTjJIUGNzd0g5V1dzMFFRNmpROXJmK1pL?=
 =?utf-8?B?aS82aGhiblFRaG5hUURiN212VkduVzZzclhUSkwxcUpZdllJbjNPQktmSmFS?=
 =?utf-8?B?cGIrZ3E3ODA2LzRvRmxSM29WTGY4dk11YnFoQzVZZWs1MnY1M2o5eldxaHhZ?=
 =?utf-8?B?UTFLR2Q2Rm9WdmFHVzRuczhjN1B5MHBiRVYzNXlTdjl4U2Q2dUErbXc1YzJs?=
 =?utf-8?B?Y1h6enZHeWVnUldaVDhIelVpY2JpZWRkVjRtckVjTWdRbDNKdXdPSmxuR0p0?=
 =?utf-8?B?cjJ0Zk9UTEZPbXk0cEU2RUlqLzZnNzk0YUZKOUduMHhJRFczb21LSE1GbG1G?=
 =?utf-8?B?OExHYjYyS1lmdWdQb0JzYlFvN3c0VG5WMnMwakdFZDZaVzRQejBiK1RyQ0Np?=
 =?utf-8?Q?zACsEJNqvkXB95CR8wlrU1j85?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f27dac0b-27b3-4ba6-0e7b-08dc3cf849eb
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2024 09:40:27.2909 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p6ie+Cx3/E65zFM88Obm9WQ3TmwmaB+DEz7nffHW7yy9Jpjhf4IRluWspUb2/fPg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7897
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



On 3/5/2024 2:44 PM, Christian König wrote:
> Am 05.03.24 um 10:01 schrieb Lazar, Lijo:
>> On 3/5/2024 2:22 PM, Christian König wrote:
>>> Am 05.03.24 um 07:40 schrieb Lijo Lazar:
>>>> VCN 4.0.3 cannot trigger HDP flush with RRMT enabled. Instead, trigger
>>>> HDP flush from host side before ringing doorbell.
>>> Well that won't work like that.
>>>
>>> The HDP flush is supposed to be emitted into the ring buffer of the
>>> engine. If you just "emulate" it by a register write than that write
>>> comes at the wrong time.
>>>
>>> This code here is seriously broken.
>>>
>> This approach was in fact suggested by VCN IP and FW team since RRMT is
>> not working from VCN side to do a remote flush of HDP (HDP is active
>> only in one of the AIDs). They mentioned that VCN doesn't need to flush
>> HDP at the time of processing.
> 
> In this case you don't need to implement anything here.
> 
> See amdgpu_device_flush_hdp(), we already have the CPU fallback for the
> engines which don't have access to the HDP:
> 
> #ifdef CONFIG_X86_64
>         if ((adev->flags & AMD_IS_APU) && !amdgpu_passthrough(adev))
>                 return;
> #endif
>         if (adev->gmc.xgmi.connected_to_cpu)
>                 return;
> 
>         if (ring && ring->funcs->emit_hdp_flush)
>                 amdgpu_ring_emit_hdp_flush(ring);
>         else
>                 amdgpu_asic_flush_hdp(adev, ring);
> 

The recommendation was to do a HDP flush at the time of packet
submission before write pointer update. Hence we added a dummy
emit_hdp_flush() to the ring which does nothing at this point and does a
flush only before it updates write pointer.

Thanks,
Lijo

> Regards,
> Christian.
> 
>>
>> Thanks,
>> Lijo
>>
>>> Regards,
>>> Christian.
>>>
>>>> Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
>>>> ---
>>>>    drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c | 25
>>>> +++++++++++++++++++++++++
>>>>    1 file changed, 25 insertions(+)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
>>>> b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
>>>> index 810bbfccd6f2..7b5ad13b618e 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
>>>> @@ -36,6 +36,7 @@
>>>>    #include "vcn/vcn_4_0_3_offset.h"
>>>>    #include "vcn/vcn_4_0_3_sh_mask.h"
>>>>    #include "ivsrcid/vcn/irqsrcs_vcn_4_0.h"
>>>> +#include <uapi/linux/kfd_ioctl.h>
>>>>      #define mmUVD_DPG_LMA_CTL        regUVD_DPG_LMA_CTL
>>>>    #define mmUVD_DPG_LMA_CTL_BASE_IDX    regUVD_DPG_LMA_CTL_BASE_IDX
>>>> @@ -1380,6 +1381,26 @@ static uint64_t
>>>> vcn_v4_0_3_unified_ring_get_wptr(struct amdgpu_ring *ring)
>>>>                        regUVD_RB_WPTR);
>>>>    }
>>>>    +static void vcn_v4_0_3_ring_emit_hdp_flush(struct amdgpu_ring
>>>> *ring)
>>>> +{
>>>> +    /* VCN engine access for HDP flush doesn't work when RRMT is
>>>> enabled.
>>>> +     * This is a workaround to avoid any HDP flush through VCN ring.
>>>> Instead
>>>> +     * HDP flush will be done by driver while submitting doorbell.
>>>> +     */
>>>> +}
>>>> +
>>>> +static void vcn_v4_0_3_flush_hdp(struct amdgpu_ring *ring)
>>>> +{
>>>> +    struct amdgpu_device *adev = ring->adev;
>>>> +
>>>> +#ifdef CONFIG_X86_64
>>>> +    if ((adev->flags & AMD_IS_APU) && !amdgpu_passthrough(adev))
>>>> +        return;
>>>> +#endif
>>>> +    if (ring->wptr)
>>>> +        WREG32_NO_KIQ((adev->rmmio_remap.reg_offset +
>>>> KFD_MMIO_REMAP_HDP_MEM_FLUSH_CNTL) >> 2, 0);
>>>> +}
>>>> +
>>>>    /**
>>>>     * vcn_v4_0_3_unified_ring_set_wptr - set enc write pointer
>>>>     *
>>>> @@ -1394,6 +1415,9 @@ static void
>>>> vcn_v4_0_3_unified_ring_set_wptr(struct amdgpu_ring *ring)
>>>>        if (ring != &adev->vcn.inst[ring->me].ring_enc[0])
>>>>            DRM_ERROR("wrong ring id is identified in %s", __func__);
>>>>    +    /* Flush HDP before ringing doorbell */
>>>> +    vcn_v4_0_3_flush_hdp(ring);
>>>> +
>>>>        if (ring->use_doorbell) {
>>>>            *ring->wptr_cpu_addr = lower_32_bits(ring->wptr);
>>>>            WDOORBELL32(ring->doorbell_index,
>>>> lower_32_bits(ring->wptr));
>>>> @@ -1420,6 +1444,7 @@ static const struct amdgpu_ring_funcs
>>>> vcn_v4_0_3_unified_ring_vm_funcs = {
>>>>        .emit_ib = vcn_v2_0_enc_ring_emit_ib,
>>>>        .emit_fence = vcn_v2_0_enc_ring_emit_fence,
>>>>        .emit_vm_flush = vcn_v2_0_enc_ring_emit_vm_flush,
>>>> +    .emit_hdp_flush = vcn_v4_0_3_ring_emit_hdp_flush,
>>>>        .test_ring = amdgpu_vcn_enc_ring_test_ring,
>>>>        .test_ib = amdgpu_vcn_unified_ring_test_ib,
>>>>        .insert_nop = amdgpu_ring_insert_nop,
> 
