Return-Path: <SRS0=4HPi=KF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38D3DC43462
	for <amd-gfx@archiver.kernel.org>; Mon, 10 May 2021 21:02:49 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C7F73613DF
	for <amd-gfx@archiver.kernel.org>; Mon, 10 May 2021 21:02:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7F73613DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 71A7E6E8F3;
	Mon, 10 May 2021 21:02:46 +0000 (UTC)
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com
 [IPv6:2607:f8b0:4864:20::334])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BFA6E6E8F1;
 Mon, 10 May 2021 21:02:44 +0000 (UTC)
Received: by mail-ot1-x334.google.com with SMTP id
 q7-20020a9d57870000b02902a5c2bd8c17so15706803oth.5; 
 Mon, 10 May 2021 14:02:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=3cBBZkePd5gfKATN60V4QwGBhUGNtLUNcw+1xoOiiZs=;
 b=S2lsNjatPX3UKOV5pkxnIgd2tRdEDE1F/mJYBW1mBH0XTLW23kTgYMfvEuqFgWgCcG
 GpeN7skQ8HRDLyzonMznUF4k4KFu9cRWv9zQBbCtBdxybb7lS7+cyIM8ceLQvVpqebto
 Ta+XIA3rtvSzNn4QMP/U5sGbl11s41Entls7NMUUyS7wgK8ENv7EKgBBvrS2SLGEeu/q
 d1IQpmZRoZCDXEKRI0odbDo0kwhcdmT8MQOmT+KdCYBwpXFOZgoUV4JgLhmcnri/7V1S
 Spb/pP0HPKxZnPu9b/Ufuha9NG2NpU2UJiquIBsEYYnlWwNWoBWkSs0Wbz2Mx2SUicRq
 3rdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=3cBBZkePd5gfKATN60V4QwGBhUGNtLUNcw+1xoOiiZs=;
 b=VbbplB+RIXjxMIA7j7/1JW3hwOkgKQaMWNHrQS/2awiOl+JyXh3ew3i2283UIyzmc0
 gHWfTIbAikI6EHsBPWwgCXGw/su4AzbcvBec9mneOBxODxJcdSbYPMBjOU4Xr/ofu/KS
 nfMQV1xyTqknV9vV6z/VwneNi/vEtofAdb2tcirHw+lbKie3WqLkazbFtyrxLoy86NDv
 tYHzuxsLYu+FhL8VpM8fjnagv4lwOWiTYm8dJ4Gtv/381U2/EpsVXBYxDoL3KDRLVi5A
 zpB2YFogyoH2gjZPkA4m2It687Z8+AW/yZ+cUnluzdWGVau6z2nrJjfgwKYz9OIU51Xl
 WhFA==
X-Gm-Message-State: AOAM530opQqLXN513XocSSCuMklD3dU3KxQcE74aoroh4HVF0b4p3TLO
 XYth/IFT33VTEJVMlcVi4v9hzz72SD4Yk5sP1lQ=
X-Google-Smtp-Source: ABdhPJw7DyKD1Lyyq9S41EMv+Yyu/ErA9AViQoXtkzjglGNF7HKdlfnp86mEla//UDe5eTZlAP0X/kMW5Kco3byONpk=
X-Received: by 2002:a9d:51c6:: with SMTP id d6mr16637610oth.311.1620680564170; 
 Mon, 10 May 2021 14:02:44 -0700 (PDT)
MIME-Version: 1.0
References: <20210509144923.6316-1-dwaipayanray1@gmail.com>
 <2c5387b7-2fa1-9b5a-c671-806429b463aa@amd.com>
In-Reply-To: <2c5387b7-2fa1-9b5a-c671-806429b463aa@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 10 May 2021 17:02:32 -0400
Message-ID: <CADnq5_NXXD1K6kb0Jr8P5DPGcHRMo0jQTC+y2n4-4sfZY12pyA@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/amdgpu: Fix errors in function documentation
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
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
Cc: Dave Airlie <airlied@linux.ie>, Dwaipayan Ray <dwaipayanray1@gmail.com>,
 LKML <linux-kernel@vger.kernel.org>,
 Maling list - DRI developers <dri-devel@lists.freedesktop.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>, Daniel Vetter <daniel@ffwll.ch>,
 "Deucher, Alexander" <alexander.deucher@amd.com>,
 Lukas Bulwahn <lukas.bulwahn@gmail.com>,
 linux-media <linux-media@vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QXBwbGllZC4gIFRoYW5rcyEKCkFsZXgKCk9uIFN1biwgTWF5IDksIDIwMjEgYXQgMTI6MzAgUE0g
