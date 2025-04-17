Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F898C369B2
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Apr 2025 13:08:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CB44010EB01;
	Thu, 17 Apr 2025 13:08:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ihOBv7vj";
	dkim-atps=neutral
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com
 [209.85.215.176])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 516A310EB00
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Apr 2025 13:08:36 +0000 (UTC)
Received: by mail-pg1-f176.google.com with SMTP id
 41be03b00d2f7-af51b57ea41so91511a12.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Apr 2025 06:08:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744895316; x=1745500116; darn=lists.freedesktop.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=SkUv4LhWhAj3EBL1DmLzQI3altPauQ76PUZeZ4EyP7A=;
 b=ihOBv7vjs20OooCpPnMEOYs4B9s+ZZ3U+yir3WP6VdSv3KszDMHN5SwwR87SjtD1z+
 9Btf56gjGVMJfZBhaNKRG6QBfkfgotysKQTfYTXzjHvEblKEZ7DquHlqs4fNooqI9Abx
 ZMztog7y40mpPrFdE+UKohCcXoD2mK3mxnGbxF2+Vr3j39kEBJFGbZIUggr748DETaxT
 nI++LMEXRpx431kLZO74pOTBDDU+swgXAo7yeicW/bKP7l5niO9YOwuwsQJxNhFbiKkQ
 cIQZpAO5wQP4kRK1lyu+bA/MhNMHEt6IB3JqSsxGX6R3bBm0SJLU2NIyrOAlzxIrnaOp
 rgTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744895316; x=1745500116;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=SkUv4LhWhAj3EBL1DmLzQI3altPauQ76PUZeZ4EyP7A=;
 b=aSBpYZuQwyPEO1SXsFJXZWvQRXhzGGHs6+Kvhx21J7aA/vwxvQas7U/7q016Js6Frn
 k25sQmkl/uWcd0tthbqWeCVO6Hofwr2mMHu5tONRLEUTRTX97ePtvzBcLg44mesDgwyA
 3XMaepMVRuUQyybhDNnY6QtX3Iym0tGmq3HP5Ju8ZSjRH/d4wp8rDe2/DFhnQRQNjVyu
 B7rpQaWmCSL5/xk+vN05OzqAMeJd39B60TQJ5LzIVajSS0XFEb2cAc5axaR76G+2FBRL
 YIGKHrj19uKd06RhnROLWxD9ucuZ7zwqc/jD7tjhMcBLqsqauQvia6F4T6OjiQ0I3prx
 buNQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV9W0vfM1ysz5w9Z/tFXfrlKR4claxLFU5WHnUHwD8VTsyRx+PQjaG3MqDFcfK7/iRwohHP0sJd@lists.freedesktop.org
X-Gm-Message-State: AOJu0Ywz8HpzOSxmJSYRVXI2yw+VHo0TFFWDbDDDh9/WNhjCELUzhQ3V
 +SLlsHucaxSOw1J+bEd3hp+fsmgeDAHu9GNNw5PrTUujFSIxTSYsX/ewmTOJruOurnZ95pFYZj6
 OnSLf7G+7ZDR7pf/lGIcLvtZ5fek=
X-Gm-Gg: ASbGncvl4sjN/LuFqvC3SmEp95lkHsSzM3ZkSuME9lrHYyAyhVbJEphIQ8PNnbnVs5N
 fwIZPBAGs8XCz1U/aZZLI3x2LYAO6fZZQ0Ff7ikQ3Df0cHAg9c5XlnRJYRQYhTo93OAXa3hXFIN
 E910h6B8l5xW3rpsXuGCRi0g==
X-Google-Smtp-Source: AGHT+IFPjM6s/cQk7weSuDS2PDSyXdWhMHPS3wEQpy/EA+M9j2XNxG5BPIX/cOz3JCOOEVMc/pWXY57Oo7xhHqOj410=
X-Received: by 2002:a17:90b:3ece:b0:2ff:5540:bb48 with SMTP id
 98e67ed59e1d1-3086d477001mr2089755a91.8.1744895315724; Thu, 17 Apr 2025
 06:08:35 -0700 (PDT)
