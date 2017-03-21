From: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 000/100] Add Vega10 Support
Date: Tue, 21 Mar 2017 13:12:18 +0100
Message-ID: <CAAxE2A4Hvr=hXZ-nA20DL=5QgceMif7h1+A-edn45xt06zBa6w@mail.gmail.com>
References: <CAODFU0pW=uyAa9Bdjbzv63cFaBMoF34+rW9xWDorAuMKHFsRUQ@mail.gmail.com>
 <CADnq5_ONBTDeGQC_3ApDBv+xa88r5ZvA0RHiZHbohYBZ48=F5g@mail.gmail.com>
 <CAODFU0q8C=yW-rBhf-Tj7AT=OijGfRViajMQH59WVYzHmPU9LA@mail.gmail.com>
 <d1dc991e-8ae7-eae9-65bf-97c6319e8d17@amd.com>
 <608e9c51-6610-bf11-a22a-a1f07e5cf4a9@amd.com>
 <37027c02-1f10-858e-ca22-a6fc7cad330a@folklore1984.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1061853685=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <37027c02-1f10-858e-ca22-a6fc7cad330a-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
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
To: Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
Cc: Tom St Denis <tom.stdenis-5C7GfCeVMHo@public.gmane.org>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>, amd-gfx mailing list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============1061853685==
Content-Type: multipart/alternative; boundary=001a113f663236acd5054b3c8e9c

--001a113f663236acd5054b3c8e9c
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

It would be better to keep the headers as-is, because changing them
wouldn't fix anybody's problems, but it would take time from us that we
don't have.

Marek

On Mar 21, 2017 9:46 AM, "Edward O'Callaghan" <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
wrote:

>
>
> On 03/21/2017 05:36 PM, Christian K=C3=B6nig wrote:
> > Am 21.03.2017 um 00:38 schrieb Tom St Denis:
> >> On 03/20/2017 06:34 PM, Jan Ziak wrote:
> >>> On Mon, Mar 20, 2017 at 10:41 PM, Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
> >>> <mailto:alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>> wrote:
> >>>
> >>>     On Mon, Mar 20, 2017 at 5:36 PM, Jan Ziak <
> 0xe2.0x9a.0x9b-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
> >>>     <mailto:0xe2.0x9a.0x9b-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>> wrote:
> >>>     > Hi
> >>>     >
> >>>     >
> >>> https://cgit.freedesktop.org/~agd5f/linux/plain/drivers/gpu/
> drm/amd/include/asic_reg/vega10/NBIO/nbio_6_1_sh_mask.
> h?h=3Damd-staging-4.9&id=3D9555ef0ba926df25d9a637d0ea21bc0d231c21d2
> >>>
> >>> <https://cgit.freedesktop.org/~agd5f/linux/plain/drivers/
> gpu/drm/amd/include/asic_reg/vega10/NBIO/nbio_6_1_sh_mask.
> h?h=3Damd-staging-4.9&id=3D9555ef0ba926df25d9a637d0ea21bc0d231c21d2>
> >>>
> >>>     >
> >>>     > The file nbio_6_1_sh_mask.h is uncompressed. It consists from
> >>> 133884 lines.
> >>>     > Only generated C/C++ code will be able to utilize the content
> >>> of such a file
> >>>     > efficiently. All hand-written codes combined will be able to
> >>> utilize about
> >>>     > 1% of the file.
> >>>     >
> >>>     > Is there a reason why nbio_6_1_sh_mask.h is huge?
> >>>
> >>>     That IP block contains a lot of registers.  The idea is to open
> >>> source
> >>>     as much IP as possible to facilitate debugging, new features, etc=
.
> >>>
> >>>     Alex
> >>>
> >>>
> >>> [This email contains long/wide lines and should be viewed on a
> >>> sufficiently wide screen]
> >>>
> >>> For example if I open the file in vim and go to line 66952:
> >>>
> >>> #define
> >>> DWC_E12MP_PHY_X4_NS_X4_1_LANE1_DIG_RX_VCOCAL_RX_VCO_
> CAL_CTRL_1__DTB_SEL__SHIFT
> >>>
> >>> 0x9
> >>>
> >>> Then abstracting away some of the digits used in the defined identifi=
er
> >>> and using egrep:
> >>>
> >>> $ egrep
> >>> "\<DWC_E12MP_PHY_X._NS_X._._LANE._DIG_RX_VCOCAL_RX_VCO_
> CAL_CTRL_.__DTB_SEL__SHIFT\>"
> >>>
> >>> nbio_6_1_sh_mask.h
> >>> #define
> >>> DWC_E12MP_PHY_X4_NS_X4_0_LANE0_DIG_RX_VCOCAL_RX_VCO_
> CAL_CTRL_1__DTB_SEL__SHIFT
> >>>
> >>>                        0x9
> >>> #define
> >>> DWC_E12MP_PHY_X4_NS_X4_0_LANE1_DIG_RX_VCOCAL_RX_VCO_
> CAL_CTRL_1__DTB_SEL__SHIFT
> >>>
> >>>                        0x9
> >>> #define
> >>> DWC_E12MP_PHY_X4_NS_X4_0_LANE2_DIG_RX_VCOCAL_RX_VCO_
> CAL_CTRL_1__DTB_SEL__SHIFT
> >>>
> >>>                        0x9
> >>> #define
> >>> DWC_E12MP_PHY_X4_NS_X4_0_LANE3_DIG_RX_VCOCAL_RX_VCO_
> CAL_CTRL_1__DTB_SEL__SHIFT
> >>>
> >>>                        0x9
> >>> #define
> >>> DWC_E12MP_PHY_X4_NS_X4_0_LANEX_DIG_RX_VCOCAL_RX_VCO_
> CAL_CTRL_1__DTB_SEL__SHIFT
> >>>
> >>>                        0x9
> >>> #define
> >>> DWC_E12MP_PHY_X4_NS_X4_1_LANE0_DIG_RX_VCOCAL_RX_VCO_
> CAL_CTRL_1__DTB_SEL__SHIFT
> >>>
> >>>                        0x9
> >>> #define
> >>> DWC_E12MP_PHY_X4_NS_X4_1_LANE1_DIG_RX_VCOCAL_RX_VCO_
> CAL_CTRL_1__DTB_SEL__SHIFT
> >>>
> >>>                        0x9
> >>> #define
> >>> DWC_E12MP_PHY_X4_NS_X4_1_LANE2_DIG_RX_VCOCAL_RX_VCO_
> CAL_CTRL_1__DTB_SEL__SHIFT
> >>>
> >>>                        0x9
> >>> #define
> >>> DWC_E12MP_PHY_X4_NS_X4_1_LANE3_DIG_RX_VCOCAL_RX_VCO_
> CAL_CTRL_1__DTB_SEL__SHIFT
> >>>
> >>>                        0x9
> >>> #define
> >>> DWC_E12MP_PHY_X4_NS_X4_1_LANEX_DIG_RX_VCOCAL_RX_VCO_
> CAL_CTRL_1__DTB_SEL__SHIFT
> >>>
> >>>                        0x9
> >>> #define
> >>> DWC_E12MP_PHY_X4_NS_X4_2_LANE0_DIG_RX_VCOCAL_RX_VCO_
> CAL_CTRL_1__DTB_SEL__SHIFT
> >>>
> >>>                        0x9
> >>> #define
> >>> DWC_E12MP_PHY_X4_NS_X4_2_LANE1_DIG_RX_VCOCAL_RX_VCO_
> CAL_CTRL_1__DTB_SEL__SHIFT
> >>>
> >>>                        0x9
> >>> #define
> >>> DWC_E12MP_PHY_X4_NS_X4_2_LANE2_DIG_RX_VCOCAL_RX_VCO_
> CAL_CTRL_1__DTB_SEL__SHIFT
> >>>
> >>>                        0x9
> >>> #define
> >>> DWC_E12MP_PHY_X4_NS_X4_2_LANE3_DIG_RX_VCOCAL_RX_VCO_
> CAL_CTRL_1__DTB_SEL__SHIFT
> >>>
> >>>                        0x9
> >>> #define
> >>> DWC_E12MP_PHY_X4_NS_X4_2_LANEX_DIG_RX_VCOCAL_RX_VCO_
> CAL_CTRL_1__DTB_SEL__SHIFT
> >>>
> >>>                        0x9
> >>> #define
> >>> DWC_E12MP_PHY_X4_NS_X4_3_LANE0_DIG_RX_VCOCAL_RX_VCO_
> CAL_CTRL_1__DTB_SEL__SHIFT
> >>>
> >>>                        0x9
> >>> #define
> >>> DWC_E12MP_PHY_X4_NS_X4_3_LANE1_DIG_RX_VCOCAL_RX_VCO_
> CAL_CTRL_1__DTB_SEL__SHIFT
> >>>
> >>>                        0x9
> >>> #define
> >>> DWC_E12MP_PHY_X4_NS_X4_3_LANE2_DIG_RX_VCOCAL_RX_VCO_
> CAL_CTRL_1__DTB_SEL__SHIFT
> >>>
> >>>                        0x9
> >>> #define
> >>> DWC_E12MP_PHY_X4_NS_X4_3_LANE3_DIG_RX_VCOCAL_RX_VCO_
> CAL_CTRL_1__DTB_SEL__SHIFT
> >>>
> >>>                        0x9
> >>> #define
> >>> DWC_E12MP_PHY_X4_NS_X4_3_LANEX_DIG_RX_VCOCAL_RX_VCO_
> CAL_CTRL_1__DTB_SEL__SHIFT
> >>>
> >>>                        0x9
> >>>
> >>> The egrep command produced 20 lines.
> >>>
> >>> Instead of the many #define directives, it is a possibility to define
> >>> functions such as:
> >>>
> >>> int
> >>> DWC_E12MP_PHY_Xa_NS_Xb_c_LANEd_DIG_RX_VCOCAL_RX_VCO_
> CAL_CTRL_e__DTB_SEL__SHIFT(int
> >>>
> >>> a, int b, int c, int d, int e) __attribute__((pure));
> >>>
> >>> I suppose the file nbio_6_1_sh_mask.h is the output of a tool (it is =
a
> >>> generated file). It is an option to modify the tool to output C
> >>> functions with proper input guards instead of #define directives.
> >>
> >> The registers are generated by the HW team and then filtered down to
> >> become what we release publicly.  It is machine generated very likely
> >> from the RTL that specifies the hardware itself.
> >
> > Yes, exactly that. And it was actually quite some work to get to this
> > point.
> >
> >> Generally speaking if a class of registers share masks/offsets the
> >> lowest (zero'th) is used in programming and offsets are used when
> >> selecting the correct MMIO address to use specific instances.
> >
> > The problem is that the files we get from the HW team describe the
> > register block already broken down to the memory mappings. E.g. when an
> > RTL block is instantiated N times you get N times the same definition.
> >
> >>
> >> Having these enumerated though is handy for tools like UMR which would
> >> decode to the correct instance of the register (you could even see
> >> that by watching the logscan via umr).  So we make use of them fairly
> >> efficiently.  UMR reads the headers to create the arrays of
> >> registers/bitfields which if they were computed at runtime (via helper
> >> functions) would be harder to parse (and could amount to the halting
> >> problem...).
> >>
> >> What is in the NBIO header today is what was IP cleared but in theory
> >> it could be filtered down more simply to reduce the unused LOCs in
> >> future kernels.
> >>
> >> They don't make for good bedtime reading but imho you'd rather have
> >> more headers not less :-)
> >
> > Manually merging that back into single definitions is not really an
> > option, but what we could do is releasing the full blown headers
> > somewhere and only limit what we push into the linux kernel to actually
> > used ones.
>
> Hi Christian,
>
> I have to say I prefer your idea here and perhaps they could even become
> part of the UMR repo, not sure? May I suggest the reduction to some like
> a `kernel-native-dialect` could be automated with a clang plugin. It
> seems like heaps of work however maybe not really, clang provides a API
> to grammatically do some AST transformers and auto-rewrite large chunks
> of code given some rules.
>
> I also agree with Tom, its certainly nice to have them regardless, just
> perhaps the kernel mainline repo is the wrong place for the kitchen sink.
>
> Just my thoughts,
> Kind Regards,
> Edward.
>
> >
> > Christian.
> >
> >
> >>
> >> Tom
> >> _______________________________________________
> >> amd-gfx mailing list
> >> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> >> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
> >
> >
> > _______________________________________________
> > amd-gfx mailing list
> > amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> > https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>
>

