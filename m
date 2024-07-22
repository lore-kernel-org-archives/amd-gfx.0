Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CA7CC3DA5D
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Jul 2024 08:20:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D881189321;
	Mon, 22 Jul 2024 08:20:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="R7ieokFH";
	dkim-atps=neutral
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com
 [209.85.128.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E40FA89321
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Jul 2024 08:20:49 +0000 (UTC)
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-426526d30aaso30148775e9.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Jul 2024 01:20:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1721636448; x=1722241248; darn=lists.freedesktop.org;
 h=in-reply-to:from:content-language:references:to:subject:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=sfYvH02SOak2/ITQpmxFlX0FRXLy2rILFtiVgF4HiDc=;
 b=R7ieokFHM3kmR+yqga2OKR9kUYBBazMYHtvEsoAqVu3F16G+wz7B0p44aMeMFeIlXk
 sO6vp0nngRHCvrjoRPBMw32Jd0UXspld8GhBnbM7TO9+TngZScdBj7EFYzcoIL/9thi5
 1svM6cLnOO+PFboSKJWsp6Ghfsi9bRJreXhcTCxzIqseop28ZyM1GGsXmIpy9tTVA3Q7
 Lx+DR1BsR5lmnWENqgeD3QgF5XVhlqXxDWNXy7FUCjP8URBC7747FspaN7w8fgNXumov
 XX9pJ/hcg/eVpFsXO7JYdsxYwlzQHoH0CTm7uTEVFveA2sN/K9JqYo5sVO4Xt6S+T0a8
 QMvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721636448; x=1722241248;
 h=in-reply-to:from:content-language:references:to:subject:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=sfYvH02SOak2/ITQpmxFlX0FRXLy2rILFtiVgF4HiDc=;
 b=H4V6vrdP7H3i7P/4MluAzFag2247uRtPViJBvhPDfZhBUoyTrGkHf11O5kzc7aEOUz
 GsQcgc41vQz8rKsAgcrNFKkOAYzz/TiZwtxfLClhwx9W75Z24OOB1Ew6W+gPOzumyVW5
 cDKgHz1Eg+IGEfYEdSpQzY7PHrq+rLwVgtYKsAgpVWuldbScMDz5bi/N+FZJSpSefx53
 +h2ZCM0b1yA5w4SROzyvt1CtmgCSkjMCoTBDeqgq7KiuwVMQkAaASZTdYfPl1qzuFasg
 2AJIxFmL8vqOHmGq4zPQA17pNyFORLHWVK5QOFHIJjqFfqo4JDROxQUfOl3ppvuwFi2B
 ni2Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWAXD22uvOaPLLvX4Bmalbk+aaoJOyIxt+3pq3kMmKyqr8P06bDCH4Qkt3rjttNyY/+2SeZcyMhiso+zSZTPOmd2hKlFb8KZC9sGJ/GDg==
X-Gm-Message-State: AOJu0YzNqmZ8fWRospBuSz6iKed05SFqxaaJb7BPRjK9Z+/mTx7Of4/F
 bVz4ttMCpY93aHfXYtdSKN1Nb5pvw8EgcdHHrSqwV7dZ1K+hOa7E
X-Google-Smtp-Source: AGHT+IH5GbqvXN2QozO5vA/ACLfvV3r11OIQ/6PYLyiFYKUOjuQmlbf+MsT2ZAeL3k8wa2Btij7r3A==
X-Received: by 2002:a05:600c:1550:b0:426:5cdf:2674 with SMTP id
 5b1f17b1804b1-427dc51a073mr39452395e9.4.1721636447350; 
 Mon, 22 Jul 2024 01:20:47 -0700 (PDT)
Received: from [10.254.108.81] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-368786944c8sm7786418f8f.54.2024.07.22.01.20.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 Jul 2024 01:20:46 -0700 (PDT)
Content-Type: multipart/alternative;
 boundary="------------Q0amzg4GUnZMtc0JlovGnSCi"
Message-ID: <92f00b1c-79c2-431b-b8dc-70070a65b14a@gmail.com>
Date: Mon, 22 Jul 2024 10:20:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu/mes: fix mes ring buffer overflow
To: "Xiao, Jack" <Jack.Xiao@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>
References: <20240719091615.1534436-1-Jack.Xiao@amd.com>
 <bfca2c44-9e40-4e04-bfcf-1285b3552707@gmail.com>
 <PH8PR12MB68417B9F856C92BD02912A08EFA82@PH8PR12MB6841.namprd12.prod.outlook.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <PH8PR12MB68417B9F856C92BD02912A08EFA82@PH8PR12MB6841.namprd12.prod.outlook.com>
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

This is a multi-part message in MIME format.
--------------Q0amzg4GUnZMtc0JlovGnSCi
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Thx, but in that case this patch here then won't help either it just 
mitigates the problem.

Can you try to reduce num_hw_submission for the MES ring?

Thanks,
Christian.

Am 22.07.24 um 05:27 schrieb Xiao, Jack:
>
> [AMD Official Use Only - AMD Internal Distribution Only]
>
>
> />> I think we rather need to increase the MES ring size instead./
>
> Unfortunately, it doesn't work. I guess mes firmware has limitation.
>
> Regards,
> Jack
>
> ------------------------------------------------------------------------
> *From:* Christian König <ckoenig.leichtzumerken@gmail.com>
> *Sent:* Friday, 19 July 2024 23:44
> *To:* Xiao, Jack <Jack.Xiao@amd.com>; amd-gfx@lists.freedesktop.org 
> <amd-gfx@lists.freedesktop.org>; Deucher, Alexander 
> <Alexander.Deucher@amd.com>
> *Subject:* Re: [PATCH] drm/amdgpu/mes: fix mes ring buffer overflow
> Am 19.07.24 um 11:16 schrieb Jack Xiao:
> > wait memory room until enough before writing mes packets
> > to avoid ring buffer overflow.
> >
> > Signed-off-by: Jack Xiao <Jack.Xiao@amd.com>
> > ---
> >   drivers/gpu/drm/amd/amdgpu/mes_v11_0.c | 18 ++++++++++++++----
> >   drivers/gpu/drm/amd/amdgpu/mes_v12_0.c | 18 ++++++++++++++----
> >   2 files changed, 28 insertions(+), 8 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c 
> b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> > index 8ce51b9236c1..68c74adf79f1 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> > @@ -168,7 +168,7 @@ static int 
> mes_v11_0_submit_pkt_and_poll_completion(struct amdgpu_mes *mes,
> >        const char *op_str, *misc_op_str;
> >        unsigned long flags;
> >        u64 status_gpu_addr;
> > -     u32 status_offset;
> > +     u32 seq, status_offset;
> >        u64 *status_ptr;
> >        signed long r;
> >        int ret;
> > @@ -196,6 +196,13 @@ static int 
> mes_v11_0_submit_pkt_and_poll_completion(struct amdgpu_mes *mes,
> >        if (r)
> >                goto error_unlock_free;
> >
> > +     seq = ++ring->fence_drv.sync_seq;
> > +     r = amdgpu_fence_wait_polling(ring,
> > +                                   seq - 
> ring->fence_drv.num_fences_mask,
> > +                                   timeout);
> > +     if (r < 1)
> > +             goto error_undo;
> > +
> >        api_status = (struct MES_API_STATUS *)((char *)pkt + 
> api_status_off);
> >        api_status->api_completion_fence_addr = status_gpu_addr;
> >        api_status->api_completion_fence_value = 1;
> > @@ -208,8 +215,7 @@ static int 
> mes_v11_0_submit_pkt_and_poll_completion(struct amdgpu_mes *mes,
> >        mes_status_pkt.header.dwsize = API_FRAME_SIZE_IN_DWORDS;
> > mes_status_pkt.api_status.api_completion_fence_addr =
> >                ring->fence_drv.gpu_addr;
> > - mes_status_pkt.api_status.api_completion_fence_value =
> > -             ++ring->fence_drv.sync_seq;
> > + mes_status_pkt.api_status.api_completion_fence_value = seq;
> >
> >        amdgpu_ring_write_multiple(ring, &mes_status_pkt,
> > sizeof(mes_status_pkt) / 4);
> > @@ -229,7 +235,7 @@ static int 
> mes_v11_0_submit_pkt_and_poll_completion(struct amdgpu_mes *mes,
> >                dev_dbg(adev->dev, "MES msg=%d was emitted\n",
> >                        x_pkt->header.opcode);
> >
> > -     r = amdgpu_fence_wait_polling(ring, ring->fence_drv.sync_seq, 
> timeout);
> > +     r = amdgpu_fence_wait_polling(ring, seq, timeout);
> >        if (r < 1 || !*status_ptr) {
> >
> >                if (misc_op_str)
> > @@ -252,6 +258,10 @@ static int 
> mes_v11_0_submit_pkt_and_poll_completion(struct amdgpu_mes *mes,
> >        amdgpu_device_wb_free(adev, status_offset);
> >        return 0;
> >
> > +error_undo:
> > +     dev_err(adev->dev, "MES ring buffer is full.\n");
> > +     amdgpu_ring_undo(ring);
> > +
> >   error_unlock_free:
> > spin_unlock_irqrestore(&mes->ring_lock, flags);
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c 
> b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
> > index c9f74231ad59..48e01206bcc4 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
> > @@ -154,7 +154,7 @@ static int 
> mes_v12_0_submit_pkt_and_poll_completion(struct amdgpu_mes *mes,
> >        const char *op_str, *misc_op_str;
> >        unsigned long flags;
> >        u64 status_gpu_addr;
> > -     u32 status_offset;
> > +     u32 seq, status_offset;
> >        u64 *status_ptr;
> >        signed long r;
> >        int ret;
> > @@ -182,6 +182,13 @@ static int 
> mes_v12_0_submit_pkt_and_poll_completion(struct amdgpu_mes *mes,
> >        if (r)
> >                goto error_unlock_free;
> >
> > +     seq = ++ring->fence_drv.sync_seq;
> > +     r = amdgpu_fence_wait_polling(ring,
> > +                                   seq - 
> ring->fence_drv.num_fences_mask,
>
> That's what's amdgpu_fence_emit_polling() does anyway.
>
> So this here just moves the polling a bit earlier.
>
> I think we rather need to increase the MES ring size instead.
>
> Regards,
> Christian.
>
>
> > +                                   timeout);
> > +     if (r < 1)
> > +             goto error_undo;
> > +
> >        api_status = (struct MES_API_STATUS *)((char *)pkt + 
> api_status_off);
> >        api_status->api_completion_fence_addr = status_gpu_addr;
> >        api_status->api_completion_fence_value = 1;
> > @@ -194,8 +201,7 @@ static int 
> mes_v12_0_submit_pkt_and_poll_completion(struct amdgpu_mes *mes,
> >        mes_status_pkt.header.dwsize = API_FRAME_SIZE_IN_DWORDS;
> > mes_status_pkt.api_status.api_completion_fence_addr =
> >                ring->fence_drv.gpu_addr;
> > - mes_status_pkt.api_status.api_completion_fence_value =
> > -             ++ring->fence_drv.sync_seq;
> > + mes_status_pkt.api_status.api_completion_fence_value = seq;
> >
> >        amdgpu_ring_write_multiple(ring, &mes_status_pkt,
> > sizeof(mes_status_pkt) / 4);
> > @@ -215,7 +221,7 @@ static int 
> mes_v12_0_submit_pkt_and_poll_completion(struct amdgpu_mes *mes,
> >                dev_dbg(adev->dev, "MES msg=%d was emitted\n",
> >                        x_pkt->header.opcode);
> >
> > -     r = amdgpu_fence_wait_polling(ring, ring->fence_drv.sync_seq, 
> timeout);
> > +     r = amdgpu_fence_wait_polling(ring, seq, timeout);
> >        if (r < 1 || !*status_ptr) {
> >
> >                if (misc_op_str)
> > @@ -238,6 +244,10 @@ static int 
> mes_v12_0_submit_pkt_and_poll_completion(struct amdgpu_mes *mes,
> >        amdgpu_device_wb_free(adev, status_offset);
> >        return 0;
> >
> > +error_undo:
> > +     dev_err(adev->dev, "MES ring buffer is full.\n");
> > +     amdgpu_ring_undo(ring);
> > +
> >   error_unlock_free:
> > spin_unlock_irqrestore(&mes->ring_lock, flags);
> >
>

--------------Q0amzg4GUnZMtc0JlovGnSCi
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    Thx, but in that case this patch here then won't help either it just
    mitigates the problem.<br>
    <br>
    Can you try to reduce num_hw_submission for the MES ring?<br>
    <br>
    Thanks,<br>
    Christian.<br>
    <br>
    <div class="moz-cite-prefix">Am 22.07.24 um 05:27 schrieb Xiao,
      Jack:<br>
    </div>
    <blockquote type="cite"
cite="mid:PH8PR12MB68417B9F856C92BD02912A08EFA82@PH8PR12MB6841.namprd12.prod.outlook.com">
      <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
      <style type="text/css" style="display:none;">P {margin-top:0;margin-bottom:0;}</style>
      <p
style="font-family:Calibri;font-size:10pt;color:#0000FF;margin:5pt;font-style:normal;font-weight:normal;text-decoration:none;"
        align="Left">
        [AMD Official Use Only - AMD Internal Distribution Only]<br>
      </p>
      <br>
      <div>
        <div class="elementToProof"
style="font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
          <i>&gt;&gt; I think we rather need to increase the MES ring
            size instead.</i></div>
        <div class="elementToProof"
style="font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
          <br>
        </div>
        <div class="elementToProof"
style="font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
          Unfortunately, it doesn't work. I guess mes firmware has
          limitation.</div>
        <div class="elementToProof"
style="font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
          <br>
        </div>
        <div class="elementToProof"
style="font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
          Regards,</div>
        <div class="elementToProof"
style="font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
          Jack</div>
        <div class="elementToProof"
style="font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
          <br>
        </div>
        <hr style="display:inline-block;width:98%" tabindex="-1">
        <div id="divRplyFwdMsg" dir="ltr"><font style="font-size:11pt"
            face="Calibri, sans-serif" color="#000000"><b>From:</b>
            Christian König <a class="moz-txt-link-rfc2396E" href="mailto:ckoenig.leichtzumerken@gmail.com">&lt;ckoenig.leichtzumerken@gmail.com&gt;</a><br>
            <b>Sent:</b> Friday, 19 July 2024 23:44<br>
            <b>To:</b> Xiao, Jack <a class="moz-txt-link-rfc2396E" href="mailto:Jack.Xiao@amd.com">&lt;Jack.Xiao@amd.com&gt;</a>;
            <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.org</a>
            <a class="moz-txt-link-rfc2396E" href="mailto:amd-gfx@lists.freedesktop.org">&lt;amd-gfx@lists.freedesktop.org&gt;</a>; Deucher, Alexander
            <a class="moz-txt-link-rfc2396E" href="mailto:Alexander.Deucher@amd.com">&lt;Alexander.Deucher@amd.com&gt;</a><br>
            <b>Subject:</b> Re: [PATCH] drm/amdgpu/mes: fix mes ring
            buffer overflow</font>
          <div> </div>
        </div>
        <div class="BodyFragment"><font size="2"><span
              style="font-size:11pt;">
              <div class="PlainText">Am 19.07.24 um 11:16 schrieb Jack
                Xiao:<br>
                &gt; wait memory room until enough before writing mes
                packets<br>
                &gt; to avoid ring buffer overflow.<br>
                &gt;<br>
                &gt; Signed-off-by: Jack Xiao <a class="moz-txt-link-rfc2396E" href="mailto:Jack.Xiao@amd.com">&lt;Jack.Xiao@amd.com&gt;</a><br>
                &gt; ---<br>
                &gt;   drivers/gpu/drm/amd/amdgpu/mes_v11_0.c | 18
                ++++++++++++++----<br>
                &gt;   drivers/gpu/drm/amd/amdgpu/mes_v12_0.c | 18
                ++++++++++++++----<br>
                &gt;   2 files changed, 28 insertions(+), 8 deletions(-)<br>
                &gt;<br>
                &gt; diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
                b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c<br>
                &gt; index 8ce51b9236c1..68c74adf79f1 100644<br>
                &gt; --- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c<br>
                &gt; +++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c<br>
                &gt; @@ -168,7 +168,7 @@ static int
                mes_v11_0_submit_pkt_and_poll_completion(struct
                amdgpu_mes *mes,<br>
                &gt;        const char *op_str, *misc_op_str;<br>
                &gt;        unsigned long flags;<br>
                &gt;        u64 status_gpu_addr;<br>
                &gt; -     u32 status_offset;<br>
                &gt; +     u32 seq, status_offset;<br>
                &gt;        u64 *status_ptr;<br>
                &gt;        signed long r;<br>
                &gt;        int ret;<br>
                &gt; @@ -196,6 +196,13 @@ static int
                mes_v11_0_submit_pkt_and_poll_completion(struct
                amdgpu_mes *mes,<br>
                &gt;        if (r)<br>
                &gt;                goto error_unlock_free;<br>
                &gt;   <br>
                &gt; +     seq = ++ring-&gt;fence_drv.sync_seq;<br>
                &gt; +     r = amdgpu_fence_wait_polling(ring,<br>
                &gt; +                                   seq -
                ring-&gt;fence_drv.num_fences_mask,<br>
                &gt; +                                   timeout);<br>
                &gt; +     if (r &lt; 1)<br>
                &gt; +             goto error_undo;<br>
                &gt; +<br>
                &gt;        api_status = (struct MES_API_STATUS *)((char
                *)pkt + api_status_off);<br>
                &gt;        api_status-&gt;api_completion_fence_addr =
                status_gpu_addr;<br>
                &gt;        api_status-&gt;api_completion_fence_value =
                1;<br>
                &gt; @@ -208,8 +215,7 @@ static int
                mes_v11_0_submit_pkt_and_poll_completion(struct
                amdgpu_mes *mes,<br>
                &gt;        mes_status_pkt.header.dwsize =
                API_FRAME_SIZE_IN_DWORDS;<br>
                &gt;       
                mes_status_pkt.api_status.api_completion_fence_addr =<br>
                &gt;                ring-&gt;fence_drv.gpu_addr;<br>
                &gt; -    
                mes_status_pkt.api_status.api_completion_fence_value =<br>
                &gt; -             ++ring-&gt;fence_drv.sync_seq;<br>
                &gt; +    
                mes_status_pkt.api_status.api_completion_fence_value =
                seq;<br>
                &gt;   <br>
                &gt;        amdgpu_ring_write_multiple(ring,
                &amp;mes_status_pkt,<br>
                &gt;                                  
                sizeof(mes_status_pkt) / 4);<br>
                &gt; @@ -229,7 +235,7 @@ static int
                mes_v11_0_submit_pkt_and_poll_completion(struct
                amdgpu_mes *mes,<br>
                &gt;                dev_dbg(adev-&gt;dev, "MES msg=%d
                was emitted\n",<br>
                &gt;                        x_pkt-&gt;header.opcode);<br>
                &gt;   <br>
                &gt; -     r = amdgpu_fence_wait_polling(ring,
                ring-&gt;fence_drv.sync_seq, timeout);<br>
                &gt; +     r = amdgpu_fence_wait_polling(ring, seq,
                timeout);<br>
                &gt;        if (r &lt; 1 || !*status_ptr) {<br>
                &gt;   <br>
                &gt;                if (misc_op_str)<br>
                &gt; @@ -252,6 +258,10 @@ static int
                mes_v11_0_submit_pkt_and_poll_completion(struct
                amdgpu_mes *mes,<br>
                &gt;        amdgpu_device_wb_free(adev, status_offset);<br>
                &gt;        return 0;<br>
                &gt;   <br>
                &gt; +error_undo:<br>
                &gt; +     dev_err(adev-&gt;dev, "MES ring buffer is
                full.\n");<br>
                &gt; +     amdgpu_ring_undo(ring);<br>
                &gt; +<br>
                &gt;   error_unlock_free:<br>
                &gt;       
                spin_unlock_irqrestore(&amp;mes-&gt;ring_lock, flags);<br>
                &gt;   <br>
                &gt; diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
                b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c<br>
                &gt; index c9f74231ad59..48e01206bcc4 100644<br>
                &gt; --- a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c<br>
                &gt; +++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c<br>
                &gt; @@ -154,7 +154,7 @@ static int
                mes_v12_0_submit_pkt_and_poll_completion(struct
                amdgpu_mes *mes,<br>
                &gt;        const char *op_str, *misc_op_str;<br>
                &gt;        unsigned long flags;<br>
                &gt;        u64 status_gpu_addr;<br>
                &gt; -     u32 status_offset;<br>
                &gt; +     u32 seq, status_offset;<br>
                &gt;        u64 *status_ptr;<br>
                &gt;        signed long r;<br>
                &gt;        int ret;<br>
                &gt; @@ -182,6 +182,13 @@ static int
                mes_v12_0_submit_pkt_and_poll_completion(struct
                amdgpu_mes *mes,<br>
                &gt;        if (r)<br>
                &gt;                goto error_unlock_free;<br>
                &gt;   <br>
                &gt; +     seq = ++ring-&gt;fence_drv.sync_seq;<br>
                &gt; +     r = amdgpu_fence_wait_polling(ring,<br>
                &gt; +                                   seq -
                ring-&gt;fence_drv.num_fences_mask,<br>
                <br>
                That's what's amdgpu_fence_emit_polling() does anyway.<br>
                <br>
                So this here just moves the polling a bit earlier.<br>
                <br>
                I think we rather need to increase the MES ring size
                instead.<br>
                <br>
                Regards,<br>
                Christian.<br>
                <br>
                <br>
                &gt; +                                   timeout);<br>
                &gt; +     if (r &lt; 1)<br>
                &gt; +             goto error_undo;<br>
                &gt; +<br>
                &gt;        api_status = (struct MES_API_STATUS *)((char
                *)pkt + api_status_off);<br>
                &gt;        api_status-&gt;api_completion_fence_addr =
                status_gpu_addr;<br>
                &gt;        api_status-&gt;api_completion_fence_value =
                1;<br>
                &gt; @@ -194,8 +201,7 @@ static int
                mes_v12_0_submit_pkt_and_poll_completion(struct
                amdgpu_mes *mes,<br>
                &gt;        mes_status_pkt.header.dwsize =
                API_FRAME_SIZE_IN_DWORDS;<br>
                &gt;       
                mes_status_pkt.api_status.api_completion_fence_addr =<br>
                &gt;                ring-&gt;fence_drv.gpu_addr;<br>
                &gt; -    
                mes_status_pkt.api_status.api_completion_fence_value =<br>
                &gt; -             ++ring-&gt;fence_drv.sync_seq;<br>
                &gt; +    
                mes_status_pkt.api_status.api_completion_fence_value =
                seq;<br>
                &gt;   <br>
                &gt;        amdgpu_ring_write_multiple(ring,
                &amp;mes_status_pkt,<br>
                &gt;                                  
                sizeof(mes_status_pkt) / 4);<br>
                &gt; @@ -215,7 +221,7 @@ static int
                mes_v12_0_submit_pkt_and_poll_completion(struct
                amdgpu_mes *mes,<br>
                &gt;                dev_dbg(adev-&gt;dev, "MES msg=%d
                was emitted\n",<br>
                &gt;                        x_pkt-&gt;header.opcode);<br>
                &gt;   <br>
                &gt; -     r = amdgpu_fence_wait_polling(ring,
                ring-&gt;fence_drv.sync_seq, timeout);<br>
                &gt; +     r = amdgpu_fence_wait_polling(ring, seq,
                timeout);<br>
                &gt;        if (r &lt; 1 || !*status_ptr) {<br>
                &gt;   <br>
                &gt;                if (misc_op_str)<br>
                &gt; @@ -238,6 +244,10 @@ static int
                mes_v12_0_submit_pkt_and_poll_completion(struct
                amdgpu_mes *mes,<br>
                &gt;        amdgpu_device_wb_free(adev, status_offset);<br>
                &gt;        return 0;<br>
                &gt;   <br>
                &gt; +error_undo:<br>
                &gt; +     dev_err(adev-&gt;dev, "MES ring buffer is
                full.\n");<br>
                &gt; +     amdgpu_ring_undo(ring);<br>
                &gt; +<br>
                &gt;   error_unlock_free:<br>
                &gt;       
                spin_unlock_irqrestore(&amp;mes-&gt;ring_lock, flags);<br>
                &gt;   <br>
                <br>
              </div>
            </span></font></div>
      </div>
    </blockquote>
    <br>
  </body>
</html>

--------------Q0amzg4GUnZMtc0JlovGnSCi--
