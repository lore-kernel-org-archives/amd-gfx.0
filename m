Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C75B5C982F1
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Sep 2026 06:09:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4264F10E6C3;
	Tue, 22 Sep 2026 06:09:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="yGgYXstR";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012017.outbound.protection.outlook.com [52.101.53.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E4C4110E6C3
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Sep 2026 06:09:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aePgxe9H2NzavwCnBwuHEyfaoJQBnCOJrYuRYzNmWTJagxO7ME/IsW0ag/wjmqQlwFE3bQUaQTf5IwHx3iU34xGV8A4E9SLtAHu8Q9q/tKRZ6koXReUFN3rU9aTJdrcWZFW21gkmyb7CVPY4JpIcKppWg8kSJkMLb6Paz5n1qg5vq2FX4v4Xsu05AvvRXINcbki8nRIXa2DO+84asqJR7ZAWiO+DhkX+TdgbHCtj6o1fRJnfZeFeDhJne+FQtBX0++2Wkxi8Z56hO4oBtAuyFbERDMa0kTTjWZbhwKhA/ghnQh7ECRQq6Qi43HZj6zCl5jJNaYXIAVWt0p0X/9c+oQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZY6gcoJLg2Zx0arpkQuFRIZM820Cepg0jXeepXqDfL8=;
 b=F+sF33mdfwxZIgxAlqQcaSlS245GNWTcuIKrEVpP7iPXA+RF0+ajvNYkM2oifKeOJW7woe/ESWn619O4f1sSZvTaJfylBD6ZT4FcdTivY/0txq06RGL93DB0jGQ4Tis7cRvZCylEzpvOC1p/L7WoxvmIYMUtVQ5km1K7GamOcORiU5Dk7UVPapC5CZgOMpjn3U+qO8OKEcefdu/MBe8LLn6TNclDyy7zRu1ajcOg+r2nSw6vA8RYSPVghIWyhM5AL223q+Rx67FWQNhXl2EuKDnqCLZWh3+LNXhR5WIo6q2twueLWGt5abbjLlJ02B7fD+Atejtj/kuCZuUqgoVJHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZY6gcoJLg2Zx0arpkQuFRIZM820Cepg0jXeepXqDfL8=;
 b=yGgYXstRLfwERMTuxRAO5tV2VlqGkHtNUcvLsJav7cUANolLzmmWUiIcfZVFuEUZ/V6PfYTVFJvSVj0UGhHK/OzhskN8B0Lb3CMTTJ8hWqot/f3d8fe7pf2OsxJh5xCS7yCnz23Ryy8klTAg01Pmby/eN7WtaR4lvm5espDiBf4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH2PR12MB9457.namprd12.prod.outlook.com (2603:10b6:610:27c::7)
 by SJ0PR12MB5610.namprd12.prod.outlook.com (2603:10b6:a03:423::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.13; Tue, 22 Sep
 2026 06:08:57 +0000
Received: from CH2PR12MB9457.namprd12.prod.outlook.com
 ([fe80::85a8:1df:840a:cd4c]) by CH2PR12MB9457.namprd12.prod.outlook.com
 ([fe80::85a8:1df:840a:cd4c%4]) with mapi id 15.21.0428.015; Tue, 22 Sep 2026
 06:08:56 +0000
Content-Type: multipart/alternative;
 boundary="------------TQDtp18W3NhM1NcDqVDD4GSk"
Message-ID: <5f576123-9f57-4da0-a6d5-fd0390e39f1b@amd.com>
Date: Tue, 22 Sep 2026 14:08:50 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/10] drm/amdgpu: introduce
 amdgpu_lookup_queue_by_doorbell
From: "Zhu, Lingshan" <lingshan.zhu@amd.com>
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Alexander.Deucher@amd.com, felix.kuehling@amd.com
Cc: Ray.Huang@amd.com, amd-gfx@lists.freedesktop.org
References: <20260828095349.9797-1-lingshan.zhu@amd.com>
 <20260828095349.9797-2-lingshan.zhu@amd.com>
 <bd072438-32ee-42bc-bc06-ae29775cc2a5@amd.com>
 <2687ad99-61da-457f-9705-766bf48b2d04@amd.com>
 <a46a12b8-d9df-4995-beaf-6d41150196bc@amd.com>
 <a34a1541-7f3a-4e0f-a225-f58b1292d6d2@amd.com>
Content-Language: en-US
In-Reply-To: <a34a1541-7f3a-4e0f-a225-f58b1292d6d2@amd.com>
X-ClientProxiedBy: SEWP216CA0120.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2b9::13) To CH2PR12MB9457.namprd12.prod.outlook.com
 (2603:10b6:610:27c::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB9457:EE_|SJ0PR12MB5610:EE_
X-MS-Office365-Filtering-Correlation-Id: b6733e5a-3086-4039-518b-08df186ffc57
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|23010399003|4143699003|10067099003|56012099006|11063799006|8096899003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: VdmQK+N3oUt3sDD4g5ylnW84zlhSnh8OB/T6rhPpDzlYCxzucbQqq8xD/SIKwOx8yEsvHtFSCUuYKkz7Q5Y9k2HJXQnlyMvMGVw0yPYvjvwRXGHT29SrgCXOSyEYWISzbarnVSMqh20Md3eXFBJtg+dA0s8/VYwFHzUrzVYTjr48FKD7UARrCVNKnbDvJtoyPkuLjBtETg9xkbn6PT/QRG4nTdD4hh4wQZB3HWggU3oNtHZ2Uf59Rz+bClTXc7GsKYoXsVOprjFqZuDfeg1yuRhb1SEThBa4g7NAkaFaMGfqsdW0HDytE+dFcTGVBbWQjt8pfwu/PWqn255omOGewE6PzVgiNvl8oXx7o2Eh8QeIh+bHhuHBfr3k+QcVLDva4TB4C40RV0qS/mrvJDotZdEVjA4sIcoHMp0D/5V7obHDXnyoE/yvM+X8MZGrXTUxFi7g4QzVxu/u8WkYm25dAG2+9wsRdYfPQo7zTnRvKPx6qjuctmmo5V4woX6Qtr2L3Q/oGK8cVIGJ1UmLFtFwBdDOxsK4MLvp9F/dS3lF129J0rwnwiGU1+SuPLX6KmdRiQIozvsqXzVYT+ImSkxYIrZ/IEqEun22+wrwIja7MuhIe4G9kEStCp2gMuwKoLZ/D8k13HM1gTsqUD1+fmptkXcay9LNugozlM3VGiHB+do=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB9457.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(4143699003)(10067099003)(56012099006)(11063799006)(8096899003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RFFRTXNxcHRTOUQ5eFJDS0JZSklGc3VQTTZJN3VySmJZT1V3SUtMMjg4U2ZL?=
 =?utf-8?B?UmNtdDQ0VkRCa1Nncyt2cFFNWFFGOExkdWxDOTZlSXNvd0dONDZjZkF4Uzh5?=
 =?utf-8?B?Q21DVTZDUWd5cjBGL2NHWCtCeXhtbWkwNE8zQnVHK0Y3cWxDR0FnNDlCQlow?=
 =?utf-8?B?WmZmNkhzM0RmaHNHaHlJSUoxRStVcERuOEVXZ2J3OFJ0eThESVJKS2pyNTlD?=
 =?utf-8?B?N0VSdWhNYUJ5d2JNMy9LYTZGTUwzYk0wRnp4UUFRcW5sRk8xU0RzaS9IamZB?=
 =?utf-8?B?eW0yMjUvWEhqTmRMd2VxbGRtWGR1bG9TcEFjMC84NGZ2MnlFVGcyZnlLMnpS?=
 =?utf-8?B?b2lOVHZQL09HRFJ5cVlobS85dWRwTks1OGRjb0xJNnVxS0NlVzIrUm1PRC9j?=
 =?utf-8?B?dkQyZ3NRRklkOVpGNktZcVdTVXh6ZE9JUEdFYUhFL2NrUExPZDd4L1RwTjhk?=
 =?utf-8?B?Q1lnVkVsMGFDMk5Edit0RG1LQmJhdUUwV3p5TzRoN0tCQjA3bjFLQ3NCY3c1?=
 =?utf-8?B?bmpDaTNnQ0wxQ3JuS2VSeERrTWhBVTBtQlBDbUJzMnhzdCszSmZmVm1DVlVO?=
 =?utf-8?B?cTRMQlBzQXk3Q0RrOCtISDJPdjgvaXNndHh1NjljL0huUkdhVmJ2cHlsdWFS?=
 =?utf-8?B?OEx6Wm5DaFVMNXV0MDhHRllUUEw0eHFEeDhnMGRVbmFKbFBLL0lwQmZsN25Z?=
 =?utf-8?B?eWRWU2tVRGlnR3orOE44UmJlT1NJS2l0NXljTjM1Y2VtYTNSRSt6TlAxNlJj?=
 =?utf-8?B?TWdtaC9UVTZnTk5vcGkvNTlOTit4Q0lWd1I3OGFHRDVVcnFHbmQ2Z3NFR3lR?=
 =?utf-8?B?K0wwTmxPTUd3UUN2OVlKTlpsQTd4TjQrUnFVdzl5VWhXK0NFaXF6TU5MUllq?=
 =?utf-8?B?SEVoT2hNQ3hiNm94SHpPOW5LT2RSaE8xdDhENW9qZ0tncmt3M2JjTXphdTd6?=
 =?utf-8?B?THNDVExiU2ZNd3NweERmbTlMVjVFWEJVaEhvWlJub0Q5RFgwQjN2eUFoQStJ?=
 =?utf-8?B?eUwwYnRVSlZyeVFkR2lkT3UvUzZCWklsd3BpaVZYcnA0VXlsd2xqcEpMS1Rz?=
 =?utf-8?B?ZUg2L0EzSnV6dGVQNjNPR0NsUkZ0RlV3UG92RUdyOElQKysvVTk0SVN2YUJR?=
 =?utf-8?B?Z2syenZ1S1hnUm8wVGM1Y2d0TmpCY0RrOG1HK21uWFJBM1hzM3V2YU5WOEtM?=
 =?utf-8?B?ZzJqUkR5RlVuS0tucjhyejIxaTV4TnVLZjhubXdkYWJVNkt2OU81dGtlcEo2?=
 =?utf-8?B?Z2YxeVVQMUhsUCtFbmF6QmNtbnhTWVQrVU1FdlYwN2hlOTlzZUFZeGhVTnVL?=
 =?utf-8?B?WVBodGdRaWNwQmQ0ZFdjMWQzZVUwQjNaQklyU1BaWi9FY1NuVkI3TElrMUtj?=
 =?utf-8?B?WUVTdHJ1Mkk2b0dZR1YyblUxbFNzdFQrWjRXUUtwck85eWlsZTI0Mk5UU09X?=
 =?utf-8?B?UXFFVUxXend4UldqdWJublhKNDl1emhNNEFjWm41cmdsQjQyemFBbVl4ZDhx?=
 =?utf-8?B?blllN090bW1wdHIwaDBIc1N1TkM3RHZoRDRISUh0eGlWR2FXc3pOM2g0SFdo?=
 =?utf-8?B?Wk5pdk9nZlRLRWNrSlo2Vk5lY3c0N3AwclhIaUtuWU9FVUhLMXo5ekVwY0NO?=
 =?utf-8?B?WC9LbkpweW5GSnRuZ0hLUDdVajZ2UlRrSUs0Q2NldHdyT0VtVGs0eHNvbzMx?=
 =?utf-8?B?OHJMWVhpbXVvTTlxNDAxdllGMmMrTDhVWC9aaXkzV0QxbTduN1MyWW9JVG1C?=
 =?utf-8?B?d3hmTk8wRFlXZ3ViRUdPZVpXZkFXSzZ3RUZrZGg3OU9teUtPdWF4YUhuT1NR?=
 =?utf-8?B?Mkl6a0tidXNxSElKTjBHdU95VFFOODBuMlI1cmdYTk1RaEpoQ09qT28rTHJn?=
 =?utf-8?B?bktjdG5FRDZvY05rbmRQVDRXbWdlUjcvT2JEQnN3WUJrVkNWRWY3RTZJTUVC?=
 =?utf-8?B?UmF5b0J4Ti82U2VJWjhCNXRhVTBwUlJtd29abS9qaFo1SmpjMlRuZUE5cmtI?=
 =?utf-8?B?Q0pHOVVpUnI4ZURDNEVXQXZIQ3lld2pjR05oQmFsSjdHem1rTHpFVVo5K3JP?=
 =?utf-8?B?ZTBJdW5EZGlRR1dIeTFvREZ6aG1VNDk0ekpiblJWTmJGNUxCemUwZ1hkejBs?=
 =?utf-8?B?a3EyaXVYcmRWL3VRNkU5ZVFZdzhUTUpaOFRvUy9pMHVFQmM3YitnNnZmTyt0?=
 =?utf-8?B?UUVlVWdtVlhIMWx4SkQrRDlrL2UwdkdmWHpWb2V2TkhacVZab1JKWm1lTEhU?=
 =?utf-8?B?a2s0M0tkVGxUNmxiS3NEVWdCVHpJdlJtOXFBSFZpcTNBQ3ovai9VSDNabERp?=
 =?utf-8?B?TklvZ04yT0hGNUhDWSt5cjFucXduL3haR0VTRWwzM1dnK3RBZzJuQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6733e5a-3086-4039-518b-08df186ffc57
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB9457.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2026 06:08:56.5454 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: siV7rPBWo9Ng3EZAn7PUc5VggMBJxeLN15gR0IKg7u5DrChbwf9H0haqTVbz5NJFxn+cjAe+eUu/L+RaoVEr3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5610
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

--------------TQDtp18W3NhM1NcDqVDD4GSk
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 9/1/2026 4:50 PM, Zhu, Lingshan wrote:

> On 8/31/2026 4:21 PM, Christian König wrote:
>
>> On 8/28/26 17:59, Zhu, Lingshan wrote:
>>> On 8/28/2026 9:08 PM, Christian König wrote:
>>>
>>>> On 8/28/26 11:53, Zhu Lingshan wrote:
>>>>> This commit introduces a new helper
>>>>> amdgpu_lookup_queue_by_doorbell which helps
>>>>> look up a user queue with the given doorbell id
>>>>> in a xarray.
>>>>>
>>>>> This function takes a kref of the user space queue.
>>> Hello Christian
>>>
>>> Thanks for your comments.
>>>
>>>> Well absolutely clear NAK to the whole approach.
>>>>
>>>> This is the nonsense Sunil and I have worked quite hard to remove and we certainly shouldn't repeat such mistakes.
>>>>
>>>> When the userq needs to be used from interrupt context we need to hold the xa_lock_irqsave() or otherwise we don't have any guarantee that the userq, userq_mgr or associated fpriv went out of scope.
>>> Holding the spin lock by xa_lock_irqsave() can surely avoid racing with the destruction process, however, it does not apply to all scenarios, for example, you can not hold spin lock in mes_userq_reset_queue(),
>>> because it calls either amdgpu_mes_reset_queue_mmio or amdgpu_mes_reset_queue_mmio, both of them acquire the MES mutex through amdgpu_mes_lock.
>> Yeah which is exactly the reason why mes_userq_reset_queue() should *NOT* be called from non IOCTL context.
> I think it is not about whether called from IOCTL, it is a common racing we should fix, and holding a kref is a low haning fruit.
>
>>> Another thing, out of the topic is, holding xa_lock does not guarantee fpriv/userq_mgr alive, for example, when drm_device->unplugged is true, all amdgpu teardown paths in amdgpu_drm_release are skipped,
>>> and the fpriv/userq_mgr is freed, no matter whether holding the xa spin lock.
>> That would clearly be a massive bug. Those objects still need to be cleaned up independent of device hot plug.
> I agree, when unplugged == true, means can not access any HW registers, so this bug deserve another series to fix.
>
>>> So IMHO since we have userq->kref, lets use it to maintain the lifecycle of the queues. 
>>>
>>>> Grabbing references from this side would obviously result in circle dependencies.
>>> I am not sure, we should use the lock/unlock and kref_put/get in pairs in sequence, can you name some circle dependencies or AB-BA lockings as examples?
>> That is not AB-BA locking, but circle dependencies. E.g. A reference B, B referencing C, C referencing A again.
> A kref is an atomic counter, not a lock, that means we can try hold more than one kref in a thread, and a kref not
> depend on another. As far as I can see, current amdgpu driver does not have such problems, do you see any occurrences?

Hello Christian,

I have not heard back from you for three weeks, I wonder whether you have any further comments for this series,
or shall I make any improvements?

Thanks
Lingshan 

>
> Thanks
> Lingshan
>
>> Regards,
>> Christian.
>>
>>> Thanks
>>> Lingshan
>>>
>>>> Regards,
>>>> Christian.
>>>>
>>>>> Signed-off-by: Zhu Lingshan <lingshan.zhu@amd.com>
>>>>> ---
>>>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 30 +++++++++++++++++++++++
>>>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h |  2 ++
>>>>>  2 files changed, 32 insertions(+)
>>>>>
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>>>>> index 0a816b3c5ff9..e0639f844a8e 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>>>>> @@ -609,6 +609,36 @@ struct amdgpu_usermode_queue *amdgpu_userq_get(struct amdgpu_userq_mgr *uq_mgr,
>>>>>  	return queue;
>>>>>  }
>>>>>  
>>>>> +/**
>>>>> + * amdgpu_lookup_queue_by_doorbell - look up a user queue by doorbell
>>>>> + * @xa: user queue XArray indexed by doorbell
>>>>> + * @doorbell: doorbell index
>>>>> + *
>>>>> + * Return: A queue with the doorbell indexed, or NULL if no such a queue found.
>>>>> + *
>>>>> + * This function increases kref of the queue, the caller
>>>>> + * must release the reference with amdgpu_userq_put().
>>>>> + */
>>>>> +struct amdgpu_usermode_queue *
>>>>> +amdgpu_lookup_queue_by_doorbell(struct xarray *xa, u32 doorbell)
>>>>> +{
>>>>> +	struct amdgpu_usermode_queue *queue;
>>>>> +	unsigned long flags;
>>>>> +
>>>>> +	xa_lock_irqsave(xa, flags);
>>>>> +	queue = xa_load(xa, doorbell);
>>>>> +	if (!queue)
>>>>> +		goto out_unlock;
>>>>> +
>>>>> +	if (!kref_get_unless_zero(&queue->refcount))
>>>>> +		queue = NULL;
>>>>> +
>>>>> +out_unlock:
>>>>> +	xa_unlock_irqrestore(xa, flags);
>>>>> +
>>>>> +	return queue;
>>>>> +}
>>>>> +
>>>>>  void amdgpu_userq_put(struct amdgpu_usermode_queue *queue)
>>>>>  {
>>>>>  	if (queue)
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
>>>>> index 6412a7f7b6ef..8fc73862f64e 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
>>>>> @@ -151,6 +151,8 @@ struct amdgpu_db_info {
>>>>>  };
>>>>>  
>>>>>  struct amdgpu_usermode_queue *amdgpu_userq_get(struct amdgpu_userq_mgr *uq_mgr, u32 qid);
>>>>> +struct amdgpu_usermode_queue *
>>>>> +amdgpu_lookup_queue_by_doorbell(struct xarray *xa, u32 doorbell);
>>>>>  void amdgpu_userq_put(struct amdgpu_usermode_queue *queue);
>>>>>  
>>>>>  int amdgpu_userq_ioctl(struct drm_device *dev, void *data, struct drm_file *filp);
--------------TQDtp18W3NhM1NcDqVDD4GSk
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <pre>On 9/1/2026 4:50 PM, Zhu, Lingshan wrote:</pre>
    <blockquote type="cite" cite="mid:a34a1541-7f3a-4e0f-a225-f58b1292d6d2@amd.com">
      <pre wrap="" class="moz-quote-pre">On 8/31/2026 4:21 PM, Christian König wrote:

</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">On 8/28/26 17:59, Zhu, Lingshan wrote:
</pre>
        <blockquote type="cite">
          <pre wrap="" class="moz-quote-pre">On 8/28/2026 9:08 PM, Christian König wrote:

</pre>
          <blockquote type="cite">
            <pre wrap="" class="moz-quote-pre">On 8/28/26 11:53, Zhu Lingshan wrote:
</pre>
            <blockquote type="cite">
              <pre wrap="" class="moz-quote-pre">This commit introduces a new helper
amdgpu_lookup_queue_by_doorbell which helps
look up a user queue with the given doorbell id
in a xarray.

This function takes a kref of the user space queue.
</pre>
            </blockquote>
          </blockquote>
          <pre wrap="" class="moz-quote-pre">Hello Christian

Thanks for your comments.

</pre>
          <blockquote type="cite">
            <pre wrap="" class="moz-quote-pre">Well absolutely clear NAK to the whole approach.

This is the nonsense Sunil and I have worked quite hard to remove and we certainly shouldn't repeat such mistakes.

When the userq needs to be used from interrupt context we need to hold the xa_lock_irqsave() or otherwise we don't have any guarantee that the userq, userq_mgr or associated fpriv went out of scope.
</pre>
          </blockquote>
          <pre wrap="" class="moz-quote-pre">Holding the spin lock by xa_lock_irqsave() can surely avoid racing with the destruction process, however, it does not apply to all scenarios, for example, you can not hold spin lock in mes_userq_reset_queue(),
because it calls either amdgpu_mes_reset_queue_mmio or amdgpu_mes_reset_queue_mmio, both of them acquire the MES mutex through amdgpu_mes_lock.
</pre>
        </blockquote>
        <pre wrap="" class="moz-quote-pre">Yeah which is exactly the reason why mes_userq_reset_queue() should *NOT* be called from non IOCTL context.
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
I think it is not about whether called from IOCTL, it is a common racing we should fix, and holding a kref is a low haning fruit.

</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">
</pre>
        <blockquote type="cite">
          <pre wrap="" class="moz-quote-pre">Another thing, out of the topic is, holding xa_lock does not guarantee fpriv/userq_mgr alive, for example, when drm_device-&gt;unplugged is true, all amdgpu teardown paths in amdgpu_drm_release are skipped,
and the fpriv/userq_mgr is freed, no matter whether holding the xa spin lock.
</pre>
        </blockquote>
        <pre wrap="" class="moz-quote-pre">That would clearly be a massive bug. Those objects still need to be cleaned up independent of device hot plug.
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
I agree, when unplugged == true, means can not access any HW registers, so this bug deserve another series to fix.

</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">
</pre>
        <blockquote type="cite">
          <pre wrap="" class="moz-quote-pre">So IMHO since we have userq-&gt;kref, lets use it to maintain the lifecycle of the queues. 

</pre>
          <blockquote type="cite">
            <pre wrap="" class="moz-quote-pre">Grabbing references from this side would obviously result in circle dependencies.
</pre>
          </blockquote>
          <pre wrap="" class="moz-quote-pre">I am not sure, we should use the lock/unlock and kref_put/get in pairs in sequence, can you name some circle dependencies or AB-BA lockings as examples?
</pre>
        </blockquote>
        <pre wrap="" class="moz-quote-pre">That is not AB-BA locking, but circle dependencies. E.g. A reference B, B referencing C, C referencing A again.
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
A kref is an atomic counter, not a lock, that means we can try hold more than one kref in a thread, and a kref not
depend on another. As far as I can see, current amdgpu driver does not have such problems, do you see any occurrences?</pre>
    </blockquote>
    <pre>Hello Christian,

I have not heard back from you for three weeks, I wonder whether you have any further comments for this series,
or shall I make any improvements?

Thanks
Lingshan </pre>
    <blockquote type="cite" cite="mid:a34a1541-7f3a-4e0f-a225-f58b1292d6d2@amd.com">
      <pre wrap="" class="moz-quote-pre">

Thanks
Lingshan

</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">
Regards,
Christian.

</pre>
        <blockquote type="cite">
          <pre wrap="" class="moz-quote-pre">Thanks
Lingshan

</pre>
          <blockquote type="cite">
            <pre wrap="" class="moz-quote-pre">Regards,
Christian.

</pre>
            <blockquote type="cite">
              <pre wrap="" class="moz-quote-pre">Signed-off-by: Zhu Lingshan <a class="moz-txt-link-rfc2396E" href="mailto:lingshan.zhu@amd.com">&lt;lingshan.zhu@amd.com&gt;</a>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 30 +++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h |  2 ++
 2 files changed, 32 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 0a816b3c5ff9..e0639f844a8e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -609,6 +609,36 @@ struct amdgpu_usermode_queue *amdgpu_userq_get(struct amdgpu_userq_mgr *uq_mgr,
 	return queue;
 }
 
+/**
+ * amdgpu_lookup_queue_by_doorbell - look up a user queue by doorbell
+ * @xa: user queue XArray indexed by doorbell
+ * @doorbell: doorbell index
+ *
+ * Return: A queue with the doorbell indexed, or NULL if no such a queue found.
+ *
+ * This function increases kref of the queue, the caller
+ * must release the reference with amdgpu_userq_put().
+ */
+struct amdgpu_usermode_queue *
+amdgpu_lookup_queue_by_doorbell(struct xarray *xa, u32 doorbell)
+{
+	struct amdgpu_usermode_queue *queue;
+	unsigned long flags;
+
+	xa_lock_irqsave(xa, flags);
+	queue = xa_load(xa, doorbell);
+	if (!queue)
+		goto out_unlock;
+
+	if (!kref_get_unless_zero(&amp;queue-&gt;refcount))
+		queue = NULL;
+
+out_unlock:
+	xa_unlock_irqrestore(xa, flags);
+
+	return queue;
+}
+
 void amdgpu_userq_put(struct amdgpu_usermode_queue *queue)
 {
 	if (queue)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
index 6412a7f7b6ef..8fc73862f64e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
@@ -151,6 +151,8 @@ struct amdgpu_db_info {
 };
 
 struct amdgpu_usermode_queue *amdgpu_userq_get(struct amdgpu_userq_mgr *uq_mgr, u32 qid);
+struct amdgpu_usermode_queue *
+amdgpu_lookup_queue_by_doorbell(struct xarray *xa, u32 doorbell);
 void amdgpu_userq_put(struct amdgpu_usermode_queue *queue);
 
 int amdgpu_userq_ioctl(struct drm_device *dev, void *data, struct drm_file *filp);
</pre>
            </blockquote>
          </blockquote>
        </blockquote>
      </blockquote>
    </blockquote>
  </body>
</html>

--------------TQDtp18W3NhM1NcDqVDD4GSk--
