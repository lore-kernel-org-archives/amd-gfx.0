Return-Path: <SRS0=5//3=ZA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 179E6FA372C
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Nov 2019 16:06:58 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E55CF2084D
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Nov 2019 16:06:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E55CF2084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9825C6F9E9;
	Fri,  8 Nov 2019 16:06:57 +0000 (UTC)
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C7D456F9B6;
 Fri,  8 Nov 2019 14:38:18 +0000 (UTC)
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
 by youngberry.canonical.com with esmtpsa
 (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.86_2)
 (envelope-from <colin.king@canonical.com>)
 id 1iT5Ox-0007Dp-1i; Fri, 08 Nov 2019 14:38:15 +0000
From: Colin King <colin.king@canonical.com>
To: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 David Zhou <David1.Zhou@amd.com>, David Airlie <airlied@linux.ie>,
 Daniel Vetter <daniel@ffwll.ch>, Lyude Paul <lyude@redhat.com>,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
 Mikita Lipski <mikita.lipski@amd.com>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Subject: [PATCH][next] drm/amd/display: fix dereference of pointer aconnector
 when it is null
Date: Fri,  8 Nov 2019 14:38:14 +0000
Message-Id: <20191108143814.118856-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-Mailman-Approved-At: Fri, 08 Nov 2019 16:06:56 +0000
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
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191108143814.Vc2xz2wrsKbYM_FAQCxPKcqA8EB9mecbxPDZ0RoAisw@z>

RnJvbTogQ29saW4gSWFuIEtpbmcgPGNvbGluLmtpbmdAY2Fub25pY2FsLmNvbT4KCkN1cnJlbnRs
eSBwb2ludGVyIGFjb25uZWN0b3IgaXMgYmVpbmcgZGVyZWZlcmVuY2VkIGJ5IHRoZSBjYWxsIHRv
CnRvX2RtX2Nvbm5lY3Rvcl9zdGF0ZSBiZWZvcmUgaXQgaXMgYmVpbmcgbnVsbCBjaGVja2VkLCB0
aGlzIGNvdWxkCmxlYWQgdG8gYSBudWxsIHBvaW50ZXIgZGVyZWZlcmVuY2UuICBGaXggdGhpcyBi
eSBjaGVja2luZyB0aGF0CmFjb25uZWN0b3IgaXMgbnVsbCBiZWZvcmUgZGVyZWZlcmVuY2luZyBp
dC4KCkFkZHJlc3Nlcy1Db3Zlcml0eTogKCJEZXJlZmVyZW5jZSBiZWZvcmUgbnVsbCBjaGVjayIp
CkZpeGVzOiA1MTMzYzYyNDFkOWMgKCJkcm0vYW1kL2Rpc3BsYXk6IEFkZCBNU1QgYXRvbWljIHJv
dXRpbmVzIikKU2lnbmVkLW9mZi1ieTogQ29saW4gSWFuIEtpbmcgPGNvbGluLmtpbmdAY2Fub25p
Y2FsLmNvbT4KLS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvYW1kZ3B1X2RtL2FtZGdw
dV9kbV9oZWxwZXJzLmMgfCA1ICsrLS0tCiAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCsp
LCAzIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxh
eS9hbWRncHVfZG0vYW1kZ3B1X2RtX2hlbHBlcnMuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlz
cGxheS9hbWRncHVfZG0vYW1kZ3B1X2RtX2hlbHBlcnMuYwppbmRleCBlM2NkYTY5ODRkMjguLjcy
ZTY3Nzc5NmE0OCAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2FtZGdw
dV9kbS9hbWRncHVfZG1faGVscGVycy5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxh
eS9hbWRncHVfZG0vYW1kZ3B1X2RtX2hlbHBlcnMuYwpAQCAtMTkzLDEyICsxOTMsMTEgQEAgYm9v
bCBkbV9oZWxwZXJzX2RwX21zdF93cml0ZV9wYXlsb2FkX2FsbG9jYXRpb25fdGFibGUoCiAJICog
dGhhdCBibG9ja3MgYmVmb3JlIGNvbW1pdCBndWFyYW50ZWVpbmcgdGhhdCB0aGUgc3RhdGUKIAkg
KiBpcyBub3QgZ29ubmEgYmUgc3dhcHBlZCB3aGlsZSBzdGlsbCBpbiB1c2UgaW4gY29tbWl0IHRh
aWwgKi8KIAotCWRtX2Nvbm5fc3RhdGUgPSB0b19kbV9jb25uZWN0b3Jfc3RhdGUoYWNvbm5lY3Rv
ci0+YmFzZS5zdGF0ZSk7Ci0KLQogCWlmICghYWNvbm5lY3RvciB8fCAhYWNvbm5lY3Rvci0+bXN0
X3BvcnQpCiAJCXJldHVybiBmYWxzZTsKIAorCWRtX2Nvbm5fc3RhdGUgPSB0b19kbV9jb25uZWN0
b3Jfc3RhdGUoYWNvbm5lY3Rvci0+YmFzZS5zdGF0ZSk7CisKIAltc3RfbWdyID0gJmFjb25uZWN0
b3ItPm1zdF9wb3J0LT5tc3RfbWdyOwogCiAJaWYgKCFtc3RfbWdyLT5tc3Rfc3RhdGUpCi0tIAoy
LjIwLjEKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFt
ZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8v
bGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeA==
