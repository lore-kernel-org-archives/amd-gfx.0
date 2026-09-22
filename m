Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C91F8C982F1
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Sep 2026 02:04:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3972810E417;
	Tue, 22 Sep 2026 02:04:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mwh/2Hk0";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012039.outbound.protection.outlook.com
 [40.107.200.39])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A16D210E417
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Sep 2026 02:04:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EqcZqezo1E7V9aSJJJVVjqbRliNEG5VDvbn9X8zAFTxNTyDBBzS3qVHiZEgLyIPC7juK++b3bh4D5J5fV0PWyu+y7ISN+8n/FQ0LqKJ3sKmTbbrvkd1qayzdOuG6qTAgstnLJ1A7ad2GWGtuGPRUSstw/NuLdk1V5+bHai6Vzgwo2bbjhPjw6Mf4qfnkRb2iH7doTsOSNrWzypmU9jPXtEaTLPjrzmhzoQoyeSgXjSYTMm0iuDRVjf8+XqW1uvhDVEkhx37FrEYnzSCd+i7cT0VmPJWe2se8gNVbpFDE0JIlr/5rEzizq5AEJJTGhOY0aJDwy7HmI4m5QONjfqOGlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RsG1BknS3D7xEIfv618t5I9i7+QI3+i2nNRSXhm6w6Q=;
 b=uQhaqaNBGN8/XO/ECREigNvnrHcn69VgD52ZGdLpZugeAPUPtvYE7HMHpBCnKZWDe0ZET0MG4trj5cbvit+kWl/eE6H/cDUY0bij9ReUY9NlRsdy+v5WXtS0RIxyo4nQuP9BzvuoOUqlW/ha9pxu5rHAgMirxusMTPDXhwpGQv77lIXUDdRJSYaIVUC+oxNM+utmRhyUXQT9xYrHnOa+ZSzJJfca0yTa77dllRGpHDzTIiyFb9VC7x3c5LMxGP3jcybsJTIgIOvoVhwhJyOLgaj7B0Cex6PwsAnKJgicDqOVi1KAR0dri0+Y555zGiaf9E7NbxENNyQWx3nzRzDafA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RsG1BknS3D7xEIfv618t5I9i7+QI3+i2nNRSXhm6w6Q=;
 b=mwh/2Hk0hjQG5yB0FN/hke6PLQpk2ZVLPvzX/zWLzUG/5bWMyNg80QEdzjI49yTXfZ4vuOUrjsD4OYpcrkiqTjgIZWGVSqn8t7K8gL6wbKB7KiHS8v3VNObiuvP+l2XBNWmR2/1K9LXP+X6L0xF+1+XiXatN//3ojI3P8uf7ee0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH2PR12MB9457.namprd12.prod.outlook.com (2603:10b6:610:27c::7)
 by DM3PR12MB9389.namprd12.prod.outlook.com (2603:10b6:0:46::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.16; Tue, 22 Sep 2026 02:04:42 +0000
Received: from CH2PR12MB9457.namprd12.prod.outlook.com
 ([fe80::85a8:1df:840a:cd4c]) by CH2PR12MB9457.namprd12.prod.outlook.com
 ([fe80::85a8:1df:840a:cd4c%4]) with mapi id 15.21.0428.015; Tue, 22 Sep 2026
 02:04:42 +0000
Content-Type: multipart/alternative;
 boundary="------------p6gm3Jplpm5e21voQYOW4LZ4"
Message-ID: <ae9377aa-d381-4f21-97f6-03f6ed09d4fc@amd.com>
Date: Tue, 22 Sep 2026 10:04:36 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND 00/10] drm/amdgpu: secure userq lifecycle by its
 kref
From: "Zhu, Lingshan" <lingshan.zhu@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Kuehling, Felix" <Felix.Kuehling@amd.com>
Cc: "Huang, Ray" <Ray.Huang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20260914130724.130794-1-lingshan.zhu@amd.com>
 <CH2PR12MB945710EE0E52DC2498C528C28CBA2@CH2PR12MB9457.namprd12.prod.outlook.com>
 <BN9PR12MB51464E162658C6DC2425638AF7BA2@BN9PR12MB5146.namprd12.prod.outlook.com>
 <443c6d8c-107e-4eaf-b81d-d6df2733b5a2@amd.com>
