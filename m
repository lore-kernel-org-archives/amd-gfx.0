Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1E83CCA479
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Jun 2022 19:10:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1957410FF09;
	Tue, 28 Jun 2022 19:10:08 +0000 (UTC)
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com
 [IPv6:2001:4860:4864:20::30])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 31A9E10FF3C
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Jun 2022 19:10:07 +0000 (UTC)
Received: by mail-oa1-x30.google.com with SMTP id
 586e51a60fabf-101ab23ff3fso18376657fac.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Jun 2022 12:10:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fireburn-co-uk.20210112.gappssmtp.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Pw3HCDtO7OAHIHxCXnFBvO7kpjk6OPi4uer5YAajfoY=;
 b=YVQBBoqJ8ZNw4LW16y2szi3nhWK8l3JDEYfNcJiburpzn47Vv3uESvoOrQ6wvL/Qsa
 UhBK+djwc00d+BLt+KUvqfm7QzlBQWrGWLtsjZo8UR3Hm7Wx7qGJsCc1BmX1QwdQbvzO
 U1tcU29+4mKM8R/qdxfoBwohOLu4lqgOlCYWsk+Jo9J55U6YELIvQhBnFj9g4ANgzZyv
 YwPrXOIe2TgVPPrlN00nGGar/OYF9vxyF7aNE/ux2jhb+5cG04cMz+FyO30ntY3TkCFP
 T6mTwv+CqloLzUzx/VZSk3IXO4MGPuF6xQ1s9T4uHuGPXVE1YRRTm91GlZ00qmTQl/Uc
 4PAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Pw3HCDtO7OAHIHxCXnFBvO7kpjk6OPi4uer5YAajfoY=;
 b=OFEN4YOF3G3X5oaxC8QNpKKZWoZ1RUbTDgZnSBEs9JrJvgYNQMA9/ZsZxiW+Z6E/jn
 TMiJHx5WtLCmj/kHNXWIdR7J/F31886EkXVWFfsZ+S5rfeftUxwnTrnuA24hl27/bziI
 grLTOsKHjvtQ+CZtgNFSqDgQGNeGnqXz+4zRVLIQ2t/eKF3iY3ZynnDHXvLL9PFUmbLd
 pmMGurBdmaLbV/ZlDdCFVhMczIcIT2ZWYx7vDqRl+zTker2EK8wjK6aF0IqtQ2mDRQhM
 TPi2rrPASqhHBhMlsDTYMB+erDlUuCD2PwaSf7ycVRfLHmCHIpRs0DtnUi4OgMFnJdt+
 7EkQ==
X-Gm-Message-State: AJIora9Zs5vg7TLeGLtEftnP8DdMLwZfsI6Qmnsmm5EmfHsN155CMpux
 oNw/2XXo3/QEMXYdDl9Biz8V6LrGUlJIgR3tjXD1rw==
X-Google-Smtp-Source: AGRyM1vDGbPgsD08uGhq1FKQiQfhu40b+RsDyV/AKAc1Q49ktTn32617FH32ot/+G1sARuGAkpiLRAmFj7oi2Vtw/p8=
X-Received: by 2002:a05:6870:514e:b0:105:cdf1:f2b6 with SMTP id
 z14-20020a056870514e00b00105cdf1f2b6mr671009oak.148.1656443406353; Tue, 28
 Jun 2022 12:10:06 -0700 (PDT)
MIME-Version: 1.0
References: <20220408171911.601615-1-Pavle.Kotarac@amd.com>
 <20220408171911.601615-11-Pavle.Kotarac@amd.com>
In-Reply-To: <20220408171911.601615-11-Pavle.Kotarac@amd.com>
From: Mike Lothian <mike@fireburn.co.uk>
Date: Tue, 28 Jun 2022 20:09:55 +0100
Message-ID: <CAHbf0-GaCQSNyjSWfg7nOkhTq+U2AhNigL950goNTdN8ZEKABw@mail.gmail.com>
Subject: Re: [PATCH 10/20] drm/amd/display: Insert pulling smu busy status
 before sending another request
To: Pavle Kotarac <Pavle.Kotarac@amd.com>
Content-Type: text/plain; charset="UTF-8"
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
Cc: stylon.wang@amd.com, Charlene Liu <Charlene.Liu@amd.com>,
 Oliver Logush <oliver.logush@amd.com>, Sunpeng.Li@amd.com,
 Bhawanpreet.Lakha@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, amd-gfx@lists.freedesktop.org, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com, Harry.Wentland@amd.com,
 Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>, agustin.gutierrez@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hi

I'm seeing the following stack trace, I'm guessing due to the assert:

