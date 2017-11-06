From: Randy Dunlap <rdunlap@infradead.org>
Subject: Re: linux-next: Tree for Nov 6 (amdgpu_virt.c)
Date: Mon, 6 Nov 2017 09:20:33 -0800
Message-ID: <6f48e708-ee6f-641f-d474-4defeab93de4@infradead.org>
References: <20171106183019.46c29b1f@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171106183019.46c29b1f@canb.auug.org.au>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Stephen Rothwell <sfr@canb.auug.org.au>, Linux-Next Mailing List <linux-next@vger.kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, dri-devel <dri-devel@lists.freedesktop.org>, amd-gfx@lists.freedesktop.org
List-Id: amd-gfx.lists.freedesktop.org

On 11/05/2017 11:30 PM, Stephen Rothwell wrote:
> Hi all,
> 
> Changes since 20171103:
> 

on i386, when CONFIG_MODULES is not set:

  CC      drivers/gpu/drm/amd/amdgpu/amdgpu_virt.o
In file included from ../arch/x86/include/asm/atomic.h:5:0,
                 from ../include/linux/atomic.h:5,
                 from ../drivers/gpu/drm/amd/amdgpu/amdgpu.h:31,
                 from ../drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c:24:
../drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c: In function 'amdgpu_virt_init_data_exchange':
../drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c:331:20: error: dereferencing pointer to incomplete type
     if (THIS_MODULE->version != NULL)
                    ^
../include/linux/compiler.h:58:30: note: in definition of macro '__trace_if'
  if (__builtin_constant_p(!!(cond)) ? !!(cond) :   \
                              ^
../drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c:331:5: note: in expansion of macro 'if'
     if (THIS_MODULE->version != NULL)
     ^
../drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c:331:20: error: dereferencing pointer to incomplete type
     if (THIS_MODULE->version != NULL)
                    ^
../include/linux/compiler.h:58:42: note: in definition of macro '__trace_if'
  if (__builtin_constant_p(!!(cond)) ? !!(cond) :   \
                                          ^
../drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c:331:5: note: in expansion of macro 'if'
     if (THIS_MODULE->version != NULL)
     ^
../drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c:331:20: error: dereferencing pointer to incomplete type
     if (THIS_MODULE->version != NULL)
                    ^
../include/linux/compiler.h:69:16: note: in definition of macro '__trace_if'
   ______r = !!(cond);     \
                ^
../drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c:331:5: note: in expansion of macro 'if'
     if (THIS_MODULE->version != NULL)
     ^
../drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c:332:29: error: dereferencing pointer to incomplete type
      strcpy(str, THIS_MODULE->version);
                             ^
../scripts/Makefile.build:314: recipe for target 'drivers/gpu/drm/amd/amdgpu/amdgpu_virt.o' failed
make[5]: *** [drivers/gpu/drm/amd/amdgpu/amdgpu_virt.o] Error 1



Reported-by: Randy Dunlap <rdunlap@infradead.org>

-- 
~Randy
