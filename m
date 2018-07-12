From: jimqu <jimqu-5C7GfCeVMHo@public.gmane.org>
Subject: =?UTF-8?Q?Re:_=e7=ad=94=e5=a4=8d:_Regression_with_kernel_4.18_-_AMD?=
 =?UTF-8?Q?_RX_550_fails_IB_ring_test_on_power-up?=
Date: Thu, 12 Jul 2018 10:16:18 +0800
Message-ID: <45e7a84e-941a-fd7b-e08e-c9444ea1d77c@amd.com>
References: <CAEzXK1ofHUGNcZXM+Ys4xU9g0cSrdr63fxMVTCSq2-X4jwKfNw@mail.gmail.com>
 <CAEzXK1oftbBGeuzJEsn7bEJUmuiviq5h6cmmP0hP2+U77otZKA@mail.gmail.com>
 <DM3PR12MB0873E055CAF457DE917EC238995A0@DM3PR12MB0873.namprd12.prod.outlook.com>
 <CAEzXK1pnvjJfe2Q0WVeGToyZNDH_GQD1eMJnf3R=GNQTbK8pjw@mail.gmail.com>
 <a0bbadba-18bb-12dd-a577-305c5178ddb8@amd.com>
 <CAEzXK1q5OdOaYzLRw9YWmAeOUQxGjb2R8jTEjQX1SPNhTGsS_w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1622578313=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CAEzXK1q5OdOaYzLRw9YWmAeOUQxGjb2R8jTEjQX1SPNhTGsS_w-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
To: =?UTF-8?Q?Lu=c3=ads_Mendes?= <luis.p.mendes-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: "Qu, Jim" <Jim.Qu-5C7GfCeVMHo@public.gmane.org>, =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>, "Koenig,
 Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>, amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

This is a multi-part message in MIME format.
--===============1622578313==
Content-Type: multipart/alternative;
 boundary="------------68C0E77F0E409F6F60D1C803"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------68C0E77F0E409F6F60D1C803
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2018年07月12日 05:27, Luís Mendes wrote:
> Hi Jim,
>
> I followed your suggestion and was able to bisect the kernel patches.
> The offending patch is: drm/amdgpu: defer test IBs on the rings at 
> boot (V3)
> commit:
>
> 	2c773de2ecb8c327f2448bd1eecad224e9227087 
> <https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?h=v4.18-rc4&id=2c773de2ecb8c327f2448bd1eecad224e9227087> 
>
>
>
> After reverting this patch the IB test succeeded with kernel v4.18-rc4 
> on both systems and the amdgpu driver was correctly loaded both on 
> SAPPHIRE RX550 4GB and on SAPPHIRE RX460 2GB.
>

Alex, Christian, What do you think about the patch?

> The GPU hang remains, however.
>  I will try to configure a remote IPMI connection to see what is 
> happening with the kernel boot or setup a serial console for the Kernel.
>

You can set up remote connection by ssh, and also you can add amdgpu to 
blacklist first, and manually modprobe amdgpu.
What's about xinit? What is MESA driver version on your platform?

