From: Nathan Chancellor <natechancellor@gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Add braces to initialize task_info subojects
Date: Wed, 12 Sep 2018 11:45:47 -0700
Message-ID: <20180912184547.GA31724@flashbox>
References: <20180912002559.1853-1-natechancellor@gmail.com>
 <CAKwvOdkMg_1JxVNhKrUM0CZxF6nQo8c5h7t4zu4RP2xEXyQdKQ@mail.gmail.com>
 <20180912183843.GB30421@flashbox>
 <CADnq5_MHoZXf+16ZqoA-h974-=2Ewk1TwbdiuAs71X6WiuL4GQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CADnq5_MHoZXf+16ZqoA-h974-=2Ewk1TwbdiuAs71X6WiuL4GQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Alex Deucher <alexdeucher@gmail.com>
Cc: ndesaulniers@google.com, Chunming Zhou <David1.Zhou@amd.com>, LKML <linux-kernel@vger.kernel.org>, Maling list - DRI developers <dri-devel@lists.freedesktop.org>, richardsmith@google.com, amd-gfx list <amd-gfx@lists.freedesktop.org>, "Deucher, Alexander" <alexander.deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>
List-Id: amd-gfx.lists.freedesktop.org

On Wed, Sep 12, 2018 at 02:44:34PM -0400, Alex Deucher wrote:
> On Wed, Sep 12, 2018 at 2:40 PM Nathan Chancellor
> <natechancellor@gmail.com> wrote:
> >
> > On Wed, Sep 12, 2018 at 10:38:30AM -0700, Nick Desaulniers wrote:
> > > On Tue, Sep 11, 2018 at 5:26 PM Nathan Chancellor
> > > <natechancellor@gmail.com> wrote:
> > > >
> > > > Clang warns if there are missing braces around a subobject
> > > > initializer.
> > > >
> > > > drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c:1447:41: warning: suggest braces
> > > > around initialization of subobject [-Wmissing-braces]
> > > >                 struct amdgpu_task_info task_info = { 0 };
> > > >                                                       ^
> > > >                                                       {}
> > > > 1 warning generated.
> > > >
> > > > drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c:262:41: warning: suggest braces
> > > > around initialization of subobject [-Wmissing-braces]
> > > >                 struct amdgpu_task_info task_info = { 0 };
> > > >                                                       ^
> > > >                                                       {}
> > > > 1 warning generated.
> > > >
> > > > Reported-by: Nick Desaulniers <ndesaulniers@google.com>
> > > > Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> > > > ---
> > > >  drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c | 2 +-
> > > >  drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c | 2 +-
> > > >  2 files changed, 2 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
> > > > index 9333109b210d..968cc1b8cdff 100644
> > > > --- a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
> > > > +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
> > > > @@ -1444,7 +1444,7 @@ static int gmc_v8_0_process_interrupt(struct amdgpu_device *adev,
> > > >                 gmc_v8_0_set_fault_enable_default(adev, false);
> > > >
> > > >         if (printk_ratelimit()) {
> > > > -               struct amdgpu_task_info task_info = { 0 };
> > > > +               struct amdgpu_task_info task_info = { { 0 } };
> > >
> > > Hi Nathan,
> > > Thanks for this patch.  I discussed this syntax with our language
> > > lawyers.  Turns out, this is not quite correct, as you're now saying
> > > "initialize the first subobject to zero, but not the rest of the
> > > object."  -Wmissing-field-initializers would highlight this, but it's
> > > not part of -Wall.  It would be more correct to zero initialize the
> > > full struct, including all of its subobjects with `= {};`.
> > >
> >
> > Good point, I was debating on which one was correct. There are several
> > places in this driver that use the multiple brace + 0 idiom, which is
> > why I used this form. I will spin up a v2 with your suggestion, thank
> > you for the review!
> 
> Feel free to fix up the others as well. The others were only changed
> due to the same warning you sent the patch for.
> 
> Alex
> 

Hi Alex,

Thank you for the information, I will do that in v2.

Thanks,
Nathan

> >
> > Nathan
> >
> > > >
> > > >                 amdgpu_vm_get_task_info(adev, entry->pasid, &task_info);
> > > >
> > > > diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> > > > index 72f8018fa2a8..a781a5027212 100644
> > > > --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> > > > +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> > > > @@ -259,7 +259,7 @@ static int gmc_v9_0_process_interrupt(struct amdgpu_device *adev,
> > > >         }
> > > >
> > > >         if (printk_ratelimit()) {
> > > > -               struct amdgpu_task_info task_info = { 0 };
> > > > +               struct amdgpu_task_info task_info = { { 0 } };
> > > >
> > > >                 amdgpu_vm_get_task_info(adev, entry->pasid, &task_info);
> > > >
> > > > --
> > > > 2.18.0
> > > >
> > >
> > >
> > > --
> > > Thanks,
> > > ~Nick Desaulniers
> > _______________________________________________
> > amd-gfx mailing list
> > amd-gfx@lists.freedesktop.org
> > https://lists.freedesktop.org/mailman/listinfo/amd-gfx
