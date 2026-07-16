Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6EBAC44512
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Jul 2026 06:44:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 559DF10E2E3;
	Thu, 16 Jul 2026 06:44:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Dk0ET/BS";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011008.outbound.protection.outlook.com [40.107.208.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 73E9B10E2E3
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Jul 2026 06:44:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cfRvNdOW74Mr/gfNw+bggElEyWtp3LxQpKFJ7TB8XBLFxp4TNAHBpnWDJsC6flVO1qg8bhcIphr+inSeCoBa9Sd4P6B/h0dYUqtIUz1uWBAl/ZWpTHg2HL7SUV1Uk6QpM+Poqyb+Z5yV9s8S8MDAz02vQFVnYoZz52K/mWyyvPljcS1X0zFgAnWr3GZixA4Ml2LPiGQBnJ5jGp7sxH8+PwTs0o9QbRUUBgx5yKfm9pHZ7wOniildRzIu2DAL6j1Xjb3sP/BlM5BTIOooLjSsUL65En3P/AiWVeLNpLbMtWcGun9GWINDcxjFPNGC8wqppJtCrUMdW7SzcQGEHiGLBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TX5bh15cKQ/ZgstUqTIDxXD8lLY1A/0OvmZ5bARjA54=;
 b=ZjprBvXvaRr1f1AjCn19bZ4dDfeViy0orcy8xpeCrOgAn0vTsR8ZGRMMnHR7JzFSji6TLYmQ/Xbl3467GdcinBCFIFx2RG8VfJXDwVrsRPhfsSQ7hBsSehCSiJ1c5IMLu36MHvyOeLuQbEJxx8HSsXxzT9aNEkSh6mA1QcJXrYCk+Yrs2OjK0pzPwC4U/S9S/4cWBkAo7GF/Jjd4oTdlRRq0wNBwzI39hKU37NgWxgwujnfJAQe00DHlHOdHO+xQLNEw44JzNkuU/QODnkbvO3MU1RkeTjgdZUjWcuRAPvNXSmtkZd8OHR0dhLFb9x6F7TwXpzYnkuC/KyAsl4i4NQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TX5bh15cKQ/ZgstUqTIDxXD8lLY1A/0OvmZ5bARjA54=;
 b=Dk0ET/BSufT7W6xCiDJO7KBmaky5crd+0+s5e4m98ITyPFy5+j6ILNOxNrS9j+Y45Kqbta5BEVs0vGIaTlYz2Yt7TXS66x6mxJyBJWu0dMl9KPVCAP+FCf3Z7Azh25dkAU0XsBp06GVX8BQKsWrG1oJ9O3T9eHVLCH1snXmSPmE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by PH7PR12MB9223.namprd12.prod.outlook.com (2603:10b6:510:2f2::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Thu, 16 Jul
 2026 06:43:57 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc%6]) with mapi id 15.21.0223.008; Thu, 16 Jul 2026
 06:43:57 +0000
Message-ID: <3b22af83-9f55-4a46-9d07-927fb90f7e02@amd.com>
Date: Thu, 16 Jul 2026 12:13:48 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/14] drm/amdgpu/ih6.0: Use MMIO ACK for retry CAM on IH
 6.0
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 Natalie Vock <natalie.vock@gmx.de>, "Shetaia, Amir" <Amir.Shetaia@amd.com>,
 =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>,
 "Limonciello, Mario" <Mario.Limonciello@amd.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>,
 "Kuehling, Felix" <Felix.Kuehling@amd.com>, "He, Siwei" <Siwei.He@amd.com>,
 "Yang, Philip" <Philip.Yang@amd.com>, "Joshi, Mukul" <Mukul.Joshi@amd.com>
References: <20260701161721.85681-1-timur.kristof@gmail.com>
 <3014087.Ex9A2HvPv6@timur-max> <e934a6fc-473f-4a98-92c0-5cefdfc7e202@amd.com>
 <H4udL4GlQcaqUkZjX19xCw@gmail.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <H4udL4GlQcaqUkZjX19xCw@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5PR01CA0301.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:220::15) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|PH7PR12MB9223:EE_
