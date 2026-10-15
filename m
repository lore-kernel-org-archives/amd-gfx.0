Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F10BBCC6B38
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Oct 2026 16:53:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6BE7E112414;
	Thu, 15 Oct 2026 16:53:15 +0000 (UTC)
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010065.outbound.protection.outlook.com [52.101.46.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4A9B6112414
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Oct 2026 16:53:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X4bA6g4iulDSdRoPXKbK+WxGyIY/QF2oprwfJ7YuY48+q/O1GJOFkuYA0/vDyzsTFWBw+L6dkfav6V0f7Z7LA6hk32CsE8jwcrFUk4rII5rFWg47prFjuDLVZ6iCR3Vq34FzVBu+xByT+LIVFcybNyZugDOHfYx8/MMvp8EhaA4R6uTIxv+e8yCXJvXLZJSgduHabgIs7gq0tzxqPS/nsGQNtHZDxbYPPwMswQbF5HRu8xOSWkZmiXVZdn73qEW7qNC6xYDvUQDkGDHOMYmm1XsQYHqMehJ/INYTzHV7udKPxnewNPDEuzfUMHffVTxq9cD+QqdSlu4x6JvgUM3B9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dGpx6kVAPxH6Jv74fgMdkSAmCcGhN/BnH56HN6KycDk=;
 b=lVVIE2YJpBeN9kkxCMUN/eAckXRiEpWRzMFs4dOPLAZzXDj0klOICKvXBoFqgFj5IgwMGov3OiAkOWJ1afUax/aeMu/G8PqKfNYaa8m5C98fwmRln9ZuaFokCzX8U2+kcwqXIRBtFnFd56+Rzyo/ToMHjA59034ErFQPjHr0c5IXV580EmjEyO+MQ+F8MnINjK7vdyh1EcTEQUKZsjlpf1fPiBVc+kOosWgwgw53UzhfAiloByzAr6FwW7tKwEC2FXH3EfogeXRFpvMu7U+639imvHK7EN65AupJ/LkCgAGdyiWVZe7yzv6ndUTDXdcbBs0f9pYb8c2ISQhZ4McbWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dGpx6kVAPxH6Jv74fgMdkSAmCcGhN/BnH56HN6KycDk=;
 b=e9piYdz1V7OveGyeTuZ+zJv+ORoI/KIFtjYkmxN9DBDuXuoGGlylyUSXbrauS5tBvNDfWgIfFd4LCdY2RuGPyHJGtm54CbuCBeOwqoLBIoC9bJbdQ0xei81smPa0IQ16g6GpWZrTlZ4fjQ7jxSYMzVf5vu6xr6f87qH5IdoFBBQ=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS5PPF78FC67EBA.namprd12.prod.outlook.com
 (2603:10b6:f:fc00::655) by CH2PR12MB4055.namprd12.prod.outlook.com
 (2603:10b6:610:78::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.14; Thu, 15 Oct
 2026 16:53:05 +0000
Received: from DS5PPF78FC67EBA.namprd12.prod.outlook.com
 ([fe80::23fd:d049:8f53:2054]) by DS5PPF78FC67EBA.namprd12.prod.outlook.com
 ([fe80::23fd:d049:8f53:2054%6]) with mapi id 15.21.0522.012; Thu, 15 Oct 2026
 16:53:05 +0000
Message-ID: <76a5e842-6128-451e-84f9-7f0862c8f23d@amd.com>
Date: Thu, 15 Oct 2026 12:52:57 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] drm/amdkfd: discard interrupts during a GPU reset
To: William Palacek <William.Palacek@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Christian.Koenig@amd.com, Kent.Russell@amd.com,
 Harish.Kasiviswanathan@amd.com
References: <20261015150211.454709-1-William.Palacek@amd.com>
Content-Language: en-US
From: "Kuehling, Felix" <felix.kuehling@amd.com>
In-Reply-To: <20261015150211.454709-1-William.Palacek@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT4PR01CA0474.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d6::28) To DS5PPF78FC67EBA.namprd12.prod.outlook.com
 (2603:10b6:f:fc00::655)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS5PPF78FC67EBA:EE_|CH2PR12MB4055:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ebfaf5e-67b7-460d-6c61-08df2adcc7fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|22082099003|10067099003|18002099003|261009223027099003|11063799006|5023799004|56012099006;
