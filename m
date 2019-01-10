From: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH libdrm] amdgpu: add a faster BO list API
Date: Thu, 10 Jan 2019 07:25:26 -0500
Message-ID: <CAAxE2A5C9mDY_v_v9dHsF2w2JMvj5i66Eam_6=Btov_bc05CeQ@mail.gmail.com>
References: <20190107193104.4361-1-maraeo@gmail.com>
 <a0a15ed6-eb1a-fbbe-7c1b-e3b9a64c1008@gmail.com>
 <CAAxE2A5M2WW6uPFo0a=+6ukbtgx5xHfkKUKOB9dgtB=qH88htQ@mail.gmail.com>
 <513ee137-7e99-c8fc-9e3b-e9077ead60a3@gmail.com>
 <CAAxE2A5WYWCWAPA0K+vYDirtT6BV7QJoZSbEhh0Z57OF860mWQ@mail.gmail.com>
 <7f85afd6-b17b-1c50-ba03-c03dd6e9a362@gmail.com>
 <CAAxE2A5RjR=+2Rs5HDx1rV0ftdkZJX=6TQDkvRQSxfo++vnXOA@mail.gmail.com>
 <e23ecf17-dbd4-ecef-f8fc-4dc849e7bddf@amd.com>
 <CAAxE2A6z_LLzzsLqsBtLyXcFTsLG_8FQc7=oN2p_nLJGoXbmgg@mail.gmail.com>
 <7544c927-8b1f-c7d0-dd9d-21311ffca542@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1543906866=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <7544c927-8b1f-c7d0-dd9d-21311ffca542-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
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
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>
Cc: amd-gfx mailing list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============1543906866==
Content-Type: multipart/alternative; boundary="000000000000239618057f19ade9"

--000000000000239618057f19ade9
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 10, 2019, 6:51 AM Christian K=C3=B6nig <
ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org wrote:

> Am 10.01.19 um 12:41 schrieb Marek Ol=C5=A1=C3=A1k:
>
>
>
> On Thu, Jan 10, 2019, 4:15 AM Koenig, Christian <Christian.Koenig-5C7GfCeVMHo@public.gmane.org
> wrote:
>
>> Am 10.01.19 um 00:39 schrieb Marek Ol=C5=A1=C3=A1k:
>>
>> On Wed, Jan 9, 2019 at 1:41 PM Christian K=C3=B6nig <
>> ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
>>
>>> Am 09.01.19 um 17:14 schrieb Marek Ol=C5=A1=C3=A1k:
>>>
>>> On Wed, Jan 9, 2019 at 8:09 AM Christian K=C3=B6nig <
>>> ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
>>>
>>>> Am 09.01.19 um 13:36 schrieb Marek Ol=C5=A1=C3=A1k:
>>>>
>>>>
>>>>
>>>> On Wed, Jan 9, 2019, 5:28 AM Christian K=C3=B6nig <
>>>> ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org wrote:
>>>>
>>>>> Looks good, but I'm wondering what's the actual improvement?
>>>>>
>>>>
>>>> No malloc calls and 1 less for loop copying the bo list.
>>>>
>>>>
>>>> Yeah, but didn't we want to get completely rid of the bo list?
>>>>
>>>
>>> If we have multiple IBs (e.g. gfx + compute) that share a BO list, I
>>> think it's faster to send the BO list to the kernel only once.
>>>
>>>
>>> That's not really faster.
>>>
>>> The only thing we safe us is a single loop over all BOs to lockup the
>>> handle into a pointer and that is only a tiny fraction of the overhead.
>>>
>>> The majority of the overhead is locking the BOs and reserving space for
>>> the submission.
>>>
>>> What could really help here is to submit gfx+comput together in just on=
e
>>> CS IOCTL. This way we would need the locking and space reservation only
>>> once.
>>>
>>> It's a bit of work in the kernel side, but certainly doable.
>>>
>>
>> OK. Any objections to this patch?
>>
>>
>> In general I'm wondering if we couldn't avoid adding so much new
>> interface.
>>
>
> There are Vulkan drivers that still use the bo_list interface.
>
>
>> For example we can avoid the malloc() when we just cache the last freed
>> bo_list structure in the device. We would just need an atomic pointer
>> exchange operation for that.
>>
>
>> This way we even don't need to change mesa at all.
>>
>
> There is still the for loop that we need to get rid of.
>
>
> Yeah, but that I'm fine to handle with a amdgpu_bo_list_create_raw which
> only takes the handles and still returns the amdgpu_bo_list structure we
> are used to.
>
> See what I'm mostly concerned about is having another CS function to
> maintain.
>

