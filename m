Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A68E2C87FCA
	for <amd-gfx@archiver.kernel.org>; Fri,  1 Aug 2025 21:29:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0C7FA10E065;
	Fri,  1 Aug 2025 21:29:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="c+bNvnP7";
	dkim-atps=neutral
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com
 [209.85.160.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 10E0310E065
 for <amd-gfx@lists.freedesktop.org>; Fri,  1 Aug 2025 21:29:10 +0000 (UTC)
Received: by mail-oa1-f54.google.com with SMTP id
 586e51a60fabf-2e95f0b6cb7so1066752fac.3
 for <amd-gfx@lists.freedesktop.org>; Fri, 01 Aug 2025 14:29:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1754083749; x=1754688549; darn=lists.freedesktop.org;
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=8oU+LI4hCxzWqvIBFuHS+NF+1ZUQVXtuz08UuVtSRjA=;
 b=c+bNvnP7X71cjiY7XG1YW809eYUefi+M8VZB4nlrV1b2wVauA/KrSOTAb2NMnweR+/
 b6cq01s+10N3kPtAfzM5JUB1ZDPilHbdFZtP8kAGOgwH186RfIQ3Hl0cbGEu26wgkxyp
 PSYT77m20HQOSkIE5RvS1W/amc8r+Hc44MSKwPYkwlt9ATHg2Ov+C/tlZgfXse1gCukI
 hzQ0JBoSuJYZsjEpNJIph+N33B+hS/9JS2XlYdpO1xo6fWXuTzDaj+kE6bMWjwFg4Tm7
 tXYKYfWo0wvYHPrBpMRA9Lonk4670Ie3cV/AxtgB/mBkHxXODxWf7BmwIRzN+1UzYUl5
 MdGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754083749; x=1754688549;
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8oU+LI4hCxzWqvIBFuHS+NF+1ZUQVXtuz08UuVtSRjA=;
 b=scENFPpL1OOYklAmclOiVTH7fEn9wbwcQy6vrPn6dc22gnggKrvA4hSzqwQQWyOSaH
 xACpxVVw+UwCRsFKngsjxtYEgF3KpKRHzdIRBET1t9xM/4zoDR/JEarijJA6Dt6C7mJe
 bVVggqYeTAC8sRrBq2JZVS6FHJsbJYFB8yp4U2e1lqEMJjwiPbddGJ+DgJ5UuodT4zWV
 MMhaUYIALgAFnJzYLtn61XlrYQwQQxEQT9FlzdZA1JwVk18MJoHeQQepiaFRTSXPpXKi
 JODhBfRo4q2FBwluDJoiNSFhAdJXXf9dZU9j1mIbYzfYjbJiR6jHIfLRHucFWeAqepLX
 2+YA==
X-Gm-Message-State: AOJu0YzPw4jwcUt77jL9GG0fawsqJ8ElBdDt3tZcRtz5t7OcR6khZaue
 HniX2dgb18Btkeunl8KGb9Yu1vAyyOjszGkTA3qmIXBSehDu6ZdeJ6PHQKsXrIouqHfJRQH9435
 Vxl9J8VaG36eiPbPo2Kvg0ZpbM/tF5vs=
X-Gm-Gg: ASbGncsAMfXEcz7A1dR7R5UENl0hg6UrBqF4KwZi79v0egLwJvGJR/PNIyEDe0PQM/B
 mSjNWNCSfPweqES8lhn/dtxfWwWDEWwxcaKg2L1zkRkNF+9KqZi5WaZTMx8Mf/QyJa9/0mxRK7v
 NFtAl54vk/cMas79KJWB67FsceHLiCPD1cXlc5Qm8C3LfOiQiyi8O8n1bf1dM6sg3FMMom9PaVX
 zBTQrD8RlsbYCF/LQ==
X-Google-Smtp-Source: AGHT+IG7S34ig8PShRHcR/YH1M2vASpK4n5Wc+ShC4rQ7Guie+FHS1FbJ0MOoGqsS0nGBcj0NZUXLplDkDokQAQVOIs=
X-Received: by 2002:a05:6871:1c1:b0:2c2:4d76:f1ad with SMTP id
 586e51a60fabf-30b6760aa1bmr684090fac.16.1754083749060; Fri, 01 Aug 2025
 14:29:09 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:505:8bc5:b0:1cf4:f4df:c905 with HTTP; Fri, 1 Aug 2025
 14:29:08 -0700 (PDT)
In-Reply-To: <a90cee9d-4be0-431e-abf7-e55da92c42d5@gmail.com>
References: <20250723155813.9101-11-timur.kristof@gmail.com>
 <a90cee9d-4be0-431e-abf7-e55da92c42d5@gmail.com>
From: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>
Date: Fri, 1 Aug 2025 23:29:08 +0200
X-Gm-Features: Ac12FXwcPjlSEr9nc8HM9MByK2TLxXEddV39JQiU4s0ZqEucAskKraVh1go7zpk
Message-ID: <CAFF-SiUrWyz68xPd4+mRB1SSr0F-MO8v_s32E-gw7zkKPS7D1w@mail.gmail.com>
Subject: Re: [PATCH 10/20] drm/amd/display: Implement DCE analog stream
 encoders
To: "alexandre.f.demers@gmail.com" <alexandre.f.demers@gmail.com>
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Type: multipart/alternative; boundary="000000000000c4e5ae063b547283"
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

--000000000000c4e5ae063b547283
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

2025. augusztus 1., p=C3=A9ntek d=C3=A1tummal Alexandre Demers <
alexandre.f.demers@gmail.com> ezt =C3=ADrta:
>> Add stream encoders for DCE6-10 only, because there are definitely
>> graphics cards with analog connectors out there with these DCE
>> versions. I am not aware of newer ones.
>
>> Considering that all stream encoder functions currently have to do
>> with digital streams, there is nothing for an analog stream
>> encoder to do, making them basically a no-op.
>> That being said, we still need some kind of stream encoder to
>> represent an analog stream, and it is beneficial to split them from
>> digital stream encoders in the code to make sure they don't
>> accidentally write any DIG* registers.
>>
>> Signed-off-by: Timur Krist=C3=B3f <timur.kristof at gmail.com>
>> ---
>> .../drm/amd/display/dc/dce/dce_stream_encoder.c | 14 ++++++++++++++
>> .../drm/amd/display/dc/dce/dce_stream_encoder.h | 5 +++++
>> .../display/dc/resource/dce100/dce100_resource.c | 6 ++++++
>> .../amd/display/dc/resource/dce60/dce60_resource.c | 8 ++++++++
>> .../amd/display/dc/resource/dce80/dce80_resource.c | 8 ++++++++
>> 5 files changed, 41 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_stream_encoder.c
b/drivers/gpu/drm/amd/display/dc/dce/dce_stream_encoder.c
>> index 1130d7619b26..f8996ee2856b 100644
>> --- a/drivers/gpu/drm/amd/display/dc/dce/dce_stream_encoder.c
>> +++ b/drivers/gpu/drm/amd/display/dc/dce/dce_stream_encoder.c
>> @@ -1567,3 +1567,17 @@ void dce110_stream_encoder_construct(
>> enc110->se_shift =3D se_shift;
>> enc110->se_mask =3D se_mask;
>> }
>> +
>> +static const struct stream_encoder_funcs dce110_an_str_enc_funcs =3D {0=
};
>> +
>> +void dce110_analog_stream_encoder_construct(
>> + struct dce110_stream_encoder *enc110,
>> + struct dc_context *ctx,
>> + struct dc_bios *bp,
>> + enum engine_id eng_id)
>> +{
>> + enc110->base.funcs =3D &dce110_an_str_enc_funcs;
>> + enc110->base.ctx =3D ctx;
>> + enc110->base.id =3D eng_id;
>> + enc110->base.bp =3D bp;
>> +}
>
> Since we are adding analog stream encoder support only up to DCE10,
wouldn't it be better if the prefix "dce100_" was used instead? I know
there are a few functions in there that use "dce110_" as prefix and are
replaced by functions specific to the DCE versions that behave differently
(we even have dce60_ and dce80_ in the current patch), but this seems off
otherwise.
>
> IMO, if thie DCE code should be revisited, "dce_" should be the general
prefix instead of "dce110_", with "dceXY_" being specific (as it is right
now).
> Alexandre

Hi Alexandre,

Two reasons:

1. As best as I can tell, all DCE versions use dce110_stream_encoder
regardless of its name. I agree that this is somewhat counter-intuitive but
I wanted to follow the conventions in the rest of this file.

2. It is unclear which DCE versions actually have a DAC. On one hand there
is some conversation on this ML that suggests that Hawaii and newer don't
have a DAC, which is apparently wrong. Looking at the register headers, all
DCE including the latest one have the DAC registers. Theoretically, if
there were newer GPUs with DAC, this code would work fine on them too.

If you are not happy with the code style, I respect that but I would like
if we tackled that separarely.

With these series, I want to just focus on fixing things and getting DC to
work on SI and CIK with the least possible risk of breaking things.

Best regards,
Timur

--000000000000c4e5ae063b547283
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<br>2025. augusztus 1., p=C3=A9ntek d=C3=A1tummal Alexandre Demers &lt;<a h=
ref=3D"mailto:alexandre.f.demers@gmail.com">alexandre.f.demers@gmail.com</a=
>&gt; ezt =C3=ADrta:<br>&gt;&gt; Add stream encoders for DCE6-10 only, beca=
use there are definitely<br>&gt;&gt; graphics cards with analog connectors =
out there with these DCE<br>&gt;&gt; versions. I am not aware of newer ones=
.<br>&gt;<br>&gt;&gt; Considering that all stream encoder functions current=
ly have to do<br>&gt;&gt; with digital streams, there is nothing for an ana=
log stream<br>&gt;&gt; encoder to do, making them basically a no-op.<br>&gt=
;&gt; That being said, we still need some kind of stream encoder to<br>&gt;=
&gt; represent an analog stream, and it is beneficial to split them from<br=
>&gt;&gt; digital stream encoders in the code to make sure they don&#39;t<b=
r>&gt;&gt; accidentally write any DIG* registers.<br>&gt;&gt;<br>&gt;&gt; S=
igned-off-by: Timur Krist=C3=B3f &lt;timur.kristof at <a href=3D"http://gma=
il.com">gmail.com</a>&gt;<br>&gt;&gt; ---<br>&gt;&gt; .../drm/amd/display/d=
c/dce/dce_stream_encoder.c | 14 ++++++++++++++<br>&gt;&gt; .../drm/amd/disp=
lay/dc/dce/dce_stream_encoder.h | 5 +++++<br>&gt;&gt; .../display/dc/resour=
ce/dce100/dce100_resource.c | 6 ++++++<br>&gt;&gt; .../amd/display/dc/resou=
rce/dce60/dce60_resource.c | 8 ++++++++<br>&gt;&gt; .../amd/display/dc/reso=
urce/dce80/dce80_resource.c | 8 ++++++++<br>&gt;&gt; 5 files changed, 41 in=
sertions(+)<br>&gt;&gt;<br>&gt;&gt; diff --git a/drivers/gpu/drm/amd/displa=
y/dc/dce/dce_stream_encoder.c b/drivers/gpu/drm/amd/display/dc/dce/dce_stre=
am_encoder.c<br>&gt;&gt; index 1130d7619b26..f8996ee2856b 100644<br>&gt;&gt=
; --- a/drivers/gpu/drm/amd/display/dc/dce/dce_stream_encoder.c<br>&gt;&gt;=
 +++ b/drivers/gpu/drm/amd/display/dc/dce/dce_stream_encoder.c<br>&gt;&gt; =
@@ -1567,3 +1567,17 @@ void dce110_stream_encoder_construct(<br>&gt;&gt; en=
c110-&gt;se_shift =3D se_shift;<br>&gt;&gt; enc110-&gt;se_mask =3D se_mask;=
<br>&gt;&gt; }<br>&gt;&gt; +<br>&gt;&gt; +static const struct stream_encode=
r_funcs dce110_an_str_enc_funcs =3D {0};<br>&gt;&gt; +<br>&gt;&gt; +void dc=
e110_analog_stream_encoder_construct(<br>&gt;&gt; + struct dce110_stream_en=
coder *enc110,<br>&gt;&gt; + struct dc_context *ctx,<br>&gt;&gt; + struct d=
c_bios *bp,<br>&gt;&gt; + enum engine_id eng_id)<br>&gt;&gt; +{<br>&gt;&gt;=
 + enc110-&gt;base.funcs =3D &amp;dce110_an_str_enc_funcs;<br>&gt;&gt; + en=
c110-&gt;base.ctx =3D ctx;<br>&gt;&gt; + enc110-&gt;<a href=3D"http://base.=
id">base.id</a> =3D eng_id;<br>&gt;&gt; + enc110-&gt;base.bp =3D bp;<br>&gt=
;&gt; +}<br>&gt;<br>&gt; Since we are adding analog stream encoder support =
only up to DCE10, wouldn&#39;t it be better if the prefix &quot;dce100_&quo=
t; was used instead? I know there are a few functions in there that use &qu=
ot;dce110_&quot; as prefix and are replaced by functions specific to the DC=
E versions that behave differently (we even have dce60_ and dce80_ in the c=
urrent patch), but this seems off otherwise.<br>&gt;<br>&gt; IMO, if thie D=
CE code should be revisited, &quot;dce_&quot; should be the general prefix =
instead of &quot;dce110_&quot;, with &quot;dceXY_&quot; being specific (as =
it is right now).<br>&gt; Alexandre<br><br>Hi Alexandre,<br><br>Two reasons=
:<br><br>1. As best as I can tell, all DCE versions use dce110_stream_encod=
er regardless of its name. I agree that this is somewhat counter-intuitive =
but I wanted to follow the conventions in the rest of this file.<br><br>2. =
It is unclear which DCE versions actually have a DAC. On one hand there is =
some conversation on this ML that suggests that Hawaii and newer don&#39;t =
have a DAC, which is apparently wrong. Looking at the register headers, all=
 DCE including the latest one have the DAC registers. Theoretically, if the=
re were newer GPUs with DAC, this code would work fine on them too.<br><br>=
If you are not happy with the code style, I respect that but I would like i=
f we tackled that separarely.<br><br>With these series, I want to just focu=
s on fixing things and getting DC to work on SI and CIK with the least poss=
ible risk of breaking things.<br><br>Best regards,<br>Timur

--000000000000c4e5ae063b547283--
