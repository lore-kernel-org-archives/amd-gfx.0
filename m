From: "S, Shirish" <sshankar-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: replace mutex with spin_lock
Date: Thu, 31 May 2018 15:26:47 +0530
Message-ID: <e3b7ccb3-c9d4-f6e0-f49e-289916409dda@amd.com>
References: <1527675594-24143-1-git-send-email-shirish.s@amd.com>
 <BN6PR12MB1809BB86BD60CB77FB5A7BADF76C0@BN6PR12MB1809.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1721597126=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <BN6PR12MB1809BB86BD60CB77FB5A7BADF76C0-/b2+HYfkarSEx6ez0IUAagdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
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
To: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>, "S, Shirish" <Shirish.S-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "Wentland, Harry" <Harry.Wentland-5C7GfCeVMHo@public.gmane.org>, "Zhu, Rex" <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>

This is a multi-part message in MIME format.
--===============1721597126==
Content-Type: multipart/alternative;
 boundary="------------5FBD8ABAAB741395CB62B53E"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------5FBD8ABAAB741395CB62B53E
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit



On 5/30/2018 8:51 PM, Deucher, Alexander wrote:
>> -----Original Message-----
>> From: amd-gfx [mailto:amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org] On Behalf
>> Of Shirish S
>> Sent: Wednesday, May 30, 2018 6:20 AM
>> To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org; Wentland, Harry
>> <Harry.Wentland-5C7GfCeVMHo@public.gmane.org>; Zhu, Rex <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
>> Cc: S, Shirish <Shirish.S-5C7GfCeVMHo@public.gmane.org>
>> Subject: [PATCH] drm/amdgpu: replace mutex with spin_lock
>>
>> mutex's lead to sleeps which should be avoided in atomic context.
>> Hence this patch replaces it with the spin_locks.
>>
>> Signed-off-by: Shirish S <shirish.s-5C7GfCeVMHo@public.gmane.org>
> Does this actually fix a bug or is it just to be safe?  Do actually call atom command tables in an atomic context?
I have re-spun V2 patch, with the stack trace so that you can see the 
path taken.

For reference below is the trace:

BUG: sleeping function called from invalid context at 
kernel/locking/mutex.c:238
in_atomic(): 1, irqs_disabled(): 1, pid: 89, name: kworker/u4:3
CPU: 1 PID: 89 Comm: kworker/u4:3 Tainted: G        W 4.14.43 #8
Workqueue: events_unbound commit_work
Call Trace:
  dump_stack+0x4d/0x63
  ___might_sleep+0x11f/0x12e
  mutex_lock+0x20/0x42
  amdgpu_atom_execute_table+0x26/0x72
  enable_disp_power_gating_v2_1+0x85/0xae
  dce110_enable_display_power_gating+0x83/0x1b1
  dce110_power_down_fe+0x4a/0x6d
  dc_post_update_surfaces_to_stream+0x59/0x87
  amdgpu_dm_do_flip+0x239/0x298
  amdgpu_dm_commit_planes.isra.23+0x379/0x54b
  ? drm_calc_timestamping_constants+0x14b/0x15c
  amdgpu_dm_atomic_commit_tail+0x4fc/0x5d2
  ? wait_for_common+0x5b/0x69
  commit_tail+0x42/0x64
  process_one_work+0x1b0/0x314
  worker_thread+0x1cb/0x2c1
  ? create_worker+0x1da/0x1da
  kthread+0x156/0x15e
  ? kthread_flush_work+0xea/0xea
  ret_from_fork+0x22/0x40

Its caused when a BUG hit in the kernel.

