From: "StDenis, Tom" <Tom.StDenis-5C7GfCeVMHo@public.gmane.org>
Subject: Re: tidy'ing up cz_hwmgr.c
Date: Thu, 18 Aug 2016 16:16:48 +0000
Message-ID: <DM5PR12MB113219F25560F97BCCCF1469F7150@DM5PR12MB1132.namprd12.prod.outlook.com>
References: <DM5PR12MB1132F1D9FF8F44E09BE37EF4F7150@DM5PR12MB1132.namprd12.prod.outlook.com>
 <642600e3-dd63-7b36-a749-451a451ab153@vodafone.de>
 <DM5PR12MB11329451427722B9088E40F7F7150@DM5PR12MB1132.namprd12.prod.outlook.com>
 <CADnq5_Ntb79gEF=1Xa7BP=J4GgTzb+vY8ZbZijVTVPvaAJGrng@mail.gmail.com>
 <DM5PR12MB1132AF7ACC738F339571ECAFF7150@DM5PR12MB1132.namprd12.prod.outlook.com>
 <MWHPR12MB16947C2728D40DEC0BB41502F7150@MWHPR12MB1694.namprd12.prod.outlook.com>
 <DM5PR12MB11323E186DB7B5F065790EA9F7150@DM5PR12MB1132.namprd12.prod.outlook.com>,
 <54985952-6f8b-b882-94e2-4115ce7d5a30@vodafone.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1709375037=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <54985952-6f8b-b882-94e2-4115ce7d5a30-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
Content-Language: en-US
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
To: =?iso-8859-1?Q?Christian_K=F6nig?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>, "Deucher,
 Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Cc: amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============1709375037==
Content-Language: en-US
Content-Type: multipart/related;
	boundary="_004_DM5PR12MB113219F25560F97BCCCF1469F7150DM5PR12MB1132namp_";
	type="multipart/alternative"

--_004_DM5PR12MB113219F25560F97BCCCF1469F7150DM5PR12MB1132namp_
Content-Type: multipart/alternative;
	boundary="_000_DM5PR12MB113219F25560F97BCCCF1469F7150DM5PR12MB1132namp_"

--_000_DM5PR12MB113219F25560F97BCCCF1469F7150DM5PR12MB1132namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

No problem.  Unfortunately tail [1]'s are all over the PP code.  There acce=
ss to some entries (voltage tables for instance) using & on the [1] members=
.  I'll see if I can gather a list.


Tom




________________________________
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of Christia=
n K=F6nig <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
Sent: Thursday, August 18, 2016 12:07
To: StDenis, Tom; Deucher, Alexander
Cc: amd-gfx list
Subject: Re: tidy'ing up cz_hwmgr.c


Either way like I said I'm not strongly motivated to change it just caught =
my attention.

Well if you have time it would be really cool if you could a) identify such=
 cases before we run into issues with some gcc versions again and b) leave =
the people who added the code and/or are responsible for this part of the d=
river a note to fix it.

We really had a headache with those things because of the coding style in t=
he atom headers and I would really like to avoid that in the future.

Thanks in advance,
Christian.

Am 18.08.2016 um 17:53 schrieb StDenis, Tom:

Thanks Alex and Christian,


Yup turns out [0] is not ISO C but [] is (from the googles)


C99 6.7.2.1, =A716: As a special case, the last element of a structure with=
 more than one named member may have an incomplete array type; this is call=
ed a flexible array member.


Either way like I said I'm not strongly motivated to change it just caught =
my attention.


Cheers,

Tom


________________________________
From: Deucher, Alexander
Sent: Thursday, August 18, 2016 11:50
To: StDenis, Tom; Alex Deucher
Cc: Christian K=F6nig; amd-gfx list
Subject: RE: tidy'ing up cz_hwmgr.c


IIRC, zero sized arrays are not technically allowed in C, although gcc allo=
ws them.  As I said, some versions of gcc worked, others didn't.  I'm not s=
ure why.  Also, my example was slightly wrong.  atombios.h uses arrays of s=
ize 1, not 0.  So my example should look like:



struct table {

   uint16_t size;

   struct element elements[1];

};



atombios.h uses [1] since I don't think [0] is portable.  The same indexing=
 issue applies to [1].



Alex



From: amd-gfx [mailto:amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org] On Behalf Of S=
tDenis, Tom
Sent: Thursday, August 18, 2016 11:40 AM
To: Alex Deucher
Cc: Christian K=F6nig; amd-gfx list
Subject: Re: tidy'ing up cz_hwmgr.c



It had to be something more complicated because this demo program



#include <stdio.h>

#include <stdlib.h>



struct one {

char *foo;

int bar[0];

};



struct two {

char *foo;

int bar[1];

};



int main(void)

{

struct one *a =3D calloc(1, sizeof(struct one) + 4 * sizeof(int));

struct two *b =3D calloc(1, sizeof(struct two) + 3 * sizeof(int));

int x;



printf("a =3D=3D %p\n", a);

for (x =3D 0; x < 4; x++)

printf("&a.bar[%d] =3D %p\n", x, &a->bar[x]);



printf("b =3D=3D %p\n", b);

for (x =3D 0; x < 4; x++)

printf("&b.bar[%d] =3D %p\n", x, &b->bar[x]);



return 0;

}



produces this output



tom@fx8:~$ gcc test.c -o test

tom@fx8:~$ ./test

a =3D=3D 0x1fd4010

&a.bar[0] =3D 0x1fd4018

&a.bar[1] =3D 0x1fd401c

&a.bar[2] =3D 0x1fd4020

&a.bar[3] =3D 0x1fd4024

b =3D=3D 0x1fd4030

&b.bar[0] =3D 0x1fd4038

&b.bar[1] =3D 0x1fd403c

&b.bar[2] =3D 0x1fd4040

&b.bar[3] =3D 0x1fd4044



Which is exactly what you'd expect.  I'm not strongly advocating we change =
the PP code just noting it's not really clear that it's correct from a firs=
t reading and in theory would be better with [0].



Tom

________________________________

From: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org<mailto:alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>>
Sent: Thursday, August 18, 2016 11:33
To: StDenis, Tom
Cc: Christian K=F6nig; amd-gfx list
Subject: Re: tidy'ing up cz_hwmgr.c



The problem we ran into was when we had a struct like this:

struct table {

   uint16_t size;

   struct element elements[0];

};



and then we would try and index the array:

for (i =3D 0; i < table->size; i++) {

  element =3D &table->elements[i];

}

element ended up off in the weeds.  The only thing that seems to make some =
versions of gcc happy was pointer arithmetic.  E.g.,



element =3D (struct element *)((char *)&table->elements[0] + (sizeof(struct=
 element) * i));

Alex



On Thu, Aug 18, 2016 at 11:21 AM, StDenis, Tom <Tom.StDenis-5C7GfCeVMHo@public.gmane.org<mailto:=
Tom.StDenis-5C7GfCeVMHo@public.gmane.org>> wrote:

