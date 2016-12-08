From: =?UTF-8?Q?Kai_Wasserb=c3=a4ch?= <kai-1ZKVMVCtJ2dx9oSEVPI0kiST3g8Odh+X@public.gmane.org>
Subject: Re: [PATCH 05/12] drm/amd/display: Fix bunch of warnings in DC
Date: Thu, 8 Dec 2016 20:52:02 +0100
Message-ID: <89a8a4f0-0ea7-cb5a-f6cc-efdb5f8e195f@dev.carbon-project.org>
References: <20161208012624.8914-1-harry.wentland@amd.com>
 <20161208012624.8914-6-harry.wentland@amd.com>
 <9f4c678e-4598-3ac1-73c8-038183bc30e2@dev.carbon-project.org>
 <9a6bc7fb-225a-c693-5a6c-3420d64d51d9@amd.com>
 <e78be440-a0eb-4a96-7f71-317a6a5ce862@dev.carbon-project.org>
 <bf41a889-5d85-2646-76c7-801453175dab@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1129600679=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <bf41a889-5d85-2646-76c7-801453175dab-5C7GfCeVMHo@public.gmane.org>
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
To: Harry Wentland <harry.wentland-5C7GfCeVMHo@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, "Cheng, Tony" <Tony.Cheng-5C7GfCeVMHo@public.gmane.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--===============1129600679==
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="rUvaMUixVc60kHfrkt3xIg0ER5O3o6UIa"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--rUvaMUixVc60kHfrkt3xIg0ER5O3o6UIa
Content-Type: multipart/mixed; boundary="AuXScq7ATQOuhI0XHsst3NacUdi3CbKvW";
 protected-headers="v1"
From: =?UTF-8?Q?Kai_Wasserb=c3=a4ch?= <kai-1ZKVMVCtJ2dx9oSEVPI0kiST3g8Odh+X@public.gmane.org>
To: Harry Wentland <harry.wentland-5C7GfCeVMHo@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org,
 "Cheng, Tony" <Tony.Cheng-5C7GfCeVMHo@public.gmane.org>
Message-ID: <89a8a4f0-0ea7-cb5a-f6cc-efdb5f8e195f-1ZKVMVCtJ2dx9oSEVPI0kiST3g8Odh+X@public.gmane.org>
Subject: Re: [PATCH 05/12] drm/amd/display: Fix bunch of warnings in DC
References: <20161208012624.8914-1-harry.wentland-5C7GfCeVMHo@public.gmane.org>
 <20161208012624.8914-6-harry.wentland-5C7GfCeVMHo@public.gmane.org>
 <9f4c678e-4598-3ac1-73c8-038183bc30e2-1ZKVMVCtJ2dx9oSEVPI0kiST3g8Odh+X@public.gmane.org>
 <9a6bc7fb-225a-c693-5a6c-3420d64d51d9-5C7GfCeVMHo@public.gmane.org>
 <e78be440-a0eb-4a96-7f71-317a6a5ce862-1ZKVMVCtJ2dx9oSEVPI0kiST3g8Odh+X@public.gmane.org>
 <bf41a889-5d85-2646-76c7-801453175dab-5C7GfCeVMHo@public.gmane.org>
In-Reply-To: <bf41a889-5d85-2646-76c7-801453175dab-5C7GfCeVMHo@public.gmane.org>

--AuXScq7ATQOuhI0XHsst3NacUdi3CbKvW
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Harry Wentland wrote on 08.12.2016 19:58:
> On 2016-12-08 11:58 AM, Kai Wasserb=C3=A4ch wrote:
>> Harry Wentland wrote on 08.12.2016 17:36:
>>> On 2016-12-08 11:22 AM, Kai Wasserb=C3=A4ch wrote:
>>>> [Please CC me on all replies, I'm not subscribed to the list.]
>>>>
>>>> Harry Wentland wrote on 08.12.2016 02:26:
>>>>> Some of those are potential bugs
>>>> Are they related? If not: maybe split the changes up?
>>>>
>>>>> Change-Id: I53b2c663e18b57013e1b891fc2ecf1fb2d7d3a08
>>>>> Signed-off-by: Harry Wentland <harry.wentland-5C7GfCeVMHo@public.gmane.org>
>>>>> Reviewed-by: Tony Cheng <Tony.Cheng-5C7GfCeVMHo@public.gmane.org>
>>>> It'd be nice to see these reviews on list... (applies to all patches=
 here)
