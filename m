Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66747C433F5
	for <amd-gfx@archiver.kernel.org>; Wed,  4 May 2022 22:48:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 02E6D10F000;
	Wed,  4 May 2022 22:48:15 +0000 (UTC)
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com
 [IPv6:2607:f8b0:4864:20::1034])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B3A5C10F000
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 May 2022 22:48:13 +0000 (UTC)
Received: by mail-pj1-x1034.google.com with SMTP id
 a15-20020a17090ad80f00b001dc2e23ad84so6404500pjv.4
 for <amd-gfx@lists.freedesktop.org>; Wed, 04 May 2022 15:48:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:thread-topic:thread-index:date:message-id
 :references:in-reply-to:accept-language:content-language
 :mime-version; bh=esUvIsTLhY/Dd5POIU5qBn5TKNMlX9qq41x1AQpS1S8=;
 b=eTSiXIE4am+jSazwZ+Zv4Pp7pJWNYCS8GRxIB5dXBggVK5MmzX1FRr6Y3OXQ2Iw69q
 F/JFtT7gmgrhsP3EL5nJpNeNhNOq80o7eJQEwgskITM1mvbKeDDhGiX3kTK9F5s2dHTF
 SMTw92VrG1Mp72er6DcYgNPWIpSL3jLZihyS4qs2QoC58HQuMSQC9qHa+l6JFeumxxAg
 hUyD5MCVyA18kvg+r3F5LKAVCs2Ax6UDdeOSBiBQheVRv6u3G60+4W3SG9u2aC/Aa7Es
 0u7LN5LDG6+uI0lEMgZBjVZMK/xPtaDKUKd6gubDGe8M8TWDoFe3aefYSralF/ovfMzw
 opfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:thread-topic:thread-index
 :date:message-id:references:in-reply-to:accept-language
 :content-language:mime-version;
 bh=esUvIsTLhY/Dd5POIU5qBn5TKNMlX9qq41x1AQpS1S8=;
 b=MFUBGh3Wgr+xsJfk2EebOuT7uzJ+9c/HAiSZc7KOhp69KTKXLVkXCZflD7hTNTfxdE
 jEdUWqKetNqREFDqqxRcNtOVrGmWeTbGWa5Bu1nHGe5hg6FhvkJ0gVMieNzddIjd/hJY
 2FcTmqd1TtwCeCrLAGLFd9wuezuHsZOqIeem08F0EKcJKE7JcbBJ1rEIvs18zxTOZEyL
 y4LEOLp2ucjk20CGtn/oqmFVASVlT+WPTcuDK3VpVNIsF6oOpJUpCBlUaIsZzk3ImbPR
 emIYh/OK+EkCwyOfufF8ZOo/wpJ/qTcntNlioKeSrBfDGpbeK+jF0OvYRVSWpj2n344z
 s4kA==
X-Gm-Message-State: AOAM533p6rPJULMT1tHI4+KBw2FULNlmAiGxsv+JhytXrfkjj6Qviqac
 ovuI+FXEzoM4gbPfvjyHXm1kg/10olU=
X-Google-Smtp-Source: ABdhPJyL6subxn225NWvUceI0y4zpB1gQ2YLa8+80Z0JJNfUs/qqHPq/wvRu2g1AVpzxNlVXyBUjCw==
X-Received: by 2002:a17:90b:1d0e:b0:1d2:79e9:21aa with SMTP id
 on14-20020a17090b1d0e00b001d279e921aamr2143762pjb.153.1651704493062; 
 Wed, 04 May 2022 15:48:13 -0700 (PDT)
Received: from SJ0P221MB0691.NAMP221.PROD.OUTLOOK.COM ([52.96.202.205])
 by smtp.gmail.com with ESMTPSA id
 k15-20020a170902ce0f00b0015e8d4eb286sm8876597plg.208.2022.05.04.15.48.12
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 04 May 2022 15:48:12 -0700 (PDT)
From: Haohui Mai <ricetons@gmail.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH v6] drm/amdgpu: Ensure the DMA engine is deactivated
 during set ups