Content-Language: en-US
In-Reply-To: <443c6d8c-107e-4eaf-b81d-d6df2733b5a2@amd.com>
X-ClientProxiedBy: SEWP216CA0009.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2b4::19) To CH2PR12MB9457.namprd12.prod.outlook.com
 (2603:10b6:610:27c::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB9457:EE_|DM3PR12MB9389:EE_
X-MS-Office365-Filtering-Correlation-Id: b308e924-003e-45af-6fe0-08df184ddd93
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|23010399003|13003099007|5023799004|6133799003|10067099003|4143699003|56012099006|8096899003|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: x1bEeM8Dvfl3XPNGGyYbTO4GkelSavjE1E8Kifx3bjyYTKTqUb3/+gk8mhPrnLx4n9N7/dXk8SmNGpdaq7ragIMeGH0OsrO21CTXxGakxLsys7WAPL/26NjYFM1qISMIeAkDSYG7ZEKQSr5eZWovXZw0NaOorz/GYKQ+A2JW8Y6Ta8SltFy6jO1l13Tf4ksDXFVZh8imMG1q2vlNF8T1Hx2sBj+pWBydEekx2S+EMqbIAAURZvzrzeaG3OsrCwIEzCcXBXjE2uIdeerJxOJD/IJL5AZ1Q2DLjuoO6lY3HF/U5N/9hrHrXg3u8wYk1XPBQ95ffKGceGTCe5zqezhr7mYraLJP1CNnTkI6Pi1vKLw82AkVr1fB4ry/G4OlKPJGK5ykHGlUiY3Tit9P5m80zl8Y1xRIjNRhzkB8nu7mjkf6I1ta+5gaatIMBCXZ15Ej0Rwp0TyPHKWPTxWHj+dHUXUsOI4k2S0WoQjxeYnDIqCsyvTbBuRItqR7nycdR8mDC1Td10OLOki+F6U4KpzFIuOA7gkqnSeBhTLr2URIFO6F7NQdwn0RWzYkq+2/2iK5F/FUvMZQb/Q4hyjGMkeZLTjo5lzXqmuR9TpKZFFP1qtV1hNRJw5MAqBvct9lE/S8
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB9457.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(13003099007)(5023799004)(6133799003)(10067099003)(4143699003)(56012099006)(8096899003)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?emVkcnBpYjdreDNWK1ZUK05Tc0lmUlRtTm9aVXBtdFlpV0V6UXhkWDF4WXpa?=
 =?utf-8?B?UXpjeVFNdVZPWm1MTmZ5TC8yNjdyNTdRNndMUmNMMVFrdzFiSG1LaEZxRk1N?=
 =?utf-8?B?K2RzTTZqSE5mZ1JYeFNzSVFmNkdRN3B2Y3BHNTRGWFc5T2pRVk1xdHduWWVT?=
 =?utf-8?B?L2ZJZHRmZ2x6MFRtQWFWOWZTaVJwN3dTdC9nQ25hME9pMm0zNzZ6dlVtOEtC?=
 =?utf-8?B?eThTaXNZTEZtUUlEVExzTXFjY0g5VUI2UlgvdjhkSUdrbVZnYkJ2SEN1N29T?=
 =?utf-8?B?TFlSaXVSeVd5Mk9kYVkvWGJLR3lhZS9VcllTdldLS1YyZ0pzUU50NDN6YTl6?=
 =?utf-8?B?Z2FnOXlXcGxYUTFudHlXTy9sSTdEcG0xdlgrNWhVbExlQmZ5M0RzNnl5VTh5?=
 =?utf-8?B?WUxXc1ZQR3JITFNNd25aczFtTHhJODduSllOdVBkd1BRSVJNWWNJd0NiNjlM?=
 =?utf-8?B?Z0hzU1NRSlByVUs3NlRrQWtaK2I3b3hKT28vcHQ3QTNsc0RsdDgzUzVLNVh6?=
 =?utf-8?B?UFdIcVdESThGRE1ZRlcvb0gyTFBsVjZEeXlpUjZpVEFPaWVhbCswZmNUQlBT?=
 =?utf-8?B?OEg3MHYwcG44Wkt5Nk9ZLzdGaW44QzZrSW9CYUYyWld3VDVOaXJZSFlsYUQ1?=
 =?utf-8?B?cGgrTWNFTllMRWpVem85MDFWSDJ5Wk9KeERoTG1GZU1RQ1U3WmRtRFgzUkRy?=
 =?utf-8?B?MUZFNHc4UVh1bWZjVmhHNld1V3BsaFF0eVVzWWhseVA1dlo4NFBEY0FwWXhp?=
 =?utf-8?B?NHEzUzFmblFiYUFObGFLSnB1TC9iL1ZaajQ0SFo4b25QOGhEa3pvWmp0WnJw?=
 =?utf-8?B?bjRWOWdOdlVXdUdaeENCZ0N2Y0ppY2I3a3FLSEVPK0N2L0p3QmlqOS9TSGpo?=
 =?utf-8?B?a1VGblQyUTBMdlZ0VXg5Q2dDSk1TZkJJbUhoRWFwMlVDd3FzVGJPYjQ3VVFF?=
 =?utf-8?B?U25rTEo2ZE50N1ZWUVdCdkZHREczT0lUdFFzU3VZc3NlZzZKc2p1c3JDZUUz?=
 =?utf-8?B?aGhCN01wdGhGM3FyQXI3c2ZjRzQwL0VHYzAwK3c1SjJGQjVJNndTWTgxU1lB?=
 =?utf-8?B?NVVDTEhhMm1PWHRmZ0djaXZKUkFyaHNFZFpmMUF6NmlNNTBISUViTk9wejVJ?=
 =?utf-8?B?L0YwQnZWQTNMWlI3OFBPTUw2SG13L0hHYVZjWlJnQnZMeVUzSWwyRk1XSXZ4?=
 =?utf-8?B?bGdWMXdwZEkxaklTMXo0QjhNeHNZRUVDbTlGYWlHSlo1VHA4SXo3eE5pNmpL?=
 =?utf-8?B?ay94RGE0aVhzSCtKOTV0NG5wVUxGLzJaNi9YbmJEcWIxdFZQaEovWFZCSWds?=
 =?utf-8?B?MTF0Ukk2UVBvblBrYXBzUUtkN1ozRzZ4MHVpVURJM3NIOVhuVUhHTXhmNGpj?=
 =?utf-8?B?VDlCQjBEdHdINzN6NjhYUXY1T0JTZGt1MG92VysyY3pPSmRybldkWTI3TGdY?=
 =?utf-8?B?R3d0SlZreVJYdzJ3dTh4VGhMWS9JRTJSamFkcHFidDRyOVNUek5IRVpPakVy?=
 =?utf-8?B?NkQwUUt0NEtSL25DZ0FiWkxhdFROcnRNZTlabjlxSTBXSlRUaHpsQytBUGJG?=
 =?utf-8?B?ZHREelNMb01FUmQ3UnFGdUI3cExhemlTeXZodlgyaWxFTVZvSE9IRkppYXZK?=
 =?utf-8?B?QnN4WnlBMFkza1hld2dsandraklkdVI2bWRvdkpQU2JsZGxLSWlMTFdCYlcy?=
 =?utf-8?B?aWM5WDVaS1k2Q1JrQTYxOGs2bzZLTTcxTDlZZ2IrVlRLbDMyTW5BaERXbXNx?=
 =?utf-8?B?QXE2dkJERUYvN2ZDZzh2WGJ4Q3dEYXFlYU9sZ3ZsMkRGT0dIOEZKVTQ4L2Qx?=
 =?utf-8?B?OTBTclZnYUZNNng5V28rZDV6dVBQV21LTmdmNWFzWXhVV0ZlZ0pXbEFFOXVN?=
 =?utf-8?B?K1g5NDNmUTY3QTc0S1pZQmJ6MVZoTEZSWE5YWExjTjNUT0psY3JvNTY0akdr?=
 =?utf-8?B?MGJ2dk5VTXZVRlZodkJyVms5cW9zOForVHVtOG1LdndHclZGdWY3alJlN2hK?=
 =?utf-8?B?Y1E5dFpLRDZ2cUxXbTdEdjlOWEZQR3V1ZjhLM2Noa1ZDSk1lSDR3NzBZd3ZF?=
 =?utf-8?B?NFZZMUsxdVE0SEpZbFhUNm1IMHNuY1pLVDdSYnh0OWtnZE5MV0VpTGwvYTdn?=
 =?utf-8?B?S3ZPUml3VEpuYk1ROFdONnREMFdacm90THdBSUJRZmFRNmxGNjlvaytrR1RV?=
 =?utf-8?B?cERlWC9pSDFucjZMV1JCMEtZRDcwV1hPTkhLdzdVb0g2QS8yZUdFUmo2ZjJK?=
 =?utf-8?B?U1FWQ3J5MDBHNVhPdFFsWHBYL3ZyS0lQTXFXZmhWazlpTUpBM0hjdS9rQW1Y?=
 =?utf-8?B?YUlwWk1Vb1dBeVJYeWxPdXp6Z1dibE1YYXZ5c0VQSzczMVBuRW5XZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b308e924-003e-45af-6fe0-08df184ddd93
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB9457.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2026 02:04:42.1330 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bWtTB8f2ekTnXcC+IWRSUI/OJf7Xa4GZYCKbZf9CcHyxjikQDBMs/FG+wRPAGiizHmkizwmFY03+Oe8Ewh0KLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9389
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

--------------p6gm3Jplpm5e21voQYOW4LZ4
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Gentle Ping Alex

On 9/18/2026 6:01 PM, Zhu, Lingshan wrote:

> On 9/16/2026 6:18 AM, Deucher, Alexander wrote:
>
>> AMD General
>>
>>> -----Original Message-----
>>> From: Zhu, Lingshan <Lingshan.Zhu@amd.com>
>>> Sent: Monday, September 14, 2026 9:55 PM
>>> To: Deucher, Alexander <Alexander.Deucher@amd.com>; Kuehling, Felix
>>> <Felix.Kuehling@amd.com>
>>> Cc: Huang, Ray <Ray.Huang@amd.com>; amd-gfx@lists.freedesktop.org
>>> Subject: RE: [PATCH RESEND 00/10] drm/amdgpu: secure userq lifecycle by its
>>> kref
>>>
>>> AMD General
>>>
>>> Gentle Ping Alex
>> It doesn't look like Christian's concerns were addressed.
> Hello Alex,
>
> I didn't hear back from Christian for almost two weeks, hope I did not miss any emails
>
> This series tries to fix a common use-after-free issues for user queue.
>
> The user queues are destroyed when its kref get to zero. So any code paths that work on a user queue has to
> take a kref of the queue to make sure the queue is alive during its operation.
>
> However there are several critical functions does not take a kref of a queue when operate on it,
> for example mes_userq_reset_queue(patch 6) and gfx_v11_0_userq_priv_fault_work(patch 3).
>
> There could be use-after-free bugs if the user space invokes AMDGPU_USERQ_OP_FREE, or close the drm file,
> or the user space program unexpectedly crashes/exits when kernel processing the user queue without holding a kref.
>
> This series tries to fix these problems, and this series is a dependency of the PMC work.
>
> Please help Review
>
> Thanks
> Lingshan
>
>> Alex
>>
>>> -----Original Message-----
>>> From: Zhu, Lingshan <Lingshan.Zhu@amd.com>
>>> Sent: Monday, September 14, 2026 9:07 PM
>>> To: Deucher, Alexander <Alexander.Deucher@amd.com>; Kuehling, Felix
>>> <Felix.Kuehling@amd.com>
>>> Cc: Huang, Ray <Ray.Huang@amd.com>; amd-gfx@lists.freedesktop.org; Zhu,
>>> Lingshan <Lingshan.Zhu@amd.com>
>>> Subject: [PATCH RESEND 00/10] drm/amdgpu: secure userq lifecycle by its
>>> kref
>>>
>>> A struct kref is embedded in user queue, which manages the lifecycle of a user
>>> queue. However, several code paths access user queues without hoding the
>>> kref of a user queue, especially from the doorbell XArray.
>>>
>>> These accesses can race with the queue destruction process and result in use-
>>> after-free bugs.
>>>
>>> To fix this issue, this commit:
>>> 1) Introduces a new helper amdgpu_lookup_queue_by_doorbell, which looks
>>> up a user queue with locking and hold its kref during access.
>>>
>>> 2) Implement asynchronous userq destruction routine, because the last put of
>>> a queue kref may be placed in a code path where can not sleep or conflict
>>> locking with the destruction process.
>>>
>>> 3) Hold kref during access the user queues
>>>
>>> 4) Keep the userq manager alive as long as its queues, to avoid UAF issues.
>>>
>>> This seires passed amd_basic tests in igt tests
>>>
>>> Link to previus discussions: https://lists.freedesktop.org/archives/amd-
>>> gfx/2026-August/151692.html
>>>
>>> Please help review
>>>
>>> Thanks
>>> Lingshan
>>>
>>> Zhu Lingshan (10):
>>>   drm/amdgpu: introduce amdgpu_lookup_queue_by_doorbell
>>>   drm/amdgpu: keep the userq manager alive as long as its queues
>>>   drm/amdgpu/gfx11: hold userq refs in private fault worker
>>>   drm/amdgpu/gfx12: hold userq refs in private fault worker
>>>   drm/amdgpu: implement asynchronous userq destruction routine
>>>   drm/amdgpu: hold userq kref in MES reset
>>>   drm/amdgpu: hold userq kref during isolation scheduling
>>>   drm/amdgpu: hold userq kref during suspend and resume
>>>   drm/amdgpu: free userq by kref_put when fails to create
>>>   drm/amdgpu: take queue kref in userq_create to avoid UAF
>>>
>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c  | 214
>>> +++++++++++++++++++--  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
>>> |  18 ++
>>>  drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c     |   7 +-
>>>  drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c     |   7 +-
>>>  drivers/gpu/drm/amd/amdgpu/mes_userqueue.c |  46 ++---
>>>  5 files changed, 246 insertions(+), 46 deletions(-)
>>>
>>> --
>>> 2.53.0
>>>
--------------p6gm3Jplpm5e21voQYOW4LZ4
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <pre>Gentle Ping Alex</pre>
    <pre class="moz-cite-prefix">On 9/18/2026 6:01 PM, Zhu, Lingshan wrote:
