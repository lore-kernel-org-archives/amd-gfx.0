Return-Path: <SRS0=e+DK=KG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68A40C43460
	for <amd-gfx@archiver.kernel.org>; Tue, 11 May 2021 06:56:06 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 340106187E
	for <amd-gfx@archiver.kernel.org>; Tue, 11 May 2021 06:56:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 340106187E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 531D66E9D8;
	Tue, 11 May 2021 06:56:05 +0000 (UTC)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 461626E9D8;
 Tue, 11 May 2021 06:56:03 +0000 (UTC)
Received: by mail-ej1-x62f.google.com with SMTP id w3so28172351ejc.4;
 Mon, 10 May 2021 23:56:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=1toSUP/AaDQn+kpmlAa3khwelYYn5sPMI8SmjGTagCQ=;
 b=N/J54ruGrwq8pFl23R0IhoJx5i5wz54wTHbAhpylgexUUJ7nBAq4f942QlHcIssvJG
 X+If8eJtXAJ4mCMZ+LuRjODG8BmDmVsINFFfgUHGqHPUKDRjAOi4sXcSbvzk/K9M+Zcg
 7f0j8T0fSMu2k83PwnQ7PTR08uSCRRNR7T37VCojHcqcyhbD5iseJgf5gSt9aT0+oQjH
 7B1fSfggVhA035Co+rwxVP/fAOpzv8oNzsLRLXdqQEOIYKOT2bVVHULwv2fiAF1mRb0H
 vay8+a3E4NEIjMCstMTt9hNAUMq4o+d2K5Tn+/aOJJ1QinOGaD6Ktr/DvmBNGPh/GcTo
 apsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=1toSUP/AaDQn+kpmlAa3khwelYYn5sPMI8SmjGTagCQ=;
 b=OAI40NLKkVPU+81Q1wmuy+YIqCVBx7LMzkLPJOVhS5dQwxKCq2/KhPdOP9MOzIG0Xh
 AL6e9rOcp/AFx7yir1XHjQx7+6TvzLb1wuO0RY9KYPWMxeprVf4CJI4y3EA/xt4MIEpM
 h5z5IJv1SJ5Qylj8EbmNyBoryr0Ba7+8CfFDEpC//bafayBj7KC4vobnSBmTrKJ06LWY
 jCDhAc2wqqzmIKDz4lFiNZgzkIbHv2vXr/NnlXvN4XwVcNQSKJzi8ut5yl3MriKFIWMe
 FvbjitopT70m2GSApZfhivLX1QeZuffThwV67XWXrrXnVvQM7SjWl/jR+yImPOSQbucy
 ZU1Q==
X-Gm-Message-State: AOAM5327f4wpa9l1EOEfI0cr3HdfNgOS2g8vLqMfFzPSy5Bk0g7H9bZJ
 zqjB7fXc8Os6Nhy9VcOnIbg=
X-Google-Smtp-Source: ABdhPJz2Xs+emszyd7P6ez0qEzKjruy/WoTOQ1rs7N8d7ThB9eLy0tSAfXUL8Y8cv7KFVTtVFChCbg==
X-Received: by 2002:a17:906:8307:: with SMTP id
 j7mr28982463ejx.420.1620716161994; 
 Mon, 10 May 2021 23:56:01 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:c3ab:ee01:d547:2c4e?
 ([2a02:908:1252:fb60:c3ab:ee01:d547:2c4e])
 by smtp.gmail.com with ESMTPSA id w6sm8003653edc.25.2021.05.10.23.56.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 May 2021 23:56:01 -0700 (PDT)
Subject: Re: [PATCH v6 16/16] drm/amdgpu: Verify DMA opearations from device
 are done
To: Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
 dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 linux-pci@vger.kernel.org, daniel.vetter@ffwll.ch, Harry.Wentland@amd.com
References: <20210510163625.407105-1-andrey.grodzovsky@amd.com>
 <20210510163625.407105-17-andrey.grodzovsky@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <2660cf0e-d312-787d-3100-8e1006d8cc35@gmail.com>
Date: Tue, 11 May 2021 08:56:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210510163625.407105-17-andrey.grodzovsky@amd.com>
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
Cc: Alexander.Deucher@amd.com, gregkh@linuxfoundation.org, ppaalanen@gmail.com,
 helgaas@kernel.org, Felix.Kuehling@amd.com
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QW0gMTAuMDUuMjEgdW0gMTg6MzYgc2NocmllYiBBbmRyZXkgR3JvZHpvdnNreToKPiBJbiBjYXNl
IGRldmljZSByZW1vdmUgaXMganVzdCBzaW11YWx0ZWQgYnkgc3lzZnMgdGhlbiB2ZXJpZnkKPiBk
ZXZpY2UgZG9lc24ndCBrZWVwIGRvaW5nIERNQSB0byB0aGUgcmVsZWFzZWQgbWVtb3J5IGFmdGVy
Cj4gcGNpX3JlbW92ZSBpcyBkb25lLgo+Cj4gU2lnbmVkLW9mZi1ieTogQW5kcmV5IEdyb2R6b3Zz
a3kgPGFuZHJleS5ncm9kem92c2t5QGFtZC5jb20+CgpBY2tlZC1ieTogQ2hyaXN0aWFuIEvDtm5p
ZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPgoKPiAtLS0KPiAgIGRyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L2FtZGdwdV9kcnYuYyB8IDYgKysrKysrCj4gICAxIGZpbGUgY2hhbmdlZCwgNiBp
bnNlcnRpb25zKCspCj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
YW1kZ3B1X2Rydi5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2Rydi5jCj4g
aW5kZXggODMwMDZmNDViMTBiLi41ZTZhZjllMGI3YmYgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2Rydi5jCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvYW1kZ3B1X2Rydi5jCj4gQEAgLTEzMTQsNyArMTMxNCwxMyBAQCBhbWRncHVfcGNp
X3JlbW92ZShzdHJ1Y3QgcGNpX2RldiAqcGRldikKPiAgIAlkcm1fZGV2X3VucGx1ZyhkZXYpOwo+
ICAgCWFtZGdwdV9kcml2ZXJfdW5sb2FkX2ttcyhkZXYpOwo+ICAgCj4gKwkvKgo+ICsJICogRmx1
c2ggYW55IGluIGZsaWdodCBETUEgb3BlcmF0aW9ucyBmcm9tIGRldmljZS4KPiArCSAqIENsZWFy
IHRoZSBCdXMgTWFzdGVyIEVuYWJsZSBiaXQgYW5kIHRoZW4gd2FpdCBvbiB0aGUgUENJZSBEZXZp
Y2UKPiArCSAqIFN0YXR1c1RyYW5zYWN0aW9ucyBQZW5kaW5nIGJpdC4KPiArCSAqLwo+ICAgCXBj
aV9kaXNhYmxlX2RldmljZShwZGV2KTsKPiArCXBjaV93YWl0X2Zvcl9wZW5kaW5nX3RyYW5zYWN0
aW9uKHBkZXYpOwo+ICAgfQo+ICAgCj4gICBzdGF0aWMgdm9pZAoKX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdm
eEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFp
bG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
