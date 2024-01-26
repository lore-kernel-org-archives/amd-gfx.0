Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF564C47422
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Jan 2024 15:55:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 510C210FBCB;
	Fri, 26 Jan 2024 15:55:46 +0000 (UTC)
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com
 [209.85.208.180])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B5F6610FBCB
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Jan 2024 15:55:45 +0000 (UTC)
Received: by mail-lj1-f180.google.com with SMTP id
 38308e7fff4ca-2cf1fd1cc5bso5816131fa.3
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Jan 2024 07:55:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1706284484; x=1706889284; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=5nlZscqbBaz8PzAYidVAq3NXdoADu8F/MoHJ3ixNttk=;
 b=EfOuuniqXhmew/OftwcBSmvqu+Ql2WKzLGIvE12klu92aIPtTDBuC1AhjTvbStKVvW
 o8P5VbUv3p/zhQjWwTJ/M3qBKV8GfMtB5aXIprb3sdn8tqloaPYogHmbIWA9uPq5KCsy
 +L0mA0IE/AQSdcdkKChA1w4TAwF4zBNVf5NNh0AxaCBvdawgAdBGiGIf2GjHLpkkYCsv
 VDC6c9rHS6B/okY2vmPHHegqKOrD7V+DJ0adPADMxw7+R5b6p5W27iJVo5eN5MiEkAUa
 2goE31VCRdD3K8TtF1V0GuMhx07CgX9Pbmgt53CfsuVb5iz7cxF8vgri+4hN++GAzhuc
 klug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706284484; x=1706889284;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5nlZscqbBaz8PzAYidVAq3NXdoADu8F/MoHJ3ixNttk=;
 b=FvkipKQUuGkfKS3BHIJAfPnH2OSiSwrSqxZzrj8Fz4LMbskmQO3Z2oASxH1Noblsbz
 SEk17AMVCRFbQZri5dUIxYDaymojk5JPt3HQs8dit7DyZAUa7VhZbSztdVQWRfGh/sMl
 N1PDZireeE3cv+esAQiJ2wumZZc01PN4+fK0oInmytbiaaOSICFIi0YEoFYUexcnWigd
 kMZblldtB4cCGG8F6cLGZmmW2LU7kmOWW6nmMCV3YZNHvM52mORKklraZ12p5LiPdLHi
 PibztweTSLWyTmOuV3R32NORouOfpdxUxea3bU/iJONxi9WIwKWpo2b2OW01BQIekP6D
 ep3w==
X-Gm-Message-State: AOJu0Yxir5UP7yQmyPeLZQ/VW4Hi/AXt5tccc4gNNdTVjz4fgsYkBJ8N
 BiM4KphRDphDecy4wYHtuUmNoWvmFXeVCRcnYaRBKVZoFom1zgB1XNYP4kPQ
X-Google-Smtp-Source: AGHT+IH6R7v9DYxS6MXN9srYpWiPHSXY1yM64H9RANp1COOUq3aNgVZYyObKMD2qCndptz1krY6xHA==
X-Received: by 2002:a2e:9797:0:b0:2cf:4170:d181 with SMTP id
 y23-20020a2e9797000000b002cf4170d181mr1966057lji.7.1706284483669; 
 Fri, 26 Jan 2024 07:54:43 -0800 (PST)
Received: from able.fritz.box ([2a00:e180:1528:de00:74a1:34a:f78c:7883])
 by smtp.gmail.com with ESMTPSA id
 h1-20020a0564020e0100b0055d312732dbsm695801edh.5.2024.01.26.07.54.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jan 2024 07:54:43 -0800 (PST)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: vitaly.prosyak@amd.com,
	amd-gfx@lists.freedesktop.org
Subject: Two patches to improve gang submit with reserved VMIDs
Date: Fri, 26 Jan 2024 16:54:38 +0100
Message-Id: <20240126155440.2022-1-christian.koenig@amd.com>
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hi guys,

those two patches clean up gang submit. The first one should prevent
crashes when gang submit is used together with a reserved VMID.

The second rejects gang submits with a reserved VMID when this won't
work because of HW limitations.

Only smoke tested since I need more HW for this setup

@Vitaly: If you have some time please test them with your stand alone
gang submit test first and then we need to come up with a combined
test case for gang submit with reserved VMID.

Regards,
Christian.


