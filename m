Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC101E7716A
	for <amd-gfx@archiver.kernel.org>; Sun, 15 Dec 2024 23:57:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0963210E17B;
	Sun, 15 Dec 2024 23:57:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="VClgGeJf";
	dkim-atps=neutral
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C3D2810E044
 for <amd-gfx@lists.freedesktop.org>; Sun, 15 Dec 2024 23:57:55 +0000 (UTC)
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-aa6954ec439so52370866b.1
 for <amd-gfx@lists.freedesktop.org>; Sun, 15 Dec 2024 15:57:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1734307074; x=1734911874; darn=lists.freedesktop.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=SQ5uCSVdiAbG+S3KVetRBBydKbT1vqYxt9wiRzAv/4E=;
 b=VClgGeJfAw8CaCnHmbVj67acRcM0NHZq3XRNpMTCjILLI/VaakYLO2BDmvxe5Wo9UO
 T0j1F3jtD3jcXU6THNOW8Q402FEwghgxtzjPr46InmfCYAIxeprvbYJcwpAsJhraRBTd
 euCWprSJE/yrYiiujuZVO0fGdw1WJj6L2w5xCjUVDwrOZiELdr4lzWHlJFkUkUnP9Vsa
 otB66IxP9tefXCeymwYMErdPZNBO02uju5r8aNnqnLVdbEZd1AMeI6GfuklRKkds6HxW
 OEZxaTSrDNQontQfOzHIQ0opvEcVyUTLSj1oJknsBUw32Wrker/8pozseFPXncZguOUH
 pONg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734307074; x=1734911874;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=SQ5uCSVdiAbG+S3KVetRBBydKbT1vqYxt9wiRzAv/4E=;
 b=Zx6zW+9vLONQdjOTLMrQf+bOb+csziM+X+V7oAcFHbKvuHTECLtys5J5WzGnt3SR1F
 ZlDSvV7ST4gajDfHhw3l9hJFkiHN4Vl4QlUZsosxoCi6It8oQ0Z0B2GeqonqUE6kMgwY
 Ta3m1VVQuDHxJRwiOQlHVz01ykAjBMN7c0iGN4KqbsQ4jCa7XzqvIpBmWvEigcEPhQyk
 a7EH9earfLDFag/XS/1Pa+gOEkh1dFZcBGxPWsT7Y4YCMIcLm7WOSMOeMNf1+9WroNIf
 YhNY/GhI3RckLCL38c54EkiPwFulYsp1el7jqwsqjYOKSufgLpZkaWkqo8uC855RITn1
 5thw==
X-Gm-Message-State: AOJu0YzDdPF83dQLfcWkFzUJ5r4axPShAIRyZxh+cAhDYb5ae5zSyLg7
 24H7M/FvLHi/0GDBTNaiS25zETUGOzLzVzcWAx31fFIncYSJd0QhTEyUXssJ5iFyp0v4qAr3EHo
 SPEPAQnQSNOQ/7k5+tYMfco3tAjmCPg==
X-Gm-Gg: ASbGncvwnF233GqfwwE6uguHFWAvcQ8bFeFjyjbPAYP/cN/MyyjfnM728jgWuGszSjx
 EQxRdSmB5As8qlYjGmGzy+f4jWhTly4L2xDG1JZk=
X-Google-Smtp-Source: AGHT+IFEy75PUYSp9qrVoLsukaYI4z63qplpuSbRxxCdA+0/VThjGHCvsm7bwMjlrMpb2ANjVC1acUHG+/AdH1Ny3gE=
X-Received: by 2002:a05:6402:3489:b0:5d2:d72a:77f2 with SMTP id
 4fb4d7f45d1cf-5d63c3ed525mr3974961a12.7.1734307073818; Sun, 15 Dec 2024
 15:57:53 -0800 (PST)
MIME-Version: 1.0
References: <CAAxE2A5BkF13bFt8_UnuiqPM8W-ZESgmKEjqqGfv=DGzSfJ7aQ@mail.gmail.com>
 <CAAxE2A77j94VNp33VhO97n3db_fZz1zUpM_VUPfkt96_Dzu9Bg@mail.gmail.com>
 <972c14f7-bf6f-450f-92c5-3f2b8390eac8@froggi.es>