[    3.516409] ------------[ cut here ]------------
[    3.516412] WARNING: CPU: 1 PID: 1 at
drivers/gpu/drm/amd/amdgpu/../display/dc/clk_mgr/dcn21/rn_clk_mgr_vbios_smu.c:98
rn_vbios_smu_send_msg_with_param+0x3e/0xe0
[    3.516422] Modules linked in:
[    3.516425] CPU: 1 PID: 1 Comm: swapper/0 Not tainted 5.19.0-rc4-tip+ #3199
[    3.516428] Hardware name: ASUSTeK COMPUTER INC. ROG Strix
G513QY_G513QY/G513QY, BIOS G513QY.318 03/29/2022
[    3.516432] RIP: 0010:rn_vbios_smu_send_msg_with_param+0x3e/0xe0
[    3.516437] Code: f6 48 89 fb 48 8b 3b be 9b 62 01 00 48 c7 c2 02
bd 06 83 e8 44 c6 f0 ff 85 c0 75 12 bf c6 a7 00 00 e8 f6 9a b1 ff ff
c5 75 da <0f> 0b eb 05 83 f8 01 75 f7 48 8b 3b be 9b 62 01 00 48 c7 c1
3
c 86
[    3.516442] RSP: 0018:ffff88810026f628 EFLAGS: 00010202
[    3.516445] RAX: 00000000000000fe RBX: ffff8881058a3200 RCX: 0000000000000000
[    3.516447] RDX: 0000000000000000 RSI: ffff888105adbb80 RDI: ffff888104f80000
[    3.516450] RBP: 00000000fffcf2bf R08: ffff888110ca6800 R09: 7fc9117fffffffff
[    3.516452] R10: 0000000000000000 R11: ffffffff819bca10 R12: ffff888110cd0000
[    3.516454] R13: ffff888100cc2300 R14: 000000000000000d R15: 0000000000000001
[    3.516457] FS:  0000000000000000(0000) GS:ffff888fde440000(0000)
knlGS:0000000000000000
[    3.516460] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    3.516462] CR2: 0000000000000000 CR3: 00000000b360c000 CR4: 0000000000350ee0
[    3.516465] Call Trace:
[    3.516468]  <TASK>
[    3.516470]  ? rn_clk_mgr_construct+0x744/0x760
[    3.516475]  ? dc_clk_mgr_create+0x1f0/0x4f0
[    3.516478]  ? dc_create+0x43a/0x5c0
[    3.516481]  ? dm_hw_init+0x29a/0x2380
[    3.516485]  ? vprintk_emit+0x106/0x230
[    3.516488]  ? asm_sysvec_apic_timer_interrupt+0x1f/0x30
[    3.516492]  ? dev_vprintk_emit+0x152/0x179
[    3.516496]  ? smu_hw_init+0x255/0x290
[    3.516500]  ? amdgpu_device_ip_init+0x32a/0x4a0
[    3.516504]  ? amdgpu_device_init+0x1622/0x1bb0
[    3.516507]  ? pci_bus_read_config_word+0x35/0x50
[    3.516512]  ? amdgpu_driver_load_kms+0x14/0x150
[    3.516515]  ? amdgpu_pci_probe+0x1c0/0x3d0
[    3.516518]  ? pci_device_probe+0xd3/0x170
[    3.516520]  ? really_probe+0x13e/0x320
[    3.516523]  ? __driver_probe_device+0x91/0xd0
[    3.516525]  ? driver_probe_device+0x1a/0x160
[    3.516527]  ? __driver_attach+0xe6/0x1b0
[    3.516530]  ? bus_add_driver+0x16e/0x270
[    3.516533]  ? driver_register+0x85/0x120
[    3.516535]  ?
__initstub__kmod_gpu_sched__180_178_drm_sched_fence_slab_init6+0x3f/0x3f
[    3.516540]  ? do_one_initcall+0x100/0x290
[    3.516545]  ? do_initcall_level+0x8a/0xe8
[    3.516549]  ? do_initcalls+0x44/0x6b
[    3.516551]  ? kernel_init_freeable+0xc7/0x10d
[    3.516554]  ? rest_init+0xc0/0xc0
[    3.516558]  ? kernel_init+0x15/0x140
[    3.516561]  ? ret_from_fork+0x22/0x30
[    3.516564]  </TASK>
[    3.516565] ---[ end trace 0000000000000000 ]---

On Fri, 8 Apr 2022 at 18:27, Pavle Kotarac <Pavle.Kotarac@amd.com> wrote:
>
> From: Oliver Logush <oliver.logush@amd.com>
>
> [why]
> Make sure smu is not busy before sending another request, this is to
> prevent stress failures from MS.
>
> [how]
> Check to make sure the SMU fw busy signal is cleared before sending
> another request
>
> Reviewed-by: Charlene Liu <Charlene.Liu@amd.com>
> Reviewed-by: Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
> Acked-by: Pavle Kotarac <Pavle.Kotarac@amd.com>
> Signed-off-by: Oliver Logush <oliver.logush@amd.com>
> ---
>  .../drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr_vbios_smu.c    | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr_vbios_smu.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr_vbios_smu.c
> index 8161a6ae410d..30c6f9cd717f 100644
> --- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr_vbios_smu.c
> +++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr_vbios_smu.c
> @@ -94,6 +94,9 @@ static int rn_vbios_smu_send_msg_with_param(struct clk_mgr_internal *clk_mgr,
>  {
>         uint32_t result;
>
> +       result = rn_smu_wait_for_response(clk_mgr, 10, 200000);
> +       ASSERT(result == VBIOSSMC_Result_OK);
> +
>         /* First clear response register */
>         REG_WRITE(MP1_SMN_C2PMSG_91, VBIOSSMC_Status_BUSY);
>
> --
> 2.32.0
>
