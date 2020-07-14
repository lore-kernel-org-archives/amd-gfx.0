Return-Path: <SRS0=Dt/2=AZ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A4DBC43445
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jul 2020 18:24:41 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 03370223C6
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jul 2020 18:24:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WSdaLTui"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03370223C6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C2E846E852;
	Tue, 14 Jul 2020 18:24:40 +0000 (UTC)
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com
 [IPv6:2607:f8b0:4864:20::844])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0D0756E84A
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Jul 2020 18:24:40 +0000 (UTC)
Received: by mail-qt1-x844.google.com with SMTP id g13so13573504qtv.8
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Jul 2020 11:24:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=h2c5t/5PDU+tMKMKCW70cfR7Hk122tsZk8cAkz8we1g=;
 b=WSdaLTuibZ6dlUTuZqUPVpi9NE68saUfZFgMMbTunl28PD4K0DEwUzUPpXnrQniaay
 oaf2r2pi0AbpNaB5sLwDfJfjMqjzglHDPIKjU9jBz2v/M0I3a6G5jES6D7eD3NMRV9ml
 20lpt66kK30OMD91bc+s6TeJGzNR3zz/B6gkUgOJ/DEzFHTvTDitAWLr3RwJmqyZ4n8N
 l12btGIB4FEix2IiS1xYqTo3LgYKCjHdRSRI0LPu1Tf9aPI8NHCwCPNWVFMDfvThBiJS
 J+fxoRo07VuaBJYK7k3mUZ+YBD8db59JfcSRemXSOkxC0FYRugGpSop8JRiYh+JYoM+p
 tmXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=h2c5t/5PDU+tMKMKCW70cfR7Hk122tsZk8cAkz8we1g=;
 b=eLYAOS732kDSq0AtYvitaSTiTGPfk1o3UApMIvaJtr1jECMF8lFzO8SdH8apLedI0G
 baxTjnX69fDCyuQ5KHqZA0mQ3xiDulBiKrR8zOfU62lBsS/7hNeqSqPXbC3qOyJUmr5j
 Zx9hIZRq3kE25qmw3hsHizPr2dJacQKk0KhPb3c+9RjGWGjwgqhfwOM+8uJhIBA+beZ5
 FYyt3DrQ7jd01NYmdmMMoN+8nGiOjmAEU4SOdDtiHnQlcq1qzrwSGTdQ3srZS42pEe17
 PrdGY2Y6hhZRDCRGDoBHZ6JYbRQ/kpY4r0YEcjbqdG3B71z8nJ5pUmii7MGUIt1LfgpI
 HoAg==
X-Gm-Message-State: AOAM532ryyQ30fuXDWgss1auPA1V0dmtq8rTHJbue0I/rFDVyOPxcopx
 k40z2x8f4R00nDp7uRcCKDiXattK
X-Google-Smtp-Source: ABdhPJzwuR5ZmCzor6ttM9SIgShlJ0+Krf3hv3K+9ozzlWDCqhfaUL1wOoaZZHXTpgfDOD9ZQl/cNQ==
X-Received: by 2002:ac8:4c85:: with SMTP id j5mr6364572qtv.219.1594751078959; 
 Tue, 14 Jul 2020 11:24:38 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id d53sm26046456qtc.47.2020.07.14.11.24.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jul 2020 11:24:38 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 23/42] drm/amdgpu: add psp support for navy_flounder
Date: Tue, 14 Jul 2020 14:23:34 -0400
Message-Id: <20200714182353.2164930-24-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200714182353.2164930-1-alexander.deucher@amd.com>
References: <20200714182353.2164930-1-alexander.deucher@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Tao Zhou <tao.zhou1@amd.com>,
 Jiansong Chen <Jiansong.Chen@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Jiansong Chen <Jiansong.Chen@amd.com>

Currently skip ASD FW loading and ih reroute per
sienna_cichlid.

Signed-off-by: Jiansong Chen <Jiansong.Chen@amd.com>
Reviewed-by: Tao Zhou <tao.zhou1@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c |  8 ++++++--
 drivers/gpu/drm/amd/amdgpu/psp_v11_0.c  | 12 ++++++++++--
 2 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 40706334f7a8..aab5ffc03a6b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -99,6 +99,7 @@ static int psp_early_init(void *handle)
 	case CHIP_NAVI14:
 	case CHIP_NAVI12:
 	case CHIP_SIENNA_CICHLID:
