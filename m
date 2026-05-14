Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8D19CD4F25
	for <amd-gfx@archiver.kernel.org>; Thu, 14 May 2026 17:02:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4846210E101;
	Thu, 14 May 2026 17:02:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="g3n4QxiO";
	dkim-atps=neutral
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com
 [209.85.128.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E92E310E101
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 May 2026 17:02:47 +0000 (UTC)
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-488ad135063so67911945e9.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 May 2026 10:02:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778778166; x=1779382966; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hB5rYSPWU3EShwv1tVPSx+ORHC+hWkuGmw6uwHcZkPY=;
 b=g3n4QxiOIbhfVNfYwtinJ2v+wtg8PrH4/EBZQLfw6bdQvdAUAO+0y+lczuzoSERhqW
 /mPAxGfyb+I3pP7M1E9Iyk3jAp+IIa4U7i9wo+i9gVkxrA5qDSvSLtEKRlEStf8CwV2S
 l7wQBXT6tb10fUmpqHnXiJeJ+737ITPUwdFzCD83cCtjyo/XNJq4gURBX4/YwY1EFTNa
 E8si0HEvNdrJHNMSoQJdkhbLufQyGiP1ygbj8+QfGNGTx3fMLu2Zr5/3l5g+Bt2qnCGl
 Q2UJa0HXWwgRENQ7QPVUT6FobDoIsAFocCffnTNWDMJO39XeKgKKglBofJubiwrvXQCG
 jnnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778778166; x=1779382966;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=hB5rYSPWU3EShwv1tVPSx+ORHC+hWkuGmw6uwHcZkPY=;
 b=L5oMOjXcT+L/zix13cFZ4jcLLUoKBOxkyuxMdrMTGb7qoNpRbxyG264bGYE3iQspkv
 9/GUYSaNc1jjxA/lUtz4C0jsLMr9Mv1/hT/GaX5kEkcoRzGVzQDZi8WtvMhXSxpZEPDm
 9ECjHJFnCWalGe8s1rFZ4RkdOovLrx4rcy70+ffOAUlv/wbeslzS7V2o6CjDcDhEZz7w
 WATg4JSv38KizeZBXsES+Pn4gGbWVSYbNnJ4JL+acRrdRhetxKeVzW2m0/ibmSLFCSpb
 6pAVd6JbOIRO6dHnLaFX4xBduRJeb6SA1N6CaGReshvxq3xGl0GfKZ9/c8ju7y2yW0/0
 9ocQ==
X-Gm-Message-State: AOJu0YxhOdwD8Cr0rVg9vLlg6q/Mgec19bhrVW0r2Da5T1osErTOwR4j
 wEsd6onKEkDNCo5eDGIKTjjbd2WOlqDTz+1ohu6VCMdcZAUdow4ZV7C9
X-Gm-Gg: Acq92OHWv0l9WNtu+gBI/2MiYCr4Tij8CRjRLUx1+lASpEh+36Gx1lA45XVmq/E/eaa
 WKOaswPa3cWZKefa8SaN2NpOufPhnvrHyOVxZqmxZgeKwJ3d4vYEUBZoL6YDlKGAOsCxMJ5a1DL
 nURcdHgRLQ1bfcmsd/tZ+UFOIp+/7NBqdT/lwu7HRuYoPdAdkgjknBWeA+2zq+1vqS1/sfj3Hv9
 ivTuB+/PRwGgr1fUmS6pEDol/esbbUZ2hVRDTRRQY8//sYMPBcd6y2qMnC9faeRSeOtbVNa0O9f
 FB7JKEAi0UZYKGxIqYCJ+YWiUwdwAzwWMZWjlCcSIFQ4cwQPkTBvNLHK++wSaCGEMweTq+zdxV3
 86jWGhw5GjFcHcfetOXwDXrrRpg2guXMzAmjBZGTMTgl3gQgrfXie3oZw7Q5YmYuYHGRnon3XQK
 mIYr7VpCMXIXyfYsqR2VuKk9LUUoAKWI9t+RRukBOzVa613ci/dYfPf7+qGu2d02hfyh1TdA==
X-Received: by 2002:a05:600c:4e55:b0:488:ac01:72de with SMTP id
 5b1f17b1804b1-48fe60e510bmr3935265e9.5.1778778166099; 
 Thu, 14 May 2026 10:02:46 -0700 (PDT)
Received: from timur-hyperion.localnet (540017BE.dsl.pool.telekom.hu.
 [84.0.23.190]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48fe57944c1sm4635045e9.7.2026.05.14.10.02.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 May 2026 10:02:45 -0700 (PDT)
From: Timur =?UTF-8?B?S3Jpc3TDs2Y=?= <timur.kristof@gmail.com>
To: Alex Deucher <alexdeucher@gmail.com>,
 "Shetaia, Amir" <Amir.Shetaia@amd.com>
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>,
 Marek =?UTF-8?B?T2zFocOhaw==?= <maraeo@gmail.com>,
 Natalie Vock <natalie.vock@gmx.de>, Melissa Wen <mwen@igalia.com>
Subject: Re: [PATCH 0/6] drm/amdgpu: Improve retry fault handling
Date: Thu, 14 May 2026 19:02:43 +0200
Message-ID: <2342353.vFx2qVVIhK@timur-hyperion>
In-Reply-To: <PH8PR12MB6889AD2B155E8D73FD5A7A1B87072@PH8PR12MB6889.namprd12.prod.outlook.com>
References: <20260513163043.8725-1-timur.kristof@gmail.com>
 <4570266.UPlyArG6xL@timur-hyperion>
 <PH8PR12MB6889AD2B155E8D73FD5A7A1B87072@PH8PR12MB6889.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hi Amir,

I pushed a work in progress branch here:
https://gitlab.freedesktop.org/Venemo/linux/-/commits/ven_retry_faults_navi4

This contains the two series that I sent to the mailing list yesterday:
"Improve retry fault handling"
"Improve soft IH ring"

If we have to rely on the soft IH ring on Navi4, then we absolutely need th=
e=20
patches from "Improve soft IH ring", as it fixes a few bugs and switches th=
e=20
soft IH ring to use the system unbound workqueue. Otherwise it can happen t=
hat=20
the soft IH ring fills up even before your CPU can process anything in it.=
=20
(This is especially bad on HW that doesn't have the filter CAM enabled,
eg. Strix Halo.)

On top of that,

There is a patch to solve the race condition and make sure that the retry C=
AM=20
is ACKed after the VM update is complete. On Navi 31, this works and=20
successfully makes sure that the race is eliminated and each VM fault is on=
ly=20
processed once. I'd like to submit these if you guys agree on the approach.

And finally, there is a very messy patch that contains what I tried to do t=
o=20
get it all working on Navi 48. This has a lot of comments with my notes dur=
ing=20
development, and some attempts I tried to fix the issue (without success).

Basically, what I did was:

=2D Enable the retry CAM the same way as I did on IH 6.0 exactly like you s=
aid
=2D Added the cam_index to gmc_v12_0_process_interrupt
=2D Added a few bits to gfxhub_v12_0 and gfx_v12_0 to actually enable retry=
=20
faults (without that, the faults don't have the retry bit in src_data[1])

Now, what I observe on Navi 48 is:

1. Retry fault interrupt is triggered
2. Dispatched on the soft IH ring
3. The interrupt handler is called again on the soft IRQ ring
4. The fault is mitigated by amdgpu_vm_handle_fault()
5. Finally, the retry CAM is ACKed
6. As soon as the CAM is ACKed, I get another interrupt for the same addres=
s,=20
and it goes on infinitely or until GPU reset is triggered.

Attempts at fixing what I saw on Navi 48:

=2D Tried to add a TLB flush to various places. Now that the race is mitiga=
ted,=20
the TLB flush doesn't make things worse anymore, but it's also not helping.
=2D Tried to set the FORCE_MISS bits on various cache related registers, ho=
ping=20
that it would work around the possibility of the PTE/PDE not being updated =
in=20
the cache. This didn't help either.
=2D Tried to use amdgpu.vm_update_mode=3D3 to use the CPU to update the pag=
e=20
tables, but that didn't help on Navi 48
=2D Tried to halt the CP using CP_ME_CNTL to see if it would stop sending=20
interrupts, but it didn't.
=2D Using umr I tried to disable the L2 cache and reset it with the GRBM, b=
ut=20
that just broke the whole system.

Other notes on the retry fault topic in general:

=2D On GPUs that don't have the retry CAM (eg. Navi 1-2 and APUs) we'll nee=
d to=20
consider disabling the VM fault interrupt while processing the retry, becau=
se=20
the soft IH ring can fill up really quickly and the CPU may struggle to kee=
p up=20
with it.
=2D In general (for all GPUs), I think it would be better to update a large=
r VA=20
range of subsequent pages rather than just a single page, in order to more=
=20
efficiently mitigate VM faults to neighbouring pages.
=2D Currently all of the invalid accesses are redirected to the same dummy =
page,=20
which is a security hole because it means that a process that had an out of=
=20
bounds write can leak data to a process that does an out of bounds read. I=
=20
already talked to Christian about this, he has a few ideas how to fix it.

Thanks & best regards,
Timur


On Thursday, May 14, 2026 5:04:00=E2=80=AFPM Central European Summer Time S=
hetaia,=20
Amir wrote:
> AMD General
>=20
> Hi Timur,
>=20
> Thanks for clarifying. yes, please push the Navi 48 WIP branch when you h=
ave
> a chance, useful to compare side-by-side.
=20
> Patch 5 / WDOORBELL on ih_v7_0: I have been able to confirm that doorbell
> ACK does not free the CAM slot on the NV4 family
 (gfx1200/1201). I
> verified empirically, slots walk monotonically until the CAM fills, then =
HW
> silently drops retry events. MMIO write to regIH_RETRY_CAM_ACK does free
> it. Almost certainly required for your Navi 48 attempt.=20
> Why PTE update doesn't reach UTC L0: Most likely a race between the SDMA
> PTE-update job completing and the CAM ACK firing the
 IRQ for re-handling.
> Until SDMA finishes the write + invalidation propagates, UTC L0 keeps
> getting the stale "invalid" reply which is exactly your symptom.=20
> To inspect with umr: clone https://gitlab.freedesktop.org/tomstdenis/umr =
and
> use scripts/diag/dump_all_cpc_info.sh (needs
 halt_if_hws_hang=3D1
> gpu_recovery=3D0). For UTC specifically: umr -i <gpu> -O bits -r
> '*.*.regGCVM_L2_STATUS' (look at L2_BUSY and CONTEXT_DOMAIN_BUSY per-VMID
> bits) and regGCVM_L2_PROTECTION_FAULT_STATUS (empty + busy =3D translation
> timeout, not denial). Page-table walk to confirm PTE landed: sudo umr -i
> <gpu> -vm <vmid>@<va> 1.=20
> Your ACK-after-SDMA-fence idea: good catch. We hadn't dug into that race
> because the BO-clear deadlock dominates on NV4, but
 the ordering bug is
> almost certainly there too. Fence callback is the right shape, cleaner th=
an
> blocking the worker. Would be a generic fix benefiting both Navi 3 and 4.
> Happy to review if you take a swing.=20
> IH1 routing: fair point. I just inherited the existing IH0 path and haven=
't
> tried IH1. On the list once CAM ACK and fence ordering are stable.
=20
> AMIR SHETAIA
> Senior Software Development Engineer  |  AMD
> Software Platform Architecture Team
> -------------------------------------------------------------------------=
=2D--
> ------------------------------------------------------
 1 Commerce Valley
> Drive, Markham, ON L3T 7X6
> LinkedIn  |  Instagram  |  X  |  amd.com
>=20
>=20
>=20
>=20
> -----Original Message-----
> From: Timur Krist=C3=B3f <timur.kristof@gmail.com>
> Sent: Wednesday, May 13, 2026 6:12 PM
> To: Alex Deucher <alexdeucher@gmail.com>; Shetaia, Amir
> <Amir.Shetaia@amd.com>
 Cc: amd-gfx@lists.freedesktop.org; Deucher,
> Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
> <Christian.Koenig@amd.com>; Marek Ol=C5=A1=C3=A1k <maraeo@gmail.com>; Nat=
alie Vock
> <natalie.vock@gmx.de>; Melissa Wen <mwen@igalia.com> Subject: Re: [PATCH
> 0/6] drm/amdgpu: Improve retry fault handling=20
> Hi Amir,
>=20
>=20
> > Timur, you are right, I see your patch 6 already does the MMIO ACK for
> > gmc_v11_0/ih_v6_0. I missed that. The gap is only in patch 5's ih_v7_0
> > implementation, which still does WDOORBELL. that's where I'd suggest
> > swapping in MMIO for NV4.
>=20
>=20
> First, let me clear up a slight misunderstanding here. The patch series t=
hat
> I sent here only contains what I managed to get working on Navi 31, it do=
es
> not contain any code from my attempt at Navi 48.
=20
> The patch 5 is just a slight refactor of the pre-existing code and
> (intentionally) doesn't contain any functional changes. It seems that IH =
7.1
> relies on the doorbell, so I didn't want to remove it, albeit I have no
> means to verify if that actually works or not.
=20
> If you like, I can push a few WIP patches to a different branch tomorrow =
to
> show you exactly what I did on Navi 48. However, I wouldn't want to submit
> that to the mailing list without first making sure that it works well.
=20
>=20
> > 1. "Fault never resolves on NV48" different shape from our
> > broken-CAM-ACK symptom.
>=20
>=20
>=20
> > You're right, those are different. Our cam-walk-monotonically symptom
> > only shows up when CAM is enabled but the ACK is broken.
> >=20
>  > On your NV48 setup CAM
> >=20
> > probably isn't enabled at all (your patch 6 only enables it for
> > ih_v6_0_irq_init, no equivalent in ih_v7_0_irq_init)
>=20
>=20
> For the attempt on Navi 48, I enabled the CAM in ih_v7_0 the same way I do
> for
 ih_v6_0 in the series. But, because I couldn't get it fully working, I
> didn't include any of that code in the series.=20
>=20
> > so retries fire
> > repeatedly on the IH ring instead of being deduped by CAM. That
> > matches what you're seeing .. amdgpu_vm_handle_fault keeps being
> > called but each call is on a fresh IRQ for the same address.
> > Two things that could be happening underneath:
> > - The fault handler runs but the updated PTE never reaches UTC L0 (TLB
> > invalidation gap). On NV4 we see this as "valid PTEs failing to
> > translate"
> > in our UMR captures.
>=20
>=20
> I think this explanation may fit what I saw.
> Why is it not reaching UTC L0?
> Also, how do you inspect this stuff in umr?
>=20
>=20
> > 2. What bits we check on src_data[2]:
> >
> >
> >
> > Honestly, we don't use src_data[2] for retry detection. We use it only
> > for
> > the cam_index: cam_index =3D entry->src_data[2] & 0x3ff;   /* low 10 bi=
ts =3D
> > CAM slot */
>=20
>=20
>=20
> > For retry detection we initially used the gfx9 constant on src_data[1]
> > like you, but observed the bit cleared on a lot of NV4 events that
> > should have been retries (waves were hung in xnack-stall but no IH event
> > matched).
 So
> > we just go through the retry path unconditionally on NV4
>=20
>=20
> I see. I think I needed to change some gfxhub registers to get those
> src_data bits that you are missing.
=20
>=20
> > and let
> > amdgpu_vm_handle_fault sort it out via SVM range migration. May be
> > specific to gfx1201 / our test path
>=20
>=20
> My test case is a simple Vulkan shader which I am executing with vkrunner.
> Each shader invocation does an out of bounds read from a different page. =
=46or
> Navi 31 (and Strix Halo), I started out with just 1 page fault, and once I
> could mitigate that reliably, I turned it up to several hundred faults.
=20
>=20
> > 3. TLB flush making it worse .. clue about what to do:
> >
> >
> >
> > Honest answer: not really, not a SW-only fix. Our 1 GiB hang is an
> > architectural deadlock ... ih_soft_work blocks on a dma_fence for an
> > SDMA BO-clear, the BO-clear is stalled on a GCR (cache flush) request,
> > and the GC cache block isn't ACK'ing the GCR while UTC L2 is saturated
> > by the user shader's XNACK retry storm. Adding a TLB flush adds
> > another translation request to the same saturated UTC, which is why it
> > makes things worse.
>=20
>=20
> This may be related to a flaw in amdgpu_gmc_handle_retry_fault():
> what the function does is first call amdgpu_vm_handle_fault() which kicks
> off an SDMA job to update page tables, and then it ACKs the filter CAM.
> However, at the moment when the CAM is ACKed, the SDMA job is not finished
> yet, so the CP sees that the page is still invalid and the page fault
> interrupt is fired again. I actually noticed that on Navi 31 too, but it's
> just not fatal there.
 It just basically handles the same page fault twice.
> Once we solve this flaw, I would like to propose to enable retry faults by
> default on Navi 3.=20
> Here is an idea for a solution:
>=20
> Instead of ACKing the CAM right away, we should do it after the SDMA fence
> is signalled, ie. when we are sure the page tables are updated. Maybe we
> can set a callback on the fence and do it there, though it would require a
> slight code churn to get that to work.
=20
> What do you think?
>=20
>=20
> > 4. IH1 ring on NV4:
> >
> >
> >
> > Same as you ... retry faults on NV4 always come in on IH0. We delegate
> > from
> > IH0 to ih.ring_soft (amdgpu_irq_delegate(adev, entry, 8)) so the
> > SVM/migration path can sleep, but the original entry is on IH0. We
> > haven't tried IH1 routing.
>=20
>=20
> Why, though?
>=20
> The ih_v7_0 code does set up the IH1 ring and configure it exactly the sa=
me
> as the ih_v6_0, so I don't see why it wouldn't work?
=20
>=20
> > Re your branch: thanks for the gitlab link, easier than digging
> > through patchwork.
> > I'll cherry-pick patches 1, 3, 4 into our test build to see if patch 4
> > cleans up the timestamp filter delta we're seeing (97k entered / 2.8k
> > completed at 1 GiB might be partly explained by your Strix Halo bug).
>=20
>=20
> The timestamp issue actually gave me an endless headache when I first got
> into this topic in December. I hope the patch helps!
=20
> Best regards,
> Timur
>=20
>=20



