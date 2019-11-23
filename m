Return-Path: <SRS0=lTJr=ZR=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD4DDC432C0
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Nov 2019 08:08:05 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9EEC2207FD
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Nov 2019 08:08:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9EEC2207FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1A0F889F4F;
	Mon, 25 Nov 2019 08:08:04 +0000 (UTC)
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com
 [IPv6:2607:f8b0:4864:20::244])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DEC126E0F4;
 Sat, 23 Nov 2019 19:36:45 +0000 (UTC)
Received: by mail-oi1-x244.google.com with SMTP id x21so2511703oic.0;
 Sat, 23 Nov 2019 11:36:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=oSQc37dqCsKmcQ7zoyXBibnTMKn/Bl9FPXqYEwoE1CQ=;
 b=EV30RktEsBwRGxlq74vFWTcFgHfC5nFtPoYqIudyRw6orwrklDMx4RRaPJWIfDx2SR
 tUECJnS6KqCJyV2jHMzTUIWUVeFHEDN0GycgB8cZTptxwP2c7dlV4SetGYCxf7I2Z5Zs
 2qn6QoSe/9gOfMLnas82A3g3GpN5lgIPEs+its5HXSQCW2DvhvRwnEpAmzKmFhokHMWj
 Cuyv7qrPC7pwa9m/yAZrwpEHNcc5And6QHWPil4nqAMyHf03e7QizvWyGTClNRVqUA1t
 JyfUNkhMX3eXJI6CxbVuc2zsP5Or+BS3qjl6wmPYPs3fKIECWwzfziVTpYGKjEaNOSX+
 6ufg==
X-Gm-Message-State: APjAAAX5HRFIjw+nm679UJY/V+IWC0mwagiKLE971WbjsQu8CNdDo+FS
 2hoGlHfE9SVhJUlXYj8pb9E=
X-Google-Smtp-Source: APXvYqw88oFHCtkJk2ssxIM4pcvPnzipOe00LVFTxu4p4QE+zj9SziILY4FsQ/PNgyJqg+LhgSX0hQ==
X-Received: by 2002:aca:1715:: with SMTP id j21mr16374553oii.6.1574537804955; 
 Sat, 23 Nov 2019 11:36:44 -0800 (PST)
Received: from localhost.localdomain ([2604:1380:4111:8b00::7])
 by smtp.gmail.com with ESMTPSA id q3sm551968oti.49.2019.11.23.11.36.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 23 Nov 2019 11:36:44 -0800 (PST)
From: Nathan Chancellor <natechancellor@gmail.com>
To: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 "David (ChunMing) Zhou" <David1.Zhou@amd.com>
Subject: [PATCH] drm/amd/display: Use NULL for pointer assignment in
 copy_stream_update_to_stream
Date: Sat, 23 Nov 2019 12:36:39 -0700
Message-Id: <20191123193639.55297-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
X-Patchwork-Bot: notify
X-Mailman-Approved-At: Mon, 25 Nov 2019 08:07:50 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=oSQc37dqCsKmcQ7zoyXBibnTMKn/Bl9FPXqYEwoE1CQ=;
 b=WbGn4JFxkkTuruODpeF0BiqIiobfrQaqt4UfNgnpPqG1TPanPiI6XYwkF1u77Wlf0x
 VhxD/a/EOS73a8zJp9qKrc7iX8zceDLI+AnOY7X0TYYEZq3rJSTzU7P2qojhdMUFWeKM
 Uz8yowHqgIaVwF6dV+5dZyBLMAz5x5ZXUzR3UvfWD5BWf3VbbHI06nncpAqYr7+WDDRZ
 vg+/vScXkLKb7RppS4/yzuaNhxsiqhuE85puhcDYDaGDITEv9jTFHXG5HlDfejIp6Q+d
 DEXwi2vDvjLuCPATa/70h8DBhHniolPlDfqCASW1kQ8N/iVhQEZBDbrGbOT7w0sgl6r8
 xoZg==
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
Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, Nikola Cornij <nikola.cornij@amd.com>,
 clang-built-linux@googlegroups.com,
 Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>, amd-gfx@lists.freedesktop.org,
 Nathan Chancellor <natechancellor@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191123193639.jENLRAk0EHoeC_qe2zQ88X-gqUZU8oGekgrTGhVbD-E@z>

