Return-Path: <SRS0=kYY7=ZN=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F318AC432C0
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Nov 2019 14:02:37 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D45A820721
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Nov 2019 14:02:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D45A820721
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A4D6B6F372;
	Thu, 21 Nov 2019 14:02:32 +0000 (UTC)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9A69D6EF44;
 Thu, 21 Nov 2019 14:02:30 +0000 (UTC)
Received: from localhost (173-25-83-245.client.mchsi.com [173.25.83.245])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 2918C2070B;
 Thu, 21 Nov 2019 14:02:30 +0000 (UTC)
From: Bjorn Helgaas <helgaas@kernel.org>
To: linux-pci@vger.kernel.org
Subject: [PATCH 1/7] PCI: Add #defines for Enter Compliance, Transmit Margin
Date: Thu, 21 Nov 2019 08:02:14 -0600
Message-Id: <20191121140220.38030-2-helgaas@kernel.org>
X-Mailer: git-send-email 2.24.0.432.g9d3f5f5b63-goog
In-Reply-To: <20191121140220.38030-1-helgaas@kernel.org>
References: <20191121140220.38030-1-helgaas@kernel.org>
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=default; t=1574344950;
 bh=QNl5ddLlEQtj52j/MrXKdvbk9C/ac81zzKOpevreAlo=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=nE13WhF9osewZpyc5VcK5pgYoegxUhErGHh15hrUmRqty2dv5MIKf3XhGCXZpSwOh
 +t4Q9oucbnTf26CkDgDDNN4O4wIC8nyLa2x8f1nix4T6sySG/W6pcJn0Hnt5ZyHgQL
 TI++KCuYgfo2TIGe+nr66fTwAHyswUv7QeM8WNuo=
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
Cc: Chunming Zhou <David1.Zhou@amd.com>, Frederick Lawler <fred@fredlawl.com>,
 Dave Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, Bjorn Helgaas <bhelgaas@google.com>,
 amd-gfx@lists.freedesktop.org, Daniel Vetter <daniel@ffwll.ch>,
 Alex Deucher <alexdeucher@gmail.com>, Alex Deucher <alexander.deucher@amd.com>,
 Christian Koenig <christian.koenig@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191121140214.TXtjiTUw3apo3mG-Ksgd16UeyRxvNMa2Yyk84ITzOCA@z>

RnJvbTogQmpvcm4gSGVsZ2FhcyA8YmhlbGdhYXNAZ29vZ2xlLmNvbT4KCkFkZCBkZWZpbml0aW9u
cyBmb3IgdGhlIEVudGVyIENvbXBsaWFuY2UgYW5kIFRyYW5zbWl0IE1hcmdpbiBmaWVsZHMgb2Yg
dGhlClBDSWUgTGluayBDb250cm9sIDIgcmVnaXN0ZXIuCgpMaW5rOiBodHRwczovL2xvcmUua2Vy
bmVsLm9yZy9yLzIwMTkxMTEyMTczNTAzLjE3NjYxMS0yLWhlbGdhYXNAa2VybmVsLm9yZwpTaWdu
ZWQtb2ZmLWJ5OiBCam9ybiBIZWxnYWFzIDxiaGVsZ2Fhc0Bnb29nbGUuY29tPgpSZXZpZXdlZC1i
eTogQWxleCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPgotLS0KIGluY2x1ZGUv
dWFwaS9saW51eC9wY2lfcmVncy5oIHwgMiArKwogMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9u
cygrKQoKZGlmZiAtLWdpdCBhL2luY2x1ZGUvdWFwaS9saW51eC9wY2lfcmVncy5oIGIvaW5jbHVk
ZS91YXBpL2xpbnV4L3BjaV9yZWdzLmgKaW5kZXggMjlkNmU5M2ZkMTVlLi41ODY5ZTU3NzhhMDUg
MTAwNjQ0Ci0tLSBhL2luY2x1ZGUvdWFwaS9saW51eC9wY2lfcmVncy5oCisrKyBiL2luY2x1ZGUv
dWFwaS9saW51eC9wY2lfcmVncy5oCkBAIC02NzMsNiArNjczLDggQEAKICNkZWZpbmUgIFBDSV9F
WFBfTE5LQ1RMMl9UTFNfOF8wR1QJMHgwMDAzIC8qIFN1cHBvcnRlZCBTcGVlZCA4R1QvcyAqLwog
I2RlZmluZSAgUENJX0VYUF9MTktDVEwyX1RMU18xNl8wR1QJMHgwMDA0IC8qIFN1cHBvcnRlZCBT
cGVlZCAxNkdUL3MgKi8KICNkZWZpbmUgIFBDSV9FWFBfTE5LQ1RMMl9UTFNfMzJfMEdUCTB4MDAw
NSAvKiBTdXBwb3J0ZWQgU3BlZWQgMzJHVC9zICovCisjZGVmaW5lICBQQ0lfRVhQX0xOS0NUTDJf
RU5URVJfQ09NUAkweDAwMTAgLyogRW50ZXIgQ29tcGxpYW5jZSAqLworI2RlZmluZSAgUENJX0VY
UF9MTktDVEwyX1RYX01BUkdJTgkweDAzODAgLyogVHJhbnNtaXQgTWFyZ2luICovCiAjZGVmaW5l
IFBDSV9FWFBfTE5LU1RBMgkJNTAJLyogTGluayBTdGF0dXMgMiAqLwogI2RlZmluZSBQQ0lfQ0FQ
X0VYUF9FTkRQT0lOVF9TSVpFT0ZfVjIJNTIJLyogdjIgZW5kcG9pbnRzIHdpdGggbGluayBlbmQg
aGVyZSAqLwogI2RlZmluZSBQQ0lfRVhQX1NMVENBUDIJCTUyCS8qIFNsb3QgQ2FwYWJpbGl0aWVz
IDIgKi8KLS0gCjIuMjQuMC40MzIuZzlkM2Y1ZjViNjMtZ29vZwoKX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdm
eEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFp
bG1hbi9saXN0aW5mby9hbWQtZ2Z4
