From: Jan Ziak <0xe2.0x9a.0x9b-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 000/100] Add Vega10 Support
Date: Mon, 20 Mar 2017 23:34:52 +0100
Message-ID: <CAODFU0q8C=yW-rBhf-Tj7AT=OijGfRViajMQH59WVYzHmPU9LA@mail.gmail.com>
References: <CAODFU0pW=uyAa9Bdjbzv63cFaBMoF34+rW9xWDorAuMKHFsRUQ@mail.gmail.com>
 <CADnq5_ONBTDeGQC_3ApDBv+xa88r5ZvA0RHiZHbohYBZ48=F5g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1445564585=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CADnq5_ONBTDeGQC_3ApDBv+xa88r5ZvA0RHiZHbohYBZ48=F5g-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
To: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============1445564585==
Content-Type: multipart/alternative; boundary=f40304353fa0fd601e054b3123a9

--f40304353fa0fd601e054b3123a9
Content-Type: text/plain; charset=UTF-8

On Mon, Mar 20, 2017 at 10:41 PM, Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
wrote:

> On Mon, Mar 20, 2017 at 5:36 PM, Jan Ziak <0xe2.0x9a.0x9b-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> wrote:
> > Hi
> >
> > https://cgit.freedesktop.org/~agd5f/linux/plain/drivers/gpu/
> drm/amd/include/asic_reg/vega10/NBIO/nbio_6_1_sh_mask.
> h?h=amd-staging-4.9&id=9555ef0ba926df25d9a637d0ea21bc0d231c21d2
> >
> > The file nbio_6_1_sh_mask.h is uncompressed. It consists from 133884
> lines.
> > Only generated C/C++ code will be able to utilize the content of such a
> file
> > efficiently. All hand-written codes combined will be able to utilize
> about
> > 1% of the file.
> >
> > Is there a reason why nbio_6_1_sh_mask.h is huge?
>
> That IP block contains a lot of registers.  The idea is to open source
> as much IP as possible to facilitate debugging, new features, etc.
>
> Alex
>

[This email contains long/wide lines and should be viewed on a sufficiently
wide screen]

For example if I open the file in vim and go to line 66952:

#define DWC_E12MP_PHY_X4_NS_X4_1_LANE1_DIG_RX_VCOCAL_RX_VCO_CAL_CTRL_1__DTB_SEL__SHIFT
0x9

Then abstracting away some of the digits used in the defined identifier and
using egrep:

$ egrep
"\<DWC_E12MP_PHY_X._NS_X._._LANE._DIG_RX_VCOCAL_RX_VCO_CAL_CTRL_.__DTB_SEL__SHIFT\>"
nbio_6_1_sh_mask.h
#define
DWC_E12MP_PHY_X4_NS_X4_0_LANE0_DIG_RX_VCOCAL_RX_VCO_CAL_CTRL_1__DTB_SEL__SHIFT
                       0x9
#define
DWC_E12MP_PHY_X4_NS_X4_0_LANE1_DIG_RX_VCOCAL_RX_VCO_CAL_CTRL_1__DTB_SEL__SHIFT
                       0x9
#define
DWC_E12MP_PHY_X4_NS_X4_0_LANE2_DIG_RX_VCOCAL_RX_VCO_CAL_CTRL_1__DTB_SEL__SHIFT
                       0x9
#define
DWC_E12MP_PHY_X4_NS_X4_0_LANE3_DIG_RX_VCOCAL_RX_VCO_CAL_CTRL_1__DTB_SEL__SHIFT
                       0x9
#define
DWC_E12MP_PHY_X4_NS_X4_0_LANEX_DIG_RX_VCOCAL_RX_VCO_CAL_CTRL_1__DTB_SEL__SHIFT
                       0x9
#define
DWC_E12MP_PHY_X4_NS_X4_1_LANE0_DIG_RX_VCOCAL_RX_VCO_CAL_CTRL_1__DTB_SEL__SHIFT
                       0x9
#define
DWC_E12MP_PHY_X4_NS_X4_1_LANE1_DIG_RX_VCOCAL_RX_VCO_CAL_CTRL_1__DTB_SEL__SHIFT
                       0x9
#define
DWC_E12MP_PHY_X4_NS_X4_1_LANE2_DIG_RX_VCOCAL_RX_VCO_CAL_CTRL_1__DTB_SEL__SHIFT
                       0x9
