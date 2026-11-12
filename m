Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DDCA606A323
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Nov 2026 08:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=protonmail.com header.i=@protonmail.com header.a=rsa-sha256 header.s=protonmail3 header.b=FYMdUEcq
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C1A0510FF05;
	Thu, 12 Nov 2026 08:51:15 +0000 (UTC)
Received: from mail-106109.protonmail.ch (mail-106109.protonmail.ch
 [79.135.106.109])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 55E0F10FF06
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Nov 2026 08:51:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
 s=protonmail3; t=1794473463; x=1794732663;
 bh=NKe0z3zhu58XiC204Q8o1g7aUHJyLzvKnBmiAl5y15w=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=FYMdUEcqfIeqNZgVglGPb1b01rW3NU1CdS/xc6TKp4Y+Yir6abqUuopNJ43rDAfXq
 B6yPxCv9wt6vq1O20AJZK9/bDkR+RFR/GOuMRMIpGmzRNBFoQJACn3W4Og8f1WHQb+
 wu6eC9PwglEgJVMpKmXnGG2NGPF1WwsQvD/3O4sj7Z0KDkhFP8uzYyKNyyZM8HwxON
 B+qlDPzieHyW2jxNOU9DNXI++3NJL1sVutg6SW8NiZzkA9Ux+WQ1tsCckrCDtyIQ+r
 ApbeLOY1CKiwtw3R0d2G8mjFNC8lvr64VI36BmyVxqz+nF0OK2VjBSp5wowI0u9sBl
 5o08dNEXilI7A==
Date: Thu, 12 Nov 2026 08:51:00 +0000
To: Wayne Lin <Wayne.Lin@amd.com>
From: =?utf-8?Q?Eren_=C3=96zen?= <erenozen@protonmail.com>
Cc: amd-gfx@lists.freedesktop.org, Harry Wentland <harry.wentland@amd.com>,
 Leo Li <sunpeng.li@amd.com>, Aurabindo Pillai <aurabindo.pillai@amd.com>,
 Roman Li <roman.li@amd.com>, Tom Chung <chiahsuan.chung@amd.com>,
 Fangzhi Zuo <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>,
 Ray Wu <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>,
 Alex Hung <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>,
 Chenyu Chen <Chen-Yu.Chen@amd.com>
Subject: Re: [PATCH 10/74] drm/amd/display: Stop HDMI FRL status polling on
 fini
Message-ID: <rED2-IFmIfQnXszGhNHKi2hc_jxsJsEU-yuty77Fgml9pj38uzJmMp_PpCio0M493lCALIVVCLydqQuwmECVTuHZYOcTewJBotrH4nxAfc0=@protonmail.com>
In-Reply-To: <20261111014100.3596072-11-Wayne.Lin@amd.com>
References: <20261111014100.3596072-1-Wayne.Lin@amd.com>
 <20261111014100.3596072-11-Wayne.Lin@amd.com>
Feedback-ID: 19860221:user:proton
X-Pm-Message-ID: e0fd314b4845641718742a665b937203856281db
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

On Wed, 11 Nov 2026 09:28:16 +0800, Wayne Lin wrote:
> +=09/* The poll re-queues itself, so stop it before the wq and dc go away=
. */
> +=09if (adev->dm.hdmi_frl_status_polling_wq) {
> +=09=09cancel_delayed_work_sync(&adev->dm.hdmi_frl_status_polling_work);

This is the same change as patch 2/3 of a series I posted on Nov 10:
https://lore.kernel.org/all/20261110-frl-polling-wq-teardown-v1-0-0ff028d5c=
35b@protonmail.com/

I'm fine with either version going in, but checking the wq pointer
isn't enough on its own. amdgpu_dm_init() creates the wq before
amdgpu_dm_initialize_drm_device(), and hdmi_frl_status_polling_work is
only initialized later, in amdgpu_dm_connector_init_helper(). If init
fails between those two points (the dmub_notify or delayed_hpd_wq
allocation, for example), the error path calls amdgpu_dm_fini(), which
runs cancel_delayed_work_sync() on a work item that was never
initialized. __flush_work() then hits WARN_ON(!work->func).

Patch 1/3 of my series fixes that by moving INIT_DELAYED_WORK() into
amdgpu_dm_init(), before the wq is created. Patch 3/3 (don't queue the
work on a NULL wq when the wq allocation failed) isn't covered by this
batch either.

If this patch is applied, I'll rebase 1/3 and 3/3 on top of it and drop
2/3 in v2. Should I wait for this batch to land, or send v2 against
amd-staging-drm-next now?

One small request: my series was on the list the day before this batch.
Would you consider taking my 2/3 in place of this patch, or, if you'd
rather keep this version, adding a Reported-by: and a Link: to my
posting? This is my first kernel series, so the credit would mean a lot
to me.

Thanks,
Eren