Any modern GCC should support [0] at the tail of a struct.  This came up be=
cause when I was reading the code I saw they allocated 7 slots (plus the si=
ze of the struct) but then fill 8 slots.  It's just weird [??]



Using [0] in the struct and allocating for 8 entries makes more sense and i=
s clearer to read.



Tom



________________________________

From: Christian K=F6nig <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org<mailto:deathsimple@vodafon=
e.de>>
Sent: Thursday, August 18, 2016 11:17
To: StDenis, Tom; amd-gfx list
Subject: Re: tidy'ing up cz_hwmgr.c



Has a [1] array at the tail which is then kzalloc'ed with N-1 entries.  Sho=
uldn't that just be a [0] with N entries allocated for clarity?

Actually the starting address of a dynamic array should be manually calcula=
ted instead of using [1] or [0].

We had tons of problems with that because some gcc versions get this wrong =
and the atombios code used this as well.

Alex how did we resolved such issues?

Regards,
Christian.

Am 18.08.2016 um 16:26 schrieb StDenis, Tom:

Tidying up cz_hwmgr.c I noted a couple of things but first is



static bool cz_dpm_check_smu_features(struct pp_hwmgr *hwmgr,

unsigned long check_feature);



Which will return "true" if the smu call fails or the feature is set.



The structure



struct phm_clock_voltage_dependency_table;



Has a [1] array at the tail which is then kzalloc'ed with N-1 entries.  Sho=
uldn't that just be a [0] with N entries allocated for clarity?



Tom





_______________________________________________

amd-gfx mailing list

amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

https://lists.freedesktop.org/mailman/listinfo/amd-gfx



_______________________________________________
amd-gfx mailing list
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
https://lists.freedesktop.org/mailman/listinfo/amd-gfx





_______________________________________________
amd-gfx mailing list
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
https://lists.freedesktop.org/mailman/listinfo/amd-gfx



--_000_DM5PR12MB113219F25560F97BCCCF1469F7150DM5PR12MB1132namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"><!-- P {margin-top:0;margi=
n-bottom:0;} --></style>
</head>
<body dir=3D"ltr">
<div id=3D"divtagdefaultwrapper" style=3D"font-size:12pt;color:#000000;back=
ground-color:#FFFFFF;font-family:Calibri,Arial,Helvetica,sans-serif;">
<p>No problem. &nbsp;Unfortunately tail [1]'s are all over the PP code. &nb=
sp;There access to some entries (voltage tables for instance) using &amp; o=
n the [1] members. &nbsp;I'll see if I can gather a list.</p>
<p><br>
</p>
<p>Tom</p>
<p></p>
<div></div>
<div><br>
</div>
<p></p>
<p><br>
</p>
<br>
<br>
<div style=3D"color: rgb(0, 0, 0);">
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" co=
lor=3D"#000000" style=3D"font-size:11pt"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt; on behalf of Christian K=F6nig &lt;deathsi=
mple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org&gt;<br>
<b>Sent:</b> Thursday, August 18, 2016 12:07<br>
<b>To:</b> StDenis, Tom; Deucher, Alexander<br>
<b>Cc:</b> amd-gfx list<br>
<b>Subject:</b> Re: tidy'ing up cz_hwmgr.c</font>
<div>&nbsp;</div>
</div>
<div>
<div class=3D"moz-cite-prefix">
<blockquote type=3D"cite">
<p><span style=3D"color:rgb(36,39,41); font-family:Arial,&quot;Helvetica Ne=
ue&quot;,Helvetica,sans-serif; font-size:15px; line-height:19.5px; backgrou=
nd-color:rgb(255,248,220)">Either&nbsp;way like I said I'm not strongly mot=
ivated to change it just caught my attention.</span></p>
</blockquote>
Well if you have time it would be really cool if you could a) identify such=
 cases before we run into issues with some gcc versions again and b) leave =
the people who added the code and/or are responsible for this part of the d=
river a note to fix it.<br>
<br>
We really had a headache with those things because of the coding style in t=
he atom headers and I would really like to avoid that in the future.<br>
<br>
Thanks in advance,<br>
Christian.<br>
<br>
Am 18.08.2016 um 17:53 schrieb StDenis, Tom:<br>
</div>
<blockquote type=3D"cite">
<div id=3D"divtagdefaultwrapper" style=3D"font-size:12pt; color:#000000; ba=
ckground-color:#FFFFFF; font-family:Calibri,Arial,Helvetica,sans-serif">
<p>Thanks Alex and Christian,</p>
<p><br>
</p>
<p>Yup turns out [0] is not ISO C but [] is (from the googles)</p>
<p><br>
</p>
<p><strong style=3D"margin:0px; padding:0px; border:0px; font-size:15px; co=
lor:rgb(36,39,41); font-family:Arial,&quot;Helvetica Neue&quot;,Helvetica,s=
ans-serif; line-height:19.5px; background-color:rgb(255,248,220)">C99 6.7.2=
.1, =A716</strong><span style=3D"color:rgb(36,39,41); font-family:Arial,&qu=
ot;Helvetica Neue&quot;,Helvetica,sans-serif; font-size:15px; line-height:1=
9.5px; background-color:rgb(255,248,220)">:
 As a special case, the last element of a structure with more than one name=
d member may have an incomplete array type; this is called a flexible array=
 member.</span><br>
</p>
<p><span style=3D"color:rgb(36,39,41); font-family:Arial,&quot;Helvetica Ne=
ue&quot;,Helvetica,sans-serif; font-size:15px; line-height:19.5px; backgrou=
nd-color:rgb(255,248,220)"><br>
</span></p>
<p><span style=3D"color:rgb(36,39,41); font-family:Arial,&quot;Helvetica Ne=
ue&quot;,Helvetica,sans-serif; font-size:15px; line-height:19.5px; backgrou=
nd-color:rgb(255,248,220)">Either&nbsp;way like I said I'm not strongly mot=
ivated to change it just caught my attention.</span></p>
<p><span style=3D"color:rgb(36,39,41); font-family:Arial,&quot;Helvetica Ne=
ue&quot;,Helvetica,sans-serif; font-size:15px; line-height:19.5px; backgrou=
nd-color:rgb(255,248,220)"><br>
</span></p>
<p><font color=3D"#242729" face=3D"Arial, Helvetica Neue, Helvetica,=0A=
            sans-serif"><span style=3D"font-size:15px; line-height:19.5px; =
background-color:rgb(255,248,220)">Cheers,</span></font></p>
<p><font color=3D"#242729" face=3D"Arial, Helvetica Neue, Helvetica,=0A=
            sans-serif"><span style=3D"font-size:15px; line-height:19.5px; =
