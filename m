Return-Path: <SRS0=8Dg8=KP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33A8EC433B4
	for <amd-gfx@archiver.kernel.org>; Thu, 20 May 2021 19:13:57 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E4847613B9
	for <amd-gfx@archiver.kernel.org>; Thu, 20 May 2021 19:13:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4847613B9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 79A2F6F4EB;
	Thu, 20 May 2021 19:13:56 +0000 (UTC)
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com
 [IPv6:2607:f8b0:4864:20::330])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6DBC56E42A;
 Thu, 20 May 2021 19:13:55 +0000 (UTC)
Received: by mail-ot1-x330.google.com with SMTP id
 69-20020a9d0a4b0000b02902ed42f141e1so15843378otg.2; 
 Thu, 20 May 2021 12:13:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=4e2VdgTFJlvcvj2P7xFhk2OWf2Vw8hURmKQ/jkEZ8DQ=;
 b=ezXgqYpyUEE3k6E23Z2w5y+7QpfYLuVRb58W1d8LCGCQ0rI4n/+xcn5pEOnD2XEwGc
 ZFESJRjhrzmvYJypAz7kjFxjWWm69x1rgmsg1M5+byOvCbkqD42Kily+y/V2v7FJzoQG
 GfDqsptBHJ0Uxc3A6wre9aw1x4UCQx+8I5G1vOLiof5atKnNOO6XN1iNHxqQb2vMGBLf
 53GGvgIlVVnteholUZOzNBuxzJhcv7wvIo/t18cbb5lbKHntcgUKW4U+Z9clRT/TAcLx
 dc+jUzXPwbm/yPvryNh3KuiOLNobxwyIFoHHpPTE3KtW7XcCnOXgmMGaZ4+7xbGqHpjI
 R8TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=4e2VdgTFJlvcvj2P7xFhk2OWf2Vw8hURmKQ/jkEZ8DQ=;
 b=OqsA5gDq8LKQTnQOL3p53IoTjE2ptws1N13K9QOZ9tkw/LZrIupYfAA8mRpzhlENb3
 xHPWMfOe2ho2C/QKeNU7aNynHD0RrwsNZoud5frYfDWreO1a3uLU89eS+6xL2SpddZa+
 +JRJh1QPlLgJHVNdSxKhjdX07MdeJaEmWmji7WoiKz73SjW2yn159UfsPviiXVIgMSw6
 7m6vvNiAe3z4f7sDA9ghsLVsT8nLSqvWHu3uj+GOYBC2I6tukvehm3jBlDf78FPJQEf4
 DVbIsBaTh3PPpsQEIDpf57ZrYjpJtHmiwUezdnovwx3sjBmVGSpzOl0ikn97rXhlL1Cs
 i7YA==
X-Gm-Message-State: AOAM531VdvpIoRlUwR5eeQ9DkFJuEL7WPM++yceW97mXhDNY4Wukikl3
 k111Q0qK6vADk8wmbo4wWuzFE/GCRNQ2czkBBGGxRlwY
X-Google-Smtp-Source: ABdhPJzAKzYxXdp5xq0MqY9EcXKxblI7UDxmIIZsPw8Bd2K9JzAYaNM6nwJLxQjNQ1GW6s2RE+yFoJXI7ECtaUP0+68=
X-Received: by 2002:a9d:57cd:: with SMTP id q13mr5101139oti.23.1621538034833; 
 Thu, 20 May 2021 12:13:54 -0700 (PDT)
MIME-Version: 1.0
References: <20210520120248.3464013-1-lee.jones@linaro.org>
 <20210520120248.3464013-15-lee.jones@linaro.org>
In-Reply-To: <20210520120248.3464013-15-lee.jones@linaro.org>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 20 May 2021 15:13:43 -0400
Message-ID: <CADnq5_Mpddbb4FX0FX+6NAhhOH0iQ3ZnP37-jOkWupqdmWwmrA@mail.gmail.com>
Subject: Re: [PATCH 14/38] drm/amd/amdgpu/gfx_v7_0: Repair function names in
 the documentation
To: Lee Jones <lee.jones@linaro.org>
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
Cc: David Airlie <airlied@linux.ie>, LKML <linux-kernel@vger.kernel.org>,
 Maling list - DRI developers <dri-devel@lists.freedesktop.org>,
 "moderated list:DMA BUFFER SHARING FRAMEWORK" <linaro-mm-sig@lists.linaro.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 linux-media <linux-media@vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QXBwbGllZC4gIFRoYW5rcyEKCkFsZXgKCk9uIFRodSwgTWF5IDIwLCAyMDIxIGF0IDg6MDMgQU0g
