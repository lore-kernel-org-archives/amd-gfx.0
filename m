Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1E6BC5DF82
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Aug 2026 10:06:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7FFDD10E21F;
	Thu, 20 Aug 2026 10:06:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=pixelcluster.dev header.i=@pixelcluster.dev header.b="Qe7vPb2r";
	dkim-atps=neutral
X-Greylist: delayed 401 seconds by postgrey-1.36 at gabe;
 Thu, 20 Aug 2026 10:06:12 UTC
Received: from smtpout1.mo2.mail-out.ovh.net (smtpout1.mo2.mail-out.ovh.net
 [79.137.123.219])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3EC0810E21F
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Aug 2026 10:06:12 +0000 (UTC)
Received: from director3.derp.mail-out.ovh.net
 (director3.derp.mail-out.ovh.net [79.137.60.223])
 by mo2.mail-out.ovh.net (Postfix) with ESMTPS id 4hQf6m4t8pz488C;
 Thu, 20 Aug 2026 09:59:28 +0000 (UTC)
Received: from director3.derp.mail-out.ovh.net
 (director3.derp.mail-out.ovh.net. [127.0.0.1])
 by director3.derp.mail-out.ovh.net (inspect_sender_mail_agent) with SMTP
 for <alexander.deucher@amd.com>; Thu, 20 Aug 2026 09:59:28 +0000 (UTC)
Received: from mta3.priv.ovhmail-u1.ea.mail.ovh.net (unknown [10.109.231.53])
 by director3.derp.mail-out.ovh.net (Postfix) with ESMTPS id
 4hQf6m2qqzz1y8L; Thu, 20 Aug 2026 09:59:28 +0000 (UTC)
Received: from pixelcluster.dev (unknown [10.1.6.11])
 (Authenticated sender: nat@pixelcluster.dev)
 by mta3.priv.ovhmail-u1.ea.mail.ovh.net (Postfix) with ESMTPSA id E3080941AF5; 
 Thu, 20 Aug 2026 09:59:26 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-111S005b8ea7353-3f05-463a-9f9b-15bbabc0bbb5,
 272873839BD06AC788C5654E217593B0E5FF663A) smtp.auth=nat@pixelcluster.dev
X-OVh-ClientIp: 88.133.252.134
Message-ID: <6dcd3e9a-b308-44c6-a9cb-4bca149a2fde@pixelcluster.dev>
Date: Thu, 20 Aug 2026 11:59:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/3] drm/amdgpu/uapi: Add second-level trap handler
 ops to VM ioctl
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Felix Kuehling <felix.kuehling@amd.com>,
 James Zhu <james.zhu@amd.com>, Lijo Lazar <lijo.lazar@amd.com>,
 Lancelot Six <lancelot.six@amd.com>,
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>,
 Samuel Pitoiset <hakzsam@gmail.com>
References: <20260820070143.3916329-1-srinivasan.shanmugam@amd.com>
 <20260820070143.3916329-2-srinivasan.shanmugam@amd.com>
Content-Language: en-US
From: Natalie Vock <nat@pixelcluster.dev>
In-Reply-To: <20260820070143.3916329-2-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
x-ovh-tracer-id: 14987979560382652916
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTEzm86N0dMFhAyDanaKFRGUQnCHz7n7btvIXXcHdgRdA0d7Dctxjx6pAZFqyADuYsSYuNvg+UpF4OnpcQYh83PUVdl+rsxF7EVb2iwup3AqDdc9JIu5CHLAYbq7GXjsdnFNgj+ZX+6xErdGts/dRhvzVSHIAuHQRa7/OsYCeAH1jeSpBJrUU+t5fJqZfMvu+MyELKlromGw1hBnxzSpva2v0QIquHJ9Kw/+kWjMSM7K6gxgdO55Qspue4eFw6FsrTetCNKmk0idJx7NNCd7W5y5ykX0sf6VQ2XR4vzsy//dkuTlbS/8k81Kp+lpIPFdhnTiE8AtA4PZZfWIVxyF7hhNE0cpFkJa15M7MHyQMJvV6KsNMMmoLJJWb+fVoVtHzqPaQKyA5DWz01Yqcx52uTf85pWJ0Kb0OI5zmlrxvJKQJ7U3u6pN3ewG3lai3KjOnib24J+jYBEMOfc0QRnYy11acveOnZdlx4KO5pENT3UWtJL6x1XJwH7LnBMNuk4St/yKmgLo1BTz7C6kwddqPZl/blZOb27I1KdIeN8fbhl1gtpbFnU/tlS02xd7YjfpFYtfX9P42lgmHzPOpHeLUzhc1SDsGOJOlaPgrmZPnJ6hEjlcXfTGrZXhJPR9wlLns32PUkNAuGNQmWHX3JOetmWyhWW8/YINwGvAYZM/h8Ifug
DKIM-Signature: a=rsa-sha256; bh=L3Z0i0tO6auraOdmrwzr5OoyWeuR/yLjP/6tpWR0he4=; 
 c=relaxed/relaxed; d=pixelcluster.dev; h=From;
 s=ovhmo-selector-1; t=1787219969; v=1;
 b=Qe7vPb2rAVq6cp0Rmg6Zjxx+M2GLcY+5dXktb2UUr/UG7/m/WvjjHw9NNQXMdpvxrDv8hHaB
 DZohqhqamAwZ7xT91Seog+iuDxZPrJ8yWkgR8V3rFZ2uMHMJaCJZ6AJDmo/2/r1qWKYCo73uHZe
 vjCxj/WCSHitCEtxUcD4wDOJqaWrNpAQRtzExVqcqJq3HO9GHMWHI0Qlr64P9NFbGewQl9pIRn/
 Gyl3FMis2Iuq4aDM1+jzPOd/ZyZSD8f+fNW2ntQPOyK3zlZgIbbtbpePr3ViY5VPCIP/Pp5cijZ
 8ax7ToR9BdJD3+okhdYfx7A7GUXPL0xTtATh5NooNhaIw==
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hi,

