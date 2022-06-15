Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F1CCC433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Jun 2022 13:26:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D59C610EA58;
	Wed, 15 Jun 2022 13:26:58 +0000 (UTC)
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6D08F112343
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Jun 2022 11:12:10 +0000 (UTC)
Received: from eldfell (unknown [194.136.85.206])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested) (Authenticated sender: pq)
 by madras.collabora.co.uk (Postfix) with ESMTPSA id 116F466016C5;
 Wed, 15 Jun 2022 12:12:08 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1655291528;
 bh=ZpGPzHccUo8yAQt+G/6nBHYsUNSa9SSX5j/x8dPbgtg=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=gvAWv1FXrT52s5maj995fxnkvti/rrTAd5SoGZUKdzXeebrmK2RmEgi2ceU3X92Mq
 /WSTWEssXck0veUWZsOEm8yV5C7Ye6YYBIudj1qpvff3KQIlEmLKuHNULXvp3ntzTq
 dDHd5FndynjdX4RLGHXnwr/6copXSgjamespYvGj2FwUZ4WdT4z8axe1pS/EKUf5Ef
 FSPKGu0Cewksp898w/kX7zAam07RPh5a9BI8MeSephO6lNKelU6sjNVUpstz+6DwNd
 Gu1Srq2fN2jz8pU6+zMy1FayLKnFvIcWL0fxiWiL9AzzusC/eQwFeTbO/wjWiQWq1T
 5+lgGx6k7KiNQ==
Date: Wed, 15 Jun 2022 14:12:04 +0300
From: Pekka Paalanen <pekka.paalanen@collabora.com>
To: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Subject: Re: [PATCH 2/3] Documentation/gpu: Add an explanation about the DCN
 pipeline
Message-ID: <20220615141204.62ba64e1.pekka.paalanen@collabora.com>
In-Reply-To: <20220613200112.3377638-3-Rodrigo.Siqueira@amd.com>
References: <20220613200112.3377638-1-Rodrigo.Siqueira@amd.com>
 <20220613200112.3377638-3-Rodrigo.Siqueira@amd.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Wed, 15 Jun 2022 13:26:57 +0000
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
Cc: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 Mark Yacoub <markyacoub@chromium.org>, Simon Ser <contact@emersion.fr>,
 Michel =?UTF-8?B?RMOkbnplcg==?= <michel.daenzer@mailbox.org>,
 Alex Hung <alex.hung@amd.com>, maira.canal@usp.br,
 amd-gfx@lists.freedesktop.org, mwen@igalia.com, Leo Li <sunpeng.li@amd.com>,
 Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>, Hersen Wu <hersenxs.wu@amd.com>,
 tales.aparecida@gmail.com, Sean Paul <seanpaul@chromium.org>,
 isabbasso@riseup.net, andrealmeid@riseup.net,
 Harry Wentland <harry.wentland@amd.com>,
 Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>,
 Pierre-Loup <pgriffais@valvesoftware.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, 13 Jun 2022 16:01:11 -0400
Rodrigo Siqueira <Rodrigo.Siqueira@amd.com> wrote:

> In the DCN code, we constantly talk about hardware pipeline, pipeline,
> or even just pipes, which is a concept that is not obvious to everyone.
> For this reason, this commit expands the DCN overview explanation by
> adding a new section that describes what a pipeline is from the DCN
> perspective.
>=20
> Cc: Harry Wentland <harry.wentland@amd.com>
> Cc: Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
> Cc: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
> Cc: Hersen Wu <hersenxs.wu@amd.com>
> Cc: Alex Hung <alex.hung@amd.com>
> Cc: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
> Cc: Leo Li <sunpeng.li@amd.com>
> Cc: Simon Ser <contact@emersion.fr>
> Cc: Pekka Paalanen <pekka.paalanen@collabora.com>
> Cc: Sean Paul <seanpaul@chromium.org>
> Cc: Mark Yacoub <markyacoub@chromium.org>
> Cc: Pierre-Loup <pgriffais@valvesoftware.com>
> Cc: Michel D=C3=A4nzer <michel.daenzer@mailbox.org>
> Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
> ---
>  .../gpu/amdgpu/display/dcn-overview.rst       |   58 +
>  .../amdgpu/display/pipeline_4k_no_split.svg   |  958 +++++++++++++++
>  .../gpu/amdgpu/display/pipeline_4k_split.svg  | 1062 +++++++++++++++++
>  3 files changed, 2078 insertions(+)
>  create mode 100644 Documentation/gpu/amdgpu/display/pipeline_4k_no_split=
.svg
>  create mode 100644 Documentation/gpu/amdgpu/display/pipeline_4k_split.svg
>=20
> diff --git a/Documentation/gpu/amdgpu/display/dcn-overview.rst b/Document=
ation/gpu/amdgpu/display/dcn-overview.rst
> index f98624d7828e..430e363fccae 100644
> --- a/Documentation/gpu/amdgpu/display/dcn-overview.rst
> +++ b/Documentation/gpu/amdgpu/display/dcn-overview.rst
> @@ -124,6 +124,64 @@ depth format), bit-depth reduction/dithering would k=
ick in. In OPP, we would
>  also apply a regamma function to introduce the gamma removed earlier bac=
k.
>  Eventually, we output data in integer format at DIO.
> =20

