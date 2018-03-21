From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 1/2] drm/amdgpu: Enable scatter gather display support
Date: Wed, 21 Mar 2018 15:07:22 +0100
Message-ID: <d2786617-d81f-e448-3cba-6f7dfeb521dc@amd.com>
References: <1520033110-29964-1-git-send-email-Samuel.Li@amd.com>
 <BN6PR12MB180952A68A8AF256197D1177F7D40@BN6PR12MB1809.namprd12.prod.outlook.com>
 <BN6PR12MB1809A2A1591C19CC6E0C952FF7D40@BN6PR12MB1809.namprd12.prod.outlook.com>
 <CAAxE2A4V0=1w_aybBq0dXc3w+D=eJR-dY7Tq=7g3rnj94OY7XQ@mail.gmail.com>
 <BY1PR12MB050483D06AA7D7B08247B1D0F5D40@BY1PR12MB0504.namprd12.prod.outlook.com>
 <CADnq5_O0p30CC0JAnqvrrspXapdN5ZpXGBChGmt+14ekmPHkQw@mail.gmail.com>
 <CAAxE2A4fiM5KjfxOSTTT3Soew8S-EGE7OVWBh-7565+rahMaOg@mail.gmail.com>
 <13996c5e-dc4c-5a9a-b6c3-7fe6bb63ec5d@gmail.com>
 <CAAxE2A7ffe2fkOQG0mFpPfP4uRKZ1BVTKWQ3Q+FhLWQnYU4nww@mail.gmail.com>
 <f7bce36e-d9c6-dc13-6b1f-0e2bf91aaff0@gmail.com>
 <DM5PR12MB18205326885F0857CEC4FAA6F7AB0@DM5PR12MB1820.namprd12.prod.outlook.com>
 <7bbc4bc8-1b44-efc3-44b7-47ebcb4b9c76@amd.com>
 <CAAxE2A4gcwdGiApoh=sa-SMPtMpm6M2+LmvafhVVnW=kntPPKw@mail.gmail.com>
 <f1171a12-3092-6690-d6ae-c5e9869bce96@gmail.com>
 <CAAxE2A6xdScLAcuu3SpdnsJi-qJFr16BDxgYLvimFg1o8cNmpg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0803653836=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CAAxE2A6xdScLAcuu3SpdnsJi-qJFr16BDxgYLvimFg1o8cNmpg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
To: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>, Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>, "Li,
 Samuel" <Samuel.Li-5C7GfCeVMHo@public.gmane.org>, amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

This is a multi-part message in MIME format.
--===============0803653836==
Content-Type: multipart/alternative;
 boundary="------------9228CDE03D047F244AE03FEF"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------9228CDE03D047F244AE03FEF
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 21.03.2018 um 14:57 schrieb Marek Olšák:
> On Wed, Mar 21, 2018 at 4:13 AM, Christian König 
> <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org 
> <mailto:ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>> wrote:
>
>     Am 21.03.2018 um 06:08 schrieb Marek Olšák:
>>     On Tue, Mar 20, 2018 at 4:16 PM, Christian König
>>     <christian.koenig-5C7GfCeVMHo@public.gmane.org <mailto:christian.koenig-5C7GfCeVMHo@public.gmane.org>> wrote:
>>
>>         That's what I meant with use up the otherwise unused VRAM. I
>>         don't see any disadvantage of always setting GTT as second
>>         domain on APUs.
>>
>>         My assumption was that we dropped this in userspace for
>>         displayable surfaces, but Marek proved that wrong.
>>
>>         So what we should do is actually to add GTT as fallback to
>>         all BOs on APUs in Mesa and only make sure that the kernel is
>>         capable of handling GTT with optimal performance (e.g. have
>>         user huge pages etc..).
>>
>>
>>     VRAM|GTT is practically as good as GTT. VRAM with BO priorities
>>     and eviction throttling is the true "VRAM|GTT".
>>
>>     I don't know how else to make use of VRAM intelligently.
>
>     Well why not set VRAM|GTT as default on APUs? That should still
>     save quite a bunch of moves even with throttling.
>
>
> I explained why: VRAM|GTT is practically as good as GTT.
>
>
>     I mean there really shouldn't be any advantage to use VRAM any
>     more except that we want to use it up as long as it is available.
>
>
> Why are you suggesting to use VRAM|GTT then? Let's just only use GTT 
> on all APUs.

Then we don't use the memory stolen for VRAM.

See we want to get to a point where we have any ~16MB of stolen VRAM on 
APUs and everything else in GTT.

But we still have to support cases where we have 1GB stolen VRAM, and 
wasting those 1GB would suck a bit.

Christian.

>
> Marek


