Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0259C44521
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Jul 2026 07:49:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6519410E130;
	Mon, 20 Jul 2026 07:49:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="JlAvd2xy";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010006.outbound.protection.outlook.com
 [40.93.198.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BB4ED10E130
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Jul 2026 07:49:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=reU/Oss56Vra9uasbQzL2AdhF3L+a2s2FeG9+6a/apOshCPfKbIPIOh+t8OA4do+/cAlotdQ0UcgTP/U5Evt59NaanBa/ZldGNGJQ0ArnHnhQlHH5+T826YUHoTtVWDnQD03oBQZqVWwncuPntWzOvjGISGIG4YsOGlQt3rQVZDxDvMunbhqIoKTxxgwjYb8ossr/oAkj+nuFyqpz9AfkuuZoGUdu0VAW+escCAsd9OFAICIith+sUsSLKm7GebyOviKhC8HkW9KiP4uTdBYAtri+FhgecEx3PVY+bhFrwXc1nb+Yn8LyI6xvmfcg0Afoy5aNOiuYgUC7cHVEgw/DQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u/6ccmPVdePo2B+yJ/PPeQsAGi3XaJQkFkyF8+qswLo=;
 b=HbTlNA620c96iI1c6Peh55hAqRNIeAiTL3etINCy9rR31QB3AuhvkIX60qAeSi5n8wukgq5y2ZIkPtp5uU4uCA9qXQuIh/VKxZchXHMt65kEH2LFBinRDMPuKybcLeoTWuslkZU73/S8oApoleG2eUmGlJhEufNuDoQo4yevWHCkBuoCJiRARAwMoXuLWEL7nW1jCnosievbzRI9J+3PCDrOMuNb30kQKNrqumi+n6AA18No5v4N14X7wS94IbAd+BOOB44Q13HuJ0wJwP4saZC1gImH39lglDfwkcZss/wp+7W2/Q0ydm09u/u5ALhkakqi0UMG17vhMYDyNbFThw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u/6ccmPVdePo2B+yJ/PPeQsAGi3XaJQkFkyF8+qswLo=;
 b=JlAvd2xyFEBNnuKZGKecWwd49GQwhxSrE66EPYRyN9ggnDcGb39RJ84bZqZmM7BbdbJXQKB0sgmYhyTPEEVtGN/kItgCpPSOEJvjD1MvpzAFhfgxLWFqB3jNjPB7WRotthrNcoM7z12ckDYGpdW6zkVSTZd6EeS4QjJM53KzeBc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH2PR12MB9457.namprd12.prod.outlook.com (2603:10b6:610:27c::7)
 by PH7PR12MB7018.namprd12.prod.outlook.com (2603:10b6:510:1b8::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.16; Mon, 20 Jul
 2026 07:49:51 +0000
Received: from CH2PR12MB9457.namprd12.prod.outlook.com
 ([fe80::85a8:1df:840a:cd4c]) by CH2PR12MB9457.namprd12.prod.outlook.com
 ([fe80::85a8:1df:840a:cd4c%4]) with mapi id 15.21.0223.013; Mon, 20 Jul 2026
 07:49:51 +0000
Content-Type: multipart/alternative;
 boundary="------------WMwMbPHAjtOOC02aBPud0HeB"
Message-ID: <9e3dcbaa-01ef-4984-a107-e15888cb647e@amd.com>
Date: Mon, 20 Jul 2026 15:49:45 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: fix userq page count in input_validate
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Alexander.Deucher@amd.com
Cc: Ray.Huang@amd.com, amd-gfx@lists.freedesktop.org
References: <20260717022550.6549-1-lingshan.zhu@amd.com>
 <fb70da66-351b-4e12-ad2a-6835f8360202@amd.com>
Content-Language: en-US
From: "Zhu, Lingshan" <lingshan.zhu@amd.com>
In-Reply-To: <fb70da66-351b-4e12-ad2a-6835f8360202@amd.com>
X-ClientProxiedBy: KUZPR02CA0016.apcprd02.prod.outlook.com
 (2603:1096:d10:31::13) To CH2PR12MB9457.namprd12.prod.outlook.com
 (2603:10b6:610:27c::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB9457:EE_|PH7PR12MB7018:EE_
X-MS-Office365-Filtering-Correlation-Id: edda8e4f-462e-47b3-aa94-08dee6337af5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|8096899003|6133799003|10067099003|11063799006|4143699003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: HucOSsM0vkiVLnW67VtDZqwolq2h1frA/G64HEhRo8mrHqxXYb7FZTp0UTlFHOVtnjZDVo6EK6vkQuK1F57ouI073dWiU41zjwgdaQLP6aLjFkpSvtgB4Vt9Gw7ry5sQCIUF6q3/qmyB4//10JVcS3xqKKS84FU+JwhgoORlxPvPv3nHc/wXkWEHHhjQIEzn2oWkKGhQ0CNrCpghRu0mdwCD5McQW098fdr8Mtsg0t8KWEZgUWaJ+3AV4mVQjCkKAEmp7ydN1YRI8PhMmzbamL/VznmApbWEYLmy3hWbN7JBvHt5JJucEoeXEaR4jTBHap5yFwGxfTogepxzBr6+EHQyFzPfEQILJGzfJtanNKTpM1TtA0ZFeScS+o8ktdgvVvUCroKt/SzhxrGpzmxb0ZNb2xg5tfVeB9sHSq+IPeLqVRjouCcGRf6lYwJydNVLS1jzHDazqVlvKutLrBLgVv0tNfIh8I7CDZDlvgA/wZ/FtISlxV6pCMHE+ymd3ELM8geqOCbUpkG/EugtmgvhzsSo//dkVTEE+lARyazChPOfph7kzrqhA7PPY2aHoikpH3G37POVRbIXXHsMb8YwkAX7gzlWZ9xiuG1kERxqq6Sgj5bOjaDSxOZOSP47YERLbjW30IqF2nfFL5SmdNKbjXg6JAZlDizMfVbLbIsf+m0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB9457.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(8096899003)(6133799003)(10067099003)(11063799006)(4143699003)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NEZmdnpqay9HM1ZzRW5jTjFyK2Q4bW9mZEJVZjNCbEozcVpibGo4VW1aZHFq?=
 =?utf-8?B?enh4b05SRHBpQmp6Y1FEc3psZWgrcEtVTzRlY2VXQk4vVUpHS0xQUlUyRk5W?=
 =?utf-8?B?d2h2NHBteFBVNytHRW02L0pDbm5YcXo0bE8zNlJPOVh2VHMveVI1YjdlR2xT?=
 =?utf-8?B?ejQwOUd3NEpoVTIxeENwM0F2Y2pZVWYwSFFybjQ5d3AzdHI3Y0FNMWsyWGVy?=
 =?utf-8?B?TzkzSkNVMGtqYjJYQWR3R0pMb0V2cGcxNUhNTjhKNXBCdGR0bENqaStOR3lW?=
 =?utf-8?B?N25BdkNXcEh3eGNzYmJYWEFGODlJcW10VmxRaWRxQ0E2VHdabkNWU010cHpy?=
 =?utf-8?B?VWpGVEs3OWd2TldiZTRpOTR2QkhYSjk4alR0RkJkbnB1K0tiZWFnUnJ3V2FM?=
 =?utf-8?B?c2h6V3hBa1Q3ZVlOUXpjNzAvbmJuM1N3T0dmQXllL0RBZjBlRk9uOTg0dzNV?=
 =?utf-8?B?RkhVaTFJU2VDWGI4ZStGVGgxZVIyUUp3QW5QMGZqNDl6aGQ1cWVub1lraDdU?=
 =?utf-8?B?cXZlelBuNjV2ejZMU0wrQUdxc2JVbkRDTXFrM3lwd3pQbDQwbWo4UFBHYW0v?=
 =?utf-8?B?MEI1dXBkckk1VWl1Z0U3WW9tZGxHdytSRGZVNG94QUtpbHVuZnVwa1BZY3RV?=
 =?utf-8?B?eFpkSDB6U2ViVlJ5RFRkQ1M2SzNIRlpMaXc5Ujh3enhQNTIveTk0dzA4ZXlO?=
 =?utf-8?B?anlEZnVleG5ETm40SnFVRTFFWU1uQzFnKy8wTERsVExiSnltd1dNVnJhOVkz?=
 =?utf-8?B?enY2dTVrL2ZRTG9UZ3VDRWlJQStTN2ZlOUlmOGxmL2VVV3h2MG1ZQks1R0pw?=
 =?utf-8?B?aDNnZzBIckYxNEpzbWpCSXliTENzTjZJQ2xHc2puQUhmcVdjM1hrSDZWUklG?=
 =?utf-8?B?aW5KOTVyTmgyQnNOT285WXpRUkhVOGFjZDlXaUZMR3BzL29sOXdWNENjSmFS?=
 =?utf-8?B?Vm9xc3BaS1h3dDVHOFVzeXFXOVlxTzZ0ZVZlbW1CS0JFQldpeVlZeUJTODhV?=
 =?utf-8?B?RDhjQnBrdzh6LzRrSitDVVE3cEVuTWV1WG96TzY2ZFRaYnR5L2JFSmM2RG8y?=
 =?utf-8?B?d3dKUWNIL2JIV2VXUm53RXRNaloyNlVsa2FsN2Flc2lnVitHbU41OFRCRXow?=
 =?utf-8?B?S1FiRGlmYnlqSng0UjZ4MDdxTTJ1bElhWkExbGxKbTF5RjRrNXkra3BJZGV1?=
 =?utf-8?B?K0FHc0lQVXBwbHdIamkwTTJrOW9tV2NCVGlBU3RRclg3dm1MbmJjdHhPYjhu?=
 =?utf-8?B?NTVHTVF4MGtvcm1LaHFlZHpNRHFXWFJyOTFEU1BLcTIvb3oycmZTdjRmMUVq?=
 =?utf-8?B?cHdySDNjTHl0QnJCWHhmaSswUUQyUldLRHlhQzh3ZVVNTkM3VGU4d2R3Z1lT?=
 =?utf-8?B?ak9ISGVLRWlJcDNpWXA5KzZkYXIwZUMycEliZkUrUnM4Ymh3TzRlL1RuM01I?=
 =?utf-8?B?eXBNVmVlZDZES242M2JnN1N1UGdtVWdLLzdjTFZyR0JOMWNkYTQxRG1FZmNW?=
 =?utf-8?B?MWZ3WW9aVHRzQUFVZlVpV0dQZFJHZEZ1RmtnTmtCZ3FqbWtFckdiNTZ2aElP?=
 =?utf-8?B?S0MzS05OUG1SdFlueURIaUJIQ2lLVGVnbkFERFUwaDdzblRLLzVFcHp1RmFS?=
 =?utf-8?B?NTFjb3YyYzNLeEM0UG9ha1RiWkROZVEyM1ExU2RxZFBlcDdNSFdrMjRpMXh0?=
 =?utf-8?B?K24wQytyNjFKWDhoemFUQUE3dS9lUDRDM0xIRUZiVHZVSFdKeTZtSjlYN0lw?=
 =?utf-8?B?NFlJdEd0Tm1GWXRQc0JQYkFzZlpYZjVCY0ZINGZwZTBNelAxQ012a2JtaTlJ?=
 =?utf-8?B?QW5HTndFTXh2NmFEQjVGVnkyUjltQ1p0Nkt5c05CNGd5SGlUUUlMR2NJTzFB?=
 =?utf-8?B?MGgvZjkrRzJSdnlvK09sUlZreDh4TStNVWdYdTZHRWt1MXdNbmxGdXpJbmpQ?=
 =?utf-8?B?U3IrcldLZVhVY05HOFRiaStRY3VkM2VoMjk2N1BNOFJ0Z0ZVWUNlWit3RDhS?=
 =?utf-8?B?Mm9nbDlodzdJSDQwU0RYYTFaUFdpRFg4U1liVEl6cWZWWjN0aG9HYTgwWDZH?=
 =?utf-8?B?TndQbE8xTzNWV1lsT3hmVDFqcUpJcStVdHJPQnp1eUdZV3lNeSswN2F5a2Jp?=
 =?utf-8?B?ZkFiK0srNnVoOENPbE55UnBUaFBCNDVkZ3VZcE9LbFpTejl1a0FmU3hiaHE1?=
 =?utf-8?B?S0ZDSkkvN3hiTkJGcXI0Y3MzTzB5Q29TeXJnL3B5VGdsdGxZSTJvZGhxYWxM?=
 =?utf-8?B?Y0FobERYUGJYdzNKMFZGVlN0cVExSWszdi9pVEJTQWtpblB1Z3Bkdyt0VkFW?=
 =?utf-8?Q?1Yr/3u3EmRz0Cev8AH?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: edda8e4f-462e-47b3-aa94-08dee6337af5
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB9457.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2026 07:49:51.5392 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9A1Qt9MQwZbnqF1MUX0GMmsWwGVE24vWwGmUGLrJlW9N71iY8aJ4nv3W2V6+XR8tjxvfG7qIQP4KMCR3l/FB6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7018
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

--------------WMwMbPHAjtOOC02aBPud0HeB
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 7/17/2026 4:06 PM, Christian König wrote:

>
> On 7/17/26 04:25, Zhu Lingshan wrote:
>> amdgpu_userq_input_va_validate() converts userq
>> expected_size to page count by right shift.
>>
>> This undercounts va buffers that less than a page.
>> For example, in the AMDGPU_HW_IP_COMPUTE userq
>> creation case, the expected_size 2048,
>> so size(page count) becomes zero page and the
>> "va_map->last - user_addr + 1 >= size" is always true
>> once the start addr locates in the va_map mapping.
>>
>> A similar case is AMDGPU_HW_IP_DMA, where expected_size is 32.
>>
>> This commit calculates a proper page count by subtracting
>> the start_addr and end_addr in pages.
>>
>> Signed-off-by: Zhu Lingshan <lingshan.zhu@amd.com>
>> ---
>>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 14 +++++++++++---
>>  1 file changed, 11 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>> index 969f49592450..f9f11bdf2cef 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>> @@ -25,6 +25,7 @@
>>  #include <drm/drm_auth.h>
>>  #include <drm/drm_exec.h>
>>  #include <linux/pm_runtime.h>
>> +#include <linux/overflow.h>
>>  #include <drm/drm_drv.h>
>>  
>>  #include "amdgpu.h"
>> @@ -238,14 +239,21 @@ int amdgpu_userq_input_va_validate(struct amdgpu_device *adev,
>>  {
>>  	struct amdgpu_bo_va_mapping *va_map;
>>  	struct amdgpu_vm *vm = queue->vm;
>> -	u64 user_addr;
>> +	u64 user_addr, end;
>>  	u64 size;
>>  
>>  	/* Caller must hold vm->root.bo reservation */
>>  	dma_resv_assert_held(queue->vm->root.bo->tbo.base.resv);
>>  
>> -	user_addr = (addr & AMDGPU_GMC_HOLE_MASK) >> AMDGPU_GPU_PAGE_SHIFT;
>> -	size = expected_size >> AMDGPU_GPU_PAGE_SHIFT;
> Good catch, but I would just use ALIGN(expected_size, AMDGPU_GPU_PAGE_SIZE) here.

Hello Christian

ALIGN is more concise, however it is only correct when start_addr is PAGE aligned.

It undercounts one page when start_addr is not page aligned and "start_addr + expected_size" crosses page boundary.

An example is, if start_addr is 0xC00 (1024 X 3), and expected_size is 2048, so the size should be two pages,
but the result of ALIGN() is one page, which is wrong. 

I think this "start - end" is a more general solution.

Thanks
Lingshan 

>
> Regards,
> Christian.
>
>> +	if (!expected_size)
>> +		return -EINVAL;
>> +
>> +	user_addr = addr & AMDGPU_GMC_HOLE_MASK;
>> +	if (check_add_overflow(user_addr, expected_size - 1, &end))
>> +		return -EINVAL;
>> +
>> +	user_addr >>= AMDGPU_GPU_PAGE_SHIFT;
>> +	size = (end >> AMDGPU_GPU_PAGE_SHIFT) - user_addr + 1;
>>  
>>  	va_map = amdgpu_vm_bo_lookup_mapping(vm, user_addr);
>>  	if (!va_map)
--------------WMwMbPHAjtOOC02aBPud0HeB
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <pre>On 7/17/2026 4:06 PM, Christian König wrote:</pre>
    <blockquote type="cite" cite="mid:fb70da66-351b-4e12-ad2a-6835f8360202@amd.com">
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
      <pre wrap="" class="moz-quote-pre">
Good catch, but I would just use ALIGN(expected_size, AMDGPU_GPU_PAGE_SIZE) here.</pre>
    </blockquote>
    <pre>Hello Christian

ALIGN is more concise, however it is only correct when start_addr is PAGE aligned.

It undercounts one page when start_addr is not page aligned and &quot;start_addr + expected_size&quot; crosses page boundary.

An example is, if start_addr is 0xC00 (1024 X 3), and expected_size is 2048, so the size should be two pages,
but the result of ALIGN() is one page, which is wrong. 

I think this &quot;start - end&quot; is a more general solution.

Thanks
Lingshan </pre>
    <blockquote type="cite" cite="mid:fb70da66-351b-4e12-ad2a-6835f8360202@amd.com">
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
      <pre wrap="" class="moz-quote-pre">
</pre>
    </blockquote>
  </body>
</html>

--------------WMwMbPHAjtOOC02aBPud0HeB--
