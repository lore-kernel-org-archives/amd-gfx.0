Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A9E5E77180
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Dec 2024 14:04:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 327C610EDD5;
	Thu, 12 Dec 2024 14:04:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="yuKlaEm8";
	dkim-atps=neutral
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6F30710E00B
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Dec 2024 06:48:03 +0000 (UTC)
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-434ab938e37so1419765e9.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Dec 2024 22:48:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733986082; x=1734590882; darn=lists.freedesktop.org;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :from:to:cc:subject:date:message-id:reply-to;
 bh=gfGGmtmLXvm2ORztgHvGaqlyStpQhDbvjCh8MGtGlow=;
 b=yuKlaEm85cVNhpT7/WFKlh6jdJT+i8fP4R9Yfn2Uyq/L41Df3nGW06pKbl1i4euAi8
 4l4w9HvP/HAhFr5cgkPnZ1V/mpprW2+azAYJ5nNPuhWHPMHM7YgJvil+2auOth+fd7C0
 syGBCZpHZY/bRfoE6qbkAFZzeFblAiM77EBrWFauN4Ed/4RcJDWcpTbvE8njSv54BvH0
 wwqHVRFKiJBLQtrZBbG5c5OsgN4ryRiqhoxacCpQ/+5Lx7SWA22XoB8ZRN4Zkx3tV+/q
 BhMdaKAtdd5GjU0Ykno7UJC8vG3ai2bn5KtNqKUkZnaoJT+LPJ7Ggh0iXvzJBPqsV/7f
 /Oxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733986082; x=1734590882;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=gfGGmtmLXvm2ORztgHvGaqlyStpQhDbvjCh8MGtGlow=;
 b=cGngqcp88cZIG2eTsrKC3jTznl8s6jQjWnq8AeW2II/MF0REvMTbRRJindLQqV+k/I
 dWvV5WU6/aG8b+bCXwdz7RQTATsE24bCYMW+aMkjdthvF1+NN9chNyL+1BHbiaJAHmB7
 Jugd0YYxRd64CCgWjtIV7Ba/AHSMbEK9v4I1EgrbpeDOAinr7gSsJyHEDfaoRdCZElE4
 Lbg91TSrOqP80+5+zUGAEckgX86et0kLZgdVAvPg72xoPpkBcIfC6EXtFv9Q8hjE8dMJ
 Od7JnZmjcRIZ4nACZw55rGC/F1SoBBPbaLu0+cK1FQs/reYSpUv3ct8r3T4HPDTW4pav
 907g==
X-Gm-Message-State: AOJu0YzCE2V0y92DwOOgzSzH1P3PWO4t0Ijl7CToTuItgTq7/oy2PJPd
 ljN2/Dca35HeVbzaB/z2WnklpjUWvdZJq6UsM0HYRqW3BXdJ0y9OW6ztKW31cnw=
X-Gm-Gg: ASbGncu9On9aZzXbhsbZe6wOpMVDJWf0YWPAg60J4OmpwVAghgQgsjMsPAiCnKO0iNL
 flEKk1xvS4D7wmyUDnxhokhlp07RazJfMWYx5xi4enPzFBSvunGJO1tE23j+XT81NP8Z2s6HhOQ
 5Chsgvy0fqrDL5+vva/5UkfYMpXYFtnZgCkWdi9YsKzCmTzqUzyeLcp0Gb8QNOcaizEaAuAAPM3
 Uua3Nz9QUopuovGWdZln3qsfY34Ck9pX5J14yiMycs/RxEQTAGX1tu9wF/XCQ==
X-Google-Smtp-Source: AGHT+IEt+lQ9bwebwEBfBQPwmUv9tkvWVRTH2W/PZddXUczlT4L9zBCJvq3/ochYxv2SJnvtQ03e4Q==
X-Received: by 2002:a05:600c:3548:b0:431:6153:a258 with SMTP id
 5b1f17b1804b1-4361c373f28mr43038805e9.13.1733986081976; 
 Wed, 11 Dec 2024 22:48:01 -0800 (PST)
Received: from localhost ([196.207.164.177]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-436256e0732sm6855465e9.44.2024.12.11.22.48.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Dec 2024 22:48:01 -0800 (PST)
Date: Thu, 12 Dec 2024 09:47:58 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Leo Li <sunpeng.li@amd.com>
Cc: amd-gfx@lists.freedesktop.org,
 "SHANMUGAM, SRINIVASAN" <SRINIVASAN.SHANMUGAM@amd.com>
Subject: [bug report] drm/amd/display: Make DMCUB tracebuffer debugfs
 chronological
Message-ID: <91d1c6bf-9968-4904-a52f-d65ba7de9e5b@stanley.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailman-Approved-At: Thu, 12 Dec 2024 14:04:19 +0000
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

Hello Leo Li,

Commit 5a498172c8d0 ("drm/amd/display: Make DMCUB tracebuffer debugfs
chronological") from Nov 26, 2024 (linux-next), leads to the
following Smatch static checker warning:

	drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_debugfs.c:917 dmub_tracebuffer_show()
	warn: address of 'adev->dm.dmub_srv->meta_info' is non-NULL

drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_debugfs.c
    901 static int dmub_tracebuffer_show(struct seq_file *m, void *data)
    902 {
    903         struct amdgpu_device *adev = m->private;
    904         struct dmub_srv_fb_info *fb_info = adev->dm.dmub_fb_info;
    905         struct dmub_fw_meta_info *fw_meta_info = &adev->dm.dmub_srv->meta_info;
                                                         ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Even if adev->dm.dmub_srv is NULL, the address of ->meta_info can't be NULL

    906         struct dmub_debugfs_trace_entry *entries;
    907         uint8_t *tbuf_base;
    908         uint32_t tbuf_size, max_entries, num_entries, first_entry, i;
    909 
    910         if (!fb_info)
    911                 return 0;
    912 
    913         tbuf_base = (uint8_t *)fb_info->fb[DMUB_WINDOW_5_TRACEBUFF].cpu_addr;
    914         if (!tbuf_base)
    915                 return 0;
    916 
--> 917         tbuf_size = fw_meta_info ? fw_meta_info->trace_buffer_size :
                            ^^^^^^^^^^^^
Always non-NULL

    918                                    DMUB_TRACE_BUFFER_SIZE;
    919         max_entries = (tbuf_size - sizeof(struct dmub_debugfs_trace_header)) /
    920                       sizeof(struct dmub_debugfs_trace_entry);
    921 
    922         num_entries =

regards,
dan carpenter
