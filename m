From: Oded Gabbay <oded.gabbay@gmail.com>
Subject: Re: [PATCH] drm/amdkfd: NULL dereference involving create_process()
Date: Wed, 14 Jun 2017 23:34:57 +0300
Message-ID: <CAFCwf11tMreKQZNaeFzVVUnhSworrV8j945M52deuC0rM4NfwQ@mail.gmail.com>
References: <20170614105853.GP29394@elgon.mountain>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <kernel-janitors-owner@vger.kernel.org>
In-Reply-To: <20170614105853.GP29394@elgon.mountain>
Sender: kernel-janitors-owner@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, David Airlie <airlied@linux.ie>, Maling list - DRI developers <dri-devel@lists.freedesktop.org>, amd-gfx list <amd-gfx@lists.freedesktop.org>, kernel-janitors@vger.kernel.org, "Kuehling, Felix" <Felix.Kuehling@amd.com>
List-Id: amd-gfx.lists.freedesktop.org

On Wed, Jun 14, 2017 at 1:58 PM, Dan Carpenter <dan.carpenter@oracle.com> wrote:
>
> We accidentally return ERR_PTR(0) which is NULL.  The caller is not
> expecting that and it leads to an Oops.
>
> Fixes: dd59239a9862 ("amdkfd: init aperture once per process")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> index 84d1ffd1eef9..1190d06884ed 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> @@ -318,7 +318,8 @@ static struct kfd_process *create_process(const struct task_struct *thread)
>
>         /* init process apertures*/
>         process->is_32bit_user_mode = in_compat_syscall();
> -       if (kfd_init_apertures(process) != 0)
> +       err = kfd_init_apertures(process);
> +       if (err != 0)
>                 goto err_init_apretures;
>
>         return process;

Hi Dan,

Applied to amdkfd-next
Thanks!

Oded
