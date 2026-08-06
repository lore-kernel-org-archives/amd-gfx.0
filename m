Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DBA1C55838
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Aug 2026 07:28:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 947C110E195;
	Thu,  6 Aug 2026 07:28:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Xz+Z9RDt";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012002.outbound.protection.outlook.com [52.101.43.2])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A0C3C10E195
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Aug 2026 07:28:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ja7F+3uLHpGkcncQKe1jL7AxrQvf84NkRIVhmVAGnpWGO7xtaSJNbPILZkQSq0OyHww+B1cQ7CQCTv+5wpk/7ERvi/wrLhdWxzHHtME+q063n5TEIQgU+ZKMHQLsjJUqvCY4McyZhVuzgblkxWRJUDvWa0fe4twcKWwoNiuE6m13NvKdvLruYowRtmO2J0UUj3gT+WcPj4lRjGGwd9PzJgNUUbaAaTW+Yoro2jCWfY4pJZ5Qb9j8DdSckNOwJYJ+a3gxZAQ4cd6sUVBddV41q7X1YBT62mofSuFGAVCQWr0cUPA2h9UDOCAszyJMc1GRZWst0Vv82oJwnX9OrfWgxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jZ11YMPVsFDkToD2tuoOE9BNH3+tIGxGVONG2+1A1bE=;
 b=aba1KvIrm2SpX8DSeKdPxHXaW51CISIx5/vFguPT+JUvBhUfCtPAZm7mv/iUtPFMIEx16ROG3mRGBmjm6I8o8M8f8oJ+Ih0VeGKbfdcsvoz/Fn94Lxslo/LAjNAl0CXBMqLCpSQE5zbwNz2HDCS4RrmQTcLEdTsLYGOldnWjyLl5T2z0X75vg8BNoSrGBGaOyJ5yYMU+NGjplBVrfsJWuGQLRxskBnL1yQoWwJ5ULkMma0OBFrqLB9iPvVz25X/0jpwB6aCWF74tZoGQ8QvtaU3GGeZrdUChoQbHTj3wjI96Wt+GelCr+siQg0KNJjVXed03orWez9h/CwE131EhGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jZ11YMPVsFDkToD2tuoOE9BNH3+tIGxGVONG2+1A1bE=;
 b=Xz+Z9RDtNdLy3XJOzU1HlW8FFx6HxY3tce7bF5j/QkID/LqR8PA5/7cxpEnd641rLpRJQ9Oa+BBpfRh4QzYv7hA+WwyT8s+3lNt73jbARWs+OWB18qkkwvu3kNSjnvy3gkOfC2/yvTOb3nFLZ5dwxBbYOIr5YGzsJJYtrva9nXk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH2PR12MB9457.namprd12.prod.outlook.com (2603:10b6:610:27c::7)
 by DS7PR12MB8201.namprd12.prod.outlook.com (2603:10b6:8:ef::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.16; Thu, 6 Aug
 2026 07:28:15 +0000
Received: from CH2PR12MB9457.namprd12.prod.outlook.com
 ([fe80::85a8:1df:840a:cd4c]) by CH2PR12MB9457.namprd12.prod.outlook.com
 ([fe80::85a8:1df:840a:cd4c%4]) with mapi id 15.21.0292.019; Thu, 6 Aug 2026
 07:28:14 +0000
Content-Type: multipart/alternative;
 boundary="------------XjJDC8gwBJ8ib8O5lkvxj8JQ"
Message-ID: <762759cd-6905-4a6c-ba6e-b76df69dabb6@amd.com>
Date: Thu, 6 Aug 2026 15:28:09 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: fix userq page count in input_validate
From: "Zhu, Lingshan" <lingshan.zhu@amd.com>
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Alexander.Deucher@amd.com
Cc: Ray.Huang@amd.com, amd-gfx@lists.freedesktop.org
References: <20260717022550.6549-1-lingshan.zhu@amd.com>
 <fb70da66-351b-4e12-ad2a-6835f8360202@amd.com>
 <9e3dcbaa-01ef-4984-a107-e15888cb647e@amd.com>
Content-Language: en-US
In-Reply-To: <9e3dcbaa-01ef-4984-a107-e15888cb647e@amd.com>
X-ClientProxiedBy: SG2PR04CA0206.apcprd04.prod.outlook.com
 (2603:1096:4:187::21) To CH2PR12MB9457.namprd12.prod.outlook.com
 (2603:10b6:610:27c::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB9457:EE_|DS7PR12MB8201:EE_
X-MS-Office365-Filtering-Correlation-Id: 66ce7114-08dc-41a6-b4fd-08def38c46e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|23010399003|1800799024|6133799003|22082099003|18002099003|4143699003|11063799006|8096899003|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info: 0K5/xAgV/NzIiS6J5z97DYWlneBY6pwH/MfQH0EFq12dBk4u5EUOE5uMKzIrOQ2dclEYlGzOVx/ldoE6gXt1CO4Lijc3Yc5yxC5WKyDVS0U9Sy0CyusZsnpqBa07XH94dJr04OaNS5EI20fQPTTrY13WXDcM4BU75XZJjiQWxWCq9+kI+Q5SmIjrepZUYt1fqGV1W2GyFwRqB4GYy1kYG7M5S3CjcPih7PuYL0XVrzvFIc2F6J01ScdV7UVyIZCW8Tq8LmhpgpmRjU6SZel3uo+FVluT6by/YdS2EDr5HgmsDAY303Y+bz+0AEM2iQ0V40uOv88lxR11mJUVzQQ1hC0NsmHhV6WrvSf2gh3vxDXeR6kHfi6dtPq2EqCbignWaUzfhXG7/fCISm0yEBlJyGbeCOAFWQACohyed5+OC1S/TnlW+mEV68Pxzt850Jb/kq8u3PxtfIa+I21uqKsP4LHP0o1mDC/Lp3qlAreTvMbnpvRkmC1HM9iFlmoH/Sv5Ao99Drf3ypY/qpke6+9Jjj6IAsGG1lXd9pqGHhQjQyVrPFJjGIn090E3wtl9RqMKkzo51QdVN7Up4JKHdhqEws8UMmSArfHiUdtHnK1jpGu5yEf6pSEphC3zaSfPx1h1CJZaTcfPYOfMPADETxOE9vdgWRUHLFqdu196MuQ5a0A=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB9457.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(6133799003)(22082099003)(18002099003)(4143699003)(11063799006)(8096899003)(10067099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OENhbUQ5ajdlM2s5Z1U1OStSdmdZK1F6eEUzTjZWSE5yZXE0ZkpwVUNRbHBw?=
 =?utf-8?B?c0JKaUIwN1JBU1pJL2NMNEJaQlp4bkRBWUVMb3ovR1RPWkZ3UW1kZWpScWZZ?=
 =?utf-8?B?NWh5SnFLZC9uWXZUTjdlOURkSG9JcnJScC9ZQk14cGhZZXFwd3l1RUs1MEZP?=
 =?utf-8?B?N0ErSHRSM3VVTHIwbkQ2U1hYY2I0WjFnSk1VQ3hacFlsUjgxS2V5QzNqaXZ0?=
 =?utf-8?B?emFkRVNpYlN0R1l4N09sTnZHeU5FNjhZRXpHOVE5VzEzL0xsMEd1NmpRdzhU?=
 =?utf-8?B?dGVoSkhveDM5aDFsUkRxK085TW15L0VuZ2tOTTAzcUNFQWd2SkxYSUhqNXoy?=
 =?utf-8?B?MWpUd3ZIdVd3V0Yyb25id0lJU0xYMDhlQTNzeWVvNXRjSmJTYkdKaUdvOWZ2?=
 =?utf-8?B?bDZ1SXJPVXk1bVVUM0NzeFRjUEVZL25JVzYrRUhUcmNad3k4cUc5ZGtIcGdI?=
 =?utf-8?B?WHNNK3ljcDg3cHpCci8wTE5tMlBYTVQ2aU1BdjJUNWhKRXlvei95RlhwVlpy?=
 =?utf-8?B?NVpzTVlWSG1RQ29ITU5oOW5sbTdaQWxPSWl0MzNaYW45dFBaSkN1K28vajha?=
 =?utf-8?B?UXV2NUMxMllFSmVRRmY5NmRnY3Z0L0N1cjZnOENmeUx1VzJROFNxSGMxOGZQ?=
 =?utf-8?B?OVJ2dEFBM1U5NHBvekdWVjVkcmZqSE9HQXlNYTlzQ01GZGQ1NXpxK1RJbTNB?=
 =?utf-8?B?M2RKTUkvU0RQYUgyblpzRzNBMW82YnQxV2V3ZTc5RXp1d01BRWN3cDlJdUZv?=
 =?utf-8?B?R3NJUlBrenlGcWVZR2lKaUhTa1BkU21qSlRzR3liNEwyVzNCTXM1RkJFN1dt?=
 =?utf-8?B?TE9xcUhUbUhjNHRQR2RacVQyWWpoM0tTWTRwVjZuMXJ1d3BGaG0zU2pTelpq?=
 =?utf-8?B?WW9vK0VTelRCMFFsQ1k2a29IUk82MCtZYkU4bnRoSVFDSC9RZTBMUXRWdHo4?=
 =?utf-8?B?Z21FUnpYWnNIUysvUm16N1hjY1FscGdsbTIrVm5IcEZNM1dqc3lPYlljb2hB?=
 =?utf-8?B?a2RFaFVaWGFKZW9CamRjUEtITGJhTXFJaXFveHI2TjQwQXBrVGh6U1hVWU56?=
 =?utf-8?B?SnRlZUJ1RTVkVkFtaENoS2tnNTdWbHF6UER5YzU4bGduUTNPUVZkQ2hpS0lp?=
 =?utf-8?B?YVBEK1NBSzE0R0duQXh1aVdzQkxha1haTWE5U3hFTWMwSG1lTDZ3eUNIa2dk?=
 =?utf-8?B?Vkluc1VLZi95dTErdkdtZlk4ZlpsNVkvc2o1YXNCSzc2dXRtMWltMnc4TlRO?=
 =?utf-8?B?UDNJQUNRNVovc1Jobkk2dUQvVmZrNFdEV2huVDJnSmpJOTdxZmtQb3RHcUhh?=
 =?utf-8?B?RkIwQ2hOTVhIYXBzQkxHeTJFUFNJZXJtLzNtMFRIeVg4Tk9PRnNiWUZEb3k5?=
 =?utf-8?B?dGxPZEhxTkJDSjB6WGNmVTN4R1lYcW1reW1yZ2lBOE5XdFc2R05LSmZsRnFr?=
 =?utf-8?B?N2F3ckw5d3k2dXl6Q3YxT0t2RFVpb3kvRDFNd2l4SnVWZ0JnR0JSeGJBdnI5?=
 =?utf-8?B?U2o0d1NOVVdWZmtnakYvVWhraGpRY3Q0d2E3dGhUY25UK2ZJaGNFclVyUitQ?=
 =?utf-8?B?OTc1WW81Sk4xVkd2aVRGcDVxYnFEUmFFVnVKakNpUFFNYnVJdFZyZXRNa29K?=
 =?utf-8?B?eXV1N0p6THkxcGZEdmZBb0N3bFJtWWo5ckpISUw0NzNVMDBRRWpZQm9aWTdU?=
 =?utf-8?B?Q0x6T1Z3TWZpTHc3MFptN3dLZGRIbE94TmVCUlNCN1hIVUJ1UzRVSkY4aE10?=
 =?utf-8?B?N05UZXFmSU1Ed1lWRVl5Q0lXU2ZkdWk1Ym1XMHEvSm4xOXZLL2YxYzRBckVZ?=
 =?utf-8?B?N3J0SjFmUU1zV2xsUVB3MnJVMnV0K0pVUWFuUVlYSnJrWnpVUWs1UmlYbXhL?=
 =?utf-8?B?ZG9xMzREdVRFcGU3bkp4TGJ4VkRCZ0ZTNEcrVm1Famw2dHpJN0x0TC9taTZT?=
 =?utf-8?B?clRXZTE4MDJoVyt1VTU0MEJIWUZHc3FlcGNXb1BUTzZMcFl2aEt4TDZ4TTF4?=
 =?utf-8?B?NzMzdTRBWnNKVFk4bWF1aURuRmpuUUFlWXh6ZFpNMDhWNm0rMWpVSnN5Y3E1?=
 =?utf-8?B?UFBpb2V0c2NZcjZFT2dlTmk0YlFPaTJlMVBDVUw3a2VEb1pqMHliS0N3d3F6?=
 =?utf-8?B?bnhMeGNEdnRrUjZZS2lENUF2RnB0T2Z6SEt2ODh3NkpqbHZwUm5XdnJYWER3?=
 =?utf-8?B?WXlVMjN1enF1SHZ4VkZiMjdsbXJkVHlMbWpITVU3dFlyVGlKZnM0em5vNUZJ?=
 =?utf-8?B?SXQzWU14Q2w3RmtLNUMzWGRVQ1VqQW1ZOE5OeVJhdzVZNVhFS3A0ZHJESkdS?=
 =?utf-8?B?UVkzT292NVBlTk96WEdyQk9VU3NtU3o3OUVHbTJPcHZmSHJ0eHNUUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66ce7114-08dc-41a6-b4fd-08def38c46e4
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB9457.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2026 07:28:14.7917 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Qr4Gkxd18OEWXRyauoXiXHW2CUhJv1GTDFfuT4oAPlhwIszhsYxcLm042nPg4OKhBQkTohtUgHDH+gzo7gw0qg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8201
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

--------------XjJDC8gwBJ8ib8O5lkvxj8JQ
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Ping Christian.


On 7/20/2026 3:49 PM, Zhu, Lingshan wrote:

> On 7/17/2026 4:06 PM, Christian König wrote:
>
>> On 7/17/26 04:25, Zhu Lingshan wrote:
>>> amdgpu_userq_input_va_validate() converts userq
>>> expected_size to page count by right shift.
>>>
>>> This undercounts va buffers that less than a page.
>>> For example, in the AMDGPU_HW_IP_COMPUTE userq
>>> creation case, the expected_size 2048,
>>> so size(page count) becomes zero page and the
>>> "va_map->last - user_addr + 1 >= size" is always true
>>> once the start addr locates in the va_map mapping.
>>>
>>> A similar case is AMDGPU_HW_IP_DMA, where expected_size is 32.
>>>
>>> This commit calculates a proper page count by subtracting
>>> the start_addr and end_addr in pages.
>>>
>>> Signed-off-by: Zhu Lingshan <lingshan.zhu@amd.com>
>>> ---
>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 14 +++++++++++---
>>>  1 file changed, 11 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>>> index 969f49592450..f9f11bdf2cef 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>>> @@ -25,6 +25,7 @@
>>>  #include <drm/drm_auth.h>
>>>  #include <drm/drm_exec.h>
>>>  #include <linux/pm_runtime.h>
>>> +#include <linux/overflow.h>
>>>  #include <drm/drm_drv.h>
>>>  
>>>  #include "amdgpu.h"
>>> @@ -238,14 +239,21 @@ int amdgpu_userq_input_va_validate(struct amdgpu_device *adev,
>>>  {
>>>  	struct amdgpu_bo_va_mapping *va_map;
>>>  	struct amdgpu_vm *vm = queue->vm;
>>> -	u64 user_addr;
>>> +	u64 user_addr, end;
>>>  	u64 size;
>>>  
>>>  	/* Caller must hold vm->root.bo reservation */
>>>  	dma_resv_assert_held(queue->vm->root.bo->tbo.base.resv);
>>>  
>>> -	user_addr = (addr & AMDGPU_GMC_HOLE_MASK) >> AMDGPU_GPU_PAGE_SHIFT;
>>> -	size = expected_size >> AMDGPU_GPU_PAGE_SHIFT;
>> Good catch, but I would just use ALIGN(expected_size, AMDGPU_GPU_PAGE_SIZE) here.
> Hello Christian
>
> ALIGN is more concise, however it is only correct when start_addr is PAGE aligned.
>
> It undercounts one page when start_addr is not page aligned and "start_addr + expected_size" crosses page boundary.
>
> An example is, if start_addr is 0xC00 (1024 X 3), and expected_size is 2048, so the size should be two pages,
> but the result of ALIGN() is one page, which is wrong. 
>
> I think this "start - end" is a more general solution.
>
> Thanks
> Lingshan 
>
>> Regards,
>> Christian.
>>
>>> +	if (!expected_size)
>>> +		return -EINVAL;
>>> +
>>> +	user_addr = addr & AMDGPU_GMC_HOLE_MASK;
>>> +	if (check_add_overflow(user_addr, expected_size - 1, &end))
>>> +		return -EINVAL;
>>> +
>>> +	user_addr >>= AMDGPU_GPU_PAGE_SHIFT;
>>> +	size = (end >> AMDGPU_GPU_PAGE_SHIFT) - user_addr + 1;
>>>  
>>>  	va_map = amdgpu_vm_bo_lookup_mapping(vm, user_addr);
>>>  	if (!va_map)
--------------XjJDC8gwBJ8ib8O5lkvxj8JQ
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <pre>Ping Christian.


On 7/20/2026 3:49 PM, Zhu, Lingshan wrote:</pre>
    <blockquote type="cite" cite="mid:9e3dcbaa-01ef-4984-a107-e15888cb647e@amd.com">
      <pre wrap="" class="moz-quote-pre">On 7/17/2026 4:06 PM, Christian König wrote:

</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">
On 7/17/26 04:25, Zhu Lingshan wrote:
</pre>
        <blockquote type="cite">
          <pre wrap="" class="moz-quote-pre">amdgpu_userq_input_va_validate() converts userq
expected_size to page count by right shift.

This undercounts va buffers that less than a page.
For example, in the AMDGPU_HW_IP_COMPUTE userq
creation case, the expected_size 2048,
so size(page count) becomes zero page and the
&quot;va_map-&gt;last - user_addr + 1 &gt;= size&quot; is always true
once the start addr locates in the va_map mapping.

A similar case is AMDGPU_HW_IP_DMA, where expected_size is 32.

This commit calculates a proper page count by subtracting
the start_addr and end_addr in pages.

Signed-off-by: Zhu Lingshan <a class="moz-txt-link-rfc2396E" href="mailto:lingshan.zhu@amd.com">&lt;lingshan.zhu@amd.com&gt;</a>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 969f49592450..f9f11bdf2cef 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -25,6 +25,7 @@
 #include &lt;drm/drm_auth.h&gt;
 #include &lt;drm/drm_exec.h&gt;
 #include &lt;linux/pm_runtime.h&gt;
+#include &lt;linux/overflow.h&gt;
 #include &lt;drm/drm_drv.h&gt;
 
 #include &quot;amdgpu.h&quot;
@@ -238,14 +239,21 @@ int amdgpu_userq_input_va_validate(struct amdgpu_device *adev,
 {
 	struct amdgpu_bo_va_mapping *va_map;
 	struct amdgpu_vm *vm = queue-&gt;vm;
-	u64 user_addr;
+	u64 user_addr, end;
 	u64 size;
 
 	/* Caller must hold vm-&gt;root.bo reservation */
 	dma_resv_assert_held(queue-&gt;vm-&gt;root.bo-&gt;tbo.base.resv);
 
-	user_addr = (addr &amp; AMDGPU_GMC_HOLE_MASK) &gt;&gt; AMDGPU_GPU_PAGE_SHIFT;
-	size = expected_size &gt;&gt; AMDGPU_GPU_PAGE_SHIFT;
</pre>
        </blockquote>
        <pre wrap="" class="moz-quote-pre">Good catch, but I would just use ALIGN(expected_size, AMDGPU_GPU_PAGE_SIZE) here.
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
Hello Christian

ALIGN is more concise, however it is only correct when start_addr is PAGE aligned.

It undercounts one page when start_addr is not page aligned and &quot;start_addr + expected_size&quot; crosses page boundary.

An example is, if start_addr is 0xC00 (1024 X 3), and expected_size is 2048, so the size should be two pages,
but the result of ALIGN() is one page, which is wrong. 

I think this &quot;start - end&quot; is a more general solution.

Thanks
Lingshan 

</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">
Regards,
Christian.

</pre>
        <blockquote type="cite">
          <pre wrap="" class="moz-quote-pre">+	if (!expected_size)
+		return -EINVAL;
+
+	user_addr = addr &amp; AMDGPU_GMC_HOLE_MASK;
+	if (check_add_overflow(user_addr, expected_size - 1, &amp;end))
+		return -EINVAL;
+
+	user_addr &gt;&gt;= AMDGPU_GPU_PAGE_SHIFT;
+	size = (end &gt;&gt; AMDGPU_GPU_PAGE_SHIFT) - user_addr + 1;
 
 	va_map = amdgpu_vm_bo_lookup_mapping(vm, user_addr);
 	if (!va_map)
</pre>
        </blockquote>
      </blockquote>
    </blockquote>
  </body>
</html>

--------------XjJDC8gwBJ8ib8O5lkvxj8JQ--
