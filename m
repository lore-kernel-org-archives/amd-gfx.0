From: Felix Kuehling <felix.kuehling@amd.com>
Subject: Re: [PATCH] drm/amdkfd: NULL dereference involving create_process()
Date: Wed, 14 Jun 2017 14:34:44 -0400
Message-ID: <2ccf5b7b-c4e8-c0d3-fd8e-d7438ba8681f@amd.com>
References: <20170614105853.GP29394@elgon.mountain>
 <BN6PR12MB16526A96549054656758635FF7C30@BN6PR12MB1652.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <kernel-janitors-owner@vger.kernel.org>
In-Reply-To: <BN6PR12MB16526A96549054656758635FF7C30@BN6PR12MB1652.namprd12.prod.outlook.com>
Content-Language: en-CA
Sender: kernel-janitors-owner@vger.kernel.org
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>, 'Dan Carpenter' <dan.carpenter@oracle.com>, Oded Gabbay <oded.gabbay@gmail.com>, Alexey Skidanov <Alexey.Skidanov@amd.com>
Cc: "Koenig, Christian" <Christian.Koenig@amd.com>, David Airlie <airlied@linux.ie>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
List-Id: amd-gfx.lists.freedesktop.org

Yeah, I saw this earlier. I'm on the amd-gfx list.

The patch looks good to me. Feel free to add my R-b. Do you want to
apply it to amd-staging-4.11 and drm-next? I can take care of
amd-kfd-staging and the release branches.

Thanks,
  Felix


On 17-06-14 12:41 PM, Deucher, Alexander wrote:
> > -----Original Message-----
> > From: Dan Carpenter [mailto:dan.carpenter@oracle.com]
> > Sent: Wednesday, June 14, 2017 6:59 AM
> > To: Oded Gabbay; Alexey Skidanov
> > Cc: Deucher, Alexander; Koenig, Christian; David Airlie; dri-
> > devel@lists.freedesktop.org; amd-gfx@lists.freedesktop.org; kernel-
> > janitors@vger.kernel.org
> > Subject: [PATCH] drm/amdkfd: NULL dereference involving create_process()
> >
> > We accidentally return ERR_PTR(0) which is NULL.  The caller is not
> > expecting that and it leads to an Oops.
> >
> > Fixes: dd59239a9862 ("amdkfd: init aperture once per process")
> > Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
>
> Include Felix.
>
> Alex
>
> >
> > diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> > b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> > index 84d1ffd1eef9..1190d06884ed 100644
> > --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> > +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> > @@ -318,7 +318,8 @@ static struct kfd_process *create_process(const
> struct
> > task_struct *thread)
> >
> >        /* init process apertures*/
> >        process->is_32bit_user_mode = in_compat_syscall();
> > -     if (kfd_init_apertures(process) != 0)
> > +     err = kfd_init_apertures(process);
> > +     if (err != 0)
> >                goto err_init_apretures;
> >
> >        return process;

