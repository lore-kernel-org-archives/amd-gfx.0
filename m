Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19B97C54EE9
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Aug 2022 13:18:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1D46510F26A;
	Mon, 29 Aug 2022 13:18:47 +0000 (UTC)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7462510F1C5
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Aug 2022 13:18:25 +0000 (UTC)
Received: by mail-ej1-x62d.google.com with SMTP id kk26so15589502ejc.11
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Aug 2022 06:18:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc;
 bh=Gnd1cvQXHxshbuHnSVWAFKYYevCPiyZpo1Yi5KRm8Jk=;
 b=FEeS0yhvRNCnHclg+9J2X5q6UZiAfhyLqyxYjB/LhERjQJl0pm+//LLGb9c/xNrg95
 p7mqcxCtu/NjSNWr/D9fWrqq7zxP8rDi0DBpwfMbjU2OuvrFIoDR/zuPBSxqmcWR339S
 ciK5ngLxdWv3x4GjgS343L8Dj/w4akvlLTbBwH1IdX1pwAX1Edhp+RY17bhlhpI2VxJ6
 2aNz0bqNTZ9Lu2lReMNtIrVfgSwxZ8IJYFAGWkmoWiraUkJfBZf2OaRXM0MBqST1fc2V
 nDgYQ4Zhs/HSl66YZvHUdCMLJjzd3hjJliZKUgba/g6uAzjlMJc1Y5aXZynrUg9PZnKP
 mNoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc;
 bh=Gnd1cvQXHxshbuHnSVWAFKYYevCPiyZpo1Yi5KRm8Jk=;
 b=i122avOgqvWJKQRg2P3R/QMqo4TKLnlpZH8aPeFS9nWGU9vjnsncrI9bqmEt1jncyz
 hrSTpKXyeTeLHS28t5duoBocPA+5zHkaezuWilGdqoVQ7knC4ymKqtmryMAShuAZmCbD
 1Um44YNi8MfZG4QMjcPm38ErBK/FX2bjYo/3VieZm1rcyEB3lnXo93BAVVgHoCh3IzRu
 8BYsrcbJ9CBKiSdAgJMrtcXCtQKVbSJ5/i7klYNavZgVCBeZO2GN0vUXRQFl+nCy0lX8
 8i3VMFJOx8TImC2HYNU3BfLx+Kne7Q5osjx87S6um6weIps3quoFdpQLFjb5wWiv8yq9
 I83g==
X-Gm-Message-State: ACgBeo1V1Av7ZqX6/MaIR8SfZX3bw+FNxOO3mwUAGqkGZXPnIxCu+WdB
 Y40OCiQ/xX1mFAcIZgWLUHA=
X-Google-Smtp-Source: AA6agR4jC/PhLeWAcbHwHCUDq2U+nbF0qdb/WJhaK6z6R/5yx2CpJRkDmnv7DpjO4W0t0eKx7qfU0g==
X-Received: by 2002:a17:906:4bd3:b0:731:3bdf:b95c with SMTP id
 x19-20020a1709064bd300b007313bdfb95cmr13670156ejv.677.1661779104001; 
 Mon, 29 Aug 2022 06:18:24 -0700 (PDT)
Received: from able.fritz.box (p4fc20ad4.dip0.t-ipconnect.de. [79.194.10.212])
 by smtp.gmail.com with ESMTPSA id
 z22-20020a50cd16000000b00445f9faf13csm5726218edi.72.2022.08.29.06.18.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Aug 2022 06:18:23 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: Ruijing.Dong@amd.com,
	amd-gfx@lists.freedesktop.org
Subject: Gang submit patches
Date: Mon, 29 Aug 2022 15:18:10 +0200
Message-Id: <20220829131821.2049-1-christian.koenig@amd.com>
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

I've finally fixed why the gang submit patches broke VCN3/4 video
decoding for AV1.

Please re-test.

Thanks,
Christian.


