Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 211B3C43217
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Mar 2022 13:28:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6B3B510E938;
	Fri, 18 Mar 2022 13:28:24 +0000 (UTC)
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com
 [IPv6:2607:f8b0:4864:20::1134])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EF10D10E09B
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Mar 2022 11:25:09 +0000 (UTC)
Received: by mail-yw1-x1134.google.com with SMTP id
 00721157ae682-2e5ad7166f1so75156527b3.12
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Mar 2022 04:25:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=n4Zv8HscmPAqEtpJpjMtw+sPyiB6Cmp1Ol+6ywaYjm0=;
 b=NV8+n4Ep6hIWodm2mkqTTP93FyG6YRr5zUeD7uq0XsC+VhaRM9ZzLUCMn/c3fgdEk1
 HSPr3A5tsytpc+JuLoj6KbrByYQ76UrLeeN/9h/vT3XFiQnm4aklYGnIXgUeBmSoLNJX
 Bn7cAz1Xg/g/PRabs200R9ws1s4YmM6Np1KWMx1EZFL1P/hWtlM/InFELwUAJCI3Epxq
 /9SUtKSggWpcaMQCTfRJR8OK/Velte2yG+keQ/cB1w6r+Q0lmyRHS0Cq6yi6NRmKCXAF
 C0zkzRRzsNt321HQ6PuyZzkJoHWw/tJhy4iWs8vf3InlBoIxUeqXuOG/6HzD7WdfZXRr
 NJBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=n4Zv8HscmPAqEtpJpjMtw+sPyiB6Cmp1Ol+6ywaYjm0=;
 b=MUrV6JgB/llTCazlQdNYGIYeVUsdDebwI8Ij94Zvr+EoyzjQqo05m4nWa8s2zAOEKO
 yLIfbIMZouGDR1pJtquHQqPTqvtM9/vEEYWbHvyapCmOtM49MLD7Yzvm4rCjQwuZvC7q
 MW08dFD/VhV8fBJisNIrXrCoSrLsl3fKhCsklXVh85yIfG9hZX/7ghU3QK90LJG02U3E
 rpyekVDSeSU5jLSh+xl2Phpyn6hbbjclXiBpyoOfn5xZzzfzpBXetT9PqZBmvsPE6ilr
 d9wKRhl5YPuY2hwWE/flponticcqpyufHdTeahLYuwUxcbKy1nD4hf6f90t1vfXBSWRv
 c9+A==
X-Gm-Message-State: AOAM5324TZYWb3gmuSPpKF0Hk8EJ0I0UPBLatoJRToO+Hw4YEnukyHWu
 PuJ6QoV3/xQk2f2cnwfVSDh7kQlNRttzLahLovY=
X-Google-Smtp-Source: ABdhPJxtY6zMwXB25UUEjlLouMPMxTrLE6a56LOed8GWDy0gCv19wUsoeK626sLPr9clVm39g+h9KS6EdafmGe217u8=
X-Received: by 2002:a05:690c:89:b0:2d7:fb7d:db7 with SMTP id
 be9-20020a05690c008900b002d7fb7d0db7mr11352578ywb.219.1647602708863; Fri, 18
 Mar 2022 04:25:08 -0700 (PDT)
MIME-Version: 1.0
References: <CAMdYzYptw9L=5SECtVkNZruTT-x57+03vj0A+5efvq8cESzLyQ@mail.gmail.com>
 <CADnq5_NXmRr_Q7JuWZxJAjmavVkvJjNcWayQ1x8LhfcX5CS0uA@mail.gmail.com>
 <CAMdYzYoamh-igvBbKaLSJ6bSc3wA29=8mooJDLMJkj9YQ=wj0A@mail.gmail.com>
 <CADnq5_NXFZPA_z6413FDgr8WRObhCB+HdkHE5P=PAAMV4FiWiA@mail.gmail.com>
 <20dffd4d-fa54-5bc3-c13b-f8ffbf0fb593@arm.com>
 <599edb94-8294-c4c5-ff7f-84c7072af3dd@gmail.com>
 <546bf682-565f-8384-ec80-201ce1c747f4@arm.com>
 <8afb06c4-7601-d0d7-feae-ee5abc9c3641@amd.com>
 <CAMdYzYqH57HuqMMydMtQw2Ep2A_Qhjg3N_gTw6GuO6Kuxd9chQ@mail.gmail.com>
 <ece56cf6-5ef2-6bd4-8e62-7828adca9844@rock-chips.com>
 <CAMdYzYoTz7rbs7pMDTcDzVPVaaP97BkUeMOM0Ab5FVSqOQRgxg@mail.gmail.com>
 <7652b236-238c-4e8a-f1c5-e3b7f7f71be6@rock-chips.com>
 <cd95435c-7ad5-6126-26f6-76a62f6f85fb@amd.com>
