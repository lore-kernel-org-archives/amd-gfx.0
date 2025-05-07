Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FA30C3ABBF
	for <amd-gfx@archiver.kernel.org>; Wed,  7 May 2025 19:06:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 279CB10E877;
	Wed,  7 May 2025 19:06:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="HYlievng";
	dkim-atps=neutral
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com
 [209.85.216.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E1EFB10E877
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 May 2025 19:06:33 +0000 (UTC)
Received: by mail-pj1-f50.google.com with SMTP id
 98e67ed59e1d1-30a7cf86d69so46177a91.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 07 May 2025 12:06:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1746644793; x=1747249593; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lBEw7znuSR1UYMlCV23n7PzTLqntC9rUPUuk1lMbpnM=;
 b=HYlievngBakjHfuh/txTXU4kkD4zSk7Xenu5ZzxO8E+Q266IryjBfl4143RANYQVc3
 A5kv8KB/VOh6ug/FBhzS81g1l82kNJtRnHjDpx9LKgJWLOT77fxSTOyuxyWRwAuCYVwV
 614nGMI65JgtvaomdscANmZ89F9O6VxlYOQO7NFvpLgTLwdoBgtqVJE+PR3V0mrLet1y
 rfU5MGLdALNd5vphma4FZ3GCC9tZkCBrPtIiH4Jt5sSoGWv2hTCCAprCBXI5oGmUiMLK
 Zl/WouQdxqsFLComz3A81DcJUX2dBuCn8Taq4Pn7JiMI/emH4VoM6cEcduKtwaee6fTI
 7jLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746644793; x=1747249593;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lBEw7znuSR1UYMlCV23n7PzTLqntC9rUPUuk1lMbpnM=;
 b=au13rtdho15Jrok+uMqceUjtXeTPz/4QFIHtKBffizqBMTco+D2rmBKaqnra1/FUoF
 vWsT1ZNqwyTYtIzrEKlX/yqkvTAUFfl3K3ljDlyys9fcwS2K+dP3tpGKa4Cqowzi4kse
 NB4i8XqHnN7e3mUPpawDcjPfkKa6sAyGfBCqyzUBEErjwhwHX/wvAK/ZEP4D4/NioRg6
 A3nNP53TX8Cs3AswsFx4T/dg6/JOIlTSSH3+bbs3tHgmHblPw0bL2Xh5IjdCvlgDPsoD
 3kYwyWsAq1u7ONLoaCvaHcZDvwFh2LHdt10OM61EBF1VKtbWnWWjsvZwHw/6+ZMiuuFL
 Wv9Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWGHBeKADXxpLKx59IOlhmqVDNaAO7q+23s8mjTWgbug8iV3n/sBVT330QAbBEv+cbw7rFVLm5u@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzCO6oGTQROTqm0AFGU4HtiJnY8z7Cg8+Q3KEtdL5dreMsl6thz
 VSLx93GH6uGT0eJcfMUUmdMc0VvKo1vJPRz4S+gJcIujAZ/dskod3+KtKNZZ+KRa654TupBH+5w
 NnWc/CvlxfsyoZKVkW54pkUb1F677t2n/
X-Gm-Gg: ASbGnctiroX5UIt8JLIhJGWuV6lmAFVEMRaHU4jRvNUiV8h5YugWanwhEt83X6aGbH0
 e4g3GikqAiWz+3XCOewodq7lBi8QGUaGQdM+4L8faAfP5AdAQs1hX31zgpgZU7jn5cIrCtSdXKY
 8nhP0wNdtCh852sInNUvOj4A==
X-Google-Smtp-Source: AGHT+IHgJTx0CsKOUjpUFEwQOv2an/+AMybAqn3DkRU534126d6d+4T5iXpBF3blfP9P0XWVr/tWPBS2yqNTiE2S8Eg=
X-Received: by 2002:a17:90b:4a4a:b0:305:5f31:6c63 with SMTP id
 98e67ed59e1d1-30aac22030bmr2856814a91.6.1746644793224; Wed, 07 May 2025
 12:06:33 -0700 (PDT)
MIME-Version: 1.0
References: <20250507183722.76789-1-Arvind.Yadav@amd.com>
In-Reply-To: <20250507183722.76789-1-Arvind.Yadav@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 7 May 2025 15:06:22 -0400
X-Gm-Features: ATxdqUG1JNd72tbiBeNcBni4uOHefOo24cz1E4fGVBuU6Eza2i6Q0h1vLaQ8tbQ
Message-ID: <CADnq5_N0m738JXJDzRkdZum=KteV_jTYixXQ4SCYGs-43NdhLg@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Fix NULL dereference in
 amdgpu_userq_restore_worker
To: Arvind Yadav <Arvind.Yadav@amd.com>
Cc: Christian.Koenig@amd.com, alexander.deucher@amd.com, sunil.khatri@amd.com, 
 amd-gfx@lists.freedesktop.org
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

On Wed, May 7, 2025 at 2:38=E2=80=AFPM Arvind Yadav <Arvind.Yadav@amd.com> =
wrote:
>
> Switch cancel_delayed_work() to cancel_delayed_work_sync() to ensure
> the delayed work has finished executing before proceeding with
> resource cleanup. This prevents a potential use-after-free or
> NULL dereference if the resume_work is still running during finalization.

There are several other places with similar patterns that look
suspect.  E.g., amdgpu_userq_destroy() and amdgpu_userq_evict().

Alex

>
> BUG: kernel NULL pointer dereference, address: 0000000000000140
> [  +0.000050] #PF: supervisor read access in kernel mode
> [  +0.000019] #PF: error_code(0x0000) - not-present page
> [  +0.000021] PGD 0 P4D 0
> [  +0.000015] Oops: Oops: 0000 [#1] PREEMPT SMP NOPTI
> [  +0.000021] CPU: 17 UID: 0 PID: 196299 Comm: kworker/17:0 Tainted: G   =
  U             6.14.0-org-staging #1
> [  +0.000032] Tainted: [U]=3DUSER
> [  +0.000015] Hardware name: Gigabyte Technology Co., Ltd. X570 AORUS ELI=
TE/X570 AORUS ELITE, BIOS F39 03/22/2024
> [  +0.000029] Workqueue: events amdgpu_userq_restore_worker [amdgpu]
> [  +0.000426] RIP: 0010:drm_exec_lock_obj+0x32/0x210 [drm_exec]
> [  +0.000025] Code: e5 41 57 41 56 41 55 49 89 f5 41 54 49 89 fc 48 83 ec=
 08 4c 8b 77 30 4d 85 f6 0f 85 c0 00 00 00 4c 8d 7f 08 48 39 77 38 74 54 <4=
9> 8b bd f8 00 00 00 4c 89 fe 41 f6 04 24 01 75 3c e8 08 50 bc e0
> [  +0.000046] RSP: 0018:ffffab1b04da3ce8 EFLAGS: 00010297
> [  +0.000020] RAX: 0000000000000001 RBX: ffff930cc60e4bc0 RCX: 0000000000=
000000
> [  +0.000025] RDX: 0000000000000004 RSI: 0000000000000048 RDI: ffffab1b04=
da3d88
> [  +0.000028] RBP: ffffab1b04da3d10 R08: ffff930cc60e4000 R09: 0000000000=
000000
> [  +0.000022] R10: ffffab1b04da3d18 R11: 0000000000000001 R12: ffffab1b04=
da3d88
> [  +0.000023] R13: 0000000000000048 R14: 0000000000000000 R15: ffffab1b04=
da3d90
> [  +0.000023] FS:  0000000000000000(0000) GS:ffff9313dea80000(0000) knlGS=
:0000000000000000
> [  +0.000024] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  +0.000021] CR2: 0000000000000140 CR3: 000000018351a000 CR4: 0000000000=
350ef0
> [  +0.000025] Call Trace:
> [  +0.000018]  <TASK>
> [  +0.000015]  ? show_regs+0x69/0x80
> [  +0.000022]  ? __die+0x25/0x70
> [  +0.000019]  ? page_fault_oops+0x15d/0x510
> [  +0.000024]  ? do_user_addr_fault+0x312/0x690
> [  +0.000024]  ? sched_clock_cpu+0x10/0x1a0
> [  +0.000028]  ? exc_page_fault+0x78/0x1b0
> [  +0.000025]  ? asm_exc_page_fault+0x27/0x30
> [  +0.000024]  ? drm_exec_lock_obj+0x32/0x210 [drm_exec]
> [  +0.000024]  drm_exec_prepare_obj+0x21/0x60 [drm_exec]
> [  +0.000021]  amdgpu_vm_lock_pd+0x22/0x30 [amdgpu]
> [  +0.000266]  amdgpu_userq_validate_bos+0x6c/0x320 [amdgpu]
> [  +0.000333]  amdgpu_userq_restore_worker+0x4a/0x120 [amdgpu]
> [  +0.000316]  process_one_work+0x189/0x3c0
> [  +0.000021]  worker_thread+0x2a4/0x3b0
> [  +0.000022]  kthread+0x109/0x220
> [  +0.000018]  ? __pfx_worker_thread+0x10/0x10
> [  +0.000779]  ? _raw_spin_unlock_irq+0x1f/0x40
> [  +0.000560]  ? __pfx_kthread+0x10/0x10
> [  +0.000543]  ret_from_fork+0x3c/0x60
> [  +0.000507]  ? __pfx_kthread+0x10/0x10
> [  +0.000515]  ret_from_fork_asm+0x1a/0x30
> [  +0.000515]  </TASK>
>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
> Cc: Sunil Khatri <sunil.khatri@amd.com>
> Signed-off-by: Arvind Yadav <arvind.yadav@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_userq.c
> index afbe01149ed3..711e190a6a82 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -774,7 +774,7 @@ void amdgpu_userq_mgr_fini(struct amdgpu_userq_mgr *u=
serq_mgr)
>         struct amdgpu_userq_mgr *uqm, *tmp;
>         uint32_t queue_id;
>
> -       cancel_delayed_work(&userq_mgr->resume_work);
> +       cancel_delayed_work_sync(&userq_mgr->resume_work);
>
>         mutex_lock(&userq_mgr->userq_mutex);
>         idr_for_each_entry(&userq_mgr->userq_idr, queue, queue_id) {
> --
> 2.34.1
>
