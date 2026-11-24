Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A86A606A330
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Nov 2026 15:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qgwAyDRA
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 71B3910F756;
	Tue, 24 Nov 2026 15:55:00 +0000 (UTC)
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com
 [209.85.210.175])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E35F610F57A
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Nov 2026 13:01:30 +0000 (UTC)
Received: by mail-pf1-f175.google.com with SMTP id
 d2e1a72fcca58-8b904d10882so1733746b3a.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Nov 2026 05:01:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795525290; cv=none;
 d=google.com; s=arc-20260327;
 b=OfdnUKueJZkDf8/nU6D6QxNlXv/DSbBW4qqypWjtlkSntkmYas1v6TFhGzQk1nvQr4
 Jgu5qdkme6nT/LDU1rJEY4+Unmk+0tRUaQu5/Ma4OYYUT5xl+skviFKHifg5ShCHrKty
 q3bH19aSvRt0zYwEygAud4e+ZxzpsPU+chwJvnf64ELcKlC/q0fH7JWQkDvZ0bO2vQnR
 7chUNg3oEwbYd+iG0jPzFEk1TZblXZF5xlK7caMpoHcaDnETpHctwcTmaRxUnTwBjMnH
 BxKVi3dZWtBi0srnk6kkhqO+0nXzEuF9GZ5hXjyu9XZVto7mt/XsU+eJP5aPAAQ41ghb
 5f1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=E1/ABQVN2GPiKBoDWrNxt3rdTrNQNeVIinl1MUjuV88=;
 fh=GnJdj/jW9sgMA+2jXDY7kDjZwB12+pZYQ0QRt6e4irI=;
 b=DWHA+6LYWmy7xdl0mO5MOCjB9gl3Ko+NaVjUpKzlwwfNW3a0rqzoWoLIqaioa2mOgM
 N9o0i+Kh6QUlNgTOh+VXERczuI9b7Waxezd9U4N6mfCSaEcNwqgah9seX0swlYsHma+i
 VgUHw99eodLiWjy7AVryJXi0YcjipRRm4P85NTuTmTOzkQ1S0JQya1jza1PeQiQMROvy
 1xzzE5mIlwRHYL3EW+Ti+ux8EYHiNiXGce6pYAndUfQ+kXeL0dugagfpK28Xn/vPna0o
 Y+16mHgTTQ2xRSrJ6hYaOrHaancAf1352DXrLDzljhB0F/Kz6uc4kp02zxjxvF5Aqyi5
 mc4g==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795525290; x=1796130090; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=E1/ABQVN2GPiKBoDWrNxt3rdTrNQNeVIinl1MUjuV88=;
 b=qgwAyDRA7+qNu3K5v0raW/Zv2r5OQ92ZEPS893RXRv4v56imK6FlEXrccbFo8Q2w+r
 SGkVcOaHbzBWUkhSnqraFX1z5493Gy+ji/Fb4JUbJBPRfWH9VxT/EdVoZBncYsajIzrP
 InyDBNQvuayna4BIiPlC8zMONhicHXJY+mAVY4Mmv79TKnfDf8tMzmhIEFQkaRX41z6K
 RPVTbUPfS8KFr3s8vQTECj1DcyJG9PyDiURj8eGroXccq6SvfcONou59ovll7g9Cbg/W
 80rqy/WncU35W4SlWuBaa9VDG6KrXkUY5U6GNMC81M9byb1ysdbzZvnUBjh6id88/9Qr
 Hu4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795525290; x=1796130090;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=E1/ABQVN2GPiKBoDWrNxt3rdTrNQNeVIinl1MUjuV88=;
 b=ZjzZ0P0q4dSpmbb78k3LF7iilOCJ5HGPDvy8d+0/RfwT0fvnC6M23eEST/D3eSdfdA
 ttyD6EFDvzg44WeC791mIUzz9dy/iOuzoUtSBSlqiSDCpb6mIgpCgobPAW3EwPXgWpyX
 NQms9f/7bkBPPvgMkmewVjZ6m88jmT/O/tcUgh7z50gQUNmUCxvn2JNFGJt2igeubBED
 +ZmfHFYEZseffa8W4pLn+9FEh0mHMrUbjANzwzpyT2uqtPi7sk67+we/mFZ9STB7Gxxm
 uSl7XZS37oDaCoc8uSZIKpG3Vv5/5yTKTk+bYUvwngU3iAHIayZ/7FqAp1UMhOdcCMV7
 9qZg==
