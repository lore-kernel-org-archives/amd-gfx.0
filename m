Return-Path: <SRS0=bbC/=KX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DA20C2B9F7
	for <amd-gfx@archiver.kernel.org>; Fri, 28 May 2021 15:28:51 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C4F2F613AB
	for <amd-gfx@archiver.kernel.org>; Fri, 28 May 2021 15:28:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4F2F613AB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 649FA6E845;
	Fri, 28 May 2021 15:28:50 +0000 (UTC)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B51746E845
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 May 2021 15:28:49 +0000 (UTC)
Received: by mail-ej1-x634.google.com with SMTP id s22so5899101ejv.12
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 May 2021 08:28:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=uRx1QPy3glqXmcEG0T7IryGkNV1WRR0oSU30PCdRqcM=;
 b=Xu7OxfBFsf/nI+N03yVtOFA3XPXLt/Ald51NDGmk8sX+7TSr8VHIui3XB77Z2qmjFn
 qSUUPgTJNpANICK16EEA21Ts2pcJdrehXLXTXLpQ2Y5gdDEdFTROq8OY+oyb/VdM+1Jf
 gKFMerebpnCaAaWW8CDrWgZcB5mPI3bABvvVRveLCoTto9xwuNR3GdPTiEOP97PbevXW
 rj2nogmPRu5TyS4l/X7jHT2EEj2zr7PFBdJ1FocofvnLZktXjokUSIdO9v7+aytTPXuZ
 bOkby5L2GEd2Jfqzod8uVtvuJ9V8srkBwNyvie9HhWMYC3JlSCfAv5oCXC5WPLTnX9sF
 ffmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=uRx1QPy3glqXmcEG0T7IryGkNV1WRR0oSU30PCdRqcM=;
 b=LdHtUjkK/U53gYOa0cq/TNvAD701jsMfDmqDtObKZy8Hv2mmqwgHpy/nxHR4jDy12S
 Bfj/VhwraM5XVghj+OQMGOUqGIAzSe5/5GV8TXjbQ5OFG1flO9OqXdAJMbNIioIz7wAF
 lsswOdRjmbWJ8yI1n/DcpSrT134BTF1mfukf4n9aGt4T/KsFQ0fvKBhUf2qPj/8Dmg+n
 y4cumq52RuLPqldLGsDTdIT6LzhVnXqKB/YkiGnpZKsYsHqY6kLo0LWHDhjq++utbTAf
 LsSJmE4F24EZf0pziiEum54IsmXO59RyDgd2KWAcC5N5leVoSmerrBN8p3nRNiEsQ1pB
 yhGw==
X-Gm-Message-State: AOAM531UFpdJ+Mk6Wni6azgs3YvowhTZU9x4ld9PnRemReVcv/ZBpN+k
 vfpup+4GYOR6EkxMtvb4bYJTpkwStoA=
X-Google-Smtp-Source: ABdhPJz45DMIuEFxzNey1yxhCVrp9z7ApKhXB1hbApB39vHLAWKY7QTIv/r7Kz54WcG5IdgeNqBTTw==
X-Received: by 2002:a17:906:365a:: with SMTP id
 r26mr341041ejb.340.1622215728357; 
 Fri, 28 May 2021 08:28:48 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:a878:922a:f147:ebc?
 ([2a02:908:1252:fb60:a878:922a:f147:ebc])
 by smtp.gmail.com with ESMTPSA id rn2sm2505927ejb.45.2021.05.28.08.28.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 28 May 2021 08:28:47 -0700 (PDT)
Subject: Re: [PATCH 1/1] drm/amd/display: WARN_ON cleanups
To: Nirmoy Das <nirmoy.das@amd.com>, harry.wentland@amd.com
References: <20210527121448.33713-1-nirmoy.das@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <6d5e5cda-02b2-6357-f486-4562ac79f523@gmail.com>
Date: Fri, 28 May 2021 17:28:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210527121448.33713-1-nirmoy.das@amd.com>
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
Cc: alexander.deucher@amd.com, christian.koenig@amd.com,
 amd-gfx@lists.freedesktop.org
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

