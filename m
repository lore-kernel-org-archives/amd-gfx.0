Return-Path: <SRS0=Rnur=AS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA6CAC433DF
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Jul 2020 14:24:15 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 265F72073E
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Jul 2020 14:24:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 265F72073E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=daenzer.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 026866E0BA;
	Tue,  7 Jul 2020 14:24:14 +0000 (UTC)
Received: from netline-mail3.netline.ch (mail.netline.ch [148.251.143.178])
 by gabe.freedesktop.org (Postfix) with ESMTP id 707166E0BA
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Jul 2020 14:24:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by netline-mail3.netline.ch (Postfix) with ESMTP id 98FD72A6048;
 Tue,  7 Jul 2020 16:24:11 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at netline-mail3.netline.ch
Received: from netline-mail3.netline.ch ([127.0.0.1])
 by localhost (netline-mail3.netline.ch [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id W1h3MbmeYQ64; Tue,  7 Jul 2020 16:24:11 +0200 (CEST)
Received: from thor (212.174.63.188.dynamic.wline.res.cust.swisscom.ch
 [188.63.174.212])
 by netline-mail3.netline.ch (Postfix) with ESMTPSA id A90912A6045;
 Tue,  7 Jul 2020 16:24:10 +0200 (CEST)
Received: from localhost ([::1]) by thor with esmtp (Exim 4.94)
 (envelope-from <michel@daenzer.net>)
 id 1jsoW2-000e0H-0m; Tue, 07 Jul 2020 16:24:10 +0200
Subject: Re: [PATCH] tests/amdgpu: set emit fence flag for multi fence
To: christian.koenig@amd.com, "Zhang, Hawking" <Hawking.Zhang@amd.com>,
 "Gao, Likun" <Likun.Gao@amd.com>
References: <20200707131504.2994506-1-likun.gao@amd.com>
 <MN2PR12MB4078A186CF4FB3333A6837F9FC660@MN2PR12MB4078.namprd12.prod.outlook.com>
 <4d37be35-273b-898b-e5f2-9e5c77947f45@gmail.com>
From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel@daenzer.net>
Message-ID: <18752702-af01-20b9-1570-d35af4c13acc@daenzer.net>
Date: Tue, 7 Jul 2020 16:24:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <4d37be35-273b-898b-e5f2-9e5c77947f45@gmail.com>
Content-Language: en-CA
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
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gMjAyMC0wNy0wNyAzOjQwIHAubS4sIENocmlzdGlhbiBLw7ZuaWcgd3JvdGU6Cj4gVGhlcmUg
aXMgYSBkb2N1bWVudCBhYm91dCBob3cgdGhlIGxpYmRybSBjb3B5IG9mIHRoZSBoZWFkZXIgaXMg
dG8gYmUKPiB1cGRhdGVkLgo+IAo+IENhbid0IGZpbmQgaXQgb2YgaGFuZCwgYnV0IG91ciB1c2Vy
c3BhY2UgZ3V5cyBzaG91bGQgYmUgYWJsZSB0byBwb2ludAo+IG91dCB3aGVyZSBpdCBpcy4KCmh0
dHBzOi8vZ2l0bGFiLmZyZWVkZXNrdG9wLm9yZy9tZXNhL2RybS8tL2Jsb2IvbWFzdGVyL2luY2x1
ZGUvZHJtL1JFQURNRQoKCi0tIApFYXJ0aGxpbmcgTWljaGVsIETDpG56ZXIgICAgICAgICAgICAg
ICB8ICAgICAgICAgICAgICAgaHR0cHM6Ly9yZWRoYXQuY29tCkxpYnJlIHNvZnR3YXJlIGVudGh1
c2lhc3QgICAgICAgICAgICAgfCAgICAgICAgICAgICBNZXNhIGFuZCBYIGRldmVsb3BlcgpfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxp
bmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVk
ZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
