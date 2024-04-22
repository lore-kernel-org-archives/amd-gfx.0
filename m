Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 425D4C07C79
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Apr 2024 11:30:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D1A5D1129F7;
	Mon, 22 Apr 2024 11:30:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vo2TjcMt";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2084.outbound.protection.outlook.com [40.107.244.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C81941129FA
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Apr 2024 11:30:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GOftZjP1q9kA+6EuJeD07Kx7UaUwgPODsLAAG0gChnWZmyXpOSUNTnOOkuy6CnvUaVRwfQFmWaHhofWLnqgWDErtMlipiardM4ai5+LtElzqhNooXvFHASJuVJwThmmM7XqvPzh1lX+uCteskBgQM5LfCWZtBByQhJEmdsqwe+cdLWn2bOdfMMK5r8Slmd4f8iOjWoWrdb1aAjMSQWKfIGiNcSsN0JnHUvKDZ5ik3Lpl4eTNafvz8/l0npxWRQmZY730KOAFned7Gg31jSikIAFZiLY14Di23oiPNqhIqUojYlvr3gi1Jppm0J1JVPf9Jr3V371Orpf0LeNrqXes7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eiVcsYcRWF0ntFPtXEugZxVp9nfGBRI6naOqIlW+m0s=;
 b=KoIlIKB7SvjdxKpwhbypXvQyLllUlgovaTBdkGXqCXWh4fBir+fVSxuzzdt8bJIHKxEDclI/nSgD8kK6ea+GmiTmACUMLZ/4rusmfnjpvzNvxz64gXF3AW32Wy9JHPkX09lg7RO9MbWWBs5Pw8EzmGApvNwHpS/bZvplxP4f9j4JlC+ZGpk9PMPo54A6Gy/exni0UUa5kwxDhu42yDP58A75gKYihjU9Nu3zhgom9pQ/KzBXO0L4KahBg+Mjap7ikpRezlW3XUKQnCiRnFCaYVNizQMxGfvFekPE++JjlTmgULgfYvAQ3osC4SllaX3h+KBLk1jyReqMUt5zQQee8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eiVcsYcRWF0ntFPtXEugZxVp9nfGBRI6naOqIlW+m0s=;
 b=vo2TjcMt/Yc+He3kXXV/V8G1HlL49VagYhh/JA4riTnuyYuXpJk3hgScz0WwQ6umm0zhLwxBrKRHEf21f5/CG9NWJXP+hyZuctNR9AEgHageFRoRQH6BVN7EbN3Q3KYMOS9Nu58BYKbX5OMz3LlWZT7YeKC/RttjhQBgjNGwKXQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SJ0PR12MB6992.namprd12.prod.outlook.com (2603:10b6:a03:483::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Mon, 22 Apr
 2024 11:30:20 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::f2b6:1034:76e8:f15a]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::f2b6:1034:76e8:f15a%6]) with mapi id 15.20.7472.044; Mon, 22 Apr 2024
 11:30:20 +0000
Message-ID: <466e3fa9-f10d-468d-9bc7-b9c4836d4577@amd.com>
Date: Mon, 22 Apr 2024 13:30:14 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amdgpu/mes: fix use-after-free issue
To: "Lazar, Lijo" <lijo.lazar@amd.com>, Jack Xiao <Jack.Xiao@amd.com>,
 amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com,
 Hawking.Zhang@amd.com
References: <20240422093931.3823889-1-Jack.Xiao@amd.com>
 <198a359c-f9c2-4651-8367-36f5d4a51494@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <198a359c-f9c2-4651-8367-36f5d4a51494@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0353.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f4::16) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SJ0PR12MB6992:EE_
