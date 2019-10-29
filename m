Return-Path: <SRS0=VQNv=YW=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A618CA9EAE
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Oct 2019 22:01:33 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 135DD2087F
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Oct 2019 22:01:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 135DD2087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=users.sourceforge.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C82156EC5F;
	Tue, 29 Oct 2019 22:01:32 +0000 (UTC)
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com
 [IPv6:2607:f8b0:4864:20::432])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7B0B96EC5D
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Oct 2019 22:01:31 +0000 (UTC)
Received: by mail-pf1-x432.google.com with SMTP id u9so68837pfn.4
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Oct 2019 15:01:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:to:from:subject:autocrypt:message-id:date
 :user-agent:mime-version:content-language;
 bh=XwdjDGy5nMZhQPRYmPHrC1Yxm4SIallw04S0v4i0DXU=;
 b=hfZIHojLc5+cBTPzCfxc/v9T9DLqzdXQ96Qw/c6moY/zNGwv2MomL8/212+H8QUr0O
 R8GAqrR8EMpXPK9NOtZe9EkIRD2dJ7GgBnkmz/XNqBE2WTWNvL2Uh91ei/gVvQ95vHHb
 5TKl0njSqaFVr9iVNEqMtrO+h+m+/UVtJ61Xq1ainDorZbhr9B3/pFYBaiRhiYyDPdWw
 Es3AGgOXhvzFxX6zKiFm/1qX+9Vod1+p/k7whG0kxSsXUqFctB21M8MaCbQ/oJabho/l
 io9GMQZZdB7RHHOKQPO/kr5cfH1OQtpkLlGchz3uhU5AcCkpUoCawu+Enmrl0L0nEVQa
 FU2w==
X-Gm-Message-State: APjAAAWKtjhTgArGIbnWc8nqxrL7IlfMActeYPdtNSPZfzSOAzHBlyRV
 +rLhPQIhoskEQMYcjBYIqlnwGcLxFmg=
X-Google-Smtp-Source: APXvYqwuvPbbOhkgYmHNHbkGFvHw9Uxaq1qQx/TzpPwLC9yxljPxTpMRaEhO4MQ/+90ACGZFY4jRbg==
X-Received: by 2002:a17:90a:eb11:: with SMTP id
 j17mr9637472pjz.77.1572386490555; 
 Tue, 29 Oct 2019 15:01:30 -0700 (PDT)
Received: from gideon.lan ([2604:3d09:137e:c000:9dde:82f9:5d1f:6284])
 by smtp.gmail.com with ESMTPSA id ay23sm95681pjb.0.2019.10.29.15.01.29
 for <amd-gfx@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Oct 2019 15:01:29 -0700 (PDT)
