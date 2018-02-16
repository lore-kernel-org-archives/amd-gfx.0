From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>
Subject: Re: amdgpu with 8+ cards for GPU mining?
Date: Fri, 16 Feb 2018 20:51:28 +0100
Message-ID: <a7ba184a-d45e-8d5e-6ecb-417f6143dbd1@amd.com>
References: <CAPoeEY80EyzCrRfTFp7E9VreZAzEUC4SQ6Kuqynn2Q3oL9CB5A@mail.gmail.com>
 <2c8f8862-9884-fd90-b8bb-0949ecd18185@gmail.com>
 <CAPoeEY8F_uHAZbh2o12X7JME8oG_y18CxoJhs3_Q4mxku-_F2Q@mail.gmail.com>
 <98480e52-41aa-1aa5-deee-e72ac3338310@amd.com>
 <CAPoeEY9w63K4JsgcGH7b7X7VCjDZwTKFUPxbjrSH=_62kJP7Yg@mail.gmail.com>
 <5bad2ebd-2de3-028e-e8e5-918d04e3dfb5@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0667859057=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <5bad2ebd-2de3-028e-e8e5-918d04e3dfb5-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
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
To: Joseph Wang <joequant-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: dev-Kfi0mlvI6tSGglJvpFV4uA@public.gmane.org, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

This is a multi-part message in MIME format.
--===============0667859057==
Content-Type: multipart/alternative;
 boundary="------------6650E8326BD067659131CA6F"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------6650E8326BD067659131CA6F
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Joseph,

I think I've figured out why you run into problems with this hardware 
configuration. The BIOS doesn't assign enough memory address spaces to 
the PCI root hub for this to work.

There is a 2,5GB window below the 4GB limit, starting at address 
0x58000000:
> 58000000-f7ffffff : PCI Bus 0000:00

And a 64GB window above the 4GB limit, starting at address 0x2000000000:
> 2000000000-2fffffffff : PCI Bus 0000:00

Now your Polaris 10 cards have either 8GB or 4GB installed on each board 
and additionally to the installed memory we need 2MB for each card for 
the doorbell bar. Since the assignments can basically only be done as a 
power of two we end up with a requirement of 16GB address space for the 
8GB card and 8GB address space for the 4GB.


For compatibility reasons the cards only advertise a 256MB window for 
the video memory BAR to the BIOS on boot and we later try to resize that 
to the real size of the installed memory.

The first three cards are behind a common PCIe bridge and since we can't 
reprogram the bridge without turning all of them off at once this resize 
operation fails:
> [    1.496085] amdgpu 0000:04:00.0: BAR 0: no space for [mem size 
> 0x200000000 64bit pref]
> [    1.496208] amdgpu 0000:04:00.0: BAR 0: failed to assign [mem size 
> 0x200000000 64bit pref]
> [    1.496332] amdgpu 0000:04:00.0: BAR 2: no space for [mem size 
> 0x00200000 64bit pref]
> [    1.496455] amdgpu 0000:04:00.0: BAR 2: failed to assign [mem size 
> 0x00200000 64bit pref]
> [    1.496581] pcieport 0000:02:00.0: PCI bridge to [bus 03-0a]
> [    1.496686] pcieport 0000:02:00.0:   bridge window [io 0x7000-0x9fff]
> [    1.496795] pcieport 0000:02:00.0:   bridge window [mem 
> 0xf7600000-0xf78fffff]
> [    1.496919] pcieport 0000:02:00.0:   bridge window [mem 
> 0xa0000000-0xf01fffff 64bit pref]
> [    1.497112] pcieport 0000:03:01.0: PCI bridge to [bus 04]
> [    1.497216] pcieport 0000:03:01.0:   bridge window [io 0x9000-0x9fff]
> [    1.497325] pcieport 0000:03:01.0:   bridge window [mem 
> 0xf7800000-0xf78fffff]
> [    1.497450] pcieport 0000:03:01.0:   bridge window [mem 
> 0xe0000000-0xf01fffff 64bit pref]
> [    1.497594] [drm] Not enough PCI address space for a large BAR.
> [    1.508628] [drm] Detected VRAM RAM=8192M, BAR=256M
Fortunately the driver manages to fallback to the original 256MB 
configuration and continues with that. That is a bit sub-optimal, but 
still not a real problem.

