Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B4E7C4332F
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Feb 2022 14:06:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 48D2E10E82B;
	Tue, 22 Feb 2022 14:06:43 +0000 (UTC)
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com
 [IPv6:2607:f8b0:4864:20::234])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9098910E62B
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Feb 2022 13:18:08 +0000 (UTC)
Received: by mail-oi1-x234.google.com with SMTP id ay7so14376048oib.8
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Feb 2022 05:18:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=usp.br; s=usp-google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ACyjILcPZ7NYc4LHqBI/xMepMYxZRqk3PuvZsYhS/Ak=;
 b=v4JuF4eo37E18crpKjb/Gy2A7pJWq76VCa+SO0Yq2LZhwxQ80IckHLVEykfxl+nfW6
 zOiTv4hSWHNOaMO3uESTI58NF+VpBtZ+ioz74gPPvRewBi5Wm/vNY4R76jnCGHoPc6H1
 D4duIjjzalbpwjn4VmFoKeov9xAV/JkbSY0bME9CiQ5EoiVvI/bAL+3PvS4rK8pcTUer
 fAL6Y8cQdpq2p3zQaGuE84a+1HeTzBv7Vxh8mUZFHbhT28l7rk9/7J139WxWOZ2t9UX0
 QfoIZcl0NVgcSrenDt/ZlCfp0kbAjFMyzQUcxgYWD2P6bDQVYoBq0GMddHGGMJx8FiVi
 Xkgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ACyjILcPZ7NYc4LHqBI/xMepMYxZRqk3PuvZsYhS/Ak=;
 b=lBcFtK91ECz4dmIpYgqXtdV3k9CoAMHFeUqHD3N9FSU3rZUV3DHYWGCN79pQKPiEdp
 Gs9P5S6DjzIARXjF502GI40KD4tZCksVCP25JwrL57Fdv0xQYHubpHffFQoFBzvR1uMc
 sGJPcUGBOUxVCu8SrvDuILacarQRLxfKfHbFfLl/w88KF+JB5O8z1XQswNzY3wwu6wnI
 qPcbn2E38VDIvih+4NMuLt6fwuXHEnG6Ugn5t88BeHfOGLndn7hxy3tfO32jSGr73CXK
 ItAYxqLr02hI9VYb1cCerrAv3Rq9uoi/5KqZGwRpgYkTS1kaysEj53Vv5D6fWZFDHmvO
 X51A==
X-Gm-Message-State: AOAM532QyRv3sPPkByIsKLzPxzG+1O9wNw2KOCLEW3vqOH+qqJjIkSNq
 9TeKkucnAwjTAyiWdhlc9uCEHg==
X-Google-Smtp-Source: ABdhPJwPv6b/Py7a73THpCfPZnfM/8IqLsz85BzUx8kIjX3WPdbvzYq+DLAUFR44XYrhcXxQsPSCiA==
X-Received: by 2002:a05:6808:238e:b0:2d4:fe08:9351 with SMTP id
 bp14-20020a056808238e00b002d4fe089351mr1835703oib.291.1645535887885; 
 Tue, 22 Feb 2022 05:18:07 -0800 (PST)
Received: from fedora.. ([187.36.236.204])
 by smtp.gmail.com with ESMTPSA id c9sm6325050otd.26.2022.02.22.05.18.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Feb 2022 05:18:07 -0800 (PST)
From: =?UTF-8?q?Ma=C3=ADra=20Canal?= <maira.canal@usp.br>
To: alexander.deucher@amd.com, christian.koenig@amd.com, Xinhui.Pan@amd.com,
 Hawking.Zhang@amd.com, john.clements@amd.com, tao.zhou1@amd.com,
 YiPeng.Chai@amd.com, luben.tuikov@amd.com, Stanley.Yang@amd.com,
 Dennis.Li@amd.com, mukul.joshi@amd.com, harry.wentland@amd.com,
 sunpeng.li@amd.com, Rodrigo.Siqueira@amd.com, Anthony.Koo@amd.com
Subject: [PATCH 05/10] drm/amd/display: Remove unused
 dcn316_smu_set_voltage_via_phyclk function
Date: Tue, 22 Feb 2022 10:16:56 -0300
Message-Id: <20220222131701.356117-6-maira.canal@usp.br>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220222131701.356117-1-maira.canal@usp.br>
References: <20220222131701.356117-1-maira.canal@usp.br>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 22 Feb 2022 14:06:42 +0000
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
Cc: magalilemes00@gmail.com,
 =?UTF-8?q?Ma=C3=ADra=20Canal?= <maira.canal@usp.br>,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, mwen@igalia.com,
 amd-gfx@lists.freedesktop.org, isabbasso@riseup.net
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Remove dcn316_smu_set_voltage_via_phyclk function, which is not used in the
codebase.

This was pointed by clang with the following warning:

drivers/gpu/drm/amd/amdgpu/../display/dc/clk_mgr/dcn316/dcn316_smu.c:171:5:
warning: no previous prototype for function
'dcn316_smu_set_voltage_via_phyclk' [-Wmissing-prototypes]
int dcn316_smu_set_voltage_via_phyclk(struct clk_mgr_internal *clk_mgr, int
requested_phyclk_khz)
    ^

Signed-off-by: Maíra Canal <maira.canal@usp.br>
---
 .../amd/display/dc/clk_mgr/dcn316/dcn316_smu.c   | 16 ----------------
 1 file changed, 16 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn316/dcn316_smu.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn316/dcn316_smu.c
index b7f9e1b34c11..fd6497fd2dc5 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn316/dcn316_smu.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn316/dcn316_smu.c
@@ -168,22 +168,6 @@ int dcn316_smu_set_dispclk(struct clk_mgr_internal *clk_mgr, int requested_dispc
 	return actual_dispclk_set_mhz * 1000;
 }
 
-int dcn316_smu_set_voltage_via_phyclk(struct clk_mgr_internal *clk_mgr, int requested_phyclk_khz)
-{
-	int actual_phypclk_set_mhz = -1;
-
-	if (!clk_mgr->smu_present && requested_phyclk_khz)
-		return requested_phyclk_khz;
-
-	/*  Unit of SMU msg parameter is Mhz */
-	actual_phypclk_set_mhz = dcn316_smu_send_msg_with_param(
-			clk_mgr,
-			VBIOSSMC_MSG_SetPhyclkVoltageByFreq,
-			khz_to_mhz_ceil(requested_phyclk_khz));
-
-	return actual_phypclk_set_mhz * 1000;
-}
-
 int dcn316_smu_set_hard_min_dcfclk(struct clk_mgr_internal *clk_mgr, int requested_dcfclk_khz)
 {
 	int actual_dcfclk_set_mhz = -1;
-- 
2.35.1

