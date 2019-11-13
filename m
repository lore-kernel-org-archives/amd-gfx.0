Return-Path: <SRS0=4UxD=ZF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD095C43331
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Nov 2019 15:24:24 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E39D222C9
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Nov 2019 15:24:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E39D222C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 34F8B6ED60;
	Wed, 13 Nov 2019 15:24:22 +0000 (UTC)
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com
 [IPv6:2a00:1450:4864:20::342])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 899406ED60;
 Wed, 13 Nov 2019 15:24:20 +0000 (UTC)
Received: by mail-wm1-x342.google.com with SMTP id q70so2431116wme.1;
 Wed, 13 Nov 2019 07:24:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=EZIr8n1tU+j0xhtRpbzRhBLFBsZMuPY7L0CnRVcZR4k=;
 b=Xg6mXu5iAfx97LogtGgvETssaQcsvkM8Any+OutEGDtbnClqGZeVpHxCfldchG9Vs3
 rhxMBJgp91tcF684+sf+H8bm0qzF5Gv2+gHUASRgw+q8Sb9olK/52X0BWg2rmAa+GvK4
 XH3c/TFpPty3UJkV91KnIGsMc/eRsvOm7yOo63W2fViAFq6Wp93l94Twqu9clohEIQ1W
 ONlkf0JkepG2O9QyGVhwZ6AWLmrV0Z8r4YyWykHXCCI9YcpVHHRJfLtiIghWQGkjP4nc
 oh12lGN5llo2uOIC5ChBzIi3FI4T/xgmBCqUHkuLyUU+Pnzs24gOX8nVHqXg/g5lra0Q
 8CZQ==
X-Gm-Message-State: APjAAAU71eJxf/I3yseMPN89xnAI6KAeStJOel2BesiUhvyDFI9KukPZ
 CGX8RPm9zEV4tRAC6Px2F7mS1rCBZ6N0E4ul7+E=
X-Google-Smtp-Source: APXvYqyh/U3wryjoZZSptRRKloXLftAMfY1jR1cvrpoCxOaKPTJf/IYD45uGLGkd1pxrgI+3IHhHsLJO4Mf4t58c4rs=
X-Received: by 2002:a1c:790b:: with SMTP id l11mr3485526wme.127.1573658659004; 
 Wed, 13 Nov 2019 07:24:19 -0800 (PST)
MIME-Version: 1.0
References: <1573649074-72589-1-git-send-email-yukuai3@huawei.com>
In-Reply-To: <1573649074-72589-1-git-send-email-yukuai3@huawei.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 13 Nov 2019 10:24:07 -0500
Message-ID:
 <CADnq5_P38AfOHtRAAYXHVmjPPS9ot4NTGX-dQXgeUiGUjYUCHw@mail.gmail.com>
Subject: Re: [PATCH 0/7] various '-Wunused-but-set-variable' gcc warning fixes
To: yu kuai <yukuai3@huawei.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc;
 bh=EZIr8n1tU+j0xhtRpbzRhBLFBsZMuPY7L0CnRVcZR4k=;
 b=c/X7BxOj/QjILROu0J4DmJluqRkTUtYoR0f7eEpN/8Yq7Vyg64Xb8zYRvXYHRBDTfI
 Qahh/XnS36s2Q3+nuvxj8n0hh4V+DEQq3MlaejW5Yv/uRPSEPqtWTG9ZTc9Jz3hzIakk
 HnZjZUGnvxb08VG5g26S5ivktTIFPJ9FWZrCnuYgITCkeu5uPgsIx/6FCy5+qGyhhQ/2
 pqxmX75YScunIZ3uUo6Krl8P/I23/PJ4eDzVVO6Zuh/q9Qty81S2NJ8ubrVbmrsfHgYZ
 2Hsk9KE1rsL1pb/e0qyiNonYkWoI1lx4Lqrsq9Q30l+ASHJBNVaxitEpDqH1lndQKH3Y
 s3uw==
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
Cc: Chunming Zhou <David1.Zhou@amd.com>, yi.zhang@huawei.com,
 Dave Airlie <airlied@linux.ie>, "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 LKML <linux-kernel@vger.kernel.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>, zhengbin <zhengbin13@huawei.com>,
 Maling list - DRI developers <dri-devel@lists.freedesktop.org>,
 Daniel Vetter <daniel@ffwll.ch>, "Deucher,
 Alexander" <alexander.deucher@amd.com>, "Quan, Evan" <evan.quan@amd.com>,
 Rex Zhu <Rex.Zhu@amd.com>, Christian Koenig <christian.koenig@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191113152407.ebJv1_-enbaiRIAAjQSmTaAVt3n9g2Exb1LuUMZNc_k@z>

