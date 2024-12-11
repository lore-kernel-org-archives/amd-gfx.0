Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 385E7E77186
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Dec 2024 15:10:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A7AE910EB87;
	Wed, 11 Dec 2024 15:10:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="FA3V3zFa";
	dkim-atps=neutral
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com
 [209.85.210.182])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 39E4F10E183
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Dec 2024 03:17:58 +0000 (UTC)
Received: by mail-pf1-f182.google.com with SMTP id
 d2e1a72fcca58-725ecc42d43so2329778b3a.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Dec 2024 19:17:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1733887077; x=1734491877; darn=lists.freedesktop.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
 :reply-to; bh=MkB64RFwpW9AUQt2wKyq1Yb5kYMbSZj/H+ENOEOo5+A=;
 b=FA3V3zFaOOrm93Dl2RxxQi+OfA9Id/RHd3hMB1qb6YE9MyFbAxvhlDgfI/q5qDB2HP
 bBmIauWZBOmbWCNGjQGa5MZAWB9A0eFw5cRP9gGpSEjuJFK29mk9aRW3LFpsK7SG62K6
 55WkcThllmCfj5uTA790zLVtn8Ej3aFYlCEgf0ayZHYgFHJ87iMp5MbnDSc2O2WSNQU9
 Hf09yIuyc+5ooN1J0l6Fqt5nYNKfTUQQzG05khNdbIV82YHjVBKRHA7McKw134KCa9DI
 ps2Fe1/O8iwhUf0U6fk7W+OmOxG2nJN3WQ0revihb0XRzruzeuhCX9BtvrLcE+junBmk
 Vvew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733887077; x=1734491877;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MkB64RFwpW9AUQt2wKyq1Yb5kYMbSZj/H+ENOEOo5+A=;
 b=Vg9b1LYlYjwMVHFD082/4oR+wOBoCX3QDz5onB12rGHTVB22mpNk6TKZEGBimtxSsE
 IH11PqJF209YMiz19gwLuZ82ysDCBo7mp0STBRbzkq89GRoYDuyrPRFDv+lcunYIwSPW
 XGkL1SD7xNf6ifJYdjkOwmaEmOHsDx5ooW6k00XT1Aysb9Hl9YZ1Lk+Fdmcfk19T8/ZP
 YeRlDaRWEX08DLr5ApUL+fz/sqMtXM08prKuag/1y9C2zwg8ttaohiBDM2Dva63MLgUu
 jYIYlFdtD3pRwKWwzlpViNszIdiAZuEMk9475eHzjjkNOkbS8LUGPmhFoiTNZszpBx+v
 Ilug==
X-Gm-Message-State: AOJu0YyMjgIDpPP4H0LppHEpr6XidPmod7Mbjru5KYh4YmHfUwJRwbti
 tbmaNxdiNTseQuFm50ySRnlCOmleyD0wpNwe7oszcQRZLc+4Hh5PDmZNVg==
X-Gm-Gg: ASbGncvMZP+eUy1NSpBLIekFyHrffYTUdg/a/KF04miDsL7VPTnRInnBimSrzgioBRG
 Gx7GZ9kCKxffPvGrrvSMVqhtbc7O6SS4r3tGYKRwVrvLHgzNb0iXcA1AAjROcNSMXhomya7Tc0q
 C3NS0i0u1hyKnLWqTp1CX4liDBkn//WVyUWzax4dMRP1gVlEoh/iiKgNLV69QTn97YnSmM23ToH
 eC11Utg6hI77d9d2KHdni31aaQZnsZVLaEvKsfAx8Tpg9/9nmT7ODyPQmIi0u0ADnA=
X-Google-Smtp-Source: AGHT+IG7zOYLXKIClvUY2/43cDFsOI7npDSa9Oy+0ygdPM2bqkUlxmwDQ+/Geu7s7eCtenoMWn99Ug==
X-Received: by 2002:a05:6a20:d50c:b0:1e0:be48:177d with SMTP id
 adf61e73a8af0-1e1c12ab50emr2530724637.3.1733887076867; 
 Tue, 10 Dec 2024 19:17:56 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-725ceb7c02dsm6803657b3a.136.2024.12.10.19.17.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Dec 2024 19:17:56 -0800 (PST)
