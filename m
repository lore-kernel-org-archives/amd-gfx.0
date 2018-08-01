From: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Subject: Re: [PATCH v2] drm/amd/display: Report non-DP display as disconnected
 without EDID
Date: Wed, 1 Aug 2018 15:55:41 -0400
Message-ID: <c4ba3810-d90a-beba-7e89-239184bfbd17@amd.com>
References: <20180801195106.10971-1-harry.wentland@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20180801195106.10971-1-harry.wentland@amd.com>
Content-Language: en-US
Sender: stable-owner@vger.kernel.org
To: Harry Wentland <harry.wentland@amd.com>, amd-gfx@lists.freedesktop.org
Cc: stable@vger.kernel.org
List-Id: amd-gfx.lists.freedesktop.org

On 08/01/2018 03:51 PM, Harry Wentland wrote:
> [Why]
> Some boards seem to have a problem where HPD is high on HDMI even though
> no display is connected. We don't want to report these as connected. DP
> spec still requires us to report DP displays as connected when HPD is
> high but we can't read the EDID in order to go to fail-safe mode.
> 
> [How]
> If connector_signal is not DP abort detection if we can't retrieve the
> EDID.
> 
> Bugzilla: https://bugs.freedesktop.org/107390
> Bugzilla: https://bugs.freedesktop.org/106846
> Cc: stable@vger.kernel.org
> Signed-off-by: Harry Wentland <harry.wentland@amd.com>
> Acked-by: Alex Deucher <alexander.deucher@amd.com>
> 
> v2: Add Bugzilla and stable
> ---
>   drivers/gpu/drm/amd/display/dc/core/dc_link.c | 11 +++++++++++
>   1 file changed, 11 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
> index b180197a41e2..84f0fd15be4c 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
> @@ -744,6 +744,17 @@ bool dc_link_detect(struct dc_link *link, enum dc_detect_reason reason)
>   			break;
>   		case EDID_NO_RESPONSE:
>   			DC_LOG_ERROR("No EDID read.\n");
> +
> +			/*
> +			 * Abort detection for non-DP connectors if we have
> +			 * no EDID
> +			 *
> +			 * DP needs to report as connected if HDP is high
> +			 * even if we have no EDID in order to go to
> +			 * fail-safe mode
> +			 */
> +			if (!dc_is_dp_signal(link->connector_signal))
> +				return false;
>   		default:
>   			break;
>   		}
> 
Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
