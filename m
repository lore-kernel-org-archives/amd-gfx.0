Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0534FCCD19F
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Oct 2025 16:34:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8971F10E2AF;
	Mon, 20 Oct 2025 16:34:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="W8/uxG13";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011071.outbound.protection.outlook.com [52.101.52.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0DE8C10E2AF
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Oct 2025 16:34:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vI4U+u2O6SDxF6hLFf2DFbwM6eKM84BfLOnBtoTiNgupra1xaCqKFrB0sXMlao8uJOabHTSn8AJvw1utphHTi3VX3in6hyAQw4yHtyXn89X9UYbK23fkO9CKTYHJF082o8iHWAwuYUkZoKxcjVggm8AtM9S340SOlll3cCgND7kEjdrv5HU7UftFC2svH7/08OWSn4mO54FdonjKfhqWAJnTQmEMIhHV+/BhO+jo8cIq4DHntsgp7VSIO6sRFJKyapQExrkS1FqOedP/ZLlxaPxD9sAGmUzudbCKHTjfq+mVItq1BoKm0txpwUxncWgW3SWLTLQxkqMtuZoBm3cBRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xSz+3mNFfvwn0iA68bWUFEpjJhdrSa6T9bPhtMCdwlY=;
 b=RaQNUTyECF74VEgXLLZsNZz53vheE++wnWjxcGjAQsQr7DA3YFkmjp4xORKvlfFln5L1gPs0mFT3Ua2wfpNrbgcICTr2OjIu7kXfaHT/xXbq1d3If+bmdu4TqDwKUTSpMSG/bd/KuJKcz/CfdGXEepqXKGbCxjqtMKRaiwaHinMrjvM+Jn4Sie119CHLe77bthP9fZE4/O9GaI6MlSgEZJzTKrm0bgMU/XHvd0H5K3MLEmorGVxOgJp4TeA/e2snYTzZ9pTnRILbNQONeFPJJjTffY8PCUBBv4t5FBHhA9yOuaNF1RY6xuPo82wv9p1s3EI+ncufj6MOsXFQqNE6aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xSz+3mNFfvwn0iA68bWUFEpjJhdrSa6T9bPhtMCdwlY=;
 b=W8/uxG13Sj7wJWKvwNs6DTHw9pQbdDj/oHGPZ89ZWx43fj4Da8dzM+O6yv03Ulegqvlqj3W/UsYk/SqlSVpogD3H3RqTUuqkNhNMv3yyaJqV73NJ/xWXM7uQEOXZON5CPJ9ywD2W5lLusT8T5Zc2GT3amQjAsoHLfhKk+bU4agQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5149.namprd12.prod.outlook.com (2603:10b6:5:390::14)
 by IA0PR12MB7651.namprd12.prod.outlook.com (2603:10b6:208:435::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.16; Mon, 20 Oct
 2025 16:34:42 +0000
Received: from DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::36fa:deca:aaeb:75da]) by DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::36fa:deca:aaeb:75da%4]) with mapi id 15.20.9228.014; Mon, 20 Oct 2025
 16:34:42 +0000
Message-ID: <1d60c36a-523b-5bf0-bea9-7d5fbdecf93e@amd.com>
Date: Mon, 20 Oct 2025 12:34:39 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v3 1/2] drm/amdkfd: Fix false positive queue buffer free
 warning
Content-Language: en-US
To: "Chen, Xiaogang" <xiaogang.chen@amd.com>,
 Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Felix.Kuehling@amd.com
References: <20251020143016.23409-1-Philip.Yang@amd.com>
 <f82491c6-c6f5-449e-89e1-1735606f60d0@amd.com>
