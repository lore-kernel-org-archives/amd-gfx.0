From: Lionel Landwerlin <lionel.g.landwerlin-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 09/11] drm/syncobj: add transition iotcls between binary
 and timeline
Date: Mon, 18 Feb 2019 12:07:58 +0000
Message-ID: <83890a08-769a-b52a-f2f6-9fe425f2562c@intel.com>
References: <20181207095601.2058-1-david1.zhou@amd.com>
 <20181207095601.2058-9-david1.zhou@amd.com>
 <95b9b990-fd69-197c-97c5-a8a1bfa4c6e6@intel.com>
 <e3d6b775-01b0-c694-5abe-47a91ce2e0ba@amd.com>
 <27a38e11-0c77-4340-aac9-b02e816c6f58@email.android.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1299319351=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <27a38e11-0c77-4340-aac9-b02e816c6f58-2ueSQiBKiTY7tOexoI0I+QC/G2K4zDHf@public.gmane.org>
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
To: "Koenig, Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>, "Zhou, David(ChunMing)" <David1.Zhou-5C7GfCeVMHo@public.gmane.org>
Cc: "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

This is a multi-part message in MIME format.
--===============1299319351==
Content-Type: multipart/alternative;
 boundary="------------4F3AF5DC861C90BDB8685CF4"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------4F3AF5DC861C90BDB8685CF4
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Thanks guys :)

You mentioned that signaling out of order is illegal.
Is this illegal with regard to the vulkan spec or to the syncobj 
implementation?

I'm not finding anything in the vulkan spec that makes out of order 
signaling illegal.
That's why I came up with this test, just verifying that the timeline 
does not go backward in term of its payload.

-Lionel

