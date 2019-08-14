From: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [Intel-gfx] [PATCH v6 08/17] drm/ttm: use gem vma_node
Date: Wed, 14 Aug 2019 12:14:11 +0200
Message-ID: <20190814101411.lj3p6zjzbjvnnjf4@sirius.home.kraxel.org>
References: <20190805140119.7337-1-kraxel@redhat.com>
 <20190805140119.7337-9-kraxel@redhat.com>
 <20190813151115.GA29955@ulmo>
 <20190814055827.6hrxj6daovxxnnvw@sirius.home.kraxel.org>
 <20190814093524.GA31345@ulmo>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190814093524.GA31345@ulmo>
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Ben Skeggs <bskeggs@redhat.com>, dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org, amd-gfx@lists.freedesktop.org, linux-graphics-maintainer@vmware.com, intel-gfx@lists.freedesktop.org, spice-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
List-Id: amd-gfx.lists.freedesktop.org

  Hi,

> > Changing the order doesn't look hard.  Patch attached (untested, have no
> > test hardware).  But maybe I missed some detail ...
> 
> I came up with something very similar by splitting up nouveau_bo_new()
> into allocation and initialization steps, so that when necessary the GEM
> object can be initialized in between. I think that's slightly more
> flexible and easier to understand than a boolean flag.

Yes, that should work too.

Acked-by: Gerd Hoffmann <kraxel@redhat.com>

cheers,
  Gerd
