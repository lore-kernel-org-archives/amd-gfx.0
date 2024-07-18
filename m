Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C82AC3DA49
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Jul 2024 20:48:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D6DF710EB15;
	Thu, 18 Jul 2024 20:48:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="VTsZmiz2";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2081.outbound.protection.outlook.com [40.107.96.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D2E7E10EB15
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Jul 2024 20:48:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U81BEBRYptV+Ea1X4JRvyIOw+VypnbsjNQO07huz6jWdR43MXHRD9r82BhHfRqls/+agiWOIA5YsZ43G+8E/2dX4PwxUs/xhP/2CPsWvjcu17XY6MfqdqbcZ6Kp00Gf1JnYFaf8szsthaELTOfR6GnCREO5SnfRCUBxDBhtAkJJ+NLTOexpX43+gH2FK6qfy9G1viHyfDvgxfqc4l+kaGHLwbt5VfFZIzSHNJhH+7rM0/L9w7Q3kRByoJWhJtLaKf09Bk72SWTlBvdvGj1Qd4X8OGvLRHNxXvrSWfPGVr7jOD0ytkmSQ09oDGFeymZhuCvM+A6hWY9mAcQDlRe13Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J5nyP5EVGz+r4RGtzfcCTUrcksteoLFhpbqqjYV+vNA=;
 b=AnJEIb8s2FWmazjYViM8F2Zuw6dgo7pd/t0HEn1PGuX6FIlGXbPoKxdU6Z1jAWZZ/n+sLDYcUcBKp7W71xFWiqsBr819zIo1NmujXTnKZUS0lH4S/+Yx3gmh/s/avPNxtvwfQwSU4QOE7HAgZlIr96aZ3RCaDbVX3EoG8rjfN476xcFwg1TY5hYATtBnGxuyahxeK8Ys8kAMskERFv2xJOIu2m+OgJUNljXGyW74vYBuF/z9gKPlWtxLE9z+tQFlPzCUe0QvLI7DiqYNy7PrDO6Nu1pHUNZSICy2vO/0NagV8uHqOcYKP/K9P6KTlVvI1Badvv06TeXH45uxprI6dA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J5nyP5EVGz+r4RGtzfcCTUrcksteoLFhpbqqjYV+vNA=;
 b=VTsZmiz2RTHys+46n9uhBKv1Jcw8A1LEytq5qC3eVRV0UGvPuTvRAAsJGYa28nHCKsvmQUMOQBB194hNhy6Jbe/CVfZSI9NWOvFkg2R5MLNQ8J29SYzP7C2xFiBiBGQQDTfB95LisK7xKgvK1gQCq+QBh5KJvrLBEr8yR9xLJDw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by DS7PR12MB6072.namprd12.prod.outlook.com (2603:10b6:8:9c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.28; Thu, 18 Jul
 2024 20:48:47 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81%6]) with mapi id 15.20.7784.016; Thu, 18 Jul 2024
 20:48:47 +0000
Message-ID: <aa875495-d7ab-4fbe-9fc3-214d1c321932@amd.com>
Date: Thu, 18 Jul 2024 16:48:44 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/9] drm/amdkfd: Refactor queue wptr_bo GART mapping
To: Philip Yang <yangp@amd.com>, Philip Yang <Philip.Yang@amd.com>,
 amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, christian.koenig@amd.com
References: <20240715123502.7013-1-Philip.Yang@amd.com>
 <20240715123502.7013-4-Philip.Yang@amd.com>
 <478a13e5-2a72-4a43-8a68-10117c1a0f6f@amd.com>
 <7506ba1f-27c3-3868-3c42-64b3094a84ee@amd.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <7506ba1f-27c3-3868-3c42-64b3094a84ee@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: QB1P288CA0023.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:c00:2d::36) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|DS7PR12MB6072:EE_
