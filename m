Return-Path: <SRS0=gBm/=OQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C1C7C433F5
	for <amd-gfx@archiver.kernel.org>; Sun, 26 Sep 2021 21:27:26 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB8EE60EB4
	for <amd-gfx@archiver.kernel.org>; Sun, 26 Sep 2021 21:27:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org AB8EE60EB4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3C7F06E5A0;
	Sun, 26 Sep 2021 21:27:25 +0000 (UTC)
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com
 [IPv6:2a00:1450:4864:20::532])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7CFAC6E5A0
 for <amd-gfx@lists.freedesktop.org>; Sun, 26 Sep 2021 21:27:23 +0000 (UTC)
Received: by mail-ed1-x532.google.com with SMTP id y35so9497742ede.3
 for <amd-gfx@lists.freedesktop.org>; Sun, 26 Sep 2021 14:27:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=dyJ1qO+R5BLfYYuTWc2QXotgbOwk1jJzzgANj7+bdq0=;
 b=l5wHDbI/chLkG7O4NWyHarjQZHT3s1bGnpM3MdlnBhTxfiFEiHdJaqnaUkZslaYaRa
 PkcBuHeIy13vu3IrqQzmgDiSQ8V1Jt+GnbhNJkgnrSQbgvlOWh7dBT9Cji0dz7EPHkLN
 Um1t1Kc8HFsuKBgAfnb96M9mkVJWM/MquHRyjtY3Zgm+Jo3iLvfwjAg0M3v6VDa0duSr
 VyMvW6kjS5dOPFn7927u2HwTKscvwclRwWh5t4XML3lC8cZBbvJKBphANESfup3WbKxT
 r9biTmMTN4K/TT2cUnoteWZ8mjFkuzHUEuaG6mVUJYXzPg9bWwksqhq+7DivU7sd46Sb
 q3hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=dyJ1qO+R5BLfYYuTWc2QXotgbOwk1jJzzgANj7+bdq0=;
 b=1iqFOLtVsRdA6I2FcZYIRSbxZoCnBm1JHoPj/cB9NTD/XVYpwJ6wC2Wze5nRrbYicP
 SuPhe23bAdoEOW6P+8YwGc5VWQFMg5FMuxoH9+sBYPs5OoxXUkP66ddoIo+B+OU1kLIw
 Q+KBSehkc+9fzdNOmVQnTVW1cvAYQRRfcyrwWVhq/r/0cD16OiiF3sbm60lEI0guhxxF
 BtVrwsWjshVuoDzIuR9+jwVFq705kS/WGsLGbaw62kn7DKhUxtQLtyreLhrBVura0DFG
 IHfjxig9fVHPLvhB+LbC/S4n6v4TUKQenX2LsSBtg3dpxBEtuErduxOMEbQc7iGHy7Tc
 lKRQ==
X-Gm-Message-State: AOAM531qqO89I1V8C70g3xX2DF+m6VHxjbIh3w3gFHp76d0RgLGwhDI9
 wicl4IBIpBeGeeVn/V/S5XzYYsOoQLU=
X-Google-Smtp-Source: ABdhPJyJ6BbjNXD/s55sBkRloKMBzcbd5KJ7G4GIyvq4RBroyhnzxrKde4VU1nDGlky0ejdshg+ujw==
X-Received: by 2002:aa7:ce14:: with SMTP id d20mr19492103edv.132.1632691641616; 
 Sun, 26 Sep 2021 14:27:21 -0700 (PDT)
Received: from mammut.. (c83-254-134-100.bredband.tele2.se. [83.254.134.100])
 by smtp.gmail.com with ESMTPSA id
 l10sm1619285edr.14.2021.09.26.14.27.20
 for <amd-gfx@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 Sep 2021 14:27:21 -0700 (PDT)
From: =?UTF-8?q?Ernst=20Sj=C3=B6strand?= <ernstp@gmail.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amd/amdgpu: Validate ip discovery blob
Date: Sun, 26 Sep 2021 23:27:19 +0200
Message-Id: <20210926212719.45595-1-ernstp@gmail.com>
X-Mailer: git-send-email 2.30.2
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

We use the number_instance index that we get from the fw discovery blob
to index into an array for example.

Signed-off-by: Ernst Sjöstrand <ernstp@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index ada7bc19118a..b3fc46ba8144 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -245,6 +245,20 @@ void amdgpu_discovery_fini(struct amdgpu_device *adev)
 	adev->mman.discovery_bin = NULL;
 }
 
+static int amdgpu_discovery_validate_ip(const struct ip *ip)
+{
+	if (ip->number_instance >= HWIP_MAX_INSTANCE) {
+		DRM_ERROR("Unexpected number_instance from ip discovery blob\n");
+		return -EINVAL;
+	}
+	if (le16_to_cpu(ip->hw_id) >= HW_ID_MAX) {
+		DRM_ERROR("Unexpected hw_id from ip discovery blob\n");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 int amdgpu_discovery_reg_base_init(struct amdgpu_device *adev)
 {
 	struct binary_header *bhdr;
@@ -290,6 +304,10 @@ int amdgpu_discovery_reg_base_init(struct amdgpu_device *adev)
 
 		for (j = 0; j < num_ips; j++) {
 			ip = (struct ip *)(adev->mman.discovery_bin + ip_offset);
+
+			if (amdgpu_discovery_validate_ip(ip))
+				goto next_ip;
+
 			num_base_address = ip->num_base_address;
 
 			DRM_DEBUG("%s(%d) #%d v%d.%d.%d:\n",
@@ -321,6 +339,7 @@ int amdgpu_discovery_reg_base_init(struct amdgpu_device *adev)
 
 			}
 
+next_ip:
 			ip_offset += sizeof(*ip) + 4 * (ip->num_base_address - 1);
 		}
 	}
-- 
2.30.2

