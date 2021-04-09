Return-Path: <SRS0=E5im=JG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE237C433B4
	for <amd-gfx@archiver.kernel.org>; Fri,  9 Apr 2021 07:01:13 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 585C7610FC
	for <amd-gfx@archiver.kernel.org>; Fri,  9 Apr 2021 07:01:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 585C7610FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D46166E47B;
	Fri,  9 Apr 2021 07:01:12 +0000 (UTC)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CDB116E47B
 for <amd-gfx@lists.freedesktop.org>; Fri,  9 Apr 2021 07:01:11 +0000 (UTC)
Received: by mail-ed1-x52e.google.com with SMTP id f8so5279038edd.11
 for <amd-gfx@lists.freedesktop.org>; Fri, 09 Apr 2021 00:01:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-transfer-encoding:content-language;
 bh=x7NnMW9aAK+vUD6XQ+axK9qv4n712Qhl3wDC+cLYuFw=;
 b=R3BA0XulULqKBFrDoSzAzym59ww02lORU07emqt/WfPnZRNn9DY6Lfv2nOG7LLgGqU
 ih7Y4QuDxOosf44kMvYTxBw4YjH9cWg50oSSEpS0SuDxCDy1B5iY6Hw9xtbcnALvnF+m
 8QvJmYVi3XkR8axfOp5PecLJM7VKNwNTlF6D6Ui0BkejsLUWMZo4jKLkjRC4Z8dUVowF
 AQUdTkBjC0wiGJW0AqZXJmCMFKHLsjmKySVd1xqMPfg2BFDMDeMhwkYP2j1M7/IYSeYy
 n23BJ29LR/A/m/9GZkx2Vlp5ZRIDk8e73cCJNZ6wGWYJFe5yP3UJUmO0ZqUlAOpFQZa9
 ecKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=x7NnMW9aAK+vUD6XQ+axK9qv4n712Qhl3wDC+cLYuFw=;
 b=rAJvzENOvG3bNiQ2Du2DhyKeyt1kNXjjcTO4O2eWnv32xuN+LXlDjCNkxjfnnIdlOx
 uGoya+y56ujLbPWizdvfHisTEvULK9pTv/s1o+vWjzXrwQ6qgtSn5wu68f+Jwlf5tPr8
 qEPGspJUlKO5xJvV7aeduoxj+jXDrfNZ5Atvslor+sIYcUFzcHGKhpxoIeRXfy3o6bSu
 ln5YtX0Al/hoaAkWRNBULDeQGE9G5FekYcCHrG61nUmr+Z0zKkxEH1tCIiGmvExSB4YE
 cvIYDCZ+6ag8pgDVklqGZaa9yGFA29kbuZz91980B8vzMTE9QXBot7DbcDbLJ2GGLNfC
 nKEw==
X-Gm-Message-State: AOAM531myy/gn/SnvvzwE8KcFAYtD+U3UzEbUbFrzs0fEOqHbUAbeHer
 T2ueitR4UZPseG3DM/ocSvada/mQfpE=
X-Google-Smtp-Source: ABdhPJxrgXliZLuXN46Vz4R24KHO2K4sms9vvcxpC/06AP0h/nVJhP6iilENmtZmsMqfPzfdKT+sFQ==
X-Received: by 2002:a05:6402:254a:: with SMTP id
 l10mr15985103edb.160.1617951670461; 
 Fri, 09 Apr 2021 00:01:10 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:2f79:f442:c4cd:830e?
 ([2a02:908:1252:fb60:2f79:f442:c4cd:830e])
 by smtp.gmail.com with ESMTPSA id c19sm878165edu.20.2021.04.09.00.01.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 09 Apr 2021 00:01:10 -0700 (PDT)
Subject: Re: [PATCH 0/4] Refine GPU recovery sequence to enhance its stability
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Andrey Grodzovsky <andrey.grodzovsky@amd.com>, "Li, Dennis"
 <Dennis.Li@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "Zhang, Hawking" <Hawking.Zhang@amd.com>
References: <20210318072339.28736-1-Dennis.Li@amd.com>
 <d40648ba-9948-5442-23ed-d352f824f8f9@amd.com>
 <DM5PR12MB25330F3CD92C587C2E921424ED699@DM5PR12MB2533.namprd12.prod.outlook.com>
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
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <32b2ab00-7514-43ce-cb28-a437c194c16a@gmail.com>
Date: Fri, 9 Apr 2021 09:01:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <b3965720-ea45-7664-5927-dd3836bfa46d@amd.com>
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

