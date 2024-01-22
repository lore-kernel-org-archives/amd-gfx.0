Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD813C47DDC
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Jan 2024 12:04:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2183710F032;
	Tue, 23 Jan 2024 12:04:52 +0000 (UTC)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com
 [209.85.128.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 95ABA10E657
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Jan 2024 09:16:48 +0000 (UTC)
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-40ea5653f6bso21854895e9.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Jan 2024 01:16:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705914947; x=1706519747; darn=lists.freedesktop.org;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :from:to:cc:subject:date:message-id:reply-to;
 bh=JSJ7VruC7bi2nALb/EmcULYDuICQTeEcPYoZ2NUOQbw=;
 b=uwK/68j89IPr+Hg7HFlXA/A/jtZiU3ga7Bn8KwGz8lHi7KJiIQKmiShFGbo9P5z1nO
 +pCK7TYje1EXg66pF/ONkHYYTjvQ/kZFtSTzcpWmzZK5wrN0KV3rUYH8zqbKyDiRiK0B
 zSOK9H9wYqL5PEq0bXrjKJ1ChJ7i1XFAEGADlCZPBY4O2SghXxASCdXP3mlnk8KqXXwU
 PI1Izl7kZRo+FL85OHqx1+wb9+7aNkOx582jEcQJxgMrD4ogpYxyxkHgh5h9VE+sBsnM
 /eKIoKhh84fQ/dxTOCi7AnL3+wV94lk0uuXK2wk509MZOeaK5SBrmjl5GunFJBlGrvDv
 AG0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705914947; x=1706519747;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=JSJ7VruC7bi2nALb/EmcULYDuICQTeEcPYoZ2NUOQbw=;
 b=JGD8WTYjfi/vR2LJH8XA3shdAA3eDd+zhi0vlgXpsZ2fbdN+NAPJuZDUhdpKf+58QZ
 1IYMTVzRTyYsQMQ6bZMApjbYX48Rn74RD5tPEQ/EfOIY10wZhhrQN5tD9+INKWi+ET93
 Gqpy6dYG/3518HGc4ElFWJimMfN6gnRy9j+a7a8mfFqB7Z3hOi/ZHZUhZiAV9bIrZIaJ
 5IXA1AoNOfJN17JHLGzvM7FIDfmouUYvCyoNtdFz9bpMJa+h0dBc3WvwqR1MMx9h0CST
 IsvaBCFZ07B3x2m8ozc/O9PTAX1FCbvmpnkWL7u66vt4fj/x3tD2XjmYXNj9n/PpF4M6
 hR6A==
X-Gm-Message-State: AOJu0YzOZjQ3SpJ/M6H6MIDwz0Me7+5gVI08u1SF+188I2SQ0aRfSbeU
 /mN7AJDbqfMPnW0FDTGThoPNDZaU9u/Vh+Z/tAtVTCHfXkSOnVK0PDWXRyFFd1s=
X-Google-Smtp-Source: AGHT+IFreBKad7C/PYy1DBUu1MwdS6tfn0AE6P4Uo31Rhc1rGaB4WNGWnDWIuoFrYBgcLlCN1oJYBg==
X-Received: by 2002:a05:600c:291:b0:40e:44de:d2a9 with SMTP id
 17-20020a05600c029100b0040e44ded2a9mr2296035wmk.208.1705914947029; 
 Mon, 22 Jan 2024 01:15:47 -0800 (PST)
Received: from localhost ([102.140.209.237]) by smtp.gmail.com with ESMTPSA id
 b1-20020a5d6341000000b0033930b9a2b1sm3400633wrw.26.2024.01.22.01.15.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jan 2024 01:15:46 -0800 (PST)
Date: Mon, 22 Jan 2024 12:15:43 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: meenakshikumar.somasundaram@amd.com
Subject: [bug report] drm/amd/display: Add dpia display mode validation logic
Message-ID: <53d04b9e-e237-42c8-b7d2-6d7d4c1e1dab@moroto.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailman-Approved-At: Tue, 23 Jan 2024 12:04:50 +0000
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

Hello Meenakshikumar Somasundaram,

The patch 59f1622a5f05: "drm/amd/display: Add dpia display mode
validation logic" from Dec 5, 2023 (linux-next), leads to the
following Smatch static checker warning:

	drivers/gpu/drm/amd/amdgpu/../display/dc/link/protocols/link_dp_dpia_bw.c:208 get_host_router_total_dp_tunnel_bw()
	error: buffer overflow 'dc->links' 12 <= 12

drivers/gpu/drm/amd/amdgpu/../display/dc/link/protocols/link_dp_dpia_bw.c
    192 static int get_host_router_total_dp_tunnel_bw(const struct dc *dc, uint8_t hr_index)
    193 {
    194         uint8_t lowest_dpia_index = get_lowest_dpia_index(dc->links[0]);
    195         uint8_t hr_index_temp = 0;
    196         struct dc_link *link_dpia_primary, *link_dpia_secondary;
    197         int total_bw = 0;
    198 
    199         for (uint8_t i = 0; i < MAX_PIPES * 2; ++i) {
    200 
    201                 if (!dc->links[i] || dc->links[i]->ep_type != DISPLAY_ENDPOINT_USB4_DPIA)
    202                         continue;
    203 
    204                 hr_index_temp = (dc->links[i]->link_index - lowest_dpia_index) / 2;
    205 
    206                 if (hr_index_temp == hr_index) {
    207                         link_dpia_primary = dc->links[i];
--> 208                         link_dpia_secondary = dc->links[i + 1];

Imagine "i = MAX_PIPES * 2 - 1" then that means [i + 1] is out of
bounds.

    209 
    210                         /**
    211                          * If BW allocation enabled on both DPIAs, then
    212                          * HR BW = Estimated(dpia_primary) + Allocated(dpia_secondary)
    213                          * otherwise HR BW = Estimated(bw alloc enabled dpia)
    214                          */
    215                         if ((link_dpia_primary->hpd_status &&
    216                                 link_dpia_primary->dpia_bw_alloc_config.bw_alloc_enabled) &&
    217                                 (link_dpia_secondary->hpd_status &&
    218                                 link_dpia_secondary->dpia_bw_alloc_config.bw_alloc_enabled)) {
    219                                         total_bw += link_dpia_primary->dpia_bw_alloc_config.estimated_bw +
    220                                                 link_dpia_secondary->dpia_bw_alloc_config.allocated_bw;
    221                         } else if (link_dpia_primary->hpd_status &&
    222                                         link_dpia_primary->dpia_bw_alloc_config.bw_alloc_enabled) {
    223                                 total_bw = link_dpia_primary->dpia_bw_alloc_config.estimated_bw;
    224                         } else if (link_dpia_secondary->hpd_status &&
    225                                 link_dpia_secondary->dpia_bw_alloc_config.bw_alloc_enabled) {
    226                                 total_bw += link_dpia_secondary->dpia_bw_alloc_config.estimated_bw;
    227                         }
    228                         break;
    229                 }
    230         }
    231 
    232         return total_bw;
    233 }

regards,
dan carpenter
