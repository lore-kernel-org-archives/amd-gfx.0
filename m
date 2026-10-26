Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E803606A31A
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Oct 2026 21:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=VOQOz7jr
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B360210E078;
	Mon, 26 Oct 2026 21:27:24 +0000 (UTC)
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011026.outbound.protection.outlook.com
 [40.93.194.26])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5795710E078
 for <amd-gfx@lists.freedesktop.org>; Mon, 26 Oct 2026 21:27:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S27Ou2wkcwtVLfX9yIHoWRhYutpfEAjcQn/sKRPBzyJ4NmUijuU9q/oRicTK1s5KDurrbcmsh08d4NBQ1d/jejD5M+p5UwZb1vwYw6ldPp2PcM3dO6c7AtX7pZCNrn7yMlFl1fzy1VHaQDraZhqH/SZsiktU1+gQgAHCwkOF76CvI96GZrCUFlCwsTXqwdb7MaxQvozJEhON0KdExV9PcpKm2FHbLbokg3MEuBfh7MnnqF17cCYr9GoKLvBT22feannOnv/privYW/DC/iIb4CvclqonzpygUHGy6p4h0akiGoSrW0+ODz8RQuc+QSvnFLHNDQWm6/KmLXxZ/PLtEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tdrXnhIerk37JdkKH9uFM/8kkTTQ4F3mL3OyYwJaxSc=;
 b=BrJavzTJdiH8xwtb+xMOVA25xV5J4dWgpuxzAADvsSy7M5x3Hochu9/gBQY1hBSDMK0oDW0x1xGwX44CHbAfex8CyuQxS8FLjGd+8rXOZ7q9lNLjzqgdgsYW+QBYDxv2rBSe4qI//Pt28PpP1PeSGEBR9deEvvDGtOyBBODCB9Oy5uZAf997U3vEALcW5NhFaBVs1sT1gD+tp8VrI+Iv5dwMgsyLC6VUWLg1xovTyUFT3gUC3d6YONcXE9xbgYB2PAc49VmEScpI16jxMzaOCIovOHq4nSXAVJtFSEPJQpA1ot4+7PJPYZJt10M2wH7ckhMrd+tPulO4HwV/8FSHxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tdrXnhIerk37JdkKH9uFM/8kkTTQ4F3mL3OyYwJaxSc=;
 b=VOQOz7jryLRVFpsCx4Nde9mao0USfpvMW4EIn0NumCmST3deE1bphImM/YZ/ItLqgQDK0xGz2UWpUz0RTpmD/IQD1S1rPhm0jvr1gHQPzfR2MAI0Enm3zAKBpF78ZZbGgUdnxYWGrYfKecwqGBDrPni0satAe7I1NNiMOJPF6To=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB8517.namprd12.prod.outlook.com (2603:10b6:208:449::8)
 by BL1PR12MB5753.namprd12.prod.outlook.com (2603:10b6:208:390::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Mon, 26 Oct
 2026 21:27:13 +0000
Received: from IA1PR12MB8517.namprd12.prod.outlook.com
 ([fe80::c47e:c884:f06:1525]) by IA1PR12MB8517.namprd12.prod.outlook.com
 ([fe80::c47e:c884:f06:1525%4]) with mapi id 15.21.0546.021; Mon, 26 Oct 2026
 21:27:12 +0000
Content-Type: multipart/alternative;
 boundary="------------vAE3nLrqpXRnRVL2UqSmqYni"
Message-ID: <601d1612-ea3d-4379-9336-9c36e9485230@amd.com>
Date: Mon, 26 Oct 2026 16:27:09 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdkfd: Don't reuse a VRAM page that is still
 referenced
To: "Mishra, Apurv" <Apurv.Mishra@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Sierra Guiza, Alejandro (Alex)" <Alex.Sierra@amd.com>,
 "Kasiviswanathan, Harish" <Harish.Kasiviswanathan@amd.com>
References: <20261023171722.46301-1-Apurv.Mishra@amd.com>
 <53899e72-b727-42ab-81ee-8587a10f16b7@amd.com>
 <PH9PR12MB135921453E146E0DA733B16DE99F612@PH9PR12MB135921.namprd12.prod.outlook.com>
Content-Language: en-US
From: "Chen, Xiaogang" <xiaogang.chen@amd.com>
In-Reply-To: <PH9PR12MB135921453E146E0DA733B16DE99F612@PH9PR12MB135921.namprd12.prod.outlook.com>
X-ClientProxiedBy: DS1P221CA0018.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:8:242::13) To IA1PR12MB8517.namprd12.prod.outlook.com
 (2603:10b6:208:449::8)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB8517:EE_|BL1PR12MB5753:EE_