Thread-Topic: [PATCH v6] drm/amdgpu: Ensure the DMA engine is deactivated
 during set ups
Thread-Index: AXNpOTQ0SGd7CFFBVDz4ucQP1MzA68ntn5SC
X-MS-Exchange-MessageSentRepresentingType: 1
Date: Wed, 4 May 2022 22:48:10 +0000
Message-ID: <SJ0P221MB0691348810B9605D928A5286AEC39@SJ0P221MB0691.NAMP221.PROD.OUTLOOK.COM>
References: <20220430073400.2494-1-ricetons@gmail.com>
In-Reply-To: <20220430073400.2494-1-ricetons@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-Exchange-Organization-SCL: -1
X-MS-TNEF-Correlator: 
X-MS-Exchange-Organization-RecordReviewCfmType: 0
Content-Type: multipart/alternative;
 boundary="_000_SJ0P221MB0691348810B9605D928A5286AEC39SJ0P221MB0691NAMP_"
MIME-Version: 1.0
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
Cc: "ckoenig.leichtzumerken@gmail.com" <ckoenig.leichtzumerken@gmail.com>,
 "Hawking.Zhang@amd.com" <Hawking.Zhang@amd.com>,
 "lang.yu@amd.com" <lang.yu@amd.com>,
 "Guchun.Chen@amd.com" <Guchun.Chen@amd.com>,
 "yifan1.zhang@amd.com" <yifan1.zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_SJ0P221MB0691348810B9605D928A5286AEC39SJ0P221MB0691NAMP_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Ping...
________________________________
From: ricetons@gmail.com <ricetons@gmail.com>
Sent: Saturday, April 30, 2022 3:34:00 PM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: lang.yu@amd.com <lang.yu@amd.com>; ckoenig.leichtzumerken@gmail.com <ck=
oenig.leichtzumerken@gmail.com>; Guchun.Chen@amd.com <Guchun.Chen@amd.com>;=
 yifan1.zhang@amd.com <yifan1.zhang@amd.com>; Hawking.Zhang@amd.com <Hawkin=
g.Zhang@amd.com>; Haohui Mai <ricetons@gmail.com>
Subject: [PATCH v6] drm/amdgpu: Ensure the DMA engine is deactivated during=
 set ups

From: Haohui Mai <ricetons@gmail.com>

The patch fully deactivates the DMA engine before setting up the ring
buffer to avoid potential data races and crashes.

Signed-off-by: Haohui Mai <ricetons@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c | 109 +++++++++++++++----------
 1 file changed, 64 insertions(+), 45 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm/amd/a=
mdgpu/sdma_v5_2.c
index 013d2dec81d0..1fac9d8e99de 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
@@ -459,7 +459,6 @@ static void sdma_v5_2_ring_emit_fence(struct amdgpu_rin=
g *ring, u64 addr, u64 se
         }
 }

-
 /**
  * sdma_v5_2_gfx_stop - stop the gfx async dma engines
  *
@@ -505,17 +504,21 @@ static void sdma_v5_2_rlc_stop(struct amdgpu_device *=
adev)
 }

 /**
- * sdma_v5_2_ctx_switch_enable - stop the async dma engines context switch
+ * sdma_v5_2_ctx_switch_enable_for_instance - start the async dma engines
+ * context switch for an instance
  *
  * @adev: amdgpu_device pointer
- * @enable: enable/disable the DMA MEs context switch.
+ * @instance_idx: the index of the SDMA instance
  *
- * Halt or unhalt the async dma engines context switch.
+ * Unhalt the async dma engines context switch.
  */