QW0gMDkuMDQuMjEgdW0gMDg6NTMgc2NocmllYiBDaHJpc3RpYW4gS8O2bmlnOgo+IEFtIDA4LjA0
LjIxIHVtIDIyOjM5IHNjaHJpZWIgQW5kcmV5IEdyb2R6b3Zza3k6Cj4+Cj4+IE9uIDIwMjEtMDQt
MDggMjo1OCBwLm0uLCBDaHJpc3RpYW4gS8O2bmlnIHdyb3RlOgo+Pj4gQW0gMDguMDQuMjEgdW0g
MTg6MDggc2NocmllYiBBbmRyZXkgR3JvZHpvdnNreToKPj4+PiBPbiAyMDIxLTA0LTA4IDQ6MzIg
YS5tLiwgQ2hyaXN0aWFuIEvDtm5pZyB3cm90ZToKPj4+Pj4gQW0gMDguMDQuMjEgdW0gMTA6MjIg
c2NocmllYiBDaHJpc3RpYW4gS8O2bmlnOgo+Pj4+Pj4gW1NOSVBdCj4+Pj4+Pj4+Cj4+Pj4+Pj4+
Cj4+Pj4+Pj4+PiBCZXlvbmQgYmxvY2tpbmcgYWxsIGRlbGF5ZWQgd29ya3MgYW5kIHNjaGVkdWxl
ciB0aHJlYWRzIHdlIAo+Pj4+Pj4+Pj4gYWxzbyBuZWVkIHRvIGd1YXJhbnRlZSBub8KgIElPQ1RM
IGNhbiBhY2Nlc3MgTU1JTyBwb3N0IGRldmljZSAKPj4+Pj4+Pj4+IHVucGx1ZyBPUiBpbiBmbGln
aHQgSU9DVExzIGFyZSBkb25lIGJlZm9yZSB3ZSBmaW5pc2ggCj4+Pj4+Pj4+PiBwY2lfcmVtb3Zl
IChhbWRncHVfcGNpX3JlbW92ZSBmb3IgdXMpLgo+Pj4+Pj4+Pj4gRm9yIHRoaXMgSSBzdWdnZXN0
IHdlIGRvIHNvbWV0aGluZyBsaWtlIHdoYXQgd2Ugd29ya2VkIG9uIHdpdGggCj4+Pj4+Pj4+PiBU
YWthc2hpIEl3YWkgdGhlIEFMU0EgbWFpbnRhaW5lciByZWNlbnRseSB3aGVuIGhlIGhlbHBlZCAK
Pj4+Pj4+Pj4+IGltcGxlbWVudGluZyBQQ0kgQkFScyBtb3ZlIHN1cHBvcnQgZm9yIHNuZF9oZGFf
aW50ZWwuIFRha2UgYSAKPj4+Pj4+Pj4+IGxvb2sgYXQKPj4+Pj4+Pj4+IGh0dHBzOi8vY2dpdC5m
cmVlZGVza3RvcC5vcmcvfmFncm9kem92L2xpbnV4L2NvbW1pdC8/aD15YWRyby9wY2llX2hvdHBs
dWcvbW92YWJsZV9iYXJzX3Y5LjEmaWQ9Y2JhYTMyNDc5OTcxOGUyYjgyOGE4YzdiNWIwMDFkZDg5
Njc0ODQ5NyAKPj4+Pj4+Pj4+IGFuZAo+Pj4+Pj4+Pj4gaHR0cHM6Ly9jZ2l0LmZyZWVkZXNrdG9w
Lm9yZy9+YWdyb2R6b3YvbGludXgvY29tbWl0Lz9oPXlhZHJvL3BjaWVfaG90cGx1Zy9tb3ZhYmxl
X2JhcnNfdjkuMSZpZD1lMzYzNjVkOWFiNWJiYzMwYmRjMjIxYWI0YjM0MzdkZTM0NDkyNDQwIAo+
Pj4+Pj4+Pj4KPj4+Pj4+Pj4+IFdlIGFsc28gaGFkIHNhbWUgaXNzdWUgdGhlcmUsIGhvdyB0byBw
cmV2ZW50IE1NSU8gYWNjZXNzZXMgCj4+Pj4+Pj4+PiB3aGlsZSB0aGUgQkFScyBhcmUgbWlncmF0
aW5nLiBXaGF0IHdhcyBkb25lIHRoZXJlIGlzIGEgCj4+Pj4+Pj4+PiByZWZjb3VudCB3YXMgYWRk
ZWQgdG8gY291bnQgYWxsIElPQ1RMcyBpbiBmbGlnaHQsIGZvciBhbnkgaW4gCj4+Pj4+Pj4+PiBm
bGlnaHTCoCBJT0NUTCB0aGUgQkFSIG1pZ3JhdGlvbiBoYW5kbGVyIHdvdWxkCj4+Pj4+Pj4+PiBi
bG9jayBmb3IgdGhlIHJlZmNvdW50IHRvIGRyb3AgdG8gMCBiZWZvcmUgaXQgd291bGQgcHJvY2Vl
ZCwgCj4+Pj4+Pj4+PiBmb3IgYW55IGxhdGVyIElPQ1RMIGl0IHN0b3BzIGFuZCB3YWl0IGlmIGRl
dmljZSBpcyBpbiAKPj4+Pj4+Pj4+IG1pZ3JhdGlvbiBzdGF0ZS4gV2UgZXZlbiBkb24ndCBuZWVk
IHRoZSB3YWl0IHBhcnQsIG5vdGhpbmcgdG8gCj4+Pj4+Pj4+PiB3YWl0IGZvciwgd2UganVzdCBy
ZXR1cm4gd2l0aCAtRU5PREVWIGZvciB0aGlzIGNhc2UuCj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pgo+Pj4+
Pj4+PiBUaGlzIGlzIGVzc2VudGlhbGx5IHdoYXQgdGhlIERSTSBTUkNVIGlzIGRvaW5nIGFzIHdl
bGwuCj4+Pj4+Pj4+Cj4+Pj4+Pj4+IEZvciB0aGUgaG90cGx1ZyBjYXNlIHdlIGNvdWxkIGRvIHRo
aXMgaW4gdGhlIHRvcGxldmVsIHNpbmNlIHdlIAo+Pj4+Pj4+PiBjYW4gc2lnbmFsIHRoZSBmZW5j
ZSBhbmQgZG9uJ3QgbmVlZCB0byBibG9jayBtZW1vcnkgbWFuYWdlbWVudC4KPj4+Pj4+Pgo+Pj4+
Pj4+Cj4+Pj4+Pj4gVG8gbWFrZSBTUkNVICd3YWl0IGZvcicgYWxsIElPQ1RMcyBpbiBmbGlnaHQg
d2Ugd291bGQgbmVlZCB0byAKPj4+Pj4+PiB3cmFwIGV2ZXJ5IElPQ1RMICggcHJhY3RpY2FsbHkg
LSBqdXN0IGRybV9pb2N0bCBmdW5jdGlvbikgd2l0aCAKPj4+Pj4+PiBkcm1fZGV2X2VudGVyL2Ry
bV9kZXZfZXhpdCAtIGNhbiB3ZSBkbyBpdCA/Cj4+Pj4+Pj4KPj4+Pj4KPj4+Pj4gU29ycnkgdG90
YWxseSBtaXNzZWQgdGhpcyBxdWVzdGlvbi4KPj4+Pj4KPj4+Pj4gWWVzLCBleGFjdGx5IHRoYXQu
IEFzIGRpc2N1c3NlZCBmb3IgdGhlIGhvdHBsdWcgY2FzZSB3ZSBjYW4gZG8gdGhpcy4KPj4+Pgo+
Pj4+Cj4+Pj4gVGhpbmtpbmcgbW9yZSBhYm91dCBpdCAtIGFzc3VtaW5nIHdlIGFyZcKgIHRyZWF0
aW5nIHN5bmNocm9uaXplX3NyY3UgCj4+Pj4gYXMgYSAnd2FpdCBmb3IgY29tcGxldGlvbicgb2Yg
YW55IGluIGZsaWdodCB7ZHJtX2Rldl9lbnRlciwgCj4+Pj4gZHJtX2Rldl9leGl0fSBzY29wZSwg
c29tZSBvZiB0aG9zZSBzY29wZXMgbWlnaHQgZG8gZG1hX2ZlbmNlX3dhaXQgCj4+Pj4gaW5zaWRl
LiBTaW5jZSB3ZSBoYXZlbid0IGZvcmNlIHNpZ25hbGVkIHRoZSBmZW5jZXMgeWV0IHdlIHdpbGwg
ZW5kIAo+Pj4+IHVwIGEgZGVhZGxvY2suIFdlIGhhdmUgdG8gc2lnbmFsIGFsbCB0aGUgdmFyaW91
cyBmZW5jZXMgYmVmb3JlIAo+Pj4+IGRvaW5nIHRoZSAnd2FpdCBmb3InLiBCdXQgd2UgY2FuJ3Qg
c2lnbmFsIHRoZSBmZW5jZXMgYmVmb3JlIHNldHRpbmcgCj4+Pj4gJ2Rldi0+dW5wbHVnZ2VkID0g
dHJ1ZScgdG8gcmVqZWN0IGZ1cnRoZXIgQ1MgYW5kIG90aGVyIHN0dWZmIHdoaWNoIAo+Pj4+IG1p
Z2h0IGNyZWF0ZSBtb3JlIGZlbmNlcyB3ZSB3ZXJlIHN1cHBvc2VkLXRvIGZvcmNlIHNpZ25hbCBh
bmQgbm93IAo+Pj4+IG1pc3NlZCB0aGVtLiBFZmZlY3RpdmVseSBzZXR0aW5nICdkZXYtPnVucGx1
Z2dlZCA9IHRydWUnIGFuZCBkb2luZyAKPj4+PiBzeW5jaHJvbml6ZV9zcmN1IGluIG9uZSBjYWxs
IGxpa2UgZHJtX2Rldl91bnBsdWcgZG9lcyB3aXRob3V0IAo+Pj4+IHNpZ25hbGxpbmcgYWxsIHRo
ZSBmZW5jZXMgaW4gdGhlIGRldmljZSBpbiBiZXR3ZWVuIHRoZXNlIHR3byBzdGVwcyAKPj4+PiBs
b29rcyBsdWNrIGEgcG9zc2libGUgZGVhZGxvY2sgdG8gbWUgLSB3aGF0IGRvIHlvdSB0aGluayA/
Cj4+Pj4KPj4+Cj4+PiBJbmRlZWQsIHRoYXQgaXMgYSByZWFsbHkgZ29vZCBhcmd1bWVudCB0byBo
YW5kbGUgaXQgdGhlIHNhbWUgd2F5IGFzIAo+Pj4gdGhlIHJlc2V0IGxvY2suCj4+Pgo+Pj4gRS5n
LiBub3QgdGFraW5nIGl0IGF0IHRoZSBoaWdoIGxldmVsIElPQ1RMLCBidXQgcmF0aGVyIHdoZW4g
dGhlIAo+Pj4gZnJvbnRlbmQgb2YgdGhlIGRyaXZlciBoYXMgYWNxdWlyZWQgYWxsIHRoZSBuZWNl
c3NhcnkgbG9ja3MgKEJPIAo+Pj4gcmVzdiwgVk0gbG9jayBldGMuLi4pIGJlZm9yZSBjYWxsaW5n
IGludG8gdGhlIGJhY2tlbmQgdG8gYWN0dWFsbHkgZG8gCj4+PiB0aGluZ3Mgd2l0aCB0aGUgaGFy
ZHdhcmUuCj4+Pgo+Pj4gQ2hyaXN0aWFuLgo+Pgo+PiBGcm9tIHdoYXQgeW91IHNhaWQgSSB1bmRl
cnN0YW5kIHRoYXQgeW91IHdhbnQgdG8gc29sdmUgdGhpcyBwcm9ibGVtIAo+PiBieSB1c2luZyBk
cm1fZGV2X2VudGVyL2V4aXQgYnJhY2tldHMgbG93IGVub3VnaCBpbiB0aGUgY29kZSBzdWNoIHRo
YXQgCj4+IGl0IHdpbGwgbm90IGluY2x1ZGUgYW5kIGZlbmNlIHdhaXQuCj4+Cj4+IEJ1dCBpbnNl
cnRpbmcgZG1yX2Rldl9lbnRlci9leGl0IG9uIHRoZSBoaWdoZXN0IGxldmVsIGluIGRybV9pb2N0
bCBpcyAKPj4gbXVjaCBsZXNzIGVmZm9ydCBhbmQgbGVzcyByb29tIGZvciBlcnJvciB0aGVuIGdv
aW5nIHRocm91Z2ggZWFjaCAKPj4gSU9DVEwgYW5kIHRyeWluZyB0byBpZGVudGlmeSBhdCB3aGF0
IHBvaW50IChwb3NzaWJseSBtdWx0aXBsZSBwb2ludHMpIAo+PiB0aGV5IGFyZSBhYm91dCB0byBh
Y2Nlc3MgSFcsIHNvbWUgb2YgdGhpcyBpcyBoaWRkZW4gZGVlcCBpbiBIQUwgCj4+IGxheWVycyBz
dWNoIGFzIERDIGxheWVyIGluIGRpc3BsYXkgZHJpdmVyIG9yIHRoZSBtdWx0aSBsYXllcnMgb2Yg
Cj4+IHBvd2VycGxheS9TTVUgbGlicmFyaWVzLiBBbHNvLCB3ZSBjYW4ndCBvbmx5IGxpbWl0IG91
ci1zZWxmIHRvIAo+PiBiYWNrLWVuZCBpZiBieSB0aGlzIHlvdSBtZWFuIEFTSUMgc3BlY2lmaWMg
ZnVuY3Rpb25zIHdoaWNoIGFjY2VzcyAKPj4gcmVnaXN0ZXJzLiBXZSBhbHNvIG5lZWQgdG8gdGFr
ZSBjYXJlIG9mIGFueSBNTUlPIGtlcm5lbCBCTyAoVlJBTSBCT3MpIAo+PiB3aGVyZSB3ZSBtYXkg
YWNjZXNzIGRpcmVjdGx5IE1NSU8gc3BhY2UgYnkgcG9pbnRlciBmcm9tIHRoZSBmcm9udCBlbmQg
Cj4+IG9mIHRoZSBkcml2ZXIgKEhXIGFnbm9zdGljKSBhbmQgVFRNL0RSTSBsYXllcnMuCj4KPiBF
eGFjdGx5LCB5ZXMuIFRoZSBrZXkgcG9pbnQgaXMgd2UgbmVlZCB0byBpZGVudGlmeSBzdWNoIHBs
YWNlcyBhbnl3YXkgCj4gZm9yIEdQVSByZXNldCB0byB3b3JrIHByb3Blcmx5LiBTbyB3ZSBjb3Vs
ZCBqdXN0IHBpZ2d5IGJhY2sgaG90cGx1ZyBvbiAKPiB0b3Agb2YgdGhhdCB3b3JrIGFuZCBhcmUg
ZG9uZS4KPgo+Pgo+PiBPdXIgcHJvYmxlbSBoZXJlIGlzIGhvdyB0byBzaWduYWwgYWxsIHRoZSBl
eGlzdGluZ8KgIGZlbmNlcyBvbiBvbmUgCj4+IGhhbmQgYW5kIG9uIHRoZSBvdGhlciBwcmV2ZW50
IGFueSBuZXcgZG1hX2ZlbmNlIHdhaXRzIGFmdGVyIHdlIAo+PiBmaW5pc2hlZCBzaWduYWxpbmcg
ZXhpc3RpbmcgZmVuY2VzLiBPbmNlIHdlIHNvbHZlZCB0aGlzIHRoZW4gdGhlcmUgaXMgCj4+IG5v
IHByb2JsZW0gdXNpbmcgZHJtX2Rldl91bnBsdWcgaW4gY29uanVuY3Rpb24gd2l0aCAKPj4gZHJt
X2Rldl9lbnRlci9leGl0IGF0IHRoZSBoaWdoZXN0IGxldmVsIG9mIGRybV9pb2N0bCB0byBmbHVz
aCBhbnkgCj4+IElPQ1RMcyBpbiBmbGlnaHQgYW5kIGJsb2NrIGFueSBuZXcgb25lcy4KPj4KPj4g
SU1ITyB3aGVuIHdlIHNwZWFrIGFib3V0IHNpZ25hbGxpbmcgYWxsIGZlbmNlcyB3ZSBkb24ndCBt
ZWFuIEFMTCB0aGUgCj4+IGN1cnJlbnRseSBleGlzdGluZyBkbWFfZmVuY2Ugc3RydWN0cyAodGhl
eSBhcmUgc3ByZWFkIGFsbCBvdmVyIHRoZSAKPj4gcGxhY2UpIGJ1dCByYXRoZXIgc2lnbmFsIGFs
bCB0aGUgSFcgZmVuY2VzIGJlY2F1c2UgSFcgaXMgd2hhdCdzIGdvbmUgCj4+IGFuZCB3ZSBjYW4n
dCBleHBlY3QgZm9yIHRob3NlIGZlbmNlcyB0byBiZSBldmVyIHNpZ25hbGVkLiBBbGwgdGhlIAo+
PiByZXN0IHN1Y2ggYXM6IHNjaGVkdWxlciBmZW5jZXMswqAgdXNlciBmZW5jZXMsIGRybV9nZW0g
cmVzZXJ2YXRpb24gCj4+IG9iamVjdHMgZS50LmMuIGFyZSBlaXRoZXIgZGVwZW5kZW50IG9uIHRo
b3NlIEhXIGZlbmNlcyBhbmQgaGVuY2UgCj4+IHNpZ25hbGluZyB0aGUgSFcgZmVuY2VzIHdpbGwg
aW4gdHVybiBzaWduYWwgdGhlbSBvciwgYXJlIG5vdCBpbXBhY3RlZCAKPj4gYnkgdGhlIEhXIGJl
aW5nIGdvbmUgYW5kIGhlbmNlIGNhbiBzdGlsbCBiZSB3YWl0ZWQgb24gYW5kIHdpbGwgCj4+IGNv
bXBsZXRlLiBJZiB0aGlzIGFzc3VtcHRpb24gaXMgY29ycmVjdCB0aGVuIEkgdGhpbmsgdGhhdCB3
ZSBzaG91bGQgCj4+IHVzZSBzb21lIGZsYWcgdG8gcHJldmVudCBhbnkgbmV3IHN1Ym1pc3Npb24g
dG8gSFcgd2hpY2ggY3JlYXRlcyBIVyAKPj4gZmVuY2VzIChzb21ld2hlcmUgYXJvdW5kIGFtZGdw
dV9mZW5jZV9lbWl0KSwgdGhlbiB0cmF2ZXJzZSBhbGwgCj4+IGV4aXN0aW5nIEhXIGZlbmNlcyAo
Y3VycmVudGx5IHRoZXkgYXJlIHNwcmVhZCBpbiBhIGZldyBwbGFjZXMgc28gCj4+IG1heWJlIHdl
IG5lZWQgdG8gdHJhY2sgdGhlbSBpbiBhIGxpc3QpIGFuZCBzaWduYWwgdGhlbS4gQWZ0ZXIgdGhh
dCAKPj4gaXQncyBzYWZlIHRvIGNhbCBkcm1fZGV2X3VucGx1ZyBhbmQgYmUgc3VyZSBzeW5jaHJv
bml6ZV9zcmN1IHdvbid0IAo+PiBzdGFsbCBiZWNhdXNlIG9mIG9mIGRtYV9mZW5jZV93YWl0LiBB
ZnRlciB0aGF0IHdlIGNhbiBwcm9jZWVkIHRvIAo+PiBjYW5jZWxpbmcgd29yayBpdGVtcywgc3Rv
cHBpbmcgc2NoZWR1bGVycyBlLnQuYy4KPgo+IFRoYXQgaXMgcHJvYmxlbWF0aWMgYXMgd2VsbCBz
aW5jZSB5b3UgbmVlZCB0byBtYWtlIHN1cmUgdGhhdCB0aGUgCj4gc2NoZWR1bGVyIGlzIG5vdCBj
cmVhdGluZyBhIG5ldyBoYXJkd2FyZSBmZW5jZSBpbiB0aGUgbW9tZW50IHlvdSB0cnkgCj4gdG8g
c2lnbmFsIGFsbCBvZiB0aGVtLiBJdCB3b3VsZCByZXF1aXJlIGFub3RoZXIgU1JDVSBvciBsb2Nr
IGZvciB0aGlzLgoKQWx0ZXJuYXRpdmVseSBncmFiYmluZyB0aGUgcmVzZXQgd3JpdGUgc2lkZSBh
bmQgc3RvcHBpbmcgYW5kIHRoZW4gCnJlc3RhcnRpbmcgdGhlIHNjaGVkdWxlciBjb3VsZCB3b3Jr
IGFzIHdlbGwuCgpDaHJpc3RpYW4uCgo+Cj4gQ2hyaXN0aWFuLgo+Cj4+Cj4+IEFuZHJleQo+Pgo+
Pgo+Pj4KPj4+PiBBbmRyZXkKPj4+Pgo+Pj4+Cj4+Pgo+CgpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxp
c3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFu
L2xpc3RpbmZvL2FtZC1nZngK
