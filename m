Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F15FC0218A
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Jan 2025 15:07:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E512510E67B;
	Tue, 28 Jan 2025 15:07:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="muWHYuWO";
	dkim-atps=neutral
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com
 [209.85.214.178])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 21B7C10E67B
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Jan 2025 15:07:28 +0000 (UTC)
Received: by mail-pl1-f178.google.com with SMTP id
 d9443c01a7336-21c0e29b26bso11272535ad.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Jan 2025 07:07:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1738076847; x=1738681647; darn=lists.freedesktop.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=3nUPgPtZFSmbsT6Mfb1ZnmYurDYzqm93eTN8nErv4EE=;
 b=muWHYuWOlzuMOXOmqHLHu/kd8DQ7m3plN/6kyYlHWBmOQEhIsO4BktXtI0oLUnNVXR
 Gd7moIqlUO6LHv3B/I67o/aGRlL0Thf8XYLhz8+AFFNRB71tq+hIYvxwAKZLRUqbsx93
 8MVty/9wBIGZwYQn+LDKl7Jh/kPVMlgUd/0Wf+QmiwgMJgrDQTA5ODzWSK/FH5h3OXzu
 DyeLXpSQTTk5Sj4B0WViT6X9BkiSKprZIPHtPdhvLV9K7qZR7vu9GqmNfQAC3yxVab0M
 t+qK/TlvpmDAyyBesCcHgYUsg2G9sMGkhvlmPxYLra0LkuYVPQQYji9ccLqR1FmpMF2M
 hwDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738076847; x=1738681647;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3nUPgPtZFSmbsT6Mfb1ZnmYurDYzqm93eTN8nErv4EE=;
 b=ORbmzAzvgq6KxYMK9XxTUt0BLrCWjvw9iCtX73S62TMdqUt8yaHBqLds+cQTevd+qV
 nIy8+H/Aclrw/CmKHclcZt9pvTZNThJ9owkkd2IWu8BQy630WmwR7WtrgJRy5fTv912L
 MXE+YElgKLFoE8q2HNLTNLfi3/rSsfKbNv1O6BO2750hKjN6ISHPcFg741ezA6IsyLZA
 H3GNw4sfXPwt3dRaZBOXT3JByhls5/DEMckFAkYVO5phkru+Kg1Lc6rw3jtgZZkCr05Q
 9cakOzE5d/4QcGZn2cvAemwiylx+JCw3M0H2YtbGoZQANWmJYxa/hq1TZCndXaxN0hTJ
 RmEA==
X-Gm-Message-State: AOJu0Yze92CZUISBHVvb/BcuKjI+Pbaxv9ijCDRRVXOUtSPdMHR/Ldym
 dpO2zNfZ4z8qzAUcjlqQUIByTdkPuL//qv6MFe8XOQo6SJWvSgrm80tlr0IlSVSeO1YB4h35auO
 zSqBkmq+DTXe4IRSpsTFbynFbKM3Hgw==
X-Gm-Gg: ASbGncvJcWsOfPjW7D/eZrDgEjIKs6YdTm/Z5WfaQgnkosDww74G5Kf+4kkusby+4hW
 ZHcWEoYLx+NxAMy7jiWIkQAKDjFMFa2bYUqNP7xo+5WPMvHkjJkssLoJEaKeuyc1+/v+8AI+Z
X-Google-Smtp-Source: AGHT+IFQQxGDzwsA0grlCecEqjXFHOrV2+Ewp64/RgegulFgue9T+30FeSqEIqlxBKr8Q3MpGUtQOsmmNISGXrUSvM4=
X-Received: by 2002:a17:903:1c7:b0:216:536a:9d3b with SMTP id
 d9443c01a7336-21c352cb700mr245812025ad.1.1738076847501; Tue, 28 Jan 2025
 07:07:27 -0800 (PST)
MIME-Version: 1.0
References: <20250114213157.19de9009@ryz.dorfdsl.de>
 <CADnq5_MFq-OWn7dwTTPPcBbFKQmBHvD6qCi8ngiVumk2V1U40g@mail.gmail.com>
 <20250115160834.033e8aad@ryz.dorfdsl.de> <20250115211039.09e6e69e@zbook>
 <CADnq5_MY+cN0dPTis582HY0a80rNiO86kz9Ha=e=HS2Toim=4w@mail.gmail.com>
 <20250115213511.2feaa331@zbook>
 <CADnq5_MbeTRb642qwb0Q7JbL=2UsnK6RnLm6NWTeVLZOEuyn4A@mail.gmail.com>
 <20250116172916.0dba9ff6@ryz.dorfdsl.de>
 <CADnq5_NU-stpay1uFHXD9fVemg4snyE-eZZ4rfyg2Mc3x2OLyg@mail.gmail.com>
 <20250116173734.256704ca@ryz.dorfdsl.de>
 <CADnq5_O_WcZJ7yoDKEJpktSqffbP8RENhChmkD8Es7NHRYhCAg@mail.gmail.com>
 <20250124110225.6a0a87ad@ryz.dorfdsl.de>
 <CADnq5_PwhCK0DfUrEgmdpoFmcBcS-FobGf8p20fSDHOrPTFrNg@mail.gmail.com>
 <20250125193837.373438f7@ryz.dorfdsl.de>
In-Reply-To: <20250125193837.373438f7@ryz.dorfdsl.de>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 28 Jan 2025 10:07:15 -0500
X-Gm-Features: AWEUYZn_BffBZJ9DEGPY3gCuXktsuReKIeSRQ3joX5dKj6zpfwPMdul7-XVJgKU
Message-ID: <CADnq5_ODfJtaRpQpkSbkSuCQobHyz3QZ-CO2KkPuaqHBuupKvw@mail.gmail.com>
Subject: Re: amdgpu 100% CPU usage causing freeze 1002:15d8
To: Marco Moock <mm@dorfdsl.de>
Cc: amd-gfx@lists.freedesktop.org
Content-Type: multipart/mixed; boundary="000000000000168e25062cc58d51"
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

