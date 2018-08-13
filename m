From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] [v3] drm: amd: dc: don't use FP math when Kcov is enabled
Date: Mon, 13 Aug 2018 17:23:57 +0200
Message-ID: <CAK8P3a1AGC4fFYSSDQn2snkvf5htZVffCwRLV1NBm5YeZgw+CA@mail.gmail.com>
References: <20180811155554.3382650-1-arnd@arndb.de> <593dd8e1-fa23-3216-3550-274401d88bcb@gmail.com>
 <CADnq5_PCyKb72-BjFG3B4p_+bctNKoswAibw8C687_fpystSJA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CADnq5_PCyKb72-BjFG3B4p_+bctNKoswAibw8C687_fpystSJA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: alexdeucher@gmail.com
Cc: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, Alex Deucher <alexander.deucher@amd.com>, "David (ChunMing) Zhou" <David1.Zhou@amd.com>, Harry Wentland <Harry.Wentland@amd.com>, David Airlie <airlied@linux.ie>, michel.daenzer@amd.com, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, amd-gfx@lists.freedesktop.org, Shirish S <shirish.s@amd.com>, Jerry.Zuo@amd.com, dri-devel <dri-devel@lists.freedesktop.org>
List-Id: amd-gfx.lists.freedesktop.org

On Mon, Aug 13, 2018 at 4:49 PM Alex Deucher <alexdeucher@gmail.com> wrote:
>
> On Sun, Aug 12, 2018 at 3:55 AM Christian König
> <ckoenig.leichtzumerken@gmail.com> wrote:
> > Adding Harry as well.
> > Am 11.08.2018 um 17:54 schrieb Arnd Bergmann:
> > >
> > > Fixes: bf2e2e2e0ea9 ("drm/amd/display: Limit DCN to x86 arch")
> > > Fixes: 4841203102a3 ("drm/amdgpu/display: Replace CONFIG_DRM_AMD_DC_DCN1_0 with CONFIG_X86")
>
> Maybe it would be better to revert 4841203102a3 so we can limit the
> scope of this to DCN support.

That would help, but we would still require the patch at
https://patchwork.kernel.org/patch/10090227/ or something else to avoid
broken randconfig builds.

     Arnd