On 18/02/2019 11:01, Koenig, Christian wrote:
> Hi David,
>
> well I think Lionel is testing the invalid signal order on purpose :)
>
> Anyway we really need to handle invalid order graceful here. E.g. 
> either the same way as during CS or we abort and return an error message.
>
> I think just using the same approach as during CS ist the best we can do.
>
> Regards,
> Christian
>
>
> Am 18.02.2019 11:35 schrieb "Zhou, David(ChunMing)" <David1.Zhou-5C7GfCeVMHo@public.gmane.org>:
>
> Hi Lionel,
>
> I checked your igt test case,
>
> uint64_t points[5] = { 1, 5, 3, 7, 6 };
>
> which is illegal signal order.
>
> I must admit we should handle it gracefully if signal isn't in-order, 
> and we shouldn't lead to deadlock.
>
> Hi Christian,
>
> Can we just ignore when signal point X <= timeline Y? Or just give a 
> warning?
>
> Otherwise like Lionel's unexpected use cases, which easily leads to 
> deadlock.
>
>
> -David
>
>
> On 2019年02月15日 22:28, Lionel Landwerlin wrote:
>> Hi David,
>>
>> Thanks a lot for point me to the tests you've added in IGT.
>> While adding a test with that signals fences imported into a timeline
>> syncobj out of order, I ran into a deadlock.
>> Here is the test :
>> https://github.com/djdeath/intel-gpu-tools/commit/1e46cf7e7bff09b78a24367ddc2314f97eb0a1b9
>>
>> Trying to kill the deadlocked process I got this backtrace :
>>
>>
>> [   33.969136] [IGT] syncobj_timeline: starting subtest signal-order
>> [   60.452823] watchdog: BUG: soft lockup - CPU#6 stuck for 23s!
>> [syncobj_timelin:2021]
>> [   60.452826] Modules linked in: rfcomm cmac bnep binfmt_misc
>> nls_iso8859_1 snd_hda_codec_hdmi snd_hda_codec_realtek
>> snd_hda_codec_generic ledtrig_audio sch_fq_codel ib_iser snd_hda_intel
>> rdma_cm iw_cm snd_hda_codec ib_cm snd_hda_core snd_hwdep intel_rapl
>> snd_pcm ib_core x86_pkg_temp_thermal intel_powerclamp configf
>> s coretemp iscsi_tcp snd_seq_midi libiscsi_tcp snd_seq_midi_event
>> libiscsi kvm_intel scsi_transport_iscsi kvm btusb snd_rawmidi irqbypass
>> btrtl intel_cstate intel_rapl_perf btbcm btintel bluetooth snd_seq
>> snd_seq_device snd_timer input_leds ecdh_generic snd soundcore mei_me
>> mei intel_pch_thermal mac_hid acpi_pad parp
>> ort_pc ppdev lp parport ip_tables x_tables autofs4 btrfs zstd_decompress
>> zstd_compress raid10 raid456 async_raid6_recov async_memcpy async_pq
>> async_xor async_tx xor raid6_pq libcrc32c raid1 raid0 multipath linear
>> hid_generic usbhid hid i915 crct10dif_pclmul crc32_pclmul i2c_algo_bit
>> ghash_clmulni_intel prime_numbers
>> drm_kms_helper aesni_intel syscopyarea sysfillrect
>> [   60.452876]  sysimgblt fb_sys_fops aes_x86_64 crypto_simd sdhci_pci
>> cryptd drm e1000e glue_helper cqhci sdhci wmi video
>> [   60.452881] CPU: 6 PID: 2021 Comm: syncobj_timelin Tainted: G
>> U            5.0.0-rc5+ #337
>> [   60.452882] Hardware name:  /NUC6i7KYB, BIOS
>> KYSKLi70.86A.0042.2016.0929.1933 09/29/2016
>> [   60.452886] RIP: 0010:dma_fence_chain_walk+0x22c/0x260
>> [   60.452888] Code: ff e9 93 fe ff ff 48 8b 45 08 48 8b 40 18 48 85 c0
>> 74 0c 48 89 ef e8 33 0f 58 00 84 c0 75 23 f0 41 ff 4d 00 0f 88 99 87 2f
>> 00 <0f> 85 05 fe ff ff 4c 89 ef e8 56 ea ff ff 48 89 d8 5b 5d 41 5c 41
>> [   60.452888] RSP: 0018:ffff9a5804653ca8 EFLAGS: 00010296 ORIG_RAX:
>> ffffffffffffff13
>> [   60.452889] RAX: 0000000000000000 RBX: ffff8f5690fb2480 RCX:
>> ffff8f5690fb2f00
>> [   60.452890] RDX: 00000000003e3730 RSI: 0000000000000000 RDI:
>> ffff8f5690fb2180
>> [   60.452891] RBP: ffff8f5690fb2180 R08: 0000000000000000 R09:
>> ffff8f5690fb2eb0
>> [   60.452891] R10: 0000000000000000 R11: ffff8f5660469860 R12:
>> ffff8f5690fb2f68
>> [   60.452892] R13: ffff8f5690fb2f00 R14: 0000000000000003 R15:
>> ffff8f5655a45fc0
>> [   60.452913] FS:  00007fdc5c459980(0000) GS:ffff8f569eb80000(0000)
>> knlGS:0000000000000000
>> [   60.452913] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> [   60.452914] CR2: 00007f9d74336dd8 CR3: 000000084a67e004 CR4:
>> 00000000003606e0
>> [   60.452915] DR0: 0000000000000000 DR1: 0000000000000000 DR2:
>> 0000000000000000
>> [   60.452915] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7:
>> 0000000000000400
>> [   60.452916] Call Trace:
>> [   60.452958]  drm_syncobj_add_point+0x102/0x160 [drm]
>> [   60.452965]  ? drm_syncobj_fd_to_handle_ioctl+0x1b0/0x1b0 [drm]
>> [   60.452971]  drm_syncobj_transfer_ioctl+0x10f/0x180 [drm]
>> [   60.452978]  drm_ioctl_kernel+0xac/0xf0 [drm]
>> [   60.452984]  drm_ioctl+0x2eb/0x3b0 [drm]
>> [   60.452990]  ? drm_syncobj_fd_to_handle_ioctl+0x1b0/0x1b0 [drm]
>> [   60.452992]  ? sw_sync_ioctl+0x347/0x370
>> [   60.452994]  do_vfs_ioctl+0xa4/0x640
>> [   60.452995]  ? __fput+0x134/0x220
>> [   60.452997]  ? do_fcntl+0x1a5/0x650
>> [   60.452998]  ksys_ioctl+0x70/0x80
>> [   60.452999]  __x64_sys_ioctl+0x16/0x20
>> [   60.453002]  do_syscall_64+0x55/0x110
>> [   60.453004]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
>> [   60.453005] RIP: 0033:0x7fdc5b6e45d7
>> [   60.453006] Code: b3 66 90 48 8b 05 b1 48 2d 00 64 c7 00 26 00 00 00
>> 48 c7 c0 ff ff ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 b8 10 00 00 00 0f
>> 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 81 48 2d 00 f7 d8 64 89 01 48
>> [   60.453007] RSP: 002b:00007fff25c4d198 EFLAGS: 00000206 ORIG_RAX:
>> 0000000000000010
>> [   60.453008] RAX: ffffffffffffffda RBX: 0000000000000000 RCX:
>> 00007fdc5b6e45d7
>> [   60.453008] RDX: 00007fff25c4d200 RSI: 00000000c02064cc RDI:
>> 0000000000000003
>> [   60.453009] RBP: 00007fff25c4d1d0 R08: 0000000000000000 R09:
>> 000000000000001e
>> [   60.453010] R10: 0000000000000000 R11: 0000000000000206 R12:
>> 0000563d3959e4d0
>> [   60.453010] R13: 00007fff25c4d620 R14: 0000000000000000 R15:
>> 0000000000000000
>> [   88.447359] watchdog: BUG: soft lockup - CPU#6 stuck for 22s!
>> [syncobj_timelin:2021]
>>
>>
>> -Lionel
>>
>>
>> On 07/12/2018 09:55, Chunming Zhou wrote:
>>> we need to import/export timeline point
>>>
>>> Signed-off-by: Chunming Zhou<david1.zhou-5C7GfCeVMHo@public.gmane.org>
>>> ---
>>>    drivers/gpu/drm/drm_internal.h |  4 +++
>>>    drivers/gpu/drm/drm_ioctl.c    |  6 ++++
>>>    drivers/gpu/drm/drm_syncobj.c  | 66 ++++++++++++++++++++++++++++++++++
>>>    include/uapi/drm/drm.h         | 10 ++++++
>>>    4 files changed, 86 insertions(+)
>>>
>>> diff --git a/drivers/gpu/drm/drm_internal.h b/drivers/gpu/drm/drm_internal.h
>>> index dab4d5936441..ecbe3d51a702 100644
>>> --- a/drivers/gpu/drm/drm_internal.h
>>> +++ b/drivers/gpu/drm/drm_internal.h
>>> @@ -176,6 +176,10 @@ int drm_syncobj_handle_to_fd_ioctl(struct drm_device *dev, void *data,
>>>    				   struct drm_file *file_private);
>>>    int drm_syncobj_fd_to_handle_ioctl(struct drm_device *dev, void *data,
>>>    				   struct drm_file *file_private);
>>> +int drm_syncobj_binary_to_timeline_ioctl(struct drm_device *dev, void *data,
>>> +					 struct drm_file *file_private);
>>> +int drm_syncobj_timeline_to_binary_ioctl(struct drm_device *dev, void *data,
>>> +					 struct drm_file *file_private);
>>>    int drm_syncobj_wait_ioctl(struct drm_device *dev, void *data,
>>>    			   struct drm_file *file_private);
>>>    int drm_syncobj_timeline_wait_ioctl(struct drm_device *dev, void *data,
>>> diff --git a/drivers/gpu/drm/drm_ioctl.c b/drivers/gpu/drm/drm_ioctl.c
>>> index 7578ef6dc1d1..6b417e3c3ea5 100644
>>> --- a/drivers/gpu/drm/drm_ioctl.c
>>> +++ b/drivers/gpu/drm/drm_ioctl.c
>>> @@ -673,6 +673,12 @@ static const struct drm_ioctl_desc drm_ioctls[] = {
>>>    		      DRM_UNLOCKED|DRM_RENDER_ALLOW),
>>>    	DRM_IOCTL_DEF(DRM_IOCTL_SYNCOBJ_FD_TO_HANDLE, drm_syncobj_fd_to_handle_ioctl,
>>>    		      DRM_UNLOCKED|DRM_RENDER_ALLOW),
>>> +	DRM_IOCTL_DEF(DRM_IOCTL_SYNCOBJ_BINARY_TO_TIMELINE,
>>> +		      drm_syncobj_binary_to_timeline_ioctl,
>>> +		      DRM_UNLOCKED|DRM_RENDER_ALLOW),
>>> +	DRM_IOCTL_DEF(DRM_IOCTL_SYNCOBJ_TIMELINE_TO_BINARY,
>>> +		      drm_syncobj_timeline_to_binary_ioctl,
>>> +		      DRM_UNLOCKED|DRM_RENDER_ALLOW),
>>>    	DRM_IOCTL_DEF(DRM_IOCTL_SYNCOBJ_WAIT, drm_syncobj_wait_ioctl,
>>>    		      DRM_UNLOCKED|DRM_RENDER_ALLOW),
>>>    	DRM_IOCTL_DEF(DRM_IOCTL_SYNCOBJ_TIMELINE_WAIT, drm_syncobj_timeline_wait_ioctl,
>>> diff --git a/drivers/gpu/drm/drm_syncobj.c b/drivers/gpu/drm/drm_syncobj.c
>>> index 282982e58dbd..cf4daa670252 100644
>>> --- a/drivers/gpu/drm/drm_syncobj.c
>>> +++ b/drivers/gpu/drm/drm_syncobj.c
>>> @@ -670,6 +670,72 @@ drm_syncobj_fd_to_handle_ioctl(struct drm_device *dev, void *data,
>>>    					&args->handle);
>>>    }
>>>    
>>> +int
>>> +drm_syncobj_binary_to_timeline_ioctl(struct drm_device *dev, void *data,
>>> +				     struct drm_file *file_private)
>>> +{
>>> +	struct drm_syncobj_transfer *args = data;
>>> +	struct drm_syncobj *timeline_syncobj = NULL;
>>> +	struct dma_fence *fence;
>>> +	struct dma_fence_chain *chain;
>>> +	int ret;
>>> +
>>> +	if (!drm_core_check_feature(dev, DRIVER_SYNCOBJ))
>>> +		return -ENODEV;
>>> +
>>> +	if (args->pad)
>>> +		return -EINVAL;
>>> +
>>> +	timeline_syncobj = drm_syncobj_find(file_private, args->timeline_handle);
>>> +	if (!timeline_syncobj) {
>>> +		return -ENOENT;
>>> +	}
>>> +	ret = drm_syncobj_find_fence(file_private, args->binary_handle, 0, 0,
>>> +				     &fence);
>>> +	if (ret)
>>> +		goto err;
>>> +	chain = kzalloc(sizeof(struct dma_fence_chain), GFP_KERNEL);
>>> +	if (!chain)
>>> +		goto err1;
>>> +	drm_syncobj_add_point(timeline_syncobj, chain, fence, args->point);
>>> +err1:
>>> +	dma_fence_put(fence);
>>> +err:
>>> +	drm_syncobj_put(timeline_syncobj);
>>> +
>>> +	return ret;
>>> +}
>>> +
>>> +int
>>> +drm_syncobj_timeline_to_binary_ioctl(struct drm_device *dev, void *data,
>>> +				     struct drm_file *file_private)
>>> +{
>>> +	struct drm_syncobj_transfer *args = data;
>>> +	struct drm_syncobj *binary_syncobj = NULL;
>>> +	struct dma_fence *fence;
>>> +	int ret;
>>> +
>>> +	if (!drm_core_check_feature(dev, DRIVER_SYNCOBJ))
>>> +		return -ENODEV;
>>> +
>>> +	if (args->pad)
>>> +		return -EINVAL;
>>> +
>>> +	binary_syncobj = drm_syncobj_find(file_private, args->binary_handle);
>>> +	if (!binary_syncobj)
>>> +		return -ENOENT;
>>> +	ret = drm_syncobj_find_fence(file_private, args->timeline_handle,
>>> +				     args->point, args->flags, &fence);
>>> +	if (ret)
>>> +		goto err;
>>> +	drm_syncobj_replace_fence(binary_syncobj, fence);
>>> +	dma_fence_put(fence);
>>> +err:
>>> +	drm_syncobj_put(binary_syncobj);
>>> +
>>> +	return ret;
>>> +}
>>> +
>>>    static void syncobj_wait_fence_func(struct dma_fence *fence,
>>>    				    struct dma_fence_cb *cb)
>>>    {
>>> diff --git a/include/uapi/drm/drm.h b/include/uapi/drm/drm.h
>>> index b2c36f2b2599..88d6129d4a18 100644
>>> --- a/include/uapi/drm/drm.h
>>> +++ b/include/uapi/drm/drm.h
>>> @@ -735,6 +735,14 @@ struct drm_syncobj_handle {
>>>    	__u32 pad;
>>>    };
>>>    
>>> +struct drm_syncobj_transfer {
>>> +	__u32 binary_handle;
>>> +	__u32 timeline_handle;
>>> +	__u64 point;
>>> +	__u32 flags;
>>> +	__u32 pad;
>>> +};
>>> +
>>>    #define DRM_SYNCOBJ_WAIT_FLAGS_WAIT_ALL (1 << 0)
>>>    #define DRM_SYNCOBJ_WAIT_FLAGS_WAIT_FOR_SUBMIT (1 << 1)
>>>    #define DRM_SYNCOBJ_WAIT_FLAGS_WAIT_AVAILABLE (1 << 2)
>>> @@ -933,6 +941,8 @@ extern "C" {
>>>    
>>>    #define DRM_IOCTL_SYNCOBJ_TIMELINE_WAIT	DRM_IOWR(0xCA, struct drm_syncobj_timeline_wait)
>>>    #define DRM_IOCTL_SYNCOBJ_QUERY		DRM_IOWR(0xCB, struct drm_syncobj_timeline_array)
>>> +#define DRM_IOCTL_SYNCOBJ_BINARY_TO_TIMELINE	DRM_IOWR(0xCC, struct drm_syncobj_transfer)
>>> +#define DRM_IOCTL_SYNCOBJ_TIMELINE_TO_BINARY	DRM_IOWR(0xCD, struct drm_syncobj_transfer)
>>>    
>>>    /**
>>>     * Device specific ioctls should only be in their respective headers
>


--------------4F3AF5DC861C90BDB8685CF4
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <div class="moz-cite-prefix">Thanks guys :)</div>
    <div class="moz-cite-prefix"><br>
    </div>
    <div class="moz-cite-prefix">You mentioned that signaling out of
      order is illegal.</div>
    <div class="moz-cite-prefix">Is this illegal with regard to the
      vulkan spec or to the syncobj implementation?</div>
    <div class="moz-cite-prefix"><br>
    </div>
    <div class="moz-cite-prefix">I'm not finding anything in the vulkan
      spec that makes out of order signaling illegal.</div>
    <div class="moz-cite-prefix">That's why I came up with this test,
      just verifying that the timeline does not go backward in term of
      its payload.<br>
    </div>
    <div class="moz-cite-prefix"><br>
    </div>
    <div class="moz-cite-prefix">-Lionel<br>
    </div>
    <br>
    <div class="moz-cite-prefix">On 18/02/2019 11:01, Koenig, Christian
      wrote:<br>
    </div>
    <blockquote type="cite"
      cite="mid:27a38e11-0c77-4340-aac9-b02e816c6f58-2ueSQiBKiTY7tOexoI0I+QC/G2K4zDHf@public.gmane.org">
      <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
      <meta content="text/html; charset=utf-8">
      <div dir="auto">Hi David,
        <div dir="auto"><br>
        </div>
        <div dir="auto">well I think Lionel is testing the invalid
          signal order on purpose :)</div>
        <div dir="auto"><br>
        </div>
        <div dir="auto">Anyway we really need to handle invalid order
          graceful here. E.g. either the same way as during CS or we
          abort and return an error message.</div>
        <div dir="auto"><br>
        </div>
        <div dir="auto">I think just using the same approach as during
          CS ist the best we can do.</div>
        <div dir="auto"><br>
        </div>
        <div dir="auto">Regards,</div>
        <div dir="auto">Christian</div>
        <div dir="auto"><br>
        </div>
      </div>
      <div class="gmail_extra"><br>
        <div class="gmail_quote">Am 18.02.2019 11:35 schrieb "Zhou,
          David(ChunMing)" <a class="moz-txt-link-rfc2396E" href="mailto:David1.Zhou-5C7GfCeVMHo@public.gmane.org">&lt;David1.Zhou-5C7GfCeVMHo@public.gmane.org&gt;</a>:<br
            type="attribution">
        </div>
      </div>
      <div>
        <p>Hi Lionel,</p>
        <p>I checked your igt test case,</p>
        <p><span class="blob-code-inner"><span class="pl-c1">uint64_t</span>
            points[<span class="pl-c1">5</span>] = {
            <span class="pl-c1">1</span>, <span class="pl-c1">5</span>,
            <span class="pl-c1">3</span>,
            <span class="pl-c1">7</span>, <span class="pl-c1">6</span>
            };</span></p>
        <p><span class="blob-code-inner">which is illegal signal order.</span></p>
        <p><span class="blob-code-inner">I must admit we should handle
            it gracefully if signal isn't in-order, and we shouldn't
            lead to deadlock.</span></p>
        <p><span class="blob-code-inner">Hi Christian,</span></p>
        <p><span class="blob-code-inner">Can we just ignore when signal
            point X &lt;= timeline Y? Or just give a warning?</span></p>
        <p><span class="blob-code-inner">Otherwise like Lionel's
            unexpected use cases, which easily leads to deadlock.</span></p>
        <p><span class="blob-code-inner"><br>
          </span></p>
        <p><span class="blob-code-inner">-David<br>
          </span></p>
        <br>
        <div class="moz-cite-prefix">On 2019年02月15日 22:28, Lionel
          Landwerlin wrote:<br>
        </div>
        <blockquote type="cite">
          <pre>Hi David,

Thanks a lot for point me to the tests you've added in IGT.
While adding a test with that signals fences imported into a timeline 
syncobj out of order, I ran into a deadlock.
Here is the test : 
<a class="moz-txt-link-freetext" href="https://github.com/djdeath/intel-gpu-tools/commit/1e46cf7e7bff09b78a24367ddc2314f97eb0a1b9" moz-do-not-send="true">https://github.com/djdeath/intel-gpu-tools/commit/1e46cf7e7bff09b78a24367ddc2314f97eb0a1b9</a>

Trying to kill the deadlocked process I got this backtrace :


[   33.969136] [IGT] syncobj_timeline: starting subtest signal-order
[   60.452823] watchdog: BUG: soft lockup - CPU#6 stuck for 23s! 
[syncobj_timelin:2021]
[   60.452826] Modules linked in: rfcomm cmac bnep binfmt_misc 
nls_iso8859_1 snd_hda_codec_hdmi snd_hda_codec_realtek 
snd_hda_codec_generic ledtrig_audio sch_fq_codel ib_iser snd_hda_intel 
rdma_cm iw_cm snd_hda_codec ib_cm snd_hda_core snd_hwdep intel_rapl 
snd_pcm ib_core x86_pkg_temp_thermal intel_powerclamp configf
s coretemp iscsi_tcp snd_seq_midi libiscsi_tcp snd_seq_midi_event 
libiscsi kvm_intel scsi_transport_iscsi kvm btusb snd_rawmidi irqbypass 
btrtl intel_cstate intel_rapl_perf btbcm btintel bluetooth snd_seq 
snd_seq_device snd_timer input_leds ecdh_generic snd soundcore mei_me 
mei intel_pch_thermal mac_hid acpi_pad parp
ort_pc ppdev lp parport ip_tables x_tables autofs4 btrfs zstd_decompress 
zstd_compress raid10 raid456 async_raid6_recov async_memcpy async_pq 
async_xor async_tx xor raid6_pq libcrc32c raid1 raid0 multipath linear 
hid_generic usbhid hid i915 crct10dif_pclmul crc32_pclmul i2c_algo_bit 
ghash_clmulni_intel prime_numbers
drm_kms_helper aesni_intel syscopyarea sysfillrect
[   60.452876]  sysimgblt fb_sys_fops aes_x86_64 crypto_simd sdhci_pci 
cryptd drm e1000e glue_helper cqhci sdhci wmi video
[   60.452881] CPU: 6 PID: 2021 Comm: syncobj_timelin Tainted: G     
U            5.0.0-rc5+ #337
[   60.452882] Hardware name:  /NUC6i7KYB, BIOS 
KYSKLi70.86A.0042.2016.0929.1933 09/29/2016
[   60.452886] RIP: 0010:dma_fence_chain_walk+0x22c/0x260
[   60.452888] Code: ff e9 93 fe ff ff 48 8b 45 08 48 8b 40 18 48 85 c0 
74 0c 48 89 ef e8 33 0f 58 00 84 c0 75 23 f0 41 ff 4d 00 0f 88 99 87 2f 
00 &lt;0f&gt; 85 05 fe ff ff 4c 89 ef e8 56 ea ff ff 48 89 d8 5b 5d 41 5c 41
[   60.452888] RSP: 0018:ffff9a5804653ca8 EFLAGS: 00010296 ORIG_RAX: 
ffffffffffffff13
[   60.452889] RAX: 0000000000000000 RBX: ffff8f5690fb2480 RCX: 
ffff8f5690fb2f00
[   60.452890] RDX: 00000000003e3730 RSI: 0000000000000000 RDI: 
ffff8f5690fb2180
[   60.452891] RBP: ffff8f5690fb2180 R08: 0000000000000000 R09: 
ffff8f5690fb2eb0
[   60.452891] R10: 0000000000000000 R11: ffff8f5660469860 R12: 
ffff8f5690fb2f68
[   60.452892] R13: ffff8f5690fb2f00 R14: 0000000000000003 R15: 
ffff8f5655a45fc0
[   60.452913] FS:  00007fdc5c459980(0000) GS:ffff8f569eb80000(0000) 
knlGS:0000000000000000
[   60.452913] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   60.452914] CR2: 00007f9d74336dd8 CR3: 000000084a67e004 CR4: 
00000000003606e0
[   60.452915] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 
0000000000000000
[   60.452915] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 
0000000000000400
[   60.452916] Call Trace:
[   60.452958]  drm_syncobj_add_point+0x102/0x160 [drm]
[   60.452965]  ? drm_syncobj_fd_to_handle_ioctl+0x1b0/0x1b0 [drm]
[   60.452971]  drm_syncobj_transfer_ioctl+0x10f/0x180 [drm]
[   60.452978]  drm_ioctl_kernel+0xac/0xf0 [drm]
[   60.452984]  drm_ioctl+0x2eb/0x3b0 [drm]
[   60.452990]  ? drm_syncobj_fd_to_handle_ioctl+0x1b0/0x1b0 [drm]
[   60.452992]  ? sw_sync_ioctl+0x347/0x370
[   60.452994]  do_vfs_ioctl+0xa4/0x640
[   60.452995]  ? __fput+0x134/0x220
[   60.452997]  ? do_fcntl+0x1a5/0x650
[   60.452998]  ksys_ioctl+0x70/0x80
[   60.452999]  __x64_sys_ioctl+0x16/0x20
[   60.453002]  do_syscall_64+0x55/0x110
[   60.453004]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[   60.453005] RIP: 0033:0x7fdc5b6e45d7
[   60.453006] Code: b3 66 90 48 8b 05 b1 48 2d 00 64 c7 00 26 00 00 00 
48 c7 c0 ff ff ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 b8 10 00 00 00 0f 
05 &lt;48&gt; 3d 01 f0 ff ff 73 01 c3 48 8b 0d 81 48 2d 00 f7 d8 64 89 01 48
[   60.453007] RSP: 002b:00007fff25c4d198 EFLAGS: 00000206 ORIG_RAX: 
0000000000000010
[   60.453008] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 
00007fdc5b6e45d7
[   60.453008] RDX: 00007fff25c4d200 RSI: 00000000c02064cc RDI: 
0000000000000003
[   60.453009] RBP: 00007fff25c4d1d0 R08: 0000000000000000 R09: 
000000000000001e
[   60.453010] R10: 0000000000000000 R11: 0000000000000206 R12: 
0000563d3959e4d0
[   60.453010] R13: 00007fff25c4d620 R14: 0000000000000000 R15: 
0000000000000000
[   88.447359] watchdog: BUG: soft lockup - CPU#6 stuck for 22s! 
[syncobj_timelin:2021]


-Lionel


On 07/12/2018 09:55, Chunming Zhou wrote:
</pre>
          <blockquote type="cite">
            <pre>we need to import/export timeline point

Signed-off-by: Chunming Zhou <a class="moz-txt-link-rfc2396E" href="mailto:david1.zhou-5C7GfCeVMHo@public.gmane.org" moz-do-not-send="true">&lt;david1.zhou-5C7GfCeVMHo@public.gmane.org&gt;</a>
---
  drivers/gpu/drm/drm_internal.h |  4 +++
  drivers/gpu/drm/drm_ioctl.c    |  6 ++++
  drivers/gpu/drm/drm_syncobj.c  | 66 ++++++++++++++++++++++++++++++++++
  include/uapi/drm/drm.h         | 10 ++++++
  4 files changed, 86 insertions(+)

diff --git a/drivers/gpu/drm/drm_internal.h b/drivers/gpu/drm/drm_internal.h
index dab4d5936441..ecbe3d51a702 100644
--- a/drivers/gpu/drm/drm_internal.h
+++ b/drivers/gpu/drm/drm_internal.h
@@ -176,6 +176,10 @@ int drm_syncobj_handle_to_fd_ioctl(struct drm_device *dev, void *data,
  				   struct drm_file *file_private);
  int drm_syncobj_fd_to_handle_ioctl(struct drm_device *dev, void *data,
  				   struct drm_file *file_private);
+int drm_syncobj_binary_to_timeline_ioctl(struct drm_device *dev, void *data,
+					 struct drm_file *file_private);
+int drm_syncobj_timeline_to_binary_ioctl(struct drm_device *dev, void *data,
+					 struct drm_file *file_private);
  int drm_syncobj_wait_ioctl(struct drm_device *dev, void *data,
  			   struct drm_file *file_private);
  int drm_syncobj_timeline_wait_ioctl(struct drm_device *dev, void *data,
diff --git a/drivers/gpu/drm/drm_ioctl.c b/drivers/gpu/drm/drm_ioctl.c
index 7578ef6dc1d1..6b417e3c3ea5 100644
--- a/drivers/gpu/drm/drm_ioctl.c
+++ b/drivers/gpu/drm/drm_ioctl.c
@@ -673,6 +673,12 @@ static const struct drm_ioctl_desc drm_ioctls[] = {
  		      DRM_UNLOCKED|DRM_RENDER_ALLOW),
  	DRM_IOCTL_DEF(DRM_IOCTL_SYNCOBJ_FD_TO_HANDLE, drm_syncobj_fd_to_handle_ioctl,
  		      DRM_UNLOCKED|DRM_RENDER_ALLOW),
+	DRM_IOCTL_DEF(DRM_IOCTL_SYNCOBJ_BINARY_TO_TIMELINE,
+		      drm_syncobj_binary_to_timeline_ioctl,
+		      DRM_UNLOCKED|DRM_RENDER_ALLOW),
+	DRM_IOCTL_DEF(DRM_IOCTL_SYNCOBJ_TIMELINE_TO_BINARY,
+		      drm_syncobj_timeline_to_binary_ioctl,
+		      DRM_UNLOCKED|DRM_RENDER_ALLOW),
  	DRM_IOCTL_DEF(DRM_IOCTL_SYNCOBJ_WAIT, drm_syncobj_wait_ioctl,
  		      DRM_UNLOCKED|DRM_RENDER_ALLOW),
  	DRM_IOCTL_DEF(DRM_IOCTL_SYNCOBJ_TIMELINE_WAIT, drm_syncobj_timeline_wait_ioctl,
diff --git a/drivers/gpu/drm/drm_syncobj.c b/drivers/gpu/drm/drm_syncobj.c
index 282982e58dbd..cf4daa670252 100644
--- a/drivers/gpu/drm/drm_syncobj.c
+++ b/drivers/gpu/drm/drm_syncobj.c
@@ -670,6 +670,72 @@ drm_syncobj_fd_to_handle_ioctl(struct drm_device *dev, void *data,
  					&amp;args-&gt;handle);
  }
  
+int
+drm_syncobj_binary_to_timeline_ioctl(struct drm_device *dev, void *data,
+				     struct drm_file *file_private)
+{
+	struct drm_syncobj_transfer *args = data;
+	struct drm_syncobj *timeline_syncobj = NULL;
+	struct dma_fence *fence;
+	struct dma_fence_chain *chain;
+	int ret;
+
+	if (!drm_core_check_feature(dev, DRIVER_SYNCOBJ))
+		return -ENODEV;
+
+	if (args-&gt;pad)
+		return -EINVAL;
+
+	timeline_syncobj = drm_syncobj_find(file_private, args-&gt;timeline_handle);
+	if (!timeline_syncobj) {
+		return -ENOENT;
+	}
+	ret = drm_syncobj_find_fence(file_private, args-&gt;binary_handle, 0, 0,
+				     &amp;fence);
+	if (ret)
+		goto err;
+	chain = kzalloc(sizeof(struct dma_fence_chain), GFP_KERNEL);
+	if (!chain)
+		goto err1;
+	drm_syncobj_add_point(timeline_syncobj, chain, fence, args-&gt;point);
+err1:
+	dma_fence_put(fence);
+err:
+	drm_syncobj_put(timeline_syncobj);
+
+	return ret;
+}
+
+int
+drm_syncobj_timeline_to_binary_ioctl(struct drm_device *dev, void *data,
+				     struct drm_file *file_private)
+{
+	struct drm_syncobj_transfer *args = data;
+	struct drm_syncobj *binary_syncobj = NULL;
+	struct dma_fence *fence;
+	int ret;
+
+	if (!drm_core_check_feature(dev, DRIVER_SYNCOBJ))
+		return -ENODEV;
+
+	if (args-&gt;pad)
+		return -EINVAL;
+
+	binary_syncobj = drm_syncobj_find(file_private, args-&gt;binary_handle);
+	if (!binary_syncobj)
+		return -ENOENT;
+	ret = drm_syncobj_find_fence(file_private, args-&gt;timeline_handle,
+				     args-&gt;point, args-&gt;flags, &amp;fence);
+	if (ret)
+		goto err;
+	drm_syncobj_replace_fence(binary_syncobj, fence);
+	dma_fence_put(fence);
+err:
+	drm_syncobj_put(binary_syncobj);
+
+	return ret;
+}
+
  static void syncobj_wait_fence_func(struct dma_fence *fence,
  				    struct dma_fence_cb *cb)
  {
diff --git a/include/uapi/drm/drm.h b/include/uapi/drm/drm.h
index b2c36f2b2599..88d6129d4a18 100644
--- a/include/uapi/drm/drm.h
+++ b/include/uapi/drm/drm.h
@@ -735,6 +735,14 @@ struct drm_syncobj_handle {
  	__u32 pad;
  };
  
+struct drm_syncobj_transfer {
+	__u32 binary_handle;
+	__u32 timeline_handle;
+	__u64 point;
+	__u32 flags;
+	__u32 pad;
+};
+
  #define DRM_SYNCOBJ_WAIT_FLAGS_WAIT_ALL (1 &lt;&lt; 0)
  #define DRM_SYNCOBJ_WAIT_FLAGS_WAIT_FOR_SUBMIT (1 &lt;&lt; 1)
  #define DRM_SYNCOBJ_WAIT_FLAGS_WAIT_AVAILABLE (1 &lt;&lt; 2)
@@ -933,6 +941,8 @@ extern "C" {
  
  #define DRM_IOCTL_SYNCOBJ_TIMELINE_WAIT	DRM_IOWR(0xCA, struct drm_syncobj_timeline_wait)
  #define DRM_IOCTL_SYNCOBJ_QUERY		DRM_IOWR(0xCB, struct drm_syncobj_timeline_array)
+#define DRM_IOCTL_SYNCOBJ_BINARY_TO_TIMELINE	DRM_IOWR(0xCC, struct drm_syncobj_transfer)
+#define DRM_IOCTL_SYNCOBJ_TIMELINE_TO_BINARY	DRM_IOWR(0xCD, struct drm_syncobj_transfer)
  
  /**
   * Device specific ioctls should only be in their respective headers
</pre>
          </blockquote>
        </blockquote>
        <br>
      </div>
    </blockquote>
    <p><br>
    </p>
  </body>
</html>

--------------4F3AF5DC861C90BDB8685CF4--

--===============1299319351==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============1299319351==--
