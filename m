From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 2/2] drm/amd/display: Don't build DCN1 when kcov is enabled
Date: Thu, 16 Aug 2018 23:05:51 +0200
Message-ID: <CAK8P3a0Ds9OPqDqpBeY_cbQShTCO9Bkf4uRBtpAz4+8RP2Mwaw@mail.gmail.com>
References: <1534448679-13823-1-git-send-email-sunpeng.li@amd.com> <1534448679-13823-2-git-send-email-sunpeng.li@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1534448679-13823-2-git-send-email-sunpeng.li@amd.com>
Sender: linux-kernel-owner@vger.kernel.org
To: sunpeng.li@amd.com
Cc: Alex Deucher <alexander.deucher@amd.com>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, michel.daenzer@amd.com, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, amd-gfx@lists.freedesktop.org, David Airlie <airlied@linux.ie>, Jordan Lazare <Jordan.Lazare@amd.com>, Harry Wentland <harry.wentland@amd.com>
List-Id: amd-gfx.lists.freedesktop.org

On Thu, Aug 16, 2018 at 9:45 PM <sunpeng.li@amd.com> wrote:
>
> From: "Leo (Sunpeng) Li" <sunpeng.li@amd.com>
>
> DCN1 contains code that utilizes fp math. When
> CONFIG_KCOV_INSTRUMENT_ALL and CONFIG_KCOV_ENABLE_COMPARISONS are
> enabled, build errors are found. See this earlier patch for details:
>
> https://lists.freedesktop.org/archives/dri-devel/2018-August/186131.html
>
> As a short term solution, disable CONFIG_DRM_AMD_DC_DCN1_0 when
> KCOV_INSTRUMENT_ALL and KCOV_ENABLE_COMPARISONS are enabled. In
> addition, make it a fully derived config, taking into account
> CONFIG_X86.
>
> Signed-off-by: Leo (Sunpeng) Li <sunpeng.li@amd.com>

Looks good to me,

Acked-by: Arnd Bergmann <arnd@arndb.de>
