Return-Path: <SRS0=iszZ=JR=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B82FEC433B4
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Apr 2021 20:54:09 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D197613EE
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Apr 2021 20:54:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D197613EE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E9A996E8DE;
	Tue, 20 Apr 2021 20:54:03 +0000 (UTC)
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com
 [IPv6:2607:f8b0:4864:20::332])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 207CD6E8DC
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Apr 2021 20:54:02 +0000 (UTC)
Received: by mail-ot1-x332.google.com with SMTP id
 c8-20020a9d78480000b0290289e9d1b7bcso22982803otm.4
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Apr 2021 13:54:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ffwll.ch; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=+9CzNNo6qK0a1HlYtEKpNdFwMAjOkB4iTQg21q+R7WM=;
 b=M5OqeXLSGbs0qLCBnUQlDT7EKkVC6IVdKYnsavsRAjSQpS6unWZZ5Lw/Z+YOVVuPMM
 2vh3sIx6OicI3o1+i2v0Jzs/HY6zeNSb9Rc/uTIPsJbLJ4T1q36erMS4k063B9T4ISBd
 +/yeUf2u2jWgIq5w35bYOJAze8TTx38AMkAXc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=+9CzNNo6qK0a1HlYtEKpNdFwMAjOkB4iTQg21q+R7WM=;
 b=dBfO12+Ix8zTFI6X1r1csnXHUy4R/Aovp8whylt2tYwjQCPawnNG6jRorF6lFY4D0S
 XvHEmtwo/TktcKqNeTOeKmc/crr1/0zfyFfyMILsOSlMK6U552mT5VLZwIukVfTIp16V
 F/sB0Cp98/UYuNnQRpt1dQFAzL3rID6Rbo8yCXFDc1gHTnaGdP40Zujdh3Pol+Y5l6aB
 VlyDhxhjxjIF2jvYmuaFQPcuyXfUx+LXKWxpJAjO/bNw7nlzr9YSnKCPLgL5Uo+4kALr
 RI1/7kQYDYIBAaBsI/wVTz2kbNoaPyfc9Co3lqIae2AGNJSWeyiPPEXHREEi2bmTngO4
 bTNw==
X-Gm-Message-State: AOAM533CNz6tDxMEY7jTQavgvCzQY3NDkuM4C+7J6dEo7/jRVfBvko6T
 Qa483uyNCovYlxXUy9LBVJTSnNMW6kMYzSHuwwJQxw==
X-Google-Smtp-Source: ABdhPJyrlQs0cmBULqtDtVBa+uZ4Nh42mhpyBDtmuX2s2RBgQeDtV1C9YydrikuGmRegoZJX6KgDX4zN9n0FDdgVmkE=
X-Received: by 2002:a05:6830:2103:: with SMTP id
 i3mr1493179otc.303.1618952041398; 
 Tue, 20 Apr 2021 13:54:01 -0700 (PDT)
MIME-Version: 1.0
References: <20210416133146.24825-1-tzimmermann@suse.de>
 <20210416133146.24825-6-tzimmermann@suse.de>
 <b7008944-fbe5-bd59-d2a9-ff62bea38237@gmail.com>
 <80012c09-6975-f694-420f-72b2236dcf4e@amd.com>
 <52403618-62f5-2085-c245-e1e98762cccb@suse.de>
 <YH6WJ0p2jGd3Q5Xw@phenom.ffwll.local>
 <a76b44d2-d894-ab4e-ef37-f0feb4326297@amd.com>
In-Reply-To: <a76b44d2-d894-ab4e-ef37-f0feb4326297@amd.com>
From: Daniel Vetter <daniel@ffwll.ch>
Date: Tue, 20 Apr 2021 22:53:50 +0200
Message-ID: <CAKMK7uGmR_US-fy1GTWF4jCnCiRofyDrrJP1qFrE2CKLWbTXBA@mail.gmail.com>
Subject: Re: [PATCH v3 5/7] drm/vmwgfx: Inline ttm_bo_mmap() into vmwgfx driver
To: Felix Kuehling <felix.kuehling@amd.com>
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
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>, "Sharma,
 Shashank" <shashank.sharma@amd.com>, Dave Airlie <airlied@linux.ie>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 Roland Scheidegger <sroland@vmware.com>, Nirmoy Das <nirmoy.das@amd.com>,
 dri-devel <dri-devel@lists.freedesktop.org>, Huang Rui <ray.huang@amd.com>,
 VMware Graphics <linux-graphics-maintainer@vmware.com>,
 Ben Skeggs <bskeggs@redhat.com>, Thomas Zimmermann <tzimmermann@suse.de>,
 Nouveau Dev <nouveau@lists.freedesktop.org>,
 Alex Deucher <alexander.deucher@amd.com>, Sam Ravnborg <sam@ravnborg.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Zack Rusin <zackr@vmware.com>, Emil Velikov <emil.velikov@collabora.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gVHVlLCBBcHIgMjAsIDIwMjEgYXQgMTA6MjMgUE0gRmVsaXggS3VlaGxpbmcgPGZlbGl4Lmt1