To: amd-gfx@lists.freedesktop.org
From: Neil Mayhew <neil_mayhew@users.sourceforge.net>
Subject: 21:9 monitor resolution incorrect since 4.14 kernel
Autocrypt: addr=neil_mayhew@users.sourceforge.net; prefer-encrypt=mutual;
 keydata=
 mQGiBEOCDVoRBACvzIg0gdFah/8QoVvkjqX8bQCtvqE3asNqjQGhgPV6TE2M0jvI1HkqUZlK
 ZG5axdkgBoetMdxALVLvEiUiucqfmA+d9B/YqSu1NPIx//J0bahMbc//jqA4owogREa9ZQvq
 H34Il7238u7n77iauiKu2qCi0ln51aMTj+LLX2uwrwCg+scm7YRE/t44VlneseESIPa73YsE
 AIuzlm5GIb6Gq47nwDKvUYm6+vfEvPQpbwd/JQ5ep629cMgZTg04jNwwtZIb/I6gsfQXR7h3
 qLKdLP1QZmkER5WDg7eqwRTzsst91Ux/vMHxsJ0fJQAuFYiSSE4Hxquh0BperTcky22cA+ad
 7e50VZ5YSRRsyWSy73F3owAOFL5yA/4r9k6/Qs6wk1tJna7nabM9iQvmY5CNsd03evjcV88f
 Wip2HUqTx1Ryygs/4cD4V4cz3jHWNIKJ0vK//wALNs1FSvEgpwhqwjU6tQNcB/F+nxp/eI+P
 /ECjzO7ym2c9wXTBVDo8LTDiV6VXTEB6ei7buG9X1X9yoJrGS/IzrpVR/rQhTmVpbCBNYXlo
 ZXcgPG5laWxfbWF5aGV3QHNpbC5vcmc+iGEEExEIACECGwMCHgECF4AFAlNQGNoFCwkIBwMF
 FQoJCAsFFgIDAQAACgkQYtNAUVcAJm25swCgyaMGhhuJl666H3EjlghDAnxKbh4AnAp6j0nv
 4/kjcTWmGUvHSd8FbwqYuQINBEOCDWAQCACBMwnjPru4hSSLHkU9Ah9Khmqv3aZ/WAMQOE+s
 3eBPutR0q6+VLyaALl7O1nu4qBOIvsbkaa2GdH4KJivFkVE6fJUMDzccSabDjOK5WkK4VloR
 +ZL+ZX9y6qcf8J2ZnKVwhW0BOxQPZTawlXR0bk1sCWw6i9EsS3bOfl+F/BIMP618Xu52uKfb
 RrVf03SZqumtSCHdZ3F9PL6P2Ws4NuGfxD7YC3E9SpE2PP5e2QwtCPQ2ySL8PRv6sQR6p6f0
 shtuqckF/vAsLCHcfLiIBEcpGD10Frm2P9a20jVNbdVeKv2pb15bnEFq8ZstxO0c8NPJesmd
 FOjODFUUwcjK0dJzAAMGB/oCmU+2XNF7XA2GmtS6J/66Zyq3lI/b6wgBhOhL1+OeBmC/B5cz
 UNEwohdy0Ep7R0tDmR+SBYnAYe/W2CTbDc8SNdd3gT+JQIqAiZba6py3oTsRWQ1RaHhJy6fw
 PiMOy51JAnP9D4IxVQ/M67+tTM3+zKLeyet63vjRHG0zjzYSg/FFh87HIETRhvD4dMteS4b+
 07gKyl9YeFRZ2S9cl6bIMG7rKf3G8cU9P2E5Dy0MvHCbYnf9VBz+jAlP7T8XKZEdmv3CIncs
 nHiXE826FTz7HwWG2BmI87fTCycdPz57ufm2b5R8AEQ/A9gjj9Ve7OXG9ujFIBDhF2tqpLsH
 bx56iEkEGBECAAkFAkOCDWACGwwACgkQYtNAUVcAJm2J/QCg04zcu+oxN3MgPr8KvvMzOkbC
 JiEAn1NvGMGPBp/KACJ8Z0ivt32TCBcl
Message-ID: <32e595a2-fdc1-7b13-2e33-c2b8752c60f2@users.sourceforge.net>
Date: Tue, 29 Oct 2019 16:01:29 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
Content-Language: en-CA
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20161025;
 h=sender:to:from:subject:autocrypt:message-id:date:user-agent
 :mime-version:content-language;
 bh=XwdjDGy5nMZhQPRYmPHrC1Yxm4SIallw04S0v4i0DXU=;
 b=f7MPGZImDEdcX/uek4g40EvGgj6Chk/ahtxzCUllO5NIdBorC112MnWAbG/TtilTzv
 Y3Rh9HFSrAkTU2ZfY4/84CEO9l5QBYz9Er4kHIoqdjPAHQUndZDejoAxLmFBYgdFgslY
 Vsbnt+2caOeI4Zln0yKWvei0F8p2tOnPiFF4QfCfLvbbjzFlcltBq1t8AcieFcBfbqRf
 KxSkIePSEsog6BkWVLNgrSTsQIj9G9Am+E9hv1jyifaRmWk1kFh3g5eSJHhRvzEoV8do
 1MZxxa0wGD7hltvWmNVs43x+kOOLwgkxtm9QNk7ZdYoBfMb3F72WLzEh2uHHv7UfXb74
 9Syg==
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0990841692=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191029220129.qt-ZKfJOEwV9GL9uhe5AYK2QT0nT3L3JYh-h0IG9pYs@z>

This is a multi-part message in MIME format.
--===============0990841692==
Content-Type: multipart/alternative;
 boundary="------------4C67A626F291EB74C8147B37"
Content-Language: en-CA

This is a multi-part message in MIME format.
--------------4C67A626F291EB74C8147B37
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: base64