X-MS-Office365-Filtering-Correlation-Id: 73d84c84-b32d-4c50-048f-08df33a7e610
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|23010399003|10067099003|18002099003|22082099003|261026140227099003|3023799007|8096899003|13003099007|11063799006|56012099006|4143699003|261009223027099003|261021123027099003|261021121427099003|261021135927099003|261022075727099003|261022105027099003|261026121527099003;
X-Microsoft-Antispam-Message-Info: vrENsE0ugv3fqVAHlswsz3NP7vdZ7WJyQVJCGqS39+8Hmn2QQocdEcFsZqSTQjVg/BQ59XZFQLO4P4uMrc/+S9WZlRIRZkJrKPx8n/G1gAbRlLPAxrOP/nhVcMt487AhhiafeEGbo5nEGNkANUeSRxKsV7+t/802/aL43XZaJzYCPiDFfTufpmXqjOlu5A/hAPDkNBiNAloDaSm1jlsKAwbojY2mwzjGYo/yk0fidUJxYY+ZvcIkoSYsdenPfq9FRZDnMF47e+VlFdCkU86OR0tDh+Lbjm3Cl710NqmDRTMZzPumivHRQVb2Zi4nzZqC6q5xPgO/Jxxzhw+lJw7doM/OuG51VEM9TSYoIaGSNGxebkWsFq8MU4VKxEPwhDHjFq5ZynU0ThydvknrpaAy8Bbmeo1iozVOuT8YL5mVUx56Ji7OZaBEsV3KDIZahT/vb09LXJp6uo27jt+NpOCWCJFi25pZsS4jwSZq+V5k7pKxNz+C5mdk8sc0qsXlk/i3fGM0uJ0u5mf5Mx879FXbiTjLZpKhRcqpLKfcQeDVzAyOINhF6lSBRA32aOw60q8E6kgl8F19GONmNI0rnU36Rud6aI7eoEELvYKmdP+BgLh23SZSfhlBwBgbe2NL5f4a2RPbAWzI6ibQghCOGJ6nHiHV72YwoFQExYTsD01l85Q=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR12MB8517.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(10067099003)(18002099003)(22082099003)(261026140227099003)(3023799007)(8096899003)(13003099007)(11063799006)(56012099006)(4143699003)(261009223027099003)(261021123027099003)(261021121427099003)(261021135927099003)(261022075727099003)(261022105027099003)(261026121527099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?djFXM3Y0Ulh1eC9IZnhaL2hvdVdEa1FZWjBCajBaekpIRHR5bjVBNmNsSjhv?=
 =?utf-8?B?bEw1MnRMcGNnUm83a2dwemNsQXhDZHI1S1RldSs5YUJacnBsTElTSVBGd1NK?=
 =?utf-8?B?TzlaT2toNVY4TzlGdUlJVHIvNlVIeWxBWWoreXRyYlpmVzVmVGJ3c1dBRjEx?=
 =?utf-8?B?VG1Ha3JEb0NZWnBZbFdJQzRmQVJ3VnJZc3pKZnZzanlvbUEwUWJ6V004UHIz?=
 =?utf-8?B?OEZJVzJ0U05ZSXBrWmFNZ0VFaVNpT1p3Sjh0cm5aRUI5VTEwZURQYTR4cU1I?=
 =?utf-8?B?djNoR0FaYjNiVVEvSGlQZmhlR0hDTGplSDdia0tOaWxXL1lLMWFuM1hHaVRF?=
 =?utf-8?B?bkxqd2NLNklJdkhIeC94bmZmeVRINEtoSUMybWgybzNBQks5bDlOWExBdWdv?=
 =?utf-8?B?N1pFRjhKU21TeUhRVy9nRFRNRnRJaWZkZVFHV2xUejRyTVJnYTdIaWlFVDNY?=
 =?utf-8?B?Q3MzV3FON0Z2ekhWbDRLQmxrV2JHTTg5cDVvRG9EMzZBRWpIQ05aUy9iK1N5?=
 =?utf-8?B?TWRDTUxIZXE4Z2QyV3ZaTUxPODRFY1pYZWpnckRBY0JyUW43VTUxYnNVMC9w?=
 =?utf-8?B?V3pEWDF6QWxVZ0ZabTFiUDF1TVREWWhUeUc4enFKSm1reVVQRFJUVi9ySk9j?=
 =?utf-8?B?ZmNLUndkWkFXekVxZTlCY2tOS1AyMUc2L2NjR2IvMGMwZzJ6NEVyT3JJcDZv?=
 =?utf-8?B?aGVNc1VkU2hxUStOTjRxcDZkYmJFQ2l4QVgyZ0FhbnkzTEFFZlJGVCtuWDBo?=
 =?utf-8?B?N2RDeHY0TldQLzNwQ2MyOVFQNzVydmFPYVBXWllneGtGSFRWdUlmd2drdzFB?=
 =?utf-8?B?Zk9WODJOK25MNmFVVGtIaDBkeWo3WVRheENSazdseldseG1rcitoMktXaXF6?=
 =?utf-8?B?NFdGUEVZK1Q3dmxPb2l6WXRHRHRFelRYMGtWRXVpSkx6TE5zOVZFaC9RRVV3?=
 =?utf-8?B?T1JMUmRHTVlqR0tSK1JnVmNlYTh6K2k5Y2lDWWlqN1c0UTR5UWEzSFVxTHA5?=
 =?utf-8?B?SERXL3BaRTJWbWMydVNxQkZRdEt0Q0l4dE9nWU8yT0dmb01YKzhXS1p2Y3Jr?=
 =?utf-8?B?TU5Mb1V1R2lVRDZYVXFyQjdzZm04S013YTVQbEttd0F3SVJiZ1hUa2lyMDVB?=
 =?utf-8?B?SytTT2F0SEJBSTd0RlFkbk1DdWVZZ3A2S1pmRzE2VTI3MUdCbnR3TDhCSWNX?=
 =?utf-8?B?VDlpa0djTDhWRHlkOTdnckg1dDVDT0FEZXRPTFRPejlNYVlNY0J6cGZocHNt?=
 =?utf-8?B?aXdFM2Y3RFdJeFM3OW5tb01DcXprbjdqL29QZktoMnVLWU5Sc0Ztckl5RS9z?=
 =?utf-8?B?L2FTdzVtNGQ3ODNNVVBRQldqMHJXaWMyempwTXRSWTNNTGJ1Y2M2dXg2VU5s?=
 =?utf-8?B?TkJabllBVG1rUmRSZ2t0U1RJakY4RkE2ZGtMN0JqS3BYRFh4YVVoNGxNaXVQ?=
 =?utf-8?B?eUQzM2J0RXFpQU1Pc1R3eDlkNjdERVJqU0pHMXpzM3NmMmxPajlGWmVHektE?=
 =?utf-8?B?enVqcW0yZVBGOENZbVN1OGhzNXRySUU4dlRvYVovd0dsNkUzSXJuU01ma0lq?=
 =?utf-8?B?UjNNRGJzc1l3QUlNYkNCdnZKWTJnV1N2cVhwb1Y2dE5nekMzVmREcE5QSDI4?=
 =?utf-8?B?bm43VEk1QkFoQ1VtNFdpU0pCNHN1ZVVtR081ei9kUVZLOTFwdXRNb3VBUm1l?=
 =?utf-8?B?b3JXZUZLQmJNbHVtSWhBcHYrRDk4eTZRNDNkVTNuVDRGdDlSdjRmU3llenRj?=
 =?utf-8?B?aUV1MU50ZStjK3hRanZIZU42bEtaZzZjaWMxeFMzZG11TEx6K1pGbFdDNGdU?=
 =?utf-8?B?eGZDUWY1bmhQRjlqdi8zaXJYbmZkZGp6aHVtNzFGOWROWWxxZkpRR2pnVUo1?=
 =?utf-8?B?OXVCbWtsVW9CNnFyRlVFdktsM1Q3VHVZNDhJcjJvWVV2NWdvcjJ1TGJ4STVk?=
 =?utf-8?B?Y3VQVGpwcEs5SlFqUEhPajhuVmFYa2M0dHJlRDNIRFlQd29RdEh6ZkJtMWlF?=
 =?utf-8?B?TGZDSElQamY4VzNlTE45d2xRUG5xTGhwbE55b0MxMURZckpRZmorWkVudUtJ?=
 =?utf-8?B?VFVIS2p3L29TMEpxemttK292eDVCYjY0aHNWMFYzY0hab05UZ3RrOFlFOENx?=
 =?utf-8?B?bENzdFI2bHhTNTJUdHlsWUFFdzVreWNLakRrRXlDemNiRXVkaHRKaGZac2ZL?=
 =?utf-8?B?VkdBWmFuVFVFQlpVeS9Md05Dei9Ea2FsTm1zMW4wV1RuOUxBbHJpWUxwbkVx?=
 =?utf-8?B?Qmh6Vk1rOFIrVlczWWp0V2hBZUExNVZmdUhweWVmcHVDRk1tOGxZdno4MWZx?=
 =?utf-8?Q?zOqy9Cngll+YG3lNoT?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73d84c84-b32d-4c50-048f-08df33a7e610
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB8517.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2026 21:27:12.3716 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1e5i47UDwtRYnFg6mMlMZOZg5dRr7YnpvQbv66NCQIzoojw2zNq+BB/0Lg0ap3cb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5753
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
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--------------vAE3nLrqpXRnRVL2UqSmqYni
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 10/26/2026 1:12 PM, Mishra, Apurv wrote:
> AMD General
>
> Hi, @Chen, Xiaogang<mailto:Xiaogang.Chen@amd.com>, thank you for the review.
>
> The two migrations don't overlap on that address; they run back-to-back. What
> overlaps is the lifetime of the VRAM page. This was reproduced with ASan and
> XNACK, which make concurrent CPU and GPU faults on the same ranges frequently.
> As per the logs (ROCM-31012<https://amd-hub.atlassian.net/browse/ROCM-31012>):
>
>    *
>
>      A CPU fault enters /do_swap_page()/, takes a reference on VRAM page P, and /
>      svm_migrate_to_ram/() moves the data to system page S. The PTE now points to
>      S, but /do_swap_page/() still holds P until /migrate_to_ram/() returns.
>
>    *
>
>      About 66 µs later, a GPU retry fault migrates the range back to VRAM. src =
>      S with /MIGRATE_PFN_MIGRATE /set is correct here, because the data really is
>      in system RAM.
>
>    *
>
>      KFD reuses the /svm_bo/, which P keeps alive, and gets P again as the
>      destination. /zone_device_page_init/(P) runs with ref=1 (traced) and
>      overwrites the refcount.
>
>    *

How KFD reuses same P? From the description above CPU fault has not 
finished because svm_migrate_to_ram has not returned, P has not been 
returned to KFD driver, so P still has reference count.

Then GPU page fault happen on same range. For each migration on a prange 
there is prange->migrate_mutex to have migration on the prange happen 
exclusively. Then how can svm_migrate_to_vram enter migration if 
prange->migrate_mutex is still hold at svm_migrate_to_ram?

My basic concern is a vram page can only be involved at one migration at 
a moment. If it is getting migrated in two migrations at same time with 
difference direction there is syn issue. Checking the page ref here to 
avoid migration is not fixing the root cause.

Regards

Xiaogang

>      The CPU fault's /put_page/(P) frees P mid-migration and clears its
>      mapping. /migrate_vma_finalize/() misses that PTE (263 of 264 restored), and
>      it's left pointing at S. S is freed, and the next /hmm_range_fault /hits the
>      BUG_ON in /swapops.h:504/.
>
> The trace and the panic registers match this page and S exactly. With the fix,
> the /refcount /check skipped a busy page 705 times on the repro host with no panic.
>
>
> Regards,
>
> Apurv
>
>
>
> --------------------------------------------------------------------------------
> *From:* Chen, Xiaogang<Xiaogang.Chen@amd.com>
> *Sent:* Monday, October 26, 2026 10:32 AM
> *To:* Mishra, Apurv<Apurv.Mishra@amd.com>;amd-gfx@lists.freedesktop.org <amd- gfx@lists.freedesktop.org>
> *Cc:* Deucher, Alexander<Alexander.Deucher@amd.com>; Sierra Guiza, Alejandro
> (Alex)<Alex.Sierra@amd.com>; Kasiviswanathan, Harish
> <Harish.Kasiviswanathan@amd.com>
> *Subject:* Re: [PATCH] drm/amdkfd: Don't reuse a VRAM page that is still referenced
>
>
> On 10/23/2026 12:17 PM, Apurv Mishra wrote:
>
>      In svm_migrate_copy_to_vram(), skip VRAM pages with a non-zero refcount and
>      leave those pages in system memory for this migration. When an svm_bo is
>      reused, a VRAM page can still be held by an in-flight CPU fault
>      (do_swap_page -> svm_migrate_to_ram). Migrating to VRAM then re-initializes
>      the page via zone_device_page_init(), resetting its refcount. The fault's
>      late put_page() frees the page mid-migration, so migrate_vma_finalize()
>      never restores that PTE. It is left pointing at a freed system page and
>      hmm_range_fault() hits BUG_ON in pfn_swap_entry_to_page() (swapops.h).
>
> If there is cpu fault the data is in vram page. If at same time driver is
> migrating data from sys->vram  migrate->src[i] & MIGRATE_PFN_MIGRATE should be
> false since the data is already at device side.
>
> Then if you got a  MIGRATE_PFN_MIGRAT sys ram page at svm_migrate_copy_to_vram
> after migrate_vma_setup, but cpu page fault also happened on same page there is
> a contradict.
>
> So, I do not see this scenario can happen or the real cause is revealed.
>
> Regards
>
> Xiaogang
>
>      Signed-off-by: Apurv Mishra<Apurv.Mishra@amd.com>
>      <mailto:Apurv.Mishra@amd.com> --- drivers/gpu/drm/amd/amdkfd/kfd_migrate.c |
>      20 +++++++++++++++----- 1 file changed, 15 insertions(+), 5 deletions(-)
>      diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd/
>      amdkfd/kfd_migrate.c index 8b96e1fe741a..1eb92ac6eb05 100644 --- a/drivers/
>      gpu/drm/amd/amdkfd/kfd_migrate.c +++ b/drivers/gpu/drm/amd/amdkfd/
>      kfd_migrate.c @@ -297,16 +297,26 @@ svm_migrate_copy_to_vram(struct kfd_node
>      *node, struct svm_range *prange, amdgpu_res_first(prange->ttm_res,
>      ttm_res_offset, npages << PAGE_SHIFT, &cursor); for (i = j = 0; (i < npages)
>      && (mpages < migrate->cpages); i++) { - struct page *spage; + struct page
>      *spage = migrate_pfn_to_page(migrate->src[i]); if (migrate->src[i] &
>      MIGRATE_PFN_MIGRATE) { dst[i] = cursor.start + (j << PAGE_SHIFT); migrate-
>       >dst[i] = svm_migrate_addr_to_pfn(adev, dst[i]); -
>      svm_migrate_get_vram_page(prange, migrate->dst[i]); - migrate->dst[i] =
>      migrate_pfn(migrate->dst[i]); - mpages++; + /* + * A reused svm_bo page may
>      still be held by a CPU fault. + * Reinitializing it would free it under this
>      migration, + * so leave this page in system memory. + */ + if
>      (page_ref_count(pfn_to_page(migrate->dst[i]))) { + dst[i] = 0; + migrate-
>       >dst[i] = 0; + spage = NULL; + } else { + svm_migrate_get_vram_page(prange,
>      migrate->dst[i]); + migrate->dst[i] = migrate_pfn(migrate->dst[i]); +
>      mpages++; + } } - spage = migrate_pfn_to_page(migrate->src[i]); if (spage
>      && !is_zone_device_page(spage)) { src[i] = dma_map_page(dev, spage, 0,
>      PAGE_SIZE,      DMA_BIDIRECTIONAL);
>
--------------vAE3nLrqpXRnRVL2UqSmqYni
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 10/26/2026 1:12 PM, Mishra, Apurv
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:PH9PR12MB135921453E146E0DA733B16DE99F612@PH9PR12MB135921.namprd12.prod.outlook.com">
      <pre wrap="" class="moz-quote-pre">AMD General

Hi, @Chen, Xiaogang <a class="moz-txt-link-rfc2396E" href="mailto:Xiaogang.Chen@amd.com">&lt;mailto:Xiaogang.Chen@amd.com&gt;</a>, thank you for the review.

The two migrations don't overlap on that address; they run back-to-back. What 
overlaps is the lifetime of the VRAM page. This was reproduced with ASan and 
XNACK, which make concurrent CPU and GPU faults on the same ranges frequently. 
As per the logs (ROCM-31012 <a class="moz-txt-link-rfc2396E" href="https://amd-hub.atlassian.net/browse/ROCM-31012">&lt;https://amd-hub.atlassian.net/browse/ROCM-31012&gt;</a>):

  *

    A CPU fault enters /do_swap_page()/, takes a reference on VRAM page P, and /
    svm_migrate_to_ram/() moves the data to system page S. The PTE now points to
    S, but /do_swap_page/() still holds P until /migrate_to_ram/() returns.

  *

    About 66 µs later, a GPU retry fault migrates the range back to VRAM. src =
    S with /MIGRATE_PFN_MIGRATE /set is correct here, because the data really is
    in system RAM.

  *

    KFD reuses the /svm_bo/, which P keeps alive, and gets P again as the
    destination. /zone_device_page_init/(P) runs with ref=1 (traced) and
    overwrites the refcount.

  *
</pre>
    </blockquote>
    <p>How KFD reuses same P? From the description above CPU fault has
      not finished because&nbsp; <span style="white-space: pre-wrap">svm_migrate_to_ram has not returned, P has not been returned to KFD driver, so P still has reference count.</span></p>
    <p><span style="white-space: pre-wrap">Then GPU page fault happen on same range. For each migration on a prange there is prange-&gt;migrate_mutex to have migration on the prange happen exclusively. Then how can svm_migrate_to_vram enter migration if </span><span style="white-space: pre-wrap">prange-&gt;migrate_mutex is still hold at </span>
      <span style="white-space: pre-wrap">svm_migrate_to_ram?</span></p>
    <p><span style="white-space: pre-wrap">My basic concern is a vram page can only be involved at one migration at a moment.  If it is getting migrated in two migrations at same time with difference direction there is syn issue. Checking the page ref here to avoid migration is not fixing the root cause.</span></p>
    <p><span style="white-space: pre-wrap">Regards</span></p>
    <p><span style="white-space: pre-wrap">Xiaogang</span></p>
    <blockquote type="cite" cite="mid:PH9PR12MB135921453E146E0DA733B16DE99F612@PH9PR12MB135921.namprd12.prod.outlook.com">
      <pre wrap="" class="moz-quote-pre">
    The CPU fault's /put_page/(P) frees P mid-migration and clears its
    mapping. /migrate_vma_finalize/() misses that PTE (263 of 264 restored), and
    it's left pointing at S. S is freed, and the next /hmm_range_fault /hits the
    BUG_ON in /swapops.h:504/.

The trace and the panic registers match this page and S exactly. With the fix, 
the /refcount /check skipped a busy page 705 times on the repro host with no panic.


Regards,

Apurv



--------------------------------------------------------------------------------
*From:* Chen, Xiaogang <a class="moz-txt-link-rfc2396E" href="mailto:Xiaogang.Chen@amd.com">&lt;Xiaogang.Chen@amd.com&gt;</a>
*Sent:* Monday, October 26, 2026 10:32 AM
*To:* Mishra, Apurv <a class="moz-txt-link-rfc2396E" href="mailto:Apurv.Mishra@amd.com">&lt;Apurv.Mishra@amd.com&gt;</a>; <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.org</a> <a class="moz-txt-link-rfc2396E" href="mailto:amd-gfx@lists.freedesktop.org">&lt;amd- 
gfx@lists.freedesktop.org&gt;</a>
*Cc:* Deucher, Alexander <a class="moz-txt-link-rfc2396E" href="mailto:Alexander.Deucher@amd.com">&lt;Alexander.Deucher@amd.com&gt;</a>; Sierra Guiza, Alejandro 
(Alex) <a class="moz-txt-link-rfc2396E" href="mailto:Alex.Sierra@amd.com">&lt;Alex.Sierra@amd.com&gt;</a>; Kasiviswanathan, Harish 
<a class="moz-txt-link-rfc2396E" href="mailto:Harish.Kasiviswanathan@amd.com">&lt;Harish.Kasiviswanathan@amd.com&gt;</a>
*Subject:* Re: [PATCH] drm/amdkfd: Don't reuse a VRAM page that is still referenced


On 10/23/2026 12:17 PM, Apurv Mishra wrote:

    In svm_migrate_copy_to_vram(), skip VRAM pages with a non-zero refcount and
    leave those pages in system memory for this migration. When an svm_bo is
    reused, a VRAM page can still be held by an in-flight CPU fault
    (do_swap_page -&gt; svm_migrate_to_ram). Migrating to VRAM then re-initializes
    the page via zone_device_page_init(), resetting its refcount. The fault's
    late put_page() frees the page mid-migration, so migrate_vma_finalize()
    never restores that PTE. It is left pointing at a freed system page and
    hmm_range_fault() hits BUG_ON in pfn_swap_entry_to_page() (swapops.h).

If there is cpu fault the data is in vram page. If at same time driver is 
migrating data from sys-&gt;vram  migrate-&gt;src[i] &amp; MIGRATE_PFN_MIGRATE should be 
false since the data is already at device side.

Then if you got a  MIGRATE_PFN_MIGRAT sys ram page at svm_migrate_copy_to_vram 
after migrate_vma_setup, but cpu page fault also happened on same page there is 
a contradict.

So, I do not see this scenario can happen or the real cause is revealed.

Regards

Xiaogang

    Signed-off-by: Apurv Mishra <a class="moz-txt-link-rfc2396E" href="mailto:Apurv.Mishra@amd.com">&lt;Apurv.Mishra@amd.com&gt;</a>
    <a class="moz-txt-link-rfc2396E" href="mailto:Apurv.Mishra@amd.com">&lt;mailto:Apurv.Mishra@amd.com&gt;</a> --- drivers/gpu/drm/amd/amdkfd/kfd_migrate.c |
    20 +++++++++++++++----- 1 file changed, 15 insertions(+), 5 deletions(-)
    diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd/
    amdkfd/kfd_migrate.c index 8b96e1fe741a..1eb92ac6eb05 100644 --- a/drivers/
    gpu/drm/amd/amdkfd/kfd_migrate.c +++ b/drivers/gpu/drm/amd/amdkfd/
    kfd_migrate.c @@ -297,16 +297,26 @@ svm_migrate_copy_to_vram(struct kfd_node
    *node, struct svm_range *prange, amdgpu_res_first(prange-&gt;ttm_res,
    ttm_res_offset, npages &lt;&lt; PAGE_SHIFT, &amp;cursor); for (i = j = 0; (i &lt; npages)
    &amp;&amp; (mpages &lt; migrate-&gt;cpages); i++) { - struct page *spage; + struct page
    *spage = migrate_pfn_to_page(migrate-&gt;src[i]); if (migrate-&gt;src[i] &amp;
    MIGRATE_PFN_MIGRATE) { dst[i] = cursor.start + (j &lt;&lt; PAGE_SHIFT); migrate-
     &gt;dst[i] = svm_migrate_addr_to_pfn(adev, dst[i]); -
    svm_migrate_get_vram_page(prange, migrate-&gt;dst[i]); - migrate-&gt;dst[i] =
    migrate_pfn(migrate-&gt;dst[i]); - mpages++; + /* + * A reused svm_bo page may
    still be held by a CPU fault. + * Reinitializing it would free it under this
    migration, + * so leave this page in system memory. + */ + if
    (page_ref_count(pfn_to_page(migrate-&gt;dst[i]))) { + dst[i] = 0; + migrate-
     &gt;dst[i] = 0; + spage = NULL; + } else { + svm_migrate_get_vram_page(prange,
    migrate-&gt;dst[i]); + migrate-&gt;dst[i] = migrate_pfn(migrate-&gt;dst[i]); +
    mpages++; + } } - spage = migrate_pfn_to_page(migrate-&gt;src[i]); if (spage
    &amp;&amp; !is_zone_device_page(spage)) { src[i] = dma_map_page(dev, spage, 0,
    PAGE_SIZE,      DMA_BIDIRECTIONAL);

</pre>
    </blockquote>
  </body>
</html>

--------------vAE3nLrqpXRnRVL2UqSmqYni--