ZWhsaW5nQGFtZC5jb20+IHdyb3RlOgo+Cj4KPiBBbSAyMDIxLTA0LTIwIHVtIDQ6NTEgYS5tLiBz
Y2hyaWViIERhbmllbCBWZXR0ZXI6Cj4gPj4+IFdob2xlIHNlcmllcyBpcyBSZXZpZXdlZC1ieTog
Q2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPgo+ID4+IFRoYW5rcyBh
IGxvdC4gSWYgSSdtIG5vdCBtaXN0YWtlbiwgdGhlIHBhdGNoZXMgYXQgWzFdIG5lZWQgdG8gZ28g
aW4gZmlyc3QuCj4gPj4gU28gaXQgY291bGQgdGFrZSBhIGEgYml0IHVudGlsIHRoaXMgbGFuZHMu
Cj4gPj4KPiA+PiBPdGhlcndpc2UsIHRoaXMgc2VyaWVzIGNvdWxkIGdvIHRocm91Z2ggdGhlIHNh
bWUgdHJlZSBhcyBbMV0gaWYgbm91dmVhdSBhbmQKPiA+PiB2bXdnZnggZGV2cyBkb24ndCBtaW5k
Lgo+ID4gSSB3b3VsZCBsYW5kIGl0IGFsbCB0aHJvdWdoIGRybS1taXNjLW5leHQuIE1heWJlIGNo
ZWNrIHdpdGggQWxleCBvbiBpcmMKPiA+IGZvciBhbiBhY2sgZm9yIG1lcmdpbmcgdGhhdCB3YXks
IGJ1dCBJIGRvbid0IHRoaW5rIHRoaXMgd2lsbCBjYXVzZSBpc3N1ZXMKPiA+IGFnYWluc3QgdGhl
IGFtZGdwdSB0cmVlLiBMb3RzIG9mIHR0bSBjbGVhbnVwIGhhcyBsYW5kZWQgdGhpcyB3YXkgYWxy
ZWFkeQo+ID4gcGFzdCBmZXcgbW9udGhzLiBPdGhlcndpc2UgeW91IGNvdWxkIGNyZWF0ZSBhIHNt
YWxsIHRvcGljIGJyYW5jaCB3aXRoCj4gPiB0aGVzZSBwYXRjaGVzIGhlcmUgYW5kIHNlbmQgdGhh
dCB0byBBbGV4LCBhbmQgaGUgY2FuIHNvcnQgb3V0IHRoZQo+ID4gaW50ZXJhY3Rpb24gd2l0aCBG
ZWxpeCcgc2VyaWVzLgo+ID4gLURhbmllbAo+Cj4gTXkgcGF0Y2ggc2VyaWVzIGludm9sdmVkIHNv
bWUgcHJldHR5IGZhci1yZWFjaGluZyBjaGFuZ2VzIGluIEtGRAo+IChyZW5hbWluZyBzb21lIHZh
cmlhYmxlcyBpbiBLRkQgYW5kIGFtZGdwdSwgY2hhbmdpbmcgdGhlIEtGRC0+YW1kZ3B1Cj4gaW50
ZXJmYWNlKS4gV2UgYWxyZWFkeSBzdWJtaXR0ZWQgb3RoZXIgcGF0Y2hlcyBvbiB0b3Agb2YgaXQg
dGhhdCBoYXZlCj4gZGVwZW5kZW5jaWVzIG9uIGl0LiBJZiB3ZSBkZWNpZGUgdG8gZGVsaXZlciB0
aGlzIHRocm91Z2ggYSBkaWZmZXJlbnQKPiB0cmVlIGFuZCByZW1vdmUgaXQgZnJvbSBhbWQtc3Rh
Z2luZy1kcm0tbmV4dCwgdGhlcmUgd2lsbCBiZSBjb25mbGljdHMgdG8KPiByZXNvbHZlIHdoZW4g
cmVtb3ZpbmcgaXQgZnJvbSBhbWQtc3RhZ2luZy1kcm0tbmV4dCwgYW5kIGFnYWluIHRoZSBuZXh0
Cj4gdGltZSB5b3UgbWVyZ2Ugd2l0aCBhbWQtc3RhZ2luZy1kcm0tbmV4dC4KCkFoIHRoZW4gdGhl
IHVzdWFsIHdheSBpcyBmb3IgQWxleCB0byBhc3NlbWJsZSBhIHRvcGljIHB1bGwgcmVxdWVzdAoo
c3RhYmxlLCBub24tcmViYXNpbmcpIHdpdGggdGhvc2Ugc2VsZWN0IHBhdGNoZXMsIHdoaWNoIHRo
ZW4gZ2V0cwptZXJnZWQgaW50byBkcm0tbWlzYy1uZXh0LiBPciB3ZSBzbWFzaCBpdCBhbGwgaW50
byBhbWRncHUtbmV4dC4gT3Igd2UKanVzdCB3YWl0IHVudGlsIC1yYzIgd2hlbiBkcm0tbmV4dCBp
cyBiYWNrIG9wZW4gZm9yIGJ1c2luZXNzLgotRGFuaWVsCi0tIApEYW5pZWwgVmV0dGVyClNvZnR3
YXJlIEVuZ2luZWVyLCBJbnRlbCBDb3Jwb3JhdGlvbgpodHRwOi8vYmxvZy5mZndsbC5jaApfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxp
bmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVk
ZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