For the remaining cards this operation succeeds and we can actually see 
that they are working fine with the new setup:
> [    8.419414] amdgpu 0000:0c:00.0: BAR 2: releasing [mem 
> 0x2ff0000000-0x2ff01fffff 64bit pref]
> [    8.426969] amdgpu 0000:0c:00.0: BAR 0: releasing [mem 
> 0x2fe0000000-0x2fefffffff 64bit pref]
> [    8.434531] pcieport 0000:00:1c.6: BAR 15: releasing [mem 
> 0x2fe0000000-0x2ff01fffff 64bit pref]
> [    8.442219] pcieport 0000:00:1c.6: BAR 15: assigned [mem 
> 0x2080000000-0x21ffffffff 64bit pref]
> [    8.449789] amdgpu 0000:0c:00.0: BAR 0: assigned [mem 
> 0x2100000000-0x21ffffffff 64bit pref]
> [    8.457390] amdgpu 0000:0c:00.0: BAR 2: assigned [mem 
> 0x2080000000-0x20801fffff 64bit pref]
> [    8.464981] pcieport 0000:00:1c.6: PCI bridge to [bus 0c]
> [    8.472505] pcieport 0000:00:1c.6:   bridge window [io 0xe000-0xefff]
> [    8.480066] pcieport 0000:00:1c.6:   bridge window [mem 
> 0xf7d00000-0xf7dfffff]
> [    8.487530] pcieport 0000:00:1c.6:   bridge window [mem 
> 0x2080000000-0x21ffffffff 64bit pref]
> [    8.495020] amdgpu 0000:0c:00.0: VRAM: 4096M 0x000000F400000000 - 
> 0x000000F4FFFFFFFF (4096M used)
> [    8.502610] amdgpu 0000:0c:00.0: GTT: 256M 0x0000000000000000 - 
> 0x000000000FFFFFFF
> [    8.510215] [drm] Detected VRAM RAM=4096M, BAR=4096M


Now what I think happens when you insert the ninth card is that the BIOS 
fails to assign even this small 256MB window to the card, so the card in 
general becomes completely useless.

To further narrow down this issue I need the output from "sudo lspci 
-vvvv" WITHOUT the amdgpu driver loaded when 9 cards are installed. Only 
this way I can inspect what the BIOS programmed as values for the PCI BARs.

Additional to that please provide the dmesg with the actual crash, e.g. 
with 9 cards and amdgpu manually load and/or crash log captured over the 
network.

Thanks in advance,
Christian.

Am 16.02.2018 um 19:42 schrieb Christian König:
> Am 16.02.2018 um 19:17 schrieb Joseph Wang:
>> Here are the logs for the eight card case.
>>
>> cc'ing the Mageia linux group since I'm using that distribution for 
>> development.
>>
>> Three questions:
>>
>> 1) (this might be for the mageia people) What's the easiest way of 
>> booting up the system without loading in the amdgpu module?
>
> Usually modprobe.blacklist=amdgpu should work independent of the 
> distribution.
>
> Christian.
>
>>
>> 2) What's the easiest way of generating a patch from the amd-gfx 
>> repository against the mainline kernel.  The reason for this is that 
>> it's easier
>> for me to do local configuration management if I generate rpms locally.
>>
>> 3) Also right now I'm running a mix of software.  I take the opencl 
>> legacy drivers from the rpm package and they work against amdgpu.  
>> The trouble
>> is that they replace them mesa drivers and so I can't get opencl.  
>> I'd like to move onto ROCm but that involves a lot of configuration 
>> management.
>>
>> The good news is that I have a system with 8 gpu cards that works as 
>> a mining system.
>>
>>
>>
>>
>>
>> _______________________________________________
>> amd-gfx mailing list
>> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
>> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>


