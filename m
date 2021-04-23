Return-Path: <SRS0=d4Si=JU=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C188C433ED
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Apr 2021 14:18:46 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B10C613E1
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Apr 2021 14:18:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B10C613E1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 35C986EB95;
	Fri, 23 Apr 2021 14:18:45 +0000 (UTC)
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com
 [IPv6:2a00:1450:4864:20::232])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8A50E6EB95
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 Apr 2021 14:18:44 +0000 (UTC)
Received: by mail-lj1-x232.google.com with SMTP id a25so42565445ljm.11
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 Apr 2021 07:18:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=TXbI5Oo0zfyl69DvKxAj2fO3Hm2ZEiDPMmXNP4VrOPU=;
 b=pY7koaVpQIsKa+eB7gEdCusqOZK96k5XYCs1vxIQM6Vjhet2WFwVHaP6uQ3ZVQ1aVE
 frt+HUmI0s17pQLY/IoNMaU/pK1WTsJdImy/cN7fNYv2ljfi0UwAKCMOrINEug9Rutw2
 ICWdWDT/E/OexhF66an8Zuznqe98ACNM1EHXq9lX/RvCJd30LmMDJ0Hx/w53l4uXhr3Y
 O71SW50Gt+jiJRkCRwc7XXCLLXRNJqAhvszyFOcSLgg0OIKVb8MZg2rGUh5NlIuLmUI2
 rFLUmTfxdv+8FJ9GAEsc4GNyGny+TAY9p2dvvTFgfb6AOIczhM0L52XFgV6+Sggn2vJ2
 roDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=TXbI5Oo0zfyl69DvKxAj2fO3Hm2ZEiDPMmXNP4VrOPU=;
 b=RNyKkS4TqajjtHjl86Vdk3VyloU7wyjBF906fInhMqaVd4LNQtFt/blBhp5A8s/57U
 6krBgmVAFeQCxYK0S3lHVT/BE2z6PPfrzSkY/e6eFRm3rtRYDU5sZ27Iv2RpCzNoxFGb
 k0IE6E33raxr2s757R+eT0zdvrNRYjhIbf7QZpO3mvGT9bYju8LnmZsh+We5tjcxY6Gp
 +5v11d7x8xldZ9hgU5aQdh9H8HpiMMH9fNXq859VOmBqj7uQkIAch84hJHBHIylLlWWq
 sUxFtZR5/rh/YHdytavyTUd2uOEpDZFW32th/iQQFMtQiYZm5T3drwUOmBpO60mpU+4T
 Cj7A==
X-Gm-Message-State: AOAM531SSbmLIPLM6ONsZBv4NMmQtGWCd9vLwG/QYYgCKiagx6ApUi34
 0RaSBEevTXOBnmTcip8A29c=
X-Google-Smtp-Source: ABdhPJyrX7sILEuzZmAB+wkSCMGYjvxpNPiBhLWXoKFFVBYYgjTbjw5v4OGz6zFyp6MYhN17XCx0DA==
X-Received: by 2002:a2e:a379:: with SMTP id i25mr2971485ljn.344.1619187522816; 
 Fri, 23 Apr 2021 07:18:42 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:88a3:b9e2:1bf9:4d38?
 ([2a02:908:1252:fb60:88a3:b9e2:1bf9:4d38])
 by smtp.gmail.com with ESMTPSA id s7sm557795ljg.31.2021.04.23.07.18.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 23 Apr 2021 07:18:42 -0700 (PDT)
Subject: Re: [PATCH v2] drm/amd/display: Reject non-zero src_y and src_x for
 video planes
To: Harry Wentland <harry.wentland@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210423140958.25205-1-harry.wentland@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <49d21b75-eaf7-5e24-7a16-480698e1498c@gmail.com>
Date: Fri, 23 Apr 2021 16:18:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210423140958.25205-1-harry.wentland@amd.com>
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
Cc: Roman.Li@amd.com, stable@vger.kernel.org, hersenxs.wu@amd.com,
 alexander.deucher@amd.com, danny.wang@amd.com, nicholas.kazlauskas@amd.com
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