QXBwbGllZCB0aGUgc2VyaWVzLCBhbHRob3VnaCBhIGNvdXBsZSBvZiB0aGUgcGF0Y2hlcyB3ZXJl
IGFscmVhZHkKYXBwbGllZCBmcm9tIGEgcHJldmlvdXMgcGF0Y2ggc2V0LgoKVGhhbmtzLAoKQWxl
eAoKT24gV2VkLCBOb3YgMTMsIDIwMTkgYXQgOToxMiBBTSB5dSBrdWFpIDx5dWt1YWkzQGh1YXdl
aS5jb20+IHdyb3RlOgo+Cj4gVGhpcyBwYXRjaCBzZXQgZml4ZXMgdmFyaW91cyB1bnJlbGF0ZWQg
Z2NjICctV3VudXNlZC1idXQtc2V0LXZhcmlhYmxlJwo+IHdhcm5pbmdzLgo+Cj4geXUga3VhaSAo
Nyk6Cj4gICBkcm0vYW1kZ3B1OiByZW1vdmUgc2V0IGJ1dCBub3QgdXNlZCB2YXJpYWJsZSAnbWNf
c2hhcmVkX2NobWFwJyBmcm9tCj4gICAgICdnZnhfdjZfMC5jJyBhbmQgJ2dmeF92N18wLmMnCj4g
ICBkcm0vYW1kZ3B1OiByZW1vdmUgc2V0IGJ1dCBub3QgdXNlZCB2YXJpYWJsZSAnYW1kZ3B1X2Nv
bm5lY3RvcicKPiAgIGRybS9hbWRncHU6IHJlbW92ZSBzZXQgYnV0IG5vdCB1c2VkIHZhcmlhYmxl
ICdjb3VudCcKPiAgIGRybS9hbWRncHU6IHJlbW92ZSBzZXQgYnV0IG5vdCB1c2VkIHZhcmlhYmxl
ICdpbnZhbGlkJwo+ICAgZHJtL2FtZGdwdTogcmVtb3ZlIHNldCBidXQgbm90IHVzZWQgdmFyaWFi
bGUgJ3RocmVzaG9sZCcKPiAgIGRybS9hbWRncHU6IHJlbW92ZSBzZXQgYnV0IG5vdCB1c2VkIHZh
cmlhYmxlICdzdGF0ZScKPiAgIGRybS9hbWRncHU6IHJlbW92ZSBzZXQgYnV0IG5vdCB1c2VkIHZh
cmlhYmxlICd1c19tdmRkJwo+Cj4gIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9h
bWRrZmRfZ3B1dm0uYyAgICB8ICA0ICsrLS0KPiAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
YW1kZ3B1X2Rpc3BsYXkuYyAgICAgICAgIHwgIDIgLS0KPiAgZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvZ2Z4X3Y2XzAuYyAgICAgICAgICAgICAgIHwgIDMgKy0tCj4gIGRyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2dmeF92N18wLmMgICAgICAgICAgICAgICB8ICAzICstLQo+ICBkcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfZGV2aWNlLmMgICAgICAgICAgICAgfCAgNCArKy0tCj4g
IGRyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L3NtdW1nci9maWppX3NtdW1nci5jICB8ICA3
ICsrLS0tLS0KPiAgZHJpdmVycy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkvc211bWdyL3ZlZ2FtX3Nt
dW1nci5jIHwgMTIgLS0tLS0tLS0tLS0tCj4gIDcgZmlsZXMgY2hhbmdlZCwgOCBpbnNlcnRpb25z
KCspLCAyNyBkZWxldGlvbnMoLSkKPgo+IC0tCj4gMi43LjQKPgo+IF9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCj4gYW1kLWdmeCBtYWlsaW5nIGxpc3QKPiBh
bWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwo+IGh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Au
b3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeApfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZy
ZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3Rp
bmZvL2FtZC1nZng=