X-MS-Office365-Filtering-Correlation-Id: a111acbb-7074-4f7c-8728-08dca76b051c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WXZzc2h4VW5rZGdxOElMYzVwK2tuUlNYaDdMQURDanluNnJxYnJJOTB5d2VZ?=
 =?utf-8?B?RGwvVUVDV2F4NnBIYmd0V2pDdS9XZkoyamlkZ01YSy9GMXhhZStqT1MzcU4y?=
 =?utf-8?B?UktOMk1xSG12UEZZdHNMZS9TVGRPTmNpNHFMeTJyeVB6L3NDeWdRcm5jczVE?=
 =?utf-8?B?WS84emxqcTg5ZFZsNlRteG85Uk5VOGM1RWE3M3VJV1NuQTNWUEoreEVwZ3ZK?=
 =?utf-8?B?TGsxclI1M3dWNE15ekJZMXp3NU05bFBKSFVRMHA0L094UmZOQm5aTU8vNjhn?=
 =?utf-8?B?dERTUmZqbU1pVDJacStWSEgreWljTFJPS3IrVkJ6a2RMdFNIc2lLOHVlbUN6?=
 =?utf-8?B?Z0FJMmgwZ0g5ZW9sbm1hVEhNSU9XNGlJaHdNTjNCU3ZGYzJ1K1pqWml3Tzli?=
 =?utf-8?B?MlpnUER5d3NBSm91VWJuMlY1c0tHMEtYL2xuUTdyQWx4ekcwYVlxZ3kxVXlF?=
 =?utf-8?B?ZDJXdWxmTmQ3b1hlZndVUEpaL1g1VE4xWGJlNjFXTUpiYmdyc1dPVGluc1lV?=
 =?utf-8?B?cFlRTS9sRWhlM0VnY1I1UExoQVlBT3JwdGtYV2Iwa2hPOFFQam9haXdNekFI?=
 =?utf-8?B?dmI4a0dYc0ZQNjJYWWtVbjZ5RXhPTytZQ0daZW81Q3VLeW1LNURpTmxiaUI3?=
 =?utf-8?B?SGx5SjNQZ05SZFpoOFdScGxnN1lpQXVIckVvYjNHRmhOT0dHTnZPYjh3Y2tY?=
 =?utf-8?B?bWZlU1ovZkw2a3BoTkFwU3VBRXlEdkJYa04wcU51L3RCMmFJSEo0NjA0YWZD?=
 =?utf-8?B?YjRsbWhQbkZEVHJmMzg5a3Y2T0dLVHBsb1VhRWZyclRVWG5hNUYya1ViM0Ji?=
 =?utf-8?B?Nm8rRUsvNitzL3cvbEM5ZGZHcW50MTg0NEVpbmF5QUt5YkhyWDhwNEE4Vnh2?=
 =?utf-8?B?emQzOVlOejdrR0RDa3pMckk3RURRejFBSmFGTVo5VHNFT21wOGk2S242dnV6?=
 =?utf-8?B?K21TR3k4RERpWG50SnFLOTc1cGU1Z2l3a1VSRnRhVWw0ZjhjUy9SRlNBMitG?=
 =?utf-8?B?MFAxUWJ5R2hERENZL0p1RlF5eitKczhMZHV6eCs1UlYyak1kcVRIVDBFV1Jt?=
 =?utf-8?B?THI2U0hjY1k0ejNTbkw5V1NEa0tOVzlzRzdUd3JZUWpWYlVmb25HMThxMS9m?=
 =?utf-8?B?aStLNzVUcSs1dFJ5ZWJwUTJRNFRld3NxamV5WVFGWmhLajBZMXNSMi9SajBh?=
 =?utf-8?B?SnVIbzY1djlUYjErdjFsSnFBUGJZNW1RUE5ScnUvSnRQT0dzUkpkKzdJNGZl?=
 =?utf-8?B?c2VUTzJpSkxrRUJQbHZvN3VTbU91a2JYczVydERtR1Nidlc1RUVkQk93ZVVB?=
 =?utf-8?B?c3k4ZExZb3dEQmpwejEwRkJnWjRyaFVNZ05SS3B5RENReGNJZ2Q0UDRQSHdJ?=
 =?utf-8?B?ZE16OUxVOFFBelc4WEFwbVVnRDJBR1orZENlZDJDZ0RxVmZZYXpwOFhmaVNM?=
 =?utf-8?B?KytDT0k5WTM5R2p0bm9EVEhvbFVrUGVhaVY2d2NhVW9pVEl5WFpDMDQ4bjZ0?=
 =?utf-8?B?RG9NenVLN3VyaXBYeWVwSHNFNU5pRk5McmVmMko4UzFXT2tBZ2dIUEt4QURI?=
 =?utf-8?B?aUdIODdmNzA3WFVETmY5UExJa1FralFBQzFRV292VEJBN1p3YUZiemprT2pP?=
 =?utf-8?B?NWhqejMxbGMzTkFJZXdKMXdFZHNBUWZUWmFLOUhnRGo2eHhLcXVvU3EyYWZv?=
 =?utf-8?B?QnRnQlA3LzdlR0tWQ3luc2d4aSs4Tlpqanc5bW53QUF1UzdTR1VCZGYxcDFF?=
 =?utf-8?B?ZWovQTFiSFIvZXlMTmlUL2lZR2hTK1JDMjllejB3Q2pOMUxTUWsxN3VPSEc4?=
 =?utf-8?B?cVdTT0hIUUNLbFljNGxwZz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VTJ6aVd1cWpSeWJENHkyQ3RySXZLdnJUeWxTR2txcC8zeFBTZXA4V0ZscGpn?=
 =?utf-8?B?WWxjdXp1V0xUdWsyN09vTDArSUFuUXNLZ1kzeUxyRElVaTZvWFVPQmh0c05N?=
 =?utf-8?B?emF4N3ZLalJMY2R0YTFyUmNZZ1lid1ROQUFKYkloTWMycjZCQkdKd2ZTWktz?=
 =?utf-8?B?QWhNTTA0TWRldUdsTW44OXBNVmJXeWN1S1VnTWNHamNJazYwdUZucmpTeC93?=
 =?utf-8?B?T1ZQeXJObnBmVndKS0dzS1FkRi9OczhNZ3JwWCtzUFYzR0djY3B6Y0VyK1No?=
 =?utf-8?B?RXIwVUpvWXhPS05BWjltRlBvbUprZTZQNUxoZ0xOMko1NXlMMEFZWUh4Rkpu?=
 =?utf-8?B?RmxMYjdLRUNxQkVjK0pIdVVITjk0cHR5bjg5Vk5yNEFWN3RwZDJPR1NSdzFU?=
 =?utf-8?B?bFV0OUVGa09lcHAvWGZqR1JFVXRVN3hreUFPY1VWSHd0alphMjdsUDJ5UktX?=
 =?utf-8?B?RTI5amQwNGpkMXlnUnJsU3VrT2pTVE5NeHpLdnlYdFR4MldWTlROV2k2aFN5?=
 =?utf-8?B?amd6aFB6VWFwTzlMbzlNNGhrUk0wOVQ1RTBXU1JhMXdjNUhxWFpERDdsZlZh?=
 =?utf-8?B?SWFDTnlLend3VksxR1BkL1IzSTNwU2lZeGtHRXQ0SFB5VXZxM1Ntays5VCtq?=
 =?utf-8?B?aVdyejEvbGIzT2o4KzM1Y2JYL29ROHJGWGhPSGllT0x6S3RyTUIybmdRVE12?=
 =?utf-8?B?YVYyWDJncGZTVjErSExmUnczLzRBOXNuVHI1aEhPaFhIRWNmNWNMeWNLRzZV?=
 =?utf-8?B?eFdBQThuM21VbDJ3TFNHNWJPSGl6eW0zUmc0Z09Zdk9yeCswV2RIbHhDK1g2?=
 =?utf-8?B?R2JjU0U5N1dQQVdDZFdLUXFzNEhEQkZHQXdMMFJVMUUrUk9pck9lZEt3TnQz?=
 =?utf-8?B?ZzBWTzRZaGJjR250eW12ODBPTjdWLzQxbGhSMkFDeGJ1aHl3YUt0YjM1UXlv?=
 =?utf-8?B?U1JnTVNob0krTDM2RHB2d3VrVHlGdEJCV0xSQUtEMkVaODV3K1pmenl5b0dJ?=
 =?utf-8?B?ZXE0NHBMc0ZwUDhlWTF3MmQvWmhJK1Q2SXh2Qzh6SlB1Z1MrelUyeEZHalJo?=
 =?utf-8?B?Unh6NFVrWFJ2T1NMV1B1SG0yMUtMSXBja3Uyekt5WitkUHM2L0tRU1NxQ1B0?=
 =?utf-8?B?Q2lXRzhnV2xGQVFTd3RqQkhhVlBqMHhoZ3BhelpwYS8xa2w5dEEyMWphNXVa?=
 =?utf-8?B?aFVvbHByRXpHSnNwcnpiUk5lTTk3eSsySFpVcDFLQ3Z2U1hqemVTaGhNRWZM?=
 =?utf-8?B?a0NqOUhpd3YwZVR1T2tXdUxjc0g5V3BPZGwvNG1PT0J3SnV4NEc1bGtITHND?=
 =?utf-8?B?WDFoaHpVS0NEWTBxZWltNXljdy9yYms2TWcvbEtHak9QbXJQRDMzVEJRQnBP?=
 =?utf-8?B?d2VQbnhuRGgyMy8yTTFzOElvd1NKZXpxQlJuQVJWSlA5d3Q1Qks2UzBJOERr?=
 =?utf-8?B?MlBUK01JQUg2eVVLN2s0NWVianR0enRQTlRxbmIzMjBJbnF1blNRWmI0S3pO?=
 =?utf-8?B?OXBsQ0RCOTJabTA1N2ZjRzZNV0FrNGwvdzhKOHltK0g3MUhIUi9XTFZ5R08y?=
 =?utf-8?B?OE1iT0Q4M3hqaXhoMG9XUzdwY1ZreENHUUdFKzVTdzBnNnplN2hBdnVtckZt?=
 =?utf-8?B?VCtTclRJRXBZU1V3MTgyNFlNUXVDRHhzUVV4ZmVQRGx1anBPdEp3ZkthZ3dy?=
 =?utf-8?B?SVBBRG9ma25zR28ya1FEVVM5OGZGQlk3Qjl5WkRaZnhMTFVPK0xjdTRwN1Jh?=
 =?utf-8?B?S0xqa1hhS3M1N1VHNmJVVDhTR2g0L2Fnc3F1Q0pMdlBmMEp2RkJmc2syRWhp?=
 =?utf-8?B?V0IxbXJ2MVZaQzJKdmlDSjUwUGgrZVVPS0ZrTUNQZ0FjMXdiYTNMQUhWdlZ6?=
 =?utf-8?B?UDh5dnVlVlNOcS9QV1UvYlY5d3NacXMwUnRTVDR0TVJ3SzF2YVJ5RjdmOXVL?=
 =?utf-8?B?OURub1pYc0NkVnhFNEYvZmJvSDlPTUZWS2crZGh0N2JYV1owUGE0R3R5NGEw?=
 =?utf-8?B?YkdRKytUcDdURUJTd05aS0c4d2ZuRzZ2UDNIWW1vWjlPV001VzRGc3FDRnpy?=
 =?utf-8?B?UWVKTnBqb0d4dGJHUFJhSG5vcmpvQ0RhQUF6TkMzb29TNUYrc0hDMFRIemdt?=
 =?utf-8?Q?dipEOfVKUzM05RdN5As2SCeAk?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a111acbb-7074-4f7c-8728-08dca76b051c
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2024 20:48:47.1585 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C64P8G23LdELZPJK/PEANUFfjKeIFJ4acTUVa66VPtGgaRtR5GS6EIo7J0VtkEzU3yegnaBDaVDbl5V4PoyI6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6072
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



