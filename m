Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CBF2C433FE
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Mar 2022 09:15:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C2BE010E0D8;
	Thu, 17 Mar 2022 09:15:08 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam08on2078.outbound.protection.outlook.com [40.107.101.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A015310E0D8
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Mar 2022 09:15:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H8O+VWFfAwc0Za7S/rDidwBmsZR8RbJO66a2bJrPoIOVAAA+G0pVtBSIOFSxvnbzU1Vur0ZRK76GLKSN7ZQ/nzYFmeBJgC5EVWDH1H5Yxw1o+gF90Cl90Ac7HaQjTadS+REnq6VwUYWamsnNJvwkWiMLUHyStXJCPs5N4/UYqFqOpXtC2qc2YiaOZWLsYtOq2EVFmjgfxk8P5hZO0n62ggrznsY7p5S7VyjtX22Hxy+B18jyZ/OahubMRKQuq8VSOB8zUKqZtCPaVCFp9b1RLFRfdU2oXMke2fvgS+MnLt4DQ9a4MpisfCbW/1nwPi6vcaCNq1alU3YvYjY3xQUZrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nNkin4bHQamdp4eLOW2EvAmYFw7yxXpMDOjlvHr1qSE=;
 b=GWXZu3LdiLqRsZGRgWW5EAioPms1hMWw6U+r6LtK20rxzy3iZP8EECewaw2jlq0Rha1fco3Md06acSuzJ+lBmQjMSjgAN0fX8gzVNP3FvbOzOJ60HIILW0BlAZT63r6+A809nLJ++5KTgVkFk0IN/Ow3EilfrabH2aXMEPpQ47BC48XckuQQoDOk/9cHqmBrMwa2vW2n/W3VS62B2vYmrTGDqx/JBC5BcZvcxYFC+WL7NFAK3P2dRTO6w2Tajfz5C0j9TIE2Dr1ly1iRPhb4aLTRtGPDNUccxd/CURKIvlQquoYZiuUIBUwEmkty6vSqTTc1jN9vgHJLeCo2qVi97g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nNkin4bHQamdp4eLOW2EvAmYFw7yxXpMDOjlvHr1qSE=;
 b=orda/UGfWDsTfdcUsSFf1Vg25LvURmGKYLh75U+zHh+wFR50CH+8v4YomJ5h2mBKua5rHnsaRc2XMjR4GL1YVc+VjbLLjM3DmugNLlcJe5meFqv/7LmH0EObdaruiQ6J6yd1Yy3fiJvUSygVwa6rVxxT+T/NgHimHIstIZccCjU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by DM4PR12MB5391.namprd12.prod.outlook.com (2603:10b6:5:39a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.14; Thu, 17 Mar
 2022 09:15:05 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::404f:1fc8:9f4c:f185]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::404f:1fc8:9f4c:f185%6]) with mapi id 15.20.5081.015; Thu, 17 Mar 2022
 09:15:05 +0000
Message-ID: <a62372c7-d274-a58a-0487-d199312fd7d6@amd.com>
Date: Thu, 17 Mar 2022 10:14:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: radeon ring 0 test failed on arm64
Content-Language: en-US
To: Peter Geis <pgwipeout@gmail.com>, Kever Yang <kever.yang@rock-chips.com>, 
 Robin Murphy <robin.murphy@arm.com>, Shawn Lin <shawn.lin@rock-chips.com>
References: <CAMdYzYptw9L=5SECtVkNZruTT-x57+03vj0A+5efvq8cESzLyQ@mail.gmail.com>
 <CADnq5_NXmRr_Q7JuWZxJAjmavVkvJjNcWayQ1x8LhfcX5CS0uA@mail.gmail.com>
 <CAMdYzYoamh-igvBbKaLSJ6bSc3wA29=8mooJDLMJkj9YQ=wj0A@mail.gmail.com>
 <CADnq5_NXFZPA_z6413FDgr8WRObhCB+HdkHE5P=PAAMV4FiWiA@mail.gmail.com>
 <20dffd4d-fa54-5bc3-c13b-f8ffbf0fb593@arm.com>
 <599edb94-8294-c4c5-ff7f-84c7072af3dd@gmail.com>
 <546bf682-565f-8384-ec80-201ce1c747f4@arm.com>
 <8afb06c4-7601-d0d7-feae-ee5abc9c3641@amd.com>
 <CAMdYzYqH57HuqMMydMtQw2Ep2A_Qhjg3N_gTw6GuO6Kuxd9chQ@mail.gmail.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <CAMdYzYqH57HuqMMydMtQw2Ep2A_Qhjg3N_gTw6GuO6Kuxd9chQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0025.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1c::23) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2a1d394b-06d6-44ba-39ac-08da07f69fee
