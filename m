From: Julia Lawall <julia.lawall@lip6.fr>
Subject: Re: [PATCH 11/12] drm/amd/powerplay: drop unneeded newline
Date: Wed, 27 Dec 2017 21:11:56 +0100 (CET)
Message-ID: <alpine.DEB.2.20.1712272111390.2118@hadrien>
References: <1514386305-7402-1-git-send-email-Julia.Lawall@lip6.fr>
 <1514386305-7402-12-git-send-email-Julia.Lawall@lip6.fr>
 <0378ac3c-752c-12b4-6f7c-046b208ff6d7@daenzer.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-482809422-1514405516=:2118"
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <0378ac3c-752c-12b4-6f7c-046b208ff6d7@daenzer.net>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: =?ISO-8859-15?Q?Michel_D=E4nzer?= <michel@daenzer.net>
Cc: David Airlie <airlied@linux.ie>, kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>, =?ISO-8859-15?Q?Christian_K=F6nig?= <christian.koenig@amd.com>
List-Id: amd-gfx.lists.freedesktop.org

--8323329-482809422-1514405516=:2118
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT



On Wed, 27 Dec 2017, Michel Dänzer wrote:

> On 2017-12-27 03:51 PM, Julia Lawall wrote:
> > PP_ASSERT_WITH_CODE prints a newline at the end of the message string,
> > so the message string does not need to include a newline explicitly.
> > Done using Coccinelle.
> >
> > Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>
> >
> > ---
> >
> > I couldn't figure out how to configure the kernel to get any of this code
> > to compile.
>
> Just enabling CONFIG_DRM_AMDGPU should be enough AFAICT.

That seems to work.  Thanks.

julia
--8323329-482809422-1514405516=:2118
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVs
IG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCg==

--8323329-482809422-1514405516=:2118--
