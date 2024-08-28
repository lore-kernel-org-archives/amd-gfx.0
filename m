Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CBFDC7113C
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Aug 2024 21:38:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C22F610E5F8;
	Wed, 28 Aug 2024 21:38:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="MA3Cb8Dt";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2064.outbound.protection.outlook.com [40.107.92.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BE3D510E5F8
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Aug 2024 21:38:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IAg5FSH18Bomxe/+MeOrGXyYeHfNn25AzNTImR9K2ZVX+aox2s1KE7FZXXNDS7ipKaYsTl2Zfv1Ua/Rt3M/lwQIFgFE1gZ4ht9WcLMsAH581ZA2X8iJlfH+KuSwrXNH+1vXNKuk6pS5itau0YjwBuTeFpLwMsWBob6yovoApJqCvTFxZ4PvxjKT7aQBtdtBBiptjXgnLEtmeYYKvGSFYXudrtCq2vlM6Q0BzQYmAFThfMqTb/BXzWKaxz4VzBHDZc1c0U2djGvgkFxkRANhHIv1aWyTV3X6y0xx4OAGDKwambzQUuMpD7tmUfn1FGMvTfJauPa8znqFUrCqTeRiDQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k4/Jxs1RTWi2ghj7E22OWC48xjOHMw89D6erjslV9v4=;
 b=pHTXdUmwny/mMOarxwJF7TKAo9PBtzSJWfB7O09U8zgWC/+6MSGQRFRXu96d1piKmdJK2ENrO1jyJd06LL4blQUxOr6CsmfDLE9EJ3d3U5qmyiPqgm08+lOY/3O3ES1wG1RyO6lp7XoTfGzQ84YJvU/1Sg8ab1Z72fAoKsWz+OwZYY2uQJNv2UOqhID/Tpzl9/jgTiDvF5X/s/ZczE336liYLiLfuVP5c9owfn/41T/ZFgtVvmT1NHeml8O45qzCWdvnbeKGP2uqilRYSb/MV/JQyuwlV01uAf0GQVz+W1mUQ47NAE0iOpppais75d4CZVP2z2qkt2SJ4c5gxnnL2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k4/Jxs1RTWi2ghj7E22OWC48xjOHMw89D6erjslV9v4=;
 b=MA3Cb8DtrzZ+n0UCVkti6iPOTuKox3HryHw5pLReZJMs9yjHhcmE6ntMOJo1nYAT58L6AK9Js8+Semx36hRyZyrQzkV2ke+jWQmut59N+aoIWVrqCQeOW8t47WC3QSDoepaeA6pqjA3BZLA3AlN1tokYlYgSqcv3O5xPaXKGrnU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6566.namprd12.prod.outlook.com (2603:10b6:8:8d::16) by
 DM4PR12MB6591.namprd12.prod.outlook.com (2603:10b6:8:8e::13) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7897.25; Wed, 28 Aug 2024 21:38:22 +0000
Received: from DM4PR12MB6566.namprd12.prod.outlook.com
 ([fe80::31b:5d31:8ba6:abd7]) by DM4PR12MB6566.namprd12.prod.outlook.com
 ([fe80::31b:5d31:8ba6:abd7%6]) with mapi id 15.20.7897.021; Wed, 28 Aug 2024
 21:38:22 +0000
Content-Type: multipart/alternative;
 boundary="------------VSdsmt0PY5zZ0I5IwnUBqtVK"
Message-ID: <d97d55a7-da73-4c08-930b-e85c81477b51@amd.com>
Date: Wed, 28 Aug 2024 16:38:22 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amdgpu: Surface svm_attr_gobm, a RW module
 parameter
Content-Language: en-CA
To: Felix Kuehling <felix.kuehling@amd.com>,
 "Errabolu, Ramesh" <Ramesh.Errabolu@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20240826193420.126272-1-Ramesh.Errabolu@amd.com>
 <773d3d99-4e97-45cf-a457-51989ba3081c@amd.com>
 <DS7PR12MB8321124485D5DF7E4A0CC67CE3952@DS7PR12MB8321.namprd12.prod.outlook.com>
 <77342503-b366-4d8f-93f1-91e75c0682a8@amd.com>
 <DS7PR12MB832146FE01CC9CF5DF499D39E3952@DS7PR12MB8321.namprd12.prod.outlook.com>
 <3ad48bb9-ec0d-4908-a9d6-af60aead9de2@amd.com>
 <82fe94f3-9f45-4cf4-9e52-664f7624a469@amd.com>
From: "Chen, Xiaogang" <xiaogang.chen@amd.com>
In-Reply-To: <82fe94f3-9f45-4cf4-9e52-664f7624a469@amd.com>
X-ClientProxiedBy: SA9PR10CA0019.namprd10.prod.outlook.com
 (2603:10b6:806:a7::24) To DM4PR12MB6566.namprd12.prod.outlook.com
 (2603:10b6:8:8d::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6566:EE_|DM4PR12MB6591:EE_
X-MS-Office365-Filtering-Correlation-Id: 6457fbbf-a785-4c9b-633b-08dcc7a9bdb4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cW9pY0YvZVZGeklvOWtaVDRMRk5ROWFzSzRzWUkzMWNiK2dOSUxLMkxKb1JZ?=
 =?utf-8?B?Sm80YUhCZ3pJNG5uQUF6dUNHUVcvUDVZdTdQSUFoZUJJMklNVzRNa2FqQWhO?=
 =?utf-8?B?em1KaDZDd3RONVdZd0gwYWFyczZUVGdxSmhXL09BMFZZVnlNWnRnaWd6VGxG?=
 =?utf-8?B?aS85L0wrQTZ3Sy84RkEzOWFnRzZIYVlrMkZqNDV2eFd1aFIzOW00Vk9JOVNo?=
 =?utf-8?B?eWtoMU5ZU3luazdrWDVjYzFJUnJRZkw2T2tRaG5YQzhFU25ZcjF3c3hTZnR0?=
 =?utf-8?B?VmRQSDBINmtjNmVjdXpTWENMbXhsRUVZMzIvOU50UmtoMEZ3Z3dFN0pweENK?=
 =?utf-8?B?QmRJSm1ycDRWVjdqa3pTOTdUanhuT1BvWStKL3RxMUpmTXRadGk2MURmellK?=
 =?utf-8?B?dGRjdHNDVVZTa243VzQ3WWhSVjZKdjVhQ3AvQ25aSmZuZitZVjRJdDZmZkdp?=
 =?utf-8?B?akxuZjNDQ094MGxhTnNhNmpmelhjRHFDZmxaUTlvQStPdEJ4aDJVR3ZiYUFp?=
 =?utf-8?B?ODFBZnUzdjBtQndta21SVjhSWDQ4SDZWWERjZ2hJcmtHcWVweWxraWZsd3JL?=
 =?utf-8?B?bkpVekt3WVJkZHFoQWUwbklzRGJMUTFkbVNPK1oxUW5FZnJhMUNnNDgrUThP?=
 =?utf-8?B?dTA1bkZHb0xhNGdweEl1NERWTEhoMWVhc2x2V2VJckRsNE1PTWFXdUFsblFS?=
 =?utf-8?B?NjN3ZWtweDk4dmZqUTJpak5rb252MHFWRGNLSGdZaWdyQkhSYVI5Yk9SWnZX?=
 =?utf-8?B?NXB3dDVEZldWQlNoUzhVRGF2enpvSER0STkydVJUbFhIUjJPWDl4K0FWWTRa?=
 =?utf-8?B?dmdrRHRsWW5RRElBbVkyM0ZBNXlnSTVCbGtxdXlYRUQ1M0JmT1picVRSWTIx?=
 =?utf-8?B?aml0RWtnM0VwQTlOWlprMDNsUnBCVmQwaUtVcForQmdWdmxiZzl0TlBXdFB1?=
 =?utf-8?B?Z1JwemdreXkrS0VvTzZ3Wi80RjhHYnlSWXdhWHBlOGM1azAxRFVaMmVVN2or?=
 =?utf-8?B?dlBUQXVFSkY3dUd1MXVDb2FjOXdsdnJCYW9RMzJkUXlUbmJCR3B0Q2VMbFRZ?=
 =?utf-8?B?cjlPaDNKZldiUFNFK2MxenVMYUJkdndFS3FnSEdQWHBhRFFTTjh2WW9xK0Nr?=
 =?utf-8?B?K25RUHBtMnduWHlWS2lqOVMzM2ZwU0xwMTdBaUhxelFEeVdDUXlVMEtSQTlM?=
 =?utf-8?B?WmpDSDFCYTFpYTV3RFVKd0czdHN5L1c1RzZwR0VrUDdyZ3JVRDU1UWtjVitp?=
 =?utf-8?B?M0gzR2puNDRQeTIzTStKWjJRVTlWb2FKbm4yWDlsdURScENiL2ExMTNWWmFW?=
 =?utf-8?B?b1Nrd0pRbDlqYWlBaU9YTGQyZmFHQzNabGRTalNvVzNHL1l3K3R2UGhkdjJn?=
 =?utf-8?B?MnVHVWVaMzhDZFVINDNkWHpQNVRTMmt2SDh1a3A3SjhTOGJtTE85b3VKakg5?=
 =?utf-8?B?OEQyVXFFdnNSeUg5QU9DWTg1aXlYQjM2eXgzWEkwMGJRZi82NFB4Z2lFU0JU?=
 =?utf-8?B?UE9DMnVOeU1zYk1SMEZMamtmTGd0UVRQUGp4RXZRMFUwSzhsYjhkMjFLOVJK?=
 =?utf-8?B?ejd2RjZUOERpV3F6MlY1MjVDRDc5RWlUN3lSbzYxc0VnU1FzMXIxWG0rTzBY?=
 =?utf-8?B?emFXdHFzYmNmbDlhMXVSYW1YQVVQV3VMOWdRVHpmYWo1UTZXQng0dUd6aTU0?=
 =?utf-8?B?NlgyR2hEYU1GNUJHYnJDUFp3L0tnRkhpMmtLWXI3MG1NeWpQYlhaM1R2NlYw?=
 =?utf-8?B?VURqcXhWc3YwNWtSaktwSEVjczdrU29IT3BMKzNyWjlWcHFxMEtVWElrQVpo?=
 =?utf-8?B?ejkreitxZ3VRakJxRFdTQT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB6566.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NldINGhVWUs4Wk11OEtKSk80QzJ1OEJVQmZUQk45c0kxQ0l0UWMzdmZIL0dw?=
 =?utf-8?B?cVJTdkQrYmRhOG9EdDRxYXY3eWNiY09LWTIxcmpWV04wdjZxeGxtZWVjNkpQ?=
 =?utf-8?B?bk9STlh4UTI0a2d0akNTMVBZb3RtSHhHRE5URXpjNEwveFRxSFppYy9NMk1R?=
 =?utf-8?B?eGdreE40MVNDbThpOXRzSDB2cXRCTXQyU3V5YUtscFY3a1dQdWpYczc0ay9r?=
 =?utf-8?B?Nzdmd3ladFdSODNRYW92aXpjcGhqQ0hhVnVVNTB6SkdCcEZHYjF0WWhQbzRt?=
 =?utf-8?B?YTRpcEIyWWVwaHBkK1FyZ3BsUVpUQVpscmJSN3Z2aTYyU1hRL2R6UStIM2FS?=
 =?utf-8?B?T2w5c0JoL3EwSWYxM3dRV2EzVjZpSHJ3M3U5SnNsRVB6TG9zOFB1NWZLcXRH?=
 =?utf-8?B?TWJDd0U1U01mYkZLbk1HWWNJaDJMSHB6TkdlTTlmUVZOZURJaStaRndsWFFo?=
 =?utf-8?B?aGtTM1NSaHBUN3I4bEZMUnR3YmtPRyt2MmtGWG5mTGNib3l4SmszZEd6SVJk?=
 =?utf-8?B?L3Y3bnA0SkRpL3gwNVlXWlFKY0gyL1hweUJzYS8xR1VQbm9wdXczVEN4STEv?=
 =?utf-8?B?dVVzMHVDM1ptSEtBVzJ5MGtnN3pvU21ReGdtRDNVMTBuU0dUNElxOGY1aWFE?=
 =?utf-8?B?MTY0bW5jcFUxS3Z6SkdBSXQvaWxyWDBnMFI0dW5JU3Q1YlRnWkgvdTFQNFBC?=
 =?utf-8?B?U2oyNy9rdjR3anNTSEptQ1g2TU93MG05WC9YY3VyTUZGLzltQUUrTHNPb1hj?=
 =?utf-8?B?OGJxTVFDQitPTVltYUxDR04zeFB6em9JR3poL0lBV1QzOTlBWlBxdENRc292?=
 =?utf-8?B?bFcyYjJGRVB6OXpIK0cwbWdMck4vMVAyT2NLUDNndDVhMUx1Q1c0dGMrSmFk?=
 =?utf-8?B?MmtNL0VhenFyNGl6NmQ1eXlmU0xaTWFEWFQzVWJTWE9WTXF1b0hjenZnbVIw?=
 =?utf-8?B?NWVjTEN0R3l6MnNwVDFkeEJ6aHY1YjdTZWxvWjBaQzBFbDhhM0M4Qi9SZzBS?=
 =?utf-8?B?UWcwRmM3TWQvUzgvKzJzZXNjZlIwdnBxMXpmbU14bkxROGRadlZhOWVQMjFJ?=
 =?utf-8?B?QzdSMDRKbFZ2M3hZVXQxaW5abHk3cjhUT0NybFUwZnZNQXRRTjNBZmFFbEJj?=
 =?utf-8?B?VEJ0T2VuaVZUNnJGbG83V3hPdTg4aS9FNFpGOVY2b3JYcFVZM3BUUm9VL211?=
 =?utf-8?B?anZtdTFuM1RzMVhtSWJFRU9aMC83VEhSWkFwVmUxYmQ2L25mblEvVmJ4NjFu?=
 =?utf-8?B?Y1BVRm5LalRHMzlWeWZ0TG01ZUtXeDc3QXNTYkk4V0xKVDRkMXBQSFlPUUlo?=
 =?utf-8?B?UExvV3JwWUo3c1ZFSHNJQThYMzhQcVBVNHkyYk5iNTJsMzRRdWE3NC9FbHRK?=
 =?utf-8?B?UUk1TFVFbXpINUxxN0NEWExobG1ldnVKbG5Kb2RLQW1OZ0tvTUMvYVlGaFZ0?=
 =?utf-8?B?akVsM2NvTWNyMVhCREZYeDZ2ZWs4SVVmUXhzYzYxMjZhUkg5Z09kczlDeUdq?=
 =?utf-8?B?MWEzRWpaTzRMMnpoU2RrRTIrejNtckNqMDN5TVNoS1JCZW83NDN6aUpPL3p2?=
 =?utf-8?B?VTRmeHNablZ6QVFlOCtSNzR0Sm9UbWVCSlNqVUI4eDkvY0RndGpqQUpYVC84?=
 =?utf-8?B?aHVmZ1ZWYlVsYjhwcW1rN0p6ejQ2dXFTY0dFV25nQ094ck5sL29MRTJVNkRV?=
 =?utf-8?B?dkJMLzluVHV4ZGlwTmxHWWZPNnd4SCt5RkZBRUt5K1ExWGs0bXM4cEhFK3lR?=
 =?utf-8?B?ZUNaemttSUVuYjJqT1JwdlBjUmk5cStnWkJ0NGoxWHcyd2p0S3R6ODlTU09w?=
 =?utf-8?B?a1BlSVpwa0s3aWVxQzlSTEZScS8xekZOaVB0bVNpakV6S1ZndjRtZjBqU1dL?=
 =?utf-8?B?Yi9BTW1mOTJqcVpPUFhZNDlUcjlGblFnaFhWUUxDajlxOEl4NCtNcEh2UGdv?=
 =?utf-8?B?MzROUmdVNllDcjF5OTJxVEtGZlFxZ3hmRkcrSzFrUklVRTl2VFhKQjdyWnYz?=
 =?utf-8?B?REdHQXFBK2ZYdlViZ09XY2ZpakVjWTNvM3BpWlhYS2xhQ0Voa0luT283SGdJ?=
 =?utf-8?B?VGFnSlpqamZvaDkrQllEWWZGRm9mRXArcnY4REM4TGZSVFhqK3JGOE5hUGF0?=
 =?utf-8?Q?dnbM=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6457fbbf-a785-4c9b-633b-08dcc7a9bdb4
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6566.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2024 21:38:22.7554 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LrnLBWp3190MzSvsZo7VVEZL98DsCRr0kyiSUf8rpEAuP6du3lF3fjvg+hTxa455
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6591
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

--------------VSdsmt0PY5zZ0I5IwnUBqtVK
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 8/28/2024 4:05 PM, Felix Kuehling wrote:
>
> On 2024-08-28 16:34, Chen, Xiaogang wrote:
>>
>>
>> On 8/28/2024 3:26 PM, Errabolu, Ramesh wrote:
>>>
>>> Responses inline
>>>
>>> Regards,
>>>
>>> Ramesh
>>>
>>> *From:*Chen, Xiaogang <Xiaogang.Chen@amd.com>
>>> *Sent:* Wednesday, August 28, 2024 3:01 PM
>>> *To:* Errabolu, Ramesh <Ramesh.Errabolu@amd.com>; 
>>> amd-gfx@lists.freedesktop.org
>>> *Subject:* Re: [PATCH v2] drm/amdgpu: Surface svm_attr_gobm, a RW 
>>> module parameter
>>>
>>> On 8/28/2024 2:52 PM, Errabolu, Ramesh wrote:
>>>
>>>     Response inline
>>>
>>>     Regards,
>>>
>>>     Ramesh
>>>
>>>
>>>     -----Original Message-----
>>>
>>>     From: Chen, Xiaogang<Xiaogang.Chen@amd.com> 
>>> <mailto:Xiaogang.Chen@amd.com>
>>>     Sent: Wednesday, August 28, 2024 2:43 PM
>>>
>>>     To: Errabolu, Ramesh<Ramesh.Errabolu@amd.com> 
>>> <mailto:Ramesh.Errabolu@amd.com>;amd-gfx@lists.freedesktop.org
>>>
>>>     Subject: Re: [PATCH v2] drm/amdgpu: Surface svm_attr_gobm, a RW 
>>> module parameter
>>>
>>>     Why need this driver parameter? kfd has 
>>> KFD_IOCTL_SVM_ATTR_GRANULARITY api that allows user space to set 
>>> migration granularity per prange. If both got set which will take 
>>> precedence?
>>>
>>>     Ramesh: Use of Kfd Ioctl is available to users of registered 
>>> memory. It allows users to control GOBM per buffer level, including 
>>> overwriting default value. For ranges that do not specify GOBM, the 
>>> default value will be found.
>>>
>>> If user space use KFD_IOCTL_SVM_ATTR_GRANULARITY it will overwrite 
>>> this parameter value for a prange, then how to know which 
>>> granularity take effect? That is decided when user set this 
>>> parameter and when the api got used.
>>>
>>> Ramesh: The value bound by Kfd ioctl will take effect. In the life 
>>> cycle of a prange it can go from the default value to one that is 
>>> set by user via set_attr() call. However, it is generally understood 
>>> that that users of set_attr() will not call it directly i.e. the 
>>> rely on higher level apis from ROCr or HIP.
>>>
>> driver parameter can be set at run time, not only at boot time. It is 
>> not predictable  when user set this driver parameter and when the api 
>> got called.
>>
> I don't think this is a problem. The module parameter determines the 
> granularity if the application doesn't set the virtual address range 
> attribute. The default is captured in the per-process svms structure. 
> So all mappings of the same process will use the same default, even if 
> the module parameter is changed after the process is started. The 
> get_attr ioctl will always return the actual granularity, no matter 
> whether it comes from the default or was overridden by user mode for 
> the virtual address range.

My concern is there are two ways to set pragne's granularity, both can 
be used at run time. It can make confusion to know which one take effect 
as user can use driver parameter and api to change granularity with any 
timing.

Regards

Xiaogang

>
> Regards,
>   Felix
>
>
>> Regards
>>
>> Xiaogang
>>
>>> Regards
>>>
>>> Xiaogang
>>>
>>>     Regards
>>>
>>>     Xiaogang
>>>
>>>     On 8/26/2024 2:34 PM, Ramesh Errabolu wrote:
>>>
>>>         Caution: This message originated from an External Source. 
>>> Use proper caution when opening attachments, clicking links, or 
>>> responding.
>>>
>>>         Enables users to update the default size of buffer used in 
>>> migration
>>>
>>>         either from Sysmem to VRAM or vice versa.
>>>
>>>         The param GOBM refers to granularity of buffer migration, 
>>> and is
>>>
>>>         specified in terms of log(numPages(buffer)). It facilitates 
>>> users of
>>>
>>>         unregistered memory to control GOBM, albeit at a coarse level
>>>
>>>         Signed-off-by: Ramesh Errabolu<Ramesh.Errabolu@amd.com> 
>>> <mailto:Ramesh.Errabolu@amd.com>
>>>
>>>         ---
>>>
>>>            drivers/gpu/drm/amd/amdgpu/amdgpu.h     |  4 ++++
>>>
>>>            drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 18 
>>> +++++++++++++++++
>>>
>>>            drivers/gpu/drm/amd/amdkfd/kfd_priv.h   | 12 ++++++++++++
>>>
>>>            drivers/gpu/drm/amd/amdkfd/kfd_svm.c    | 26 
>>> ++++++++++++++++---------
>>>
>>>            4 files changed, 51 insertions(+), 9 deletions(-)
>>>
>>>         diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>>
>>>         b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>>
>>>         index e8c284aea1f2..73dd816b01f2 100644
>>>
>>>         --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>>
>>>         +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>>
>>>         @@ -237,6 +237,7 @@ extern int sched_policy;
>>>
>>>            extern bool debug_evictions;
>>>
>>>            extern bool no_system_mem_limit;
>>>
>>>            extern int halt_if_hws_hang;
>>>
>>>         +extern uint amdgpu_svm_attr_gobm;
>>>
>>>            #else
>>>
>>>            static const int __maybe_unused sched_policy = 
>>> KFD_SCHED_POLICY_HWS;
>>>
>>>            static const bool __maybe_unused debug_evictions; /* = 
>>> false */ @@
>>>
>>>         -313,6 +314,9 @@ extern int amdgpu_wbrf;
>>>
>>>            /* Extra time delay(in ms) to eliminate the influence of 
>>> temperature momentary fluctuation */
>>>
>>>            #define AMDGPU_SWCTF_EXTRA_DELAY               50
>>>
>>>         +/* Default size of buffer to use in migrating buffer */
>>>
>>>         +#define AMDGPU_SVM_ATTR_GOBM       9
>>>
>>>         +
>>>
>>>            struct amdgpu_xcp_mgr;
>>>
>>>            struct amdgpu_device;
>>>
>>>            struct amdgpu_irq_src;
>>>
>>>         diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>>>
>>>         b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>>>
>>>         index b9529948f2b2..09c501753a3b 100644
>>>
>>>         --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>>>
>>>         +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>>>
>>>         @@ -169,6 +169,17 @@ uint amdgpu_sdma_phase_quantum = 32;
>>>
>>>            char *amdgpu_disable_cu;
>>>
>>>            char *amdgpu_virtual_display;
>>>
>>>            bool enforce_isolation;
>>>
>>>         +
>>>
>>>         +/* Specifies the default size of buffer to use in
>>>
>>>         + * migrating buffer from Sysmem to VRAM and vice
>>>
>>>         + * versa
>>>
>>>         + *
>>>
>>>         + * GOBM - Granularity of Buffer Migration
>>>
>>>         + *
>>>
>>>         + * Defined as log2(sizeof(buffer)/PAGE_SIZE)  */ uint
>>>
>>>         +amdgpu_svm_attr_gobm = AMDGPU_SVM_ATTR_GOBM;
>>>
>>>         +
>>>
>>>            /*
>>>
>>>             * OverDrive(bit 14) disabled by default
>>>
>>>             * GFX DCS(bit 19) disabled by default @@ -320,6 +331,13 @@
>>>
>>>         module_param_named(pcie_gen2, amdgpu_pcie_gen2, int, 0444);
>>>
>>>            MODULE_PARM_DESC(msi, "MSI support (1 = enable, 0 = 
>>> disable, -1 = auto)");
>>>
>>>            module_param_named(msi, amdgpu_msi, int, 0444);
>>>
>>>         +/**
>>>
>>>         + * DOC: svm_attr_gobm (uint)
>>>
>>>         + * Size of buffer to use in migrating buffer from Sysmem to 
>>> VRAM and
>>>
>>>         +vice versa  */ MODULE_PARM_DESC(svm_attr_gobm, "Defined as
>>>
>>>         +log2(sizeof(buffer)/PAGE_SIZE), e.g. 9 for 2 MiB");
>>>
>>>         +module_param_named(svm_attr_gobm, amdgpu_svm_attr_gobm, 
>>> uint, 0644);
>>>
>>>         +
>>>
>>>            /**
>>>
>>>             * DOC: lockup_timeout (string)
>>>
>>>             * Set GPU scheduler timeout value in ms.
>>>
>>>         diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>>>
>>>         b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>>>
>>>         index 9ae9abc6eb43..c2e54b18c167 100644
>>>
>>>         --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>>>
>>>         +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>>>
>>>         @@ -868,6 +868,18 @@ struct svm_range_list {
>>>
>>>                   struct task_struct *faulting_task;
>>>
>>>                   /* check point ts decides if page fault recovery 
>>> need be dropped */
>>>
>>>                   uint64_t checkpoint_ts[MAX_GPU_INSTANCE];
>>>
>>>         +
>>>
>>>         +       /* Indicates the default size to use in migrating
>>>
>>>         +        * buffers of a process from Sysmem to VRAM and vice
>>>
>>>         +        * versa. The max legal value cannot be greater than
>>>
>>>         +        * 0x3F
>>>
>>>         +        *
>>>
>>>         +        * @note: A side effect of this symbol being part of
>>>
>>>         +        * struct svm_range_list is that it forces all buffers
>>>
>>>         +        * of the process of unregistered kind to use the same
>>>
>>>         +        * size in buffer migration
>>>
>>>         +        */
>>>
>>>         +       uint8_t attr_gobm;
>>>
>>>            };
>>>
>>>            /* Process data */
>>>
>>>         diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>>>
>>>         b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>>>
>>>         index b44dec90969f..78c78baddb1f 100644
>>>
>>>         --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>>>
>>>         +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>>>
>>>         @@ -309,12 +309,11 @@ static void svm_range_free(struct 
>>> svm_range *prange, bool do_unmap)
>>>
>>>            }
>>>
>>>            static void
>>>
>>>         -svm_range_set_default_attributes(int32_t *location, int32_t 
>>> *prefetch_loc,
>>>
>>>         -                                uint8_t *granularity, 
>>> uint32_t *flags)
>>>
>>>         +svm_range_set_default_attributes(int32_t *location,
>>>
>>>         +                       int32_t *prefetch_loc, uint32_t *flags)
>>>
>>>            {
>>>
>>>                   *location = KFD_IOCTL_SVM_LOCATION_UNDEFINED;
>>>
>>>                   *prefetch_loc = KFD_IOCTL_SVM_LOCATION_UNDEFINED;
>>>
>>>         -       *granularity = 9;
>>>
>>>                   *flags =
>>>
>>>                           KFD_IOCTL_SVM_FLAG_HOST_ACCESS | 
>>> KFD_IOCTL_SVM_FLAG_COHERENT;
>>>
>>>            }
>>>
>>>         @@ -358,9 +357,9 @@ svm_range *svm_range_new(struct 
>>> svm_range_list *svms, uint64_t start,
>>>
>>> bitmap_copy(prange->bitmap_access, svms->bitmap_supported,
>>>
>>>                                       MAX_GPU_INSTANCE);
>>>
>>>         +       prange->granularity = svms->attr_gobm;
>>>
>>> svm_range_set_default_attributes(&prange->preferred_loc,
>>>
>>>         - &prange->prefetch_loc,
>>>
>>>         - &prange->granularity, &prange->flags);
>>>
>>>         + &prange->prefetch_loc,
>>>
>>>         + &prange->flags);
>>>
>>>                   pr_debug("svms 0x%p [0x%llx 0x%llx]\n", svms, 
>>> start, last);
>>>
>>>         @@ -2693,10 +2692,12 @@ svm_range_get_range_boundaries(struct
>>>
>>>         kfd_process *p, int64_t addr,
>>>
>>>                   *is_heap_stack = vma_is_initial_heap(vma) ||
>>>
>>>         vma_is_initial_stack(vma);
>>>
>>>         +       /* Determine the starting and ending page of prange */
>>>
>>>                   start_limit = max(vma->vm_start >> PAGE_SHIFT,
>>>
>>>         -                     (unsigned long)ALIGN_DOWN(addr, 2UL << 
>>> 8));
>>>
>>>         +                     (unsigned long)ALIGN_DOWN(addr, 1 <<
>>>
>>>         + p->svms.attr_gobm));
>>>
>>>                   end_limit = min(vma->vm_end >> PAGE_SHIFT,
>>>
>>>         -                   (unsigned long)ALIGN(addr + 1, 2UL << 8));
>>>
>>>         +                   (unsigned long)ALIGN(addr + 1, 1 <<
>>>
>>>         + p->svms.attr_gobm));
>>>
>>>         +
>>>
>>>                   /* First range that starts after the fault address */
>>>
>>>                   node = interval_tree_iter_first(&p->svms.objects, 
>>> addr + 1, ULONG_MAX);
>>>
>>>                   if (node) {
>>>
>>>         @@ -3240,6 +3241,12 @@ int svm_range_list_init(struct 
>>> kfd_process *p)
>>>
>>>                           if 
>>> (KFD_IS_SVM_API_SUPPORTED(p->pdds[i]->dev->adev))
>>>
>>> bitmap_set(svms->bitmap_supported, i, 1);
>>>
>>>         +       /* Bind granularity of buffer migration, either
>>>
>>>         +        * the default size or one specified by the user
>>>
>>>         +        */
>>>
>>>         +       svms->attr_gobm = min_t(u8, amdgpu_svm_attr_gobm, 
>>> 0x3F);
>>>
>>>         +       pr_debug("Granularity Of Buffer Migration: %d\n",
>>>
>>>         + svms->attr_gobm);
>>>
>>>         +
>>>
>>>                   return 0;
>>>
>>>            }
>>>
>>>         @@ -3767,8 +3774,9 @@ svm_range_get_attr(struct kfd_process 
>>> *p, struct mm_struct *mm,
>>>
>>>                   node = interval_tree_iter_first(&svms->objects, 
>>> start, last);
>>>
>>>                   if (!node) {
>>>
>>>                           pr_debug("range attrs not found return 
>>> default values\n");
>>>
>>>         - svm_range_set_default_attributes(&location, &prefetch_loc,
>>>
>>>         - &granularity, &flags_and);
>>>
>>>         +               granularity = svms->attr_gobm;
>>>
>>>         + svm_range_set_default_attributes(&location,
>>>
>>>         +     &prefetch_loc, &flags_and);
>>>
>>>                           flags_or = flags_and;
>>>
>>>                           if (p->xnack_enabled)
>>>
>>>                                   bitmap_copy(bitmap_access,
>>>
>>>         svms->bitmap_supported,
>>>
>>>         --
>>>
>>>         2.34.1
>>>
--------------VSdsmt0PY5zZ0I5IwnUBqtVK
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 8/28/2024 4:05 PM, Felix Kuehling
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:82fe94f3-9f45-4cf4-9e52-664f7624a469@amd.com">
      <br>
      On 2024-08-28 16:34, Chen, Xiaogang wrote:
      <br>
      <blockquote type="cite">
        <br>
        <br>
        On 8/28/2024 3:26 PM, Errabolu, Ramesh wrote:
        <br>
        <blockquote type="cite">
          <br>
          Responses inline
          <br>
          <br>
          Regards,
          <br>
          <br>
          Ramesh
          <br>
          <br>
          *From:*Chen, Xiaogang <a class="moz-txt-link-rfc2396E" href="mailto:Xiaogang.Chen@amd.com">&lt;Xiaogang.Chen@amd.com&gt;</a>
          <br>
          *Sent:* Wednesday, August 28, 2024 3:01 PM
          <br>
          *To:* Errabolu, Ramesh <a class="moz-txt-link-rfc2396E" href="mailto:Ramesh.Errabolu@amd.com">&lt;Ramesh.Errabolu@amd.com&gt;</a>;
          <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.org</a>
          <br>
          *Subject:* Re: [PATCH v2] drm/amdgpu: Surface svm_attr_gobm, a
          RW module parameter
          <br>
          <br>
          On 8/28/2024 2:52 PM, Errabolu, Ramesh wrote:
          <br>
          <br>
          &nbsp;&nbsp;&nbsp; Response inline
          <br>
          <br>
          &nbsp;&nbsp;&nbsp; Regards,
          <br>
          <br>
          &nbsp;&nbsp;&nbsp; Ramesh
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <br>
          &nbsp;&nbsp;&nbsp; -----Original Message-----
          <br>
          <br>
          &nbsp;&nbsp;&nbsp; From: Chen, Xiaogang<a class="moz-txt-link-rfc2396E" href="mailto:Xiaogang.Chen@amd.com">&lt;Xiaogang.Chen@amd.com&gt;</a>&nbsp;
          <a class="moz-txt-link-rfc2396E" href="mailto:Xiaogang.Chen@amd.com">&lt;mailto:Xiaogang.Chen@amd.com&gt;</a>&nbsp; <br>
          &nbsp;&nbsp;&nbsp; Sent: Wednesday, August 28, 2024 2:43 PM
          <br>
          <br>
          &nbsp;&nbsp;&nbsp; To: Errabolu, Ramesh<a class="moz-txt-link-rfc2396E" href="mailto:Ramesh.Errabolu@amd.com">&lt;Ramesh.Errabolu@amd.com&gt;</a>&nbsp;
          <a class="moz-txt-link-rfc2396E" href="mailto:Ramesh.Errabolu@amd.com">&lt;mailto:Ramesh.Errabolu@amd.com&gt;</a>;amd-gfx@lists.freedesktop.org
          <br>
          <br>
          &nbsp;&nbsp;&nbsp; Subject: Re: [PATCH v2] drm/amdgpu: Surface svm_attr_gobm,
          a RW module parameter
          <br>
          <br>
          &nbsp;&nbsp;&nbsp; Why need this driver parameter? kfd has
          KFD_IOCTL_SVM_ATTR_GRANULARITY api that allows user space to
          set migration granularity per prange. If both got set which
          will take precedence?
          <br>
          <br>
          &nbsp;&nbsp;&nbsp; Ramesh: Use of Kfd Ioctl is available to users of
          registered memory. It allows users to control GOBM per buffer
          level, including overwriting default value. For ranges that do
          not specify GOBM, the default value will be found.
          <br>
          <br>
          If user space use KFD_IOCTL_SVM_ATTR_GRANULARITY it will
          overwrite this parameter value for a prange, then how to know
          which granularity take effect? That is decided when user set
          this parameter and when the api got used.
          <br>
          <br>
          Ramesh: The value bound by Kfd ioctl will take effect. In the
          life cycle of a prange it can go from the default value to one
          that is set by user via set_attr() call. However, it is
          generally understood that that users of set_attr() will not
          call it directly i.e. the rely on higher level apis from ROCr
          or HIP.
          <br>
          <br>
        </blockquote>
        driver parameter can be set at run time, not only at boot time.
        It is not predictable&nbsp; when user set this driver parameter and
        when the api got called.
        <br>
        <br>
      </blockquote>
      I don't think this is a problem. The module parameter determines
      the granularity if the application doesn't set the virtual address
      range attribute. The default is captured in the per-process svms
      structure. So all mappings of the same process will use the same
      default, even if the module parameter is changed after the process
      is started. The get_attr ioctl will always return the actual
      granularity, no matter whether it comes from the default or was
      overridden by user mode for the virtual address range.
      <br>
    </blockquote>
    <p><!--[if gte mso 9]><xml>
 <o:OfficeDocumentSettings>
  <o:AllowPNG/>
 </o:OfficeDocumentSettings>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <w:WordDocument>
  <w:View>Normal</w:View>
  <w:Zoom>0</w:Zoom>
  <w:TrackMoves/>
  <w:TrackFormatting/>
  <w:PunctuationKerning/>
  <w:ValidateAgainstSchemas/>
  <w:SaveIfXMLInvalid>false</w:SaveIfXMLInvalid>
  <w:IgnoreMixedContent>false</w:IgnoreMixedContent>
  <w:AlwaysShowPlaceholderText>false</w:AlwaysShowPlaceholderText>
  <w:DoNotPromoteQF/>
  <w:LidThemeOther>EN-US</w:LidThemeOther>
  <w:LidThemeAsian>X-NONE</w:LidThemeAsian>
  <w:LidThemeComplexScript>X-NONE</w:LidThemeComplexScript>
  <w:Compatibility>
   <w:BreakWrappedTables/>
   <w:SnapToGridInCell/>
   <w:WrapTextWithPunct/>
   <w:UseAsianBreakRules/>
   <w:DontGrowAutofit/>
   <w:SplitPgBreakAndParaMark/>
   <w:EnableOpenTypeKerning/>
   <w:DontFlipMirrorIndents/>
   <w:OverrideTableStyleHps/>
  </w:Compatibility>
  <w:DoNotOptimizeForBrowser/>
  <m:mathPr>
   <m:mathFont m:val="Cambria Math"/>
   <m:brkBin m:val="before"/>
   <m:brkBinSub m:val="&#45;-"/>
   <m:smallFrac m:val="off"/>
   <m:dispDef/>
   <m:lMargin m:val="0"/>
   <m:rMargin m:val="0"/>
   <m:defJc m:val="centerGroup"/>
   <m:wrapIndent m:val="1440"/>
   <m:intLim m:val="subSup"/>
   <m:naryLim m:val="undOvr"/>
  </m:mathPr></w:WordDocument>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <w:LatentStyles DefLockedState="false" DefUnhideWhenUsed="false"
  DefSemiHidden="false" DefQFormat="false" DefPriority="99"
  LatentStyleCount="376">
  <w:LsdException Locked="false" Priority="0" QFormat="true" Name="Normal"/>
  <w:LsdException Locked="false" Priority="9" QFormat="true" Name="heading 1"/>
  <w:LsdException Locked="false" Priority="9" SemiHidden="true"
   UnhideWhenUsed="true" QFormat="true" Name="heading 2"/>
  <w:LsdException Locked="false" Priority="9" SemiHidden="true"
   UnhideWhenUsed="true" QFormat="true" Name="heading 3"/>
  <w:LsdException Locked="false" Priority="9" SemiHidden="true"
   UnhideWhenUsed="true" QFormat="true" Name="heading 4"/>
  <w:LsdException Locked="false" Priority="9" SemiHidden="true"
   UnhideWhenUsed="true" QFormat="true" Name="heading 5"/>
  <w:LsdException Locked="false" Priority="9" SemiHidden="true"
   UnhideWhenUsed="true" QFormat="true" Name="heading 6"/>
  <w:LsdException Locked="false" Priority="9" SemiHidden="true"
   UnhideWhenUsed="true" QFormat="true" Name="heading 7"/>
  <w:LsdException Locked="false" Priority="9" SemiHidden="true"
   UnhideWhenUsed="true" QFormat="true" Name="heading 8"/>
  <w:LsdException Locked="false" Priority="9" SemiHidden="true"
   UnhideWhenUsed="true" QFormat="true" Name="heading 9"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="index 1"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="index 2"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="index 3"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="index 4"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="index 5"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="index 6"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="index 7"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="index 8"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="index 9"/>
  <w:LsdException Locked="false" Priority="39" SemiHidden="true"
   UnhideWhenUsed="true" Name="toc 1"/>
  <w:LsdException Locked="false" Priority="39" SemiHidden="true"
   UnhideWhenUsed="true" Name="toc 2"/>
  <w:LsdException Locked="false" Priority="39" SemiHidden="true"
   UnhideWhenUsed="true" Name="toc 3"/>
  <w:LsdException Locked="false" Priority="39" SemiHidden="true"
   UnhideWhenUsed="true" Name="toc 4"/>
  <w:LsdException Locked="false" Priority="39" SemiHidden="true"
   UnhideWhenUsed="true" Name="toc 5"/>
  <w:LsdException Locked="false" Priority="39" SemiHidden="true"
   UnhideWhenUsed="true" Name="toc 6"/>
  <w:LsdException Locked="false" Priority="39" SemiHidden="true"
   UnhideWhenUsed="true" Name="toc 7"/>
  <w:LsdException Locked="false" Priority="39" SemiHidden="true"
   UnhideWhenUsed="true" Name="toc 8"/>
  <w:LsdException Locked="false" Priority="39" SemiHidden="true"
   UnhideWhenUsed="true" Name="toc 9"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Normal Indent"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="footnote text"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="annotation text"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="header"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="footer"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="index heading"/>
  <w:LsdException Locked="false" Priority="35" SemiHidden="true"
   UnhideWhenUsed="true" QFormat="true" Name="caption"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="table of figures"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="envelope address"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="envelope return"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="footnote reference"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="annotation reference"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="line number"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="page number"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="endnote reference"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="endnote text"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="table of authorities"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="macro"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="toa heading"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="List"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="List Bullet"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="List Number"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="List 2"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="List 3"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="List 4"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="List 5"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="List Bullet 2"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="List Bullet 3"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="List Bullet 4"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="List Bullet 5"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="List Number 2"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="List Number 3"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="List Number 4"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="List Number 5"/>
  <w:LsdException Locked="false" Priority="10" QFormat="true" Name="Title"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Closing"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Signature"/>
  <w:LsdException Locked="false" Priority="1" SemiHidden="true"
   UnhideWhenUsed="true" Name="Default Paragraph Font"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Body Text"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Body Text Indent"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="List Continue"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="List Continue 2"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="List Continue 3"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="List Continue 4"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="List Continue 5"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Message Header"/>
  <w:LsdException Locked="false" Priority="11" QFormat="true" Name="Subtitle"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Salutation"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Date"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Body Text First Indent"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Body Text First Indent 2"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Note Heading"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Body Text 2"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Body Text 3"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Body Text Indent 2"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Body Text Indent 3"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Block Text"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Hyperlink"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="FollowedHyperlink"/>
  <w:LsdException Locked="false" Priority="22" QFormat="true" Name="Strong"/>
  <w:LsdException Locked="false" Priority="20" QFormat="true" Name="Emphasis"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Document Map"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Plain Text"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="E-mail Signature"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="HTML Top of Form"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="HTML Bottom of Form"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Normal (Web)"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="HTML Acronym"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="HTML Address"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="HTML Cite"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="HTML Code"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="HTML Definition"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="HTML Keyboard"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="HTML Preformatted"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="HTML Sample"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="HTML Typewriter"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="HTML Variable"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Normal Table"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="annotation subject"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="No List"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Outline List 1"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Outline List 2"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Outline List 3"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Simple 1"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Simple 2"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Simple 3"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Classic 1"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Classic 2"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Classic 3"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Classic 4"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Colorful 1"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Colorful 2"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Colorful 3"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Columns 1"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Columns 2"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Columns 3"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Columns 4"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Columns 5"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Grid 1"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Grid 2"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Grid 3"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Grid 4"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Grid 5"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Grid 6"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Grid 7"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Grid 8"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table List 1"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table List 2"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table List 3"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table List 4"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table List 5"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table List 6"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table List 7"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table List 8"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table 3D effects 1"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table 3D effects 2"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table 3D effects 3"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Contemporary"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Elegant"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Professional"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Subtle 1"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Subtle 2"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Web 1"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Web 2"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Web 3"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Balloon Text"/>
  <w:LsdException Locked="false" Priority="39" Name="Table Grid"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Theme"/>
  <w:LsdException Locked="false" SemiHidden="true" Name="Placeholder Text"/>
  <w:LsdException Locked="false" Priority="1" QFormat="true" Name="No Spacing"/>
  <w:LsdException Locked="false" Priority="60" Name="Light Shading"/>
  <w:LsdException Locked="false" Priority="61" Name="Light List"/>
  <w:LsdException Locked="false" Priority="62" Name="Light Grid"/>
  <w:LsdException Locked="false" Priority="63" Name="Medium Shading 1"/>
  <w:LsdException Locked="false" Priority="64" Name="Medium Shading 2"/>
  <w:LsdException Locked="false" Priority="65" Name="Medium List 1"/>
  <w:LsdException Locked="false" Priority="66" Name="Medium List 2"/>
  <w:LsdException Locked="false" Priority="67" Name="Medium Grid 1"/>
  <w:LsdException Locked="false" Priority="68" Name="Medium Grid 2"/>
  <w:LsdException Locked="false" Priority="69" Name="Medium Grid 3"/>
  <w:LsdException Locked="false" Priority="70" Name="Dark List"/>
  <w:LsdException Locked="false" Priority="71" Name="Colorful Shading"/>
  <w:LsdException Locked="false" Priority="72" Name="Colorful List"/>
  <w:LsdException Locked="false" Priority="73" Name="Colorful Grid"/>
  <w:LsdException Locked="false" Priority="60" Name="Light Shading Accent 1"/>
  <w:LsdException Locked="false" Priority="61" Name="Light List Accent 1"/>
  <w:LsdException Locked="false" Priority="62" Name="Light Grid Accent 1"/>
  <w:LsdException Locked="false" Priority="63" Name="Medium Shading 1 Accent 1"/>
  <w:LsdException Locked="false" Priority="64" Name="Medium Shading 2 Accent 1"/>
  <w:LsdException Locked="false" Priority="65" Name="Medium List 1 Accent 1"/>
  <w:LsdException Locked="false" SemiHidden="true" Name="Revision"/>
  <w:LsdException Locked="false" Priority="34" QFormat="true"
   Name="List Paragraph"/>
  <w:LsdException Locked="false" Priority="29" QFormat="true" Name="Quote"/>
  <w:LsdException Locked="false" Priority="30" QFormat="true"
   Name="Intense Quote"/>
  <w:LsdException Locked="false" Priority="66" Name="Medium List 2 Accent 1"/>
  <w:LsdException Locked="false" Priority="67" Name="Medium Grid 1 Accent 1"/>
  <w:LsdException Locked="false" Priority="68" Name="Medium Grid 2 Accent 1"/>
  <w:LsdException Locked="false" Priority="69" Name="Medium Grid 3 Accent 1"/>
  <w:LsdException Locked="false" Priority="70" Name="Dark List Accent 1"/>
  <w:LsdException Locked="false" Priority="71" Name="Colorful Shading Accent 1"/>
  <w:LsdException Locked="false" Priority="72" Name="Colorful List Accent 1"/>
  <w:LsdException Locked="false" Priority="73" Name="Colorful Grid Accent 1"/>
  <w:LsdException Locked="false" Priority="60" Name="Light Shading Accent 2"/>
  <w:LsdException Locked="false" Priority="61" Name="Light List Accent 2"/>
  <w:LsdException Locked="false" Priority="62" Name="Light Grid Accent 2"/>
  <w:LsdException Locked="false" Priority="63" Name="Medium Shading 1 Accent 2"/>
  <w:LsdException Locked="false" Priority="64" Name="Medium Shading 2 Accent 2"/>
  <w:LsdException Locked="false" Priority="65" Name="Medium List 1 Accent 2"/>
  <w:LsdException Locked="false" Priority="66" Name="Medium List 2 Accent 2"/>
  <w:LsdException Locked="false" Priority="67" Name="Medium Grid 1 Accent 2"/>
  <w:LsdException Locked="false" Priority="68" Name="Medium Grid 2 Accent 2"/>
  <w:LsdException Locked="false" Priority="69" Name="Medium Grid 3 Accent 2"/>
  <w:LsdException Locked="false" Priority="70" Name="Dark List Accent 2"/>
  <w:LsdException Locked="false" Priority="71" Name="Colorful Shading Accent 2"/>
  <w:LsdException Locked="false" Priority="72" Name="Colorful List Accent 2"/>
  <w:LsdException Locked="false" Priority="73" Name="Colorful Grid Accent 2"/>
  <w:LsdException Locked="false" Priority="60" Name="Light Shading Accent 3"/>
  <w:LsdException Locked="false" Priority="61" Name="Light List Accent 3"/>
  <w:LsdException Locked="false" Priority="62" Name="Light Grid Accent 3"/>
  <w:LsdException Locked="false" Priority="63" Name="Medium Shading 1 Accent 3"/>
  <w:LsdException Locked="false" Priority="64" Name="Medium Shading 2 Accent 3"/>
  <w:LsdException Locked="false" Priority="65" Name="Medium List 1 Accent 3"/>
  <w:LsdException Locked="false" Priority="66" Name="Medium List 2 Accent 3"/>
  <w:LsdException Locked="false" Priority="67" Name="Medium Grid 1 Accent 3"/>
  <w:LsdException Locked="false" Priority="68" Name="Medium Grid 2 Accent 3"/>
  <w:LsdException Locked="false" Priority="69" Name="Medium Grid 3 Accent 3"/>
  <w:LsdException Locked="false" Priority="70" Name="Dark List Accent 3"/>
  <w:LsdException Locked="false" Priority="71" Name="Colorful Shading Accent 3"/>
  <w:LsdException Locked="false" Priority="72" Name="Colorful List Accent 3"/>
  <w:LsdException Locked="false" Priority="73" Name="Colorful Grid Accent 3"/>
  <w:LsdException Locked="false" Priority="60" Name="Light Shading Accent 4"/>
  <w:LsdException Locked="false" Priority="61" Name="Light List Accent 4"/>
  <w:LsdException Locked="false" Priority="62" Name="Light Grid Accent 4"/>
  <w:LsdException Locked="false" Priority="63" Name="Medium Shading 1 Accent 4"/>
  <w:LsdException Locked="false" Priority="64" Name="Medium Shading 2 Accent 4"/>
  <w:LsdException Locked="false" Priority="65" Name="Medium List 1 Accent 4"/>
  <w:LsdException Locked="false" Priority="66" Name="Medium List 2 Accent 4"/>
  <w:LsdException Locked="false" Priority="67" Name="Medium Grid 1 Accent 4"/>
  <w:LsdException Locked="false" Priority="68" Name="Medium Grid 2 Accent 4"/>
  <w:LsdException Locked="false" Priority="69" Name="Medium Grid 3 Accent 4"/>
  <w:LsdException Locked="false" Priority="70" Name="Dark List Accent 4"/>
  <w:LsdException Locked="false" Priority="71" Name="Colorful Shading Accent 4"/>
  <w:LsdException Locked="false" Priority="72" Name="Colorful List Accent 4"/>
  <w:LsdException Locked="false" Priority="73" Name="Colorful Grid Accent 4"/>
  <w:LsdException Locked="false" Priority="60" Name="Light Shading Accent 5"/>
  <w:LsdException Locked="false" Priority="61" Name="Light List Accent 5"/>
  <w:LsdException Locked="false" Priority="62" Name="Light Grid Accent 5"/>
  <w:LsdException Locked="false" Priority="63" Name="Medium Shading 1 Accent 5"/>
  <w:LsdException Locked="false" Priority="64" Name="Medium Shading 2 Accent 5"/>
  <w:LsdException Locked="false" Priority="65" Name="Medium List 1 Accent 5"/>
  <w:LsdException Locked="false" Priority="66" Name="Medium List 2 Accent 5"/>
  <w:LsdException Locked="false" Priority="67" Name="Medium Grid 1 Accent 5"/>
  <w:LsdException Locked="false" Priority="68" Name="Medium Grid 2 Accent 5"/>
  <w:LsdException Locked="false" Priority="69" Name="Medium Grid 3 Accent 5"/>
  <w:LsdException Locked="false" Priority="70" Name="Dark List Accent 5"/>
  <w:LsdException Locked="false" Priority="71" Name="Colorful Shading Accent 5"/>
  <w:LsdException Locked="false" Priority="72" Name="Colorful List Accent 5"/>
  <w:LsdException Locked="false" Priority="73" Name="Colorful Grid Accent 5"/>
  <w:LsdException Locked="false" Priority="60" Name="Light Shading Accent 6"/>
  <w:LsdException Locked="false" Priority="61" Name="Light List Accent 6"/>
  <w:LsdException Locked="false" Priority="62" Name="Light Grid Accent 6"/>
  <w:LsdException Locked="false" Priority="63" Name="Medium Shading 1 Accent 6"/>
  <w:LsdException Locked="false" Priority="64" Name="Medium Shading 2 Accent 6"/>
  <w:LsdException Locked="false" Priority="65" Name="Medium List 1 Accent 6"/>
  <w:LsdException Locked="false" Priority="66" Name="Medium List 2 Accent 6"/>
  <w:LsdException Locked="false" Priority="67" Name="Medium Grid 1 Accent 6"/>
  <w:LsdException Locked="false" Priority="68" Name="Medium Grid 2 Accent 6"/>
  <w:LsdException Locked="false" Priority="69" Name="Medium Grid 3 Accent 6"/>
  <w:LsdException Locked="false" Priority="70" Name="Dark List Accent 6"/>
  <w:LsdException Locked="false" Priority="71" Name="Colorful Shading Accent 6"/>
  <w:LsdException Locked="false" Priority="72" Name="Colorful List Accent 6"/>
  <w:LsdException Locked="false" Priority="73" Name="Colorful Grid Accent 6"/>
  <w:LsdException Locked="false" Priority="19" QFormat="true"
   Name="Subtle Emphasis"/>
  <w:LsdException Locked="false" Priority="21" QFormat="true"
   Name="Intense Emphasis"/>
  <w:LsdException Locked="false" Priority="31" QFormat="true"
   Name="Subtle Reference"/>
  <w:LsdException Locked="false" Priority="32" QFormat="true"
   Name="Intense Reference"/>
  <w:LsdException Locked="false" Priority="33" QFormat="true" Name="Book Title"/>
  <w:LsdException Locked="false" Priority="37" SemiHidden="true"
   UnhideWhenUsed="true" Name="Bibliography"/>
  <w:LsdException Locked="false" Priority="39" SemiHidden="true"
   UnhideWhenUsed="true" QFormat="true" Name="TOC Heading"/>
  <w:LsdException Locked="false" Priority="41" Name="Plain Table 1"/>
  <w:LsdException Locked="false" Priority="42" Name="Plain Table 2"/>
  <w:LsdException Locked="false" Priority="43" Name="Plain Table 3"/>
  <w:LsdException Locked="false" Priority="44" Name="Plain Table 4"/>
  <w:LsdException Locked="false" Priority="45" Name="Plain Table 5"/>
  <w:LsdException Locked="false" Priority="40" Name="Grid Table Light"/>
  <w:LsdException Locked="false" Priority="46" Name="Grid Table 1 Light"/>
  <w:LsdException Locked="false" Priority="47" Name="Grid Table 2"/>
  <w:LsdException Locked="false" Priority="48" Name="Grid Table 3"/>
  <w:LsdException Locked="false" Priority="49" Name="Grid Table 4"/>
  <w:LsdException Locked="false" Priority="50" Name="Grid Table 5 Dark"/>
  <w:LsdException Locked="false" Priority="51" Name="Grid Table 6 Colorful"/>
  <w:LsdException Locked="false" Priority="52" Name="Grid Table 7 Colorful"/>
  <w:LsdException Locked="false" Priority="46"
   Name="Grid Table 1 Light Accent 1"/>
  <w:LsdException Locked="false" Priority="47" Name="Grid Table 2 Accent 1"/>
  <w:LsdException Locked="false" Priority="48" Name="Grid Table 3 Accent 1"/>
  <w:LsdException Locked="false" Priority="49" Name="Grid Table 4 Accent 1"/>
  <w:LsdException Locked="false" Priority="50" Name="Grid Table 5 Dark Accent 1"/>
  <w:LsdException Locked="false" Priority="51"
   Name="Grid Table 6 Colorful Accent 1"/>
  <w:LsdException Locked="false" Priority="52"
   Name="Grid Table 7 Colorful Accent 1"/>
  <w:LsdException Locked="false" Priority="46"
   Name="Grid Table 1 Light Accent 2"/>
  <w:LsdException Locked="false" Priority="47" Name="Grid Table 2 Accent 2"/>
  <w:LsdException Locked="false" Priority="48" Name="Grid Table 3 Accent 2"/>
  <w:LsdException Locked="false" Priority="49" Name="Grid Table 4 Accent 2"/>
  <w:LsdException Locked="false" Priority="50" Name="Grid Table 5 Dark Accent 2"/>
  <w:LsdException Locked="false" Priority="51"
   Name="Grid Table 6 Colorful Accent 2"/>
  <w:LsdException Locked="false" Priority="52"
   Name="Grid Table 7 Colorful Accent 2"/>
  <w:LsdException Locked="false" Priority="46"
   Name="Grid Table 1 Light Accent 3"/>
  <w:LsdException Locked="false" Priority="47" Name="Grid Table 2 Accent 3"/>
  <w:LsdException Locked="false" Priority="48" Name="Grid Table 3 Accent 3"/>
  <w:LsdException Locked="false" Priority="49" Name="Grid Table 4 Accent 3"/>
  <w:LsdException Locked="false" Priority="50" Name="Grid Table 5 Dark Accent 3"/>
  <w:LsdException Locked="false" Priority="51"
   Name="Grid Table 6 Colorful Accent 3"/>
  <w:LsdException Locked="false" Priority="52"
   Name="Grid Table 7 Colorful Accent 3"/>
  <w:LsdException Locked="false" Priority="46"
   Name="Grid Table 1 Light Accent 4"/>
  <w:LsdException Locked="false" Priority="47" Name="Grid Table 2 Accent 4"/>
  <w:LsdException Locked="false" Priority="48" Name="Grid Table 3 Accent 4"/>
  <w:LsdException Locked="false" Priority="49" Name="Grid Table 4 Accent 4"/>
  <w:LsdException Locked="false" Priority="50" Name="Grid Table 5 Dark Accent 4"/>
  <w:LsdException Locked="false" Priority="51"
   Name="Grid Table 6 Colorful Accent 4"/>
  <w:LsdException Locked="false" Priority="52"
   Name="Grid Table 7 Colorful Accent 4"/>
  <w:LsdException Locked="false" Priority="46"
   Name="Grid Table 1 Light Accent 5"/>
  <w:LsdException Locked="false" Priority="47" Name="Grid Table 2 Accent 5"/>
  <w:LsdException Locked="false" Priority="48" Name="Grid Table 3 Accent 5"/>
  <w:LsdException Locked="false" Priority="49" Name="Grid Table 4 Accent 5"/>
  <w:LsdException Locked="false" Priority="50" Name="Grid Table 5 Dark Accent 5"/>
  <w:LsdException Locked="false" Priority="51"
   Name="Grid Table 6 Colorful Accent 5"/>
  <w:LsdException Locked="false" Priority="52"
   Name="Grid Table 7 Colorful Accent 5"/>
  <w:LsdException Locked="false" Priority="46"
   Name="Grid Table 1 Light Accent 6"/>
  <w:LsdException Locked="false" Priority="47" Name="Grid Table 2 Accent 6"/>
  <w:LsdException Locked="false" Priority="48" Name="Grid Table 3 Accent 6"/>
  <w:LsdException Locked="false" Priority="49" Name="Grid Table 4 Accent 6"/>
  <w:LsdException Locked="false" Priority="50" Name="Grid Table 5 Dark Accent 6"/>
  <w:LsdException Locked="false" Priority="51"
   Name="Grid Table 6 Colorful Accent 6"/>
  <w:LsdException Locked="false" Priority="52"
   Name="Grid Table 7 Colorful Accent 6"/>
  <w:LsdException Locked="false" Priority="46" Name="List Table 1 Light"/>
  <w:LsdException Locked="false" Priority="47" Name="List Table 2"/>
  <w:LsdException Locked="false" Priority="48" Name="List Table 3"/>
  <w:LsdException Locked="false" Priority="49" Name="List Table 4"/>
  <w:LsdException Locked="false" Priority="50" Name="List Table 5 Dark"/>
  <w:LsdException Locked="false" Priority="51" Name="List Table 6 Colorful"/>
  <w:LsdException Locked="false" Priority="52" Name="List Table 7 Colorful"/>
  <w:LsdException Locked="false" Priority="46"
   Name="List Table 1 Light Accent 1"/>
  <w:LsdException Locked="false" Priority="47" Name="List Table 2 Accent 1"/>
  <w:LsdException Locked="false" Priority="48" Name="List Table 3 Accent 1"/>
  <w:LsdException Locked="false" Priority="49" Name="List Table 4 Accent 1"/>
  <w:LsdException Locked="false" Priority="50" Name="List Table 5 Dark Accent 1"/>
  <w:LsdException Locked="false" Priority="51"
   Name="List Table 6 Colorful Accent 1"/>
  <w:LsdException Locked="false" Priority="52"
   Name="List Table 7 Colorful Accent 1"/>
  <w:LsdException Locked="false" Priority="46"
   Name="List Table 1 Light Accent 2"/>
  <w:LsdException Locked="false" Priority="47" Name="List Table 2 Accent 2"/>
  <w:LsdException Locked="false" Priority="48" Name="List Table 3 Accent 2"/>
  <w:LsdException Locked="false" Priority="49" Name="List Table 4 Accent 2"/>
  <w:LsdException Locked="false" Priority="50" Name="List Table 5 Dark Accent 2"/>
  <w:LsdException Locked="false" Priority="51"
   Name="List Table 6 Colorful Accent 2"/>
  <w:LsdException Locked="false" Priority="52"
   Name="List Table 7 Colorful Accent 2"/>
  <w:LsdException Locked="false" Priority="46"
   Name="List Table 1 Light Accent 3"/>
  <w:LsdException Locked="false" Priority="47" Name="List Table 2 Accent 3"/>
  <w:LsdException Locked="false" Priority="48" Name="List Table 3 Accent 3"/>
  <w:LsdException Locked="false" Priority="49" Name="List Table 4 Accent 3"/>
  <w:LsdException Locked="false" Priority="50" Name="List Table 5 Dark Accent 3"/>
  <w:LsdException Locked="false" Priority="51"
   Name="List Table 6 Colorful Accent 3"/>
  <w:LsdException Locked="false" Priority="52"
   Name="List Table 7 Colorful Accent 3"/>
  <w:LsdException Locked="false" Priority="46"
   Name="List Table 1 Light Accent 4"/>
  <w:LsdException Locked="false" Priority="47" Name="List Table 2 Accent 4"/>
  <w:LsdException Locked="false" Priority="48" Name="List Table 3 Accent 4"/>
  <w:LsdException Locked="false" Priority="49" Name="List Table 4 Accent 4"/>
  <w:LsdException Locked="false" Priority="50" Name="List Table 5 Dark Accent 4"/>
  <w:LsdException Locked="false" Priority="51"
   Name="List Table 6 Colorful Accent 4"/>
  <w:LsdException Locked="false" Priority="52"
   Name="List Table 7 Colorful Accent 4"/>
  <w:LsdException Locked="false" Priority="46"
   Name="List Table 1 Light Accent 5"/>
  <w:LsdException Locked="false" Priority="47" Name="List Table 2 Accent 5"/>
  <w:LsdException Locked="false" Priority="48" Name="List Table 3 Accent 5"/>
  <w:LsdException Locked="false" Priority="49" Name="List Table 4 Accent 5"/>
  <w:LsdException Locked="false" Priority="50" Name="List Table 5 Dark Accent 5"/>
  <w:LsdException Locked="false" Priority="51"
   Name="List Table 6 Colorful Accent 5"/>
  <w:LsdException Locked="false" Priority="52"
   Name="List Table 7 Colorful Accent 5"/>
  <w:LsdException Locked="false" Priority="46"
   Name="List Table 1 Light Accent 6"/>
  <w:LsdException Locked="false" Priority="47" Name="List Table 2 Accent 6"/>
  <w:LsdException Locked="false" Priority="48" Name="List Table 3 Accent 6"/>
  <w:LsdException Locked="false" Priority="49" Name="List Table 4 Accent 6"/>
  <w:LsdException Locked="false" Priority="50" Name="List Table 5 Dark Accent 6"/>
  <w:LsdException Locked="false" Priority="51"
   Name="List Table 6 Colorful Accent 6"/>
  <w:LsdException Locked="false" Priority="52"
   Name="List Table 7 Colorful Accent 6"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Mention"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Smart Hyperlink"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Hashtag"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Unresolved Mention"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Smart Link"/>
 </w:LatentStyles>
</xml><![endif]--><!--[if gte mso 10]>
<style>
 /* Style Definitions */
 table.MsoNormalTable
	{mso-style-name:"Table Normal";
	mso-tstyle-rowband-size:0;
	mso-tstyle-colband-size:0;
	mso-style-noshow:yes;
	mso-style-priority:99;
	mso-style-parent:"";
	mso-padding-alt:0in 5.4pt 0in 5.4pt;
	mso-para-margin:0in;
	mso-pagination:widow-orphan;
	font-size:11.0pt;
	font-family:"Aptos",sans-serif;
	mso-ascii-font-family:Aptos;
	mso-ascii-theme-font:minor-latin;
	mso-hansi-font-family:Aptos;
	mso-hansi-theme-font:minor-latin;
	mso-font-kerning:1.0pt;
	mso-ligatures:standardcontextual;}
</style>
<![endif]-->
    </p>
    <p class="MsoPlainText">My concern is there are two ways to set
      pragne's
      granularity, both can be used at run time. It can make confusion
      to know which
      one take effect as user can use driver parameter and api to change
      granularity
      with any timing.</p>
    <p class="MsoPlainText">Regards <br>
    </p>
    <p class="MsoPlainText">Xiaogang</p>
    <p class="MsoPlainText">&nbsp;</p>
    <blockquote type="cite" cite="mid:82fe94f3-9f45-4cf4-9e52-664f7624a469@amd.com">
      <br>
      Regards,
      <br>
      &nbsp; Felix
      <br>
      <br>
      <br>
      <blockquote type="cite">Regards
        <br>
        <br>
        Xiaogang
        <br>
        <br>
        <blockquote type="cite">Regards
          <br>
          <br>
          Xiaogang
          <br>
          <br>
          &nbsp;&nbsp;&nbsp; Regards
          <br>
          <br>
          &nbsp;&nbsp;&nbsp; Xiaogang
          <br>
          <br>
          &nbsp;&nbsp;&nbsp; On 8/26/2024 2:34 PM, Ramesh Errabolu wrote:
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Caution: This message originated from an External
          Source. Use proper caution when opening attachments, clicking
          links, or responding.
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Enables users to update the default size of buffer
          used in migration
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; either from Sysmem to VRAM or vice versa.
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; The param GOBM refers to granularity of buffer
          migration, and is
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; specified in terms of log(numPages(buffer)). It
          facilitates users of
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unregistered memory to control GOBM, albeit at a
          coarse level
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Signed-off-by: Ramesh
          Errabolu<a class="moz-txt-link-rfc2396E" href="mailto:Ramesh.Errabolu@amd.com">&lt;Ramesh.Errabolu@amd.com&gt;</a>&nbsp;
          <a class="moz-txt-link-rfc2396E" href="mailto:Ramesh.Errabolu@amd.com">&lt;mailto:Ramesh.Errabolu@amd.com&gt;</a>
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ---
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu.h&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 4 ++++
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 18
          +++++++++++++++++
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp; drivers/gpu/drm/amd/amdkfd/kfd_priv.h&nbsp;&nbsp; | 12
          ++++++++++++
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp; drivers/gpu/drm/amd/amdkfd/kfd_svm.c&nbsp;&nbsp;&nbsp; | 26
          ++++++++++++++++---------
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp; 4 files changed, 51 insertions(+), 9 deletions(-)
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; index e8c284aea1f2..73dd816b01f2 100644
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; @@ -237,6 +237,7 @@ extern int sched_policy;
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp; extern bool debug_evictions;
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp; extern bool no_system_mem_limit;
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp; extern int halt_if_hws_hang;
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; +extern uint amdgpu_svm_attr_gobm;
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp; #else
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp; static const int __maybe_unused sched_policy =
          KFD_SCHED_POLICY_HWS;
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp; static const bool __maybe_unused debug_evictions;
          /* = false */ @@
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -313,6 +314,9 @@ extern int amdgpu_wbrf;
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp; /* Extra time delay(in ms) to eliminate the
          influence of temperature momentary fluctuation */
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp; #define AMDGPU_SWCTF_EXTRA_DELAY&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 50
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; +/* Default size of buffer to use in migrating buffer
          */
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; +#define AMDGPU_SVM_ATTR_GOBM&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 9
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; +
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp; struct amdgpu_xcp_mgr;
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp; struct amdgpu_device;
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp; struct amdgpu_irq_src;
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; index b9529948f2b2..09c501753a3b 100644
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; @@ -169,6 +169,17 @@ uint amdgpu_sdma_phase_quantum =
          32;
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp; char *amdgpu_disable_cu;
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp; char *amdgpu_virtual_display;
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp; bool enforce_isolation;
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; +
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; +/* Specifies the default size of buffer to use in
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; + * migrating buffer from Sysmem to VRAM and vice
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; + * versa
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; + *
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; + * GOBM - Granularity of Buffer Migration
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; + *
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; + * Defined as log2(sizeof(buffer)/PAGE_SIZE)&nbsp; */ uint
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; +amdgpu_svm_attr_gobm = AMDGPU_SVM_ATTR_GOBM;
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; +
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp; /*
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp; * OverDrive(bit 14) disabled by default
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp; * GFX DCS(bit 19) disabled by default @@ -320,6
          +331,13 @@
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; module_param_named(pcie_gen2, amdgpu_pcie_gen2, int,
          0444);
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp; MODULE_PARM_DESC(msi, &quot;MSI support (1 = enable, 0 =
          disable, -1 = auto)&quot;);
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp; module_param_named(msi, amdgpu_msi, int, 0444);
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; +/**
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; + * DOC: svm_attr_gobm (uint)
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; + * Size of buffer to use in migrating buffer from
          Sysmem to VRAM and
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; +vice versa&nbsp; */ MODULE_PARM_DESC(svm_attr_gobm,
          &quot;Defined as
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; +log2(sizeof(buffer)/PAGE_SIZE), e.g. 9 for 2 MiB&quot;);
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; +module_param_named(svm_attr_gobm,
          amdgpu_svm_attr_gobm, uint, 0644);
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; +
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp; /**
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp; * DOC: lockup_timeout (string)
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp; * Set GPU scheduler timeout value in ms.
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; index 9ae9abc6eb43..c2e54b18c167 100644
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; @@ -868,6 +868,18 @@ struct svm_range_list {
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct task_struct&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
          *faulting_task;
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* check point ts decides if page fault
          recovery need be dropped */
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
          checkpoint_ts[MAX_GPU_INSTANCE];
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; +
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Indicates the default size to use in
          migrating
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * buffers of a process from Sysmem to VRAM
          and vice
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * versa. The max legal value cannot be
          greater than
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * 0x3F
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * @note: A side effect of this symbol being
          part of
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * struct svm_range_list is that it forces all
          buffers
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * of the process of unregistered kind to use
          the same
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * size in buffer migration
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint8_t attr_gobm;
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp; };
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp; /* Process data */
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; index b44dec90969f..78c78baddb1f 100644
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; @@ -309,12 +309,11 @@ static void
          svm_range_free(struct svm_range *prange, bool do_unmap)
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp; }
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp; static void
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -svm_range_set_default_attributes(int32_t *location,
          int32_t *prefetch_loc,
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint8_t *granularity,
          uint32_t *flags)
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; +svm_range_set_default_attributes(int32_t *location,
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int32_t *prefetch_loc,
          uint32_t *flags)
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp; {
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *location =
          KFD_IOCTL_SVM_LOCATION_UNDEFINED;
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *prefetch_loc =
          KFD_IOCTL_SVM_LOCATION_UNDEFINED;
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *granularity = 9;
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *flags =
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; KFD_IOCTL_SVM_FLAG_HOST_ACCESS |
          KFD_IOCTL_SVM_FLAG_COHERENT;
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp; }
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; @@ -358,9 +357,9 @@ svm_range *svm_range_new(struct
          svm_range_list *svms, uint64_t start,
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
          bitmap_copy(prange-&gt;bitmap_access,
          svms-&gt;bitmap_supported,
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MAX_GPU_INSTANCE);
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; prange-&gt;granularity = svms-&gt;attr_gobm;
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
          svm_range_set_default_attributes(&amp;prange-&gt;preferred_loc,
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
          &amp;prange-&gt;prefetch_loc,
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
          &amp;prange-&gt;granularity, &amp;prange-&gt;flags);
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
          &amp;prange-&gt;prefetch_loc,
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; + &amp;prange-&gt;flags);
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_debug(&quot;svms 0x%p [0x%llx 0x%llx]\n&quot;,
          svms, start, last);
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; @@ -2693,10 +2692,12 @@
          svm_range_get_range_boundaries(struct
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfd_process *p, int64_t addr,
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *is_heap_stack = vma_is_initial_heap(vma) ||
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vma_is_initial_stack(vma);
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Determine the starting and ending page of
          prange */
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; start_limit = max(vma-&gt;vm_start &gt;&gt;
          PAGE_SHIFT,
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (unsigned long)ALIGN_DOWN(addr,
          2UL &lt;&lt; 8));
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (unsigned long)ALIGN_DOWN(addr,
          1 &lt;&lt;
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; + p-&gt;svms.attr_gobm));
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; end_limit = min(vma-&gt;vm_end &gt;&gt;
          PAGE_SHIFT,
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (unsigned long)ALIGN(addr + 1, 2UL
          &lt;&lt; 8));
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (unsigned long)ALIGN(addr + 1, 1
          &lt;&lt;
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; + p-&gt;svms.attr_gobm));
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; +
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* First range that starts after the fault
          address */
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; node =
          interval_tree_iter_first(&amp;p-&gt;svms.objects, addr + 1,
          ULONG_MAX);
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (node) {
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; @@ -3240,6 +3241,12 @@ int svm_range_list_init(struct
          kfd_process *p)
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if
          (KFD_IS_SVM_API_SUPPORTED(p-&gt;pdds[i]-&gt;dev-&gt;adev))
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
          bitmap_set(svms-&gt;bitmap_supported, i, 1);
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Bind granularity of buffer migration,
          either
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * the default size or one specified by the
          user
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; svms-&gt;attr_gobm = min_t(u8,
          amdgpu_svm_attr_gobm, 0x3F);
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_debug(&quot;Granularity Of Buffer Migration:
          %d\n&quot;,
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; + svms-&gt;attr_gobm);
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; +
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp; }
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; @@ -3767,8 +3774,9 @@ svm_range_get_attr(struct
          kfd_process *p, struct mm_struct *mm,
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; node =
          interval_tree_iter_first(&amp;svms-&gt;objects, start, last);
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!node) {
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_debug(&quot;range attrs not found
          return default values\n&quot;);
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
          svm_range_set_default_attributes(&amp;location,
          &amp;prefetch_loc,
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
          &amp;granularity, &amp;flags_and);
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; granularity = svms-&gt;attr_gobm;
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
          svm_range_set_default_attributes(&amp;location,
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
          &nbsp;&nbsp;&nbsp;&nbsp;&amp;prefetch_loc, &amp;flags_and);
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; flags_or = flags_and;
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (p-&gt;xnack_enabled)
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bitmap_copy(bitmap_access,
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; svms-&gt;bitmap_supported,
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; --
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2.34.1
          <br>
          <br>
        </blockquote>
      </blockquote>
    </blockquote>
  </body>
</html>

--------------VSdsmt0PY5zZ0I5IwnUBqtVK--
