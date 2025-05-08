Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09023C3ABC0
	for <amd-gfx@archiver.kernel.org>; Thu,  8 May 2025 17:26:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 741E110E3C2;
	Thu,  8 May 2025 17:26:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="SN9K+ndN";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2062.outbound.protection.outlook.com [40.107.96.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 81B5E10E3C2
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 May 2025 17:26:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uoMMcue22E1U4QCZHY2dWl9NUnEKgmZTdhh4u+LSbcmiRU7o+YBTLOQvC/u17gd2+BJPW+WgmESJ1u4PUHWtctm5IWRDzhx76xb28H4AxD30l2B4WpUyuz+gDPiKnIzGETH4SMYtImXHOIQmXE7G8ZZAF5sVJyXpPvUlb6Alyi2nbCjW1bd2IOHnIqqFqnqekQ0gkP1dYyYIHfKobPNoTY94L2a7VMdTmGQLtqneuNUOw50740ERarUPffHXv3WYg+QnygiiQ5W2+ZJ9wneepUzh+PMz/4lA2W+97OtN1yhDzyCybQ4Lnmo6nr+IuX+EOUy2gWMVGJb+WXp9nLM79g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cb4pIvSYsI1UVTjOIel0F5tYG4Zj9EFbZOR1x+JkjYI=;
 b=Qz7AIJwyBMnj1LJIgUZX8VhfC8HQTMu1fSWiRWPFiBC4uduOMMeEBI1MN7pwbumQy75aQymirJcbflI0TNk0DrxFA5KJ41qjs3jWHsdOJZdDbRt8AxTlPOq+ULlfI/QPkZpuAG1F/aBxIk5ZVr7mlnzztH2YMVzOnNZLBskKB23dU7Zxp+yz9MISSiXdzxprMlcPX6KqGbS++K1E2UBvAkqvU7Jp399KiBYdrGlq8DpOx3cZU2vW8j4as+PFxyvq3AXN58ziPNb+ZEhQaEv0Sc/fz2LF7GoB7yPuAJu4jn6TQZor5PjEG7LjzGc0fkUbcMvfZ8PU431taJT936XjnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cb4pIvSYsI1UVTjOIel0F5tYG4Zj9EFbZOR1x+JkjYI=;
 b=SN9K+ndN3Fvpz12wJt3sAkPQxsEUw/N86J72eF8DFqXT7CwfyU64DzhQtEl2TaI2bxH8Niol3zirbEq+xRGKL09h13/47+ePjpe82HGF1bakJAVHhguVhYb6ifOiIJscsRNCpjq+GaUv6lRzqYGSrEf5MPxGMPs/hLegCMHKn88=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ0PR12MB6760.namprd12.prod.outlook.com (2603:10b6:a03:44c::18)
 by CYYPR12MB8853.namprd12.prod.outlook.com (2603:10b6:930:cb::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.24; Thu, 8 May
 2025 17:25:56 +0000
Received: from SJ0PR12MB6760.namprd12.prod.outlook.com
 ([fe80::25c8:f399:b2e8:1947]) by SJ0PR12MB6760.namprd12.prod.outlook.com
 ([fe80::25c8:f399:b2e8:1947%5]) with mapi id 15.20.8699.026; Thu, 8 May 2025
 17:25:53 +0000
Message-ID: <7563a7d3-a871-490b-b756-11255d0532d9@amd.com>
Date: Thu, 8 May 2025 13:25:51 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdkfd: improve performance with XNACK enable
From: James Zhu <jamesz@amd.com>
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 James Zhu <James.Zhu@amd.com>, amd-gfx@lists.freedesktop.org,
 philip.yang@amd.com
Cc: Felix.kuehling@amd.com
References: <20250508144651.16745-1-James.Zhu@amd.com>
 <e741c57a-651e-4acf-9ae6-4268c6540e0e@amd.com>
 <6466df95-a64d-4894-b148-c153d299599b@amd.com>
Content-Language: en-US
Organization: AMD RTG
In-Reply-To: <6466df95-a64d-4894-b148-c153d299599b@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQZPR01CA0158.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:8c::21) To SJ0PR12MB6760.namprd12.prod.outlook.com
 (2603:10b6:a03:44c::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR12MB6760:EE_|CYYPR12MB8853:EE_
X-MS-Office365-Filtering-Correlation-Id: 677fd89e-306f-4912-b672-08dd8e55628a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Z2dwRisxdlhmaXhnWVlDckdEOWQvdXU4TkZpZTdjSlpQMndQcmwzRDlxK2FL?=
 =?utf-8?B?SkZ2MHRBTzJ1RE5NY2VId2tsUGswWTVaUXo4d0w4U25KVFd6L2h4aTV3UXN2?=
 =?utf-8?B?NkFqcDlMQnFJZWdUQ3UvMWZYYkZ3MFg2TmRsblZsbHhnYWdJRG15RDB2cEs2?=
 =?utf-8?B?eXBzNkloSzRIamh6SXIwYlRPQmhUcWRGcVhCSXlLakRBOE5wMHBvaWNSUlNx?=
 =?utf-8?B?dDVXL3c2ZXZOamg3eGZyNzFVay9QWnVHR3lheVBndW5wZFl0b3NybGlPVkNa?=
 =?utf-8?B?WERhV0tLeHFkTWlMS1VMc20rNDBnYnM3Nm5TM0NQVVkzZS93Z3VtUVFRQ3Fs?=
 =?utf-8?B?djhYeHlSaVBZa21HbXFoZHJyMCtNUmJMbjlseHhuOEJRN0w5aE1ka3RsTHZD?=
 =?utf-8?B?dG1WYUZObG9HRnZsdllGdjllclovMFZsWFVINzFIRTBhc2JPV01jYUlQbXRS?=
 =?utf-8?B?YndRcHZIdzhXTUdwdmR4SWRvdnJFeHRuenRCbTZ5OUwzM2RyanNHRHFGbnlz?=
 =?utf-8?B?VUJINjNUOXRITitmcmhubTJVVmVnVFpsRjlhVXc1ckpLT3hXeEdzZmpBSTEx?=
 =?utf-8?B?WHNTM1pWK2NDYW8yUFdyMC9yTzAzNkxWSExvR3A5amxtcnpXQ1ltNk5DT1FX?=
 =?utf-8?B?aTR6cDc5S2ZvOVBXWDE0cFM4N1lpdnltSFE1ZWR2SGN0aWs5MnppVWR0SzBy?=
 =?utf-8?B?YXJiaUpvcThkMi9wMjVwcnU0WS9SUnc2RFJMNXBlNkY4V01ZeTBreWpwNjBm?=
 =?utf-8?B?Z3MyZ3ZZazJORzM1dEUvTUJJVmVwUU11Um1MMG9yd3dLMXZxUkZwUUVONVpN?=
 =?utf-8?B?YnVQUG5PYmczeWRYa0pNNjhIamhKNGY5dDdUVTkxQnN3Tm1wL2pIWFhabUtJ?=
 =?utf-8?B?VFJZOWtIRlBSa0c3cFhuZmQvVVRzWmc5TG10RVU5VXhNOU1UOHdnQVpoWEFI?=
 =?utf-8?B?K1ppWWcvYWUzNkdtaEZzNEhwN21FUlQ0MUVOOUFNM0dkQjJIK1p5aFJXL2xQ?=
 =?utf-8?B?Nkl2SGovS21HTVFkR2crVnJLK3dwNy9mNjFuNm53TU5OL3o3VUhoU2ZENUhU?=
 =?utf-8?B?UlRWRFkxekxKb0xqeG9GV3VyYjV6bUd6ZHQwb0x4dXpKSll3S2NtMVdDbjg0?=
 =?utf-8?B?aXFhL1VFb2R4eVdvM0xnUTNSYkl5MnJpV0YvSzh6U3dKL21VK05RQ2FFN1ZE?=
 =?utf-8?B?aVpFMENVZXZSNXI4dW1nRkNkRGxHR21GWkhjVlZNRUpmaFdjRElidlpWTjFW?=
 =?utf-8?B?aUlOOGxVZFFyQ1o3blNLaVJEQ1hzOVlZU0pFdmMxeitDcHNRWVJ3Tk5rSUd4?=
 =?utf-8?B?TUVUcHNDYXRSOEJzS3lHMGNqU2lHQnRSQ0VLU09haHRoMEhUZm1mdVFrbUU3?=
 =?utf-8?B?cFpuTjNqdWhJeFFMSmFLWFoxM0d2QmdxTnhzRW82UklrY1BjenBlR0w5TDYw?=
 =?utf-8?B?NDZ1U3RoQTJRc0tSOUs0TGNaZTljL2JVODltR2ZmQWlGcmdpSlJVMExBcnEv?=
 =?utf-8?B?c3NMRUhBSFVod1lwS3pzOUhFMk0vbFA2ZXVFNU1TcStzY3ZwbkpsSzJmL0tz?=
 =?utf-8?B?N2VVVzY1QU9WT0t2Z2c0c0d4Sm1LQUloT2ptaytkYTZBM3NPMkFxWlR4WXVD?=
 =?utf-8?B?UGRpdDBndlhjaS8wOXdlSExGdVZmaXZZejFJR00vVEpmYkIvNlFQWVZ3dE4y?=
 =?utf-8?B?R1dLKzhETm01WDRaLzBtYXowVkN1alFsUDdaYThhTi96RlZhaElLaXhFOG9Q?=
 =?utf-8?B?V1NFVHVFQVVTZGN0c0R2ZWN3dk5JR0pCaEVldmx0bHM0VUgyVHJvUHhBYmdp?=
 =?utf-8?B?aXFtMWJpWHlmL3NnVEhQVldlVExQWHhWei91b3pFMVpmUnlMZ1pjWk5icHdT?=
 =?utf-8?B?RlJlZGZLRXdoWmJhTE5wdHpKeTZ5dUc0VzZwdUZVRVRqMW5rU0IxQTNSbW1L?=
 =?utf-8?Q?I/+naxvOfpk=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR12MB6760.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TGc3eFJZTWRHWXl0LzlHNU5DZEMrWk8vanBPbWhPQXQ2d1c3cTdMbWZJRmJE?=
 =?utf-8?B?eDIxS252TFdqUWkzVVRvbDYycE5adDNJV1JDbHRoeGdTOWdFSUR2ODNNODZM?=
 =?utf-8?B?VUxUenpPV0VnQ2kyMDNOTmE1Mmx6OEMzdzUzNW9EaGNHZW4wb3RQM2Z1TU5t?=
 =?utf-8?B?YnN5U0ppaWFIbHMwdjdpUVd0cmFLcVdTckMrRnNzMFc2dzNscllzdmZicHRk?=
 =?utf-8?B?cmpSSEMxZUl3VHkxa3BrRjVyNTlLQ0JQVDZkdkk5Y0huT2RxYUdsZlhXQlBS?=
 =?utf-8?B?TkRBUkcrOU1aT0gyNTF2b3BLMTFBeWwxMFFSaXM0VVh4cTdEWm41VDloSTlr?=
 =?utf-8?B?YXRDYmtFYmhraWMwYS9ENUlucndMcUN2VlFMSDVrTDA3dXRVYXk3OFpjL2xm?=
 =?utf-8?B?Q01qV2ZvWE9LMGY1U29BbWhZVHE2NGhIbjR4cE5nMHNWQlNPejJwaWhvM2pF?=
 =?utf-8?B?U3QzbjJsNUFzS2V4dE8zZk8zeXlWckUvaHVkc3N3KzRsN0w3RGpNT25iVk5G?=
 =?utf-8?B?MjJpZ2llR1ZzUzZlOWQrb0d1cWIwYk5uVFN0ejAwcjdNcE9NZkxPVStLOFRD?=
 =?utf-8?B?NmE3YTI4SHFmV3Q2UWRrU2ZNQi9yblg0MTB1NkIxcVRGcU5IbGhXSlV5eGQ3?=
 =?utf-8?B?K1NZN2pRTERoR2J6OWNmYXJCN2pFb1ZxQ2VPZlZSd0FEYVdlVXJzcFJkMTRL?=
 =?utf-8?B?ZGMrN0RtSkNGcjZDYkFUeUhlM1R1b2JoMXkzQVdMRm9CYlZJdE13OE5DTXlP?=
 =?utf-8?B?Sk5HZDFiUFJsQzZtZXdIblY5SnJERzBYWmpoRTE4dlZTNTBaUU1mOTZ5V2xO?=
 =?utf-8?B?S29CWmloMXFpeGk5NjhxWmxwcm9RSmF6dWoweU5JSDl3RkRqbEdpdUhUcVp0?=
 =?utf-8?B?ZGZWMlZ4RTA3OG16dmpHUXlmMzNxNTM1M1FEYUtYc0lQSDBYRFI3ZE50VXJI?=
 =?utf-8?B?S21WenFNdGtZT01IVVJpMUNKb21SY0Y3SjUxZzlIZjQwNmhBZklUbytIYVFN?=
 =?utf-8?B?RUY2WlBSczR5SWlGYWRmRWNjRGcxTWZ4SEFoS3I3QTBjYit1U0dYNDNaUzB5?=
 =?utf-8?B?SGlaankzMkV0Vy9mYUZNTlZpWmFuNzZETUtoRnREb3g3cXFreE9QZmhtV3NX?=
 =?utf-8?B?dXZuYUNvbElSRWxIN1RldWw2U1BZNVlaY1cwVVhuL0FJTENONWhRUEdpRm44?=
 =?utf-8?B?RFhiSFRnWkRsUGRqVkxISnNKbEt1YU5XQTRYN2gxWW1uZGluZHhxVWVPWkxw?=
 =?utf-8?B?a01yVGMxYWhIem83Ni9FMGZFczNiZVJFaVdMbi92RFBlRVA2UHIyN3llL0JQ?=
 =?utf-8?B?aDl0SS9qaXUrcmN2ZmhIRGFOQjh2SUtIWEhkN2E0YWNsTkNrUWcrVFczdmlh?=
 =?utf-8?B?SjZhUWppRFk0T25IdG00akRZQi9XY0owSFNWSUVFM3plbFR3QzhiYlRYTE5B?=
 =?utf-8?B?ZmJ4MFRmUHk5Mm5WVWMwMWNHdEFWbEdUaDJrRUVOQjQ0aS82SVNmR2pBbEE3?=
 =?utf-8?B?aDk0WDd3cTUyWU9DUGlJaTZ2clZxNFF1TEovcGh3UFl5c3RBV1E5d2I2MVBq?=
 =?utf-8?B?dWVMY2JUbW9IMWdBTGFCT1h5aGxEMElSZGpiS0h6Sk1zYnZwM3F4YUxGNEQ5?=
 =?utf-8?B?SStnRHA3cSt4ajVNMDRiWWNnc2J6cXljeVVBZVFqT2c1ejhvcjhCSTl0d25h?=
 =?utf-8?B?NlZ5N25LUlYwWnhWMEdiUzd2MGJ5a0hJY0VMMk42c0xlMTViSEhsNFJIbncx?=
 =?utf-8?B?ZFJmUkhTL0YxSjJULzlHdTMrWG9ZQUxSenBsbjk0eHRDdUdMOWYxdVY3Smkw?=
 =?utf-8?B?U0VpbVloeTlJbDBGWDMwOVdjMEdLbW1yM2RCRXhQN0orNzBySEhLdkhFcXhm?=
 =?utf-8?B?Q1BsVXdYNlhqa3BoQ01rSzdjc0Rab1BjeTdta01GN3JYMDVFLzk2VkZoci9y?=
 =?utf-8?B?VE5kRUZHNG95ZkQ5bDlUK2RXZjM5K1EyWTk5K25uamtNRDNCTXN6REdhUElZ?=
 =?utf-8?B?NjQvazdUeDBVZTVza01rRFU5bWlwdVZ1cWRSZTM4aWtrdUxYc2VLUHFkZDl6?=
 =?utf-8?B?MWJBbXIxMTZ4UG5zKy9HZkpHTWx4YURVNStMc3ZsQVcrV0diOUVhUnJQd3Vq?=
 =?utf-8?Q?9t8ca007sVVoGLNRpNKQqltPN?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 677fd89e-306f-4912-b672-08dd8e55628a
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB6760.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2025 17:25:53.6441 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QZuSymKyMgNN4o8SonIYFGzsX2OTwDbIKd4/3Loj1uBrmP8ww//1sFMDE0S2sk8S
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8853
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


On 2025-05-08 11:20, James Zhu wrote:
>
> On 2025-05-08 10:50, Christian König wrote:
>> On 5/8/25 16:46, James Zhu wrote:
>>> When XNACK on, hang or low performance is observed with some test 
>>> cases.
>>> The restoring page process has unexpected stuck during 
>>> evicting/restoring
>>> if some bo's flag has KFD_IOCTL_SVM_FLAG_GPU_ALWAYS_MAPPED setting:
>>> 1. when xnack on, retry pagefault will invoke restoring pages process
>>> 2. A. if there is enough VRAM space, simply migrating pages from ram 
>>> to vram
>>>     B. if there is no enough VRAM space left, searching resource LRU 
>>> list, and
>>>        scheduling a new eviction work queue to evict LRU bo from 
>>> vram to ram
>>>        first, then resume restoring pages process, or waiting for 
>>> eviction
>>>        timeout and try to schedule evicting next LRU bo
>>> 3. for case 2B, if bo has KFD_IOCTL_SVM_FLAG_GPU_ALWAYS_MAPPED setting,
>>>     queue eviction will be triggered.So restoring work queue will be 
>>> scheduled.
>>> 4. step 1, restoring pages process will hold one mm->mmap_lock's 
>>> read until
>>>     restoring pages is completed
>>>     step 2B, evictiion work queue process will hold one 
>>> mm->mmap_lock's read
>>>     until evicting bo is completed
>>>     step 3, restoring work queue process is trying to acquire one 
>>> mm->mmap_lock's
>>>     write after the above two mm->mmap_lock's read are released, and 
>>> in the
>>>     meantime which will block all following mm->mmap_lock's read 
>>> request.
>>> 5. in step 2, if the first eviction bo's size is big enough for step 1
>>>     restoring pages request, everything is fine. if not, which means 
>>> that the
>>>     mm->mmap_lock's read step 1 won't be release right the way. In 
>>> step 3, first
>>>     eviction bo's restoring work queue will compete for 
>>> mm->mmap_lock's write,
>>>     the second and following LRU bo's evictiion work queue will be 
>>> blocked by
>>>     tring to acquire mm->mmap_lock's read until timeout. All 
>>> restoring pages
>>>     process will be stuck here.
>>> Using down_write_trylock to replace mmap_write_lock will help not 
>>> block the
>>> second and following evictiion work queue process.
>>>
>>> Signed-off-by: James Zhu <James.Zhu@amd.com>
>>> ---
>>>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 6 +++++-
>>>   1 file changed, 5 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c 
>>> b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>>> index 72be6e152e88..5f6ed70559b7 100644
>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>>> @@ -1794,7 +1794,11 @@ svm_range_list_lock_and_flush_work(struct 
>>> svm_range_list *svms,
>>>   {
>>>   retry_flush_work:
>>>       flush_work(&svms->deferred_list_work);
>>> -    mmap_write_lock(mm);
>>> +        while (true) {
>>> +                if (down_write_trylock(&(mm->mmap_lock)))
>>> +                        break;
>>> +                schedule();
>>> +        }
>> Oh, stuff like that is usually an absolutely clear NAK from upstream.
>>
>> As far as I know that is not something we can do so easily.
>>
>> Would it be possible to wait for progress instead of calling 
>> schedule() here?
>
> [JZ]  At 1st beginning, I am thinking adding sync with restoring pages 
> done.
>
> but the original restoring work design philosophy is blindly scheduled 
> after certain delay.
>
> the changes with sync may take more time and risk. I would like Felix 
> and Philip give comments
>
> if there is efficient and safe way to fix it. Thanks!
[JZ] BTW, in worse case, mmap_write_lock will fall into 
rwsem_down_write_slowpath(), schedule_preempt_disabled() and schedule();

>
>>
>> Regards,
>> Christian.
>>
>>>         if (list_empty(&svms->deferred_range_list))
>>>           return;
