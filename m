Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C13BCECAAD8
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Sep 2022 09:08:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6CB3C10ECFC;
	Fri, 16 Sep 2022 09:08:56 +0000 (UTC)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4ECE710ECF8
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Sep 2022 09:08:50 +0000 (UTC)
Received: by mail-wm1-x32e.google.com with SMTP id
 ay7-20020a05600c1e0700b003b49861bf48so718752wmb.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Sep 2022 02:08:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date;
 bh=0fX2pjJqmdwXsIgQyCR3QZ7IQiqzgInyIH8HidTvfTA=;
 b=MI+0glnWH1RI5Alk+nD0Tet498Hb3dRvGgR2QEcYal5R1xaz3NL667Hgp6Z4hyTHTq
 lx9epm5GAo4tI96VwZH+7B0QKm4Y20aTUcu4IzkOHy63PreeElt2aWgla819WCDiFIC/
 +BgqaW8UW6l7Un1dgkKYA/l/6OlbxGdvCyoi6QYI5sxZ0heRDLrcefE+1PO6oW6UYNsZ
 cvvFWAfdXYHYLjcUw/SkaV+g7hlVM2/T4Jl5tcbYD+sfUSRpgn4TtsQQHRdzJTJlWPEF
 tgS0kYChV6XTG2D3yQ+XQH4Z+Sq6v38vCJegZL2dQSiLA31q8+AszRUzwMhQuLWJJN+w
 tkMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date;
 bh=0fX2pjJqmdwXsIgQyCR3QZ7IQiqzgInyIH8HidTvfTA=;
 b=aHwGBe7qGYB3EnfWYB/PfFpXdwPTqOodB5yFjYmBkPri1dBfEyiIGo0DDQOVUIXtQl
 GSwO6oVw+ueafgOCEN3wQPdw4x2xzB08uTad5HCXmylEyABQDslhHaKqzn0ZQkpdB2Y9
 tQwlQyWUr3RCuxeG2FRduQhANAxD4XNiVwQkQEZ+q+BRAQEGTfoYRakts2pRGS9BnC9v
 F/8UZ1BC0yaFOwjeYKH8WgSUInb5SRfR2OtYPW+UU4pk+O7O+ww85wUd++gwFPoGhg3j
 HN4hJIsumNv91yHHzfNOgbbm4hth3B+on4p5mxJBp9Y5ZrksJ3OUTAF7InZzj3lPDeZ1
 J0IA==
X-Gm-Message-State: ACgBeo2YEPNSZOZghf2O/Jgr1I2ZJ9AUqA5Ux5KTOqE3LljfHvIrZ5jH
 SzsbjJ9KbdHLMaIp883Nhc4xAyVdn5c=
X-Google-Smtp-Source: AA6agR4oC6PedCif5AOFq8vocu93kWYq0uiJnvLrwafZoy5cvPsitsWXCvVdjJ0gCEjRjf4lE/gzTw==
X-Received: by 2002:a05:600c:2747:b0:3b4:708a:f66a with SMTP id
 7-20020a05600c274700b003b4708af66amr9122881wmw.146.1663319328727; 
 Fri, 16 Sep 2022 02:08:48 -0700 (PDT)
Received: from able.fritz.box (p4fc20ebf.dip0.t-ipconnect.de. [79.194.14.191])
 by smtp.gmail.com with ESMTPSA id
 b12-20020adff24c000000b00226d1711276sm4604145wrp.1.2022.09.16.02.08.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Sep 2022 02:08:48 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: amd-gfx@lists.freedesktop.org,
	alexander.deucher@amd.com
Subject: Final gang submit patches
Date: Fri, 16 Sep 2022 11:08:37 +0200
Message-Id: <20220916090845.3336-1-christian.koenig@amd.com>
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
Cc: bas@basnieuwenhuizen.nl, timur.kristof@gmail.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hey guys,

so thanks to Ruijing I was finally able to hammer out all the known VCN
regressions from this patch set.

Alex can you review those? AFAIK you are pretty much the only other
person deep enough in the CS IOCTL for that.

Going to takle the userptr issue Bas stumbled over next.

Thanks,
Christian.


