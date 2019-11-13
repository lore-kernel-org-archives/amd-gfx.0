Return-Path: <SRS0=4UxD=ZF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97CE5C432C3
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Nov 2019 19:29:47 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 039AD206D5
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Nov 2019 19:29:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 039AD206D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 361FC6EE38;
	Wed, 13 Nov 2019 19:29:47 +0000 (UTC)
Received: from mail-yw1-xc42.google.com (mail-yw1-xc42.google.com
 [IPv6:2607:f8b0:4864:20::c42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 46BEA6EE38
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Nov 2019 19:29:46 +0000 (UTC)
Received: by mail-yw1-xc42.google.com with SMTP id n82so1100398ywc.7
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Nov 2019 11:29:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=XfzcN5070+5aqmmN0Q0dy8aMynaBJRNBTy+L9zS3PAs=;
 b=prxN+62V8utW0+VPZt8as+GtVvUCmd29CcUZSndNfIQdds4XUpRxFFGDe1MNC1z4t8
 RQn9nCKQwMUy/hDaSxlvQn/0bkPBrWPGuVJwAL9kToyYIdq5xx8CcdUY8fFICVwMH6s+
 gs54TZMFayn1rA/2L4ddhbQv7mtG9zvkOQO/H/nsLwi1nb3rXKhGIbXXbm17+MjCtZQO
 TSl7HTTzpKOfimVOHrNNsaxt32hvnNaniD0zC6+uIFB6zbkS7p/zlJk9pZriDq+XVxk6
 tlxYZcbIKvUV8VPLdbVD3iLNPe7+/AJxNu7+TcAjCDbz5Kusiz6V6zE4dtnhxbVlWx5w
 qAtg==
X-Gm-Message-State: APjAAAWNJF3fshkiB7YGVs3LpE13M3sv12lcUTofaAFhnw5j1DUGJ8NT
 bvaC7W1vdFKibsxoTLTqF+ZUz7NO
X-Google-Smtp-Source: APXvYqxsWOnrKcjyx+yOGsAQBt7j1elQSNSy9ZTJ4RLpxQL8YoWgUYc+NiwV5qFn1uYg0kuPR0g/Bw==
X-Received: by 2002:a81:d543:: with SMTP id l3mr3208921ywj.394.1573673385094; 
 Wed, 13 Nov 2019 11:29:45 -0800 (PST)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id 197sm937560ywf.42.2019.11.13.11.29.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Nov 2019 11:29:44 -0800 (PST)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu/nv: add asic func for fetching vbios from rom
 directly
Date: Wed, 13 Nov 2019 14:29:37 -0500
Message-Id: <20191113192937.781329-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=XfzcN5070+5aqmmN0Q0dy8aMynaBJRNBTy+L9zS3PAs=;
 b=bJ+0lx0rxznJRM0ug/yxUdDHvD9KxzSAGiSfG4YkcRBhJxNrEeul5spHI2x4v/GKz7
 wOBQiHDKH3lTzVx5csrJf1u0KPwBvtnJ1qINrtO3YsYwK/Sun7v3UDtKuR/7jgCBLtKU
 KSFCF96KXTNumtu+hocRX/TBW/3RtRsxVJKgh0tgBuRHBVB/KZqA99LuvRLmhBosKxnE
 qM7HaWc98RAnobholYKQ1qXTTpXTCxv50JxFtf3MPHRsChzu1zL4bgE9HabMIna/PT7Q
 NMzaMpnno98vlkpFU2h9QoY7n8k48B4F4/Da7s5XiFMKFtzmKCgiSzVPXQoZt1khlsCP
 X8jg==
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
Message-ID: <20191113192937.j3qgragHh5gbcgxDVmwu0_h_5jR5ccBKyMK7h_fP49o@z>

TmVlZGVkIGFzIGEgZmFsbGJhY2sgaWYgdGhlIHZiaW9zIGNhbid0IGJlIGZldGNoZWQgYnkgb3Ro
ZXIgbWVhbnMuCgpTaWduZWQtb2ZmLWJ5OiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVy
QGFtZC5jb20+Ci0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvbnYuYyB8IDI0ICsrKysr
KysrKysrKysrKysrKysrKystLQogMSBmaWxlIGNoYW5nZWQsIDIyIGluc2VydGlvbnMoKyksIDIg
ZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvbnYu
YyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L252LmMKaW5kZXggNzI4M2Q2MTk4Yjg5Li5h
ZDA0ZDFkNmU5YzcgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L252LmMK
KysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvbnYuYwpAQCAtNDAsNiArNDAsNyBAQAog
I2luY2x1ZGUgImdjL2djXzEwXzFfMF9zaF9tYXNrLmgiCiAjaW5jbHVkZSAiaGRwL2hkcF81XzBf
MF9vZmZzZXQuaCIKICNpbmNsdWRlICJoZHAvaGRwXzVfMF8wX3NoX21hc2suaCIKKyNpbmNsdWRl
ICJzbXVpby9zbXVpb18xMV8wXzBfb2Zmc2V0LmgiCiAKICNpbmNsdWRlICJzb2MxNS5oIgogI2lu
Y2x1ZGUgInNvYzE1X2NvbW1vbi5oIgpAQCAtMTU2LDggKzE1NywyNyBAQCBzdGF0aWMgYm9vbCBu
dl9yZWFkX2Rpc2FibGVkX2Jpb3Moc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpCiBzdGF0aWMg
Ym9vbCBudl9yZWFkX2Jpb3NfZnJvbV9yb20oc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsCiAJ
CQkJICB1OCAqYmlvcywgdTMyIGxlbmd0aF9ieXRlcykKIHsKLQkvKiBUT0RPOiB3aWxsIGltcGxl
bWVudCBpdCB3aGVuIFNNVSBoZWFkZXIgaXMgYXZhaWxhYmxlICovCi0JcmV0dXJuIGZhbHNlOwor
CXUzMiAqZHdfcHRyOworCXUzMiBpLCBsZW5ndGhfZHc7CisKKwlpZiAoYmlvcyA9PSBOVUxMKQor
CQlyZXR1cm4gZmFsc2U7CisJaWYgKGxlbmd0aF9ieXRlcyA9PSAwKQorCQlyZXR1cm4gZmFsc2U7
CisJLyogQVBVIHZiaW9zIGltYWdlIGlzIHBhcnQgb2Ygc2Jpb3MgaW1hZ2UgKi8KKwlpZiAoYWRl
di0+ZmxhZ3MgJiBBTURfSVNfQVBVKQorCQlyZXR1cm4gZmFsc2U7CisKKwlkd19wdHIgPSAodTMy
ICopYmlvczsKKwlsZW5ndGhfZHcgPSBBTElHTihsZW5ndGhfYnl0ZXMsIDQpIC8gNDsKKworCS8q
IHNldCByb20gaW5kZXggdG8gMCAqLworCVdSRUczMihTT0MxNV9SRUdfT0ZGU0VUKFNNVUlPLCAw
LCBtbVJPTV9JTkRFWCksIDApOworCS8qIHJlYWQgb3V0IHRoZSByb20gZGF0YSAqLworCWZvciAo
aSA9IDA7IGkgPCBsZW5ndGhfZHc7IGkrKykKKwkJZHdfcHRyW2ldID0gUlJFRzMyKFNPQzE1X1JF
R19PRkZTRVQoU01VSU8sIDAsIG1tUk9NX0RBVEEpKTsKKworCXJldHVybiB0cnVlOwogfQogCiBz
dGF0aWMgc3RydWN0IHNvYzE1X2FsbG93ZWRfcmVnaXN0ZXJfZW50cnkgbnZfYWxsb3dlZF9yZWFk
X3JlZ2lzdGVyc1tdID0gewotLSAKMi4yMy4wCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZy
ZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3Rp
bmZvL2FtZC1nZng=
