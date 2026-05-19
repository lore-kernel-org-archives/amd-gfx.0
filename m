Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E30CCD4F5E
	for <amd-gfx@archiver.kernel.org>; Tue, 19 May 2026 16:23:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8374A10ED9C;
	Tue, 19 May 2026 16:23:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="GvBIcgVS";
	dkim-atps=neutral
Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4363010ED9C
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 May 2026 16:23:55 +0000 (UTC)
Received: by mail-dl1-f53.google.com with SMTP id
 a92af1059eb24-134e41fee21so139657c88.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 May 2026 09:23:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779207834; cv=none;
 d=google.com; s=arc-20240605;
 b=hMuG3j2jdGs4ksogYCbRxkq4RLtjiaEfXXistJEDqbqONBHachLXLy7e4aGpB5p23A
 ew+lqC+n8r1MSFnNbT51/J9wHo1yWij1c696N74gRWCsESzZ50iV8UyYQkanc4iv6V2t
 +2YGsiOST0Qm4zq42h3uDVKrx3ep0wSplAEPaJ5Py2hGizbsHWgj5ZOwGaZ16Ti+9C7q
 W9/qXV+jJ+CXi+pJCPEpu6cFQ3WRdDD7pH+nmunnl8XRWDDo4s34ILX0eTxW1A5tqV5i
 OAnaslkqHXAwWIUK2FwaFqjrk578QytPg1UTQ3+ejr6hv6WbCDE54Xg4AJiBWEgaV/mY
 U8Ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=T+zeIzpyK0qjlPU0AuWsjL1v+AbG68v3PvQfqVL8RKo=;
 fh=328T9GRFRZ0Ry2IYaUGQb2Y6Pxk1+sxW1A/L2dQeS2g=;
 b=gMu9E9MdyBQtM1wAGEa0F05L0YrkjVzQlKgERTRbeFlM8daW9jSk+zyKicAjvaFcO+
 CtUSLBcUZkhTWNwdF7ti94q22JI4XGlU3KDk9cT78e1sL3z2jbB1WvLRe/9RHRR3UgqR
 RwntoeDHeEZQlt/J8RiORcwK7k8oP3dDJdTkc/BZwjK9JZebfKio1wbA5XWuiFdlIN+s
 iE7vlF7YCRqf2Yo44lTUj8JNHbl2WqXWp42VDOMXR6O2mKiGqUHG9jU+GHlOXi3KlJ0t
 223tQSrO4Y/OC2SuIhuWlWwzvoBKUJZRG/Vven8/54j5D4QeFEHbWBASwevjxve7jMOm
 sz2A==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779207834; x=1779812634; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=T+zeIzpyK0qjlPU0AuWsjL1v+AbG68v3PvQfqVL8RKo=;
 b=GvBIcgVSo7inuBg45aCb03r7z1D7dD1SVYpdxAwPIEXbBtPeC3pstxDYq6QwldatK9
 eORZxR8s/+YzsrPzEktdFy75raOhHJmYMri8dfS9fGiOek+dnLIOVvlTbfuSysuKlxKQ
 o5XiF4buLn7RVqiKXDZ9493Y+xvXF+EnIDZmJctnCd5BKIOIcIPuVLifev+l8BvIz+2U
 idIpPqa/1n4Q7BenDT0HSEPqtiQ/lO9bfOocb7UV1p1r1JMVnQaw0j09aq5My2gVA56v
 Aaq3RLc1+/bRpTYRadsaI9BrqSI/ICmZFE3qtxoCTnUw/OKd5UweMVgAQY0TwtlH3J2N
 fUgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779207834; x=1779812634;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=T+zeIzpyK0qjlPU0AuWsjL1v+AbG68v3PvQfqVL8RKo=;
 b=mtDt4EU+k2k4oS06VwzSQNYsV0dywG9ZJgSuS6HfPQJoA8sCsbg3sIBfUD8SOWEla1
 MnPFJOlx6M44y+2GzFwZWQIWSDxc/GCg57U543xrk8O461lY8DR0etXzLTbHYHCxfsrk
 E+VpRTjbpN3HWQ3Ao/Trr3AsnG5pV8zlZtXzzOKCSqIfGpsz6XQfqEzFJR8TUEoQakw/
 rrX62X2yma5cPH0jR7BGE+mq2n8tIFHQ4ocwKHBbRG4IqV61sWP61C7kdKb/y0ME/3pe
 +zZE9et9vcLMiIlRAWjG7R44RAcNVCwUDhtTSsYkNewJQWf5G2FFjrY3FYTVD40h3nvT
 Ez5g==