In-Reply-To: <972c14f7-bf6f-450f-92c5-3f2b8390eac8@froggi.es>
From: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>
Date: Sun, 15 Dec 2024 18:57:17 -0500
Message-ID: <CAAxE2A6popiaVF=u5B1swqXLGwnPxFTrqJKSEJJZ4tjVeWDpsA@mail.gmail.com>
Subject: Re: [PATCH] drm/fourcc: add LINEAR modifiers with an exact pitch
 alignment
To: Joshua Ashton <joshua@froggi.es>
Cc: amd-gfx@lists.freedesktop.org
Content-Type: multipart/mixed; boundary="000000000000113c07062957d561"
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

--000000000000113c07062957d561
Content-Type: multipart/alternative; boundary="000000000000113c05062957d55f"

--000000000000113c05062957d55f
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Only for you: Attached.

Marek

On Sun, Dec 15, 2024 at 6:37=E2=80=AFPM Joshua Ashton <joshua@froggi.es> wr=
ote:

> You should just re-send the whole patch, probably.
>
> On 12/15/24 8:54 PM, Marek Ol=C5=A1=C3=A1k wrote:
> > Missed 2 lines from the diff:
> >
> > +#define DRM_FORMAT_MOD_LINEAR_PITCH_ALIGN_128B fourcc_mod_code(NONE, 2=
)
> > +#define DRM_FORMAT_MOD_LINEAR_PITCH_ALIGN_256B fourcc_mod_code(NONE, 3=
)
> >
> > Marek
> >
> > On Sun, Dec 15, 2024 at 3:53=E2=80=AFPM Marek Ol=C5=A1=C3=A1k <maraeo@g=
mail.com
> > <mailto:maraeo@gmail.com>> wrote:
> >
> >     The comment explains the problem with DRM_FORMAT_MOD_LINEAR.
> >
> >     Signed-off-by: Marek Ol=C5=A1=C3=A1k <marek.olsak@amd.com
> >     <mailto:marek.olsak@amd.com>>
> >
> >     diff --git a/include/uapi/drm/drm_fourcc.h b/include/uapi/drm/
> >     drm_fourcc.h
> >     index 78abd819fd62e..8ec4163429014 100644
> >     --- a/include/uapi/drm/drm_fourcc.h
> >     +++ b/include/uapi/drm/drm_fourcc.h
> >     @@ -484,9 +484,27 @@ extern "C" {
> >        * modifier (e.g. not setting DRM_MODE_FB_MODIFIERS in the
> >     DRM_ADDFB2 ioctl),
> >        * which tells the driver to also take driver-internal informatio=
n
> >     into account
> >        * and so might actually result in a tiled framebuffer.
> >     + *
> >     + * WARNING:
> >     + * There are drivers out there that expose DRM_FORMAT_MOD_LINEAR,
> >     but only
> >     + * support a certain pitch alignment and can't import images with
> >     this modifier
> >     + * if the pitch alignment isn't exactly the one supported. They ca=
n
> >     however
> >     + * allocate images with this modifier and other drivers can import
> >     them only
> >     + * if they support the same pitch alignment. Thus,
> >     DRM_FORMAT_MOD_LINEAR is
> >     + * fundamentically incompatible across devices and is the only
> >     modifier that
> >     + * has a chance of not working. The PITCH_ALIGN modifiers should b=
e
> >     used
> >     + * instead.
> >        */
> >       #define DRM_FORMAT_MOD_LINEAR  fourcc_mod_code(NONE, 0)
> >
> >     +/* Linear layout modifiers with an explicit pitch alignment in
> bytes.
> >     + * Exposing this modifier requires that the pitch alignment is
> exactly
> >     + * the number in the definition.
> >     + */
> >     +#define DRM_FORMAT_MOD_LINEAR_PITCH_ALIGN_64B fourcc_mod_code(NONE=
,
> 1)
> >
>
> - Joshie =F0=9F=90=B8=E2=9C=A8
>
>

