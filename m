Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60A0CC001DF
	for <amd-gfx@archiver.kernel.org>; Sun, 22 Oct 2023 10:12:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E8D7110E061;
	Sun, 22 Oct 2023 10:12:37 +0000 (UTC)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B477410E061;
 Sun, 22 Oct 2023 10:12:35 +0000 (UTC)
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4SCvJc010vz9sc8;
 Sun, 22 Oct 2023 12:12:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1697969552;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=H9pCW3esi4cGD7GNRQGPwStAuhs4FyHDpTPRuNYfiwQ=;
 b=tc1k850Y28GbB7Cl2wR0AvUpKD7mgre+G/S1JH6+HThHgWTgY20W2td3ZGVPYKwOc+IrQ6
 lcw8W7BufgVozjqFwWWiZ3/GhtyYfTRVMpeCHjkxJZjv91Oq5O46of3h5BDn4dP8YyDi+R
 jbpTF2IpQDJNrblKoqa84AF3l8JLAhTvP7IgYBcn3wohHQH7TXGDQJcw94IKV6BCZyK5yU
 IjNh59RgtTX76msWZHMOWmQP6QGjU9HzpAH5AnQbmEk0gps/8VIaFVm13B44gRzICp3Usi
 6Ysr+5BWGHX110W0NQlU6xPhPkapbfUGQDRkdXjSZtoAJJ7uVeE2zOdGN2mokg==
Message-ID: <8c1641e4-a7e2-ecb2-ab7a-c6e2bb3e951b@mailbox.org>
Date: Sun, 22 Oct 2023 12:12:28 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v7 4/6] drm: Refuse to async flip with atomic prop changes
To: Simon Ser <contact@emersion.fr>, =?UTF-8?Q?Andr=c3=a9_Almeida?=
 <andrealmeid@igalia.com>
References: <20231017092837.32428-1-andrealmeid@igalia.com>
 <20231017092837.32428-5-andrealmeid@igalia.com>
 <CzEtDALWvF3EU4DDLLEmH3ms0B25PbsEHRU9b_IqwfyhzdG4zC-XXAU6fm2PnMcngAYmntH7s4iuew0vocN6cO8zUit8kgi-Sb1hBQXNYiw=@emersion.fr>
 <3r5-_03WC5dK3LaRt1Is78zD_bmT2aaGc5h9jpUGzo2o5GCtGP1zpQNzUxglsieewFklY7xwTrOS9jtI18YlNnnzHNx2Ccw9yM2NuJpDQZU=@emersion.fr>
Content-Language: de-CH-frami, en-CA
From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel.daenzer@mailbox.org>
In-Reply-To: <3r5-_03WC5dK3LaRt1Is78zD_bmT2aaGc5h9jpUGzo2o5GCtGP1zpQNzUxglsieewFklY7xwTrOS9jtI18YlNnnzHNx2Ccw9yM2NuJpDQZU=@emersion.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: s8qcypr51f1tfyaumquugzjaho4tpc7c
X-MBO-RS-ID: 1dd85632f82723d365f
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
Cc: pierre-eric.pelloux-prayer@amd.com,
 =?UTF-8?B?J01hcmVrIE9sxaHDoWsn?= <maraeo@gmail.com>,
 Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, Pekka Paalanen <ppaalanen@gmail.com>,
 dri-devel@lists.freedesktop.org, kernel-dev@igalia.com,
 alexander.deucher@amd.com, hwentlan@amd.com, christian.koenig@amd.com,
 joshua@froggi.es
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 10/17/23 14:16, Simon Ser wrote:
> After discussing with André it seems like we missed a plane type check
> here. We need to make sure FB_ID changes are only allowed on primary
> planes.

Can you elaborate why that's needed?


-- 
Earthling Michel Dänzer            |                  https://redhat.com
Libre software enthusiast          |         Mesa and Xwayland developer

