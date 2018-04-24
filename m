From: ebiederm@xmission.com (Eric W. Biederman)
Subject: Re: [PATCH 3/3] drm/amdgpu: Switch to interrupted wait to recover from ring hang.
Date: Tue, 24 Apr 2018 11:14:24 -0500
Message-ID: <8736zkd1jz.fsf@xmission.com>
References: <1524583836-12130-1-git-send-email-andrey.grodzovsky@amd.com>
        <1524583836-12130-4-git-send-email-andrey.grodzovsky@amd.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1524583836-12130-4-git-send-email-andrey.grodzovsky@amd.com>
        (Andrey Grodzovsky's message of "Tue, 24 Apr 2018 11:30:36 -0400")
Sender: linux-kernel-owner@vger.kernel.org
To: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
Cc: linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com, Christian.Koenig@amd.com, David.Panariti@amd.com, oleg@redhat.com, akpm@linux-foundation.org
List-Id: amd-gfx.lists.freedesktop.org

Andrey Grodzovsky <andrey.grodzovsky@amd.com> writes:

> If the ring is hanging for some reason allow to recover the waiting
> by sending fatal signal.
>
> Originally-by: David Panariti <David.Panariti@amd.com>
> Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c | 14 ++++++++++----
>  1 file changed, 10 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> index eb80edf..37a36af 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> @@ -421,10 +421,16 @@ int amdgpu_ctx_wait_prev_fence(struct amdgpu_ctx *ctx, unsigned ring_id)
>  
>  	if (other) {
>  		signed long r;
> -		r = dma_fence_wait_timeout(other, false, MAX_SCHEDULE_TIMEOUT);
> -		if (r < 0) {
> -			DRM_ERROR("Error (%ld) waiting for fence!\n", r);
> -			return r;
> +
> +		while (true) {
> +			if ((r = dma_fence_wait_timeout(other, true,
> +					MAX_SCHEDULE_TIMEOUT)) >= 0)
> +				return 0;
> +
> +			if (fatal_signal_pending(current)) {
> +				DRM_ERROR("Error (%ld) waiting for fence!\n", r);
> +				return r;
> +			}

It looks like if you make this code say:
			if (fatal_signal_pending(current) ||
			    (current->flags & PF_EXITING)) {
				DRM_ERROR("Error (%ld) waiting for fence!\n", r);
				return r;
>  		}
>  	}

Than you would not need the horrible hack want_signal to deliver signals
to processes who have passed exit_signal() and don't expect to need
their signal handling mechanisms anymore.

Eric
