Return-Path: <SRS0=PoT7=EI=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A659C4742C
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Nov 2020 17:44:51 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9013F21D91
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Nov 2020 17:44:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JjkLFkvm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9013F21D91
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 142776E11C;
	Mon,  2 Nov 2020 17:44:48 +0000 (UTC)
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com
 [IPv6:2607:f8b0:4864:20::542])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A84F36E0DC;
 Mon,  2 Nov 2020 17:18:27 +0000 (UTC)
Received: by mail-pg1-x542.google.com with SMTP id z24so11363398pgk.3;
 Mon, 02 Nov 2020 09:18:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=ongijzBbU5JhggY7XsRs9RUVgnhkALPDdAHYW5noMnU=;
 b=JjkLFkvmOwH3zDu+TtrRvT9/DODaBkhXxFr9Ngla+xzBEAzxw0ASE3vDj5LEA/KrQo
 bNU0Sw0e/+652u5nIAervazqr5MO+wygx2UY9Fbb1QBbxnPRafQvUPPfRm6pZMG71VqO
 IvNHbk89ZlNe9LoCr9lsNi8lacxTTLPZyd91Dr0euY0QwYJfUw0eyBkRZ2XPjdo6pgma
 cRV4c3jlUNi4gWm5o6DXG0WM5VuC55BBz8zjZBTVRAVehfU2x+FgsgyXcVE4PFwW2+fO
 SHH/8wjBVW6F2gh1HCWgISSUgdgKjLlyYly6nHXWo4tjgtWxkOeg4kjjck5JFH4RYHRl
 nDHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=ongijzBbU5JhggY7XsRs9RUVgnhkALPDdAHYW5noMnU=;
 b=dxqKXBSOV3l1OiZoGoKSDOsIbJj7frQgDu/OaJRdwWFOOgZLZ++tULExC0YD0GetTS
 anDTI0mH3pXyv7BoDmOkZqbBEVadZBcClbExqJwmTU4M8Qiot93Uafnuogf5vEHZtDFC
 XRl6Jmk3g2RRZKSpIsikuqPPYq3Yu7yGP4o3mKeQYesHpj5XdBYAs1NQ3dIZ79bcLHO/
 KKMIxMh786rJY1RpFh4CXs2K4TIoogEaqKVsaPKfkhPI+yHLuQ72irNo4EGwMN+NdZct
 u6Hcas03mLrAntuZYv7XJ4ZWi7r8rD8TnkpGkIH5EavNcU58i422pUzaULNkM8Vymz0c
 vG9A==
X-Gm-Message-State: AOAM533CL7pEkMSqKtQNEMJmVjsYFlCDEaooV2J7X8NBTwhrzhj0dCJ9
 FpYxE6rlx0gE0Lh6zFzo2Jw=
X-Google-Smtp-Source: ABdhPJyzPukp9r0F2P829WuznckwaVdiOgSt22gGhCcWY9DhcmgwB3d1g7RXRJesRJ8qX/PIQI9A4w==
X-Received: by 2002:aa7:8281:0:b029:164:cc0f:2b3a with SMTP id
 s1-20020aa782810000b0290164cc0f2b3amr20031757pfm.30.1604337507299; 
 Mon, 02 Nov 2020 09:18:27 -0800 (PST)
Received: from localhost ([160.202.157.3])
 by smtp.gmail.com with ESMTPSA id w6sm13164699pgr.71.2020.11.02.09.18.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2020 09:18:26 -0800 (PST)
Date: Mon, 2 Nov 2020 22:48:21 +0530
From: Deepak R Varma <mh12gx2825@gmail.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@linux.ie>, gregkh@linuxfoundation.org,
 Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/6] drm/amdgpu/vcn: improve code indentation and alignment
Message-ID: <0307c0682da36a5c0c091faf5f352f109df86955.1604336791.git.mh12gx2825@gmail.com>
References: <d644879c4cac32a7cbdbbeebc97c98efd421e17f.1604336791.git.mh12gx2825@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <d644879c4cac32a7cbdbbeebc97c98efd421e17f.1604336791.git.mh12gx2825@gmail.com>
X-Mailman-Approved-At: Mon, 02 Nov 2020 17:44:47 +0000
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
Cc: melissa.srw@gmail.com, daniel.vetter@ffwll.ch, mh12gx2825@gmail.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