Q2xhbmcgd2FybnM6CgouLi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS8uLi9kaXNwbGF5L2Rj
L2NvcmUvZGMuYzoxOTY1OjI2OiB3YXJuaW5nOgpleHByZXNzaW9uIHdoaWNoIGV2YWx1YXRlcyB0
byB6ZXJvIHRyZWF0ZWQgYXMgYSBudWxsIHBvaW50ZXIgY29uc3RhbnQgb2YKdHlwZSAnc3RydWN0
IGRjX2RzY19jb25maWcgKicgWy1Xbm9uLWxpdGVyYWwtbnVsbC1jb252ZXJzaW9uXQogICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIHVwZGF0ZS0+ZHNjX2NvbmZpZyA9IGZhbHNlOwogICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIF5+fn5+Ci4u
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1Ly4uL2Rpc3BsYXkvZGMvY29yZS9kYy5jOjE5NzE6
MjU6IHdhcm5pbmc6CmV4cHJlc3Npb24gd2hpY2ggZXZhbHVhdGVzIHRvIHplcm8gdHJlYXRlZCBh
cyBhIG51bGwgcG9pbnRlciBjb25zdGFudCBvZgp0eXBlICdzdHJ1Y3QgZGNfZHNjX2NvbmZpZyAq
JyBbLVdub24tbGl0ZXJhbC1udWxsLWNvbnZlcnNpb25dCiAgICAgICAgICAgICAgICAgICAgICAg
IHVwZGF0ZS0+ZHNjX2NvbmZpZyA9IGZhbHNlOwogICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICBefn5+fgoyIHdhcm5pbmdzIGdlbmVyYXRlZC4KCkZpeGVzOiBmNmZl
NDA1M2I5MWYgKCJkcm0vYW1kL2Rpc3BsYXk6IFVzZSBhIHRlbXBvcmFyeSBjb3B5IG9mIHRoZSBj
dXJyZW50IHN0YXRlIHdoZW4gdXBkYXRpbmcgRFNDIGNvbmZpZyIpCkxpbms6IGh0dHBzOi8vZ2l0
aHViLmNvbS9DbGFuZ0J1aWx0TGludXgvbGludXgvaXNzdWVzLzc3NwpTaWduZWQtb2ZmLWJ5OiBO
YXRoYW4gQ2hhbmNlbGxvciA8bmF0ZWNoYW5jZWxsb3JAZ21haWwuY29tPgotLS0KIGRyaXZlcnMv
Z3B1L2RybS9hbWQvZGlzcGxheS9kYy9jb3JlL2RjLmMgfCA0ICsrLS0KIDEgZmlsZSBjaGFuZ2Vk
LCAyIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9n
cHUvZHJtL2FtZC9kaXNwbGF5L2RjL2NvcmUvZGMuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlz
cGxheS9kYy9jb3JlL2RjLmMKaW5kZXggYzdkYjRmNDgxMGM2Li4yNjQ1ZDIwZThjNGMgMTAwNjQ0
Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9jb3JlL2RjLmMKKysrIGIvZHJp
dmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2NvcmUvZGMuYwpAQCAtMTk2MiwxMyArMTk2Miwx
MyBAQCBzdGF0aWMgdm9pZCBjb3B5X3N0cmVhbV91cGRhdGVfdG9fc3RyZWFtKHN0cnVjdCBkYyAq
ZGMsCiAJCQlpZiAoIWRjLT5yZXNfcG9vbC0+ZnVuY3MtPnZhbGlkYXRlX2JhbmR3aWR0aChkYywg
ZHNjX3ZhbGlkYXRlX2NvbnRleHQsIHRydWUpKSB7CiAJCQkJc3RyZWFtLT50aW1pbmcuZHNjX2Nm
ZyA9IG9sZF9kc2NfY2ZnOwogCQkJCXN0cmVhbS0+dGltaW5nLmZsYWdzLkRTQyA9IG9sZF9kc2Nf
ZW5hYmxlZDsKLQkJCQl1cGRhdGUtPmRzY19jb25maWcgPSBmYWxzZTsKKwkJCQl1cGRhdGUtPmRz
Y19jb25maWcgPSBOVUxMOwogCQkJfQogCiAJCQlkY19yZWxlYXNlX3N0YXRlKGRzY192YWxpZGF0
ZV9jb250ZXh0KTsKIAkJfSBlbHNlIHsKIAkJCURDX0VSUk9SKCJGYWlsZWQgdG8gYWxsb2NhdGUg
bmV3IHZhbGlkYXRlIGNvbnRleHQgZm9yIERTQyBjaGFuZ2VcbiIpOwotCQkJdXBkYXRlLT5kc2Nf
Y29uZmlnID0gZmFsc2U7CisJCQl1cGRhdGUtPmRzY19jb25maWcgPSBOVUxMOwogCQl9CiAJfQog
fQotLSAKMi4yNC4wCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpo
dHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZng=
