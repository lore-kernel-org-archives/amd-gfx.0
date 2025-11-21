Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0600CFC279
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Nov 2025 13:48:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9F02B10E87D;
	Fri, 21 Nov 2025 13:48:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="VEIJ8owk";
	dkim-atps=neutral
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com
 [209.85.128.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 49AAD10E86E
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Nov 2025 13:35:47 +0000 (UTC)
Received: by mail-wm1-f53.google.com with SMTP id
 5b1f17b1804b1-4775895d69cso9053715e9.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Nov 2025 05:35:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763732146; x=1764336946; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-disposition:mime-version
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JQTDlLSHya5ZJFcSZ4CgYKRRhdfnceV1QeecZlmRQYU=;
 b=VEIJ8owkAXLuzL+gvHxCcZm9Hk4d/w0/t9mvBfDAx9GD/kAxbzlEfnPwYxYERsIa36
 kwf70pIKxx7nUO2nYJxDdOQWzIJTxsiZAHnUU8rNp5GhKv7N4fCSEPPrFHUG24yQ3Nd8
 HMbos7iZQyx7/0m7NjoIkm0/2uuA7PUBpYI4ktlir0BqVvtcrV0BioiycMEmsfBcyTE+
 paOFrs+0cBJxqRIH3cjlKWKcnO5hew8vECg/cEZ0RLUgYdphVH5L0Pdjkx0kEF6B33G2
 dEppf3TLPA5wSkiVOFA2XTKCsiPQVg00chsq1N2SCn5YW6R9LtwE69qA6df4af927WlF
 bXeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763732146; x=1764336946;
 h=content-transfer-encoding:content-disposition:mime-version
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=JQTDlLSHya5ZJFcSZ4CgYKRRhdfnceV1QeecZlmRQYU=;
 b=gIA9tZxNOXQ/HfYWKz0xes0rWhs2Ut+IjS7DL421Ih7ZsTx4BY20mpeO6+sPeY7meS
 XlOvR4jMJxfErPR7g6LdpqVbQn1nGCfXxmvT7MWbhLBlggxX0zEn1z7kItfP9buyiMkz
 kYg7RBy+y7ZDD1uDlrp/HDIHax5KURVeB5IgWKJECSULQtrxBt6alub6qZlvZ01QblGE
 lbNe7ozkyMYsXdBDAkc26y6ZJo2q37LjVBcRHaF2wQ7Srw+TYwUXMZwT52+lTL5BlK7E
 JKlI5A4xc1qFRJoZ6WA/y8jl2ag3Uerklog9d3i3Z7iT530s9edaUkQa6Imhl/RMma0h
 Ic0Q==
X-Gm-Message-State: AOJu0Yyhhva14384Ozjq/kWe4b0ZG3rKXins5d42FUsvIVw55y5MfBNF
 TlrIhcxDjLmMqP8KsGcuvB+3t/ZQmylOGxT8m/S9dM5HoEYErw+m2ZeeLkUNFH7Qygs=
X-Gm-Gg: ASbGncu1rn93o/5ogQoeyjDG+YJd5mo5NXYiRqV/ezQkp70Z9r+X1/jZJ4O2+3RWGaX
 etSCmG1/422hlkCZgLRcZJchX1xxDZGwvm3+ErTGFPnJghels8GFsvzG/YyhfXWOE7ffEDMjKzi
 qMFq6KwVuTsZH1Ussi4ELJpk4BxXDOAaYkqOIk0qvyre0aIdHcbiZvmx4oS/kmnMSR9NvxZgeqj
 xhJeYzbwqjDRfgmNVEEOgRqLkZo7yrlX2pfqVXIufsudsWShKrCy4UrEptlb2fDZQJS9RcJ1ojn
 zA2i2bULB2jw+sl1lEZ9P8UefjMhRmJ2LRx0EP6aICQHlBReev6oomJnxdM2DbMwe5hUNG1fhW1
 HUPj2iK2ANsWw66atA6Qg3HNjR34II/PIENjGd5FWydm98zYSC/gdgTMXvX8zclBgJRt8d6/YHO
 EplGMFJ7zwAbOrAuM7/AzLoTJsJHQ=
X-Google-Smtp-Source: AGHT+IF48UZsl84AvUaz0yRQwq1RSA9byQE0yoohws0P1EphOv9uOpY2K7n/i7Twry36Uhm8udlIkQ==
X-Received: by 2002:a05:600c:354f:b0:477:641a:1402 with SMTP id
 5b1f17b1804b1-477c016e74bmr26120025e9.4.1763732145659; 
 Fri, 21 Nov 2025 05:35:45 -0800 (PST)
Received: from localhost ([196.207.164.177])
 by smtp.gmail.com with UTF8SMTPSA id
 ffacd0b85a97d-42cb7f3635bsm11262391f8f.17.2025.11.21.05.35.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Nov 2025 05:35:45 -0800 (PST)
Date: Fri, 21 Nov 2025 16:35:42 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Timur =?iso-8859-1?Q?Krist=F3f?= <timur.kristof@gmail.com>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 "SHANMUGAM, SRINIVASAN" <SRINIVASAN.SHANMUGAM@amd.com>
Subject: [bug report] drm/amd/display: Cleanup uses of the analog flag
Message-ID: <aSBqrjTkmpMhLJmF@stanley.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 21 Nov 2025 13:48:32 +0000
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

Hello Timur Kristóf,

This is a semi-automatic email about new static checker warnings.

Commit d46e422f65ae ("drm/amd/display: Cleanup uses of the analog
flag") from Nov 13, 2025, leads to the following Smatch complaint:

    drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:8858 amdgpu_dm_connector_get_modes()
    warn: variable dereferenced before check 'amdgpu_dm_connector->dc_link' (see line 8846)

drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c
  8845				&amdgpu_dm_connector->dc_link->verified_link_cap;
  8846		const struct dc *dc = amdgpu_dm_connector->dc_link->dc;
                                      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Dereference

  8847	
  8848		encoder = amdgpu_dm_connector_to_encoder(connector);
  8849	
  8850		if (!drm_edid) {
  8851			amdgpu_dm_connector->num_modes =
  8852					drm_add_modes_noedid(connector, 640, 480);
  8853			if (dc->link_srv->dp_get_encoding_format(verified_link_cap) == DP_128b_132b_ENCODING)
  8854				amdgpu_dm_connector->num_modes +=
  8855					drm_add_modes_noedid(connector, 1920, 1080);
  8856	
  8857			if (amdgpu_dm_connector->dc_sink &&
  8858			    amdgpu_dm_connector->dc_link &&
                            ^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Checked too late.  Presumably this NULL check could be removed?

  8859			    amdgpu_dm_connector->dc_sink->edid_caps.analog &&
  8860			    dc_connector_supports_analog(amdgpu_dm_connector->dc_link->link_id.id)) {

regards,
dan carpenter
