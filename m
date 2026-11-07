Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DBDA606A31C
	for <amd-gfx@archiver.kernel.org>; Sun,  8 Nov 2026 15:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cH2IRBdr
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8A1C910E538;
	Sun,  8 Nov 2026 15:02:43 +0000 (UTC)
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com
 [209.85.221.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C7F9710E2B1
 for <amd-gfx@lists.freedesktop.org>; Sat,  7 Nov 2026 20:48:05 +0000 (UTC)
Received: by mail-wr1-f53.google.com with SMTP id
 ffacd0b85a97d-490f38e9688so52279f8f.0
 for <amd-gfx@lists.freedesktop.org>; Sat, 07 Nov 2026 12:48:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794084484; x=1794689284; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=dEK4DMTI3KM8bcuTj0Liw5CczqSbiD66MDHm6KNtTVw=;
 b=cH2IRBdrL+oyAXXwvy/DvVp3ZE+q+5HvEgYgAOlEiZrSCxsNyifiGGRubs6wJI3EZc
 JrXLqh0FnyngC+y3Fwyp6qeTxTQ6Z3dchOkKnZuj/Aq+oxAjr0P3lPGv7RnPTwVSyQW7
 bCqOFaVngcIZAqvFVe9wSuScHEwgkqkc1MCWlLgw+vbyKiBLXybpwOCQPxleGi58dEQe
 fJBWe4dOBM4ReItg7JFuB1aNMi/jC8B+5OOe7uyv4HciyCXjYHS2sBrP5pOZJ5cAQ2WY
 tcl4ItF2CZthxq6cDTRhbiwvnPJ+YyfJVOPjl+cZkVx5v1HjeZw/2ftCPn4RnP6Fc3td
 PgVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794084484; x=1794689284;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=dEK4DMTI3KM8bcuTj0Liw5CczqSbiD66MDHm6KNtTVw=;
 b=b3c+2qqTSENHMaQUdA2Nhm1GVKvdaPOVBQYvZt3t1UmO47h3C3YKwNYzJcnjnqj/oS
 KgYRCqXlWhru4RiF08sTXCBvgxuCqiUBqHVa/2aAUfrd+VzK8opj+kmjAGzrowRWVk/G
 a0gLj3Xt+7hLtofvYtlkC6zA02C9RXo5XV6/JW7Z86owXCKtqeQyBpKyOut4G8Ou8OdV
 uwoMVq28KOovBL5mbzJLJRbJHWwBiwcgWNPcyWOxZOG+5fpYaOMtDKmCAbHuJOwcNS9C
 oao1mkHkMAB4skQS4ajh155kDYoaXRCxM3r+RtgPwryTI97mvWeja1DkwtEfVEJOW8O4
 0D8g==
X-Gm-Message-State: APuU4Z8/+YXmaU6i/yV3g0eJODV6dxAcyYrs3PB4h0VgNlb6q6Ug2+iw
 WDTt3MI03kZr9BOizG6YheVSspzJxIcJiV8ZLBWcdhbfQGdq4C6eKFAL4xx9waxLoTc=
X-Gm-Gg: AYBFou2XAf7VHNMm+LFbg9oYZ6l0iQKlvWLbxOwxvW3eNqqEs5QYl2j1rMzo6Zq+hgO
 qET4mHnR6tkldiETEQwr5+lh1s7C8tiNk9WriH8IzqYBegVnuzF5lx+JC2B+HZG2mdwvAahjpK9
 +TGVSrCgm2MFeLMQh5LWCCUliDNCf70Wdk8nyYoo1u7qZJ78cKnwn+No7hTCNFIvg8T9PaAwVcP
 5iS+EdlWIqtCrymyOtoTa3m01sPNOkdgsYDO1koYY0SL/ICukKjhHuJJgbBLUNu38HZV93B505q
 vWLQocn+t8duTT7NAwkvYSPnOHZfkKaqoGR9vGDaed+01fua88aWBtoz3BVDPJ/NvbGZeO17K0V
 GU+/N5+fSKrNfEhlIetGfZ6xKQ6KeNvoLMHq3TW+S1yEwPHNAZlKuwFbbwgjNnijzOdCJE/585z
 qToILOr6eMLLry/SAN1CSA1v9jYib43ptMGQYWDuAUQWyxGMHTxlb7p7sWaal88aLMbvyNTjlU7
 t761VWCntUsuKNYBoeeA4OyBB6SpMJ56XL7Mo1dvVwNmMzSLgKl1veoAEcX7877hHBltCzh3J0A
 1+NVQFgEewRPPOp8AUou5O7Cfq2rhFbakJYilCvzV3qZnD5TCc6jSC9qxbE2cpNXY47LRmpej4C
 VauF0w+dgYexKO+4=
X-Received: by 2002:a5d:5d83:0:b0:492:aff5:da60 with SMTP id
 ffacd0b85a97d-494233d76c0mr4817982f8f.13.1794084483900; 
 Sat, 07 Nov 2026 12:48:03 -0800 (PST)
Received: from archBTW.Dlink ([176.194.224.120])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-495966f3163sm59372f8f.11.2026.11.07.12.48.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Nov 2026 12:48:03 -0800 (PST)
From: Maxim Sokolov <raymondjup46@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com, christian.koenig@amd.com, kenneth.feng@amd.com,
 lijo.lazar@amd.com, Tim.Huang@amd.com
Subject: [PATCH] drm/amd/pm: skip MP1 unload on S4 after S0i3 on SMU 13.0.4
Date: Sat,  7 Nov 2026 23:48:01 +0300
Message-ID: <20261107204801.624322-1-raymondjup46@gmail.com>
X-Mailer: git-send-email 2.56.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 08 Nov 2026 15:02:42 +0000
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FORGED_GMAIL_RCVD,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

After a suspend-to-idle cycle, PMFW on SMU 13.0.4 no longer
answers GfxDeviceDriverReset, and the whole SoC hangs when hibernate
sends it before PrepareMp1ForUnload.

Track whether PMFW has been through S0i3 since it was last unloaded.
If it has, skip the GFX reset and MP1 unload for S4. The platform
powers off after the hibernate image is written and PMFW cold-boots
before restore. S0i3 already leaves PMFW running on GFX11 APUs.

Tested on a Redmi Book 15 Pro 2023(Ryzen 7 7840HS, BIOS RMAPH5B0P0909):
s2idle followed by hibernate no longer hangs.

Fixes: fedb6ae49758 ("drm/amd/pm: fixes a random hang in S4 for SMU v13.0.4/11")
Signed-off-by: Maxim Sokolov <raymondjup46@gmail.com>
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c            |  3 +++
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h        |  2 ++
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c | 11 +++++++++++
 3 files changed, 16 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 86e34e814fe..4988f85526b 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -2247,6 +2247,9 @@ static int smu_hw_fini(struct amdgpu_ip_block *ip_block)
 
 	adev->pm.dpm_enabled = false;
 
+	if (adev->in_s0ix)
+		smu->pmfw_s0ix_since_unload = true;
+
 	ret = smu_smc_hw_cleanup(smu);
 	if (ret)
 		return ret;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
index 2a0cdc6e805..b0232ccbe1e 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
@@ -766,6 +766,8 @@ struct smu_context {
 	long *custom_profile_params;
 	bool pm_enabled;
 	bool is_apu;
+	/* PMFW has been through S0i3 since it was last unloaded */
+	bool pmfw_s0ix_since_unload;
 
 	/* Power dependency link from an integrated xHCI controller to the GPU */
 	struct device_link		*usb_power_link;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c
index a9d558f5b73..35274c5c67d 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c
@@ -230,6 +230,15 @@ static int smu_v13_0_4_system_features_control(struct smu_context *smu, bool en)
 	int ret = 0;
 
 	if (!en && !adev->in_s0ix) {
+		/*
+		 * After an S0i3 cycle PMFW does not answer GfxDeviceDriverReset.
+		 * Leave PMFW running, as is already done for S0i3 on GFX11 APUs.
+		 */
+		if (adev->in_s4 && smu->pmfw_s0ix_since_unload) {
+			dev_dbg(adev->dev, "Skipping MP1 unload for S4 after S0i3\n");
+			return 0;
+		}
+
 		if (adev->in_s4) {
 			/* Adds a GFX reset as workaround just before sending the
 			 * MP1_UNLOAD message to prevent GC/RLC/PMFW from entering
@@ -242,6 +251,8 @@ static int smu_v13_0_4_system_features_control(struct smu_context *smu, bool en)
 		}
 
 		ret = smu_cmn_send_smc_msg(smu, SMU_MSG_PrepareMp1ForUnload, NULL);
+		if (!ret)
+			smu->pmfw_s0ix_since_unload = false;
 	}
 
 	return ret;
-- 
2.56.0

