Return-Path: <SRS0=Sanp=4W=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 140F5C3F2D1
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Mar 2020 13:37:06 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA799208C3
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Mar 2020 13:37:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ij2TL5VB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA799208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6D98089EAC;
	Thu,  5 Mar 2020 13:37:05 +0000 (UTC)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B38A089EAC
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Mar 2020 13:37:03 +0000 (UTC)
Received: by mail-wr1-x42c.google.com with SMTP id v11so5095930wrm.9
 for <amd-gfx@lists.freedesktop.org>; Thu, 05 Mar 2020 05:37:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=reply-to:subject:to:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=gl3kGuTffbKYchZKYcR+C/6pGXnwye8/ns8pBHS/iB4=;
 b=Ij2TL5VBWOTwbA+gjtjklCc3W18hLBAZtYtbOnemfqbWUebC0BrsirB2wPagodNwCC
 i89iaenMVeH+XaWwIWa1PLEDR19yhdJ1MvDcw3ID99wk4Pl+mytw4N/XZuu7IoCG9zaW
 2cYs2FDJkkUuDNNyF1sG3VMIUYkmAt/kyw5+/M0qvo6ZeDapQtaet5gLhCSUrVzfFybt
 6jBV6UqoluR/bdEqtDd82+7LD4O9TNhrHNblnRMPm5YhipkZ/Tpqj8We+1esSfrqiFSU
 J8DbVPVklK24lH7SKEuDq83UoCgEga2wOgDcvii/J+HVKUMQxMGAYSoo+uyXH/VoCNOI
 Qt1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=gl3kGuTffbKYchZKYcR+C/6pGXnwye8/ns8pBHS/iB4=;
 b=hFKNNcmF/xBoQ9VLCpSCW3eZTLxaZbfhtJajmUyTVLx/j3HOFwnfrpEPD+pWm+n2d0
 nUOr1OcbNn30l/bN7X7sQ7eI2fcLERlv6nuZbvo5GdyCfUzrukNRFFNwhGq99mlk3y0P
 U8BrGDsJZc2ZtHwIXdCGKXvBg2/UFtmOFkOk6HEkSYQIbRPEW1F4SdAnWV3AvKVEAvu0
 +igrkRi1gEM0o/sh0bSJ7JfmsVbR1zVjvTDrTyt+1wtt6MjSHljQuKU2GZNiFY0nwlP3
 7geyWl9GpLoNdKq7ASe6m+RSahUeq7shc6e4ZIk8FUy9vJ6IjfMP5/i3a8CnbwVZpysm
 w4Eg==
X-Gm-Message-State: ANhLgQ0kepQDqIsbRK2u3bgb375DPk1sPX7TFCQIUA6Flz+ldWlPdQjs
 h0ID6sdtmF9rQZrKVPxt96uSX3Wd
X-Google-Smtp-Source: ADFU+vvKFcTEOC1L63RR2GegyhoBJPRZ0U5LfjuzPDqd0FkJCpphu/NXMA/kw+0JfhQF/nvKe5lddA==
X-Received: by 2002:a5d:6a04:: with SMTP id m4mr10121098wru.127.1583415422175; 
 Thu, 05 Mar 2020 05:37:02 -0800 (PST)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7?
 ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
 by smtp.gmail.com with ESMTPSA id s22sm8814435wmc.16.2020.03.05.05.37.01
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 05 Mar 2020 05:37:01 -0800 (PST)
Subject: Re: [enable VCN2.0 for NV12 SRIOV 6/6] drm/amdgpu: clear warning on
 unused var
To: Monk Liu <Monk.Liu@amd.com>, amd-gfx@lists.freedesktop.org
References: <1583415187-16594-1-git-send-email-Monk.Liu@amd.com>
 <1583415187-16594-6-git-send-email-Monk.Liu@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <576079d2-c733-d13e-49f6-570311fd9573@gmail.com>
Date: Thu, 5 Mar 2020 14:37:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <1583415187-16594-6-git-send-email-Monk.Liu@amd.com>
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
Reply-To: christian.koenig@amd.com
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QW0gMDUuMDMuMjAgdW0gMTQ6MzMgc2NocmllYiBNb25rIExpdToKPiBTaWduZWQtb2ZmLWJ5OiBN
b25rIExpdSA8TW9uay5MaXVAYW1kLmNvbT4KCkFja2VkLWJ5OiBDaHJpc3RpYW4gS8O2bmlnIDxj
aHJpc3RpYW4ua29lbmlnQGFtZC5jb20+Cgo+IC0tLQo+ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvYW1kZ3B1X3Zjbi5jIHwgMiAtLQo+ICAgMSBmaWxlIGNoYW5nZWQsIDIgZGVsZXRpb25z
KC0pCj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Zj
bi5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Zjbi5jCj4gaW5kZXggYWU5
NzU0Zi4uYTQxMjcyZiAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9h
bWRncHVfdmNuLmMKPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdmNu
LmMKPiBAQCAtNDkzLDcgKzQ5Myw2IEBAIHN0YXRpYyBpbnQgYW1kZ3B1X3Zjbl9kZWNfZ2V0X2Rl
c3Ryb3lfbXNnKHN0cnVjdCBhbWRncHVfcmluZyAqcmluZywgdWludDMyX3QgaGFuCj4gICAKPiAg
IGludCBhbWRncHVfdmNuX2RlY19yaW5nX3Rlc3RfaWIoc3RydWN0IGFtZGdwdV9yaW5nICpyaW5n
LCBsb25nIHRpbWVvdXQpCj4gICB7Cj4gLQlzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiA9IHJp
bmctPmFkZXY7Cj4gICAJc3RydWN0IGRtYV9mZW5jZSAqZmVuY2U7Cj4gICAJbG9uZyByOwo+ICAg
Cj4gQEAgLTY1NSw3ICs2NTQsNiBAQCBzdGF0aWMgaW50IGFtZGdwdV92Y25fZW5jX2dldF9kZXN0
cm95X21zZyhzdHJ1Y3QgYW1kZ3B1X3JpbmcgKnJpbmcsIHVpbnQzMl90IGhhbgo+ICAgCj4gICBp
bnQgYW1kZ3B1X3Zjbl9lbmNfcmluZ190ZXN0X2liKHN0cnVjdCBhbWRncHVfcmluZyAqcmluZywg
bG9uZyB0aW1lb3V0KQo+ICAgewo+IC0Jc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYgPSByaW5n
LT5hZGV2Owo+ICAgCXN0cnVjdCBkbWFfZmVuY2UgKmZlbmNlID0gTlVMTDsKPiAgIAlzdHJ1Y3Qg
YW1kZ3B1X2JvICpibyA9IE5VTEw7Cj4gICAJbG9uZyByOwoKX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBs
aXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1h
bi9saXN0aW5mby9hbWQtZ2Z4Cg==