Q2hyaXN0aWFuIEvDtm5pZwo8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPiB3cm90ZToKPgo+IEFt
IDA5LjA1LjIxIHVtIDE2OjQ5IHNjaHJpZWIgRHdhaXBheWFuIFJheToKPiA+IEZpeCBhIGNvdXBs
ZSBvZiBzeW50YXggZXJyb3JzIGFuZCByZW1vdmVkIG9uZSBleGNlc3MKPiA+IHBhcmFtZXRlciBp
biB0aGUgZnVuY3Rpb24gZG9jdW1lbnRhdGlvbnMgd2hpY2ggbGVhZAo+ID4gdG8ga2VybmVsIGRv
Y3MgYnVpbGQgd2FybmluZy4KPiA+Cj4gPiBTaWduZWQtb2ZmLWJ5OiBEd2FpcGF5YW4gUmF5IDxk
d2FpcGF5YW5yYXkxQGdtYWlsLmNvbT4KPgo+IFJldmlld2VkLWJ5OiBDaHJpc3RpYW4gS8O2bmln
IDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+Cj4KPiA+IC0tLQo+ID4gICBkcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9hbWRncHVfcmFzLmMgfCAzICsrKwo+ID4gICBkcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9hbWRncHVfdm0uYyAgfCAxIC0KPiA+ICAgMiBmaWxlcyBjaGFuZ2VkLCAzIGlu
c2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkKPiA+Cj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Jhcy5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvYW1kZ3B1X3Jhcy5jCj4gPiBpbmRleCBhZTlmYjIwMjUyNTkuLjMxMmYyNDAwNDQxMyAxMDA2
NDQKPiA+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9yYXMuYwo+ID4g
KysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Jhcy5jCj4gPiBAQCAtMzIw
LDExICszMjAsMTQgQEAgc3RhdGljIGludCBhbWRncHVfcmFzX2RlYnVnZnNfY3RybF9wYXJzZV9k
YXRhKHN0cnVjdCBmaWxlICpmLAo+ID4gICAgKiAiZGlzYWJsZSIgcmVxdWlyZXMgb25seSB0aGUg
YmxvY2suCj4gPiAgICAqICJlbmFibGUiIHJlcXVpcmVzIHRoZSBibG9jayBhbmQgZXJyb3IgdHlw
ZS4KPiA+ICAgICogImluamVjdCIgcmVxdWlyZXMgdGhlIGJsb2NrLCBlcnJvciB0eXBlLCBhZGRy
ZXNzLCBhbmQgdmFsdWUuCj4gPiArICoKPiA+ICAgICogVGhlIGJsb2NrIGlzIG9uZSBvZjogdW1j
LCBzZG1hLCBnZngsIGV0Yy4KPiA+ICAgICogIHNlZSByYXNfYmxvY2tfc3RyaW5nW10gZm9yIGRl
dGFpbHMKPiA+ICsgKgo+ID4gICAgKiBUaGUgZXJyb3IgdHlwZSBpcyBvbmUgb2Y6IHVlLCBjZSwg
d2hlcmUsCj4gPiAgICAqICB1ZSBpcyBtdWx0aS11bmNvcnJlY3RhYmxlCj4gPiAgICAqICBjZSBp
cyBzaW5nbGUtY29ycmVjdGFibGUKPiA+ICsgKgo+ID4gICAgKiBUaGUgc3ViLWJsb2NrIGlzIGEg
dGhlIHN1Yi1ibG9jayBpbmRleCwgcGFzcyAwIGlmIHRoZXJlIGlzIG5vIHN1Yi1ibG9jay4KPiA+
ICAgICogVGhlIGFkZHJlc3MgYW5kIHZhbHVlIGFyZSBoZXhhZGVjaW1hbCBudW1iZXJzLCBsZWFk
aW5nIDB4IGlzIG9wdGlvbmFsLgo+ID4gICAgKgo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
YW1kZ3B1X3ZtLmMKPiA+IGluZGV4IDE2MjUyZDQ4ZTVhNC4uN2UxYTY3Mjk1MTA2IDEwMDY0NAo+
ID4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtLmMKPiA+ICsrKyBi
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5jCj4gPiBAQCAtMjc5Niw3ICsy
Nzk2LDYgQEAgbG9uZyBhbWRncHVfdm1fd2FpdF9pZGxlKHN0cnVjdCBhbWRncHVfdm0gKnZtLCBs
b25nIHRpbWVvdXQpCj4gPiAgICAqCj4gPiAgICAqIEBhZGV2OiBhbWRncHVfZGV2aWNlIHBvaW50
ZXIKPiA+ICAgICogQHZtOiByZXF1ZXN0ZWQgdm0KPiA+IC0gKiBAdm1fY29udGV4dDogSW5kaWNh
dGVzIGlmIGl0IEdGWCBvciBDb21wdXRlIGNvbnRleHQKPiA+ICAgICogQHBhc2lkOiBQcm9jZXNz
IGFkZHJlc3Mgc3BhY2UgaWRlbnRpZmllcgo+ID4gICAgKgo+ID4gICAgKiBJbml0IEB2bSBmaWVs
ZHMuCj4KPiBfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwo+
IGFtZC1nZnggbWFpbGluZyBsaXN0Cj4gYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKPiBo
dHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngKX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWls
aW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVl
ZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