X-Forwarded-Encrypted: i=1;
 AL+hErHAF4C5I3irXOUYJbl72lNbuz95aY9UviB/mq/602yWiaLLT3tTOWvUj2wfY6a/mKHmO8UWUMAh@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8jYW0JBnaiSfqVYhoir8SVb2xO3j03fjBSO42vY+EbOqVJ6qhF
 8oaLKqtn0a7XCUN2E/sTOLWlzshPkRpuCBze1bvObY8Jf4TZGVTBquBo8v5OUVs0tvB//AQFNQf
 0QYiPwhJm9JHvKt3E6mxPfayYU4ttWXjnefeItHocQQ==
X-Gm-Gg: AZFdTZf4ORUV6RjvGBYlMiIg3JJIbq2Kw35o2WR9VeNokRKsNxq2KU7D1XnMp1mScjM
 DomgiHfmWFFFXbgn8r9w/dvGlWTEXVY/XKLG9QNuBDfeBvFTkMZLyN/KtVoIgiAPAD3ywxMdXm9
 Fv1nOu8W9cNRoY7ejhEU2L1Zk16+qfa6dh3gQW2qJFBWB2QNpJeMHmpspjQoA1SSHuPM0q0wwEl
 W5/u1iWo7U/sm+DjAuxsObBl3zZTX97ueCCmND5iZBk4POSlyjVJEGiTaeagnk2Ph6OoErNvttS
 otF6EfCx0bYDFA2qYYnuD5M4/zWLqIBNVS/hKYZu/5xt+IzFP/pQqNUMDvutw4deLDyXlbSGDWN
 RwKEJS/Ipo5ARFUGecP9Y+EqMK548nTyTH9mfG5w39SbXyfvAnSPl0xEfkrOh2xrul4bj0RXuoo
 ZdQmsjPJaNVT6CzGmMSct/EEPF
X-Received: by 2002:a05:6a21:7907:b0:3eb:ab88:cb81 with SMTP id
 adf61e73a8af0-4014ee4f137mr12244669637.69.1795525290034; Tue, 24 Nov 2026
 05:01:30 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <cover.1795482456.git.arisa.snowbell@gmail.com>
 <c896f5f9-fc3a-4eb9-b81d-a3a3cb1b37d5@amd.com>
In-Reply-To: <c896f5f9-fc3a-4eb9-b81d-a3a3cb1b37d5@amd.com>
From: Arisa Snowbell <arisa.snowbell@gmail.com>
Date: Tue, 24 Nov 2026 14:01:18 +0100
X-Gm-Features: Aa3M54petmu5PuToSPcfedN04snMW7oml_MWt5yNxmp-Vt7Ywh4NwZrdkdEsUdI
Message-ID: <CABpa4MCyCoFCiA51jaRHAd3de3TO7HXJ5U4-Hh5tpd36m_T0vg@mail.gmail.com>
Subject: Re: [PATCH 0/1] drm/amdgpu/userq: fix S3 suspend hang with user queues
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Mario Limonciello <mario.limonciello@amd.com>, "Prosyak,
 Vitaly" <Vitaly.Prosyak@amd.com>, "Khatri, Sunil" <Sunil.Khatri@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Tue, 24 Nov 2026 15:54:45 +0000
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
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Christian,

On 11/24/26, Christian K=C3=B6nig wrote:
> So I also have the question if you have encountered any other problems
> except suspend/resume?

Apart from the suspend hang, two things:

- "MES(1) failed to respond to msg=3DINVALIDATE_TLBS", like the one
  before the hang in the report. It has shown up a few times under
  different kinds of heavy load, also when nothing was using user
  queues, but I never saw it before I enabled amdgpu.user_queue=3D1. The
  desktop kept working each time.

- After S3 resume, a D3D12 game (Hunt: Showdown 1896 through
  vkd3d-proton) keeps running but renders wrong until it is restarted.
  It happens with kernel queues too, so it doesn't look like a user
  queue problem, though the artifacts look different with user queues.

Otherwise games and the desktop have run fine on user queues so far.
Maybe that's why there's so little feedback: it just works pretty well.

> In general the workqueue who executes the restore should been frozen
> during suspend, so evicting VRAM can then do it's work without
> userspace interfering.
[...]
> Or it could be that we are submitting the restore work to a
> non-freezeable workqeueu.

Oh I see, amdgpu_eviction_fence_suspend_worker() and
amdgpu_userq_ensure_ev_fence() queue resume_work with
schedule_delayed_work(), so it runs on system_wq. The stuck worker in
the dump shows "Workqueue: events amdgpu_userq_restore_worker", and the
eviction there comes from amdgpu_device_prepare(), which runs after
freeze_kernel_threads(), so a freezable workqueue would have held the
restore back.

