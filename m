Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 536EFECAAD4
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Aug 2022 21:57:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1DEF510E1EC;
	Tue, 30 Aug 2022 21:56:59 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2088.outbound.protection.outlook.com [40.107.243.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8B9B510E1F8
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Aug 2022 21:56:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P+/2qHtyosoxlvK4AGfxg2jix+i9OGLLq1GT1DhlAGwLxApoqy0l24ivKkKi7D2Zb3djcSkgUYhagHu4vM6DwSfP6SpHcpNviAV6gmvw2UczAR8G2EGTKAoGFC0NZAOXriPWqbUtSxLU+wpCVPYW6vFVCekNMjK/3f4gSOBwne2/jVZ8yl6p/rySbgoflkT/GfcGxyG5z5XOs0cEMXmF9G5Nc4WfK/AnjbfY1gJ4maGbi6r7vvIrjZtdacS1sgFmEyemhEn3kfVIZbxSGYaFvSoILlpbKAVKzU38dlgCOXqDJCiyQnhQ4u1FyXPWcGWuzR5GwDMUn/9V5NGUrvfk4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e18ADq7mvgg0jyzZpnscmxFi2Nbyej7laEu2wvFwUyg=;
 b=feoPrWk47KRuudDyZPinF6pUZPQ9BhrqvuJrMhUFS8a5KF260iWKLs5K9GFi34UO3tWK910sZoO3RnwORZyoNpIM6dml/XhVSWVwnPdDYJwrw0ZNwL3MyZiFhrDJ19puukOXMY4gEsIv78VwIZ34cI2K35ucHLxvREh04mYrJ0lET9ijvnPFrSSL0q/6iXjG213/L36JUB7hLEsFpPx5QU+rcG/42ig+PgUyHcfhCqaVWbrAmUb70P++2gtsR7mrhynH0DtSmSeM0SflVgotdLzXaJOkHrjARgbsn8IG1ONIc8ekCn/ijDQq7y7hQG+HdmnDxNOqh9aNaEJH+P6nmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e18ADq7mvgg0jyzZpnscmxFi2Nbyej7laEu2wvFwUyg=;
 b=wHsG1ei1XlqLWC+yEpijmp2h7eOw80ksegH6THBYnVQ7XciiRpxg6/U/ltOJ3oGr049erLRuVcuX1+NcXZmHCTeUhA0/1ljp+QrqeQrhggiz1lvMuYXSfx9Qc6HeeSnzao29Q2u9jFhB3yO0YIoLLwxOHB1X7lWGlCq3vQJd3/s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by DM6PR12MB4513.namprd12.prod.outlook.com (2603:10b6:5:2ad::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.14; Tue, 30 Aug
 2022 21:56:52 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::406d:afb5:d2d7:8115]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::406d:afb5:d2d7:8115%6]) with mapi id 15.20.5566.021; Tue, 30 Aug 2022
 21:56:51 +0000
Message-ID: <fb029eb5-a08c-c2e0-31d7-4bf10150b9e9@amd.com>
Date: Tue, 30 Aug 2022 17:56:49 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 18/29] drm/amdkfd: update process interrupt handling for
 debug events
Content-Language: en-US
To: Jonathan Kim <jonathan.kim@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220829143026.1509027-1-jonathan.kim@amd.com>
 <20220829143026.1509027-19-jonathan.kim@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20220829143026.1509027-19-jonathan.kim@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH2PR05CA0052.namprd05.prod.outlook.com
 (2603:10b6:610:38::29) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7da3e3c2-768d-48e0-838f-08da8ad28ba0
