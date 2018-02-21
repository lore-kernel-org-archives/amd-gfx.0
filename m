From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>
Subject: Re: AMD E8860 on PowerPC with u-boot (T2080)
Date: Wed, 21 Feb 2018 12:52:00 +0100
Message-ID: <4b7d2add-456f-5e0e-5aea-15439d2b76e3@amd.com>
References: <CAGtoiRjxS7mgQKG_yib9-5tVkD9_yAkp3P8PxYvipy3bFnV9Rg@mail.gmail.com>
 <62565c2f-a57f-9a2b-8277-ca94937bbe0f@daenzer.net>
 <CAGtoiRjqaseQSw7utV5Ncru1ggrq+p2OAg7weULzzSt0DWNoaA@mail.gmail.com>
 <9b9704ee-05ae-8586-bdf8-0e37171d8829@daenzer.net>
 <CAGtoiRgJsoETCpE7R+LwQ-941vgifCWQ+9GdDe_-NiNaJK-78A@mail.gmail.com>
 <8950aedc-29db-ae1b-96c9-20be3c8177eb@gmail.com>
 <CAGtoiRhivO8WtafLy-LC=h9VOsOUrwR7=_Uze9pTBAk=FfiVsA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0688236311=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CAGtoiRhivO8WtafLy-LC=h9VOsOUrwR7=_Uze9pTBAk=FfiVsA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
To: Bas Vermeulen <bas-MbI5SpmOCPBHdOctNixuYw@public.gmane.org>
Cc: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

This is a multi-part message in MIME format.
--===============0688236311==
Content-Type: multipart/alternative;
 boundary="------------73BF2549415753901B70E937"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------73BF2549415753901B70E937
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 21.02.2018 um 12:01 schrieb Bas Vermeulen:
> On Wed, Feb 21, 2018 at 11:43 AM, Christian König 
> <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org 
> <mailto:ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>> wrote:
>
>     Am 21.02.2018 um 11:38 schrieb Bas Vermeulen:
>>     On Wed, Feb 21, 2018 at 10:31 AM, Michel Dänzer
>>     <michel-otUistvHUpPR7s880joybQ@public.gmane.org <mailto:michel-otUistvHUpPR7s880joybQ@public.gmane.org>> wrote:
>>
>>         On 2018-02-21 10:18 AM, Bas Vermeulen wrote:
>>         > On Wed, Feb 21, 2018 at 10:06 AM, Michel Dänzer
>>         <michel-otUistvHUpPR7s880joybQ@public.gmane.org <mailto:michel-otUistvHUpPR7s880joybQ@public.gmane.org>
>>         > <mailto:michel-otUistvHUpPR7s880joybQ@public.gmane.org <mailto:michel-otUistvHUpPR7s880joybQ@public.gmane.org>>> wrote:
>>         >
>>         >     > My question is, what do I need to do to correctly
>>         initialize the E8860
>>         >     > board on my powerpc machine?
>>         >
>>         >     Start by sharing the dmesg output, and maybe also the
>>         kernel build
>>         >     configuration file.
>>         >
>>         >
>>         > Both are attached (gzipped because of size).
>>
>>         It might be related to this:
>>
>>         [   10.482772] radeon: No coherent DMA available.
>>
>>
>>     I updated my device-tree to add incoming pcie ranges, and that
>>     removes this error:
>>
>>     [   10.161044] [drm] radeon kernel modesetting enabled.
>>     [   10.165168] [drm] initializing kernel modesetting (VERDE
>>     0x1002:0x6822 0x1002:0x031E).
>>     [   10.171799] radeon: No coherent DMA available.
>
>     Well that reads like the problem is still there and yes when you
>     don't have coherent DMA possibility that would explain why it
>     doesn't work.
>
>     Can you provide us with a dump of /proc/iomem as well?
>
>
> Sure:
>
> 00000000-ffffffff : System RAM

Mhm, ok all system memory is below 4GB. So at least in theory it should 
work even without coherent DMA.

