Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A91D2C982FE
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Sep 2026 14:05:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 28F5C10ED3B;
	Tue, 22 Sep 2026 14:05:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="d0aBo3Ae";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012016.outbound.protection.outlook.com
 [40.107.200.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0710910ED2E
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Sep 2026 14:05:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q983mhFjqimC3Y043zplM7vnNg+GQAjR6qXSGWQjlBis4+IlGeOe/m+iuF0VXqF6oFHW3NJXPmwmp3wIV4elRrvai0M0zMQ99dAm+1XgtrfrKv/PSPDkgw6jQhP9nLzqdlxjqTSq8YaHwvMQ2/lcgZMd9L6RQZiqfvkndbcNxj7RENVDtcf0EsuzHYwsL+kZA0LDYR5yMbM4l8o/D1VTI03v50sDf/IGf7dP2/uWEJs/AQZz+aL/yBKsXbeCffsiFvGF1r5eHNYo2R+U5ItNmnUTVXs5vhLJD1/rFzzpFBP85Kbcit8M7Xeu1g/1BIpz2YgVrfG7HXNSZC4vHLd/eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VEbdOFfdZOoC7kkAaAQe7VwXN4VAqRGcrPiiC0a2vCY=;
 b=JhHpc3mfcTAymfbF7kwFZud/EoKjL8l9v+JU77jHm2V5PqvmhLCKdpTrO7v0fmKkz8bjrLAHI5R/mdcRtZfTHMGiDuGJJBj9HP0/wCZwMPHS/H/T18AGKI4YZC3t6zJ65yBd4ECXD4Ip3i5zEUn62kinEuapcuOtds/dUfNrKptlZV/pPhq1knpWcs4+W+HzGtZGN0nFGxyvYnUT9hLNlz62f4G9If0EjUUiw5rwM/0zk0DEj5ubhOSsXqaAAEFOmDBOT/wxYVk8iD/H4uVppKgnuF/+tosOFaVBfb4nHAR1TwF/PtOOsyLOpzjt0yCu0pMGbWSLyUDtSaTBlvyrSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VEbdOFfdZOoC7kkAaAQe7VwXN4VAqRGcrPiiC0a2vCY=;
 b=d0aBo3AeYKENjP1cWq1qUkm0xPbRnZL8B9IlZoqvSQsK7k0WN7t69e3Rfsne/wRBXCUVP2QdVstobic49MnHA/XI3MVedxUaXaettrkRaGdNjEaVl4Cvn0BuhdFCLRcXHY4Lt+orMD1ApTiT6SyTVXbfjEEelqCGV1E0mC51k+U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB8558.namprd12.prod.outlook.com (2603:10b6:8:187::22)
 by LV1PR12MB999280.namprd12.prod.outlook.com (2603:10b6:408:3f5::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.14; Tue, 22 Sep
 2026 14:04:57 +0000
Received: from DM4PR12MB8558.namprd12.prod.outlook.com
 ([fe80::1b2b:b6fc:16eb:2422]) by DM4PR12MB8558.namprd12.prod.outlook.com
 ([fe80::1b2b:b6fc:16eb:2422%3]) with mapi id 15.21.0406.007; Tue, 22 Sep 2026
 14:04:57 +0000
Message-ID: <202ed1b1-faae-4a4f-a54a-4538a8659495@amd.com>
Date: Tue, 22 Sep 2026 10:04:56 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/12] drm/amdgpu: add amdgpu_xcp_get_xcc_mask helper
To: "Lazar, Lijo" <lijo.lazar@amd.com>, James Zhu <James.Zhu@amd.com>,
 amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com, Bing.Ma@amd.com
References: <20260921200313.865829-1-James.Zhu@amd.com>
 <20260921200313.865829-4-James.Zhu@amd.com>
 <8f06398f-e207-45b0-ab85-931ccac35b65@amd.com>
 <ce3dbd30-31e6-4680-8618-2144fe44a928@amd.com>
 <0e573608-7f9e-4f3e-ac58-cf375962ae2b@amd.com>
Content-Language: en-US
From: James Zhu <jamesz@amd.com>
Organization: AMD RTG
In-Reply-To: <0e573608-7f9e-4f3e-ac58-cf375962ae2b@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR0101CA0251.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:66::15) To DM4PR12MB8558.namprd12.prod.outlook.com
 (2603:10b6:8:187::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB8558:EE_|LV1PR12MB999280:EE_
X-MS-Office365-Filtering-Correlation-Id: 150e47cd-921b-43ce-0278-08df18b27c11
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|6133799003|18002099003|22082099003|3023799007|11063799006|10067099003|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info: BtilJ4ngL7M9bar0iOo4XUrfWohxTejKkh/yvWrAD4fDsJSfV15n3XD1zbQ2yXRiPd96EcNADMQtIUZTeU1682a9jxyYYlbW8QcFh5hYZQIqwwG+aCL8lbay/JBbpzQZIV9eEGjNpP+h+jiiv6z28IiROtms+pxvSzWvXfjshXNJ0lbx3FjycrAm+VwkmojH+80XomGWCFJm/Tk84AaEntTjgWqpMc5Q7MT1/PxRLrcPnHYdZ49ZFXWnBly4Rlq7TnhbvAQk2K1hPgUGGkUhP5V5+JhCaB0K1Kb8kp2Nu4W+2/H7uzG6HI4x+y64LkoJFHKu1qdZO7a6u5uhHQWtsEK8osUGAEXeO1BmrnbPyhUM3OXcUc7YMjTu5L488QnxHGI35TScdHrgS0seL1inURMur/6Em/C/+gZ7HGFLMhyyBHX9aSjz7kxbUXKlpsyOcSPxrLqNxOl8H73go90oVhAcgqb4fGy9d59BS51yOHt9zuIJg8KZvs5awAecE64/0ei2PCl6s/V0Al/74gPS+RB2GlL9qPL/0IeNF2cU71pjReDI2bMymkthCLocsualWotbTeCl0bStUmdaPGKabMvZ14+65UPjleKiu84t95cB6K2OhHtOtWqSk0QyohMR
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB8558.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(6133799003)(18002099003)(22082099003)(3023799007)(11063799006)(10067099003)(4143699003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TjZRODlrMU9qTjZCVm9kRTJ2QWtvNXJpZjloY3JJMUJJSHJFRmVDR0lnK0Jw?=
 =?utf-8?B?NVZuUmlEaWdjSW9CUDQ2Qjk4MVIzQ0dnNDFxcHYzajFxczFFaUxaT0lyTzhq?=
 =?utf-8?B?OHZOdG1XNnlIQXkyMDNKd2ppVFU2R2tLelpzVEtZRTJacWxCSkxnTTlNQ0Jn?=
 =?utf-8?B?aC8xZGcxMTJyajAwRjVvd2Z2SGI0a0RZZDNwS1VVbFpPVTNKMUlGb05CYmVp?=
 =?utf-8?B?SEhQUmc4YXdlOFdnNERMSHdHYVpueTlzdWtCK2hmWEJhNjQ1a3FmdGJwN1Bo?=
 =?utf-8?B?a0tNd3J1SjExMzJ1OHB0eXJRQnBvcHEvUnEzWTN6TmFGMTRjVHZIc01CWkZI?=
 =?utf-8?B?UDc1dEwwMndHOTNDQlJPdlVuS2ZaRjBibHdJaGVpamE3ejc2OUc2bzA2a3I4?=
 =?utf-8?B?QS8vUWt2MkJRcXBVS3BRWGFJcTNyYzlwWTZXaWYxZnRoMzY4SnhYYVBPSHpt?=
 =?utf-8?B?OGdWcmxMNjFIWFZEbkdFR2JGWkVkcE82Vzhmd0JIVEpFRjUvSEREeExDZ0dR?=
 =?utf-8?B?UFhFT0ZWUVpPWTBqcTF0NVdLMXhYMnVhZm1zTGJsaFFSUkVtMU5LZUY1UkRX?=
 =?utf-8?B?cGhKV1grdWxDbFdYR2xUNklHcWo5eXh5SWEyWnljQWo2cmVQeVRnYUtaUjBr?=
 =?utf-8?B?Z2RtRkJuY2RCVHlUSmxWUUhiUUV4SWcrZmU0djJ5Nm9TK2VJQ0V3elpyQUN6?=
 =?utf-8?B?NFUxRnBEWDdHTm9EZ0RYY3VWUXFwVE9EdEJ2a2RocWpDd240V0hSMzhLLzZ5?=
 =?utf-8?B?WE4zd01SNHplSGhCQktTeHZDaGo2dGpBb09wbVJlVzJZYUc5bmRxcWdMajFx?=
 =?utf-8?B?aEhYeWtTdk0zc000cUZSZ0pSN1JmWHcyQk1taTZUVXJibEk3MnAxYlJiTXg5?=
 =?utf-8?B?V0QyYm5YVktqUGw3MFdFa1VjUUREUlI2ZWgvc2ordDZ3bmVSRTJpZWY4b3Ez?=
 =?utf-8?B?bk85OVU1bWRzaHpveitKT1F4dWpMS0lvNWNrMmk1YS9QTXNMdzA2NzVJbFdq?=
 =?utf-8?B?aUQ0TTVzVHdJSFlic3hQVVp0QUQrZGxQQjRrdDExYjRHRjFWM0JHRnpEdkg1?=
 =?utf-8?B?a3FTaE9JZjhsaWl3Z0tTSVNTdytUQlQ3ek1Nc0hOZ0EvOHVGaWRqdVZMZ3Zv?=
 =?utf-8?B?a1V5T1A2SU5YSE9xM204cjZrTmVSZzN5N3FYZ2lPZ0t5VVp4SjBJT2lPSlFM?=
 =?utf-8?B?S043dko3cHVvSUVIenR0TGRFYlBsd3JEVEZUd2MxalhGM3JCVTRubUVhZHlX?=
 =?utf-8?B?SUZidDNCUk05OWt1YUhoeEVQc1lNcUxqY21IMUZtbVJqdXNUVFB2Rk5wYXQ4?=
 =?utf-8?B?MUd1MkM3OXNmdmZrcFhEMi8zUWVabDh5UkQ0REpLc3JmRU5QbmxvL3BxTk90?=
 =?utf-8?B?b2JnbjhQY2E5Y295NmpTNTN1RGVuSWUvUHp0Z3hia1piRzJ2eWJzU0hYY2ZV?=
 =?utf-8?B?RU9VcmVRc1FhL2NZc1dTZU5IbythMElPNklYaGFIUlQyY1pwYzhqSGhhTkhL?=
 =?utf-8?B?eklCd1ZMckxMK3FUTFJTZ2pGZlNQTi9NRnRIOHF4aTNKQTRvRFVyRUhZTEFU?=
 =?utf-8?B?WVRqOHpHVWMyQ2tuRUpYV1NqNjc2QjJtTzBwVlRGU29wVWM2cVpLMkx6YVFO?=
 =?utf-8?B?RnlqTHkxL1Y4ZmpQWFZpZGtUWURRSVIyaGIvRmZqR1JseDRVQlJUOWh2Qkcr?=
 =?utf-8?B?bTJsZko1a0xDTzZIYnM0a0VXOVdaTHFmUVpvc2tHM0JlU2c1M0EwMnhkS0FN?=
 =?utf-8?B?U0ZoYlQwdlFpa1ZacXV1WEtVQndhTGhOcDRrNmpvaUxqdkFEY003TWhhVzlG?=
 =?utf-8?B?WnJtQklkUTdxcENmdXNJamRaa2RVa2o1bHAwTWhzOWtXcTZLdmczL3g5ajE0?=
 =?utf-8?B?V05DVFRVcUZqdExWTUN0OWhXS0NKN1FadVVzZ3k4d3ppck5DVGVqSFExY2NQ?=
 =?utf-8?B?ZS9uWDEvakpBOHdNZGZZclNzN1JGbFBSVVVZaHBDMmtTTCs4RS9ZeFY2a0o3?=
 =?utf-8?B?RVdtMnAvSktqMmQzR21DdC9BREJvSmpCd3ZCcUtQRFBiRHRQWHZtQzlxYTRn?=
 =?utf-8?B?YjJ4UGlXdUpaZzhkTXZIV2hOZHJNNHp5ZlF0RzhicjRFYW4vV01xOVhiMjlt?=
 =?utf-8?B?aFZDdFZWYlRtSTNoQkJ5NklqMXFnVmduUE5OdVZmamZ6Rjg2ODgzYjBzcy9k?=
 =?utf-8?B?WUZFdDBBeFJpVmM3bm81U0hEZHpIR3E5dFpVdG1MMDFwc1ExUnFKYTI5VDRw?=
 =?utf-8?B?RVN3aUlFWWlEZWpyQTdkYlJ0alJQclBhdkZqM3kybi9rREtWSFFsWWgwcDd3?=
 =?utf-8?Q?/JqHoCj0hFj0f/Lp9E?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 150e47cd-921b-43ce-0278-08df18b27c11
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB8558.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2026 14:04:57.6128 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: er6NmeU4S3SwwoUTshn9tcHvLHzCU5IcsQ6GP8Ld067NGkyWKNlTCsjDoqWAi/lK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV1PR12MB999280
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


On 2026-09-22 09:45, Lazar, Lijo wrote:
>
>
> On 22-Sep-26 7:05 PM, James Zhu wrote:
>>
>> On 2026-09-22 01:22, Lazar, Lijo wrote:
>>>
>>>
>>> On 22-Sep-26 1:33 AM, James Zhu wrote:
>>>> Add amdgpu_xcp_get_xcc_mask() to return the XCC instance mask for a 
>>>> given
>>>> XCP partition. This is needed by upcoming SPM (Stream Performance 
>>>> Monitor)
>>>> support, which programs hardware per partition and must operate 
>>>> only on
>>>> the XCCs that belong to a given XCP.
>>>>
>>>> For partitioned systems the helper returns only the XCCs belonging 
>>>> to the
>>>> specified XCP. When @xcp_id is AMDGPU_XCP_NO_PARTITION (or the 
>>>> device is
>>>> not partitioned) it returns the device's full XCC mask (e.g. 0xFF 
>>>> for an
>>>> 8-XCC device). Note that the full device mask is returned even on a
>>>> partitioned device; callers that require partition isolation (e.g. 
>>>> SPM)
>>>> must reject AMDGPU_XCP_NO_PARTITION on a partitioned device 
>>>> themselves.
>>>>
>>>
>>> Could you clarifiy on this part - xcp_id = AMDGPU_XCP_NO_PARTITION 
>>> usage on 8-XCC device?
>>>
>>> The default state on a multi-XCC device after driver load is all 
>>> XCCs in a single partition called SPX. It should have at least one 
>>> partition valid.
>>
>> [JZ] Yes, 8-XCC device should not reach AMDGPU_XCP_NO_PARTITION case.
>>
>> the if(!xcp_mgr ||xcp_id ==AMDGPU_XCP_NO_PARTITION) mainly covers non 
>> partition device, I can remove the above comments which don't reflect 
>> the source accurately.
>
> Then I'm not sure what issue this is fixing.
>
> Multi-xcc devices will be in SPX mode and will return a mask with all 
> the XCCs. Non-multi xcc devices are expected to have this set to 1 
> anyway to reflect that a single GC is present always.
[JZ]This is a non-functional refactor and cleanup following the 
introduction of  amdgpu_xcp_get_xcc_mask(). Since 
amdgpu_xcp_get_xcc_mask() and
amdgpu_xcp_get_num_xcc() share similar logic, consolidate the duplicate code

https://gerrit-git.amd.com/plugins/gitiles/brahma/ec/linux/+/refs/heads/amd-unified-interface/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h#222

Thanks!

James

>
> Thanks,
> Lijo
>
>>> Thanks,
>>> Lioj
>>>
>>>> amdgpu_xcp_get_num_xcc() is reworked to take (adev, xcp_id) and 
>>>> derive the
>>>> count from this helper via hweight32(). The helper is defined out 
>>>> of line
>>>> in amdgpu_xcp.c so that the static inline in amdgpu_xcp.h never has to
>>>> dereference the (incomplete) struct amdgpu_device; it only passes the
>>>> pointer through.
>>>>
>>>> This is a user-visible change: amdgpu_xcp_get_num_xcc() previously
>>>> returned 1 for non-partitioned systems (and for 
>>>> AMDGPU_XCP_NO_PARTITION),
>>>> and now returns the actual XCC count (e.g. 8 for an 8-XCC device). 
>>>> CWSR
>>>> callers (amdgpu_kms.c, amdgpu_userq.c, mes_userqueue.c) scale the 
>>>> per-XCC
>>>> control-stack and debug-memory sizes by num_xcc, so the uAPI-visible
>>>> ctl_stack_size and dbg_mem_size values grow accordingly to match the
>>>> actual hardware resource requirements, which were previously 
>>>> undersized.
>>>>
>>>> Fixes: 4cd417bfec49 ("drm/amdgpu: Add helper function to get xcc 
>>>> count")
>>>> Signed-off-by: James Zhu <James.Zhu@amd.com>
>>>> Reviewed-by: Bing Ma <bing.ma@amd.com>
>>>> ---
>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c    |  2 +-
>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c  |  2 +-
>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c    | 48 
>>>> ++++++++++++++++++++++
>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h    | 32 +++++++--------
>>>>   drivers/gpu/drm/amd/amdgpu/mes_userqueue.c |  3 +-
>>>>   5 files changed, 66 insertions(+), 21 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/ 
>>>> drm/amd/amdgpu/amdgpu_kms.c
>>>> index 57fa69c0382d..7782ccd4d28f 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
>>>> @@ -1501,7 +1501,7 @@ int amdgpu_info_ioctl(struct drm_device *dev, 
>>>> void *data, struct drm_file *filp)
>>>>           fpriv = (struct amdgpu_fpriv *)filp->driver_priv;
>>>>           if (!amdgpu_trap_is_enabled(adev) || !fpriv->trap_obj)
>>>>               return -EOPNOTSUPP;
>>>> -        num_xcc = amdgpu_xcp_get_num_xcc(adev->xcp_mgr, 
>>>> fpriv->xcp_id);
>>>> +        num_xcc = amdgpu_xcp_get_num_xcc(adev, fpriv->xcp_id);
>>>>           cwsr_info.ctl_stack_size =
>>>>               adev->trap_info->cwsr.xcc_ctl_stack_sz * num_xcc;
>>>>           cwsr_info.dbg_mem_size =
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c 
>>>> b/drivers/gpu/ drm/amd/amdgpu/amdgpu_userq.c
>>>> index db09e879b85e..d19af9cb6ee1 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>>>> @@ -258,7 +258,7 @@ int 
>>>> amdgpu_userq_input_trap_params_validate(struct 
>>>> amdgpu_usermode_queue *queue,
>>>>       int num_xcc;
>>>>       int r;
>>>>   -    num_xcc = amdgpu_xcp_get_num_xcc(adev->xcp_mgr, fpriv->xcp_id);
>>>> +    num_xcc = amdgpu_xcp_get_num_xcc(adev, fpriv->xcp_id);
>>>>       r = amdgpu_trap_validate_params(queue->userq_mgr->adev, 
>>>> trap_params,
>>>>                       num_xcc);
>>>>       if (r)
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c b/drivers/gpu/ 
>>>> drm/amd/amdgpu/amdgpu_xcp.c
>>>> index 2a56f5ec9c76..90846d55292b 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
>>>> @@ -390,6 +390,54 @@ int amdgpu_xcp_get_inst_details(struct 
>>>> amdgpu_xcp *xcp,
>>>>       return 0;
>>>>   }
>>>>   +/**
>>>> + * amdgpu_xcp_get_xcc_mask - Get XCC instance mask for a partition
>>>> + * @adev: amdgpu device pointer
>>>> + * @xcp_id: XCP partition ID
>>>> + * @xcc_mask: output parameter for XCC instance mask
>>>> + *
>>>> + * Returns the XCC instance mask for the specified XCP partition.
>>>> + * For partitioned systems, returns only the XCCs belonging to 
>>>> this XCP.
>>>> + *
>>>> + * When @xcp_id is AMDGPU_XCP_NO_PARTITION (or the device is not
>>>> + * partitioned), the device's full XCC mask is returned (e.g. 0xFF 
>>>> for an
>>>> + * 8-XCC device). Note that the full device mask is returned even 
>>>> on a
>>>> + * partitioned device: callers that require partition isolation 
>>>> (e.g. SPM)
>>>> + * must reject AMDGPU_XCP_NO_PARTITION on a partitioned device 
>>>> themselves.
>>>> + *
>>>> + * Note: On error, xcc_mask is undefined. Callers must check 
>>>> return code
>>>> + * and only read xcc_mask when return == 0.
>>>> + *
>>>> + * Return: 0 on success (non-partitioned systems or valid XCP found),
>>>> + *         -EINVAL if xcc_mask is NULL, no matching XCP id is 
>>>> found, or the
>>>> + *         partition's GFX IP details are unavailable
>>>> + */
>>>> +int amdgpu_xcp_get_xcc_mask(struct amdgpu_device *adev, int xcp_id,
>>>> +                uint32_t *xcc_mask)
>>>> +{
>>>> +    struct amdgpu_xcp_mgr *xcp_mgr = adev->xcp_mgr;
>>>> +    struct amdgpu_xcp *xcp;
>>>> +    int i;
>>>> +
>>>> +    if (!xcc_mask)
>>>> +        return -EINVAL;
>>>> +
>>>> +    if (!xcp_mgr || xcp_id == AMDGPU_XCP_NO_PARTITION) {
>>>> +        /* Non-partitioned: return the device's full XCC mask. */
>>>> +        *xcc_mask = adev->gfx.xcc_mask;
>>>> +        return 0;
>>>> +    }
>>>> +
>>>> +    /* Partitioned system: get this XCP's XCCs */
>>>> +    for_each_xcp(xcp_mgr, xcp, i) {
>>>> +        if (xcp->id == xcp_id)
>>>> +            return amdgpu_xcp_get_inst_details(xcp, AMDGPU_XCP_GFX,
>>>> +                               xcc_mask);
>>>> +    }
>>>> +
>>>> +    return -EINVAL;
>>>> +}
>>>> +
>>>>   int amdgpu_xcp_dev_register(struct amdgpu_device *adev,
>>>>               const struct pci_device_id *ent)
>>>>   {
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h b/drivers/gpu/ 
>>>> drm/amd/amdgpu/amdgpu_xcp.h
>>>> index 692508be23fb..6eed82ad49b1 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h
>>>> @@ -44,6 +44,7 @@
>>>>   #define XCP_INST_MASK(num_inst, xcp_id)        \
>>>>       (num_inst ? GENMASK(num_inst - 1, 0) << (xcp_id * num_inst) : 0)
>>>>   +struct amdgpu_device;
>>>>   struct amdgpu_fpriv;
>>>>     enum AMDGPU_XCP_IP_BLOCK {
>>>> @@ -219,26 +220,23 @@ amdgpu_get_next_xcp(struct amdgpu_xcp_mgr 
>>>> *xcp_mgr, int *from)
>>>>       for (i = 0, xcp = amdgpu_get_next_xcp(xcp_mgr, &i); xcp; \
>>>>            ++i, xcp = amdgpu_get_next_xcp(xcp_mgr, &i))
>>>>   -static inline int amdgpu_xcp_get_num_xcc(struct amdgpu_xcp_mgr 
>>>> *xcp_mgr,
>>>> -                     int xcp_id)
>>>> +int amdgpu_xcp_get_xcc_mask(struct amdgpu_device *adev, int xcp_id,
>>>> +                uint32_t *xcc_mask);
>>>> +
>>>> +static inline int amdgpu_xcp_get_num_xcc(struct amdgpu_device 
>>>> *adev, int xcp_id)
>>>>   {
>>>> -    struct amdgpu_xcp *xcp;
>>>>       uint32_t xcc_mask;
>>>> -    int i, r;
>>>> -
>>>> -    if (!xcp_mgr || xcp_id == AMDGPU_XCP_NO_PARTITION)
>>>> +    int r, count;
>>>> +
>>>> +    /* Derive the XCC count from the partition's XCC mask (or the 
>>>> full
>>>> +     * device mask when not partitioned). amdgpu_xcp_get_xcc_mask()
>>>> +     * handles both partitioned and non-partitioned cases.
>>>> +     */
>>>> +    r = amdgpu_xcp_get_xcc_mask(adev, xcp_id, &xcc_mask);
>>>> +    if (unlikely(r))
>>>>           return 1;
>>>> -    for_each_xcp(xcp_mgr, xcp, i) {
>>>> -        if (xcp->id == xcp_id) {
>>>> -            r = amdgpu_xcp_get_inst_details(xcp, AMDGPU_XCP_GFX,
>>>> -                            &xcc_mask);
>>>> -            if (unlikely(r))
>>>> -                return 1;
>>>> -            else
>>>> -                return hweight32(xcc_mask);
>>>> -        }
>>>> -    }
>>>>   -    return 1;
>>>> +    count = hweight32(xcc_mask);
>>>> +    return count ? count : 1;
>>>>   }
>>>>   #endif
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/drivers/ 
>>>> gpu/drm/amd/amdgpu/mes_userqueue.c
>>>> index 16aa22b25098..1c7b2f3227e5 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
>>>> @@ -503,8 +503,7 @@ static int mes_userq_mqd_create(struct 
>>>> amdgpu_usermode_queue *queue,
>>>>                   uq_mgr_to_fpriv(queue->userq_mgr);
>>>>               int num_xcc;
>>>>   -            num_xcc = amdgpu_xcp_get_num_xcc(adev->xcp_mgr,
>>>> -                             fpriv->xcp_id);
>>>> +            num_xcc = amdgpu_xcp_get_num_xcc(adev, fpriv->xcp_id);
>>>>               trap_params.ctx_save_area_address =
>>>>                   compute_mqd->ctx_save_area_va;
>>>>               trap_params.cwsr_sz = compute_mqd->ctx_save_area_size;
>>>
>
