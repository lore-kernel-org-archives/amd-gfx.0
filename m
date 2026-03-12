Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C1B1FED2D1
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Mar 2026 05:44:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0405B10E1A4;
	Thu, 12 Mar 2026 05:44:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="DtuoMGER";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011048.outbound.protection.outlook.com [52.101.57.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9B21E10E1A4
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Mar 2026 05:44:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OmQVXHSHQ5/Dw4VHvkMtbVxG5qAvor+w586EwdEl2uPSRR4GTanQsOaH1qHszxRhTdpqz342Bb8bUeK56IsuwOp7v0FcbrnVKynNPt0JNXt+AYjQ0M7KhQYyPITw6blhaNcwa0Bo/Z92KP5i1DfEvWAhirakV5PM97wlopaiu69HsAntNR6785v+0kaTwugLz6BqNb8ZbhQB0DTvbOq74wc+2fSg5EtMK7i1zS+mNm1LKdJ2BsRBd4Mi8ulzzK6Tj0Vih+6OgFJiOIE3tYBl4T3VumWg387z/O05gWm+fCnuYh+m/0PdlyOs3BgYbFlb6sXdp//Er+zGBLECKg/aDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/P1LVk4q7woMKDUoSOVps2cOIGhax52OJisAJl8Hq/o=;
 b=XswrJYONhh3sbDg0rw+sK+sNztCPEZtWdz107kI1geOqdk0Z5Yv85YsTuIX0shKkRSAXB+hqDfPdDKDJMRSMPeB4RFZ4vy6kaMk86e1761diTld9viuT0c+Zhns3IMPQcKd+xT2KxjAoXwUlH+pp6d9mu0Csu+t3hBGcFdxDQofDtcd21n698dqjwAgQG82ye10EUu3HVCkBXIly4o4MEtrEXjdxHlot8yASsA6NvJJQ+b3gU3FTU0/A0WPDG3Ab4ZEke39RyuWdVhUiCLkfKIiwrIT3xUmpsCJqppwOpFSEh2Sk8T0NJ6bMgYdy47Ocusrr51G39XEUAtWdNdtKnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/P1LVk4q7woMKDUoSOVps2cOIGhax52OJisAJl8Hq/o=;
 b=DtuoMGERtX4JGNaSnccNu4e1S0kj21d1jUsNTavk00onbPB5xV4uGeG6syWwR7TqhH5sLUOnuDMiqXWIeo1n2beWfs4DvUZjBL75krv4h3PNjRg8L+5+s0nSiJ3/b6eBV/2uh7WxUEvXs+Ucw83+gl3YI+ZkPVIq4bPWp/dxD0M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by IA0PPF1D04084C7.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::bca) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.12; Thu, 12 Mar
 2026 05:44:43 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc%6]) with mapi id 15.20.9723.000; Thu, 12 Mar 2026
 05:44:43 +0000
Message-ID: <946d46d1-3778-4261-b1c4-9ccd60133246@amd.com>
Date: Thu, 12 Mar 2026 11:14:38 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] drm/amdgpu: avoid KIQ HDP flush from VM CPU commit
 during reset
To: "Xie, Chenglei" <Chenglei.Xie@amd.com>
Cc: "Chan, Hing Pong" <Jeffrey.Chan@amd.com>,
 "Luo, Zhigang" <Zhigang.Luo@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Yang, Philip" <philip.yang@amd.com>
References: <8738adb8-9c4a-45d3-b515-08c7cfbc5b29@amd.com>
 <20260311193123.2531557-1-Chenglei.Xie@amd.com>
 <SJ1PR12MB61212CEE0DBA45B1BD76768A8047A@SJ1PR12MB6121.namprd12.prod.outlook.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <SJ1PR12MB61212CEE0DBA45B1BD76768A8047A@SJ1PR12MB6121.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA1PR01CA0162.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:71::32) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|IA0PPF1D04084C7:EE_