I took a quick look and I think the patch can be simplified a lot. In
v1 I also claimed that hibernation calls dpm_prepare() before freezing
kernel threads, and that was the only reason for the extra flag. I'll
send a v2 that only moves the restore worker to system_freezable_wq.

One thing v1 also changed and v2 will leave alone: amdgpu_userq_resume()
maps the queues again even when the BOs of the process were evicted
before suspend, while only the restore worker validates them and
updates the page tables. With v2 nothing queues that restore at resume;
it runs with the next signal ioctl. Is it fine for the queues to run
before that, or should resume queue the restore instead of mapping?

Thanks,
Arisa

On Tue, Nov 24, 2026 at 1:15=E2=80=AFPM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
> Hi Arisa,
>
> On 11/24/26 03:32, Arisa Snowbell wrote:
> > Hi,
> >
> > I've been testing user queues on my RX 9070 XT (amdgpu.user_queue=3D1,
> > with AMD_USERQ=3D1 for everything I run through Steam) and came across =
a
> > suspend hang. After a few hours of uptime, S3 suspend sometimes never
> > finishes, and I have to reboot the machine by hand. What I see depends
> > on how the suspend started:
> >
> > - When the screen locks in parallel with the suspend, the machine
> >   freezes on the lock screen.
> > - When it locks first, the screens turn off and the suspend starts
> >   after that, the screens stay off; the machine looks asleep but never
> >   wakes up.
> >
> > Either way it never actually sleeps. Short sessions suspend and resume
> > fine.
>
> well first of all thanks a lot for testing user queues we haven't got muc=
h feedback so far.
>
> So I also have the question if you have encountered any other problems ex=
cept suspend/resume?
>
> > In short: while amdgpu_device_prepare() evicts VRAM for suspend, the
> > user queue restore worker starts and moves the same BOs back. One
> > restore worker got stuck waiting on a page table update fence while
> > holding the BO locks, and the suspend waited for those locks forever.
>
> Yeah we haven't tested suspend/resume with userqueues yet and I don't thi=
nk we have a test case for that.
>
> @Vitaly is that right? If yes we should probably create a test case.
>
> > The patch keeps the restore worker out of system sleep; the details are
> > in its commit message. It builds cleanly with W=3D1 against v7.4-rc4 an=
d
> > passes checkpatch. I'm running it now: S3 suspend and resume work, also
> > with a game on user queues running, which keeps running after resume,
> > so the restore worker maps the queues again. It hasn't seen enough long
> > sessions with suspends yet to show that the hang is gone, so I'm sendin=
g
> > it for review first and will report back once I have more runtime on
> > it.
>
> That approach looks a bit to complicated, in theory it should work out of=
 the box.
