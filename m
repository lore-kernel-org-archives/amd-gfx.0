Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08622C433FE
	for <amd-gfx@archiver.kernel.org>; Thu,  3 Nov 2022 16:42:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CDC1210E6F8;
	Thu,  3 Nov 2022 16:42:43 +0000 (UTC)
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com
 [IPv6:2a00:1450:4864:20::133])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5E2BE10E65D
 for <amd-gfx@lists.freedesktop.org>; Thu,  3 Nov 2022 16:40:57 +0000 (UTC)
Received: by mail-lf1-x133.google.com with SMTP id g12so3798629lfh.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 03 Nov 2022 09:40:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=6D1WH9mhlPfdlZGKzIx9zNhu75BQ+o8VBEU+EV26NXc=;
 b=S34vNYfOQ4r2pdPJgcwfDXYkqOgYp6naIGUmJWtiZhbCp7Zzsodzs4BBc2lp0qTysw
 4ZKpvEIWPkoa+w/4MyIoTolTUQnF1zDuyMbq+QTQWACtvYZeaBNG2/B8HNkF5ei5jls/
 UB1bQIGq1shl/DvACyG+4YMOAvl+QFG3pO5ZzXobsFzggNJXjsXydf3Uzzj3zvdOyZJh
 mQpGmwmfM44X/0MeerRNem5AjTcW2T3Xix/zG8fofL2QqSRjXjSYFxm56MZNRXNspgc+
 +KwVFdHq3WPxfaEAVkxc5Oj+g3GajZvA2dIs6IYIeWsRt+AvnFR4zcQ0GbxHn9+n/p6l
 foMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=6D1WH9mhlPfdlZGKzIx9zNhu75BQ+o8VBEU+EV26NXc=;
 b=WcGQ+Az8JlFICn8DSLmgohcOe4rvF4SlC7CWiJzPfjeMBk1Emvi04jfKRDchbuNOEQ
 X+PLfEGo1vShBMpnnkjdJ9crhqvcnZJsgMgTmp4VClbtwYefgtDRrUz4DqxGtfxeD3P7
 /vBeCna0JPVkY++JX9Ey+pFcAYreFw0NYMi0WsNhDg8y/B0L169pBdsKqPAXtY7KFyRj
 gvBFevkSA+78eCXxO+RQrXg496O9jpq18POSl8yybyQuzslW7YwxmS+IA/4/AdnCIBKA
 kKCabz/4He/ElSgODrBA4xc9v26K8VajuF6EcTSMwSBCuMzMRaxZbKOImUV0eZGh8qRS
 xCZg==
X-Gm-Message-State: ACrzQf3UDoBGaTn0vnqTegwBPmhQJi90TiGHOjm9wUwTSVJiHz8Wn8z6
 iBWfcWJIOiBgm6bnHw3y2osDKlEsCYQ/jaRQttyZ3ZZK
X-Google-Smtp-Source: AMsMyM6jZNCe97n434oNmVUI1Y29sL92QFq1Ci18G1NorQF7V1Impj5ZCHumlbjq1vMIO77Mc6x/BxZy5ZNYS2ZaIUY=
X-Received: by 2002:a05:6512:1303:b0:4ab:4bef:b3db with SMTP id
 x3-20020a056512130300b004ab4befb3dbmr13066920lfu.592.1667493655525; Thu, 03
 Nov 2022 09:40:55 -0700 (PDT)
MIME-Version: 1.0
From: Stefan Springer <stefanspr94@gmail.com>
Date: Thu, 3 Nov 2022 17:40:44 +0100
Message-ID: <CAE4WtP8iis0VGjuveNE7-OffejSUUra-ym_WmS8nV3ir-DkOsA@mail.gmail.com>
Subject: [PATCH] drm/amdgpu: workaround for TLB seq race
To: amd-gfx@lists.freedesktop.org
Content-Type: multipart/alternative; boundary="00000000000000bdf505ec939f77"
X-Mailman-Approved-At: Thu, 03 Nov 2022 16:42:39 +0000
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

--00000000000000bdf505ec939f77
Content-Type: text/plain; charset="UTF-8"

Looking good after 24+hrs of use
Tested-by: Stefan Springer <stefanspr94@gmail.com>

--00000000000000bdf505ec939f77
Content-Type: text/html; charset="UTF-8"

<div dir="ltr"><div>Looking good after 24+hrs of use<br></div><div>Tested-by: Stefan Springer &lt;<a href="mailto:stefanspr94@gmail.com">stefanspr94@gmail.com</a>&gt;</div></div>

--00000000000000bdf505ec939f77--
