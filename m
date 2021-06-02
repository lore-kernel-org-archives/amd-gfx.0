Return-Path: <SRS0=QW4G=K4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F10EC47092
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Jun 2021 14:40:59 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C3B18610E5
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Jun 2021 14:40:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3B18610E5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7AB886ECC3;
	Wed,  2 Jun 2021 14:40:58 +0000 (UTC)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 627FB6ECAF
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Jun 2021 14:33:11 +0000 (UTC)
Received: by mail-wm1-x335.google.com with SMTP id r13so1454727wmq.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 02 Jun 2021 07:33:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Hexu7cKSeKzuwDGfSYjJ5Naq4syeodeMqWoX460WR6c=;
 b=YnUg9R7FAfDth6b0+i7LnprXoGOHmxfpsGVrwM1uR4qc3ylGDcN2fMm7g5Cw2B/cIW
 j30w+lYL/AREtK2OKb6Mpkh+UhMcDOqEW8PseOYarGU/zP/skxG0FKrFJ0rR1Zs6txh8
 5+8n+muAZdpofmyn1MIYZF5LmLJvIhct3uXEcUaKJfZq0a6R+yt4uSJuh8vvcT+wLdbZ
 GmfEoZH5U46rZrJkBqJWpH87XABFe/4GcwKakQj6Sjpv/7rIFKu+YxANUoRR6Jxmo3RT
 kUj/s0mLMiLiZ+uLUu1nFREt38x9aoB2pic1i2duhXYWl2LDDriXoDDCyZGQ/7coEEoi
 NO2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Hexu7cKSeKzuwDGfSYjJ5Naq4syeodeMqWoX460WR6c=;
 b=kRhs4GnGRG8JHaWMatoNAYemUigmvik0qssSp4H0Hm3oo2aTUHMqaAoWF3Z1YlhO2z
 Vq88iK+u2C4Q3qa5BXPxkP5QuRvNEwmjQvYWDhgPvBRywjE/yYo7vv0JiMomgEtB2B++
 hO15Hl/7VEdXWn8S+T7y8smxEuw41nhcBQQJK3Q/aEoroFZ2E6N9PrZTPvpzHrWpYorf
 0xk6wcsoSnT5hRV0clse8dwLnOZ/tBglLbD4eQrUGaLPXgt4P6sPvnGr57FS4naLhhJE
 Zqcqf+Vk3ZOZRrGeEzHgwima9CTH8vkHFRLaUoX8YZEZ93/qptT9f0o+o89JreQQXeKa
 LQyg==
X-Gm-Message-State: AOAM531DADr6UqZ+dP4Mwb/3Jau3sCB8Dz01P/dFYVmlnfeQKSANltUD
 QRPJ+3FGXFmArNBWSOBtICdt8w==
X-Google-Smtp-Source: ABdhPJwH8/eJTRs27ADnedTTW55aDfi99/T9FH9EumVjgB06SEnGQcD9JLwfnOw2xFcXpsN5fAwH9w==
X-Received: by 2002:a05:600c:2cd2:: with SMTP id
 l18mr31968202wmc.142.1622644389928; 
 Wed, 02 Jun 2021 07:33:09 -0700 (PDT)
Received: from dell.default ([91.110.221.214])
 by smtp.gmail.com with ESMTPSA id o11sm132315wrq.93.2021.06.02.07.33.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Jun 2021 07:33:09 -0700 (PDT)
