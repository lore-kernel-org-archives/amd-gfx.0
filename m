Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D693EB64DD
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Aug 2023 07:15:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 22C8410E256;
	Wed,  9 Aug 2023 07:14:58 +0000 (UTC)
X-Greylist: delayed 85609 seconds by postgrey-1.36 at gabe;
 Wed, 09 Aug 2023 06:27:42 UTC
Received: from mail-4319.protonmail.ch (mail-4319.protonmail.ch [185.70.43.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2D8A410E00F
 for <amd-gfx@lists.freedesktop.org>; Wed,  9 Aug 2023 06:27:42 +0000 (UTC)
Date: Wed, 09 Aug 2023 06:25:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
 s=protonmail3; t=1691562459; x=1691821659;
 bh=WGpo4uIMss2QKj9VET6gkilk/5xEnlxJboSXQR771Qc=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=f8eC5MV7GIz11V90us4esU3cWeH0v87IXipKeJJ/RE2wwqQeElkdVgdDnIU7zjVtG
 Ajt/GT6gwy7ae4NK6BtcCXz025Is6uUMT9FC/57Qm6amPugjENOnIQUbxzoL7yi2VR
 Ia7qGp7D+rn5O+mapYgTgSg9nZmml3Tfr1XFevaJ8Im8liOLFTzxaQ59/5d+PDT0M/
 3qwOG04busJZCFaOiAZlcztoDoqIUbG3En6TANHCu1loUB3n58ylniVsQ9BhTHXH8D
 rymHP0/06gmFwdt2ycRkh7OEAkUTtQJnQ3Uozk/VuUeAhPD8zj62oxlij5T+grtI4b
 dLgVdf3YC0SNg==
To: amd-gfx@lists.freedesktop.org
From: Umio Yasuno <coelacanth_dream@protonmail.com>
Subject: Re: [PATCH] fix throttle_status for other than MP0 11.0.7
Message-ID: <20230809062525.2346797-1-coelacanth_dream@protonmail.com>
In-Reply-To: <CADnq5_NdZzofSAoaEg+fZbbn1weELA8acJ++RuekVWH13+YLeA@mail.gmail.com>
References: <20230808064025.1008680-1-coelacanth_dream@protonmail.com>
 <DM6PR12MB26194F879FCE037C745B6D97E40DA@DM6PR12MB2619.namprd12.prod.outlook.com>
 <CADnq5_NdZzofSAoaEg+fZbbn1weELA8acJ++RuekVWH13+YLeA@mail.gmail.com>
Feedback-ID: 19510729:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Wed, 09 Aug 2023 07:14:50 +0000
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Evan Quan <evan.quan@amd.com>,
 Mario Limonciello <mario.limonciello@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Sorry, I had mistaken MP1 for MP0.
Also, should I add an `drm/amdgpu:` or `drm/amdgpu/swsmu` or `drm/amdgpu/pm=
` to
the prefix of the patch title?

