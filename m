Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7103CA1005
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Sep 2025 07:53:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5935B10E38D;
	Tue,  2 Sep 2025 07:53:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ct0wm8ur";
	dkim-atps=neutral
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com
 [209.85.221.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6098F10E38D
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Sep 2025 07:53:00 +0000 (UTC)
Received: by mail-wr1-f43.google.com with SMTP id
 ffacd0b85a97d-3ceb9c3d98cso2190784f8f.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 02 Sep 2025 00:53:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756799579; x=1757404379; darn=lists.freedesktop.org;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
 :date:message-id:reply-to;
 bh=cyt1DdyHr3oTtevDVluqppot2qFn6kbtlZnK9krNR8o=;
 b=ct0wm8urucV+Rp9KdIqUX3AvxUEP5NQg0ruleQaf7/TJgjZY7Lt6AcVqRltSUGpOdj
 1d4wYHxTDI4HPGxEJpVBd2i8UTWfKb287lyrfoGi1WsnvDyOKAx7qOKthTaDfgc8yHWy
 lgrATPEzO2xdCwRfb+hjXt9DQfumgtnjI3AYpoR0N8eCxsgjSdnKVb8DGN6+zOEM1HHp
 8W3jFAUPvPxGiQLWx48Fow1FFIEeIHiEwSAoFmLzYwebTmIZ+oyZ77gTWLVJ6idhsorM
 7X4yT3EPZXJlvxnwFlBrmmWji/M1AMjbWObwTSneWKBzejo5ohRMHu4zjllRDk5imvAb
 jTlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756799579; x=1757404379;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=cyt1DdyHr3oTtevDVluqppot2qFn6kbtlZnK9krNR8o=;
 b=s/Gb4eDu4D8mDAG9npmAlsUHTdjMMkComi7MLONwJgi43OUL5hPAQSuIEEb3A4qcpW
 xgEOk7RN4u1kZqeQYyXYJMdMYt88Jqv6fYvOwTcNwbiprLl8o8NBGFBnvqFwOgBP4NtP
 7pHphAV+eyCT/6WVD0C7JM6acegGQL1/unA60yOMFfDRVctjZwvqDimKEBiv5JbCLX7O
 nzolUlbRvwgF08BUDDL9dHW7uodkM450aL8BdZss5l4eLgFDu9TsVl65nYi+QbJdqFg1
 4t9FoD7yO1igTEHpR88ubWQQMrJBVEJg+uglbf0OckthNCXpxDdjAFddKPs+6AMwcoPe
 pA9g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWLquc3kXlah5kyvaP/t9G7VSDnGezqiH3EO65SrMqZeGNyDLJJU5Q+MwHw8U9OBsjzm0bzLl9O@lists.freedesktop.org
X-Gm-Message-State: AOJu0YznPz6ISpHmqeoSApJEo0mkWMMRCzP2QqPSfLSg/yzfGIN9nILe
 0PUkOJCsWr+dXbrEDNdbp5ZCEA6T5bKOVxi38Jw+J6U84ANYJYZnljASoWC5Hg==
X-Gm-Gg: ASbGncvgASpfri24GJ0zhdo6epgC/MAzLfblz3vA9YRpBlCStMilNix3blj8IBfZ9TD
 86PrcvNGREYW79fKLK8bv5y03G8UyQ88MGSP5Jc01uNmw/zr9faOMlsT26gLKotCDBDe51w2XIC
 wmD4BtRUPjXFMApI6dr0CfU85V0aD1EWyfsT+1oVj+bwvzo3D0WD1loNA4ITh9QohA3TuqNzI6k
 FoAbx6OzYeQvw+WdSR8E2pCYTjnwyYomKT3zc+6OOgSC3C5/aZJDj1aCHSrMRJCY371hhqDYAUk
 ExaODZAm6xA52kgCFj7v1hG1EX6+7XstC3ZcYMBMxmn8L9vg1cXGHiR5FCjPl1Jr9/GY+7vhl9Q
 BEpWNKiADp8zqZ7uvRpzzldaGuzdVThLO0fib3lOgUl3N/FyTWbwub7ggG33SigSLqqDO3OdzRY
 7IRTpml90sdBKfA63uYKe2R141BWy/a+/jkpvE7c/CX+I47saKvC9Gs+0vC5JqFQ==
X-Google-Smtp-Source: AGHT+IE+GlWWTEq6PWBfAAxnSKi84hcwYJq60hHjm0v9yVxN3HFPqxtvOSdYaTJJ0Fyw6/cKUikrMw==
X-Received: by 2002:a05:6000:2311:b0:3d0:de1c:36da with SMTP id
 ffacd0b85a97d-3d1def64d7amr8269822f8f.46.1756799578641; 
 Tue, 02 Sep 2025 00:52:58 -0700 (PDT)
Received: from ?IPv6:2001:4c4e:24c1:9400:5635:26cc:b04a:ca6d?
 (20014C4E24C19400563526CCB04ACA6D.dsl.pool.telekom.hu.
 [2001:4c4e:24c1:9400:5635:26cc:b04a:ca6d])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3cf276d5e5fsm18692190f8f.27.2025.09.02.00.52.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Sep 2025 00:52:58 -0700 (PDT)
Message-ID: <2281608ed8fedfc58aee3449fff1f8df28e3e36a.camel@gmail.com>
Subject: Re: [PATCH 4/4] drm/amdgpu: Set SDMA v3 copy_max_bytes to 0x3fff00
From: Timur =?ISO-8859-1?Q?Krist=F3f?= <timur.kristof@gmail.com>
To: Christian =?ISO-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>, 
 amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com
Date: Tue, 02 Sep 2025 09:52:57 +0200
In-Reply-To: <7c10ac6d-93a8-41c9-900c-50261893d482@amd.com>
References: <20250901100012.439155-1-timur.kristof@gmail.com>
 <20250901100012.439155-4-timur.kristof@gmail.com>
 <7c10ac6d-93a8-41c9-900c-50261893d482@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
MIME-Version: 1.0
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

On Tue, 2025-09-02 at 08:45 +0200, Christian K=C3=B6nig wrote:
> On 01.09.25 12:00, Timur Krist=C3=B3f wrote:
> > SDMA v3-v5 can copy almost 4 MiB in a single copy operation.
> > Use the	same value as PAL and Mesa for copy_max_bytes.
> >=20
> > For reference, see oss2DmaCmdBuffer.cpp	in PAL:
> > "Due to HW limitation, the maximum count may not be 2^n-1,
> > can only be 2^n - 1 - start_addr[4:2]"
>=20
> Is that public available? If yes better reference AMDVLK here.

I only have access to public code, so that's all I can reference.

AMDVLK uses PAL so I assume the same would apply to it as well.
The above comment is in oss2DmaCmdBuffer.cpp here:
https://github.com/GPUOpen-Drivers/pal/blob/bcec463efe5260776d486a5e3da0c54=
9bc0a75d2/src/core/hw/ossip/oss2/oss2DmaCmdBuffer.cpp#L308



>=20
> Apart from that looks good to me.
>=20
> Regards,
> Christian.
>=20
> >=20
> > See also sid.h in Mesa:
> > "There is apparently an undocumented HW limitation that
> > prevents the HW from copying the last 255 bytes of (1 << 22) - 1"
> >=20
> > Fixes: dfe5c2b76b2a ("drm/amdgpu: Correct bytes limit for SDMA 3.0
> > copy and fill")
> > Signed-off-by: Timur Krist=C3=B3f <timur.kristof@gmail.com>
> > ---
> > =C2=A0drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c | 4 ++--
> > =C2=A01 file changed, 2 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
> > b/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
> > index 1c076bd1cf73..9302cf0b5e4b 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
> > @@ -1659,11 +1659,11 @@ static void
> > sdma_v3_0_emit_fill_buffer(struct amdgpu_ib *ib,
> > =C2=A0}
> > =C2=A0
> > =C2=A0static const struct amdgpu_buffer_funcs sdma_v3_0_buffer_funcs =
=3D {
> > -	.copy_max_bytes =3D 0x3fffe0, /* not 0x3fffff due to HW
> > limitation */
> > +	.copy_max_bytes =3D 0x3fff00, /* not 0x3fffff due to HW
> > limitation */
> > =C2=A0	.copy_num_dw =3D 7,
> > =C2=A0	.emit_copy_buffer =3D sdma_v3_0_emit_copy_buffer,
> > =C2=A0
> > -	.fill_max_bytes =3D 0x3fffe0, /* not 0x3fffff due to HW
> > limitation */
> > +	.fill_max_bytes =3D 0x3fff00, /* not 0x3fffff due to HW
> > limitation */
> > =C2=A0	.fill_num_dw =3D 5,
> > =C2=A0	.emit_fill_buffer =3D sdma_v3_0_emit_fill_buffer,
> > =C2=A0};
