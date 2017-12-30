From: Andrey Grodzovsky <Andrey.Grodzovsky-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] Revert "drm/amd/amdgpu: set gtt size according to system
 memory size only"
Date: Sat, 30 Dec 2017 15:02:04 -0500
Message-ID: <4610d737-d122-8a52-429c-1d6bc4064746@amd.com>
References: <f817cb0f-9c6f-472b-8bdc-025b34da595a@email.android.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------C15D2C78EF12A5277D511F30"
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <f817cb0f-9c6f-472b-8bdc-025b34da595a-2ueSQiBKiTY7tOexoI0I+QC/G2K4zDHf@public.gmane.org>
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
To: "Koenig, Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>, "Kuehling, Felix" <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>
Cc: "Daenzer, Michel" <Michel.Daenzer-5C7GfCeVMHo@public.gmane.org>, "He, Roger" <Hongbo.He-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

This is a multi-part message in MIME format.
--------------C15D2C78EF12A5277D511F30
Content-Type: multipart/alternative;
 boundary="------------233B4B644893ECCDEE16E7F4"

--------------233B4B644893ECCDEE16E7F4
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit



On 12/29/2017 03:19 PM, Koenig, Christian wrote:
> The difference is that the OOM killer doesn't know of the pages an 
> application allocates through the driver.
>
> This results in a bad decision which process to kill.
>
> I had patches to fix this a long time ago on the list, but never found 
> time to clean them up and push them upstream.
>
> Andrey is now working on this, but I don't know the status of hand.
>
> Christian.

Don't have updates since the last status I sent on this (on vacation 
currently), so will just reiterate the last  status here -

"Worked a bit more on this, did find a function to properly get free 
swap space but this solution is not working for when evicting to swap a 
BO from LRU list which is larger then available RAM (as you predicted) 
and it causes OOM in the swapper work thread, as you can see from 
attachment shmem_read_mapping_page will use default allocation policy 
for swap pages while I think we should have used __GFP_RETRY_MAYFAIL 
here and the way to do it is to use shmem_read_mapping_page_gfp which 
allows to set GFP flags.

