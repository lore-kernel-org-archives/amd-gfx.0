Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23E41C433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Dec 2021 09:13:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 98FE910F289;
	Tue, 21 Dec 2021 09:13:38 +0000 (UTC)
Received: from office.oderland.com (office.oderland.com [91.201.60.5])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D6F4E10EF17
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Dec 2021 08:41:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=oderland.se
 ; s=default;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:Subject:
 From:References:Cc:To:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=fOoKLFcuaqpj6wN3/vpFiWdY1E2tB/9cgyQaBju10x0=; b=eA/xee7KOS2JUp+XLbcwMb1SYb
 mp0k3HrH7fpJtSV3LYJe5o+DZPnumEH5TH8VaAwG8387A2H3WPuogNoM5es4sRE6D3YC/YpSLu1M4
 8U0C6M1brEvXAVFiKOZXqhDxi5Xe/7aNq+/VyNjuKigeGzNXbMM7R5UEfx5+jJo4VStI0DGEgK/Gf
 dtK9Qy+OKknzGPzCEpPt0X13wexGIiGyeTilRiOFzPHPi5Xioiq+Ms6fT8wOLv6Zy9ULztHuMnVj4
 6uoVd0J+3tA6uoJnbv6SFo8WHLHjukav2pJksSYP/wHV4aJ87cHNEjt4Z2XUrOQa8BptmF5d/8qmv
 UPWtXDgw==;
Received: from 160.193-180-18.r.oderland.com ([193.180.18.160]:36856
 helo=[10.137.0.14]) by office.oderland.com with esmtpsa (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256 (Exim 4.94.2)
 (envelope-from <josef@oderland.se>)
 id 1mzai9-00FmM9-Or; Tue, 21 Dec 2021 09:41:29 +0100
Message-ID: <cec25e90-f6fb-3d57-4241-5644062cad52@oderland.se>
Date: Tue, 21 Dec 2021 09:41:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:95.0) Gecko/20100101
 Thunderbird/95.0
Content-Language: en-US
To: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>, "Yu, Lang" <Lang.Yu@amd.com>
References: <20211208092642.173385-1-lang.yu@amd.com>
 <CO6PR12MB547373A8EA694763B14A431A826F9@CO6PR12MB5473.namprd12.prod.outlook.com>
 <YbCP2DWgO207Uqjr@lang-desktop>
 <CO6PR12MB54732E5665A1323B2BB8010F826F9@CO6PR12MB5473.namprd12.prod.outlook.com>
From: Josef Johansson <josef@oderland.se>
Subject: Re: [PATCH 1/2] drm/amdgpu: remove power on/off SDMA in SMU
 hw_init/fini()
In-Reply-To: <CO6PR12MB54732E5665A1323B2BB8010F826F9@CO6PR12MB5473.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse,
 please include it with any abuse report
X-AntiAbuse: Primary Hostname - office.oderland.com
X-AntiAbuse: Original Domain - lists.freedesktop.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - oderland.se
X-Get-Message-Sender-Via: office.oderland.com: authenticated_id:
 josjoh@oderland.se
X-Authenticated-Sender: office.oderland.com: josjoh@oderland.se
X-Mailman-Approved-At: Tue, 21 Dec 2021 09:13:38 +0000
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Lazar,
 Lijo" <Lijo.Lazar@amd.com>, "Huang, Ray" <Ray.Huang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 12/8/21 12:11, Wang, Yang(Kevin) wrote:
>
> [AMD Official Use Only]
>
>
> OK, I miss this call path.
>
> Reviewed-by: Kevin Wang <kevinyang.wang@amd.com>
>
> Best Regards,
> Kevin
>
> ------------------------------------------------------------------------
> *From:* Yu, Lang <Lang.Yu@amd.com>
> *Sent:* Wednesday, December 8, 2021 6:58 PM
> *To:* Wang, Yang(Kevin) <KevinYang.Wang@amd.com>
> *Cc:* amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>;
> Deucher, Alexander <Alexander.Deucher@amd.com>; Lazar, Lijo
> <Lijo.Lazar@amd.com>; Huang, Ray <Ray.Huang@amd.com>
> *Subject:* Re: [PATCH 1/2] drm/amdgpu: remove power on/off SDMA in SMU
> hw_init/fini()
>  
> On 12/08/ , Wang, Yang(Kevin) wrote:
> >    [AMD Official Use Only]
> >
> >    Hi Lang,
> >    the function of smu_powergate_sdma() is only valid on renoir chip.
> >    if you want to remove it, please also remove following callback
> pointer
> >    in struct pptable_funcs{}.
> >    related macro definitions also need to be cleaned up.
> >    int (*powergate_sdma)(struct smu_context *smu, bool gate);
>
>      It will be still called by amdgpu_dpm_set_powergating_by_smu()
>      in sdma_v4_0_hw_init/fini().
>        
>      Regards,
>      Lang
>
> >    Best Regards,
> >    Kevin
> >      __________________________________________________________________
> >
> >    From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf
> of Lang
> >    Yu <lang.yu@amd.com>
> >    Sent: Wednesday, December 8, 2021 5:26 PM
> >    To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
> >    Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Yu, Lang
> >    <Lang.Yu@amd.com>; Lazar, Lijo <Lijo.Lazar@amd.com>; Huang, Ray
> >    <Ray.Huang@amd.com>
> >    Subject: [PATCH 1/2] drm/amdgpu: remove power on/off SDMA in SMU
> >    hw_init/fini()
> >
> >    Currently, we don't find some neccesities to power on/off
> >    SDMA in SMU hw_init/fini(). It makes more sense in SDMA
> >    hw_init/fini().
> >    Signed-off-by: Lang Yu <lang.yu@amd.com>
> >    ---
> >     drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 5 -----
> >     1 file changed, 5 deletions(-)
> >    diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> >    b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> >    index 5839918cb574..2d718c30c8eb 100644
> >    --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> >    +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> >    @@ -1350,7 +1350,6 @@ static int smu_hw_init(void *handle)
> >             }
> >
> >             if (smu->is_apu) {
> >    -               smu_powergate_sdma(&adev->smu, false);
> >                     smu_dpm_set_vcn_enable(smu, true);
> >                     smu_dpm_set_jpeg_enable(smu, true);
> >                     smu_set_gfx_cgpg(&adev->smu, true);
> >    @@ -1512,10 +1511,6 @@ static int smu_hw_fini(void *handle)
> >             if (amdgpu_sriov_vf(adev)&&
> !amdgpu_sriov_is_pp_one_vf(adev))
> >                     return 0;
> >
> >    -       if (smu->is_apu) {
> >    -               smu_powergate_sdma(&adev->smu, true);
> >    -       }
> >    -
> >             smu_dpm_set_vcn_enable(smu, false);
> >             smu_dpm_set_jpeg_enable(smu, false);
> >
> >    --
> >    2.25.1
Hi,

Could this patch be related to the stacktrace I get when setting
amdgpu.dpm=0 on Renoir?
I tried to clear it up as much as possible (translated via OTR).

amdgpu 0000:07:00.0: amdgpu: amdgpu_device_ip_init failed
amdgpu 0000:07:00.0: amdgpu: Fatal error during GPU init
hid-multitouch 2003:04F3:ZACC.0001: Input,hiddeu 96, hidrawo: USB HID v1.10 Device CELAN Touchscreen on 00.3-4/inputor
amdgpu 0000:07:00.0: amdgpu: amdgpu: finishing device.
[drm] free PSP TMR buffer
amdgpu: probe of 0000:07:00.0 failed with error -95
BUG: unable to handle page fault for address: ffffc90080ccc000
#PF: supervisor write access in kernel modes
#PF: error_code(0x0002) - not-present page
PGD cd7cc067 P4D cd7cc067 PUD 10d93b067 PMD 10db30067 PTE O
Oops: 0002 (#1) SMP NOPTI
CPU: 4 PID: 427 Conn: systend-udevd Tainted: G V
5.16.0-0.rcs.8.fc32.qubes.x86_64 eur
Hardware name: LENOVO 20Y1S02400/2041502400, BIOS RIBET66U(1.35 ) 07/30/2021
RIP: e030:vcn_v2_0_sw_fini+0x72/0x90 [amdgpu]
Code: 89 ef eB 41 17 FE FE 85 c0 75 08 48 69 ef e8 65 10 FE ER 48 Bb 54 24 08 65 48 2b 14 25 28 00 00 00 75 18 48 83 4 10 51 5d c3 c?> 03 00 00 00 00 66 70 24 04 e8 af 07 do ff eb be es
RSP: e02b:feffc9004070bc18 EFLAGS: 00010202
RAX: 0000000000000001 RBX: ffffc900B0ccc000 RCX: 0000000000000000
RDX: 0000607ebf40a 100 RSI: feffc9004070bcic RDI: PEEEEEEfco2760401
RBP: ffff88810fe20000 ROB: 0000000000000000 RO9: 0000000080200018
R10: 0000000040000000 R11: 0000000000000004 R12: FF188810fe35a2er
R13: fer88810fe36980 R14: 000000000000000b R15: ffff88810111137cf
FS: 00007033B0a08b80C0000) GS: PEF 88814070000000000) knlGS:000000000000
CS: e030 DS: 0000 ES: 0000 CRO: 0000000080050033
CR2: ffffc90088ccc000 CR3: 0000000100b9c000 CR4: 0000000000050660
Call Trace:
<TASK>
amdgpu_device_ip_fini.isra.O+Oxb6/0x1bo [amdgpu]
amdgpu_device_fini_sw+Ox16/Oxe0 [amdgpu]
amdgpu_driver release_kms.0x12/0x30 [amdgpu]
devm_drm_dev_init_release+Ox3d/0x60 tarnir
devres_release_all.0xb8/0x100
really probe.x100/BX3108
_driver_probe_device.exfe/0x180P
driver probe_device-Oxle/8x90
_driver_attach•OxcB/Oxice
? _device_attach_driver Oxee/exeos
? _device_attach_driver.exe/Oxeos
bus_for_each_dev@x89/exdes
Bus_add_driver Ox149/Oxices
driver register.Ox8f/xee
? Oxffffffffcobddooos
do_one_initcall.0257/8x200
do_init_module=0x5c/8x260
_do_sys_finit_module.Oxae Exi1er
do_syscall_64.0x3b/Bx90
entry_SYSCALL_64_after_huframe.8x44 Axael
RIP: 0033:0x70308ee351345
Code: 00 c3 66 Ze of 1f 84 00 00 00 00 90 83 or le fa 48 89 68 48 89 67 48 89 46 48 89 ca 40 89 c2 40 69 cb 4c 8b 4c 24 08 of 05 <48> 30  01 to ff ff 73 01 c3 48 8b od 2b 6d Oc '00 f? d8 64 89 01 4
RSP: 002b:00007fff2a5c6198 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
RAX: ffffffffffffffda RBX: 00005a0b9881a640 RCX: 0000703d8ee35131
RDX: 0000000000000000 RSI: 00005a0b98819100 RDI: 00000000000000148
RBP: 0000000000020000 ROB: 0000000000000000 RO9; 00005ab9875700N
R10: 0000000000000014 R11: 0000000000000246 R12: 0000000000000000
R13: 00005a0b98819000 R14: 00005ab9881b9a0 R15: 0000000000000006
<TASKS
Modules linked in: hid_multitouch andgpul) commu_y2 gpu_sched 
12c_algo_bit dem_ttn_helper ttn sdhcl_pcl crct1001f_pclmul crc32_pc Imul
 drm_kms_helper crc32c_intel cqhci xhci_pci cec sdhci inme 
xhci_ci_remesa
serio_raw ghash_clmulni_intel xhci_hcd muc_core ehci 
Jhcd nume_core xen_acpl_processor xen_pr lucnd xen_pelback xen_blkback 
xen_gntalloc xen_gntdeu xen_eutchn uinputs
CR2: ffffc900B0cce000
--- end trace 6bbd70000e18e7a9 )---

