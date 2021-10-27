Return-Path: <SRS0=hGuQ=PP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2009FC433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Oct 2021 14:45:47 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D0F3660F21
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Oct 2021 14:45:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D0F3660F21
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6ADE36E8AF;
	Wed, 27 Oct 2021 14:45:46 +0000 (UTC)
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com
 [IPv6:2607:f8b0:4864:20::231])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 846B96E8AE;
 Wed, 27 Oct 2021 14:39:48 +0000 (UTC)
Received: by mail-oi1-x231.google.com with SMTP id y207so3683411oia.11;
 Wed, 27 Oct 2021 07:39:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=sender:date:from:to:cc:subject:message-id:mime-version
 :content-disposition;
 bh=ZOVIW59kKpmA3YI6MyWfAQdWikp/1S+bV4WvwADltGI=;
 b=l3VHqW+goh9EHaX+7Vr/K8TAijIkOX8IUNP6+2QSVp9LQtv1as36aPVcm/F4HjQzC/
 LC+2Ruoy4oEUhC2ITk9J+MX8teOSjapO+KJH1NSabDmTTKPqFkhVfb5J9jPDCw8L0JER
 79INMm8w6WMacJjG0aK90648YYdIkXCdMjAZFObUvrhgMAqBEdGQgCg3J+DrbhlgTmaA
 YF6Vj4xML4fl0gBvveJ/6H7ETblC4ehdkPErvU967yh4nq/c08JPTZSTI/2+wXlppTdK
 enPzilSXE/M99mVYnlq1mWrEAsV3rIE2hKTbMk9uwfaQh9nrSquS8VmfIhkqu7p769qZ
 RPwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
 :mime-version:content-disposition;
 bh=ZOVIW59kKpmA3YI6MyWfAQdWikp/1S+bV4WvwADltGI=;
 b=ryRNkTkNSyu9iBi9i8RgY8vybkGd+DcpOg7+TBFlbuXuaPMhgdeK34sbNMcbHNQ57j
 DTHPvV36HdZZEKGLSjuxpVP7Sqsp/kpEoZGSJFGMRe2/o4D2f5QJTxLwIL03Z6y3s+5S
 h2ovHhu5nxSu+2z+fCI3QE+GeILCQ20k5licSQpAK/Sc+DBVHSdxWuEgIFX9hVatf+Oa
 EUpf0F4wEL6RYElX7Atg/AvzZto4MXHp50JBalUGey8hzHk7bdccMJNPLbV5B6NiRJvi
 kzMqT5K7NbrE6s//9AURXZDzU/uH687b4zDja2vkawSbo9EVL9nZJ8eediOEunUHIVug
 nNIg==
X-Gm-Message-State: AOAM5328C2FGyRtWjSS1s6cp/VcGHGuEvsVjgIOYffi1t0z/o3jahjTR
 X3VG3xuI3OcRPThmjwPZRHw3beshbxY=
X-Google-Smtp-Source: ABdhPJyHthbhSHJfSRNPj/xZEqesLzv1SFbQ3NKuegTuxoKp/W3Nsj1ndnpoWIrBM4Ob9PJzOL+XWQ==
X-Received: by 2002:a05:6808:490:: with SMTP id
 z16mr4119312oid.54.1635345587781; 
 Wed, 27 Oct 2021 07:39:47 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
 by smtp.gmail.com with ESMTPSA id
 y123sm41791oie.0.2021.10.27.07.39.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Oct 2021 07:39:47 -0700 (PDT)
Date: Wed, 27 Oct 2021 07:39:45 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Thelford Williams <tdwilliamsiv@gmail.com>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, David Airlie <airlied@linux.ie>,
 Alex Deucher <alexander.deucher@amd.com>
Subject: Re: [PATCH] drm/amdgpu: fix out of bounds write
Message-ID: <20211027143945.GA1947580@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailman-Approved-At: Wed, 27 Oct 2021 14:45:45 +0000
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

On Wed, Oct 13, 2021 at 04:04:13PM -0400, Thelford Williams wrote:
> Size can be any value and is user controlled resulting in overwriting the
> 40 byte array wr_buf with an arbitrary length of data from buf.
> 
> Signed-off-by: Thelford Williams <tdwilliamsiv@gmail.com>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

The fix works, but unless I am missing something it is incomplete.
parse_write_buffer_into_params() is called several times, and the
size parameter is always wrong. This patch only fixes one of several
instances of the problem.

Guenter

> ---
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
> index 814f67d86a3c..9b3ad56607bb 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
> @@ -264,7 +264,7 @@ static ssize_t dp_link_settings_write(struct file *f, const char __user *buf,
>  	if (!wr_buf)
>  		return -ENOSPC;
>  
> -	if (parse_write_buffer_into_params(wr_buf, size,
> +	if (parse_write_buffer_into_params(wr_buf, wr_buf_size,
>  					   (long *)param, buf,
>  					   max_param_num,
>  					   &param_nums)) {
> -- 
> 2.33.0
