From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>
Subject: Re: AMD E8860 on PowerPC with u-boot (T2080)
Date: Thu, 22 Feb 2018 09:51:17 +0100
Message-ID: <808b67da-30df-ed8b-f266-34a449d3f4ab@amd.com>
References: <CAGtoiRjxS7mgQKG_yib9-5tVkD9_yAkp3P8PxYvipy3bFnV9Rg@mail.gmail.com>
 <62565c2f-a57f-9a2b-8277-ca94937bbe0f@daenzer.net>
 <CAGtoiRjqaseQSw7utV5Ncru1ggrq+p2OAg7weULzzSt0DWNoaA@mail.gmail.com>
 <9b9704ee-05ae-8586-bdf8-0e37171d8829@daenzer.net>
 <CAGtoiRgJsoETCpE7R+LwQ-941vgifCWQ+9GdDe_-NiNaJK-78A@mail.gmail.com>
 <8950aedc-29db-ae1b-96c9-20be3c8177eb@gmail.com>
 <CAGtoiRhivO8WtafLy-LC=h9VOsOUrwR7=_Uze9pTBAk=FfiVsA@mail.gmail.com>
 <4b7d2add-456f-5e0e-5aea-15439d2b76e3@amd.com>
 <CAGtoiRhjUShyxeHRuhx_g4zoTYLig=5R_9f-bHAUOcfVO7C0FQ@mail.gmail.com>
 <0f2a9449-b81a-2103-cd6b-df8e7e4b1d60@amd.com>
 <CADnq5_MDSKX8M+seffLxjdNaF3c6WtwY5Pz03YqBSdg6zG=QkA@mail.gmail.com>
 <CAGtoiRiSNHOVUnHDrD9_E41Zunciy_3sMTWFpD_RowZ_D7mAcA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1780249643=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CAGtoiRiSNHOVUnHDrD9_E41Zunciy_3sMTWFpD_RowZ_D7mAcA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
To: Bas Vermeulen <bas-MbI5SpmOCPBHdOctNixuYw@public.gmane.org>, Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>, amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

This is a multi-part message in MIME format.
--===============1780249643==
Content-Type: multipart/alternative;
 boundary="------------35305E4E9F6001C6BD41E0FC"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------35305E4E9F6001C6BD41E0FC
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 22.02.2018 um 09:37 schrieb Bas Vermeulen:
> On Wed, Feb 21, 2018 at 6:22 PM, Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org 
> <mailto:alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>> wrote:
>
>     On Wed, Feb 21, 2018 at 7:43 AM, Christian König
>     [SNIP]
>     > Apart from that I don't have any good idea any more why that
>     shouldn't work.
>
>     Does your platform properly handle DMA masks?  Most radeon hw only
>     supports a 40 bit DMA mask.  If there are relevant bits in the upper
>     bits of the address, they will be lost when the hw tries to use the
>     address.  On at least some powerpc hw, I believe there is some memory
>     routing related info in the high bits.
>
>
> On 4.1 (without the hashing algorithm when printing pointers), The 
> rings are placed thus:
>
> [   11.002673] radeon 0002:01:00.0: fence driver on ring 0 use gpu 
> addr 0x0000000080000c00 and cpu addr 0xc00000007c0c8c00
> [   11.012165] radeon 0002:01:00.0: fence driver on ring 1 use gpu 
> addr 0x0000000080000c04 and cpu addr 0xc00000007c0c8c04
> [   11.021657] radeon 0002:01:00.0: fence driver on ring 2 use gpu 
> addr 0x0000000080000c08 and cpu addr 0xc00000007c0c8c08
> [   11.031152] radeon 0002:01:00.0: fence driver on ring 3 use gpu 
> addr 0x0000000080000c0c and cpu addr 0xc00000007c0c8c0c
> [   11.040644] radeon 0002:01:00.0: fence driver on ring 4 use gpu 
> addr 0x0000000080000c10 and cpu addr 0xc00000007c0c8c10
> [   11.051919] radeon 0002:01:00.0: fence driver on ring 5 use gpu 
> addr 0x0000000000075a18 and cpu addr 0x8000080088db5a18
>
> It's also using bit 63 & 62. So this might be something to look into.

No, that is just the virtual address of the buffer in kernel space and 
perfectly ok.