X-Microsoft-Antispam-Message-Info: MHFxLJL1W15Wjsd16362QgRhEH508hu8H+G/T75VW+pAmha4pgP0MFIFRczJJ37mX6/YbHMHAmzRADm41JFpdy8kLFsGADN4o88PWe8wWtt8b3nIRJalZM5V7QeH/aBOaJ45gOVwLBbZ84zk/KBOaOPu4BiEimuzHitY3CE9pIMQChazntdimshSDIAe/ccEsBrXz25EmfJ90nv8wAkA/vEK2/NmS0I13uPHl02Kio6JJGWZZMUPIutrrTFOYOjW+e1+FFaWRvoK5bCfI14/nEeCN4QYrDKZ/ivGRu7GJnZkF5LrkazaFi6XFcnCXWXMwKPgukZHgWWGoLrm8+JQiLpK8viQ/bEsTMu1G3s/e5uIleGJadBJi6e4C7SAeIXlAQoZ2t7yOqtLW2noWLvo6POXiYQUoKc/vJJU75njFgFDU0ys/ErHd/g5U7VF3gQm+i04BEA8Xwmzh1Fdwg24w5Xbj5PitVENGCoRkqOpt4XPUXnhjuEnATnwZn1wgqlSvd87YdKMhVxBPIVZ9UM+XP6xKDQV//rCZtviiUOgh7mkmqv6Q09EorQ0bm9FBIXmGVQSNpdD1xdtfbCKqHOHUyZlQn38zzVlZ+KcS8yg3B7B8P2q0iwRhIB/TXqKN7pZ++VUqzhheept9NxncjjYztalbM1GtZrrC+PFlKXX1xA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS5PPF78FC67EBA.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(22082099003)(10067099003)(18002099003)(261009223027099003)(11063799006)(5023799004)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eWNVdVhGMnB5eFhMTThxbUtDSm9YcGVmdS9nV1FrVE1lN2VxbWQzTzhCRzdv?=
 =?utf-8?B?T0dFWHVmMXlmcVRHUHREL2ZFZGNLTjNVQzJSV1MzdjFJaUJ6UmtPN1NRazl4?=
 =?utf-8?B?M0xpZmJ1OVBFSjFzRms5Ym5UUStQeSt2Y1hMQUNNYmFnTFpaVm1kYkltcXpo?=
 =?utf-8?B?YkI5T3liRDBScElTd1paT0h5bm0xMXBsZzh4YTVTd25ucHo0N0hvVVhHS0xl?=
 =?utf-8?B?Z1BnNlhxRENRZVpkR3BXUkN4ZkovU0UyTUJwZCtqU2NSOWFuaW8rZDUxTHdw?=
 =?utf-8?B?Y211UmxBTkRJLzl4YkJMaHJkTDBWcGVOYnZnWHNrOVk4S2VzQWY4OE5mRk9l?=
 =?utf-8?B?Mm1yTG5SSjI0L0VTMHRaZE5PY3k0MWRoc1FsN3ZOQUg3N3hET1dFS0gzVHBn?=
 =?utf-8?B?YXIvdCtEZWdLM3QwcmJjNjNQWHFkUFhFM2hNTWFoNG5DKzFVZGtpWGZCUzFw?=
 =?utf-8?B?WE1UbzJtdEl2c1BEQ20xaEE2M1hWVW5Ldzd3b0hzUlo2UWJXd2hwUkhRd29O?=
 =?utf-8?B?eVgyVWhaek9XbzBmWm9vaTc1NXM3cVQ2WUpoK2ZDWlF3TVlSVy9wTGNHOW1B?=
 =?utf-8?B?dUN0MEhYUVpyQ1JndXBYOHR6eVpMTjRLL3ZIWUJqSHFhNGR0UTlZS1Q2S241?=
 =?utf-8?B?UDlDRTlwU1ozbFF0Y3NSd21nTGczWlFhSng1SEEyYVgxRXZ1T1FkNThBQ054?=
 =?utf-8?B?NTFFdDZYQ2ExL0R1aWlYN1BQTHUwS0dLWVBrdi9UVUFhRHVCOTVYSGM4NkRr?=
 =?utf-8?B?NFZnVGtLUjJTeG9rSzRlTnpnUkNxQm1pWlRSVHh5MXlkVGFWbnNBaTh4MVht?=
 =?utf-8?B?Z3MydnRtRTdQdFNOSzFrRnN3Wk9YeDRjb2JXYmhvN3ltOXRIa0RXd2owSUtM?=
 =?utf-8?B?TDVobHU2YW9xeCsxb2ZQL2xndCtDK3pac0t2VGtnbm0yRDNhOTJFWkg3ZEJq?=
 =?utf-8?B?amZQVlBSS3NKd1VCV01nckRTVkEvb0w3MWlobUROR2ZWYUZNNXc5Z0ZuY1FP?=
 =?utf-8?B?alR5UEwrMjhwNG15ZU5oS0I4QmVDNXB1L3Jxc0FoelhmVmtrbDdwYkVreGUx?=
 =?utf-8?B?S2MxSHdmZi9SemhIcWladGRoU0ZRT1NHYVEvT3JPM05sajN1QndabEp3ZzFI?=
 =?utf-8?B?TlRCMGVmeEhGTXE2K3UzYVJSK3dhME9Uck5pZWNZbXhlR2NlUFpZWW1nSEs1?=
 =?utf-8?B?UnVvV2VIWHhsbTgvU04vNDV5N0JPaG9DbE54ZGtQTzI0aTJ5enZObUEvWno5?=
 =?utf-8?B?SG5vWmN6RFd4MThLYkVqcnoyVWJ6ZXFqTms4N0N5VjV6aytLVmRWeWdLTExN?=
 =?utf-8?B?Y2dEcWFQWi91U2s0SHhMUEFNckV0MFlTRC9tejV3NmdmMy9kb0xpZjg0R0t5?=
 =?utf-8?B?Q1ZoRGlxZEpZdnAybUVGdk1XSmpYNFBVejZzemxsZFBqM2pJUkxubStVcGlX?=
 =?utf-8?B?M1B3VTlCdWV6clh6ZTFLd3ZUQ2EwQjRWMTFvU2pPdDRub2hQZkhPQ1JUcER4?=
 =?utf-8?B?U3Vkd2Zyejl2WHRXYndzQ0V0QitUdVlKbkl5M2Z0NE10N3FLNGFIblBEMUhX?=
 =?utf-8?B?VlA4REtGSys1L0FJR2tNOXpaT01YbElrbmprZWdhaXlFZ0dPOVBjU3VJVG0z?=
 =?utf-8?B?cG1aSVl3dUZNV3N5L1VnUEIvZU5ZZnhpT3oweWx5bmZqTjc3SzBka2IwWnpK?=
 =?utf-8?B?b2ZHOEhxRDNNNlJMMi8zR25qeGZaRUFYZWhRakJuMUkvcDBqVU90dm5nR0pI?=
 =?utf-8?B?ZnVCWFh6dzFWMFJSL3ZsYzV4TXUxQWw5WS9CQjJoeFRaVzBMNk9DU0FwUk5U?=
 =?utf-8?B?QjJEZ1FkcmxQN29KUEc4UktQYm5iVnRMeHNSbUV1U0Z3WUdsODVFS3J6UzBX?=
 =?utf-8?B?OUpoUExuZzMxUXc3RTZENlBQQ2hCamVEYnJ2RnRkenZVemloVTd6OFRGOXl5?=
 =?utf-8?B?cEtKTmlvZzNCVTlMZXltUHRLelAvN3BXeS9ETGJ4WmdPRGorL2FwTmUxWktz?=
 =?utf-8?B?bmVpSURYYitEZzhTTy9ycTFoWjIxd2Jqb2QxZ1FjR0pJaG5Sb0xiVEJIOW8z?=
 =?utf-8?B?clRiT1Jsc0NRdUZHV2ZwZjFTQnFtd0p1N3N2c0tMQURDUVFacDdQYTdUVUUz?=
 =?utf-8?B?eFlHVi9Nb3VKNVdHRGNwQld2aFlSLzVtOWxOVHNTd1hPN1RSMDdkSGRpMVA5?=
 =?utf-8?B?MytnOU5YWHRUV3BaanQ5VGR4TU51eVYwbU9pdkRZaHIwRkJLTVdNazUwNVpY?=
 =?utf-8?B?WWo5NWgxUlZXSWVJMjg4SkhTWDVJNE41WWFKUldQR0twcGR2dXJkdmFsL3BQ?=
 =?utf-8?B?aUIyOHNwRFBJcml0bVBuRVNEZGRWUjcrMVRqV3lEaDBuTUwwNTJrUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ebfaf5e-67b7-460d-6c61-08df2adcc7fc
