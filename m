From: Jason Ekstrand <jason@jlekstrand.net>
Subject: Re: [PATCH] drm/syncobj: add sync obj wait interface. (v6)
Date: Wed, 12 Jul 2017 10:02:31 -0700
Message-ID: <CAOFGe975SqrhyeNVVdgRn7KA_baXz+GA2NgZdfpjvEm8+G_4oA@mail.gmail.com>
References: <20170706010409.9373-1-airlied@gmail.com>
 <CAOFGe94mA9i7+-XTJQn65N-vK_GbQwvjru2b=6ucXejpWWmx4g@mail.gmail.com>
 <899f9bb3-f7c7-ce86-c22b-bb8d262778bf@vodafone.de>
 <CAOFGe96gaX2OjsXr8bNBUiqwyKAQfMSycH7PXgYAt_BBJ1UHkQ@mail.gmail.com>
 <fe27d2f8-760b-c2d4-9474-7eaaae560086@vodafone.de>
 <CAOFGe95oZz-O743v7J6gpVuUqvPjdeifAcuoaZe8bf1HUNXm+Q@mail.gmail.com>
 <0c81dd81-e84a-2381-3ce1-e08450929da8@daenzer.net>
 <c7a44542-acca-09e1-5ea5-bf9938921e54@vodafone.de>
 <CAOFGe95cnFJCEAO6k8emWFWaAZdMPrdHjQos02peuWe6Ve1wvw@mail.gmail.com>
 <2a0f44cc-b893-153c-9852-b1b4855e386e@vodafone.de>
 <CAPM=9twkH4H0Buxpb7nKAMawNxouWCombhfAh++pNpSZNMLRow@mail.gmail.com>
 <CAOFGe95mj1G_Ap0oOPFyatZWEbEk_Kwo8Wn_E+eYS16Nhz_huQ@mail.gmail.com>
 <f1375dda-2997-7ed5-dcde-e2fc5e1c44c2@vodafone.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1253956481=="
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <f1375dda-2997-7ed5-dcde-e2fc5e1c44c2@vodafone.de>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <deathsimple@vodafone.de>
Cc: =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel@daenzer.net>, amd-gfx mailing list <amd-gfx@lists.freedesktop.org>, Maling list - DRI developers <dri-devel@lists.freedesktop.org>
List-Id: amd-gfx.lists.freedesktop.org

--===============1253956481==
Content-Type: multipart/alternative; boundary="001a11469ecc30e4c5055421c8c4"

--001a11469ecc30e4c5055421c8c4
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 12, 2017 at 9:45 AM, Christian K=C3=B6nig <deathsimple@vodafone=
.de>
wrote:

> Am 12.07.2017 um 17:53 schrieb Jason Ekstrand:
>
> [SNIP]
>
>
>> Is that easier than just waiting in the kernel, I'm not sure how
>> optimised we need this path to be.
>>
>
> I don't think so.  I think it's more-or-less the same code regardless of
> how it's done.  The advantage of doing it in the kernel is that it's
> standardized (we don't have to both go write that userspace code) and it
> doesn't have the problems stated above.
>
>
> Ok, I'm convinced. The next price question is then how do we do it?
>
> I mean writing an IOCTL to wait for a fence to appear is simple, but do w=
e
> also need to wait for a fence to change?
>

I don't think so.  Taking a page from the Vulkan book, I think the "right"
thing to do would be to have a reset ioctl that simply deletes the
dma_fence and replaces it with NULL.  Then the only behavior you care about
is "wait for a fence to appear".  The usage pattern becomes:

 1) Submit work to signal the syncobj
 2) Wait on the syncobj (this may happen before the submit)
 3) Once everyone is done waiting, reset the syncobj

