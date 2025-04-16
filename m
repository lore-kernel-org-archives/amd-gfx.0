Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21B53C369BD
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Apr 2025 14:49:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B873710E27A;
	Wed, 16 Apr 2025 14:49:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="QhYS8z5s";
	dkim-atps=neutral
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com
 [209.85.216.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4A55610E27A
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Apr 2025 14:49:14 +0000 (UTC)
Received: by mail-pj1-f52.google.com with SMTP id
 98e67ed59e1d1-301317939a0so1146392a91.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Apr 2025 07:49:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744814954; x=1745419754; darn=lists.freedesktop.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=rnFAmlWkTV0t0Z7telQmxot+UIwLm82aHdkqDN3p2V8=;
 b=QhYS8z5shwEV8a4eZucL1nE24qbM8DmuHnopKYyPPeUw4R6qfouVkVme0pX0qQowae
 kTpSpvQu+lQMiK0FqYF3/eUHszI+APo4QTLb7kt2ATby7ygqt5c3rLqN/s9Gj/hlcq47
 v37OSyPQ2rv6OkrjiaTKDkZAxsEKcQ4VrLQbn4Z1ickAq+SlzWRiOx4wfkLyzne/6Hfh
 a4qfE/V5o+wAmoBeUkygsm4Dq8hXXCzJwQZ2QcgGw/b1AjI9KTHv2EKxykxA9P3Oopjc
 UhxudxOvpQ4rZyD+WZs2P4z8PaTpSV1sUUKuLhBxAnLeb/o0eMrz7aKXCBOFZCbNPl67
 DLKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744814954; x=1745419754;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rnFAmlWkTV0t0Z7telQmxot+UIwLm82aHdkqDN3p2V8=;
 b=OZvZY4OQyvU11xNxv46RXKmAqclrSrbY//Clj5Winmcz+7jxXvJKrHlWl3IBtzZ22c
 iDYQaXnrf2aPZ9LEQbyPFTgo+kNn+J6ro+0cnY04VA/Hl4uXfbx2fT18iQA+2oOv8zTD
 01faW0ZJNtK6oDtR7ZBSPf/G+b8uhn4g5A2XCOuA6ZYhiCzKSOciQ0fiiAasQm4rOJWo
 kiB4tNjLy4Ovq2ZwN1mIhMGEO/ftQZmjbcF1TSN+MvhK9rG81rzKwAxFj2qEKzQehTJ9
 lheoNdzBFVzUxucrrcnGd1MsLW36+exmZZ/GH8shD+5w3ki5Yf6tEMijDYVKg7Nyo7CC
 wrrg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXlPPxKnYDGAyH94xEQhp5+UjKbFqF0blqDyXE50E5ytLGm9GNaPeKMQLIxBNeV1kg3u1v33N1m@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx5pHNkPVrmQBanqGiwePYY3aqxsf5IzV7nSdZrAlau4mYp6nPI
 DknIaOdwzwF1al2faYwlfO2c8iJhJ/nm2HM2ji+pOoY64K2zxaViFOw5N9M5U1mzIpgk0ijn3JR
 8D/TTiaqMF9IjLDFMl71BUSfZDmg=
X-Gm-Gg: ASbGncu468g1Lx61ZMyE3EqXz6gheCjHiG+w6hhRdmqc/9b/9tpxjhvcRykRxQwjeXz
 QAiaWbDZZpLu6w/4VDT6g7vYv/r8XjWuThP9lGyh33mwsK+ruTcpidDTHLey0oChLXFAk4eUhH1
 XO7Ai1U4UrKRkfFIGyAASKEA==
X-Google-Smtp-Source: AGHT+IGotM9RtmOHQShgZcxGS159J/JGYg0HqSEnE+xfwtQamzkhlTX1NYnkHtDUj6JFeoLU2oo0zIBfc/gLnDSTEYQ=
X-Received: by 2002:a17:90b:2249:b0:2ff:7b15:8138 with SMTP id
 98e67ed59e1d1-3086d476f28mr23688a91.7.1744814953601; Wed, 16 Apr 2025
 07:49:13 -0700 (PDT)
MIME-Version: 1.0
References: <D97FB92117J2.PXTNFKCIRWAS@linaro.org>
 <SI2PR06MB5041FB15F8DBB44916FB6430F1BD2@SI2PR06MB5041.apcprd06.prod.outlook.com>
 <D980Y4WDV662.L4S7QAU72GN2@linaro.org>
In-Reply-To: <D980Y4WDV662.L4S7QAU72GN2@linaro.org>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 16 Apr 2025 10:49:01 -0400
X-Gm-Features: ATxdqUFVXMWWR2TxEeaaPk1Z6N8v3_ogOGrjeVPBDyhXOT8NnzeXf9zY-QQgQns
Message-ID: <CADnq5_NT0syV8wB=MZZRDONsTNSYwNXhGhNg9LOFmn=MJP7d9Q@mail.gmail.com>
Subject: =?UTF-8?B?UmU6IOWbnuWkjTogW1JFR1JFU1NJT05dIGFtZGdwdTogYXN5bmMgc3lzdGVtIGVycm9yIA==?=
 =?UTF-8?B?ZXhjZXB0aW9uIGZyb20gaGRwX3Y1XzBfZmx1c2hfaGRwKCk=?=
To: Alexey Klimov <alexey.klimov@linaro.org>
Cc: Fugang Duan <fugang.duan@cixtech.com>, 
 "alexander.deucher@amd.com" <alexander.deucher@amd.com>,
 "frank.min@amd.com" <frank.min@amd.com>, 
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, 
 "stable@vger.kernel.org" <stable@vger.kernel.org>,
 "david.belanger@amd.com" <david.belanger@amd.com>, 
 "christian.koenig@amd.com" <christian.koenig@amd.com>,
 Peter Chen <peter.chen@cixtech.com>, 
 cix-kernel-upstream <cix-kernel-upstream@cixtech.com>, 
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: multipart/mixed; boundary="0000000000008239040632e66333"
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

--0000000000008239040632e66333
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 16, 2025 at 9:48=E2=80=AFAM Alexey Klimov <alexey.klimov@linaro=
.org> wrote:
>
> On Wed Apr 16, 2025 at 4:12 AM BST, Fugang Duan wrote:
> > =E5=8F=91=E4=BB=B6=E4=BA=BA: Alexey Klimov <alexey.klimov@linaro.org> =
=E5=8F=91=E9=80=81=E6=97=B6=E9=97=B4: 2025=E5=B9=B44=E6=9C=8816=E6=97=A5 2:=
28
> >>#regzbot introduced: v6.12..v6.13
>
> [..]
>
> >>The only change related to hdp_v5_0_flush_hdp() was
> >>cf424020e040 drm/amdgpu/hdp5.0: do a posting read when flushing HDP
> >>
> >>Reverting that commit ^^ did help and resolved that problem. Before sen=
ding
> >>revert as-is I was interested to know if there supposed to be a proper =
fix for
> >>this or maybe someone is interested to debug this or have any suggestio=
ns.
> >>
> > Can you revert the change and try again https://gitlab.com/linux-kernel=
/linux/-/commit/cf424020e040be35df05b682b546b255e74a420f
>
> Please read my email in the first place.
> Let me quote just in case:
>
> >The only change related to hdp_v5_0_flush_hdp() was
> >cf424020e040 drm/amdgpu/hdp5.0: do a posting read when flushing HDP
>
> >Reverting that commit ^^ did help and resolved that problem.

We can't really revert the change as that will lead to coherency
problems.  What is the page size on your system?  Does the attached
patch fix it?

Alex

>
> Thanks,
> Alexey
>

--0000000000008239040632e66333
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0001-drm-amdgpu-don-t-remap-HDP-registers-if-page-size-is.patch"
Content-Disposition: attachment; 
	filename="0001-drm-amdgpu-don-t-remap-HDP-registers-if-page-size-is.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_m9k1rck10>
X-Attachment-Id: f_m9k1rck10

RnJvbSA1YzE3MzY3NWNlNDk2YjI4OWIwYjBlN2Q5N2U1N2NiYjBjNWE1M2ZlIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5j
b20+CkRhdGU6IFdlZCwgMTYgQXByIDIwMjUgMTA6MzA6MjAgLTA0MDAKU3ViamVjdDogW1BBVENI
XSBkcm0vYW1kZ3B1OiBkb24ndCByZW1hcCBIRFAgcmVnaXN0ZXJzIGlmIHBhZ2Ugc2l6ZSBpcyA+
IDRLCgpXZSByZW1hcCB0aGUgSERQIHJlZ2lzdGVycyB0byBhbiBvcGVuIHBhcnQgb2YgdGhlIE1N
SU8KYXBlcnR1cmUgaWYgcGFnZSBzaXplIGlzIDwgNEssIGJ1dCBpZiBpdCdzID4gNGssIHdlIHJl
bWFwCnRoZSBIRFAgcmVnaXN0ZXJzIGJhY2sgdG8gdGhlbXNlbHZlcy4gIFRoaXMgZG9lc24ndCBz
ZWVtCnRvIHdvcmsgcHJvcGVybHksIGF0IGxlYXN0IG9uIEFSTSBzeXN0ZW1zLCBzbyBqdXN0IHNr
aXAKdGhlIEhEUCByZW1hcCBhbHRvZ2V0aGVyIGlmIHBhZ2Ugc2l6ZSBpcyA+IDRLLgoKRml4ZXM6
IGM5YjhkY2FiYjUyYSAoImRybS9hbWRncHUvaGRwNC4wOiBkbyBhIHBvc3RpbmcgcmVhZCB3aGVu
IGZsdXNoaW5nIEhEUCIpCkZpeGVzOiBjZjQyNDAyMGUwNDAgKCJkcm0vYW1kZ3B1L2hkcDUuMDog
ZG8gYSBwb3N0aW5nIHJlYWQgd2hlbiBmbHVzaGluZyBIRFAiKQpGaXhlczogZjc1NmRiYWMxY2Ux
ICgiZHJtL2FtZGdwdS9oZHA1LjI6IGRvIGEgcG9zdGluZyByZWFkIHdoZW4gZmx1c2hpbmcgSERQ
IikKRml4ZXM6IGFiZTFjYmFlYzZjZiAoImRybS9hbWRncHUvaGRwNi4wOiBkbyBhIHBvc3Rpbmcg
cmVhZCB3aGVuIGZsdXNoaW5nIEhEUCIpCkZpeGVzOiA2ODkyNzUxNDBjYjggKCJkcm0vYW1kZ3B1
L2hkcDcuMDogZG8gYSBwb3N0aW5nIHJlYWQgd2hlbiBmbHVzaGluZyBIRFAiKQpTaWduZWQtb2Zm
LWJ5OiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+Ci0tLQogZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvbnYuYyAgICB8IDMgKystCiBkcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9zb2MxNS5jIHwgMyArKy0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3NvYzIx
LmMgfCAzICsrLQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvc29jMjQuYyB8IDIgKy0KIDQg
ZmlsZXMgY2hhbmdlZCwgNyBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdp
dCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L252LmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9udi5jCmluZGV4IDUwZTc3ZDliMzBhZmEuLjg5MGY4NDZiODA2MDcgMTAwNjQ0Ci0t
LSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L252LmMKKysrIGIvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvbnYuYwpAQCAtMTAwMiw3ICsxMDAyLDggQEAgc3RhdGljIGludCBudl9jb21t
b25faHdfaW5pdChzdHJ1Y3QgYW1kZ3B1X2lwX2Jsb2NrICppcF9ibG9jaykKIAkgKiBmb3IgdGhl
IHB1cnBvc2Ugb2YgZXhwb3NlIHRob3NlIHJlZ2lzdGVycwogCSAqIHRvIHByb2Nlc3Mgc3BhY2UK
IAkgKi8KLQlpZiAoYWRldi0+bmJpby5mdW5jcy0+cmVtYXBfaGRwX3JlZ2lzdGVycyAmJiAhYW1k
Z3B1X3NyaW92X3ZmKGFkZXYpKQorCWlmIChhZGV2LT5uYmlvLmZ1bmNzLT5yZW1hcF9oZHBfcmVn
aXN0ZXJzICYmICFhbWRncHVfc3Jpb3ZfdmYoYWRldikgJiYKKwkgICAgKFBBR0VfU0laRSA8PSA0
MDk2KSkKIAkJYWRldi0+bmJpby5mdW5jcy0+cmVtYXBfaGRwX3JlZ2lzdGVycyhhZGV2KTsKIAkv
KiBlbmFibGUgdGhlIGRvb3JiZWxsIGFwZXJ0dXJlICovCiAJYWRldi0+bmJpby5mdW5jcy0+ZW5h
YmxlX2Rvb3JiZWxsX2FwZXJ0dXJlKGFkZXYsIHRydWUpOwpkaWZmIC0tZ2l0IGEvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvc29jMTUuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3Nv
YzE1LmMKaW5kZXggYzQ1N2JlM2EzYzU2Zi4uZWYyNDIwMWZmYWQ1MiAxMDA2NDQKLS0tIGEvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvc29jMTUuYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9zb2MxNS5jCkBAIC0xMjk3LDcgKzEyOTcsOCBAQCBzdGF0aWMgaW50IHNvYzE1X2Nv
bW1vbl9od19pbml0KHN0cnVjdCBhbWRncHVfaXBfYmxvY2sgKmlwX2Jsb2NrKQogCSAqIGZvciB0
aGUgcHVycG9zZSBvZiBleHBvc2UgdGhvc2UgcmVnaXN0ZXJzCiAJICogdG8gcHJvY2VzcyBzcGFj
ZQogCSAqLwotCWlmIChhZGV2LT5uYmlvLmZ1bmNzLT5yZW1hcF9oZHBfcmVnaXN0ZXJzICYmICFh
bWRncHVfc3Jpb3ZfdmYoYWRldikpCisJaWYgKGFkZXYtPm5iaW8uZnVuY3MtPnJlbWFwX2hkcF9y
ZWdpc3RlcnMgJiYgIWFtZGdwdV9zcmlvdl92ZihhZGV2KSAmJgorCSAgICAoUEFHRV9TSVpFIDw9
IDQwOTYpKQogCQlhZGV2LT5uYmlvLmZ1bmNzLT5yZW1hcF9oZHBfcmVnaXN0ZXJzKGFkZXYpOwog
CiAJLyogZW5hYmxlIHRoZSBkb29yYmVsbCBhcGVydHVyZSAqLwpkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvc29jMjEuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L3NvYzIxLmMKaW5kZXggYWQzNmM5NjQ3OGE4Mi4uMjNkNDExNzI4NzcwMiAxMDA2NDQKLS0tIGEv
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvc29jMjEuYworKysgYi9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9zb2MyMS5jCkBAIC04NzcsNyArODc3LDggQEAgc3RhdGljIGludCBzb2MyMV9j
b21tb25faHdfaW5pdChzdHJ1Y3QgYW1kZ3B1X2lwX2Jsb2NrICppcF9ibG9jaykKIAkgKiBmb3Ig
dGhlIHB1cnBvc2Ugb2YgZXhwb3NlIHRob3NlIHJlZ2lzdGVycwogCSAqIHRvIHByb2Nlc3Mgc3Bh
Y2UKIAkgKi8KLQlpZiAoYWRldi0+bmJpby5mdW5jcy0+cmVtYXBfaGRwX3JlZ2lzdGVycyAmJiAh
YW1kZ3B1X3NyaW92X3ZmKGFkZXYpKQorCWlmIChhZGV2LT5uYmlvLmZ1bmNzLT5yZW1hcF9oZHBf
cmVnaXN0ZXJzICYmICFhbWRncHVfc3Jpb3ZfdmYoYWRldikgJiYKKwkgICAgKFBBR0VfU0laRSA8
PSA0MDk2KSkKIAkJYWRldi0+bmJpby5mdW5jcy0+cmVtYXBfaGRwX3JlZ2lzdGVycyhhZGV2KTsK
IAkvKiBlbmFibGUgdGhlIGRvb3JiZWxsIGFwZXJ0dXJlICovCiAJYWRldi0+bmJpby5mdW5jcy0+
ZW5hYmxlX2Rvb3JiZWxsX2FwZXJ0dXJlKGFkZXYsIHRydWUpOwpkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvc29jMjQuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L3NvYzI0LmMKaW5kZXggOTcyYjQ0OWFiODlmYS4uNzFiYTFmYThhODg5OSAxMDA2NDQKLS0tIGEv
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvc29jMjQuYworKysgYi9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9zb2MyNC5jCkBAIC00ODYsNyArNDg2LDcgQEAgc3RhdGljIGludCBzb2MyNF9j
b21tb25faHdfaW5pdChzdHJ1Y3QgYW1kZ3B1X2lwX2Jsb2NrICppcF9ibG9jaykKIAkgKiBmb3Ig
dGhlIHB1cnBvc2Ugb2YgZXhwb3NlIHRob3NlIHJlZ2lzdGVycwogCSAqIHRvIHByb2Nlc3Mgc3Bh
Y2UKIAkgKi8KLQlpZiAoYWRldi0+bmJpby5mdW5jcy0+cmVtYXBfaGRwX3JlZ2lzdGVycykKKwlp
ZiAoYWRldi0+bmJpby5mdW5jcy0+cmVtYXBfaGRwX3JlZ2lzdGVycyAmJiAoUEFHRV9TSVpFIDw9
IDQwOTYpKQogCQlhZGV2LT5uYmlvLmZ1bmNzLT5yZW1hcF9oZHBfcmVnaXN0ZXJzKGFkZXYpOwog
CiAJaWYgKGFkZXYtPmRmLmZ1bmNzLT5od19pbml0KQotLSAKMi40OS4wCgo=
--0000000000008239040632e66333--
