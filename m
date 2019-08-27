From: Alex Deucher <alexdeucher@gmail.com>
Subject: Re: linux-next: Tree for Aug 27 (amdgpu)
Date: Tue, 27 Aug 2019 11:41:41 -0400
Message-ID: <CADnq5_NBnovQGuhsoEsw+S-LBDU-CbWXKm=mJ3Oy6PcgUeiOQw@mail.gmail.com>
References: <20190827190526.6f27e763@canb.auug.org.au> <3b5936f1-e471-846a-d133-0e17d290d2f3@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <3b5936f1-e471-846a-d133-0e17d290d2f3@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Linux Next Mailing List <linux-next@vger.kernel.org>, amd-gfx list <amd-gfx@lists.freedesktop.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, dri-devel <dri-devel@lists.freedesktop.org>
List-Id: amd-gfx.lists.freedesktop.org

On Tue, Aug 27, 2019 at 11:31 AM Randy Dunlap <rdunlap@infradead.org> wrote=
:
>
> On 8/27/19 2:05 AM, Stephen Rothwell wrote:
> > Hi all,
> >
> > Changes since 20190826:
> >
>
> on i386:
>
> ../drivers/gpu/drm/amd/amdgpu/../display/dc/dcn20/dcn20_hwseq.c: In funct=
ion =E2=80=98dcn20_hw_sequencer_construct=E2=80=99:
> ../drivers/gpu/drm/amd/amdgpu/../display/dc/dcn20/dcn20_hwseq.c:2127:28: =
error: =E2=80=98dcn20_dsc_pg_control=E2=80=99 undeclared (first use in this=
 function); did you mean =E2=80=98dcn20_dpp_pg_control=E2=80=99?
>   dc->hwss.dsc_pg_control =3D dcn20_dsc_pg_control;
>                             ^~~~~~~~~~~~~~~~~~~~
>                             dcn20_dpp_pg_control
>
>
> Full randconfig file is attached.

Fixed:
https://cgit.freedesktop.org/~agd5f/linux/commit/?h=3Ddrm-next&id=3Dda26ded=
3b2fff646d28559004195abe353bce49b

Alex

>
> --
> ~Randy
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