> Thanks & Regards,
> Luís
>
> On Wed, Jul 11, 2018 at 10:56 AM, jimqu <jimqu-5C7GfCeVMHo@public.gmane.org 
> <mailto:jimqu-5C7GfCeVMHo@public.gmane.org>> wrote:
>
>     HI Luis,
>
>
>     Let us trace the issue one by one.
>
>
>     IB test fail:
>
>     This should be regression issue on 4.18, you can bisect the kernel
>     patches.
>
>     GPU hang:
>
>     Fix IB test fail first.
>
>
>     Thanks
>
>     JimQu
>
>
>
>     On 2018年07月11日 17:34, Luís Mendes wrote:
>>     Hi Jim,
>>
>>     Thanks for your interest in this issue. Actually this is a
>>     multiple issue... not only the IB ring test is failing... as I am
>>     having quite some trouble getting the cards SAPPHIRE RX 550 4GB
>>     on a Tyan S7025 and SAPPHIRE RX 460 2GB on a TYAN S7002 to work,
>>     both systems using same Ubuntu 18.04 with vanilla kernel.
>>
>>     *1. May you also test earlier kernel? v4.17 or v4.16.*
>>     I've tested kernels v4.17.5 and v4.16.6 with same system and both
>>     are able to pass the IB ring test and system boots into X using
>>     NVIDIA as the display connected card.
>>     dmesg log attached for kernel 4.17.5, file
>>     TYAN_S7025_kernelv4.17.5_amdgpu_IB_ring_test_OK.txt.
>>
>>     *2. May you test the issue only with amdgpu?*
>>     - I've tested on a TYAN S7002 system with a single SAPPHIRE RX
>>     460 2GB, on-board VGA enabled and used as primary display.
>>     Kernel v4.18-rc4 fails the IB ring test, system is able to enter
>>     X through the on-board VGA.
>>     dmesg log attached for kernel 4.18-rc4, file
>>     TYAN_S7002_kernel_v4.18-rc4_IB_ring_test_fail.txt.
>>
>>     - Same TYAN S7002 system, but now with on-board VGA disabled and
>>     using RX 460 as display connected card.
>>     Kernels v4.17.5 and v4.16.6 are able to pass the IB ring test,
>>     but GPU hangs before entering X. Don't have logs for these yet.
>>
>>     Regards,
>>     Luís Mendes
>>     Aparapi contributor and MSc Researcher
>>
>>
>>
>>
>>
>>     On Wed, Jul 11, 2018 at 3:49 AM, Qu, Jim <Jim.Qu-5C7GfCeVMHo@public.gmane.org
>>     <mailto:Jim.Qu-5C7GfCeVMHo@public.gmane.org>> wrote:
>>
>>         Hi Luis,
>>
>>         1. May you also test earlier kernel? v4.17 or v4.16.
>>         2. May you test the issue only with amdgpu?
>>
>>         Thanks
>>         JimQu
>>
>>         ________________________________________
>>         发件人: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
>>         <mailto:amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>> 代表 Luís
>>         Mendes <luis.p.mendes-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org <mailto:luis.p.mendes-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>>
>>         发送时间: 2018年7月11日 6:04:00
>>         收件人: Michel Dänzer; Koenig, Christian; amd-gfx list
>>         主题: Re: Regression with kernel 4.18 - AMD RX 550 fails IB
>>         ring test on power-up
>>
>>         Hi,
>>
>>         Issue remains in kernel 4.18-rc4 using SAPPHIRE RX 550 4GB.
>>
>>         Logs follow attached.
>>
>>         Regards,
>>         Luis
>>
>>         On Tue, Jun 26, 2018 at 10:08 AM, Luís Mendes
>>         <luis.p.mendes-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
>>         <mailto:luis.p.mendes-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org><mailto:luis.p.mendes-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
>>         <mailto:luis.p.mendes-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>>> wrote:
>>         Hi,
>>
>>         I've tried kernel 4.18-rc2 on a system with a NVIDIA GTX 1050
>>         Ti and an AMD RX 550 4GB and the RX 550 card is failing the
>>         IB ring test.
>>
>>         [    5.033217] [drm:gfx_v8_0_ring_test_ib [amdgpu]] *ERROR*
>>         amdgpu: ib test failed (scratch(0xC040)=0xFFFFFFFF)
>>         [    5.033264] [drm:amdgpu_ib_ring_tests [amdgpu]] *ERROR*
>>         amdgpu: failed testing IB on ring 6 (-22).
>>
>>         Please see the attached log.
>>
>>         Regards,
>>         Luís
>>
>>
>
>


--------------68C0E77F0E409F6F60D1C803
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <p><br>
    </p>
    <br>
    <div class="moz-cite-prefix">On 2018年07月12日 05:27, Luís Mendes
      wrote:<br>
    </div>
    <blockquote type="cite"
cite="mid:CAEzXK1q5OdOaYzLRw9YWmAeOUQxGjb2R8jTEjQX1SPNhTGsS_w-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org">
      <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
      <div dir="ltr">
        <div>Hi Jim,</div>
        <div><br>
        </div>
        <div>I followed your suggestion and was able to bisect the
          kernel patches.</div>
        <div>The offending patch is: drm/amdgpu: defer test IBs on the
          rings at boot (V3)<br>
        </div>
        <div>commit:
          <table summary="commit info" class="gmail-commit-info">
            <tbody>
              <tr>
                <th><br>
                </th>
                <td colspan="2" class="gmail-sha1"><a
href="https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?h=v4.18-rc4&amp;id=2c773de2ecb8c327f2448bd1eecad224e9227087"
                    moz-do-not-send="true">2c773de2ecb8c327f2448bd1eecad224e9227087</a></td>
              </tr>
            </tbody>
          </table>
        </div>
        <div><br>
        </div>
        <div>After reverting this patch the IB test succeeded with
          kernel v4.18-rc4 on both systems and the amdgpu driver was
          correctly loaded both on SAPPHIRE RX550 4GB and on SAPPHIRE
          RX460 2GB.</div>
        <div><br>
        </div>
      </div>
    </blockquote>
    <br>
    Alex, Christian, What do you think about the patch?<br>
    <br>
    <blockquote type="cite"
