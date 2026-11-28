Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EC2C606A31C
	for <amd-gfx@archiver.kernel.org>; Sat, 28 Nov 2026 09:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=protonmail.com header.i=@protonmail.com header.a=rsa-sha256 header.s=protonmail3 header.b=EfSSjYDn
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EE29F10E3AC;
	Sat, 28 Nov 2026 09:43:52 +0000 (UTC)
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 05ECD10E3AC
 for <amd-gfx@lists.freedesktop.org>; Sat, 28 Nov 2026 09:43:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
 s=protonmail3; t=1795859025; x=1796118225;
 bh=yBzSVsNGnLLHsuBPJV9A8YnRBTDGW5JhHWd5tyKOKbc=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=EfSSjYDnTUSMmzFyMwEfr30S2ilvSRqVA7bZndLEMt0Du1yext3XygTMmyul7fR86
 JuDQ8i4ynNAja5yjpjff7oibWjif2mhqqRS51TE3gkk6M2CrqvyFzM9dthGcdP/149
 I4cV2DyD9gVt+O80QbJCrpaplZjLx4us6lKPYQQhyXznOYMTlTupNICZWRE/IItVLe
 tM21npAa+9EqKqH4y3X5GP7eEJZbH0qmO62QY6FUJKxydp4OW4/isMPEe0nV9hSxus
 IikNb0Wk215APrf+6GsM9qlQnoItgmiFeMLWnOJIy5omHgdHc1cimJjoifiR3NIOW9
 yqI7Q+ND6fsPA==
Date: Sat, 28 Nov 2026 09:43:39 +0000
To: Chenyu Chen <chen-yu.chen@amd.com>
From: =?utf-8?Q?Eren_=C3=96zen?= <erenozen@protonmail.com>
Cc: amd-gfx@lists.freedesktop.org, Harry Wentland <harry.wentland@amd.com>,
 Leo Li <sunpeng.li@amd.com>, Aurabindo Pillai <aurabindo.pillai@amd.com>,
 Roman Li <roman.li@amd.com>, Wayne Lin <wayne.lin@amd.com>,
 Tom Chung <chiahsuan.chung@amd.com>, Fangzhi Zuo <jerry.zuo@amd.com>,
 Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu <Ray.Wu@amd.com>,
 Ivan Lipski <ivan.lipski@amd.com>, Alex Hung <alex.hung@amd.com>,
 James Lin <PingLei.Lin@amd.com>, Mario Limonciello <superm1@kernel.org>
Subject: Re: [PATCH 15/27] drm/amd/display: Guard connector I2C transfer
 without DDC pin
Message-ID: <D625PZrdGWeEqbBV6K9LV6lFe36aUMnR0hHLRcWLG6JmN94-5TOjMVBRDcWjJyhJosNIRMe3w4eQBMUfR3CNYiWEzxpqdMwQGtfGuXL-NTg=@protonmail.com>
In-Reply-To: <20261125065631.3889665-16-chen-yu.chen@amd.com>
References: <20261125065631.3889665-1-chen-yu.chen@amd.com>
 <20261125065631.3889665-16-chen-yu.chen@amd.com>
Feedback-ID: 19860221:user:proton
X-Pm-Message-ID: caa9d1b3f8db3b2309853c350e8dd4caddd77b8d
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi James, Chenyu,

This fixes the dm_test_i2c_xfer_no_ddc_pin() crash I reported on
11-18 against commit 48b8c06b05ad ("drm/amd/display: Route connector
DDC over AUX for native DP sinks"):
https://lore.kernel.org/all/QU464501lRPW3X8es-jXBFOvvwqS3eKR3HRS33U6x6o5eYC=
6h5AKV7f3ZXRCaU7-sEcupJMHereqyDUsUSG_fsOMNwvGO_CcZRKsz1AgObk=3D@protonmail.=
com/

I think  moving the check to the top also turns off the AUX routing on
links that have no DDC pin. ddc_service_construct() leaves ddc_pin
NULL for USB4 DPIA links and for force_to_use_aux links (no_ddc_pin
on ASICs with dp_connector_no_native_i2c, i.e. DCN 4.2b and DCN 6.0).
Those connectors still get the hw i2c adapter as their "ddc" bus, and
AUX is the only way to reach the sink. With this patch, DDC/CI through
that bus fails with -EIO there again, and that's the case
48b8c06b05ad was written for (fwupd). I found this by reading the
code and haven't tested it on DPIA hardware.

Mario's v4 fixes the crash without  that side effect: it checks
ddc_service->link before using it and keeps the routing. It also
carries my test fix, which gives the test a zeroed dc_link:
https://lore.kernel.org/all/20261118-superm1-amdgpu-ddc-v4-1-539eaeb4edd7@k=
ernel.org/

Could this patch be dropped in favour of v4, or changed to check
ddc_service->link instead? If it stays as it is, could you please add
the tags below? These are some of my first kernel contributions, so
the credit would mean a lot to me.

Fixes: 48b8c06b05ad ("drm/amd/display: Route connector DDC over AUX for nat=
ive DP sinks")
Reported-by: Eren =C3=96zen <erenozen@protonmail.com>
Closes: https://lore.kernel.org/all/QU464501lRPW3X8es-jXBFOvvwqS3eKR3HRS33U=
6x6o5eYC6h5AKV7f3ZXRCaU7-sEcupJMHereqyDUsUSG_fsOMNwvGO_CcZRKsz1AgObk=3D@pro=
tonmail.com/

Thanks,
Eren

