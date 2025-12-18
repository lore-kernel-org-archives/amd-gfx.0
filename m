Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CA2BD68BFC
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Dec 2025 09:00:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0539F10E845;
	Thu, 18 Dec 2025 09:00:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Q/D04PMY";
	dkim-atps=neutral
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com
 [209.85.128.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 53BC210E142
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Dec 2025 07:49:22 +0000 (UTC)
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-47a95efd2ceso2559205e9.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Dec 2025 23:49:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766044161; x=1766648961; darn=lists.freedesktop.org;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :from:to:cc:subject:date:message-id:reply-to;
 bh=pPlR0S4j+usr/LWTw5hQzuiVy1gsCKzfBkT6LLNHn78=;
 b=Q/D04PMYqDZ65BOe6a64HhGJOwYc+udOb6u1Ky9xzeq2FT/OfR1cWSPFYysKxdW3Yl
 BHt2SOZK1omSAXvZMwFVY9jFGZkc1/WyyX8NBEaiS3slqTjJLXv4Imcj6YQi66X0LLMf
 Qag68QThN22xFhvqXU9J1EhR873lQ8lfTjF37E05peiXbOXCmaACuZ598tOm9T32YRP1
 X/CuoQw9UYP9dIi/Ynvq4RS3UQ8M19J53XnH89GJwo4gKyYMffgcXXQvef45R1dPk9Lg
 4iWyZQd+yokJILv+nexzRgGhTTKhsp0+2kPrevA3eRjxCs/PD4l9QA4pCwke+R2A5s00
 sh9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766044161; x=1766648961;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pPlR0S4j+usr/LWTw5hQzuiVy1gsCKzfBkT6LLNHn78=;
 b=R1+3/x4BNBnhXutt24ISiCSX2701FIVDV5gYVh6eB35AEiVz0vJI09l+DikCai5e8T
 5tolTwiRgsaJh+CTrOhc6GuNZ2UocCibcBGL1vjGHYXrKbFG8Aexxt+ZI4Nww9HvO8qi
 u/i2Jcl0wQyzdBJKSL7v8uHDcm9LyRtCk5jBLHPpAxO1XSrYl5CQMWOmqVBTEvf/Dl6L
 H1dZbo1Zp9a9Ym3wv+eCgm20HfR+wxr/I3aOdeOPOKzq99izFV5TzTzoZ9Xs+2u+nrRf
 FApYJjKUE2ePLVYjsJ5B4U2t4CH4toh8cCp58ypZAkVvQ6CCWZyJC/4LnSrKFcIPoHch
 UZWA==
X-Gm-Message-State: AOJu0YzuKpFzMsNXB2Wu1ZwkeFgQ2M0YoC2TmZJhQzWYEEGYJ0HwtqEG
 2xraiVQTK6ih/ovrQ1WIAy0tEHxR8SlrUOHYyMW6HP9KTz1syKdNbsjOI1BA5OGjJF8=
X-Gm-Gg: AY/fxX6ssimSxQYyjvrsuKrN9bK28SDAu00frHT6T0Zaokfh+ZwLGnPrwQ9HFyUoRin
 3FkuMubO6QC+GSalrTrrzapHbSDyYDeKcV+LiO18ZMvZffu1TubHf//PDLmAvjNPrKQGZFVCC55
 GDbpMEAmyMcPMJxNRlde8iN0ybgftQ4tJXlNssJTwnP/fGrPblPESVJ9h2EDZAo903VIkV6lcWA
 HpWq5lo2GMQ/jOZcxKv9jK07VqqCIXUoWwPrlHLIYZdnUYvNh6wlrOtEX/IgeAgvH/WRq9CRc6W
 GL4P2sKoxYoLQj1kT/wcW6UD3NDGCmsZIulLTWGlXcR7AFZcPt8ikYT46POqPKSXOPn/M2J3XKp
 TalfecEnIxV2Tn+IrTiqXUGZ+bXgnRj+++LncRXP4XTOZ2Mhba06Wg9gxXL0+CwNFmOyWR32Sd5
 eLVm7fwwCURlTAHPWGdSkXVhXftlw=
X-Google-Smtp-Source: AGHT+IFDLPvYn1AhU18ZsEiWGFSaB9O9eErWzbcGCcMwPlk8hH/eRfC1z0XgDHyuV5Fx1ZF4Ikd6nw==
X-Received: by 2002:a05:600c:45c9:b0:46e:35a0:3587 with SMTP id
 5b1f17b1804b1-47a8f90c516mr210603205e9.27.1766044160699; 
 Wed, 17 Dec 2025 23:49:20 -0800 (PST)
Received: from localhost ([196.207.164.177]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47be2f7b0f7sm26832855e9.0.2025.12.17.23.49.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Dec 2025 23:49:20 -0800 (PST)
Date: Thu, 18 Dec 2025 10:49:17 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Monk Liu <Monk.Liu@amd.com>
Cc: amd-gfx@lists.freedesktop.org,
 "SHANMUGAM, SRINIVASAN" <SRINIVASAN.SHANMUGAM@amd.com>
Subject: [bug report] drm/amdgpu: implement initialization part on VCN2.0 for
 SRIOV
Message-ID: <aUOx_SgFJIjuILtY@stanley.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailman-Approved-At: Thu, 18 Dec 2025 09:00:47 +0000
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

Hello Monk Liu,

Commit dd26858a9cd8 ("drm/amdgpu: implement initialization part on
VCN2.0 for SRIOV") from Mar 5, 2020 (linux-next), leads to the
following Smatch static checker warning:

	drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c:1967 vcn_v2_0_start_sriov()
	warn: iterator 'i' not incremented

drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
  1955  static int vcn_v2_0_start_sriov(struct amdgpu_device *adev)
  1956  {
  1957          int r;
  1958          uint32_t tmp;
  1959          struct amdgpu_ring *ring;
  1960          uint32_t offset, size;
  1961          uint32_t table_size = 0;
  1962          struct mmsch_v2_0_cmd_direct_write direct_wt = { {0} };
  1963          struct mmsch_v2_0_cmd_direct_read_modify_write direct_rd_mod_wt = { {0} };
  1964          struct mmsch_v2_0_cmd_end end = { {0} };
  1965          struct mmsch_v2_0_init_header *header;
  1966          uint32_t *init_table = adev->virt.mm_table.cpu_addr;
  1967          uint8_t i = 0;

i is always just zero.  What's the dealio, yo?

  1968  
  1969          header = (struct mmsch_v2_0_init_header *)init_table;
  1970          direct_wt.cmd_header.command_type = MMSCH_COMMAND__DIRECT_REG_WRITE;
  1971          direct_rd_mod_wt.cmd_header.command_type =
  1972                  MMSCH_COMMAND__DIRECT_REG_READ_MODIFY_WRITE;
  1973          end.cmd_header.command_type = MMSCH_COMMAND__END;
  1974  
  1975          if (header->vcn_table_offset == 0 && header->vcn_table_size == 0) {
  1976                  header->version = MMSCH_VERSION;
  1977                  header->header_size = sizeof(struct mmsch_v2_0_init_header) >> 2;
  1978  
  1979                  header->vcn_table_offset = header->header_size;
  1980  
  1981                  init_table += header->vcn_table_offset;
  1982  
  1983                  size = AMDGPU_GPU_PAGE_ALIGN(adev->vcn.inst[0].fw->size + 4);
  1984  
  1985                  MMSCH_V2_0_INSERT_DIRECT_RD_MOD_WT(
  1986                          SOC15_REG_OFFSET(UVD, i, mmUVD_STATUS),
  1987                          0xFFFFFFFF, 0x00000004);
  1988  
  1989                  /* mc resume*/
  1990                  if (adev->firmware.load_type == AMDGPU_FW_LOAD_PSP) {
  1991                          MMSCH_V2_0_INSERT_DIRECT_WT(
  1992                                  SOC15_REG_OFFSET(UVD, i,
  1993                                          mmUVD_LMI_VCPU_CACHE_64BIT_BAR_LOW),
  1994                                  adev->firmware.ucode[AMDGPU_UCODE_ID_VCN].tmr_mc_addr_lo);
  1995                          MMSCH_V2_0_INSERT_DIRECT_WT(
  1996                                  SOC15_REG_OFFSET(UVD, i,
  1997                                          mmUVD_LMI_VCPU_CACHE_64BIT_BAR_HIGH),
  1998                                  adev->firmware.ucode[AMDGPU_UCODE_ID_VCN].tmr_mc_addr_hi);
  1999                          offset = 0;
  2000                  } else {
  2001                          MMSCH_V2_0_INSERT_DIRECT_WT(
  2002                                  SOC15_REG_OFFSET(UVD, i,
  2003                                          mmUVD_LMI_VCPU_CACHE_64BIT_BAR_LOW),
  2004                                  lower_32_bits(adev->vcn.inst->gpu_addr));
  2005                          MMSCH_V2_0_INSERT_DIRECT_WT(
  2006                                  SOC15_REG_OFFSET(UVD, i,
  2007                                          mmUVD_LMI_VCPU_CACHE_64BIT_BAR_HIGH),
  2008                                  upper_32_bits(adev->vcn.inst->gpu_addr));
  2009                          offset = size;
  2010                  }
  2011  
  2012                  MMSCH_V2_0_INSERT_DIRECT_WT(
  2013                          SOC15_REG_OFFSET(UVD, i, mmUVD_VCPU_CACHE_OFFSET0),
  2014                          0);
  2015                  MMSCH_V2_0_INSERT_DIRECT_WT(
  2016                          SOC15_REG_OFFSET(UVD, i, mmUVD_VCPU_CACHE_SIZE0),
  2017                          size);
  2018  
  2019                  MMSCH_V2_0_INSERT_DIRECT_WT(
  2020                          SOC15_REG_OFFSET(UVD, i,
  2021                                  mmUVD_LMI_VCPU_CACHE1_64BIT_BAR_LOW),
  2022                          lower_32_bits(adev->vcn.inst->gpu_addr + offset));
  2023                  MMSCH_V2_0_INSERT_DIRECT_WT(
  2024                          SOC15_REG_OFFSET(UVD, i,
  2025                                  mmUVD_LMI_VCPU_CACHE1_64BIT_BAR_HIGH),
  2026                          upper_32_bits(adev->vcn.inst->gpu_addr + offset));
  2027                  MMSCH_V2_0_INSERT_DIRECT_WT(
  2028                          SOC15_REG_OFFSET(UVD, i, mmUVD_VCPU_CACHE_OFFSET1),
  2029                          0);
  2030                  MMSCH_V2_0_INSERT_DIRECT_WT(
  2031                          SOC15_REG_OFFSET(UVD, i, mmUVD_VCPU_CACHE_SIZE1),
  2032                          AMDGPU_VCN_STACK_SIZE);
  2033  
  2034                  MMSCH_V2_0_INSERT_DIRECT_WT(
  2035                          SOC15_REG_OFFSET(UVD, i,
  2036                                  mmUVD_LMI_VCPU_CACHE2_64BIT_BAR_LOW),
  2037                          lower_32_bits(adev->vcn.inst->gpu_addr + offset +
  2038                                  AMDGPU_VCN_STACK_SIZE));
  2039                  MMSCH_V2_0_INSERT_DIRECT_WT(
  2040                          SOC15_REG_OFFSET(UVD, i,
  2041                                  mmUVD_LMI_VCPU_CACHE2_64BIT_BAR_HIGH),
  2042                          upper_32_bits(adev->vcn.inst->gpu_addr + offset +
  2043                                  AMDGPU_VCN_STACK_SIZE));
  2044                  MMSCH_V2_0_INSERT_DIRECT_WT(
  2045                          SOC15_REG_OFFSET(UVD, i, mmUVD_VCPU_CACHE_OFFSET2),
  2046                          0);
  2047                  MMSCH_V2_0_INSERT_DIRECT_WT(
  2048                          SOC15_REG_OFFSET(UVD, i, mmUVD_VCPU_CACHE_SIZE2),
  2049                          AMDGPU_VCN_CONTEXT_SIZE);
  2050  
  2051                  for (r = 0; r < adev->vcn.inst[0].num_enc_rings; ++r) {
  2052                          ring = &adev->vcn.inst->ring_enc[r];
  2053                          ring->wptr = 0;
  2054                          MMSCH_V2_0_INSERT_DIRECT_WT(
  2055                                  SOC15_REG_OFFSET(UVD, i, mmUVD_RB_BASE_LO),
  2056                                  lower_32_bits(ring->gpu_addr));
  2057                          MMSCH_V2_0_INSERT_DIRECT_WT(
  2058                                  SOC15_REG_OFFSET(UVD, i, mmUVD_RB_BASE_HI),
  2059                                  upper_32_bits(ring->gpu_addr));
  2060                          MMSCH_V2_0_INSERT_DIRECT_WT(
  2061                                  SOC15_REG_OFFSET(UVD, i, mmUVD_RB_SIZE),
  2062                                  ring->ring_size / 4);
  2063                  }
  2064  
  2065                  ring = &adev->vcn.inst->ring_dec;
  2066                  ring->wptr = 0;
  2067                  MMSCH_V2_0_INSERT_DIRECT_WT(
  2068                          SOC15_REG_OFFSET(UVD, i,
  2069                                  mmUVD_LMI_RBC_RB_64BIT_BAR_LOW),
  2070                          lower_32_bits(ring->gpu_addr));
  2071                  MMSCH_V2_0_INSERT_DIRECT_WT(
  2072                          SOC15_REG_OFFSET(UVD, i,
  2073                                  mmUVD_LMI_RBC_RB_64BIT_BAR_HIGH),
  2074                          upper_32_bits(ring->gpu_addr));
  2075                  /* force RBC into idle state */
  2076                  tmp = order_base_2(ring->ring_size);
  2077                  tmp = REG_SET_FIELD(0, UVD_RBC_RB_CNTL, RB_BUFSZ, tmp);
  2078                  tmp = REG_SET_FIELD(tmp, UVD_RBC_RB_CNTL, RB_BLKSZ, 1);
  2079                  tmp = REG_SET_FIELD(tmp, UVD_RBC_RB_CNTL, RB_NO_FETCH, 1);
  2080                  tmp = REG_SET_FIELD(tmp, UVD_RBC_RB_CNTL, RB_NO_UPDATE, 1);
  2081                  tmp = REG_SET_FIELD(tmp, UVD_RBC_RB_CNTL, RB_RPTR_WR_EN, 1);
  2082                  MMSCH_V2_0_INSERT_DIRECT_WT(
  2083                          SOC15_REG_OFFSET(UVD, i, mmUVD_RBC_RB_CNTL), tmp);
  2084  
  2085                  /* add end packet */
  2086                  tmp = sizeof(struct mmsch_v2_0_cmd_end);
  2087                  memcpy((void *)init_table, &end, tmp);
  2088                  table_size += (tmp / 4);
  2089                  header->vcn_table_size = table_size;
  2090  
  2091          }
  2092          return vcn_v2_0_start_mmsch(adev, &adev->virt.mm_table);
  2093  }

regards,
dan carpenter
