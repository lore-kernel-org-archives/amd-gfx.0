Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D25B6C47077
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Jan 2024 13:58:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6366010E603;
	Fri,  5 Jan 2024 13:58:08 +0000 (UTC)
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com
 [IPv6:2a00:1450:4864:20::132])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5617210E5FC
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Jan 2024 13:33:42 +0000 (UTC)
Received: by mail-lf1-x132.google.com with SMTP id
 2adb3069b0e04-50eac018059so2013688e87.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 05 Jan 2024 05:33:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704461620; x=1705066420; darn=lists.freedesktop.org;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :from:to:cc:subject:date:message-id:reply-to;
 bh=kDa+bWPe+L04ie3zk0iYVMfic3JToEuuY681zN4ite4=;
 b=T5j7fZTtDKjWPuY2lHL5iC6qWdKcRWbxOPKs5a2u2enADfdGqHloqYI8H0B88PpoGw
 boW4fVBrnFsT1wknN6FSCzc1+Q+JzDVKH2NOdnS/VJl+Jhk2HiqfSdJ6H9fGwAqp0xPL
 wBE4OZ5kkZdUwh9oo0hALd+UzNFZl4+ZZvU3EEpniGM2T0p9PzSYd+dKgq0nFNouBlsj
 MidUaCP9FHa9tQpLeqS+mKPchzndn8aLJKVbi0rUqPWvf98Vq0tYInw3VmTNUCHZaucX
 gddLnG0cwtybJwviWp8dogD029caMxCHV/PtG9+HFdrGFz7nbD0NLYJwv7YF3h6F14wW
 f3rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704461620; x=1705066420;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=kDa+bWPe+L04ie3zk0iYVMfic3JToEuuY681zN4ite4=;
 b=vtTYyv5mijvDLBrimcLPdSN8ZLXELPMiJRq2/+Y/2+goJm/m6Ci6N7NxFn8INdj/pP
 gXTbABiCWey0ZkpliTjz6lNb3SiZ6sc7CnFczt+4VJcw8JPSbEuQiERn+lEeC967frF1
 KHUPIoO1OGfKkK3suK0neV3WT/lXDI0eEAPBWvR+t81ltQZlzB+/SZqCG1JF/vJpMAoi
 h/rAIKYR5DWsPDFhBziMny6zZfEvPRaxvkrqw65cZmDjnsEP33NXv5TiEc2kyo291DfL
 yIx0DroqXOYAbA14vltAHFyErTNN0hzeHX9WOdRBwf6K4Z14pSX4sna+Ekb2xsDW6h0/
 x+fQ==
X-Gm-Message-State: AOJu0YyXK4Yt8AqRusQSe7DE6y9lqT+/i+b0O1AYmJ5Q0Q4DCKNwNUI3
 ON9cH6uWtZjGSfZAtynmVLMwG65HUPcFmg==
X-Google-Smtp-Source: AGHT+IFDQ3SG6UVtfNOkwiaxL0QSV7wBjlFD1egz8ghv9s8qQkWEB3MWi8R2qERtMrvIa/Q2X1JElg==
X-Received: by 2002:ac2:4c33:0:b0:50e:3158:c53a with SMTP id
 u19-20020ac24c33000000b0050e3158c53amr1083112lfq.124.1704461620475; 
 Fri, 05 Jan 2024 05:33:40 -0800 (PST)
Received: from localhost ([102.140.209.237]) by smtp.gmail.com with ESMTPSA id
 t20-20020a170906609400b00a28badcf367sm897949ejj.54.2024.01.05.05.33.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Jan 2024 05:33:40 -0800 (PST)
Date: Fri, 5 Jan 2024 16:33:37 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: peytolee@amd.com
Subject: [bug report] drm/amdgpu/vpe: enable vpe dpm
Message-ID: <efbcd813-8f22-44ad-a6e1-6bee6d3bb18c@moroto.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailman-Approved-At: Fri, 05 Jan 2024 13:58:06 +0000
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
Cc: dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hello Peyton Lee,

The patch 5f82a0c90cca: "drm/amdgpu/vpe: enable vpe dpm" from Dec 12,
2023 (linux-next), leads to the following Smatch static checker
warning:

drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c:62 vpe_u1_8_from_fraction() warn: unsigned 'numerator' is never less than zero.
drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c:63 vpe_u1_8_from_fraction() warn: unsigned 'denominator' is never less than zero.

drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
    60 static uint16_t vpe_u1_8_from_fraction(uint16_t numerator, uint16_t denominator)
    61 {
--> 62         bool arg1_negative = numerator < 0;
    63         bool arg2_negative = denominator < 0;

uint16_t can't be negative.

    64 
    65         uint16_t arg1_value = (uint16_t)(arg1_negative ? -numerator : numerator);
    66         uint16_t arg2_value = (uint16_t)(arg2_negative ? -denominator : denominator);
    67 
    68         uint16_t remainder;
    69 

regards,
dan carpenter
