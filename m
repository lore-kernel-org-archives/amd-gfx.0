From: =?UTF-8?Q?Christian_K=c3=b6nig?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
Subject: Re: [PATCH] drm/syncobj: add sync obj wait interface. (v6)
Date: Mon, 10 Jul 2017 18:15:38 +0200
Message-ID: <fe27d2f8-760b-c2d4-9474-7eaaae560086@vodafone.de>
References: <20170706010409.9373-1-airlied@gmail.com>
 <CAOFGe94mA9i7+-XTJQn65N-vK_GbQwvjru2b=6ucXejpWWmx4g@mail.gmail.com>
 <899f9bb3-f7c7-ce86-c22b-bb8d262778bf@vodafone.de>
 <CAOFGe96gaX2OjsXr8bNBUiqwyKAQfMSycH7PXgYAt_BBJ1UHkQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1847800320=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CAOFGe96gaX2OjsXr8bNBUiqwyKAQfMSycH7PXgYAt_BBJ1UHkQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
To: Jason Ekstrand <jason-fQELhIk9awXprZlt/sZkLg@public.gmane.org>
Cc: Dave Airlie <airlied-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Maling list - DRI developers <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, amd-gfx mailing list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

This is a multi-part message in MIME format.
--===============1847800320==
Content-Type: multipart/alternative;
 boundary="------------EE062E88A58BF11D5444B67C"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------EE062E88A58BF11D5444B67C
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 10.07.2017 um 17:52 schrieb Jason Ekstrand:
> On Mon, Jul 10, 2017 at 8:45 AM, Christian König 
> <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org <mailto:deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>> wrote:
>
>     Am 10.07.2017 um 17:28 schrieb Jason Ekstrand:
>>     On Wed, Jul 5, 2017 at 6:04 PM, Dave Airlie <airlied-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
>>     <mailto:airlied-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>> wrote:
>>     [SNIP]
>>     So, reading some CTS tests again, and I think we have a problem
>>     here.  The Vulkan spec allows you to wait on a fence that is in
>>     the unsignaled state.
>
>     At least on the closed source driver that would be illegal as far
>     as I know.
>
>
> Then they are doing workarounds in userspace.  There are definitely 
> CTS tests for this:
>
> https://github.com/KhronosGroup/VK-GL-CTS/blob/master/external/vulkancts/modules/vulkan/synchronization/vktSynchronizationBasicFenceTests.cpp#L74
>
>     You can't wait on a semaphore before the signal operation is send
>     down to the kerel.
>
>
> We (Intel) deal with this today by tracking whether or not the fence 
> has been submitted and using a condition variable in userspace to sort 
> it all out.

Which sounds exactly like what AMD is doing in it's drivers as well.

> If we ever want to share fences across processes (which we do), then 
> this needs to be sorted in the kernel.

That would clearly get a NAK from my side, even Microsoft forbids wait 
before signal because you can easily end up in deadlock situations.

Regards,
Christian.

--------------EE062E88A58BF11D5444B67C
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <div class="moz-cite-prefix">Am 10.07.2017 um 17:52 schrieb Jason
      Ekstrand:<br>
    </div>
    <blockquote type="cite"
cite="mid:CAOFGe96gaX2OjsXr8bNBUiqwyKAQfMSycH7PXgYAt_BBJ1UHkQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org">
      <div dir="ltr">
        <div class="gmail_extra">
          <div class="gmail_quote">On Mon, Jul 10, 2017 at 8:45 AM,
            Christian König <span dir="ltr">&lt;<a
                href="mailto:deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org" target="_blank"
                moz-do-not-send="true">deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org</a>&gt;</span>
            wrote:<br>
            <blockquote class="gmail_quote" style="margin:0px 0px 0px
              0.8ex;border-left:1px solid
              rgb(204,204,204);padding-left:1ex">
              <div bgcolor="#FFFFFF">
                <div>
                  <div class="gmail-h5">
                    <div
                      class="gmail-m_-226855681158848481moz-cite-prefix">Am
                      10.07.2017 um 17:28 schrieb Jason Ekstrand:<br>
                    </div>
                    <blockquote type="cite">
                      <div dir="ltr">
                        <div class="gmail_extra">
                          <div class="gmail_quote">On Wed, Jul 5, 2017
                            at 6:04 PM, Dave Airlie <span dir="ltr">&lt;<a
                                href="mailto:airlied-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org"
                                target="_blank" moz-do-not-send="true">airlied-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt;</span>
                            wrote:<br>
                            [SNIP]<br>
                            <div>So, reading some CTS tests again, and I
                              think we have a problem here.  The Vulkan
                              spec allows you to wait on a fence that is
                              in the unsignaled state.</div>
                          </div>
                        </div>
                      </div>
                    </blockquote>
                    <br>
                  </div>
                </div>
                At least on the closed source driver that would be
                illegal as far as I know.<br>
              </div>
            </blockquote>
            <div><br>
            </div>
            <div>Then they are doing workarounds in userspace.  There
              are definitely CTS tests for this:<br>
              <br>
              <a
href="https://github.com/KhronosGroup/VK-GL-CTS/blob/master/external/vulkancts/modules/vulkan/synchronization/vktSynchronizationBasicFenceTests.cpp#L74"
                moz-do-not-send="true">https://github.com/KhronosGroup/VK-GL-CTS/blob/master/external/vulkancts/modules/vulkan/synchronization/vktSynchronizationBasicFenceTests.cpp#L74</a><br>
            </div>
            <div> </div>
            <blockquote class="gmail_quote" style="margin:0px 0px 0px
              0.8ex;border-left:1px solid
              rgb(204,204,204);padding-left:1ex">
              <div> You can't wait on a semaphore before the signal
                operation is send down to the kerel.</div>
            </blockquote>
            <div><br>
            </div>
            <div>We (Intel) deal with this today by tracking whether or
              not the fence has been submitted and using a condition
              variable in userspace to sort it all out.</div>
          </div>
        </div>
      </div>
    </blockquote>
    <br>
    Which sounds exactly like what AMD is doing in it's drivers as well.<br>
    <br>
    <blockquote type="cite"
cite="mid:CAOFGe96gaX2OjsXr8bNBUiqwyKAQfMSycH7PXgYAt_BBJ1UHkQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org">
      <div dir="ltr">
        <div class="gmail_extra">
          <div class="gmail_quote">
            <div>If we ever want to share fences across processes (which
              we do), then this needs to be sorted in the kernel. </div>
          </div>
        </div>
      </div>
    </blockquote>
    <br>
    That would clearly get a NAK from my side, even Microsoft forbids
    wait before signal because you can easily end up in deadlock
    situations.<br>
    <br>
    Regards,<br>
    Christian.<br>
  </body>
</html>

--------------EE062E88A58BF11D5444B67C--

--===============1847800320==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1847800320==--