No idea what goes wrong here,
Christian.

> c20000000-c2fffffff : /pcie@ffe250000
>   c20000000-c2fffffff : PCI Bus 0001:01
>     c21000000-c210fffff : 0001:01:00.0
>     c21100000-c211fffff : 0001:01:00.0
> c40000000-c7fffffff : /pcie@ffe270000
>   c40000000-c7fffffff : PCI Bus 0002:01
>     c41000000-c4103ffff : 0002:01:00.0
>     c41040000-c4105ffff : 0002:01:00.0
>     c41060000-c41063fff : 0002:01:00.1
>     c60000000-c6fffffff : 0002:01:00.0
> fe8000000-fefffffff : fe8000000.nor
> ffe008000-ffe008fff : mpc85xx_mc_err
> ffe100100-ffe10017f : dma
> ffe100180-ffe1001ff : dma
> ffe100200-ffe10027f : dma
> ffe100280-ffe1002ff : dma
> ffe100400-ffe10047f : dma
> ffe100480-ffe1004ff : dma
> ffe100500-ffe10057f : dma
> ffe100580-ffe1005ff : dma
> ffe101100-ffe10117f : dma
> ffe101180-ffe1011ff : dma
> ffe101200-ffe10127f : dma
> ffe101280-ffe1012ff : dma
> ffe101400-ffe10147f : dma
> ffe101480-ffe1014ff : dma
> ffe101500-ffe10157f : dma
> ffe101580-ffe1015ff : dma
> ffe102100-ffe10217f : dma
> ffe102180-ffe1021ff : dma
> ffe102200-ffe10227f : dma
> ffe102280-ffe1022ff : dma
> ffe102400-ffe10247f : dma
> ffe102480-ffe1024ff : dma
> ffe102500-ffe10257f : dma
> ffe102580-ffe1025ff : dma
> ffe110000-ffe110fff : /soc@ffe000000/spi@110000
> ffe114000-ffe114fff : mmc0
> ffe11c500-ffe11c507 : serial
> ffe11c600-ffe11c607 : serial
> ffe11d500-ffe11d507 : serial
> ffe11d600-ffe11d607 : serial
> ffe210000-ffe210fff : /soc@ffe000000/usb@210000
>   ffe210000-ffe210fff : /soc@ffe000000/usb@210000
> ffe211000-ffe211fff : /soc@ffe000000/usb@211000
>   ffe211000-ffe211fff : /soc@ffe000000/usb@211000
> ffe240e00-ffe24ffff : mpc85xx_pci_err
> ffe250e00-ffe25ffff : mpc85xx_pci_err
> ffe270e00-ffe27ffff : mpc85xx_pci_err
> ffe400000-ffe4fffff : fman
>   ffe400000-ffe45ffff : fman-muram
>   ffe482000-ffe482fff : fman-port-hc
>   ffe483000-ffe483fff : fman-port-hc
>   ffe484000-ffe484fff : fman-port-hc
>   ffe485000-ffe485fff : fman-port-hc
>   ffe486000-ffe486fff : fman-port-hc
>   ffe487000-ffe487fff : fman-port-hc
>   ffe488000-ffe488fff : fman-port-hc
>   ffe489000-ffe489fff : fman-port-hc
>   ffe48a000-ffe48afff : fman-port-hc
>   ffe48b000-ffe48bfff : fman-port-hc
>   ffe48c000-ffe48cfff : fman-port-hc
>   ffe48d000-ffe48dfff : fman-port-hc
>   ffe490000-ffe490fff : fman-port-hc
>   ffe491000-ffe491fff : fman-port-hc
>   ffe4a8000-ffe4a8fff : fman-port-hc
>   ffe4a9000-ffe4a9fff : fman-port-hc
>   ffe4aa000-ffe4aafff : fman-port-hc
>   ffe4ab000-ffe4abfff : fman-port-hc
>   ffe4ac000-ffe4acfff : fman-port-hc
>   ffe4ad000-ffe4adfff : fman-port-hc
>   ffe4b0000-ffe4b0fff : fman-port-hc
>   ffe4b1000-ffe4b1fff : fman-port-hc
>   ffe4dc000-ffe4dcfff : fman-vsp
>   ffe4e0000-ffe4e0fff : mac
>   ffe4e2000-ffe4e2fff : mac
>   ffe4e4000-ffe4e4fff : mac
>   ffe4e6000-ffe4e6fff : mac
>   ffe4f0000-ffe4f0fff : mac
>   ffe4f2000-ffe4f2fff : mac
>   ffe4fe000-ffe4fefff : fman-rtc
>
> Bas Vermeulen


