Return-Path: <SRS0=JNIh=LB=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C914CC47082
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Jun 2021 17:18:41 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8839761029
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Jun 2021 17:18:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8839761029
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DC8A46E95F;
	Mon,  7 Jun 2021 17:18:40 +0000 (UTC)
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com
 [IPv6:2607:f8b0:4864:20::22e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 007D36E95E;
 Mon,  7 Jun 2021 17:18:39 +0000 (UTC)
Received: by mail-oi1-x22e.google.com with SMTP id z3so18808108oib.5;
 Mon, 07 Jun 2021 10:18:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=Bs0iIp2b+xLwRPkKeIWpOD/7m4nhQ2yrv+tV+dY2+Dk=;
 b=ZfJqjDRtbPhKwBfzpuNEpxC+DixbiXqh1fDLnKXYnFPI9Qlf1ttw6aMTd691KAb0Nw
 ap3EFjQ+F1P/azkjwjFcJeplW20c8Wy6rjIAmiBeQoqKJH06tOpZ1ZxK8mXwXNZmU4Mx
 z1Zyl6+qqWUh4SVUR92ud5048RIyYmOg+5JJNAI8yoCx9nbMxHazeBm79+GM1fF22BzC
 LSNRJ7TCk9ni35039MOrYp56Cn62e7XcsMy2W6AAr53IWdOXTJY2MN+62tsZ0I+Aeu6R
 He586b00SYq/ywaPZ6ehXU4jLQGpDiMhI0UNYVyK9P/mkSM36+TBm2C58avFcUFUoNH7
 iQdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=Bs0iIp2b+xLwRPkKeIWpOD/7m4nhQ2yrv+tV+dY2+Dk=;
 b=r3hYAcUVCqcpVfUGebT2XfVehWxNqt1cGul5UqWfefrPT4BEYGgUa1wrg7f0K0Yu8G
 LNcqbrJUu5OZwA0lANr2wQ8GIVRdFL+1dX412ZQc7hqJa3pRM3VqUIiv4NH7UHWLw0qm
 LXigxvgzEn7iufZos/DHuzbjTrEqrWcVkOm1odVOkmClmyIGAAtoMlzqFeO3wOpF9twc
 SptQPLh/4WCMuYhn1T1VIt12wYOtVRaPzD5SmyQb3b2/gS0MQaD5hfOrRGR62zHxAzs5
 dZDIezlMVwrFSICNUdzxCBmARLQLe3khW9+9kZ8qHkVxviXmuqnW4ZcJXcdyoJ6LqzZy
 z7vg==
X-Gm-Message-State: AOAM5319nuCNjcnHRHOhtOORWldoEI0iCgsN0MnYSXYlvSW6IYE/UH5N
 adKVpU7K2S3jQ9fPwI/Z1rAYU4y67ZSi2kU9rdg=
X-Google-Smtp-Source: ABdhPJyirKNeUEEtw5y9m++p4gcGiiOq1LOMwU9dlkkw7YMYbr+3rPlg1bL7kJG8ZiRpSn4RBR+dXRzlWAbHbNNqDsM=
X-Received: by 2002:a05:6808:249:: with SMTP id
 m9mr196398oie.120.1623086319382; 
 Mon, 07 Jun 2021 10:18:39 -0700 (PDT)
MIME-Version: 1.0
References: <ea7ecbef546a03ef71d65bfe82608bb347e6f3c2.1622883895.git.christophe.jaillet@wanadoo.fr>
 <99a5eba3-2d2a-65a8-9b03-a3d4043c5ec5@gmail.com>
In-Reply-To: <99a5eba3-2d2a-65a8-9b03-a3d4043c5ec5@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 7 Jun 2021 13:18:28 -0400
Message-ID: <CADnq5_PSw_zLDpdpAgxbUKLH54toLyxL23Ytw0q8G+xBzcaeRQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Fix a a typo in a comment
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
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
Cc: Dave Airlie <airlied@linux.ie>, xinhui pan <Xinhui.Pan@amd.com>,
 kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
 Maling list - DRI developers <dri-devel@lists.freedesktop.org>,
 Daniel Vetter <daniel@ffwll.ch>, "Deucher,
 Alexander" <alexander.deucher@amd.com>,
 Christian Koenig <christian.koenig@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QXBwbGllZC4gIFRoYW5rcyEKCkFsZXgKCk9uIE1vbiwgSnVuIDcsIDIwMjEgYXQgNjo0NiBBTSBD
aHJpc3RpYW4gS8O2bmlnCjxja29lbmlnLmxlaWNodHp1bWVya2VuQGdtYWlsLmNvbT4gd3JvdGU6
Cj4KPiBBbSAwNS4wNi4yMSB1bSAxMTowNiBzY2hyaWViIENocmlzdG9waGUgSkFJTExFVDoKPiA+
IHMvdGhhbi90aGVuLwo+ID4KPiA+IFNpZ25lZC1vZmYtYnk6IENocmlzdG9waGUgSkFJTExFVCA8
Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI+Cj4KPiBBY2tlZC1ieTogQ2hyaXN0aWFuIEvD
tm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPgo+Cj4gPiAtLS0KPiA+ICAgZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2NzLmMgfCAyICstCj4gPiAgIDEgZmlsZSBjaGFuZ2Vk
LCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQo+ID4KPiA+IGRpZmYgLS1naXQgYS9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfY3MuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L2FtZGdwdV9jcy5jCj4gPiBpbmRleCA4OWViYmYzNjNlMjcuLjE0NzYyMzZmNWM3YyAx
MDA2NDQKPiA+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9jcy5jCj4g
PiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfY3MuYwo+ID4gQEAgLTY2
Miw3ICs2NjIsNyBAQCBzdGF0aWMgaW50IGFtZGdwdV9jc19zeW5jX3JpbmdzKHN0cnVjdCBhbWRn
cHVfY3NfcGFyc2VyICpwKQo+ID4gICAgKiBAZXJyb3I6ICBlcnJvciBudW1iZXIKPiA+ICAgICog
QGJhY2tvZmY6ICAgICAgICBpbmRpY2F0b3IgdG8gYmFja29mZiB0aGUgcmVzZXJ2YXRpb24KPiA+
ICAgICoKPiA+IC0gKiBJZiBlcnJvciBpcyBzZXQgdGhhbiB1bnZhbGlkYXRlIGJ1ZmZlciwgb3Ro
ZXJ3aXNlIGp1c3QgZnJlZSBtZW1vcnkKPiA+ICsgKiBJZiBlcnJvciBpcyBzZXQgdGhlbiB1bnZh
bGlkYXRlIGJ1ZmZlciwgb3RoZXJ3aXNlIGp1c3QgZnJlZSBtZW1vcnkKPiA+ICAgICogdXNlZCBi
eSBwYXJzaW5nIGNvbnRleHQuCj4gPiAgICAqKi8KPiA+ICAgc3RhdGljIHZvaWQgYW1kZ3B1X2Nz
X3BhcnNlcl9maW5pKHN0cnVjdCBhbWRncHVfY3NfcGFyc2VyICpwYXJzZXIsIGludCBlcnJvciwK
Pgo+IF9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCj4gYW1k
LWdmeCBtYWlsaW5nIGxpc3QKPiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwo+IGh0dHBz
Oi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeApfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcg
bGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNr
dG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
