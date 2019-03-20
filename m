From: Nathan Chancellor <natechancellor@gmail.com>
Subject: Re: Clang warning in drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
Date: Tue, 19 Mar 2019 21:34:40 -0700
Message-ID: <20190320043440.GA23335@archlinux-ryzen>
References: <20190320005406.GA16412@archlinux-ryzen>
 <SN6PR12MB280017BDAB60B61088B221C287410@SN6PR12MB2800.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <SN6PR12MB280017BDAB60B61088B221C287410@SN6PR12MB2800.namprd12.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Pan, Xinhui" <Xinhui.Pan@amd.com>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian" <Christian.Koenig@amd.com>, "Zhou, David(ChunMing)" <David1.Zhou@amd.com>, "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "clang-built-linux@googlegroups.com" <clang-built-linux@googlegroups.com>
List-Id: amd-gfx.lists.freedesktop.org

On Wed, Mar 20, 2019 at 01:31:27AM +0000, Pan, Xinhui wrote:
> these two enumerated types are same for now. both of them might change in the future.
> 
> I have not used clang, but would  .block_id =  (int)head->block fix your warning? If such change is acceptable, I can make one then.
> 
> Thanks
> xinhui
> 
> 
> -----Original Message-----
> From: Nathan Chancellor <natechancellor@gmail.com> 
> Sent: 2019年3月20日 8:54
> To: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian <Christian.Koenig@amd.com>; Zhou, David(ChunMing) <David1.Zhou@amd.com>; Pan, Xinhui <Xinhui.Pan@amd.com>
> Cc: amd-gfx@lists.freedesktop.org; dri-devel@lists.freedesktop.org; linux-kernel@vger.kernel.org; clang-built-linux@googlegroups.com
> Subject: Clang warning in drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> 
> Hi all,
> 
> The introduction of this file in commit dbd249c24427 ("drm/amdgpu: add amdgpu_ras.c to support ras (v2)") introduces the following Clang
> warnings:
> 
> drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c:544:23: warning: implicit conversion from enumeration type 'enum amdgpu_ras_block' to different enumeration type 'enum ta_ras_block' [-Wenum-conversion]
>                         .block_id =  head->block,
>                                      ~~~~~~^~~~~
> drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c:545:24: warning: implicit conversion from enumeration type 'enum amdgpu_ras_error_type' to different enumeration type 'enum ta_ras_error_type' [-Wenum-conversion]
>                         .error_type = head->type,
>                                       ~~~~~~^~~~
> drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c:549:23: warning: implicit conversion from enumeration type 'enum amdgpu_ras_block' to different enumeration type 'enum ta_ras_block' [-Wenum-conversion]
>                         .block_id =  head->block,
>                                      ~~~~~~^~~~~
> drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c:550:24: warning: implicit conversion from enumeration type 'enum amdgpu_ras_error_type' to different enumeration type 'enum ta_ras_error_type' [-Wenum-conversion]
>                         .error_type = head->type,
>                                       ~~~~~~^~~~
> drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c:650:26: warning: implicit conversion from enumeration type 'enum amdgpu_ras_block' to different enumeration type 'enum ta_ras_block' [-Wenum-conversion]
>                 .block_id = info->head.block,
>                             ~~~~~~~~~~~^~~~~
> drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c:651:35: warning: implicit conversion from enumeration type 'enum amdgpu_ras_error_type' to different enumeration type 'enum ta_ras_error_type' [-Wenum-conversion]
>                 .inject_error_type = info->head.type,
>                                      ~~~~~~~~~~~^~~~
> 6 warnings generated.
> 
> Normally, I would sent a fix for this myself but I am not entirely sure why these two enumerated types exist when one would do since they have the same values minus the prefix. In fact, the ta_ras_{block,error_type} values are never used aside from being defined. Some clarification would be appreciated.
> 
> Thank you,
> Nathan

Hi Xinhui,

Yes, explicitly casting these six spots to int would resolve this
warning.

Thank you for the quick response!
Nathan