--------------73BF2549415753901B70E937
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <div class="moz-cite-prefix">Am 21.02.2018 um 12:01 schrieb Bas
      Vermeulen:<br>
    </div>
    <blockquote type="cite"
cite="mid:CAGtoiRhivO8WtafLy-LC=h9VOsOUrwR7=_Uze9pTBAk=FfiVsA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org">
      <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
      <div dir="ltr">
        <div class="gmail_extra">
          <div class="gmail_quote">On Wed, Feb 21, 2018 at 11:43 AM,
            Christian König <span dir="ltr">&lt;<a
                href="mailto:ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org"
                target="_blank" moz-do-not-send="true">ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt;</span>
            wrote:<br>
            <blockquote class="gmail_quote" style="margin:0px 0px 0px
              0.8ex;border-left:1px solid
              rgb(204,204,204);padding-left:1ex">
              <div bgcolor="#FFFFFF"><span class="gmail-">
                  <div
                    class="gmail-m_-6485466701557759592moz-cite-prefix">Am
                    21.02.2018 um 11:38 schrieb Bas Vermeulen:<br>
                  </div>
                  <blockquote type="cite">
                    <div dir="ltr">
                      <div class="gmail_extra">
                        <div class="gmail_quote">On Wed, Feb 21, 2018 at
                          10:31 AM, Michel Dänzer <span dir="ltr">&lt;<a
                              href="mailto:michel-otUistvHUpPR7s880joybQ@public.gmane.org"
                              target="_blank" moz-do-not-send="true">michel-otUistvHUpPR7s880joybQ@public.gmane.org</a>&gt;</span>
                          wrote:<br>
                          <blockquote class="gmail_quote"
                            style="margin:0px 0px 0px
                            0.8ex;border-left:1px solid
                            rgb(204,204,204);padding-left:1ex"><span
                              class="gmail-m_-6485466701557759592gmail-">On
                              2018-02-21 10:18 AM, Bas Vermeulen wrote:<br>
                              &gt; On Wed, Feb 21, 2018 at 10:06 AM,
                              Michel Dänzer &lt;<a
                                href="mailto:michel-otUistvHUpPR7s880joybQ@public.gmane.org"
                                target="_blank" moz-do-not-send="true">michel-otUistvHUpPR7s880joybQ@public.gmane.org</a><br>
                            </span><span
                              class="gmail-m_-6485466701557759592gmail-">&gt;
                              &lt;mailto:<a
                                href="mailto:michel-otUistvHUpPR7s880joybQ@public.gmane.org"
                                target="_blank" moz-do-not-send="true">michel-otUistvHUpPR7s880joybQ@public.gmane.org</a>&gt;&gt;
                              wrote:<br>
                              &gt;<br>
                              &gt;     &gt; My question is, what do I
                              need to do to correctly initialize the
                              E8860<br>
                              &gt;     &gt; board on my powerpc machine?<br>
                              &gt;<br>
                              &gt;     Start by sharing the dmesg
                              output, and maybe also the kernel build<br>
                              &gt;     configuration file.<br>
                              &gt;<br>
                              &gt;  <br>
                              &gt; Both are attached (gzipped because of
                              size).<br>
                              <br>
                            </span>It might be related to this:<br>
                            <br>
                            [   10.482772] radeon: No coherent DMA
                            available.<br>
                            <div
                              class="gmail-m_-6485466701557759592gmail-HOEnZb">
                              <div
                                class="gmail-m_-6485466701557759592gmail-h5"><br>
                              </div>
                            </div>
                          </blockquote>
                          <div><br>
                          </div>
                          <div>I updated my device-tree to add incoming
                            pcie ranges, and that removes this error:</div>
                          <div><br>
                          </div>
                          <div>[   10.161044] [drm] radeon kernel
                            modesetting enabled.</div>
                          <div>[   10.165168] [drm] initializing kernel
                            modesetting (VERDE 0x1002:0x6822
                            0x1002:0x031E).</div>
                          <div>[   10.171799] radeon: No coherent DMA
                            available.</div>
                        </div>
                      </div>
                    </div>
                  </blockquote>
                  <br>
                </span> Well that reads like the problem is still there
                and yes when you don't have coherent DMA possibility
                that would explain why it doesn't work.<br>
                <br>
                Can you provide us with a dump of /proc/iomem as well?<br>
              </div>
            </blockquote>
            <div><br>
            </div>
            <div>Sure:</div>
            <div><br>
            </div>
            <div>00000000-ffffffff : System RAM</div>
          </div>
        </div>
      </div>
    </blockquote>
    <br>
    Mhm, ok all system memory is below 4GB. So at least in theory it
    should work even without coherent DMA.<br>
    <br>
    No idea what goes wrong here,<br>
    Christian.<br>
    <br>
    <blockquote type="cite"
