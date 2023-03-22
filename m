Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A88FC6FD1C
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Mar 2023 13:03:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AF98C10E945;
	Wed, 22 Mar 2023 13:03:16 +0000 (UTC)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BA5FC10E8EF
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Mar 2023 09:33:40 +0000 (UTC)
Received: by mail-wm1-x32a.google.com with SMTP id
 v4-20020a05600c470400b003ee4f06428fso1435915wmo.4
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Mar 2023 02:33:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20210112; t=1679477619;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ydCnZju8qzeI9mdPVPTu8Q6VyZ1XECWM66tkf7mxeVQ=;
 b=HiD8A7QhnHkpsa9ucYOM9Se4hguyIWfWVDgWfiCDs9EvPM97Xawq8eCLOzvwD2mhbU
 RE+mOsnjaF5K6/k9c2j0qiSKJfopS2CSDs4+tFa4maZFzAnGjFFf0eUOGg31oOrdI3ok
 T7YD+ee6w0gyZ9lrRABxGB8QwxrznXxHnr2cBOXfoWwuA7+oxf4iVardj0FpeGbf0XSD
 crVMKtNbrO0VhKf5JJ2IJvHY1iXT/89ptSSpMrS4IiCO+fe6by1hRtMcVz4Jz4daCUvl
 mMPXPWFg2pZCwleUsBXZDLApyl0cCEdNFw8ZzexcEW08ipqoMvB50mNzs6utm9oeC42A
 CaBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1679477619;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ydCnZju8qzeI9mdPVPTu8Q6VyZ1XECWM66tkf7mxeVQ=;
 b=YrrwzFOTiAYfJtf3ffq0s1T/CkrA2x2b69sCIQDz0No5h1459O/OG81WGtuz7PW5Vc
 cXuPpzg4UoeHq34xSrXYn5GHQaERBbuEyV+DrJHSccsAt0UN/zfzB00H8S5dYrKI3JsX
 TIELhWzqmAdkJzJGcWL5Y1MeMlqon/aRL7VdIrexpNlAEacY9b56MU2cJVxuzpvEvHx5
 d/J6QUxEXvMUZP7zH3QsLNVa7LPMH303uujeu76P33NlLZoySsyt6EwYdE+z2aBIxjGI
 MJ9MboGS91qb1xyflmCkkTSaBT7ujy027mFFAHY5POKVVCP2dPzZJRiwwqCl1zXibZ4A
 aCng==
X-Gm-Message-State: AO0yUKUKIizBqSnm0/DZiU4mby35wc5Av2HiQKkItmKS0X6Ds7hDR06h
 BsAgTh7duJXN4CmX6fjForX7uLs62hPrlw==
X-Google-Smtp-Source: AK7set8JOogKrt2RECDdRZXRzlKGQqMSFH06a1q8vKNV5XTKvQZ+Zxq2YhxtDfoqpP/9LKe43YruqA==
X-Received: by 2002:a05:600c:206:b0:3eb:395b:8b62 with SMTP id
 6-20020a05600c020600b003eb395b8b62mr4515561wmi.39.1679477619086; 
 Wed, 22 Mar 2023 02:33:39 -0700 (PDT)
Received: from localhost ([102.36.222.112]) by smtp.gmail.com with ESMTPSA id
 u26-20020a05600c211a00b003ee097c58e3sm7370725wml.39.2023.03.22.02.33.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Mar 2023 02:33:38 -0700 (PDT)
Date: Wed, 22 Mar 2023 12:33:34 +0300
From: Dan Carpenter <error27@gmail.com>
To: Wenjing Liu <wenjing.liu@amd.com>
Subject: [bug report] drm/amd/display: move eDP panel control logic to
 link_edp_panel_control
Message-ID: <22f63124-dd5b-4678-8195-c289be805718@kili.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailman-Approved-At: Wed, 22 Mar 2023 13:03:14 +0000
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

The recent function renames made these warnings show up as new again:

drivers/gpu/drm/amd/amdgpu/../display/dc/link/protocols/link_edp_panel_control.c:358
edp_receiver_ready_T9() warn: potential negative cast to bool 'result'

drivers/gpu/drm/amd/amdgpu/../display/dc/link/protocols/link_edp_panel_control.c:393
edp_receiver_ready_T7() warn: potential negative cast to bool 'result'

drivers/gpu/drm/amd/amdgpu/../display/dc/link/protocols/link_edp_panel_control.c
    336 bool edp_receiver_ready_T9(struct dc_link *link)
    337 {
    338         unsigned int tries = 0;
    339         unsigned char sinkstatus = 0;
    340         unsigned char edpRev = 0;
    341         enum dc_status result = DC_OK;
    342 
    343         result = core_link_read_dpcd(link, DP_EDP_DPCD_REV, &edpRev, sizeof(edpRev));
    344 
    345         /* start from eDP version 1.2, SINK_STAUS indicate the sink is ready.*/
    346         if (result == DC_OK && edpRev >= DP_EDP_12) {
    347                 do {
    348                         sinkstatus = 1;
    349                         result = core_link_read_dpcd(link, DP_SINK_STATUS, &sinkstatus, sizeof(sinkstatus));
    350                         if (sinkstatus == 0)
    351                                 break;
    352                         if (result != DC_OK)
    353                                 break;
    354                         udelay(100); //MAx T9
    355                 } while (++tries < 50);
    356         }
    357 
--> 358         return result;
                       ^^^^^^
result is a non-zero enum so this always returns true.  Which is fine
because the caller doesn't check.

    359 }

regards,
dan carpenter
