Return-Path: <SRS0=yWhT=GL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE43BC433DB
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Jan 2021 21:17:15 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 83E0B23A9C
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Jan 2021 21:17:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83E0B23A9C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D4E596E8E7;
	Fri,  8 Jan 2021 21:17:14 +0000 (UTC)
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com
 [IPv6:2607:f8b0:4864:20::22a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 382AE6E8DE;
 Fri,  8 Jan 2021 21:17:13 +0000 (UTC)
Received: by mail-oi1-x22a.google.com with SMTP id d203so12969198oia.0;
 Fri, 08 Jan 2021 13:17:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=TY5MROL71NTqtli+NhUZvNx26dK4LplFxHZHvvWoZHQ=;
 b=KXRjsjvsExLfCARy7KK9m+0XV0SKmGxUUtt2u9BNbYZI++GnbFPmoQjfrKKo0dyDTR
 ds1i/3jzjmCBX/UBVR7pSYUWZXyMWYRScnt/lqtMr16eaJFc8iSsAmU4V3xZOk75dwtA
 BRl6IdrL0fZfWlF8UnAwQas+ARr164VIrc3nZXKOaNc92DElQIfCqgELYs6TAO08jYdg
 8FVhg/WqgBsE7oWuSuZxqpIJ8O9dTeDeQdymbF+bIyvM+AfBm+Qf1wdMKbh7AKvjJ53E
 37Hz7C7KwNGpXmPJD7IPv86hrysCFk/NLqtGlwhWBdFdFQXPKOZohf7dSMfthA9ZaRZM
 YVcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=TY5MROL71NTqtli+NhUZvNx26dK4LplFxHZHvvWoZHQ=;
 b=W0fKcU83thlqxdCco4c+oa15r/uNEietZJ8PSOoNVHFKEnygE882WbNTuUKEdDrBMW
 1Gc1YgfFT5QV0SkupwGeCMfLhQCUHjG62b1oGfkpLnFq4GcokJPmMq1JRd543xbf8Po2
 LhrefxsKCSi/qtM2+aI9NvAa/ML+WC1LcEQMFQ/iG1YDMX26FqKvFCkV/wyNPXqHDtnG
 x0XWr+eFQEKQ3u9Xq48vIMVQDXCa9yIpyVkkYUBVpziLAAHqOaATHO6ZsTObxzq08U74
 H7zmoATBeiHHXDWg7XzKmARGNVpHWbRS+B1tP51nMxdY9TP7jwml8mEUGOTtAd11lz+p
 mgqA==
X-Gm-Message-State: AOAM532ci26d+iG4UURNDi32LK6qL9OJge5Ew/HEiTw9CKdlvgHbC6pl
 9UaDHFD5f8k0OsJi4L2HHLgn8oYfGKgc6EG+Tbvi2nSY
X-Google-Smtp-Source: ABdhPJyhD+1eZavw/5ZhQ+L6btJZdBTm0qdWVrGs2C97Duv9DDnWKyEaTnnz+VNgy3s5DbUzUANVq7ApaZ7tsSUQSgA=
X-Received: by 2002:aca:4f97:: with SMTP id d145mr3509847oib.123.1610140632586; 
 Fri, 08 Jan 2021 13:17:12 -0800 (PST)
MIME-Version: 1.0
References: <20210108201457.3078600-1-lee.jones@linaro.org>
 <20210108201457.3078600-29-lee.jones@linaro.org>
In-Reply-To: <20210108201457.3078600-29-lee.jones@linaro.org>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 8 Jan 2021 16:17:01 -0500
Message-ID: <CADnq5_NtvngjE2UUL9MEeBXrb_XJz-3FjAK6D1bcEtOyHbDD7w@mail.gmail.com>
Subject: Re: [PATCH 28/40] drm/amd/display/dc/dce/dce_transform: Remove 3
 unused/legacy variables
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
Cc: Leo Li <sunpeng.li@amd.com>, Mauro Rossi <issor.oruam@gmail.com>,
 LKML <linux-kernel@vger.kernel.org>,
 Maling list - DRI developers <dri-devel@lists.freedesktop.org>,
 David Airlie <airlied@linux.ie>, amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gRnJpLCBKYW4gOCwgMjAyMSBhdCAzOjE1IFBNIExlZSBKb25lcyA8bGVlLmpvbmVzQGxpbmFy
by5vcmc+IHdyb3RlOgo+Cj4gRml4ZXMgdGhlIGZvbGxvd2luZyBXPTEga2VybmVsIGJ1aWxkIHdh
cm5pbmcocyk6Cj4KPiAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvLi4vZGlzcGxheS9kYy9k
Y2UvZGNlX3RyYW5zZm9ybS5jOiBJbiBmdW5jdGlvbiDigJhkY2U2MF90cmFuc2Zvcm1fc2V0X3Nj
YWxlcuKAmToKPiAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvLi4vZGlzcGxheS9kYy9kY2Uv
ZGNlX3RyYW5zZm9ybS5jOjQ5Njo3OiB3YXJuaW5nOiB2YXJpYWJsZSDigJhmaWx0ZXJfdXBkYXRl
ZOKAmSBzZXQgYnV0IG5vdCB1c2VkIFstV3VudXNlZC1idXQtc2V0LXZhcmlhYmxlXQo+ICBkcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS8uLi9kaXNwbGF5L2RjL2RjZS9kY2VfdHJhbnNmb3JtLmM6
IEluIGZ1bmN0aW9uIOKAmGRjZTYwX3RyYW5zZm9ybV9zZXRfcGl4ZWxfc3RvcmFnZV9kZXB0aOKA
mToKPiAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvLi4vZGlzcGxheS9kYy9kY2UvZGNlX3Ry
YW5zZm9ybS5jOjEwNDA6MTk6IHdhcm5pbmc6IHZhcmlhYmxlIOKAmGV4cGFuX21vZGXigJkgc2V0
IGJ1dCBub3QgdXNlZCBbLVd1bnVzZWQtYnV0LXNldC12YXJpYWJsZV0KPiAgZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvLi4vZGlzcGxheS9kYy9kY2UvZGNlX3RyYW5zZm9ybS5jOjEwNDA6Njog
d2FybmluZzogdmFyaWFibGUg4oCYcGl4ZWxfZGVwdGjigJkgc2V0IGJ1dCBub3QgdXNlZCBbLVd1
bnVzZWQtYnV0LXNldC12YXJpYWJsZV0KPgo+IENjOiBIYXJyeSBXZW50bGFuZCA8aGFycnkud2Vu
dGxhbmRAYW1kLmNvbT4KPiBDYzogTGVvIExpIDxzdW5wZW5nLmxpQGFtZC5jb20+Cj4gQ2M6IEFs
ZXggRGV1Y2hlciA8YWxleGFuZGVyLmRldWNoZXJAYW1kLmNvbT4KPiBDYzogIkNocmlzdGlhbiBL
w7ZuaWciIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+Cj4gQ2M6IERhdmlkIEFpcmxpZSA8YWly
bGllZEBsaW51eC5pZT4KPiBDYzogRGFuaWVsIFZldHRlciA8ZGFuaWVsQGZmd2xsLmNoPgo+IENj
OiBNYXVybyBSb3NzaSA8aXNzb3Iub3J1YW1AZ21haWwuY29tPgo+IENjOiBhbWQtZ2Z4QGxpc3Rz
LmZyZWVkZXNrdG9wLm9yZwo+IENjOiBkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCj4g
U2lnbmVkLW9mZi1ieTogTGVlIEpvbmVzIDxsZWUuam9uZXNAbGluYXJvLm9yZz4KCkFwcGxpZWQu
ICBUaGFua3MhCgpBbGV4Cgo+IC0tLQo+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMv
ZGNlL2RjZV90cmFuc2Zvcm0uYyB8IDEzIC0tLS0tLS0tLS0tLS0KPiAgMSBmaWxlIGNoYW5nZWQs
IDEzIGRlbGV0aW9ucygtKQo+Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlz
cGxheS9kYy9kY2UvZGNlX3RyYW5zZm9ybS5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5
L2RjL2RjZS9kY2VfdHJhbnNmb3JtLmMKPiBpbmRleCAxMzBhMGEwYzgzMzI5Li42MTIxYmI3YjAw
OWI4IDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9kY2UvZGNl
X3RyYW5zZm9ybS5jCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2RjZS9k
Y2VfdHJhbnNmb3JtLmMKPiBAQCAtNDkzLDcgKzQ5Myw2IEBAIHN0YXRpYyB2b2lkIGRjZTYwX3Ry
YW5zZm9ybV9zZXRfc2NhbGVyKAo+ICB7Cj4gICAgICAgICBzdHJ1Y3QgZGNlX3RyYW5zZm9ybSAq
eGZtX2RjZSA9IFRPX0RDRV9UUkFOU0ZPUk0oeGZtKTsKPiAgICAgICAgIGJvb2wgaXNfc2NhbGlu
Z19yZXF1aXJlZDsKPiAtICAgICAgIGJvb2wgZmlsdGVyX3VwZGF0ZWQgPSBmYWxzZTsKPiAgICAg
ICAgIGNvbnN0IHVpbnQxNl90ICpjb2VmZnNfdiwgKmNvZWZmc19oOwo+Cj4gICAgICAgICAvKlVz
ZSB3aG9sZSBsaW5lIGJ1ZmZlciBtZW1vcnkgYWx3YXlzKi8KPiBAQCAtNTU4LDcgKzU1Nyw2IEBA
IHN0YXRpYyB2b2lkIGRjZTYwX3RyYW5zZm9ybV9zZXRfc2NhbGVyKAo+Cj4gICAgICAgICAgICAg
ICAgICAgICAgICAgeGZtX2RjZS0+ZmlsdGVyX3YgPSBjb2VmZnNfdjsKPiAgICAgICAgICAgICAg
ICAgICAgICAgICB4Zm1fZGNlLT5maWx0ZXJfaCA9IGNvZWZmc19oOwo+IC0gICAgICAgICAgICAg
ICAgICAgICAgIGZpbHRlcl91cGRhdGVkID0gdHJ1ZTsKPiAgICAgICAgICAgICAgICAgfQo+ICAg
ICAgICAgfQo+Cj4gQEAgLTEwMzcsMzQgKzEwMzUsMjMgQEAgc3RhdGljIHZvaWQgZGNlNjBfdHJh
bnNmb3JtX3NldF9waXhlbF9zdG9yYWdlX2RlcHRoKAo+ICAgICAgICAgY29uc3Qgc3RydWN0IGJp
dF9kZXB0aF9yZWR1Y3Rpb25fcGFyYW1zICpiaXRfZGVwdGhfcGFyYW1zKQo+ICB7Cj4gICAgICAg
ICBzdHJ1Y3QgZGNlX3RyYW5zZm9ybSAqeGZtX2RjZSA9IFRPX0RDRV9UUkFOU0ZPUk0oeGZtKTsK
PiAtICAgICAgIGludCBwaXhlbF9kZXB0aCwgZXhwYW5fbW9kZTsKPiAgICAgICAgIGVudW0gZGNf
Y29sb3JfZGVwdGggY29sb3JfZGVwdGg7Cj4KPiAgICAgICAgIHN3aXRjaCAoZGVwdGgpIHsKPiAg
ICAgICAgIGNhc2UgTEJfUElYRUxfREVQVEhfMThCUFA6Cj4gICAgICAgICAgICAgICAgIGNvbG9y
X2RlcHRoID0gQ09MT1JfREVQVEhfNjY2Owo+IC0gICAgICAgICAgICAgICBwaXhlbF9kZXB0aCA9
IDI7Cj4gLSAgICAgICAgICAgICAgIGV4cGFuX21vZGUgID0gMTsKPiAgICAgICAgICAgICAgICAg
YnJlYWs7Cj4gICAgICAgICBjYXNlIExCX1BJWEVMX0RFUFRIXzI0QlBQOgo+ICAgICAgICAgICAg
ICAgICBjb2xvcl9kZXB0aCA9IENPTE9SX0RFUFRIXzg4ODsKPiAtICAgICAgICAgICAgICAgcGl4
ZWxfZGVwdGggPSAxOwo+IC0gICAgICAgICAgICAgICBleHBhbl9tb2RlICA9IDE7Cj4gICAgICAg
ICAgICAgICAgIGJyZWFrOwo+ICAgICAgICAgY2FzZSBMQl9QSVhFTF9ERVBUSF8zMEJQUDoKPiAg
ICAgICAgICAgICAgICAgY29sb3JfZGVwdGggPSBDT0xPUl9ERVBUSF8xMDEwMTA7Cj4gLSAgICAg
ICAgICAgICAgIHBpeGVsX2RlcHRoID0gMDsKPiAtICAgICAgICAgICAgICAgZXhwYW5fbW9kZSAg
PSAxOwo+ICAgICAgICAgICAgICAgICBicmVhazsKPiAgICAgICAgIGNhc2UgTEJfUElYRUxfREVQ
VEhfMzZCUFA6Cj4gICAgICAgICAgICAgICAgIGNvbG9yX2RlcHRoID0gQ09MT1JfREVQVEhfMTIx
MjEyOwo+IC0gICAgICAgICAgICAgICBwaXhlbF9kZXB0aCA9IDM7Cj4gLSAgICAgICAgICAgICAg
IGV4cGFuX21vZGUgID0gMDsKPiAgICAgICAgICAgICAgICAgYnJlYWs7Cj4gICAgICAgICBkZWZh
dWx0Ogo+ICAgICAgICAgICAgICAgICBjb2xvcl9kZXB0aCA9IENPTE9SX0RFUFRIXzEwMTAxMDsK
PiAtICAgICAgICAgICAgICAgcGl4ZWxfZGVwdGggPSAwOwo+IC0gICAgICAgICAgICAgICBleHBh
bl9tb2RlICA9IDE7Cj4gICAgICAgICAgICAgICAgIEJSRUFLX1RPX0RFQlVHR0VSKCk7Cj4gICAg
ICAgICAgICAgICAgIGJyZWFrOwo+ICAgICAgICAgfQo+IC0tCj4gMi4yNS4xCj4KPiBfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwo+IGRyaS1kZXZlbCBtYWls
aW5nIGxpc3QKPiBkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCj4gaHR0cHM6Ly9saXN0
cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9kcmktZGV2ZWwKX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QK
YW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5v
cmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