cite="mid:CAGtoiRhivO8WtafLy-LC=h9VOsOUrwR7=_Uze9pTBAk=FfiVsA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org">
      <div dir="ltr">
        <div class="gmail_extra">
          <div class="gmail_quote">
            <div>c20000000-c2fffffff : /pcie@ffe250000</div>
            <div>  c20000000-c2fffffff : PCI Bus 0001:01</div>
            <div>    c21000000-c210fffff : 0001:01:00.0</div>
            <div>    c21100000-c211fffff : 0001:01:00.0</div>
            <div>c40000000-c7fffffff : /pcie@ffe270000</div>
            <div>  c40000000-c7fffffff : PCI Bus 0002:01</div>
            <div>    c41000000-c4103ffff : 0002:01:00.0</div>
            <div>    c41040000-c4105ffff : 0002:01:00.0</div>
            <div>    c41060000-c41063fff : 0002:01:00.1</div>
            <div>    c60000000-c6fffffff : 0002:01:00.0</div>
            <div>fe8000000-fefffffff : fe8000000.nor</div>
            <div>ffe008000-ffe008fff : mpc85xx_mc_err</div>
            <div>ffe100100-ffe10017f : dma</div>
            <div>ffe100180-ffe1001ff : dma</div>
            <div>ffe100200-ffe10027f : dma</div>
            <div>ffe100280-ffe1002ff : dma</div>
            <div>ffe100400-ffe10047f : dma</div>
            <div>ffe100480-ffe1004ff : dma</div>
            <div>ffe100500-ffe10057f : dma</div>
            <div>ffe100580-ffe1005ff : dma</div>
            <div>ffe101100-ffe10117f : dma</div>
            <div>ffe101180-ffe1011ff : dma</div>
            <div>ffe101200-ffe10127f : dma</div>
            <div>ffe101280-ffe1012ff : dma</div>
            <div>ffe101400-ffe10147f : dma</div>
            <div>ffe101480-ffe1014ff : dma</div>
            <div>ffe101500-ffe10157f : dma</div>
            <div>ffe101580-ffe1015ff : dma</div>
            <div>ffe102100-ffe10217f : dma</div>
            <div>ffe102180-ffe1021ff : dma</div>
            <div>ffe102200-ffe10227f : dma</div>
            <div>ffe102280-ffe1022ff : dma</div>
            <div>ffe102400-ffe10247f : dma</div>
            <div>ffe102480-ffe1024ff : dma</div>
            <div>ffe102500-ffe10257f : dma</div>
            <div>ffe102580-ffe1025ff : dma</div>
            <div>ffe110000-ffe110fff : /soc@ffe000000/spi@110000</div>
            <div>ffe114000-ffe114fff : mmc0</div>
            <div>ffe11c500-ffe11c507 : serial</div>
            <div>ffe11c600-ffe11c607 : serial</div>
            <div>ffe11d500-ffe11d507 : serial</div>
            <div>ffe11d600-ffe11d607 : serial</div>
            <div>ffe210000-ffe210fff : /soc@ffe000000/usb@210000</div>
            <div>  ffe210000-ffe210fff : /soc@ffe000000/usb@210000</div>
            <div>ffe211000-ffe211fff : /soc@ffe000000/usb@211000</div>
            <div>  ffe211000-ffe211fff : /soc@ffe000000/usb@211000</div>
            <div>ffe240e00-ffe24ffff : mpc85xx_pci_err</div>
            <div>ffe250e00-ffe25ffff : mpc85xx_pci_err</div>
            <div>ffe270e00-ffe27ffff : mpc85xx_pci_err</div>
            <div>ffe400000-ffe4fffff : fman</div>
            <div>  ffe400000-ffe45ffff : fman-muram</div>
            <div>  ffe482000-ffe482fff : fman-port-hc</div>
            <div>  ffe483000-ffe483fff : fman-port-hc</div>
            <div>  ffe484000-ffe484fff : fman-port-hc</div>
            <div>  ffe485000-ffe485fff : fman-port-hc</div>
            <div>  ffe486000-ffe486fff : fman-port-hc</div>
            <div>  ffe487000-ffe487fff : fman-port-hc</div>
            <div>  ffe488000-ffe488fff : fman-port-hc</div>
            <div>  ffe489000-ffe489fff : fman-port-hc</div>
            <div>  ffe48a000-ffe48afff : fman-port-hc</div>
            <div>  ffe48b000-ffe48bfff : fman-port-hc</div>
            <div>  ffe48c000-ffe48cfff : fman-port-hc</div>
            <div>  ffe48d000-ffe48dfff : fman-port-hc</div>
            <div>  ffe490000-ffe490fff : fman-port-hc</div>
            <div>  ffe491000-ffe491fff : fman-port-hc</div>
            <div>  ffe4a8000-ffe4a8fff : fman-port-hc</div>
            <div>  ffe4a9000-ffe4a9fff : fman-port-hc</div>
            <div>  ffe4aa000-ffe4aafff : fman-port-hc</div>
            <div>  ffe4ab000-ffe4abfff : fman-port-hc</div>
            <div>  ffe4ac000-ffe4acfff : fman-port-hc</div>
            <div>  ffe4ad000-ffe4adfff : fman-port-hc</div>
            <div>  ffe4b0000-ffe4b0fff : fman-port-hc</div>
            <div>  ffe4b1000-ffe4b1fff : fman-port-hc</div>
            <div>  ffe4dc000-ffe4dcfff : fman-vsp</div>
            <div>  ffe4e0000-ffe4e0fff : mac</div>
            <div>  ffe4e2000-ffe4e2fff : mac</div>
            <div>  ffe4e4000-ffe4e4fff : mac</div>
            <div>  ffe4e6000-ffe4e6fff : mac</div>
            <div>  ffe4f0000-ffe4f0fff : mac</div>
            <div>  ffe4f2000-ffe4f2fff : mac</div>
            <div>  ffe4fe000-ffe4fefff : fman-rtc</div>
            <div><br>
            </div>
            <div>Bas Vermeulen</div>
          </div>
        </div>
      </div>
    </blockquote>
    <br>
  </body>
</html>

--------------73BF2549415753901B70E937--

--===============0688236311==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0688236311==--
