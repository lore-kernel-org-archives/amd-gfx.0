Return-Path: <SRS0=WUpi=KU=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D81CC47085
	for <amd-gfx@archiver.kernel.org>; Tue, 25 May 2021 14:02:13 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D78A6611BE
	for <amd-gfx@archiver.kernel.org>; Tue, 25 May 2021 14:02:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D78A6611BE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 927D46E223;
	Tue, 25 May 2021 14:02:12 +0000 (UTC)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 62E576E223
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 May 2021 14:02:11 +0000 (UTC)
Received: by mail-wm1-x334.google.com with SMTP id
 l18-20020a1ced120000b029014c1adff1edso13529390wmh.4
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 May 2021 07:02:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-transfer-encoding:content-language;
 bh=YJQGtsPF4qwxqxO2wFbwOR2DssjG9BrXDlN0anZPj3I=;
 b=myQDnuchjV8FuW8f/Ciin8VdwQwAnnJCUTgCLUNx+lflcLP85x6VntapjOCa9VrIre
 xOSVpOcr7GLQCsrc9vXuABsauze3y7R5YhUIsHtKsLKJ2d6qbvi5geZNHqS3qiZJt/Kr
 XFvlv4tnA0iLTgmQxD7j4Tus0knGyrE5KZ4iA9mvzsrcyy2dptJxDbxsn5Pz62OXOrPz
 vPwu+sflJBXQCQiV5z2bxMINNlKZ+mt9Rwj3B4t9oF9+T6sev9zTCzPyy4Z5xwGhU0sC
 QkNyTmGqpnP57KCf3mDHKbhRjCDj0dFYxEW757HVN8wq/7z8IEDdOvSwXl7OXc+lkuhX
 iNnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=YJQGtsPF4qwxqxO2wFbwOR2DssjG9BrXDlN0anZPj3I=;
 b=pA3N+Ab1p7bz1mxikYRESpaQUWtpDfz3j0xzBitXjmJ79HQ3K76MuaMHb2cnbhRZDb
 3371N25//8LOqaGiDHNLpPKf38O3V5wb4EIWiBBdYjJmyEFJWQPTiDYdOn1eq2MpkuVP
 QCtOl05u/JMo97jdbDA458QJ1Fu4WLO3H0eJlKfjKh6hzZArKxEHtMLjfkD4l8g9N+b+
 LhAxQ1ATLlEknpPnfoR3GKiBcyHYiMsvd/ey3dIY4WVFnlPiq6Q48AewMpj6ZR5cktnq
 peSGWMDfogixtXTnWW4fShJ1p2NMEvPSlfsx++WDplzkotA0JGYo6MOcOEg+uivjwhmH
 WI2w==
X-Gm-Message-State: AOAM531VmYr/lVfhICF//qdUVTOqA4OF6mSJHpxQmDwYV4Zn3oi2nzdD
 No/piBp5ucm+hhTtA8NnYIU=
X-Google-Smtp-Source: ABdhPJyvYn2ehzicVACo5QY0beCEqp6PSY6n/HbBwuEgVHyW5qMxEN5msKw6q/mIwPdCRy+Y+usr9w==
X-Received: by 2002:a1c:4482:: with SMTP id r124mr4065017wma.42.1621951330074; 
 Tue, 25 May 2021 07:02:10 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:d67f:bd9a:6dbf:33b1?
 ([2a02:908:1252:fb60:d67f:bd9a:6dbf:33b1])
 by smtp.gmail.com with ESMTPSA id r2sm16759242wrv.39.2021.05.25.07.02.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 25 May 2021 07:02:09 -0700 (PDT)
Subject: Re: Regression: bisected: AMDGPU causes Kernel Bad page state OOPS
 starting with kernels 5.11.x, 5.12.x, 5.13-rc
To: =?UTF-8?Q?Lu=c3=ads_Mendes?= <luis.p.mendes@gmail.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>, Daniel Vetter <daniel@ffwll.ch>
References: <CAEzXK1pXrnXpBfzZ9c-8MsYpoDCRt86F7yU=uLi52i96u8+SQA@mail.gmail.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <f18ccab2-19ed-c6ce-3778-7364bab6c821@gmail.com>
Date: Tue, 25 May 2021 16:02:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <CAEzXK1pXrnXpBfzZ9c-8MsYpoDCRt86F7yU=uLi52i96u8+SQA@mail.gmail.com>
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

