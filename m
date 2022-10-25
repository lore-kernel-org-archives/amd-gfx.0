Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B23DCC04A95
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Oct 2022 07:25:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B01D310E18B;
	Tue, 25 Oct 2022 07:25:11 +0000 (UTC)
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com
 [66.111.4.28])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B747510E0B0
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Oct 2022 03:23:49 +0000 (UTC)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
 by mailout.nyi.internal (Postfix) with ESMTP id 5307A5C014E;
 Mon, 24 Oct 2022 23:23:47 -0400 (EDT)
Received: from imap47 ([10.202.2.97])
 by compute5.internal (MEProxy); Mon, 24 Oct 2022 23:23:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lunnova.dev; h=
 cc:content-transfer-encoding:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:sender:subject:subject:to:to; s=fm1; t=1666668227; x=
 1666754627; bh=PTO0nLnc0QQBliLpeSTBo+dWNW3ZR0ukG2MTy7ih80U=; b=r
 P1Zp3x2xtD6ceQST96JOfJ/L9kZuMoxlYMq3BsvSjJXOM1bAMfNkPA1147mlY85Q
 /r9TBMvYXe9HviXnCMaGxmf7tT4KH0ZpeGLIjLmNmr52clX6TBDhiRLUES4/jDhS
 6LEP+xJC7x9Q/PAbUMwveyMAlE87O5nt4gUvhpKYdqqI+nEl0+WbziBirQK5moCC
 ePnwe2TbtCgZ7PMjqHWjzjALotHruPA7xpgrwpFohjvfFPzsqP7xq8NHWM+Jw7Bk
 a/Vqz0yry0RKyWx1wIsqSN5xuaMvnIFU35qwiH6XuZXr4n+0/CrM9IOxyrmyyG7Y
 CnZFuFSTffhu4baXzCf0Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:content-type
 :date:date:feedback-id:feedback-id:from:from:in-reply-to
 :in-reply-to:message-id:mime-version:references:reply-to:sender
 :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm3; t=1666668227; x=1666754627; bh=P
 TO0nLnc0QQBliLpeSTBo+dWNW3ZR0ukG2MTy7ih80U=; b=q8m8yuLMR4nlaZuS4
 wkaejhaIpRGyVwQjsXoj/BiyzUVEyryYTh6zj6EkHulFsx9m9zo+Z1Zv5b6cOyYv
 ahvpYiSUgHJiWKxKnY4jpfwZh1551noBlZBf3RYYeofhLWU3A31FUKcPLHkJKDsu
 CXrAQXzwtMpn+Lnv183s3FZ8ynCVD8AZ8BxSrLl2LRmJswxTR6eQ6XzkzsIv4jds
 DeVz8tygDbm/XZY3bQV/fKoVsfi9/4xeA5+1FzzxN4FxZDYXJ2esNAMvpyyGF+G5
 yXKaz4v9XixMveBfvWN/5r+AqL1sbaRr+uIUv7q6B2tQegWNd3kpJEKthYWCaJFJ
 lrPqA==
X-ME-Sender: <xms:w1ZXYxjj2Fi064lFsORrHnw-QuZ1OTb23XtyDhTtyWUv9CIGh8rf3g>
 <xme:w1ZXY2BddiKFIg0cYw62PgdeDGORJBhez3P34R25dVenMu3FIN5UO_P5awx9svoDz
 plGb91g5_IzW1H8Pg4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrgedthedgjedvucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucenucfjughrpefofgggkfgjfhffhffvufgtgfesth
 hqredtreerjeenucfhrhhomhepfdfnuhhnrgcupfhovhgrfdcuoehgihhtsehluhhnnhho
 vhgrrdguvghvqeenucggtffrrghtthgvrhhnpeejkeetveeluefgtefglefhvedtteelue
 dvfeehvdeltdeivefhheeugefffeevvdenucevlhhushhtvghrufhiiigvpedtnecurfgr
 rhgrmhepmhgrihhlfhhrohhmpehgihhtsehluhhnnhhovhgrrdguvghv
X-ME-Proxy: <xmx:w1ZXYxFaKlANd-B2pxNLvGGOrH9fHM7-3k76k1NrjleeiY8Xu0VslA>
 <xmx:w1ZXY2QLgzlu3qlJ3Pb0EUPn9w5E-8JkJ6wjSaUgZO53b5u6DgEnLw>
 <xmx:w1ZXY-x1e60vugmFQdzsq9BBAOKa0WEUdlIgJHKMIdNo-3w-BqHXog>
 <xmx:w1ZXYzvc5IPTh0QZgb1Qi5XJGdj_QGZCow-bidoxH6s_4CeBfu-Q7A>
Feedback-ID: i9ac946e8:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
 id 1F8BBA6007C; Mon, 24 Oct 2022 23:23:47 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-1047-g9e4af4ada4-fm-20221005.001-g9e4af4ad
Mime-Version: 1.0
Message-Id: <f49e6008-fd01-4942-b39a-ab605548ade2@app.fastmail.com>
In-Reply-To: <20221014084641.128280-2-christian.koenig@amd.com>
References: <20221014084641.128280-1-christian.koenig@amd.com>
 <20221014084641.128280-2-christian.koenig@amd.com>
Date: Mon, 24 Oct 2022 20:23:26 -0700
From: "Luna Nova" <git@lunnova.dev>
To: amd-gfx@lists.freedesktop.org, christian.koenig@amd.com
Subject: Re: [PATCH 01/13] drm/scheduler: fix fence ref counting
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Tue, 25 Oct 2022 07:24:58 +0000
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

This patch doesn't apply nicely on 6.0, seems amd-staging-drm-next is mi=
ssing 9b04369b060fd4885f728b7a4ab4851ffb1abb64 drm/scheduler: Don't kill=
 jobs in interrupt context

On Fri, 14 Oct 2022, at 01:46, Christian K=C3=B6nig wrote:
> We leaked dependency fences when processes were beeing killed.
>=20
> Additional to that grab a reference to the last scheduled fence.
> diff --git a/drivers/gpu/drm/scheduler/sched_entity.c b/drivers/gpu/dr=
m/scheduler/sched_entity.c
> index 43d337d8b153..243ff384cde8 100644
> --- a/drivers/gpu/drm/scheduler/sched_entity.c
> +++ b/drivers/gpu/drm/scheduler/sched_entity.c
> @@ -207,6 +207,7 @@ static void drm_sched_entity_kill_jobs_cb(struct d=
ma_fence *f,
> struct drm_sched_job *job =3D container_of(cb, struct drm_sched_job,
> finish_cb);
> =20
> + dma_fence_put(f);
Conflict here, is INIT_WORK with that commit.
> init_irq_work(&job->work, drm_sched_entity_kill_jobs_irq_work);
> irq_work_queue(&job->work);

