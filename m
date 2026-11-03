Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E476F606D820
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Nov 2026 14:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=proton.me header.i=@proton.me header.a=rsa-sha256 header.s=protonmail2 header.b=y3g8pQ/p
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 30C0410F5BB;
	Tue,  3 Nov 2026 14:03:05 +0000 (UTC)
Received: from mail-4327.protonmail.ch (mail-4327.protonmail.ch [185.70.43.27])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8543810E7E8
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Nov 2026 11:07:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
 s=protonmail2; t=1793703013; x=1793962213;
 bh=bk9xmJ/CHw/ZUJ1Dey5/G9hjtl0NWofMk3bhkkdRGjU=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=y3g8pQ/puW0qgWRXimT7OcGCvZd+3zkK0npqEsM5FittYXahBdL6zMdEHG8b2ArBz
 rcbP4L/EC3uwax3TrNP1orD8zXJ/smO1atsA9+udSsV4CWDtMrWRp8hz0xJeJ1Nd1b
 9hjcJOc5EkC6mdc1oj6EczVDpD+o/J/76+KLpn6CgV7p++2HZXeTKh90FocZf7pLIk
 ONnkb4FXZ31l8O/bHXnvr/kBLIfbgqqA2gWA5iZSE7o8LDVSx1bs25a4mNnevibuMm
 Cyra+FsZU/Zn/k+DCVn2/EJbVysJSXDVkHHMqTeWAgjWLyDIS7ZAm/FxYiwWcluXbX
 5m0tv+LDRqa2Q==
Date: Tue, 03 Nov 2026 10:50:09 +0000
To: =?utf-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
From: aarthex <aarthex@proton.me>
Cc: SRINIVASAN SHANMUGAM <srinivasan.shanmugam@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "Felix.Kuehling@amd.com" <Felix.Kuehling@amd.com>,
 "alexander.deucher@amd.com" <alexander.deucher@amd.com>
Subject: Re: [RFC] amdkfd: Native integration with DRM fences/syncobjs
Message-ID: <vHxZms6rrYjnunJpZ8MsMZX6IsaTnKi2Y0ijzijoOMf4Bj-URZ8laaOhNpX-rmrRXt1Y5cVGKHaFsVwXTGh5TSNs1a9odNPfQ8KeuQOE-KY=@proton.me>
In-Reply-To: <10dd384d-12ec-443c-8f1f-b21c524b10ae@amd.com>
References: <6LGhg_Yb_ppPcBcic7UenLy4cBVr66GyWswWm0xLqKQZc04YxYzLkPxbPNQj_2LvHWaG-hSzXaFM2ERSYhJbEOEUYXVn_tWBUYfMP_KzQAI=@proton.me>
 <ba707a14-2802-4a35-a727-c22e749c136d@amd.com>
 <5e8e8c22-d8c7-4c76-8a88-2a69f920245d@amd.com>
 <9PPY12T_RVxa1D24UhLqTocmtEOshesvldOUE5OiV3YlaMIUd0DtVNHxD2Ac6YyHHuGwS2VIhLz2LSsb0CH8_DATSblqKlSYg3ldElY2HPo=@proton.me>
 <10dd384d-12ec-443c-8f1f-b21c524b10ae@amd.com>
Feedback-ID: 83802568:user:proton
X-Pm-Message-ID: 6fa7fca8ea22ddc27b902e2a581f037c8f69b9d1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Tue, 03 Nov 2026 14:03:04 +0000
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
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Thank you so much for the explaination, that clarifies things greatly!


Sent from Proton Mail for Android.

-------- Original Message --------
On Tuesday, 11/03/26 at 15:10 Christian K=C3=B6nig <christian.koenig@amd.co=
m> wrote:
Hi Aarthex,

On 11/3/26 09:44, aarthex wrote:
> Hey Christian and Srinivasan,
>
> Thank you for your response. This eventfd solution seems quite promising!
>
> As much as I don't want to take too much of your time, could you refer an=
y discussions on why fences/syncobjs are fundamentally incompatible with am=
dkfd and such?