X-MS-TrafficTypeDiagnostic: DM6PR12MB4513:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bU2G1kyxKRBzzira3Ccky6MdMGf6FHXu8p6AYDPOdwh5VSFdx2Dg2nYRA42exabRlRFmDgE4KPD0ydSKocA5f8d0aQwladhSaRRvpIeMUe/d0bLoYWKS6nvfvwdEHCTyqM5HXSN5vojQ58CF0N5VewxugXibNhA/vW4Z/9PvjbJES7wRXN7ka/Igif05wmGIyRG+foH+eqDLs7Oaf1IaApTufbUl56aUYzl6X4oAGeoy9aWfOLBeBZZCg3c9y4vVbp6syGFBHbH7sXOON37OT3Y2wiVkATQIgMljg3IlQ85U4JphCRoiLyldqa48qxXIjsaqmwTF6rgJ+hJeywt04EY8/HB//DJsjO46sIvE3E8AAD8vy59/D8F9W+25WH7u3liHeuB+NCCFWshZkJcsZl/HuKHRi3gV8XhnlIaGK8hCkq0793KW6Jxu0lIyj0SHtadEg6r1JYl1kCEWgTQQY1hytgr1fxoOnPmFVLWHQnuDFGEXx3g4dxevWUjzD+z6NsLQynD43eo6yc9mQ3FeVGfHyPhLnHfP9uP4bxFVdPpPSp2pZzA5oFpQkz3vN644gC8StnYLSUK8tyawTCqB3lCW1PPliizQABGc/EWhuFxTYm+iK8BUY88U863UcYLb6QEGysSS/naK9RoBjF/gVLq6BefmvsUMY18WNZ4AT2L0jld8W6BmL/UmNF01HyYGKydY7NWPXYesf9sCJBaN7edvG3qW53MMY+D/t/L29W9bAsvJfOuroS3pSw0pwAN27ocuz62G867nX3SClDJNK+7vTWd9m1Wt19GF25tjoIw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(376002)(39860400002)(346002)(396003)(136003)(366004)(44832011)(36916002)(15650500001)(41300700001)(53546011)(6506007)(31696002)(8676002)(6486002)(30864003)(8936002)(66946007)(86362001)(2616005)(186003)(83380400001)(478600001)(5660300002)(66476007)(66556008)(4326008)(6512007)(2906002)(38100700002)(26005)(316002)(36756003)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?alBaYm03VmpUVFV5QlFleU1LUEczd2Y2MzViRXJOZGFMTHBUeUsrQ2JBdzlP?=
 =?utf-8?B?Rlh3MERWeWJrSThoRUpIS2x0TUpGZENLVGF3SnFid045L05DWlBRU1ErQStL?=
 =?utf-8?B?UmFhUjBodTh2c2d5cENCM0dXeWdDUDdpUE1rYXpYeldNenlweUpYSE55bEtM?=
 =?utf-8?B?VWg4VGh5M2FjRXRqMysvd1FSTk9QZlU5djNXWUw1L0lKa09iem9URmN4emZu?=
 =?utf-8?B?OVFzL2NBNGtnRWY3UXB1OWc4ZFE0UXJtQVNPTldxazZqSzRvbGwyNmpGZ0RZ?=
 =?utf-8?B?ZEJzRksrQTF0dWt6NG04WEJUbW02cHdyQi9WNlV3eFJrN3FLbnJrNG82UFEy?=
 =?utf-8?B?RkJNV3lMZnBMOG1XeTZ0UHBXcUNiNDJWajdPemI1eG5xTy9WcVAxZERwcWRN?=
 =?utf-8?B?WUd2aXZKUCtGZi83YVM1RzVvU29WMjlaa04rcy9zK05EdHZuenhrZ29FY2xt?=
 =?utf-8?B?dUwzRWJtczNkd1BPMktHeERXMjNKWVBqc05IQ3Z2UG5YN1AzaUFmbXgrbjZD?=
 =?utf-8?B?ZStpWHpaMGxDOGh5N2pHUnhNWWErRGZWQVJZaXc3YlU5RVRmK25CQzlISi9a?=
 =?utf-8?B?T2MwQW5qdkhKZjlydmY2Q2hoOFdnYTI0KzZDdWMvSDc1RDdvdnV3a09ad3Vh?=
 =?utf-8?B?UWJPd3BYbEZiclU0SkZaN3kzaTZxalVvc01WSXJDaVl5T1hqS0ZraEFrSXpp?=
 =?utf-8?B?UExWUXQySnp5dnYyUVp6ZmgyZDB3WHNnbGxwTzVWVUl3dFByK29Eam9sRXZZ?=
 =?utf-8?B?VkZXL295WU93aDRtS1FrREtPckN3M2FYVkxjaXJUemY2THJMclp1WmNISFZO?=
 =?utf-8?B?L1FXTHB5NTRaVElvWnJxczduZHhhMWFsakdUaXJvbzhWcmhENlgvZVBRNWg0?=
 =?utf-8?B?V0x2cnJHVXIyQnBoNHY0NkNKSzZKSktBYTQ0RzREemNiMlhVL0syM2JSL3VT?=
 =?utf-8?B?bUtPYnF6VkxGVlJUMXEwbkhBdHdUL05EdlhQM2N1ZDZFczMrdHE4b2tHZlE0?=
 =?utf-8?B?UE92azBBL05KRGVYUnVPSDhaV3dxR3V5WFlMSlFkS1FBTnlnWFp3S0hVZ1gw?=
 =?utf-8?B?TllJUFRzWjA0TUtLVUdiL1MvWXhXbEhCbWpVNGtyVWRJM25LZFhSOTcyMG1u?=
 =?utf-8?B?b0NXM1BXakNsVHUyQ1RUQXNCUm9ZYXBLbTdMaVZxbWs3dDJqdVJ2ZVpIT1VL?=
 =?utf-8?B?N0o5bFRTTnhtYlc5UmREZ21hMmJnQTlJd3JkTWdJUlhoQ3pxb2kvY1hNY3po?=
 =?utf-8?B?RENjeU1mQUJvcHgybFZlMW50ajJiK0p2YXVsRzN3LzZIczdpU0NVcHFpc2ZM?=
 =?utf-8?B?eTJjY1FEYlZnODBQaUFReXMwQ09NSHR0K3cwVk5hT3ppdFNmMEZwVndNSmJ3?=
 =?utf-8?B?ZGNKd2Fwd1BUKzYrTGVScHRSQUlDK1NIeitaa2hYMnpST0Jvd2UzTUlobXZl?=
 =?utf-8?B?RUxKZUpTNEdxMXRiU1VoRzdCSDlsL0gvMHdhck0yY0ZaUFdWNTJJZDhvYUNI?=
 =?utf-8?B?ZUEwWERpQTltNCtUS3Q4VkZkOVU5RFRaekZ2SE5md1RCTXBiVUp5S3h6d0FZ?=
 =?utf-8?B?NGJUUDZzbXViWS9pMSt1REgvemNhdVJFVWxqN0lmRlNIcittMEoyOU5uVU4v?=
 =?utf-8?B?U1FWTGQ4K1pQdWdIRW1iMXFrU2R0dlBDb1dlNE5RR3NUTTI5UUhOelUrOEo4?=
 =?utf-8?B?Rk0rRnVaVnFUaDRFTk9xLzJGcFdjMDVTTlIzem1lUkszdWIwc1lKTldPUzk1?=
 =?utf-8?B?ZXg1VThTMGY1M1FYeDF3VHVnQ1N5ZjBEbXQxSWMrVUZUaUdERGMvOHY0UEhJ?=
 =?utf-8?B?aW5iMTVzWGc4K2ZXdkVBVGd4dmRDRVQzM0NEMzVqSUxVR2J1eU1zczN0VExB?=
 =?utf-8?B?MTFzY3JkaWQ2U2dheTdDUHUxVmhNZkdiTGJTWVlLQmppU2hTcmlXNTB0Q1U2?=
 =?utf-8?B?UnpJNXp3NEVXOXZsUTUyVEFrcHRvYnlHb0RmcTIrN0ZMaGtJYzRXVUNzc08w?=
 =?utf-8?B?VWdrbmpZQTZQL2ErSnpFYzhEdXp2c0VBR0s1S3ZNd0tscWRtYWhFOXM3aEVv?=
 =?utf-8?B?cjcwY01LMVAwWmJTZ0hyei84aWFLNkVTSGl0enpRdGhabkRJenFRWFp0MFFx?=
 =?utf-8?Q?zieKXRg97sDwYrfegQ6Q6n9uu?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7da3e3c2-768d-48e0-838f-08da8ad28ba0
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2022 21:56:51.8538 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mfK7KJqcHL8QK9BDlSC+zc4lX3YbkiBjf44pbyumAVJADs9xFkBCmrTV/K3G6CpZRBvMKZUVtMlLMI8Bp+zFmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4513
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
Cc: Lancelot.Six@amd.com, Laurent.Morichetti@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 2022-08-29 10:30, Jonathan Kim wrote:
> The debugger must be notified by any debugger subscribed exception
> that comes from hardware interrupts.
>
> Debugger notification must be scheduled as HW state may be unknown
> when receiving an exception that could require an immediate process
> eviction.

I don't understand this statement. Is this a reference to 
debug_event_write_work_handler that gets scheduled in a workqueue (which 
is actually implemented in a different patch)? I think the reasoning 
here was, that kernel_write can stall, which could stall further event 
processing.


>
> If a debugger session exits, any exceptions it subscribed to may still
> have interrupts in the interrupt ring buffer or KGD/KFD pipeline.
> To prevent a new session from inheriting stale interrupts, when a new
> queue is created, open an interrupt drain and allow the IH ring to drain
> from a timestamped checkpoint.  Then inject a custom IV so that once
> the custom IV is picked up by the KFD, it's safe to close the drain
> and proceed with queue creation.
>
> The debugger may also not be attached nor subscibed to certain
> exceptions so forward them directly to the runtime.

Can you add a paragraph that explains why you split kfd_int_process_v10 
into a separate file?

Two more nit-picks and one potential problem inline.


