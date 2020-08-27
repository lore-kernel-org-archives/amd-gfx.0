Return-Path: <SRS0=3ay0=CF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E44A0C433E1
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Aug 2020 17:14:16 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC7B720737
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Aug 2020 17:14:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Whp+8GHc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC7B720737
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 65BE36E400;
	Thu, 27 Aug 2020 17:14:16 +0000 (UTC)
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com
 [IPv6:2a00:1450:4864:20::229])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B56FA6E400
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Aug 2020 17:14:14 +0000 (UTC)
Received: by mail-lj1-x229.google.com with SMTP id v9so7288063ljk.6
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Aug 2020 10:14:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=1Ave4K0hb+qc3/RAIBo28HzwKGjm1i6G3tV2dt2+xHw=;
 b=Whp+8GHc1OZ77U91w2EHIpE8K1WtR85mQP+cpBDNZmZHUiq1QBGq/4KJAvgqwGcUo2
 bvw+LO6tHl07pCHRElFsZOtkxy20cyKNOMRXL8a3jv1sxzmiKigpYlDgT3bFf2s1s7J3
 gNpSQ28aVC5AML+LB8LCKVcjDuOg/YKIGdFuRY3fnZz88sNzGj3UZT+KN3xuJR/Bmz/e
 aaS0N5g2wyEVbWi0rCaOniI53Rag6V+B/aR32t9//JqXkr4CjbkVMkjLC0ykwpKvHYUk
 raeuRUo2FU4PaWRk1I14WlPMJX2DdrInSZx6wbbhVDuCvM+KVeh2Os9YIpTDaMqfi29P
 zzlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=1Ave4K0hb+qc3/RAIBo28HzwKGjm1i6G3tV2dt2+xHw=;
 b=h9b9uiCwV8fbmvudiOSuKA8vn31QFe9gmhFz9u2/h7HaK7SdXSHKvER1VDDfAr2o5J
 ZuAM/GoMriJ+BGVNvE8fy+8KMPsd129zy+V49pA5S+q2T6LTo+CbGubcZeLn79k2Ru7K
 RFD4IVckCxURrFbMa1biAjA6OtlnGbZ+x8ET/EtsTkrWYr8z6wy0JN1eyUlNiosYLmAQ
 0cxmXlkf+cHXrimqA/YzN9ncLtMtVfAXzc7ox1GqKt/W/7x+Fa07UkrRVlkDZLsyvHug
 aS13wM/8O8RArcRVWdYIzy98hrPKjzpj3DEEOjYBVb8bBSkEx58KOvbGl+u+YKdkrViY
 Ntzw==
X-Gm-Message-State: AOAM533C2+3TnD1U2Bs0MiBVh+6qSGkl6NBoe62BNGOGj7EsBd+yEEd6
 W7OYRztJnKR3BiEOFMFwvsiBmwvPoK53SVjAnHelzeSXjo0=
X-Google-Smtp-Source: ABdhPJymn8dH89asETthFMGNzvwDNiKq58YztX5h9lvc3QYhmjI0Wj6TV8iekDkuUYYuywTgIynflZhjTpmTco5t+RI=
X-Received: by 2002:a2e:9811:: with SMTP id a17mr9142972ljj.21.1598548453174; 
 Thu, 27 Aug 2020 10:14:13 -0700 (PDT)
MIME-Version: 1.0
References: <5eb9e79.42da.1742ef91f76.Coremail.erdong2018@163.com>
In-Reply-To: <5eb9e79.42da.1742ef91f76.Coremail.erdong2018@163.com>
From: Tom St Denis <tstdenis82@gmail.com>
Date: Thu, 27 Aug 2020 13:14:02 -0400
Message-ID: <CAAzXoRJ+S6qaE_UaN0gNtkHPQcp+toMcUA1-8fLhU37rDdHyRQ@mail.gmail.com>
Subject: Re: 0001-Fix-a-array-bound-overflow-bug-in-function-umr_clock
To: =?UTF-8?B?5byg5LqM5Lic?= <erdong2018@163.com>
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
Cc: amd-gfx mailing list <amd-gfx@lists.freedesktop.org>
Content-Type: multipart/mixed; boundary="===============0613141341=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0613141341==
Content-Type: multipart/alternative; boundary="000000000000b5334d05addf1093"

--000000000000b5334d05addf1093
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

isn't a better fix to simply delete the line?  The print seems redundant to
me.

Tom

On Thu, Aug 27, 2020 at 9:27 AM =E5=BC=A0=E4=BA=8C=E4=B8=9C <erdong2018@163=
.com> wrote:

>
>
>
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>

--000000000000b5334d05addf1093
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">isn&#39;t a better fix to simply delete the line?=C2=A0 Th=
e print seems redundant to me.<div><br></div><div>Tom</div></div><br><div c=
lass=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, Aug 27, =
2020 at 9:27 AM =E5=BC=A0=E4=BA=8C=E4=B8=9C &lt;<a href=3D"mailto:erdong201=
8@163.com">erdong2018@163.com</a>&gt; wrote:<br></div><blockquote class=3D"=
gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(20=
4,204,204);padding-left:1ex"><div style=3D"line-height:1.7;color:rgb(0,0,0)=
;font-size:14px;font-family:Arial"><p style=3D"margin:0px"><br></p></div><b=
r><br><span title=3D"neteasefooter"><p>=C2=A0</p></span>___________________=
____________________________<br>
amd-gfx mailing list<br>
<a href=3D"mailto:amd-gfx@lists.freedesktop.org" target=3D"_blank">amd-gfx@=
lists.freedesktop.org</a><br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx" rel=3D"n=
oreferrer" target=3D"_blank">https://lists.freedesktop.org/mailman/listinfo=
/amd-gfx</a><br>
</blockquote></div>

--000000000000b5334d05addf1093--

--===============0613141341==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0613141341==--
