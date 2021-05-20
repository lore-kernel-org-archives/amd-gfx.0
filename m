Return-Path: <SRS0=8Dg8=KP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25A3FC43619
	for <amd-gfx@archiver.kernel.org>; Thu, 20 May 2021 12:49:33 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E2E4361001
	for <amd-gfx@archiver.kernel.org>; Thu, 20 May 2021 12:49:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2E4361001
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 988136F45E;
	Thu, 20 May 2021 12:49:16 +0000 (UTC)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9EC826F41B
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 May 2021 12:03:09 +0000 (UTC)
Received: by mail-wm1-x336.google.com with SMTP id
 z85-20020a1c7e580000b029017a76f3afbaso2531543wmc.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 May 2021 05:03:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=EkPRRoz7F84TTvDB6+0jP5Wh7M4ODElC4NQcMjBtFnE=;
 b=C7sgYTiANrC4NQXV+e5udHxsCPzVZnTdUONTGFy0elAjMgOr4a4/G1J+MxGPYWhgeG
 fKGfGMfyFUqP/jfVk/15fcyt5KfukAI0rN0/N2CeMI481eYGwA/ae2yAGB5r+KY8XBHU
 WS7b7Qm8Ple3GdMdCYcMp+hm6XJtj1QmCU9DJk9LqD58oSjspNVNWGzgWaitErSc4qWm
 NMIpVZzr8aIs+wkkMsvfH0oKbSph/Ecueoe50rcU9k85CjFRwvRRmZROlZdtpcEc19U9
 YWDrGUfx/MmdtGpYp/+KlYsxMkUJg5YvQj8KD4ya/3Nq0FnI2SucE+lTMo8DIpSGJcX6
 ygwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=EkPRRoz7F84TTvDB6+0jP5Wh7M4ODElC4NQcMjBtFnE=;
 b=Isr2DY4fr5ZAW5ZxpUQowsxgyKniibOEiny7TiVqIA4H+byvIopvsB9XHBUHm0DJm+
 S6796e7f2bw93qqTn6bSbz7fr+zc9hpXo33RI/8qFXceLWVw+PXfIyiLYAzBvEQYdS6i
 iZdWNtI9/0uFJ9UM/Lk/lbt6hHQ8YWcnl/U5C1guCCl7+oKXGT1cgOI4sWDvQjrHVxFm
 2KBGHafSf6dhm8UOi+IIcAGoBIupqP+0cui6vCgVngueZIR6KcqdhMwVWJhTUP/iNPa5
 q9vZGZLFoNnMX4qLZfGBH+6CvwjKD+/zzuX2539heiixbnlxs+YaVdHPj8v38RA/Mwoq
 btiQ==
X-Gm-Message-State: AOAM533+5RfIYmi9I7UX4PqqatYXhMXohlQ0SkUQhwnNoU261ZTqtcxD
 HyJ/RC/4O0u5aivUVUtNxOCspg==
X-Google-Smtp-Source: ABdhPJzPnAPqk77sjtNc+xUnzh/WodTD1UR6pw3gSJKCE5waqxLJcs6BuyWwb2EH/6hrtLLTYjuCKA==
X-Received: by 2002:a7b:c8ce:: with SMTP id f14mr3283573wml.81.1621512188364; 
 Thu, 20 May 2021 05:03:08 -0700 (PDT)
Received: from dell.default ([91.110.221.215])
 by smtp.gmail.com with ESMTPSA id j10sm2886332wrt.32.2021.05.20.05.03.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 May 2021 05:03:07 -0700 (PDT)
From: Lee Jones <lee.jones@linaro.org>
To: lee.jones@linaro.org
Subject: [PATCH 16/38] drm/amd/amdgpu/si_dma: Fix some function name disparity
Date: Thu, 20 May 2021 13:02:26 +0100
Message-Id: <20210520120248.3464013-17-lee.jones@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210520120248.3464013-1-lee.jones@linaro.org>
References: <20210520120248.3464013-1-lee.jones@linaro.org>
MIME-Version: 1.0
X-Mailman-Approved-At: Thu, 20 May 2021 12:49:10 +0000
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
Cc: David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org,
 amd-gfx@lists.freedesktop.org,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 linaro-mm-sig@lists.linaro.org, dri-devel@lists.freedesktop.org,
 Daniel Vetter <daniel@ffwll.ch>, Alex Deucher <alexander.deucher@amd.com>,
 Sumit Semwal <sumit.semwal@linaro.org>, linux-media@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Rml4ZXMgdGhlIGZvbGxvd2luZyBXPTEga2VybmVsIGJ1aWxkIHdhcm5pbmcocyk6CgogZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvc2lfZG1hLmM6MzIwOiB3YXJuaW5nOiBleHBlY3RpbmcgcHJv