--000000000000113c05062957d55f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Only for you: Attached.</div><div><br></div><div>Mare=
k<br></div></div><br><div class=3D"gmail_quote gmail_quote_container"><div =
dir=3D"ltr" class=3D"gmail_attr">On Sun, Dec 15, 2024 at 6:37=E2=80=AFPM Jo=
shua Ashton &lt;<a href=3D"mailto:joshua@froggi.es">joshua@froggi.es</a>&gt=
; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px=
 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">You sho=
uld just re-send the whole patch, probably.<br>
<br>
On 12/15/24 8:54 PM, Marek Ol=C5=A1=C3=A1k wrote:<br>
&gt; Missed 2 lines from the diff:<br>
&gt; <br>
&gt; +#define DRM_FORMAT_MOD_LINEAR_PITCH_ALIGN_128B fourcc_mod_code(NONE, =
2)<br>
&gt; +#define DRM_FORMAT_MOD_LINEAR_PITCH_ALIGN_256B fourcc_mod_code(NONE, =
3)<br>
&gt; <br>
&gt; Marek<br>
&gt; <br>
&gt; On Sun, Dec 15, 2024 at 3:53=E2=80=AFPM Marek Ol=C5=A1=C3=A1k &lt;<a h=
ref=3D"mailto:maraeo@gmail.com" target=3D"_blank">maraeo@gmail.com</a> <br>
&gt; &lt;mailto:<a href=3D"mailto:maraeo@gmail.com" target=3D"_blank">marae=
o@gmail.com</a>&gt;&gt; wrote:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0The comment explains the problem with DRM_FORMAT_MO=
D_LINEAR.<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0Signed-off-by: Marek Ol=C5=A1=C3=A1k &lt;<a href=3D=
"mailto:marek.olsak@amd.com" target=3D"_blank">marek.olsak@amd.com</a><br>
&gt;=C2=A0 =C2=A0 =C2=A0&lt;mailto:<a href=3D"mailto:marek.olsak@amd.com" t=
arget=3D"_blank">marek.olsak@amd.com</a>&gt;&gt;<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0diff --git a/include/uapi/drm/drm_fourcc.h b/includ=
e/uapi/drm/<br>
&gt;=C2=A0 =C2=A0 =C2=A0drm_fourcc.h<br>
&gt;=C2=A0 =C2=A0 =C2=A0index 78abd819fd62e..8ec4163429014 100644<br>
&gt;=C2=A0 =C2=A0 =C2=A0--- a/include/uapi/drm/drm_fourcc.h<br>
&gt;=C2=A0 =C2=A0 =C2=A0+++ b/include/uapi/drm/drm_fourcc.h<br>
&gt;=C2=A0 =C2=A0 =C2=A0@@ -484,9 +484,27 @@ extern &quot;C&quot; {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 * modifier (e.g. not setting DRM_MODE_FB_MO=
DIFIERS in the<br>
&gt;=C2=A0 =C2=A0 =C2=A0DRM_ADDFB2 ioctl),<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 * which tells the driver to also take drive=
r-internal information<br>
&gt;=C2=A0 =C2=A0 =C2=A0into account<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 * and so might actually result in a tiled f=
ramebuffer.<br>
&gt;=C2=A0 =C2=A0 =C2=A0+ *<br>
&gt;=C2=A0 =C2=A0 =C2=A0+ * WARNING:<br>
&gt;=C2=A0 =C2=A0 =C2=A0+ * There are drivers out there that expose DRM_FOR=
MAT_MOD_LINEAR,<br>
&gt;=C2=A0 =C2=A0 =C2=A0but only<br>
&gt;=C2=A0 =C2=A0 =C2=A0+ * support a certain pitch alignment and can&#39;t=
 import images with<br>
&gt;=C2=A0 =C2=A0 =C2=A0this modifier<br>
&gt;=C2=A0 =C2=A0 =C2=A0+ * if the pitch alignment isn&#39;t exactly the on=
e supported. They can<br>
&gt;=C2=A0 =C2=A0 =C2=A0however<br>
&gt;=C2=A0 =C2=A0 =C2=A0+ * allocate images with this modifier and other dr=
ivers can import<br>
&gt;=C2=A0 =C2=A0 =C2=A0them only<br>
&gt;=C2=A0 =C2=A0 =C2=A0+ * if they support the same pitch alignment. Thus,=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0DRM_FORMAT_MOD_LINEAR is<br>
&gt;=C2=A0 =C2=A0 =C2=A0+ * fundamentically incompatible across devices and=
 is the only<br>
&gt;=C2=A0 =C2=A0 =C2=A0modifier that<br>
&gt;=C2=A0 =C2=A0 =C2=A0+ * has a chance of not working. The PITCH_ALIGN mo=
difiers should be<br>
&gt;=C2=A0 =C2=A0 =C2=A0used<br>
&gt;=C2=A0 =C2=A0 =C2=A0+ * instead.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0#define DRM_FORMAT_MOD_LINEAR =C2=A0fourcc_m=
od_code(NONE, 0)<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0+/* Linear layout modifiers with an explicit pitch =
alignment in bytes.<br>
&gt;=C2=A0 =C2=A0 =C2=A0+ * Exposing this modifier requires that the pitch =
alignment is exactly<br>
&gt;=C2=A0 =C2=A0 =C2=A0+ * the number in the definition.<br>
&gt;=C2=A0 =C2=A0 =C2=A0+ */<br>
&gt;=C2=A0 =C2=A0 =C2=A0+#define DRM_FORMAT_MOD_LINEAR_PITCH_ALIGN_64B four=
cc_mod_code(NONE, 1)<br>
&gt; <br>
<br>
- Joshie =F0=9F=90=B8=E2=9C=A8<br>
<br>
</blockquote></div>

--000000000000113c05062957d55f--

--000000000000113c07062957d561
Content-Type: text/x-patch; charset="UTF-8"; 
	name="0001-drm-fourcc-add-LINEAR-modifiers-with-an-exact-pitch-.patch"
Content-Disposition: attachment; 
	filename="0001-drm-fourcc-add-LINEAR-modifiers-with-an-exact-pitch-.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_m4q9mfrr0>
X-Attachment-Id: f_m4q9mfrr0

RnJvbSA1MGU2YWE0ZjUxODJkYTVjZTI0N2E5NWM5YWM2OWVhZWIzNDljYjllIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiA9P1VURi04P3E/TWFyZWs9MjBPbD1DNT1BMT1DMz1BMWs/PSA8
bWFyZWsub2xzYWtAYW1kLmNvbT4KRGF0ZTogU3VuLCAxNSBEZWMgMjAyNCAxNTo0OTozMCAtMDUw
MApTdWJqZWN0OiBbUEFUQ0hdIGRybS9mb3VyY2M6IGFkZCBMSU5FQVIgbW9kaWZpZXJzIHdpdGgg
YW4gZXhhY3QgcGl0Y2gKIGFsaWdubWVudApNSU1FLVZlcnNpb246IDEuMApDb250ZW50LVR5cGU6
IHRleHQvcGxhaW47IGNoYXJzZXQ9VVRGLTgKQ29udGVudC1UcmFuc2Zlci1FbmNvZGluZzogOGJp
dAoKVGhlIGNvbW1lbnQgZXhwbGFpbnMgdGhlIHByb2JsZW0gd2l0aCBEUk1fRk9STUFUX01PRF9M
SU5FQVIuCgpTaWduZWQtb2ZmLWJ5OiBNYXJlayBPbMWhw6FrIDxtYXJlay5vbHNha0BhbWQuY29t
PgotLS0KIGluY2x1ZGUvdWFwaS9kcm0vZHJtX2ZvdXJjYy5oIHwgMTggKysrKysrKysrKysrKysr
KysrCiAxIGZpbGUgY2hhbmdlZCwgMTggaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL2luY2x1
ZGUvdWFwaS9kcm0vZHJtX2ZvdXJjYy5oIGIvaW5jbHVkZS91YXBpL2RybS9kcm1fZm91cmNjLmgK
aW5kZXggNzhhYmQ4MTlmZDYyZS4uOGVjNDE2MzQyOTAxNCAxMDA2NDQKLS0tIGEvaW5jbHVkZS91
YXBpL2RybS9kcm1fZm91cmNjLmgKKysrIGIvaW5jbHVkZS91YXBpL2RybS9kcm1fZm91cmNjLmgK
QEAgLTQ4NCw5ICs0ODQsMjcgQEAgZXh0ZXJuICJDIiB7CiAgKiBtb2RpZmllciAoZS5nLiBub3Qg
c2V0dGluZyBEUk1fTU9ERV9GQl9NT0RJRklFUlMgaW4gdGhlIERSTV9BRERGQjIgaW9jdGwpLAog
ICogd2hpY2ggdGVsbHMgdGhlIGRyaXZlciB0byBhbHNvIHRha2UgZHJpdmVyLWludGVybmFsIGlu
Zm9ybWF0aW9uIGludG8gYWNjb3VudAogICogYW5kIHNvIG1pZ2h0IGFjdHVhbGx5IHJlc3VsdCBp
biBhIHRpbGVkIGZyYW1lYnVmZmVyLgorICoKKyAqIFdBUk5JTkc6CisgKiBUaGVyZSBhcmUgZHJp
dmVycyBvdXQgdGhlcmUgdGhhdCBleHBvc2UgRFJNX0ZPUk1BVF9NT0RfTElORUFSLCBidXQgb25s
eQorICogc3VwcG9ydCBhIGNlcnRhaW4gcGl0Y2ggYWxpZ25tZW50IGFuZCBjYW4ndCBpbXBvcnQg
aW1hZ2VzIHdpdGggdGhpcyBtb2RpZmllcgorICogaWYgdGhlIHBpdGNoIGFsaWdubWVudCBpc24n
dCBleGFjdGx5IHRoZSBvbmUgc3VwcG9ydGVkLiBUaGV5IGNhbiBob3dldmVyCisgKiBhbGxvY2F0
ZSBpbWFnZXMgd2l0aCB0aGlzIG1vZGlmaWVyIGFuZCBvdGhlciBkcml2ZXJzIGNhbiBpbXBvcnQg
dGhlbSBvbmx5CisgKiBpZiB0aGV5IHN1cHBvcnQgdGhlIHNhbWUgcGl0Y2ggYWxpZ25tZW50LiBU
aHVzLCBEUk1fRk9STUFUX01PRF9MSU5FQVIgaXMKKyAqIGZ1bmRhbWVudGljYWxseSBpbmNvbXBh
dGlibGUgYWNyb3NzIGRldmljZXMgYW5kIGlzIHRoZSBvbmx5IG1vZGlmaWVyIHRoYXQKKyAqIGhh
cyBhIGNoYW5jZSBvZiBub3Qgd29ya2luZy4gVGhlIFBJVENIX0FMSUdOIG1vZGlmaWVycyBzaG91
bGQgYmUgdXNlZAorICogaW5zdGVhZC4KICAqLwogI2RlZmluZSBEUk1fRk9STUFUX01PRF9MSU5F
QVIJZm91cmNjX21vZF9jb2RlKE5PTkUsIDApCiAKKy8qIExpbmVhciBsYXlvdXQgbW9kaWZpZXJz
IHdpdGggYW4gZXhwbGljaXQgcGl0Y2ggYWxpZ25tZW50IGluIGJ5dGVzLgorICogRXhwb3Npbmcg
dGhpcyBtb2RpZmllciByZXF1aXJlcyB0aGF0IHRoZSBwaXRjaCBhbGlnbm1lbnQgaXMgZXhhY3Rs
eQorICogdGhlIG51bWJlciBpbiB0aGUgZGVmaW5pdGlvbi4KKyAqLworI2RlZmluZSBEUk1fRk9S
TUFUX01PRF9MSU5FQVJfUElUQ0hfQUxJR05fNjRCIGZvdXJjY19tb2RfY29kZShOT05FLCAxKQor
I2RlZmluZSBEUk1fRk9STUFUX01PRF9MSU5FQVJfUElUQ0hfQUxJR05fMTI4QiBmb3VyY2NfbW9k
X2NvZGUoTk9ORSwgMikKKyNkZWZpbmUgRFJNX0ZPUk1BVF9NT0RfTElORUFSX1BJVENIX0FMSUdO
XzI1NkIgZm91cmNjX21vZF9jb2RlKE5PTkUsIDMpCisKIC8qCiAgKiBEZXByZWNhdGVkOiB1c2Ug
RFJNX0ZPUk1BVF9NT0RfTElORUFSIGluc3RlYWQKICAqCi0tIAoyLjQzLjAKCg==
--000000000000113c07062957d561--