</pre>
    <blockquote type="cite" cite="mid:443c6d8c-107e-4eaf-b81d-d6df2733b5a2@amd.com">
      <pre wrap="" class="moz-quote-pre">On 9/16/2026 6:18 AM, Deucher, Alexander wrote:

</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">AMD General

</pre>
        <blockquote type="cite">
          <pre wrap="" class="moz-quote-pre">-----Original Message-----
From: Zhu, Lingshan <a class="moz-txt-link-rfc2396E" href="mailto:Lingshan.Zhu@amd.com">&lt;Lingshan.Zhu@amd.com&gt;</a>
Sent: Monday, September 14, 2026 9:55 PM
To: Deucher, Alexander <a class="moz-txt-link-rfc2396E" href="mailto:Alexander.Deucher@amd.com">&lt;Alexander.Deucher@amd.com&gt;</a>; Kuehling, Felix
<a class="moz-txt-link-rfc2396E" href="mailto:Felix.Kuehling@amd.com">&lt;Felix.Kuehling@amd.com&gt;</a>
Cc: Huang, Ray <a class="moz-txt-link-rfc2396E" href="mailto:Ray.Huang@amd.com">&lt;Ray.Huang@amd.com&gt;</a>; <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.org</a>
Subject: RE: [PATCH RESEND 00/10] drm/amdgpu: secure userq lifecycle by its
kref