There is no maintenance cost. It's just a wrapper. Eventually all drivers
will switch to it.

Marek


>
>
>> Regarding optimization, this chunk can be replaced by a cast on 64bit:
>>
>> +	chunk_array =3D alloca(sizeof(uint64_t) * num_chunks);
>> +	for (i =3D 0; i < num_chunks; i++)
>> +		chunk_array[i] =3D (uint64_t)(uintptr_t)&chunks[i];
>>
>> It can't. The input is an array of structures. The ioctl takes an array
> of pointers.
>
>
> Ah! Haven't seen this, sorry for the noise.
>
> Christian.
>
>
> Marek
>
>
>> Regards,
>> Christian.
>>
>>
>> Thanks,
>> Marek
>>
>>
>>
> _______________________________________________
> amd-gfx mailing listamd-gfx-PD4FTy7X32lNgt0PjOBp934avgP/u3fG0wdF1cv0I5s@public.gmane.org://lists.freedeskto=
p.org/mailman/listinfo/amd-gfx
>
>
>

--000000000000239618057f19ade9
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr">=
On Thu, Jan 10, 2019, 6:51 AM Christian K=C3=B6nig &lt;<a href=3D"mailto:ck=
oenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org">ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a> wrote:=
<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;bord=
er-left:1px #ccc solid;padding-left:1ex">
 =20
   =20
 =20
  <div text=3D"#000000" bgcolor=3D"#FFFFFF">
    <div class=3D"m_-6120466974339202476moz-cite-prefix">Am 10.01.19 um 12:=
41 schrieb Marek
      Ol=C5=A1=C3=A1k:<br>
    </div>
    <blockquote type=3D"cite">
     =20
      <div dir=3D"auto">
        <div><br>
          <br>
          <div class=3D"gmail_quote">
            <div dir=3D"ltr">On Thu, Jan 10, 2019, 4:15 AM Koenig,
              Christian &lt;<a href=3D"mailto:Christian.Koenig-5C7GfCeVMHo@public.gmane.org" tar=
get=3D"_blank" rel=3D"noreferrer">Christian.Koenig-5C7GfCeVMHo@public.gmane.org</a>
              wrote:<br>
            </div>
            <blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;bo=
rder-left:1px #ccc solid;padding-left:1ex">
              <div text=3D"#000000" bgcolor=3D"#FFFFFF">
                <div class=3D"m_-6120466974339202476m_-4107032735876451030m=
oz-cite-prefix">Am
                  10.01.19 um 00:39 schrieb Marek Ol=C5=A1=C3=A1k:<br>
                </div>
                <blockquote type=3D"cite">
                  <div dir=3D"ltr">
                    <div class=3D"gmail_quote">
                      <div dir=3D"ltr">On Wed, Jan 9, 2019 at 1:41 PM
                        Christian K=C3=B6nig &lt;<a href=3D"mailto:ckoenig.=
leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" rel=3D"noreferrer noreferrer" target=3D"_blank">c=
koenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt;
                        wrote:<br>
                      </div>
                      <blockquote class=3D"gmail_quote" style=3D"margin:0px=
 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
                        <div bgcolor=3D"#FFFFFF">
                          <div class=3D"m_-6120466974339202476m_-4107032735=
876451030gmail-m_-7810855682144448022moz-cite-prefix">Am
                            09.01.19 um 17:14 schrieb Marek Ol=C5=A1=C3=A1k=