#define
DWC_E12MP_PHY_X4_NS_X4_1_LANE3_DIG_RX_VCOCAL_RX_VCO_CAL_CTRL_1__DTB_SEL__SHIFT
                       0x9
#define
DWC_E12MP_PHY_X4_NS_X4_1_LANEX_DIG_RX_VCOCAL_RX_VCO_CAL_CTRL_1__DTB_SEL__SHIFT
                       0x9
#define
DWC_E12MP_PHY_X4_NS_X4_2_LANE0_DIG_RX_VCOCAL_RX_VCO_CAL_CTRL_1__DTB_SEL__SHIFT
                       0x9
#define
DWC_E12MP_PHY_X4_NS_X4_2_LANE1_DIG_RX_VCOCAL_RX_VCO_CAL_CTRL_1__DTB_SEL__SHIFT
                       0x9
#define
DWC_E12MP_PHY_X4_NS_X4_2_LANE2_DIG_RX_VCOCAL_RX_VCO_CAL_CTRL_1__DTB_SEL__SHIFT
                       0x9
#define
DWC_E12MP_PHY_X4_NS_X4_2_LANE3_DIG_RX_VCOCAL_RX_VCO_CAL_CTRL_1__DTB_SEL__SHIFT
                       0x9
#define
DWC_E12MP_PHY_X4_NS_X4_2_LANEX_DIG_RX_VCOCAL_RX_VCO_CAL_CTRL_1__DTB_SEL__SHIFT
                       0x9
#define
DWC_E12MP_PHY_X4_NS_X4_3_LANE0_DIG_RX_VCOCAL_RX_VCO_CAL_CTRL_1__DTB_SEL__SHIFT
                       0x9
#define
DWC_E12MP_PHY_X4_NS_X4_3_LANE1_DIG_RX_VCOCAL_RX_VCO_CAL_CTRL_1__DTB_SEL__SHIFT
                       0x9
#define
DWC_E12MP_PHY_X4_NS_X4_3_LANE2_DIG_RX_VCOCAL_RX_VCO_CAL_CTRL_1__DTB_SEL__SHIFT
                       0x9
#define
DWC_E12MP_PHY_X4_NS_X4_3_LANE3_DIG_RX_VCOCAL_RX_VCO_CAL_CTRL_1__DTB_SEL__SHIFT
                       0x9
#define
DWC_E12MP_PHY_X4_NS_X4_3_LANEX_DIG_RX_VCOCAL_RX_VCO_CAL_CTRL_1__DTB_SEL__SHIFT
                       0x9

The egrep command produced 20 lines.

Instead of the many #define directives, it is a possibility to define
functions such as:

int
DWC_E12MP_PHY_Xa_NS_Xb_c_LANEd_DIG_RX_VCOCAL_RX_VCO_CAL_CTRL_e__DTB_SEL__SHIFT(int
a, int b, int c, int d, int e) __attribute__((pure));

I suppose the file nbio_6_1_sh_mask.h is the output of a tool (it is a
generated file). It is an option to modify the tool to output C functions
with proper input guards instead of #define directives.

Jan

--f40304353fa0fd601e054b3123a9
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><div class=3D"gmail_quote">On M=
on, Mar 20, 2017 at 10:41 PM, Alex Deucher <span dir=3D"ltr">&lt;<a href=3D=
"mailto:alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" target=3D"_blank">alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&=
gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0px =
0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><spa=
n class=3D"gmail-">On Mon, Mar 20, 2017 at 5:36 PM, Jan Ziak &lt;<a href=3D=
"mailto:0xe2.0x9a.0x9b-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org">0xe2.0x9a.0x9b-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt; wrote:<b=
r>
&gt; Hi<br>
&gt;<br>
&gt; <a href=3D"https://cgit.freedesktop.org/~agd5f/linux/plain/drivers/gpu=
/drm/amd/include/asic_reg/vega10/NBIO/nbio_6_1_sh_mask.h?h=3Damd-staging-4.=
9&amp;id=3D9555ef0ba926df25d9a637d0ea21bc0d231c21d2" rel=3D"noreferrer" tar=
get=3D"_blank">https://cgit.freedesktop.org/~<wbr>agd5f/linux/plain/drivers=
/gpu/<wbr>drm/amd/include/asic_reg/<wbr>vega10/NBIO/nbio_6_1_sh_mask.<wbr>h=
?h=3Damd-staging-4.9&amp;id=3D<wbr>9555ef0ba926df25d9a637d0ea21bc<wbr>0d231=
c21d2</a><br>
&gt;<br>
&gt; The file nbio_6_1_sh_mask.h is uncompressed. It consists from 133884 l=
ines.<br>
&gt; Only generated C/C++ code will be able to utilize the content of such =
a file<br>
&gt; efficiently. All hand-written codes combined will be able to utilize a=
bout<br>
&gt; 1% of the file.<br>
&gt;<br>
&gt; Is there a reason why nbio_6_1_sh_mask.h is huge?<br>
<br>
</span>That IP block contains a lot of registers.=C2=A0 The idea is to open=
 source<br>
