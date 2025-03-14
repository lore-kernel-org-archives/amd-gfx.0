Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6E22C282EC
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Mar 2025 12:55:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 843E610E368;
	Fri, 14 Mar 2025 12:55:37 +0000 (UTC)
Received: from einhorn-mail-out.in-berlin.de (einhorn.in-berlin.de
 [192.109.42.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E784210E9C2
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Mar 2025 11:06:33 +0000 (UTC)
X-Envelope-From: dieter@faulbaum.in-berlin.de
Received: from authenticated.user (localhost [127.0.0.1]) by
 einhorn.in-berlin.de with ESMTPSA id 52EB6JRJ803794
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 14 Mar 2025 12:06:19 +0100
Received: from frangula (frangula.xpertex.internal [172.16.3.241])
 by frangula.xpertex.internal (Postfix) with ESMTPSA id CAC5213C;
 Fri, 14 Mar 2025 12:06:18 +0100 (CET)
From: Dieter Faulbaum <dieter@faulbaum.in-berlin.de>
To: Philip Yang <yangp@amd.com>
Cc: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
 Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org,
 Felix.Kuehling@amd.com, Alexander.Deucher@amd.com,
 christian.koenig@amd.com, regressions@lists.linux.dev
Subject: Re: [PATCH v2 4/9] drm/amdkfd: Validate user queue buffers
In-Reply-To: <315e27ab-f1d1-a681-a32f-1fc28cd81193@amd.com> (Philip Yang's
 message of "Wed, 12 Feb 2025 18:02:15 -0500")
References: <20240718210558.26340-1-Philip.Yang@amd.com>
 <20240718210558.26340-5-Philip.Yang@amd.com>
 <zpzehsckjz2bee6w5bsnfpmkvtlxf6jywijz7iroausghoh43i@nxr644rwjsb3>
 <315e27ab-f1d1-a681-a32f-1fc28cd81193@amd.com>
Date: Fri, 14 Mar 2025 12:06:18 +0100
Message-ID: <rie1puzeus5.fsf@faulbaum.in-berlin.de>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Fri, 14 Mar 2025 12:55:36 +0000
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


Hello Philip,

Philip Yang <yangp@amd.com> writes:

> On 2025-02-12 17:42, Uwe Kleine-K=C3=B6nig wrote:
>
>  #regzbot introduced: 68e599db7a549f010a329515f3508d8a8c3467a4
> #regzbot monitor: https://bugs.debian.org/1093124
>
> Hello,
>
> On Thu, Jul 18, 2024 at 05:05:53PM -0400, Philip Yang wrote:
>
>  Find user queue rptr, ring buf, eop buffer and cwsr area BOs,=20
>  and
> check BOs are mapped on the GPU with correct size and take the=20
> BO
> reference.
>
> Signed-off-by: Philip Yang <Philip.Yang@amd.com>
> Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
>
>
> This change made it into v6.12-rc1 as 68e599db7a54 ("drm/amdkfd:
> Validate user queue buffers"). A Debian user (Dieter Faulbaum,=20
> on Cc)
> reported that this change introduced a regression using a gfx803=20
> device
> resulting in a HSA exception when e.g. darktable is used. I=20
> didn't even
> try to understand the problem, but maybe one of you have an idea=20
> about
> the issue?!
>
> Try this patch
>
> https://lore.kernel.org/all/20250130000412.29812-1-Philip.Yang@amd.com/T/

It seems for me, that your patch isn't applied in the mainline=20
kernel.
What do you think, will it once happen?-)
Is it falling through cracks?



With regards
Dieter
