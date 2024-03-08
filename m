Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55DB4C54E5C
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Mar 2024 08:26:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B69B0113389;
	Fri,  8 Mar 2024 08:26:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=yonsei.ac.kr header.i=@yonsei.ac.kr header.b="dAlUCZ1F";
	dkim-atps=neutral
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com
 [209.85.128.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 01402112FFE
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Mar 2024 07:32:35 +0000 (UTC)
Received: by mail-yw1-f170.google.com with SMTP id
 00721157ae682-609eb87a847so13679387b3.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 07 Mar 2024 23:32:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=yonsei.ac.kr; s=google; t=1709883154; x=1710487954;
 darn=lists.freedesktop.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ifPbKUI+bT00aa2fTtBnHrDwx+gpKaMAMhTI2u+fdZo=;
 b=dAlUCZ1FfFNP7aor+QHfH0DpAwsW04szaqWFi1zP8U+6fOoRxT6UEc8386XKGvhJnc
 EvwpUIxGSqcKuw7qtQpYFzvEc0hwDclKnS0exsSqXxZETjhn6qVs8wzjqlut0ryUikbL
 hBPcUBrSyamsPjzjCDNip9+NJ+VnxOOJzKA345QnNJhIT+ab3J6nylRtJjG/mqZM5xvy
 P6XGjKcPh1y2ObPQCfwCSfs8S7/Lqy6OhoT4aN3PKZ3aALRtNElMGMk3wdlTN0Yv26NZ
 ya7a0fSTV3x2Bhn81NiOCUgetAAjYyN7LWnYDgNS0d9ibaVcsaP+CwnvFlqL4ETCBxfx
 fsbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709883154; x=1710487954;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ifPbKUI+bT00aa2fTtBnHrDwx+gpKaMAMhTI2u+fdZo=;
 b=PKUJKnh4xZUmT2ltOYfNxpBoFI5sDdYGsvrnEU1/SL35WCkXvnzvN4DEY2QdR4v2wo
 eN4raYOpC6YMufjTXGdpiqUDr1fZ1q4vi6RAYv+azN03mIQNuXjmDggcIozjgls39r1w
 4sfR/w5yVSSx2S+csUlDGIkQhqViYTBH5bEmi2bS6TrM+9wKzw4p3wc0tHMwfu81yAWQ
 5RFDVFFVFrc4IWoEj0uERe18/jZpLRoJvZgPM1S2nxHVj4kqWh+nhqc2tQOPh8wmbbCU
 zczZPNnvt/eaFeE6290XyxKgRhIKGGK9THQSElJkc4xF1KwoFshT95k9ZrC1eYvRE3WX
 oz6A==
X-Forwarded-Encrypted: i=1;
 AJvYcCX0xUfc2uAelk9Hb3ZMBcHaXoR8LiP+JJpjfjYmsnT/aCduzpNj5oy5bRpsiYBYYKVOTfa2Qk+BTTZksFHsg40nB3XONAlFB2v69HeT/Q==
X-Gm-Message-State: AOJu0Yz3YD75UVh4WRbYxXKLAwggzzWHxKAlfFC2aNv7M0qBmqsnPSBb
 lDnvUuoJBnGkY+Wu5BzlmuVVF5RzJA+bYSkmUOtAHpiN9LxfdweIk6tq5KWeZpB5uWyoTMWtJNT
 5uiGsksed6/FgN+j4LJjIIgnP/L1sNKBuX8t/oqDKHXeOwrCRWqk=
X-Google-Smtp-Source: AGHT+IEkHUBBqG8NxKxk/C87N0S+tMEddUtFI9cRbgLj3QwzlTa9F1HccfntStdDK5EYNEQShXvCDzyc8CB/XmDiVc4=
X-Received: by 2002:a81:ae54:0:b0:60a:6b4:a031 with SMTP id
 g20-20020a81ae54000000b0060a06b4a031mr270059ywk.15.1709883154125; Thu, 07 Mar
 2024 23:32:34 -0800 (PST)
MIME-Version: 1.0
References: <CAKc8oVUXUHUYQSDYDZ3XqpfwcmOwoxii5+SkyteXoZSPRwshfQ@mail.gmail.com>
 <CAKc8oVU8C-MRVa640603R2Gi7BRZ5P8ZN_uJoruDzR_A8xg71Q@mail.gmail.com>
 <f3cb1403-6822-44b2-95fe-ab5f50ca3736@amd.com>
In-Reply-To: <f3cb1403-6822-44b2-95fe-ab5f50ca3736@amd.com>
From: Joonkyo Jung <joonkyoj@yonsei.ac.kr>
Date: Fri, 8 Mar 2024 16:32:23 +0900
Message-ID: <CAKc8oVXw0YhLdBHZUcc73aFAeL-zioCpEsNZYW7c7y70DYds-w@mail.gmail.com>
Subject: Re: Reporting a slab-use-after-free in amdgpu
To: vitaly prosyak <vprosyak@amd.com>
Cc: Dokyung Song <dokyungs@yonsei.ac.kr>, Xinhui.Pan@amd.com,
 alexander.deucher@amd.com, 
 amd-gfx@lists.freedesktop.org, christian.koenig@amd.com, 
 jisoo.jang@yonsei.ac.kr, "yw9865@gmail.com" <yw9865@gmail.com>
Content-Type: multipart/alternative; boundary="000000000000026ea106132132ec"
X-Mailman-Approved-At: Fri, 08 Mar 2024 08:26:38 +0000
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

--000000000000026ea106132132ec
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Vitaly,

No worries, thank you for working on the patches!

I have also confirmed that with the inflight patch, issue No.1
(use-after-free) seems to be resolved.
However, I have reproduced issue No.3 (slab-use-after-free) even with the
patch for issue No.1 applied - if it's the first program tested after
reboot.
(i.e., if any other bugs are tested before the slab-use-after-free, it does
not reproduce).

Could you check if the bug reproduces in this condition for you too?
I will check and see why this is happening and update you if I have
something new.

Thank you!

Best,
Joonkyo



On Fri, Mar 8, 2024 at 12:45=E2=80=AFPM vitaly prosyak <vprosyak@amd.com> w=
rote:

> Hi Joonkyo,
> Sorry for the delay.
> Yes, sure, I reproduced issue 2 (null-ptr-deref in amdgpu) and I will
> provide the fix soon.
> However, issue No. 3 is no longer reproducible if the recent patch
> inflight is applied which fixes issue No 1.
>
> Do you see the same behavior?
>
> Thanks in advance, Vitaly
> On 2024-03-07 20:18, Joonkyo Jung wrote:
>
> Hello,
> thank you for patching the first bug we have sent!
>
> Just a quick touch base with you, to ask if there has been any update on
> our other two bugs.
> They were each sent with emails titled
> "Reporting a slab-use-after-free in amdgpu" (this one)
> "Reporting a null-ptr-deref in amdgpu".
>
> Thank you!
>
> Best,
> Joonkyo
>
>
> 2024=EB=85=84 2=EC=9B=94 16=EC=9D=BC (=EA=B8=88) =EC=98=A4=ED=9B=84 6:22,=
 Joonkyo Jung <joonkyoj@yonsei.ac.kr>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
>> Hello,
>>
>> We would like to report a slab-use-after-free bug in the AMDGPU DRM
>> driver in the linux kernel v6.8-rc4 that we found with our customized
>> Syzkaller.
>> The bug can be triggered by sending two ioctls to the AMDGPU DRM driver
>> in succession.
>>
>> In amdgpu_bo_move, struct ttm_resource *old_mem =3D bo->resource is
>> assigned.
>> As you can see on the alloc & free stack calls, on the same function
>> amdgpu_bo_move,
>> amdgpu_move_blit in the end frees bo->resource at
>> ttm_bo_move_accel_cleanup with ttm_bo_wait_free_node(bo, man->use_tt).
>> But amdgpu_bo_move continues after that, reaching
>> trace_amdgpu_bo_move(abo, new_mem->mem_type, old_mem->mem_type) at the e=
nd,
>> causing the use-after-free bug.
>>
>> Steps to reproduce are as below.
>> union drm_amdgpu_gem_create *arg1;
>>
>> arg1 =3D malloc(sizeof(union drm_amdgpu_gem_create));
>> arg1->in.bo_size =3D 0x8;
>> arg1->in.alignment =3D 0x0;
>> arg1->in.domains =3D 0x4;
>> arg1->in.domain_flags =3D 0x9;
>> ioctl(fd, 0xc0206440, arg1);
>>
>> arg1->in.bo_size =3D 0x7fffffff;
>> arg1->in.alignment =3D 0x0;
>> arg1->in.domains =3D 0x4;
>> arg1->in.domain_flags =3D 0x9;
>> ioctl(fd, 0xc0206440, arg1);
>>
>> The KASAN report is as follows:
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> BUG: KASAN: slab-use-after-free in amdgpu_bo_move+0x1479/0x1550
>> Read of size 4 at addr ffff88800f5bee80 by task syz-executor/219
>> Call Trace:
>>  <TASK>
>>  amdgpu_bo_move+0x1479/0x1550
>>  ttm_bo_handle_move_mem+0x4d0/0x700
>>  ttm_mem_evict_first+0x945/0x1230
>>  ttm_bo_mem_space+0x6c7/0x940
>>  ttm_bo_validate+0x286/0x650
>>  ttm_bo_init_reserved+0x34c/0x490
>>  amdgpu_bo_create+0x94b/0x1610
>>  amdgpu_bo_create_user+0xa3/0x130
>>  amdgpu_gem_create_ioctl+0x4bc/0xc10
>>  drm_ioctl_kernel+0x300/0x410
>>  drm_ioctl+0x648/0xb30
>>  amdgpu_drm_ioctl+0xc8/0x160
>>  </TASK>
>>
>> Allocated by task 219:
>>  kmalloc_trace+0x211/0x390
>>  amdgpu_vram_mgr_new+0x1d6/0xbe0
>>  ttm_resource_alloc+0xfd/0x1e0
>>  ttm_bo_mem_space+0x255/0x940
>>  ttm_bo_validate+0x286/0x650
>>  ttm_bo_init_reserved+0x34c/0x490
>>  amdgpu_bo_create+0x94b/0x1610
>>  amdgpu_bo_create_user+0xa3/0x130
>>  amdgpu_gem_create_ioctl+0x4bc/0xc10
>>  drm_ioctl_kernel+0x300/0x410
>>  drm_ioctl+0x648/0xb30
>>  amdgpu_drm_ioctl+0xc8/0x160
>>
>> Freed by task 219:
>>  kfree+0x111/0x2d0
>>  ttm_resource_free+0x17e/0x1e0
>>  ttm_bo_move_accel_cleanup+0x77e/0x9b0
>>  amdgpu_move_blit+0x3db/0x670
>>  amdgpu_bo_move+0xfa2/0x1550
>>  ttm_bo_handle_move_mem+0x4d0/0x700
>>  ttm_mem_evict_first+0x945/0x1230
>>  ttm_bo_mem_space+0x6c7/0x940
>>  ttm_bo_validate+0x286/0x650
>>  ttm_bo_init_reserved+0x34c/0x490
>>  amdgpu_bo_create+0x94b/0x1610
>>  amdgpu_bo_create_user+0xa3/0x130
>>  amdgpu_gem_create_ioctl+0x4bc/0xc10
>>  drm_ioctl_kernel+0x300/0x410
>>  drm_ioctl+0x648/0xb30
>>  amdgpu_drm_ioctl+0xc8/0x160
>>
>> The buggy address belongs to the object at ffff88800f5bee70
>>  which belongs to the cache kmalloc-96 of size 96
>> The buggy address is located 16 bytes inside of
>>  freed 96-byte region [ffff88800f5bee70, ffff88800f5beed0)
>>
>> Should you need any more information, please do not hesitate to contact
>> us.
>>
>> Best regards,
>> Joonkyo Jung
>>
>

--000000000000026ea106132132ec
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div><div dir=3D"ltr">Hi Vitaly,<br><br>No worries, thank you for working o=
n the patches!<br><br>I have also confirmed that with the inflight patch, i=
ssue No.1 (use-after-free) seems to be resolved.<br>However, I have reprodu=
ced issue No.3 (slab-use-after-free) even with the patch for issue No.1 app=
lied - if it&#39;s the first program tested after reboot.<br>(i.e., if any =
other bugs are tested before the slab-use-after-free, it does not reproduce=
).<br><br>Could you check if the bug reproduces in this condition for you t=
oo?<br>I will check and see why this is happening and update you if I have =
something new.<br><br>Thank you!<br><br>Best,<br>Joonkyo</div></div><div><d=
iv dir=3D"ltr"><br><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" clas=
s=3D"gmail_attr">On Fri, Mar 8, 2024 at 12:45=E2=80=AFPM vitaly prosyak &lt=
;<a href=3D"mailto:vprosyak@amd.com" target=3D"_blank">vprosyak@amd.com</a>=
&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px =
0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><u><=
/u>

 =20
  <div>
    <p>Hi Joonkyo,<br>
      Sorry for the delay. <br>
      Yes, sure, I reproduced issue 2 (null-ptr-deref in amdgpu) and I
      will provide the fix soon.<br>
      However, issue No. 3 is no longer reproducible if the recent patch
      inflight is applied which fixes issue No 1.</p>
    <p>Do you see the same behavior?<br>
    </p>
    <p>Thanks in advance, Vitaly<br>
    </p>
    <div>On 2024-03-07 20:18, Joonkyo Jung
      wrote:<br>
    </div>
    <blockquote type=3D"cite">
     =20
      <div>
        <div>
          <div dir=3D"auto" style=3D"font-family:-apple-system,helveticaneu=
