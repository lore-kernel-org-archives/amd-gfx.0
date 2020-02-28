Return-Path: <SRS0=XGul=4Q=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE0A7C3F2CF
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Feb 2020 09:19:44 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF56C246A2
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Feb 2020 09:19:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KC9BVoP8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF56C246A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7B7866EE94;
	Fri, 28 Feb 2020 09:19:44 +0000 (UTC)
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com
 [IPv6:2a00:1450:4864:20::341])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4D5286EE94
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Feb 2020 09:19:43 +0000 (UTC)
Received: by mail-wm1-x341.google.com with SMTP id m3so2420209wmi.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Feb 2020 01:19:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=nt5jmmcydPvQ25UcFqukjn8kV5xCkoy+Aqvrqi34IEM=;
 b=KC9BVoP8qDmUJ0bKL1LwVMHXgUqjhoiEOaHEYNg+1RRsDTtAYVrlxCSNlHRITVaRnQ
 Bo0Nz1XuDzEQnIF5bGtsySZ8dFMeKXfyontEgn1/b5je7HTH4iFFtebVwFddB50XEeGD
 fFqlgcCWll4Q8YHGis1bT/kvYf1Ifemzyi16gKui40opqvJKXPVhTSULTYL0T4vxKJlK
 lKK58yYald+oBs5rK1MX6wbjN2odN22e3llyrl1KNDTQywQD+uIUCeok3hHsEv65TLqO
 Yi66cCmpQ3ipg6BoBS4Az7HCM0cz6T/YP5iBaL0bns+bsYaRKN/l79OEOpyadqS//d9s
 1F7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:cc:references:from
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-transfer-encoding:content-language;
 bh=nt5jmmcydPvQ25UcFqukjn8kV5xCkoy+Aqvrqi34IEM=;
 b=LofufMvHcQdjD62Lo4+sH6hdw/LQcuQF57sXpNJL4UGqWPl87298kpVaqc6VOCv3vZ
 8mCp1Csi+55txiAMBW1fDkXawhsjznMo5sVOzawFxJ4FeH2QTr+JnKzu9hcJScEpiz6/
 IkRRlbVP0/PcphpeVRQz8ouFHzjvWlIFVUMOKLpUV3aleJ7qUHl7fvcBH5o7imujZASf
 IYM1xxiASBfUUJSNhOa7VwcGx1ficsCeVU0TJtE0I1K/PeN4oDuaDO7r/5zdURZ0kJZ/
 YaOAn7JOQ4NqW63uYMTfzb83EEn5q145xvutr/jIWGZJDTCezeIUvZowbs5vo9Tgww82
 2yQw==
X-Gm-Message-State: APjAAAUg5PLjIsKXdgZhlcccRGnLecUax4JGjuybv8ik4dnFgOZxQ+AI
 Ocnhrj887ICc0BsFHZ9E9zS3lnxv
X-Google-Smtp-Source: APXvYqxBOQ+Xa5Ukc4xLapwYbERHGjY2Z/vbRKzcHXY0w5WasncOKX00HueQk5ltHeyDUKsu2O/5gw==
X-Received: by 2002:a05:600c:2257:: with SMTP id
 a23mr3821672wmm.15.1582881581713; 
 Fri, 28 Feb 2020 01:19:41 -0800 (PST)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7?
 ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
 by smtp.gmail.com with ESMTPSA id z8sm11137185wrv.74.2020.02.28.01.19.40
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 28 Feb 2020 01:19:41 -0800 (PST)
Subject: Re: [PATCH] drm/amdgpu: clean wptr on wb when gpu recovery
To: Yintian Tao <yttao@amd.com>, christian.koenig@amd.com,
 Alexander.Deucher@amd.com, "monk.liu" <monk.liu@amd.com>
