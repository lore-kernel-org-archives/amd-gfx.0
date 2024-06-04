Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45071C27C5E
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Jun 2024 12:57:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A1DE710E7C1;
	Wed,  5 Jun 2024 12:57:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=arndb.de header.i=@arndb.de header.b="WKqt6wLQ";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="dV45h+Zg";
	dkim-atps=neutral
X-Greylist: delayed 484 seconds by postgrey-1.36 at gabe;
 Tue, 04 Jun 2024 19:51:04 UTC
Received: from wfout1-smtp.messagingengine.com
 (wfout1-smtp.messagingengine.com [64.147.123.144])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8A10310E5E5
 for <amd-gfx@lists.freedesktop.org>; Tue,  4 Jun 2024 19:51:04 +0000 (UTC)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
 by mailfout.west.internal (Postfix) with ESMTP id 946591C001B2;
 Tue,  4 Jun 2024 15:42:58 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
 by compute5.internal (MEProxy); Tue, 04 Jun 2024 15:42:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
 :cc:content-type:content-type:date:date:from:from:in-reply-to
 :in-reply-to:message-id:mime-version:references:reply-to:subject
 :subject:to:to; s=fm3; t=1717530178; x=1717616578; bh=iXZMhUnBqt
 w5kIWzk158K4r92P57EhyAAjC0zc8jpqs=; b=WKqt6wLQPdEni9R5OyIc1b1ISC
 NNtiiYCyZO8mA7H8RjfLDN0Dv11/3x+MG4yHtnVDWbLtlxqf/GWx+RaUtqUP18Oc
 adG38FTZNGLZAUIh/m920Eimmp1H+ObAN2yJGmJEdfiOGrNKqB0LzjQVPAeQ6HAS
 qDxgR6sX+x7sDfWcBY1VD+t2znt3+J76OPfsKw+gnQcQh+IKxGYpHMtbySrc0DpW
 4Vb4IV281Dz011HwPBHvjOvsCofRabMFLv1rMqfdGz0PEXJiM9D/B0/9lglfR9/A
 fdbFFNAUuOlWCE3x0zfCfrPP5qREHR8YVJaKa51gy0zMcdQPAsO2bA1FJvSg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:content-type:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm1; t=1717530178; x=1717616578; bh=iXZMhUnBqtw5kIWzk158K4r92P57
 EhyAAjC0zc8jpqs=; b=dV45h+ZgnmnB2dd909KX3s4Nk0otZb9l2TPv+YvN9vho
 eX/VUExUhMiM3JzsKHZJWo0VbVsTZUhR+dA8JFaMUBWuMtZTVkvYlOfDSeFxTksE
 0kh+KEzfHFmPeB+gJQIFzMcHFNpc8QSc7IC6MjEXyNX/z2GzOG3BVkzEYtKHuEh7
 bMku7T+JN8VhWpchv1jYPSP2EhnCmII7nbWOj5BtrqmzcOlTtoqJP7SR0nS2ST1R
 /42JbhdyQNMnB+urHnB7dzlAbtd5o3zFRwk0gTDvoMqYODH44vn6Rme9iuceJhqj
 AU99hW4KOWm9mPkKFq2TCDi72ycFSjLtGA0yBPcAvA==
X-ME-Sender: <xms:QW5fZsd4GHZTcokofJAw75cPgFsaI26s_QgOImXfJYo5m7UFIeCiuA>
 <xme:QW5fZuNSWHac3V0C0cWi4U9qqt4XZq1HIoDHtuawk68Qw-gyRFe8Lp3EN9mtmiHKT
 hb1Pvx4BIphbcFt2yQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdelgedgudefhecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
 necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
 enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdet
 rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
 htthgvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedt
 keetffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
 grrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:QW5fZtiUt_hSlfg1fpUminfYrU_Q8XdN3Nn6X5SSG0b1v07hmNNxkA>
 <xmx:QW5fZh_c56EJXDBnvCVIuj28WpN9sLX8sKtB9eJsn-bs9cZOqJgs7A>
 <xmx:QW5fZotXVEoNK63ZXIjr8OBcde-3839M59a7S4YWPy-sw_MHe1QsDA>
 <xmx:QW5fZoHEmitQGPy9lH69OXgxXh9rSp0Hvmk4sn0pjhGmpWbvr6BzQQ>
 <xmx:Qm5fZt9bWF4D6CSCnz2Rfw7yVRzBwsDxaJUgLDUBOEv7XEbZtrS3gkfk>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
 id B7A4CB6008F; Tue,  4 Jun 2024 15:42:57 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-497-g97f96844c-fm-20240526.001-g97f96844
MIME-Version: 1.0
Message-Id: <bd5302af-ae99-4af9-91c3-b1a95a29879d@app.fastmail.com>
In-Reply-To: <20240604180619.600760-1-alexander.deucher@amd.com>
References: <20240604180619.600760-1-alexander.deucher@amd.com>
Date: Tue, 04 Jun 2024 21:42:36 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Alex Deucher" <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
Cc: "George Zhang" <George.zhang@amd.com>,
 "Hamza Mahfooz" <hamza.mahfooz@amd.com>,
 "Harry Wentland" <harry.wentland@amd.com>, "Leo Li" <sunpeng.li@amd.com>,
 "Rodrigo Siqueira" <Rodrigo.Siqueira@amd.com>,
 "Joshua Aberback" <joshua.aberback@amd.com>
Subject: Re: [PATCH 1/2] drm/amd/display: use pre-allocated temp structure for
 bounding box
Content-Type: text/plain
X-Mailman-Approved-At: Wed, 05 Jun 2024 12:57:07 +0000
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

On Tue, Jun 4, 2024, at 20:06, Alex Deucher wrote:
> This mirrors what the driver does for older DCN generations.
>
> Should fix:
>
> BUG: sleeping function called from invalid context at 
> include/linux/sched/mm.h:306
> in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 449, name: 
> kworker/u64:8
> preempt_count: 2, expected: 0
> RCU nest depth: 0, expected: 0
> Preemption disabled at:
> ffffffffc0ce1580>] dc_fpu_begin+0x30/0xd0 [amdgpu]
> CPU: 5 PID: 449 Comm: kworker/u64:8 Tainted: G        W          6.8.0+ 
> #35
> Hardware name: System manufacturer System Product Name/ROG STRIX X570-E 
> GAMING WIFI II, BIOS 4204 02/24/2022
> Workqueue: events_unbound async_run_entry_fn
>
> Fixes: 88c61827cedc ("drm/amd/display: dynamically allocate 
> dml2_configuration_options structures")
> Tested-by: George Zhang <George.zhang@amd.com>
> Suggested-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> Cc: George Zhang <george.zhang@amd.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: harry.wentland@amd.com
> Cc: sunpeng.li@amd.com
> Cc: Rodrigo.Siqueira@amd.com

That looks nicer than all the other suggestions, thanks!

Acked-by: Arnd Bergmann <arnd@arndb.de>

One part sticks out though:

> @@ -2027,7 +2025,7 @@ static void dcn32_update_bw_bounding_box(struct 
> dc *dc, struct clk_bw_params *bw
> 
>  	DC_FP_END();
> 
> -	kfree(dml2_opt);
> +	memcpy(&dc->dml2_options, dml2_opt, sizeof(dc->dml2_options));
>  }

The driver did not copy the data back before, so this is a
change in behavior. Is that intentional or a mistake?

If the intention is to have the data copied back into
dc->dml2_options in the end, wouldn't it be easier to
just pass a pointer as in the old version before commit
e779f4587f61 ("drm/amd/display: Add handling for DC power
mode")?

     Arnd
