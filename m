Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3748C6FD18
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Mar 2023 22:09:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EDBEC10E146;
	Tue, 28 Mar 2023 22:09:58 +0000 (UTC)
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com
 [IPv6:2607:f8b0:4864:20::233])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B500510E146
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Mar 2023 22:09:57 +0000 (UTC)
Received: by mail-oi1-x233.google.com with SMTP id l18so10147919oic.13
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Mar 2023 15:09:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=usp.br; s=usp-google; t=1680041396;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=+do5RbLU3FTsGCyiGfUyvpvc06CIKe8iN2wcuyFgpdk=;
 b=Xpn9Q5gVncsLo51GKrL6c6j8Xvr3Cw7fVwaMSzFQslWxG1K3wWhkJpHRZ519ne2b5C
 Rv5kRiXfXne25VOVjR/Ca+aO64nUkX0AnChhFB2k4Kko6H7O/DfgBBloSXZXuSkn5znl
 vOoTA47SfQdiQp7w+zOWyFY31pBV3NKlKqueYOLudpad7EMpkQxhKVsgjrs5IknVJXZh
 NVIGYaRf6shqf3eTEbkCOanf1Fe8HImUjtk2nxI6s3icOF/7LxJxoKoDAlLp78IpGFlu
 uCVR7AwQL8IVtSK+Ir2va5M/N0ZSMXeLhLcEPJWfiS08sNEFRIeYwSTnkR+44hQJlQAB
 OWRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1680041396;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+do5RbLU3FTsGCyiGfUyvpvc06CIKe8iN2wcuyFgpdk=;
 b=Nw/Gbj43rmBRUmkzrLJKo1e2CwCp2yHPbk73y5Jlovar2DQoT6NgcE3tXKNrnNF80N
 5q35HIiUZ7wrU27P21TdB0DDEWbFHbzJdonZRYamAU4nBRtD5z6WZZ5T18SWHtPKUuF8
 ax6dn3uoigJxRzlHaJvkE0hO9Bet3GSKUqY14Voqq2v3yA/sCukWL0teTEWyODcfCCNM
 oZggYSdtRp1SFe3N5PQSqfsTmVugtaOEhbVXg1fG/2xTd23JdBRPScohRksn2FdPizCk
 BenAho+EkoLnoUNWOPaHD4iWZsDtb4D5GzSb42q8if/3agPKJUWwHCGpXrZPLx4F6WTa
 ukoQ==
X-Gm-Message-State: AO0yUKXVp+aiPbxDCo/3ITN5v96+szbmWnvZScssSJy2ONHiTTDPYxwt
 bZ0oMxlaBK7SJhz8qc27YPXeKiIhBDClPbPj3VI2EA==
X-Google-Smtp-Source: AK7set/TXS3xSTLtKC+z7VZsY/Cb0Lq/C02tDibxlVEYu2PSIT1ral1k8nJ/tIKCnGedRgkbJbybZg==
X-Received: by 2002:a05:6808:394a:b0:383:d1e3:38f9 with SMTP id
 en10-20020a056808394a00b00383d1e338f9mr7790081oib.16.1680041396675; 
 Tue, 28 Mar 2023 15:09:56 -0700 (PDT)
Received: from ARCHaio.localdomain ([2804:1b3:a2c0:c911:919f:bd20:4f2a:8383])
 by smtp.gmail.com with ESMTPSA id
 ee39-20020a056870c82700b0017299192eb1sm5400446oab.25.2023.03.28.15.09.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Mar 2023 15:09:56 -0700 (PDT)
From: Caio Novais <caionovais@usp.br>
To: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] drm/amd/display: Remove a unused variable and add a
 function prototype
Date: Tue, 28 Mar 2023 19:09:45 -0300
Message-Id: <20230328220947.108188-1-caionovais@usp.br>
X-Mailer: git-send-email 2.40.0
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
Cc: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
 Wesley Chalmers <Wesley.Chalmers@amd.com>, Gabe Teeger <gabe.teeger@amd.com>,
 Leo Li <sunpeng.li@amd.com>, David Airlie <airlied@gmail.com>,
 Qingqing Zhuo <qingqing.zhuo@amd.com>, "Pan, Xinhui" <Xinhui.Pan@amd.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, Roman Li <roman.li@amd.com>,
 Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>,
 =?UTF-8?q?Ma=C3=ADra=20Canal?= <mairacanal@riseup.net>,
 Hamza Mahfooz <hamza.mahfooz@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Deepak R Varma <drv@mailo.com>,
 "Lee, Alvin" <Alvin.Lee2@amd.com>, Daniel Vetter <daniel@ffwll.ch>,
 Alex Deucher <alexander.deucher@amd.com>, Jun Lei <Jun.Lei@amd.com>,
 Harry Wentland <harry.wentland@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Caio Novais <caionovais@usp.br>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This patchset removes one unused variable and adds a function prototype.

Caio Novais (2):
  drm/amd/display: Remove unused variable 'scl_enable'
  drm/amd/display: Add previous prototype to
    'optc3_wait_drr_doublebuffer_pending_clear'

 drivers/gpu/drm/amd/display/dc/dcn30/dcn30_optc.h               | 2 ++
 .../gpu/drm/amd/display/dc/dml/dcn314/display_rq_dlg_calc_314.c | 2 --
 2 files changed, 2 insertions(+), 2 deletions(-)

-- 
2.40.0

