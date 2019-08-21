From: Ben Skeggs <skeggsb@gmail.com>
Subject: Re: [Nouveau] [Intel-gfx] [PATCH v6 08/17] drm/ttm: use gem vma_node
Date: Wed, 21 Aug 2019 16:33:58 +1000
Message-ID: <CACAvsv5Rar9F=Wf-9HBpndY4QaQZcGCx05j0esvV9pitM=JoGg@mail.gmail.com>
References: <20190805140119.7337-1-kraxel@redhat.com> <20190805140119.7337-9-kraxel@redhat.com>
 <20190813151115.GA29955@ulmo> <20190814055827.6hrxj6daovxxnnvw@sirius.home.kraxel.org>
 <20190814093524.GA31345@ulmo> <20190814101411.lj3p6zjzbjvnnjf4@sirius.home.kraxel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190814101411.lj3p6zjzbjvnnjf4@sirius.home.kraxel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, ML dri-devel <dri-devel@lists.freedesktop.org>, ML nouveau <nouveau@lists.freedesktop.org>, intel-gfx <intel-gfx@lists.freedesktop.org>, linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org, linux-graphics-maintainer@vmware.com, Ben Skeggs <bskeggs@redhat.com>, spice-devel@lists.freedesktop.org
List-Id: amd-gfx.lists.freedesktop.org

On Wed, 14 Aug 2019 at 20:14, Gerd Hoffmann <kraxel@redhat.com> wrote:
>
>   Hi,
>
> > > Changing the order doesn't look hard.  Patch attached (untested, have no
> > > test hardware).  But maybe I missed some detail ...
> >
> > I came up with something very similar by splitting up nouveau_bo_new()
> > into allocation and initialization steps, so that when necessary the GEM
> > object can be initialized in between. I think that's slightly more
> > flexible and easier to understand than a boolean flag.
>
> Yes, that should work too.
>
> Acked-by: Gerd Hoffmann <kraxel@redhat.com>
Acked-by: Ben Skeggs <bskeggs@redhat.com>

>
> cheers,
>   Gerd
>
> _______________________________________________
> Nouveau mailing list
> Nouveau@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/nouveau
