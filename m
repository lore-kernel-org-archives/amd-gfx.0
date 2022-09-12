Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3D4DECAAD5
	for <amd-gfx@archiver.kernel.org>; Mon, 12 Sep 2022 12:36:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3ADBF10E43A;
	Mon, 12 Sep 2022 12:36:53 +0000 (UTC)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 51F1410E46C
 for <amd-gfx@lists.freedesktop.org>; Mon, 12 Sep 2022 12:36:44 +0000 (UTC)
Received: by mail-ed1-x52f.google.com with SMTP id b35so12595580edf.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 12 Sep 2022 05:36:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date;
 bh=1pa194MrJFm1FW9E+Lk+2r3hrWZ83LpI2uiW0ni7RT4=;
 b=Q6cBU6Iyfo1YItAsJ40upuF5FASBjrqtQxByIajjpgKRREOmCnIW8NBuszWXyMtbgG
 KwgChG9/2uFV7RyX779Bzc9ilTS/NVKmrdPy1EcDhI+9d0a8h1fo72n9XXHPntG/fnoh
 f7Vczx+TLm8Odn+svDvSgCe8crEz0VdeOsbHuOcL4AztqMUpN+j1EUEwllyMC3uoz6lI
 PmuJs46ygcgtXrM7PWVCKLp1qvcnQwYs3sUeY2/t5s+2vsXIcZFLfADBZijaxdtBPaEj
 4tNKafjXBYeiKArft6TkJkoIzBBFLHhc/7an1wRji2y4SesfQSiuiFZqIBfisIzvEwYo
 hkwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date;
 bh=1pa194MrJFm1FW9E+Lk+2r3hrWZ83LpI2uiW0ni7RT4=;
 b=B7xse3fRIk7TVWSeM5WS3GuN3smv54glMnvwejJSLjPqHqfo17IhZcBkhNA4xCFeh7
 O/0FKMF+Jhzltc6KQUaOrbHKAo3WzYE9z+GHm5O8eSeto90F56ikUPW/yZ00L98jmAiL
 PwL2QMQVmguQrAlM5A2IUG4iuzQ5VwnnzxxQ2gNERMTna1IFhbiRZJtaZ2bIeCdpV4NW
 4acgOi+JfvzfjpYbWsZF1fDeJ5atDLYqpTieZuD5dAxqLWlw4Sib6tqQWcIEtp6gesSU
 R/XrxusajxVX8Jsue7kIeQ3D2Xd3Lqt+IeBURqTiF0eBK92zOXDGq2pyW41Ma5EjGrD1
 i3pQ==
X-Gm-Message-State: ACgBeo1/Y5FpdTSOKB7j7MhyLTlyflyfMfKOYtQnZ9n8NGREbWFt4sN2
 uf2ob5OVz338qHi4OvSt0Zo=
X-Google-Smtp-Source: AA6agR621hLjVKJL4XKH5MZmJDL+ykA3VLXYjewDf1tAy2S2EEqdEd90P5naTmEnfug1agUNmQHM0g==
X-Received: by 2002:a05:6402:c8a:b0:44e:81b3:4b7e with SMTP id
 cm10-20020a0564020c8a00b0044e81b34b7emr21913816edb.181.1662986202843; 
 Mon, 12 Sep 2022 05:36:42 -0700 (PDT)
Received: from able.fritz.box (p4fc20f4e.dip0.t-ipconnect.de. [79.194.15.78])
 by smtp.gmail.com with ESMTPSA id
 au6-20020a170907092600b00770c8e157ccsm4335639ejc.136.2022.09.12.05.36.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Sep 2022 05:36:42 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: alexander.deucher@amd.com,
	amd-gfx@lists.freedesktop.org
Subject: 
Date: Mon, 12 Sep 2022 14:36:33 +0200
Message-Id: <20220912123640.20058-1-christian.koenig@amd.com>
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

Hey Alex,

I've decided to split this patch set into two because we still can't
figure out where the VCN regressions come from.

Ruijing tested them and confirmed that they don't regress VCN.

Can you and maybe Felix take a look and review them?

Thanks,
Christian.