From: Philip Yang <yangp@amd.com>
In-Reply-To: <f82491c6-c6f5-449e-89e1-1735606f60d0@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT4PR01CA0363.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:fd::12) To DM4PR12MB5149.namprd12.prod.outlook.com
 (2603:10b6:5:390::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5149:EE_|IA0PR12MB7651:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d9afc18-ddf4-442b-2a27-08de0ff6926d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VGFQeU05RnpIOHpGQnJCRnB5aW45QWFFTGFXb3BhYk54VmlOVytIWSs2ekhv?=
 =?utf-8?B?NVBQWFEzckN2dG9xMkR1RW4vSGY1TFl4dmtNNEh3RXRNYURKTzU4RVZ0WlZ5?=
 =?utf-8?B?dnErS0MvY04zRm5ySnJ0MkhySGxlbGcxeUZiZFRvbXV4aUhHWEpIQUtzR2RS?=
 =?utf-8?B?UnBIQXMyU3RVY3oxMy9EZCsxVkN2NndIbWhobWZtUkNZMkJVeHIycmVZdGlk?=
 =?utf-8?B?RFZpN3BiRmt4NlJmdUVMbjJzUTlGNHRoTDlKYUV4S1grcmFadjR5VUpFVXAv?=
 =?utf-8?B?OVp5TzUwaGFGZlhMbFBNcmNRZjRLakFJQlh5Z0JwenNMV28renpLT3FNMmgv?=
 =?utf-8?B?elJ5enhMK1lmSmIwTjdXclJXZHNyMjVLckJabWxFWmlYYlJrT0lBaDY2OHFR?=
 =?utf-8?B?Yk01a3VqVjVTZXBWdENvSVRkUUtFZTN6TzVCSFdSZ2JaU04yblRxdWFCQS80?=
 =?utf-8?B?V09GN3YrY3d6R0U3ZHhMdnoyeDArS2NOYTJBVFpnYlBJSFlsZXJsZ0htVnhN?=
 =?utf-8?B?czlUZ01aYkZMYTN0TkZHVmNONlhvMGtlUlByMDJOQUxucmdnU0hyRzk4ZFRZ?=
 =?utf-8?B?YThlTm1jS1gveHpxT1VKbEYyNjRJeWRjTkIxVHo5SlB3YWZITk9mU2NTUGht?=
 =?utf-8?B?cUtvMlJ5SDY0UnNhNUFDKytJTHlwUlNwdEVFNWxONTlEbzZNdUZmckZvVG9u?=
 =?utf-8?B?b0o1NHhLUU9UZmF5clBPaHcwc1NQdXc0dGk3Vy9DUFVhbHlsd3o0ek1aUUQ1?=
 =?utf-8?B?NXI5Q2MxRGFLd0ZFMjUxanR3dENaeEVDYlhyRXUxWW1aWS9ZSFIyby8rNmwx?=
 =?utf-8?B?TkJJQWgraHRrRW8rWlBYWU9qczlXTlB6c0Jxby9ERWxTRENZQWZEVkcrd2RU?=
 =?utf-8?B?WFpyOFNwOUN6R3FwTWc1QVV2Zzl3WWl1NFdZUGRqSTRuOGRxaU5mMjQyaGUz?=
 =?utf-8?B?dnp4a0VKcUVkWUY4TUVtdTRmU3VkR1k5NWN1ZTBrM2FtY1gwL3hUdnJodFBS?=
 =?utf-8?B?UVZMVVd2VnduNjBGdEJvYStDUXQ4OWFuYUhTOEVMNDBEdENRdHlKZUFaYU04?=
 =?utf-8?B?VDExNEpwSjdleENlRDNKN3ppSDdiZXFMT2VtTVNNZUJFdGhIa1NsbzV3VW9C?=
 =?utf-8?B?SDZBalVaTllPMHhCVTJMUHJ1UXJCd2FnZC9PV0ZPSSttbFdRQ0xXWVpTWUdN?=
 =?utf-8?B?cFRCUHNPUlNOckpkYTFmbVBzZ2NTcnpLRy9Hd2hpbWJiM2kzRldVZ3BZalp5?=
 =?utf-8?B?WGFUTlpiNjFCcTBVWVZiczdlU2dVdk90TGVUZEdhVm1nZE1VWmNzMUZyUkhS?=
 =?utf-8?B?UW9ybkh6OE9ubkwvaUN2a3hSM0Y5alBVVFU2cVVUenQ0aVk3N3l0YU5LcG10?=
 =?utf-8?B?ckJ6YlYrSVByY0ZZajlFcDU3dFZZYjlabk5iWFZsV1dqY2pldGJVNWJPZm1D?=
 =?utf-8?B?S1Y2LzF1SkxSdEo1dlFqZWp4cjFiWFpyckM4ZWtqQkJYVXVDcGZ6MFNwU1or?=
 =?utf-8?B?dkRCdk1pWmQxc2tBRGhVS2kvK0o2YUxBQ1FKUEp5bzRrdElzYzdRQjlhandU?=
 =?utf-8?B?Q1pZelYzTmZZSVp4ZklDM3l1Z3JNMGt0bCtzL2dlR3IxZ1ZreFU0T1h3dEMr?=
 =?utf-8?B?YkVJOXhnSXZzT0NUOHlDTGZ2U1BNK0tWSDRLLzIxT25FVkF1RzZiQUlmelZl?=
 =?utf-8?B?RzZKK2lYM3JvVHpIRDRiNjdlYllJbkJPbHVuNmdiMHVlZ0NDRyt2VExRRUlD?=
 =?utf-8?B?UEZqRFlrUmdmOWJJdDNOaVlkcVFBeHhOWVJsZCsxaG1pbWtMQ2d5dmhkYVpy?=
 =?utf-8?B?OUR6WXFGY3Vob1dmM056RjNoT1N4aTcxam44SHlIZ0hIZHdadktEUXpxTDBw?=
 =?utf-8?B?QWY1d1kxdll2R3FJeDB6R1VvMWNDWEozQzQ4NGRWSktMTmRGOXlOcVNUSGxK?=
 =?utf-8?Q?VqkpyZWfL29K8GOBrcrIb+ao3eQqZY0H?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5149.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SVZxTmtFeHZCY0hwZzg2Mkt0ak94dDhrUFpOZkVKMWtJZVdvekxMb2JwQVpY?=
 =?utf-8?B?THdId2Y0S0F3ZHJwL2FxWEpFWHRVanFSUFlzR21YVkx1ei9vRVJ5bzFPRGpJ?=
 =?utf-8?B?OUsxUEtHUDREYTVFT3NFQU91Ryt3Q1p3N0RSWnk5OW9UYjRpRElUV0oxNUZD?=
 =?utf-8?B?bmJVbDBsRXpVS01kbnM5SThScTk4STc5WFVMbS93dkJVd3g3NjlucDJSd2Vq?=
 =?utf-8?B?bmNFK1NXUjA3WkRvZ1p3Skt1MjBldDFQendJYS9MTC9mT0dOTXB4LytESjUw?=
 =?utf-8?B?TS94VktXdzF0eEpKdWR5eHlWcEhiRFdiTnc5QmtGQXNlOGt6WWEyeGMwUGo3?=
 =?utf-8?B?VnZxNTJWTFVRVG83NElHN1FaaC83NDZLbTI1SjQ3VTdEakdMQk1sOW9UbTlz?=
 =?utf-8?B?WU1FYTBjMlVuRHU1MkU3eFFjWk0xMnhnZ2Q2R3dFNm8zbTFnVlZXbnJxUk9S?=
 =?utf-8?B?bTFTQ09vTzZHRXhUeWNkSVFqQjh2OFlYSHlBaTJvYXJpQTdJM1M3b3BGUDF3?=
 =?utf-8?B?RGNCUlAyellzU00rWC8yRkdwV3JjeVFNdEkxUUZRNnphQnhDeWRjWldKWlVy?=
 =?utf-8?B?dHlYd3hKZnVQa2Z5dFB2R1dIOXkxTUlDTU9Tc2JOTUJQelphUjlGbWxCdG1Y?=
 =?utf-8?B?bVo3MlBCT1REZlhLcWtpRlpTNitHSGxhL0o3WDQ4RDZhTll3MDNsa0loMzlo?=
 =?utf-8?B?SS9pVStQdmRPd3VPWlRSR2Z0YlZKQVRaeHR3M1E0MVJzZnB3Z3Yvb0lEWUor?=
 =?utf-8?B?WkZ6b0tmS2tqY3EwMmpKSkhWRzR3WUZQTkF0eUpJOEhLcEdFM3lNUThwQ3F6?=
 =?utf-8?B?bVYrS2tIdDhNWE9WM0diVmxZZVhtd1E2YnZReWJsT0RTQXNsMlZVL3BGVGli?=
 =?utf-8?B?Q3ozVFErU0RQNVlVVy9obmV1Rll4SHZJTkc4dGVzM0lxNktBU09ZVGQvMVpP?=
 =?utf-8?B?VE9wa2dXWWhVUWw3bjEvU0JxVFg1V3hXM1AvUGlrMGJxcDgvbW93ZjdVM2FS?=
 =?utf-8?B?VGxMWkNmWm10dE5wQVB6M08vN0I2SlFkTWZTYlBOVnZwRXpveXIwYTZWdWFr?=
 =?utf-8?B?Vmd2RUVmc2ZFUm1rMFlzdjk3eDM2MFpXRm1MQ2YyLzRPSmxPWHBHMmR4bzFk?=
 =?utf-8?B?UmF1N3dTa1l2OHFRSlNTOHQyQW5RQU9Vb2ZTVXpsZ1k0SzgvU3VhQ1dNaTlZ?=
 =?utf-8?B?dDdMeGM2R1VBL2I5TjhZbngzSmRwWWlDd0I2ZjdTaTRmNVVEWHNNY2x1Vk5D?=
 =?utf-8?B?MjFPUGdzM0puTExBeStRSTdRdGt0L3FyMmx2NTZXd0RDd0lUM1o0M2RNV3kz?=
 =?utf-8?B?ckk4R1Y0dmlxaWRjdml4UzNaZHFLa0w0MG5IUU0wUGpoUFlJTTlnUHFxNWVG?=
 =?utf-8?B?TUtYTnJBMkpDUTBUZGJWYm4rRDM3dFhsVlN1eTFldUY4d1ZwL2paM3lIY1RG?=
 =?utf-8?B?ZmVTN0oycEZPcmtrODdUd2lyQ2NTTnoyQ0VjVVphZ3M1a1FrdFJjb2pXZEtp?=
 =?utf-8?B?N2F6d003dG1YbEpUZWFSYm1kMFE4bTB4VFZXK1JXWmgwUnJuNE81aGFuaFVK?=
 =?utf-8?B?Q0JINTVNa1o3QnRJYUI2YUdQdDJMYS9BTTdXNWFMUUt4b2tZdkZabElWQ05w?=
 =?utf-8?B?L293ZDFxK25RMzMrbmhRQ04rc0theTMvb0tSMWNSMHFjTnN3K3Z6QlNCL2FI?=
 =?utf-8?B?U3FJaWtSTzducU9wcXRlaVY5TG9tdFpuZnNUVzBTMUxmWFM4Q0JCZEFVK1VG?=
 =?utf-8?B?aFkzSEI4U1cvS1gzQTlrNytEMno4aGNkMjU0bWRHeUV4RHk5WTlyWTdvR29P?=
 =?utf-8?B?cnFrc01ZbDRKRE54MEgxSGhiam5uRm5xUUJvbElpajlLaGFwSWovRkxrNk1m?=
 =?utf-8?B?ZGQrUmxCTnBKV292U0M4Qnkra2tmcWxrNzZmNlJBVXoycWJmZUpTZUtWSlFW?=
 =?utf-8?B?YjVoelBmSXdvTlZweWZBc3JyVHdKNVpwdjVDTFJoY2htZk5HTytZdGovRTMy?=
 =?utf-8?B?RDRmN1dtUENROUJZWXBtMmtuK2JnZi9IckZlZkE5Ky9yQzREVWNTYW1zK0V4?=
 =?utf-8?B?aHJqamRnTkFSS0pGM1YvQkdmODFNQmpta2xPdSsrWUlaS05OU2E0dUdEUFZa?=
 =?utf-8?Q?EE88=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d9afc18-ddf4-442b-2a27-08de0ff6926d
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5149.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2025 16:34:42.7580 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G1G5sqIiCvqgIhcbp4pZAUxGHWD6WWainUuDWSFKEACJ7gXAAgNfTr6a0Z5i4PDu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7651
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


On 2025-10-20 11:59, Chen, Xiaogang wrote:
>
>
> On 10/20/2025 9:30 AM, Philip Yang wrote:
>> Only show warning message if process mm is still alive when queue
>> buffer is freed.
>>
>> If kfd_lookup_process_by_mm return NULL, means the process is already
>> exited and mm is gone, it is fine to free queue buffer.
>>
>> Fixes: b049504e211e ("drm/amdkfd: Validate user queue svm memory residency")
>> Signed-off-by: Philip Yang<Philip.Yang@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 5 +++--
>>   1 file changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>> index 4d4a47313f5b..d1b2f8525f80 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>> @@ -2487,7 +2487,9 @@ svm_range_unmap_from_cpu(struct mm_struct *mm, struct svm_range *prange,
>>   	bool unmap_parent;
>>   	uint32_t i;
>>   
>> -	if (atomic_read(&prange->queue_refcount)) {
>> +	p = kfd_lookup_process_by_mm(mm);
>
> p->mm is null, not p  because driver set p->mm to null. But still 
> prange->queue_refcount is ref of queues from this prange. If app unmap 
> this prange app should have destroyed the queues associated with this 
> prange already. If not, it is not driver issue.
>
right, we still pr_warn if app unmap the prange with queue_refcount not 
zero, p is not NULL for this case.
>
> I think driver should send this warning anyway to indicate there are 
> queues not destroyed by app before app unmap the prange.
>
if app killed or segmentation fault, mm is gone first, then queue is 
destroyed in scheduled release wq, then exit_mmap unmap the prange with 
queue_refcount not zero, p is NULL, should not pr_warn, because warning 
message "Freeing queue vital buffer...." is not related to app 
segmentation fault or killed.

Regards,

Philip

> It is an app race condition, not driver.
>
> Regards
>
> Xiaogang
>
>> +
>> +	if (p && atomic_read(&prange->queue_refcount)) {
>>   		int r;
>>   
>>   		pr_warn("Freeing queue vital buffer 0x%lx, queue evicted\n",
>> @@ -2497,7 +2499,6 @@ svm_range_unmap_from_cpu(struct mm_struct *mm, struct svm_range *prange,
>>   			pr_debug("failed %d to quiesce KFD queues\n", r);
>>   	}
>>   
>> -	p = kfd_lookup_process_by_mm(mm);
>>   	if (!p)
>>   		return;
>>   	svms = &p->svms;