Hi,

always nice to see more docs!

> +AMD Hardware Pipeline
> +---------------------
> +
> +When discussing graphics on Linux, the **pipeline** term is often overlo=
aded
> +with multiple meanings, and DCN adds another context to this word. In th=
e DCN
> +driver, we use the term **hardware pipeline** or  **pipeline** or just *=
*pipe**
> +to indicate how many DCN blocks we are instantiating to address some spe=
cific

This seems to say that a "pipeline" is a number, a count (how many).

> +configuration. DCN composes those pipelines together when the data reach=
 the

This seems to imply that each "DCN block" is "a pipeline".

Is either true? Is a pipeline not a sequence of selected DCN blocks
instead?

> +end of the OPTC block before sending it to the display. We have this pip=
eline
> +concept for trying to save energy and optimize bandwidth utilization whi=
le
> +providing the maximum performance per watt. It is easier to discuss it i=
f we
> +dive into this topic by taking the example of a 4k display in the below
> +example:
> +
> +.. kernel-figure:: pipeline_4k_no_split.svg

A bit too hard for me to look at SVGs from email patches, sorry.

You wouldn't happen to have a git branch available in Gitlab or Github
or even cgit somewhere I could visit with my browser?


Thanks,
pq

> +
> +Additionally, let's take a look at parts of the DTN log (see
> +'Documentation/gpu/amdgpu/display/dc-debug.rst' for more information) si=
nce
> +this log can help us to see part of this pipeline behavior in real-time::
> +
> + HUBP:  format  addr_hi  width  height ...
> + [ 0]:      8h      81h   3840    2160
> + [ 1]:      0h       0h      0       0
> + [ 2]:      0h       0h      0       0
> + [ 3]:      0h       0h      0       0
> + [ 4]:      0h       0h      0       0
> + ...
> + MPCC:  OPP  DPP ...
> + [ 0]:   0h   0h ...
> +
> +The first thing to notice from the diagram and DTN log it is the fact th=
at we
> +have different clock domains for each part of the DCN blocks. In this ex=
ample,
> +we have just a single **pipeline** where the data flows from DCHUB to DI=
O, as
> +we intuitively expect. Nonetheless, DCN is flexible, as mentioned before=
, and
> +we can split this single pipe differently, as described in the below dia=
gram:
> +
> +.. kernel-figure:: pipeline_4k_split.svg
> +
> +Now, if we inspect the DTN log again we can see some interesting changes=
::
> +
> + HUBP:  format  addr_hi  width  height ...
> + [ 0]:      8h      81h   1920    2160 ...
> + ...
> + [ 4]:      0h       0h      0       0 ...
> + [ 5]:      8h      81h   1920    2160 ...
> + ...
> + MPCC:  OPP  DPP ...
> + [ 0]:   0h   0h ...
> + [ 5]:   0h   5h ...
> +
> +From the above example, we now split the display pipeline into two verti=
cal
> +parts of 1920x2160 (i.e., 3440x2160), and as a result, we could reduce t=
he
> +clock frequency in the DPP part. This is not only useful for saving powe=
r but
> +also to better handle the required throughput. The idea to keep in mind =
here is
> +that the pipe configuration can vary a lot according to the display
> +configuration, and it is the DML's responsibility to set up all required
> +configuration parameters for multiple scenarios supported by our hardwar=
e.
> +
>  Global Sync
>  -----------
> =20
