Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E8F4CA5FFC
	for <amd-gfx@archiver.kernel.org>; Mon,  5 Oct 2026 19:26:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B952210E056;
	Mon,  5 Oct 2026 19:26:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="rwXPg+oM";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011010.outbound.protection.outlook.com
 [40.93.194.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3D56710E056
 for <amd-gfx@lists.freedesktop.org>; Mon,  5 Oct 2026 19:26:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o6ZGlgOYIvO67vEhKH01sw/hc7pflquMIA5g1YKH68H829niixxzWWpxnzW2iFVgAPdLjRntKCqOSuiqxpMBf+azknn12F7iKyhZkeC65KvqPLtT2rF2MzhHg/XdSJMgKH3HKEAGOK2luqwN9rx2+ml4hT5UbQenH2rG5CuFMm6XvgOCmYQOnyZTB2csEZvtq5fJPRTGcU8HRq11Vawkm+xBDVUrby3dI/nuyatewnN5LbX5oCB/PvUyBkLpBjaCJl3FuHX+lWF3s0hoCWzSVqAoX2YrGPirYvv+N0hScHUjIUpC+nkUxWADBwB2myqlcP20JDLduznKbURiTOZ3MQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9KnlqIhvYXfl5X3tyHH1Yw3KlTw9jnsR2upQfO2kOGA=;
 b=UaftIDzKm6zhSVyP4KfCApPi0kT0BqKi1IWXPPwtc8L14C8nBLw/k+/kjaKn0KIqsDaLFI50VNHHzKt5mXqYlBEBz8/okpkjivPevKeQwxlST2OKhUL099fdwqoG0QUb2jYTWqpsKthlg0BO6GmS86sDSraJdmwx6mxcZ6kdCbefDXF76EOD4t+7ZjFlfnuasLc69veTLGpq+KF0PXvPrYM8O9GKXLIQr3wUhEkOZ/Q2ytKbegxM3KET3/0zz+I1kEkvHssei2pv19fDc6hlR1kOx5ScnBie5HtJnGZ/mvZnHVJmSehvsLkCa/9mvyC05q74Ml3fke95LS3uZ0+f9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9KnlqIhvYXfl5X3tyHH1Yw3KlTw9jnsR2upQfO2kOGA=;
 b=rwXPg+oMzoqIxTMBxBfC5tgO3hu49hergm+o3h4u1pMkjSvPpaiI76+k1cuxU119MpaoPL10NdFQxwpNOJmqK5VV7xcOXtL/ICntUxHYrglB+lIa73flVSjQlxv/uXiFTw+VMVsWeGBVwZGUei/aAWyO5nYMu0tMOAEZOXKWTxE=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::607) by IA1PR12MB6283.namprd12.prod.outlook.com
 (2603:10b6:208:3e5::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Mon, 5 Oct
 2026 19:26:28 +0000
Received: from BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 ([fe80::3f44:4881:3c5a:943]) by BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 ([fe80::3f44:4881:3c5a:943%3]) with mapi id 15.21.0472.016; Mon, 5 Oct 2026
 19:26:27 +0000
Message-ID: <8e289c9a-bb0e-44a5-9e96-997e8fa1ec61@amd.com>
Date: Mon, 5 Oct 2026 15:26:26 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] drm/amdkfd: fix NULL deref and unbounded wait in
 teardown_processes on surprise removal
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Olivier Kaloudoff <olivier.kaloudoff@gmail.com>,
 amd-gfx@lists.freedesktop.org
Cc: xiaogang.chen@amd.com, alexander.deucher@amd.com
References: <20261003063817.36606-1-olivier.kaloudoff@gmail.com>
 <20261003063817.36606-2-olivier.kaloudoff@gmail.com>
 <91edc04d-c635-41e9-8ce7-88bbbb2b5938@amd.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <91edc04d-c635-41e9-8ce7-88bbbb2b5938@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT4PR01CA0346.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:fc::16) To BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::607)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN7PPF5F16C5C9C:EE_|IA1PR12MB6283:EE_