See the documentation here https://www.kernel.org/doc/html/next/driver-api/=
dma-buf.html#indefinite-dma-fences

"Infinite fences from compute workloads are allowed to depend on DMA fences=
, but not the other way around."

In other words ROCm submissions can wait for dma_fences inside sync_files o=
r syncobj (which we partially already support), but you can't signal a dma_=
fence from a ROCm submission / KFD queue.

Technical background is that in compute frameworks like ROCm or CUDA you ha=
ve features like long running submissions, page faults, busy waits on CPU a=
ctivity etc.... all of that is not allowed when you want to signal a dma_fe=
nce or otherwise you sooner or later run into deadlocks with the core resou=
rce management.
> I was under the impression piping GPU events into eventfd is not too diss=
imilar from piping it into syncobjs and such.

Well what could be done is to signal a syncobj from an eventfd inside the k=
ernel instead of userspace, we already support that the other way around.

But the problem here is that signaling inside the kernel it is not much bet=
ter than creating an userspace thread, blocking for the eventfd to signal a=
nd then manually signal the syncobj.

You only save a mostly negligible kernel/userspace/kernel transition for th=
e cost of much more complexity and resource handling inside the kernel and =
that is not really feasible.

> I will admit i am not very knowledgeable about amdgpu's internals.

Well that is not amdgpu related at all, it's just the general dma_fence rul=
es.

And people get that wrong all the time and are then surprised when stuff is=
 rejected during upstreaming or falls apart as soon as customers start to u=
se it in a production environment.

We unfortunately had quite a number of such things in the past.

Regards,
Christian.


> -------- Original Message --------
> On Tuesday, 11/03/26 at 08:22 SRINIVASAN SHANMUGAM <srinivasan.shanmugam@=
amd.com> wrote:
>
> On 11/2/2026 6:20 PM, Christian K=C3=B6nig wrote:
>> Hi,
>>
>> On 10/31/26 05:28, aarthex wrote:
>>> Hello people,
>>>
>>> Currently, amdkfd provides no native way to integrate itself into a wid=
er event loop (like epoll or Wayland explicit sync) using standard DRM fenc=
es or syncobjs.
>> Yeah that is completely intentional.
>>
>> Background is that the semantics of dma_fences/DRM syncobjs are incompat=
ible with ROCm or more generally any compute stack, Intel (XE) and Nvidia h=
ave the same limitation.
>>
>>> There are some workarounds, like creating a syncobj and then signaling =
it from the CPU side after the GPU is done, either via polling or hardware =
interrupts.
>>>
>>> But none of these are very tasteful, especially for something that is i=
deally the driver's job.
>>>
>>> I opened a feature request for this on GitLab a bit ago here: https://g=
itlab.freedesktop.org/drm/amd/-/issues/6013
>>>
>>>
>>> Before I work on implementing it, it would be nice to know if the team =
was open to accepting this, or if anyone had any thoughts/architectural poi=
nters to leave.
>> It's really good that you asked before starting anything because stuff l=
ike that is completely impossible to get right for dma_fences and DRM synco=
bs.
>>
>> AMD and Intel are working together on a eventfd based approach for their=
 compute stack to replace AMD specific KFD events. If you are interested Sr=
ini can point you to the right patches/components on the mailing list and i=
n code.
>
> Hi Christian,
>
> Thanks for the context.
>
> For reference, we've previously posted prototype work around
> eventfd-based compute event delivery, WAIT_EVENT infrastructure,
>
> - EVENTFD infrastructure:
>    https://patchwork.freedesktop.org/series/164618/
>
> - GPU event producers wired into EVENTFD notifications:
>    https://patchwork.freedesktop.org/series/170501/
>
> - WAIT_EVENT metadata retrieval and consumption:
>    https://patchwork.freedesktop.org/series/164813/
>
> The goal of that work was to explore a generic eventfd-based mechanism
> for queue completion, reset, and debugger-visible compute events from
> the render-node side.
>
> Regards,
> Srini
>
>


