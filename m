From: Dave Airlie <airlied@gmail.com>
Subject: Re: [PATCH v2 15/27] drm/dp_mst: Cleanup drm_dp_send_link_address() a bit
Date: Wed, 4 Sep 2019 07:42:16 +1000
Message-ID: <CAPM=9ty-264nFotVRy7VwMw_BQPo-=7su7y3J2MjC9Sdkxcu+A@mail.gmail.com>
References: <20190903204645.25487-1-lyude@redhat.com> <20190903204645.25487-16-lyude@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190903204645.25487-16-lyude@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Lyude Paul <lyude@redhat.com>
Cc: dri-devel <dri-devel@lists.freedesktop.org>, nouveau <nouveau@lists.freedesktop.org>, amd-gfx mailing list <amd-gfx@lists.freedesktop.org>, Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel.vetter@ffwll.ch>, Imre Deak <imre.deak@intel.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, LKML <linux-kernel@vger.kernel.org>, Maxime Ripard <mripard@kernel.org>, Juston Li <juston.li@intel.com>, Daniel Vetter <daniel@ffwll.ch>, Harry Wentland <hwentlan@amd.com>, =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>
List-Id: amd-gfx.lists.freedesktop.org

On Wed, 4 Sep 2019 at 06:48, Lyude Paul <lyude@redhat.com> wrote:
>
> Declare local pointer to the drm_dp_link_address_ack_reply struct
> instead of constantly dereferencing it through the union in
> txmsg->reply. Then, invert the order of conditionals so we don't have to
> do the bulk of the work inside them, and can wrap lines even less. Then
> finally, rearrange variable declarations a bit.
>
> Cc: Juston Li <juston.li@intel.com>
> Cc: Imre Deak <imre.deak@intel.com>
> Cc: Ville Syrj=C3=A4l=C3=A4 <ville.syrjala@linux.intel.com>
> Cc: Harry Wentland <hwentlan@amd.com>
> Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
> Signed-off-by: Lyude Paul <lyude@redhat.com>

Reviewed-by: Dave Airlie <airlied@redhat.com>