General code indentation and alignment changes such as replace spaces
by tabs or align function arguments as per the coding style
guidelines. Issue reported by checkpatch script.

Signed-off-by: Deepak R Varma <mh12gx2825@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c |  2 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c |  2 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c | 10 +++++-----
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
index e5d29dee0c88..136270e4af7b 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
@@ -45,7 +45,7 @@
 #define mmUVD_SCRATCH9_INTERNAL_OFFSET				0xc01d
 
 #define mmUVD_LMI_RBC_IB_VMID_INTERNAL_OFFSET			0x1e1
-#define mmUVD_LMI_RBC_IB_64BIT_BAR_HIGH_INTERNAL_OFFSET 	0x5a6
+#define mmUVD_LMI_RBC_IB_64BIT_BAR_HIGH_INTERNAL_OFFSET		0x5a6
 #define mmUVD_LMI_RBC_IB_64BIT_BAR_LOW_INTERNAL_OFFSET		0x5a7
 #define mmUVD_RBC_IB_SIZE_INTERNAL_OFFSET			0x1e2
 
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
index 0f1d3ef8baa7..4094718ae27a 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
@@ -45,7 +45,7 @@
 
 #define mmUVD_LMI_RBC_IB_VMID_INTERNAL_OFFSET			0x431
 #define mmUVD_LMI_RBC_IB_64BIT_BAR_LOW_INTERNAL_OFFSET		0x3b4
-#define mmUVD_LMI_RBC_IB_64BIT_BAR_HIGH_INTERNAL_OFFSET 	0x3b5
+#define mmUVD_LMI_RBC_IB_64BIT_BAR_HIGH_INTERNAL_OFFSET		0x3b5
 #define mmUVD_RBC_IB_SIZE_INTERNAL_OFFSET			0x25c
 
 #define VCN25_MAX_HW_INSTANCES_ARCTURUS			2
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
index e074f7ed388c..13e511d77bb1 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
@@ -44,10 +44,10 @@
 
 #define mmUVD_LMI_RBC_IB_VMID_INTERNAL_OFFSET			0x431
 #define mmUVD_LMI_RBC_IB_64BIT_BAR_LOW_INTERNAL_OFFSET		0x3b4
-#define mmUVD_LMI_RBC_IB_64BIT_BAR_HIGH_INTERNAL_OFFSET 	0x3b5
+#define mmUVD_LMI_RBC_IB_64BIT_BAR_HIGH_INTERNAL_OFFSET		0x3b5
 #define mmUVD_RBC_IB_SIZE_INTERNAL_OFFSET			0x25c
 
-#define VCN_INSTANCES_SIENNA_CICHLID	 				2
+#define VCN_INSTANCES_SIENNA_CICHLID				2
 
 static int amdgpu_ih_clientid_vcns[] = {
 	SOC15_IH_CLIENTID_VCN,
@@ -55,8 +55,8 @@ static int amdgpu_ih_clientid_vcns[] = {
 };
 
 static int amdgpu_ucode_id_vcns[] = {
-       AMDGPU_UCODE_ID_VCN,
-       AMDGPU_UCODE_ID_VCN1
+		AMDGPU_UCODE_ID_VCN,
+		AMDGPU_UCODE_ID_VCN1
 };
 
 static int vcn_v3_0_start_sriov(struct amdgpu_device *adev);
@@ -1371,7 +1371,7 @@ static int vcn_v3_0_start_sriov(struct amdgpu_device *adev)
 	}
 
 	/* Update init table header in memory */
-        size = sizeof(struct mmsch_v3_0_init_header);
+	size = sizeof(struct mmsch_v3_0_init_header);
 	table_loc = (uint32_t *)table->cpu_addr;
 	memcpy((void *)table_loc, &header, size);
 
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
