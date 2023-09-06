Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79A75EB8FD2
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Sep 2023 13:25:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F130610E658;
	Wed,  6 Sep 2023 13:25:08 +0000 (UTC)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6F62210E604
 for <amd-gfx@lists.freedesktop.org>; Wed,  6 Sep 2023 10:57:18 +0000 (UTC)
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-31977ace1c8so3118409f8f.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 06 Sep 2023 03:57:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693997837; x=1694602637; darn=lists.freedesktop.org;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :from:to:cc:subject:date:message-id:reply-to;
 bh=/Y5Ej8sVuMgzRhuzQp0sd6X+S75bJvIgOVGK1WruK1g=;
 b=msko9axxeNpIk89gZp1We8A9MAOrE7SWCZSkO6fkCNp5Of0TmlNPdCo8RbpdeUG9yA
 xDFfCFS2klDRORmC3ZiBfNezb8zmrNad71r7A0YNDuRax8ss2Z7HCI9fe7BoIG7l8tWR
 P/rpS2NTV3Pdu1IH188b6ZogZiOJZcfS5P8CR0ZmfSukpKmq5l/V5Rf/kREiThXh7cmB
 rJXjx4PVTPfwc+xjJ3pS83XbHLe4UMkPmXbkwCXxTU0IusqGaMO2d0NcGX67Jogkzbvq
 JjWR01riU1a4ZluWeji90lsoaeUQ5gmnV8jDnNKTBUaytnJmTF+Y+ucXPX8YBHpaO6WD
 7pUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693997837; x=1694602637;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/Y5Ej8sVuMgzRhuzQp0sd6X+S75bJvIgOVGK1WruK1g=;
 b=cN+2+8WBflJLwYZs/Hng6InBK2Wk6pYFNL92sDVnKhTuEYy5dM6j1SKP+o018Onsc3
 X/6/9d5n1E40vab+fIgYL4vLmgzTXlHepMSfUQxavV+H1CTHrS4kcW6H4Jm1JnZT27Jv
 i1h0LH0eNBOgKOSVk/Hi2nf741442UaqTIrjh95/cbaVsEs06vOUItERsViu4ZHNvnaf
 CfblqL0FqbHgJ1Lc9MZ5ULzlJUU/vphX1DD9xuJ8DCViS5kF6o3P2hw78QRekEy+Sucy
 brYwu3KQenrdwoeV6dYHBSERBJrN6/en+cq0labp2BQSomfn83ePha2ExgiNvyjX7oml
 3DAw==
X-Gm-Message-State: AOJu0YwZjvtWCglLsjSI/X4YDJjUAm5r1dmtacixrp/fuA2g4a95Xb10
 fz/n4bAz38a2y1vaLbtJk044uQ==
X-Google-Smtp-Source: AGHT+IHDhQup35uKxMbBvfmKm9+/hPi8QxVZTzQujAcUp9WCatyfRefdOi1A+fT+b7RyHoJjm/Aznw==
X-Received: by 2002:a5d:66c1:0:b0:319:8ce0:4e52 with SMTP id
 k1-20020a5d66c1000000b003198ce04e52mr1814168wrw.67.1693997836795; 
 Wed, 06 Sep 2023 03:57:16 -0700 (PDT)
Received: from localhost ([102.36.222.112]) by smtp.gmail.com with ESMTPSA id
 fa20-20020a05600c519400b00402d7105035sm4142200wmb.26.2023.09.06.03.57.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Sep 2023 03:57:16 -0700 (PDT)
Date: Wed, 6 Sep 2023 13:57:08 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Qingqing.Zhuo@amd.com
Subject: [bug report] Mass report of new Smatch warnings
Message-ID: <e69124d0-4b11-4518-b36c-8aafa3c88bd7@moroto.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailman-Approved-At: Wed, 06 Sep 2023 13:25:05 +0000
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
Cc: amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Here is the list of new warning which were introduced while I was out
of office.  The line numbers are from linux-next next-20230905.

regards,
dan carpenter