X-Gm-Message-State: AOJu0YxJfSiguqquV7qWTVMWSBRRkfYPhtKP0LsfWFdyf14ka9yV/s4w
 yNNFJPqm7CGbQiOdgRiGymsPsv3vH+NsiqTF+1wpXTDqdeDmd0fD3e+T+364d8NX1f+WRRIIUFl
 E7bGnkdLATAwqzMzjxPW0ChaxV3wCkDE=
X-Gm-Gg: Acq92OGVeeLYRTzy1bidrZiX1OWK4t+F5agX9lmgfQ6YQwIVXWrv5XbV2xF1YIFktzG
 P7PLjIGMYRaENnpH9ehxzyKg8n6JYUMFR4JaL3xMooLp9WKbDYz4+hfUlG/46NByopcyZN29sGV
 aOXM9UB+gUrJP/wFqBD+CgQ9fR+X8bqkDu7WTbRpvbyj+XUphgRA1Z3lPvvNF8O4JZJDEST2h3t
 VTYRTxecvUfDvpNGVnLi4EyNfqOlj0VPmkBxiUUz0SFcUPIfU9iCLtLRXkEG278GEhVZEHM5qFY
 SYYFnMomDgBZ+TQ4WjA9zn+9ULIPt8ECM1Y8RKkQ87qQeTbmJYxLrWn6ym0ZKwDY17H5riBqR9X
 KT+h5
X-Received: by 2002:a05:7022:4596:b0:12c:888b:aaab with SMTP id
 a92af1059eb24-1350451b228mr3618786c88.0.1779207834463; Tue, 19 May 2026
 09:23:54 -0700 (PDT)
MIME-Version: 1.0
References: <20260512150535.75401-1-jinhuieric.huang@amd.com>
In-Reply-To: <20260512150535.75401-1-jinhuieric.huang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 19 May 2026 12:23:42 -0400
X-Gm-Features: AVHnY4IjYworgOFTMfVUonEft6h6X1OeDYCbQgIMxUhaLS_acLfJr2ikzMI8qk0
Message-ID: <CADnq5_MzA_-tjzGcTesehuvkZ=0+=jgQuAbQzR5HXLctSGF=YA@mail.gmail.com>
Subject: Re: [PATCH] drm/amdkfd: fix a vulnerability of integer overflow in
 kfd debugger
To: Eric Huang <jinhuieric.huang@amd.com>
Cc: amd-gfx@lists.freedesktop.org
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

On Tue, May 12, 2026 at 11:24=E2=80=AFAM Eric Huang <jinhuieric.huang@amd.c=
om> wrote:
>
> get_queue_ids() computes array_size =3D num_queues * sizeof(uint32_t),
> which could overflow on 32-bit size_t build. using array_size()
> instead, it saturates to SIZE_MAX on overflow.
>
> Signed-off-by: Eric Huang <jinhuieric.huang@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/driv=
ers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> index 2e6923528342..b34f29501ff8 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> @@ -3468,12 +3468,14 @@ static void copy_context_work_handler(struct work=
_struct *work)
>
>  static uint32_t *get_queue_ids(uint32_t num_queues, uint32_t *usr_queue_=
id_array)
>  {
> -       size_t array_size =3D num_queues * sizeof(uint32_t);
> -
>         if (!usr_queue_id_array)
>                 return NULL;
>
> -       return memdup_user(usr_queue_id_array, array_size);
> +       if (num_queues > KFD_MAX_NUM_OF_QUEUES_PER_PROCESS)
> +               return ERR_PTR(-EINVAL);
> +
> +       return memdup_user(usr_queue_id_array,
> +                          array_size(num_queues, sizeof(uint32_t)));
>  }
>
>  int resume_queues(struct kfd_process *p,
> --
> 2.34.1
>
