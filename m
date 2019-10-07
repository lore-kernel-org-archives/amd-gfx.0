From: Jani Nikula <jani.nikula@linux.intel.com>
Subject: Re: [PATCH TRIVIAL v2] gpu: Fix Kconfig indentation
Date: Mon, 07 Oct 2019 14:39:33 +0300
Message-ID: <87sgo4hjii.fsf@intel.com>
References: <20191004144549.3567-1-krzk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191004144549.3567-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, Jiri Kosina <trivial@kernel.org>, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org, intel-gfx@lists.freedesktop.org, lima@lists.freedesktop.org, nouveau@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org
Cc: Krzysztof Kozlowski <krzk@kernel.org>
List-Id: amd-gfx.lists.freedesktop.org

On Fri, 04 Oct 2019, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>  drivers/gpu/drm/i915/Kconfig             |  12 +-
>  drivers/gpu/drm/i915/Kconfig.debug       | 144 +++++++++++------------

Please split these out to a separate patch. Can't speak for others, but
the patch looks like it'll be conflicts galore and a problem to manage
if merged in one big lump.

BR,
Jani.


-- 
Jani Nikula, Intel Open Source Graphics Center
