Return-Path: <SRS0=s+k6=6D=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9028BC54F70
	for <amd-gfx@archiver.kernel.org>; Sun, 19 Apr 2020 21:12:22 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 65B0D2137B
	for <amd-gfx@archiver.kernel.org>; Sun, 19 Apr 2020 21:12:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="ohDDSvFU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65B0D2137B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E0A916E0C4;
	Sun, 19 Apr 2020 21:12:17 +0000 (UTC)
X-Greylist: delayed 311 seconds by postgrey-1.36 at gabe;
 Sun, 19 Apr 2020 09:10:29 UTC
Received: from mout.web.de (mout.web.de [217.72.192.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0999F6E44C
 for <amd-gfx@lists.freedesktop.org>; Sun, 19 Apr 2020 09:10:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1587287427;
 bh=pEOnXWUWJq32wcmWoEXmTWiIZi1eoe0kShcruVve2N0=;
 h=X-UI-Sender-Class:To:Cc:Subject:From:Date;
 b=ohDDSvFU2b0mzcQult68Rfzur8xHRP/0RygLTHagbAGGE/ZJ4tcwtjW6JT9EBCiFu
 1d3KF/d+wIorRTstWVs7PTZHjPSz7ZMVLE+4wbWlmRn2NBLjBN7Vwu+CBTQK65inWe
 skponNFztGFcZE0CCm5XlOxWdzYDGiCIfuuA81+4=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([2.243.85.208]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0Lpw6t-1imLDu1Dh1-00fioW; Sun, 19
 Apr 2020 11:05:09 +0200
To: Bernard Zhao <bernard@vivo.com>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Chunming Zhou <David1.Zhou@amd.com>, =?UTF-8?Q?Felix_K=c3=bchling?=
 <Felix.Kuehling@amd.com>
Subject: Re: [PATCH] drm/amdgpu: Reduce a lock scope in
 amdgpu_amdkfd_gpuvm_free_memory_of_gpu()
From: Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <af0aa64e-f097-76a7-1c7b-5bdf0ad55a31@web.de>
Date: Sun, 19 Apr 2020 11:05:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
Content-Language: en-GB
X-Provags-ID: V03:K1:ejkFRws8u94G50TmJ+06NF8v58dM/Kg4QYRAJeDxA65iCsqyUK/
 Q49VO2Za7oZHZZkUJN0I3iAODIrOyQIYm+l0M8q/ZXRdPABhI/AdTc5BclF6ys+nnR/DI2+
 9X/0Zw35mVrxBzS1j0BNpt2qoflkre6K2XKyljehSrh65S2jNmd5nykKuqggvwyMi2OUawR
 aS9No9WtnCTIgv9vsI7ag==
X-UI-Out-Filterresults: notjunk:1;V03:K0:6k/q6BgM9Jk=:Xuu2vhx4eVIZb4YTqgUFBK
 VZo/IKHeV+EXvFsf0VLPWvYT/46WwgOzKoWLdrJsv1u+/Me8t+3G2yTRpS3gUaM1ACnFXjctb
 NkMAB6ePxmPC0geChtcnw5vGWzWqaWBaJypQQQSgS9xJAExe45Yd+nk8i26Cu0dFNbUPmCo06
 djwZnO7/R9zG4VHQRPnuFOFLXU37e3stauKL9pxIuec45P/fj8ZW2RVC/2FVV9CXvhsWeLUyO
 OLndia5jZqJjd1p9kz6psIUXRh8LorV/qFQRmr82Np5DR+qF3wnIwgj1y9jIC7KP7vFETddWr
 Q2kIi5Q57WWvCWa0x19ZkmBegjbMvJU/QWG69Ubxu0mc7jlahwerRIXqzM8uvEie2/mFi3714
 XeLeH1tGIUzUiM92s317jrCIOfSb+gVvcrWAJ61Wj32e+wW37ZYCK5WyjnJvyv5oLe+HOJRJx
 9XMgTDZnJ5PJycKnYTg3JTLWRujq12KXRMiwv74WgZ/EpjAZGAO3vLqLm+VzuK9TNU8aGQIWt
 ioyaX2c5P4po9W8Q7jIOo7/05qoTDo6g+rWcZtYpLwax65wTz19eOaJ65VIM6O1CPEbUgri/1
 ziUXNb50IADrV6n+I0RlsIYiTUQRq2IyaHSmRNGkclSxxFRuCaJXEE0GeuzmrdFDXhZACq9os
 PhzvqMWfDuycHuHF2Dgdex4rsM45UEbAutg9fVsiLLR7TrjFCcHniVImYEE2UscmHmmoAfOhh
 9fbFjzvT8vTo5LzzktRqevorxh3RBeTYTLsNPDqQw6c2v6jaxF4EBAsADKDGiUZKUDqa0WhUZ
 9hvjfqD+rocuXkJZopsQzEtKEWJxAIAZ8r+1VXkGKT1r5WUS+VysiXHNPNMoDAN5U992bItOZ
 KVCDVpSEOrr6qKVgCompwS7d/XbHqcxASCWjN3bzvjUQZVvubOF8X26N6xHJMsqwcpPFt5zOz
 XsOjMTqIpz3zlh+c2BjjznJDKmk0hnuTWV6H3B5W76z3HtbBTaSs5IMPOUkiAFAG3z52vYFlc
 V8vDbqjlDNyaMPhPb51rpMcs3JIJBYotDctTqU8/If/H5wbUKhqgCvw+q2iANbRwL+7249dLY
 cyDVw03GBjsqHzEAP5+Gc+EXdB7xlNdS2stQsB+Ng6AaNQYVqgZGYwf3PwBBHTfpDYEPBpK5K
 bH4Xe84nvLoI57IlipZxPJA5dJDZaXjNrEU0kQ+elhONCVOqMxIWYw4xb8NXWAjnuGSF98Tp5
 vn1usUBo1CLrumNZY
X-Mailman-Approved-At: Sun, 19 Apr 2020 21:12:16 +0000
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
Cc: David Airlie <airlied@linux.ie>, kernel@vivo.com,
 linux-kernel@vger.kernel.org, Daniel Vetter <daniel@ffwll.ch>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

> Maybe we could reduce the mutex_lock(&mem->lock)`s protected code area,
> and noneed to protect pr_debug.

I suggest to improve the commit message.
Would you like to adjust the patch subject?

Do you imagine that data synchronisation should evolve in other ways?

Regards,
Markus
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