-static void sdma_v5_2_ctx_switch_enable(struct amdgpu_device *adev, bool e=
nable)
+static void sdma_v5_2_ctx_switch_enable_for_instance(struct amdgpu_device =
*adev, int instance_idx)
 {
         u32 f32_cntl, phase_quantum =3D 0;
-       int i;
+
+       if (WARN_ON(instance_idx >=3D adev->sdma.num_instances)) {
+               return;
+       }

         if (amdgpu_sdma_phase_quantum) {
                 unsigned value =3D amdgpu_sdma_phase_quantum;
@@ -539,50 +542,68 @@ static void sdma_v5_2_ctx_switch_enable(struct amdgpu=
_device *adev, bool enable)
                 phase_quantum =3D
                         value << SDMA0_PHASE0_QUANTUM__VALUE__SHIFT |
                         unit  << SDMA0_PHASE0_QUANTUM__UNIT__SHIFT;
-       }
-
-       for (i =3D 0; i < adev->sdma.num_instances; i++) {
-               if (enable && amdgpu_sdma_phase_quantum) {
-                       WREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, =
i, mmSDMA0_PHASE0_QUANTUM),
-                              phase_quantum);
-                       WREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, =
i, mmSDMA0_PHASE1_QUANTUM),
-                              phase_quantum);
-                       WREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, =
i, mmSDMA0_PHASE2_QUANTUM),
-                              phase_quantum);
-               }

-               if (!amdgpu_sriov_vf(adev)) {
-                       f32_cntl =3D RREG32(sdma_v5_2_get_reg_offset(adev, =
i, mmSDMA0_CNTL));
-                       f32_cntl =3D REG_SET_FIELD(f32_cntl, SDMA0_CNTL,
-                                       AUTO_CTXSW_ENABLE, enable ? 1 : 0);
-                       WREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_CN=
TL), f32_cntl);
-               }
+               WREG32_SOC15_IP(GC,
+                       sdma_v5_2_get_reg_offset(adev, instance_idx, mmSDMA=
0_PHASE0_QUANTUM),
+                       phase_quantum);
+               WREG32_SOC15_IP(GC,
+                       sdma_v5_2_get_reg_offset(adev, instance_idx, mmSDMA=
0_PHASE1_QUANTUM),
+                   phase_quantum);
+               WREG32_SOC15_IP(GC,
+                       sdma_v5_2_get_reg_offset(adev, instance_idx, mmSDMA=
0_PHASE2_QUANTUM),
+                   phase_quantum);
         }

+       if (!amdgpu_sriov_vf(adev)) {
+               f32_cntl =3D RREG32(sdma_v5_2_get_reg_offset(adev, instance=
_idx, mmSDMA0_CNTL));
+               f32_cntl =3D REG_SET_FIELD(f32_cntl, SDMA0_CNTL,
+                               AUTO_CTXSW_ENABLE, 1);
+               WREG32(sdma_v5_2_get_reg_offset(adev, instance_idx, mmSDMA0=
_CNTL), f32_cntl);
+       }
 }

 /**
- * sdma_v5_2_enable - stop the async dma engines
+ * sdma_v5_2_ctx_switch_disable_all - stop the async dma engines context s=
witch
  *
  * @adev: amdgpu_device pointer
- * @enable: enable/disable the DMA MEs.
  *
- * Halt or unhalt the async dma engines.
+ * Halt the async dma engines context switch.
  */
-static void sdma_v5_2_enable(struct amdgpu_device *adev, bool enable)
+static void sdma_v5_2_ctx_switch_disable_all(struct amdgpu_device *adev)
 {
         u32 f32_cntl;
         int i;

-       if (!enable) {
-               sdma_v5_2_gfx_stop(adev);
-               sdma_v5_2_rlc_stop(adev);
+       if (amdgpu_sriov_vf(adev))
+               return;
+
+       for (i =3D 0; i < adev->sdma.num_instances; i++) {
+               f32_cntl =3D RREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDM=
A0_CNTL));
+               f32_cntl =3D REG_SET_FIELD(f32_cntl, SDMA0_CNTL,
+                               AUTO_CTXSW_ENABLE, 0);
+               WREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_CNTL), f32=
_cntl);
         }
