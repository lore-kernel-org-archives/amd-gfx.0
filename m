Return-Path: <SRS0=OkES=DI=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D98FC4727C
	for <amd-gfx@archiver.kernel.org>; Thu,  1 Oct 2020 13:47:38 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 697D3207F7
	for <amd-gfx@archiver.kernel.org>; Thu,  1 Oct 2020 13:47:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="pmD5NZbT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 697D3207F7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CABBA6E217;
	Thu,  1 Oct 2020 13:47:36 +0000 (UTC)
X-Greylist: delayed 316 seconds by postgrey-1.36 at gabe;
 Thu, 01 Oct 2020 13:36:09 UTC
Received: from mout.web.de (mout.web.de [212.227.15.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3D7C06E217
 for <amd-gfx@lists.freedesktop.org>; Thu,  1 Oct 2020 13:36:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1601559367;
 bh=JCuC+YxYl97qqlkG4kZ/uganLKGm8eQOvYq7b53mvWU=;
 h=X-UI-Sender-Class:To:Cc:Subject:From:Date;
 b=pmD5NZbT3Y61qT+QdpzFJ0ovEd1HW5M+PyVn8oneWMybGQLZ/5Y/RgQuwR3D9Rd9C
 nb4MId9fS7piAGWrpo84cE1/FuMVestckuLiPNdvk/Op3dDqqw6nzaMD00WRdFiiYU
 3TRxZ9OfEolbREI2NpM07A3kS3eNDL6WnutjDDQ4=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.133.75.172]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MXHcb-1jrkuo2gSL-00WBNy; Thu, 01
 Oct 2020 15:30:31 +0200
To: Dirk Gouders <dirk@gouders.net>, amd-gfx@lists.freedesktop.org
Subject: Re: [PATCH] drm/amdgpu: Avoid null pointer dereference in
 soc15_reg_base_init()
From: Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <6078dfa1-4b54-e58e-7fed-60d751c584e0@web.de>
Date: Thu, 1 Oct 2020 15:30:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
Content-Language: en-GB
X-Provags-ID: V03:K1:gsmzjVwR+wSlSkWqVU6tovQmQBtZz+8La50DV+1PijsbAloyyIo
 95j6kfsNt55Sup9murAM6GOddYl5MUsKcyJ51jSVCb1OIEJImf5HtSk/JPqZPXgOoPvOVii
 MMRATszaWYi5B4WbmJan9UbpVyj6lvXCvaNnyeVYBLwOm8QQyQFFc5GRWlOHfc2AlJUUsgC
 j8WGiLbjY1voDxLSPHpxQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Lz6ribQFqKw=:K2zu2Hr8knhD186Q9JXMxn
 VdgQQi6sDE30fwZBI5eP8tvJAwI1H8q0dDYPecZ0wcj4SX3QogSyiHe4ahioYcGdS+e6pUjT7
 6QMU2Pvq7GyVfa1WyezpnGxMHa6zwNdK6droIQTFbS7xWhu00mkBCO0c5pMDz/kh+xT8wUISJ
 ZGS5PI+Q4RxLSE4R+FJ00Mimi0k5o8jc83e5oa/VKfjkXjjlWqbBOqUmwYvhcatTtt2iWqFW+
 FWfcEn52keUZiiYYIFfedATkmGhbhgBkqJJ3LGv1+1QoItwNkvE2HEhyMTDmPOu+qJVsCLEN6
 I0EQCbGDq9AGFekRsitpkO1kRk3PEfN0W7ykc7mxqZQts/+cbfLC2weKPPzBPMyGl66Qh/VQj
 lrWupCPh3kQC549QIccdCvgGa4JR9RtYHpqlW535kSmzXQbougYZXUNmh+PD5CBPDVaGkIssz
 +P1kPG1nRqq3AdNnu4NkyWGEGKMmYQL4dRD2jU8pfImmyq2X5ppMQem7QWGXAszewDi804GB1
 8kXdubX2XZC8hA/EZIpobtIfCqh8fCzkYe8cvCGLzrlNT75kp1T46kkwvuCD4+C5h/2WsKhGd
 o8c95UD6Rr90FzcJOY8+xcN8tkhvg/S9IQibVjzH1b0RSb9E9Fqee5MhY3b2n//C+K5R2PT7j
 JJxdQql+ujViuwXCRpb4Zsn4UJDKXfVqIkckXdkpObrb35rddwCRDNaFHYOoApcglM6l63wtl
 TEq//nkVwjnJUH5iLlJuufSuRNX37yol13mk1pX59j9t66jAVpy68KfrcP1dEZLIVfJJcjuPg
 7enl9yH1QufU0IGxxP7314w2GSlyv5nc8ni75hY3dFYMjdHCu4y+q45oE1zGdpbE30UvvuLJ9
 3QnkBh4SLwATQ1BetHAJFz2sXxu737qwvIu2XDK9VgATRf5944H0KfCAtGZs22vu7LgN/dnsP
 JBI2aUf8NFI6u2csIt2NOBmDWISqrwWwGA2c5ONWoThtDRFrlfTNdMoBm/KKY5zrGh9Y0/AEc
 fG4Tw2j7VWeUPsxLaA16NS738B9ZpRuhwjATtZYzVaw2MHB3wlqYrjHsOu+hxmcFOgeVhftR+
 TzANd+lfqu0VeGF6lo2GRBD7VDhAolrW9dV2OfOJmHU4P1/sS856VNU84cZh2INvdqWZcah5K
 u9WzONqkThZu52alPaZ6QMhBzIik8rZYR05QGeN3nlDABbikBpPY2bJlPL3vTebe6Ev6bTdZi
 RyIcKLXs0kVN+vLGls+4fL62ISaTo3dk4F941HQ==
X-Mailman-Approved-At: Thu, 01 Oct 2020 13:47:35 +0000
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
Cc: David Airlie <airlied@linux.ie>, kernel-janitors@vger.kernel.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 Wenhui Sheng <Wenhui.Sheng@amd.com>, Daniel Vetter <daniel@ffwll.ch>,
 Alex Deucher <alexander.deucher@amd.com>, Evan Quan <evan.quan@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

PiB0aGF0IGNoYW5nZSwgdGhlIE5VTEwgcG9pbnRlciBkZXJlZmVyZW5jZSBkb2VzIG5vdCBvY2N1
cjoKCiogUGxlYXNlIHByb3ZpZGUgYSBwcm9wZXIgdGFnIOKAnFNpZ25lZC1vZmYtYnnigJ0uCgoq
IEhvdyBkbyB5b3UgdGhpbmsgYWJvdXQgdG8gYWRkIHRoZSB0YWcg4oCcRml4ZXPigJ0gdG8gdGhl
IGNvbW1pdCBtZXNzYWdlPwoKKiBXb3VsZCBhbm90aGVyIGltcGVyYXRpdmUgd29yZGluZyBiZWNv
bWUgaGVscGZ1bCBmb3IgdGhlIGNoYW5nZSBkZXNjcmlwdGlvbj8KCiogV291bGQgeW91IGxpa2Ug
dG8gY2hvb3NlIGFuIG90aGVyIHBhdGNoIHN1YmplY3Q/CgoK4oCmCj4gKysrIGIvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvc29jMTUuYwo+IEBAIC02OTksNyArNjk5LDggQEAgIHN0YXRpYyB2
b2lkIHNvYzE1X3JlZ19iYXNlX2luaXQoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpCj4gICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAiZmFsbGJhY2sgdG8gbGVnYWN5
IGluaXQgbWV0aG9kXG4iKTsKPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHZlZ2Ex
MF9yZWdfYmFzZV9pbml0KGFkZXYpOwo+ICAgICAgICAgICAgICAgICAgICAgICAgIH0KPiAtICAg
ICAgICAgICAgICAgfQo+ICsgICAgICAgICAgICAgICB9IGVsc2UKPiArICAgICAgICAgICAgICAg
ICAgICAgICB2ZWdhMTBfcmVnX2Jhc2VfaW5pdChhZGV2KTsKPiAgICAgICAgICAgICAgICAgYnJl
YWs7CuKApgoKV2lsbCBjdXJseSBicmFja2V0cyBiZSByZWxldmFudCBhbHNvIGZvciB0aGlzIGVs
c2UgYnJhbmNoPwoKUmVnYXJkcywKTWFya3VzCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGlu
Zm8vYW1kLWdmeAo=
