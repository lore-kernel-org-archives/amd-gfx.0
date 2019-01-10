From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Trying to run AMD E9260 (Polaris 11) on NXP LS1012A-RDB
Date: Thu, 10 Jan 2019 11:59:34 +0100
Message-ID: <5ae96345-680a-221f-1b04-678cb61f7eca@gmail.com>
References: <CAGtoiRiubNF5fCwGvYbC_sxzFk10Ceg79ZsK2fPLXUzFvm_QZw@mail.gmail.com>
 <CADnq5_MC9PLzvouWT=4J_RXkmsAy7NF1bpB-geEgxa-XV1dgQQ@mail.gmail.com>
 <CAGtoiRjahq_zC=QbS3gNCQB-nA++=gs=kKVJhWKNXEY0QQ8y=g@mail.gmail.com>
 <CAGtoiRiPHW8a3afkO3ui5FtLP-OztBjVz6CgMgLifgLvnk4QOg@mail.gmail.com>
Reply-To: christian.koenig-5C7GfCeVMHo@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1195382125=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CAGtoiRiPHW8a3afkO3ui5FtLP-OztBjVz6CgMgLifgLvnk4QOg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
Cc: amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

This is a multi-part message in MIME format.
--===============1195382125==
Content-Type: multipart/alternative;
 boundary="------------201F6A530A7A2BA1E12F01E5"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------201F6A530A7A2BA1E12F01E5
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

> The PCI Express controller as instantiated on this chip does not 
> support hardware coherency. All incoming PCI Express transactions are 
> made non IO-coherent.
>
> Would AMDGPU still work with that PCI Express controller, or is this a 
> show-stopper?

I'm really wondering what this comment in the documentation means.

As far as I know PCIe doesn't support cache coherency in the downstream 
and supporting it in the up stream is a must have.

So what exactly is meant here with IO-coherent?

Regards,
Christian.

