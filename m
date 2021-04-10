Return-Path: <SRS0=wHtS=JH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EE24C433B4
	for <amd-gfx@archiver.kernel.org>; Sat, 10 Apr 2021 17:34:14 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A693611AE
	for <amd-gfx@archiver.kernel.org>; Sat, 10 Apr 2021 17:34:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A693611AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DF5C46EC7F;
	Sat, 10 Apr 2021 17:34:13 +0000 (UTC)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7B38B6EC7F
 for <amd-gfx@lists.freedesktop.org>; Sat, 10 Apr 2021 17:34:12 +0000 (UTC)
Received: by mail-ej1-x635.google.com with SMTP id w3so13535528ejc.4
 for <amd-gfx@lists.freedesktop.org>; Sat, 10 Apr 2021 10:34:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-transfer-encoding:content-language;
 bh=EFzvgdWwbi8rorFL9SEGfhdpnHX8dVAjO0B+uolrJvQ=;
 b=hblU2luPWRPfgfmCBlvBydgyCRqKW5JxdMdsa8q4ew86hitMMG8w9FHShhRGLy6hkj
 gIyUFxLP6B2IcojcwvIZYTH+4rnWoNhc/Gn8Ul+Wyr5S5YamQ+oPqBcnY1DWkw/ardQ1
 7gLW9M23rlHWJ9LxF6uV66IRsQZTmfDEkk2l70MqO9MOEvy0oKZF9KYGabwJKxwFZcPW
 USw31nD/tNAoTPwXkSEdi3kpZ2wa9qiC9Gh4ZDDU/mebn8TPmlVE7Q2Z/IVIAPk5DrfB
 qMdKX6ZQIPqEJABJeD5sNjgsMyki+RUpHea45uN718cv8j4md+dlhKC8OJdRP5riS2QZ
 nDIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=EFzvgdWwbi8rorFL9SEGfhdpnHX8dVAjO0B+uolrJvQ=;
 b=oxXbRdE/qH8DoN7MVBSM8zdmyFVXp9d2+xW/stbfy8T3/BFu+bpbhAaYL/35T6hw0C
 MFL9IhbEiIORcyxjTlLNKwvpgljHly9nnX5MaJkK/2oSLbnbzmnRVFvhnvRZ53HHbNSz
 o1Wjn/Tdr5a+L0x/s7UlUuyQWG82+wU/rMs4cPBc+H1X+SZZpqKeNWXk4FlbxPCxbX6t
 Ec8xPp2ZOJfOr19vTzjNkpYyo3RvIgTfsXUDKA7bMqliWbLxP6AhC6G29IKW8w8Efs2u
 d2ZTSjaMICrFDV1QoqjRANtha+OiKsfgCg4lFXt3q6WscH9tg/7UH5hqDrsUoolbd0bg
 aELw==
X-Gm-Message-State: AOAM532K3tdAa8D1OJwwguWpB+5/zjZCIet3jSQewxOF6xK3l+GV3Efe
 s5zVam7G0EDLQYZpag/EatE=
X-Google-Smtp-Source: ABdhPJyZOsaoiUmA5uCJUHN/7acqVc+jSMglSgpDyt6t4ktZAvtI08xHaUaXvP/5Mof/dKghdDHhYw==
X-Received: by 2002:a17:906:1c8f:: with SMTP id
 g15mr20323315ejh.20.1618076051085; 
 Sat, 10 Apr 2021 10:34:11 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:eeab:ef2d:fa52:f8d5?
 ([2a02:908:1252:fb60:eeab:ef2d:fa52:f8d5])
 by smtp.gmail.com with ESMTPSA id b13sm3409517edw.45.2021.04.10.10.34.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 10 Apr 2021 10:34:10 -0700 (PDT)
