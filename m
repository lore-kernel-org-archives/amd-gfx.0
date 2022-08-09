Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4A8CC25B0C
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Aug 2022 15:52:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 247DC18ADBE;
	Tue,  9 Aug 2022 15:51:29 +0000 (UTC)
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com
 [IPv6:2001:4860:4864:20::2d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D9CC48D19D
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 Aug 2022 15:50:16 +0000 (UTC)
Received: by mail-oa1-x2d.google.com with SMTP id
 586e51a60fabf-10bd4812c29so14386672fac.11
 for <amd-gfx@lists.freedesktop.org>; Tue, 09 Aug 2022 08:50:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc;
 bh=Vn30nOutD2AC9h3DYJTYUVNOUvvUlLcfeEmI4+Q1sNg=;
 b=dD3oBLY5ZccbJUaLsbRFpwASFBV0zZ1RRPGZS2HXjt/2BtggshLxDG5yMz3HW2HSX7
 yyeGfyGvTPlGZZ4QMab6PBZ0l0vKockcblBnSHua10GjcPv6hGH4IdHhjXxGMA7FylOQ
 IN7M3BFtg8Za5fy0uqcFRHt4iMF4AHfJH/nydeYw8col87dUGG+/hJ4aNJt8n8bB7ou4
 nkMHdm8IzsCvam31pg/DMnG+nI9PnBGKoLJuTiduVk2n/H4TMZM5P5ni3UOQcY0mqa0l
 9g58fbinhQ+Zi8JgAbOShOoJAsm1SBiuqKaOFrZnDX0doun4Noeay/c2SNrNVtnne501
 rMUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc;
 bh=Vn30nOutD2AC9h3DYJTYUVNOUvvUlLcfeEmI4+Q1sNg=;
 b=f3N2/6mXkWtdgvJegWddHr/MjyJhhNiK8SH+drm5t6FMAAfCuUkxmLSGVrLgviiNhp
 BBXsuYqLlEVHhV2WhXYEAXAi2OVS6Q3RpaaFeoD04GpxhvzzTysIZfNbXCSFPDslx3Za
 5Sz0clarfWeIicWjC38/vyaDc5Jc9wB2l6mblGrICvcvAtfZ9ndao/NJ0S63JMl5Wzl7
 4ANlX4AC1CVZBKI9xVCg3wiRAw9m0HKkY3qQsi5F8bvi5+gzBiNHc33T5kRwkY/CwNm8
 WYfURL1WiHlc1f26iR6aoxJg0hfc10LSL6KJBZz0zjNAOosurY26mbZ+1TbN174Jmval
 zxWw==
X-Gm-Message-State: ACgBeo3ovBOF7+KxEM2npL6eV+RMVuv1pPu+rLB7Hxkh/x/ibIVymBGH
 Tf9z7+FSfAPemWcDDmbcn9zzVR6oMVIjWkTHKX0=
X-Google-Smtp-Source: AA6agR7A4C1tTaQPHk9nD732kdaV/JfIOR8htK33E5jEKc88vNTpunq713X83HiHbGx0u4Fw4NcLp/JRUXc4fmuKVec=
X-Received: by 2002:a05:6870:3398:b0:113:7f43:d0e9 with SMTP id
 w24-20020a056870339800b001137f43d0e9mr6350297oae.33.1660060215831; Tue, 09
 Aug 2022 08:50:15 -0700 (PDT)
MIME-Version: 1.0
References: <20220809151008.20376-1-mario.limonciello@amd.com>
In-Reply-To: <20220809151008.20376-1-mario.limonciello@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 9 Aug 2022 11:50:04 -0400
Message-ID: <CADnq5_OTV8C8oSicO7=7TAGy1s9ZwX40Pi1XHYFCizw_UiO-8Q@mail.gmail.com>
Subject: Re: [PATCH 0/4] Fix S3 and S4 issues related to fbdev
To: Mario Limonciello <mario.limonciello@amd.com>
Content-Type: multipart/mixed; boundary="00000000000078b1ef05e5d0e372"
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
Cc: Alexander.Deucher@amd.com, Evan.Quan@amd.com, h.judt@gmx.at,
 Renjith.Pananchikkal@amd.com, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--00000000000078b1ef05e5d0e372
Content-Type: text/plain; charset="UTF-8"

On Tue, Aug 9, 2022 at 11:10 AM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> Moving to the generic fbdev helper introduced a regression in S4 support
> on Hawaii PRO graphics cards.  A workaround commit was introduced to
> avoid this S4 regression until the root cause could be found, but that
> workaround commit introduced a completely separate regression on S3 on
> a WX3200.
>
> This series reverts all the code to move to generic fbdev helpers to
> fix both issues.

I'm not opposed to reverting this, but I fear we'll never get rid of
this old fbdev code.  What about just applying the workaround for
hawaii as per the attached patch?  There is always the concern that
this will lead to more workarounds, but I'd rather avoid touching the
older asic support as much as possible.

Alex

>
> Mario Limonciello (4):
>   Revert "drm/amdgpu/display: disable prefer_shadow for generic fb
>     helpers"
>   Revert "drm/amdgpu: keep fbdev buffers pinned during suspend"
>   Revert "drm/amdgpu: drop amdgpu_display_gem_fb_init()"
>   Revert "drm/amdgpu: use generic fb helpers instead of setting up AMD
>     own's."
>
>  drivers/gpu/drm/amd/amdgpu/Makefile           |   2 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |  12 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_display.c   |  43 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       |  13 -
>  drivers/gpu/drm/amd/amdgpu/amdgpu_fb.c        | 388 ++++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c       |  30 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h      |  25 ++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c      |   3 +-
>  drivers/gpu/drm/amd/amdgpu/dce_v10_0.c        |   3 +-
>  drivers/gpu/drm/amd/amdgpu/dce_v11_0.c        |   3 +-
>  drivers/gpu/drm/amd/amdgpu/dce_v6_0.c         |   3 +-
>  drivers/gpu/drm/amd/amdgpu/dce_v8_0.c         |   3 +-
>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |   3 +-
>  13 files changed, 457 insertions(+), 74 deletions(-)
>  create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_fb.c
>
> --
> 2.34.1
>

--00000000000078b1ef05e5d0e372
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0001-drm-amdgpu-Only-disable-prefer_shadow-on-hawaii.patch"
Content-Disposition: attachment; 
	filename="0001-drm-amdgpu-Only-disable-prefer_shadow-on-hawaii.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_l6mcwy4d0>
X-Attachment-Id: f_l6mcwy4d0

RnJvbSA5ZTA0NzU5YTQzMmFkZGUzODczN2ZiYjlkYTNiNTdkYjI1OTY5ZTE4IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5j
b20+CkRhdGU6IFR1ZSwgOSBBdWcgMjAyMiAxMTo0NDowNSAtMDQwMApTdWJqZWN0OiBbUEFUQ0hd
IGRybS9hbWRncHU6IE9ubHkgZGlzYWJsZSBwcmVmZXJfc2hhZG93IG9uIGhhd2FpaQoKV2UgY2hh
bmdlZCBpdCBmb3IgYWxsIGFzaWNzIGR1ZSB0byBhIGhpYmVybmF0aW9uIHJlZ3Jlc3Npb24Kb24g
aGF3YWlpLCBidXQgdGhlIHdvcmthcm91bmQgYnJlYWtzIHN1c3BlbmQgb24gYSBwb2xhcmlzMTIu
Ckp1c3QgZGlzYWJsZSBpdCBmb3IgaGF3YWlpLgoKTGluazogaHR0cHM6Ly9idWd6aWxsYS5rZXJu
ZWwub3JnL3Nob3dfYnVnLmNnaT9pZD0yMTYxMTkKRml4ZXM6IDNhNGIxY2MyOGZiZCAoImRybS9h
bWRncHUvZGlzcGxheTogZGlzYWJsZSBwcmVmZXJfc2hhZG93IGZvciBnZW5lcmljIGZiIGhlbHBl
cnMiKQpTaWduZWQtb2ZmLWJ5OiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5j
b20+Ci0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZrbXMuYyAgICAgICAg
ICB8IDMgKy0tCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9kY2VfdjEwXzAuYyAgICAgICAg
ICAgIHwgMyArLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2RjZV92MTFfMC5jICAgICAg
ICAgICAgfCAzICstLQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZGNlX3Y2XzAuYyAgICAg
ICAgICAgICB8IDMgKy0tCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9kY2VfdjhfMC5jICAg
ICAgICAgICAgIHwgNyArKysrKy0tCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvYW1kZ3B1
X2RtL2FtZGdwdV9kbS5jIHwgNyArKysrKy0tCiA2IGZpbGVzIGNoYW5nZWQsIDE0IGluc2VydGlv
bnMoKyksIDEyIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L2FtZGdwdV92a21zLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVf
dmttcy5jCmluZGV4IDMyNzE2NmYyZjM1Yy4uZDY4MjMzZGM3NzJjIDEwMDY0NAotLS0gYS9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdmttcy5jCisrKyBiL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2FtZGdwdV92a21zLmMKQEAgLTQ5Niw4ICs0OTYsNyBAQCBzdGF0aWMgaW50
IGFtZGdwdV92a21zX3N3X2luaXQodm9pZCAqaGFuZGxlKQogCWFkZXZfdG9fZHJtKGFkZXYpLT5t
b2RlX2NvbmZpZy5tYXhfaGVpZ2h0ID0gWVJFU19NQVg7CiAKIAlhZGV2X3RvX2RybShhZGV2KS0+
bW9kZV9jb25maWcucHJlZmVycmVkX2RlcHRoID0gMjQ7Ci0JLyogZGlzYWJsZSBwcmVmZXIgc2hh
ZG93IGZvciBub3cgZHVlIHRvIGhpYmVybmF0aW9uIGlzc3VlcyAqLwotCWFkZXZfdG9fZHJtKGFk
ZXYpLT5tb2RlX2NvbmZpZy5wcmVmZXJfc2hhZG93ID0gMDsKKwlhZGV2X3RvX2RybShhZGV2KS0+
bW9kZV9jb25maWcucHJlZmVyX3NoYWRvdyA9IDE7CiAKIAlhZGV2X3RvX2RybShhZGV2KS0+bW9k
ZV9jb25maWcuZmJfYmFzZSA9IGFkZXYtPmdtYy5hcGVyX2Jhc2U7CiAKZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2RjZV92MTBfMC5jIGIvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvZGNlX3YxMF8wLmMKaW5kZXggMmU5MGNkODI4ODk1Li5iZGQzYWVmNmQwNzEgMTAw
NjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2RjZV92MTBfMC5jCisrKyBiL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2RjZV92MTBfMC5jCkBAIC0yNzk2LDggKzI3OTYsNyBA
QCBzdGF0aWMgaW50IGRjZV92MTBfMF9zd19pbml0KHZvaWQgKmhhbmRsZSkKIAlhZGV2X3RvX2Ry
bShhZGV2KS0+bW9kZV9jb25maWcubWF4X2hlaWdodCA9IDE2Mzg0OwogCiAJYWRldl90b19kcm0o
YWRldiktPm1vZGVfY29uZmlnLnByZWZlcnJlZF9kZXB0aCA9IDI0OwotCS8qIGRpc2FibGUgcHJl
ZmVyIHNoYWRvdyBmb3Igbm93IGR1ZSB0byBoaWJlcm5hdGlvbiBpc3N1ZXMgKi8KLQlhZGV2X3Rv
X2RybShhZGV2KS0+bW9kZV9jb25maWcucHJlZmVyX3NoYWRvdyA9IDA7CisJYWRldl90b19kcm0o
YWRldiktPm1vZGVfY29uZmlnLnByZWZlcl9zaGFkb3cgPSAxOwogCiAJYWRldl90b19kcm0oYWRl
diktPm1vZGVfY29uZmlnLmZiX21vZGlmaWVyc19ub3Rfc3VwcG9ydGVkID0gdHJ1ZTsKIApkaWZm
IC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZGNlX3YxMV8wLmMgYi9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9kY2VfdjExXzAuYwppbmRleCBiMzJhY2JhYWQyOTMuLjMyOGQ5
ZTE2NjY4YSAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZGNlX3YxMV8w
LmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZGNlX3YxMV8wLmMKQEAgLTI5MTQs
OCArMjkxNCw3IEBAIHN0YXRpYyBpbnQgZGNlX3YxMV8wX3N3X2luaXQodm9pZCAqaGFuZGxlKQog
CWFkZXZfdG9fZHJtKGFkZXYpLT5tb2RlX2NvbmZpZy5tYXhfaGVpZ2h0ID0gMTYzODQ7CiAKIAlh
ZGV2X3RvX2RybShhZGV2KS0+bW9kZV9jb25maWcucHJlZmVycmVkX2RlcHRoID0gMjQ7Ci0JLyog
ZGlzYWJsZSBwcmVmZXIgc2hhZG93IGZvciBub3cgZHVlIHRvIGhpYmVybmF0aW9uIGlzc3VlcyAq
LwotCWFkZXZfdG9fZHJtKGFkZXYpLT5tb2RlX2NvbmZpZy5wcmVmZXJfc2hhZG93ID0gMDsKKwlh
ZGV2X3RvX2RybShhZGV2KS0+bW9kZV9jb25maWcucHJlZmVyX3NoYWRvdyA9IDE7CiAKIAlhZGV2
X3RvX2RybShhZGV2KS0+bW9kZV9jb25maWcuZmJfbW9kaWZpZXJzX25vdF9zdXBwb3J0ZWQgPSB0
cnVlOwogCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9kY2VfdjZfMC5j
IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZGNlX3Y2XzAuYwppbmRleCBkYjNmNTVkODVk
NWMuLmQxMDFjZWI4YzJhNCAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
ZGNlX3Y2XzAuYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9kY2VfdjZfMC5jCkBA
IC0yNjczLDggKzI2NzMsNyBAQCBzdGF0aWMgaW50IGRjZV92Nl8wX3N3X2luaXQodm9pZCAqaGFu
ZGxlKQogCWFkZXZfdG9fZHJtKGFkZXYpLT5tb2RlX2NvbmZpZy5tYXhfd2lkdGggPSAxNjM4NDsK
IAlhZGV2X3RvX2RybShhZGV2KS0+bW9kZV9jb25maWcubWF4X2hlaWdodCA9IDE2Mzg0OwogCWFk
ZXZfdG9fZHJtKGFkZXYpLT5tb2RlX2NvbmZpZy5wcmVmZXJyZWRfZGVwdGggPSAyNDsKLQkvKiBk
aXNhYmxlIHByZWZlciBzaGFkb3cgZm9yIG5vdyBkdWUgdG8gaGliZXJuYXRpb24gaXNzdWVzICov
Ci0JYWRldl90b19kcm0oYWRldiktPm1vZGVfY29uZmlnLnByZWZlcl9zaGFkb3cgPSAwOworCWFk
ZXZfdG9fZHJtKGFkZXYpLT5tb2RlX2NvbmZpZy5wcmVmZXJfc2hhZG93ID0gMTsKIAlhZGV2X3Rv
X2RybShhZGV2KS0+bW9kZV9jb25maWcuZmJfbW9kaWZpZXJzX25vdF9zdXBwb3J0ZWQgPSB0cnVl
OwogCWFkZXZfdG9fZHJtKGFkZXYpLT5tb2RlX2NvbmZpZy5mYl9iYXNlID0gYWRldi0+Z21jLmFw
ZXJfYmFzZTsKIApkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZGNlX3Y4
XzAuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2RjZV92OF8wLmMKaW5kZXggZGY4MDA5
MGVlYzViLi4yYmVlODM0Mzc4MmQgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2RjZV92OF8wLmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZGNlX3Y4XzAu
YwpAQCAtMjY5Myw4ICsyNjkzLDExIEBAIHN0YXRpYyBpbnQgZGNlX3Y4XzBfc3dfaW5pdCh2b2lk
ICpoYW5kbGUpCiAJYWRldl90b19kcm0oYWRldiktPm1vZGVfY29uZmlnLm1heF9oZWlnaHQgPSAx
NjM4NDsKIAogCWFkZXZfdG9fZHJtKGFkZXYpLT5tb2RlX2NvbmZpZy5wcmVmZXJyZWRfZGVwdGgg
PSAyNDsKLQkvKiBkaXNhYmxlIHByZWZlciBzaGFkb3cgZm9yIG5vdyBkdWUgdG8gaGliZXJuYXRp
b24gaXNzdWVzICovCi0JYWRldl90b19kcm0oYWRldiktPm1vZGVfY29uZmlnLnByZWZlcl9zaGFk
b3cgPSAwOworCWlmIChhZGV2LT5hc2ljX3R5cGUgPT0gQ0hJUF9IQVdBSUkpCisJCS8qIGRpc2Fi
bGUgcHJlZmVyIHNoYWRvdyBmb3Igbm93IGR1ZSB0byBoaWJlcm5hdGlvbiBpc3N1ZXMgKi8KKwkJ
YWRldl90b19kcm0oYWRldiktPm1vZGVfY29uZmlnLnByZWZlcl9zaGFkb3cgPSAwOworCWVsc2UK
KwkJYWRldl90b19kcm0oYWRldiktPm1vZGVfY29uZmlnLnByZWZlcl9zaGFkb3cgPSAxOwogCiAJ
YWRldl90b19kcm0oYWRldiktPm1vZGVfY29uZmlnLmZiX21vZGlmaWVyc19ub3Rfc3VwcG9ydGVk
ID0gdHJ1ZTsKIApkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2FtZGdw
dV9kbS9hbWRncHVfZG0uYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9hbWRncHVfZG0v
YW1kZ3B1X2RtLmMKaW5kZXggYTQ0YTNmNTIwYzA1Li41N2JlZjVlYTlhYTUgMTAwNjQ0Ci0tLSBh
L2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9hbWRncHVfZG0vYW1kZ3B1X2RtLmMKKysrIGIv
ZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2FtZGdwdV9kbS9hbWRncHVfZG0uYwpAQCAtMzgy
NSw4ICszODI1LDExIEBAIHN0YXRpYyBpbnQgYW1kZ3B1X2RtX21vZGVfY29uZmlnX2luaXQoc3Ry
dWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpCiAJYWRldl90b19kcm0oYWRldiktPm1vZGVfY29uZmln
Lm1heF9oZWlnaHQgPSAxNjM4NDsKIAogCWFkZXZfdG9fZHJtKGFkZXYpLT5tb2RlX2NvbmZpZy5w
cmVmZXJyZWRfZGVwdGggPSAyNDsKLQkvKiBkaXNhYmxlIHByZWZlciBzaGFkb3cgZm9yIG5vdyBk
dWUgdG8gaGliZXJuYXRpb24gaXNzdWVzICovCi0JYWRldl90b19kcm0oYWRldiktPm1vZGVfY29u
ZmlnLnByZWZlcl9zaGFkb3cgPSAwOworCWlmIChhZGV2LT5hc2ljX3R5cGUgPT0gQ0hJUF9IQVdB
SUkpCisJCS8qIGRpc2FibGUgcHJlZmVyIHNoYWRvdyBmb3Igbm93IGR1ZSB0byBoaWJlcm5hdGlv
biBpc3N1ZXMgKi8KKwkJYWRldl90b19kcm0oYWRldiktPm1vZGVfY29uZmlnLnByZWZlcl9zaGFk
b3cgPSAwOworCWVsc2UKKwkJYWRldl90b19kcm0oYWRldiktPm1vZGVfY29uZmlnLnByZWZlcl9z
aGFkb3cgPSAxOwogCS8qIGluZGljYXRlcyBzdXBwb3J0IGZvciBpbW1lZGlhdGUgZmxpcCAqLwog
CWFkZXZfdG9fZHJtKGFkZXYpLT5tb2RlX2NvbmZpZy5hc3luY19wYWdlX2ZsaXAgPSB0cnVlOwog
Ci0tIAoyLjM1LjMKCg==
--00000000000078b1ef05e5d0e372--
