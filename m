Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 043D9606A31F
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Oct 2026 14:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=JCRwH/1J
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 978A810E112;
	Thu, 29 Oct 2026 14:56:41 +0000 (UTC)
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010035.outbound.protection.outlook.com
 [40.93.198.35])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1FED310E112
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Oct 2026 14:56:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r2pHTUaJVVBJ93vTwlwzhvLWJYXjReCje1hg2huk9onUiAy8OjPNCAS3rvMBOiCK4/XT790lPoyTpukSt9iBotWm0fxMWRHvbjxzSY9E/s9q8O/i46o7Vu2V8u21MYZZjf9opU2xwgw4QOXSUqmVt5CaZd/OudzT5iH7SznGQcfwdXSnopW3DzZVBPsc55OpUKzVOFBYv44zwdBZg9GOzrAT+JcjOiHhc46AoLpZckmo14RrL0kl0V/iRfrIxFjC/I0P2Uy16eTZPAzEJpC/uhlsfBx0bRaLuuYVGTSXKG8wNaXmavcPYFmSGz5i0KED9CKYM/nttwGYxFrvQ+I0Qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1YMcK7shM9MvHBMOXpbGVY3Nldea4FIecN6R917CPEA=;
 b=NkYE9bnlczjaTWQDQAVcQTS/8NdrBqoggeudeLLah6lv5zR71mjGVhiieL3LuhIUeFwex87fkIooDya8K4zjGS0hbjnBF6Ab2Om9KQOJI8YeycVd0M3FBb15K+CVSVGAzl2pD3Pwj6vdMvH1BlTNvXkGgWJWuph8PRNfEqruHgxaRm31H3r8mZwtarS/uFrmF5OLjNaGz0M5wSkBovcMJDXzPw/OYv0J8CrAiccgIj4Zqeb1qkkWbuGiEv0BCD5xHVo+ybr50FyivJMaUJh7Sa0q3PlElj5TzHhdr95fgyX0oDt0IR3LN1f0CqRjtJ8mjktlpvETu2iwn5IzRC0OoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1YMcK7shM9MvHBMOXpbGVY3Nldea4FIecN6R917CPEA=;
 b=JCRwH/1J8J8kKAaZVVhptgmZB9bPkPTcZm0iNeOKNi7BoHY8a5sC8/WMsJJFlxtvM/h3a8TLvxhgO9EDPLOpHhAPAq91QY6q1mPh76ui+PtfE+T2G4yx6JaHcxZ5zyi6LD5GcLObjTrapQ5ABe6p/57vBL1rEuQZIqyeQh9NBes=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by PH7PR12MB6788.namprd12.prod.outlook.com (2603:10b6:510:1ae::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.8; Thu, 29 Oct
 2026 14:56:30 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0546.021; Thu, 29 Oct 2026
 14:56:29 +0000
Message-ID: <af5949cb-0cc8-4eca-be00-9a64c9a8ccd3@amd.com>
Date: Thu, 29 Oct 2026 15:56:26 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] drm/amdgpu: Implement disabling implicit sync per
 submission.
To: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
Cc: amd-gfx@lists.freedesktop.org, samuel.pitoiset@gmail.com,
 natalie.vock@gmx.de