Subject: Re: [PATCH 0/4] Refine GPU recovery sequence to enhance its stability
To: Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 "Li, Dennis" <Dennis.Li@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "Zhang, Hawking" <Hawking.Zhang@amd.com>
References: <20210318072339.28736-1-Dennis.Li@amd.com>
 <MN2PR12MB3775531A74B886A207134B1583699@MN2PR12MB3775.namprd12.prod.outlook.com>
 <DM5PR12MB253379E8C89D8A20C8A0245AED699@DM5PR12MB2533.namprd12.prod.outlook.com>
 <378fdffb-99b5-2a14-736d-a06f310b040c@amd.com>
 <1e37bb4d-f54d-1b7e-4632-94cfcf749528@amd.com>
 <51d7873d-cf35-6be5-79c2-024937c67f6a@amd.com>
 <29ffe63b-9049-824f-84fc-a92fdb451e0d@amd.com>
 <e37bdceb-cdb2-a826-21cf-8cb88748be08@gmail.com>
 <1e4b766d-b5c2-e6b5-8be6-9b2fae3abc94@amd.com>
 <b67ab565-e4be-0809-7021-cb59fd10464a@amd.com>
 <8c2cbe39-ea05-add4-efee-65527e53bb34@gmail.com>
 <50e0907c-52d6-1fdb-aa5e-39b1c326180c@amd.com>
 <4a1e3961-8708-46b7-bfd8-86a4ee4e2726@amd.com>
 <f36bef2c-d5c2-7290-c029-2bcc9d834bbc@amd.com>
 <b3965720-ea45-7664-5927-dd3836bfa46d@amd.com>
 <32b2ab00-7514-43ce-cb28-a437c194c16a@gmail.com>
 <01f69c6f-02a3-3387-db6b-0fa1bfa9bd17@amd.com>
 <70a534b7-2e55-cdd7-2f82-3b8799967aa0@amd.com>
 <62a329d4-ffd1-3ac1-03eb-dd0089b75541@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <b6a24d3f-4fe6-c642-b478-36e386aa906d@gmail.com>
Date: Sat, 10 Apr 2021 19:34:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <62a329d4-ffd1-3ac1-03eb-dd0089b75541@amd.com>
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