e;font-size:15px;font-style:normal;font-weight:400;letter-spacing:normal;te=
xt-indent:0px;text-transform:none;white-space:normal;word-spacing:0px;text-=
decoration:none;background-color:rgba(0,0,0,0);border-color:rgb(0,0,0);colo=
r:rgb(0,0,0)">Hello,=C2=A0</div>
          <div dir=3D"auto" style=3D"font-family:-apple-system,helveticaneu=
e;font-size:15px;font-style:normal;font-weight:400;letter-spacing:normal;te=
xt-indent:0px;text-transform:none;white-space:normal;word-spacing:0px;text-=
decoration:none;background-color:rgba(0,0,0,0);border-color:rgb(0,0,0);colo=
r:rgb(0,0,0)">thank
            you for patching the first bug we have sent!</div>
          <div dir=3D"auto" style=3D"font-family:-apple-system,helveticaneu=
e;font-size:15px;font-style:normal;font-weight:400;letter-spacing:normal;te=
xt-indent:0px;text-transform:none;white-space:normal;word-spacing:0px;text-=
decoration:none;background-color:rgba(0,0,0,0);border-color:rgb(0,0,0);colo=
r:rgb(0,0,0)"><br>
          </div>
          <div dir=3D"auto" style=3D"font-family:-apple-system,helveticaneu=
