Return-Path: <SRS0=kYY7=ZN=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43D2FC432C0
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Nov 2019 14:02:53 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2112D20679
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Nov 2019 14:02:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2112D20679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 951C86F381;
	Thu, 21 Nov 2019 14:02:45 +0000 (UTC)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 30BCC6F376;
 Thu, 21 Nov 2019 14:02:36 +0000 (UTC)
Received: from localhost (173-25-83-245.client.mchsi.com [173.25.83.245])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id C6A5720714;
 Thu, 21 Nov 2019 14:02:35 +0000 (UTC)
From: Bjorn Helgaas <helgaas@kernel.org>
To: linux-pci@vger.kernel.org
Subject: [PATCH 5/7] drm/radeon: Correct Transmit Margin masks
Date: Thu, 21 Nov 2019 08:02:18 -0600
Message-Id: <20191121140220.38030-6-helgaas@kernel.org>
X-Mailer: git-send-email 2.24.0.432.g9d3f5f5b63-goog
In-Reply-To: <20191121140220.38030-1-helgaas@kernel.org>
References: <20191121140220.38030-1-helgaas@kernel.org>
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=default; t=1574344956;
 bh=iI6P6FLhSZffxNAomh8eN45Lk4VFuntsL83fGjuXh+U=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=RKO3DxKO3jUUQU2GSnSiihCTC12JxFdcHvrSy8GhnixGFgHxJjDcZxOOKa3I4qHB0
 lJoj0WGHo91ieE1jKTfEL2PXPipg7YzAGSv+23DLAyoNueC1/c+OBUsjexx58ezPgV
 7bi8VmzkHVq7KMWmhFJeuqD/srdjbfdsKm7u5vbU=
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
Message-ID: <20191121140218.w_kXppNkhwBHEC9wxb6gdf9FD1mKH8csMnxFXtcbnI8@z>

