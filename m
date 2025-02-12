Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35E57C02198
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Feb 2025 14:08:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 984AC10E31E;
	Wed, 12 Feb 2025 14:08:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="WYD+REfZ";
	dkim-atps=neutral
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com
 [209.85.208.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 03D9F10E7ED
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Feb 2025 08:09:01 +0000 (UTC)
Received: by mail-ed1-f49.google.com with SMTP id
 4fb4d7f45d1cf-5de6ff9643fso6269451a12.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Feb 2025 00:09:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739347740; x=1739952540; darn=lists.freedesktop.org;
 h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
 :to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=DvXcYW1MKztDl/tRYElqJoXD5IkRoH7LOQ+vHwT06FQ=;
 b=WYD+REfZUOD9qRvG+zCMuOrhZ3ZyLzZi0zVYdYvpKVA2JlZgjtDAz5Fkh9ImTSeXO+
 vLBkTQdXaBjF1akDsYcIQ44Mgfs24gXxYFqkr3siOX2Hh6f/15d9zpzMMUdFPFZf8Y0t
 h7d3P6VxqPdW2x29pTzoEQnTEcCp35dDcxd2CyLlST+Fi8HBi9ye5AKMiRIEDyRNeaLp
 gP746EYE4zzyj9negy7lHICDVZ8AFXppQ74r/KJiPgftCcjvs7zRHN1jLC5+J9Wqji7n
 znuOJkAsax/IA9XQiMDnskxhV7AU/TTO/gzWOKpjkxj3pVCjmbGJR7S1q1vyiktPUaGc
 T/Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739347740; x=1739952540;
 h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
 :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=DvXcYW1MKztDl/tRYElqJoXD5IkRoH7LOQ+vHwT06FQ=;
 b=WpC8vv+EflEfAjSVToMPbh+K1XH2lCwb5oHOFvw2IcFUZlSvU0m9e4MbPvsLgNfx9y
 8cIxrv2DAgTugi+QaVwf2JyU3ydZQXO5WyEWlXMZTEUfsLrg3iwBiBBaA4DX2eaRyFae
 7W7B5jY+ox3i8rwenAUlLdBaCLCo6g1zNWxdp2+Z1pPiszZbjsao9pglzu283tZlWa5J
 SkEy5UoetJ6nKVg4wZvwrDWK6L5o7Op/1uKmAIzzzSx2gCbS1WhSlM1epZT/zieN3JO4
 FeYSG2z+tmsBKnFDTi3wXt9uXeM4fZZVGIF288oIRN+pCsHVt2yqY3PMhdroXSe7zC89
 kU1g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWvY7+aM1cEZcfDmQ+V3HH0m+QQ2+TyrqtJebGt7yYxByjpYRQ03et7bRewXGw0eCtx0fSDQp1V@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwpgR2WjiZPhHeeyReZy18rEoQGLGnlkYRNiGVANxqnua4WO2hK
 ciEBBJWFcXXEMUzqP9gSEmY+Tk8Rk1ih+8Ew+xOL/qcFZQQDLPd8vGw5qLp+EnA=
X-Gm-Gg: ASbGncvOA6jGt0hUGZo2Co4hDAyRgISdF9PbxGexVh0py9gsg/7ETtwmBB1+yZ5atmF
 Igd9+RyRcWYCytJ1F6y0iZLuwuoFqf4zNsdJriJrN8RbiLq3C1tcm8ixYjivwIAblKfRmDKfXcC
 9OdYquUeDbG1qix/kufSnr1GdrTmIb+LAmWTdwDwtLZ7I8FwGlvqXsN4C8WA/fyFGJO3BOWmbCZ
 CFhsPlonnyJdhh98mSlEEOis+YRgtXHuhieUY1Ka05uzr1HTs5yCLvDMIpy25xVq5J5OG3n8CJB
 hQ3IZq8ZDXJwi+6EJHbH
X-Google-Smtp-Source: AGHT+IFbvgL16Ql7hM3shlk1MJkm5T6QdHnfS2u0kU96lZQKTswY5nVLhhE0KAeP0UU4pKwvyLBkYA==
X-Received: by 2002:a05:6402:26d3:b0:5db:f423:19c5 with SMTP id
 4fb4d7f45d1cf-5deadd7b8c3mr1650639a12.5.1739347740274; 
 Wed, 12 Feb 2025 00:09:00 -0800 (PST)
Received: from localhost ([196.207.164.177])
 by smtp.gmail.com with UTF8SMTPSA id
 4fb4d7f45d1cf-5de45a92fa7sm10133870a12.23.2025.02.12.00.08.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Feb 2025 00:08:59 -0800 (PST)
Date: Wed, 12 Feb 2025 11:08:56 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: oe-kbuild@lists.linux.dev, Melissa Wen <mwen@igalia.com>,
 harry.wentland@amd.com, sunpeng.li@amd.com,
 Rodrigo.Siqueira@amd.com, alexander.deucher@amd.com,
 christian.koenig@amd.com, Xinhui.Pan@amd.com, airlied@gmail.com,
 simona@ffwll.ch, alex.hung@amd.com, mario.limonciello@amd.com
Cc: lkp@intel.com, oe-kbuild-all@lists.linux.dev,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 kernel-dev@igalia.com
Subject: Re: [PATCH] drm/amd/display: restore edid reading from a given i2c
 adapter
Message-ID: <63cd70b2-895c-4475-b154-cf4e041e43d6@stanley.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250209225843.7412-1-mwen@igalia.com>
X-Mailman-Approved-At: Wed, 12 Feb 2025 14:08:23 +0000
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

Hi Melissa,

kernel test robot noticed the following build warnings:

https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Melissa-Wen/drm-amd-display-restore-edid-reading-from-a-given-i2c-adapter/20250210-070016
base:   https://git.kernel.org/pub/scm/linux/kernel/git/daeinki/drm-exynos.git exynos-drm-next
patch link:    https://lore.kernel.org/r/20250209225843.7412-1-mwen%40igalia.com
patch subject: [PATCH] drm/amd/display: restore edid reading from a given i2c adapter
config: x86_64-randconfig-161-20250211 (https://download.01.org/0day-ci/archive/20250212/202502121000.EBCEdoo9-lkp@intel.com/config)
compiler: clang version 19.1.3 (https://github.com/llvm/llvm-project ab51eccf88f5321e7c60591c5546b254b6afab99)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
| Closes: https://lore.kernel.org/r/202502121000.EBCEdoo9-lkp@intel.com/

New smatch warnings:
drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:7201 amdgpu_dm_connector_funcs_force() warn: variable dereferenced before check 'dc_link' (see line 7187)

Old smatch warnings:
drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:12110 parse_edid_displayid_vrr() warn: variable dereferenced before check 'edid_ext' (see line 12106)

vim +/dc_link +7201 drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c

dae343b343ff741 Arnd Bergmann 2023-05-01  7179  static void amdgpu_dm_connector_funcs_force(struct drm_connector *connector)
0ba4a784a14592a Alex Hung     2023-04-05  7180  {
0ba4a784a14592a Alex Hung     2023-04-05  7181  	struct amdgpu_dm_connector *aconnector = to_amdgpu_dm_connector(connector);
0ba4a784a14592a Alex Hung     2023-04-05  7182  	struct dc_link *dc_link = aconnector->dc_link;
0ba4a784a14592a Alex Hung     2023-04-05  7183  	struct dc_sink *dc_em_sink = aconnector->dc_em_sink;
48edb2a4256eedf Melissa Wen   2024-09-27  7184  	const struct drm_edid *drm_edid;
be1aae525741575 Melissa Wen   2025-02-09  7185  	struct i2c_adapter *ddc;
0ba4a784a14592a Alex Hung     2023-04-05  7186  
be1aae525741575 Melissa Wen   2025-02-09 @7187  	if (dc_link->aux_mode)
                                                            ^^^^^^^^^^^^^^^^^
Unchecked dereference

be1aae525741575 Melissa Wen   2025-02-09  7188  		ddc = &aconnector->dm_dp_aux.aux.ddc;
be1aae525741575 Melissa Wen   2025-02-09  7189  	else
be1aae525741575 Melissa Wen   2025-02-09  7190  		ddc = &aconnector->i2c->base;
be1aae525741575 Melissa Wen   2025-02-09  7191  
be1aae525741575 Melissa Wen   2025-02-09  7192  	drm_edid = drm_edid_read_ddc(connector, ddc);
48edb2a4256eedf Melissa Wen   2024-09-27  7193  	drm_edid_connector_update(connector, drm_edid);
48edb2a4256eedf Melissa Wen   2024-09-27  7194  	if (!drm_edid) {
0e859faf8670a78 Alex Hung     2023-08-25  7195  		DRM_ERROR("No EDID found on connector: %s.\n", connector->name);
0ba4a784a14592a Alex Hung     2023-04-05  7196  		return;
0e859faf8670a78 Alex Hung     2023-08-25  7197  	}
0ba4a784a14592a Alex Hung     2023-04-05  7198  
48edb2a4256eedf Melissa Wen   2024-09-27  7199  	aconnector->drm_edid = drm_edid;
0ba4a784a14592a Alex Hung     2023-04-05  7200  	/* Update emulated (virtual) sink's EDID */
0ba4a784a14592a Alex Hung     2023-04-05 @7201  	if (dc_em_sink && dc_link) {
                                                                          ^^^^^^^
This code assumes dc_link can be NULL

48edb2a4256eedf Melissa Wen   2024-09-27  7202  		// FIXME: Get rid of drm_edid_raw()
48edb2a4256eedf Melissa Wen   2024-09-27  7203  		const struct edid *edid = drm_edid_raw(drm_edid);
48edb2a4256eedf Melissa Wen   2024-09-27  7204  
0ba4a784a14592a Alex Hung     2023-04-05  7205  		memset(&dc_em_sink->edid_caps, 0, sizeof(struct dc_edid_caps));
48edb2a4256eedf Melissa Wen   2024-09-27  7206  		memmove(dc_em_sink->dc_edid.raw_edid, edid,
48edb2a4256eedf Melissa Wen   2024-09-27  7207  			(edid->extensions + 1) * EDID_LENGTH);
0ba4a784a14592a Alex Hung     2023-04-05  7208  		dm_helpers_parse_edid_caps(
0ba4a784a14592a Alex Hung     2023-04-05  7209  			dc_link,
0ba4a784a14592a Alex Hung     2023-04-05  7210  			&dc_em_sink->dc_edid,
0ba4a784a14592a Alex Hung     2023-04-05  7211  			&dc_em_sink->edid_caps);
0ba4a784a14592a Alex Hung     2023-04-05  7212  	}
0ba4a784a14592a Alex Hung     2023-04-05  7213  }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

