From: Dave Airlie <airlied@gmail.com>
Subject: Re: [PATCH v2 06/27] drm/dp_mst: Combine redundant cases in drm_dp_encode_sideband_req()
Date: Wed, 4 Sep 2019 07:35:59 +1000
Message-ID: <CAPM=9tx1vQMEsw4VjDVCbDYFUiaeHNCfP09aiSxnPnucQuB1JQ@mail.gmail.com>
References: <20190903204645.25487-1-lyude@redhat.com> <20190903204645.25487-7-lyude@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190903204645.25487-7-lyude@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Lyude Paul <lyude@redhat.com>
Cc: dri-devel <dri-devel@lists.freedesktop.org>, nouveau <nouveau@lists.freedesktop.org>, amd-gfx mailing list <amd-gfx@lists.freedesktop.org>, Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel.vetter@ffwll.ch>, Imre Deak <imre.deak@intel.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, LKML <linux-kernel@vger.kernel.org>, Maxime Ripard <mripard@kernel.org>, Juston Li <juston.li@intel.com>, Daniel Vetter <daniel@ffwll.ch>, Harry Wentland <hwentlan@amd.com>, =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>
List-Id: amd-gfx.lists.freedesktop.org

On Wed, 4 Sep 2019 at 06:48, Lyude Paul <lyude@redhat.com> wrote:
>
> Noticed this while working on adding a drm_dp_decode_sideband_req().
> DP_POWER_DOWN_PHY/DP_POWER_UP_PHY both use the same struct, so we can
> just combine their cases.

both use the same struct as enum path resources?

Since otherwise the patch doesn't make sense.

With that fixed:
Reviewed-by: Dave Airlie <airlied@redhat.com>
