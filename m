From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH] drm/amd/display: Fix boolean expression in
 get_surf_rq_param
Date: Thu, 21 Mar 2019 20:14:41 -0700
Message-ID: <742758434301d3329b336fd9c683dc753fbdc552.camel@perches.com>
References: <20190103194845.GA26175@embeddedor>
         <8169baae-434e-2d08-d63f-a285d1c3457e@amd.com>
         <456595ea-6f20-76d7-2ff3-773724123967@embeddedor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <456595ea-6f20-76d7-2ff3-773724123967@embeddedor.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>, "Wentland, Harry" <Harry.Wentland@amd.com>, "Laktyushkin, Dmytro" <Dmytro.Laktyushkin@amd.com>, "Li, Sun peng (Leo)" <Sunpeng.Li@amd.com>, "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian" <Christian.Koenig@amd.com>, "Zhou, David(ChunMing)" <David1.Zhou@amd.com>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, stable@vger.kernel.org
List-Id: amd-gfx.lists.freedesktop.org

On Thu, 2019-03-21 at 22:10 -0500, Gustavo A. R. Silva wrote:
> Hi Harry,
> 
> I noticed this patch is already in mainline, but the stable tag
> was removed.  What is the reason for that if this bug is present
> in stable?

It's not a bug, it's just a style issue and
the && use in some compilers it may be slower.

bool when set is 1.
