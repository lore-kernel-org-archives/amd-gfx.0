From: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: tidy'ing up cz_hwmgr.c
Date: Thu, 18 Aug 2016 11:33:41 -0400
Message-ID: <CADnq5_Ntb79gEF=1Xa7BP=J4GgTzb+vY8ZbZijVTVPvaAJGrng@mail.gmail.com>
References: <DM5PR12MB1132F1D9FF8F44E09BE37EF4F7150@DM5PR12MB1132.namprd12.prod.outlook.com>
 <642600e3-dd63-7b36-a749-451a451ab153@vodafone.de>
 <DM5PR12MB11329451427722B9088E40F7F7150@DM5PR12MB1132.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0686184706=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <DM5PR12MB11329451427722B9088E40F7F7150-2J9CzHegvk+UzrhdoDeimQdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
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
To: "StDenis, Tom" <Tom.StDenis-5C7GfCeVMHo@public.gmane.org>
Cc: =?UTF-8?Q?Christian_K=C3=B6nig?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>, amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============0686184706==
Content-Type: multipart/related; boundary=001a114db34a893ab3053a5a4e11

--001a114db34a893ab3053a5a4e11
Content-Type: multipart/alternative; boundary=001a114db34a893ab1053a5a4e10

--001a114db34a893ab1053a5a4e10
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

The problem we ran into was when we had a struct like this:

struct table {
   uint16_t size;
   struct element elements[0];
};

and then we would try and index the array:

for (i =3D 0; i < table->size; i++) {
  element =3D &table->elements[i];
}

element ended up off in the weeds.  The only thing that seems to make some
versions of gcc happy was pointer arithmetic.  E.g.,

element =3D (struct element *)((char *)&table->elements[0] + (sizeof(struct
element) * i));

Alex

On Thu, Aug 18, 2016 at 11:21 AM, StDenis, Tom <Tom.StDenis-5C7GfCeVMHo@public.gmane.org> wrote:

> Any modern GCC should support [0] at the tail of a struct.  This came up
> because when I was reading the code I saw they allocated 7 slots (plus th=
e
> size of the struct) but then fill 8 slots.  It's just weird [image: =F0=
=9F=98=8A]
>
>
> Using [0] in the struct and allocating for 8 entries makes more sense and
> is clearer to read.
>
>
> Tom
>
>
> ------------------------------
> *From:* Christian K=C3=B6nig <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
> *Sent:* Thursday, August 18, 2016 11:17
> *To:* StDenis, Tom; amd-gfx list
> *Subject:* Re: tidy'ing up cz_hwmgr.c
>
>
> Has a [1] array at the tail which is then kzalloc'ed with N-1 entries.
> Shouldn't that just be a [0] with N entries allocated for clarity?
>
> Actually the starting address of a dynamic array should be manually
> calculated instead of using [1] or [0].
>
> We had tons of problems with that because some gcc versions get this wron=
g
> and the atombios code used this as well.
>
> Alex how did we resolved such issues?
>
> Regards,
> Christian.
>
> Am 18.08.2016 um 16:26 schrieb StDenis, Tom:
>
> Tidying up cz_hwmgr.c I noted a couple of things but first is
>
>
> static bool cz_dpm_check_smu_features(struct pp_hwmgr *hwmgr,
> unsigned long check_feature);
>
> Which will return "true" if the smu call fails *or* the feature is set.
>
> The structure
>
> struct phm_clock_voltage_dependency_table;
>
> Has a [1] array at the tail which is then kzalloc'ed with N-1 entries.
> Shouldn't that just be a [0] with N entries allocated for clarity?
>
> Tom
>
>
>
> _______________________________________________
> amd-gfx mailing listamd-gfx-PD4FTy7X32lNgt0PjOBp934avgP/u3fG0wdF1cv0I5s@public.gmane.org://lists.freedeskto=
p.org/mailman/listinfo/amd-gfx
>
>
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>
>

--001a114db34a893ab1053a5a4e10
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div><div>The problem we ran into was when we had a s=
truct like this:<br><br></div>struct table {<br></div>=C2=A0=C2=A0 uint16_t=
 size;<br></div>=C2=A0=C2=A0 struct element elements[0];<br><div><div>};<br=