In-Reply-To: <cd95435c-7ad5-6126-26f6-76a62f6f85fb@amd.com>
From: Peter Geis <pgwipeout@gmail.com>
Date: Fri, 18 Mar 2022 07:24:53 -0400
Message-ID: <CAMdYzYo0Qk9U+m8-NfYnJT8vvN=Q1wm6eNGnd-RKoMn-qQ+gXQ@mail.gmail.com>
Subject: Re: radeon ring 0 test failed on arm64
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Fri, 18 Mar 2022 13:28:22 +0000
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
Cc: Tao Huang <huangtao@rock-chips.com>,
 "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 Shawn Lin <shawn.lin@rock-chips.com>, Kever Yang <kever.yang@rock-chips.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>, "Deucher,
 Alexander" <alexander.deucher@amd.com>, Alex Deucher <alexdeucher@gmail.com>,
 Robin Murphy <robin.murphy@arm.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Fri, Mar 18, 2022 at 4:35 AM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
>
>
> Am 18.03.22 um 08:51 schrieb Kever Yang:
>
>
> On 2022/3/17 20:19, Peter Geis wrote:
>
> On Wed, Mar 16, 2022 at 11:08 PM Kever Yang <kever.yang@rock-chips.com> w=
rote:
>
> Hi Peter,
>
> On 2022/3/17 08:14, Peter Geis wrote:
>
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
>
> On my two hour drive in to work this morning, I got to thinking.
> If this was an memcpy fault, this would be universally broken on arm64
> which is obviously not the case.
> So I started thinking, what is different here than with systems known to =
work:
> 1. No IOMMU for the PCIe controller.
> 2. The Outer Cache Issue.
>
> Robin:
> My questions for you, since you're the smartest person I know about
> arm64 memory management:
> Could cache snooping permit unaligned accesses to IO to be safe?
> Or
> Is it the lack of an IOMMU that's causing the ali gnment faults to become=
 fatal?
