From: Leo Liu <leo.liu-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: move UVD/VCE and VCN structure out from union
Date: Tue, 21 Nov 2017 11:13:16 -0500
Message-ID: <648f7d30-5f15-b64c-2220-36cac6caed16@amd.com>
References: <20171121142804.4047-1-leo.liu@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2110989910=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20171121142804.4047-1-leo.liu-5C7GfCeVMHo@public.gmane.org>
Content-Language: en-GB
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
To: "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org >> amd-gfx list" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

This is a multi-part message in MIME format.
--===============2110989910==
Content-Type: multipart/alternative;
 boundary="------------96DC964390F057E3FF4E2DD3"
Content-Language: en-GB

This is a multi-part message in MIME format.
--------------96DC964390F057E3FF4E2DD3
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

Wth the current upstream Mesa, kernel will spin error and break when 
starting display manger at least on my Polaris10 card.

This is because the query info from VCN enc from Mesa, and 
"adev->vcn.num_enc_rings" is not zero because of the union.

[ 9066.794232] BUG: unable to handle kernel paging request at 
ffff99b6400001ec
[ 9066.794293] IP: amdgpu_info_ioctl+0xee2/0x1070 [amdgpu]
[ 9066.794295] PGD 44229067 P4D 44229067 PUD 0
[ 9066.794300] Oops: 0000 [#1] SMP
[ 9066.794302] Modules linked in: fuse amdgpu(OE) mfd_core chash ttm 
k10temp i2c_piix4
[ 9066.794310] CPU: 3 PID: 24999 Comm: Xorg Tainted: G OE   4.14.0-rc3+ #4
[ 9066.794311] Hardware name: Gigabyte Technology Co., Ltd. 
GA-880GMA-UD2H/GA-880GMA-UD2H, BIOS F5 09/30/2010
[ 9066.794313] task: ffff99b62a930040 task.stack: ffffadf280c60000
[ 9066.794339] RIP: 0010:amdgpu_info_ioctl+0xee2/0x1070 [amdgpu]
[ 9066.794340] RSP: 0018:ffffadf280c63b70 EFLAGS: 00010217
[ 9066.794342] RAX: 0000000000000000 RBX: ffffadf280c63db0 RCX: 
0000000000063c59
[ 9066.794344] RDX: ffff99b6400001ec RSI: 00000000ffffffff RDI: 
00000000ffffffff
[ 9066.794345] RBP: ffffadf280c63d28 R08: 000000000000e200 R09: 
0000000000000001
[ 9066.794346] R10: 0000000000000000 R11: 0000000000000000 R12: 
ffff99b61e7b0000
[ 9066.794348] R13: ffffffffc0127730 R14: 0000000000000020 R15: 
00007ffd852f0410
[ 9066.794350] FS:  00007f0265507a00(0000) GS:ffff99b63fcc0000(0000) 
knlGS:0000000000000000
[ 9066.794351] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 9066.794352] CR2: ffff99b6400001ec CR3: 000000013763d000 CR4: 
00000000000006e0
[ 9066.794354] Call Trace:
[ 9066.794359]  ? kernel_text_address+0x69/0xc0
[ 9066.794362]  ? rcu_read_lock_sched_held+0x1d/0x60
[ 9066.794365]  ? module_assert_mutex_or_preempt+0x13/0x40
[ 9066.794366]  ? __module_address+0x27/0xf0
[ 9066.794391]  ? amdgpu_drm_ioctl+0x32/0x80 [amdgpu]
[ 9066.794395]  ? entry_SYSCALL_64_fastpath+0x1f/0xbe
[ 9066.794396]  ? __kernel_text_address+0xd/0x40
[ 9066.794399]  ? unwind_get_return_address+0x1a/0x30
[ 9066.794402]  ? __save_stack_trace+0x61/0xd0
[ 9066.794404]  ? entry_SYSCALL_64_fastpath+0x1f/0xbe
[ 9066.794430]  ? amdgpu_debugfs_firmware_info+0x290/0x290 [amdgpu]
[ 9066.794433]  drm_ioctl_kernel+0x64/0xb0
[ 9066.794435]  drm_ioctl+0x30a/0x3d0
[ 9066.794461]  ? amdgpu_debugfs_firmware_info+0x290/0x290 [amdgpu]
[ 9066.794464]  ? trace_hardirqs_on_caller+0x11f/0x190
[ 9066.794466]  ? trace_hardirqs_on+0xd/0x10
[ 9066.794492]  amdgpu_drm_ioctl+0x47/0x80 [amdgpu]
[ 9066.794495]  do_vfs_ioctl+0x8e/0x640
[ 9066.794497]  ? trace_hardirqs_on+0xd/0x10
[ 9066.794500]  ? security_file_ioctl+0x3e/0x60


