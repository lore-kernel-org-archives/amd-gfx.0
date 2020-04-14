Return-Path: <SRS0=Gn/P=56=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 709CCC2BA19
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Apr 2020 14:22:56 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4277C206D5
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Apr 2020 14:22:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bm94RCAK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4277C206D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1120A6E17C;
	Tue, 14 Apr 2020 14:22:56 +0000 (UTC)
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com
 [IPv6:2a00:1450:4864:20::443])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3B3636E17C
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Apr 2020 14:22:55 +0000 (UTC)
Received: by mail-wr1-x443.google.com with SMTP id h26so3138571wrb.7
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Apr 2020 07:22:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=7TpN2I/GfF9HKv/W8TrJ0mGN1400pXbUqxo8Pa4deR8=;
 b=Bm94RCAKN+WeYSd2RVFsaWEfFUUofCC7A41lIVW5mxS0+SwLDDYJabvFHrBpMxHEn5
 4Q2I56bHWdC70ZQJwu2AgJvuGBCLQnGZNGRXsB/wChBydm84vMYu513gz/RLTjOkM3M4
 CRKWxrfqRTZwe3upRxj2/DW8ffY8TmCjVxR9bzUFCo795NzYi7obwHHJXC01k8p6+9Q7
 tMewgKD9zJeSDcmwdkghxz+5E0ZX6arVGoy4xp9FDmflA/8BBiS8rFGDQxhy3EzRXhxK
 wrXDFQcTfRkjDBgGwGxSBhNMRcmrB2I89JoVWXckoDbgeTI3ThZOTA4BEjou8AgRo1oe
 huBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=7TpN2I/GfF9HKv/W8TrJ0mGN1400pXbUqxo8Pa4deR8=;
 b=QobY5N7YmT4TPMeyDBV2VQ/JqpI6kTkDJ0uIVjzJ6KJlUVGihn3G4XdbUqOuE/oQiJ
 g78p9leUJsTlDUuH7EtzkNVVo1yn8H4oo+0DikbYoH5qoFAvkwV/EnjhDU3WnViP5JSp
 BBRLxDMQj5c2AgwCvNR0Rx30ZdEZR6nJ/dJN5veI3xo3BCWDCbL77qWYS/0dWFX9O5g7
 NSimlk7yCnybMpKo+wbqKvYs6kf36SimjIN82QQzvaieyxT5tvqwaPIS1rOwcVrnIA6j
 g+Z4Zb1/IV/nBLRA9KjRvswTFd6PM3SBWy0PirPWZ5i1xbkEktiH4FJOaztb8nUZrQVR
 agkg==
X-Gm-Message-State: AGi0PuZDgMjyxSiM8+LflRufhaeQU6fxaJdOSOA4Uzh4u6ZvEyPxOQLo
 1DBbMKymnnrm0UEz1Lvvb6tHq0/FRHXOs312kWNxkQ==
X-Google-Smtp-Source: APiQypLtjWMlQ7GrzGSmsr0rqWr+6Kv21E2rWuqSrOccswBGNRP3GofUx23yL9/39fFkID0R8IixtVuYlDyNDNwKG9g=
X-Received: by 2002:a5d:6342:: with SMTP id b2mr10915237wrw.111.1586874173877; 
 Tue, 14 Apr 2020 07:22:53 -0700 (PDT)
MIME-Version: 1.0
References: <1586865913-11415-1-git-send-email-James.Zhu@amd.com>
In-Reply-To: <1586865913-11415-1-git-send-email-James.Zhu@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 14 Apr 2020 10:22:42 -0400
Message-ID: <CADnq5_M6g8tsrNdAmuZLGZsJ9PktZFXoSRV24RYBuxKSEQ=Jdg@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu/vcn: fix gfxoff issue
To: James Zhu <James.Zhu@amd.com>
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
Cc: James Zhu <jamesz@amd.com>, changzhu <Changfeng.Zhu@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Apr 14, 2020 at 8:05 AM James Zhu <James.Zhu@amd.com> wrote:
>
> Turn off gfxoff control when vcn is gated.
>
> Signed-off-by: James Zhu <James.Zhu@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> index dab34f6..aa9a7a5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> @@ -369,9 +369,11 @@ void amdgpu_vcn_ring_begin_use(struct amdgpu_ring *ring)
>         cancel_delayed_work_sync(&adev->vcn.idle_work);
>
>         mutex_lock(&adev->vcn.vcn_pg_lock);
> -       amdgpu_gfx_off_ctrl(adev, false);
> -       amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_VCN,
> -              AMD_PG_STATE_UNGATE);
> +       if (adev->vcn.cur_state == AMD_PG_STATE_GATE) {
> +               amdgpu_gfx_off_ctrl(adev, false);
> +               amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_VCN,
> +                      AMD_PG_STATE_UNGATE);
> +       }
>

Why are we touching gfxoff with VCN?  Was this a leftover from bring
up?  Can we just drop all of this gfxoff stuff from VCN handling?  I
don't see why there would be a dependency.

Alex

>         if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG)    {
>                 struct dpg_pause_state new_state;
> --
> 2.7.4
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
