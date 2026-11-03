Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17DD1606A31B
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Nov 2026 18:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=MF6T+h8X
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9DB0010E19D;
	Tue,  3 Nov 2026 18:27:08 +0000 (UTC)
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013009.outbound.protection.outlook.com
 [40.93.196.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 22E068961D
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Nov 2026 18:27:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S6rf6p99invGmCQtmv4HSuQ6HtohgC7Gm3iTYCYDJ0WmpSM9OzaDEULphXuLk4Ljz8JEyKxAgM8G8w8VZkzg/AbbucOcorBScx0eET2IUT1MnMRcwDdxp5JYmKwHvxS7LTY7ewI9k2zyq7JxdCsjP0n7+PXm/OtUGvmoSYnVT+kXZGZbDyrJflbQ8QWH/ivXUiisD6M/i0SznYv3lwL5E95EaAd0EyedALY2BDdPMEL/pL8WeeEni2nKA5iyas9F9uYgVg4FEkOE//nJpQew5jgUFpFRC9Gk38ftlx6cVHpb8D7xCcoLQfGoUA7ystIDmgCmUNFbcH9AXBolBQKptQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xT4rkyfcG7wMyUru83IcEvi9WxPZAV/8PjPoUtcq3Jk=;
 b=dkNEfJ1JE63CZe6cIndGS7zK3fejtmU2trpOu7UGGRCVbov8XSF7zffepE/6+hldJvNntkodnY0dbmJj/xjIvpmbizzt6MWqHetvEE/kwsKRc8uwgj1B6PMgbRjB7l3j2rzR+pZvxflas/cMXH6Emh8yx6IV7CmvkwFZTbcm2T9knU9H8TCz0XCKGUPgVHelTQSdGkwrPOO3uKgu/lZn8UxgAQZ9kPQplzp49INRNdrSKme8cpz4dnW33B1peMbKUyVCvsYCvnoyXJJkpYmNnWYST+awK+0LuSaw+GhP56EfzA74cX8KaDBvMXbrgtaW2xNGtOSSK3j/jjZGsHzrvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xT4rkyfcG7wMyUru83IcEvi9WxPZAV/8PjPoUtcq3Jk=;
 b=MF6T+h8XXlidlkg6xq0Gq2kCuqFtTUwnpoIWkLpJXomVy7lqGMDLBFF3HmhyC9twFw9W2y8PdTlu3nEtiAyMIbINE57MdFmiOvIdPSEBZo19OT4bRTCe0Xhf95JBgkhnEluIItZND2AGiYRFJKeBAvaQqfN0xHc9SBs1RMEYY40=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5167.namprd12.prod.outlook.com (2603:10b6:5:396::10)
 by PH7PR12MB7818.namprd12.prod.outlook.com (2603:10b6:510:269::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Tue, 3 Nov
 2026 18:26:58 +0000
Received: from DM4PR12MB5167.namprd12.prod.outlook.com
 ([fe80::4588:54c1:bc29:2c7c]) by DM4PR12MB5167.namprd12.prod.outlook.com
 ([fe80::4588:54c1:bc29:2c7c%3]) with mapi id 15.21.0569.011; Tue, 3 Nov 2026
 18:26:58 +0000
Content-Type: multipart/alternative;
 boundary="------------Gjh0zXyMii5ZiFCRluZyKcWk"
Message-ID: <fe5c2998-f19d-4992-b87c-2a498fa109d0@amd.com>
Date: Tue, 3 Nov 2026 13:26:56 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdkfd: Don't reuse a VRAM page that is still
 referenced
To: "Chen, Xiaogang" <xiaogang.chen@amd.com>,
 "Mishra, Apurv" <Apurv.Mishra@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Sierra Guiza, Alejandro (Alex)" <Alex.Sierra@amd.com>,
 "Kasiviswanathan, Harish" <Harish.Kasiviswanathan@amd.com>,
 "Faizal, Sahil" <Sahil.Faizal@amd.com>
References: <20261023171722.46301-1-Apurv.Mishra@amd.com>
 <53899e72-b727-42ab-81ee-8587a10f16b7@amd.com>
 <PH9PR12MB135921453E146E0DA733B16DE99F612@PH9PR12MB135921.namprd12.prod.outlook.com>
 <601d1612-ea3d-4379-9336-9c36e9485230@amd.com>
 <PH9PR12MB13592198ABB2BF96C9F290F41D9F6F2@PH9PR12MB135921.namprd12.prod.outlook.com>
 <ee715a81-5643-4da7-a0b9-7205e34758b5@amd.com>
 <PH9PR12MB13592158862738134DABAB73F89F6A2@PH9PR12MB135921.namprd12.prod.outlook.com>
 <39984cf9-fe4a-40e3-b076-20bea95f2127@amd.com>
 <fe5f9b54-0516-4a83-ad54-c982dc161523@amd.com>
Content-Language: en-US
From: Philip Yang <yangp@amd.com>
In-Reply-To: <fe5f9b54-0516-4a83-ad54-c982dc161523@amd.com>
X-ClientProxiedBy: YT3PR01CA0016.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:86::6) To DM4PR12MB5167.namprd12.prod.outlook.com
 (2603:10b6:5:396::10)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5167:EE_|PH7PR12MB7818:EE_
X-MS-Office365-Filtering-Correlation-Id: bc6b37e8-6ed7-470c-f165-08df39d80b52
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|23010399003|261102123227099003|18002099003|8096899003|22082099003|3023799007|13003099007|56012099006|261009223027099003|261021123027099003|261022075727099003|261022105027099003|261021135927099003|261021121427099003|4143699003|5023799004|11063799006|10067099003|261028144727099003|261026121527099003|261026140227099003;
X-Microsoft-Antispam-Message-Info: /z9+CGEzyPlGH37xmnPSTwGg48Mepk6fcRI+QiUrahBJ76uA1aUYeNUUb4pM5YDwrvCdxoCwpsXy7LaTSxvy0C6pTcqQ144VA5eFq8yq2BAjRAo9yhzN1YpFYuYEhOcDbB4B0GiFfskz9odQIvlS7ojL+LAMaeLlNIXjUunDZXL7CLYYr/mw7YycwZGdrbRwxabShDVdsVaAQiwCR7PBoXGrFJO8JPH2xl6IhaQNLOwlOcLYrD1aLIMkLJZfP4m9L02tANpfB3hVmSOVNScYt7tZXb+q8ii44Y1DxIGGRRh63JLiBgUwo9Ls2mEyN+cC8qU8G7+NT7/yF7PJ+TMqHSZ8ULS1bxu8/LqUo+OR3lWE5SuW74PrNghhTn+8vc7eu4SDSRefaaRmnTR4nPwDRujtA3EB1xdnn5L7FdIb9t8NEo8zaXTK2QPgkqv40/FiYymg/9+zJ7tlfLKfaCRhg1vy+OMe2C/4adnK5fkvjyrrNapwlxa9TmV1C3q0w1YcN9RJMDD0WjrSbLMfciJNYHOAlxOB4HYAwikNWl7CX97Xj1lQKEs/G5N0t0TRfUTjGNEhcVdrPmQ+5424nnGmLWFPX1aoZoghJATYvpnI/CBEC1ufpGh8NyvYdqnQcBBD
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5167.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(261102123227099003)(18002099003)(8096899003)(22082099003)(3023799007)(13003099007)(56012099006)(261009223027099003)(261021123027099003)(261022075727099003)(261022105027099003)(261021135927099003)(261021121427099003)(4143699003)(5023799004)(11063799006)(10067099003)(261028144727099003)(261026121527099003)(261026140227099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M0lkWThDY05TcXVwSm91R3NYTkFCTFREaUdWRlc0cS85Z3R4cWJTcS9oYU8y?=
 =?utf-8?B?Y3pkREVGZ05DVlBjN3pJa3Zxa3U1a0JwajEvRU9WUzB3b0Z1N3FFcldzZUcw?=
 =?utf-8?B?Sytsb2V4WVRSeFJNU2FCWUl0RDZENHVzcmIzdFJSWk1PSU9CWnd2V1FqODNw?=
 =?utf-8?B?RE9TVXJpSVFwc0lpVnc3VHBpR09lQW9NeFZTNXh3V1FTRU9tUlJicGZmZzd2?=
 =?utf-8?B?N1N1bWJoN2dYL0ExUkhodTI3eXIzZVEyNG41MmU1STI0NzcrQjFzamVkZk1B?=
 =?utf-8?B?emRabFIzM29qOXZKOUFnS21vSzZTekVKZklYWGhtdXNXYmRQanNrdDk4Ukha?=
 =?utf-8?B?Wml2UEhONmt4NE52ODg4RE9SY3FIRFk0SFlNdjZFZitCWUdoV2JCcklxWUtZ?=
 =?utf-8?B?MmFPQTNPSytLQTZ2aFBjNVRGY1VGOTdoTm5wK05wNFRvRWV4OFI4aFd0YlBz?=
 =?utf-8?B?TXdtZGVHZ05TcjFkZnJoQWVtYlpjcUlWN2pZRVhIUCs4RlBFWWJvNkJkY2g1?=
 =?utf-8?B?MHNnMVBXR1hPZnFXb2xhck9hTzhXNXhCTjl2UVJGNlFVYjdiMkMybDhZVS9y?=
 =?utf-8?B?dmxxVVBPZXhCK1dRbHpmb3k5NWIxYW1GdFpwMFh3emtJNzNkMUVSaGsxNW5o?=
 =?utf-8?B?bnduNVR6a3JzclViUFMyQ2p4ZWN2dnVlWC94b1BKK3FncVdKYzRRcW5hNU9h?=
 =?utf-8?B?MUZ4VmMyNVZhZk0zRnFudzJWeTNLMjh4UzF4U3JHQm1Pa3BBa1lZRnczNzVi?=
 =?utf-8?B?VXBGdTdLd3ppbzk4aVU1LzloUXlTT2doc3pvOW1wUkZrNkpwN1JicHN1bENY?=
 =?utf-8?B?UWlGTS9zYjVBU3dneTU3TnlSZXVhZy9hRlJOUGpoUGJBaFJiZzZrem9vZnkv?=
 =?utf-8?B?VUlQY3pLb0g5WDhuaVFYemxueEJjbXVtMkpqRUlyOEp2OENSdlZDZURVZ3FG?=
 =?utf-8?B?OGlNVUNXcFZvS2dXZVJlYXJTajRNVHF3dFk5WFNqbDlOWC9UbXZtWjFKSDN3?=
 =?utf-8?B?VjdrdW5DbE41c3g1QTVYUnFuOG8yMXFGZ2x2c1J6MFB2TlZtRmRwd21Ka1VY?=
 =?utf-8?B?ZWZoaFg5SGFKazNtYWpkd1FFMXV1NzFvckVPSE82SXM2MjFxT2NLOTRVdDcw?=
 =?utf-8?B?VHBQbE9tU0MyQWNnMEZtVWJpZDZkYXBiK05mQW0xcEE4OHVoeFBKdnNzRTFZ?=
 =?utf-8?B?YitHeXlkd0U5VUtCZmkwZHQvSjJHcG96ZWNmUGgzdnVIbTVEVTJDRzkyelVU?=
 =?utf-8?B?UFdzRUV2SXRLdHo0QVZjWWdWOXR6b1NIWXF0YTlLclo3T0loNGxpSVZhcUxR?=
 =?utf-8?B?bDF0RUw1WXJ4VkZhTjcwMEtTV2FlYkJPdkdmdi9wNjRNMGJyOWpVdzVLWXd0?=
 =?utf-8?B?UXJ4K1VZYmxhRXpRRGZWRkxoaVdGY1pjQSsvbjlvcEhDUlZOYkZPMVFzS3Uy?=
 =?utf-8?B?QnluRDhZRWFJQ2owdVRNK29tUXE3TzllLzF0dUQwRmY0VVhkVXNnaE83Skx4?=
 =?utf-8?B?cG9INUFwRDZkNm12M2phdE04QnVLcHZrY3EwQ3h1RGhxOFp1Q2U2U05xbWhh?=
 =?utf-8?B?bFFKZFNuTndEb09xdXg5VlptTjR4L2d6bjk5a2ZwWEQxN3hiSlVIYzhmbmFE?=
 =?utf-8?B?bHllL3NHWkM3QUs5QmVSazJKbHI1Y3J5WWpQbEI2b3FNZGN2QWRJUWhhNy9I?=
 =?utf-8?B?QkRXbjFmd2RoTkVvWk5XeU14VXliRTRHa3hmMUxoaHRKOGY2M2Zua09MRVl3?=
 =?utf-8?B?VWIyckFwVVpDOVg0VXdrN3RJT2wyb1MzK2ozemlBa1luMEl1YWVSZTNyamlq?=
 =?utf-8?B?ZTdJZjd3dzJrU28zY0RFaFJ1cG9iRy82SGdIK0N6NnBUZytWYk96ZnA0SWNk?=
 =?utf-8?B?dEc1UTFyUGpFemxXUDdSWUVxOXlVRVY1M3JxMUtrc1JtTFFHbklqTHljYjlE?=
 =?utf-8?B?QUtPdmJyMW9hcU5NZC9UaEdzai8xNlo0UHZjUjQwTmt0aWpkRzVKMFltQXMr?=
 =?utf-8?B?L0s4RlJ6VmZzVW8xS0JYNFU1enBDSkdLMkRJem8zNUFMR2pPM1JIQ3VHd044?=
 =?utf-8?B?V1l4Vk1NM2h6NXRzQ1BqR2NXeEVWeWp2cFAvbUg4N2ZrbDQ2SndoVk9rOEpK?=
 =?utf-8?B?OXBqSTI4dmN5dGdSclVyZWx3bHFRbjY1QjRDM2dqTWNsU004TzJzdDYrUVNB?=
 =?utf-8?B?QTg5V1o0Ky9tUUw0ZTlhTzZQOEZOZ0R6UmlSVytyMU5TcDYxckZpTy80WGN0?=
 =?utf-8?B?MEVSMWpYZ3JWTGplM25OOWQ0c3lnNnREUi8zMWZEcFA4dENrb3VYOW5ZM0FW?=
 =?utf-8?Q?qRYk3fHVjXj3vWEX40?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc6b37e8-6ed7-470c-f165-08df39d80b52
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5167.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2026 18:26:58.3317 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wM+xpS74F7dkYPGuNR3jc4blLUHSc3D103NGNX+gMWD8A7OE8YYPunNiNL9K9Rwb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7818
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-14.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--------------Gjh0zXyMii5ZiFCRluZyKcWk
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2026-11-03 12:09, Chen, Xiaogang wrote:
>
> On 11/3/2026 10:57 AM, Philip Yang wrote:
>>
>>
>> On 2026-11-02 18:32, Mishra, Apurv wrote:
>>> AMD General
>>>
>>> AMD General
>>>
>>> Hi, @Chen, Xiaogang <mailto:Xiaogang.Chen@amd.com>, following up on 
>>> your comment...
>>>
>>> P's other user is |do_swap_page()|'s own pin. On Ubuntu 6.8, 
>>> |do_swap_page()| calls |get_page()|, then |migrate_to_ram()|, then 
>>> |put_page()| (/mm/memory.c:3861–3864/). The extra reference outlives 
>>> |migrate_mutex|. By then P's data has already moved to S, and the 
>>> PTE points to S, so nothing else is wrong.
>>>
>>> The wrong place is KFD's reuse. |svm_range_validate_svm_bo()| reuses 
>>> the |svm_bo| because P's pin keeps it alive. 
>>> |svm_migrate_copy_to_vram()| then hands out P by offset without 
>>> checking it, while |zone_device_page_init()| requires the page to be 
>>> free. The fix adds that check where KFD hands out the page. When the 
>>> pin is still there, the page stays in system memory with a valid 
>>> PTE, and the next GPU fault migrates it normally.
>>>
>>> Mainline is the same. |do_swap_page()| now holds the page lock 
>>> across `migrate_to_ram()`, but `zone_device_page_init()` resets the 
>>> refcount before `lock_page()`. The race remains on mainline, because 
>>> upstream KFD has no such check. My patch adds it. This has been 
>>> tested and verified.
>>>
>>> Adding @Faizal, Sahil <mailto:Sahil.Faizal@amd.com> for updates as 
>>> the fix needs to merge soon.
>> This is the corner case I tried to fix with the patch "drm/amdkfd: 
>> Fix svm_bo and vram page refcount". That patch was rejected because 
>> we cannot take a page that is not free and treat it as free and safe 
>> to use. The approach here makes sense to me: if the page has not been 
>> freed, we skip it. With that said, this patch is
>
> If the page has not been freed HMM page collect will set 
> (migrate->src[i] & MIGRATE_PFN_MIGRATE) to false. The explanation from 
> this patch is do_swap_page does not release vram page during cpu page 
> fault recovery, then page collection by page table walk would see pte 
> sill point to device memory, then not collect this page.
This issue isn't with the source page, it's with the destination VRAM 
page, which still has a non-zero refcount after migrating to RAM. We 
cannot assume every VRAM page has been freed and zero-initialise it, so 
we skip it and map to the GPU with the system page instead.

Regards,
Philip
>
> If this explanation is right it is not drive issue. Driver does data 
> migration, not decide which page can be migrated. There is contradict 
> in this explanation. I suspect the real cause is not revealed.
>
> Regards
>
> Xiaogang
>
>>
>> Reviewed-by: Philip Yang <Philip.Yang@amd.com>
>>>
>>> Regards,
>>> Apurv
>>>
>>> ------------------------------------------------------------------------ 
>>>
>>> *From:* Chen, Xiaogang <Xiaogang.Chen@amd.com>
>>> *Sent:* Wednesday, October 28, 2026 6:41 PM
>>> *To:* Mishra, Apurv <Apurv.Mishra@amd.com>; 
>>> amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
>>> *Cc:* Deucher, Alexander <Alexander.Deucher@amd.com>; Sierra Guiza, 
>>> Alejandro (Alex) <Alex.Sierra@amd.com>; Kasiviswanathan, Harish 
>>> <Harish.Kasiviswanathan@amd.com>
>>> *Subject:* Re: [PATCH] drm/amdkfd: Don't reuse a VRAM page that is 
>>> still referenced
>>>
>>> On 10/27/2026 8:19 PM, Mishra, Apurv wrote:
>>> > AMD General
>>> >
>>> > Hi, @Chen, Xiaogang <mailto:Xiaogang.Chen@amd.com 
>>> <mailto:Xiaogang.Chen@amd.com>>,
>>> >
>>> > The migrations don't overlap. |migrate_mutex| serializes them, but 
>>> it doesn't
>>> > cover P's last reference:
>>> >
>>> >    *
>>> >      |svm_migrate_to_ram()| releases |prange->migrate_mutex| at /
>>> >      kfd_migrate.c:1073/, after the VRAM→RAM migration has 
>>> finished and before
>>> >      the function returns.
>>> >    *
>>> >
>>> >      |do_swap_page()| drops its own reference on P only after 
>>> |migrate_to_ram()|
>>> >      returns, at /mm/memory.c:4851–4853/.
>>>
>>> Before do_swap-page drops the last ref on P the cpu mapping of fault
>>> address has not been changed. Then at following sys->vram the
>>> migrate_vma_walk_ops->pmd_entry will not collect this source(sys) page
>>> because the address there still point to device private page(since you
>>> got cpu page fault it is device private memory). Then 
>>> (migrate->src[i] &
>>> MIGRATE_PFN_MIGRATE) is false.
>>>
>>> If P got used at sys->vram, but P is still used by someone else
>>> something wrong is in other places. Skipping migration does not 
>>> solve it.
>>>
>>> Regards
>>>
>>> Xiaogang
>>>
>>>
>>> > So, the GPU fault takes |migrate_mutex| legitimately, while P 
>>> still has |
>>> > do_swap_page()|'s reference. KFD gets P back without P ever being 
>>> freed. VRAM
>>> > destinations come from the |svm_bo| by offset (`cursor.start + 
>>> j`), not from a
>>> > pool of free pages. That |svm_bo| is still alive because P holds a 
>>> reference on
>>> > it until P is freed, so |svm_range_validate_svm_bo()| reuses it 
>>> and the same
>>> > offset gives P again. Nothing checks whether P's previous user is 
>>> done with it.
>>> >
>>> > Regards,
>>> > Apurv
>>> >
>>> >
>>> > 
>>> --------------------------------------------------------------------------------
>>> > *From:* Chen, Xiaogang <Xiaogang.Chen@amd.com>
>>> > *Sent:* Monday, October 26, 2026 5:27 PM
>>> > *To:* Mishra, Apurv <Apurv.Mishra@amd.com>; 
>>> amd-gfx@lists.freedesktop.org <amd-
>>> > gfx@lists.freedesktop.org>
>>> > *Cc:* Deucher, Alexander <Alexander.Deucher@amd.com>; Sierra 
>>> Guiza, Alejandro
>>> > (Alex) <Alex.Sierra@amd.com>; Kasiviswanathan, Harish
>>> > <Harish.Kasiviswanathan@amd.com>
>>> > *Subject:* Re: [PATCH] drm/amdkfd: Don't reuse a VRAM page that is 
>>> still referenced
>>> >
>>> >
>>> > On 10/26/2026 1:12 PM, Mishra, Apurv wrote:
>>> >
>>> >      AMD General Hi, @Chen, Xiaogang <mailto:Xiaogang.Chen@amd.com 
>>> <mailto:Xiaogang.Chen@amd.com>>
>>> >      <mailto:Xiaogang.Chen@amd.com 
>>> <mailto:Xiaogang.Chen@amd.com>>, thank you for the review. The two 
>>> migrations
>>> >      don't overlap on that address; they run back-to-back. What 
>>> overlaps is the
>>> >      lifetime of the VRAM page. This was reproduced with ASan and 
>>> XNACK, which
>>> >      make concurrent CPU and GPU faults on the same ranges 
>>> frequently. As per the
>>> >      logs (ROCM-31012 
>>> <https://amd-hub.atlassian.net/browse/ROCM-31012 
>>> <https://amd-hub.atlassian.net/browse/ROCM-31012>> <https://
>>> >      amd-hub.atlassian.net/browse/ROCM-31012>):  * A CPU fault 
>>> enters /
>>> >      do_swap_page()/, takes a reference on VRAM page P, and /
>>> >        svm_migrate_to_ram/() moves the data to system page S. The 
>>> PTE now points
>>> >      to    S, but /do_swap_page/() still holds P until 
>>> /migrate_to_ram/()
>>> >      returns.  *    About 66 µs later, a GPU retry fault migrates 
>>> the range back
>>> >      to VRAM. src =    S with /MIGRATE_PFN_MIGRATE /set is correct 
>>> here, because
>>> >      the data really is    in system RAM.  *    KFD reuses the 
>>> /svm_bo/, which P
>>> >      keeps alive, and gets P again as the    destination. 
>>> /zone_device_page_init/
>>> >      (P) runs with ref=1 (traced) and    overwrites the refcount.  *
>>> >
>>> > How KFD reuses same P? From the description above CPU fault has 
>>> not finished
>>> > because  svm_migrate_to_ram has not returned, P has not been 
>>> returned to KFD
>>> > driver, so P still has reference count.
>>> >
>>> > Then GPU page fault happen on same range. For each migration on a 
>>> prange there
>>> > is prange->migrate_mutex to have migration on the prange happen 
>>> exclusively.
>>> > Then how can svm_migrate_to_vram enter migration if 
>>> prange->migrate_mutex is
>>> > still hold at svm_migrate_to_ram?
>>> >
>>> > My basic concern is a vram page can only be involved at one 
>>> migration at a
>>> > moment. If it is getting migrated in two migrations at same time 
>>> with difference
>>> > direction there is syn issue. Checking the page ref here to avoid 
>>> migration is
>>> > not fixing the root cause.
>>> >
>>> > Regards
>>> >
>>> > Xiaogang
>>> >
>>> >          The CPU fault's /put_page/(P) frees P mid-migration and 
>>> clears its
>>> >        mapping. /migrate_vma_finalize/() misses that PTE (263 of 
>>> 264 restored),
>>> >      and    it's left pointing at S. S is freed, and the next 
>>> /hmm_range_fault /
>>> >      hits the    BUG_ON in /swapops.h:504/. The trace and the 
>>> panic registers
>>> >      match this page and S exactly. With the fix, the /refcount 
>>> /check skipped a
>>> >      busy page 705 times on the repro host with no panic. Regards, 
>>> Apurv
>>> > 
>>> -------------------------------------------------------------------------------- 
>>> *From:* Chen, Xiaogang <Xiaogang.Chen@amd.com> 
>>> <mailto:Xiaogang.Chen@amd.com <mailto:Xiaogang.Chen@amd.com>> 
>>> *Sent:* Monday, October 26, 2026 10:32 AM *To:* Mishra, Apurv 
>>> <Apurv.Mishra@amd.com> <mailto:Apurv.Mishra@amd.com 
>>> <mailto:Apurv.Mishra@amd.com>>; amd-gfx@lists.freedesktop.org 
>>> <mailto:amd-gfx@lists.freedesktop.org 
>>> <mailto:amd-gfx@lists.freedesktop.org>> <amd- 
>>> gfx@lists.freedesktop.org> <mailto:amd-gfx@lists.freedesktop.org 
>>> <mailto:amd-gfx@lists.freedesktop.org>> *Cc:* Deucher, Alexander 
>>> <Alexander.Deucher@amd.com> <mailto:Alexander.Deucher@amd.com 
>>> <mailto:Alexander.Deucher@amd.com>>; Sierra Guiza, Alejandro (Alex) 
>>> <Alex.Sierra@amd.com> <mailto:Alex.Sierra@amd.com 
>>> <mailto:Alex.Sierra@amd.com>>; Kasiviswanathan, Harish 
>>> <Harish.Kasiviswanathan@amd.com> 
>>> <mailto:Harish.Kasiviswanathan@amd.com 
>>> <mailto:Harish.Kasiviswanathan@amd.com>> *Subject:* Re: [PATCH] 
>>> drm/amdkfd: Don't reuse a VRAM page that is still referenced On 
>>> 10/23/2026 12:17 PM, Apurv Mishra wrote:    In 
>>> svm_migrate_copy_to_vram(), skip VRAM pages with a non-zero refcount 
>>> and    leave those pages in system memory for this migration. When 
>>> an svm_bo is    reused, a VRAM page can still be held by an 
>>> in-flight CPU fault    (do_swap_page -> svm_migrate_to_ram). 
>>> Migrating to VRAM then re-initializes the page via 
>>> zone_device_page_init(), resetting its refcount. The fault's    late 
>>> put_page() frees the page mid-migration, so 
>>> migrate_vma_finalize()    never restores that PTE. It is left 
>>> pointing at a freed system page and    hmm_range_fault() hits BUG_ON 
>>> in pfn_swap_entry_to_page() (swapops.h). If there is cpu fault the 
>>> data is in vram page. If at same time driver is migrating data from 
>>> sys->vram  migrate->src[i] & MIGRATE_PFN_MIGRATE should be false 
>>> since the data is already at device side. Then if you got a  
>>> MIGRATE_PFN_MIGRAT sys ram page at svm_migrate_copy_to_vram after 
>>> migrate_vma_setup, but cpu page fault also happened on same page 
>>> there is a contradict. So, I do not see this scenario can happen or 
>>> the real cause is revealed. Regards Xiaogang    Signed-off-by: Apurv 
>>> Mishra <Apurv.Mishra@amd.com> <mailto:Apurv.Mishra@amd.com 
>>> <mailto:Apurv.Mishra@amd.com>> <mailto:Apurv.Mishra@amd.com 
>>> <mailto:Apurv.Mishra@amd.com>> <mailto:Apurv.Mishra@amd.com 
>>> <mailto:Apurv.Mishra@amd.com>> --- 
>>> drivers/gpu/drm/amd/amdkfd/kfd_migrate.c |    20 
>>> +++++++++++++++----- 1 file changed, 15 insertions(+), 5 
>>> deletions(-)    diff --git 
>>> a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd/    
>>> amdkfd/kfd_migrate.c index 8b96e1fe741a..1eb92ac6eb05 100644 --- 
>>> a/drivers/ gpu/drm/amd/amdkfd/kfd_migrate.c +++ 
>>> b/drivers/gpu/drm/amd/amdkfd/    kfd_migrate.c @@ -297,16 +297,26 @@ 
>>> svm_migrate_copy_to_vram(struct kfd_node    *node, struct svm_range 
>>> *prange, amdgpu_res_first(prange->ttm_res,    ttm_res_offset, npages 
>>> << PAGE_SHIFT, &cursor); for (i = j = 0; (i < npages)    && (mpages 
>>> < migrate->cpages); i++) { - struct page *spage; + struct page    
>>> *spage = migrate_pfn_to_page(migrate->src[i]); if (migrate->src[i] 
>>> &    MIGRATE_PFN_MIGRATE) { dst[i] = cursor.start + (j << 
>>> PAGE_SHIFT); migrate- >dst[i] = svm_migrate_addr_to_pfn(adev, 
>>> dst[i]); - svm_migrate_get_vram_page(prange, migrate->dst[i]); - 
>>> migrate->dst[i] =    migrate_pfn(migrate->dst[i]); - mpages++; + /* 
>>> + * A reused svm_bo page may    still be held by a CPU fault. + * 
>>> Reinitializing it would free it under this migration, + * so leave 
>>> this page in system memory. + */ + if 
>>> (page_ref_count(pfn_to_page(migrate->dst[i]))) { + dst[i] = 0; + 
>>> migrate-     >dst[i] = 0; + spage = NULL; + } else { + 
>>> svm_migrate_get_vram_page(prange,    migrate->dst[i]); + 
>>> migrate->dst[i] = migrate_pfn(migrate->dst[i]); + mpages++; + } } - 
>>> spage = migrate_pfn_to_page(migrate->src[i]); if (spage && 
>>> !is_zone_device_page(spage)) { src[i] = dma_map_page(dev, spage, 
>>> 0,    PAGE_SIZE, DMA_BIDIRECTIONAL);
>>> >
>>

--------------Gjh0zXyMii5ZiFCRluZyKcWk
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <br>
    <br>
    <div class="moz-cite-prefix">On 2026-11-03 12:09, Chen, Xiaogang
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:fe5f9b54-0516-4a83-ad54-c982dc161523@amd.com">
      <br>
      On 11/3/2026 10:57 AM, Philip Yang wrote:
      <br>
      <blockquote type="cite">
        <br>
        <br>
        On 2026-11-02 18:32, Mishra, Apurv wrote:
        <br>
        <blockquote type="cite">AMD General
          <br>
          <br>
          AMD General
          <br>
          <br>
          Hi, @Chen, Xiaogang <a class="moz-txt-link-rfc2396E" href="mailto:Xiaogang.Chen@amd.com">&lt;mailto:Xiaogang.Chen@amd.com&gt;</a>,
          following up on your comment...
          <br>
          <br>
          P's other user is |do_swap_page()|'s own pin. On Ubuntu 6.8,
          |do_swap_page()| calls |get_page()|, then |migrate_to_ram()|,
          then |put_page()| (/mm/memory.c:3861–3864/). The extra
          reference outlives |migrate_mutex|. By then P's data has
          already moved to S, and the PTE points to S, so nothing else
          is wrong.
          <br>
          <br>
          The wrong place is KFD's reuse. |svm_range_validate_svm_bo()|
          reuses the |svm_bo| because P's pin keeps it alive.
          |svm_migrate_copy_to_vram()| then hands out P by offset
          without checking it, while |zone_device_page_init()| requires
          the page to be free. The fix adds that check where KFD hands
          out the page. When the pin is still there, the page stays in
          system memory with a valid PTE, and the next GPU fault
          migrates it normally.
          <br>
          <br>
          Mainline is the same. |do_swap_page()| now holds the page lock
          across `migrate_to_ram()`, but `zone_device_page_init()`
          resets the refcount before `lock_page()`.&nbsp;The race remains on
          mainline, because upstream KFD has no such check. My patch
          adds it. This has been tested and verified.
          <br>
          <br>
          Adding @Faizal, Sahil <a class="moz-txt-link-rfc2396E" href="mailto:Sahil.Faizal@amd.com">&lt;mailto:Sahil.Faizal@amd.com&gt;</a>&nbsp;for
          updates as the fix needs to merge soon.
          <br>
        </blockquote>
        This is the corner case I tried to fix with the patch
        &quot;drm/amdkfd: Fix svm_bo and vram page refcount&quot;. That patch was
        rejected because we cannot take a page that is not free and
        treat it as free and safe to use. The approach here makes sense
        to me: if the page has not been freed, we skip it. With that
        said, this patch is
        <br>
      </blockquote>
      <br>
      If the page has not been freed HMM page collect will set
      (migrate-&gt;src[i] &amp; MIGRATE_PFN_MIGRATE) to false. The
      explanation from this patch is do_swap_page does not release vram
      page during cpu page fault recovery, then page collection by page
      table walk would see pte sill point to device memory, then not
      collect this page.&nbsp;<br>
    </blockquote>
    This issue isn't with the source page, it's with the destination
    VRAM page, which still has a non-zero refcount after migrating to
    RAM. We cannot assume every VRAM page has been freed and
    zero-initialise it, so we skip it and map to the GPU with the system
    page instead.<br>
    <br>
    Regards,<br>
    Philip
    <blockquote type="cite" cite="mid:fe5f9b54-0516-4a83-ad54-c982dc161523@amd.com"><br>
      If this explanation is right it is not drive issue. Driver does
      data migration, not decide which page can be migrated. There is
      contradict in this explanation. I suspect the real cause is not
      revealed.
      <br>
      <br>
      Regards
      <br>
      <br>
      Xiaogang
      <br>
      <br>
      <blockquote type="cite">
        <br>
        Reviewed-by: Philip Yang <a class="moz-txt-link-rfc2396E" href="mailto:Philip.Yang@amd.com">&lt;Philip.Yang@amd.com&gt;</a>
        <br>
        <blockquote type="cite">
          <br>
          Regards,
          <br>
          Apurv
          <br>
          <br>
------------------------------------------------------------------------
          <br>
          *From:* Chen, Xiaogang <a class="moz-txt-link-rfc2396E" href="mailto:Xiaogang.Chen@amd.com">&lt;Xiaogang.Chen@amd.com&gt;</a>
          <br>
          *Sent:* Wednesday, October 28, 2026 6:41 PM
          <br>
          *To:* Mishra, Apurv <a class="moz-txt-link-rfc2396E" href="mailto:Apurv.Mishra@amd.com">&lt;Apurv.Mishra@amd.com&gt;</a>;
          <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.org</a>
          <a class="moz-txt-link-rfc2396E" href="mailto:amd-gfx@lists.freedesktop.org">&lt;amd-gfx@lists.freedesktop.org&gt;</a>
          <br>
          *Cc:* Deucher, Alexander <a class="moz-txt-link-rfc2396E" href="mailto:Alexander.Deucher@amd.com">&lt;Alexander.Deucher@amd.com&gt;</a>;
          Sierra Guiza, Alejandro (Alex) <a class="moz-txt-link-rfc2396E" href="mailto:Alex.Sierra@amd.com">&lt;Alex.Sierra@amd.com&gt;</a>;
          Kasiviswanathan, Harish <a class="moz-txt-link-rfc2396E" href="mailto:Harish.Kasiviswanathan@amd.com">&lt;Harish.Kasiviswanathan@amd.com&gt;</a>
          <br>
          *Subject:* Re: [PATCH] drm/amdkfd: Don't reuse a VRAM page
          that is still referenced
          <br>
          <br>
          On 10/27/2026 8:19 PM, Mishra, Apurv wrote:
          <br>
          &gt; AMD General
          <br>
          &gt;
          <br>
          &gt; Hi, @Chen, Xiaogang &lt;<a class="moz-txt-link-freetext" href="mailto:Xiaogang.Chen@amd.com">mailto:Xiaogang.Chen@amd.com</a>
          <a class="moz-txt-link-rfc2396E" href="mailto:Xiaogang.Chen@amd.com">&lt;mailto:Xiaogang.Chen@amd.com&gt;</a>&gt;,
          <br>
          &gt;
          <br>
          &gt; The migrations don't overlap. |migrate_mutex| serializes
          them, but it doesn't
          <br>
          &gt; cover P's last reference:
          <br>
          &gt;
          <br>
          &gt;&nbsp;&nbsp;&nbsp; *
          <br>
          &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |svm_migrate_to_ram()| releases
          |prange-&gt;migrate_mutex| at /
          <br>
          &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfd_migrate.c:1073/, after the VRAM→RAM migration
          has finished and before
          <br>
          &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; the function returns.
          <br>
          &gt;&nbsp;&nbsp;&nbsp; *
          <br>
          &gt;
          <br>
          &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |do_swap_page()| drops its own reference on P only
          after |migrate_to_ram()|
          <br>
          &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; returns, at /mm/memory.c:4851–4853/.
          <br>
          <br>
          Before do_swap-page drops the last ref on P the cpu mapping of
          fault
          <br>
          address has not been changed. Then at following sys-&gt;vram
          the
          <br>
          migrate_vma_walk_ops-&gt;pmd_entry will not collect this
          source(sys) page
          <br>
          because the address there still point to device private
          page(since you
          <br>
          got cpu page fault it is device private memory). Then
          (migrate-&gt;src[i] &amp;
          <br>
          MIGRATE_PFN_MIGRATE) is false.
          <br>
          <br>
          If P got used at sys-&gt;vram, but P is still used by someone
          else
          <br>
          something wrong is in other places. Skipping migration does
          not solve it.
          <br>
          <br>
          Regards
          <br>
          <br>
          Xiaogang
          <br>
          <br>
          <br>
          &gt; So, the GPU fault takes |migrate_mutex| legitimately,
          while P still has |
          <br>
          &gt; do_swap_page()|'s reference. KFD gets P back without P
          ever being freed. VRAM
          <br>
          &gt; destinations come from the |svm_bo| by offset
          (`cursor.start + j`), not from a
          <br>
          &gt; pool of free pages. That |svm_bo| is still alive because
          P holds a reference on
          <br>
          &gt; it until P is freed, so |svm_range_validate_svm_bo()|
          reuses it and the same
          <br>
          &gt; offset gives P again. Nothing checks whether P's previous
          user is done with it.
          <br>
          &gt;
          <br>
          &gt; Regards,
          <br>
          &gt; Apurv
          <br>
          &gt;
          <br>
          &gt;
          <br>
          &gt;
--------------------------------------------------------------------------------<br>
          &gt; *From:* Chen, Xiaogang <a class="moz-txt-link-rfc2396E" href="mailto:Xiaogang.Chen@amd.com">&lt;Xiaogang.Chen@amd.com&gt;</a>
          <br>
          &gt; *Sent:* Monday, October 26, 2026 5:27 PM
          <br>
          &gt; *To:* Mishra, Apurv <a class="moz-txt-link-rfc2396E" href="mailto:Apurv.Mishra@amd.com">&lt;Apurv.Mishra@amd.com&gt;</a>;
          <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.org</a> &lt;amd-
          <br>
          &gt; <a class="moz-txt-link-abbreviated" href="mailto:gfx@lists.freedesktop.org">gfx@lists.freedesktop.org</a>&gt;
          <br>
          &gt; *Cc:* Deucher, Alexander
          <a class="moz-txt-link-rfc2396E" href="mailto:Alexander.Deucher@amd.com">&lt;Alexander.Deucher@amd.com&gt;</a>; Sierra Guiza, Alejandro
          <br>
          &gt; (Alex) <a class="moz-txt-link-rfc2396E" href="mailto:Alex.Sierra@amd.com">&lt;Alex.Sierra@amd.com&gt;</a>; Kasiviswanathan,
          Harish
          <br>
          &gt; <a class="moz-txt-link-rfc2396E" href="mailto:Harish.Kasiviswanathan@amd.com">&lt;Harish.Kasiviswanathan@amd.com&gt;</a>
          <br>
          &gt; *Subject:* Re: [PATCH] drm/amdkfd: Don't reuse a VRAM
          page that is still referenced
          <br>
          &gt;
          <br>
          &gt;
          <br>
          &gt; On 10/26/2026 1:12 PM, Mishra, Apurv wrote:
          <br>
          &gt;
          <br>
          &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMD General Hi, @Chen, Xiaogang
          &lt;<a class="moz-txt-link-freetext" href="mailto:Xiaogang.Chen@amd.com">mailto:Xiaogang.Chen@amd.com</a>
          <a class="moz-txt-link-rfc2396E" href="mailto:Xiaogang.Chen@amd.com">&lt;mailto:Xiaogang.Chen@amd.com&gt;</a>&gt;
          <br>
          &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &lt;<a class="moz-txt-link-freetext" href="mailto:Xiaogang.Chen@amd.com">mailto:Xiaogang.Chen@amd.com</a>
          <a class="moz-txt-link-rfc2396E" href="mailto:Xiaogang.Chen@amd.com">&lt;mailto:Xiaogang.Chen@amd.com&gt;</a>&gt;, thank you for the
          review. The two migrations
          <br>
          &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; don't overlap on that address; they run
          back-to-back. What overlaps is the
          <br>
          &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; lifetime of the VRAM page. This was reproduced with
          ASan and XNACK, which
          <br>
          &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; make concurrent CPU and GPU faults on the same
          ranges frequently. As per the
          <br>
          &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; logs (ROCM-31012
          &lt;<a class="moz-txt-link-freetext" href="https://amd-hub.atlassian.net/browse/ROCM-31012">https://amd-hub.atlassian.net/browse/ROCM-31012</a>
          <a class="moz-txt-link-rfc2396E" href="https://amd-hub.atlassian.net/browse/ROCM-31012">&lt;https://amd-hub.atlassian.net/browse/ROCM-31012&gt;</a>&gt;
          &lt;https://
          <br>
          &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amd-hub.atlassian.net/browse/ROCM-31012&gt;):&nbsp; *&nbsp;&nbsp;&nbsp;
          A CPU fault enters /
          <br>
          &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; do_swap_page()/, takes a reference on VRAM page P,
          and /
          <br>
          &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; svm_migrate_to_ram/() moves the data to system
          page S. The PTE now points
          <br>
          &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; to&nbsp;&nbsp;&nbsp; S, but /do_swap_page/() still holds P until
          /migrate_to_ram/()
          <br>
          &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; returns.&nbsp; *&nbsp;&nbsp;&nbsp; About 66 µs later, a GPU retry fault
          migrates the range back
          <br>
          &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; to VRAM. src =&nbsp;&nbsp;&nbsp; S with /MIGRATE_PFN_MIGRATE /set
          is correct here, because
          <br>
          &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; the data really is&nbsp;&nbsp;&nbsp; in system RAM.&nbsp; *&nbsp;&nbsp;&nbsp; KFD
          reuses the /svm_bo/, which P
          <br>
          &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; keeps alive, and gets P again as the&nbsp;&nbsp;&nbsp; destination.
          /zone_device_page_init/
          <br>
          &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (P) runs with ref=1 (traced) and&nbsp;&nbsp;&nbsp; overwrites the
          refcount.&nbsp; *
          <br>
          &gt;
          <br>
          &gt; How KFD reuses same P? From the description above CPU
          fault has not finished
          <br>
          &gt; because&nbsp; svm_migrate_to_ram has not returned, P has not
          been returned to KFD
          <br>
          &gt; driver, so P still has reference count.
          <br>
          &gt;
          <br>
          &gt; Then GPU page fault happen on same range. For each
          migration on a prange there
          <br>
          &gt; is prange-&gt;migrate_mutex to have migration on the
          prange happen exclusively.
          <br>
          &gt; Then how can svm_migrate_to_vram enter migration if
          prange-&gt;migrate_mutex is
          <br>
          &gt; still hold at svm_migrate_to_ram?
          <br>
          &gt;
          <br>
          &gt; My basic concern is a vram page can only be involved at
          one migration at a
          <br>
          &gt; moment. If it is getting migrated in two migrations at
          same time with difference
          <br>
          &gt; direction there is syn issue. Checking the page ref here
          to avoid migration is
          <br>
          &gt; not fixing the root cause.
          <br>
          &gt;
          <br>
          &gt; Regards
          <br>
          &gt;
          <br>
          &gt; Xiaogang
          <br>
          &gt;
          <br>
          &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; The CPU fault's /put_page/(P) frees P
          mid-migration and clears its
          <br>
          &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mapping. /migrate_vma_finalize/() misses that PTE
          (263 of 264 restored),
          <br>
          &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; and&nbsp;&nbsp;&nbsp; it's left pointing at S. S is freed, and the
          next /hmm_range_fault /
          <br>
          &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hits the&nbsp;&nbsp;&nbsp; BUG_ON in /swapops.h:504/. The trace and
          the panic registers
          <br>
          &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; match this page and S exactly. With the fix, the
          /refcount /check skipped a
          <br>
          &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; busy page 705 times on the repro host with no panic.
          Regards, Apurv
          <br>
          &gt;
--------------------------------------------------------------------------------
          *From:* Chen, Xiaogang <a class="moz-txt-link-rfc2396E" href="mailto:Xiaogang.Chen@amd.com">&lt;Xiaogang.Chen@amd.com&gt;</a>
          &lt;<a class="moz-txt-link-freetext" href="mailto:Xiaogang.Chen@amd.com">mailto:Xiaogang.Chen@amd.com</a>
          <a class="moz-txt-link-rfc2396E" href="mailto:Xiaogang.Chen@amd.com">&lt;mailto:Xiaogang.Chen@amd.com&gt;</a>&gt; *Sent:* Monday,
          October 26, 2026 10:32 AM *To:* Mishra, Apurv
          <a class="moz-txt-link-rfc2396E" href="mailto:Apurv.Mishra@amd.com">&lt;Apurv.Mishra@amd.com&gt;</a> &lt;<a class="moz-txt-link-freetext" href="mailto:Apurv.Mishra@amd.com">mailto:Apurv.Mishra@amd.com</a>
          <a class="moz-txt-link-rfc2396E" href="mailto:Apurv.Mishra@amd.com">&lt;mailto:Apurv.Mishra@amd.com&gt;</a>&gt;;
          <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.org</a>
          &lt;<a class="moz-txt-link-freetext" href="mailto:amd-gfx@lists.freedesktop.org">mailto:amd-gfx@lists.freedesktop.org</a>
          <a class="moz-txt-link-rfc2396E" href="mailto:amd-gfx@lists.freedesktop.org">&lt;mailto:amd-gfx@lists.freedesktop.org&gt;</a>&gt; &lt;amd-
          <a class="moz-txt-link-abbreviated" href="mailto:gfx@lists.freedesktop.org">gfx@lists.freedesktop.org</a>&gt;
          &lt;<a class="moz-txt-link-freetext" href="mailto:amd-gfx@lists.freedesktop.org">mailto:amd-gfx@lists.freedesktop.org</a>
          <a class="moz-txt-link-rfc2396E" href="mailto:amd-gfx@lists.freedesktop.org">&lt;mailto:amd-gfx@lists.freedesktop.org&gt;</a>&gt; *Cc:*
          Deucher, Alexander <a class="moz-txt-link-rfc2396E" href="mailto:Alexander.Deucher@amd.com">&lt;Alexander.Deucher@amd.com&gt;</a>
          &lt;<a class="moz-txt-link-freetext" href="mailto:Alexander.Deucher@amd.com">mailto:Alexander.Deucher@amd.com</a>
          <a class="moz-txt-link-rfc2396E" href="mailto:Alexander.Deucher@amd.com">&lt;mailto:Alexander.Deucher@amd.com&gt;</a>&gt;; Sierra Guiza,
          Alejandro (Alex) <a class="moz-txt-link-rfc2396E" href="mailto:Alex.Sierra@amd.com">&lt;Alex.Sierra@amd.com&gt;</a>
          &lt;<a class="moz-txt-link-freetext" href="mailto:Alex.Sierra@amd.com">mailto:Alex.Sierra@amd.com</a>
          <a class="moz-txt-link-rfc2396E" href="mailto:Alex.Sierra@amd.com">&lt;mailto:Alex.Sierra@amd.com&gt;</a>&gt;; Kasiviswanathan,
          Harish <a class="moz-txt-link-rfc2396E" href="mailto:Harish.Kasiviswanathan@amd.com">&lt;Harish.Kasiviswanathan@amd.com&gt;</a>
          &lt;<a class="moz-txt-link-freetext" href="mailto:Harish.Kasiviswanathan@amd.com">mailto:Harish.Kasiviswanathan@amd.com</a>
          <a class="moz-txt-link-rfc2396E" href="mailto:Harish.Kasiviswanathan@amd.com">&lt;mailto:Harish.Kasiviswanathan@amd.com&gt;</a>&gt; *Subject:*
          Re: [PATCH] drm/amdkfd: Don't reuse a VRAM page that is still
          referenced On 10/23/2026 12:17 PM, Apurv Mishra wrote:&nbsp;&nbsp;&nbsp; In
          svm_migrate_copy_to_vram(), skip VRAM pages with a non-zero
          refcount and&nbsp;&nbsp;&nbsp; leave those pages in system memory for this
          migration. When an svm_bo is&nbsp;&nbsp;&nbsp; reused, a VRAM page can still
          be held by an in-flight CPU fault&nbsp;&nbsp;&nbsp; (do_swap_page -&gt;
          svm_migrate_to_ram). Migrating to VRAM then re-initializes the
          page via zone_device_page_init(), resetting its refcount. The
          fault's&nbsp;&nbsp;&nbsp; late put_page() frees the page mid-migration, so
          migrate_vma_finalize()&nbsp;&nbsp;&nbsp; never restores that PTE. It is left
          pointing at a freed system page and&nbsp;&nbsp;&nbsp; hmm_range_fault() hits
          BUG_ON in pfn_swap_entry_to_page() (swapops.h). If there is
          cpu fault the data is in vram page. If at same time driver is
          migrating data from sys-&gt;vram&nbsp; migrate-&gt;src[i] &amp;
          MIGRATE_PFN_MIGRATE should be false since the data is already
          at device side. Then if you got a&nbsp; MIGRATE_PFN_MIGRAT sys ram
          page at svm_migrate_copy_to_vram after migrate_vma_setup, but
          cpu page fault also happened on same page there is a
          contradict. So, I do not see this scenario can happen or the
          real cause is revealed. Regards Xiaogang&nbsp;&nbsp;&nbsp; Signed-off-by:
          Apurv Mishra <a class="moz-txt-link-rfc2396E" href="mailto:Apurv.Mishra@amd.com">&lt;Apurv.Mishra@amd.com&gt;</a>
          &lt;<a class="moz-txt-link-freetext" href="mailto:Apurv.Mishra@amd.com">mailto:Apurv.Mishra@amd.com</a>
          <a class="moz-txt-link-rfc2396E" href="mailto:Apurv.Mishra@amd.com">&lt;mailto:Apurv.Mishra@amd.com&gt;</a>&gt;
          &lt;<a class="moz-txt-link-freetext" href="mailto:Apurv.Mishra@amd.com">mailto:Apurv.Mishra@amd.com</a>
          <a class="moz-txt-link-rfc2396E" href="mailto:Apurv.Mishra@amd.com">&lt;mailto:Apurv.Mishra@amd.com&gt;</a>&gt;
          &lt;<a class="moz-txt-link-freetext" href="mailto:Apurv.Mishra@amd.com">mailto:Apurv.Mishra@amd.com</a>
          <a class="moz-txt-link-rfc2396E" href="mailto:Apurv.Mishra@amd.com">&lt;mailto:Apurv.Mishra@amd.com&gt;</a>&gt; ---
          drivers/gpu/drm/amd/amdkfd/kfd_migrate.c |&nbsp;&nbsp;&nbsp; 20
          +++++++++++++++----- 1 file changed, 15 insertions(+), 5
          deletions(-)&nbsp;&nbsp;&nbsp; diff --git
          a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
          b/drivers/gpu/drm/amd/&nbsp;&nbsp;&nbsp; amdkfd/kfd_migrate.c index
          8b96e1fe741a..1eb92ac6eb05 100644 --- a/drivers/
          gpu/drm/amd/amdkfd/kfd_migrate.c +++
          b/drivers/gpu/drm/amd/amdkfd/&nbsp;&nbsp;&nbsp; kfd_migrate.c @@ -297,16
          +297,26 @@ svm_migrate_copy_to_vram(struct kfd_node&nbsp;&nbsp;&nbsp; *node,
          struct svm_range *prange,
          amdgpu_res_first(prange-&gt;ttm_res,&nbsp;&nbsp;&nbsp; ttm_res_offset, npages
          &lt;&lt; PAGE_SHIFT, &amp;cursor); for (i = j = 0; (i &lt;
          npages)&nbsp;&nbsp;&nbsp; &amp;&amp; (mpages &lt; migrate-&gt;cpages); i++) {
          - struct page *spage; + struct page&nbsp;&nbsp;&nbsp; *spage =
          migrate_pfn_to_page(migrate-&gt;src[i]); if
          (migrate-&gt;src[i] &amp;&nbsp;&nbsp;&nbsp; MIGRATE_PFN_MIGRATE) { dst[i] =
          cursor.start + (j &lt;&lt; PAGE_SHIFT); migrate-&nbsp;&nbsp;&nbsp;&nbsp;
          &gt;dst[i] = svm_migrate_addr_to_pfn(adev, dst[i]); -
          svm_migrate_get_vram_page(prange, migrate-&gt;dst[i]); -
          migrate-&gt;dst[i] =&nbsp;&nbsp;&nbsp; migrate_pfn(migrate-&gt;dst[i]); -
          mpages++; + /* + * A reused svm_bo page may&nbsp;&nbsp;&nbsp; still be held
          by a CPU fault. + * Reinitializing it would free it under this
          migration, + * so leave this page in system memory. + */ + if
          (page_ref_count(pfn_to_page(migrate-&gt;dst[i]))) { + dst[i] =
          0; + migrate-&nbsp;&nbsp;&nbsp;&nbsp; &gt;dst[i] = 0; + spage = NULL; + } else { +
          svm_migrate_get_vram_page(prange,&nbsp;&nbsp;&nbsp; migrate-&gt;dst[i]); +
          migrate-&gt;dst[i] = migrate_pfn(migrate-&gt;dst[i]); +
          mpages++; + } } - spage =
          migrate_pfn_to_page(migrate-&gt;src[i]); if (spage&nbsp;&nbsp;&nbsp;
          &amp;&amp; !is_zone_device_page(spage)) { src[i] =
          dma_map_page(dev, spage, 0,&nbsp;&nbsp;&nbsp; PAGE_SIZE,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
          DMA_BIDIRECTIONAL);
          <br>
          &gt;
          <br>
        </blockquote>
        <br>
      </blockquote>
    </blockquote>
    <br>
  </body>
</html>

--------------Gjh0zXyMii5ZiFCRluZyKcWk--