--001a113f663236acd5054b3c8e9c
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">It would be better to keep the headers as-is, because cha=
nging them wouldn&#39;t fix anybody&#39;s problems, but it would take time =
from us that we don&#39;t have.<div dir=3D"auto"><br></div><div dir=3D"auto=
">Marek</div></div><div class=3D"gmail_extra"><br><div class=3D"gmail_quote=
">On Mar 21, 2017 9:46 AM, &quot;Edward O&#39;Callaghan&quot; &lt;<a href=
=3D"mailto:funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org">funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org</a>&gt;=
 wrote:<br type=3D"attribution"><blockquote class=3D"gmail_quote" style=3D"=
margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><br>
<br>
On 03/21/2017 05:36 PM, Christian K=C3=B6nig wrote:<br>
&gt; Am 21.03.2017 um 00:38 schrieb Tom St Denis:<br>
&gt;&gt; On 03/20/2017 06:34 PM, Jan Ziak wrote:<br>
&gt;&gt;&gt; On Mon, Mar 20, 2017 at 10:41 PM, Alex Deucher &lt;<a href=3D"=
mailto:alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org">alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a><br>
&gt;&gt;&gt; &lt;mailto:<a href=3D"mailto:alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org">alexdeuche=
r@gmail.com</a>&gt;<wbr>&gt; wrote:<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0On Mon, Mar 20, 2017 at 5:36 PM, Jan Ziak &=
lt;<a href=3D"mailto:0xe2.0x9a.0x9b-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org">0xe2.0x9a.0x9b-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>=
<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0&lt;mailto:<a href=3D"mailto:0xe2.0x9a.0x9b=
@gmail.com">0xe2.0x9a.0x9b@gmail.<wbr>com</a>&gt;&gt; wrote:<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; Hi<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;&gt;&gt; <a href=3D"https://cgit.freedesktop.org/~agd5f/linux/plain/dri=
vers/gpu/drm/amd/include/asic_reg/vega10/NBIO/nbio_6_1_sh_mask.h?h=3Damd-st=
aging-4.9&amp;id=3D9555ef0ba926df25d9a637d0ea21bc0d231c21d2" rel=3D"norefer=
rer" target=3D"_blank">https://cgit.freedesktop.org/~<wbr>agd5f/linux/plain=
/drivers/gpu/<wbr>drm/amd/include/asic_reg/<wbr>vega10/NBIO/nbio_6_1_sh_mas=
k.<wbr>h?h=3Damd-staging-4.9&amp;id=3D<wbr>9555ef0ba926df25d9a637d0ea21bc<w=
br>0d231c21d2</a><br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; &lt;<a href=3D"https://cgit.freedesktop.org/~agd5f/linux/plain=
/drivers/gpu/drm/amd/include/asic_reg/vega10/NBIO/nbio_6_1_sh_mask.h?h=3Dam=
d-staging-4.9&amp;id=3D9555ef0ba926df25d9a637d0ea21bc0d231c21d2" rel=3D"nor=
eferrer" target=3D"_blank">https://cgit.freedesktop.org/<wbr>~agd5f/linux/p=
lain/drivers/<wbr>gpu/drm/amd/include/asic_reg/<wbr>vega10/NBIO/nbio_6_1_sh=
_mask.<wbr>h?h=3Damd-staging-4.9&amp;id=3D<wbr>9555ef0ba926df25d9a637d0ea21=
bc<wbr>0d231c21d2</a>&gt;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; The file nbio_6_1_sh_mask.h is uncompr=
essed. It consists from<br>
&gt;&gt;&gt; 133884 lines.<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; Only generated C/C++ code will be able=
 to utilize the content<br>