--000000000000168e25062cc58d51
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Can you try the attached patch (with no other patches applied)?  I
think it should fix the issue.

Alex

On Sat, Jan 25, 2025 at 1:38=E2=80=AFPM Marco Moock <mm@dorfdsl.de> wrote:
>
> Am 24.01.2025 um 16:40:37 Uhr schrieb Alex Deucher:
>
> > On Fri, Jan 24, 2025 at 9:17=E2=80=AFAM Marco Moock <mm@dorfdsl.de> wro=
te:
> > >
> > > Am 20.01.2025 um 11:35:07 Uhr schrieb Alex Deucher:
> > >
> > > > On Thu, Jan 16, 2025 at 11:57=E2=80=AFAM Marco Moock <mm@dorfdsl.de=
>
> > > > wrote:
> > > > >
> > > > > Am 16.01.2025 um 11:32:42 Uhr schrieb Alex Deucher:
> > > > >
> > > > > > I'd like to see the driver messages leading up to that.
> > > > >
> > > > > I've now attached the entire dmesg without the firewall stuff.
> > > >
> > > > Does the attached test patch help?
> > >
> > > I've now compiled a kernel with the patch.
> > > It doesn't change the freeze problem.
> >
> > Thanks,
> >
> > Does setting amdgpu.ppfeaturemask=3D0xfff73fff on the kernel command
> > line in grub help?
>
> No crash anymore.
>
>
> --
> Gru=C3=9F
> Marco
>
> Send unsolicited bulk mail to 1737733237muell@cartoonies.org

--000000000000168e25062cc58d51
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0001-drm-amdgpu-gfx9-disallow-gfxoff-when-doing-KCQ-reset.patch"
Content-Disposition: attachment; 
	filename="0001-drm-amdgpu-gfx9-disallow-gfxoff-when-doing-KCQ-reset.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_m6gm2gue0>
X-Attachment-Id: f_m6gm2gue0

RnJvbSA4NThkMDBmY2Q0MzM2NmNkNGFmNjhjZjQ2NGYyZTI2Mzk1YTc1NzhlIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5j
b20+CkRhdGU6IFR1ZSwgMjggSmFuIDIwMjUgMTA6MDI6NDkgLTA1MDAKU3ViamVjdDogW1BBVENI
XSBkcm0vYW1kZ3B1L2dmeDk6IGRpc2FsbG93IGdmeG9mZiB3aGVuIGRvaW5nIEtDUSByZXNldAoK
U2hvdWxkIGZpeCBoYW5ncyB3aGVuIHJlc2V0dGluZyBLQ1FzIG9uIHJhdmVuIEFQVXMuCgpMaW5r
OiBodHRwczovL2dpdGxhYi5mcmVlZGVza3RvcC5vcmcvZHJtL2FtZC8tL2lzc3Vlcy8zODYxClNp
Z25lZC1vZmYtYnk6IEFsZXggRGV1Y2hlciA8YWxleGFuZGVyLmRldWNoZXJAYW1kLmNvbT4KLS0t
CiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjlfMC5jIHwgMiArKwogMSBmaWxlIGNo
YW5nZWQsIDIgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L2dmeF92OV8wLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjlfMC5j
CmluZGV4IDZhYTcxM2NmYTJmM2UuLjRmZTk3ZjMzODJhNjQgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92OV8wLmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvZ2Z4X3Y5XzAuYwpAQCAtNzMwMiw2ICs3MzAyLDcgQEAgc3RhdGljIGludCBnZnhfdjlf
MF9yZXNldF9rY3Eoc3RydWN0IGFtZGdwdV9yaW5nICpyaW5nLAogCWlmIChyKQogCQlyZXR1cm4g
cjsKIAorCWFtZGdwdV9nZnhfb2ZmX2N0cmwoYWRldiwgZmFsc2UpOwogCS8qIG1ha2Ugc3VyZSBk
ZXF1ZXVlIGlzIGNvbXBsZXRlKi8KIAlhbWRncHVfZ2Z4X3JsY19lbnRlcl9zYWZlX21vZGUoYWRl
diwgMCk7CiAJbXV0ZXhfbG9jaygmYWRldi0+c3JibV9tdXRleCk7CkBAIC03MzE2LDYgKzczMTcs
NyBAQCBzdGF0aWMgaW50IGdmeF92OV8wX3Jlc2V0X2tjcShzdHJ1Y3QgYW1kZ3B1X3JpbmcgKnJp
bmcsCiAJc29jMTVfZ3JibV9zZWxlY3QoYWRldiwgMCwgMCwgMCwgMCwgMCk7CiAJbXV0ZXhfdW5s
b2NrKCZhZGV2LT5zcmJtX211dGV4KTsKIAlhbWRncHVfZ2Z4X3JsY19leGl0X3NhZmVfbW9kZShh
ZGV2LCAwKTsKKwlhbWRncHVfZ2Z4X29mZl9jdHJsKGFkZXYsIHRydWUpOwogCWlmIChyKSB7CiAJ
CWRldl9lcnIoYWRldi0+ZGV2LCAiZmFpbCB0byB3YWl0IG9uIGhxZCBkZWFjdGl2ZVxuIik7CiAJ
CXJldHVybiByOwotLSAKMi40OC4xCgo=
--000000000000168e25062cc58d51--
