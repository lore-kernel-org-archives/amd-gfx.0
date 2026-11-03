Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DD44606A328
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Nov 2026 14:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=proton.me header.i=@proton.me header.a=rsa-sha256 header.s=protonmail2 header.b=w+ul3qfp
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0D6FA10F5C2;
	Tue,  3 Nov 2026 14:03:06 +0000 (UTC)
Received: from mail-244103.protonmail.ch (mail-244103.protonmail.ch
 [109.224.244.103])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4A04710E7A1
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Nov 2026 08:44:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
 s=protonmail2; t=1793695486; x=1793954686;
 bh=hsH60NpL7rbtfmSRhempahLMCge8MMXKbxjh+zV+LwI=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=w+ul3qfpqk/BR3iBEwBMYp6OESmuOvZ1IPcJ0D3Qi4s01h55BwS/L06gB0b/mgmHj
 3NZPzjZL2gA0D7vKGlYt+TiAP8UeSVFV4gqxvJH9JcVpbPliCbZEJ+ctROa0WY7Icc
 Y7VK1xLOnVR2tvF2iKWeMNCkBwQ5EhEd+ckzi1DrG1Olej5ZssyRbdcRO3jdZKvcAn
 FVoR3tCLw2PUZcSG+gnHACQ+wNSIWTrpYJJTrCYVfyGq+7K0007/4d5Kxs5CtmMNIF
 ArSmhdDIBCy1gxlKH7qBXy36zaOCtaIHuMFzsg7ezmcpw/2sX7jeyjt9/AiLFIP/SY
 oJQGCGEAU67eQ==
Date: Tue, 03 Nov 2026 08:44:42 +0000
To: SRINIVASAN SHANMUGAM <srinivasan.shanmugam@amd.com>
From: aarthex <aarthex@proton.me>
Cc: =?utf-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "Felix.Kuehling@amd.com" <Felix.Kuehling@amd.com>,
 "alexander.deucher@amd.com" <alexander.deucher@amd.com>
Subject: Re: [RFC] amdkfd: Native integration with DRM fences/syncobjs
Message-ID: <9PPY12T_RVxa1D24UhLqTocmtEOshesvldOUE5OiV3YlaMIUd0DtVNHxD2Ac6YyHHuGwS2VIhLz2LSsb0CH8_DATSblqKlSYg3ldElY2HPo=@proton.me>
In-Reply-To: <5e8e8c22-d8c7-4c76-8a88-2a69f920245d@amd.com>
References: <6LGhg_Yb_ppPcBcic7UenLy4cBVr66GyWswWm0xLqKQZc04YxYzLkPxbPNQj_2LvHWaG-hSzXaFM2ERSYhJbEOEUYXVn_tWBUYfMP_KzQAI=@proton.me>
 <ba707a14-2802-4a35-a727-c22e749c136d@amd.com>
 <5e8e8c22-d8c7-4c76-8a88-2a69f920245d@amd.com>
Feedback-ID: 83802568:user:proton
X-Pm-Message-ID: 69a3ee832d1649a4afbd86ee5622ae2ebb7d1f4a
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

Hey Christian and Srinivasan,

Thank you for your response. This eventfd solution seems quite promising!

As much as I don't want to take too much of your time, could you refer any =
discussions on why fences/syncobjs are fundamentally incompatible with amdk=
fd and such?

I was under the impression piping GPU events into eventfd is not too dissim=
ilar from piping it into syncobjs and such.

I will admit i am not very knowledgeable about amdgpu's internals.




-------- Original Message --------
On Tuesday, 11/03/26 at 08:22 SRINIVASAN SHANMUGAM <srinivasan.shanmugam@am=
d.com> wrote:

On 11/2/2026 6:20 PM, Christian K=C3=B6nig wrote:
> Hi,
>
> On 10/31/26 05:28, aarthex wrote:
>> Hello people,
>>
>> Currently, amdkfd provides no native way to integrate itself into a wide=
r event loop (like epoll or Wayland explicit sync) using standard DRM fence=
s or syncobjs.
> Yeah that is completely intentional.
>
> Background is that the semantics of dma_fences/DRM syncobjs are incompati=
ble with ROCm or more generally any compute stack, Intel (XE) and Nvidia ha=
ve the same limitation.
>
>> There are some workarounds, like creating a syncobj and then signaling i=
t from the CPU side after the GPU is done, either via polling or hardware i=
nterrupts.
>>
>> But none of these are very tasteful, especially for something that is id=
eally the driver's job.
>>
>> I opened a feature request for this on GitLab a bit ago here: https://gi=
tlab.freedesktop.org/drm/amd/-/issues/6013
>>
>>
>> Before I work on implementing it, it would be nice to know if the team w=
as open to accepting this, or if anyone had any thoughts/architectural poin=
ters to leave.
> It's really good that you asked before starting anything because stuff li=
ke that is completely impossible to get right for dma_fences and DRM syncob=
s.
>
> AMD and Intel are working together on a eventfd based approach for their =
compute stack to replace AMD specific KFD events. If you are interested Sri=
ni can point you to the right patches/components on the mailing list and in=
 code.

Hi Christian,

Thanks for the context.

For reference, we've previously posted prototype work around
eventfd-based compute event delivery, WAIT_EVENT infrastructure,

- EVENTFD infrastructure:
 =C2=A0 https://patchwork.freedesktop.org/series/164618/

- GPU event producers wired into EVENTFD notifications:
 =C2=A0 https://patchwork.freedesktop.org/series/170501/

- WAIT_EVENT metadata retrieval and consumption:
 =C2=A0 https://patchwork.freedesktop.org/series/164813/

The goal of that work was to explore a generic eventfd-based mechanism
for queue completion, reset, and debugger-visible compute events from
the render-node side.

Regards,
Srini