cite="mid:CAEzXK1q5OdOaYzLRw9YWmAeOUQxGjb2R8jTEjQX1SPNhTGsS_w-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org">
      <div dir="ltr">
        <div>The GPU hang remains, however.<br>
        </div>
        <div> I will try to configure a remote IPMI connection to see
          what is happening with the kernel boot or setup a serial
          console for the Kernel.</div>
        <div><br>
        </div>
      </div>
    </blockquote>
    <br>
    You can set up remote connection by ssh, and also you can add amdgpu
    to blacklist first, and manually modprobe amdgpu.<br>
    What's about xinit? What is MESA driver version on your platform?<br>
    <br>
    <blockquote type="cite"
cite="mid:CAEzXK1q5OdOaYzLRw9YWmAeOUQxGjb2R8jTEjQX1SPNhTGsS_w-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org">
      <div dir="ltr">
        <div>Thanks &amp; Regards,</div>
        <div>Luís<br>
        </div>
      </div>
      <div class="gmail_extra"><br>
        <div class="gmail_quote">On Wed, Jul 11, 2018 at 10:56 AM, jimqu
          <span dir="ltr">&lt;<a href="mailto:jimqu-5C7GfCeVMHo@public.gmane.org"
              target="_blank" moz-do-not-send="true">jimqu-5C7GfCeVMHo@public.gmane.org</a>&gt;</span>
          wrote:<br>
          <blockquote class="gmail_quote" style="margin:0 0 0
            .8ex;border-left:1px #ccc solid;padding-left:1ex">
            <div text="#000000" bgcolor="#FFFFFF">
              <p>HI Luis,</p>
              <p><br>
              </p>
              <p>Let us trace the issue one by one.</p>
              <p><br>
              </p>
              <p>IB test fail:</p>
              <p>This should be regression issue on 4.18, you can bisect
                the kernel patches.</p>
              <p>GPU hang:</p>
              <p>Fix IB test fail first.</p>
              <p><br>
              </p>
              <p>Thanks</p>
              <span class="HOEnZb"><font color="#888888">
                  <p>JimQu<br>
                  </p>
                </font></span>
              <div>
                <div class="h5">
                  <p><br>
                  </p>
                  <br>
                  <div class="m_-5542977703135971300moz-cite-prefix">On
                    2018年07月11日 17:34, Luís Mendes wrote:<br>
                  </div>
                  <blockquote type="cite">
                    <div dir="ltr">
                      <div>Hi Jim,</div>
                      <div><br>
                      </div>
                      <div>Thanks for your interest in this issue.
                        Actually this is a multiple issue... not only
                        the IB ring test is failing... as I am having
                        quite some trouble getting the cards SAPPHIRE RX
                        550 4GB on a Tyan S7025 and SAPPHIRE RX 460 2GB
                        on a TYAN S7002 to work, both systems using same
                        Ubuntu 18.04 with vanilla kernel.<br>
                      </div>
                      <div><br>
                      </div>
                      <div><b>1. May you also test earlier kernel? v4.17
                          or v4.16.</b><br>
                      </div>
                      <div>I've tested kernels v4.17.5 and v4.16.6 with
                        same system and both are able to pass the IB
                        ring test and system boots into X using NVIDIA
                        as the display connected card.</div>
                      <div>dmesg log attached for kernel 4.17.5, file
                        TYAN_S7025_kernelv4.17.5_<wbr>amdgpu_IB_ring_test_OK.txt.<br>
                      </div>
                      <div><br>
                      </div>
                      <div><b>2. May you test the issue only with
                          amdgpu?</b></div>
                      <div>
                        <div>- I've tested on a TYAN S7002 system with a
                          single SAPPHIRE RX 460 2GB, on-board VGA
                          enabled and used as primary display.</div>
                        <div>Kernel v4.18-rc4 fails the IB ring test,
                          system is able to enter X through the on-board
                          VGA. <br>
                        </div>
                        <div>dmesg log attached for kernel 4.18-rc4,
                          file TYAN_S7002_kernel_v4.18-rc4_<wbr>IB_ring_test_fail.txt.</div>
                        <div><br>
                        </div>
                        <div>- Same TYAN S7002 system, but now with
                          on-board VGA disabled and using RX 460 as
                          display connected card.<br>
                        </div>
                        <div>
                          <div>Kernels v4.17.5 and v4.16.6 are able to
                            pass the IB ring test, but GPU hangs before
                            entering X. Don't have logs for these yet.<br>
                          </div>
                          <br>
                          <div>Regards,</div>
                          <div>Luís Mendes</div>
                          <div>Aparapi contributor and MSc Researcher<br>
                          </div>
                          <div><br>
                          </div>
                          <div><br>
                          </div>
                          <br>
                        </div>
                        <br>
                      </div>
                    </div>
                    <div class="gmail_extra"><br>
                      <div class="gmail_quote">On Wed, Jul 11, 2018 at
                        3:49 AM, Qu, Jim <span dir="ltr">&lt;<a
                            href="mailto:Jim.Qu-5C7GfCeVMHo@public.gmane.org" target="_blank"
                            moz-do-not-send="true">Jim.Qu-5C7GfCeVMHo@public.gmane.org</a>&gt;</span>
                        wrote:<br>
                        <blockquote class="gmail_quote" style="margin:0
                          0 0 .8ex;border-left:1px #ccc
                          solid;padding-left:1ex">Hi Luis,<br>
                          <br>
                          1. May you also test earlier kernel? v4.17 or
                          v4.16.<br>
                          2. May you test the issue only with amdgpu?<br>
                          <br>
                          Thanks<br>
                          JimQu<br>
                          <br>
                          ______________________________<wbr>__________<br>
                          发件人: amd-gfx &lt;<a
                            href="mailto:amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org"
                            target="_blank" moz-do-not-send="true">amd-gfx-bounces-PD4FTy7X32mqWrfYKbYh0A@public.gmane.org<wbr>ktop.org</a>&gt;
                          代表 Luís Mendes &lt;<a
                            href="mailto:luis.p.mendes-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org"
                            target="_blank" moz-do-not-send="true">luis.p.mendes-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt;<br>
                          发送时间: 2018年7月11日 6:04:00<br>
                          收件人: Michel Dänzer; Koenig, Christian; amd-gfx
                          list<br>
                          主题: Re: Regression with kernel 4.18 - AMD RX
                          550 fails IB ring test on power-up<br>
                          <span class="m_-5542977703135971300im
                            m_-5542977703135971300HOEnZb"><br>
                            Hi,<br>
                            <br>
                            Issue remains in kernel 4.18-rc4 using
                            SAPPHIRE RX 550 4GB.<br>
                            <br>
                            Logs follow attached.<br>
                            <br>
                            Regards,<br>
                            Luis<br>
                            <br>
                          </span>
                          <div class="m_-5542977703135971300HOEnZb">
                            <div class="m_-5542977703135971300h5">On
                              Tue, Jun 26, 2018 at 10:08 AM, Luís Mendes
                              &lt;<a
                                href="mailto:luis.p.mendes-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org"
                                target="_blank" moz-do-not-send="true">luis.p.mendes-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&lt;mailt<wbr>o:<a
                                href="mailto:luis.p.mendes-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org"
                                target="_blank" moz-do-not-send="true">luis.p.mendes-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt;&gt;
                              wrote:<br>
                              Hi,<br>
                              <br>
                              I've tried kernel 4.18-rc2 on a system
                              with a NVIDIA GTX 1050 Ti and an AMD RX
                              550 4GB and the RX 550 card is failing the
                              IB ring test.<br>
                              <br>
                              [    5.033217] [drm:gfx_v8_0_ring_test_ib
                              [amdgpu]] *ERROR* amdgpu: ib test failed
                              (scratch(0xC040)=0xFFFFFFFF)<br>
                              [    5.033264] [drm:amdgpu_ib_ring_tests
                              [amdgpu]] *ERROR* amdgpu: failed testing
                              IB on ring 6 (-22).<br>
                              <br>
                              Please see the attached log.<br>
                              <br>
                              Regards,<br>
                              Luís<br>
                              <br>
                            </div>
                          </div>
                        </blockquote>
                      </div>
                      <br>
                    </div>
                  </blockquote>
                  <br>
                </div>
              </div>
            </div>
          </blockquote>
        </div>
        <br>
      </div>
    </blockquote>
    <br>
  </body>
</html>

--------------68C0E77F0E409F6F60D1C803--

--===============1622578313==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1622578313==--
