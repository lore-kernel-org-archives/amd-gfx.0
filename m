Return-Path: <SRS0=3j8t=LP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A7B4C49EA3
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Jun 2021 07:09:14 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3DD86611BD
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Jun 2021 07:09:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DD86611BD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=vivo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8C0B489D99;
	Mon, 21 Jun 2021 07:09:13 +0000 (UTC)
Received: from mail-m176233.qiye.163.com (mail-m176233.qiye.163.com
 [59.111.176.233])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CB10A89CE3;
 Mon, 21 Jun 2021 01:34:18 +0000 (UTC)
DKIM-Signature: a=rsa-sha256;
 b=O7JOUViPH58toSHBRUGmwW0M9jOOSyOZKrenBo1/mSvbKs05dsH2f0iGZwc8+QcDUzqvJ+PdVxPi4mRct8KDwSWRbQBisHX17llaxhD4opEFJidhYvovbV5EzFMHA0y7CtbhBQu08kq8XbXqf0NyjeDCT06sDZt+wve8z44OAb0=;
 s=default; c=relaxed/relaxed; d=vivo.com; v=1;
 bh=nA77dwefWlFxLZGJhY5jKVIiNZ7p4Um7DetRWYuu1+s=;
 h=date:mime-version:subject:message-id:from;
Received: from vivo.com (localhost [127.0.0.1])
 by mail-m176233.qiye.163.com (Hmail) with ESMTP id EAE418C00C9;
 Mon, 21 Jun 2021 09:33:41 +0800 (CST)
Message-ID: <AFIAWADvD1*BeRWHpwhmBaqG.3.1624239221938.Hmail.bernard@vivo.com>
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Subject: =?UTF-8?B?UmU6UmU6IFtQQVRDSCAwLzRdIGRlbGV0ZSB1c2VsZXNzIGZ1bmN0aW9uIHJldHVybiB2YWx1ZXMgJiByZW1vdmUgbWVhbmluZ2xlc3MgaWYocikgY2hlY2sgY29kZQ==?=
X-Priority: 3
X-Mailer: HMail Webmail Server V2.0 Copyright (c) 2016-163.com
X-Originating-IP: 58.213.83.158
In-Reply-To: <e6c51c79-52ae-5591-45c7-382d1a8f2b5d@amd.com>
MIME-Version: 1.0
Received: from bernard@vivo.com( [58.213.83.158) ] by ajax-webmail (
 [127.0.0.1] ) ; Mon, 21 Jun 2021 09:33:41 +0800 (GMT+08:00)
From: Bernard <bernard@vivo.com>
Date: Mon, 21 Jun 2021 09:33:41 +0800 (GMT+08:00)
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
 oVCBIfWUFZQh5DT1ZOSUxKQ0JDHUhPH0JVEwETFhoSFyQUDg9ZV1kWGg8SFR0UWUFZT0tIVUpKS0
 9ISFVLWQY+
X-HM-Sender-Digest: e1kJHlYWEh9ZQU1PT0hCS0xPSU5ON1dZDB4ZWUEPCQ4eV1kSHx4VD1lB
 WUc6PTI6LDo*DT9KUTkeKSwzCwwTFjkaCjxVSFVKTUlPSUhCSUlJSU5KVTMWGhIXVRkeCRUaCR87
 DRINFFUYFBZFWVdZEgtZQVlOQ1VJSkhVQ0hVSk5DWVdZCAFZQU9CTU43Bg++
X-HM-Tid: 0a7a2c33acd1d9abkuwseae418c00c9
X-Mailman-Approved-At: Mon, 21 Jun 2021 07:09:08 +0000
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
Cc: David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 Daniel Vetter <daniel@ffwll.ch>, Alex Deucher <alexander.deucher@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

