Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21E40CCA480
	for <amd-gfx@archiver.kernel.org>; Sat, 18 Jun 2022 13:54:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5F58410E706;
	Sat, 18 Jun 2022 13:54:56 +0000 (UTC)
Received: from madras.collabora.co.uk (madras.collabora.co.uk
 [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0AA4B11A9BE
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Jun 2022 07:35:23 +0000 (UTC)
Received: from eldfell (unknown [194.136.85.206])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested) (Authenticated sender: pq)
 by madras.collabora.co.uk (Postfix) with ESMTPSA id AFCA56601797;
 Fri, 17 Jun 2022 08:35:20 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1655451321;
 bh=H9zb0Fos07H+NZxC44HFd4dgmpvpAX8KofZH4Who7zU=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=a/z2/+CfDOFse55hnT9iquruiHEhnKkljWR6xk8rnVCVj6j3rnF/dhCS47IETC8do
 8GZ+C3HzxCvus9j2MBP5AoI7vbM8UQqcSgtigo7URDJZfNKDitg+xO1NgaaKMvxRzU
 DzaoCGGEhN6Th8ubj2HMrJKatq9Ia2oZZRIkWi8evqfT67NWapAOOhmqSAEfI40tqq
 jcksojVdQAWjqcDipy47osKAzvI0g1ci1OFuV/8DLeXc2Gn8ze1ouB9izIIjNmf7gS
 56p035qcJIiwu9ij7ilblyImqh3m2fBw9UfJIp1bDndeB6tMuq1vfZZFAlQPMiIyaa
 f7//07dkSVd3Q==
Date: Fri, 17 Jun 2022 10:35:17 +0300
From: Pekka Paalanen <pekka.paalanen@collabora.com>
To: Rodrigo Siqueira Jordao <Rodrigo.Siqueira@amd.com>
Subject: Re: [PATCH 2/3] Documentation/gpu: Add an explanation about the DCN
 pipeline
Message-ID: <20220617103517.68b9503b.pekka.paalanen@collabora.com>
In-Reply-To: <d48aa87e-b5fa-0437-d637-d7306b115311@amd.com>
References: <20220613200112.3377638-1-Rodrigo.Siqueira@amd.com>
 <20220613200112.3377638-3-Rodrigo.Siqueira@amd.com>
 <20220615141204.62ba64e1.pekka.paalanen@collabora.com>
 <d48aa87e-b5fa-0437-d637-d7306b115311@amd.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Sat, 18 Jun 2022 13:54:45 +0000
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

On Thu, 16 Jun 2022 17:59:21 -0400
Rodrigo Siqueira Jordao <Rodrigo.Siqueira@amd.com> wrote:

> On 2022-06-15 07:12, Pekka Paalanen wrote:
> > On Mon, 13 Jun 2022 16:01:11 -0400
> > Rodrigo Siqueira <Rodrigo.Siqueira@amd.com> wrote:
> >  =20
> >> In the DCN code, we constantly talk about hardware pipeline, pipeline,
> >> or even just pipes, which is a concept that is not obvious to everyone.
> >> For this reason, this commit expands the DCN overview explanation by
> >> adding a new section that describes what a pipeline is from the DCN
> >> perspective.
> >>
> >> Cc: Harry Wentland <harry.wentland@amd.com>
> >> Cc: Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
> >> Cc: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
> >> Cc: Hersen Wu <hersenxs.wu@amd.com>
> >> Cc: Alex Hung <alex.hung@amd.com>
> >> Cc: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
> >> Cc: Leo Li <sunpeng.li@amd.com>
> >> Cc: Simon Ser <contact@emersion.fr>
> >> Cc: Pekka Paalanen <pekka.paalanen@collabora.com>
> >> Cc: Sean Paul <seanpaul@chromium.org>
> >> Cc: Mark Yacoub <markyacoub@chromium.org>
> >> Cc: Pierre-Loup <pgriffais@valvesoftware.com>
> >> Cc: Michel D=C3=A4nzer <michel.daenzer@mailbox.org>
> >> Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
> >> ---
> >>   .../gpu/amdgpu/display/dcn-overview.rst       |   58 +
> >>   .../amdgpu/display/pipeline_4k_no_split.svg   |  958 +++++++++++++++
> >>   .../gpu/amdgpu/display/pipeline_4k_split.svg  | 1062 +++++++++++++++=
++
> >>   3 files changed, 2078 insertions(+)
> >>   create mode 100644 Documentation/gpu/amdgpu/display/pipeline_4k_no_s=
plit.svg
> >>   create mode 100644 Documentation/gpu/amdgpu/display/pipeline_4k_spli=
t.svg
> >>
> >> diff --git a/Documentation/gpu/amdgpu/display/dcn-overview.rst b/Docum=
entation/gpu/amdgpu/display/dcn-overview.rst
> >> index f98624d7828e..430e363fccae 100644
> >> --- a/Documentation/gpu/amdgpu/display/dcn-overview.rst
> >> +++ b/Documentation/gpu/amdgpu/display/dcn-overview.rst
> >> @@ -124,6 +124,64 @@ depth format), bit-depth reduction/dithering woul=
d kick in. In OPP, we would
> >>   also apply a regamma function to introduce the gamma removed earlier=
 back.