first of all: Thanks for working on this! It's great seeing trap handler 
support come together.

On 8/20/26 09:01, Srinivasan Shanmugam wrote:
> When a GPU shader hits an exception, memory fault, or debug breakpoint,
> the hardware jumps to the first-level trap handler. The first-level
> handler (managed by the kernel via CWSR) checks the TMA buffer for a
> second-level handler address. If one is installed, it forwards the trap
> to that userspace handler, allowing the runtime or debugger to handle
> shader exceptions without modifying the kernel trap handler.
> 
> KFD already supports this for compute workloads. Render-node user queues
> had no equivalent mechanism. Add it.
> 
> The second-level handler is a per-VM setting — it applies to all shader
> waves executing under that VMID regardless of queue type. GFX and
> compute queues from the same process share the same VMID, so one
> SET_L2_TRAP call covers all queue types for that process. This
> configuration is not CWSR-specific; CWSR is only the first-level handler
> mechanism. The correct home for this setting is the VM ioctl
> (DRM_AMDGPU_VM), following the same pattern as
> AMDGPU_VM_OP_RESERVE_VMID.
> 
> Add two new VM ioctl operations:
>    AMDGPU_VM_OP_SET_L2_TRAP   (op = 3) — install second-level handler
>    AMDGPU_VM_OP_CLEAR_L2_TRAP (op = 4) — remove second-level handler
> 
> Extend drm_amdgpu_vm_in with a 32-byte union for op-specific data. The
> l2trap member carries the GPU virtual addresses and sizes of the TBA
> (handler code) and TMA (handler scratch memory).

This should be a BO handle and offset+size, instead. The BOs associated
with the TBA/TMA must be tracked as used by every submission from the VM
that has this trap handler installed, otherwise you introduce a ton of
race conditions. Off the top of my head, here are a few:
1. The GEM VA ioctl can spuriously fail to actually update page tables.
    This is okay and intentional, and BOs with outdated page tables will
    be updated on the next submit if they're used by the submission. If
    the TBA/TMA BOs aren't marked in the set of used buffers, the PTs may
    end up never being updated and subsequent accesses will fault.
2. The TBA/TMA may be evicted/moved around concurrently with executing
    submissions if these submissions didn't add their fences to the
    TBA/TMA resv, which would likely randomly corrupt things or hang.

A simpler solution could be requiring the TBA/TMA buffers to be
VM_ALWAYS_VALID, in which case synchronization to all submissions in the
VM is taken care of automagically. This prevents exporting the TBA/TMA
to an fd, but I don't expect anyone would want to do this.

Regards,
Natalie