On 11/21/2017 09:28 AM, Leo Liu wrote:
> With the enablement of VCN Dec and Enc from user space, User space queries
> kernel for the IP information, if HW has UVD/VCE, the info comes from these
> IP blocks, but this could end up mis-interpret for VCN when they are in the
> union, ther other way same when HW with VCN block.
>
> Signed-off-by: Leo Liu<leo.liu-5C7GfCeVMHo@public.gmane.org>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu.h | 20 ++++++++------------
>   1 file changed, 8 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index 750336dce0e9..86f91789de6d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -1590,18 +1590,14 @@ struct amdgpu_device {
>   	/* sdma */
>   	struct amdgpu_sdma		sdma;
>   
> -	union {
> -		struct {
> -			/* uvd */
> -			struct amdgpu_uvd		uvd;
> -
> -			/* vce */
> -			struct amdgpu_vce		vce;
> -		};
> -
> -		/* vcn */
> -		struct amdgpu_vcn		vcn;
> -	};
> +	/* uvd */
> +	struct amdgpu_uvd		uvd;
> +
> +	/* vce */
> +	struct amdgpu_vce		vce;
> +
> +	/* vcn */
> +	struct amdgpu_vcn		vcn;
>   
>   	/* firmwares */
>   	struct amdgpu_firmware		firmware;


--------------96DC964390F057E3FF4E2DD3
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <p>Wth the current upstream Mesa, kernel will spin error and break
      when starting display manger at least on my Polaris10 card. <br>
    </p>
    <p>This is because the query info from VCN enc from Mesa, and
      "adev-&gt;vcn.num_enc_rings" is not zero because of the union. <br>
    </p>
    <p>[ 9066.794232] BUG: unable to handle kernel paging request at
      ffff99b6400001ec<br>
      [ 9066.794293] IP: amdgpu_info_ioctl+0xee2/0x1070 [amdgpu]<br>
      [ 9066.794295] PGD 44229067 P4D 44229067 PUD 0 <br>
      [ 9066.794300] Oops: 0000 [#1] SMP<br>
      [ 9066.794302] Modules linked in: fuse amdgpu(OE) mfd_core chash
      ttm k10temp i2c_piix4<br>
      [ 9066.794310] CPU: 3 PID: 24999 Comm: Xorg Tainted: G          
      OE   4.14.0-rc3+ #4<br>
      [ 9066.794311] Hardware name: Gigabyte Technology Co., Ltd.
      GA-880GMA-UD2H/GA-880GMA-UD2H, BIOS F5 09/30/2010<br>
      [ 9066.794313] task: ffff99b62a930040 task.stack: ffffadf280c60000<br>
      [ 9066.794339] RIP: 0010:amdgpu_info_ioctl+0xee2/0x1070 [amdgpu]<br>
      [ 9066.794340] RSP: 0018:ffffadf280c63b70 EFLAGS: 00010217<br>
      [ 9066.794342] RAX: 0000000000000000 RBX: ffffadf280c63db0 RCX:
      0000000000063c59<br>
      [ 9066.794344] RDX: ffff99b6400001ec RSI: 00000000ffffffff RDI:
      00000000ffffffff<br>
      [ 9066.794345] RBP: ffffadf280c63d28 R08: 000000000000e200 R09:
      0000000000000001<br>
      [ 9066.794346] R10: 0000000000000000 R11: 0000000000000000 R12:
      ffff99b61e7b0000<br>
      [ 9066.794348] R13: ffffffffc0127730 R14: 0000000000000020 R15:
      00007ffd852f0410<br>
      [ 9066.794350] FS:  00007f0265507a00(0000)
      GS:ffff99b63fcc0000(0000) knlGS:0000000000000000<br>
      [ 9066.794351] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033<br>
      [ 9066.794352] CR2: ffff99b6400001ec CR3: 000000013763d000 CR4:
      00000000000006e0<br>
      [ 9066.794354] Call Trace:<br>
      [ 9066.794359]  ? kernel_text_address+0x69/0xc0<br>
      [ 9066.794362]  ? rcu_read_lock_sched_held+0x1d/0x60<br>
      [ 9066.794365]  ? module_assert_mutex_or_preempt+0x13/0x40<br>
      [ 9066.794366]  ? __module_address+0x27/0xf0<br>
      [ 9066.794391]  ? amdgpu_drm_ioctl+0x32/0x80 [amdgpu]<br>
      [ 9066.794395]  ? entry_SYSCALL_64_fastpath+0x1f/0xbe<br>
      [ 9066.794396]  ? __kernel_text_address+0xd/0x40<br>
      [ 9066.794399]  ? unwind_get_return_address+0x1a/0x30<br>
      [ 9066.794402]  ? __save_stack_trace+0x61/0xd0<br>
      [ 9066.794404]  ? entry_SYSCALL_64_fastpath+0x1f/0xbe<br>
      [ 9066.794430]  ? amdgpu_debugfs_firmware_info+0x290/0x290
      [amdgpu]<br>
      [ 9066.794433]  drm_ioctl_kernel+0x64/0xb0<br>
      [ 9066.794435]  drm_ioctl+0x30a/0x3d0<br>
      [ 9066.794461]  ? amdgpu_debugfs_firmware_info+0x290/0x290
      [amdgpu]<br>
      [ 9066.794464]  ? trace_hardirqs_on_caller+0x11f/0x190<br>
      [ 9066.794466]  ? trace_hardirqs_on+0xd/0x10<br>
      [ 9066.794492]  amdgpu_drm_ioctl+0x47/0x80 [amdgpu]<br>
      [ 9066.794495]  do_vfs_ioctl+0x8e/0x640<br>
      [ 9066.794497]  ? trace_hardirqs_on+0xd/0x10<br>
      [ 9066.794500]  ? security_file_ioctl+0x3e/0x60<br>
      <br>
    </p>
    <br>
    <div class="moz-cite-prefix">On 11/21/2017 09:28 AM, Leo Liu wrote:<br>
    </div>
    <blockquote type="cite"
      cite="mid:20171121142804.4047-1-leo.liu-5C7GfCeVMHo@public.gmane.org">
      <pre wrap="">With the enablement of VCN Dec and Enc from user space, User space queries
kernel for the IP information, if HW has UVD/VCE, the info comes from these
IP blocks, but this could end up mis-interpret for VCN when they are in the
union, ther other way same when HW with VCN block.

Signed-off-by: Leo Liu <a class="moz-txt-link-rfc2396E" href="mailto:leo.liu-5C7GfCeVMHo@public.gmane.org">&lt;leo.liu-5C7GfCeVMHo@public.gmane.org&gt;</a>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h | 20 ++++++++------------
 1 file changed, 8 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 750336dce0e9..86f91789de6d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1590,18 +1590,14 @@ struct amdgpu_device {
 	/* sdma */
 	struct amdgpu_sdma		sdma;
 
-	union {
-		struct {
-			/* uvd */
-			struct amdgpu_uvd		uvd;
-
-			/* vce */
-			struct amdgpu_vce		vce;
-		};
-
-		/* vcn */
-		struct amdgpu_vcn		vcn;
-	};
+	/* uvd */
+	struct amdgpu_uvd		uvd;
+
+	/* vce */
+	struct amdgpu_vce		vce;
+
+	/* vcn */
+	struct amdgpu_vcn		vcn;
 
 	/* firmwares */
 	struct amdgpu_firmware		firmware;
</pre>
    </blockquote>
    <br>
  </body>
</html>

--------------96DC964390F057E3FF4E2DD3--

--===============2110989910==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============2110989910==--
