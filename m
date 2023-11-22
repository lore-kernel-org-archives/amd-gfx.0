Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 151AEC61D9B
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Nov 2023 16:21:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 63D9010E68D;
	Wed, 22 Nov 2023 16:20:54 +0000 (UTC)
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CA6DE10E68E;
 Wed, 22 Nov 2023 16:20:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=LgiP6k4b25j6JdOl1t3vzbWpalkz+TaPG+lRilXJhV0=; b=QUMPjg4YQvQo+GWFK/4494HEuy
 rDbyp+KIU3owVzNlGUlll01Ecxk0G5hSpLUk1kYdO5RVPKm9qYBlnXSrnFJGx695NoaHrAG842lFe
 5UyEqnz66VZR4ydlO49u3LFEtJcAbsLs7DS26s7fFoQavfPZkt8lEFzzjpiwYM0MnCU2QmzdprWZA
 ImjWX+UpkODk0aIWKOONuZ7SrGKK3p7CT2cNfkl3k4JcUg0BCBSheK67BExi7+rLI0/nZBYbq2pd7
 CobE7liFqYjf7kfeVOPgGSJYWs25ygFn0Li48MqB3lL25Hb8SwWMT5g+nUt16DzaqafSSnKTxh09R
 kybx9Bcg==;
Received: from 189-69-166-209.dial-up.telesp.net.br ([189.69.166.209]
 helo=steammachine.lan) by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1r5py3-0061lT-FC; Wed, 22 Nov 2023 17:20:47 +0100
From: =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>
To: dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH v9 4/4] drm/doc: Define KMS atomic state set
Date: Wed, 22 Nov 2023 13:19:41 -0300
Message-ID: <20231122161941.320564-5-andrealmeid@igalia.com>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231122161941.320564-1-andrealmeid@igalia.com>
References: <20231122161941.320564-1-andrealmeid@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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
Cc: pierre-eric.pelloux-prayer@amd.com,
 Pekka Paalanen <pekka.paalanen@collabora.com>, daniel@ffwll.ch,
 =?UTF-8?q?=27Marek=20Ol=C5=A1=C3=A1k=27?= <maraeo@gmail.com>,
 =?UTF-8?q?Michel=20D=C3=A4nzer?= <michel.daenzer@mailbox.org>,
 Simon Ser <contact@emersion.fr>, intel-gfx@lists.freedesktop.org,
 Randy Dunlap <rdunlap@infradead.org>, Pekka Paalanen <ppaalanen@gmail.com>,
 Daniel Stone <daniel@fooishbar.org>, Rob Clark <robdclark@gmail.com>,
 kernel-dev@igalia.com, alexander.deucher@amd.com,
 =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>,
 Dave Airlie <airlied@gmail.com>, christian.koenig@amd.com,
 ville.syrjala@linux.intel.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Pekka Paalanen <pekka.paalanen@collabora.com>

Specify how the atomic state is maintained between userspace and
kernel, plus the special case for async flips.

Signed-off-by: Pekka Paalanen <pekka.paalanen@collabora.com>
Signed-off-by: André Almeida <andrealmeid@igalia.com>
---
v9:
- no changes
v8:
- no changes
v7:
- add a note that drivers can make exceptions for ad-hoc prop changes
- add a note about flipping the same FB_ID as a no-op
---
---
 Documentation/gpu/drm-uapi.rst | 47 ++++++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/Documentation/gpu/drm-uapi.rst b/Documentation/gpu/drm-uapi.rst
index 370d820be248..d0693f902a5c 100644
--- a/Documentation/gpu/drm-uapi.rst
+++ b/Documentation/gpu/drm-uapi.rst
@@ -570,3 +570,50 @@ dma-buf interoperability
 
 Please see Documentation/userspace-api/dma-buf-alloc-exchange.rst for
 information on how dma-buf is integrated and exposed within DRM.
+
+KMS atomic state
+================
+
+An atomic commit can change multiple KMS properties in an atomic fashion,
+without ever applying intermediate or partial state changes.  Either the whole
+commit succeeds or fails, and it will never be applied partially. This is the
+fundamental improvement of the atomic API over the older non-atomic API which is
+referred to as the "legacy API".  Applying intermediate state could unexpectedly
+fail, cause visible glitches, or delay reaching the final state.
+
+An atomic commit can be flagged with DRM_MODE_ATOMIC_TEST_ONLY, which means the
+complete state change is validated but not applied.  Userspace should use this
+flag to validate any state change before asking to apply it. If validation fails
+for any reason, userspace should attempt to fall back to another, perhaps
+simpler, final state.  This allows userspace to probe for various configurations
+without causing visible glitches on screen and without the need to undo a
+probing change.
+
+The changes recorded in an atomic commit apply on top the current KMS state in
+the kernel. Hence, the complete new KMS state is the complete old KMS state with
+the committed property settings done on top. The kernel will try to avoid
+no-operation changes, so it is safe for userspace to send redundant property
+settings.  However, not every situation allows for no-op changes, due to the
+need to acquire locks for some attributes. Userspace needs to be aware that some
+redundant information might result in oversynchronization issues.  No-operation
+changes do not count towards actually needed changes, e.g.  setting MODE_ID to a
+different blob with identical contents as the current KMS state shall not be a
+modeset on its own. As a special exception for VRR needs, explicitly setting
+FB_ID to its current value is not a no-op.
+
+A "modeset" is a change in KMS state that might enable, disable, or temporarily
+disrupt the emitted video signal, possibly causing visible glitches on screen. A
+modeset may also take considerably more time to complete than other kinds of
+changes, and the video sink might also need time to adapt to the new signal
+properties. Therefore a modeset must be explicitly allowed with the flag
+DRM_MODE_ATOMIC_ALLOW_MODESET.  This in combination with
+DRM_MODE_ATOMIC_TEST_ONLY allows userspace to determine if a state change is
+likely to cause visible disruption on screen and avoid such changes when end
+users do not expect them.
+
+An atomic commit with the flag DRM_MODE_PAGE_FLIP_ASYNC is allowed to
+effectively change only the FB_ID property on any planes. No-operation changes
+are ignored as always. Changing any other property will cause the commit to be
+rejected. Each driver may relax this restriction if they have guarantees that
+such property change doesn't cause modesets. Userspace can use TEST_ONLY commits
+to query the driver about this.
-- 
2.42.1