X-MS-Exchange-CrossTenant-AuthSource: DS5PPF78FC67EBA.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2026 16:53:04.9367 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AVznqIn1YWUbUjLJL722WgxbxLhFxkrxCCRBix7kBHhCZl7L85mxAb7zjU9NgRW+Ob9yo1U7O+fzMA/v4wQxiw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4055
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

On 2026-10-15 11:02, William Palacek wrote:
> kgd2kfd_interrupt() only checks init_complete and the per-node
> interrupts_active flag, and interrupts_active is cleared only in
> kfd_interrupt_exit(). During a GPU reset KFD therefore keeps queueing
> IH entries for its interrupt worker, and the worker processes them
> together with entries queued just before the reset started. These
> entries describe state that the reset is discarding, and processing
> them can act on queues and processes that are being torn down.
>
> Discard KFD IH entries while the reset domain is held, using the
> existing amdgpu_in_reset() check:
>
> - kgd2kfd_interrupt() drops new entries;
> - the interrupt worker discards entries it dequeues;
> - kgd2kfd_pre_reset() flushes the interrupt workqueue after suspending
>    KFD, so entries queued before the reset are discarded before the
>    ASIC is reset, rather than whenever the worker next runs.
>
> Nothing is drained through the GPU, which may not respond at this point.
>
> The only entry KFD waits for is the drain fence that
> kfd_process_drain_interrupts() sends when a debugger disables traps or
> detaches. If that happens during a reset, the fence is discarded and
> the wait ends after AMDGPU_FENCE_JIFFIES_TIMEOUT (HZ/2) with a
> ratelimited warning.
>
> Suggested-by: Felix Kuehling <Felix.Kuehling@amd.com>
> Signed-off-by: William Palacek <William.Palacek@amd.com>
> ---
> v4: new approach, replaces "drm/amdgpu: preempt KFD queues before taking
>      the reset domain lock" (v1-v3)
>      - Drop the queue preemption and every reset-ordering change: queues
>        cannot be unmapped once a reset has started (Christian)
>      - Ignore KFD interrupts while amdgpu_in_reset() (Felix)
>      - Discard IH entries already queued when the reset starts: the worker
>        drops them and kgd2kfd_pre_reset() flushes the KFD IH workqueue
>        (Felix: drain or discard)
>      - Drop the v3 amdgpu_amdkfd_pre_reset() device-list change and the
>        unmap_queues_cpsch() -EIO path along with the approach
>      - Retitle to drm/amdkfd, the change is KFD-only
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_device.c    | 7 +++++++
>   drivers/gpu/drm/amd/amdkfd/kfd_interrupt.c | 6 ++++--
>   2 files changed, 11 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> index bb4c6695f3cf9..ceee52eee7a38 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> @@ -1019,6 +1019,9 @@ int kgd2kfd_pre_reset(struct kfd_dev *kfd,
>   
>   	kgd2kfd_suspend(kfd, true);
>   
> +	/* Reset is in progress, so the worker discards what is still queued */
> +	flush_workqueue(kfd->ih_wq);
> +

This doesn't do what you think it does. It waits for any running worker 
to finish. But the worker can schedule itself again, and it won't wait 
for that rescheduled worker.


>   	for (i = 0; i < kfd->num_nodes; i++)
>   		kfd_signal_reset_event(kfd->nodes[i]);
>   
> @@ -1176,6 +1179,10 @@ void kgd2kfd_interrupt(struct kfd_dev *kfd, const void *ih_ring_entry)
>   	if (!kfd->init_complete)
>   		return;
>   
> +	/* IH entries raised while the ASIC is being reset are stale */
> +	if (amdgpu_in_reset(kfd->adev))
> +		return;
> +
>   	if (kfd->device_info.ih_ring_entry_size > sizeof(patched_ihre)) {
>   		dev_err_once(kfd_device, "Ring entry too small\n");
>   		return;
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_interrupt.c b/drivers/gpu/drm/amd/amdkfd/kfd_interrupt.c
> index 783c2f5a04e4b..abc0e5c583cee 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_interrupt.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_interrupt.c
> @@ -140,8 +140,10 @@ static void interrupt_wq(struct work_struct *work)
>   	unsigned long start_jiffies = jiffies;
>   
>   	while (dequeue_ih_ring_entry(dev, &ih_ring_entry)) {
> -		dev->kfd->device_info.event_interrupt_class->interrupt_wq(dev,
> -								ih_ring_entry);
> +		/* Discard entries queued before the reset started */
> +		if (!amdgpu_in_reset(dev->adev))
> +			dev->kfd->device_info.event_interrupt_class->interrupt_wq(dev,
> +									ih_ring_entry);
>   		kfifo_skip_count(&dev->ih_fifo, dev->kfd->device_info.ih_ring_entry_size);
>   
>   		if (time_is_before_jiffies(start_jiffies + HZ)) {

Just below is where the rescheduling happens. You'll need to prevent 
that when we're draining work in the reset case. It should be no problem 
because it shouldn't take a lot of time when we're just skipping over 
all the IH entries anyway.

Regards,
   Felix