CkZyb206ICJDaHJpc3RpYW4gS8O2bmlnIiA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPgpEYXRl
OiAyMDIxLTA2LTIxIDAwOjU5OjI3ClRvOiAgQmVybmFyZCBaaGFvIDxiZXJuYXJkQHZpdm8uY29t
PixBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+LERhdmlkIEFpcmxpZSA8
YWlybGllZEBsaW51eC5pZT4sRGFuaWVsIFZldHRlciA8ZGFuaWVsQGZmd2xsLmNoPixhbWQtZ2Z4
QGxpc3RzLmZyZWVkZXNrdG9wLm9yZyxkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnLGxp
bnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcKU3ViamVjdDogUmU6IFtQQVRDSCAwLzRdIGRlbGV0
ZSB1c2VsZXNzIGZ1bmN0aW9uIHJldHVybiB2YWx1ZXMgJiByZW1vdmUgbWVhbmluZ2xlc3MgaWYo
cikgY2hlY2sgY29kZT5BbSAxOS4wNi4yMSB1bSAwODo0MyBzY2hyaWViIEJlcm5hcmQgWmhhbzoK
Pj4gRnVuY3Rpb24gcmFkZW9uX2ZlbmNlX2RyaXZlcl9pbml0IGFsd2F5cyByZXR1cm5zIHN1Y2Nl
c3MsCj4+IHRoZSBmdW5jdGlvbiB0eXBlIG1heWJlIGNvdWxlIGJlIGNoYW5nZWQgdG8gdm9pZC4K
Pj4gVGhpcyBwYXRjaCBzZXJpZXMgd2lsbCBmaXJzdCBkZWxldGUgdGhlIGNoZWNrIG9mIHRoZSBy
ZXR1cm4KPj4gdmFsdWUgb2YgdGhlIGZ1bmN0aW9uIGNhbGwgcmFkZW9uX2ZlbmNlX2RyaXZlcl9p
bml0LCB0aGVuLAo+PiBvcHRpbWlzZSB0aGUgZnVuY3Rpb24gZGVjbGFyYXRpb24gYW5kIGZ1bmN0
aW9uIHRvIHZvaWQgdHlwZS4KPgo+UGxlYXNlIG1lcmdlIGFsbCBvZiB0aGlzIGludG8gYSBzaW5n
bGUgcGF0Y2gsIEkgZG9uJ3Qgc2VlIGFueSBwb2ludCAKPnNlcGFyYXRpbmcgdGhpcy4KPgo+Q2hy
aXN0aWFuLgoKSGkKU3VyZSwgaSB3aWxsIHJlc3VibWl0IG9uZSBuZXcgcHRhY2gsIHRoYW5rcyEK
QlIvL0Jlcm5hcmQKCj4+Cj4+IFNpZ25lZC1vZmYtYnk6IEJlcm5hcmQgWmhhbyA8YmVybmFyZEB2
aXZvLmNvbT4KPj4KPj4gQmVybmFyZCBaaGFvICg0KToKPj4gICAgZHJtL3JhZGVvbjogcmVtb3Zl
IG1lYW5pbmdsZXNzIGlmKHIpIGNoZWNrIGNvZGUKPj4gICAgZHJtL3JhZGVvbjogcmVtb3ZlIG1l
YW5pbmdsZXNzIGlmKHIpIGNoZWNrIGNvZGUKPj4gICAgZHJtL3JhZGVvbjogcmVtb3ZlIG1lYW5p
bmdsZXNzIGlmKHIpIGNoZWNrIGNvZGUKPj4gICAgZHJtL3JhZGVvbjogZGVsZXRlIHVzZWxlc3Mg
cmV0dXJuIHZhbHVlcwo+Pgo+PiAgIGRyaXZlcnMvZ3B1L2RybS9yYWRlb24vY2lrLmMgICAgICAg
ICAgfCA0ICstLS0KPj4gICBkcml2ZXJzL2dwdS9kcm0vcmFkZW9uL2V2ZXJncmVlbi5jICAgIHwg
NCArLS0tCj4+ICAgZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9uaS5jICAgICAgICAgICB8IDQgKy0t
LQo+PiAgIGRyaXZlcnMvZ3B1L2RybS9yYWRlb24vcjEwMC5jICAgICAgICAgfCA0ICstLS0KPj4g
ICBkcml2ZXJzL2dwdS9kcm0vcmFkZW9uL3IzMDAuYyAgICAgICAgIHwgNCArLS0tCj4+ICAgZHJp
dmVycy9ncHUvZHJtL3JhZGVvbi9yNDIwLmMgICAgICAgICB8IDUgKy0tLS0KPj4gICBkcml2ZXJz
L2dwdS9kcm0vcmFkZW9uL3I1MjAuYyAgICAgICAgIHwgNCArLS0tCj4+ICAgZHJpdmVycy9ncHUv
ZHJtL3JhZGVvbi9yNjAwLmMgICAgICAgICB8IDQgKy0tLQo+PiAgIGRyaXZlcnMvZ3B1L2RybS9y
YWRlb24vcmFkZW9uLmggICAgICAgfCAyICstCj4+ICAgZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9y
YWRlb25fZmVuY2UuYyB8IDUgKy0tLS0KPj4gICBkcml2ZXJzL2dwdS9kcm0vcmFkZW9uL3JzNDAw
LmMgICAgICAgIHwgNCArLS0tCj4+ICAgZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9yczYwMC5jICAg
ICAgICB8IDQgKy0tLQo+PiAgIGRyaXZlcnMvZ3B1L2RybS9yYWRlb24vcnM2OTAuYyAgICAgICAg
fCA0ICstLS0KPj4gICBkcml2ZXJzL2dwdS9kcm0vcmFkZW9uL3J2NTE1LmMgICAgICAgIHwgNCAr
LS0tCj4+ICAgZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9ydjc3MC5jICAgICAgICB8IDQgKy0tLQo+
PiAgIGRyaXZlcnMvZ3B1L2RybS9yYWRlb24vc2kuYyAgICAgICAgICAgfCA0ICstLS0KPj4gICAx
NiBmaWxlcyBjaGFuZ2VkLCAxNiBpbnNlcnRpb25zKCspLCA0OCBkZWxldGlvbnMoLSkKPj4KPgoN
Cg0KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdm
eCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0
cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
