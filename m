From: Peter Rosin <peda@axentia.se>
Subject: Re: [PATCH 08/11] drm: nouveau: remove dead code and pointless local
 lut storage
Date: Wed, 21 Jun 2017 12:35:02 +0200
Message-ID: <abeaa572-c129-f942-1aa4-ec028da846be@axentia.se>
References: <1497986735-14418-1-git-send-email-peda@axentia.se>
 <1497986735-14418-9-git-send-email-peda@axentia.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1497986735-14418-9-git-send-email-peda@axentia.se>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Alex Deucher <alexander.deucher@amd.com>, =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>, David Airlie <airlied@linux.ie>, Dave Airlie <airlied@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Daniel Vetter <daniel.vetter@intel.com>, Jani Nikula <jani.nikula@linux.intel.com>, Sean Paul <seanpaul@chromium.org>, Patrik Jakobsson <patrik.r.jakobsson@gmail.com>, Ben Skeggs <bskeggs@redhat.com>, Yannick Fertre <yannick.fertre@st.com>, Philippe Cornu <philippe.cornu@st.com>, Benjamin Gaignard <benjamin.gaignard@linaro.org>, Vincent Abriou <vincent.abriou@st.com>, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org, intel-gfx@lists.freedesktop.org, nouveau@lists.freedesktop.org, Boris
List-Id: amd-gfx.lists.freedesktop.org

On 2017-06-20 21:25, Peter Rosin wrote:
> The redundant fb helpers .load_lut, .gamma_set and .gamma_get are
> no longer used. Remove the dead code and hook up the crtc .gamma_set
> to use the crtc gamma_store directly instead of duplicating that
> info locally.

[...]

> -	for (i = 0; i < 256; i++) {
> -		u16 r = nv_crtc->lut.r[i] >> 2;
> -		u16 g = nv_crtc->lut.g[i] >> 2;
> -		u16 b = nv_crtc->lut.b[i] >> 2;
> +	r = crtc->gamma_store;
> +	g = r + crtc->gamma_size;
> +	b = g + crtc->gamma_size;
>  
> +	for (i = 0; i < 256; i++) {
>  		if (disp->disp->oclass < GF110_DISP) {
> -			writew(r + 0x0000, lut + (i * 0x08) + 0);
> -			writew(g + 0x0000, lut + (i * 0x08) + 2);
> -			writew(b + 0x0000, lut + (i * 0x08) + 4);
> +			writew((*r++ >> 2) + 0x0000, lut + (i * 0x08) + 0);
> +			writew((*g++ >> 2) + 0x0000, lut + (i * 0x08) + 2);
> +			writew((*b++ >> 2) + 0x0000, lut + (i * 0x08) + 4);
>  		} else {
> -			writew(r + 0x6000, lut + (i * 0x20) + 0);
> -			writew(g + 0x6000, lut + (i * 0x20) + 2);
> -			writew(b + 0x6000, lut + (i * 0x20) + 4);
> +			writew((*r++ >> 2) + 0x6000, lut + (i * 0x20) + 0);
> +			writew((*g++ >> 2) + 0x6000, lut + (i * 0x20) + 2);
> +			writew((*b++ >> 2) + 0x6000, lut + (i * 0x20) + 4);
>  		}
>  	}
>  }

I forgot to mention this, but the above is very strange for
disp->disp->oclass >= GF110_DISP because 0x6000 interferes with
the 14 bits that appear to be the lut depth in the registers.

I suspect some other bit-shift should be used for that case?

Someone should probably consult a datasheet...

Cheers,
peda
