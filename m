Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 363A3FD8FD2
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Feb 2026 16:09:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D402D10E9A6;
	Thu, 26 Feb 2026 16:09:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="fwljDLQq";
	dkim-atps=neutral
Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3D6EA10E9A6
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Feb 2026 16:09:52 +0000 (UTC)
Received: by mail-dl1-f47.google.com with SMTP id
 a92af1059eb24-124713e4244so22493c88.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Feb 2026 08:09:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772122191; cv=none;
 d=google.com; s=arc-20240605;
 b=JCefMNfy4fpKbj2KzrtNhGdyADf8qjflF8/8q6FhDAn8Mx38nwXtrsZbRdXXGdhKaJ
 JkjvD25fju2EN2oco5/7TWNfiuWNvEwBfRWa8+MtwXeqczUrYvxYkY6byeipw0j2QAOh
 bc2sd8HJsft2oBNJncSzFW1pTIo+imjD1p9GceJU82toiJBPxZTwyOBsiVxHna5aENJv
 35twTU2u6HW5PnbMBiD1oQKK15OYN22ejbV72BZeTw/8Lys85baelTL4wbH/L3UaqVWx
 5nHG/OBRNfntKfoSRKW2CLuY2M8BtGxk4t+GtsthvF08dvIvj2GYgbVt472s+5xwwqcd
 rs2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=ap++YtL66V8YHV9/UDMB1voltqT/IaoAu1jqaTGNrx0=;
 fh=d1QW0OgK3aTinW1TLocwY2JGZq2DZ4BtQXlbeZ+K+oU=;
 b=hySonoxmxIhQtUNwuoQ4nu2T9hqenYV37yn+/Os8L7pnWqMBvwJN7XMdg0ZDicFvay
 SeeBgXpkqqZqQiIBh5idU/SBtg/bqpO498sZoRm44lQbES9hXP79bq5LB7NRPEHLU8e2
 l6xKCX+ISACVT9uVxKNgtkJhS2QbTLzQWX9xH8M+KbLYcHa6a2XHofW8ebMPkW//dnLi
 xgTzfgFsGy71zNAC8BCSxhwAwgfFYYRIhuJJ+D+8aDfbyGn4L6KTHqfbP1B6epkyPZs7
 O5BtcjaRgGEq3NwU5PEB9Ih1lu16he0t8JfYnxsnb5FbY9cjxAz6y5Xt133Zu1k+f+V6
 0AbA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772122191; x=1772726991; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ap++YtL66V8YHV9/UDMB1voltqT/IaoAu1jqaTGNrx0=;
 b=fwljDLQqoNs6B3Jdr6j4/BO67BDUfnDH9OqHHZ17lpsyjcEcDhENeuMzYAZC9O0GB9
 cRX3gTA7c8h4fSIHJqrSqCwsrjDjaCaXCc0hSA8nbbkAGo1kQawJj1OfZ2hkZTD0LarR
 lKAfUrn/c9zuC83rW1LrleGjw81t3J0hDhgymYRBDMpYSyOLLNPa72P7UVJ3dGF/w6tQ
 G/iCptN8yMJiNlauSx0L5iKIFoTqV35a56Ksy+q+xs64vFJkQPON445pZlCy6wuaYrZu
 3/f7YguEpBkTzHTor4l5pWxDUmb50r0mA9KyuuKNqkJP+jb4LBuZDGiRKo8zWbvxutnA
 IvkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772122191; x=1772726991;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ap++YtL66V8YHV9/UDMB1voltqT/IaoAu1jqaTGNrx0=;
 b=ncrnQlu58sew/SR8inbOBn8JmekyWruEP4NVZbZ7AxAsi9kMnIXI1i1HGQowirhVSM
 UoX5ZMy97VY002iTdeBTonSbWXe6qf5us/McaGBAysOisb/3GXsIFxPOGfV9FP6w4LXY
 iBIdlDhB2pFqhHEueSZTMBYfupMtzIbByIlC0WacZMx7cs04Ly72jLpDIaZi68z3tBpf
 BHtBLWDW9OeG0Y/cNb+mugTKgdnDb9c/vMWMBTsWmTivAAn+oDGSkTRGMsMPaVYodX3u
 19vaJSrXh9gttGdKBYq8KI9IuKyerfUrgsVWt4mYUGhCY4IO61TelowYaIq3lV1C5/PN
 UYkQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV2oTVascwQVUaWu42zQEnIfp+xh1Rm+I60mcL+PI5zRBPEcGMl57owZrhjm8aV/2CO8h+T0t0U@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzYVREj41RUqj7RswAdfhKjPAeH+x4iSus1OMVRefRd8odxt4E0
 P4D/4gVQHdTn06Pj6c9FyhCbr3QADGXW98qFCNwE8gKVHHVL7/NeXxcCRyAwgLLs9y8W70MVEc6
 DnQRbuB2fU6SKNZzoM5A1njIo2kGvm90=
X-Gm-Gg: ATEYQzxKYbJb4h0/ftqfH2iBt+zHhw7eib6jbbGyCmwqofHfsK/I/QLdZvypq0T1jAK
 brEGeSptNNVeyW4VsZtDwwxjJEj9L1q2MFGOrWDZoqFi3G9yUh6cfYbJNkG0InCJ5q9+0fVFm2l
 U1GFfcOAAfk8Xyhd0Wsr3vx0fzzJZwTfdlMauUvVIWD8b2OMon0YPJ2UMokVqWF7Pv/DjzFdvG0
 44C2N2GlGKW+c9BO1CqLcFAhFf/4JxAh3KmK/JXIQpo8aOYzjUFA0bExZB99ID5sWGaaVt5VNua
 +9dwtBOHrzCfTFfxw/qr84DBTENzYQEOgiPpeeYORYEZXhQUANWmJ78hFPInuPHDXo5t8pBAEFW
 8LgyH
