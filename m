From: Julia Lawall <julia.lawall@lip6.fr>
Subject: Re: [Outreachy kernel] [PATCH v2] drm/amd/powerplay: Remove unnecessary
 cast on void pointer
Date: Fri, 13 Oct 2017 19:40:05 +0200 (CEST)
Message-ID: <alpine.DEB.2.20.1710131938400.6944@hadrien>
References: <20171013173341.12367-1-harshasharmaiitr@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171013173341.12367-1-harshasharmaiitr@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Harsha Sharma <harshasharmaiitr@gmail.com>
Cc: alexander.deucher@amd.com, christian.koenig@amd.com, airlied@linux.ie, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, outreachy-kernel@googlegroups.com
List-Id: amd-gfx.lists.freedesktop.org

> @@ -3400,7 +3400,7 @@ static int smu7_read_sensor(struct pp_hwmgr *hwmgr, int idx,
>  static int smu7_find_dpm_states_clocks_in_dpm_table(struct pp_hwmgr *hwmgr, const void *input)
>  {
>  	const struct phm_set_power_state_input *states =
> -			(const struct phm_set_power_state_input *)input;
> +			input;

Actually, there are some more cleanup opportunities heer and in some other
cases.  There is no need for the newline before input.

julia
