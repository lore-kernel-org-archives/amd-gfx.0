Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8269F357DA
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Feb 2026 14:33:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5DF1C10E593;
	Tue, 24 Feb 2026 14:33:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="YaQsEo6J";
	dkim-atps=neutral
Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 15F5310E591
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Feb 2026 14:33:01 +0000 (UTC)
Received: by mail-dl1-f54.google.com with SMTP id
 a92af1059eb24-12736a0147cso373182c88.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Feb 2026 06:33:01 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771943580; cv=none;
 d=google.com; s=arc-20240605;
 b=Oy6i/f06fbuHOUenOCoqY1lVgPrtmUQ5n4hn/1wjjDD1tDxteYB6merZh0UBWf3Rj8
 IzbdGle33+xtMstMeUTqbVOao+011vbQFPw/91Ivej1ntgvH8wdF7s35kAfO+C5mpL4M
 8okD35s2F9Zhs7nsk1N8Qndzyl7kohMKLrvoXETMgnoaALzFZvkByZ6YrFOWU/HAv5he
 P8jooLO/85G0tFlFMGuauOlVFvSbUnFBYHeBNTIwZ7Ttv1/pGJ4HvaOp59/pOgKD+Agj
 SauUssQoILoABGbibzbEehtfbel0RaUg/4LPvPUGUAJAVUV1i4S1LeOQktooUAkA2UKi
 +/DA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=CDrORiDeLR4kaXGmMZ3Y4bvwbgrw4APixwLtQi/SAto=;
 fh=XHHKLX+HgSTJF/HMUIc3EtqJ8FJsUKx1Uo8pey24mnY=;
 b=Bs9jCPMcRhyDwYggmhDCcm+pdWPndkcGEUFmWBD15ZlVJOSLk1k4WbJqmLZoE21fPd
 ei0fO3OnCRuLjc4NsDDFu4+vfpOlWh6ITVx2YHHfDSgskVXxeUAVAdYaIVCjRzv5rNlh
 +erVxSBWTUaR98NblpT8JVC+TrBk8V028kTA3OCPHZX+RBx8D/t9860mLSJUeZDB8pzs
 q9/ZtfNS4N2OuJC5NhQ3srxwnX6I7uWRsMBME0E8U2avVh++h4Hk+4vEC5Xl2v3tKqUo
 3hT3Yp98l55PO4hyGWxD/7MHuLOI4/KsrT1OTdPJ678O7jx4irgWROEtG7Zocqwz8nek
 V1Tg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1771943580; x=1772548380; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CDrORiDeLR4kaXGmMZ3Y4bvwbgrw4APixwLtQi/SAto=;
 b=YaQsEo6JHulF3Mcm8u3CNa6tN9p+WcEaBS+CD+zI5pLfP6LiUOCWwqwEUxt45bO6YE
 UGnKLhZIjsZEqsa6oLoRcK/6Bm4QHktl9JUDNfLp/r8T52TBuDRzku5QlvEHQ26jrpPK
 xAVr9JnNbaVNfS9pRzOTutd73Yr01NnTrUGOjLevD3+a7LBU7pUMs4VfRLD8n0/oakop
 xBieoHk2H6iXTrV4WfdSpS0vMftsapI3AZBmK8ZvBEXNHH0IdDfAP/RJCNyYqze09nGS
 LT8OpLvo1WZOa5/VBMZIM0wmt3owxwtYFuvSFuBu50YAShE1Zm6BfNsKSNgQ5O5MatNZ
 ynUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771943580; x=1772548380;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=CDrORiDeLR4kaXGmMZ3Y4bvwbgrw4APixwLtQi/SAto=;
 b=XF3QodsB5MqDGV1lOIJUWd9TH4IAOkT+CLNRyPpzbyF+b8ub+38RZTpYksim+LsqsL
 5r5BwX14lGa5TWrZEgsJxrmcktY6maqgj66XTEEm0lb+xa9K4P+b4qcoAkXMU42N7cz2
 972jJFeRQ412ecjylCt3b7tMG1534GM+425oG1mPE+L5h6KohvYxp8ljwvopkVlzqISW
 T/xrhTA5e0o6gVhTBTckNzKxJQyrvlWH4sKvMlURHHixiUYPo76jTsTujjc1sPKhUAY8
 uNXnWBQENd4aQtJuf8Afe6DLV0fcYDW0PdO7Hq0qKG2KbcWWyGuu0RFv6o7iKWvvwjzT
 j/Fw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXnuQ3pNlqR30z7wpIRjkWG6BrT8Teu2RH26Jpg7+lO16/BfuG/7aAFJFtFVATehrXDdUDc5hHe@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yzd+wPHILFAuPcku4JnGl0+6Rs/qcumORc8I8WnVKkuvZW3z0RV
 qCAMSHMKdqevqAMbFp+alsv6phpMIQMhCiG3i20Gu2+lJS2PVJnNpbvdXADjFtVIggoN2TfoW1P
 nBV1r4RprbEfsNzhUeU1y3eVzKVtILY8=
