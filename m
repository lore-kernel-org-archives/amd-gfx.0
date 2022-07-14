Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88817C43334
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Jul 2022 14:36:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1C94C113209;
	Thu, 14 Jul 2022 14:36:31 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2047.outbound.protection.outlook.com [40.107.223.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A7028113209
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 Jul 2022 14:36:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BxdmbuWUyTg8gVcTH3uPP3R9YZpHIMejAPIv+z0WKQlPswLidAULPvqph9Qvujv3dli+LhIAo20pZamEJOyE6lkHfJROiuCK1BUO9YfgJiKcunRwIey1Im3srxfNrigfrvnqH6SKmQHKbYwk/GKfBHUXNjzDDMxcAdxr1dGj2C0tclPPmJbA+q9XCuhSNWSBASRPgX0RL18pWiEZMBSQO/DiIwfAjvekaxWn2UTffvAL1uyo7/QT3X+atNNZzCtKESjdLSdO4MnWJXvN6WHLkschAtcx+5YsHIwEtK+DDR0ntBv9FWj3sMRoWBG9MhC5NkUsqc2+/pcg3XVPYQoM0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1ry5qwIN2Uc1kd1hphSXZ34Ve9D5dVvKGyxV8No/LYI=;
 b=C1KXDVHYRpPSgt2cJnpR4srsdYrKpNkePBR9HH69uolSZiQWQty96sIBHpTAw27MN1mLqyJkCxWsM7Q3l0iOKhf1mgoSCUdJQjTyaj39HbdMeqempfm6ebks7RB1h4/C6q2AlW7yQKaO4WoINRgIqiI3csuUZWAYaXOG32mLHQdGsTL8HvRNsBqvkofIa59X7ooCnuoWo5pCD04n1r78R0yuDFUHxbUtFepy81DC05BGaZFdm2Ysf99LOTVnNCFS3ut6oziz4D/UiPNaqiwxoV6suY3S4DCPdMAp4FOB71dn1g+i5wkCAk12e9P9tpk5nqzpCdzcGWkCCyE2vKi1rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1ry5qwIN2Uc1kd1hphSXZ34Ve9D5dVvKGyxV8No/LYI=;
 b=e/5rKXgc8/yNtaGG6mSy3fO5s5pgxkghYdfVa54QaRm5hlqPDc/bGmHvPX2ocFTVcdUo7vxXoDd17hgrHt+vbo0Y7PNmlkORjUqOiSQxo3UaXxF5E+KQ2bqMlc/p2TlwNUW1OIEdFa0+6zQ9arBUUnDx6vtGBNxcBxKhCbfxXk0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1947.namprd12.prod.outlook.com (2603:10b6:3:111::23)
 by DS7PR12MB6215.namprd12.prod.outlook.com (2603:10b6:8:95::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5438.13; Thu, 14 Jul 2022 14:36:26 +0000
Received: from DM5PR12MB1947.namprd12.prod.outlook.com
 ([fe80::9da9:705a:18ae:5e91]) by DM5PR12MB1947.namprd12.prod.outlook.com
 ([fe80::9da9:705a:18ae:5e91%9]) with mapi id 15.20.5417.026; Thu, 14 Jul 2022
 14:36:26 +0000
Message-ID: <355b3810-a176-dbff-d5a5-c944c849382c@amd.com>
Date: Thu, 14 Jul 2022 10:36:24 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 09/10] drm/amdgpu: add gang submit backend
Content-Language: en-US
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 amd-gfx@lists.freedesktop.org, Marek.Olsak@amd.com, timur.kristof@gmail.com,
 Yogesh.Mohanmarimuthu@amd.com
References: <20220714103902.7084-1-christian.koenig@amd.com>
 <20220714103902.7084-10-christian.koenig@amd.com>
From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
In-Reply-To: <20220714103902.7084-10-christian.koenig@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT1PR01CA0061.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2e::30) To DM5PR12MB1947.namprd12.prod.outlook.com
 (2603:10b6:3:111::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1b8b9882-6022-4d19-9b8f-08da65a63b98
X-MS-TrafficTypeDiagnostic: DS7PR12MB6215:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CrKga4PLClR2+f4Tijivlu/G2SOwf6x6OxXfM6HkBk9zu8RWN91+1cST9NcLn2DVfFzJhGx1n4w66JERY+t8Fvh9gZ28jI6Pp6w1ubs5tbzAEx2SFKTgEdRTqGzSSJLko7YSbfDvmvwqeuTZtoE7GRtFCkApXTNGFdbv0E1+umpuY8q3qQAvcI1ahyodkWlV6CfidRCUXvQkzWiI1F2lRZX9XoD2QHxPlRnVaBjo+H55LSYU2ouJb/mN41gurY6cAw8vQuft210ZhkMR2w0EySu/KyfOkK1NAHZ6OPP/s18u2L2e7/MdKTP5/HhQ35gpBn6szqBGnfS6kIRdgEwtKV8TmeGa3QMZI9w6yjVVP8iuQnzV7pbzdTNQb2rfzwaVOsyfGobzKjl+BIN4i5JZznAZ2x59ZvHtE9lR90bjmq9GaKrfK3VNpMGux9KblFWrP9pyg0aV0m4GpxNQI3ak6i3CIhVFP+l/ynHvTnsznxORclOzvvt9Wk/3onnN8a/VdRDSXIRbEoNTPasCK2pFNUALmO0o/stYuLHMI9D45v8dO6LGtiovTd4nrWvoBTvJyvPsaR93+kjYV6h0+fyEi/krnyagbXNyMCyFyT0Kg11WqzY08Nnld1VGG5r7hWJ3Sj882TzdT9EupcUaThwzOfEUvAyFlBCoyuget4zZ2iiFhnEN4s9YIRP1Hoym5O8xMM6mX0xf40ggQMiq/SSIkR7IH5xwgkzgRj9OAo54cGtxVJDMVSgNbemt6B9/BxhwWi7KIiqDLXdUCwiz2JqMbcilyqXBCtkl0olZHTSBLn0bcXtogeWiv237yoZYGEdH6n5EzyYv384vivOqkXO332Rn3+BOwghd6jbgf6jKbawl8MiICmsVmwrYQc5M6buC
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1947.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(346002)(136003)(396003)(39860400002)(366004)(376002)(36756003)(31686004)(38100700002)(83380400001)(44832011)(8936002)(2906002)(66574015)(316002)(5660300002)(66946007)(2616005)(8676002)(66556008)(86362001)(4326008)(66476007)(186003)(41300700001)(6506007)(6636002)(6512007)(6486002)(966005)(478600001)(31696002)(53546011)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a0JYWmtZR2Ixc3lHV0dKbVRZRGpDSi9iS1VnNUtSQmZlRkVwWmgySHhzRnhK?=
 =?utf-8?B?c0Y1YjVha2IxbTlYaGszYkh4Q3JwODVaOStVb1FYNGtyVjVFUTJPOGh5cGhF?=
 =?utf-8?B?eWUwWGplYVRMSHR5c3VvWnBUbnVSamdSOHRidTRWREV2OE9yRmZ0bkxHTUNu?=
 =?utf-8?B?QXZLZzduWWs5eFczcTRVOWNIRnJHY2hMelo2RVlaYnA5VytFRU41SmZCSDlm?=
 =?utf-8?B?NjAyTkx6VG5oR0ladWtWY1BXQTlET1RqYVFId3pEUGdROHhVdmlsdEltV0FP?=
 =?utf-8?B?VE9BcmpmbnltL0RKN004WEp5Z0lWWmZRSk1ONER4L3lyLzUyRGJpZDlPK1R0?=
 =?utf-8?B?amQ5bGZZbFg2VXg4NGNMUHJRb2tVekJNOHlJNnVrOFZtdjJ0aXVyN1NaZTNI?=
 =?utf-8?B?MGt2aG41Z2dQTEtnRENNSThQWWlCcWUxbERlRFBIUEppa0RxaFdGUWlHWm1u?=
 =?utf-8?B?dk43TGs1VkVwTjJEVVJ0VVdWNXFnaEtjd3J0b2VzN0xCY043YnUyZ3RNUFZF?=
 =?utf-8?B?MS95TnVRTEFBaEIyRUxXQ0VFeFVQUWxBUGUwSE4vL1RpZzRsTmlPTncxV3lW?=
 =?utf-8?B?aTZwS0oyM1hSOGlCellpSlVLU1NlRUZEL0ZibS9Kemp0VXJJVXFjMnc3Zisv?=
 =?utf-8?B?TUlMOWxBMmU4T0ZRUDFNUDA4N1pzc0xUdlEwMTJvOGZRc3VITTl4UW84WXlt?=
 =?utf-8?B?NmJZaGNLMElqTzdtTXRUMUpIVklHZWpSRUdiVE1UbDYwZ013S0ZMZDFRYzVw?=
 =?utf-8?B?L2N5ZUNYT1RUYWVtdE5uc3dmUnhCV0N6VG0rTmhlYTE4MkJkWmh6TlFqTVhx?=
 =?utf-8?B?a2k3c2NlZHN3NmphaVVTSXNYTXBCdVJRQmNsa1BWZHJVbkVYTHNuUkVaQWJk?=
 =?utf-8?B?ZDlpMG5XN1ZhUEZVYzZXeng0STFPOGJtdTY5Z3RMeXdCN0FwSXlWc2E5WE1z?=
 =?utf-8?B?MXBjSEFUL1l3UlRGL1hBTmVQc3lLUTZNSjZ2R0piUWJPayszbkNuYXZnZE0w?=
 =?utf-8?B?T2pPZmQyajFQdnJGdmJzMjhIdC9JQ2I1R2FHYUdneURYSWE2Y0I1dFdLZmwr?=
 =?utf-8?B?d2lsbjVDRHJWSXJPSVljOHNJU2svQjM0dDYyVjlSYTd4WWNieVZPemxQQlJQ?=
 =?utf-8?B?bTRWOTQxUWJPaHlrTC92cnN2eTU3dmhqbmgvaVBEeFMra0thU0RwYWJDMTNI?=
 =?utf-8?B?MEFleXp6RGxkeFNUT2Z0dUtyZkxCK2pDdEg4WHpNVEgwZWtTd0hpVUlKUnl2?=
 =?utf-8?B?ZDZCUnBTZUljdk1GTzlBM1VQd01QaFhoN0IzSEM0clMxTjdBbHZhTmtxbFBH?=
 =?utf-8?B?VitmMVAxWi9tTUx2ME54bGlPMXpacU1uMC9nVWcrRmRRd3ZCdFBHLzBYQ2pW?=
 =?utf-8?B?bXFYVERMWkFQL29rb2VqNTk1eG8rTTNuRklSTEw5V3d5SDBzcjZoTEZ0ZFZC?=
 =?utf-8?B?Q05Sd0FrUWlLV0RMZ1JJYTFBYmtQbVk1OUN1dUZ5M09VYkV5WFJGbVE5RWZV?=
 =?utf-8?B?d2xOTkc3WS9FTW1Wem81Q213MUdVUURsN1htTXM0S2ZrblNKQTI2Y0xmWXRM?=
 =?utf-8?B?TzZsYnlxVDdPSkg4MWpxdTZxTFFiVDU0b1ZuU08wSVlnV0FmdFZvYmZaaXIv?=
 =?utf-8?B?YXlrL1Jyb2Y2aVNQK0VJRWxPQ1FPWXFyenlSdTBzY0c0RStHbnd3LzBGUTR0?=
 =?utf-8?B?TnJMN0pKT0FQUzhmZVFmYW04VUxwRW44RWVhSDV6SEZIUEdMc0I5T3MwQXJP?=
 =?utf-8?B?K2p1cXFWM1h2TjFOVUpJY1dTK2ZCQ1lHT0NsSmZWLzd6R2grRndqTGttc1Rk?=
 =?utf-8?B?ZmtLaTFPSG0ranVqWlljNGthejBORGpzR0p4N20yN2ZmSDRieVZuamdzWjgy?=
 =?utf-8?B?cENaWUZPbEJRQzZWSTlDcTdBSHJXVEd0UjhaUXU0RGx1QmpQc0IwWk9JajFp?=
 =?utf-8?B?LzV6bHFPdlFReDMvclBudlNYNEh0VEZ3WkQ3QW96ZmdvYnZQYjdFV2crWFIy?=
 =?utf-8?B?c3lObkQzRmVFM2NFaElIeWFDb2I2OU42RENMYXdWbEV1dEdmMWFtaUdGMkJ2?=
 =?utf-8?B?UWtpaGpiRGZEbTUyTXhSNEU1eDZWZlhmTDFpakNQVmFtT29PTTJ5WktNeGFI?=
 =?utf-8?B?N3JOdHJOOVRSb2NVZE1Ma3JxVTZOT29JNGpYc1oyZm5MQWdkS1dnZXM5UjRF?=
 =?utf-8?Q?BBx+2EsHdBc3YIZ+r7JoZE5lQZola1XAr0Pm+AWKMwFy?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b8b9882-6022-4d19-9b8f-08da65a63b98
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1947.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2022 14:36:26.6742 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fsjT9t8zks9pots8CrLQ+bGMHGNcqbpnZBqtmAU9lfv5iVZYcpwWSeVa8xVo9hbK+T0lY9ag1zCVwOk/Syew/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6215
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
Cc: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 2022-07-14 06:39, Christian König wrote:
> Allows submitting jobs as gang which needs to run on multiple
> engines at the same time.
>
> Basic idea is that we have a global gang submit fence representing when the
> gang leader is finally pushed to run on the hardware last.
>
> Jobs submitted as gang are never re-submitted in case of a GPU reset since this
> won't work and will just deadlock the hardware immediately again.
>
> Signed-off-by: Christian König <christian.koenig@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  3 ++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 34 ++++++++++++++++++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_job.c    | 28 ++++++++++++++++--
>   drivers/gpu/drm/amd/amdgpu/amdgpu_job.h    |  3 ++
>   4 files changed, 66 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index 2871a3e3801f..19308db52984 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -881,6 +881,7 @@ struct amdgpu_device {
>   	u64				fence_context;
>   	unsigned			num_rings;
>   	struct amdgpu_ring		*rings[AMDGPU_MAX_RINGS];
> +	struct dma_fence __rcu		*gang_submit;
>   	bool				ib_pool_ready;
>   	struct amdgpu_sa_manager	ib_pools[AMDGPU_IB_POOL_MAX];
>   	struct amdgpu_sched		gpu_sched[AMDGPU_HW_IP_NUM][AMDGPU_RING_PRIO_MAX];
> @@ -1288,6 +1289,8 @@ u32 amdgpu_device_pcie_port_rreg(struct amdgpu_device *adev,
>   				u32 reg);
>   void amdgpu_device_pcie_port_wreg(struct amdgpu_device *adev,
>   				u32 reg, u32 v);
> +struct dma_fence *amdgpu_device_switch_gang(struct amdgpu_device *adev,
> +					    struct dma_fence *gang);
>   
>   /* atpx handler */
>   #if defined(CONFIG_VGA_SWITCHEROO)
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index e1c9587f659b..f80beb7208c0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -3499,6 +3499,7 @@ int amdgpu_device_init(struct amdgpu_device *adev,
>   	adev->gmc.gart_size = 512 * 1024 * 1024;
>   	adev->accel_working = false;
>   	adev->num_rings = 0;
> +	RCU_INIT_POINTER(adev->gang_submit, dma_fence_get_stub());
>   	adev->mman.buffer_funcs = NULL;
>   	adev->mman.buffer_funcs_ring = NULL;
>   	adev->vm_manager.vm_pte_funcs = NULL;
> @@ -3979,6 +3980,7 @@ void amdgpu_device_fini_sw(struct amdgpu_device *adev)
>   	release_firmware(adev->firmware.gpu_info_fw);
>   	adev->firmware.gpu_info_fw = NULL;
>   	adev->accel_working = false;
> +	dma_fence_put(rcu_dereference_protected(adev->gang_submit, true));
>   
>   	amdgpu_reset_fini(adev);
>   
> @@ -5905,3 +5907,35 @@ void amdgpu_device_pcie_port_wreg(struct amdgpu_device *adev,
>   	(void)RREG32(data);
>   	spin_unlock_irqrestore(&adev->pcie_idx_lock, flags);
>   }
> +
> +/**
> + * amdgpu_device_switch_gang - switch to a new gang
> + * @adev: amdgpu_device pointer
> + * @gang: the gang to switch to
> + *
> + * Try to switch to a new gang or return a reference to the current gang if that
> + * isn't possible.
> + * Returns: Either NULL if we switched correctly or a reference to the existing
> + * gang.
> + */
> +struct dma_fence *amdgpu_device_switch_gang(struct amdgpu_device *adev,
> +					    struct dma_fence *gang)
> +{
> +	struct dma_fence *old = NULL;
> +
> +	do {
> +		dma_fence_put(old);
> +		old = dma_fence_get_rcu_safe(&adev->gang_submit);
> +
> +		if (old == gang)
> +			break;
> +
> +		if (!dma_fence_is_signaled(old))
> +			return old;
> +
> +	} while (cmpxchg((struct dma_fence __force **)&adev->gang_submit,
> +			 old, gang) != old);
> +
> +	dma_fence_put(old);
> +	return NULL;
> +}
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> index 3255b2fca611..f3a1fdbd41a3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> @@ -180,11 +180,29 @@ static void amdgpu_job_free_cb(struct drm_sched_job *s_job)
>   		kfree(job);
>   }
>   
> +void amdgpu_job_set_gang_leader(struct amdgpu_job *job,
> +				struct amdgpu_job *leader)
> +{
> +	struct dma_fence *fence = &leader->base.s_fence->scheduled;
> +
> +	WARN_ON(job->gang_submit);
> +
> +	/*
> +	 * Don't add a reference when we are the gang leader to avoid circle
> +	 * dependency.
> +	 */
> +	if (job != leader)
> +		dma_fence_get(fence);
> +	job->gang_submit = fence;
> +}
> +
>   void amdgpu_job_free(struct amdgpu_job *job)
>   {
>   	amdgpu_job_free_resources(job);
>   	amdgpu_sync_free(&job->sync);
>   	amdgpu_sync_free(&job->sched_sync);
> +	if (job->gang_submit != &job->base.s_fence->scheduled)
> +		dma_fence_put(job->gang_submit);
>   
>   	/* only put the hw fence if has embedded fence */
>   	if (job->hw_fence.ops != NULL)
> @@ -258,12 +276,16 @@ static struct dma_fence *amdgpu_job_dependency(struct drm_sched_job *sched_job,
>   		fence = amdgpu_sync_get_fence(&job->sync);
>   	}
>   
> +	if (!fence && !job->gang_submit)
> +		fence = amdgpu_device_switch_gang(ring->adev, job->gang_submit);
> +
>   	return fence;


Looks like you forgot to fix a functional 'typo' we discussed - 
https://lore.kernel.org/all/dd6839eb-da19-30fd-1422-6b0aba326e7f@amd.com/

Andrey


>   }
>   
>   static struct dma_fence *amdgpu_job_run(struct drm_sched_job *sched_job)
>   {
>   	struct amdgpu_ring *ring = to_amdgpu_ring(sched_job->sched);
> +	struct amdgpu_device *adev = ring->adev;
>   	struct dma_fence *fence = NULL, *finished;
>   	struct amdgpu_job *job;
>   	int r = 0;
> @@ -275,8 +297,10 @@ static struct dma_fence *amdgpu_job_run(struct drm_sched_job *sched_job)
>   
>   	trace_amdgpu_sched_run_job(job);
>   
> -	if (job->vram_lost_counter != atomic_read(&ring->adev->vram_lost_counter))
> -		dma_fence_set_error(finished, -ECANCELED);/* skip IB as well if VRAM lost */
> +	/* Skip job if VRAM is lost and never resubmit gangs */
> +	if (job->vram_lost_counter != atomic_read(&adev->vram_lost_counter) ||
> +	    (job->job_run_counter && job->gang_submit))
> +		dma_fence_set_error(finished, -ECANCELED);
>   
>   	if (finished->error < 0) {
>   		DRM_INFO("Skip scheduling IBs!\n");
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
> index 0bab8fe0d419..615328130615 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
> @@ -51,6 +51,7 @@ struct amdgpu_job {
>   	struct amdgpu_sync	sched_sync;
>   	struct dma_fence	hw_fence;
>   	struct dma_fence	*external_hw_fence;
> +	struct dma_fence	*gang_submit;
>   	uint32_t		preamble_status;
>   	uint32_t                preemption_status;
>   	bool                    vm_needs_flush;
> @@ -80,6 +81,8 @@ int amdgpu_job_alloc_with_ib(struct amdgpu_device *adev, unsigned size,
>   void amdgpu_job_set_resources(struct amdgpu_job *job, struct amdgpu_bo *gds,
>   			      struct amdgpu_bo *gws, struct amdgpu_bo *oa);
>   void amdgpu_job_free_resources(struct amdgpu_job *job);
> +void amdgpu_job_set_gang_leader(struct amdgpu_job *job,
> +				struct amdgpu_job *leader);
>   void amdgpu_job_free(struct amdgpu_job *job);
>   int amdgpu_job_submit(struct amdgpu_job *job, struct drm_sched_entity *entity,
>   		      void *owner, struct dma_fence **f);