e;font-size:15px;font-style:normal;font-weight:400;letter-spacing:normal;te=
xt-indent:0px;text-transform:none;white-space:normal;word-spacing:0px;text-=
decoration:none;background-color:rgba(0,0,0,0);border-color:rgb(0,0,0);colo=
r:rgb(0,0,0)">Just
            a quick touch base with you, to ask if there has been any
            update on our other two bugs.</div>
          <div dir=3D"auto" style=3D"font-family:-apple-system,helveticaneu=
e;font-size:15px;font-style:normal;font-weight:400;letter-spacing:normal;te=
xt-indent:0px;text-transform:none;white-space:normal;word-spacing:0px;text-=
decoration:none;background-color:rgba(0,0,0,0);border-color:rgb(0,0,0);colo=
r:rgb(0,0,0)">They
            were each sent with emails titled=C2=A0</div>
          <div dir=3D"auto" style=3D"font-family:-apple-system,helveticaneu=
e;font-size:15px;font-style:normal;font-weight:400;letter-spacing:normal;te=
xt-indent:0px;text-transform:none;white-space:normal;word-spacing:0px;text-=
decoration:none;background-color:rgba(0,0,0,0);border-color:rgb(0,0,0);colo=
r:rgb(0,0,0)">&quot;Reporting
            a slab-use-after-free in amdgpu&quot; (this one)</div>
          <div dir=3D"auto" style=3D"font-family:-apple-system,helveticaneu=