background-color:rgb(255,248,220)">Tom</span></font></p>
<br>
<br>
<div style=3D"color:rgb(0,0,0)">
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font color=3D"#000000" face=3D"Calib=
ri, sans-serif" style=3D"font-size:11pt"><b>From:</b> Deucher, Alexander<br=
>
<b>Sent:</b> Thursday, August 18, 2016 11:50<br>
<b>To:</b> StDenis, Tom; Alex Deucher<br>
<b>Cc:</b> Christian K=F6nig; amd-gfx list<br>
<b>Subject:</b> RE: tidy'ing up cz_hwmgr.c</font>
<div>&nbsp;</div>
</div>
<div>
<div>
<p style=3D"margin:0in 0in 0.0001pt; font-size:12pt; font-family:&quot;Time=
s New Roman&quot;,serif">
<span style=3D"font-size:11.0pt; font-family:&quot;Calibri&quot;,&quot;sans=
-serif&quot;; color:#1F497D">IIRC, zero sized arrays are not technically al=
lowed in C, although gcc allows them.&nbsp; As I said, some versions of gcc=
 worked, others didn't.&nbsp; I'm not sure why.&nbsp; Also, my example
 was slightly wrong.&nbsp; atombios.h uses arrays of size 1, not 0.&nbsp; S=
o my example should look like:</span></p>
<p style=3D"margin:0in 0in 0.0001pt; font-size:12pt; font-family:&quot;Time=
s New Roman&quot;,serif">
<span style=3D"font-size:11.0pt; font-family:&quot;Calibri&quot;,&quot;sans=
-serif&quot;; color:#1F497D">&nbsp;</span></p>
<p style=3D"margin:0in 0in 0.0001pt; font-size:12pt; font-family:&quot;Time=
s New Roman&quot;,serif; background:white">
<span style=3D"font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;; colo=
r:black">struct table {</span></p>
<p style=3D"margin:0in 0in 0.0001pt; font-size:12pt; font-family:&quot;Time=
s New Roman&quot;,serif; background:white">
<span style=3D"font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;; colo=
r:black">&nbsp;&nbsp; uint16_t size;</span></p>
<p style=3D"margin:0in 0in 0.0001pt; font-size:12pt; font-family:&quot;Time=
s New Roman&quot;,serif; background:white">
<span style=3D"font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;; colo=
r:black">&nbsp;&nbsp; struct element elements[1];</span></p>
<p style=3D"margin:0in 0in 0.0001pt; font-size:12pt; font-family:&quot;Time=
s New Roman&quot;,serif; background:white">
<span style=3D"font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;; colo=
r:black">};</span></p>
<p style=3D"margin:0in 0in 0.0001pt; font-size:12pt; font-family:&quot;Time=
s New Roman&quot;,serif">
<span style=3D"font-size:11.0pt; font-family:&quot;Calibri&quot;,&quot;sans=
-serif&quot;; color:#1F497D">&nbsp;</span></p>
<p style=3D"margin:0in 0in 0.0001pt; font-size:12pt; font-family:&quot;Time=
s New Roman&quot;,serif">
<span style=3D"font-size:11.0pt; font-family:&quot;Calibri&quot;,&quot;sans=
-serif&quot;; color:#1F497D">atombios.h uses [1] since I don't think [0] is=
 portable.&nbsp; The same indexing issue applies to [1].</span></p>
<p style=3D"margin:0in 0in 0.0001pt; font-size:12pt; font-family:&quot;Time=
s New Roman&quot;,serif">
<span style=3D"font-size:11.0pt; font-family:&quot;Calibri&quot;,&quot;sans=
-serif&quot;; color:#1F497D">&nbsp;</span></p>
<p style=3D"margin:0in 0in 0.0001pt; font-size:12pt; font-family:&quot;Time=
s New Roman&quot;,serif">
<span style=3D"font-size:11.0pt; font-family:&quot;Calibri&quot;,&quot;sans=
-serif&quot;; color:#1F497D">Alex</span></p>
<p style=3D"margin:0in 0in 0.0001pt; font-size:12pt; font-family:&quot;Time=
s New Roman&quot;,serif">
<span style=3D"font-size:11.0pt; font-family:&quot;Calibri&quot;,&quot;sans=
-serif&quot;; color:#1F497D">&nbsp;</span></p>
<div style=3D"border:none; border-left:solid blue 1.5pt; padding:0in 0in 0i=
n 4.0pt">
<div>
<div style=3D"border:none; border-top:solid #B5C4DF=0A=
                    1.0pt; padding:3.0pt 0in 0in 0in">
