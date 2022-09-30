Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66791C433FE
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Sep 2022 22:18:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2663910EDD2;
	Fri, 30 Sep 2022 22:18:22 +0000 (UTC)
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com
 [IPv6:2607:f8b0:4864:20::530])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0D00110EDB0
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 Sep 2022 21:41:42 +0000 (UTC)
Received: by mail-pg1-x530.google.com with SMTP id c7so5186731pgt.11
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 Sep 2022 14:41:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date;
 bh=LHKjqiv/1IHiQva1vWxJ8QVlM67W4929ggbGJZR64u0=;
 b=FEV0LEPSMUlSbwnVYD7mmedr/iHQ0xyAf5qU00LNXYcOuaLKugLFBkuVC39Lt/YJd5
 Eo42iKlC8ydkOvxLBF168YxPi5HGb+yashCijTKzrI2iQNniLKARB4eFNwYHZZHZX18G
 yIOGCNWh4sAbwwguZwrdJCzgwnzu6QziSqIeLxmW6/5FTsSeYSAss82v3DCuWStdd+Tv
 rMknqB5ja5yzNIsqc3OJ6kLIWTPIm9p4lXODhJwfMGamIkzqgCroHAFsch/J9vlUw5VY
 +uq8vmdEVhA4zx4KkmVei59WXosO5u5E9waoefGAXde8xh5AozVFsRxNB+0oSubHC2ET
 dFJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date;
 bh=LHKjqiv/1IHiQva1vWxJ8QVlM67W4929ggbGJZR64u0=;
 b=gx+h1bqxI9t8xb4slyWBH8mbtrbZC11DN5XrRs9CEPaKX/yYENAF2cwIbEDRlevtR1
 8hL4+zUKvJp9+A9xA2OcdqPsgC19dPblTD7TX1gReXxhVvVk8g5qnHH+Xt3ryq2eFl72
 jg1tFQp8QlLlSrO/124Id/vUJcuNj7Lx35QHS9riGsUltzRlIY3zcF2Mev+OBgFY/waM
 7Q7iZd9dEq9RSGtBttjeG7k8+4Wj54QHfwreM4fbYa13qpUmdSCo3gS/ay0mzTizHSXK
 McRLps7jpemhWaaFPOsOyuKRc1WPYXCINz2JJpnqJeuTml8W76o7dZG5iC6ScB9iKi9I
 bkmQ==
X-Gm-Message-State: ACrzQf0AbORrf9QUl2CYx9rkU53wZ90+W/Qp8zOX59gDVbrd/+pm85Ek
 I8QLvCGzCvyWZXwrlLkyEoo=
X-Google-Smtp-Source: AMsMyM45UxdTWoNBNzj5nmv40+tuCZZ04crLXO/v8089MJ7ZK0zmjLx9WXcPJ2v0P3sOxm35pV4yYA==
X-Received: by 2002:a05:6a02:186:b0:439:49a3:479b with SMTP id
 bj6-20020a056a02018600b0043949a3479bmr9250552pgb.171.1664574101595; 
 Fri, 30 Sep 2022 14:41:41 -0700 (PDT)
Received: from localhost.localdomain
 (ec2-13-113-80-70.ap-northeast-1.compute.amazonaws.com. [13.113.80.70])
 by smtp.gmail.com with ESMTPSA id
 p124-20020a62d082000000b0053617cbe2d2sm2281711pfg.168.2022.09.30.14.41.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Sep 2022 14:41:39 -0700 (PDT)
From: Zhang Boyang <zhangboyang.id@gmail.com>
To: Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org
Subject: [RFC PATCH 0/1] drm/amdgpu: Fix NULL-deref in amdgpu_device_fini_sw()
Date: Sat,  1 Oct 2022 05:41:09 +0800
Message-Id: <20220930214110.1074226-1-zhangboyang.id@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 30 Sep 2022 22:18:15 +0000
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
Cc: Steven J Abner <pheonix.sja@att.net>,
 "David C . Rankin" <drankinatty@suddenlinkmail.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hi,

There are several reports of "Fatal error during GPU init" will cause
NULL-deref in amdgpu_device_fini_sw(). Although the NULL-deref is result
instead of reason, this NULL-deref will confuse user.

https://lore.kernel.org/lkml/a8bce489-8ccc-aa95-3de6-f854e03ad557@suddenlinkmail.com/
https://lore.kernel.org/lkml/AT9WHR.3Z1T3VI9A2AQ3@att.net/

This is probably because "adev" is not fully initialized when
amdgpu_device_init() failed. Thus subsequent amdgpu_device_fini_sw()
will try to release "adev->reset_domain" and cause NULL-deref.

This patch fixes this problem by guarding the code with an "if".
However, I'm new to this module and I didn't fully understand the code,
so please review my code carefully.

Best Regards,
Zhang Boyang


