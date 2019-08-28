From: Alex Deucher <alexdeucher@gmail.com>
Subject: Re: mmotm 2019-08-27-20-39 uploaded (gpu/drm/amd/display/)
Date: Wed, 28 Aug 2019 14:53:37 -0400
Message-ID: <CADnq5_PHNbSVUsM65sisfUwDxg_4-uEZWZMSQ=u78AWkaRdvtw@mail.gmail.com>
References: <20190828034012.sBvm81sYK%akpm@linux-foundation.org> <3e4eba58-7d24-f811-baa1-b6e88334e5a2@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <3e4eba58-7d24-f811-baa1-b6e88334e5a2@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Mark Brown <broonie@kernel.org>, linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>, Linux-Next Mailing List <linux-next@vger.kernel.org>, Michal Hocko <mhocko@suse.cz>, mm-commits@vger.kernel.org, Stephen Rothwell <sfr@canb.auug.org.au>, amd-gfx list <amd-gfx@lists.freedesktop.org>, dri-devel <dri-devel@lists.freedesktop.org>, Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>
List-Id: amd-gfx.lists.freedesktop.org

On Wed, Aug 28, 2019 at 2:51 PM Randy Dunlap <rdunlap@infradead.org> wrote:
>
> On 8/27/19 8:40 PM, akpm@linux-foundation.org wrote:
> > The mm-of-the-moment snapshot 2019-08-27-20-39 has been uploaded to
> >
> >    http://www.ozlabs.org/~akpm/mmotm/
> >
> > mmotm-readme.txt says
> >
> > README for mm-of-the-moment:
> >
> > http://www.ozlabs.org/~akpm/mmotm/
> >
> > This is a snapshot of my -mm patch queue.  Uploaded at random hopefully
> > more than once a week.
> >
> > You will need quilt to apply these patches to the latest Linus release =
(5.x
> > or 5.x-rcY).  The series file is in broken-out.tar.gz and is duplicated=
 in
> > http://ozlabs.org/~akpm/mmotm/series
> >
> > The file broken-out.tar.gz contains two datestamp files: .DATE and
> > .DATE-yyyy-mm-dd-hh-mm-ss.  Both contain the string yyyy-mm-dd-hh-mm-ss=
,
> > followed by the base kernel version against which this patch series is =
to
> > be applied.
> >
> > This tree is partially included in linux-next.  To see which patches ar=
e
> > included in linux-next, consult the `series' file.  Only the patches
> > within the #NEXT_PATCHES_START/#NEXT_PATCHES_END markers are included i=
n
> > linux-next.
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

Fixed here:
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
