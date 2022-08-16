Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4313C2BB41
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Aug 2022 07:20:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3F91BDE8ED;
	Tue, 16 Aug 2022 07:20:07 +0000 (UTC)
X-Greylist: delayed 605 seconds by postgrey-1.36 at gabe;
 Tue, 16 Aug 2022 06:26:45 UTC
Received: from vsp03-out.oderland.com (vsp03-out.oderland.com
 [IPv6:2a02:28f0::28:1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BF3D3C917D
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Aug 2022 06:26:45 +0000 (UTC)
X-Scanned-Cookie: 0b0521547ac943ef62836e0268d609899bcf8ea6
Received: from office.oderland.com (office.oderland.com [91.201.60.5])
 by vsp-out.oderland.com (Halon) with ESMTPSA
 id fc1db4fb-1d2a-11ed-a7df-37adc66064ab;
 Tue, 16 Aug 2022 08:16:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=oderland.se
 ; s=default;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
 References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=PdSawCdJcNgItCKlMdi+wUFyzNOpUQFE2AqLCGbZHCI=; b=tBvVNeoBh6gk7Hhzlv3Ls1RGbb
 bDBtjRzo08xTLmf2D7ofYWIS8C4sDawu7av8j7VDMRbN6EcwseyyfwOo+rAbBKb4XftYUCCILht1d
 01BuzX1hETWpnqljykJcMYw8EOVmsChUIfez+scyTGRGiFw8zz6xg2ElkGldXY9Av0kWP0ZJCsuP/
 vMMwubjGgzkV96vo8/+ZIqjqsCz+pSu04+C5zQovuVJABZuoIft114Mrvc++ixErux2Qsp5t3OVv8
 myLZnxMDhblo/ofuvzNHWc7AfOrGJCAWU7t8+qGudq9DYkF8cg5zpA4NSy+sgHTV68++gjUR2Z7Ln
 OE4TEjEQ==;
Received: from 160.193-180-18.r.oderland.com ([193.180.18.160]:59630
 helo=[10.137.0.14])
 by office.oderland.com with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
 (Exim 4.95) (envelope-from <josef@oderland.se>) id 1oNpsU-004plJ-D0;
 Tue, 16 Aug 2022 08:16:37 +0200
Message-ID: <1fbfb339-62ba-2e30-aac0-2c8894fbf538@oderland.se>
Date: Tue, 16 Aug 2022 08:16:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:104.0) Gecko/20100101
 Thunderbird/104.0
Subject: Re: [PATCH] drm/amdgpu: fix refcount underflow in device reset
Content-Language: en-US
To: Yiqing Yao <yiqing.yao@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220601133523.2370337-1-yiqing.yao@amd.com>
From: Josef Johansson <josef@oderland.se>
In-Reply-To: <20220601133523.2370337-1-yiqing.yao@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
x-oderland-domain-valid: yes
X-Mailman-Approved-At: Tue, 16 Aug 2022 07:19:29 +0000
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
Cc: jingwen.chen2@amd.com, horace.chen@amd.com, monk.liu@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 6/1/22 15:35, Yiqing Yao wrote:
> [why]
> A gfx job may be processed but not finished when reset begin from
> compute job timeout. drm_sched_resubmit_jobs_ext in sched_main
> assume submitted job unsignaled and always put parent fence.
> Resubmission for that job cause underflow. This fix is done in
> device reset to avoid changing drm sched_main.
>
> [how]
> Check if the job to submit has signaled and avoid submission if
> signaled in device reset for both advanced TDR and normal job
> resume.
>
> Signed-off-by: Yiqing Yao <yiqing.yao@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 72 ++++++++++++----------
>   1 file changed, 41 insertions(+), 31 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index f16f105a737b..29b307af97eb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -4980,39 +4980,43 @@ static void amdgpu_device_recheck_guilty_jobs(
>   		/* for the real bad job, it will be resubmitted twice, adding a dma_fence_get
>   		 * to make sure fence is balanced */
>   		dma_fence_get(s_job->s_fence->parent);
> -		drm_sched_resubmit_jobs_ext(&ring->sched, 1);
>   
> -		ret = dma_fence_wait_timeout(s_job->s_fence->parent, false, ring->sched.timeout);
> -		if (ret == 0) { /* timeout */
> -			DRM_ERROR("Found the real bad job! ring:%s, job_id:%llx\n",
> -						ring->sched.name, s_job->id);
> +		/* avoid submission for signaled hw fence */
> +		if(!dma_fence_is_signaled(s_job->s_fence->parent)){
>   
> -			/* set guilty */
> -			drm_sched_increase_karma(s_job);
> +			drm_sched_resubmit_jobs_ext(&ring->sched, 1);
> +
> +			ret = dma_fence_wait_timeout(s_job->s_fence->parent, false, ring->sched.timeout);
> +			if (ret == 0) { /* timeout */
> +				DRM_ERROR("Found the real bad job! ring:%s, job_id:%llx\n",
> +							ring->sched.name, s_job->id);
> +
> +				/* set guilty */
> +				drm_sched_increase_karma(s_job);
>   retry:
> -			/* do hw reset */
> -			if (amdgpu_sriov_vf(adev)) {
> -				amdgpu_virt_fini_data_exchange(adev);
> -				r = amdgpu_device_reset_sriov(adev, false);
> -				if (r)
> -					adev->asic_reset_res = r;
> -			} else {
> -				clear_bit(AMDGPU_SKIP_HW_RESET,
> -					  &reset_context->flags);
> -				r = amdgpu_do_asic_reset(device_list_handle,
> -							 reset_context);
> -				if (r && r == -EAGAIN)
> -					goto retry;
> -			}
> +				/* do hw reset */
> +				if (amdgpu_sriov_vf(adev)) {
> +					amdgpu_virt_fini_data_exchange(adev);
> +					r = amdgpu_device_reset_sriov(adev, false);
> +					if (r)
> +						adev->asic_reset_res = r;
> +				} else {
> +					clear_bit(AMDGPU_SKIP_HW_RESET,
> +						&reset_context->flags);
> +					r = amdgpu_do_asic_reset(device_list_handle,
> +								reset_context);
> +					if (r && r == -EAGAIN)
> +						goto retry;
> +				}
>   
> -			/*
> -			 * add reset counter so that the following
> -			 * resubmitted job could flush vmid
> -			 */
> -			atomic_inc(&adev->gpu_reset_counter);
> -			continue;
> +				/*
> +				* add reset counter so that the following
> +				* resubmitted job could flush vmid
> +				*/
> +				atomic_inc(&adev->gpu_reset_counter);
> +				continue;
> +			}
>   		}
> -
>   		/* got the hw fence, signal finished fence */
>   		atomic_dec(ring->sched.score);
>   		dma_fence_put(s_job->s_fence->parent);
> @@ -5221,13 +5225,19 @@ int amdgpu_device_gpu_recover_imp(struct amdgpu_device *adev,
>   
>   		for (i = 0; i < AMDGPU_MAX_RINGS; ++i) {
>   			struct amdgpu_ring *ring = tmp_adev->rings[i];
> -
> +			struct drm_sched_job *s_job;
>   			if (!ring || !ring->sched.thread)
>   				continue;
>   
> +			s_job = list_first_entry_or_null(&ring->sched.pending_list,
> +				struct drm_sched_job, list);
> +
> +			if(s_job){
>   			/* No point to resubmit jobs if we didn't HW reset*/
> -			if (!tmp_adev->asic_reset_res && !job_signaled)
> -				drm_sched_resubmit_jobs(&ring->sched);
> +				if (!tmp_adev->asic_reset_res && !job_signaled
> +					&& !dma_fence_is_signaled(s_job->s_fence->parent))
> +					drm_sched_resubmit_jobs(&ring->sched);
> +			}
>   
>   			drm_sched_start(&ring->sched, !tmp_adev->asic_reset_res);
>   		}

Hi,

I have this patch in my kernel and during resume/suspend on a AMD Ryzen 4750U
I got the following seemingly very related trace:

Linux version 5.19.0-7.fc32.qubes.x86_64 (user@compiler) (gcc (GCC) 12.1.0, GNU ld version 2.34-6.fc32) #1 SMP PREEMPT_DYNAMIC
  Thu Aug 11 09:37:28 UTC 2022
Command line: placeholder root=/dev/mapper/qubes_dom0-root ro rd.lvm.lv
=qubes_dom0/root rd.lvm.lv=qubes_dom0/swap plymouth.ignore-serial-consoles rd.driver.pre=btrfs rd.driver.blacklist=pcspkr
[...]
amdgpu 0000:07:00.0: amdgpu: ring jpeg_dec uses VM inv eng 6 on hub 1
amdgpu 0000:07:00.0: amdgpu: recover vram bo from shadow start
amdgpu 0000:07:00.0: amdgpu: recover vram bo from shadow done
[drm] Skip scheduling IBs!
amdgpu 0000:07:00.0: amdgpu: GPU reset(2) succeeded!
[drm] Skip scheduling IBs!
------------[ cut here ]------------
refcount_t: underflow; use-after-free.
WARNING: CPU: 2 PID: 538 at lib/refcount.c:28 refcount_warn_saturate+0xba/0x110
Modules linked in: snd_seq_dummy snd_hrtimer nf_tables nfnetlink vfat fat intel_rapl_msr snd_soc_dmic snd_acp3x_rn snd_acp3x_p
dm_dma think_lmi firmware_attributes_class wmi_bmof tps6598x intel_rapl_common snd_ctl_led snd_hda_codec_realtek snd_hda_codec
_generic snd_sof_amd_renoir snd_hda_codec_hdmi snd_sof_amd_acp snd_sof_pci snd_sof snd_sof_utils joydev snd_hda_intel snd_inte
l_dspcfg snd_soc_core
snd_intel_sdw_acpi snd_hda_codec snd_compress uvcvideo iwlwifi ac97_bus snd_hda_core videobuf2_vmalloc snd_pcm_dmaengine videobuf2_memops videobuf2_v4l2 snd_hwdep snd_pci_acp6x snd_pci_acp5x iwlmei snd_seq videobuf2_common videodev snd_seq_device snd_rn_pci_acp3x mc cfg80211 snd_acp_config k10temp snd_pcm sp5100_tco ipmi_devintf snd_soc_acpi snd_pci_acp3x snd_timer i2c_piix4 mei r8169 ipmi_msghandler wmi serial_multi_instantiate i2c_scmi(OE) fuse xenfs ip_tables dm_thin_pool dm_persistent_data dm_bio_prison dm_crypt hid_multitouch amdgpu sdhci_pci cqhci crct10dif_pclmul
  drm_ttm_helper crc32_pclmul ttm sdhci crc32c_intel ghash_clmulni_intel serio_raw ehci_pci gpu_sched mmc_core xhci_pci ehci_hcd xhci_pci_renesas drm_buddy ucsi_acpi nvme drm_display_helper thinkpad_acpi xhci_hcd cec ccp nvme_core typec_ucsi ledtrig_audio platform_profile typec rfkill snd soundcore video xen_acpi_processor xen_privcmd xen_pciback xen_blkback xen_gntalloc xen_gntdev xen_evtchn uinput amd_pmc
CPU: 2 PID: 538 Comm: gfx Tainted: G        W  OE      6.0.0-1.fc32.qubes.x86_64 #1
Hardware name: LENOVO 20Y1S02400/20Y1S02400, BIOS R1BET72W(1.41 ) 06/27/2022
RIP: e030:refcount_warn_saturate+0xba/0x110
Code: 01 01 e8 27 cb 66 00 0f 0b e9 d2 6e ab 00 80 3d 2f 78 77 01 00 75 85 48 c7 c7 10 62 8c 82 c6 05 1f 78 77 01 01 e8 04 cb 66 00 <0f> 0b e9 af 6e ab 00 80 3d 0a 78 77 01 00 0f 85 5e ff ff ff 48 c7
RSP: e02b:ffffc90041037e88 EFLAGS: 00010282
RAX: 0000000000000000 RBX: ffff8881108896d8 RCX: 0000000000000000
RDX: 0000000000000001 RSI: ffffffff828ada7f RDI: 00000000ffffffff
RBP: ffff888110889618 R08: 0000000000000000 R09: 00000000ffffdfff
R10: ffffc90041037d48 R11: ffffffff82d45dc8 R12: 0000000000000000
R13: ffff888110889790 R14: ffff88810df016a8 R15: ffff888110889618
FS:  0000000000000000(0000) GS:ffff888140880000(0000) knlGS:0000000000000000
CS:  e030 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000592edf3c1e08 CR3: 0000000109fdc000 CR4: 0000000000010660
Call Trace:
  <TASK>
  drm_sched_main+0x9c/0x4b0 [gpu_sched]
  ? sd_flags_show+0xb0/0xb0
  ? drm_sched_job_cleanup+0x130/0x130 [gpu_sched]
  kthread+0xe7/0x110
  ? kthread_complete_and_exit+0x20/0x20
  ret_from_fork+0x22/0x30
  </TASK>
---[ end trace 0000000000000000 ]---
[drm] Skip scheduling IBs!
[drm] Skip scheduling IBs!
[drm] Skip scheduling IBs!
[drm] Skip scheduling IBs!
[drm] Skip scheduling IBs!
[drm] Skip scheduling IBs!