R29vZCB0aGF0IHRoaXMgaGFzIGJlZW4gZm91bmQuIEp1c3QgYSBjdXJpb3VzIGd1ZXNzLCBidXQg
aGF2ZSB5b3UgZ3V5cyAKY2hlY2tlZCBpZiB0aGUgc3JjX3ggYW5kIHNyY195IGFyZSBhIG11bHRp
cGxlIG9mIDI/CgpNaWdodCBjYXVzZSBwcm9ibGVtcyB0byB0cnkgdG8gYWNjZXNzIGEgc3Vic2Ft
cGxlZCBzdXJmYWNlIGlmIHRoZSAKY29vcmRpbmF0ZXMgZG9lc24ndCBtYWtlIG11Y2ggc2Vuc2Uu
CgpBbnl3YXkgcGF0Y2ggaXMgQWNrZWQtYnk6IENocmlzdGlhbiBLw7ZuaWcgPGNocmlzdGlhbi5r
b2VuaWdAYW1kLmNvbT4KClJlZ2FyZHMsCkNocmlzdGlhbi4KCkFtIDIzLjA0LjIxIHVtIDE2OjA5
IHNjaHJpZWIgSGFycnkgV2VudGxhbmQ6Cj4gW1doeV0KPiBUaGlzIGhhc24ndCBiZWVuIHdlbGwg
dGVzdGVkIGFuZCBsZWFkcyB0byBjb21wbGV0ZSBzeXN0ZW0gaGFuZ3Mgb24gRENOMQo+IGJhc2Vk
IHN5c3RlbXMsIHBvc3NpYmx5IG90aGVycy4KPgo+IFRoZSBzeXN0ZW0gaGFuZyBjYW4gYmUgcmVw
cm9kdWNlZCBieSBnZXN0dXJpbmcgdGhlIHZpZGVvIG9uIHRoZSBZb3VUdWJlCj4gQW5kcm9pZCBh
cHAgb24gQ2hyb21lT1MgaW50byBmdWxsIHNjcmVlbi4KPgo+IFtIb3ddCj4gUmVqZWN0IGF0b21p
YyBjb21taXRzIHdpdGggbm9uLXplcm8gZHJtX3BsYW5lX3N0YXRlLnNyY194IG9yIHNyY195IHZh
bHVlcy4KPgo+IHYyOgo+ICAgLSBBZGQgY29kZSBjb21tZW50IGRlc2NyaWJpbmcgdGhlIHJlYXNv
biB3ZSdyZSByZWplY3Rpbmcgbm9uLXplcm8KPiAgICAgc3JjX3ggYW5kIHNyY195Cj4gICAtIERy
b3AgZ2Vycml0IENoYW5nZS1JZAo+ICAgLSBBZGQgc3RhYmxlIENDCj4gICAtIEJhc2VkIG9uIGFt
ZC1zdGFnaW5nLWRybS1uZXh0Cj4KPiBTaWduZWQtb2ZmLWJ5OiBIYXJyeSBXZW50bGFuZCA8aGFy
cnkud2VudGxhbmRAYW1kLmNvbT4KPiBDYzogc3RhYmxlQHZnZXIua2VybmVsLm9yZwo+IENjOiBu
aWNob2xhcy5rYXpsYXVza2FzQGFtZC5jb20KPiBDYzogYW1kLWdmeEBsaXN0cy5mcmVlZGVza3Rv
cC5vcmcKPiBDYzogYWxleGFuZGVyLmRldWNoZXJAYW1kLmNvbQo+IENjOiBSb21hbi5MaUBhbWQu
Y29tCj4gQ2M6IGhlcnNlbnhzLnd1QGFtZC5jb20KPiBDYzogZGFubnkud2FuZ0BhbWQuY29tCj4g
UmV2aWV3ZWQtYnk6IE5pY2hvbGFzIEthemxhdXNrYXMgPG5pY2hvbGFzLmthemxhdXNrYXNAYW1k
LmNvbT4KPiAtLS0KPiAgIC4uLi9ncHUvZHJtL2FtZC9kaXNwbGF5L2FtZGdwdV9kbS9hbWRncHVf
ZG0uYyAgIHwgMTcgKysrKysrKysrKysrKysrKysKPiAgIDEgZmlsZSBjaGFuZ2VkLCAxNyBpbnNl
cnRpb25zKCspCj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2Ft
ZGdwdV9kbS9hbWRncHVfZG0uYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9hbWRncHVf
ZG0vYW1kZ3B1X2RtLmMKPiBpbmRleCBiZTE3NjlkMjk3NDIuLmIxMjQ2OTA0M2U2YiAxMDA2NDQK
PiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvYW1kZ3B1X2RtL2FtZGdwdV9kbS5j
Cj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2FtZGdwdV9kbS9hbWRncHVfZG0u
Ywo+IEBAIC00MDg5LDYgKzQwODksMjMgQEAgc3RhdGljIGludCBmaWxsX2RjX3NjYWxpbmdfaW5m
byhjb25zdCBzdHJ1Y3QgZHJtX3BsYW5lX3N0YXRlICpzdGF0ZSwKPiAgIAlzY2FsaW5nX2luZm8t
PnNyY19yZWN0LnggPSBzdGF0ZS0+c3JjX3ggPj4gMTY7Cj4gICAJc2NhbGluZ19pbmZvLT5zcmNf
cmVjdC55ID0gc3RhdGUtPnNyY195ID4+IDE2Owo+ICAgCj4gKwkvKgo+ICsJICogRm9yIHJlYXNv
bnMgd2UgZG9uJ3QgKHlldCkgZnVsbHkgdW5kZXJzdGFuZCBhIG5vbi16ZXJvCj4gKwkgKiBzcmNf
eSBjb29yZGluYXRlIGludG8gYW4gTlYxMiBidWZmZXIgY2FuIGNhdXNlIGEKPiArCSAqIHN5c3Rl
bSBoYW5nLiBUbyBhdm9pZCBoYW5ncyAoYW5kIG1heWJlIGJlIG92ZXJseSBjYXV0aW91cykKPiAr
CSAqIGxldCdzIHJlamVjdCBib3RoIG5vbi16ZXJvIHNyY194IGFuZCBzcmNfeS4KPiArCSAqCj4g
KwkgKiBXZSBjdXJyZW50bHkga25vdyBvZiBvbmx5IG9uZSB1c2UtY2FzZSB0byByZXByb2R1Y2Ug
YQo+ICsJICogc2NlbmFyaW8gd2l0aCBub24temVybyBzcmNfeCBhbmQgc3JjX3kgZm9yIE5WMTIs
IHdoaWNoCj4gKwkgKiBpcyB0byBnZXN0dXJlIHRoZSBZb3VUdWJlIEFuZHJvaWQgYXBwIGludG8g
ZnVsbCBzY3JlZW4KPiArCSAqIG9uIENocm9tZU9TLgo+ICsJICovCj4gKwlpZiAoc3RhdGUtPmZi
ICYmCj4gKwkgICAgc3RhdGUtPmZiLT5mb3JtYXQtPmZvcm1hdCA9PSBEUk1fRk9STUFUX05WMTIg
JiYKPiArCSAgICAoc2NhbGluZ19pbmZvLT5zcmNfcmVjdC54ICE9IDAgfHwKPiArCSAgICAgc2Nh
bGluZ19pbmZvLT5zcmNfcmVjdC55ICE9IDApKQo+ICsJCXJldHVybiAtRUlOVkFMOwo+ICsKPiAg
IAlzY2FsaW5nX2luZm8tPnNyY19yZWN0LndpZHRoID0gc3RhdGUtPnNyY193ID4+IDE2Owo+ICAg
CWlmIChzY2FsaW5nX2luZm8tPnNyY19yZWN0LndpZHRoID09IDApCj4gICAJCXJldHVybiAtRUlO
VkFMOwoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1k
LWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9s
aXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
