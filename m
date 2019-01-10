From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH libdrm] amdgpu: add a faster BO list API
Date: Thu, 10 Jan 2019 12:51:03 +0100
Message-ID: <7544c927-8b1f-c7d0-dd9d-21311ffca542@gmail.com>
References: <20190107193104.4361-1-maraeo@gmail.com>
 <a0a15ed6-eb1a-fbbe-7c1b-e3b9a64c1008@gmail.com>
 <CAAxE2A5M2WW6uPFo0a=+6ukbtgx5xHfkKUKOB9dgtB=qH88htQ@mail.gmail.com>
 <513ee137-7e99-c8fc-9e3b-e9077ead60a3@gmail.com>
 <CAAxE2A5WYWCWAPA0K+vYDirtT6BV7QJoZSbEhh0Z57OF860mWQ@mail.gmail.com>
 <7f85afd6-b17b-1c50-ba03-c03dd6e9a362@gmail.com>
 <CAAxE2A5RjR=+2Rs5HDx1rV0ftdkZJX=6TQDkvRQSxfo++vnXOA@mail.gmail.com>
 <e23ecf17-dbd4-ecef-f8fc-4dc849e7bddf@amd.com>
 <CAAxE2A6z_LLzzsLqsBtLyXcFTsLG_8FQc7=oN2p_nLJGoXbmgg@mail.gmail.com>
Reply-To: christian.koenig-5C7GfCeVMHo@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0333486860=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CAAxE2A6z_LLzzsLqsBtLyXcFTsLG_8FQc7=oN2p_nLJGoXbmgg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
To: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "Koenig, Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>
Cc: amd-gfx mailing list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

This is a multi-part message in MIME format.
--===============0333486860==
Content-Type: multipart/alternative;
 boundary="------------DBE86E3B36B9FF9EC193D9B6"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------DBE86E3B36B9FF9EC193D9B6
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 10.01.19 um 12:41 schrieb Marek Olšák:
>
>
> On Thu, Jan 10, 2019, 4:15 AM Koenig, Christian 
> <Christian.Koenig-5C7GfCeVMHo@public.gmane.org <mailto:Christian.Koenig-5C7GfCeVMHo@public.gmane.org> wrote:
>
>     Am 10.01.19 um 00:39 schrieb Marek Olšák:
>>     On Wed, Jan 9, 2019 at 1:41 PM Christian König
>>     <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
>>     <mailto:ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>> wrote:
>>
>>         Am 09.01.19 um 17:14 schrieb Marek Olšák:
>>>         On Wed, Jan 9, 2019 at 8:09 AM Christian König
>>>         <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
>>>         <mailto:ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>> wrote:
>>>
>>>             Am 09.01.19 um 13:36 schrieb Marek Olšák:
>>>>
>>>>
>>>>             On Wed, Jan 9, 2019, 5:28 AM Christian König
>>>>             <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
>>>>             <mailto:ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
>>>>
>>>>                 Looks good, but I'm wondering what's the actual
>>>>                 improvement?
>>>>
>>>>
>>>>             No malloc calls and 1 less for loop copying the bo list.
>>>
>>>             Yeah, but didn't we want to get completely rid of the bo
>>>             list?
>>>
>>>
>>>         If we have multiple IBs (e.g. gfx + compute) that share a BO
>>>         list, I think it's faster to send the BO list to the kernel
>>>         only once.
>>
>>         That's not really faster.
>>
>>         The only thing we safe us is a single loop over all BOs to
>>         lockup the handle into a pointer and that is only a tiny
>>         fraction of the overhead.
>>
>>         The majority of the overhead is locking the BOs and reserving
>>         space for the submission.
>>
>>         What could really help here is to submit gfx+comput together
>>         in just one CS IOCTL. This way we would need the locking and
>>         space reservation only once.
>>
>>         It's a bit of work in the kernel side, but certainly doable.
>>
>>
>>     OK. Any objections to this patch?
>
>     In general I'm wondering if we couldn't avoid adding so much new
>     interface.
>
>
> There are Vulkan drivers that still use the bo_list interface.
>
>
>     For example we can avoid the malloc() when we just cache the last
>     freed bo_list structure in the device. We would just need an
>     atomic pointer exchange operation for that.
>
>
>     This way we even don't need to change mesa at all.
>
>
> There is still the for loop that we need to get rid of.

Yeah, but that I'm fine to handle with a amdgpu_bo_list_create_raw which 
only takes the handles and still returns the amdgpu_bo_list structure we 
are used to.

See what I'm mostly concerned about is having another CS function to 
maintain.

