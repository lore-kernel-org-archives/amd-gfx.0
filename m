From: Sven Van Asbroeck <thesven73@gmail.com>
Subject: Re: [PATCH v2] drm/amdgpu: fix multiple memory leaks
Date: Thu, 19 Sep 2019 10:28:22 -0400
Message-ID: <CAGngYiWHe1mw0+Ay6HO7kG5y8HMriUX3BO8VUcTvGayEK-4JOw@mail.gmail.com>
References: <7bab24ff-ded7-9f76-ba25-efd07cdd30dd@amd.com> <20190918190529.17298-1-navid.emamdoost@gmail.com>
 <88fc639a-32ed-b6c6-f930-552083d5887d@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <88fc639a-32ed-b6c6-f930-552083d5887d@amd.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Koenig, Christian" <Christian.Koenig@amd.com>
Cc: Navid Emamdoost <navid.emamdoost@gmail.com>, "emamd001@umn.edu" <emamd001@umn.edu>, "smccaman@umn.edu" <smccaman@umn.edu>, "kjlu@umn.edu" <kjlu@umn.edu>, "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Zhou, David(ChunMing)" <David1.Zhou@amd.com>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, Rex Zhu <Rex.Zhu@amd.com>, Sam Ravnborg <sam@ravnborg.org>, "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: amd-gfx.lists.freedesktop.org

Hi Christian,

On Thu, Sep 19, 2019 at 4:05 AM Koenig, Christian
<Christian.Koenig@amd.com> wrote:
>
> > +out4:
> > +     kfree(i2s_pdata);
> > +out3:
> > +     kfree(adev->acp.acp_res);
> > +out2:
> > +     kfree(adev->acp.acp_cell);
> > +out1:
> > +     kfree(adev->acp.acp_genpd);
>
> kfree on a NULL pointer is harmless, so a single error label should be
> sufficient.

That is true, but I notice that the adev structure comes from outside this
driver:

static int acp_hw_init(void *handle)
{
...
struct amdgpu_device *adev = (struct amdgpu_device *)handle;
...
}

As far as I can tell, the init() does not explicitly set these to NULL:
adev->acp.acp_res
adev->acp.acp_cell
adev->acp.acp_genpd

I am assuming that core code sets these to NULL, before calling
acp_hw_init(). But is that guaranteed or simply a happy accident?
Ie. if they are NULL today, are they likely to remain NULL tomorrow?

Because calling kfree() on a stale pointer would be, well
not good. Especially not on an error path, which typically
does not receive much testing, if any.

My apologies if I have misinterpreted this, I am not familiar with
this code base.

Sven
