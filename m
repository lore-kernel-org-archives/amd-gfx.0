From: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: Need to set the baco cap before baco reset
Date: Mon, 17 Jun 2019 10:39:13 -0400
Message-ID: <CADnq5_OVnHfJongr4CrDH4T8Yb0Jihy+CSyDh+Ena_ekk7yaXA@mail.gmail.com>
References: <1558943005-16557-1-git-send-email-Emily.Deng@amd.com>
 <MN2PR12MB3344E228ADA29C20F5BA9DDBE41E0@MN2PR12MB3344.namprd12.prod.outlook.com>
 <BN6PR12MB1618E4322B84944963895A8E85EF0@BN6PR12MB1618.namprd12.prod.outlook.com>
 <MN2PR12MB29750834B9F6C548E831DE798FEE0@MN2PR12MB2975.namprd12.prod.outlook.com>
 <9bfdbf20-b914-6063-5517-8352e652e203@amd.com>
 <MN2PR12MB2975EAAD825DA9842876B4A38FEB0@MN2PR12MB2975.namprd12.prod.outlook.com>
 <MN2PR12MB29750900DC4B43AD00254D888FEB0@MN2PR12MB2975.namprd12.prod.outlook.com>
 <BN6PR12MB16188EBC282A9D8BEA715AB185EB0@BN6PR12MB1618.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="0000000000007d0cd7058b85f6a4"
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <BN6PR12MB16188EBC282A9D8BEA715AB185EB0-/b2+HYfkarRqaFUXYJa4HgdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
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
To: "Russell, Kent" <Kent.Russell-5C7GfCeVMHo@public.gmane.org>
Cc: "Deng, Emily" <Emily.Deng-5C7GfCeVMHo@public.gmane.org>, "Quan, Evan" <Evan.Quan-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "Yang,
 Philip" <Philip.Yang-5C7GfCeVMHo@public.gmane.org>

--0000000000007d0cd7058b85f6a4
Content-Type: text/plain; charset="UTF-8"

On Mon, Jun 17, 2019 at 7:08 AM Russell, Kent <Kent.Russell-5C7GfCeVMHo@public.gmane.org> wrote:
>
> The issue was limited to one specific model of MI25, I'll see if I can get access to that later today and try your patch out. Thank you Emily!

Where is the crash happening in amdgpu_bios.c?  What pointer is NULL?
Presumably it's one of the asic_funcs?  Can we move the call to after
the common early init?  I think that is cleaner.  Something like the
attached patch?

Alex

