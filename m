Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15134C001E0
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Jul 2023 10:56:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A29C810E181;
	Fri, 28 Jul 2023 10:56:35 +0000 (UTC)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3D70410E181
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Jul 2023 10:56:33 +0000 (UTC)
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4RC4M13R90z9stN;
 Fri, 28 Jul 2023 12:56:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1690541789;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5hEPLoqfE400Hx7CzA6V5N5eofZ4eL6nZVe4GAa1lt8=;
 b=lgPeODzlFiLyKYgwuJOhutG0AhftmIL08n4h+2VEcjp6PcZSd7gSh99zlTWVvaarHKy5ly
 jUBauyl/z7rstkzAARjspPkYQ7k8xW4vT9iW+lZWHJVHw+O9GnetjdVyxOhIOKDcHx9FIA
 JA5MQHTxyfhV1zgmFx0PeU4UPlHhH+YXH6lD9dtMRxobtYKPqYRS05c5aRFPSzx85YSwtm
 ZEYtVLm2l8rBvzAp8IrnHRevSFYwyRU1rr1VdbqWHeKSaNILaJgvboCmAfSjqyCWg664Fh
 a2VJpKS/2Yd5v1N8v0DZ4qTKBVyWmgNa6QpFQvqOAsk/UH4zD6mZ0HMgFzjgrA==
Content-Type: multipart/mixed; boundary="------------NAyugCMDRDovcKgz4UNkpx7m"
Message-ID: <acfde12d-e6b3-f95c-bd1d-94c0930a1bb7@mailbox.org>
Date: Fri, 28 Jul 2023 12:56:28 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v2] drm/amd/display: Use root connector's colorspace
 property for MST
From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel.daenzer@mailbox.org>
To: Harry Wentland <harry.wentland@amd.com>
References: <20230713195850.165198-1-harry.wentland@amd.com>
 <47c218ef-2844-1e9b-0e67-c0aae1cb8e9d@mailbox.org>
Content-Language: en-CA
In-Reply-To: <47c218ef-2844-1e9b-0e67-c0aae1cb8e9d@mailbox.org>
X-MBO-RS-META: rb4xhd9qfh8aa7eqjd3rhzxcdw5is88w
X-MBO-RS-ID: 18516e12f99d3fa938e
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
Cc: amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This is a multi-part message in MIME format.
--------------NAyugCMDRDovcKgz4UNkpx7m
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 7/14/23 18:52, Michel Dänzer wrote:
> On 7/13/23 21:58, Harry Wentland wrote:
>> After driver init we shouldn't create new properties. Doing so
>> will lead to a warning storm from __drm_mode_object_add.
>>
>> We don't really need to create the property for MST connectors.
>> Re-using the mst_root connector's property is fine.
>>
>> v2: Add curly braces to avoid possibly 'else' confusion
> 
> I'm still hitting WARNINGs with this, see attachment.

It's because drm_connector_attach_colorspace_property tries attaching the property to the MST root connector again, instead of to the newly created MST connector.

I tried the attached patch on top and didn't get any WARNINGs, but for some reason the MST connector for my external monitor never showed up to user space. Not sure what's going on there.


-- 
Earthling Michel Dänzer            |                  https://redhat.com
Libre software enthusiast          |         Mesa and Xwayland developer

--------------NAyugCMDRDovcKgz4UNkpx7m
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-drm-amd-display-Fix-attaching-root-colorspace-proper.patch"
Content-Disposition: attachment;
 filename*0="0001-drm-amd-display-Fix-attaching-root-colorspace-proper.pa";
 filename*1="tch"
Content-Transfer-Encoding: base64