as much IP as possible to facilitate debugging, new features, etc.<br>
<span class=3D"gmail-HOEnZb"><font color=3D"#888888"><br>
Alex<br>
</font></span></blockquote></div><br></div><div class=3D"gmail_extra">[This=
 email contains long/wide lines and should be viewed on a sufficiently wide=
 screen]<br></div><div class=3D"gmail_extra"><br></div><div class=3D"gmail_=
extra">For example if I open the file in vim and go to line 66952:</div><di=
v class=3D"gmail_extra"><br></div><div class=3D"gmail_extra">#define=C2=A0D=
WC_E12MP_PHY_X4_NS_X4_1_LANE1_DIG_RX_VCOCAL_RX_VCO_CAL_CTRL_1__DTB_SEL__SHI=
FT 0x9<br></div><div class=3D"gmail_extra"><br></div><div class=3D"gmail_ex=
tra">Then abstracting away some of the digits used in the defined identifie=
r and using egrep:</div><div class=3D"gmail_extra"><br></div><div class=3D"=
gmail_extra"><div class=3D"gmail_extra">$ egrep &quot;\&lt;DWC_E12MP_PHY_X.=
_NS_X._._LANE._DIG_RX_VCOCAL_RX_VCO_CAL_CTRL_.__DTB_SEL__SHIFT\&gt;&quot; n=
bio_6_1_sh_mask.h=C2=A0</div><div class=3D"gmail_extra">#define DWC_E12MP_P=
HY_X4_NS_X4_0_LANE0_DIG_RX_VCOCAL_RX_VCO_CAL_CTRL_1__DTB_SEL__SHIFT =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A00x9</div><div class=3D"gmail_extra">#define DWC_E12MP_PHY_X4_NS_X4_0_LAN=
E1_DIG_RX_VCOCAL_RX_VCO_CAL_CTRL_1__DTB_SEL__SHIFT =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00x9</div><div cl=
ass=3D"gmail_extra">#define DWC_E12MP_PHY_X4_NS_X4_0_LANE2_DIG_RX_VCOCAL_RX=
_VCO_CAL_CTRL_1__DTB_SEL__SHIFT =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00x9</div><div class=3D"gmail_extra=
">#define DWC_E12MP_PHY_X4_NS_X4_0_LANE3_DIG_RX_VCOCAL_RX_VCO_CAL_CTRL_1__D=
TB_SEL__SHIFT =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A00x9</div><div class=3D"gmail_extra">#define DWC_E12=
MP_PHY_X4_NS_X4_0_LANEX_DIG_RX_VCOCAL_RX_VCO_CAL_CTRL_1__DTB_SEL__SHIFT =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A00x9</div><div class=3D"gmail_extra">#define DWC_E12MP_PHY_X4_NS_X4_1_=
LANE0_DIG_RX_VCOCAL_RX_VCO_CAL_CTRL_1__DTB_SEL__SHIFT =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00x9</div><div=
 class=3D"gmail_extra">#define DWC_E12MP_PHY_X4_NS_X4_1_LANE1_DIG_RX_VCOCAL=