>
>
>     Regarding optimization, this chunk can be replaced by a cast on 64bit:
>>     +	chunk_array = alloca(sizeof(uint64_t) * num_chunks);
>>     +	for (i = 0; i < num_chunks; i++)
>>     +		chunk_array[i] = (uint64_t)(uintptr_t)&chunks[i];
>
> It can't. The input is an array of structures. The ioctl takes an 
> array of pointers.

Ah! Haven't seen this, sorry for the noise.

Christian.

>
> Marek
>
>
>     Regards,
>     Christian.
>
>>
>>     Thanks,
>>     Marek
>
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx


--------------DBE86E3B36B9FF9EC193D9B6
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <div class="moz-cite-prefix">Am 10.01.19 um 12:41 schrieb Marek
      Olšák:<br>
    </div>
    <blockquote type="cite"
cite="mid:CAAxE2A6z_LLzzsLqsBtLyXcFTsLG_8FQc7=oN2p_nLJGoXbmgg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org">
      <meta http-equiv="content-type" content="text/html; charset=UTF-8">
      <div dir="auto">
        <div><br>
          <br>
          <div class="gmail_quote">
            <div dir="ltr">On Thu, Jan 10, 2019, 4:15 AM Koenig,
              Christian &lt;<a href="mailto:Christian.Koenig-5C7GfCeVMHo@public.gmane.org"
                moz-do-not-send="true">Christian.Koenig-5C7GfCeVMHo@public.gmane.org</a>
              wrote:<br>
            </div>
            <blockquote class="gmail_quote" style="margin:0 0 0
              .8ex;border-left:1px #ccc solid;padding-left:1ex">
              <div text="#000000" bgcolor="#FFFFFF">
                <div class="m_-4107032735876451030moz-cite-prefix">Am
                  10.01.19 um 00:39 schrieb Marek Olšák:<br>
                </div>
                <blockquote type="cite">
                  <div dir="ltr">
                    <div class="gmail_quote">
                      <div dir="ltr">On Wed, Jan 9, 2019 at 1:41 PM
                        Christian König &lt;<a
                          href="mailto:ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org"
                          target="_blank" rel="noreferrer"
                          moz-do-not-send="true">ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt;
                        wrote:<br>
                      </div>
                      <blockquote class="gmail_quote" style="margin:0px
                        0px 0px 0.8ex;border-left:1px solid
                        rgb(204,204,204);padding-left:1ex">
                        <div bgcolor="#FFFFFF">
                          <div
class="m_-4107032735876451030gmail-m_-7810855682144448022moz-cite-prefix">Am
                            09.01.19 um 17:14 schrieb Marek Olšák:<br>
                          </div>
                          <blockquote type="cite">
                            <div dir="ltr">
                              <div dir="ltr">
                                <div class="gmail_quote">
                                  <div dir="ltr">On Wed, Jan 9, 2019 at
                                    8:09 AM Christian König &lt;<a
                                      href="mailto:ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org"
                                      target="_blank" rel="noreferrer"
                                      moz-do-not-send="true">ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt;
                                    wrote:<br>
                                  </div>
                                  <blockquote class="gmail_quote"
                                    style="margin:0px 0px 0px
                                    0.8ex;border-left:1px solid
                                    rgb(204,204,204);padding-left:1ex">
                                    <div bgcolor="#FFFFFF">
                                      <div
