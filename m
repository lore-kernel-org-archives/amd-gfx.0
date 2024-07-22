Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48020C3DA59
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Jul 2024 11:21:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B88E110E4DC;
	Mon, 22 Jul 2024 11:21:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="JSLhcW3q";
	dkim-atps=neutral
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com
 [209.85.208.175])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B288610E4DC
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Jul 2024 11:21:00 +0000 (UTC)
Received: by mail-lj1-f175.google.com with SMTP id
 38308e7fff4ca-2eede876fbfso56557721fa.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Jul 2024 04:21:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1721647259; x=1722252059; darn=lists.freedesktop.org;
 h=in-reply-to:from:content-language:references:to:subject:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=W24yABKvqq5/qg6cCKyTRox0+zW+jV7VUViXuKLWtqg=;
 b=JSLhcW3qxJNzR4jBcjo7uiyo/ejKr0qQwBwwJqexRS6+5U47sbcUP2hNxSgH4WO/uO
 viS7BSSZGQ+unRNvtbF9OdTORz+sBc5+mpn5vfp7l5v9Ddeu9rs+vjH+PiUIAphaBJDD
 P8Om8zkTpsdb8nanBBJ2DDVgOq2qAMV7tMrjrQX0y1OriYAWOcaSUYVnsRV62Lftj436
 KZi3yEAg4h9utOdEpqytmlR5NmYIZAOBGM6LCxZgWhXAyx+KMKsjsg7X14AjHGGI8bXP
 rhKyMwe9vI3F+q6PJ2p6aM9X4fD5UGwBY7/3+OO3OGBxGEj65X8NSqA50FpC3VbDrvK2
 UNgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721647259; x=1722252059;
 h=in-reply-to:from:content-language:references:to:subject:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=W24yABKvqq5/qg6cCKyTRox0+zW+jV7VUViXuKLWtqg=;
 b=iB2OWGr9GHr1IgnJXa4yjB55gO2btJFv9y0CamAnME9HrupF+bSlJ84GS7kZf+WrL5
 dsjYrpL/drttG2+6etL02jAWxpiXhrh1EpaXrtn2ETlPLCs7qjFAGzi5ATXBRwpuRdeU
 zIqxwOjEKBevhrTttP4scxu74kGtSCWsSA4W1PqBNcp9d22zO5KkRyAgMk3qjqFJmG64
 9VP9VZib8bIFM8s2zxaQ1SJ683CL1Y5s5EGfK6S7u/aeAtXKTx1Mz6okb+IeM7XPg3Gb
 anClxK42YkYViAU2XOIqPXuGVjY/3lW4Q+KpN6AUXilwIyAX0imXFWIjq1zkKB5VzBVG
 x5wQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWA4I6/PtzUfeGa94dGkrGRnKvIc13DbJyOtHVLdtkSN2dLWmCnRYZUOe9dmowngLLrZTyXtAKcWf5W2zlRM5FvYh8KzaiDoH2LzEh8tA==
X-Gm-Message-State: AOJu0Yyzv3cEVlUxuYumM6IIqjLb0cpwHYq2PF8TyofsUkFUpYZRiga6
 97w8ypqUhZKGg7PlqBc/V3HRc8MiaPR6ZVeWxCdZPjuambJfpM08
X-Google-Smtp-Source: AGHT+IGxRwvvesHSQoqGS/+X1tbOjBuZVSlZak7FuTHr8xnrJMeiKEB/cYpGtG/We8Z0mBmtr5/X3g==
X-Received: by 2002:a2e:83c6:0:b0:2ec:5fe1:c762 with SMTP id
 38308e7fff4ca-2ef16864a11mr49071021fa.46.1721647258034; 
 Mon, 22 Jul 2024 04:20:58 -0700 (PDT)
Received: from [10.254.108.81] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3687868b7cesm8247471f8f.37.2024.07.22.04.20.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 Jul 2024 04:20:57 -0700 (PDT)
Content-Type: multipart/alternative;
 boundary="------------DwP7akRhqonRfmaXCDBJuLt0"