SGkgQW5kcmV5LAoKQW0gMDkuMDQuMjEgdW0gMjA6MTggc2NocmllYiBBbmRyZXkgR3JvZHpvdnNr
eToKPiBbU05JUF0KPj4+Cj4+PiBJZiB3ZSB1c2UgYSBsaXN0IGFuZCBhIGZsYWcgY2FsbGVkICdl
bWl0X2FsbG93ZWQnIHVuZGVyIGEgbG9jayBzdWNoIAo+Pj4gdGhhdCBpbiBhbWRncHVfZmVuY2Vf
ZW1pdCB3ZSBsb2NrIHRoZSBsaXN0LCBjaGVjayB0aGUgZmxhZyBhbmQgaWYgCj4+PiB0cnVlIGFk
ZCB0aGUgbmV3IEhXIGZlbmNlIHRvIGxpc3QgYW5kIHByb2NlZWQgdG8gSFcgZW1pdGlvbiBhcyAK
Pj4+IG5vcm1hbCwgb3RoZXJ3aXNlIHJldHVybiB3aXRoIC1FTk9ERVYuIEluIGFtZGdwdV9wY2lf
cmVtb3ZlIHdlIHRha2UgCj4+PiB0aGUgbG9jaywgc2V0IHRoZSBmbGFnIHRvIGZhbHNlLCBhbmQg
dGhlbiBpdGVyYXRlIHRoZSBsaXN0IGFuZCBmb3JjZSAKPj4+IHNpZ25hbCBpdC4gV2lsbCB0aGlz
IG5vdCBwcmV2ZW50IGFueSBuZXcgSFcgZmVuY2UgY3JlYXRpb24gZnJvbSBub3cgCj4+PiBvbiBm
cm9tIGFueSBwbGFjZSB0cnlpbmcgdG8gZG8gc28gPwo+Pgo+PiBXYXkgdG8gbXVjaCBvdmVyaGVh
ZC4gVGhlIGZlbmNlIHByb2Nlc3NpbmcgaXMgaW50ZW50aW9uYWxseSBsb2NrIGZyZWUgCj4+IHRv
IGF2b2lkIGNhY2hlIGxpbmUgYm91bmNpbmcgYmVjYXVzZSB0aGUgSVJRIGNhbiBtb3ZlIGZyb20g
Q1BVIHRvIENQVS4KPj4KPj4gV2UgbmVlZCBzb21ldGhpbmcgd2hpY2ggYXQgbGVhc3QgdGhlIHBy
b2Nlc3Npbmcgb2YgZmVuY2VzIGluIHRoZSAKPj4gaW50ZXJydXB0IGhhbmRsZXIgZG9lc24ndCBh
ZmZlY3QgYXQgYWxsLgo+Cj4KPiBBcyBmYXIgYXMgSSBzZWUgaW4gdGhlIGNvZGUsIGFtZGdwdV9m
ZW5jZV9lbWl0IGlzIG9ubHkgY2FsbGVkIGZyb20gCj4gdGFzayBjb250ZXh0LiBBbHNvLCB3ZSBj
YW4gc2tpcCB0aGlzIGxpc3QgSSBwcm9wb3NlZCBhbmQganVzdCB1c2UgCj4gYW1kZ3B1X2ZlbmNl
X2RyaXZlcl9mb3JjZV9jb21wbGV0aW9uIGZvciBlYWNoIHJpbmcgdG8gc2lnbmFsIGFsbCAKPiBj
cmVhdGVkIEhXIGZlbmNlcy4KCkFoLCB3YWl0IGEgc2Vjb25kIHRoaXMgZ2F2ZSBtZSBhbm90aGVy
IGlkZWEuCgpTZWUgYW1kZ3B1X2ZlbmNlX2RyaXZlcl9mb3JjZV9jb21wbGV0aW9uKCk6CgphbWRn
cHVfZmVuY2Vfd3JpdGUocmluZywgcmluZy0+ZmVuY2VfZHJ2LnN5bmNfc2VxKTsKCklmIHdlIGNo
YW5nZSB0aGF0IHRvIHNvbWV0aGluZyBsaWtlOgoKYW1kZ3B1X2ZlbmNlX3dyaXRlKHJpbmcsIHJp
bmctPmZlbmNlX2Rydi5zeW5jX3NlcSArIDB4M0ZGRkZGRkYpOwoKTm90IG9ubHkgdGhlIGN1cnJl
bnRseSBzdWJtaXR0ZWQsIGJ1dCBhbHNvIHRoZSBuZXh0IDB4M0ZGRkZGRkYgZmVuY2VzIAp3aWxs
IGJlIGNvbnNpZGVyZWQgc2lnbmFsZWQuCgpUaGlzIGJhc2ljYWxseSBzb2x2ZXMgb3V0IHByb2Js
ZW0gb2YgbWFraW5nIHN1cmUgdGhhdCBuZXcgZmVuY2VzIGFyZSAKYWxzbyBzaWduYWxlZCB3aXRo
b3V0IGFueSBhZGRpdGlvbmFsIG92ZXJoZWFkIHdoYXRzb2V2ZXIuCgo+Cj4+Pj4KPj4+PiBBbHRl
cm5hdGl2ZWx5IGdyYWJiaW5nIHRoZSByZXNldCB3cml0ZSBzaWRlIGFuZCBzdG9wcGluZyBhbmQg
dGhlbiAKPj4+PiByZXN0YXJ0aW5nIHRoZSBzY2hlZHVsZXIgY291bGQgd29yayBhcyB3ZWxsLgo+
Pj4+Cj4+Pj4gQ2hyaXN0aWFuLgo+Pj4KPj4+Cj4+PiBJIGRpZG4ndCBnZXQgdGhlIGFib3ZlIGFu
ZCBJIGRvbid0IHNlZSB3aHkgSSBuZWVkIHRvIHJldXNlIHRoZSBHUFUgCj4+PiByZXNldCByd19s
b2NrLiBJIHJlbHkgb24gdGhlIFNSQ1UgdW5wbHVnIGZsYWcgZm9yIHVucGx1Zy4gQWxzbywgbm90
IAo+Pj4gY2xlYXIgdG8gbWUgd2h5IGFyZSB3ZSBmb2N1c2luZyBvbiB0aGUgc2NoZWR1bGVyIHRo
cmVhZHMsIGFueSBjb2RlIAo+Pj4gcGF0Y2ggdG8gZ2VuZXJhdGUgSFcgZmVuY2VzIHNob3VsZCBi
ZSBjb3ZlcmVkLCBzbyBhbnkgY29kZSBsZWFkaW5nIAo+Pj4gdG8gYW1kZ3B1X2ZlbmNlX2VtaXQg
bmVlZHMgdG8gYmUgdGFrZW4gaW50byBhY2NvdW50IHN1Y2ggYXMsIGRpcmVjdCAKPj4+IElCIHN1
Ym1pc3Npb25zLCBWTSBmbHVzaGVzIGUudC5jCj4+Cj4+IFlvdSBuZWVkIHRvIHdvcmsgdG9nZXRo
ZXIgd2l0aCB0aGUgcmVzZXQgbG9jayBhbnl3YXksIGNhdXNlIGEgaG90cGx1ZyAKPj4gY291bGQg
cnVuIGF0IHRoZSBzYW1lIHRpbWUgYXMgYSByZXNldC4KPgo+Cj4gRm9yIGdvaW5nIG15IHdheSBp
bmRlZWQgbm93IEkgc2VlIG5vdyB0aGF0IEkgaGF2ZSB0byB0YWtlIHJlc2V0IHdyaXRlIAo+IHNp
ZGUgbG9jayBkdXJpbmcgSFcgZmVuY2VzIHNpZ25hbGxpbmcgaW4gb3JkZXIgdG8gcHJvdGVjdCBh
Z2FpbnN0IAo+IHNjaGVkdWxlci9IVyBmZW5jZXMgZGV0YWNobWVudCBhbmQgcmVhdHRhY2htZW50
IGR1cmluZyBzY2hlZHVsZXJzIAo+IHN0b3AvcmVzdGFydC4gQnV0IGlmIHdlIGdvIHdpdGggeW91
ciBhcHByb2FjaMKgIHRoZW4gY2FsbGluZyAKPiBkcm1fZGV2X3VucGx1ZyBhbmQgc2NvcGluZyBh
bWRncHVfam9iX3RpbWVvdXQgd2l0aCBkcm1fZGV2X2VudGVyL2V4aXQgCj4gc2hvdWxkIGJlIGVu
b3VnaCB0byBwcmV2ZW50IGFueSBjb25jdXJyZW50IEdQVSByZXNldHMgZHVyaW5nIHVucGx1Zy4g
Cj4gSW4gZmFjdCBJIGFscmVhZHkgZG8gaXQgYW55d2F5IC0gCj4gaHR0cHM6Ly9jZ2l0LmZyZWVk
ZXNrdG9wLm9yZy9+YWdyb2R6b3YvbGludXgvY29tbWl0Lz9oPWRybS1taXNjLW5leHQmaWQ9ZWYw
ZWE0ZGQyOWVmNDRkMjY0OWM1ZWRhMTZjOGY0ODY5YWNjMzZiMQoKWWVzLCBnb29kIHBvaW50IGFz
IHdlbGwuCgpDaHJpc3RpYW4uCgo+Cj4gQW5kcmV5Cj4KPgo+Pgo+Pgo+PiBDaHJpc3RpYW4uCj4+
Cj4+Pgo+Pj4gQW5kcmV5Cj4+Pgo+Pj4KPj4+Pgo+Pj4+Pgo+Pj4+PiBDaHJpc3RpYW4uCj4+Pj4+
Cj4+Pj4+Pgo+Pj4+Pj4gQW5kcmV5Cj4+Pj4+Pgo+Pj4+Pj4KPj4+Pj4+Pgo+Pj4+Pj4+PiBBbmRy
ZXkKPj4+Pj4+Pj4KPj4+Pj4+Pj4KPj4+Pj4+Pgo+Pj4+Pgo+Pj4+Cj4+CgpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAph
bWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9y
Zy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