X-Gm-Gg: AZuq6aKhKfedO9NICbVct1BVB0RoFWlgjPk6DgGJPAq/vaVAYtsIvqm7dudB8C9L9sy
 T5T8bA59VZ2zBBQBXy7N/GLhW+yIt90toqbLN5G6eDL0WaVUD5LCqhqbygKFssLjETh+SqdUUG0
 /g/C78YINsuxrzvK27kt5y+XRtiBEstQ/oklAFnXGvZU0vEB0N64V9BaaMxOTppa11QN+40i2oM
 +bDRdsx+aCZ/QG+z3STxrXAXlGYgIjpZJ9XBR7U83n4DMF53Y2WJh5d7zRu1Q0XJNvDU3E0DQk1
 Lcr80FEkYywUL/RGtr3tqfwFS8QwH5mae8JBDpdOuzZMUm+eO9kIB/yp6LpMrJGQd+4xPg==
X-Received: by 2002:a05:7022:6995:b0:11a:2020:ac85 with SMTP id
 a92af1059eb24-1276ad0a535mr2422324c88.4.1771943580236; Tue, 24 Feb 2026
 06:33:00 -0800 (PST)
MIME-Version: 1.0
References: <20260223215118.2154194-1-bvanassche@acm.org>
 <20260223215118.2154194-9-bvanassche@acm.org>
 <9041d720-7cc9-4a2d-a5bf-1ed6ce7c4640@amd.com>
In-Reply-To: <9041d720-7cc9-4a2d-a5bf-1ed6ce7c4640@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 24 Feb 2026 09:32:48 -0500
X-Gm-Features: AaiRm53cf3vckqTudlxKM07ExYaC5eFxJ5ZmYsz7t99igMYYFOT3F2MhM0KsnwE
Message-ID: <CADnq5_OWyj=_u41zhYH14yY+Q4Cos3hbedtKgeSq1CPz7xZfNA@mail.gmail.com>
Subject: Re: [PATCH 08/62] drm/amdgpu: Fix locking bugs in error paths
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Bart Van Assche <bvanassche@acm.org>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
 Boqun Feng <boqun@kernel.org>, 
 Waiman Long <longman@redhat.com>, linux-kernel@vger.kernel.org, 
 Marco Elver <elver@google.com>, Christoph Hellwig <hch@lst.de>,
 Steven Rostedt <rostedt@goodmis.org>, 
 Nick Desaulniers <ndesaulniers@google.com>,
 Nathan Chancellor <nathan@kernel.org>, Kees Cook <kees@kernel.org>, 
 Jann Horn <jannh@google.com>, Alex Deucher <alexander.deucher@amd.com>, 
 YiPeng Chai <YiPeng.Chai@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>, 
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

Applied.  Thanks!

On Tue, Feb 24, 2026 at 3:54=E2=80=AFAM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
> On 2/23/26 22:50, Bart Van Assche wrote:
> > Do not unlock psp->ras_context.mutex if it has not been locked. This ha=
s
> > been detected by the Clang thread-safety analyzer.
> >
> > Cc: Alex Deucher <alexander.deucher@amd.com>
> > Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
> > Cc: YiPeng Chai <YiPeng.Chai@amd.com>
> > Cc: Hawking Zhang <Hawking.Zhang@amd.com>
> > Cc: amd-gfx@lists.freedesktop.org
> > Fixes: b3fb79cda568 ("drm/amdgpu: add mutex to protect ras shared memor=
y")
> > Signed-off-by: Bart Van Assche <bvanassche@acm.org>
>
> Acked-by: Christian K=C3=B6nig <christian.koenig@amd.com>
>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.c | 12 +++++++-----
> >  1 file changed, 7 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.c b/drivers/gpu/d=
rm/amd/amdgpu/amdgpu_psp_ta.c
> > index 6e8aad91bcd3..0d3c18f04ac3 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.c
> > @@ -332,13 +332,13 @@ static ssize_t ta_if_invoke_debugfs_write(struct =
file *fp, const char *buf, size
> >       if (!context || !context->initialized) {
> >               dev_err(adev->dev, "TA is not initialized\n");
> >               ret =3D -EINVAL;
> > -             goto err_free_shared_buf;
> > +             goto free_shared_buf;
> >       }
> >
> >       if (!psp->ta_funcs || !psp->ta_funcs->fn_ta_invoke) {
> >               dev_err(adev->dev, "Unsupported function to invoke TA\n")=
;
> >               ret =3D -EOPNOTSUPP;
> > -             goto err_free_shared_buf;
> > +             goto free_shared_buf;
> >       }
> >
> >       context->session_id =3D ta_id;
> > @@ -346,7 +346,7 @@ static ssize_t ta_if_invoke_debugfs_write(struct fi=
le *fp, const char *buf, size
> >       mutex_lock(&psp->ras_context.mutex);
> >       ret =3D prep_ta_mem_context(&context->mem_context, shared_buf, sh=
ared_buf_len);
> >       if (ret)
> > -             goto err_free_shared_buf;
> > +             goto unlock;
> >
> >       ret =3D psp_fn_ta_invoke(psp, cmd_id);
> >       if (ret || context->resp_status) {
> > @@ -354,15 +354,17 @@ static ssize_t ta_if_invoke_debugfs_write(struct =
file *fp, const char *buf, size
> >                       ret, context->resp_status);
> >               if (!ret) {
> >                       ret =3D -EINVAL;
> > -                     goto err_free_shared_buf;
> > +                     goto unlock;
> >               }
> >       }
> >
> >       if (copy_to_user((char *)&buf[copy_pos], context->mem_context.sha=
red_buf, shared_buf_len))
> >               ret =3D -EFAULT;
> >
> > -err_free_shared_buf:
> > +unlock:
> >       mutex_unlock(&psp->ras_context.mutex);
> > +
> > +free_shared_buf:
> >       kfree(shared_buf);
> >
> >       return ret;
>