References: <20200228063131.2630-1-yttao@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <fd5c5d29-285d-ab18-b0b4-ca2540e456c2@gmail.com>
Date: Fri, 28 Feb 2020 10:19:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200228063131.2630-1-yttao@amd.com>
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
Cc: amd-gfx@lists.freedesktop.org
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QW0gMjguMDIuMjAgdW0gMDc6MzEgc2NocmllYiBZaW50aWFuIFRhbzoKPiBUaGUgVERSIHdpbGwg
YmUgcmFuZG9tbHkgZmFpbGVkIGR1ZSB0byBjb21wdXRlIHJpbmcKPiB0ZXN0IGZhaWx1cmUuIElm
IHRoZSBjb21wdXRlIHJpbmcgd3B0ciAmIDB4N2ZmKHJpbmdfYnVmX21hc2spCj4gaXMgMHgxMDAg
dGhlbiBhZnRlciBtYXAgbXFkIHRoZSBjb21wdXRlIHJpbmcgcnB0ciB3aWxsIGJlCj4gc3luY2Vk
IHdpdGggMHgxMDAuIEFuZCB0aGUgcmluZyB0ZXN0IHBhY2tldCBzaXplIGlzIGFsc28gMHgxMDAu
Cj4gVGhlbiBhZnRlciBpbnZvY2F0aW9uIG9mIGFtZGdwdV9yaW5nX2NvbW1pdCwgdGhlIGNwIHdp
bGwgbm90Cj4gcmVhbGx5IGhhbmRsZSB0aGUgcGFja2V0IG9uIHRoZSByaW5nIGJ1ZmZlciBiZWNh
dXNlIHJwdHIgaXMgZXF1YWwgdG8gd3B0ci4KPgo+IFNpZ25lZC1vZmYtYnk6IFlpbnRpYW4gVGFv
IDx5dHRhb0BhbWQuY29tPgoKT2YgaGFuZCB0aGF0IGxvb2tzIGNvcnJlY3QgdG8gbWUsIGJ1dCBJ
IGNhbid0IGZ1bGx5IGp1ZGdlIGlmIHRoYXQgd29uJ3QgCmhhdmUgYW55IG5lZ2F0aXZlIHNpZGUg
ZWZmZWN0cy4gUGF0Y2ggaXMgQWNrZWQtYnk6IENocmlzdGlhbiBLw7ZuaWcgCjxjaHJpc3RpYW4u
a29lbmlnQGFtZC5jb20+IGZvciBub3cuCgpNb25rIGFjY29yZGluZyB0byBnaXQgeW91IG1vZGlm
aWVkIHRoYXQgZnVuY3Rpb24gYXMgd2VsbC4gQ291bGQgdGhpcyAKaGF2ZSBhbnkgcG90ZW50aWFs
IG5lZ2F0aXZlIGVmZmVjdCBmb3IgU1JJT1Y/IEkgZG9uJ3QgdGhpbmsgc28sIGJ1dCAKYmV0dGVy
IHNhdmUgdGhhbiBzb3JyeS4KClJlZ2FyZHMsCkNocmlzdGlhbi4KCj4gLS0tCj4gICBkcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjEwXzAuYyB8IDEgKwo+ICAgZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvZ2Z4X3Y5XzAuYyAgfCAxICsKPiAgIDIgZmlsZXMgY2hhbmdlZCwgMiBpbnNl
cnRpb25zKCspCj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4
X3YxMF8wLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjEwXzAuYwo+IGluZGV4
IDQ0ZjAwZWNlYTMyMi4uNWRmMWE2ZDQ1NDU3IDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2dmeF92MTBfMC5jCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvZ2Z4X3YxMF8wLmMKPiBAQCAtMzUwOCw2ICszNTA4LDcgQEAgc3RhdGljIGludCBnZnhfdjEw
XzBfa2NxX2luaXRfcXVldWUoc3RydWN0IGFtZGdwdV9yaW5nICpyaW5nKQo+ICAgCj4gICAJCS8q
IHJlc2V0IHJpbmcgYnVmZmVyICovCj4gICAJCXJpbmctPndwdHIgPSAwOwo+ICsJCWF0b21pYzY0
X3NldCgoYXRvbWljNjRfdCAqKSZhZGV2LT53Yi53YltyaW5nLT53cHRyX29mZnNdLCAwKTsKPiAg
IAkJYW1kZ3B1X3JpbmdfY2xlYXJfcmluZyhyaW5nKTsKPiAgIAl9IGVsc2Ugewo+ICAgCQlhbWRn
cHVfcmluZ19jbGVhcl9yaW5nKHJpbmcpOwo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9nZnhfdjlfMC5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3Y5
XzAuYwo+IGluZGV4IDQxMzVlNDEyNmU4Mi4uYWMyMjQ5MGU4NjU2IDEwMDY0NAo+IC0tLSBhL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92OV8wLmMKPiArKysgYi9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9nZnhfdjlfMC5jCj4gQEAgLTM2NjQsNiArMzY2NCw3IEBAIHN0YXRpYyBp
bnQgZ2Z4X3Y5XzBfa2NxX2luaXRfcXVldWUoc3RydWN0IGFtZGdwdV9yaW5nICpyaW5nKQo+ICAg
Cj4gICAJCS8qIHJlc2V0IHJpbmcgYnVmZmVyICovCj4gICAJCXJpbmctPndwdHIgPSAwOwo+ICsJ
CWF0b21pYzY0X3NldCgoYXRvbWljNjRfdCAqKSZhZGV2LT53Yi53YltyaW5nLT53cHRyX29mZnNd
LCAwKTsKPiAgIAkJYW1kZ3B1X3JpbmdfY2xlYXJfcmluZyhyaW5nKTsKPiAgIAl9IGVsc2Ugewo+
ICAgCQlhbWRncHVfcmluZ19jbGVhcl9yaW5nKHJpbmcpOwoKX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBs
aXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1h
bi9saXN0aW5mby9hbWQtZ2Z4Cg==