From: Lee Jones <lee.jones@linaro.org>
To: lee.jones@linaro.org
Subject: [RESEND 00/26] Rid W=1 warnings from GPU
Date: Wed,  2 Jun 2021 15:32:34 +0100
Message-Id: <20210602143300.2330146-1-lee.jones@linaro.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
X-Mailman-Approved-At: Wed, 02 Jun 2021 14:40:57 +0000
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
Cc: David Airlie <airlied@linux.ie>, nouveau@lists.freedesktop.org,
 Mauro Rossi <issor.oruam@gmail.com>, dri-devel@lists.freedesktop.org,
 Eric Anholt <eric@anholt.net>, Huang Rui <ray.huang@amd.com>,
 Rob Clark <robdclark@gmail.com>, Fabien Dessenne <fabien.dessenne@st.com>,
 Benjamin Gaignard <benjamin.gaignard@linaro.org>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>,
 Kuogee Hsieh <khsieh@codeaurora.org>, Sam Ravnborg <sam@ravnborg.org>,
 Ajay Kumar <ajaykumar.rs@samsung.com>,
 Chandan Uddaraju <chandanu@codeaurora.org>,
 Marek Szyprowski <m.szyprowski@samsung.com>, Ben Widawsky <ben@bwidawsk.net>,
 linux-samsung-soc@vger.kernel.org, Joonyoung Shim <jy0922.shim@samsung.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
 Vincent Abriou <vincent.abriou@st.com>, Alistair Popple <apopple@nvidia.com>,
 Michal Simek <michal.simek@xilinx.com>, amd-gfx@lists.freedesktop.org,
 Sumit Semwal <sumit.semwal@linaro.org>, Ben Skeggs <bskeggs@redhat.com>,
 Harry Wentland <harry.wentland@amd.com>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Thierry Reding <thierry.reding@gmail.com>,
 Chun-Kuang Hu <chunkuang.hu@kernel.org>,
 Philipp Zabel <p.zabel@pengutronix.de>, Leo Li <sunpeng.li@amd.com>,
 linux-arm-msm@vger.kernel.org, Stephen Boyd <swboyd@chromium.org>,
 Inki Dae <inki.dae@samsung.com>, Hans de Goede <hdegoede@redhat.com>,
 Akshu Agarwal <akshua@gmail.com>, Matthias Brugger <matthias.bgg@gmail.com>,
 Sean Paul <sean@poorly.run>, linux-arm-kernel@lists.infradead.org,
 Krishna Manikandan <mkrishn@codeaurora.org>, Hyun Kwon <hyun.kwon@xilinx.com>,
 Seung-Woo Kim <sw0312.kim@samsung.com>, linux-kernel@vger.kernel.org,
 Kyungmin Park <kyungmin.park@samsung.com>, linaro-mm-sig@lists.linaro.org,
 Adam Jackson <ajax@redhat.com>, Daniel Vetter <daniel@ffwll.ch>,
 Alex Deucher <alexander.deucher@amd.com>, linux-mediatek@lists.infradead.org,
 linux-media@vger.kernel.org, freedreno@lists.freedesktop.org,
 Christian Koenig <christian.koenig@amd.com>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