class="m_-4107032735876451030gmail-m_-7810855682144448022m_8930908994027207900m_-7323258551939539738gmail-m_4443106390953893387gmail-m_-3252015337124169842moz-cite-prefix">Am
                                        09.01.19 um 13:36 schrieb Marek
                                        Olšák:<br>
                                      </div>
                                      <blockquote type="cite">
                                        <div dir="auto">
                                          <div><br>
                                            <br>
                                            <div class="gmail_quote">
                                              <div dir="ltr">On Wed, Jan
                                                9, 2019, 5:28 AM
                                                Christian König &lt;<a
                                                  href="mailto:ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org"
                                                  target="_blank"
                                                  rel="noreferrer"
                                                  moz-do-not-send="true">ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>
                                                wrote:<br>
                                              </div>
                                              <blockquote
                                                class="gmail_quote"
                                                style="margin:0px 0px
                                                0px
                                                0.8ex;border-left:1px
                                                solid
                                                rgb(204,204,204);padding-left:1ex">
                                                Looks good, but I'm
                                                wondering what's the
                                                actual improvement?<br>
                                              </blockquote>
                                            </div>
                                          </div>
                                          <div dir="auto"><br>
                                          </div>
                                          <div dir="auto">No malloc
                                            calls and 1 less for loop
                                            copying the bo list.</div>
                                        </div>
                                      </blockquote>
                                      <br>
                                      Yeah, but didn't we want to get
                                      completely rid of the bo list?<br>
                                    </div>
                                  </blockquote>
                                  <div><br>
                                  </div>
                                  If we have multiple IBs (e.g. gfx +
                                  compute) that share a BO list, I think
                                  it's faster to send the BO list to the
                                  kernel only once.</div>
                              </div>
                            </div>
                          </blockquote>
                          <br>
                          That's not really faster.<br>
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
                          It's a bit of work in the kernel side, but
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
                In general I'm wondering if we couldn't avoid adding so
                much new interface.<br>
              </div>
            </blockquote>
          </div>
        </div>
        <div dir="auto"><br>
        </div>
        <div dir="auto">There are Vulkan drivers that still use the
          bo_list interface.</div>
        <div dir="auto"><br>
        </div>
        <div dir="auto">
          <div class="gmail_quote">
            <blockquote class="gmail_quote" style="margin:0 0 0
              .8ex;border-left:1px #ccc solid;padding-left:1ex">
              <div text="#000000" bgcolor="#FFFFFF">
                <br>
                For example we can avoid the malloc() when we just cache
                the last freed bo_list structure in the device. We would
                just need an atomic pointer exchange operation for that.</div>
            </blockquote>
          </div>
        </div>
        <div dir="auto">
          <div class="gmail_quote">
            <blockquote class="gmail_quote" style="margin:0 0 0
              .8ex;border-left:1px #ccc solid;padding-left:1ex">
              <div text="#000000" bgcolor="#FFFFFF">
                <br>
                This way we even don't need to change mesa at all.<br>
              </div>
            </blockquote>
          </div>
        </div>
        <div dir="auto"><br>
        </div>
        <div dir="auto">There is still the for loop that we need to get
          rid of.</div>
      </div>
    </blockquote>
    <br>
    Yeah, but that I'm fine to handle with a amdgpu_bo_list_create_raw
    which only takes the handles and still returns the amdgpu_bo_list
    structure we are used to.<br>
    <br>
    See what I'm mostly concerned about is having another CS function to
    maintain.<br>
    <br>
    <blockquote type="cite"
cite="mid:CAAxE2A6z_LLzzsLqsBtLyXcFTsLG_8FQc7=oN2p_nLJGoXbmgg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org">
      <div dir="auto">
        <div dir="auto"><br>
        </div>
        <div dir="auto">
          <div class="gmail_quote">
            <blockquote class="gmail_quote" style="margin:0 0 0
              .8ex;border-left:1px #ccc solid;padding-left:1ex">
              <div text="#000000" bgcolor="#FFFFFF">
                <br>
                Regarding optimization, this chunk can be replaced by a
                cast on 64bit:<br>
                <blockquote type="cite">
                  <pre class="m_-4107032735876451030moz-quote-pre">+	chunk_array = alloca(sizeof(uint64_t) * num_chunks);
+	for (i = 0; i &lt; num_chunks; i++)
+		chunk_array[i] = (uint64_t)(uintptr_t)&amp;chunks[i];</pre>
                </blockquote>
              </div>
            </blockquote>
          </div>
        </div>
        <div dir="auto">It can't. The input is an array of structures.
          The ioctl takes an array of pointers.</div>
      </div>
    </blockquote>
    <br>
    Ah! Haven't seen this, sorry for the noise.<br>
    <br>
    Christian.<br>
    <br>
    <blockquote type="cite"
cite="mid:CAAxE2A6z_LLzzsLqsBtLyXcFTsLG_8FQc7=oN2p_nLJGoXbmgg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org">
      <div dir="auto">
        <div dir="auto"><br>
        </div>
        <div dir="auto">Marek</div>
        <div dir="auto"><br>
        </div>
        <div dir="auto">
          <div class="gmail_quote">
            <blockquote class="gmail_quote" style="margin:0 0 0
              .8ex;border-left:1px #ccc solid;padding-left:1ex">
              <div text="#000000" bgcolor="#FFFFFF">
                <blockquote type="cite">
                </blockquote>
                <br>
                Regards,<br>
                Christian.<br>
                <br>
                <blockquote type="cite">
                  <div dir="ltr">
                    <div class="gmail_quote">
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
      <fieldset class="mimeAttachmentHeader"></fieldset>
      <pre class="moz-quote-pre" wrap="">_______________________________________________
amd-gfx mailing list
<a class="moz-txt-link-abbreviated" href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a>
<a class="moz-txt-link-freetext" href="https://lists.freedesktop.org/mailman/listinfo/amd-gfx">https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a>
</pre>
    </blockquote>
    <br>
  </body>
</html>

--------------DBE86E3B36B9FF9EC193D9B6--

--===============0333486860==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0333486860==--
