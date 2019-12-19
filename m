Return-Path: <SRS0=793y=2J=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3986BC43603
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Dec 2019 17:11:38 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0DC2E24672
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Dec 2019 17:11:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="lQ/Xfr7L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DC2E24672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=umn.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BC2B06E392;
	Thu, 19 Dec 2019 17:11:37 +0000 (UTC)
Received: from mta-p5.oit.umn.edu (mta-p5.oit.umn.edu [134.84.196.205])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7828B6E392
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Dec 2019 17:06:55 +0000 (UTC)
Received: from localhost (unknown [127.0.0.1])
 by mta-p5.oit.umn.edu (Postfix) with ESMTP id 47dywG6N01z9vbYM
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Dec 2019 17:06:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p5.oit.umn.edu ([127.0.0.1])
 by localhost (mta-p5.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id xCxt7P7kJNHI for <amd-gfx@lists.freedesktop.org>;
 Thu, 19 Dec 2019 11:06:54 -0600 (CST)
Received: from mail-yb1-f200.google.com (mail-yb1-f200.google.com
 [209.85.219.200])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mta-p5.oit.umn.edu (Postfix) with ESMTPS id 47dywG54rRz9vbXv
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Dec 2019 11:06:54 -0600 (CST)
Received: by mail-yb1-f200.google.com with SMTP id w201so4571825ybg.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Dec 2019 09:06:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=umn.edu; s=google;
 h=subject:to:cc:references:from:in-reply-to:message-id:date
 :user-agent:mime-version:content-language:content-transfer-encoding;
 bh=khlYaPbWIWU3Yw95Dv5xQPpS+EL00uRq9R+bfqtQfGE=;
 b=lQ/Xfr7LFusZOGaK6IzuJQXJfpzY5VP4sHGkSbgquKqc5U9vVmLPvuMpuHFe0rmkHd
 410E0V22Aq8PUHS+gMcuU5IrhzAhsrzskBv0ZFGzYbLczWUp6pwNza4sFn8/39wiGCAf
 W+KPjBv+hZJA8Xn0dGn7sjElyzzPcorZn6ej2l9UP/LNUGvryzSy0+p3ENL2NIoTKSk3
 r7wfXVYwL/TTG8Co+Xq2bykhRbdlc2wVgHOPL1YxAHYWY+MQSwK1Pn7u3VDOXZw2+3Jv
 G0JiALuby9+UBdQ3FZesNPTJrhU7A02RVwnX/XeyaRbV8BU74U5NYn7flFV+hrrrsx1K
 m2dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:in-reply-to
 :message-id:date:user-agent:mime-version:content-language
 :content-transfer-encoding;
 bh=khlYaPbWIWU3Yw95Dv5xQPpS+EL00uRq9R+bfqtQfGE=;
 b=NOi81OcuFpVuz87BKeZWlFpZ8mlpdV/akTrLQZJDgnfyjFGWoLLeQ6b9dhs/y4OJDb
 HEkxhV4zMHuobmuFDIodyMKCQeg2Ru+uITiLZOKkTI+BlVi3PUo2PRu8ZLqB7qogTAGx
 cY6xH+KnDT4Yb81qilCZvHzmxHTHNgylLGICHrhhVUoy+wllAiQVt7FORe34Pk/PuCnt
 ICj25gZopVVmBetc7tM0kpzt5Auc05HMvg4nMIQidRDYLn9bklmrmyjX0qd2/2kBuNLp
 3qgboh+zidvHdiXAE5CndFfXz402FjgdqDYl1skDTcdIf0/dsLwr1P+Pz3g/acE99D9J
 wkdQ==
X-Gm-Message-State: APjAAAXiQHL9m+w7Yb47kcm61X9qhlx1bsrKVxOckDkFzfcQDBbsA+Y1
 qNmjyhNtWCjT2i33Ul85eX/5GOscd5xzXZAMVTFjaXkXWIJraALT6wJ8owEjurdQNN1r06y8Dv2
 EuvAsK8X+y1nbqiqLVfeyRV79JQ20AA==
X-Received: by 2002:a25:5984:: with SMTP id n126mr2353399ybb.347.1576775213888; 
 Thu, 19 Dec 2019 09:06:53 -0800 (PST)
X-Google-Smtp-Source: APXvYqzd996EJBbEY6a2F54855tl8zzwzeowj+d2Jd91rW95pAhUsAcgUXSwRnIh8w0xA9uNbZGCjw==
X-Received: by 2002:a25:5984:: with SMTP id n126mr2353355ybb.347.1576775213425; 
 Thu, 19 Dec 2019 09:06:53 -0800 (PST)
Received: from [128.101.106.66] (cs-u-syssec1.cs.umn.edu. [128.101.106.66])
 by smtp.gmail.com with ESMTPSA id h23sm2569757ywc.105.2019.12.19.09.06.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Dec 2019 09:06:52 -0800 (PST)
Subject: Re: [PATCH] drm/amd/display: replace BUG_ON with WARN_ON
To: Mikita Lipski <mlipski@amd.com>
References: <20191218161505.13416-1-pakki001@umn.edu>
 <d963ed6f-4ced-cc9d-6612-8720ed9d2c41@amd.com>
From: Aditya Pakki <pakki001@umn.edu>
In-Reply-To: <d963ed6f-4ced-cc9d-6612-8720ed9d2c41@amd.com>
Message-ID: <cb5b4d65-4a56-8fa4-5be4-c9ff5a2bf4e3@umn.edu>
Date: Thu, 19 Dec 2019 11:06:51 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
Content-Language: en-US
X-Mailman-Approved-At: Thu, 19 Dec 2019 17:11:37 +0000
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
Cc: "David \(ChunMing\) Zhou" <David1.Zhou@amd.com>,
 Mario Kleiner <mario.kleiner.de@gmail.com>, Leo Li <sunpeng.li@amd.com>,
 Harry Wentland <harry.wentland@amd.com>, David Francis <David.Francis@amd.com>,
 kjlu@umn.edu, linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org,
 Daniel Vetter <daniel@ffwll.ch>, Alex Deucher <alexander.deucher@amd.com>,
 Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gMTIvMTkvMTkgMTA6MjkgQU0sIE1pa2l0YSBMaXBza2kgd3JvdGU6Cj4gCj4gCj4gT24gMTIv
MTgvMTkgMTE6MTUgQU0sIEFkaXR5YSBQYWtraSB3cm90ZToKPj4gSW4gc2tpcF9tb2Rlc2V0IGxh
YmVsIHdpdGhpbiBkbV91cGRhdGVfY3J0Y19zdGF0ZSgpLCB0aGUgZGMgc3RyZWFtCj4+IGNhbm5v
dCBiZSBOVUxMLiBVc2luZyBCVUdfT04gYXMgYW4gYXNzZXJ0aW9uIGlzIG5vdCByZXF1aXJlZCBh
bmQKPj4gY2FuIGJlIHJlbW92ZWQuIFRoZSBwYXRjaCByZXBsYWNlcyB0aGUgY2hlY2sgd2l0aCBh
IFdBUk5fT04gaW4gY2FzZQo+PiBkbV9uZXdfY3J0Y19zdGF0ZS0+c3RyZWFtIGlzIE5VTEwuCj4+
Cj4+IFNpZ25lZC1vZmYtYnk6IEFkaXR5YSBQYWtraSA8cGFra2kwMDFAdW1uLmVkdT4KPj4gLS0t
Cj4+IMKgIGRyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9hbWRncHVfZG0vYW1kZ3B1X2RtLmMg
fCAyICstCj4+IMKgIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigt
KQo+Pgo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2FtZGdwdV9k
bS9hbWRncHVfZG0uYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9hbWRncHVfZG0vYW1k
Z3B1X2RtLmMKPj4gaW5kZXggN2FhYzk1NjhkM2JlLi4wM2NiMzA5MTNjMjAgMTAwNjQ0Cj4+IC0t
LSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9hbWRncHVfZG0vYW1kZ3B1X2RtLmMKPj4g
KysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2FtZGdwdV9kbS9hbWRncHVfZG0uYwo+
PiBAQCAtNzAxMiw3ICs3MDEyLDcgQEAgc3RhdGljIGludCBkbV91cGRhdGVfY3J0Y19zdGF0ZShz
dHJ1Y3QgYW1kZ3B1X2Rpc3BsYXlfbWFuYWdlciAqZG0sCj4+IMKgwqDCoMKgwqDCoCAqIDMuIElz
IGN1cnJlbnRseSBhY3RpdmUgYW5kIGVuYWJsZWQuCj4+IMKgwqDCoMKgwqDCoCAqID0+IFRoZSBk
YyBzdHJlYW0gc3RhdGUgY3VycmVudGx5IGV4aXN0cy4KPj4gwqDCoMKgwqDCoMKgICovCj4+IC3C
oMKgwqAgQlVHX09OKGRtX25ld19jcnRjX3N0YXRlLT5zdHJlYW0gPT0gTlVMTCk7Cj4+ICvCoMKg
wqAgV0FSTl9PTighZG1fbmV3X2NydGNfc3RhdGUtPnN0cmVhbSk7Cj4+IMKgIAo+IAo+IFRoYW5r
cyBmb3IgdGhlIHBhdGNoLCBidXQgdGhpcyBpcyBOQUsgZnJvbSBtZSBzaW5jZSBpdCBkb2Vzbid0
IHJlYWxseSBkbyBhbnl0aGluZyB0byBwcmV2ZW50IGl0IG9yIGZpeCBpdC4KPiAKPiBJZiB0aGUg
c3RyZWFtIGlzIE5VTEwgYW5kIGl0IHBhc3NlZCB0aGlzIGZhciBpbiB0aGUgZnVuY3Rpb24gdGhl
biBzb21ldGhpbmcgcmVhbGx5IHdyb25nIGhhcyBoYXBwZW5lZCBhbmQgdGhlIHByb2Nlc3Mgc2hv
dWxkIGJlIHN0b3BwZWQuCj4gCj4gSSdtIGN1cnJlbnRseSBkZWFsaW5nIHdpdGggYW4gaXNzdWUg
d2hlcmUgZG1fbmV3X2NydGNfc3RhdGUtPnN0cmVhbSBpcyBOVUxMLiBPbmUgb2YgdGhlIHNjZW5h
cmlvcyBjb3VsZCBiZSB0aGF0IGRyaXZlciBjcmVhdGVzIHN0cmVhbSBmb3IgYSBmYWtlIHNpbmsg
aW5zdGVhZCBvZiBmYWlsaW5nLCB0aGF0IGlzIGNvbm5lY3RlZCBvdmVyIE1TVCwgYW5kIGNhbGxz
IGRtX3VwZGF0ZV9jcnRjX3N0YXRlIHRvIGVuYWJsZSBDUlRDLgo+IAo+PiDCoMKgwqDCoMKgIC8q
IFNjYWxpbmcgb3IgdW5kZXJzY2FuIHNldHRpbmdzICovCj4+IMKgwqDCoMKgwqAgaWYgKGlzX3Nj
YWxpbmdfc3RhdGVfZGlmZmVyZW50KGRtX29sZF9jb25uX3N0YXRlLCBkbV9uZXdfY29ubl9zdGF0
ZSkpCj4+Cj4gCgpUaGFua3MgTWlraXRhIGZvciB5b3VyIGFkdmljZSByZWdhcmRpbmcgdGhlIHBh
dGNoLiBIb3dldmVyLCB3b3VsZCBhIGJldHRlciBlcnJvciBoYW5kbGluZyAKaW4gdGhpcyBzY2Vu
YXJpbyBiZSBoZWxwZnVsID8gQ2xlYXJseSwgdGhlIHN0cmVhbSB2YXJpYWJsZSBpcyBkZXJlZmVy
ZW5jZWQgaW4gCnVwZGF0ZV9zdHJlYW1fc2NhbGluZ19zZXR0aW5ncyB3b3VsZCBoYXZlIHRoZSBz
YW1lIGltcGFjdCBhcyBhIGNyYXNoID8KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVz
a3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9h
bWQtZ2Z4Cg==