Date: Tue, 10 Dec 2024 19:17:53 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Alex Hung <alex.hung@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Harry.Wentland@amd.com,
 Sunpeng.Li@amd.com, Rodrigo.Siqueira@amd.com,
 Aurabindo.Pillai@amd.com, roman.li@amd.com, wayne.lin@amd.com,
 agustin.gutierrez@amd.com, chiahsuan.chung@amd.com,
 hersenxs.wu@amd.com, jerry.zuo@amd.com,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
 Duncan Ma <duncan.ma@amd.com>
Subject: Re: [PATCH 10/34] drm/amd/display: Add debug prints for IPS testing
Message-ID: <abe64cad-4ac4-4372-9d46-5e77618b3836@roeck-us.net>
References: <20240228183940.1883742-1-alex.hung@amd.com>
 <20240228183940.1883742-11-alex.hung@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240228183940.1883742-11-alex.hung@amd.com>
X-Mailman-Approved-At: Wed, 11 Dec 2024 15:10:09 +0000
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

Hi,

On Wed, Feb 28, 2024 at 11:39:16AM -0700, Alex Hung wrote:
> From: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
> 
> [WHY]
> To log commit states and when we transition in/out of allow and idle
> states and the caller.
> 
> [HOW]
> Add a new logging helper and wrap idle optimization calls to receive
> the caller.
> 
> Reviewed-by: Duncan Ma <duncan.ma@amd.com>
> Acked-by: Alex Hung <alex.hung@amd.com>
> Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
> ---
...
>  
> +	DC_LOG_ERROR("%s: DMCUB error - collecting diagnostic data\n", __func__);
> +

This patch generates _lots_ of logging noise.

[689208.336969] amdgpu 0000:03:00.0: [drm] *ERROR* dc_dmub_srv_log_diagnostic_data: DMCUB error - collecting diagnostic data
[689219.628141] amdgpu 0000:03:00.0: [drm] *ERROR* dc_dmub_srv_log_diagnostic_data: DMCUB error - collecting diagnostic data
[689221.098993] amdgpu 0000:03:00.0: [drm] *ERROR* dc_dmub_srv_log_diagnostic_data: DMCUB error - collecting diagnostic data
[689222.645994] amdgpu 0000:03:00.0: [drm] *ERROR* dc_dmub_srv_log_diagnostic_data: DMCUB error - collecting diagnostic data
[689225.341470] amdgpu 0000:03:00.0: [drm] *ERROR* dc_dmub_srv_log_diagnostic_data: DMCUB error - collecting diagnostic data
[689226.467388] amdgpu 0000:03:00.0: [drm] *ERROR* dc_dmub_srv_log_diagnostic_data: DMCUB error - collecting diagnostic data
[689226.716755] amdgpu 0000:03:00.0: [drm] *ERROR* dc_dmub_srv_log_diagnostic_data: DMCUB error - collecting diagnostic data
[689231.507746] amdgpu 0000:03:00.0: [drm] *ERROR* dc_dmub_srv_log_diagnostic_data: DMCUB error - collecting diagnostic data
[689247.287990] amdgpu 0000:03:00.0: [drm] *ERROR* dc_dmub_srv_log_diagnostic_data: DMCUB error - collecting diagnostic data
[689252.441150] amdgpu 0000:03:00.0: [drm] *ERROR* dc_dmub_srv_log_diagnostic_data: DMCUB error - collecting diagnostic data

I disabled it in my private kernel build, so no problem for me. However,
searching for the string on the web shows lots of complaints. Not my call
to make, but claiming that this patch adds "debug prints for IPS testing"
seems to be a bit misleading.

Guenter