&gt;&gt;&gt; of such a file<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; efficiently. All hand-written codes co=
mbined will be able to<br>
&gt;&gt;&gt; utilize about<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; 1% of the file.<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0&gt; Is there a reason why nbio_6_1_sh_mask=
.h is huge?<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0That IP block contains a lot of registers.=
=C2=A0 The idea is to open<br>
&gt;&gt;&gt; source<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0as much IP as possible to facilitate debugg=
ing, new features, etc.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0Alex<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; [This email contains long/wide lines and should be viewed on a=
<br>
&gt;&gt;&gt; sufficiently wide screen]<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; For example if I open the file in vim and go to line 66952:<br=
>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; #define<br>
&gt;&gt;&gt; DWC_E12MP_PHY_X4_NS_X4_1_<wbr>LANE1_DIG_RX_VCOCAL_RX_VCO_<wbr>=
CAL_CTRL_1__DTB_SEL__SHIFT<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; 0x9<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; Then abstracting away some of the digits used in the defined i=
dentifier<br>
&gt;&gt;&gt; and using egrep:<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; $ egrep<br>
&gt;&gt;&gt; &quot;\&lt;DWC_E12MP_PHY_X._NS_X._._<wbr>LANE._DIG_RX_VCOCAL_R=
X_VCO_<wbr>CAL_CTRL_.__DTB_SEL__SHIFT\&gt;&quot;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; nbio_6_1_sh_mask.h<br>
&gt;&gt;&gt; #define<br>
&gt;&gt;&gt; DWC_E12MP_PHY_X4_NS_X4_0_<wbr>LANE0_DIG_RX_VCOCAL_RX_VCO_<wbr>=
CAL_CTRL_1__DTB_SEL__SHIFT<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 0x9<br>
&gt;&gt;&gt; #define<br>
&gt;&gt;&gt; DWC_E12MP_PHY_X4_NS_X4_0_<wbr>LANE1_DIG_RX_VCOCAL_RX_VCO_<wbr>=
CAL_CTRL_1__DTB_SEL__SHIFT<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 0x9<br>
&gt;&gt;&gt; #define<br>
&gt;&gt;&gt; DWC_E12MP_PHY_X4_NS_X4_0_<wbr>LANE2_DIG_RX_VCOCAL_RX_VCO_<wbr>=
CAL_CTRL_1__DTB_SEL__SHIFT<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 0x9<br>
&gt;&gt;&gt; #define<br>
&gt;&gt;&gt; DWC_E12MP_PHY_X4_NS_X4_0_<wbr>LANE3_DIG_RX_VCOCAL_RX_VCO_<wbr>=
CAL_CTRL_1__DTB_SEL__SHIFT<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 0x9<br>
&gt;&gt;&gt; #define<br>
&gt;&gt;&gt; DWC_E12MP_PHY_X4_NS_X4_0_<wbr>LANEX_DIG_RX_VCOCAL_RX_VCO_<wbr>=
CAL_CTRL_1__DTB_SEL__SHIFT<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 0x9<br>
&gt;&gt;&gt; #define<br>
&gt;&gt;&gt; DWC_E12MP_PHY_X4_NS_X4_1_<wbr>LANE0_DIG_RX_VCOCAL_RX_VCO_<wbr>=
CAL_CTRL_1__DTB_SEL__SHIFT<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 0x9<br>
&gt;&gt;&gt; #define<br>
&gt;&gt;&gt; DWC_E12MP_PHY_X4_NS_X4_1_<wbr>LANE1_DIG_RX_VCOCAL_RX_VCO_<wbr>=
CAL_CTRL_1__DTB_SEL__SHIFT<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 0x9<br>
&gt;&gt;&gt; #define<br>
&gt;&gt;&gt; DWC_E12MP_PHY_X4_NS_X4_1_<wbr>LANE2_DIG_RX_VCOCAL_RX_VCO_<wbr>=
CAL_CTRL_1__DTB_SEL__SHIFT<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 0x9<br>
&gt;&gt;&gt; #define<br>
&gt;&gt;&gt; DWC_E12MP_PHY_X4_NS_X4_1_<wbr>LANE3_DIG_RX_VCOCAL_RX_VCO_<wbr>=
CAL_CTRL_1__DTB_SEL__SHIFT<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 0x9<br>
&gt;&gt;&gt; #define<br>
&gt;&gt;&gt; DWC_E12MP_PHY_X4_NS_X4_1_<wbr>LANEX_DIG_RX_VCOCAL_RX_VCO_<wbr>=
CAL_CTRL_1__DTB_SEL__SHIFT<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 0x9<br>
&gt;&gt;&gt; #define<br>
&gt;&gt;&gt; DWC_E12MP_PHY_X4_NS_X4_2_<wbr>LANE0_DIG_RX_VCOCAL_RX_VCO_<wbr>=
CAL_CTRL_1__DTB_SEL__SHIFT<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 0x9<br>
&gt;&gt;&gt; #define<br>
&gt;&gt;&gt; DWC_E12MP_PHY_X4_NS_X4_2_<wbr>LANE1_DIG_RX_VCOCAL_RX_VCO_<wbr>=
CAL_CTRL_1__DTB_SEL__SHIFT<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 0x9<br>
&gt;&gt;&gt; #define<br>
&gt;&gt;&gt; DWC_E12MP_PHY_X4_NS_X4_2_<wbr>LANE2_DIG_RX_VCOCAL_RX_VCO_<wbr>=
CAL_CTRL_1__DTB_SEL__SHIFT<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 0x9<br>
&gt;&gt;&gt; #define<br>
&gt;&gt;&gt; DWC_E12MP_PHY_X4_NS_X4_2_<wbr>LANE3_DIG_RX_VCOCAL_RX_VCO_<wbr>=
CAL_CTRL_1__DTB_SEL__SHIFT<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 0x9<br>
&gt;&gt;&gt; #define<br>
&gt;&gt;&gt; DWC_E12MP_PHY_X4_NS_X4_2_<wbr>LANEX_DIG_RX_VCOCAL_RX_VCO_<wbr>=
CAL_CTRL_1__DTB_SEL__SHIFT<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 0x9<br>
&gt;&gt;&gt; #define<br>
&gt;&gt;&gt; DWC_E12MP_PHY_X4_NS_X4_3_<wbr>LANE0_DIG_RX_VCOCAL_RX_VCO_<wbr>=
CAL_CTRL_1__DTB_SEL__SHIFT<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 0x9<br>
&gt;&gt;&gt; #define<br>
&gt;&gt;&gt; DWC_E12MP_PHY_X4_NS_X4_3_<wbr>LANE1_DIG_RX_VCOCAL_RX_VCO_<wbr>=
CAL_CTRL_1__DTB_SEL__SHIFT<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 0x9<br>
&gt;&gt;&gt; #define<br>
&gt;&gt;&gt; DWC_E12MP_PHY_X4_NS_X4_3_<wbr>LANE2_DIG_RX_VCOCAL_RX_VCO_<wbr>=
CAL_CTRL_1__DTB_SEL__SHIFT<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 0x9<br>
&gt;&gt;&gt; #define<br>
&gt;&gt;&gt; DWC_E12MP_PHY_X4_NS_X4_3_<wbr>LANE3_DIG_RX_VCOCAL_RX_VCO_<wbr>=
CAL_CTRL_1__DTB_SEL__SHIFT<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 0x9<br>
&gt;&gt;&gt; #define<br>
&gt;&gt;&gt; DWC_E12MP_PHY_X4_NS_X4_3_<wbr>LANEX_DIG_RX_VCOCAL_RX_VCO_<wbr>=
CAL_CTRL_1__DTB_SEL__SHIFT<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 0x9<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; The egrep command produced 20 lines.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; Instead of the many #define directives, it is a possibility to=
 define<br>