References: <20261022003058.1723817-1-bas@basnieuwenhuizen.nl>
 <20261022003058.1723817-5-bas@basnieuwenhuizen.nl>
 <9222106f-576f-4921-bf2f-ee59105a7d4f@amd.com>
 <CAP+8YyGggpPyVzjRvAnSCD3q3U2Gdtah0LVPBjhyJvsie+=RHQ@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <CAP+8YyGggpPyVzjRvAnSCD3q3U2Gdtah0LVPBjhyJvsie+=RHQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0179.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a0::16) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|PH7PR12MB6788:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b3917c9-aa57-4620-a3e7-08df35ccd068
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|4143699003|11063799006|56012099006|261009223027099003|261026121527099003|261026140227099003|261028144727099003|261021121427099003|261022075727099003|261021123027099003|261022105027099003|10067099003|22082099003|18002099003|13003099007;
X-Microsoft-Antispam-Message-Info: 8f4qCSfCFCF22dwXL3Wtbf4Nuq3fHIC8pOk/trnB0fn5sLZsbgLBjXoazK/O66Qv9uY+jKXjs6Ck4mVxSN7bEXR3wRDZMCeoCahNnL39sRNrSS/7oOBALUUTiRWzFff9LIOz/cwzsyCZynx6obtyeLVhAVOopu+4I5OImEYtCjNBAEtp5SZpflsqguRMvIy+ltPDEsVaJeB16OBA8pDDp2EiWMhcX3V8t2f2XlctK4GpxAwxOiSv0UZ+/yxzbgRO145vM8LIDRMp6XhArK/LpCsjkgN5UmTABJtdEepfU8sFW02HZcGt/fBmQFJo4sWp97w8F3MpXusFm8XVQpJi2xltXvXUeMfKBZdcHyn6QIFbagOdF6sV/Buwv0srcH5vG9MNKTAcZnZ9t8hOOWH7wBP/6JscAix8LYoXRtFSpgeTLTemCiSQ8+Pb2HBYX49rQAjDxKmmpCSWSxjNI0qLqLBvHkkeL7ycQCZCk5WNGBR2cSAU0s2PCYLyJlILhYlieLZUPM3eWLeqS6x8d82EXVROhAfohkwmcKjYAaADPRVEO8TxjnxrQH8/BN/EU5UxmYMw2/Cm03fr+jA25mY9xqfe9x0PYf64V1JDEanfD9uOith9MK6ayj+IIuh6y/hr
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(4143699003)(11063799006)(56012099006)(261009223027099003)(261026121527099003)(261026140227099003)(261028144727099003)(261021121427099003)(261022075727099003)(261021123027099003)(261022105027099003)(10067099003)(22082099003)(18002099003)(13003099007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WmFpMkt1YVJlNTlvNmRDdHV2SkgxYStXNGovSUFtWVlHQXNTWFh2Nng5anNi?=
 =?utf-8?B?bUdYYXdOU0tuRCt0YnlDc1pnYUxJWXlQTW9xeHN2czdaNjUvMFgvNzF3MmNY?=
 =?utf-8?B?Q2pkVXBUcXJxZGRQbDdqbnc0NGhqbHExM01obG9oRC80NGUrUFdPRVRFNC9v?=
 =?utf-8?B?MFN6aEk1NVVmSFJBN1kxR2xRM0RjOThJVlRvWkVyV055TlRYVU9SelYrZjZn?=
 =?utf-8?B?TDBoZEJMc0FOMmE4SzFldko5T3l2SUk0aEp4eGxoZVJFWUlzeitwTUVqRVZx?=
 =?utf-8?B?OEVYdUxFUnQvUlNQUlRibUVnWnNqeGhVVjE4ejVKWDduZlEvUVB3N0JKRExj?=
 =?utf-8?B?ODlXVERhR2VWczFTSERWenlQSEdySGNIaTd4U1pPZnhUSHdRdDdJWS8zNEZz?=
 =?utf-8?B?VW9LMVFpNWpOc0txMGh0bEJWc0pGdDIxdTMvZzFneWhwU2xxeXBTanZBanhJ?=
 =?utf-8?B?OXBTOTh2eVN5am44NkpScVgzcDZMRXU0UXJIeUtiekZkazJlUVhvelRyOS9O?=
 =?utf-8?B?cm4raS9TOEgrdnFpL2VSd2ZYVXIyajl2bm5PUFhXQ09ra2laQ0VsMlhzL1pC?=
 =?utf-8?B?UjFxVysrUHprNlJCZnhJMW4rejZReUtlRDdSS0RZZktlYXJxa1N4eWZ0SnVs?=
 =?utf-8?B?VEZhVUFpRU5xWTFlWFNxeTZUcVFab1dtWngwMzZHWVI1QXBRUFNxOXNtdmVX?=
 =?utf-8?B?U2FiOXRNT3hNUnBMd25IaHBzVEM5Q2xhRUNtamJTTkVkZVZnem5DcGVZaDIx?=
 =?utf-8?B?YmcvUjZQWDhFcFdYT01FSE9aTkdpdXI5ZmhhUjZ4STU1ZUFVQ0d5UHZESFNv?=
 =?utf-8?B?Z09JaWw5RUh1ZmhUV0ptSzBWZHlvN3lXYWs2ZHh5WWJtdEErdDg2ZUtlcExw?=
 =?utf-8?B?SDM3YUdKUEpOUENGWFpuWjQzV3R6UktxbG0wM1p5SWl4OXBBUmxFcjN6eExC?=
 =?utf-8?B?SVNGc0NNT1JVcnUzVXVvSHd5Z1lNWC9iTDF4c3ErT2JQMnFEcEFvb2h4YTJT?=
 =?utf-8?B?VEhsVzFydEhtV1RTbU5WZUlnOGlHeTg1OE1DNS9vWkE3Sk1pdzdWWnQzZkhX?=
 =?utf-8?B?WDE3UWo1b0NkZW1oQUNZeVNWVVRycThJZHNyeXQvblVSSTV2Z295azJKRGhu?=
 =?utf-8?B?YmJLcExTOExFemtSZ2EzQlJkRUZ0L2dWc0p2d0w2djhnM1RPSXRIWEREVHFt?=
 =?utf-8?B?cGtKb25CZ2JYNmdHcjIrV0w1Z2luUHNRWjdhcFg3VWsyQ1dldTZvRXlNYlEv?=
 =?utf-8?B?bEVqOVlrWDg3d1Ryd0VZbEg1M2pnc0dXNGJZUHVhWEUxZHVoZkFadjBhVEJ3?=
 =?utf-8?B?K093cWR2UDVaZDAyL0lUQ25yNHlTSUgzZTgzb01WVDZEVFpLRFlqMUtjRVJ4?=
 =?utf-8?B?dmdSQzI5U1FvRTJteUVkc0MreWNpMGpZSGZQeERnbzZ1dlVTUHpOSnpOQ0Vq?=
 =?utf-8?B?STZYOWRUQVN1UGJJVFRvN3Buby9XdTJkaHNPYzFYOVhoaGpzOGJzTlFtdVE2?=
 =?utf-8?B?d2pTSnQxQmplaytFK2hjM3ZCSktSSm1jNG5BMDZtYms4TFJDZUV2QUpZL28z?=
 =?utf-8?B?NnZmNDh3WU9yVVd1UUQyZURuVkt2Z0hzSFZiNStjU0drK0gwZ2l0OXZLRzNh?=
 =?utf-8?B?Tzk4Q3J6Qld1N0MwYWc1aFRuZHlmaSsrS0JBTkIyUys0ek5UTG9zSzJ1ZE1l?=
 =?utf-8?B?L3lxTmFzdkJWc1lnZG5KbytENWZGc2RRaGFac3Nic0ZoVU9IeXpRaDlLZXlF?=
 =?utf-8?B?RE4yWkFjSFhkeVoreFk1eXI4UjRBUWgvNndtT3lNdXV0ano2ZzhDMEg4T3FU?=
 =?utf-8?B?a0QrSlgvYkZXenBjV1VVNXlicWV1QWl3WnlvYWZYT2FKWFBqMEw3ZlB2Z2xG?=
 =?utf-8?B?MG5NeDF4UUpBSDRwNGNUN3NVUFREMDhaT3U2SzRwUWVnUlBjd2x2UHNYcXl4?=
 =?utf-8?B?SENkeWZDRFFxVEtubE01bEFVSjVkL2pqaHBZYXNJTCtwc29lY3IvbkF2UFJu?=
 =?utf-8?B?eUdhdWVhU1I0aW1KQnlZVngzMHpJY1JtVmxmcVNXZStrYjlqSkRlL0tDMFN6?=
 =?utf-8?B?K25KUklPOUFxODYyNm1MY3BHQTA1WSsrSUNYZnBBdnRSMlAwWDNzWWEwTzhz?=
 =?utf-8?B?RmJQd05YTCtYb0NpbzFlTVY1MXNCM1U2MmxCcERGYWw2cDYrMWxQV0xHYnQ3?=
 =?utf-8?B?d1hUUm1adU15OVB0RkIxVmdyQVM5Y05CL1JiQ0VDQ3dYdkJjTEJDOTlSNHFm?=
 =?utf-8?B?K09KcDdyZVExRmNhMEVvUEV5RE5nWEFOK21RVDJCUXhzQ1JjMDNoZUM4Y1pI?=
 =?utf-8?Q?oYV53hbID43xfd9zcu?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b3917c9-aa57-4620-a3e7-08df35ccd068
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2026 14:56:29.8891 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Tz2xVqFBLVx2xdNjx6h6bfmiVutMS8PiAZFb5cjMhWWjtbmav85srv5RxcFbXRgX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6788
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
X-Spam-Status: No, score=-22.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/28/26 20:59, Bas Nieuwenhuizen wrote:
> On Tue, Oct 27, 2026 at 1:30 PM Christian König <christian.koenig@amd.com <mailto:christian.koenig@amd.com>> wrote:
> 
>     On 10/22/26 02:30, Bas Nieuwenhuizen wrote:
>     > Implements the UAPI flag to give apps an options to disable
>     > implicit sync per submission.
>     >
>     > v2:
>     >  - signal READ fences for the VM root PD, as some unmapping
>     >    operations only wait for READ and up.
>     >
>     > Signed-off-by: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl <mailto:bas@basnieuwenhuizen.nl>>
>     > Reviewed-by: Faith Ekstrand <faith.ekstrand@collabora.com <mailto:faith.ekstrand@collabora.com>>
>     > ---
>     >  drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c | 34 +++++++++++++++++++++-----
>     >  drivers/gpu/drm/amd/amdgpu/amdgpu_cs.h |  1 +
>     >  2 files changed, 29 insertions(+), 6 deletions(-)
>     >
>     > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
>     > index afcd254c9884..f0fe9d0f1398 100644
>     > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
>     > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
>     > @@ -49,6 +49,9 @@
>     >  #define AMDGPU_GFX_SDMA_IB_PACKET_SIZE_MAX_DW        0xFFFFF
>     >  #define AMDGPU_MM_IB_PACKET_SIZE_MAX_DW      0x7FFFF0
>     > 
>     > +/* All flags accepted in drm_amdgpu_cs_in.flags */
>     > +#define AMDGPU_CS_FLAGS_MASK AMDGPU_CS_NO_IMPLICIT_SYNC
>     > +
>     >  static u32 amdgpu_cs_ib_packet_size_max_dw(enum amdgpu_ring_type type)
>     >  {
>     >       switch (type) {
>     > @@ -188,9 +191,11 @@ static int amdgpu_cs_pass1(struct amdgpu_cs_parser *p,
>     >       int ret;
>     >       int i;
>     > 
>     > -     if (cs->in.flags)
>     > +     if (cs->in.flags & ~AMDGPU_CS_FLAGS_MASK)
>     >               return -EINVAL;
>     > 
>     > +     p->flags = cs->in.flags;
>     > +
>     >       chunk_array = memdup_array_user(u64_to_user_ptr(cs->in.chunks),
>     >                                       cs->in.num_chunks,
>     >                                       sizeof(uint64_t));
>     > @@ -1220,16 +1225,19 @@ static int amdgpu_cs_sync_rings(struct amdgpu_cs_parser *p)
>     >       }
>     > 
>     >       drm_exec_for_each_locked_object(&p->exec, obj) {
>     > +             /* Implicitly sync only to KERNEL, WRITE and READ */
>     > +             enum dma_resv_usage usage = DMA_RESV_USAGE_READ;
>     >               struct amdgpu_bo *bo = gem_to_amdgpu_bo(obj);
>     > 
>     >               struct dma_resv *resv = bo->tbo.base.resv;
>     >               enum amdgpu_sync_mode sync_mode;
>     > 
>     > +             if (p->flags & AMDGPU_CS_NO_IMPLICIT_SYNC)
>     > +                     usage = DMA_RESV_USAGE_KERNEL;
> 
>     Use DMA_RESV_USAGE_WRITE here.
> 
>     > +
>     >               sync_mode = amdgpu_bo_explicit_sync(bo) ?
>     >                       AMDGPU_SYNC_EXPLICIT : AMDGPU_SYNC_NE_OWNER;
>     > -             /* Implicitly sync only to KERNEL, WRITE and READ */
>     > -             r = amdgpu_sync_resv(p->adev, &p->sync, resv,
>     > -                                  DMA_RESV_USAGE_READ, sync_mode,
>     > +             r = amdgpu_sync_resv(p->adev, &p->sync, resv, usage, sync_mode,
>     >                                    &fpriv->vm);
>     >               if (r)
>     >                       return r;
>     > @@ -1341,9 +1349,23 @@ static int amdgpu_cs_submit(struct amdgpu_cs_parser *p,
>     > 
>     >       p->fence = dma_fence_get(&leader->base.s_fence->finished);
>     >       drm_exec_for_each_locked_object(&p->exec, gobj) {
>     > +             enum dma_resv_usage read_usage = DMA_RESV_USAGE_READ;
>     > +             enum dma_resv_usage write_usage = DMA_RESV_USAGE_WRITE;
>     > 
>     >               ttm_bo_move_to_lru_tail_unlocked(&gem_to_amdgpu_bo(gobj)->tbo);
>     > 
>     > +             /*
>     > +              * Keep READ/WRITE on the root PD resv:
>     > +              * amdgpu_vm_bo_update(clear=true) only waits on the VM root PD
>     > +              * resv with read and should still sync to avoid unmapping
>     > +              * before the job finishes.
>     > +              */
>     > +             if ((p->flags & AMDGPU_CS_NO_IMPLICIT_SYNC) &&
>     > +                 gobj->resv != vm->root.bo->tbo.base.resv) {
>     > +                     read_usage = DMA_RESV_USAGE_BOOKKEEP;
>     > +                     write_usage = DMA_RESV_USAGE_BOOKKEEP;
>     > +             }
>     > +
> 
>     Completely drop that.
> 
>     >               /* Everybody except for the gang leader uses READ */
>     >               for (i = 0; i < p->gang_size; ++i) {
>     >                       if (p->jobs[i] == leader)
>     > @@ -1351,11 +1373,11 @@ static int amdgpu_cs_submit(struct amdgpu_cs_parser *p,
>     > 
>     >                       dma_resv_add_fence(gobj->resv,
>     >                                          &p->jobs[i]->base.s_fence->finished,
>     > -                                        DMA_RESV_USAGE_READ);
>     > +                                        read_usage);
>     >               }
>     > 
>     >               /* The gang leader as remembered as writer */
>     > -             dma_resv_add_fence(gobj->resv, p->fence, DMA_RESV_USAGE_WRITE);
>     > +             dma_resv_add_fence(gobj->resv, p->fence, write_usage);
> 
>     Instead just set that here to DMA_RESV_USAGE_READ when the CS is explicitely synced.
> 
>     This way we get amdgpu nearly back to the usage model all other DRM drivers uses.
> 
> 
> I think this has two problems:
> 
> 1. It doesn't fully solve the problem I'm trying to address. In the common Vulkan WSI apps for present signal WRITE  and then wait on READ[1], meaning that the proposed wait on WRITE and signal READ result in submissions from the compositor still fully participating in implicit sync wrt presents. Waiting on KERNEL and signalling BOOKKEEP actually resolves this.

Yeah and that was fully intentional. 

> 2. While the driver landscape is very diverse I think other drivers are actually pretty much moving to KERNEL/BOOKKEEP. In particular:
> - Xe does the KERNEl/BOOKKEEP[2]
> - MSMs BO list based path skips waits alltogether with MSM_SUBMIT_NO_IMPLICT [4], though signals READ/WRITE, but its newer VM_BIND based submission path does not have any BO list at all and adds a BOOKKEEP fence to all external BOs imported into the VM[5]
> - Panthor skips waits alltogether and signals BOOKKEEP[6]
> 
> And finally I think KERNEL/BOOKKEEP follows the dma-resv documentation[3]:
> - DMA_RESV_USAGE_READ: This should only be used for userspace command submissions which add an *implicit read dependency*.
> - DMA_RESV_USAGE_BOOKKEEP: This should be used by submissions which don't want to participate in any implicit synchronization. The most common cases are preemption fences, page table updates, TLB flushes as well as *explicitly synced user submissions*.
> 
> (emphasis mine)
> 
> So I'm not sure why we shouldn't stick with KERNEL/BOOKKEEP?

Because of the usage model amdgpu uses I'm still not sure if that will actually work with bookkeep or not.

What might be possible is that we set the owner to NULL/UNKNOWN instead of the VM pointer for the fences when the explicit sync flag is given, this would give us the same semantics other drivers use as well.

I would need something like a day to completely wrap my head around all that stuff again to judge and I absolutely can't find any time at the moment for such stuff.

Regards,
Christian.


> 
>  - Bas
> 
> [1] https://gitlab.freedesktop.org/mesa/mesa/-/blob/main/src/vulkan/wsi/wsi_common_drm.c?ref_type=heads#L48 <https://gitlab.freedesktop.org/mesa/mesa/-/blob/main/src/vulkan/wsi/wsi_common_drm.c?ref_type=heads#L48>
> [2] https://github.com/torvalds/linux/blob/v7.3-rc4/drivers/gpu/drm/xe/xe_exec.c#L303-L311 <https://github.com/torvalds/linux/blob/v7.3-rc4/drivers/gpu/drm/xe/xe_exec.c#L303-L311> and https://github.com/torvalds/linux/blob/v7.3-rc4/drivers/gpu/drm/xe/xe_exec.c#L335-L337 <https://github.com/torvalds/linux/blob/v7.3-rc4/drivers/gpu/drm/xe/xe_exec.c#L335-L337>
> [3] https://github.com/torvalds/linux/blob/v7.3-rc4/include/linux/dma-resv.h#L71-L116 <https://github.com/torvalds/linux/blob/v7.3-rc4/include/linux/dma-resv.h#L71-L116>
> [4] https://github.com/torvalds/linux/blob/v7.3-rc4/drivers/gpu/drm/msm/msm_gem_submit.c#L678-L682 <https://github.com/torvalds/linux/blob/v7.3-rc4/drivers/gpu/drm/msm/msm_gem_submit.c#L678-L682>
> [5] https://github.com/torvalds/linux/blob/v7.3-rc4/drivers/gpu/drm/msm/msm_gem_submit.c#L410-L413 <https://github.com/torvalds/linux/blob/v7.3-rc4/drivers/gpu/drm/msm/msm_gem_submit.c#L410-L413>
> [6] https://github.com/torvalds/linux/blob/v7.3-rc4/drivers/gpu/drm/panthor/panthor_sched.c#L4056-L4062 <https://github.com/torvalds/linux/blob/v7.3-rc4/drivers/gpu/drm/panthor/panthor_sched.c#L4056-L4062>
> 
> 
>     Regards,
>     Christian.
> 
>     >       }
>     > 
>     >       seq = amdgpu_ctx_add_fence(p->ctx, p->entities[p->gang_leader_idx],
>     > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.h
>     > index 39c33ad100cb..5c2a5f6b1d55 100644
>     > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.h
>     > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.h
>     > @@ -50,6 +50,7 @@ struct amdgpu_cs_parser {
>     >       struct amdgpu_device    *adev;
>     >       struct drm_file         *filp;
>     >       struct amdgpu_ctx       *ctx;
>     > +     u32                     flags;
>     > 
>     >       /* chunks */
>     >       unsigned                nchunks;
> 

