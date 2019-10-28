Return-Path: <SRS0=qril=YV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 096ECCA9EC0
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Oct 2019 12:47:38 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DCCD3204FD
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Oct 2019 12:47:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCCD3204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8F5F06E84F;
	Mon, 28 Oct 2019 12:47:36 +0000 (UTC)
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 23F866E566;
 Mon, 28 Oct 2019 10:38:53 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 28 Oct 2019 03:38:52 -0700
X-IronPort-AV: E=Sophos;i="5.68,239,1569308400"; d="scan'208";a="374195680"
Received: from jnikula-mobl3.fi.intel.com (HELO localhost) ([10.237.66.161])
 by orsmga005-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 28 Oct 2019 03:38:49 -0700
From: Jani Nikula <jani.nikula@intel.com>
To: dri-devel@lists.freedesktop.org
Subject: [PATCH RESEND 3/8] drm/amdgpu: use drm_debug_enabled() to check for
 debug categories
Date: Mon, 28 Oct 2019 12:38:17 +0200
Message-Id:
 <e30ddbd627be1fe1c67dd007e0d36f81a094bc91.1572258936.git.jani.nikula@intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1572258935.git.jani.nikula@intel.com>
References: <cover.1572258935.git.jani.nikula@intel.com>
MIME-Version: 1.0
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Mailman-Approved-At: Mon, 28 Oct 2019 12:47:35 +0000
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
Cc: David Zhou <David1.Zhou@amd.com>, jani.nikula@intel.com,
 intel-gfx@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191028103817.hNalv4eidEdEVmsdFoI1zg4bKJ0zBu81jS18NxqDt9Q@z>

QWxsb3cgYmV0dGVyIGFic3RyYWN0aW9uIG9mIHRoZSBkcm1fZGVidWcgZ2xvYmFsIHZhcmlhYmxl
IGluIHRoZQpmdXR1cmUuIE5vIGZ1bmN0aW9uYWwgY2hhbmdlcy4KCkNjOiBBbGV4IERldWNoZXIg
PGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+CkNjOiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJpc3Rp
YW4ua29lbmlnQGFtZC5jb20+CkNjOiBEYXZpZCAoQ2h1bk1pbmcpIFpob3UgPERhdmlkMS5aaG91
QGFtZC5jb20+CkNjOiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpBY2tlZC1ieTogQWxl
eCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPgpTaWduZWQtb2ZmLWJ5OiBKYW5p
IE5pa3VsYSA8amFuaS5uaWt1bGFAaW50ZWwuY29tPgotLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L3NtdV92MTFfMF9pMmMuYyB8IDQgKystLQogMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0
aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9zbXVfdjExXzBfaTJjLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9zbXVf
djExXzBfaTJjLmMKaW5kZXggYzQ0NzIzYzI2N2M5Li5jOTAyZjI2Y2Y1MGQgMTAwNjQ0Ci0tLSBh
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3NtdV92MTFfMF9pMmMuYworKysgYi9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9zbXVfdjExXzBfaTJjLmMKQEAgLTIzNCw3ICsyMzQsNyBAQCBz
dGF0aWMgdWludDMyX3Qgc211X3YxMV8wX2kyY190cmFuc21pdChzdHJ1Y3QgaTJjX2FkYXB0ZXIg
KmNvbnRyb2wsCiAJRFJNX0RFQlVHX0RSSVZFUigiSTJDX1RyYW5zbWl0KCksIGFkZHJlc3MgPSAl
eCwgYnl0ZXMgPSAlZCAsIGRhdGE6ICIsCiAJCSAodWludDE2X3QpYWRkcmVzcywgbnVtYnl0ZXMp
OwogCi0JaWYgKGRybV9kZWJ1ZyAmIERSTV9VVF9EUklWRVIpIHsKKwlpZiAoZHJtX2RlYnVnX2Vu
YWJsZWQoRFJNX1VUX0RSSVZFUikpIHsKIAkJcHJpbnRfaGV4X2R1bXAoS0VSTl9JTkZPLCAiZGF0
YTogIiwgRFVNUF9QUkVGSVhfTk9ORSwKIAkJCSAgICAgICAxNiwgMSwgZGF0YSwgbnVtYnl0ZXMs
IGZhbHNlKTsKIAl9CkBAIC0zODgsNyArMzg4LDcgQEAgc3RhdGljIHVpbnQzMl90IHNtdV92MTFf
MF9pMmNfcmVjZWl2ZShzdHJ1Y3QgaTJjX2FkYXB0ZXIgKmNvbnRyb2wsCiAJRFJNX0RFQlVHX0RS
SVZFUigiSTJDX1JlY2VpdmUoKSwgYWRkcmVzcyA9ICV4LCBieXRlcyA9ICVkLCBkYXRhIDoiLAog
CQkgICh1aW50MTZfdClhZGRyZXNzLCBieXRlc19yZWNlaXZlZCk7CiAKLQlpZiAoZHJtX2RlYnVn
ICYgRFJNX1VUX0RSSVZFUikgeworCWlmIChkcm1fZGVidWdfZW5hYmxlZChEUk1fVVRfRFJJVkVS
KSkgewogCQlwcmludF9oZXhfZHVtcChLRVJOX0lORk8sICJkYXRhOiAiLCBEVU1QX1BSRUZJWF9O
T05FLAogCQkJICAgICAgIDE2LCAxLCBkYXRhLCBieXRlc19yZWNlaXZlZCwgZmFsc2UpOwogCX0K
LS0gCjIuMjAuMQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0
cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
