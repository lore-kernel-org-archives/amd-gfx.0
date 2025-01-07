Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C539E77188
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Jan 2025 09:07:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9DAE810E293;
	Wed,  8 Jan 2025 09:07:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Epb8UfU1";
	dkim-atps=neutral
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com
 [209.85.167.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8930A10E261
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Jan 2025 16:57:15 +0000 (UTC)
Received: by mail-lf1-f50.google.com with SMTP id
 2adb3069b0e04-54024ecc33dso2020483e87.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 07 Jan 2025 08:57:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1736268974; x=1736873774; darn=lists.freedesktop.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=lMfX1ukmt9zKlMQvTs4rDaldX9Ypcnm+9H1/Ac3eikQ=;
 b=Epb8UfU1PFApMReWKvDaRql/AZ8X7PRG9YPLNh5cTbhhxr6aXMORS1DFXeLmBv0j40
 xHCEsRkuO6ORRkR8t+FNlShrPcr4qUDs1xphOBoKAYLLX20dTTutPgM5syfwGHixgW9x
 Gi0wcr78N0xSa2bisnQVvBdWJHG02COIqj/AEOBTdW69Dr+6Ke18TOIpCc8KtSM14vmZ
 fXT72+E8Ay0eBsLFdifYHjBqL24nSQqRZybzNdFDmjh0MFRem+pbrmQk7N+N5oUbN5FH
 XqNH1UHHUu2cvia3XKudKV8mci6KlCOssZ70HDC5fBawgTSELEt3aboRLmbdU3I5cXX4
 368Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736268974; x=1736873774;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lMfX1ukmt9zKlMQvTs4rDaldX9Ypcnm+9H1/Ac3eikQ=;
 b=N6c3dpgvpYpi/+NMZjBE3bslgoxpZDZBD/9yRT8O0ysfQwfzgVMw+EGd8Lfb5CbKjq
 RYsAiQSX+khph9N1IGCa9ZpIF9UXmPPH2ayWJbHgYDHVysjyLCUcA/6HORXxtE1WhuOs
 QznFl4m573b2bbY+eiAV43VcadoNf4WfdDkkJKSXyOuj08PQyEhPyxKnO+Trt8zzJNqF
 K2yoDziAq0szO1QvCPT8rkUWDsIuv1Wawn3uViWcX1/2tjmVR7UIq207L7mbgwceuQD8
 wHUcPHarCOBliUMUyFJaPwSQknEQ40i9p+aK3qE/oq+kHc4LTQCSyC+UDPWhe1kZh/Zq
 pfrQ==
X-Gm-Message-State: AOJu0YxozclCQ7jmtIXJ9iDy3kHU7Lbu0vVgiM6/lZALy2zX5eCCaHae
 O7Vrb9jW7jEFod9jmbt8pNxd4DB81w3GsbRUncTm8GPbSy0evGUSdFoB+yOX
X-Gm-Gg: ASbGncsnS4vvzupzD1XviORT9rLAbkGLt/OW0Fzk4BncYKvTj2ug/P8hDzvTE2paQ22
 qaZoOi32e68kmwpDLsq/R9YXB699c4/Lx09X1+OeSGwBbsmiZWyWfiNI71GCsLoztHg0MNMaW7i
 GmuG1tP/Ckrnyj82ukHdPP5hSyvws9ZelB46UVxjvr9SrrmMd8K+KJuM5wVatOW9+LlT8qV+tNA
 BWdpcREEZ3X6c9HTXMle8XxoivUufiq1dcbixd0NHRMQovetVeFztvLil2KOfqWJA==
X-Google-Smtp-Source: AGHT+IHhld3Aj2eOg6OSq3UrWdclip0tuLg3hj6E39Paamh0zg+IMdpn2D4qS8+BRnfMsIcynzBSBg==
X-Received: by 2002:a05:6000:4012:b0:386:3272:ee68 with SMTP id
 ffacd0b85a97d-38a221f9fd4mr57615402f8f.28.1736268650005; 
 Tue, 07 Jan 2025 08:50:50 -0800 (PST)
Received: from debian.local ([84.66.149.209]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a1c832e8asm50137086f8f.37.2025.01.07.08.50.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jan 2025 08:50:49 -0800 (PST)
Date: Tue, 7 Jan 2025 16:50:47 +0000
From: Chris Bainbridge <chris.bainbridge@gmail.com>
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: amd-gfx@lists.freedesktop.org, alex.hung@amd.com,
 regressions@lists.linux.dev, tjakobi@math.uni-bielefeld.de,
 rafael@kernel.org, lenb@kernel.org, linux-acpi@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/amd: Fix random crashes due to bad kfree
Message-ID: <Z31bZzkjySUgoOkM@debian.local>
References: <Z2yQvTyg_MWwrlj3@debian.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z2yQvTyg_MWwrlj3@debian.local>
X-Mailman-Approved-At: Wed, 08 Jan 2025 09:07:10 +0000
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

#regzbot introduced: c6a837088bed ^
