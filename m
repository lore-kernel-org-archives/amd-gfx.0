Return-Path: <SRS0=ZtFC=PY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37247C433EF
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Nov 2021 08:41:00 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DCD7761252
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Nov 2021 08:40:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org DCD7761252
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zzywysm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 30033892AD;
	Fri,  5 Nov 2021 08:40:58 +0000 (UTC)
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com
 [IPv6:2607:f8b0:4864:20::733])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 895B26E10B
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Nov 2021 03:13:56 +0000 (UTC)
Received: by mail-qk1-x733.google.com with SMTP id bm28so7669072qkb.9
 for <amd-gfx@lists.freedesktop.org>; Thu, 04 Nov 2021 20:13:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zzywysm.com; s=google;
 h=from:content-transfer-encoding:mime-version:subject:date:references
 :to:in-reply-to:message-id;
 bh=79ZBW9jMPymvzXegHrf/XvBoh2ftN04xBl5UtAEVtp8=;
 b=S31CRdSw/1V1rxaqvk6uen0G/147mfMh8YzK1XsZwWyFEbCJOQ2wkN9RvMDGZ3jw4E
 meivH71fbxmOcPbNU907QJQhd+d7k0Vnzo4HGq80i1Z/w5NeD4LxvtVPqvpVSbdVnKoi
 i2rrRWWXm3LCs/3y6skq8t19c0phgrpJ2OOl8Yfx1qmibfJJneJ/P54auOFz9MmGH3rv
 0FtOLstyqApex2z3vdx3YMeT/i+KJftzgz3gpRT5i2vTpivD8s88+CtpfnrIlGqf4Sbp
 /BKT6CnurHj2yzWxHEFGXrBqaNR+O0aaOzVwrYuwuwa+XBKWjCj6qUHJRV1iTrm7mLon
 Jiuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:content-transfer-encoding:mime-version
 :subject:date:references:to:in-reply-to:message-id;
 bh=79ZBW9jMPymvzXegHrf/XvBoh2ftN04xBl5UtAEVtp8=;
 b=3eK6ywlFd0qc8iDdI5isiHHDg49oiBcr0zafFNsSAOS7X/uhBQF6E8Pg1jni6mTpBU
 BoOT12Pp8QNdsbBj1H9TZhH51W1Q0UzogtXPX6YMC1pdEoE7qcFq1VJCaN7zq9Qw/JjT
 sc4PtpqcJb3R1XLJ8uvHvX/f1OYpB9jncMeaciLgpAR89TltwkqixSqn2WjIRLfBTVQw
 ewqhslU+0/yJOHfyUpLfLMM+riakWaOT6UUmURtGfCRKcJ0BIOSIG+8fPDit79y1ufQP
 4YBni9OO/l22lbFVd3V0sAXRc4c3GEFM6lgU+6k7gFtFIW8H3VUTVVliieuofLB1osrT
 q7mg==
X-Gm-Message-State: AOAM533yZ5qCZblJ88f+Gwid4se32t/6noU8s8kdBqaGpZVH8ZD/PSKE
 uRyDwEatky+nZehOryjBkKD4Ubtj8PoNkAIk
X-Google-Smtp-Source: ABdhPJxt6hmcwkndpZDNmcAAKDlQCA9WPtW7XpqY0mv814E5bD2DfwSBRAdtCg/L79ypkS6HLd7pfQ==
X-Received: by 2002:a05:620a:2449:: with SMTP id
 h9mr2754106qkn.119.1636082035384; 
 Thu, 04 Nov 2021 20:13:55 -0700 (PDT)
Received: from [10.99.0.16] ([136.144.58.108])
 by smtp.gmail.com with ESMTPSA id 76sm3907573qkn.77.2021.11.04.20.13.54
 for <amd-gfx@lists.freedesktop.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 04 Nov 2021 20:13:55 -0700 (PDT)
From: Zzy Wysm <zzy@zzywysm.com>
Content-Type: text/plain;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.7\))
Subject: Re: Kernel WARNING at 
Date: Thu, 4 Nov 2021 23:13:54 -0400
References: <3253FEEC-4FF1-48A5-B14B-9005052111BE@zzywysm.com>
To: amd-gfx@lists.freedesktop.org
In-Reply-To: <3253FEEC-4FF1-48A5-B14B-9005052111BE@zzywysm.com>
Message-Id: <8A927DC6-6EF9-4A73-BC2D-CC45BAEB3F4A@zzywysm.com>
X-Mailer: Apple Mail (2.3608.120.23.2.7)
X-Mailman-Approved-At: Fri, 05 Nov 2021 08:40:56 +0000
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

