Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C02BEC3A59D
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Oct 2022 07:14:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C30A510E0A3;
	Mon, 24 Oct 2022 07:14:02 +0000 (UTC)
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com
 [IPv6:2607:f8b0:4864:20::829])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4CE5F10E060
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Oct 2022 01:32:10 +0000 (UTC)
Received: by mail-qt1-x829.google.com with SMTP id bb5so4919585qtb.11
 for <amd-gfx@lists.freedesktop.org>; Sun, 23 Oct 2022 18:32:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :from:to:cc:subject:date:message-id:reply-to;
 bh=i2woeV1xfn23wJfHzwefrC3IjNXDtm0d0F1XSgZEEV4=;
 b=gla5yXvZzDjpeMxoHTxoYyevgbcvouW8WXqD0W7GdgfNuEhHWq/rKb1kW7bZZisqEq
 L9MRiHJz8NM03eggEimK6KmWNBU+B/HFOe39jgT5ouspAwmnG56Yz/Np9sRQMujdrOmL
 CSBSn+U2bV8X2mH2OOmOZlnatWI9q4dpnQHYQxCc42WT67AFfNQBchYmv+fnRsMJVDsv
 C/KhAgVrM+Kvl1UYPJPS4gI15zRoRG6bdjj4VYOvf9aRiMnpQbpgKLMdAZQuWEuc0uTJ
 S2OqivP2/k1yowqmU2LSA4gqdvtymRHW3l+QcDRDaTvVn1WK9Veabnzll+396N6/f2ep
 MKvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=i2woeV1xfn23wJfHzwefrC3IjNXDtm0d0F1XSgZEEV4=;
 b=MVlgnAEttD/sSxFtxMNjv6aD6yC+1q9i45ORyhf9xUADnQT7J9shiy58sIl3ppnP8d
 lvua6loTVqb6Fy4YLO+le/zngGMs4MeXidPL8CM3Vlb9+PZh590xopfFAAmfGlK928Jv
 a0+B0AdUCAjx7Er90edt1MrhzBkZaINwjYbgxQ1MLKIDf3qA7q7K58SprzMMO0+QlKqi
 XvmpMpYkaQVZUINyBxgRAgjV6x0BKtrXxCyYaHyC6HxVg7C94mag6iOG3t1tEKXCo3hD
 dC+Ia7enl6WHO4Ei/I40zu46IY4O5YVz/DKRGbMyw6kTc6YPCs7tVvGC71bzZLKWRNba
 85Zg==
X-Gm-Message-State: ACrzQf27sKnjVQP+YIwpKcekEjfzwgxkuWUFuc815w6UDDq6pOEmIJ1h
 F0TTZUSHrE/1Z9GmK1FwbtR1AniHWGHNspxBrpM=
X-Google-Smtp-Source: AMsMyM5noUWagFbcDbSp+sf3egW7Q1ZvSETHN0c9Bl26w27b+VophiksWRp9S/iD7/kNd1YOtF5+dfLAIZJV6ni59wc=
X-Received: by 2002:ac8:5991:0:b0:39c:be3a:6f4f with SMTP id
 e17-20020ac85991000000b0039cbe3a6f4fmr26110935qte.348.1666575129338; Sun, 23
 Oct 2022 18:32:09 -0700 (PDT)
MIME-Version: 1.0
References: <3dbf8c82-9e07-5b9f-e969-4a7cd83e4d9e@komputer>
In-Reply-To: <3dbf8c82-9e07-5b9f-e969-4a7cd83e4d9e@komputer>
From: Uros Milojkovic <uroshm@gmail.com>
Date: Sun, 23 Oct 2022 21:32:09 -0400
Message-ID: <CAP=xWk71RhkpFbS=B2qpcypcpESYGztL13TvwAkJwvRcR8_R3w@mail.gmail.com>
Subject: Re: Fixing rts5208 driver code style
To: akpm@linux-foundation.org, linux-kernel@vger.kernel.org, 
 micky_ching@realsil.com.cn, alexander.deucher@amd.com, 
 christian.koenig@amd.com, Xinhui.Pan@amd.com, amd-gfx@lists.freedesktop.org
Content-Type: multipart/alternative; boundary="0000000000009382be05ebbdc2e4"
X-Mailman-Approved-At: Mon, 24 Oct 2022 07:13:29 +0000
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

--0000000000009382be05ebbdc2e4
Content-Type: text/plain; charset="UTF-8"

Hi I am new to kernel dev and am very passionate, even if this fix isn't
formatted correctly, could you please give me specific advice on how to do
so going forward?
Best,
Uros

On Sun, Oct 23, 2022 at 3:32 PM uroshm <uroshm@gmail.com> wrote:

>
> diff --git a/drivers/staging/rts5208/general.c
> b/drivers/staging/rts5208/general.c
> index 0f912b011064..4694593af4d9 100644
> --- a/drivers/staging/rts5208/general.c
> +++ b/drivers/staging/rts5208/general.c
> @@ -9,7 +9,7 @@
>    *   Micky Ching (micky_ching@realsil.com.cn)
>    */
>
> -#include "general.h"
> + #include "general.h"
>
>   int bit1cnt_long(u32 data)
>   {
>
>
> Signed-off-by: Uros Milojkovic <uroshm@gmail.com>
>
>

--0000000000009382be05ebbdc2e4
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi I am new to kernel dev and am very passionate, eve=
n if this fix isn&#39;t formatted correctly, could you please give me speci=
fic advice on how to do so going forward?</div><div>Best,</div><div>Uros<br=
></div></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail=
_attr">On Sun, Oct 23, 2022 at 3:32 PM uroshm &lt;<a href=3D"mailto:uroshm@=
gmail.com">uroshm@gmail.com</a>&gt; wrote:<br></div><blockquote class=3D"gm=
ail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,=
204,204);padding-left:1ex"><br>
diff --git a/drivers/staging/rts5208/general.c <br>
b/drivers/staging/rts5208/general.c<br>
index 0f912b011064..4694593af4d9 100644<br>
--- a/drivers/staging/rts5208/general.c<br>
+++ b/drivers/staging/rts5208/general.c<br>
@@ -9,7 +9,7 @@<br>
=C2=A0 =C2=A0*=C2=A0 =C2=A0Micky Ching (<a href=3D"mailto:micky_ching@reals=
il.com.cn" target=3D"_blank">micky_ching@realsil.com.cn</a>)<br>
=C2=A0 =C2=A0*/<br>
<br>
-#include &quot;general.h&quot;<br>
+ #include &quot;general.h&quot;<br>
<br>
=C2=A0 int bit1cnt_long(u32 data)<br>
=C2=A0 {<br>
<br>
<br>
Signed-off-by: Uros Milojkovic &lt;<a href=3D"mailto:uroshm@gmail.com" targ=
et=3D"_blank">uroshm@gmail.com</a>&gt;<br>
<br>
</blockquote></div>

--0000000000009382be05ebbdc2e4--