Message-ID: <87d19441-ac19-4b79-a7d8-6980840f0f19@gmail.com>
Date: Mon, 22 Jul 2024 13:20:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu/mes: fix mes ring buffer overflow
To: "Xiao, Jack" <Jack.Xiao@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>
References: <20240719091615.1534436-1-Jack.Xiao@amd.com>
 <bfca2c44-9e40-4e04-bfcf-1285b3552707@gmail.com>
 <PH8PR12MB68417B9F856C92BD02912A08EFA82@PH8PR12MB6841.namprd12.prod.outlook.com>
 <92f00b1c-79c2-431b-b8dc-70070a65b14a@gmail.com>
 <PH8PR12MB6841A6DA262E07EF7317FE72EFA82@PH8PR12MB6841.namprd12.prod.outlook.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <PH8PR12MB6841A6DA262E07EF7317FE72EFA82@PH8PR12MB6841.namprd12.prod.outlook.com>
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
--------------DwP7akRhqonRfmaXCDBJuLt0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

What I meant is that the MES ring is now to small for the number of 
packets written to it.

Either reduce the num_hw_submission or increase the MES ring size.

E.g. see this code here in amdgpu_ring_init:

         if (ring->funcs->type == AMDGPU_RING_TYPE_KIQ)
                 sched_hw_submission = max(sched_hw_submission, 256);
         else if (ring == &adev->sdma.instance[0].page)
                 sched_hw_submission = 256;

We are basically just missing a case for the MES here as far as I can see.

Regards,
Christian.