AMD General

Gentle Ping Alex
</pre>
        </blockquote>
        <pre wrap="" class="moz-quote-pre">It doesn't look like Christian's concerns were addressed.
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
Hello Alex,

I didn't hear back from Christian for almost two weeks, hope I did not miss any emails

This series tries to fix a common use-after-free issues for user queue.

The user queues are destroyed when its kref get to zero. So any code paths that work on a user queue has to
take a kref of the queue to make sure the queue is alive during its operation.

However there are several critical functions does not take a kref of a queue when operate on it,
for example mes_userq_reset_queue(patch 6) and gfx_v11_0_userq_priv_fault_work(patch 3).

There could be use-after-free bugs if the user space invokes AMDGPU_USERQ_OP_FREE, or close the drm file,
or the user space program unexpectedly crashes/exits when kernel processing the user queue without holding a kref.

This series tries to fix these problems, and this series is a dependency of the PMC work.

Please help Review

Thanks
Lingshan

</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">
Alex

</pre>
        <blockquote type="cite">
          <pre wrap="" class="moz-quote-pre">-----Original Message-----
From: Zhu, Lingshan <a class="moz-txt-link-rfc2396E" href="mailto:Lingshan.Zhu@amd.com">&lt;Lingshan.Zhu@amd.com&gt;</a>
Sent: Monday, September 14, 2026 9:07 PM
To: Deucher, Alexander <a class="moz-txt-link-rfc2396E" href="mailto:Alexander.Deucher@amd.com">&lt;Alexander.Deucher@amd.com&gt;</a>; Kuehling, Felix
<a class="moz-txt-link-rfc2396E" href="mailto:Felix.Kuehling@amd.com">&lt;Felix.Kuehling@amd.com&gt;</a>
Cc: Huang, Ray <a class="moz-txt-link-rfc2396E" href="mailto:Ray.Huang@amd.com">&lt;Ray.Huang@amd.com&gt;</a>; <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.org</a>; Zhu,
Lingshan <a class="moz-txt-link-rfc2396E" href="mailto:Lingshan.Zhu@amd.com">&lt;Lingshan.Zhu@amd.com&gt;</a>
Subject: [PATCH RESEND 00/10] drm/amdgpu: secure userq lifecycle by its
kref

