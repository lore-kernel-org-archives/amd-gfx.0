Return-Path: <SRS0=FndT=ZH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0791EC43141
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Nov 2019 16:35:29 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD19920730
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Nov 2019 16:35:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD19920730
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BC6E86E953;
	Fri, 15 Nov 2019 16:35:27 +0000 (UTC)
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com
 [IPv6:2607:f8b0:4864:20::730])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3BEF06E953;
 Fri, 15 Nov 2019 16:35:26 +0000 (UTC)
Received: by mail-qk1-x730.google.com with SMTP id d13so8582497qko.3;
 Fri, 15 Nov 2019 08:35:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=HsczsOHRzfYjXhfOYn0siRhLPlHsf833zErUpogAfD0=;
 b=fD5xoNVcZQSwoOdWD+5HGnPG85VDx74dGeMQ6mNICp4h/H+wjiNH+Gv1uJM+VjIdiM
 H7+DXryGMlBWAx8rgV9byyuCMNkAi94OOEzP6AGh8NJ6tp8FIMmXU2021avWzx5IqP7V
 4U4b6qD7sIL4KFZ81kZbvvrsH+ige0rgrwhYj1vhkWK4HAfUq7iyIugkbHwxiR9bS494
 ynR9nxw4HkLImVZnkTr85D28LNyt81XC5R1JeM3sQlEuwMGlJgcRztUu1psQO52OEVH4
 iBNWHkm4NjxnNRVpv6k8BCmwv2XVJ9U79THb/RlcZAFGZaBV9N/D1VATi+H2aXBG1TPq
 tXNg==
X-Gm-Message-State: APjAAAVTiCty0AhJ4o1hxFfylpR0B5lC/NQEQKTQ85cuXfjEO5IsQB25
 Ui6NSiXaEzkV3db3Gn6CNSB9GmUM
X-Google-Smtp-Source: APXvYqyN3KdViH5IJhoAGOQYt77Ro8E+l/uxUyko3cza9VNBkrTEk30ALqy0aysikGekeQujm/KOUg==
X-Received: by 2002:a37:41d2:: with SMTP id
 o201mr13961084qka.100.1573835724738; 
 Fri, 15 Nov 2019 08:35:24 -0800 (PST)
Received: from localhost.localdomain ([71.219.59.120])
 by smtp.gmail.com with ESMTPSA id i128sm4432338qkf.134.2019.11.15.08.35.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Nov 2019 08:35:24 -0800 (PST)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 airlied@gmail.com, daniel.vetter@ffwll.ch
Subject: [pull] radeon and amdgpu drm-next-5.5
Date: Fri, 15 Nov 2019 11:35:16 -0500
Message-Id: <20191115163516.3714-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=HsczsOHRzfYjXhfOYn0siRhLPlHsf833zErUpogAfD0=;
 b=Y+pKMhw4zmGJ60newI3sk05ZvIyYDhizaHnTJD5ftDWaePh1BdWuDl6NIgOmyoqsc+
 De7pM9ICXrQXThtFz41y1zzA2MsN1MoEqlRcJMDqua+1ASfYplwNeHwQ2hAWopoUkg9F
 Z/uruD2XINic78qqmfr2DazTRmhSO6Bnf9uHsBxgNP6Qi1hd1GprlBxTrXE8KfPA+fiW
 IV1rOGLjrlDqSF3fLipXqVGexZqSzmxtHMc4xh/q+HCreyb/28Clsbzmeqz5yQ5H6Wai
 dtsVCkBfs7HUe0UZKtw21n+l09PkHOxw6fnBlms8L4tYFCdMIXiIWYQ5AghhLXiuQLmF
 mnDA==
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191115163516.iirWGdbv0nD_Qm4m2UgehaZboDGCeZhjDp3fKu29nDk@z>

