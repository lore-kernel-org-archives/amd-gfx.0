Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8F59C77B7E
	for <amd-gfx@archiver.kernel.org>; Thu, 25 May 2023 14:31:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3C63C10E172;
	Thu, 25 May 2023 14:31:50 +0000 (UTC)
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com
 [IPv6:2607:f8b0:4864:20::c2f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 97BB510E172
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 May 2023 14:31:47 +0000 (UTC)
Received: by mail-oo1-xc2f.google.com with SMTP id
 006d021491bc7-55517975c5fso307465eaf.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 May 2023 07:31:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1685025106; x=1687617106;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=haAYY5tLv8OMkHzlc8rZXyqMrmgPF5/OSoQHEqhuR9E=;
 b=e2+soVjjgDVG8bYEsYs/aFBnwxgqZDCzjcyklI6xlX0FKLDL9ic/wAULYcg+uI8JY0
 YBn2nwMKUpkAgPvwr6eJSbajzd5CTZvYQ3v+WeNHU4szlcZEKNx83HavdbCT4GCDdlBo
 TxvM+/qp7ZokwwA4LEhhvoJOtIfw1LU50EDzla9eyaEtetaftLmHLzwsa10mPOT35nxg
 YuQxZfBaT+CeWwBdJNJ2hy6kkd0oQ/AbT4ZjD3VFSv2fHdDSp/N4NZoyUcR6wP6SECYm
 LE5UoX81hJ3UP/lxTmCyuBG59+9qekqfHaZmVF6MC7DrORSvOtbOUxHeAiGTtjriaFkC
 aoCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685025106; x=1687617106;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=haAYY5tLv8OMkHzlc8rZXyqMrmgPF5/OSoQHEqhuR9E=;
 b=BuYA94VaV2vqodHp4YkqWbG/mYuK9xiAOTSHGb6a33mg1x2auuytutvZcTR9Ca00y8
 FvaNkI+V22NCHSHzmQ+t+LPDTNmLlRwDdzMIkgmZleMOkknAH+MI0q71j4O8I8Bmy7Jg
 uJOqfIzGCO0geKpdoQx03B/0YfvOA+Kw4RTG+BK3TeMNaA177/Em/piaADU+V4wP8utR
 9tS5FOZplEqIGk+UzuN2bPb9FkE6or0euZyqdywBxr1O5bH+U1EwHymfivcD4+Wgpv6e
 lDQjhPGrGk9zSjhBnlE9PHZyk84VouEcrQQwJzOTX4LmY1XDh3/CxFidLBuqpDKwe4f0
 a3GA==
X-Gm-Message-State: AC+VfDzkJe0lyFCoLpYYH67nZgkC0OE5ef+j7QtNEsJ22yO6XaBM4JWm
 yAOKW0O9dP7gMAG6jOC8FvLW+C889QbL0VoU5rS/y5qD
X-Google-Smtp-Source: ACHHUZ5On1iKCZUqCOAmrhHZn6ujk6l4EMEHy2In65GKPmhKlOqKVH3+lhIl3nLA2MggJ3qszJOiw8NGFgIEY3JtEy4=
X-Received: by 2002:a05:6808:1282:b0:399:25d0:30d1 with SMTP id
 a2-20020a056808128200b0039925d030d1mr620346oiw.3.1685025106450; Thu, 25 May
 2023 07:31:46 -0700 (PDT)
MIME-Version: 1.0
References: <20230522130823.769236-1-michel@daenzer.net>
 <16635e8f-f81e-a731-e81b-3f1c02d24b9f@amd.com>
 <821e8eb3-0ca8-34ff-dba8-7edcef34e28f@daenzer.net>
In-Reply-To: <821e8eb3-0ca8-34ff-dba8-7edcef34e28f@daenzer.net>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 25 May 2023 10:31:34 -0400
Message-ID: <CADnq5_MrxRrOExM+kZwu-Nv=8Y6mcAqGNDYAhvLp4um1R=-XYw@mail.gmail.com>
Subject: Re: [PATCH 1/2] Revert "drm/amd/display: Block optimize on
 consecutive FAMS enables"
To: =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel@daenzer.net>
Content-Type: text/plain; charset="UTF-8"
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
Cc: Wesley Chalmers <Wesley.Chalmers@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Qingqing Zhuo <Qingqing.Zhuo@amd.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, amd-gfx@lists.freedesktop.org,
 Aurabindo Pillai <Aurabindo.Pillai@amd.com>,
 Hamza Mahfooz <hamza.mahfooz@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Harry Wentland <harry.wentland@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, May 25, 2023 at 6:27=E2=80=AFAM Michel D=C3=A4nzer <michel@daenzer.=
net> wrote:
>
> On 5/23/23 18:09, Hamza Mahfooz wrote:
> > On 5/22/23 09:08, Michel D=C3=A4nzer wrote:
> >> From: Michel D=C3=A4nzer <mdaenzer@redhat.com>
> >>
> >> This reverts commit ce560ac40272a5c8b5b68a9d63a75edd9e66aed2.
> >>
> >> It depends on its parent commit, which we want to revert.
> >>
> >> Signed-off-by: Michel D=C3=A4nzer <mdaenzer@redhat.com>
> >
> > I have applied the series, thanks!
>
> Thank you. Note that these need to be merged for 6.4; they weren't in Ale=
x's 6.4 fixes PR yesterday.

Yes, I plan to include it in next week's PR.

Alex