MIME-Version: 1.0
References: <D97FB92117J2.PXTNFKCIRWAS@linaro.org>
 <SI2PR06MB5041FB15F8DBB44916FB6430F1BD2@SI2PR06MB5041.apcprd06.prod.outlook.com>
 <D980Y4WDV662.L4S7QAU72GN2@linaro.org>
 <CADnq5_NT0syV8wB=MZZRDONsTNSYwNXhGhNg9LOFmn=MJP7d9Q@mail.gmail.com>
 <SI2PR06MB504138A5BEA1E1B3772E8527F1BC2@SI2PR06MB5041.apcprd06.prod.outlook.com>
In-Reply-To: <SI2PR06MB504138A5BEA1E1B3772E8527F1BC2@SI2PR06MB5041.apcprd06.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 17 Apr 2025 09:08:23 -0400
X-Gm-Features: ATxdqUF06OTkz7oFVtYlPUWRvkXMlpL0llTOQUAUfZlXtGvAJj0flY_LbK6lg3o
Message-ID: <CADnq5_M=YiMVvMpGaFhn2T3jRWGY2FrsUwCVPG6HupmTzZCYug@mail.gmail.com>
Subject: =?UTF-8?B?UmU6IOWbnuWkjTogW1JFR1JFU1NJT05dIGFtZGdwdTogYXN5bmMgc3lzdGVtIGVycm9yIA==?=
 =?UTF-8?B?ZXhjZXB0aW9uIGZyb20gaGRwX3Y1XzBfZmx1c2hfaGRwKCk=?=
To: Fugang Duan <fugang.duan@cixtech.com>
Cc: Alexey Klimov <alexey.klimov@linaro.org>, 
 "alexander.deucher@amd.com" <alexander.deucher@amd.com>,
 "frank.min@amd.com" <frank.min@amd.com>, 
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, 
 "stable@vger.kernel.org" <stable@vger.kernel.org>,
 "david.belanger@amd.com" <david.belanger@amd.com>, 
 "christian.koenig@amd.com" <christian.koenig@amd.com>,
 Peter Chen <peter.chen@cixtech.com>, 
 cix-kernel-upstream <cix-kernel-upstream@cixtech.com>, 
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: multipart/mixed; boundary="00000000000076eb0a0632f919c5"
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

--00000000000076eb0a0632f919c5
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 16, 2025 at 8:43=E2=80=AFPM Fugang Duan <fugang.duan@cixtech.co=
m> wrote:
>
> =E5=8F=91=E4=BB=B6=E4=BA=BA: Alex Deucher <alexdeucher@gmail.com> =E5=8F=
=91=E9=80=81=E6=97=B6=E9=97=B4: 2025=E5=B9=B44=E6=9C=8816=E6=97=A5 22:49
> >=E6=94=B6=E4=BB=B6=E4=BA=BA: Alexey Klimov <alexey.klimov@linaro.org>
> >On Wed, Apr 16, 2025 at 9:48=E2=80=AFAM Alexey Klimov <alexey.klimov@lin=
aro.org> wrote:
> >>
> >> On Wed Apr 16, 2025 at 4:12 AM BST, Fugang Duan wrote:
> >> > =E5=8F=91=E4=BB=B6=E4=BA=BA: Alexey Klimov <alexey.klimov@linaro.org=
> =E5=8F=91=E9=80=81=E6=97=B6=E9=97=B4: 2025=E5=B9=B44=E6=9C=8816
> >=E6=97=A5 2:28
> >> >>#regzbot introduced: v6.12..v6.13
> >>
> >> [..]
> >>
> >> >>The only change related to hdp_v5_0_flush_hdp() was
> >> >>cf424020e040 drm/amdgpu/hdp5.0: do a posting read when flushing HDP
> >> >>
> >> >>Reverting that commit ^^ did help and resolved that problem. Before
> >> >>sending revert as-is I was interested to know if there supposed to
> >> >>be a proper fix for this or maybe someone is interested to debug thi=
s or
> >have any suggestions.
> >> >>
> >> > Can you revert the change and try again
> >> > https://gitlab.com/linux-kernel/linux/-/commit/cf424020e040be35df05b
> >> > 682b546b255e74a420f
> >>
> >> Please read my email in the first place.
> >> Let me quote just in case:
> >>
> >> >The only change related to hdp_v5_0_flush_hdp() was
> >> >cf424020e040 drm/amdgpu/hdp5.0: do a posting read when flushing HDP
> >>
> >> >Reverting that commit ^^ did help and resolved that problem.
> >
> >We can't really revert the change as that will lead to coherency problem=
s.  What
> >is the page size on your system?  Does the attached patch fix it?
> >
> >Alex
> >
> 4K page size.  We can try the fix if we got the environment.