Another use-after-free on the same computer that looks like it=E2=80=99s =
in amdgpu:

[ 2101.168138] ------------[ cut here ]------------
[ 2101.168144] refcount_t: underflow; use-after-free.
[ 2101.168162] WARNING: CPU: 4 PID: 965 at lib/refcount.c:28 =
refcount_warn_saturate+0xa6/0xf0
[ 2101.168167] CPU: 4 PID: 965 Comm: Xorg Tainted: G                T =
5.10.77 #1
[ 2101.168169] Hardware name: Supermicro Super Server/H11SSL-NC, BIOS =
2.1 02/21/2020
[ 2101.168174] RIP: 0010:refcount_warn_saturate+0xa6/0xf0
[ 2101.168177] Code: 05 9f 6b f3 01 01 e8 4a 0d 9d 00 0f 0b c3 80 3d 8d =
6b f3 01 00 75 95 48 c7 c7 e0 ee fc ad c6 05 7d 6b f3 01 01 e8 2b 0d 9d =
00 <0f> 0b c3 80 3d 6c 6b f3 01 00 0f 85 72 ff ff ff 48 c7 c7 38 ef fc
[ 2101.168180] RSP: 0018:ffffb3778216fdc0 EFLAGS: 00010282
[ 2101.168183] RAX: 0000000000000000 RBX: 0000000000000000 RCX: =
0000000000000027
[ 2101.168186] RDX: 0000000000000027 RSI: 00000000fffeffff RDI: =
ffff8ddb4e212ec8
[ 2101.168187] RBP: ffff8dbdf149f680 R08: ffff8ddb4e212ec0 R09: =
ffffb3778216fbe8
[ 2101.168189] R10: 0000000000000001 R11: 0000000000000001 R12: =
00000000ffffffff
[ 2101.168191] R13: ffff8dbca0b50c00 R14: ffff8dbca0b50c58 R15: =
0000000000000000
[ 2101.168194] FS:  000071af94f3fa40(0000) GS:ffff8ddb4e200000(0000) =
knlGS:0000000000000000
[ 2101.168196] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 2101.168198] CR2: 000071af0c7a9000 CR3: 00000015680a2000 CR4: =
0000000000350ee0
[ 2101.168199] Call Trace:
[ 2101.168206]  dma_resv_list_free.part.0+0x66/0x70
[ 2101.168212]  drm_gem_object_release+0x28/0x50
[ 2101.168218]  amdgpu_bo_destroy+0x60/0x100
[ 2101.168223]  ttm_bo_release+0x1de/0x310
[ 2101.168226]  amdgpu_bo_unref+0x15/0x20
[ 2101.168230]  amdgpu_gem_object_free+0x2b/0x50
[ 2101.168236]  drm_gem_dmabuf_release+0x31/0x50
[ 2101.168239]  dma_buf_release+0x35/0x70
[ 2101.168244]  __dentry_kill+0xe5/0x150
[ 2101.168249]  __fput+0xe1/0x250
[ 2101.168254]  task_work_run+0x5a/0x90
[ 2101.168260]  exit_to_user_mode_prepare+0xbe/0xc0
[ 2101.168266]  syscall_exit_to_user_mode+0x22/0xf0
[ 2101.168271]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[ 2101.168274] RIP: 0033:0x71af953aacc7
[ 2101.168278] Code: 00 00 00 48 8b 05 c9 91 0c 00 64 c7 00 26 00 00 00 =
48 c7 c0 ff ff ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 b8 10 00 00 00 0f =
05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 99 91 0c 00 f7 d8 64 89 01 48
[ 2101.168280] RSP: 002b:00007ffd1fbd3628 EFLAGS: 00000246 ORIG_RAX: =
0000000000000010
[ 2101.168284] RAX: 0000000000000000 RBX: 00007ffd1fbd3660 RCX: =
000071af953aacc7
[ 2101.168286] RDX: 00007ffd1fbd3660 RSI: 0000000040086409 RDI: =
0000000000000010
[ 2101.168288] RBP: 0000000040086409 R08: 0000000000000007 R09: =
000000000000000e
[ 2101.168290] R10: 000000000000001b R11: 0000000000000246 R12: =
0000561c5b999b98
[ 2101.168292] R13: 0000000000000010 R14: 0000561c5ba2b72c R15: =
00007ffd1fbd36a0
[ 2101.168295] ---[ end trace 921c49c63d8e1053 ]=E2=80=94

