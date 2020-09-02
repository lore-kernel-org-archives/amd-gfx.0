Return-Path: <SRS0=4FJE=CL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7AD8C433E7
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Sep 2020 14:31:44 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA3D720767
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Sep 2020 14:31:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ki5T3hj+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA3D720767
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 560C66E4B5;
	Wed,  2 Sep 2020 14:31:44 +0000 (UTC)
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com
 [IPv6:2a00:1450:4864:20::343])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E81926E4B5
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Sep 2020 14:31:42 +0000 (UTC)
Received: by mail-wm1-x343.google.com with SMTP id e11so3294492wme.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 02 Sep 2020 07:31:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=1XoDRUJXucTYm9J+uL224y2+aXIJJnOgQqVfBc2N1V0=;
 b=ki5T3hj+Tjirb9S5hhS2Gu11Xj7/MHIqLXvOR3Qnpeh6iS0jis6gbUdmPr3ojWhL3x
 rDmVmOD3KLd5mW+hOhrs1BYOXldIfLJ7I9DaCDkidCOJXJhmtHoRszIWpTC6MHqefdH+
 vzMtM8OSwCefEOecjGZRBU+RQnmZJqJbfjnfocpvJT4VmU2FAnaElBdWl9Jz+JjhhXuP
 +56DObgO1CagpR4zl+h4pNqjcLQDxGRWXUq0+/CQ3rkOXTb7Gl0JORqnuAz8Kns9E2rP
 3PKp7QMfrROt75L0MY8UzHZUf76sdEymNqvCtWgRDbCksnwpCSrhLPHILM7TRdhAqTaR
 rtzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:cc:references:from
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-transfer-encoding:content-language;
 bh=1XoDRUJXucTYm9J+uL224y2+aXIJJnOgQqVfBc2N1V0=;
 b=bae237oy0xSVkWwKpLOeD1SBa5V0Olk3DZePuZQdkhwAURGDSC2G8FICN59d3lCDlr
 WAiyxSLe1O+n44msUK5pUEbCc3hdTpqj24hspHo3YymAnc0SDI5aaDfjIuwzjue64edm
 QL4lFGI4pP2GchBhDCge+Pab90YnfSBMzdXVR0Z64TEioSlFnlSJbMia6xs969w4SjXn
 q//xbpya3jrmOx0wVFCwlnu4Z4VeiDdEsnyg7W7Q+x3UCK6vu5p21+SYdFDLzHREzfYu
 LUJwBiutcBBu643Mo/tKS8e3C1sRtLsjNJdR9bqxuDTv1yUJaJKSvWhzRECTVR/lY8V+
 2Yrg==
X-Gm-Message-State: AOAM531yfkkP3y/Ejpv+aurJ/1FQYAwtHqwCHULWdVnek6Og2mkbwtjD
 nAtPhugi/KxEJ/XjlM4WglOmFkkFKnU=
X-Google-Smtp-Source: ABdhPJyPaUGPKPAKm4mv+kiED9hRwbsv2dzQjecp11SBA03HDbrRIxGn7hw3By/1oK5sEvCm1ZSRJg==
X-Received: by 2002:a1c:5a87:: with SMTP id o129mr967231wmb.145.1599057101339; 
 Wed, 02 Sep 2020 07:31:41 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7?
 ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
 by smtp.gmail.com with ESMTPSA id c4sm7730085wrp.85.2020.09.02.07.31.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Sep 2020 07:31:40 -0700 (PDT)
Subject: Re: [PATCH] drm/amdgpu: fix max_entries calculation v2
To: "Pan, Xinhui" <Xinhui.Pan@amd.com>
References: <20200902140512.2343-1-christian.koenig@amd.com>
 <32A985F3-1C3B-45E4-B90F-7C023CCE7B71@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <98a58d52-81a3-c7de-f848-e612c1f52e59@gmail.com>