:<br>
                          </div>
                          <blockquote type=3D"cite">
                            <div dir=3D"ltr">
                              <div dir=3D"ltr">
                                <div class=3D"gmail_quote">
                                  <div dir=3D"ltr">On Wed, Jan 9, 2019 at
                                    8:09 AM Christian K=C3=B6nig &lt;<a hre=
f=3D"mailto:ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" rel=3D"noreferrer noreferrer"=
 target=3D"_blank">ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt;
                                    wrote:<br>
                                  </div>
                                  <blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">
                                    <div bgcolor=3D"#FFFFFF">
                                      <div class=3D"m_-6120466974339202476m=
_-4107032735876451030gmail-m_-7810855682144448022m_8930908994027207900m_-73=
23258551939539738gmail-m_4443106390953893387gmail-m_-3252015337124169842moz=
-cite-prefix">Am
                                        09.01.19 um 13:36 schrieb Marek
                                        Ol=C5=A1=C3=A1k:<br>
                                      </div>
                                      <blockquote type=3D"cite">
                                        <div dir=3D"auto">
                                          <div><br>
                                            <br>
                                            <div class=3D"gmail_quote">
                                              <div dir=3D"ltr">On Wed, Jan
                                                9, 2019, 5:28 AM
                                                Christian K=C3=B6nig &lt;<a=
 href=3D"mailto:ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" rel=3D"noreferrer norefer=
rer" target=3D"_blank">ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>
                                                wrote:<br>
                                              </div>
                                              <blockquote class=3D"gmail_qu=
ote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,20=
4);padding-left:1ex">
                                                Looks good, but I&#39;m
                                                wondering what&#39;s the
                                                actual improvement?<br>
                                              </blockquote>
                                            </div>
                                          </div>
                                          <div dir=3D"auto"><br>
                                          </div>
                                          <div dir=3D"auto">No malloc
                                            calls and 1 less for loop
                                            copying the bo list.</div>
                                        </div>
                                      </blockquote>
                                      <br>
                                      Yeah, but didn&#39;t we want to get
                                      completely rid of the bo list?<br>
                                    </div>
                                  </blockquote>
                                  <div><br>
                                  </div>
                                  If we have multiple IBs (e.g. gfx +
                                  compute) that share a BO list, I think
                                  it&#39;s faster to send the BO list to th=
e
                                  kernel only once.</div>
                              </div>
                            </div>
                          </blockquote>
                          <br>
                          That&#39;s not really faster.<br>
                          <br>
                          The only thing we safe us is a single loop
                          over all BOs to lockup the handle into a
                          pointer and that is only a tiny fraction of
                          the overhead.<br>
                          <br>
                          The majority of the overhead is locking the
                          BOs and reserving space for the submission.<br>
                          <br>
                          What could really help here is to submit
                          gfx+comput together in just one CS IOCTL. This
                          way we would need the locking and space
                          reservation only once.<br>
                          <br>
                          It&#39;s a bit of work in the kernel side, but
                          certainly doable.<br>
                        </div>
                      </blockquote>
                      <div><br>
                      </div>
                      <div>OK. Any objections to this patch?</div>
                    </div>
                  </div>
                </blockquote>
                <br>
                In general I&#39;m wondering if we couldn&#39;t avoid addin=
g so
                much new interface.<br>
              </div>
            </blockquote>
          </div>
        </div>
        <div dir=3D"auto"><br>
        </div>
        <div dir=3D"auto">There are Vulkan drivers that still use the
          bo_list interface.</div>
        <div dir=3D"auto"><br>
        </div>
        <div dir=3D"auto">
          <div class=3D"gmail_quote">
            <blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;bo=
rder-left:1px #ccc solid;padding-left:1ex">
              <div text=3D"#000000" bgcolor=3D"#FFFFFF">
                <br>
                For example we can avoid the malloc() when we just cache
                the last freed bo_list structure in the device. We would
                just need an atomic pointer exchange operation for that.</d=
iv>
            </blockquote>
          </div>
        </div>
        <div dir=3D"auto">
          <div class=3D"gmail_quote">
            <blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;bo=