zzy


> On Nov 4, 2021, at 9:34 PM, Zzy Wysm <zzy@zzywysm.com> wrote:
>=20
> I found the following warning in my log this evening.  I don=E2=80=99t =
know if or how it can be reproduced.
>=20
> Linux 5.10.77 amd64.  Kernel config attached.  (The kernel taint is =
merely because of the struct randomization plugin.)
>=20
> zzy
>=20
> ..
>=20
> kernel: ------------[ cut here ]------------
> kernel: refcount_t: addition on 0; use-after-free.
> kernel: WARNING: CPU: 3 PID: 957 at lib/refcount.c:25 =
refcount_warn_saturate+0x68/0xf0
> kernel: CPU: 3 PID: 957 Comm: Xorg Tainted: G        W       T 5.10.77 =
#1
> kernel: Hardware name: Supermicro Super Server/H11SSL-NC, BIOS 2.1 =
02/21/2020
> kernel: RIP: 0010:refcount_warn_saturate+0x68/0xf0
> kernel: Code: 05 2c 9f f5 01 01 e8 83 82 9e 00 0f 0b c3 80 3d 1c 9f f5 =
01 00 75 d3 48 c7 c7 f0 2e 1d 96 c6 05 0c 9f f5 01 01 e8 64 82 9e 00 =
<0f> 0b c3 80 3d ff 9e f5 01 00 75 d3 48 c7 c7 f0 2e 1d 96 c6 05 0c 9f =
f5 01 01 e8 64 82 9e 00 <0f> 0b c3 80 3d ff 9e f5 01 00 75 b4 48 c7 c7 =
c8 2e 1d 96 c6 05 ef
> kernel: RSP: 0018:ffffb4f201cc3c00 EFLAGS: 00010286
> kernel: RAX: 0000000000000000 RBX: ffff8a0c00ede458 RCX: =
0000000000000027
> kernel: RDX: 0000000000000027 RSI: 00000000fffeffff RDI: =
ffff8a2ace192e88
> kernel: RBP: ffffb4f201cc3d38 R08: ffff8a2ace192e80 R09: =
ffffb4f201cc3a28
> kernel: R10: 0000000000000001 R11: 0000000000000001 R12: =
ffff8a0c911e5000
> kernel: R13: ffff8a0cba1fc580 R14: ffffb4f201cc3cc8 R15: =
ffff8a0c1a440000
> kernel: FS:  0000000000000000(0000) GS:ffff8a2ace180000(0000) =
knlGS:0000000000000000
> kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> kernel: CR2: 0000736ef80ab660 CR3: 00000011da80c000 CR4: =
0000000000350ee0
> kernel: Call Trace:
> kernel:  dma_resv_add_shared_fence+0x122/0x180
> kernel:  amdgpu_gem_object_close+0x1c3/0x250
> kernel:  drm_gem_object_release_handle+0x2b/0x90
> kernel:  ? drm_gem_object_handle_put_unlocked+0xc0/0xc0
> kernel:  idr_for_each+0x70/0xe0
> kernel:  drm_gem_release+0x17/0x20
> kernel:  drm_file_free.part.0+0x273/0x280
> kernel:  drm_release+0x60/0xe0
> kernel:  __fput+0x96/0x240
> kernel:  task_work_run+0x5a/0x90
> kernel:  do_exit+0x34e/0xaf0
> kernel:  do_group_exit+0x34/0xb0
> kernel:  __x64_sys_exit_group+0xf/0x10
> kernel:  do_syscall_64+0x33/0x40
> kernel:  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> kernel: RIP: 0033:0x736f1c33a699
> kernel: Code: Unable to access opcode bytes at RIP 0x736f1c33a66f.
> kernel: RSP: 002b:00007ffce40b21e8 EFLAGS: 00000246 ORIG_RAX: =
00000000000000e7
> kernel: RAX: ffffffffffffffda RBX: 0000736f1c42f610 RCX: =
0000736f1c33a699
> kernel: RDX: 000000000000003c RSI: 00000000000000e7 RDI: =
0000000000000000
> kernel: RBP: 0000000000000000 R08: fffffffffffffc80 R09: =
0000000000000000
> kernel: R10: 0000736f1cdbaa40 R11: 0000000000000246 R12: =
0000736f1c42f610
> kernel: R13: 0000000000000b14 R14: 0000736f1c42fae8 R15: =
0000000000000000
> kernel: ---[ end trace 52a8b244b766437f ]=E2=80=94
>=20
> ..
>=20
> <kernel-warning-config>
>=20

