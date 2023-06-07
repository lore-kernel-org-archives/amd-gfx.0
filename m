Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E82D9C77B7A
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Jun 2023 16:05:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 65F5D10E0BA;
	Wed,  7 Jun 2023 16:05:03 +0000 (UTC)
Received: from mail-4317.proton.ch (mail-4317.proton.ch [185.70.43.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 668C410E51F;
 Wed,  7 Jun 2023 16:05:02 +0000 (UTC)
Date: Wed, 07 Jun 2023 16:04:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emersion.fr;
 s=protonmail; t=1686153898; x=1686413098;
 bh=8/JLwy12a5V/z94vGMw3A9XncxoP2Snt8NqsFpfO2DU=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=rhWSxP/bm0sDRmRofWAxeLkZ4JqidkoLL3ZwpB4v8eF9jtwUpDz4f6PL1dvpjYXwX
 TYfzIunROzgb09KmD5Ns7tFcG/Gdvm0rGoFvYHhwwXYymejP9ACzv4/BLRdOMSqvCN
 P658XAzw/AL6QbyX2sEle5B27AwIE+GTrfwojqhY3vDKIrN3/cmmFz5QbnT4XKMJtH
 cK5ykfUx/HOmet2M7hUOGVHYosz9vME7YCeKggM+YMuQRy+vbJeHPQSucWUpwSJwyi
 T7sE6ZDr2D/EvCRi4jxcLnWW8iko1yPtCJqDgA2TnFTo5Fq1/FwgBIiqmGDNSKXu2Z
 xGIZoEmax3vfg==
To: Harry Wentland <harry.wentland@amd.com>
From: Simon Ser <contact@emersion.fr>
Subject: Re: [PATCH v6 00/13] Enable Colorspace connector property in amdgpu
Message-ID: <0zKjnX2EVbPmX6UrMOUTG9GB6_0h57LVyjoj5PL5XFiJnrWVSBbUBIjl6P-Ir1NsLuL8iDof9s1N_jwfNGgvVbe_I9J3ckO2RxJud8znL7M=@emersion.fr>
In-Reply-To: <20230607152617.997573-1-harry.wentland@amd.com>
References: <20230607152617.997573-1-harry.wentland@amd.com>
Feedback-ID: 1358184:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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
Cc: Jani Nikula <jani.nikula@linux.intel.com>,
 Sebastian Wick <sebastian.wick@redhat.com>,
 =?utf-8?Q?Michel_D=C3=A4nzer?= <michel.daenzer@mailbox.org>,
 amd-gfx@lists.freedesktop.org, Melissa Wen <mwen@igalia.com>,
 Pekka Paalanen <ppaalanen@gmail.com>, Uma Shankar <uma.shankar@intel.com>,
 dri-devel@lists.freedesktop.org, Joshua Ashton <joshua@froggi.es>,
 =?utf-8?Q?Ville_Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>,
 Vitaly.Prosyak@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Thanks! All of the core DRM patches (1-6) are

Reviewed-by: Simon Ser <contact@emersion.fr>