dG90eXBlIGZvciBjaWtfZG1hX3ZtX2NvcHlfcHRlKCkuIFByb3RvdHlwZSB3YXMgZm9yIHNpX2Rt
YV92bV9jb3B5X3B0ZSgpIGluc3RlYWQKIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3NpX2Rt
YS5jOjQxMjogd2FybmluZzogZXhwZWN0aW5nIHByb3RvdHlwZSBmb3Igc2lfZG1hX3BhZF9pYigp
LiBQcm90b3R5cGUgd2FzIGZvciBzaV9kbWFfcmluZ19wYWRfaWIoKSBpbnN0ZWFkCiBkcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9zaV9kbWEuYzo0MjU6IHdhcm5pbmc6IGV4cGVjdGluZyBwcm90
b3R5cGUgZm9yIGNpa19zZG1hX3JpbmdfZW1pdF9waXBlbGluZV9zeW5jKCkuIFByb3RvdHlwZSB3
YXMgZm9yIHNpX2RtYV9yaW5nX2VtaXRfcGlwZWxpbmVfc3luYygpIGluc3RlYWQKCkNjOiBBbGV4
IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+CkNjOiAiQ2hyaXN0aWFuIEvDtm5p
ZyIgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4KQ2M6IERhdmlkIEFpcmxpZSA8YWlybGllZEBs
aW51eC5pZT4KQ2M6IERhbmllbCBWZXR0ZXIgPGRhbmllbEBmZndsbC5jaD4KQ2M6IFN1bWl0IFNl
bXdhbCA8c3VtaXQuc2Vtd2FsQGxpbmFyby5vcmc+CkNjOiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNr
dG9wLm9yZwpDYzogZHJpLWRldmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpDYzogbGludXgtbWVk
aWFAdmdlci5rZXJuZWwub3JnCkNjOiBsaW5hcm8tbW0tc2lnQGxpc3RzLmxpbmFyby5vcmcKU2ln
bmVkLW9mZi1ieTogTGVlIEpvbmVzIDxsZWUuam9uZXNAbGluYXJvLm9yZz4KLS0tCiBkcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9zaV9kbWEuYyB8IDYgKysrLS0tCiAxIGZpbGUgY2hhbmdlZCwg
MyBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L3NpX2RtYS5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvc2lf
ZG1hLmMKaW5kZXggY2I3MDNlMzA3MjM4ZC4uMTk1YjQ1YmNiOGFkOSAxMDA2NDQKLS0tIGEvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvc2lfZG1hLmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvc2lfZG1hLmMKQEAgLTMwNSw3ICszMDUsNyBAQCBzdGF0aWMgaW50IHNpX2RtYV9y
aW5nX3Rlc3RfaWIoc3RydWN0IGFtZGdwdV9yaW5nICpyaW5nLCBsb25nIHRpbWVvdXQpCiB9CiAK
IC8qKgotICogY2lrX2RtYV92bV9jb3B5X3B0ZSAtIHVwZGF0ZSBQVEVzIGJ5IGNvcHlpbmcgdGhl
bSBmcm9tIHRoZSBHQVJUCisgKiBzaV9kbWFfdm1fY29weV9wdGUgLSB1cGRhdGUgUFRFcyBieSBj
b3B5aW5nIHRoZW0gZnJvbSB0aGUgR0FSVAogICoKICAqIEBpYjogaW5kaXJlY3QgYnVmZmVyIHRv
IGZpbGwgd2l0aCBjb21tYW5kcwogICogQHBlOiBhZGRyIG9mIHRoZSBwYWdlIGVudHJ5CkBAIC00
MDIsNyArNDAyLDcgQEAgc3RhdGljIHZvaWQgc2lfZG1hX3ZtX3NldF9wdGVfcGRlKHN0cnVjdCBh
bWRncHVfaWIgKmliLAogfQogCiAvKioKLSAqIHNpX2RtYV9wYWRfaWIgLSBwYWQgdGhlIElCIHRv
IHRoZSByZXF1aXJlZCBudW1iZXIgb2YgZHcKKyAqIHNpX2RtYV9yaW5nX3BhZF9pYiAtIHBhZCB0
aGUgSUIgdG8gdGhlIHJlcXVpcmVkIG51bWJlciBvZiBkdwogICoKICAqIEByaW5nOiBhbWRncHVf
cmluZyBwb2ludGVyCiAgKiBAaWI6IGluZGlyZWN0IGJ1ZmZlciB0byBmaWxsIHdpdGggcGFkZGlu
ZwpAQCAtNDE1LDcgKzQxNSw3IEBAIHN0YXRpYyB2b2lkIHNpX2RtYV9yaW5nX3BhZF9pYihzdHJ1
Y3QgYW1kZ3B1X3JpbmcgKnJpbmcsIHN0cnVjdCBhbWRncHVfaWIgKmliKQogfQogCiAvKioKLSAq
IGNpa19zZG1hX3JpbmdfZW1pdF9waXBlbGluZV9zeW5jIC0gc3luYyB0aGUgcGlwZWxpbmUKKyAq
IHNpX2RtYV9yaW5nX2VtaXRfcGlwZWxpbmVfc3luYyAtIHN5bmMgdGhlIHBpcGVsaW5lCiAgKgog
ICogQHJpbmc6IGFtZGdwdV9yaW5nIHBvaW50ZXIKICAqCi0tIAoyLjMxLjEKCl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0
CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Au
b3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
