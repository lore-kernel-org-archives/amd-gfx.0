Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BEE6CD37AC
	for <amd-gfx@archiver.kernel.org>; Mon, 11 May 2026 13:29:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 28D0F10E2D4;
	Mon, 11 May 2026 13:29:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="1KOjhdxS";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011006.outbound.protection.outlook.com [52.101.57.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2B8CB10E2D4
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 May 2026 13:29:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xi/O3lpL6t5/uKZbS159KZ23y+Ja4Bj+zFT2LDvgcE5IWIvQIXyEIEspyx74uIY5SPTEGtpJ8WBsJ882tmHGWEWkXqdNUkNILvDe+fhTME36Cdwb6TUHri97FrKe5EsI/QfPOeU6BET8MbZ48Y1cf17TYWMyPhj+RXatQ/0t1nbHif6PSFbuVIWJNiFt6KC3Biok4vtV7O++woO0WmPHF0v6K7N/KcUskDqZ6Yxwejl5qEmYUfJ8f8uuEgfTJf3HqnUpKl7Z117+wVcsSN+x3GpPZJquysNuAbjGIDrnQ8i+V3OiADd2iHY07mdlI+h0AGWUrq69sG+gWkBdJVdrPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9PPVp6wuchC+ahgmtClEGPVjVOe9wvo2hZoVBmZFSbI=;
 b=RjEeHFcp1oBnUUWehEquDiTUzIvh8nDKdp9ygIOcg2nUUSLquVtQpd2HJ7iklvdndRYMLKQxXnHh7Nno/78d3Iqk988hn8QdZUrvNJJzjI+qbpcoiED3LgKywlh2CGd3HrEWNh0TtcY2KLsF2VI3HFk1i9EqK1bvTkjEalRUL+fUAnhVbAoXttDQzZ4qgGCfRrvKqqtzUq2JUrWShsCOqUcHrxGht0tX1hg5uxrFL+d5r5Ib4ec0tg18m8XlQXa+ynSV3DQelBKYzEdECaxiDGUTZCnsh/t4xK37mqJH6gcxrBipMjdsqWIqZgCrJnOyEiXsF2ZI+jEbhP9R4NSVuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9PPVp6wuchC+ahgmtClEGPVjVOe9wvo2hZoVBmZFSbI=;
 b=1KOjhdxS1FHWKq82lTAm2ztVXuq87837ainIVTtGDbumdaBte9Uj/3wDwY8K3c8zgjYZkDMrd7Y/EL5ADJkWDiYeZhtYQ8PMSCtDAQ+nKkDoalN6bCZRaAXC26rjM7PyjDvJJShtcHMUrExRNEyGFbIrQKWwcCaAdL/g2BTp65s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB7794.namprd12.prod.outlook.com (2603:10b6:510:276::15)
 by DS2PR12MB9616.namprd12.prod.outlook.com (2603:10b6:8:275::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.23; Mon, 11 May
 2026 13:29:32 +0000
Received: from PH7PR12MB7794.namprd12.prod.outlook.com
 ([fe80::e0be:f851:96ea:cf85]) by PH7PR12MB7794.namprd12.prod.outlook.com
 ([fe80::e0be:f851:96ea:cf85%4]) with mapi id 15.20.9891.021; Mon, 11 May 2026
 13:29:32 +0000
Message-ID: <9d6a099d-ac6d-426f-ba65-9c5a3a632c5f@amd.com>
Date: Mon, 11 May 2026 18:59:26 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] drm/amdgpu/userq: pin mqd and fw object bo to
 avoid eviction
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Sunil Khatri <sunil.khatri@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20260508103910.2442183-1-sunil.khatri@amd.com>
 <20260508103910.2442183-2-sunil.khatri@amd.com>
 <450e8b51-4326-41a3-a504-d0dc630009d8@amd.com>
Content-Language: en-US
From: "Khatri, Sunil" <sukhatri@amd.com>
In-Reply-To: <450e8b51-4326-41a3-a504-d0dc630009d8@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5PR01CA0084.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1ad::15) To PH7PR12MB7794.namprd12.prod.outlook.com
 (2603:10b6:510:276::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB7794:EE_|DS2PR12MB9616:EE_
X-MS-Office365-Filtering-Correlation-Id: 443668e0-877a-4e4c-38e7-08deaf6155de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|56012099003|11063799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: B0x9TSZzoFwvuUfohgejOJLf9/LArg2D0oTHpg0aY/bFnaFw/kfoF0kdE9gESnRX7A2E9cz6RhMbbo6xzqfygt5l7fiO26NOMOIevPt82kJpiYpDP3z3Ub20JlLLVELGmyx+WwqpigOgb+CkJ9psAjGfRE6lveobD+lrTet4orMFrpdVwerJwrBiVRDAulN/tO3G37m/eZ68WfltkKjKGb43ZW7X42Nw66t15uv2wHshQMOeztAtdFL0jjA65khOI4tbXcFYpK1/6pxJsvSvqfHdTAlZBfvvbXx0ltlJ0ELR3liVPAOR12gq8CuSZ/RuyfxtNNWuSEgcJtnQIX9k/+/jLNSPU0ji1sAkPNqdN1cJ7wOre+IU1/aiYrY1mQ9WtKdY7hgkvmhC+mSEYOTUF0+ImFIWiMXbto4DETv/ESdyeqbtRdeWdfWkI1SSxEX9H9A80cZeXxtoFiewkj9DR65j1HlfKVVeU1xXgKIaDyvGW2Ynnm2Brn+I8aZRrpnrKhYGy1xPsNoLcPEdBp7fwvqJBxiXBqZo3hQRvepUCH20FFETlLAGFGUIPHpBwOVBOdyXp5FkPJ0tUDvAY/B25WRdaf/Ih3TeT041DuZeyDgA5mlpOwUs0K5bm+ouMKnALqPL4BRILpOkGouJ03iNw3Bwl/MGtG5XIlLi7RXLEI+CVEuLA+4w6KXpV35Nrj4U
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB7794.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(56012099003)(11063799003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dWFpaXVKYjEyODZSKzhjRkp6dGNzWFZZd0F3TkgyS09nVGRycGF0bGJIeGxM?=
 =?utf-8?B?OU1CSWNCK2wvajJYczNaUW1PUnRvdE0vSWlNNkdZM21MTFJZR2daWDJHbzMr?=
 =?utf-8?B?ZitRSG9TcUpzV2liS1pWckE0SW5qdndVb1hsY1laUXVqTmxod0V3ZFdHcXYz?=
 =?utf-8?B?QVJrUElIVDFqdVduMiswYkJJa21oYlo3TXZZbThEb0s0L0NXK3lGbHlYdDBJ?=
 =?utf-8?B?bkpXOWM2d294L1U0NEs2enlYbDRzUGpSdlcvdUhNVTR5eEI0SCtNVUVlZHBw?=
 =?utf-8?B?bjYwZjRBczFsSURlY0M0NUp6RmJpcnQ2VjhTdFc4c0V4U3pvNjdTeTFPUlAw?=
 =?utf-8?B?VjUwVlZScEpmckh0clF3VGpHZk9sUXVJU2FGRmVzSTYvNHErTVE1dTVnbEM1?=
 =?utf-8?B?djBMU0pUcndSNjVDdzRhTUJtZ0Y2MC9vZVRFamFJR2ZuN0ZtcnhYcEZSSXhn?=
 =?utf-8?B?emxOTkxhczYyT3dNKzdQYlN4RDNWcTZwQm0vRFlqMHRXS01YTDI2eHdYZTFP?=
 =?utf-8?B?L2NtVDNOVXc4Q1hTSGwrQXdsS084a2xJYjJMNisvUE5nN2k2WXN1WDVNb2da?=
 =?utf-8?B?TThQUFpxZWp6SlVHTFpzR1Y3Zy9qenV4REswbkswSHROUS9qZUQwVFB6Ull3?=
 =?utf-8?B?ZjZWczNSTnBvU0tXblVNZHNKMDFBbHVKRm1SU0ZpNVJCQ3lZY1hDMnJOV2Z2?=
 =?utf-8?B?UERrRnhRb2FnbHExbXRERTRsQi9ZWk1hRzh3TmcrS2xMQzRvdkllaHFFYWhq?=
 =?utf-8?B?KzZORDBWNnVlelVtcGtEa1A0bU9mWVFPUUFPWk50RFZ5bXJUOFk2cTNITytv?=
 =?utf-8?B?MkxOQXloc3pJQ29oVW9pSWMrRjh4ZWY4alZPallqd1VwcjJLQVhKMGxMU0Z3?=
 =?utf-8?B?dTA5NWhrdmY2aHBCbWR3YkIyQ3BqZW8wdzJSbHd2V0hweFk1RkhhZEt1L0px?=
 =?utf-8?B?Vnp1YzJraTc5aXBkbitmb0czQnk3dUhHc3MzR085UkRLQWM2OE8xSjkwL05V?=
 =?utf-8?B?aUJTVXdydUREaFllcGNjTWZWeU5PR281T3pTY3plUmpZN3l1ZE5UVFJla3NX?=
 =?utf-8?B?ejl6SjZoeGNucXpqS25ybmxwSVRjajZZSEdTelJCYWtQa0xpNDNoWnVhR1h3?=
 =?utf-8?B?Nkl0V25uM2xPSmdMVXNRSUk4L0VNQnRRcnRnZG9nVW5VZHVNUU42ZGtjYXVN?=
 =?utf-8?B?ZzZvV1puY1JiVzhxeXc1THdSQ3R5R1hPSUZOUHVOR2RMallDdUtoY2xXOHdK?=
 =?utf-8?B?S0Y5aGFKK2RBK3lkOXVOMzFRVVNQVVJhbTVxaXZnd3pqODF4dFJkT3NlRjJy?=
 =?utf-8?B?V2NqVFVZWlZQd3piYTlMNHFKUFRLTGh6YldQUnpDdEc2ZHA3bVkrUmhUMXhi?=
 =?utf-8?B?ZFVadFV6b2pBNmFrUHJ2cFVucFVVOW14cURocjdqTHNjN1FkWmNUcnhBbkFv?=
 =?utf-8?B?ZkorSXQySWhaNmp2T3p6SE9aVzdDbHJCNU1TRWdHUG1vb2NzUFpmUURsMFE2?=
 =?utf-8?B?OUU0azh2R1k0Q0hXS0ZsNEtNcHZHdk5tMmpoaG9BR3N5Si9POFJjR0xuSU1n?=
 =?utf-8?B?cEh3L2VMWkxkYTJxVitxY1FjN3prT3h4YVJSOG8vdkxnT0pHWE5XRFNiQ2Rp?=
 =?utf-8?B?emZ6YlQrTHBNNjZBK3JRUVpJQW42MGxYNW9qVC90NGNmYXhxWm9KRXQrUzBs?=
 =?utf-8?B?R2tyOVRKZHplc1ZmSGUxV3RvNThKM2tETGFzTXR1Sk1aUnI1L2xFRmEwem1H?=
 =?utf-8?B?SUxTZ04vdHFDUlVibkg1M2R6UHlJMEFhdzlRUjlDY3NjRUhnV0ZURFB0cWoy?=
 =?utf-8?B?ZWRWb0RXVSs5a1FyRDlzKzViaVVCUWdUcGZlT0FFWXhFcllLL2w5bEtFejgx?=
 =?utf-8?B?VVYzL3FiZzd5WmxpU3o0VG4rU1A2dFJIVUcydGxlN3MrN3IySkpOaXNkQ01E?=
 =?utf-8?B?SWRSdGtBL2lGTGRteXc5azRtYVY1UEhMU2IvOVNTcnVrVXdQT2pUcnBPdkhX?=
 =?utf-8?B?WE5UWmIxazJyTTdUWU9TajJkZVh0V1p3cCtJRWlrc1AvNUJmT3hrZit3cFpZ?=
 =?utf-8?B?VVQxdzZlNHJkWUtlQk8vY1NRUDVBODNYUzVQSDZvNFFncTYyTkxiVkxndkc5?=
 =?utf-8?B?UC81d0gyWFNta2FqclVsWTRWaFlXM09PWmNkcTV6M3lHK3FQKzdsWTZQSzJi?=
 =?utf-8?B?dDlkRmsxSitTME40Vy81WGtqNkpHdUo4S1dIcjBTN0U4anFvMUFRNTdYaFFF?=
 =?utf-8?B?ZlJHWmNSN2FGNTR5enFrTE9WNEhhdDd4SFU5bVFneW1sZWE3ZGlNYWhEcVZh?=
 =?utf-8?B?dksrTFBsbG1hejZZVnRTQ1l5NldtT2lmdSt2UUVIZnZXTW5nTVlvZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 443668e0-877a-4e4c-38e7-08deaf6155de
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB7794.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2026 13:29:32.5000 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qX4Cxrtttx9xy+5UEJ3W7NGnl1555DimzM7qSqVsJ8WsB5UsJ6A1wLd/jLk1rS+VjDUYFC5yUoxhegTq4oDwzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9616
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


On 11-05-2026 06:57 pm, Christian König wrote:
> On 5/8/26 12:39, Sunil Khatri wrote:
>> mqd and fw objects are queue core objects which should remain
>> valid and never be unmapped and evicted for user queues to work
>> properly.
>>
>> During eviction if these buffers are evicted the hw continue to
>> use the invalid addresses and caused page faults and system hung.
>>
>> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
> We should probably use the eviction fence instead of pinning, but that can come in a later patch set.

yes, that is todo but also on other hand these buffers need to stay 
valid till the queue stays valid and active so keeping these buffers 
alive is fine but yes associating with eviction fence sounds correct.

Regards
Sunil khatri

>
> Reviewed-by: Christian König <christian.koenig@amd.com> for now.
>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 13 ++++++++++---
>>   1 file changed, 10 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>> index 06b7b4228065..813df2d87dc3 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>> @@ -504,16 +504,20 @@ int amdgpu_userq_create_object(struct amdgpu_userq_mgr *uq_mgr,
>>   		goto free_obj;
>>   	}
>>   
>> +	r = amdgpu_bo_pin(userq_obj->obj, AMDGPU_GEM_DOMAIN_GTT);
>> +	if (r)
>> +		goto unresv;
>> +
>>   	r = amdgpu_ttm_alloc_gart(&(userq_obj->obj)->tbo);
>>   	if (r) {
>>   		drm_file_err(uq_mgr->file, "Failed to alloc GART for userqueue object (%d)", r);
>> -		goto unresv;
>> +		goto unpin_bo;
>>   	}
>>   
>>   	r = amdgpu_bo_kmap(userq_obj->obj, &userq_obj->cpu_ptr);
>>   	if (r) {
>>   		drm_file_err(uq_mgr->file, "Failed to map BO for userqueue (%d)", r);
>> -		goto unresv;
>> +		goto unpin_bo;
>>   	}
>>   
>>   	userq_obj->gpu_addr = amdgpu_bo_gpu_offset(userq_obj->obj);
>> @@ -521,11 +525,13 @@ int amdgpu_userq_create_object(struct amdgpu_userq_mgr *uq_mgr,
>>   	memset(userq_obj->cpu_ptr, 0, size);
>>   	return 0;
>>   
>> +unpin_bo:
>> +	amdgpu_bo_unpin(userq_obj->obj);
>>   unresv:
>>   	amdgpu_bo_unreserve(userq_obj->obj);
>> -
>>   free_obj:
>>   	amdgpu_bo_unref(&userq_obj->obj);
>> +
>>   	return r;
>>   }
>>   
>> @@ -533,6 +539,7 @@ void amdgpu_userq_destroy_object(struct amdgpu_userq_mgr *uq_mgr,
>>   				 struct amdgpu_userq_obj *userq_obj)
>>   {
>>   	amdgpu_bo_kunmap(userq_obj->obj);
>> +	amdgpu_bo_unpin(userq_obj->obj);
>>   	amdgpu_bo_unref(&userq_obj->obj);
>>   }
>>   
