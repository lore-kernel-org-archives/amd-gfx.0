Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E7E4109B474
	for <amd-gfx@archiver.kernel.org>; Tue, 31 Mar 2026 14:21:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BB54010E961;
	Tue, 31 Mar 2026 14:21:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="GXlp1Kd0";
	dkim-atps=neutral
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com
 [209.85.167.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 320B010E961
 for <amd-gfx@lists.freedesktop.org>; Tue, 31 Mar 2026 14:21:34 +0000 (UTC)
Received: by mail-lf1-f52.google.com with SMTP id
 2adb3069b0e04-5a2b542cbaaso2630246e87.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 31 Mar 2026 07:21:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774966892; x=1775571692; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=1oYcPcx8F3d6g2/KOSoArMOX0Oh8a20uUVdo2G1rSio=;
 b=GXlp1Kd0Sm9f1m/VgIRHyqcva4hnKPuIhrzVZXoqwiRtaAVvMOCNmHetEc9MFnFoeS
 4tTuKor9IfsDp3h28yaFkoSZcre80cXrNVIHbDrsr67Kt9DoDqwWv8Qclc/6ap0bo1jT
 U5aV84t7FdDONbjaJuml0FxDpyvpUBALnEbNRwlDVCGtgC3lS89vCkhErApOzGRdqCj0
 NZaxEdKcfIaqYB1UkxUls2bkaNsYsWxupjhAUFJE9VobGj2GNGWWxG/cqCi5eXT3RyBC
 wCUKGEUAOGVXfQtyo0WtOA4przFt2gnVQLXglIUBmSUwBtZtHAfmyOz5Vyla0ERha9bk
 PfEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774966892; x=1775571692;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1oYcPcx8F3d6g2/KOSoArMOX0Oh8a20uUVdo2G1rSio=;
 b=eogDhxBLSiJtbTqjlOMiIPcvK/I0wxWOl6JsyttzTtnBgBhQy3un36M3zwVzBU+xfi
 IHAikgupOSP1acKTNUDPVP1BhH3PCk8QRRsdCleHGQEQoDOUfhY9vqotbT95wKLG9xcc
 afhjec0IIv2Ff6VWss9RD8JJEcULTpo/XKvszA7lI5dQKlbDfH9PQcafv14jroQbE6r4
 sLsjVLJocsrftaHgbeU+1Aqikzywu9Cp41CJOSDz3hm+U4m+INtONhN98HRug+eJlu34
 14s8+Sf7sjHalNUsESb8/cxdkUdoGiborQCF9JesKL70sx8XhCQJtLCDnFQb9z4NPLrq
 DPFA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV1DhufB85PIklgU8z/IN2CLSFu5uKO9K6PAGbrn7DeDnK3lD4ThcYqM3mVx8sCycQC1ICy457c@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz8C6YDjGvAf2HAykoxyG5Rhx6YCdzXUSsExaEqs6dawZ+Lkp3b
 SMygcKaA4LAK+v3cN9l3gpZ5Y888+PlVu6uNyj3nsbTBnnorBIqGnMIm
X-Gm-Gg: ATEYQzxD/EFjbgkXB+f/kZC4i4veY/8+xxSU95CCusGCQDjMmGNSRqLLUNF106emuu4
 uDXnXKyy0R5Iw+MiJBCglZbOdF0k+ERqaWcpYy8umVuLH1I79NDHP5rGOkmUawrh1L8eQR9fcR4
 yNFl7X94KnpJBcwXnIIGq9GlY7OKtTC/nRoDT0VSvcBlqAJhASXE7K2XaSDQv3w/QG62Ng80bVW
 JsB1S9LVUhFuSJj3jF44qVyMR+kWv6t04vFN2xxcSpvho7hkbKN/pSjiM/tDwzDZCECzI7jgQa/
 Jucof8yHTqnJfrSSbecSp1d1K0kI0+/SFHLKG/AEG9sRLAmqzfmyQyUPN+ue5prvhH/KpBfy+jQ
 MKprYLD/NbRKeZaZq8gZnFdXmXK8l1/fTudm+CY+PlNkWw0F4KtVnDKMm4i4LTUedwkAm2GMAHl
 XH7TShIAYYgoxxskkZALkxZY8KyrZ9gQuaIQ==
X-Received: by 2002:a05:6512:3ca8:b0:5a2:bc8d:272 with SMTP id
 2adb3069b0e04-5a2bc8d0336mr1017775e87.0.1774966891920; 
 Tue, 31 Mar 2026 07:21:31 -0700 (PDT)
Received: from localhost ([188.234.148.119]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a2b1444a1dsm2422837e87.54.2026.03.31.07.21.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 31 Mar 2026 07:21:31 -0700 (PDT)
From: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Cc: lijo.lazar@amd.com, Eric Huang <jinhuieric.huang@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Subject: [PATCH v7] drm/amdgpu: replace PASID IDR with XArray
Date: Tue, 31 Mar 2026 19:21:26 +0500
Message-ID: <20260331142127.52796-1-mikhail.v.gavrilov@gmail.com>
X-Mailer: git-send-email 2.53.0
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Replace the PASID IDR + spinlock with XArray as noted in the TODO
left by commit dccd79bb1c7f ("drm/amdgpu: fix the idr allocation
flags").

The IDR conversion still has an IRQ safety issue:
amdgpu_pasid_free() can be called from hardirq context via the fence
signal path, but amdgpu_pasid_idr_lock is taken with plain spin_lock()
in process context, creating a potential deadlock:

     CPU0
     ----
     spin_lock(&amdgpu_pasid_idr_lock)   // process context, IRQs on
     <Interrupt>
       spin_lock(&amdgpu_pasid_idr_lock) // deadlock

   The hardirq call chain is:

     sdma_v6_0_process_trap_irq
      -> amdgpu_fence_process
       -> dma_fence_signal
        -> drm_sched_job_done
         -> dma_fence_signal
          -> amdgpu_pasid_free_cb
           -> amdgpu_pasid_free

Use XArray with XA_FLAGS_LOCK_IRQ (all xa operations use IRQ-safe
locking internally) and XA_FLAGS_ALLOC1 (zero is not a valid PASID).
Both xa_alloc_cyclic() and xa_erase() then handle locking
consistently, fixing the IRQ safety issue and removing the need for
an explicit spinlock.

Suggested-by: Lijo Lazar <lijo.lazar@amd.com>
Fixes: e6d765de3d6b ("drm/amdgpu: prevent immediate PASID reuse case")
Signed-off-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
---

v7: Rebased on amd-staging-drm-next which already includes
    dccd79bb1c7f ("drm/amdgpu: fix the idr allocation flags").
    Updated commit message to reflect that sleeping-under-spinlock
    is already fixed and the xarray conversion now addresses the
    remaining IRQ safety issue.  Inverted error check to
    if (r < 0) return r; per Christian König.
v6: Use DEFINE_XARRAY_FLAGS with XA_FLAGS_LOCK_IRQ | XA_FLAGS_ALLOC1
    so all xa operations use IRQ-safe locking internally.  Drop
    Cc: stable since the regression was never released to any stable
    kernel. (Christian König)
    https://lore.kernel.org/all/20260331111733.118553-1-mikhail.v.gavrilov@gmail.com/
v5: Use explicit xa_lock_irqsave/__xa_erase for amdgpu_pasid_free()
    since xa_erase() only uses plain xa_lock() which is not safe from
    hardirq context.
    https://lore.kernel.org/all/20260330191120.105065-1-mikhail.v.gavrilov@gmail.com/
v4: Use xa_alloc_cyclic/xa_erase directly instead of explicit
    xa_lock_irqsave, as suggested by Lijo Lazar.
    https://lore.kernel.org/all/20260330162038.25073-1-mikhail.v.gavrilov@gmail.com/
v3: Replace IDR with XArray instead of fixing the spinlock, as
    suggested by Lijo Lazar.
    https://lore.kernel.org/all/20260330110346.16548-1-mikhail.v.gavrilov@gmail.com/
v2: Added second patch fixing the {HARDIRQ-ON-W} -> {IN-HARDIRQ-W}
    lock inconsistency (spin_lock -> spin_lock_irqsave).
    https://lore.kernel.org/all/20260330053025.19203-1-mikhail.v.gavrilov@gmail.com/
v1: Fixed sleeping-under-spinlock (idr_alloc_cyclic with GFP_KERNEL)
    using idr_preload/GFP_NOWAIT.
    https://lore.kernel.org/all/20260328213900.19255-1-mikhail.v.gavrilov@gmail.com/

 drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c | 34 ++++++++++---------------
 1 file changed, 13 insertions(+), 21 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
index e495a8fa13fd..a6ac3b4ce0df 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
@@ -22,7 +22,7 @@
  */
 #include "amdgpu_ids.h"
 
-#include <linux/idr.h>
+#include <linux/xarray.h>
 #include <linux/dma-fence-array.h>
 
 
@@ -40,8 +40,8 @@
  * VMs are looked up from the PASID per amdgpu_device.
  */
 
-static DEFINE_IDR(amdgpu_pasid_idr);
-static DEFINE_SPINLOCK(amdgpu_pasid_idr_lock);
+static DEFINE_XARRAY_FLAGS(amdgpu_pasid_xa, XA_FLAGS_LOCK_IRQ | XA_FLAGS_ALLOC1);
+static u32 amdgpu_pasid_xa_next;
 
 /* Helper to free pasid from a fence callback */
 struct amdgpu_pasid_cb {
@@ -62,22 +62,19 @@ struct amdgpu_pasid_cb {
  */
 int amdgpu_pasid_alloc(unsigned int bits)
 {
-	int pasid;
+	u32 pasid;
+	int r;
 
 	if (bits == 0)
 		return -EINVAL;
 
-	spin_lock(&amdgpu_pasid_idr_lock);
-	/* TODO: Need to replace the idr with an xarry, and then
-	 * handle the internal locking with ATOMIC safe paths.
-	 */
-	pasid = idr_alloc_cyclic(&amdgpu_pasid_idr, NULL, 1,
-				 1U << bits, GFP_ATOMIC);
-	spin_unlock(&amdgpu_pasid_idr_lock);
-
-	if (pasid >= 0)
-		trace_amdgpu_pasid_allocated(pasid);
+	r = xa_alloc_cyclic(&amdgpu_pasid_xa, &pasid, xa_mk_value(0),
+			    XA_LIMIT(1, (1U << bits) - 1),
+			    &amdgpu_pasid_xa_next, GFP_KERNEL);
+	if (r < 0)
+		return r;
 
+	trace_amdgpu_pasid_allocated(pasid);
 	return pasid;
 }
 
@@ -88,10 +85,7 @@ int amdgpu_pasid_alloc(unsigned int bits)
 void amdgpu_pasid_free(u32 pasid)
 {
 	trace_amdgpu_pasid_freed(pasid);
-
-	spin_lock(&amdgpu_pasid_idr_lock);
-	idr_remove(&amdgpu_pasid_idr, pasid);
-	spin_unlock(&amdgpu_pasid_idr_lock);
+	xa_erase(&amdgpu_pasid_xa, pasid);
 }
 
 static void amdgpu_pasid_free_cb(struct dma_fence *fence,
@@ -634,7 +628,5 @@ void amdgpu_vmid_mgr_fini(struct amdgpu_device *adev)
  */
 void amdgpu_pasid_mgr_cleanup(void)
 {
-	spin_lock(&amdgpu_pasid_idr_lock);
-	idr_destroy(&amdgpu_pasid_idr);
-	spin_unlock(&amdgpu_pasid_idr_lock);
+	xa_destroy(&amdgpu_pasid_xa);
 }
-- 
2.53.0