><div><div><div class=3D"gmail_extra"><br></div><div class=3D"gmail_extra">=
and then we would try and index the array:<br><br></div><div class=3D"gmail=
_extra">for (i =3D 0; i &lt; table-&gt;size; i++) {<br></div><div class=3D"=
gmail_extra">=C2=A0 element =3D &amp;table-&gt;elements[i];<br></div><div c=
lass=3D"gmail_extra">}<br><br></div><div class=3D"gmail_extra">element ende=
d up off in the weeds.=C2=A0 The only thing that seems to make some version=
s of gcc happy was pointer arithmetic.=C2=A0 E.g.,<br></div><div class=3D"g=
mail_extra"><br></div><div class=3D"gmail_extra">element =3D (struct elemen=
t *)((char *)&amp;table-&gt;elements[0] + (sizeof(struct element) * i));<br=
><br></div><div class=3D"gmail_extra">Alex<br></div><div class=3D"gmail_ext=
ra"><br><div class=3D"gmail_quote">On Thu, Aug 18, 2016 at 11:21 AM, StDeni=
s, Tom <span dir=3D"ltr">&lt;<a href=3D"mailto:Tom.StDenis-5C7GfCeVMHo@public.gmane.org" target=
=3D"_blank">Tom.StDenis-5C7GfCeVMHo@public.gmane.org</a>&gt;</span> wrote:<br><blockquote class=
=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padd=
ing-left:1ex">




