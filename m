From: Randy Dunlap <rdunlap@infradead.org>
Subject: Re: linux-next: Tree for Sep 4 (amd/display/)
Date: Wed, 4 Sep 2019 13:58:24 -0700
Message-ID: <6b70fdfd-1f18-1e55-2574-7be5997cfb2a@infradead.org>
References: <20190904233443.3f73c46b@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190904233443.3f73c46b@canb.auug.org.au>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Stephen Rothwell <sfr@canb.auug.org.au>, Linux Next Mailing List <linux-next@vger.kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, dri-devel <dri-devel@lists.freedesktop.org>, amd-gfx@lists.freedesktop.org, Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>
List-Id: amd-gfx.lists.freedesktop.org

On 9/4/19 6:34 AM, Stephen Rothwell wrote:
> Hi all,
> 
> News: this will be the last linux-next I will release until Sept 30.
> 
> Changes since 20190903:
> 

on x86_64:

In file included from ../drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn20/display_rq_dlg_calc_20v2.c:77:0:
../drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn20/../dml_inline_defs.h: In function ‘dml_min’:
../drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn20/../dml_inline_defs.h:34:1: error: SSE register return with SSE disabled


-- 
~Randy
