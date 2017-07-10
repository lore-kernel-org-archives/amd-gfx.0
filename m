From: Jason Ekstrand <jason-fQELhIk9awXprZlt/sZkLg@public.gmane.org>
Subject: Re: [PATCH] drm/syncobj: add sync obj wait interface. (v6)
Date: Mon, 10 Jul 2017 14:09:42 -0700
Message-ID: <CAOFGe95oZz-O743v7J6gpVuUqvPjdeifAcuoaZe8bf1HUNXm+Q@mail.gmail.com>
References: <20170706010409.9373-1-airlied@gmail.com>
 <CAOFGe94mA9i7+-XTJQn65N-vK_GbQwvjru2b=6ucXejpWWmx4g@mail.gmail.com>
 <899f9bb3-f7c7-ce86-c22b-bb8d262778bf@vodafone.de>
 <CAOFGe96gaX2OjsXr8bNBUiqwyKAQfMSycH7PXgYAt_BBJ1UHkQ@mail.gmail.com>
 <fe27d2f8-760b-c2d4-9474-7eaaae560086@vodafone.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1182414786=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <fe27d2f8-760b-c2d4-9474-7eaaae560086-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
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
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
Cc: Dave Airlie <airlied-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Maling list - DRI developers <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, amd-gfx mailing list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============1182414786==
Content-Type: multipart/alternative; boundary="001a114b2fe4742c020553fd00e0"

--001a114b2fe4742c020553fd00e0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 10, 2017 at 9:15 AM, Christian K=C3=B6nig <deathsimple@vodafone=
.de>
wrote:

> Am 10.07.2017 um 17:52 schrieb Jason Ekstrand:
>
> On Mon, Jul 10, 2017 at 8:45 AM, Christian K=C3=B6nig <deathsimple@vodafo=
ne.de>
> wrote:
>
>> Am 10.07.2017 um 17:28 schrieb Jason Ekstrand:
>>
>> On Wed, Jul 5, 2017 at 6:04 PM, Dave Airlie <airlied-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
>> [SNIP]
>> So, reading some CTS tests again, and I think we have a problem here.
>> The Vulkan spec allows you to wait on a fence that is in the unsignaled
>> state.
>>
>>
>> At least on the closed source driver that would be illegal as far as I
>> know.
>>
>
> Then they are doing workarounds in userspace.  There are definitely CTS
> tests for this:
>
> https://github.com/KhronosGroup/VK-GL-CTS/blob/master/external/vulkancts/
> modules/vulkan/synchronization/vktSynchronizationBasicFenceTests.cpp#L74
>
>
>> You can't wait on a semaphore before the signal operation is send down t=
o
>> the kerel.
>>
>
> We (Intel) deal with this today by tracking whether or not the fence has
> been submitted and using a condition variable in userspace to sort it all
> out.
>
>
> Which sounds exactly like what AMD is doing in it's drivers as well.
>

Which doesn't work cross-process so...

> If we ever want to share fences across processes (which we do), then this
> needs to be sorted in the kernel.
>
>
> That would clearly get a NAK from my side, even Microsoft forbids wait
> before signal because you can easily end up in deadlock situations.
>

Please don't NAK things that are required by the API specification and CTS
tests.  That makes it very hard for people like me to get their jobs done.
:-)

Now, as for whether or not it's a good idea.  First off, we do have
timeouts an a status querying mechanism so an application can just set a
timeout of 1s and do something if it times out.  Second, if the application
is a compositor or something else that doesn't trust its client, it
shouldn't be using the OPAQUE_FD mechanism of Vulkan semaphore/fence
sharing anyway.  For those scenarios, they can require the untrusted client
to use FENCE_FD (sync file) and they have all of the usual guarantees about
when the work got submitted, etc.

Also, I'm more than happy to put this all behind a flag so it's not the
default behavior.

--Jason

--001a114b2fe4742c020553fd00e0
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><div class=3D"gmail_quote">On M=
on, Jul 10, 2017 at 9:15 AM, Christian K=C3=B6nig <span dir=3D"ltr">&lt;<a =
href=3D"mailto:deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org" target=3D"_blank">deathsimple@vodaf=
one.de</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"=
margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
 =20
   =20
 =20
  <div text=3D"#000000" bgcolor=3D"#FFFFFF"><span class=3D"">
    <div class=3D"m_-3527794384181374639moz-cite-prefix">Am 10.07.2017 um 1=
7:52 schrieb Jason
      Ekstrand:<br>
    </div>
    </span><blockquote type=3D"cite">
      <div dir=3D"ltr">
        <div class=3D"gmail_extra">
          <div class=3D"gmail_quote"><span class=3D"">On Mon, Jul 10, 2017 =
at 8:45 AM,
            Christian K=C3=B6nig <span dir=3D"ltr">&lt;<a href=3D"mailto:de=
athsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org" target=3D"_blank">deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org</a>&gt;</s=
pan>
            wrote:<br>
            </span><blockquote class=3D"gmail_quote" style=3D"margin:0px 0p=
x 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
              <div bgcolor=3D"#FFFFFF">
                <div>
                  <div class=3D"m_-3527794384181374639gmail-h5"><span class=
=3D"">
                    <div class=3D"m_-3527794384181374639gmail-m_-2268556811=
58848481moz-cite-prefix">Am
                      10.07.2017 um 17:28 schrieb Jason Ekstrand:<br>
                    </div>
                    </span><blockquote type=3D"cite">
                      <div dir=3D"ltr">
                        <div class=3D"gmail_extra">
                          <div class=3D"gmail_quote"><span class=3D"">On We=
d, Jul 5, 2017
                            at 6:04 PM, Dave Airlie <span dir=3D"ltr">&lt;<=
a href=3D"mailto:airlied-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" target=3D"_blank">airlied-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>=
&gt;</span>
                            wrote:<br></span>
                            [SNIP]<span class=3D""><br>
                            <div>So, reading some CTS tests again, and I
                              think we have a problem here.=C2=A0 The Vulka=
n
                              spec allows you to wait on a fence that is
                              in the unsignaled state.</div>
                          </span></div>
                        </div>
                      </div>
                    </blockquote>
                    <br>
                  </div>
                </div><span class=3D"">
                At least on the closed source driver that would be
                illegal as far as I know.<br>
              </span></div>
            </blockquote><span class=3D"">
            <div><br>
            </div>
            <div>Then they are doing workarounds in userspace.=C2=A0 There
              are definitely CTS tests for this:<br>
              <br>
              <a href=3D"https://github.com/KhronosGroup/VK-GL-CTS/blob/mas=
ter/external/vulkancts/modules/vulkan/synchronization/vktSynchronizationBas=
icFenceTests.cpp#L74" target=3D"_blank">https://github.com/<wbr>KhronosGrou=
p/VK-GL-CTS/blob/<wbr>master/external/vulkancts/<wbr>modules/vulkan/<wbr>sy=
nchronization/<wbr>vktSynchronizationBasicFenceTe<wbr>sts.cpp#L74</a><br>
            </div>
            <div>=C2=A0</div>
            <blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0=
.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
              <div> You can&#39;t wait on a semaphore before the signal
                operation is send down to the kerel.</div>
            </blockquote>
            <div><br>
            </div>
            <div>We (Intel) deal with this today by tracking whether or
              not the fence has been submitted and using a condition
              variable in userspace to sort it all out.</div>
          </span></div>
        </div>
      </div>
    </blockquote>
    <br>
    Which sounds exactly like what AMD is doing in it&#39;s drivers as well=
.<span class=3D""><br></span></div></blockquote><div><br></div><div>Which d=
oesn&#39;t work cross-process so... <br></div><blockquote class=3D"gmail_qu=
ote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex=
"><div text=3D"#000000" bgcolor=3D"#FFFFFF"><span class=3D"">
    <blockquote type=3D"cite">
      <div dir=3D"ltr">
        <div class=3D"gmail_extra">
          <div class=3D"gmail_quote">
            <div>If we ever want to share fences across processes (which
              we do), then this needs to be sorted in the kernel. </div>
          </div>
        </div>
      </div>
    </blockquote>
    <br></span>
    That would clearly get a NAK from my side, even Microsoft forbids
    wait before signal because you can easily end up in deadlock
    situations.<br>
  </div>

</blockquote></div><br></div><div class=3D"gmail_extra">Please don&#39;t NA=
K things that are required by the API specification and CTS tests.=C2=A0 Th=
at makes it very hard for people like me to get their jobs done. :-)<br><br=
></div><div class=3D"gmail_extra">Now, as for whether or not it&#39;s a goo=
d idea.=C2=A0 First off, we do have timeouts an a status querying mechanism=
 so an application can just set a timeout of 1s and do something if it time=
s out.=C2=A0 Second, if the application is a compositor or something else t=
hat doesn&#39;t trust its client, it shouldn&#39;t be using the OPAQUE_FD m=
echanism of Vulkan semaphore/fence sharing anyway.=C2=A0 For those scenario=
s, they can require the untrusted client to use FENCE_FD (sync file) and th=
ey have all of the usual guarantees about when the work got submitted, etc.=
<br><br></div><div class=3D"gmail_extra">Also, I&#39;m more than happy to p=
ut this all behind a flag so it&#39;s not the default behavior.<br><br></di=
v><div class=3D"gmail_extra">--Jason<br></div></div>

--001a114b2fe4742c020553fd00e0--

--===============1182414786==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1182414786==--
