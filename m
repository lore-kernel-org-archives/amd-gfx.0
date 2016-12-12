From: "Bridgman, John" <John.Bridgman-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [RFC] Using DC in amdgpu for upcoming GPU
Date: Mon, 12 Dec 2016 03:43:51 +0000
Message-ID: <BN6PR12MB13482393D316367FCCD71BB6E8980@BN6PR12MB1348.namprd12.prod.outlook.com>
References: <55d5e664-25f7-70e0-f2f5-9c9daf3efdf6@amd.com>,
 <CAPM=9tx+j9-3fZNY=peLjdsVqyLS6i3V-sV3XrnYsK2YuhWRBA@mail.gmail.com>,
 <BN6PR12MB134883D1437EC26D13BA62D0E8980@BN6PR12MB1348.namprd12.prod.outlook.com>,
 <BN6PR12MB13484A1D247707C399180266E8980@BN6PR12MB1348.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1639654592=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <BN6PR12MB13484A1D247707C399180266E8980-/b2+HYfkarQX0pEhCR5T8QdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
Content-Language: en-CA
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
To: Dave Airlie <airlied-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "Wentland, Harry" <Harry.Wentland-5C7GfCeVMHo@public.gmane.org>
Cc: "Grodzovsky, Andrey" <Andrey.Grodzovsky-5C7GfCeVMHo@public.gmane.org>, "Cyr,
 Aric" <Aric.Cyr-5C7GfCeVMHo@public.gmane.org>, "Lazare, Jordan" <Jordan.Lazare-5C7GfCeVMHo@public.gmane.org>, amd-gfx mailing list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, dri-devel <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "Deucher,
 Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>, "Cheng, Tony" <Tony.Cheng-5C7GfCeVMHo@public.gmane.org>

--===============1639654592==
Content-Language: en-CA
Content-Type: multipart/alternative;
	boundary="_000_BN6PR12MB13482393D316367FCCD71BB6E8980BN6PR12MB1348namp_"

--_000_BN6PR12MB13482393D316367FCCD71BB6E8980BN6PR12MB1348namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

v3 with typo fixes and additional comments/questions..


________________________________
From: Bridgman, John
Sent: December 11, 2016 10:21 PM
To: Dave Airlie; Wentland, Harry
Cc: dri-devel; amd-gfx mailing list; Deucher, Alexander; Lazare, Jordan; Ch=
eng, Tony; Cyr, Aric; Grodzovsky, Andrey
Subject: Re: [RFC] Using DC in amdgpu for upcoming GPU


Thanks Dave. Apologies in advance for top posting but I'm stuck on a mail c=
lient that makes a big mess when I try anything else...


>This code needs rewriting, not cleaning, not polishing, it needs to be
>split into its constituent parts, and reintegrated in a form more
>Linux process friendly.


Can we say "restructuring" just for consistency with Daniel's message (the =
HW-dependent bits don't need to be rewritten but the way they are used/call=
ed needs to change) ?


>I feel that if I reply to the individual points Harry has raised in
>this RFC, that it means the code would then be suitable for merging,
>which it still won't, and I don't want people wasting another 6
>months.


That's fair. There was an implicit "when it's suitable" assumption in the R=
FC, but we'll make that explicit in the future.


>If DC was ready for the next-gen GPU it would be ready for the current
>GPU, it's not the specific ASIC code that is the problem, it's the
>huge midlayer sitting in the middle.


We realize that (a) we are getting into the high-risk-of-breakage part of t=
he rework and (b) no matter how much we change the code structure there's a=
 good chance that a month after it goes upstream one of us is going to find=
 that more structural changes are required.


I was kinda thinking that if we are doing high-risk activities (risk of sub=
tle breakage not obvious regression, and/or risk of making structural chang=
es that turn out to be a bad idea even though we all thought they were corr=
ect last week) there's an argument for doing it in code which is only used =
for cards that people can't buy yet.

