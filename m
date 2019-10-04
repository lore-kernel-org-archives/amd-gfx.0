From: Randy Dunlap <rdunlap@infradead.org>
Subject: Re: linux-next: Tree for Oct 4 (amdgpu)
Date: Fri, 4 Oct 2019 07:54:38 -0700
Message-ID: <06969836-ac7f-0d18-1866-159e48018d98@infradead.org>
References: <20191004155929.3ac043b5@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191004155929.3ac043b5@canb.auug.org.au>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Stephen Rothwell <sfr@canb.auug.org.au>, Linux Next Mailing List <linux-next@vger.kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, dri-devel <dri-devel@lists.freedesktop.org>
List-Id: amd-gfx.lists.freedesktop.org

On 10/3/19 10:59 PM, Stephen Rothwell wrote:
> Hi all,
> 
> Changes since 20191003:
> 

on x86_64:
CONFIG_DRM_AMDGPU=y
# CONFIG_DRM_AMDGPU_SI is not set
# CONFIG_DRM_AMDGPU_CIK is not set
CONFIG_DRM_AMDGPU_USERPTR=y
CONFIG_DRM_AMDGPU_GART_DEBUGFS=y

ld: drivers/gpu/drm/amd/amdkfd/kfd_device.o:(.rodata+0xf60): undefined reference to `gfx_v7_kfd2kgd'

-- 
~Randy