RnJvbSAxOGVkYjkyZGRkYjY3ZTIzNGZlNzAwMmFlN2QwZmI4YmZkNzQ2NDJmIE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiA9P1VURi04P3E/TWljaGVsPTIwRD1DMz1BNG56ZXI/
PSA8bWRhZW56ZXJAcmVkaGF0LmNvbT4KRGF0ZTogRnJpLCAyOCBKdWwgMjAyMyAxMjoyMzox
MyArMDIwMApTdWJqZWN0OiBbUEFUQ0hdIGRybS9hbWQvZGlzcGxheTogRml4IGF0dGFjaGlu
ZyByb290IGNvbG9yc3BhY2UgcHJvcGVydHkgdG8KIE1TVCBjb25uZWN0b3IKTUlNRS1WZXJz
aW9uOiAxLjAKQ29udGVudC1UeXBlOiB0ZXh0L3BsYWluOyBjaGFyc2V0PVVURi04CkNvbnRl
bnQtVHJhbnNmZXItRW5jb2Rpbmc6IDhiaXQKCmRybV9jb25uZWN0b3JfYXR0YWNoX2NvbG9y
c3BhY2VfcHJvcGVydHkgdHJpZWQgYXR0YWNoaW5nIHRoZSBwcm9wZXJ0eQp0byB0aGUgbXN0
X3Jvb3QgY29ubmVjdG9yIGFnYWluLCB3aGljaCBoaXQgYSBXQVJOSU5HIGluCmRybV9vYmpl
Y3RfYXR0YWNoX3Byb3BlcnR5LgoKRml4IHRoaXMgYnkgY2FsbGluZyBkcm1fb2JqZWN0X2F0
dGFjaF9wcm9wZXJ0eSBkaXJlY3RseSB3aXRoIGFwcHJvcHJpYXRlCnBhcmFtZXRlcnMuCgpT
aWduZWQtb2ZmLWJ5OiBNaWNoZWwgRMOkbnplciA8bWRhZW56ZXJAcmVkaGF0LmNvbT4KLS0t
CiBkcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvYW1kZ3B1X2RtL2FtZGdwdV9kbS5jIHwg
NyArKysrKy0tCiAxIGZpbGUgY2hhbmdlZCwgNSBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9u
cygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9hbWRncHVf
ZG0vYW1kZ3B1X2RtLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvYW1kZ3B1X2Rt
L2FtZGdwdV9kbS5jCmluZGV4IGRmMzAyMDRhMmExYS4uNDQ3NTc2ZmI3NDIwIDEwMDY0NAot
LS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvYW1kZ3B1X2RtL2FtZGdwdV9kbS5j
CisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9hbWRncHVfZG0vYW1kZ3B1X2Rt
LmMKQEAgLTczMDIsOCArNzMwMiwxMSBAQCB2b2lkIGFtZGdwdV9kbV9jb25uZWN0b3JfaW5p
dF9oZWxwZXIoc3RydWN0IGFtZGdwdV9kaXNwbGF5X21hbmFnZXIgKmRtLAogCQkJaWYgKCFk
cm1fbW9kZV9jcmVhdGVfZHBfY29sb3JzcGFjZV9wcm9wZXJ0eSgmYWNvbm5lY3Rvci0+YmFz
ZSwgc3VwcG9ydGVkX2NvbG9yc3BhY2VzKSkKIAkJCQlkcm1fY29ubmVjdG9yX2F0dGFjaF9j
b2xvcnNwYWNlX3Byb3BlcnR5KCZhY29ubmVjdG9yLT5iYXNlKTsKIAkJfSBlbHNlIHsgLyog
dXNlIHJvb3QgY29ubmVjdG9yJ3MgcHJvcGVydHkgKi8KLQkJCWlmIChhY29ubmVjdG9yLT5t
c3Rfcm9vdC0+YmFzZS5jb2xvcnNwYWNlX3Byb3BlcnR5KQotCQkJCWRybV9jb25uZWN0b3Jf
YXR0YWNoX2NvbG9yc3BhY2VfcHJvcGVydHkoJmFjb25uZWN0b3ItPm1zdF9yb290LT5iYXNl
KTsKKwkJCWlmIChhY29ubmVjdG9yLT5tc3Rfcm9vdC0+YmFzZS5jb2xvcnNwYWNlX3Byb3Bl
cnR5KSB7CisJCQkJZHJtX29iamVjdF9hdHRhY2hfcHJvcGVydHkoJmFjb25uZWN0b3ItPmJh
c2UuYmFzZSwKKwkJCQkJCQkgICBhY29ubmVjdG9yLT5tc3Rfcm9vdC0+YmFzZS5jb2xvcnNw
YWNlX3Byb3BlcnR5LAorCQkJCQkJCSAgIERSTV9NT0RFX0NPTE9SSU1FVFJZX0RFRkFVTFQp
OworCQkJfQogCQl9CiAKIAl9Ci0tIAoyLjQwLjEKCg==

--------------NAyugCMDRDovcKgz4UNkpx7m--