If someone does a wait on a stale syncobj that has completed and not yet
been reset, they return immediately.  Yes, there is a possible race between
2 and 3, especially if 2 is waiting on multiple syncobjs.  Ideally, we'd
make it so that a reset in the middle of someone else's wait wouldn't cause
them to wait until that syncobj gets triggerd a second time.  However, I
don't think it's a deal-breaker as any client that sets the "wait for
submit" flag should know that it's liable to wait forever and set a timeout=
.

--001a11469ecc30e4c5055421c8c4
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><div class=3D"gmail_quote">On W=
ed, Jul 12, 2017 at 9:45 AM, Christian K=C3=B6nig <span dir=3D"ltr">&lt;<a =
href=3D"mailto:deathsimple@vodafone.de" target=3D"_blank">deathsimple@vodaf=
one.de</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"=
margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
 =20
   =20
 =20
  <div text=3D"#000000" bgcolor=3D"#FFFFFF">
    <div class=3D"m_9095598565780015075moz-cite-prefix">Am 12.07.2017 um 17=
:53 schrieb Jason
      Ekstrand:<br>
    </div>
    <blockquote type=3D"cite">
      <div dir=3D"ltr">
        <div class=3D"gmail_extra">
          <div class=3D"gmail_quote">[SNIP]<span class=3D""><br>
            <div>=C2=A0</div>
            <blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;bo=
rder-left:1px #ccc solid;padding-left:1ex"><span>
              </span>Is that easier than just waiting in the kernel, I&#39;=
m
              not sure how<br>
              optimised we need this path to be.<span class=3D"m_9095598565=
780015075HOEnZb"><font color=3D"#888888"><br>
                </font></span></blockquote>
          </span></div>
          <br>
        </div><span class=3D"">
        <div class=3D"gmail_extra">I don&#39;t think so.=C2=A0 I think it&#=
39;s
          more-or-less the same code regardless of how it&#39;s done.=C2=A0=
 The
          advantage of doing it in the kernel is that it&#39;s standardized
          (we don&#39;t have to both go write that userspace code) and it
          doesn&#39;t have the problems stated above.<br>
        </div>
      </span></div>
    </blockquote>
    <br>
    Ok, I&#39;m convinced. The next price question is then how do we do it?=
<br>
    <br>
    I mean writing an IOCTL to wait for a fence to appear is simple, but
    do we also need to wait for a fence to change?<span class=3D"HOEnZb"><f=
ont color=3D"#888888"><br>
  </font></span></div>

</blockquote></div><br></div><div class=3D"gmail_extra">I don&#39;t think s=
o.=C2=A0 Taking a page from the Vulkan book, I think the &quot;right&quot; =
thing to do would be to have a reset ioctl that simply deletes the dma_fenc=
e and replaces it with NULL.=C2=A0 Then the only behavior you care about is=
 &quot;wait for a fence to appear&quot;.=C2=A0 The usage pattern becomes:<b=
r><br></div><div class=3D"gmail_extra">=C2=A01) Submit work to signal the s=
yncobj<br></div><div class=3D"gmail_extra">=C2=A02) Wait on the syncobj (th=
is may happen before the submit)<br></div><div class=3D"gmail_extra">=C2=A0=
3) Once everyone is done waiting, reset the syncobj<br><br></div><div class=
=3D"gmail_extra">If someone does a wait on a stale syncobj that has complet=
ed and not yet been reset, they return immediately.=C2=A0 Yes, there is a p=
ossible race between 2 and 3, especially if 2 is waiting on multiple syncob=
js.=C2=A0 Ideally, we&#39;d make it so that a reset in the middle of someon=
e else&#39;s wait wouldn&#39;t cause them to wait until that syncobj gets t=
riggerd a second time.=C2=A0 However, I don&#39;t think it&#39;s a deal-bre=
aker as any client that sets the &quot;wait for submit&quot; flag should kn=
ow that it&#39;s liable to wait forever and set a timeout.<br></div></div>

--001a11469ecc30e4c5055421c8c4--

--===============1253956481==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVs
IG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCg==

--===============1253956481==--
