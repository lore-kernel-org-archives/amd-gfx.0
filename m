From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>
Subject: Re: amdgpu with 8+ cards for GPU mining?
Date: Mon, 19 Feb 2018 14:21:16 +0100
Message-ID: <064a018e-9b61-4559-e4af-929b0bccd841@amd.com>
References: <CAPoeEY80EyzCrRfTFp7E9VreZAzEUC4SQ6Kuqynn2Q3oL9CB5A@mail.gmail.com>
 <2c8f8862-9884-fd90-b8bb-0949ecd18185@gmail.com>
 <CAPoeEY8F_uHAZbh2o12X7JME8oG_y18CxoJhs3_Q4mxku-_F2Q@mail.gmail.com>
 <98480e52-41aa-1aa5-deee-e72ac3338310@amd.com>
 <CAPoeEY9w63K4JsgcGH7b7X7VCjDZwTKFUPxbjrSH=_62kJP7Yg@mail.gmail.com>
 <5bad2ebd-2de3-028e-e8e5-918d04e3dfb5@gmail.com>
 <a7ba184a-d45e-8d5e-6ecb-417f6143dbd1@amd.com>
 <CAPoeEY8uEOt2PR5raz0Y10=xqJvxObh52UvLJQGsBMw-DhzC7A@mail.gmail.com>
 <5025ec18-0343-019c-29d4-43dee75c5113@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------C0DBA12949F15BA913621626"
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <5025ec18-0343-019c-29d4-43dee75c5113-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
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
--------------C0DBA12949F15BA913621626
Content-Type: multipart/alternative;
 boundary="------------2F09C55235A091D82C48DCD2"

--------------2F09C55235A091D82C48DCD2
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Joseph,

as a band aid you can try the attached patch. It should at least fix the 
crash at hand and allow amdgpu to continue with the boot process.

Regards,
Christian.

Am 19.02.2018 um 14:13 schrieb Christian König:
> Hi Joseph,
>
> and here is the root cause of the problem:
>> 0b:00.0 VGA compatible controller: Advanced Micro Devices, Inc. 
>> [AMD/ATI] Ellesmere [Radeon RX 470/480/570/580] (rev ef) (prog-if 00 
>> [VGA controller])
>>     Subsystem: Advanced Micro Devices, Inc. [AMD/ATI] Device 0b31
>>     Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- 
>> ParErr- Stepping- SERR- FastB2B- DisINTx-
>>     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
>> <TAbort- <MAbort- >SERR- <PERR- INTx-
>>     Interrupt: pin A routed to IRQ 11
>>     Region 0: Memory at <ignored> (64-bit, prefetchable) [disabled]
>>     Region 2: Memory at b0000000 (64-bit, prefetchable) [disabled] 
>> [size=2M]
>
> The BIOS is not able to assign resources to one of the VGA adapters 
> when there are more than eight installed.
>
> You could try with pci=realloc, but I doubt that there is much we can 
> do in the operating system when the BIOS messed things up like that.
>
> What we should do is to prevent amdgpu from crashing so badly, e.g. 
> allow to cleanly continue with the working hardware even when one of 
> the devices doesn't work.
>
>> when I load in amdgpu, everything froze, so I don't have the log.
> You can work around that using netconsole, see 
> Documentation/networking/netconsole.txt.
>
> Going to try to fix that by just using the screen shot you send 
> earlier, but it would be better if I can get a full log.
>
> Regards,
> Christian.
>
> Am 19.02.2018 um 12:55 schrieb Joseph Wang:
>> Here is the lspci without amdgpu loaded.  when I load in amdgpu, 
>> everything froze, so I don't have the log.
>>
>>
>> _______________________________________________
>> amd-gfx mailing list
>> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
>> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>


