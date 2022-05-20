Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6957C433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 20 May 2022 20:54:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1127D10E399;
	Fri, 20 May 2022 20:54:08 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2077.outbound.protection.outlook.com [40.107.94.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4BAA110E399
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 May 2022 20:54:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NwV8MPnjypqwWo4SnwKOxylHyeT7J4aTj29N6LvAuxTGI/SwdPyhQKZoxSoEG41anzsqj67uhp814+/eFZxfHE7l4fwY7Tqb0fC6/3g9pwghsMP97R2fhh61yOUnOrYaXG5+iFsC9bK4LFuEU1LgdU/MLTL37G8dbgULbTE8opKbWk7kitue/RI6MIB1plyz6QTXJ3BiVbJQGlr9ewaC4+KdYsYnqOFaG2DcmTR2WHAyc+cyH3nesxhX16yEMjvIxDOq/Br2T1I8HXQHNFvN5lMbEI78Y2jm7NXTBsGbHRcTiI7510D8hBD0M1j+hvqU7A5DcFoFroaNcl3/VcX9zQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lQOVTU7+H9iEP/PHWx1f+GjW1/IMwpBMZmJy1E8YANA=;
 b=MlpLFxUEnKaDzKk7Vv7iK48wVO8/i1Sr35mVM5ChD79CVBAgeu01w++SQvrn+MhIukziMj8ozBmF5hxXBwo56trXCtJP8d8jpFsv5kzyLuFit5769+sZcp7otKvFz0Wy+4qzGy9Nt1nB4XW5PitG20Pl6Newc+4AQG111//+e52hRmJl81qfuyWfTawPFwKq9FrAmDK3/qXP18Wxte2YQHN7kmrLCfl7YjtDjKK7w/ZowwL1KXOhY0O2IHy9ThZ2oZJkyZH2f2orHZiXGdtAUBXjZu3mZbm41kEdyQu+EbEdlWiyivyB1ldpGJAl2tuglJGn580I8fLd4j4j2Ih+Xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lQOVTU7+H9iEP/PHWx1f+GjW1/IMwpBMZmJy1E8YANA=;
 b=nxyFYX9xajFcTYyQrnZK1nP62VbkTYBd9gfTH4yVL4daugVTad07puxNr+ffRpRksVgnXyE1H1U+Nb7CJO9goXM6I4qavqCXSSU0GRLhdmBIJhMZjAnscEfGHDOSY+0/8LxGNS2xoNTLOWY/jCuqle1RxIBlpcS/uPsfjQE8sSA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by DS0PR12MB6581.namprd12.prod.outlook.com (2603:10b6:8:d3::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.14; Fri, 20 May
 2022 20:54:05 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::1cf6:2a9d:41d6:e8c3]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::1cf6:2a9d:41d6:e8c3%4]) with mapi id 15.20.5273.018; Fri, 20 May 2022
 20:54:05 +0000
Message-ID: <d09dcbc3-1e32-866a-5471-c3bd1682f743@amd.com>
Date: Fri, 20 May 2022 16:54:03 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH] drm/amdgpu: Adjust logic around GTT size
Content-Language: en-US
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>
References: <20220519143446.74326-1-alexander.deucher@amd.com>
 <981e5ec0-2073-3308-0f66-488300d36065@gmail.com>
 <CAAxE2A7iJT19myNfU8TbqqounG=Yvm1_N4aakvTbPipRxrg1gA@mail.gmail.com>
 <151a0478-8dbb-49c7-ab45-99dd9a1fcc2d@gmail.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <151a0478-8dbb-49c7-ab45-99dd9a1fcc2d@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN2PR14CA0005.namprd14.prod.outlook.com
 (2603:10b6:208:23e::10) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 573fab45-6bbe-4469-9b15-08da3aa2e03c
