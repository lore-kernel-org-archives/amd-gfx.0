Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 416BACDB474
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Oct 2023 08:27:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A34E310E17F;
	Mon, 23 Oct 2023 08:27:29 +0000 (UTC)
Received: from mail-4327.protonmail.ch (mail-4327.protonmail.ch [185.70.43.27])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EB9C410E17F
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Oct 2023 08:27:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emersion.fr;
 s=protonmail2; t=1698049641; x=1698308841;
 bh=E286vjDkg1qT5X7T/0laoU76NAczw6eMVxOaqO74GTQ=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=HHqC6H6jpKuOnCR6UjEuqgPw8HVmDomNFEobNYu+lQdncQxP4VLHQAjmGEA+bP3JN
 /alAi8MHa8bY53QoR2e1GKCaid6zWfgJQ+vyuOgmcxYKvZBnb0wo70x4GpchHpV5WF
 gLLiDhMjvtrCAOOB8njQEhf9Cognaxrh1MnAaFtfbIaV4fB1Id/cFu9LlgpKeMrXmv
 /vfcR4UpV07Th843zJRGjOhiUU/l3bvr9zYY4eHu0pWKfFwwwsR3OkFhP4pYHIKLIX
 hGvoVr+bUNkIN/P7QJUSDgMBtmziBgP1BPc5+EAJEfL0gL6kDqk49KB60pc3pObzf3
 q0IQlLjyA2w/g==
Date: Mon, 23 Oct 2023 08:27:17 +0000
To: =?utf-8?Q?Michel_D=C3=A4nzer?= <michel.daenzer@mailbox.org>
From: Simon Ser <contact@emersion.fr>
Subject: Re: [PATCH v7 4/6] drm: Refuse to async flip with atomic prop changes
Message-ID: <Bi9El_nuZXA997YlVyCzD5s7KfP820IVUuYiB69mgXnjQbfCgOucCBe6aKvSFrMzB_9DwxO2lli_MqLzMuGZ-rmrRp57vePsTwUarEweLJs=@emersion.fr>
In-Reply-To: <8c1641e4-a7e2-ecb2-ab7a-c6e2bb3e951b@mailbox.org>
References: <20231017092837.32428-1-andrealmeid@igalia.com>
 <20231017092837.32428-5-andrealmeid@igalia.com>
 <CzEtDALWvF3EU4DDLLEmH3ms0B25PbsEHRU9b_IqwfyhzdG4zC-XXAU6fm2PnMcngAYmntH7s4iuew0vocN6cO8zUit8kgi-Sb1hBQXNYiw=@emersion.fr>
 <3r5-_03WC5dK3LaRt1Is78zD_bmT2aaGc5h9jpUGzo2o5GCtGP1zpQNzUxglsieewFklY7xwTrOS9jtI18YlNnnzHNx2Ccw9yM2NuJpDQZU=@emersion.fr>
 <8c1641e4-a7e2-ecb2-ab7a-c6e2bb3e951b@mailbox.org>
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
Cc: pierre-eric.pelloux-prayer@amd.com,
 =?utf-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>,
 =?utf-8?Q?=27Marek_Ol=C5=A1=C3=A1k=27?= <maraeo@gmail.com>,
 Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, Pekka Paalanen <ppaalanen@gmail.com>,
 dri-devel@lists.freedesktop.org, kernel-dev@igalia.com,
 alexander.deucher@amd.com, hwentlan@amd.com, christian.koenig@amd.com,
 joshua@froggi.es
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Sunday, October 22nd, 2023 at 12:12, Michel D=C3=A4nzer <michel.daenzer@=
mailbox.org> wrote:

> On 10/17/23 14:16, Simon Ser wrote:
>=20
> > After discussing with Andr=C3=A9 it seems like we missed a plane type c=
heck
> > here. We need to make sure FB_ID changes are only allowed on primary
> > planes.
>=20
> Can you elaborate why that's needed?

Current drivers are in general not prepared to perform async page-flips
on planes other than primary. For instance I don't think i915 has logic
to perform async page-flip on an overlay plane FB_ID change.
