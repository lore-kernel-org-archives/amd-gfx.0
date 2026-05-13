Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70F5DCD4851
	for <amd-gfx@archiver.kernel.org>; Wed, 13 May 2026 07:21:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E0D1010E05D;
	Wed, 13 May 2026 07:21:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="gVJVSWYl";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011034.outbound.protection.outlook.com [40.107.208.34])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 28BEE10E05D
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 May 2026 07:21:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IjsHEi/98BQsImIOCSgYP1K/1LNC0zO7ay6HxleIuqUaZi61uDTGARFY9ffLaKYLYGredG7mw9pkfU2HdEBRs/yHwJwXssIAvQabWa61tUcA+qd6maew0oqB3JHhp9A5fMwQo1vjCP8nm91RnMMCrTofD3w2ObQ4hc9fnDT82owfZ8QPtDY7L62a3roOumkCNxd6CVFR3zI34J4yK36x8jKR+uEDYokEk9sLPTDzUgfafEhrSWlsrhtEDLIhVlse2tY67+nRDcg6w6v6s3zsyBam2Hz1aisxoDWfX2dai3QjpMSqZOhTc2jmR5NtGWbzJAGx5j7SlJdIoOGeEkLwbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AnrU6fWqtUurVwrcN4IN82rMo/1hxvuwRvsmgGqfJLk=;
 b=ZITIPr8Jfqml2bTW1ZUMLQwfvuM/2Cn175//9ZPLcG+8NcfXp8aHRjvCuB/vPxGiPgEeDnDVa6xs0aWD5L3WMDppcWl3aKWT145ZFOJN6d9kQ6uGlGyvJqmVrvHFSUW1i2USsfso09B7FIovp5+Jo40J0XmFKzI12Qjm9F9DcX8eNucTpHF/Afjsd20WfKHcTWR0sTSr3SeluD/hi9XVaf92EE5ZHsv+nveM0DpAEh4plb31g+4y+t2aNrq8L9BqC2yWmz8GizhvR39cPFMQY9wjFEfaIZ6fyenXj0S8EcTHFx2SLq7Z6e48/EXbtHQufnWLXnbAQkZeksnHlKpjUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AnrU6fWqtUurVwrcN4IN82rMo/1hxvuwRvsmgGqfJLk=;
 b=gVJVSWYl9wiWQx7p+vZ15gsHKLNiSi5MXdCC5d5EHgvjwisTnrgx7sVLXbV0nzoLD+whR3kw+91xy/org94hXljtTgKogAq9oW30ZOejobG4wmUVMOmzf8W4N7D4Qic1TLjGYGHi/W5zrtdGBI/dLoAOdNNi6p5keBZVSRoYN4Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by PH7PR12MB7891.namprd12.prod.outlook.com (2603:10b6:510:27a::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Wed, 13 May
 2026 07:21:29 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9891.021; Wed, 13 May 2026
 07:21:26 +0000
Message-ID: <07bb4f58-47cf-4ca2-9ff6-d59d69d43715@amd.com>
Date: Wed, 13 May 2026 09:21:20 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: remove va cursors for all mappings
To: Sunil Khatri <sunil.khatri@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20260512193045.1279817-1-sunil.khatri@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260512193045.1279817-1-sunil.khatri@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0195.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ca::20) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|PH7PR12MB7891:EE_
X-MS-Office365-Filtering-Correlation-Id: dec50b1d-dbd6-4a2e-f0bb-08deb0c03e3f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|11063799003|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: +jtH6HoDgIQ8bKPVOPfoZ0vSZAjQV5fX7B09X7XNyYMm6nbOH9cvd49ByBzxV1sUixnDfIqgMbR6Rh3gjhzuZYSPnOHQpbyqdplH/brnyxSAVr6dfVMQwd6vjyQtGQcZKSKs96XruPzTxipEySeyPv5m6gwkYvQ7lWQd84S8Y5buxd9ZCQq3Sa/sybDxaGOnXXbGvFaLqjkiYkODe3UxKj28PpZzCb0WkBdp2fOFLd/ynN+ZVzHkyIm8wjbHVUNOGkHXZ2uFwuF0XGgrhdcUX51YvQAiG8N8e82ZvokKqxBwVKFmfDa3IY8UhhXsose0I7HRboLgiF6u3Y2kU/kmibLkqa4z6pX4YvA3oiVDd+AuJq6uItTv8gPInzMLfc+gXqWghXuPGIEYdxx6SCNe2fxZV2YxBeKEr7dHpaB6R912fQSdVUHoA9p5XhcMTk0gIa7qVfA2Gyn+/Upci1iss2WO2HXV7Zl7VeiV0ysDQoDIZbfxyZ+Lvz5zJCfu3BSIUrTvYrbmD+GrPFXfGliesKCQpBTxJ9cSmkIeV7/hWAWNjfqgl7sZPJjv0pNYey+AILehDV2d5hyy0NhMCfkIIyGtxvQjsTMuzLe/YgQafPg8JM/MWalSHPX8XTyTilPl2gzEeRq0+kQWManCy6wePKaOOhGLtD5Z2Hl6hX5C0Uab8tJG1bsUhoCel/T+/ocU
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(11063799003)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UVV3VzVPWWNOZmxHb0ttWGoxUy9PZ2kwdE43dXh4NEVLUEJoM2dWYlpFOHZu?=
 =?utf-8?B?bUcyeTZma09FNXN2NEpUR2I1amxnTU50MGVRUHQ3WGNsR0ZsQjEwUUd0aFlZ?=
 =?utf-8?B?SXd4Q1JQc0pZZmhZZDcvbTFXcmthQlBhZ1kwakhUY2JiWncwZEw3R2VGN1dU?=
 =?utf-8?B?S1NkYmpFYlRQVlZub25Uc3NYNFFJcGRBTC9DMjM0SEY0dDB3cTJLZWI2WlJo?=
 =?utf-8?B?dmZvbDhvN2Y1YTFoc0FsbHU3TlBRakhJdk1lOHgzdjJuTnNVaExvZVRxcVh2?=
 =?utf-8?B?b0dUN0x2Tk9IOWJSZG4ra2F3QVNMT3YwaHNLM0N4VWQ3dDlOV1ZzWUVDYldT?=
 =?utf-8?B?d3NuT053MWxPMjdUbTRSbHl0dEwycnJMS0NMK25BQm84RkZVRXBNQkFpZkRS?=
 =?utf-8?B?RFd1UW9kSFhjTDBQRGYvem13K284d3ZXWktWczUycDNKQ2JvTWZ2R24zUzRa?=
 =?utf-8?B?VzdiWi9tRUlINlR6TU51UkdwcVRGU1N4eUdZRlhlYmNOVGVyci93VXJYY014?=
 =?utf-8?B?N2R2TVVyWmRTeEN4SU5SQ0M1a2FycmNVZHBENVRpOXBuYXl2amRyUGppRkVn?=
 =?utf-8?B?SHh1VUhlQWQ4V1BZNFJlcW56ZUhnc0xCMWE0RCtMTUZzTzlIL2lDVlh4UWl4?=
 =?utf-8?B?V0YxbEtob1M5am1reXkvVnB2RXd0UnVSek1DVXZvV29VZ0ZYZnp1K092WXp6?=
 =?utf-8?B?WkFRQ1pwNTRONmI1UXZkSlc0RzlQUG1nUXdkTHNLamVncTFORWw2VVJlNlNY?=
 =?utf-8?B?b0Y1Qk5mMFNVb2FUaVFId3pjdW1FYW96cC9KR3Z2cWZqQVZ3TENTYzBYa1N1?=
 =?utf-8?B?dmVHcDZKSHlwWjEyME8xaXlDZGs5Vm42eXVkVHJ1MWFTWlNiVXFqQjZkL3pN?=
 =?utf-8?B?YVM3c0k2STdEVk5VMVV6L3BOZm54NXRIY2pscDNxMXdtQWp2L0ZoOGRKN2xS?=
 =?utf-8?B?TmtHeVRLMVFWYjFTRXdzdGtvNFZnaWpsUEJjQmFFY09DTUJab3BWaU5wMytk?=
 =?utf-8?B?MXVIZXNRcHhsZHVSbkdsRXdKU0EvR3k0VUNUaVhYWVhtSXQ0Q1hsQXlFdCtC?=
 =?utf-8?B?Tjk1Qjd1Njl6SmVpMlFlS1dDNjd6bFU2VXc0OEVlSm54bk5kOXRDUkRuNzBm?=
 =?utf-8?B?Z1RlOWVxRDJOQnVKaFBSdGdWV01EWkh0VCs4OVl5a0JKWWh1NUVoUmhaM1NF?=
 =?utf-8?B?N3hHbzNUM2FxNFA5RVpzNVcva2YrSWpoeEg2YjcvblBBNVpWUklxUERJblRV?=
 =?utf-8?B?emhpUkN5UzVvNlhuN3huYVJSUk05eFlMb0ROdXo2ZmRFUXRQMzE2S1Y1QytE?=
 =?utf-8?B?d25Za1ZUWms3dkFucTB4WmJ3SERvb3llNkNFZ25sTnhrVzUyWFhhRlVQaG1a?=
 =?utf-8?B?YTh3R0ZOYlVVNzBidDErUThxajBOV3E1a0RZS1VtY3hQSllxK1M5bHlNYnFE?=
 =?utf-8?B?WFoyaGIwczBWQ2trVEt2SFJCS0cyc1IvUzV2dldOWHhGdTF3MkloRHhiaUtD?=
 =?utf-8?B?WkNYRVhpK05LUCt6WGFXY2JtVnZDNDhBYkVjekxoRlZ1dE1xRjMvWkVxT3hN?=
 =?utf-8?B?ZDJvV0J3aEROLzd1NEJMeVB5SU9qbFYyQXNaUEtzZzRyam1VRXJyNGVlNWFB?=
 =?utf-8?B?QjRXWjBUUXVHc2tJT3dTdEd0akNEK2ltVGxQTUh6TWVqVGtpZlhoaHlUNnZK?=
 =?utf-8?B?SkFSd3RuQ25ZT0pjV1RwM1pNbk9Ra0I0cHV1QlJnM3F2VXlCQ3ZDNmVyM0pI?=
 =?utf-8?B?Mk41TXkxR3hlVFpEakljWTZXZW9scVQ4d2FrZ2JXNmtvTEhIaTdPeHJnR3Q5?=
 =?utf-8?B?MitwT2FyYjhsd0k2VHRaSThBejNQaUEvNTlVbE9OdFY5R0ppZjBjQTQ4RWVX?=
 =?utf-8?B?dUpDRzVzWW5POFJVRy9XYTN5OEI3cCtnZm95alZLSUlhY3ZieElPOW9Relhq?=
 =?utf-8?B?cHpNNjRDR1RYbmRFRUJXWTlPVlRGTGd0LzA3d0Q5L1p4Ly9qeWZpelVuNXNa?=
 =?utf-8?B?TitXQ2dlSU11UW82bzd5dVVBTEw0aVdiTGpLSE5sSWlpY0ZVQlI2QXVueGVQ?=
 =?utf-8?B?cFQ5RHNiMk9LUkZ3SG92WkFMTjZJR2JhNk9XakZXYlFXMERJVVdiSUlUdzJz?=
 =?utf-8?B?MjNXdFpOOWwzWkdxNWhrUlUvZ1JUR2RWTjFublFHNXFIbURKOTJjdnQrYVhQ?=
 =?utf-8?B?OXc2T21RT1dvVXJxK0lmQnltdEN0WW1xblQwN21sUzM0aml6Y2ErZWNQZ1ph?=
 =?utf-8?B?VFZQTG92ZThkaVpiVDc4N1dLLytoOGhnNU5Ydk5yK1lXYnhlcG95ODNWM3JV?=
 =?utf-8?Q?/MePuUn0az9Sljq+bL?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dec50b1d-dbd6-4a2e-f0bb-08deb0c03e3f
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2026 07:21:26.0052 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DG9koAKJAJ94QAVRRq6ddnhqB3RbJXYpUiQWXAhK/4OuyD5t73Gi8ZLrEu1ujUNX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7891
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