X-MS-Office365-Filtering-Correlation-Id: 50d1ab0b-0301-4568-ad37-08df23168d2d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|23010399003|22082099003|4143699003|11063799006|10067099003|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info: kJPnCLrBFkvt3tziGtE7fy2HR0rspP8P8B07E5ZHymjAfq8IH48WUsjwyl30uBW4w+OfYIrJXiI/qePVnERa2e/Gii7N1V7vfVI3C3zFIyQfDjQUXuEjA+Pl0s6WLfulhQ2rEJewggqUI/SJROm0hjNtHfJEyA6q7fkd/rU/jkb1GPNfPWVATnnReaVDT4XIvCDEKlPGt2pNnIQ/R1FuvX6sM4Im0RmRb37itgjx1DVpz6/S4AryxVyVK33OT2mBn92nd16wcTp3p6vqicglcnEHdQIuuRt5v8NwIQPWakgGsCO1LmRxh9ACs17o7fGgSFdxCOHZyrkUhmW7b12Wp8sVT3A48gpNxYPmwl9h8T8tF9kwkJBa0S3VUmMBgGTWKwRfw7jOuE5iFAyjg4l3TNIzlrv4oa9CmWEseC1HWtD9dAmsX8p8nLuCeoyVgeqK6BMBwqQ/UYvDY0jqhwKnIhumfrWbeJHf2AoLPmWg6lEQzgmkE7wcQDbReEdLsxHk6/w6EzJ+AWxktTcmkBpWsqqcCFLaLWAKeNX6z195Rcu9sOR5PlM7s2EdS63u2P5TwpmHJc7vNSDxwqfk8SlMTeqWh8AA8WuD+9CDrdVmzPWRw8fUA5ltZewGLmQi3cW4yot287sjvbSAOOQiMqfr0M/HvM9OZfr9w9eDj2xyGAs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN7PPF5F16C5C9C.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(22082099003)(4143699003)(11063799006)(10067099003)(56012099006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MjE1cXYzenFibDQ0VjdjVXJUY0cxSFg2WndsS2lDWmMxWTRnUmlBdlEweFdE?=
 =?utf-8?B?QUR2TG5iK1hIbmU0SGU2eFRDQmNYYkRJWUNIMXhvb1d5OHVIaEFkTVdpb29D?=
 =?utf-8?B?aktkbzg2SldkOG1FME1wU2VHbkMwZ2RVMW45VkxvNFp5dU51TkpxcEhSMW5n?=
 =?utf-8?B?UGE5S3dlK3AyQ3E5K0lWbS90cGc2QnB4YjVqbzFqQkpidW5IN0lKVERNVSty?=
 =?utf-8?B?L0FkOGhsUXRZMllkUkV4Qzk1aExmY1BvV1NEbUdwUTZFenVHT2F2cDRweEpB?=
 =?utf-8?B?YU9qZjBFa1hSbndjTDVwdVduWGtMdmxSOFlQV0J4N1ZVa2pORDB1dVZZOWd3?=
 =?utf-8?B?UzVqbWhNRG1xdWE1cVdUUzJQandieWpyMUJ5c3NRR3pENDREN2xnV2lwdDE1?=
 =?utf-8?B?VlM5eVB5NlNqTEw3Q080cWVGMmRNa3Evb2NKQk1IQXNTWWlaZzhWNVU2eDNX?=
 =?utf-8?B?V2ZQTHQyck84dThHK2s4RXlmeHMrQVQvLzVxSTIvNWFXZDg4eE55K21hOXcr?=
 =?utf-8?B?UWd4R2pxYzIrbWxCMVQ5ZVY4WUcwVFJrcTl3WkNNY2hYVXJDRHF0MDlSWldI?=
 =?utf-8?B?cUhodW1oSzJwN3M3Q09WN1JuWWFiR1BOZmdzdEVhck44b2lVRjFqeUtSenBF?=
 =?utf-8?B?ZFpycXliakV6b3YySjkzVjg2eGx5NGRaZXJOSTJ6NFRsR2pIMmZKZmt5SjJ6?=
 =?utf-8?B?V0dhYnZVSUY5M1h2ZHBrWG9yejAzcWFSL1U1Ym8ray9LTzN5akladFZpeHVz?=
 =?utf-8?B?MEZsN2pqSU5zN05SeUxLOTVJODBCSGpRRy9xaytrYkQ5TzVCTDM3bjJLQ09w?=
 =?utf-8?B?b01oRWhTOUhrd2xualVWQXpyK1k1NDlQSVh5WVNZeXdlelhSRUw5bFNCU3lo?=
 =?utf-8?B?dmh3NXpVL29YaFRaV2gybHRQeFNFOWk4ekJuSzlvOS9HTHM0Y09SM0haU2hx?=
 =?utf-8?B?QUp6WW9WbFM5RTFOSEV5Z1JqQVVQMlIvT3RNSVJMTnJ4TG5HS2ZEVW14VDk2?=
 =?utf-8?B?TzRmYVZiMCtpdHB0QjdtUko0NEwyWjZCWkhIWjd2Z3VZOEF4R1MxZnRwajFW?=
 =?utf-8?B?SldqWmRUTkI2TWhld2Vpak5laXE5U2ZmK2p4ZVI5MVc3Q0VRQkFnYi9DVFYr?=
 =?utf-8?B?U2NXaTN3MFdscHV3ZEtDYjNjL0R1cFczbWlLN0RmcUswM0lZa200TS9ERE1J?=
 =?utf-8?B?UHY2ZGcrQm1VZWszckQvWlBSQWlFYjNtaHVBTURxaTEvd1FZaVBPT2xxS0x6?=
 =?utf-8?B?K3dMbGZ0RkdBK2xrcXduV3hRQnZnTno1WGpnajkwWjZhTGt0bExLVkVPOXdX?=
 =?utf-8?B?RnFBRlRXY1FmSFBSNjQ5OGpxNHNvakNjeEo5cXFvelphWk8rVlBJMnI3djc3?=
 =?utf-8?B?MHNmQ0J0OFRsbGdMN291M0NDWXdqcW84VzZqckFheTMzWTZ4QnBaNSswZGo4?=
 =?utf-8?B?Uk1Ra0xLbTZldnAvZ1BkTXluV1VqejluU282MlA5d3k0aFFuYi91bDdRaGFH?=
 =?utf-8?B?cTlYOWQ5RklMejBzYitYSHRvSExkaFhkcFF5ampKandsN0dEM040TzZtVENs?=
 =?utf-8?B?ZUlHTEZyb1pKR2JEMi81UnJoNzJZRUo0eFdhSDE4YzJ0YWlmY3ZvWXBxYmF1?=
 =?utf-8?B?eFVWd0paZzZ0TXVJWldwM2JZdnh0aWE2ajdtUkVBcWJUTEtRZWJVNExETkti?=
 =?utf-8?B?d05qK0V4UzBtKzFnK2xIWjlMR3lPam1PYUo4RTFtbUlkY2lRUUVKQVZQYisw?=
 =?utf-8?B?UWxFa2o3SHJTRmlmdUd6WmNZQUFDZ3BldktwNUFMTzRFQmx4NlJjNkRmZm1T?=
 =?utf-8?B?MjJ5R0NhSFR2cnpGaDZzVEl6OWdxaHdTN0xFcFVQWkZNemNNN0I1THBuRVIz?=
 =?utf-8?B?d0JmdnBCSHdUNFNpNmFuNFJrdjYvcjhaVEROSFlZSmJuWnNwNEtKSmt1TzRW?=
 =?utf-8?B?T2NocWY0YTYrTkhMUlh3Qkc1aHg2YlE2QU9WZDRjbE9ER1dpcVFoWUl6MWVu?=
 =?utf-8?B?Tm0raS91RFB1azNrRi9KdVNPYUl6VUdUeDVweTFmc0JhVlBNZlZXaWZqQW54?=
 =?utf-8?B?Q05zSW51ZVJnTVE4RCtxT0xVZkJoaTRiMW5YZ1BJcGlOa0x4Vm9ZK2lOOXZ1?=
 =?utf-8?B?alBheEgySVFmZUp4aW40VWxvTzB0Z0drdXB4b3ZkQTdYS2pvOG96bXlob0o4?=
 =?utf-8?B?OVp3MmhZRVgzS3FSVzNxdmRsbDY4dlVGVkZuUm83ZWVSbHZVR0RxYTNBVnVy?=
 =?utf-8?B?THRUWG1HOTB6R2RPVk03VWRuZnhabUFpZ2lLUlNrWjhyUUF1VUJsWWZDaTJT?=
 =?utf-8?B?bEg1MlZEL254ZmRMOWU5T2NueG1YNmJtZ3JCdy9JVytPMVRPeXo0QT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50d1ab0b-0301-4568-ad37-08df23168d2d
X-MS-Exchange-CrossTenant-AuthSource: BN7PPF5F16C5C9C.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2026 19:26:27.6814 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Zr5hdt/yGUIF1I6cK7fbKpuwaYlMXQX1VJ6oojCdluEIRLkEBZIo2Np6QD3Dh1R9t+SlRFPZ+d7cR5301AhM/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6283
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

On 2026-10-05 03:41, Christian König wrote:
> On 10/3/26 08:38, Olivier Kaloudoff wrote:
>> On PCIe surprise removal (e.g. Thunderbolt eGPU link drop),
>> amdgpu_device_fini_hw() calls amdgpu_amdkfd_device_fini_sw() when
>> pci_dev_is_disconnected() is true, which frees adev->kfd.dev and sets
>> it to NULL. amdgpu_device_ip_fini_early() then runs a few calls later
>> in the same function and reaches kgd2kfd_teardown_processes(), which
>> unconditionally dereferences adev->kfd.dev->kfd_processes_count.
>>
>> Observed on real hardware (MI50 eGPU behind TB3): NULL deref at +0x1b4
>> (kfd_processes_count) inside kgd2kfd_teardown_processes, called from
>> the pciehp removal thread; panic via panic_on_oops (pstore capture).
>>
>> Additionally, the wait-for-termination loop is unbounded: on a
>> physically gone device, processes can be unable to make forward
>> progress, wedging the pciehp removal thread in cond_resched() forever
>> and cascading into hung-task/softlockup panics.
>>
>> Guard the wait on adev->kfd.dev and bound it to 30s with a dev_warn so
>> removal can complete and the kernel survives.
> That is clearly a really bad idea. Waiting for the termination *must* be unbounded.
>
> The real question is why those KFD processes doesn't terminate?

kgd2kfd_teardown_processes sends SIGBUS to those processes. The 
kfd_processes_count is decremented in kfd_process_destroy_pdds, called 
from kfd_process_wq_release in a cleanup worker that is typically 
scheduled by the MMU release notifier or when the process ref count 
drops to 0. A reference count leak of the kfd_process or the mm_struct 
could prevent this from happening.

Do we have a sequencing issues? Should kgd2kfd_teardown_processes run 
before the KFD dev is destroyed?

Regards,
   Felix


>
> Regards,
> Christian.
>
>> Fixes: d12d05c4bc4c ("drm/amdkfd: Check if there are kfd porcesses using adev by kfd_processes_count")
>> Cc: Xiaogang Chen <xiaogang.chen@amd.com>
>> Signed-off-by: Olivier Kaloudoff <olivier.kaloudoff@gmail.com>
>> ---
>>   drivers/gpu/drm/amd/amdkfd/kfd_device.c | 22 ++++++++++++++++++++--
>>   1 file changed, 20 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
>> index 586e640..9326447 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
>> @@ -1780,6 +1780,7 @@ bool kgd2kfd_vmfault_fast_path(struct amdgpu_device *adev, struct amdgpu_iv_entr
>>   void kgd2kfd_teardown_processes(struct amdgpu_device *adev)
>>   {
>>   	struct hlist_node *p_temp;
>> +	unsigned long timeout;
>>   	struct kfd_process *p;
>>   	struct kfd_node *dev;
>>   	unsigned int temp;
>> @@ -1801,9 +1802,26 @@ void kgd2kfd_teardown_processes(struct amdgpu_device *adev)
>>   
>>   	mutex_unlock(&kfd_processes_mutex);
>>   
>> -	/* wait all kfd processes use adev terminate */
>> -	while (!!atomic_read(&adev->kfd.dev->kfd_processes_count))
>> +	/* On surprise removal amdgpu_amdkfd_device_fini_sw() has already
>> +	 * freed kfd.dev before we get here.
>> +	 */
>> +	if (!adev->kfd.dev)
>> +		return;
>> +
>> +	/* Wait for all kfd processes using adev to terminate. Bound the
>> +	 * wait: on a physically gone device processes may never finish,
>> +	 * and spinning here forever wedges the pciehp removal thread.
>> +	 */
>> +	timeout = jiffies + msecs_to_jiffies(30000);
>> +	while (atomic_read(&adev->kfd.dev->kfd_processes_count)) {
>> +		if (time_after(jiffies, timeout)) {
>> +			dev_warn(adev->dev,
>> +				 "kfd: %d processes still attached to removed device\n",
>> +				 atomic_read(&adev->kfd.dev->kfd_processes_count));
>> +			break;
>> +		}
>>   		cond_resched();
>> +	}
>>   }
>>   
>>   int kgd2kfd_reset_mes_queue(struct kfd_dev *kfd, uint32_t node_id,
