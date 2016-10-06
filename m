From: Jeremy Newton <alexjnewt-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Issue with amd-staging-4.7 on rx480
Date: Thu, 6 Oct 2016 10:38:44 -0400
Message-ID: <CAHOSEu9edP3sFwkjpzcX2cVt90TPkqJsPn=fazUbYZ6azMm-0A@mail.gmail.com>
References: <CAHOSEu8-fa0RznKX7s-vbU_1g_eCaa-ZBp=0ySP5X_VqJA13Ng@mail.gmail.com>
 <CY4PR12MB1768EB91BA59663BC700C2AAF7C70@CY4PR12MB1768.namprd12.prod.outlook.com>
 <CAHOSEu_mFEy5W5v=603raJC21xnAK5TScABCGm-8haO0-xRnkQ@mail.gmail.com>
 <CY4PR12MB1768C5EE5166DBDB8156F199F7C70@CY4PR12MB1768.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0201788591=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CY4PR12MB1768C5EE5166DBDB8156F199F7C70-rpdhrqHFk06yjjPBNVDk/QdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
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
Cc: "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============0201788591==
Content-Type: multipart/alternative; boundary=001a114c6df03d8cff053e33403b

--001a114c6df03d8cff053e33403b
Content-Type: text/plain; charset=UTF-8

Fair enough, I'll bisect and see what happens.

Thanks for your help!

On Thu, Oct 6, 2016 at 10:12 AM, StDenis, Tom <Tom.StDenis-5C7GfCeVMHo@public.gmane.org> wrote:

> Hi Jeremy,
>
>
> Nothing between the UVD PG patch and the tip of stg-4.7 seems to be that
> relevant to 480.
>
>
> If 8f877a8 is stable best you can do is bisect (shouldn't take long) with
> cold boots in between.  I too run Fedora 24 + GNOME and have good
> performance with Carrizo, Stoney, FIJI and Tonga (with the 5dw patch
> reverted) on the tip of stg-4.7.  I have yet to test a polaris asic
> though...
>
>
> Tom
>
>
> ------------------------------
> *From:* Jeremy Newton <alexjnewt-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> *Sent:* Thursday, October 6, 2016 10:07
> *To:* StDenis, Tom
> *Cc:* amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> *Subject:* Re: Issue with amd-staging-4.7 on rx480
>
> I apologise if what I said was unclear. When I mean I reverted back to 8f877a8,
> I mean I did a hard reset to this commit, i.e. reverting all
> commits/changes after this one. Basically I reverted the following
> commits: e3bb40f, 32ba038, 6892173, 55a9ab5, 4760300,
> 8ee5196, 381c90a, 5ae6bd0, 9a846b4, 042f89f, and 78d1842. I just skimmed
> it last night, so I can't say for sure where the issue is, but I'm assuming
> it's one of the drm/amdgpu commits, i.e. excluding commits9a846b4, 042f89f,
> and 78d1842.
>
> I have only tested based on a snapshot at 8f877a8 and another snapshot at 78d1842.
> The latter caused the issue, while the former seems fine. I just discovered
> this last night, but I'll do some builds tonight to bisect the issue if
> need be.
>
> Commit 6691270 on the other hand doesn't appear cause my issues. And
> lastly, I rarely do warm boots on my machine, so all of my tests have been
> cold boots.
>
> Thanks,
> Jeremy
>
> On Thu, Oct 6, 2016 at 9:41 AM, StDenis, Tom <Tom.StDenis-5C7GfCeVMHo@public.gmane.org> wrote:
>
>> If I read this correctly you reverted the commit which enables UVD PG on
>> Tonga?  I can't see how that impacts Polaris at all.
>>
>>
>> If I had to guess it's a dGPU state issue.  I've had on occasion to
>> resort to cold reboots to bisect the kernel because the GPU firmware can
>> get into states that aren't 100% resolved by a warm reboot.
>>
>>
>> There is a known bad commit which was reverted by Christian which I guess
>> isn't out on fdo yet.  https://cgit.freedesktop.org/
>> ~agd5f/linux/commit/?h=amd-staging-4.7&id=6691270952b6909218
>> c520dcc71a342070c96874 that commit seems to break dGPU support.
>>
>>
>> Cheers,
>>
>> Tom
>>
>>
>> ------------------------------
>> *From:* amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of
>> Jeremy Newton <alexjnewt-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>> *Sent:* Wednesday, October 5, 2016 22:54
>> *To:* amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
>> *Subject:* Issue with amd-staging-4.7 on rx480
>>
>> Hello,
>>
>> I'm currently regularly building and using the amd-staging-4.7 linux
>> branch, which can be found here:
>>
>> https://cgit.freedesktop.org/~agd5f/linux/log/?h=amd-staging-4.7
>>
>> It seems that one of the commits pushed on 2016-10-03 broke something,
>> and I just wanted to give the devs a heads up in case no one noticed. I'm
>> guessing it was caused by one of the commits in the range of e3bb40f all
>> the way up to 78d1842.
>>
>> I'm using an RX480, polaris10. The issue seems to have two symptoms:
>> - Plymouth (the boot splash screen) seems to get visually corrupted or
>> just blacked out.
>> - After login, the screen just remains black until I hard reset.
>>
>> Reverting back to 8f877a8 seems to fix it. I'm using Fedora 24 with
>> GNOME. As well, I haven't had time to bisect, but I can do so if desired.
>>
>> Thanks!
>>
>
>

--001a114c6df03d8cff053e33403b
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Fair enough, I&#39;ll bisect and see what happens.<div><br=
></div><div>Thanks for your help!</div></div><div class=3D"gmail_extra"><br=
><div class=3D"gmail_quote">On Thu, Oct 6, 2016 at 10:12 AM, StDenis, Tom <=
span dir=3D"ltr">&lt;<a href=3D"mailto:Tom.StDenis-5C7GfCeVMHo@public.gmane.org" target=3D"_blan=
k">Tom.StDenis-5C7GfCeVMHo@public.gmane.org</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_=
quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1=
ex">




<div dir=3D"ltr">
<div id=3D"m_4386376317330016210divtagdefaultwrapper" style=3D"font-size:12=
pt;color:#000000;font-family:Calibri,Arial,Helvetica,sans-serif">
<p>Hi Jeremy,</p>
<p><br>
</p>
<p>Nothing between the UVD PG patch and the tip of stg-4.7 seems to be that=
 relevant to 480.</p>
<p><br>
</p>
<p>If 8f877a8 is stable best you can do is bisect (shouldn&#39;t take long)=
 with cold boots in=C2=A0between.=C2=A0 I too run Fedora 24 + GNOME and hav=
e good performance with Carrizo, Stoney, FIJI and Tonga (with the 5dw patch=
 reverted) on the tip of stg-4.7.=C2=A0 I have yet
 to test a polaris asic though...</p>
<p><br>
</p>
<p>Tom</p>
<br>
<br>
<div style=3D"color:rgb(0,0,0)">
<hr style=3D"display:inline-block;width:98%">
<div id=3D"m_4386376317330016210divRplyFwdMsg" dir=3D"ltr"><font face=3D"Ca=
libri, sans-serif" color=3D"#000000" style=3D"font-size:11pt"><b>From:</b> =
Jeremy Newton &lt;<a href=3D"mailto:alexjnewt-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" target=3D"_blank">=
alexjnewt-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt;<br>
<b>Sent:</b> Thursday, October 6, 2016 10:07<br>
<b>To:</b> StDenis, Tom<br>
<b>Cc:</b> <a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" target=3D"_blan=
k">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
<b>Subject:</b> Re: Issue with amd-staging-4.7 on rx480</font>
<div>=C2=A0</div>
</div><div><div class=3D"h5">
<div>
<div dir=3D"ltr">I apologise if what I said was unclear. When I mean I reve=
rted back to=C2=A0<span style=3D"font-size:12.8px">8f877a8, I mean I did a =
hard reset to this commit, i.e. reverting all commits/changes after this on=
e. Basically I reverted the following commits:=C2=A0e3bb40f,=C2=A032ba038,=
=C2=A0<wbr>6892173,=C2=A055a9ab5,=C2=A04760300,=C2=A0<wbr>8ee5196,=C2=A0381=
c90a,=C2=A05ae6bd0,=C2=A0<wbr>9a846b4,=C2=A0042f89f,
 and 78d1842. I just skimmed it last night, so I can&#39;t say for sure whe=
re the issue is, but I&#39;m assuming it&#39;s one of the=C2=A0drm/amdgpu=
=C2=A0commits, i.e. excluding commits</span><span style=3D"font-size:12.8px=
">9a846b4,=C2=A0042f89f, and 78d1842</span><span style=3D"font-size:12.8px"=
>.</span>
<div><span style=3D"font-size:12.8px"><br>
</span></div>
<div><span style=3D"font-size:12.8px">I have only tested based on a snapsho=
t at=C2=A0</span><span style=3D"font-size:12.8px">8f877a8 and another snaps=
hot at=C2=A0</span><span style=3D"font-size:12.8px">78d1842. The latter cau=
sed the issue, while the former seems fine. I just
 discovered this last night, but I&#39;ll do some builds tonight to bisect =
the issue if need be.</span><span style=3D"font-size:12.8px"><br>
</span>
<div><span style=3D"font-size:12.8px"><br>
</span></div>
<div>Commit=C2=A06691270 on the other hand doesn&#39;t appear cause my issu=
es. And lastly, I rarely do warm boots on my machine, so all of my tests ha=
ve been cold boots.</div>
</div>
<div><br>
</div>
<div>Thanks,</div>
<div>Jeremy</div>
</div>
<div class=3D"gmail_extra"><br>
<div class=3D"gmail_quote">On Thu, Oct 6, 2016 at 9:41 AM, StDenis, Tom <sp=
an dir=3D"ltr">
&lt;<a href=3D"mailto:Tom.StDenis-5C7GfCeVMHo@public.gmane.org" target=3D"_blank">Tom.StDenis@am=
d.com</a>&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
<div dir=3D"ltr">
<div id=3D"m_4386376317330016210m_-3510539901589408934divtagdefaultwrapper"=
 style=3D"font-size:12pt;color:#000000;font-family:Calibri,Arial,Helvetica,=
sans-serif">
<p>If I read this correctly you reverted the commit which enables UVD PG on=
 Tonga?=C2=A0 I can&#39;t see how that impacts Polaris at all. =C2=A0</p>
<p><br>
</p>
<p>If I had to guess it&#39;s a dGPU state issue.=C2=A0 I&#39;ve had on occ=
asion to resort to cold reboots to bisect the kernel because the GPU firmwa=
re can get into states that aren&#39;t 100% resolved by a warm reboot.</p>
<p><br>
</p>
<p>There is a known bad commit which was reverted by Christian which I gues=
s isn&#39;t out on fdo yet. =C2=A0<a href=3D"https://cgit.freedesktop.org/~=
agd5f/linux/commit/?h=3Damd-staging-4.7&amp;id=3D6691270952b6909218c520dcc7=
1a342070c96874" class=3D"m_4386376317330016210m_-3510539901589408934OWAAuto=
Link" id=3D"m_4386376317330016210m_-3510539901589408934LPlnk533633" target=
=3D"_blank">https://cgit.freedesktop.org/<wbr>~agd5f/linux/commit/?h=3Damd-=
sta<wbr>ging-4.7&amp;id=3D6691270952b6909218<wbr>c520dcc71a342070c96874</a>=
=C2=A0that
 commit seems to break dGPU support.</p>
<p><br>
</p>
<p>Cheers,</p>
<p>Tom</p>
<br>
<br>
<div style=3D"color:rgb(0,0,0)">
<hr style=3D"display:inline-block;width:98%">
<div id=3D"m_4386376317330016210m_-3510539901589408934divRplyFwdMsg" dir=3D=
"ltr"><font face=3D"Calibri, sans-serif" color=3D"#000000" style=3D"font-si=
ze:11pt"><b>From:</b> amd-gfx &lt;<a href=3D"mailto:amd-gfx-bounces@lists.f=
reedesktop.org" target=3D"_blank">amd-gfx-bounces-PD4FTy7X32mqWrfYKbYh0A@public.gmane.org<wbr>ktop.or=
g</a>&gt;
 on behalf of Jeremy Newton &lt;<a href=3D"mailto:alexjnewt-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" targ=
et=3D"_blank">alexjnewt-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt;<br>
<b>Sent:</b> Wednesday, October 5, 2016 22:54<br>
<b>To:</b> <a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" target=3D"_blan=
k">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
<b>Subject:</b> Issue with amd-staging-4.7 on rx480</font>
<div>=C2=A0</div>
</div>
<div>
<div class=3D"m_4386376317330016210h5">
<div>
<div dir=3D"ltr">
<div><span style=3D"text-align:right">
<div style=3D"text-align:start">Hello,</div>
<div style=3D"text-align:start"><br>
</div>
<div style=3D"text-align:start">I&#39;m currently regularly building and us=
ing the amd-staging-4.7 linux branch, which can be found here:</div>
<div style=3D"text-align:start"><br>
</div>
<div style=3D"text-align:start"><a href=3D"https://cgit.freedesktop.org/~ag=
d5f/linux/log/?h=3Damd-staging-4.7" id=3D"m_4386376317330016210m_-351053990=
1589408934LPlnk449083" target=3D"_blank">https://cgit.freedesktop.org/~<wbr=
>agd5f/linux/log/?h=3Damd-staging<wbr>-4.7</a></div>
<div style=3D"text-align:start"><br>
</div>
<div style=3D"text-align:start">It seems that one of the commits pushed on =
2016-10-03 broke something, and I just wanted to give the devs a heads up i=
n case no one noticed. I&#39;m guessing it was caused by one of the commits=
 in the range of e3bb40f all the way up
 to 78d1842.</div>
<div style=3D"text-align:start"><br>
</div>
<div style=3D"text-align:start">I&#39;m using an RX480, polaris10. The issu=
e seems to have two symptoms:</div>
<div style=3D"text-align:start">- Plymouth (the boot splash screen) seems t=
o get visually corrupted or just blacked out.</div>
<div style=3D"text-align:start">- After login, the screen just remains blac=
k until I hard reset.</div>
<div style=3D"text-align:start"><br>
</div>
<div style=3D"text-align:start">Reverting back to 8f877a8 seems to fix it. =
I&#39;m using Fedora 24 with GNOME. As well, I haven&#39;t had time to bise=
ct, but I can do so if desired.</div>
<div style=3D"text-align:start"><br>
</div>
<div style=3D"text-align:start">Thanks!</div>
</span></div>
</div>
</div>
</div>
</div>
</div>
</div>
</div>
</blockquote>
</div>
<br>
</div>
</div>
</div></div></div>
</div>
</div>

</blockquote></div><br></div>

--001a114c6df03d8cff053e33403b--

--===============0201788591==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0201788591==--
