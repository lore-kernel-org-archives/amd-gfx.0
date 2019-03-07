From: Nathan Chancellor <natechancellor@gmail.com>
Subject: Re: [PATCH] drm/amd/display: avoid passing enum as NULL pointer
Date: Thu, 7 Mar 2019 08:34:20 -0700
Message-ID: <20190307153420.GJ20201@archlinux-ryzen>
References: <20190307103454.1637485-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190307103454.1637485-1-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, Alex Deucher <alexander.deucher@amd.com>, Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>, "David (ChunMing) Zhou" <David1.Zhou@amd.com>, Nick Desaulniers <ndesaulniers@google.com>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, Anthony Koo <Anthony.Koo@amd.com>, Aric Cyr <Aric.Cyr@amd.com>, Harmanprit Tatla <Harmanprit.Tatla@amd.com>, Ken Chalmers <ken.chalmers@amd.com>, SivapiriyanKumarasamy <sivapiriyan.kumarasamy@amd.com>, Kees Cook <keescook@chromium.org>, Bayan Zabihiyan <Bayan.Zabihiyan@amd.com>, Tony Cheng <Tony.Cheng@amd.com>, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
List-Id: amd-gfx.lists.freedesktop.org

On Thu, Mar 07, 2019 at 11:34:29AM +0100, Arnd Bergmann wrote:
> The mod_freesync_build_vrr_infopacket() function uses rather obscure
> calling conventions, where an enum is passed in through a pointer,
> and a NULL pointer is expected to behave the same way as the zero-value
> (TRANSFER_FUNC_UNKNOWN).
> 
> Trying to build this with clang results in a warning:
> 
> drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:4601:3: error: expression which evaluates to zero treated
>       as a null pointer constant of type 'const enum color_transfer_func *' [-Werror,-Wnon-literal-null-conversion]
> 
> Passing it by value instead of by reference makes the code simpler
> and more conventional but should not change the behavior at all.
> 
> Fixes: c2791297013e ("drm/amd/display: Add color bit info to freesync infoframe")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/gpu/drm/amd/display/modules/freesync/freesync.c | 7 +++----
>  drivers/gpu/drm/amd/display/modules/inc/mod_freesync.h  | 2 +-
>  2 files changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/modules/freesync/freesync.c b/drivers/gpu/drm/amd/display/modules/freesync/freesync.c
> index 94a84bc57c7a..6f32fe129880 100644
> --- a/drivers/gpu/drm/amd/display/modules/freesync/freesync.c
> +++ b/drivers/gpu/drm/amd/display/modules/freesync/freesync.c
> @@ -724,7 +724,7 @@ static void build_vrr_infopacket_v1(enum signal_type signal,
>  
>  static void build_vrr_infopacket_v2(enum signal_type signal,
>  		const struct mod_vrr_params *vrr,
> -		const enum color_transfer_func *app_tf,
> +		const enum color_transfer_func app_tf,
>  		struct dc_info_packet *infopacket)
>  {
>  	unsigned int payload_size = 0;
> @@ -732,8 +732,7 @@ static void build_vrr_infopacket_v2(enum signal_type signal,
>  	build_vrr_infopacket_header_v2(signal, infopacket, &payload_size);
>  	build_vrr_infopacket_data(vrr, infopacket);
>  
> -	if (app_tf != NULL)
> -		build_vrr_infopacket_fs2_data(*app_tf, infopacket);
> +	build_vrr_infopacket_fs2_data(app_tf, infopacket);
>  
>  	build_vrr_infopacket_checksum(&payload_size, infopacket);
>  
> @@ -757,7 +756,7 @@ void mod_freesync_build_vrr_infopacket(struct mod_freesync *mod_freesync,
>  		const struct dc_stream_state *stream,
>  		const struct mod_vrr_params *vrr,
>  		enum vrr_packet_type packet_type,
> -		const enum color_transfer_func *app_tf,
> +		const enum color_transfer_func app_tf,
>  		struct dc_info_packet *infopacket)
>  {
>  	/* SPD info packet for FreeSync
> diff --git a/drivers/gpu/drm/amd/display/modules/inc/mod_freesync.h b/drivers/gpu/drm/amd/display/modules/inc/mod_freesync.h
> index 4222e403b151..645793b924cf 100644
> --- a/drivers/gpu/drm/amd/display/modules/inc/mod_freesync.h
> +++ b/drivers/gpu/drm/amd/display/modules/inc/mod_freesync.h
> @@ -145,7 +145,7 @@ void mod_freesync_build_vrr_infopacket(struct mod_freesync *mod_freesync,
>  		const struct dc_stream_state *stream,
>  		const struct mod_vrr_params *vrr,
>  		enum vrr_packet_type packet_type,
> -		const enum color_transfer_func *app_tf,
> +		const enum color_transfer_func app_tf,
>  		struct dc_info_packet *infopacket);
>  
>  void mod_freesync_build_vrr_params(struct mod_freesync *mod_freesync,
> -- 
> 2.20.0
> 

Just as an FYI, I sent the same fix when the warning first hit which was
recently accepted:

https://cgit.freedesktop.org/~agd5f/linux/commit/?id=672e78cab819ebe31e3b9b8abac367be8a110472

Just waiting for it to hit mainline.

Cheers,
Nathan
