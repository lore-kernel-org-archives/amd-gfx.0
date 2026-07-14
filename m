Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0343AC44508
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jul 2026 14:17:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9990110ED73;
	Tue, 14 Jul 2026 14:17:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="q36m9RE1";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012006.outbound.protection.outlook.com
 [40.107.200.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AC78F10ED73
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Jul 2026 14:17:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I6zkLPLPHsMCx6EKbdvxU0XTvZkIk/wTV3v3QPKEg6vlmZwtY0Rcs855RRlqW0/cTk/+IUeBTxVRcJ5KtHfTDzh9n6Lk47dvzZH3jJtcFtG8EfRaOqPeUqQdeJfHu0LQsiEyknReGXpMrp+mNLLoInll94clx7CB+eYJI0IzI+wp+1buEhuWt0yqcoaB91zzJ5RR1uhRkIx9BKk1CJm7RzCdZU4aWAhW5tYTtgamjvINelgaYrsel4LWAjIsNnQ36Dq/d2XTRDBfn9KcbYIwvZCLoHqCLq4Tp1HszhoZi7/Whomnf8pyzbZG1DlB8j//tnlo4Vpu1QOrL8kY7DM1BA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cu8KetnXXNzXZLs7ShJw+F2AGpaTke91jvWe0PRg6c8=;
 b=elhFb35cbszIm3la4cfndLkFmbIFY2Qu4hUFmjKT2kq82HRhGlIHDV0CRWcTwXe7Gxn8Pfoxzz9CRviYJ+bM166q0xB5vIedpNmrSqqT5LFYEJvxMx+13jgVgJrksYPSwR5C+lX1Ux3X/1xvRIuKB+S+4LGhSPKZbDZd9ydXGlEPikRvGYLU6QFnI5HrIdABcE+38P2PtDDL87F+VJMVk4QfF/agi6H82CmRJURlcyRy0jfeREZVyU5ttr89yGq4fLNDnorhHJmcPO8Eos4qjr0Uh0tTvLGoHftI1zZNgP7XfezZCXnSZosBhaQZYPmZEjhR6cxL6Yp3WwnIAY/N9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cu8KetnXXNzXZLs7ShJw+F2AGpaTke91jvWe0PRg6c8=;
 b=q36m9RE1BZdwEuPK/Fd/jiFe/3F6Cl3qrY7oS1ymTU0L5oumESUU/30SgMLXvBCzo0OzIVMPhGViWoBXGdBTtvQsvoTrW2VA7s4HKOH0B5cGjpMscsIkF30blILS7CCHGvjG76WQSmkUmc+9Ubi407EfpboF+Oj0VdxHymgEL0Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by CH3PR12MB9454.namprd12.prod.outlook.com (2603:10b6:610:1c7::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.10; Tue, 14 Jul
 2026 14:17:16 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc%6]) with mapi id 15.21.0202.014; Tue, 14 Jul 2026
 14:17:14 +0000
Message-ID: <679f24a8-e4bc-4613-b535-1d0243f50530@amd.com>
Date: Tue, 14 Jul 2026 19:47:09 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu/userq: properly account for resets
To: amd-gfx@lists.freedesktop.org
References: <20260713203850.650426-1-alexander.deucher@amd.com>
 <IA0PR12MB820888C41AF05BAA5C2CA57090F92@IA0PR12MB8208.namprd12.prod.outlook.com>
 <3656074a-1a01-49f6-8f7c-129ab379f129@amd.com>
 <IA0PR12MB8208F00938342B8FD8377E0090F92@IA0PR12MB8208.namprd12.prod.outlook.com>
 <9d575350-c3a2-4e9c-b842-b2a68678914e@amd.com>
 <IA0PR12MB8208EB469D4C2403243D321C90F92@IA0PR12MB8208.namprd12.prod.outlook.com>
 <CADnq5_PbxvfpjCDQKyeySp1fipA12YduN2t7XzgE7iacc1v-Rg@mail.gmail.com>
 <decc51ae-83fd-48f7-9a31-7aa02e2d0e3f@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <decc51ae-83fd-48f7-9a31-7aa02e2d0e3f@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA1PR01CA0184.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:d::13) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|CH3PR12MB9454:EE_
