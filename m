From: Alex Deucher <alexdeucher@gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Fix a typo in the include header guard of 'navi12_ip_offset.h'
Date: Mon, 19 Aug 2019 09:08:43 -0400
Message-ID: <CADnq5_OsELJss5pyMmcHJnvVr7FpA0COJE+SmxM7ZQpfvQShYA@mail.gmail.com>
References: <20190818155957.4029-1-christophe.jaillet@wanadoo.fr> <81BEC287-3D11-4B5B-BF32-3E29F3266453@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <81BEC287-3D11-4B5B-BF32-3E29F3266453@amd.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Yuan, Xiaojie" <Xiaojie.Yuan@amd.com>
Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr>, "Xiao, Jack" <Jack.Xiao@amd.com>, "airlied@linux.ie" <airlied@linux.ie>, "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian" <Christian.Koenig@amd.com>, "Zhang, Hawking" <Hawking.Zhang@amd.com>
List-Id: amd-gfx.lists.freedesktop.org

Applied.  thanks!

Alex

On Sun, Aug 18, 2019 at 9:33 PM Yuan, Xiaojie <Xiaojie.Yuan@amd.com> wrote:
>
> Reviewed-by: Xiaojie Yuan <xiaojie.yuan@amd.com>
>
> Xiaojie
>
> > On Aug 19, 2019, at 12:00 AM, Christophe JAILLET <christophe.jaillet@wanadoo.fr> wrote:
> >
> > '_navi10_ip_offset_HEADER' is already used in 'navi10_ip_offset.h', so use
> > '_navi12_ip_offset_HEADER' instead here.
> >
> > Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> > ---
> > drivers/gpu/drm/amd/include/navi12_ip_offset.h | 4 ++--
> > 1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/include/navi12_ip_offset.h b/drivers/gpu/drm/amd/include/navi12_ip_offset.h
> > index 229e8fddfcc1..6c2cc6296c06 100644
> > --- a/drivers/gpu/drm/amd/include/navi12_ip_offset.h
> > +++ b/drivers/gpu/drm/amd/include/navi12_ip_offset.h
> > @@ -18,8 +18,8 @@
> >  * AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
> >  * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
> >  */
> > -#ifndef _navi10_ip_offset_HEADER
> > -#define _navi10_ip_offset_HEADER
> > +#ifndef _navi12_ip_offset_HEADER
> > +#define _navi12_ip_offset_HEADER
> >
> > #define MAX_INSTANCE                                       7
> > #define MAX_SEGMENT                                        5
> > --
> > 2.20.1
> >
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