>
>  Kent
>
> -----Original Message-----
> From: Deng, Emily <Emily.Deng-5C7GfCeVMHo@public.gmane.org>
> Sent: Sunday, June 16, 2019 11:53 PM
> To: Yang, Philip <Philip.Yang-5C7GfCeVMHo@public.gmane.org>; Russell, Kent <Kent.Russell-5C7GfCeVMHo@public.gmane.org>; Quan, Evan <Evan.Quan-5C7GfCeVMHo@public.gmane.org>; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> Subject: RE: [PATCH] drm/amdgpu: Need to set the baco cap before baco reset
>
> Hi Philip,
>      Could you help to try whether the attachment patch could help with the issue encounter? If it is OK, then I will send this patch out to review.
>
> Best wishes
> Emily Deng
>
>
>
> >-----Original Message-----
> >From: Deng, Emily
> >Sent: Monday, June 17, 2019 10:50 AM
> >To: Yang, Philip <Philip.Yang-5C7GfCeVMHo@public.gmane.org>; Russell, Kent
> ><Kent.Russell-5C7GfCeVMHo@public.gmane.org>; Quan, Evan <Evan.Quan-5C7GfCeVMHo@public.gmane.org>; amd-
> >gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> >Subject: RE: [PATCH] drm/amdgpu: Need to set the baco cap before baco
> >reset
> >
> >Hi Philip,
> >     Sorry for introduce this issue for you. From the code, I couldn't
> >see any issue. And I have tested the code in my Vega10, it is OK.  So I
> >think this is the kfd specific issue, but I couldn't reproduce issue on
> >my platform. Could you create an ticket, and assign to me, and share me
> >your platform, so I could debug it and fix it today.
> >
> >Best wishes
> >Emily Deng
> >
> >>-----Original Message-----
> >>From: Yang, Philip <Philip.Yang-5C7GfCeVMHo@public.gmane.org>
> >>Sent: Friday, June 14, 2019 10:16 PM
> >>To: Deng, Emily <Emily.Deng-5C7GfCeVMHo@public.gmane.org>; Russell, Kent
> >><Kent.Russell-5C7GfCeVMHo@public.gmane.org>; Quan, Evan <Evan.Quan-5C7GfCeVMHo@public.gmane.org>; amd-
> >>gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> >>Subject: Re: [PATCH] drm/amdgpu: Need to set the baco cap before baco
> >>reset
> >>
> >>Hi Emily,
> >>
> >>I am not familiar with vbios and driver init part, just based on my
> >>experience, the patch don't modify amdgpu_get_bios but move
> >>amdgpu_get_bios to amdgpu_device_ip_early_init from
> >>amdgpu_device_init, so amdgpu_get_bios is executed earlier. The kernel error message "BUG:
> >>kernel NULL pointer dereference" means something is not initialized.
> >>Please review the change. This issue blocks rocm release now.
> >>
> >>Regards,
> >>Philip
> >>
> >>On 2019-06-13 11:19 p.m., Deng, Emily wrote:
> >>> Hi Russell,
> >>>       This patch will read vbios, and parse vbios to get the baco
> >>> reset feature
> >>bit.  From the call trace, it shows error in " amdgpu_get_bios ", but
> >>this patch don't modify amdgpu_get_bios, and code before
> >>amdgpu_get_bios. Please first check why it will has error when read vbios.
> >>>
> >>> Best wishes
> >>> Emily Deng
> >>>
> >>>
> >>>
> >>>> -----Original Message-----
> >>>> From: Russell, Kent <Kent.Russell-5C7GfCeVMHo@public.gmane.org>
> >>>> Sent: Thursday, June 13, 2019 7:11 PM
> >>>> To: Quan, Evan <Evan.Quan-5C7GfCeVMHo@public.gmane.org>; Deng, Emily
> >><Emily.Deng-5C7GfCeVMHo@public.gmane.org>;
> >>>> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> >>>> Cc: Deng, Emily <Emily.Deng-5C7GfCeVMHo@public.gmane.org>
> >>>> Subject: RE: [PATCH] drm/amdgpu: Need to set the baco cap before
> >>>> baco reset
> >>>>
> >>>> Hi Emily,
> >>>>
> >>>> This patch caused a regression on MI25 (Chip 6860, VBIOS
> >>>> 113-D0513700-001) machines where the driver would not boot. Note
> >>>> that this was not seen on
> >>>> Vega10 Frontier (Chip 6863, VBIOS 113-D0501100-X09) or Radeon64
> >>>> (Chip 697f). Reverting this patch resolved the issue with no other
> >>>> work required and was confirmed on all 3 machines.
> >>>>
> >>>> Here is the dmesg:
> >>>>
> >>>> [    3.908653] amdgpu 0000:23:00.0: BAR 6: can't assign [??? 0x00000000
> >>flags
> >>>> 0x20000000] (bogus alignment)
> >>>> [    3.908692] BUG: kernel NULL pointer dereference, address:
> >>>> 0000000000000008
> >>>> [    3.908716] #PF: supervisor read access in kernel mode
> >>>> [    3.908734] #PF: error_code(0x0000) - not-present page
> >>>> [    3.908753] PGD 0 P4D 0
> >>>> [    3.908767] Oops: 0000 [#1] SMP NOPTI
> >>>> [    3.909293] CPU: 8 PID: 409 Comm: kworker/8:1 Not tainted 5.2.0-rc1-
> >kfd-
> >>>> compute-roc-master-10734 #1
> >>>> [    3.909753] Hardware name: Inventec     P47
> >>WC2071019001
> >>>> /P47             , BIOS 0.64 04/09/2018
> >>>> [    3.910534] Workqueue: events work_for_cpu_fn
> >>>> [    3.910953] RIP: 0010:amdgpu_get_bios+0x3aa/0x580 [amdgpu]
> >>>> [    3.911314] Code: c0 48 c7 44 24 5c 00 00 00 00 48 c7 84 24 90 00 00 00
> >00
> >>00
> >>>> 00 00 48 89 d9 48 29 f9 83 c1 3c c1 e9 03 f3 48 ab 49 8b 44 24 38
> >>>> <48> 8b 40 08
> >>>> 48 85 c0 74 24 ba 3c 00 00 00 48 89 de 4c 89 e7 ff d0
> >>>> [    3.912069] RSP: 0018:ffffa27dce28fc50 EFLAGS: 00010212
> >>>> [    3.912502] RAX: 0000000000000000 RBX: ffffa27dce28fcac RCX:
> >>>> 0000000000000000
> >>>> [    3.912980] RDX: 0000000000000000 RSI: 0000000000000082 RDI:
> >>>> ffffa27dce28fce8
> >>>> [    3.913467] RBP: 0000000000000000 R08: 0000000000000001 R09:
> >>>> 000000000000079a
> >>>> [    3.913940] R10: 0000000000000000 R11: 0000000000000001 R12:
> >>>> ffff88d657af0000
> >>>> [    3.914349] R13: ffffffffc0c38120 R14: ffffa27dce28fc68 R15:
> >>>> ffff88d657af0000
> >>>> [    3.914767] FS:  0000000000000000(0000) GS:ffff88d65f400000(0000)
> >>>> knlGS:0000000000000000
> >>>> [    3.915203] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> >>>> [    3.915637] CR2: 0000000000000008 CR3: 0000003e7540a000 CR4:
> >>>> 00000000003406e0
> >>>> [    3.916075] Call Trace:
> >>>> [    3.916522]  ? pcie_capability_clear_and_set_word+0x53/0x80
> >>>> [    3.917014]  amdgpu_device_init+0x923/0x1820 [amdgpu]
> >>>> [    3.917515]  amdgpu_driver_load_kms+0x71/0x310 [amdgpu]
> >>>> [    3.917997]  drm_dev_register+0x113/0x1a0 [drm]
> >>>> [    3.918514]  amdgpu_pci_probe+0xb8/0x150 [amdgpu]
> >>>> [    3.919003]  ? __pm_runtime_resume+0x54/0x70
> >>>> [    3.919270] usb 1-2: New USB device found, idVendor=14dd,
> >>idProduct=1005,
> >>>> bcdDevice= 0.00
> >>>> [    3.919498]  local_pci_probe+0x3d/0x90
> >>>> [    3.919503]  ? __schedule+0x3de/0x690
> >>>> [    3.920374] usb 1-2: New USB device strings: Mfr=1, Product=2,
> >>>> SerialNumber=3
> >>>> [    3.921137]  work_for_cpu_fn+0x10/0x20
> >>>> [    3.922028] usb 1-2: Product: D2CIM-VUSB
> >>>> [    3.922815]  process_one_work+0x159/0x3e0
> >>>> [    3.923633] usb 1-2: Manufacturer: Raritan
> >>>> [    3.923635] usb 1-2: SerialNumber: EFFB212D0A6E32F
> >>>> [    3.924416]  worker_thread+0x22b/0x440
> >>>> [    3.924419]  ? rescuer_thread+0x350/0x350
> >>>> [    3.927812]  kthread+0xf6/0x130
> >>>> [    3.928157] ata1: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
> >>>> [    3.928365]  ? kthread_destroy_worker+0x40/0x40
> >>>> [    3.929401] ata1.00: ATA-10: INTEL SSDSC2KG960G7, SCV10100, max
> >>>> UDMA/133
> >>>> [    3.930101]  ret_from_fork+0x1f/0x30
> >>>> [    3.930103] Modules linked in: amdgpu(+) crct10dif_pclmul crc32_pclmul
> >>>> ghash_clmulni_intel ast amd_iommu_v2 aesni_intel gpu_sched
> >>>> i2c_algo_bit
> >>>> aes_x86_64 ttm crypto_simd drm_kms_helper cryptd glue_helper
> >>>> syscopyarea sysfillrect ahci sysimgblt libahci fb_sys_fops ixgbe(+)
> >>>> drm dca mdio
> >>>> [    3.930965] ata1.00: 1875385008 sectors, multi 1: LBA48 NCQ (depth 32)
> >>>> [    3.931085] ata1.00: configured for UDMA/133
> >>>> [    3.931809] CR2: 0000000000000008
> >>>> [    3.934723] scsi 0:0:0:0: Direct-Access     ATA      INTEL SSDSC2KG96 0100
> >>PQ:
> >>>> 0 ANSI: 5
> >>>>
> >>>>
> >>>> Thanks!
> >>>>
> >>>> Kent
> >>>>
> >>>> -----Original Message-----
> >>>> From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> On Behalf Of
> >>>> Quan, Evan
> >>>> Sent: Monday, May 27, 2019 9:17 PM
> >>>> To: Deng, Emily <Emily.Deng-5C7GfCeVMHo@public.gmane.org>; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> >>>> Cc: Deng, Emily <Emily.Deng-5C7GfCeVMHo@public.gmane.org>
> >>>> Subject: RE: [PATCH] drm/amdgpu: Need to set the baco cap before
> >>>> baco reset
> >>>>
> >>>> Reviewed-by: Evan Quan <evan.quan-5C7GfCeVMHo@public.gmane.org>
> >>>>
> >>>>> -----Original Message-----
> >>>>> From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> On Behalf Of
> >>>>> Emily Deng
> >>>>> Sent: Monday, May 27, 2019 3:43 PM
> >>>>> To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> >>>>> Cc: Deng, Emily <Emily.Deng-5C7GfCeVMHo@public.gmane.org>
> >>>>> Subject: [PATCH] drm/amdgpu: Need to set the baco cap before baco
> >>>>> reset
> >>>>>
> >>>>> For passthrough, after rebooted the VM, driver will do a baco
> >>>>> reset before doing other driver initialization during loading  driver.
> >>>>> For doing the baco reset, it will first check the baco reset capability.
> >>>>> So first need to set the cap from the vbios information or baco
> >>>>> reset won't
> >>>> be enabled.
> >>>>>
> >>>>> Signed-off-by: Emily Deng <Emily.Deng-5C7GfCeVMHo@public.gmane.org>
> >>>>> ---
> >>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c         | 24
> >++++++++++--
> >>---
> >>>>> -------
> >>>>>   drivers/gpu/drm/amd/amdgpu/soc15.c                 |  3 ++-
> >>>>>   drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c |  4 ++++
> >>>>>   .../amd/powerplay/hwmgr/vega10_processpptables.c   | 24
> >>>>> ++++++++++++++++++++++
> >>>>>   .../amd/powerplay/hwmgr/vega10_processpptables.h   |  1 +
> >>>>>   5 files changed, 42 insertions(+), 14 deletions(-)
> >>>>>
> >>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> >>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> >>>>> index b6ded84..7a8c220 100644
> >>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> >>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> >>>>> @@ -1541,6 +1541,17 @@ static int
> >>>>> amdgpu_device_ip_early_init(struct
> >>>>> amdgpu_device *adev)
> >>>>>           if (amdgpu_sriov_vf(adev))
> >>>>>                   adev->pm.pp_feature &= ~PP_GFXOFF_MASK;
> >>>>>
> >>>>> + /* Read BIOS */
> >>>>> + if (!amdgpu_get_bios(adev))
> >>>>> +         return -EINVAL;
> >>>>> +
> >>>>> + r = amdgpu_atombios_init(adev);
> >>>>> + if (r) {
> >>>>> +         dev_err(adev->dev, "amdgpu_atombios_init failed\n");
> >>>>> +         amdgpu_vf_error_put(adev,
> >>>>> AMDGIM_ERROR_VF_ATOMBIOS_INIT_FAIL, 0, 0);
> >>>>> +         return r;
> >>>>> + }
> >>>>> +
> >>>>>           for (i = 0; i < adev->num_ip_blocks; i++) {
> >>>>>                   if ((amdgpu_ip_block_mask & (1 << i)) == 0) {
> >>>>>                           DRM_ERROR("disabled ip block: %d <%s>\n", @@ -
> >>>>> 2591,19 +2602,6 @@ int amdgpu_device_init(struct amdgpu_device
> >>*adev,
> >>>>>                   goto fence_driver_init;
> >>>>>           }
> >>>>>
> >>>>> - /* Read BIOS */
> >>>>> - if (!amdgpu_get_bios(adev)) {
> >>>>> -         r = -EINVAL;
> >>>>> -         goto failed;
> >>>>> - }
> >>>>> -
> >>>>> - r = amdgpu_atombios_init(adev);
> >>>>> - if (r) {
> >>>>> -         dev_err(adev->dev, "amdgpu_atombios_init failed\n");
> >>>>> -         amdgpu_vf_error_put(adev,
> >>>>> AMDGIM_ERROR_VF_ATOMBIOS_INIT_FAIL, 0, 0);
> >>>>> -         goto failed;
> >>>>> - }
> >>>>> -
> >>>>>           /* detect if we are with an SRIOV vbios */
> >>>>>           amdgpu_device_detect_sriov_bios(adev);
> >>>>>
> >>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c
> >>>>> b/drivers/gpu/drm/amd/amdgpu/soc15.c
> >>>>> index 78bd4fc..d9fdd95 100644
> >>>>> --- a/drivers/gpu/drm/amd/amdgpu/soc15.c
> >>>>> +++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
> >>>>> @@ -764,7 +764,8 @@ static bool soc15_need_reset_on_init(struct
> >>>>> amdgpu_device *adev)
> >>>>>           /* Just return false for soc15 GPUs.  Reset does not seem to
> >>>>>            * be necessary.
> >>>>>            */
> >>>>> - return false;
> >>>>> + if (!amdgpu_passthrough(adev))
> >>>>> +         return false;
> >>>>>
> >>>>>           if (adev->flags & AMD_IS_APU)
> >>>>>                   return false;
> >>>>> diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c
> >>>>> b/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c
> >>>>> index ce6aeb5..1d9bb29 100644
> >>>>> --- a/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c
> >>>>> +++ b/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c
> >>>>> @@ -5311,8 +5311,12 @@ static const struct pp_hwmgr_func
> >>>>> vega10_hwmgr_funcs = {
> >>>>>
> >>>>>   int vega10_hwmgr_init(struct pp_hwmgr *hwmgr)  {
> >>>>> + struct amdgpu_device *adev = hwmgr->adev;
> >>>>> +
> >>>>>           hwmgr->hwmgr_func = &vega10_hwmgr_funcs;
> >>>>>           hwmgr->pptable_func = &vega10_pptable_funcs;
> >>>>> + if (amdgpu_passthrough(adev))
> >>>>> +         return vega10_baco_set_cap(hwmgr);
> >>>>>
> >>>>>           return 0;
> >>>>>   }
> >>>>> diff --git
> >>>>> a/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_processpptables.c
> >>>>> b/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_processpptables.c
> >>>>> index b6767d7..83d22cd 100644
> >>>>> ---
> >a/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_processpptables.c
> >>>>> +++
> >>b/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_processpptables.c
> >>>>> @@ -1371,3 +1371,27 @@ int vega10_get_powerplay_table_entry(struct
> >>>>> pp_hwmgr *hwmgr,
> >>>>>
> >>>>>           return result;
> >>>>>   }
> >>>>> +
> >>>>> +int vega10_baco_set_cap(struct pp_hwmgr *hwmgr) {
> >>>>> + int result = 0;
> >>>>> +
> >>>>> + const ATOM_Vega10_POWERPLAYTABLE *powerplay_table;
> >>>>> +
> >>>>> + powerplay_table = get_powerplay_table(hwmgr);
> >>>>> +
> >>>>> + PP_ASSERT_WITH_CODE((powerplay_table != NULL),
> >>>>> +         "Missing PowerPlay Table!", return -1);
> >>>>> +
> >>>>> + result = check_powerplay_tables(hwmgr, powerplay_table);
> >>>>> +
> >>>>> + PP_ASSERT_WITH_CODE((result == 0),
> >>>>> +                     "check_powerplay_tables failed", return result);
> >>>>> +
> >>>>> + set_hw_cap(
> >>>>> +                 hwmgr,
> >>>>> +                 0 != (le32_to_cpu(powerplay_table->ulPlatformCaps)
> >>>>> & ATOM_VEGA10_PP_PLATFORM_CAP_BACO),
> >>>>> +                 PHM_PlatformCaps_BACO);
> >>>>> + return result;
> >>>>> +}
> >>>>> +
> >>>>> diff --git
> >>>>> a/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_processpptables.h
> >>>>> b/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_processpptables.h
> >>>>> index d83ed2a..da5fbec 100644
> >>>>> ---
> >>a/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_processpptables.h
> >>>>> +++
> >>b/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_processpptables.h
> >>>>> @@ -59,4 +59,5 @@ extern int
> >>>>> vega10_get_number_of_powerplay_table_entries(struct pp_hwmgr
> >>>> *hwmgr);
> >>>>> extern int vega10_get_powerplay_table_entry(struct pp_hwmgr
> >>>>> *hwmgr, uint32_t entry_index,
> >>>>>                   struct pp_power_state *power_state, int
> >>>> (*call_back_func)(struct
> >>>>> pp_hwmgr *, void *,
> >>>>>                                   struct pp_power_state *, void *, uint32_t));
> >>>>> +extern int vega10_baco_set_cap(struct pp_hwmgr *hwmgr);
> >>>>>   #endif
> >>>>> --
> >>>>> 2.7.4
> >>>>>
> >>>>> _______________________________________________
> >>>>> amd-gfx mailing list
> >>>>> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> >>>>> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
> >>>> _______________________________________________
> >>>> amd-gfx mailing list
> >>>> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> >>>> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
> >>> _______________________________________________
> >>> amd-gfx mailing list
> >>> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> >>> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
> >>>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--0000000000007d0cd7058b85f6a4
Content-Type: text/x-patch; charset="US-ASCII";
	name="0001-drm-amdgpu-wait-to-fetch-the-vbios-until-after-commo.patch"
Content-Disposition: attachment;
	filename="0001-drm-amdgpu-wait-to-fetch-the-vbios-until-after-commo.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_jx0hif1a0>
X-Attachment-Id: f_jx0hif1a0

RnJvbSAxZjQ4ZTcwNWMzMGU3ZGMxOTk0YmNiZGJlMDVjMmU1ZDM5NmRjNmIwIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5j
b20+CkRhdGU6IE1vbiwgMTcgSnVuIDIwMTkgMDk6Mzc6NDUgLTA1MDAKU3ViamVjdDogW1BBVENI
XSBkcm0vYW1kZ3B1OiB3YWl0IHRvIGZldGNoIHRoZSB2YmlvcyB1bnRpbCBhZnRlciBjb21tb24g
aW5pdAoKV2UgbmVlZCB0aGUgYXNpY19mdW5jcyBzZXQgZm9yIHRoZSBnZXQgcm9tIGNhbGxiYWNr
cyBpbiBzb21lCmNhc2VzLgoKU2lnbmVkLW9mZi1ieTogQWxleCBEZXVjaGVyIDxhbGV4YW5kZXIu
ZGV1Y2hlckBhbWQuY29tPgotLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9k
ZXZpY2UuYyB8IDI0ICsrKysrKysrKysrKy0tLS0tLS0tLS0KIDEgZmlsZSBjaGFuZ2VkLCAxMyBp
bnNlcnRpb25zKCspLCAxMSBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9hbWRncHVfZGV2aWNlLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9hbWRncHVfZGV2aWNlLmMKaW5kZXggNGE4MzZkYjEwMDBmLi5lMjYzMDNiYzU2N2UgMTAwNjQ0
Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZXZpY2UuYworKysgYi9k
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGV2aWNlLmMKQEAgLTE1MzQsMTcgKzE1
MzQsNiBAQCBzdGF0aWMgaW50IGFtZGdwdV9kZXZpY2VfaXBfZWFybHlfaW5pdChzdHJ1Y3QgYW1k
Z3B1X2RldmljZSAqYWRldikKIAlpZiAoYW1kZ3B1X3NyaW92X3ZmKGFkZXYpKQogCQlhZGV2LT5w
bS5wcF9mZWF0dXJlICY9IH5QUF9HRlhPRkZfTUFTSzsKIAotCS8qIFJlYWQgQklPUyAqLwotCWlm
ICghYW1kZ3B1X2dldF9iaW9zKGFkZXYpKQotCQlyZXR1cm4gLUVJTlZBTDsKLQotCXIgPSBhbWRn
cHVfYXRvbWJpb3NfaW5pdChhZGV2KTsKLQlpZiAocikgewotCQlkZXZfZXJyKGFkZXYtPmRldiwg
ImFtZGdwdV9hdG9tYmlvc19pbml0IGZhaWxlZFxuIik7Ci0JCWFtZGdwdV92Zl9lcnJvcl9wdXQo
YWRldiwgQU1ER0lNX0VSUk9SX1ZGX0FUT01CSU9TX0lOSVRfRkFJTCwgMCwgMCk7Ci0JCXJldHVy
biByOwotCX0KLQogCWZvciAoaSA9IDA7IGkgPCBhZGV2LT5udW1faXBfYmxvY2tzOyBpKyspIHsK
IAkJaWYgKChhbWRncHVfaXBfYmxvY2tfbWFzayAmICgxIDw8IGkpKSA9PSAwKSB7CiAJCQlEUk1f
RVJST1IoImRpc2FibGVkIGlwIGJsb2NrOiAlZCA8JXM+XG4iLApAQCAtMTU2Niw2ICsxNTU1LDE5
IEBAIHN0YXRpYyBpbnQgYW1kZ3B1X2RldmljZV9pcF9lYXJseV9pbml0KHN0cnVjdCBhbWRncHVf
ZGV2aWNlICphZGV2KQogCQkJCWFkZXYtPmlwX2Jsb2Nrc1tpXS5zdGF0dXMudmFsaWQgPSB0cnVl
OwogCQkJfQogCQl9CisJCS8qIGdldCB0aGUgdmJpb3MgYWZ0ZXIgdGhlIGFzaWNfZnVuY3MgYXJl
IHNldCB1cCAqLworCQlpZiAoYWRldi0+aXBfYmxvY2tzW2ldLnZlcnNpb24tPnR5cGUgPT0gQU1E
X0lQX0JMT0NLX1RZUEVfQ09NTU9OKSB7CisJCQkvKiBSZWFkIEJJT1MgKi8KKwkJCWlmICghYW1k
Z3B1X2dldF9iaW9zKGFkZXYpKQorCQkJCXJldHVybiAtRUlOVkFMOworCisJCQlyID0gYW1kZ3B1
X2F0b21iaW9zX2luaXQoYWRldik7CisJCQlpZiAocikgeworCQkJCWRldl9lcnIoYWRldi0+ZGV2
LCAiYW1kZ3B1X2F0b21iaW9zX2luaXQgZmFpbGVkXG4iKTsKKwkJCQlhbWRncHVfdmZfZXJyb3Jf
cHV0KGFkZXYsIEFNREdJTV9FUlJPUl9WRl9BVE9NQklPU19JTklUX0ZBSUwsIDAsIDApOworCQkJ
CXJldHVybiByOworCQkJfQorCQl9CiAJfQogCiAJYWRldi0+Y2dfZmxhZ3MgJj0gYW1kZ3B1X2Nn
X21hc2s7Ci0tIAoyLjIwLjEKCg==
--0000000000007d0cd7058b85f6a4
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--0000000000007d0cd7058b85f6a4--