drivers/gpu/drm/amd/amdgpu/../display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c:292 dcn35_update_clocks() warn: inconsistent indenting
drivers/gpu/drm/amd/amdgpu/../display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c:919 dcn35_clk_mgr_construct() warn: inconsistent indenting
drivers/gpu/drm/amd/amdgpu/../display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c:921 dcn35_clk_mgr_construct() warn: inconsistent indenting
drivers/gpu/drm/amd/amdgpu/../display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c:980 dcn35_clk_mgr_construct() warn: variable dereferenced before check 'ctx->dc_bios->integrated_info' (see line 913)
drivers/gpu/drm/amd/amdgpu/../display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c:980 dcn35_clk_mgr_construct() warn: variable dereferenced before check 'ctx->dc_bios' (see line 913)
drivers/gpu/drm/amd/amdgpu/../display/dc/dcn20/dcn20_hwseq.c:1751 dcn20_program_pipe() error: we previously assumed 'pipe_ctx->plane_state' could be null (see line 1710)
drivers/gpu/drm/amd/amdgpu/../display/dc/dcn35/dcn35_hwseq.c:159 dcn35_init_hw() warn: inconsistent indenting
drivers/gpu/drm/amd/amdgpu/../display/dc/dcn35/dcn35_hwseq.c:159 dcn35_init_hw() warn: variable dereferenced before check 'res_pool->dccg' (see line 150)
drivers/gpu/drm/amd/amdgpu/../display/dc/dcn35/dcn35_hwseq.c:206 dcn35_init_hw() error: we previously assumed 'res_pool->hubbub' could be null (see line 159)
drivers/gpu/drm/amd/amdgpu/../display/dc/dcn35/dcn35_hwseq.c:285 dcn35_init_hw() error: we previously assumed 'dc->clk_mgr' could be null (see line 136)
drivers/gpu/drm/amd/amdgpu/../display/dc/dcn35/dcn35_hwseq.c:977 dcn35_calc_blocks_to_gate() error: we previously assumed 'pipe_ctx->plane_res.hubp' could be null (see line 973)
drivers/gpu/drm/amd/amdgpu/../display/dc/dcn35/dcn35_hwseq.c:980 dcn35_calc_blocks_to_gate() warn: always true condition '(pipe_ctx->plane_res.mpcc_inst >= 0) => (0-255 >= 0)'
drivers/gpu/drm/amd/amdgpu/../display/dc/dcn35/dcn35_pg_cntl.c:203 pg_cntl35_hubp_dpp_pg_control() warn: duplicate check 'power_on' (previous on line 193)
drivers/gpu/drm/amd/amdgpu/../display/dc/dcn35/dcn35_pg_cntl.c:318 pg_cntl35_io_clk_pg_control() warn: duplicate check 'power_on' (previous on line 312)
drivers/gpu/drm/amd/amdgpu/../display/dc/dcn35/dcn35_pg_cntl.c:404 pg_cntl35_plane_otg_pg_control() warn: duplicate check 'power_on' (previous on line 398)
drivers/gpu/drm/amd/amdgpu/../display/dc/dcn35/dcn35_resource.c:1877 dcn35_resource_construct() warn: inconsistent indenting
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn35/dcn35_fpu.c:260 dcn35_update_bw_bounding_box_fpu() warn: inconsistent indenting
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn35/dcn35_fpu.c:351 dcn35_update_bw_bounding_box_fpu() warn: inconsistent indenting
drivers/gpu/drm/amd/amdgpu/../display/dmub/src/dmub_srv.c:355 dmub_srv_hw_setup() warn: inconsistent indenting
drivers/gpu/drm/amd/amdgpu/nbio_v7_11.c:34 nbio_v7_11_get_rev_id() warn: inconsistent indenting
drivers/gpu/drm/amd/amdgpu/../pm/swsmu/smu13/smu_v13_0_6_ppt.c:351 smu_v13_0_6_setup_driver_pptable() warn: should this be 'retry == -1'