_RX_VCO_CAL_CTRL_1__DTB_SEL__SHIFT =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00x9</div><div class=3D"gmail_e=
xtra">#define DWC_E12MP_PHY_X4_NS_X4_1_LANE2_DIG_RX_VCOCAL_RX_VCO_CAL_CTRL_=
1__DTB_SEL__SHIFT =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A00x9</div><div class=3D"gmail_extra">#define DWC_=
E12MP_PHY_X4_NS_X4_1_LANE3_DIG_RX_VCOCAL_RX_VCO_CAL_CTRL_1__DTB_SEL__SHIFT =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A00x9</div><div class=3D"gmail_extra">#define DWC_E12MP_PHY_X4_NS_X=
4_1_LANEX_DIG_RX_VCOCAL_RX_VCO_CAL_CTRL_1__DTB_SEL__SHIFT =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00x9</div>=
<div class=3D"gmail_extra">#define DWC_E12MP_PHY_X4_NS_X4_2_LANE0_DIG_RX_VC=
OCAL_RX_VCO_CAL_CTRL_1__DTB_SEL__SHIFT =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00x9</div><div class=3D"gmai=
l_extra">#define DWC_E12MP_PHY_X4_NS_X4_2_LANE1_DIG_RX_VCOCAL_RX_VCO_CAL_CT=
RL_1__DTB_SEL__SHIFT =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00x9</div><div class=3D"gmail_extra">#define =
DWC_E12MP_PHY_X4_NS_X4_2_LANE2_DIG_RX_VCOCAL_RX_VCO_CAL_CTRL_1__DTB_SEL__SH=
IFT =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A00x9</div><div class=3D"gmail_extra">#define DWC_E12MP_PHY_X4_N=
S_X4_2_LANE3_DIG_RX_VCOCAL_RX_VCO_CAL_CTRL_1__DTB_SEL__SHIFT =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00x9</d=
iv><div class=3D"gmail_extra">#define DWC_E12MP_PHY_X4_NS_X4_2_LANEX_DIG_RX=
_VCOCAL_RX_VCO_CAL_CTRL_1__DTB_SEL__SHIFT =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00x9</div><div class=3D"=
gmail_extra">#define DWC_E12MP_PHY_X4_NS_X4_3_LANE0_DIG_RX_VCOCAL_RX_VCO_CA=
L_CTRL_1__DTB_SEL__SHIFT =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00x9</div><div class=3D"gmail_extra">#defi=
ne DWC_E12MP_PHY_X4_NS_X4_3_LANE1_DIG_RX_VCOCAL_RX_VCO_CAL_CTRL_1__DTB_SEL_=
_SHIFT =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A00x9</div><div class=3D"gmail_extra">#define DWC_E12MP_PHY_=
X4_NS_X4_3_LANE2_DIG_RX_VCOCAL_RX_VCO_CAL_CTRL_1__DTB_SEL__SHIFT =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00x=
9</div><div class=3D"gmail_extra">#define DWC_E12MP_PHY_X4_NS_X4_3_LANE3_DI=
G_RX_VCOCAL_RX_VCO_CAL_CTRL_1__DTB_SEL__SHIFT =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00x9</div><div class=
=3D"gmail_extra">#define DWC_E12MP_PHY_X4_NS_X4_3_LANEX_DIG_RX_VCOCAL_RX_VC=
O_CAL_CTRL_1__DTB_SEL__SHIFT =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00x9</div><div class=3D"gmail_extra"><=
br></div><div class=3D"gmail_extra">The egrep command produced 20 lines.</d=
iv><div class=3D"gmail_extra"><br></div><div class=3D"gmail_extra">Instead =
of the many #define directives, it is a possibility to define functions suc=
h as:</div><div class=3D"gmail_extra"><br></div><div class=3D"gmail_extra">=
int DWC_E12MP_PHY_Xa_NS_Xb_c_LANEd_DIG_RX_VCOCAL_RX_VCO_CAL_CTRL_e__DTB_SEL=
__SHIFT(int a, int b, int c, int d, int e) __attribute__((pure));</div><div=
 class=3D"gmail_extra"><br></div><div class=3D"gmail_extra">I suppose the f=
ile nbio_6_1_sh_mask.h is the output of a tool (it is a generated file). It=
 is an option to modify the tool to output C functions with proper input gu=
ards instead of #define directives.</div><div class=3D"gmail_extra"><br></d=
iv><div class=3D"gmail_extra">Jan</div></div></div>

--f40304353fa0fd601e054b3123a9--

--===============1445564585==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1445564585==--
