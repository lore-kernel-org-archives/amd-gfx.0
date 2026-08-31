Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E039FC61DD3
	for <amd-gfx@archiver.kernel.org>; Mon, 31 Aug 2026 08:21:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6CACF10E74F;
	Mon, 31 Aug 2026 08:21:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="AImnGa39";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010016.outbound.protection.outlook.com [52.101.61.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D105C10E74F
 for <amd-gfx@lists.freedesktop.org>; Mon, 31 Aug 2026 08:21:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VC23iK7Vntrac3pMeKBPGlO9kIL94NVEI5lHbsKxCY32gA/Ixt/9UqKB7t28BUaLQZvRBsY39qh+yinRToSUpLDODKQINONAO/9VWGluQEm8bl8c0HWueHKN5f7SB1FueqASVT2LygauWw8PvNFenxvt7l/eg55Df6TvyDzj7T98VkKnEdr+Tr2JfEhjVN4lJjqm+Z1A3w2SxtBg20wOqH5MrJb8EImzXZ3Tf23kPlwf1NRq2rQYEuPN6YhcjQ+mYJtcOXq76MhMZv+A0htmxQ0bbG9OvBtFv9EbX+xuIcRuE+8B7WLdKNSHVlUGH5VrzR4HuFnn5mVaxgKt97V0Tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YHV8RFZqa+7IO5391tgMUAAc3S7hicj7TMApg0f3XDI=;
 b=iiVWu1HgoztOJkwtexc+ES/iX2gtRZWjwxG6GPBFvB3DZg3Q45k/d/K4n8mTkEKzYkg9b5lHZO+zvcbu9w+AI3ulHQ9Q2wdKHs8zOVGplBerLaagh8D7Lw9ZlVO7UH5dDTj7WO1Q7hjpOycyz539st68wSuP2rmSd9YIYNiETHxE+qzKZnBkiyprWvAhNkj6WC9gBl5YBJrcLfpNR/GpJ/Dj+N9otutwtEWijq+xzumng5dAMX2ByofltzH94nARWmmxVD8yFE7jyWHDPM6MMVAd6oymWIXqqWT4AWm+/xUCcDKePpsPMzlDrL6QnH6UwUpl3le8P/FDmYvBTLdCOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YHV8RFZqa+7IO5391tgMUAAc3S7hicj7TMApg0f3XDI=;
 b=AImnGa39jPMzaXQhGwxg8tQsPj9GFqvGWX2iZY4mVlA8ZTC3ZweWjXKbfNgQlJDpHPiFRprrIcdctXrQIKeBUAsTvsJysWUkVwov4XgeIks+NSpi8Ej36aI6tbi7idzz8f+SDzjG2Cn9IfSgn3EaepGmB0cbBSgLiG/FULtJNis=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CH1PPFDA34A4201.namprd12.prod.outlook.com
 (2603:10b6:61f:fc00::625) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 08:21:44 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0339.007; Mon, 31 Aug 2026
 08:21:44 +0000
Message-ID: <a46a12b8-d9df-4995-beaf-6d41150196bc@amd.com>
Date: Mon, 31 Aug 2026 10:21:41 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/10] drm/amdgpu: introduce
 amdgpu_lookup_queue_by_doorbell
To: "Zhu, Lingshan" <lingshan.zhu@amd.com>, Alexander.Deucher@amd.com,
 felix.kuehling@amd.com
Cc: Ray.Huang@amd.com, amd-gfx@lists.freedesktop.org
References: <20260828095349.9797-1-lingshan.zhu@amd.com>
 <20260828095349.9797-2-lingshan.zhu@amd.com>
 <bd072438-32ee-42bc-bc06-ae29775cc2a5@amd.com>
 <2687ad99-61da-457f-9705-766bf48b2d04@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <2687ad99-61da-457f-9705-766bf48b2d04@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0029.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:14::16) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CH1PPFDA34A4201:EE_
