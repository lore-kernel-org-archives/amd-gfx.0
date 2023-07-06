Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E94A1EB64DC
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Jul 2023 14:11:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 541A710E405;
	Thu,  6 Jul 2023 14:11:44 +0000 (UTC)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E451410E405
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Jul 2023 14:11:42 +0000 (UTC)
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4QxdkL0jrjz9sq7;
 Thu,  6 Jul 2023 16:11:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1688652698;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LxsfBNOmBml68i855IXZMzamK8M/lhPkxU9Ey3Yl5Yw=;
 b=V1EuurTmt/EdQ5E3EC/D/2uW7yLDKp93cx3q+f19TqXH5OgAGs15Gyb8Z9UUJCBioyiWCJ
 km7xDfn1h+OgIodHQQ6G7TlY5w6ijb2ofbrvai749xtgGwaXX4GMROICjoGY9WxdpNhQtB
 Zl///vXufD95HrZA5FSScBcf+Ji2M/noC2LS9ATWl1Jkhqg2dEDyEJ0dmMqZ0oiIzOvUME
 6VbvUJdiciZKC9au6vrxNyqQCW9K5x5u9u3s7+YKaIOcx2cu9N8zxtbPJdi3ubo3uUVEQI
 vIbl5YI1X+nGPhqJTufkt5Z2zBqnp36re08PzYC0ckzydFyeB6riWRXXMuh4gA==
Message-ID: <a5a0551f-74cb-7ec0-eec8-2d82f193d98b@mailbox.org>
Date: Thu, 6 Jul 2023 16:11:36 +0200
MIME-Version: 1.0
Subject: Re: [PATCH 1/2] drm/amd/display: Do not set drr on pipe commit
Content-Language: en-CA
To: "Pillai, Aurabindo" <Aurabindo.Pillai@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20230705180752.2813978-1-aurabindo.pillai@amd.com>
 <dc331ebc-7032-033a-0076-b80472920e79@mailbox.org>
 <CH0PR12MB528437E7114C0CD07C1491F38B2CA@CH0PR12MB5284.namprd12.prod.outlook.com>
From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel.daenzer@mailbox.org>
In-Reply-To: <CH0PR12MB528437E7114C0CD07C1491F38B2CA@CH0PR12MB5284.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: c7n17zjzicx5dx394w64tmde4f9ars6g
X-MBO-RS-ID: dbc5db8ec257541360d
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
Cc: "Chalmers, Wesley" <Wesley.Chalmers@amd.com>, "Siqueira,
 Rodrigo" <Rodrigo.Siqueira@amd.com>, "Wheeler,
 Daniel" <Daniel.Wheeler@amd.com>, "Mahfooz, Hamza" <Hamza.Mahfooz@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Wentland,
 Harry" <Harry.Wentland@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 7/6/23 15:55, Pillai, Aurabindo wrote:
> 
> Hi Michel,
> 
> You confirmed in another thread the monitor specific quirk for disabling FAMS fixed your hang. 

That's not quite accurate. I confirmed that hard-coding FAMS to be disabled works around the hangs I reported, and you asked me to test an EDID quirk patch, which I reported not to have any effect for my monitor. Then I didn't hear back anything until this patch series today, so I haven't tested the de1da2f7fe25 commit. (I expect it to work, but I can't confirm it yet)


-- 
Earthling Michel Dänzer            |                  https://redhat.com
Libre software enthusiast          |         Mesa and Xwayland developer

