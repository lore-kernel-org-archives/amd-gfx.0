Return-Path: <SRS0=0i2d=KW=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FB96C4708A
	for <amd-gfx@archiver.kernel.org>; Thu, 27 May 2021 03:51:58 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F0AE0613C7
	for <amd-gfx@archiver.kernel.org>; Thu, 27 May 2021 03:51:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0AE0613C7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8EA926EE01;
	Thu, 27 May 2021 03:51:55 +0000 (UTC)
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com
 [IPv6:2607:f8b0:4864:20::333])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A8FC26EDFE;
 Thu, 27 May 2021 03:51:53 +0000 (UTC)
Received: by mail-ot1-x333.google.com with SMTP id
 80-20020a9d08560000b0290333e9d2b247so3155390oty.7; 
 Wed, 26 May 2021 20:51:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=ObVfNwPVO2PC2rJ9mQ29zRLy3G1wFkbEiSVflWMxPk4=;
 b=bI4D1NOOpgtzq6luGnjJmHGV5j4sd9uC+nnz4zwFn2dCp2SPukZLmj+rS+Ra0LVncm
 kT+0/v11S2ccVthKIOH+C+b12P2XUqegYcFbGb2tM60SY1kfCxuhkjH36LnDNKarTmLe
 FlwSVyc7WBPgTFHmirMYMTQBiAxZv6mU4D6hIbDgZhtRbduzQphA2gwwMpTXgPzSMOjX
 8uY7xAnrhMsfsv+Efn51gD0Yk4EicB5y4rckTYSmlWy1rWoh9e+zPLuqSp9pW+vWbaSA
 nIAIH3JqV7zPtXopv8ahSj+4c9N5bN8YekfFmJTMhs7Kh/QZDs01vItMLmZqcX4ThW+g
 LeyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=ObVfNwPVO2PC2rJ9mQ29zRLy3G1wFkbEiSVflWMxPk4=;
 b=pFOYE4NcseXaLvblRj4e6Cx+/iyl40xg3ekB7V4zOoZYz6Whpi3naPhG1TlXOGRzNF
 ePbCKEZ4qerYvh5Ny0cdEOm9kxTsMMpstfKoYkyC5orUsH0ZAB4xk4sT/8JF0jQh7FAH
 bnKddE4DCN4o+4a8k9141ztI1QQXvpUcycGSkJ8y/55uVred3ik732zQ8C6Umf3KigHo
 cChVbLJuKqrahEnO4gXQkYM52hwAx68V8/kU0x0UtWMRZdhuvROZTYKzKtzuj+2pAYYk
 gFyOroffuaUfqIWqxbJbWRIOs+Eb+h3LnI0b+nxN3TcBtK0c0FZIav2CN9qmOgBtU3lA
 ZDuA==
X-Gm-Message-State: AOAM533VIjdpCgjjuC014WCI495U6r+QGvzw6ryuxTP6Xwqe766u+Y73
 Hgt1UkvqiHT1RO5kMfqTKbLrIw+TcnNMvd8aGvJqWLCt
X-Google-Smtp-Source: ABdhPJzoXaQbaKR/UK+3tvFkSVSQl0hgYg8KapNW/jKmqAowfs7VRGNg2OuJK2CjLoD3C/186iR8I/cCd0c4HRWXKmo=
X-Received: by 2002:a9d:57cd:: with SMTP id q13mr1201591oti.23.1622087513057; 
 Wed, 26 May 2021 20:51:53 -0700 (PDT)
MIME-Version: 1.0
References: <20210526084726.552052-1-lee.jones@linaro.org>
 <20210526084726.552052-4-lee.jones@linaro.org>
In-Reply-To: <20210526084726.552052-4-lee.jones@linaro.org>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 26 May 2021 23:51:41 -0400
Message-ID: <CADnq5_MRrMWuCOrWx4iVrARkFs6HQzdQb8TMKMK4sm3bmNkv4Q@mail.gmail.com>
Subject: Re: [PATCH 03/34] drm/amd/pm/powerplay/hwmgr/smu7_thermal: Provide
 function name for 'smu7_fan_ctrl_set_default_mode()'
To: Lee Jones <lee.jones@linaro.org>
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
Cc: David Airlie <airlied@linux.ie>, LKML <linux-kernel@vger.kernel.org>,
 Maling list - DRI developers <dri-devel@lists.freedesktop.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Alex Deucher <alexander.deucher@amd.com>, Evan Quan <evan.quan@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QXBwbGllZC4gIFRoYW5rcyEKCk9uIFdlZCwgTWF5IDI2LCAyMDIxIGF0IDQ6NDcgQU0gTGVlIEpv
