Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CF83C4332F
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Nov 2023 19:14:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 10FF310E3DC;
	Mon,  6 Nov 2023 19:14:54 +0000 (UTC)
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com
 [IPv6:2001:4860:4864:20::34])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 373B010E3DA
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 Nov 2023 19:06:54 +0000 (UTC)
Received: by mail-oa1-x34.google.com with SMTP id
 586e51a60fabf-1f03db0a410so3024970fac.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 06 Nov 2023 11:06:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ncf.edu; s=google; t=1699297613; x=1699902413; darn=lists.freedesktop.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=vYgbVooXzG9bXvnAO9hh0cIK7Z3AtpRVQORTv9KMDa0=;
 b=T/9079/ZujSAt522K0MEoucNF77Z+sEjTCxd0BCv8+fFpY+BMsFnSEq5WCkKuq9/pH
 SBzEQzYWVsERvPo/l/aGRRdn1pfdgoE87pJz7dGXtDCBxsVntyAlQNI/uXb+luyEnGpI
 23pWTdK4XJYgkIQfcP+lumCUlpLux8WcwSNY9bP21za9jahFY0YcozT09JL/gX5Bie00
 iX4zbsGitGiQyERvyFHTG4rKUgHSDPuVV5dEHIhMsmlU7zjpCiYxL/xi3yiEP+/P86YD
 3Zta5sNj2Johw681XTYjDr7IqFYq9OWN+yvh6hQMWw/CGOLR7Qd493WRtoRarsaywoXN
 xu8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699297613; x=1699902413;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vYgbVooXzG9bXvnAO9hh0cIK7Z3AtpRVQORTv9KMDa0=;
 b=fmLRQWc/NFpFBOTYEzT2sRMSZdYYvepKsTVPuF9z/xMEAIN89TtAnOFlRSyKDA6wOF
 HQ9yYHWrg0xrIbjL+Az04jjJaYItIRiXXBZy6GdxF7IK9umwBwbFwIZLT5nyN2vNvlFk
 o07er+xTAb97bdh0am1K6OBcG3ZvTQNexY+pfgWHZTFfypQ/v4bsN282XQKUsfH1DdUE
 Jni/q4+p9AsnW57BOCxxWsDDEll7d0ynhmp8YGfN20GhsUn2Xy0FJZ2zGkUXhTflooeK
 iI7PYGbvBpMnt5vR1TnYh7k4/KbfUMx4ri7qwXLeEfwQ4bRGSPNNShn+kwT7NgIYdIbS
 mClw==
X-Gm-Message-State: AOJu0YzpivIlHpYEtpWfJ/VfAiMsnGMfUKj8byZQrPJG5gpgFE03u3Qw
 bZ3RdIJa9UzIyqmgFhdYDYJ6zg==
X-Google-Smtp-Source: AGHT+IH9OffbmsvZj+QnoxsyZtHU5JoQN6Vh73gHIVV9NgsvSQfbLQDqJBZsTJlf5jNN45d5OrYJSw==
X-Received: by 2002:a05:6870:11ca:b0:1ea:29a:8628 with SMTP id
 10-20020a05687011ca00b001ea029a8628mr549121oav.15.1699297613453; 
 Mon, 06 Nov 2023 11:06:53 -0800 (PST)
Received: from localhost.localdomain ([2601:580:8201:d0::d089])
 by smtp.gmail.com with ESMTPSA id
 ft8-20020a05690c360800b005a7b8d12f52sm4617500ywb.40.2023.11.06.11.06.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Nov 2023 11:06:53 -0800 (PST)
Date: Mon, 6 Nov 2023 14:06:51 -0500
From: Hunter Chasens <hunter.chasens18@ncf.edu>
To: Jani Nikula <jani.nikula@linux.intel.com>
Subject: Re: [PATCH v1] drm: amd: Resolve Sphinx unexpected indentation warning
Message-ID: <irp2myv4jp6o7vut5m7ax4hya5764xzustf2klxfpys42qmevk@yxxus464hito>
References: <20231105210044.70371-1-hunter.chasens18@ncf.edu>
 <ZUh2fuCjmgle3vd9@debian.me>
 <665794d7-38e0-4e74-9af7-eca986792e44@infradead.org>
 <ZUigbshGGc451V5L@debian.me> <875y2f193t.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <875y2f193t.fsf@intel.com>
X-Mailman-Approved-At: Mon, 06 Nov 2023 19:14:53 +0000
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
Cc: Xinhui.Pan@amd.com, Linux Documentation <linux-doc@vger.kernel.org>,
 Linux DRI Development <dri-devel@lists.freedesktop.org>,
 Lijo Lazar <lijo.lazar@amd.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 amd-gfx@lists.freedesktop.org, Randy Dunlap <rdunlap@infradead.org>,
 Bagas Sanjaya <bagasdotme@gmail.com>, alexander.deucher@amd.com,
 evan.quan@amd.com, christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

First, apologies to Jani Nikula. I accedently top posted on the other thread.
My email client is giving me a hard time. The following works and, if 
everyone agrees, I'll send out a v2.

 * E.g.::
 *
 *  S: 19Mhz *
 *  0: 615Mhz
 *  1: 800Mhz
 *  2: 888Mhz
 *  3: 1000Mhz