X-MS-Office365-Filtering-Correlation-Id: e5a122c6-15cc-449d-8c3e-08df0738e471
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|18002099003|22082099003|56012099006|4143699003|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info: AcWKrNP7/WSAl65GF45GjzWADr4JtR7EeLrQETyw7AJJNPAsdvN7+oZSpI7ynzMqser9UzLMamWwhHmOdFz5/K85ucKoU6dmDT9dqAXPsu+3wZNJXyRuGuhZgFt4IlPdf1XrRo48SglEv/mrph3p5QveDgx16XXBxZ3oG490Uj+fROHqsAb+07syxl8SgTyni7uEsJu340rYeZvD0PjHt/pogU0haesTVYjltKVER/Kq2Po6VZ8b1NiH7OYkX4+SPy+UDPNhuZYiS7wymHGZkSAmMTa3JlkuNq+Tpx8nsKiKIx92mIu9uVWm8aRo0M7qCCvrfx8jcl3XJaCMme/f7pROrBqkNqyWb6sZkBAoz/9NDAfv0x09WT27UieVXcJf6vmKCChKFppcXq0SQgwerBSXM6aW2/Cys+D1f53H+6qDCOOe903ChiWRuWyg7rnjp0d4XuHktRhdeJkcN57DHwt6uRYkxFJR0hBKsgPE1Mi3oiIBzHVfvOq8J0+iGgj17bSg1X5HoFEZFHtuuFxNs4UcEs1S+DNuVolx+fHGMNVK4VnX7yYxknQkLo87Ke9a8fophF51cmpy59gHA7V9z4rQUPJLwAp6ip4m5Apc/GPKeYsSOu3ZEIKMG5kNGvkWbtz93UjVr05bQIDjIbkh6opt3KnJpypAFIfFmo7uZDc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(18002099003)(22082099003)(56012099006)(4143699003)(11063799006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S2poM0FiZ1VmY2hKSzhYdWpTNkduSWVhbXdLOExLN3JkSVQ3REY5a0Y3MUFy?=
 =?utf-8?B?aWJ5dU5mYnFVZDNKaGl1ZndVVk5teEVoZmdVUFk2SklmREwrRDQrK3QrWXB4?=
 =?utf-8?B?SGlUdU9WN2UzWkN1MVFla0l2TSt3Sk1IM0Nla3FLRndaQVgrMEpZemZZL3d0?=
 =?utf-8?B?c1phUG8xdmpoVzFEVmRTei9ZU0U5TkRZUUR6Y21FR0I4dDZGSVBZSm56TG1t?=
 =?utf-8?B?TzhEOUtYZG5LSTdWNWRyczdpN3BheWhqWno2clNPV1d4S3dQUGNkUGphQnNK?=
 =?utf-8?B?L1Z0NXF2RUpEWFhXTWZnZnY4UGRLTW9pT3l2U3ZqYXIxZjlmaHJJMGUxeVhW?=
 =?utf-8?B?TGpQNC83NjAzTmpCcDIxQ3BBTDROVG8wZUI5ZkprUzY3em1iNmVNcGpLeUFa?=
 =?utf-8?B?bzltVDQ5dUI3aUw1VUI1NVdtaE1nbDIra2JEenBOTlZ6bVo2SlpuaXRjR0VL?=
 =?utf-8?B?NnVtQUV5cG5QRzVWNndvUU5EWndsbWpaTzJtKy9QYW4waEY3ejNiS2FhSHdX?=
 =?utf-8?B?dGlON2lFQ010Ynp1S2hIQmdhYUR4SzFieUNLWE52a2QrU0NLUE5KYUZCMUh2?=
 =?utf-8?B?clRHa1dZN1pPcGt6blp6N0tHVThhM3dZL2xOam5UKzdBWUNjNG42TWNTaW02?=
 =?utf-8?B?aDRCTGo5ejI3dWxxZnc3WlBEbzFCaW9qZDRsMVl4WHAzak95eHZPckVYd084?=
 =?utf-8?B?Zjd5WXd4TEFpZ3UraXg2ZGFEVXl3eHYrUVRVM1JzQnlXTDhTSUlCbzNLVFdT?=
 =?utf-8?B?bWpWVktqd01lNjlXZ1BLQTNPcTJrczR2SlVWTVNYNmdMcTU2TVVEOFVlQVFG?=
 =?utf-8?B?Smp1YnkraFRCdGFJeGdHM0dlUVVwZXVTSDVXTWxoQlU3cVM3eDdqNzArSVF1?=
 =?utf-8?B?U2JQdWRBZTZxQWcyb1NTN0NIRUtuYnpjRXY3U25sUml2OGQ0ays3OWlEZkdr?=
 =?utf-8?B?WWl5dVpYNEo2U2I4TzUvU21CS3lUVHNCSldoaDN6OEROT085UUtIVG50b3J1?=
 =?utf-8?B?MlZ2dXhKZEhWZUIwcFRmMlArcENKbUpNRmtSRFdoMjk5YkxXNkJyTHkzRURR?=
 =?utf-8?B?MkYyblk1S3pmbXVJY1UrL0JRSzFvV0JsdmhKbXRFY0orNjVnZjZ5V0F3YURM?=
 =?utf-8?B?MGwwazNUWm0wTmhqZjM3RTVSWUFqMTFGcWpHTGpaUW43YVE4V08rL3J5UktW?=
 =?utf-8?B?RVZUcnQ2NkpUQnJjTmViOGl4QmwwcWZwaVRSZlY5L1B4UkluQ1F5WXlJblBW?=
 =?utf-8?B?amYwUkI2Zjk4RlBuOFBQa1R0NHRmRzBPSGJBRmQyU2l4ZHpDdEFsUEZIRng4?=
 =?utf-8?B?SUxkeElnYTY3NEpqbllBOXVmMjUramM0U3hoeW9RbEs5VHhOUGFMT3U5ZjE3?=
 =?utf-8?B?c2J6ejl2ZDJEVkd6cXBtUDV1ZWg2N3lQRnpOVEhYTWxiT24yVW1qUHFERGZ3?=
 =?utf-8?B?bmtiUkxHbEZBd1FIRXBjQVU3ZEp5OWpLUGRyRTl0dFZNVHFwcXZpYVlMdHpC?=
 =?utf-8?B?WEF6TTB3UjBaekdQRUIyN2hoWUo5MnlDNHZqbHVxOWd3V1hMS3FaK2d1WHEx?=
 =?utf-8?B?SjZvR0VYYTB2Y1N6WnlwSHQ4aVNlV2ZoallFd3Z4QjFUVjBDNjBpeU9WQmJa?=
 =?utf-8?B?ekJORkpFS056SVZHeUZmamU4WmFXNEFVSWZsT2hnem9zWXFNNFJpZUwwUGV6?=
 =?utf-8?B?MUEySE44aGllay9XU0t4dHJoYW94UXRFNEVLWERKMzZxWmE1QVd3UmFETzFF?=
 =?utf-8?B?Vk9GU1JrOS8ydXovWnAzUjVBREpsTEY4eGIzTkNHVzMrYnRTWVJrYzVyZkRO?=
 =?utf-8?B?K3Jpalh2ZmNxRGRKT1JBZjY3VXkzRmt6UUFjODR6T1A4dFdyRTcvN09qd0dz?=
 =?utf-8?B?YzUrckZaNTZ2b3g5dXd6R2lnQ1VsTWxLd0tkNVpHOWVZVXFwZEVqWUloRlQ1?=
 =?utf-8?B?N09RTEZ2SzRQUTFWVTBNMzVqM2dldVVHdUNleW5Vc3dtSnJtT3hVR3p0dE1N?=
 =?utf-8?B?dEh4NEhPS3NNY0VCY0RmanhiTVJDSjA5d3ZiT1doaFI0NDdXOFlZUDNUblRi?=
 =?utf-8?B?d2FrNjVtY2lCQzdETEtVSG9BTk00c0tIV0NFVWFoRlNJcmFTUmx5bHN4eUs0?=
 =?utf-8?B?eFJpajc2SUJ1eC9ubUxqM3Q2cHBMRGd0eTFmL3d2b216cTJqd1NwYTFjOGhS?=
 =?utf-8?B?ajhuUWFmbWc4RDhEdXZQNTdPems4dTlTZFhPOEVtLzVVYWxhcllIeTR2MkNQ?=
 =?utf-8?B?cWtLU3pIa3g2RWtIcWxEYnEzbVNWWEZiM3NBMlZabkllQmVPVHhLZ29tbFQy?=
 =?utf-8?Q?xp7w1V62FrbdUUzvgW?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5a122c6-15cc-449d-8c3e-08df0738e471
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 08:21:44.5834 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b73M4Gd6RqUNtQk28dvx9G0VpjkB8Fz90NSJ0j1QfKIpd/W52DaUojV9vWyZhmzY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPFDA34A4201
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

On 8/28/26 17:59, Zhu, Lingshan wrote:
> On 8/28/2026 9:08 PM, Christian König wrote:
> 
>> On 8/28/26 11:53, Zhu Lingshan wrote:
>>> This commit introduces a new helper
>>> amdgpu_lookup_queue_by_doorbell which helps
>>> look up a user queue with the given doorbell id
>>> in a xarray.
>>>
>>> This function takes a kref of the user space queue.
> 
> Hello Christian
> 
> Thanks for your comments.
> 
>> Well absolutely clear NAK to the whole approach.
>>
>> This is the nonsense Sunil and I have worked quite hard to remove and we certainly shouldn't repeat such mistakes.
>>
>> When the userq needs to be used from interrupt context we need to hold the xa_lock_irqsave() or otherwise we don't have any guarantee that the userq, userq_mgr or associated fpriv went out of scope.
> 
> Holding the spin lock by xa_lock_irqsave() can surely avoid racing with the destruction process, however, it does not apply to all scenarios, for example, you can not hold spin lock in mes_userq_reset_queue(),
> because it calls either amdgpu_mes_reset_queue_mmio or amdgpu_mes_reset_queue_mmio, both of them acquire the MES mutex through amdgpu_mes_lock.

Yeah which is exactly the reason why mes_userq_reset_queue() should *NOT* be called from non IOCTL context.

> Another thing, out of the topic is, holding xa_lock does not guarantee fpriv/userq_mgr alive, for example, when drm_device->unplugged is true, all amdgpu teardown paths in amdgpu_drm_release are skipped,
> and the fpriv/userq_mgr is freed, no matter whether holding the xa spin lock.

That would clearly be a massive bug. Those objects still need to be cleaned up independent of device hot plug.

> So IMHO since we have userq->kref, lets use it to maintain the lifecycle of the queues. 
> 
>> Grabbing references from this side would obviously result in circle dependencies.
> 
> I am not sure, we should use the lock/unlock and kref_put/get in pairs in sequence, can you name some circle dependencies or AB-BA lockings as examples?

That is not AB-BA locking, but circle dependencies. E.g. A reference B, B referencing C, C referencing A again.

Regards,
Christian.

> 
> Thanks
> Lingshan
> 
>> Regards,
>> Christian.
>>
>>> Signed-off-by: Zhu Lingshan <lingshan.zhu@amd.com>
>>> ---
>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 30 +++++++++++++++++++++++
>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h |  2 ++
>>>  2 files changed, 32 insertions(+)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>>> index 0a816b3c5ff9..e0639f844a8e 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>>> @@ -609,6 +609,36 @@ struct amdgpu_usermode_queue *amdgpu_userq_get(struct amdgpu_userq_mgr *uq_mgr,
>>>  	return queue;
>>>  }
>>>  
>>> +/**
>>> + * amdgpu_lookup_queue_by_doorbell - look up a user queue by doorbell
>>> + * @xa: user queue XArray indexed by doorbell
>>> + * @doorbell: doorbell index
>>> + *
>>> + * Return: A queue with the doorbell indexed, or NULL if no such a queue found.
>>> + *
>>> + * This function increases kref of the queue, the caller
>>> + * must release the reference with amdgpu_userq_put().
>>> + */
>>> +struct amdgpu_usermode_queue *
>>> +amdgpu_lookup_queue_by_doorbell(struct xarray *xa, u32 doorbell)
>>> +{
>>> +	struct amdgpu_usermode_queue *queue;
>>> +	unsigned long flags;
>>> +
>>> +	xa_lock_irqsave(xa, flags);
>>> +	queue = xa_load(xa, doorbell);
>>> +	if (!queue)
>>> +		goto out_unlock;
>>> +
>>> +	if (!kref_get_unless_zero(&queue->refcount))
>>> +		queue = NULL;
>>> +
>>> +out_unlock:
>>> +	xa_unlock_irqrestore(xa, flags);
>>> +
>>> +	return queue;
>>> +}
>>> +
>>>  void amdgpu_userq_put(struct amdgpu_usermode_queue *queue)
>>>  {
>>>  	if (queue)
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
>>> index 6412a7f7b6ef..8fc73862f64e 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
>>> @@ -151,6 +151,8 @@ struct amdgpu_db_info {
>>>  };
>>>  
>>>  struct amdgpu_usermode_queue *amdgpu_userq_get(struct amdgpu_userq_mgr *uq_mgr, u32 qid);
>>> +struct amdgpu_usermode_queue *
>>> +amdgpu_lookup_queue_by_doorbell(struct xarray *xa, u32 doorbell);
>>>  void amdgpu_userq_put(struct amdgpu_usermode_queue *queue);
>>>  
>>>  int amdgpu_userq_ioctl(struct drm_device *dev, void *data, struct drm_file *filp);

