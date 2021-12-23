Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DD1CC433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Dec 2021 19:21:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E8A7C10E3DF;
	Thu, 23 Dec 2021 19:21:07 +0000 (UTC)
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com
 [IPv6:2607:f8b0:4864:20::22b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4B1DD10E3DF
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Dec 2021 19:21:07 +0000 (UTC)
Received: by mail-oi1-x22b.google.com with SMTP id t204so4363678oie.7
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Dec 2021 11:21:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Rk6ieWv+x1OLF2elTshj6an8oPyhtm+yPWSMpfTEoRo=;
 b=HQrMt1eY8zk3hhlY4KlKI2qU56M9lAIVebURpn5QKjpeCyzN4xgbIC/YkSHdBXClze
 1BaN4204hMJM6DGumd6GjgNSMCE2dzlK9UmuqXUolRkxxor9wpe7fkCKlrFqAq1parW4
 bhociJ+o7pLhgU9caCCoY3d3rVUOZYGXHwaha04X3ejreZlkLrYCRhdFuRZQqxvVV7t+
 wWiAcibQMdwK1fF+ZB+a6aaJ103oJoA1eQJSRrvLAQ3NUmLQTdjc6Mx0f5GqDmlP2pTB
 el4n3GRoORA7Sn5zzTMvR9+B0BbK76dPd72hwukFPopoMtVqDwiAX8ovGgjxfH/otBWu
 YjQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Rk6ieWv+x1OLF2elTshj6an8oPyhtm+yPWSMpfTEoRo=;
 b=ujsoITOy8YlvWnnIzqaVoKAyWbe4yQNLuCi+WSgUssSuTcbL86UHVcfEsYG6gwOivC
 1dsAEzB2XYEu4Q1BqbM16SwfVD+qpAOIOgIh13skD7t++5enOXf4P74zwpsOfkFtEIJ2
 vrJeFPzfdfk3xZlWbeFzd8KYDGdwwW/3arbA/lauxl8DH94LbujV33g9pszDR7WZq96U
 7SgrZ58fUAqboL5WBaGk6PxXe3HBpzHw5nMxjSg2B5ZKZOgi3zB4+Kn9p/ZZCpHQlBep
 itoorZ0EmoX2slaYCBY96kAQtTFrcilmzquT1DyjD0RCRJROtzoXuvYVz111bWtk9wls
 26Gg==
X-Gm-Message-State: AOAM530LwUjFTkMM/mZup+6QS4xLRcdcIG6yFAPw02P9PiDsxGHkHLlQ
 yU+0+2+4QHCU0CQBpUQHnSQnGAaJyjSAbFq4gY4=
X-Google-Smtp-Source: ABdhPJwGJ2SYkNHnDSlwJuTeoWZvWXOkoWSlxebTIDPzFXB5H/2fy0zkehlPiBmQSXGuOAwqwuL7RPIao2fMkz0N4Uo=
X-Received: by 2002:a05:6808:68f:: with SMTP id
 k15mr2700626oig.5.1640287266514; 
 Thu, 23 Dec 2021 11:21:06 -0800 (PST)
MIME-Version: 1.0
References: <1240565206.508633.1640262607606.ref@mail.yahoo.com>
 <1240565206.508633.1640262607606@mail.yahoo.com>
In-Reply-To: <1240565206.508633.1640262607606@mail.yahoo.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 23 Dec 2021 14:20:55 -0500
Message-ID: <CADnq5_Ohep6ZY4UyMJTs8ELP+Sq4Mjff_AMcEA7AzR36WYR6ug@mail.gmail.com>
Subject: Re: [bisected][regression] drm: amdgpu: system hangs on tty login
 prompt
To: "Tareque Md.Hanif" <tarequemd.hanif@yahoo.com>
Content-Type: multipart/mixed; boundary="000000000000d9c1ac05d3d52376"
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
Cc: "alexander.deucher@amd.com" <alexander.deucher@amd.com>,
 "Xinhui.Pan@amd.com" <Xinhui.Pan@amd.com>,
 "christian.koenig@amd.com" <christian.koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--000000000000d9c1ac05d3d52376
Content-Type: text/plain; charset="UTF-8"

The attached patch should fix this.

Alex

On Thu, Dec 23, 2021 at 2:04 PM Tareque Md.Hanif
<tarequemd.hanif@yahoo.com> wrote:
>
> Hi,
>
> I have been testing the 5.16-rc6 kernel and it hangs on tty login prompt on my laptop. Sometimes it lets me to login but "startx" hangs the system. The system is booting fine in 5.15.7.
>
> So I bisected the bug.
>
> first bad commit: [f7f12b25823c0dce1165b390522d29f99c4585b4] drm/amdgpu: default to true in amdgpu_device_asic_has_dc_support
>
> Reverting this commit fixes the issue.
>
> Device Information:
> Laptop model: Dell Inspiron 15 5567
> GPU 0: Intel HD Graphics 620
> GPU 1: AMD ATI Radeon R7 M445
>
> Regards,
> Tareque.
>

--000000000000d9c1ac05d3d52376
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0001-drm-amdgpu-no-DC-support-for-headless-chips.patch"
Content-Disposition: attachment; 
	filename="0001-drm-amdgpu-no-DC-support-for-headless-chips.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_kxjcodfy0>
X-Attachment-Id: f_kxjcodfy0

RnJvbSA3YjA3NmYxYWI1NjIyMTFkMmYyMWQyMmYyZmY5OTIwNTAzNzk2ZjA2IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5j
b20+CkRhdGU6IFRodSwgMjMgRGVjIDIwMjEgMTQ6MTM6MDIgLTA1MDAKU3ViamVjdDogW1BBVENI
XSBkcm0vYW1kZ3B1OiBubyBEQyBzdXBwb3J0IGZvciBoZWFkbGVzcyBjaGlwcwoKQ2hpcHMgd2l0
aCBubyBkaXNwbGF5IGhhcmR3YXJlIHNob3VsZCByZXR1cm4gZmFsc2UgZm9yCkRDIHN1cHBvcnQu
CgpGaXhlczogZjdmMTJiMjU4MjNjMGQgKCJkcm0vYW1kZ3B1OiBkZWZhdWx0IHRvIHRydWUgaW4g
YW1kZ3B1X2RldmljZV9hc2ljX2hhc19kY19zdXBwb3J0IikKU2lnbmVkLW9mZi1ieTogQWxleCBE
ZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPgotLS0KIGRyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L2FtZGdwdV9kZXZpY2UuYyB8IDggKysrKysrKysKIDEgZmlsZSBjaGFuZ2VkLCA4
IGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9h
bWRncHVfZGV2aWNlLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGV2aWNl
LmMKaW5kZXggOWRjODZjNWExY2FkLi41OGUyMDM0OTg0ZGUgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZXZpY2UuYworKysgYi9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9hbWRncHVfZGV2aWNlLmMKQEAgLTMxNjYsNiArMzE2NiwxNCBAQCBzdGF0aWMg
dm9pZCBhbWRncHVfZGV2aWNlX2RldGVjdF9zcmlvdl9iaW9zKHN0cnVjdCBhbWRncHVfZGV2aWNl
ICphZGV2KQogYm9vbCBhbWRncHVfZGV2aWNlX2FzaWNfaGFzX2RjX3N1cHBvcnQoZW51bSBhbWRf
YXNpY190eXBlIGFzaWNfdHlwZSkKIHsKIAlzd2l0Y2ggKGFzaWNfdHlwZSkgeworI2lmZGVmIENP
TkZJR19EUk1fQU1ER1BVX1NJCisJY2FzZSBDSElQX0hBSU5BTjoKKyNlbmRpZgorCWNhc2UgQ0hJ
UF9UT1BBWjoKKwljYXNlIENISVBfQVJDVFVSVVM6CisJY2FzZSBDSElQX0FMREVCQVJBTjoKKwkJ
LyogY2hpcHMgd2l0aCBubyBkaXNwbGF5IGhhcmR3YXJlICovCisJCXJldHVybiBmYWxzZTsKICNp
ZiBkZWZpbmVkKENPTkZJR19EUk1fQU1EX0RDKQogCWNhc2UgQ0hJUF9UQUhJVEk6CiAJY2FzZSBD
SElQX1BJVENBSVJOOgotLSAKMi4zMy4xCgo=
--000000000000d9c1ac05d3d52376--