>
> In general the workqueue who executes the restore should been frozen duri=
ng suspend, so evicting VRAM can then do it's work without userspace interf=
ering.
>
> What could be is that Mario's work to evict VRAM before swapping is disab=
led somehow broke that.
>
> Or it could be that we are submitting the restore work to a non-freezeabl=
e workqeueu.
>
> Either way Sunil should probably take a look after he's back from vacatio=
n.
>
> Regards,
> Christian.
>
> >
> > System:
> >
> >   GPU:      RX 9070 XT, Navi 48 [1002:7550] rev c0, gfx12, MES fw 0x97
> >   Kernel:   7.4.0-rc4 (linux-mainline)
> >   Firmware: linux-firmware-amdgpu 20261019
> >   Mesa:     mesa-git 27.0.0_devel.234528.a54c80d04d3 (RADV)
> >   Options:  amdgpu ppfeaturemask=3D0xfff7ffff user_queue=3D1 runpm=3D0
> >
> > What I saw:
> >
> > The suspend started about 11 hours after boot and never finished. About
> > 4 hours later I pressed SysRq w, s and c, and efi-pstore kept the dump.
> > 22 tasks were blocked:
> >
> > - systemd-sleep, in ttm_bo_evict_first() waiting for a BO lock
> > - 3 amdgpu_userq_restore_worker: one waiting on a page table update
> >   fence, two waiting for its locks
> > - 12 amdgpu_tlb_fence_work, waiting on their page table update fences
> > - 5 ttm_bo_delayed_delete, waiting on BO fences
> >
> > All the workers except one TLB fence worker have higher PIDs than
> > systemd-sleep, so they started after the suspend did.
> >
> > The earlier suspends of that boot worked. The only amdgpu error before
> > the hang was one "MES(1) failed to respond to msg=3DINVALIDATE_TLBS"
> > about 1.5 hours before it; the desktop kept working after it, and I
> > don't know if it's related.
> >
> > systemd-sleep:
> >
> > [31192.858314] task:systemd-sleep   state:D stack:0     pid:466006 tgid=
:466006 ppid:1      task_flags:0x80400100 flags:0x00080800
> > [31192.858315] Call Trace:
> > [31192.858315]  <TASK>
> > [31192.858315]  __schedule+0x400/0x1770
> > [31192.858317]  schedule+0x28/0xa0
> > [31192.858317]  schedule_preempt_disabled+0x16/0x30
> > [31192.858318]  __ww_mutex_lock.constprop.0+0x7cb/0xd40
> > [31192.858320]  ttm_bo_evict_first+0x14e/0x240 [ttm]
> > [31192.858323]  ? __pfx_pci_pm_prepare+0x10/0x10
> > [31192.858325]  ttm_resource_manager_evict_all+0x55/0x220 [ttm]
> > [31192.858329]  amdgpu_device_evict_resources+0x32/0x80 [amdgpu]
> > [31192.858430]  amdgpu_device_prepare+0x2f/0xe0 [amdgpu]
> > [31192.858532]  ? amdgpu_pmops_prepare+0x5b/0xb0 [amdgpu]
> > [31192.858632]  pci_pm_prepare+0x33/0x80
> > [31192.858633]  dpm_prepare+0x187/0x4e0
> > [31192.858635]  dpm_suspend_start+0x1e/0x60
> > [31192.858636]  suspend_devices_and_enter+0x131/0x8b0
> > [31192.858638]  pm_suspend.cold+0x2bc/0x336
> > [31192.858639]  state_store+0x7f/0xf0
> > [31192.858640]  kernfs_fop_write_iter+0x16b/0x210
> > [31192.858642]  vfs_write+0x258/0x540
> > [31192.858644]  ksys_write+0x7b/0x110
> > [31192.858645]  do_syscall_64+0xce/0x580
> > [31192.858647]  ? do_user_addr_fault+0x235/0x760
> > [31192.858648]  ? do_syscall_64+0x35/0x580
> > [31192.858649]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> > [31192.858662]  </TASK>
> >
> > The stuck restore worker:
> >
> > [31192.862190] task:kworker/0:12    state:D stack:0     pid:466979 tgid=
:466979 ppid:2      task_flags:0x4208060 flags:0x00080000
> > [31192.862191] Workqueue: events amdgpu_userq_restore_worker [amdgpu]
> > [31192.862307] Call Trace:
> > [31192.862307]  <TASK>
> > [31192.862307]  __schedule+0x400/0x1770
> > [31192.862309]  schedule+0x28/0xa0
> > [31192.862310]  schedule_timeout+0xce/0x120
> > [31192.862311]  dma_fence_default_wait+0x19b/0x2f0
> > [31192.862312]  ? __pfx_dma_fence_default_wait_cb+0x10/0x10
> > [31192.862313]  dma_fence_wait_timeout+0xee/0x1b0
> > [31192.862314]  amdgpu_userq_vm_validate_and_restore_queue+0x702/0x990 =
[amdgpu]
> > [31192.862432]  amdgpu_userq_restore_worker+0xb3/0x1a0 [amdgpu]
> > [31192.862547]  process_one_work+0x1d6/0x3b0
> > [31192.862548]  worker_thread+0x1aa/0x310
> > [31192.862549]  ? __pfx_worker_thread+0x10/0x10
> > [31192.862550]  kthread+0xe9/0x120
> > [31192.862551]  ? __pfx_kthread+0x10/0x10
> > [31192.862551]  ret_from_fork+0x2a9/0x340
> > [31192.862552]  ? __pfx_kthread+0x10/0x10
> > [31192.862552]  ret_from_fork_asm+0x1a/0x30
> > [31192.862554]  </TASK>
> >
> > I can send the full pstore dump if it helps; the journal of that boot
> > has nothing beyond the MES timeout above. I'm also happy to test other
> > patches or collect more data.
> >
> > Thanks,
> > Arisa
> >
> > Arisa Snowbell (1):
> >   drm/amdgpu/userq: don't restore user queues during system sleep
> >
> >  drivers/gpu/drm/amd/amdgpu/amdgpu.h           |  1 +
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       | 13 +++-
> >  .../drm/amd/amdgpu/amdgpu_eviction_fence.c    |  2 +-
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c     | 64 ++++++++++++++++++-
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h     |  3 +
> >  5 files changed, 79 insertions(+), 4 deletions(-)
> >
> > --
> > 2.56.1
> >
>
