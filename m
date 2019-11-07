Return-Path: <SRS0=ouc1=Y7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01863C43331
	for <amd-gfx@archiver.kernel.org>; Thu,  7 Nov 2019 20:18:33 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CFFC02166E
	for <amd-gfx@archiver.kernel.org>; Thu,  7 Nov 2019 20:18:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFFC02166E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6900E6F795;
	Thu,  7 Nov 2019 20:18:32 +0000 (UTC)
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com
 [IPv6:2607:f8b0:4864:20::842])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 296BC6F791
 for <amd-gfx@lists.freedesktop.org>; Thu,  7 Nov 2019 20:18:31 +0000 (UTC)
Received: by mail-qt1-x842.google.com with SMTP id c25so3182370qtq.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 07 Nov 2019 12:18:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=HXlUhJXkbBuWjWsTdVLI811TcXsfoCG9Xj1j7e6Rqa8=;
 b=aNXI2gRhIoMCflkQPvMqzTTOfR6vKjmfd5T1ifHmJg/EB2DHo6AT2DsMhDE2lpzRKs
 lPbubDQfqCUT6l3J/3vpFP5wDMTH2lsllq7S1avurRkFRJ6bffHOXPrQK6ZcpsDoPM8c
 Ze4Qatg3U1amttzFQFDztgm2CgiS0IYfOoVAl5N3Y0nJfnQ6hvQbVLzitR/i/8JvNlgo
 4o6lM7IQuoWOxaXGAgA+LjTaLIHGiu2WCTBVVO+37jwn+3b4BbOuzAq+WfniDcy6Jrt7
 HfoCqPVUi4bK3jFMCYN9ZqA+jvsVGjc+B+FGnQGGCoRk9yU1jsSNCw+Cr2PwV/oZ94jJ
 yDrw==
X-Gm-Message-State: APjAAAUn99tTLZevo8SrX84cnQ6U3OJw2W0/jwhSp9nVe1rGWTPSqghV
 /5EXkNALHKvgCDdmd2VNCdDKSbzc
X-Google-Smtp-Source: APXvYqx8NWTDXh3wgToOiX00V7FcqNGt0xH6AE18gKCATqDSnHsomXv+Q+WLK5c11WCgkATL/W9K6Q==
X-Received: by 2002:aed:2ec6:: with SMTP id k64mr6182334qtd.61.1573157909835; 
 Thu, 07 Nov 2019 12:18:29 -0800 (PST)
Received: from localhost.localdomain ([71.219.59.120])
 by smtp.gmail.com with ESMTPSA id a4sm1647676qko.57.2019.11.07.12.18.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Nov 2019 12:18:29 -0800 (PST)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu/powerplay: fix AVFS handling with custom powerplay
 table
Date: Thu,  7 Nov 2019 15:18:21 -0500
Message-Id: <20191107201821.1252472-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=HXlUhJXkbBuWjWsTdVLI811TcXsfoCG9Xj1j7e6Rqa8=;
 b=rt5kaOoxLwyi+2tJ5aRnbohTitJHp0s1ew/TlSuh4KDJRgDAgLLmJaXfusHbDhf6Hv
 Ykl3qSikKxEaDc4L06WWia71y3+7Xq5Fj54S/888NZi+OHKEYr+L0ucJNB0pnolyagch
 4cACe7y9uRF1qtk4KWlC6kE0Zq9ZTl5L02TS9734jCoAuudvGsedjk8M8EVeJCFSCbDm
 ZwUT4dkcprX/9nrdeWkcE+sH/pIblo2IpidhYufxI2itzYsvzXhd/VlNOMLYR18Y1w5Z
 x2NY1Yqki7bb5q94oGXHl8/sjp9Dq1d+C/ugEP0+3zY9lMkBAymxb/bqq/SdQs3DW8K1
 snQw==
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
Message-ID: <20191107201821.oXpOcJDMAQxgeQf1Vr5r5HsQY9U5qsDpSa1dDkmeU3Y@z>

V2hlbiBhIGN1c3RvbSBwb3dlcnBsYXkgdGFibGUgaXMgcHJvdmlkZWQsIHdlIG5lZWQgdG8gdXBk
YXRlCnRoZSBPRCBWRERDIGZsYWcgdG8gYXZvaWQgQVZGUyBiZWluZyBlbmFibGVkIHdoZW4gaXQg
c2hvdWxkbid0IGJlLgoKQnVnOiBodHRwczovL2J1Z3ppbGxhLmtlcm5lbC5vcmcvc2hvd19idWcu
Y2dpP2lkPTIwNTM5MwpTaWduZWQtb2ZmLWJ5OiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVj
aGVyQGFtZC5jb20+Ci0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkvaHdtZ3IvdmVn
YTEwX2h3bWdyLmMgfCA3ICsrKysrKysKIDEgZmlsZSBjaGFuZ2VkLCA3IGluc2VydGlvbnMoKykK
CmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS9od21nci92ZWdhMTBf
aHdtZ3IuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L2h3bWdyL3ZlZ2ExMF9od21n
ci5jCmluZGV4IDRlYTYzYTJlMTdkYS4uYTRhN2Y4NTM0OTY2IDEwMDY0NAotLS0gYS9kcml2ZXJz
L2dwdS9kcm0vYW1kL3Bvd2VycGxheS9od21nci92ZWdhMTBfaHdtZ3IuYworKysgYi9kcml2ZXJz
L2dwdS9kcm0vYW1kL3Bvd2VycGxheS9od21nci92ZWdhMTBfaHdtZ3IuYwpAQCAtMzY4OSw2ICsz
Njg5LDEzIEBAIHN0YXRpYyBpbnQgdmVnYTEwX3NldF9wb3dlcl9zdGF0ZV90YXNrcyhzdHJ1Y3Qg
cHBfaHdtZ3IgKmh3bWdyLAogCVBQX0FTU0VSVF9XSVRIX0NPREUoIXJlc3VsdCwKIAkJCSJGYWls
ZWQgdG8gdXBsb2FkIFBQdGFibGUhIiwgcmV0dXJuIHJlc3VsdCk7CiAKKwkvKgorCSAqIElmIGEg
Y3VzdG9tIHBwIHRhYmxlIGlzIGxvYWRlZCwgc2V0IERQTVRBQkxFX09EX1VQREFURV9WRERDIGZs
YWcuCisJICogVGhhdCBlZmZlY3RpdmVseSBkaXNhYmxlcyBBVkZTIGZlYXR1cmUuCisJICovCisJ
aWYoaHdtZ3ItPmhhcmRjb2RlX3BwX3RhYmxlICE9IE5VTEwpCisJCWRhdGEtPm5lZWRfdXBkYXRl
X2RwbV90YWJsZSB8PSBEUE1UQUJMRV9PRF9VUERBVEVfVkREQzsKKwogCXZlZ2ExMF91cGRhdGVf
YXZmcyhod21ncik7CiAKIAkvKgotLSAKMi4yMy4wCgpfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3Rz
LmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xp
c3RpbmZvL2FtZC1nZng=