--------------2F09C55235A091D82C48DCD2
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <div class="moz-cite-prefix">Hi Joseph,<br>
      <br>
      as a band aid you can try the attached patch. It should at least
      fix the crash at hand and allow amdgpu to continue with the boot
      process.<br>
      <br>
      Regards,<br>
      Christian.<br>
      <br>
      Am 19.02.2018 um 14:13 schrieb Christian König:<br>
    </div>
    <blockquote type="cite"
      cite="mid:5025ec18-0343-019c-29d4-43dee75c5113-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org">
      <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
      <div class="moz-cite-prefix">Hi Joseph,<br>
        <br>
        and here is the root cause of the problem:<br>
        <blockquote type="cite">0b:00.0 VGA compatible controller:
          Advanced Micro Devices, Inc. [AMD/ATI] Ellesmere [Radeon RX
          470/480/570/580] (rev ef) (prog-if 00 [VGA controller])<br>
              Subsystem: Advanced Micro Devices, Inc. [AMD/ATI] Device
          0b31<br>
              Control: I/O- Mem- BusMaster- SpecCycle- MemWINV-
          VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-<br>
              Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast
          &gt;TAbort- &lt;TAbort- &lt;MAbort- &gt;SERR- &lt;PERR- INTx-<br>
              Interrupt: pin A routed to IRQ 11<br>
              Region 0: Memory at &lt;ignored&gt; (64-bit, prefetchable)
          [disabled]<br>
              Region 2: Memory at b0000000 (64-bit, prefetchable)
          [disabled] [size=2M]<br>
        </blockquote>
        <br>
        The BIOS is not able to assign resources to one of the VGA
        adapters when there are more than eight installed.<br>
        <br>
        You could try with pci=realloc, but I doubt that there is much
        we can do in the operating system when the BIOS messed things up
        like that.<br>
        <br>
        What we should do is to prevent amdgpu from crashing so badly,
        e.g. allow to cleanly continue with the working hardware even
        when one of the devices doesn't work.<br>
        <br>
        <blockquote type="cite">when I load in amdgpu, everything froze,
          so I don't have the log.</blockquote>
        You can work around that using netconsole, see
        Documentation/networking/netconsole.txt.<br>
        <br>
        Going to try to fix that by just using the screen shot you send
        earlier, but it would be better if I can get a full log.<br>
        <br>
        Regards,<br>
        Christian.<br>
        <br>
        Am 19.02.2018 um 12:55 schrieb Joseph Wang:<br>
      </div>
      <blockquote type="cite"
cite="mid:CAPoeEY8uEOt2PR5raz0Y10=xqJvxObh52UvLJQGsBMw-DhzC7A-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org">
        <div dir="ltr">Here is the lspci without amdgpu loaded.  when I
          load in amdgpu, everything froze, so I don't have the log.<br>
        </div>
        <br>
        <fieldset class="mimeAttachmentHeader"></fieldset>
        <br>
        <pre wrap="">_______________________________________________
amd-gfx mailing list
<a class="moz-txt-link-abbreviated" href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" moz-do-not-send="true">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a>
<a class="moz-txt-link-freetext" href="https://lists.freedesktop.org/mailman/listinfo/amd-gfx" moz-do-not-send="true">https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a>
</pre>
      </blockquote>
      <br>
    </blockquote>
    <br>
  </body>
</html>

--------------2F09C55235A091D82C48DCD2--

--------------C0DBA12949F15BA913621626
Content-Type: text/x-patch;
 name="0001-PCI-stop-crashing-in-pci_release_resource.patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment;
 filename="0001-PCI-stop-crashing-in-pci_release_resource.patch"

>From 9a90837362d8620d247d943b0e8ed93250a3ad3c Mon Sep 17 00:00:00 2001
From: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>
Date: Mon, 19 Feb 2018 14:17:18 +0100
Subject: [PATCH] PCI: stop crashing in pci_release_resource
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Is it entirely possible that the BIOS wasn't able to assign resources to
a device. In this case don't crash in pci_release_resource() when we try
to resize the resource.

Signed-off-by: Christian König <christian.koenig-5C7GfCeVMHo@public.gmane.org>
---
 drivers/pci/setup-res.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/pci/setup-res.c b/drivers/pci/setup-res.c
index e815111f3f81..fd72c87a9b72 100644
--- a/drivers/pci/setup-res.c
+++ b/drivers/pci/setup-res.c
@@ -401,6 +401,9 @@ void pci_release_resource(struct pci_dev *dev, int resno)
 {
 	struct resource *res = dev->resource + resno;
 
+	if (!res->parent)
+		return;
+
 	dev_info(&dev->dev, "BAR %d: releasing %pR\n", resno, res);
 	release_resource(res);
 	res->end = resource_size(res) - 1;
-- 
2.14.1


--------------C0DBA12949F15BA913621626
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--------------C0DBA12949F15BA913621626--
