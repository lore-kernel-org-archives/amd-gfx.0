Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C892CD98E2
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Jun 2026 06:23:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B735E10EE0C;
	Wed, 17 Jun 2026 06:23:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Vph5wiMr";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010054.outbound.protection.outlook.com [52.101.56.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7841310EE0C
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Jun 2026 06:23:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N69FtXBGzIUiYxPb8jmWQ+Il2QZ+OL9TntR4iSV8gvBmTwF+nWOtMMxmtv1A1j7fZmz+VpYN/P0rwFQw3UMisd3uRn6H0fWJDZ9XcC1n8E5luE6MWfaOI28e/UCZGamaw9fp+2OcsEeu190SucVNGV9fbRQeWOlsQB3e3kj5KOf9n7tdY5DVH5WqMyT8LCufPyoPtKw8zDLYqbTtU3KEMv+ElNQzuL1LtcdpGSajk6SG/rTbP6OPLqFraAgCCtM0fJFBLvzBKXdsTD1AGBllcS08q9Ye+hEyty1J08rDlDSvIoH3mQWdraQms9kh26crON3kxPEdaIQIUt4ND125mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=emzJUUqWDtCv+1kw24+ccnjr2c8FTWoTtQBZY3/ZqY8=;
 b=pB31K20qZP1CoN0k8Bn4J6M7DAm60rdW+/xYwNaTv3u7cfZzvrZwWAPNRDlS8zwZKjF0zvuE+aoWcmPLeaGjcZxkQzT+Zv+7bEPBFkoAOcwD5yZhlHFea/EwUA+dt7Xzg+2n+ZgNrRDxW7tfBKEzeV37zMYQD9cN0EyaI1K/ZB8Xzhe8SQ6tI5cf2O39d5RDUGAlKV15fndyY2ABrwIX+Nt4SI7SDOsdQSOsBnfAmytzkNomtQebuOIXrQh/3UOO65Pula+zCS9qifFMIJ1RZgATpcAhGNF++CAC4Q2VT5Mr1yrJ8qzCaQBhx83UOAoP0rcQH/3qohiC3pAnQ34N/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=emzJUUqWDtCv+1kw24+ccnjr2c8FTWoTtQBZY3/ZqY8=;
 b=Vph5wiMr4v3WTuefasbGG60dKjvjxXaYyOgPs6GmLOkFVo15ptolav3GGoqlwk/6+nuAy8IsJbhYc/X0qkiT3oBl5StFRS7mu0BRa0nMK4ibChH7nxwU1w9A+8pq8LOFA1CjUmNAoswMcJjSG+uHrzK70W+VNof4EzM0oFHnEno=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by CHAPR12MB999226.namprd12.prod.outlook.com (2603:10b6:610:2ff::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.16; Wed, 17 Jun
 2026 06:23:02 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc%3]) with mapi id 15.21.0113.015; Wed, 17 Jun 2026
 06:23:01 +0000
