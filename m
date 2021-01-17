Return-Path: <SRS0=twpl=GV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDA7FC433E0
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Jan 2021 08:38:41 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 21A8922211
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Jan 2021 08:38:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21A8922211
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 65CE76E11F;
	Mon, 18 Jan 2021 08:38:40 +0000 (UTC)
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7BBB089C63
 for <amd-gfx@lists.freedesktop.org>; Sun, 17 Jan 2021 21:37:49 +0000 (UTC)
Received: from zn.tnic (p200300ec2f27cc00a436fd501b9f0f20.dip0.t-ipconnect.de
 [IPv6:2003:ec:2f27:cc00:a436:fd50:1b9f:f20])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id B15D61EC036C;
 Sun, 17 Jan 2021 22:37:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
 t=1610919465;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=tBjuK98joOluzEgrTB6iHYUjpVbsEniybo1aFtsR/CQ=;
 b=PbJkGQW+oHrSxQlC4obtD7kji9f6tqs2W2HzbFib7sF9CE4wz3hGH+pn+X4llo8L9zp9EM
 MxnGa6YsfBwOdSsaXvQ3hGLGXIfRK0uNJ1QSioQo/rbaJKqUNSyfmvZfPouJo6hk+WbvJj
 5r4DG7OIZZA4dA1UnfRxl6zpZ3f9azw=
Date: Sun, 17 Jan 2021 22:37:40 +0100
From: Borislav Petkov <bp@alien8.de>
To: amd-gfx@lists.freedesktop.org
Subject: [bugzilla-daemon@bugzilla.kernel.org: [Bug 211245] New: Fedora 33
 amdgpu print warning at boot]
Message-ID: <20210117213740.GA23592@zn.tnic>
MIME-Version: 1.0
Content-Disposition: inline
X-Mailman-Approved-At: Mon, 18 Jan 2021 08:38:38 +0000
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Forwarding by mail because I can't find the respective AMD GPU assignee
mail on bugzilla.k.o.

----- Forwarded message from bugzilla-daemon@bugzilla.kernel.org -----

Date: Sun, 17 Jan 2021 21:13:06 +0000
From: bugzilla-daemon@bugzilla.kernel.org
To: bp@alien8.de
Subject: [Bug 211245] New: Fedora 33 amdgpu print warning at boot
Message-ID: <bug-211245-6385@https.bugzilla.kernel.org/>

https://bugzilla.kernel.org/show_bug.cgi?id=211245

            Bug ID: 211245
           Summary: Fedora 33 amdgpu print warning at boot
           Product: Platform Specific/Hardware
           Version: 2.5
    Kernel Version: 5.10.7-200.fc33.x86_64
          Hardware: All
                OS: Linux
              Tree: Mainline
            Status: NEW
          Severity: normal
          Priority: P1
         Component: x86-64
          Assignee: platform_x86_64@kernel-bugs.osdl.org
          Reporter: aalsing@gmail.com
        Regression: No

Sorry for a non-descriptive bug report, but I have no idea what is going on
here, but I guess that it is better to report the error.

I get this in dmesg every time I boot

```
[   12.743879] ------------[ cut here ]------------
[   12.743958] WARNING: CPU: 15 PID: 465 at
drivers/gpu/drm/amd/amdgpu/../display/dc/dcn20/dcn20_resource.c:3240
dcn20_validate_bandwidth_fp+0x8d/0xd0 [amdgpu]
[   12.743959] Modules linked in: hid_logitech_hidpp hid_logitech_dj
hid_plantronics amdgpu iommu_v2 gpu_sched ttm drm_kms_helper cec drm
crct10dif_pclmul crc32_pclmul crc32c_intel igb nvme ccp ghash_clmulni_intel
nvme_core dca xhci_pci i2c_algo_bit xhci_pci_renesas wmi pinctrl_amd fuse
[   12.743971] CPU: 15 PID: 465 Comm: kworker/15:2 Not tainted
5.10.7-200.fc33.x86_64 #1
[   12.743972] Hardware name: To Be Filled By O.E.M. To Be Filled By
O.E.M./X570 Taichi, BIOS P3.61 11/06/2020
[   12.743985] Workqueue: events drm_mode_rmfb_work_fn [drm]
[   12.744058] RIP: 0010:dcn20_validate_bandwidth_fp+0x8d/0xd0 [amdgpu]
[   12.744071] Code: 00 7b 35 22 85 14 1f 00 00 75 2f 31 d2 f2 0f 11 85 58 26
00 00 48 89 ee 4c 89 e7 e8 9d f6 ff ff 89 c2 22 95 14 1f 00 00 75 30 <0f> 0b 48
89 9d 58 26 00 00 5b 5d 41 5c c3 75 c9 48 89 9d 58 26 00
[   12.744072] RSP: 0018:ffffbf15c07c7c40 EFLAGS: 00010246
[   12.744073] RAX: 0000000000000001 RBX: 4079400000000000 RCX:
00000000000007a6
[   12.744073] RDX: 0000000000000000 RSI: 590effd4489bae10 RDI:
000000000002f1a0
[   12.744074] RBP: ffff985fd1e40000 R08: ffff985fd25cb000 R09:
ffff985fd0370000
[   12.744074] R10: ffff985fd25cb000 R11: 0000000100000001 R12:
ffff985fd0370000
[   12.744075] R13: ffff985fcd1134e0 R14: ffff985fcef93000 R15:
ffff985fd1e40000
[   12.744076] FS:  0000000000000000(0000) GS:ffff9866cedc0000(0000)
knlGS:0000000000000000
[   12.744077] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   12.744077] CR2: 00007f899f98c56c CR3: 000000010c616000 CR4:
0000000000350ee0
[   12.744078] Call Trace:
[   12.744154]  dcn20_validate_bandwidth+0x24/0x40 [amdgpu]
[   12.744223]  dc_validate_global_state+0x2f2/0x390 [amdgpu]
[   12.744295]  amdgpu_dm_atomic_check+0xacf/0xbd0 [amdgpu]
[   12.744308]  drm_atomic_check_only+0x55a/0x7d0 [drm]
[   12.744321]  ? drm_connector_list_iter_next+0x81/0xb0 [drm]
[   12.744330]  drm_atomic_commit+0x13/0x50 [drm]
[   12.744341]  drm_framebuffer_remove+0x388/0x3f0 [drm]
[   12.744351]  drm_mode_rmfb_work_fn+0x4f/0x60 [drm]
[   12.744354]  process_one_work+0x1b6/0x350
[   12.744356]  worker_thread+0x1e8/0x3e0
[   12.744358]  ? process_one_work+0x350/0x350
[   12.744359]  kthread+0x11b/0x140
[   12.744360]  ? __kthread_bind_mask+0x60/0x60
[   12.744362]  ret_from_fork+0x22/0x30
[   12.744364] ---[ end trace 9e0cfbae2c7a2d73 ]---
```

$ uname -r
5.10.7-200.fc33.x86_64

-- 
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.

----- End forwarded message -----

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
