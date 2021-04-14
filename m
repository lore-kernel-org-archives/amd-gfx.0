Return-Path: <SRS0=h6PS=JL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20728C433ED
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Apr 2021 06:49:02 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AFDA96101B
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Apr 2021 06:49:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFDA96101B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 41C926E8E6;
	Wed, 14 Apr 2021 06:49:01 +0000 (UTC)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CAED16E8E6
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Apr 2021 06:49:00 +0000 (UTC)
Received: by mail-ej1-x62d.google.com with SMTP id l4so29668590ejc.10
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Apr 2021 23:49:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=B+6jr48Ojmznsxy4oxkxofQU/L6ur022KHUmb08+AKw=;
 b=dXA+vORs75v7tBI7xHzxHssLv0Cv7a82SFSTESmFZkL5LGkytxDvh583n8epxC/EkQ
 JKpmDMzL/H396ZiXVe8P/hbdFa7DElz+SsdTAAdixv8X9tOBkvprSSg75wUUtjEPHy9J
 L++48dCtpybt6/XC8KNFRItR6w4tLCSkzPIFAtbd/8tRnnT5DG//tA9TeljD//7B+W/H
 ROTyziBZk9kdwhTZdGuadddQZtXUy5da2eM3wnRp9KIp29i528dGFO/mq5seHrTC41Nh
 lH3r+/OhGN6Xa8HB0s48ZR7FL4H566Jk2kWbMwyYhq3KNy7bEv2bCDaHkhTsAybEbmHP
 +3Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=B+6jr48Ojmznsxy4oxkxofQU/L6ur022KHUmb08+AKw=;
 b=tsuHduERlnPIPPeLF7fX7B4ZLDFROs+MQy4jNxW/2tBWFmhwdNsTUTLmPADiU3tai+
 cMv8A6T69YSSWsdw0+uD0KWyNO5BpDHnxpCgZhdyhaWBbs/MCyBfdHITeNCIhuUNnBEL
 N4y83UU7AjiKIHty8trPEkVYqc8DfGjoNuRb8IC3j7YYPvpoTWORUiyyAFCLpn6MbIQL
 4TasAw+rrmGZVbRWqZAgk0cPk5DUdcuP8EhnAXpTfnJGZWcssc7WEiouUICAj9OH6y5Y
 7r9laqw5X9nSTsPYQg8EWdsu2T9Ysn89UbRfrvLCJb5S6JrV25qXB/+3fgfjZcf8SpVA
 razg==
X-Gm-Message-State: AOAM533ygKSeOm9MfxCSPUKQKYb/smMtT94V5ibGyRinN1DpZ8DImM/c
 dE/Te57FwusvmOdMMb4e9ak7fG9e3wQ=
X-Google-Smtp-Source: ABdhPJyiZSX8xkF7d5J5ttZet1s3oX9W153kD9Z9vwQiVCXCHKDxuyS3zDOtIdT1Pq0+z5KBgm7xvw==
X-Received: by 2002:a17:907:7283:: with SMTP id
 dt3mr13149444ejc.47.1618382939554; 
 Tue, 13 Apr 2021 23:48:59 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:eb49:bad8:5b80:ea48?
 ([2a02:908:1252:fb60:eb49:bad8:5b80:ea48])
 by smtp.gmail.com with ESMTPSA id c2sm11244029edr.57.2021.04.13.23.48.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Apr 2021 23:48:59 -0700 (PDT)
Subject: Re: [BUG] VAAPI encoder cause kernel panic if encoded video in 4K
To: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
References: <CABXGCsOifMk4+VHi4bnHCL2L_tT+Tm_Rz+KxD3ZQOowx1xms4g@mail.gmail.com>
 <293189a2-3a6b-1e50-7607-33917743b9d8@amd.com>
 <CABXGCsMMUa=0+GAHxfVdOOFO0Lx=tCa4+ongHN8rF4TAR9nVmg@mail.gmail.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <66f5fdcb-d414-603d-bdb8-70579335b4a2@gmail.com>
Date: Wed, 14 Apr 2021 08:48:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <CABXGCsMMUa=0+GAHxfVdOOFO0Lx=tCa4+ongHN8rF4TAR9nVmg@mail.gmail.com>
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
Cc: Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

CgpBbSAxMy4wNC4yMSB1bSAyMzoxOSBzY2hyaWViIE1pa2hhaWwgR2F2cmlsb3Y6Cj4gT24gVHVl
LCAxMyBBcHIgMjAyMSBhdCAxMjoyOSwgQ2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5p
Z0BhbWQuY29tPiB3cm90ZToKPj4gSGkgTWlraGFpbCwKPj4KPj4gdGhlIGNyYXNoIGlzIGEga25v
d24gaXNzdWUgYW5kIHNob3VsZCBiZSBmaXhlZCBieToKPj4KPj4gY29tbWl0IGY2M2RhOWFlNzU4
NDI4MDU4MmNiYzgzNGIyMGNjMThiZmIyMDNiMTQKPj4gQXV0aG9yOiBQaGlsaXAgWWFuZyA8UGhp
bGlwLllhbmdAYW1kLmNvbT4KPj4gRGF0ZTogICBUaHUgQXByIDEgMDA6MjI6MjMgMjAyMSAtMDQw
MAo+Pgo+PiAgICAgICBkcm0vYW1kZ3B1OiByZXNlcnZlIGZlbmNlIHNsb3QgdG8gdXBkYXRlIHBh
Z2UgdGFibGUKPj4KPiBVbmZvcnR1bmF0ZWx5LCB0aGlzIGNvbW1pdCBjb3VsZG4ndCBmaXggdGhl
IGluaXRpYWwgcHJvYmxlbS4KPiAxLiBSZXN1bHQgdmlkZW8gaXMgamVya3kgaWYgaXQgZ3JhYmJl
ZCBhbmQgZW5jb2RlZCB3aXRoIGZmbXBlZwo+IChoMjY0X3ZhYXBpIGNvZGVjKS4KPiAyLiBPQlMg
c3RpbGwgY3Jhc2hlZCBpZiBJIHRyeSB0byByZWNvcmQgb3Igc3RyZWFtIHZpZGVvLgo+IDMuIElu
IHRoZSBrZXJuZWwgbG9nIHN0aWxsIGFwcGVhcnMgdGhlIG1lc3NhZ2UgImFtZGdwdTogW21taHVi
XSBwYWdlCj4gZmF1bHQgKHNyY19pZDowIHJpbmc6MCB2bWlkOjQgcGFzaWQ6MzI3NzAsIGZvciBw
cm9jZXNzIG9icyIgaWYgSSB0cmllZAo+IHRvIHJlY29yZCBvciBzdHJlYW0gdmlkZW8gYnkgT0JT
LgoKVGhhdCBpcyBleHBlY3RlZCBiZWhhdmlvciwgdGhlIGFwcGxpY2F0aW9uIGlzIGp1c3QgYnVn
Z3kgYW5kIGNhdXNpbmcgYSAKcGFnZSBmYXVsdCBvbiB0aGUgR1BVLgoKVGhlIGtlcm5lbCBzaG91
bGQganVzdCBub3QgY3Jhc2ggd2l0aCBhIGJhY2t0cmFjZS4KClJlZ2FyZHMsCkNocmlzdGlhbi4K
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