>
> Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c    |  16 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h    |   2 +
>   drivers/gpu/drm/amd/amdkfd/Makefile           |   1 +
>   drivers/gpu/drm/amd/amdkfd/kfd_debug.c        |  59 +++
>   drivers/gpu/drm/amd/amdkfd/kfd_debug.h        |   6 +
>   drivers/gpu/drm/amd/amdkfd/kfd_device.c       |   4 +-
>   .../gpu/drm/amd/amdkfd/kfd_int_process_v10.c  | 402 ++++++++++++++++++
>   .../gpu/drm/amd/amdkfd/kfd_int_process_v9.c   |  95 ++++-
>   drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |  12 +
>   drivers/gpu/drm/amd/amdkfd/kfd_process.c      |  43 ++
>   .../amd/amdkfd/kfd_process_queue_manager.c    |   1 +
>   11 files changed, 631 insertions(+), 10 deletions(-)
>   create mode 100644 drivers/gpu/drm/amd/amdkfd/kfd_int_process_v10.c
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> index 091415a4abf0..1004d162efc1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> @@ -760,6 +760,22 @@ void amdgpu_amdkfd_ras_poison_consumption_handler(struct amdgpu_device *adev, bo
>   		amdgpu_amdkfd_gpu_reset(adev);
>   }
>   
> +int amdgpu_amdkfd_send_close_event_drain_irq(struct amdgpu_device *adev,
> +					uint32_t *payload)
> +{
> +	int ret;
> +
> +	/* Device or IH ring is not ready so bail. */
> +	ret = amdgpu_ih_wait_on_checkpoint_process_ts(adev, &adev->irq.ih);
> +	if (ret)
> +		return ret;
> +
> +	/* Send payload to fence KFD interrupts */
> +	amdgpu_amdkfd_interrupt(adev, payload);
> +
> +	return 0;
> +}
> +
>   bool amdgpu_amdkfd_ras_query_utcl2_poison_status(struct amdgpu_device *adev)
>   {
>   	if (adev->gfx.ras && adev->gfx.ras->query_utcl2_poison_status)
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> index 647220a8762d..5ba68ec08199 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> @@ -236,6 +236,8 @@ int amdgpu_amdkfd_get_xgmi_bandwidth_mbytes(struct amdgpu_device *dst,
>   					    struct amdgpu_device *src,
>   					    bool is_min);
>   int amdgpu_amdkfd_get_pcie_bandwidth_mbytes(struct amdgpu_device *adev, bool is_min);
> +int amdgpu_amdkfd_send_close_event_drain_irq(struct amdgpu_device *adev,
> +					uint32_t *payload);
>   
>   /* Read user wptr from a specified user address space with page fault
>    * disabled. The memory must be pinned and mapped to the hardware when
> diff --git a/drivers/gpu/drm/amd/amdkfd/Makefile b/drivers/gpu/drm/amd/amdkfd/Makefile
> index 747754428073..2ec8f27c5366 100644
> --- a/drivers/gpu/drm/amd/amdkfd/Makefile
> +++ b/drivers/gpu/drm/amd/amdkfd/Makefile
> @@ -53,6 +53,7 @@ AMDKFD_FILES	:= $(AMDKFD_PATH)/kfd_module.o \
>   		$(AMDKFD_PATH)/kfd_events.o \
>   		$(AMDKFD_PATH)/cik_event_interrupt.o \
>   		$(AMDKFD_PATH)/kfd_int_process_v9.o \
> +		$(AMDKFD_PATH)/kfd_int_process_v10.o \
>   		$(AMDKFD_PATH)/kfd_int_process_v11.o \
>   		$(AMDKFD_PATH)/kfd_smi_events.o \
>   		$(AMDKFD_PATH)/kfd_crat.o \
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_debug.c b/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
> index d4f87f2adada..8d0e6802e2fb 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
> @@ -125,6 +125,65 @@ bool kfd_dbg_ev_raise(uint64_t event_mask,
>   	return is_subscribed;
>   }
>   
> +/* set pending event queue entry from ring entry  */
> +bool kfd_set_dbg_ev_from_interrupt(struct kfd_dev *dev,
> +				   unsigned int pasid,
> +				   uint32_t doorbell_id,
> +				   uint64_t trap_mask,
> +				   void *exception_data,
> +				   size_t exception_data_size)
> +{
> +	struct kfd_process *p;
> +	bool signaled_to_debugger_or_runtime = false;
> +
> +	p = kfd_lookup_process_by_pasid(pasid);
> +
> +	if (!p)
> +		return false;
> +
> +	if (!kfd_dbg_ev_raise(trap_mask, p, dev, doorbell_id, true,
> +					exception_data, exception_data_size)) {
> +		struct process_queue_manager *pqm;
> +		struct process_queue_node *pqn;
> +
> +		if (!!(trap_mask & KFD_EC_MASK_QUEUE) &&
> +				p->runtime_info.runtime_state == DEBUG_RUNTIME_STATE_ENABLED) {
> +			mutex_lock(&p->mutex);
> +
> +			pqm = &p->pqm;
> +			list_for_each_entry(pqn, &pqm->queues,
> +							process_queue_list) {
> +
> +				if (!(pqn->q && pqn->q->device == dev &&
> +						pqn->q->doorbell_id == doorbell_id))
> +					continue;
> +
> +				kfd_send_exception_to_runtime(p,
> +						pqn->q->properties.queue_id,
> +						trap_mask);
> +
> +				signaled_to_debugger_or_runtime = true;
> +
> +				break;
> +			}
> +
> +			mutex_unlock(&p->mutex);
> +		} else if (trap_mask & KFD_EC_MASK(EC_DEVICE_MEMORY_VIOLATION)) {
> +			kfd_dqm_evict_pasid(dev->dqm, p->pasid);
> +			kfd_signal_vm_fault_event(dev, p->pasid, NULL,
> +							exception_data);
> +
> +			signaled_to_debugger_or_runtime = true;
> +		}
> +	} else {
> +		signaled_to_debugger_or_runtime = true;
> +	}
> +
> +	kfd_unref_process(p);
> +
> +	return signaled_to_debugger_or_runtime;
> +}
> +
>   int kfd_dbg_send_exception_to_runtime(struct kfd_process *p,
>   					unsigned int dev_id,
>   					unsigned int queue_id,
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_debug.h b/drivers/gpu/drm/amd/amdkfd/kfd_debug.h
> index e31c9bb0e848..5270d5749828 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_debug.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_debug.h
> @@ -30,6 +30,12 @@ void kgd_gfx_v9_set_wave_launch_stall(struct amdgpu_device *adev,
>   					bool stall);
>   void kfd_dbg_trap_deactivate(struct kfd_process *target, bool unwind, int unwind_count);
>   int kfd_dbg_trap_activate(struct kfd_process *target);
> +bool kfd_set_dbg_ev_from_interrupt(struct kfd_dev *dev,
> +				   unsigned int pasid,
> +				   uint32_t doorbell_id,
> +				   uint64_t trap_mask,
> +				   void *exception_data,
> +				   size_t exception_data_size);
>   bool kfd_dbg_ev_raise(uint64_t event_mask,
>   			struct kfd_process *process, struct kfd_dev *dev,
>   			unsigned int source_id, bool use_worker,
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> index fdad1415f8bd..0bbaf262ea19 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> @@ -133,6 +133,8 @@ static void kfd_device_info_set_event_interrupt_class(struct kfd_dev *kfd)
>   	case IP_VERSION(9, 4, 0): /* VEGA20 */
>   	case IP_VERSION(9, 4, 1): /* ARCTURUS */
>   	case IP_VERSION(9, 4, 2): /* ALDEBARAN */
> +		kfd->device_info.event_interrupt_class = &event_interrupt_class_v9;
> +		break;
>   	case IP_VERSION(10, 3, 1): /* VANGOGH */
>   	case IP_VERSION(10, 3, 3): /* YELLOW_CARP */
>   	case IP_VERSION(10, 3, 6): /* GC 10.3.6 */
> @@ -146,7 +148,7 @@ static void kfd_device_info_set_event_interrupt_class(struct kfd_dev *kfd)
>   	case IP_VERSION(10, 3, 2): /* NAVY_FLOUNDER */
>   	case IP_VERSION(10, 3, 4): /* DIMGREY_CAVEFISH */
>   	case IP_VERSION(10, 3, 5): /* BEIGE_GOBY */
> -		kfd->device_info.event_interrupt_class = &event_interrupt_class_v9;
> +		kfd->device_info.event_interrupt_class = &event_interrupt_class_v10;
>   		break;
>   	case IP_VERSION(11, 0, 0):
>   	case IP_VERSION(11, 0, 1):
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v10.c b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v10.c
> new file mode 100644
> index 000000000000..e954245e9c21
> --- /dev/null
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v10.c
> @@ -0,0 +1,402 @@
> +/*
> + * Copyright 2022 Advanced Micro Devices, Inc.
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining a
> + * copy of this software and associated documentation files (the "Software"),
> + * to deal in the Software without restriction, including without limitation
> + * the rights to use, copy, modify, merge, publish, distribute, sublicense,
> + * and/or sell copies of the Software, and to permit persons to whom the
> + * Software is furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be included in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
> + * OTHER DEALINGS IN THE SOFTWARE.
> + */
> +
> +#include "kfd_events.h"
> +#include "kfd_debug.h"
> +#include "soc15_int.h"
> +#include "kfd_device_queue_manager.h"
> +
> +/*
> + * GFX10 SQ Interrupts
> + *
> + * There are 3 encoding types of interrupts sourced from SQ sent as a 44-bit
> + * packet to the Interrupt Handler:
> + * Auto - Generated by the SQG (various cmd overflows, timestamps etc)
> + * Wave - Generated by S_SENDMSG through a shader program
> + * Error - HW generated errors (Illegal instructions, Memviols, EDC etc)
> + *
> + * The 44-bit packet is mapped as {context_id1[7:0],context_id0[31:0]} plus
> + * 4-bits for VMID (SOC15_VMID_FROM_IH_ENTRY) as such:
> + *
> + * - context_id1[7:6]
> + * Encoding type (0 = Auto, 1 = Wave, 2 = Error)
> + *
> + * - context_id0[24]
> + * PRIV bit indicates that Wave S_SEND or error occurred within trap
> + *
> + * - context_id0[22:0]
> + * 23-bit data with the following layout per encoding type:
> + * Auto - only context_id0[8:0] is used, which reports various interrupts
> + * generated by SQG.  The rest is 0.
> + * Wave - user data sent from m0 via S_SENDMSG
> + * Error - Error type (context_id0[22:19]), Error Details (rest of bits)
> + *
> + * The other context_id bits show coordinates (SE/SH/CU/SIMD/WGP) for wave
> + * S_SENDMSG and Errors.  These are 0 for Auto.
> + */
> +
> +enum SQ_INTERRUPT_WORD_ENCODING {
> +	SQ_INTERRUPT_WORD_ENCODING_AUTO = 0x0,
> +	SQ_INTERRUPT_WORD_ENCODING_INST,
> +	SQ_INTERRUPT_WORD_ENCODING_ERROR,
> +};
> +
> +enum SQ_INTERRUPT_ERROR_TYPE {
> +	SQ_INTERRUPT_ERROR_TYPE_EDC_FUE = 0x0,
> +	SQ_INTERRUPT_ERROR_TYPE_ILLEGAL_INST,
> +	SQ_INTERRUPT_ERROR_TYPE_MEMVIOL,
> +	SQ_INTERRUPT_ERROR_TYPE_EDC_FED,
> +};
> +
> +/* SQ_INTERRUPT_WORD_AUTO_CTXID */
> +#define SQ_INTERRUPT_WORD_AUTO_CTXID0__THREAD_TRACE__SHIFT 0
> +#define SQ_INTERRUPT_WORD_AUTO_CTXID0__WLT__SHIFT 1
> +#define SQ_INTERRUPT_WORD_AUTO_CTXID0__THREAD_TRACE_BUF0_FULL__SHIFT 2
> +#define SQ_INTERRUPT_WORD_AUTO_CTXID0__THREAD_TRACE_BUF1_FULL__SHIFT 3
> +#define SQ_INTERRUPT_WORD_AUTO_CTXID0__THREAD_TRACE_UTC_ERROR__SHIFT 7
> +#define SQ_INTERRUPT_WORD_AUTO_CTXID1__SE_ID__SHIFT 4
> +#define SQ_INTERRUPT_WORD_AUTO_CTXID1__ENCODING__SHIFT 6
> +
> +#define SQ_INTERRUPT_WORD_AUTO_CTXID0__THREAD_TRACE_MASK 0x00000001
> +#define SQ_INTERRUPT_WORD_AUTO_CTXID0__WLT_MASK 0x00000002
> +#define SQ_INTERRUPT_WORD_AUTO_CTXID0__THREAD_TRACE_BUF0_FULL_MASK 0x00000004
> +#define SQ_INTERRUPT_WORD_AUTO_CTXID0__THREAD_TRACE_BUF1_FULL_MASK 0x00000008
> +#define SQ_INTERRUPT_WORD_AUTO_CTXID0__THREAD_TRACE_UTC_ERROR_MASK 0x00000080
> +#define SQ_INTERRUPT_WORD_AUTO_CTXID1__SE_ID_MASK 0x030
> +#define SQ_INTERRUPT_WORD_AUTO_CTXID1__ENCODING_MASK 0x0c0
> +
> +/* SQ_INTERRUPT_WORD_WAVE_CTXID */
> +#define SQ_INTERRUPT_WORD_WAVE_CTXID0__DATA__SHIFT 0
> +#define SQ_INTERRUPT_WORD_WAVE_CTXID0__SA_ID__SHIFT 23
> +#define SQ_INTERRUPT_WORD_WAVE_CTXID0__PRIV__SHIFT 24
> +#define SQ_INTERRUPT_WORD_WAVE_CTXID0__WAVE_ID__SHIFT 25
> +#define SQ_INTERRUPT_WORD_WAVE_CTXID0__SIMD_ID__SHIFT 30
> +#define SQ_INTERRUPT_WORD_WAVE_CTXID1__WGP_ID__SHIFT 0
> +#define SQ_INTERRUPT_WORD_WAVE_CTXID1__SE_ID__SHIFT 4
> +#define SQ_INTERRUPT_WORD_WAVE_CTXID1__ENCODING__SHIFT 6
> +
> +#define SQ_INTERRUPT_WORD_WAVE_CTXID0__DATA_MASK 0x000007fffff
> +#define SQ_INTERRUPT_WORD_WAVE_CTXID0__SA_ID_MASK 0x0000800000
> +#define SQ_INTERRUPT_WORD_WAVE_CTXID0__PRIV_MASK 0x00001000000
> +#define SQ_INTERRUPT_WORD_WAVE_CTXID0__WAVE_ID_MASK 0x0003e000000
> +#define SQ_INTERRUPT_WORD_WAVE_CTXID0__SIMD_ID_MASK 0x000c0000000
> +#define SQ_INTERRUPT_WORD_WAVE_CTXID1__WGP_ID_MASK 0x00f
> +#define SQ_INTERRUPT_WORD_WAVE_CTXID1__SE_ID_MASK 0x030
> +#define SQ_INTERRUPT_WORD_WAVE_CTXID1__ENCODING_MASK 0x0c0
> +
> +#define KFD_CTXID0__ERR_TYPE_MASK 0x780000
> +#define KFD_CTXID0__ERR_TYPE__SHIFT 19
> +
> +/* GFX10 SQ interrupt ENC type bit (context_id1[7:6]) for wave s_sendmsg */
> +#define KFD_CONTEXT_ID1_ENC_TYPE_WAVE_MASK	0x40
> +/* GFX10 SQ interrupt PRIV bit (context_id0[24]) for s_sendmsg inside trap */
> +#define KFD_CONTEXT_ID0_PRIV_MASK		0x1000000
> +/*
> + * The debugger will send user data(m0) with PRIV=1 to indicate it requires
> + * notification from the KFD with the following queue id (DOORBELL_ID) and
> + * trap code (TRAP_CODE).
> + */
> +#define KFD_CONTEXT_ID0_DEBUG_DOORBELL_MASK	0x0003ff
> +#define KFD_CONTEXT_ID0_DEBUG_TRAP_CODE_SHIFT	10
> +#define KFD_CONTEXT_ID0_DEBUG_TRAP_CODE_MASK	0x07fc00
> +#define KFD_DEBUG_DOORBELL_ID(ctxid0)	((ctxid0) &	\
> +				KFD_CONTEXT_ID0_DEBUG_DOORBELL_MASK)
> +#define KFD_DEBUG_TRAP_CODE(ctxid0)	(((ctxid0) &	\
> +				KFD_CONTEXT_ID0_DEBUG_TRAP_CODE_MASK)	\
> +				>> KFD_CONTEXT_ID0_DEBUG_TRAP_CODE_SHIFT)
> +#define KFD_DEBUG_CP_BAD_OP_ECODE(ctxid0) (((ctxid0) & 0x3ffffff)	\
> +				>> KFD_CONTEXT_ID0_DEBUG_TRAP_CODE_SHIFT)
> +
> +static void event_interrupt_poison_consumption(struct kfd_dev *dev,
> +				uint16_t pasid, uint16_t client_id)
> +{
> +	int old_poison, ret = -EINVAL;
> +	struct kfd_process *p = kfd_lookup_process_by_pasid(pasid);
> +
> +	if (!p)
> +		return;
> +
> +	/* all queues of a process will be unmapped in one time */
> +	old_poison = atomic_cmpxchg(&p->poison, 0, 1);
> +	kfd_unref_process(p);
> +	if (old_poison)
> +		return;
> +
> +	switch (client_id) {
> +	case SOC15_IH_CLIENTID_SE0SH:
> +	case SOC15_IH_CLIENTID_SE1SH:
> +	case SOC15_IH_CLIENTID_SE2SH:
> +	case SOC15_IH_CLIENTID_SE3SH:
> +	case SOC15_IH_CLIENTID_UTCL2:
> +		ret = kfd_dqm_evict_pasid(dev->dqm, pasid);
> +		break;
> +	case SOC15_IH_CLIENTID_SDMA0:
> +	case SOC15_IH_CLIENTID_SDMA1:
> +	case SOC15_IH_CLIENTID_SDMA2:
> +	case SOC15_IH_CLIENTID_SDMA3:
> +	case SOC15_IH_CLIENTID_SDMA4:
> +		break;
> +	default:
> +		break;
> +	}
> +
> +	kfd_signal_poison_consumed_event(dev, pasid);
> +
> +	/* resetting queue passes, do page retirement without gpu reset
> +	 * resetting queue fails, fallback to gpu reset solution
> +	 */
> +	if (!ret) {
> +		dev_warn(dev->adev->dev,
> +			"RAS poison consumption, unmap queue flow succeeded: client id %d\n",
> +			client_id);
> +		amdgpu_amdkfd_ras_poison_consumption_handler(dev->adev, false);
> +	} else {
> +		dev_warn(dev->adev->dev,
> +			"RAS poison consumption, fall back to gpu reset flow: client id %d\n",
> +			client_id);
> +		amdgpu_amdkfd_ras_poison_consumption_handler(dev->adev, true);
> +	}
> +}
> +
> +static bool event_interrupt_isr_v10(struct kfd_dev *dev,
> +					const uint32_t *ih_ring_entry,
> +					uint32_t *patched_ihre,
> +					bool *patched_flag)
> +{
> +	uint16_t source_id, client_id, pasid, vmid;
> +	const uint32_t *data = ih_ring_entry;
> +
> +	source_id = SOC15_SOURCE_ID_FROM_IH_ENTRY(ih_ring_entry);
> +	client_id = SOC15_CLIENT_ID_FROM_IH_ENTRY(ih_ring_entry);
> +
> +	/* Only handle interrupts from KFD VMIDs */
> +	vmid = SOC15_VMID_FROM_IH_ENTRY(ih_ring_entry);
> +	if (!KFD_IRQ_IS_FENCE(client_id, source_id) &&
> +	   (vmid < dev->vm_info.first_vmid_kfd ||
> +	    vmid > dev->vm_info.last_vmid_kfd))
> +		return false;
> +
> +	pasid = SOC15_PASID_FROM_IH_ENTRY(ih_ring_entry);
> +
> +	/* Only handle clients we care about */
> +	if (client_id != SOC15_IH_CLIENTID_GRBM_CP &&
> +	    client_id != SOC15_IH_CLIENTID_SDMA0 &&
> +	    client_id != SOC15_IH_CLIENTID_SDMA1 &&
> +	    client_id != SOC15_IH_CLIENTID_SDMA2 &&
> +	    client_id != SOC15_IH_CLIENTID_SDMA3 &&
> +	    client_id != SOC15_IH_CLIENTID_SDMA4 &&
> +	    client_id != SOC15_IH_CLIENTID_SDMA5 &&
> +	    client_id != SOC15_IH_CLIENTID_SDMA6 &&
> +	    client_id != SOC15_IH_CLIENTID_SDMA7 &&
> +	    client_id != SOC15_IH_CLIENTID_VMC &&
> +	    client_id != SOC15_IH_CLIENTID_VMC1 &&
> +	    client_id != SOC15_IH_CLIENTID_UTCL2 &&
> +	    client_id != SOC15_IH_CLIENTID_SE0SH &&
> +	    client_id != SOC15_IH_CLIENTID_SE1SH &&
> +	    client_id != SOC15_IH_CLIENTID_SE2SH &&
> +	    client_id != SOC15_IH_CLIENTID_SE3SH)
> +		return false;
> +
> +	pr_debug("client id 0x%x, source id %d, vmid %d, pasid 0x%x. raw data:\n",
> +		 client_id, source_id, vmid, pasid);
> +	pr_debug("%8X, %8X, %8X, %8X, %8X, %8X, %8X, %8X.\n",
> +		 data[0], data[1], data[2], data[3],
> +		 data[4], data[5], data[6], data[7]);
> +
> +	/* If there is no valid PASID, it's likely a bug */
> +	if (WARN_ONCE(pasid == 0, "Bug: No PASID in KFD interrupt"))
> +		return 0;
> +
> +	/* Interrupt types we care about: various signals and faults.
> +	 * They will be forwarded to a work queue (see below).
> +	 */
> +	return source_id == SOC15_INTSRC_CP_END_OF_PIPE ||
> +		source_id == SOC15_INTSRC_SDMA_TRAP ||
> +		source_id == SOC15_INTSRC_SQ_INTERRUPT_MSG ||
> +		source_id == SOC15_INTSRC_CP_BAD_OPCODE ||
> +		client_id == SOC15_IH_CLIENTID_VMC ||
> +		client_id == SOC15_IH_CLIENTID_VMC1 ||
> +		client_id == SOC15_IH_CLIENTID_UTCL2 ||
> +		KFD_IRQ_IS_FENCE(client_id, source_id);
> +}
> +
> +static void event_interrupt_wq_v10(struct kfd_dev *dev,
> +					const uint32_t *ih_ring_entry)
> +{
> +	uint16_t source_id, client_id, pasid, vmid;
> +	uint32_t context_id0, context_id1;
> +	uint32_t encoding, sq_intr_err_type;
> +
> +	source_id = SOC15_SOURCE_ID_FROM_IH_ENTRY(ih_ring_entry);
> +	client_id = SOC15_CLIENT_ID_FROM_IH_ENTRY(ih_ring_entry);
> +	pasid = SOC15_PASID_FROM_IH_ENTRY(ih_ring_entry);
> +	vmid = SOC15_VMID_FROM_IH_ENTRY(ih_ring_entry);
> +	context_id0 = SOC15_CONTEXT_ID0_FROM_IH_ENTRY(ih_ring_entry);
> +	context_id1 = SOC15_CONTEXT_ID1_FROM_IH_ENTRY(ih_ring_entry);
> +
> +	if (client_id == SOC15_IH_CLIENTID_GRBM_CP ||
> +	    client_id == SOC15_IH_CLIENTID_SE0SH ||
> +	    client_id == SOC15_IH_CLIENTID_SE1SH ||
> +	    client_id == SOC15_IH_CLIENTID_SE2SH ||
> +	    client_id == SOC15_IH_CLIENTID_SE3SH) {
> +		if (source_id == SOC15_INTSRC_CP_END_OF_PIPE)
> +			kfd_signal_event_interrupt(pasid, context_id0, 32);
> +		else if (source_id == SOC15_INTSRC_SQ_INTERRUPT_MSG) {
> +			encoding = REG_GET_FIELD(context_id1,
> +						SQ_INTERRUPT_WORD_WAVE_CTXID1, ENCODING);
> +			switch (encoding) {
> +			case SQ_INTERRUPT_WORD_ENCODING_AUTO:
> +				pr_debug(
> +					"sq_intr: auto, se %d, ttrace %d, wlt %d, ttrac_buf0_full %d, ttrac_buf1_full %d, ttrace_utc_err %d\n",
> +					REG_GET_FIELD(context_id1, SQ_INTERRUPT_WORD_AUTO_CTXID1,
> +							SE_ID),
> +					REG_GET_FIELD(context_id0, SQ_INTERRUPT_WORD_AUTO_CTXID0,
> +							THREAD_TRACE),
> +					REG_GET_FIELD(context_id0, SQ_INTERRUPT_WORD_AUTO_CTXID0,
> +							WLT),
> +					REG_GET_FIELD(context_id0, SQ_INTERRUPT_WORD_AUTO_CTXID0,
> +							THREAD_TRACE_BUF0_FULL),
> +					REG_GET_FIELD(context_id0, SQ_INTERRUPT_WORD_AUTO_CTXID0,
> +							THREAD_TRACE_BUF1_FULL),
> +					REG_GET_FIELD(context_id0, SQ_INTERRUPT_WORD_AUTO_CTXID0,
> +							THREAD_TRACE_UTC_ERROR));
> +				break;
> +			case SQ_INTERRUPT_WORD_ENCODING_INST:
> +				pr_debug("sq_intr: inst, se %d, data 0x%x, sa %d, priv %d, wave_id %d, simd_id %d, wgp_id %d\n",
> +					REG_GET_FIELD(context_id1, SQ_INTERRUPT_WORD_WAVE_CTXID1,
> +							SE_ID),
> +					REG_GET_FIELD(context_id0, SQ_INTERRUPT_WORD_WAVE_CTXID0,
> +							DATA),
> +					REG_GET_FIELD(context_id0, SQ_INTERRUPT_WORD_WAVE_CTXID0,
> +							SA_ID),
> +					REG_GET_FIELD(context_id0, SQ_INTERRUPT_WORD_WAVE_CTXID0,
> +							PRIV),
> +					REG_GET_FIELD(context_id0, SQ_INTERRUPT_WORD_WAVE_CTXID0,
> +							WAVE_ID),
> +					REG_GET_FIELD(context_id0, SQ_INTERRUPT_WORD_WAVE_CTXID0,
> +							SIMD_ID),
> +					REG_GET_FIELD(context_id1, SQ_INTERRUPT_WORD_WAVE_CTXID1,
> +							WGP_ID));
> +				if (context_id0 & SQ_INTERRUPT_WORD_WAVE_CTXID0__PRIV_MASK) {
> +					if (kfd_set_dbg_ev_from_interrupt(dev, pasid,
> +							KFD_DEBUG_DOORBELL_ID(context_id0),
> +							KFD_DEBUG_TRAP_CODE(context_id0),
> +							NULL, 0))
> +						return;
> +				}
> +				break;
> +			case SQ_INTERRUPT_WORD_ENCODING_ERROR:
> +				sq_intr_err_type = REG_GET_FIELD(context_id0, KFD_CTXID0,
> +								ERR_TYPE);
> +				pr_warn("sq_intr: error, se %d, data 0x%x, sa %d, priv %d, wave_id %d, simd_id %d, wgp_id %d, err_type %d\n",
> +					REG_GET_FIELD(context_id1, SQ_INTERRUPT_WORD_WAVE_CTXID1,
> +							SE_ID),
> +					REG_GET_FIELD(context_id0, SQ_INTERRUPT_WORD_WAVE_CTXID0,
> +							DATA),
> +					REG_GET_FIELD(context_id0, SQ_INTERRUPT_WORD_WAVE_CTXID0,
> +							SA_ID),
> +					REG_GET_FIELD(context_id0, SQ_INTERRUPT_WORD_WAVE_CTXID0,
> +							PRIV),
> +					REG_GET_FIELD(context_id0, SQ_INTERRUPT_WORD_WAVE_CTXID0,
> +							WAVE_ID),
> +					REG_GET_FIELD(context_id0, SQ_INTERRUPT_WORD_WAVE_CTXID0,
> +							SIMD_ID),
> +					REG_GET_FIELD(context_id1, SQ_INTERRUPT_WORD_WAVE_CTXID1,
> +							WGP_ID),
> +					sq_intr_err_type);
> +				if (sq_intr_err_type != SQ_INTERRUPT_ERROR_TYPE_ILLEGAL_INST &&
> +					sq_intr_err_type != SQ_INTERRUPT_ERROR_TYPE_MEMVIOL) {
> +					event_interrupt_poison_consumption(dev, pasid, source_id);
> +					return;
> +				}
> +				break;
> +			default:
> +				break;
> +			}
> +			kfd_signal_event_interrupt(pasid, context_id0 & 0x7fffff, 23);
> +		} else if (source_id == SOC15_INTSRC_CP_BAD_OPCODE) {
> +			kfd_set_dbg_ev_from_interrupt(dev, pasid,
> +				KFD_DEBUG_DOORBELL_ID(context_id0),
> +				KFD_EC_MASK(KFD_DEBUG_CP_BAD_OP_ECODE(context_id0)),
> +				NULL,
> +				0);
> +		}
> +	} else if (client_id == SOC15_IH_CLIENTID_SDMA0 ||
> +		   client_id == SOC15_IH_CLIENTID_SDMA1 ||
> +		   client_id == SOC15_IH_CLIENTID_SDMA2 ||
> +		   client_id == SOC15_IH_CLIENTID_SDMA3 ||
> +		   (client_id == SOC15_IH_CLIENTID_SDMA3_Sienna_Cichlid &&
> +		    KFD_GC_VERSION(dev) == IP_VERSION(10, 3, 0)) ||
> +		   client_id == SOC15_IH_CLIENTID_SDMA4 ||
> +		   client_id == SOC15_IH_CLIENTID_SDMA5 ||
> +		   client_id == SOC15_IH_CLIENTID_SDMA6 ||
> +		   client_id == SOC15_IH_CLIENTID_SDMA7) {
> +		if (source_id == SOC15_INTSRC_SDMA_TRAP) {
> +			kfd_signal_event_interrupt(pasid, context_id0 & 0xfffffff, 28);
> +		} else if (source_id == SOC15_INTSRC_SDMA_ECC) {
> +			event_interrupt_poison_consumption(dev, pasid, source_id);
> +			return;
> +		}
> +	} else if (client_id == SOC15_IH_CLIENTID_VMC ||
> +		   client_id == SOC15_IH_CLIENTID_VMC1 ||
> +		   client_id == SOC15_IH_CLIENTID_UTCL2) {
> +		struct kfd_vm_fault_info info = {0};
> +		uint16_t ring_id = SOC15_RING_ID_FROM_IH_ENTRY(ih_ring_entry);
> +		struct kfd_hsa_memory_exception_data exception_data;
> +
> +		if (client_id == SOC15_IH_CLIENTID_UTCL2 &&
> +				amdgpu_amdkfd_ras_query_utcl2_poison_status(dev->adev)) {
> +			event_interrupt_poison_consumption(dev, pasid, client_id);
> +			return;
> +		}
> +
> +		info.vmid = vmid;
> +		info.mc_id = client_id;
> +		info.page_addr = ih_ring_entry[4] |
> +			(uint64_t)(ih_ring_entry[5] & 0xf) << 32;
> +		info.prot_valid = ring_id & 0x08;
> +		info.prot_read  = ring_id & 0x10;
> +		info.prot_write = ring_id & 0x20;
> +
> +		memset(&exception_data, 0, sizeof(exception_data));
> +		exception_data.gpu_id = dev->id;
> +		exception_data.va = (info.page_addr) << PAGE_SHIFT;
> +		exception_data.failure.NotPresent = info.prot_valid ? 1 : 0;
> +		exception_data.failure.NoExecute = info.prot_exec ? 1 : 0;
> +		exception_data.failure.ReadOnly = info.prot_write ? 1 : 0;
> +		exception_data.failure.imprecise = 0;
> +
> +		kfd_set_dbg_ev_from_interrupt(dev,
> +						pasid,
> +						-1,
> +						KFD_EC_MASK(EC_DEVICE_MEMORY_VIOLATION),
> +						&exception_data,
> +						sizeof(exception_data));
> +	} else if (KFD_IRQ_IS_FENCE(client_id, source_id)) {
> +		kfd_process_close_interrupt_drain(pasid);
> +	}
> +}
> +
> +const struct kfd_event_interrupt_class event_interrupt_class_v10 = {
> +	.interrupt_isr = event_interrupt_isr_v10,
> +	.interrupt_wq = event_interrupt_wq_v10,
> +};
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
> index e092563f22de..33f6d319ce1d 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
> @@ -23,10 +23,40 @@
>   
>   #include "kfd_priv.h"
>   #include "kfd_events.h"
> +#include "kfd_debug.h"
>   #include "soc15_int.h"
>   #include "kfd_device_queue_manager.h"
>   #include "kfd_smi_events.h"
>   
> +/*
> + * GFX9 SQ Interrupts
> + *
> + * There are 3 encoding types of interrupts sourced from SQ sent as a 44-bit
> + * packet to the Interrupt Handler:
> + * Auto - Generated by the SQG (various cmd overflows, timestamps etc)
> + * Wave - Generated by S_SENDMSG through a shader program
> + * Error - HW generated errors (Illegal instructions, Memviols, EDC etc)
> + *
> + * The 44-bit packet is mapped as {context_id1[7:0],context_id0[31:0]} plus
> + * 4-bits for VMID (SOC15_VMID_FROM_IH_ENTRY) as such:
> + *
> + * - context_id0[27:26]
> + * Encoding type (0 = Auto, 1 = Wave, 2 = Error)
> + *
> + * - context_id0[13]
> + * PRIV bit indicates that Wave S_SEND or error occurred within trap
> + *
> + * - {context_id1[7:0],context_id0[31:28],context_id0[11:0]}
> + * 24-bit data with the following layout per encoding type:
> + * Auto - only context_id0[8:0] is used, which reports various interrupts
> + * generated by SQG.  The rest is 0.
> + * Wave - user data sent from m0 via S_SENDMSG
> + * Error - Error type (context_id1[7:4]), Error Details (rest of bits)
> + *
> + * The other context_id bits show coordinates (SE/SH/CU/SIMD/WAVE) for wave
> + * S_SENDMSG and Errors.  These are 0 for Auto.
> + */
> +
>   enum SQ_INTERRUPT_WORD_ENCODING {
>   	SQ_INTERRUPT_WORD_ENCODING_AUTO = 0x0,
>   	SQ_INTERRUPT_WORD_ENCODING_INST,
> @@ -84,12 +114,29 @@ enum SQ_INTERRUPT_ERROR_TYPE {
>   #define SQ_INTERRUPT_WORD_WAVE_CTXID__SE_ID_MASK 0x03000000
>   #define SQ_INTERRUPT_WORD_WAVE_CTXID__ENCODING_MASK 0x0c000000
>   
> +/* GFX9 SQ interrupt 24-bit data from context_id<0,1> */
>   #define KFD_CONTEXT_ID_GET_SQ_INT_DATA(ctx0, ctx1)                             \
>   	((ctx0 & 0xfff) | ((ctx0 >> 16) & 0xf000) | ((ctx1 << 16) & 0xff0000))
>   
>   #define KFD_SQ_INT_DATA__ERR_TYPE_MASK 0xF00000
>   #define KFD_SQ_INT_DATA__ERR_TYPE__SHIFT 20
>   
> +/*
> + * The debugger will send user data(m0) with PRIV=1 to indicate it requires
> + * notification from the KFD with the following queue id (DOORBELL_ID) and
> + * trap code (TRAP_CODE).
> + */
> +#define KFD_SQ_INT_DATA_DEBUG_DOORBELL_MASK	0x0003ff
> +#define KFD_SQ_INT_DATA_DEBUG_TRAP_CODE_SHIFT	10

The doorbell mask and trap-code shift are not SQ-specific. They are also 
used for CP interrupts. So they should not have SQ in the name.


> +#define KFD_SQ_INT_DATA_DEBUG_TRAP_CODE_MASK	0x07fc00
> +#define KFD_DEBUG_DOORBELL_ID(sq_int_data)	((sq_int_data) &	\
> +				KFD_SQ_INT_DATA_DEBUG_DOORBELL_MASK)
> +#define KFD_DEBUG_TRAP_CODE(sq_int_data)	(((sq_int_data) &	\
> +				KFD_SQ_INT_DATA_DEBUG_TRAP_CODE_MASK)	\
> +				>> KFD_SQ_INT_DATA_DEBUG_TRAP_CODE_SHIFT)
> +#define KFD_DEBUG_CP_BAD_OP_ECODE(ctxid0)	(((ctxid0) & 0x3ffffff) \
> +				>> KFD_SQ_INT_DATA_DEBUG_TRAP_CODE_SHIFT)