>>> These patches currently start out in our internal tree with a whole l=
ot of stuff
>>> that we can't open up, like new IP, so unfortunately can't be done in=
 a public
>>> forum. I pull the r-b from our internal review system for reference w=
hen I
>>> prepare the patches for public review.
>> Hm, not nice, but not my place to tell you to change this. That's Dave=
's and
>> Linus' job. ;-)
>>
>>>>> Acked-by: Harry Wentland <Harry.Wentland-5C7GfCeVMHo@public.gmane.org>
>>>>> ---
>>>>>    .../gpu/drm/amd/display/dc/calcs/bandwidth_calcs.c |  2 +-
>>>>>    drivers/gpu/drm/amd/display/dc/core/dc_resource.c  |  5 +--
>>>>>    .../gpu/drm/amd/display/dc/dce/dce_clock_source.c  |  5 ---
>>>>>    drivers/gpu/drm/amd/display/dc/dce/dce_clocks.c    | 43
>>>>> +---------------------
>>>>>    drivers/gpu/drm/amd/display/dc/dce/dce_transform.c |  2 -
>>>>>    .../drm/amd/display/dc/dce110/dce110_transform_v.c |  3 +-
>>>>>    6 files changed, 6 insertions(+), 54 deletions(-)
>>>>>
>>>>> diff --git a/drivers/gpu/drm/amd/display/dc/calcs/bandwidth_calcs.c=