On 5/12/26 21:30, Sunil Khatri wrote:
> va_cursor struct needs to be cleaned even if the mapping
> has been removed already.
> 
> Also simplify it by make it a void function as return value
> check isn't needed as its called during tear down.
> 
> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>

That patch here is Reviewed-by: Christian König <christian.koenig@amd.com> for now since it is clearly fixing an issue.

But of hand the userq_va_cursor design looks like it could be improved.

First of all bo_va->userq_va_mapped shouldn't be an atomic, but rather just a flag/boolean.

Then second we should never set this flag back to false since it can be that multiple queues refer the same buffer.

Not sure if we should fix those issues in that patch here or just commit this patch alone.

Thanks,
Christian.

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 17 +++++++----------
>  1 file changed, 7 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> index f62163917f70..e325c7a350f9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -303,13 +303,14 @@ static bool amdgpu_userq_buffer_vas_mapped(struct amdgpu_usermode_queue *queue)
>  static void amdgpu_userq_buffer_va_list_del(struct amdgpu_bo_va_mapping *mapping,
>  					    struct amdgpu_userq_va_cursor *va_cursor)
>  {
> -	atomic_set(&mapping->bo_va->userq_va_mapped, 0);
> +	if (mapping)
> +		atomic_set(&mapping->bo_va->userq_va_mapped, 0);
>  	list_del(&va_cursor->list);
>  	kfree(va_cursor);
>  }
>  
> -static int amdgpu_userq_buffer_vas_list_cleanup(struct amdgpu_device *adev,
> -						struct amdgpu_usermode_queue *queue)
> +static void amdgpu_userq_buffer_vas_list_cleanup(struct amdgpu_device *adev,
> +						 struct amdgpu_usermode_queue *queue)
>  {
>  	struct amdgpu_userq_va_cursor *va_cursor, *tmp;
>  	struct amdgpu_bo_va_mapping *mapping;
> @@ -319,15 +320,11 @@ static int amdgpu_userq_buffer_vas_list_cleanup(struct amdgpu_device *adev,
>  
>  	list_for_each_entry_safe(va_cursor, tmp, &queue->userq_va_list, list) {
>  		mapping = amdgpu_vm_bo_lookup_mapping(queue->vm, va_cursor->gpu_addr);
> -		if (!mapping) {
> -			return -EINVAL;
> -		}
> -		dev_dbg(adev->dev, "delete the userq:%p va:%llx\n",
> -			queue, va_cursor->gpu_addr);
> +		if (mapping)
> +			dev_dbg(adev->dev, "delete the userq:%p va:%llx\n",
> +				queue, va_cursor->gpu_addr);
>  		amdgpu_userq_buffer_va_list_del(mapping, va_cursor);
>  	}
> -
> -	return 0;
>  }
>  
>  static int amdgpu_userq_preempt_helper(struct amdgpu_usermode_queue *queue)

