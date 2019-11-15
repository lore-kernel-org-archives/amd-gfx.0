Return-Path: <SRS0=FndT=ZH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DF93C432C3
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Nov 2019 12:56:29 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4DD5520733
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Nov 2019 12:56:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DD5520733
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F3AB76E5D8;
	Fri, 15 Nov 2019 12:56:28 +0000 (UTC)
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com
 [IPv6:2a00:1450:4864:20::443])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 886F16E5D8
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Nov 2019 12:56:27 +0000 (UTC)
Received: by mail-wr1-x443.google.com with SMTP id w9so10914093wrr.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Nov 2019 04:56:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:cc:references:from
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-transfer-encoding:content-language;
 bh=+RatrPMl4E+4QWpzyUOa48uQTtJEccBQ8zJQavGpnls=;
 b=loRAAiwZcZCLhg0QptUfgvtFPhw3W7uhDO8FPc41OwJVaWg61fItCianvZHfOe/joR
 hETqnHO6gyBR52agtFx6AD+jfneUCRSSSGaV6dFr/R4O3h+VrIQDbP45XtqdaZDXTxPz
 9OusTzwrkwQHgJYeD1W30cVHVc3aMyx2M/fTi9IczdBB3mglR8tv2Hp1ncyilNisSb3O
 iwnzfYaEgnGVA0pu/8ntU5CnNwBxDVvZTr313FLvTUrZEeIEM6OBQfPdo3iQMOoTg39g
 qnKSdu0hlv/shFCIf4ToxWsyrYlni2GVB9Gfw9RNUUNIlPtX4tSdfohQh3TW/vbHeXge
 mE1g==
X-Gm-Message-State: APjAAAVWSZ7ZP0nx2kGoSRNx6wvWvHvPMadWfSi76LOAFYdQxOphGB5b
 6UZzEyz2ge0xuQAjjHL4LArJPw8a
X-Google-Smtp-Source: APXvYqxAN/zMIVxAnrM8v+SBJKobjucpZSc24MbrfEOxHYgNfhONPCZJWzoJ5MY8vXEfKQGzHfbeMA==
X-Received: by 2002:a5d:538d:: with SMTP id d13mr16072579wrv.304.1573822586245; 
 Fri, 15 Nov 2019 04:56:26 -0800 (PST)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7?
 ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
 by smtp.gmail.com with ESMTPSA id 4sm10713180wmd.33.2019.11.15.04.56.25
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 15 Nov 2019 04:56:25 -0800 (PST)
Subject: Re: [PATCH 01/12] amdgpu: add UAPI for creating encrypted buffers
To: Aaron Liu <aaron.liu@amd.com>, amd-gfx@lists.freedesktop.org
References: <1573788895-3936-1-git-send-email-aaron.liu@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <06a979a0-0795-88cb-f1d9-80255165f0e4@gmail.com>
Date: Fri, 15 Nov 2019 13:56:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <1573788895-3936-1-git-send-email-aaron.liu@amd.com>
Content-Language: en-US
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20161025;
 h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=+RatrPMl4E+4QWpzyUOa48uQTtJEccBQ8zJQavGpnls=;
 b=p9rCweTprJlBIwj5crkvZkUr6LkXh0L5rpOVYDgmHF4lKSNprSwe3nJryWuXhctUuy
 BF8VZamdJ8Ea6CdYfJad5OMw5VdpWg7VYpmfHYmXRHznwM1MV2QUD6MKN+/cJtc8LmW2
 +TFNyETcEcdSZvUjoJ2coQvuLsnKKUAhwY8RCX8Z1ppGSaOQCRLygSnKBetqrxJisRfu
 fuyslYDIwoQf3nnDlDueNpKKFtmbPWPFUs9N/TSp0/WTHaX/EZVLSXJMSRDBGQvcZMPL
 1Fker0cxnQu889HRck8j6KFxIq/Y4pebS7lw5gQjXbcawBZuSEWHIFFRo0k+kH1k0BEp
 C9sA==
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
Cc: Marek.Olsak@amd.com, Huang Rui <ray.huang@amd.com>, Luben.Tuikov@amd.com,
 Alexander.Deucher@amd.com, Leo.Liu@amd.com, Christian.Koenig@amd.com
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191115125623.w-M1Dniqt6_jNiTRKCty7DJRMQdsICcB0F-_U9vPDEE@z>