RnJvbTogQmpvcm4gSGVsZ2FhcyA8YmhlbGdhYXNAZ29vZ2xlLmNvbT4KClByZXZpb3VzbHkgd2Ug
bWFza2VkIFBDSWUgTGluayBDb250cm9sIDIgcmVnaXN0ZXIgdmFsdWVzIHdpdGggIjcgPDwgOSIs
CndoaWNoIHdhcyBhcHBhcmVudGx5IGludGVuZGVkIHRvIGJlIHRoZSBUcmFuc21pdCBNYXJnaW4g
ZmllbGQsIGJ1dCBpbnN0ZWFkCndhcyB0aGUgaGlnaCBvcmRlciBiaXQgb2YgVHJhbnNtaXQgTWFy
Z2luLCB0aGUgRW50ZXIgTW9kaWZpZWQgQ29tcGxpYW5jZQpiaXQsIGFuZCB0aGUgQ29tcGxpYW5j
ZSBTT1MgYml0LgoKQ29ycmVjdCB0aGUgbWFzayB0byAiNyA8PCA3Iiwgd2hpY2ggaXMgdGhlIFRy
YW5zbWl0IE1hcmdpbiBmaWVsZC4KCkxpbms6IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3IvMjAx
OTExMTIxNzM1MDMuMTc2NjExLTMtaGVsZ2Fhc0BrZXJuZWwub3JnClNpZ25lZC1vZmYtYnk6IEJq
b3JuIEhlbGdhYXMgPGJoZWxnYWFzQGdvb2dsZS5jb20+ClJldmlld2VkLWJ5OiBBbGV4IERldWNo
ZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+Ci0tLQogZHJpdmVycy9ncHUvZHJtL3JhZGVv
bi9jaWsuYyB8IDggKysrKy0tLS0KIGRyaXZlcnMvZ3B1L2RybS9yYWRlb24vc2kuYyAgfCA4ICsr
KystLS0tCiAyIGZpbGVzIGNoYW5nZWQsIDggaW5zZXJ0aW9ucygrKSwgOCBkZWxldGlvbnMoLSkK
CmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vcmFkZW9uL2Npay5jIGIvZHJpdmVycy9ncHUv
ZHJtL3JhZGVvbi9jaWsuYwppbmRleCA2MmVhYjgyYTY0ZjkuLjE0Y2RmZGY3OGJkZSAxMDA2NDQK
LS0tIGEvZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9jaWsuYworKysgYi9kcml2ZXJzL2dwdS9kcm0v
cmFkZW9uL2Npay5jCkBAIC05NjE5LDEzICs5NjE5LDEzIEBAIHN0YXRpYyB2b2lkIGNpa19wY2ll
X2dlbjNfZW5hYmxlKHN0cnVjdCByYWRlb25fZGV2aWNlICpyZGV2KQogCiAJCQkJLyogbGlua2N0
bDIgKi8KIAkJCQlwY2lfcmVhZF9jb25maWdfd29yZChyb290LCBicmlkZ2VfcG9zICsgUENJX0VY
UF9MTktDVEwyLCAmdG1wMTYpOwotCQkJCXRtcDE2ICY9IH4oKDEgPDwgNCkgfCAoNyA8PCA5KSk7
Ci0JCQkJdG1wMTYgfD0gKGJyaWRnZV9jZmcyICYgKCgxIDw8IDQpIHwgKDcgPDwgOSkpKTsKKwkJ
CQl0bXAxNiAmPSB+KCgxIDw8IDQpIHwgKDcgPDwgNykpOworCQkJCXRtcDE2IHw9IChicmlkZ2Vf
Y2ZnMiAmICgoMSA8PCA0KSB8ICg3IDw8IDcpKSk7CiAJCQkJcGNpX3dyaXRlX2NvbmZpZ193b3Jk
KHJvb3QsIGJyaWRnZV9wb3MgKyBQQ0lfRVhQX0xOS0NUTDIsIHRtcDE2KTsKIAogCQkJCXBjaV9y
ZWFkX2NvbmZpZ193b3JkKHJkZXYtPnBkZXYsIGdwdV9wb3MgKyBQQ0lfRVhQX0xOS0NUTDIsICZ0
bXAxNik7Ci0JCQkJdG1wMTYgJj0gfigoMSA8PCA0KSB8ICg3IDw8IDkpKTsKLQkJCQl0bXAxNiB8
PSAoZ3B1X2NmZzIgJiAoKDEgPDwgNCkgfCAoNyA8PCA5KSkpOworCQkJCXRtcDE2ICY9IH4oKDEg
PDwgNCkgfCAoNyA8PCA3KSk7CisJCQkJdG1wMTYgfD0gKGdwdV9jZmcyICYgKCgxIDw8IDQpIHwg
KDcgPDwgNykpKTsKIAkJCQlwY2lfd3JpdGVfY29uZmlnX3dvcmQocmRldi0+cGRldiwgZ3B1X3Bv
cyArIFBDSV9FWFBfTE5LQ1RMMiwgdG1wMTYpOwogCiAJCQkJdG1wID0gUlJFRzMyX1BDSUVfUE9S
VChQQ0lFX0xDX0NOVEw0KTsKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9yYWRlb24vc2ku
YyBiL2RyaXZlcnMvZ3B1L2RybS9yYWRlb24vc2kuYwppbmRleCAwNTg5NGQxOThhNzkuLjliNzA0
MmQzZWYxYiAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9zaS5jCisrKyBiL2Ry
aXZlcnMvZ3B1L2RybS9yYWRlb24vc2kuYwpAQCAtNzIwMiwxMyArNzIwMiwxMyBAQCBzdGF0aWMg
dm9pZCBzaV9wY2llX2dlbjNfZW5hYmxlKHN0cnVjdCByYWRlb25fZGV2aWNlICpyZGV2KQogCiAJ
CQkJLyogbGlua2N0bDIgKi8KIAkJCQlwY2lfcmVhZF9jb25maWdfd29yZChyb290LCBicmlkZ2Vf
cG9zICsgUENJX0VYUF9MTktDVEwyLCAmdG1wMTYpOwotCQkJCXRtcDE2ICY9IH4oKDEgPDwgNCkg
fCAoNyA8PCA5KSk7Ci0JCQkJdG1wMTYgfD0gKGJyaWRnZV9jZmcyICYgKCgxIDw8IDQpIHwgKDcg
PDwgOSkpKTsKKwkJCQl0bXAxNiAmPSB+KCgxIDw8IDQpIHwgKDcgPDwgNykpOworCQkJCXRtcDE2
IHw9IChicmlkZ2VfY2ZnMiAmICgoMSA8PCA0KSB8ICg3IDw8IDcpKSk7CiAJCQkJcGNpX3dyaXRl
X2NvbmZpZ193b3JkKHJvb3QsIGJyaWRnZV9wb3MgKyBQQ0lfRVhQX0xOS0NUTDIsIHRtcDE2KTsK
IAogCQkJCXBjaV9yZWFkX2NvbmZpZ193b3JkKHJkZXYtPnBkZXYsIGdwdV9wb3MgKyBQQ0lfRVhQ
X0xOS0NUTDIsICZ0bXAxNik7Ci0JCQkJdG1wMTYgJj0gfigoMSA8PCA0KSB8ICg3IDw8IDkpKTsK
LQkJCQl0bXAxNiB8PSAoZ3B1X2NmZzIgJiAoKDEgPDwgNCkgfCAoNyA8PCA5KSkpOworCQkJCXRt
cDE2ICY9IH4oKDEgPDwgNCkgfCAoNyA8PCA3KSk7CisJCQkJdG1wMTYgfD0gKGdwdV9jZmcyICYg
KCgxIDw8IDQpIHwgKDcgPDwgNykpKTsKIAkJCQlwY2lfd3JpdGVfY29uZmlnX3dvcmQocmRldi0+
cGRldiwgZ3B1X3BvcyArIFBDSV9FWFBfTE5LQ1RMMiwgdG1wMTYpOwogCiAJCQkJdG1wID0gUlJF
RzMyX1BDSUVfUE9SVChQQ0lFX0xDX0NOVEw0KTsKLS0gCjIuMjQuMC40MzIuZzlkM2Y1ZjViNjMt
Z29vZwoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1k
LWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9s
aXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
