Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B204DCDE009
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Jun 2026 07:03:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0A01610F144;
	Thu, 25 Jun 2026 07:03:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="SU4QdkFM";
	dkim-atps=neutral
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com
 [209.85.218.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D44DA10F014
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Jun 2026 19:11:38 +0000 (UTC)
Received: by mail-ej1-f48.google.com with SMTP id
 a640c23a62f3a-c0c41ff84a6so229742566b.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Jun 2026 12:11:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782328297; cv=none;
 d=google.com; s=arc-20240605;
 b=N5x2GmqTlhuFTH0OrHJAPlHwUj7jaALoY7K8UB76/RPjXXA2JalFNOFue3rdp7h+tJ
 9kk8NY7KAE9vA9y7LHowZmqdUrJeq4byxHUQJOtZapLMdFgkQaEKvFgdnFKmevyFvkFP
 fUnTs7m6MwfmKl+sn/2oyoPYKauW1ltaiNRfoYKlyZ6BRS86mDlOrmv8iARX9zw+udpQ
 PbHwMcMo8ORsKvIPCj7yNN1J0W3/km+lM0NxTOIwlMOsQE+fZSsZcYpf+8mS9Kxg/7/R
 oy9dNihF7AbDD9u4Jn3+1YvNgJOU0FWdJAZPQhfRgbi15jvKQDYwmWOO6V+NJ339Mrye
 ntVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=DRZlMNeqeOXmhfrFdEkWOyTOPJY3Aueu6qa43DQrvIA=;
 fh=kkyWXs/SyB2nWsTNelRVpetDjnWw9OXADfzVMNQSVDM=;
 b=iEIOiYbTahmn25V34X9hzfVaoxC0w5P1DPIuzHr9NAEN7ejI1HppsHthHhbU2Z8MAc
 Fn+/oqU74NebTApwPYBG+GPpec6QTx800OEM5EIxLny9QTgmJukR2p0vSX6TSYU8cBeB
 QIiFBkigHS9cboo5DtXvW9tq8zbWgbsAkwUn1U760gfKwmYvDa7SxlLQK5OaKz52JhBv
 QrACrE8emKxt9hsHgfUZ8SjHnBYYBIyJ8yqEFfVmRAL1dt7P0W3aaKhJr2dcRLfivU11
 EKg6RMFYG2sWndturgA1o2/ku4C4M3EuprY/RBpdbQWJ168O6tI5cmYd+I+z4oJRf1I1
 +13A==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782328297; x=1782933097; darn=lists.freedesktop.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=DRZlMNeqeOXmhfrFdEkWOyTOPJY3Aueu6qa43DQrvIA=;
 b=SU4QdkFMV5gcJ2ZQkWX696E9PUEfvSklmw4wcmKqUe95Q7MdTJ9mIg5DVlR/MEuDxl
 QgSxSvRVKNpthrHpWWMqwl2IyvDoxaT6/OoFhFw9pnrOCXhROhtYveGVWew41hPwn/PX
 Rl6UCyJz1jfYQ2O9QEFKYWn2AUblFETheMg0xbqJBbeyDJNreT9CmUkNcxZPixaqwyEg
 nIxxAHvCtbKErWXsb5PPGL5WXXCqlkQb4MaOY8jC/ZFOSx46FOew5rmuqgTwXhgS+dpw
 4d0z9viH8miYWP/+2AXXH5lNITjDNq0WOpVkB2qvF5rgGRREFQnq92lrkBayM8B57nLb
 YVdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782328297; x=1782933097;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DRZlMNeqeOXmhfrFdEkWOyTOPJY3Aueu6qa43DQrvIA=;
 b=Kw30VHqIG6lCVhlOXjR2Y70i1sK05HsKgflG6MpGjmNpseJ7zXF2ZEX8GUrdYn+yQi
 Q1Wq4+/QsTQJzfSzMNWGdBc97VoporHjBTShMK2kEBby0RwT/sx4Ek61sSg5NBiNspwk
 MLQ5oywcjTYvyOBjpDmSOVEW4wtfs9Xn5uQTNKyk8R/JWDyhydJ+v4amv4Wp0oB+QWgt
 qZpBMJTabh82rwASXoEmOvUjs92+yCsEBE1y0200zcpYcgYyGjUarrMolrIYjLsCyxBh
 mU+EiSMtfhVewEb0VjK4ruYjCD6U8pxlgx3oh/e8PffBUKDig/bu4ztTpghnPtFRK3gh
 gMWQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/3j68jbA393YO1MTVKxzPkaF7U918m1PACp4FL9Cg2vPSp4lyQd1wGr6dAhbmp6OtbZFoL+yC/@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzUijRrngRns/xUzuPVTBCfK2w0T2xgccV8V3hILCalyH+v0eQ0
 h/5Si1oJHi0gX1+KkYL0Ml/47IRKfOrx3Ljayf2aBrFuab4cFo4F948YETUpwqxoZz8EubPVPSN
 C4mG7VZd/WI73CpsUy/yNpjrdpdNtOYgp6Q==
X-Gm-Gg: AfdE7ckAEa1cHN6SkS1Cis2j7NMoCN4yP00RWj/jy6YkLRceRlIvdoJ+qY5nC97PmZ0
 N66UdaXHXsIqN/77b+UKtr/9HJBQH2fevBJozfSjcRxWSbhuYGGpdq2IJ2WkzOwRLRCnu1geT3G
 H15P+dqyJRI490xw8RYnd+N/mBC+lYuCrx2O0nMYvXs9eE8qJ2w06/LApFlUr8zea+6g8+hs7XG
 JzWEppWUcHI0HaV7GqjLfQvSTavcrj2wU006A4nJI3kk4Lo1FXAOCVzVNMwR3F5tR+qmM4URjb+
 1sNulz9Ld92QejRqPQ3TUqZlsUFXNQ==
X-Received: by 2002:a17:907:6092:b0:bd8:6ac6:d722 with SMTP id
 a640c23a62f3a-c119e444c81mr277136066b.24.1782328297041; Wed, 24 Jun 2026
 12:11:37 -0700 (PDT)
MIME-Version: 1.0
References: <20260619045904.5872-1-charleslmunger@gmail.com>
 <BL1PR12MB514432F894701A3CBAD341E9F7E22@BL1PR12MB5144.namprd12.prod.outlook.com>
 <436f03eb-0b19-4eb6-b884-c45a79a067e7@amd.com>
In-Reply-To: <436f03eb-0b19-4eb6-b884-c45a79a067e7@amd.com>
From: Charles Munger <charleslmunger@gmail.com>
Date: Wed, 24 Jun 2026 12:11:27 -0700
X-Gm-Features: AVVi8CcEGjymuWq3uJuO3En_gQCm00HiBrgDU0ZGxpWsN3GrOfsE7_3YrPFYjqY
Message-ID: <CACf9n8Sdu5KxKAn75SwCDpjzd+Sg-p0UFnok6BqSoOTxhQPnEA@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Add Paradetech OUI to VRR compat list
To: Harry Wentland <harry.wentland@amd.com>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 amd-gfx@lists.freedesktop.org, 
 "Hung, Alex" <Alex.Hung@amd.com>, "Li, Sun peng (Leo)" <Sunpeng.Li@amd.com>
Content-Type: multipart/alternative; boundary="00000000000004b1f3065504a5b7"
X-Mailman-Approved-At: Thu, 25 Jun 2026 07:03:56 +0000
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

--00000000000004b1f3065504a5b7
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Yes, and that's what I tested it with.

On Wed, Jun 24, 2026, 11:54=E2=80=AFAM Harry Wentland <harry.wentland@amd.c=
om>
wrote:

>
>
> On 2026-06-19 12:17, Deucher, Alexander wrote:
> > Public
> >
> > Adding a few display folks to review.
> >
> > Thanks,
> >
> > Alex
> >
> >> -----Original Message-----
> >> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of
> >> Charles Munger
> >> Sent: Friday, June 19, 2026 12:59 AM
> >> To: amd-gfx@lists.freedesktop.org
> >> Cc: Charles Munger <charleslmunger@gmail.com>
> >> Subject: [PATCH] drm/amdgpu: Add Paradetech OUI to VRR compat list
> >>
> >> There's at least two firmware versions on the CalDigit DP20-HDMI21
> adapter,
> >> which is powered by the ParadeTech PS196G chip. The first version has =
a
> bug
> >> where it incorrectly neglects to set the DOWN_STREAM_PORT_PRESENT fiel=
d
> >> in the DPCD:
> >>
> >> $ sudo dpcd_reg read --offset=3D0x2205 --count=3D1 --device=3D0
> >> 0x2205:  00
> >> $ sudo dpcd_reg read --offset=3D0x0005 --count=3D1 --device=3D0
> >> 0x0005:  00
> >>
> >> The newer one fixes this, and with this patch correctly negotiates VRR=
.
> >>
> >> [~]$ sudo dpcd_reg read --offset=3D0x5 --count=3D1 --device=3D2
> >> 0x0005:  1d
> >> [~]$ sudo dpcd_reg read --offset=3D0x2205 --count=3D1 --device=3D2
> >> 0x2205:  1d
> >>
> >> So if you're using a Paradetech adapter and it doesn't negotiate VRR,
> check
> >> that it has a firmware that produces the correct DPCD.
> >>
> >> Signed-off-by: Charles Munger <charleslmunger@gmail.com>
> >> ---
> >>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c | 1 +
> >>  1 file changed, 1 insertion(+)
> >>
> >> diff --git
> >> a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
> >> b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
> >> index 6c827e6703a0..f463495d1c87 100644
> >> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
> >> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
> >> @@ -1410,6 +1410,7 @@ bool dm_helpers_is_vrr_pcon_allowed(const
>
> Looks like this is based on the "drm/amd: VRR fixes, HDMI Gaming Features=
"
> series, not directly on amd-staging-drm-next. I'll have to take another
> closer look at that series.
>
> Harry
>
> >> struct dc_link *link, const struct drm
> >>       case DP_BRANCH_DEVICE_ID_00E04C:
> >>       case DP_BRANCH_DEVICE_ID_90CC24:
> >>       case DP_BRANCH_DEVICE_ID_2B02F0:
> >> +     case DP_BRANCH_DEVICE_ID_001CF8:
> >>               return true;
> >>       }
> >>
> >> --
> >> 2.54.0
> >
>
>

--00000000000004b1f3065504a5b7
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">Yes, and that&#39;s what I tested it with.</div><br><div =
class=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr" class=3D"gmail=
_attr">On Wed, Jun 24, 2026, 11:54=E2=80=AFAM Harry Wentland &lt;<a href=3D=
"mailto:harry.wentland@amd.com">harry.wentland@amd.com</a>&gt; wrote:<br></=
div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bor=
der-left:1px solid rgb(204,204,204);padding-left:1ex"><br>
<br>
On 2026-06-19 12:17, Deucher, Alexander wrote:<br>
&gt; Public<br>
&gt; <br>
&gt; Adding a few display folks to review.<br>
&gt; <br>
&gt; Thanks,<br>
&gt; <br>
&gt; Alex<br>
&gt; <br>
&gt;&gt; -----Original Message-----<br>
&gt;&gt; From: amd-gfx &lt;<a href=3D"mailto:amd-gfx-bounces@lists.freedesk=
top.org" target=3D"_blank" rel=3D"noreferrer">amd-gfx-bounces@lists.freedes=
ktop.org</a>&gt; On Behalf Of<br>
&gt;&gt; Charles Munger<br>
&gt;&gt; Sent: Friday, June 19, 2026 12:59 AM<br>
&gt;&gt; To: <a href=3D"mailto:amd-gfx@lists.freedesktop.org" target=3D"_bl=
ank" rel=3D"noreferrer">amd-gfx@lists.freedesktop.org</a><br>
&gt;&gt; Cc: Charles Munger &lt;<a href=3D"mailto:charleslmunger@gmail.com"=
 target=3D"_blank" rel=3D"noreferrer">charleslmunger@gmail.com</a>&gt;<br>
&gt;&gt; Subject: [PATCH] drm/amdgpu: Add Paradetech OUI to VRR compat list=
<br>
&gt;&gt;<br>
&gt;&gt; There&#39;s at least two firmware versions on the CalDigit DP20-HD=
MI21 adapter,<br>
&gt;&gt; which is powered by the ParadeTech PS196G chip. The first version =
has a bug<br>
&gt;&gt; where it incorrectly neglects to set the DOWN_STREAM_PORT_PRESENT =
field<br>
&gt;&gt; in the DPCD:<br>
&gt;&gt;<br>
&gt;&gt; $ sudo dpcd_reg read --offset=3D0x2205 --count=3D1 --device=3D0<br=
>
&gt;&gt; 0x2205:=C2=A0 00<br>
&gt;&gt; $ sudo dpcd_reg read --offset=3D0x0005 --count=3D1 --device=3D0<br=
>
&gt;&gt; 0x0005:=C2=A0 00<br>
&gt;&gt;<br>
&gt;&gt; The newer one fixes this, and with this patch correctly negotiates=
 VRR.<br>
&gt;&gt;<br>
&gt;&gt; [~]$ sudo dpcd_reg read --offset=3D0x5 --count=3D1 --device=3D2<br=
>
&gt;&gt; 0x0005:=C2=A0 1d<br>
&gt;&gt; [~]$ sudo dpcd_reg read --offset=3D0x2205 --count=3D1 --device=3D2=
<br>
&gt;&gt; 0x2205:=C2=A0 1d<br>
&gt;&gt;<br>
&gt;&gt; So if you&#39;re using a Paradetech adapter and it doesn&#39;t neg=
otiate VRR, check<br>
&gt;&gt; that it has a firmware that produces the correct DPCD.<br>
&gt;&gt;<br>
&gt;&gt; Signed-off-by: Charles Munger &lt;<a href=3D"mailto:charleslmunger=
@gmail.com" target=3D"_blank" rel=3D"noreferrer">charleslmunger@gmail.com</=
a>&gt;<br>
&gt;&gt; ---<br>
&gt;&gt;=C2=A0 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c | =
1 +<br>
&gt;&gt;=C2=A0 1 file changed, 1 insertion(+)<br>
&gt;&gt;<br>
&gt;&gt; diff --git<br>
&gt;&gt; a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c<br>
&gt;&gt; b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c<br>
&gt;&gt; index 6c827e6703a0..f463495d1c87 100644<br>
&gt;&gt; --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c<br=
>
&gt;&gt; +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c<br=
>
&gt;&gt; @@ -1410,6 +1410,7 @@ bool dm_helpers_is_vrr_pcon_allowed(const<br=
>
<br>
Looks like this is based on the &quot;drm/amd: VRR fixes, HDMI Gaming Featu=
res&quot;<br>
series, not directly on amd-staging-drm-next. I&#39;ll have to take another=
<br>
closer look at that series.<br>
<br>
Harry<br>
<br>
&gt;&gt; struct dc_link *link, const struct drm<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0case DP_BRANCH_DEVICE_ID_00E04C:<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0case DP_BRANCH_DEVICE_ID_90CC24:<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0case DP_BRANCH_DEVICE_ID_2B02F0:<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0case DP_BRANCH_DEVICE_ID_001CF8:<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return true;=
<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;&gt;<br>
&gt;&gt; --<br>
&gt;&gt; 2.54.0<br>
&gt; <br>
<br>
</blockquote></div>

--00000000000004b1f3065504a5b7--
