Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1829BC83F33
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Sep 2023 06:04:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AABC510E423;
	Tue,  5 Sep 2023 06:04:20 +0000 (UTC)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A7E9510E423
 for <amd-gfx@lists.freedesktop.org>; Tue,  5 Sep 2023 06:04:19 +0000 (UTC)
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-52c4d3ff424so3002254a12.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 04 Sep 2023 23:04:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1693893858; x=1694498658; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=mAqztmiFAD1g4DE4iT8A5dUqLGaJDLwE+Y2DLOZmK74=;
 b=qGwgF3dNJa8z6ObiUEhOw4yA+B7RWQ741GitLYBks7iYS/QexfcOYBck2xr8BhP/ry
 W1RnO4r/CKuMpoFODQOYHSPuyPSUahV2Pt54hnoX8fjylR1S3KArssGJugjPfznLIm0e
 32C6qRvH8e84jG0jOJ59k5qxlt22UBjYY858jc6e715NNxQ7ZVUdkJp16pW5AkSQUbY5
 DNqHwKGbecKnaxo9/ESNNrdoz4FZ6hDuKTfp96/FtH+1vnfAzOFfaW2Q9qPCaR8u5x9f
 uKMj3ufwTEtG3A5ovayKTXwcY0DonDvV0QY5z8/lGwHqC2UHTnwcujZXqLtJofEQcZzq
 Hcyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693893858; x=1694498658;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mAqztmiFAD1g4DE4iT8A5dUqLGaJDLwE+Y2DLOZmK74=;
 b=VtOZ+0iElXuKcpCTtuyAx7PO9Pdv/Si4MOS/HyqO4iwKpbjMmUwU2To28SKzUYbYti
 kBqf4vw49Vd0GNbIDnAaKjpKiTsUuEEixZFRV/vnkdRg3iw9Nzohhqkz+whlW48jRcEU
 Mu5ABzWhKZobu3f9YTSdd9cIY1C5avg4QSxCLkwPe5F8Qr9QvEHI6MFzXTLL+VUzY4hI
 klgf2r7Pr6h9j26fpwE3jBDcloLmzN6EXUceb+DUuGva+6AtycVVBbJSWctDMsfWs7/z
 oz9rylAXg3r9kpV21nF9RKhn+IisH0UkJki4UnQ2guZHRHks7PiKLCe6S/CAUI6aXvsl
 7wvA==
X-Gm-Message-State: AOJu0YyB3rufQ+FNpTNXa9K0cFzFcUmgMsYTCPsSN5JCsoQ7f0AJTBTu
 QFoBf4sn3/6ivdTiw7ks6mltnjI5ApFryQ==
X-Google-Smtp-Source: AGHT+IEW5WT/AWvn074nMYL+3/PAO2tEnZgOJyVU+GdF3lJtR2XouMzXIGuhf1RTC2m1D9XROQuVag==
X-Received: by 2002:a50:fc13:0:b0:523:48d7:70b1 with SMTP id
 i19-20020a50fc13000000b0052348d770b1mr10031258edr.19.1693893857644; 
 Mon, 04 Sep 2023 23:04:17 -0700 (PDT)
Received: from able.fritz.box ([2a00:e180:15d9:7000:2f9d:c07d:1ee2:6439])
 by smtp.gmail.com with ESMTPSA id
 f2-20020a056402150200b0052a3b212157sm6631582edw.63.2023.09.04.23.04.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Sep 2023 23:04:17 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: Rework flushing changes to the TLB
Date: Tue,  5 Sep 2023 08:04:04 +0200
Message-Id: <20230905060415.1400-1-christian.koenig@amd.com>
X-Mailer: git-send-email 2.34.1
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
Cc: shashank.sharma@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hi guys,

as discussed internally the MES and KFD needs some form of TLB fence
which signals when flushing VM updates out to the hardware is completed
and resources can be freed.

As prerequisite to this we need to rework all the different workarounds
and approaches around TLB flushing to be at a higher level.

While at it fix a bunch of bugs in that code which could trigger in
certain situations.

Please review,
Christian.


