Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1AC3C9830D
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Sep 2026 09:55:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 385F410E272;
	Fri, 25 Sep 2026 09:55:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="b0/dk8RZ";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C2A9310E272
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Sep 2026 09:55:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:From:Cc:To:Subject:
 MIME-Version:Date:Message-ID:From:Reply-To;
 bh=aDnXyV5jsiW+S1mwGyTnCiVEvipY2nLJlRPvqHr2POU=; b=b0/dk8RZA7q//JwlY3uEmzLrfm
 apK/zlTJIz33JR1Zi4jlwLQ13H89vI8X9yO7hKjeOjTnKLmLBK6gUgFt05ABI7BKXXXeykspXD5j2
 sLzbfdwk0ekjGaMXwq7WSN/CTKtKJ2hD1lh3/u2DxHL2UQlnbrjuEVnxgEhzwf2NlrzogQM5UlKLi
 RLrgELVm23eYOr0Ez+xmMNiGnWLFSw5Y7M9ZHKBHG6+OTWpOJDSkNzrvxBqiTzsTLg34XuZH2PCsl
 8Vdn9E7Pmw+X+LBdDQbe0NqZUdYaqJB6+7PXoK40aW0F7mOUtZDY/SkEHNTFq+v2MmE+hCWEKFfKH
 eEigby7Q==;
Received: from [81.79.79.1] (helo=[192.168.0.116])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1xA2e6-0075RN-ER; Fri, 25 Sep 2026 11:55:10 +0200
Message-ID: <1accce61-be0a-4fbe-90e0-9503853d80d5@igalia.com>
Date: Fri, 25 Sep 2026 10:55:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/8] drm/amd/display: declare
 amdgpu_dm_atomic_state_template as an event class
To: Melissa Wen <mwen@igalia.com>, airlied@gmail.com,
 alexander.deucher@amd.com, aurabindo.pillai@amd.com,
 christian.koenig@amd.com, David.Francis@amd.com, harry.wentland@amd.com,
 simona@ffwll.ch, siqueira@igalia.com, sunpeng.li@amd.com
Cc: amd-gfx@lists.freedesktop.org, kernel-dev@igalia.com,
 linux-kernel@vger.kernel.org
References: <20260924211410.867686-1-mwen@igalia.com>
 <20260924211410.867686-5-mwen@igalia.com>
Content-Language: en-GB
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
In-Reply-To: <20260924211410.867686-5-mwen@igalia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 24/09/2026 22:10, Melissa Wen wrote:
> Don't create an amdgpu_dm_atomic_state_template event since this is just
> a template. Declare the template as an event class that will be used by
> actual event tracers.
> 
> Fixes: e8a982355f96 ("drm/amd/display: Add tracepoint for amdgpu_dm")
> Signed-off-by: Melissa Wen <mwen@igalia.com>
> ---
>   .../amd/display/amdgpu_dm/amdgpu_dm_trace.h   | 56 +++++++++----------
>   1 file changed, 26 insertions(+), 30 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_trace.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_trace.h
> index f5c2f589f691..c59ba41a9721 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_trace.h
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_trace.h
> @@ -314,36 +314,32 @@ DEFINE_EVENT(amdgpu_dm_plane_state_template, amdgpu_dm_atomic_update_cursor,
>   	     TP_PROTO(const struct drm_plane_state *state),
>   	     TP_ARGS(state));
>   
> -TRACE_EVENT(amdgpu_dm_atomic_state_template,
> -	    TP_PROTO(const struct drm_atomic_commit *state),
> -	    TP_ARGS(state),
> -
> -	    TP_STRUCT__entry(
> -			     __field(const struct drm_atomic_commit *, state)
> -			     __field(bool, allow_modeset)
> -			     __field(bool, legacy_cursor_update)
> -			     __field(bool, async_update)
> -			     __field(bool, duplicated)
> -			     __field(int, num_connector)
> -			     __field(int, num_private_objs)
> -	    ),
> -
> -	    TP_fast_assign(
> -			   __entry->state = state;
> -			   __entry->allow_modeset = state->allow_modeset;
> -			   __entry->legacy_cursor_update = state->legacy_cursor_update;
> -			   __entry->async_update = state->async_update;
> -			   __entry->duplicated = state->duplicated;
> -			   __entry->num_connector = state->num_connector;
> -			   __entry->num_private_objs = state->num_private_objs;
> -	    ),
> -
> -	    TP_printk("state=%p allow_modeset=%d legacy_cursor_update=%d "
> -		      "async_update=%d duplicated=%d num_connector=%d "
> -		      "num_private_objs=%d",
> -		      __entry->state, __entry->allow_modeset, __entry->legacy_cursor_update,
> -		      __entry->async_update, __entry->duplicated, __entry->num_connector,
> -		      __entry->num_private_objs)
> +DECLARE_EVENT_CLASS(amdgpu_dm_atomic_state_template,
> +		    TP_PROTO(const struct drm_atomic_commit *state),
> +		    TP_ARGS(state),
> +		    TP_STRUCT__entry(__field(const struct drm_atomic_commit *, state)
> +				     __field(bool, allow_modeset)
> +				     __field(bool, legacy_cursor_update)
> +				     __field(bool, async_update)
> +				     __field(bool, duplicated)
> +				     __field(int, num_connector)
> +				     __field(int, num_private_objs)
> +		    ),
> +		    TP_fast_assign(__entry->state = state;
> +				   __entry->allow_modeset = state->allow_modeset;
> +				   __entry->legacy_cursor_update = state->legacy_cursor_update;
> +				   __entry->async_update = state->async_update;
> +				   __entry->duplicated = state->duplicated;
> +				   __entry->num_connector = state->num_connector;
> +				   __entry->num_private_objs = state->num_private_objs;
> +		    ),
> +		    TP_printk("state=%p allow_modeset=%d legacy_cursor_update=%d "
> +			      "async_update=%d duplicated=%d num_connector=%d "
> +			      "num_private_objs=%d",
> +			      __entry->state, __entry->allow_modeset,
> +			      __entry->legacy_cursor_update, __entry->async_update,
> +			      __entry->duplicated, __entry->num_connector,
> +			      __entry->num_private_objs)
>   );
>   
>   DEFINE_EVENT(amdgpu_dm_atomic_state_template, amdgpu_dm_atomic_commit_tail_begin,

Reviewed-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>

Regards,

Tvrtko

P.S. A side question - are %p useful in these tracepoints? I imagine one 
has to know the object lifetimes really well, or make sure state init 
and free are also traced to make sense of what is what.