<p style=3D"margin:0in 0in 0.0001pt; font-size:12pt; font-family:&quot;Time=
s New Roman&quot;,serif">
<b><span style=3D"font-size:10.0pt; font-family:&quot;Tahoma&quot;,&quot;sa=
ns-serif&quot;">From:</span></b><span style=3D"font-size:10.0pt; font-famil=
y:&quot;Tahoma&quot;,&quot;sans-serif&quot;"> amd-gfx [<a class=3D"moz-txt-=
link-freetext" href=3D"mailto:amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">mailto=
:amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a>]
<b>On Behalf Of </b>StDenis, Tom<br>
<b>Sent:</b> Thursday, August 18, 2016 11:40 AM<br>
<b>To:</b> Alex Deucher<br>
<b>Cc:</b> Christian K=F6nig; amd-gfx list<br>
<b>Subject:</b> Re: tidy'ing up cz_hwmgr.c</span></p>
</div>
</div>
<p style=3D"margin:0in 0in 0.0001pt; font-size:12pt; font-family:&quot;Time=
s New Roman&quot;,serif">
&nbsp;</p>
<div id=3D"divtagdefaultwrapper">
<p style=3D"background:white"><span style=3D"font-family:&quot;Calibri&quot=
;,&quot;sans-serif&quot;; color:black">It had to be something more complica=
ted because this demo program</span></p>
<p style=3D"background:white"><span style=3D"font-family:&quot;Calibri&quot=
;,&quot;sans-serif&quot;; color:black">&nbsp;</span></p>
<div>
<p style=3D"margin:0in 0in 0.0001pt; font-size:12pt; font-family:&quot;Time=
s New Roman&quot;,serif; background:white">
<span style=3D"font-family:&quot;Courier New&quot;; color:black">#include &=
lt;stdio.h&gt;</span><span style=3D"font-family:&quot;Calibri&quot;,&quot;s=
ans-serif&quot;; color:black"></span></p>
</div>
<div>
<p style=3D"margin:0in 0in 0.0001pt; font-size:12pt; font-family:&quot;Time=
s New Roman&quot;,serif; background:white">
<span style=3D"font-family:&quot;Courier New&quot;; color:black">#include &=
lt;stdlib.h&gt;</span><span style=3D"font-family:&quot;Calibri&quot;,&quot;=
sans-serif&quot;; color:black"></span></p>
</div>
<div>
<p style=3D"margin:0in 0in 0.0001pt; font-size:12pt; font-family:&quot;Time=
s New Roman&quot;,serif; background:white">
<span style=3D"font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;; colo=
r:black">&nbsp;</span></p>
</div>
<div>
<p style=3D"margin:0in 0in 0.0001pt; font-size:12pt; font-family:&quot;Time=
s New Roman&quot;,serif; background:white">
<span style=3D"font-family:&quot;Courier New&quot;; color:black">struct one=
 {</span><span style=3D"font-family:&quot;Calibri&quot;,&quot;sans-serif&qu=
ot;; color:black"></span></p>
</div>
<div>
<p style=3D"margin:0in 0in 0.0001pt; font-size:12pt; font-family:&quot;Time=
s New Roman&quot;,serif; background:white">
<span style=3D"font-family:&quot;Courier New&quot;; color:black">char *foo;=
</span><span style=3D"font-family:&quot;Calibri&quot;,&quot;sans-serif&quot=
;; color:black"></span></p>
</div>
<div>
<p style=3D"margin:0in 0in 0.0001pt; font-size:12pt; font-family:&quot;Time=
s New Roman&quot;,serif; background:white">
<span style=3D"font-family:&quot;Courier New&quot;; color:black">int bar[0]=
;</span><span style=3D"font-family:&quot;Calibri&quot;,&quot;sans-serif&quo=
t;; color:black"></span></p>
</div>
<div>
<p style=3D"margin:0in 0in 0.0001pt; font-size:12pt; font-family:&quot;Time=
s New Roman&quot;,serif; background:white">
<span style=3D"font-family:&quot;Courier New&quot;; color:black">};</span><=
span style=3D"font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;; color=
:black"></span></p>
</div>
<div>
<p style=3D"margin:0in 0in 0.0001pt; font-size:12pt; font-family:&quot;Time=
s New Roman&quot;,serif; background:white">
<span style=3D"font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;; colo=
r:black">&nbsp;</span></p>
</div>
<div>
<p style=3D"margin:0in 0in 0.0001pt; font-size:12pt; font-family:&quot;Time=
s New Roman&quot;,serif; background:white">
<span style=3D"font-family:&quot;Courier New&quot;; color:black">struct two=
 {</span><span style=3D"font-family:&quot;Calibri&quot;,&quot;sans-serif&qu=
ot;; color:black"></span></p>
</div>
<div>
<p style=3D"margin:0in 0in 0.0001pt; font-size:12pt; font-family:&quot;Time=
s New Roman&quot;,serif; background:white">
<span style=3D"font-family:&quot;Courier New&quot;; color:black">char *foo;=
</span><span style=3D"font-family:&quot;Calibri&quot;,&quot;sans-serif&quot=
;; color:black"></span></p>
</div>
<div>
<p style=3D"margin:0in 0in 0.0001pt; font-size:12pt; font-family:&quot;Time=
s New Roman&quot;,serif; background:white">
<span style=3D"font-family:&quot;Courier New&quot;; color:black">int bar[1]=
;</span><span style=3D"font-family:&quot;Calibri&quot;,&quot;sans-serif&quo=
t;; color:black"></span></p>
</div>
<div>
<p style=3D"margin:0in 0in 0.0001pt; font-size:12pt; font-family:&quot;Time=
s New Roman&quot;,serif; background:white">
<span style=3D"font-family:&quot;Courier New&quot;; color:black">};</span><=
span style=3D"font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;; color=
:black"></span></p>
</div>
<div>
<p style=3D"margin:0in 0in 0.0001pt; font-size:12pt; font-family:&quot;Time=
s New Roman&quot;,serif; background:white">
<span style=3D"font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;; colo=
r:black">&nbsp;</span></p>
</div>
<div>
<p style=3D"margin:0in 0in 0.0001pt; font-size:12pt; font-family:&quot;Time=
s New Roman&quot;,serif; background:white">
<span style=3D"font-family:&quot;Courier New&quot;; color:black">int main(v=
oid)</span><span style=3D"font-family:&quot;Calibri&quot;,&quot;sans-serif&=
quot;; color:black"></span></p>
</div>
<div>
<p style=3D"margin:0in 0in 0.0001pt; font-size:12pt; font-family:&quot;Time=
s New Roman&quot;,serif; background:white">
<span style=3D"font-family:&quot;Courier New&quot;; color:black">{</span><s=
pan style=3D"font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;; color:=
black"></span></p>
</div>
<div>
<p style=3D"margin:0in 0in 0.0001pt; font-size:12pt; font-family:&quot;Time=
s New Roman&quot;,serif; background:white">
<span style=3D"font-family:&quot;Courier New&quot;; color:black">struct one=
 *a =3D calloc(1, sizeof(struct one) &#43; 4 * sizeof(int));</span><span st=
yle=3D"font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;; color:black"=
></span></p>
</div>
<div>
<p style=3D"margin:0in 0in 0.0001pt; font-size:12pt; font-family:&quot;Time=
s New Roman&quot;,serif; background:white">
<span style=3D"font-family:&quot;Courier New&quot;; color:black">struct two=
 *b =3D calloc(1, sizeof(struct two) &#43; 3 * sizeof(int));</span><span st=
yle=3D"font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;; color:black"=
></span></p>
</div>
<div>
<p style=3D"margin:0in 0in 0.0001pt; font-size:12pt; font-family:&quot;Time=
s New Roman&quot;,serif; background:white">
<span style=3D"font-family:&quot;Courier New&quot;; color:black">int x;</sp=
an><span style=3D"font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;; c=
olor:black"></span></p>
</div>
<div>
<p style=3D"margin:0in 0in 0.0001pt; font-size:12pt; font-family:&quot;Time=
s New Roman&quot;,serif; background:white">
<span style=3D"font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;; colo=
r:black">&nbsp;</span></p>
</div>
<div>
<p style=3D"margin:0in 0in 0.0001pt; font-size:12pt; font-family:&quot;Time=
s New Roman&quot;,serif; background:white">
<span style=3D"font-family:&quot;Courier New&quot;; color:black">printf(&qu=
ot;a =3D=3D %p\n&quot;, a);</span><span style=3D"font-family:&quot;Calibri&=
quot;,&quot;sans-serif&quot;; color:black"></span></p>
</div>
<div>
<p style=3D"margin:0in 0in 0.0001pt; font-size:12pt; font-family:&quot;Time=
s New Roman&quot;,serif; background:white">
<span style=3D"font-family:&quot;Courier New&quot;; color:black">for (x =3D=
 0; x &lt; 4; x&#43;&#43;)</span><span style=3D"font-family:&quot;Calibri&q=
uot;,&quot;sans-serif&quot;; color:black"></span></p>
</div>
<div>
<p style=3D"margin:0in 0in 0.0001pt; font-size:12pt; font-family:&quot;Time=
s New Roman&quot;,serif; background:white">
<span style=3D"font-family:&quot;Courier New&quot;; color:black">printf(&qu=
ot;&amp;a.bar[%d] =3D %p\n&quot;, x, &amp;a-&gt;bar[x]);</span><span style=
=3D"font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;; color:black"></=
span></p>
</div>
<div>
<p style=3D"margin:0in 0in 0.0001pt; font-size:12pt; font-family:&quot;Time=
s New Roman&quot;,serif; background:white">
<span style=3D"font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;; colo=
r:black">&nbsp;</span></p>
</div>
<div>
<p style=3D"margin:0in 0in 0.0001pt; font-size:12pt; font-family:&quot;Time=
s New Roman&quot;,serif; background:white">
<span style=3D"font-family:&quot;Courier New&quot;; color:black">printf(&qu=
ot;b =3D=3D %p\n&quot;, b);</span><span style=3D"font-family:&quot;Calibri&=
quot;,&quot;sans-serif&quot;; color:black"></span></p>
</div>
<div>
<p style=3D"margin:0in 0in 0.0001pt; font-size:12pt; font-family:&quot;Time=
s New Roman&quot;,serif; background:white">
<span style=3D"font-family:&quot;Courier New&quot;; color:black">for (x =3D=
 0; x &lt; 4; x&#43;&#43;)</span><span style=3D"font-family:&quot;Calibri&q=
uot;,&quot;sans-serif&quot;; color:black"></span></p>
</div>
<div>
<p style=3D"margin:0in 0in 0.0001pt; font-size:12pt; font-family:&quot;Time=
s New Roman&quot;,serif; background:white">
<span style=3D"font-family:&quot;Courier New&quot;; color:black">printf(&qu=
ot;&amp;b.bar[%d] =3D %p\n&quot;, x, &amp;b-&gt;bar[x]);</span><span style=
=3D"font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;; color:black"></=
span></p>
</div>
<div>
<p style=3D"margin:0in 0in 0.0001pt; font-size:12pt; font-family:&quot;Time=
s New Roman&quot;,serif; background:white">
<span style=3D"font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;; colo=
r:black">&nbsp;</span></p>
</div>
<div>
<p style=3D"margin:0in 0in 0.0001pt; font-size:12pt; font-family:&quot;Time=
s New Roman&quot;,serif; background:white">
<span style=3D"font-family:&quot;Courier New&quot;; color:black">return 0;<=
/span><span style=3D"font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;=
; color:black"></span></p>
</div>
<div>
<p style=3D"margin:0in 0in 0.0001pt; font-size:12pt; font-family:&quot;Time=
s New Roman&quot;,serif; background:white">
<span style=3D"font-family:&quot;Courier New&quot;; color:black">}</span><s=
pan style=3D"font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;; color:=
black"></span></p>
</div>
<div>
<p style=3D"margin:0in 0in 0.0001pt; font-size:12pt; font-family:&quot;Time=
s New Roman&quot;,serif; background:white">
<span style=3D"font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;; colo=
r:black">&nbsp;</span></p>
</div>
<p style=3D"background:white"><span style=3D"font-family:&quot;Calibri&quot=
;,&quot;sans-serif&quot;; color:black">produces this output</span></p>
<p style=3D"background:white"><span style=3D"font-family:&quot;Calibri&quot=
;,&quot;sans-serif&quot;; color:black">&nbsp;</span></p>
<div>
<p style=3D"margin:0in 0in 0.0001pt; font-size:12pt; font-family:&quot;Time=
s New Roman&quot;,serif; background:white">
<span style=3D"font-family:&quot;Courier New&quot;; color:black">tom@fx8:~$=
 gcc test.c -o test</span><span style=3D"font-family:&quot;Calibri&quot;,&q=
uot;sans-serif&quot;; color:black"></span></p>
</div>
<div>
<p style=3D"margin:0in 0in 0.0001pt; font-size:12pt; font-family:&quot;Time=
s New Roman&quot;,serif; background:white">
<span style=3D"font-family:&quot;Courier New&quot;; color:black">tom@fx8:~$=
 ./test</span><span style=3D"font-family:&quot;Calibri&quot;,&quot;sans-ser=
if&quot;; color:black"></span></p>
</div>
<div>
<p style=3D"margin:0in 0in 0.0001pt; font-size:12pt; font-family:&quot;Time=
s New Roman&quot;,serif; background:white">
<span style=3D"font-family:&quot;Courier New&quot;; color:black">a =3D=3D 0=
x1fd4010</span><span style=3D"font-family:&quot;Calibri&quot;,&quot;sans-se=
rif&quot;; color:black"></span></p>
</div>
<div>
<p style=3D"margin:0in 0in 0.0001pt; font-size:12pt; font-family:&quot;Time=
s New Roman&quot;,serif; background:white">
<span style=3D"font-family:&quot;Courier New&quot;; color:black">&amp;a.bar=
[0] =3D 0x1fd4018</span><span style=3D"font-family:&quot;Calibri&quot;,&quo=
t;sans-serif&quot;; color:black"></span></p>
</div>
<div>
<p style=3D"margin:0in 0in 0.0001pt; font-size:12pt; font-family:&quot;Time=
s New Roman&quot;,serif; background:white">
<span style=3D"font-family:&quot;Courier New&quot;; color:black">&amp;a.bar=
[1] =3D 0x1fd401c</span><span style=3D"font-family:&quot;Calibri&quot;,&quo=
t;sans-serif&quot;; color:black"></span></p>
</div>
<div>
<p style=3D"margin:0in 0in 0.0001pt; font-size:12pt; font-family:&quot;Time=
s New Roman&quot;,serif; background:white">
<span style=3D"font-family:&quot;Courier New&quot;; color:black">&amp;a.bar=
[2] =3D 0x1fd4020</span><span style=3D"font-family:&quot;Calibri&quot;,&quo=
t;sans-serif&quot;; color:black"></span></p>
</div>
<div>
<p style=3D"margin:0in 0in 0.0001pt; font-size:12pt; font-family:&quot;Time=
s New Roman&quot;,serif; background:white">
<span style=3D"font-family:&quot;Courier New&quot;; color:black">&amp;a.bar=
[3] =3D 0x1fd4024</span><span style=3D"font-family:&quot;Calibri&quot;,&quo=
t;sans-serif&quot;; color:black"></span></p>
</div>
<div>
<p style=3D"margin:0in 0in 0.0001pt; font-size:12pt; font-family:&quot;Time=
s New Roman&quot;,serif; background:white">
<span style=3D"font-family:&quot;Courier New&quot;; color:black">b =3D=3D 0=
x1fd4030</span><span style=3D"font-family:&quot;Calibri&quot;,&quot;sans-se=
rif&quot;; color:black"></span></p>
</div>
<div>
<p style=3D"margin:0in 0in 0.0001pt; font-size:12pt; font-family:&quot;Time=
s New Roman&quot;,serif; background:white">
<span style=3D"font-family:&quot;Courier New&quot;; color:black">&amp;b.bar=
[0] =3D 0x1fd4038</span><span style=3D"font-family:&quot;Calibri&quot;,&quo=
t;sans-serif&quot;; color:black"></span></p>
</div>
<div>
<p style=3D"margin:0in 0in 0.0001pt; font-size:12pt; font-family:&quot;Time=
s New Roman&quot;,serif; background:white">
<span style=3D"font-family:&quot;Courier New&quot;; color:black">&amp;b.bar=
[1] =3D 0x1fd403c</span><span style=3D"font-family:&quot;Calibri&quot;,&quo=
t;sans-serif&quot;; color:black"></span></p>
</div>
<div>
<p style=3D"margin:0in 0in 0.0001pt; font-size:12pt; font-family:&quot;Time=
s New Roman&quot;,serif; background:white">
<span style=3D"font-family:&quot;Courier New&quot;; color:black">&amp;b.bar=
[2] =3D 0x1fd4040</span><span style=3D"font-family:&quot;Calibri&quot;,&quo=
t;sans-serif&quot;; color:black"></span></p>
</div>
<div>
<p style=3D"margin:0in 0in 0.0001pt; font-size:12pt; font-family:&quot;Time=
s New Roman&quot;,serif; background:white">
<span style=3D"font-family:&quot;Courier New&quot;; color:black">&amp;b.bar=
[3] =3D 0x1fd4044</span><span style=3D"font-family:&quot;Calibri&quot;,&quo=
t;sans-serif&quot;; color:black"></span></p>
</div>
<div>
<p style=3D"margin:0in 0in 0.0001pt; font-size:12pt; font-family:&quot;Time=
s New Roman&quot;,serif; background:white">
<span style=3D"font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;; colo=
r:black">&nbsp;</span></p>
</div>
<p style=3D"margin:0in 0in 0.0001pt; font-size:12pt; font-family:&quot;Time=
s New Roman&quot;,serif; background:white">
<span style=3D"font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;; colo=
r:black">Which is exactly what you'd expect. &nbsp;I'm not strongly advocat=
ing we change the PP code just noting it's not really clear that it's corre=
ct from a first reading and in theory would be better with
 [0]. </span></p>
<div>
<p style=3D"margin:0in 0in 0.0001pt; font-size:12pt; font-family:&quot;Time=
s New Roman&quot;,serif; background:white">
<span style=3D"font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;; colo=
r:black">&nbsp;</span></p>
</div>
<p style=3D"margin:0in 0in 0.0001pt; font-size:12pt; font-family:&quot;Time=
s New Roman&quot;,serif; background:white">
<span style=3D"font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;; colo=
r:black">Tom</span></p>
<div>
<div align=3D"center" style=3D"text-align:center; margin:0in 0in=0A=
                      0.0001pt; font-size:12pt; font-family:&quot;Times New=
 Roman&quot;,serif; background:white">
<span style=3D"font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;; colo=
r:black">
<hr width=3D"98%" align=3D"center" size=3D"2">
</span></div>
<div id=3D"divRplyFwdMsg">
<p style=3D"margin:0in 0in 0.0001pt; font-size:12pt; font-family:&quot;Time=
s New Roman&quot;,serif; background:white">
<b><span style=3D"font-size:11.0pt; font-family:&quot;Calibri&quot;,&quot;s=
ans-serif&quot;; color:black">From:</span></b><span style=3D"font-size:11.0=
pt; font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;; color:black"> A=
lex Deucher &lt;<a href=3D"mailto:alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" style=3D"color:blu=
e; text-decoration:underline">alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt;<br>
<b>Sent:</b> Thursday, August 18, 2016 11:33<br>
<b>To:</b> StDenis, Tom<br>
<b>Cc:</b> Christian K=F6nig; amd-gfx list<br>
<b>Subject:</b> Re: tidy'ing up cz_hwmgr.c</span><span style=3D"font-family=
:&quot;Calibri&quot;,&quot;sans-serif&quot;; color:black">
</span></p>
<div>
<p style=3D""><span style=3D"font-family:&quot;Calibri&quot;,&quot;sans-ser=
if&quot;; color:black">&nbsp;</span></p>
</div>
</div>
<div>
<div>
<div>
<div>
<div>
<p style=3D"margin:0in 0in 0.0001pt; font-size:12pt; font-family:&quot;Time=
s New Roman&quot;,serif; background:white">
<span style=3D"font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;; colo=
r:black">The problem we ran into was when we had a struct like this:</span>=
</p>
</div>
<p style=3D""><span style=3D"font-family:&quot;Calibri&quot;,&quot;sans-ser=
if&quot;; color:black">struct table {</span></p>
</div>
<p style=3D""><span style=3D"font-family:&quot;Calibri&quot;,&quot;sans-ser=
if&quot;; color:black">&nbsp;&nbsp; uint16_t size;</span></p>
</div>
<p style=3D""><span style=3D"font-family:&quot;Calibri&quot;,&quot;sans-ser=
if&quot;; color:black">&nbsp;&nbsp; struct element elements[0];</span></p>
<div>
<div>
<p style=3D""><span style=3D"font-family:&quot;Calibri&quot;,&quot;sans-ser=
if&quot;; color:black">};</span></p>
<div>
<div>
<div>
<p style=3D"margin:0in 0in 0.0001pt; font-size:12pt; font-family:&quot;Time=
s New Roman&quot;,serif; background:white">
<span style=3D"font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;; colo=
r:black">&nbsp;</span></p>
</div>
<div>
<p style=3D"margin:0in 0in 0.0001pt; font-size:12pt; font-family:&quot;Time=
s New Roman&quot;,serif; background:white">
<span style=3D"font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;; colo=
r:black">and then we would try and index the array:</span></p>
</div>
<div>
<p style=3D"margin:0in 0in 0.0001pt; font-size:12pt; font-family:&quot;Time=
s New Roman&quot;,serif; background:white">
<span style=3D"font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;; colo=
r:black">for (i =3D 0; i &lt; table-&gt;size; i&#43;&#43;) {</span></p>
</div>
<div>
<p style=3D"margin:0in 0in 0.0001pt; font-size:12pt; font-family:&quot;Time=
s New Roman&quot;,serif; background:white">
<span style=3D"font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;; colo=
r:black">&nbsp; element =3D &amp;table-&gt;elements[i];</span></p>
</div>
<div>
<p style=3D"margin:0in 0in 0.0001pt; font-size:12pt; font-family:&quot;Time=
s New Roman&quot;,serif; background:white">
<span style=3D"font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;; colo=
r:black">}</span></p>
</div>
<div>
<p style=3D"margin:0in 0in 0.0001pt; font-size:12pt; font-family:&quot;Time=
s New Roman&quot;,serif; background:white">
<span style=3D"font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;; colo=
r:black">element ended up off in the weeds.&nbsp; The only thing that seems=
 to make some versions of gcc happy was pointer arithmetic.&nbsp; E.g.,</sp=
an></p>
</div>
<div>
<p style=3D"margin:0in 0in 0.0001pt; font-size:12pt; font-family:&quot;Time=
s New Roman&quot;,serif; background:white">
<span style=3D"font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;; colo=
r:black">&nbsp;</span></p>
</div>
<div>
<p style=3D"margin:0in 0in 0.0001pt; font-size:12pt; font-family:&quot;Time=
s New Roman&quot;,serif; background:white">
<span style=3D"font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;; colo=
r:black">element =3D (struct element *)((char *)&amp;table-&gt;elements[0] =
&#43; (sizeof(struct element) * i));</span></p>
</div>
<div>
<p style=3D"margin:0in 0in 0.0001pt; font-size:12pt; font-family:&quot;Time=
s New Roman&quot;,serif; background:white">
<span style=3D"font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;; colo=
r:black">Alex</span></p>
</div>
<div>
<p style=3D"margin:0in 0in 0.0001pt; font-size:12pt; font-family:&quot;Time=
s New Roman&quot;,serif; background:white">
<span style=3D"font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;; colo=
r:black">&nbsp;</span></p>
<div>
<p style=3D"margin:0in 0in 0.0001pt; font-size:12pt; font-family:&quot;Time=
s New Roman&quot;,serif; background:white">
<span style=3D"font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;; colo=
r:black">On Thu, Aug 18, 2016 at 11:21 AM, StDenis, Tom &lt;<a href=3D"mail=
to:Tom.StDenis-5C7GfCeVMHo@public.gmane.org" target=3D"_blank" style=3D"color:blue; text-decorat=
ion:underline">Tom.StDenis-5C7GfCeVMHo@public.gmane.org</a>&gt; wrote:</span></p>
<div>
<div>
<p style=3D"background:white"><span style=3D"font-family:&quot;Calibri&quot=
;,&quot;sans-serif&quot;; color:black">Any modern GCC should support [0] at=
 the tail of a struct.&nbsp; This came up because when I was reading the co=
de I saw they allocated 7 slots (plus the size of the struct)
 but then fill 8 slots.&nbsp; It's just weird <img id=3D"_x0000_i1026" alt=
=3D"&#65533;&#65533;" tabindex=3D"0" width=3D"19" border=3D"0" height=3D"19=
" style=3D"-webkit-user-select: none;" src=3D"cid:part3.F176A269.01DFF465@v=
odafone.de"></span></p>
<p style=3D"background:white"><span style=3D"font-family:&quot;Calibri&quot=
;,&quot;sans-serif&quot;; color:black">&nbsp;</span></p>
<p style=3D"background:white"><span style=3D"font-family:&quot;Calibri&quot=
;,&quot;sans-serif&quot;; color:black">Using [0] in the struct and allocati=
ng for 8 entries makes more sense and is clearer to read.</span></p>
<p style=3D"background:white"><span style=3D"font-family:&quot;Calibri&quot=
;,&quot;sans-serif&quot;; color:black">&nbsp;</span></p>
<p style=3D"background:white"><span style=3D"font-family:&quot;Calibri&quot=
;,&quot;sans-serif&quot;; color:black">Tom</span></p>
<p style=3D""><span style=3D"font-family:&quot;Calibri&quot;,&quot;sans-ser=
if&quot;; color:black">&nbsp;</span></p>
<div>
<div align=3D"center" style=3D""><span style=3D"font-family:&quot;Calibri&q=
uot;,&quot;sans-serif&quot;; color:black">
<hr width=3D"98%" align=3D"center" size=3D"2">
</span></div>
<div>
<p style=3D""><b><span style=3D"font-size:11.0pt; font-family:&quot;Calibri=
&quot;,&quot;sans-serif&quot;; color:black">From:</span></b><span style=3D"=
font-size:11.0pt; font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;; c=
olor:black"> Christian K=F6nig &lt;<a href=3D"mailto:deathsimple@vodafone.d=
e" target=3D"_blank" style=3D"color:blue; text-decoration:underline">deaths=
imple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org</a>&gt;<br>
<b>Sent:</b> Thursday, August 18, 2016 11:17<br>
<b>To:</b> StDenis, Tom; amd-gfx list<br>
<b>Subject:</b> Re: tidy'ing up cz_hwmgr.c</span><span style=3D"font-family=
:&quot;Calibri&quot;,&quot;sans-serif&quot;; color:black">
</span></p>
<div>
<p style=3D""><span style=3D"font-family:&quot;Calibri&quot;,&quot;sans-ser=
if&quot;; color:black">&nbsp;</span></p>
</div>
</div>
<div>
<div>
<div>
<div>
<blockquote style=3D"margin-top:5.0pt; margin-bottom:5.0pt">
<div>
<p style=3D""><span style=3D"font-family:&quot;Calibri&quot;,&quot;sans-ser=
if&quot;; color:black">Has a [1] array at the tail which is then kzalloc'ed=
 with N-1 entries.&nbsp; Shouldn't that just be a [0] with N entries alloca=
ted for clarity?</span></p>
</div>
</blockquote>
<p style=3D""><span style=3D"font-family:&quot;Calibri&quot;,&quot;sans-ser=
if&quot;; color:black">Actually the starting address of a dynamic array sho=
uld be manually calculated instead of using [1] or [0].<br>
<br>
We had tons of problems with that because some gcc versions get this wrong =
and the atombios code used this as well.<br>
<br>
Alex how did we resolved such issues?<br>
<br>
Regards,<br>
Christian.<br>
<br>
Am 18.08.2016 um 16:26 schrieb StDenis, Tom:</span></p>
</div>
<blockquote style=3D"margin-top:5.0pt; margin-bottom:5.0pt">
<div>
<p style=3D"background:white"><span style=3D"font-family:&quot;Calibri&quot=
;,&quot;sans-serif&quot;; color:black">Tidying up cz_hwmgr.c I noted a coup=
le of things but first is&nbsp;</span></p>
<p style=3D"background:white"><span style=3D"font-family:&quot;Calibri&quot=
;,&quot;sans-serif&quot;; color:black">&nbsp;</span></p>
<div>
<p style=3D""><span style=3D"">static bool cz_dpm_check_smu_features(struct=
 pp_hwmgr *hwmgr,</span><span style=3D"font-family:&quot;Calibri&quot;,&quo=
t;sans-serif&quot;; color:black"></span></p>
</div>
<div>
<p style=3D""><span style=3D"">unsigned long check_feature);</span><span st=
yle=3D"font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;; color:black"=
></span></p>
</div>
<div>
<p style=3D""><span style=3D"font-family:&quot;Calibri&quot;,&quot;sans-ser=
if&quot;; color:black">&nbsp;</span></p>
</div>
<div>
<p style=3D""><span style=3D"font-family:&quot;Calibri&quot;,&quot;sans-ser=
if&quot;; color:black">Which will return &quot;true&quot; if the smu call f=
ails
<b>or</b>&nbsp;the feature is set. &nbsp;</span></p>
</div>
<div>
<p style=3D""><span style=3D"font-family:&quot;Calibri&quot;,&quot;sans-ser=
if&quot;; color:black">&nbsp;</span></p>
</div>
<div>
<p style=3D""><span style=3D"font-family:&quot;Calibri&quot;,&quot;sans-ser=
if&quot;; color:black">The structure&nbsp;</span></p>
</div>
<div>
<p style=3D""><span style=3D"font-family:&quot;Calibri&quot;,&quot;sans-ser=
if&quot;; color:black">&nbsp;</span></p>
</div>
<div>
<div>
<p style=3D""><span style=3D"">struct phm_clock_voltage_dependency_table;</=
span><span style=3D"font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;=
 color:black"></span></p>
</div>
</div>
<div>
<p style=3D""><span style=3D"font-family:&quot;Calibri&quot;,&quot;sans-ser=
if&quot;; color:black">&nbsp;</span></p>
</div>
<div>
<p style=3D""><span style=3D"font-family:&quot;Calibri&quot;,&quot;sans-ser=
if&quot;; color:black">Has a [1] array at the tail which is then kzalloc'ed=
 with N-1 entries.&nbsp; Shouldn't that just be a [0] with N entries alloca=
ted for clarity?</span></p>
</div>
<div>
<p style=3D""><span style=3D"font-family:&quot;Calibri&quot;,&quot;sans-ser=
if&quot;; color:black">&nbsp;</span></p>
</div>
<div>
<p style=3D""><span style=3D"font-family:&quot;Calibri&quot;,&quot;sans-ser=
if&quot;; color:black">Tom</span></p>
</div>
<div>
<p style=3D""><span style=3D"font-family:&quot;Calibri&quot;,&quot;sans-ser=
if&quot;; color:black">&nbsp;</span></p>
</div>
</div>
<p style=3D""><span style=3D"font-family:&quot;Calibri&quot;,&quot;sans-ser=
if&quot;; color:black"><br>
<br>
</span></p>
<pre style=3D"margin:0in 0in 0.0001pt; font-size:10pt; font-family:&quot;Co=
urier New&quot;; background:white"><span style=3D"color:black">____________=
___________________________________</span></pre>
<pre style=3D"margin:0in 0in 0.0001pt; font-size:10pt; font-family:&quot;Co=
urier New&quot;; background:white"><span style=3D"color:black">amd-gfx mail=
ing list</span></pre>
<pre style=3D"margin:0in 0in 0.0001pt; font-size:10pt; font-family:&quot;Co=
urier New&quot;; background:white"><span style=3D"color:black"><a href=3D"m=
ailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" target=3D"_blank" style=3D"color:blue;=
 text-decoration:underline">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a></span></pre>
<pre style=3D"margin:0in 0in 0.0001pt; font-size:10pt; font-family:&quot;Co=
urier New&quot;; background:white"><span style=3D"color:black"><a href=3D"h=
ttps://lists.freedesktop.org/mailman/listinfo/amd-gfx" target=3D"_blank" st=
yle=3D"color:blue; text-decoration:underline">https://lists.freedesktop.org=
/mailman/listinfo/amd-gfx</a></span></pre>
</blockquote>
<p style=3D"background:white"><span style=3D"font-family:&quot;Calibri&quot=
;,&quot;sans-serif&quot;; color:black">&nbsp;</span></p>
</div>
</div>
</div>
</div>
</div>
</div>
<p style=3D"margin:0in 0in 0.0001pt; font-size:12pt; font-family:&quot;Time=
s New Roman&quot;,serif; background:white">
<span style=3D"font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;; colo=
r:black"><br>
_______________________________________________<br>
amd-gfx mailing list<br>
<a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" style=3D"color:blue; text-=
decoration:underline">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx" target=
=3D"_blank" style=3D"color:blue; text-decoration:underline">https://lists.f=
reedesktop.org/mailman/listinfo/amd-gfx</a></span></p>
</div>
<p style=3D"margin:0in 0in 0.0001pt; font-size:12pt; font-family:&quot;Time=
s New Roman&quot;,serif; background:white">
<span style=3D"font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;; colo=
r:black">&nbsp;</span></p>
</div>
</div>
</div>
</div>
</div>
</div>
</div>
</div>
</div>
</div>
</div>
</div>
</div>
</div>
<br>
<fieldset class=3D"mimeAttachmentHeader"></fieldset> <br>
<pre>_______________________________________________=0A=
amd-gfx mailing list=0A=
<a class=3D"moz-txt-link-abbreviated" href=3D"mailto:amd-gfx-PD4FTy7X32lzq7FAFJ/aeQ@public.gmane.org=
top.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a>=0A=
<a class=3D"moz-txt-link-freetext" href=3D"https://lists.freedesktop.org/ma=
ilman/listinfo/amd-gfx">https://lists.freedesktop.org/mailman/listinfo/amd-=
gfx</a>=0A=
</pre>
</blockquote>
<p><br>
</p>
</div>
</div>
</div>
</body>
</html>

--_000_DM5PR12MB113219F25560F97BCCCF1469F7150DM5PR12MB1132namp_--

--_004_DM5PR12MB113219F25560F97BCCCF1469F7150DM5PR12MB1132namp_
Content-Type: image/png; name="ATT00001.png"
Content-Description: ATT00001.png
Content-Disposition: inline; filename="ATT00001.png"; size=488;
	creation-date="Thu, 18 Aug 2016 16:07:16 GMT";
	modification-date="Thu, 18 Aug 2016 16:07:16 GMT"
Content-ID: <part3.F176A269.01DFF465-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
Content-Transfer-Encoding: base64

iVBORw0KGgoAAAANSUhEUgAAABMAAAATCAYAAAByUDbMAAAAGXRFWHRTb2Z0d2FyZQBBZG9iZSBJ
bWFnZVJlYWR5ccllPAAAAYpJREFUeNpi/P//PwO1ACM2wf9njBWAVD4QBwCxApLUAyDeAMQTGU3O
PkDRA3QUIxaD+oFUAREOaQQa2IDTMKBB84FUAgk+WwA0MBFmGBOaixJIDKYEoD6465igBjkge+3C
rW94TUCTr4eGMdxl8TCZxMYHDIZR1xk2HPiA1SCQOEgepA4J5CMbFgAPhM1vwfTFW9+xGgYTh6lD
1s8IdKIAkH4PEz1w9jOYVpBiZ1CQZMMw7MHzXwwPnv0Esx2MeRESxmcYWYCUAbJiFAVYAMgCbJbA
vPmAWjmACZqS4aHdOOs5wdgEBcWE5a8Y0HIGPAIOwETtjXkYJqIqxAAgeQM1ThTzkQ2biB5mC7a8
xZ7kgeICvMzoYTsRJaMDY3U9chIBpaMHz34xxPsKgwMcFIsLgckB5KL+YllkgyYAg6oQJW9Ck8h+
5NgFhd3GAx/humAGI2cGIHYEGvYBW0YHGTgf2YX4MjkQF4IMwlkEIeXVfByGwsqzAwTLMywGg7wN
cvED9AIR3TCAAAMAqh+p+YMVeBQAAAAASUVORK5CYII=

--_004_DM5PR12MB113219F25560F97BCCCF1469F7150DM5PR12MB1132namp_--

--===============1709375037==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1709375037==--