TGVlIEpvbmVzIDxsZWUuam9uZXNAbGluYXJvLm9yZz4gd3JvdGU6Cj4KPiBGaXhlcyB0aGUgZm9s
bG93aW5nIFc9MSBrZXJuZWwgYnVpbGQgd2FybmluZyhzKToKPgo+ICBkcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9nZnhfdjdfMC5jOjIxMjY6IHdhcm5pbmc6IGV4cGVjdGluZyBwcm90b3R5cGUg
Zm9yIGdmeF92N18wX3JpbmdfZW1pdF9oZHAoKS4gUHJvdG90eXBlIHdhcyBmb3IgZ2Z4X3Y3XzBf
cmluZ19lbWl0X2hkcF9mbHVzaCgpIGluc3RlYWQKPiAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvZ2Z4X3Y3XzAuYzoyMjYyOiB3YXJuaW5nOiBleHBlY3RpbmcgcHJvdG90eXBlIGZvciBnZnhf
djdfMF9yaW5nX2VtaXRfaWIoKS4gUHJvdG90eXBlIHdhcyBmb3IgZ2Z4X3Y3XzBfcmluZ19lbWl0
X2liX2dmeCgpIGluc3RlYWQKPiAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3Y3XzAu
YzozMjA3OiB3YXJuaW5nOiBleHBlY3RpbmcgcHJvdG90eXBlIGZvciBnZnhfdjdfMF9yaW5nX2Vt
aXRfdm1fZmx1c2goKS4gUHJvdG90eXBlIHdhcyBmb3IgZ2Z4X3Y3XzBfcmluZ19lbWl0X3BpcGVs
aW5lX3N5bmMoKSBpbnN0ZWFkCj4KPiBDYzogQWxleCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hl
ckBhbWQuY29tPgo+IENjOiAiQ2hyaXN0aWFuIEvDtm5pZyIgPGNocmlzdGlhbi5rb2VuaWdAYW1k
LmNvbT4KPiBDYzogRGF2aWQgQWlybGllIDxhaXJsaWVkQGxpbnV4LmllPgo+IENjOiBEYW5pZWwg
VmV0dGVyIDxkYW5pZWxAZmZ3bGwuY2g+Cj4gQ2M6IFN1bWl0IFNlbXdhbCA8c3VtaXQuc2Vtd2Fs
QGxpbmFyby5vcmc+Cj4gQ2M6IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCj4gQ2M6IGRy
aS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKPiBDYzogbGludXgtbWVkaWFAdmdlci5rZXJu
ZWwub3JnCj4gQ2M6IGxpbmFyby1tbS1zaWdAbGlzdHMubGluYXJvLm9yZwo+IFNpZ25lZC1vZmYt
Ynk6IExlZSBKb25lcyA8bGVlLmpvbmVzQGxpbmFyby5vcmc+Cj4gLS0tCj4gIGRyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2dmeF92N18wLmMgfCA2ICsrKy0tLQo+ICAxIGZpbGUgY2hhbmdlZCwg
MyBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQo+Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92N18wLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9nZnhfdjdfMC5jCj4gaW5kZXggYzM1ZmRkMmVmMmQ0ZC4uNjg1MjEyYzNkZGFlNSAxMDA2NDQK
PiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjdfMC5jCj4gKysrIGIvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3Y3XzAuYwo+IEBAIC0yMTE2LDcgKzIxMTYsNyBA
QCBzdGF0aWMgaW50IGdmeF92N18wX3JpbmdfdGVzdF9yaW5nKHN0cnVjdCBhbWRncHVfcmluZyAq
cmluZykKPiAgfQo+Cj4gIC8qKgo+IC0gKiBnZnhfdjdfMF9yaW5nX2VtaXRfaGRwIC0gZW1pdCBh
biBoZHAgZmx1c2ggb24gdGhlIGNwCj4gKyAqIGdmeF92N18wX3JpbmdfZW1pdF9oZHBfZmx1c2gg
LSBlbWl0IGFuIGhkcCBmbHVzaCBvbiB0aGUgY3AKPiAgICoKPiAgICogQHJpbmc6IGFtZGdwdV9y
aW5nIHN0cnVjdHVyZSBob2xkaW5nIHJpbmcgaW5mb3JtYXRpb24KPiAgICoKPiBAQCAtMjI0Miw3
ICsyMjQyLDcgQEAgc3RhdGljIHZvaWQgZ2Z4X3Y3XzBfcmluZ19lbWl0X2ZlbmNlX2NvbXB1dGUo
c3RydWN0IGFtZGdwdV9yaW5nICpyaW5nLAo+ICAgKiBJQiBzdHVmZgo+ICAgKi8KPiAgLyoqCj4g
LSAqIGdmeF92N18wX3JpbmdfZW1pdF9pYiAtIGVtaXQgYW4gSUIgKEluZGlyZWN0IEJ1ZmZlcikg
b24gdGhlIHJpbmcKPiArICogZ2Z4X3Y3XzBfcmluZ19lbWl0X2liX2dmeCAtIGVtaXQgYW4gSUIg
KEluZGlyZWN0IEJ1ZmZlcikgb24gdGhlIHJpbmcKPiAgICoKPiAgICogQHJpbmc6IGFtZGdwdV9y
aW5nIHN0cnVjdHVyZSBob2xkaW5nIHJpbmcgaW5mb3JtYXRpb24KPiAgICogQGpvYjogam9iIHRv
IHJldHJpZXZlIHZtaWQgZnJvbQo+IEBAIC0zMTk2LDcgKzMxOTYsNyBAQCBzdGF0aWMgaW50IGdm
eF92N18wX2NwX3Jlc3VtZShzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldikKPiAgfQo+Cj4gIC8q
Kgo+IC0gKiBnZnhfdjdfMF9yaW5nX2VtaXRfdm1fZmx1c2ggLSBjaWsgdm0gZmx1c2ggdXNpbmcg
dGhlIENQCj4gKyAqIGdmeF92N18wX3JpbmdfZW1pdF9waXBlbGluZV9zeW5jIC0gY2lrIHZtIGZs
dXNoIHVzaW5nIHRoZSBDUAo+ICAgKgo+ICAgKiBAcmluZzogdGhlIHJpbmcgdG8gZW1pdCB0aGUg
Y29tbWFuZHMgdG8KPiAgICoKPiAtLQo+IDIuMzEuMQo+Cl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlz
dHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4v
bGlzdGluZm8vYW1kLWdmeAo=
