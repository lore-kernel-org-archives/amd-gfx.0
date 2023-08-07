Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DB7EC00528
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Aug 2023 16:04:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9F44B10E1FE;
	Mon,  7 Aug 2023 16:04:24 +0000 (UTC)
Received: from ms7.webland.ch (ms7.webland.ch [92.43.217.107])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 77B4010E1FE
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Aug 2023 16:04:21 +0000 (UTC)
Received: from [192.168.1.137] ([213.144.156.170])
 by ms7.webland.ch (12.3.0 build 2 x64) with ASMTP (SSL) id
 01202308071804163083; Mon, 07 Aug 2023 18:04:16 +0200
Message-ID: <84c6f537-ddd6-6a8b-a574-723b8eec231a@daenzer.net>
Date: Mon, 7 Aug 2023 18:04:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.1
Content-Language: en-CA
To: Alex Deucher <alexdeucher@gmail.com>
References: <20230510212333.2071373-28-alexander.deucher@amd.com>
 <647beed4-9d0b-e351-6f66-756f73eb73a5@daenzer.net>
 <1da36164-7cd9-c2a3-a42f-558942257727@daenzer.net>
 <f8c83922-f3d4-34d8-6ae1-3112b52bcdf3@amd.com>
 <d515206e-ab58-a8c4-ef3a-e93fc61ba37d@daenzer.net>
 <0a99c609-c5c2-25fc-4ceb-52a0b4a49f29@amd.com>
 <219fc41b-13f2-8517-1720-eb92fe02083c@amd.com>
 <DM4PR12MB5152DC2873CB6726977F45C9E301A@DM4PR12MB5152.namprd12.prod.outlook.com>
 <DM4PR12MB5152E173B970C3974F071E76E306A@DM4PR12MB5152.namprd12.prod.outlook.com>
 <063f67cc-241d-f92f-1c6b-1ec20795690a@daenzer.net>
 <493a9ab5-1665-0188-8bab-69086f7d94a6@daenzer.net>
 <CADnq5_N-5MNq1YjU1w5AgsqFVTc0_nJ+XWgkifhRAzKKiftHZg@mail.gmail.com>
 <e654d536-54c0-258d-c80b-129f95c048cc@daenzer.net>
 <CADnq5_Np7QqvdER3+ayJQB1_7DvL5ddR447q_x1Yp5Ku8yOsTg@mail.gmail.com>
From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel@daenzer.net>
Subject: Re: [PATCH 28/29] drm/amdkfd: Refactor migrate init to support
 partition switch
In-Reply-To: <CADnq5_Np7QqvdER3+ayJQB1_7DvL5ddR447q_x1Yp5Ku8yOsTg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CTCH: RefID="str=0001.0A782F21.64D11602.000A,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0";
 Spam="Unknown"; VOD="Unknown"
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Yang,
 Philip" <Philip.Yang@amd.com>, "Zhang, Jesse\(Jie\)" <Jesse.Zhang@amd.com>,
 "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 7/28/23 19:20, Alex Deucher wrote:
> On Fri, Jul 28, 2023 at 1:19 PM Michel Dänzer <michel@daenzer.net> wrote:
>> On 7/28/23 18:43, Alex Deucher wrote:
>>> On Fri, Jul 28, 2023 at 10:25 AM Michel Dänzer <michel@daenzer.net> wrote:
>>>> On 7/28/23 11:30, Michel Dänzer wrote:
>>>>> On 7/28/23 03:38, Zhang, Jesse(Jie) wrote:
>>>>>>
>>>>>> Could you try the patch again ?  That work for me.
>>>>>>
>>>>>> https://patchwork.freedesktop.org/patch/549605/ <https://patchwork.freedesktop.org/patch/549605/>
>>>>>
>>>>> This patch fixes the symptoms described in https://gitlab.freedesktop.org/drm/amd/-/issues/2659 for me as well.
>>>>>
>>>>> However, it does not fix the IOMMU page faults[0] or the IB test failures on the compute rings. Should I try amdgpu.ignore_crat=1 for these symptoms as well?
>>>>
>>>> I tried ignore_crat=1, it avoids the remaining symptoms as well.
>>>
>>> The first 3 patches of this set may also fix it:
>>> https://patchwork.freedesktop.org/series/121538/
>>
>> They do fix all symptoms I'm seeing.
>>
>> Is this a feasible solution for the final 6.5 release?
> 
> I think the first3 are.

Even with Felix's feedback on patch 2?

If so, will you merge these for 6.5 final?

Or should we revert 84b4dd3f84de ("drm/amdkfd: Refactor migrate init to support partition switch") for that?


-- 
Earthling Michel Dänzer            |                  https://redhat.com
Libre software enthusiast          |         Mesa and Xwayland developer