> Or
> Am I insane here?
>
> Rockchip:
> Please update on the status for the Outer Cache errata for ITS services.
>
> Our SoC design team has double check with ARM GIC/ITS IP team for many
> times, and the GITS_CBASER
> of GIC600 IP does not support hardware bind or config to a fix value, so
> they insist this is an IP
> limitation instead of a SoC bug, software should take  care of it :(
> I will check again if we can provide errata for this issue.
>
> Thanks. This is necessary as the mbi-alias provides an imperfect
> implementation of the ITS and causes certain PCIe cards (eg x520 Intel
> 10G NIC) to misbehave.
>
> Please provide an answer to the errata of the PCIe controller, in
> regard to cache snooping and buffering, for both the rk356x and the
> upcoming rk3588.
>
>
> Sorry, what is this?
>
> Part of the ITS bug is it expects to be cache coherent with the CPU
> cluster by design.
> Due to the rk356x being implemented without an outer accessible cache,
> the ITS and other devices that require cache coherency (PCIe for
> example) crash in fun ways.
>
> Then this is still the ITS issue, not PCIe issue.
> PCIe is a peripheral bus controller like USB and other device, the driver=
 should maintain the "cache coherency" if there is any, and there is no req=
uirement for hardware cache coherency between PCIe and CPU.

Kever,

These issues are one and the same.
Certain hardware blocks *require* cache coherency as part of their design.
All of the *interesting* things PCIe can do stem from it.

When I saw you bumped the available window to the PCIe controller to
1GB I was really excited, because that meant we could finally support
devices that used these interesting features.
However, without cache coherency, having more than a 256MB window is a
waste, as any card that can take advantage of it *requires* coherency.
The same thing goes for a resizable BAR.
EP mode is the same, having the ability to connect one CPU to another
CPU over a PCIe bus loses the advantages when you don't have
coherency.
At that point, you might as well toss in a 2.5GB ethernet port and
just use that instead.

>
>
> Well then I suggest to re-read the PCIe specification.
>
> Cache coherency is defined as mandatory there. Non-cache coherency is an =
optional feature.
>
> See section 2.2.6.5 in the PCIe 2.0 specification for a good example.
>
> Regards,
> Christian.
>
>
> We didn't see any transfer error on rk356x PCIe till now, we can take a l=
ook if it's easy to reproduce.

It's easy to reproduce, just try to use any card that has a
significantly large enough BAR to warrant requiring coherency.
dGPUs are the most readily accessible device, but High Performance
Computing Acceleration devices and high power FPGAs also would work.
Was the resizable bar tested at all internally either?
Any current device that could use that requires coherency.
And like above, EP mode without coherency is a waste at best, and
unpleasant at worst.

Very Respectfully,
Peter

>
> Thanks,
> - Kever
>
>
> This means that rk356x cannot implement a specification compliant ITS or =
PCIe.
> >From the rk3588 source dump it appears it was produced without an
> outer accessible cache, which means if true it also will be unable to
> use any PCIe cards that implement cache coherency as part of their
> design.
>
>
> Thanks,
> - Kever
>
> [1] https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fg=
ithub.com%2FJeffyCN%2Fmirrors%2Fcommit%2F0b985f29304dcb9d644174edacb67298e8=
049d4f&amp;data=3D04%7C01%7Cchristian.koenig%40amd.com%7C8bdb8c3a6a2e4643bb=
fd08da08b42da4%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637831867224766=
930%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1=
haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=3DLcwZggIwIqjvzjDH2DUnIDwxsgk7WmhE9LK1=
3knx36E%3D&amp;reserved=3D0
> [2] https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fl=
ore.kernel.org%2Flkml%2F871rbdt4tu.wl-maz%40kernel.org%2FT%2F&amp;data=3D04=
%7C01%7Cchristian.koenig%40amd.com%7C8bdb8c3a6a2e4643bbfd08da08b42da4%7C3dd=
8961fe4884e608e11a82d994e183d%7C0%7C0%7C637831867224766930%7CUnknown%7CTWFp=
bGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%=
7C3000&amp;sdata=3DfXALLO1EnGi2s8pClt6aMrUlzqDy2KDO8wzpi033qtU%3D&amp;reser=
ved=3D0
> [3] https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fc=
dn.discordapp.com%2Fattachments%2F926487797844541510%2F953414755970850816%2=
Funknown.png&amp;data=3D04%7C01%7Cchristian.koenig%40amd.com%7C8bdb8c3a6a2e=
4643bbfd08da08b42da4%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637831867=
224766930%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBT=
iI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=3Dtx%2Bw9ayScUTftjWAFL0GY%2FADQs=
wxEJGRUhgxDw2TSzQ%3D&amp;reserved=3D0
> [4] https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fc=
dn.discordapp.com%2Fattachments%2F926487797844541510%2F953424952042852422%2=
Funknown.png&amp;data=3D04%7C01%7Cchristian.koenig%40amd.com%7C8bdb8c3a6a2e=
4643bbfd08da08b42da4%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637831867=
224766930%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBT=
iI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=3D8VXuZvQAhD%2FsQBJ6WEXe0YElD6wC=
I675oxqHesKhclY%3D&amp;reserved=3D0
>
> Thank you everyone for your time.
>
> Very Respectfully,
> Peter Geis
>
> On Wed, May 26, 2021 at 7:21 AM Christian K=C3=B6nig
> <christian.koenig@amd.com> wrote:
>
> Hi Robin,
>
> Am 26.05.21 um 12:59 schrieb Robin Murphy:
>
> On 2021-05-26 10:42, Christian K=C3=B6nig wrote:
>
> Hi Robin,
>
> Am 25.05.21 um 22:09 schrieb Robin Murphy:
>
> On 2021-05-25 14:05, Alex Deucher wrote:
>
> On Tue, May 25, 2021 at 8:56 AM Peter Geis <pgwipeout@gmail.com>
> wrote:
>
> On Tue, May 25, 2021 at 8:47 AM Alex Deucher
> <alexdeucher@gmail.com> wrote:
>
> On Tue, May 25, 2021 at 8:42 AM Peter Geis <pgwipeout@gmail.com>
> wrote:
>
> Good Evening,
>
> I am stress testing the pcie controller on the rk3566-quartz64
> prototype SBC.
> This device has 1GB available at <0x3 0x00000000> for the PCIe
> controller, which makes a dGPU theoretically possible.
> While attempting to light off a HD7570 card I manage to get a
> modeset
> console, but ring0 test fails and disables acceleration.
>
> Note, we do not have UEFI, so all PCIe setup is from the Linux
> kernel.
> Any insight you can provide would be much appreciated.
>
> Does your platform support PCIe cache coherency with the CPU?  I.e.,
> does the CPU allow cache snoops from PCIe devices?  That is required
> for the driver to operate.
>
> Ah, most likely not.
> This issue has come up already as the GIC isn't permitted to snoop on
> the CPUs, so I doubt the PCIe controller can either.
>
> Is there no way to work around this or is it dead in the water?
>
> It's required by the pcie spec.  You could potentially work around it
> if you can allocate uncached memory for DMA, but I don't think that is
> possible currently.  Ideally we'd figure out some way to detect if a
> particular platform supports cache snooping or not as well.
>
> There's device_get_dma_attr(), although I don't think it will work
> currently for PCI devices without an OF or ACPI node - we could
> perhaps do with a PCI-specific wrapper which can walk up and defer
> to the host bridge's firmware description as necessary.
>
> The common DMA ops *do* correctly keep track of per-device coherency
> internally, but drivers aren't supposed to be poking at that
> information directly.
>
> That sounds like you underestimate the problem. ARM has unfortunately
> made the coherency for PCI an optional IP.
>
> Sorry to be that guy, but I'm involved a lot internally with our
> system IP and interconnect, and I probably understand the situation
> better than 99% of the community ;)
>
> I need to apologize, didn't realized who was answering :)
>
> It just sounded to me that you wanted to suggest to the end user that
> this is fixable in software and I really wanted to avoid even more
> customers coming around asking how to do this.
>
> For the record, the SBSA specification (the closet thing we have to a
> "system architecture") does require that PCIe is integrated in an
> I/O-coherent manner, but we don't have any control over what people do
> in embedded applications (note that we don't make PCIe IP at all, and
> there is plenty of 3rd-party interconnect IP).
>
> So basically it is not the fault of the ARM IP-core, but people are just
> stitching together PCIe interconnect IP with a core where it is not
> supposed to be used with.
>
> Do I get that correctly? That's an interesting puzzle piece in the pictur=
e.
>
> So we are talking about a hardware limitation which potentially can't
> be fixed without replacing the hardware.
>
> You expressed interest in "some way to detect if a particular platform
> supports cache snooping or not", by which I assumed you meant a
> software method for the amdgpu/radeon drivers to call, rather than,
> say, a website that driver maintainers can look up SoC names on. I'm
> saying that that API already exists (just may need a bit more work).
> Note that it is emphatically not a platform-level thing since
> coherency can and does vary per device within a system.
>
> Well, I think this is not something an individual driver should mess
> with. What the driver should do is just express that it needs coherent
> access to all of system memory and if that is not possible fail to load
> with a warning why it is not possible.
>
> I wasn't suggesting that Linux could somehow make coherency magically
> work when the signals don't physically exist in the interconnect - I
> was assuming you'd merely want to do something like throw a big
> warning and taint the kernel to help triage bug reports. Some drivers
> like ahci_qoriq and panfrost simply need to know so they can program
> their device to emit the appropriate memory attributes either way, and
> rely on the DMA API to hide the rest of the difference, but if you
> want to treat non-coherent use as unsupported because it would require
> too invasive changes that's fine by me.
>
> Yes exactly that please. I mean not sure how panfrost is doing it, but
> at least the Vulkan userspace API specification requires devices to have
> coherent access to system memory.
>
> So even if I would want to do this it is simply not possible because the
> application doesn't tell the driver which memory is accessed by the
> device and which by the CPU.
>
> Christian.
>
> Robin.
>
> _______________________________________________
> Linux-rockchip mailing list
> Linux-rockchip@lists.infradead.org
> https://nam11.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Flists.=
infradead.org%2Fmailman%2Flistinfo%2Flinux-rockchip&amp;data=3D04%7C01%7Cch=
ristian.koenig%40amd.com%7C8bdb8c3a6a2e4643bbfd08da08b42da4%7C3dd8961fe4884=
e608e11a82d994e183d%7C0%7C0%7C637831867224766930%7CUnknown%7CTWFpbGZsb3d8ey=
JWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp=
;sdata=3DF77FbO3SqslbzKu2%2FnjRLrQF45kljtD3%2FAEXEFd7NQs%3D&amp;reserved=3D=
0
>
>