SGkgTHVpcywKCmFkZGluZyBEYW5pZWwgYXMgd2VsbC4KCmZpcnN0IG9mIGFsbCBjYW4geW91IHBs
ZWFzZSBjcmVhdGUgYSBidWcgcmVwb3J0IGZvciB0aGlzIGhlcmU6IApodHRwczovL2dpdGxhYi5m
cmVlZGVza3RvcC5vcmcvZHJtL2FtZC8tL2lzc3VlcyBUaGlzIHdheSB3ZSBjYW4gYmV0dGVyIAp0
cmFjayBpc3N1ZXMuCgpUaGVuIHdoYXQgc2VlbXMgdG8gaGFwcGVuIGlzIHRoYXQgc29tZWJvZHkg
aXMgdXNpbmcgdGhlIFRUTSBwYWdlcyBpbiBhIAp3YXkgdGhleSBhcmUgbm90IHN1cHBvc2VkIHRv
IGJlIHVzZWQuCgpXZSBoYXZlIGZvdW5kIGEgYnVuY2ggb2YgYnVncyBpbiBmb3IgZXhhbXBsZSBL
Vk0gc2luY2UgYWRkaW5nIHRoYXQgCmNvbW1pdCBhbmQgSSBoYXZlIHRoZSBzdHJvbmcgc3VzcGlj
aW9uIHRoYXQgaXMganVzdCBhbm90aGVyIG9uZSBvZiB0aG9zZS4KClJlZ2FyZHMsCkNocmlzdGlh
bi4KCkFtIDI0LjA1LjIxIHVtIDIxOjI1IHNjaHJpZWIgTHXDrXMgTWVuZGVzOgo+IEhpLAo+Cj4g
QU1ER1BVIHdhcyB3b3JraW5nIGZpbmUgb24gbXkgYXJtaGYgc3lzdGVtcyB3aXRoIDUuMTAueCBh
bmQgcHJldmlvdXMKPiBrZXJuZWxzIGFuZCBhIFJYNTUwIGNhcmQuIFVuZm9ydHVuYXRlbHkgSSBo
YXZlIG9ubHkgbm93IHRlc3RlZCBrZXJuZWxzCj4gNS4xMS54LCA1LjEyLnggYW5kIDUuMTMtcmMg
YW5kIGFsbCBhcmUgbm93IHNob3dpbmcgcHJvYmxlbXMgbGlrZSB0aGlzCj4gb25lOgo+IE1heSAx
MCAyMDoyMzoxNCBwaWNvbG8ga2VybmVsOiBbICAgMTguOTY3NjI2XSBCVUc6IEJhZCBwYWdlIHN0
YXRlIGluCj4gcHJvY2VzcyBnbm9tZS1zaGVsbCAgcGZuOjc4YzA4Cj4gTWF5IDEwIDIwOjIzOjE0
IHBpY29sbyBrZXJuZWw6IFsgICAxOC45NzM3NTBdIHBhZ2U6Y2UyZTk3MTcgcmVmY291bnQ6Mgo+
IG1hcGNvdW50OjEgbWFwcGluZzoxN2VkY2VkMCBpbmRleDoweDEwOWU5IHBmbjoweDc4YzA4Cj4g
TWF5IDEwIDIwOjIzOjE0IHBpY29sbyBrZXJuZWw6IFsgICAxOC45NzM3NjNdIGFvcHM6MHhjMGUx
MmY1NCBpbm86MzBkCj4KPiBGdWxsIEtlcm5lbCBib290IGxvZyBpcyBoZXJlCj4gaHR0cHM6Ly9w
YXN0ZWJpbi5jb20vcGN1VVdYYmoKPgo+IEkndmUgYmlzZWN0ZWQgYW5kIHRyYWNlZCB0aGUgcHJv
YmxlbSB0byB0aGlzIGNvbW1pdDoKPiBlOTNiMmRhOTc5OWU1Y2I5Nzc2MDk2OWYzZTFmMDJhNWJk
YWMyOWZlIGlzIHRoZSBmaXJzdCBiYWQgY29tbWl0Cj4gY29tbWl0IGU5M2IyZGE5Nzk5ZTVjYjk3
NzYwOTY5ZjNlMWYwMmE1YmRhYzI5ZmUKPiBBdXRob3I6IENocmlzdGlhbiBLw7ZuaWcgPGNocmlz
dGlhbi5rb2VuaWdAYW1kLmNvbT4KPiBEYXRlOiAgIFNhdCBPY3QgMjQgMTM6MTE6MjkgMjAyMCAr
MDIwMAo+Cj4gICAgICBkcm0vYW1kZ3B1OiBzd2l0Y2ggdG8gbmV3IGFsbG9jYXRvciB2Mgo+Cj4g
ICAgICBJdCBzaG91bGQgYmUgYWJsZSB0byBoYW5kbGUgYWxsIGNhc2VzIGhlcmUuCj4KPiAgICAg
IHYyOiBmaXggZGVidWdmcyBhcyB3ZWxsCj4KPiAgICAgIFNpZ25lZC1vZmYtYnk6IENocmlzdGlh
biBLw7ZuaWcgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4KPiAgICAgIFJldmlld2VkLWJ5OiBE
YXZlIEFpcmxpZSA8YWlybGllZEByZWRoYXQuY29tPgo+ICAgICAgUmV2aWV3ZWQtYnk6IE1hZGhh
diBDaGF1aGFuIDxtYWRoYXYuY2hhdWhhbkBhbWQuY29tPgo+ICAgICAgVGVzdGVkLWJ5OiBIdWFu
ZyBSdWkgPHJheS5odWFuZ0BhbWQuY29tPgo+ICAgICAgTGluazogaHR0cHM6Ly9wYXRjaHdvcmsu
ZnJlZWRlc2t0b3Aub3JnL3BhdGNoLzM5NzA4Ni8/c2VyaWVzPTgzMDUxJnJldj0xCj4KPiAgIGRy
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV90dG0uYyB8IDQ1ICsrKysrKysrKystLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLQo+ICAgMSBmaWxlIGNoYW5nZWQsIDE0IGluc2VydGlvbnMoKyks
IDMxIGRlbGV0aW9ucygtKQo+Cj4gRGV0YWlsZWQgYmlzZWN0IGxvZyBpcyBoZXJlOgo+IGh0dHBz
Oi8vYmluLnByaXZhY3l0b29scy5pby8/YTg4YWU2M2ZiOTVmYTFjMSNFdHJDNHF4R1dqbWd5NUMz
ZEJ6WEZHcWp4Yzd6blRLVUx0ejRjeG9ZRnhXNQo+Cj4gQmVzdCByZWdhcmRzLAo+IEx1w61zIE1l
bmRlcwo+IEFwYXJhcGkgZGV2ZWxvcGVyCj4gUGhEIFN0dWRlbnQgJiBSZXNlYXJjaGVyCj4gX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KPiBhbWQtZ2Z4IG1h
aWxpbmcgbGlzdAo+IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCj4gaHR0cHM6Ly9saXN0
cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4CgpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAph
bWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9y
Zy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