X-MS-Office365-Filtering-Correlation-Id: 62f7063d-b4a1-46ff-e96b-08dc62bf9761
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?N2ZzU1NWSmRJbWVnS2x4cnhsRVhvV1JlSTVKbVZqdytQNDJzUmZXREVYVXE3?=
 =?utf-8?B?QXJ0bG4zRHpDektQOHJzSDcyamM0NC9qWU0vTnczcTdZdVZGVzJXOGxpcklu?=
 =?utf-8?B?UkdMc2E4dlBJRmhjODNtTkZ5RVd5UVpMVndqb1NiUU5YTFFZbkFZeEV6bEt2?=
 =?utf-8?B?YnpVUmJBMzA4V0dhRC84dThOUk1iVUJCY0hPTFpLUDBEVlJpV1k2NGRyeWcz?=
 =?utf-8?B?dmo2b25QMFUrVGY5T0ZPTFQ3UWlVVDhyUG12OWI0T3pHYWRTWVcvZzVSZU5a?=
 =?utf-8?B?eWxRc0Z4K0V0S2ZMQmNJc0hLMkR3WjU2TkViNHVSUzVmdWg3cHBPZCtVanRn?=
 =?utf-8?B?VXNLcGFzamJvQU5zSXlqL2Rid1FSM0tDVnhaNDN1bXg1cWR2WHdyTkZpZEVt?=
 =?utf-8?B?Vy9UVk95alg3UzhYQi9UdndOc0NQSnhrNEE5eFZ2N09uNGFkNThzL2Jsa29k?=
 =?utf-8?B?N20weDBmbENaVjBYc1V5OHBIcDA0Q0Q5S2VialNMd0dpZ29UMXVQTG9VejFM?=
 =?utf-8?B?SHVZR3lNQ0xndnpTSFBEbys5MU9XT3FwY2kvMGIzTENKNEw5c1RlOU1xYWpF?=
 =?utf-8?B?blViSHVqeHMwZWV2d3puMTFJN1NLNmI0SC9nNEdNZS9TSkVnR2hXVm0zSm41?=
 =?utf-8?B?cHZTbjRsY2t0VnFkeEpLNjcrUGFDK3B3eHZVeGx5YXNiTWpjVnBvU01RcE56?=
 =?utf-8?B?V1QvbFpaaUtpaExtM3FLcllnZ0poRXhTR0VGV1BISnBBdXVsaHZIV2Y0RXBR?=
 =?utf-8?B?R3Z1aHZ3MGwwb05DTmhhQXRFWkZ5TWIwRkFncnh0eTlIUEJMMjQzSy9JMm1U?=
 =?utf-8?B?a2dyTGYyeGE2YWFXcXNiWThaRExPeXhnR0RQU3pKLzJ2K05lWW4rcFg0NVNk?=
 =?utf-8?B?dk9wUGFiU1NYaEh2U2ZvajF5TGV6WWFDYkp5Qithbytmb0ZFc2xxMkFzejlZ?=
 =?utf-8?B?dlZRU29LZXVpaG1GbkhFZEdYYTVJOGhob2VTeEtsdS9XcGpOcXZ6Uk5SVjVS?=
 =?utf-8?B?LzlRQXFtekQwOWFuOHlhb3lNOXFWTFkrMkpGYmUyaE5uOFh6ci9SMC9zcWxV?=
 =?utf-8?B?aEFtY3J1dU44ZFhEaVNsODM4Mk1LQmpRMmN4bHJZbFozT1cxZjdteWpYT2Nw?=
 =?utf-8?B?REE2NkZhdlR4S2w1ei9vdUgxUHprSEI3WW5tNEM1ekJXS1JWN1F4Zk4rcXBB?=
 =?utf-8?B?QlJUMjBRV0pDM2Y5cWx3L0JwVkxiZHkxS2VNSkZBWFBGVGNjblpYbHBKTjZl?=
 =?utf-8?B?TmRyYlliSVFlL2xMKzFndG9pc0VWVVNnT3BvdGxoeERtanRXaWJNMkpGdWhl?=
 =?utf-8?B?MG9GMVJUMDF3S092ZjFyV2JKKzB0K2w1RmdiYjM3TElNbFdackdtekdpRVRQ?=
 =?utf-8?B?bGpMYzJLU1NRWHhiRlhUM1c0ZDRheEJOZGp3QXFOeWhFcjc4UTBSU0xkc2Uw?=
 =?utf-8?B?SEk4d0lvVFpmVE5ZSzkyL0R4RnZocVoxMkFNZ1dYRS9taytUWVYra0RRYzZm?=
 =?utf-8?B?Zk9HTzF3MmdDKzFSempLbWtUb3hYMlNaNVA0TWRtcWpveEM3MEYzYldrZFNW?=
 =?utf-8?B?cEJpM1VSSy9jYmZTMXJSQ2xJWWI0RG40RDBZWDBWL21XTUJKMy9EMzJKUlgr?=
 =?utf-8?B?TUdqVWoyeW40QmJmMkM1L1FkZlV1SnhSdkxmVEhyclhrZ2ljV2dCUCtBR011?=
 =?utf-8?B?UkwvcDJGN1dmV1ZYUGhHNm5ENGROMm0zbldoSXhFNE9oQkUyKzlqQTBRPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(376005); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c05mdC81QkFkdXJSczhhdU92KzFyM01SSzU3L1cxQWpNRXUwbkhtOTdSSDht?=
 =?utf-8?B?RnpDd0g5WlB2S0syeTdUK2l4dDVTUU1wbEVXK3NkMThoblZkSzhPZ3JCT21M?=
 =?utf-8?B?QllyZlB0LzNLWG9YOWR1bGR2OEFDNEY5SktmcXY0Z1pzdzRSVlZjK1dXUXRz?=
 =?utf-8?B?VXYwUnBkd3Y2U0lkcVJkYlZRMlIyZkw1cHY3L1hhNGJSQUNyK0FqblhJZkdD?=
 =?utf-8?B?S3ZUUklkNUFSWnZhL2RrUlpaUUwzOTRSRXZqemJld1lHQXhnTWVBSHdzdHM4?=
 =?utf-8?B?YmJjclpWTkZmVTM1SnZuU1NJVHNCOVEzc2VOYkJ0UUZ3K2lhRk5POFAyK1lT?=
 =?utf-8?B?bGdnaGpBUGZvTDBHbWhvN2pLTndxNWFVbFpWRDRSek5rWFhPZ2lWQlA5VDdQ?=
 =?utf-8?B?UmEwT3lKZnl0T3hzeC8vdi9XcFQyNGhjNVhPa1BaT29TYlhRaXAvcTlTcEFh?=
 =?utf-8?B?Sm5mRjJKRE1sZlVBVE9sSlQxd2xZQXZUeFg3K0lqYkowU2JNS2w5VkNMenBw?=
 =?utf-8?B?ZGZjZVRvTFhuZlcra3BYdTB3UlU4WHZjZmEyY0FvRFFodWV1aVc0WjFCY3lT?=
 =?utf-8?B?MVIwRWZYbk1Icyt1NkMzNTV2RUt1NFA1ekczM0hlMTVBczBVVjR1NjkrVHBn?=
 =?utf-8?B?TUwyWUxtaUREVEc5YWpwd052VjNyRXFNNzZNY3M0RUdaMVBJMnZWdU5OMTly?=
 =?utf-8?B?WEZaQTlvZVJ3UWlDRU1vUUx6S1FvVlNhaHM2bHZoenVMdS85SWUvNFdGMWhr?=
 =?utf-8?B?RC95TFBMTzlscmUvQmo1d3ZkbTlVTVZGS1N2V2R5aG04L2I0bUJ2WlpnWU5Q?=
 =?utf-8?B?clJKU0g4ZzFFTXdMNmRKeU9FaVovMXNvQ3luc1UxMVduZzJHV2xPYjVhYU9m?=
 =?utf-8?B?VFltMjlTTFRMVUtPd2Zja1p6bzVPVWNkVlY4YTYyRXE5Y3ZHM2duUVVnYk5P?=
 =?utf-8?B?OUg3d0llakd6RlVQeUdlRXRFSjBkNDFKTk1vZ1JrTnRDR0dtUThVV1lWR2wv?=
 =?utf-8?B?am9rcGlZTkptajMyWHJlc3J4bWZHRU8wYzQyajFwdHMvMzJtcGEvM0hUNHhU?=
 =?utf-8?B?Q3pCOTBqRmtkTXc2WXdiZkNMTk1rMXYvMFpXSmx5dTJvTDQvbGVpZkpNVGpp?=
 =?utf-8?B?R1VZcE5TM1RHSlVYRWx0SEpHL0gxV0JrZnVTcWh3SkZ4ZWc1N3NPcHlKZmFK?=
 =?utf-8?B?b3Zic0lJMWwxWjJMSndRRC9qc05ZUDRDS3kwOEgzVDZwY3VlREdCTFk5c2pj?=
 =?utf-8?B?SjBDYXdHTUhMeGpzb2FKSGVGRlVaM1pEV2diVmFmclloa2ZWYVlxRk1qUGJZ?=
 =?utf-8?B?NE5ZYTY1TDBTQVVPNzFPZW1HSVFheitOdFllcktJOWdUWU5jVVFTTjZHa1B6?=
 =?utf-8?B?QnRuMzNOMWU3VzdaNHRMd1RVRkgzNVNHVllBWmJ0RDlvLzJjUFJsZHdlVlBP?=
 =?utf-8?B?WVZINC9Zald6aWRPdVRtKzI0WmVxanMzSUFmVWJNOHZ0ejQ0QzQrczBpVzQ1?=
 =?utf-8?B?MCtNd0pNd0M5eDl4MXhwekRBZVJRTUVvQ2RKdWpJRlVHVjRFNzVicWNwSEtp?=
 =?utf-8?B?eUVpV1czNEx6YXpsN244Um84cnVjWUx6OGF4RmdaWEltckZCTWZOamQvdEw0?=
 =?utf-8?B?dXZ5ZTh3dzBzOWF0OCtuK3JacUduOTVXZGVVTEZKNVN4NXRiTlN6eElRbkFt?=
 =?utf-8?B?VXNuSU1GakwrWkM1MHo5Mk1yUk5US1FwV0hxemlCWStvZE1BTFZ1ZkJSaGhY?=
 =?utf-8?B?aHQ3TFREOVFqemN3dGU1ZmVSUXg0ZExBSll5d2ltYW51czBtTXYwa3dCRnlm?=
 =?utf-8?B?QjNTYVVKUnpuZDNzSjJSZW1KK0hFTmFaeHNpTFUrdWZpRzRLVFpHUUcwUWZz?=
 =?utf-8?B?MVhrQXB1alFWajFYMWVyRDgzaU4vamlmek03cUpVS3NtYklxSldieFBDQmZi?=
 =?utf-8?B?S3ViNWFBMTV3alYzSkhiS1ZNU1J5cC9ZaDN0UFRBdnZQUzZ1LzRCUCs3OS9V?=
 =?utf-8?B?UEJtajFTbW80eWpPZEY4N1RyZ0hmdGxuTXhLL05yZzYyWjJHL2dDdlMzMFMz?=
 =?utf-8?B?UkU5azhOb05mTjQ1S3kvYmdKejBuTUg4NE1aMXhlZVkyQzlZT3EzYXU1TGJm?=
 =?utf-8?Q?7xO6NYB6RzWCH7wolcnP2i0UX?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62f7063d-b4a1-46ff-e96b-08dc62bf9761
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2024 11:30:20.0217 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ijguEIVE9RKcBq4VJ5mk1LGeGVp4MBjTtyZ3ljaLw1TkOrzLZb26dDVbr5Yh1eT8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6992
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

Am 22.04.24 um 13:12 schrieb Lazar, Lijo:
>
> On 4/22/2024 3:09 PM, Jack Xiao wrote:
>> Delete fence fallback timer to fix the ramdom
>> use-after-free issue.
>>
>> v2: move to amdgpu_mes.c
>>
>> Signed-off-by: Jack Xiao <Jack.Xiao@amd.com>
> Acked-by: Lijo Lazar <lijo.lazar@amd.com>

Acked-by: Christian König <christian.koenig@amd.com>

>
> Thanks,
> Lijo
>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
>> index 78e4f88f5134..226751ea084b 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
>> @@ -1128,6 +1128,7 @@ void amdgpu_mes_remove_ring(struct amdgpu_device *adev,
>>   		return;
>>   
>>   	amdgpu_mes_remove_hw_queue(adev, ring->hw_queue_id);
>> +	del_timer_sync(&ring->fence_drv.fallback_timer);
>>   	amdgpu_ring_fini(ring);
>>   	kfree(ring);
>>   }

