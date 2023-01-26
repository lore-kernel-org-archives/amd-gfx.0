Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B938C05027
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Jan 2023 13:57:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B3C3110E908;
	Thu, 26 Jan 2023 13:56:58 +0000 (UTC)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 73A3F10E075
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Jan 2023 11:07:00 +0000 (UTC)
Received: by mail-wm1-x32d.google.com with SMTP id
 o17-20020a05600c511100b003db021ef437so860318wms.4
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Jan 2023 03:07:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :from:to:cc:subject:date:message-id:reply-to;
 bh=RWvA/LuMivm6khb5ABFFkww00AXK1hEHUXiSdgFZ3Yg=;
 b=kJeAgdZmt4SrBrlV55IMiRPBZ9qJcFWocfzInFvkOz8DOrRchQDBI1pzLawF3AFPB5
 1KEwPBH/O7Etafs+VoxA5oT2SXmtMd9gCqQdJwtLDsimM66EEmWKyCGJHpHcYdDMPdhM
 YLgqT5hpTI/r3dbclhr+jWM0PCiWqsdUSkE46j0vrI0ftpdzC0KUQWBrM9QRQc5t396v
 MoonKGr6L9droptziBePCFXzyXJzQDJ6WWovO7R/eonlLTV8xgxgwuWXcIPyvrm+/5lA
 8nGeQeSkLVDh2mM3adqtmFNF/Dd4+G4oI2Y/lX/S3fxi22EccjNiQdGFrhq0IfJdH6wq
 h5cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=RWvA/LuMivm6khb5ABFFkww00AXK1hEHUXiSdgFZ3Yg=;
 b=Nl6iUQBXfBlTNP9IMckbYy61Z8Fhm0sG0EhDunXIl2axdFzbN4Rz2QbfVbNIyxVBwI
 HLlqPFmpPSZIzcyhhe8KfP87BDpBpDwU3a8Rvv8px543Wz0v8zT88hNQMBni7HuUZO+v
 a3djOvfIld3R3gyIq55G0fpmzeApTKQGvGmAJzTFYwYi5LSwt2LsS9ZHtFMGNEIeFQmQ
 oIDkt1m1We83cFHLT66xnQ64q5I3vJ1b0/NwiO8cccUVNoEIN7yV5EUtj1bUSRLEl7Iv
 Os99VDgPYATZhlRsZHcUDYQIg8AC2PUfJNtQnaMZWsrSH3QX7Qe6q892a2lHTgQE7B0v
 gYIg==
X-Gm-Message-State: AFqh2kp8yZC16yE3qi0tmVfJSmU0rNYm4VqqDu3N1GS0yVpUISLuNcw/
 W3bG4wFqyydalxZYfzQMpF8=
X-Google-Smtp-Source: AMrXdXvrmOhwuMrvCRT4UpvMKxjXCNw6EDUGRseVr+3ha9BA98bQv1gDpiow2vHd1oeqam8FHd9ghg==
X-Received: by 2002:a7b:c5d6:0:b0:3d9:fb89:4e3d with SMTP id
 n22-20020a7bc5d6000000b003d9fb894e3dmr36703776wmk.28.1674731218808; 
 Thu, 26 Jan 2023 03:06:58 -0800 (PST)
Received: from localhost ([102.36.222.112]) by smtp.gmail.com with ESMTPSA id
 q4-20020adff944000000b002bfae3f6802sm1020444wrr.58.2023.01.26.03.06.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Jan 2023 03:06:58 -0800 (PST)
Date: Thu, 26 Jan 2023 14:06:54 +0300
From: Dan Carpenter <error27@gmail.com>
To: wenjing.liu@amd.com
Subject: [bug report] drm/amd/display: move eDP panel control logic to
 link_edp_panel_control
Message-ID: <Y9JezlqdEleSQh23@kili>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailman-Approved-At: Thu, 26 Jan 2023 13:56:56 +0000
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

Hello Wenjing Liu,

The patch 0078c924e733: "drm/amd/display: move eDP panel control
logic to link_edp_panel_control" from Dec 19, 2022, leads to the
following Smatch static checker warning:

    drivers/gpu/drm/amd/amdgpu/../display/dc/link/protocols/link_edp_panel_control.c:353
    link_edp_receiver_ready_T9() warn: potential negative cast to bool 'result'

    drivers/gpu/drm/amd/amdgpu/../display/dc/link/protocols/link_edp_panel_control.c:388
    link_edp_receiver_ready_T7() warn: potential negative cast to bool 'result'

drivers/gpu/drm/amd/amdgpu/../display/dc/link/protocols/link_edp_panel_control.c
    331 bool link_edp_receiver_ready_T9(struct dc_link *link)

This function returns DC_OK (1) on success or positive on error or -1
on unknown error.  So casting it to bool means it always returns true.

    332 {
    333         unsigned int tries = 0;
    334         unsigned char sinkstatus = 0;
    335         unsigned char edpRev = 0;
    336         enum dc_status result = DC_OK;
    337 
    338         result = core_link_read_dpcd(link, DP_EDP_DPCD_REV, &edpRev, sizeof(edpRev));
    339 
    340         /* start from eDP version 1.2, SINK_STAUS indicate the sink is ready.*/
    341         if (result == DC_OK && edpRev >= DP_EDP_12) {
    342                 do {
    343                         sinkstatus = 1;
    344                         result = core_link_read_dpcd(link, DP_SINK_STATUS, &sinkstatus, sizeof(sinkstatus));
    345                         if (sinkstatus == 0)
    346                                 break;
    347                         if (result != DC_OK)
    348                                 break;
    349                         udelay(100); //MAx T9
    350                 } while (++tries < 50);
    351         }
    352 
--> 353         return result;
    354 }

regards,
dan carpenter