rder-left:1px #ccc solid;padding-left:1ex">
              <div text=3D"#000000" bgcolor=3D"#FFFFFF">
                <br>
                This way we even don&#39;t need to change mesa at all.<br>
              </div>
            </blockquote>
          </div>
        </div>
        <div dir=3D"auto"><br>
        </div>
        <div dir=3D"auto">There is still the for loop that we need to get
          rid of.</div>
      </div>
    </blockquote>
    <br>
    Yeah, but that I&#39;m fine to handle with a amdgpu_bo_list_create_raw
    which only takes the handles and still returns the amdgpu_bo_list
    structure we are used to.<br>
    <br>
    See what I&#39;m mostly concerned about is having another CS function t=
o
    maintain.<br></div></blockquote></div></div><div dir=3D"auto"><br></div=
><div dir=3D"auto">There is no maintenance cost. It&#39;s just a wrapper. E=
ventually all drivers will switch to it.</div><div dir=3D"auto"><br></div><=
div dir=3D"auto">Marek</div><div dir=3D"auto"><br></div><div dir=3D"auto"><=
div class=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"margin=
:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><div text=3D"#0000=
00" bgcolor=3D"#FFFFFF">
    <br>
    <blockquote type=3D"cite">
      <div dir=3D"auto">
        <div dir=3D"auto"><br>
        </div>
        <div dir=3D"auto">
          <div class=3D"gmail_quote">
            <blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;bo=
rder-left:1px #ccc solid;padding-left:1ex">
              <div text=3D"#000000" bgcolor=3D"#FFFFFF">
                <br>
                Regarding optimization, this chunk can be replaced by a
                cast on 64bit:<br>
                <blockquote type=3D"cite">
                  <pre class=3D"m_-6120466974339202476m_-410703273587645103=
0moz-quote-pre">+	chunk_array =3D alloca(sizeof(uint64_t) * num_chunks);
+	for (i =3D 0; i &lt; num_chunks; i++)
+		chunk_array[i] =3D (uint64_t)(uintptr_t)&amp;chunks[i];</pre>
                </blockquote>
              </div>
            </blockquote>
          </div>
        </div>
        <div dir=3D"auto">It can&#39;t. The input is an array of structures=
.
          The ioctl takes an array of pointers.</div>
      </div>
    </blockquote>
    <br>
    Ah! Haven&#39;t seen this, sorry for the noise.<br>
    <br>
    Christian.<br>
    <br>
    <blockquote type=3D"cite">
      <div dir=3D"auto">
        <div dir=3D"auto"><br>
        </div>
        <div dir=3D"auto">Marek</div>
        <div dir=3D"auto"><br>
        </div>
        <div dir=3D"auto">
          <div class=3D"gmail_quote">
            <blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;bo=
rder-left:1px #ccc solid;padding-left:1ex">
              <div text=3D"#000000" bgcolor=3D"#FFFFFF">
                <blockquote type=3D"cite">
                </blockquote>
                <br>
                Regards,<br>
                Christian.<br>
                <br>
                <blockquote type=3D"cite">
                  <div dir=3D"ltr">
                    <div class=3D"gmail_quote">
                      <div><br>
                      </div>
                      <div>Thanks,<br>
                      </div>
                      <div>Marek</div>
                    </div>
                  </div>
                </blockquote>
                <br>
              </div>
            </blockquote>
          </div>
        </div>
      </div>
      <br>
      <fieldset class=3D"m_-6120466974339202476mimeAttachmentHeader"></fiel=
dset>
      <pre class=3D"m_-6120466974339202476moz-quote-pre">__________________=
_____________________________
amd-gfx mailing list
<a class=3D"m_-6120466974339202476moz-txt-link-abbreviated" href=3D"mailto:=
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" target=3D"_blank" rel=3D"noreferrer">amd-gfx=
@lists.freedesktop.org</a>
<a class=3D"m_-6120466974339202476moz-txt-link-freetext" href=3D"https://li=
sts.freedesktop.org/mailman/listinfo/amd-gfx" target=3D"_blank" rel=3D"nore=
ferrer">https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a>
</pre>
    </blockquote>
    <br>
  </div>

</blockquote></div></div></div>

--000000000000239618057f19ade9--

--===============1543906866==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1543906866==--