X-MS-TrafficTypeDiagnostic: DM4PR12MB5391:EE_
X-Microsoft-Antispam-PRVS: <DM4PR12MB5391FF147F77C5562F7625E583129@DM4PR12MB5391.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 18yJxgXcgARJhZ9dgosN1Hmc2tKkHMiy3gINWHXCWnMlbOMPRx0UJ2+hlA7qbFX1/U4XgXS6W9Nf6rD/XpupxmpP7Ke+Tf3jqGDKXlH7gJK+q2ekIWZiqYDHQ5G3qmlvb/EZ6vp+kLpM55zIBpPMV2AC/f+sl8IwY6iBuWWpnpaoxHRU6hemmEBfPNDmc70d9DlKYkan9VBWtjGfnC/MsTtJ37Te+XY7n4hIO/CZyp9LcwtDyiNhjUYS+B1UZVG893JZwRuzXEX5Wc814z9pReUUSuhHlfDJR9yaWITBvjpVS4hSOhngAZ8ITA5ZSD0rgpx7AL1S+zOaybjmLyg2ZFcWSmUPIYohpx4q3n+RbRZ0E7hMCaHA/7Dhj4k22Ji+l9r8h9987JW0a9JNvtPoU9gC7cNc4XjJdTYNwvxeDRhpwud4vJ9CD4rzK6ALkPhHpSNOaJcNme1ZOJSmQydz2u7oeuK5kzXPLSxVt9DSl2xvQk4M9MIWSo1IoO+zPwX4lJrVdJJBwUthvea/T3t9/O8QdgH5dR/Tylw4ujTIHKEzoNd3PqcWR3HxBgkvpvMemL0xMqs1xYFRc9sCPF+Kp5qkkSoMOdZhBZw9tp1ShG6AyixLk1+U7ob5F3fxTAQgszAVmR+v3p8n1hYh3RZ0OH0mY6NiD0qNatMRVi38no3EjeR7MYJLHf/XdUo8ujYnpBgjAkdbnvpKCLcgKzSRA+CpxCk4gqCzrJDNUzLIkQozQsHPI6QvfBZnb0k6lBcsdcTFEZMbSBsgex+Z5fVajrqZ5+BemD6bPeZdTknOXu81CTek4ztj0CEX0GAQw0j/lzprYsNbcCHnuOmnNCHL5nebigalJkUzDYfQ/wpxH1U=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(36756003)(6666004)(6506007)(6512007)(186003)(38100700002)(26005)(2616005)(53546011)(2906002)(66574015)(31686004)(8936002)(508600001)(110136005)(54906003)(66476007)(8676002)(66946007)(4326008)(5660300002)(66556008)(30864003)(316002)(86362001)(966005)(6486002)(83380400001)(45080400002)(31696002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Qi9jR0hiY1kwUDZCWWVsMVBjbXJvaVRucmtNNEhQU24rTlM0MVV6NXl3RzU1?=
 =?utf-8?B?Z0thb2xrLzlJVVRWNFc3YnRPdU81cTA3RGZFOHpxNXVtejA1VG82aEV2ajZs?=
 =?utf-8?B?aU5DK1Z5WHhxYjBydkhhWmV2WDI2enZyQzNsQlBMbUZjQ0x2RmVXaW5YT0dk?=
 =?utf-8?B?b0RtOWtvSnZQN21FSmlrNUNpb3NmNmFBeStJRERHdFNnUEJVQkJWOE5IaVJY?=
 =?utf-8?B?ZnYza2FERERCRU1jd3FvRDVBNHN2Y05EanhoZjlLR2VGUDZWa3dReGZYSnFK?=
 =?utf-8?B?V1dRU1FZeWFNcm93MWtRejFkeGpVNTdGelRaMmpMMnp6OGZmSnVndHM4ekdI?=
 =?utf-8?B?T1cvSUdDclFuTEtpK2x2VEFNeTFOY00yVGZJWkIxeWk3Q3FGTThZTkxFL0g4?=
 =?utf-8?B?K2tJUXVrS1VwTmRweU5xTHZ4Z3RRaHdrL2RBa0FBS1k1M1lNYkd2NDVic1Nj?=
 =?utf-8?B?VGFlWU1KRG1ESHk1MitoWWVKSWV5VnkzWkd5YzAwZmorMXZRN1VGSnFOK2dh?=
 =?utf-8?B?TXp3Y2VkQTVhdUxYb1ZOclAzUVR2MG5mYkx3c0laVHFFL2pIQTY3OGY5NDB6?=
 =?utf-8?B?UkFlZnlzRm9Qam83L0JYZEdJSnpLZEg4d1JOUkprTWtmWkNESHhCcTY1TEUv?=
 =?utf-8?B?d1lQVUdiWlZGY1JKUWpOaWMrZDhKK2NWUEt1YWdOUUJ1c1d1WXJIa3ppRnNK?=
 =?utf-8?B?eXExSkdhSmlTQ1dOTWhQYzI2dFlERjJHWU9mYnZJY2lnNS8rRFZ1WlZma2RT?=
 =?utf-8?B?VUgydzJ4blNJR2RDTVhiQWpma0JmWVZtTEpON1B1c3dhd0lWNExiQXNwRU5x?=
 =?utf-8?B?bFhUMXZTZjNubDY0Nzc3eVhFR1Vuc2pvQVdSZk56ZXFvL2I2c2JCdm1zK0Zs?=
 =?utf-8?B?TW5Ib3BVcnRHa0pmRElmZXdFdmhSUHBLU2wzWDB1WmdQNUNPZ2M3NmYrVW5B?=
 =?utf-8?B?Vk5LaExUa0JaSVFEMkExNjQrWk9waEZ5Vkt2c1g4bjU3SHljcCt5V2w3MWUv?=
 =?utf-8?B?K0o1RTEvRTV2ZlZlU054eE5ZVHJrNGFtdG16Umtub21WbjdObWpWeXhVVldD?=
 =?utf-8?B?c0RYQTFvejdCQzBxdzZSVVdyWjk0NmRxNGhjRzQ3cHVCeUljSVVGbmhsWHBO?=
 =?utf-8?B?ckFUaTgrcjdQeGtrNmc0VWZFWGR1V2ROb3BCemN6RkJWTHQ3a0hXY3o1N3Nv?=
 =?utf-8?B?SkFmaisxOUoyRUVwNU5CM2N0OTBDN1NFaWp5MWZ1eDBBdFlZQ2pqMXlvRXFO?=
 =?utf-8?B?cExEWHY4dDkzWENBaTZjVzNCcXRYRW9ranpQdmltb0o4YjUzaFVOQmZzeita?=
 =?utf-8?B?UDJZWUUzcW5lWlJTQUtsWXh3UGh2OFdUQ2Z1RC9tQ0srTHpWNUptWm9ZR1pB?=
 =?utf-8?B?ZEt1U053SCtMV2FENDlpRG83YlgvTTFMaUhvNzRlV2hFd0FTbmpHelJTL0hj?=
 =?utf-8?B?MGw5ZU9vaW50cDExaEl4aWhvVEZXUzBWVGdTbDd6TnlYSGUvRDJGdEw4QTFh?=
 =?utf-8?B?NWlCWTkyWFdaNXJrMFRGSWc2OG85Y2gvMThNUnltQW1VOHdrTmFNWndNOXdM?=
 =?utf-8?B?WnJyemhVSFVtZE5ia2ZGZTdoWU1NVDY5Q2lZZC9ySFRQMWR1ZVc4ME5GNFVv?=
 =?utf-8?B?amxxYi82SjRUQXVjNTB5VzVzSjhQQ291SThWSFpoTTNZZTk1MkFGSU1nSnpi?=
 =?utf-8?B?RU1USmNlbkpGeXA3TlNZVG5zRUcyV2czUXRNQUtqNWdEVjV6Vy82WDNzUlBJ?=
 =?utf-8?B?Rm43c0NUc3oxWHdSb1Zld0tFYlNoNUgzalppajhvSFg0TDJaQjB4UzlkQUQ4?=
 =?utf-8?B?dGlOeWFnK09NR0Frd1lKYTJZaVJvY1hRN2RNS2lVTVAvay9QanoySE5OYUxL?=
 =?utf-8?B?djNzM1BWbjV1dHI5MGJaWmRWVUk4b1Iycm44eGJla3BORkpxbmVXeDh3ZHBx?=
 =?utf-8?Q?67s2Eb7HHu8wwjN76gc8u3nyrw920EY9?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a1d394b-06d6-44ba-39ac-08da07f69fee
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2022 09:15:05.4916 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FQ3MNGa1/nYI9tY+DDKW7G7nOeNe3duepk7EsSBHrixf/iNJKVbSVP7cM83ZuOkQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5391
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
Cc: Alex Deucher <alexdeucher@gmail.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>, "Deucher,
 Alexander" <alexander.deucher@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hi Peter,

Am 17.03.22 um 01:14 schrieb Peter Geis:
> Good Evening,
>
> I apologize for raising this email chain from the dead, but there have
> been some developments that have introduced even more questions.
> I've looped the Rockchip mailing list into this too, as this affects
> rk356x, and likely the upcoming rk3588 if [1] is to be believed.
>
> TLDR for those not familiar: It seems the rk356x series (and possibly
> the rk3588) were built without any outer coherent cache.
> This means (unless Rockchip wants to clarify here) devices such as the
> ITS and PCIe cannot utilize cache snooping.

well, as far as I know that is a clear violation of the PCIe specification.

Coherent access to system memory is simply a must have.

> This is based on the results of the email chain [2].
>
> The new circumstances are as follows:
> The RPi CM4 Adventure Team as I've taken to calling them has been
> attempting to get a dGPU working with the very broken Broadcom
> controller in the RPi CM4.
> Recently they acquired a SoQuartz rk3566 module which is pin
> compatible with the CM4, and have taken to trying it out as well.
>
> This is how I got involved.
> It seems they found a trivial way to force the Radeon R600 driver to
> use Non-Cached memory for everything.

Yeah, you basically just force it into AGP mode :)