X-MS-TrafficTypeDiagnostic: DS0PR12MB6581:EE_
X-Microsoft-Antispam-PRVS: <DS0PR12MB65811D7371FDE167A624DA5292D39@DS0PR12MB6581.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: K3aHonmyGTWh6OE/LnxZ20DR+w/5WNAlquKohESHKXUSyk4i9Gd/d9vjxnAnezbERI8DpxOxN7pasX0zWeWSWD15wWUH7mwL/GLg2JdkNqV1HOCaPpn8sW7iqL0Q/xbn61fv3WStlIMsm4BPsGg7vbInuOcFu83ZjyZgV4XrmGXyTkowv4Ip0yG6dhrcOocFFzaEqnEk7kVHh1nlY6fR10AxWJCQBQxf+7wbaCFZqOak4vx84LsQsnUJRa2uS4R28ndC8nb+nyU7lWyvS0P2oGE8IJ7n86gkg4EmSoC4zp02c6AUndo4JIFwFZYdumH8HG5yzo6KTQhycASASZFhiJ2GJz+p3heHB3j3AUy4q369LudQCGS1UOZv/AE4QzbrE0uwzL09MkAw/N/y/tSLeJHm9UfLu/YFbhwQbkkJLSbencBJIWqKSOW07TwLI4yPOCeMFRNDw4f1A7KLJ0XzQ7Ic3RfX64KnLwapS25nVuUH1FFxCKyoRvuQNCdSy94j5R0ZtXMlvHdWwpWTQR02zNNMRkQ7nvlfblt88kO42fsBkRTORAxDhjMGYz2JcSnH6/UtexYxaOKvj0LkOvK6o7JWgzEUrBU+Bp9O4K1940fPTIvRcH457O7bqHaC/rzdr50xYXQwRZ42QDqyBX12tovWfy1Ag3DFFhpLOpknBX1O1xYhP+8rcpsxy3VnQbB8D5XwTyMrlQrUAMpRMbYPs7P6naoaDS8yXnem1wOKwLkQXyipUEvouBD3i9IgCCrv
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(6506007)(26005)(36756003)(83380400001)(186003)(8676002)(5660300002)(508600001)(8936002)(44832011)(36916002)(6512007)(53546011)(31686004)(66574015)(54906003)(66476007)(110136005)(66946007)(66556008)(2616005)(86362001)(4326008)(316002)(6486002)(38100700002)(31696002)(2906002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TnhiWnZSZi8vN0NvNHd4bTh4ZmZPenNGc1VtcjdrNzlTUHFrSVlDamk2Nm5V?=
 =?utf-8?B?MUJjeVU4c0h6TCtraTdLazRJaCt4UGUyTkY2SS9sTGMrN05WSW1Vc25sZ0NC?=
 =?utf-8?B?RllZYkZIdnJ4YnhxTTdEdFI0aHpjV1orYzhFWmdWcGtBZWd4QWVhQmdDRzMx?=
 =?utf-8?B?RHB3WU83UnRhd3MxVTJWUEhtdkx1VWpXTkhxcm1vdzR6OWE1UG81M1lMUmJw?=
 =?utf-8?B?NUN5Y1VKRVFnQm44ZWlHbHlpNmJtN2crTFl5UzU3a0VwYW1HQm90RDU0Z0ZV?=
 =?utf-8?B?YUZuc0VnQWMvWlBMU21RYXlIOUJNd2hHbFd5L0JyQ1lab3hLd1QrQmVQMmpo?=
 =?utf-8?B?cDhZQzlpWkVZOUhVWTAwMndhZGYyYTF6OTdSZDFEMGRGNFE0MmtheUdIblZt?=
 =?utf-8?B?NlBDNXRKeVJUeE90NTFGNHhMWU5PNEZuYW9udzZuMFNyZXVFTEFIaXBWZVhK?=
 =?utf-8?B?QzJWcXJrWVlWM0JwbjJiVHpjVXM4N0VFaXR6RmxCdnh4MTlLRDU5VDU3YWFu?=
 =?utf-8?B?Y2hsWFhnRHZNZFkzNWJiWjh3Tm0yN0M2VU1NSlRQbHZEOG1zcnpNenhTVUUw?=
 =?utf-8?B?M01YdjNHYm9qSTNBQVhqQ0R3d1BKNUZiU21iSVA3ZUlpb01LYlI5eVdMeHk2?=
 =?utf-8?B?ZnJlVVJtV216WlE3Q0h0MFJlWk5xbllINHVQci9CZkRocVdOcGYybS95a3d1?=
 =?utf-8?B?WktFNEJXa3lRT3dUNVBPSERIeUFKQnZUL0ZsSnNWYlBGUTBPeGY0Z1prR0dx?=
 =?utf-8?B?Mytva3ZDb3FKZ2RYb2lyNTN0K050NVYzNWJYdC9zbzBIcEhNNW5URHJ0OStE?=
 =?utf-8?B?U1I1cms4MEdjSjhuUy9RTTNSRGZLMkwrdFZVT0diT28wNDlaV0w0Y1d5UDRz?=
 =?utf-8?B?RlZJeFlEYXBwRjkrWVJ5Nlg1aWszSS83ZzNRUkxuR0ZHZlhqZkVlUjFJUHp5?=
 =?utf-8?B?ZkIwT2hqSi90NWFPSHdPZFBtRnBUVTVoVXdvWVZzR2huaGlRSmYyeTcxajNN?=
 =?utf-8?B?TE1rOVluN1p1bHpLbFhlMUpmRzNQVHdhNytLeVd6Zk8vYmQ5eHF6VzVhYzJi?=
 =?utf-8?B?dUVQUDM0MTdDRCtEZHNGeFZ5SXoyeGIvQ2FPaExtdWtzcjBwVG0yMXNUbEwy?=
 =?utf-8?B?ZjRQdDNVZk1Xc1h5NkpGa2FQNjhiZ3BRaVBYZHJaY0o3MGdVVU9renhqQ2Vy?=
 =?utf-8?B?MTVQMFBoMTVvbXIzVmZSWDlBTmZxRDdZMzVOODFBZm9sUmxHZXlseVFucWwy?=
 =?utf-8?B?amFxQkc2ZUlTb0N2ZitVdmVnZ3JOaXRkdnJTcFFLeW5zZVVneGR0d0VodWNZ?=
 =?utf-8?B?UXZSQUl5SEU0TnI2WjVjcmdxMmFMZ1BmY0ZZQmNHSXVHd2hoalNxYnFNUmxG?=
 =?utf-8?B?UEpLcUIxbzNERlVjb2cyUzFLYU82NHRNS0NzSFBGZ2hWcHBIdzhjMVJUZ01w?=
 =?utf-8?B?NVIzK2p3Q05ybnF4d2lhZlYwa3l0cDVIQjhYSFkwL3JvZXkrTldzVTFuenhV?=
 =?utf-8?B?TFY1eEMzd3dZQmY3SDdXd1dURXQrMXgrSVNvbXViN253elB4b3hrUHB3L0RN?=
 =?utf-8?B?WFFVTWtRRDkvRll2TlVtR0t1NFdvUGFnenRXOXNLV21ORkVzeTRpVHJnYzl0?=
 =?utf-8?B?WVRJaGhzQWo4SzRydGJrRDkxVnMvSUxzWmtmK0c4U0V5L09nVVRHTk5kT2dz?=
 =?utf-8?B?NlBrdmhJeHNkbFhaZ3FTdWJ0K2p3STFEckxlL1RZV1Y4RDJpYkZlS0NsVlRh?=
 =?utf-8?B?cEcvUWtENWVzMzdxbElJZ3FxMWZVdUZ2WTZBMXpYMXphbk1rajZHeWFlWmlt?=
 =?utf-8?B?c3prbFVhdDdGQ1d6R0p6Y1BRZncrK2pSWVIxVnhJWW1USTRxa3h5eWhIanMr?=
 =?utf-8?B?NEY0UUFuUDJDaXd3WllvZEg2TzM5YW5qdHJ1cFdiZHREN2t5MmZ6UVNjNDBM?=
 =?utf-8?B?SGlBV3FNUHhHSnA1aS9Mdm5WSzN6ZUR0cnBacFhlWFdDMW1Va0xXYU9LVTZ1?=
 =?utf-8?B?QVc0WEhYU1ZtWHBKZVpyR0NxcVNvTE5WWU8vK0ZYelJMVlJnYW9CcVM0KzJT?=
 =?utf-8?B?a1JLVEpVZVA3ajdNTjVFcTlRVlQvWWp6U3hLMkVGQ3lWamw1UEFORjdHL2Rx?=
 =?utf-8?B?a25UUE4xczRtOUp2R2t4T0haY0FRQkJ3SnVZbkZBaWhFUlBpNkNaRmhQYXNM?=
 =?utf-8?B?SGFnOTB5MGpPSko4NmpRdFp3aDNTTXMvekpKTkJUMjRHWDBwa2NQKzMydzcw?=
 =?utf-8?B?YzN5K1FIV3NQQVFIajJvajFPN2FqVjZQTDZGMW0xdUxqSUVpVGJ3N0lnVlBi?=
 =?utf-8?B?dStuMTJBZVh0R0VZbnYra245bkRORklBWWI5SDg2amNVdEtZZ0YxQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 573fab45-6bbe-4469-9b15-08da3aa2e03c
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2022 20:54:04.9402 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9S6PGruuDh+mgq72WXL1bAPWZ1Lzhe5SHoG4hEzUSzhBbwgtQOZrHzQiLLM/ReW50IO1TFfH6mmBfDi/H6mfbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6581
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 amd-gfx mailing list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2022-05-20 05:42, Christian König wrote:
> In theory we should allow much more than that. The problem is just 
> that we can't.
>
> We have the following issues:
> 1. For swapping out stuff we need to make sure that we can allocate 
> temporary pages.
>     Because of this TTM has a fixed 50% limit where it starts to unmap 
> memory from GPUs.
>     So currently even with a higher GTT limit you can't actually use this.
>
> 2. Apart from the test case of allocating textures with increasing 
> power of two until it fails we also have a bunch of extremely stupid 
> applications.
>     E.g. stuff like looking at the amount of memory available and 
> trying preallocate everything.
>
> I'm working on this for years, but there aren't easy solutions to 
> those issues. Felix has opted out for adding a separate domain for KFD 
> allocations, but sooner or later we need to find a solution which 
> works for everybody.

For the record, the reason I added a new domain is, because the GTT 
limit otherwise applies to memory, that isn't even managed by TTM 
(userptrs) and isn't under TTM's 50% system memory limit in the first place.

Regards,
   Felix


>
> Christian.
>
> Am 20.05.22 um 11:14 schrieb Marek Olšák:
>> Ignore the silly tests. We only need to make sure games work. The 
>> current minimum requirement for running modern games is 8GB of GPU 
>> memory. Soon it will be 12GB. APUs will need to support that.
>>
>> Marek
>>
>> On Fri., May 20, 2022, 03:52 Christian König, 
>> <ckoenig.leichtzumerken@gmail.com> wrote:
>>
>>     Am 19.05.22 um 16:34 schrieb Alex Deucher:
>>     > The current somewhat strange logic is in place because certain
>>     > GL unit tests for large textures can cause problems with the
>>     > OOM killer since there is no way to link this memory to a
>>     > process.  The problem is this limit is often too low for many
>>     > modern games on systems with more memory so limit the logic to
>>     > systems with less than 8GB of main memory.  For systems with 8
>>     > or more GB of system memory, set the GTT size to 3/4 of system
>>     > memory.
>>
>>     It's unfortunately not only the unit tests, but some games as well.
>>
>>     3/4 of total system memory sounds reasonable to be, but I'm 100%
>>     sure
>>     that this will break some tests.
>>
>>     Christian.
>>
>>     >
>>     > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>>     > ---
>>     >   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 25
>>     ++++++++++++++++++++-----
>>     >   1 file changed, 20 insertions(+), 5 deletions(-)
>>     >
>>     > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>>     b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>>     > index 4b9ee6e27f74..daa0babcf869 100644
>>     > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>>     > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>>     > @@ -1801,15 +1801,30 @@ int amdgpu_ttm_init(struct
>>     amdgpu_device *adev)
>>     >       /* Compute GTT size, either bsaed on 3/4th the size of
>>     RAM size
>>     >        * or whatever the user passed on module init */
>>     >       if (amdgpu_gtt_size == -1) {
>>     > +             const u64 eight_GB = 8192ULL * 1024 * 1024;
>>     >               struct sysinfo si;
>>     > +             u64 total_memory, default_gtt_size;
>>     >
>>     >               si_meminfo(&si);
>>     > -             gtt_size = min(max((AMDGPU_DEFAULT_GTT_SIZE_MB <<
>>     20),
>>     > - adev->gmc.mc_vram_size),
>>     > -                            ((uint64_t)si.totalram *
>>     si.mem_unit * 3/4));
>>     > -     }
>>     > -     else
>>     > +             total_memory = (u64)si.totalram * si.mem_unit;
>>     > +             default_gtt_size = total_memory * 3 / 4;
>>     > +             /* This somewhat strange logic is in place
>>     because certain GL unit
>>     > +              * tests for large textures can cause problems
>>     with the OOM killer
>>     > +              * since there is no way to link this memory to a
>>     process.
>>     > +              * The problem is this limit is often too low for
>>     many modern games
>>     > +              * on systems with more memory so limit the logic
>>     to systems with
>>     > +              * less than 8GB of main memory.
>>     > +              */
>>     > +             if (total_memory < eight_GB) {
>>     > +                     gtt_size =
>>     min(max((AMDGPU_DEFAULT_GTT_SIZE_MB << 20),
>>     > + adev->gmc.mc_vram_size),
>>     > +                                    default_gtt_size);
>>     > +             } else {
>>     > +                     gtt_size = default_gtt_size;
>>     > +             }
>>     > +     } else {
>>     >               gtt_size = (uint64_t)amdgpu_gtt_size << 20;
>>     > +     }
>>     >
>>     >       /* Initialize GTT memory pool */
>>     >       r = amdgpu_gtt_mgr_init(adev, gtt_size);
>>
>
