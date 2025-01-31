Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 519D6C0218F
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Jan 2025 17:41:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0A31A10E409;
	Fri, 31 Jan 2025 17:41:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="FbHgQO2X";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2058.outbound.protection.outlook.com [40.107.94.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5C85910E409
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Jan 2025 17:41:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v+wwvLfc1/0RUKZKVV3YA8XVQJV6tnkoTTJ5aGdG/5pt/0JeCD290lPeAzELzNOg70buGhnn6Tzw6HoPU865N2H1U6vHBGMHrOKF8imBuVX3mh9NHYEi2KHP8iKlyfg1L3mhR1MjkdVNpfHoJXl5MTGDSlNo6W9BIjrckjg3iE1DOKqs1jncfHND1DURlu5QiFifOHnhOVBuJx9yqCoECdafm6aUW+ixpHZWXf0VLz2M8jN2FUFr6SjGGqOI5SuXKDXCmjubx3d4rYTattdauyiHMXvbStuM6stSPN8xEi8PGsALQcHQTSqhlQPHZ5p85HcDuAmQ1apPNz19aqMleQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FwXP0uCTCNhIqlzSoLj83f9A0KTuPsWZu/CGy38ww6A=;
 b=CWNt85gkv5qVYElGXjiQZZpQ3jYrYn27vJZcgp3g15HWalAuG51KzaGbXo4o6bKwQT+kRyhwYPJ2YLskhV/gKfk2w64LRlDAXuxAdtFj1jnLZ564xDbMJ1tK6Tgh+IeqNI5fKazLo/iksXjXZqfqUic/HTyWYzreI2chsmmf299g05NDIHwfIecrvud1yzruaR7UUmc45zBXfCWzP4ZnIp2X8MCbiRB1+MLIrQ01JYgcuDsJb71munI13bdUbCsfFBRQjTb6SfZiC2P+M0ihQuQr86+D1G2IWqbGD4Y1eeXa/H2ZOpYB8WgYKgQAOGKyyfNO82mAMu7v+P+Gx3zG2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FwXP0uCTCNhIqlzSoLj83f9A0KTuPsWZu/CGy38ww6A=;
 b=FbHgQO2XDpMhn8wauQBoLYGzEgyHfwvrfBcQY6gMvPztBGp+73SdIgrwoovsmdswKXKqg6h8qU64byBeF00jzCdVe8lgQbQMSCkhplUP3lJq+/xsZmrdMcrwi8krpMcoLJUP+FkEZw6wtVoE19NBpza8CE/4onEF0p6KEgj12HQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6293.namprd12.prod.outlook.com (2603:10b6:208:3c2::22)
 by SA1PR12MB6752.namprd12.prod.outlook.com (2603:10b6:806:259::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.20; Fri, 31 Jan
 2025 17:41:40 +0000
Received: from MN0PR12MB6293.namprd12.prod.outlook.com
 ([fe80::49ac:e84e:ea32:d743]) by MN0PR12MB6293.namprd12.prod.outlook.com
 ([fe80::49ac:e84e:ea32:d743%6]) with mapi id 15.20.8398.020; Fri, 31 Jan 2025
 17:41:40 +0000
Message-ID: <c47138b6-5b15-4596-8022-2d63deba0326@amd.com>
Date: Fri, 31 Jan 2025 23:11:27 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/7] drm/amdgpu: Add ring reset callback for JPEG4_0_3
To: Alex Deucher <alexdeucher@gmail.com>,
 Sathishkumar S <sathishkumar.sundararaju@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Leo Liu <Leo.Liu@amd.com>,
 Alexander Deucher <Alexander.Deucher@amd.com>,
 Koenig Christian <Christian.Koenig@amd.com>
References: <20250131162321.563314-1-sathishkumar.sundararaju@amd.com>
 <20250131162321.563314-3-sathishkumar.sundararaju@amd.com>
 <CADnq5_OTt63z4unFJAcKCwztJYAMYrPgvp1hOWVRZfhg3=1S+A@mail.gmail.com>
Content-Language: en-US
From: "Sundararaju, Sathishkumar" <sasundar@amd.com>
In-Reply-To: <CADnq5_OTt63z4unFJAcKCwztJYAMYrPgvp1hOWVRZfhg3=1S+A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0182.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:be::18) To MN0PR12MB6293.namprd12.prod.outlook.com
 (2603:10b6:208:3c2::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6293:EE_|SA1PR12MB6752:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c972bbb-4a6f-440b-3954-08dd421e8498
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?a0RIb3ZQSEVjMWo0MjRuZW96ZStqb2RpeVRNODI0U3pFUTJYOGdOdWJtNnc4?=
 =?utf-8?B?OFhtRXRaQmk2S2s1Yy80eEhuazh3bTRPblUvNWtLMCtJY2tHZ2hNc2VYMDhk?=
 =?utf-8?B?bTFmbkppdEwvNkZscG94eTN5c09IbnhUWkFtemdsVmw4bDAvbWk2R1MxUHE4?=
 =?utf-8?B?aHhzdGd4RHo0S1N5YTJnVzRWTUM0Ykw4dE5RUE94bWRyU1lUZjR6MnVaUUVH?=
 =?utf-8?B?RnZZeW8vMW0vSnYwZ3ZSRUNsNTFnZkM2RldOUUNCdGloN0VydlNlVnRpbE4r?=
 =?utf-8?B?bS9oUmZBNnNXcUJmVFpDcmt4dVZrKzF3cHRsMTUwRDF5SW5ha1E1TUVHZ3c3?=
 =?utf-8?B?cCtMcGhnaFZNUjhndnVGN05selBOMS9nOTFyWk43MWVWMm12Vk42QUtGT1l4?=
 =?utf-8?B?YVZrTUVZZmVVd2M5ZGx3dWNuRGFPYU4yWm03ZVYzMVFHdk93NXJJNkdoQndh?=
 =?utf-8?B?MHdhUGJsTUJzTldnUDFuY2ZDa2toa2NTQXA5WHFkYS9ZdGttVU9seFVQM0J2?=
 =?utf-8?B?d3RJdURadUp1a04yWUdLNnREMzRpM0NnWkg5M3dqa1c1YzJPY1EveHZSNHpB?=
 =?utf-8?B?d0E0akFNVGh3UTFpekdaMEN6Q2hsUHNlNmRiQjJ5Vmh6QmZYWlc2ZDNOK2VU?=
 =?utf-8?B?d2hBK043UEhOTXdoQlloSWdmTkVFWDJKVzgvUkZuanA2SGYxbzl6c1ppN1V3?=
 =?utf-8?B?dmo5V2hXZExJa3g0Yy9RbFpFRVpjbnRiU0FnUkQ4bitTdktRWmdJc1dmOFRp?=
 =?utf-8?B?Y21Ha3l0ZmlYSzNMTFJ5cWJqUSt6MGM3eG9RL0E4T0dOSXdwaWFnQUVTRTAw?=
 =?utf-8?B?WkdNMTRVdGowQzlIN24yTnNGbUpDYUxwaEdvMHNycVJMYjF3MmFIK01xWUwx?=
 =?utf-8?B?S3hRZTBTSCs4VkRxbVBWY2p2dE9ZRUFpNVhTd0FXcldpQktEanRvWi9odzYr?=
 =?utf-8?B?VmVReTlmYVNINTlNQUprZzYzV3hVakw3QnJ2VGZqSXV0UmhJaXlxcUhGcS9p?=
 =?utf-8?B?bFZXekdoNmdzdVAzMmZneWx5clNDNkVOOGJmbWErYk04ZGFRa0l0a2tudzBI?=
 =?utf-8?B?eklsRnFYQVhvdHZ6M01uOHd0OVVMNWNUZ3M0aXZTL2J6cG5JVnRpWWEyV2gv?=
 =?utf-8?B?dzVXR1lJcU82ZU9RT0trTldvT3VuNnZ3QTFRdkFLRnBxL1BOUzlQZlFKeXcx?=
 =?utf-8?B?bldhb2FQUWs5S1ZQdjkzcElpeTk0d2xIV2dmT0dsOG5wcGNNUGt2UmNHUlBD?=
 =?utf-8?B?bjJ5TS9hU2g1S04yaEZYL1pvbm1nOVFLSjE4elAxM2dlTlhLY3BYeU9KbXQ0?=
 =?utf-8?B?UjRrWDREdGgzdnRiaWUvejNudEhsOVdWMTFqcFpUUStlUWE4UmVSc1lNRkly?=
 =?utf-8?B?eERkdmRHbmQxbzdJdStkTEhWY0V4NnZXNkk2amROaFliRkVmSTBKalpBS2hR?=
 =?utf-8?B?bjdENy9FUXErKzV6TGZ2KzJPNElZcFMzVDJaNDROWFhnM3huZnRraW9IVStj?=
 =?utf-8?B?aWhHNndqT1lXVi9xa1RaQ3Z0YS9aOWRNUDJhbll3dktGeTZmWXZ2V3FYaXl1?=
 =?utf-8?B?bUt2clZsRGx6bldEVFdpYWhYaUtic3FDQUNlQ01odklMRVE3cFZLZHdwTlVD?=
 =?utf-8?B?dGdSVHRUT0ZDM1ZLQnhnbTFIUDlvZS9WMGs1NDc5TVZUTHJvOVZLVDczSXV2?=
 =?utf-8?B?TnFDNFA3RkR1akhPWUhvT3dWTkFzRWlZcjJWUmZxUW03NG1lOVlERVJYeGJQ?=
 =?utf-8?B?Y1NNbmRWVXJqQjJmMHRoeFErcTNBV1NLdytKYXArNldCREVrQ25QaXFwWklx?=
 =?utf-8?B?LzhTRkZWNGsxNkFNSVFCZHlLbWh0V09JOGtMTlJsM244VU1Gc29qSi8xMnI5?=
 =?utf-8?Q?y2U6KOQ5DDj7H?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6293.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dlNYNklXQUcvYWdJdTdkUkQ5eFQ5VTdKWVo2d2QwalNHcjFjdVMrZUdoTTZF?=
 =?utf-8?B?WjEwS0ExS1NOTG14WGZhSzJaNm9aUDRINUZYKzR3T3R3Vld1K0IyRU5XNzdP?=
 =?utf-8?B?eDN1OTBGZUEvWWNjQTJjM2dHMDlzUmVhL0E3RlZvalloMEJWSE5JN0E3ZU1Q?=
 =?utf-8?B?eHltTUI1YmVtUll4WmcrY0ZLamJUamhXZW8xVU9QeDlDWEQ1RCtyNWluT01S?=
 =?utf-8?B?QkRYMU5RMEFyRFJEeFRCZXpKdkE1cXRZK3JGSDNKMlhxSElkL05KWFhJaCth?=
 =?utf-8?B?V1FSdEFYRjBxeUhMdWZxTDRISlZPNTJsNWczdGFzeXVhd3pFZnM3UFlLWnpj?=
 =?utf-8?B?eXorZ2I2WWhWQzd5a1JrSVNrb2x3ckExYU9DTHJ6dlUwb1dnTThoL2xlaFdC?=
 =?utf-8?B?ZVpDY0VaZ2U3ZEVrTTRObkJIVldIUG9palBKaGFRd085S3cxaFI5TTlPVFVx?=
 =?utf-8?B?SjV2ckVpVVJzMHd1TFFtSzdOSDNManFteFhWMm1mcVU2elpFTGV6MFBBQnh5?=
 =?utf-8?B?a3VzdWsvSnZWMFlINnJsSUlZa1cxZm41MDYrN2l1bEo0ekVQNHdrNkZTa2Y2?=
 =?utf-8?B?eFRyd1UwQWhCMHZQUHcxM3hZN0lGbkczVEZ1SEJoektHZ2picVRnRzdYVnhh?=
 =?utf-8?B?S29hc3NMOTJqVTBmb2ZlK2V3czAvS05GNmxVZ3pEVlRPeXA4T2EyQWQ4YWRQ?=
 =?utf-8?B?dEYxVk9YbzdYNUVVYlBhVlk2RHpUVnNZd3VXWlRSdU9Uc3JYbzNjRUtuQkhZ?=
 =?utf-8?B?c2pIZUxjejlVcEowdE8zMVVGNnY0SnZraVhPRUhxbm9IYit4L3lrSGJFcWRF?=
 =?utf-8?B?NjJsN0lkY2c4RlN3L2xjanZWOUtTT3ZIQlBmRWdYblZqclF1SkJRNmp5WXRV?=
 =?utf-8?B?RlBKRnVNWnI5cFRVWW8rMnY1Nm1NV3dFUTlVVFZYTUN5Y0p5enlJSzMrMUpM?=
 =?utf-8?B?VTh4MHpuaXBuTVNZUUdLSlk2cEFoWjV3Z09jTExOSkd4bXd1cGY5aUdzQlRE?=
 =?utf-8?B?dDAzY1RPQ2F0YWIvWnRHRjBJYmNNeEtidWVWQlpRMkRFRERMT2xUSVYzUEs4?=
 =?utf-8?B?eXAxZllBZ21HazhtREg1dE5uUUhpOTJkRmVMNkQ4L0EwSEpJSnhyTG80bDdC?=
 =?utf-8?B?YzJGbmtNS0RxYnp2SVBGRnozazNpTTR4ZHJmbDFkV0UwZGxMQm5VcDhXRGtp?=
 =?utf-8?B?c0Y2eXJBbkMxb25udHlLeEJKc3FhMWpobC84L00vV2grSnRUVHlKMnhoVjNW?=
 =?utf-8?B?VkFFUUxzaWFZVDdUR1BJbmE4QWo4aWNEUy9OeWhNV1Y5dElrYS9jTTRxZUE1?=
 =?utf-8?B?L1lGbys4YUVFTGkrM3B5YUw4L0ZWN0lRSFQ2VlpsSThycEMvYkdiMEpVRTlv?=
 =?utf-8?B?ZS9aZmlVUzdWU0hyVzI1M2Jxc2pURmVZQm50RGdyVm5lVjYwQXBkandaMkN1?=
 =?utf-8?B?Y09jUE9OTzVQTVRRUEhreHhJdzVCRFVORFlBc0pFeEdsdzBkT1A0WGgyNTYw?=
 =?utf-8?B?VndYWnhsbXhZcThqa3h5ZnZna3RmZTNwUXpYV0UyQnpubXI0Qmx1UFNTbTFM?=
 =?utf-8?B?d205WHRSU0ZXWW91T0V6NFRqWTVNWnVnaDQweE1OamNEc1hWamhPdVVINjEr?=
 =?utf-8?B?akl2dVkvK2RhRFdWL2p1TERldTBWeXdmTHNtQnBoNjR4Z1BJUHZQZk9NclM1?=
 =?utf-8?B?cm9maFpDbWtXNVlhWlVJMkZqYzhsUW5Qd0VHMXNpRlN0QThOOW9JRGRyWFBD?=
 =?utf-8?B?dXVlWFE5OTl4U3JsNzRCeHVwd01KNzYveFhsSGV2bmRHQVBZYjBXUFFtbUh6?=
 =?utf-8?B?OGJZS2liM1IvSE5VU0Nja3VCN1hhY25nMmFzM3QvclpBRnFZNTloaDV3UXBa?=
 =?utf-8?B?MXdaZVNqOVRTQkZ4VERDdzdEM2JvREdrTWpxRTZOSWlIOWg1NzZQanJFSDhz?=
 =?utf-8?B?b1NadjFxYkJZbzVBUTdWYUNBNTJmVkpTUUp2RXd0U2dUUnVNc3Q2dTVZNWgw?=
 =?utf-8?B?bHJxMFlPaGpmTHA0OG51VC92OEpWMzNsQjJpR1hEVjFoVHZTYm04VnlZNjBI?=
 =?utf-8?B?ci9xQzZqc2V2T1hWV3hUQ2xNbGc3ZG1rQU83Wk93TVdFOGpPZkFGMU12MWFo?=
 =?utf-8?Q?l7vRdCzh9BS5rpYC4cCSMqui6?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c972bbb-4a6f-440b-3954-08dd421e8498
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6293.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2025 17:41:40.0516 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9fsSconOICflUhX3N+pm4UmLHxvEo3Ugp19zgEgDoTkurCro8WWoGEER1/tN5TVB9DMC7/BSWH5QReXAC0u1Kw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6752
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

Hi Alex,


On 1/31/2025 10:42 PM, Alex Deucher wrote:
> On Fri, Jan 31, 2025 at 11:32 AM Sathishkumar S
> <sathishkumar.sundararaju@amd.com> wrote:
>> Add ring reset function callback for JPEG4_0_3 to
>> recover from job timeouts without a full gpu reset.
>>
>> Signed-off-by: Sathishkumar S <sathishkumar.sundararaju@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c | 60 ++++++++++++++++++++++--
>>   1 file changed, 57 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
>> index be0b3b4c8690..62d8628dccc5 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
>> @@ -204,9 +204,7 @@ static int jpeg_v4_0_3_sw_init(struct amdgpu_ip_block *ip_block)
>>          if (r)
>>                  return r;
>>
>> -       /* TODO: Add queue reset mask when FW fully supports it */
>> -       adev->jpeg.supported_reset =
>> -               amdgpu_get_soft_full_reset_mask(&adev->jpeg.inst[0].ring_dec[0]);
>> +       adev->jpeg.supported_reset = AMDGPU_RESET_TYPE_PER_PIPE;
>>          r = amdgpu_jpeg_sysfs_reset_mask_init(adev);
>>          if (r)
>>                  return r;
>> @@ -231,6 +229,7 @@ static int jpeg_v4_0_3_sw_fini(struct amdgpu_ip_block *ip_block)
>>                  return r;
>>
>>          amdgpu_jpeg_sysfs_reset_mask_fini(adev);
>> +
>>          r = amdgpu_jpeg_sw_fini(adev);
>>
>>          return r;
>> @@ -1099,6 +1098,60 @@ static int jpeg_v4_0_3_process_interrupt(struct amdgpu_device *adev,
>>          return 0;
>>   }
>>
>> +static int jpeg_v4_0_3_wait_for_idle_on_inst(struct amdgpu_ring *ring)
>> +{
>> +       struct amdgpu_device *adev = ring->adev;
>> +       struct amdgpu_ring *r;
>> +       int ret, j;
>> +
>> +       for (j = 0; j < adev->jpeg.num_jpeg_rings; ++j) {
>> +               r = &adev->jpeg.inst[ring->me].ring_dec[j];
>> +               r->sched.ready = false;
> I think you want to call drm_sched_wqueue_stop(&r->sched); here
> instead to stop further submissions to the other rings.  Note that
> drm_sched_wqueue_stop() is already called from amdgpu_job_timedout()
> for the queue that kicked this off.  You'll need to start them again
> after the reset.
Thank you Alex for the suggestion, I will use this to stop the 
submissions and start them after reset. This will help save other good 
jpeg contexts.

Regards,
Sathish
>
>
>> +       }
>> +       /* publish update */
>> +       smp_rmb();
>> +       for (j = 0; j < adev->jpeg.num_jpeg_rings; ++j) {
>> +               r = &adev->jpeg.inst[ring->me].ring_dec[j];
>> +               if (r->pipe == j)
>> +                       continue;
>> +               ret = SOC15_WAIT_ON_RREG_OFFSET(JPEG, GET_INST(JPEG, ring->me),
>> +                                               regUVD_JRBC0_UVD_JRBC_STATUS,
>> +                                               jpeg_v4_0_3_core_reg_offset(j),
>> +                                               UVD_JRBC0_UVD_JRBC_STATUS__RB_JOB_DONE_MASK,
>> +                                               UVD_JRBC0_UVD_JRBC_STATUS__RB_JOB_DONE_MASK);
>> +               if (ret)
>> +                       return ret;
>> +       }
>> +
>> +       return 0;
>> +}
>> +
>> +static int jpeg_v4_0_3_ring_reset(struct amdgpu_ring *ring, unsigned int vmid)
>> +{
>> +       struct amdgpu_device *adev = ring->adev;
>> +       struct amdgpu_ring *r;
>> +       int ret, j;
>> +
>> +       if (amdgpu_sriov_vf(adev))
>> +               return -EINVAL;
>> +
>> +       jpeg_v4_0_3_wait_for_idle_on_inst(ring);
>> +       jpeg_v4_0_3_stop_inst(ring->adev, ring->me);
>> +       jpeg_v4_0_3_start_inst(ring->adev, ring->me);
> Is JPEG pipelined or can each engine only process one packet from one
> queue at a time?  If it's the latter, then when you reset the engine,
> you'll need to save the current rptrs and wptrs from all of the queues
> on that engine before you reset it so that you can restore those after
> you reset and kick them off again where they left off.  That way we
> don't lose any jobs running on other queues.  SDMA has similar
> limitations for chips where we can only reset the entire engine.
>
> Alex
>
>> +       for (j = 0; j < adev->jpeg.num_jpeg_rings; ++j) {
>> +               r = &adev->jpeg.inst[ring->me].ring_dec[j];
>> +               jpeg_v4_0_3_start_jrbc(r);
>> +               ret = amdgpu_ring_test_helper(r);
>> +               if (ret)
>> +                       return ret;
>> +               r->sched.ready = true;
>> +       }
>> +       /* publish update */
>> +       smp_rmb();
>> +       dev_info(adev->dev, "Reset on %s succeeded\n", ring->sched.name);
>> +       return 0;
>> +}
>> +
>>   static const struct amd_ip_funcs jpeg_v4_0_3_ip_funcs = {
>>          .name = "jpeg_v4_0_3",
>>          .early_init = jpeg_v4_0_3_early_init,
>> @@ -1145,6 +1198,7 @@ static const struct amdgpu_ring_funcs jpeg_v4_0_3_dec_ring_vm_funcs = {
>>          .emit_wreg = jpeg_v4_0_3_dec_ring_emit_wreg,
>>          .emit_reg_wait = jpeg_v4_0_3_dec_ring_emit_reg_wait,
>>          .emit_reg_write_reg_wait = amdgpu_ring_emit_reg_write_reg_wait_helper,
>> +       .reset = jpeg_v4_0_3_ring_reset,
>>   };
>>
>>   static void jpeg_v4_0_3_set_dec_ring_funcs(struct amdgpu_device *adev)
>> --
>> 2.25.1
>>