Message-ID: <c2825801-31a3-4e92-8136-ed0e379f1471@amd.com>
Date: Wed, 17 Jun 2026 11:52:57 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] drm/amdgpu: Signal GPU_RESET EVENTFD notifications
To: "SHANMUGAM, SRINIVASAN" <SRINIVASAN.SHANMUGAM@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20260612055226.2879270-1-srinivasan.shanmugam@amd.com>
 <20260612055226.2879270-6-srinivasan.shanmugam@amd.com>
 <4872460d-f5bc-4031-93e3-63650ec04479@amd.com>
 <IA0PR12MB8208AD2E2E8B8363030D514990E42@IA0PR12MB8208.namprd12.prod.outlook.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <IA0PR12MB8208AD2E2E8B8363030D514990E42@IA0PR12MB8208.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4PR01CA0092.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:2af::6) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|CHAPR12MB999226:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e70672d-1e1b-4795-71be-08decc38e218
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|23010399003|56012099006|11063799006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: cIc77ywhJ8J3RNiVgayKHBBoocapkMv1tzh7ZQKQDzdH8GwIJL7NwK8BRVUzG1LWGnCARtOzCyJAryDQAFXvB9PmY07CBKkny0f+mGGMzmtiBBtbsOkNeTgVXMEywXtxBM4wr3s3TwrXksHHpn96Lapu0M0xrCNEKdBfz6MlSkOc9IjCENuoPBYC81JQHKgx9Wc2EhpJF/DX9kSoKK5/ljzVhLFd/3tHmyAXDYgNoarrrPBjnD4vq/jjWOOqmNe0dmGAKgeP6HASQV5LBO29CttOlmzRoOX06QI3nw3JDGT2Sd27LQPmJAzBS1okAFJGNdZ9mFbTihZVHxFyr8yDs61sRmKf+PJiVH/Av9bRDIkxkVVkVmHswI+3WwfgPD58RhVU6BiraiBr6gkJcQhQg/Yc0bZYlHSXz7WYbyO0XctVrV9mf3ItqIB/anjTouMQnfEo5BK2a7P6Mr0EtCRBjPBibyXDZT1/x4wZkxTb9Mur7cbU4SAAOhWfFJtYzjJ4W9+NEM2XBGNysnDqfKn/W1P0UZEtIca4tGQx/GYPpwkIL8llFCJ0UIcSZ0jLuW06ikZDJSgbHx0VnF8qYMADLh+dejTyWyYmLqZzGEojzqNGpNI4gfW7OrYoHqgTLJGVRMhB4q55zIbjEo4NFQGIPA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(56012099006)(11063799006)(4143699003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RlUzVVlmYVZBRjNWYXd6N0VrQm9GejVOdU9IS3BDOHNaai9MUm1sekZyL1Vw?=
 =?utf-8?B?cDhwYVB0c0xlZWw1T2FWM3FjeU53ZTFjYnVjKyt3MVhDbWV3UEplRFBFSmhI?=
 =?utf-8?B?bkQ5Qm5NODA4MitSZXU1TzJYSDh0S0MvUHZaT05nYk1vZE95azNIOW1MQURI?=
 =?utf-8?B?aFdWUVIwaVE4VHJ2cHM2c3g3cnRCVW1vNVdCb25TU2VYK3BWRG5jcnBxTjJH?=
 =?utf-8?B?OHBHejZ6MDBvdVRWaGY4alhFblRuRHBGZFpyRjNSeXl2VG1odVFnT3BaK3Rj?=
 =?utf-8?B?TDJRZkU4UE80SDBXMEZ1R2E0TkJWeXdzWEplL1p6NE1zajBrd2NkUU82RlpG?=
 =?utf-8?B?U2tiVWVZcVB0SUVsMVY4RXE0Y3g1RGQ5TEZnLzJYZHJCbGg4OFRPNmQrZjZu?=
 =?utf-8?B?ZlMyTXVzbVFYVWVSZzJWKzl0VDlXVythT3F6NS9ReWdNUm1lL2hWbHJRNWdP?=
 =?utf-8?B?OU9TcSs4SUtTcDM2Qm52dEVVVUVUOW94SURBTkhTN0dPY0U3YStyMFkwbFc5?=
 =?utf-8?B?SFovR2FmdGNSY1phRWFxejVQU0UrU29JNHVOdGFFbEd4SjUzMWF3MlBzVFVW?=
 =?utf-8?B?MitMUHFsVnQ0Tk9SUVBYTEJpS0FKVzdFUm84SElOMjBtcG1iVmJMVEREbkM5?=
 =?utf-8?B?dDh5ajJkVmtlMFh1SmhZd1NnNHhYVS9neWxPRE1nMm5NZ2pJc05IblhMUnBz?=
 =?utf-8?B?blpBbGJrL0xIWG9ubGg2eGFHbHBJd3UvMm1JQnhHWHh6UnlYUmdKTk5HOGZs?=
 =?utf-8?B?WTVoRDRFNzRHN3Z3TG9HTFcyZ2RGbVNPUStvVTgyUzhHd0pPeDZBeHZNQ0F0?=
 =?utf-8?B?NWlMNVVLMnR6TWRqVnE4YmVCMDA4Nkk3eXYvS1cwVzIvVy9OUFJVTDg3YXRx?=
 =?utf-8?B?bDNZWHU5TkorQ0NqT1A2Y0dHS2lQNU5XbWtiekZxOVBCQVZyNDRSQmFTT3pv?=
 =?utf-8?B?WlNvN1QvQW1nY1RIbVkrU1Q4OWdiWmNKb3crQ0puMER1dEI1NlVSdjBiU0dE?=
 =?utf-8?B?VkFZK2FrZEpGZDlSbHRyTGU3WWdReTRKNFBmYmZUMmJsc05udVEvZm1KbmJK?=
 =?utf-8?B?WHZsSDlMdklaRGlFaUZVKzBmQnI1Y0hWb3RzWGtKWFdOTFY2MmVNb1JYMzB0?=
 =?utf-8?B?cVZMQUJRYUd5T1FwRXYwMXh6clBpS0lGVGpiMmNudWt3RDdsdlhtc25WYjJU?=
 =?utf-8?B?N29CZnUwWjNUbGVWUUhmTm1oRVQ1cFZlaGdlNDR5eVV4aXk5Qnhpa2VUQmNj?=
 =?utf-8?B?enAvMjNYTW5pOFN5UklFZVNTWDhCUjhKVUg1RUorQXJJRkt1elR6bTRnRVNz?=
 =?utf-8?B?d2FHcjROUzZCZTNZT3M5b3RJbVhkb2dmWEpVMzhUS2JWM2tiVGI3V2czSnBG?=
 =?utf-8?B?ZjNoQXpmb1loc2RwV1I1M3dwZENpZmtoWTErWjRKUThxUU9HY29DdVhrR1Vp?=
 =?utf-8?B?Q2lrcjIrR0s1MEVXYmx1cERSN2NrdTMyUDFJM054dG9ibHYxUGpZdVE3SWpa?=
 =?utf-8?B?ZkxlRnRKdGh3L1RkTGpKcDJGR0JUdG12RE9Ec2NPTlZYaGhXNmZnMk9CSkJO?=
 =?utf-8?B?THd0Z2cyTVNSQWxnSWIycnRGNmNMaCtwQTBCUEgxSTV0RUtMdHNHSEVwdlI0?=
 =?utf-8?B?UWxGZDNVelAyeGZHUWRJS1lJWWNrQThqTmFFNytBVldNeDJvV2U5bzhLR1Va?=
 =?utf-8?B?M0ZUSVFXQnVBLytsK3BOVnVlME5UUmxxbCtydFlJZlA4NWtpRVNHWDVHYmgw?=
 =?utf-8?B?Q1BBcThsV01iSU1EOU1Oa2VJdUw0TjNRZHFWTHZMdlcva1cvenFkY21iSlFN?=
 =?utf-8?B?cjhMaUhEcmxtcm95czJvZGpzQ3U3YTh2a243VW9ZMUVyaXk0a2RWYUpWZ2ZK?=
 =?utf-8?B?dVUyZ0ZTTkFTckpFUWJYc1R6SDlQSGlnS290ZUl2UEZrb1VLdzJqd1JnMzNT?=
 =?utf-8?B?UDdsZ1pPZXFmdnhaN1Fkb1NYbnF3T08xSXRieWxQOVV4ei9ZOVdFTHRwd3VX?=
 =?utf-8?B?Y3JSWVNDYVhKc285TUN0eWE4U1pGazBmVHNDOUQxWjhqY1Q3cS9QRjE5d3BI?=
 =?utf-8?B?UnVZWWNMYlVVQXhDdGkrVXBkcm50WVdoQTUyZ2FXOG43Tmt6emRPWjdGcVda?=
 =?utf-8?B?RjBkYjlVbzdFWHF1MWJpVUtHOGlnMVN6WURwUDB5S21mazlMUmE4YlpHbmlP?=
 =?utf-8?B?aU9OS05YMDlvakdZZ0lLYStIOEl1SzZGcnJWbnZJSUxLeGl1QitiSkpmaExz?=
 =?utf-8?B?NUlUVDgrcHBlSmh2c1ZWUzBuNG9EcFY5U2Y3aVZveDJibmNTU2RZNVpRZUdQ?=
 =?utf-8?B?djFxZHNONVdDS0NKOTZrUVMzSG5RN0VySjYrZitFenB3endEWTIydz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e70672d-1e1b-4795-71be-08decc38e218
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2026 06:23:01.8366 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vz6z+Rn/bbAovVCF6HFH0edYF4SSu7j3WVmoN8wTajejE86nKbPQqBvr9tK7yEhB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CHAPR12MB999226
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



On 17-Jun-26 11:29 AM, SHANMUGAM, SRINIVASAN wrote:
> AMD General
> 
>> -----Original Message-----
>> From: Lazar, Lijo <Lijo.Lazar@amd.com>
>> Sent: Wednesday, June 17, 2026 10:38 AM
>> To: SHANMUGAM, SRINIVASAN <SRINIVASAN.SHANMUGAM@amd.com>;
>> Koenig, Christian <Christian.Koenig@amd.com>; Deucher, Alexander
>> <Alexander.Deucher@amd.com>
>> Cc: amd-gfx@lists.freedesktop.org
>> Subject: Re: [PATCH 5/5] drm/amdgpu: Signal GPU_RESET EVENTFD
>> notifications
>>
>>
>>
>> On 12-Jun-26 11:22 AM, Srinivasan Shanmugam wrote:
>>> Signal GPU_RESET EVENTFD subscriptions from the GPU recovery path.
>>>
>>> The GPU recovery flow already determines when a device reset has
>>> completed successfully. Use that point to wake up matching EVENTFD
>>> subscribers.
>>>
>>
>> It seems beneficial to send an event before and after the reset, rather than only on
>> successful completion of a reset.
>>
>>> GPU_RESET is a device-scoped event, so no queue object is used.  All
>>> processes that subscribed to GPU_RESET on the device are notified.
>>>
> 
> My original intention was to notify userspace that GPU recovery had completed and the device was usable again, which is why I only signaled on successful completion.
> 
> One thing I'm trying to understand is what userspace is expected to do with a reset-begin notification. For the other events in this series, EVENTFD is only used as a wakeup mechanism and WAIT_EVENT provides the associated details.
> 
> Do you have a particular userspace use case in mind where observing both reset begin and reset end would be beneficial?

This is an existing one -

https://elixir.bootlin.com/linux/v7.1/source/include/uapi/linux/kfd_ioctl.h#L536

Presently, it serves as an SMI event. Other processes may choose to halt 
submissions from their side, and resume after a reset (though this is 
still asynchronous).

Thanks,
Lijo

> 
> Hi @Koenig, Christian/@Deucher, Alexander: Any opinions onto this please?
> 
> Thanks!,
> Srini