X-MS-Office365-Filtering-Correlation-Id: 89fccff9-349f-41e6-c797-08dee3059c4c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|366016|1800799024|921020|22082099003|18002099003|3023799007|4143699003|10067099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: 046NdUGp3pHuADKJ7F6Q8x6vWnylWD7qCeSnfywgUtHO9l4Uwh1R9VvLD+PTvWggWWYsacFZkvpsKOTvOdx/rQxh+scCpjoqDRTIV1C+HXsv+nZX7eDqFaqh5C6L8Vdege7LRDqzLxF9a+UJqevt+FW6EeCAMF2yuC/mIS2J87loUHqznn5PdrAcQg7ZIxnqVn8nkpULFX2T2Nr1o1C2PO7LXOzOSVhV85gkRtutjYiMne+7ygTYvDNx+wjbmmNmZf09pfXVRSaXYewDkSFr9VYq9cT4bvHxNVDus70ObX/O1y4i6+QN/XumoyczyOeOGmMnY40QZgZjEPuv8gREg6SLc9Q4Qax+NWih951C0V8uM1GCuJclcn0iaSG9/Lln5Xe/VE2iYrWXU1KCUZIfktdCA9uDUUwIlauik/SnJTXfHxYec+70a+lAPMlZfafYleUuhx/ga5Hq2tAQJZd5lKKtzwwDWmT3RUjQzlwE2nKVl/dF6DjWmngSametoi1Q4Gm5ozEgt6G9GKkUxAS6YZWIBq8jRhQEJzz8x+kpWfXBBqdsvwz4lXX8WcugRAytL5sEBb1h3YTyrLR2t8rG0oiTPDqeODHVc5oCQz+5tgx6IEeug4jLYrnrM1oyRhD8DAf6qB9q4TpMHW6QmvEbpq9M+xn6nnkgDdzOoElpeh1tR1/AGaSnvpx+tddQUhNpFeNfmFdVGXSrB3PZu30/vw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(921020)(22082099003)(18002099003)(3023799007)(4143699003)(10067099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WHdoc1gxMjdwei9PS1FFbHhuNkNwVkphaDBtNEp2QStEMkRPanNGZ0c5S1BE?=
 =?utf-8?B?dWR5eUthdkN1VFhNamkyaGFLVDNrNXh3VkRQWkQwcnlXWG1GeEFYSVdJN1lY?=
 =?utf-8?B?TEs0YzI5ZHFZeVd0ckZ5UDR2U05nQXFUb0dycWl2OWtuNUVxRUE1N1oyWTRw?=
 =?utf-8?B?QWova1cxR3RRcFpTNDd5S3FnVWZpTDNnTzVwZ3ZsZHA5UkV4NlpPc2c2Yjcz?=
 =?utf-8?B?NUV0SElFQzROOVRtQ2c2OTZMSC9MelV1cTFJLzFSL1RDaGZSaXozQnF5d3NB?=
 =?utf-8?B?Vlg0S09FSEdJTzhycnJZNGZwM1RSdkZTRXVzeWltWmNJbnlyaGFQSzdxWjZC?=
 =?utf-8?B?em5OaHlSNTZhMFNnWFc2SGp5bjF2dFp2d3lYWW1SWVNTVGhxK1FhVmI1U3VD?=
 =?utf-8?B?NGV4KytrQUdDTCszT1VVZ2w4a3FLT0VPVXlmWmdrU3lmbEZrb3FEdzFRdUth?=
 =?utf-8?B?R1NJOWVnWmJ5eG1rLzdXU2pnMDdqMU5iVVpyNjFMUlQreWx5cEh2Z2F2YjF5?=
 =?utf-8?B?OE1ING16Q1BKUUx6S3BwTThKSXlsbnRZc2Q5OWoybzBBb1Z0MkR3MGU3dWNF?=
 =?utf-8?B?OEdHN25tQlZKNWI2cXp5ZlF6Tnoxa21PRm9RWkxzL2R2ZGU1WlRWMFpuazh5?=
 =?utf-8?B?QU82aFVwMjgwdVZPUDZhTE84U2hzSVQ3UFoxSmRCYU1qSDFWZE5KSEpBcnFG?=
 =?utf-8?B?dlhEd0RuWGx5c1pWbjJqMjNxdVU0enJLSGsvN29IekNYdHVsM2N3VWFFb2tn?=
 =?utf-8?B?cGcxVVpqRUFUbjlSUjdyd05vOUplcU9idERKSDFESkFVdG0wZWtCaHdrTjBR?=
 =?utf-8?B?K081WHdsUEdCY3FQWXF2Mk9uS0QwSkY1Q0o0dUdaaVpjMmxvZ2t5WHprME5h?=
 =?utf-8?B?WVczeGFaYnk0UkxCYjU1MUtiVDlHcklhL05KUmVpM2VMTVhTTWVqRzFobUFm?=
 =?utf-8?B?VDBTSXJ2Tkw3SmtBakRVVllMKzJzQTk5elJyc2VkbjU4K1RQMi9zdG9XTUhh?=
 =?utf-8?B?cnpETEF3UUtFc3NPQXhzTmx0c21Ea0ZBRGFqRHZUWWE2SEI3Rzk5R0VBZCtE?=
 =?utf-8?B?Q0hQNDYvNFNmVG9YUnJvM0tYN0EzcEh3K2Rxajc4anlRQ1JORE9wS2xJVmZ3?=
 =?utf-8?B?VjdUeDg4bUxGVGlXeUlZcFFXTloxUG9adzZ4VWwyRUdlN1NoU2FOYjFmclBI?=
 =?utf-8?B?NExGOTJLS2NYVUxoN3NsTCsvQkVOZFB3ZVdiemlRWjFFSEpzYk9tRWllV0or?=
 =?utf-8?B?dnIxdnJaWE0rSEpHZEtjalBGZnR2TTBvZCtpTW82Zy9ac2dqT3lpcjZzSEJt?=
 =?utf-8?B?eXc2NlEzYmYweGNRNVFCVUxsM083V2FyMWEyRVQ5ZmcwdnRjclplaWJCN0F1?=
 =?utf-8?B?NkVUWnRuU3A2UUViTFNyZi9XT1hycUZzc0dGblJDRlJMM3BhRXNNV2l4Q1pW?=
 =?utf-8?B?aFJyeTI4M1hYK1dmTUw4elpDci9SK1ZNU2wzTDFOZCtuakd2UHhmL2Y5MnA5?=
 =?utf-8?B?RDlvOUpQa25HTEVjUzQweDd3UXptaFRybXJENEM0MVBHN1Vuck8ydk5tb0tq?=
 =?utf-8?B?b0Z5TDRTUjFuVjR6YWMvNHA4SEorS3ZhRXRZOE1uUWpSNVpmTzlIdmpURzQ4?=
 =?utf-8?B?d3RXbXB0UVJseVczOTlkVENyczJCaEY2NTVaM0hJTTdPdlpOTU5JMm1MTXZ5?=
 =?utf-8?B?amc1Sjg0T3ZyOHNETktBM1VHeTJHSmJQeVZtUFp1YXlIODF0ZWJHUTNuQ1E2?=
 =?utf-8?B?ZHZUMFVPcUYraGc3a256V1VSTzJpWVU1Wk5ia2ZZVmVCZk9XN0d0b0grby9v?=
 =?utf-8?B?bzRzU1FlQWZYNGxQR3JwRTIvM2d4T1dFVVQzUE1YbjJHMlZYQXJEUHNVNHQz?=
 =?utf-8?B?R3lkWlo3STV6SDhtay9tcms2ckxmb2hjbVZGQy92WEpPRkFKZzRsdkp0ZXVy?=
 =?utf-8?B?bUw0ZndEajcrOE1vWXQ2TkZsS2RBM2pldjZnWUc5eG1XQmdDY2l5QnMzWHZR?=
 =?utf-8?B?RmNwOUkza1k3VXhVdGdVMEFGbXRIU0VlQmgxY1lmUFJKTGVidzY4VXBGVTU1?=
 =?utf-8?B?UkhmTTBTOGhobVlzcThuZHYxU2pPbHdIM2VZN3VBcmVJc0JDQkI1dWFhWGc1?=
 =?utf-8?B?UUZVa0tFVXFoOVB5QkdzbFlzUjFtdGtPbUxpaytTbXkyTVJCMWI1UnZzQy9x?=
 =?utf-8?B?MFFnWUFad3h3RzdOeXkyVFJSREp1TU9INDQwMmNvd1c5QjBmZHZZdVh1RGNO?=
 =?utf-8?B?SWFQMEpXMWh6RldNbXl5QmZvTWRZbTJaQlF2cHRIUzJrREVLd2doYjVVUHJ2?=
 =?utf-8?Q?dGBfsnToy97HP0TOOT?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89fccff9-349f-41e6-c797-08dee3059c4c
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2026 06:43:57.1375 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xR9v48v2pqJiRMuEe367s1Z0gGgXHXeFidffoL7BmAuCuWZ3H9AdDaT6Ibog5VoD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9223
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



On 16-Jul-26 4:25 AM, Timur Kristóf wrote:
> On Tuesday, July 7, 2026 10:25:09 AM Central European Summer Time Lazar, Lijo
> wrote:
>> On 04-Jul-26 12:20 AM, Timur Kristóf wrote:
>>> On 2026. július 3., péntek 20:11:59 közép-európai nyári idő Joshi, Mukul
>>>
>>> wrote:
>>>>> I still haven't found any explanation why we use a doorbell for the CAM
>>>>> in
>>>>> the first
>>>>
>>>> place? Lijo, Alex, Felix does anybody know that?
>>>>
>>>>
>>>> If I remember correctly, we weren't sure if the IH_RETRY_CAM_ACK register
>>>> would be available under
>>>> virtualization. And we were sure doorbells would
>>>> work for both bare-metal and virtualization.
>>>
>>> Hi Mukul,
>>>
>>> Can you clarify that please?
>>>
>>> How are retry faults supposed to work under virtualization? Is the
>>> interrupt processed by the guest or the host? Why is the IH_RETRY_CAM_ACK
>>> register not available under virtualization?
>>
>> For clarification - CAM entries are separate for PF/VF. ACK register
>> also has PF/VF copies. However, in general host driver imposes MMIO
>> register access restrictions to VF, possibly that's the reason.
>>
>> Please note that IH_RETRY_INT_CAM_CNTL is PF only. With new versions,
>> please make sure to add a VF check for programming.
> 
> Hi Lijo,
> 
> Can you please clarify what PF and VF means here?

PF = physical function.  VF = virtual function. On virtualization 
environments amdgpu is a guest driver.

Translates to below check for cam_cntl register programming.
	if (!amdgpu_sriov_vf(adev))

Thanks,
Lijo

> I'm not familiar with those abbreviations.
> 
> Thanks,
> Timur
> 
> 

