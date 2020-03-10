Return-Path: <SRS0=k5/X=43=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEAE3C10F27
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Mar 2020 12:54:43 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9FD012253D
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Mar 2020 12:54:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tVqSpwoU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FD012253D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6D9086E2D1;
	Tue, 10 Mar 2020 12:54:43 +0000 (UTC)
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com
 [IPv6:2a00:1450:4864:20::343])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3666A6E2D1
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Mar 2020 12:54:43 +0000 (UTC)
Received: by mail-wm1-x343.google.com with SMTP id e26so1215537wme.5
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Mar 2020 05:54:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=reply-to:subject:to:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=OZEYPx3p/SKdRGg6FGh9Mii+fufFbOZBXD81I/Ml+VM=;
 b=tVqSpwoUgdZzHua65ORBC4VSPQk1jiLwRHlOqpOlAkqm9ysJpyP+DnEP+6gSGEST8n
 qNuUVFi5UZIThMHrE7uRVUa35TUkk69oU0NKvWf6DJfH5d3BKh5lfRvasXERylfNGNts
 alo13WItjJfONwA3y4gGT6jPjh0uCO27eMzqfs3XaBAZsRoS1KRuEC+MeU/FnPt+x2tw
 Ox5EtqmK6qWwVmI5mhrQQmXFwPqQ8lYYX/T39pmkK+olJReFp9jVRGbrh8M/mZ07reuy
 qvaoaZyfkpfNsJ3BDBkE/rhnGUt+sSkOltaZ3hjG2pZYyi2jscTJpvi4L7CUlzD8urkE
 IDgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=OZEYPx3p/SKdRGg6FGh9Mii+fufFbOZBXD81I/Ml+VM=;
 b=BLMyDqSR9mUGUOnOk0qVvqZV2ONe+Wa4tenA6ZZ6QwyXdz+4pxOtt2ZRMDKE+PMtH2
 OSwyNqobfx1WgaZV2CzoQBhSmCpeZdjeKRGtIZ7ybMuS1dn40a21MZVtUpjNLMuu911K
 PIgntpIuyEbGCe3/Sz/i/GE1axlJrASQuY7wzecgRGxyLR5RdGo7NSyOM0CtnM5RS/4a
 n5fZskkqpfZecvTl0otKb5733gAEp0moCsl61C1TatOB2vIc0OJDgBM/isA56X8FM/74
 Zko8GtJZHibKO5Qpij0oNtIUrro4tNrnEr9FlGISN07voTwSAd4TFq+D2Qjoi9Slqf1T
 r/mg==
X-Gm-Message-State: ANhLgQ3UmY9HoCAhVDG9T7WXa+4Se7qg6xdMmp0SUap3zPkV+j+aNUS9
 chU0PgqG74+UkGJ0Cv37ezUhTQ59
X-Google-Smtp-Source: ADFU+vvpmyId7mMSvBDvjHU9hHJaAYCKfyqa6K73zQBXl+GEpfYZwNzEO3U7lsFUf+BYIlfFCoFLQA==
X-Received: by 2002:a1c:2048:: with SMTP id g69mr2078837wmg.187.1583844881518; 
 Tue, 10 Mar 2020 05:54:41 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7?
 ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
 by smtp.gmail.com with ESMTPSA id a1sm6678603wro.72.2020.03.10.05.54.40
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 10 Mar 2020 05:54:40 -0700 (PDT)
Subject: Re: [PATCH] drm/amd/amdgpu: Fix GPR read from debugfs
To: Tom St Denis <tom.stdenis@amd.com>, amd-gfx@lists.freedesktop.org
References: <20200310125314.83981-1-tom.stdenis@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <abaf3d7d-dc68-4380-96f7-be6b44dbc72f@gmail.com>
Date: Tue, 10 Mar 2020 13:54:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200310125314.83981-1-tom.stdenis@amd.com>
Content-Language: en-US
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
Reply-To: christian.koenig@amd.com
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QW0gMTAuMDMuMjAgdW0gMTM6NTMgc2NocmllYiBUb20gU3QgRGVuaXM6Cj4gVGhlIG9mZnNldCBp
bnRvIHRoZSBhcnJheSB3YXMgc3BlY2lmaWVkIGluIGJ5dGVzIGJ1dCBzaG91bGQKPiBiZSBpbiB0
ZXJtcyBvZiAzMi1iaXQgd29yZHMuICBBbHNvIHByZXZlbnQgbGFyZ2UgcmVhZHMgdGhhdAo+IHdv
dWxkIGFsc28gY2F1c2UgYSBidWZmZXIgb3ZlcnJlYWQuCj4KPiBTaWduZWQtb2ZmLWJ5OiBUb20g
U3QgRGVuaXMgPHRvbS5zdGRlbmlzQGFtZC5jb20+CgpBY2tlZC1ieTogQ2hyaXN0aWFuIEvDtm5p
ZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPgoKPiAtLS0KPiAgIGRyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L2FtZGdwdV9kZWJ1Z2ZzLmMgfCA0ICsrLS0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAy
IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2RlYnVnZnMuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L2FtZGdwdV9kZWJ1Z2ZzLmMKPiBpbmRleCBjNTczZWRmMDJhZmMuLmUwZjRjY2Q5MWZk
NCAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGVidWdm
cy5jCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2RlYnVnZnMuYwo+
IEBAIC03ODMsMTEgKzc4MywxMSBAQCBzdGF0aWMgc3NpemVfdCBhbWRncHVfZGVidWdmc19ncHJf
cmVhZChzdHJ1Y3QgZmlsZSAqZiwgY2hhciBfX3VzZXIgKmJ1ZiwKPiAgIAlzc2l6ZV90IHJlc3Vs
dCA9IDA7Cj4gICAJdWludDMyX3Qgb2Zmc2V0LCBzZSwgc2gsIGN1LCB3YXZlLCBzaW1kLCB0aHJl
YWQsIGJhbmssICpkYXRhOwo+ICAgCj4gLQlpZiAoc2l6ZSAmIDMgfHwgKnBvcyAmIDMpCj4gKwlp
ZiAoc2l6ZSA+IDQwOTYgfHwgc2l6ZSAmIDMgfHwgKnBvcyAmIDMpCj4gICAJCXJldHVybiAtRUlO
VkFMOwo+ICAgCj4gICAJLyogZGVjb2RlIG9mZnNldCAqLwo+IC0Jb2Zmc2V0ID0gKnBvcyAmIEdF
Tk1BU0tfVUxMKDExLCAwKTsKPiArCW9mZnNldCA9ICgqcG9zICYgR0VOTUFTS19VTEwoMTEsIDAp
KSAvIDQ7Cj4gICAJc2UgPSAoKnBvcyAmIEdFTk1BU0tfVUxMKDE5LCAxMikpID4+IDEyOwo+ICAg
CXNoID0gKCpwb3MgJiBHRU5NQVNLX1VMTCgyNywgMjApKSA+PiAyMDsKPiAgIAljdSA9ICgqcG9z
ICYgR0VOTUFTS19VTEwoMzUsIDI4KSkgPj4gMjg7CgpfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3Rz
LmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xp
c3RpbmZvL2FtZC1nZngK