Thanks & Regards,
Shirish S
> Alex
>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c | 2 +-
>>   drivers/gpu/drm/amd/amdgpu/atom.c            | 4 ++--
>>   drivers/gpu/drm/amd/amdgpu/atom.h            | 3 ++-
>>   3 files changed, 5 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c
>> index bf872f6..ba3d4b9 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c
>> @@ -2033,7 +2033,7 @@ int amdgpu_atombios_init(struct amdgpu_device
>> *adev)
>>   		return -ENOMEM;
>>   	}
>>
>> -	mutex_init(&adev->mode_info.atom_context->mutex);
>> +	spin_lock_init(&adev->mode_info.atom_context->lock);
>>   	if (adev->is_atom_fw) {
>>   		amdgpu_atomfirmware_scratch_regs_init(adev);
>>   		amdgpu_atomfirmware_allocate_fb_scratch(adev);
>> diff --git a/drivers/gpu/drm/amd/amdgpu/atom.c
>> b/drivers/gpu/drm/amd/amdgpu/atom.c
>> index 69500a8..bfd98f0 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/atom.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/atom.c
>> @@ -1261,7 +1261,7 @@ int amdgpu_atom_execute_table(struct
>> atom_context *ctx, int index, uint32_t * pa  {
>>   	int r;
>>
>> -	mutex_lock(&ctx->mutex);
>> +	spin_lock(&ctx->lock);
>>   	/* reset data block */
>>   	ctx->data_block = 0;
>>   	/* reset reg block */
>> @@ -1274,7 +1274,7 @@ int amdgpu_atom_execute_table(struct
>> atom_context *ctx, int index, uint32_t * pa
>>   	ctx->divmul[0] = 0;
>>   	ctx->divmul[1] = 0;
>>   	r = amdgpu_atom_execute_table_locked(ctx, index, params);
>> -	mutex_unlock(&ctx->mutex);
>> +	spin_unlock(&ctx->lock);
>>   	return r;
>>   }
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/atom.h
>> b/drivers/gpu/drm/amd/amdgpu/atom.h
>> index a391709..cdfb0d0 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/atom.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/atom.h
>> @@ -26,6 +26,7 @@
>>   #define ATOM_H
>>
>>   #include <linux/types.h>
>> +#include <linux/spinlock_types.h>
>>   #include <drm/drmP.h>
>>
>>   #define ATOM_BIOS_MAGIC		0xAA55
>> @@ -125,7 +126,7 @@ struct card_info {
>>
>>   struct atom_context {
>>   	struct card_info *card;
>> -	struct mutex mutex;
>> +	spinlock_t lock;
>>   	void *bios;
>>   	uint32_t cmd_table, data_table;
>>   	uint16_t *iio;
>> --
>> 2.7.4
>>
>> _______________________________________________
>> amd-gfx mailing list
>> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
>> https://lists.freedesktop.org/mailman/listinfo/amd-gfx

-- 
Regards,
Shirish S


--------------5FBD8ABAAB741395CB62B53E
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
    <div class="moz-cite-prefix">On 5/30/2018 8:51 PM, Deucher,
      Alexander wrote:<br>
    </div>
    <blockquote type="cite"
cite="mid:BN6PR12MB1809BB86BD60CB77FB5A7BADF76C0-/b2+HYfkarSEx6ez0IUAagdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org">
      <blockquote type="cite">
        <pre wrap="">-----Original Message-----
From: amd-gfx [<a class="moz-txt-link-freetext" href="mailto:amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">mailto:amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a>] On Behalf
Of Shirish S
Sent: Wednesday, May 30, 2018 6:20 AM
To: <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a>; Wentland, Harry
<a class="moz-txt-link-rfc2396E" href="mailto:Harry.Wentland-5C7GfCeVMHo@public.gmane.org">&lt;Harry.Wentland-5C7GfCeVMHo@public.gmane.org&gt;</a>; Zhu, Rex <a class="moz-txt-link-rfc2396E" href="mailto:Rex.Zhu-5C7GfCeVMHo@public.gmane.org">&lt;Rex.Zhu-5C7GfCeVMHo@public.gmane.org&gt;</a>
Cc: S, Shirish <a class="moz-txt-link-rfc2396E" href="mailto:Shirish.S-5C7GfCeVMHo@public.gmane.org">&lt;Shirish.S-5C7GfCeVMHo@public.gmane.org&gt;</a>
Subject: [PATCH] drm/amdgpu: replace mutex with spin_lock

mutex's lead to sleeps which should be avoided in atomic context.
Hence this patch replaces it with the spin_locks.

Signed-off-by: Shirish S <a class="moz-txt-link-rfc2396E" href="mailto:shirish.s-5C7GfCeVMHo@public.gmane.org">&lt;shirish.s-5C7GfCeVMHo@public.gmane.org&gt;</a>
</pre>
      </blockquote>
      <pre wrap="">
Does this actually fix a bug or is it just to be safe?  Do actually call atom command tables in an atomic context?
</pre>
    </blockquote>
    I have re-spun V2 patch, with the stack trace so that you can see
    the path taken. <br>
    <br>
    For reference below is the trace:<br>
    <br>
    <font face="Calibri">BUG: sleeping function called from invalid
      context at kernel/locking/mutex.c:238<br>
      in_atomic(): 1, irqs_disabled(): 1, pid: 89, name: kworker/u4:3<br>
      CPU: 1 PID: 89 Comm: kworker/u4:3 Tainted: G        W      
      4.14.43 #8<br>
      Workqueue: events_unbound commit_work<br>
      Call Trace:<br>
       dump_stack+0x4d/0x63<br>
       ___might_sleep+0x11f/0x12e<br>
       mutex_lock+0x20/0x42<br>
       amdgpu_atom_execute_table+0x26/0x72<br>
       enable_disp_power_gating_v2_1+0x85/0xae<br>
       dce110_enable_display_power_gating+0x83/0x1b1<br>
       dce110_power_down_fe+0x4a/0x6d<br>
       dc_post_update_surfaces_to_stream+0x59/0x87<br>
       amdgpu_dm_do_flip+0x239/0x298<br>
       amdgpu_dm_commit_planes.isra.23+0x379/0x54b<br>
       ? drm_calc_timestamping_constants+0x14b/0x15c<br>
       amdgpu_dm_atomic_commit_tail+0x4fc/0x5d2<br>
       ? wait_for_common+0x5b/0x69<br>
       commit_tail+0x42/0x64<br>
       process_one_work+0x1b0/0x314<br>
       worker_thread+0x1cb/0x2c1<br>
       ? create_worker+0x1da/0x1da<br>
       kthread+0x156/0x15e<br>
       ? kthread_flush_work+0xea/0xea<br>
       ret_from_fork+0x22/0x40</font><br>
    <br>
    Its caused when a BUG hit in the kernel.<br>
    <br>
    Thanks &amp; Regards,<br>
    Shirish S
    <blockquote type="cite"
cite="mid:BN6PR12MB1809BB86BD60CB77FB5A7BADF76C0-/b2+HYfkarSEx6ez0IUAagdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org">
      <pre wrap="">
Alex

</pre>
      <blockquote type="cite">
        <pre wrap="">---
 drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c | 2 +-
 drivers/gpu/drm/amd/amdgpu/atom.c            | 4 ++--
 drivers/gpu/drm/amd/amdgpu/atom.h            | 3 ++-
 3 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c
b/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c
index bf872f6..ba3d4b9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c
@@ -2033,7 +2033,7 @@ int amdgpu_atombios_init(struct amdgpu_device
*adev)
 		return -ENOMEM;
 	}

-	mutex_init(&amp;adev-&gt;mode_info.atom_context-&gt;mutex);
+	spin_lock_init(&amp;adev-&gt;mode_info.atom_context-&gt;lock);
 	if (adev-&gt;is_atom_fw) {
 		amdgpu_atomfirmware_scratch_regs_init(adev);
 		amdgpu_atomfirmware_allocate_fb_scratch(adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/atom.c
b/drivers/gpu/drm/amd/amdgpu/atom.c
index 69500a8..bfd98f0 100644
--- a/drivers/gpu/drm/amd/amdgpu/atom.c
+++ b/drivers/gpu/drm/amd/amdgpu/atom.c
@@ -1261,7 +1261,7 @@ int amdgpu_atom_execute_table(struct
atom_context *ctx, int index, uint32_t * pa  {
 	int r;

-	mutex_lock(&amp;ctx-&gt;mutex);
+	spin_lock(&amp;ctx-&gt;lock);
 	/* reset data block */
 	ctx-&gt;data_block = 0;
 	/* reset reg block */
@@ -1274,7 +1274,7 @@ int amdgpu_atom_execute_table(struct
atom_context *ctx, int index, uint32_t * pa
 	ctx-&gt;divmul[0] = 0;
 	ctx-&gt;divmul[1] = 0;
 	r = amdgpu_atom_execute_table_locked(ctx, index, params);
-	mutex_unlock(&amp;ctx-&gt;mutex);
+	spin_unlock(&amp;ctx-&gt;lock);
 	return r;
 }

diff --git a/drivers/gpu/drm/amd/amdgpu/atom.h
b/drivers/gpu/drm/amd/amdgpu/atom.h
index a391709..cdfb0d0 100644
--- a/drivers/gpu/drm/amd/amdgpu/atom.h
+++ b/drivers/gpu/drm/amd/amdgpu/atom.h
@@ -26,6 +26,7 @@
 #define ATOM_H

 #include &lt;linux/types.h&gt;
+#include &lt;linux/spinlock_types.h&gt;
 #include &lt;drm/drmP.h&gt;

 #define ATOM_BIOS_MAGIC		0xAA55
@@ -125,7 +126,7 @@ struct card_info {

 struct atom_context {
 	struct card_info *card;
-	struct mutex mutex;
+	spinlock_t lock;
 	void *bios;
 	uint32_t cmd_table, data_table;
 	uint16_t *iio;
--
2.7.4

_______________________________________________
amd-gfx mailing list
<a class="moz-txt-link-abbreviated" href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a>
<a class="moz-txt-link-freetext" href="https://lists.freedesktop.org/mailman/listinfo/amd-gfx">https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a>
</pre>
      </blockquote>
    </blockquote>
    <br>
    <pre class="moz-signature" cols="72">-- 
Regards,
Shirish S</pre>
  </body>
</html>

--------------5FBD8ABAAB741395CB62B53E--

--===============1721597126==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1721597126==--