X-Received: by 2002:a05:7022:ecc:b0:127:332d:62d with SMTP id
 a92af1059eb24-1276ad1bdc8mr4195841c88.6.1772122191235; Thu, 26 Feb 2026
 08:09:51 -0800 (PST)
MIME-Version: 1.0
References: <20260226074241.3150441-1-sunil.khatri@amd.com>
 <CADnq5_M7B++68+Kgo7Eb+y-mco=P9Ov4JT=2HkrubFNYxRVBVw@mail.gmail.com>
 <5b409ab7-7c63-4020-8d96-461cb649ecaf@amd.com>
In-Reply-To: <5b409ab7-7c63-4020-8d96-461cb649ecaf@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 26 Feb 2026 11:09:38 -0500
X-Gm-Features: AaiRm53wcv59_pS49jflCPRDJWSfJQ1gNZRHGj2J5bpMK0Mzgbis5mEUvqI6jhM
Message-ID: <CADnq5_MDB0aFN04X=hhcDrAzpj6mH-jZto=YP4t2xeqrHSjXDw@mail.gmail.com>
Subject: Re: [PATCH v1] drm/amdgpu/userq: change queue id type to u32 from int
To: "Khatri, Sunil" <sukhatri@amd.com>
Cc: Sunil Khatri <sunil.khatri@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
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

On Thu, Feb 26, 2026 at 10:05=E2=80=AFAM Khatri, Sunil <sukhatri@amd.com> w=
rote:
>
>
> On 26-02-2026 08:30 pm, Alex Deucher wrote:
> > On Thu, Feb 26, 2026 at 2:42=E2=80=AFAM Sunil Khatri <sunil.khatri@amd.=
com> wrote:
> >> queue id always remain a positive value and should
> >> be of type unsigned.
> > Does it need to be a u32 or can you just use an unsigned int?
>
> UAPI, where we are returning the queue id is u32 and based on that i
> changed this to u32 only, but i guess unsigned int also should be ok.
>
> whatever you suggest is fine for me.

That's fine.
Acked-by: Alex Deucher <alexander.deucher@amd.com>

>
> Regards
> Sunil khatri
>
> >
> > Alex
> >
> >> With this we also dont need to typecast the id to other
> >> types specially in xarray functions.
> >>
> >> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
> >> ---
> >>   drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 8 ++++----
> >>   1 file changed, 4 insertions(+), 4 deletions(-)
> >>
> >> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/d=
rm/amd/amdgpu/amdgpu_userq.c
> >> index b700c2b91465..e07b2082cf25 100644
> >> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> >> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> >> @@ -447,7 +447,7 @@ static int amdgpu_userq_wait_for_last_fence(struct=
 amdgpu_usermode_queue *queue)
> >>   }
> >>
> >>   static void amdgpu_userq_cleanup(struct amdgpu_usermode_queue *queue=
,
> >> -                                int queue_id)
> >> +                                u32 queue_id)
> >>   {
> >>          struct amdgpu_userq_mgr *uq_mgr =3D queue->userq_mgr;
> >>          struct amdgpu_device *adev =3D uq_mgr->adev;
> >> @@ -461,7 +461,7 @@ static void amdgpu_userq_cleanup(struct amdgpu_use=
rmode_queue *queue,
> >>          uq_funcs->mqd_destroy(queue);
> >>          amdgpu_userq_fence_driver_free(queue);
> >>          /* Use interrupt-safe locking since IRQ handlers may access t=
hese XArrays */
> >> -       xa_erase_irq(&uq_mgr->userq_xa, (unsigned long)queue_id);
> >> +       xa_erase_irq(&uq_mgr->userq_xa, queue_id);
> >>          xa_erase_irq(&adev->userq_doorbell_xa, queue->doorbell_index)=
;
> >>          queue->userq_mgr =3D NULL;
> >>          list_del(&queue->userq_va_list);
> >> @@ -471,7 +471,7 @@ static void amdgpu_userq_cleanup(struct amdgpu_use=
rmode_queue *queue,
> >>   }
> >>
> >>   static struct amdgpu_usermode_queue *
> >> -amdgpu_userq_find(struct amdgpu_userq_mgr *uq_mgr, int qid)
> >> +amdgpu_userq_find(struct amdgpu_userq_mgr *uq_mgr, u32 qid)
> >>   {
> >>          return xa_load(&uq_mgr->userq_xa, qid);
> >>   }
> >> @@ -625,7 +625,7 @@ amdgpu_userq_get_doorbell_index(struct amdgpu_user=
q_mgr *uq_mgr,
> >>   }
> >>
> >>   static int
> >> -amdgpu_userq_destroy(struct drm_file *filp, int queue_id)
> >> +amdgpu_userq_destroy(struct drm_file *filp, u32 queue_id)
> >>   {
> >>          struct amdgpu_fpriv *fpriv =3D filp->driver_priv;
> >>          struct amdgpu_userq_mgr *uq_mgr =3D &fpriv->userq_mgr;
> >> --
> >> 2.34.1
> >>
