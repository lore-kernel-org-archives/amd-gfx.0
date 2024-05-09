Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6587EC25B10
	for <amd-gfx@archiver.kernel.org>; Fri, 10 May 2024 07:19:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CC01C10E4E1;
	Fri, 10 May 2024 07:19:45 +0000 (UTC)
Received: from irl.hu (irl.hu [95.85.9.111])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3A1F810E5DC
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 May 2024 20:55:09 +0000 (UTC)
Received: from fedori.lan (51b68e76.unconfigured.pool.telekom.hu
 [::ffff:81.182.142.118]) (AUTH: CRAM-MD5 soyer@irl.hu, )
 by irl.hu with ESMTPSA
 id 0000000000073AAE.00000000663D382B.00251B47; Thu, 09 May 2024 22:55:07 +0200
Message-ID: <e6eee6368dd5fd96631f20bd0a5a9576e0337549.camel@irl.hu>
Subject: Re: [PATCH] drm/amd/display: Don't register panel_power_savings on
 OLED panels
From: Gergo Koteles <soyer@irl.hu>
To: Mario Limonciello <mario.limonciello@amd.com>,
 amd-gfx@lists.freedesktop.org
Date: Thu, 09 May 2024 22:55:07 +0200
In-Reply-To: <20240509170524.34811-1-mario.limonciello@amd.com>
References: <20240509170524.34811-1-mario.limonciello@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.1 (3.52.1-1.fc40) 
MIME-Version: 1.0
X-Mailman-Approved-At: Fri, 10 May 2024 07:19:44 +0000
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

Hi Mario,

On Thu, 2024-05-09 at 12:05 -0500, Mario Limonciello wrote:
> OLED panels don't support the ABM, they shouldn't offer the
> panel_power_savings attribute to the user. Check whether aux BL
> control support was enabled to decide whether to offer it.
>=20
> Reported-by: Gergo Koteles <soyer@irl.hu>
> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3359
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---

It works on a Lenovo Yoga 7 14ARB7 laptop.

Tested-by: Gergo Koteles <soyer@irl.hu>

Best regards,
Gergo