X-MS-Office365-Filtering-Correlation-Id: 8cf4a6ec-b974-43ca-d731-08de7ffa762f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7053199007|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: Xn5N+53G/qkP4+j9XjVGk7LBG3vQo/fgIbnrhzcQixGBM4C9X9q3nfKVEBhtvhIznjKuUW8TIfPVZ1j2YzH2iQvhdJgL+mE5Bi5gHY4EM09camLNXLTT+aFSyFO3IHC98CCKihl1vd7LvuSU9rFKrC67Ua7OIlTHYaisOYxRrW2zQk5AgzHX0lQVdOVii1pK8kocYMczze4qiG4MHO7I/GYRqsiCbmN/FvUy9SnlMxZ/6g5NJiQtIYsAIO8jQ7G5ITpHWuk6L//0nBK8/YC1zQjMJ8R3tzufkvIbYNpCDE9ed4FTYqsddu2hfgVBrUwxrhpP+v/MGzuQp9uheNMt4e90ZWS/hWXEk14i2gGUiwsz5E27xK3iZyUOuNUNT1fskM/AaMPFQX4P97IAKL3+LvLP6r/v9dg8Qo9L685QMDYufKQ2eKt0W8upgvSSg/rzRbqYJscBCQpxlx8X4kd+0LMF+xhYqIjCSbZEAjUxp8Wt/1hBIQrG8vys8EHITD1dgd72k+8SomQ3XlS5eRCESOgbVMmKzhZt98B/jOFL1zYU8h1NuxBeo8Ron/7hWtssoMkC9Y75jFkV09ate9wuTQlHr29v6VC+oHor7IAwYICjTuvRG/dp91s6Y7PYvO2rRD4PfWtjXwH9YaOEYwYKKHPUsuxRt2FZOGAZu8AvcUqctfzxUHA1JuU0EZLybVm/tSDZhH2qLFqOtLYwfUsW0iipEY2ZCnqTAoRvYZt97dM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZjlFNmtNUThCM1d3c05SbkRJMlB2d3BHZmNnZ0E2VDJNOFpXdXVrNHQwRmJ2?=
 =?utf-8?B?UGNnUE1IRHNSUFVLbVMyUVR5Rjk5WkIrUGlhdmw1amNSYTBsekpHcmlKRmpY?=
 =?utf-8?B?a1RMcHVqNnVBTXphQ2pxUnZiVFR3TW5iL3VJbVRzMm9FK2I3V0sxQlUwOTZu?=
 =?utf-8?B?QkliMGpGZk5pUisvdmNtaGVSRFFuM1FLdGRtaCthbXpKQlN3YXo1NFJtendB?=
 =?utf-8?B?bDJBNVdBRTVWaGhpdmliMGdhd0NpdUx0WHZ5U2hZR2kvdUFNQXJvYWY3N1Fk?=
 =?utf-8?B?ZzkvWjZVd256TGV5S1ZMa1BCNzZCMjk2MHMwdUpxZGNRYjUzTWVpY0dMWkZO?=
 =?utf-8?B?aHdNbk1ET090V2t4QnBueEtWN0Y1L2dDS2RkKzlvcExYeWN2cTJ4RkdpU1Bp?=
 =?utf-8?B?S0Q3UjI5RE54eDUwYkNlUUQyVURpNHNsL3ZXYm1wZHhFM3hleVBkWnJmNEcy?=
 =?utf-8?B?aHdWNU9qNXNMVExpaWp4c0l6b1lrWStENVMzaGxXM1ZBVGg0dndGWWs5MWZv?=
 =?utf-8?B?ZGxQNzBwV2J6YVIwSlFRdXRmeWZQUUxjSVc5L1l3THpwWWZyQXFUK2ZSbDZE?=
 =?utf-8?B?UHRvYnBLZlJsbTVYck1kc0R3bEpTbnFWeEx4R0o1L3BtYlVIOTF5QzVLQUI2?=
 =?utf-8?B?citaS3VuZFo4dGlmdmcvQkJ5d0NlbnBSOGZQNTg3SzhOVnJvUnROUXlCVWlT?=
 =?utf-8?B?aGF6MElhNDhkanBEN1NqY01DOXR1bEllV1kwSnlYZ2dRQlpQVWhXcERwcVJu?=
 =?utf-8?B?c01jaEtXZEdnY2l0ZS9jQ2QwK3F5MThkdzg2anZzb25jRjE2UFh0cGdKUzRu?=
 =?utf-8?B?Kyt3NXBtUFYzeDV6UldrOUxlYVhUa05vQ3p0NUhtbXFnbXN3OGJMa1ZjWkIr?=
 =?utf-8?B?U2Q0bytkd3Jtd1pkaVp0WUUrclhBZ2lXbk5mdzJiWmJSVFZ1WHNCYm5UMU01?=
 =?utf-8?B?SjNpSzlNQ2lUSHVraUJUK2M3c2pGWmREcFdoMXRJaHViZk4zM2JJVjFGeFdB?=
 =?utf-8?B?YUpKSWFYdkxxMnVOc1d6MHc0WmUvcVFjUVQrNzZtbURrVkI0ZWx4MjB0QUtL?=
 =?utf-8?B?Rk1rMnhKcStoK2lLZ3NCMTNRb1ZUTFZud2x0ZEtuQkRFajR1RHdGSjgySS9N?=
 =?utf-8?B?NUs1ZUdTMGJWM0N5aFNTR3NWeFVvQ0NIakNOYi9qUFRKRnB5cDN5S05Mc3lj?=
 =?utf-8?B?MWZORUhKRDV2OXBYTVhOMjZleHNxc3E2Rm1JRDBLYko2S1JzVk1iNHh0Y3hk?=
 =?utf-8?B?azgwdm94YzNqVEI5NnJlbFZCaHhkS01QaTQ1OCt5S0ZxM3p1THRFbXNVTTRz?=
 =?utf-8?B?R2RsT214VXE5Y01ISlhtdkhlWlg2RW1IUnBiVmpsRU1jc2FPL3NtR2YwQ3JR?=
 =?utf-8?B?SUdsbWpYMjhWRjF6c0xrcGtKZkhkeWNwemR2Qkl0Ymtzcm1KMHRwRUg1amRx?=
 =?utf-8?B?MnlaSmVxbzNyelExZWE4dU5zb3ozZENnWWxiS09ERjcrYXVXMytJZmRxUHls?=
 =?utf-8?B?OG4yUWRVWCtWZms3VExIQXE2blpBSlJyWThZaG84bDZ0UWxzUklFNDE5czNl?=
 =?utf-8?B?U3FNWHBsbVFvWnhqaFhUTkpkMGdKNDZMaDFMcGI2clQrYTZDMm9kblBYOHg2?=
 =?utf-8?B?a09oRGh4SmNGOTFoRGgyZDM5YTZVVWhwWmJEYkRFb3ZUcjR1Q0J2RG5iVXow?=
 =?utf-8?B?Q3FVVThzcWhXMEUxT1RnSHZmL0htc2RRZG9QekxnKzBPU1RXOEJDUFdKc2tF?=
 =?utf-8?B?TGZVTmNneXlUcURhTFlaN1RpOEV0NSsxajV5YXQ0NXB6Zk5oODBzd2czYW9m?=
 =?utf-8?B?aHhrVktpTFd1MGdESUdmUDA0Tm5SUGNkYnJNRitLLytjRGpZcndCK0x6Sk5E?=
 =?utf-8?B?UmM5bGh5aDJveENXMmZRaWZaNlFqRTEzaGQyeFpLNnNsTnRNVExzTG1rNFFL?=
 =?utf-8?B?KzI5WWxmZGc0T1ZVenFyOEpnSGdWNU9VbUdjWUZnSWRoWnpxdGZNd2VRRE83?=
 =?utf-8?B?WHJ5NHJWSWRqUmVEaTE1WFNscTd6K1FFOXZ1QzliT1RqbzIzZmY5all2bzg3?=
 =?utf-8?B?VkNVTzVjQTlNdTJCNWN4WURTWGkyNFhrT042MVNHNE5tZWdUdlVac3RYUlFD?=
 =?utf-8?B?UUg3V2lsdmwrcmN2UGxRYTRQYzNnRmpINmN5NGZVYXVnV1E5dGJyWGdWOXFK?=
 =?utf-8?B?KzlPdTBUMStZWjIrOEkzaVZ2Yno5NUJHTGZrOFFYVzZRMXRwYTR2emlYL2JW?=
 =?utf-8?B?eUZDbERqK2FvWkdoVmR2MVdzclhwb2lkME5BQTRybndJZllWYVlvSjNMbkRz?=
 =?utf-8?B?MW9XL1ZCL25HOWFTNHVkM0VHM29yQm5sQXRGbWpLWmhXOVJWOC9Jdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cf4a6ec-b974-43ca-d731-08de7ffa762f
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2026 05:44:43.6404 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N4kNv2rE2/wr79JYymVJlpFxRpWhMzWL0yA25bDD5EZHUcHBZnEgVFxigcArtvOM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPF1D04084C7
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