bmVzIDxsZWUuam9uZXNAbGluYXJvLm9yZz4gd3JvdGU6Cj4KPiBGaXhlcyB0aGUgZm9sbG93aW5n
IFc9MSBrZXJuZWwgYnVpbGQgd2FybmluZyhzKToKPgo+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS8uLi9wbS9wb3dlcnBsYXkvaHdtZ3Ivc211N190aGVybWFsLmM6MTMyOiB3YXJuaW5nOiBU
aGlzIGNvbW1lbnQgc3RhcnRzIHdpdGggJy8qKicsIGJ1dCBpc24ndCBhIGtlcm5lbC1kb2MgY29t
bWVudC4gUmVmZXIgRG9jdW1lbnRhdGlvbi9kb2MtZ3VpZGUva2VybmVsLWRvYy5yc3QKPgo+IENj
OiBFdmFuIFF1YW4gPGV2YW4ucXVhbkBhbWQuY29tPgo+IENjOiBBbGV4IERldWNoZXIgPGFsZXhh
bmRlci5kZXVjaGVyQGFtZC5jb20+Cj4gQ2M6ICJDaHJpc3RpYW4gS8O2bmlnIiA8Y2hyaXN0aWFu
LmtvZW5pZ0BhbWQuY29tPgo+IENjOiBEYXZpZCBBaXJsaWUgPGFpcmxpZWRAbGludXguaWU+Cj4g
Q2M6IERhbmllbCBWZXR0ZXIgPGRhbmllbEBmZndsbC5jaD4KPiBDYzogYW1kLWdmeEBsaXN0cy5m
cmVlZGVza3RvcC5vcmcKPiBDYzogZHJpLWRldmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9yZwo+IFNp
Z25lZC1vZmYtYnk6IExlZSBKb25lcyA8bGVlLmpvbmVzQGxpbmFyby5vcmc+Cj4gLS0tCj4gIGRy
aXZlcnMvZ3B1L2RybS9hbWQvcG0vcG93ZXJwbGF5L2h3bWdyL3NtdTdfdGhlcm1hbC5jIHwgOCAr
KysrLS0tLQo+ICAxIGZpbGUgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygt
KQo+Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG0vcG93ZXJwbGF5L2h3bWdy
L3NtdTdfdGhlcm1hbC5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9wb3dlcnBsYXkvaHdtZ3Iv
c211N190aGVybWFsLmMKPiBpbmRleCAwZDM4ZDQyMDY4NDhhLi42Y2ZlMTQ4ZWQ0NWJiIDEwMDY0
NAo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG0vcG93ZXJwbGF5L2h3bWdyL3NtdTdfdGhl
cm1hbC5jCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9wb3dlcnBsYXkvaHdtZ3Ivc211
N190aGVybWFsLmMKPiBAQCAtMTI5LDEwICsxMjksMTAgQEAgaW50IHNtdTdfZmFuX2N0cmxfc2V0
X3N0YXRpY19tb2RlKHN0cnVjdCBwcF9od21nciAqaHdtZ3IsIHVpbnQzMl90IG1vZGUpCj4gIH0K
Pgo+ICAvKioKPiAtKiBSZXNldCBGYW4gU3BlZWQgQ29udHJvbCB0byBkZWZhdWx0IG1vZGUuCj4g
LSogQGh3bWdyOiAgdGhlIGFkZHJlc3Mgb2YgdGhlIHBvd2VycGxheSBoYXJkd2FyZSBtYW5hZ2Vy
Lgo+IC0qIEV4Y2VwdGlvbjogU2hvdWxkIGFsd2F5cyBzdWNjZWVkLgo+IC0qLwo+ICsgKiBzbXU3
X2Zhbl9jdHJsX3NldF9kZWZhdWx0X21vZGUgLSBSZXNldCBGYW4gU3BlZWQgQ29udHJvbCB0byBk
ZWZhdWx0IG1vZGUuCj4gKyAqIEBod21ncjogIHRoZSBhZGRyZXNzIG9mIHRoZSBwb3dlcnBsYXkg
aGFyZHdhcmUgbWFuYWdlci4KPiArICogRXhjZXB0aW9uOiBTaG91bGQgYWx3YXlzIHN1Y2NlZWQu
Cj4gKyAqLwo+ICBpbnQgc211N19mYW5fY3RybF9zZXRfZGVmYXVsdF9tb2RlKHN0cnVjdCBwcF9o
d21nciAqaHdtZ3IpCj4gIHsKPiAgICAgICAgIGlmICghaHdtZ3ItPmZhbl9jdHJsX2lzX2luX2Rl
ZmF1bHRfbW9kZSkgewo+IC0tCj4gMi4zMS4xCj4KX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5m
cmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0
aW5mby9hbWQtZ2Z4Cg==
