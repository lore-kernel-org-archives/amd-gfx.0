From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: amdgpu with 8+ cards for GPU mining?
Date: Fri, 16 Feb 2018 09:01:58 +0100
Message-ID: <2c8f8862-9884-fd90-b8bb-0949ecd18185@gmail.com>
References: <CAPoeEY80EyzCrRfTFp7E9VreZAzEUC4SQ6Kuqynn2Q3oL9CB5A@mail.gmail.com>
Reply-To: christian.koenig-5C7GfCeVMHo@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1598911832=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CAPoeEY80EyzCrRfTFp7E9VreZAzEUC4SQ6Kuqynn2Q3oL9CB5A-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
To: Joseph Wang <joequant-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

This is a multi-part message in MIME format.
--===============1598911832==
Content-Type: multipart/alternative;
 boundary="------------E51E62C42FE23ACD0473C366"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------E51E62C42FE23ACD0473C366
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Joseph,

please provide the output of lspci -vvvv when the driver is not loaded 
as an attachment.

Additional to that a full dmesg as a text file attachment with the crash 
would be helpful, you should still be able to ssh into the system even 
when the driver crashed.

That looks strongly like the BIOS didn't assigned a PCI BAR to the GPUs. 
The drivers crashes because we assume that the BIOS is working correctly 
and assigned PCI BARs to all GPUs.

Another possibility is that something went wrong while resizing the 
BARs. In this case it would be a driver/PCI subsystem problem.

Regards,
Christian.

Am 15.02.2018 um 23:26 schrieb Joseph Wang:
> I'm attempting to use amdgpu with the B250 mining expert motherboard 
> for GPU mining of ethereum.  The MB can handle 19 cards.  When I have 
> more than six cards, X11 stops working but I can still handle text 
> console.  At nine cards, I get the attached kernel oops on boot.
>
> This is running with the drm-next-4.17-wip branch.
>
> Also would love to get this working with rocm
>
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx


--------------E51E62C42FE23ACD0473C366
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <div class="moz-cite-prefix">Hi Joseph,<br>
      <br>
      please provide the output of lspci -vvvv when the driver is not
      loaded as an attachment.<br>
      <br>
      Additional to that a full dmesg as a text file attachment with the
      crash would be helpful, you should still be able to ssh into the
      system even when the driver crashed.<br>
      <br>
      That looks strongly like the BIOS didn't assigned a PCI BAR to the
      GPUs. The drivers crashes because we assume that the BIOS is
      working correctly and assigned PCI BARs to all GPUs.<br>
      <br>
      Another possibility is that something went wrong while resizing
      the BARs. In this case it would be a driver/PCI subsystem problem.<br>
      <br>
      Regards,<br>
      Christian.<br>
      <br>
      Am 15.02.2018 um 23:26 schrieb Joseph Wang:<br>
    </div>
    <blockquote type="cite"
cite="mid:CAPoeEY80EyzCrRfTFp7E9VreZAzEUC4SQ6Kuqynn2Q3oL9CB5A-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org">
      <div dir="ltr">
        <div>I'm attempting to use amdgpu with the B250 mining expert
          motherboard for GPU mining of ethereum.  The MB can handle 19
          cards.  When I have more than six cards, X11 stops working but
          I can still handle text console.  At nine cards, I get the
          attached kernel oops on boot.</div>
        <div><br>
        </div>
        <div>This is running with the drm-next-4.17-wip branch.</div>
        <div><br>
        </div>
        <div>Also would love to get this working with rocm<br>
        </div>
      </div>
      <br>
      <fieldset class="mimeAttachmentHeader"></fieldset>
      <br>
      <pre wrap="">_______________________________________________
amd-gfx mailing list
<a class="moz-txt-link-abbreviated" href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a>
<a class="moz-txt-link-freetext" href="https://lists.freedesktop.org/mailman/listinfo/amd-gfx">https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a>
</pre>
    </blockquote>
    <br>
  </body>
</html>

--------------E51E62C42FE23ACD0473C366--

--===============1598911832==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1598911832==--