The mask should not be hard-coded here. It should be defined as another 
#define KFD_CP_BAD_OP_ECODE_MASK. It's also misleading that the mask 
includes low bits that then get shifted out to the right.

The same applies to kfd_int_process_v10.c.


> +
>   static void event_interrupt_poison_consumption_v9(struct kfd_dev *dev,
>   				uint16_t pasid, uint16_t client_id)
>   {
> @@ -168,14 +215,16 @@ static bool event_interrupt_isr_v9(struct kfd_dev *dev,
>   	uint16_t source_id, client_id, pasid, vmid;
>   	const uint32_t *data = ih_ring_entry;
>   
> +	source_id = SOC15_SOURCE_ID_FROM_IH_ENTRY(ih_ring_entry);
> +	client_id = SOC15_CLIENT_ID_FROM_IH_ENTRY(ih_ring_entry);
> +
>   	/* Only handle interrupts from KFD VMIDs */
>   	vmid = SOC15_VMID_FROM_IH_ENTRY(ih_ring_entry);
> -	if (vmid < dev->vm_info.first_vmid_kfd ||
> -	    vmid > dev->vm_info.last_vmid_kfd)
> +	if (!KFD_IRQ_IS_FENCE(client_id, source_id) &&
> +	   (vmid < dev->vm_info.first_vmid_kfd ||
> +	    vmid > dev->vm_info.last_vmid_kfd))
>   		return false;
>   
> -	source_id = SOC15_SOURCE_ID_FROM_IH_ENTRY(ih_ring_entry);
> -	client_id = SOC15_CLIENT_ID_FROM_IH_ENTRY(ih_ring_entry);
>   	pasid = SOC15_PASID_FROM_IH_ENTRY(ih_ring_entry);
>   
>   	/* Only handle clients we care about */
> @@ -194,7 +243,8 @@ static bool event_interrupt_isr_v9(struct kfd_dev *dev,
>   	    client_id != SOC15_IH_CLIENTID_SE0SH &&
>   	    client_id != SOC15_IH_CLIENTID_SE1SH &&
>   	    client_id != SOC15_IH_CLIENTID_SE2SH &&
> -	    client_id != SOC15_IH_CLIENTID_SE3SH)
> +	    client_id != SOC15_IH_CLIENTID_SE3SH &&
> +	    !KFD_IRQ_IS_FENCE(client_id, source_id))
>   		return false;
>   
>   	/* This is a known issue for gfx9. Under non HWS, pasid is not set
> @@ -247,6 +297,7 @@ static bool event_interrupt_isr_v9(struct kfd_dev *dev,
>   		source_id == SOC15_INTSRC_SDMA_ECC ||
>   		source_id == SOC15_INTSRC_SQ_INTERRUPT_MSG ||
>   		source_id == SOC15_INTSRC_CP_BAD_OPCODE ||
> +		KFD_IRQ_IS_FENCE(client_id, source_id) ||
>   		((client_id == SOC15_IH_CLIENTID_VMC ||
>   		client_id == SOC15_IH_CLIENTID_VMC1 ||
>   		client_id == SOC15_IH_CLIENTID_UTCL2) &&
> @@ -302,6 +353,13 @@ static void event_interrupt_wq_v9(struct kfd_dev *dev,
>   					REG_GET_FIELD(context_id0, SQ_INTERRUPT_WORD_WAVE_CTXID, SIMD_ID),
>   					REG_GET_FIELD(context_id0, SQ_INTERRUPT_WORD_WAVE_CTXID, CU_ID),
>   					sq_int_data);
> +				if (context_id0 & SQ_INTERRUPT_WORD_WAVE_CTXID__PRIV_MASK) {
> +					if (kfd_set_dbg_ev_from_interrupt(dev, pasid,
> +							KFD_DEBUG_DOORBELL_ID(sq_int_data),
> +							KFD_DEBUG_TRAP_CODE(sq_int_data),
> +							NULL, 0))
> +						return;
> +				}
>   				break;
>   			case SQ_INTERRUPT_WORD_ENCODING_ERROR:
>   				sq_intr_err = REG_GET_FIELD(sq_int_data, KFD_SQ_INT_DATA, ERR_TYPE);
> @@ -324,8 +382,12 @@ static void event_interrupt_wq_v9(struct kfd_dev *dev,
>   				break;
>   			}
>   			kfd_signal_event_interrupt(pasid, context_id0 & 0xffffff, 24);
> -		} else if (source_id == SOC15_INTSRC_CP_BAD_OPCODE)
> -			kfd_signal_hw_exception_event(pasid);
> +		} else if (source_id == SOC15_INTSRC_CP_BAD_OPCODE) {
> +			kfd_set_dbg_ev_from_interrupt(dev, pasid,
> +				KFD_DEBUG_DOORBELL_ID(context_id0),
> +				KFD_EC_MASK(KFD_DEBUG_CP_BAD_OP_ECODE(context_id0)),
> +				NULL, 0);
> +		}
>   	} else if (client_id == SOC15_IH_CLIENTID_SDMA0 ||
>   		   client_id == SOC15_IH_CLIENTID_SDMA1 ||
>   		   client_id == SOC15_IH_CLIENTID_SDMA2 ||
> @@ -345,6 +407,7 @@ static void event_interrupt_wq_v9(struct kfd_dev *dev,
>   		   client_id == SOC15_IH_CLIENTID_UTCL2) {
>   		struct kfd_vm_fault_info info = {0};
>   		uint16_t ring_id = SOC15_RING_ID_FROM_IH_ENTRY(ih_ring_entry);
> +		struct kfd_hsa_memory_exception_data exception_data;
>   
>   		if (client_id == SOC15_IH_CLIENTID_UTCL2 &&
>   		    amdgpu_amdkfd_ras_query_utcl2_poison_status(dev->adev)) {
> @@ -360,9 +423,23 @@ static void event_interrupt_wq_v9(struct kfd_dev *dev,
>   		info.prot_read  = ring_id & 0x10;
>   		info.prot_write = ring_id & 0x20;
>   
> +		memset(&exception_data, 0, sizeof(exception_data));
> +		exception_data.gpu_id = dev->id;
> +		exception_data.va = (info.page_addr) << PAGE_SHIFT;
> +		exception_data.failure.NotPresent = info.prot_valid ? 1 : 0;
> +		exception_data.failure.NoExecute = info.prot_exec ? 1 : 0;
> +		exception_data.failure.ReadOnly = info.prot_write ? 1 : 0;
> +		exception_data.failure.imprecise = 0;
> +
> +		kfd_set_dbg_ev_from_interrupt(dev,
> +						pasid,
> +						-1,
> +						KFD_EC_MASK(EC_DEVICE_MEMORY_VIOLATION),
> +						&exception_data,
> +						sizeof(exception_data));
>   		kfd_smi_event_update_vmfault(dev, pasid);
> -		kfd_dqm_evict_pasid(dev->dqm, pasid);
> -		kfd_signal_vm_fault_event(dev, pasid, &info, NULL);
> +	} else if (KFD_IRQ_IS_FENCE(client_id, source_id)) {
> +		kfd_process_close_interrupt_drain(pasid);
>   	}
>   }
>   
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> index 82b28588ab72..e50b472460ad 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> @@ -926,6 +926,10 @@ struct kfd_process {
>   	uint64_t exception_enable_mask;
>   	uint64_t exception_status;
>   
> +	/* Used to drain stale interrupts */
> +	wait_queue_head_t wait_irq_drain;
> +	bool irq_drain_is_open;
> +
>   	/* shared virtual memory registered by this process */
>   	struct svm_range_list svms;
>   
> @@ -1088,12 +1092,19 @@ int kfd_numa_node_to_apic_id(int numa_node_id);
>   void kfd_double_confirm_iommu_support(struct kfd_dev *gpu);
>   
>   /* Interrupts */
> +#define	KFD_IRQ_FENCE_CLIENTID	0xff
> +#define	KFD_IRQ_FENCE_SOURCEID	0xff
> +#define	KFD_IRQ_IS_FENCE(client, source)				\
> +				((client) == KFD_IRQ_FENCE_CLIENTID &&	\
> +				(source) == KFD_IRQ_FENCE_SOURCEID)
>   int kfd_interrupt_init(struct kfd_dev *dev);
>   void kfd_interrupt_exit(struct kfd_dev *dev);
>   bool enqueue_ih_ring_entry(struct kfd_dev *kfd,	const void *ih_ring_entry);
>   bool interrupt_is_wanted(struct kfd_dev *dev,
>   				const uint32_t *ih_ring_entry,
>   				uint32_t *patched_ihre, bool *flag);
> +void kfd_process_drain_interrupts(struct kfd_process_device *pdd);
> +void kfd_process_close_interrupt_drain(unsigned int pasid);
>   
>   /* amdkfd Apertures */
>   int kfd_init_apertures(struct kfd_process *process);
> @@ -1365,6 +1376,7 @@ uint64_t kfd_get_number_elems(struct kfd_dev *kfd);
>   /* Events */
>   extern const struct kfd_event_interrupt_class event_interrupt_class_cik;
>   extern const struct kfd_event_interrupt_class event_interrupt_class_v9;
> +extern const struct kfd_event_interrupt_class event_interrupt_class_v10;
>   extern const struct kfd_event_interrupt_class event_interrupt_class_v11;
>   
>   extern const struct kfd_device_global_init_class device_global_init_class_cik;
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> index c7d0ecbf2f57..6e347c0e4f44 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> @@ -856,6 +856,8 @@ struct kfd_process *kfd_create_process(struct task_struct *thread)
>   		kfd_procfs_add_sysfs_stats(process);
>   		kfd_procfs_add_sysfs_files(process);
>   		kfd_procfs_add_sysfs_counters(process);
> +
> +		init_waitqueue_head(&process->wait_irq_drain);
>   	}
>   out:
>   	if (!IS_ERR(process))
> @@ -2068,6 +2070,47 @@ void kfd_flush_tlb(struct kfd_process_device *pdd, enum TLB_FLUSH_TYPE type)
>   	}
>   }
>   
> +/* assumes caller holds process lock. */
> +void kfd_process_drain_interrupts(struct kfd_process_device *pdd)
> +{
> +	uint32_t irq_drain_fence[8];
> +
> +	if (!KFD_IS_SOC15(pdd->dev))
> +		return;
> +
> +	pdd->process->irq_drain_is_open = true;
> +
> +	memset(irq_drain_fence, 0, sizeof(irq_drain_fence));
> +	irq_drain_fence[0] = (KFD_IRQ_FENCE_SOURCEID << 8) |
> +							KFD_IRQ_FENCE_CLIENTID;
> +	irq_drain_fence[3] = pdd->process->pasid;
> +
> +	/* ensure stale irqs scheduled KFD interrupts and send drain fence. */
> +	if (amdgpu_amdkfd_send_close_event_drain_irq(pdd->dev->adev,
> +							irq_drain_fence)) {
> +		pdd->process->irq_drain_is_open = false;
> +		return;
> +	}
> +
> +	if (wait_event_interruptible(pdd->process->wait_irq_drain,
> +				!READ_ONCE(pdd->process->irq_drain_is_open)))
> +		pdd->process->irq_drain_is_open = false;

I believe we only get into this if-block, if wait_event_interruptible 
returns -ERESTARTSYS. This happens when the ioctl gets interrupted to 
process a user mode signal. I think we should pass that error code back 
up to the caller. See below.


> +}
> +
> +void kfd_process_close_interrupt_drain(unsigned int pasid)
> +{
> +	struct kfd_process *p;
> +
> +	p = kfd_lookup_process_by_pasid(pasid);
> +
> +	if (!p)
> +		return;
> +
> +	WRITE_ONCE(p->irq_drain_is_open, false);
> +	wake_up_all(&p->wait_irq_drain);
> +	kfd_unref_process(p);
> +}
> +
>   struct send_exception_work_handler_workarea {
>   	struct work_struct work;
>   	struct kfd_process *p;
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> index 6e3e7f54381b..77a6a03c949a 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> @@ -330,6 +330,7 @@ int pqm_create_queue(struct process_queue_manager *pqm,
>   		kq->queue->properties.queue_id = *qid;
>   		pqn->kq = kq;
>   		pqn->q = NULL;
> +		kfd_process_drain_interrupts(pdd);

If draining got interrupted by a signal, we should set retval to the 
error code (-ERESTARTSYS) and break here. When the ioctl gets restarted, 
we'll retry the drain.

Regards,
   Felix


>   		retval = dev->dqm->ops.create_kernel_queue(dev->dqm,
>   							kq, &pdd->qpd);
>   		break;