+	case CHIP_NAVY_FLOUNDER:
 		psp_v11_0_set_psp_funcs(psp);
 		psp->autoload_supported = true;
 		break;
@@ -498,7 +499,9 @@ static int psp_asd_load(struct psp_context *psp)
 	 * add workaround to bypass it for sriov now.
 	 * TODO: add version check to make it common
 	 */
-	if (amdgpu_sriov_vf(psp->adev) || (psp->adev->asic_type == CHIP_SIENNA_CICHLID))
+	if (amdgpu_sriov_vf(psp->adev) ||
+	    (psp->adev->asic_type == CHIP_SIENNA_CICHLID) ||
+	    (psp->adev->asic_type == CHIP_NAVY_FLOUNDER))
 		return 0;
 
 	cmd = kzalloc(sizeof(struct psp_gfx_cmd_resp), GFP_KERNEL);
@@ -1763,7 +1766,8 @@ static int psp_np_fw_load(struct psp_context *psp)
 			continue;
 
 		if (psp->autoload_supported &&
-		    adev->asic_type == CHIP_SIENNA_CICHLID &&
+		    (adev->asic_type == CHIP_SIENNA_CICHLID ||
+		     adev->asic_type == CHIP_NAVY_FLOUNDER) &&
 		    (ucode->ucode_id == AMDGPU_UCODE_ID_SDMA1 ||
 		     ucode->ucode_id == AMDGPU_UCODE_ID_SDMA2 ||
 		     ucode->ucode_id == AMDGPU_UCODE_ID_SDMA3))
diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c b/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
index 423386272920..77f99811cd85 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
@@ -57,6 +57,8 @@ MODULE_FIRMWARE("amdgpu/arcturus_asd.bin");
 MODULE_FIRMWARE("amdgpu/arcturus_ta.bin");
 MODULE_FIRMWARE("amdgpu/sienna_cichlid_sos.bin");
 MODULE_FIRMWARE("amdgpu/sienna_cichlid_asd.bin");
+MODULE_FIRMWARE("amdgpu/navy_flounder_sos.bin");
+MODULE_FIRMWARE("amdgpu/navy_flounder_asd.bin");
 
 /* address block */
 #define smnMP1_FIRMWARE_FLAGS		0x3010024
@@ -100,6 +102,9 @@ static int psp_v11_0_init_microcode(struct psp_context *psp)
 	case CHIP_SIENNA_CICHLID:
 		chip_name = "sienna_cichlid";
 		break;
+	case CHIP_NAVY_FLOUNDER:
+		chip_name = "navy_flounder";
+		break;
 	default:
 		BUG();
 	}
@@ -108,7 +113,8 @@ static int psp_v11_0_init_microcode(struct psp_context *psp)
 	if (err)
 		return err;
 
-	if (adev->asic_type != CHIP_SIENNA_CICHLID) {
+	if (adev->asic_type != CHIP_SIENNA_CICHLID &&
+	    adev->asic_type != CHIP_NAVY_FLOUNDER) {
 		err = psp_init_asd_microcode(psp, chip_name);
 		if (err)
 			return err;
@@ -173,6 +179,7 @@ static int psp_v11_0_init_microcode(struct psp_context *psp)
 		}
 		break;
 	case CHIP_SIENNA_CICHLID:
+	case CHIP_NAVY_FLOUNDER:
 		break;
 	default:
 		BUG();
@@ -397,7 +404,8 @@ static int psp_v11_0_ring_init(struct psp_context *psp,
 	struct amdgpu_device *adev = psp->adev;
 
 	if ((!amdgpu_sriov_vf(adev)) &&
-	    (adev->asic_type != CHIP_SIENNA_CICHLID))
+	    (adev->asic_type != CHIP_SIENNA_CICHLID) &&
+	    (adev->asic_type != CHIP_NAVY_FLOUNDER))
 		psp_v11_0_reroute_ih(psp);
 
 	ring = &psp->km_ring;
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