Date: Wed, 2 Sep 2020 16:31:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <32A985F3-1C3B-45E4-B90F-7C023CCE7B71@amd.com>
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
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QW0gMDIuMDkuMjAgdW0gMTY6Mjcgc2NocmllYiBQYW4sIFhpbmh1aToKPgo+PiAyMDIw5bm0Oeac
iDLml6UgMjI6MDXvvIxDaHJpc3RpYW4gS8O2bmlnIDxja29lbmlnLmxlaWNodHp1bWVya2VuQGdt
YWlsLmNvbT4g5YaZ6YGT77yaCj4+Cj4+IENhbGN1bGF0ZSB0aGUgY29ycmVjdCB2YWx1ZSBmb3Ig
bWF4X2VudHJpZXMgb3Igd2UgbWlnaHQgcnVuIGFmdGVyIHRoZQo+PiBwYWdlX2FkZHJlc3MgYXJy
YXkuCj4+Cj4+IHYyOiBYaW5odWkgcG9pbnRlZCBvdXQgd2UgZG9uJ3QgbmVlZCB0aGUgc2hpZnQK
Pj4KPj4gU2lnbmVkLW9mZi1ieTogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0Bh
bWQuY29tPgo+PiBGaXhlczogMWU2OTFlMjQ0NDg3IGRybS9hbWRncHU6IHN0b3AgYWxsb2NhdGlu
ZyBkdW1teSBHVFQgbm9kZXMKPj4gLS0tCj4+IGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2Ft
ZGdwdV92bS5jIHwgMiArLQo+PiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVs
ZXRpb24oLSkKPj4KPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2Ft
ZGdwdV92bS5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtLmMKPj4gaW5k
ZXggOGJjMjI1MzkzOWJlLi5iZTg4NmJkY2E1YzYgMTAwNjQ0Cj4+IC0tLSBhL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5jCj4+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L2FtZGdwdV92bS5jCj4+IEBAIC0xNjk3LDcgKzE2OTcsNyBAQCBzdGF0aWMgaW50IGFt
ZGdwdV92bV9ib19zcGxpdF9tYXBwaW5nKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LAo+PiAJ
CQkJQU1ER1BVX0dQVV9QQUdFU19JTl9DUFVfUEFHRTsKPj4gCQl9IGVsc2Ugewo+PiAJCQlhZGRy
ID0gMDsKPj4gLQkJCW1heF9lbnRyaWVzID0gUzY0X01BWDsKPj4gKwkJCW1heF9lbnRyaWVzID0g
bWFwcGluZy0+bGFzdCAtIG1hcHBpbmctPnN0YXJ0ICsgMTsKPiBZb3UgbmVlZCBtaW51cyBwZm4g
aGVyZS4KClRoYXQgZG9lc24ndCBzb3VuZCBjb3JyZWN0IGVpdGhlci4gVGhlIHBmbiBpcyB0aGUg
ZGVzdGluYXRpb24gb2YgdGhlIAptYXBwaW5nLCBlLmcuIHRoZSBvZmZzZXQgaW5zaWRlIHRoZSBC
TyBhbmQgbm90IHJlbGF0ZWQgdG8gdGhlIHZpcnR1YWwgCmFkZHJlc3MgcmFuZ2Ugd2UgbWFwLgoK
PiBUaGUgcmFuZ2Ugd2UgYXJlIGdvaW5nIHRvIHRvdWNoIGlzIFtzdGFydCArIG9mZnNldCwgbGFz
dF0uCj4gc28gdGhlIG1heF9lbnRyaWVzIGlzIGxhc3QgLSAoc3RhcnQgKyBvZmZzZXQpICsgMS4g
YW5kIG9mZnNldCBpcyBwZm4gaW4gdGhpcyBjYXNlLgo+Cj4gSSBzdGlsbCBoaXQgcGFuaWMgd2l0
aCB0aGlzIHBhdGNoIGluIHByYWN0aWNlLgoKVGhhbmtzIGZvciB0ZXN0aW5nLCBJIHRoaW5rIEkg
a25vdyB3aGF0IHRoZSBwcm9ibGVtIGlzLgoKV2UgbmVlZCB0byBzdGFydCBpbnN0ZWFkIG9mIG1h
cHBpbmctPnN0YXJ0IG9yIG90aGVyd2lzZSB0aGUgdmFsdWVzIGlzIHRvIApsYXJnZSBhZnRlciB0
aGUgZmlyc3QgaXRlcmF0aW9uLgoKR2l2ZSBtZSBhIHNlY29uZCBmb3IgYSB2My4KCkNocmlzdGlh
bi4KCj4KPj4gCQl9Cj4+Cj4+IAkJaWYgKHBhZ2VzX2FkZHIpIHsKPj4gLS0gCj4+IDIuMTcuMQo+
PgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdm
eCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0
cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