U29tZSBvZmYgdGhlc2UgcGF0Y2hlcyBoYXZlIGJlZW4ga25vY2tpbmcgYXJvdW5kIGZvciBhIHdo
aWxlLgoKV2hvIHdpbGwgaG9vdmVyIHRoZW0gdXAgcGxlYXNlPwoKVGhpcyBzZXQgaXMgcGFydCBv
ZiBhIGxhcmdlciBlZmZvcnQgYXR0ZW1wdGluZyB0byBjbGVhbi11cCBXPTEKa2VybmVsIGJ1aWxk
cywgd2hpY2ggYXJlIGN1cnJlbnRseSBvdmVyd2hlbG1pbmdseSByaWRkbGVkIHdpdGgKbmlnZ2x5
IGxpdHRsZSB3YXJuaW5ncy4KCkxlZSBKb25lcyAoMjYpOgogIGRybS9tZWRpYXRlay9tdGtfZGlz
cF9jb2xvcjogU3RyaXAgaW5jb3JyZWN0IGRvYyBhbmQgZGVtb3RlIGhlYWRlcgogIGRybS9tZWRp
YXRlay9tdGtfZGlzcF9nYW1tYTogU3RyaXAgYW5kIGRlbW90ZSBub24tY29uZm9ybWFudAogICAg
a2VybmVsLWRvYyBoZWFkZXIKICBkcm0vbWVkaWF0ZWsvbXRrX2Rpc3Bfb3ZsOiBTdHJpcCBhbmQg
ZGVtb3RlIG5vbi1jb25mb3JtYW50IGhlYWRlcgogIGRybS9tZWRpYXRlay9tdGtfZGlzcF9yZG1h
OiBTdHJpcCBhbmQgZGVtb3RlIG5vbi1jb25mb3JtYW50IGtlcm5lbC1kb2MKICAgIGhlYWRlcgog
IGRybS9zdGkvc3RpX2hkbWlfdHgzZzRjMjhwaHk6IFByb3ZpZGUgZnVuY3Rpb24gbmFtZXMgZm9y
IGtlcm5lbC1kb2MKICAgIGhlYWRlcnMKICBkcm0vc3RpL3N0aV9oZGE6IFByb3ZpZGUgbWlzc2lu
ZyBmdW5jdGlvbiBuYW1lcwogIGRybS9zdGkvc3RpX3R2b3V0OiBQcm92aWRlIGEgYnVuY2ggb2Yg
bWlzc2luZyBmdW5jdGlvbiBuYW1lcwogIGRybS9zdGkvc3RpX2hxdmRwOiBGaXggaW5jb3JyZWN0
bHkgbmFtZWQgZnVuY3Rpb24gJ3N0aV9ocXZkcF92dGdfY2IoKScKICBkcm0vbXNtL2Rpc3AvZHB1
MS9kcHVfZW5jb2Rlcl9waHlzX2NtZDogUmVtb3ZlIHVudXNlZCB2YXJpYWJsZQogICAgJ2NtZF9l
bmMnCiAgZHJtL21zbS9kaXNwL2RwdTEvZHB1X2h3X2ludGVycnVwdHM6IERlbW90ZSBhIGJ1bmNo
IG9mIGtlcm5lbC1kb2MKICAgIGFidXNlcwogIGRybS9tc20vZGlzcC9kcHUxL2RwdV9wbGFuZTog
Rml4IGEgY291cGxlIG9mIG5hbWluZyBpc3N1ZXMKICBkcm0vbXNtL21zbV9nZW06IERlbW90ZSBr
ZXJuZWwtZG9jIGFidXNlcwogIGRybS9tc20vZHAvZHBfY2F0YWxvZzogQ29ycmVjdGx5IGRvY3Vt
ZW50IHBhcmFtICdkcF9jYXRhbG9nJwogIGRybS9tc20vZHAvZHBfbGluazogRml4IHNvbWUgcG90
ZW50aWFsIGRvYy1yb3QKICBkcm0vbm91dmVhdS9udmttL3N1YmRldi9tYy90dTEwMjogTWFrZSBm
dW5jdGlvbnMgY2FsbGVkIGJ5IHJlZmVyZW5jZQogICAgc3RhdGljCiAgZHJtL2FtZC9kaXNwbGF5
L2RjL2RjZS9kY2VfdHJhbnNmb3JtOiBSZW1vdmUgc3VwZXJmbHVvdXMKICAgIHJlLWluaXRpYWxp
c2F0aW9uIG9mIERDRkVfTUVNX0xJR0hUX1NMRUVQX0NOVEwsCiAgZHJtL3hsbngvenlucW1wX2Rp
c3A6IEZpeCBpbmNvcnJlY3RseSBuYW1lZCBlbnVtCiAgICAnenlucW1wX2Rpc3BfbGF5ZXJfaWQn
CiAgZHJtL3hsbngvenlucW1wX2RwOiBGaXggaW5jb3JyZWN0bHkgbmFtZSBmdW5jdGlvbiAnenlu
cW1wX2RwX3RyYWluKCknCiAgZHJtL3R0bS90dG1fdHQ6IERlbW90ZSBub24tY29uZm9ybWFudCBr
ZXJuZWwtZG9jIGhlYWRlcgogIGRybS9wYW5lbC9wYW5lbC1yYXNwYmVycnlwaS10b3VjaHNjcmVl
bjogRGVtb3RlIGtlcm5lbC1kb2MgYWJ1c2UKICBkcm0vcGFuZWwvcGFuZWwtc2l0cm9uaXgtc3Q3
NzAxOiBEZW1vdGUga2VybmVsLWRvYyBhYnVzZQogIGRybS92Z2VtL3ZnZW1fZHJ2OiBTdGFuZGFy
ZCBjb21tZW50IGJsb2NrcyBzaG91bGQgbm90IHVzZSBrZXJuZWwtZG9jCiAgICBmb3JtYXQKICBk
cm0vZXh5bm9zL2V4eW5vczdfZHJtX2RlY29uOiBGaXggaW5jb3JyZWN0IG5hbWluZyBvZgogICAg
J2RlY29uX3NoYWRvd19wcm90ZWN0X3dpbigpJwogIGRybS9leHlub3MvZXh5bm9zX2RybV9pcHA6
IEZpeCBkb2N1bWVudGF0aW9uIGZvcgogICAgJ2V4eW5vc19kcm1faXBwX2dldF97Y2FwcyxyZXN9
X2lvY3RsKCknCiAgZHJtL3Zib3h2aWRlby9oZ3NtaV9iYXNlOiBQbGFjZSBmdW5jdGlvbiBuYW1l
cyBpbnRvIGhlYWRlcnMKICBkcm0vdmJveHZpZGVvL21vZGVzZXR0aW5nOiBQcm92aWRlIGZ1bmN0
aW9uIG5hbWVzIGZvciBwcm90b3R5cGUKICAgIGhlYWRlcnMKCiAuLi4vZHJtL2FtZC9kaXNwbGF5
L2RjL2RjZS9kY2VfdHJhbnNmb3JtLmggICAgfCAgMyArLQogZHJpdmVycy9ncHUvZHJtL2V4eW5v
cy9leHlub3M3X2RybV9kZWNvbi5jICAgIHwgIDIgKy0KIGRyaXZlcnMvZ3B1L2RybS9leHlub3Mv
ZXh5bm9zX2RybV9pcHAuYyAgICAgICB8ICA0ICstLQogZHJpdmVycy9ncHUvZHJtL21lZGlhdGVr
L210a19kaXNwX2NvbG9yLmMgICAgIHwgIDMgKy0KIGRyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9t
dGtfZGlzcF9nYW1tYS5jICAgICB8ICA0ICstLQogZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210
a19kaXNwX292bC5jICAgICAgIHwgIDMgKy0KIGRyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtf
ZGlzcF9yZG1hLmMgICAgICB8ICA0ICstLQogLi4uL2RybS9tc20vZGlzcC9kcHUxL2RwdV9lbmNv
ZGVyX3BoeXNfY21kLmMgIHwgIDQgLS0tCiAuLi4vZ3B1L2RybS9tc20vZGlzcC9kcHUxL2RwdV9o
d19pbnRlcnJ1cHRzLmMgfCAzMiArKysrKysrKystLS0tLS0tLS0tCiBkcml2ZXJzL2dwdS9kcm0v
bXNtL2Rpc3AvZHB1MS9kcHVfcGxhbmUuYyAgICAgfCAgNCArLS0KIGRyaXZlcnMvZ3B1L2RybS9t
c20vZHAvZHBfY2F0YWxvZy5jICAgICAgICAgICB8ICAyICstCiBkcml2ZXJzL2dwdS9kcm0vbXNt
L2RwL2RwX2xpbmsuYyAgICAgICAgICAgICAgfCAgNiArKy0tCiBkcml2ZXJzL2dwdS9kcm0vbXNt
L21zbV9nZW0uYyAgICAgICAgICAgICAgICAgfCAgNCArLS0KIC4uLi9ncHUvZHJtL25vdXZlYXUv
bnZrbS9zdWJkZXYvbWMvdHUxMDIuYyAgICB8ICA2ICsrLS0KIC4uLi9kcm0vcGFuZWwvcGFuZWwt
cmFzcGJlcnJ5cGktdG91Y2hzY3JlZW4uYyB8ICAyICstCiBkcml2ZXJzL2dwdS9kcm0vcGFuZWwv
cGFuZWwtc2l0cm9uaXgtc3Q3NzAxLmMgfCAgMiArLQogZHJpdmVycy9ncHUvZHJtL3N0aS9zdGlf
aGRhLmMgICAgICAgICAgICAgICAgIHwgIDYgKystLQogZHJpdmVycy9ncHUvZHJtL3N0aS9zdGlf
aGRtaV90eDNnNGMyOHBoeS5jICAgIHwgIDQgKy0tCiBkcml2ZXJzL2dwdS9kcm0vc3RpL3N0aV9o
cXZkcC5jICAgICAgICAgICAgICAgfCAgMiArLQogZHJpdmVycy9ncHUvZHJtL3N0aS9zdGlfdHZv
dXQuYyAgICAgICAgICAgICAgIHwgMTggKysrKystLS0tLS0KIGRyaXZlcnMvZ3B1L2RybS90dG0v
dHRtX3R0LmMgICAgICAgICAgICAgICAgICB8ICAyICstCiBkcml2ZXJzL2dwdS9kcm0vdmJveHZp
ZGVvL2hnc21pX2Jhc2UuYyAgICAgICAgfCAxOSArKysrKysrLS0tLQogZHJpdmVycy9ncHUvZHJt
L3Zib3h2aWRlby9tb2Rlc2V0dGluZy5jICAgICAgIHwgMjAgKysrKysrKy0tLS0tCiBkcml2ZXJz
L2dwdS9kcm0vdmdlbS92Z2VtX2Rydi5jICAgICAgICAgICAgICAgfCAgMiArLQogZHJpdmVycy9n
cHUvZHJtL3hsbngvenlucW1wX2Rpc3AuYyAgICAgICAgICAgIHwgIDIgKy0KIGRyaXZlcnMvZ3B1
L2RybS94bG54L3p5bnFtcF9kcC5jICAgICAgICAgICAgICB8ICAyICstCiAyNiBmaWxlcyBjaGFu
Z2VkLCA4MCBpbnNlcnRpb25zKCspLCA4MiBkZWxldGlvbnMoLSkKCkNjOiBBZGFtIEphY2tzb24g
PGFqYXhAcmVkaGF0LmNvbT4KQ2M6IEFqYXkgS3VtYXIgPGFqYXlrdW1hci5yc0BzYW1zdW5nLmNv
bT4KQ2M6IEFrc2h1IEFnYXJ3YWwgPGFrc2h1YUBnbWFpbC5jb20+CkNjOiBBbGV4IERldWNoZXIg
PGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+CkNjOiBBbGlzdGFpciBQb3BwbGUgPGFwb3BwbGVA
bnZpZGlhLmNvbT4KQ2M6IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCkNjOiBBbmdlbG9H
aW9hY2NoaW5vIERlbCBSZWdubyA8YW5nZWxvZ2lvYWNjaGluby5kZWxyZWdub0Bzb21haW5saW5l
Lm9yZz4KQ2M6IEJlbmphbWluIEdhaWduYXJkIDxiZW5qYW1pbi5nYWlnbmFyZEBsaW5hcm8ub3Jn
PgpDYzogQmVuIFNrZWdncyA8YnNrZWdnc0ByZWRoYXQuY29tPgpDYzogQmVuIFdpZGF3c2t5IDxi
ZW5AYndpZGF3c2submV0PgpDYzogQ2hhbmRhbiBVZGRhcmFqdSA8Y2hhbmRhbnVAY29kZWF1cm9y
YS5vcmc+CkNjOiBDaHJpc3RpYW4gS29lbmlnIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+CkNj
OiAiQ2hyaXN0aWFuIEvDtm5pZyIgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4KQ2M6IENodW4t
S3VhbmcgSHUgPGNodW5rdWFuZy5odUBrZXJuZWwub3JnPgpDYzogRGFuaWVsIFZldHRlciA8ZGFu
aWVsQGZmd2xsLmNoPgpDYzogRGF2aWQgQWlybGllIDxhaXJsaWVkQGxpbnV4LmllPgpDYzogZHJp
LWRldmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpDYzogRXJpYyBBbmhvbHQgPGVyaWNAYW5ob2x0
Lm5ldD4KQ2M6IEZhYmllbiBEZXNzZW5uZSA8ZmFiaWVuLmRlc3Nlbm5lQHN0LmNvbT4KQ2M6IGZy
ZWVkcmVub0BsaXN0cy5mcmVlZGVza3RvcC5vcmcKQ2M6IEhhbnMgZGUgR29lZGUgPGhkZWdvZWRl
QHJlZGhhdC5jb20+CkNjOiBIYXJyeSBXZW50bGFuZCA8aGFycnkud2VudGxhbmRAYW1kLmNvbT4K
Q2M6IEh1YW5nIFJ1aSA8cmF5Lmh1YW5nQGFtZC5jb20+CkNjOiBIeXVuIEt3b24gPGh5dW4ua3dv
bkB4aWxpbnguY29tPgpDYzogSW5raSBEYWUgPGlua2kuZGFlQHNhbXN1bmcuY29tPgpDYzogSmFn
YW4gVGVraSA8amFnYW5AYW1hcnVsYXNvbHV0aW9ucy5jb20+CkNjOiBKb29ueW91bmcgU2hpbSA8
ankwOTIyLnNoaW1Ac2Ftc3VuZy5jb20+CkNjOiBLcmlzaG5hIE1hbmlrYW5kYW4gPG1rcmlzaG5A
Y29kZWF1cm9yYS5vcmc+CkNjOiBLcnp5c3p0b2YgS296bG93c2tpIDxrcnp5c3p0b2Yua296bG93
c2tpQGNhbm9uaWNhbC5jb20+CkNjOiBLdW9nZWUgSHNpZWggPGtoc2llaEBjb2RlYXVyb3JhLm9y
Zz4KQ2M6IEt5dW5nbWluIFBhcmsgPGt5dW5nbWluLnBhcmtAc2Ftc3VuZy5jb20+CkNjOiBMYXVy
ZW50IFBpbmNoYXJ0IDxsYXVyZW50LnBpbmNoYXJ0QGlkZWFzb25ib2FyZC5jb20+CkNjOiBMZW8g
TGkgPHN1bnBlbmcubGlAYW1kLmNvbT4KQ2M6IGxpbmFyby1tbS1zaWdAbGlzdHMubGluYXJvLm9y
ZwpDYzogbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnCkNjOiBsaW51eC1hcm0t
bXNtQHZnZXIua2VybmVsLm9yZwpDYzogbGludXgtbWVkaWF0ZWtAbGlzdHMuaW5mcmFkZWFkLm9y
ZwpDYzogbGludXgtbWVkaWFAdmdlci5rZXJuZWwub3JnCkNjOiBsaW51eC1zYW1zdW5nLXNvY0B2
Z2VyLmtlcm5lbC5vcmcKQ2M6IE1hcmVrIFN6eXByb3dza2kgPG0uc3p5cHJvd3NraUBzYW1zdW5n
LmNvbT4KQ2M6IE1hdHRoaWFzIEJydWdnZXIgPG1hdHRoaWFzLmJnZ0BnbWFpbC5jb20+CkNjOiBN
YXVybyBSb3NzaSA8aXNzb3Iub3J1YW1AZ21haWwuY29tPgpDYzogTWljaGFsIFNpbWVrIDxtaWNo
YWwuc2ltZWtAeGlsaW54LmNvbT4KQ2M6IG5vdXZlYXVAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCkNj
OiBQaGlsaXBwIFphYmVsIDxwLnphYmVsQHBlbmd1dHJvbml4LmRlPgpDYzogUm9iIENsYXJrIDxy
b2JkY2xhcmtAZ21haWwuY29tPgpDYzogU2FtIFJhdm5ib3JnIDxzYW1AcmF2bmJvcmcub3JnPgpD
YzogU2VhbiBQYXVsIDxzZWFuQHBvb3JseS5ydW4+CkNjOiBTZXVuZy1Xb28gS2ltIDxzdzAzMTIu
a2ltQHNhbXN1bmcuY29tPgpDYzogU3RlcGhlbiBCb3lkIDxzd2JveWRAY2hyb21pdW0ub3JnPgpD
YzogU3VtaXQgU2Vtd2FsIDxzdW1pdC5zZW13YWxAbGluYXJvLm9yZz4KQ2M6IFRoaWVycnkgUmVk
aW5nIDx0aGllcnJ5LnJlZGluZ0BnbWFpbC5jb20+CkNjOiBWaW5jZW50IEFicmlvdSA8dmluY2Vu
dC5hYnJpb3VAc3QuY29tPgotLSAKMi4zMS4xCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZy
ZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3Rp
bmZvL2FtZC1nZngK