QW0gMTUuMTEuMTkgdW0gMDQ6MzQgc2NocmllYiBBYXJvbiBMaXU6Cj4gRnJvbTogSHVhbmcgUnVp
IDxyYXkuaHVhbmdAYW1kLmNvbT4KPgo+IFRvIGFsaWduIHRoZSBrZXJuZWwgdWFwaSBjaGFuZ2Ug
ZnJvbSBBbGV4Ogo+Cj4gIkFkZCBhIGZsYWcgdG8gdGhlIEdFTV9DUkVBVEUgaW9jdGwgdG8gY3Jl
YXRlIGVuY3J5cHRlZCBidWZmZXJzLiBCdWZmZXJzIHdpdGgKPiB0aGlzIGZsYWcgc2V0IHdpbGwg
YmUgY3JlYXRlZCB3aXRoIHRoZSBUTVogYml0IHNldCBpbiB0aGUgUFRFcyBvciBlbmdpbmVzCj4g
YWNjZXNzaW5nIHRoZW0uIFRoaXMgaXMgcmVxdWlyZWQgaW4gb3JkZXIgdG8gcHJvcGVybHkgYWNj
ZXNzIHRoZSBkYXRhIGZyb20gdGhlCj4gZW5naW5lcy4iCj4KPiBXZSB3aWxsIHVzZSBHRU1fQ1JF
QVRFX0VOQ1JZUFRFRCBmbGFnIGZvciBzZWN1cmUgYnVmZmVyIGFsbG9jYXRpb24uCj4KPiBTaWdu
ZWQtb2ZmLWJ5OiBIdWFuZyBSdWkgPHJheS5odWFuZ0BhbWQuY29tPgo+IFJldmlld2VkLWJ5OiBB
bGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+CgpQbGVhc2UgcmVhZCB1cCBv
biBob3cgYW1kcHVfZHJtLmggaXMgdXBkYXRlZC4gVGhlIGNoYW5nZSBtdXN0IGZpcnN0IGxhbmQg
CnVwc3RyZWFtIGFuZCB0aGVuIHRoZSBmaWxlIGlzIHN5bmNlZCB1cCBzb21laG93IHNlbWktYXV0
b21hdGljLgoKQ2hyaXN0aWFuLgoKPiAtLS0KPiAgIGluY2x1ZGUvZHJtL2FtZGdwdV9kcm0uaCB8
IDUgKysrKysKPiAgIDEgZmlsZSBjaGFuZ2VkLCA1IGluc2VydGlvbnMoKykKPgo+IGRpZmYgLS1n
aXQgYS9pbmNsdWRlL2RybS9hbWRncHVfZHJtLmggYi9pbmNsdWRlL2RybS9hbWRncHVfZHJtLmgK
PiBpbmRleCA1YzI4YWE3Li4xYTk1ZTM3IDEwMDY0NAo+IC0tLSBhL2luY2x1ZGUvZHJtL2FtZGdw
dV9kcm0uaAo+ICsrKyBiL2luY2x1ZGUvZHJtL2FtZGdwdV9kcm0uaAo+IEBAIC0xNDEsNiArMTQx
LDExIEBAIGV4dGVybiAiQyIgewo+ICAgICogcmVsZWFzaW5nIHRoZSBtZW1vcnkKPiAgICAqLwo+
ICAgI2RlZmluZSBBTURHUFVfR0VNX0NSRUFURV9WUkFNX1dJUEVfT05fUkVMRUFTRQkoMSA8PCA5
KQo+ICsvKiBGbGFnIHRoYXQgQk8gd2lsbCBiZSBlbmNyeXB0ZWQgYW5kIHRoYXQgdGhlIFRNWiBi
aXQgc2hvdWxkIGJlCj4gKyAqIHNldCBpbiB0aGUgUFRFcyB3aGVuIG1hcHBpbmcgdGhpcyBidWZm
ZXIgdmlhIEdQVVZNIG9yCj4gKyAqIGFjY2Vzc2luZyBpdCB3aXRoIHZhcmlvdXMgaHcgYmxvY2tz
Cj4gKyAqLwo+ICsjZGVmaW5lIEFNREdQVV9HRU1fQ1JFQVRFX0VOQ1JZUFRFRAkJKDEgPDwgMTAp
Cj4gICAKPiAgIC8qIEh5YnJpZCBzcGVjaWZpYyAqLwo+ICAgLyogRmxhZyB0aGF0IHRoZSBtZW1v
cnkgYWxsb2NhdGlvbiBzaG91bGQgYmUgZnJvbSB0b3Agb2YgZG9tYWluICovCgpfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlz
dAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9w
Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZng=