> Existing ops only use
> the first 8 bytes (op + flags); the union is zero-initialized for those
> ops. The DRM framework zero-extends when userspace passes a smaller
> struct, so existing userspace is unaffected.
> 
> Explicit padding is used at every natural alignment boundary so the
> layout is identical for native and 32-bit compat userspace.
> 
> If the TBA or TMA mapping is removed via GEM_VA UNMAP/CLEAR while the
> handler is active, the kernel waits for the VM to be idle, evicts all
> user queues, flushes the GPU TLB, clears the handler, and allows the
> unmap to proceed. UNMAP never returns an error for this condition.
> Queues whose trap handler VA was removed are not restarted.
> 
> Cc: Christian König <christian.koenig@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Felix Kuehling <felix.kuehling@amd.com>
> Cc: James Zhu <james.zhu@amd.com>
> Cc: Lijo Lazar <lijo.lazar@amd.com>
> Cc: Lancelot Six <lancelot.six@amd.com>
> Cc: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
> Cc: Timur Kristóf <timur.kristof@gmail.com>
> Cc: Samuel Pitoiset <hakzsam@gmail.com>
> Cc: Natalie Vock <natalie.vock@gmx.de>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> Change-Id: Ie039e496c75092c91c13719a16d541c5f06c3257
> ---
>   include/uapi/drm/amdgpu_drm.h | 67 +++++++++++++++++++++++++++++++++++
>   1 file changed, 67 insertions(+)
> 
> diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
> index 9222be9a6d2a..872ff9d1d1ff 100644
> --- a/include/uapi/drm/amdgpu_drm.h
> +++ b/include/uapi/drm/amdgpu_drm.h
> @@ -634,10 +634,77 @@ struct drm_amdgpu_userq_wait {
>   #define AMDGPU_VM_OP_RESERVE_VMID	1
>   #define AMDGPU_VM_OP_UNRESERVE_VMID	2
>   
> +/**
> + * AMDGPU_VM_OP_SET_L2_TRAP - install or replace the second-level trap
> + *   handler for all GFX and compute user queues belonging to this VM.
> + *
> + * The second-level trap handler is a per-VM setting. All shader waves
> + * executing under this VMID share the same handler regardless of queue
> + * type. GFX and compute queues from the same process share the same VMID
> + * so one SET_L2_TRAP covers all queue types for this DRM file.
> + *
> + * The TBA range must contain the handler executable code.
> + * The TMA range is the handler scratch memory buffer.
> + * Both ranges must be non-empty and fully mapped in the GPU virtual
> + * address space of this DRM file descriptor.
> + *
> + * Userspace should keep both mappings alive until
> + * AMDGPU_VM_OP_CLEAR_L2_TRAP succeeds. If either mapping is removed
> + * while the handler is active, the kernel waits for the VM to be idle,
> + * evicts all user queues, flushes the GPU TLB, clears the handler, and
> + * allows the unmap to proceed. UNMAP never returns an error for this
> + * condition. Queues whose trap handler VA was removed are not restarted.
> + *
> + * Returns:
> + *  0             on success;
> + *  -EOPNOTSUPP   if the first-level CWSR handler is unavailable;
> + *  -EINVAL       for an invalid or incompletely mapped range;
> + *  negative errno if the VM reservation fails.
> + */
> +#define AMDGPU_VM_OP_SET_L2_TRAP	3
> +/**
> + * AMDGPU_VM_OP_CLEAR_L2_TRAP - disable the second-level trap handler.
> + *
> + * All active user queues are evicted and the GPU TLB is flushed before
> + * TBA is zeroed to ensure no wave is executing inside the handler at the
> + * time of the clear and no stale TBA/TMA values remain cached.
> + * The l2trap input members are ignored.
> + *
> + * After this operation succeeds userspace may safely remove the TBA
> + * and TMA mappings.
> + *
> + * Returns:
> + *  0             on success;
> + *  -EOPNOTSUPP   if the first-level CWSR handler is unavailable;
> + *  negative errno if the VM reservation fails.
> + */
> +#define AMDGPU_VM_OP_CLEAR_L2_TRAP	4
> +
>   struct drm_amdgpu_vm_in {
>   	/** AMDGPU_VM_OP_* */
>   	__u32	op;
>   	__u32	flags;
> +	union {
> +		struct {
> +			/** Second-level trap handler code base address (GPU VA) */
> +			__u64 tba_va;
> +			/** TBA buffer size in bytes */
> +			__u32 tba_sz;
> +			/** Explicit padding; tma_va starts at offset 24 */
> +			__u32 _pad;
> +			/** Second-level trap handler scratch memory address (GPU VA) */
> +			__u64 tma_va;
> +			/** TMA buffer size in bytes */
> +			__u32 tma_sz;
> +			/** Padding to fix total union size at 32 bytes */
> +			__u32 _pad2;
> +		} l2trap;
> +		/**
> +		 * Padding — keeps the union at a fixed 32-byte size for
> +		 * future ops. Zero-initialise for RESERVE/UNRESERVE_VMID.
> +		 */
> +		__u64 _pad[4];
> +	};
>   };
>   
>   struct drm_amdgpu_vm_out {