Am 10.01.19 um 11:55 schrieb Bas Vermeulen:
> Hi Alex,
>
> I've managed to get a little further. I am currently running mainline 
> (5.0.0-rc1) and am getting the errors below.
> Looking at the datasheet for the LS1012A, it mentions in the PCI 
> Express section that:
>
> The PCI Express controller as instantiated on this chip does not 
> support hardware coherency. All incoming PCI Express transactions are 
> made non IO-coherent.
>
> Would AMDGPU still work with that PCI Express controller, or is this a 
> show-stopper?
>
> [    5.727691] [drm] initializing kernel modesetting (POLARIS11 
> 0x1002:0x67E8 0x1DA2:0xE362 0x80).
> [    5.761767] [drm] register mmio base: 0x58000000
> [    5.777272] [drm] register mmio size: 262144
> [    5.825973] [drm] add ip block number 0 <vi_common>
> [    5.832242] [drm] add ip block number 1 <gmc_v8_0>
> [    5.837767] [drm] add ip block number 2 <tonga_ih>
> [    5.843121] [drm] add ip block number 3 <gfx_v8_0>
> [    5.848480] [drm] add ip block number 4 <sdma_v3_0>
> [    5.853969] [drm] add ip block number 5 <powerplay>
> [    5.859413] [drm] add ip block number 6 <dm>
> [    5.864238] [drm] add ip block number 7 <uvd_v6_0>
> [    5.869690] [drm] add ip block number 8 <vce_v3_0>
> [    5.875067] [drm] UVD is enabled in VM mode
> [    5.879858] [drm] UVD ENC is enabled in VM mode
> [    5.884985] [drm] VCE enabled in VM mode
> [    6.114020] ATOM BIOS: 113-C98511-U01
> [    6.117757] [drm] GPU posting now...
> [    6.238112] [drm] vm size is 64 GB, 2 levels, block size is 10-bit, 
> fragment size is 9-bit
> [    6.247290] amdgpu 0000:01:00.0: BAR 2: releasing [mem 
> 0x4050000000-0x40501fffff 64bit pref]
> [    6.257354] amdgpu 0000:01:00.0: BAR 0: releasing [mem 
> 0x4040000000-0x404fffffff 64bit pref]
> [    6.267261] pcieport 0000:00:00.0: BAR 15: releasing [mem 
> 0x4040000000-0x4057ffffff 64bit pref]
> [    6.277288] pcieport 0000:00:00.0: BAR 15: no space for [mem size 
> 0x300000000 64bit pref]
> [    6.286843] pcieport 0000:00:00.0: BAR 15: failed to assign [mem 
> size 0x300000000 64bit pref]
> [    6.296708] amdgpu 0000:01:00.0: BAR 0: no space for [mem size 
> 0x200000000 64bit pref]
> [    6.306009] amdgpu 0000:01:00.0: BAR 0: failed to assign [mem size 
> 0x200000000 64bit pref]
> [    6.315635] amdgpu 0000:01:00.0: BAR 2: no space for [mem size 
> 0x00200000 64bit pref]
> [    6.324804] amdgpu 0000:01:00.0: BAR 2: failed to assign [mem size 
> 0x00200000 64bit pref]
> [    6.334366] pcieport 0000:00:00.0: PCI bridge to [bus 01-ff]
> [    6.341323] pcieport 0000:00:00.0:   bridge window [io  0x1000-0x1fff]
> [    6.349158] pcieport 0000:00:00.0:   bridge window [mem 
> 0x4058000000-0x40580fffff]
> [    6.358095] pcieport 0000:00:00.0: PCI bridge to [bus 01-ff]
> [    6.365054] pcieport 0000:00:00.0:   bridge window [io  0x1000-0x1fff]
> [    6.372981] pcieport 0000:00:00.0:   bridge window [mem 
> 0x4058000000-0x40580fffff]
> [    6.381917] pcieport 0000:00:00.0:   bridge window [mem 
> 0x4040000000-0x4057ffffff 64bit pref]
> [    6.391789] [drm] Not enough PCI address space for a large BAR.
> [    6.391820] amdgpu 0000:01:00.0: BAR 0: assigned [mem 
> 0x4040000000-0x404fffffff 64bit pref]
> [    6.407776] amdgpu 0000:01:00.0: BAR 2: assigned [mem 
> 0x4050000000-0x40501fffff 64bit pref]
> [    6.417672] amdgpu 0000:01:00.0: VRAM: 8192M 0x000000F400000000 - 
> 0x000000F5FFFFFFFF (8192M used)
> [    6.426586] amdgpu 0000:01:00.0: GART: 256M 0x000000FF00000000 - 
> 0x000000FF0FFFFFFF
> [    6.436171] [drm] Detected VRAM RAM=8192M, BAR=256M
> [    6.478952] [drm] GART: num cpu pages 65536, num gpu pages 65536
> [    6.487871] [drm] PCIE GART of 256M enabled (table at 
> 0x000000F400000000).
> [    6.496316] amdgpu 0000:01:00.0: Direct firmware load for 
> amdgpu/polaris11_pfp_2.bin failed with error -2
> [    6.508078] amdgpu 0000:01:00.0: Direct firmware load for 
> amdgpu/polaris11_me_2.bin failed with error -2
> [    6.519538] amdgpu 0000:01:00.0: Direct firmware load for 
> amdgpu/polaris11_ce_2.bin failed with error -2
> [    6.531496] amdgpu 0000:01:00.0: Direct firmware load for 
> amdgpu/polaris11_mec_2.bin failed with error -2
> [    6.544214] amdgpu 0000:01:00.0: Direct firmware load for 
> amdgpu/polaris11_mec2_2.bin failed with error -2
> [    6.565121] [drm] Found UVD firmware Version: 1.79 Family ID: 16
> [    6.571241] [drm] UVD ENC is disabled
> [    6.580927] [drm] Found VCE firmware Version: 52.4 Binary ID: 3
> [    6.656854] amdgpu 0000:01:00.0: GPU fault detected: 147 0x00004802 
> for process  pid 0 thread  pid 0
> [    6.666013] amdgpu 0000:01:00.0: 
>  VM_CONTEXT1_PROTECTION_FAULT_ADDR   0x0017F000
> [    6.673508] amdgpu 0000:01:00.0: 
>  VM_CONTEXT1_PROTECTION_FAULT_STATUS 0x02048002
> [    6.681006] amdgpu 0000:01:00.0: VM fault (0x02, vmid 1, pasid 0) 
> at page 1568768, read from 'TC0' (0x54433000) (72)
> [    6.691557] amdgpu 0000:01:00.0: GPU fault detected: 147 0x00004402 
> for process  pid 0 thread  pid 0
> [    6.700706] amdgpu 0000:01:00.0: 
>  VM_CONTEXT1_PROTECTION_FAULT_ADDR   0x0017F000
> [    6.708200] amdgpu 0000:01:00.0: 
>  VM_CONTEXT1_PROTECTION_FAULT_STATUS 0x02048002
> [    6.715697] amdgpu 0000:01:00.0: VM fault (0x02, vmid 1, pasid 0) 
> at page 1568768, read from 'TC0' (0x54433000) (72)
> [    6.726246] amdgpu 0000:01:00.0: GPU fault detected: 147 0x00000402 
> for process  pid 0 thread  pid 0
> [    6.735395] amdgpu 0000:01:00.0: 
>  VM_CONTEXT1_PROTECTION_FAULT_ADDR   0x0017F000
> [    6.742889] amdgpu 0000:01:00.0: 
>  VM_CONTEXT1_PROTECTION_FAULT_STATUS 0x02048002
> [    6.750386] amdgpu 0000:01:00.0: VM fault (0x02, vmid 1, pasid 0) 
> at page 1568768, read from 'TC0' (0x54433000) (72)
> [    6.984485] amdgpu 0000:01:00.0: [drm:amdgpu_ring_test_helper 
> [amdgpu]] *ERROR* ring gfx test failed (-110)
> [    6.994562] [drm:amdgpu_device_init [amdgpu]] *ERROR* hw_init of IP 
> block <gfx_v8_0> failed -110
> [    7.004942] amdgpu 0000:01:00.0: amdgpu_device_ip_init failed
> [    7.011963] amdgpu 0000:01:00.0: Fatal error during GPU init
> [    7.018890] [drm] amdgpu: finishing device.
> [    7.308898] WARNING: CPU: 0 PID: 2084 at 
> /home/bas/linux/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c:915 
> amdgpu_bo_unpin+0xe4/0x110 [amdgpu]
> [    7.321451] Modules linked in: amdgpu(+) realtek chash gpu_sched 
> ttm drm_kms_helper drm crct10dif_ce drm_panel_orientation_quirks 
> pfe(C) ip_tables x_tables ipv6
> [    7.335850] CPU: 0 PID: 2084 Comm: systemd-udevd Tainted: G        
>  C 5.0.0-rc1-00001-g3bd6e94bec12-dirty #1
> [    7.346303] Hardware name: LS1012A RDB Board (DT)
> [    7.351014] pstate: 40000005 (nZcv daif -PAN -UAO)
> [    7.356090] pc : amdgpu_bo_unpin+0xe4/0x110 [amdgpu]
> [    7.361307] lr : amdgpu_bo_free_kernel+0x7c/0x148 [amdgpu]
> [    7.366799] sp : ffff0000118c3730
> [    7.370114] x29: ffff0000118c3730 x28: ffff000008e63710
> [    7.375434] x27: ffff0000118c3df0 x26: 0000000000000100
> [    7.380754] x25: ffff80003599cb60 x24: ffff8000359927d0
> [    7.386073] x23: ffff800035994750 x22: ffff8000359927d0
> [    7.391393] x21: ffff8000358cb800 x20: ffff0000111fd000
> [    7.396713] x19: ffff8000358cb800 x18: 000000000000001e
> [    7.402033] x17: 0000000000000000 x16: 0000000000000002
> [    7.407351] x15: 0000000000000400 x14: 0000000000000400
> [    7.412670] x13: 000000000000cb72 x12: 000000000000b308
> [    7.417989] x11: ffff7e0000d02488 x10: ffff800037798030
> [    7.423308] x9 : ffff0000118c36e4 x8 : 0000000000000000
> [    7.428627] x7 : 0000000000210d00 x6 : 0000000000000000
> [    7.433946] x5 : 0000000000000001 x4 : 0000000000000001
> [    7.439265] x3 : ffff8000358cb87c x2 : 0000000000000000
> [    7.444583] x1 : 0000000000000000 x0 : ffff8000358cb800
> [    7.449903] Call trace:
> [    7.452583]  amdgpu_bo_unpin+0xe4/0x110 [amdgpu]
> [    7.457437]  amdgpu_bo_free_kernel+0x7c/0x148 [amdgpu]
> [    7.462812]  amdgpu_gfx_rlc_fini+0x50/0x78 [amdgpu]
> [    7.467926]  gfx_v8_0_sw_fini+0xfc/0x1c0 [amdgpu]
> [    7.472864]  amdgpu_device_fini+0x1e0/0x480 [amdgpu]
> [    7.478058] amdgpu_driver_unload_kms+0xa0/0x150 [amdgpu]
> [    7.483686] amdgpu_driver_load_kms+0x144/0x1f8 [amdgpu]
> [    7.489110]  drm_dev_register+0x14c/0x1e0 [drm]
> [    7.493906]  amdgpu_pci_probe+0xcc/0x188 [amdgpu]
> [    7.498622]  local_pci_probe+0x3c/0xb0
> [    7.502375]  pci_device_probe+0x150/0x1b8
> [    7.506390]  really_probe+0x1f0/0x298
> [    7.510055]  driver_probe_device+0x58/0x100
> [    7.514242]  __driver_attach+0xd4/0xd8
> [    7.517993]  bus_for_each_dev+0x74/0xc8
> [    7.521832]  driver_attach+0x20/0x28
> [    7.525410]  bus_add_driver+0x1ac/0x218
> [    7.529250]  driver_register+0x60/0x110
> [    7.533089]  __pci_register_driver+0x40/0x48
> [    7.537599]  amdgpu_init+0x58/0x1000 [amdgpu]
> [    7.541964]  do_one_initcall+0x5c/0x178
> [    7.545804]  do_init_module+0x58/0x1b0
> [    7.549556]  load_module+0x1dc8/0x2178
> [    7.553308]  __se_sys_finit_module+0xbc/0xd0
> [    7.557582] __arm64_sys_finit_module+0x18/0x20
> [    7.562119]  el0_svc_common+0x60/0x100
> [    7.565872]  el0_svc_handler+0x2c/0x80
> [    7.581715] amdgpu 0000:01:00.0: (____ptrval____) unpin not necessary
> [    7.594743] [TTM] Finalizing pool allocator
> [    7.599867] [TTM] Finalizing DMA pool allocator
> [    7.605265] [TTM] Zone  kernel: Used memory at exit: 0 kiB
> [    7.611482] [drm] amdgpu: ttm finalized
> [    7.618028] amdgpu: probe of 0000:01:00.0 failed with error -110
>
> Bas Vermeulen
>
>
> On Thu, Dec 20, 2018 at 5:11 PM Bas Vermeulen <bas-MbI5SpmOCPBHdOctNixuYw@public.gmane.org 
> <mailto:bas-MbI5SpmOCPBHdOctNixuYw@public.gmane.org>> wrote:
>
>     Hi Alex,
>
>     I already have a similar patch in, that doesn't fix it just yet.
>     I'll investigate some more.
>
>     Bas Vermeulen
>
>     On Thu, Dec 20, 2018 at 4:27 PM Alex Deucher
>     <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org <mailto:alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>> wrote:
>
>         On Thu, Dec 20, 2018 at 9:06 AM Bas Vermeulen
>         <bas-MbI5SpmOCPBHdOctNixuYw@public.gmane.org <mailto:bas-MbI5SpmOCPBHdOctNixuYw@public.gmane.org>> wrote:
>         >
>         > Hi all,
>         >
>         > I have connected an E9260 (Polaris 11 based) to a mini-PCIe
>         slot on my NXP LS1012ARDB.
>         > The GPU is seen, all the BARs are correctly assigned (but
>         there's not enough PCIe memory space for the big BARs).
>         >
>         > When I try to load the amdgpu module, I can't get the driver
>         to enable the acceleration (the scratch register check fails).
>         >
>         > The E9260 is connected to a PCIe x1 (Gen2) slot.
>         >
>         > Anyone have an idea on where to look or how to fix this?
>         This is a test-bed before we get an LS1046ARDB with quad core
>         A72's.
>         >
>         > Any help would be appreciated,
>
>         Something like this patch should fix it assuming this is an
>         ARM based platform:
>         https://patchwork.freedesktop.org/patch/269367/
>
>         Alex
>
>         >
>         > Bas Vermeulen
>         > _______________________________________________
>         > amd-gfx mailing list
>         > amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
>         <mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
>         > https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx


--------------201F6A530A7A2BA1E12F01E5
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <div class="moz-cite-prefix">
      <blockquote type="cite">The PCI Express controller as instantiated
        on this chip does not
        support hardware coherency. All incoming PCI Express
        transactions are made non IO-coherent.
        <div><br>
        </div>
        <div>Would AMDGPU still work with that PCI Express controller,
          or is this a show-stopper?</div>
      </blockquote>
      <br>
      I'm really wondering what this comment in the documentation means.<br>
      <br>
      As far as I know PCIe doesn't support cache coherency in the
      downstream and supporting it in the up stream is a must have.<br>
      <br>
      So what exactly is meant here with IO-coherent?<br>
      <br>
      Regards,<br>
      Christian.<br>
      <br>
      Am 10.01.19 um 11:55 schrieb Bas Vermeulen:<br>
    </div>
    <blockquote type="cite"
cite="mid:CAGtoiRiPHW8a3afkO3ui5FtLP-OztBjVz6CgMgLifgLvnk4QOg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org">
      <meta http-equiv="content-type" content="text/html; charset=UTF-8">
      <div dir="ltr">
        <div dir="ltr">
          <div dir="ltr">
            <div dir="ltr">
              <div dir="ltr">Hi Alex,
                <div><br>
                </div>
                <div>I've managed to get a little further. I am
                  currently running mainline (5.0.0-rc1) and am getting
                  the errors below.</div>
                <div>Looking at the datasheet for the LS1012A, it
                  mentions in the PCI Express section that:<br>
                  <br>
                  The PCI Express controller as instantiated on this
                  chip does not
                  support hardware coherency. All incoming PCI Express
                  transactions are made non IO-coherent.</div>
                <div><br>
                </div>
                <div>Would AMDGPU still work with that PCI Express
                  controller, or is this a show-stopper?</div>
                <div><br>
                  <div>[    5.727691] [drm] initializing kernel
                    modesetting (POLARIS11 0x1002:0x67E8 0x1DA2:0xE362
                    0x80).</div>
                  <div>[    5.761767] [drm] register mmio base:
                    0x58000000</div>
                  <div>[    5.777272] [drm] register mmio size: 262144</div>
                  <div>[    5.825973] [drm] add ip block number 0
                    &lt;vi_common&gt;</div>
                  <div>[    5.832242] [drm] add ip block number 1
                    &lt;gmc_v8_0&gt;</div>
                  <div>[    5.837767] [drm] add ip block number 2
                    &lt;tonga_ih&gt;</div>
                  <div>[    5.843121] [drm] add ip block number 3
                    &lt;gfx_v8_0&gt;</div>
                  <div>[    5.848480] [drm] add ip block number 4
                    &lt;sdma_v3_0&gt;</div>
                  <div>[    5.853969] [drm] add ip block number 5
                    &lt;powerplay&gt;</div>
                  <div>[    5.859413] [drm] add ip block number 6
                    &lt;dm&gt;</div>
                  <div>[    5.864238] [drm] add ip block number 7
                    &lt;uvd_v6_0&gt;</div>
                  <div>[    5.869690] [drm] add ip block number 8
                    &lt;vce_v3_0&gt;</div>
                  <div>[    5.875067] [drm] UVD is enabled in VM mode</div>
                  <div>[    5.879858] [drm] UVD ENC is enabled in VM
                    mode</div>
                  <div>[    5.884985] [drm] VCE enabled in VM mode</div>
                  <div>[    6.114020] ATOM BIOS: 113-C98511-U01</div>
                  <div>[    6.117757] [drm] GPU posting now...</div>
                  <div>[    6.238112] [drm] vm size is 64 GB, 2 levels,
                    block size is 10-bit, fragment size is 9-bit</div>
                  <div>[    6.247290] amdgpu 0000:01:00.0: BAR 2:
                    releasing [mem 0x4050000000-0x40501fffff 64bit pref]</div>
                  <div>[    6.257354] amdgpu 0000:01:00.0: BAR 0:
                    releasing [mem 0x4040000000-0x404fffffff 64bit pref]</div>
                  <div>[    6.267261] pcieport 0000:00:00.0: BAR 15:
                    releasing [mem 0x4040000000-0x4057ffffff 64bit pref]</div>
                  <div>[    6.277288] pcieport 0000:00:00.0: BAR 15: no
                    space for [mem size 0x300000000 64bit pref]</div>
                  <div>[    6.286843] pcieport 0000:00:00.0: BAR 15:
                    failed to assign [mem size 0x300000000 64bit pref]</div>
                  <div>[    6.296708] amdgpu 0000:01:00.0: BAR 0: no
                    space for [mem size 0x200000000 64bit pref]</div>
                  <div>[    6.306009] amdgpu 0000:01:00.0: BAR 0: failed
                    to assign [mem size 0x200000000 64bit pref]</div>
                  <div>[    6.315635] amdgpu 0000:01:00.0: BAR 2: no
                    space for [mem size 0x00200000 64bit pref]</div>
                  <div>[    6.324804] amdgpu 0000:01:00.0: BAR 2: failed
                    to assign [mem size 0x00200000 64bit pref]</div>
                  <div>[    6.334366] pcieport 0000:00:00.0: PCI bridge
                    to [bus 01-ff]</div>
                  <div>[    6.341323] pcieport 0000:00:00.0:   bridge
                    window [io  0x1000-0x1fff]</div>
                  <div>[    6.349158] pcieport 0000:00:00.0:   bridge
                    window [mem 0x4058000000-0x40580fffff]</div>
                  <div>[    6.358095] pcieport 0000:00:00.0: PCI bridge
                    to [bus 01-ff]</div>
                  <div>[    6.365054] pcieport 0000:00:00.0:   bridge
                    window [io  0x1000-0x1fff]</div>
                  <div>[    6.372981] pcieport 0000:00:00.0:   bridge
                    window [mem 0x4058000000-0x40580fffff]</div>
                  <div>[    6.381917] pcieport 0000:00:00.0:   bridge
                    window [mem 0x4040000000-0x4057ffffff 64bit pref]</div>
                  <div>[    6.391789] [drm] Not enough PCI address space
                    for a large BAR.</div>
                  <div>[    6.391820] amdgpu 0000:01:00.0: BAR 0:
                    assigned [mem 0x4040000000-0x404fffffff 64bit pref]</div>
                  <div>[    6.407776] amdgpu 0000:01:00.0: BAR 2:
                    assigned [mem 0x4050000000-0x40501fffff 64bit pref]</div>
                  <div>[    6.417672] amdgpu 0000:01:00.0: VRAM: 8192M
                    0x000000F400000000 - 0x000000F5FFFFFFFF (8192M used)</div>
                  <div>[    6.426586] amdgpu 0000:01:00.0: GART: 256M
                    0x000000FF00000000 - 0x000000FF0FFFFFFF</div>
                  <div>[    6.436171] [drm] Detected VRAM RAM=8192M,
                    BAR=256M</div>
                  <div>[    6.478952] [drm] GART: num cpu pages 65536,
                    num gpu pages 65536</div>
                  <div>
                    <div>[    6.487871] [drm] PCIE GART of 256M enabled
                      (table at 0x000000F400000000).</div>
                    <div>[    6.496316] amdgpu 0000:01:00.0: Direct
                      firmware load for amdgpu/polaris11_pfp_2.bin
                      failed with error -2</div>
                    <div>[    6.508078] amdgpu 0000:01:00.0: Direct
                      firmware load for amdgpu/polaris11_me_2.bin failed
                      with error -2</div>
                    <div>[    6.519538] amdgpu 0000:01:00.0: Direct
                      firmware load for amdgpu/polaris11_ce_2.bin failed
                      with error -2</div>
                    <div>[    6.531496] amdgpu 0000:01:00.0: Direct
                      firmware load for amdgpu/polaris11_mec_2.bin
                      failed with error -2</div>
                    <div>[    6.544214] amdgpu 0000:01:00.0: Direct
                      firmware load for amdgpu/polaris11_mec2_2.bin
                      failed with error -2</div>
                    <div>[    6.565121] [drm] Found UVD firmware
                      Version: 1.79 Family ID: 16</div>
                    <div>[    6.571241] [drm] UVD ENC is disabled</div>
                    <div>[    6.580927] [drm] Found VCE firmware
                      Version: 52.4 Binary ID: 3</div>
                    <div>[    6.656854] amdgpu 0000:01:00.0: GPU fault
                      detected: 147 0x00004802 for process  pid 0
                      thread  pid 0</div>
                    <div>[    6.666013] amdgpu 0000:01:00.0: 
                       VM_CONTEXT1_PROTECTION_FAULT_ADDR   0x0017F000</div>
                    <div>[    6.673508] amdgpu 0000:01:00.0: 
                       VM_CONTEXT1_PROTECTION_FAULT_STATUS 0x02048002</div>
                    <div>[    6.681006] amdgpu 0000:01:00.0: VM fault
                      (0x02, vmid 1, pasid 0) at page 1568768, read from
                      'TC0' (0x54433000) (72)</div>
                    <div>[    6.691557] amdgpu 0000:01:00.0: GPU fault
                      detected: 147 0x00004402 for process  pid 0
                      thread  pid 0</div>
                    <div>[    6.700706] amdgpu 0000:01:00.0: 
                       VM_CONTEXT1_PROTECTION_FAULT_ADDR   0x0017F000</div>
                    <div>[    6.708200] amdgpu 0000:01:00.0: 
                       VM_CONTEXT1_PROTECTION_FAULT_STATUS 0x02048002</div>
                    <div>[    6.715697] amdgpu 0000:01:00.0: VM fault
                      (0x02, vmid 1, pasid 0) at page 1568768, read from
                      'TC0' (0x54433000) (72)</div>
                    <div>[    6.726246] amdgpu 0000:01:00.0: GPU fault
                      detected: 147 0x00000402 for process  pid 0
                      thread  pid 0</div>
                    <div>[    6.735395] amdgpu 0000:01:00.0: 
                       VM_CONTEXT1_PROTECTION_FAULT_ADDR   0x0017F000</div>
                    <div>[    6.742889] amdgpu 0000:01:00.0: 
                       VM_CONTEXT1_PROTECTION_FAULT_STATUS 0x02048002</div>
                    <div>[    6.750386] amdgpu 0000:01:00.0: VM fault
                      (0x02, vmid 1, pasid 0) at page 1568768, read from
                      'TC0' (0x54433000) (72)</div>
                    <div>[    6.984485] amdgpu 0000:01:00.0:
                      [drm:amdgpu_ring_test_helper [amdgpu]] *ERROR*
                      ring gfx test failed (-110)</div>
                    <div>[    6.994562] [drm:amdgpu_device_init
                      [amdgpu]] *ERROR* hw_init of IP block
                      &lt;gfx_v8_0&gt; failed -110</div>
                    <div>[    7.004942] amdgpu 0000:01:00.0:
                      amdgpu_device_ip_init failed</div>
                    <div>[    7.011963] amdgpu 0000:01:00.0: Fatal error
                      during GPU init</div>
                    <div>[    7.018890] [drm] amdgpu: finishing device.</div>
                  </div>
                </div>
                <div>
                  <div>[    7.308898] WARNING: CPU: 0 PID: 2084 at
                    /home/bas/linux/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c:915
                    amdgpu_bo_unpin+0xe4/0x110 [amdgpu]</div>
                  <div>[    7.321451] Modules linked in: amdgpu(+)
                    realtek chash gpu_sched ttm drm_kms_helper drm
                    crct10dif_ce drm_panel_orientation_quirks pfe(C)
                    ip_tables x_tables ipv6</div>
                  <div>[    7.335850] CPU: 0 PID: 2084 Comm:
                    systemd-udevd Tainted: G         C       
                    5.0.0-rc1-00001-g3bd6e94bec12-dirty #1</div>
                  <div>[    7.346303] Hardware name: LS1012A RDB Board
                    (DT)</div>
                  <div>[    7.351014] pstate: 40000005 (nZcv daif -PAN
                    -UAO)</div>
                  <div>[    7.356090] pc : amdgpu_bo_unpin+0xe4/0x110
                    [amdgpu]</div>
                  <div>[    7.361307] lr :
                    amdgpu_bo_free_kernel+0x7c/0x148 [amdgpu]</div>
                  <div>[    7.366799] sp : ffff0000118c3730</div>
                  <div>[    7.370114] x29: ffff0000118c3730 x28:
                    ffff000008e63710 </div>
                  <div>[    7.375434] x27: ffff0000118c3df0 x26:
                    0000000000000100 </div>
                  <div>[    7.380754] x25: ffff80003599cb60 x24:
                    ffff8000359927d0 </div>
                  <div>[    7.386073] x23: ffff800035994750 x22:
                    ffff8000359927d0 </div>
                  <div>[    7.391393] x21: ffff8000358cb800 x20:
                    ffff0000111fd000 </div>
                  <div>[    7.396713] x19: ffff8000358cb800 x18:
                    000000000000001e </div>
                  <div>[    7.402033] x17: 0000000000000000 x16:
                    0000000000000002 </div>
                  <div>[    7.407351] x15: 0000000000000400 x14:
                    0000000000000400 </div>
                  <div>[    7.412670] x13: 000000000000cb72 x12:
                    000000000000b308 </div>
                  <div>[    7.417989] x11: ffff7e0000d02488 x10:
                    ffff800037798030 </div>
                  <div>[    7.423308] x9 : ffff0000118c36e4 x8 :
                    0000000000000000 </div>
                  <div>[    7.428627] x7 : 0000000000210d00 x6 :
                    0000000000000000 </div>
                  <div>[    7.433946] x5 : 0000000000000001 x4 :
                    0000000000000001 </div>
                  <div>[    7.439265] x3 : ffff8000358cb87c x2 :
                    0000000000000000 </div>
                  <div>[    7.444583] x1 : 0000000000000000 x0 :
                    ffff8000358cb800 </div>
                  <div>[    7.449903] Call trace:</div>
                  <div>[    7.452583]  amdgpu_bo_unpin+0xe4/0x110
                    [amdgpu]</div>
                  <div>[    7.457437]  amdgpu_bo_free_kernel+0x7c/0x148
                    [amdgpu]</div>
                  <div>[    7.462812]  amdgpu_gfx_rlc_fini+0x50/0x78
                    [amdgpu]</div>
                  <div>[    7.467926]  gfx_v8_0_sw_fini+0xfc/0x1c0
                    [amdgpu]</div>
                  <div>[    7.472864]  amdgpu_device_fini+0x1e0/0x480
                    [amdgpu]</div>
                  <div>[    7.478058] 
                    amdgpu_driver_unload_kms+0xa0/0x150 [amdgpu]</div>
                  <div>[    7.483686] 
                    amdgpu_driver_load_kms+0x144/0x1f8 [amdgpu]</div>
                  <div>[    7.489110]  drm_dev_register+0x14c/0x1e0
                    [drm]</div>
                  <div>[    7.493906]  amdgpu_pci_probe+0xcc/0x188
                    [amdgpu]</div>
                  <div>[    7.498622]  local_pci_probe+0x3c/0xb0</div>
                  <div>[    7.502375]  pci_device_probe+0x150/0x1b8</div>
                  <div>[    7.506390]  really_probe+0x1f0/0x298</div>
                  <div>[    7.510055]  driver_probe_device+0x58/0x100</div>
                  <div>[    7.514242]  __driver_attach+0xd4/0xd8</div>
                  <div>[    7.517993]  bus_for_each_dev+0x74/0xc8</div>
                  <div>[    7.521832]  driver_attach+0x20/0x28</div>
                  <div>[    7.525410]  bus_add_driver+0x1ac/0x218</div>
                  <div>[    7.529250]  driver_register+0x60/0x110</div>
                  <div>[    7.533089]  __pci_register_driver+0x40/0x48</div>
                  <div>[    7.537599]  amdgpu_init+0x58/0x1000 [amdgpu]</div>
                  <div>[    7.541964]  do_one_initcall+0x5c/0x178</div>
                  <div>[    7.545804]  do_init_module+0x58/0x1b0</div>
                  <div>[    7.549556]  load_module+0x1dc8/0x2178</div>
                  <div>[    7.553308]  __se_sys_finit_module+0xbc/0xd0</div>
                  <div>[    7.557582] 
                    __arm64_sys_finit_module+0x18/0x20</div>
                  <div>[    7.562119]  el0_svc_common+0x60/0x100</div>
                  <div>[    7.565872]  el0_svc_handler+0x2c/0x80</div>
                </div>
                <div>
                  <div>[    7.581715] amdgpu 0000:01:00.0:
                    (____ptrval____) unpin not necessary</div>
                  <div>[    7.594743] [TTM] Finalizing pool allocator</div>
                  <div>[    7.599867] [TTM] Finalizing DMA pool
                    allocator</div>
                  <div>[    7.605265] [TTM] Zone  kernel: Used memory at
                    exit: 0 kiB</div>
                  <div>[    7.611482] [drm] amdgpu: ttm finalized</div>
                  <div>[    7.618028] amdgpu: probe of 0000:01:00.0
                    failed with error -110</div>
                </div>
                <div><br>
                </div>
                <div>Bas Vermeulen</div>
                <div><br>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
      <br>
      <div class="gmail_quote">
        <div dir="ltr">On Thu, Dec 20, 2018 at 5:11 PM Bas Vermeulen
          &lt;<a href="mailto:bas-MbI5SpmOCPBHdOctNixuYw@public.gmane.org" moz-do-not-send="true">bas-MbI5SpmOCPBHdOctNixuYw@public.gmane.org</a>&gt;
          wrote:<br>
        </div>
        <blockquote class="gmail_quote" style="margin:0px 0px 0px
          0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
          <div dir="ltr">Hi Alex,
            <div><br>
            </div>
            <div>I already have a similar patch in, that doesn't fix it
              just yet. I'll investigate some more.</div>
            <div><br>
            </div>
            <div>Bas Vermeulen</div>
          </div>
          <br>
          <div class="gmail_quote">
            <div dir="ltr">On Thu, Dec 20, 2018 at 4:27 PM Alex Deucher
              &lt;<a href="mailto:alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" target="_blank"
                moz-do-not-send="true">alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt;
              wrote:<br>
            </div>
            <blockquote class="gmail_quote" style="margin:0px 0px 0px
              0.8ex;border-left:1px solid
              rgb(204,204,204);padding-left:1ex">On Thu, Dec 20, 2018 at
              9:06 AM Bas Vermeulen &lt;<a
                href="mailto:bas-MbI5SpmOCPBHdOctNixuYw@public.gmane.org" target="_blank"
                moz-do-not-send="true">bas-MbI5SpmOCPBHdOctNixuYw@public.gmane.org</a>&gt; wrote:<br>
              &gt;<br>
              &gt; Hi all,<br>
              &gt;<br>
              &gt; I have connected an E9260 (Polaris 11 based) to a
              mini-PCIe slot on my NXP LS1012ARDB.<br>
              &gt; The GPU is seen, all the BARs are correctly assigned
              (but there's not enough PCIe memory space for the big
              BARs).<br>
              &gt;<br>
              &gt; When I try to load the amdgpu module, I can't get the
              driver to enable the acceleration (the scratch register
              check fails).<br>
              &gt;<br>
              &gt; The E9260 is connected to a PCIe x1 (Gen2) slot.<br>
              &gt;<br>
              &gt; Anyone have an idea on where to look or how to fix
              this? This is a test-bed before we get an LS1046ARDB with
              quad core A72's.<br>
              &gt;<br>
              &gt; Any help would be appreciated,<br>
              <br>
              Something like this patch should fix it assuming this is
              an ARM based platform:<br>
              <a href="https://patchwork.freedesktop.org/patch/269367/"
                rel="noreferrer" target="_blank" moz-do-not-send="true">https://patchwork.freedesktop.org/patch/269367/</a><br>
              <br>
              Alex<br>
              <br>
              &gt;<br>
              &gt; Bas Vermeulen<br>
              &gt; _______________________________________________<br>
              &gt; amd-gfx mailing list<br>
              &gt; <a href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org"
                target="_blank" moz-do-not-send="true">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
              &gt; <a
                href="https://lists.freedesktop.org/mailman/listinfo/amd-gfx"
                rel="noreferrer" target="_blank" moz-do-not-send="true">https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a><br>
            </blockquote>
          </div>
        </blockquote>
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

--------------201F6A530A7A2BA1E12F01E5--

--===============1195382125==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1195382125==--