________________________________
From: Dave Airlie <airlied-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sent: December 11, 2016 9:57 PM
To: Wentland, Harry
Cc: dri-devel; amd-gfx mailing list; Bridgman, John; Deucher, Alexander; La=
zare, Jordan; Cheng, Tony; Cyr, Aric; Grodzovsky, Andrey
Subject: Re: [RFC] Using DC in amdgpu for upcoming GPU

On 8 December 2016 at 12:02, Harry Wentland <harry.wentland-5C7GfCeVMHo@public.gmane.org> wrote:
> We propose to use the Display Core (DC) driver for display support on
> AMD's upcoming GPU (referred to by uGPU in the rest of the doc). In order=
 to
> avoid a flag day the plan is to only support uGPU initially and transitio=
n
> to older ASICs gradually.

[FAQ: from past few days]

1) Hey you replied to Daniel, you never addressed the points of the RFC!
I've read it being said that I hadn't addressed the RFC, and you know
I've realised I actually had, because the RFC is great but it
presupposes the codebase as designed can get upstream eventually, and
I don't think it can. The code is too littered with midlayering and
other problems, that actually addressing the individual points of the
RFC would be missing the main point I'm trying to make.

This code needs rewriting, not cleaning, not polishing, it needs to be
split into its constituent parts, and reintegrated in a form more
Linux process friendly.

I feel that if I reply to the individual points Harry has raised in
this RFC, that it means the code would then be suitable for merging,
which it still won't, and I don't want people wasting another 6
months.

If DC was ready for the next-gen GPU it would be ready for the current
GPU, it's not the specific ASIC code that is the problem, it's the
huge midlayer sitting in the middle.

2) We really need to share all of this code between OSes, why does
Linux not want it?

Sharing code is a laudable goal and I appreciate the resourcing
constraints that led us to the point at which we find ourselves, but
the way forward involves finding resources to upstream this code,
dedicated people (even one person) who can spend time on a day by day
basis talking to people in the open and working upstream, improving
other pieces of the drm as they go, reading atomic patches and
reviewing them, and can incrementally build the DC experience on top
of the Linux kernel infrastructure. Then having the corresponding
changes in the DC codebase happen internally to correspond to how the
kernel code ends up looking. Lots of this code overlaps with stuff the
drm already does, lots of is stuff the drm should be doing, so patches
to the drm should be sent instead.

3) Then how do we upstream it?
Resource(s) need(s) to start concentrating at splitting this thing up
and using portions of it in the upstream kernel. We don't land fully
formed code in the kernel if we can avoid it. Because you can't review
the ideas and structure as easy as when someone builds up code in
chunks and actually develops in the Linux kernel. This has always
produced better more maintainable code. Maybe the result will end up
improving the AMD codebase as well.

4) Why can't we put this in staging?
People have also mentioned staging, Daniel has called it a dead end,
I'd have considered staging for this code base, and I still might.
However staging has rules, and the main one is code in staging needs a
TODO list, and agreed criteria for exiting staging, I don't think we'd
be able to get an agreement on what the TODO list should contain and
how we'd ever get all things on it done. If this code ended up in
staging, it would most likely require someone dedicated to recreating
it in the mainline driver in an incremental fashion, and I don't see
that resource being available.

5) Why is a midlayer bad?
I'm not going to go into specifics on the DC midlayer, but we abhor
midlayers for a fair few reasons. The main reason I find causes the
most issues is locking. When you have breaks in code flow between
multiple layers, but having layers calling back into previous layers
it becomes near impossible to track who owns the locking and what the
current locking state is.

Consider
    drma -> dca -> dcb -> drmb
    drmc -> dcc  -> dcb -> drmb

We have two codes paths that go back into drmb, now maybe drma has a
lock taken, but drmc doesn't, but we've no indication when we hit drmb
of what the context pre entering the DC layer is. This causes all
kinds of problems. The main requirement is the driver maintains the
execution flow as much as possible. The only callback behaviour should
be from an irq or workqueue type situations where you've handed
execution flow to the hardware to do something and it is getting back
to you. The pattern we use to get our of this sort of hole is helper
libraries, we structure code as much as possible as leaf nodes that
don't call back into the parents if we can avoid it (we don't always
succeed).