On 12-Mar-26 1:10 AM, Xie, Chenglei wrote:
> [AMD Official Use Only - AMD Internal Distribution Only]
> 
> Hi Lijo,
> 
> Please help review the latest patch version. The faulty source is the amdgpu_vm_cpu_commit() requests too many HDP flush commands to KIQ due to VM page table updates during reset.

Do you have a dmesg log for this trace? If this is happening after 
hardware reset is initiated, it needs a closer look. We don't expect 
page table commits while hardware reset is ongoing. Copying Philip.

> The new change fix this by using non-KIQ HDP flush path when in reset, and added extra fence force completion on KIQ rings during SRIOV pre_reset.

If I remember correctly, the reason to introduce KIQ based HDP flush was 
that the direct ones don't work for multi-VF cases. I think you cannot 
replace one with the other just for flush happening in reset scenarios.

Thanks,
Lijo

> 
> Thanks,
> Chenglei
> 
> -----Original Message-----
> From: Xie, Chenglei <Chenglei.Xie@amd.com>
> Sent: Wednesday, March 11, 2026 3:31 PM
> To: Lazar, Lijo <Lijo.Lazar@amd.com>
> Cc: Chan, Hing Pong <Jeffrey.Chan@amd.com>; Luo, Zhigang <Zhigang.Luo@amd.com>; amd-gfx@lists.freedesktop.org; Xie, Chenglei <Chenglei.Xie@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com>
> Subject: [PATCH v4] drm/amdgpu: avoid KIQ HDP flush from VM CPU commit during reset
> 
> During GPU reset (SR-IOV), amdgpu_vm_cpu_commit() is called repeatedly for VM page table updates. Each call uses amdgpu_device_flush_hdp(adev, NULL), which on SRIOV runtime takes the KIQ path and submits a fence to the KIQ ring. That floods the KIQ ring while the GPU is resetting. After reset, hardware has cleared the queue and those fences are lost, but fence writeback memory and sync_seq are out of sync, so amdgpu_fence_emit_polling() can hit -ETIMEDOUT and block further KIQ use.
> 
> Fix:
> - In amdgpu_vm_cpu_commit(), when the device is in reset,
>    use the non-KIQ HDP flush path (amdgpu_hdp_flush) instead of
>    amdgpu_device_flush_hdp so VM updates during reset do not submit to the
>    KIQ ring.
> - In amdgpu_virt_pre_reset(), force completion on all KIQ ring fences so any
>    pending fences are signalled before reset. The other rings were handled in amdgpu_device_pre_asic_reset()
> 
> Signed-off-by: Chenglei Xie <Chenglei.Xie@amd.com>
> Change-Id: I95404ce348ad546ddff1ea3b95a3f790299eb7aa
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c   | 11 +++++++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm_cpu.c |  7 ++++++-
>   2 files changed, 17 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> index f01f385091083..5998e0a04d760 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> @@ -1191,9 +1191,20 @@ enum amdgpu_sriov_vf_mode amdgpu_virt_get_sriov_vf_mode(struct amdgpu_device *ad
> 
>   void amdgpu_virt_pre_reset(struct amdgpu_device *adev)  {
> +       int i;
> +
>          /* stop the data exchange thread */
>          amdgpu_virt_fini_data_exchange(adev);
>          amdgpu_dpm_set_mp1_state(adev, PP_MP1_STATE_FLR);
> +
> +       /* Force completion on KIQ ring fences so pending fences are signalled. */
> +       for (i = 0; i < AMDGPU_MAX_GC_INSTANCES; i++) {
> +               struct amdgpu_ring *ring = &adev->gfx.kiq[i].ring;
> +
> +               if (!ring->fence_drv.initialized)
> +                       continue;
> +               amdgpu_fence_driver_force_completion(ring);
> +       }
>   }
> 
>   void amdgpu_virt_post_reset(struct amdgpu_device *adev) diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_cpu.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_cpu.c
> index 22e2e5b473415..50ab9f9604834 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_cpu.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_cpu.c
> @@ -21,6 +21,7 @@
>    */
> 
>   #include "amdgpu_vm.h"
> +#include "amdgpu.h"
>   #include "amdgpu_object.h"
>   #include "amdgpu_trace.h"
> 
> @@ -112,7 +113,11 @@ static int amdgpu_vm_cpu_commit(struct amdgpu_vm_update_params *p,
>                  atomic64_inc(&p->vm->tlb_seq);
> 
>          mb();
> -       amdgpu_device_flush_hdp(p->adev, NULL);
> +       /* Avoid KIQ during reset; use non-KIQ HDP flush */
> +       if (amdgpu_in_reset(p->adev))
> +               amdgpu_hdp_flush(p->adev, NULL);
> +       else
> +               amdgpu_device_flush_hdp(p->adev, NULL);
>          return 0;
>   }
> 
> --
> 2.34.1
> 

