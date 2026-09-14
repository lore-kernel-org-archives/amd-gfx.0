Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E77EAC88E70
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Sep 2026 12:47:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EA30610EDF8;
	Mon, 14 Sep 2026 12:47:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Ckj5Lgnt";
	dkim-atps=neutral
Received: from mail-ej2-f12.google.com (mail-ej2-f12.google.com
 [74.125.228.140])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C851810E397
 for <amd-gfx@lists.freedesktop.org>; Mon, 14 Sep 2026 10:30:36 +0000 (UTC)
Received: by mail-ej2-f12.google.com with SMTP id
 a640c23a62f3a-c254fa4c24cso252002866b.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 14 Sep 2026 03:30:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789381835; x=1789986635; darn=lists.freedesktop.org;
 h=content-disposition:content-type:mime-version:message-id:subject:cc
 :to:from:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=ZKeoHyxJcGHvnZP+SSp3fLq1fos9BUNkVIoHSvpzm6Y=;
 b=Ckj5Lgnt+ImJgdE5b71g4LvcArDMI6IdF1yP955Xn1IKDSohTdjUEVUAk7/5yNwhBF
 tuIkXyvKKybj/4zypvEVJkB67L+G36bzu0zj2vOntJytwmaxhAyeq8+/i5aQcqoTePDt
 9f22icwf/xHjlpgnk/NYst5yh5V2f2j9hXcGWS9bcCa2OEiID316zNrlLXg/fzDIH3C6
 QwWeEdTBZ45682pn6TQdiy35GWHzL5fDvRnQ3qLF4cowNNQvXwzB7vLE5A4PpXdYkrMQ
 yvjw0iVnxLS8FbvjppQtx3LdQ5gukzGTPlDFhmnO3pPsZSCM8Sv+t+kRc5s57ToBNhIp
 eflg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789381835; x=1789986635;
 h=content-disposition:content-type:mime-version:message-id:subject:cc
 :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ZKeoHyxJcGHvnZP+SSp3fLq1fos9BUNkVIoHSvpzm6Y=;
 b=Y2k5RRZQDMnAF+cIFF3IzB+VjwdOcv+wC6+HzzjPvRGDyKSJiHJhqpN6FpBczboyJm
 fUfSHEKeopJEhK49cCBbU7Wx9MtgLBlN0/nfjgO4IcWBmMsqyklrH/h56+ghzYNOJEOM
 5so1C71BQPiHqTajyM8OeNLoCNF2CNkVVQS72oftNVy3j4tjgR+d/g+XsbRukkvv905+
 yIkUS23fvRY/Jt5LShKPQuAvblp0IVmH/uJDuFn9BxSOfoHuwsUu8z6hQO23FVOLR26q
 ef+Cj0l9x6BUSkllsWVEUSUBumysdri7uV82Ppl+1mj2NzWAqQtO7wP+ifAM5qS+julk
 oQlQ==
X-Gm-Message-State: AFuF++mjp1X/aeiiSjIOeDsd7BRz5jdSSMiH6E1KHITY1/cn/aPPL9DU
 aYCXUwoD7DQaT8dlscdgLItm0kAFaqUNRj7yEIiaB7+W95TEiUQ9k+Zh
X-Gm-Gg: AYBFou16iCfiR8y1O8REdFnP0ApIQBRti/kTkC0z2iUGaL/TGUCNuM9LK0wbsOTMudJ
 U8iMDD1PM4mbaKbbZRulbxen/wgehA4mSfdwFnZ4vUF+wn1cNM9L58Ev99cyjG2gcDlxIAHW3XI
 +u6dD/p0FfYKyG24Frktt6QmoLOOfeTgSNPiV42jAKFK/o4qLTGdKgbD3PaMtDbKg7af0JjrJ3y
 HUDGNBZxIVkQRT8TfBMDv4noz5Qcfiw7fk5WzburRvdm3BbcJCbFR7EmOzg+eB/wSRyGckI9MaM
 XxLN3+IGXpL/qqrncspcMJKJ5y0UJPsJjYxkses8iU6KuXYt2GsPJUwVac2lM/pEltDS43tlN20
 ObDoR6TNbi/FD7WeH6fHxer5LXU9vZZPBNA8agvy70eBODEMnoevIdk3UFT1hOjboOQWAVVIeQj
 lh6+Em/U/Ldj+ktBtKdc2szS3b7Q4DAKRf5IgwOWjABapveN4mfRCjSwmloIGt/2YeV0I=
X-Received: by 2002:a17:907:9411:b0:c26:3190:296b with SMTP id
 a640c23a62f3a-c29b876b1e3mr119972266b.48.1789381835026; 
 Mon, 14 Sep 2026 03:30:35 -0700 (PDT)
Received: from localhost ([2c0f:3d00:6be:8900:ce5e:9212:ea4b:f30])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c2966026e2esm402972066b.19.2026.09.14.03.30.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Sep 2026 03:30:34 -0700 (PDT)
Date: Mon, 14 Sep 2026 13:30:30 +0300
From: Dan Carpenter <error27@gmail.com>
To: Aurabindo Pillai <aurabindo.pillai@amd.com>
Cc: amd-gfx@lists.freedesktop.org,
 "SHANMUGAM, SRINIVASAN" <SRINIVASAN.SHANMUGAM@amd.com>
Subject: [bug report] drm/amd/display: Enable DCN6 sources compilation
Message-ID: <aqfMxsk1sVyVHNKt@stanley.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailman-Approved-At: Mon, 14 Sep 2026 12:47:06 +0000
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

Hello Aurabindo Pillai,

Commit 992694ad2858 ("drm/amd/display: Enable DCN6 sources
compilation") from Jul 21, 2026, leads to the following Smatch
complaint:

    drivers/gpu/drm/amd/amdgpu/../display/dc/hwss/dce110/dce110_hwseq.c:3500 dce110_enable_tmds_link_output()
    warn: variable dereferenced before check 'link->link_enc' (see line 3490)

drivers/gpu/drm/amd/amdgpu/../display/dc/hwss/dce110/dce110_hwseq.c
  3489		(void)link_res;
  3490		link->link_enc->funcs->enable_tmds_output(
                ^^^^^^^^^^^^^^^^
The exiting code dereferences link->link_enc

  3491				link->link_enc,
  3492				clock_source,
  3493				color_depth,
  3494				signal,
  3495				pixel_clock);
  3496		link->phy_state.symclk_state = SYMCLK_ON_TX_ON;
  3497	
  3498		// For dongle Type 2 with no I2C support on board, setup sw mode of Ri/Pj check with proper aux instance
  3499		if (link->force_to_use_aux) {
  3500			if (link->link_enc && link->link_enc->funcs->setup_ri_pj_check_in_sw_or_hw_mode)
                            ^^^^^^^^^^^^^^

  3501				link->link_enc->funcs->setup_ri_pj_check_in_sw_or_hw_mode(link->link_enc,
  3502					link->aux_hw_inst, true);
  3503          } else
  3504                  // For HDMI setup hw mode of Ri/Pj check with proper ddc pin instance
  3505                  if (link->link_enc && link->link_enc->funcs->setup_ri_pj_check_in_sw_or_hw_mode)
                            ^^^^^^^^^^^^^^
So these checks don't make sense.

  3506                          link->link_enc->funcs->setup_ri_pj_check_in_sw_or_hw_mode(link->link_enc,
  3507                                  link->ddc_hw_inst, false);
  3508  }


This email is a free service from the Smatch-CI project [smatch.sf.net].

regards,
dan carpenter
