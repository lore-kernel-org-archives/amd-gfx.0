Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A57F6C43334
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Jun 2022 13:51:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3C7D010E2DA;
	Mon,  6 Jun 2022 13:51:28 +0000 (UTC)
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com
 [IPv6:2a00:1450:4864:20::12a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6C30210E2DA
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 Jun 2022 13:51:26 +0000 (UTC)
Received: by mail-lf1-x12a.google.com with SMTP id c2so3984017lfk.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 06 Jun 2022 06:51:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bell-sw-com.20210112.gappssmtp.com; s=20210112;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=7Rs5VSE8HWfdflYyBF9WOg2vOZdqzwmKO4+NjsW67k0=;
 b=daeutWhKtWSWPvb1AEMf46UG3dhzY1HOijzsgiC4DQB2fii5iY6nxHzJvcjBf4SBs/
 jMbw4R7ufuvUqi4UOVfeLD6j09zFijtEu5AwBi7I3EBQfr17eoiISm+xUcEMEGofWuyn
 NspivbumhsSUuKaD+jxQaW42tgxhMvinWD87HYTzYr96S6f06ONZ7WrdrgQYtWGwIT3e
 cw+ys6xQjn1IpAu5xNgJzcG7SWxjPoejIPyl9OMQmr+L2dlWXCK2QeZ7443MTL4BBGrB
 653h4OStxf+QANfC1bDkiOsc3w9gzqIINACnnP75kzHrwzuQHu5fjjNfdwQ428Gw6Red
 SD0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=7Rs5VSE8HWfdflYyBF9WOg2vOZdqzwmKO4+NjsW67k0=;
 b=6hQbUSQeqqAyO6PzNi+qS/mNmYc6Wxw9ygY6T4pEbbToP82Zt67VncjI7dgg03LnVl
 huee4gD4mDeoCOvz9VCbBcJRw5+3yBIDAhWbvggq0x+hSjzks9Qb2bR8lK9t18zX2xSc
 KFrFXkGWLmxHeT//lFh/4USJQbZugZ+4d5ClksRsiIsxqu/ymiUBHT2GBfhfNsDsvyYx
 5pTPAcftjVLVFU2SAaC2die8WvDHmlRRLXXDMEMXwh2wQYccTbZijcSwZfoYqVpqChj0
 89wzOOMACiqgApSD9Nw1iwzBL+TVRGP8S1KRgzq84Ir4ndNMgmc4BYaw3Lr+UfNbqSUG
 SYWA==
X-Gm-Message-State: AOAM531Vq2GZ4YEpbaRc98uy4Kx0Pp1PldoOZTXzp4MRIU1o8XfPIy9K
 HJuUraMi+r75OQqPVaBw5erp6Z7lL+3G
X-Google-Smtp-Source: ABdhPJxLJNkNBoCuNV4bofnjid/6V8sHvhFUWEKSSCj9uVkmivqChC9GEeWcJz8FkUazonALEVy0WA==
X-Received: by 2002:ac2:5d22:0:b0:478:9e46:ae85 with SMTP id
 i2-20020ac25d22000000b004789e46ae85mr15387284lfb.126.1654523484451; 
 Mon, 06 Jun 2022 06:51:24 -0700 (PDT)
Received: from localhost.localdomain ([91.247.148.7])
 by smtp.gmail.com with ESMTPSA id
 a7-20020a2e8607000000b00253bc47c202sm1080589lji.59.2022.06.06.06.51.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jun 2022 06:51:24 -0700 (PDT)
From: Alexey Kodanev <aleksei.kodanev@bell-sw.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/radeon: fix potential buffer overflow in
 ni_set_mc_special_registers()
Date: Mon,  6 Jun 2022 16:50:54 +0300
Message-Id: <20220606135054.82326-1-aleksei.kodanev@bell-sw.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
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
Cc: Alexey Kodanev <aleksei.kodanev@bell-sw.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The last case label can write two buffers 'mc_reg_address[j]' and
'mc_data[j]' with 'j' offset equal to SMC_NISLANDS_MC_REGISTER_ARRAY_SIZE
since there are no checks for this value in both case labels after the
last 'j++'.

Instead of changing '>' to '>=' there, add the bounds check at the start
of the second 'case' (the first one already has it).

Also, remove redundant last checks for 'j' index bigger than array size.
The expression is always false. Moreover, before or after the patch
'table->last' can be equal to SMC_NISLANDS_MC_REGISTER_ARRAY_SIZE and it
seems it can be a valid value.

Detected using the static analysis tool - Svace.
Fixes: 69e0b57a91ad ("drm/radeon/kms: add dpm support for cayman (v5)")
Signed-off-by: Alexey Kodanev <aleksei.kodanev@bell-sw.com>
---
 drivers/gpu/drm/radeon/ni_dpm.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/radeon/ni_dpm.c b/drivers/gpu/drm/radeon/ni_dpm.c
index 769f666335ac..672d2239293e 100644
--- a/drivers/gpu/drm/radeon/ni_dpm.c
+++ b/drivers/gpu/drm/radeon/ni_dpm.c
@@ -2741,10 +2741,10 @@ static int ni_set_mc_special_registers(struct radeon_device *rdev,
 					table->mc_reg_table_entry[k].mc_data[j] |= 0x100;
 			}
 			j++;
-			if (j > SMC_NISLANDS_MC_REGISTER_ARRAY_SIZE)
-				return -EINVAL;
 			break;
 		case MC_SEQ_RESERVE_M >> 2:
+			if (j >= SMC_NISLANDS_MC_REGISTER_ARRAY_SIZE)
+				return -EINVAL;
 			temp_reg = RREG32(MC_PMG_CMD_MRS1);
 			table->mc_reg_address[j].s1 = MC_PMG_CMD_MRS1 >> 2;
 			table->mc_reg_address[j].s0 = MC_SEQ_PMG_CMD_MRS1_LP >> 2;
@@ -2753,8 +2753,6 @@ static int ni_set_mc_special_registers(struct radeon_device *rdev,
 					(temp_reg & 0xffff0000) |
 					(table->mc_reg_table_entry[k].mc_data[i] & 0x0000ffff);
 			j++;
-			if (j > SMC_NISLANDS_MC_REGISTER_ARRAY_SIZE)
-				return -EINVAL;
 			break;
 		default:
 			break;
-- 
2.25.1

