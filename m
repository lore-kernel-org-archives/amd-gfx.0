From: =?UTF-8?Q?Kai_Wasserb=c3=a4ch?= <kai-1ZKVMVCtJ2dx9oSEVPI0kiST3g8Odh+X@public.gmane.org>
Subject: Re: [PATCH 05/12] drm/amd/display: Fix bunch of warnings in DC
Date: Thu, 8 Dec 2016 17:58:44 +0100
Message-ID: <e78be440-a0eb-4a96-7f71-317a6a5ce862@dev.carbon-project.org>
References: <20161208012624.8914-1-harry.wentland@amd.com>
 <20161208012624.8914-6-harry.wentland@amd.com>
 <9f4c678e-4598-3ac1-73c8-038183bc30e2@dev.carbon-project.org>
 <9a6bc7fb-225a-c693-5a6c-3420d64d51d9@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0878376801=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <9a6bc7fb-225a-c693-5a6c-3420d64d51d9-5C7GfCeVMHo@public.gmane.org>
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
List-Help: <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=subscribe>
Errors-To: amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Sender: "amd-gfx" <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
To: Harry Wentland <harry.wentland-5C7GfCeVMHo@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--===============0878376801==
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="5wrSGQXSF9PrRxlOuWG3MsvPW4nAqIit4"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--5wrSGQXSF9PrRxlOuWG3MsvPW4nAqIit4
Content-Type: multipart/mixed; boundary="J6R4R9jC054IodHAuRj3dbfMsPSrVXgd0";
 protected-headers="v1"
From: =?UTF-8?Q?Kai_Wasserb=c3=a4ch?= <kai-1ZKVMVCtJ2dx9oSEVPI0kiST3g8Odh+X@public.gmane.org>
To: Harry Wentland <harry.wentland-5C7GfCeVMHo@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Message-ID: <e78be440-a0eb-4a96-7f71-317a6a5ce862-1ZKVMVCtJ2dx9oSEVPI0kiST3g8Odh+X@public.gmane.org>
Subject: Re: [PATCH 05/12] drm/amd/display: Fix bunch of warnings in DC
References: <20161208012624.8914-1-harry.wentland-5C7GfCeVMHo@public.gmane.org>
 <20161208012624.8914-6-harry.wentland-5C7GfCeVMHo@public.gmane.org>
 <9f4c678e-4598-3ac1-73c8-038183bc30e2-1ZKVMVCtJ2dx9oSEVPI0kiST3g8Odh+X@public.gmane.org>
 <9a6bc7fb-225a-c693-5a6c-3420d64d51d9-5C7GfCeVMHo@public.gmane.org>
In-Reply-To: <9a6bc7fb-225a-c693-5a6c-3420d64d51d9-5C7GfCeVMHo@public.gmane.org>

--J6R4R9jC054IodHAuRj3dbfMsPSrVXgd0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Harry Wentland wrote on 08.12.2016 17:36:
>=20
>=20
> On 2016-12-08 11:22 AM, Kai Wasserb=C3=A4ch wrote:
>> [Please CC me on all replies, I'm not subscribed to the list.]
>>
>> Harry Wentland wrote on 08.12.2016 02:26:
>>> Some of those are potential bugs
>> Are they related? If not: maybe split the changes up?
>>
>>> Change-Id: I53b2c663e18b57013e1b891fc2ecf1fb2d7d3a08
>>> Signed-off-by: Harry Wentland <harry.wentland-5C7GfCeVMHo@public.gmane.org>
>>> Reviewed-by: Tony Cheng <Tony.Cheng-5C7GfCeVMHo@public.gmane.org>
>> It'd be nice to see these reviews on list... (applies to all patches h=
ere)
> These patches currently start out in our internal tree with a whole lot=
 of stuff
> that we can't open up, like new IP, so unfortunately can't be done in a=
 public
> forum. I pull the r-b from our internal review system for reference whe=
n I
> prepare the patches for public review.

Hm, not nice, but not my place to tell you to change this. That's Dave's =
and
Linus' job. ;-)

