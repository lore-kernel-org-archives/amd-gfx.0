Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60E63C4332F
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Dec 2022 04:13:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DFA0C10E053;
	Tue, 13 Dec 2022 04:13:31 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2066.outbound.protection.outlook.com [40.107.101.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2F65A10E053
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Dec 2022 04:13:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EGjtZ0Pi4hr3Uo5PQHpEvOTuy8lcX8peTXQ7ppZLSEmnaDDb5JMLYtIO0WWi2j+9mG5UkaXAS3itZVgRtIdeOaQCf/mnswtWr14bOVAF9fDhx/KOZMGUuCOqkJ66kZgXd8ZU5PfeAXBWzG5F5I/sJTyuXTazD2SROIDZoKZD2hko9RbeK7SbyhSfFhJ9E6Wv9E2OP+Q8gXIXb4d0sSqQfncbmXqmDJfGUEiLKsD3xFYqbfrhGDuNDtxZtYxVVgw+psrryyeictuHevF+h3rgHEpXkW+X9pW2heT7S/yMsuF8yhF0EzEwQ/nRDpPe1RV1UIYB02w/ZOpsq6cPbO+r8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZpL87GLOPLQHFSvfEbMECzhj8ECLvS81xiEeACJdWdQ=;
 b=SzFlqyr1A65oznVLT208+MhUUU5WZCEX/r0LfRz1TShfLe9wF7r2LO2u/RkXC+PVpR9bLGTotwXaWoLNks91yWvagS4QMzuFcqtqoggX3pbP+bogj1D8GTuwMr+ILnAmmMNDbX3pXuFuYiTizeRD+RA4fOGMG/m8wY+XVnnR48R1wkM0FJ96bKpUdLx7yf67rW4xDbu2aLXv7fKsGl9FKI5CHF54bWz25koRQsr4giTGGU4LyyaNL1wbNj+C5/YXGab6kg1C8XMgHj+f0u76Dz6vIedVNzG/5NJg5zZfjAntBMxOYgAwtWpC9xDlflQHuz3W9jfS6IV8CEDJuF+Dug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZpL87GLOPLQHFSvfEbMECzhj8ECLvS81xiEeACJdWdQ=;
 b=0FVgxFNBb0R3LgTkLXqIF59aoV/tIjjiougVuMPfLUuD3RQfKkZ70ixexWQADtbeyaPNW1Nz2p0WaPdm9naopJ+8D+p5Bu4iBL4aCsHKhdAQxt7o6RCFHsfvgvlaVcFbvyeSrqsHALUC5HCZu4AG9+u6JHBqSNdvnWxoiWHoUr0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3370.namprd12.prod.outlook.com (2603:10b6:5:38::25) by
 CH2PR12MB5514.namprd12.prod.outlook.com (2603:10b6:610:62::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5880.19; Tue, 13 Dec 2022 04:13:24 +0000
Received: from DM6PR12MB3370.namprd12.prod.outlook.com
 ([fe80::2fd1:bdaf:af05:e178]) by DM6PR12MB3370.namprd12.prod.outlook.com
 ([fe80::2fd1:bdaf:af05:e178%3]) with mapi id 15.20.5880.019; Tue, 13 Dec 2022
 04:13:23 +0000
Message-ID: <a9aff70e-591a-35ee-fd06-02a452be8886@amd.com>
Date: Mon, 12 Dec 2022 23:13:21 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v2] drm/amdgpu: Fix size validation for non-exclusive
 domains
Content-Language: en-CA
From: Luben Tuikov <luben.tuikov@amd.com>
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 AMD Graphics <amd-gfx@lists.freedesktop.org>
References: <20221210092419.16548-1-luben.tuikov@amd.com>
 <20221212174834.36544-1-luben.tuikov@amd.com>
 <802b6283-d015-eb67-18fd-cba6fb03c96a@amd.com>
 <fe09407d-9057-879b-be61-3bfbe74846db@amd.com>
In-Reply-To: <fe09407d-9057-879b-be61-3bfbe74846db@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT3PR01CA0078.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:84::9) To DM6PR12MB3370.namprd12.prod.outlook.com
 (2603:10b6:5:38::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3370:EE_|CH2PR12MB5514:EE_
X-MS-Office365-Filtering-Correlation-Id: 224e09f7-edb5-4527-0fc0-08dadcc06081
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pJzS2Z+kdXeDoYpG2/3QZLGELt/KJz/8467DNTwbT8sV6qnLg8bBTfOfodh1V3XfLfrKL6Nj4BrH5UXLTTmlWousxmqhRIrZ7L/+nWPmd37G3vkjV5FsvudBsnkjE+SFbdpjhQnSBn6TlsKi3MNvUyj/k9nJ5wsDSvmbXbOt2qc0ks0mJVrVt5cJ24/N04UckvkZ0obTBn0eDd4X6/8rn3LJecaqNiIwwbk/bcczzuBl0jxNObysBmHww87PzLnGBFYSMS6WXYu+IVgYI0AvMWdGAhmXwcjwWt8tC9CuVOlkPnntZi8eCrtiJ8toM5afs2tN0HVZJFU4UerNqbWnuqluACMUz12NhoqtVq3oKKerQKqd1qN8wVDA8C0sCAFBJBkfbQmTc7WWgJbPAZYWtSvqID1y1Hf3qwpxKBVnEJ/vJ/Xdhwu479A6ARy2mInU1Pz9+4/tfoM0J7Toqe3/xFHFVf0wsSyZRXTvSfNsHF8+P4ufrJL2ei0UHrlRZ55wscgPs+EGOd2zwfpFfXCegBe2fRobcOhaj8JjFg+hN1fwQFTr453w//N5Wt//XFMHpE9Q24tI+/j2/iHwRpoZBVMQ9u5S75wJ5WjHd+nD0jzHX/SzBU3o5QoA1ItSNaiq4mmqaXCn9Ixid2+B5i8Pyjc9wXdBW1M1/VtLN7S0K1s3VravIlqLmVkafHNQxkquhasQsKXHURSqUznFJtlsYPwYMlgwntVWLsrI5L+w/AI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3370.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(136003)(346002)(396003)(39860400002)(366004)(376002)(451199015)(110136005)(66946007)(4326008)(36756003)(66476007)(8676002)(41300700001)(66556008)(316002)(26005)(83380400001)(38100700002)(5660300002)(186003)(6486002)(8936002)(6506007)(478600001)(6512007)(53546011)(86362001)(2616005)(66574015)(31696002)(31686004)(44832011)(4001150100001)(2906002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SlZsRUlvT1l2NFg0b2NnRjJPS21HOTFGMDY1dWJsSEJHN2MwbWc3aHo4eE9H?=
 =?utf-8?B?dzU0ODRmemhtVEE3ektKYkphUTBBdE5pNlQxMkJ6QjYrK0czZW14bkVOSnha?=
 =?utf-8?B?aFVvSXp1MklWV2JZZldyZ3I3Mnc4azd1azQyMmUva0s0cENOQnlDU1VwWGd4?=
 =?utf-8?B?SVVOZVpkelhIeXgvZ1NpSGtjNWhlVjloMmo3QkRlbVd6S01OREs0QmZaRUhV?=
 =?utf-8?B?Ujg5VXl5eFRKOFhwS0pveGlVYVF6bFdqb2FIZ1Q4MjQyQjBTZEtzU3JueDJl?=
 =?utf-8?B?YVZqanJiSlNzbGxyZHhhTFFLcjg3T3NXK1hyMDE0engzY0xpc2hWNjg0Zndl?=
 =?utf-8?B?alJMRytuek83bm82YjdoMEhRNWRoTUhPcDgwejVBZXU5dkczY1VTME45UnJs?=
 =?utf-8?B?b21MTG91WXNJbjV4OHRSQS9yc21JanRvQkFIRDh5WWZ5SEgyaVRBT091NmtF?=
 =?utf-8?B?RGdZY1BienlCUmYxYncvWXo5YmVucFhBeFZZK2tqMG1TdXNObVdORitUc3dK?=
 =?utf-8?B?dUd1a1BhMldNV09wRU9uVnlNMXdwbHd0S2NJTnEyOFU5bHdGdklxZHkzYUJi?=
 =?utf-8?B?Y3RTRnpUMHptYk5YTmp6ZnJhaWc4ZS90TEVCTEs3QU5iQVZQSDRFQS80bG0x?=
 =?utf-8?B?dXoyVDR2QW1XUzhodFdWTDZmanlaOFlnUDhuVWVWMGpLSnNCdTZEUDBXVXJG?=
 =?utf-8?B?d01Dc2M1aG1SbUtGTWNlbnZVNGNsQUNDN3o5UGJGVVJ4R2tnNDFRRXBWQnNS?=
 =?utf-8?B?UmhpS2pwSHRETXg5VG5abStQSklDWDBFZnM4azRVbmVyMVFIVGJhdDdEb2x5?=
 =?utf-8?B?WGFlWmYvSDcxcm5NVTZnMXFkdUJLNG9PQ2xzUWM2aUtNWDdka3ExdzZIK2Rw?=
 =?utf-8?B?VzZ3bDA5bmFOb0tjTENFRnk5RG5jUVIrSFBvN0h5OFU4NUZpZUVPZFI3aGlz?=
 =?utf-8?B?UXNOM2xOaEtrSkp4K252Z1B5WkcwQ1NkSkNjVm84a2h0dGJuR1R2YVZoOFVs?=
 =?utf-8?B?K3UwdUtYdGpaV3hFVGJRQXVIbDFHOUw1aGlUY3QyT0dNOGZZSlNJSU42NFJ6?=
 =?utf-8?B?VFdhbUNaUTJ1WmZwTDd3aHptUWtYQ0dGakpaUzJ3dThIVTBUZy9RZGlOMWY4?=
 =?utf-8?B?QXRmeDlKMzFoNnByRWR0UFZPS0pYNWs3ckc5cTJnRlpEdHRrMGRvWWhMcS9Z?=
 =?utf-8?B?cEY0a28vRmtGRUMxR3d6NFBWS2J1ZTl5UDl4Z0xqNkQ3UUx1NGhkMnhPUjEv?=
 =?utf-8?B?MnM1R3FGeUZCYkhadzRtdVF3Y2ttTEtFbHoybzNKRWVYRTRlMWNKVHhZdlc3?=
 =?utf-8?B?WVN0YnZlRGg2cmdWYmVoTkR1ODJlL0pTamp4UG1qTmtUU0ZqVXFoZE93M3ZY?=
 =?utf-8?B?UTRoV2tkdVNRY0MwWEhCREV0dUFOdHpkQlQ5K3hkWkhPekR3RFhTV0o3Um5Z?=
 =?utf-8?B?UVZYZ0d2cDl1dmVjTzFmbnA2RWg2TTJWVkxpOTVhQ3NjZlZ6MkpYRkJrTWxT?=
 =?utf-8?B?YlZJbE9IMTBCRTJRNlVNdmpEUE0xcmN3Z2kyMmZtSytFMFAyYjZiKzIrM2RE?=
 =?utf-8?B?SWg1M3U3UDVRUzM2M3pHbVVDR0xzQVZMbHNGbjR6c1VnOWhqcVoyT3Rmb2R5?=
 =?utf-8?B?WngyUWhQY1F4SWRYR1VjQXF0dlgwdjhrTUhULzQ3RXNTZndianpNZEpWSnBz?=
 =?utf-8?B?d0dPeTViZmtMVjdzL1haRXV6VUl2ZG0rUGdZcXM1T1g0Q0xCOGpSVVAweDVi?=
 =?utf-8?B?KzVkU1FRZDdQUk91anM3WTl5TE4yaUZ5Rkx0eDM4K0dVUFBTSktqc0NtVWdy?=
 =?utf-8?B?OHdIZW80dDdXY1BVUDFIeGVkczA1L0EvZS8ybXUwNzdLZzJXTm4zVGk5cWI5?=
 =?utf-8?B?dnBIT3YxNUhsTHhkNURPak16L1cwOG9HTGtDVEp5akZrUjNnVUUzRXMzZTlk?=
 =?utf-8?B?WGJhejJvYnlUeUNzZmdzbm0wYlZBcXBMN1VZWUVkeC9QQnBvTll6U01jYkE1?=
 =?utf-8?B?bFRQeWJhMkhtQ3VUbnpDT1Bma0ZUdWhXakdNQlpQNHhYM3F6VUpOSUhTd2tS?=
 =?utf-8?B?RXkyNXdNOHhPZmswclRBMENoSDVxKzdydENuSExaWWF0TXBCYjN4azBBMUdT?=
 =?utf-8?Q?zgLDKqDih5chpIRxqJkzZsY+O?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 224e09f7-edb5-4527-0fc0-08dadcc06081
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2022 04:13:23.9123 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N50riH+N3lwZB3dcVUQqZfufMGW84PFdZ/L4zEFSEWSFiLOcuzwSAVf+NnK5Q4Sm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB5514
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
Cc: Alex Deucher <Alexander.Deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2022-12-12 18:44, Luben Tuikov wrote:
> On 2022-12-12 14:19, Christian König wrote:
>> Am 12.12.22 um 18:48 schrieb Luben Tuikov:
>>> Fix amdgpu_bo_validate_size() to check whether the TTM domain manager for the
>>> requested memory exists, and to allow for non-exclusive domain allocations, as
>>> there would be if the domain is a mask, e.g. AMDGPU_GEM_DOMAIN_VRAM |
>>> AMDGPU_GEM_DOMAIN_GTT.
>>>
>>> Cc: Alex Deucher <Alexander.Deucher@amd.com>
>>> Cc: Christian König <christian.koenig@amd.com>
>>> Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>
>>> ---
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 19 +++++++------------
>>>   1 file changed, 7 insertions(+), 12 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>>> index fd3ab4b5e5bb1f..e0f103f0ec2178 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>>> @@ -448,31 +448,26 @@ static bool amdgpu_bo_validate_size(struct amdgpu_device *adev,
>>>   
>>>   	/*
>>>   	 * If GTT is part of requested domains the check must succeed to
>>> -	 * allow fall back to GTT
>>> +	 * allow fall back to GTT.
>>> +	 *
>>> +	 * Note that allocations can request from either domain. For
>>> +	 * this reason, check either in non-exclusive way, and if
>>> +	 * neither satisfies, fail the validation.
>>
>> That's not correct, the original logic was completely intentional.
>>
>> If both VRAM and GTT are specified it's valid if the size fits only into 
>> GTT.
> 
> Given that this patch fixes a kernel oops, should this patch then fail the validation,
> i.e. return false?
> 
> This would then fail, in amdgpu_ttm_reserve_tmr():
> 
> 	ret = amdgpu_bo_create_kernel_at(adev,
> 				adev->gmc.real_vram_size - adev->mman.discovery_tmr_size,
> 				adev->mman.discovery_tmr_size,
> 				AMDGPU_GEM_DOMAIN_VRAM |
> 				AMDGPU_GEM_DOMAIN_GTT,
> 				&adev->mman.discovery_memory,
> 				NULL);
> 

I've rewritten the patch to be minimal and just check that the memory manager
is not NULL. The patch follows this email.

Regards,
Luben


