Return-Path: <SRS0=BT7C=ID=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39E8AC433DB
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Mar 2021 08:01:01 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC69965004
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Mar 2021 08:01:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC69965004
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 955906EB0B;
	Fri,  5 Mar 2021 08:01:00 +0000 (UTC)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B39C86EB0B
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Mar 2021 08:00:59 +0000 (UTC)
Received: by mail-ej1-x62f.google.com with SMTP id p8so1622695ejb.10
 for <amd-gfx@lists.freedesktop.org>; Fri, 05 Mar 2021 00:00:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-transfer-encoding:content-language;
 bh=YiB6ySYuNT0E/gYitezpSecagjLDrAw3wehZJqrZZHM=;
 b=pgMvuordGX4JKKsZkixU8uXXS1gQWEjLNFoJcFjKG+L1/0EF4TAdzDg1f+ZCyopUO4
 jspgpCotJp2FTG5eGcZncadCcbRk7KDTyvMJAGS9NCFNzdfFY6QwJ8iJ6hXYfpGKL0WQ
 r9idD4l66sFGrreVrg5FM1BrqZJTSzwV//1zUDrbdDebb3jaU8MgfKsd1l3x75EBUwbj
 RPsZvVMqqd0vH200/vH343AfczZ9ogpkAmfcEpfLV7ZYdVKt98GalJNn5gMKuwZV0AfX
 eEBbo8bhyJUVSKcioyYV1iK7EFqZ3FzWdvYxv5kvfTWDgMNRSz3dB9pLpHpkhMAdpZKl
 wQ/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=YiB6ySYuNT0E/gYitezpSecagjLDrAw3wehZJqrZZHM=;
 b=NureT0Z/prDFmL7ikRtjIVQWiBE2IWz55YflRrtE7qTgQYBp1m5PQvZP4L/qHZWCVt
 flLBis7g2FEbMjh30d+5wjLoojd7eLygtFLIhl99HoH8338qKv5gZTnGcrAam/nvfh8R
 GW7l9lyuZvjLZIGRv8CWj7acqRymI4gQjyYOpHShRd2OvJjU10gxTE4c0vVPltiMYuJU
 +S/N/ZD94LybcHyMZtaFxZnrEKqVTN2hW/+jlQk0J9MyybVWQSkzbCeSh4/68stV7Y9P
 E+bSsTjVgjNOVHTkBMS+c9NM5wjejmaFtUPDSt0K3FuddmevAa96mCaf+UwHtbufAPtU
 qzUw==
X-Gm-Message-State: AOAM5314i2maO0kpWVA16byYsDvV5NGIaXqYkPzeTa1DsKgO4nhPDUSW
 +bT2AVRJEpTcR5Vmxc3+hps+gv/wOleM0A==
X-Google-Smtp-Source: ABdhPJxR74ww4nJON/WH4AP3TQ+sl0WhVAKm2P+s2TOT9QbK1En6CnBIMHj+lwrxntES8m+eUIMtxA==
X-Received: by 2002:a17:906:444d:: with SMTP id
 i13mr1185199ejp.170.1614931258459; 
 Fri, 05 Mar 2021 00:00:58 -0800 (PST)
Received: from ?IPv6:2a02:908:1252:fb60:9f0d:d59a:6448:4a90?
 ([2a02:908:1252:fb60:9f0d:d59a:6448:4a90])
 by smtp.gmail.com with ESMTPSA id r5sm1027002ejx.96.2021.03.05.00.00.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 05 Mar 2021 00:00:57 -0800 (PST)
Subject: Re: [amdgpu] Can compute kernels with different VMIDs run
 concurrently on the gpu hardware
To: Felix Kuehling <felix.kuehling@amd.com>, amd-gfx@lists.freedesktop.org
References: <CAGztBWWAv2ei=JvJvG6hvGp_275rFwQvFtzSaC4kbuCDgNBZEQ@mail.gmail.com>
 <f72da304-c744-4d38-d9ec-b9cf26dc267b@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <54465eb7-3cce-8d14-323a-0d72b6360a8e@gmail.com>
Date: Fri, 5 Mar 2021 09:00:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <f72da304-c744-4d38-d9ec-b9cf26dc267b@amd.com>
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

CgpBbSAwNS4wMy4yMSB1bSAwNDo1OSBzY2hyaWViIEZlbGl4IEt1ZWhsaW5nOgo+IEFtIDIwMjEt
MDMtMDQgdW0gMzowMyBhLm0uIHNjaHJpZWIgU21pdGggSm9objoKPj4gSGkhIEkgbm90aWNlZCB0
aGF0IGtlcm5lbHMgd2l0aCBkaWZmZXJlbnQgVk1JRHMgaGF2ZSBkaWZmZXJlbnQgR1BVCj4+IGFk
ZHJlc3Mgc3BhY2VzLiBJIHdhcyB3b25kZXJpbmcgaWYgaXQgaXMgcG9zc2libGUgZm9yIHRoZXNl
IGtlcm5lbHMgdG8KPj4gcnVuIGNvbmN1cnJlbnRseSBvbiB0aGUgc2FtZSBHUFUsIG9yIHRoZXkg
bmVlZCB0byBiZSBzZXJpYWxpemVkIGV2ZW4KPj4gd2hlbiB0aGVyZSBhcmUgZnJlZSBDVXMuCj4g
VGhleSBjYW4gcnVuIGNvbmN1cnJlbnRseS4gVGhhdCdzIHRoZSBwb2ludCBvZiBoYXZpbmcgbXVs
dGlwbGUgVk1JRHMgaW4KPiB0aGUgZmlyc3QgcGxhY2UuCgpXaGF0IGNhbiBvZiBjb3Vyc2UgaGFw
cGVuIGlzIHRoYXQgdGhleSBmaWdodCBmb3Igb3RoZXIgcmVzb3VyY2VzIGxpa2UgCm1lbW9yeS4K
ClRoZSBtb3N0IGVmZmljaWVudCB1c2FnZSBpcyBzdGlsbCB0byBtYWtlIHN1cmUgdGhhdCB5b3Vy
IGNvbXB1dGUgam9iIGNhbiAKa2VlcCBDVXMgYnVzeSBhcyBtdWNoIGFzIHBvc3NpYmxlLgoKVGhl
IGludGVudGlvbiBvZiBkaWZmZXJlbnQgVk1JRHMgaXMgdG8gaGVscCB3aGlsZSBzd2l0Y2hpbmcg
YmV0d2VlbiAKYXBwbGljYXRpb25zLgoKUmVnYXJkcywKQ2hyaXN0YW4uCgo+Cj4gUmVnYXJkcywK
PiAgwqAgRmVsaXgKPgo+Cj4+IF9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fCj4+IGFtZC1nZnggbWFpbGluZyBsaXN0Cj4+IGFtZC1nZnhAbGlzdHMuZnJlZWRl
c2t0b3Aub3JnCj4+IGh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGlu
Zm8vYW1kLWdmeAo+IF9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fCj4gYW1kLWdmeCBtYWlsaW5nIGxpc3QKPiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9y
Zwo+IGh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdm
eAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdm
eCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0
cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