<div dir=3D"ltr">
<div style=3D"font-size:12pt;color:#000000;background-color:#ffffff;font-fa=
mily:Calibri,Arial,Helvetica,sans-serif">
<p>Any modern GCC should support [0] at the tail of a struct.=C2=A0 This ca=
me up because when I was reading the code I saw they allocated 7 slots (plu=
s the size of the struct) but then fill 8 slots.=C2=A0 It&#39;s just weird
<img alt=3D"=F0=9F=98=8A" style=3D"vertical-align:bottom" src=3D"cid:b9d342=
ca-4063-4b61-a23c-e54ecb4cfb09"></p>
<p><br>
</p>
<p>Using [0] in the struct and allocating for 8 entries makes more sense an=
d is clearer to read.</p>
<p><br>
</p>
<p>Tom</p>
<br>
<br>
<div style=3D"color:rgb(0,0,0)">
<hr style=3D"display:inline-block;width:98%">
<div dir=3D"ltr"><font style=3D"font-size:11pt" color=3D"#000000" face=3D"C=
alibri, sans-serif"><b>From:</b> Christian K=C3=B6nig &lt;<a href=3D"mailto=
:deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org" target=3D"_blank">deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org</a>&gt;=
<br>
<b>Sent:</b> Thursday, August 18, 2016 11:17<br>
<b>To:</b> StDenis, Tom; amd-gfx list<br>
<b>Subject:</b> Re: tidy&#39;ing up cz_hwmgr.c</font>
<div>=C2=A0</div>
</div><div><div class=3D"h5">
<div>
<div>
<blockquote type=3D"cite">
<div>Has a [1] array at the tail which is then kzalloc&#39;ed with N-1 entr=
ies.=C2=A0 Shouldn&#39;t that just be a [0] with N entries allocated for cl=
arity?</div>
</blockquote>
Actually the starting address of a dynamic array should be manually calcula=
ted instead of using [1] or [0].<br>
<br>
We had tons of problems with that because some gcc versions get this wrong =
and the atombios code used this as well.<br>
<br>
Alex how did we resolved such issues?<br>
<br>
Regards,<br>
Christian.<br>
<br>
Am 18.08.2016 um 16:26 schrieb StDenis, Tom:<br>
</div>
<blockquote type=3D"cite">
<div style=3D"font-size:12pt;color:#000000;background-color:#ffffff;font-fa=
mily:Calibri,Arial,Helvetica,sans-serif">
<p>Tidying up cz_hwmgr.c I noted a couple of things but first is=C2=A0</p>
<p><br>
</p>
<div><span style=3D"font-family:&quot;Courier New&quot;,monospace">static b=
ool cz_dpm_check_smu_features(<wbr>struct pp_hwmgr *hwmgr,</span></div>
<div><span style=3D"white-space:pre-wrap;font-family:&quot;Courier New&quot=
;,monospace"></span><span style=3D"font-family:&quot;Courier New&quot;,mono=
space">unsigned long check_feature);</span></div>
<div><br>
</div>
<div>Which will return &quot;true&quot; if the smu call fails <b>or</b>=C2=
=A0the feature is set. =C2=A0</div>
<div><br>
</div>
<div>The structure=C2=A0</div>
<div><br>
</div>
<div>
<div><span style=3D"font-family:&quot;Courier New&quot;,monospace">struct p=
hm_clock_voltage_dependency_<wbr>table;</span></div>
</div>
<div><br>
</div>
<div>Has a [1] array at the tail which is then kzalloc&#39;ed with N-1 entr=
ies.=C2=A0 Shouldn&#39;t that just be a [0] with N entries allocated for cl=
arity?</div>
<div><br>
</div>
<div>Tom</div>
<div><br>
</div>
</div>
<br>
<fieldset></fieldset> <br>
<pre>______________________________<wbr>_________________
amd-gfx mailing list
<a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" target=3D"_blank">amd-gfx@=
lists.freedesktop.org</a>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx" target=
=3D"_blank">https://lists.freedesktop.org/<wbr>mailman/listinfo/amd-gfx</a>
</pre>
</blockquote>
<p><br>
</p>
</div>
</div></div></div>
</div>
</div>

<br>______________________________<wbr>_________________<br>
amd-gfx mailing list<br>
<a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9/rsn8yoX9R0@public.gmane.org=
org</a><br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx" rel=3D"n=
oreferrer" target=3D"_blank">https://lists.freedesktop.org/<wbr>mailman/lis=
tinfo/amd-gfx</a><br>
<br></blockquote></div><br></div></div></div></div></div></div>

--001a114db34a893ab1053a5a4e10--

--001a114db34a893ab3053a5a4e11
Content-Type: image/png; name="=?UTF-8?B?T3V0bG9va0Vtb2ppLfCfmIoucG5n?="
Content-Disposition: inline; filename="=?UTF-8?B?T3V0bG9va0Vtb2ppLfCfmIoucG5n?="
Content-Transfer-Encoding: base64
Content-ID: <b9d342ca-4063-4b61-a23c-e54ecb4cfb09>
X-Attachment-Id: 3ec5fd653305898e_0.0.1

iVBORw0KGgoAAAANSUhEUgAAABMAAAATCAYAAAByUDbMAAAAGXRFWHRTb2Z0d2FyZQBBZG9iZSBJ
bWFnZVJlYWR5ccllPAAAAYpJREFUeNpi/P//PwO1ACM2wf9njBWAVD4QBwCxApLUAyDeAMQTGU3O
PkDRA3QUIxaD+oFUAREOaQQa2IDTMKBB84FUAgk+WwA0MBFmGBOaixJIDKYEoD6465igBjkge+3C
rW94TUCTr4eGMdxl8TCZxMYHDIZR1xk2HPiA1SCQOEgepA4J5CMbFgAPhM1vwfTFW9+xGgYTh6lD
1s8IdKIAkH4PEz1w9jOYVpBiZ1CQZMMw7MHzXwwPnv0Esx2MeRESxmcYWYCUAbJiFAVYAMgCbJbA
vPmAWjmACZqS4aHdOOs5wdgEBcWE5a8Y0HIGPAIOwETtjXkYJqIqxAAgeQM1ThTzkQ2biB5mC7a8
xZ7kgeICvMzoYTsRJaMDY3U9chIBpaMHz34xxPsKgwMcFIsLgckB5KL+YllkgyYAg6oQJW9Ck8h+
5NgFhd3GAx/humAGI2cGIHYEGvYBW0YHGTgf2YX4MjkQF4IMwlkEIeXVfByGwsqzAwTLMywGg7wN
cvED9AIR3TCAAAMAqh+p+YMVeBQAAAAASUVORK5CYII=
--001a114db34a893ab3053a5a4e11--

--===============0686184706==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0686184706==--