OK.  that patch won't change anything then.  Can you try this patch instead=
?

Alex

>
> Fugang
>
>
>
> This email (including its attachments) is intended only for the person or=
 entity to which it is addressed and may contain information that is privil=
eged, confidential or otherwise protected from disclosure. Unauthorized use=
, dissemination, distribution or copying of this email or the information h=
erein or taking any action in reliance on the contents of this email or the=
 information herein, by anyone other than the intended recipient, or an emp=
loyee or agent responsible for delivering the message to the intended recip=
ient, is strictly prohibited. If you are not the intended recipient, please=
 do not read, copy, use or disclose any part of this e-mail to others. Plea=
se notify the sender immediately and permanently delete this e-mail and any=
 attachments if you received it in error. Internet communications cannot be=
 guaranteed to be timely, secure, error-free or virus-free. The sender does=
 not accept liability for any errors or omissions.

--00000000000076eb0a0632f919c5
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0001-drm-amdgpu-don-t-remap-the-HDP-registers-on-ARM.patch"
Content-Disposition: attachment; 
	filename="0001-drm-amdgpu-don-t-remap-the-HDP-registers-on-ARM.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_m9ldlyuc0>
X-Attachment-Id: f_m9ldlyuc0

RnJvbSBiMjlkMDVmZWZhNWRhMjg3NTE0N2NmY2U0M2Y1N2YxNTFkNjExY2ExIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5j
b20+CkRhdGU6IFRodSwgMTcgQXByIDIwMjUgMDk6MDQ6MjEgLTA0MDAKU3ViamVjdDogW1BBVENI
XSBkcm0vYW1kZ3B1OiBkb24ndCByZW1hcCB0aGUgSERQIHJlZ2lzdGVycyBvbiBBUk0KCldlIHJl
bWFwIHRoZSBIRFAgcmVnaXN0ZXJzIHRvIGFuIG9wZW4gcGFydCBvZiB0aGUgTU1JTwphcGVydHVy
ZS4gIFRoaXMgZG9lc24ndCBzZWVtIHRvIHdvcmsgcHJvcGVybHkgb24gYXQgbGVhc3QKb25lIEFS
TSBzeXN0ZW0sIHNvIGp1c3Qgc2tpcCB0aGUgSERQIHJlbWFwIGFsdG9nZXRoZXIgb24gQVJNLgoK
Rml4ZXM6IGM5YjhkY2FiYjUyYSAoImRybS9hbWRncHUvaGRwNC4wOiBkbyBhIHBvc3RpbmcgcmVh
ZCB3aGVuIGZsdXNoaW5nIEhEUCIpCkZpeGVzOiBjZjQyNDAyMGUwNDAgKCJkcm0vYW1kZ3B1L2hk
cDUuMDogZG8gYSBwb3N0aW5nIHJlYWQgd2hlbiBmbHVzaGluZyBIRFAiKQpGaXhlczogZjc1NmRi
YWMxY2UxICgiZHJtL2FtZGdwdS9oZHA1LjI6IGRvIGEgcG9zdGluZyByZWFkIHdoZW4gZmx1c2hp
bmcgSERQIikKRml4ZXM6IGFiZTFjYmFlYzZjZiAoImRybS9hbWRncHUvaGRwNi4wOiBkbyBhIHBv
c3RpbmcgcmVhZCB3aGVuIGZsdXNoaW5nIEhEUCIpCkZpeGVzOiA2ODkyNzUxNDBjYjggKCJkcm0v
YW1kZ3B1L2hkcDcuMDogZG8gYSBwb3N0aW5nIHJlYWQgd2hlbiBmbHVzaGluZyBIRFAiKQpTaWdu
ZWQtb2ZmLWJ5OiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+Ci0tLQog
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvbnYuYyAgICB8IDIgKysKIGRyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L3NvYzE1LmMgfCAyICsrCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9z
b2MyMS5jIHwgMiArKwogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvc29jMjQuYyB8IDMgKyst
CiA0IGZpbGVzIGNoYW5nZWQsIDggaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAt
LWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L252LmMgYi9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9udi5jCmluZGV4IDUwZTc3ZDliMzBhZmEuLmYwOGYzMGZlMjBhY2EgMTAwNjQ0
Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L252LmMKKysrIGIvZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvbnYuYwpAQCAtMTAwMiw4ICsxMDAyLDEwIEBAIHN0YXRpYyBpbnQgbnZf
Y29tbW9uX2h3X2luaXQoc3RydWN0IGFtZGdwdV9pcF9ibG9jayAqaXBfYmxvY2spCiAJICogZm9y
IHRoZSBwdXJwb3NlIG9mIGV4cG9zZSB0aG9zZSByZWdpc3RlcnMKIAkgKiB0byBwcm9jZXNzIHNw
YWNlCiAJICovCisjaWYgIWRlZmluZWQoQ09ORklHX0FSTSkgJiYgIWRlZmluZWQoQ09ORklHX0FS
TTY0KQogCWlmIChhZGV2LT5uYmlvLmZ1bmNzLT5yZW1hcF9oZHBfcmVnaXN0ZXJzICYmICFhbWRn
cHVfc3Jpb3ZfdmYoYWRldikpCiAJCWFkZXYtPm5iaW8uZnVuY3MtPnJlbWFwX2hkcF9yZWdpc3Rl
cnMoYWRldik7CisjZW5kaWYKIAkvKiBlbmFibGUgdGhlIGRvb3JiZWxsIGFwZXJ0dXJlICovCiAJ
YWRldi0+bmJpby5mdW5jcy0+ZW5hYmxlX2Rvb3JiZWxsX2FwZXJ0dXJlKGFkZXYsIHRydWUpOwog
CmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9zb2MxNS5jIGIvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvc29jMTUuYwppbmRleCBjNDU3YmUzYTNjNTZmLi45YTRlYmFk
Nzc0Njg2IDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9zb2MxNS5jCisr
KyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3NvYzE1LmMKQEAgLTEyOTcsOCArMTI5Nywx
MCBAQCBzdGF0aWMgaW50IHNvYzE1X2NvbW1vbl9od19pbml0KHN0cnVjdCBhbWRncHVfaXBfYmxv
Y2sgKmlwX2Jsb2NrKQogCSAqIGZvciB0aGUgcHVycG9zZSBvZiBleHBvc2UgdGhvc2UgcmVnaXN0
ZXJzCiAJICogdG8gcHJvY2VzcyBzcGFjZQogCSAqLworI2lmICFkZWZpbmVkKENPTkZJR19BUk0p
ICYmICFkZWZpbmVkKENPTkZJR19BUk02NCkKIAlpZiAoYWRldi0+bmJpby5mdW5jcy0+cmVtYXBf
aGRwX3JlZ2lzdGVycyAmJiAhYW1kZ3B1X3NyaW92X3ZmKGFkZXYpKQogCQlhZGV2LT5uYmlvLmZ1
bmNzLT5yZW1hcF9oZHBfcmVnaXN0ZXJzKGFkZXYpOworI2VuZGlmCiAKIAkvKiBlbmFibGUgdGhl
IGRvb3JiZWxsIGFwZXJ0dXJlICovCiAJYWRldi0+bmJpby5mdW5jcy0+ZW5hYmxlX2Rvb3JiZWxs
X2FwZXJ0dXJlKGFkZXYsIHRydWUpOwpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvc29jMjEuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3NvYzIxLmMKaW5kZXgg
YWQzNmM5NjQ3OGE4Mi4uOWRhZmE0NGM4ZTlmMyAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvc29jMjEuYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9zb2My
MS5jCkBAIC04NzcsOCArODc3LDEwIEBAIHN0YXRpYyBpbnQgc29jMjFfY29tbW9uX2h3X2luaXQo
c3RydWN0IGFtZGdwdV9pcF9ibG9jayAqaXBfYmxvY2spCiAJICogZm9yIHRoZSBwdXJwb3NlIG9m
IGV4cG9zZSB0aG9zZSByZWdpc3RlcnMKIAkgKiB0byBwcm9jZXNzIHNwYWNlCiAJICovCisjaWYg
IWRlZmluZWQoQ09ORklHX0FSTSkgJiYgIWRlZmluZWQoQ09ORklHX0FSTTY0KQogCWlmIChhZGV2
LT5uYmlvLmZ1bmNzLT5yZW1hcF9oZHBfcmVnaXN0ZXJzICYmICFhbWRncHVfc3Jpb3ZfdmYoYWRl
dikpCiAJCWFkZXYtPm5iaW8uZnVuY3MtPnJlbWFwX2hkcF9yZWdpc3RlcnMoYWRldik7CisjZW5k
aWYKIAkvKiBlbmFibGUgdGhlIGRvb3JiZWxsIGFwZXJ0dXJlICovCiAJYWRldi0+bmJpby5mdW5j
cy0+ZW5hYmxlX2Rvb3JiZWxsX2FwZXJ0dXJlKGFkZXYsIHRydWUpOwogCmRpZmYgLS1naXQgYS9k
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9zb2MyNC5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvc29jMjQuYwppbmRleCA5NzJiNDQ5YWI4OWZhLi4wNDMwYWNmOWI1YzY5IDEwMDY0NAot
LS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9zb2MyNC5jCisrKyBiL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L3NvYzI0LmMKQEAgLTQ4Niw5ICs0ODYsMTAgQEAgc3RhdGljIGludCBz
b2MyNF9jb21tb25faHdfaW5pdChzdHJ1Y3QgYW1kZ3B1X2lwX2Jsb2NrICppcF9ibG9jaykKIAkg
KiBmb3IgdGhlIHB1cnBvc2Ugb2YgZXhwb3NlIHRob3NlIHJlZ2lzdGVycwogCSAqIHRvIHByb2Nl
c3Mgc3BhY2UKIAkgKi8KKyNpZiAhZGVmaW5lZChDT05GSUdfQVJNKSAmJiAhZGVmaW5lZChDT05G
SUdfQVJNNjQpCiAJaWYgKGFkZXYtPm5iaW8uZnVuY3MtPnJlbWFwX2hkcF9yZWdpc3RlcnMpCiAJ
CWFkZXYtPm5iaW8uZnVuY3MtPnJlbWFwX2hkcF9yZWdpc3RlcnMoYWRldik7Ci0KKyNlbmRpZgog
CWlmIChhZGV2LT5kZi5mdW5jcy0+aHdfaW5pdCkKIAkJYWRldi0+ZGYuZnVuY3MtPmh3X2luaXQo
YWRldik7CiAKLS0gCjIuNDkuMAoK
--00000000000076eb0a0632f919c5--