SGkgRGF2ZSwgRGFuaWVsLAoKTWlzYyBmaXhlcyBmb3IgNS41LgoKVGhlIGZvbGxvd2luZyBjaGFu
Z2VzIHNpbmNlIGNvbW1pdCA1M2RiYzI3YWQ1YTkzOTMyZmYxODkyYThlNGVmMjY2ODI3ZDc0YTBm
OgoKICBkcm0vYW1kZ3B1L3Bvd2VycGxheTogZml4IEFWRlMgaGFuZGxpbmcgd2l0aCBjdXN0b20g
cG93ZXJwbGF5IHRhYmxlICgyMDE5LTExLTA4IDEyOjMwOjI0IC0wNTAwKQoKYXJlIGF2YWlsYWJs
ZSBpbiB0aGUgR2l0IHJlcG9zaXRvcnkgYXQ6CgogIGdpdDovL3Blb3BsZS5mcmVlZGVza3RvcC5v
cmcvfmFnZDVmL2xpbnV4IHRhZ3MvZHJtLW5leHQtNS41LTIwMTktMTEtMTUKCmZvciB5b3UgdG8g
ZmV0Y2ggY2hhbmdlcyB1cCB0byA2MjJiMmEwYWI2NDdkMjc1NWYyYzFmMTAwMGQzNDAzZTg2YTY5
NzYzOgoKICBkcm0vYW1kZ3B1L3ZjbjogZmluaXNoIGRlbGF5IHdvcmsgYmVmb3JlIHJlbGVhc2Ug
cmVzb3VyY2VzICgyMDE5LTExLTEzIDE1OjI5OjQyIC0wNTAwKQoKLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQpkcm0tbmV4dC01
LjUtMjAxOS0xMS0xNToKCmFtZGdwdToKLSBGaXggQVZGUyBoYW5kbGluZyBvbiBTTVU3IHBhcnRz
IHdpdGggY3VzdG9tIHBvd2VyIHRhYmxlcwotIEVuYWJsZSBPdmVyZHJpdmUgc3lzZnMgaW50ZXJm
YWNlIGZvciBOYXZpIHBhcnRzCi0gRml4IHBvd2VyIGxpbWl0IGhhbmRsaW5nIG9uIHNtdTExIHBh
cnRzCi0gRml4IHBjaWUgbGluayBzeXNmcyBvdXRwdXQgZm9yIE5hdmkKLSBQcm9wZXJseSBjYW5j
ZWwgTU0gd29ya2VyIHRocmVhZHMgb24gc2h1dGRvd24KCnJhZGVvbjoKLSBDbGVhbnVwIGZvciBw
cGMgY2hhbmdlCgotLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tCkFsZXggRGV1Y2hlciAoMik6CiAgICAgIGRybS9hbWRncHUvcG93
ZXJwbGF5L3NtdTc6IGZpeCBBVkZTIGhhbmRsaW5nIHdpdGggY3VzdG9tIHBvd2VycGxheSB0YWJs
ZQogICAgICBkcm0vYW1kZ3B1L3ZjbjogZmluaXNoIGRlbGF5IHdvcmsgYmVmb3JlIHJlbGVhc2Ug
cmVzb3VyY2VzCgpIYXdraW5nIFpoYW5nICgxKToKICAgICAgZHJtL2FtZGdwdTogYXZvaWQgdXBs
b2FkIGNvcnJ1cHRlZCB0YSB1Y29kZSB0byBwc3AKCkplc3NlIFpoYW5nICgxKToKICAgICAgZHJt
L2FtZC9hbWRncHU6IGZpbmlzaCBkZWxheSB3b3JrcyBiZWZvcmUgcmVsZWFzZSByZXNvdXJjZXMK
Cktlbm5ldGggRmVuZyAoMSk6CiAgICAgIGRybS9hbWQvcG93ZXJwbGF5OiByZWFkIHBjaWUgc3Bl
ZWQvd2lkdGggaW5mbyAodjIpCgpLeWxlTWFobGt1Y2ggKDEpOgogICAgICBkcm0vcmFkZW9uOiBD
bGVhbiB1cCBjb2RlIGluIHJhZGVvbl9wY2lfc2h1dGRvd24oKQoKTWF0dCBDb2ZmaW4gKDQpOgog
ICAgICBkcm0vYW1kZ3B1L25hdmkxMDogaW1wbGVtZW50IHNjbGsvbWNsayBPRCB2aWEgcHBfb2Rf
Y2xrX3ZvbHRhZ2UKICAgICAgZHJtL2FtZGdwdS9uYXZpMTA6IGltcGxlbWVudCBHRlhDTEtfQ1VS
VkUgb3ZlcmRyaXZlCiAgICAgIGRybS9hbWRncHUvbmF2aTEwOiBJbXBsZW1lbnQgb2QgY2xrIHBy
aW50aW5nCiAgICAgIGRybS9hbWRncHUvc211X3YxMTogVW5pZnkgYW5kIGZpeCBwb3dlciBsaW1p
dHMKCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGV2aWNlLmMgICAgICAgICB8
ICAgMyArCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcHNwLmMgICAgICAgICAg
ICB8ICAyMiArLQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3V2ZC5jICAgICAg
ICAgICAgfCAgIDEgKwogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZjZS5jICAg
ICAgICAgICAgfCAgIDEgKwogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Zjbi5j
ICAgICAgICAgICAgfCAgIDIgKwogZHJpdmVycy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkvYW1kZ3B1
X3NtdS5jICAgICAgICAgfCAgMjIgKy0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L2Fy
Y3R1cnVzX3BwdC5jICAgICAgIHwgIDIzICstCiBkcml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxh
eS9od21nci9zbXU3X2h3bWdyLmMgICB8ICAgNyArCiBkcml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2Vy
cGxheS9pbmMvYW1kZ3B1X3NtdS5oICAgICB8ICAgNCArLQogZHJpdmVycy9ncHUvZHJtL2FtZC9w
b3dlcnBsYXkvaW5jL3NtdV92MTFfMC5oICAgICAgfCAgMTIgKwogLi4uL2dwdS9kcm0vYW1kL3Bv
d2VycGxheS9pbmMvc211X3YxMV8wX3BwdGFibGUuaCAgfCAgIDIgKwogZHJpdmVycy9ncHUvZHJt
L2FtZC9wb3dlcnBsYXkvbmF2aTEwX3BwdC5jICAgICAgICAgfCAzNTEgKysrKysrKysrKysrKysr
KysrKystCiBkcml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS9uYXZpMTBfcHB0LmggICAgICAg
ICB8ICAgNSArCiBkcml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS9zbXVfdjExXzAuYyAgICAg
ICAgICB8ICA2NyArKystCiBkcml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS92ZWdhMjBfcHB0
LmMgICAgICAgICB8ICAgMSAtCiBkcml2ZXJzL2dwdS9kcm0vcmFkZW9uL3JhZGVvbl9kcnYuYyAg
ICAgICAgICAgICAgICB8ICAgOSArLQogMTYgZmlsZXMgY2hhbmdlZCwgNDkzIGluc2VydGlvbnMo
KyksIDM5IGRlbGV0aW9ucygtKQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9w
Lm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1n
Zng=