e;font-size:15px;font-style:normal;font-weight:400;letter-spacing:normal;te=
xt-indent:0px;text-transform:none;white-space:normal;word-spacing:0px;text-=
decoration:none;background-color:rgba(0,0,0,0);border-color:rgb(0,0,0);colo=
r:rgb(0,0,0)">&quot;Reporting
            a null-ptr-deref in amdgpu&quot;.=C2=A0</div>
          <div dir=3D"auto" style=3D"font-family:-apple-system,helveticaneu=
e;font-size:15px;font-style:normal;font-weight:400;letter-spacing:normal;te=
xt-indent:0px;text-transform:none;white-space:normal;word-spacing:0px;text-=
decoration:none;background-color:rgba(0,0,0,0);border-color:rgb(0,0,0);colo=
r:rgb(0,0,0)"><br>
          </div>
          <div dir=3D"auto" style=3D"font-family:-apple-system,helveticaneu=
e;font-size:15px;font-style:normal;font-weight:400;letter-spacing:normal;te=
xt-indent:0px;text-transform:none;white-space:normal;word-spacing:0px;text-=
decoration:none;background-color:rgba(0,0,0,0);border-color:rgb(0,0,0);colo=
r:rgb(0,0,0)">Thank
            you!=C2=A0</div>
          <div dir=3D"auto" style=3D"font-family:-apple-system,helveticaneu=