A struct kref is embedded in user queue, which manages the lifecycle of a user
queue. However, several code paths access user queues without hoding the
kref of a user queue, especially from the doorbell XArray.

These accesses can race with the queue destruction process and result in use-
after-free bugs.

To fix this issue, this commit:
1) Introduces a new helper amdgpu_lookup_queue_by_doorbell, which looks
up a user queue with locking and hold its kref during access.

2) Implement asynchronous userq destruction routine, because the last put of
a queue kref may be placed in a code path where can not sleep or conflict
locking with the destruction process.

3) Hold kref during access the user queues

4) Keep the userq manager alive as long as its queues, to avoid UAF issues.

This seires passed amd_basic tests in igt tests

Link to previus discussions: <a class="moz-txt-link-freetext" href="https://lists.freedesktop.org/archives/amd">https://lists.freedesktop.org/archives/amd</a>-
gfx/2026-August/151692.html

Please help review

Thanks
Lingshan

Zhu Lingshan (10):
  drm/amdgpu: introduce amdgpu_lookup_queue_by_doorbell
  drm/amdgpu: keep the userq manager alive as long as its queues
  drm/amdgpu/gfx11: hold userq refs in private fault worker
  drm/amdgpu/gfx12: hold userq refs in private fault worker
  drm/amdgpu: implement asynchronous userq destruction routine
  drm/amdgpu: hold userq kref in MES reset
  drm/amdgpu: hold userq kref during isolation scheduling
  drm/amdgpu: hold userq kref during suspend and resume
  drm/amdgpu: free userq by kref_put when fails to create
  drm/amdgpu: take queue kref in userq_create to avoid UAF

 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c  | 214
+++++++++++++++++++--  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
|  18 ++
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c     |   7 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c     |   7 +-
 drivers/gpu/drm/amd/amdgpu/mes_userqueue.c |  46 ++---
 5 files changed, 246 insertions(+), 46 deletions(-)

--
2.53.0

</pre>
        </blockquote>
      </blockquote>
    </blockquote>
  </body>
</html>

--------------p6gm3Jplpm5e21voQYOW4LZ4--
