From: Nick Desaulniers <ndesaulniers-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] drm/amd/display: Pass app_tf by value rather than by
 reference
Date: Tue, 11 Dec 2018 14:41:03 -0800
Message-ID: <CAKwvOd=EU-9CpQF-_rODPALA9wL=T7njt2kN2D-z5rJvPduYSQ@mail.gmail.com>
References: <20181210234201.4850-1-natechancellor@gmail.com>
 <CAKwvOdkOwdrsOAADGp9To2F5o2AAW7123yADFzYLMawwsinmug@mail.gmail.com>
 <20181211214240.GA31705@flashbox>
 <CAKwvOdn4467193YUMCboj+Z62m0+pVMAbjAc4avCsSsng7hpPg@mail.gmail.com>
 <20181211222430.GA17468@flashbox>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0839036368=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20181211222430.GA17468@flashbox>
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
List-Help: <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=subscribe>
Errors-To: amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Sender: "amd-gfx" <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
To: Nathan Chancellor <natechancellor-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: David1.Zhou-5C7GfCeVMHo@public.gmane.org, sunpeng.li-5C7GfCeVMHo@public.gmane.org, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, alexander.deucher-5C7GfCeVMHo@public.gmane.org, Harry Wentland <harry.wentland-5C7GfCeVMHo@public.gmane.org>, christian.koenig-5C7GfCeVMHo@public.gmane.org

--===============0839036368==
Content-Type: multipart/alternative; boundary="0000000000006a0cac057cc6c77a"

--0000000000006a0cac057cc6c77a
Content-Type: text/plain; charset="UTF-8"

On Tue, Dec 11, 2018 at 2:24 PM Nathan Chancellor <natechancellor-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
wrote:

> On Tue, Dec 11, 2018 at 02:07:31PM -0800, Nick Desaulniers wrote:
> > On Tue, Dec 11, 2018 at 1:42 PM Nathan Chancellor
> > <natechancellor-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> > >
> > > On Tue, Dec 11, 2018 at 01:25:00PM -0800, Nick Desaulniers wrote:
> > > > On Mon, Dec 10, 2018 at 3:42 PM Nathan Chancellor
> > > > <natechancellor-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> > > > >
> > > > > Clang warns when an expression that equals zero is used as a null
> > > > > pointer constant (in lieu of NULL):
> > > > >
> > > > > drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:4435:3:
> > > > > warning: expression which evaluates to zero treated as a null
> pointer
> > > > > constant of type 'const enum color_transfer_func *'
> > > > > [-Wnon-literal-null-conversion]
> > > > >                 TRANSFER_FUNC_UNKNOWN,
> > > > >                 ^~~~~~~~~~~~~~~~~~~~~
> > > > > 1 warning generated.
> > > > >
> > > > > This warning is caused by commit bb47de736661 ("drm/amdgpu: Set
> FreeSync
> > > > > state using drm VRR properties") and it could be solved by using
> NULL
> > > > > instead of TRANSFER_FUNC_UNKNOWN or casting TRANSFER_FUNC_UNKNOWN
> as a
> > > > > pointer. However, after looking into it, there doesn't appear to
> be a
> > > > > good reason to pass app_tf by reference as it is never mutated
> along the
> > > > > way. This is the only code path in which app_tf is used:
> > > > >
> > > > > mod_freesync_build_vrr_infopacket ->
> > > > >     build_vrr_infopacket_v2 ->
> > > > >         build_vrr_infopacket_fs2_data
> > > > >
> > > > > Neither mod_freesync_build_vrr_infopacket or
> build_vrr_infopacket_v2
> > > > > modify app_tf's value and build_vrr_infopacket_fs2_data expects
> just
> > > > > the value so we can avoid dereferencing anything by just passing in
> > > > > app_tf's value to mod_freesync_build_vrr_infopacket and
> > > > > build_vrr_infopacket_v2.
> > > > >
> > > > > There is no functional change because build_vrr_infopacket_fs2_data
> > > > > doesn't do anything if TRANSFER_FUNC_UNKNOWN is passed to it, the
> same
> > > > > as not calling build_vrr_infopacket_fs2_data at all like before
> this
> > > > > change when NULL was used for app_tf.
> > > >
> > > > Nathan,
> > > > Thanks for sending this patch.  I was hoping to provide review
> sooner,
> > > > but have been quite busy lately.
> > > >
> > >
> > > Late review is better than no review, I appeciate you taking the time
> to
> > > do this!
> > >
> > > > Yeah, especially for LP64 targets, the pointer to enum is larger than
> > > > just the enum, and if it's not being updated ("in/out paramter")
> > > > there's no need to pass by pointer.
> > > >
> > >
> > > Thanks for confirming!
> > >
> > > > >
> > > > > Signed-off-by: Nathan Chancellor <natechancellor-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> > > > > ---
> > > > >  drivers/gpu/drm/amd/display/modules/freesync/freesync.c | 7
> +++----
> > > > >  drivers/gpu/drm/amd/display/modules/inc/mod_freesync.h  | 2 +-
> > > > >  2 files changed, 4 insertions(+), 5 deletions(-)
> > > > >
> > > > > diff --git
> a/drivers/gpu/drm/amd/display/modules/freesync/freesync.c
> b/drivers/gpu/drm/amd/display/modules/freesync/freesync.c
> > > > > index 620a171620ee..520665a9d81a 100644
> > > > > --- a/drivers/gpu/drm/amd/display/modules/freesync/freesync.c
> > > > > +++ b/drivers/gpu/drm/amd/display/modules/freesync/freesync.c
> > > > > @@ -656,7 +656,7 @@ static void build_vrr_infopacket_v1(enum
> signal_type signal,
> > > > >
> > > > >  static void build_vrr_infopacket_v2(enum signal_type signal,
> > > > >                 const struct mod_vrr_params *vrr,
> > > > > -               const enum color_transfer_func *app_tf,
> > > > > +               enum color_transfer_func app_tf,
> > > > >                 struct dc_info_packet *infopacket)
> > > > >  {
> > > > >         unsigned int payload_size = 0;
> > > > > @@ -664,8 +664,7 @@ static void build_vrr_infopacket_v2(enum
> signal_type signal,
> > > > >         build_vrr_infopacket_header_v2(signal, infopacket,
> &payload_size);
> > > > >         build_vrr_infopacket_data(vrr, infopacket);
> > > > >
> > > > > -       if (app_tf != NULL)
> > > > > -               build_vrr_infopacket_fs2_data(*app_tf, infopacket);
> > > > > +       build_vrr_infopacket_fs2_data(app_tf, infopacket);
> > > > >
> > > > >         build_vrr_infopacket_checksum(&payload_size, infopacket);
> > > > >
> > > > > @@ -676,7 +675,7 @@ void mod_freesync_build_vrr_infopacket(struct
> mod_freesync *mod_freesync,
> > > > >                 const struct dc_stream_state *stream,
> > > > >                 const struct mod_vrr_params *vrr,
> > > > >                 enum vrr_packet_type packet_type,
> > > > > -               const enum color_transfer_func *app_tf,
> > > > > +               enum color_transfer_func app_tf,
> > > > >                 struct dc_info_packet *infopacket)
> > > > >  {
> > > > >         /* SPD info packet for FreeSync */
> > > > > diff --git
> a/drivers/gpu/drm/amd/display/modules/inc/mod_freesync.h
> b/drivers/gpu/drm/amd/display/modules/inc/mod_freesync.h
> > > > > index 949a8b62aa98..063af6258fd9 100644
> > > > > --- a/drivers/gpu/drm/amd/display/modules/inc/mod_freesync.h
> > > > > +++ b/drivers/gpu/drm/amd/display/modules/inc/mod_freesync.h
> > > > > @@ -145,7 +145,7 @@ void mod_freesync_build_vrr_infopacket(struct
> mod_freesync *mod_freesync,
> > > > >                 const struct dc_stream_state *stream,
> > > > >                 const struct mod_vrr_params *vrr,
> > > > >                 enum vrr_packet_type packet_type,
> > > > > -               const enum color_transfer_func *app_tf,
> > > > > +               enum color_transfer_func app_tf,
> > > >
> > > > Don't you need to update the callsite of
> `mod_freesync_build_vrr_infopacket` in
> > > >
> > > > drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c#4949:
> > > >
> > > > -                                           NULL,
> > > > +                                          transfer_func_unknown,
> > > >
> > >
> > > That change in commit bb47de736661 ("drm/amdgpu: Set FreeSync state
> > > using drm VRR properties") in -next is what prompted this patch (the
> > > warning in the commit message is not present in mainline):
> >
> > Ah! Sorry, I was looking at mainline.  I should have noticed
> > bb47de736661 wasn't there.
> >
> > Shouldn't that change fail to compile, as transfer_func_unknown is an
> > `enum color_transfer_func` value, but
> > mod_freesync_build_vrr_infopacket takes a *pointer* to an `enum
> > color_transfer_func` value?
> >
> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/drivers/gpu/drm/amd/display/modules/freesync/freesync.c#n675
> >
>
> Unfortunately, no. GCC does not warn like Clang does when an expression
> that equals zero is passed to a function requiring a pointer (it just
> silently treats it as NULL, whereas Clang audibly complains).
>

That C allows this is troubling to me.  I may need to go seek therapy to
deal with my anguish this has caused me...


>
> They both do when the expression is something other than zero.
>
> https://godbolt.org/z/goo91G
>
> Nathan
>
> > >
> > >         mod_freesync_build_vrr_infopacket(
> > >                 dm->freesync_module,
> > >                 new_stream,
> > >                 &vrr,
> > >                 packet_type_vrr,
> > >                 transfer_func_unknown,
> > >                 &vrr_infopacket);
> > >
> > > > Maybe at that point the `if (app_tf != NULL)` could be replaced with
> > > > `if (app_tf != transfer_func_unknown)` hoisted from
> > > > `build_vrr_infopacket_fs2_data`? (There's only one caller of
> > > > `build_vrr_infopacket_fs2_data` today, maybe fine to leave the
> > > > unconditional call and check).
> > > >
> > >
> > > Hmmm that's not unreasonable I suppose. I guess it depends on if
> > > build_vrr_infopacket_fs2_data could ever be called from outside of
> > > build_vrr_infopacket_v2; if it can, it makes sense to leave the
> > > conditional check for 'app_tf != transfer_func_unknown' in
> > > build_vrr_infopacket_fs2_data and leaving the unconditional call
> > > to it in build_vrr_infopacket_v2 (since app_tf is no longer a pointer,
> > > no need to check against NULL).
> > >
> > > I'm happy to do a v2 if the maintainers feel strongly about it, thank
> > > you for bringing that up.
> >
> > Don't worry about it, I think it's fine.
> > Reviewed-by: Nick Desaulniers <ndesaulniers-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
> >
> > --
> > Thanks,
> > ~Nick Desaulniers
>


-- 
Thanks,
~Nick Desaulniers

--0000000000006a0cac057cc6c77a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_quote"><div dir=3D"ltr">On Tue, Dec 11=
, 2018 at 2:24 PM Nathan Chancellor &lt;<a href=3D"mailto:natechancellor@gm=
ail.com">natechancellor-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt; wrote:<br></div><blockquote class=
=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padd=
ing-left:1ex">On Tue, Dec 11, 2018 at 02:07:31PM -0800, Nick Desaulniers wr=
ote:<br>
&gt; On Tue, Dec 11, 2018 at 1:42 PM Nathan Chancellor<br>
&gt; &lt;<a href=3D"mailto:natechancellor-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" target=3D"_blank">nate=
chancellor-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt; wrote:<br>
&gt; &gt;<br>
&gt; &gt; On Tue, Dec 11, 2018 at 01:25:00PM -0800, Nick Desaulniers wrote:=
<br>
&gt; &gt; &gt; On Mon, Dec 10, 2018 at 3:42 PM Nathan Chancellor<br>
&gt; &gt; &gt; &lt;<a href=3D"mailto:natechancellor-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" target=3D"_b=
lank">natechancellor-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt; wrote:<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; Clang warns when an expression that equals zero is used=
 as a null<br>
&gt; &gt; &gt; &gt; pointer constant (in lieu of NULL):<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_=
dm.c:4435:3:<br>
&gt; &gt; &gt; &gt; warning: expression which evaluates to zero treated as =
a null pointer<br>
&gt; &gt; &gt; &gt; constant of type &#39;const enum color_transfer_func *&=
#39;<br>
&gt; &gt; &gt; &gt; [-Wnon-literal-null-conversion]<br>
&gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0TRANSFER_FUNC_UNKNOWN,<br>
&gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0^~~~~~~~~~~~~~~~~~~~~<br>
&gt; &gt; &gt; &gt; 1 warning generated.<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; This warning is caused by commit bb47de736661 (&quot;dr=
m/amdgpu: Set FreeSync<br>
&gt; &gt; &gt; &gt; state using drm VRR properties&quot;) and it could be s=
olved by using NULL<br>
&gt; &gt; &gt; &gt; instead of TRANSFER_FUNC_UNKNOWN or casting TRANSFER_FU=
NC_UNKNOWN as a<br>
&gt; &gt; &gt; &gt; pointer. However, after looking into it, there doesn&#3=
9;t appear to be a<br>
&gt; &gt; &gt; &gt; good reason to pass app_tf by reference as it is never =
mutated along the<br>
&gt; &gt; &gt; &gt; way. This is the only code path in which app_tf is used=
:<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; mod_freesync_build_vrr_infopacket -&gt;<br>
&gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0build_vrr_infopacket_v2 -&gt;<br>
&gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0build_vrr_infopacket_f=
s2_data<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; Neither mod_freesync_build_vrr_infopacket or build_vrr_=
infopacket_v2<br>
&gt; &gt; &gt; &gt; modify app_tf&#39;s value and build_vrr_infopacket_fs2_=
data expects just<br>
&gt; &gt; &gt; &gt; the value so we can avoid dereferencing anything by jus=
t passing in<br>
&gt; &gt; &gt; &gt; app_tf&#39;s value to mod_freesync_build_vrr_infopacket=
 and<br>
&gt; &gt; &gt; &gt; build_vrr_infopacket_v2.<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; There is no functional change because build_vrr_infopac=
ket_fs2_data<br>
&gt; &gt; &gt; &gt; doesn&#39;t do anything if TRANSFER_FUNC_UNKNOWN is pas=
sed to it, the same<br>
&gt; &gt; &gt; &gt; as not calling build_vrr_infopacket_fs2_data at all lik=
e before this<br>
&gt; &gt; &gt; &gt; change when NULL was used for app_tf.<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; Nathan,<br>
&gt; &gt; &gt; Thanks for sending this patch.=C2=A0 I was hoping to provide=
 review sooner,<br>
&gt; &gt; &gt; but have been quite busy lately.<br>
&gt; &gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt; Late review is better than no review, I appeciate you taking the =
time to<br>
&gt; &gt; do this!<br>
&gt; &gt;<br>
&gt; &gt; &gt; Yeah, especially for LP64 targets, the pointer to enum is la=
rger than<br>
&gt; &gt; &gt; just the enum, and if it&#39;s not being updated (&quot;in/o=
ut paramter&quot;)<br>
&gt; &gt; &gt; there&#39;s no need to pass by pointer.<br>
&gt; &gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt; Thanks for confirming!<br>
&gt; &gt;<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; Signed-off-by: Nathan Chancellor &lt;<a href=3D"mailto:=
natechancellor-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" target=3D"_blank">natechancellor-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt=
;<br>
&gt; &gt; &gt; &gt; ---<br>
&gt; &gt; &gt; &gt;=C2=A0 drivers/gpu/drm/amd/display/modules/freesync/free=
sync.c | 7 +++----<br>
&gt; &gt; &gt; &gt;=C2=A0 drivers/gpu/drm/amd/display/modules/inc/mod_frees=
ync.h=C2=A0 | 2 +-<br>
&gt; &gt; &gt; &gt;=C2=A0 2 files changed, 4 insertions(+), 5 deletions(-)<=
br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; diff --git a/drivers/gpu/drm/amd/display/modules/freesy=
nc/freesync.c b/drivers/gpu/drm/amd/display/modules/freesync/freesync.c<br>
&gt; &gt; &gt; &gt; index 620a171620ee..520665a9d81a 100644<br>
&gt; &gt; &gt; &gt; --- a/drivers/gpu/drm/amd/display/modules/freesync/free=
sync.c<br>
&gt; &gt; &gt; &gt; +++ b/drivers/gpu/drm/amd/display/modules/freesync/free=
sync.c<br>
&gt; &gt; &gt; &gt; @@ -656,7 +656,7 @@ static void build_vrr_infopacket_v1=
(enum signal_type signal,<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt;=C2=A0 static void build_vrr_infopacket_v2(enum signal_t=
ype signal,<br>
&gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0const struct mod_vrr_params *vrr,<br>
&gt; &gt; &gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0const enum color_transfer_func *app_tf,<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0enum color_transfer_func app_tf,<br>
&gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0struct dc_info_packet *infopacket)<br>
&gt; &gt; &gt; &gt;=C2=A0 {<br>
&gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned int payload_s=
ize =3D 0;<br>
&gt; &gt; &gt; &gt; @@ -664,8 +664,7 @@ static void build_vrr_infopacket_v2=
(enum signal_type signal,<br>
&gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0build_vrr_infopacket_h=
eader_v2(signal, infopacket, &amp;payload_size);<br>
&gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0build_vrr_infopacket_d=
ata(vrr, infopacket);<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0if (app_tf !=3D NULL)<br>
&gt; &gt; &gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0build_vrr_infopacket_fs2_data(*app_tf, infopacket);<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0build_vrr_infopacket_fs2_da=
ta(app_tf, infopacket);<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0build_vrr_infopacket_c=
hecksum(&amp;payload_size, infopacket);<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; @@ -676,7 +675,7 @@ void mod_freesync_build_vrr_infopac=
ket(struct mod_freesync *mod_freesync,<br>
&gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0const struct dc_stream_state *stream,<br>
&gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0const struct mod_vrr_params *vrr,<br>
&gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0enum vrr_packet_type packet_type,<br>
&gt; &gt; &gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0const enum color_transfer_func *app_tf,<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0enum color_transfer_func app_tf,<br>
&gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0struct dc_info_packet *infopacket)<br>
&gt; &gt; &gt; &gt;=C2=A0 {<br>
&gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* SPD info packet for=
 FreeSync */<br>
&gt; &gt; &gt; &gt; diff --git a/drivers/gpu/drm/amd/display/modules/inc/mo=
d_freesync.h b/drivers/gpu/drm/amd/display/modules/inc/mod_freesync.h<br>
&gt; &gt; &gt; &gt; index 949a8b62aa98..063af6258fd9 100644<br>
&gt; &gt; &gt; &gt; --- a/drivers/gpu/drm/amd/display/modules/inc/mod_frees=
ync.h<br>
&gt; &gt; &gt; &gt; +++ b/drivers/gpu/drm/amd/display/modules/inc/mod_frees=
ync.h<br>
&gt; &gt; &gt; &gt; @@ -145,7 +145,7 @@ void mod_freesync_build_vrr_infopac=
ket(struct mod_freesync *mod_freesync,<br>
&gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0const struct dc_stream_state *stream,<br>
&gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0const struct mod_vrr_params *vrr,<br>
&gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0enum vrr_packet_type packet_type,<br>
&gt; &gt; &gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0const enum color_transfer_func *app_tf,<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0enum color_transfer_func app_tf,<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; Don&#39;t you need to update the callsite of `mod_freesync_b=
uild_vrr_infopacket` in<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c#4949:<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0NULL,<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 transfer_func_unknown,<br>
&gt; &gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt; That change in commit bb47de736661 (&quot;drm/amdgpu: Set FreeSyn=
c state<br>
&gt; &gt; using drm VRR properties&quot;) in -next is what prompted this pa=
tch (the<br>
&gt; &gt; warning in the commit message is not present in mainline):<br>
&gt; <br>
&gt; Ah! Sorry, I was looking at mainline.=C2=A0 I should have noticed<br>
&gt; bb47de736661 wasn&#39;t there.<br>
&gt; <br>
&gt; Shouldn&#39;t that change fail to compile, as transfer_func_unknown is=
 an<br>
&gt; `enum color_transfer_func` value, but<br>
&gt; mod_freesync_build_vrr_infopacket takes a *pointer* to an `enum<br>
&gt; color_transfer_func` value?<br>
&gt; <a href=3D"https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-=
next.git/tree/drivers/gpu/drm/amd/display/modules/freesync/freesync.c#n675"=
 rel=3D"noreferrer" target=3D"_blank">https://git.kernel.org/pub/scm/linux/=
kernel/git/next/linux-next.git/tree/drivers/gpu/drm/amd/display/modules/fre=
esync/freesync.c#n675</a><br>
&gt; <br>
<br>
Unfortunately, no. GCC does not warn like Clang does when an expression<br>
that equals zero is passed to a function requiring a pointer (it just<br>
silently treats it as NULL, whereas Clang audibly complains).<br></blockquo=
te><div><br></div><div>That C allows this is troubling to me.=C2=A0 I may n=
eed to go seek therapy to deal with my anguish this has caused me...</div><=
div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8e=
x;border-left:1px #ccc solid;padding-left:1ex">
<br>
They both do when the expression is something other than zero.<br>
<br>
<a href=3D"https://godbolt.org/z/goo91G" rel=3D"noreferrer" target=3D"_blan=
k">https://godbolt.org/z/goo91G</a><br>
<br>
Nathan<br>
<br>
&gt; &gt;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0mod_freesync_build_vrr_infopacke=
t(<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dm-&=
gt;freesync_module,<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0new_=
stream,<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&amp=
;vrr,<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pack=
et_type_vrr,<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tran=
sfer_func_unknown,<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&amp=
;vrr_infopacket);<br>
&gt; &gt;<br>
&gt; &gt; &gt; Maybe at that point the `if (app_tf !=3D NULL)` could be rep=
laced with<br>
&gt; &gt; &gt; `if (app_tf !=3D transfer_func_unknown)` hoisted from<br>
&gt; &gt; &gt; `build_vrr_infopacket_fs2_data`? (There&#39;s only one calle=
r of<br>
&gt; &gt; &gt; `build_vrr_infopacket_fs2_data` today, maybe fine to leave t=
he<br>
&gt; &gt; &gt; unconditional call and check).<br>
&gt; &gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt; Hmmm that&#39;s not unreasonable I suppose. I guess it depends on=
 if<br>
&gt; &gt; build_vrr_infopacket_fs2_data could ever be called from outside o=
f<br>
&gt; &gt; build_vrr_infopacket_v2; if it can, it makes sense to leave the<b=
r>
&gt; &gt; conditional check for &#39;app_tf !=3D transfer_func_unknown&#39;=
 in<br>
&gt; &gt; build_vrr_infopacket_fs2_data and leaving the unconditional call<=
br>
&gt; &gt; to it in build_vrr_infopacket_v2 (since app_tf is no longer a poi=
nter,<br>
&gt; &gt; no need to check against NULL).<br>
&gt; &gt;<br>
&gt; &gt; I&#39;m happy to do a v2 if the maintainers feel strongly about i=
t, thank<br>
&gt; &gt; you for bringing that up.<br>
&gt; <br>
&gt; Don&#39;t worry about it, I think it&#39;s fine.<br>
&gt; Reviewed-by: Nick Desaulniers &lt;<a href=3D"mailto:ndesaulniers@googl=
e.com" target=3D"_blank">ndesaulniers-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org</a>&gt;<br>
&gt; <br>
&gt; -- <br>
&gt; Thanks,<br>
&gt; ~Nick Desaulniers<br>
</blockquote></div><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr"=
 class=3D"gmail_signature" data-smartmail=3D"gmail_signature"><div dir=3D"l=
tr">Thanks,<div>~Nick Desaulniers</div></div></div></div>

--0000000000006a0cac057cc6c77a--

--===============0839036368==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0839036368==--