e;font-size:15px;font-style:normal;font-weight:400;letter-spacing:normal;te=
xt-indent:0px;text-transform:none;white-space:normal;word-spacing:0px;text-=
decoration:none;background-color:rgba(0,0,0,0);border-color:rgb(0,0,0);colo=
r:rgb(0,0,0)"><br>
          </div>
          <div dir=3D"auto" style=3D"font-family:-apple-system,helveticaneu=
e;font-size:15px;font-style:normal;font-weight:400;letter-spacing:normal;te=
xt-indent:0px;text-transform:none;white-space:normal;word-spacing:0px;text-=
decoration:none;background-color:rgba(0,0,0,0);border-color:rgb(0,0,0);colo=
r:rgb(0,0,0)">Best,=C2=A0</div>
          <div dir=3D"auto" style=3D"font-family:-apple-system,helveticaneu=
e;font-size:15px;font-style:normal;font-weight:400;letter-spacing:normal;te=
xt-indent:0px;text-transform:none;white-space:normal;word-spacing:0px;text-=
decoration:none;background-color:rgba(0,0,0,0);border-color:rgb(0,0,0);colo=
r:rgb(0,0,0)">Joonkyo</div>
        </div>
        <br>
      </div>
      <div><br>
        <div class=3D"gmail_quote">
          <div dir=3D"ltr" class=3D"gmail_attr">2024=EB=85=84 2=EC=9B=94 16=
=EC=9D=BC (=EA=B8=88) =EC=98=A4=ED=9B=84 6:22,
            Joonkyo Jung &lt;<a href=3D"mailto:joonkyoj@yonsei.ac.kr" targe=