>>> Acked-by: Harry Wentland <Harry.Wentland-5C7GfCeVMHo@public.gmane.org>
>>> ---
>>>   .../gpu/drm/amd/display/dc/calcs/bandwidth_calcs.c |  2 +-
>>>   drivers/gpu/drm/amd/display/dc/core/dc_resource.c  |  5 +--
>>>   .../gpu/drm/amd/display/dc/dce/dce_clock_source.c  |  5 ---
>>>   drivers/gpu/drm/amd/display/dc/dce/dce_clocks.c    | 43 +----------=
-----------
>>>   drivers/gpu/drm/amd/display/dc/dce/dce_transform.c |  2 -
>>>   .../drm/amd/display/dc/dce110/dce110_transform_v.c |  3 +-
>>>   6 files changed, 6 insertions(+), 54 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/display/dc/calcs/bandwidth_calcs.c
>>> b/drivers/gpu/drm/amd/display/dc/calcs/bandwidth_calcs.c
>>> index 0b2bb3992f1a..3b0710ef4716 100644
>>> --- a/drivers/gpu/drm/amd/display/dc/calcs/bandwidth_calcs.c
>>> +++ b/drivers/gpu/drm/amd/display/dc/calcs/bandwidth_calcs.c
>>> @@ -1709,7 +1709,7 @@ static void calculate_bandwidth(
>>>               else {
>>>                   data->blackout_recovery_time =3D
>>> bw_max2(data->blackout_recovery_time, bw_add(bw_mul(bw_int_to_fixed(2=
),
>>> vbios->mcifwrmc_urgent_latency),
>>> data->mcifwr_burst_time[data->y_clk_level][data->sclk_level]));
>>>                   if (bw_ltn(data->adjusted_data_buffer_size[k],
>>> bw_mul(bw_div(bw_mul(data->display_bandwidth[k],
>>> data->useful_bytes_per_request[k]), data->bytes_per_request[k]),
>>> (bw_add(vbios->blackout_duration, bw_add(bw_mul(bw_int_to_fixed(2),
>>> vbios->mcifwrmc_urgent_latency),
>>> data->mcifwr_burst_time[data->y_clk_level][data->sclk_level])))))) {
>>> -                    data->blackout_recovery_time =3D
>>> bw_max2(data->blackout_recovery_time,
>>> bw_div((bw_add(bw_mul(bw_div(bw_mul(data->display_bandwidth[k],
>>> data->useful_bytes_per_request[k]), data->bytes_per_request[k]),
>>> vbios->blackout_duration),
>>> bw_sub(bw_div(bw_mul(bw_mul(bw_mul((bw_add(bw_add(bw_mul(bw_int_to_fi=
xed(2),
>>> vbios->mcifwrmc_urgent_latency), data->dmif_burst_time[i][j]),
>>> data->mcifwr_burst_time[data->y_clk_level][data->sclk_level])),
>>> data->dispclk), bw_int_to_fixed(data->bytes_per_pixel[k])),
>>> data->lines_interleaved_in_mem_access[k]), data->latency_hiding_lines=
[k]),
>>> data->adjusted_data_buffer_size[k]))),
>>> (bw_sub(bw_div(bw_mul(bw_mul(data->dispclk,
>>> bw_int_to_fixed(data->bytes_per_pixel[k])),
>>> data->lines_interleaved_in_mem_access[k]), data->latency_hiding_lines=
[k]),
>>> bw_div(bw_mul(data->display_bandwidth[k], data->useful_bytes_per_requ=
est[k]),
>>> data->bytes_per_request[k])))));
>>> +                    data->blackout_recovery_time =3D
>>> bw_max2(data->blackout_recovery_time,
>>> bw_div((bw_add(bw_mul(bw_div(bw_mul(data->display_bandwidth[k],
>>> data->useful_bytes_per_request[k]), data->bytes_per_request[k]),
>>> vbios->blackout_duration),
>>> bw_sub(bw_div(bw_mul(bw_mul(bw_mul((bw_add(bw_add(bw_mul(bw_int_to_fi=
xed(2),
>>> vbios->mcifwrmc_urgent_latency),
>>> data->dmif_burst_time[data->y_clk_level][data->sclk_level]),
>>> data->mcifwr_burst_time[data->y_clk_level][data->sclk_level])),
>>> data->dispclk), bw_int_to_fixed(data->bytes_per_pixel[k])),
>>> data->lines_interleaved_in_mem_access[k]), data->latency_hiding_lines=
[k]),
>>> data->adjusted_data_buffer_size[k]))),
>>> (bw_sub(bw_div(bw_mul(bw_mul(data->dispclk,
>>> bw_int_to_fixed(data->bytes_per_pixel[k])),
>>> data->lines_interleaved_in_mem_access[k]), data->latency_hiding_lines=
[k]),
>>> bw_div(bw_mul(data->display_bandwidth[k], data->useful_bytes_per_requ=
est[k]),
>>> data->bytes_per_request[k])))));
>> Uhg, can this be wrapped/split up somehow? Seeing the changes is nigh =
impossible
>> and I suspect it might even be impossible for you to check internally.=

> I believe this comes straight from some complicated code HW gives us an=
d we use
> directly. I'll see if we can somehow make this more readable or at leas=
t add a
> comment, as you mention below.

That would be really appreciated. I mean, I'm in no way able to review
DAL/Display thoroughly (huge code base I'm not familiar with and where I =
might
easily miss interactions), but this is just not reviewable/verifiable at =
all for
any person outside your inner circle.

Thanks,
Kai

>> A nice comment above giving the formula and maybe some reasoning would=
 also be
>> nice, that way somebody from the outside has at least a chance to chec=
k if the
>> code does what it's supposed to do.
>>
>> Cheers,
>> Kai
>>
>>
>>>                   }
>>>               }
>>>           }
>>> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
>>> b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
>>> index bd53d27e5414..f552b0468186 100644
>>> --- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
>>> +++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
>>> @@ -1834,11 +1834,10 @@ void resource_build_info_frame(struct pipe_ct=
x
>>> *pipe_ctx)
>>>           set_vendor_info_packet(
>>>               pipe_ctx->stream, &info_frame.vendor_info_packet);
>>>           set_spd_info_packet(pipe_ctx->stream, &info_frame.spd_packe=
t);
>>> -    }
>>> -
>>> -    else if (dc_is_dp_signal(signal))
>>> +    } else if (dc_is_dp_signal(signal)) {
>>>           set_vsc_info_packet(pipe_ctx->stream, &info_frame.vsc_packe=
t);
>>>           set_spd_info_packet(pipe_ctx->stream, &info_frame.spd_packe=
t);
>>> +    }
>>>         translate_info_frame(&info_frame,
>>>               &pipe_ctx->encoder_info_frame);
>>> diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c
>>> b/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c
>>> index 80ac5d9efa71..3d1c32122d69 100644
>>> --- a/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c
>>> +++ b/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c
>>> @@ -465,7 +465,6 @@ static uint32_t dce110_get_pix_clk_dividers_helpe=
r (
>>>           struct pll_settings *pll_settings,
>>>           struct pixel_clk_params *pix_clk_params)
>>>   {
>>> -    uint32_t addr =3D 0;
>>>       uint32_t value =3D 0;
>>>       uint32_t field =3D 0;
>>>       uint32_t pll_calc_error =3D MAX_PLL_CALC_ERROR;
>>> @@ -731,8 +730,6 @@ static void dce110_program_pixel_clk_resync(
>>>           enum signal_type signal_type,
>>>           enum dc_color_depth colordepth)
>>>   {
>>> -    uint32_t value =3D 0;
>>> -
>>>       REG_UPDATE(RESYNC_CNTL,
>>>               DCCG_DEEP_COLOR_CNTL1, 0);
>>>       /*
>>> @@ -772,8 +769,6 @@ static void dce112_program_pixel_clk_resync(
>>>           enum dc_color_depth colordepth,
>>>           bool enable_ycbcr420)
>>>   {
>>> -    uint32_t value =3D 0;
>>> -
>>>       REG_UPDATE(PIXCLK_RESYNC_CNTL,
>>>               PHYPLLA_DCCG_DEEP_COLOR_CNTL, 0);
>>>       /*
>>> diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_clocks.c
>>> b/drivers/gpu/drm/amd/display/dc/dce/dce_clocks.c
>>> index c2bd8dc7b4ad..262612061c68 100644
>>> --- a/drivers/gpu/drm/amd/display/dc/dce/dce_clocks.c
>>> +++ b/drivers/gpu/drm/amd/display/dc/dce/dce_clocks.c
>>> @@ -148,29 +148,6 @@ static int dce_divider_range_calc_divider(
>>>     }
>>>   -static int dce_divider_range_calc_did(
>>> -    struct dce_divider_range *div_range,
>>> -    int div)
>>> -{
>>> -    int did;
>>> -    /* Check before dividing.*/
>>> -    if (div_range->div_range_step =3D=3D 0) {
>>> -        div_range->div_range_step =3D 1;
>>> -        /*div_range_step cannot be zero*/
>>> -        BREAK_TO_DEBUGGER();
>>> -    }
>>> -    /* Is this divider within our range?*/
>>> -    if ((div < div_range->div_range_start)
>>> -        || (div >=3D div_range->div_range_end))
>>> -        return INVALID_DID;
>>> -/* did =3D (divider - range_start + (range_step-1)) / range_step) + =
did_min*/
>>> -    did =3D div - div_range->div_range_start;
>>> -    did +=3D div_range->div_range_step - 1;
>>> -    did /=3D div_range->div_range_step;
>>> -    did +=3D div_range->did_min;
>>> -    return did;
>>> -}
>>> -
>>>   static int dce_divider_range_get_divider(
>>>       struct dce_divider_range *div_range,
>>>       int ranges_num,
>>> @@ -189,25 +166,7 @@ static int dce_divider_range_get_divider(
>>>       return div;
>>>   }
>>>   -static int dce_divider_range_get_did(
>>> -    struct dce_divider_range *div_range,
>>> -    int ranges_num,
>>> -    int divider)
>>> -{
>>> -    int did =3D INVALID_DID;
>>> -    int i;
>>> -
>>> -    for (i =3D 0; i < ranges_num; i++) {
>>> -        /*  CalcDid returns InvalidDid if a divider ID isn't found*/=

>>> -        did =3D dce_divider_range_calc_did(&div_range[i], divider);
>>> -        /* Found a valid return did*/
>>> -        if (did !=3D INVALID_DID)
>>> -            break;
>>> -    }
>>> -    return did;
>>> -}
>>> -
>>> -static uint32_t dce_clocks_get_dp_ref_freq(struct display_clock *clk=
)
>>> +static int dce_clocks_get_dp_ref_freq(struct display_clock *clk)
>>>   {
>>>       struct dce_disp_clk *clk_dce =3D TO_DCE_CLOCKS(clk);
>>>       int dprefclk_wdivider;
>>> diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_transform.c
>>> b/drivers/gpu/drm/amd/display/dc/dce/dce_transform.c
>>> index f47b6617f662..bbf4d97cb980 100644
>>> --- a/drivers/gpu/drm/amd/display/dc/dce/dce_transform.c
>>> +++ b/drivers/gpu/drm/amd/display/dc/dce/dce_transform.c
>>> @@ -83,8 +83,6 @@ static bool setup_scaling_configuration(
>>>       struct dce_transform *xfm_dce,
>>>       const struct scaler_data *data)
>>>   {
>>> -    struct dc_context *ctx =3D xfm_dce->base.ctx;
>>> -
>>>       if (data->taps.h_taps + data->taps.v_taps <=3D 2) {
>>>           /* Set bypass */
>>>           REG_UPDATE_2(SCL_MODE, SCL_MODE, 0, SCL_PSCL_EN, 0);
>>> diff --git a/drivers/gpu/drm/amd/display/dc/dce110/dce110_transform_v=
=2Ec
>>> b/drivers/gpu/drm/amd/display/dc/dce110/dce110_transform_v.c
>>> index 7d8cf7a58f46..feb5f3c29804 100644
>>> --- a/drivers/gpu/drm/amd/display/dc/dce110/dce110_transform_v.c
>>> +++ b/drivers/gpu/drm/amd/display/dc/dce110/dce110_transform_v.c
>>> @@ -621,7 +621,8 @@ static void dce110_xfmv_set_pixel_storage_depth(
>>>       const struct bit_depth_reduction_params *bit_depth_params)
>>>   {
>>>       struct dce_transform *xfm_dce =3D TO_DCE_TRANSFORM(xfm);
>>> -    int pixel_depth, expan_mode;
>>> +    int pixel_depth =3D 0;
>>> +    int expan_mode =3D 0;
>>>       uint32_t reg_data =3D 0;
>>>         switch (depth) {
>>>
>=20
> _______________________________________________
> amd-gfx mailing list
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--=20

Kai Wasserb=C3=A4ch (Kai Wasserbaech)

E-Mail: kai-1ZKVMVCtJ2dx9oSEVPI0kiST3g8Odh+X@public.gmane.org


--J6R4R9jC054IodHAuRj3dbfMsPSrVXgd0--

--5wrSGQXSF9PrRxlOuWG3MsvPW4nAqIit4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGyBAEBCgAdFiEEBgCWzvPI5zPlthWHownXbOHeWdIFAlhJkUQACgkQownXbOHe
WdK+lAv4lkefAs3/m4jsikoCKAjAk6nNw5bGkjLVlTdbtDEU6qgIjB33GWk6aPCf
iYaxjF5kXOMOlGa3tk2quKL7yRjsbAw5ewt9uhC3xbxMsxccNhMH9Grp1KYydFXO
usBSr8igfYt8mroiterQRnn8pEynlktWy5ZP8dIeqtvoz/9KsEMMLdPswiIRwU5M
dEZetUM2n1uxo8TH2osxOAamnuQwmBGC93OnO6ATg3LBVEqZcQPzImyekn2ZNZBb
StADlbxZnCh+YZfM0rP3Z3UgvylzYsW41qDd5AP42BZsyFLtc2VQyJTqlvGkrWSz
oIbfD+MJnhQeYbOdOIEgjGfnOEud8ZiNWqvO3EXmBeYJtBvQ6UtiU0jeMrDVwGBR
GVCZorkr0mjl58vzsyEp/gM/mSnNQd9M6E/kzL8uQKfn6ObytssK+suvhtgI7hzR
iQoz7fz1mOQYl13Uih+r0f+w7bJ37mgp9G3Ip5cilbDlQoBefVczj7YnVGBk8wLS
5WZ9EBI=
=HVa8
-----END PGP SIGNATURE-----

--5wrSGQXSF9PrRxlOuWG3MsvPW4nAqIit4--

--===============0878376801==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0878376801==--