On 2024-07-18 15:57, Philip Yang wrote:
> 
> On 2024-07-17 16:16, Felix Kuehling wrote:
>> Sorry, I see that this patch still doesn't propagate errors returned from kfd_queue_releasre_buffers correctly. And the later patches in the series don't seem to fix it either. See inline.
> kfd_queue_release_buffers return value is handled in queue destroy path, to return -ERESTARTSYS if fail to hold vm lock to release buffers because signal is received. See inline.

Sorry, I thought I had searched all the places that call kfd_queue_release_buffers, but I missed the one where the error handling matters most, that does it correctly. More inline.

>>
>> On 2024-07-15 08:34, Philip Yang wrote:
>>> Add helper function kfd_queue_acquire_buffers to get queue wptr_bo
>>> reference from queue write_ptr if it is mapped to the KFD node with
>>> expected size.
>>>
>>> Move wptr_bo to structure queue_properties from struct queue as queue is
>>> allocated after queue buffers are validated, then we can remove wptr_bo
>>> parameter from pqm_create_queue.
>>>
>>> Because amdgpu_bo_unref clear the pointer, queue_properties wptr_bo is
>>> used to acquire and release wptr_bo for validation, add wptr_bo_gart to
>>> queue_propertes, to hold wptr_bo reference for GART mapping and
>>> umapping.
>>>
>>> Move MES wptr_bo GART mapping to init_user_queue, the same location with
>>> queue ctx_bo GART mapping.
>>>
>>> Signed-off-by: Philip Yang <Philip.Yang@amd.com>
>>> ---
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h    |  2 +-
>>>   .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  |  5 +-
>>>   drivers/gpu/drm/amd/amdkfd/kfd_chardev.c      | 56 +++---------------
>>>   .../drm/amd/amdkfd/kfd_device_queue_manager.c |  6 +-
>>>   drivers/gpu/drm/amd/amdkfd/kfd_priv.h         | 14 +++--
>>>   .../amd/amdkfd/kfd_process_queue_manager.c    | 45 +++++++++++----
>>>   drivers/gpu/drm/amd/amdkfd/kfd_queue.c        | 57 +++++++++++++++++++
>>>   7 files changed, 116 insertions(+), 69 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
>>> index 6e591280774b..4ed49265c764 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
>>> @@ -322,7 +322,7 @@ int amdgpu_amdkfd_gpuvm_map_gtt_bo_to_kernel(struct kgd_mem *mem,
>>>                            void **kptr, uint64_t *size);
>>>   void amdgpu_amdkfd_gpuvm_unmap_gtt_bo_from_kernel(struct kgd_mem *mem);
>>>   -int amdgpu_amdkfd_map_gtt_bo_to_gart(struct amdgpu_bo *bo);
>>> +int amdgpu_amdkfd_map_gtt_bo_to_gart(struct amdgpu_bo *bo, struct amdgpu_bo **bo_gart);
>>>     int amdgpu_amdkfd_gpuvm_restore_process_bos(void *process_info,
>>>                           struct dma_fence __rcu **ef);
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>>> index 199e387d35f4..0ab37e7aec26 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>>> @@ -2226,11 +2226,12 @@ int amdgpu_amdkfd_gpuvm_sync_memory(
>>>   /**
>>>    * amdgpu_amdkfd_map_gtt_bo_to_gart - Map BO to GART and increment reference count
>>>    * @bo: Buffer object to be mapped
>>> + * @bo_gart: Return bo reference
>>>    *
>>>    * Before return, bo reference count is incremented. To release the reference and unpin/
>>>    * unmap the BO, call amdgpu_amdkfd_free_gtt_mem.
>>>    */
>>> -int amdgpu_amdkfd_map_gtt_bo_to_gart(struct amdgpu_bo *bo)
>>> +int amdgpu_amdkfd_map_gtt_bo_to_gart(struct amdgpu_bo *bo, struct amdgpu_bo **bo_gart)
>>>   {
>>>       int ret;
>>>   @@ -2257,7 +2258,7 @@ int amdgpu_amdkfd_map_gtt_bo_to_gart(struct amdgpu_bo *bo)
>>>         amdgpu_bo_unreserve(bo);
>>>   -    bo = amdgpu_bo_ref(bo);
>>> +    *bo_gart = amdgpu_bo_ref(bo);
>>>         return 0;
>>>   diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
>>> index 823f245dc7d0..202f24ee4bd7 100644
>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
>>> @@ -247,8 +247,8 @@ static int set_queue_properties_from_user(struct queue_properties *q_properties,
>>>       q_properties->priority = args->queue_priority;
>>>       q_properties->queue_address = args->ring_base_address;
>>>       q_properties->queue_size = args->ring_size;
>>> -    q_properties->read_ptr = (uint32_t *) args->read_pointer_address;
>>> -    q_properties->write_ptr = (uint32_t *) args->write_pointer_address;
>>> +    q_properties->read_ptr = (void __user *)args->read_pointer_address;
>>> +    q_properties->write_ptr = (void __user *)args->write_pointer_address;
>>>       q_properties->eop_ring_buffer_address = args->eop_buffer_address;
>>>       q_properties->eop_ring_buffer_size = args->eop_buffer_size;
>>>       q_properties->ctx_save_restore_area_address =
>>> @@ -306,7 +306,6 @@ static int kfd_ioctl_create_queue(struct file *filep, struct kfd_process *p,
>>>       struct kfd_process_device *pdd;
>>>       struct queue_properties q_properties;
>>>       uint32_t doorbell_offset_in_process = 0;
>>> -    struct amdgpu_bo *wptr_bo = NULL;
>>>         memset(&q_properties, 0, sizeof(struct queue_properties));
>>>   @@ -342,53 +341,17 @@ static int kfd_ioctl_create_queue(struct file *filep, struct kfd_process *p,
>>>           }
>>>       }
>>>   -    /* Starting with GFX11, wptr BOs must be mapped to GART for MES to determine work
>>> -     * on unmapped queues for usermode queue oversubscription (no aggregated doorbell)
>>> -     */
>>> -    if (dev->kfd->shared_resources.enable_mes &&
>>> -            ((dev->adev->mes.sched_version & AMDGPU_MES_API_VERSION_MASK)
>>> -            >> AMDGPU_MES_API_VERSION_SHIFT) >= 2) {
>>> -        struct amdgpu_bo_va_mapping *wptr_mapping;
>>> -        struct amdgpu_vm *wptr_vm;
>>> -
>>> -        wptr_vm = drm_priv_to_vm(pdd->drm_priv);
>>> -        err = amdgpu_bo_reserve(wptr_vm->root.bo, false);
>>> -        if (err)
>>> -            goto err_wptr_map_gart;
>>> -
>>> -        wptr_mapping = amdgpu_vm_bo_lookup_mapping(
>>> -                wptr_vm, args->write_pointer_address >> PAGE_SHIFT);
>>> -        amdgpu_bo_unreserve(wptr_vm->root.bo);
>>> -        if (!wptr_mapping) {
>>> -            pr_err("Failed to lookup wptr bo\n");
>>> -            err = -EINVAL;
>>> -            goto err_wptr_map_gart;
>>> -        }
>>> -
>>> -        wptr_bo = wptr_mapping->bo_va->base.bo;
>>> -        if (wptr_bo->tbo.base.size > PAGE_SIZE) {
>>> -            pr_err("Requested GART mapping for wptr bo larger than one page\n");
>>> -            err = -EINVAL;
>>> -            goto err_wptr_map_gart;
>>> -        }
>>> -        if (dev->adev != amdgpu_ttm_adev(wptr_bo->tbo.bdev)) {
>>> -            pr_err("Queue memory allocated to wrong device\n");
>>> -            err = -EINVAL;
>>> -            goto err_wptr_map_gart;
>>> -        }
>>> -
>>> -        err = amdgpu_amdkfd_map_gtt_bo_to_gart(wptr_bo);
>>> -        if (err) {
>>> -            pr_err("Failed to map wptr bo to GART\n");
>>> -            goto err_wptr_map_gart;
>>> -        }
>>> +    err = kfd_queue_acquire_buffers(pdd, &q_properties);
>>> +    if (err) {
>>> +        pr_debug("failed to acquire user queue buffers\n");
>>> +        goto err_acquire_queue_buf;
>>>       }
>>>         pr_debug("Creating queue for PASID 0x%x on gpu 0x%x\n",
>>>               p->pasid,
>>>               dev->id);
>>>   -    err = pqm_create_queue(&p->pqm, dev, filep, &q_properties, &queue_id, wptr_bo,
>>> +    err = pqm_create_queue(&p->pqm, dev, filep, &q_properties, &queue_id,
>>>               NULL, NULL, NULL, &doorbell_offset_in_process);
>>>       if (err != 0)
>>>           goto err_create_queue;
>>> @@ -422,9 +385,8 @@ static int kfd_ioctl_create_queue(struct file *filep, struct kfd_process *p,
>>>       return 0;
>>>     err_create_queue:
>>> -    if (wptr_bo)
>>> -        amdgpu_amdkfd_free_gtt_mem(dev->adev, (void **)&wptr_bo);
>>> -err_wptr_map_gart:
>>> +    kfd_queue_release_buffers(pdd, &q_properties);
>>
>> You're ignoring the return value here. In this patch, the function always returns 0, but in later patches it can return -ERESTARTSYS and you never fix up the error handling here. This patch should lay the groundwork for proper error handling.
> This is error handling path after acquiring queue buffers, but fail to alloc queue, or fail GART mapping queue wptr or F/W return failure to create queue, 

Right. We're still potentially leaking bo_va->queue_refcounts here. I don't have a good solution, and it probably doesn't matter. If queue creation failed, the application is going to be broken anyway, and the cleanup at process teardown will still clean it up.


>>
>>
>>> +err_acquire_queue_buf:
>>>   err_bind_process:
>>>   err_pdd:
>>>       mutex_unlock(&p->mutex);
>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
>>> index 420444eb8e98..fdc76c24b2e7 100644
>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
>>> @@ -208,10 +208,8 @@ static int add_queue_mes(struct device_queue_manager *dqm, struct queue *q,
>>>       queue_input.mqd_addr = q->gart_mqd_addr;
>>>       queue_input.wptr_addr = (uint64_t)q->properties.write_ptr;
>>>   -    if (q->wptr_bo) {
>>> -        wptr_addr_off = (uint64_t)q->properties.write_ptr & (PAGE_SIZE - 1);
>>> -        queue_input.wptr_mc_addr = amdgpu_bo_gpu_offset(q->wptr_bo) + wptr_addr_off;
>>> -    }
>>> +    wptr_addr_off = (uint64_t)q->properties.write_ptr & (PAGE_SIZE - 1);
>>> +    queue_input.wptr_mc_addr = amdgpu_bo_gpu_offset(q->properties.wptr_bo) + wptr_addr_off;
>>>         queue_input.is_kfd_process = 1;
>>>       queue_input.is_aql_queue = (q->properties.format == KFD_QUEUE_FORMAT_AQL);
>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>>> index 2b3ec92981e8..c98ff548313c 100644
>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>>> @@ -494,8 +494,8 @@ struct queue_properties {
>>>       uint64_t  queue_size;
>>>       uint32_t priority;
>>>       uint32_t queue_percent;
>>> -    uint32_t *read_ptr;
>>> -    uint32_t *write_ptr;
>>> +    void __user *read_ptr;
>>> +    void __user *write_ptr;
>>>       void __iomem *doorbell_ptr;
>>>       uint32_t doorbell_off;
>>>       bool is_interop;
>>> @@ -522,6 +522,9 @@ struct queue_properties {
>>>       uint64_t tba_addr;
>>>       uint64_t tma_addr;
>>>       uint64_t exception_status;
>>> +
>>> +    struct amdgpu_bo *wptr_bo_gart;
>>> +    struct amdgpu_bo *wptr_bo;
>>>   };
>>>     #define QUEUE_IS_ACTIVE(q) ((q).queue_size > 0 &&    \
>>> @@ -603,8 +606,6 @@ struct queue {
>>>       void *gang_ctx_bo;
>>>       uint64_t gang_ctx_gpu_addr;
>>>       void *gang_ctx_cpu_ptr;
>>> -
>>> -    struct amdgpu_bo *wptr_bo;
>>>   };
>>>     enum KFD_MQD_TYPE {
>>> @@ -1284,6 +1285,10 @@ int init_queue(struct queue **q, const struct queue_properties *properties);
>>>   void uninit_queue(struct queue *q);
>>>   void print_queue_properties(struct queue_properties *q);
>>>   void print_queue(struct queue *q);
>>> +int kfd_queue_buffer_get(struct amdgpu_vm *vm, void __user *addr, struct amdgpu_bo **pbo,
>>> +             u64 expected_size);
>>> +int kfd_queue_acquire_buffers(struct kfd_process_device *pdd, struct queue_properties *properties);
>>> +int kfd_queue_release_buffers(struct kfd_process_device *pdd, struct queue_properties *properties);
>>>     struct mqd_manager *mqd_manager_init_cik(enum KFD_MQD_TYPE type,
>>>           struct kfd_node *dev);
>>> @@ -1320,7 +1325,6 @@ int pqm_create_queue(struct process_queue_manager *pqm,
>>>                   struct file *f,
>>>                   struct queue_properties *properties,
>>>                   unsigned int *qid,
>>> -                struct amdgpu_bo *wptr_bo,
>>>                   const struct kfd_criu_queue_priv_data *q_data,
>>>                   const void *restore_mqd,
>>>                   const void *restore_ctl_stack,
>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
>>> index 36f0460cbffe..8552400d6d47 100644
>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
>>> @@ -205,18 +205,21 @@ static void pqm_clean_queue_resource(struct process_queue_manager *pqm,
>>>         if (dev->kfd->shared_resources.enable_mes) {
>>>           amdgpu_amdkfd_free_gtt_mem(dev->adev, &pqn->q->gang_ctx_bo);
>>> -        if (pqn->q->wptr_bo)
>>> -            amdgpu_amdkfd_free_gtt_mem(dev->adev, (void **)&pqn->q->wptr_bo);
>>> +        amdgpu_amdkfd_free_gtt_mem(dev->adev, (void **)&pqn->q->properties.wptr_bo_gart);
>>>       }
>>>   }
>>>     void pqm_uninit(struct process_queue_manager *pqm)
>>>   {
>>>       struct process_queue_node *pqn, *next;
>>> +    struct kfd_process_device *pdd;
>>>         list_for_each_entry_safe(pqn, next, &pqm->queues, process_queue_list) {
>>> -        if (pqn->q)
>>> +        if (pqn->q) {
>>> +            pdd = kfd_get_process_device_data(pqn->q->device, pqm->process);
>>> +            kfd_queue_release_buffers(pdd, &pqn->q->properties);
>> You're ignoring the return value here. In this patch, the function always returns 0, but in later patches it can return -ERESTARTSYS and you never fix up the error handling here. This patch should lay the groundwork for proper error handling.
> This is called from kfd_process_wq_release kernel worker, to cleanup outstanding user queues after process exit, it is impossible to be interrupted by user signal, I think it is safe to ignore the return value here.

I agree. The memory is about to be freed anyway.

>>
>> Regards,
>>   Felix
>>
>>
>>>               pqm_clean_queue_resource(pqm, pqn);
>>> +        }
>>>             kfd_procfs_del_queue(pqn->q);
>>>           uninit_queue(pqn->q);
>>> @@ -231,8 +234,7 @@ void pqm_uninit(struct process_queue_manager *pqm)
>>>   static int init_user_queue(struct process_queue_manager *pqm,
>>>                   struct kfd_node *dev, struct queue **q,
>>>                   struct queue_properties *q_properties,
>>> -                struct file *f, struct amdgpu_bo *wptr_bo,
>>> -                unsigned int qid)
>>> +                struct file *f, unsigned int qid)
>>>   {
>>>       int retval;
>>>   @@ -263,12 +265,32 @@ static int init_user_queue(struct process_queue_manager *pqm,
>>>               goto cleanup;
>>>           }
>>>           memset((*q)->gang_ctx_cpu_ptr, 0, AMDGPU_MES_GANG_CTX_SIZE);
>>> -        (*q)->wptr_bo = wptr_bo;
>>> +
>>> +        /* Starting with GFX11, wptr BOs must be mapped to GART for MES to determine work
>>> +         * on unmapped queues for usermode queue oversubscription (no aggregated doorbell)
>>> +         */
>>> +        if (((dev->adev->mes.sched_version & AMDGPU_MES_API_VERSION_MASK)
>>> +            >> AMDGPU_MES_API_VERSION_SHIFT) >= 2) {
>>> +            if (dev->adev != amdgpu_ttm_adev(q_properties->wptr_bo->tbo.bdev)) {
>>> +                pr_err("Queue memory allocated to wrong device\n");
>>> +                retval = -EINVAL;
>>> +                goto free_gang_ctx_bo;
>>> +            }
>>> +
>>> +            retval = amdgpu_amdkfd_map_gtt_bo_to_gart(q_properties->wptr_bo,
>>> +                                  &(*q)->properties.wptr_bo_gart);
>>> +            if (retval) {
>>> +                pr_err("Failed to map wptr bo to GART\n");
>>> +                goto free_gang_ctx_bo;
>>> +            }
>>> +        }
>>>       }
>>>         pr_debug("PQM After init queue");
>>>       return 0;
>>>   +free_gang_ctx_bo:
>>> +    amdgpu_amdkfd_free_gtt_mem(dev->adev, (*q)->gang_ctx_bo);
>>>   cleanup:
>>>       uninit_queue(*q);
>>>       *q = NULL;
>>> @@ -280,7 +302,6 @@ int pqm_create_queue(struct process_queue_manager *pqm,
>>>                   struct file *f,
>>>                   struct queue_properties *properties,
>>>                   unsigned int *qid,
>>> -                struct amdgpu_bo *wptr_bo,
>>>                   const struct kfd_criu_queue_priv_data *q_data,
>>>                   const void *restore_mqd,
>>>                   const void *restore_ctl_stack,
>>> @@ -351,7 +372,7 @@ int pqm_create_queue(struct process_queue_manager *pqm,
>>>            * allocate_sdma_queue() in create_queue() has the
>>>            * corresponding check logic.
>>>            */
>>> -        retval = init_user_queue(pqm, dev, &q, properties, f, wptr_bo, *qid);
>>> +        retval = init_user_queue(pqm, dev, &q, properties, f, *qid);
>>>           if (retval != 0)
>>>               goto err_create_queue;
>>>           pqn->q = q;
>>> @@ -372,7 +393,7 @@ int pqm_create_queue(struct process_queue_manager *pqm,
>>>               goto err_create_queue;
>>>           }
>>>   -        retval = init_user_queue(pqm, dev, &q, properties, f, wptr_bo, *qid);
>>> +        retval = init_user_queue(pqm, dev, &q, properties, f, *qid);
>>>           if (retval != 0)
>>>               goto err_create_queue;
>>>           pqn->q = q;
>>> @@ -490,6 +511,10 @@ int pqm_destroy_queue(struct process_queue_manager *pqm, unsigned int qid)
>>>       }
>>>         if (pqn->q) {
>>> +        retval = kfd_queue_release_buffers(pdd, &pqn->q->properties);
>>> +        if (retval)
>>> +            goto err_destroy_queue;
> 
> if destroy queue wait for vm lock is interrupted return by a signal, here return -ERESTARTSYS, then user process could retry or exit.

Thanks for pointing this out, for some reason I missed this call-site in my review.

Regards,
  Felix

> 
> Regards,
> 
> Philip
> 
>>> +
>>>           kfd_procfs_del_queue(pqn->q);
>>>           dqm = pqn->q->device->dqm;
>>>           retval = dqm->ops.destroy_queue(dqm, &pdd->qpd, pqn->q);
>>> @@ -971,7 +996,7 @@ int kfd_criu_restore_queue(struct kfd_process *p,
>>>         print_queue_properties(&qp);
>>>   -    ret = pqm_create_queue(&p->pqm, pdd->dev, NULL, &qp, &queue_id, NULL, q_data, mqd, ctl_stack,
>>> +    ret = pqm_create_queue(&p->pqm, pdd->dev, NULL, &qp, &queue_id, q_data, mqd, ctl_stack,
>>>                   NULL);
>>>       if (ret) {
>>>           pr_err("Failed to create new queue err:%d\n", ret);
>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_queue.c b/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
>>> index 0f6992b1895c..b4529ec298a9 100644
>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
>>> @@ -82,3 +82,60 @@ void uninit_queue(struct queue *q)
>>>   {
>>>       kfree(q);
>>>   }
>>> +
>>> +int kfd_queue_buffer_get(struct amdgpu_vm *vm, void __user *addr, struct amdgpu_bo **pbo,
>>> +             u64 expected_size)
>>> +{
>>> +    struct amdgpu_bo_va_mapping *mapping;
>>> +    u64 user_addr;
>>> +    u64 size;
>>> +
>>> +    user_addr = (u64)addr >> AMDGPU_GPU_PAGE_SHIFT;
>>> +    size = expected_size >> AMDGPU_GPU_PAGE_SHIFT;
>>> +
>>> +    mapping = amdgpu_vm_bo_lookup_mapping(vm, user_addr);
>>> +    if (!mapping)
>>> +        goto out_err;
>>> +
>>> +    if (user_addr != mapping->start || user_addr + size - 1 != mapping->last) {
>>> +        pr_debug("expected size 0x%llx not equal to mapping addr 0x%llx size 0x%llx\n",
>>> +            expected_size, mapping->start << AMDGPU_GPU_PAGE_SHIFT,
>>> +            (mapping->last - mapping->start + 1) << AMDGPU_GPU_PAGE_SHIFT);
>>> +        goto out_err;
>>> +    }
>>> +
>>> +    *pbo = amdgpu_bo_ref(mapping->bo_va->base.bo);
>>> +    return 0;
>>> +
>>> +out_err:
>>> +    *pbo = NULL;
>>> +    return -EINVAL;
>>> +}
>>> +
>>> +int kfd_queue_acquire_buffers(struct kfd_process_device *pdd, struct queue_properties *properties)
>>> +{
>>> +    struct amdgpu_vm *vm;
>>> +    int err;
>>> +
>>> +    vm = drm_priv_to_vm(pdd->drm_priv);
>>> +    err = amdgpu_bo_reserve(vm->root.bo, false);
>>> +    if (err)
>>> +        return err;
>>> +
>>> +    err = kfd_queue_buffer_get(vm, properties->write_ptr, &properties->wptr_bo, PAGE_SIZE);
>>> +    if (err)
>>> +        goto out_unreserve;
>>> +
>>> +    amdgpu_bo_unreserve(vm->root.bo);
>>> +    return 0;
>>> +
>>> +out_unreserve:
>>> +    amdgpu_bo_unreserve(vm->root.bo);
>>> +    return err;
>>> +}
>>> +
>>> +int kfd_queue_release_buffers(struct kfd_process_device *pdd, struct queue_properties *properties)
>>> +{
>>> +    amdgpu_bo_unref(&properties->wptr_bo);
>>> +    return 0;
>>> +}