+}
+
+/**
+ * sdma_v5_2_halt - stop the async dma engines
+ *
+ * @adev: amdgpu_device pointer
+ *
+ * Halt the async dma engines.
+ */
+static void sdma_v5_2_halt(struct amdgpu_device *adev)
+{
+       int i;
+       u32 f32_cntl;
+
+       sdma_v5_2_gfx_stop(adev);
+       sdma_v5_2_rlc_stop(adev);

         if (!amdgpu_sriov_vf(adev)) {
                 for (i =3D 0; i < adev->sdma.num_instances; i++) {
                         f32_cntl =3D RREG32(sdma_v5_2_get_reg_offset(adev,=
 i, mmSDMA0_F32_CNTL));
-                       f32_cntl =3D REG_SET_FIELD(f32_cntl, SDMA0_F32_CNTL=
, HALT, enable ? 0 : 1);
+                       f32_cntl =3D REG_SET_FIELD(f32_cntl, SDMA0_F32_CNTL=
, HALT, 1);
                         WREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_F=
32_CNTL), f32_cntl);
                 }
         }
@@ -594,6 +615,9 @@ static void sdma_v5_2_enable(struct amdgpu_device *adev=
, bool enable)
  * @adev: amdgpu_device pointer
  *
  * Set up the gfx DMA ring buffers and enable them.
+ * It assumes that the dma engine is stopped for each instance.
+ * The function enables the engine and preemptions sequentially for each i=
nstance.
+ *
  * Returns 0 for success, error for failure.
  */
 static int sdma_v5_2_gfx_resume(struct amdgpu_device *adev)
@@ -737,10 +761,7 @@ static int sdma_v5_2_gfx_resume(struct amdgpu_device *=
adev)

                 ring->sched.ready =3D true;