CgpBbSAyNy4wNS4yMSB1bSAxNDoxNCBzY2hyaWViIE5pcm1veSBEYXM6Cj4gVXVzZSBXQVJOX09O
KCkgaW5zaWRlIGlmLWNvbmRpdGlvbiB3aGVuIHBvc3NpYmxlLgo+Cj4gU2lnbmVkLW9mZi1ieTog
TmlybW95IERhcyA8bmlybW95LmRhc0BhbWQuY29tPgo+IC0tLQo+ICAgZHJpdmVycy9ncHUvZHJt
L2FtZC9kaXNwbGF5L2FtZGdwdV9kbS9hbWRncHVfZG0uYyB8IDExICsrKystLS0tLS0tCj4gICAx
IGZpbGUgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspLCA3IGRlbGV0aW9ucygtKQo+Cj4gZGlmZiAt
LWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9hbWRncHVfZG0vYW1kZ3B1X2RtLmMg
Yi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvYW1kZ3B1X2RtL2FtZGdwdV9kbS5jCj4gaW5k
ZXggZjJlZDUxNDg0OTgwLi43MzZlYjUzN2E4ZTQgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9ncHUv
ZHJtL2FtZC9kaXNwbGF5L2FtZGdwdV9kbS9hbWRncHVfZG0uYwo+ICsrKyBiL2RyaXZlcnMvZ3B1
L2RybS9hbWQvZGlzcGxheS9hbWRncHVfZG0vYW1kZ3B1X2RtLmMKPiBAQCAtMzE1LDggKzMxNSw3
IEBAIGdldF9jcnRjX2J5X290Z19pbnN0KHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LAo+ICAg
CXN0cnVjdCBkcm1fY3J0YyAqY3J0YzsKPiAgIAlzdHJ1Y3QgYW1kZ3B1X2NydGMgKmFtZGdwdV9j
cnRjOwo+ICAgCj4gLQlpZiAob3RnX2luc3QgPT0gLTEpIHsKPiAtCQlXQVJOX09OKDEpOwo+ICsJ
aWYgKFdBUk5fT04ob3RnX2luc3QgPT0gLTEpKSB7Cj4gICAJCXJldHVybiBhZGV2LT5tb2RlX2lu
Zm8uY3J0Y3NbMF07Cj4gICAJfQoKV2hpbGUgYXQgaXQgeW91IGNvdWxkIGFsc28gZHJvcCB0aGUg
ZXh0cmEge30gaGVyZS4KCkFwYXJ0IGZyb20gdGhhdCBwYXRjaCBpcyBBY2tlZC1ieTogQ2hyaXN0
aWFuIEvDtm5pZyAKPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4uCgpDaHJpc3RpYW4uCgo+ICAg
Cj4gQEAgLTM5Nyw4ICszOTYsNyBAQCBzdGF0aWMgdm9pZCBkbV9wZmxpcF9oaWdoX2lycSh2b2lk
ICppbnRlcnJ1cHRfcGFyYW1zKQo+ICAgCWUgPSBhbWRncHVfY3J0Yy0+ZXZlbnQ7Cj4gICAJYW1k
Z3B1X2NydGMtPmV2ZW50ID0gTlVMTDsKPiAgIAo+IC0JaWYgKCFlKQo+IC0JCVdBUk5fT04oMSk7
Cj4gKwlXQVJOX09OKCFlKTsKPiAgIAo+ICAgCXZycl9hY3RpdmUgPSBhbWRncHVfZG1fdnJyX2Fj
dGl2ZV9pcnEoYW1kZ3B1X2NydGMpOwo+ICAgCj4gQEAgLTY2OTgsOSArNjY5Niw4IEBAIHN0YXRp
YyBpbnQgZG1fY3J0Y19oZWxwZXJfYXRvbWljX2NoZWNrKHN0cnVjdCBkcm1fY3J0YyAqY3J0YywK
PiAgIAo+ICAgCWRtX3VwZGF0ZV9jcnRjX2FjdGl2ZV9wbGFuZXMoY3J0YywgY3J0Y19zdGF0ZSk7
Cj4gICAKPiAtCWlmICh1bmxpa2VseSghZG1fY3J0Y19zdGF0ZS0+c3RyZWFtICYmCj4gLQkJICAg
ICBtb2Rlc2V0X3JlcXVpcmVkKGNydGNfc3RhdGUsIE5VTEwsIGRtX2NydGNfc3RhdGUtPnN0cmVh
bSkpKSB7Cj4gLQkJV0FSTl9PTigxKTsKPiArCWlmIChXQVJOX09OKHVubGlrZWx5KCFkbV9jcnRj
X3N0YXRlLT5zdHJlYW0gJiYKPiArCQkgICAgIG1vZGVzZXRfcmVxdWlyZWQoY3J0Y19zdGF0ZSwg
TlVMTCwgZG1fY3J0Y19zdGF0ZS0+c3RyZWFtKSkpKSB7Cj4gICAJCXJldHVybiByZXQ7Cj4gICAJ
fQo+ICAgCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwph
bWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczov
L2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
