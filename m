Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6443C43334
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Jul 2022 10:39:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 49374A4500;
	Thu, 14 Jul 2022 10:39:07 +0000 (UTC)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4B52CA44F0
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 Jul 2022 10:39:06 +0000 (UTC)
Received: by mail-ed1-x531.google.com with SMTP id e15so1856477edj.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 Jul 2022 03:39:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=EM+jCoTd8S0FZJCysEpryhgBnEb+CIfDG88NbmWSxMc=;
 b=NfO+Jtpik4slRweOAkXqGN2XaOygy2WDC5tX39YKRyoR1hvAZ5YaabtYPuLVO1lu1L
 G3e6FP9V6qyNpTJUN/sjtUiEsLSdx4hsL+Y8yfW/K2p63FFP/9sWMnOzyNhLZ2vXg51c
 stgYS8vsRQn2cP1eDVpY/fH/jd06vE9SzYN/ysgjUr+26meQ80kuixc3xPBOWKsCgCOn
 FyuHRzP1HGu0Q4a5qw2qC1/4Q+02FpuuXrSdGawv7h7ip7256zrI2JgAvqAjujNGetKw
 noPwQAxhj8QqTEu5FWK41/RJN5V3htQ0Db7uNoj6iydl/aflctxKcSHw4p1VR8iwrZhF
 lPLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=EM+jCoTd8S0FZJCysEpryhgBnEb+CIfDG88NbmWSxMc=;
 b=UB+zOPogW4qOHXCxyOhgRnMea3AiuBxJXy5XetH/zIcu/62X7/qx1HV2ZGHmv+7W6l
 tkKcmRmzoccMHe7Q5jGoNd9oVCU4EkkzKDnXgrJePvsMlyFW4+42/z4a0KKbxpHEQ48S
 H4w6fH14efwc6U3XRf9NbRfcft1DdRSTm8hfkLc4KMpTErf+uE1/wfOgZI7XRHChmVG0
 dODgwfMSVw0t9n/9fRpd+OIPcaX0aJxExJwO2PQbkLsiK1N5yAWYmYU1dV+1LrgkltCp
 Q1/02Axc05mHKol7eVw7+i1ilU8Etow68Q2Qs+6RzkyZ3lUQorQzcco3aOQZcry7lTpu
 ynMQ==
X-Gm-Message-State: AJIora8tsdCOFYeqHhnI5iBmeGZwhyL173vNMALHwkrOqdlCqZQjR225
 Tk7rlIhxicmJd/lsNPtx+rCxOhTZnac=
X-Google-Smtp-Source: AGRyM1vX12h/U4zZsh9TdVPjZPHD77kPVomFaLEos7I3tITOakOe4MrEpeEmkH3PYr0OCu+9vSUyww==
X-Received: by 2002:a05:6402:3326:b0:43a:902b:d335 with SMTP id
 e38-20020a056402332600b0043a902bd335mr11340375eda.412.1657795144849; 
 Thu, 14 Jul 2022 03:39:04 -0700 (PDT)
Received: from able.fritz.box (p57b0bd9f.dip0.t-ipconnect.de. [87.176.189.159])
 by smtp.gmail.com with ESMTPSA id
 z13-20020aa7d40d000000b0043adc6552d6sm799487edq.20.2022.07.14.03.39.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Jul 2022 03:39:04 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: amd-gfx@lists.freedesktop.org, Marek.Olsak@amd.com,
 timur.kristof@gmail.com, andrey.grodzovsky@amd.com,
 Yogesh.Mohanmarimuthu@amd.com
Subject: Gang submit v2
Date: Thu, 14 Jul 2022 12:38:52 +0200
Message-Id: <20220714103902.7084-1-christian.koenig@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

Hi guys,

secound round for this patch set. I've fixed the minor comments and bugs
Andrey and Yogesh came up with and rebased everything.

The base is not the current amd-staging-drm-next branch, but rather Alex
rebased version since this depends on the dma-resv usage rework. So
don't bother trying to apply that anywhere.

The patches are also available here https://gitlab.freedesktop.org/ckoenig/linux-drm.git
on branch amd-gang-submit.

Please review and comment,
Christian.