-               if (amdgpu_sriov_vf(adev)) { /* bare-metal sequence doesn't=
 need below to lines */
-                       sdma_v5_2_ctx_switch_enable(adev, true);
-                       sdma_v5_2_enable(adev, true);
-               }
+               sdma_v5_2_ctx_switch_enable_for_instance(adev, i);

                 r =3D amdgpu_ring_test_ring(ring);
                 if (r) {
@@ -784,7 +805,7 @@ static int sdma_v5_2_load_microcode(struct amdgpu_devic=
e *adev)
         int i, j;

         /* halt the MEs */
-       sdma_v5_2_enable(adev, false);
+       sdma_v5_2_halt(adev);

         for (i =3D 0; i < adev->sdma.num_instances; i++) {
                 if (!adev->sdma.instance[i].fw)
@@ -856,8 +877,8 @@ static int sdma_v5_2_start(struct amdgpu_device *adev)
         int r =3D 0;

         if (amdgpu_sriov_vf(adev)) {
-               sdma_v5_2_ctx_switch_enable(adev, false);
-               sdma_v5_2_enable(adev, false);
+               sdma_v5_2_ctx_switch_disable_all(adev);
+               sdma_v5_2_halt(adev);

                 /* set RB registers */
                 r =3D sdma_v5_2_gfx_resume(adev);
@@ -881,12 +902,10 @@ static int sdma_v5_2_start(struct amdgpu_device *adev=
)
                 amdgpu_gfx_off_ctrl(adev, false);

         sdma_v5_2_soft_reset(adev);
-       /* unhalt the MEs */
-       sdma_v5_2_enable(adev, true);
-       /* enable sdma ring preemption */
-       sdma_v5_2_ctx_switch_enable(adev, true);

-       /* start the gfx rings and rlc compute queues */
+       /* Soft reset supposes to disable the dma engine and preemption.
+        * Now start the gfx rings and rlc compute queues.
+        */
         r =3D sdma_v5_2_gfx_resume(adev);
         if (adev->in_s0ix)
                 amdgpu_gfx_off_ctrl(adev, true);
@@ -1340,8 +1359,8 @@ static int sdma_v5_2_hw_fini(void *handle)
         if (amdgpu_sriov_vf(adev))
                 return 0;

-       sdma_v5_2_ctx_switch_enable(adev, false);
-       sdma_v5_2_enable(adev, false);
+       sdma_v5_2_ctx_switch_disable_all(adev);
+       sdma_v5_2_halt(adev);

         return 0;
 }
--
2.25.1


--_000_SJ0P221MB0691348810B9605D928A5286AEC39SJ0P221MB0691NAMP_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
</head>
<body>
<div>
<div>
<div style=3D"color: rgb(0, 0, 0); background-color: rgb(255, 255, 255);" d=
ir=3D"ltr">
Ping&#8230;</div>
</div>
<div id=3D"ms-outlook-mobile-signature">
<div></div>
</div>
</div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> ricetons@gmail.com &l=
t;ricetons@gmail.com&gt;<br>
<b>Sent:</b> Saturday, April 30, 2022 3:34:00 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> lang.yu@amd.com &lt;lang.yu@amd.com&gt;; ckoenig.leichtzumerken@=
gmail.com &lt;ckoenig.leichtzumerken@gmail.com&gt;; Guchun.Chen@amd.com &lt=
;Guchun.Chen@amd.com&gt;; yifan1.zhang@amd.com &lt;yifan1.zhang@amd.com&gt;=
; Hawking.Zhang@amd.com &lt;Hawking.Zhang@amd.com&gt;; Haohui
 Mai &lt;ricetons@gmail.com&gt;<br>
<b>Subject:</b> [PATCH v6] drm/amdgpu: Ensure the DMA engine is deactivated=
 during set ups</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">From: Haohui Mai &lt;ricetons@gmail.com&gt;<br>
<br>
The patch fully deactivates the DMA engine before setting up the ring<br>
buffer to avoid potential data races and crashes.<br>
<br>
Signed-off-by: Haohui Mai &lt;ricetons@gmail.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c | 109 +++++++++++++++---------=
-<br>
&nbsp;1 file changed, 64 insertions(+), 45 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm/amd/a=
mdgpu/sdma_v5_2.c<br>
index 013d2dec81d0..1fac9d8e99de 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c<br>
@@ -459,7 +459,6 @@ static void sdma_v5_2_ring_emit_fence(struct amdgpu_rin=
g *ring, u64 addr, u64 se<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;}<br>
&nbsp;<br>
-<br>
&nbsp;/**<br>
&nbsp; * sdma_v5_2_gfx_stop - stop the gfx async dma engines<br>
&nbsp; *<br>
@@ -505,17 +504,21 @@ static void sdma_v5_2_rlc_stop(struct amdgpu_device *=
adev)<br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;/**<br>
- * sdma_v5_2_ctx_switch_enable - stop the async dma engines context switch=
<br>
+ * sdma_v5_2_ctx_switch_enable_for_instance - start the async dma engines<=
br>
+ * context switch for an instance<br>
&nbsp; *<br>
&nbsp; * @adev: amdgpu_device pointer<br>
- * @enable: enable/disable the DMA MEs context switch.<br>
+ * @instance_idx: the index of the SDMA instance<br>
&nbsp; *<br>
- * Halt or unhalt the async dma engines context switch.<br>
+ * Unhalt the async dma engines context switch.<br>
&nbsp; */<br>
-static void sdma_v5_2_ctx_switch_enable(struct amdgpu_device *adev, bool e=
nable)<br>
+static void sdma_v5_2_ctx_switch_enable_for_instance(struct amdgpu_device =
*adev, int instance_idx)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 f32_cntl, phase_quantu=
m =3D 0;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int i;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (WARN_ON(instance_idx &gt;=3D adev=
-&gt;sdma.num_instances)) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_sdma_phase_quan=
tum) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; unsigned value =3D amdgpu_sdma_phase_quantum;<br>
@@ -539,50 +542,68 @@ static void sdma_v5_2_ctx_switch_enable(struct amdgpu=
_device *adev, bool enable)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; phase_quantum =3D<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; value=
 &lt;&lt; SDMA0_PHASE0_QUANTUM__VALUE__SHIFT |<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unit&=
nbsp; &lt;&lt; SDMA0_PHASE0_QUANTUM__UNIT__SHIFT;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; adev-&gt;sdma.nu=
m_instances; i++) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (enable &amp;&amp; amdgpu_sdma_phase_quantum) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15_IP(=
GC, sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_PHASE0_QUANTUM),<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; phase_quantum);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15_IP(=
GC, sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_PHASE1_QUANTUM),<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; phase_quantum);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15_IP(=
GC, sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_PHASE2_QUANTUM),<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; phase_quantum);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; }<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (!amdgpu_sriov_vf(adev)) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; f32_cntl =3D RRE=
G32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_CNTL));<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; f32_cntl =3D REG=
_SET_FIELD(f32_cntl, SDMA0_CNTL,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; AUTO_CTXSW_ENABLE, enable ? 1 : 0);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32(sdma_v5_2=
_get_reg_offset(adev, i, mmSDMA0_CNTL), f32_cntl);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; }<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; WREG32_SOC15_IP(GC,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sdma_v5_2_get_re=
g_offset(adev, instance_idx, mmSDMA0_PHASE0_QUANTUM),<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; phase_quantum);<=
br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; WREG32_SOC15_IP(GC,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sdma_v5_2_get_re=
g_offset(adev, instance_idx, mmSDMA0_PHASE1_QUANTUM),<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; phase_quantum);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; WREG32_SOC15_IP(GC,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sdma_v5_2_get_re=
g_offset(adev, instance_idx, mmSDMA0_PHASE2_QUANTUM),<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; phase_quantum);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!amdgpu_sriov_vf(adev)) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; f32_cntl =3D RREG32(sdma_v5_2_get_reg_offset(adev, instance_idx,=
 mmSDMA0_CNTL));<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; f32_cntl =3D REG_SET_FIELD(f32_cntl, SDMA0_CNTL,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AUTO_CTXSW_ENABLE, 1);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; WREG32(sdma_v5_2_get_reg_offset(adev, instance_idx, mmSDMA0_CNTL=
), f32_cntl);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;/**<br>
- * sdma_v5_2_enable - stop the async dma engines<br>
+ * sdma_v5_2_ctx_switch_disable_all - stop the async dma engines context s=
witch<br>
&nbsp; *<br>
&nbsp; * @adev: amdgpu_device pointer<br>
- * @enable: enable/disable the DMA MEs.<br>
&nbsp; *<br>
- * Halt or unhalt the async dma engines.<br>
+ * Halt the async dma engines context switch.<br>
&nbsp; */<br>
-static void sdma_v5_2_enable(struct amdgpu_device *adev, bool enable)<br>
+static void sdma_v5_2_ctx_switch_disable_all(struct amdgpu_device *adev)<b=
r>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 f32_cntl;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int i;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!enable) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; sdma_v5_2_gfx_stop(adev);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; sdma_v5_2_rlc_stop(adev);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_sriov_vf(adev))<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; adev-&gt;sdma.nu=
m_instances; i++) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; f32_cntl =3D RREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_CN=
TL));<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; f32_cntl =3D REG_SET_FIELD(f32_cntl, SDMA0_CNTL,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AUTO_CTXSW_ENABLE, 0);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; WREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_CNTL), f32_cntl=
);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+}<br>
+<br>
+/**<br>
+ * sdma_v5_2_halt - stop the async dma engines<br>
+ *<br>
+ * @adev: amdgpu_device pointer<br>
+ *<br>
+ * Halt the async dma engines.<br>
+ */<br>
+static void sdma_v5_2_halt(struct amdgpu_device *adev)<br>
+{<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int i;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 f32_cntl;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sdma_v5_2_gfx_stop(adev);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sdma_v5_2_rlc_stop(adev);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!amdgpu_sriov_vf(adev)=
) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; adev-&gt;sdma.num_instances; i++=
) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; f32_c=
ntl =3D RREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_F32_CNTL));<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; f32_cntl =3D REG=
_SET_FIELD(f32_cntl, SDMA0_F32_CNTL, HALT, enable ? 0 : 1);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; f32_cntl =3D REG=
_SET_FIELD(f32_cntl, SDMA0_F32_CNTL, HALT, 1);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG3=
2(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_F32_CNTL), f32_cntl);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
@@ -594,6 +615,9 @@ static void sdma_v5_2_enable(struct amdgpu_device *adev=
, bool enable)<br>
&nbsp; * @adev: amdgpu_device pointer<br>
&nbsp; *<br>
&nbsp; * Set up the gfx DMA ring buffers and enable them.<br>
+ * It assumes that the dma engine is stopped for each instance.<br>
+ * The function enables the engine and preemptions sequentially for each i=
nstance.<br>
+ *<br>
&nbsp; * Returns 0 for success, error for failure.<br>
&nbsp; */<br>
&nbsp;static int sdma_v5_2_gfx_resume(struct amdgpu_device *adev)<br>
@@ -737,10 +761,7 @@ static int sdma_v5_2_gfx_resume(struct amdgpu_device *=
adev)<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; ring-&gt;sched.ready =3D true;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (amdgpu_sriov_vf(adev)) { /* bare-metal sequence doesn't need=
 below to lines */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sdma_v5_2_ctx_sw=
itch_enable(adev, true);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sdma_v5_2_enable=
(adev, true);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; }<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; sdma_v5_2_ctx_switch_enable_for_instance(adev, i);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_ring_test_ring(ring);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (r) {<br>
@@ -784,7 +805,7 @@ static int sdma_v5_2_load_microcode(struct amdgpu_devic=
e *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int i, j;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* halt the MEs */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sdma_v5_2_enable(adev, false);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sdma_v5_2_halt(adev);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; adev-=
&gt;sdma.num_instances; i++) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (!adev-&gt;sdma.instance[i].fw)<br>
@@ -856,8 +877,8 @@ static int sdma_v5_2_start(struct amdgpu_device *adev)<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int r =3D 0;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_sriov_vf(adev))=
 {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; sdma_v5_2_ctx_switch_enable(adev, false);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; sdma_v5_2_enable(adev, false);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; sdma_v5_2_ctx_switch_disable_all(adev);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; sdma_v5_2_halt(adev);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; /* set RB registers */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; r =3D sdma_v5_2_gfx_resume(adev);<br>
@@ -881,12 +902,10 @@ static int sdma_v5_2_start(struct amdgpu_device *adev=
)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; amdgpu_gfx_off_ctrl(adev, false);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sdma_v5_2_soft_reset(adev)=
;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* unhalt the MEs */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sdma_v5_2_enable(adev, true);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* enable sdma ring preemption */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sdma_v5_2_ctx_switch_enable(adev, tru=
e);<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* start the gfx rings and rlc comput=
e queues */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Soft reset supposes to disable the=
 dma engine and preemption.<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * Now start the gfx rings and r=
lc compute queues.<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D sdma_v5_2_gfx_resume=
(adev);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;in_s0ix)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; amdgpu_gfx_off_ctrl(adev, true);<br>
@@ -1340,8 +1359,8 @@ static int sdma_v5_2_hw_fini(void *handle)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_sriov_vf(adev))=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sdma_v5_2_ctx_switch_enable(adev, fal=
se);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sdma_v5_2_enable(adev, false);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sdma_v5_2_ctx_switch_disable_all(adev=
);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sdma_v5_2_halt(adev);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;}<br>
-- <br>
2.25.1<br>
<br>
</div>
</span></font></div>
</body>
</html>

--_000_SJ0P221MB0691348810B9605D928A5286AEC39SJ0P221MB0691NAMP_--
