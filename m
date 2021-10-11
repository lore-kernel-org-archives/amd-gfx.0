Return-Path: <SRS0=iyzK=O7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65492C433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Oct 2021 07:31:18 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2344060EFE
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Oct 2021 07:31:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 2344060EFE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 77FB76E431;
	Mon, 11 Oct 2021 07:31:14 +0000 (UTC)
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com
 [IPv6:2607:f8b0:4864:20::1035])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5BC636E416
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 Oct 2021 06:13:42 +0000 (UTC)
Received: by mail-pj1-x1035.google.com with SMTP id
 nn3-20020a17090b38c300b001a03bb6c4ebso10192955pjb.1
 for <amd-gfx@lists.freedesktop.org>; Sun, 10 Oct 2021 23:13:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=R4+ZSF8fedpLrdxgiZRAMn6/n1z3LzukZHZ9DDUazSU=;
 b=pYTKnH+KPJi/U7Fs7/N5gC7H6P5E8C4oPBCvi6XCx1qhL3IUzrcY2V69c45jJNiThf
 brVST1XrC3bsZrjkiA0H6alofnsTET1uZ+FhG7t/QyI4BmLaF8EgFZiB2c6iH/iDXUXp
 mUeZZiy0wcwNxgCVtJ6p7ZTcXk+d9qj4T8KzG5OGkcP9swGEwtJsbz9oxsHeB/wjMy0P
 oqdNIzQiEbMMWCjtksvl92PlKJb8NbcOLqOcbG9aWrhl1xsCTKZEQVWztBb08Ygp2wel
 7RRsmYvpqOyWzrymQppNIFNKDECAN9ZRNIN2xJdz6N4TwsyWKlFIaWd/7sbIJbO1Cnev
 TfFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=R4+ZSF8fedpLrdxgiZRAMn6/n1z3LzukZHZ9DDUazSU=;
 b=GI3cterfN5IkBVrFFGnteY0QqcTrxf67ZJFusx13b+uprPDVtoB6GAksptmBcHdcmp
 JtVPgtTPRJ1HmsiB05B2ZaQ4O9RHBsNN4w/NAD66lPoJ47x5CBmWyk+h31fzdO0rB33C
 hlt0oJq0uoGJIV1j8ar3IEiYAYm1SFbJNjc5XW0D86kU8FeT+5w0B+dqWp1Ab9ALWNxm
 3M9F/84Z9oTzE94wBh4KRP3CpxX0SY8w1oaVC8Y4APH0BQ2+sfAZzShYAIKRP8A4HpWo
 NObYsexhg4nfTb4SH3rn3PosXBmJuNrwO6CmYZFeEne/xxRDtnHBMbpgDJTv+UAJFLRW
 N8/Q==
X-Gm-Message-State: AOAM531tRlUJ+40FStj0BHuYvSV1uB7sEvsl8maDr1jFXbATygOnV3na
 92Yf7/1o3pCjkpCTaNC4ESQ=
X-Google-Smtp-Source: ABdhPJzcE/x1FN72uU7uRf/H0y1G+sU2OylBlR7Abe4FOC1Ow4w/86LZLwbfN59/gR4sqzUYBReUiA==
X-Received: by 2002:a17:902:8f90:b0:13e:a44e:2d3c with SMTP id
 z16-20020a1709028f9000b0013ea44e2d3cmr22977522plo.85.1633932821815; 
 Sun, 10 Oct 2021 23:13:41 -0700 (PDT)
Received: from localhost.localdomain ([66.115.177.144])
 by smtp.gmail.com with ESMTPSA id p3sm6304504pfb.205.2021.10.10.23.13.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 10 Oct 2021 23:13:41 -0700 (PDT)
From: youling257 <youling257@gmail.com>
To: yifan1.zhang@amd.com
Cc: Felix.Kuehling@amd.com,
	amd-gfx@lists.freedesktop.org
Subject: Re: [PATCH 2/2] drm/amdgpu: init iommu after amdkfd device init
Date: Mon, 11 Oct 2021 14:13:26 +0800
Message-Id: <20211011061326.13718-1-youling257@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210928082819.205231-2-yifan1.zhang@amd.com>
References: <20210928082819.205231-2-yifan1.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 11 Oct 2021 07:31:13 +0000
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

my kernel config CONFIG_AMD_IOMMU=y CONFIG_AMD_IOMMU_V2=y.
linux kernel 5.15rc2 "drm/amdgpu: move iommu_resume before ip init/resume" cause my amd 3400g suspend to disk resume failed, have to press power button to force shutdown.
linux kernel 5.15rc5 "drm/amdgpu: init iommu after amdkfd device init" cause my amd 3400g blackscreen when boot enter my userspace.
i need revert "drm/amdgpu: init iommu after amdkfd device init" and "drm/amdgpu: move iommu_resume before ip init/resume" for my userspace, running androidx86 with mesa21.3 on amdgpu.
