Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54B75C10F16
	for <amd-gfx@archiver.kernel.org>; Mon,  6 May 2024 15:07:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CBC8910E1F6;
	Mon,  6 May 2024 15:07:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="PkEp9rEA";
	dkim-atps=neutral
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com
 [209.85.216.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D8A1510E1F6
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 May 2024 15:07:41 +0000 (UTC)
Received: by mail-pj1-f54.google.com with SMTP id
 98e67ed59e1d1-2b239b5fedaso1610747a91.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 06 May 2024 08:07:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1715008061; x=1715612861; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=neQGyNV+29mTtk8Q8Cqua5MUdaby9aEM9B8FtgLuJf8=;
 b=PkEp9rEAS355YdzqRvwgsgVh4BnSTATikMa97EzxfChFcJwtItLXZCeiDbcd4MqMgV
 1iijppwqIqw0T1EyY/AAZFtRF9b5WcdYzH8ELM3cYTZOrgZDa5bTS71KWmCmh3Yk7LqM
 Yti7/CdwHvqbtuAjTSIlSC18RphcU3MoJb/qrXvkZAVzhb6E+T8E7kKppy1X17O6JlTb
 H5lSGrPZu6tvx1+8+YshY0uASJdXYGSAD2i5CCpn6eBgXIXflXpWs++LuSSfx5foi7Cf
 ctZoUXs8FqKjvCmfmtFFxB7oyjYKTTFAA1MAuNY4hKphgxE5CNIISUFOXOq1s0Ha+zRc
 teOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715008061; x=1715612861;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=neQGyNV+29mTtk8Q8Cqua5MUdaby9aEM9B8FtgLuJf8=;
 b=DdqDvvS9a7g1wg5GyoSXc+PFDCvq8DPXDwZOWjUA7d7907Fj/S4wc36HPTrAWxb8An
 NEmkev2hsXijLeDhb+UL68DvfACHv7g5ijlXIdp23pSj8nZckWlYLS3r2tqo+tXipu02
 ukGcTXQc2gwkAR5euBvcbMX4gkFyPzdW9IxiKcEprADN8Icii0yyhlfqVmGZRsZ4SXpJ
 ovDEcdrKM/zzg2l2s+7mzvrJOCs3vFBmGL7kIOTKxDbZmkyJOHDZwM7aZMy9j4WlbTiu
 v150Ox4kSY/wrbFMlqRWfYXv0xD/y50NFsIHd4NLi0DRxJHpO8gc6obM30DLn7RKShyz
 wHhA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWTljJHubFnAALUsnuSnFj65UyCl1IdQRZC/315sdAMy9b0ESfxdwVIwoUn915Jh1lpfQw/iH//ERJ3f0jKu4zIgZQzcUh89O1SjkrnEg==
X-Gm-Message-State: AOJu0Ywtk8M4IRO8rMAA8kJJqADCzkHJKzJ395AsLdFtmkD72pCFlV2f
 QTFNoBoXWVMVnbO3fGuyElhzj4kHw9eytxIqN+UGgJzs0jZDO/f443NIG66xxrYjZVTaE1OXot1
 BNT3gycbUVkCuZVcGSG54o2zgFm8=
X-Google-Smtp-Source: AGHT+IGcvtTriyl/vepdivHRpRJovjDp8Qk11rQQEHS4UyhwdiwsUFxePf3tymHKBuNBmQkAym4sctAcIphE9xIRtWE=
X-Received: by 2002:a17:90b:11d4:b0:2b2:7c53:2601 with SMTP id
 gv20-20020a17090b11d400b002b27c532601mr8035017pjb.37.1715008061006; Mon, 06
 May 2024 08:07:41 -0700 (PDT)
MIME-Version: 1.0
References: <1237381714935562@dmcmxrwo3x2o7y3i.sas.yp-c.yandex.net>
 <20240505224508.GAZjgL9PO9Y5QaAO2t@fat_crate.local>
In-Reply-To: <20240505224508.GAZjgL9PO9Y5QaAO2t@fat_crate.local>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 6 May 2024 11:07:29 -0400
Message-ID: <CADnq5_NNATnV+mTEn6Mshro3gqpH5ffjQ=EWdH8QVZgEBYB-ew@mail.gmail.com>
Subject: Re: Error in amd driver?
To: Borislav Petkov <bp@alien8.de>
Cc: Tranton Baddy <t.baddy@yandex.ru>, amd-gfx@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Mon, May 6, 2024 at 6:00=E2=80=AFAM Borislav Petkov <bp@alien8.de> wrote=
:
>
> + amd-gfx@lists.freedesktop.org
>
> On Sun, May 05, 2024 at 09:59:22PM +0300, Tranton Baddy wrote:
> > I have this in my dmesg since version 6.8.6, not sure when it appeared.=
 Is amdgpu driver has bug?

Should be fixed in:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?=
id=3Dd3a9331a6591e9df64791e076f6591f440af51c3

Alex

> > [   64.253144] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > [   64.253162] BUG: KFENCE: use-after-free read in amdgpu_bo_move+0x51f=
/0x7a0
> >
> > [   64.253183] Use-after-free read at 0x00000000671c48dd (in kfence-#11=
1):
> > [   64.253192]  amdgpu_bo_move+0x51f/0x7a0
> > [   64.253202]  ttm_bo_handle_move_mem+0xcf/0x180
> > [   64.253211]  ttm_mem_evict_first+0x1c5/0x500
> > [   64.253218]  ttm_resource_manager_evict_all+0xa3/0x1e0
> > [   64.253228]  amdgpu_device_prepare+0x66/0x110
> > [   64.253237]  amdgpu_pmops_runtime_suspend+0xbe/0x1c0
> > [   64.253248]  pci_pm_runtime_suspend+0x74/0x200
> > [   64.253259]  vga_switcheroo_runtime_suspend+0x21/0xb0
> > [   64.253268]  __rpm_callback+0x5f/0x190
> > [   64.253277]  rpm_callback+0x7f/0x90
> > [   64.253283]  rpm_suspend+0x120/0x6a0
> > [   64.253290]  pm_runtime_work+0x9c/0xa0
> > [   64.253297]  process_one_work+0x164/0x330
> > [   64.253310]  worker_thread+0x302/0x430
> > [   64.253320]  kthread+0xe4/0x110
> > [   64.253329]  ret_from_fork+0x4c/0x60
> > [   64.253341]  ret_from_fork_asm+0x1b/0x30
> >
> > [   64.253353] kfence-#111: 0x00000000d018cf03-0x0000000034e821d1, size=
=3D96, cache=3Dkmalloc-96
> >
> > [   64.253363] allocated by task 152 on cpu 3 at 64.248952s:
> > [   64.253418]  kmalloc_trace+0x283/0x340
> > [   64.253427]  amdgpu_vram_mgr_new+0x8f/0x3f0
> > [   64.253435]  ttm_resource_alloc+0x39/0x90
> > [   64.253444]  ttm_bo_mem_space+0xa4/0x260
> > [   64.253450]  ttm_mem_evict_first+0x18a/0x500
> > [   64.253456]  ttm_resource_manager_evict_all+0xa3/0x1e0
> > [   64.253465]  amdgpu_device_prepare+0x66/0x110
> > [   64.253472]  amdgpu_pmops_runtime_suspend+0xbe/0x1c0
> > [   64.253481]  pci_pm_runtime_suspend+0x74/0x200
> > [   64.253489]  vga_switcheroo_runtime_suspend+0x21/0xb0
> > [   64.253496]  __rpm_callback+0x5f/0x190
> > [   64.253503]  rpm_callback+0x7f/0x90
> > [   64.253509]  rpm_suspend+0x120/0x6a0
> > [   64.253516]  pm_runtime_work+0x9c/0xa0
> > [   64.253523]  process_one_work+0x164/0x330
> > [   64.253532]  worker_thread+0x302/0x430
> > [   64.253542]  kthread+0xe4/0x110
> > [   64.253550]  ret_from_fork+0x4c/0x60
> > [   64.253559]  ret_from_fork_asm+0x1b/0x30
> >
> > [   64.253570] freed by task 152 on cpu 3 at 64.253117s:
> > [   64.253582]  ttm_resource_free+0x67/0x90
> > [   64.253591]  ttm_bo_move_accel_cleanup+0x247/0x2e0
> > [   64.253598]  amdgpu_bo_move+0x1bd/0x7a0
> > [   64.253605]  ttm_bo_handle_move_mem+0xcf/0x180
> > [   64.253612]  ttm_mem_evict_first+0x1c5/0x500
> > [   64.253618]  ttm_resource_manager_evict_all+0xa3/0x1e0
> > [   64.253626]  amdgpu_device_prepare+0x66/0x110
> > [   64.253634]  amdgpu_pmops_runtime_suspend+0xbe/0x1c0
> > [   64.253642]  pci_pm_runtime_suspend+0x74/0x200
> > [   64.253650]  vga_switcheroo_runtime_suspend+0x21/0xb0
> > [   64.253658]  __rpm_callback+0x5f/0x190
> > [   64.253664]  rpm_callback+0x7f/0x90
> > [   64.253671]  rpm_suspend+0x120/0x6a0
> > [   64.253677]  pm_runtime_work+0x9c/0xa0
> > [   64.253684]  process_one_work+0x164/0x330
> > [   64.253693]  worker_thread+0x302/0x430
> > [   64.253703]  kthread+0xe4/0x110
> > [   64.253711]  ret_from_fork+0x4c/0x60
> > [   64.253723]  ret_from_fork_asm+0x1b/0x30
> >
> > [   64.253735] CPU: 3 PID: 152 Comm: kworker/3:2 Tainted: P           O=
E      6.8.9 #3 e7323d0d25f89e853881fc823e59523bdcc577c6
> > [   64.253756] Hardware name: Hewlett-Packard HP Pavilion Notebook /80B=
9, BIOS F.54 05/27/2019
> > [   64.253761] Workqueue: pm pm_runtime_work
> > [   64.253771] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >
>
> --
> Regards/Gruss,
>     Boris.
>
> https://people.kernel.org/tglx/notes-about-netiquette