t=3D"_blank">joonkyoj@yonsei.ac.kr</a>&gt;=EB=8B=98=EC=9D=B4
            =EC=9E=91=EC=84=B1:<br>
          </div>
          <blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8=
ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
            <div dir=3D"ltr">Hello,<br>
              <br>
              We would like to report a slab-use-after-free bug in the
              AMDGPU DRM driver in the linux kernel v6.8-rc4 that we
              found with our customized Syzkaller.<br>
              The bug can be triggered by sending two ioctls to the
              AMDGPU DRM driver in succession.<br>
              <br>
              In amdgpu_bo_move, struct ttm_resource *old_mem =3D
              bo-&gt;resource is assigned.<br>
              As you can see on the alloc &amp; free stack calls, on the
              same function amdgpu_bo_move,<br>
              amdgpu_move_blit in the end frees bo-&gt;resource at
              ttm_bo_move_accel_cleanup with ttm_bo_wait_free_node(bo,
              man-&gt;use_tt).<br>
              But amdgpu_bo_move continues after that, reaching
              trace_amdgpu_bo_move(abo, new_mem-&gt;mem_type,
              old_mem-&gt;mem_type) at the end, causing the
              use-after-free bug.<br>
              <br>
              Steps to reproduce are as below.<br>
              union drm_amdgpu_gem_create *arg1;<br>
              <br>
              arg1 =3D malloc(sizeof(union drm_amdgpu_gem_create));<br>
              arg1-&gt;in.bo_size =3D 0x8;<br>
              arg1-&gt;in.alignment =3D 0x0;<br>
              arg1-&gt;in.domains =3D 0x4;<br>
              arg1-&gt;in.domain_flags =3D 0x9;<br>
              ioctl(fd, 0xc0206440, arg1);<br>
              <br>
              arg1-&gt;in.bo_size =3D 0x7fffffff;<br>
              arg1-&gt;in.alignment =3D 0x0;<br>
              arg1-&gt;in.domains =3D 0x4;<br>
              arg1-&gt;in.domain_flags =3D 0x9;<br>
              ioctl(fd, 0xc0206440, arg1);<br>
              <br>
              The KASAN report is as follows:<br>
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>
              BUG: KASAN: slab-use-after-free in
              amdgpu_bo_move+0x1479/0x1550<br>
              Read of size 4 at addr ffff88800f5bee80 by task
              syz-executor/219<br>
              Call Trace:<br>
              =C2=A0&lt;TASK&gt;<br>
              =C2=A0amdgpu_bo_move+0x1479/0x1550<br>
              =C2=A0ttm_bo_handle_move_mem+0x4d0/0x700<br>
              =C2=A0ttm_mem_evict_first+0x945/0x1230<br>
              =C2=A0ttm_bo_mem_space+0x6c7/0x940<br>
              =C2=A0ttm_bo_validate+0x286/0x650<br>
              =C2=A0ttm_bo_init_reserved+0x34c/0x490<br>
              =C2=A0amdgpu_bo_create+0x94b/0x1610<br>
              =C2=A0amdgpu_bo_create_user+0xa3/0x130<br>
              =C2=A0amdgpu_gem_create_ioctl+0x4bc/0xc10<br>
              =C2=A0drm_ioctl_kernel+0x300/0x410<br>
              =C2=A0drm_ioctl+0x648/0xb30<br>
              =C2=A0amdgpu_drm_ioctl+0xc8/0x160<br>
              =C2=A0&lt;/TASK&gt;<br>
              <br>
              Allocated by task 219:<br>
              =C2=A0kmalloc_trace+0x211/0x390<br>
              =C2=A0amdgpu_vram_mgr_new+0x1d6/0xbe0<br>
              =C2=A0ttm_resource_alloc+0xfd/0x1e0<br>
              =C2=A0ttm_bo_mem_space+0x255/0x940<br>
              =C2=A0ttm_bo_validate+0x286/0x650<br>
              =C2=A0ttm_bo_init_reserved+0x34c/0x490<br>
              =C2=A0amdgpu_bo_create+0x94b/0x1610<br>
              =C2=A0amdgpu_bo_create_user+0xa3/0x130<br>
              =C2=A0amdgpu_gem_create_ioctl+0x4bc/0xc10<br>
              =C2=A0drm_ioctl_kernel+0x300/0x410<br>
              =C2=A0drm_ioctl+0x648/0xb30<br>
              =C2=A0amdgpu_drm_ioctl+0xc8/0x160<br>
              <br>
              Freed by task 219:<br>
              =C2=A0kfree+0x111/0x2d0<br>
              =C2=A0ttm_resource_free+0x17e/0x1e0<br>
              =C2=A0ttm_bo_move_accel_cleanup+0x77e/0x9b0<br>
              =C2=A0amdgpu_move_blit+0x3db/0x670<br>
              =C2=A0amdgpu_bo_move+0xfa2/0x1550<br>
              =C2=A0ttm_bo_handle_move_mem+0x4d0/0x700<br>
              =C2=A0ttm_mem_evict_first+0x945/0x1230<br>
              =C2=A0ttm_bo_mem_space+0x6c7/0x940<br>
              =C2=A0ttm_bo_validate+0x286/0x650<br>
              =C2=A0ttm_bo_init_reserved+0x34c/0x490<br>
              =C2=A0amdgpu_bo_create+0x94b/0x1610<br>
              =C2=A0amdgpu_bo_create_user+0xa3/0x130<br>
              =C2=A0amdgpu_gem_create_ioctl+0x4bc/0xc10<br>
              =C2=A0drm_ioctl_kernel+0x300/0x410<br>
              =C2=A0drm_ioctl+0x648/0xb30<br>
              =C2=A0amdgpu_drm_ioctl+0xc8/0x160<br>
              <br>
              The buggy address belongs to the object at
              ffff88800f5bee70<br>
              =C2=A0which belongs to the cache kmalloc-96 of size 96<br>
              The buggy address is located 16 bytes inside of<br>
              =C2=A0freed 96-byte region [ffff88800f5bee70, ffff88800f5beed=
0)<br>
              <br>
              Should you need any more information, please do not
              hesitate to contact us.<br>
              <br>
              Best regards,<br>
              Joonkyo Jung<br>
            </div>
          </blockquote>
        </div>
      </div>
    </blockquote>
  </div>

</blockquote></div></div>
</div>

--000000000000026ea106132132ec--
