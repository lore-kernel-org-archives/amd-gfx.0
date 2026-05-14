Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD141CD4F39
	for <amd-gfx@archiver.kernel.org>; Thu, 14 May 2026 21:24:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 36C2310E004;
	Thu, 14 May 2026 21:24:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="VC89xAMp";
	dkim-atps=neutral
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com
 [209.85.128.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8AFDC10E004
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 May 2026 21:24:53 +0000 (UTC)
Received: by mail-wm1-f53.google.com with SMTP id
 5b1f17b1804b1-488b150559bso66531095e9.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 May 2026 14:24:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778793892; x=1779398692; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BXO9xaXpbZ0XEQpGzHtPBknevDBGb0nIBIAv6nzooxY=;
 b=VC89xAMpEu6d+Gxl4TbuvHaYp6WnSXr9oUuFPKTLuc0iRrP/0TkdKpnQ6zwJX3VqyQ
 V0F/N81qkEYfRTYS4qWL1NRJZDbFrQrKHTPZg1V58f/8qLx6ruO67LDzXeYYxwZzL2h5
 KIiIWYtukirAtSydLPEbOQR26h5ZoeMnMGPcewH0J6D+D4UGb/GT4nosyuHCtbLUIr67
 FkljMCSAHS2tV0EJAFDBKJZ+2foi+lQjOwmJR160Fgbr8XhiOj2E6sYAmVOgnm8k/LE+
 RGNAooHX6vxVJzvx/a+ZWYUZ+1JRFfO4KDe8tYSaGfPkfLb2lEG10xeT8iX+ZfXSMXD0
 MBig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778793892; x=1779398692;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=BXO9xaXpbZ0XEQpGzHtPBknevDBGb0nIBIAv6nzooxY=;
 b=ggpXuEZK+h26tcwB51Jnzde6tbl0UVzZNPcprGTX8cz6jIBuZt6LlA7rlYOay3VlqV
 66Tke9XXEBa4LYWhALR/cpBiqkLYg0iXt6H0T1xr6VnthLjY1vNVNuC4C+/ZzfaQeKYv
 PS7Bqd8GAohx6TEqzOt/N6o1j39ml+X+HCj7uOZ/rNvhwHSNh89on9YO2SSS8xeHX59A
 gUY1EPT6AC6kiyOyoVxU6Ex8uggTl/sIsXlxeFcB85GEUaf4OEYRshV+zmC89Kl8qDWF
 Qk/X95EFYDHf4gehHm8F+5lPRCO6tD4M/+2MEAuOsqpdYc9oD0InkDsb1pP8Khs7FnIr
 qLpg==
X-Gm-Message-State: AOJu0Yx4X1F90/ak11YL72ZKkOk5OOSnqOewSpXwcm0BSyG3Br97ZTkK
 gZDJ/UOZYn5ybBcLNPVFOD3T42vbCsb/yv50hnE1uYkmEIfp/4NdQebW
X-Gm-Gg: Acq92OGALHMcJcQeN2UxRbA5+aUPnVF3FFaGeVUKcvP9bYtbi8sMWB/A2h7cdjSKp//
 D4wM2Lpzcqh/p2OEedTQcQpnzYDcZdnTfLRNk0N/XWKgZcet+OqLQR3zP5VAjeKQoaQUsSaSZuv
 YZhwZAYAEn1R9Z+dK+i5x1ABi3ZcpPX4J27Xs9HOtSqTND88WVZyabpdfBb6ro+D2n0VLlGIsr9
 TetYi3Hy19co8G5jjTTecNuH4Qo8dtnlaKF9X2vMAX0NAhavYbbnaNkzOzww0sCHF6mm+tBvjFG
 vJe8xlv1anE1sGdKtT5swtWOP+ofN/FDJh/GaGlzt5A+i3JM6MxXM8SGLFhpJBctgNd65i56rqY
 KnGgkE04Pjgz0L8+n/VihjfJ1zmTwDJ5AwMv0Mz8U0qG+jrPvVQpyi6SViaofuxoosuQJJvK2Yr
 HI/oB6hwKsfQ0kA2PBIVhq8rHBvYLaGl1zXA0g9nB59FMih1n70hw0HwCRYe1YpCfZV42H4P0xF
 dDmH/6i
X-Received: by 2002:a05:600c:4e02:b0:483:2c98:4368 with SMTP id
 5b1f17b1804b1-48fe6322416mr14263175e9.18.1778793891628; 
 Thu, 14 May 2026 14:24:51 -0700 (PDT)
Received: from timur-hyperion.localnet (540017BE.dsl.pool.telekom.hu.
 [84.0.23.190]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48fe53804aesm15599805e9.15.2026.05.14.14.24.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 May 2026 14:24:51 -0700 (PDT)
From: Timur =?UTF-8?B?S3Jpc3TDs2Y=?= <timur.kristof@gmail.com>
To: Alex Deucher <alexdeucher@gmail.com>,
 "Shetaia, Amir" <Amir.Shetaia@amd.com>
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>,
 Marek =?UTF-8?B?T2zFocOhaw==?= <maraeo@gmail.com>,
 Natalie Vock <natalie.vock@gmx.de>, Melissa Wen <mwen@igalia.com>
Subject: Re: [PATCH 0/6] drm/amdgpu: Improve retry fault handling
Date: Thu, 14 May 2026 23:24:49 +0200
Message-ID: <5044340.OV4Wx5bFTl@timur-hyperion>
In-Reply-To: <PH8PR12MB6889CDC1BE1667402FDE152087072@PH8PR12MB6889.namprd12.prod.outlook.com>
References: <20260513163043.8725-1-timur.kristof@gmail.com>
 <2342353.vFx2qVVIhK@timur-hyperion>
 <PH8PR12MB6889CDC1BE1667402FDE152087072@PH8PR12MB6889.namprd12.prod.outlook.com>
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

Thanks, glad to hear that!

I recommend to also apply "Add fence argument to amdgpu_vm_handle_fault()" =
and=20
"ACK the retry CAM after VM update finishes" as these fix the race between =
the=20
CAM and the SDMA, and should improve the reliability of the whole mechanism=
 in=20
my opinion.

In the meantime I think I figured out what I was missing.
Considering that the FORCE_MISS bits didn't change the behavior, I was=20
thinking that the curlpit must be something else, so I started looking into=
=20
the PTE that is being added.

It all started working for me when I added some new PTE flags to=20
amdgpu_vm_handle_fault(): AMDGPU_PTE_IS_PTE and AMDGPU_PTE_NOALLOC.
With that, I cleaned up my patches and force-pushed them to the same branch:

https://gitlab.freedesktop.org/Venemo/linux/-/commits/ven_retry_faults_navi4

What do you think?

Best regards,
Timur


On Thursday, May 14, 2026 9:32:16=E2=80=AFPM Central European Summer Time S=
hetaia,=20
Amir wrote:
> AMD General
>=20
> Hi Timur,
>=20
> I cherry-picked your soft-IH-ring + timestamp-filter patches onto our bui=
ld,
> ran malloc 1 GiB sweep (N=3D10) on Navi4 (gfx1201):
=20
>                                                     PASS    1st hang   sR=
_r
> entered
 Baseline (no patches)            1/10    trial 6       97k
>   With your patches                  2/10    trial 8      43k
>=20
> What I noticed on NV4:
> - 2=C3=97 trials before failure (soft-IH unbound workqueue helping)
> - ~55% reduction in spurious svm_range_restore_pages (your timestamp-filt=
er
> fix catches a real bug here too, not just Strix Halo)
 - Soft IH worker
> visibly on events_unbound queue
>=20
> Same dma_fence_wait_timeout signature underneath, now on TWO workers
> (amdgpu_irq_handle_ih_soft + ttm_bo_delayed_delete,
 TTM cleanup gated on
> the same fence chain). Central BO-clear/GCR deadlock unchanged, your
> patches fix adjacent bugs but that one needs the HW fix.=20
> Also tested UTCL0 retry-rate knob. On NV4 the gfx12 equivalents are
> regGL1C_UTCL0_RETRY / regGL1XC_UTCL0_RETRY
 (the TCP-level register moved
> to GL1C-level on gfx12). Wrote INCR=3D0xff COUNT=3D0xf via umr to all SE/=
SA
> banks =E2=86=92 0/10 PASS, hung sooner. So, slowing UTCL0 retries doesn't=
 help.
> deadlock isn't pressure-driven on UTCL0.=20
>=20
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
> Sent: Thursday, May 14, 2026 1:03 PM
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
> I pushed a work in progress branch here:
> https://gitlab.freedesktop.org/Venemo/linux/-/commits/ven_retry_faults_na=
vi4
>=20
=20
> This contains the two series that I sent to the mailing list yesterday:
> "Improve retry fault handling"
> "Improve soft IH ring"
>=20
> If we have to rely on the soft IH ring on Navi4, then we absolutely need =
the
> patches from "Improve soft IH ring", as it fixes a few bugs and switches
> the soft IH ring to use the system unbound workqueue. Otherwise it can
> happen that the soft IH ring fills up even before your CPU can process
> anything in it.
 (This is especially bad on HW that doesn't have the filter
> CAM enabled, eg. Strix Halo.)=20
> On top of that,
>=20
> There is a patch to solve the race condition and make sure that the retry
> CAM is ACKed after the VM update is complete. On Navi 31, this works and
> successfully makes sure that the race is eliminated and each VM fault is
> only processed once. I'd like to submit these if you guys agree on the
> approach.
=20
> And finally, there is a very messy patch that contains what I tried to do=
 to
> get it all working on Navi 48. This has a lot of comments with my notes
> during development, and some attempts I tried to fix the issue (without
> success).
=20
> Basically, what I did was:
>=20
> - Enable the retry CAM the same way as I did on IH 6.0 exactly like you
> said
 - Added the cam_index to gmc_v12_0_process_interrupt
> - Added a few bits to gfxhub_v12_0 and gfx_v12_0 to actually enable retry
> faults (without that, the faults don't have the retry bit in src_data[1])
=20
> Now, what I observe on Navi 48 is:
>=20
> 1. Retry fault interrupt is triggered
> 2. Dispatched on the soft IH ring
> 3. The interrupt handler is called again on the soft IRQ ring 4. The fault
> is mitigated by amdgpu_vm_handle_fault() 5. Finally, the retry CAM is ACK=
ed
> 6. As soon as the CAM is ACKed, I get another interrupt for the same
> address, and it goes on infinitely or until GPU reset is triggered.
=20
> Attempts at fixing what I saw on Navi 48:
>=20
> - Tried to add a TLB flush to various places. Now that the race is
> mitigated, the TLB flush doesn't make things worse anymore, but it's also
> not helping.
 - Tried to set the FORCE_MISS bits on various cache related
> registers, hoping that it would work around the possibility of the PTE/PDE
> not being updated in the cache. This didn't help either. - Tried to use
> amdgpu.vm_update_mode=3D3 to use the CPU to update the page tables, but t=
hat
> didn't help on Navi 48 - Tried to halt the CP using CP_ME_CNTL to see if =
it
> would stop sending interrupts, but it didn't. - Using umr I tried to
> disable the L2 cache and reset it with the GRBM, but that just broke the
> whole system.=20
> Other notes on the retry fault topic in general:
>=20
> - On GPUs that don't have the retry CAM (eg. Navi 1-2 and APUs) we'll need
> to consider disabling the VM fault interrupt while processing the retry,
> because the soft IH ring can fill up really quickly and the CPU may
> struggle to keep up with it.
 - In general (for all GPUs), I think it would
> be better to update a larger VA range of subsequent pages rather than just
> a single page, in order to more efficiently mitigate VM faults to
> neighbouring pages. - Currently all of the invalid accesses are redirected
> to the same dummy page, which is a security hole because it means that a
> process that had an out of bounds write can leak data to a process that
> does an out of bounds read. I already talked to Christian about this, he
> has a few ideas how to fix it.=20
> Thanks & best regards,
> Timur
>=20
>=20
> On Thursday, May 14, 2026 5:04:00=E2=80=AFPM Central European Summer Time=
 Shetaia,
> Amir wrote:
> > AMD General
> >
> >
> >
> > Hi Timur,
> >
> >
> >
> > Thanks for clarifying. yes, please push the Navi 48 WIP branch when
> > you have a chance, useful to compare side-by-side.
>=20
>=20
>=20
> > Patch 5 / WDOORBELL on ih_v7_0: I have been able to confirm that
> > doorbell ACK does not free the CAM slot on the NV4 family
>=20
>  (gfx1200/1201). I
>=20
> > verified empirically, slots walk monotonically until the CAM fills,
> > then HW silently drops retry events. MMIO write to regIH_RETRY_CAM_ACK
> > does free it. Almost certainly required for your Navi 48 attempt.
> > Why PTE update doesn't reach UTC L0: Most likely a race between the
> > SDMA PTE-update job completing and the CAM ACK firing the
>=20
>  IRQ for re-handling.
>=20
> > Until SDMA finishes the write + invalidation propagates, UTC L0 keeps
> > getting the stale "invalid" reply which is exactly your symptom.
> > To inspect with umr: clone
> > https://gitlab.freedesktop.org/tomstdenis/umr and use
> > scripts/diag/dump_all_cpc_info.sh (needs
>=20
>  halt_if_hws_hang=3D1
>=20
> > gpu_recovery=3D0). For UTC specifically: umr -i <gpu> -O bits -r
> > '*.*.regGCVM_L2_STATUS' (look at L2_BUSY and CONTEXT_DOMAIN_BUSY
> > per-VMID
> > bits) and regGCVM_L2_PROTECTION_FAULT_STATUS (empty + busy =3D
> > translation timeout, not denial). Page-table walk to confirm PTE
> > landed: sudo umr -i <gpu> -vm <vmid>@<va> 1.
> > Your ACK-after-SDMA-fence idea: good catch. We hadn't dug into that
> > race because the BO-clear deadlock dominates on NV4, but
>=20
>  the ordering bug is
>=20
> > almost certainly there too. Fence callback is the right shape, cleaner
> > than blocking the worker. Would be a generic fix benefiting both Navi 3
> > and 4.
 Happy to review if you take a swing.
> > IH1 routing: fair point. I just inherited the existing IH0 path and
> > haven't tried IH1. On the list once CAM ACK and fence ordering are
> > stable.
>=20
>=20
>=20
> > AMIR SHETAIA
> > Senior Software Development Engineer  |  AMD Software Platform
> > Architecture Team
> > ----------------------------------------------------------------------
> > ------
> > ------------------------------------------------------
>=20
>  1 Commerce Valley
>=20
> > Drive, Markham, ON L3T 7X6
> > LinkedIn  |  Instagram  |  X  |  amd.com
> >
> >
> >
> >
> >
> >
> > -----Original Message-----
> > From: Timur Krist=C3=B3f <timur.kristof@gmail.com>
> > Sent: Wednesday, May 13, 2026 6:12 PM
> > To: Alex Deucher <alexdeucher@gmail.com>; Shetaia, Amir
> > <Amir.Shetaia@amd.com>
>=20
>  Cc: amd-gfx@lists.freedesktop.org; Deucher,
>=20
> > Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
> > <Christian.Koenig@amd.com>; Marek Ol=C5=A1=C3=A1k <maraeo@gmail.com>; N=
atalie
> > Vock <natalie.vock@gmx.de>; Melissa Wen <mwen@igalia.com> Subject: Re:
> > [PATCH 0/6] drm/amdgpu: Improve retry fault handling Hi Amir,
> >
> >
> >
> >
> > > Timur, you are right, I see your patch 6 already does the MMIO ACK
> > > for gmc_v11_0/ih_v6_0. I missed that. The gap is only in patch 5's
> > > ih_v7_0 implementation, which still does WDOORBELL. that's where I'd
> > > suggest swapping in MMIO for NV4.
> >
> >
> >
> >
> > First, let me clear up a slight misunderstanding here. The patch
> > series that I sent here only contains what I managed to get working on
> > Navi 31, it does not contain any code from my attempt at Navi 48.
>=20
>=20
>=20
> > The patch 5 is just a slight refactor of the pre-existing code and
> > (intentionally) doesn't contain any functional changes. It seems that
> > IH 7.1 relies on the doorbell, so I didn't want to remove it, albeit I
> > have no means to verify if that actually works or not.
>=20
>=20
>=20
> > If you like, I can push a few WIP patches to a different branch
> > tomorrow to show you exactly what I did on Navi 48. However, I
> > wouldn't want to submit that to the mailing list without first making s=
ure
> > that it works well.
>=20
>=20
> >
> >
> > > 1. "Fault never resolves on NV48" different shape from our
> > > broken-CAM-ACK symptom.
> >
> >
> >
> >
> >
> > > You're right, those are different. Our cam-walk-monotonically
> > > symptom only shows up when CAM is enabled but the ACK is broken.
> > >
> > >
> > >
> >  > On your NV48 setup CAM
> > >
> > >
> > >
> > > probably isn't enabled at all (your patch 6 only enables it for
> > > ih_v6_0_irq_init, no equivalent in ih_v7_0_irq_init)
> >
> >
> >
> >
> > For the attempt on Navi 48, I enabled the CAM in ih_v7_0 the same way
> > I do for
>=20
>  ih_v6_0 in the series. But, because I couldn't get it fully working, I
>=20
> > didn't include any of that code in the series.
> >
> >
> >
> > > so retries fire
> > > repeatedly on the IH ring instead of being deduped by CAM. That
> > > matches what you're seeing .. amdgpu_vm_handle_fault keeps being
> > > called but each call is on a fresh IRQ for the same address.
> > > Two things that could be happening underneath:
> > > - The fault handler runs but the updated PTE never reaches UTC L0
> > > (TLB invalidation gap). On NV4 we see this as "valid PTEs failing to
> > > translate"
> > > in our UMR captures.
> >
> >
> >
> >
> > I think this explanation may fit what I saw.
> > Why is it not reaching UTC L0?
> > Also, how do you inspect this stuff in umr?
> >
> >
> >
> >
> > > 2. What bits we check on src_data[2]:
> > >
> > >
> > >
> > >
> > >
> > > Honestly, we don't use src_data[2] for retry detection. We use it
> > > only for
> > > the cam_index: cam_index =3D entry->src_data[2] & 0x3ff;   /* low 10 =
bits
> > > =3D
> > > CAM slot */
> >
> >
> >
> >
> >
> > > For retry detection we initially used the gfx9 constant on
> > > src_data[1] like you, but observed the bit cleared on a lot of NV4
> > > events that should have been retries (waves were hung in xnack-stall
> > > but no IH event matched).
>=20
>  So
>=20
> > > we just go through the retry path unconditionally on NV4
> >
> >
> >
> >
> > I see. I think I needed to change some gfxhub registers to get those
> > src_data bits that you are missing.
>=20
>=20
>=20
> >
> >
> > > and let
> > > amdgpu_vm_handle_fault sort it out via SVM range migration. May be
> > > specific to gfx1201 / our test path
> >
> >
> >
> >
> > My test case is a simple Vulkan shader which I am executing with
> > vkrunner.
> > Each shader invocation does an out of bounds read from a different
> > page. For Navi 31 (and Strix Halo), I started out with just 1 page
> > fault, and once I could mitigate that reliably, I turned it up to sever=
al
> > hundred faults.
>=20
>=20
> >
> >
> > > 3. TLB flush making it worse .. clue about what to do:
> > >
> > >
> > >
> > >
> > >
> > > Honest answer: not really, not a SW-only fix. Our 1 GiB hang is an
> > > architectural deadlock ... ih_soft_work blocks on a dma_fence for an
> > > SDMA BO-clear, the BO-clear is stalled on a GCR (cache flush)
> > > request, and the GC cache block isn't ACK'ing the GCR while UTC L2
> > > is saturated by the user shader's XNACK retry storm. Adding a TLB
> > > flush adds another translation request to the same saturated UTC,
> > > which is why it makes things worse.
> >
> >
> >
> >
> > This may be related to a flaw in amdgpu_gmc_handle_retry_fault():
> > what the function does is first call amdgpu_vm_handle_fault() which
> > kicks off an SDMA job to update page tables, and then it ACKs the filter
> > CAM.
 However, at the moment when the CAM is ACKed, the SDMA job is not
> > finished yet, so the CP sees that the page is still invalid and the page
> > fault interrupt is fired again. I actually noticed that on Navi 31 too,
> > but it's just not fatal there.
>=20
>  It just basically handles the same page fault twice.
>=20
> > Once we solve this flaw, I would like to propose to enable retry
> > faults by default on Navi 3.
> > Here is an idea for a solution:
> >
> >
> >
> > Instead of ACKing the CAM right away, we should do it after the SDMA
> > fence is signalled, ie. when we are sure the page tables are updated.
> > Maybe we can set a callback on the fence and do it there, though it
> > would require a slight code churn to get that to work.
>=20
>=20
>=20
> > What do you think?
> >
> >
> >
> >
> > > 4. IH1 ring on NV4:
> > >
> > >
> > >
> > >
> > >
> > > Same as you ... retry faults on NV4 always come in on IH0. We
> > > delegate from
> > > IH0 to ih.ring_soft (amdgpu_irq_delegate(adev, entry, 8)) so the
> > > SVM/migration path can sleep, but the original entry is on IH0. We
> > > haven't tried IH1 routing.
> >
> >
> >
> >
> > Why, though?
> >
> >
> >
> > The ih_v7_0 code does set up the IH1 ring and configure it exactly the
> > same as the ih_v6_0, so I don't see why it wouldn't work?
>=20
>=20
>=20
> >
> >
> > > Re your branch: thanks for the gitlab link, easier than digging
> > > through patchwork.
> > > I'll cherry-pick patches 1, 3, 4 into our test build to see if patch
> > > 4 cleans up the timestamp filter delta we're seeing (97k entered /
> > > 2.8k completed at 1 GiB might be partly explained by your Strix Halo
> > > bug).
> >
> >
> >
> >
> > The timestamp issue actually gave me an endless headache when I first
> > got into this topic in December. I hope the patch helps!
>=20
>=20
>=20
> > Best regards,
> > Timur
> >
> >
> >
>=20
>=20
>=20
>=20