&gt;&gt;&gt; functions such as:<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; int<br>
&gt;&gt;&gt; DWC_E12MP_PHY_Xa_NS_Xb_c_<wbr>LANEd_DIG_RX_VCOCAL_RX_VCO_<wbr>=
CAL_CTRL_e__DTB_SEL__SHIFT(int<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; a, int b, int c, int d, int e) __attribute__((pure));<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; I suppose the file nbio_6_1_sh_mask.h is the output of a tool =
(it is a<br>
&gt;&gt;&gt; generated file). It is an option to modify the tool to output =
C<br>
&gt;&gt;&gt; functions with proper input guards instead of #define directiv=
es.<br>
&gt;&gt;<br>
&gt;&gt; The registers are generated by the HW team and then filtered down =
to<br>
&gt;&gt; become what we release publicly.=C2=A0 It is machine generated ver=
y likely<br>
&gt;&gt; from the RTL that specifies the hardware itself.<br>
&gt;<br>
&gt; Yes, exactly that. And it was actually quite some work to get to this<=
br>
&gt; point.<br>
&gt;<br>
&gt;&gt; Generally speaking if a class of registers share masks/offsets the=
<br>
&gt;&gt; lowest (zero&#39;th) is used in programming and offsets are used w=
hen<br>
&gt;&gt; selecting the correct MMIO address to use specific instances.<br>
&gt;<br>
&gt; The problem is that the files we get from the HW team describe the<br>
&gt; register block already broken down to the memory mappings. E.g. when a=
n<br>
&gt; RTL block is instantiated N times you get N times the same definition.=
<br>
&gt;<br>
&gt;&gt;<br>
&gt;&gt; Having these enumerated though is handy for tools like UMR which w=
ould<br>
&gt;&gt; decode to the correct instance of the register (you could even see=
<br>
&gt;&gt; that by watching the logscan via umr).=C2=A0 So we make use of the=
m fairly<br>
&gt;&gt; efficiently.=C2=A0 UMR reads the headers to create the arrays of<b=
r>
&gt;&gt; registers/bitfields which if they were computed at runtime (via he=
lper<br>
&gt;&gt; functions) would be harder to parse (and could amount to the halti=
ng<br>
&gt;&gt; problem...).<br>
&gt;&gt;<br>
&gt;&gt; What is in the NBIO header today is what was IP cleared but in the=
ory<br>
&gt;&gt; it could be filtered down more simply to reduce the unused LOCs in=
<br>
&gt;&gt; future kernels.<br>
&gt;&gt;<br>
&gt;&gt; They don&#39;t make for good bedtime reading but imho you&#39;d ra=
ther have<br>
&gt;&gt; more headers not less :-)<br>
&gt;<br>
&gt; Manually merging that back into single definitions is not really an<br=
>
&gt; option, but what we could do is releasing the full blown headers<br>
&gt; somewhere and only limit what we push into the linux kernel to actuall=
y<br>
&gt; used ones.<br>
<br>
Hi Christian,<br>
<br>
I have to say I prefer your idea here and perhaps they could even become<br=
>
part of the UMR repo, not sure? May I suggest the reduction to some like<br=
>
a `kernel-native-dialect` could be automated with a clang plugin. It<br>
seems like heaps of work however maybe not really, clang provides a API<br>
to grammatically do some AST transformers and auto-rewrite large chunks<br>
of code given some rules.<br>
<br>
I also agree with Tom, its certainly nice to have them regardless, just<br>
perhaps the kernel mainline repo is the wrong place for the kitchen sink.<b=
r>
<br>
Just my thoughts,<br>
Kind Regards,<br>
Edward.<br>
<br>
&gt;<br>
&gt; Christian.<br>
&gt;<br>
&gt;<br>
&gt;&gt;<br>
&gt;&gt; Tom<br>
&gt;&gt; ______________________________<wbr>_________________<br>
&gt;&gt; amd-gfx mailing list<br>
&gt;&gt; <a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32mzQB+pC5nmwQ@public.gmane.org=
edesktop.org</a><br>
&gt;&gt; <a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx"=
 rel=3D"noreferrer" target=3D"_blank">https://lists.freedesktop.org/<wbr>ma=
ilman/listinfo/amd-gfx</a><br>
&gt;<br>
&gt;<br>
&gt; ______________________________<wbr>_________________<br>
&gt; amd-gfx mailing list<br>
&gt; <a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32mqWrfYKbYh0A@public.gmane.org=
ktop.org</a><br>
&gt; <a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx" rel=
=3D"noreferrer" target=3D"_blank">https://lists.freedesktop.org/<wbr>mailma=
n/listinfo/amd-gfx</a><br>
<br>
<br>______________________________<wbr>_________________<br>
amd-gfx mailing list<br>
<a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9/rsn8yoX9R0@public.gmane.org=
org</a><br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx" rel=3D"n=
oreferrer" target=3D"_blank">https://lists.freedesktop.org/<wbr>mailman/lis=
tinfo/amd-gfx</a><br>
<br></blockquote></div></div>

--001a113f663236acd5054b3c8e9c--

--===============1061853685==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1061853685==--
