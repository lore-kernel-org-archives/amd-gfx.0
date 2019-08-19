From: "Yuan, Xiaojie" <Xiaojie.Yuan@amd.com>
Subject: Re: [PATCH] drm/amdgpu: Fix a typo in the include header guard of
 'navi12_ip_offset.h'
Date: Mon, 19 Aug 2019 01:33:46 +0000
Message-ID: <81BEC287-3D11-4B5B-BF32-3E29F3266453@amd.com>
References: <20190818155957.4029-1-christophe.jaillet@wanadoo.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190818155957.4029-1-christophe.jaillet@wanadoo.fr>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian" <Christian.Koenig@amd.com>, "Zhou, David(ChunMing)" <David1.Zhou@amd.com>, "airlied@linux.ie" <airlied@linux.ie>, "daniel@ffwll.ch" <daniel@ffwll.ch>, "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Xiao, Jack" <Jack.Xiao@amd.com>, "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
List-Id: amd-gfx.lists.freedesktop.org

Reviewed-by: Xiaojie Yuan <xiaojie.yuan@amd.com>

Xiaojie

> On Aug 19, 2019, at 12:00 AM, Christophe JAILLET <christophe.jaillet@wana=
doo.fr> wrote:
>=20
> '_navi10_ip_offset_HEADER' is already used in 'navi10_ip_offset.h', so us=
e
> '_navi12_ip_offset_HEADER' instead here.
>=20
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> drivers/gpu/drm/amd/include/navi12_ip_offset.h | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/amd/include/navi12_ip_offset.h b/drivers/gpu=
/drm/amd/include/navi12_ip_offset.h
> index 229e8fddfcc1..6c2cc6296c06 100644
> --- a/drivers/gpu/drm/amd/include/navi12_ip_offset.h
> +++ b/drivers/gpu/drm/amd/include/navi12_ip_offset.h
> @@ -18,8 +18,8 @@
>  * AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
>  * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTW=
ARE.
>  */
> -#ifndef _navi10_ip_offset_HEADER
> -#define _navi10_ip_offset_HEADER
> +#ifndef _navi12_ip_offset_HEADER
> +#define _navi12_ip_offset_HEADER
>=20
> #define MAX_INSTANCE                                       7
> #define MAX_SEGMENT                                        5
> --=20
> 2.20.1
>=20
