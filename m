Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D215606A321
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Nov 2026 13:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=protonmail.com header.i=@protonmail.com header.a=rsa-sha256 header.s=protonmail3 header.b=SnfYgowD
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D324D11213E;
	Thu, 12 Nov 2026 13:56:07 +0000 (UTC)
Received: from mail-4327.protonmail.ch (mail-4327.protonmail.ch [185.70.43.27])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4596510E1DE
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Nov 2026 07:22:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
 s=protonmail3; t=1794467834; x=1794727034;
 bh=H/FcLJDmrrH/TS/kJuCBQLAqGChNQ2hnRw7CRE8AXdM=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=SnfYgowDj0TJ+9qGa6QBmEH1eTajRC4G4zpSQtFLCCN0v037p0Dsvt7ECPdwvnnPP
 aK71oVlv6+c65rHSZuF58nbc2EBghCS7P+LBth59buBV2yV55CF3aQ2JFThIc11edl
 koH8eLJSHNWJFtKHYx5WB06v6Q+sxDuEqF/g/2ex1RxyDGF/suEk2xewFBXIm0t5sI
 Y+PhyzyTHj7eEd6T1K5cKhvY2AzE+23PmFXBY708Ob/AEBB5sObWdvXtLw3mkAb+E1
 IrFr6xsTQbh9bDlrHW+7/bj4PPmiwkQU1328kNW/VebITa3nPFFLv0qBenT7G0wq+Q
 zQvY3t+xdQbEA==
Date: Thu, 12 Nov 2026 07:17:11 +0000
To: Wayne Lin <Wayne.Lin@amd.com>
From: =?utf-8?Q?Eren_=C3=96zen?= <erenozen@protonmail.com>
Cc: amd-gfx@lists.freedesktop.org, Harry Wentland <harry.wentland@amd.com>,
 Leo Li <sunpeng.li@amd.com>, Aurabindo Pillai <aurabindo.pillai@amd.com>,
 Roman Li <roman.li@amd.com>, Tom Chung <chiahsuan.chung@amd.com>,
 Fangzhi Zuo <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>,
 Ray Wu <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>,
 Alex Hung <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>,
 Chenyu Chen <Chen-Yu.Chen@amd.com>
Subject: Re: [PATCH 63/74] drm/amd/display: Expect VRAM|GTT for the DMUB
 framebuffer
Message-ID: <WkzHH7HuTq1aeeOZT_ixs6PCtY8cUwuSO1RXPTESv4vNktjFjx8pxsJ3HRSgT37hQhiwobppnBBzhaptR_azyxIjm_KDRX9xvyWu0SKexWI=@protonmail.com>
In-Reply-To: <20261111014100.3596072-64-Wayne.Lin@amd.com>
References: <20261111014100.3596072-1-Wayne.Lin@amd.com>
 <20261111014100.3596072-64-Wayne.Lin@amd.com>
Feedback-ID: 19860221:user:proton
X-Pm-Message-ID: 866cff9df6b72a06cb48c9d2f3f77da12482409d
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Thu, 12 Nov 2026 13:56:07 +0000
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
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Nov 11, 2026 at 09:29:09AM +0800, Wayne Lin wrote:
> The DCN32 GTT-only framebuffer allocation was reverted, so
> dm_dmub_sw_init() passes VRAM and GTT for every ASIC. The KUnit
> case still required GTT alone and failed with domain 0x6.

I hit this failure too. Ran the amdgpu_dm KUnit suite on UML
(kunit.py, amdgpu_dm/tests .kunitconfig, GCC 16, CONFIG_GCOV=3Dn) on
amd-staging-drm-next 47df73aa49:

  before: 1910/1912 passed (create_domain 0x6, expected 0x2)
  after this patch and 44/74: 1912/1912 passed

Tested-by: Eren =C3=96zen <erenozen@protonmail.com>

