Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C01CC43334
	for <amd-gfx@archiver.kernel.org>; Sat, 18 Jun 2022 05:38:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 004F711AB88;
	Sat, 18 Jun 2022 05:38:32 +0000 (UTC)
Received: from mail-41104.protonmail.ch (mail-41104.protonmail.ch
 [185.70.41.104])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6EA3911AB84
 for <amd-gfx@lists.freedesktop.org>; Sat, 18 Jun 2022 05:38:30 +0000 (UTC)
Date: Sat, 18 Jun 2022 05:38:16 +0000
Authentication-Results: mail-41104.protonmail.ch;
 dkim=pass (2048-bit key) header.d=emersion.fr header.i=@emersion.fr
 header.b="tSyuifwb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emersion.fr;
 s=protonmail2; t=1655530703; x=1655789903;
 bh=zRwWsMDd5Kf2yQpedEA3Ka2dLpgNvYvwuOL0uYq4mxY=;
 h=Date:To:From:Cc:Reply-To:Subject:Message-ID:In-Reply-To:
 References:Feedback-ID:From:To:Cc:Date:Subject:Reply-To:
 Feedback-ID:Message-ID;
 b=tSyuifwbDS+nq+djQ6UlupBBlFH3ObNvyWiXS6k/EK1lYGEIxBeaDM7EN/IfpCs2Q
 n/nQgJOkiGJgQYHY4ECCKEzAs6QO44mcxo0XHN3e0IrjFGXfTr0B83F97Pm3yRf+uA
 ACYvdGGWr61XJ13gobn0YOffxqjoQxd1wHzs18t4SudiP15b6PJluRqWsQFQfOg0mk
 D/UG0sUVnhKQkEK5zgT2ixRnbFDvGXvmPC2VyInN+ckNJDWCRQbUc2+fhHafNeP6KO
 S+pdhmDvNuPDsQp81YUWx3XO7JPDpT7yfE+LFYRwg/+sW0ekGz534YeGtWm9s1tbbN
 8LmbCWNu/vitQ==
To: Souptick Joarder <jrdr.linux@gmail.com>
From: Simon Ser <contact@emersion.fr>
Subject: Re: [PATCH] drm/amd/display: Remove unused variable 'abo'
Message-ID: <_2lEhqJcf7dWZ9gxUFTqACIgfM7O6Mnus7HdamgrIT3zwLBiP7Quzy9MLnuFk5EYQAobBEa9UwI-1SSgEhmsncVEsKai10xWlJk8LvRs-W0=@emersion.fr>
In-Reply-To: <20220618015642.5958-1-jrdr.linux@gmail.com>
References: <20220618015642.5958-1-jrdr.linux@gmail.com>
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
Reply-To: Simon Ser <contact@emersion.fr>
Cc: Kernel test robot <lkp@intel.com>, sunpeng.li@amd.com, shenshih@amd.com,
 Xinhui.Pan@amd.com, Rodrigo.Siqueira@amd.com, Roman.Li@amd.com,
 amd-gfx@lists.freedesktop.org, nicholas.kazlauskas@amd.com, airlied@linux.ie,
 dri-devel@lists.freedesktop.org, daniel@ffwll.ch, Wayne.Lin@amd.com,
 alexander.deucher@amd.com, harry.wentland@amd.com, christian.koenig@amd.com,
 linux-kernel@vger.kernel.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Reviewed-by: Simon Ser <contact@emersion.fr>