SSBoYXZlIGEgMjE6OSB1bHRyYXdpZGUgbW9uaXRvciBjb25uZWN0ZWQgdG8gYW4gUlggNTcw
IHdpdGggdGhlIGFtZGdwdQpkcml2ZXIuIEknbSBzdGlsbCB1c2luZyB0aGUgNC4xNCBrZXJu
ZWwgc2luY2Ugd2l0aCBsYXRlciBrZXJuZWxzIEkgY2FuJ3QKZ2V0IHRoZSBkcml2ZXIgdG8g
YWxsb3cgdXNlIG9mIHRoZSBmdWxsIHJlc29sdXRpb24gb2YgMjU2MHgxMDgwIGFuZCBJJ20K
bGltaXRlZCB0byByZWd1bGFyIEhELCBpZSAxOTIweDEwODAuIFRoZSBsYXRlc3Qga2VybmVs
IEkndmUgdHJpZWQgaXMKNS40LXJjMi4gTXkgZGlzdHJvIGlzIE5peE9TIHVuc3RhYmxlLXNt
YWxsLiBJIGhhdmUgdHdvIG90aGVyIG1vbml0b3JzCigxNjo5IGFuZCAxNjoxMCkgY29ubmVj
dGVkIHRvIHRoZSBzYW1lIGdyYXBoaWNzIGNhcmQuCgpJcyB0aGVyZSBhbnl0aGluZyBJIGNh
biBkbyB0byB3b3JrIGFyb3VuZCB0aGlzIG9yIHRyeSB0byBmaXggaXQ/IEkgaGFkIGEKbG9v
ayBhdCB0aGUgZHJpdmVyIHNvdXJjZXMgYnV0IGNvdWxkbid0IGZpbmQgd2hlcmUgdGhlIG1v
ZGUgaXMgc2V0LiBJJ20KaGFwcHkgdG8gdHJ5IHRoaW5ncyBpZiBzb21lb25lIGNhbiBwb2lu
dCBtZSBpbiB0aGUgcmlnaHQgZGlyZWN0aW9uLCBldmVuCmlmIGl0J3MganVzdCB0byBnYXRo
ZXIgYmV0dGVyIGluZm8gZm9yIGEgYnVnIHJlcG9ydC4gVXNpbmcgc3VjaCBhbiBvbGQKa2Vy
bmVsIGlzIGJlY29taW5nIHJlYWxseSBpbmNvbnZlbmllbnQuCgpTb21lIGFkZGl0aW9uYWwg
aW5mbyBhYm91dCB0aGUgc2l0dWF0aW9uIG9uIDQuMTQgdGhhdCBtYXkgb3IgbWF5IG5vdCBo
ZWxwOgoKMS4gVGhlIHJlc29sdXRpb24gaXMgbGltaXRlZCB3aXRoIFdheWxhbmQgYnV0IG5v
dCB3aXRoIFgxMQoKMi4gV2hlbiB0aGUgc3lzdGVtIGJvb3RzIHVwIHRoZSByZXNvbHV0aW9u
IGlzIHNxdWFyZSBhbmQgdGhlIGltYWdlIGlzCnNxdWlzaGVkIGhvcml6b250YWxseSB3aXRo
IG1hbnkgY29sdW1ucyBkcm9wcGVkLCBib3RoIGR1cmluZyB0aGUgYm9vdApwcm9jZXNzIGFu
ZCBhdCB0aGUgZ2RtIGxvZ2luIHNjcmVlbi4gSXQncyBub3QgdW50aWwgYWZ0ZXIgSSBsb2cg
d2l0aCBYMTEKdGhhdCB0aGUgcmVzb2x1dGlvbiBpcyBzZXQgY29ycmVjdGx5LgoKMy4gVGhl
IG91dHB1dCBvZiB4cmFuZHIgLS1wcm9wcyBpcyBiZWxvdy4KClRJQSBmb3IgYW55IGhlbHAu
CgotLU5laWwKClNjcmVlbiAwOiBtaW5pbXVtIDMyMCB4IDIwMCwgY3VycmVudCA2MTYwIHgg
MTA4MCwgbWF4aW11bSAxNjM4NCB4IDE2Mzg0CkRQLTEgY29ubmVjdGVkIHByaW1hcnkgMjU2
MHgxMDgwKzE5MjArMCAobm9ybWFsIGxlZnQgaW52ZXJ0ZWQgcmlnaHQgeApheGlzIHkgYXhp
cykgNzk4bW0geCAzMzRtbQrCoMKgwqAgX01VVFRFUl9QUkVTRU5UQVRJT05fT1VUUFVUOiAw
CsKgwqDCoCBFRElEOgrCoMKgwqAgwqDCoMKgIDAwZmZmZmZmZmZmZmZmMDAxZTZkZjk3NjVk
ZTgwNTAwCsKgwqDCoCDCoMKgwqAgMDkxYzAxMDM4MDUwMjI3OGVhY2E5NWE2NTU0ZWExMjYK
wqDCoMKgIMKgwqDCoCAwZjUwNTQyNTZiODA3MTQwODE4MDgxYzBhOWMwYjMwMArCoMKgwqAg
wqDCoMKgIGQxYzA4MTAwZDFjZmNkNDYwMGEwYTAzODFmNDAzMDIwCsKgwqDCoCDCoMKgwqAg
M2EwMDFlNGUzMTAwMDAxYTAwM2E4MDE4NzEzODJkNDAKwqDCoMKgIMKgwqDCoCA1ODJjNDUw
MDEzMmEyMTAwMDAxZTAwMDAwMGZkMDAzOArCoMKgwqAgwqDCoMKgIDRiMWU1YTE4MDAwYTIw
MjAyMDIwMjAyMDAwMDAwMGZjCsKgwqDCoCDCoMKgwqAgMDA0YzQ3MjA1NTRjNTQ1MjQxNTc0
OTQ0NDUwYTAxYjUKwqDCoMKgIMKgwqDCoCAwMjAzMWFmMTIzMDkwNzA3NDcxMDA0MDMwMTFm
MTMxMgrCoMKgwqAgwqDCoMKgIDgzMDEwMDAwNjUwMzBjMDAxMDAwOGMwYWQwOGEyMGUwCsKg
wqDCoCDCoMKgwqAgMmQxMDEwM2U5NjAwMWU0ZTMxMDAwMDE4Mjk1OTAwYTAKwqDCoMKgIMKg
wqDCoCBhMDM4Mjc0MDMwMjAzYTAwMWU0ZTMxMDAwMDFhMDAwMArCoMKgwqAgwqDCoMKgIDAw
MDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwCsKgwqDCoCDCoMKgwqAgMDAwMDAwMDAw
MDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAKwqDCoMKgIMKgwqDCoCAwMDAwMDAwMDAwZmYwMDM4
MzAzOTRlNTQ0YjQ2NDI0NArCoMKgwqAgwqDCoMKgIDMxMzYzNTBhMDAwMDAwMDAwMDAwMDAw
MDAwMDAwMGE0CsKgwqDCoCBkaXRoZXI6IG9mZgrCoMKgwqAgwqDCoMKgIHN1cHBvcnRlZDog
b2ZmLCBvbgrCoMKgwqAgYXVkaW86IGF1dG8KwqDCoMKgIMKgwqDCoCBzdXBwb3J0ZWQ6IG9m
Ziwgb24sIGF1dG8KwqDCoMKgIHNjYWxpbmcgbW9kZTogTm9uZQrCoMKgwqAgwqDCoMKgIHN1
cHBvcnRlZDogTm9uZSwgRnVsbCwgQ2VudGVyLCBGdWxsIGFzcGVjdArCoMKgwqAgdW5kZXJz
Y2FuIHZib3JkZXI6IDAKwqDCoMKgIMKgwqDCoCByYW5nZTogKDAsIDEyOCkKwqDCoMKgIHVu
ZGVyc2NhbiBoYm9yZGVyOiAwCsKgwqDCoCDCoMKgwqAgcmFuZ2U6ICgwLCAxMjgpCsKgwqDC
oCB1bmRlcnNjYW46IG9mZgrCoMKgwqAgwqDCoMKgIHN1cHBvcnRlZDogb2ZmLCBvbiwgYXV0
bwrCoMKgwqAgY29oZXJlbnQ6IDEKwqDCoMKgIMKgwqDCoCByYW5nZTogKDAsIDEpCsKgwqDC
oCBsaW5rLXN0YXR1czogR29vZArCoMKgwqAgwqDCoMKgIHN1cHBvcnRlZDogR29vZCwgQmFk
CsKgwqDCoCBDT05ORUNUT1JfSUQ6IDQ4CsKgwqDCoCDCoMKgwqAgc3VwcG9ydGVkOiA0OArC
oMKgwqAgbm9uLWRlc2t0b3A6IDAKwqDCoMKgIMKgwqDCoCBzdXBwb3J0ZWQ6IDAsIDEKwqDC
oCAyNTYweDEwODDCoMKgwqDCoCA1OS45OCArwqAgNzQuOTkqCsKgwqAgMTkyMHgxMDgwwqDC
oMKgwqAgNzQuOTnCoMKgwqAgNTkuOTbCoMKgwqAgNTAuMDDCoMKgwqAgNTkuOTnCoMKgwqAg
NTkuOTTCoMKgwqAgNTkuOTPCoArCoMKgIDE2ODB4MTA1MMKgwqDCoMKgIDU5Ljk1wqDCoMKg
IDU5Ljg4wqAKCltldGMuXQo=
--------------4C67A626F291EB74C8147B37
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html>
  <head>

    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <font face="Open Sans, Calibri, sans-serif">I have a 21:9 ultrawide
      monitor connected to an RX 570 with the amdgpu driver. I'm still
      using the 4.14 kernel since with later kernels I can't get the
      driver to allow use of the full resolution of 2560x1080 and I'm
      limited to regular HD, ie 1920x1080. The latest kernel I've tried
      is 5.4-rc2. My distro is NixOS unstable-small. I have two other
      monitors (16:9 and 16:10) connected to the same graphics card.<br>
      <br>
      Is there anything I can do to work around this or try to fix it? I
      had a look at the driver sources but couldn't find where the mode
      is set. I'm happy to try things if someone can point me in the
      right direction, even if it's just to gather better info for a bug
      report. Using such an old kernel is becoming really inconvenient.<br>
      <br>
      Some additional info about the situation on 4.14 that may or may
      not help:<br>
      <br>
      1. The resolution is limited with Wayland but not with X11<br>
      <br>
      2. When the system boots up the resolution is square and the image
      is squished horizontally with many columns dropped, both during
      the boot process and at the gdm login screen. It's not until after
      I log with X11 that the resolution is set correctly.<br>
      <br>
      3. The output of xrandr --props is below.<br>
      <br>
      TIA for any help.<br>
      <br>
      --Neil<br>
      <br>
      Screen 0: minimum 320 x 200, current 6160 x 1080, maximum 16384 x
      16384<br>
      DP-1 connected primary 2560x1080+1920+0 (normal left inverted
      right x axis y axis) 798mm x 334mm<br>
          _MUTTER_PRESENTATION_OUTPUT: 0 <br>
          EDID: <br>
              00ffffffffffff001e6df9765de80500<br>
              091c010380502278eaca95a6554ea126<br>
              0f5054256b807140818081c0a9c0b300<br>
              d1c08100d1cfcd4600a0a0381f403020<br>
              3a001e4e3100001a003a801871382d40<br>
              582c4500132a2100001e000000fd0038<br>
              4b1e5a18000a202020202020000000fc<br>
              004c4720554c545241574944450a01b5<br>
              02031af12309070747100403011f1312<br>
              8301000065030c0010008c0ad08a20e0<br>
              2d10103e96001e4e31000018295900a0<br>
              a038274030203a001e4e3100001a0000<br>
              00000000000000000000000000000000<br>
              00000000000000000000000000000000<br>
              0000000000ff003830394e544b464244<br>
              3136350a0000000000000000000000a4<br>
          dither: off <br>
              supported: off, on<br>
          audio: auto <br>
              supported: off, on, auto<br>
          scaling mode: None <br>
              supported: None, Full, Center, Full aspect<br>
          underscan vborder: 0 <br>
              range: (0, 128)<br>
          underscan hborder: 0 <br>
              range: (0, 128)<br>
          underscan: off <br>
              supported: off, on, auto<br>
          coherent: 1 <br>
              range: (0, 1)<br>
          link-status: Good <br>
              supported: Good, Bad<br>
          CONNECTOR_ID: 48 <br>
              supported: 48<br>
          non-desktop: 0 <br>
              supported: 0, 1<br>
         2560x1080     59.98 +  74.99* <br>
         1920x1080     74.99    59.96    50.00    59.99    59.94   
      59.93  <br>
         1680x1050     59.95    59.88  <br>
      <br>
      [etc.]<br>
    </font>
  </body>
</html>

--------------4C67A626F291EB74C8147B37--

--===============0990841692==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============0990841692==--