In general I think that the approach you suggested (and then one i was 
advised at #mm channel) is the right one, to avoid OOM killer we should 
not try to do any estimations on free RAM or SWAP since it's not 
reliable any way to assume that by the time we allocate things will not 
change, what we should do is to allocate pages without triggering OOM 
killer. I think I should again to try and set all system page allocation 
code paths we use to __GFP_RETRY_MAYFAIL and debug again why it didn't 
work last time. One reason could be because i missed the SWAP pages 
allocation, another is a possible memory leak when failing allocation 
and rolling back all previously allocated pages for the BO, which leads 
to OOM anyway. "

Thanks,
Andrey

>
> Am 29.12.2017 20:36 schrieb "Kuehling, Felix" <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>:
>
>     Is it possible that the test is broken? A test that allocates
>     memory to
>     exhaustion may well trigger the OOM killer. A test can do that by
>     using
>     malloc. Why not by using the graphics driver? The OOM killer does what
>     it's supposed to do, and kills the broken application.
>
>     As I understand it, this change is adds artificial limitations to
>     workaround a bug in a user mode test. However, it ends up limiting the
>     memory available for well behaved applications, more than necessary.
>
>     For compute applications that work with huge data sets, we want to be
>     able to allocate lots of system memory. Tying available system
>     memory to
>     the VRAM size makes no sense for compute applications that want to
>     work
>     with such huge data sets.
>
>     Regards,
>       Felix
>
>
>     On 2017-12-15 02:09 PM, Andrey Grodzovsky wrote:
>     > This reverts commit ba851eed895c76be0eb4260bdbeb7e26f9ccfaa2.
>     > With that change piglit max size tests (running with -t
>     max.*size) are causing
>     > OOM and hard hang on my CZ with 1GB RAM.
>     >
>     > Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky-5C7GfCeVMHo@public.gmane.org>
>     > ---
>     >  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 8 +++++---
>     >  1 file changed, 5 insertions(+), 3 deletions(-)
>     >
>     > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>     b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>     > index c307a7d..814a9c1 100644
>     > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>     > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>     > @@ -1329,9 +1329,11 @@ int amdgpu_ttm_init(struct amdgpu_device
>     *adev)
>     >                struct sysinfo si;
>     >
>     >                si_meminfo(&si);
>     > -             gtt_size = max(AMDGPU_DEFAULT_GTT_SIZE_MB << 20,
>     > -                     (uint64_t)si.totalram * si.mem_unit * 3/4);
>     > -     } else
>     > +             gtt_size = min(max((AMDGPU_DEFAULT_GTT_SIZE_MB << 20),
>     > + adev->mc.mc_vram_size),
>     > + ((uint64_t)si.totalram * si.mem_unit * 3/4));
>     > +     }
>     > +     else
>     >                gtt_size = (uint64_t)amdgpu_gtt_size << 20;
>     >        r = ttm_bo_init_mm(&adev->mman.bdev, TTM_PL_TT, gtt_size
>     >> PAGE_SHIFT);
>     >        if (r) {
>
>


--------------233B4B644893ECCDEE16E7F4
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
    <div class="moz-cite-prefix">On 12/29/2017 03:19 PM, Koenig,
      Christian wrote:<br>
    </div>
    <blockquote type="cite"
      cite="mid:f817cb0f-9c6f-472b-8bdc-025b34da595a-2ueSQiBKiTY7tOexoI0I+QC/G2K4zDHf@public.gmane.org">
      <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
      <div dir="auto">The difference is that the OOM killer doesn't know
        of the pages an application allocates through the driver.
        <div dir="auto"><br>
        </div>
        <div dir="auto">This results in a bad decision which process to
          kill.</div>
        <div dir="auto"><br>
        </div>
        <div dir="auto">I had patches to fix this a long time ago on the
          list, but never found time to clean them up and push them
          upstream.</div>
        <div dir="auto"><br>
        </div>
        <div dir="auto">Andrey is now working on this, but I don't know
          the status of hand.</div>
        <div dir="auto"><br>
        </div>
        <div dir="auto">Christian.</div>
      </div>
    </blockquote>
    <br>
    Don't have updates since the last status I sent on this (on vacation
    currently), so will just reiterate the last  status here - <br>
    <br>
    "Worked a bit more on this, did find a function to properly get free
    swap space but this solution is not working for when evicting to
    swap a BO from LRU list which is larger then available RAM (as you
    predicted) and it causes OOM in the swapper work thread, as you can
    see from attachment shmem_read_mapping_page will use default
    allocation policy for swap pages while I think we should have used
    __GFP_RETRY_MAYFAIL here and the way to do it is to use
    shmem_read_mapping_page_gfp which allows to set GFP flags.
    <br>
    <br>
    In general I think that the approach you suggested (and then one i
    was advised at #mm channel) is the right one, to avoid OOM killer we
    should not try to do any estimations on free RAM or SWAP since it's
    not reliable any way to assume that by the time we allocate things
    will not change, what we should do is to allocate pages without
    triggering OOM killer. I think I should again to try and set all
    system page allocation code paths we use to __GFP_RETRY_MAYFAIL and
    debug again why it didn't work last time. One reason could be
    because i missed the SWAP pages allocation, another is a possible
    memory leak when failing allocation and rolling back all previously
    allocated pages for the BO, which leads to OOM anyway. "<br>
    <br>
    Thanks,<br>
    Andrey<br>
    <br>
    <blockquote type="cite"
      cite="mid:f817cb0f-9c6f-472b-8bdc-025b34da595a-2ueSQiBKiTY7tOexoI0I+QC/G2K4zDHf@public.gmane.org">
      <div dir="auto">
      </div>
      <div class="gmail_extra"><br>
        <div class="gmail_quote">Am 29.12.2017 20:36 schrieb "Kuehling,
          Felix" <a class="moz-txt-link-rfc2396E" href="mailto:Felix.Kuehling-5C7GfCeVMHo@public.gmane.org">&lt;Felix.Kuehling-5C7GfCeVMHo@public.gmane.org&gt;</a>:<br type="attribution">
          <blockquote class="quote" style="margin:0 0 0
            .8ex;border-left:1px #ccc solid;padding-left:1ex">
            <div><font size="2"><span style="font-size:11pt">
                  <div>Is it possible that the test is broken? A test
                    that allocates memory to<br>
                    exhaustion may well trigger the OOM killer. A test
                    can do that by using<br>
                    malloc. Why not by using the graphics driver? The
                    OOM killer does what<br>
                    it's supposed to do, and kills the broken
                    application.<br>
                    <br>
                    As I understand it, this change is adds artificial
                    limitations to<br>
                    workaround a bug in a user mode test. However, it
                    ends up limiting the<br>
                    memory available for well behaved applications, more
                    than necessary.<br>
                    <br>
                    For compute applications that work with huge data
                    sets, we want to be<br>
                    able to allocate lots of system memory. Tying
                    available system memory to<br>
                    the VRAM size makes no sense for compute
                    applications that want to work<br>
                    with such huge data sets.<br>
                    <br>
                    Regards,<br>
                      Felix<br>
                    <br>
                    <br>
                    On 2017-12-15 02:09 PM, Andrey Grodzovsky wrote:<br>
                    &gt; This reverts commit
                    ba851eed895c76be0eb4260bdbeb7e26f9ccfaa2.<br>
                    &gt; With that change piglit max size tests (running
                    with -t max.*size) are causing<br>
                    &gt; OOM and hard hang on my CZ with 1GB RAM.<br>
                    &gt;<br>
                    &gt; Signed-off-by: Andrey Grodzovsky
                    <a class="moz-txt-link-rfc2396E" href="mailto:andrey.grodzovsky-5C7GfCeVMHo@public.gmane.org">&lt;andrey.grodzovsky-5C7GfCeVMHo@public.gmane.org&gt;</a><br>
                    &gt; ---<br>
                    &gt;  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 8
                    +++++---<br>
                    &gt;  1 file changed, 5 insertions(+), 3
                    deletions(-)<br>
                    &gt;<br>
                    &gt; diff --git
                    a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
                    b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c<br>
                    &gt; index c307a7d..814a9c1 100644<br>
                    &gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c<br>
                    &gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c<br>
                    &gt; @@ -1329,9 +1329,11 @@ int
                    amdgpu_ttm_init(struct amdgpu_device *adev)<br>
                    &gt;                struct sysinfo si;<br>
                    &gt;  <br>
                    &gt;                si_meminfo(&amp;si);<br>
                    &gt; -             gtt_size =
                    max(AMDGPU_DEFAULT_GTT_SIZE_MB &lt;&lt; 20,<br>
                    &gt; -                     (uint64_t)si.totalram *
                    si.mem_unit * 3/4);<br>
                    &gt; -     } else<br>
                    &gt; +             gtt_size =
                    min(max((AMDGPU_DEFAULT_GTT_SIZE_MB &lt;&lt; 20),<br>
                    &gt; +                           
                    adev-&gt;mc.mc_vram_size),<br>
                    &gt; +                           
                    ((uint64_t)si.totalram * si.mem_unit * 3/4));<br>
                    &gt; +     }<br>
                    &gt; +     else<br>
                    &gt;                gtt_size =
                    (uint64_t)amdgpu_gtt_size &lt;&lt; 20;<br>
                    &gt;        r =
                    ttm_bo_init_mm(&amp;adev-&gt;mman.bdev, TTM_PL_TT,
                    gtt_size &gt;&gt; PAGE_SHIFT);<br>
                    &gt;        if (r) {<!-- --><br>
                    <br>
                  </div>
                </span></font></div>
          </blockquote>
        </div>
        <br>
      </div>
    </blockquote>
    <br>
  </body>
</html>

--------------233B4B644893ECCDEE16E7F4--

--------------C15D2C78EF12A5277D511F30
Content-Type: text/plain; charset=UTF-8;
 name="swap_oom"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="swap_oom"

WyAgNjk5LjEwNjk1MyA8ICAgOTMuMTI3NTMyPl0gW2RybV0gZnJlZSBzd2FwIDIxMTYyODQ0
MTYKWyAgNzI3LjIxOTgwOSA8ICAgMjguMTEyODU2Pl0gW2RybV0gZnJlZSBzd2FwIDIxMTYy
ODQ0MTYKWyAgNzQ3LjExNTIzNSA8ICAgMTkuODk1NDI2Pl0gW2RybV0gZnJlZSBzd2FwIDE1
Nzk5Mzc3OTIKWyAgNzQ4Ljc0MTA2MSA8ICAgIDEuNjI1ODI2Pl0ga3dvcmtlci91ODozIGlu
dm9rZWQgb29tLWtpbGxlcjogZ2ZwX21hc2s9MHgxNDIwMGNhKEdGUF9ISUdIVVNFUl9NT1ZB
QkxFKSwgbm9kZW1hc2s9KG51bGwpLCBvcmRlcj0wLCBvb21fc2NvcmVfYWRqPTAKWyAgNzQ4
Ljc0MTA2NSA8ICAgIDAuMDAwMDA0Pl0ga3dvcmtlci91ODozIGNwdXNldD0vIG1lbXNfYWxs
b3dlZD0wClsgIDc0OC43NDEwNzggPCAgICAwLjAwMDAxMz5dIENQVTogMyBQSUQ6IDE1NyBD
b21tOiBrd29ya2VyL3U4OjMgVGFpbnRlZDogRyAgICAgICAgVyAgT0UgICAgNC4xNS4wLXJj
MisgIzcKWyAgNzQ4Ljc0MTA4MCA8ICAgIDAuMDAwMDAyPl0gSGFyZHdhcmUgbmFtZTogQU1E
IEdhcmRlbmlhL0dhcmRlbmlhLCBCSU9TIFJHQTExMDFDIDA3LzIwLzIwMTUKWyAgNzQ4Ljc0
MTEwNiA8ICAgIDAuMDAwMDI2Pl0gV29ya3F1ZXVlOiB0dG1fc3dhcCB0dG1fc2hyaW5rX3dv
cmsgW3R0bV0KWyAgNzQ4Ljc0MTEwOCA8ICAgIDAuMDAwMDAyPl0gQ2FsbCBUcmFjZToKWyAg
NzQ4Ljc0MTEyMCA8ICAgIDAuMDAwMDEyPl0gIGR1bXBfc3RhY2srMHg1Yy8weDc4ClsgIDc0
OC43NDExMjcgPCAgICAwLjAwMDAwNz5dICBkdW1wX2hlYWRlcisweGMwLzB4NDQ4ClsgIDc0
OC43NDExMzMgPCAgICAwLjAwMDAwNj5dICA/IHRhc2tfd2lsbF9mcmVlX21lbSsweDk4LzB4
MjAwClsgIDc0OC43NDExMzggPCAgICAwLjAwMDAwNT5dICA/IF9yYXdfc3Bpbl90cnlsb2Nr
KzB4ZS8weDMwClsgIDc0OC43NDExNDIgPCAgICAwLjAwMDAwND5dICA/IF9fX3JhdGVsaW1p
dCsweDEwNS8weDE5MApbICA3NDguNzQxMTQ3IDwgICAgMC4wMDAwMDU+XSAgb29tX2tpbGxf
cHJvY2VzcysweDM2OS8weDZiMApbICA3NDguNzQxMTUxIDwgICAgMC4wMDAwMDQ+XSAgPyBv
b21fYmFkbmVzcysweDFhMC8weDIyMApbICA3NDguNzQxMTU2IDwgICAgMC4wMDAwMDU+XSAg
PyBvb21fZXZhbHVhdGVfdGFzaysweDE4My8weDFmMApbICA3NDguNzQxMTYxIDwgICAgMC4w
MDAwMDU+XSAgb3V0X29mX21lbW9yeSsweDFkZS8weDc5MApbICA3NDguNzQxMTY2IDwgICAg
MC4wMDAwMDU+XSAgPyBvb21fa2lsbGVyX2Rpc2FibGUrMHgxNzAvMHgxNzAKWyAgNzQ4Ljc0
MTE3MSA8ICAgIDAuMDAwMDA1Pl0gID8gY3B1bWFza19uZXh0KzB4MTYvMHgyMApbICA3NDgu
NzQxMTc2IDwgICAgMC4wMDAwMDU+XSAgPyB6b25lX3JlY2xhaW1hYmxlX3BhZ2VzKzB4MjRm
LzB4MjkwClsgIDc0OC43NDExODAgPCAgICAwLjAwMDAwND5dICA/IF9fem9uZV93YXRlcm1h
cmtfb2srMHhhZS8weDIwMApbICA3NDguNzQxMTg2IDwgICAgMC4wMDAwMDY+XSAgX19hbGxv
Y19wYWdlc19zbG93cGF0aCsweDExZGIvMHgxMmEwClsgIDc0OC43NDExOTQgPCAgICAwLjAw
MDAwOD5dICA/IHdhcm5fYWxsb2MrMHgyMTAvMHgyMTAKWyAgNzQ4Ljc0MTE5OSA8ICAgIDAu
MDAwMDA1Pl0gID8gcmFkaXhfdHJlZV9ub2RlX2FsbG9jLmNvbnN0cHJvcC4xOCsweGM2LzB4
MTUwClsgIDc0OC43NDEyMDUgPCAgICAwLjAwMDAwNj5dICA/IGthc2FuX2ttYWxsb2MrMHhh
Ni8weGQwClsgIDc0OC43NDEyMTEgPCAgICAwLjAwMDAwNj5dICBfX2FsbG9jX3BhZ2VzX25v
ZGVtYXNrKzB4MzdmLzB4M2MwClsgIDc0OC43NDEyMTcgPCAgICAwLjAwMDAwNj5dICA/IF9f
YWxsb2NfcGFnZXNfc2xvd3BhdGgrMHgxMmEwLzB4MTJhMApbICA3NDguNzQxMjIyIDwgICAg
MC4wMDAwMDU+XSAgPyBfX3JhZGl4X3RyZWVfaW5zZXJ0KzB4MmY3LzB4MzQwClsgIDc0OC43
NDEyMjggPCAgICAwLjAwMDAwNj5dICBhbGxvY19wYWdlc192bWErMHg4My8weDI4MApbICA3
NDguNzQxMjM0IDwgICAgMC4wMDAwMDY+XSAgc2htZW1fYWxsb2NfcGFnZSsweGJjLzB4MTEw
ClsgIDc0OC43NDEyMzkgPCAgICAwLjAwMDAwNT5dICA/IHNobWVtX3N3YXBpbisweDExMC8w
eDExMApbICA3NDguNzQxMjQzIDwgICAgMC4wMDAwMDQ+XSAgPyByZWxlYXNlX3BhZ2VzKzB4
NDMxLzB4NTcwClsgIDc0OC43NDEyNDcgPCAgICAwLjAwMDAwND5dICA/IF9fcmFkaXhfdHJl
ZV9sb29rdXArMHgxMjIvMHgxNTAKWyAgNzQ4Ljc0MTI1MyA8ICAgIDAuMDAwMDA2Pl0gID8g
cmFkaXhfdHJlZV9sb29rdXBfc2xvdCsweDUzLzB4OTAKWyAgNzQ4Ljc0MTI1OSA8ICAgIDAu
MDAwMDA2Pl0gIHNobWVtX2FsbG9jX2FuZF9hY2N0X3BhZ2UrMHhjMC8weDMwMApbICA3NDgu
NzQxMjY1IDwgICAgMC4wMDAwMDY+XSAgc2htZW1fZ2V0cGFnZV9nZnAuaXNyYS4zNSsweDIy
NS8weDExMTAKWyAgNzQ4Ljc0MTI3MiA8ICAgIDAuMDAwMDA3Pl0gID8gX19tdXRleF9pbml0
KzB4NGMvMHg2MApbICA3NDguNzQxMjc3IDwgICAgMC4wMDAwMDU+XSAgPyBzaG1lbV9hZGRf
dG9fcGFnZV9jYWNoZSsweDQ3MC8weDQ3MApbICA3NDguNzQxMjgyIDwgICAgMC4wMDAwMDU+
XSAgPyBfX2RfaW5zdGFudGlhdGUrMHgxMjIvMHgxNjAKWyAgNzQ4Ljc0MTI4NyA8ICAgIDAu
MDAwMDA1Pl0gID8gYWxsb2NfZmlsZSsweDE1NS8weDFjMApbICA3NDguNzQxMjkyIDwgICAg
MC4wMDAwMDU+XSAgPyBfX3NobWVtX2ZpbGVfc2V0dXArMHgxNzQvMHgzMDAKWyAgNzQ4Ljc0
MTI5OCA8ICAgIDAuMDAwMDA2Pl0gIHNobWVtX3JlYWRfbWFwcGluZ19wYWdlX2dmcCsweDk0
LzB4ZTAKWyAgNzQ4Ljc0MTMwNCA8ICAgIDAuMDAwMDA2Pl0gID8gc2htZW1fZ2V0cGFnZV9n
ZnAuaXNyYS4zNSsweDExMTAvMHgxMTEwClsgIDc0OC43NDEzMDggPCAgICAwLjAwMDAwND5d
ICA/IHBhZ2VfbWFwcGluZysweDliLzB4MTEwClsgIDc0OC43NDEzMTIgPCAgICAwLjAwMDAw
ND5dICA/IG1hcmtfcGFnZV9hY2Nlc3NlZCsweGE4LzB4MWUwClsgIDc0OC43NDEzMzEgPCAg
ICAwLjAwMDAxOT5dICB0dG1fdHRfc3dhcG91dCsweDEwNS8weDM4MCBbdHRtXQpbICA3NDgu
NzQxMzU0IDwgICAgMC4wMDAwMjM+XSAgdHRtX2JvX3N3YXBvdXQrMHgzNGIvMHgzODAgW3R0
bV0KWyAgNzQ4Ljc0MTM3NiA8ICAgIDAuMDAwMDIyPl0gID8gdHRtX2JvX3VubWFwX3ZpcnR1
YWwrMHg1MC8weDUwIFt0dG1dClsgIDc0OC43NDEzODIgPCAgICAwLjAwMDAwNj5dICA/IHNj
aGVkX2Nsb2NrKzB4NS8weDEwClsgIDc0OC43NDEzODcgPCAgICAwLjAwMDAwNT5dICA/IHZ0
aW1lX2FjY291bnRfaWRsZSsweDY3LzB4NzAKWyAgNzQ4Ljc0MTM5MiA8ICAgIDAuMDAwMDA1
Pl0gID8gX19zY2hlZHVsZSsweDY4Yi8weGNmMApbICA3NDguNzQxNDEyIDwgICAgMC4wMDAw
MjA+XSAgdHRtX3NocmluaysweGZkLzB4MTMwIFt0dG1dClsgIDc0OC43NDE0MTggPCAgICAw
LjAwMDAwNj5dICBwcm9jZXNzX29uZV93b3JrKzB4MmEyLzB4NmQwClsgIDc0OC43NDE0MjMg
PCAgICAwLjAwMDAwNT5dICB3b3JrZXJfdGhyZWFkKzB4ODcvMHg3NzAKWyAgNzQ4Ljc0MTQz
MCA8ICAgIDAuMDAwMDA3Pl0gIGt0aHJlYWQrMHgxNzQvMHgxYzAKWyAgNzQ4Ljc0MTQzNCA8
ICAgIDAuMDAwMDA0Pl0gID8gcHJvY2Vzc19vbmVfd29yaysweDZkMC8weDZkMApbICA3NDgu
NzQxNDM5IDwgICAgMC4wMDAwMDU+XSAgPyBrdGhyZWFkX2Fzc29jaWF0ZV9ibGtjZysweDEz
MC8weDEzMApbICA3NDguNzQxNDQ0IDwgICAgMC4wMDAwMDU+XSAgcmV0X2Zyb21fZm9yaysw
eDFmLzB4MzAKWyAgNzQ4Ljc0MTQ0NyA8ICAgIDAuMDAwMDAzPl0gTWVtLUluZm86ClsgIDc0
OC43NDE0NTggPCAgICAwLjAwMDAxMT5dIGFjdGl2ZV9hbm9uOjAgaW5hY3RpdmVfYW5vbjow
IGlzb2xhdGVkX2Fub246MAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgYWN0aXZl
X2ZpbGU6NzEgaW5hY3RpdmVfZmlsZTo0MCBpc29sYXRlZF9maWxlOjAKICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIHVuZXZpY3RhYmxlOjAgZGlydHk6MCB3cml0ZWJhY2s6MCB1
bnN0YWJsZTowCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBzbGFiX3JlY2xhaW1h
YmxlOjU0MTkgc2xhYl91bnJlY2xhaW1hYmxlOjE1MzU4CiAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICBtYXBwZWQ6MTUxIHNobWVtOjIgcGFnZXRhYmxlczoxNTAyIGJvdW5jZTow
CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBmcmVlOjEyMzg0IGZyZWVfcGNwOjIg
ZnJlZV9jbWE6MApbICA3NDguNzQxNDY2IDwgICAgMC4wMDAwMDg+XSBOb2RlIDAgYWN0aXZl
X2Fub246MGtCIGluYWN0aXZlX2Fub246MGtCIGFjdGl2ZV9maWxlOjI4NGtCIGluYWN0aXZl
X2ZpbGU6MTYwa0IgdW5ldmljdGFibGU6MGtCIGlzb2xhdGVkKGFub24pOjBrQiBpc29sYXRl
ZChmaWxlKTowa0IgbWFwcGVkOjYwNGtCIGRpcnR5OjBrQiB3cml0ZWJhY2s6MGtCIHNobWVt
OjhrQiBzaG1lbV90aHA6IDBrQiBzaG1lbV9wbWRtYXBwZWQ6IDBrQiBhbm9uX3RocDogMGtC
IHdyaXRlYmFja190bXA6MGtCIHVuc3RhYmxlOjBrQiBhbGxfdW5yZWNsYWltYWJsZT8gbm8K
WyAgNzQ4Ljc0MTQ2OCA8ICAgIDAuMDAwMDAyPl0gTm9kZSAwIERNQSBmcmVlOjUwOTZrQiBt
aW46NjEya0IgbG93Ojc2NGtCIGhpZ2g6OTE2a0IgYWN0aXZlX2Fub246MGtCIGluYWN0aXZl
X2Fub246MGtCIGFjdGl2ZV9maWxlOjBrQiBpbmFjdGl2ZV9maWxlOjBrQiB1bmV2aWN0YWJs
ZTowa0Igd3JpdGVwZW5kaW5nOjBrQiBwcmVzZW50OjE1OTkya0IgbWFuYWdlZDoxNTkwOGtC
IG1sb2NrZWQ6MGtCIGtlcm5lbF9zdGFjazowa0IgcGFnZXRhYmxlczowa0IgYm91bmNlOjBr
QiBmcmVlX3BjcDowa0IgbG9jYWxfcGNwOjBrQiBmcmVlX2NtYTowa0IKWyAgNzQ4Ljc0MTQ3
OCA8ICAgIDAuMDAwMDEwPl0gbG93bWVtX3Jlc2VydmVbXTogMCAxMTI2IDExMjYgMTEyNgpb
ICA3NDguNzQxNDgzIDwgICAgMC4wMDAwMDU+XSBOb2RlIDAgRE1BMzIgZnJlZTo0NDQ0MGtC
IG1pbjo0NDQ0MGtCIGxvdzo1NTU0OGtCIGhpZ2g6NjY2NTZrQiBhY3RpdmVfYW5vbjowa0Ig
aW5hY3RpdmVfYW5vbjo3NmtCIGFjdGl2ZV9maWxlOjc2MGtCIGluYWN0aXZlX2ZpbGU6MjI0
a0IgdW5ldmljdGFibGU6MGtCIHdyaXRlcGVuZGluZzowa0IgcHJlc2VudDoyMDgwNzY0a0Ig
bWFuYWdlZDoxMTUzODA0a0IgbWxvY2tlZDowa0Iga2VybmVsX3N0YWNrOjUxMjBrQiBwYWdl
dGFibGVzOjYwMDhrQiBib3VuY2U6MGtCIGZyZWVfcGNwOjhrQiBsb2NhbF9wY3A6MGtCIGZy
ZWVfY21hOjBrQgpbICA3NDguNzQxNDkzIDwgICAgMC4wMDAwMTA+XSBsb3dtZW1fcmVzZXJ2
ZVtdOiAwIDAgMCAwClsgIDc0OC43NDE0OTggPCAgICAwLjAwMDAwNT5dIE5vZGUgMCBETUE6
IDAqNGtCIDEqOGtCIChVKSAwKjE2a0IgMSozMmtCIChVKSAxKjY0a0IgKFUpIDEqMTI4a0Ig
KFUpIDEqMjU2a0IgKFUpIDEqNTEya0IgKFUpIDIqMTAyNGtCIChVKSAxKjIwNDhrQiAoTSkg
MCo0MDk2a0IgPSA1MDk2a0IKWyAgNzQ4Ljc0MTUyMSA8ICAgIDAuMDAwMDIzPl0gTm9kZSAw
IERNQTMyOiAyOTcqNGtCIChVTUUpIDM5MCo4a0IgKE1FKSA0NzMqMTZrQiAoTUVIKSAzNDYq
MzJrQiAoVU1FKSAxNzIqNjRrQiAoVU0pIDUzKjEyOGtCIChVTSkgMTIqMjU2a0IgKFVNKSAz
KjUxMmtCIChVTSkgMCoxMDI0a0IgMCoyMDQ4a0IgMCo0MDk2a0IgPSA0NTM0OGtCClsgIDc0
OC43NDE2MjkgPCAgICAwLjAwMDEwOD5dIE5vZGUgMCBodWdlcGFnZXNfdG90YWw9MCBodWdl
cGFnZXNfZnJlZT0wIGh1Z2VwYWdlc19zdXJwPTAgaHVnZXBhZ2VzX3NpemU9MTA0ODU3NmtC
ClsgIDc0OC43NDE2MzMgPCAgICAwLjAwMDAwND5dIE5vZGUgMCBodWdlcGFnZXNfdG90YWw9
MCBodWdlcGFnZXNfZnJlZT0wIGh1Z2VwYWdlc19zdXJwPTAgaHVnZXBhZ2VzX3NpemU9MjA0
OGtCClsgIDc0OC43NDE2MzQgPCAgICAwLjAwMDAwMT5dIDI2OCB0b3RhbCBwYWdlY2FjaGUg
cGFnZXMKWyAgNzQ4Ljc0MTYzNyA8ICAgIDAuMDAwMDAzPl0gMTUgcGFnZXMgaW4gc3dhcCBj
YWNoZQpbICA3NDguNzQxNjQxIDwgICAgMC4wMDAwMDQ+XSBTd2FwIGNhY2hlIHN0YXRzOiBh
ZGQgOTgzMTM3LCBkZWxldGUgOTgzMTAxLCBmaW5kIDE5NDIvNDU3NgpbICA3NDguNzQxNjQy
IDwgICAgMC4wMDAwMDE+XSBGcmVlIHN3YXAgID0gMTM1NzgyMGtCClsgIDc0OC43NDE2NDQg
PCAgICAwLjAwMDAwMj5dIFRvdGFsIHN3YXAgPSAyMDkyMDI4a0IKWyAgNzQ4Ljc0MTY0NSA8
ICAgIDAuMDAwMDAxPl0gNTI0MTg5IHBhZ2VzIFJBTQpbICA3NDguNzQxNjQ3IDwgICAgMC4w
MDAwMDI+XSAwIHBhZ2VzIEhpZ2hNZW0vTW92YWJsZU9ubHkKWyAgNzQ4Ljc0MTY0OCA8ICAg
IDAuMDAwMDAxPl0gMjMxNzYxIHBhZ2VzIHJlc2VydmVkClsgIDc0OC43NDE2NTEgPCAgICAw
LjAwMDAwMz5dIDAgcGFnZXMgY21hIHJlc2VydmVkClsgIDc0OC43NDE2NTIgPCAgICAwLjAw
MDAwMT5dIDAgcGFnZXMgaHdwb2lzb25lZApbICA3NDguNzQxNjUzIDwgICAgMC4wMDAwMDE+
XSBVbnJlY2xhaW1hYmxlIHNsYWIgaW5mbzoKWyAgNzQ4Ljc0MTY1NSA8ICAgIDAuMDAwMDAy
Pl0gTmFtZSAgICAgICAgICAgICAgICAgICAgICBVc2VkICAgICAgIAo=
--------------C15D2C78EF12A5277D511F30
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--------------C15D2C78EF12A5277D511F30--