--------------6650E8326BD067659131CA6F
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <div class="moz-cite-prefix">Hi Joseph,<br>
      <br>
      I think I've figured out why you run into problems with this
      hardware configuration. The BIOS doesn't assign enough memory
      address spaces to the PCI root hub for this to work.<br>
      <br>
      There is a 2,5GB window below the 4GB limit, starting at address
      0x58000000:
      <blockquote type="cite">58000000-f7ffffff : PCI Bus 0000:00</blockquote>
      <br>
      And a 64GB window above the 4GB limit, starting at address
      0x2000000000:<br>
      <blockquote type="cite">2000000000-2fffffffff : PCI Bus 0000:00 <br>
      </blockquote>
      <br>
      Now your Polaris 10 cards have either 8GB or 4GB installed on each
      board and additionally to the installed memory we need 2MB for
      each card for the doorbell bar. Since the assignments can
      basically only be done as a power of two we end up with a
      requirement of 16GB address space for the 8GB card and 8GB address
      space for the 4GB.<br>
      <br>
      <br>
      For compatibility reasons the cards only advertise a 256MB window
      for the video memory BAR to the BIOS on boot and we later try to
      resize that to the real size of the installed memory.<br>
      <br>
      The first three cards are behind a common PCIe bridge and since we
      can't reprogram the bridge without turning all of them off at once
      this resize operation fails:<br>
      <blockquote type="cite">[    1.496085] amdgpu 0000:04:00.0: BAR 0:
        no space for [mem size 0x200000000 64bit pref]<br>
        [    1.496208] amdgpu 0000:04:00.0: BAR 0: failed to assign [mem
        size 0x200000000 64bit pref]<br>
        [    1.496332] amdgpu 0000:04:00.0: BAR 2: no space for [mem
        size 0x00200000 64bit pref]<br>
        [    1.496455] amdgpu 0000:04:00.0: BAR 2: failed to assign [mem
        size 0x00200000 64bit pref]<br>
        [    1.496581] pcieport 0000:02:00.0: PCI bridge to [bus 03-0a]<br>
        [    1.496686] pcieport 0000:02:00.0:   bridge window [io 
        0x7000-0x9fff]<br>
        [    1.496795] pcieport 0000:02:00.0:   bridge window [mem
        0xf7600000-0xf78fffff]<br>
        [    1.496919] pcieport 0000:02:00.0:   bridge window [mem
        0xa0000000-0xf01fffff 64bit pref]<br>
        [    1.497112] pcieport 0000:03:01.0: PCI bridge to [bus 04]<br>
        [    1.497216] pcieport 0000:03:01.0:   bridge window [io 
        0x9000-0x9fff]<br>
        [    1.497325] pcieport 0000:03:01.0:   bridge window [mem
        0xf7800000-0xf78fffff]<br>
        [    1.497450] pcieport 0000:03:01.0:   bridge window [mem
        0xe0000000-0xf01fffff 64bit pref]<br>
        [    1.497594] [drm] Not enough PCI address space for a large
        BAR.<br>
      </blockquote>
      <blockquote type="cite">[    1.508628] [drm] Detected VRAM
        RAM=8192M, BAR=256M</blockquote>
      Fortunately the driver manages to fallback to the original 256MB
      configuration and continues with that. That is a bit sub-optimal,
      but still not a real problem.<br>
      <br>
      For the remaining cards this operation succeeds and we can
      actually see that they are working fine with the new setup:<br>
      <blockquote type="cite">[    8.419414] amdgpu 0000:0c:00.0: BAR 2:
        releasing [mem 0x2ff0000000-0x2ff01fffff 64bit pref]<br>
        [    8.426969] amdgpu 0000:0c:00.0: BAR 0: releasing [mem
        0x2fe0000000-0x2fefffffff 64bit pref]<br>
        [    8.434531] pcieport 0000:00:1c.6: BAR 15: releasing [mem
        0x2fe0000000-0x2ff01fffff 64bit pref]<br>
        [    8.442219] pcieport 0000:00:1c.6: BAR 15: assigned [mem
        0x2080000000-0x21ffffffff 64bit pref]<br>
        [    8.449789] amdgpu 0000:0c:00.0: BAR 0: assigned [mem
        0x2100000000-0x21ffffffff 64bit pref]<br>
        [    8.457390] amdgpu 0000:0c:00.0: BAR 2: assigned [mem
        0x2080000000-0x20801fffff 64bit pref]<br>
        [    8.464981] pcieport 0000:00:1c.6: PCI bridge to [bus 0c]<br>
        [    8.472505] pcieport 0000:00:1c.6:   bridge window [io 
        0xe000-0xefff]<br>
        [    8.480066] pcieport 0000:00:1c.6:   bridge window [mem
        0xf7d00000-0xf7dfffff]<br>
        [    8.487530] pcieport 0000:00:1c.6:   bridge window [mem
        0x2080000000-0x21ffffffff 64bit pref]<br>
        [    8.495020] amdgpu 0000:0c:00.0: VRAM: 4096M
        0x000000F400000000 - 0x000000F4FFFFFFFF (4096M used)<br>
        [    8.502610] amdgpu 0000:0c:00.0: GTT: 256M 0x0000000000000000
        - 0x000000000FFFFFFF<br>
        [    8.510215] [drm] Detected VRAM RAM=4096M, BAR=4096M<br>
      </blockquote>
      <br>
      <br>
      Now what I think happens when you insert the ninth card is that
      the BIOS fails to assign even this small 256MB window to the card,
      so the card in general becomes completely useless.<br>
      <br>
      To further narrow down this issue I need the output from "sudo
      lspci -vvvv" WITHOUT the amdgpu driver loaded when 9 cards are
      installed. Only this way I can inspect what the BIOS programmed as
      values for the PCI BARs.<br>
      <br>
      Additional to that please provide the dmesg with the actual crash,
      e.g. with 9 cards and amdgpu manually load and/or crash log
      captured over the network.<br>
      <br>
      Thanks in advance,<br>
      Christian.<br>
      <br>
      Am 16.02.2018 um 19:42 schrieb Christian König:<br>
    </div>
    <blockquote type="cite"
      cite="mid:5bad2ebd-2de3-028e-e8e5-918d04e3dfb5-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org">
      <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
      <div class="moz-cite-prefix">Am 16.02.2018 um 19:17 schrieb Joseph
        Wang:<br>
      </div>
      <blockquote type="cite"