So the above might becomes
   drma-> dca_helper
           -> dcb_helper
           -> drmb.

In this case the code flow is controlled by drma, dca/dcb might be
modifying data or setting hw state but when we get to drmb it's easy
to see what data is needs and what locking.

DAL/DC goes against this in so many ways, and when I look at the code
I'm never sure where to even start pulling the thread to unravel it.

Some questions I have for AMD engineers that also I'd want to see
addressed before any consideration of merging would happen!

How do you plan on dealing with people rewriting or removing code
upstream that is redundant in the kernel, but required for internal
stuff?
How are you going to deal with new Linux things that overlap
incompatibly with your internally developed stuff?
If the code is upstream will it be tested in the kernel by some QA
group, or will there be some CI infrastructure used to maintain and to
watch for Linux code that breaks assumptions in the DC code?
Can you show me you understand that upstream code is no longer 100% in
your control and things can happen to it that you might not expect and
you need to deal with it?

Dave.

--_000_BN6PR12MB13482393D316367FCCD71BB6E8980BN6PR12MB1348namp_
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
<div id=3D"divtagdefaultwrapper" style=3D"font-size:12pt;color:#000000;font=
-family:Calibri,Arial,Helvetica,sans-serif;" dir=3D"ltr">
<p>v3 with typo fixes and additional comments/questions..<br>
</p>
<br>
<div style=3D"color: rgb(0, 0, 0);">
<div>
<div id=3D"divtagdefaultwrapper" dir=3D"ltr" style=3D"font-size:12pt; color=
:#000000; font-family:Calibri,Arial,Helvetica,sans-serif">
<br>
<div style=3D"color:rgb(0,0,0)">
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font style=3D"font-size:11pt" color=
=3D"#000000" face=3D"Calibri, sans-serif"><b>From:</b> Bridgman, John<br>
<b>Sent:</b> December 11, 2016 10:21 PM<br>
<b>To:</b> Dave Airlie; Wentland, Harry<br>
<b>Cc:</b> dri-devel; amd-gfx mailing list; Deucher, Alexander; Lazare, Jor=
dan; Cheng, Tony; Cyr, Aric; Grodzovsky, Andrey<br>
<b>Subject:</b> Re: [RFC] Using DC in amdgpu for upcoming GPU</font>
<div>&nbsp;</div>
</div>
<div>
<div id=3D"divtagdefaultwrapper" dir=3D"ltr" style=3D"font-size:12pt; color=
:#000000; font-family:Calibri,Arial,Helvetica,sans-serif">
<p>Thanks Dave. Apologies in advance for top posting but I'm stuck on a mai=
l client that makes a big mess when I try anything else...</p>
<p><br>
</p>
<p><font size=3D"2"><span style=3D"font-size:10pt">&gt;This code needs rewr=
iting, not cleaning, not polishing, it needs to be<br>
&gt;split into its constituent parts, and reintegrated in a form more<br>
&gt;Linux process friendly.</span></font><br>
</p>
<p><br>
</p>
<p>Can we say &quot;restructuring&quot; just for consistency with Daniel's =
message (the HW-dependent bits don't need to be rewritten but the way they =
are used/called needs to change) ?<br>
</p>
<p><br>
</p>
<p><font size=3D"2"><span style=3D"font-size:10pt">&gt;I feel that if I rep=
ly to the individual points Harry has raised in<br>
&gt;this RFC, that it means the code would then be suitable for merging,<br=
>
&gt;which it still won't, and I don't want people wasting another 6<br>
&gt;months.</span></font><br>
</p>
<p><br>
</p>
<p>That's fair. There was an implicit &quot;when it's suitable&quot; assump=
tion in the RFC, but we'll make that explicit in the future.<br>
</p>
<p><font size=3D"2"><span style=3D"font-size:10pt"></span></font></p>
<p><font size=3D"2"><span style=3D"font-size:10pt"><br>
</span></font></p>
<p><font size=3D"2"><span style=3D"font-size:10pt">&gt;If DC was ready for =
the next-gen GPU it would be ready for the current<br>
&gt;GPU, it's not the specific ASIC code that is the problem, it's the<br>
&gt;huge midlayer sitting in the middle.</span></font><br>
</p>
<br>
<p>We realize that (a) we are getting into the high-risk-of-breakage part o=
f the rework and (b) no matter how much we change the code structure there'=
s a good chance that a month after it goes upstream one of us is going to f=
ind that more structural changes
 are required. <br>
