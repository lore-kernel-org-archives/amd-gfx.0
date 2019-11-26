Return-Path: <SRS0=NdEU=ZS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C52CC432C0
	for <amd-gfx@archiver.kernel.org>; Tue, 26 Nov 2019 12:12:37 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 794B62075C
	for <amd-gfx@archiver.kernel.org>; Tue, 26 Nov 2019 12:12:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 794B62075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 319C789C37;
	Tue, 26 Nov 2019 12:12:37 +0000 (UTC)
Received: from mail-yb1-xb41.google.com (mail-yb1-xb41.google.com
 [IPv6:2607:f8b0:4864:20::b41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1FF6B89C37
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 Nov 2019 12:12:35 +0000 (UTC)
Received: by mail-yb1-xb41.google.com with SMTP id h23so7367531ybg.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 Nov 2019 04:12:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:cc:references:from
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-transfer-encoding:content-language;
 bh=KvBO29KxZ+3PSjABgw8LnE3+6ZP1VdWB7C+dMMpgYIc=;
 b=RvHNWhm64pMlf/OU62L8/m/3TknnDWU2KR44a2ba+OJLydKgiFEk/+y8d5At0K/Ke4
 HWrKnBu3IpxcNoMf9dmPl7Pfd2apzn7052/ay1dLafP2cVm7o0+mBMJhB24G5vHENdkJ
 ihDRXb3oyNory3Ur6UYWzgG/fcKqiGoxPapTWjczcpyW75BEmvW9r9dand7MwqQCxEZ0
 zKP0hgbRoMKhu23eG9sBwIMrJ5sPixFZpInO5G318A9VKffrRt9N6S4KKqLcEOcnt/HE
 0yeGOmRrm5g07GTBOK8TMRWORQSiv9DhEkEnE6t0Gt+Mo8hqBP+pmIK4e+rzbk13VaBr
 IQmQ==
X-Gm-Message-State: APjAAAXImGLJ+2jd1bQX1If2ooRlpKMtnhIUcqhBTl+3q5E0czCFlI2o
 uMic7vvfAyGMyBhEbWiP6QU=
X-Google-Smtp-Source: APXvYqz+pbcHlbzuokYA4pWh5aTV5bOIqc6K8kTMBF3Z81r/Xs6eSV0oidObV+mb1CWBISCS60HSVw==
X-Received: by 2002:a25:7182:: with SMTP id
 m124mr26648151ybc.487.1574770354206; 
 Tue, 26 Nov 2019 04:12:34 -0800 (PST)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7?
 ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
 by smtp.gmail.com with ESMTPSA id j79sm5122366ywa.100.2019.11.26.04.12.32
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 26 Nov 2019 04:12:33 -0800 (PST)
Subject: Re: [PATCH] drm/amdgpu: flag vram lost on baco reset for VI/CIK
To: "Quan, Evan" <Evan.Quan@amd.com>, Alex Deucher <alexdeucher@gmail.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20191125161239.347655-1-alexander.deucher@amd.com>
 <MN2PR12MB334444E864912858AB31DE4FE4450@MN2PR12MB3344.namprd12.prod.outlook.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <c8cf241f-212a-3773-98f3-9db5548331a9@gmail.com>
Date: Tue, 26 Nov 2019 13:12:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <MN2PR12MB334444E864912858AB31DE4FE4450@MN2PR12MB3344.namprd12.prod.outlook.com>
Content-Language: en-US
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20161025;
 h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=KvBO29KxZ+3PSjABgw8LnE3+6ZP1VdWB7C+dMMpgYIc=;
 b=bjZUzuLVskojXR7hbLc5EU7QlVgqAcuA5ljScQHVPt40dZBf4txf9L+TzkAH1e3v4f
 iRYWTi+dkbI92jGGF17OCv6nSUG8mQvphEibHMZww3DsgJYu1/XgXr+rFnJAoNeGaeIr
 7RSnK7nxX89DIQOQBswcCjeu/QKxpifPEv+UN3usUgo8iUCUnD+jTiG9IThYiC3+zgXs
 xRW9XC3dv/CvP0RDtE9wPEQdX0pgka/eSEAEODpZ5dmnLxYyhzOhrblwnhHn0S/02Ya9
 Er0D3SoEvVV1KnM93XJNwKV7GZpQ3NaM1Q6Wtxe6K0M0b3f2ZU7pLntpWcvwFxyombo5
 VDDg==
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
Reply-To: christian.koenig@amd.com
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191126121231._s_Lw9e0g-hgEtXlBXm2RlovG_VpgnpGQJTj-SnDfqs@z>

QWNrZWQtYnk6IENocmlzdGlhbiBLw7ZuaWcgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4KCkFt
IDI2LjExLjE5IHVtIDA0OjExIHNjaHJpZWIgUXVhbiwgRXZhbjoKPiBBY2tlZC1ieTogRXZhbiBR
dWFuIDxldmFuLnF1YW5AYW1kLmNvbT4KPgo+PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQo+
PiBGcm9tOiBhbWQtZ2Z4IDxhbWQtZ2Z4LWJvdW5jZXNAbGlzdHMuZnJlZWRlc2t0b3Aub3JnPiBP
biBCZWhhbGYgT2YgQWxleAo+PiBEZXVjaGVyCj4+IFNlbnQ6IFR1ZXNkYXksIE5vdmVtYmVyIDI2
LCAyMDE5IDEyOjEzIEFNCj4+IFRvOiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwo+PiBD
YzogRGV1Y2hlciwgQWxleGFuZGVyIDxBbGV4YW5kZXIuRGV1Y2hlckBhbWQuY29tPgo+PiBTdWJq
ZWN0OiBbUEFUQ0hdIGRybS9hbWRncHU6IGZsYWcgdnJhbSBsb3N0IG9uIGJhY28gcmVzZXQgZm9y
IFZJL0NJSwo+Pgo+PiBWSS9DSUsgQkFDTyB3YXMgaW5mbGlnaHQgd2hlbiB0aGlzIGZpeCBsYW5k
ZWQgZm9yIFNPQzE1L05WLgo+PiBBZGQgdGhlIGZpeCB0byBWSS9DSUsgYXMgd2VsbC4KPj4KPj4g
U2lnbmVkLW9mZi1ieTogQWxleCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPgo+
PiAtLS0KPj4gICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9jaWsuYyB8IDcgKysrKystLQo+
PiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS92aS5jICB8IDcgKysrKystLQo+PiAgIDIgZmls
ZXMgY2hhbmdlZCwgMTAgaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkKPj4KPj4gZGlmZiAt
LWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2Npay5jCj4+IGIvZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvY2lrLmMKPj4gaW5kZXggOTY4YmM3MDZiOTRkLi4xZGZlNGExMzM3Y2Yg
MTAwNjQ0Cj4+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2Npay5jCj4+ICsrKyBi
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2Npay5jCj4+IEBAIC0xMzYzLDEwICsxMzYzLDEz
IEBAIHN0YXRpYyBpbnQgY2lrX2FzaWNfcmVzZXQoc3RydWN0IGFtZGdwdV9kZXZpY2UKPj4gKmFk
ZXYpICB7Cj4+ICAgCWludCByOwo+Pgo+PiAtCWlmIChjaWtfYXNpY19yZXNldF9tZXRob2QoYWRl
dikgPT0gQU1EX1JFU0VUX01FVEhPRF9CQUNPKQo+PiArCWlmIChjaWtfYXNpY19yZXNldF9tZXRo
b2QoYWRldikgPT0gQU1EX1JFU0VUX01FVEhPRF9CQUNPKSB7Cj4+ICsJCWlmICghYWRldi0+aW5f
c3VzcGVuZCkKPj4gKwkJCWFtZGdwdV9pbmNfdnJhbV9sb3N0KGFkZXYpOwo+PiAgIAkJciA9IHNt
dTdfYXNpY19iYWNvX3Jlc2V0KGFkZXYpOwo+PiAtCWVsc2UKPj4gKwl9IGVsc2Ugewo+PiAgIAkJ
ciA9IGNpa19hc2ljX3BjaV9jb25maWdfcmVzZXQoYWRldik7Cj4+ICsJfQo+Pgo+PiAgIAlyZXR1
cm4gcjsKPj4gICB9Cj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS92
aS5jCj4+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvdmkuYyBpbmRleCA4NzFjMGI4YzZi
MGIuLmU0ZjQyMDFiM2MzNAo+PiAxMDA2NDQKPj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvdmkuYwo+PiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS92aS5jCj4+IEBA
IC04MDQsMTAgKzgwNCwxMyBAQCBzdGF0aWMgaW50IHZpX2FzaWNfcmVzZXQoc3RydWN0IGFtZGdw
dV9kZXZpY2UgKmFkZXYpCj4+IHsKPj4gICAJaW50IHI7Cj4+Cj4+IC0JaWYgKHZpX2FzaWNfcmVz
ZXRfbWV0aG9kKGFkZXYpID09IEFNRF9SRVNFVF9NRVRIT0RfQkFDTykKPj4gKwlpZiAodmlfYXNp
Y19yZXNldF9tZXRob2QoYWRldikgPT0gQU1EX1JFU0VUX01FVEhPRF9CQUNPKSB7Cj4+ICsJCWlm
ICghYWRldi0+aW5fc3VzcGVuZCkKPj4gKwkJCWFtZGdwdV9pbmNfdnJhbV9sb3N0KGFkZXYpOwo+
PiAgIAkJciA9IHNtdTdfYXNpY19iYWNvX3Jlc2V0KGFkZXYpOwo+PiAtCWVsc2UKPj4gKwl9IGVs
c2Ugewo+PiAgIAkJciA9IHZpX2FzaWNfcGNpX2NvbmZpZ19yZXNldChhZGV2KTsKPj4gKwl9Cj4+
Cj4+ICAgCXJldHVybiByOwo+PiAgIH0KPj4gLS0KPj4gMi4yMy4wCj4+Cj4+IF9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCj4+IGFtZC1nZnggbWFpbGluZyBs
aXN0Cj4+IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCj4+IGh0dHBzOi8vbmFtMTEuc2Fm
ZWxpbmtzLnByb3RlY3Rpb24ub3V0bG9vay5jb20vP3VybD1odHRwcyUzQSUyRiUyRmxpc3RzLmZy
ZWUKPj4gZGVza3RvcC5vcmclMkZtYWlsbWFuJTJGbGlzdGluZm8lMkZhbWQtCj4+IGdmeCZhbXA7
ZGF0YT0wMiU3QzAxJTdDZXZhbi5xdWFuJTQwYW1kLmNvbSU3QzhhNTgwMjZiNjZkMjQ4YjI3ZQo+
PiAyMjA4ZDc3MWMyNTUxOCU3QzNkZDg5NjFmZTQ4ODRlNjA4ZTExYTgyZDk5NGUxODNkJTdDMCU3
QzElN0M2MzcKPj4gMTAyOTUxODE0MjAwNjE3JmFtcDtzZGF0YT03bEtOZkc4TnB6QktzbEtJb092
c2V5bDJhd2xNMURjeFNObnR2JTJGCj4+IFVBQ2p3JTNEJmFtcDtyZXNlcnZlZD0wCj4gX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KPiBhbWQtZ2Z4IG1haWxp
bmcgbGlzdAo+IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCj4gaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4CgpfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQt
Z2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9t
YWlsbWFuL2xpc3RpbmZvL2FtZC1nZng=