What you could try is to force the need_dma32 flag to true, see 
drivers/gpu/drm/radeon/radeon_ttm.c and search for need_dma32.

Regards,
Christian.

>
> Bas Vermeulen
>


--------------35305E4E9F6001C6BD41E0FC
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <div class="moz-cite-prefix">Am 22.02.2018 um 09:37 schrieb Bas
      Vermeulen:<br>
    </div>
    <blockquote type="cite"
cite="mid:CAGtoiRiSNHOVUnHDrD9_E41Zunciy_3sMTWFpD_RowZ_D7mAcA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org">
      <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
      <div dir="ltr">
        <div class="gmail_extra">
          <div class="gmail_quote">On Wed, Feb 21, 2018 at 6:22 PM, Alex
            Deucher <span dir="ltr">&lt;<a
                href="mailto:alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" target="_blank"
                moz-do-not-send="true">alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt;</span>
            wrote:<br>
            <blockquote class="gmail_quote" style="margin:0px 0px 0px
              0.8ex;border-left:1px solid
              rgb(204,204,204);padding-left:1ex">
              <div class="gmail-HOEnZb">
                <div class="gmail-h5">On Wed, Feb 21, 2018 at 7:43 AM,
                  Christian König<br>
                  [SNIP]<br>
                  &gt; Apart from that I don't have any good idea any
                  more why that shouldn't work.<br>
                  <br>
                </div>
              </div>
              Does your platform properly handle DMA masks?  Most radeon
              hw only<br>
              supports a 40 bit DMA mask.  If there are relevant bits in
              the upper<br>
              bits of the address, they will be lost when the hw tries
              to use the<br>
              address.  On at least some powerpc hw, I believe there is
              some memory<br>
              routing related info in the high bits.<br>
            </blockquote>
            <div><br>
            </div>
            <div>On 4.1 (without the hashing algorithm when printing
              pointers), The rings are placed thus:</div>
            <div><br>
            </div>
            <div>
              <div>[   11.002673] radeon 0002:01:00.0: fence driver on
                ring 0 use gpu addr 0x0000000080000c00 and cpu addr
                0xc00000007c0c8c00</div>
              <div>[   11.012165] radeon 0002:01:00.0: fence driver on
                ring 1 use gpu addr 0x0000000080000c04 and cpu addr
                0xc00000007c0c8c04</div>
              <div>[   11.021657] radeon 0002:01:00.0: fence driver on
                ring 2 use gpu addr 0x0000000080000c08 and cpu addr
                0xc00000007c0c8c08</div>
              <div>[   11.031152] radeon 0002:01:00.0: fence driver on
                ring 3 use gpu addr 0x0000000080000c0c and cpu addr
                0xc00000007c0c8c0c</div>
              <div>[   11.040644] radeon 0002:01:00.0: fence driver on
                ring 4 use gpu addr 0x0000000080000c10 and cpu addr
                0xc00000007c0c8c10</div>
              <div>[   11.051919] radeon 0002:01:00.0: fence driver on
                ring 5 use gpu addr 0x0000000000075a18 and cpu addr
                0x8000080088db5a18</div>
            </div>
            <div><br>
            </div>
            <div>It's also using bit 63 &amp; 62. So this might be
              something to look into.</div>
          </div>
        </div>
      </div>
    </blockquote>
    <br>
    No, that is just the virtual address of the buffer in kernel space
    and perfectly ok.<br>
    <br>
    What you could try is to force the need_dma32 flag to true, see
    drivers/gpu/drm/radeon/radeon_ttm.c and search for need_dma32.<br>
    <br>
    Regards,<br>
    Christian.<br>
    <br>
    <blockquote type="cite"
cite="mid:CAGtoiRiSNHOVUnHDrD9_E41Zunciy_3sMTWFpD_RowZ_D7mAcA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org">
      <div dir="ltr">
        <div class="gmail_extra">
          <div class="gmail_quote">
            <div><br>
            </div>
            <div>Bas Vermeulen</div>
            <div><br>
            </div>
          </div>
        </div>
      </div>
    </blockquote>
    <br>
  </body>
</html>

--------------35305E4E9F6001C6BD41E0FC--

--===============1780249643==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1780249643==--
