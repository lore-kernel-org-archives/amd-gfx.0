Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B44B606A324
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Nov 2026 18:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=FyCx05K0
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 237AE10E5B7;
	Tue,  3 Nov 2026 18:43:12 +0000 (UTC)
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010029.outbound.protection.outlook.com [52.101.46.29])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8CBF710E5B7
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Nov 2026 18:43:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H3yCgIkLgYelQMIcNAbj6Ai1E4YbYh/RM5/M6RpoXR+E+1m1C98MXmCrFxiaRfO9YK/h4POn1cRxDsko2mUnWniUugnH7aj7LCQZqFhKr2Nk4sAiGLAQ8U7S5sj90I4KQDyHt1UvSHiINuiJjP0W6JhR/xNF/C53yBBbi5O61SVbGQABDCAhch+oIDFuHiW2Sqkt/tC2x2WUZWziEQll1WRGItfMxxcXuFspOIXfMOUsfHnc3cHT4oSbv2JvP1QJP3yJO3N4ob3gc5D4rpmto+YqS8tgt/RdwTLgypVNHUKBGK3bQDQYXGg34F5hU3eVV0Crtmu1AQo2V3MhAROHwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qb9U9QZV8odGBMWZMmJtjtsw7wibyjLE6VOPMdSriDY=;
 b=sAOzwdA9noRSsr2xtiGBSn+vdFeSrKAeEm0uYS7u4lm2ZGL4JaGCn1G0sRNg+Oln646PqDgESYGystReOP1821aw5RCeDeVeJZHpiqR5ZFnhMDffKewcMZvyNFvqyGasW59f+Mf/kPASTwipBcphcIg+MSGeMMET4StzTj0hp0JXFSYhY1TdiFcfhaI6cxWR4QoWxMFnNfQb9YOICxrJCt6wJhWK+Z6uWnlcYo9eiKZKAdpHr0itxeECVIkK1SXdFXHLolkJVvP1mkLc/wHkHsFERDpzTK9Yz/1HyYvKchoT+FEgUZKrDI14D9t9DBICedJOSkg3IFMSmKd4YYYX8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qb9U9QZV8odGBMWZMmJtjtsw7wibyjLE6VOPMdSriDY=;
 b=FyCx05K0LBmXL0PB8jl8Qf8lmd5EYVrlYd6iPPiDm06ab95uRAPUg03xLwRrU+bvKXWHBPST1capB6ujH9SdMmLzfsJbT76k9TtQv26Yv7G6J/wgTvZc9abUKJm0eeeC8gedbieC+EkUO+AqZEyHyqruz6nVNQv+LnEL9uW3mEA=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB8517.namprd12.prod.outlook.com (2603:10b6:208:449::8)
 by LY0PR12MB331121.namprd12.prod.outlook.com (2603:10b6:404:226::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Tue, 3 Nov
 2026 18:43:02 +0000
Received: from IA1PR12MB8517.namprd12.prod.outlook.com
 ([fe80::c47e:c884:f06:1525]) by IA1PR12MB8517.namprd12.prod.outlook.com
 ([fe80::c47e:c884:f06:1525%4]) with mapi id 15.21.0569.011; Tue, 3 Nov 2026
 18:43:02 +0000
Message-ID: <fd5bf2a6-6146-499d-9e75-bdcfc51b3ca5@amd.com>
Date: Tue, 3 Nov 2026 12:43:00 -0600
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
Content-Language: en-US
From: "Chen, Xiaogang" <xiaogang.chen@amd.com>
In-Reply-To: <fe5c2998-f19d-4992-b87c-2a498fa109d0@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN7PR18CA0006.namprd18.prod.outlook.com
 (2603:10b6:806:f3::8) To IA1PR12MB8517.namprd12.prod.outlook.com
 (2603:10b6:208:449::8)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB8517:EE_|LY0PR12MB331121:EE_
X-MS-Office365-Filtering-Correlation-Id: 5cbe144d-95b4-4ca0-96f5-08df39da4a78
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|366016|261102123227099003|261021123027099003|56012099006|11063799006|4143699003|5023799004|261009223027099003|261028144727099003|261021135927099003|261026121527099003|261021121427099003|261022105027099003|261026140227099003|261022075727099003|22082099003|18002099003|3023799007|10067099003|13003099007;
X-Microsoft-Antispam-Message-Info: BOI9Yjm+ZlvHnqS4b+4pMoL9zM+Hc8FqIhxdOeMSE9Y1nVGwGciLFfe7nIk8YkNXDM36h1jrtkzFkzbNpedeQIU/wXY2Puikf/Mloqcas9HtXFkLYPGVmIqqDIHHr97x8EJHsavq/muS1mD7Irda2DISKa15yX1r5ArkJXdPPgT6yV2Nh7XZlQfKJeSrghGvFMqRw2+O1Q+eq7HP/2YY2ooSVVK9RDbdZ5ADdQhiNbGB1io2d+gQDRgPFc+2dmV8YkRDk86OH0WurXCt0NZ5eio7A/aiQ+HASrHWfwGgRscE3fn3qclkrAY3V7OjbuWx+fm/4qMg9JCZFT/DAZc/F5zPdQQIorBPsG/j2A6E+a2beZFR0P08n5VLpELoCstxE30yjfUxN9Uunb/Ou/XEbz19dJFx5ZfKTJHGhVq4NhoUo2NBoFOoLbFEqkE9cH6skFhTRNtcSO5FXOp3lkvgtHMB54MeYSgnvs2ctO1gHDVSjpuwsJ57Nx5FAn+pfP7NE6SiAp9ulUNETBcP/cjH1+hRGFi1pTilR4JgNXu5PR10pmcbUV5SuRnCxzhiXt3hVFR31w4w9E30RFgEdH7d6Oxjs3fg1ynQCA1FmJ2mIrnhEclYwilVaekvSP7Ykdg3
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR12MB8517.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(261102123227099003)(261021123027099003)(56012099006)(11063799006)(4143699003)(5023799004)(261009223027099003)(261028144727099003)(261021135927099003)(261026121527099003)(261021121427099003)(261022105027099003)(261026140227099003)(261022075727099003)(22082099003)(18002099003)(3023799007)(10067099003)(13003099007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eERFUVhZU2ZmZ1BEbjg3c3B2MXVNWVZMcGVuYkFpN1BmRW5waU4rOWc0SGJs?=
 =?utf-8?B?ajZBTzd4SGpMVldYYW9mdlJDem5FVmoyc0ZEM3U0NzFxall1NGpadmlINGdS?=
 =?utf-8?B?alNZQmxYa3Y2a0Z3anU5RzQ0d0VuMUNObnEyRlBib2QvV2RibEtZbURFUzNx?=
 =?utf-8?B?M2R2L0xFOU1FaDBQdGRyN1hITUFlVGQzd2RUUjdUak9tZmRPMkNNS2wwV0Zx?=
 =?utf-8?B?anc4SEJSS09FYXo0NlJoeXlFQTlEdXc1aXdmZGJQRnVHRmNXUW1tN3pSNmd6?=
 =?utf-8?B?YmZLSmdGa0NyVVdsV2FRc1RJT1I0YitXSnY3S2xFOXh4OTc5eWREV1hxNEFE?=
 =?utf-8?B?TmcwcGU3TlIvcERVQWY4d1NUMFBHN05wR0pjYVAxWnp0YXYwNGdZdXlrREhP?=
 =?utf-8?B?ejhXUWpqbjIxaE0vQ1A2Um81Qk8yNHBjT1hId2o0aGVNYUNSamJYbVNLL25O?=
 =?utf-8?B?dXdvenhZeStveTJCOUI1ME5Eb2xaUFUzUDN6UGRJa1hkU3RvclJJQkEyRHg2?=
 =?utf-8?B?NmRJcWtWT0xmRHgwS3U4aUNRWEFGUzFabUlZTmh2WVNGak9sSEo4SlNtUjg2?=
 =?utf-8?B?eVpkVll0aUhWWm9KRUVvejFOalZkMUlWdWd3SE45MXVnQ1kza0M0S1p4L1Nl?=
 =?utf-8?B?dS9pZzVkaHdodTcvSEdvejR2YngycmN6SWI5NTAvaldzRUF4RTc2cVQ2TUtU?=
 =?utf-8?B?Vm91YVUra09DZTV0YjRKc0FNdmJ6anl6WGt1VU9WN1ZFV1gxRmMzWjhXMHEw?=
 =?utf-8?B?MlZvM2V0TnBFSHozNjVYMmxCYkFPTXIxRER4eUpOU3RoOVVFb3lSRzY3aWZM?=
 =?utf-8?B?SGkweUFkRXhEVW94TkhmekcxMVF4ZEdQSk9ocDJMM3NJRnJ3RGRkUGxoK05a?=
 =?utf-8?B?bEVaaEFBWnk3VVBhWjdycTlGQ3k0OFNpYVRuejVSOTNqNng0VGp2L0tZS2Fh?=
 =?utf-8?B?QkhlOHRUeHZSMENCbHFtcUhoTFZyQmRZZkoyNjRBTHljMHF6SE41WWx2RmhD?=
 =?utf-8?B?bWhNZEdiZTRMS1RwcWZLZ3dCWTk5QVJ4WTRxUEc3OVVkaVgyaE1OdFNiT3pS?=
 =?utf-8?B?YlRDYlh1OHF2czZXQllPc2dJUkNqZERBQWI0SGhoakczZTc4L3FUeGRYT2Uw?=
 =?utf-8?B?bEtxVERKR2RLVWtYUGxJTUdwSkZzQXdiZzRKaEN0V3haTWx0UGFZTzM5M1ov?=
 =?utf-8?B?L2ZWVzl3K0daUEI1ZThDV0YwK1d2cEFkVUtvZWhNeEZlSlE4Q1JGMzF4Sjc3?=
 =?utf-8?B?WmRVeEYwTlNvbU1mKzBSTlBHaUorcVQxY2lUdkd0WEx6TlNBeDdmVFhibzlp?=
 =?utf-8?B?ekdtMG82aThwVUlocG5yRHpsK0NONjhId3V1NXBXaVJCN3dXT08vckhvV1Fj?=
 =?utf-8?B?cWhoZUtNdG05TDhTMDdaemQzMUZBR3pMOUVmc2F0dHd4RzNxQ1hkWGlvYnRQ?=
 =?utf-8?B?Tkx0dFlKOXo0NmJTZTcyU2xsMHZKZTBneFo4TU8yR3FmenQ0NEhORDVucWRt?=
 =?utf-8?B?T2M5TTVpMlp0clNud3Y3dUQrSXNhRXppRVRBN3lyYjgwS2hjYjNYcGM2WlJI?=
 =?utf-8?B?U0FMMEE3ZG03M0toQmVFa05rY1JYRXArWnkzaXlRQXcwVVpqYVlCbVRweVh5?=
 =?utf-8?B?aU85Tk9pSGZMdkVlMUNCM1VCYTVYR0QzZ0VjV0FHTk5NSmpmVjhLVzRTUVVr?=
 =?utf-8?B?RHk3azdXMitjclYvT1liUE9QQlNHMnB0MUtzdkI2OEJXMmtZR3UxQ0U2eENW?=
 =?utf-8?B?ckFQMWVnOTB4U0dYc1dwSjY3Q1dFLzNacUY1Q3BLejhQckZ1YXpRMzFaNkQz?=
 =?utf-8?B?Y3dPeGNzSmQ1bXIzaGZBYUIrMjFaUzNMQXRFZWR0TEVvam05MW44SGZ6c0Z4?=
 =?utf-8?B?TzgzcFVPTWZ0cGJML2hlbUJmbUpEOXo5MGhHcWVPRllmVWVOVTArYTRVSWRh?=
 =?utf-8?B?ZU9YeUNiWnNMWEo4Y2NlcTR6WlJSQlVFQXVIb0JveW5rRnBuL0l1MzVKdkkx?=
 =?utf-8?B?ZHdqSENWdHNWaTNXTFlXMnA4UWxpL21FUFhkN3BSb2JVRFNiMlJiTStwVDc3?=
 =?utf-8?B?eVF1OXowV2phOERJUTloYVVaK3djdllFc2JUS2dTSGczUFlNQXVjSzZmQ3JH?=
 =?utf-8?B?RCtIbHpQYzN6cWZQWjRsNGtpQjZjSTR4dEFzKytqUy9IQ0R2SWkrRUxENW5C?=
 =?utf-8?B?SXhoTUFtU3hGZTd1WGtZOFl3YW1OSU1hSUFKdFB5aW1ZWDZWWWM1ZkoraUJs?=
 =?utf-8?B?R1NHWXlTYUthNGQwOGczQnhhWiszbytvTlBnK2hjdDVrU0hLRi93dGw1SWQw?=
 =?utf-8?Q?62qMJRrNVm0JjEyeyr?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cbe144d-95b4-4ca0-96f5-08df39da4a78
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB8517.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2026 18:43:02.6845 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ji3yOeEo+PlCNj4A/VhP4qkqV6SsTvRaZbRF0IJpEr0AdhvPhTKc+M+PVv22FUXg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LY0PR12MB331121
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


On 11/3/2026 12:26 PM, Philip Yang wrote:
>
>
> On 2026-11-03 12:09, Chen, Xiaogang wrote:
>>
>> On 11/3/2026 10:57 AM, Philip Yang wrote:
>>>
>>>
>>> On 2026-11-02 18:32, Mishra, Apurv wrote:
>>>> AMD General
>>>>
>>>> AMD General
>>>>
>>>> Hi, @Chen, Xiaogang <mailto:Xiaogang.Chen@amd.com>, following up on 
>>>> your comment...
>>>>
>>>> P's other user is |do_swap_page()|'s own pin. On Ubuntu 6.8, 
>>>> |do_swap_page()| calls |get_page()|, then |migrate_to_ram()|, then 
>>>> |put_page()| (/mm/memory.c:3861–3864/). The extra reference 
>>>> outlives |migrate_mutex|. By then P's data has already moved to S, 
>>>> and the PTE points to S, so nothing else is wrong.
>>>>
>>>> The wrong place is KFD's reuse. |svm_range_validate_svm_bo()| 
>>>> reuses the |svm_bo| because P's pin keeps it alive. 
>>>> |svm_migrate_copy_to_vram()| then hands out P by offset without 
>>>> checking it, while |zone_device_page_init()| requires the page to 
>>>> be free. The fix adds that check where KFD hands out the page. When 
>>>> the pin is still there, the page stays in system memory with a 
>>>> valid PTE, and the next GPU fault migrates it normally.
>>>>
>>>> Mainline is the same. |do_swap_page()| now holds the page lock 
>>>> across `migrate_to_ram()`, but `zone_device_page_init()` resets the 
>>>> refcount before `lock_page()`. The race remains on mainline, 
>>>> because upstream KFD has no such check. My patch adds it. This has 
>>>> been tested and verified.
>>>>
>>>> Adding @Faizal, Sahil <mailto:Sahil.Faizal@amd.com> for updates as 
>>>> the fix needs to merge soon.
>>> This is the corner case I tried to fix with the patch "drm/amdkfd: 
>>> Fix svm_bo and vram page refcount". That patch was rejected because 
>>> we cannot take a page that is not free and treat it as free and safe 
>>> to use. The approach here makes sense to me: if the page has not 
>>> been freed, we skip it. With that said, this patch is
>>
>> If the page has not been freed HMM page collect will set 
>> (migrate->src[i] & MIGRATE_PFN_MIGRATE) to false. The explanation 
>> from this patch is do_swap_page does not release vram page during cpu 
>> page fault recovery, then page collection by page table walk would 
>> see pte sill point to device memory, then not collect this page.
> This issue isn't with the source page, it's with the destination VRAM 
> page, which still has a non-zero refcount after migrating to RAM. We 
> cannot assume every VRAM page has been freed and zero-initialise it, 
> so we skip it and map to the GPU with the system page instead.

When HMM allows sys->vram migration on a vram page this vram page should 
not be used by someone else. In this case do_swap_page has not release 
the vram page, then data is still in vram, then collection will not 
collect the sys page correspondent to the vram page since the vram page 
is not available and pte at cpu page table still points to the varm page 
, then not enter svm path of sys->vram for this vram page.

If the explanation in this patch is what happened it is not driver 
issue. This type vram page ref count is not under driver control. Skip 
migration just covers the real cause.

Regards

Xiaogang

>
> Regards,
> Philip
>>
>> If this explanation is right it is not drive issue. Driver does data 
>> migration, not decide which page can be migrated. There is contradict 
>> in this explanation. I suspect the real cause is not revealed.
>>
>> Regards
>>
>> Xiaogang
>>
>>>
>>> Reviewed-by: Philip Yang <Philip.Yang@amd.com>
>>>>
>>>> Regards,
>>>> Apurv
>>>>
>>>> ------------------------------------------------------------------------ 
>>>>
>>>> *From:* Chen, Xiaogang <Xiaogang.Chen@amd.com>
>>>> *Sent:* Wednesday, October 28, 2026 6:41 PM
>>>> *To:* Mishra, Apurv <Apurv.Mishra@amd.com>; 
>>>> amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
>>>> *Cc:* Deucher, Alexander <Alexander.Deucher@amd.com>; Sierra Guiza, 
>>>> Alejandro (Alex) <Alex.Sierra@amd.com>; Kasiviswanathan, Harish 
>>>> <Harish.Kasiviswanathan@amd.com>
>>>> *Subject:* Re: [PATCH] drm/amdkfd: Don't reuse a VRAM page that is 
>>>> still referenced
>>>>
>>>> On 10/27/2026 8:19 PM, Mishra, Apurv wrote:
>>>> > AMD General
>>>> >
>>>> > Hi, @Chen, Xiaogang <mailto:Xiaogang.Chen@amd.com 
>>>> <mailto:Xiaogang.Chen@amd.com>>,
>>>> >
>>>> > The migrations don't overlap. |migrate_mutex| serializes them, 
>>>> but it doesn't
>>>> > cover P's last reference:
>>>> >
>>>> >    *
>>>> >      |svm_migrate_to_ram()| releases |prange->migrate_mutex| at /
>>>> >      kfd_migrate.c:1073/, after the VRAM→RAM migration has 
>>>> finished and before
>>>> >      the function returns.
>>>> >    *
>>>> >
>>>> >      |do_swap_page()| drops its own reference on P only after 
>>>> |migrate_to_ram()|
>>>> >      returns, at /mm/memory.c:4851–4853/.
>>>>
>>>> Before do_swap-page drops the last ref on P the cpu mapping of fault
>>>> address has not been changed. Then at following sys->vram the
>>>> migrate_vma_walk_ops->pmd_entry will not collect this source(sys) page
>>>> because the address there still point to device private page(since you
>>>> got cpu page fault it is device private memory). Then 
>>>> (migrate->src[i] &
>>>> MIGRATE_PFN_MIGRATE) is false.
>>>>
>>>> If P got used at sys->vram, but P is still used by someone else
>>>> something wrong is in other places. Skipping migration does not 
>>>> solve it.
>>>>
>>>> Regards
>>>>
>>>> Xiaogang
>>>>
>>>>
>>>> > So, the GPU fault takes |migrate_mutex| legitimately, while P 
>>>> still has |
>>>> > do_swap_page()|'s reference. KFD gets P back without P ever being 
>>>> freed. VRAM
>>>> > destinations come from the |svm_bo| by offset (`cursor.start + 
>>>> j`), not from a
>>>> > pool of free pages. That |svm_bo| is still alive because P holds 
>>>> a reference on
>>>> > it until P is freed, so |svm_range_validate_svm_bo()| reuses it 
>>>> and the same
>>>> > offset gives P again. Nothing checks whether P's previous user is 
>>>> done with it.
>>>> >
>>>> > Regards,
>>>> > Apurv
>>>> >
>>>> >
>>>> > 
>>>> --------------------------------------------------------------------------------
>>>> > *From:* Chen, Xiaogang <Xiaogang.Chen@amd.com>
>>>> > *Sent:* Monday, October 26, 2026 5:27 PM
>>>> > *To:* Mishra, Apurv <Apurv.Mishra@amd.com>; 
>>>> amd-gfx@lists.freedesktop.org <amd-
>>>> > gfx@lists.freedesktop.org>
>>>> > *Cc:* Deucher, Alexander <Alexander.Deucher@amd.com>; Sierra 
>>>> Guiza, Alejandro
>>>> > (Alex) <Alex.Sierra@amd.com>; Kasiviswanathan, Harish
>>>> > <Harish.Kasiviswanathan@amd.com>
>>>> > *Subject:* Re: [PATCH] drm/amdkfd: Don't reuse a VRAM page that 
>>>> is still referenced
>>>> >
>>>> >
>>>> > On 10/26/2026 1:12 PM, Mishra, Apurv wrote:
>>>> >
>>>> >      AMD General Hi, @Chen, Xiaogang 
>>>> <mailto:Xiaogang.Chen@amd.com <mailto:Xiaogang.Chen@amd.com>>
>>>> >      <mailto:Xiaogang.Chen@amd.com 
>>>> <mailto:Xiaogang.Chen@amd.com>>, thank you for the review. The two 
>>>> migrations
>>>> >      don't overlap on that address; they run back-to-back. What 
>>>> overlaps is the
>>>> >      lifetime of the VRAM page. This was reproduced with ASan and 
>>>> XNACK, which
>>>> >      make concurrent CPU and GPU faults on the same ranges 
>>>> frequently. As per the
>>>> >      logs (ROCM-31012 
>>>> <https://amd-hub.atlassian.net/browse/ROCM-31012 
>>>> <https://amd-hub.atlassian.net/browse/ROCM-31012>> <https://
>>>> >      amd-hub.atlassian.net/browse/ROCM-31012>):  * A CPU fault 
>>>> enters /
>>>> >      do_swap_page()/, takes a reference on VRAM page P, and /
>>>> >        svm_migrate_to_ram/() moves the data to system page S. The 
>>>> PTE now points
>>>> >      to    S, but /do_swap_page/() still holds P until 
>>>> /migrate_to_ram/()
>>>> >      returns.  *    About 66 µs later, a GPU retry fault migrates 
>>>> the range back
>>>> >      to VRAM. src =    S with /MIGRATE_PFN_MIGRATE /set is 
>>>> correct here, because
>>>> >      the data really is    in system RAM.  *    KFD reuses the 
>>>> /svm_bo/, which P
>>>> >      keeps alive, and gets P again as the destination. 
>>>> /zone_device_page_init/
>>>> >      (P) runs with ref=1 (traced) and    overwrites the refcount.  *
>>>> >
>>>> > How KFD reuses same P? From the description above CPU fault has 
>>>> not finished
>>>> > because  svm_migrate_to_ram has not returned, P has not been 
>>>> returned to KFD
>>>> > driver, so P still has reference count.
>>>> >
>>>> > Then GPU page fault happen on same range. For each migration on a 
>>>> prange there
>>>> > is prange->migrate_mutex to have migration on the prange happen 
>>>> exclusively.
>>>> > Then how can svm_migrate_to_vram enter migration if 
>>>> prange->migrate_mutex is
>>>> > still hold at svm_migrate_to_ram?
>>>> >
>>>> > My basic concern is a vram page can only be involved at one 
>>>> migration at a
>>>> > moment. If it is getting migrated in two migrations at same time 
>>>> with difference
>>>> > direction there is syn issue. Checking the page ref here to avoid 
>>>> migration is
>>>> > not fixing the root cause.
>>>> >
>>>> > Regards
>>>> >
>>>> > Xiaogang
>>>> >
>>>> >          The CPU fault's /put_page/(P) frees P mid-migration and 
>>>> clears its
>>>> >        mapping. /migrate_vma_finalize/() misses that PTE (263 of 
>>>> 264 restored),
>>>> >      and    it's left pointing at S. S is freed, and the next 
>>>> /hmm_range_fault /
>>>> >      hits the    BUG_ON in /swapops.h:504/. The trace and the 
>>>> panic registers
>>>> >      match this page and S exactly. With the fix, the /refcount 
>>>> /check skipped a
>>>> >      busy page 705 times on the repro host with no panic. 
>>>> Regards, Apurv
>>>> > 
>>>> -------------------------------------------------------------------------------- 
>>>> *From:* Chen, Xiaogang <Xiaogang.Chen@amd.com> 
>>>> <mailto:Xiaogang.Chen@amd.com <mailto:Xiaogang.Chen@amd.com>> 
>>>> *Sent:* Monday, October 26, 2026 10:32 AM *To:* Mishra, Apurv 
>>>> <Apurv.Mishra@amd.com> <mailto:Apurv.Mishra@amd.com 
>>>> <mailto:Apurv.Mishra@amd.com>>; amd-gfx@lists.freedesktop.org 
>>>> <mailto:amd-gfx@lists.freedesktop.org 
>>>> <mailto:amd-gfx@lists.freedesktop.org>> <amd- 
>>>> gfx@lists.freedesktop.org> <mailto:amd-gfx@lists.freedesktop.org 
>>>> <mailto:amd-gfx@lists.freedesktop.org>> *Cc:* Deucher, Alexander 
>>>> <Alexander.Deucher@amd.com> <mailto:Alexander.Deucher@amd.com 
>>>> <mailto:Alexander.Deucher@amd.com>>; Sierra Guiza, Alejandro (Alex) 
>>>> <Alex.Sierra@amd.com> <mailto:Alex.Sierra@amd.com 
>>>> <mailto:Alex.Sierra@amd.com>>; Kasiviswanathan, Harish 
>>>> <Harish.Kasiviswanathan@amd.com> 
>>>> <mailto:Harish.Kasiviswanathan@amd.com 
>>>> <mailto:Harish.Kasiviswanathan@amd.com>> *Subject:* Re: [PATCH] 
>>>> drm/amdkfd: Don't reuse a VRAM page that is still referenced On 
>>>> 10/23/2026 12:17 PM, Apurv Mishra wrote:    In 
>>>> svm_migrate_copy_to_vram(), skip VRAM pages with a non-zero 
>>>> refcount and    leave those pages in system memory for this 
>>>> migration. When an svm_bo is    reused, a VRAM page can still be 
>>>> held by an in-flight CPU fault (do_swap_page -> 
>>>> svm_migrate_to_ram). Migrating to VRAM then re-initializes the page 
>>>> via zone_device_page_init(), resetting its refcount. The fault's    
>>>> late put_page() frees the page mid-migration, so 
>>>> migrate_vma_finalize()    never restores that PTE. It is left 
>>>> pointing at a freed system page and    hmm_range_fault() hits 
>>>> BUG_ON in pfn_swap_entry_to_page() (swapops.h). If there is cpu 
>>>> fault the data is in vram page. If at same time driver is migrating 
>>>> data from sys->vram  migrate->src[i] & MIGRATE_PFN_MIGRATE should 
>>>> be false since the data is already at device side. Then if you got 
>>>> a MIGRATE_PFN_MIGRAT sys ram page at svm_migrate_copy_to_vram after 
>>>> migrate_vma_setup, but cpu page fault also happened on same page 
>>>> there is a contradict. So, I do not see this scenario can happen or 
>>>> the real cause is revealed. Regards Xiaogang    Signed-off-by: 
>>>> Apurv Mishra <Apurv.Mishra@amd.com> <mailto:Apurv.Mishra@amd.com 
>>>> <mailto:Apurv.Mishra@amd.com>> <mailto:Apurv.Mishra@amd.com 
>>>> <mailto:Apurv.Mishra@amd.com>> <mailto:Apurv.Mishra@amd.com 
>>>> <mailto:Apurv.Mishra@amd.com>> --- 
>>>> drivers/gpu/drm/amd/amdkfd/kfd_migrate.c |    20 
>>>> +++++++++++++++----- 1 file changed, 15 insertions(+), 5 
>>>> deletions(-)    diff --git 
>>>> a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c 
>>>> b/drivers/gpu/drm/amd/    amdkfd/kfd_migrate.c index 
>>>> 8b96e1fe741a..1eb92ac6eb05 100644 --- a/drivers/ 
>>>> gpu/drm/amd/amdkfd/kfd_migrate.c +++ 
>>>> b/drivers/gpu/drm/amd/amdkfd/    kfd_migrate.c @@ -297,16 +297,26 
>>>> @@ svm_migrate_copy_to_vram(struct kfd_node *node, struct svm_range 
>>>> *prange, amdgpu_res_first(prange->ttm_res,    ttm_res_offset, 
>>>> npages << PAGE_SHIFT, &cursor); for (i = j = 0; (i < npages)    && 
>>>> (mpages < migrate->cpages); i++) { - struct page *spage; + struct 
>>>> page    *spage = migrate_pfn_to_page(migrate->src[i]); if 
>>>> (migrate->src[i] &    MIGRATE_PFN_MIGRATE) { dst[i] = cursor.start 
>>>> + (j << PAGE_SHIFT); migrate- >dst[i] = 
>>>> svm_migrate_addr_to_pfn(adev, dst[i]); - 
>>>> svm_migrate_get_vram_page(prange, migrate->dst[i]); - 
>>>> migrate->dst[i] =    migrate_pfn(migrate->dst[i]); - mpages++; + /* 
>>>> + * A reused svm_bo page may    still be held by a CPU fault. + * 
>>>> Reinitializing it would free it under this migration, + * so leave 
>>>> this page in system memory. + */ + if 
>>>> (page_ref_count(pfn_to_page(migrate->dst[i]))) { + dst[i] = 0; + 
>>>> migrate-     >dst[i] = 0; + spage = NULL; + } else { + 
>>>> svm_migrate_get_vram_page(prange, migrate->dst[i]); + 
>>>> migrate->dst[i] = migrate_pfn(migrate->dst[i]); + mpages++; + } } - 
>>>> spage = migrate_pfn_to_page(migrate->src[i]); if (spage && 
>>>> !is_zone_device_page(spage)) { src[i] = dma_map_page(dev, spage, 
>>>> 0,    PAGE_SIZE, DMA_BIDIRECTIONAL);
>>>> >
>>>
>