</p>
<p><br>
</p>
<p>I was kinda thinking that if we are doing high-risk activities (risk of =
subtle breakage not obvious regression, and/or risk of making structural ch=
anges that turn out to be a bad idea even though we all thought they were c=
orrect last week) there's an argument
 for doing it in code which is only used for cards that people can't buy ye=
t.<br>
</p>
<br>
<div style=3D"color:rgb(0,0,0)">
<div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"x_divRplyFwdMsg" dir=3D"ltr"><font style=3D"font-size:11pt" colo=
r=3D"#000000" face=3D"Calibri, sans-serif"><b>From:</b> Dave Airlie &lt;air=
lied-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org&gt;<br>
<b>Sent:</b> December 11, 2016 9:57 PM<br>
<b>To:</b> Wentland, Harry<br>
<b>Cc:</b> dri-devel; amd-gfx mailing list; Bridgman, John; Deucher, Alexan=
der; Lazare, Jordan; Cheng, Tony; Cyr, Aric; Grodzovsky, Andrey<br>
<b>Subject:</b> Re: [RFC] Using DC in amdgpu for upcoming GPU</font>
<div>&nbsp;</div>
</div>
</div>
<font size=3D"2"><span style=3D"font-size:10pt">
<div class=3D"PlainText">On 8 December 2016 at 12:02, Harry Wentland &lt;ha=
rry.wentland-5C7GfCeVMHo@public.gmane.org&gt; wrote:<br>
&gt; We propose to use the Display Core (DC) driver for display support on<=
br>
&gt; AMD's upcoming GPU (referred to by uGPU in the rest of the doc). In or=
der to<br>
&gt; avoid a flag day the plan is to only support uGPU initially and transi=
tion<br>
&gt; to older ASICs gradually.<br>
<br>
[FAQ: from past few days]<br>
<br>
1) Hey you replied to Daniel, you never addressed the points of the RFC!<br=
>
I've read it being said that I hadn't addressed the RFC, and you know<br>
I've realised I actually had, because the RFC is great but it<br>
presupposes the codebase as designed can get upstream eventually, and<br>
I don't think it can. The code is too littered with midlayering and<br>
other problems, that actually addressing the individual points of the<br>
RFC would be missing the main point I'm trying to make.<br>
<br>
This code needs rewriting, not cleaning, not polishing, it needs to be<br>
split into its constituent parts, and reintegrated in a form more<br>
Linux process friendly.<br>
<br>
I feel that if I reply to the individual points Harry has raised in<br>
this RFC, that it means the code would then be suitable for merging,<br>
which it still won't, and I don't want people wasting another 6<br>
months.<br>
<br>
If DC was ready for the next-gen GPU it would be ready for the current<br>
GPU, it's not the specific ASIC code that is the problem, it's the<br>
huge midlayer sitting in the middle.<br>
<br>
2) We really need to share all of this code between OSes, why does<br>
Linux not want it?<br>
<br>
Sharing code is a laudable goal and I appreciate the resourcing<br>
constraints that led us to the point at which we find ourselves, but<br>
the way forward involves finding resources to upstream this code,<br>
dedicated people (even one person) who can spend time on a day by day<br>
basis talking to people in the open and working upstream, improving<br>
other pieces of the drm as they go, reading atomic patches and<br>
reviewing them, and can incrementally build the DC experience on top<br>
of the Linux kernel infrastructure. Then having the corresponding<br>
changes in the DC codebase happen internally to correspond to how the<br>
kernel code ends up looking. Lots of this code overlaps with stuff the<br>
drm already does, lots of is stuff the drm should be doing, so patches<br>
to the drm should be sent instead.<br>
<br>
3) Then how do we upstream it?<br>
Resource(s) need(s) to start concentrating at splitting this thing up<br>
and using portions of it in the upstream kernel. We don't land fully<br>
formed code in the kernel if we can avoid it. Because you can't review<br>
the ideas and structure as easy as when someone builds up code in<br>
chunks and actually develops in the Linux kernel. This has always<br>
produced better more maintainable code. Maybe the result will end up<br>
improving the AMD codebase as well.<br>
<br>
4) Why can't we put this in staging?<br>
People have also mentioned staging, Daniel has called it a dead end,<br>
I'd have considered staging for this code base, and I still might.<br>
However staging has rules, and the main one is code in staging needs a<br>
TODO list, and agreed criteria for exiting staging, I don't think we'd<br>
be able to get an agreement on what the TODO list should contain and<br>
how we'd ever get all things on it done. If this code ended up in<br>
staging, it would most likely require someone dedicated to recreating<br>
it in the mainline driver in an incremental fashion, and I don't see<br>
that resource being available.<br>
<br>
5) Why is a midlayer bad?<br>
I'm not going to go into specifics on the DC midlayer, but we abhor<br>
midlayers for a fair few reasons. The main reason I find causes the<br>
most issues is locking. When you have breaks in code flow between<br>
multiple layers, but having layers calling back into previous layers<br>
it becomes near impossible to track who owns the locking and what the<br>
current locking state is.<br>
<br>
Consider<br>
&nbsp;&nbsp;&nbsp; drma -&gt; dca -&gt; dcb -&gt; drmb<br>
&nbsp;&nbsp;&nbsp; drmc -&gt; dcc&nbsp; -&gt; dcb -&gt; drmb<br>
<br>
We have two codes paths that go back into drmb, now maybe drma has a<br>
lock taken, but drmc doesn't, but we've no indication when we hit drmb<br>
of what the context pre entering the DC layer is. This causes all<br>
kinds of problems. The main requirement is the driver maintains the<br>
execution flow as much as possible. The only callback behaviour should<br>
be from an irq or workqueue type situations where you've handed<br>
execution flow to the hardware to do something and it is getting back<br>
to you. The pattern we use to get our of this sort of hole is helper<br>
libraries, we structure code as much as possible as leaf nodes that<br>
don't call back into the parents if we can avoid it (we don't always<br>
succeed).<br>
<br>
So the above might becomes<br>
&nbsp;&nbsp; drma-&gt; dca_helper<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -&gt; dcb_help=
er<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -&gt; drmb.<br=
>
<br>
In this case the code flow is controlled by drma, dca/dcb might be<br>
modifying data or setting hw state but when we get to drmb it's easy<br>
to see what data is needs and what locking.<br>
<br>
DAL/DC goes against this in so many ways, and when I look at the code<br>
I'm never sure where to even start pulling the thread to unravel it.<br>
<br>
Some questions I have for AMD engineers that also I'd want to see<br>
addressed before any consideration of merging would happen!<br>
<br>
How do you plan on dealing with people rewriting or removing code<br>
upstream that is redundant in the kernel, but required for internal<br>
stuff?<br>
How are you going to deal with new Linux things that overlap<br>
incompatibly with your internally developed stuff?<br>
If the code is upstream will it be tested in the kernel by some QA<br>
group, or will there be some CI infrastructure used to maintain and to<br>
watch for Linux code that breaks assumptions in the DC code?<br>
Can you show me you understand that upstream code is no longer 100% in<br>
your control and things can happen to it that you might not expect and<br>
you need to deal with it?<br>
<br>
Dave.<br>
</div>
</span></font></div>
</div>
</div>
</div>
</div>
</div>
</div>
</div>
</body>
</html>

--_000_BN6PR12MB13482393D316367FCCD71BB6E8980BN6PR12MB1348namp_--

--===============1639654592==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1639654592==--
