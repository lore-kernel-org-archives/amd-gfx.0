Return-Path: <SRS0=NdEU=ZS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9BC0C432C0
	for <amd-gfx@archiver.kernel.org>; Tue, 26 Nov 2019 19:44:21 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 58AE12075C
	for <amd-gfx@archiver.kernel.org>; Tue, 26 Nov 2019 19:44:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58AE12075C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux.ee
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1AD616E14E;
	Tue, 26 Nov 2019 19:44:21 +0000 (UTC)
Received: from mx2.cyber.ee (mx2.cyber.ee [193.40.6.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 08D4F6E184;
 Tue, 26 Nov 2019 17:46:27 +0000 (UTC)
Subject: Re: radeon UBSAN warning from user syscall
To: Alex Deucher <alexdeucher@gmail.com>
References: <70afeeda-e6a5-4c3b-2691-efe282472fa1@linux.ee>
 <CADnq5_PUgfHjvwYiYO26aTKMUAShGD5jQ=bSL+-is2Ws17BMGQ@mail.gmail.com>
From: Meelis Roos <mroos@linux.ee>
Message-ID: <34470725-7707-04d7-d5d6-5d3b6ae1aa9b@linux.ee>
Date: Tue, 26 Nov 2019 19:46:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <CADnq5_PUgfHjvwYiYO26aTKMUAShGD5jQ=bSL+-is2Ws17BMGQ@mail.gmail.com>
Content-Language: en-US
X-Mailman-Approved-At: Tue, 26 Nov 2019 19:44:20 +0000
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Maling list - DRI developers <dri-devel@lists.freedesktop.org>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191126174616.7BHCL8dZ_FNWCbQL6Es9CaynzTlHB2R5sgxicv0lysA@z>

PiBMb29rcyBsaWtlIHRoZSBzaGlmdCBhbmQgbWFzayBhcmUgcmV2ZXJzZWQuICBEb2VzIHRoaXMg
cGF0Y2ggZml4IGl0PwoKWWVzLCB0aGUgd2FybmluZyBpcyBnb25lIGFuZCBpdCBzdGlsbCB3b3Jr
cy4gVGhhbmsgeW91IQoKVGVzdGVkLWJ5OiBNZWVsaXMgUm9vcyA8bXJvb3NAbGludXguZWU+Cl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFp
bGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeA==