There is just absolutely no guarantee that this works reliable.

> This single line change, combined with using memset_io instead of
> memset, allows the ring tests to pass and the card probes successfully
> (minus the DMA limitations of the rk356x due to the 32 bit
> interconnect).
> I discovered using this method that we start having unaligned io
> memory access faults (bus errors) when running glmark2-drm (running
> glmark2 directly was impossible, as both X and Wayland crashed too
> early).
> I traced this to using what I thought at the time was an unsafe memcpy
> in the mesa stack.
> Rewriting this function to force aligned writes solved the problem and
> allows glmark2-drm to run to completion.
> With some extensive debugging, I found about half a dozen memcpy
> functions in mesa that if forced to be aligned would allow Wayland to
> start, but with hilarious display corruption (see [3]. [4]).
> The CM4 team is convinced this is an issue with memcpy in glibc, but
> I'm not convinced it's that simple.

Yes exactly that.

Both OpenGL and Vulkan allow the application to mmap() device memory and 
do any memory access they want with that.

This means that changing memcpy is just a futile effort, it's still 
possible for the application to make an unaligned memory access and that 
is perfectly valid.

> On my two hour drive in to work this morning, I got to thinking.
> If this was an memcpy fault, this would be universally broken on arm64
> which is obviously not the case.
> So I started thinking, what is different here than with systems known to work:
> 1. No IOMMU for the PCIe controller.
> 2. The Outer Cache Issue.

