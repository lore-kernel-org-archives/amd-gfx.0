Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCDEFC88E77
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Sep 2026 07:37:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 928DA10E7E1;
	Wed, 16 Sep 2026 07:37:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="szAHdEIL";
	dkim-atps=neutral
Received: from mail-pz2-f42.google.com (mail-pz2-f42.google.com
 [74.125.228.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0551210E2DC
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Sep 2026 23:20:51 +0000 (UTC)
Received: by mail-pz2-f42.google.com with SMTP id
 41be03b00d2f7-cc50b9e8a45so233487a12.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Sep 2026 16:20:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789514451; x=1790119251; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=IGMnqDW895Je/mS7NKJPFeoFTm2jsczP2vXK225eeOg=;
 b=szAHdEILMY/SW5Fwk1l3I4tx0NWcGYwbY3VooazTPYZl++1X5NuZiv5tlP7ZglutCI
 WRUFyfxUvhQaSFiYxpfx9IQcsmRPtjp3S/IOJ0FYdhOTmC7RAEenr7NcB8bxmTV0PaV2
 a95EBdg4TEjfP5sx4zEJICKf4Xilnw6tJitD8LRdd5as+GhHjOoWiFbB+AldLPggqa30
 EYsXxZsv5T8sZ6z5lQtYbsxTGTte5jWEI5+2j+6m+iEImcP6QTlCsjukIVzJRijDU/L/
 Gvc4RqJMtQF4mfEI7KFdZ4RVTbLyXkyi3zmM7Z7k9OSkf5+mHOSHKy48mGsfgkMgeQRt
 5esw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789514451; x=1790119251;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=IGMnqDW895Je/mS7NKJPFeoFTm2jsczP2vXK225eeOg=;
 b=dZtdB2qetG72UGG80tr5vNc9QdWLBQXCu2H9jmCQWvad367uxFRIuwvyNu9+BQwkL0
 jzwtcI8JZUpff3Ex0+lF8XHEiid+JKX/VKk4leRxCa5wysVYSkMprfw8NYaFKCshp3Ss
 b2F25h58XUOab3MFkTLIn/D7PodEJlCa9ntbd+OKKyR/bQo/Xi7bgiovMFyMxvN3I3IF
 qM6q4I0lW5+YjT2fGdVLWIAuyRiLTE/dtDBW8EHnzZ7LY9T1TEmYLucTOmBnae/iTERY
 3HcOsQClAdDRQqYs0ofLPRZE3yjABlSynsO+93GwJrXzBt4rML39Vffp9yeuElI2u+5N
 gHVg==
X-Forwarded-Encrypted: i=1;
 AKwUvBx17UAic1/Y+Di/bDWghq1nzCHtvHXiJSuUcZdS/shVpROEynnFlE5YnwBh2iJP2NxJj4T61IPc@lists.freedesktop.org
X-Gm-Message-State: AFuF++mZFWyuv7d5wuRpODeHVm9LsnpuuKZzU/u38KxiGROKSGVERCMQ
 KfpO8OzPc/bFir8eIVMI5hsT1iUiKsLUGV+zxONrRRadiC1oyqXHSpE=
X-Gm-Gg: AYBFou1oI199rsLIHwW+kE3ZNJ1OAk9SYiIGQMw1FRFNo/Iho79MivId7ZnzFl1MDN1
 WZvcdWg/9tGbKCg4QMlR7wVGJUuaCj9v7qZ5cYXOWMCnFPLXNKcZawRpOQ/5qL+v7mU88vnmVNe
 YNGX7llw6CZt5q/D8YWJQ3HXXE7wODGGl81+UJunQUthttA9IBKvk2HzzTj9yGTa8KmMwn1bpQz
 ByZ5MIxHcYTatUWFBD1u3TtJw7vi5qA02Mpng73+T3afWxQUVe4OMwDPPrPuCqmNb329dcPeQIJ
 6G0vJZxlf+GbgW4PKltMkdSOwRQPnFWWi3VJjDAXk69LKcw87MhGjBeiRzk5+2/LGXewIKOflTl
 Y1M7yyqjTqlVM+tAdlhrC4a1b9z4kSUTK59j8qBmvZ2TqQQ+hG+iNE+zEdZQtT/GCOQ471zTPGu
 kIlYErcZdiVXioOq84THUbvk66YtdQu5Bxool69/gyEZss/6vhH29eKoHhEuuKo6PMubTEMItxM
 4ZOordWDl9nAfKOvwuezIuBOxjkCg==
X-Received: by 2002:a05:6a21:9090:b0:3d0:e034:a26f with SMTP id
 adf61e73a8af0-3dd5f5d8672mr1159394637.17.1789514451428; 
 Tue, 15 Sep 2026 16:20:51 -0700 (PDT)
Received: from at-Standard-PC-Q35-ICH9-2009 ([27.59.94.4])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33bf5a6a166sm2341985eec.10.2026.09.15.16.20.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Sep 2026 16:20:50 -0700 (PDT)
From: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
To: alexdeucher@gmail.com
Cc: 062bel313@gmail.com, Alexander.Deucher@amd.com, Christian.Koenig@amd.com,
 Kenneth.Feng@amd.com, airlied@gmail.com, amd-gfx@lists.freedesktop.org,
 atharvatiwarilinuxdev@gmail.com, dri-devel@lists.freedesktop.org,
 ed@aicharmers.com, linux-kernel@vger.kernel.org, simona@ffwll.ch
Subject: Re: [PATCH v2] drm/amd/pm: defer UCLK DPM enablement on Apple Navi 14
Date: Tue, 15 Sep 2026 19:20:43 -0400
Message-ID: <20260915232043.1222-1-atharvatiwarilinuxdev@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <CADnq5_NyBdPbavmiPVdsHkP_Oi1w7ngX0kPSNce+BWN-YkuAFQ@mail.gmail.com>
References: <CADnq5_NyBdPbavmiPVdsHkP_Oi1w7ngX0kPSNce+BWN-YkuAFQ@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 16 Sep 2026 07:36:56 +0000
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

> I can drop the patch if you feel strongly, although it is pretty
> similar your original patch, it just keeps all of the logic within
> navi10_ppt.c which is cleaner in my opinion rather than pulling navi1x
> specific logic into the core pm code.
> 
> Alex

I dont have problem with the code, the problem is that, this is not the
solution to this problem, as i said in the previous, the solution lies
in the DC not the SMU (i tested by removing dce_v10_0_early_init and adding
that function to dce_v10_sw_init), it is also confirmed via the testing using
Opencore Lecacy patcher, which makes the display 5K, and make the display not
use compatibility mode (4K), and it also fixes the SMU problem.

(https://gitlab.freedesktop.org/drm/amd/-/work_items/4455)

You can choose to upstream this, i dont necessarily have a problem with this
patch as long as i am the patch author (eg using From: )

Thanks