--------------9228CDE03D047F244AE03FEF
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <div class="moz-cite-prefix">Am 21.03.2018 um 14:57 schrieb Marek
      Olšák:<br>
    </div>
    <blockquote type="cite"
cite="mid:CAAxE2A6xdScLAcuu3SpdnsJi-qJFr16BDxgYLvimFg1o8cNmpg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org">
      <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
      <div dir="ltr">
        <div class="gmail_extra">
          <div class="gmail_quote">On Wed, Mar 21, 2018 at 4:13 AM,
            Christian König <span dir="ltr">&lt;<a
                href="mailto:ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org"
                target="_blank" moz-do-not-send="true">ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt;</span>
            wrote:<br>
            <blockquote class="gmail_quote" style="margin:0 0 0
              .8ex;border-left:1px #ccc solid;padding-left:1ex">
              <div text="#000000" bgcolor="#FFFFFF"><span class="">
                  <div class="m_-1982752714132975532moz-cite-prefix">Am
                    21.03.2018 um 06:08 schrieb Marek Olšák:<br>
                  </div>
                  <blockquote type="cite">
                    <div dir="ltr">
                      <div class="gmail_extra">
                        <div class="gmail_quote">On Tue, Mar 20, 2018 at
                          4:16 PM, Christian König <span dir="ltr">&lt;<a
                              href="mailto:christian.koenig-5C7GfCeVMHo@public.gmane.org"
                              target="_blank" moz-do-not-send="true">christian.koenig-5C7GfCeVMHo@public.gmane.org</a>&gt;</span>
                          wrote:<br>
                          <blockquote class="gmail_quote"
                            style="margin:0 0 0 .8ex;border-left:1px
                            #ccc solid;padding-left:1ex">
                            <div text="#000000" bgcolor="#FFFFFF">
                              <div
                                class="m_-1982752714132975532m_4643584645760816653moz-cite-prefix">That's
                                what I meant with use up the otherwise
                                unused VRAM. I don't see any
                                disadvantage of always setting GTT as
                                second domain on APUs.<br>
                                <br>
                                My assumption was that we dropped this
                                in userspace for displayable surfaces,
                                but Marek proved that wrong.<br>
                                <br>
                                So what we should do is actually to add
                                GTT as fallback to all BOs on APUs in
                                Mesa and only make sure that the kernel
                                is capable of handling GTT with optimal
                                performance (e.g. have user huge pages
                                etc..).<span
                                  class="m_-1982752714132975532HOEnZb"><font
                                    color="#888888"><br>
                                  </font></span></div>
                            </div>
                          </blockquote>
                          <div><br>
                          </div>
                          <div>VRAM|GTT is practically as good as GTT.
                            VRAM with BO priorities and eviction
                            throttling is the true "VRAM|GTT".<br>
                            <br>
                          </div>
                          <div>I don't know how else to make use of VRAM
                            intelligently.</div>
                        </div>
                      </div>
                    </div>
                  </blockquote>
                  <br>
                </span> Well why not set VRAM|GTT as default on APUs?
                That should still save quite a bunch of moves even with
                throttling.<br>
              </div>
            </blockquote>
            <div><br>
            </div>
            <div>I explained why: <span class="gmail-">VRAM|GTT is
                practically as good as GTT.</span><br>
            </div>
            <div> </div>
            <blockquote class="gmail_quote" style="margin:0 0 0
              .8ex;border-left:1px #ccc solid;padding-left:1ex">
              <div text="#000000" bgcolor="#FFFFFF"> <br>
                I mean there really shouldn't be any advantage to use
                VRAM any more except that we want to use it up as long
                as it is available.<br>
              </div>
            </blockquote>
            <div><br>
            </div>
            <div>Why are you suggesting to use VRAM|GTT then? Let's just
              only use GTT on all APUs.</div>
          </div>
        </div>
      </div>
    </blockquote>
    <br>
    Then we don't use the memory stolen for VRAM.<br>
    <br>
    See we want to get to a point where we have any ~16MB of stolen VRAM
    on APUs and everything else in GTT.<br>
    <br>
    But we still have to support cases where we have 1GB stolen VRAM,
    and wasting those 1GB would suck a bit.<br>
    <br>
    Christian.<br>
    <br>
    <blockquote type="cite"
cite="mid:CAAxE2A6xdScLAcuu3SpdnsJi-qJFr16BDxgYLvimFg1o8cNmpg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org">
      <div dir="ltr">
        <div class="gmail_extra">
          <div class="gmail_quote">
            <div><br>
            </div>
            <div>Marek<br>
            </div>
          </div>
        </div>
      </div>
    </blockquote>
    <br>
  </body>
</html>

--------------9228CDE03D047F244AE03FEF--

--===============0803653836==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0803653836==--