X-MS-Office365-Filtering-Correlation-Id: 7010f915-d648-46f8-d638-08dee1b29a5e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|6133799003|4143699003|18002099003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: vmHDhmfCi5Pe4oLXumnw4x/N4IWqttRgM6u7t/Vbx+Q9x+Gf8xrkzQgeUDFfsosRKa0pLH742vNYmIzKQbkUqQ9iHC0rMyCFskg6tNXie1G1YFclhUS0FHPGHswhx6jJ9MVN0pRKj4Qj2zPDxAdUcILwcKrWIELQsZc3PIErk4p/2iSg1NaZlG/Gsy3VyARYLJXq9rPxbK2DLEhEjDH3P+aWc/GfcxY2dLIJUyhtjs1qUGWy+BzzS/w+8CZR0aRduXVHgCLqOX8W82DJ+Xw6W6M0xk32L5X+lDuQ9lVAeeBQ5cN48J4cbe8qIxD3DJKE8rU4GK+vDkr4ZzMFhLIY+7LK+/HkSzZ+rACVYui+W0A61PYFNi1KVa8CqcOOmTfP9vlIcH1SZ9Dp8K9xQrTgl6NGF0wXHGmyTXSe0bRGzQ2hB06Wyv92KhUV+Tzc+oIdiZ2gBA08iGm0DP9/TYnS6iamW1ZbSFOKbvoJ8L7LoFoAU9KKTSclNCJU7PFj4AkHl9xCpqWV8o86H/NyqDawtGlQHx1A0ZehehyG2L0wrg3G65mcWvKaL+rcjL4Ap5i7PpOPrmOVlpwTEdVve3x8npXvZQ5QJVII3DVQKJYMbD8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(6133799003)(4143699003)(18002099003)(22082099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cmNZMVBmaU5WUWQvMGlHQy9WVHZZTFRPRUJzWVdQMzBVb0hsQTNpZTBuVTN5?=
 =?utf-8?B?UWFrSXdjcHJ5Z09vYS9rZnFBOGRPbWVmbmZLMnpPQVY2SitqU2p1QU15L21j?=
 =?utf-8?B?SDhWb3hQaWtsTlpmaXMwaml3UHFsUm90ZnRCWXluVEd6OHgvamhtUEU4cGZs?=
 =?utf-8?B?VXZwbWF2Zlh1ZWpCSHZCaFV6RzgvNk9pVGFiYnhGckdqeWFDa2V1cUVraEp3?=
 =?utf-8?B?RFlMYlpNTloxSUtEUTcxVUNYV1ZHK2hqQ2VGUzIyRU1EelZjN08xbGI1Z0Nj?=
 =?utf-8?B?QTFSSXpnbEk4UUNxZnpZckcxc2Z5bUdhOStPWTB0bTVGRktyNXFsKzFxR3d5?=
 =?utf-8?B?aXZUdjk0b2hybDR1bmlRWkEra25CZFFPUGdPQVBLcWNrS3FxQUdQTFJVK0l2?=
 =?utf-8?B?QnJaK0pSZW1yT3hGQytaWnludGw3QitSZ1ZyeExpVXY5YkEzSEhYYi9hRlFr?=
 =?utf-8?B?ajhrM2Jhb3JjNVN0Tk9kb2poUEtFaUFjdmdSS1RFVkFIYW1UWGVKZFNBS3lz?=
 =?utf-8?B?Nmg4TW5qN25FVmZJR3RyWENhc3c1K1RxSEhlbGlTK3JsbkxmUUhFTlFZS1Vy?=
 =?utf-8?B?ekhHOWFGUUVucVk3cndPdUxMSW5vR3FCdElIdDBpRHNBRU93bnJvK0FUNHZl?=
 =?utf-8?B?ZDVLWFhUOGsvT3hiaVdhSm0zYkdyWGFuQkJlbG9SQThmMDdlZi9lZllhWFJM?=
 =?utf-8?B?UytQRXRETjloWm9KaFZza1ZsSEsxMWhNS1BWUjlJV0p6bk5vem1pQnNIU3Za?=
 =?utf-8?B?eWNjWXdnalUxTzZZVWEvOUZWUWRBdUw0V2Y2OUt3dGp1SmRUSGpmK2NrTzhT?=
 =?utf-8?B?ZS8vL3NBUEtvSkJHTVJDWElWdTJtWDhiKzF5cy9QVlRkSENKNTAvNFZUUVhB?=
 =?utf-8?B?NzdWZU9rbEZMRUV3Q3FBaitYVXB0Zlh0TzBYdUJGbk1UYlErbkRKSUVQZ0s0?=
 =?utf-8?B?dHAvWUFZcmRoQ0pYV2Y1UFBwYll2dmJlay9iUDlQaHQ5MXRKWUU3RHN4N05Y?=
 =?utf-8?B?MzdzNFd6UCsybGZ3dVBnajBLejY5TFRwVnoySWlYUEt4UmMzaHdxVmU0SGFr?=
 =?utf-8?B?cmdVcENQZ1Q1MDBXTERpb3AxMGVocjVBZEFFd0JIN0trYXpEdHlEak9Lemdj?=
 =?utf-8?B?WGx1N2xPM2FZejViOHppYkpmOFZwbkhQcEo0R2t5ajhDQ0V1Q09DMzQ0SmlX?=
 =?utf-8?B?SnphOVV3RnRhN0xBQ2NDQmtxN1JVOXJ6OGJsSktSclRsZFhHREFxOFYrYlhq?=
 =?utf-8?B?LzhpMFozcG1hMFRyUGJBVHNHYUFoU0c5ejQxQ3NjUURmSGFFNGRSU2loYzVE?=
 =?utf-8?B?djQ4SDFGb2lIa1lGcDdrK2krcEo3WnA3VUdaQzRiVUhVcXV4bTdDczUyVERK?=
 =?utf-8?B?M1ZMUHp0cmkrYlZZOTlsdjJwa2ltWUI4THRoakduYnRvc20rZktnV2lDNXpK?=
 =?utf-8?B?K2ZrOHBDT3doaElOOE9BWmRJSllLN01EYUt2UE9RdjFRWHIwclJ3RjNoSkNp?=
 =?utf-8?B?OTN5WUU4SjhOUVNYS2ZZZnRLSlk5S2FaYUVsQUozdWo5emtTaTdqdVdxTGNj?=
 =?utf-8?B?ZTZlU0hmOHVpbWN5R3cvTkhXdm9US1RWRjRUWXpGNjdtcjliekFuZGhCYmY4?=
 =?utf-8?B?SmIvK1JQTGd5eXZReW0wV1hQUmtjNzF3Tk5zN25JYWFacjVPNUQ2cmhKbndY?=
 =?utf-8?B?Tjkrd1Z2VzZSR1lNZ3FJQzgycDg3bnpZcTcwdkxKYWFZRGpxZnR4a1hZQWl0?=
 =?utf-8?B?VTM3bmpQRStOcHlZTHlIV2sveEJ5Rk96anBZWjQxTnRYWm1NUTR6N0tQZi9M?=
 =?utf-8?B?SENGeUhhMXZucCtCa2xxTmRxeVpDaHRaOTh0SisvQzQ1aTVpQVpLNWtvVFBJ?=
 =?utf-8?B?RHUvTEp0Smk5SWF3VmVRMk1QdkNqVTJmeWFFcnU1eno0YXdhUkRnRjBDUmJ4?=
 =?utf-8?B?Q3YwVTB6TDI4T1RMcW1ucm9UY1lTYjFzSklISmpIMytKNk1nWEpUSWMzbm9l?=
 =?utf-8?B?alhmYVMyRms2QWZmYVBVOGd1NTFjWlBWUjUwZmhDSW1GMUh1ZkhYdytqcGU2?=
 =?utf-8?B?dVhSOUw0dG5WYW9HdEE1Vnk5Y1NoR0FGaWsya2dMeVl0RHFldTQ1ZzZiRDFm?=
 =?utf-8?B?SCtpZWU2MS91SVNzdjExaHJ3TCtQQ1ZwTUp3Qk1IM0JPMW9EOXkyTFQ1b0x3?=
 =?utf-8?B?L1ZYU0VxQjBXbVJ2R2hVZ08waWtSRnJydkZObjlJSGEzTi9lUHpzNnBFaVov?=
 =?utf-8?B?eTA3RnpwcjJrK3I3OHBGRFcwSGxtMmorcVU5MmhmdWFGWldXR3lvdkJ2alZS?=
 =?utf-8?Q?4kwZ2Rjx+dcchwihcs?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7010f915-d648-46f8-d638-08dee1b29a5e
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2026 14:17:14.5073 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 07v2WrN4a2821vDOGpF6F89wMwfdG+Zw4zIGjh+hyBSZhdshv2NES7Pro6d1cxpT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9454
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



On 14-Jul-26 7:44 PM, Lazar, Lijo wrote:
> 
> 
> On 14-Jul-26 7:25 PM, Alex Deucher wrote:
>> On Tue, Jul 14, 2026 at 9:49 AM SHANMUGAM, SRINIVASAN
>> <SRINIVASAN.SHANMUGAM@amd.com> wrote:
>>>
>>> AMD General
>>>
>>>> -----Original Message-----
>>>> From: Lazar, Lijo <Lijo.Lazar@amd.com>
>>>> Sent: Tuesday, July 14, 2026 4:02 PM
>>>> To: SHANMUGAM, SRINIVASAN <SRINIVASAN.SHANMUGAM@amd.com>;
>>>> Deucher, Alexander <Alexander.Deucher@amd.com>; amd-
>>>> gfx@lists.freedesktop.org
>>>> Cc: Liang, Prike <Prike.Liang@amd.com>; Khatri, Sunil 
>>>> <Sunil.Khatri@amd.com>
>>>> Subject: Re: [PATCH] drm/amdgpu/userq: properly account for resets
>>>>
>>>>
>>>>
>>>> On 14-Jul-26 3:57 PM, SHANMUGAM, SRINIVASAN wrote:
>>>>> AMD General
>>>>>
>>>>>
>>>>>
>>>>>
>>>>> Get Outlook for Android <https://aka.ms/AAb9ysg>
>>>>>
>>>>> ----------------------------------------------------------------------
>>>>> -- 
>>>>> *From:* Lazar, Lijo <Lijo.Lazar@amd.com>
>>>>> *Sent:* Tuesday, July 14, 2026 3:14:34 PM
>>>>> *To:* SHANMUGAM, SRINIVASAN <SRINIVASAN.SHANMUGAM@amd.com>;
>>>> Deucher,
>>>>> Alexander <Alexander.Deucher@amd.com>; amd-gfx@lists.freedesktop.org
>>>>> <amd-gfx@lists.freedesktop.org>
>>>>> *Cc:* Liang, Prike <Prike.Liang@amd.com>; Khatri, Sunil
>>>>> <Sunil.Khatri@amd.com>
>>>>> *Subject:* Re: [PATCH] drm/amdgpu/userq: properly account for resets
>>>>>
>>>>>
>>>>>
>>>>> On 14-Jul-26 10:16 AM, SHANMUGAM, SRINIVASAN wrote:
>>>>>   > AMD General
>>>>>   >
>>>>>   >> -----Original Message-----
>>>>>   >> From: Alex Deucher <alexander.deucher@amd.com>  >> Sent: Tuesday,
>>>>> July 14, 2026 2:09 AM  >> To: amd-gfx@lists.freedesktop.org  >> Cc:
>>>>> Deucher, Alexander <Alexander.Deucher@amd.com>; SHANMUGAM,  >>
>>>>> SRINIVASAN <SRINIVASAN.SHANMUGAM@amd.com>; Liang, Prike  >>
>>>>> <Prike.Liang@amd.com>; Khatri, Sunil <Sunil.Khatri@amd.com>  >>
>>>>> Subject: [PATCH] drm/amdgpu/userq: properly account for resets  >>  >>
>>>>> We need to increment the reset counter, force fence completion, and
>>>>> set the  >> wedged event when a user queue is reset.
>>>>>   >>
>>>>>   >> mes_userq_reset_queue() handles this for collateral damage, but
>>>>> the caller needs  >> to handle this directly for the original guilty
>>>>> queue.
>>>>>   >>
>>>>>   >> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>  >> Cc:
>>>>> Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>  >> Cc: Prike
>>>>> Liang <Prike.Liang@amd.com>  >> Cc: Sunil Khatri
>>>>> <sunil.khatri@amd.com>  >> ---  >>
>>>>> drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 7 ++++++-  >>   1 file
>>>>> changed, 6 insertions(+), 1 deletion(-)  >>  >> diff --git
>>>>> a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>>>>>   >> b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>>>>>   >> index 6aa75da27f912..5e1262636e1e9 100644  >> ---
>>>>> a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>>>>>   >> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>>>>>   >> @@ -146,8 +146,13 @@ static void
>>>>> amdgpu_userq_hang_detect_work(struct
>>>>>   >> work_struct *work)
>>>>>   >>                                                         queue,
>>>>> NULL, NULL);  >>                else  >>                        r =
>>>>> userq_funcs->reset(queue);  >> -             if (r)  >> +
>>>>> if (r) {  >>                        gpu_reset = true;  >> +
>>>>> } else {  >> +
>>>>> atomic_inc(&adev->gpu_reset_counter);
>>>>>   >> +
>>>>> amdgpu_userq_fence_driver_force_completion(queue);
>>>>>   >> +                     drm_dev_wedged_event(adev_to_drm(adev),
>>>>>   >> DRM_WEDGE_RECOVERY_NONE, NULL);
>>>>>   >> +             }
>>>>>   >>        } else {
>>>>>   >>                gpu_reset = true;
>>>>>   >>        }
>>>>>   >
>>>>>   > After the original queue was reset successfully, it did not update
>>>>> gpu_reset_counter, complete its pending fences, or send the wedged 
>>>>> event.
>>>>>   > mes_userq_reset_queue() already updates gpu_reset_counter,
>>>>> completes the pending fences, and sends the wedged event for the other
>>>>> affected queues,  > but skips the original queue because it has
>>>>> already been reset.
>>>>>
>>>>> What is the rationale of sending multiple device wedged events on a
>>>>> per queue basis?
>>>>>
>>>>> The question of whether drm_dev_wedged_event() should be emitted once
>>>>> per queue or once per overall recovery seems like a broader design
>>>>> discussion.
>>>>>
>>>>
>>>> Along with that, also need to consider if device reset_counter needs 
>>>> to be
>>>> incremented on a per queue basis or based on reset event recovery. 
>>>> It could get
>>>> incremented multiple times inside this - mes_userq_reset_queue.
>>>
>>> Looking at the current flow, both gpu_reset_counter and 
>>> drm_dev_wedged_event() are updated once for each successfully reset 
>>> queue. It would be helpful to clarify whether they are intended to be 
>>> updated per affected queue or once per overall recovery.
>>>
>>
>> What are the semantics around the reset counter and wedged events?
>> Presumably each should be incremented for each queue that is reset? If
>> a hang affects multiple queues shouldn't each be a separate "reset"?
>> In the most common case, there should just be one since queue reset
>> should be able to reset just the guilty queue.
>>
> 
> Device wedged event is a udev event. It's not good to send  multiple 
> events when multiple queues are recovered as part of single recovery 
> process. Otherwise userspace monitoring the device will see back to back 
> events. There is no context associated so it doesn't have any clue of 
> what sort of reset happened.
> 
> I think the same goes with device. I believe it's to indicate a recovery 
> event associated with device and not as a per queue event.
> 

"I think the same goes with device" = device reset counter

Thanks,
Lijo

> Thanks,
> Lijo
> 
>> Alex
>>
>>> Thanks,
>>> Srini
>>>
>>>>
>>>> Thanks,
>>>> Lijo
>>>>
>>>>> Thanks,
>>>>> Srini
>>>>>
>>>>>
>>>>>
>>>
> 