cite="mid:CAPoeEY9w63K4JsgcGH7b7X7VCjDZwTKFUPxbjrSH=_62kJP7Yg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org">
        <div dir="ltr">
          <div class="gmail_extra">Here are the logs for the eight card
            case.  <br>
          </div>
          <div class="gmail_extra"><br>
          </div>
          <div class="gmail_extra">cc'ing the Mageia linux group since
            I'm using that distribution for development.</div>
          <div class="gmail_extra"><br>
          </div>
          <div class="gmail_extra">Three questions:</div>
          <div class="gmail_extra"><br>
          </div>
          <div class="gmail_extra">1) (this might be for the mageia
            people) What's the easiest way of booting up the system
            without loading in the amdgpu module?</div>
        </div>
      </blockquote>
      <br>
      Usually modprobe.blacklist=amdgpu should work independent of the
      distribution.<br>
      <br>
      Christian.<br>
      <br>
      <blockquote type="cite"
cite="mid:CAPoeEY9w63K4JsgcGH7b7X7VCjDZwTKFUPxbjrSH=_62kJP7Yg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org">
        <div dir="ltr">
          <div class="gmail_extra"><br>
          </div>
          <div class="gmail_extra">2) What's the easiest way of
            generating a patch from the amd-gfx repository against the
            mainline kernel.  The reason for this is that it's easier</div>
          <div class="gmail_extra">for me to do local configuration
            management if I generate rpms locally.<br>
          </div>
          <div class="gmail_extra"><br>
          </div>
          <div class="gmail_extra">3) Also right now I'm running a mix
            of software.  I take the opencl legacy drivers from the rpm
            package and they work against amdgpu.  The trouble</div>
          <div class="gmail_extra">is that they replace them mesa
            drivers and so I can't get opencl.  I'd like to move onto
            ROCm but that involves a lot of configuration management.</div>
          <div class="gmail_extra"><br>
          </div>
          <div class="gmail_extra">The good news is that I have a system
            with 8 gpu cards that works as a mining system.</div>
          <div class="gmail_extra"><br>
          </div>
          <div class="gmail_extra"><br>
          </div>
          <div class="gmail_extra"><br>
          </div>
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

--------------6650E8326BD067659131CA6F--

--===============0667859057==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0667859057==--
