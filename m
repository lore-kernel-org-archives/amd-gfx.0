Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEF94C5AD4C
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Nov 2023 16:25:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1683B10E186;
	Thu, 23 Nov 2023 16:25:00 +0000 (UTC)
Received: from mail-4018.proton.ch (mail-4018.proton.ch [185.70.40.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EB00010E186
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Nov 2023 16:24:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emersion.fr;
 s=protonmail2; t=1700756692; x=1701015892;
 bh=UtahpTMUIkzRRkLLl/RDgccHpG8+Tv/LRGhCg/01Fe8=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=KFKx8LXc6AFb6BvzMma3qYOE4eoj8SHnsCn8MEICv6IajMp7hSDIs0omOsTCGSesW
 ku0WtE3pWlIQLMaiJiPZDclndKyxkJTG+wgRCG0VMFMmWT+pWQQyrpelITxeoWyGW2
 nNgm+cSSOqXNEU21VW3sR7uk2SQbPm4zao3spvUYTcvJc1MZRSHUL5HOW+GkB9w9nd
 x/4UzvPVq2Zot6S1SzyCvRHNcn6vPfB2uH1TpyHs+vbd3DmZpfRCx0Tc3hewHlZwvd
 9OE3tqbPBJM4gEzUqTz5+NKMdZBHicZ8qRUQ9SN09YmrDcWd5h2r2dECYEgeap7CnC
 C5cGpakrBNnsQ==
Date: Thu, 23 Nov 2023 16:24:36 +0000
To: =?utf-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
From: Simon Ser <contact@emersion.fr>
Subject: Re: [PATCH v9 0/4] drm: Add support for atomic async page-flip
Message-ID: <WG-nBy-xqSEAQQX1ASB9Gw7Ra0aZ-qFYDQq1mXjQdOTwxlM1wEROginNiWbnM9CZE9idUyE6P5urNZ8q8kFMswbPt5ewbk3ocuIVnajQpAQ=@emersion.fr>
In-Reply-To: <50ff86d4-5ce1-4ae5-aafb-ce3bc0069629@igalia.com>
References: <20231122161941.320564-1-andrealmeid@igalia.com>
 <cc10f6b0-e26e-4021-85ca-33cb1e58e937@amd.com>
 <50ff86d4-5ce1-4ae5-aafb-ce3bc0069629@igalia.com>
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
Cc: pierre-eric.pelloux-prayer@amd.com, dri-devel@lists.freedesktop.org,
 =?utf-8?Q?=27Marek_Ol=C5=A1=C3=A1k=27?= <maraeo@gmail.com>,
 =?utf-8?Q?Michel_D=C3=A4nzer?= <michel.daenzer@mailbox.org>,
 intel-gfx@lists.freedesktop.org, Randy Dunlap <rdunlap@infradead.org>,
 xaver.hugl@gmail.com, amd-gfx@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Pekka Paalanen <ppaalanen@gmail.com>,
 Hamza Mahfooz <hamza.mahfooz@amd.com>, kernel-dev@igalia.com,
 alexander.deucher@amd.com, christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Thanks! This iteration of the first 3 patches LGTM, I've pushed them to
drm-misc-next. I've made two adjustments to make checkpatch.pl happy:

- s/uint64_t/u64/
- Fix indentation for a drm_dbg_atomic()
