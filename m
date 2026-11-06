Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B47C4606A336
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Nov 2026 15:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=aozO9Rk1
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 18476112E3E;
	Fri,  6 Nov 2026 15:26:37 +0000 (UTC)
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010017.outbound.protection.outlook.com [52.101.85.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3BD99112E4F
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Nov 2026 15:26:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zAIJErsfGhmnQRAlo00vS1nrsd1IUCz0+kpmTucBRQYJqBGF3Nh1VfzMY1//nJkeYgPWtm+n4P/tVq1oGmuhrNGT3i2UW7itJwkHmEadPJ5L4EmBiJwP0N4FFmepNqVw9iO+I6Rrdg8QHZt2xNyQpkrmexiaNzZC3g6rlxhuB1ry+g4uLHdGcQKqDhmEIL+zga3ILhk7K/CGSe1IehE4NIzhnec/0I4x2try2qsxNoDi0uFvHGZTPkOqlA3X2Qtaao0XYwR/QoCBB5iBQG1x9jyqsQT2eElnlMukryU4SU/AmS2XlfXGA1S4lcbHtvs7GX0FRwe9k+OQsxDacSyG2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2Iny7viCN0jdsoI+5fRxJ20CL3hrsQPHo7FLmtk7piQ=;
 b=e98NTYEgpS5I63b/6C8Ya5FSNqeis78QtqyAg5rv0SUIHlwVbMGoSm9QnDv4ux8ESBqnj1PJYyhs/lp3ShrYVf7NP7AJAwqFDTdvPNIljB/wUo/0R7hrTENEE4nW9QNgibAwbDHVnKH/DCOH5ItK1laDzkUAF7WNSoGI6MqY27K5z4y31J+T05z0merphC/2Td78lIpkhrpagAE5KKAbaplnoUyXrRWd8T6Gdlhs5Pf8RpylVZjvdVeY/aZZFGJ+VVuwSDSRST7DOzfaRAWyIjrsmnFHOti6gJ6zUAXuXkoFbJDJKBLmzgW6bL8kUv3/bXK6tk26RsJ6nrfX9Q4biA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2Iny7viCN0jdsoI+5fRxJ20CL3hrsQPHo7FLmtk7piQ=;
 b=aozO9Rk1A2ML1pE3Up550lZdpJn3lLClpdEZeqXOqEOmPAFGOJo9o22sQSz54zXo9brtdGYoacoch4pgiXjarsG7iBJrLu7oz/y+BAkrRUao/DIS3cHcWFdffuH2RR5jDpKgCxyOMUHzrtLEnPUC2Uub7fWtXV793vP8vKupx08=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB8517.namprd12.prod.outlook.com (2603:10b6:208:449::8)
 by PH0PR12MB5631.namprd12.prod.outlook.com (2603:10b6:510:144::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.9; Fri, 6 Nov 2026
 15:26:28 +0000
Received: from IA1PR12MB8517.namprd12.prod.outlook.com
 ([fe80::c47e:c884:f06:1525]) by IA1PR12MB8517.namprd12.prod.outlook.com
 ([fe80::c47e:c884:f06:1525%4]) with mapi id 15.21.0592.009; Fri, 6 Nov 2026
 15:26:27 +0000
Message-ID: <b52094b5-97b6-46b2-a48b-16557626d259@amd.com>
Date: Fri, 6 Nov 2026 09:26:25 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdkfd: Don't reuse a VRAM page that is still
 referenced
To: Philip Yang <yangp@amd.com>, "Mishra, Apurv" <Apurv.Mishra@amd.com>,
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
 <fe5c2998-f19d-4992-b87c-2a498fa109d0@amd.com>
 <fd5bf2a6-6146-499d-9e75-bdcfc51b3ca5@amd.com>
 <b312d42e-817f-46f7-8030-27c33265fbe1@amd.com>
Content-Language: en-US
From: "Chen, Xiaogang" <xiaogang.chen@amd.com>
In-Reply-To: <b312d42e-817f-46f7-8030-27c33265fbe1@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA9PR13CA0121.namprd13.prod.outlook.com
 (2603:10b6:806:27::6) To IA1PR12MB8517.namprd12.prod.outlook.com
 (2603:10b6:208:449::8)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB8517:EE_|PH0PR12MB5631:EE_
X-MS-Office365-Filtering-Correlation-Id: fb02b504-83de-4880-438e-08df3c1a5366
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|23010399003|1800799024|13003099007|18002099003|22082099003|56012099006|4143699003|5023799004|11063799006|3023799007|261009223027099003|261102123227099003|261022105027099003|261022075727099003|261021123027099003|261021121427099003|261021135927099003|261028144727099003|261026140227099003|261026121527099003|10067099003|6133799003;
X-Microsoft-Antispam-Message-Info: Zm6f77cW+VzCuez6hv3ampnT4XKzEBshwy2YjobHidg4cDoTsS05eFoDUG6y20RhrJurIIH3pl5cWOoSxdBlbLfFR4omZIgconptG0MpzTIp5tM36t2WdJFRD3oHlHnYwop1n8rhMLrlqU/QjFjhbEfgdkiFjA/BGDPkjQ5v7p6UHwZbMS4UoTrdPmXqmjFwoFP6TWrUW2wdvcdEDXkkT87r/pfuWT3vz6eiSHhdw+Cmus6OrEvpaIT6JWzMarZLaslFNV4psG4l3bkKTeEMzA9+YNwvbJ2ZNP2iVhV/8U9zo1KfRN5A0zA1aEpxzgbI5bGMTRTeb86o0DHOpY6XXBfQlm68686HavScsJzG0bPmrzfMm3mSnao4A7mTUAUNm9i7IJ3YBM5mrTZ1Hc1cPsriTvCoJ7Rsr7AJrZgPPCeMIkUcJ4MSGQd1bQqhwkKgmXzYfEL/i98EIWlqV0gmk3mjO+7urC3uGe5d1TaFT7TFK1mqpFtlaUzm3A+irobx1XLLWL5zYZQoKzTXLshExe6uXqhUTuN9FAqAkFBvF5eME6CdkC0EfP91lgxMlLW3O2433VXkOsGxpfn1th02/Di6ba5OLb5RqGGrG+o6pi69voTBtN2Iq7iGFXmR/Nju
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR12MB8517.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(13003099007)(18002099003)(22082099003)(56012099006)(4143699003)(5023799004)(11063799006)(3023799007)(261009223027099003)(261102123227099003)(261022105027099003)(261022075727099003)(261021123027099003)(261021121427099003)(261021135927099003)(261028144727099003)(261026140227099003)(261026121527099003)(10067099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bC91SWtRTE1vS01sVTVXWkxDcmUrbjhnT3NOQlBuYTNqblRJSHZpOVNQdm9u?=
 =?utf-8?B?ZjU0NGV4QURxOWE5dHpUVFMvT2NSSnlrd2lkWTFDT2o2bGdzNWg4TFZ4aXJV?=
 =?utf-8?B?M2diRzY1Z01Fd2ZJejFCY1QvQ1pGUTNUV25Kdm5zK1JGTFpLZXl6TVQ2VW1U?=
 =?utf-8?B?Q2tOcmt4bkd0dHplT0hiVHB0QVFqdVN2eVNESEZXSUlLWGNMa2tKb0FENkZN?=
 =?utf-8?B?a2ZpM3Jia05lMGtJT2VVL0QzM0ZpNCt6UTN0dndjRDdtM05EQ0J6RzR4QVNn?=
 =?utf-8?B?NmdXVzBiU2hscTF0WDhCWUErM3c4TWdtL2J5TG9NYVZpQ1ZPRFZrMHFBa3lv?=
 =?utf-8?B?Qld5ZVc4RW1ITDlacm9rbEw0SU53dENCQnZ6UGEzc0xLcVBHRXJ6bVN2S3Ey?=
 =?utf-8?B?VDlJbmhKdlM2SnNlbVJ3akhNYW5Wc0FVY1lFbTlUZ09TZzBlK0J5MDRuL2dR?=
 =?utf-8?B?QWs4TU9ZRGUveE43OEppSmZlZCsyWmk0eTVvN2hQazJkMDJoOHhCOGtrYUU4?=
 =?utf-8?B?Nm1UeDNYNzJHVnJvWmcvNjRlM0JVQ251aW8vTWtwOENobndVNks1UW83VDcy?=
 =?utf-8?B?QUJxbzdJR0pQZmVqNHBKN2c3M3R3R0gvR2hyVXlNTzNHRDBia3RYUUMvaDNR?=
 =?utf-8?B?aWtaSktUNFRJZ1NwRUJSa24vNFJ4a0dQVzFMU1BaUkphNjdpVTRieHJPWDFo?=
 =?utf-8?B?dEZtM3RBa1FSalM0OUhZQ2NOcFdmU0J3ZVIzTVIzZ3U5c0VQR1dJcFhhMEgz?=
 =?utf-8?B?a1hFMC9GWTRNVkxCODFTc1JEMGVpT2lkQnJuSmFkRGgvNE9zaHFyNFJlYU1v?=
 =?utf-8?B?czV5Q2I2VUh3VDJDd2N0VFVBdnRSM1ZrakVXYU1zVWIrK1Z6OGxDbDFscUNZ?=
 =?utf-8?B?VU1tTHJVbmNuNUlGY21PeFdEUHluUW1FUklXOTJ2d3hIdDJVZHNLYm1yV3pL?=
 =?utf-8?B?WjU0bkhvZmNYRTRZSlZkNmI2STIzWUtucmVPeUljdllRU1RhZ2NBT3VSZWZ1?=
 =?utf-8?B?bWJuTkdBbm1HTXNBNk8walNKbTVndUxPWFlmWHNON0MvTGk4VmU0YVN5RzZI?=
 =?utf-8?B?YVNsTGdSYlcySmE0YW51VFBSN2ZoVFFGbmRJSXlQQXNXTE0yUHBLaysxTE1l?=
 =?utf-8?B?MTBySTN5TiswTm1tYUpWclN5SW81Z0tuVVA4VFdCMDVLMko5OFlJREthV3NV?=
 =?utf-8?B?eG40blVRVDRld1FUVTAvVEhGL25WczlWdk1UbFM0M01tK1ZteDdIdlhzRzB3?=
 =?utf-8?B?TGlUZ2ZyR0JVcUR2bHpDNmpXUUM4YWRwRnZmQ1Y1dllZQmhGT3owZ3JCS2tS?=
 =?utf-8?B?Zm9wVXFWWVRkcDhmRnp5dHJtWkM3QUphMzhvU1FJeXVtbmI1Tm1kSmlYeW92?=
 =?utf-8?B?Wllvcis0ZGc1TUtQREJBY2Mrbmd6ZGcxem5IQlFyamU0dXRETWEvR1V4dHpI?=
 =?utf-8?B?YkNLckFQSy9IcW5pNkpzWFR0Q3Bjb0g3dStTVTlXSDMvQzJWT09zcUhZREM0?=
 =?utf-8?B?L2R6WExrcWJWNlFkaU5VZU1SZmw3R2NMVkpYalNMaXVKZVdPeUJSdW1SWUM0?=
 =?utf-8?B?YzNyWmxJM05YTTE2Q1A0QWJvcjZrMGVKVWtCa0toTTRiTUtScGQzWWVGbllp?=
 =?utf-8?B?N2hPT1pWdG9VU2V4d2ZMdFFuL0lNcysyeWdoSE04WlJSdWc5SFIyQnpFYVVh?=
 =?utf-8?B?RmQxa1lvTGNpNVY1ZFNEU09XUzVaczNURkN0d0pXbEtSTzhhUjhvdndpWURX?=
 =?utf-8?B?UXVmOExWdDRCdTZBcGlUQkd2a2hobGhVMGRFdzRMeElUTlMva0Q2VUJxZmVG?=
 =?utf-8?B?TnRPZ1dWWklTVjBxVThNVEkrN2ZTS3VhcXljMjlEZkdvcTlrL2dwb1c2cUlK?=
 =?utf-8?B?Um96WmZrUnJQQ1pJMXRtVThET0l3Mm9jUS83bnk1TC9KdWx0eE5qeHZqem5X?=
 =?utf-8?B?VW5PMGVST3NrMEg4aWtkVktiQVdrZW5ycTZYU2VSVVFtWEFwVi9YZkpYMnlG?=
 =?utf-8?B?a0pWcCtpRnowQkpXdy9IQ0FRQmlrMjRwOEpvaHlDcmFURjkxekdIYXptUTlN?=
 =?utf-8?B?RWhraUd5c3lyd2ZxSllYRTV0OUZBMjZEQVdjb2NMU091Zk51VnRkU085S3M3?=
 =?utf-8?B?bkhoOW5VTHgwQmtVZFNkR3NYQUo2cHh3UDhHLzZmTGtTT3BJNkk3aXlsdy9v?=
 =?utf-8?B?bUU3eDJsVDlCSjF6QTc3aDV4OUlXK0VlRmRxdTZLRTk3NFFrWXYwZnNjNE1T?=
 =?utf-8?B?dWdxekh1TE5CS3dHd2ZCd281ektpOEUyWkFQS2FmSlI2bW1xMERWTGpqVEZm?=
 =?utf-8?Q?4t+/k3afyVbs31xmit?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb02b504-83de-4880-438e-08df3c1a5366
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB8517.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2026 15:26:27.8753 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dEl06kqtS/hbaV2H6rcV5FNeTnXx0+ceMEW50XJ+toyRDMpmmJdupuYpiyXccl+E
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5631
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
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


On 11/5/2026 9:51 AM, Philip Yang wrote:
>
>
> On 2026-11-03 13:43, Chen, Xiaogang wrote:
>>
>> On 11/3/2026 12:26 PM, Philip Yang wrote:
>>>
>>>
>>> On 2026-11-03 12:09, Chen, Xiaogang wrote:
>>>>
>>>> On 11/3/2026 10:57 AM, Philip Yang wrote:
>>>>>
>>>>>
>>>>> On 2026-11-02 18:32, Mishra, Apurv wrote:
>>>>>> AMD General
>>>>>>
>>>>>> AMD General
>>>>>>
>>>>>> Hi, @Chen, Xiaogang <mailto:Xiaogang.Chen@amd.com>, following up 
>>>>>> on your comment...
>>>>>>
>>>>>> P's other user is |do_swap_page()|'s own pin. On Ubuntu 6.8, 
>>>>>> |do_swap_page()| calls |get_page()|, then |migrate_to_ram()|, 
>>>>>> then |put_page()| (/mm/memory.c:3861–3864/). The extra reference 
>>>>>> outlives |migrate_mutex|. By then P's data has already moved to 
>>>>>> S, and the PTE points to S, so nothing else is wrong.
>>>>>>
>>>>>> The wrong place is KFD's reuse. |svm_range_validate_svm_bo()| 
>>>>>> reuses the |svm_bo| because P's pin keeps it alive. 
>>>>>> |svm_migrate_copy_to_vram()| then hands out P by offset without 
>>>>>> checking it, while |zone_device_page_init()| requires the page to 
>>>>>> be free. The fix adds that check where KFD hands out the page. 
>>>>>> When the pin is still there, the page stays in system memory with 
>>>>>> a valid PTE, and the next GPU fault migrates it normally.
>>>>>>
>>>>>> Mainline is the same. |do_swap_page()| now holds the page lock 
>>>>>> across `migrate_to_ram()`, but `zone_device_page_init()` resets 
>>>>>> the refcount before `lock_page()`. The race remains on mainline, 
>>>>>> because upstream KFD has no such check. My patch adds it. This 
>>>>>> has been tested and verified.
>>>>>>
>>>>>> Adding @Faizal, Sahil <mailto:Sahil.Faizal@amd.com> for updates 
>>>>>> as the fix needs to merge soon.
>>>>> This is the corner case I tried to fix with the patch "drm/amdkfd: 
>>>>> Fix svm_bo and vram page refcount". That patch was rejected 
>>>>> because we cannot take a page that is not free and treat it as 
>>>>> free and safe to use. The approach here makes sense to me: if the 
>>>>> page has not been freed, we skip it. With that said, this patch is
>>>>
>>>> If the page has not been freed HMM page collect will set 
>>>> (migrate->src[i] & MIGRATE_PFN_MIGRATE) to false. The explanation 
>>>> from this patch is do_swap_page does not release vram page during 
>>>> cpu page fault recovery, then page collection by page table walk 
>>>> would see pte sill point to device memory, then not collect this page.
>>> This issue isn't with the source page, it's with the destination 
>>> VRAM page, which still has a non-zero refcount after migrating to 
>>> RAM. We cannot assume every VRAM page has been freed and 
>>> zero-initialise it, so we skip it and map to the GPU with the system 
>>> page instead.
>>
>> When HMM allows sys->vram migration on a vram page this vram page 
>> should not be used by someone else. In this case do_swap_page has not 
>> release the vram page, then data is still in vram, then collection 
>> will not collect the sys page correspondent to the vram page since 
>> the vram page is not available and pte at cpu page table still points 
>> to the varm page , then not enter svm path of sys->vram for this vram 
>> page.
> Right, the root cause is hard to follow. Let's start from the CPU page 
> fault: handle_pte_fault on a device-private page -> do_swap_page ->
> ........
>             if (trylock_page(vmf->page)) {
>                 struct dev_pagemap *pgmap;
>
>                 get_page(vmf->page);
>                 pte_unmap_unlock(vmf->pte, vmf->ptl);
>                 pgmap = page_pgmap(vmf->page);
>                 ret = pgmap->ops->migrate_to_ram(vmf);
>
> This is where it races with the GPU page fault. migrate_to_vram can 
> collect the system page, because the CPU mapping on the system page is 
> complete by then, and it reuses the same svm_bo, because the svm_bo 
> refcount has not reached 0 while vmf->page still holds a reference.
>
>
>                 unlock_page(vmf->page);
>
> It then uses this device page, and svm_migrate_get_vram_page() locks 
> the page and resets the refcount.

Yes, but the problem is this type of  vram page ref is not under driver 
control. When the vram page is allowed to be used at sys->device its 
reference must be zero. At zone_device_page_init, there is:

VM_WARN_ON_FOLIO(folio_ref_count(new_folio), new_folio);

If the page ref is not zero, WARN_ON(1) is triggered if CONFIG_DEBUG_VM 
is defined.  I think the kernel used on the system has no 
CONFIG_DEBUG_VM defined. Try kernel with CONFIG_DEBUG_VM=y you would see 
the WARN before HMM complain. HMM expects the vram page is not being 
referenced by anyone before use it.

There is either driver reuses a page that isn't really free or a 
reference leak: a leftover get_page/pin, or a mapping that was never 
released. That is what I mean the root cause is not identified.

>
>                 put_page(vmf->page);

I think what you mean is this put_page at  do_swap_page was called after 
sys->device migration has began. Then the vram page is not 
released(dev_pagemap_ops->folio_free, or svm_migrate_folio_free not got 
called). Then correspondent svm_bo is not released to ttm, then kfd 
either needs to wait the svm_bo got release, or allocates new vram pages 
for this sys->device migration. Either way the vram pages will have zero 
reference number when call svm_migrate_copy_to_vram.

If it is what happened, it is a timing issue between cpu page fault 
handling and vram page release/then got reused. It is driver issue when 
decides whether reuse current vram pages or need wait, or allocate new 
ones.

Regards

Xiaogang


>
> then drops the refcount to 0 ( put_page() has to come after 
> unlock_page(), otherwise releasing the page deadlocks.)
>
> Hope that explains the root cause.
>
> Regards,
> Philip
>>
>> If the explanation in this patch is what happened it is not driver 
>> issue. This type vram page ref count is not under driver control. 
>> Skip migration just covers the real cause.
>>
>> Regards
>>
>> Xiaogang
>>
>>>
>>> Regards,
>>> Philip
>>>>
>>>> If this explanation is right it is not drive issue. Driver does 
>>>> data migration, not decide which page can be migrated. There is 
>>>> contradict in this explanation. I suspect the real cause is not 
>>>> revealed.
>>>>
>>>> Regards
>>>>
>>>> Xiaogang
>>>>
>>>>>
>>>>> Reviewed-by: Philip Yang <Philip.Yang@amd.com>
>>>>>>
>>>>>> Regards,
>>>>>> Apurv
>>>>>>
>>>>>> ------------------------------------------------------------------------ 
>>>>>>
>>>>>> *From:* Chen, Xiaogang <Xiaogang.Chen@amd.com>
>>>>>> *Sent:* Wednesday, October 28, 2026 6:41 PM
>>>>>> *To:* Mishra, Apurv <Apurv.Mishra@amd.com>; 
>>>>>> amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
>>>>>> *Cc:* Deucher, Alexander <Alexander.Deucher@amd.com>; Sierra 
>>>>>> Guiza, Alejandro (Alex) <Alex.Sierra@amd.com>; Kasiviswanathan, 
>>>>>> Harish <Harish.Kasiviswanathan@amd.com>
>>>>>> *Subject:* Re: [PATCH] drm/amdkfd: Don't reuse a VRAM page that 
>>>>>> is still referenced
>>>>>>
>>>>>> On 10/27/2026 8:19 PM, Mishra, Apurv wrote:
>>>>>> > AMD General
>>>>>> >
>>>>>> > Hi, @Chen, Xiaogang <mailto:Xiaogang.Chen@amd.com 
>>>>>> <mailto:Xiaogang.Chen@amd.com>>,
>>>>>> >
>>>>>> > The migrations don't overlap. |migrate_mutex| serializes them, 
>>>>>> but it doesn't
>>>>>> > cover P's last reference:
>>>>>> >
>>>>>> >    *
>>>>>> >      |svm_migrate_to_ram()| releases |prange->migrate_mutex| at /
>>>>>> >      kfd_migrate.c:1073/, after the VRAM→RAM migration has 
>>>>>> finished and before
>>>>>> >      the function returns.
>>>>>> >    *
>>>>>> >
>>>>>> >      |do_swap_page()| drops its own reference on P only after 
>>>>>> |migrate_to_ram()|
>>>>>> >      returns, at /mm/memory.c:4851–4853/.
>>>>>>
>>>>>> Before do_swap-page drops the last ref on P the cpu mapping of fault
>>>>>> address has not been changed. Then at following sys->vram the
>>>>>> migrate_vma_walk_ops->pmd_entry will not collect this source(sys) 
>>>>>> page
>>>>>> because the address there still point to device private 
>>>>>> page(since you
>>>>>> got cpu page fault it is device private memory). Then 
>>>>>> (migrate->src[i] &
>>>>>> MIGRATE_PFN_MIGRATE) is false.
>>>>>>
>>>>>> If P got used at sys->vram, but P is still used by someone else
>>>>>> something wrong is in other places. Skipping migration does not 
>>>>>> solve it.
>>>>>>
>>>>>> Regards
>>>>>>
>>>>>> Xiaogang
>>>>>>
>>>>>>
>>>>>> > So, the GPU fault takes |migrate_mutex| legitimately, while P 
>>>>>> still has |
>>>>>> > do_swap_page()|'s reference. KFD gets P back without P ever 
>>>>>> being freed. VRAM
>>>>>> > destinations come from the |svm_bo| by offset (`cursor.start + 
>>>>>> j`), not from a
>>>>>> > pool of free pages. That |svm_bo| is still alive because P 
>>>>>> holds a reference on
>>>>>> > it until P is freed, so |svm_range_validate_svm_bo()| reuses it 
>>>>>> and the same
>>>>>> > offset gives P again. Nothing checks whether P's previous user 
>>>>>> is done with it.
>>>>>> >
>>>>>> > Regards,
>>>>>> > Apurv
>>>>>> >
>>>>>> >
>>>>>> > 
>>>>>> --------------------------------------------------------------------------------
>>>>>> > *From:* Chen, Xiaogang <Xiaogang.Chen@amd.com>
>>>>>> > *Sent:* Monday, October 26, 2026 5:27 PM
>>>>>> > *To:* Mishra, Apurv <Apurv.Mishra@amd.com>; 
>>>>>> amd-gfx@lists.freedesktop.org <amd-
>>>>>> > gfx@lists.freedesktop.org>
>>>>>> > *Cc:* Deucher, Alexander <Alexander.Deucher@amd.com>; Sierra 
>>>>>> Guiza, Alejandro
>>>>>> > (Alex) <Alex.Sierra@amd.com>; Kasiviswanathan, Harish
>>>>>> > <Harish.Kasiviswanathan@amd.com>
>>>>>> > *Subject:* Re: [PATCH] drm/amdkfd: Don't reuse a VRAM page that 
>>>>>> is still referenced
>>>>>> >
>>>>>> >
>>>>>> > On 10/26/2026 1:12 PM, Mishra, Apurv wrote:
>>>>>> >
>>>>>> >      AMD General Hi, @Chen, Xiaogang 
>>>>>> <mailto:Xiaogang.Chen@amd.com <mailto:Xiaogang.Chen@amd.com>>
>>>>>> >      <mailto:Xiaogang.Chen@amd.com 
>>>>>> <mailto:Xiaogang.Chen@amd.com>>, thank you for the review. The 
>>>>>> two migrations
>>>>>> >      don't overlap on that address; they run back-to-back. What 
>>>>>> overlaps is the
>>>>>> >      lifetime of the VRAM page. This was reproduced with ASan 
>>>>>> and XNACK, which
>>>>>> >      make concurrent CPU and GPU faults on the same ranges 
>>>>>> frequently. As per the
>>>>>> >      logs (ROCM-31012 
>>>>>> <https://amd-hub.atlassian.net/browse/ROCM-31012 
>>>>>> <https://amd-hub.atlassian.net/browse/ROCM-31012>> <https://
>>>>>> >      amd-hub.atlassian.net/browse/ROCM-31012>): * A CPU fault 
>>>>>> enters /
>>>>>> >      do_swap_page()/, takes a reference on VRAM page P, and /
>>>>>> >        svm_migrate_to_ram/() moves the data to system page S. 
>>>>>> The PTE now points
>>>>>> >      to    S, but /do_swap_page/() still holds P until 
>>>>>> /migrate_to_ram/()
>>>>>> >      returns.  *    About 66 µs later, a GPU retry fault 
>>>>>> migrates the range back
>>>>>> >      to VRAM. src =    S with /MIGRATE_PFN_MIGRATE /set is 
>>>>>> correct here, because
>>>>>> >      the data really is    in system RAM.  *    KFD reuses the 
>>>>>> /svm_bo/, which P
>>>>>> >      keeps alive, and gets P again as the destination. 
>>>>>> /zone_device_page_init/
>>>>>> >      (P) runs with ref=1 (traced) and    overwrites the 
>>>>>> refcount.  *
>>>>>> >
>>>>>> > How KFD reuses same P? From the description above CPU fault has 
>>>>>> not finished
>>>>>> > because  svm_migrate_to_ram has not returned, P has not been 
>>>>>> returned to KFD
>>>>>> > driver, so P still has reference count.
>>>>>> >
>>>>>> > Then GPU page fault happen on same range. For each migration on 
>>>>>> a prange there
>>>>>> > is prange->migrate_mutex to have migration on the prange happen 
>>>>>> exclusively.
>>>>>> > Then how can svm_migrate_to_vram enter migration if 
>>>>>> prange->migrate_mutex is
>>>>>> > still hold at svm_migrate_to_ram?
>>>>>> >
>>>>>> > My basic concern is a vram page can only be involved at one 
>>>>>> migration at a
>>>>>> > moment. If it is getting migrated in two migrations at same 
>>>>>> time with difference
>>>>>> > direction there is syn issue. Checking the page ref here to 
>>>>>> avoid migration is
>>>>>> > not fixing the root cause.
>>>>>> >
>>>>>> > Regards
>>>>>> >
>>>>>> > Xiaogang
>>>>>> >
>>>>>> >          The CPU fault's /put_page/(P) frees P mid-migration 
>>>>>> and clears its
>>>>>> >        mapping. /migrate_vma_finalize/() misses that PTE (263 
>>>>>> of 264 restored),
>>>>>> >      and    it's left pointing at S. S is freed, and the next 
>>>>>> /hmm_range_fault /
>>>>>> >      hits the    BUG_ON in /swapops.h:504/. The trace and the 
>>>>>> panic registers
>>>>>> >      match this page and S exactly. With the fix, the /refcount 
>>>>>> /check skipped a
>>>>>> >      busy page 705 times on the repro host with no panic. 
>>>>>> Regards, Apurv
>>>>>> > 
>>>>>> -------------------------------------------------------------------------------- 
>>>>>> *From:* Chen, Xiaogang <Xiaogang.Chen@amd.com> 
>>>>>> <mailto:Xiaogang.Chen@amd.com <mailto:Xiaogang.Chen@amd.com>> 
>>>>>> *Sent:* Monday, October 26, 2026 10:32 AM *To:* Mishra, Apurv 
>>>>>> <Apurv.Mishra@amd.com> <mailto:Apurv.Mishra@amd.com 
>>>>>> <mailto:Apurv.Mishra@amd.com>>; amd-gfx@lists.freedesktop.org 
>>>>>> <mailto:amd-gfx@lists.freedesktop.org 
>>>>>> <mailto:amd-gfx@lists.freedesktop.org>> <amd- 
>>>>>> gfx@lists.freedesktop.org> <mailto:amd-gfx@lists.freedesktop.org 
>>>>>> <mailto:amd-gfx@lists.freedesktop.org>> *Cc:* Deucher, Alexander 
>>>>>> <Alexander.Deucher@amd.com> <mailto:Alexander.Deucher@amd.com 
>>>>>> <mailto:Alexander.Deucher@amd.com>>; Sierra Guiza, Alejandro 
>>>>>> (Alex) <Alex.Sierra@amd.com> <mailto:Alex.Sierra@amd.com 
>>>>>> <mailto:Alex.Sierra@amd.com>>; Kasiviswanathan, Harish 
>>>>>> <Harish.Kasiviswanathan@amd.com> 
>>>>>> <mailto:Harish.Kasiviswanathan@amd.com 
>>>>>> <mailto:Harish.Kasiviswanathan@amd.com>> *Subject:* Re: [PATCH] 
>>>>>> drm/amdkfd: Don't reuse a VRAM page that is still referenced On 
>>>>>> 10/23/2026 12:17 PM, Apurv Mishra wrote:    In 
>>>>>> svm_migrate_copy_to_vram(), skip VRAM pages with a non-zero 
>>>>>> refcount and    leave those pages in system memory for this 
>>>>>> migration. When an svm_bo is reused, a VRAM page can still be 
>>>>>> held by an in-flight CPU fault (do_swap_page -> 
>>>>>> svm_migrate_to_ram). Migrating to VRAM then re-initializes the 
>>>>>> page via zone_device_page_init(), resetting its refcount. The 
>>>>>> fault's    late put_page() frees the page mid-migration, so 
>>>>>> migrate_vma_finalize()    never restores that PTE. It is left 
>>>>>> pointing at a freed system page and hmm_range_fault() hits BUG_ON 
>>>>>> in pfn_swap_entry_to_page() (swapops.h). If there is cpu fault 
>>>>>> the data is in vram page. If at same time driver is migrating 
>>>>>> data from sys->vram  migrate->src[i] & MIGRATE_PFN_MIGRATE should 
>>>>>> be false since the data is already at device side. Then if you 
>>>>>> got a MIGRATE_PFN_MIGRAT sys ram page at svm_migrate_copy_to_vram 
>>>>>> after migrate_vma_setup, but cpu page fault also happened on same 
>>>>>> page there is a contradict. So, I do not see this scenario can 
>>>>>> happen or the real cause is revealed. Regards Xiaogang 
>>>>>> Signed-off-by: Apurv Mishra <Apurv.Mishra@amd.com> 
>>>>>> <mailto:Apurv.Mishra@amd.com <mailto:Apurv.Mishra@amd.com>> 
>>>>>> <mailto:Apurv.Mishra@amd.com <mailto:Apurv.Mishra@amd.com>> 
>>>>>> <mailto:Apurv.Mishra@amd.com <mailto:Apurv.Mishra@amd.com>> --- 
>>>>>> drivers/gpu/drm/amd/amdkfd/kfd_migrate.c |    20 
>>>>>> +++++++++++++++----- 1 file changed, 15 insertions(+), 5 
>>>>>> deletions(-)    diff --git 
>>>>>> a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c 
>>>>>> b/drivers/gpu/drm/amd/    amdkfd/kfd_migrate.c index 
>>>>>> 8b96e1fe741a..1eb92ac6eb05 100644 --- a/drivers/ 
>>>>>> gpu/drm/amd/amdkfd/kfd_migrate.c +++ 
>>>>>> b/drivers/gpu/drm/amd/amdkfd/    kfd_migrate.c @@ -297,16 +297,26 
>>>>>> @@ svm_migrate_copy_to_vram(struct kfd_node *node, struct 
>>>>>> svm_range *prange, amdgpu_res_first(prange->ttm_res,    
>>>>>> ttm_res_offset, npages << PAGE_SHIFT, &cursor); for (i = j = 0; 
>>>>>> (i < npages)    && (mpages < migrate->cpages); i++) { - struct 
>>>>>> page *spage; + struct page    *spage = 
>>>>>> migrate_pfn_to_page(migrate->src[i]); if (migrate->src[i] &    
>>>>>> MIGRATE_PFN_MIGRATE) { dst[i] = cursor.start + (j << PAGE_SHIFT); 
>>>>>> migrate- >dst[i] = svm_migrate_addr_to_pfn(adev, dst[i]); - 
>>>>>> svm_migrate_get_vram_page(prange, migrate->dst[i]); - 
>>>>>> migrate->dst[i] = migrate_pfn(migrate->dst[i]); - mpages++; + /* 
>>>>>> + * A reused svm_bo page may    still be held by a CPU fault. + * 
>>>>>> Reinitializing it would free it under this migration, + * so 
>>>>>> leave this page in system memory. + */ + if 
>>>>>> (page_ref_count(pfn_to_page(migrate->dst[i]))) { + dst[i] = 0; + 
>>>>>> migrate-     >dst[i] = 0; + spage = NULL; + } else { + 
>>>>>> svm_migrate_get_vram_page(prange, migrate->dst[i]); + 
>>>>>> migrate->dst[i] = migrate_pfn(migrate->dst[i]); + mpages++; + } } 
>>>>>> - spage = migrate_pfn_to_page(migrate->src[i]); if (spage && 
>>>>>> !is_zone_device_page(spage)) { src[i] = dma_map_page(dev, spage, 
>>>>>> 0,    PAGE_SIZE, DMA_BIDIRECTIONAL);
>>>>>> >
>>>>>
>>>
>
