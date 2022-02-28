Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30BA7C433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Feb 2022 19:06:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 631C810E371;
	Mon, 28 Feb 2022 19:06:00 +0000 (UTC)
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com
 [IPv6:2607:f8b0:4864:20::1033])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CE9C410E34C;
 Mon, 28 Feb 2022 17:27:03 +0000 (UTC)
Received: by mail-pj1-x1033.google.com with SMTP id v4so11756679pjh.2;
 Mon, 28 Feb 2022 09:27:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=B90OuQ7zc9yVKMEVZCKsWsT7ET8T63FPfntMYlVMILY=;
 b=OHhVJJKi3QwRpjML07uhDBNGsvJriFhT/RPMNynKmU4RJBp/81c6vzb15LhS1kWkPj
 jo7cxjR99E+MYr9GCsHkC3s2CoZMo6nkTKEzCrwRcYY0CzUZHrTZoIHYqXSedkRSofWQ
 OS5sBzh+9rWrBkg123djnzM+6EgcUNzXR+sXy+z3n3C6heOIiIsvSJRft2QbEN58uMod
 EL/QrlaOqlOeCaXnuO+CAzqi5+DOwovRrLu3RmqBI0SKyl+hkGX3z/9bGHC2QJ6TEodk
 wTXY/UUi9eD4FzxBQ8XNa1W84p5V98V9fHnYDpV6PoW1CPSn2zIGty4PJi1Mn0TQzOOB
 fIBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=B90OuQ7zc9yVKMEVZCKsWsT7ET8T63FPfntMYlVMILY=;
 b=3hb6mwJ1tBpDB/57oJV0N9vPpY0cmJpzcxbSl6Ngkjk1dpQhQP3QN3EZDxfTwjXAcV
 OqabpBTqS5zdb9mcSsBSSj1YxrlMZVluVswrPQO/ldd6wh5hLHdi0aLD9/ruJ7gW3vk3
 rCaufc+aSCf3FYIPPXHhTeYtSCIYsWcof91okLl/3VNbzsg4dfDiBY+33VJKp59Azz5c
 82guOwZXoEmv/moVBIPdsriVJKsgAnZ8EfmMtLjl2P4S/6WfZLCazDDzPnNH1GQWrpoO
 3hFV1spkOIW+V4/0g+DllspsTSIHdgOb5deaVMEjKbZtRicYWgwaRnG0PXAgH3c/tFpT
 ioaw==
X-Gm-Message-State: AOAM532iUx2Bnb0e1bMDVE0rVEoe++TJLkHIibUy/Lp01pFJ6T7vUDRD
 PRk9cOWT/EsBN53OlxE6VS0=
X-Google-Smtp-Source: ABdhPJx/iNMGqljFhakgfTxdO/FncHSNaIeQEtLUil2wMfsLA+k8LTnvxhl5MvsK3lr/JpWx/ON0Ig==
X-Received: by 2002:a17:90b:3693:b0:1bc:89f0:e38f with SMTP id
 mj19-20020a17090b369300b001bc89f0e38fmr17950554pjb.171.1646069223201; 
 Mon, 28 Feb 2022 09:27:03 -0800 (PST)
Received: from localhost.localdomain ([103.172.183.185])
 by smtp.gmail.com with ESMTPSA id
 f15-20020a056a0022cf00b004f3b99a6c43sm14027748pfj.219.2022.02.28.09.27.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Feb 2022 09:27:02 -0800 (PST)
From: youling257 <youling257@gmail.com>
To: qiang.yu@amd.com
Subject: Re: [PATCH v2] drm/amdgpu: check vm ready by amdgpu_vm->evicting flag
Date: Tue,  1 Mar 2022 01:26:51 +0800
Message-Id: <20220228172651.12642-1-youling257@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220222024651.36675-1-qiang.yu@amd.com>
References: <20220222024651.36675-1-qiang.yu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 28 Feb 2022 19:05:59 +0000
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
Cc: pmenzel@molgen.mpg.de, airlied@linux.ie, linux-kernel@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 daniel@ffwll.ch, alexander.deucher@amd.com, christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

this patch cause suspend to disk resume amdgpu hang,  [drm:amdgpu_job_timedout [amdgpu]] *ERROR* ring gfx timeout, signaled seq=8330, emitted seq=8332

https://gitlab.freedesktop.org/drm/amd/-/issues/1915