Am 22.07.24 um 10:46 schrieb Xiao, Jack:
>
> [AMD Official Use Only - AMD Internal Distribution Only]
>
>
> />> Can you try to reduce num_hw_submission for the MES ring?
> /
> Smaller num_hw_submission should not help for this issue, for Mes work 
> without drm scheduler like legacy kiq. Smaller num_hw_submission will 
> result in smaller mes ring size and more waiting time.
>
> Regards,
> Jack
> ------------------------------------------------------------------------
> *From:* Christian König <ckoenig.leichtzumerken@gmail.com>
> *Sent:* Monday, 22 July 2024 16:20
> *To:* Xiao, Jack <Jack.Xiao@amd.com>; amd-gfx@lists.freedesktop.org 
> <amd-gfx@lists.freedesktop.org>; Deucher, Alexander 
> <Alexander.Deucher@amd.com>
> *Subject:* Re: [PATCH] drm/amdgpu/mes: fix mes ring buffer overflow
> Thx, but in that case this patch here then won't help either it just 
> mitigates the problem.
>
> Can you try to reduce num_hw_submission for the MES ring?
>
> Thanks,
> Christian.
>
> Am 22.07.24 um 05:27 schrieb Xiao, Jack:
>>
>> [AMD Official Use Only - AMD Internal Distribution Only]
>>
>>
>> />> I think we rather need to increase the MES ring size instead./
>>
>> Unfortunately, it doesn't work. I guess mes firmware has limitation.
>>
>> Regards,
>> Jack
>>
>> ------------------------------------------------------------------------
>> *From:* Christian König <ckoenig.leichtzumerken@gmail.com> 
>> <mailto:ckoenig.leichtzumerken@gmail.com>
>> *Sent:* Friday, 19 July 2024 23:44
>> *To:* Xiao, Jack <Jack.Xiao@amd.com> <mailto:Jack.Xiao@amd.com>; 
>> amd-gfx@lists.freedesktop.org <mailto:amd-gfx@lists.freedesktop.org> 
>> <amd-gfx@lists.freedesktop.org> 
>> <mailto:amd-gfx@lists.freedesktop.org>; Deucher, Alexander 
>> <Alexander.Deucher@amd.com> <mailto:Alexander.Deucher@amd.com>
>> *Subject:* Re: [PATCH] drm/amdgpu/mes: fix mes ring buffer overflow
>> Am 19.07.24 um 11:16 schrieb Jack Xiao:
>> > wait memory room until enough before writing mes packets
>> > to avoid ring buffer overflow.
>> >
>> > Signed-off-by: Jack Xiao <Jack.Xiao@amd.com> <mailto:Jack.Xiao@amd.com>
>> > ---
>> >   drivers/gpu/drm/amd/amdgpu/mes_v11_0.c | 18 ++++++++++++++----
>> >   drivers/gpu/drm/amd/amdgpu/mes_v12_0.c | 18 ++++++++++++++----
>> >   2 files changed, 28 insertions(+), 8 deletions(-)
>> >
>> > diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c 
>> b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
>> > index 8ce51b9236c1..68c74adf79f1 100644
>> > --- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
>> > +++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
>> > @@ -168,7 +168,7 @@ static int 
>> mes_v11_0_submit_pkt_and_poll_completion(struct amdgpu_mes *mes,
>> >        const char *op_str, *misc_op_str;
>> >        unsigned long flags;
>> >        u64 status_gpu_addr;
>> > -     u32 status_offset;
>> > +     u32 seq, status_offset;
>> >        u64 *status_ptr;
>> >        signed long r;
>> >        int ret;
>> > @@ -196,6 +196,13 @@ static int 
>> mes_v11_0_submit_pkt_and_poll_completion(struct amdgpu_mes *mes,
>> >        if (r)
>> >                goto error_unlock_free;
>> >
>> > +     seq = ++ring->fence_drv.sync_seq;
>> > +     r = amdgpu_fence_wait_polling(ring,
>> > +                                   seq - 
>> ring->fence_drv.num_fences_mask,
>> > +                                   timeout);
>> > +     if (r < 1)
>> > +             goto error_undo;
>> > +
>> >        api_status = (struct MES_API_STATUS *)((char *)pkt + 
>> api_status_off);
>> > api_status->api_completion_fence_addr = status_gpu_addr;
>> > api_status->api_completion_fence_value = 1;
>> > @@ -208,8 +215,7 @@ static int 
>> mes_v11_0_submit_pkt_and_poll_completion(struct amdgpu_mes *mes,
>> >        mes_status_pkt.header.dwsize = API_FRAME_SIZE_IN_DWORDS;
>> > mes_status_pkt.api_status.api_completion_fence_addr =
>> >                ring->fence_drv.gpu_addr;
>> > - mes_status_pkt.api_status.api_completion_fence_value =
>> > -             ++ring->fence_drv.sync_seq;
>> > + mes_status_pkt.api_status.api_completion_fence_value = seq;
>> >
>> >        amdgpu_ring_write_multiple(ring, &mes_status_pkt,
>> > sizeof(mes_status_pkt) / 4);
>> > @@ -229,7 +235,7 @@ static int 
>> mes_v11_0_submit_pkt_and_poll_completion(struct amdgpu_mes *mes,
>> >                dev_dbg(adev->dev, "MES msg=%d was emitted\n",
>> > x_pkt->header.opcode);
>> >
>> > -     r = amdgpu_fence_wait_polling(ring, ring->fence_drv.sync_seq, 
>> timeout);
>> > +     r = amdgpu_fence_wait_polling(ring, seq, timeout);
>> >        if (r < 1 || !*status_ptr) {
>> >
>> >                if (misc_op_str)
>> > @@ -252,6 +258,10 @@ static int 
>> mes_v11_0_submit_pkt_and_poll_completion(struct amdgpu_mes *mes,
>> >        amdgpu_device_wb_free(adev, status_offset);
>> >        return 0;
>> >
>> > +error_undo:
>> > +     dev_err(adev->dev, "MES ring buffer is full.\n");
>> > +     amdgpu_ring_undo(ring);
>> > +
>> >   error_unlock_free:
>> > spin_unlock_irqrestore(&mes->ring_lock, flags);
>> >
>> > diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c 
>> b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
>> > index c9f74231ad59..48e01206bcc4 100644
>> > --- a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
>> > +++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
>> > @@ -154,7 +154,7 @@ static int 
>> mes_v12_0_submit_pkt_and_poll_completion(struct amdgpu_mes *mes,
>> >        const char *op_str, *misc_op_str;
>> >        unsigned long flags;
>> >        u64 status_gpu_addr;
>> > -     u32 status_offset;
>> > +     u32 seq, status_offset;
>> >        u64 *status_ptr;
>> >        signed long r;
>> >        int ret;
>> > @@ -182,6 +182,13 @@ static int 
>> mes_v12_0_submit_pkt_and_poll_completion(struct amdgpu_mes *mes,
>> >        if (r)
>> >                goto error_unlock_free;
>> >
>> > +     seq = ++ring->fence_drv.sync_seq;
>> > +     r = amdgpu_fence_wait_polling(ring,
>> > +                                   seq - 
>> ring->fence_drv.num_fences_mask,
>>
>> That's what's amdgpu_fence_emit_polling() does anyway.
>>
>> So this here just moves the polling a bit earlier.
>>
>> I think we rather need to increase the MES ring size instead.
>>
>> Regards,
>> Christian.
>>
>>
>> > +                                   timeout);
>> > +     if (r < 1)
>> > +             goto error_undo;
>> > +
>> >        api_status = (struct MES_API_STATUS *)((char *)pkt + 
>> api_status_off);
>> > api_status->api_completion_fence_addr = status_gpu_addr;
>> > api_status->api_completion_fence_value = 1;
>> > @@ -194,8 +201,7 @@ static int 
>> mes_v12_0_submit_pkt_and_poll_completion(struct amdgpu_mes *mes,
>> >        mes_status_pkt.header.dwsize = API_FRAME_SIZE_IN_DWORDS;
>> > mes_status_pkt.api_status.api_completion_fence_addr =
>> >                ring->fence_drv.gpu_addr;
>> > - mes_status_pkt.api_status.api_completion_fence_value =
>> > -             ++ring->fence_drv.sync_seq;
>> > + mes_status_pkt.api_status.api_completion_fence_value = seq;
>> >
>> >        amdgpu_ring_write_multiple(ring, &mes_status_pkt,
>> > sizeof(mes_status_pkt) / 4);
>> > @@ -215,7 +221,7 @@ static int 
>> mes_v12_0_submit_pkt_and_poll_completion(struct amdgpu_mes *mes,
>> >                dev_dbg(adev->dev, "MES msg=%d was emitted\n",
>> > x_pkt->header.opcode);
>> >
>> > -     r = amdgpu_fence_wait_polling(ring, ring->fence_drv.sync_seq, 
>> timeout);
>> > +     r = amdgpu_fence_wait_polling(ring, seq, timeout);
>> >        if (r < 1 || !*status_ptr) {
>> >
>> >                if (misc_op_str)
>> > @@ -238,6 +244,10 @@ static int 
>> mes_v12_0_submit_pkt_and_poll_completion(struct amdgpu_mes *mes,
>> >        amdgpu_device_wb_free(adev, status_offset);
>> >        return 0;
>> >
>> > +error_undo:
>> > +     dev_err(adev->dev, "MES ring buffer is full.\n");
>> > +     amdgpu_ring_undo(ring);
>> > +
>> >   error_unlock_free:
>> > spin_unlock_irqrestore(&mes->ring_lock, flags);
>> >
>>
>

--------------DwP7akRhqonRfmaXCDBJuLt0
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    What I meant is that the MES ring is now to small for the number of
    packets written to it.<br>
    <br>
    Either reduce the num_hw_submission or increase the MES ring size.<br>
    <br>
    E.g. see this code here in amdgpu_ring_init:<br>
    <br>
            if (ring-&gt;funcs-&gt;type == AMDGPU_RING_TYPE_KIQ)<br>
                    sched_hw_submission = max(sched_hw_submission, 256);<br>
            else if (ring == &amp;adev-&gt;sdma.instance[0].page)<br>
                    sched_hw_submission = 256;<br>
    <br>
    We are basically just missing a case for the MES here as far as I
    can see.<br>
    <br>
    Regards,<br>
    Christian.<br>
    <br>
    <div class="moz-cite-prefix">Am 22.07.24 um 10:46 schrieb Xiao,
      Jack:<br>
    </div>
    <blockquote type="cite"
cite="mid:PH8PR12MB6841A6DA262E07EF7317FE72EFA82@PH8PR12MB6841.namprd12.prod.outlook.com">
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
          <i>&gt;&gt; Can you try to reduce num_hw_submission for the
            MES ring?<br>
          </i><br>
        </div>
        <div class="elementToProof"
style="font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
          Smaller num_hw_submission should not help for this issue, for
          Mes work without drm scheduler like legacy kiq. Smaller
          num_hw_submission will result in smaller mes ring size and
          more waiting time.</div>
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
        <hr style="display:inline-block;width:98%" tabindex="-1">
        <div id="divRplyFwdMsg" dir="ltr"><font style="font-size:11pt"
            face="Calibri, sans-serif" color="#000000"><b>From:</b>
            Christian König <a class="moz-txt-link-rfc2396E" href="mailto:ckoenig.leichtzumerken@gmail.com">&lt;ckoenig.leichtzumerken@gmail.com&gt;</a><br>
            <b>Sent:</b> Monday, 22 July 2024 16:20<br>
            <b>To:</b> Xiao, Jack <a class="moz-txt-link-rfc2396E" href="mailto:Jack.Xiao@amd.com">&lt;Jack.Xiao@amd.com&gt;</a>;
            <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.org</a>
            <a class="moz-txt-link-rfc2396E" href="mailto:amd-gfx@lists.freedesktop.org">&lt;amd-gfx@lists.freedesktop.org&gt;</a>; Deucher, Alexander
            <a class="moz-txt-link-rfc2396E" href="mailto:Alexander.Deucher@amd.com">&lt;Alexander.Deucher@amd.com&gt;</a><br>
            <b>Subject:</b> Re: [PATCH] drm/amdgpu/mes: fix mes ring
            buffer overflow</font>
          <div> </div>
        </div>
        <div>Thx, but in that case this patch here then won't help
          either it just mitigates the problem.<br>
          <br>
          Can you try to reduce num_hw_submission for the MES ring?<br>
          <br>
          Thanks,<br>
          Christian.<br>
          <br>
          <div class="x_moz-cite-prefix">Am 22.07.24 um 05:27 schrieb
            Xiao, Jack:<br>
          </div>
          <blockquote type="cite">
            <style type="text/css" style="display:none">p
	{margin-top:0;
	margin-bottom:0}</style>
            <p
style="font-family:Calibri; font-size:10pt; color:#0000FF; margin:5pt; font-style:normal; font-weight:normal; text-decoration:none"
              align="Left">
              [AMD Official Use Only - AMD Internal Distribution Only]<br>
            </p>
            <br>
            <div>
              <div class="x_elementToProof"
style="font-family:Aptos,Aptos_EmbeddedFont,Aptos_MSFontService,Calibri,Helvetica,sans-serif; font-size:12pt; color:rgb(0,0,0)">
                <i>&gt;&gt; I think we rather need to increase the MES
                  ring size instead.</i></div>
              <div class="x_elementToProof"
style="font-family:Aptos,Aptos_EmbeddedFont,Aptos_MSFontService,Calibri,Helvetica,sans-serif; font-size:12pt; color:rgb(0,0,0)">
                <br>
              </div>
              <div class="x_elementToProof"
style="font-family:Aptos,Aptos_EmbeddedFont,Aptos_MSFontService,Calibri,Helvetica,sans-serif; font-size:12pt; color:rgb(0,0,0)">
                Unfortunately, it doesn't work. I guess mes firmware has
                limitation.</div>
              <div class="x_elementToProof"
style="font-family:Aptos,Aptos_EmbeddedFont,Aptos_MSFontService,Calibri,Helvetica,sans-serif; font-size:12pt; color:rgb(0,0,0)">
                <br>
              </div>
              <div class="x_elementToProof"
style="font-family:Aptos,Aptos_EmbeddedFont,Aptos_MSFontService,Calibri,Helvetica,sans-serif; font-size:12pt; color:rgb(0,0,0)">
                Regards,</div>
              <div class="x_elementToProof"
style="font-family:Aptos,Aptos_EmbeddedFont,Aptos_MSFontService,Calibri,Helvetica,sans-serif; font-size:12pt; color:rgb(0,0,0)">
                Jack</div>
              <div class="x_elementToProof"
style="font-family:Aptos,Aptos_EmbeddedFont,Aptos_MSFontService,Calibri,Helvetica,sans-serif; font-size:12pt; color:rgb(0,0,0)">
                <br>
              </div>
              <hr tabindex="-1" style="display:inline-block; width:98%">
              <div id="x_divRplyFwdMsg" dir="ltr"><font
                  style="font-size:11pt" face="Calibri, sans-serif"
                  color="#000000"><b>From:</b> Christian König
                  <a class="x_moz-txt-link-rfc2396E"
                    href="mailto:ckoenig.leichtzumerken@gmail.com"
                    moz-do-not-send="true">
                    &lt;ckoenig.leichtzumerken@gmail.com&gt;</a><br>
                  <b>Sent:</b> Friday, 19 July 2024 23:44<br>
                  <b>To:</b> Xiao, Jack <a
                    class="x_moz-txt-link-rfc2396E"
                    href="mailto:Jack.Xiao@amd.com"
                    moz-do-not-send="true">
                    &lt;Jack.Xiao@amd.com&gt;</a>; <a
class="x_moz-txt-link-abbreviated moz-txt-link-freetext"
                    href="mailto:amd-gfx@lists.freedesktop.org"
                    moz-do-not-send="true">
                    amd-gfx@lists.freedesktop.org</a> <a
                    class="x_moz-txt-link-rfc2396E"
                    href="mailto:amd-gfx@lists.freedesktop.org"
                    moz-do-not-send="true">
                    &lt;amd-gfx@lists.freedesktop.org&gt;</a>; Deucher,
                  Alexander <a class="x_moz-txt-link-rfc2396E"
                    href="mailto:Alexander.Deucher@amd.com"
                    moz-do-not-send="true">
                    &lt;Alexander.Deucher@amd.com&gt;</a><br>
                  <b>Subject:</b> Re: [PATCH] drm/amdgpu/mes: fix mes
                  ring buffer overflow</font>
                <div> </div>
              </div>
              <div class="x_BodyFragment"><font size="2"><span
                    style="font-size:11pt">
                    <div class="x_PlainText">Am 19.07.24 um 11:16
                      schrieb Jack Xiao:<br>
                      &gt; wait memory room until enough before writing
                      mes packets<br>
                      &gt; to avoid ring buffer overflow.<br>
                      &gt;<br>
                      &gt; Signed-off-by: Jack Xiao <a
                        class="x_moz-txt-link-rfc2396E"
                        href="mailto:Jack.Xiao@amd.com"
                        moz-do-not-send="true">
                        &lt;Jack.Xiao@amd.com&gt;</a><br>
                      &gt; ---<br>
                      &gt;   drivers/gpu/drm/amd/amdgpu/mes_v11_0.c | 18
                      ++++++++++++++----<br>
                      &gt;   drivers/gpu/drm/amd/amdgpu/mes_v12_0.c | 18
                      ++++++++++++++----<br>
                      &gt;   2 files changed, 28 insertions(+), 8
                      deletions(-)<br>
                      &gt;<br>
                      &gt; diff --git
                      a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
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
                      &gt;        api_status = (struct MES_API_STATUS
                      *)((char *)pkt + api_status_off);<br>
                      &gt;       
                      api_status-&gt;api_completion_fence_addr =
                      status_gpu_addr;<br>
                      &gt;       
                      api_status-&gt;api_completion_fence_value = 1;<br>
                      &gt; @@ -208,8 +215,7 @@ static int
                      mes_v11_0_submit_pkt_and_poll_completion(struct
                      amdgpu_mes *mes,<br>
                      &gt;        mes_status_pkt.header.dwsize =
                      API_FRAME_SIZE_IN_DWORDS;<br>
                      &gt;       
                      mes_status_pkt.api_status.api_completion_fence_addr
                      =<br>
                      &gt;                ring-&gt;fence_drv.gpu_addr;<br>
                      &gt; -    
                      mes_status_pkt.api_status.api_completion_fence_value
                      =<br>
                      &gt; -             ++ring-&gt;fence_drv.sync_seq;<br>
                      &gt; +    
                      mes_status_pkt.api_status.api_completion_fence_value
                      = seq;<br>
                      &gt;   <br>
                      &gt;        amdgpu_ring_write_multiple(ring,
                      &amp;mes_status_pkt,<br>
                      &gt;                                  
                      sizeof(mes_status_pkt) / 4);<br>
                      &gt; @@ -229,7 +235,7 @@ static int
                      mes_v11_0_submit_pkt_and_poll_completion(struct
                      amdgpu_mes *mes,<br>
                      &gt;                dev_dbg(adev-&gt;dev, "MES
                      msg=%d was emitted\n",<br>
                      &gt;                       
                      x_pkt-&gt;header.opcode);<br>
                      &gt;   <br>
                      &gt; -     r = amdgpu_fence_wait_polling(ring,
                      ring-&gt;fence_drv.sync_seq, timeout);<br>
                      &gt; +     r = amdgpu_fence_wait_polling(ring,
                      seq, timeout);<br>
                      &gt;        if (r &lt; 1 || !*status_ptr) {<br>
                      &gt;   <br>
                      &gt;                if (misc_op_str)<br>
                      &gt; @@ -252,6 +258,10 @@ static int
                      mes_v11_0_submit_pkt_and_poll_completion(struct
                      amdgpu_mes *mes,<br>
                      &gt;        amdgpu_device_wb_free(adev,
                      status_offset);<br>
                      &gt;        return 0;<br>
                      &gt;   <br>
                      &gt; +error_undo:<br>
                      &gt; +     dev_err(adev-&gt;dev, "MES ring buffer
                      is full.\n");<br>
                      &gt; +     amdgpu_ring_undo(ring);<br>
                      &gt; +<br>
                      &gt;   error_unlock_free:<br>
                      &gt;       
                      spin_unlock_irqrestore(&amp;mes-&gt;ring_lock,
                      flags);<br>
                      &gt;   <br>
                      &gt; diff --git
                      a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
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
                      That's what's amdgpu_fence_emit_polling() does
                      anyway.<br>
                      <br>
                      So this here just moves the polling a bit earlier.<br>
                      <br>
                      I think we rather need to increase the MES ring
                      size instead.<br>
                      <br>
                      Regards,<br>
                      Christian.<br>
                      <br>
                      <br>
                      &gt; +                                   timeout);<br>
                      &gt; +     if (r &lt; 1)<br>
                      &gt; +             goto error_undo;<br>
                      &gt; +<br>
                      &gt;        api_status = (struct MES_API_STATUS
                      *)((char *)pkt + api_status_off);<br>
                      &gt;       
                      api_status-&gt;api_completion_fence_addr =
                      status_gpu_addr;<br>
                      &gt;       
                      api_status-&gt;api_completion_fence_value = 1;<br>
                      &gt; @@ -194,8 +201,7 @@ static int
                      mes_v12_0_submit_pkt_and_poll_completion(struct
                      amdgpu_mes *mes,<br>
                      &gt;        mes_status_pkt.header.dwsize =
                      API_FRAME_SIZE_IN_DWORDS;<br>
                      &gt;       
                      mes_status_pkt.api_status.api_completion_fence_addr
                      =<br>
                      &gt;                ring-&gt;fence_drv.gpu_addr;<br>
                      &gt; -    
                      mes_status_pkt.api_status.api_completion_fence_value
                      =<br>
                      &gt; -             ++ring-&gt;fence_drv.sync_seq;<br>
                      &gt; +    
                      mes_status_pkt.api_status.api_completion_fence_value
                      = seq;<br>
                      &gt;   <br>
                      &gt;        amdgpu_ring_write_multiple(ring,
                      &amp;mes_status_pkt,<br>
                      &gt;                                  
                      sizeof(mes_status_pkt) / 4);<br>
                      &gt; @@ -215,7 +221,7 @@ static int
                      mes_v12_0_submit_pkt_and_poll_completion(struct
                      amdgpu_mes *mes,<br>
                      &gt;                dev_dbg(adev-&gt;dev, "MES
                      msg=%d was emitted\n",<br>
                      &gt;                       
                      x_pkt-&gt;header.opcode);<br>
                      &gt;   <br>
                      &gt; -     r = amdgpu_fence_wait_polling(ring,
                      ring-&gt;fence_drv.sync_seq, timeout);<br>
                      &gt; +     r = amdgpu_fence_wait_polling(ring,
                      seq, timeout);<br>
                      &gt;        if (r &lt; 1 || !*status_ptr) {<br>
                      &gt;   <br>
                      &gt;                if (misc_op_str)<br>
                      &gt; @@ -238,6 +244,10 @@ static int
                      mes_v12_0_submit_pkt_and_poll_completion(struct
                      amdgpu_mes *mes,<br>
                      &gt;        amdgpu_device_wb_free(adev,
                      status_offset);<br>
                      &gt;        return 0;<br>
                      &gt;   <br>
                      &gt; +error_undo:<br>
                      &gt; +     dev_err(adev-&gt;dev, "MES ring buffer
                      is full.\n");<br>
                      &gt; +     amdgpu_ring_undo(ring);<br>
                      &gt; +<br>
                      &gt;   error_unlock_free:<br>
                      &gt;       
                      spin_unlock_irqrestore(&amp;mes-&gt;ring_lock,
                      flags);<br>
                      &gt;   <br>
                      <br>
                    </div>
                  </span></font></div>
            </div>
          </blockquote>
          <br>
        </div>
      </div>
    </blockquote>
    <br>
  </body>
</html>

--------------DwP7akRhqonRfmaXCDBJuLt0--