Oh, very good point. I would be interested in that as answer as well.

Regards,
Christian.

>
> Robin:
> My questions for you, since you're the smartest person I know about
> arm64 memory management:
> Could cache snooping permit unaligned accesses to IO to be safe?
> Or
> Is it the lack of an IOMMU that's causing the alignment faults to become fatal?
> Or
> Am I insane here?
>
> Rockchip:
> Please update on the status for the Outer Cache errata for ITS services.
> Please provide an answer to the errata of the PCIe controller, in
> regard to cache snooping and buffering, for both the rk356x and the
> upcoming rk3588.
>
> [1] https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgithub.com%2FJeffyCN%2Fmirrors%2Fcommit%2F0b985f29304dcb9d644174edacb67298e8049d4f&amp;data=04%7C01%7Cchristian.koenig%40amd.com%7C4ae2dfa3e8ec4a765f8a08da07ab1cb2%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637830728762044450%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=ZL3jA2VrnynWbUdFG6naaqrZqcnKRq338n%2Bj50DRa74%3D&amp;reserved=0
> [2] https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flore.kernel.org%2Flkml%2F871rbdt4tu.wl-maz%40kernel.org%2FT%2F&amp;data=04%7C01%7Cchristian.koenig%40amd.com%7C4ae2dfa3e8ec4a765f8a08da07ab1cb2%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637830728762044450%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=QZy%2Bt%2Fus5f3yxwrHmXpzerXngPpKp3i9ZsF1UJ%2BHvlU%3D&amp;reserved=0
> [3] https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fcdn.discordapp.com%2Fattachments%2F926487797844541510%2F953414755970850816%2Funknown.png&amp;data=04%7C01%7Cchristian.koenig%40amd.com%7C4ae2dfa3e8ec4a765f8a08da07ab1cb2%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637830728762044450%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=c29bc87hxyIvnsBK3Fo7FbF7RwJcFr%2FjgBrLIiBb%2FyY%3D&amp;reserved=0
> [4] https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fcdn.discordapp.com%2Fattachments%2F926487797844541510%2F953424952042852422%2Funknown.png&amp;data=04%7C01%7Cchristian.koenig%40amd.com%7C4ae2dfa3e8ec4a765f8a08da07ab1cb2%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637830728762044450%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=fwygTk%2BDzdla67rdAYb44vlivlby9lFwtcgjLfJEH4A%3D&amp;reserved=0
>
> Thank you everyone for your time.
>
> Very Respectfully,
> Peter Geis
>
> On Wed, May 26, 2021 at 7:21 AM Christian König
> <christian.koenig@amd.com> wrote:
>> Hi Robin,
>>
>> Am 26.05.21 um 12:59 schrieb Robin Murphy:
>>> On 2021-05-26 10:42, Christian König wrote:
>>>> Hi Robin,
>>>>
>>>> Am 25.05.21 um 22:09 schrieb Robin Murphy:
>>>>> On 2021-05-25 14:05, Alex Deucher wrote:
>>>>>> On Tue, May 25, 2021 at 8:56 AM Peter Geis <pgwipeout@gmail.com>
>>>>>> wrote:
>>>>>>> On Tue, May 25, 2021 at 8:47 AM Alex Deucher
>>>>>>> <alexdeucher@gmail.com> wrote:
>>>>>>>> On Tue, May 25, 2021 at 8:42 AM Peter Geis <pgwipeout@gmail.com>
>>>>>>>> wrote:
>>>>>>>>> Good Evening,
>>>>>>>>>
>>>>>>>>> I am stress testing the pcie controller on the rk3566-quartz64
>>>>>>>>> prototype SBC.
>>>>>>>>> This device has 1GB available at <0x3 0x00000000> for the PCIe
>>>>>>>>> controller, which makes a dGPU theoretically possible.
>>>>>>>>> While attempting to light off a HD7570 card I manage to get a
>>>>>>>>> modeset
>>>>>>>>> console, but ring0 test fails and disables acceleration.
>>>>>>>>>
>>>>>>>>> Note, we do not have UEFI, so all PCIe setup is from the Linux
>>>>>>>>> kernel.
>>>>>>>>> Any insight you can provide would be much appreciated.
>>>>>>>> Does your platform support PCIe cache coherency with the CPU?  I.e.,
>>>>>>>> does the CPU allow cache snoops from PCIe devices?  That is required
>>>>>>>> for the driver to operate.
>>>>>>> Ah, most likely not.
>>>>>>> This issue has come up already as the GIC isn't permitted to snoop on
>>>>>>> the CPUs, so I doubt the PCIe controller can either.
>>>>>>>
>>>>>>> Is there no way to work around this or is it dead in the water?
>>>>>> It's required by the pcie spec.  You could potentially work around it
>>>>>> if you can allocate uncached memory for DMA, but I don't think that is
>>>>>> possible currently.  Ideally we'd figure out some way to detect if a
>>>>>> particular platform supports cache snooping or not as well.
>>>>> There's device_get_dma_attr(), although I don't think it will work
>>>>> currently for PCI devices without an OF or ACPI node - we could
>>>>> perhaps do with a PCI-specific wrapper which can walk up and defer
>>>>> to the host bridge's firmware description as necessary.
>>>>>
>>>>> The common DMA ops *do* correctly keep track of per-device coherency
>>>>> internally, but drivers aren't supposed to be poking at that
>>>>> information directly.
>>>> That sounds like you underestimate the problem. ARM has unfortunately
>>>> made the coherency for PCI an optional IP.
>>> Sorry to be that guy, but I'm involved a lot internally with our
>>> system IP and interconnect, and I probably understand the situation
>>> better than 99% of the community ;)
>> I need to apologize, didn't realized who was answering :)
>>
>> It just sounded to me that you wanted to suggest to the end user that
>> this is fixable in software and I really wanted to avoid even more
>> customers coming around asking how to do this.
>>
>>> For the record, the SBSA specification (the closet thing we have to a
>>> "system architecture") does require that PCIe is integrated in an
>>> I/O-coherent manner, but we don't have any control over what people do
>>> in embedded applications (note that we don't make PCIe IP at all, and
>>> there is plenty of 3rd-party interconnect IP).
>> So basically it is not the fault of the ARM IP-core, but people are just
>> stitching together PCIe interconnect IP with a core where it is not
>> supposed to be used with.
>>
>> Do I get that correctly? That's an interesting puzzle piece in the picture.
>>
>>>> So we are talking about a hardware limitation which potentially can't
>>>> be fixed without replacing the hardware.
>>> You expressed interest in "some way to detect if a particular platform
>>> supports cache snooping or not", by which I assumed you meant a
>>> software method for the amdgpu/radeon drivers to call, rather than,
>>> say, a website that driver maintainers can look up SoC names on. I'm
>>> saying that that API already exists (just may need a bit more work).
>>> Note that it is emphatically not a platform-level thing since
>>> coherency can and does vary per device within a system.
>> Well, I think this is not something an individual driver should mess
>> with. What the driver should do is just express that it needs coherent
>> access to all of system memory and if that is not possible fail to load
>> with a warning why it is not possible.
>>
>>> I wasn't suggesting that Linux could somehow make coherency magically
>>> work when the signals don't physically exist in the interconnect - I
>>> was assuming you'd merely want to do something like throw a big
>>> warning and taint the kernel to help triage bug reports. Some drivers
>>> like ahci_qoriq and panfrost simply need to know so they can program
>>> their device to emit the appropriate memory attributes either way, and
>>> rely on the DMA API to hide the rest of the difference, but if you
>>> want to treat non-coherent use as unsupported because it would require
>>> too invasive changes that's fine by me.
>> Yes exactly that please. I mean not sure how panfrost is doing it, but
>> at least the Vulkan userspace API specification requires devices to have
>> coherent access to system memory.
>>
>> So even if I would want to do this it is simply not possible because the
>> application doesn't tell the driver which memory is accessed by the
>> device and which by the CPU.
>>
>> Christian.
>>
>>> Robin.