>>>>> b/drivers/gpu/drm/amd/display/dc/calcs/bandwidth_calcs.c
>>>>> index 0b2bb3992f1a..3b0710ef4716 100644
>>>>> --- a/drivers/gpu/drm/amd/display/dc/calcs/bandwidth_calcs.c
>>>>> +++ b/drivers/gpu/drm/amd/display/dc/calcs/bandwidth_calcs.c
>>>>> @@ -1709,7 +1709,7 @@ static void calculate_bandwidth(
>>>>>                else {
>>>>>                    data->blackout_recovery_time =3D
>>>>> bw_max2(data->blackout_recovery_time, bw_add(bw_mul(bw_int_to_fixed=
(2),
>>>>> vbios->mcifwrmc_urgent_latency),
>>>>> data->mcifwr_burst_time[data->y_clk_level][data->sclk_level]));
>>>>>                    if (bw_ltn(data->adjusted_data_buffer_size[k],
>>>>> bw_mul(bw_div(bw_mul(data->display_bandwidth[k],
>>>>> data->useful_bytes_per_request[k]), data->bytes_per_request[k]),
>>>>> (bw_add(vbios->blackout_duration, bw_add(bw_mul(bw_int_to_fixed(2),=

>>>>> vbios->mcifwrmc_urgent_latency),
>>>>> data->mcifwr_burst_time[data->y_clk_level][data->sclk_level])))))) =
{
>>>>> -                    data->blackout_recovery_time =3D
>>>>> bw_max2(data->blackout_recovery_time,
>>>>> bw_div((bw_add(bw_mul(bw_div(bw_mul(data->display_bandwidth[k],
>>>>> data->useful_bytes_per_request[k]), data->bytes_per_request[k]),
>>>>> vbios->blackout_duration),
>>>>> bw_sub(bw_div(bw_mul(bw_mul(bw_mul((bw_add(bw_add(bw_mul(bw_int_to_=
fixed(2),
>>>>> vbios->mcifwrmc_urgent_latency), data->dmif_burst_time[i][j]),
>>>>> data->mcifwr_burst_time[data->y_clk_level][data->sclk_level])),
>>>>> data->dispclk), bw_int_to_fixed(data->bytes_per_pixel[k])),
>>>>> data->lines_interleaved_in_mem_access[k]), data->latency_hiding_lin=
es[k]),
>>>>> data->adjusted_data_buffer_size[k]))),
>>>>> (bw_sub(bw_div(bw_mul(bw_mul(data->dispclk,
>>>>> bw_int_to_fixed(data->bytes_per_pixel[k])),
>>>>> data->lines_interleaved_in_mem_access[k]), data->latency_hiding_lin=
es[k]),
>>>>> bw_div(bw_mul(data->display_bandwidth[k], data->useful_bytes_per_re=
quest[k]),
>>>>> data->bytes_per_request[k])))));
>>>>> +                    data->blackout_recovery_time =3D
>>>>> bw_max2(data->blackout_recovery_time,
>>>>> bw_div((bw_add(bw_mul(bw_div(bw_mul(data->display_bandwidth[k],
>>>>> data->useful_bytes_per_request[k]), data->bytes_per_request[k]),
>>>>> vbios->blackout_duration),
>>>>> bw_sub(bw_div(bw_mul(bw_mul(bw_mul((bw_add(bw_add(bw_mul(bw_int_to_=
fixed(2),
>>>>> vbios->mcifwrmc_urgent_latency),
>>>>> data->dmif_burst_time[data->y_clk_level][data->sclk_level]),
>>>>> data->mcifwr_burst_time[data->y_clk_level][data->sclk_level])),
>>>>> data->dispclk), bw_int_to_fixed(data->bytes_per_pixel[k])),
>>>>> data->lines_interleaved_in_mem_access[k]), data->latency_hiding_lin=
es[k]),
>>>>> data->adjusted_data_buffer_size[k]))),
>>>>> (bw_sub(bw_div(bw_mul(bw_mul(data->dispclk,
>>>>> bw_int_to_fixed(data->bytes_per_pixel[k])),
>>>>> data->lines_interleaved_in_mem_access[k]), data->latency_hiding_lin=
es[k]),
>>>>> bw_div(bw_mul(data->display_bandwidth[k], data->useful_bytes_per_re=
quest[k]),
>>>>> data->bytes_per_request[k])))));
>>>> Uhg, can this be wrapped/split up somehow? Seeing the changes is nig=
h
>>>> impossible
>>>> and I suspect it might even be impossible for you to check internall=
y.
>>> I believe this comes straight from some complicated code HW gives us =
and we use
>>> directly. I'll see if we can somehow make this more readable or at le=
ast add a
>>> comment, as you mention below.
>> That would be really appreciated. I mean, I'm in no way able to review=

>> DAL/Display thoroughly (huge code base I'm not familiar with and where=
 I might
>> easily miss interactions), but this is just not reviewable/verifiable =
at all for
>> any person outside your inner circle.
> I followed up with Tony, who's been working with HW guys to get them to=
 share
> this code with us. Unfortunately there isn't much we can do in the way =
of
> changing this code.

That's rather unfortunate, that not even reformatting into an easier to r=
ead
format is possible (though I do not really understand why, beyond "it tak=
es
work"); maybe the comment showing the formula in an easier to read form c=
an be
done then?

Cheers,
Kai

P.S.: Did you see my comments on patch 2? That contained the null pointer=
 deref
(if I didn't misread something).


--AuXScq7ATQOuhI0XHsst3NacUdi3CbKvW--

--rUvaMUixVc60kHfrkt3xIg0ER5O3o6UIa
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAEBCgAdFiEEBgCWzvPI5zPlthWHownXbOHeWdIFAlhJueIACgkQownXbOHe
WdLOPgv9E0P4D5HbHzBxWFsvPRPwCEdOvSmDnA9Ivk4M86yKbVJ069qZgeItRmjo
UDlfmNooWd1bHnJoTyPYtAoIugcSeMBHMbyvNb1qx+X+rV17ykSYWyAPr5ltnWKm
eRFU04+CcG/I6E5stPHWuluxaOcu5+nWqlE0QC6er6/wttyrgABd92nE6qjtxFdL
UCfjqWDJLrtvIAYlyHOzd+AVCKGUxeM6tS6eBnMy8XgKz2xO5YehaQ6j8ydk2cHC
2k0k2nL5XLgEJiwhCXM65Tjdsem3hQW1eGJhzCk69sRqTgUeR4cs3VWJB1BuAlR/
jz98CtWXnWyV2aXTmjGX7j7yisxB5i74ruJyg/hScBH1b+djkswlFCQWMDqGm/Ab
hAFsQc11CoaaI6m03heiunxZ+gfC2JqAJnhzJJsuREPaneiQ9DcoWaOHfhZ/ohuq
nU5SusAuQVaenQjZB7k9YJcgWTOPzDgiy3S1twiTEwDohICU7B/7MNHXtsb2nHWB
eqyNY90y
=q2qM
-----END PGP SIGNATURE-----

--rUvaMUixVc60kHfrkt3xIg0ER5O3o6UIa--

--===============1129600679==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1129600679==--
