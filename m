Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EDBFC02190
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Jan 2025 17:06:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AED9810E6D2;
	Tue, 28 Jan 2025 17:06:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="jww5n0SM";
	dkim-atps=neutral
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com
 [209.85.216.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3A0D510E6D2
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Jan 2025 17:06:24 +0000 (UTC)
Received: by mail-pj1-f49.google.com with SMTP id
 98e67ed59e1d1-2ef6ee55225so1220403a91.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Jan 2025 09:06:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1738083984; x=1738688784; darn=lists.freedesktop.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Rg2KELkwrnfvQXKDxkPh5Whez4zEvQNT5j0JEdCK3YA=;
 b=jww5n0SMaNN50YOfcKu5bAWj3sB3PKxig7+bmKqMyS/RekRicRFRpTtb+P5HrhgvGl
 a+TY6+b9IK5TCqu0vXDYMo3ZHlFkww3BL76HV7kuPwdjL87cE5BAHUpYKRSPo+9stT7U
 y8uwQayaS8MLaPpEPp2g1qCrJ87yiO11rwc1t9PHUE7KVuq3Mqt32mXJrSjf3L7i680F
 VoNyWw435Jk9ME4MJZXA/YcmMsI767Rb30551Ai/owa+3UhoobQKWSGY2QL3iSyQ2LBj
 W4sMyPus8zE4DK5G2Hlpj+wESiAMvsLsEbCYhOk5OU/SIiXsyKUqrX9aFwohh6il0Qzm
 KHNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738083984; x=1738688784;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Rg2KELkwrnfvQXKDxkPh5Whez4zEvQNT5j0JEdCK3YA=;
 b=sCupCEtUKSes5h3xKeEs1KVRTaps+RyuiiWCxzjIG2x960SkM19v45DNRv9zSGusnv
 7ZpauQXjOmb7/ywVjWAJ0JOTd98JKXBT9zpiq6IpgfviDTgbTq3rzfP0UcbR5au/XcGM
 87ncOOQkBAhNZRcpFFwGpf6Xwjy9vp+OZ/pGyhckUBfoXIb3nIgkfNRlCyhsPETO8k1h
 WwxOWM3sPbuEY3mf4sd484wi2L3+l0YtDP7M3P1NuDx4YbVRVpSKgCkHllu/4O4r6+64
 cpvKEVDqmeMBDJ2Pekuzia7TOrfmh4JQDYWFG5KSNCkUr0mO88DlAyekMcDPbX1WgDNv
 mq6g==
X-Gm-Message-State: AOJu0Yw2/EziVHrfC/kp6iCUAC0m6N2S7HIgI+qXoCBrZQ0/Fg2qWkZb
 vI6BkjXoLof9OdkH26NkTja+LuKt94NhVZwqbH5YlCGXL7tiQPpeGfZRK6WyNKv6ZV0J5ehc8jB
 fXR584ZKrtt6qHp168AJeKVoKoRN16A==
X-Gm-Gg: ASbGncubCXq+5VEUNasvE0iYBgIwntMSHx53rnEWpJ3HECibd5eekYmV14vi9d9yTpY
 RqiW1Y4oKXg8mCQacxdmQEcRF1WhAf8jNWK7jAbJ/OhzGrl2d0AvAn0GdQwl1KaMDdPTjtkhbl2
 xPjozjKr4=
X-Google-Smtp-Source: AGHT+IGzIHWn6oTfOxt1r2jnI+N2IjVD4S0TJNIQq+dR0FrAtxfT/I6ZNzrKQjR7NmL50MZEF8oDjq5Q/xWdKKkOvwo=
X-Received: by 2002:a17:90a:d64e:b0:2ee:d372:91bd with SMTP id
 98e67ed59e1d1-2f7e3efc78dmr15885370a91.2.1738083983625; Tue, 28 Jan 2025
 09:06:23 -0800 (PST)
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
 <CADnq5_ODfJtaRpQpkSbkSuCQobHyz3QZ-CO2KkPuaqHBuupKvw@mail.gmail.com>
In-Reply-To: <CADnq5_ODfJtaRpQpkSbkSuCQobHyz3QZ-CO2KkPuaqHBuupKvw@mail.gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 28 Jan 2025 12:06:11 -0500
X-Gm-Features: AWEUYZmcDwFFijJ-VakLGYQ_Qd3j2xIN79svTrc3d7KdGFKtr680--tQxVGeUPg
Message-ID: <CADnq5_Pg2JMuJ13ow0AcVgMqUvin6Oj41hmWYqP6+Vrjq3cMWQ@mail.gmail.com>
Subject: Re: amdgpu 100% CPU usage causing freeze 1002:15d8
To: Marco Moock <mm@dorfdsl.de>
Cc: amd-gfx@lists.freedesktop.org
Content-Type: multipart/mixed; boundary="0000000000006f28d8062cc736b2"
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

--0000000000006f28d8062cc736b2
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Another potential better patch to try.

Alex

On Tue, Jan 28, 2025 at 10:07=E2=80=AFAM Alex Deucher <alexdeucher@gmail.co=
m> wrote:
>
> Can you try the attached patch (with no other patches applied)?  I
> think it should fix the issue.
>
> Alex
>
> On Sat, Jan 25, 2025 at 1:38=E2=80=AFPM Marco Moock <mm@dorfdsl.de> wrote=
:
> >
> > Am 24.01.2025 um 16:40:37 Uhr schrieb Alex Deucher:
> >
> > > On Fri, Jan 24, 2025 at 9:17=E2=80=AFAM Marco Moock <mm@dorfdsl.de> w=
rote:
> > > >
> > > > Am 20.01.2025 um 11:35:07 Uhr schrieb Alex Deucher:
> > > >
> > > > > On Thu, Jan 16, 2025 at 11:57=E2=80=AFAM Marco Moock <mm@dorfdsl.=
de>
> > > > > wrote:
> > > > > >
> > > > > > Am 16.01.2025 um 11:32:42 Uhr schrieb Alex Deucher:
> > > > > >
> > > > > > > I'd like to see the driver messages leading up to that.
> > > > > >
> > > > > > I've now attached the entire dmesg without the firewall stuff.
> > > > >
> > > > > Does the attached test patch help?
> > > >
> > > > I've now compiled a kernel with the patch.
> > > > It doesn't change the freeze problem.
> > >
> > > Thanks,
> > >
> > > Does setting amdgpu.ppfeaturemask=3D0xfff73fff on the kernel command
> > > line in grub help?
> >
> > No crash anymore.
> >
> >
> > --
> > Gru=C3=9F
> > Marco
> >
> > Send unsolicited bulk mail to 1737733237muell@cartoonies.org

--0000000000006f28d8062cc736b2
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0001-drm-amdgpu-gfx9-manually-control-gfxoff-for-CS.patch"
Content-Disposition: attachment; 
	filename="0001-drm-amdgpu-gfx9-manually-control-gfxoff-for-CS.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_m6gqbhhz0>
X-Attachment-Id: f_m6gqbhhz0

RnJvbSA4MWEzMTUyMjk5OWY2YTYyYWU4OWVhNWE4MzI1ZDg1NzNkZDc3NWY3IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5j
b20+CkRhdGU6IFR1ZSwgMjggSmFuIDIwMjUgMTE6NTU6MjIgLTA1MDAKU3ViamVjdDogW1BBVENI
XSBkcm0vYW1kZ3B1L2dmeDk6IG1hbnVhbGx5IGNvbnRyb2wgZ2Z4b2ZmIGZvciBDUwoKV2hlbiBt
ZXNhIHN0YXJ0ZWQgdXNpbmcgY29tcHV0ZSBxdWV1ZXMgbW9yZSBvZnRlbgp3ZSBzdGFydGVkIHNl
ZWluZyBhZGRpdGlvbmFsIGhhbmdzIHdpdGggY29tcHV0ZSBxdWV1ZXMuCkRpc2FibGluZyBnZnhv
ZmYgc2VlbXMgdG8gbWl0aWdhdGUgdGhhdC4gIE1hbnVhbGx5CmNvbnRyb2wgZ2Z4b2ZmIHdpdGgg
Y29tbWFuZCBzdWJtaXNzaW9ucyB0byBhdm9pZAphbnkgaXNzdWVzIHJlbGF0ZWQgdG8gZ2Z4b2Zm
LgoKTGluazogaHR0cHM6Ly9naXRsYWIuZnJlZWRlc2t0b3Aub3JnL2RybS9hbWQvLS9pc3N1ZXMv
Mzg2MQpMaW5rOiBodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9hcmNoaXZlcy9hbWQtZ2Z4
LzIwMjUtSmFudWFyeS8xMTkxMTYuaHRtbApTaWduZWQtb2ZmLWJ5OiBBbGV4IERldWNoZXIgPGFs
ZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+Ci0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
Z2Z4X3Y5XzAuYyB8IDM4ICsrKysrKysrKysrKysrKysrKysrKystLS0tLQogMSBmaWxlIGNoYW5n
ZWQsIDMyIGluc2VydGlvbnMoKyksIDYgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3Y5XzAuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2dmeF92OV8wLmMKaW5kZXggNGZlOTdmMzM4MmE2NC4uMWQyZjY0MWQxZGQ5NCAxMDA2NDQK
LS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3Y5XzAuYworKysgYi9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjlfMC5jCkBAIC03NDQ1LDYgKzc0NDUsMzIgQEAgc3Rh
dGljIHZvaWQgZ2Z4X3Y5XzBfcmluZ19lbWl0X2NsZWFuZXJfc2hhZGVyKHN0cnVjdCBhbWRncHVf
cmluZyAqcmluZykKIAlhbWRncHVfcmluZ193cml0ZShyaW5nLCAwKTsgIC8qIFJFU0VSVkVEIGZp
ZWxkLCBwcm9ncmFtbWVkIHRvIHplcm8gKi8KIH0KIAorc3RhdGljIHZvaWQgZ2Z4X3Y5XzBfcmlu
Z19iZWdpbl91c2Uoc3RydWN0IGFtZGdwdV9yaW5nICpyaW5nKQoreworCXN0cnVjdCBhbWRncHVf
ZGV2aWNlICphZGV2ID0gcmluZy0+YWRldjsKKworCS8qIFJhdmVuIGFuZCBQQ08gQVBVcyBzZWVt
IHRvIGhhdmUgc3RhYmlsaXR5IGlzc3VlcworCSAqIHdpdGggY29tcHV0ZSBhbmQgZ2Z4b2ZmLiAg
RGlzYWxsb3cgZ2Z4b2ZmIGR1cmluZworCSAqIHN1Ym1pc3Npb24gYW5kIGFsbG93IGFnYWluIGFm
dGVyd2FyZHMuCisJICovCisJYW1kZ3B1X2dmeF9vZmZfY3RybChhZGV2LCBmYWxzZSk7CisKKwlh
bWRncHVfZ2Z4X2VuZm9yY2VfaXNvbGF0aW9uX3JpbmdfYmVnaW5fdXNlKHJpbmcpOworfQorCitz
dGF0aWMgdm9pZCBnZnhfdjlfMF9yaW5nX2VuZF91c2Uoc3RydWN0IGFtZGdwdV9yaW5nICpyaW5n
KQoreworCXN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2ID0gcmluZy0+YWRldjsKKworCWFtZGdw
dV9nZnhfZW5mb3JjZV9pc29sYXRpb25fcmluZ19lbmRfdXNlKHJpbmcpOworCisJLyogUmF2ZW4g
YW5kIFBDTyBBUFVzIHNlZW0gdG8gaGF2ZSBzdGFiaWxpdHkgaXNzdWVzCisJICogd2l0aCBjb21w
dXRlIGFuZCBnZnhvZmYuICBEaXNhbGxvdyBnZnhvZmYgZHVyaW5nCisJICogc3VibWlzc2lvbiBh
bmQgYWxsb3cgYWdhaW4gYWZ0ZXJ3YXJkcy4KKwkgKi8KKwlhbWRncHVfZ2Z4X29mZl9jdHJsKGFk
ZXYsIHRydWUpOworfQorCiBzdGF0aWMgY29uc3Qgc3RydWN0IGFtZF9pcF9mdW5jcyBnZnhfdjlf
MF9pcF9mdW5jcyA9IHsKIAkubmFtZSA9ICJnZnhfdjlfMCIsCiAJLmVhcmx5X2luaXQgPSBnZnhf
djlfMF9lYXJseV9pbml0LApAQCAtNzUxOCw4ICs3NTQ0LDggQEAgc3RhdGljIGNvbnN0IHN0cnVj
dCBhbWRncHVfcmluZ19mdW5jcyBnZnhfdjlfMF9yaW5nX2Z1bmNzX2dmeCA9IHsKIAkuZW1pdF9t
ZW1fc3luYyA9IGdmeF92OV8wX2VtaXRfbWVtX3N5bmMsCiAJLnJlc2V0ID0gZ2Z4X3Y5XzBfcmVz
ZXRfa2dxLAogCS5lbWl0X2NsZWFuZXJfc2hhZGVyID0gZ2Z4X3Y5XzBfcmluZ19lbWl0X2NsZWFu
ZXJfc2hhZGVyLAotCS5iZWdpbl91c2UgPSBhbWRncHVfZ2Z4X2VuZm9yY2VfaXNvbGF0aW9uX3Jp
bmdfYmVnaW5fdXNlLAotCS5lbmRfdXNlID0gYW1kZ3B1X2dmeF9lbmZvcmNlX2lzb2xhdGlvbl9y
aW5nX2VuZF91c2UsCisJLmJlZ2luX3VzZSA9IGdmeF92OV8wX3JpbmdfYmVnaW5fdXNlLAorCS5l
bmRfdXNlID0gZ2Z4X3Y5XzBfcmluZ19lbmRfdXNlLAogfTsKIAogc3RhdGljIGNvbnN0IHN0cnVj
dCBhbWRncHVfcmluZ19mdW5jcyBnZnhfdjlfMF9zd19yaW5nX2Z1bmNzX2dmeCA9IHsKQEAgLTc1
NzgsOCArNzYwNCw4IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgYW1kZ3B1X3JpbmdfZnVuY3MgZ2Z4
X3Y5XzBfc3dfcmluZ19mdW5jc19nZnggPSB7CiAJLnBhdGNoX2RlID0gZ2Z4X3Y5XzBfcmluZ19w
YXRjaF9kZV9tZXRhLAogCS5wYXRjaF9jZSA9IGdmeF92OV8wX3JpbmdfcGF0Y2hfY2VfbWV0YSwK
IAkuZW1pdF9jbGVhbmVyX3NoYWRlciA9IGdmeF92OV8wX3JpbmdfZW1pdF9jbGVhbmVyX3NoYWRl
ciwKLQkuYmVnaW5fdXNlID0gYW1kZ3B1X2dmeF9lbmZvcmNlX2lzb2xhdGlvbl9yaW5nX2JlZ2lu
X3VzZSwKLQkuZW5kX3VzZSA9IGFtZGdwdV9nZnhfZW5mb3JjZV9pc29sYXRpb25fcmluZ19lbmRf
dXNlLAorCS5iZWdpbl91c2UgPSBnZnhfdjlfMF9yaW5nX2JlZ2luX3VzZSwKKwkuZW5kX3VzZSA9
IGdmeF92OV8wX3JpbmdfZW5kX3VzZSwKIH07CiAKIHN0YXRpYyBjb25zdCBzdHJ1Y3QgYW1kZ3B1
X3JpbmdfZnVuY3MgZ2Z4X3Y5XzBfcmluZ19mdW5jc19jb21wdXRlID0gewpAQCAtNzYyMSw4ICs3
NjQ3LDggQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBhbWRncHVfcmluZ19mdW5jcyBnZnhfdjlfMF9y
aW5nX2Z1bmNzX2NvbXB1dGUgPSB7CiAJLmVtaXRfd2F2ZV9saW1pdCA9IGdmeF92OV8wX2VtaXRf
d2F2ZV9saW1pdCwKIAkucmVzZXQgPSBnZnhfdjlfMF9yZXNldF9rY3EsCiAJLmVtaXRfY2xlYW5l
cl9zaGFkZXIgPSBnZnhfdjlfMF9yaW5nX2VtaXRfY2xlYW5lcl9zaGFkZXIsCi0JLmJlZ2luX3Vz
ZSA9IGFtZGdwdV9nZnhfZW5mb3JjZV9pc29sYXRpb25fcmluZ19iZWdpbl91c2UsCi0JLmVuZF91
c2UgPSBhbWRncHVfZ2Z4X2VuZm9yY2VfaXNvbGF0aW9uX3JpbmdfZW5kX3VzZSwKKwkuYmVnaW5f
dXNlID0gZ2Z4X3Y5XzBfcmluZ19iZWdpbl91c2UsCisJLmVuZF91c2UgPSBnZnhfdjlfMF9yaW5n
X2VuZF91c2UsCiB9OwogCiBzdGF0aWMgY29uc3Qgc3RydWN0IGFtZGdwdV9yaW5nX2Z1bmNzIGdm
eF92OV8wX3JpbmdfZnVuY3Nfa2lxID0gewotLSAKMi40OC4xCgo=
--0000000000006f28d8062cc736b2--
