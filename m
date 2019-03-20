From: Nathan Chancellor <natechancellor@gmail.com>
Subject: Clang warning in drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
Date: Tue, 19 Mar 2019 17:54:06 -0700
Message-ID: <20190320005406.GA16412@archlinux-ryzen>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Alex Deucher <alexander.deucher@amd.com>, Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>, "David (ChunMing) Zhou" <David1.Zhou@amd.com>, xinhui pan <xinhui.pan@amd.com>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com
List-Id: amd-gfx.lists.freedesktop.org

Hi all,

The introduction of this file in commit dbd249c24427 ("drm/amdgpu: add
amdgpu_ras.c to support ras (v2)") introduces the following Clang
warnings:

drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c:544:23: warning: implicit conversion from enumeration type 'enum amdgpu_ras_block' to different enumeration type 'enum ta_ras_block' [-Wenum-conversion]
                        .block_id =  head->block,
                                     ~~~~~~^~~~~
drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c:545:24: warning: implicit conversion from enumeration type 'enum amdgpu_ras_error_type' to different enumeration type 'enum ta_ras_error_type' [-Wenum-conversion]
                        .error_type = head->type,
                                      ~~~~~~^~~~
drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c:549:23: warning: implicit conversion from enumeration type 'enum amdgpu_ras_block' to different enumeration type 'enum ta_ras_block' [-Wenum-conversion]
                        .block_id =  head->block,
                                     ~~~~~~^~~~~
drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c:550:24: warning: implicit conversion from enumeration type 'enum amdgpu_ras_error_type' to different enumeration type 'enum ta_ras_error_type' [-Wenum-conversion]
                        .error_type = head->type,
                                      ~~~~~~^~~~
drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c:650:26: warning: implicit conversion from enumeration type 'enum amdgpu_ras_block' to different enumeration type 'enum ta_ras_block' [-Wenum-conversion]
                .block_id = info->head.block,
                            ~~~~~~~~~~~^~~~~
drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c:651:35: warning: implicit conversion from enumeration type 'enum amdgpu_ras_error_type' to different enumeration type 'enum ta_ras_error_type' [-Wenum-conversion]
                .inject_error_type = info->head.type,
                                     ~~~~~~~~~~~^~~~
6 warnings generated.

Normally, I would sent a fix for this myself but I am not entirely sure
why these two enumerated types exist when one would do since they have
the same values minus the prefix. In fact, the ta_ras_{block,error_type}
values are never used aside from being defined. Some clarification would
be appreciated.

Thank you,
Nathan
