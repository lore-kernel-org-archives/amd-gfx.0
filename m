From: Nathan Chancellor <natechancellor@gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Add braces to initialize task_info subojects
Date: Wed, 12 Sep 2018 13:30:55 -0700
Message-ID: <20180912203055.GA9320@flashbox>
References: <20180912002559.1853-1-natechancellor@gmail.com>
 <CAKwvOdkMg_1JxVNhKrUM0CZxF6nQo8c5h7t4zu4RP2xEXyQdKQ@mail.gmail.com>
 <CAGL0aWeYARfArmSJwXemE_QdGeRwnfE-CKh+DaRY8jwEF0SU5w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAGL0aWeYARfArmSJwXemE_QdGeRwnfE-CKh+DaRY8jwEF0SU5w@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Richard Smith <richardsmith@google.com>
Cc: Nick Desaulniers <ndesaulniers@google.com>, alexander.deucher@amd.com, christian.koenig@amd.com, David1.Zhou@amd.com, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
List-Id: amd-gfx.lists.freedesktop.org

On Wed, Sep 12, 2018 at 01:24:34PM -0700, Richard Smith wrote:
> On Wed, Sep 12, 2018 at 10:38 AM Nick Desaulniers <ndesaulniers@google.com>
> wrote:
> 
> > On Tue, Sep 11, 2018 at 5:26 PM Nathan Chancellor
> > <natechancellor@gmail.com> wrote:
> > >
> > > Clang warns if there are missing braces around a subobject
> > > initializer.
> > >
> > > drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c:1447:41: warning: suggest braces
> > > around initialization of subobject [-Wmissing-braces]
> > >                 struct amdgpu_task_info task_info = { 0 };
> > >                                                       ^
> > >                                                       {}
> > > 1 warning generated.
> > >
> > > drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c:262:41: warning: suggest braces
> > > around initialization of subobject [-Wmissing-braces]
> > >                 struct amdgpu_task_info task_info = { 0 };
> > >                                                       ^
> > >                                                       {}
> > > 1 warning generated.
> > >
> > > Reported-by: Nick Desaulniers <ndesaulniers@google.com>
> > > Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> > > ---
> > >  drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c | 2 +-
> > >  drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c | 2 +-
> > >  2 files changed, 2 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
> > b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
> > > index 9333109b210d..968cc1b8cdff 100644
> > > --- a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
> > > +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
> > > @@ -1444,7 +1444,7 @@ static int gmc_v8_0_process_interrupt(struct
> > amdgpu_device *adev,
> > >                 gmc_v8_0_set_fault_enable_default(adev, false);
> > >
> > >         if (printk_ratelimit()) {
> > > -               struct amdgpu_task_info task_info = { 0 };
> > > +               struct amdgpu_task_info task_info = { { 0 } };
> >
> > Hi Nathan,
> > Thanks for this patch.  I discussed this syntax with our language
> > lawyers.  Turns out, this is not quite correct, as you're now saying
> > "initialize the first subobject to zero, but not the rest of the
> > object."  -Wmissing-field-initializers would highlight this, but it's
> > not part of -Wall.  It would be more correct to zero initialize the
> > full struct, including all of its subobjects with `= {};`.
> >
> 
> Sorry, I think I've caused some confusion here.
> 
> Elements with an omitted initializer get implicitly zero-initialized. In
> C++, it's idiomatic to write `= {}` to perform aggregate
> zero-initialization, but in C, that's invalid because at least one
> initializer is syntactically required within the braces. As a result, `=
> {0}` is an idiomatic way to perform zero-initialization of an aggregate in
> C. Clang intends to suppress the -Wmissing-braces in that case; if the
> warning is still being produced in a recent version of Clang, that's a bug.
> However, the warning suppression was added between Clang 5 and Clang 6, so
> it's very plausible that the compiler being used here is simply older than
> the warning fix.
> 
> (Long story short: the change here seems fine, but should be unnecessary as
> of Clang 6.)
> 

Interesting...

nathan@flashbox ~/kernels/next (master >) $ clang --version | head -n1
clang version 6.0.1 (tags/RELEASE_601/final)

I guess the v2 I sent is unnecessary then. I'll leave it up to the
maintainers to decide which one they want to take.

Thanks!
Nathan

> 
> > >                 amdgpu_vm_get_task_info(adev, entry->pasid, &task_info);
> > >
> > > diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> > b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> > > index 72f8018fa2a8..a781a5027212 100644
> > > --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> > > +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> > > @@ -259,7 +259,7 @@ static int gmc_v9_0_process_interrupt(struct
> > amdgpu_device *adev,
> > >         }
> > >
> > >         if (printk_ratelimit()) {
> > > -               struct amdgpu_task_info task_info = { 0 };
> > > +               struct amdgpu_task_info task_info = { { 0 } };
> > >
> > >                 amdgpu_vm_get_task_info(adev, entry->pasid, &task_info);
> > >
> > > --
> > > 2.18.0
> > >
> >
> >
> > --
> > Thanks,
> > ~Nick Desaulniers
> >