> >>   Eventually, we output data in integer format at DIO.
> >>    =20
> >=20
> > Hi,
> >=20
> > always nice to see more docs! =20
>=20
> Hi Pekka,
>=20
> First of all, thanks for your review.
>=20
> >  =20
> >> +AMD Hardware Pipeline
> >> +---------------------
> >> +
> >> +When discussing graphics on Linux, the **pipeline** term is often ove=
rloaded
> >> +with multiple meanings, and DCN adds another context to this word. In=
 the DCN
> >> +driver, we use the term **hardware pipeline** or  **pipeline** or jus=
t **pipe**
> >> +to indicate how many DCN blocks we are instantiating to address some =
specific =20
> >=20
> > This seems to say that a "pipeline" is a number, a count (how many).
> >  =20
> >> +configuration. DCN composes those pipelines together when the data re=
ach the =20
> >=20
> > This seems to imply that each "DCN block" is "a pipeline".
> >=20
> > Is either true? Is a pipeline not a sequence of selected DCN blocks
> > instead? =20
>=20
> In the DCN we can have different pipeline configurations. For example,=20
> see the below picture:
>=20
> =20
> https://www.kernel.org/doc/html/latest/gpu/amdgpu/display/dcn-overview.ht=
ml
>=20
> Let's say that our pipeline policy does not allow pipe split, in that=20
> case we will have just one instance of each component. However, if we=20
> decided to split our pipe, we will have more instance of the other=20
> components (e.g., 2 DPP). I added some examples about it a little bit=20
> below in this patch.
>=20
> Try to apply my series in your local kernel [1]. That way you will be=20
> able to open the svg files at Documentation/gpu/amdgpu/display/.

Sorry, that's too much to ask for patch review on a project I don't
work on.

> Maybe I can rephrase it, do you have some suggestions?

I'm not sure what your definition of a pipeline is. If you have split
blocks, does that mean you have one pipeline or multiple pipelines?
Does block splitting allow to create multiple pipelines in the sense
that they do not all contain the exact same blocks?

The only thing I could suggest is to not say that a pipeline is a
count. That would be done by replacing "to indicate how many DCN
blocks" by "to indicate which DCN blocks".


Thanks,
pq

> 1. https://patchwork.freedesktop.org/series/105071/
>=20
> Thanks
> Siqueira
>=20
> >> +end of the OPTC block before sending it to the display. We have this =
pipeline
> >> +concept for trying to save energy and optimize bandwidth utilization =
while
> >> +providing the maximum performance per watt. It is easier to discuss i=
t if we
> >> +dive into this topic by taking the example of a 4k display in the bel=
ow
> >> +example:
> >> +
> >> +.. kernel-figure:: pipeline_4k_no_split.svg =20
> >=20
> > A bit too hard for me to look at SVGs from email patches, sorry.
> >=20
> > You wouldn't happen to have a git branch available in Gitlab or Github
> > or even cgit somewhere I could visit with my browser?
> >=20
> >=20
> > Thanks,
> > pq
